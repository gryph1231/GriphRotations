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
KeepItRolling = Spell(381989),


AudacityBuff = Spell(381845),
    ThistleTea             = Spell(381623),
    HiddenOpportunity      = Spell(383281),
    autoattack             = Spell(20572), -- blood fury
    Polymorph              = Spell(118),
    Repentance             = Spell(20066),
    HexPvP                 = Spell(51514),
    WyvernSting            = Spell(19386),
    Fear                   = Spell(5782),
    Dreadblades            = Spell(343142),
    Cyclone                = Spell(33786),
    MindControl            = Spell(605),
    RevivePet              = Spell(982),
    MassDispel             = Spell(32375),
    GreatestPyroblast      = Spell(203286),
    ChaosBolt              = Spell(116858),
    Rebirth                = Spell(20484),
    SniperShot             = Spell(203155),
    Temptation             = Spell(234143),
    Temptationz            = Spell(260364), -- arcane pulse
    Penance                = Spell(47540),
    ColdBlood              = Spell(382245),
    ColdBloodz             = Spell(107079), -- quaking palm
    PrayerofHealing        = Spell(596),
    HealPvP                = Spell(2060),
    FlashHeal              = Spell(2061),
    BindingHeal            = Spell(32546),
    PrayerofMending        = Spell(33076),
    DivineHymn             = Spell(64843),
    Halo                   = Spell(120517),
    ShadowMend             = Spell(186263),
    PowerWordRadiance      = Spell(194509),
    HolyWordSalvation      = Spell(265202),
    GreaterHeal            = Spell(289666),
    Tranquility            = Spell(740),
    ImprovedAdrenalineRush = Spell(395422),
    CountTheOdds           = Spell(381982),
    CountTheOddsConduit    = Spell(341546),
    Regrowth               = Spell(8936),
    WildGrowth             = Spell(48438),
    SwiftSlasher           = Spell(381988),
    Nourish                = Spell(289022),
    ChainHeal              = Spell(1064),
    HealingSurge           = Spell(8004),
    ShadowDance            = Spell(185313),
    HealingRain            = Spell(73920),
    Wellspring             = Spell(197995),
    Downpour               = Spell(207778),
    FlashofLight           = Spell(19750),
    HolyLight              = Spell(82326),
    Vivify                 = Spell(116670),
    EnvelopingMist         = Spell(124682),
    EssenceFont            = Spell(191837),
    SoothingMist           = Spell(209525),
    SurgingMist            = Spell(227344),

    --Dungeons
    --Enrage
    UndyingRage = Spell(333227),
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
    Flagellation = Spell(323654),
    BindingFungus = Spell(329917),
    CreepyCrawlers = Spell(329239),
    CorrosiveGunk = Spell(319070),
    FanTheHammer = Spell(381846),
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
    Discharge = Spell(332196),
    Steward = Spell(324739),
    EchoingReprimand = Spell(323547), --385616
    EchoingReprimandCP2 = Spell(323558),
    EchoingReprimandCP3 = Spell(323559),
    EchoingReprimandCP4 = Spell(323560),
    EchoingReprimandCP5 = Spell(354838),
    trink2z = Spell(260364), --arcane pulse
    BladeRush = Spell(271877),
    stopcasting = Spell(291944), --regeneration
    CripplingPoison = Spell(3408),
    InstantPoison = Spell(315584),
    NumbingPoison = Spell(5761),
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
    DeviousStratagem = Spell(394321),
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
    QuickDraw = Spell(196938),
    Tricks = Spell(57934),
    GreenSkinsWickers = Spell(386823), --386823 --394131
    GreenSkinsWickersBuff = Spell(394131),
    ToTT = Spell(58984),
    SliceandDice = Spell(315496),
    Vigor = Spell(14983),
    Exhaustion = Spell(57723),
    Blind = Spell(2094),
    Blunderbuss = Spell(202895),
    CurseoftheDreadblades = Spell(202665),
    HiddenBlade = Spell(202754),
    LoadedDice = Spell(256170),
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
    healingpot = Spell(169451),
    crimsonvial = Spell(312411), --bag of tricks
    PistolShotz = Spell(287712),
    foodanddrink = Spell(308433),
    smokebomb = Spell(212182),
    trink = Spell(274738),
    trink2 = Spell(260364),
    plunderarmor = Spell(198529),
    FlayedToxin = Spell(345545),
    dismantle = Spell(207777),
    mantle = Spell(340094),
    WoundPoison = Spell(8679),
}

local S = RubimRH.Spell[260]

if not Item.Rogue then Item.Rogue = {}; end

