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
lustAT = Spell(28730), -- arcane turrent

--Fireblood                             = Spell(265221), used for bloodthirst and bloodbath until ggl fixed pixels
  -- Talents
  SlayersDominance                      = Spell(444767),
  -- Buffs
  BrutalFinishBuff                      = Spell(446918),
  ImminentDemiseBuff                    = Spell(445606),
  OpportunistBuff                       = Spell(456120),
  -- Debuffs
  MarkedforExecutionDebuff              = Spell(445584),
-- Racials
AncestralCall                         = Spell(274738),
ArcaneTorrent                         = Spell(50613),
BagofTricks                           = Spell(312411),
Berserking                            = Spell(26297),
BloodFury                             = Spell(20572),
LightsJudgment                        = Spell(255647),
-- Abilities

BattleShout                           = Spell(6673),
BattleStance                          = Spell(386164),
Charge                                = Spell(100),
HeroicThrow                           = Spell(57755),
Pummel                                = Spell(6552),
Slam                                  = Spell(1464),
VictoryRush                           = Spell(34428),
EnragedRegeneration = Spell(184364),
DefensiveStance                       = Spell(386208),
LightningStrikes                      = Spell(434969),

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
VoidRift                              = Spell(440313),
-- Buffs
AvatarBuff                            = Spell(107574),
BattleShoutBuff                       = Spell(6673),
ChampionsMightBuff                    = Spell(386286),
HurricaneBuff                         = Spell(390581),
WarMachineBuff                        = Spell(262232),
BitterImmunity                        = Spell(383762),
-- Debuffs
ChampionsMightDebuff                  = Spell(376080),
MarkofFyralathDebuff                  = Spell(414532),
ThunderousRoarDebuff                  = Spell(397364),
-- Pool
Pool                                  = Spell(999910),

ChampionsMight = Spell(386284),

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
SlaughteringStrikes                   = Spell(388004),

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
Unhinged                              = Spell(386628),

MeatCleaver                       = Spell(280392),

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


-- S.Bloodbath.TextureSpellID = { 265221 }
-- S.Bloodthirst.TextureSpellID = { 265221 }
-- S.Ravager.TextureSpellID = { 228920 }
-- S.Bladestorm.TextureSpellID = { 228920 }

if not Item.Warrior then Item.Warrior = {}; end

Item.Warrior.Fury = {
  drums = Item(193470),

HPIcon = Item(169451),
};

local I = Item.Warrior.Fury;

local function num(val)
  if val then
      return 1
  else
      return 0
  end
end









