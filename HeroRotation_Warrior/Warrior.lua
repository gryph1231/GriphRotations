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
local MultiSpell = HL.MultiSpell
local Item       = HL.Item
local MergeTableByKey = HL.Utils.MergeTableByKey
-- HeroRotation
local HR         = HeroRotation

--- ============================ CONTENT ============================

-- Spell
if not Spell.Warrior then Spell.Warrior = {} end
Spell.Warrior.Commons = {
  -- Racials
  MPI = Spell(999955),
  combat = Spell(999956),
  channeling = Spell(999957),
  mounted = Spell(999958),
  wristsx = Spell(255647), -- lights judgmenet

  lust1 = Spell(57724),
lust2 = Spell(57723),
lust3 = Spell(80354),
lust4 = Spell(95809),
lust5 = Spell(264689),
  lustAT = Spell(265221), -- fireblood
  Ravagerz                              = Spell(312411),
execute = Spell(135358),
  AncestralCall                         = Spell(274738),
  ArcaneTorrent                         = Spell(50613),
  -- BagofTricks                           = Spell(312411),
  Berserking                            = Spell(26297),
  BloodFury                             = Spell(20572),
  -- Abilities
  BattleShout                           = Spell(6673),
  Charge                                = Spell(100),
  HeroicThrow                           = Spell(57755),
  Pummel                                = Spell(6552),
  Slam                                  = Spell(1464),
  odynsfury                             = Spell(28880),--Gift of Naru
  VictoryRush                           = Spell(34428),
  -- Talents
  Avatar                                = Spell(107574),
  BerserkerRage                         = Spell(18499),
  BloodandThunder                       = Spell(384277),
  DoubleTime                            = Spell(103827),
  FrothingBerserker                     = Spell(215571),
  IntimidatingShout                     = Spell(5246),
  HeroicLeap                            = Spell(6544),
  ImpendingVictory                      = Spell(202168),
  OverwhelmingRage                      = Spell(382767),
  RallyingCry                           = Spell(97462),
  Shockwave                             = Spell(46968),
  SonicBoom                             = Spell(390725),
  SpearofBastion                        = Spell(376079),
  StormBolt                             = Spell(107570),
  ThunderousRoar                        = Spell(384318),
  TitanicThrow                          = Spell(384090),
  TitansTorment                         = Spell(390135),
  WreckingThrow                         = Spell(384110),
  -- Buffs
  AvatarBuff                            = Spell(107574),
  BattleShoutBuff                       = Spell(6673),
  -- Debuffs
  SpearofBastionDebuff                  = Spell(376080),
  -- Covenant Abilities (Shadowlands)
  AncientAftershock                     = Spell(325886),
  Condemn                               = MultiSpell(330325, 330334, 317485, 317349),
  CondemnDebuff                         = Spell(317491),
  ConquerorsBanner                      = Spell(324143),
  ConquerorsFrenzyBuff                  = Spell(343672),
  ElysianMightBuff                      = Spell(311193),
  Fleshcraft                            = Spell(324631),
  SpearofBastionCov                     = Spell(307865),
  SpearofBastionCovBuff                 = Spell(307871),
  -- Conduits (Shadowlands)
  AshenJuggernaut                       = Spell(335232),
  AshenJuggernautBuff                   = Spell(335234),
  MercilessBonegrinder                  = Spell(335260),
  MercilessBonegrinderBuff              = Spell(346574),
  -- Pool
  Pool                                  = Spell(999910),
}

Spell.Warrior.Fury = MergeTableByKey(Spell.Warrior.Commons, {
  -- Abilities
  Bloodbath                             = Spell(335096),
  CrushingBlow                          = Spell(335097),
  Execute                               = Spell(280735),
  Whirlwind                             = Spell(190411),
  -- Talents
  Annihilator                           = Spell(383916),
  Bloodthirst                           = Spell(23881),
  Cruelty                               = Spell(392931),
  Frenzy                                = Spell(335077),
  Massacre                              = Spell(206315),
  MeatCleaver                           = Spell(280392),
  OdynsFury                             = Spell(385059),
  Onslaught                             = Spell(315720),
  RagingBlow                            = Spell(85288),
  Rampage                               = Spell(184367),
  Ravager                               = Spell(228920),
  RecklessAbandon                       = Spell(202751),
  Recklessness                          = Spell(1719),
  StormofSwords                         = Spell(388903),
  SuddenDeath                           = Spell(280721),
  Tenderize                             = Spell(388933),
  WrathandFury                          = Spell(392936),
  -- Buffs
  EnrageBuff                            = Spell(184362),
  FrenzyBuff                            = Spell(335082),
  MeatCleaverBuff                       = Spell(85739),
  RecklessnessBuff                      = Spell(1719),
  SuddenDeathBuff                       = Spell(280776),
  -- Debuffs
  SiegebreakerDebuff                    = Spell(280773),
  -- Conduits (Shadowlands)
  ViciousContempt                       = Spell(337302),
  -- Legendary Effects (Shadowlands)
  WilloftheBerserkerBuff                = Spell(335594),
})

