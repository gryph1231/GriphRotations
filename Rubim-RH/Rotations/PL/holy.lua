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

if not Spell.Paladin then
    Spell.Paladin = {};
end

RubimRH.Spell[65] = {




    autoattack = Spell(291944), -- regeneratin
    wristsx = Spell(255647), -- lights judgmenet
    tempestofthelightbringer = Spell(383396),

    BastionofLight = Spell(378974),
   
    DivineSteedBuff          = Spell(221883),
    BlessingofProtection     = Spell(1022),
    Forbearance              = Spell(25771),
    -- Racials
    AncestralCall            = Spell(274738),
    ArcanePulse              = Spell(260364),
    ArcaneTorrent            = Spell(155145),
    BagofTricks              = Spell(312411),
    Berserking               = Spell(26297),
    BloodFury                = Spell(20572),
    -- Fireblood                             = Spell(265221),
    GiftoftheNaaru           = Spell(59542),
    -- LightsJudgment                        = Spell(255647),
    -- Abilities
    Consecration             = Spell(26573),
    CrusaderStrike           = Spell(35395),
    DivineShield             = Spell(642),
    DivineSteed              = Spell(190784),
    FlashofLight             = Spell(19750),
    HammerofJustice          = Spell(853),
    HandofReckoning          = Spell(62124),
    Judgment                 = Spell(20271),
    Rebuke                   = Spell(96231),
    ShieldoftheRighteous     = Spell(53600),
    WordofGlory              = Spell(85673),
    -- Talents
    AvengingWrath            = Spell(31884),
    HammerofWrath            = Spell(24275),
    HolyAvenger              = Spell(105809),
    HolyAvengerBuff          = Spell(105809),
    LayonHands               = Spell(633),
    SanctifiedWrath          = Spell(53376),
    Seraphim                 = Spell(152262),
    SeraphimBuff             = Spell(152262),
    -- Covenants (Shadowlands)
    AshenHallow              = Spell(316958),
    BlessingofAutumn         = Spell(328622),
    BlessingofSpring         = Spell(328282),
    BlessingofSummer         = Spell(328620),
    BlessingofWinter         = Spell(328281),
    DivinePurpose            = Spell(223817),
    -- DivineTollCov                         = Spell(304971),
    DoorofShadows            = Spell(300728),
    Fleshcraft               = Spell(324631),
    Soulshape                = Spell(310143),
    SummonSteward            = Spell(324739),
    VanquishersHammer        = Spell(328204),
    VanquishersHammerBuff    = Spell(328204),
    -- Soulbinds/Conduits (Shadowlands)
    Expurgation              = Spell(339371),
    PustuleEruption          = Spell(351094),
    VengefulShock            = Spell(340006),
    VengefulShockDebuff      = Spell(340007),
    VolatileSolvent          = Spell(323074),
    VolatileSolventHumanBuff = Spell(323491),
    -- Auras
    ConcentrationAura        = Spell(317920),
    CrusaderAura             = Spell(32223),
    DevotionAura             = Spell(465),
    RetributionAura          = Spell(183435),
    -- Buffs
    Intercession             = Spell(391054),
    Intercessionz            = Spell(215661),
    trinket                  = Spell(59547), -- gift of narru

    AvengingWrathBuff           = Spell(31884),
    ConsecrationBuff            = Spell(188370),
    DivinePurposeBuff           = Spell(223819),
    ScarsofFraternalStrifeBuff4 = Spell(368638),
    ShieldoftheRighteousBuff    = Spell(132403),
    TemptationBuff              = Spell(234143),
    -- Debuffs
    ConsecrationDebuff          = Spell(204242),
    CruelGarroteDebuff          = Spell(230011),
    -- Legendary Effects
    DivineResonanceBuff         = Spell(355455),
    FinalVerdictBuff            = Spell(337228),
    JudgmentDebuff              = Spell(197277),
    -- Pool

    -- Pool                                  = Spell(999910),
    Pool = Spell(397799),


    lust1 = Spell(57724),
    lust2 = Spell(57723),
    lust3 = Spell(80354),
    lust4 = Spell(95809),
    lust5 = Spell(264689),
    lustAT = Spell(265221), -- fireblood
    DivineProtection                      = Spell(498),
    HolyShock                             = Spell(20473),
    Judgment                              = Spell(275773),
    JudgmentDebuff                        = Spell(197277),
    LightofDawn                           = Spell(85222),
    InfusionofLightBuff                   = Spell(54149),
    -- Talents
    AvengingCrusader                      = Spell(216331),
    Awakening                             = Spell(248033),
    BestowFaith                           = Spell(223306),
    CrusadersMight                        = Spell(196926),
    GlimmerofLight                        = Spell(325966),
    GlimmerofLightDebuff                  = Spell(325966),
    HolyPrism                             = Spell(114165),
    LightsHammer                          = Spell(114158),





}

