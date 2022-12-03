--- ============================ HEADER ============================
--- ======= LOCALIZE =======
-- Addon
local addonName, addonTable = ...
-- HeroDBC
local DBC = HeroDBC.DBC
-- HeroLib
local HL            = HeroLib
local Cache         = HeroCache
local Unit          = HL.Unit
local Player        = Unit.Player
local Target        = Unit.Target
local Pet           = Unit.Pet
local Spell         = HL.Spell
local Item          = HL.Item
-- HeroRotation
local HR            = HeroRotation
local AoEON         = HR.AoEON
local CDsON         = HR.CDsON
local Cast          = HR.Cast
local CastAnnotated = HR.CastAnnotated
local CastSuggested = HR.CastSuggested

--- ============================ CONTENT ===========================
--- ======= APL LOCALS =======
-- luacheck: max_line_length 9999

-- Define S/I for spell and item arrays
local S = Spell.Evoker.Devastation
local I = Item.Evoker.Devastation

-- Create table to exclude above trinkets from On Use function
local OnUseExcludes = {
  I.CrimsonAspirantsBadgeofFerocity:ID(),
  I.KharnalexTheFirstLight:ID(),
  I.ShadowedOrbofTorment:ID(),
}

-- GUI Settings
local Everyone = HR.Commons.Everyone
local Settings = {
  General = HR.GUISettings.General,
  Commons = HR.GUISettings.APL.Evoker.Commons,
  Devastation = HR.GUISettings.APL.Evoker.Devastation
}

-- Player Covenant
-- 0: none, 1: Kyrian, 2: Venthyr, 3: Night Fae, 4: Necrolord
local CovenantID = Player:CovenantID()

-- Trinket Item Objects
local equip = Player:GetEquipment()
local trinket1 = equip[13] and Item(equip[13]) or Item(0)
local trinket2 = equip[14] and Item(equip[14]) or Item(0)

-- Rotation Var
local Enemies25y
local Enemies8ySplash
local EnemiesCount8ySplash
local MaxEssenceBurstStack = (S.EssenceAttunement:IsAvailable()) and 2 or 1
local VarTrinket1Sync, VarTrinket2Sync, TrinketPriority
local BossFightRemains = 11111
local FightRemains = 11111
local GCDMax

-- Stun Interrupts
local StunInterrupts = {
  {S.TailSwipe, "Cast Tail Swipe (Interrupt)", function() return true; end},
  {S.WingBuffet, "Cast Wing Buffet (Interrupt)", function() return true; end},
}

-- Update Equipment
HL:RegisterForEvent(function()
  equip = Player:GetEquipment()
  trinket1 = equip[13] and Item(equip[13]) or Item(0)
  trinket2 = equip[14] and Item(equip[14]) or Item(0)
end, "PLAYER_EQUIPMENT_CHANGED")

-- Update CovenantID if we change Covenants
HL:RegisterForEvent(function()
  CovenantID = Player:CovenantID()
end, "COVENANT_CHOSEN")

-- Talent change registrations
HL:RegisterForEvent(function()
  MaxEssenceBurstStack = (S.EssenceAttunement:IsAvailable()) and 2 or 1
end, "PLAYER_TALENT_UPDATE")

-- Reset variables after fights
HL:RegisterForEvent(function()
  BossFightRemains = 11111
  FightRemains = 11111
end, "PLAYER_REGEN_ENABLED")

local function num(val)
  if val then return 1 else return 0 end
end

local function bool(val)
  return val ~= 0
end