local function SlayerST()
  -- recklessness,if=(!talent.anger_management&cooldown.avatar.remains<1&talent.titans_torment)|talent.anger_management|!talent.titans_torment
  if RubimRH.CDsON() and targetRange10 and IsReady("Recklessness") and ((not S.AngerManagement:IsAvailable() and S.Avatar:CooldownRemains() < 1 and S.TitansTorment:IsAvailable()) or S.AngerManagement:IsAvailable() or not S.TitansTorment:IsAvailable()) then
  return S.Recklessness:Cast()
    end
  -- avatar,if=(talent.titans_torment&(buff.enrage.up|talent.titanic_rage)&(debuff.champions_might.up|!talent.champions_might))|!talent.titans_torment
  if RubimRH.CDsON()  and targetRange10 and IsReady("Avatar") and ((S.TitansTorment:IsAvailable() and (EnrageUp or S.TitanicRage:IsAvailable()) and (Target:DebuffUp(S.ChampionsMightDebuff) or not S.ChampionsMight:IsAvailable())) or not S.TitansTorment:IsAvailable()) then
    return S.Avatar:Cast()
  end
  -- thunderous_roar,if=buff.enrage.up
  if RubimRH.CDsON()  and targetRange10 and IsReady("Thunderous Roar") and (EnrageUp) then
    return S.ThunderousRoar:Cast()
  end
  -- champions_spear,if=(buff.enrage.up&talent.titans_torment&cooldown.avatar.remains<gcd)|(buff.enrage.up&!talent.titans_torment)
  if RubimRH.CDsON() and targetRange10  and IsReady("Champion's Spear") and ((EnrageUp and S.TitansTorment:IsAvailable() and S.Avatar:CooldownRemains() < Player:GCD()) or (EnrageUp and not S.TitansTorment:IsAvailable())) then
    return S.ChampionsSpear:Cast()
  end
  -- odyns_fury,if=dot.odyns_fury_torment_mh.remains<1&(buff.enrage.up|talent.titanic_rage)&cooldown.avatar.remains
  if RubimRH.CDsON()  and targetRange10 and IsReady("Odyn's Fury") and (Target:DebuffRemains(S.OdynsFuryDebuff) < 1 and (EnrageUp or S.TitanicRage:IsAvailable()) and S.Avatar:CooldownDown()) then
    return S.OdynsFury:Cast()
  end
  -- execute,if=debuff.marked_for_execution.stack=3|(talent.ashen_juggernaut&buff.ashen_juggernaut.remains<=gcd&buff.enrage.up)
  if IsReady("Execute")  and targetRange8 and (Target:DebuffStack(S.MarkedforExecutionDebuff) == 3 or (S.AshenJuggernaut:IsAvailable() and Player:BuffRemains(S.AshenJuggernautBuff) <= Player:GCD() and EnrageUp)) then
    return S.Execute:Cast()
  end
  -- rampage,if=talent.bladestorm&cooldown.bladestorm.remains<=gcd&!debuff.champions_might.up
  if IsReady("Rampage")  and targetRange8 and (S.Bladestorm:IsLearned() and S.Bladestorm:CooldownRemains() <= Player:GCD() and Target:DebuffDown(S.ChampionsMightDebuff)) then
    return S.Rampage:Cast()
  end
  -- bladestorm,if=buff.enrage.up&cooldown.avatar.remains>=9
  if RubimRH.CDsON()  and targetRange10 and IsReady("Bladestorm") and (EnrageUp and S.Avatar:CooldownRemains() >= 9) then
    return S.Bladestorm:Cast()
  end
  -- onslaught,if=talent.tenderize&buff.brutal_finish.up
  if IsReady("Onslaught")  and targetRange10 and (S.Tenderize:IsAvailable() or Player:BuffUp(S.BrutalFinishBuff)) then
    return S.Onslaught:Cast()
  end
  -- rampage,if=talent.anger_management
  if IsReady("Rampage")  and targetRange8 and (S.AngerManagement:IsAvailable()) then
    return S.Rampage:Cast()
  end
  -- crushing_blow
  if IsReady("Crushing Blow")  and targetRange8 then
    return S.CrushingBlow:Cast()
  end
  -- onslaught,if=talent.tenderize
  if IsReady("Onslaught")  and targetRange8 and (S.Tenderize:IsAvailable()) then
    return S.Onslaught:Cast()
  end
  -- bloodbath,if=rage<100|target.health.pct<35&talent.vicious_contempt
  if IsReady("Bloodbath")  and targetRange8 and (Player:Rage() < 100 or Target:HealthPercentage() < 35 and S.ViciousContempt:IsAvailable()) then
    return S.Bloodbath:Cast()
  end
  -- raging_blow,if=rage<100&!buff.opportunist.up
  if IsReady("Raging Blow")  and targetRange8 and (Player:Rage() < 100 and Player:BuffDown(S.OpportunistBuff)) then
    return S.RagingBlow:Cast()
  end
  -- rampage,if=talent.reckless_abandon
  if IsReady("Rampage")  and targetRange8 and (S.RecklessAbandon:IsAvailable()) then
    return S.Rampage:Cast()
  end
  -- execute,if=buff.enrage.up&debuff.marked_for_execution.up
  if IsReady("Execute")  and targetRange8 and (EnrageUp and Target:DebuffUp(S.MarkedforExecutionDebuff)) then
    return S.Execute:Cast()
  end
  -- bloodthirst,if=!talent.reckless_abandon&buff.enrage.up
  if IsReady("Bloodthirst")  and targetRange8 and (not S.RecklessAbandon:IsAvailable() and EnrageUp) then
    return S.Bloodthirst:Cast()
  end
  -- raging_blow
  if IsReady("Raging Blow") and targetRange8  then
    return S.RagingBlow:Cast()
  end
  -- onslaught
  if IsReady("Onslaught") and targetRange8  then
    return S.Onslaught:Cast()
  end
  -- execute
  if IsReady("Execute")  and targetRange8 then
    return S.Execute:Cast()
  end
  -- bloodthirst
  if IsReady("Bloodthirst")  and targetRange8 then
    return S.Bloodthirst:Cast()
  end
  -- whirlwind,if=talent.meat_cleaver
  if IsReady("Whirlwind")  and targetRange8 and (S.MeatCleaver:IsAvailable()) then
    return S.Whirlwind:Cast()
  end
  -- slam
  if IsReady("Slam")  and targetRange8 then
    return S.Slam:Cast()
  end
  -- storm_bolt,if=buff.bladestorm.up
  if IsReady("Storm Bolt")  and targetRange20 and (Player:BuffUp(S.Bladestorm)) then
    return S.StormBolt:Cast()
  end
