--- Localize Vars
-- Addon
local addonName, addonTable = ...;
-- HeroLib
local HL = HeroLib;
local Cache = HeroCache;
local Unit = HL.Unit;
local Player = Unit.Player;
local Target = Unit.Target;
local Spell = HL.Spell;
local Item = HL.Item;
local MouseOver = Unit.MouseOver;
local MultiSpell = HL.MultiSpell;
local Delay      = C_Timer.After;
-- Lua
local pairs = pairs;
local tableconcat = table.concat;
local tostring = tostring;
local tableinsert = table.insert;

if not Spell.Warrior then
    Spell.Warrior = {};
end



RubimRH.Spell[72] = {
  autoattack = Spell(274738), --ancestral call
  lust1 = Spell(57724),
  lust2 = Spell(57723),
  lust3 = Spell(80354),
  lust4 = Spell(95809),
  lust5 = Spell(264689),
    lustAT = Spell(265221), -- fireblood
    -- Racials
  AncestralCall                         = Spell(274738),
  ArcaneTorrent                         = Spell(50613),
  BagofTricks                           = Spell(312411),
  Berserking                            = Spell(26297),
  BloodFury                             = Spell(20572),
  Fireblood                             = Spell(265221),
  LightsJudgment                        = Spell(255647),
  -- Abilities
  BattleShout                           = Spell(6673),
  BattleStance                          = Spell(386164),
  Charge                                = Spell(100),
  HeroicThrow                           = Spell(57755),
  Pummel                                = Spell(6552),
  Slam                                  = Spell(1464),
  VictoryRush                           = Spell(34428),
  DefensiveStance                       = Spell(386208),
  -- Talents
  Avatar                                = Spell(107574),
  BerserkerRage                         = Spell(18499),
  BerserkersTorment                     = Spell(390123),
  Bladestorm                            = MultiSpell(227847, 389774),
  BloodandThunder                       = Spell(384277),
  ChampionsSpear                        = Spell(376079),
  DoubleTime                            = Spell(103827),
  CrushingForce                         = Spell(382764),
  FrothingBerserker                     = Spell(215571),
  Hurricane                             = Spell(390563),
  ImmovableObject                       = Spell(394307),
  IntimidatingShout                     = Spell(5246),
  HeroicLeap                            = Spell(6544),
  ImpendingVictory                      = Spell(202168),
  OverwhelmingRage                      = Spell(382767),
  RallyingCry                           = Spell(97462),
  Ravager                               = Spell(228920),
  RumblingEarth                         = Spell(275339),
  Shockwave                             = Spell(46968),
  SonicBoom                             = Spell(390725),
  SpellReflection                       = Spell(23920),
  StormBolt                             = Spell(107570),
  ThunderClap                           = Spell(6343),
  ThunderousRoar                        = Spell(384318),
  TitanicThrow                          = Spell(384090),
  WreckingThrow                         = Spell(384110),
  -- Buffs
  AvatarBuff                            = Spell(107574),
  BattleShoutBuff                       = Spell(6673),
  ChampionsMightBuff                    = Spell(386286),
  HurricaneBuff                         = Spell(390581),
  WarMachineBuff                        = Spell(262232),
  -- Debuffs
  ChampionsMightDebuff                  = Spell(376080),
  MarkofFyralathDebuff                  = Spell(414532),
  ThunderousRoarDebuff                  = Spell(397364),
  -- Pool
  Pool                                  = Spell(999910),



-- Abilities
BerserkerStance                       = Spell(386196),
Bloodbath                             = Spell(335096),
CrushingBlow                          = Spell(335097),
Execute                               = MultiSpell(5308, 280735),
Whirlwind                             = Spell(190411),
-- Talents
AngerManagement                       = Spell(152278),
AshenJuggernaut                       = Spell(392536),
Bloodthirst                           = Spell(23881),
DancingBlades                         = Spell(391683),
ImprovedWhilwind                      = Spell(12950),
Massacre                              = Spell(206315),
OdynsFury                             = Spell(385059),
Onslaught                             = Spell(315720),
RagingBlow                            = Spell(85288),
Rampage                               = Spell(184367),
RecklessAbandon                       = Spell(396749),
Recklessness                          = Spell(1719),
Tenderize                             = Spell(388933),
TitanicRage                           = Spell(394329),
TitansTorment                         = Spell(390135),
WrathandFury                          = Spell(392936),
-- Buffs
AshenJuggernautBuff                   = Spell(392537),
BloodcrazeBuff                        = Spell(393951),
DancingBladesBuff                     = Spell(391688),
EnrageBuff                            = Spell(184362),
FuriousBloodthirstBuff                = Spell(423211), -- T31 2pc
MeatCleaverBuff                       = Spell(85739),
MercilessAssaultBuff                  = Spell(409983),
RecklessnessBuff                      = Spell(1719),
SuddenDeathBuff                       = Spell(280776),
-- Debuffs
GushingWoundDebuff                    = Spell(385042),
OdynsFuryDebuff                       = Spell(385060),



  -- Abilities
  ThunderBlastAbility                   = Spell(435222),
  -- Talents
  CrashingThunder                       = Spell(436707),
  ThunderBlast                          = Spell(435607),
  -- Buffs
  BurstofPowerBuff                      = Spell(437121),
  ThunderBlastBuff                      = Spell(435615),










}

local S = RubimRH.Spell[72]

if not Item.Warrior then Item.Warrior = {}; end

Item.Warrior.Fury = {
healingpoticon = Item(169451),
tx1 = Item(118330),
tx2 = Item(114616),
HPIcon = Item(169451),
};

local I = Item.Warrior.Fury;

-- --- ===== Rotation Variables =====
-- local Trinket1, Trinket2
-- local VarTrinket1ID, VarTrinket2ID
-- local VarTrinket1Spell, VarTrinket2Spell
-- local VarTrinket1Range, VarTrinket2Range
-- local VarTrinket1CastTime, VarTrinket2CastTime
-- local VarTrinket1CD, VarTrinket2CD
-- local VarTrinket1BL, VarTrinket2BL
-- local VarTrinket1Exclude, VarTrinket2Exclude
-- local VarTrinket1Sync, VarTrinket2Sync
-- local VarTrinket1Buffs, VarTrinket2Buffs
-- local VarTrinket1Manual, VarTrinket2Manual
-- local VarTrinketPriority
-- local VarSTPlanning, VarAddsRemain
-- local EnemiesMelee, EnemiesMeleeCount
-- local TargetInMeleeRange
-- local EnrageUp
-- local BossFightRemains = 11111
-- local FightRemains = 11111

-- --- ===== Trinket Variables (from Precombat) =====
-- local function SetTrinketVariables()
--   Trinket1, Trinket2 = Player:GetTrinketItems()
--   VarTrinket1ID = Trinket1:ID()
--   VarTrinket2ID = Trinket2:ID()

--   -- If we don't have trinket items, try again in 2 seconds.
--   if VarTrinket1ID == 0 or VarTrinket2ID == 0 then
--     Delay(2, function()
--         Trinket1, Trinket2 = Player:GetTrinketItems()
--         VarTrinket1ID = Trinket1:ID()
--         VarTrinket2ID = Trinket2:ID()
--       end
--     )
--   end

