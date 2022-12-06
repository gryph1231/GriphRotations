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

--- ============================ CONTENT ===========================
--- ======= APL LOCALS =======
-- luacheck: max_line_length 9999

-- Spells
RubimRH.Spell[66] = {




    autoattack = Spell(291944), -- regeneratin
    wristsx = Spell(255647), -- lights judgmenet
    tempestofthelightbringer = Spell(383396),

    lust1                    = Spell(57724),
    lust2                    = Spell(57723),
    lust3                    = Spell(80354),
    lust4                    = Spell(95809),
    lust5                    = Spell(264689),
    lustAT                   = Spell(265221), -- fireblood
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

    EyeofTyr = Spell(387174),
   

    ArdentDefender             = Spell(31850),
    ArdentDefenderBuff         = Spell(31850),
    AvengersShield             = Spell(31935),
    GuardianofAncientKings     = Spell(86659),
    GuardianofAncientKingsBuff = Spell(86659),
    HammeroftheRighteous       = Spell(53595),
    Judgment                   = Spell(275779),
    JudgmentDebuff             = Spell(197277),
    ShiningLight       = Spell(327510),
    -- Talents
    BlessedHammer              = Spell(204019),
    CrusadersJudgment          = Spell(204023),
    MomentofGlory              = Spell(327193),
    SanctifiedWrath            = Spell(171648),
    DivineToll                 = Spell(375576),



BastionofLight = Spell(378974),



};




local S = RubimRH.Spell[66];
local G = RubimRH.Spell[1]; -- General Skills

-- Items
if not Item.Paladin then
    Item.Paladin = {}
end
Item.Paladin.Protection = {
    trink = Item(178751, { 13, 14 }),

    bracer = Item(168978),
    rez = Item(158379),
    drums = Item(172233),

    HPIcon = Item(169451),
    tx1 = Item(118330),
    tx2 = Item(114616),
};
local I = Item.Paladin.Protection;


-- Variables
local EnemyRanges = { 10, 15, 50 }
local function UpdateRanges()
    for _, i in ipairs(EnemyRanges) do
        HL.GetEnemies(i);
    end
end

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

local function allMobsinRange(range)
    local totalRange40 = 0
    local allMobsinRange = false

    for id = 1, 40 do
        local unitID = "nameplate" .. id
        if UnitCanAttack("player", unitID) and Cache.EnemiesCount[40]
            and UnitHealthMax(unitID) > 5 and UnitAffectingCombat(unitID) then
            totalRange40 = totalRange40 + 1
        end
    end

    if range == totalRange40 and totalRange40 >= 1 then
        allMobsinRange = true
    else
        allMobsinRange = false
    end

    return allMobsinRange

end