end

local function SlayerMT()
  
  -- recklessness,if=(!talent.anger_management&cooldown.avatar.remains<1&talent.titans_torment)|talent.anger_management|!talent.titans_torment
  if RubimRH.CDsON()  and targetRange10 and IsReady("Recklessness") and ((not S.AngerManagement:IsAvailable() and S.Avatar:CooldownRemains() < 1 and S.TitansTorment:IsAvailable()) or S.AngerManagement:IsAvailable() or not S.TitansTorment:IsAvailable()) then
    return S.Recklessness:Cast()
  end
  -- avatar,if=(talent.titans_torment&(buff.enrage.up|talent.titanic_rage)&(debuff.champions_might.up|!talent.champions_might))|!talent.titans_torment
  if RubimRH.CDsON()  and targetRange10 and IsReady("Avatar") and ((S.TitansTorment:IsAvailable() and (EnrageUp or S.TitanicRage:IsAvailable()) and (Target:DebuffUp(S.ChampionsMightDebuff) or not S.ChampionsMight:IsAvailable())) or not S.TitansTorment:IsAvailable()) then
    return S.Avatar:Cast()
  end


  -- thunderous_roar,if=buff.enrage.up
  if RubimRH.CDsON()  and targetRange8 and IsReady("Thunderous Roar") and (EnrageUp) then
    return S.ThunderousRoar:Cast()
  end


  -- champions_spear,if=(buff.enrage.up&talent.titans_torment&cooldown.avatar.remains<gcd)|(buff.enrage.up&!talent.titans_torment)
  if RubimRH.CDsON()  and targetRange8 and IsReady("Champion's Spear") and ((EnrageUp and S.TitansTorment:IsAvailable() and S.Avatar:CooldownRemains() < Player:GCD()) or (EnrageUp and not S.TitansTorment:IsAvailable())) then
    return S.ChampionsSpear:Cast()
  end

  -- odyns_fury,if=dot.odyns_fury_torment_mh.remains<1&(buff.enrage.up|talent.titanic_rage)&cooldown.avatar.remains
  if RubimRH.CDsON()  and targetRange8 and IsReady("Odyn's Fury") and (Target:DebuffRemains(S.OdynsFuryDebuff) < 1 and (EnrageUp or S.TitanicRage:IsAvailable()) and S.Avatar:CooldownDown()) then
    return S.OdynsFury:Cast()
  end

  -- whirlwind,if=buff.meat_cleaver.stack=0&talent.meat_cleaver
  if IsReady("Whirlwind")  and targetRange8 and (Player:BuffDown(S.MeatCleaverBuff) and S.MeatCleaver:IsAvailable()) then
    return S.Whirlwind:Cast()
  end


  -- execute,if=talent.ashen_juggernaut&buff.ashen_juggernaut.remains<=gcd&buff.enrage.up
  if IsReady("Execute")  and targetRange8 and (S.AshenJuggernaut:IsAvailable() and Player:BuffRemains(S.AshenJuggernautBuff) <= Player:GCD() and EnrageUp) then
    return S.Execute:Cast()
  end

  -- rampage,if=talent.bladestorm&cooldown.bladestorm.remains<=gcd&!debuff.champions_might.up
  if IsReady("Rampage")  and targetRange8 and (S.Bladestorm:IsLearned() and S.Bladestorm:CooldownRemains() <= Player:GCD() and Target:DebuffDown(S.ChampionsMightDebuff)) then
    return S.Rampage:Cast()
  end

  -- bladestorm,if=buff.enrage.up&cooldown.avatar.remains>=9
  if RubimRH.CDsON()  and targetRange8 and IsReady("Bladestorm") and (EnrageUp and S.Avatar:CooldownRemains() >= 9) then
    return S.Bladestorm:Cast()
  end
  -- onslaught,if=talent.tenderize&buff.brutal_finish.up
  if IsReady("Onslaught")  and targetRange8 and (S.Tenderize:IsAvailable() or Player:BuffUp(S.BrutalFinishBuff)) then
    return S.Onslaught:Cast()
  end
  -- rampage,if=talent.anger_management
  if IsReady("Rampage")  and targetRange8 and (S.AngerManagement:IsAvailable()) then
    return S.Rampage:Cast()
  end
  -- crushing_blow
  if IsReady("Crushing Blow")  and targetRange8 then
    return S.CrushingBlow:Cast()
  end
  -- onslaught,if=talent.tenderize
  if IsReady("Onslaught")  and targetRange8 and (S.Tenderize:IsAvailable()) then
    return S.Onslaught:Cast()
  end
  -- bloodbath,if=buff.enrage.up
  if IsReady("Bloodbath")  and targetRange8 and (EnrageUp) then
    return S.Bloodbath:Cast()
  end
  -- rampage,if=talent.reckless_abandon
  if IsReady("Rampage")  and targetRange8 and (S.RecklessAbandon:IsAvailable()) then
    return S.Rampage:Cast()
  end
  -- execute,if=buff.enrage.up&debuff.marked_for_execution.up
  if IsReady("Execute")  and targetRange8 and (EnrageUp and Target:DebuffUp(S.MarkedforExecutionDebuff)) then
    return S.Execute:Cast()
  end
  -- bloodbath
  if IsReady("Bloodbath")  and targetRange8 then
    return S.Bloodbath:Cast()
  end
  -- raging_blow,if=talent.slaughtering_strikes
  if IsReady("Raging Blow")  and targetRange8 and (S.SlaughteringStrikes:IsAvailable()) then
    return S.RagingBlow:Cast()
  end
  -- onslaught
  if IsReady("Onslaught")  and targetRange8 then
    return S.Onslaught:Cast()
  end
  -- execute
  if IsReady("Execute")  and targetRange8 then
    return S.Execute:Cast()
  end
  -- bloodthirst
  if IsReady("Bloodthirst")  and targetRange8 then
    return S.Bloodthirst:Cast()
  end
  -- raging_blow
  if IsReady("Raging Blow")  and targetRange8 then
    return S.RagingBlow:Cast()
  end
  -- whirlwind
  if IsReady("Whirlwind") then
    return S.Whirlwind:Cast()
  end
  -- storm_bolt,if=buff.bladestorm.up
  if IsReady("Storm Bolt")  and targetRange20 and (Player:BuffUp(S.Bladestorm)) then
    return S.StormBolt:Cast()
  end