local function Precombat()
  -- flask
  -- augmentation
  -- food
  -- snapshot_stats
  -- Manually added: Group buff check
  if S.BlessingoftheBronze:IsCastable() and (Player:BuffDown(S.BlessingoftheBronzeBuff) or Everyone.GroupBuffMissing(S.BlessingoftheBronzeBuff)) then
    if Cast(S.BlessingoftheBronze, Settings.Commons.GCDasOffGCD.BlessingOfTheBronze) then return "blessing_of_the_bronze precombat"; end
  end
  -- variable,name=trinket_1_sync,op=setif,value=1,value_else=0.5,condition=trinket.1.has_use_buff&(trinket.1.cooldown.duration%%cooldown.dragonrage.duration=0)
  -- VarTrinket1Sync = (trinket1:TrinketHasUseBuff() and (trinket1:Cooldown() % 120 == 0)) and 1 or 0
  -- variable,name=trinket_2_sync,op=setif,value=1,value_else=0.5,condition=trinket.2.has_use_buff&(trinket.2.cooldown.duration%%cooldown.dragonrage.duration=0)
  -- VarTrinket2Sync = (trinket2:TrinketHasUseBuff() and (trinket2:Cooldown() % 120 == 0)) and 1 or 0
  -- variable,name=trinket_priority,op=setif,value=2,value_else=1,condition=!trinket.1.has_use_buff&trinket.2.has_use_buff|trinket.2.has_use_buff&((trinket.2.cooldown.duration%trinket.2.proc.any_dps.duration)*(1.5+trinket.2.has_buff.intellect)*(variable.trinket_2_sync))>((trinket.1.cooldown.duration%trinket.1.proc.any_dps.duration)*(1.5+trinket.1.has_buff.intellect)*(variable.trinket_1_sync))
  -- TODO: Can't yet handle all of these trinket conditions
  -- use_item,name=shadowed_orb_of_torment
  if Settings.Commons.Enabled.Trinkets and I.ShadowedOrbofTorment:IsEquippedAndReady() then
    if Cast(I.ShadowedOrbofTorment, nil, Settings.Commons.DisplayStyle.Trinkets) then return "shadowed_orb_of_torment precombat"; end
  end
  -- firestorm,if=talent.firestorm
  if S.Firestorm:IsCastable() then
    if Cast(S.Firestorm, nil, nil, not Target:IsInRange(25)) then return "firestorm precombat"; end
  end
  -- living_flame,if=!talent.firestorm
  if S.LivingFlame:IsCastable() and (not S.Firestorm:IsAvailable()) then
    if Cast(S.LivingFlame, nil, nil, not Target:IsInRange(25)) then return "living_flame precombat"; end
  end
end

local function Defensives()
  if S.ObsidianScales:IsCastable() and Player:BuffDown(S.ObsidianScales) and (Player:HealthPercentage() < Settings.Devastation.ObsidianScalesThreshold) then
    if Cast(S.ObsidianScales, nil, Settings.Commons.DisplayStyle.Defensives) then return "obsidian_scales defensives"; end
  end
end

local function Trinkets()
  -- use_item,slot=trinket1,if=buff.dragonrage.up&(!trinket.2.has_cooldown|trinket.2.cooldown.remains|variable.trinket_priority=1)|trinket.1.proc.any_dps.duration>=fight_remains
  -- use_item,slot=trinket2,if=buff.dragonrage.up&(!trinket.1.has_cooldown|trinket.1.cooldown.remains|variable.trinket_priority=2)|trinket.2.proc.any_dps.duration>=fight_remains
  -- use_item,slot=trinket1,if=(!trinket.1.has_use_buff&(trinket.2.cooldown.remains|!trinket.2.has_use_buff)|cooldown.dragonrage.remains>20|!talent.dragonrage)
  -- use_item,slot=trinket2,if=(!trinket.2.has_use_buff&(trinket.1.cooldown.remains|!trinket.1.has_use_buff)|cooldown.dragonrage.remains>20|!talent.dragonrage)
  -- Note: Can't handle above trinket tracking, so let's use the old fallback. When we can do above tracking, the below can be removed.
  -- use_items,if=buff.dragonrage.up
  if Player:BuffUp(S.Dragonrage) then
    local TrinketToUse = Player:GetUseableTrinkets(OnUseExcludes)
    if TrinketToUse then
      if Cast(TrinketToUse, nil, Settings.Commons.DisplayStyle.Trinkets) then return "Generic use_items for " .. TrinketToUse:Name(); end
    end
  end
