--- ============================ HEADER ============================
--- ======= LOCALIZE =======
-- Addon
local addonName, addonTable = ...
-- HeroLib
local HL         = HeroLib
local Cache      = HeroCache
local Unit       = HL.Unit
local Player     = Unit.Player
local Target     = Unit.Target
local Pet        = Unit.Pet
local Spell      = HL.Spell
local MultiSpell = HL.MultiSpell
local Item       = HL.Item
-- HeroRotation
local HR         = HeroRotation
local Cast       = HR.Cast
local AoEON      = HR.AoEON
local CDsON      = HR.CDsON

--- ============================ CONTENT ===========================
--- ======= APL LOCALS =======
-- GUI Settings
local Everyone = HR.Commons.Everyone
local Settings = {
  General = HR.GUISettings.General,
  Commons = HR.GUISettings.APL.Hunter.Commons,
  Commons2 = HR.GUISettings.APL.Hunter.Commons2,
  Survival = HR.GUISettings.APL.Hunter.Survival
}

-- Spells
local S = Spell.Hunter.Survival

-- Items
local I = Item.Hunter.Survival
local OnUseExcludes = {
  -- I.Trinket:ID(),
}

-- Trinket Item Objects
local equip = Player:GetEquipment()
local trinket1 = (equip[13]) and Item(equip[13]) or Item(0)
local trinket2 = (equip[14]) and Item(equip[14]) or Item(0)

-- Check when equipment changes
HL:RegisterForEvent(function()
  equip = Player:GetEquipment()
  trinket1 = (equip[13]) and Item(equip[13]) or Item(0)
  trinket2 = (equip[14]) and Item(equip[14]) or Item(0)
end, "PLAYER_EQUIPMENT_CHANGED")

-- Rotation Var
local SummonPetSpells = { S.SummonPet, S.SummonPet2, S.SummonPet3, S.SummonPet4, S.SummonPet5 }
local EnemyCount8ySplash, EnemyList
local BossFightRemains = 11111
local FightRemains = 11111
local MBRSCost = S.MongooseBite:IsAvailable() and S.MongooseBite:Cost() or S.RaptorStrike:Cost()

HL:RegisterForEvent(function()
  MBRSCost = S.MongooseBite:IsAvailable() and S.MongooseBite:Cost() or S.RaptorStrike:Cost()
end, "PLAYER_TALENT_UPDATE")

HL:RegisterForEvent(function()
  BossFightRemains = 11111
  FightRemains = 11111
end, "PLAYER_REGEN_ENABLED")

-- Stuns
local StunInterrupts = {
  {S.Intimidation, "Cast Intimidation (Interrupt)", function () return true; end},
}

-- Bombs
local Bombs = { S.WildfireBomb, S.ShrapnelBomb, S.PheromoneBomb, S.VolatileBomb }
local BombDebuffs = { S.WildfireBombDebuff, S.ShrapnelBombDebuff, S.PheromoneBombDebuff, S.VolatileBombDebuff }

-- Function to see if we're going to cap focus
local function CheckFocusCap(SpellCastTime, GenFocus)
  local GeneratedFocus = GenFocus or 0
  return (Player:Focus() + Player:FocusCastRegen(SpellCastTime) + GeneratedFocus < Player:FocusMax())
end

-- Helper Functions
local function num(val)
  if val then return 1 else return 0 end
end

local function bool(val)
  return val ~= 0
end

-- CastCycle/CastTargetIf functions
local function EvaluateTargetIfFilterSerpentStingRemains(TargetUnit)
  -- target_if=min:remains
  return (TargetUnit:DebuffRemains(S.SerpentStingDebuff))
end

local function EvaluateTargetIfFilterBloodseekerRemains(TargetUnit)
  -- target_if=min:bloodseeker.remains
  return (TargetUnit:DebuffRemains(S.BloodseekerDebuff))
end

local function EvaluateTargetIfFilterLatentStacks(TargetUnit)
  -- target_if=max:debuff.latent_poison.stack
  return (TargetUnit:DebuffStack(S.LatentPoisonDebuff))
end

local function EvaluateTargetIfRaptorStrikeCleave(TargetUnit)
  -- if=debuff.latent_poison.stack>8
  return (TargetUnit:DebuffStack(S.LatentPoisonDebuff) > 8)
end

local function EvaluateTargetIfSerpentStingCleave(TargetUnit)
  -- if=refreshable&target.time_to_die>12&(!talent.vipers_venom|talent.hydras_bite)
  return (TargetUnit:DebuffRefreshable(S.SerpentStingDebuff) and TargetUnit:TimeToDie() > 12 and ((not S.VipersVenom:IsAvailable()) or S.HydrasBite:IsAvailable()))
