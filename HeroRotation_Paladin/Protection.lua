--- ============================ HEADER ============================
--- ======= LOCALIZE =======
-- Addon
local addonName, addonTable = ...
-- HeroDBC
local DBC = HeroDBC.DBC
-- HeroLib
local HL         = HeroLib
local Cache      = HeroCache
local Unit       = HL.Unit
local Player     = Unit.Player
local Target     = Unit.Target
local Pet        = Unit.Pet
local Spell      = HL.Spell
local Item       = HL.Item
-- HeroRotation
local HR         = HeroRotation
local AoEON      = HR.AoEON
local CDsON      = HR.CDsON
local Cast       = HR.Cast

--- ============================ CONTENT ===========================
--- ======= APL LOCALS =======
-- luacheck: max_line_length 9999

-- Define S/I for spell and item arrays
local S = Spell.Paladin.Protection
local I = Item.Paladin.Protection

-- Create table to exclude above trinkets from On Use function
local OnUseExcludes = {
}

-- Interrupts List
local StunInterrupts = {
  {S.HammerofJustice, "Cast Hammer of Justice (Interrupt)", function () return true; end},
}

-- Rotation Var
local ActiveMitigationNeeded
local IsTanking
local Enemies8y, Enemies30y
local EnemiesCount8y, EnemiesCount30y

-- GUI Settings
local Everyone = HR.Commons.Everyone
local Settings = {
  General = HR.GUISettings.General,
  Commons = HR.GUISettings.APL.Paladin.Commons,
  Protection = HR.GUISettings.APL.Paladin.Protection
}

-- Player Covenant
-- 0: none, 1: Kyrian, 2: Venthyr, 3: Night Fae, 4: Necrolord
local CovenantID = Player:CovenantID()

-- Update CovenantID if we change Covenants
HL:RegisterForEvent(function()
  CovenantID = Player:CovenantID()
end, "COVENANT_CHOSEN")

local function EvaluateCycleJudgment200(TargetUnit)
  return TargetUnit:DebuffRefreshable(S.JudgmentDebuff)
end

local function EvaluateCycleHammerofWrath(TargetUnit)
  return TargetUnit:HealthPercentage() < 20 or Player:BuffUp(S.AvengingWrathBuff)
end

local function HandleNightFaeBlessings()
  local Seasons = {S.BlessingofSpring, S.BlessingofSummer, S.BlessingofAutumn, S.BlessingofWinter}
  for _, i in pairs(Seasons) do
    if i:IsReady() then
      if Cast(i, nil, Settings.Commons.DisplayStyle.Signature) then return "blessing_of_the_seasons"; end
    end
  end
end

local function Precombat()
  -- flask
  -- food
  -- augmentation
  -- devotion_aura
  if S.DevotionAura:IsCastable() and (Player:BuffDown(S.DevotionAura)) then
    if Cast(S.DevotionAura) then return "devotion_aura precombat 2"; end
  end
  -- snapshot_stats
  -- potion
  -- Manually removed, as this is no longer needed in Precombat
  -- consecration
  if S.Consecration:IsCastable() and consecrationactivate then
    if Cast(S.Consecration) then return "consecration precombat 4"; end
  end
  -- lights_judgment
  -- if S.LightsJudgment:IsCastable() then
  --   if Cast(S.LightsJudgment, nil, nil, not Target:IsSpellInRange(S.LightsJudgment)) then return "lights_judgment precombat 6"; end
  -- end

  -- Manually added: avengers_shield
  if S.AvengersShield:IsCastable() and Target:IsInRange(30) then
    if Cast(S.AvengersShield) then return "avengers_shield"; end
  end
  -- Manually added: judgment
  if S.Judgment:IsReady() and Target:IsInRange(30) then
    if Cast(S.Judgment) then return "judgment"; end
  end
end

