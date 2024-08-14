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

if not Spell.DeathKnight then
    Spell.DeathKnight = {};
end

RubimRH.Spell[251] = {
	RaiseAlly = Spell(61999),
    ArcaneTorrent = Spell(50613),
    Berserking = Spell(26297),
    BloodFury = Spell(20572),
    GiftoftheNaaru = Spell(59547),
    ControlUndead = Spell(45524),
    DeathGrip = Spell(49576),
    MindFreeze = Spell(47528),
    PathOfFrost = Spell(3714),
    WraithWalk = Spell(212552),
    ChillStreak = Spell(204160),
    AntiMagicShell = Spell(48707),
    DeathStrike = Spell(49998),
    IceboundFortitude = Spell(48792),
    DarkSuccor = Spell(101568),
    DeathGrip = Spell(49576),
    DeathsAdvance = Spell(48265),
    DeathPact = Spell(48743),
    BreathofSindragosaBuff = Spell(152279),
    RemorselessWinter = Spell(196770),
	RemorselessWinterz = Spell(179057),
    GatheringStorm = Spell(194912),
    GlacialAdvance = Spell(194913),
    Frostscythe = Spell(207230),
    FrostStrike = Spell(49143),
	FrostStrikez = Spell(162243),
	Frostscythez = Spell(211881),
    HowlingBlast = Spell(49184),
	HowlingBlastz = Spell(162794),
    RimeBuff = Spell(59052),
    KillingMachineBuff = Spell(51124),
    RunicAttenuation = Spell(207104),
    Obliterate = Spell(49020),
	Obliteratez = Spell(198013),
    HornofWinter = Spell(57330),
    ArcaneTorrent = Spell(50613),
    PillarofFrost = Spell(51271),
    ChainsofIce = Spell(45524),
	ChainsofIcez = Spell(188499),
    ColdHeartBuff = Spell(281209),
    PillarofFrostBuff = Spell(51271),
    FrostwyrmsFury = Spell(279302),
    EmpowerRuneWeaponBuff = Spell(47568),
    BloodFury = Spell(20572),
    Berserking = Spell(26297),
    EmpowerRuneWeapon = Spell(47568),
    BreathofSindragosa = Spell(152279),
    ColdHeart = Spell(281208),
    RazoriceDebuff = Spell(51714),
    FrozenPulseBuff = Spell(194909),
    FrozenPulse = Spell(194909),
    FrostFeverDebuff = Spell(55095),
    IcyTalonsBuff = Spell(194879),
    Obliteration = Spell(281238),
    DeathStrike = Spell(49998),
    DeathStrikeBuff = Spell(101568),
    FrozenTempest = Spell(278487),
    UnholyStrengthBuff = Spell(53365),
	Lichborne = Spell(49039),
    Transfusion = Spell(288977),
	IcyCitadel = Spell(272718),
    IcyCitadelBuff = Spell(272719),
}

local S = RubimRH.Spell[251] 

if not Item.DeathKnight then Item.DeathKnight = {}; end

Item.DeathKnight.Frost = {


};

local I = Item.DeathKnight.Frost;


local function num(val)
    if val then
        return 1
    else
        return 0
    end
end

local function APL()

 













	return 0, "Interface\\Addons\\Rubim-RH\\Media\\mount2.tga"
end

RubimRH.Rotation.SetAPL(251, APL);

local function PASSIVE()
    
end

RubimRH.Rotation.SetPASSIVE(251, PASSIVE);