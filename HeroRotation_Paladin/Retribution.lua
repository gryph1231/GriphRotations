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
-- Lua
local mathmin = math.min

--- ============================ CONTENT ============================
--- ======= APL LOCALS =======
-- Commons
local Everyone = HR.Commons.Everyone
local Paladin = HR.Commons.Paladin

-- GUI Settings
local Settings = {
  General = HR.GUISettings.General,
  Commons = HR.GUISettings.APL.Paladin.Commons,
  Retribution = HR.GUISettings.APL.Paladin.Retribution
}

-- Spells
local S = Spell.Paladin.Retribution

-- Items
local I = Item.Paladin.Retribution
local OnUseExcludeTrinkets = {
  I.AnodizedDeflectors:ID(),
  I.AspirantsBadgeCosmic:ID(),
  I.AspirantsBadgeSinful:ID(),
  I.AspirantsBadgeUnchained:ID(),
  I.BloodstainedHandkerchief:ID(),
  I.ChainsofDomination:ID(),
  I.DarkmoonDeckVoracity:ID(),
  I.DreadfireVessel:ID(),
  I.EarthbreakersImpact:ID(),
  I.EnforcersStunGrenade:ID(),
  I.FaultyCountermeasure:ID(),
  I.GaveloftheFirstArbiter:ID(),
  I.GiantOrnamentalPearl:ID(),
  I.GladiatorsBadgeCosmic:ID(),
  I.GladiatorsBadgeSinful:ID(),
  I.GladiatorsBadgeUnchained:ID(),
  I.GrimCodex:ID(),
  I.HeartoftheSwarm:ID(),
  I.InscrutableQuantumDevice:ID(),
  I.MacabreSheetMusic:ID(),
  I.MemoryofPastSins:ID(),
  I.OverwhelmingPowerCrystal:ID(),
  I.RemoteGuidanceDevice:ID(),
  I.RingofCollapsingFutures:ID(),
  I.SalvagedFusionAmplifier:ID(),
  I.ScarsofFraternalStrife:ID(),
  I.SkulkersWing:ID(),
  I.SpareMeatHook:ID(),
  I.TheFirstSigil:ID(),
  I.ToeKneesPromise:ID(),
  I.WindscarWhetstone:ID()
}

local MagistratesJudgmentEquipped = Player:HasLegendaryEquipped(101)
local VanguardsMomentumEquipped = Player:HasLegendaryEquipped(112)
local FinalVerdictEquipped = Player:HasLegendaryEquipped(113)
local MadParagonEquipped = Player:HasLegendaryEquipped(196)
local DivineResonanceEquipped = Player:HasLegendaryEquipped(234)
local VerdictSpell = FinalVerdictEquipped and S.FinalVerdict or S.TemplarsVerdict

HL:RegisterForEvent(function()
  MagistratesJudgmentEquipped = Player:HasLegendaryEquipped(101)
  VanguardsMomentumEquipped = Player:HasLegendaryEquipped(112)
  FinalVerdictEquipped = Player:HasLegendaryEquipped(113)
  MadParagonEquipped = Player:HasLegendaryEquipped(196)
  DivineResonanceEquipped = Player:HasLegendaryEquipped(234)
  VerdictSpell = FinalVerdictEquipped and S.FinalVerdict or S.TemplarsVerdict
end, "PLAYER_EQUIPMENT_CHANGED")

-- Player Covenant
-- 0: none, 1: Kyrian, 2: Venthyr, 3: Night Fae, 4: Necrolord
local CovenantID = Player:CovenantID()

-- Update CovenantID if we change Covenants
HL:RegisterForEvent(function()
  CovenantID = Player:CovenantID()
end, "COVENANT_CHOSEN")

-- Rotation Variables
local BossFightRemains = 11111
local FightRemains = 11111
local TimeToHPG
local VarDSCastable

HL:RegisterForEvent(function()
  BossFightRemains = 11111
  FightRemains = 11111
end, "PLAYER_REGEN_ENABLED")



-- Interrupts
-- local Interrupts = {
--   { S.HammerofJustice, "Cast Hammer of Justice (Interrupt)", function () return true; end },
-- }

--- ======= HELPERS =======
-- time_to_hpg_expr_t @ https://github.com/simulationcraft/simc/blob/shadowlands/engine/class_modules/paladin/sc_paladin.cpp#L3236
local function ComputeTimeToHPG()
  local GCDRemains = Player:GCDRemains()
  local ShortestHPGTime = mathmin(
    S.CrusaderStrike:CooldownRemains(),
    S.BladeofJustice:CooldownRemains(),
    S.Judgment:CooldownRemains(),
    S.HammerofWrath:IsUsable() and S.HammerofWrath:CooldownRemains() or 10, -- if not usable, return a dummy 10
    S.WakeofAshes:CooldownRemains()
  )

  if GCDRemains > ShortestHPGTime then
    return GCDRemains
  end

  return ShortestHPGTime
end

local function HandleNightFaeBlessings()
  local Seasons = {S.BlessingofSpring, S.BlessingofSummer, S.BlessingofAutumn, S.BlessingofWinter}
  for _, i in pairs(Seasons) do
    if i:IsCastable() then
      if Cast(i, nil, Settings.Commons.DisplayStyle.Signature) then return "blessing_of_the_seasons"; end
    end
  end
end

local function MissingAura()
  return (Player:BuffDown(S.RetributionAura) and Player:BuffDown(S.DevotionAura) and Player:BuffDown(S.ConcentrationAura) and Player:BuffDown(S.CrusaderAura))
end

--- ======= ACTION LISTS =======
local function Precombat()
  -- flask
  -- food
  -- augmentation
  -- snapshot_stats
  -- retribution_aura

  -- fleshcraft,if=soulbind.pustule_eruption|soulbind.volatile_solvent
  if S.Fleshcraft:IsCastable() and (S.PustuleEruption:SoulbindEnabled() or S.VolatileSolvent:SoulbindEnabled()) then
    if Cast(S.Fleshcraft) then return "fleshcraft precombat 2"; end
  end
  -- arcane_torrent,if=talent.final_reckoning&talent.seraphim
  if S.ArcaneTorrent:IsCastable() and Target:IsInRange(8) and (S.FinalReckoning:IsAvailable() and S.Seraphim:IsAvailable()) then
    if Cast(S.ArcaneTorrent) then return "arcane_torrent precombat 4"; end
  end
  -- blessing_of_the_seasons
  local ShouldReturn = HandleNightFaeBlessings(); if ShouldReturn then return ShouldReturn; end
  -- shield_of_vengeance
  -- if S.ShieldofVengeance:IsCastable() then
  --   if Cast(S.ShieldofVengeance, Settings.Retribution.GCDasOffGCD.ShieldOfVengeance) then return "shield_of_vengeance precombat 6"; end
  -- end
  -- Manually added: openers
  if Player:HolyPower() >= 4 and Target:IsInMeleeRange(5) then
    if S.DivineStorm:IsReady() and divinestormrange then
      if Cast(S.DivineStorm) then return "divine_storm precombat 8" end
    end
    if VerdictSpell:IsReady() and Target:IsInRange(8) and not divinestormrange  then
      if Cast(VerdictSpell) then return "either verdict precombat 10" end
    end
  end
  if S.BladeofJustice:IsCastable() and Target:IsInRange(12) then
    if Cast(S.BladeofJustice) then return "blade_of_justice precombat 12" end
  end
  if S.HammerofWrath:IsReady() and Target:IsInRange(30) then
    if Cast(S.HammerofWrath) then return "hammer_of_wrath precombat 14" end
  end
  if S.Judgment:IsCastable() and Target:IsInRange(30)then
    if Cast(S.Judgment) then return "judgment precombat 16" end
  end
  if S.CrusaderStrike:IsCastable() and Target:IsInRange(8) then
    if Cast(S.CrusaderStrike) then return "crusader_strike 18" end
  end
end