end

local function ThaneST()
  -- recklessness,if=(!talent.anger_management&cooldown.avatar.remains<1&talent.titans_torment)|talent.anger_management|!talent.titans_torment
  if RubimRH.CDsON()  and targetRange10 and IsReady("Recklessness") and ((not S.AngerManagement:IsAvailable() and S.Avatar:CooldownRemains() < 1 and S.TitansTorment:IsAvailable()) or S.AngerManagement:IsAvailable() or not S.TitansTorment:IsAvailable()) then
    return S.Recklessness:Cast()
  end
  -- thunder_blast,if=buff.enrage.up
  if IsReady("Thunder Blast")  and targetRange10 and (EnrageUp) then
    return S.ThunderBlastAbility:Cast()
  end
  -- avatar,if=(talent.titans_torment&(buff.enrage.up|talent.titanic_rage)&(debuff.champions_might.up|!talent.champions_might))|!talent.titans_torment
  if RubimRH.CDsON()  and targetRange10 and IsReady("Avatar") and ((S.TitansTorment:IsAvailable() and (EnrageUp or S.TitanicRage:IsAvailable()) and (Target:DebuffUp(S.ChampionsMightDebuff) or not S.ChampionsMight:IsAvailable())) or not S.TitansTorment:IsAvailable()) then
    return S.Avatar:Cast()
  end
  -- ravager
  if RubimRH.CDsON() and IsReady("Ravager")  and targetRange8 then
    return S.Ravager:Cast()
  end
  -- thunderous_roar,if=buff.enrage.up
  if RubimRH.CDsON()  and targetRange8 and IsReady("Thunderous Roar") and (EnrageUp) then
    return S.ThunderousRoar:Cast()
  end
  -- champions_spear,if=buff.enrage.up&(cooldown.avatar.remains<gcd|!talent.titans_torment)
  if RubimRH.CDsON() and targetRange8  and IsReady("Champion's Spear") and (EnrageUp and (S.Avatar:CooldownRemains() < Player:GCD() or not S.TitansTorment:IsAvailable())) then
    return S.ChampionsSpear:Cast()
  end
  -- odyns_fury,if=dot.odyns_fury_torment_mh.remains<1&(buff.enrage.up|talent.titanic_rage)&cooldown.avatar.remains
  if RubimRH.CDsON()  and targetRange8 and IsReady("Odyn's Fury") and (Target:DebuffRemains(S.OdynsFuryDebuff) < 1 and (EnrageUp or S.TitanicRage:IsAvailable()) and S.Avatar:CooldownDown()) then
    return S.OdynsFury:Cast()
  end
  -- execute,if=talent.ashen_juggernaut&buff.ashen_juggernaut.remains<=gcd&buff.enrage.up
  if IsReady("Execute")  and targetRange8 and (S.AshenJuggernaut:IsAvailable() and Player:BuffRemains(S.AshenJuggernautBuff) <= Player:GCD() and EnrageUp) then
    return S.Execute:Cast()
  end
  -- rampage,if=talent.bladestorm&cooldown.bladestorm.remains<=gcd&!debuff.champions_might.up
  if IsReady("Rampage") and targetRange8  and (S.Bladestorm:IsLearned() and S.Bladestorm:CooldownRemains() <= Player:GCD() and Target:DebuffDown(S.ChampionsMightDebuff)) then
    return S.Rampage:Cast()
  end
  -- bladestorm,if=buff.enrage.up&talent.unhinged
  if RubimRH.CDsON() and targetRange8  and IsReady("Bladestorm") and (EnrageUp and S.Unhinged:IsAvailable()) then
    return S.Bladestorm:Cast()
  end
  -- rampage,if=talent.anger_management
  if IsReady("Rampage")  and targetRange8 and (S.AngerManagement:IsAvailable()) then
    return S.Rampage:Cast()
  end
  -- crushing_blow
  if IsReady("Crushing Blow")  and targetRange8 then
    return S.CrushingBlow:Cast()
  end
  -- onslaught,if=talent.tenderize
  if IsReady("Onslaught") and targetRange8  and (S.Tenderize:IsAvailable()) then
    return S.Onslaught:Cast()
  end
  -- bloodbath
  if IsReady("Bloodbath") and targetRange8  then
    return S.Bloodbath:Cast()
  end
  -- rampage,if=talent.reckless_abandon
  if IsReady("Rampage") and targetRange8  and (S.RecklessAbandon:IsAvailable()) then
    return S.Rampage:Cast()
  end
  -- raging_blow
  if IsReady("Raging Blow")  and targetRange8 then
    return S.RagingBlow:Cast()
  end
  -- execute
  if IsReady("Execute") and targetRange8  then
    return S.Execute:Cast()
  end
  -- bloodthirst,if=buff.enrage.up&(!buff.burst_of_power.up|!talent.reckless_abandon)
  if IsReady("Bloodthirst")  and targetRange8 and (EnrageUp and (Player:BuffDown(S.BurstofPowerBuff) or not S.RecklessAbandon:IsAvailable())) then
    return S.Bloodthirst:Cast()
  end
  -- onslaught
  if IsReady("Onslaught") and targetRange8  then
    return S.Onslaught:Cast()
  end
  -- bloodthirst
  if IsReady("Bloodthirst") and targetRange8  then
    return S.Bloodthirst:Cast()
  end
  -- thunder_clap
  if IsReady("Thunder Clap") and targetRange8  then
    return S.ThunderClap:Cast()
  end
  -- whirlwind,if=talent.meat_cleaver
  if IsReady("Whirlwind") and (S.MeatCleaver:IsAvailable()) then
    return S.Whirlwind:Cast()
  end
  -- slam
  if IsReady("Slam")  and targetRange8 then
    return S.Slam:Cast()
  end