end

local function EvaluateTargetIfSerpentStingST(TargetUnit)
  -- if=!dot.serpent_sting.ticking&target.time_to_die>7&!talent.vipers_venom
  return (TargetUnit:DebuffDown(S.SerpentStingDebuff) and TargetUnit:TimeToDie() > 7)
end

local function EvaluateTargetIfSerpentStingST2(TargetUnit)
  -- if=refreshable&!talent.vipers_venom
  return (TargetUnit:DebuffRefreshable(S.SerpentStingDebuff))
end

local function Precombat()
  -- flask
  -- augmentation
  -- food
  -- variable,name=mb_rs_cost,op=setif,value=action.mongoose_bite.cost,value_else=action.raptor_strike.cost,condition=talent.mongoose_bite
  -- Defined with profile variables
  -- summon_pet
  -- Moved to Pet Management section in APL()
  -- snapshot_stat
  -- steel_trap,precast_time=20
  if S.SteelTrap:IsCastable() and Target:DebuffDown(S.SteelTrapDebuff) then
    if Cast(S.SteelTrap, nil, nil, not Target:IsInRange(40)) then return "steel_trap precombat 2"; end
  end
  -- Manually added: harpoon
  if S.Harpoon:IsCastable() and (Player:BuffDown(S.AspectoftheEagle) or not Target:IsInRange(30)) then
    if Cast(S.Harpoon, Settings.Survival.GCDasOffGCD.Harpoon, nil, not Target:IsSpellInRange(S.Harpoon)) then return "harpoon precombat 4"; end
  end
  -- Manually added: mongoose_bite or raptor_strike
  if Target:IsInMeleeRange(5) or (Player:BuffUp(S.AspectoftheEagle) and Target:IsInRange(40)) then
    if S.MongooseBite:IsReady() then
      if Cast(S.MongooseBite) then return "mongoose_bite precombat 6"; end
    elseif S.RaptorStrike:IsReady() then
      if Cast(S.RaptorStrike) then return "raptor_strike precombat 8"; end
    end
  end
end

local function CDs()
  -- harpoon,if=talent.terms_of_engagement.enabled&focus<focus.max
  if S.Harpoon:IsCastable() and (S.TermsofEngagement:IsAvailable() and Player:Focus() < Player:FocusMax()) then
    if Cast(S.Harpoon, Settings.Survival.GCDasOffGCD.Harpoon, nil, not Target:IsSpellInRange(S.Harpoon)) then return "harpoon cds 2"; end
  end
  if (Player:BuffUp(S.CoordinatedAssault) or Player:BuffUp(S.SpearheadBuff) or (not S.Spearhead:IsAvailable()) and not S.CoordinatedAssault:IsAvailable()) then
    -- blood_fury,if=buff.coordinated_assault.up|buff.spearhead.up|!talent.spearhead&!talent.coordinated_assault
    if S.BloodFury:IsCastable() then
      if Cast(S.BloodFury, Settings.Commons.GCDasOffGCD.Racials) then return "blood_fury cds 4"; end
    end
    -- ancestral_call,if=buff.coordinated_assault.up|buff.spearhead.up|!talent.spearhead&!talent.coordinated_assault
    if S.AncestralCall:IsCastable() then
      if Cast(S.AncestralCall, Settings.Commons.GCDasOffGCD.Racials) then return "ancestral_call cds 6"; end
    end
    -- fireblood,if=buff.coordinated_assault.up|buff.spearhead.up|!talent.spearhead&!talent.coordinated_assault
    if S.Fireblood:IsCastable() then
      if Cast(S.Fireblood, Settings.Commons.GCDasOffGCD.Racials) then return "fireblood cds 8"; end
    end
  end
  -- lights_judgment
  if S.LightsJudgment:IsCastable() then
    if Cast(S.LightsJudgment, Settings.Commons.GCDasOffGCD.Racials, nil, not Target:IsSpellInRange(S.LightsJudgment)) then return "lights_judgment cds 10"; end
  end
  -- bag_of_tricks,if=cooldown.kill_command.full_recharge_time>gcd
  if S.BagofTricks:IsCastable() and (S.KillCommand:FullRechargeTime() > Player:GCD()) then
    if Cast(S.BagofTricks, Settings.Commons.GCDasOffGCD.Racials, nil, not Target:IsSpellInRange(S.BagofTricks)) then return "bag_of_tricks cds 12"; end
  end
  -- berserking,if=buff.coordinated_assault.up|buff.spearhead.up|!talent.spearhead&!talent.coordinated_assault|time_to_die<13
  if S.Berserking:IsCastable() and (Player:BuffUp(S.CoordinatedAssault) or Player:BuffUp(S.SpearheadBuff) or (not S.Spearhead:IsAvailable()) and (not S.CoordinatedAssault:IsAvailable()) or FightRemains < 13) then
    if Cast(S.Berserking, Settings.Commons.GCDasOffGCD.Racials) then return "berserking cds 14"; end
  end
  -- muzzle
  -- Handled via Interrupt in APL()
  -- potion,if=target.time_to_die<30|buff.coordinated_assault.up|buff.spearhead.up|!talent.spearhead&!talent.coordinated_assault
  if Settings.Commons.Enabled.Potions and (FightRemains < 30 or Player:BuffUp(S.CoordinatedAssault) or Player:BuffUp(S.SpearheadBuff) or (not S.Spearhead:IsAvailable()) and not S.CoordinatedAssault:IsAvailable()) then
    local PotionSelected = Everyone.PotionSelected()
    if PotionSelected and PotionSelected:IsReady() then
      if Cast(PotionSelected, nil, Settings.Commons.DisplayStyle.Potions) then return "potion cds 16"; end
    end
  end
  -- use_items
  local TrinketToUse = Player:GetUseableTrinkets(OnUseExcludes)
  if TrinketToUse then
    if Cast(TrinketToUse, nil, Settings.Commons.DisplayStyle.Trinkets) then return "Generic use_items for " .. TrinketToUse:Name(); end
  end
  -- aspect_of_the_eagle,if=target.distance>=6
  if S.AspectoftheEagle:IsCastable() and Settings.Survival.AspectOfTheEagle and not Target:IsInRange(6) then
    if Cast(S.AspectoftheEagle, Settings.Survival.OffGCDasOffGCD.AspectOfTheEagle) then return "aspect_of_the_eagle cds 18"; end
  end