--   VarTrinket1Spell = Trinket1:OnUseSpell()
--   VarTrinket1Range = (VarTrinket1Spell and VarTrinket1Spell.MaximumRange > 0 and VarTrinket1Spell.MaximumRange <= 100) and VarTrinket1Spell.MaximumRange or 100
--   VarTrinket1CastTime = VarTrinket1Spell and VarTrinket1Spell:CastTime() or 0
--   VarTrinket2Spell = Trinket2:OnUseSpell()
--   VarTrinket2Range = (VarTrinket2Spell and VarTrinket2Spell.MaximumRange > 0 and VarTrinket2Spell.MaximumRange <= 100) and VarTrinket2Spell.MaximumRange or 100
--   VarTrinket2CastTime = VarTrinket2Spell and VarTrinket2Spell:CastTime() or 0

--   VarTrinket1CD = Trinket1:Cooldown()
--   VarTrinket2CD = Trinket2:Cooldown()

--   VarTrinket1BL = Player:IsItemBlacklisted(Trinket1)
--   VarTrinket2BL = Player:IsItemBlacklisted(Trinket2)

--   VarTrinket1Exclude = (VarTrinket1ID == 193757 or VarTrinket1ID == 194301)
--   VarTrinket2Exclude = (VarTrinket2ID == 193757 or VarTrinket2ID == 194301)

--   VarTrinket1Sync = 0.5
--   if Trinket1:HasUseBuff() and (Trinket1CD % 90 == 0 or Trinket1CD) then
--     VarTrinket1Sync = 1
--   end
--   VarTrinket2Sync = 0.5
--   if Trinket2:HasUseBuff() and (Trinket2CD % 90 == 0) then
--     VarTrinket2Sync = 1
--   end

--   VarTrinket1Buffs = Trinket1:HasUseBuff()
--   VarTrinket2Buffs = Trinket2:HasUseBuff()

--   -- Note: Using the below buff durations to avoid potential divide by zero errors.
--   local T1BuffDuration = (Trinket1:BuffDuration() > 0) and Trinket1:BuffDuration() or 1
--   local T2BuffDuration = (Trinket2:BuffDuration() > 0) and Trinket2:BuffDuration() or 1
--   VarTrinketPriority = 1
--   if not VarTrinket1Buffs and VarTrinket2Buffs or VarTrinket2Buffs and ((VarTrinket2CD / T2BuffDuration) * (VarTrinket2Sync)) > ((VarTrinket1CD / T1BuffDuration) * (VarTrinket1Sync)) then
--     VarTrinketPriority = 2
--   end

--   VarTrinket1Manual = VarTrinket1ID == I.AlgetharPuzzleBox:ID()
--   VarTrinket2Manual = VarTrinket2ID == I.AlgetharPuzzleBox:ID()
-- end
-- SetTrinketVariables()

-- --- ===== Stun Interrupts List =====
-- local StunInterrupts = {
--   {S.StormBolt, "Cast Storm Bolt (Interrupt)", function () return true; end},
-- }

-- --- ===== Event Registrations =====
-- HL:RegisterForEvent(function()
--   BossFightRemains = 11111
--   FightRemains = 11111
-- end, "PLAYER_REGEN_ENABLED")

-- HL:RegisterForEvent(function()
--   SetTrinketVariables()
-- end, "PLAYER_EQUIPMENT_CHANGED", "SPELLS_CHANGED", "LEARNED_SPELL_IN_TAB")

-- --- ===== Rotation Functions =====
-- local function Precombat()
 
-- --   -- Manually added: Group Battle Shout check
-- --   if S.BattleShout:IsCastable() and Everyone.GroupBuffMissing(S.BattleShoutBuff) then
-- --     if Cast(S.BattleShout, Settings.CommonsOGCD.GCDasOffGCD.BattleShout) then return "battle_shout precombat 2"; end
-- --   end
-- --   -- use_item,name=algethar_puzzle_box
-- --   if Settings.Commons.Enabled.Trinkets and I.AlgetharPuzzleBox:IsEquippedAndReady() then
-- --     if Cast(I.AlgetharPuzzleBox, nil, Settings.CommonsDS.DisplayStyle.Trinkets) then return "algethar_puzzle_box precombat 4"; end
-- --   end
-- --   -- berserker_stance,toggle=on
-- --   if S.BerserkerStance:IsCastable() and Player:BuffDown(S.BerserkerStance, true) then
-- --     if Cast(S.BerserkerStance) then return "berserker_stance precombat 6"; end
-- --   end
-- --   -- recklessness,if=!equipped.fyralath_the_dreamrender
-- --   if CDsON() and S.Recklessness:IsCastable() and (not I.Fyralath:IsEquipped()) then
-- --     if Cast(S.Recklessness, Settings.Fury.GCDasOffGCD.Recklessness) then return "recklessness precombat 8"; end
-- --   end
-- --   -- avatar,if=!talent.titans_torment
-- --   if CDsON() and S.Avatar:IsCastable() and (not S.TitansTorment:IsAvailable()) then
-- --     if Cast(S.Avatar, Settings.Fury.GCDasOffGCD.Avatar) then return "avatar precombat 10"; end
-- --   end
-- --   -- Manually Added: Charge if not in melee range. Bloodthirst if in melee range
-- --   if S.Bloodthirst:IsCastable() and TargetInMeleeRange then
-- --     if Cast(S.Bloodthirst, nil, nil, not TargetInMeleeRange) then return "bloodthirst precombat 12"; end
-- --   end
-- --   if S.Charge:IsReady() and not TargetInMeleeRange then
-- --     if Cast(S.Charge, nil, nil, not Target:IsInRange(25)) then return "charge precombat 14"; end
-- --   end
-- end

