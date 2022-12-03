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

-- Spells
if not Spell.Warlock then Spell.Warlock = {} end
Spell.Warlock.Commons = {
  -- Racials


  MPI = Spell(999955),
  combat = Spell(999956),
  channeling = Spell(999957),
  mounted = Spell(999958),
  Berserking                            = Spell(26297),
  BloodFury                             = Spell(33702),
  Fireblood                             = Spell(265221),
  -- Abilities
  ShadowBolt                            = Spell(686),
  SummonDarkglare                       = Spell(205180),
  UnendingResolve                       = Spell(104773),
  -- Talents
  GrimoireofSacrifice                   = Spell(108503),
  GrimoireofSacrificeBuff               = Spell(196099),
  SoulConduit                           = Spell(215941),
  -- Command Demon Abilities
  AxeToss                               = Spell(119914),
  Seduction                             = Spell(119909),
  ShadowBulwark                         = Spell(119907),
  SingeMagic                            = Spell(119905),
  SpellLock                             = Spell(119910),
}

Spell.Warlock.Demonology = MergeTableByKey(Spell.Warlock.Commons, {
  -- Base Abilities
  Felstorm                              = Spell(89751),
  HandofGuldan                          = Spell(105174), -- Splash, 8
  SummonPet                             = Spell(30146),
  -- Talents
  BilescourgeBombers                    = Spell(267211), -- Splash, 8
  CallDreadstalkers                     = Spell(104316),
  Demonbolt                             = Spell(264178),
  DemonicCalling                        = Spell(205145),
  DemonicStrength                       = Spell(267171),
  Doom                                  = Spell(603),
  FromtheShadows                        = Spell(267170),
  GrimoireFelguard                      = Spell(111898),
  Guillotine                            = Spell(386833),
  Implosion                             = Spell(196277), -- Splash, 8
  InnerDemons                           = Spell(267216),
  NetherPortal                          = Spell(267217),
  PowerSiphon                           = Spell(264130),
  SacrificedSouls                       = Spell(267214),
  SoulStrike                            = Spell(264057),
  SummonDemonicTyrant                   = Spell(265187),
  SummonVilefiend                       = Spell(264119),
  -- Buffs
  DemonicCallingBuff                    = Spell(205146),
  DemonicCoreBuff                       = Spell(264173),
  DemonicPowerBuff                      = Spell(265273),
  NetherPortalBuff                      = Spell(267218),
  -- Debuffs
  DoomDebuff                            = Spell(603),
  FromtheShadowsDebuff                  = Spell(270569),
})

Spell.Warlock.Affliction = MergeTableByKey(Spell.Warlock.Commons, {
  -- Base Abilities
  Agony                                 = Spell(980),
  AgonyDebuff                           = Spell(980),
  Corruption                            = Spell(172),
  CorruptionDebuff                      = Spell(146739),
  DrainLife                             = Spell(234153),
  MaleficRapture                        = Spell(324536),
  SeedofCorruption                      = Spell(27243),
  SeedofCorruptionDebuff                = Spell(27243),
  SummonPet                             = Spell(688),
  UnstableAffliction                    = Spell(316099),
  UnstableAfflictionDebuff              = Spell(316099),
  -- Talents
  AbsoluteCorruption                    = Spell(196103),
  DarkSoulMisery                        = Spell(113860),
  DrainSoul                             = Spell(198590),
  Haunt                                 = Spell(48181),
  HauntDebuff                           = Spell(48181),
  InevitableDemise                      = Spell(334319),
  InevitableDemiseBuff                  = Spell(334320),
  Nightfall                             = Spell(108558),
  PhantomSingularity                    = Spell(205179),
  PhantomSingularityDebuff              = Spell(205179),
  ShadowEmbrace                         = Spell(32388),
  ShadowEmbraceDebuff                   = Spell(32390),
  SiphonLife                            = Spell(63106),
  SiphonLifeDebuff                      = Spell(63106),
  SowtheSeeds                           = Spell(196226),
  VileTaint                             = Spell(278350),
  VileTaintDebuff                       = Spell(278350),
  WritheinAgony                         = Spell(196102),
  -- T28 Effects
  CalamitousCrescendo                   = Spell(364322),
})

