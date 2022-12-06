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

if not Spell.Rogue then
    Spell.Rogue = {};
end


RubimRH.Spell[260] = {
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
    StimulateResistance = Spell(326046),
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
    Hex = Spell(332605),
    LightningDischarge = Spell(332608),
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


-- Soothe
	SeethingRage = Spell(320703),
   UndyingRage = Spell(333227),
    SeethingRage = Spell(320703),
    UnholyFrenzy = Spell(320012),
    VengefulRage = Spell(327155),
    Enraged = Spell(324737),
    LoyalBeasts = Spell(326450),
    Frenzy = Spell(321220),
    RagingTantrum = Spell(333241),
    BattleTrance = Spell(342139),

	
	Steward = Spell(324739),
	EchoingReprimand = Spell(323547),
	EchoingReprimandz = Spell(265221), --fireblood
	EchoingReprimandCP2 = Spell(323558),
	EchoingReprimandCP3 = Spell(323559),
	EchoingReprimandCP4 = Spell(323560),
	trink2z = Spell(260364), --arcane pulse
	BladeRush = Spell(271877),
	stopcasting = Spell(291944), --regeneratin
	CripplingPoison = Spell(3408),
	cripplingpoison = Spell(260364), --arcane pulse
	InstantPoison = Spell(315584),
	instantpoison = Spell(274738), --ancestral call
	NumbingPoison  = Spell(5761),
	lust1 = Spell(57724),
	lust2 = Spell(57723),
	lust3 = Spell(80354),
	lust4 = Spell(95809),
	lust5 = Spell(264689),
	
	KidneyShot = Spell(408),
    AceUpYourSleeve = Spell(278676),
    Deadshot = Spell(272935),
    Berserking = Spell(26297),
    Darkflight = Spell(68992),
	Distract = Spell(1725),
	lustAT = Spell(155145),
    WaterStrider = Spell(118089),
    BugMount = Spell(243795),
	razorcoral = Spell(303568),
	ConductiveInk = Spell(302565),
    AdrenalineRush = Spell(13750),
    Ambush = Spell(8676),
    BetweentheEyes = Spell(315341),
    BladeFlurry = Spell(13877),
    DeeperStratagem = Spell(193531),
    Opportunity = Spell(195627),
    PistolShot = Spell(185763),
    RolltheBones = Spell(315508),
    Dispatch = Spell(2098),
    SinisterStrike = Spell(193315),
    Stealth = Spell(1784),
    Vanish = Spell(1856),
    VanishBuff = Spell(11327),
    Shiv = Spell(5938),
    Riposte = Spell(199754), -- evasion
    WilloftheForsaken = Spell(7744),
    CloakofShadows = Spell(31224),
    Alacrity = Spell(193539),
    AlacrityBuff = Spell(193538),
    Anticipation = Spell(114015),
    CannonballBarrage = Spell(185767),
    DeathfromAbove = Spell(152150),
    DeeperStratagem = Spell(193531),
    DirtyTricks = Spell(108216),
    GhostlyStrike = Spell(196937),
    KillingSpree = Spell(51690),
    MarkedforDeath = Spell(137619),
	MarkedforDeathz = Spell(265221), --fireblood
    QuickDraw = Spell(196938),
    Tricks = Spell(57934),
    ToTT = Spell(58984),
    SliceandDice = Spell(315496),
    Vigor = Spell(14983),
	Exhaustion = Spell(57723),
	Blind = Spell(2094),
    Blunderbuss = Spell(202895),
    CurseoftheDreadblades = Spell(202665),
    HiddenBlade = Spell(202754),
    LoadedDice = Spell(256171),
    DeadshotBuff = Spell(272940),
	AceUpYourSleeve = Spell(278676),
	SnakeEyes = Spell(275846),
	SnakeEyesBuff = Spell(275863),
	DS = Spell(642),
	CheapShot = Spell(1833),
    CrimsonVial = Spell(185311),
    Feint = Spell(1966),
    Gouge = Spell(1776),
    Kick = Spell(1766),
    Sprint = Spell(2983),
    Broadside = Spell(193356),
    BuriedTreasure = Spell(199600),
    GrandMelee = Spell(193358),
    SkullandCrossbones = Spell(199603),
	GCBoon = Spell(20572),
    RuthlessPrecision = Spell(193357),
    TrueBearing = Spell(193359),
	Evasion = Spell(5277),
	healingpot = Spell(176108), --phial/pots
	crimsonvial = Spell(312411), --bag of tricks
	phialofserenityz = Spell(107079), --quaking palm
	PistolShotz = Spell(287712),
	foodanddrink = Spell(308433),
	smokebomb = Spell(212182),
	trink = Spell(274738),
	trink2 = Spell(260364),
	plunderarmor = Spell(198529),
	FlayedToxin = Spell(345545),
	dismasterassassin = Spell(207777),
	masterassassin = Spell(340094),
	WoundPoison = Spell(8679),
}