-- local function MultiTarget()
-- --   -- recklessness,if=(!talent.anger_management&cooldown.avatar.remains<1&talent.titans_torment)|talent.anger_management|!talent.titans_torment
-- --   if CDsON() and S.Recklessness:IsCastable() and ((not S.AngerManagement:IsAvailable() and S.Avatar:CooldownRemains() < 1 and S.TitansTorment:IsAvailable()) or S.AngerManagement:IsAvailable() or not S.TitansTorment:IsAvailable()) then
-- --     if Cast(S.Recklessness, Settings.Fury.GCDasOffGCD.Recklessness) then return "recklessness multi_target 2"; end
-- --   end
-- --   -- avatar,if=talent.titans_torment&(buff.enrage.up|talent.titanic_rage)|!talent.titans_torment
-- --   if CDsON() and S.Avatar:IsCastable() and (S.TitansTorment:IsAvailable() and (EnrageUp or S.TitanicRage:IsAvailable()) or not S.TitansTorment:IsAvailable()) then
-- --     if Cast(S.Avatar, Settings.Fury.GCDasOffGCD.Avatar) then return "avatar multi_target 4"; end
-- --   end
-- --   -- thunderous_roar,if=buff.enrage.up
-- --   if CDsON() and S.ThunderousRoar:IsCastable() and (EnrageUp) then
-- --     if Cast(S.ThunderousRoar, Settings.Fury.GCDasOffGCD.ThunderousRoar, nil, not Target:IsInMeleeRange(12)) then return "thunderous_roar multi_target 6"; end
-- --   end
-- --   -- champions_spear,if=buff.enrage.up
-- --   if S.ChampionsSpear:IsCastable() and (EnrageUp) then
-- --     if Cast(S.ChampionsSpear, nil, Settings.CommonsDS.DisplayStyle.ChampionsSpear, not (Target:IsInRange(25) or TargetInMeleeRange)) then return "champions_spear multi_target 8"; end
-- --   end
-- --   -- odyns_fury,if=dot.odyns_fury_torment_mh.remains<1&(buff.enrage.up|talent.titanic_rage)&cooldown.avatar.remains
-- --   if CDsON() and S.OdynsFury:IsCastable() and (Target:DebuffRemains(S.OdynsFuryDebuff) < 1 and (EnrageUp or S.TitanicRage:IsAvailable()) and S.Avatar:CooldownDown()) then
-- --     if Cast(S.OdynsFury, nil, Settings.CommonsDS.DisplayStyle.OdynsFury, not Target:IsInMeleeRange(12)) then return "odyns_fury multi_target 10"; end
-- --   end
-- --   -- whirlwind,if=buff.meat_cleaver.stack=0&talent.improved_whirlwind
-- --   if S.Whirlwind:IsCastable() and (Player:BuffDown(S.MeatCleaverBuff) and S.ImprovedWhilwind:IsAvailable()) then
-- --     if Cast(S.Whirlwind, nil, nil, not Target:IsInMeleeRange(8)) then return "whirlwind multi_target 12"; end
-- --   end
-- --   -- execute,if=buff.enrage.up&buff.ashen_juggernaut.remains<=gcd&talent.ashen_juggernaut
-- --   if S.Execute:IsReady() and (EnrageUp and Player:BuffRemains(S.AshenJuggernautBuff) <= Player:GCD() and S.AshenJuggernaut:IsAvailable()) then
-- --     if Cast(S.Execute, nil, nil, not TargetInMeleeRange) then return "execute multi_target 14"; end
-- --   end
-- --   -- rampage,if=rage.pct>85&cooldown.bladestorm.remains<=gcd&!debuff.champions_might.up
-- --   if S.Rampage:IsReady() and (Player:RagePercentage() > 85 and S.Bladestorm:CooldownRemains() <= Player:GCD() and Target:DebuffDown(S.ChampionsMightDebuff)) then
-- --     if Cast(S.Rampage, nil, nil, not TargetInMeleeRange) then return "rampage multi_target 16"; end
-- --   end
-- --   -- bladestorm,if=buff.enrage.up&cooldown.avatar.remains>=9
-- --   if CDsON() and S.Bladestorm:IsCastable() and (EnrageUp and S.Avatar:CooldownRemains() >= 9) then
-- --     if Cast(S.Bladestorm, Settings.CommonsOGCD.GCDasOffGCD.Bladestorm, nil, not TargetInMeleeRange) then return "bladestorm multi_target 18"; end
-- --   end
-- --   -- ravager,if=buff.enrage.up
-- --   if S.Ravager:IsCastable() and (EnrageUp) then
-- --     if Cast(S.Ravager, Settings.CommonsOGCD.GCDasOffGCD.Ravager, nil, not Target:IsInRange(40)) then return "ravager multi_target 20"; end
-- --   end
-- --   -- rampage,if=talent.anger_management
-- --   if S.Rampage:IsReady() and (S.AngerManagement:IsAvailable()) then
-- --     if Cast(S.Rampage, nil, nil, not TargetInMeleeRange) then return "rampage multi_target 22"; end
-- --   end
-- --   -- bloodbath,if=buff.furious_bloodthirst.up
-- --   if S.Bloodbath:IsCastable() and (Player:BuffUp(S.FuriousBloodthirstBuff)) then
-- --     if Cast(S.Bloodbath, nil, nil, not TargetInMeleeRange) then return "bloodbath multi_target 24"; end
-- --   end
-- --   -- crushing_blow
-- --   if S.CrushingBlow:IsCastable() then
-- --     if Cast(S.CrushingBlow, nil, nil, not TargetInMeleeRange) then return "crushing_blow multi_target 26"; end
-- --   end
-- --   -- onslaught,if=talent.tenderize|buff.enrage.up
-- --   if S.Onslaught:IsReady() and (S.Tenderize:IsAvailable() or EnrageUp) then
-- --     if Cast(S.Onslaught, nil, nil, not TargetInMeleeRange) then return "onslaught multi_target 28"; end
-- --   end
-- --   -- bloodbath,if=!dot.gushing_wound.remains
-- --   if S.Bloodbath:IsCastable() and (Player:BuffUp(S.FuriousBloodthirstBuff)) then
-- --     if Cast(S.Bloodbath, nil, nil, not TargetInMeleeRange) then return "bloodbath multi_target 30"; end
-- --   end
-- --   -- rampage,if=talent.reckless_abandon
-- --   if S.Rampage:IsReady() and (S.RecklessAbandon:IsAvailable()) then
-- --     if Cast(S.Rampage, nil, nil, not TargetInMeleeRange) then return "rampage multi_target 32"; end
-- --   end
-- --   -- execute,if=buff.enrage.up&((target.health.pct>35&talent.massacre|target.health.pct>20)&buff.sudden_death.remains<=gcd)
-- --   if S.Execute:IsReady() and (EnrageUp and ((Target:HealthPercentage() > 35 and S.Massacre:IsAvailable() or Target:HealthPercentage() > 20) and Player:BuffRemains(S.SuddenDeathBuff) <= Player:GCD())) then
-- --     if Cast(S.Execute, nil, nil, not TargetInMeleeRange) then return "execute multi_target 34"; end
-- --   end
-- --   -- bloodbath
-- --   if S.Bloodbath:IsCastable() then
-- --     if Cast(S.Bloodbath, nil, nil, not TargetInMeleeRange) then return "bloodbath multi_target 36"; end
-- --   end
-- --   -- bloodthirst
-- --   if S.Bloodthirst:IsCastable() then
-- --     if Cast(S.Bloodthirst, nil, nil, not TargetInMeleeRange) then return "bloodthirst multi_target 38"; end
-- --   end
-- --   -- raging_blow
-- --   if S.RagingBlow:IsCastable() then
-- --     if Cast(S.RagingBlow, nil, nil, not TargetInMeleeRange) then return "raging_blow multi_target 40"; end
-- --   end
-- --   -- execute
-- --   if S.Execute:IsReady() then
-- --     if Cast(S.Execute, nil, nil, not TargetInMeleeRange) then return "execute multi_target 42"; end
-- --   end
-- --   -- whirlwind
-- --   if S.Whirlwind:IsCastable() then
-- --     if Cast(S.Whirlwind, nil, nil, not Target:IsInMeleeRange(8)) then return "whirlwind multi_target 44"; end
-- --   end
-- end