end

local function Cleave()
  -- wildfire_bomb,if=full_recharge_time<gcd
  if (S.WildfireBomb:FullRechargeTime() < Player:GCD()) then
    for _, Bomb in pairs(Bombs) do
      if Bomb:IsCastable() then
        if Cast(Bomb, nil, nil, not Target:IsSpellInRange(Bomb)) then return "wildfire_bomb cleave 2"; end
      end
    end
  end
  -- death_chakram,if=focus+cast_regen<focus.max
  if S.DeathChakram:IsCastable() and (CheckFocusCap(S.DeathChakram:ExecuteTime())) then
    if Cast(S.DeathChakram, nil, Settings.Commons.DisplayStyle.Signature, not Target:IsSpellInRange(S.DeathChakram)) then return "death_chakram cleave 4"; end
  end
  -- stampede
  if S.Stampede:IsCastable() and CDsON() then
    if Cast(S.Stampede, nil, nil, not Target:IsSpellInRange(S.Stampede)) then return "stampede cleave 6"; end
  end
  -- coordinated_assault
  if S.CoordinatedAssault:IsCastable() and CDsON() then
    if Cast(S.CoordinatedAssault, Settings.Survival.GCDasOffGCD.CoordinatedAssault, nil, not Target:IsSpellInRange(S.CoordinatedAssault)) then return "coordinated_assault cleave 8"; end
  end
  -- kill_shot,if=buff.coordinated_assault_empower.up
  if S.KillShot:IsReady() and (Player:BuffUp(S.CoordinatedAssaultBuff)) then
    if Cast(S.KillShot, nil, nil, not Target:IsSpellInRange(S.KillShot)) then return "kill_shot cleave 10"; end
  end
  -- explosive_shot
  if S.ExplosiveShot:IsReady() then
    if Cast(S.ExplosiveShot, nil, nil, not Target:IsSpellInRange(S.ExplosiveShot)) then return "explosive_shot cleave 12"; end
  end
  -- carve,if=cooldown.wildfire_bomb.full_recharge_time>spell_targets%2
  if S.Carve:IsReady() and (S.WildfireBomb:FullRechargeTime() > EnemyCount8ySplash / 2) then
    if Cast(S.Carve, nil, nil, not Target:IsInMeleeRange(5)) then return "carve cleave 14"; end
  end
  -- butchery,if=full_recharge_time<gcd
  if S.Butchery:IsReady() and (S.Butchery:FullRechargeTime() < Player:GCD()) then
    if Cast(S.Butchery, nil, nil, not Target:IsInMeleeRange(8)) then return "butchery cleave 16"; end
  end
  -- wildfire_bomb,if=!dot.wildfire_bomb.ticking
  for BombNum, Bomb in pairs(Bombs) do
    if Bomb:IsCastable() and (Target:DebuffDown(BombDebuffs[BombNum])) then
      if Cast(Bomb, nil, nil, not Target:IsSpellInRange(Bomb)) then return "wildfire_bomb cleave 18"; end
    end
  end
  -- butchery,if=dot.shrapnel_bomb.ticking&(dot.internal_bleeding.stack<2|dot.shrapnel_bomb.remains<gcd)
  if S.Butchery:IsReady() and (Target:DebuffUp(S.ShrapnelBombDebuff) and (Target:DebuffStack(S.InternalBleedingDebuff) < 2 or Target:DebuffRemains(S.ShrapnelBombDebuff) < Player:GCD())) then
    if Cast(S.Butchery, nil, nil, not Target:IsInMeleeRange(8)) then return "butchery cleave 20"; end
  end
  -- fury_of_the_eagle
  if S.FuryoftheEagle:IsCastable() then
    if Cast(S.FuryoftheEagle, nil, Settings.Commons.DisplayStyle.Signature, not Target:IsInMeleeRange(5)) then return "fury_of_the_eagle cleave 22"; end
  end
  -- carve,if=dot.shrapnel_bomb.ticking
  if S.Carve:IsReady() and (Target:DebuffUp(S.ShrapnelBombDebuff)) then
    if Cast(S.Carve, nil, nil, not Target:IsInMeleeRange(5)) then return "carve cleave 24"; end
  end
  -- flanking_strike,if=focus+cast_regen<focus.max
  if S.FlankingStrike:IsCastable() and (CheckFocusCap(S.FlankingStrike:ExecuteTime(), 30)) then
    if Cast(S.FlankingStrike, nil, nil, not Target:IsSpellInRange(S.FlankingStrike)) then return "flanking_strike cleave 26"; end
  end
  -- butchery,if=(!next_wi_bomb.shrapnel|!talent.wildfire_infusion)&cooldown.wildfire_bomb.full_recharge_time>spell_targets%2
  if S.Butchery:IsReady() and (((not S.ShrapnelBomb:IsCastable()) or not S.WildfireInfusion:IsAvailable()) and S.WildfireBomb:FullRechargeTime() > EnemyCount8ySplash / 2) then
    if Cast(S.Butchery, nil, nil, not Target:IsInMeleeRange(8)) then return "butchery cleave 28"; end
  end
  -- mongoose_bite,target_if=max:debuff.latent_poison.stack,if=debuff.latent_poison.stack>8
  if S.MongooseBite:IsReady() then
    if Everyone.CastTargetIf(S.MongooseBite, EnemyList, "max", EvaluateTargetIfFilterLatentStacks, EvaluateTargetIfRaptorStrikeCleave, not Target:IsInMeleeRange(5)) then return "mongoose_bite cleave 30"; end
  end
  -- raptor_strike,target_if=max:debuff.latent_poison.stack,if=debuff.latent_poison.stack>8
  if S.RaptorStrike:IsReady() then
    if Everyone.CastTargetIf(S.RaptorStrike, EnemyList, "max", EvaluateTargetIfFilterLatentStacks, EvaluateTargetIfRaptorStrikeCleave, not Target:IsInMeleeRange(5)) then return "raptor_strike cleave 32"; end
  end
  -- kill_command,target_if=min:bloodseeker.remains,if=focus+cast_regen<focus.max&full_recharge_time<gcd
  if S.KillCommand:IsCastable() and (CheckFocusCap(S.KillCommand:ExecuteTime()) and S.KillCommand:FullRechargeTime() < Player:GCD()) then
    if Everyone.CastTargetIf(S.KillCommand, EnemyList, "min", EvaluateTargetIfFilterBloodseekerRemains, nil, not Target:IsSpellInRange(S.KillCommand)) then return "kill_command cleave 34"; end
  end
  -- carve
  if S.Carve:IsReady() then
    if Cast(S.Carve, nil, nil, not Target:IsInMeleeRange(5)) then return "carve cleave 36"; end
  end
  -- kill_shot
  if S.KillShot:IsReady() then
    if Cast(S.KillShot, nil, nil, not Target:IsSpellInRange(S.KillShot)) then return "kill_shot cleave 38"; end
  end
  -- steel_trap,if=focus+cast_regen<focus.max
  if S.SteelTrap:IsCastable() and (CheckFocusCap(S.SteelTrap:ExecuteTime())) then
    if Cast(S.SteelTrap, Settings.Commons2.GCDasOffGCD.SteelTrap, nil, not Target:IsInRange(40)) then return "steel_trap cleave 40"; end
  end
  -- serpent_sting,target_if=min:remains,if=refreshable&target.time_to_die>12&(!talent.vipers_venom|talent.hydras_bite)
  if S.SerpentSting:IsReady() then
    if Everyone.CastTargetIf(S.SerpentSting, EnemyList, "min", EvaluateTargetIfFilterSerpentStingRemains, EvaluateTargetIfSerpentStingCleave, not Target:IsSpellInRange(S.SerpentSting)) then return "serpent_sting cleave 42"; end
  end
  -- mongoose_bite,target_if=min:dot.serpent_sting.remains
  if S.MongooseBite:IsReady() then
    if Everyone.CastTargetIf(S.MongooseBite, EnemyList, "min", EvaluateTargetIfFilterSerpentStingRemains, nil, not Target:IsInMeleeRange(5)) then return "mongoose_bite cleave 44"; end
  end
  -- raptor_strike,target_if=min:dot.serpent_sting.remains
  if S.RaptorStrike:IsReady() then
    if Everyone.CastTargetIf(S.RaptorStrike, EnemyList, "min", EvaluateTargetIfFilterSerpentStingRemains, nil, not Target:IsInMeleeRange(5)) then return "raptor_strike cleave 46"; end
  end