local S = RubimRH.Spell[260] 

if not Item.Rogue then Item.Rogue = {}; end

Item.Rogue.Outlaw = {
	trink = Item(184016, { 13, 14 }),
		trink2 = Item(179350, { 13, 14 }),
drums = Item(172233),
    healingpot = Item(171267),
	masterassassin = Item(178926, {12}),
	healthstone = Item(5512),
	phialofserenity = Item(177278),
};

local I = Item.Rogue.Outlaw;


local RtB_BuffsList = {
    S.Broadside,
    S.BuriedTreasure,
    S.GrandMelee,
    S.SkullandCrossbones,
    S.RuthlessPrecision,
    S.TrueBearing
};

local function num(val)
    if val then
        return 1
    else
        return 0
    end
end

local function CPMaxSpend()
    return RubimRH.Spell[261].DeeperStratagem:IsAvailable() and 6 or 5;
end

local function RtB_BuffRemains ()
    if not Cache.APLVar.RtB_BuffRemains then
        Cache.APLVar.RtB_BuffRemains = 0;
        for i = 1, #RtB_BuffsList do
            if Player:Buff(RtB_BuffsList[i]) then
                Cache.APLVar.RtB_BuffRemains = Player:BuffRemainsP(RtB_BuffsList[i]);
                break ;
            end
        end
    end
    return Cache.APLVar.RtB_BuffRemains;
end

local function RtB_Buffs()
    if not Cache.APLVar.RtB_Buffs then
        Cache.APLVar.RtB_Buffs = 0;
        for i = 1, #RtB_BuffsList do
            if Player:BuffP(RtB_BuffsList[i]) then
                Cache.APLVar.RtB_Buffs = Cache.APLVar.RtB_Buffs + 1;
            end
        end
    end
    return Cache.APLVar.RtB_Buffs;
end

local function EnergyTimeToMaxRounded()
    return math.floor(Player:EnergyTimeToMaxPredicted() * 10 + 0.5) / 10;
end


local ambushcondition 

local function APL()
	HL.GetEnemies("Melee");
	HL.GetEnemies(5, true);
    HL.GetEnemies(8, true);
    HL.GetEnemies(10, true);
	HL.GetEnemies(11, true);
	HL.GetEnemies(12, true);
	HL.GetEnemies(15, true);
	HL.GetEnemies(17, true);
	HL.GetEnemies(20, true);
	HL.GetEnemies(22, true);
	HL.GetEnemies(25, true);
	HL.GetEnemies(30, true);


if S.Shiv:IsReady(8) and Player:Buff(S.NumbingPoison) and RubimRH.InterruptsON() and 
(Target:Buff(S.UndyingRage)
or Target:BuffStack(S.SeethingRage)>=2
or Target:Buff(S.UnholyFrenzy)
or Target:Buff(S.VengefulRage)
or Target:Buff(S.Enraged)
or Target:Buff(S.LoyalBeasts)
or Target:Buff(S.Frenzy)
or Target:Buff(S.RagingTantrum)
or Target:Buff(S.BattleTrance)) then
return S.Shiv:Cast()
end