-- local function SingleTarget()
-- --   -- ravager,if=cooldown.recklessness.remains<gcd|buff.recklessness.up
-- --   if S.Ravager:IsCastable() and (S.Recklessness:CooldownRemains() < Player:GCD() or Player:BuffUp(S.RecklessnessBuff)) then
-- --     if Cast(S.Ravager, Settings.CommonsOGCD.GCDasOffGCD.Ravager, nil, not Target:IsInRange(40)) then return "ravager single_target 2"; end
-- --   end
-- --   -- recklessness,if=!talent.anger_management|(talent.anger_management&cooldown.avatar.ready|cooldown.avatar.remains<gcd|cooldown.avatar.remains>30)
-- --   if CDsON() and S.Recklessness:IsCastable() and (not S.AngerManagement:IsAvailable() or (S.AngerManagement:IsAvailable() and S.Avatar:CooldownUp() or S.Avatar:CooldownRemains() < Player:GCD() or S.Avatar:CooldownRemains() > 30)) then
-- --     if Cast(S.Recklessness, Settings.Fury.GCDasOffGCD.Recklessness) then return "recklessness single_target 4"; end
-- --   end
-- --   -- avatar,if=!talent.titans_torment|(talent.titans_torment&(buff.enrage.up|talent.titanic_rage))
-- --   if CDsON() and S.Avatar:IsCastable() and (not S.TitansTorment:IsAvailable() or (S.TitansTorment:IsAvailable() and (EnrageUp or S.TitanicRage:IsAvailable()))) then
-- --     if Cast(S.Avatar, Settings.Fury.GCDasOffGCD.Avatar) then return "avatar single_target 6"; end
-- --   end
-- --   -- champions_spear,if=buff.enrage.up&((buff.furious_bloodthirst.up&talent.titans_torment)|!talent.titans_torment|target.time_to_die<20|active_enemies>1|!set_bonus.tier31_2pc)&raid_event.adds.in>15
-- --   if S.ChampionsSpear:IsCastable() and (EnrageUp and ((Player:BuffUp(S.FuriousBloodthirstBuff) and S.TitansTorment:IsAvailable()) or not S.TitansTorment:IsAvailable() or FightRemains < 20 or EnemiesMeleeCount > 1 or not Player:HasTier(31, 2))) then
-- --     if Cast(S.ChampionsSpear, nil, Settings.CommonsDS.DisplayStyle.ChampionsSpear, not (Target:IsInRange(25) or TargetInMeleeRange)) then return "champions_spear single_target 8"; end
-- --   end
-- --   -- whirlwind,if=spell_targets.whirlwind>1&talent.improved_whirlwind&!buff.meat_cleaver.up|raid_event.adds.in<2&talent.improved_whirlwind&!buff.meat_cleaver.up
-- --   if S.Whirlwind:IsCastable() and (EnemiesMeleeCount > 1 and S.ImprovedWhilwind:IsAvailable() and Player:BuffDown(S.MeatCleaverBuff)) then
-- --     if Cast(S.Whirlwind, nil, nil, not Target:IsInMeleeRange(8)) then return "whirlwind single_target 10"; end
-- --   end
-- --   -- execute,if=buff.ashen_juggernaut.up&buff.ashen_juggernaut.remains<gcd
-- --   if S.Execute:IsReady() and (Player:BuffUp(S.AshenJuggernautBuff) and Player:BuffRemains(S.AshenJuggernautBuff) < Player:GCD()) then
-- --     if Cast(S.Execute, nil, nil, not TargetInMeleeRange) then return "execute single_target 12"; end
-- --   end
-- --   -- bladestorm,if=buff.enrage.up&(buff.avatar.up|buff.recklessness.up&talent.anger_management)
-- --   if CDsON() and S.Bladestorm:IsCastable() and (EnrageUp and (Player:BuffUp(S.AvatarBuff) or Player:BuffUp(S.RecklessnessBuff) and S.AngerManagement:IsAvailable())) then
-- --     if Cast(S.Bladestorm, Settings.CommonsOGCD.GCDasOffGCD.Bladestorm, nil, not TargetInMeleeRange) then return "bladestorm single_target 14"; end
-- --   end
-- --   -- odyns_fury,if=buff.enrage.up&(spell_targets.whirlwind>1|raid_event.adds.in>15)&(talent.dancing_blades&buff.dancing_blades.remains<5|!talent.dancing_blades)
-- --   if CDsON() and S.OdynsFury:IsCastable() and (EnrageUp and (S.DancingBlades:IsAvailable() and Player:BuffRemains(S.DancingBladesBuff) < 5 or not S.DancingBlades:IsAvailable())) then
-- --     if Cast(S.OdynsFury, nil, Settings.CommonsDS.DisplayStyle.OdynsFury, not Target:IsInMeleeRange(12)) then return "odyns_fury single_target 16"; end
-- --   end
-- --   -- rampage,if=talent.anger_management&(buff.recklessness.up|buff.enrage.remains<gcd|rage.pct>85)
-- --   if S.Rampage:IsReady() and (S.AngerManagement:IsAvailable() and (Player:BuffUp(S.RecklessnessBuff) or Player:BuffRemains(S.EnrageBuff) < Player:GCD() or Player:RagePercentage() > 85)) then
-- --     if Cast(S.Rampage, nil, nil, not TargetInMeleeRange) then return "rampage single_target 18"; end
-- --   end
-- --   local BTCritChance = Player:CritChancePct() + num(Player:BuffUp(S.RecklessnessBuff)) * 20 + Player:BuffStack(S.MercilessAssaultBuff) * 10 + Player:BuffStack(S.BloodcrazeBuff) * 15
-- --   -- bloodbath,if=set_bonus.tier30_4pc&action.bloodthirst.crit_pct_current>=95
-- --   if S.Bloodbath:IsCastable() and (Player:HasTier(30, 4) and BTCritChance >= 95) then
-- --     if Cast(S.Bloodbath, nil, nil, not TargetInMeleeRange) then return "bloodbath single_target 20"; end
-- --   end
-- --   -- bloodthirst,if=(set_bonus.tier30_4pc&action.bloodthirst.crit_pct_current>=95)|(!talent.reckless_abandon&buff.furious_bloodthirst.up&buff.enrage.up&(!dot.gushing_wound.remains|buff.champions_might.up))
-- --   if S.Bloodthirst:IsCastable() and ((Player:HasTier(30, 4) and BTCritChance >= 95) or (not S.RecklessAbandon:IsAvailable() and Player:BuffUp(S.FuriousBloodthirstBuff) and EnrageUp and (Target:DebuffDown(S.GushingWoundDebuff) or Player:DebuffUp(S.ChampionsMightDebuff)))) then
-- --     if Cast(S.Bloodthirst, nil, nil, not TargetInMeleeRange) then return "bloodthirst single_target 22"; end
-- --   end
-- --   -- bloodbath,if=buff.furious_bloodthirst.up
-- --   if S.Bloodbath:IsCastable() and (Player:BuffUp(S.FuriousBloodthirstBuff)) then
-- --     if Cast(S.Bloodbath, nil, nil, not TargetInMeleeRange) then return "bloodbath single_target 24"; end
-- --   end
-- --   -- thunderous_roar,if=buff.enrage.up&(spell_targets.whirlwind>1|raid_event.adds.in>15)
-- --   if CDsON() and S.ThunderousRoar:IsCastable() and (EnrageUp) then
-- --     if Cast(S.ThunderousRoar, Settings.Fury.GCDasOffGCD.ThunderousRoar, nil, not Target:IsInMeleeRange(12)) then return "thunderous_roar single_target 26"; end
-- --   end
-- --   -- onslaught,if=buff.enrage.up|talent.tenderize
-- --   if S.Onslaught:IsReady() and (EnrageUp or S.Tenderize:IsAvailable()) then
-- --     if Cast(S.Onslaught, nil, nil, not TargetInMeleeRange) then return "onslaught single_target 28"; end
-- --   end
-- --   -- crushing_blow,if=buff.enrage.up
-- --   if S.CrushingBlow:IsCastable() and (EnrageUp) then
-- --     if Cast(S.CrushingBlow, nil, nil, not TargetInMeleeRange) then return "crushing_blow single_target 30"; end
-- --   end
-- --   -- rampage,if=talent.reckless_abandon&(buff.recklessness.up|buff.enrage.remains<gcd|rage.pct>85)
-- --   if S.Rampage:IsReady() and (S.RecklessAbandon:IsAvailable() and (Player:BuffUp(S.RecklessnessBuff) or Player:BuffRemains(S.EnrageBuff) < Player:GCD() or Player:RagePercentage() > 85)) then
-- --     if Cast(S.Rampage, nil, nil, not TargetInMeleeRange) then return "rampage single_target 32"; end
-- --   end
-- --   -- execute,if=buff.enrage.up&!buff.furious_bloodthirst.up&buff.ashen_juggernaut.up|buff.sudden_death.remains<=gcd&(target.health.pct>35&talent.massacre|target.health.pct>20)
-- --   if S.Execute:IsReady() and (EnrageUp and Player:BuffDown(S.FuriousBloodthirstBuff) and Player:BuffUp(S.AshenJuggernautBuff) or Player:BuffRemains(S.SuddenDeathBuff) <= Player:GCD() and (Target:HealthPercentage() > 35 and S.Massacre:IsAvailable() or Target:HealthPercentage() > 20)) then
-- --     if Cast(S.Execute, nil, nil, not TargetInMeleeRange) then return "execute single_target 34"; end
-- --   end
-- --   -- execute,if=buff.enrage.up
-- --   if S.Execute:IsReady() and (EnrageUp) then
-- --     if Cast(S.Execute, nil, nil, not TargetInMeleeRange) then return "execute single_target 36"; end
-- --   end
-- --   -- rampage,if=talent.anger_management
-- --   if S.Rampage:IsReady() and (S.AngerManagement:IsAvailable()) then
-- --     if Cast(S.Rampage, nil, nil, not TargetInMeleeRange) then return "rampage single_target 38"; end
-- --   end
-- --   -- bloodbath,if=buff.enrage.up&talent.reckless_abandon&!talent.wrath_and_fury
-- --   if S.Bloodbath:IsCastable() and (EnrageUp and S.RecklessAbandon:IsAvailable() and not S.WrathandFury:IsAvailable()) then
-- --     if Cast(S.Bloodbath, nil, nil, not TargetInMeleeRange) then return "bloodbath single_target 40"; end
-- --   end
-- --   -- rampage,if=target.health.pct<35&talent.massacre.enabled
-- --   if S.Rampage:IsReady() and (Target:HealthPercentage() < 35 and S.Massacre:IsAvailable()) then
-- --     if Cast(S.Rampage, nil, nil, not TargetInMeleeRange) then return "rampage single_target 42"; end
-- --   end
-- --   -- bloodthirst,if=buff.enrage.down|!buff.furious_bloodthirst.up
-- --   if S.Bloodthirst:IsCastable() and (not EnrageUp or Player:BuffDown(S.FuriousBloodthirstBuff)) then
-- --     if Cast(S.Bloodthirst, nil, nil, not TargetInMeleeRange) then return "bloodthirst single_target 44"; end
-- --   end
-- --   -- raging_blow,if=charges>1
-- --   if S.RagingBlow:IsCastable() and (S.RagingBlow:Charges() > 1) then
-- --     if Cast(S.RagingBlow, nil, nil, not TargetInMeleeRange) then return "raging_blow single_target 46"; end
-- --   end
-- --   -- crushing_blow,if=charges>1
-- --   if S.CrushingBlow:IsCastable() and (S.CrushingBlow:Charges() > 1) then
-- --     if Cast(S.CrushingBlow, nil, nil, not TargetInMeleeRange) then return "crushing_blow single_target 48"; end
-- --   end
-- --   -- bloodbath,if=buff.enrage.down
-- --   if S.Bloodbath:IsCastable() and (not EnrageUp) then
-- --     if Cast(S.Bloodbath, nil, nil, not TargetInMeleeRange) then return "bloodbath single_target 50"; end
-- --   end
-- --   -- crushing_blow,if=buff.enrage.up&talent.reckless_abandon
-- --   if S.CrushingBlow:IsCastable() and (EnrageUp and S.RecklessAbandon:IsAvailable()) then
-- --     if Cast(S.CrushingBlow, nil, nil, not TargetInMeleeRange) then return "crushing_blow single_target 52"; end
-- --   end
-- --   -- bloodthirst,if=!buff.furious_bloodthirst.up
-- --   if S.Bloodthirst:IsCastable() and (Player:BuffDown(S.FuriousBloodthirstBuff)) then
-- --     if Cast(S.Bloodthirst, nil, nil, not TargetInMeleeRange) then return "bloodthirst single_target 54"; end
-- --   end
-- --   -- raging_blow,if=charges>1
-- --   if S.RagingBlow:IsCastable() and (S.RagingBlow:Charges() > 1) then
-- --     if Cast(S.RagingBlow, nil, nil, not TargetInMeleeRange) then return "raging_blow single_target 56"; end
-- --   end
-- --   -- rampage
-- --   if S.Rampage:IsReady() then
-- --     if Cast(S.Rampage, nil, nil, not TargetInMeleeRange) then return "rampage single_target 58"; end
-- --   end
-- --   -- bloodbath
-- --   if S.Bloodbath:IsCastable() then
-- --     if Cast(S.Bloodbath, nil, nil, not TargetInMeleeRange) then return "bloodbath single_target 60"; end
-- --   end
-- --   -- raging_blow
-- --   if S.RagingBlow:IsCastable() then
-- --     if Cast(S.RagingBlow, nil, nil, not TargetInMeleeRange) then return "raging_blow single_target 62"; end
-- --   end
-- --   -- crushing_blow
-- --   if S.CrushingBlow:IsCastable() then
-- --     if Cast(S.CrushingBlow, nil, nil, not TargetInMeleeRange) then return "crushing_blow single_target 64"; end
-- --   end
-- --   -- bloodthirst
-- --   if S.Bloodthirst:IsCastable() then
-- --     if Cast(S.Bloodthirst, nil, nil, not TargetInMeleeRange) then return "bloodthirst single_target 66"; end
-- --   end
-- --   -- slam
-- --   if S.Slam:IsCastable() then
-- --     if Cast(S.Slam, nil, nil, not TargetInMeleeRange) then return "slam single_target 68"; end
-- --   end
-- end

