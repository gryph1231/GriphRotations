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
local Boss       = Unit.Boss
local Pet        = Unit.Pet
local Spell      = HL.Spell
local Item       = HL.Item
-- HeroRotation
local HR         = HeroRotation
local Cast       = HR.Cast
local CDsON      = HR.CDsON
local AoEON      = HR.AoEON
-- lua
local tableinsert = table.insert

--- ============================ CONTENT ===========================
--- ======= APL LOCALS =======
-- luacheck: max_line_length 9999

-- Define S/I for spell and item arrays
local S = Spell.DeathKnight.Unholy
local I = Item.DeathKnight.Unholy

-- Create table to exclude above trinkets from On Use function
local OnUseExcludes = {
  --  I.TrinketName:ID(),
}

-- Trinket Item Objects
local equip = Player:GetEquipment()
local trinket1 = equip[13] and Item(equip[13]) or Item(0)
local trinket2 = equip[14] and Item(equip[14]) or Item(0)

-- Rotation Var
local ShouldReturn -- Used to get the return string
local no_heal

-- GUI Settings
local Everyone = HR.Commons.Everyone
local Settings = {
  General = HR.GUISettings.General,
  Commons = HR.GUISettings.APL.DeathKnight.Commons,
  Unholy = HR.GUISettings.APL.DeathKnight.Unholy
}

-- Variables
local VarApocTiming
local VarGargPooling
local VarFesterTracker
local VarBuildWounds
local VarPopWounds
local VarPoolingRunicPower
local VarPoolingRunes
local VarSTPlanning
local VarAddsRemain
local VarApocGhoulActive, VarApocGhoulRemains
local VarArmyGhoulActive, VarArmyGhoulRemains
local WoundSpender
local AnyDnD
local VarTrinket1Sync, VarTrinket2Sync
local VarTrinketPriority
local FesterStacks
local BossFightRemains = 11111
local FightRemains = 11111
local ghoul = HL.GhoulTable

-- Enemies Variables
local EnemiesMelee, EnemiesMeleeCount
local Enemies10ySplash, Enemies10ySplashCount
local EnemiesWithoutVP

-- Stun Interrupts List
local StunInterrupts = {
  {S.Asphyxiate, "Cast Asphyxiate (Interrupt)", function () return true; end},
}

-- Event Registrations
HL:RegisterForEvent(function()
  equip = Player:GetEquipment()
  trinket1 = equip[13] and Item(equip[13]) or Item(0)
  trinket2 = equip[14] and Item(equip[14]) or Item(0)
end, "PLAYER_EQUIPMENT_CHANGED")

HL:RegisterForEvent(function()
  BossFightRemains = 11111
  FightRemains = 11111
end, "PLAYER_REGEN_ENABLED")

--Functions
local function num(val)
  if val then return 1 else return 0 end
end

local function bool(val)
  return val ~= 0
end

local function DeathStrikeHeal()
  return (Settings.General.SoloMode and (Player:HealthPercentage() < Settings.Commons.UseDeathStrikeHP or Player:HealthPercentage() < Settings.Commons.UseDarkSuccorHP and Player:BuffUp(S.DeathStrikeBuff)))
end

local function UnitsWithoutVP(enemies)
  local WithoutVPCount = 0
  for _, CycleUnit in pairs(enemies) do
    if CycleUnit:DebuffDown(S.VirulentPlagueDebuff) then
      WithoutVPCount = WithoutVPCount + 1
    end
  end
  return WithoutVPCount
end

local function AddsFightRemains(enemies)
  local NonBossEnemies = {}
  for k in pairs(enemies) do
    if not Unit:IsInBossList(enemies[k]["UnitNPCID"]) then
      tableinsert(NonBossEnemies, enemies[k])
    end
  end
  return HL.FightRemains(NonBossEnemies)
end

local function EvaluateTargetIfFilterFWStack(TargetUnit)
  return (TargetUnit:DebuffStack(S.FesteringWoundDebuff))
end

local function EvaluateTargetIfApocalypse(TargetUnit)
  -- if=debuff.festering_wound.up&variable.adds_remain&!death_and_decay.ticking&cooldown.death_and_decay.remains&rune<3|death_and_decay.ticking&rune=0
  return (TargetUnit:DebuffUp(S.FesteringWoundDebuff) and VarAddsRemain and Player:BuffDown(S.DeathAndDecayBuff) and S.DeathAndDecay:CooldownRemains() < 3 or Player:BuffUp(S.DeathAndDecayBuff) and Player:Rune() == 0)
end

local function EvaluateTargetIfSoulReaper(TargetUnit)
  -- if=target.time_to_pct_35<5&active_enemies>=2&target.time_to_die>(dot.soul_reaper.remains+5)
  return (TargetUnit:TimeToX(35) < 5 and TargetUnit:TimeToDie() > (TargetUnit:DebuffRemains(S.SoulReaper) + 5))
end

local function EvaluateTargetIfFesteringStrike(TargetUnit)
  return (TargetUnit:DebuffStack(S.FesteringWoundDebuff) < 4)
end

local function EvaluateTargetIfUnholyAssault(TargetUnit)
  return (TargetUnit:DebuffStack(S.FesteringWoundDebuff) <= 2)
end