local function Defensives()
  if Player:HealthPercentage() <= Settings.Protection.LoHHP and S.LayonHands:IsCastable() then
    if Cast(S.LayonHands, nil, Settings.Protection.DisplayStyle.Defensives) then return "lay_on_hands defensive 2"; end
  end

  if S.GuardianofAncientKings:IsCastable() and (Player:NeedPanicHealing() or Player:HealthPercentage()<40) and Player:BuffDown(S.DivineShield) and (Player:BuffDown(S.ArdentDefenderBuff)) then
    if Cast(S.GuardianofAncientKings, nil, Settings.Protection.DisplayStyle.Defensives) then return "guardian_of_ancient_kings defensive"; end
  end
  if S.ArdentDefender:IsCastable() and (Player:NeedMajorHealing() or Player:HealthPercentage()<50) and Player:BuffDown(S.DivineShield) and Player:BuffDown(S.GuardianofAncientKingsBuff) and Player:BuffDown(S.ArdentDefenderBuff) then
    if Cast(S.ArdentDefender, nil, Settings.Protection.DisplayStyle.Defensives) then return "ardent_defender defensive"; end
  end
  if S.EyeofTyr:IsCastable() and (Player:NeedMajorHealing() or Player:HealthPercentage()<85) and (#Enemies8y>= 1 or Target:IsInRange(8)) and Player:BuffDown(S.DivineShield) and Player:BuffDown(S.GuardianofAncientKingsBuff) then
    if Cast(S.eyeoftyr, nil, Settings.Protection.DisplayStyle.Defensives) then return "eye of tyr defensive"; end
  end

  if S.DivineShield:IsCastable() and (Player:NeedPanicHealing() or Player:HealthPercentage()<20) and Player:BuffDown(S.ArdentDefenderBuff) and Player:BuffDown(S.GuardianofAncientKingsBuff) and S.GuardianofAncientKings:CooldownRemains()>Player:GCD() and S.ArdentDefender:CooldownRemains()>Player:GCD() and S.LayonHands:CooldownRemains()>Player:GCD() then
    if Cast(S.DivineShield, nil, Settings.Protection.DisplayStyle.Defensives) then return "divine shield defensive"; end
  end

  -- cast word of glory on us if it's a) free or b) probably not going to drop sotr
  if S.WordofGlory:IsReady() and (Player:HealthPercentage() <= Settings.Protection.WordofGloryHP and not Player:HealingAbsorbed()) then
    if (Player:BuffRemains(S.ShieldoftheRighteousBuff) >= 5 
       or Player:BuffUp(S.DivinePurposeBuff) 
       or Player:BuffUp(S.ShiningLightFreeBuff)) then
      if Cast(S.WordofGlory) then return "word_of_glory defensive 8"; end
    else
      -- cast it anyway but run the fuck away
      if HR.CastAnnotated(S.WordofGlory, false, "KITE") then return "word_of_glory defensive 10"; end
    end
  end

  if S.ShieldoftheRighteous:IsReady() and Target:IsInRange(5) and (Player:BuffRefreshable(S.ShieldoftheRighteousBuff) and (ActiveMitigationNeeded or Player:HealthPercentage() <= Settings.Protection.ShieldoftheRighteousHP)) then
    if Cast(S.ShieldoftheRighteous) then return "shield_of_the_righteous defensive 12"; end
  end
end

local function Cooldowns()
  -- fireblood,if=buff.avenging_wrath.up
  -- if S.Fireblood:IsCastable() and (Player:BuffUp(S.AvengingWrathBuff)) then
  --   if Cast(S.Fireblood, Settings.Commons.OffGCDasOffGCD.Racials) then return "fireblood cooldowns 2"; end
  -- end

  if S.Consecration:IsCastable() and Player:BuffDown(S.ConsecrationBuff) and Target:IsInRange(8) and #Enemies8y>1 then
    if Cast(S.Consecration) then return "consecration standard 18"; end
  end

  -- seraphim
  if S.Seraphim:IsReady() and Target:IsInRange(8) then
    if Cast(S.Seraphim) then return "seraphim"; end
  end

  -- sanctified wrath
  -- if S.SanctifiedWrath:IsCastable() and Target:IsInRange(8) then
  --   if Cast(S.SanctifiedWrath) then return "avenging_wrath cooldowns 6"; end
  -- end

  -- avenging_wrath
  if S.AvengingWrath:IsCastable() and Target:IsInRange(8) then
    if Cast(S.AvengingWrath) then return "avenging_wrath cooldowns 6"; end
  end
  -- holy_avenger,if=buff.avenging_wrath.up|cooldown.avenging_wrath.remains>60
  if S.HolyAvenger:IsCastable() and (Player:BuffUp(S.AvengingWrathBuff) or S.AvengingWrath:CooldownRemains() > 60) then
    if Cast(S.HolyAvenger) then return "holy_avenger cooldowns 8"; end
  end
  -- potion,if=buff.avenging_wrath.up
  if Settings.Commons.Enabled.Potions and (Player:BuffUp(S.AvengingWrathBuff)) then
    local PotionSelected = Everyone.PotionSelected()
    if PotionSelected and PotionSelected:IsReady() then
      if Cast(PotionSelected, nil, Settings.Commons.DisplayStyle.Potions) then return "potion cooldowns 10"; end
    end
  end
  -- use_items,if=buff.seraphim.up|!talent.seraphim.enabled
  if (Player:BuffUp(S.SeraphimBuff) or not S.Seraphim:IsAvailable()) then
    -- local TrinketToUse = Player:GetUseableTrinkets(OnUseExcludes)
    -- if TrinketToUse then
    --   if Cast(TrinketToUse, nil, Settings.Commons.DisplayStyle.Trinkets) then return "Generic use_items for " .. TrinketToUse:Name(); end
    -- end
  end
  -- moment_of_glory,if=prev_gcd.1.avengers_shield&cooldown.avengers_shield.remains
  if S.MomentofGlory:IsCastable() and (Player:PrevGCD(1, S.AvengersShield) and not S.AvengersShield:CooldownUp()) and (#Enemies30y>1 or Player:HealthPercentage()<50) and Target:IsInRange(10) then
    if Cast(S.MomentofGlory, Settings.Protection.OffGCDasOffGCD.MomentOfGlory) then return "moment_of_glory cooldowns 12"; end
  end
end

local function Standard()
  if I.AnodizedDeflectors:IsEquippedAndReady() and Target:IsInRange(8) then
    if Cast(S.wristsx) then return "anodized_deflectors cooldowns 16"; end
  end
  -- shield_of_the_righteous,if=debuff.judgment.up
  if S.ShieldoftheRighteous:IsReady() and (Target:DebuffUp(S.JudgmentDebuff)) and Target:IsInRange(5) then
    if Cast(S.ShieldoftheRighteous) then return "shield_of_the_righteous standard 2"; end
  end
  -- shield_of_the_righteous,if=holy_power=5|buff.holy_avenger.up|holy_power=4&talent.sanctified_wrath.enabled&buff.avenging_wrath.up
  if S.ShieldoftheRighteous:IsReady() and Target:IsInRange(5) and (Player:HolyPower() == 5 or Player:BuffUp(S.HolyAvengerBuff) or Player:HolyPower() == 4 and S.SanctifiedWrath:IsAvailable() and Player:BuffUp(S.AvengingWrathBuff)) then
    if Cast(S.ShieldoftheRighteous) then return "shield_of_the_righteous standard 4"; end
  end

  -- NOTE(MRDMND) - added an AOE prio on this over judgment
  if S.AvengersShield:IsCastable() and #Enemies10y >= 3 and Target:IsInRange(30)  then
    if Cast(S.AvengersShield) then return "avengers_shield standard 6"; end
  end
  if S.Consecration:IsCastable() and Player:BuffDown(S.ConsecrationBuff) and consecrationactivate then
    if Cast(S.Consecration) then return "consecration standard 18"; end
  end

  -- judgment,target_if=min:debuff.judgment.remains,if=charges=2|!talent.crusaders_judgment.enabled
  if S.Judgment:IsReady() and (S.Judgment:Charges() == 2 or not S.CrusadersJudgment:IsAvailable()) and Target:IsInRange(30) then
    if Cast(S.Judgment) then return "judgment"; end
  end
  -- hammer_of_wrath
  if S.HammerofWrath:IsReady() and Target:IsInRange(30)  then
    if Cast(S.HammerofWrath) then return "hammer_of_wrath standard 10"; end
  end
  -- blessing_of_the_seasons
  -- avengers_shield
  if S.AvengersShield:IsCastable() and Target:IsInRange(30)  then
    if Cast(S.AvengersShield) then return "avengers_shield standard 12"; end
  end
  -- judgment,target_if=min:debuff.judgment.remains
  if S.Judgment:IsReady() and Target:IsInRange(30) and not Target:DebuffUp(S.JudgmentDebuff) then
    if Cast(S.Judgment) then return "judgment"; end
  end
  -- vanquishers_hammer
  if S.VanquishersHammer:IsReady() and Target:IsInRange(30) then
    if Cast(S.VanquishersHammer) then return "vanquishers_hammer"; end
  end
  -- consecration,if=!consecration.up
  -- if S.Consecration:IsCastable() and Player:BuffDown(S.ConsecrationBuff) and consecrationactivate then
  --   if Cast(S.Consecration) then return "consecration standard 18"; end
  -- end
  -- divine_toll
  if S.DivineToll:IsCastable() and Target:IsInRange(30) and CDsON() then
    if Cast(S.DivineToll) then return "divine_toll"; end
  end

  -- blessed_hammer,strikes=2.4,if=charges=3
  if S.BlessedHammer:IsCastable() and (S.BlessedHammer:Charges() == 3) and (Target:IsInRange(10) or #Enemies10y>=1) then
    if Cast(S.BlessedHammer) then return "blessed_hammer standard 20"; end
  end

  -- hammer_of_the_righteous,if=charges=2
  if S.HammeroftheRighteous:IsCastable() and (S.HammeroftheRighteous:Charges() == 2) and (Target:IsInRange(10) or #Enemies10y>=1)  then
    if Cast(S.HammeroftheRighteous) then return "hammer_of_the_righteous standard 24"; end
  end
  -- word_of_glory,if=buff.vanquishers_hammer.up
  if S.WordofGlory:IsReady() and (Player:BuffUp(S.VanquishersHammerBuff)) then
    if Cast(S.WordofGlory) then return "word_of_glory standard 26"; end
  end
  -- blessed_hammer,strikes=2.4
  if S.BlessedHammer:IsCastable() and (Target:IsInRange(10) or #Enemies10y>=1)  then
    if Cast(S.BlessedHammer) then return "blessed_hammer"; end
  end
  -- hammer_of_the_righteous
  if S.HammeroftheRighteous:IsCastable() and (Target:IsInRange(10) or #Enemies10y>=1) then
    if Cast(S.HammeroftheRighteous) then return "hammer_of_the_righteous standard 30"; end
  end
  -- lights_judgment
  -- if S.LightsJudgment:IsCastable() then
  --   if Cast(S.LightsJudgment, Settings.Commons.OffGCDasOffGCD.Racials, nil, not Target:IsSpellInRange(S.LightsJudgment)) then return "lights_judgment standard 32"; end
  -- end
  -- arcane_torrent
  -- if S.ArcaneTorrent:IsCastable() then
  --   if Cast(S.ArcaneTorrent, Settings.Commons.OffGCDasOffGCD.Racials, nil, not Target:IsInRange(8)) then return "arcane_torrent standard 34"; end
  -- end
  -- consecration
  if S.Consecration:IsCastable() and consecrationactivate then
    if Cast(S.Consecration) then return "consecration"; end
  end
  -- word_of_glory,if=buff.shining_light_free.up&!covenant.necrolord
  -- TODO: this should not fire if everyone in your party is full HP, but we DO want to heal teammates if we're topped at this point
  if S.WordofGlory:IsReady() and (Player:BuffUp(S.ShiningLightFreeBuff) and (Player:HealthPercentage()<90 or Player:BuffRemains(S.ShiningLightFreeBuff)<Player:GCD())) then
    if Cast(S.WordofGlory) then return "word_of_glory"; end
  end
  
end

-- APL Main
local function APL()

  -- if not Target:Exists() then 
  --   return 0,"Interface\\Addons\\HeroRotation\\Textures\\999955.blp"
  --   end
  
  Enemies8y = Player:GetEnemiesInMeleeRange(8)
  Enemies10y = Player:GetEnemiesInMeleeRange(10)

  Enemies30y = Player:GetEnemiesInRange(30)
  Enemies12y = Player:GetEnemiesInRange(12)
  Enemies15y = Player:GetEnemiesInRange(15)
  if (AoEON()) then
    EnemiesCount8y = #Enemies8y
    EnemiesCount30y = #Enemies30y
  else
    EnemiesCount8y = 1
    EnemiesCount30y = 1
  end
  consecrationactivate = (Target:IsInRange(5) 
  and Player:IsMoving() 
  or Target:IsInRange(8) 
  and Player:MovingFor()<Player:GCD() 
  or #Enemies8y>1)

  ActiveMitigationNeeded = Player:ActiveMitigationNeeded()
  IsTanking = Player:IsTankingAoE(8) or Player:IsTanking(Target)


  if (Player:IsCasting() or Player:IsChanneling()) then return HR.Cast(S.channeling) end






  if Player:HealthPercentage() < 40 and Player:AffectingCombat() and IsUsableItem(187802) and GetItemCooldown(187802) == 0 and GetItemCount(187802) >= 1 
then
    if Cast(I.potion) then return "potion drank"; end
  end

  if not Player:BuffUp(S.DevotionAura) then 
    if Cast(S.DevotionAura) then return ""; end
    end

if S.Intercession:ID() ==  HR.queuedSpell[1]:ID() and S.Intercession:IsReady() and UnitExists("mouseover") then
  if Cast(S.Intercessionz) then return "q sent"; end
  end

if S.Intercession:ID() ==  HR.queuedSpell[1]:ID() and (not S.Intercession:CooldownUp() or not UnitExists("mouseover") or not UnitIsDeadOrGhost("mouseover") or Player:HolyPower()<3) then
  HR.queuedSpell = { HR.Spell[1].Empty, 0 }
end	

if S.lustAT:ID() ==  HR.queuedSpell[1]:ID() and not Player:Debuff(S.lust1) and not Player:Debuff(S.lust2) and not Player:Debuff(S.lust3) and not Player:Debuff(S.lust4) and not Player:Debuff(S.lust5) and (I.drums:IsReady()) then
  if Cast(S.lustAT) then return "q sent"; end
  end

if S.lustAT:ID() ==  HR.queuedSpell[1]:ID() and (Player:Debuff(S.lust1) or Player:Debuff(S.lust2) or Player:Debuff(S.lust3) or Player:Debuff(S.lust4) or Player:Debuff(S.lust5)) then
  HR.queuedSpell = { HR.Spell[1].Empty, 0 }
end

  -- if I.raven:IsEquippedAndReady() and Target:IsInRange(8) and CDsON() then
  --   if Cast(S.trinket) then return "trinket"; end
  -- end
 
   if  S.FlashofLight:ID() ==  HR.queuedSpell[1]:ID() and Player:IsMoving() then
      HR.queuedSpell = { HR.Spell[1].Empty, 0 }
end


   if  S.DivineShield:ID() ==  HR.queuedSpell[1]:ID() and Player:DebuffUp(S.Forbearance) then
      HR.queuedSpell = { HR.Spell[1].Empty, 0 }
end
   if  S.BlessingofProtection:ID() ==  HR.queuedSpell[1]:ID() and Player:DebuffUp(S.Forbearance) then
      HR.queuedSpell = { HR.Spell[1].Empty, 0 }
end
   if  S.LayonHands:ID() ==  HR.queuedSpell[1]:ID() and Player:DebuffUp(S.Forbearance) then
      HR.queuedSpell = { HR.Spell[1].Empty, 0 }
end

   if  S.DivineSteed:ID() ==  HR.queuedSpell[1]:ID() and Player:BuffUp(S.DivineSteedBuff) then
      HR.queuedSpell = { HR.Spell[1].Empty, 0 }
end

  
  if not IsCurrentSpell(6603) and Player:CanAttack(Target)
  and Target:AffectingCombat() and Player:AffectingCombat() and Target:IsInRange(10) then
    if Cast(S.autoattack) then return "autoattack"; end
  end

  
  if HR.QueuedSpell():IsReadyQueue() then
    if Cast(HR.QueuedSpell()) then return "Queue Spell Sent"; end
  end


  if (not HR.queuedSpell[1]:CooldownUp() or not Player:AffectingCombat() or #Enemies30y) then 
    HR.queuedSpell = { HR.Spell[1].Empty, 0 }
end

  -- divine_toll
  if S.DivineToll:IsCastable() and Target:IsInRange(30) and (Target:DebuffUp(S.JudgmentDebuff) or #Enemies30y>=3 or Player:BuffUp(S.AvengingWrathBuff)) then
    if Cast(S.DivineToll) then return "divine_toll generators 19"; end
  end





  if Everyone.TargetIsValid() then
    -- Precombat
    if not Player:AffectingCombat() then
      local ShouldReturn = Precombat(); if ShouldReturn then return ShouldReturn; end
    end
    -- auto_attack

    -- Interrupts
    local ShouldReturn = Everyone.Interrupt(5, S.Rebuke, Settings.Commons.OffGCDasOffGCD.Rebuke, StunInterrupts) and Target:IsInRange(5) and Target:CastPercentage()>25 and Target:CastPercentage()<75; if ShouldReturn then return ShouldReturn; end
    local ShouldReturn = Everyone.Interrupt(30, S.AvengersShield, Settings.Commons.OffGCDasOffGCD.AvengersShield, StunInterrupts) and Target:IsInRange(5) and Target:CastPercentage()>0 and Target:CastPercentage()<90; if ShouldReturn then return ShouldReturn; end

    
    
    -- Manually added: Defensives!

    if S.Consecration:IsCastable() and consecrationactivate and Player:BuffDown(S.ConsecrationBuff) and (Target:DebuffUp(S.JudgmentDebuff) or S.Judgment:CooldownRemains()>Player:GCD() or Player:BuffUp(S.ShieldoftheRighteousBuff)) then
      if Cast(S.Consecration) then return "consecration precombat 4"; end
    end

    if (IsTanking) then
      local ShouldReturn = Defensives(); if ShouldReturn then return ShouldReturn; end
    end
    -- call_action_list,name=cooldowns
    if (CDsON()) then
      local ShouldReturn = Cooldowns(); if ShouldReturn then return ShouldReturn; end
    end
    -- call_action_list,name=standard
    if (true) then
      local ShouldReturn = Standard(); if ShouldReturn then return ShouldReturn; end
    end
    -- Manually added: Pool, if nothing else to do


  end
  if  Player:IsMounted() then return HR.Cast(S.mounted)
  elseif Player:AffectingCombat() then
    return HR.Cast(S.combat)
  else
return HR.Cast(S.MPI)
  end
end



HR.SetAPL(66, APL)
