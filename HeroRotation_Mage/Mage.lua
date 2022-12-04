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
-- lua
local GetTime    = GetTime

-- File Locals
HR.Commons.Mage = {}
local Settings = HR.GUISettings.APL.Mage.Commons
local Mage = HR.Commons.Mage

--- ============================ CONTENT ============================

-- Spells
if not Spell.Mage then Spell.Mage = {} end
Spell.Mage.Commons = {
  -- Racials
  AncestralCall                         = Spell(274738),
  BagofTricks                           = Spell(312411),
  Berserking                            = Spell(26297),
  BerserkingBuff                        = Spell(26297),
  BloodFury                             = Spell(20572),
  BloodFuryBuff                         = Spell(20572),
  Fireblood                             = Spell(265221),
  LightsJudgment                        = Spell(255647),
  -- Abilities
  ArcaneExplosion                       = Spell(1449), --Melee, 10
  ArcaneIntellect                       = Spell(1459),
  ArcaneIntellectBuff                   = Spell(1459),
  Blink                                 = MultiSpell(1953, 212653),
  Frostbolt                             = Spell(116),
  FrostNova                             = Spell(122),
  SlowFall                              = Spell(130),
  TimeWarp                              = Spell(80353),
  -- Talents
  AlterTime                             = Spell(342245),
  IceBlock                              = Spell(45438),
  Counterspell                          = Spell(2139),
  SpellSteal                            = Spell(30449),
  Invisibility                          = Spell(66),
  MirrorImage                           = Spell(55342),
  RemoveCurse                           = Spell(475),
  FocusMagic                            = Spell(321358),
  RingOfFrost                           = Spell(113724),
  RuneofPower                           = Spell(116011),
  RuneofPowerBuff                       = Spell(116014),
  BlastWave                             = Spell(157981),
  IceFloes                              = Spell(108839),
  IceNova                               = Spell(157997), --splash, 8
  Meteor                                = Spell(153561),
  ShiftingPower                         = Spell(382440), --Melee 15
}

Spell.Mage.Arcane = MergeTableByKey(Spell.Mage.Commons, {
  -- Abilities
  ArcaneBarrage                         = Spell(44425), --Splash, 10
  ArcaneBlast                           = Spell(30451),
  ArcaneMissiles                        = Spell(5143),
  ArcanePower                           = Spell(12042),
  ClearcastingBuff                      = Spell(263725),
  ConjureManaGem                        = Spell(759),
  Evocation                             = Spell(12051),
  FireBlast                             = Spell(319836),
  PresenceofMind                        = Spell(205025),
  TouchoftheMagi                        = Spell(321507), --Splash, 8
  TouchoftheMagiDebuff                  = Spell(210824),
  PrismaticBarrier                      = Spell(235450),
  GreaterInvisibility                   = Spell(110959),
  -- Talents
  Amplification                         = Spell(236628),
  ArcaneEcho                            = Spell(342231), --Splash, 8
  ArcaneFamiliar                        = Spell(205022),
  ArcaneFamiliarBuff                    = Spell(210126),
  ArcaneOrb                             = Spell(153626), --Splash, 16
  Enlightened                           = Spell(321387),
  NetherTempest                         = Spell(114923), --Splash, 10
  Overpowered                           = Spell(155147),
  Resonance                             = Spell(205028),
  RuleofThrees                          = Spell(264354),
  RuleofThreesBuff                      = Spell(264774),
  Slipstream                            = Spell(236457),
  Supernova                             = Spell(157980), --Splash, 8
  -- Legendaries (Shadowlands)
  ArcaneHarmonyBuff                     = Spell(332777),
  SiphonStormBuff                       = Spell(332934),
})

Spell.Mage.Fire = MergeTableByKey(Spell.Mage.Commons, {
  -- Abilities
  BlazingBarrier                        = Spell(235313),
  Combustion                            = Spell(190319),
  CombustionBuff                        = Spell(190319),
  DragonsBreath                         = Spell(31661),
  FireBlast                             = Spell(108853),
  Fireball                              = Spell(133),
  Flamestrike                           = Spell(2120),
  HeatingUpBuff                         = Spell(48107),
  HotStreakBuff                         = Spell(48108),
  Ignite                                = Spell(12654),
  PhoenixFlames                         = Spell(257541),
  Pyroblast                             = Spell(11366),
  Scorch                                = Spell(2948),
  -- Talents
  AlexstraszasFury                      = Spell(235870),
  Firestarter                           = Spell(205026),
  FlameOn                               = Spell(205029),
  FlamePatch                            = Spell(205037),
  FromTheAshes                          = Spell(342344),
  Kindling                              = Spell(155148),
  LivingBomb                            = Spell(44457),
  Pyroclasm                             = Spell(269650),
  PyroclasmBuff                         = Spell(269651),
  SearingTouch                          = Spell(269644),
  -- Conduit
  FlameAccretion                        = Spell(337224),
  InfernalCascade                       = Spell(336821),
  InfernalCascadeBuff                   = Spell(336832),
  -- Legendaries (Shadowlands)
  FirestormBuff                         = Spell(333100),
  GrislyIcicleBuff                      = Spell(333393),
  GrislyIcicleDebuff                    = Spell(348007),
  SunKingsBlessingBuff                  = Spell(333314),
  SunKingsBlessingBuffReady             = Spell(333315),
})