--INTERRUPTS

	if (Target:IsCasting(S.Polymorph)
or Target:IsCasting(S.DarkLotus)
or Target:IsCasting(S.Repentance)
or Target:IsCasting(S.HexPvP)
or Target:IsCasting(S.WyvernSting)
or Target:IsCasting(S.Fear)
or Target:IsCasting(S.Cyclone)
or Target:IsCasting(S.MindControl)
or Target:IsCasting(S.RevivePet)
or Target:IsCasting(S.MassDispel)
or Target:IsCasting(S.GreatestPyroblast)
or Target:IsCasting(S.ChaosBolt)
or Target:IsCasting(S.Rebirth)
or Target:IsCasting(S.SniperShot)
or Target:IsCasting(S.Penance)
or Target:IsCasting(S.PrayerofHealing)
or Target:IsCasting(S.HealPvP)
or Target:IsCasting(S.FlashHeal)
or Target:IsCasting(S.BindingHeal)
or Target:IsCasting(S.PrayerofMending)
or Target:IsCasting(S.DivineHymn)
or Target:IsCasting(S.Halo)
or Target:IsCasting(S.ShadowMend)
or Target:IsCasting(S.PowerWordRadiance)
or Target:IsCasting(S.HolyWordSalvation)
or Target:IsCasting(S.GreaterHeal)
or Target:IsCasting(S.Tranquility)
or Target:IsCasting(S.Regrowth)
or Target:IsCasting(S.WildGrowth)
or Target:IsCasting(S.Nourish)
or Target:IsCasting(S.ChainHeal)
or Target:IsCasting(S.HealingSurge)
or Target:IsCasting(S.HealingRain)
or Target:IsCasting(S.Wellspring)
or Target:IsCasting(S.Downpour)
or Target:IsCasting(S.FlashofLight)
or Target:IsCasting(S.HolyLight)
or Target:IsCasting(S.Vivify)
or Target:IsCasting(S.EnvelopingMist)
or Target:IsCasting(S.EssenceFont)
or Target:IsCasting(S.SoothingMist)
or Target:IsCasting(S.SurgingMist)
or Target:IsCasting(S.DrainFluids)
or Target:IsCasting(S.MeatShield)
or Target:IsCasting(S.NecroticBolt)
or Target:IsCasting(S.FrostboltVolley)
or Target:IsCasting(S.ShadowWell)
or Target:IsCasting(S.RaspingScream)
or Target:IsCasting(S.Goresplatter)
or Target:IsChanneling(S.RepairFlesh)
or Target:IsCasting(S.Bonemend)
or Target:IsCasting(S.SpiritBolt)
or Target:IsCasting(S.BramblethornCoat)
or Target:IsCasting(S.NourishTheForest)
or Target:IsCasting(S.StimulateResistance)
or Target:IsChanneling(S.StimulateRegeneration)
or Target:IsCasting(S.ParasiticPacification)
or Target:IsCasting(S.ParasiticIncapacitation)
or Target:IsCasting(S.ParasiticDomination)
or Target:IsChanneling(S.HarvestEssence)
or Target:IsCasting(S.BurdenofKnowledge)
or Target:IsCasting(S.DarkLash)
or Target:IsCasting(S.RebelliousFist)
or Target:IsCasting(S.DarkLance)
or Target:IsCasting(S.ForswornDoctrine)
or Target:IsCasting(S.InsidiousVenom)
or Target:IsCasting(S.InternalStrife)
or Target:IsCasting(S.ForcedConfession)
or Target:IsCasting(S.GreaterMending)
or Target:IsCasting(S.DarkPulse)
or Target:IsCasting(S.CurseofObliteration)
or Target:IsCasting(S.WickedBolt)
or Target:IsCasting(S.CollectSins)
or Target:IsCasting(S.TurntoStone)
or Target:IsCasting(S.VolleyofPower)
or Target:IsCasting(S.BoltofPower)
or Target:IsCasting(S.Scribe)
or Target:IsCasting(S.DeathsEmbrace)
or Target:IsCasting(S.Shadowcore)
or Target:IsCasting(S.Heal)
or Target:IsCasting(S.ShadowWordPain)
or Target:IsCasting(S.Smite)
or Target:IsCasting(S.HealingWave)
or Target:IsCasting(S.Hex)
or Target:IsCasting(S.LightningDischarge)
or Target:IsCasting(S.Lubricate)
or Target:IsCasting(S.SelfCleaningCycle)
or Target:IsCasting(S.Frostbolt)
or Target:IsCasting(S.BarkArmor)
or Target:IsCasting(S.WonderGrow)
or Target:IsCasting(S.BindingFungus)
or Target:IsCasting(S.CreepyCrawlers)
or Target:IsCasting(S.CorrosiveGunk)
or Target:IsCasting(S.GrippingInfection)
or Target:IsCasting(S.PestilenceBolt)
or Target:IsCasting(S.ViralGlobs)
or Target:IsCasting(S.EnvelopingWebbing)
or Target:IsCasting(S.DrainEssence)
or Target:IsCasting(S.SapLifeblood)
or Target:IsCasting(S.Engorge)
or Target:IsCasting(S.HungeringDrain)
or Target:IsCasting(S.CurseofSuppression)
or Target:IsCasting(S.Stoneskin)
or Target:IsCasting(S.GloomBurst)
or Target:IsCasting(S.BarbedShackles)
or Target:IsCasting(S.ExplosiveAnger)
or Target:IsCasting(S.FieryCantrip)
or Target:IsCasting(S.PlagueBolt)
or Target:IsCasting(S.NecromanticBolt)
or Target:IsCasting(S.DemoralizingShout)
or Target:IsCasting(S.BattleTrance)
or Target:IsChanneling(S.BindSoul)
or Target:IsCasting(S.BoneSpear)
or Target:IsCasting(S.GraveSpike)
or Target:IsCasting(S.NecroticBoltVolley)
or Target:IsCasting(S.SpiritFrost)
or Target:IsCasting(S.FieryCantrip)
or Target:IsCasting(S.NecroticBoltToP)
or Target:IsCasting(S.MeatShieldToP)
or Target:IsCasting(S.WitheringDischarge)
or Target:IsCasting(S.DecayingFilth))	
	and Target:CastPercentage()> 40 and RubimRH.InterruptsON() and S.Kick:IsReady(8) then
	return S.Kick:Cast()
	end
  





    if S.CrimsonVial:IsCastable() and Cache.EnemiesCount[40] == 0 and Player:HealthPercentage() <= 100 and Player:EnergyDeficit() == 0 then
		return S.CrimsonVial:Cast()
    end