local S = RubimRH.Spell[65]
local G = RubimRH.Spell[1] -- General Skills

S.AvengingWrath.TextureSpellID = { 55748 }
S.Crusade.TextureSpellID = { 55748 }



-- Items
if not Item.Paladin then Item.Paladin = {} end

Item.Paladin.Holy = {

    HPIcon = Item(169451),
    tx1 = Item(118330),
    tx2 = Item(114616),


};
local I = Item.Paladin.Holy;




local function num(val)
    if val then
        return 1
    else
        return 0
    end
end

local function bool(val)
    return val ~= 0
end






local function UseItems()

    local trinket1 = GetInventoryItemID("player", 13)
    local trinket2 = GetInventoryItemID("player", 14)
    local trinket1ready = IsUsableItem(trinket1) and GetItemCooldown(trinket1) == 0 and IsEquippedItem(trinket1)
    local trinket2ready = IsUsableItem(trinket2) and GetItemCooldown(trinket2) == 0 and IsEquippedItem(trinket2)

    if trinket1ready then
        return I.tx1:Cast()
    end
    if trinket2ready then
        return I.tx2:Cast()
    end
end

function HealthPotionSelected()

    local HealthPotionIDs = {
        191380, 191379, 191378

    }

    for _, HealthPotionID in ipairs(HealthPotionIDs) do
        if Item(HealthPotionID):IsUsable() then
            return Item(HealthPotionID)
        end
    end
end