end

local function ST()
  -- death_chakram,if=focus+cast_regen<focus.max|talent.spearhead&!cooldown.spearhead.remains
  if S.DeathChakram:IsCastable() and (CheckFocusCap(S.DeathChakram:ExecuteTime()) or S.Spearhead:IsAvailable() and S.Spearhead:CooldownUp()) then
    if Cast(S.DeathChakram, nil, Settings.Commons.DisplayStyle.Signature, not Target:IsSpellInRange(S.DeathChakram)) then return "death_chakram st 2"; end
  end
  -- spearhead,if=focus+action.kill_command.cast_regen>focus.max-10&(cooldown.death_chakram.remains|!talent.death_chakram)
  if S.Spearhead:IsCastable() and CDsON() and (Player:Focus() + Player:FocusCastRegen(S.KillCommand:ExecuteTime()) + 21 > Player:FocusMax() - 10 and (S.DeathChakram:CooldownDown() or not S.DeathChakram:IsAvailable())) then
    if Cast(S.Spearhead, nil, nil, not Target:IsSpellInRange(S.Spearhead)) then return "spearhead st 4"; end
  end
  -- kill_shot,if=buff.coordinated_assault_empower.up
  if S.KillShot:IsReady() and (Player:BuffUp(S.CoordinatedAssaultBuff)) then
    if Cast(S.KillShot, nil, nil, not Target:IsSpellInRange(S.KillShot)) then return "kill_shot st 6"; end
  end
  -- kill_command,target_if=min:bloodseeker.remains,if=full_recharge_time<gcd&focus+cast_regen<focus.max&buff.deadly_duo.stack>1
  if S.KillCommand:IsCastable() and (S.KillCommand:FullRechargeTime() < Player:GCD() and CheckFocusCap(S.KillCommand:ExecuteTime(), 21) and Player:BuffStack(S.DeadlyDuoBuff) > 1) then
    if Everyone.CastTargetIf(S.KillCommand, EnemyList, "min", EvaluateTargetIfFilterBloodseekerRemains, nil, not Target:IsSpellInRange(S.KillCommand)) then return "kill_command st 8"; end
  end
  -- mongoose_bite,if=buff.spearhead.remains
  if S.MongooseBite:IsReady() and (Player:BuffUp(S.SpearheadBuff)) then
    if Cast(S.MongooseBite, nil, nil, not Target:IsInMeleeRange(5)) then return "mongoose_bite st 10"; end
  end
  -- mongoose_bite,if=active_enemies=1&target.time_to_die<focus%(variable.mb_rs_cost-cast_regen)*gcd|buff.mongoose_fury.up&buff.mongoose_fury.remains<gcd
  if S.MongooseBite:IsReady() and (EnemyCount8ySplash == 1 and Target:TimeToDie() < Player:Focus() / (MBRSCost - Player:FocusCastRegen(S.MongooseBite:ExecuteTime())) * Player:GCD() or Player:BuffUp(S.MongooseFuryBuff) and Player:BuffRemains(S.MongooseFuryBuff) < Player:GCD()) then
    if Cast(S.MongooseBite, nil, nil, not Target:IsInMeleeRange(5)) then return "mongoose_bite st 12"; end
  end
  -- kill_shot
  if S.KillShot:IsReady() then
    if Cast(S.KillShot, nil, nil, not Target:IsSpellInRange(S.KillShot)) then return "kill_shot st 14"; end
  end
  -- raptor_strike,if=active_enemies=1&target.time_to_die<focus%(variable.mb_rs_cost-cast_regen)*gcd
  if S.RaptorStrike:IsReady() and (EnemyCount8ySplash == 1 and Target:TimeToDie() < Player:Focus() / (MBRSCost - Player:FocusCastRegen(S.RaptorStrike:ExecuteTime())) * Player:GCD()) then
    if Cast(S.RaptorStrike, nil, nil, not Target:IsInMeleeRange(5)) then return "raptor_strike st 16"; end
  end
  -- serpent_sting,target_if=min:remains,if=!dot.serpent_sting.ticking&target.time_to_die>7&!talent.vipers_venom
  if S.SerpentSting:IsReady() and (not S.VipersVenom:IsAvailable()) then
    if Everyone.CastTargetIf(S.SerpentSting, EnemyList, "min", EvaluateTargetIfFilterSerpentStingRemains, EvaluateTargetIfSerpentStingST, not Target:IsSpellInRange(S.SerpentSting)) then return "serpent_sting st 18"; end
  end
  -- mongoose_bite,if=talent.alpha_predator&buff.mongoose_fury.up&buff.mongoose_fury.remains<focus%(variable.mb_rs_cost-cast_regen)*gcd
  if S.MongooseBite:IsReady() and (S.AlphaPredator:IsAvailable() and Player:BuffUp(S.MongooseFuryBuff) and Player:BuffRemains(S.MongooseFuryBuff) < Player:Focus() / (MBRSCost - Player:FocusCastRegen(S.MongooseBite:ExecuteTime())) * Player:GCD()) then
    if Cast(S.MongooseBite, nil, nil, not Target:IsInMeleeRange(5)) then return "mongoose_bite st 20"; end
  end
  -- flanking_strike,if=focus+cast_regen<focus.max
  if S.FlankingStrike:IsCastable() and (CheckFocusCap(S.FlankingStrike:ExecuteTime(), 30)) then
    if Cast(S.FlankingStrike, nil, nil, not Target:IsSpellInRange(S.FlankingStrike)) then return "flanking_strike st 22"; end
  end
  -- coordinated_assault,if=!talent.coordinated_kill&target.health.pct<20&(!buff.spearhead.remains&cooldown.spearhead.remains|!talent.spearhead)|talent.coordinated_kill&(!buff.spearhead.remains&cooldown.spearhead.remains|!talent.spearhead)
  if S.CoordinatedAssault:IsCastable() and CDsON() and ((not S.CoordinatedKill:IsAvailable()) and Target:HealthPercentage() < 20 and (Player:BuffDown(S.SpearheadBuff) and S.Spearhead:CooldownDown() or not S.Spearhead:IsAvailable()) or S.CoordinatedKill:IsAvailable() and (Player:BuffDown(S.SpearheadBuff) and S.Spearhead:CooldownDown() or not S.Spearhead:IsAvailable())) then
    if Cast(S.CoordinatedAssault, Settings.Survival.GCDasOffGCD.CoordinatedAssault, nil, not Target:IsSpellInRange(S.CoordinatedAssault)) then return "coordinated_assault st 24"; end
  end
  -- wildfire_bomb,if=next_wi_bomb.pheromone&!buff.mongoose_fury.up&focus+cast_regen<focus.max-action.kill_command.cast_regen*2
  if S.PheromoneBomb:IsCastable() and (S.PheromoneBomb:IsCastable() and Player:BuffDown(S.MongooseFuryBuff) and Player:Focus() + Player:FocusCastRegen(S.PheromoneBomb:ExecuteTime()) < Player:FocusMax() - (Player:FocusCastRegen(S.KillCommand:ExecuteTime()) + 21) * 2) then
    if Cast(S.PheromoneBomb, nil, nil, not Target:IsSpellInRange(S.PheromoneBomb)) then return "wildfire_bomb st 26"; end
  end
  -- kill_command,target_if=min:bloodseeker.remains,if=full_recharge_time<gcd&focus+cast_regen<focus.max
  if S.KillCommand:IsCastable() and (S.KillCommand:FullRechargeTime() < Player:GCD() and CheckFocusCap(S.KillCommand:ExecuteTime(), 21)) then
    if Everyone.CastTargetIf(S.KillCommand, EnemyList, "min", EvaluateTargetIfFilterBloodseekerRemains, nil, not Target:IsSpellInRange(S.KillCommand)) then return "kill_command st 28"; end
  end
  -- mongoose_bite,if=dot.shrapnel_bomb.ticking
  if S.MongooseBite:IsReady() and (Target:DebuffUp(S.ShrapnelBombDebuff)) then
    if Cast(S.MongooseBite, nil, nil, not Target:IsInMeleeRange(5)) then return "mongoose_bite st 30"; end
  end
  -- serpent_sting,target_if=min:remains,if=refreshable&!talent.vipers_venom
  if S.SerpentSting:IsReady() and (not S.VipersVenom:IsAvailable()) then
    if Everyone.CastTargetIf(S.SerpentSting, EnemyList, "min", EvaluateTargetIfFilterSerpentStingRemains, EvaluateTargetIfSerpentStingST2, not Target:IsSpellInRange(S.SerpentSting)) then return "serpent_sting st 32"; end
  end
  -- wildfire_bomb,if=full_recharge_time<gcd&!set_bonus.tier29_2pc
  if (S.WildfireBomb:FullRechargeTime() < Player:GCD() and not Player:HasTier(29, 2)) then
    for _, Bomb in pairs(Bombs) do
      if Bomb:IsCastable() then
        if Cast(Bomb, nil, nil, not Target:IsSpellInRange(Bomb)) then return "wildfire_bomb st 34"; end
      end
    end
  end
  -- mongoose_bite,target_if=max:debuff.latent_poison.stack,if=buff.mongoose_fury.up
  if S.MongooseBite:IsReady() and (Player:BuffUp(S.MongooseFuryBuff)) then
    if Everyone.CastTargetIf(S.MongooseBite, EnemyList, "max", EvaluateTargetIfFilterLatentStacks, nil, not Target:IsInMeleeRange(5)) then return "mongoose_bite st 36"; end
  end
  -- wildfire_bomb,if=full_recharge_time<gcd
  if (S.WildfireBomb:FullRechargeTime() < Player:GCD()) then
    for _, Bomb in pairs(Bombs) do
      if Bomb:IsCastable() then
        if Cast(Bomb, nil, nil, not Target:IsSpellInRange(Bomb)) then return "wildfire_bomb st 38"; end
      end
    end
  end
  -- mongoose_bite,target_if=max:debuff.latent_poison.stack,if=focus+action.kill_command.cast_regen>focus.max-10
  if S.MongooseBite:IsReady() and (Player:Focus() + Player:FocusCastRegen(S.KillCommand:ExecuteTime()) + 21 > Player:FocusMax() - 10) then
    if Everyone.CastTargetIf(S.MongooseBite, EnemyList, "max", EvaluateTargetIfFilterLatentStacks, nil, not Target:IsInMeleeRange(5)) then return "mongoose_bite st 40"; end
  end
  -- stampede
  if S.Stampede:IsCastable() and CDsON() then
    if Cast(S.Stampede, Settings.Commons2.GCDasOffGCD.Stampede, nil, not Target:IsSpellInRange(S.Stampede)) then return "stampede st 42"; end
  end
  -- explosive_shot,if=talent.ranger
  if S.ExplosiveShot:IsReady() and (S.Ranger:IsAvailable()) then
    if Cast(S.ExplosiveShot, nil, nil, not Target:IsSpellInRange(S.ExplosiveShot)) then return "explosive_shot st 44"; end
  end
  -- raptor_strike,target_if=max:debuff.latent_poison.stack
  if S.RaptorStrike:IsReady() then
    if Everyone.CastTargetIf(S.RaptorStrike, EnemyList, "max", EvaluateTargetIfFilterLatentStacks, nil, not Target:IsInMeleeRange(5)) then return "raptor_strike st 46"; end
  end
  -- steel_trap
  if S.SteelTrap:IsCastable() then
    if Cast(S.SteelTrap, Settings.Commons2.GCDasOffGCD.SteelTrap, nil, not Target:IsInRange(40)) then return "steel_trap st 48"; end
  end
  -- wildfire_bomb,if=!dot.wildfire_bomb.ticking
  for BombNum, Bomb in pairs(Bombs) do
    if Bomb:IsCastable() and (Target:DebuffDown(BombDebuffs[BombNum])) then
      if Cast(Bomb, nil, nil, not Target:IsSpellInRange(Bomb)) then return "wildfire_bomb st 50"; end
    end
  end
  -- kill_command,target_if=min:bloodseeker.remains,if=focus+cast_regen<focus.max
  if S.KillCommand:IsCastable() and (CheckFocusCap(S.KillCommand:ExecuteTime(), 21)) then
    if Everyone.CastTargetIf(S.KillCommand, EnemyList, "min", EvaluateTargetIfFilterBloodseekerRemains, nil, not Target:IsSpellInRange(S.KillCommand)) then return "kill_command st 52"; end
  end
  -- coordinated_assault,if=!talent.coordinated_kill&time_to_die>140
  if S.CoordinatedAssault:IsCastable() and ((not S.CoordinatedKill:IsAvailable()) and Target:TimeToDie() > 140) then
    if Cast(S.CoordinatedAssault, Settings.Survival.GCDasOffGCD.CoordinatedAssault, nil, not Target:IsSpellInRange(S.CoordinatedAssault)) then return "coordinated_assault st 54"; end
  end
  -- fury_of_the_eagle,interrupt=1
  if S.FuryoftheEagle:IsCastable() then
    if Cast(S.FuryoftheEagle, nil, Settings.Commons.DisplayStyle.Signature, not Target:IsInMeleeRange(5)) then return "fury_of_the_eagle st 56"; end
  end