-- local function Trinkets()
-- --   -- use_item,name=fyralath_the_dreamrender,if=dot.mark_of_fyralath.ticking
-- --   if Settings.Commons.Enabled.Items and I.Fyralath:IsEquippedAndReady() and (S.MarkofFyralathDebuff:AuraActiveCount() > 0) then
-- --     if Cast(I.Fyralath, nil, Settings.CommonsDS.DisplayStyle.Items, not Target:IsItemInRange(I.Fyralath)) then return "fyralath_the_dreamrender trinkets 2"; end
-- --   end
-- --   if Settings.Commons.Enabled.Trinkets then
-- --     -- use_item,use_off_gcd=1,name=algethar_puzzle_box,if=cooldown.recklessness.remains<3|(talent.anger_management&cooldown.avatar.remains<3)
-- --     if I.AlgetharPuzzleBox:IsEquippedAndReady() and (S.Recklessness:CooldownRemains() < 3 or (S.AngerManagement:IsAvailable() and S.Avatar:CooldownRemains() < 3)) then
-- --       if Cast(I.AlgetharPuzzleBox, nil, Settings.CommonsDS.DisplayStyle.Trinkets) then return "algethar_puzzle_box trinkets 4"; end
-- --     end
-- --     -- use_item,use_off_gcd=1,slot=trinket1,if=variable.trinket_1_buffs&!variable.trinket_1_manual&(!buff.avatar.up&trinket.1.cast_time>0|!trinket.1.cast_time>0)&(buff.avatar.up)&(variable.trinket_2_exclude|!trinket.2.has_cooldown|trinket.2.cooldown.remains|variable.trinket_priority=1)|trinket.1.proc.any_dps.duration>=fight_remains
-- --     if Trinket1:IsReady() and not VarTrinket1BL and (VarTrinket1Buffs and not VarTrinket1Manual and (Player:BuffDown(S.AvatarBuff) and VarTrinket1CastTime > 0 or VarTrinket1CastTime == 0) and Player:BuffUp(S.AvatarBuff) and (VarTrinket2Exclude or not Trinket2:HasCooldown() or Trinket2:CooldownDown() or VarTrinketPriority == 1) or Trinket1:BuffDuration() >= BossFightRemains) then
-- --       if Cast(Trinket1, nil, Settings.CommonsDS.DisplayStyle.Trinkets, not Target:IsInRange(VarTrinket1Range)) then return "use_item for " .. Trinket1:Name() .. " trinkets 6"; end
-- --     end
-- --     -- use_item,use_off_gcd=1,slot=trinket2,if=variable.trinket_2_buffs&!variable.trinket_2_manual&(!buff.avatar.up&trinket.2.cast_time>0|!trinket.2.cast_time>0)&(buff.avatar.up)&(variable.trinket_1_exclude|!trinket.1.has_cooldown|trinket.1.cooldown.remains|variable.trinket_priority=2)|trinket.2.proc.any_dps.duration>=fight_remains
-- --     if Trinket2:IsReady() and not VarTrinket2BL and (VarTrinket2Buffs and not VarTrinket2Manual and (Player:BuffDown(S.AvatarBuff) and VarTrinket2CastTime > 0 or VarTrinket2CastTime == 0) and Player:BuffUp(S.AvatarBuff) and (VarTrinket1Exclude or not Trinket1:HasCooldown() or Trinket1:CooldownDown() or VarTrinketPriority == 2) or Trinket2:BuffDuration() >= BossFightRemains) then
-- --       if Cast(Trinket2, nil, Settings.CommonsDS.DisplayStyle.Trinkets, not Target:IsInRange(VarTrinket2Range)) then return "use_item for " .. Trinket2:Name() .. " trinkets 8"; end
-- --     end
-- --     -- use_item,use_off_gcd=1,slot=trinket1,if=!variable.trinket_1_buffs&!variable.trinket_1_manual&(!variable.trinket_1_buffs&(trinket.2.cooldown.remains|!variable.trinket_2_buffs)|(trinket.1.cast_time>0&!buff.avatar.up|!trinket.1.cast_time>0)|cooldown.avatar.remains_expected>20)
-- --     if Trinket1:IsReady() and not VarTrinket1BL and (not VarTrinket1Buffs and not VarTrinket1Manual and (not VarTrinket1Buffs and (Trinket2:CooldownDown() or not VarTrinket2Buffs) or (VarTrinket1CastTime > 0 and Player:BuffDown(S.AvatarBuff) or VarTrinket1CastTime == 0) or S.Avatar:CooldownRemains() > 20)) then
-- --       if Cast(Trinket1, nil, Settings.CommonsDS.DisplayStyle.Trinkets, not Target:IsInRange(VarTrinket1Range)) then return "use_item for " .. Trinket1:Name() .. " trinkets 10"; end
-- --     end
-- --     -- use_item,use_off_gcd=1,slot=trinket2,if=!variable.trinket_2_buffs&!variable.trinket_2_manual&(!variable.trinket_2_buffs&(trinket.1.cooldown.remains|!variable.trinket_1_buffs)|(trinket.2.cast_time>0&!buff.avatar.up|!trinket.2.cast_time>0)|cooldown.avatar.remains_expected>20)
-- --     if Trinket2:IsReady() and not VarTrinket2BL and (not VarTrinket2Buffs and not VarTrinket2Manual and (not VarTrinket2Buffs and (Trinket1:CooldownDown() or not VarTrinket1Buffs) or (VarTrinket2CastTime > 0 and Player:BuffDown(S.AvatarBuff) or VarTrinket2CastTime == 0) or S.Avatar:CooldownRemains() > 20)) then
-- --       if Cast(Trinket2, nil, Settings.CommonsDS.DisplayStyle.Trinkets, not Target:IsInRange(VarTrinket2Range)) then return "use_item for " .. Trinket2:Name() .. " trinkets 12"; end
-- --     end
-- --   end
-- --   -- use_item,use_off_gcd=1,slot=main_hand,if=!equipped.fyralath_the_dreamrender&(!variable.trinket_1_buffs|trinket.1.cooldown.remains)&(!variable.trinket_2_buffs|trinket.2.cooldown.remains)
-- --   if Settings.Commons.Enabled.Items then
-- --     local MainHandOnUse, _, MainHandRange = Player:GetUseableItems(OnUseExcludes, 16)
-- --     if MainHandOnUse and (not I.Fyralath:IsEquipped() and (not VarTrinket1Buffs or Trinket1:CooldownDown()) and (not VarTrinket2Buffs or Trinket2:CooldownDown())) then
-- --       if Cast(MainHandOnUse, nil, Settings.CommonsDS.DisplayStyle.Items, not Target:IsInRange(MainHandRange)) then return "use_item for "..MainHandOnUse:Name().." trinkets 14"; end
-- --     end
-- --     -- Note: Adding a generic use_items for non-trinkets/non-weapons
-- --     local ItemToUse, ItemSlot, ItemRange = Player:GetUseableItems(OnUseExcludes, nil, true)
-- --     if ItemToUse and ItemSlot ~= 16 then
-- --       if Cast(ItemToUse, nil, Settings.CommonsDS.DisplayStyle.Items, not Target:IsInRange(ItemRange)) then return "Generic use_items for " .. ItemToUse:Name(); end
-- --     end
-- --   end
-- end