Item.Rogue.Outlaw = {
    trink = Item(184016, { 13, 14 }),
    drums = Item(172233),
    healthstone = Item(5512),
    healingpoticon = Item(169451)
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

local function target_is_dummy()
    local x = UnitName("target")
    local targetisdummy = false

    if x then
        name = x:sub(-5)
    end

    if Target:Exists() then
        if name == 'Dummy' then
            targetisdummy = true
        end
    else
        targetisdummy = false
    end

    return targetisdummy
end

local function RtB_BuffRemains()
    if not Cache.APLVar.RtB_BuffRemains then
        Cache.APLVar.RtB_BuffRemains = 0;
        for i = 1, #RtB_BuffsList do
            if Player:Buff(RtB_BuffsList[i]) then
                Cache.APLVar.RtB_BuffRemains = Player:BuffRemainsP(RtB_BuffsList[i]);
                break;
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

local function APL()
    HL.GetEnemies(10, true);
    HL.GetEnemies(12, true);
    HL.GetEnemies(20, true);
    HL.GetEnemies(25, true);
    HL.GetEnemies(30, true);
    target_is_dummy()
    RtB_BuffRemains()
    RtB_Buffs()
    --------------------------------------------------------------------------------------------------------------------------------------------
    ----------------------------------------------------------Functions/Top priorities----------------------------------------------------------
    --------------------------------------------------------------------------------------------------------------------------------------------
    if Player:IsCasting() or Player:IsChanneling() then
        return 0, "Interface\\Addons\\Rubim-RH\\Media\\channel.tga"
    elseif Player:IsDeadOrGhost() or AuraUtil.FindAuraByName("Drink", "player") or
        AuraUtil.FindAuraByName("Food", "player") or AuraUtil.FindAuraByName("Food & Drink", "player") then
        return 0, "Interface\\Addons\\Rubim-RH\\Media\\griph.tga"
    end

    SnDAS = select(16, AuraUtil.FindAuraByName("Slice and Dice", "player"))
    if SnDAS == nil then
        SnDAS = 0
    end

    if Player:BuffP(S.EchoingReprimandCP2) or Player:BuffP(S.EchoingReprimandCP3) or Player:BuffP(S.EchoingReprimandCP4)
        or Player:BuffP(S.EchoingReprimandCP5) then
        erbuff = true
    else
        erbuff = false
    end

    if (Player:BuffP(S.EchoingReprimandCP2) and Player:ComboPoints() == 2) or
        (Player:BuffP(S.EchoingReprimandCP3) and Player:ComboPoints() == 3)
        or (Player:BuffP(S.EchoingReprimandCP4) and Player:ComboPoints() == 4) or
        (Player:BuffP(S.EchoingReprimandCP5) and Player:ComboPoints() == 5) then
        ercp = true
    else
        ercp = false
    end

    if ercp == true then
        effective_combo_points = 7
    else
        effective_combo_points = Player:ComboPoints()
    end

    --Reroll BT + GM or single buffs early other than Broadside, TB with Shadowdust, or SnC with Blunderbuss
    if true then
        rtb_reroll = (
            RtB_Buffs() < 2 and
                (
                not Player:BuffP(S.Broadside) and
                    (not S.FanTheHammer:IsAvailable() or not Player:BuffP(S.SkullandCrossbones)) and
                    (not IsEquippedItem("Shadowdust Locket") or not Player:BuffP(S.TrueBearing))))
            or (RtB_Buffs() == 2 and Player:BuffP(S.BuriedTreasure) and Player:BuffP(S.GrandMelee))

        --Ensure we get full Ambush CP gains and aren't rerolling Count the Odds buffs away
        ambush_condition = Player:ComboPointsDeficit() >= 2 + num(Player:BuffP(S.Broadside)) and
            UnitPower("player", 3) >= 50 and (not S.CountTheOdds:IsAvailable() or RtB_BuffRemains() >= 10)

        if S.BetweentheEyes:IsReadyQueue(20) then
            --Always attempt to use BtE at 5+ CP, regardless of CP gen waste
            finishcondition = effective_combo_points >= 5
        elseif Target:DebuffP(S.Flagellation) and Target:DebuffRemainsP(S.Flagellation) <= Player:GCD() then
            --Finish at 2+ in the last GCD of Flagellation
            finishcondition = effective_combo_points >= 2
        else
            --Finish at max possible CP without overflowing bonus combo points
            finishcondition = (
                Player:ComboPoints() >=
                    CPMaxSpend() - num(Player:BuffP(S.Broadside)) -
                    (
                    num(Player:BuffP(S.Opportunity)) *
                        (num(S.QuickDraw:IsAvailable()) or num(S.FanTheHammer:IsAvailable())))) or
                effective_combo_points >= CPMaxSpend()
        end
        -- variable,name=vanish_condition,value=talent.hidden_opportunity|!talent.shadow_dance|!cooldown.shadow_dance.ready
        vanishcondition = (
            S.HiddenOpportunity:IsAvailable() or not S.ShadowDance:IsAvailable() or not S.ShadowDance:CooldownUp())

        bladeflurrysync = Cache.EnemiesCount[10] < 2 or
            (Player:BuffRemainsP(S.BladeFlurry) > 1 + num(S.KillingSpree:IsAvailable()))

        mfdcondition = Player:ComboPoints() >=
            CPMaxSpend() -
            (num(Player:BuffP(S.Broadside)) + num(Player:BuffP(S.Opportunity)) * num(S.QuickDraw:IsAvailable())) and
            S.MarkedforDeath:IsReadyQueue(10)

        if IsEquippedItem("Sigil of the Master Assassin") and not S.MarkedforDeath:IsAvailable() then
            --value=(!cooldown.between_the_eyes.ready&variable.finish_condition)|(cooldown.between_the_eyes.ready&variable.ambush_condition)
            vanish_ma_condition = (not S.BetweentheEyes:CooldownUp() and finishcondition) or
                (S.BetweentheEyes:CooldownUp() and ambush_condition)
        elseif IsEquippedItem("Sigil of the Master Assassin") and S.MarkedforDeath:IsAvailable() and finishcondition then
            --vanish,if=variable.vanish_ma_condition&master_assassin_remains=0&variable.blade_flurry_sync
            vanish_ma_condition = finishcondition
        end
        --variable,name=killing_spree_vanish_sync,value=!runeforge.mark_of_the_master_assassin|cooldown.vanish.remains>10|master_assassin_remains>2
        killing_spree_vanish_sync = not IsEquippedItem("Sigil of the Master Assassin") or
            S.Vanish:CooldownRemainsP() > 10 or Player:BuffRemainsP(S.mantle) > 2
    end
    --print(finishcondition)
    --------------------------------------------------------------------------------------------------------------------------------------------
    ----------------------------------------------------------Interrupts & Shiv-----------------------------------------------------------------
    --------------------------------------------------------------------------------------------------------------------------------------------
    if select(8, UnitCastingInfo("target")) == false and Target:CastPercentage() > math.random(43, 87) and
        RubimRH.InterruptsON() and S.Kick:IsReadyQueue(8) and Player:AffectingCombat() then
        return S.Kick:Cast()
    end

    if (select(4, UnitAura("target", 1)) == "enrage"
        or AuraUtil.FindAuraByName("Undying Rage", "target")
        or AuraUtil.FindAuraByName("Enrage", "target")
        or AuraUtil.FindAuraByName("Unholy Frenzy", "target")
        or AuraUtil.FindAuraByName("Angering Shriek", "target")
        or AuraUtil.FindAuraByName("Loyal Beasts", "target")
        or AuraUtil.FindAuraByName("Frenzy", "target")
        or AuraUtil.FindAuraByName("Motivational Clubbing", "target")
        or AuraUtil.FindAuraByName("Motivated", "target")
        or AuraUtil.FindAuraByName("Seething Rage", "target")
        or AuraUtil.FindAuraByName("Vengeful Rage", "target")
        or AuraUtil.FindAuraByName("Raging Tantrum", "target")
        or AuraUtil.FindAuraByName("Death Wish", "target")
        or AuraUtil.FindAuraByName("Battle Trance", "target"))
        and RubimRH.InterruptsON() and S.Shiv:IsReadyQueue(8) and Player:AffectingCombat() and Target:TimeToDie() > 4 then
        return S.Shiv:Cast()
    end
    --------------------------------------------------------------------------------------------------------------------------------------------
    ----------------------------------------------------------Out of Combat---------------------------------------------------------------------
    --------------------------------------------------------------------------------------------------------------------------------------------
    if not Player:AffectingCombat() and not Player:BuffP(S.VanishBuff) then
        if S.Stealth:IsCastableQueue() and not Player:Buff(S.Stealth) and
            (IsResting("player") == false or Player:CanAttack(Target)) then
            return S.Stealth:Cast()
        end

        if S.CrimsonVial:IsCastableQueue() and Cache.EnemiesCount[25] == 0 and Player:HealthPercentage() < 100 and
            Player:EnergyDeficit() == 0 then
            return S.CrimsonVial:Cast()
        end

        if S.InstantPoison:IsCastableQueue() and not Player:Buff(S.WoundPoison) and
            Player:BuffRemainsP(S.InstantPoison) < 300 and not Player:IsCasting(S.InstantPoison) and
            not Player:IsMoving() then
            return S.InstantPoison:Cast()
        end

        -- if S.CripplingPoison:IsCastableQueue() and not Player:BuffP(S.NumbingPoison) and Player:BuffRemainsP(S.CripplingPoison) < 300 and not Player:IsCasting(S.CripplingPoison) and not Player:IsMoving() then
        -- return S.CripplingPoison:Cast()
        -- end

        if S.NumbingPoison:IsCastableQueue() and not Player:BuffP(S.CripplingPoison) and
            not Player:BuffP(S.CripplingPoison) and Player:BuffRemainsP(S.NumbingPoison) < 300 and
            not Player:IsCasting(S.NumbingPoison) and not Player:IsMoving() then
            return S.NumbingPoison:Cast()
        end

        if IsResting("player") == false and Player:ComboPoints() >= CPMaxSpend() then
            if S.SliceandDice:IsCastableQueue() and Player:BuffRemainsP(S.SliceandDice) < 8 and
                Cache.EnemiesCount[30] >= 1 then
                return S.SliceandDice:Cast()
            end
        end

        if S.RolltheBones:IsCastableQueue() and IsResting("player") == false and Cache.EnemiesCount[30] >= 1
            and ((not Player:BuffP(S.mantle) or Player:Buff(S.Stealth))
                and not Player:DebuffP(S.Dreadblades) and not Target:DebuffP(S.Flagellation)
                and (RtB_Buffs() == 0 or rtb_reroll)) then
            return S.RolltheBones:Cast()
        end

        if not RubimRH.queuedSpell[1]:CooldownUp() or not Target:IsInRange(10) or not Player:AffectingCombat() then
            RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
        end

        return 0, "Interface\\Addons\\Rubim-RH\\Media\\griph.tga"
    end
    --------------------------------------------------------------------------------------------------------------------------------------------
    ----------------------------------------------------------Spell Queue-----------------------------------------------------------------------
    --------------------------------------------------------------------------------------------------------------------------------------------
    if not RubimRH.queuedSpell[1]:CooldownUp() or not Target:IsInRange(10) or
        (not Player:AffectingCombat() and not Player:BuffP(S.VanishBuff)) then
        RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
    end

    if S.lustAT:ID() == RubimRH.queuedSpell[1]:ID() and
        (
        Player:Debuff(S.lust1) or Player:Debuff(S.lust2) or Player:Debuff(S.lust3) or Player:Debuff(S.lust4) or
            Player:Debuff(S.lust5)) then
        RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
    end

    if S.lustAT:ID() == RubimRH.queuedSpell[1]:ID() and not Player:Debuff(S.lust1) and not Player:Debuff(S.lust2) and
        not Player:Debuff(S.lust3) and not Player:Debuff(S.lust4) and not Player:Debuff(S.lust5) and
        (I.drums:IsReadyQueue()) then
        return S.lustAT:Cast() -- BIND LUST KEYBIND IN BINDPAD TO ARCANE TORRENT
    end

    if S.KidneyShot:ID() == RubimRH.queuedSpell[1]:ID() and Target:Debuff(S.CheapShot) then
        RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
    end

    if S.Gouge:ID() == RubimRH.queuedSpell[1]:ID() and
        (
        Target:Debuff(S.CheapShot) or not Target:IsInRange(10) or not Player:AffectingCombat() or Player:Buff(S.Stealth)
            or Target:Debuff(S.BetweentheEyes) or Player:Buff(S.VanishBuff) or Target:Debuff(S.Blind)) then
        RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
    end

    if RubimRH.QueuedSpell():IsReadyQueue() and S.Dreadblades:ID() ~= RubimRH.queuedSpell[1]:ID() and
        S.Flagellation:ID() ~= RubimRH.queuedSpell[1]:ID() then
        return RubimRH.QueuedSpell():Cast()
    end

    if S.Flagellation:ID() == RubimRH.queuedSpell[1]:ID() and finishcondition and Player:CanAttack(Target) and
        Target:IsInRange(10) and not Player:BuffP(S.Stealth) and not Player:Buff(S.VanishBuff) and RtB_Buffs() >= 1 and
        bladeflurrysync and (S.Dreadblades:CooldownRemainsP() <= 7 + (num(Player:BuffP(S.TrueBearing)) * 3.5)) then
        return S.Flagellation:Cast()
    end

    if S.Dreadblades:ID() == RubimRH.queuedSpell[1]:ID() and Player:ComboPoints() <= 2 and not finishcondition and
        Player:CanAttack(Target) and Target:IsInRange(10) and not Player:BuffP(S.Stealth) and
        not Player:Buff(S.VanishBuff) and RtB_Buffs() >= 1 and bladeflurrysync then
        return S.Dreadblades:Cast()
    end
    --------------------------------------------------------------------------------------------------------------------------------------------
    ----------------------------------------------------------Explosives------------------------------------------------------------------------
    --------------------------------------------------------------------------------------------------------------------------------------------
    if S.PistolShot:IsReadyQueue() and UnitName('target') == 'Explosives' then
        return S.PistolShot:Cast()
    end
    --------------------------------------------------------------------------------------------------------------------------------------------
    ----------------------------------------------------------Cooldowns-------------------------------------------------------------------------
    --------------------------------------------------------------------------------------------------------------------------------------------
    if not IsCurrentSpell(6603) and not Player:BuffP(S.Stealth) and not Player:Buff(S.VanishBuff) and
        Player:CanAttack(Target)
        and Target:AffectingCombat() and Target:IsInRange(20) then
        return S.autoattack:Cast()
    end

    if IsEquippedItem("Ring of Collapsing Futures") and not Player:DebuffP(S.Temptation) and Player:CanAttack(Target) and
        Player:AffectingCombat() and not Player:Buff(S.VanishBuff) and not Player:Buff(S.Stealth)
        and Target:IsInRange(20) and IsUsableItem(142173) and GetItemCooldown(142173) == 0 then
        return S.Temptation:Cast()
    end

    if Player:HealthPercentage() <= 25 and Player:AffectingCombat() and IsUsableItem(187802) and
        GetItemCooldown(187802) == 0 and GetItemCount(187802) >= 1
        and (not Player:InArena() and not Player:InBattlegrounds()) then
        return I.healingpoticon:Cast()
    end

    if S.BladeFlurry:IsCastableQueue() and
        (
        not Player:Buff(S.VanishBuff) and not Player:Buff(S.Stealth) and
            (
            RubimRH.AoEON() and (not Player:BuffP(S.BladeFlurry) or Player:BuffRemainsP(S.BladeFlurry) < Player:GCD())
                and Cache.EnemiesCount[12] >= 2)) then
        return S.BladeFlurry:Cast()
    end

    if S.RolltheBones:IsCastableQueue() and Cache.EnemiesCount[30] >= 1 and not Player:BuffP(S.VanishBuff)
        and (not Player:BuffP(S.mantle)
            and not Player:DebuffP(S.Dreadblades)
            and (RtB_Buffs() == 0 or rtb_reroll)) then
        return S.RolltheBones:Cast()
    end

    if S.Flagellation:IsReadyQueue() and not Player:Buff(S.Stealth) and Target:IsInRange(10) and Player:CanAttack(Target)
        and RubimRH.CDsON() and Player:AffectingCombat() and finishcondition and bladeflurrysync and
        (S.Dreadblades:CooldownRemainsP() <= 7 + (num(Player:BuffP(S.TrueBearing)) * 3.5)) then
        return S.Flagellation:Cast()
    end

    if IsEquippedItem("Sigil of the Master Assassin") and Target:IsInRange(10) and Player:CanAttack(Target) and
        not Player:Buff(S.Stealth)
        and ((finishcondition and UnitPower("player", 3) >= 32) or UnitPower("player", 3) >= 50) and SnDAS == 64 then
        if S.Vanish:IsReadyQueue() and Player:GCDRemains() <= 0.5 and Player:AffectingCombat() and
            Player:BuffRemainsP(S.mantle) == 0 and bladeflurrysync and vanish_ma_condition then
            return S.Vanish:Cast()
        end

        if Player:BuffP(S.mantle) and Player:BuffP(S.VanishBuff) then
            if S.Dispatch:IsCastableQueue(8) and finishcondition then
                return S.Dispatch:Cast()
            end

            if S.Ambush:IsCastableQueue(8) then
                return S.Ambush:Cast()
            end
        end
    end

    if S.AdrenalineRush:IsCastableQueue() and not Player:BuffP(S.Stealth) and not Player:BuffP(S.AdrenalineRush) and
        Target:IsInRange(9) and Player:CanAttack(Target)
        and RubimRH.CDsON() and Player:AffectingCombat() and
        (not S.ImprovedAdrenalineRush:IsAvailable() or Player:ComboPoints() <= 2) then
        return S.AdrenalineRush:Cast()
    end

    if S.Dreadblades:IsCastableQueue() and Player:ComboPoints() <= 2 and Player:CanAttack(Target) and
        Target:IsInRange(10) and not Player:Buff(S.Stealth) and Player:AffectingCombat()
        and (not S.MarkedforDeath:IsAvailable() or not S.MarkedforDeath:CooldownUp())
        and (not S.Flagellation:IsAvailable() or Target:DebuffRemainsP(S.Flagellation) > Player:GCD() * 2) then
        return S.Dreadblades:Cast()
    end

    if S.MarkedforDeath:IsCastableQueue() and Target:IsInRange(11) and Player:CanAttack(Target)
        and
        (
        Player:ComboPointsDeficit() >= CPMaxSpend() - 1 and
            not
            (
            (Player:ComboPoints() == 2 and Player:Buff(S.EchoingReprimandCP2)) or
                (Player:ComboPoints() == 3 and Player:Buff(S.EchoingReprimandCP3)) or
                (Player:ComboPoints() == 4 and Player:Buff(S.EchoingReprimandCP4)))) then
        return S.MarkedforDeath:Cast()
    end

    if S.BladeRush:IsReadyQueue() and RubimRH.CDsON() and not RubimRH.LastCast(S.Vanish, 1) and Player:AffectingCombat()
        and not Target:Debuff(S.Blind)
        and not Player:BuffP(S.Stealth) and not Player:BuffP(S.VanishBuff) and Target:IsInRange(5)
        and
        (
        Cache.EnemiesCount[12] == 1 and EnergyTimeToMaxRounded() > 2 or
            (Cache.EnemiesCount[12] > 1 and Player:BuffP(S.BladeFlurry))
            or S.BladeFlurry:CooldownRemainsP() >= 10) then
        return S.BladeRush:Cast()
    end

    if IsEquippedItem("Shadowdust Locket") and Target:IsInRange(10) and Player:CanAttack(Target) and
        not Player:Buff(S.Stealth) then
        if S.Vanish:IsReadyQueue() and Player:GCDRemains() <= 0.5 and Player:AffectingCombat() and finishcondition
            and S.Flagellation:IsAvailable() and not S.Flagellation:CooldownUp() and
            (not S.Dreadblades:IsAvailable() or not S.Dreadblades:CooldownUp() or not Target:DebuffP(S.Flagellation)) then
            return S.Vanish:Cast()
        end

        if Player:BuffP(S.VanishBuff) then
            if S.Dispatch:IsCastableQueue(8) and finishcondition then
                return S.Dispatch:Cast()
            end

            if S.Ambush:IsCastableQueue(8) then
                return S.Ambush:Cast()
            end
        end
    end





    -- variable,name=shadow_dance_condition,value=talent.shadow_dance&debuff.between_the_eyes.up&(!talent.ghostly_strike|debuff.ghostly_strike.up)&(!talent.dreadblades|!cooldown.dreadblades.ready)&(!talent.hidden_opportunity|!buff.audacity.up&(talent.fan_the_hammer.rank<2|!buff.opportunity.up))
    -- shadow_dance,if=!talent.keep_it_rolling&variable.shadow_dance_condition&buff.slice_and_dice.up&(variable.finish_condition|talent.hidden_opportunity)&(!talent.hidden_opportunity|!cooldown.vanish.ready)
    -- shadow_dance,if=talent.keep_it_rolling&variable.shadow_dance_condition&(cooldown.keep_it_rolling.remains<=30|cooldown.keep_it_rolling.remains>120&(variable.finish_condition|talent.hidden_opportunity))
local   shadowdance = (IsUsableSpell('Shadow Dance') and S.ShadowDance:CooldownUp())

    if shadowdance and RubimRH.CDsON() then
        -- actions.stealth_cds+=/variable,name=shadow_dance_condition,value=talent.shadow_dance&debuff.between_the_eyes.up&(!talent.ghostly_strike|debuff.ghostly_strike.up)&(!talent.dreadblades|!cooldown.dreadblades.ready)&(!talent.hidden_opportunity|!buff.audacity.up&(talent.fan_the_hammer.rank<2|!buff.opportunity.up))
        -- actions.stealth_cds+=/shadow_dance,if=!talent.keep_it_rolling&variable.shadow_dance_condition&buff.slice_and_dice.up&(variable.finish_condition|talent.hidden_opportunity)&(!talent.hidden_opportunity|!cooldown.vanish.ready)
        -- actions.stealth_cds+=/shadow_dance,if=talent.keep_it_rolling&variable.shadow_dance_condition&(cooldown.keep_it_rolling.remains<=30|cooldown.keep_it_rolling.remains>120&(variable.finish_condition|talent.hidden_opportunity))
        if Target:Debuff(S.BetweentheEyes) and (not S.GhostlyStrike:IsAvailable() or Target:Debuff(S.GhostlyStrike))
            and (not S.Dreadblades:IsAvailable() or not S.Dreadblades:IsCastable())
            and
            (
            not S.HiddenOpportunity:IsAvailable() or
                not Player:Buff(S.AudacityBuff) and (S.FanTheHammer:TalentRank() < 2 or not Player:Buff(S.Opportunity))) then
            if S.KeepItRolling:IsAvailable() then
                if (
                    S.KeepItRolling:CooldownRemains() <= 30 or
                        S.KeepItRolling:CooldownRemains() > 120 and
                        (finishcondition or S.HiddenOpportunity:IsAvailable())) then
                    return S.ShadowDance:Cast()
                end
            else
                if Player:Buff(S.SliceandDice) and (finishcondition or S.HiddenOpportunity:IsAvailable())
                    and (not S.HiddenOpportunity:IsAvailable() or not S.Vanish:CooldownUp() or not vanishcondition) then
                    return S.ShadowDance:Cast()
                end

            end
        end
    end





    --------------------------------------------------------------------------------------------------------------------------------------------
    ----------------------------------------------------------Echoing Reprimand-----------------------------------------------------------------
    --------------------------------------------------------------------------------------------------------------------------------------------
    -- if (Player:ComboPoints() == 2 and Player:Buff(S.EchoingReprimandCP2)) or (Player:ComboPoints() == 3 and Player:Buff(S.EchoingReprimandCP3)) or (Player:ComboPoints() == 4 and Player:Buff(S.EchoingReprimandCP4)) then
    -- if S.BetweentheEyes:IsReadyQueue(20) and not Target:Debuff(S.Blind) and not Player:Buff(S.Stealth) and not Player:Buff(S.VanishBuff) and Player:AffectingCombat() then
    -- return S.BetweentheEyes:Cast()
    -- end

    -- if S.Dispatch:IsReadyQueue(8) and not Target:Debuff(S.Blind) and not Player:Buff(S.Stealth) and not Player:Buff(S.VanishBuff) and Player:AffectingCombat() then
    -- return S.Dispatch:Cast()
    -- end
    -- end
    --------------------------------------------------------------------------------------------------------------------------------------------
    ----------------------------------------------------------Finishers-------------------------------------------------------------------------
    --------------------------------------------------------------------------------------------------------------------------------------------
    if finishcondition then
        if S.BetweentheEyes:IsReadyQueue(20) and Target:TimeToDie() > 3 and not Target:Debuff(S.Blind) and
            not Player:Buff(S.Stealth) and Player:AffectingCombat() and not Player:Buff(S.VanishBuff)
            and
            (
            Target:DebuffRemainsP(S.BetweentheEyes) < 4 or
                (
                (S.GreenSkinsWickers:IsAvailable() and not Player:BuffP(S.GreenSkinsWickersBuff)) or
                    (not S.GreenSkinsWickers:IsAvailable() and Player:BuffP(S.RuthlessPrecision)))) then
            return S.BetweentheEyes:Cast()
        end
    end

    if S.SliceandDice:IsReadyQueue() and
        (SnDAS ~= 64 or (SnDAS == 64 and Player:BuffRemainsP(S.SliceandDice) <= Player:GCD() * 2))
        and Target:IsInRange(10) and Player:ComboPoints() >= CPMaxSpend() and not Player:BuffP(S.mantle) then
        return S.SliceandDice:Cast()
    end

    if finishcondition then
        if S.SliceandDice:IsReadyQueue() and not S.SwiftSlasher:IsAvailable() and not Player:Buff(S.GrandMelee) and
            Target:IsInRange(10)
            and Player:BuffRemainsP(S.SliceandDice) < Player:GCD() * 2 and not Player:BuffP(S.mantle) then
            return S.SliceandDice:Cast()
        end

        if S.Dispatch:IsReadyQueue(8) and not Target:Debuff(S.Blind) and not Player:Buff(S.Stealth) and
            Player:AffectingCombat() and not Player:Buff(S.VanishBuff)
            and (SnDAS == 64 or not S.SwiftSlasher:IsAvailable()) then
            if S.ColdBlood:IsReadyQueue(8) and not Player:BuffP(S.ColdBlood) and not S.GreenSkinsWickers:IsAvailable()
                and not Player:BuffP(S.mantle) and bladeflurrysync then
                return S.ColdBlood:Cast()
            end
            if S.Dispatch:IsReadyQueue(8) then
                return S.Dispatch:Cast()
            end
        end

  -- Shadow Dance at or below 3 combo points, and do not have  Audacity or  Opportunity active and wait until you have at least 80 energy. While active  Ambush becomes your highest priority builder
  if S.ShadowDance:IsCastable() and Target:IsInRange(10) and Player:ComboPoints()<3 and (not Player:Buff(S.AudacityBuff) or Player:Buff(S.Opportunity) and Player:Energy()>=80) then
    return S.ShadowDance:Cast()
  end

    end
    --------------------------------------------------------------------------------------------------------------------------------------------
    ----------------------------------------------------------Builders--------------------------------------------------------------------------
    --------------------------------------------------------------------------------------------------------------------------------------------
    if not RubimRH.LastCast(S.MarkedforDeath, 1) and not Player:Buff(S.Stealth) and not Target:Debuff(S.Blind) and
        not Player:Buff(S.VanishBuff) and Player:AffectingCombat()
        and (not finishcondition or (S.SwiftSlasher:IsAvailable() and SnDAS ~= 64)) then
        if S.EchoingReprimand:CooldownRemainsP() <= 10 and SnDAS == 64
            and (
            ((Player:ComboPoints() == 1 - num(Player:BuffP(S.Broadside))) and Player:Buff(S.EchoingReprimandCP2))
                or ((Player:ComboPoints() == 2 - num(Player:BuffP(S.Broadside))) and Player:Buff(S.EchoingReprimandCP3))
                or ((Player:ComboPoints() == 3 - num(Player:BuffP(S.Broadside))) and Player:Buff(S.EchoingReprimandCP4))
            ) then
            if S.PistolShot:IsReadyQueue(20) and not Player:BuffP(S.Opportunity) then
                return S.PistolShot:Cast()
            end
        end
        --(not finishcondition or (S.SwiftSlasher:IsAvailable() and SnDAS ~= 64))
        -- if not ((UnitClassification("target") == "minus" and UnitClassification("target") == "trivial" and UnitClassification("target") == "normal") or Player:InDungeonOrRaid()) then
        -- if S.GhostlyStrike:IsReadyQueue(8) and (Target:DebuffP(S.BetweentheEyes) or UnitClassification("target") == "worldboss") and Target:TimeToDie() > 4 then
        -- return S.GhostlyStrike:Cast()
        -- end
        -- end

        if S.EchoingReprimand:IsReadyQueue(8) then
            return S.EchoingReprimand:Cast()
        end

        if S.PistolShot:IsReadyQueue(20)
            and
            (
            (
                Player:BuffP(S.GreenSkinsWickersBuff) and Player:Buff(S.Opportunity) and
                    (not S.FanTheHammer:IsAvailable() or Player:BuffRemainsP(S.GreenSkinsWickersBuff) < 2))
                or
                (
                S.FanTheHammer:IsAvailable() and Player:Buff(S.Opportunity) and
                    (Player:BuffStack(S.Opportunity) >= 6 or Player:BuffRemainsP(S.Opportunity) < 2))
                or
                (
                S.FanTheHammer:IsAvailable() and Player:Buff(S.Opportunity) and Player:ComboPointsDeficit() > 4 and
                    not Player:DebuffP(S.Dreadblades))) then
            if S.ColdBlood:IsCastableQueue() and not Player:BuffP(S.ColdBlood) and
                (
                (Player:Buff(S.Opportunity) and Player:BuffP(S.GreenSkinsWickersBuff)) or
                    (Player:BuffP(S.GreenSkinsWickersBuff) and Player:BuffRemainsP(S.GreenSkinsWickersBuff) < 2))
                and not Player:BuffP(S.mantle) and bladeflurrysync then
                return S.ColdBlood:Cast()
            end
            if S.PistolShot:IsReadyQueue(20) then
                return S.PistolShot:Cast()
            end
        end

        if Player:EnergyTimeToMaxPredicted() <= Player:GCD() * 2 or Player:DebuffP(S.Dreadblades) or
            Target:DebuffP(S.Flagellation)
            or SnDAS ~= 64 or Player:BuffP(S.mantle) or RtB_Buffs() >= 5 or erbuff == true or
            (not Target:DebuffP(S.BetweentheEyes) and S.BetweentheEyes:CooldownUp())
            or (Player:BuffP(S.BladeFlurry) and Cache.EnemiesCount[10] >= 2) or
            S.Flagellation:ID() == RubimRH.queuedSpell[1]:ID() or S.Dreadblades:ID() == RubimRH.queuedSpell[1]:ID() then
            if S.Ambush:IsReadyQueue(8) then
                return S.Ambush:Cast()
            end

            -- pistol_shot,if=!talent.fan_the_hammer&buff.opportunity.up&(energy.base_deficit>energy.regen*1.5|!talent.weaponmaster&combo_points.deficit<=1+buff.broadside.up|talent.quick_draw.enabled|talent.audacity.enabled&!buff.audacity.up)
            if S.PistolShot:IsReadyQueue(20)
                and
                (
                not S.FanTheHammer:IsAvailable() and Player:Buff(S.Opportunity) and
                    (
                    Player:EnergyTimeToMaxPredicted() > 1.5 or
                        S.Weaponmaster:IsAvailable() and Player:ComboPointsDeficit() <= 1 + num(Player:Buff(S.Broadside))
                        or S.QuickDraw:IsAvailable() or S.Audacity:IsAvailable() and not Player:Buff(S.Audacity))) then
                return S.PistolShot:Cast()
            end

            if S.SinisterStrike:IsReadyQueue(8) then
                return S.SinisterStrike:Cast()
            end
        end
    end
    --------------------------------------------------------------------------------------------------------------------------------------------
    ----------------------------------------------------------OOR Pistol Shot / BTE-------------------------------------------------------------
    --------------------------------------------------------------------------------------------------------------------------------------------
    if not Target:IsInRange(11) and not Target:Debuff(S.Blind) and not Player:Buff(S.Stealth) and
        Player:AffectingCombat() then
        if S.BetweentheEyes:IsReadyQueue(20) and EnergyTimeToMaxRounded() <= Player:GCD() and
            Player:ComboPoints() >= CPMaxSpend() then
            return S.BetweentheEyes:Cast()
        end

        if S.PistolShot:IsReadyQueue(20) and Player:AffectingCombat() and Player:EnergyDeficitPredicted() < 25 and
            (Player:ComboPointsDeficit() >= 1 or EnergyTimeToMaxRounded() <= Player:GCD()) then
            return S.PistolShot:Cast()
        end

    end
    return 0, 135328
end

RubimRH.Rotation.SetAPL(260, APL);

local function PASSIVE()

end

RubimRH.Rotation.SetPASSIVE(260, PASSIVE);