local function Precombat()
  -- flask
  -- food
  -- augmentation
  -- snapshot_stats
  -- raise_dead
  if S.RaiseDead:IsCastable() then
    if Settings.Unholy.RaiseDeadCastLeft then
      if HR.CastLeft(S.RaiseDead) then return "raise_dead precombat 2 left"; end
    else
      if Cast(S.RaiseDead, nil, Settings.Commons.DisplayStyle.RaiseDead) then return "raise_dead precombat 2 displaystyle"; end
    end
  end
  -- variable,name=trinket_1_sync,op=setif,value=1,value_else=0.5,condition=trinket.1.has_use_buff&(trinket.1.cooldown.duration%%45=0)
  -- variable,name=trinket_2_sync,op=setif,value=1,value_else=0.5,condition=trinket.2.has_use_buff&(trinket.2.cooldown.duration%%45=0)
  -- variable,name=trinket_priority,op=setif,value=2,value_else=1,condition=!trinket.1.has_use_buff&trinket.2.has_use_buff|trinket.2.has_use_buff&((trinket.2.cooldown.duration%trinket.2.proc.any_dps.duration)*(1.5+trinket.2.has_buff.strength)*(variable.trinket_2_sync))>((trinket.1.cooldown.duration%trinket.1.proc.any_dps.duration)*(1.5+trinket.1.has_buff.strength)*(variable.trinket_1_sync))
  -- variable,name=trinket_1_buffs,value=trinket.1.has_buff.strength|trinket.1.has_buff.mastery|trinket.1.has_buff.versatility|trinket.1.has_buff.haste|trinket.1.has_buff.crit
  -- variable,name=trinket_2_buffs,value=trinket.2.has_buff.strength|trinket.2.has_buff.mastery|trinket.2.has_buff.versatility|trinket.2.has_buff.haste|trinket.2.has_buff.crit
  -- TODO: Trinket sync/priority stuff. Currently unable to pull trinket CD durations because WoW's API is bad.
  -- Manually added: outbreak if not in melee range
  if S.Outbreak:IsReady() and not Target:IsInMeleeRange(5) then
    if Cast(S.Outbreak, nil, nil, not Target:IsSpellInRange(S.Outbreak)) then return "outbreak precombat 6"; end
  end
  -- Manually added: festering_strike if in melee range
  if S.FesteringStrike:IsReady() then
    if Cast(S.FesteringStrike, nil, nil, not Target:IsInMeleeRange(5)) then return "festering_strike precombat 8"; end
  end
end

local function AoE()
  -- any_dnd,if=!death_and_decay.ticking&variable.adds_remain&(talent.festermight&buff.festermight.remains<3|!talent.festermight)&(death_knight.fwounded_targets=active_enemies|death_knight.fwounded_targets=8|!talent.bursting_sores&!talent.vile_contagion|raid_event.adds.exists&raid_event.adds.remains<=11&raid_event.adds.remains>5|(cooldown.vile_contagion.remains|!talent.vile_contagion)&buff.dark_transformation.up&talent.infected_claws&(buff.empower_rune_weapon.up|buff.unholy_assault.up))|fight_remains<10
  if AnyDnD:IsReady() and (Player:BuffDown(S.DeathAndDecayBuff) and VarAddsRemain and (S.Festermight:IsAvailable() and Player:BuffRemains(S.FestermightBuff) < 3 or not S.Festermight:IsAvailable()) and (S.FesteringWoundDebuff:AuraActiveCount() == EnemiesMeleeCount or S.FesteringWoundDebuff:AuraActiveCount() == 8 or (not S.BurstingSores:IsAvailable()) and (not S.VileContagion:IsAvailable()) or (S.VileContagion:CooldownDown() or not S.VileContagion:IsAvailable()) and Pet:BuffUp(S.DarkTransformation) and S.InfectedClaws:IsAvailable() and (Player:BuffUp(S.EmpowerRuneWeaponBuff) or Player:BuffUp(S.UnholyAssaultBuff))) or FightRemains < 10) then
    if Cast(AnyDnD, Settings.Commons.GCDasOffGCD.DeathAndDecay) then return "any_dnd aoe 4"; end
  end
  -- abomination_limb,if=rune=0&variable.adds_remain
  if S.AbominationLimb:IsCastable() and (Player:Rune() == 0 and VarAddsRemain) then
    if Cast(S.AbominationLimb, Settings.Commons.GCDasOffGCD.AbominationLimb) then return "abomination_limb aoe 6"; end
  end
  -- apocalypse,target_if=min:debuff.festering_wound.stack,if=debuff.festering_wound.up&variable.adds_remain&!death_and_decay.ticking&cooldown.death_and_decay.remains&rune<3|death_and_decay.ticking&rune=0
  if S.Apocalypse:IsCastable() then
    if Everyone.CastTargetIf(S.Apocalypse, EnemiesMelee, "min", EvaluateTargetIfFilterFWStack, EvaluateTargetIfApocalypse, not Target:IsInMeleeRange(5), Settings.Unholy.GCDasOffGCD.Apocalypse) then return "apocalypse aoe 8"; end
  end
  -- festering_strike,target_if=max:debuff.festering_wound.stack,if=!death_and_decay.ticking&debuff.festering_wound.stack<4&(cooldown.vile_contagion.remains<5|cooldown.apocalypse.ready&cooldown.any_dnd.remains)
  if S.FesteringStrike:IsReady() and (Player:BuffDown(S.DeathAndDecayBuff) and (S.VileContagion:CooldownRemains() < 5 or S.Apocalypse:CooldownUp() and AnyDnD:CooldownDown())) then
    if Everyone.CastTargetIf(S.FesteringStrike, EnemiesMelee, "max", EvaluateTargetIfFilterFWStack, EvaluateTargetIfFesteringStrike, not Target:IsInMeleeRange(5)) then return "festering_strike aoe 10"; end
  end
  -- festering_strike,target_if=min:debuff.festering_wound.stack,if=!death_and_decay.ticking&(cooldown.vile_contagion.remains>5|!talent.vile_contagion)
  if S.FesteringStrike:IsReady() and (Player:BuffDown(S.DeathAndDecayBuff) and (S.VileContagion:CooldownRemains() > 5 or not S.VileContagion:IsAvailable())) then
    if Everyone.CastTargetIf(S.FesteringStrike, EnemiesMelee, "min", EvaluateTargetIfFilterFWStack, nil, not Target:IsInMeleeRange(5)) then return "festering_strike aoe 12"; end
  end
  -- wound_spender,target_if=max:debuff.festering_wound.stack,if=death_and_decay.ticking
  if WoundSpender:IsReady() and (Player:BuffUp(S.DeathAndDecayBuff)) then
    if Everyone.CastTargetIf(WoundSpender, EnemiesMelee, "max", EvaluateTargetIfFilterFWStack, nil, not Target:IsInMeleeRange(5)) then return "wound_spender aoe 14"; end
  end
  -- death_coil,if=!variable.pooling_runic_power&!talent.epidemic
  if S.DeathCoil:IsReady() and ((not VarPoolingRunicPower) and not S.Epidemic:IsAvailable()) then
    if Cast(S.DeathCoil, nil, nil, not Target:IsSpellInRange(S.DeathCoil)) then return "death_coil aoe 16"; end
  end
  -- epidemic,if=!variable.pooling_runic_power
  if S.Epidemic:IsReady() and (not VarPoolingRunicPower) then
    if Cast(S.Epidemic, Settings.Commons.GCDasOffGCD.Epidemic, nil, not Target:IsSpellInRange(S.Epidemic)) then return "epidemic aoe 18"; end
  end
  -- wound_spender,target_if=max:debuff.festering_wound.stack,if=cooldown.death_and_decay.remains>10
  if WoundSpender:IsReady() and (S.DeathAndDecay:CooldownRemains() > 10) then
    if Everyone.CastTargetIf(WoundSpender, EnemiesMelee, "max", EvaluateTargetIfFilterFWStack, nil, not Target:IsInMeleeRange(5)) then return "wound_spender aoe 20"; end
  end