-- local function Variables()
--   -- variable,name=st_planning,value=active_enemies=1&(raid_event.adds.in>15|!raid_event.adds.exists)
--   VarSTPlanning = (EnemiesMeleeCount == 1)
--   -- variable,name=adds_remain,value=active_enemies>=2&(!raid_event.adds.exists|raid_event.adds.exists&raid_event.adds.remains>5)
--   VarAddsRemain = (EnemiesMeleeCount >= 2)
--   -- variable,name=execute_phase,value=(talent.massacre.enabled&target.health.pct<35)|target.health.pct<20
--   -- Note: Variable is only used in invoke_external_buff line, so not defining for now.
-- end



local function APL()

	EnemiesMelee = Player:GetEnemiesInMeleeRange(5)
print(#EnemiesMelee)
-- 	local _,instanceType = IsInInstance()

--     inRange5 = RangeCount(5)
--     inRange8 = RangeCount(8)
--     inRange10 = RangeCount(10)
--     inRange15 = RangeCount(15)
--     inRange20 = RangeCount(20)
--     inRange25 = RangeCount(25)
--     inRange30 = RangeCount(30)
--     targetRange5 = C_Item.IsItemInRange(8149, "target")
--     targetRange8 = C_Item.IsItemInRange(34368, "target")
--     targetRange10 = C_Item.IsItemInRange(32321, "target")
--     targetRange15 = C_Item.IsItemInRange(33069, "target")
--     targetRange20 = C_Item.IsItemInRange(10645, "target")
--     targetRange25 = C_Item.IsItemInRange(24268, "target")
--     targetRange30 = C_Item.IsItemInRange(835, "target")

	
--         local level, affixIDs, wasEnergized = C_ChallengeMode.GetActiveKeystoneInfo()
     

--         TimeToHPG = ComputeTimeToHPG()

--         if Player:IsChanneling() or Player:IsCasting() then
--         return 0, "Interface\\Addons\\Rubim-RH\\Media\\channel.tga"
--         end


--         HPpercentloss = MyHealthTracker.GetPredictedHealthLoss() * 3

--         validmobsinrange8y = combatmobs40() * .6
--     validmobsinrange30y = combatmobs40() * .6


--     if (inRange8 > validmobsinrange8y or instanceType=='raid') and combatmobs40() > 0 then
--         aoecds8y = true
--     else
--         aoecds8y = false
--     end



--     if (inRange30 > validmobsinrange30y or instanceType=='raid') and combatmobs40() > 0 then
--         aoecds30y = true
--     else
--         aoecds30y = false
--     end
--     if Target:Exists() and getCurrentDPS() and getCurrentDPS()>0 then
--         targetTTD = UnitHealth('target')/getCurrentDPS()
--         else targetTTD = 8888
--         end
        
--             local targetdying = (aoeTTD() < 5 or targetTTD<5)
        



-- 			local castchannelTime = math.random(250, 500) / 1000
-- 			local startTimeMS = select(4, UnitCastingInfo('target')) or 0
-- 			local currentTimeMS = GetTime() * 1000
-- 			local elapsedTimeca = (startTimeMS > 0) and (currentTimeMS - startTimeMS) or 0
-- 			local castTime = elapsedTimeca / 1000
-- 			local startTimeMS = select(4, UnitCastingInfo('target')) or select(4, UnitChannelInfo('target')) or 0
-- 			local currentTimeMS = GetTime() * 1000
-- 			local elapsedTimech = (startTimeMS > 0) and (currentTimeMS - startTimeMS) or 0
-- 			local channelTime = elapsedTimech/1000
			
			
			
-- 			isEnraged = (AuraUtil.FindAuraByName("Enrage", "target") or UnitChannelInfo("target") == "Ragestorm" or AuraUtil.FindAuraByName("Frenzy", "target"))
			
			
			
-- 						--health pot -- will need to update item ID of HPs as expansions progress
-- 						if inRange30 >= 1 and Player:HealthPercentage() <= 30 and Player:AffectingCombat() and (IsUsableItem(191380) == true and
-- 						GetItemCooldown(191380) == 0 and GetItemCount(191380) >= 1 or IsUsableItem(207023) == true and
-- 						GetItemCooldown(207023) == 0 and GetItemCount(207023) >= 1)
-- 						and (not Player:InArena() and not Player:InBattlegrounds()) then
-- 						return I.HPIcon:Cast()
-- 						end



						
-- 						if IsReady(RubimRH.queuedSpell[1]:ID(),nil,nil,1) then
-- 							return RubimRH.QueuedSpell():Cast()
-- 						end
				
				
-- 						if (not IsReady(RubimRH.queuedSpell[1]:ID(),nil,nil,1) or not Player:AffectingCombat() or inRange30 == 0) then
-- 						RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
-- 						end
				
-- --------------------------------------------------------------------------------------------------------------------------------------------
-- ----------------------------------------------------------Functions/Top priorities----------------------------------------------------------
-- --------------------------------------------------------------------------------------------------------------------------------------------
-- if Player:IsCasting() or Player:IsChanneling() then
-- 	return 0, "Interface\\Addons\\Rubim-RH\\Media\\channel.tga"
-- elseif Player:IsDeadOrGhost() or AuraUtil.FindAuraByName("Drink", "player") or AuraUtil.FindAuraByName("Food", "player") or AuraUtil.FindAuraByName("Food & Drink", "player") then
-- 	return 0, "Interface\\Addons\\Rubim-RH\\Media\\griph.tga"
-- end 



-- --------------------------------------------------------------------------------------------------------------------------------------------
-- ----------------------------------------------------------Interrupts------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------------------------------------------------
-- if RubimRH.InterruptsON() and Player:CanAttack(Target) and Player:AffectingCombat()  then
-- 	--Kick
-- 	if IsReady("Pummel") 
-- 	 and kickprio() and targetRange8 and (castTime > castchannelTime+0.5 or channelTime > castchannelTime+0.5)  and select(8, UnitCastingInfo("target")) == false  and not isEnraged then
-- 		return S.Pummel:Cast()
-- 	end

-- end


-- --------------------------------------------------------------------------------------------------------------------------------------------
-- ----------------------------------------------------------Rotation--------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------------------------------------------------
-- if Player:AffectingCombat() and Player:CanAttack(Target) then
-- 	if not IsCurrentSpell(6603) and Target:IsInRange(10) then
-- 		return S.autoattack:Cast()
-- 	end

		
-- 	EnemiesMelee = Player:GetEnemiesInMeleeRange(5)
-- 	if AoEON() then
-- 	  EnemiesMeleeCount = #EnemiesMelee
-- 	else
-- 	  EnemiesMeleeCount = 1
-- 	end
  
-- 	if Everyone.TargetIsValid() or Player:AffectingCombat() then
-- 	  -- Enrage check
-- 	  EnrageUp = Player:BuffUp(S.EnrageBuff)
  
-- 	  -- Range check
-- 	  TargetInMeleeRange = Target:IsInRange(5)
  
-- 	  -- Calculate fight_remains
-- 	  BossFightRemains = HL.BossFightRemains()
-- 	  FightRemains = BossFightRemains
-- 	  if FightRemains == 11111 then
-- 		FightRemains = HL.FightRemains(EnemiesMelee, false)
-- 	  end
-- 	end
  
-- 	if Everyone.TargetIsValid() then
-- 	  -- call Precombat
-- 	  if not Player:AffectingCombat() then
-- 		local ShouldReturn = Precombat(); if ShouldReturn then return ShouldReturn; end
-- 	  end
-- 	  -- Manually added: battle_shout during combat
-- 	  if S.BattleShout:IsCastable() and Settings.Commons.ShoutDuringCombat and Everyone.GroupBuffMissing(S.BattleShoutBuff) then
-- 		if Cast(S.BattleShout, Settings.CommonsOGCD.GCDasOffGCD.BattleShout) then return "battle_shout main 2"; end
-- 	  end
-- 	  -- auto_attack
-- 	  -- charge,if=time<=0.5|movement.distance>5
-- 	  if S.Charge:IsCastable() then
-- 		if Cast(S.Charge, nil, Settings.CommonsDS.DisplayStyle.Charge, not Target:IsSpellInRange(S.Charge)) then return "charge main 4"; end
-- 	  end
-- 	  -- heroic_leap,if=(raid_event.movement.distance>25&raid_event.movement.in>45)
-- 	  if S.HeroicLeap:IsCastable() and not TargetInMeleeRange and (not Target:IsInRange(25)) then
-- 		if Cast(S.HeroicLeap, nil, Settings.CommonsDS.DisplayStyle.HeroicLeap) then return "heroic_leap main 6"; end
-- 	  end
-- 	  -- potion
-- 	  if CDsON() and Settings.Commons.Enabled.Potions then
-- 		local PotionSelected = Everyone.PotionSelected()
-- 		if PotionSelected and PotionSelected:IsReady() then
-- 		  if Cast(PotionSelected, nil, Settings.CommonsDS.DisplayStyle.Potions) then return "potion main 8"; end
-- 		end
-- 	  end
-- 	  -- pummel,if=target.debuff.casting.react
-- 	  local ShouldReturn = Everyone.Interrupt(S.Pummel, Settings.CommonsDS.DisplayStyle.Interrupts, StunInterrupts); if ShouldReturn then return ShouldReturn; end
-- 	  -- Manually added: VR/IV
-- 	  if Player:HealthPercentage() < Settings.Commons.VictoryRushHP then
-- 		if S.VictoryRush:IsReady() then
-- 		  if Cast(S.VictoryRush, nil, nil, not TargetInMeleeRange) then return "victory_rush heal 10"; end
-- 		end
-- 		if S.ImpendingVictory:IsReady() then
-- 		  if Cast(S.ImpendingVictory, nil, nil, not TargetInMeleeRange) then return "impending_victory heal 12"; end
-- 		end
-- 	  end
-- 	  -- call_action_list,name=trinkets
-- 	  if Settings.Commons.Enabled.Trinkets or Settings.Commons.Enabled.Items then
-- 		local ShouldReturn = Trinkets(); if ShouldReturn then return ShouldReturn; end
-- 	  end
-- 	  -- call_action_list,name=variables
-- 	  Variables()
-- 	  if CDsON() then
-- 		-- lights_judgment,if=buff.recklessness.down
-- 		if S.LightsJudgment:IsCastable() and Player:BuffDown(S.RecklessnessBuff) then
-- 		  if Cast(S.LightsJudgment, Settings.CommonsOGCD.OffGCDasOffGCD.Racials, nil, not Target:IsSpellInRange(S.LightsJudgment)) then return "lights_judgment main 16"; end
-- 		end
-- 		-- berserking,if=buff.recklessness.up
-- 		if S.Berserking:IsCastable() and Player:BuffUp(S.RecklessnessBuff) then
-- 		  if Cast(S.Berserking, Settings.CommonsOGCD.OffGCDasOffGCD.Racials) then return "berserking main 18"; end
-- 		end
-- 		-- blood_fury
-- 		if S.BloodFury:IsCastable() then
-- 		  if Cast(S.BloodFury, Settings.CommonsOGCD.OffGCDasOffGCD.Racials) then return "blood_fury main 20"; end
-- 		end
-- 		-- fireblood
-- 		if S.Fireblood:IsCastable() then
-- 		  if Cast(S.Fireblood, Settings.CommonsOGCD.OffGCDasOffGCD.Racials) then return "fireblood main 22"; end
-- 		end
-- 		-- ancestral_call
-- 		if S.AncestralCall:IsCastable() then
-- 		  if Cast(S.AncestralCall, Settings.CommonsOGCD.OffGCDasOffGCD.Racials) then return "ancestral_call main 24"; end
-- 		end
-- 		-- invoke_external_buff,name=power_infusion,if=buff.avatar.remains>15&fight_remains>=135|variable.execute_phase&buff.avatar.up|fight_remains<=25
-- 		-- Note: Not handling external buffs.
-- 	  end
-- 	  -- run_action_list,name=multi_target,if=active_enemies>=2
-- 	  if AoEON() and EnemiesMeleeCount >= 2 then
-- 		local ShouldReturn = MultiTarget(); if ShouldReturn then return ShouldReturn; end
-- 		if HR.CastAnnotated(S.Pool, false, "WAIT") then return "Wait for MultiTarget()"; end
-- 	  end
-- 	  -- run_action_list,name=single_target,if=active_enemies=1
-- 	  -- Note: Using <2 instead of ==1 to avoid blanking/pooling icon when out of range in ST
-- 	  if EnemiesMeleeCount < 2 then
-- 		local ShouldReturn = SingleTarget(); if ShouldReturn then return ShouldReturn; end
-- 		if HR.CastAnnotated(S.Pool, false, "WAIT") then return "Wait for SingleTarget()"; end
-- 	  end
-- 	  -- Pool if nothing else to suggest
-- 	  if HR.CastAnnotated(S.Pool, false, "WAIT") then return "Wait/Pool Resources"; end
-- 	end


-- 		-- Sample Sequence

-- end
	return 0, "Interface\\Addons\\Rubim-RH\\Media\\griph.tga"
end

RubimRH.Rotation.SetAPL(72, APL);

local function PASSIVE()

end

RubimRH.Rotation.SetPASSIVE(72, PASSIVE);