end

-- APL Main
local function APL()
  Enemies25y = Player:GetEnemiesInRange(25)
  Enemies8ySplash = Target:GetEnemiesInSplashRange(8)
  if (AoEON()) then
    EnemiesCount8ySplash = #Enemies8ySplash
  else
    EnemiesCount8ySplash = 1
  end

  if Everyone.TargetIsValid() or Player:AffectingCombat() then
    -- Calculate fight_remains
    BossFightRemains = HL.BossFightRemains(nil, true)
    FightRemains = BossFightRemains
    if FightRemains == 11111 then
      FightRemains = HL.FightRemains(Enemies25y, false)
    end
  end

  -- Set GCDMax (add 0.25 seconds for latency/player reaction)
  GCDMax = Player:GCD() + 0.25
  Enemies20y = Player:GetEnemiesInRange(20)
 
  if HR.QueuedSpell():IsReadyQueue() then
    if Cast(HR.QueuedSpell()) then return "Queue Spell Sent"; end
  end

	if not HR.queuedSpell[1]:CooldownUp() or #Enemies20y==0 or not Player:AffectingCombat() then
		HR.queuedSpell = { HR.Spell[1].Empty, 0 }
	end

  if (Player:IsCasting() or Player:IsChanneling()) then return HR.Cast(S.channeling) end

  if Everyone.TargetIsValid() then
    -- Precombat
    if not Player:AffectingCombat() and not Player:IsCasting() then
      local ShouldReturn = Precombat(); if ShouldReturn then return ShouldReturn; end
    end
    -- Defensives
    if Player:AffectingCombat() and Settings.Devastation.UseDefensives then
      local ShouldReturn = Defensives(); if ShouldReturn then return ShouldReturn; end
    end
    -- Manually added: Interrupts
    local ShouldReturn = Everyone.Interrupt(10, S.Quell, Settings.Commons.OffGCDasOffGCD.Quell, StunInterrupts); if ShouldReturn then return ShouldReturn; end
    -- Manually added: boon_of_the_covenants,if=buff.dragonrage.up
    -- TODO: Remove this when Dragonflight launches
    if S.BoonoftheCovenants:IsReady() and (Player:BuffUp(S.Dragonrage)) then
      if Cast(S.BoonoftheCovenants, nil, Settings.Commons.DisplayStyle.Signature) then return "boon_of_the_covenants main 1"; end
    end
    -- potion,if=buff.dragonrage.up|time>=300&fight_remains<35
    if Settings.Commons.Enabled.Potions and (Player:BuffUp(S.Dragonrage) or HL.CombatTime() >= 300 or FightRemains < 35) then
      local PotionSelected = Everyone.PotionSelected()
      if PotionSelected and PotionSelected:IsReady() then
        if Cast(PotionSelected, nil, Settings.Commons.DisplayStyle.Potions) then return "potion main 2"; end
      end
    end
    if Settings.Commons.Enabled.Trinkets then
      -- use_item,name=shadowed_orb_of_torment
      if I.ShadowedOrbofTorment:IsEquippedAndReady() then
        if Cast(I.ShadowedOrbofTorment, nil, Settings.Commons.DisplayStyle.Trinkets) then return "shadowed_orb_of_torment main 4"; end
      end
      -- use_item,name=crimson_aspirants_badge_of_ferocity,if=cooldown.dragonrage.remains>=55
      if I.CrimsonAspirantsBadgeofFerocity:IsEquippedAndReady() and (S.Dragonrage:CooldownRemains() >= 55) then
        if Cast(S.CrimsonAspirantsBadgeofFerocity, nil, Settings.Commons.DisplayStyle.Trinkets) then return "crimson_aspirants_badge_of_ferocity main 6"; end
      end
      -- call_action_list,name=trinkets
      local ShouldReturn = Trinkets(); if ShouldReturn then return ShouldReturn; end
    end
    -- deep_breath,if=spell_targets.deep_breath>1&buff.dragonrage.down
    if S.DeepBreath:IsCastable() and (EnemiesCount8ySplash > 1 and Player:BuffDown(S.Dragonrage)) then
      if Cast(S.DeepBreath, Settings.Devastation.GCDasOffGCD.DeepBreath, nil, not Target:IsInRange(50)) then return "deep_breath main 8"; end
    end
    -- dragonrage,if=cooldown.eternity_surge.remains<=(buff.dragonrage.duration+6)&(cooldown.fire_breath.remains<=2*gcd.max|!talent.feed_the_flames)
    if S.Dragonrage:IsCastable() and (S.EternitySurge:CooldownRemains() <= (S.Dragonrage:BaseDuration() + 6) and (S.FireBreath:CooldownRemains() <= 2 * GCDMax or not S.FeedtheFlames:IsAvailable())) then
      if Cast(S.Dragonrage, Settings.Devastation.GCDasOffGCD.Dragonrage, nil, not Target:IsInRange(25)) then return "dragonrage main 10"; end
    end
    -- tip_the_scales,if=buff.dragonrage.up&(cooldown.eternity_surge.up|cooldown.fire_breath.up)&buff.dragonrage.remains<=gcd.max
    if S.TipTheScales:IsCastable() and (Player:BuffUp(S.Dragonrage) and (S.EternitySurge:CooldownUp() or S.FireBreath:CooldownUp()) and Player:BuffRemains(S.Dragonrage) <= GCDMax) then
      if Cast(S.TipTheScales, Settings.Devastation.GCDasOffGCD.TipTheScales) then return "tip_the_scales main 12"; end
    end
    -- eternity_surge,empower_to=1,if=buff.dragonrage.up&(buff.bloodlust.up|buff.power_infusion.up)&talent.feed_the_flames
    if S.EternitySurge:IsCastable() and (Player:BuffUp(S.Dragonrage) and (Player:BloodlustUp() or Player:BuffUp(S.PowerInfusionBuff)) and S.FeedtheFlames:IsAvailable()) then
      if CastAnnotated(S.EternitySurge, false, "1") then return "eternity_surge empower 1 main 14"; end
    end
    -- tip_the_scales,if=buff.dragonrage.up&cooldown.fire_breath.up&talent.everburning_flame&talent.firestorm
    if S.TipTheScales:IsCastable() and (Player:BuffUp(S.Dragonrage) and S.FireBreath:CooldownUp() and S.EverburningFlame:IsAvailable() and S.Firestorm:IsAvailable()) then
      if Cast(S.TipTheScales, Settings.Devastation.GCDasOffGCD.TipTheScales) then return "tip_the_scales main 16"; end
    end
    -- fire_breath,empower_to=1,if=talent.everburning_flame&(cooldown.firestorm.remains>=2*gcd.max|!dot.firestorm.ticking)|cooldown.dragonrage.remains>=10&talent.feed_the_flames|!talent.everburning_flame&!talent.feed_the_flames
    -- TODO: Find a way to track Firestorm. It does not have a DoT on the target.
    if S.FireBreath:IsCastable() and (S.EverburningFlame:IsAvailable() and (S.Firestorm:CooldownRemains() >= 2 * GCDMax or S.Firestorm:TimeSinceLastCast() >= 12) or S.Dragonrage:CooldownRemains() >= 10 and S.FeedtheFlames:IsAvailable() or (not S.EverburningFlame:IsAvailable()) and not S.FeedtheFlames:IsAvailable()) then
      if CastAnnotated(S.FireBreath, false, "1") then return "fire_breath main 18"; end
    end
    -- fire_breath,empower_to=2,if=talent.everburning_flame
    if S.FireBreath:IsCastable() and (S.EverburningFlame:IsAvailable()) then
      if CastAnnotated(S.FireBreath, false, "2") then return "fire_breath main 20"; end
    end
    -- firestorm,if=talent.everburning_flame&(cooldown.fire_breath.up|dot.fire_breath_damage.remains>=cast_time&dot.fire_breath_damage.remains<cooldown.fire_breath.remains)|buff.snapfire.up|spell_targets.firestorm>1
    if S.Firestorm:IsCastable() and (S.EverburningFlame:IsAvailable() and (S.FireBreath:CooldownUp() or Target:DebuffRemains(S.FireBreathDebuff) >= S.Firestorm:CastTime() and Target:DebuffRemains(S.FireBreathDebuff) < S.FireBreath:CooldownRemains()) or Player:BuffUp(S.SnapfireBuff) or EnemiesCount8ySplash > 1) then
      if Cast(S.Firestorm, nil, nil, not Target:IsInRange(25)) then return "firestorm main 22"; end
    end
    -- eternity_surge,empower_to=4,if=spell_targets.pyre>3*(1+talent.eternitys_span)
    -- eternity_surge,empower_to=3,if=spell_targets.pyre>2*(1+talent.eternitys_span)
    -- eternity_surge,empower_to=2,if=spell_targets.pyre>(1+talent.eternitys_span)
    -- eternity_surge,empower_to=1,if=(cooldown.eternity_surge.duration-cooldown.dragonrage.remains)<(buff.dragonrage.duration+6-gcd.max)
    if S.EternitySurge:IsReady() then
      local ESEmpower = 1
      if EnemiesCount8ySplash > 3 * (1 + num(S.EternitysSpan:IsAvailable())) then
        ESEmpower = 4
      elseif EnemiesCount8ySplash > 2 * (1 + num(S.EternitysSpan:IsAvailable())) then
        ESEmpower = 3
      elseif EnemiesCount8ySplash > (1 + num(S.EternitysSpan:IsAvailable())) then
        ESEmpower = 2
      end
      if ESEmpower > 1 then
        if CastAnnotated(S.EternitySurge, false, ESEmpower) then return "eternity_surge main 24"; end
      elseif (30 - S.Dragonrage:CooldownRemains()) < (S.Dragonrage:BaseDuration() + 6 - GCDMax) then
        if CastAnnotated(S.EternitySurge, false, ESEmpower) then return "eternity_surge empower 1 main 24"; end
      end
    end
    -- shattering_star,if=!talent.arcane_vigor|essence+1<essence.max|buff.dragonrage.up
    if S.ShatteringStar:IsCastable() and ((not S.ArcaneVigor:IsAvailable()) or Player:Essence() + 1 < Player:EssenceMax() or Player:BuffUp(S.Dragonrage)) then
      if Cast(S.ShatteringStar, nil, nil, not Target:IsInRange(25)) then return "shattering_star main 26"; end
    end
    -- azure_strike,if=essence<essence.max&!buff.burnout.up&spell_targets.azure_strike>(2-buff.dragonrage.up)&buff.essence_burst.stack<buff.essence_burst.max_stack&(!talent.ruby_embers|spell_targets.azure_strike>2)
    if S.AzureStrike:IsCastable() and (Player:Essence() < Player:EssenceMax() and EnemiesCount8ySplash > (2 - num(Player:BuffUp(S.Dragonrage))) and Player:BuffStack(S.EssenceBurstBuff) < MaxEssenceBurstStack and ((not S.RubyEmbers:IsAvailable()) or EnemiesCount8ySplash > 2)) then
      if Cast(S.AzureStrike, nil, nil, not Target:IsInRange(25)) then return "azure_strike main 28"; end
    end
    -- pyre,if=spell_targets.pyre>(2+talent.scintillation*talent.eternitys_span)|buff.charged_blast.stack=buff.charged_blast.max_stack&cooldown.dragonrage.remains>20&spell_targets.pyre>2
    if S.Pyre:IsReady() and (EnemiesCount8ySplash > (2 + num(S.Scintillation:IsAvailable()) * num(S.EternitysSpan:IsAvailable())) or Player:BuffStack(S.ChargedBlastBuff) == 20 and S.Dragonrage:CooldownRemains() > 20 and EnemiesCount8ySplash > 2) then
      if Cast(S.Pyre, nil, nil, not Target:IsInRange(25)) then return "pyre main 30"; end
    end
    -- living_flame,if=essence<essence.max&buff.essence_burst.stack<buff.essence_burst.max_stack&(buff.burnout.up|!talent.engulfing_blaze&!talent.shattering_star&buff.dragonrage.up&target.health.pct>80)
    if S.LivingFlame:IsCastable() and (not Player:IsCasting(S.LivingFlame)) and (Player:Essence() < Player:EssenceMax() and Player:BuffStack(S.EssenceBurstBuff) < MaxEssenceBurstStack and (Player:BuffUp(S.BurnoutBuff) or (not S.EngulfingBlaze:IsAvailable()) and (not S.ShatteringStar:IsAvailable()) and Player:BuffUp(S.Dragonrage) and Target:HealthPercentage() > 80)) then
      if Cast(S.LivingFlame, nil, nil, not Target:IsInRange(25)) then return "living_flame main 32"; end
    end
    -- disintegrate,chain=1,if=buff.dragonrage.up,interrupt_if=buff.dragonrage.up&ticks>=2,interrupt_immediate=1
    if S.Disintegrate:IsReady() and (Player:BuffUp(S.Dragonrage)) then
      if Cast(S.Disintegrate, nil, nil, not Target:IsInRange(25)) then return "disintegrate main 28"; end
    end
    -- disintegrate,chain=1,if=essence=essence.max|buff.essence_burst.stack=buff.essence_burst.max_stack|debuff.shattering_star_debuff.up|cooldown.shattering_star.remains>=3*gcd.max|!talent.shattering_star
    if S.Disintegrate:IsReady() and (Player:Essence() == Player:EssenceMax() or Player:BuffStack(S.EssenceBurstBuff) == MaxEssenceBurstStack or Target:DebuffUp(S.ShatteringStar) or S.ShatteringStar:CooldownRemains() >= 3 * GCDMax or not S.ShatteringStar:IsAvailable()) then
      if Cast(S.Disintegrate, nil, nil, not Target:IsInRange(25)) then return "disintegrate main 30"; end
    end
    -- use_item,name=kharnalex_the_first_light,if=!debuff.shattering_star_debuff.up&!buff.dragonrage.up&spell_targets.pyre=1
    if Settings.Commons.Enabled.Items and I.KharnalexTheFirstLight:IsEquippedAndReady() and (Target:DebuffDown(S.ShatteringStar) and Player:BuffDown(S.Dragonrage) and EnemiesCount8ySplash == 1) then
      if Cast(I.KharnalexTheFirstLight, nil, Settings.Commons.DisplayStyle.Items, not Target:IsInRange(25)) then return "kharnalex_the_first_light main 32"; end
    end
    -- azure_strike,if=spell_targets.azure_strike>2|(talent.engulfing_blaze|talent.feed_the_flames)&buff.dragonrage.up
    if S.AzureStrike:IsCastable() and (EnemiesCount8ySplash > 2 or (S.EngulfingBlaze:IsAvailable() or S.FeedtheFlames:IsAvailable()) and Player:BuffUp(S.Dragonrage)) then
      if Cast(S.AzureStrike, nil, nil, not Target:IsSpellInRange(S.AzureStrike)) then return "azure_strike main 32"; end
    end
    -- living_flame
    if S.LivingFlame:IsCastable() then
      if Cast(S.LivingFlame, nil, nil, not Target:IsInRange(25)) then return "living_flame main 34"; end
    end
    -- If nothing else to do, show the Pool icon
    if CastAnnotated(S.Pool, false, "WAIT") then return "Wait/Pool Resources"; end
  end


  if  Player:IsMounted() then return HR.Cast(S.mounted)
  elseif Player:AffectingCombat() then
    return HR.Cast(S.combat)
  else
return HR.Cast(S.MPI)
  end
end

local function Init()
  --HR.Print("Devastation Evoker rotation is currently a work in progress, but has been updated for patch 10.0.2.")
end

HR.SetAPL(1467, APL, Init);