-- variable,name=ambush_condition,value=combo_points.deficit>=2+buff.broadside.up&energy>=50&(!conduit.count_the_odds|buff.roll_the_bones.remains>=10)


        if (true) then
            ambushcondition = Player:ComboPointsDeficit()>=2 + num(Player:Buff(S.Broadside)) and Player:Energy()>=50 and RtB_BuffRemains()>=10
			end

if Player:BuffP(S.masterassassin) and Player:BuffP(S.VanishBuff) then


	
		if (Player:ComboPoints() == 2 and Player:Buff(S.EchoingReprimandCP2)) or (Player:ComboPoints() == 3 and Player:Buff(S.EchoingReprimandCP3)) or (Player:ComboPoints() == 4 and Player:Buff(S.EchoingReprimandCP4)) then
	    
			if S.Dispatch:IsReady(10) then
				return S.Dispatch:Cast()
			end
	
		end
	
 if Player:ComboPoints() >= CPMaxSpend() then
 
		if S.Dispatch:IsReady(10) then
			return S.Dispatch:Cast()
		end
	
	end
 

		if S.Ambush:IsCastable(10) then
			return S.Ambush:Cast()
		end
	
	
 
 end
 
 
local IsTanking = Player:IsTankingAoE(10) or Player:IsTanking(Target)