local function APL()

    HL.GetEnemies(5);
    HL.GetEnemies("Melee");
    HL.GetEnemies(8);
    HL.GetEnemies(10);
    HL.GetEnemies(12);
    HL.GetEnemies(15);
    HL.GetEnemies(20);
    HL.GetEnemies(25);
    HL.GetEnemies(30);
    HL.GetEnemies(35);
    HL.GetEnemies(40);
    Enemies5y = Cache.EnemiesCount[5]
    Enemies8y = Cache.EnemiesCount[8]
    Enemies10y = Cache.EnemiesCount[10]
    Enemies12y = Cache.EnemiesCount[12]
    Enemies15y = Cache.EnemiesCount[15]
    Enemies20y = Cache.EnemiesCount[20]
    Enemies25y = Cache.EnemiesCount[25]
    Enemies30y = Cache.EnemiesCount[30]
    Enemies35y = Cache.EnemiesCount[35]
    Enemies40y = Cache.EnemiesCount[40]


    -- Spell Queue
    if Player:IsChanneling() or Player:IsCasting() then
        return 0, "Interface\\Addons\\Rubim-RH\\Media\\channel.tga"
    end


    if S.LayonHands:IsReady() and Player:HealthPercentage() <= 20 and not Player:Debuff(S.Forbearance) and
        S.DivineShield:CooldownRemains() > Player:GCD() then
        return S.LayonHands:Cast()
    end

    IsTanking = Player:IsTankingAoE(8) or Player:IsTanking(Target)

    if Player:HealthPercentage() <= 25 and Player:AffectingCombat() and IsUsableItem(191380) and
        GetItemCooldown(191380) == 0 and GetItemCount(191380) >= 1
        and (not Player:InArena() and not Player:InBattlegrounds()) then
        return I.HPIcon:Cast()
    end



    if RubimRH.CDsON() and Target:IsInRange(8) then
        local ShouldReturn = UseItems();
        if ShouldReturn then return ShouldReturn; end
    end


 













    if S.FlashofLight:IsCastable() and (Player:InArena() or Player:InBattlegrounds()) and Player:HealthPercentage() < 50
        and Player:BuffStackP(S.SelfLessHealerBuff) == 4 then
        return S.FlashofLight:Cast()
    end

    if S.lustAT:ID() == RubimRH.queuedSpell[1]:ID() and not Player:Debuff(S.lust1) and not Player:Debuff(S.lust2) and
        not Player:Debuff(S.lust3) and not Player:Debuff(S.lust4) and not Player:Debuff(S.lust5) and (I.drums:IsReady()) then
        return S.lustAT:Cast() -- BIND LUST KEYBIND IN BINDPAD TO ARCANE TORRENT
    end

    if S.lustAT:ID() == RubimRH.queuedSpell[1]:ID() and
        (
        Player:Debuff(S.lust1) or Player:Debuff(S.lust2) or Player:Debuff(S.lust3) or Player:Debuff(S.lust4) or
            Player:Debuff(S.lust5)) then
        RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
    end




    if S.DivineShield:ID() == RubimRH.queuedSpell[1]:ID() and Player:DebuffP(S.Forbearance) then
        RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
    end
    if S.BlessingofProtection:ID() == RubimRH.queuedSpell[1]:ID() and Player:DebuffP(S.Forbearance) then
        RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
    end
    if S.LayonHands:ID() == RubimRH.queuedSpell[1]:ID() and Player:DebuffP(S.Forbearance) or
        S.LayonHands:ID() == RubimRH.queuedSpell[1]:ID() and Player:InArena() then
        RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
    end

    if S.DivineSteed:ID() == RubimRH.queuedSpell[1]:ID() and Player:BuffP(S.DivineSteedBuff) then
        RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
    end

    if RubimRH.QueuedSpell():IsReadyQueue() then
        return RubimRH.QueuedSpell():Cast()
    end

    if not RubimRH.queuedSpell[1]:CooldownUp() or Cache.EnemiesCount[20] == 0 or not Player:AffectingCombat() then
        RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
    end




    if S.DivineShield:IsReady() and Player:HealthPercentage() <= 50 and not Player:Debuff(S.Forbearance) and Player:InArena() then
        return S.DivineShield:Cast()
    end

    if S.DivineShield:IsReady() and Player:HealthPercentage() <= 40 and not Player:Debuff(S.Forbearance) then
        return S.DivineShield:Cast()
    end

    if S.LayonHands:IsReady() and Player:HealthPercentage() <= 20 and not Player:Debuff(S.Forbearance) and
        not Player:InArena() and S.DivineShield:CooldownRemains() > Player:GCD() then
        return S.LayonHands:Cast()
    end





        if select(8, UnitCastingInfo("target")) == false and Target:CastPercentage() > math.random(43, 87) and
            RubimRH.InterruptsON() and S.Rebuke:IsReady(8) and Player:AffectingCombat() then
            return S.Rebuke:Cast()
        end





    -- Out of Combat
    if not Player:AffectingCombat() then


        if RubimRH.QueuedSpell():IsReadyQueue() then
            return RubimRH.QueuedSpell():Cast()
        end

        if not RubimRH.queuedSpell[1]:CooldownUp() or Cache.EnemiesCount[20] == 0 or not Player:AffectingCombat() then
            RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
        end

        return 0, "Interface\\Addons\\Rubim-RH\\Media\\prot.tga"

    end

    return 0, 135328
end

RubimRH.Rotation.SetAPL(65, APL);

local function PASSIVE()

end

RubimRH.Rotation.SetPASSIVE(65, PASSIVE);
