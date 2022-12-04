--- ============================ HEADER ============================
--- ======= LOCALIZE =======
-- Addon
local addonName, addonTable = ...
-- HeroDBC
local DBC = HeroDBC.DBC
-- HeroLib
local HL = HeroLib
local Cache = HeroCache
local Unit = HL.Unit
local Player = Unit.Player
local Pet = Unit.Pet
local Target = Unit.Target
local Spell = HL.Spell
local MultiSpell = HL.MultiSpell
local Item = HL.Item
-- HeroRotation
local HR = HeroRotation
local AoEON = HR.AoEON
local CDsON = HR.CDsON
local Cast  = HR.Cast
-- Lua

--- ============================ CONTENT ============================
--- ======= APL LOCALS =======
-- Commons
local Everyone = HR.Commons.Everyone

-- GUI Settings
local Settings = {
  General = HR.GUISettings.General,
  Commons = HR.GUISettings.APL.Druid.Commons,
  Guardian = HR.GUISettings.APL.Druid.Guardian
}

-- Spells
local S = Spell.Druid.Guardian

-- Items
local I = Item.Druid.Guardian
local OnUseExcludes = {
  --  I.TrinketName:ID(),
}

-- Trinket Item Objects
local equip = Player:GetEquipment()
local trinket1 = equip[13] and Item(equip[13]) or Item(0)
local trinket2 = equip[14] and Item(equip[14]) or Item(0)

-- Rotation Variables
local ActiveMitigationNeeded
local IsTanking
local UseMaul

-- Enemies Variables
local MeleeEnemies11y, MeleeEnemies11yCount

-- Event Registrations
HL:RegisterForEvent(function()
  equip = Player:GetEquipment()
  trinket1 = equip[13] and Item(equip[13]) or Item(0)
  trinket2 = equip[14] and Item(equip[14]) or Item(0)
end, "PLAYER_EQUIPMENT_CHANGED")

-- num/bool Functions
local function num(val)
  if val then return 1 else return 0 end
end

local function bool(val)
  return val ~= 0
end

local function NoToothandClaw(enemies)
  for _, CycleUnit in pairs(enemies) do
    if CycleUnit:DebuffUp(S.ToothandClawDebuff) then
      return false
    end
  end
  return true
end

-- Functions
local function EvaluateCycleMoonfire(TargetUnit)
  -- if=((!ticking&time_to_die>12)|(refreshable&time_to_die>12))&active_enemies<8
  return ((TargetUnit:DebuffRefreshable(S.MoonfireDebuff) and TargetUnit:TimeToDie() > 12) and MeleeEnemies11yCount < 8)
end

local function EvaluateCycleThrash(TargetUnit)
  -- target_if=refreshable|dot.thrash_bear.stack<3|active_enemies>=5
  return (TargetUnit:DebuffRefreshable(S.ThrashDebuff) or TargetUnit:DebuffStack(S.ThrashDebuff) < 3 or MeleeEnemies11yCount >= 5)
end

local function EvaluateCyclePulverize(TargetUnit)
  -- target_if=dot.thrash_bear.stack>2
  return (TargetUnit:DebuffStack(S.ThrashDebuff) > 2)
end

local function Defensives()
  if Player:HealthPercentage() < Settings.Guardian.FrenziedRegenHP and S.FrenziedRegeneration:IsReady() and Player:BuffDown(S.FrenziedRegenerationBuff) and not Player:HealingAbsorbed() then
    if Cast(S.FrenziedRegeneration, nil, Settings.Guardian.DisplayStyle.Defensives) then return "frenzied_regeneration defensive 2"; end
  end
  if S.Ironfur:IsCastable() and (Player:Rage() >= S.Ironfur:Cost() + 1 and (Player:BuffDown(S.IronfurBuff) or Player:BuffStack(S.IronfurBuff) < 2 and Player:BuffRefreshable(S.Ironfur) or Player:Rage() >= 90)) then
    if Cast(S.Ironfur, nil, Settings.Guardian.DisplayStyle.Defensives) then return "ironfur defensive 4"; end
  end
  if S.Barkskin:IsCastable() and (Player:HealthPercentage() < Settings.Guardian.BarkskinHP and Player:BuffDown(S.IronfurBuff) or Player:HealthPercentage() < Settings.Guardian.BarkskinHP * 0.75) then
    if Cast(S.Barkskin, nil, Settings.Guardian.DisplayStyle.Defensives) then return "barkskin defensive 6"; end
  end
  if S.SurvivalInstincts:IsCastable() and (Player:HealthPercentage() < Settings.Guardian.SurvivalInstinctsHP) then
    if Cast(S.SurvivalInstincts, nil, Settings.Guardian.DisplayStyle.Defensives) then return "survival_instincts defensive 8"; end
  end
  if S.BristlingFur:IsCastable() and (Player:Rage() < Settings.Guardian.BristlingFurRage) then
    if Cast(S.BristlingFur, nil, Settings.Guardian.DisplayStyle.Defensives) then return "bristling_fur defensive 10"; end
  end