Spell.Warlock.Destruction = MergeTableByKey(Spell.Warlock.Commons, {
  -- Base Abilities
  Backdraft                             = Spell(117828),
  ChaosBolt                             = Spell(116858),
  Conflagrate                           = Spell(17962),
  Havoc                                 = Spell(80240),
  Immolate                              = Spell(348),
  ImmolateDebuff                        = Spell(157736),
  Incinerate                            = Spell(29722),
  RainofFire                            = Spell(5740),
  SummonInfernal                        = Spell(1122),
  SummonPet                             = Spell(688),
  -- Talents
  Cataclysm                             = Spell(152108),
  ChannelDemonfire                      = Spell(196447),
  DarkSoulInstability                   = Spell(113858),
  Eradication                           = Spell(196412),
  EradicationDebuff                     = Spell(196414),
  FireandBrimstone                      = Spell(196408),
  Flashover                             = Spell(267115),
  Inferno                               = Spell(270545),
  InternalCombustion                    = Spell(266134),
  RainofChaos                           = Spell(266086),
  RainofChaosBuff                       = Spell(266087),
  ReverseEntropy                        = Spell(205148),
  RoaringBlaze                          = Spell(205184),
  RoaringBlazeDebuff                    = Spell(265931),
  Shadowburn                            = Spell(17877),
  SoulFire                              = Spell(6353),
  -- T28 Effects
  RitualofRuinBuff                      = Spell(364349),
})

-- Items
if not Item.Warlock then Item.Warlock = {} end
Item.Warlock.Commons = {
  -- Potion
  PotionofSpectralIntellect             = Item(307096),
  -- Trinkets
  ArchitectsIngenuityCore               = Item(188268, {13, 14}),
  CosmicAspirantsBadgeofFerocity        = Item(186906, {13, 14}),
  CosmicGladiatorsBadgeofFerocity       = Item(186866, {13, 14}),
  CosmicGladiatorsResonator             = Item(188766, {13, 14}),
  DarkmoonDeckPutrescence               = Item(173069, {13, 14}),
  DreadfireVessel                       = Item(184030, {13, 14}),
  EbonsoulVise                          = Item(186431, {13, 14}),
  EmpyrealOrdnance                      = Item(180117, {13, 14}),
  FigureheadoftheNaglfar                = Item(137329, {13, 14}),
  FlameofBattle                         = Item(181501, {13, 14}),
  GlyphofAssimilation                   = Item(184021, {13, 14}),
  GrimEclipse                           = Item(188254, {13, 14}),
  HornofValor                           = Item(133642, {13, 14}),
  InscrutableQuantumDevice              = Item(179350, {13, 14}),
  InstructorsDivineBell                 = Item(184842, {13, 14}),
  MacabreSheetMusic                     = Item(184024, {13, 14}),
  MoonlitPrism                          = Item(137541, {13, 14}),
  MrrgriasFavor                         = Item(142160, {13, 14}),
  ObeliskoftheVoid                      = Item(137433, {13, 14}),
  OverflowingAnimaCage                  = Item(178849, {13, 14}),
  ResonantReservoir                     = Item(188272, {13, 14}),
  ScarsofFraternalStrife                = Item(188253, {13, 14}),
  ShadowedOrbofTorment                  = Item(186428, {13, 14}),
  SinfulAspirantsBadgeofFerocity        = Item(175884, {13, 14}),
  SinfulAspirantsEmblem                 = Item(178334, {13, 14}),
  SinfulGladiatorsBadgeofFerocity       = Item(175921, {13, 14}),
  SinfulGladiatorsEmblem                = Item(178447, {13, 14}),
  SoleahsSecretTechnique                = Item(185818, {13, 14}),
  SoulIgniter                           = Item(184019, {13, 14}),
  SoullettingRuby                       = Item(178809, {13, 14}),
  SunbloodAmethyst                      = Item(178826, {13, 14}),
  TabletofDespair                       = Item(181357, {13, 14}),
  TheFirstSigil                         = Item(188271, {13, 14}),
  ToeKneesPromise                       = Item(142164, {13, 14}),
  TomeofMonstrousConstructions          = Item(186422, {13, 14}),
  UnchainedGladiatorsShackles           = Item(186980, {13, 14}),
  WakenersFrond                         = Item(181457, {13, 14}),
  -- Other On-Use Items
  NeuralSynapseEnhancer                 = Item(168973),
}

Item.Warlock.Affliction = MergeTableByKey(Item.Warlock.Commons, {
})

Item.Warlock.Demonology = MergeTableByKey(Item.Warlock.Commons, {
})

Item.Warlock.Destruction = MergeTableByKey(Item.Warlock.Commons, {
})