end

local function ThaneMT()
  -- recklessness,if=(!talent.anger_management&cooldown.avatar.remains<1&talent.titans_torment)|talent.anger_management|!talent.titans_torment
  if RubimRH.CDsON()  and targetRange10 and IsReady("Recklessness") and ((not S.AngerManagement:IsAvailable() and S.Avatar:CooldownRemains() < 1 and S.TitansTorment:IsAvailable()) or S.AngerManagement:IsAvailable() or not S.TitansTorment:IsAvailable()) then
    return S.Recklessness:Cast()
  end
  -- thunder_blast,if=buff.enrage.up
  if IsReady("Thunder Blast")  and targetRange8 and (EnrageUp) then
    return S.ThunderBlastAbility:Cast()
  end
  -- avatar,if=(talent.titans_torment&(buff.enrage.up|talent.titanic_rage)&(debuff.champions_might.up|!talent.champions_might))|!talent.titans_torment
  if RubimRH.CDsON()  and targetRange10 and IsReady("Avatar") and ((S.TitansTorment:IsAvailable() and (EnrageUp or S.TitanicRage:IsAvailable()) and (Target:DebuffUp(S.ChampionsMightDebuff) or not S.ChampionsMight:IsAvailable())) or not S.TitansTorment:IsAvailable()) then
    return S.Avatar:Cast()
  end
  -- thunder_clap,if=buff.meat_cleaver.stack=0&talent.meat_cleaver
  if IsReady("Thunder Clap")  and targetRange8 and (Player:BuffDown(S.MeatCleaverBuff) and S.MeatCleaver:IsAvailable()) then
    return S.ThunderClap:Cast()
  end
  -- thunderous_roar,if=buff.enrage.up
  if RubimRH.CDsON()  and targetRange8 and IsReady("Thunderous Roar") and (EnrageUp) then
    return S.ThunderousRoar:Cast()
  end
  -- ravager
  if RubimRH.CDsON()  and targetRange8 and IsReady("Ravager") then
    return S.Ravager:Cast()
  end
  -- champions_spear,if=buff.enrage.up
  if RubimRH.CDsON()  and targetRange8 and IsReady("Champion's Spear") and (EnrageUp) then
    return S.ChampionsSpear:Cast()
  end
  -- odyns_fury,if=dot.odyns_fury_torment_mh.remains<1&(buff.enrage.up|talent.titanic_rage)&cooldown.avatar.remains
  if RubimRH.CDsON()  and targetRange8 and IsReady("Odyn's Fury") and (Target:DebuffRemains(S.OdynsFuryDebuff) < 1 and (EnrageUp or S.TitanicRage:IsAvailable()) and S.Avatar:CooldownDown()) then
    return S.OdynsFury:Cast()
  end
  -- execute,if=talent.ashen_juggernaut&buff.ashen_juggernaut.remains<=gcd&buff.enrage.up
  if IsReady("Execute")  and targetRange8 and (S.AshenJuggernaut:IsAvailable() and Player:BuffRemains(S.AshenJuggernautBuff) <= Player:GCD() and EnrageUp) then
    return S.Execute:Cast()
  end
  -- rampage,if=talent.bladestorm&cooldown.bladestorm.remains<=gcd&!debuff.champions_might.up
  if IsReady("Rampage")  and targetRange8 and (S.Bladestorm:IsLearned() and S.Bladestorm:CooldownRemains() <= Player:GCD() and Target:DebuffDown(S.ChampionsMightDebuff)) then
    return S.Rampage:Cast()
  end
  -- bladestorm,if=buff.enrage.up
  if RubimRH.CDsON()  and targetRange8 and IsReady("Bladestorm") and (EnrageUp) then
    return S.Bladestorm:Cast()
  end
  -- rampage,if=talent.anger_management
  if IsReady("Rampage")  and targetRange8 and (S.AngerManagement:IsAvailable()) then
    return S.Rampage:Cast()
  end
  -- crushing_blow,if=buff.enrage.up
  if IsReady("Crushing Blow")  and targetRange8 and (EnrageUp) then
    return S.CrushingBlow:Cast()
  end
  -- onslaught,if=talent.tenderize
  if IsReady("Onslaught")  and targetRange8 and (S.Tenderize:IsAvailable()) then
    return S.Onslaught:Cast()
  end
  -- bloodbath
  if IsReady("Bloodbath")  and targetRange8 then
    return S.Bloodbath:Cast()
  end
  -- rampage,if=talent.reckless_abandon
  if IsReady("Rampage")  and targetRange8 and (S.RecklessAbandon:IsAvailable()) then
    return S.Rampage:Cast()
  end
  -- bloodthirst
  if IsReady("Bloodthirst") and targetRange8  then
    return S.Bloodthirst:Cast()
  end
  -- thunder_clap
  if IsReady("Thunder Clap") and targetRange8  then
    return S.ThunderClap:Cast()
  end
  -- onslaught
  if IsReady("Onslaught") and targetRange8  then
    return S.Onslaught:Cast()
  end
  -- execute
  if IsReady("Execute") and targetRange8  then
    return S.Execute:Cast()
  end
  -- raging_blow
  if IsReady("Raging Blow") and targetRange8  then
    return S.RagingBlow:Cast()
  end
  -- whirlwind
  if IsReady("Whirlwind") then
    return S.Whirlwind:Cast()
  end