end

local function Cooldowns()
  -- potion,if=(buff.potion.duration>=pet.gargoyle.remains&pet.gargoyle.active)|(!talent.summon_gargoyle|cooldown.summon_gargoyle.remains>60)&(buff.dark_transformation.up&buff.potion.duration>=buff.dark_transformation.remains|pet.army_ghoul.active&pet.army_ghoul.remains<=buff.potion.duration|pet.apoc_ghoul.active&pet.apoc_ghoul.remains<=buff.potion.duration)|fight_remains<=buff.potion.duration
  if Settings.Commons.Enabled.Potions then
    local PotionSelected = Everyone.PotionSelected()
    if PotionSelected then
      local PotionDuration = PotionSelected:BuffDuration()
      if PotionSelected:IsReady() and ((PotionDuration >= ghoul:gargremains() and ghoul:gargactive()) or ((not S.SummonGargoyle:IsAvailable()) 
or S.SummonGargoyle:CooldownRemains() > 60) and (Pet:BuffUp(S.DarkTransformation) and PotionDuration >= Pet:BuffRemains(S.DarkTransformation) or VarArmyGhoulActive and VarArmyGhoulRemains <= PotionDuration or VarApocGhoulActive and VarApocGhoulRemains <= PotionDuration) or FightRemains <= PotionDuration) then
        if Cast(PotionSelected, Settings.Commons.OffGCDasOffGCD.Potions) then return "potion cooldowns 2"; end
      end
    end
  end
  -- vile_contagion,target_if=max:debuff.festering_wound.stack,if=active_enemies>=2&debuff.festering_wound.stack>=4&cooldown.any_dnd.remains<3
  if S.VileContagion:IsReady() and (Enemies10ySplashCount >= 2 and AnyDnD:CooldownRemains() < 3) then
    if Everyone.CastTargetIf(S.VileContagion, Enemies10ySplash, "max", EvaluateTargetIfFilterFWStack, EvaluateTargetIfVileContagion, not Target:IsSpellInRange(S.VileContagion), Settings.Unholy.GCDasOffGCD.VileContagion) then return "vile_contagion cooldowns 4"; end
  end
  -- raise_dead,if=!pet.ghoul.active
  if S.RaiseDead:IsCastable() then
    if Settings.Unholy.RaiseDeadCastLeft then
      if HR.CastLeft(S.RaiseDead) then return "raise_dead cooldowns 6 left"; end
    else
      if Cast(S.RaiseDead, nil, Settings.Commons.DisplayStyle.RaiseDead) then return "raise_dead cooldowns 8 displaystyle"; end
    end
  end
  -- empower_rune_weapon,if=variable.st_planning&runic_power.deficit>20&(pet.gargoyle.active&pet.apoc_ghoul.active|!talent.summon_gargoyle&talent.army_of_the_damned&pet.army_ghoul.active&pet.apoc_ghoul.active|!talent.summon_gargoyle&!talent.army_of_the_damned&buff.dark_transformation.up|!talent.summon_gargoyle&!talent.summon_gargoyle&buff.dark_transformation.up)|fight_remains<=21
  if S.EmpowerRuneWeapon:IsCastable() and (VarSTPlanning and Player:RunicPowerDeficit() > 20 and (ghoul:gargactive() and VarApocGhoulActive or (not S.SummonGargoyle:IsAvailable()) and S.ArmyoftheDamned:IsAvailable() and VarArmyGhoulActive and VarApocGhoulActive or (not S.SummonGargoyle:IsAvailable()) and (not S.ArmyoftheDamned:IsAvailable()) and Pet:BuffUp(S.DarkTransformation) or (not S.SummonGargoyle:IsAvailable()) and Pet:BuffUp(S.DarkTransformation)) or FightRemains <= 21) then
    if Cast(S.EmpowerRuneWeapon, Settings.Commons.GCDasOffGCD.EmpowerRuneWeapon) then return "empower_rune_weapon cooldowns 10"; end
  end
  -- empower_rune_weapon,if=variable.adds_remain&buff.dark_transformation.up
  if S.EmpowerRuneWeapon:IsCastable() and (VarAddsRemain and Pet:BuffUp(S.DarkTransformation)) then
    if Cast(S.EmpowerRuneWeapon, Settings.Commons.GCDasOffGCD.EmpowerRuneWeapon) then return "empower_rune_weapon cooldowns 12"; end
  end
  -- summon_gargoyle,if=buff.commander_of_the_dead_window.up|!talent.commander_of_the_dead&runic_power>=40
  if S.SummonGargoyle:IsReady() and (S.DarkTransformation:TimeSinceLastCast() <= 4 or (not S.CommanderoftheDead:IsAvailable()) and Player:RunicPower() >= 40) then
    if Cast(S.SummonGargoyle, Settings.Unholy.GCDasOffGCD.SummonGargoyle) then return "summon_gargoyle cooldowns 14"; end
  end
  -- unholy_assault,if=variable.st_planning
  if S.UnholyAssault:IsReady() and (VarSTPlanning) then
    if Cast(S.UnholyAssault, Settings.Unholy.GCDasOffGCD.UnholyAssault, nil, not Target:IsInMeleeRange(5)) then return "unholy_assault cooldowns 16"; end
  end
  -- dark_transformation,if=variable.st_planning&cooldown.apocalypse.remains<gcd
  if S.DarkTransformation:IsCastable() and (VarSTPlanning and S.Apocalypse:CooldownRemains() < Player:GCD()) then
    if Cast(S.DarkTransformation, Settings.Unholy.GCDasOffGCD.DarkTransformation) then return "dark_transformation cooldowns 10"; end
  end
  -- dark_transformation,if=variable.adds_remain&(cooldown.any_dnd.remains<10&talent.infected_claws&((cooldown.vile_contagion.remains|raid_event.adds.exists&raid_event.adds.in>10)&death_knight.fwounded_targets<active_enemies|!talent.vile_contagion)&(raid_event.adds.remains>5|!raid_event.adds.exists)|!talent.infected_claws)|fight_remains<25
  if S.DarkTransformation:IsCastable() and (VarAddsRemain and (AnyDnD:CooldownRemains() < 10 and S.InfectedClaws:IsAvailable() and (S.VileContagion:CooldownDown() and S.FesteringWoundDebuff:AuraActiveCount() < EnemiesMeleeCount or not S.VileContagion:IsAvailable()) or not S.InfectedClaws:IsAvailable()) or FightRemains < 25) then
    if Cast(S.DarkTransformation, Settings.Unholy.GCDasOffGCD.DarkTransformation) then return "dark_transformation cooldowns 20"; end
  end
  -- apocalypse,target_if=max:debuff.festering_wound.stack,if=active_enemies<=3&(!talent.commander_of_the_dead|talent.commander_of_the_dead&buff.commander_of_the_dead_window.up)
  if S.Apocalypse:IsReady() and (EnemiesMeleeCount <= 3 and ((not S.CommanderoftheDead:IsAvailable()) or S.CommanderoftheDead:IsAvailable() and S.DarkTransformation:TimeSinceLastCast() <= 4)) then
    if Everyone.CastTargetIf(S.Apocalypse, Enemies10ySplash, "max", EvaluateTargetIfFilterFWStack, nil, not Target:IsInMeleeRange(5)) then return "apocalypse cooldowns 22"; end
  end
  -- soul_reaper,if=active_enemies=1&target.time_to_pct_35<5&target.time_to_die>5
  if S.SoulReaper:IsReady() and (EnemiesMeleeCount == 1 and Target:TimeToX(35) < 5 and Target:TimeToDie() > 5) then
    if Cast(S.SoulReaper, nil, nil, not Target:IsSpellInRange(S.SoulReaper)) then return "soul_reaper cooldowns 24"; end
  end
  -- soul_reaper,target_if=min:dot.soul_reaper.remains,if=target.time_to_pct_35<5&active_enemies>=2&target.time_to_die>(dot.soul_reaper.remains+5)
  if S.SoulReaper:IsReady() and (EnemiesMeleeCount >= 2) then
    if Everyone.CastTargetIf(S.SoulReaper, EnemiesMelee, "min", EvaluateTargetIfFilterSoulReaper, EvaluateTargetIfSoulReaper, not Target:IsSpellInRange(S.SoulReaper)) then return "soul_reaper cooldowns 26"; end
  end
  -- unholy_blight,if=variable.st_planning&((!talent.apocalypse|cooldown.apocalypse.remains)&talent.morbidity|!talent.morbidity)
  if S.UnholyBlight:IsReady() and (VarSTPlanning and (((not S.Apocalypse:IsAvailable()) or S.Apocalypse:CooldownDown()) and S.Morbidity:IsAvailable() or not S.Morbidity:IsAvailable())) then
    if Cast(S.UnholyBlight, Settings.Unholy.GCDasOffGCD.UnholyBlight, nil, not Target:IsInRange(8)) then return "unholy_blight cooldowns 28"; end
  end
  -- unholy_blight,if=variable.adds_remain|fight_remains<21
  if S.UnholyBlight:IsReady() and (VarAddsRemain or FightRemains < 21) then
    if Cast(S.UnholyBlight, Settings.Unholy.GCDasOffGCD.UnholyBlight, nil, not Target:IsInRange(8)) then return "unholy_blight cooldowns 30"; end
  end
  -- abomination_limb,if=variable.st_planning&rune<3
  if S.AbominationLimb:IsCastable() and (VarSTPlanning and Player:Rune() < 3) then
    if Cast(S.AbominationLimb, Settings.Commons.GCDasOffGCD.AbominationLimb) then return "abomination_limb cooldowns 32"; end
  end
  -- sacrificial_pact,if=active_enemies>=2&!buff.dark_transformation.up&cooldown.dark_transformation.remains>6|fight_remains<gcd
  if S.SacrificialPact:IsReady() and (EnemiesMeleeCount >= 2 and Pet:BuffDown(S.DarkTransformation) and S.DarkTransformation:CooldownRemains() > 6 or FightRemains < Player:GCD()) then
    if Cast(S.SacrificialPact, Settings.Commons.GCDasOffGCD.SacrificialPact, nil, not Target:IsInRange(8)) then return "sacrificial_pact cooldowns 34"; end
  end