end

local function Precombat()
  -- flask
  -- food
  -- augmentation
  -- snapshot_stats
  -- cat_form,if=druid.catweave_bear=1&(cooldown.pause_action.remains|time>30)
  -- moonkin_form,if=(!druid.catweave_bear=1)&(cooldown.pause_action.remains|time>30)
  -- heart_of_the_wild,if=talent.heart_of_the_wild.enabled
  -- prowl,if=druid.catweave_bear=1&(cooldown.pause_action.remains|time>30)
  -- NOTE: Not handling cat-weaving or owl-weaving, so skipping above 4 lines
  -- Manually added: Group buff check
  if S.MarkoftheWild:IsCastable() and (Player:BuffDown(S.MarkoftheWildBuff, true) or Everyone.GroupBuffMissing(S.MarkoftheWildBuff)) then
    if Cast(S.MarkoftheWild, Settings.Commons.GCDasOffGCD.MarkOfTheWild) then return "mark_of_the_wild precombat 2"; end
  end
  -- bear_form,if=(!buff.prowl.up)
  if S.BearForm:IsCastable() then
    if Cast(S.BearForm) then return "bear_form precombat 4"; end
  end
  -- Manually added: moonfire
  if S.Moonfire:IsCastable() then
    if Cast(S.Moonfire, nil, nil, not Target:IsSpellInRange(S.Moonfire)) then return "moonfire precombat 8"; end
  end
  -- Manually added: wild_charge
  if S.WildCharge:IsCastable() and (Target:IsInRange(25) and not Target:IsInRange(8)) then
    if Cast(S.WildCharge) then return "wild_charge precombat 10"; end
  end
  -- Manually added: thrash_bear
  if S.Thrash:IsCastable() and Target:IsInRange(8) then
    if Cast(S.Thrash) then return "thrash precombat 12"; end
  end
  -- Manually added: mangle
  if S.Mangle:IsCastable() and Target:IsInMeleeRange(5) then
    if Cast(S.Mangle) then return "mangle precombat 14"; end
  end
end

local function CatWeave()
  -- heart_of_the_wild,if=talent.heart_of_the_wild.enabled&!buff.heart_of_the_wild.up&!buff.cat_form.up
  -- cat_form,if=!buff.cat_form.up
  -- rake,if=buff.prowl.up
  -- heart_of_the_wild,if=talent.heart_of_the_wild.enabled&!buff.heart_of_the_wild.up
  -- rake,if=dot.rake.refreshable|energy<45
  -- rip,if=dot.rip.refreshable&combo_points>=1
  -- convoke_the_spirits
  -- ferocious_bite,if=combo_points>=4&energy>50
  -- shred,if=combo_points<=5
end

local function OwlWeave()
  -- heart_of_the_wild,if=talent.heart_of_the_wild.enabled&!buff.heart_of_the_wild.up&!buff.cat_form.up
  -- moonfire,if=buff.galactic_guardian.up&buff.galactic_guardian.remains<=gcd+1
  -- sunfire,if=dot.sunfire.refreshable
  -- starsurge
end

local function OwlConvoke()
  -- heart_of_the_wild,if=talent.heart_of_the_wild.enabled&!buff.heart_of_the_wild.up&!buff.moonkin_form.up
  -- moonkin_form,if=!buff.moonkin_form.up
  -- convoke_the_spirits
end

local function CatConvoke()
  -- heart_of_the_wild,if=talent.heart_of_the_wild.enabled&!buff.heart_of_the_wild.up&!buff.cat_form.up
  -- cat_form,if=!buff.cat_form.up
  -- convoke_the_spirits
end