Spell.Mage.Frost = MergeTableByKey(Spell.Mage.Commons, {
  -- Abilities
  ConeofCold                            = Spell(120),--Melee, 12
  IciclesBuff                           = Spell(205473),
  WintersChillDebuff                    = Spell(228358),
  FireBlast                             = Spell(319836),
  -- Talents
  Blizzard                              = Spell(190356), --splash, 16
  BoneChilling                          = Spell(205766),
  ChainReaction                         = Spell(278309),
  CometStorm                            = Spell(153595), --splash, 6
  Ebonbolt                              = Spell(257537), --splash, 8 (with splitting ice)
  Flurry                                = Spell(44614),
  FreezingRain                          = Spell(270233),
  FreezingWinds                         = Spell(382103),
  Frostbite                             = Spell(198121),
  FrozenOrb                             = Spell(84714), --splash, 16
  GlacialSpike                          = Spell(199786), --splash, 8 (with splitting ice)
  IceBarrier                            = Spell(11426),
  IceCaller                             = Spell(236662),
  IceLance                              = Spell(30455), --splash, 8 (with splitting ice)
  IcyVeins                              = Spell(12472),
  RayofFrost                            = Spell(205021),
  SlickIce                              = Spell(382144),
  Snowstorm                             = Spell(381706),
  SplittingIce                          = Spell(56377), --splash, 8
  SummonWaterElemental                  = Spell(31687),
  -- Pet Abilities
  Freeze                                = Spell(33395, "pet"), --splash, 8
  WaterJet                              = Spell(135029, "pet"),
  -- Buffs
  BrainFreezeBuff                       = Spell(190446),
  FingersofFrostBuff                    = Spell(44544),
  FreezingRainBuff                      = Spell(270232),
  FreezingWindsBuff                     = Spell(382106),
  GlacialSpikeBuff                      = Spell(199844),
  IcyVeinsBuff                          = Spell(12472),
  SnowstormBuff                         = Spell(381522),
  -- Debuffs
})

-- Items
if not Item.Mage then Item.Mage = {} end
Item.Mage.Commons = {
  -- Trinkets
  -- Other On-Use Items
}

Item.Mage.Arcane = MergeTableByKey(Item.Mage.Commons, {
  ManaGem                          = Item(36799),
})

Item.Mage.Fire = MergeTableByKey(Item.Mage.Commons, {
})

Item.Mage.Frost = MergeTableByKey(Item.Mage.Commons, {
})

-- Variables
Mage.IFST = {
  CurrStacks = 0,
  CurrStacksTime = 0,
  OldStacks = 0,
  OldStacksTime = 0,
  Direction = 0
}
local S = {}
S.IncantersFlowBuff = Spell(116267)

HL:RegisterForEvent(function()
  Mage.IFST.CurrStacks = 0
  Mage.IFST.CurrStacksTime = 0
  Mage.IFST.OldStacks = 0
  Mage.IFST.OldStacksTime = 0
  Mage.IFST.Direction = 0
end, "PLAYER_REGEN_ENABLED")

function Mage.IFTracker()
  if HL.CombatTime() == 0 then return; end
  local TickDiff = Mage.IFST.CurrStacksTime - Mage.IFST.OldStacksTime
  local CurrStacks = Mage.IFST.CurrStacks
  local CurrStacksTime = Mage.IFST.CurrStacksTime
  local OldStacks = Mage.IFST.OldStacks
  if (Player:BuffUp(S.IncantersFlowBuff)) then
    if (Player:BuffStack(S.IncantersFlowBuff) ~= CurrStacks or (Player:BuffStack(S.IncantersFlowBuff) == CurrStacks and TickDiff > 1)) then
      Mage.IFST.OldStacks = CurrStacks
      Mage.IFST.OldStacksTime = CurrStacksTime
    end
    Mage.IFST.CurrStacks = Player:BuffStack(S.IncantersFlowBuff)
    Mage.IFST.CurrStacksTime = HL.CombatTime()
    if Mage.IFST.CurrStacks > Mage.IFST.OldStacks then
      if Mage.IFST.CurrStacks == 5 then
        Mage.IFST.Direction = 0
      else
        Mage.IFST.Direction = 1
      end
    elseif Mage.IFST.CurrStacks < Mage.IFST.OldStacks then
      if Mage.IFST.CurrStacks == 1 then
        Mage.IFST.Direction = 0
      else
        Mage.IFST.Direction = -1
      end
    else
      if Mage.IFST.CurrStacks == 1 then
        Mage.IFST.Direction = 1
      else
        Mage.IFST.Direction = -1
      end
    end
  else
    Mage.IFST.OldStacks = 0
    Mage.IFST.OldStacksTime = 0
    Mage.IFST.CurrStacks = 0
    Mage.IFST.CurrStacksTime = 0
    Mage.IFST.Direction = 0
  end
end

function Mage.IFTimeToX(count, direction)
    local low
    local high
    local buff_position
    if Mage.IFST.Direction == -1 or (Mage.IFST.Direction == 0 and Mage.IFST.CurrStacks == 0) then
      buff_position = 10 - Mage.IFST.CurrStacks + 1
    else
      buff_position = Mage.IFST.CurrStacks
    end
    if direction == "up" then
        low = count
        high = count
    elseif direction == "down" then
        low = 10 - count + 1
        high = 10 - count + 1
    else
        low = count
        high = 10 - count + 1
    end
    if low == buff_position or high == buff_position then
      return 0
    end
    local ticks_low = (10 + low - buff_position) % 10
    local ticks_high = (10 + high - buff_position) % 10
    return (Mage.IFST.CurrStacksTime - Mage.IFST.OldStacksTime) + math.min(ticks_low, ticks_high) - 1
end