Spell.Warrior.Arms = MergeTableByKey(Spell.Warrior.Commons, {
  -- Abilities
  Execute                               = Spell(280735),
  Whirlwind                             = Spell(1680),
  -- Talents
  AngerManagement                       = Spell(152278),
  Bladestorm                            = Spell(227847),
  Cleave                                = Spell(845),
  CollateralDamage                      = Spell(334779),
  ColossusSmash                         = Spell(167105),
  Dreadnaught                           = Spell(262150),
  ExecutionersPrecision                 = Spell(386634),
  FervorofBattle                        = Spell(202316),
  Hurricane                             = Spell(390563),
  InfortheKill                          = Spell(248621),
  MartialProwess                        = Spell(316440),
  Massacre                              = Spell(281001),
  MortalStrike                          = Spell(12294),
  Overpower                             = Spell(7384),
  Rend                                  = Spell(772),
  Skullsplitter                         = Spell(260643),
  SuddenDeath                           = Spell(29725),
  SweepingStrikes                       = Spell(260708),
  SweepingStrikesBuff                   = Spell(260708),
  TestofMight                           = Spell(385008),
  TideofBlood                           = Spell(386357),
  Unhinged                              = Spell(386628),
  Warbreaker                            = Spell(262161),
  -- Buffs
  MartialProwessBuff                    = Spell(7384),
  SuddenDeathBuff                       = Spell(52437),
  TestofMightBuff                       = Spell(385013),
  WarMachineBuff                        = Spell(262231),
  JuggernautBuff                        = Spell(383292),
  -- Debuffs
  ColossusSmashDebuff                   = Spell(208086),
  DeepWoundsDebuff                      = Spell(262115),
  ExecutionersPrecisionDebuff           = Spell(386633),
  RendDebuff                            = Spell(388539),
  -- Conduits (Shadowlands)
  BattlelordBuff                        = Spell(346369),
  ExploiterDebuff                       = Spell(335452),
})

Spell.Warrior.Protection = MergeTableByKey(Spell.Warrior.Commons, {
  -- Abilities
  Devastate                             = Spell(20243),
  Execute                               = Spell(280735),
  ShieldBlock                           = Spell(2565),
  ShieldSlam                            = Spell(23922),
  -- Talents
  BoomingVoice                          = Spell(202743),
  DemoralizingShout                     = Spell(1160),
  IgnorePain                            = Spell(190456),
  Intervene                             = Spell(3411),
  LastStand                             = Spell(12975),
  Ravager                               = Spell(228920),
  
  Rend                                  = Spell(394062),
  Revenge                               = Spell(6572),
  ShieldCharge                          = Spell(385952),
  ShieldWall                            = Spell(871),
  ThunderClap                           = Spell(6343),
  UnstoppableForce                      = Spell(275336),
  -- Buffs
  LastStandBuff                         = Spell(12975),
  RallyingCryBuff                       = Spell(97463),
  RevengeBuff                           = Spell(5302),
  SeeingRedBuff                         = Spell(386486),
  ShieldBlockBuff                       = Spell(132404),
  ShieldWallBuff                        = Spell(871),
  ViolentOutburstBuff                   = Spell(386478),
  -- Debuffs
})

-- Items
if not Item.Warrior then Item.Warrior = {} end
Item.Warrior.Commons = {
  -- Potions
  PotionofPhantomFire                   = Item(171349),
  PotionofSpectralStrength              = Item(171275),
  -- Trinkets
  DDVoracity                            = Item(173087, {13, 14}),
  FlameofBattle                         = Item(181501, {13, 14}),
  GrimCodex                             = Item(178811, {13, 14}),
  InscrutableQuantumDevice              = Item(179350, {13, 14}),
  InstructorsDivineBell                 = Item(184842, {13, 14}),
  MacabreSheetMusic                     = Item(184024, {13, 14}),
  OverwhelmingPowerCrystal              = Item(179342, {13, 14}),
  WakenersFrond                         = Item(181457, {13, 14}),
  -- Gladiator's Badges
  SinfulGladiatorsBadge                 = Item(175921, {13, 14}),
  UnchainedGladiatorsBadge              = Item(185197, {13, 14}),

  
  drums = Item(172233),

  potion = Item(169451),

}

Item.Warrior.Fury = MergeTableByKey(Item.Warrior.Commons, {
})

Item.Warrior.Arms = MergeTableByKey(Item.Warrior.Commons, {
})

Item.Warrior.Protection = MergeTableByKey(Item.Warrior.Commons, {
})