end























local function APL()

  TrackHealthLossPerSecond()
local _,instanceType = IsInInstance()

inRange5 = RangeCount(5)
inRange8 = RangeCount(8)
inRange10 = RangeCount(10)
inRange15 = RangeCount(15)
inRange12 = RangeCount(12)
inRange20 = RangeCount(20)
inRange25 = RangeCount(25)
inRange30 = RangeCount(30)
targetRange5 = C_Item.IsItemInRange(8149, "target")
targetRange8 = C_Item.IsItemInRange(34368, "target")
targetRange10 = C_Item.IsItemInRange(32321, "target")
targetRange15 = C_Item.IsItemInRange(33069, "target")
targetRange20 = C_Item.IsItemInRange(10645, "target")
targetRange25 = C_Item.IsItemInRange(24268, "target")
targetRange30 = C_Item.IsItemInRange(835, "target")

if AuraUtil.FindAuraByName("Battle Shout","player") then
battleshoutremains = select(6,AuraUtil.FindAuraByName("Battle Shout","player")) - GetTime()
else
battleshoutremains = 0
end
local bloodbath = AuraUtil.FindAuraByName("Bloodbath","player") 
local level, affixIDs, wasEnergized = C_ChallengeMode.GetActiveKeystoneInfo()
 EnrageUp = AuraUtil.FindAuraByName("Enrage","player")