if Player:IsCasting() or Player:IsChanneling() or Player:BuffP(S.foodanddrink) then
	return 0, "Interface\\Addons\\Rubim-RH\\Media\\channel.tga"
end 






-- Out of Combat

if not Player:AffectingCombat() then
	
	if S.Steward:IsCastable() and I.phialofserenity:Count() <= 1 and Cache.EnemiesCount[20] == 0 then
        return S.Steward:Cast()
    end
	
    if S.Stealth:IsCastable() and not Player:Buff(S.Stealth) and not Player:Buff(S.VanishBuff) then
		return S.Stealth:Cast()
    end

	if S.InstantPoison:IsCastable() and not Player:Buff(S.WoundPoison) and Player:BuffRemainsP(S.InstantPoison) < 300 and not Player:IsCasting(S.InstantPoison) and not Player:IsMoving() then
    	return S.InstantPoison:Cast()
    end
	
		if S.CripplingPoison:IsCastable() and not Player:BuffP(S.NumbingPoison) and Player:BuffRemainsP(S.CripplingPoison) < 300 and not Player:IsCasting(S.CripplingPoison) and not Player:IsMoving() then
    	return S.CripplingPoison:Cast()
    end
	
	if S.NumbingPoison:IsCastable() and not Player:BuffP(S.CripplingPoison) and not Player:BuffP(S.CripplingPoison) and Player:BuffRemainsP(S.NumbingPoison) < 300 and not Player:IsCasting(S.NumbingPoison) and not Player:IsMoving() then
    	return S.NumbingPoison:Cast()
    end

    if Player:ComboPoints() >= 1 then
		if S.SliceandDice:IsCastable() and Player:BuffRemainsP(S.SliceandDice)<12 and Cache.EnemiesCount[30] >= 1 and (not Player:BuffP(S.VanishBuff) or not Player:BuffP(S.masterassassin) or Cache.EnemiesCount[10]==0 or not I.masterassassin:IsEquipped()) then
			return S.SliceandDice:Cast()
		end
	end
	-- actions+=/variable,name=rtb_reroll,value=rtb_buffs<2&(!buff.true_bearing.up&!buff.broadside.up)

		if (S.RolltheBones:IsCastable() and Cache.EnemiesCount[30] >= 1 and (not Player:BuffP(S.masterassassin) or Cache.EnemiesCount[15]==0 or not I.masterassassin:IsEquipped())) and 
	(((not Player:BuffP(S.TrueBearing) and not Player:BuffP(S.Broadside)) and RtB_Buffs() < 2) or RtB_BuffRemains()<3) then
        return S.RolltheBones:Cast()
    end
  
    if S.CrimsonVial:IsCastable() and Cache.EnemiesCount[12] == 0 and Player:HealthPercentage() <= 85 and Player:EnergyDeficit() == 0 then
		return S.CrimsonVial:Cast()
    end

	if not RubimRH.queuedSpell[1]:CooldownUp() or not Target:IsInRange(10) or not Player:AffectingCombat() then
		RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
	end
	
	return 0, "Interface\\Addons\\Rubim-RH\\Media\\mount2.tga"
end 


	if S.lustAT:ID() ==  RubimRH.queuedSpell[1]:ID() and not Player:Debuff(S.lust1) and not Player:Debuff(S.lust2) and not Player:Debuff(S.lust3) and not Player:Debuff(S.lust4) and not Player:Debuff(S.lust5) and (I.drums:IsReady()) then
    	return S.lustAT:Cast() -- BIND LUST KEYBIND IN BINDPAD TO ARCANE TORRENT
	end
	
	if S.lustAT:ID() ==  RubimRH.queuedSpell[1]:ID() and (Player:Debuff(S.lust1) or Player:Debuff(S.lust2) or Player:Debuff(S.lust3) or Player:Debuff(S.lust4) or Player:Debuff(S.lust5)) then
		RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
	end
	
-- Shiv




	
	--PVP----------------------------------------------------------------------------------------------------------------