local function Cooldowns()
  -- potion,if=buff.avenging_wrath.up|buff.crusade.up&buff.crusade.stack=10|fight_remains<25
  if Settings.Commons.Enabled.Potions and (Player:BuffUp(S.AvengingWrathBuff) or Player:BuffUp(S.CrusadeBuff) and Player:BuffStack(S.CrusadeBuff) == 10 or FightRemains < 25) then
    local PotionSelected = Everyone.PotionSelected()
    if PotionSelected and PotionSelected:IsReady() then
      if Cast(PotionSelected, nil, Settings.Commons.DisplayStyle.Potions) then return "potion cooldowns 2"; end
    end
  end
  -- lights_judgment,if=spell_targets.lights_judgment>=2|!raid_event.adds.exists|raid_event.adds.in>75|raid_event.adds.up
  -- if S.LightsJudgment:IsCastable() then
  --   if Cast(S.LightsJudgment, Settings.Commons.GCDasOffGCD.Racials, nil, not Target:IsInRange(40)) then return "lights_judgment cooldowns 4" end
  -- end
  -- fireblood,if=(buff.avenging_wrath.up|buff.crusade.up&buff.crusade.stack=10)&!talent.execution_sentence
  -- if S.Fireblood:IsCastable() and ((Player:BuffUp(S.AvengingWrathBuff) or (Player:BuffUp(S.Crusade) and Player:BuffStack(S.Crusade) == 10)) and not S.ExecutionSentence:IsAvailable()) then
  --   if Cast(S.Fireblood, Settings.Commons.GCDasOffGCD.Racials) then return "fireblood cooldowns 6" end
  -- end
  -- fleshcraft,if=soulbind.pustule_eruption|soulbind.volatile_solvent,interrupt_immediate=1,interrupt_global=1,interrupt_if=soulbind.volatile_solvent
  if S.Fleshcraft:IsCastable() and (S.PustuleEruption:SoulbindEnabled() or S.VolatileSolvent:SoulbindEnabled()) then
    if Cast(S.Fleshcraft, nil, Settings.Commons.DisplayStyle.Signature) then return "fleshcraft cooldowns 8"; end
  end
  -- shield_of_vengeance,if=(!talent.execution_sentence|cooldown.execution_sentence.remains<52)&fight_remains>15
  if S.ShieldofVengeance:IsCastable() and (((not S.ExecutionSentence:IsAvailable()) or S.ExecutionSentence:CooldownRemains() < 52) and FightRemains > 15) then
    if Cast(S.ShieldofVengeance, Settings.Retribution.GCDasOffGCD.ShieldOfVengeance) then return "shield_of_vengeance cooldowns 10"; end
  end
  -- blessing_of_the_seasons
  local ShouldReturn = HandleNightFaeBlessings(); if ShouldReturn then return ShouldReturn; end
  if (Settings.Commons.Enabled.Items) then
    -- use_item,name=gavel_of_the_first_arbiter
    if I.GaveloftheFirstArbiter:IsEquippedAndReady() then
      if Cast(I.GaveloftheFirstArbiter, nil, Settings.Commons.DisplayStyle.Items, not Target:IsInRange(30)) then return "gavel_of_the_first_arbiter cooldowns 12"; end
    end
    -- use_item,name=ring_of_collapsing_futures,if=!buff.temptation.up|fight_remains<15
    if I.RingofCollapsingFutures:IsEquippedAndReady() and (Player:BuffDown(S.TemptationBuff) or FightRemains < 15) then
      if Cast(I.RingofCollapsingFutures, nil, Settings.Commons.DisplayStyle.Items) then return "ring_of_collapsing_futures cooldowns 14"; end
    end
    -- use_item,name=anodized_deflectors
    if I.AnodizedDeflectors:IsEquippedAndReady() then
      if Cast(S.wristsx) then return "anodized_deflectors cooldowns 16"; end
    end
  end
  if (Settings.Commons.Enabled.Trinkets) then
    -- use_item,name=the_first_sigil,if=buff.avenging_wrath.up|buff.crusade.up&buff.crusade.stack=10|fight_remains<20
    if I.TheFirstSigil:IsEquippedAndReady() and (Player:BuffUp(S.AvengingWrathBuff) or Player:BuffUp(S.CrusadeBuff) and Player:BuffStack(S.CrusadeBuff) == 10 or FightRemains < 20) then
      if Cast(I.TheFirstSigil, nil, Settings.Commons.DisplayStyle.Trinkets) then return "the_first_sigil cooldowns 18"; end
    end
    -- use_item,name=enforcers_stun_grenade,if=buff.avenging_wrath.up|buff.crusade.up&buff.crusade.stack=10|fight_remains<20
    if I.EnforcersStunGrenade:IsEquippedAndReady() and (Player:BuffUp(S.AvengingWrathBuff) or Player:BuffUp(S.CrusadeBuff) and Player:BuffStack(S.CrusadeBuff) == 10 or FightRemains < 20) then
      if Cast(I.EnforcersStunGrenade, nil, Settings.Commons.DisplayStyle.Trinkets) then return "enforcers_stun_grenade cooldowns 20"; end
    end
    -- use_item,name=inscrutable_quantum_device,if=buff.avenging_wrath.up|buff.crusade.up&buff.crusade.stack=10|fight_remains<30
    if I.InscrutableQuantumDevice:IsEquippedAndReady() and (Player:BuffUp(S.AvengingWrathBuff) or Player:BuffUp(S.CrusadeBuff) and Player:BuffStack(S.CrusadeBuff) == 10 or FightRemains < 30) then
      if Cast(I.InscrutableQuantumDevice, nil, Settings.Commons.DisplayStyle.Trinkets) then return "inscrutable_quantum_device cooldowns 22"; end
    end
    -- use_item,name=overwhelming_power_crystal,if=buff.avenging_wrath.up|buff.crusade.up&buff.crusade.stack=10|fight_remains<15
    if I.OverwhelmingPowerCrystal:IsEquippedAndReady() and (Player:BuffUp(S.AvengingWrathBuff) or Player:BuffUp(S.CrusadeBuff) and Player:BuffStack(S.CrusadeBuff) == 10 or FightRemains < 15) then
      if Cast(I.OverwhelmingPowerCrystal, nil, Settings.Commons.DisplayStyle.Trinkets) then return "overwhelming_power_crystal cooldowns 24"; end
    end
    -- use_item,name=darkmoon_deck_voracity,if=buff.avenging_wrath.up|buff.crusade.up&buff.crusade.stack=10|fight_remains<20
    if I.DarkmoonDeckVoracity:IsEquippedAndReady() and (Player:BuffUp(S.AvengingWrathBuff) or Player:BuffUp(S.CrusadeBuff) and Player:BuffStack(S.CrusadeBuff) == 10 or FightRemains < 20) then
      if Cast(I.DarkmoonDeckVoracity, nil, Settings.Commons.DisplayStyle.Trinkets) then return "darkmoon_deck_voracity cooldowns 26"; end
    end
    -- use_item,name=macabre_sheet_music,if=buff.avenging_wrath.up|buff.crusade.up&buff.crusade.stack=10|fight_remains<20
    if I.MacabreSheetMusic:IsEquippedAndReady() and (Player:BuffUp(S.AvengingWrathBuff) or Player:BuffUp(S.CrusadeBuff) and Player:BuffStack(S.CrusadeBuff) == 10 or FightRemains < 20) then
      if Cast(I.MacabreSheetMusic, nil, Settings.Commons.DisplayStyle.Trinkets) then return "macabre_sheet_music cooldowns 28"; end
    end
    -- use_item,name=faulty_countermeasure,if=!talent.crusade|buff.crusade.up|fight_remains<30
    if I.FaultyCountermeasure:IsEquippedAndReady() and ((not S.Crusade:IsAvailable()) or Player:BuffUp(S.CrusadeBuff) or FightRemains < 30) then
      if Cast(I.FaultyCountermeasure, nil, Settings.Commons.DisplayStyle.Trinkets) then return "faulty_countermeasure cooldowns 30"; end
    end
    -- use_item,name=dreadfire_vessel
    if I.DreadfireVessel:IsEquippedAndReady() then
      if Cast(I.DreadfireVessel, nil, Settings.Commons.DisplayStyle.Trinkets) then return "dreadfire_vessel cooldowns 32"; end
    end
    -- use_item,name=skulkers_wing
    if I.SkulkersWing:IsEquippedAndReady() then
      if Cast(I.SkulkersWing, nil, Settings.Commons.DisplayStyle.Trinkets) then return "skulkers_wing cooldowns 34"; end
    end
    -- use_item,name=grim_codex
    if I.GrimCodex:IsEquippedAndReady() then
      if Cast(I.GrimCodex, nil, Settings.Commons.DisplayStyle.Trinkets) then return "grim_codex cooldowns 36"; end
    end
    -- use_item,name=memory_of_past_sins
    if I.MemoryofPastSins:IsEquippedAndReady() then
      if Cast(I.MemoryofPastSins, nil, Settings.Commons.DisplayStyle.Trinkets) then return "memory_of_past_sins cooldowns 38"; end
    end
    -- use_item,name=spare_meat_hook
    if I.SpareMeatHook:IsEquippedAndReady() then
      if Cast(I.SpareMeatHook, nil, Settings.Commons.DisplayStyle.Trinkets) then return "spare_meat_hook cooldowns 40"; end
    end
    -- use_item,name=salvaged_fusion_amplifier
    if I.SalvagedFusionAmplifier:IsEquippedAndReady() then
      if Cast(I.SalvagedFusionAmplifier, nil, Settings.Commons.DisplayStyle.Trinkets) then return "salvaged_fusion_amplifier cooldowns 42"; end
    end
    -- use_item,name=giant_ornamental_pearl
    if I.GiantOrnamentalPearl:IsEquippedAndReady() then
      if Cast(I.GiantOrnamentalPearl, nil, Settings.Commons.DisplayStyle.Trinkets) then return "giant_ornamental_pearl cooldowns 44"; end
    end
    -- use_item,name=windscar_whetstone
    if I.WindscarWhetstone:IsEquippedAndReady() then
      if Cast(I.WindscarWhetstone, nil, Settings.Commons.DisplayStyle.Trinkets) then return "windscar_whetstone cooldowns 46"; end
    end

    -- use_item,name=toe_knees_promise
    if I.ToeKneesPromise:IsEquippedAndReady() then
      if Cast(I.ToeKneesPromise, nil, Settings.Commons.DisplayStyle.Trinkets) then return "toe_knees_promise cooldowns 50"; end
    end
    -- use_item,name=remote_guidance_device
    if I.RemoteGuidanceDevice:IsEquippedAndReady() then
      if Cast(I.RemoteGuidanceDevice, nil, Settings.Commons.DisplayStyle.Trinkets) then return "remote_guidance_device cooldowns 52"; end
    end
    -- use_item,name=scars_of_fraternal_strife,if=!buff.scars_of_fraternal_strife_4.up|fight_remains<35
    if I.ScarsofFraternalStrife:IsEquippedAndReady() then
      if Cast(I.ScarsofFraternalStrife, nil, Settings.Commons.DisplayStyle.Trinkets) then return "scars_of_fraternal_strife cooldowns 54"; end
    end
    -- use_item,name=chains_of_domination
    if I.ChainsofDomination:IsEquippedAndReady() then
      if Cast(I.ChainsofDomination, nil, Settings.Commons.DisplayStyle.Trinkets) then return "chains_of_domination cooldowns 56"; end
    end
    -- use_item,name=earthbreakers_impact
    if I.EarthbreakersImpact:IsEquippedAndReady() then
      if Cast(I.EarthbreakersImpact, nil, Settings.Commons.DisplayStyle.Trinkets) then return "earthbreakers_impact cooldowns 58"; end
    end
    -- use_item,name=heart_of_the_swarm,if=!buff.avenging_wrath.up&!buff.crusade.up
    if I.HeartoftheSwarm:IsEquippedAndReady() and (Player:BuffDown(S.AvengingWrathBuff) and Player:BuffDown(S.CrusadeBuff)) then
      if Cast(I.HeartoftheSwarm, nil, Settings.Commons.DisplayStyle.Trinkets) then return "heart_of_the_swarm cooldowns 60"; end
    end
    if (Player:BuffUp(S.AvengingWrathBuff) or Player:BuffUp(S.CrusadeBuff) and Player:BuffStack(S.CrusadeBuff) >= 10 or S.AvengingWrath:CooldownRemains() > 45 or S.Crusade:CooldownRemains() > 45) then
      -- use_item,name=cosmic_gladiators_badge_of_ferocity,if=buff.avenging_wrath.up|buff.crusade.up&buff.crusade.stack>=10|cooldown.avenging_wrath.remains>45|cooldown.crusade.remains>45
      if I.GladiatorsBadgeCosmic:IsEquippedAndReady() then
        if Cast(I.GladiatorsBadgeCosmic, nil, Settings.Commons.DisplayStyle.Trinkets) then return "cosmic_gladiators_badge_of_ferocity cooldowns 62"; end
      end
      -- use_item,name=cosmic_aspirants_badge_of_ferocity,if=buff.avenging_wrath.up|buff.crusade.up&buff.crusade.stack>=10|cooldown.avenging_wrath.remains>45|cooldown.crusade.remains>45
      if I.AspirantsBadgeCosmic:IsEquippedAndReady() then
        if Cast(I.AspirantsBadgeCosmic, nil, Settings.Commons.DisplayStyle.Trinkets) then return "cosmic_aspirants_badge_of_ferocity cooldowns 64"; end
      end
      -- use_item,name=unchained_gladiators_badge_of_ferocity,if=buff.avenging_wrath.up|buff.crusade.up&buff.crusade.stack>=10|cooldown.avenging_wrath.remains>45|cooldown.crusade.remains>45
      if I.GladiatorsBadgeUnchained:IsEquippedAndReady() then
        if Cast(I.GladiatorsBadgeUnchained, nil, Settings.Commons.DisplayStyle.Trinkets) then return "unchained_gladiators_badge_of_ferocity cooldowns 66"; end
      end
      -- use_item,name=unchained_aspirants_badge_of_ferocity,if=buff.avenging_wrath.up|buff.crusade.up&buff.crusade.stack>=10|cooldown.avenging_wrath.remains>45|cooldown.crusade.remains>45
      if I.AspirantsBadgeUnchained:IsEquippedAndReady() then
        if Cast(I.AspirantsBadgeUnchained, nil, Settings.Commons.DisplayStyle.Trinkets) then return "unchained_aspirants_badge_of_ferocity cooldowns 68"; end
      end
      -- use_item,name=sinful_gladiators_badge_of_ferocity,if=buff.avenging_wrath.up|buff.crusade.up&buff.crusade.stack>=10|cooldown.avenging_wrath.remains>45|cooldown.crusade.remains>45
      if I.GladiatorsBadgeSinful:IsEquippedAndReady() then
        if Cast(I.GladiatorsBadgeSinful, nil, Settings.Commons.DisplayStyle.Trinkets) then return "sinful_gladiators_badge_of_ferocity cooldowns 70"; end
      end
      if I.raven:IsEquippedAndReady() then
        if Cast(S.wristsx) then return "trinket 1"; end
      end
      -- use_item,name=sinful_aspirants_badge_of_ferocity,if=buff.avenging_wrath.up|buff.crusade.up&buff.crusade.stack>=10|cooldown.avenging_wrath.remains>45|cooldown.crusade.remains>45
      if I.AspirantsBadgeSinful:IsEquippedAndReady() then
        if Cast(I.AspirantsBadgeSinful, nil, Settings.Commons.DisplayStyle.Trinkets) then return "sinful_aspirants_badge_of_ferocity cooldowns 72"; end
      end
    end
    -- use_item,name=some_trinket,if=(buff.avenging_wrath.up|buff.crusade.up)
    if (Player:BuffUp(S.AvengingWrathBuff) or Player:BuffUp(S.CrusadeBuff)) then
      local TrinketToUse = Player:GetUseableTrinkets(OnUseExcludeTrinkets)
      if TrinketToUse then
        if Cast(TrinketToUse, nil, Settings.Commons.DisplayStyle.Trinkets) then return "Generic use_items for " .. TrinketToUse:Name(); end
      end
    end
  end
  -- avenging_wrath,if=(holy_power>=4&time<5|holy_power>=3&(time>5|runeforge.the_magistrates_judgment)|holy_power>=2&runeforge.vanguards_momentum&talent.final_reckoning|talent.holy_avenger&cooldown.holy_avenger.remains=0)&(!talent.seraphim|!talent.final_reckoning|cooldown.seraphim.remains>0)
  if S.AvengingWrath:IsCastable() and ((Player:HolyPower() >= 4 and HL.CombatTime() < 5 or Player:HolyPower() >= 3 and (HL.CombatTime() > 5 or MagistratesJudgmentEquipped) or Player:HolyPower() >= 2 and VanguardsMomentumEquipped and S.FinalReckoning:IsAvailable() or S.HolyAvenger:IsAvailable() and S.HolyAvenger:CooldownUp()) and ((not S.Seraphim:IsAvailable()) or (not S.FinalReckoning:IsAvailable()) or S.Seraphim:CooldownDown())) then
    if Cast(S.AvengingWrath, Settings.Retribution.OffGCDasOffGCD.AvengingWrath) then return "avenging_wrath cooldowns 74" end
  end
  -- crusade,if=holy_power>=4&time<5|holy_power>=3&time>5
  if S.Crusade:IsCastable() and (Player:HolyPower() >= 4 and HL.CombatTime() < 5 or Player:HolyPower() >= 3 and HL.CombatTime() >= 5) then
    if Cast(S.Crusade, Settings.Retribution.OffGCDasOffGCD.AvengingWrath) then return "crusade cooldowns 76" end
  end
  -- ashen_hallow
  if S.AshenHallow:IsCastable() then
    if Cast(S.AshenHallow, nil, Settings.Commons.DisplayStyle.Signature, not Target:IsInRange(30)) then return "ashen_hallow cooldowns 78" end
  end
  -- holy_avenger,if=time_to_hpg=0&holy_power<=2&(buff.avenging_wrath.up|talent.crusade&(cooldown.crusade.remains=0|buff.crusade.up)|fight_remains<20)
  if S.HolyAvenger:IsCastable() and (TimeToHPG <= Player:GCDRemains() and Player:HolyPower() <= 2 and (Player:BuffUp(S.AvengingWrath) or S.Crusade:IsAvailable() and (S.Crusade:CooldownUp() or Player:BuffUp(S.CrusadeBuff)) or FightRemains < 20)) then
    if Cast(S.HolyAvenger) then return "holy_avenger cooldowns 80" end
  end
  -- final_reckoning,if=(holy_power>=4&time<8|holy_power>=3&(time>=8|spell_targets.divine_storm>=2&covenant.kyrian))&(cooldown.avenging_wrath.remains>gcd|cooldown.crusade.remains&(!buff.crusade.up|buff.crusade.stack>=10))&(time_to_hpg>0|holy_power=5)&(!talent.seraphim|buff.seraphim.up)&(!raid_event.adds.exists|raid_event.adds.up|raid_event.adds.in>40)&(!buff.avenging_wrath.up|holy_power=5|cooldown.hammer_of_wrath.remains|spell_targets.divine_storm>=2&covenant.kyrian)
  if S.FinalReckoning:IsCastable() and Target:IsInRange(8) and ((Player:HolyPower() >= 4 and HL.CombatTime() < 8 or Player:HolyPower() >= 3 and (HL.CombatTime() >= 8 or #Enemies10y >= 2 and CovenantID == 1)) and (S.AvengingWrath:CooldownRemains() > Player:GCD() or S.Crusade:CooldownDown() and (Player:BuffDown(S.CrusadeBuff) or Player:BuffStack(S.CrusadeBuff) >= 10)) and (TimeToHPG > 0 or Player:HolyPower() == 5) and ((not S.Seraphim:IsAvailable()) or Player:BuffUp(S.Seraphim)) and (Player:BuffDown(S.AvengingWrathBuff) or Player:HolyPower() == 5 or S.HammerofWrath:CooldownDown() or #Enemies10y >= 2 and CovenantID == 1)) then
    if Cast(S.FinalReckoning) then return "final_reckoning cooldowns 82" end
  end
end

local function Finishers()
  -- variable,name=ds_castable,value=spell_targets.divine_storm>=2|buff.empyrean_power.up&!debuff.judgment.up&!buff.divine_purpose.up
  VarDSCastable = (divinestormrange
  and AoEON() 
  or Player:BuffUp(S.EmpyreanPowerBuff) 
  and Target:DebuffDown(S.JudgmentDebuff)
   and Player:BuffDown(S.DivinePurposeBuff))
  -- seraphim,if=(cooldown.avenging_wrath.remains>15|cooldown.crusade.remains>15)&!talent.final_reckoning&(!talent.execution_sentence|spell_targets.divine_storm>=5)&(!raid_event.adds.exists|raid_event.adds.in>40|raid_event.adds.in<gcd|raid_event.adds.up)&(!covenant.kyrian|cooldown.divine_toll.remains<9)|fight_remains<15&fight_remains>5|buff.crusade.up&buff.crusade.stack<10
  if S.Seraphim:IsReady() and ((S.AvengingWrath:CooldownRemains() > 15 or S.Crusade:CooldownRemains() > 15) and (not S.FinalReckoning:IsAvailable()) and ((not S.ExecutionSentence:IsAvailable()) or #Enemies10y >= 5) and (CovenantID ~= 1 or S.DivineToll:CooldownRemains() < 9) or FightRemains < 15 and FightRemains > 5 or Player:BuffUp(S.CrusadeBuff) and Player:BuffStack(S.CrusadeBuff) < 10) then
    if Cast(S.Seraphim, Settings.Retribution.GCDasOffGCD.Seraphim) then return "seraphim finishers 2" end
  end
  -- execution_sentence,if=(buff.crusade.down&cooldown.crusade.remains>10|buff.crusade.stack>=3|cooldown.avenging_wrath.remains>10)&(!talent.final_reckoning|cooldown.final_reckoning.remains>10)&target.time_to_die>8&(spell_targets.divine_storm<5|talent.executioners_wrath)
  if S.ExecutionSentence:IsReady() and ((Player:BuffDown(S.CrusadeBuff) and S.Crusade:CooldownRemains() > 10 or Player:BuffStack(S.CrusadeBuff) >= 3 or S.AvengingWrath:CooldownRemains() > 10) and ((not S.FinalReckoning:IsAvailable()) or S.FinalReckoning:CooldownRemains() > 10) and Target:TimeToDie() > 8 and (#Enemies10y < 5 or S.ExecutionersWrath:IsAvailable())) then
    if Cast(S.ExecutionSentence, Settings.Retribution.GCDasOffGCD.ExecutionSentence, nil, not Target:IsSpellInRange(S.ExecutionSentence)) then return "execution_sentence finishers 4" end
  end
  -- radiant_decree,if=(buff.crusade.down&cooldown.crusade.remains>5|buff.crusade.stack>=3|cooldown.avenging_wrath.remains>5)&(!talent.final_reckoning|cooldown.final_reckoning.remains>5)
  if  IsUsableSpell('Radiant Decree') and Target:IsInRange(8) and S.RadiantDecree:CooldownUp() and ((Player:BuffDown(S.CrusadeBuff) and S.Crusade:CooldownRemains() > 5 or Player:BuffStack(S.CrusadeBuff) >= 3 or S.AvengingWrath:CooldownRemains() > 5) and ((not S.FinalReckoning:IsAvailable()) or S.FinalReckoning:CooldownRemains() > 5)) then
    if Cast(S.RadiantDecree, nil, nil, not Target:IsInMeleeRange(12)) then return "radiant_decree finishers 6"; end
  end
  -- divine_storm,if=variable.ds_castable&!buff.vanquishers_hammer.up&((!talent.crusade|cooldown.crusade.remains>gcd*3)&(!talent.execution_sentence|cooldown.execution_sentence.remains>gcd*6|cooldown.execution_sentence.remains>gcd*4&holy_power>=4|target.time_to_die<8|spell_targets.divine_storm>=5|!talent.seraphim&cooldown.execution_sentence.remains>gcd*2)&(!talent.final_reckoning|cooldown.final_reckoning.remains>gcd*6|cooldown.final_reckoning.remains>gcd*4&holy_power>=4|!talent.seraphim&cooldown.final_reckoning.remains>gcd*2)|talent.holy_avenger&cooldown.holy_avenger.remains<gcd*3|buff.holy_avenger.up|buff.crusade.up&buff.crusade.stack<10)
  if S.DivineStorm:IsReady() and (VarDSCastable and Player:BuffDown(S.VanquishersHammer) 
  and (((not S.Crusade:IsAvailable()) or S.Crusade:CooldownRemains() > Player:GCD() * 3) 
  and ((not S.ExecutionSentence) or S.ExecutionSentence:CooldownRemains() > Player:GCD() * 6 or S.ExecutionSentence:CooldownRemains() > Player:GCD() * 4 
  and Player:HolyPower() >= 4 or Target:TimeToDie() < 8 or #Enemies10y >= 5 or (not S.Seraphim:IsAvailable()) and S.ExecutionSentence:CooldownRemains() > Player:GCD() * 2) and ((not S.FinalReckoning:IsAvailable()) or S.FinalReckoning:CooldownRemains() > Player:GCD() * 6 or S.FinalReckoning:CooldownRemains() > Player:GCD() * 4 and Player:HolyPower() >= 4 or (not S.Seraphim:IsAvailable()) and S.FinalReckoning:CooldownRemains() > Player:GCD() * 2) or S.HolyAvenger:IsAvailable() and S.HolyAvenger:CooldownRemains() < Player:GCD() * 3 or Player:BuffUp(S.HolyAvenger) or Player:BuffUp(S.CrusadeBuff) and Player:BuffStack(S.CrusadeBuff) < 10)) then
    if Cast(S.DivineStorm) then return "divine_storm finishers 8" end
  end
  -- templars_verdict,if=(!talent.crusade|cooldown.crusade.remains>gcd*3)&(!talent.execution_sentence|cooldown.execution_sentence.remains>gcd*6|cooldown.execution_sentence.remains>gcd*4&holy_power>=4|target.time_to_die<8|!talent.seraphim&cooldown.execution_sentence.remains>gcd*2)&(!talent.final_reckoning|cooldown.final_reckoning.remains>gcd*6|cooldown.final_reckoning.remains>gcd*4&holy_power>=4|!talent.seraphim&cooldown.final_reckoning.remains>gcd*2)|talent.holy_avenger&cooldown.holy_avenger.remains<gcd*3|buff.holy_avenger.up|buff.crusade.up&buff.crusade.stack<10
  if VerdictSpell:IsReady() and Target:IsInRange(8) and  (((not S.Crusade:IsAvailable()) 
  or S.Crusade:CooldownRemains() > Player:GCD() * 3) 
  and ((not S.ExecutionSentence:IsAvailable()) 
  or S.ExecutionSentence:CooldownRemains() > Player:GCD() * 6 
  or S.ExecutionSentence:CooldownRemains() > Player:GCD() * 4 
  and Player:HolyPower() >= 4 or Target:TimeToDie() < 8 
  or (not S.Seraphim:IsAvailable()) and S.ExecutionSentence:CooldownRemains() > Player:GCD() * 2) 
  and ((not S.FinalReckoning:IsAvailable()) or S.FinalReckoning:CooldownRemains() > Player:GCD() * 6 
  or S.FinalReckoning:CooldownRemains() > Player:GCD() * 4 and Player:HolyPower() >= 4 or (not S.Seraphim:IsAvailable()) and S.FinalReckoning:CooldownRemains() > Player:GCD() * 2) or S.HolyAvenger:IsAvailable() and S.HolyAvenger:CooldownRemains() < Player:GCD() * 3 or Player:BuffUp(S.HolyAvenger) or Player:BuffUp(S.CrusadeBuff) and Player:BuffStack(S.CrusadeBuff) < 10) then
    return Cast(VerdictSpell) 
  end
end

local function Generators()
  -- call_action_list,name=finishers,if=holy_power=5|(debuff.judgment.up|holy_power=4)&buff.divine_resonance.up|buff.holy_avenger.up
  if (Player:HolyPower() >= 5 or (Target:DebuffUp(S.JudgmentDebuff) or Player:HolyPower() == 4) and Player:BuffUp(S.DivineResonanceBuff) or Player:BuffUp(S.HolyAvenger)) then
    local ShouldReturn = Finishers(); if ShouldReturn then return ShouldReturn; end
  end
  -- vanquishers_hammer,if=!runeforge.dutybound_gavel|!talent.final_reckoning&!talent.execution_sentence|fight_remains<8
  if S.VanquishersHammer:IsCastable() and Target:IsInRange(15) and ((not DutyboundGavelEquipped) or (not S.FinalReckoning:IsAvailable()) and (not S.ExecutionSentence:IsAvailable()) or FightRemains < 8) then
    if Cast(S.VanquishersHammer, nil, Settings.Commons.DisplayStyle.Signature, not Target:IsSpellInRange(S.VanquishersHammer)) then return "vanquishers_hammer generators 2"; end
  end
  -- hammer_of_wrath,if=runeforge.the_mad_paragon|covenant.venthyr&cooldown.ashen_hallow.remains>210
  if S.HammerofWrath:IsReady() and Target:IsInRange(30) and (MadParagonEquipped or CovenantID == 2 and S.AshenHallow:CooldownRemains() > 210) then
    if Cast(S.HammerofWrath, nil, Settings.Retribution.GCDasOffGCD.HammerOfWrath, not Target:IsSpellInRange(S.HammerofWrath)) then return "hammer_of_wrath generators 4"; end
  end
  -- wake_of_ashes,if=holy_power<=2&talent.ashes_to_dust&(cooldown.avenging_wrath.remains|cooldown.crusade.remains)
  if S.WakeofAshes:IsCastable() and Target:IsInRange(5) and (Player:HolyPower() <= 2 and S.AshestoDust:IsAvailable() and (S.AvengingWrath:CooldownDown() or S.Crusade:CooldownDown())) then
    if Cast(S.WakeofAshes, nil, nil, not Target:IsInRange(12)) then return "wake_of_ashes generators 5"; end
  end
  -- divine_toll,if=holy_power<=2&!debuff.judgment.up&(!talent.seraphim|buff.seraphim.up)&(!raid_event.adds.exists|raid_event.adds.in>30|raid_event.adds.up)&!talent.final_reckoning&(!talent.execution_sentence|fight_remains<8|spell_targets.divine_storm>=5)&(cooldown.avenging_wrath.remains>15|cooldown.crusade.remains>15|fight_remains<8)
  if S.DivineToll:IsCastable() and CDsON() and Player:HolyPower() <= 2 and Target:IsInRange(15) and (Target:DebuffDown(S.JudgmentDebuff) and ((not S.Seraphim:IsAvailable()) or Player:BuffUp(S.Seraphim)) and (not S.FinalReckoning:IsAvailable()) and ((not S.ExecutionSentence) or FightRemains < 8 or #Enemies10y >= 5) and (S.AvengingWrath:CooldownRemains() > 15 or S.Crusade:CooldownRemains() > 15 or FightRemains < 8)) then
      if Cast(S.DivineToll) then return "divine_toll covenant generators 6"; end
    end
  
  -- judgment,if=!debuff.judgment.up&(holy_power>=1&runeforge.the_magistrates_judgment|holy_power>=2)
  if S.Judgment:IsCastable() and Target:IsInRange(30) and (Target:DebuffDown(S.JudgmentDebuff) and (Player:HolyPower() >= 1 and MagistratesJudgmentEquipped or Player:HolyPower() >= 2)) then
    if Cast(S.Judgment, nil, nil, not Target:IsSpellInRange(S.Judgment)) then return "judgment generators 8"; end
  end
  -- wake_of_ashes,if=(holy_power=0|holy_power<=2&cooldown.blade_of_justice.remains>gcd*2)&(!raid_event.adds.exists|raid_event.adds.in>20|raid_event.adds.up)&(!talent.seraphim|cooldown.seraphim.remains>5|covenant.kyrian)&(!talent.execution_sentence|cooldown.execution_sentence.remains>15|target.time_to_die<8|spell_targets.divine_storm>=5)&(!talent.final_reckoning|cooldown.final_reckoning.remains>15|fight_remains<8)&(cooldown.avenging_wrath.remains|cooldown.crusade.remains)
  if S.WakeofAshes:IsCastable() and CDsON() and Target:IsInRange(5) and ((Player:HolyPower() == 0 or Player:HolyPower() <= 2 and S.BladeofJustice:CooldownRemains() > Player:GCD() * 2) and ((not S.Seraphim:IsAvailable()) or S.Seraphim:CooldownRemains() > 5 or CovenantID == 1) and ((not S.ExecutionSentence:IsAvailable()) or S.ExecutionSentence:CooldownRemains() > 15 or Target:TimeToDie() < 8 or #Enemies10y >= 5) and ((not S.FinalReckoning:IsAvailable()) or S.FinalReckoning:CooldownRemains() > 15 or FightRemains < 8) and (S.AvengingWrath:CooldownDown() or S.Crusade:CooldownDown())) then
    if Cast(S.WakeofAshes) then return "wake_of_ashes generators 10"; end
  end
  -- call_action_list,name=finishers,if=holy_power>=3&buff.crusade.up&buff.crusade.stack<10
  if (Player:HolyPower() >= 3 and Player:BuffUp(S.CrusadeBuff) and Player:BuffStack(S.CrusadeBuff) < 10) and Target:IsInRange(8) then
    local ShouldReturn = Finishers(); if ShouldReturn then return ShouldReturn; end
  end
  -- exorcism
  if S.Exorcism:IsCastable() and Target:IsInRange(30) then
    if Cast(S.Exorcism) then return "exorcism generators 12"; end
  end
  -- blade_of_justice,if=conduit.expurgation&holy_power<=3
  if S.BladeofJustice:IsCastable() and (S.Expurgation:ConduitEnabled() and Player:HolyPower() <= 3) and Target:IsInRange(12) then
    if Cast(S.BladeofJustice, nil, nil, not Target:IsSpellInRange(S.BladeofJustice)) then return "blade_of_justice generators 12"; end
  end
  -- judgment,if=!debuff.judgment.up
  if S.Judgment:IsCastable() and (Target:DebuffDown(S.JudgmentDebuff)) and Target:IsInRange(30) then
    if Cast(S.Judgment, nil, nil, not Target:IsSpellInRange(S.Judgment)) then return "judgment generators 14"; end
  end
  -- hammer_of_wrath
  if S.HammerofWrath:IsReady() and Target:IsInRange(30) then
    if Cast(S.HammerofWrath, Settings.Retribution.GCDasOffGCD.HammerOfWrath, nil, not Target:IsSpellInRange(S.HammerofWrath)) then return "hammer_of_wrath generators 16"; end
  end
  -- blade_of_justice,if=holy_power<=3
  if S.BladeofJustice:IsCastable() and (Player:HolyPower() <= 3) and Target:IsInRange(12) then
    if Cast(S.BladeofJustice, nil, nil, not Target:IsSpellInRange(S.BladeofJustice)) then return "blade_of_justice generators 18"; end
  end
  -- call_action_list,name=finishers,if=(target.health.pct<=20|buff.avenging_wrath.up|buff.crusade.up|buff.empyrean_power.up)
  if (Target:HealthPercentage() <= 20 or Player:BuffUp(S.AvengingWrathBuff) or Player:BuffUp(S.CrusadeBuff) or Player:BuffUp(S.EmpyreanPowerBuff)) then
    local ShouldReturn = Finishers(); if ShouldReturn then return ShouldReturn; end
  end
  -- consecration,if=!consecration.up&spell_targets.divine_storm>=2
  if S.Consecration:IsCastable() and (Target:DebuffDown(S.ConsecrationDebuff) and (#Enemies10y >= 2 or Target:IsInRange(8))) then
    if Cast(S.Consecration, nil, nil, not Target:IsInMeleeRange(8)) then return "consecration generators 20"; end
  end
  -- crusader_strike,if=cooldown.crusader_strike.charges_fractional>=1.75&(holy_power<=2|holy_power<=3&cooldown.blade_of_justice.remains>gcd*2|holy_power=4&cooldown.blade_of_justice.remains>gcd*2&cooldown.judgment.remains>gcd*2)
  if S.CrusaderStrike:IsCastable() and Target:IsInRange(8) and (S.CrusaderStrike:ChargesFractional() >= 1.75 and (Player:HolyPower() <= 2 or Player:HolyPower() <= 3 and S.BladeofJustice:CooldownRemains() > Player:GCD() * 2 or Player:HolyPower() == 4 and S.BladeofJustice:CooldownRemains() > Player:GCD() * 2 and S.Judgment:CooldownRemains() > Player:GCD() * 2)) then
    if Cast(S.CrusaderStrike, nil, nil, not Target:IsInMeleeRange(5)) then return "crusader_strike generators 22"; end
  end
  -- call_action_list,name=finishers
  local ShouldReturn = Finishers(); if ShouldReturn then return ShouldReturn; end
  -- consecration,if=!consecration.up
  if S.Consecration:IsCastable() and (Target:DebuffDown(S.ConsecrationDebuff)and (#Enemies10y >= 1 or Target:IsInRange(8))) then
    if Cast(S.Consecration, nil, nil, not Target:IsInMeleeRange(8)) then return "consecration generators 24"; end
  end
  -- crusader_strike
  if S.CrusaderStrike:IsCastable() and Target:IsInRange(8) then
    if Cast(S.CrusaderStrike, nil, nil, not Target:IsInMeleeRange(5)) then return "crusader_strike generators 26"; end
  end
  -- arcane_torrent
  if S.ArcaneTorrent:IsCastable() then
    if Cast(S.ArcaneTorrent, Settings.Commons.OffGCDasOffGCD.Racials, nil, not Target:IsInRange(8)) then return "arcane_torrent generators 28"; end
  end
  -- consecration
  if S.Consecration:IsCastable() and (#Enemies10y >= 1 or Target:IsInRange(8)) then
    if Cast(S.Consecration, nil, nil, not Target:IsInMeleeRange(8)) then return "consecration generators 30"; end
  end
end

local function ESFRPooling()
  -- seraphim,if=holy_power=5&(!talent.final_reckoning|cooldown.final_reckoning.remains<=gcd*3)&(!talent.execution_sentence|cooldown.execution_sentence.remains<=gcd*3|talent.final_reckoning)&(!covenant.kyrian|cooldown.divine_toll.remains<9)
  if S.Seraphim:IsReady() and (Player:HolyPower() == 5 and ((not S.FinalReckoning:IsAvailable()) or S.FinalReckoning:CooldownRemains() <= Player:GCD() * 3) and ((not S.ExecutionSentence:IsAvailable()) or S.ExecutionSentence:CooldownRemains() <= Player:GCD() * 3 or S.FinalReckoning:IsAvailable()) and (CovenantID ~= 1 or S.DivineToll:CooldownRemains() < 9)) then
    if Cast(S.Seraphim, Settings.Retribution.GCDasOffGCD.Seraphim) then return "seraphim es_fr_pooling 2"; end
  end
  -- call_action_list,name=finishers,if=holy_power=5|debuff.final_reckoning.up|buff.crusade.up&buff.crusade.stack<10
  if (Player:HolyPower() == 5 or Target:DebuffUp(S.FinalReckoning) or Player:BuffUp(S.CrusadeBuff) and Player:BuffStack(S.CrusadeBuff) < 10) then
    local ShouldReturn = Finishers(); if ShouldReturn then return ShouldReturn; end
  end
  -- vanquishers_hammer,if=buff.seraphim.up
  if S.VanquishersHammer:IsCastable() and (Player:BuffUp(S.Seraphim)) then
    if Cast(S.VanquishersHammer, nil, Settings.Commons.DisplayStyle.Signature, not Target:IsSpellInRange(S.VanquishersHammer)) then return "vanquishers_hammer es_fr_pooling 4"; end
  end
  -- hammer_of_wrath,if=runeforge.vanguards_momentum
  if S.HammerofWrath:IsReady() and (VanguardsMomentumEquipped) then
    if Cast(S.HammerofWrath, Settings.Retribution.GCDasOffGCD.HammerOfWrath, nil, not Target:IsSpellInRange(S.HammerofWrath)) then return "hammer_of_wrath es_fr_pooling 6"; end
  end
  -- wake_of_ashes,if=holy_power<=2&talent.ashes_to_dust&(cooldown.crusade.remains|cooldown.avenging_wrath.remains)
  if S.WakeofAshes:IsCastable() and (Player:HolyPower() <=2 and S.AshestoDust:IsAvailable() and (S.Crusade:CooldownDown() or S.AvengingWrath:CooldownDown())) then
    if Cast(S.WakeofAshes, nil, nil, not Target:IsInRange(12)) then return "wake_of_ashes es_fr_pooling 7"; end
  end
  -- blade_of_justice,if=holy_power<=3
  if S.BladeofJustice:IsCastable() and (Player:HolyPower() <= 3) then
    if Cast(S.BladeofJustice, nil, nil, not Target:IsSpellInRange(S.BladeofJustice)) then return "blade_of_justice es_fr_pooling 8"; end
  end
  -- judgment,if=!debuff.judgment.up
  if S.Judgment:IsCastable() and (Target:DebuffDown(S.JudgmentDebuff)) then
    if Cast(S.Judgment, nil, nil, not Target:IsSpellInRange(S.Judgment)) then return "judgment es_fr_pooling 10"; end
  end
  -- hammer_of_wrath
  if S.HammerofWrath:IsReady() then
    if Cast(S.HammerofWrath, Settings.Retribution.GCDasOffGCD.HammerOfWrath, nil, not Target:IsSpellInRange(S.HammerofWrath)) then return "hammer_of_wrath es_fr_pooling 12"; end
  end
  -- crusader_strike,if=cooldown.crusader_strike.charges_fractional>=1.75&(holy_power<=2|holy_power<=3&cooldown.blade_of_justice.remains>gcd*2|holy_power=4&cooldown.blade_of_justice.remains>gcd*2&cooldown.judgment.remains>gcd*2)
  if S.CrusaderStrike:IsCastable() and (S.CrusaderStrike:ChargesFractional() >= 1.75 and (Player:HolyPower() <= 2 or Player:HolyPower() <= 3 and S.BladeofJustice:CooldownRemains() > Player:GCD() * 2 or Player:HolyPower() == 4 and S.BladeofJustice:CooldownRemains() > Player:GCD() * 2 and S.Judgment:CooldownRemains() > Player:GCD() * 2)) then
    if Cast(S.CrusaderStrike, nil, nil, not Target:IsInMeleeRange(5)) then return "crusader_strike es_fr_pooling 14"; end
  end
  -- seraphim,if=!talent.final_reckoning&cooldown.execution_sentence.remains<=gcd*3&(!covenant.kyrian|cooldown.divine_toll.remains<9)
  if S.Seraphim:IsReady() and ((not S.FinalReckoning:IsAvailable()) and S.ExecutionSentence:CooldownRemains() <= Player:GCD() * 3 and (CovenantID ~= 1 or S.DivineToll:CooldownRemains() < 9)) then
    if Cast(S.Seraphim, Settings.Retribution.GCDasOffGCD.Seraphim) then return "seraphim es_fr_pooling 16"; end
  end
  -- call_action_list,name=finishers
  local ShouldReturn = Finishers(); if ShouldReturn then return ShouldReturn; end
  -- crusader_strike
  if S.CrusaderStrike:IsCastable() then
    if Cast(S.CrusaderStrike, nil, nil, not Target:IsInMeleeRange(5)) then return "crusader_strike es_fr_pooling 18"; end
  end
  -- arcane_torrent,if=holy_power<=4
  if S.ArcaneTorrent:IsCastable() and (Player:HolyPower() <= 4) then
    if Cast(S.ArcaneTorrent, Settings.Commons.OffGCDasOffGCD.Racials, nil, not Target:IsInRange(8)) then return "arcane_torrent es_fr_pooling 20"; end
  end
  -- exorcism
  if S.Exorcism:IsCastable() then
    if Cast(S.Exorcism) then return "exorcism es_fr_pooling 22"; end
  end
  -- seraphim,if=(!talent.final_reckoning|cooldown.final_reckoning.remains<=gcd*3)&(!talent.execution_sentence|cooldown.execution_sentence.remains<=gcd*3|talent.final_reckoning)&(!covenant.kyrian|cooldown.divine_toll.remains<9)
  if S.Seraphim:IsReady() and (((not S.FinalReckoning:IsAvailable()) or S.FinalReckoning:CooldownRemains() <= Player:GCD() * 3) and ((not S.ExecutionSentence:IsAvailable()) or S.ExecutionSentence:CooldownRemains() <= Player:GCD() * 3 or S.FinalReckoning:IsAvailable()) and (CovenantID ~= 1 or S.DivineToll:CooldownRemains() < 9)) then
    if Cast(S.Seraphim, Settings.Retribution.GCDasOffGCD.Seraphim) then return "seraphim es_fr_pooling 24"; end
  end
  -- consecration
  if S.Consecration:IsCastable() then
    if Cast(S.Consecration, nil, nil, not Target:IsInMeleeRange(8)) then return "consecration es_fr_pooling 26"; end
  end
end

local function ESFRActive()
  -- fireblood
  -- if S.Fireblood:IsCastable() then
  --   if Cast(S.Fireblood, Settings.Commons.OffGCDasOffGCD.Racials) then return "fireblood es_fr_active 2"; end
  -- end
  -- call_action_list,name=finishers,if=holy_power=5|debuff.judgment.up|debuff.final_reckoning.up&(debuff.final_reckoning.remains<gcd.max|spell_targets.divine_storm>=2&!talent.execution_sentence)|debuff.execution_sentence.up&debuff.execution_sentence.remains<gcd.max
  if (Player:HolyPower() == 5 or Target:DebuffUp(S.JudgmentDebuff) or Target:DebuffUp(S.FinalReckoning) and (Target:DebuffRemains(S.FinalReckoning) < Player:GCD() + 0.5 or #Enemies10y >= 2 and not S.ExecutionSentence:IsAvailable()) or Target:DebuffUp(S.ExecutionSentence) and Target:DebuffRemains(S.ExecutionSentence) < Player:GCD() + 0.5) then
    local ShouldReturn = Finishers(); if ShouldReturn then return ShouldReturn; end
  end
  -- divine_toll,if=holy_power<=2
  if S.DivineToll:IsCastable() and CDsON() and Player:HolyPower() <= 2 and Target:IsInRange(12) then
    if Cast(S.DivineToll) then return "divine_toll es_fr_active 4"; end
  end
  -- vanquishers_hammer
  if S.VanquishersHammer:IsCastable() then
    if Cast(S.VanquishersHammer, nil, Settings.Commons.DisplayStyle.Signature, not Target:IsSpellInRange(S.VanquishersHammer)) then return "vanquishers_hammer es_fr_active 6"; end
  end
  -- wake_of_ashes,if=holy_power<=2&(debuff.final_reckoning.up&debuff.final_reckoning.remains<gcd*2&!runeforge.divine_resonance|debuff.execution_sentence.up&debuff.execution_sentence.remains<gcd|spell_targets.divine_storm>=5&runeforge.divine_resonance&talent.execution_sentence)
  if S.WakeofAshes:IsCastable() and (Player:HolyPower() <= 2 and (Target:DebuffUp(S.FinalReckoning) and Target:DebuffRemains(S.FinalReckoning) < Player:GCD() * 2 and (not DivineResonanceEquipped) or Target:DebuffUp(S.ExecutionSentence) and Target:DebuffRemains(S.ExecutionSentence) < Player:GCD() or #Enemies10y >= 5 and DivineResonanceEquipped and S.ExecutionSentence:IsAvailable())) then
    if Cast(S.WakeofAshes, nil, nil, not Target:IsInRange(12)) then return "wake_of_ashes es_fr_active 8"; end
  end
  -- blade_of_justice,if=conduit.expurgation&(!runeforge.divine_resonance&holy_power<=3|holy_power<=2)
  if S.BladeofJustice:IsCastable() and (S.Expurgation:ConduitEnabled() and ((not DivineResonanceEquipped) and Player:HolyPower() <= 3 or Player:HolyPower() <= 2)) then
    if Cast(S.BladeofJustice, nil, nil, not Target:IsSpellInRange(S.BladeofJustice)) then return "blade_of_justice es_fr_active 10"; end
  end
  -- judgment,if=!debuff.judgment.up&(holy_power>=1&runeforge.the_magistrates_judgment|holy_power>=2)
  if S.Judgment:IsCastable() and (Target:DebuffDown(S.JudgmentDebuff) and (Player:HolyPower() >= 1 and MagistratesJudgmentEquipped or Player:HolyPower() >= 2)) then
    if Cast(S.Judgment, nil, nil, not Target:IsSpellInRange(S.Judgment)) then return "judgment es_fr_active 12"; end
  end
  -- call_action_list,name=finishers
  local ShouldReturn = Finishers(); if ShouldReturn then return ShouldReturn; end
  -- wake_of_ashes,if=holy_power<=2
  if S.WakeofAshes:IsCastable() and (Player:HolyPower() <= 2) and Target:IsInRange(5) then
    if Cast(S.WakeofAshes, nil, nil, not Target:IsInRange(12)) then return "wake_of_ashes es_fr_active 14"; end
  end
  -- blade_of_justice,if=holy_power<=3
  if S.BladeofJustice:IsCastable() and (Player:HolyPower() <= 3) then
    if Cast(S.BladeofJustice, nil, nil, not Target:IsSpellInRange(S.BladeofJustice)) then return "blade_of_justice es_fr_active 16"; end
  end
  -- judgment,if=!debuff.judgment.up
  if S.Judgment:IsCastable() and (Target:DebuffDown(S.Judgment)) then
    if Cast(S.Judgment, nil, nil, not Target:IsSpellInRange(S.Judgment)) then return "judgment es_fr_active 18"; end
  end
  -- hammer_of_wrath
  if S.HammerofWrath:IsReady() then
    if Cast(S.HammerofWrath, Settings.Retribution.GCDasOffGCD.HammerOfWrath, nil, not Target:IsSpellInRange(S.HammerofWrath)) then return "hammer_of_wrath es_fr_active 20"; end
  end
  -- crusader_strike
  if S.CrusaderStrike:IsCastable() then
    if Cast(S.CrusaderStrike, nil, nil, not Target:IsInMeleeRange(5)) then return "crusader_strike es_fr_active 22"; end
  end
  -- arcane_torrent
  if S.ArcaneTorrent:IsCastable() then
    if Cast(S.ArcaneTorrent, Settings.Commons.OffGCDasOffGCD.Racials, nil, not Target:IsInRange(8)) then return "arcane_torrent es_fr_active 24"; end
  end
  -- exorcism
  if S.Exorcism:IsCastable() then
    if Cast(S.Exorcism) then return "exorcism es_fr_active 26"; end
  end
  -- consecration
  if S.Consecration:IsCastable() then
    if Cast(S.Consecration, nil, nil, not Target:IsInMeleeRange(8)) then return "consecration es_fr_active 28"; end
  end
end

--- ======= MAIN =======
local function APL()
  Enemies8y = Player:GetEnemiesInRange(8) 
  Enemies10y = Player:GetEnemiesInRange(10) 
  Enemies15y = Player:GetEnemiesInRange(15) 

  -- Enemies Update
  if AoEON() then
    if S.tempestofthelightbringer:IsAvailable() then
      divinestormrange = #Enemies15y>=2 and Target:IsInRange(10) 
    else
      divinestormrange = #Enemies10y>=2 and Target:IsInRange(8) 
    end
    
  end

  if S.RetributionAura:IsCastable() and MissingAura() then
   return Cast(S.RetributionAura) 
   end
 


  Enemies20y = Player:GetEnemiesInRange(20)


 -- Rotation Variables Update
  TimeToHPG = ComputeTimeToHPG()

  if Everyone.TargetIsValid() or Player:AffectingCombat() then
    -- Calculate fight_remains
    BossFightRemains = HL.BossFightRemains(nil, true)
    FightRemains = BossFightRemains
    if FightRemains == 11111 then
      FightRemains = HL.FightRemains(Enemies8y, false)
    end
  end
  if (Player:IsCasting() or Player:IsChanneling()) then return HR.Cast(S.channeling) end
--BURST
if S.Crusade:IsReady() and S.CrusadeTalent:IsAvailable() and #Enemies10y>=2 and CDsON() and Player:HolyPower()>2 then
  return Cast(S.Crusade) 
  end
  if S.AvengingWrath:IsReady() and not S.CrusadeTalent:IsAvailable() and #Enemies10y>=2 and CDsON() then
    return Cast(S.AvengingWrath) 
    end



  if S.Judgment:IsReady() and #Enemies10y>=2 and Target:DebuffDown(S.JudgmentDebuff)  then
    return Cast(S.Judgment) 
    end

   
if S.FinalReckoning:IsReady() and #Enemies8y>=2 and CDsON() and AoEON() and Target:DebuffUp(S.JudgmentDebuff) and (Player:BuffUp(S.AvengingWrathBuff) or Player:BuffUp(S.CrusadeBuff)) then
  return Cast(S.FinalReckoning) 
  end
  
    if S.DivineToll:IsReady() and #Enemies10y>=2 and Target:DebuffDown(S.JudgmentDebuff) and Player:HolyPower()<=2 and S.Judgment:CooldownRemains()>Player:GCD() then
      return Cast(S.DivineToll) 
      end
      if S.Consecration:IsReady() and #Enemies10y>=3 and Target:DebuffDown(S.ConsecrationDebuff)  then
        return Cast(S.Consecration) 
        end
  if S.RadiantDecree:IsReady() and #Enemies10y>=2 then
    return Cast(S.RadiantDecree) 
    end
    if S.Seraphim:IsReady() and #Enemies10y>=2 then
      return Cast(S.Seraphim) 
      end
  if S.DivineStorm:IsReady() and #Enemies15y>=2 and (S.RadiantDecree:CooldownRemains()>Player:GCD() or S.WakeofAshes:CooldownRemains()>Player:GCD()) then
    return Cast(S.DivineStorm) 
    end




  -- if I.trinket:IsReady() and Target:IsInRange(12) and I.trinket:IsEquipped() and RubimRH.CDsON() then
  --   return S.trinket:Cast()
  --   end	 

  if Player:HealthPercentage() < 40 and Player:AffectingCombat() and IsUsableItem(187802) and GetItemCooldown(187802) == 0 and GetItemCount(187802) >= 1 
then Cast(I.potion) end


  if S.ShieldofVengeance:IsCastable() and Player:HealthPercentage() <= 65 and Player:AffectingCombat() then
    return Cast(S.ShieldofVengeance)  
  end
  




  -- if S.FlashofLight:IsCastable() and (Player:InArena() or Player:InBattlegrounds()) and Player:HealthPercentage() < 50  and Player:BuffStack(S.SelfLessHealerBuff)==4  then
  --   if Cast(S.FlashofLight) then return "Queue Spell Sent"; end
  -- end

  -- if S.FlashofLight:ID() ==  HR.queuedSpell[1]:ID() and Player:BuffStack(S.SelfLessHealerBuff)<4 then
  -- HR.queuedSpell = { HR.Spell[1].Empty, 0 }
  -- end


  if  S.DivineShield:ID() ==  HR.queuedSpell[1]:ID() and Player:DebuffUp(S.Forbearance) then
  HR.queuedSpell = { HR.Spell[1].Empty, 0 }
  end

  if  S.BlessingofProtection:ID() ==  HR.queuedSpell[1]:ID() and Player:DebuffUp(S.Forbearance) then
  HR.queuedSpell = { HR.Spell[1].Empty, 0 }
  end

  if  S.LayonHands:ID() ==  HR.queuedSpell[1]:ID() and Player:DebuffUp(S.Forbearance) or S.LayonHands:ID() ==  HR.queuedSpell[1]:ID() and Player:InArena() then
  HR.queuedSpell = { HR.Spell[1].Empty, 0 }
  end

  if  S.DivineSteed:ID() ==  HR.queuedSpell[1]:ID() and Player:BuffUp(S.DivineSteedBuff) then
  HR.queuedSpell = { HR.Spell[1].Empty, 0 }
  end

  if S.lustAT:ID() == HR.queuedSpell[1]:ID() and (Player:DebuffUp(S.lust1) or Player:DebuffUp(S.lust2) or Player:DebuffUp(S.lust3) or Player:DebuffUp(S.lust4) or Player:DebuffUp(S.lust5)) then
    HR.queuedSpell = { HR.Spell[1].Empty, 0 }
  end
  
  if S.lustAT:ID() == HR.queuedSpell[1]:ID() and not Player:DebuffUp(S.lust1) and not Player:DebuffUp(S.lust2) and not Player:DebuffUp(S.lust3) and not Player:DebuffUp(S.lust4) and not Player:DebuffUp(S.lust5) and (I.drums:IsReadyQueue()) then
    if Cast(S.lustAT) then return "Queue Spell Sent"; end
  end
  
  if S.Intercession:ID() == HR.queuedSpell[1]:ID() then
    if Cast(S.Intercessionz) then return "Queue Spell Sent"; end
  end
  
  if HR.QueuedSpell():IsReadyQueue() then
    if Cast(HR.QueuedSpell()) then return "Queue Spell Sent"; end
  end

	if not HR.queuedSpell[1]:CooldownUp() or #Enemies20y==0 or not Player:AffectingCombat() then
		HR.queuedSpell = { HR.Spell[1].Empty, 0 }
	end



  if Everyone.TargetIsValid() then

    if S.DivineToll:IsCastable() and CDsON() and Player:HolyPower() <= 2 and Target:IsInRange(12) and (Player:BuffUp(S.CrusadeBuff) or Player:BuffUp(S.AvengingWrathBuff) or S.Crusade:IsAvailable() and S.Crusade:CooldownRemains()>30 or not S.Crusade:IsAvailable() and S.AvengingWrath:CooldownRemains()>30 or #Enemies20y>3)  then
      return Cast(S.DivineToll) 
    end

    -- Precombat
    if not Player:AffectingCombat() then
      local ShouldReturn = Precombat(); if ShouldReturn then return ShouldReturn; end
    end
    -- auto_attack
    -- rebuke
    local ShouldReturn = Everyone.Interrupt(5, S.Rebuke, Settings.Commons.OffGCDasOffGCD.Rebuke, StunInterrupts) and Target:IsInRange(5) and Target:CastPercentage()>25 and Target:CastPercentage()<75; if ShouldReturn then return ShouldReturn; end
    -- call_action_list,name=cooldowns
    if (CDsON()) then
      local ShouldReturn = Cooldowns(); if ShouldReturn then return "Cooldowns: " .. ShouldReturn; end
    end
    -- call_action_list,name=es_fr_pooling,if=(!raid_event.adds.exists|raid_event.adds.up|raid_event.adds.in<9|raid_event.adds.in>30)&(talent.execution_sentence&cooldown.execution_sentence.remains<9&spell_targets.divine_storm<5|talent.final_reckoning&cooldown.final_reckoning.remains<9)&target.time_to_die>8
    if ((S.ExecutionSentence:IsAvailable() and S.ExecutionSentence:CooldownRemains() < 9 and #Enemies10y < 5 or S.FinalReckoning:IsAvailable() and S.FinalReckoning:CooldownRemains() < 9) and Target:TimeToDie() > 8) then
      local ShouldReturn = ESFRPooling(); if ShouldReturn then return ShouldReturn; end
    end
    -- call_action_list,name=es_fr_active,if=debuff.execution_sentence.up|debuff.final_reckoning.up
    if (Target:DebuffUp(S.ExecutionSentence) or Target:DebuffUp(S.FinalReckoning)) then
      local ShouldReturn = ESFRActive(); if ShouldReturn then return ShouldReturn; end
    end

    if Target:IsInRange(30) and Player:AffectingCombat() then 
      if Generators() ~= nil then
          return Generators()
      end
    end


    -- -- call_action_list,name=generators
    -- local ShouldReturn = Generators(); if ShouldReturn then return ShouldReturn; end
    -- -- Manually added: Pooling, if nothing else to do

  end

  if  Player:IsMounted() then return HR.Cast(S.mounted)
  elseif Player:AffectingCombat() then
    return HR.Cast(S.combat)
  else
  return HR.Cast(S.MPI)
  end

end


HR.SetAPL(70, APL)