HPpercentloss = GetHealthLossPerSecond()



if Target:Exists() and getCurrentDPS() and getCurrentDPS()>0 then
targetTTD = UnitHealth('target')/getCurrentDPS()
else targetTTD = 8888
end

local targetdying = (aoeTTD() < 5 or targetTTD<5)

local castchannelTime = math.random(250, 500) / 1000
local startTimeMS = select(4, UnitCastingInfo('target')) or 0
local currentTimeMS = GetTime() * 1000
local elapsedTimeca = (startTimeMS > 0) and (currentTimeMS - startTimeMS) or 0
local castTime = elapsedTimeca / 1000
local startTimeMS = select(4, UnitCastingInfo('target')) or select(4, UnitChannelInfo('target')) or 0
local currentTimeMS = GetTime() * 1000
local elapsedTimech = (startTimeMS > 0) and (currentTimeMS - startTimeMS) or 0
local channelTime = elapsedTimech/1000

isEnraged = (AuraUtil.FindAuraByName("Enrage", "target") or UnitChannelInfo("target") == "Ragestorm" or AuraUtil.FindAuraByName("Frenzy", "target"))

--health pot -- will need to update item ID of HPs as expansions progress
if inRange30 >= 1 and Player:AffectingCombat() then
  if RangeCount(30) >= 1 and Player:HealthPercentage() <= 20 and (IsUsableItem(211880) == true and GetItemCooldown(211880) == 0 and GetItemCount(211880) >= 1 or IsUsableItem(211878) == true and GetItemCooldown(211878) == 0 and GetItemCount(211878) >= 1 or IsUsableItem(211879) == true and GetItemCooldown(211879) == 0 and GetItemCount(211879) >= 1) and (not Player:InArena() and not Player:InBattlegrounds()) then
    return I.HPIcon:Cast()
  end

if IsReady("Rallying Cry") and Player:HealthPercentage()<50 then
  return S.RallyingCry:Cast()
end

if IsReady("Enraged Regeneration") and Player:HealthPercentage()<50 then
  return S.EnragedRegeneration:Cast()
end

if IsReady("Spell Reflection") and Player:HealthPercentage()<20 then
  return S.SpellReflection:Cast()
end

end


if S.lustAT:ID() == RubimRH.queuedSpell[1]:ID()
and Player:DebuffDown(S.lust1) and Player:DebuffDown(S.lust2) and Player:CanAttack(Target) and GetItemCount(219905) >= 1 and 
Player:DebuffDown(S.lust3) and Player:DebuffDown(S.lust4) and Player:DebuffDown(S.lust5) and (I.drums:IsReady()) then
return S.lustAT:Cast() -- BIND LUST KEYBIND IN BINDPAD TO ARCANE TORRENT
end

if S.lustAT:ID() == RubimRH.queuedSpell[1]:ID() and
(
Player:DebuffUp(S.lust1) or Player:DebuffUp(S.lust2) or Player:DebuffUp(S.lust3) or Player:DebuffUp(S.lust4) or
Player:DebuffUp(S.lust5)) then
RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
end

if S.HeroicThrow:ID() == RubimRH.queuedSpell[1]:ID() and (targetRange8 or not targetRange30) then
  RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
  end

if (not IsReady(RubimRH.queuedSpell[1]:ID(),nil,nil,1) or not Player:AffectingCombat() or inRange30 == 0 or not Target:Exists()) then
  RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
  end

if IsReady(RubimRH.queuedSpell[1]:ID(),nil,nil,1) then
return RubimRH.QueuedSpell():Cast()
end




if Player:IsCasting() or Player:IsChanneling() then
return 0, "Interface\\Addons\\Rubim-RH\\Media\\channel.tga"
elseif Player:IsDeadOrGhost() or AuraUtil.FindAuraByName("Drink", "player") or AuraUtil.FindAuraByName("Food", "player") or AuraUtil.FindAuraByName("Food & Drink", "player") then
return 0, "Interface\\Addons\\Rubim-RH\\Media\\griph.tga"
end 