end

local function APL()
  -- Target Count Checking
  local EagleUp = Player:BuffUp(S.AspectoftheEagle)
  if AoEON() then
    if EagleUp and not Target:IsInMeleeRange(8) then
      EnemyCount8ySplash = Target:GetEnemiesInSplashRangeCount(8)
    else
      EnemyCount8ySplash = #Player:GetEnemiesInRange(8)
    end
  else
    EnemyCount8ySplash = 1
  end

  if EagleUp then
    EnemyList = Player:GetEnemiesInRange(40)
  else
    EnemyList = Player:GetEnemiesInRange(8)
  end

  if Everyone.TargetIsValid() or Player:AffectingCombat() then
    -- Calculate fight_remains
    BossFightRemains = HL.BossFightRemains(nil, true)
    FightRemains = BossFightRemains
    if FightRemains == 11111 then
      FightRemains = HL.FightRemains(EnemyList, false)
    end
  end

  -- Pet Management; Conditions handled via override
  if S.SummonPet:IsCastable() then
    if Cast(SummonPetSpells[Settings.Commons2.SummonPetSlot]) then return "Summon Pet"; end
  end
  if S.RevivePet:IsCastable() then
    if Cast(S.RevivePet, Settings.Commons2.GCDasOffGCD.RevivePet) then return "Revive Pet"; end
  end
  if S.MendPet:IsCastable() then
    if Cast(S.MendPet, Settings.Commons2.GCDasOffGCD.MendPet) then return "Mend Pet"; end
  end

  if Everyone.TargetIsValid() then
    -- Out of Combat
    if not Player:AffectingCombat() then
      local ShouldReturn = Precombat(); if ShouldReturn then return ShouldReturn; end
    end
    -- Exhilaration
    if S.Exhilaration:IsCastable() and Player:HealthPercentage() <= Settings.Commons2.ExhilarationHP then
      if Cast(S.Exhilaration, Settings.Commons2.GCDasOffGCD.Exhilaration) then return "Exhilaration"; end
    end
    -- muzzle
    local ShouldReturn = Everyone.Interrupt(5, S.Muzzle, Settings.Survival.OffGCDasOffGCD.Muzzle, StunInterrupts); if ShouldReturn then return ShouldReturn; end
    -- auto_attack
    -- Manually added: If out of range, use Aspect of the Eagle, otherwise Harpoon to get back into range
    if not EagleUp and not Target:IsInMeleeRange(8) then
      if S.AspectoftheEagle:IsCastable() then
        if Cast(S.AspectoftheEagle, Settings.Survival.OffGCDasOffGCD.AspectOfTheEagle) then return "aspect_of_the_eagle oor"; end
      end
      if S.Harpoon:IsCastable() then
        if Cast(S.Harpoon, Settings.Survival.GCDasOffGCD.Harpoon, nil, not Target:IsSpellInRange(S.Harpoon)) then return "harpoon oor"; end
      end
    end
    -- call_action_list,name=cds
    if (CDsON()) then
      local ShouldReturn = CDs(); if ShouldReturn then return ShouldReturn; end
    end
    -- call_action_list,name=st,if=active_enemies<3
    if (EnemyCount8ySplash < 3) then
      local ShouldReturn = ST(); if ShouldReturn then return ShouldReturn; end
    end
    -- call_action_list,name=cleave,if=active_enemies>2
    if (EnemyCount8ySplash > 2) then
      local ShouldReturn = Cleave(); if ShouldReturn then return ShouldReturn; end
    end
    -- arcane_torrent
    if S.ArcaneTorrent:IsCastable() and CDsON() then
      if Cast(S.ArcaneTorrent, Settings.Commons.OffGCDasOffGCD.Racials, nil, not Target:IsInRange(8)) then return "arcane_torrent main 888"; end
    end
    -- PoolFocus if nothing else to do
    if HR.CastAnnotated(S.PoolFocus, false, "WAIT") then return "Pooling Focus"; end
  end
end

local function OnInit ()
  HR.Print("Survival Hunter rotation is currently a work in progress, but has been updated for patch 10.0.")
end

HR.SetAPL(255, APL, OnInit)