if (not Player:Buff(S.Stealth) and (not Player:Buff(S.VanishBuff) or Player:Buff(S.VanishBuff) and I.masterassassin:IsEquipped()) and not Target:Debuff(S.Blind)) and Player:AffectingCombat() and (Target:IsAPlayer() or Player:InArena() or Player:InBattlegrounds()) then
	
	    if S.plunderarmor:IsCastable() and Target:IsInRange(10) and (not Player:Buff(S.Stealth) and not Player:Buff(S.VanishBuff) and not Target:Debuff(S.Blind)) then
		return S.plunderarmor:Cast()
    end
	    if S.dismasterassassin:IsCastable() and Target:IsInRange(10) and not Target:Debuff(S.dismasterassassin) and not Target:Debuff(S.KidneyShot) and not Target:Debuff(S.CheapShot) and (not Player:Buff(S.Stealth) and not Player:Buff(S.VanishBuff) and not Target:Debuff(S.Blind)) then
		return S.dismasterassassin:Cast()
    end

   if S.CrimsonVial:IsCastable() and Player:HealthPercentage() <= 60 then
		return S.crimsonvial:Cast()
    end

    if S.smokebomb:IsCastable() and Player:HealthPercentage() <= 90 and Cache.EnemiesCount[20]>=1 and (not Player:Buff(S.Stealth) and not Player:Buff(S.VanishBuff) and not Target:Debuff(S.Blind)) then
		return S.smokebomb:Cast()
    end
	    if S.Evasion:IsReady() and Player:HealthPercentage() <= 70 and Cache.EnemiesCount[10] >= 1 then
    	return S.Evasion:Cast()
    end

		    if S.CloakofShadows:IsReady() and Player:HealthPercentage() <= 50 and Cache.EnemiesCount[10] >= 1 then
    	return S.CloakofShadows:Cast()
    end

    if S.KidneyShot:IsCastable() and not Target:Buff(S.Evasion) and not Target:Debuff(S.CheapShot) and not Target:Debuff(S.KidneyShot) and Player:ComboPoints()>=4 and Target:IsInRange(10) then
		return S.KidneyShot:Cast()
    end
	
	end
	--PVP----------------------------------------------------------------------------------------------------------------







    if S.MarkedforDeath:IsReady(15) and (Player:AffectingCombat() or Target:AffectingCombat()) and Player:ComboPoints() <= 1 then
        return S.MarkedforDeathz:Cast()
    end

-- Explosive

	if S.PistolShot:IsReady() and UnitName('target') == 'Explosives' then
		return S.PistolShot:Cast()
	end

-- Spell Queue


	if I.trink:IsReady() and I.trink:IsEquipped() and not Player:Buff(S.Stealth) and not Player:Buff(S.VanishBuff) and Target:IsInRange(8) and RubimRH.CDsON() and (I.masterassassin:IsEquipped() and Player:BuffP(S.masterassassin) or Target:Debuff(S.BetweentheEyes) and not I.masterassassin:IsEquipped()) then
		return S.trink:Cast()
    end




	if  S.Gouge:ID() ==  RubimRH.queuedSpell[1]:ID() and Target:Debuff(S.CheapShot) then
    		RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
	end
		
	if  S.KidneyShot:ID() ==  RubimRH.queuedSpell[1]:ID() and Target:Debuff(S.CheapShot) then
    		RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
	end
	

	if RubimRH.QueuedSpell():IsReadyQueue() then
        return RubimRH.QueuedSpell():Cast()
    end
	
	if not RubimRH.queuedSpell[1]:CooldownUp() or not Target:IsInRange(10) or not Player:AffectingCombat() then
		RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
	end
	

	if S.Gouge:ID() == RubimRH.QueuedSpell():ID() and (Target:Debuff(S.CheapShot) or not Target:IsInRange(10) or not Player:AffectingCombat() or Player:Buff(S.Stealth) or Target:Debuff(S.BetweentheEyes) or Player:Buff(S.VanishBuff) or Target:Debuff(S.Blind)) then 
    	RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
	end


-- RTB



-- Cooldowns

