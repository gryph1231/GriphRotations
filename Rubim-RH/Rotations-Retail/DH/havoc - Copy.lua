--- ======= LOCALIZE =======
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
-- Lua
local pairs = pairs;
local select = select;

--Havoc
RubimRH.Spell[577] = {
    -- Racials
    ArcaneTorrent = Spell(202719),
    -- Abilities
    Annihilation = Spell(201427),
    BladeDance = Spell(188499),
    ConsumeMagic = Spell(278326),
    ChaosStrike = Spell(162794),
    ChaosNova = Spell(179057),
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

    RevolvingBlades = Spell(279581),
    UnboundChaos = Spell(275144),
    ChaoticTransformation = Spell(288754),
	-- Essences
	UnleashHeartOfAzeroth = Spell(280431),
    BloodOfTheEnemy = Spell(297108),
	CondensedLifeForce = Spell(295840),
	FocusedAzeriteBeam = Spell(295258),
	-- Fixture
}

-- Items
if not Item.DemonHunter then 
	Item.DemonHunter = {}; 
end
Item.DemonHunter.Havoc = {


};

local I = Item.DemonHunter.Havoc;
local S = RubimRH.Spell[577]

-- Rotation Var
local EnemyRanges = {20, 12, 10, 8, 6}
local function UpdateRanges()
  for _, i in ipairs(EnemyRanges) do
    HL.GetEnemies(i);
  end
end

-- Main APL
local function APL()
local Precombat, Precombat_DBM, Cooldown, DarkSlash, Demonic, Normal
UpdateRanges()

if Player:IsChanneling(S.EyeBeam) or Player:IsChanneling(S.FelBarrage) or Player:IsChanneling(S.FocusedAzeriteBeam) then
	return 0, "Interface\\Addons\\Rubim-RH\\Media\\channel.tga"
end 
	
-- Queue
	if RubimRH.queuedSpell[1]:IsReady() and (S.BloodOfTheEnemy:ID() ==  RubimRH.queuedSpell[1]:ID() or S.CondensedLifeForce:ID() == RubimRH.queuedSpell[1]:ID() or S.FocusedAzeriteBeam:ID() == RubimRH.queuedSpell[1]:ID()) then
    	return S.UnleashHeartOfAzeroth:Cast()
	end

	if QueueSkill() ~= nil then
		return QueueSkill()
	end
	
	if not RubimRH.queuedSpell[1]:IsCastable() or not Player:AffectingCombat() then
		RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
	end

-- Out of Combat
	if not Player:AffectingCombat() then
	
	end

-- Cooldowns
if RubimRH.CDsON() and (Player:AffectingCombat() or Target:IsDummy()) 
then
	
	if S.BloodOfTheEnemy:IsReady() and (Cache.EnemiesCount[10] >= 3 or
	(UnitExists("boss1") == true or UnitClassification("target") == "worldboss" or UnitClassification("target") == "rareelite" or UnitClassification("target") == "rare")) then
		return S.UnleashHeartOfAzeroth:Cast()
	end 
	
	if S.EyeBeam:IsReady() and Cache.EnemiesCount[6] >= 1 then
		return S.EyeBeam:Cast()
	end
	
end

-- Rotation
if Player:AffectingCombat() or Target:IsDummy() then 


	if S.DeathSweep:IsReadyMorph() and Cache.EnemiesCount[6] >= 1 then
		return S.DeathSweep:Cast()
	end
	
	if S.BladeDance:IsReady() and Cache.EnemiesCount[6] >= 1 then
		return S.BladeDance:Cast()
	end

	if S.ImmolationAura:IsReady() and Target:IsInRange(12) then
		return S.ImmolationAura:Cast()
	end
	
	if S.Annihilation:IsReadyMorph() and Target:IsInRange(6) and Player:Fury() >= 55 then
		return S.Annihilation:Cast()
	end
	
	if S.ChaosStrike:IsReady() and Target:IsInRange(6) and Player:Fury() >= 55 then
		return S.ChaosStrike:Cast()
	end
	
	if S.DemonsBite:IsReady() and Target:IsInRange(6) then
		return S.DemonsBite:Cast()
	end
	
	-- if S.ThrowGlaive:IsReady() and Target:MaxDistanceToPlayer(true) > 10 then
		-- return S.ThrowGlaive:Cast()
	-- end
	
end
	return 0, 135328
end

RubimRH.Rotation.SetAPL(577, APL)

local function PASSIVE()
    return RubimRH.Shared()
end

RubimRH.Rotation.SetPASSIVE(577, PASSIVE)