local function ConcerationTime()
    for i = 1, 5 do
        local active, totemName, startTime, duration, textureId = GetTotemInfo(i)
        if active == true then
            return startTime + duration - GetTime()
        end
    end
    return 0
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
--- ======= ACTION LISTS =======
local function APL()


    HL.GetEnemies("Melee");
    HL.GetEnemies(5);
    HL.GetEnemies(6);
    HL.GetEnemies(8);
    HL.GetEnemies(9);
    HL.GetEnemies(10);
    HL.GetEnemies(11);
    HL.GetEnemies(12);
    HL.GetEnemies(14);
    HL.GetEnemies(16);
    HL.GetEnemies(20);
    HL.GetEnemies(25);
    HL.GetEnemies(30);
    allMobsinRange()
    tarSpeed, _, _, _ = GetUnitSpeed('target')

    wordofglorycast = (
        Player:HolyPower() >= 3 or Player:BuffP(S.DivinePurposeBuff) or Player:BuffP(S.ShiningLight) or
            Player:Buff(S.BastionofLight))

    -- if  (not Target:Exists() or not Target:IsInRange(30)) and Cache.EnemiesCount[20]>=1 then
    -- return 133015
    -- end

    --  if I.healthstone:IsReady() and I.healthstone:Count()>=1 and Player:HealthPercentage() <= 30 and Player:AffectingCombat() then
    --     return S.healthstone:Cast()
    -- end

    if RubimRH.CDsON() and Target:IsInRange(8) then
        local ShouldReturn = UseItems();
        if ShouldReturn then return ShouldReturn; end
    end

    IsTanking = Player:IsTankingAoE(8) or Player:IsTanking(Target)

    if Player:HealthPercentage() <= 25 and Player:AffectingCombat() and IsUsableItem(191380) and
        GetItemCooldown(191380) == 0 and GetItemCount(191380) >= 1
        and (not Player:InArena() and not Player:InBattlegrounds()) then
        return I.HPIcon:Cast()
    end


    if S.Intercession:ID() == RubimRH.queuedSpell[1]:ID() and S.Intercession:IsReady() and UnitExists("mouseover") then
        return S.Intercession:Cast() -- BIND brez to stoneform
    end

    if S.Intercession:ID() == RubimRH.queuedSpell[1]:ID() and
        (not S.Intercession:CooldownUp() or not UnitExists("mouseover") or not UnitIsDeadOrGhost("mouseover")) then
        RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
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

    if I.trink:IsReady() and Cache.EnemiesCount[5] >= 1 and Target:IsInRange(8) and I.trink:IsEquipped() and
        RubimRH.CDsON() then
        return S.trinket:Cast()
    end

    if S.FlashofLight:ID() == RubimRH.queuedSpell[1]:ID() and Player:IsMoving() then
        RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
    end


    if S.DivineShield:ID() == RubimRH.queuedSpell[1]:ID() and Player:DebuffP(S.Forbearance) then
        RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
    end
    if S.BlessingofProtection:ID() == RubimRH.queuedSpell[1]:ID() and Player:DebuffP(S.Forbearance) then
        RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
    end
    if S.LayonHands:ID() == RubimRH.queuedSpell[1]:ID() and Player:DebuffP(S.Forbearance) then
        RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
    end

    if S.DivineSteed:ID() == RubimRH.queuedSpell[1]:ID() and Player:BuffP(S.DivineSteedBuff) then
        RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
    end





    if RubimRH.QueuedSpell():IsReadyQueue() then
        return RubimRH.QueuedSpell():Cast()
    end





    if (not RubimRH.queuedSpell[1]:CooldownUp() or not Player:AffectingCombat() or Cache.EnemiesCount[20] == 0) then
        RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
    end


    if select(8, UnitCastingInfo("target")) == false and Target:CastPercentage() > math.random(43, 87) and
        RubimRH.InterruptsON() and S.Rebuke:IsReady(8) and Player:AffectingCombat() then
        return S.Rebuke:Cast()
    end


    if not IsCurrentSpell(6603) and Player:CanAttack(Target)
        and Target:AffectingCombat() and Player:AffectingCombat() and Target:IsInRange(20) then
        return S.autoattack:Cast()
    end



    if S.ArdentDefender:IsReadyP() and Player:AffectingCombat() and not Player:Buff(S.GuardianofAncientKings) and
        (Player:NeedPanicHealing() or Player:NeedMajorHealing()) and Player:HealthPercentage() <= 35 and
        Cache.EnemiesCount[10] >= 1 then
        return S.ArdentDefender:Cast()
    end


    if S.ArdentDefender:IsReadyP() and not Player:Buff(S.GuardianofAncientKings) and
        (Player:NeedPanicHealing() or Player:NeedMajorHealing()) and Player:HealthPercentage() <= 25 and
        (S.LayonHands:CooldownRemains() > 1 or not Player:InArena()) and Cache.EnemiesCount[10] >= 1 then
        return S.ArdentDefender:Cast()
    end

    if S.ArdentDefender:IsReadyP() and Cache.EnemiesCount[10] >= 1 and Player:HealthPercentage() <= 60 and
        not Player:Buff(S.GuardianofAncientKings) and (Player:NeedPanicHealing() or Player:NeedMajorHealing()) then
        return S.ArdentDefender:Cast()
    end

    if S.GuardianofAncientKings:IsReadyP() and
        (
        Player:NeedPanicHealing() and Player:HealthPercentage() <= 70 or
            Player:NeedMajorHealing() and Player:HealthPercentage() < 55) and not Player:Buff(S.ArdentDefender) and
        not Player:Buff(S.DivineShield) and Cache.EnemiesCount[10] >= 1 then
        return S.GuardianofAncientKings:Cast()
    end




    if S.LayonHands:IsReadyP() and Player:HealthPercentage() <= 25 and not Player:Debuff(S.Forbearance) and
        not Player:InArena() and Cache.EnemiesCount[30] >= 1 then
        return S.LayonHands:Cast()
    end


    if S.DivineShield:IsReady() and Player:HealthPercentage() <= 25 and not Player:Debuff(S.Forbearance) and
        not Player:BuffP(S.ArdentDefender) and S.ArdentDefender:CooldownRemains() > 1 and
        not Player:Buff(S.GuardianofAncientKings) and Cache.EnemiesCount[15] >= 1 then
        return S.DivineShield:Cast()
    end


    if S.BastionofLight:IsReadyP() and Cache.EnemiesCount[8] >= 1 and RubimRH.CDsON() then
        return S.BastionofLight:Cast()
    end



    if S.WordofGlory:IsReadyP() and Player:HealthPercentage() < 65 and wordofglorycast and
        Player:BuffRemains(S.ShieldoftheRighteousBuff) > 5 then
        return S.WordofGlory:Cast()
    end

    if S.WordofGlory:IsReadyP() and
        (
        Player:HealthPercentage() < 45 and wordofglorycast or
            Player:HealthPercentage() < 70 and Player:HolyPower() == 5 and Cache.EnemiesCount[20] == 0) and
        Player:Buff(S.ShieldoftheRighteousBuff) then
        return S.WordofGlory:Cast()
    end

    if S.BlessingofProtection:IsReadyP() and Player:HealthPercentage() <= 20 and not Player:DebuffP(S.Forbearance) and
        S.DivineShield:CooldownRemains() > Player:GCD() and not Player:BuffP(S.ArdentDefender) and
        not Player:Buff(S.GuardianofAncientKings) and S.LayonHands:CooldownRemains() > Player:GCD() and
        Cache.EnemiesCount[10] >= 1 then
        return S.BlessingofProtection:Cast()
    end


    -- fireblood,if=buff.avenging_wrath.up
    -- seraphim
    -- avenging_wrath
    -- holy_avenger,if=buff.avenging_wrath.up|cooldown.avenging_wrath.remains>60
    -- potion,if=buff.avenging_wrath.up
    -- use_items,if=buff.seraphim.up|!talent.seraphim.enabled
    -- moment_of_glory,if=prev_gcd.1.avengers_shield&cooldown.avengers_shield.remains


    if RubimRH.CDsON() and Cache.EnemiesCount[8] >= 1 then

        if S.Seraphim:IsReadyP() then
            return S.Seraphim:Cast()
        end


        if S.AvengingWrath:IsReadyP() and Player:BuffDownP(S.AvengingWrathBuff) then
            return S.AvengingWrath:Cast()
        end

        if S.HolyAvenger:IsReadyP() and (Player:BuffP(S.AvengingWrathBuff) or S.AvengingWrath:CooldownRemains() > 60) then
            return S.HolyAvenger:Cast()
        end

        if S.MomentofGlory:IsReadyP() and Player:PrevGCD(1, S.AvengersShield) and not S.AvengersShield:CooldownUp() then
            return S.MomentofGlory:Cast()
        end

    end


    -- shield_of_the_righteous,if=debuff.judgment.up&(debuff.vengeful_shock.up|!conduit.vengeful_shock.enabled)
    -- shield_of_the_righteous,if=holy_power=5|buff.holy_avenger.up|holy_power=4&talent.sanctified_wrath.enabled&buff.avenging_wrath.up
    -- judgment,target_if=min:debuff.judgment.remains,if=charges=2|!talent.crusaders_judgment.enabled
    -- avengers_shield,if=debuff.vengeful_shock.down&conduit.vengeful_shock.enabled
    -- hammer_of_wrath
    -- avengers_shield
    -- judgment,target_if=min:debuff.judgment.remains
    -- vanquishers_hammer
    -- consecration,if=!consecration.up
    -- divine_toll
    -- blessed_hammer,strikes=2.4,if=charges=3
    -- ashen_hallow
    -- hammer_of_the_righteous,if=charges=2
    -- word_of_glory,if=buff.vanquishers_hammer.up
    -- blessed_hammer,strikes=2.4
    -- hammer_of_the_righteous
    -- lights_judgment
    -- arcane_torrent
    -- consecration
    -- word_of_glory,if=buff.shining_light_free.up&!covenant.necrolord


    consecrationdrop = (
        Player:CanAttack(Target) and Target:IsInRange(8) and
            (Player:MovingFor() <= Player:GCD() or allMobsinRange(10) and tarSpeed == 0) or Cache.EnemiesCount[5] >= 2)

    --consecrationdrop = (not Player:IsMoving() and Cache.EnemiesCount[8]>=1 or Player:IsMoving() and Cache.EnemiesCount[5]>=1)


    -- shield_of_the_righteous,if=debuff.judgment.up&(debuff.vengeful_shock.up|!conduit.vengeful_shock.enabled)

    if S.ShieldoftheRighteous:IsReady() and Target:IsInRange(5) and
        (
        Target:Debuff(S.JudgmentDebuff) or
            Player:HealthPercentage() < 90 and not Player:Buff(S.ShieldoftheRighteousBuff) and
            (Player:NeedMajorHealing() or Player:NeedPanicHealing()))

    then
        return S.ShieldoftheRighteous:Cast()
    end

    -- shield_of_the_righteous,if=holy_power=5|buff.holy_avenger.up|holy_power=4&talent.sanctified_wrath.enabled&buff.avenging_wrath.up

    if S.ShieldoftheRighteous:IsReady() and Target:IsInRange(5) and
        (
        Player:HolyPower() == 5 or Player:BuffP(S.HolyAvenger) or
            Player:HolyPower() == 4 and S.SanctifiedWrath:IsAvailable() and Player:BuffP(S.AvengingWrathBuff)) then
        return S.ShieldoftheRighteous:Cast()
    end

    -- -- more dr if dropped before everything

    if S.Consecration:IsReadyP() and not Player:Buff(S.ConsecrationBuff) and consecrationdrop then
        return S.Consecration:Cast()
    end

    -- judgment,target_if=min:debuff.judgment.remains,if=charges=2|!talent.crusaders_judgment.enabled

    if S.Judgment:IsReadyP() and Target:IsInRange(30) and
        (
        Target:DebuffRemains(S.JudgmentDebuff) < Player:GCD() and S.Judgment:ChargesFractional() >= 1.9 or
            not S.CrusadersJudgment:IsAvailable()) then
        return S.Judgment:Cast()
    end

    -- avengers_shield,if=debuff.vengeful_shock.down&conduit.vengeful_shock.enabled
    --waiting for shadowlands release

    if S.AvengersShield:IsReadyP() and Target:IsInRange(30) and Target:Debuff(S.VengefulShockDebuff)
    --and S.VengefulShock:IsAvailable() -- vengeful shock always enabled with build
    then
        return S.AvengersShield:Cast()
    end
    -- divine_toll

    if S.DivineToll:IsReadyP() and Cache.EnemiesCount[16] >= 3 and Target:IsInRange(30) and RubimRH.CDsON() and
        (Player:BuffP(S.AvengingWrathBuff) or S.AvengingWrath:CooldownRemains() > 0) then
        return S.DivineToll:Cast()
    end

    if S.AvengersShield:IsReadyP() and Cache.EnemiesCount[16] >= 3 and Target:IsInRange(30) then
        return S.AvengersShield:Cast()
    end


    -- hammer_of_wrath

    if S.HammerofWrath:IsReadyP() and Target:IsInRange(30) and
        (Target:HealthPercentage() <= 20 or Player:BuffP(S.AvengingWrathBuff)) then
        return S.HammerofWrath:Cast()
    end

    -- avengers_shield

    if S.AvengersShield:IsReadyP() and Target:IsInRange(30) then
        return S.AvengersShield:Cast()
    end

    -- judgment,target_if=min:debuff.judgment.remains

    if S.Judgment:IsReadyP() and Target:IsInRange(30) and Target:DebuffRemains(S.JudgmentDebuff) < Player:GCD() then
        return S.Judgment:Cast()
    end

    -- vanquishers_hammer

    if S.VanquishersHammer:IsReadyP() and Target:IsInRange(30) then
        return S.VanquishersHammer:Cast()
    end

    -- consecration,if=!consecration.up

    if S.Consecration:IsReadyP() and not Player:Buff(S.ConsecrationBuff) and consecrationdrop then
        return S.Consecration:Cast()
    end

    -- divine_toll

    if S.DivineToll:IsReadyP() and Target:IsInRange(30) and RubimRH.CDsON() and
        (Player:BuffP(S.AvengingWrathBuff) or S.AvengingWrath:CooldownRemains() > 0) then
        return S.DivineToll:Cast()
    end


    -- blessed_hammer,strikes=2.4,if=charges=3

    if S.BlessedHammer:IsReadyP() and Cache.EnemiesCount[10] >= 1 and S.BlessedHammer:ChargesFractional() >= 2.9 then
        return S.BlessedHammer:Cast()
    end

    -- hammer_of_the_righteous,if=charges=2
    if S.HammeroftheRighteous:IsReadyP() and Cache.EnemiesCount[12] >= 1 and
        S.HammeroftheRighteous:ChargesFractional() >= 2.9 then
        return S.HammeroftheRighteous:Cast()
    end


    -- blessed_hammer,strikes=2.4

    if S.BlessedHammer:IsReadyP() and Cache.EnemiesCount[10] >= 1 then
        return S.BlessedHammer:Cast()
    end


    -- hammer_of_the_righteous
    if S.HammeroftheRighteous:IsReadyP() and Cache.EnemiesCount[10] >= 1 then
        return S.HammeroftheRighteous:Cast()
    end


    -- word_of_glory,if=buff.shining_light_free.up&!covenant.necrolord

    -- if S.WordofGlory:IsReadyP() and Player:BuffP(S.ShiningLight) and Cache.EnemiesCount[12]>=1
    -- -- and not S.Necrolord:IsAvailable() --waiting for shadowlands
    -- then
    -- return S.WordofGlory:Cast()
    -- end

    if S.Judgment:IsReadyP() and Target:IsInRange(30) then
        return S.Judgment:Cast()
    end
    -- consecration

    if S.Consecration:IsReadyP() and (consecrationdrop or Target:IsInRange(5) and Player:CanAttack(Target)) then
        return S.Consecration:Cast()
    end

    -- call precombat
    if not Player:AffectingCombat() then

        if S.WordofGlory:IsCastable() and Player:HealthPercentage() < 75 and
            (Player:HolyPower() >= 3 or Player:BuffP(S.DivinePurpose) or Player:BuffP(S.ShiningLight)) then
            return S.WordofGlory:Cast()
        end
        -- if S.CrusaderAura:IsCastable() and not Player:BuffP(S.CrusaderAura) then
        -- return S.CrusaderAura:Cast()
        -- end
        if S.DevotionAura:IsCastable() and not Player:BuffP(S.DevotionAura) then
            return S.DevotionAura:Cast()
        end
        if S.MomentofGlory:IsCastable() and Cache.EnemiesCount[25] >= 1 and RubimRH.CDsON() then
            return S.MomentofGlory:Cast()
        end


        -- if S.Steward:IsCastable() and I.phialofserenity:Count() <= 1 and Cache.EnemiesCount[20] == 0 then
        --     return S.Steward:Cast()
        -- end


        return 0, "Interface\\Addons\\Rubim-RH\\Media\\prot.tga"
    end

    return 0, 135328
end

RubimRH.Rotation.SetAPL(66, APL)

local function PASSIVE()


end

RubimRH.Rotation.SetPASSIVE(66, PASSIVE)
