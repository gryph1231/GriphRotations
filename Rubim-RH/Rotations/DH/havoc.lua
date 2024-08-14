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
-- Lua
local pairs = pairs;
local tableconcat = table.concat;
local tostring = tostring;
local tableinsert = table.insert;

if not Spell.DemonHunter then
    Spell.DemonHunter = {};
end


RubimRH.Spell[577] = {
--INTERRUPTS
--PVP
Polymorph = Spell(118),
Repentance = Spell(20066),
HexPvP = Spell(51514),
WyvernSting = Spell(19386),
Fear = Spell(5782),
Cyclone = Spell(33786),
MindControl = Spell(605),
RevivePet = Spell(982),
MassDispel  = Spell(32375),
GreatestPyroblast = Spell(203286),
ChaosBolt = Spell(116858),
Rebirth = Spell(20484),
SniperShot = Spell(203155),
Penance = Spell(47540),
PrayerofHealing = Spell(596),
HealPvP = Spell(2060),
FlashHeal = Spell(2061),
BindingHeal = Spell(32546),
PrayerofMending = Spell(33076),
DivineHymn = Spell(64843),
Halo = Spell(120517),
ShadowMend = Spell(186263),
PowerWordRadiance = Spell(194509),
HolyWordSalvation = Spell(265202),
GreaterHeal = Spell(289666),
Tranquility = Spell(740),
Regrowth = Spell(8936),
WildGrowth = Spell(48438),
Nourish = Spell(289022),
ChainHeal = Spell(1064),
HealingSurge = Spell(8004),
HealingRain = Spell(73920),
Wellspring = Spell(197995),
Downpour = Spell(207778),
FlashofLight = Spell(19750),
HolyLight = Spell(82326),
Vivify = Spell(116670),
EnvelopingMist = Spell(124682),
EssenceFont = Spell(191837),
SoothingMist = Spell(209525),
SurgingMist = Spell(227344),

--Dungeons
	DarkLotus = Spell(328740),
    DrainFluids = Spell(334748),
    MeatShield = Spell(323190),
    NecroticBolt = Spell(320462),
    FrostboltVolley = Spell(328667),
    ShadowWell = Spell(320571),
    RaspingScream = Spell(324293),
    Goresplatter = Spell(338353),
    RepairFlesh = Spell(327130), -- channel
    Bonemend = Spell(335143),
    SpiritBolt = Spell(323057),
    BramblethornCoat = Spell(324776),
    NourishTheForest = Spell(324914),
    StimulateResistance = Spell(357746),
    StimulateRegeneration = Spell(340544), -- channel
    ParasiticPacification = Spell(337235),
    ParasiticIncapacitation = Spell(337251),
    ParasiticDomination = Spell(337253),
    HarvestEssence = Spell(322938), -- channel
    BurdenofKnowledge = Spell(317963),
    DarkLash = Spell(317959),
    RebelliousFist = Spell(327413),
    DarkLance = Spell(327481),
    ForswornDoctrine = Spell(317936),
    InsidiousVenom = Spell(317661),
    InternalStrife = Spell(327648),
    ForcedConfession = Spell(328331),
    GreaterMending = Spell(328295),
    DarkPulse = Spell(328137),
    CurseofObliteration = Spell(325876),
    WickedBolt = Spell(338003),
    CollectSins = Spell(325700),
    TurntoStone = Spell(326607),
    VolleyofPower = Spell(323552),
    BoltofPower = Spell(323538),
    Scribe = Spell(328707),
    DeathsEmbrace = Spell(333875),
    Shadowcore = Spell(334076),
    Heal = Spell(332706),
    ShadowWordPain = Spell(332707),
    Smite = Spell(332705),
    HealingWave = Spell(332612),
    Hex = Spell(335775),
    LightningDischarge = Spell(335778),
    Lubricate = Spell(331379),
    SelfCleaningCycle = Spell(332084),
    Frostbolt = Spell(320008),
    BarkArmor = Spell(321764),
    WonderGrow = Spell(328016),
    BindingFungus = Spell(329917),
    CreepyCrawlers = Spell(329239),
    CorrosiveGunk = Spell(319070),
    GrippingInfection = Spell(328180),
    PestilenceBolt = Spell(328094),
    ViralGlobs = Spell(321999),
    EnvelopingWebbing = Spell(328475),
    DrainEssence = Spell(320861),
    SapLifeblood = Spell(321105),
    Engorge = Spell(334653), -- channel
    HungeringDrain = Spell(319654),
    CurseofSuppression = Spell(326836),
    Stoneskin = Spell(322433),
    GloomBurst = Spell(326837),
    BarbedShackles = Spell(335305),
    ExplosiveAnger = Spell(336277),
    FieryCantrip = Spell(326952),
    PlagueBolt = Spell(320120),
    NecromanticBolt = Spell(320300),
    DemoralizingShout = Spell(330562),
    BattleTrance = Spell(342139),
    BindSoul = Spell(330810),
    BoneSpear = Spell(342675),
    GraveSpike = Spell(341771),
    NecroticBoltVolley = Spell(330868),
    SpiritFrost = Spell(330875),
    FieryCantrip = Spell(326952),
    NecroticBoltToP = Spell(330784),
    MeatShieldToP = Spell(341977),
    WitheringDischarge = Spell(341969),
    DecayingFilth = Spell(330703),
	EssenceBreakDebuff = Spell(320338),
	EssenceBreak = Spell(258860),
    -- Racials
    ArcaneTorrent = Spell(202719),
    -- Abilities
    BladeDance = Spell(188499),
    ConsumeMagic = Spell(278326),
    ChaosStrike = Spell(162794),
    ChaosNova = Spell(179057),
    SpectralSight = Spell(188501),
    Disrupt = Spell(183752),
    DeathSweep = Spell(210152),
    DemonsBite = Spell(162243),
	UnleashHeartOfAzeroth = Spell(280431),
    EyeBeam = Spell(198013),
    FelRush = Spell(195072),
	Shadowmeld = Spell(58984),
	Imprison = Spell(217832),
    Metamorphosis = Spell(191427),
    MetamorphosisImpact = Spell(200166),
    MetamorphosisBuff = Spell(162264),
    ThrowGlaive = Spell(185123),
    VengefulRetreat = Spell(198793),
	ConcentratedFlame = Spell(295373),
	SinfulBrand = Spell(317009),
	theHunt = Spell(323639),
    -- Talents
    BlindFury = Spell(203550),
    Bloodlet = Spell(206473),
    ChaosBlades = Spell(247938),
    ChaosCleave = Spell(206475),
    DemonBlades = Spell(203555),
    Demonic = Spell(213410),
    DemonicAppetite = Spell(206478),
    DemonReborn = Spell(193897),
    Felblade = Spell(232893),
    FelEruption = Spell(211881),
    FelMastery = Spell(192939),
    FirstBlood = Spell(206416),
    MasterOfTheGlaive = Spell(203556),
    Momentum = Spell(206476),
    MomentumBuff = Spell(208628),
    Nemesis = Spell(206491),
    NemesisDebuff = Spell(206491),
    TrailofRuin = Spell(258881),
    -- Artifact
    Blur = Spell(198589),
    Darkness = Spell(196718),
    -- Talents
    ImmolationAura = Spell(258920),
    FelBarrage = Spell(258925),
    DarkSlash = Spell(258860),
    DarkSlashDebuff = Spell(258860),
    PreparedBuff = Spell(203650),
	GlaiveTempest = Spell(342817),
    RevolvingBlades = Spell(279581),
    UnboundChaos = Spell(275144),
    ChaoticTransformation = Spell(288754),
    ChaosTheory = Spell(337551),
	ElysianDecree = Spell(306830),
	TheHunt = Spell(323639),
	FoddertotheFlame = Spell(329554),
	SinfulBrand = Spell(317009),	
	Steward = Spell(324739),
	BurningWound = Spell(346278),
	lust1 = Spell(57724),
	lust2 = Spell(57723),
	lust3 = Spell(80354),
	lust4 = Spell(95809),
	lust5 = Spell(264689),
	Annihilation = Spell(201427),
	FelBombardment = Spell(337775),
	lustAT = Spell(155145),
	healingpot = Spell(176108), --phial/pots
	foodanddrink = Spell(308433),
	trink = Spell(274738),
}