if (not Target:IsAPlayer() and not Player:InArena() and not Player:InBattlegrounds()) then
	-- vanish,if=!stealthed.all&variable.ambush_condition&master_assassin_remains=0&(!runeforge.deathly_shadows|buff.deathly_shadows.down&combo_points<=2)
if S.Vanish:IsReady()  and not Player:BuffP(S.Stealth) and Player:BuffRemainsP(S.masterassassin)==0 and I.masterassassin:IsEquipped() and ambushcondition and Target:IsInRange(10) and RubimRH.CDsON() and Target:TimeToDie()>6 then
		return S.Vanish:Cast()
	end
if S.Vanish:IsReady()  and not Player:BuffP(S.Stealth) and Player:BuffRemainsP(S.masterassassin)==0 and I.masterassassin:IsEquipped() and Target:IsInRange(10) and RubimRH.CDsON() and Target:TimeToDie()>6 and Player:GCDRemains()<0.2 and (Cache.EnemiesCount[12]>=3 and RubimRH.AoEON()) then
		return S.Vanish:Cast()
	end
end
		
	if S.AdrenalineRush:IsReady() and not Player:BuffP(S.Stealth) and not Player:BuffP(S.AdrenalineRush) and Target:IsInRange(8) and RubimRH.CDsON() and Player:AffectingCombat() and (not S.KillingSpree:CooldownUp() or not S.KillingSpree:IsAvailable()) then
        return S.AdrenalineRush:Cast()
    end
	
		if (S.RolltheBones:IsReady() and Cache.EnemiesCount[30] >= 1 and (not Player:BuffP(S.masterassassin) or Cache.EnemiesCount[15]==0 or not I.masterassassin:IsEquipped())) and 
	(((not Player:BuffP(S.TrueBearing) and not Player:BuffP(S.Broadside)) and RtB_Buffs() < 2) or RtB_BuffRemains()==0) then
        return S.RolltheBones:Cast()
    end
	
	
    if S.BladeRush:IsReady() and Player:AffectingCombat() and not Target:Debuff(S.Blind) and not Player:BuffP(S.Stealth) and Target:IsInRange(5) and (Cache.EnemiesCount[12] == 1 and EnergyTimeToMaxRounded()>2 or (Cache.EnemiesCount[12] > 1 and Player:BuffP(S.BladeFlurry)) or S.BladeFlurry:CooldownRemainsP() >= 10) then
    	return S.BladeRush:Cast()
    end


	-- if I.trink:IsReady() and Target:IsInRange(12) and I.trink2:IsEquipped() and (Player:BuffP(S.AdrenalineRush) or S.AdrenalineRush:CooldownRemainsP() > 20) then
        -- return S.trinkz:Cast()
    -- end 
	
	-- if S.Kick:IsReady(12) and Target:IsInterruptible() and RubimRH.InterruptsON() and Player:GCDRemains() < 0.25 then
		-- return S.Kick:Cast()
    -- end
	
	-- if S.CloakofShadows:IsReady() and Player:HealthPercentage() < 25 then
		-- return S.CloakofShadows:Cast()
	-- end

	
-- Rotation

    if S.Evasion:IsReady() and Player:HealthPercentage() <= 60 and Cache.EnemiesCount[12] >= 1 and Player:IsTanking(Target) then
    	return S.Evasion:Cast()
    end

	
	if S.BladeFlurry:IsCastable() and not Player:BuffP(S.BladeFlurry) and not Target:Debuff(S.Blind) and not Player:Buff(S.Stealth) and Cache.EnemiesCount[12] >= 2 and RubimRH.AoEON() then
		return S.BladeFlurry:Cast()
    end

	if I.healingpot:IsReady() and Player:HealthPercentage() <= 25 and (not Player:InArena() and not Player:InBattlegrounds()) then
		return S.healingpot:Cast()
    end