end

local function Racials()
  -- arcane_torrent,if=runic_power.deficit>20&(cooldown.summon_gargoyle.remains<gcd|!talent.summon_gargoyle.enabled|pet.gargoyle.active&rune<2&debuff.festering_wound.stack<1)
  if S.ArcaneTorrent:IsCastable() and (Player:RunicPowerDeficit() > 20 and (S.SummonGargoyle:CooldownRemains() < Player:GCD() or (not S.SummonGargoyle:IsAvailable()) or ghoul:gargactive() and Player:Rune() < 2 and FesterStacks < 1)) then
    if Cast(S.ArcaneTorrent, Settings.Commons.GCDasOffGCD.Racials, nil, not Target:IsInRange(8)) then return "arcane_torrent main 2"; end
  end
  -- blood_fury,if=(buff.blood_fury.duration>=pet.gargoyle.remains&pet.gargoyle.active)|(!talent.summon_gargoyle|cooldown.summon_gargoyle.remains>60)&(buff.dark_transformation.up&buff.blood_fury.duration>=buff.dark_transformation.remains|pet.army_ghoul.active&pet.army_ghoul.remains<=buff.blood_fury.duration|pet.apoc_ghoul.active&pet.apoc_ghoul.remains<=buff.blood_fury.duration|active_enemies>=2&death_and_decay.ticking)|fight_remains<=buff.blood_fury.duration
  if S.BloodFury:IsCastable() and ((S.BloodFury:BaseDuration() >= ghoul:gargremains() and ghoul:gargactive()) or ((not S.SummonGargoyle:IsAvailable()) or S.SummonGargoyle:CooldownRemains() > 60) and (Pet:BuffUp(S.DarkTransformation) and S.BloodFury:BaseDuration() >= Pet:BuffRemains(S.DarkTransformation) or VarArmyGhoulActive and VarArmyGhoulRemains <= S.BloodFury:BaseDuration() or VarApocGhoulActive and VarApocGhoulRemains <= S.BloodFury:BaseDuration() or Enemies10ySplashCount >= 2 and Player:BuffUp(S.DeathAndDecayBuff)) or FightRemains <= S.BloodFury:BaseDuration()) then
    if Cast(S.BloodFury, Settings.Commons.GCDasOffGCD.Racials) then return "blood_fury main 4"; end
  end
  -- berserking,if=(buff.berserking.duration>=pet.gargoyle.remains&pet.gargoyle.active)|(!talent.summon_gargoyle|cooldown.summon_gargoyle.remains>60)&(buff.dark_transformation.up&buff.berserking.duration>=buff.dark_transformation.remains|pet.army_ghoul.active&pet.army_ghoul.remains<=buff.berserking.duration|pet.apoc_ghoul.active&pet.apoc_ghoul.remains<=buff.berserking.duration|active_enemies>=2&death_and_decay.ticking)|fight_remains<=buff.berserking.duration
  if S.Berserking:IsCastable() and ((S.Berserking:BaseDuration() >= ghoul:gargremains() and ghoul:gargactive()) or ((not S.SummonGargoyle:IsAvailable()) or S.SummonGargoyle:CooldownRemains() > 60) and (Pet:BuffUp(S.DarkTransformation) and S.Berserking:BaseDuration() >= Pet:BuffRemains(S.DarkTransformation) or VarArmyGhoulActive and VarArmyGhoulRemains <= S.Berserking:BaseDuration() or VarApocGhoulActive and VarApocGhoulRemains <= S.Berserking:BaseDuration() or Enemies10ySplashCount >= 2 and Player:BuffUp(S.DeathAndDecayBuff)) or FightRemains <= S.Berserking:BaseDuration()) then
    if Cast(S.Berserking, Settings.Commons.GCDasOffGCD.Racials) then return "berserking main 6"; end
  end
  -- lights_judgment,if=buff.unholy_strength.up&(!talent.festermight|buff.festermight.remains<target.time_to_die|buff.unholy_strength.remains<target.time_to_die)
  if S.LightsJudgment:IsCastable() and (Player:BuffUp(S.UnholyStrengthBuff) and ((not S.Festermight:IsAvailable()) or Player:BuffRemains(S.FestermightBuff) < Target:TimeToDie() or Player:BuffRemains(S.UnholyStrengthBuff) < Target:TimeToDie())) then
    if Cast(S.LightsJudgment, Settings.Commons.GCDasOffGCD.Racials, nil, not Target:IsSpellInRange(S.LightsJudgment)) then return "lights_judgment main 8"; end
  end
  -- ancestral_call,if=(15>=pet.gargoyle.remains&pet.gargoyle.active)|(!talent.summon_gargoyle|cooldown.summon_gargoyle.remains>60)&(buff.dark_transformation.up&15>=buff.dark_transformation.remains|pet.army_ghoul.active&pet.army_ghoul.remains<=15|pet.apoc_ghoul.active&pet.apoc_ghoul.remains<=15|active_enemies>=2&death_and_decay.ticking)|fight_remains<=15
  if S.AncestralCall:IsCastable() and ((15 >= ghoul:gargremains() and ghoul:gargactive()) or ((not S.SummonGargoyle:IsAvailable()) or S.SummonGargoyle:CooldownRemains() > 60) and (Pet:BuffUp(S.DarkTransformation) and 15 >= Pet:BuffRemains(S.DarkTransformation) or VarArmyGhoulActive and VarArmyGhoulRemains <= 15 or VarApocGhoulActive and VarApocGhoulRemains <= 15 or Enemies10ySplashCount >= 2 and Player:BuffUp(S.DeathAndDecayBuff)) or FightRemains <= 15) then
    if Cast(S.AncestralCall, Settings.Commons.OffGCDasOffGCD) then return "ancestral_call main 10"; end
  end
  -- arcane_pulse,if=active_enemies>=2|(rune.deficit>=5&runic_power.deficit>=60)
  if S.ArcanePulse:IsCastable() and (EnemiesMeleeCount >= 2 or (Player:Rune() <= 1 and Player:RunicPowerDeficit() >= 60)) then
    if Cast(S.ArcanePulse, Settings.Commons.GCDasOffGCD.Racials, nil, not Target:IsInRange(8)) then return "arcane_pulse main 12"; end
  end
  -- fireblood,if=(buff.fireblood.duration>=pet.gargoyle.remains&pet.gargoyle.active)|(!talent.summon_gargoyle|cooldown.summon_gargoyle.remains>60)&(buff.dark_transformation.up&buff.fireblood.duration>=buff.dark_transformation.remains|pet.army_ghoul.active&pet.army_ghoul.remains<=buff.fireblood.duration|pet.apoc_ghoul.active&pet.apoc_ghoul.remains<=buff.fireblood.duration|active_enemies>=2&death_and_decay.ticking)|fight_remains<=buff.fireblood.duration
  if S.Fireblood:IsCastable() and ((S.Fireblood:BaseDuration() >= ghoul:gargremains() and ghoul:gargactive()) or ((not S.SummonGargoyle:IsAvailable()) or S.SummonGargoyle:CooldownRemains() > 60) and (Pet:BuffUp(S.DarkTransformation) and S.Fireblood:BaseDuration() >= Pet:BuffRemains(S.DarkTransformation) or VarArmyGhoulActive and VarArmyGhoulRemains <= S.Fireblood:BaseDuration() or VarApocGhoulActive and VarApocGhoulRemains <= S.Fireblood:BaseDuration() or Enemies10ySplashCount >= 2 and Player:BuffUp(S.DeathAndDecayBuff)) or FightRemains <= S.Fireblood:BaseDuration()) then
    if Cast(S.Fireblood, Settings.Commons.GCDasOffGCD.Racials) then return "fireblood main 14"; end
  end
  -- bag_of_tricks,if=active_enemies=1&(buff.unholy_strength.up|fight_remains<5)
  if S.BagofTricks:IsCastable() and (EnemiesMeleeCount == 1 and (Player:BuffUp(S.UnholyStrengthBuff) or HL.FilteredFightRemains(EnemiesMelee, "<", 5))) then
    if Cast(S.BagofTricks, Settings.Commons.GCDasOffGCD.Racials, nil, not Target:IsSpellInRange(S.BagofTricks)) then return "bag_of_tricks main 16"; end
  end