local S = RubimRH.Spell[577] 

if not Item.DemonHunter then Item.DemonHunter = {}; end

Item.DemonHunter.Havoc = {

};

local I = Item.DemonHunter.Havoc;


S.Annihilation.TextureSpellID = { 204317 }
S.DeathSweep.TextureSpellID = { 199552 }
S.Metamorphosis.TextureSpellID = { 187827 }


local function num(val)
    if val then
        return 1
    else
        return 0
    end
end



local function APL()
local name, text, texture, startTimeMS, endTimeMS, isTradeSkill, castID, notInterruptible, spellId = UnitCastingInfo("target")

	HL.GetEnemies("Melee");
	HL.GetEnemies(5, true);
    HL.GetEnemies(8, true);
    HL.GetEnemies(10, true);
	HL.GetEnemies(15, true);
	HL.GetEnemies(30, true);

if Player:IsCasting() or Player:IsChanneling() or Player:BuffP(S.foodanddrink) then
	return 0, "Interface\\Addons\\Rubim-RH\\Media\\channel.tga"
end 

--INTERRUPTS
	if notInterruptible == false and Target:CastPercentage() > 35 and RubimRH.InterruptsON() and S.Disrupt:IsReady(8) and Target:AffectingCombat() then
		return S.Disrupt:Cast()
	end