local function Bear()
  -- bear_form,if=!buff.bear_form.up
  if S.BearForm:IsCastable() and (Player:BuffDown(S.BearForm)) then
    if Cast(S.BearForm) then return "bear_form bear 2"; end
  end
  -- heart_of_the_wild,if=talent.heart_of_the_wild.enabled
  if S.HeartoftheWild:IsCastable() then
    if Cast(S.HeartoftheWild, Settings.Guardian.GCDasOffGCD.HeartOfTheWild) then return "heart_of_the_wild bear 4"; end
  end
  -- moonfire,cycle_targets=1,if=((!ticking&time_to_die>12)|(refreshable&time_to_die>12))&active_enemies<8
  if S.Moonfire:IsReady() then
    if Everyone.CastCycle(S.Moonfire, MeleeEnemies11y, EvaluateCycleMoonfire, not Target:IsSpellInRange(S.Moonfire)) then return "moonfire bear 6"; end
  end
  -- barkskin,if=!buff.bear_form.up
  if S.Barkskin:IsReady() and (Player:BuffDown(S.BearForm)) then
    if Cast(S.Barkskin, nil, Settings.Guardian.DisplayStyle.Defensives) then return "barkskin bear 8"; end
  end
  if CDsON() then
    -- convoke_the_spirits
    if S.ConvoketheSpirits:IsCastable() then
      if Cast(S.ConvoketheSpirits, nil, Settings.Commons.DisplayStyle.Signature) then return "convoke_the_spirits bear 10"; end
    end
    -- berserk_bear
    if S.Berserk:IsCastable() then
      if Cast(S.Berserk, Settings.Guardian.OffGCDasOffGCD.Berserk) then return "berserk bear 12"; end
    end
    -- incarnation
    if S.Incarnation:IsCastable() then
      if Cast(S.Incarnation, Settings.Guardian.OffGCDasOffGCD.Incarnation) then return "incarnation bear 14"; end
    end
  end
  -- rage_of_the_sleeper,if=buff.incarnation_guardian_of_ursoc.down&cooldown.incarnation_guardian_of_ursoc.remains>60|buff.incarnation_guardian_of_ursoc.up
  if S.RageoftheSleeper:IsCastable() and (IsTanking) and (Player:BuffDown(S.IncarnationBuff) and S.Incarnation:CooldownRemains() > 60 or Player:BuffUp(S.IncarnationBuff)) then
    if Cast(S.RageoftheSleeper) then return "rage_of_the_sleeper bear 16"; end
  end
  -- berserking,if=(buff.berserk_bear.up|buff.incarnation_guardian_of_ursoc.up)
  if S.Berserking:IsCastable() and (Player:BuffUp(S.BerserkBuff) or Player:BuffUp(S.IncarnationBuff)) then
    if Cast(S.Berserking, Settings.Commons.OffGCDasOffGCD.Racials) then return "berserking bear 18"; end
  end
  -- maul,if=buff.rage_of_the_sleeper.up&buff.tooth_and_claw.stack>0&active_enemies<=6
  if S.Maul:IsReady() and UseMaul and (Player:BuffUp(S.RageoftheSleeper) and Player:BuffStack(S.ToothandClawBuff) > 0 and MeleeEnemies11yCount <= 6) then
    if Cast(S.Maul, nil, nil, not Target:IsInMeleeRange(8)) then return "maul bear 20"; end
  end
  -- ironfur,target_if=!debuff.tooth_and_claw_debuff.up,if=!buff.ironfur.up&!cooldown.pause_action.remains|rage>90
  -- Note: ironfur handled in Defensives
  -- moonfire,if=buff.galactic_guardian.up&buff.galactic_guardian.remains<=gcd+0.5
  if S.Moonfire:IsReady() and (Player:BuffUp(S.GalacticGuardianBuff) and Player:BuffRemains(S.GalacticGuardianBuff) <= Player:GCD() + 0.5) then
    if Cast(S.Moonfire, nil, nil, not Target:IsSpellInRange(S.Moonfire)) then return "moonfire bear 22"; end
  end
  -- mangle,if=buff.gore.up&active_enemies<11|buff.vicious_cycle_mangle.stack=3
  if S.Mangle:IsCastable() and (Player:BuffUp(S.GoreBuff) and MeleeEnemies11yCount < 11 or Player:BuffStack(S.ViciousCycleMaulBuff) == 3) then
    if Cast(S.Mangle, nil, nil, not Target:IsInMeleeRange(8)) then return "mangle bear 24"; end
  end
  -- maul,if=((buff.incarnation.up|buff.berserk_bear.up)&active_enemies<=5&(buff.tooth_and_claw.stack>=2))
  if S.Maul:IsReady() and UseMaul and (((Player:BuffUp(S.IncarnationBuff) or Player:BuffUp(S.BerserkBuff)) and MeleeEnemies11yCount <= 5 and Player:BuffStack(S.ToothandClawBuff) >= 2)) then
    if Cast(S.Maul, nil, nil, not Target:IsInMeleeRange(8)) then return "maul bear 26"; end
  end
  -- thrash_bear,target_if=refreshable|dot.thrash_bear.stack<3|active_enemies>=5
  if S.Thrash:IsCastable() then
    if Everyone.CastCycle(S.Thrash, MeleeEnemies11y, EvaluateCycleThrash, not Target:IsInMeleeRange(11)) then return "thrash bear 28"; end
  end
  -- swipe,if=buff.incarnation_guardian_of_ursoc.down&buff.berserk_bear.down&active_enemies>=11
  if S.Swipe:IsCastable() and (Player:BuffDown(S.IncarnationBuff) and Player:BuffDown(S.BerserkBuff) and MeleeEnemies11yCount >= 11) then
    if Cast(S.Swipe, nil, nil, not Target:IsInMeleeRange(11)) then return "swipe bear 30"; end
  end
  -- maul,if=((buff.tooth_and_claw.up&buff.tooth_and_claw.remains<1.5)&active_enemies<=5)
  if S.Maul:IsReady() and UseMaul and ((Player:BuffUp(S.ToothandClawBuff) and Player:BuffRemains(S.ToothandClawBuff) < 1.5) and MeleeEnemies11yCount <= 5) then
    if Cast(S.Maul, nil, nil, not Target:IsInMeleeRange(8)) then return "maul bear 32"; end
  end
  -- maul,if=active_enemies<=5&buff.vicious_cycle_maul.stack>=3|active_enemies<4&!talent.vicious_cycle_maul.enabled
  if S.Maul:IsReady() and UseMaul and (MeleeEnemies11yCount <= 5 and Player:BuffStack(S.ViciousCycleMaulBuff) >= 3 or MeleeEnemies11yCount < 4 and not S.ViciousCycle:IsAvailable()) then
    if Cast(S.Maul, nil, nil, not Target:IsInMeleeRange(8)) then return "maul bear 34"; end
  end
  -- mangle,if=(buff.incarnation.up&active_enemies<=4)|(buff.incarnation.up&talent.soul_of_the_forest.enabled&active_enemies<=5)|((rage<90)&active_enemies<11)|((rage<85)&active_enemies<11&talent.soul_of_the_forest.enabled)
  if S.Mangle:IsCastable() and ((Player:BuffUp(S.IncarnationBuff) and MeleeEnemies11yCount <= 4) or (Player:BuffUp(S.IncarnationBuff) and S.SouloftheForest:IsAvailable() and MeleeEnemies11yCount <= 5) or (Player:Rage() < 90 and MeleeEnemies11yCount < 11) or (Player:Rage() < 85 and MeleeEnemies11yCount < 11 and S.SouloftheForest:IsAvailable())) then
    if Cast(S.Mangle, nil, nil, not Target:IsInMeleeRange(8)) then return "mangle bear 36"; end
  end
  -- thrash_bear,if=active_enemies>1
  if S.Thrash:IsCastable() and (MeleeEnemies11yCount > 1) then
    if Cast(S.Thrash, nil, nil, not Target:IsInMeleeRange(11)) then return "thrash bear 38"; end
  end
  -- pulverize,target_if=dot.thrash_bear.stack>2
  if S.Pulverize:IsReady() then
    if Everyone.CastCycle(S.Pulverize, MeleeEnemies11y, EvaluateCyclePulverize, not Target:IsInMeleeRange(8)) then return "pulverize bear 40"; end
  end
  -- thrash_bear
  if S.Thrash:IsCastable() then
    if Cast(S.Thrash, nil, nil, not Target:IsInMeleeRange(11)) then return "thrash bear 42"; end
  end
  -- swipe_bear
  if S.Swipe:IsCastable() then
    if Cast(S.Swipe, nil, nil, not Target:IsInMeleeRange(11)) then return "swipe bear 44"; end
  end