-- Echoing Rep
if (Player:ComboPoints() == 2 and Player:Buff(S.EchoingReprimandCP2)) or (Player:ComboPoints() == 3 and Player:Buff(S.EchoingReprimandCP3)) or (Player:ComboPoints() == 4 and Player:Buff(S.EchoingReprimandCP4)) then
	    
	if S.BetweentheEyes:IsReady(20) and not Target:Debuff(S.Blind) and not Player:Buff(S.Stealth) and not Player:Buff(S.VanishBuff) and Player:AffectingCombat() then
        return S.BetweentheEyes:Cast()
    end

    if S.Dispatch:IsReady(10) and not Target:Debuff(S.Blind) and not Player:Buff(S.Stealth) and not Player:Buff(S.VanishBuff) and Player:AffectingCombat() then
        return S.Dispatch:Cast()
    end
end


-- Spenders	
-- run_action_list,name=finish,if=combo_points>=cp_max_spend-buff.broadside.up-(buff.opportunity.up*talent.quick_draw.enabled)|combo_points=animacharged_cp

    if Player:ComboPoints() >= CPMaxSpend() - (num(Player:BuffP(S.Broadside)) + num(Player:BuffP(S.Opportunity)) * num(S.QuickDraw:IsAvailable()))  then

    -- if S.BetweentheEyes:IsReady(20) and (not Target:Debuff(S.Blind) and not Player:Buff(S.Stealth) and not Player:Buff(S.VanishBuff) and Player:AffectingCombat()
	-- and (Target:TimeToDie() >= 6 or (Cache.EnemiesCount[12] == 1 and Target:TimeToDie() >= 3) or UnitClassification("target") == "worldboss" or UnitClassification("target") == "boss")) then
        -- return S.BetweentheEyes:Cast()
    -- end

-- slice_and_dice,if=buff.slice_and_dice.remains<fight_remains&refreshable
    if S.SliceandDice:IsCastable() and Player:BuffRemains(S.SliceandDice) < 9 and (Target:TimeToDie() >= 7.5 or Cache.EnemiesCount[12]>1) and not Player:Buff(S.masterassassin) then
        return S.SliceandDice:Cast()
    end
 

    if S.BetweentheEyes:IsReady(20) and not Target:Debuff(S.Blind) and not Player:Buff(S.Stealth) and not Player:Buff(S.VanishBuff) and Player:AffectingCombat() then
        return S.BetweentheEyes:Cast()
    end


    if S.Dispatch:IsReady(10) and not Target:Debuff(S.Blind) and not Player:Buff(S.Stealth) and not Player:Buff(S.VanishBuff) and Player:AffectingCombat() then
        return S.Dispatch:Cast()
    end

end
	
-- Builders	

if not Player:Buff(S.Stealth) and Player:AffectingCombat() and not Target:Debuff(S.Blind) and not Player:Buff(S.VanishBuff) and Player:ComboPoints() < CPMaxSpend() - (num(Player:BuffP(S.Broadside)) + (num(Player:BuffP(S.Opportunity)) * num(S.QuickDraw:IsAvailable()))) then


    if S.EchoingReprimand:IsReady(10) then
        return S.EchoingReprimand:Cast()
    end
-- actions.build+=/pistol_shot,if=buff.opportunity.up&(energy<45|talent.quick_draw.enabled)

    if S.PistolShot:IsReady(20) and Player:BuffP(S.Opportunity) and (Player:Energy()<45 or S.QuickDraw:IsAvailable()) then
        return S.PistolShot:Cast()
    end


    if S.SinisterStrike:IsReady(10) then
        return S.SinisterStrike:Cast()
    end

end

-- Out of Range Pistol Shot

    if not Target:IsInRange(10) and not Target:Debuff(S.Blind) and S.PistolShot:IsReady(20) and not Player:Buff(S.Stealth) and Player:AffectingCombat()
    and Player:EnergyDeficitPredicted() < 25 and (Player:ComboPointsDeficit() >= 1 or EnergyTimeToMaxRounded() <= 1.2) then
        return S.PistolShot:Cast()
    end



    return 0, 135328
end




RubimRH.Rotation.SetAPL(260, APL);

local function PASSIVE()
    
end

RubimRH.Rotation.SetPASSIVE(260, PASSIVE);