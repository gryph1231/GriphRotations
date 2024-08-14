--- ============================ HEADER ============================
--- ======= LOCALIZE =======
-- Addon
local addonName, addonTable = ...
-- HeroLib
local HL = HeroLib
local Cache = HeroCache
local Unit = HL.Unit
local Player = Unit.Player
local Target = Unit.Target
local Pet = Unit.Pet
local Spell = HL.Spell
local Item = HL.Item

RubimRH.Spell[259] = {
    ArcanePulse = Spell(260364),
    ArcaneTorrent = Spell(25046),
    Berserking = Spell(26297),
    BloodFury = Spell(20572),
    AncestralCall  = Spell(274738),   
    Fireblood = Spell(265221),
    Shadowmeld = Spell(58984),
    Envenom = Spell(32645),
    FanofKnives = Spell(51723),
    Garrote = Spell(703),
    KidneyShot = Spell(408),
    Mutilate = Spell(1329),
    PoisonedKnife = Spell(185565),
    Rupture = Spell(1943),
    Stealth = Spell(1784),
    Stealth2 = Spell(115191), -- w/ Subterfuge Talent
    Vanish = Spell(1856),
    VanishBuff = Spell(11327),
    Vendetta = Spell(79140),
    Blindside = Spell(111240),
    BlindsideBuff = Spell(121153),
    CrimsonTempest = Spell(121411),
    DeeperStratagem = Spell(193531),
    Exsanguinate = Spell(200806),
    HiddenBladesBuff = Spell(270070),
    InternalBleeding = Spell(154953),
    MarkedforDeath = Spell(137619),
    MasterAssassin = Spell(255989),
    Nightstalker = Spell(14062),
    Subterfuge = Spell(108208),
    ToxicBlade = Spell(245388),
    ToxicBladeDebuff = Spell(245389),
    SharpenedBladesPower = Spell(272911),
    SharpenedBladesBuff = Spell(272916),
    ShroudedSuffocation = Spell(278666),
    CripplingPoison = Spell(3408),
    DeadlyPoison = Spell(2823),
    DeadlyPoisonDebuff = Spell(2818),
    LeechingPoison = Spell(108211),
    WoundPoison = Spell(8679),
    WoundPoisonDebuff = Spell(8680),
    CrimsonVial = Spell(185311),
    Evasion = Spell(5277),
    CloakofShadows = Spell(31224),
    TheDreadlordsDeceit = Spell(208693),
    Kick = Spell(1766),
	ShadowStep = Spell (36554),
	Sap = Spell(6770),
	Shiv = Spell(248744),
	SmokeBomb = Spell (212182),
	DFA = Spell (269513),
	Neuro = Spell (206328),
    CheapShot = Spell(1833),	
};
local S = RubimRH.Spell[259];

if not Item.Rogue then
    Item.Rogue = {}
end

Item.Rogue.Assassination = {

};

local I = Item.Rogue.Assassination;

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

RubimRH.Rotation.SetAPL(259, APL)