end

local function Generic()
  -- death_coil,if=!variable.pooling_runic_power&(rune<3|pet.gargoyle.active|buff.sudden_doom.react)
  if S.DeathCoil:IsReady() and ((not VarPoolingRunicPower) and (Player:Rune() < 3 or ghoul:gargactive() or Player:BuffUp(S.SuddenDoomBuff))) then
    if Cast(S.DeathCoil, nil, nil, not Target:IsSpellInRange(S.DeathCoil)) then return "death_coil generic 2"; end
  end
  -- any_dnd,if=!death_and_decay.ticking&active_enemies>=2&death_knight.fwounded_targets=active_enemies
  if AnyDnD:IsReady() and (Player:BuffDown(S.DeathAndDecayBuff) and Enemies10ySplashCount >= 2 and S.FesteringWoundDebuff:AuraActiveCount() == EnemiesMeleeCount) then
    if Cast(AnyDnD, Settings.Commons.GCDasOffGCD.DeathAndDecay) then return "any_dnd generic 6"; end
  end
  -- wound_spender,target_if=max:debuff.festering_wound.stack,if=variable.pop_wounds|active_enemies>=2&death_and_decay.ticking
  if WoundSpender:IsReady() and (VarPopWounds or EnemiesMeleeCount >= 2 and Player:BuffUp(S.DeathAndDecayBuff)) then
    if Cast(WoundSpender, nil, nil, not Target:IsSpellInRange(WoundSpender)) then return "wound_spender generic 8"; end
  end
  -- festering_strike,target_if=min:debuff.festering_wound.stack,if=!variable.pop_wounds
  if S.FesteringStrike:IsReady() and (not VarPopWounds) then
    if Everyone.CastTargetIf(S.FesteringStrike, EnemiesMelee, "min", EvaluateTargetIfFilterFWStack, nil, not Target:IsInMeleeRange(5)) then return "festering_strike generic 10"; end
  end
  -- death_coil
  if S.DeathCoil:IsReady() then
    if Cast(S.DeathCoil, nil, nil, not Target:IsSpellInRange(S.DeathCoil)) then return "death_coil generic 12"; end
  end