--QUEUE
	if not RubimRH.queuedSpell[1]:CooldownUp() or not Player:AffectingCombat() then
		RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
	end

	if RubimRH.QueuedSpell():IsReadyQueue() then
        return RubimRH.QueuedSpell():Cast()
    end

--ROTATION
if Player:AffectingCombat() and Player:CanAttack(Target) then

	if S.SinfulBrand:IsReady(30) and (Target:HealthPercentage() >= 80 or (UnitClassification("target") == "worldboss" or UnitClassification("target") == "boss")) then
        return S.SinfulBrand:Cast()
    end
	
	if S.ImmolationAura:IsReady(15) and Player:BuffRemainsP(S.ImmolationAura) <= Player:GCD() then
        return S.ImmolationAura:Cast()
    end

	if S.GlaiveTempest:IsReady() and Cache.EnemiesCount[8] >= 1 then
        return S.GlaiveTempest:Cast()
    end
	
	if S.DeathSweep:IsReadyMorph(8) and (Cache.EnemiesCount[8] >= 3 or S.FirstBlood:IsAvailable()) then
		return S.DeathSweep:Cast()
	end
	
	-- if S.BladeDance:IsReady() and Cache.EnemiesCount[10] > 2  then
        -- return S.BladeDance:Cast()
    -- end
	
	if S.BladeDance:IsReady(8) and (Cache.EnemiesCount[8] >= 3 or S.FirstBlood:IsAvailable()) then
        return S.BladeDance:Cast()
    end
	
	if S.Annihilation:IsReadyMorph("Melee") and Player:Fury() >= 30 then
		return S.Annihilation:Cast()
	end
	
	if S.ChaosStrike:IsReady("Melee") and Player:Fury() >= 30 then
        return S.ChaosStrike:Cast()
    end

	if S.DemonsBite:IsReady("Melee") then
        return S.DemonsBite:Cast()
    end

end




	
    return 0, "Interface\\Addons\\Rubim-RH\\Media\\mount2.tga"
end




RubimRH.Rotation.SetAPL(577, APL);

local function PASSIVE()
    
end

RubimRH.Rotation.SetPASSIVE(577, PASSIVE);