end

local function APL()
  -- Enemies Update
  if AoEON() then
    MeleeEnemies11y = Player:GetEnemiesInMeleeRange(11)
    MeleeEnemies11yCount = #MeleeEnemies11y
  else
    MeleeEnemies11y = {}
    MeleeEnemies11yCount = 1
  end

  ActiveMitigationNeeded = Player:ActiveMitigationNeeded()
  IsTanking = Player:IsTankingAoE(8) or Player:IsTanking(Target)

  UseMaul = false
  if ((Player:Rage() >= S.Maul:Cost() + 20 and not IsTanking) or Player:RageDeficit() <= 10 or not Settings.Guardian.UseRageDefensively) then
    UseMaul = true
  end

  if Everyone.TargetIsValid() then
    -- Precombat
    if not Player:AffectingCombat() then
      local ShouldReturn = Precombat(); if ShouldReturn then return ShouldReturn; end
    end
    -- Interrupt
    local ShouldReturn = Everyone.Interrupt(13, S.SkullBash, Settings.Guardian.OffGCDasOffGCD.SkullBash, false); if ShouldReturn then return ShouldReturn; end
    -- Manually added: run_action_list,name=defensives
    if (IsTanking and Player:BuffUp(S.BearForm)) then
      local ShouldReturn = Defensives(); if ShouldReturn then return ShouldReturn; end
    end
    -- Manually added: wild_charge if not in range
    if S.WildCharge:IsCastable() and not Target:IsInRange(8) then
      if Cast(S.WildCharge, Settings.Commons.GCDasOffGCD.WildCharge, nil, not Target:IsInRange(28)) then return "wild_charge main"; end
    end
    -- auto_attack,if=!buff.prowl.up
    -- use_item,name=jotungeirr_destinys_call,if=!buff.prowl.up&!covenant.venthyr
    if I.Jotungeirr:IsEquippedAndReady() and (CovenantID ~= 2) then
      if Cast(I.Jotungeirr, nil, Settings.Commons.DisplayStyle.Items) then return "jotungeirr_destinys_call main 2"; end
    end
    -- use_item,slot=trinket1
    -- use_item,slot=trinket2
    if Settings.Commons.Enabled.Trinkets then
      local TrinketToUse = Player:GetUseableTrinkets(OnUseExcludes)
      if TrinketToUse then
        if Cast(TrinketToUse, nil, Settings.Commons.DisplayStyle.Trinkets) then return "Generic use_items for " .. TrinketToUse:Name(); end
      end
    end
    -- potion,if=((talent.heart_of_the_wild.enabled&buff.heart_of_the_wild.up)|((buff.berserk_bear.up|buff.incarnation_guardian_of_ursoc.up)&(!druid.catweave_bear&!druid.owlweave_bear)))
    if Settings.Commons.Enabled.Potions and ((S.HeartoftheWild:IsAvailable() and Player:BuffUp(S.HeartoftheWild)) or (Player:BuffUp(S.BerserkBuff) or Player:BuffUp(S.Incarnation))) then
      local PotionSelected = Everyone.PotionSelected()
      if PotionSelected and PotionSelected:IsReady() then
        if Cast(PotionSelected, nil, Settings.Commons.DisplayStyle.Potions) then return "potion main 8"; end
      end
    end
    -- run_action_list,name=catweave,if=(target.cooldown.pause_action.remains|time>=30)&druid.catweave_bear=1&buff.tooth_and_claw.remains<1.5&(buff.incarnation_guardian_of_ursoc.down&buff.berserk_bear.down)&(cooldown.thrash_bear.remains>0&cooldown.mangle.remains>0&dot.moonfire.remains>=gcd+0.5)|(buff.cat_form.up&energy>25&druid.catweave_bear=1&buff.tooth_and_claw.remains<1.5)|(buff.heart_of_the_wild.up&energy>90&druid.catweave_bear=1&buff.tooth_and_claw.remains<1.5)
    -- run_action_list,name=owlweave,if=(target.cooldown.pause_action.remains|time>=30)&buff.tooth_and_claw.remains<1.5&((druid.owlweave_bear=1)&buff.incarnation_guardian_of_ursoc.down&buff.berserk_bear.down&cooldown.starsurge.up)
    -- Skipping the above lists, as we're not handling catweaving or owlweaving
    -- run_action_list,name=bear
    local ShouldReturn = Bear(); if ShouldReturn then return ShouldReturn; end
    -- Manually added: Pool if nothing to do
    if HR.CastAnnotated(S.Pool, false, "WAIT") then return "Wait/Pool Resources"; end
  end
end

local function OnInit()
  HR.Print("Guardian Druid rotation is currently a work in progress, but has been updated for patch 10.0.")
end

HR.SetAPL(104, APL, OnInit)