end

local function Trinkets()
  -- use_item,slot=trinket1,if=((!talent.summon_gargoyle|talent.summon_gargoyle&pet.gargoyle.active|cooldown.summon_gargoyle.remains>90)&(pet.apoc_ghoul.active|buff.dark_transformation.up)&variable.trinket_priority=1)|trinket.1.proc.any_dps.duration>=fight_remains
  -- use_item,slot=trinket2,if=((!talent.summon_gargoyle|talent.summon_gargoyle&pet.gargoyle.active|cooldown.summon_gargoyle.remains>90)&(pet.apoc_ghoul.active|buff.dark_transformation.up)&variable.trinket_priority=2)|trinket.2.proc.any_dps.duration>=fight_remains
  -- use_item,slot=trinket1,if=!variable.trinket_1_buffs&(trinket.2.cooldown.remains|!variable.trinket_2_buffs|!talent.summon_gargoyle|cooldown.summon_gargoyle.remains>20&!pet.gargoyle.active)|fight_remains<15
  -- use_item,slot=trinket2,if=!variable.trinket_2_buffs&(trinket.1.cooldown.remains|!variable.trinket_1_buffs|!talent.summon_gargoyle|cooldown.summon_gargoyle.remains>20&!pet.gargoyle.active)|fight_remains<15
  -- TODO: Add above lines and remove below lines when we can handle the trinket sync/priority variables. For now, keeping the old trinket setup below.
  -- use_items,if=(cooldown.apocalypse.remains|buff.dark_transformation.up)&(!equipped.inscrutable_quantum_device|cooldown.inscrutable_quantum_device.remains)
  if (S.Apocalypse:CooldownDown() or Pet:BuffUp(S.DarkTransformation)) then
    local TrinketToUse = Player:GetUseableTrinkets(OnUseExcludes)
    if TrinketToUse then
      if Cast(TrinketToUse, nil, Settings.Commons.DisplayStyle.Trinkets) then return "Generic use_items for " .. TrinketToUse:Name(); end
    end
  end
end