-- --------------------------------------------------------------------------------------------------------------------------------------------
-- ----------------------------------------------------------Interrupts------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------------------------------------------------
if RubimRH.InterruptsON() then
  if IsReady("Defensive Stance") and Player:HealthPercentage() < 35 and not Player:BuffUp(S.DefensiveStance) then
    return S.DefensiveStance:Cast()
  end

  if IsReady("Berserker Stance") and not Player:BuffUp(S.BerserkerStance) and (Player:HealthPercentage() >= 85 or (Player:HealthPercentage() >= 35 and not Player:BuffUp(S.DefensiveStance))) then
    return S.BerserkerStance:Cast()
  end
end

if RubimRH.InterruptsON() and Player:AffectingCombat() and inRange30 >= 1 then
  if IsReady("Bitter Immunity") and Player:DebuffUp(S.VoidRift) then
    return S.BitterImmunity:Cast()
  end

--Kick
if IsReady("Pummel") 
and kickprio() and targetRange8 and (castTime > castchannelTime+0.5 or channelTime > castchannelTime+0.5)  and select(8, UnitCastingInfo("target")) == false  and not isEnraged then
return S.Pummel:Cast()
end

if IsReady("Storm Bolt") 
and stunprio() and targetRange20 and (castTime > castchannelTime+0.5 or channelTime > castchannelTime+0.5)  and select(8, UnitCastingInfo("target")) == false  and not isEnraged then
return S.StormBolt:Cast()
end

end


-- --------------------------------------------------------------------------------------------------------------------------------------------
-- ----------------------------------------------------------Rotation--------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------------------------------------------------
if (Target:AffectingCombat() or C_Spell.IsCurrentSpell(6603)) and Player:CanAttack(Target) and not Target:IsDeadOrGhost() and inRange10 >=1 then 
if not C_Spell.IsCurrentSpell(6603) and targetRange10 then
return S.autoattack:Cast()
end


if Player:HealthPercentage() <=60 then
  if IsReady("Victory Rush") and not S.ImpendingVictory:IsAvailable() then
  return S.VictoryRush:Cast()
  end
  if IsReady("Impending Victory") then
  return S.ImpendingVictory:Cast()
  end
end

if RubimRH.CDsON() then
local ShouldReturn = UseItems();
if ShouldReturn then return ShouldReturn; end

end




 -- Note: For below lines, using <2 instead of =1 to avoid losing suggestions when moving slightly out of range.
 -- run_action_list,name=slayer_st,if=talent.slayers_dominance&active_enemies=1
 if (S.SlayersDominance:IsAvailable() or Player:Level() < 71) and (inRange10 < 2 or not RubimRH.AoEON()) then
   local ShouldReturn = SlayerST(); if ShouldReturn then return ShouldReturn; end
 end

 -- run_action_list,name=slayer_mt,if=talent.slayers_dominance&active_enemies>1 
 if (S.SlayersDominance:IsAvailable() or Player:Level() < 71) and RubimRH.AoEON() and inRange10 > 1 then
   local ShouldReturn = SlayerMT(); if ShouldReturn then return ShouldReturn; end
 end

 -- run_action_list,name=thane_st,if=talent.lightning_strikes&active_enemies=1
 if S.LightningStrikes:IsAvailable() and (inRange10 < 2 or not RubimRH.AoEON()) then
   local ShouldReturn = ThaneST(); if ShouldReturn then return ShouldReturn; end
 end


 -- run_action_list,name=thane_mt,if=talent.lightning_strikes&active_enemies>1
 if S.LightningStrikes:IsAvailable() and RubimRH.AoEON() and inRange10 > 1 then
   local ShouldReturn = ThaneMT(); if ShouldReturn then return ShouldReturn; end
 end


end
--OOC

if not Player:AffectingCombat() then

if IsReady("Battle Shout") and battleshoutremains<300 then
return S.BattleShout:Cast()
end
if IsReady("Berserker Stance") and not AuraUtil.FindAuraByName("Berserker Stance","player")  then
  return S.BerserkerStance:Cast()
  end

 -- ooc end for 'if not Player:AffectingCombat() then'
return 0, "Interface\\Addons\\Rubim-RH\\Media\\griph.tga"

end



return 0, 135328
end -- end APL


RubimRH.Rotation.SetAPL(72, APL);

local function PASSIVE()

end

RubimRH.Rotation.SetPASSIVE(72, PASSIVE);