--- ======= ACTION LISTS =======
local function APL()
  no_heal = not DeathStrikeHeal()
  EnemiesMelee = Player:GetEnemiesInMeleeRange(8)
  Enemies10ySplash = Target:GetEnemiesInSplashRange(10)
  if AoEON() then
    EnemiesMeleeCount = #EnemiesMelee
    Enemies10ySplashCount = #Enemies10ySplash
  else
    EnemiesMeleeCount = 1
    Enemies10ySplashCount = 1
  end

  -- Check which enemies don't have Virulent Plague
  EnemiesWithoutVP = UnitsWithoutVP(Enemies10ySplash)

  -- Is Apocalypse Ghoul active?
  VarApocGhoulActive = S.Apocalypse:TimeSinceLastCast() <= 15
  VarApocGhoulRemains = (VarApocGhoulActive) and 15 - S.Apocalypse:TimeSinceLastCast() or 0
  VarArmyGhoulActive = S.ArmyoftheDead:TimeSinceLastCast() <= 30
  VarArmyGhoulRemains = (VarArmyGhoulRemains) and 30 - S.ArmyoftheDead:TimeSinceLastCast() or 0

  if Everyone.TargetIsValid() or Player:AffectingCombat() then
    -- Calculate fight_remains
    BossFightRemains = HL.BossFightRemains(nil, true)
    FightRemains = BossFightRemains
    if FightRemains == 11111 then
      FightRemains = HL.FightRemains(Enemies10yd, false)
    end
  end

  -- Set WoundSpender and AnyDnD
  WoundSpender = (S.ClawingShadows:IsAvailable() and S.ClawingShadows or S.ScourgeStrike)
  AnyDnD = S.DeathAndDecay
  if S.Defile:IsAvailable() then AnyDnD = S.Defile end

  if Everyone.TargetIsValid() then
    -- Check our stacks of Festering Wounds
    FesterStacks = Target:DebuffStack(S.FesteringWoundDebuff)
    -- call precombat
    if not Player:AffectingCombat() then
      local ShouldReturn = Precombat(); if ShouldReturn then return ShouldReturn; end
    end
    -- interrupts
    local ShouldReturn = Everyone.Interrupt(15, S.MindFreeze, Settings.Commons.OffGCDasOffGCD.MindFreeze, StunInterrupts); if ShouldReturn then return ShouldReturn; end
    -- use DeathStrike on low HP or with proc in Solo Mode
    if S.DeathStrike:IsReady() and not no_heal then
      if Cast(S.DeathStrike) then return "death_strike low hp or proc"; end
    end
    -- auto_attack
    -- variable,name=apoc_timing,op=setif,value=8,value_else=4,condition=cooldown.apocalypse.remains<10&debuff.festering_wound.stack<4
    if S.Apocalypse:CooldownRemains() < 10 and FesterStacks < 4 then
      VarApocTiming = 8
    else
      VarApocTiming = 4
    end
    -- variable,name=garg_pooling,op=setif,value=(((cooldown.summon_gargoyle.remains+1)%gcd)%((rune+1)*(runic_power+20)))*100,value_else=gcd,condition=cooldown.summon_gargoyle.remains<gcd*2
    if S.SummonGargoyle:CooldownRemains() < Player:GCD() * 2 then
      VarGargPooling = ((((S.SummonGargoyle:CooldownRemains() + 1) / Player:GCD()) / ((Player:Rune() + 1) * (Player:RunicPower() + 20))) * 100)
    else
      VarGargPooling = Player:GCD()
    end
    -- variable,name=festermight_tracker,op=setif,value=debuff.festering_wound.stack>=1,value_else=debuff.festering_wound.stack>=(2-talent.infected_claws),condition=talent.festermight&buff.festermight.up&(buff.festermight.remains%(4*gcd))>=1
    if (S.Festermight:IsAvailable() and Player:BuffUp(S.FestermightBuff) and (Player:BuffRemains(S.FestermightBuff) / (4 * Player:GCD())) >= 1) then
      VarFesterTracker = FesterStacks >= 1
    else
      VarFesterTracker = FesterStacks >= (2 - num(S.InfectedClaws:IsAvailable()))
    end
    -- variable,name=pop_wounds,value=(cooldown.apocalypse.remains>variable.apoc_timing|!talent.apocalypse)&(variable.festermight_tracker|debuff.festering_wound.stack>=1&!talent.apocalypse|debuff.festering_wound.stack>=1&cooldown.unholy_assault.remains<20&talent.unholy_assault&variable.st_planning|debuff.festering_wound.stack>4|fight_remains<debuff.festering_wound.stack*gcd)
    VarPopWounds = ((S.Apocalypse:CooldownRemains() > VarApocTiming or not S.Apocalypse:IsAvailable()) and (VarFesterTracker or FesterStacks >= 1 and (not S.Apocalypse:IsAvailable()) or FesterStacks >= 1 and S.UnholyAssault:CooldownRemains() < 20 and S.UnholyAssault:IsAvailable() and VarSTPlanning or FesterStacks > 4 or FightRemains < FesterStacks * Player:GCD()))
    -- variable,name=pooling_runic_power,value=talent.vile_contagion&cooldown.vile_contagion.remains<3&runic_power<60&!variable.st_planning
    VarPoolingRunicPower = (S.VileContagion:IsAvailable() and S.VileContagion:CooldownRemains() < 3 and Player:RunicPower() < 60 and not VarSTPlanning)
    -- variable,name=pooling_runes,value=talent.soul_reaper&rune<2&target.time_to_pct_35<5&fight_remains>5
    VarPoolingRunes = (S.SoulReaper:IsAvailable() and Player:Rune() < 2 and Target:TimeToX(35) < 5 and FightRemains > 5)
    -- variable,name=st_planning,value=active_enemies<=3&(!raid_event.adds.exists|raid_event.adds.in>15)
    VarSTPlanning = (EnemiesMeleeCount <= 3 or not AoEON())
    -- variable,name=adds_remain,value=active_enemies>=4&(!raid_event.adds.exists|raid_event.adds.exists&raid_event.adds.remains>6)
    VarAddsRemain = (EnemiesMeleeCount >= 4 and AoEON())
    -- invoke_external_buff,name=power_infusion,line_cd=120,if=variable.st_planning&runic_power.deficit>20&(pet.gargoyle.active&pet.apoc_ghoul.active|!talent.summon_gargoyle&talent.army_of_the_damned&pet.army_ghoul.active&pet.apoc_ghoul.active|!talent.summon_gargoyle&!talent.army_of_the_damned&buff.dark_transformation.up|!talent.summon_gargoyle&!talent.summon_gargoyle&buff.dark_transformation.up)|fight_remains<=21
    -- Note: Not handling external buffs.
    -- Manually added: Outbreak if targets are missing VP and out of range
    if S.Outbreak:IsReady() and (EnemiesWithoutVP > 0 and EnemiesMeleeCount == 0) then
      if Cast(S.Outbreak, nil, nil, not Target:IsSpellInRange(S.Outbreak)) then return "outbreak out_of_range"; end
    end
    -- Manually added: epidemic,if=!variable.pooling_runic_power&active_enemies=0
    if S.Epidemic:IsReady() and AoEON() and S.VirulentPlagueDebuff:AuraActiveCount() > 1 and (not VarPoolingRunicPower and EnemiesMeleeCount == 0) then
      if Cast(S.Epidemic, nil, nil, not Target:IsInRange(30)) then return "epidemic out_of_range"; end
    end
    -- Manually added: death_coil,if=!variable.pooling_runic_power&active_enemies=0
    if S.DeathCoil:IsReady() and S.VirulentPlagueDebuff:AuraActiveCount() < 2 and (not VarPoolingRunicPower and EnemiesMeleeCount == 0) then
      if Cast(S.DeathCoil, nil, nil, not Target:IsSpellInRange(S.DeathCoil)) then return "death_coil out_of_range"; end
    end
    -- army_of_the_dead,if=talent.commander_of_the_dead&(cooldown.dark_transformation.remains<4|buff.commander_of_the_dead_window.up)|!talent.commander_of_the_dead&talent.unholy_assault&cooldown.unholy_assault.remains<10|!talent.unholy_assault&!talent.commander_of_the_dead|fight_remains<=30
    if S.ArmyoftheDead:IsReady() and CDsON() and (S.CommanderoftheDead:IsAvailable() and (S.DarkTransformation:CooldownRemains() < 4 or S.DarkTransformation:TimeSinceLastCast() <= 4) or (not S.CommanderoftheDead:IsAvailable()) and S.UnholyAssault:IsAvailable() and S.UnholyAssault:CooldownRemains() < 10 or (not S.UnholyAssault:IsAvailable()) and (not S.CommanderoftheDead:IsAvailable()) or FightRemains <= 30) then
      if Cast(S.ArmyoftheDead, nil, Settings.Unholy.DisplayStyle.ArmyoftheDead) then return "army_of_the_dead main 1"; end
    end
    -- outbreak,target_if=(dot.virulent_plague.refreshable|talent.superstrain&(dot.frost_fever_superstrain.refreshable|dot.blood_plague_superstrain.refreshable))&(!talent.unholy_blight|talent.unholy_blight&cooldown.unholy_blight.remains>15%((talent.superstrain*3)+(talent.plaguebringer*2)))
    if S.Outbreak:IsReady() and ((Target:DebuffRefreshable(S.VirulentPlagueDebuff) or S.Superstrain:IsAvailable() and (Target:DebuffRefreshable(S.FrostFeverDebuff) or Target:DebuffRefreshable(S.BloodPlagueDebuff))) and ((not S.UnholyBlight:IsAvailable()) or S.UnholyBlight:IsAvailable() and S.UnholyBlight:CooldownRemains() > 15 / ((num(S.Superstrain:IsAvailable()) * 3) + (num(S.Plaguebringer:IsAvailable()) * 2)))) then
      if Cast(S.Outbreak, nil, nil, not Target:IsSpellInRange(S.Outbreak)) then return "outbreak main 2"; end
    end
    -- wound_spender,if=cooldown.apocalypse.remains>variable.apoc_timing&talent.plaguebringer&talent.superstrain&buff.plaguebringer.remains<gcd
    if WoundSpender:IsReady() and (S.Apocalypse:CooldownRemains() > VarApocTiming and S.Plaguebringer:IsAvailable() and S.Superstrain:IsAvailable() and Player:BuffRemains(S.PlaguebringerBuff) < Player:GCD()) then
      if Cast(WoundSpender, nil, nil, not Target:IsSpellInRange(WoundSpender)) then return "wound_spender main 4"; end
    end
    -- call_action_list,name=trinkets
    if (Settings.Commons.Enabled.Trinkets) then
      local ShouldReturn = Trinkets(); if ShouldReturn then return ShouldReturn; end
    end
    -- call_action_list,name=racials
    if (CDsON()) then
      local ShouldReturn = Racials(); if ShouldReturn then return ShouldReturn; end
    end
    -- call_action_list,name=cooldowns
    if (CDsON()) then
      local ShouldReturn = Cooldowns(); if ShouldReturn then return ShouldReturn; end
    end
    -- run_action_list,name=aoe,if=active_enemies>=4
    if (AoEON() and Enemies10ySplashCount >= 4) then
      local ShouldReturn = AoE(); if ShouldReturn then return ShouldReturn; end
      if Cast(S.Pool) then return "pool for AoE()"; end
    end
    -- run_action_list,name=generic,if=active_enemies<=3
    if (Enemies10ySplashCount <= 3) then
      local ShouldReturn = Generic(); if ShouldReturn then return ShouldReturn; end
      if Cast(S.Pool) then return "pool for Generic()"; end
    end
    -- Add pool resources icon if nothing else to do
    if (true) then
      if Cast(S.Pool) then return "pool_resources"; end
    end
  end
end

local function Init()
  S.VirulentPlagueDebuff:RegisterAuraTracking()
  S.FesteringWoundDebuff:RegisterAuraTracking()

  HR.Print("Unholy DK rotation is currently a work in progress, but has been updated for patch 10.0.")
end

HR.SetAPL(252, APL, Init)
