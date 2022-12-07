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

RubimRH.Spell[70] = {



    BlessingofFreedom = Spell(1044),
    BlindingLight = Spell(115750),
    SenseUndead = Spell(5502),




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
    DivineResonance         = Spell(355455),
    FinalVerdictBuff            = Spell(337228),
    JudgmentDebuff              = Spell(197277),
    -- Pool

    -- Pool                                  = Spell(999910),
    Pool = Spell(397799),


    TemplarsVerdict = Spell(85256),
    -- Talents
    AshestoDust         = Spell(383300),
    BladeofJustice      = Spell(184575),
    BladeofWrath        = Spell(231832),
    Crusade             = Spell(231895), -- On-bar spell ID. Talent is a different ID for some reason.
    CrusadeTalent       = Spell(384392),
    DivineStorm         = Spell(53385),
    DivineToll          = Spell(375576),
    EmpyreanPower       = Spell(326732),
    ExecutionSentence   = Spell(343527),
    ExecutionersWrath   = Spell(387196),
    Exorcism            = Spell(383185),
    FinalReckoning      = Spell(343721),
    FiresofJustice      = Spell(203316),
    RadiantDecree       = Spell(383469),
    RadiantDecreeTalent = Spell(384052),
    RighteousVerdict    = Spell(267610),
    ShieldofVengeance   = Spell(184662),
    WakeofAshes         = Spell(255937),
    Zeal                = Spell(269569),
    -- Buffs
    CrusadeBuff         = Spell(231895),
    EmpyreanPowerBuff   = Spell(326733),
    -- Debuffs
    -- Legendary Effects
    FinalVerdict        = Spell(336872),
    --  RadiantDecreez                        = Spell(205191), --eyeforaneye











}

local S = RubimRH.Spell[70]
local G = RubimRH.Spell[1] -- General Skills

S.AvengingWrath.TextureSpellID = { 55748 }
S.Crusade.TextureSpellID = { 55748 }



-- Items
if not Item.Paladin then Item.Paladin = {} end

Item.Paladin.Retribution = {
    phialofserenity = Item(177278),
    tempest = Item(171416),
    HPIcon = Item(169451),
    tx1 = Item(118330),
    tx2 = Item(114616),
    healingpot = Item(187802),
    healingpoticon = Item(169451),
    healthstone = Item(5512), --health stone
    drums = Item(172233),
};
local I = Item.Paladin.Retribution;



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

local function ConsecrationTime()
    for i = 1, 5 do
        local active, totemName, startTime, duration, textureId = GetTotemInfo(i)
        if active == true then
            return startTime + duration - GetTime()
        end
    end
    return 0
end

local function ComputeTimeToHPG()
    local GCDRemains = Player:GCDRemains()
    local ShortestHPGTime = math.min(
        S.CrusaderStrike:CooldownRemains(),
        S.BladeofJustice:CooldownRemains(),
        S.Judgment:CooldownRemains(),
        S.HammerofWrath:IsUsable() and S.HammerofWrath:CooldownRemains() or 10, -- if not usable, return a dummy 10
        S.WakeofAshes:CooldownRemains()
    )

    if GCDRemains > ShortestHPGTime then
        return GCDRemains
    end

    return ShortestHPGTime
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

local VarDsCastable

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
    ConsecrationTime()
    ComputeTimeToHPG()
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

    allMobsinRange()
    tarSpeed, _, _, _ = GetUnitSpeed('target')
    consecrationdrop = Target:IsInRange(8) and
        (Player:MovingFor() <= Player:GCD() or (allMobsinRange(10) and tarSpeed == 0))

    TimeToHPG = ComputeTimeToHPG()
    -- Spell Queue
    if Player:IsChanneling() or Player:IsCasting() then
        return 0, "Interface\\Addons\\Rubim-RH\\Media\\channel.tga"
    end
    local start, duration = GetSpellCooldown('Radiant Decree')
    if S.RadiantDecree:IsAvailable() then
    end
    if S.LayonHands:IsReady() and Player:HealthPercentage() <= 20 and not Player:Debuff(S.Forbearance) and
        S.DivineShield:CooldownRemains() > Player:GCD() then
        return S.LayonHands:Cast()
    end
    covenantID = C_Covenants.GetActiveCovenantID()

    -- print(ConsecrationTime())
    -- if I.healthstone:IsReady() and I.healthstone:Count()>=1 and Player:HealthPercentage() <= 30 and Player:AffectingCombat() then
    -- return S.healthstone:Cast()
    -- end
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


    if S.ShieldofVengeance:IsCastable() and Player:HealthPercentage() <= 65 and Player:AffectingCombat() then
        return S.ShieldofVengeance:Cast()
    end
    if S.ShieldofVengeance:IsCastable() and Player:HealthPercentage() <= 85 and
        (Player:InArena() or Player:InBattlegrounds()) then
        return S.ShieldofVengeance:Cast()
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

    if S.FlashofLight:ID() == RubimRH.queuedSpell[1]:ID() and Player:BuffStackP(S.SelfLessHealerBuff) < 4 then
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


    -- if S.EyeforanEye:IsCastable() and S.EyeforanEye:IsAvailable() and Player:HealthPercentage() <= 75 and Cache.EnemiesCount[20]>=1 and not Player:BuffP(S.ShieldofVengeance) then
    -- return S.EyeforanEye:Cast()
    -- end

    if S.DivineShield:IsReady() and Player:HealthPercentage() <= 50 and not Player:Debuff(S.Forbearance) and
        not Player:BuffP(S.ShieldofVengeance) and Player:InArena() then
        return S.DivineShield:Cast()
    end

    if S.DivineShield:IsReady() and Player:HealthPercentage() <= 40 and not Player:Debuff(S.Forbearance) and
        not Player:BuffP(S.ShieldofVengeance) then
        return S.DivineShield:Cast()
    end

    if S.LayonHands:IsReady() and Player:HealthPercentage() <= 20 and not Player:Debuff(S.Forbearance) and
        not Player:InArena() and S.DivineShield:CooldownRemains() > Player:GCD() then
        return S.LayonHands:Cast()
    end

    if S.BlessingofProtection:IsReady() and not Player:BuffP(S.ShieldofVengeance) and Player:HealthPercentage() <= 35 and
        not Player:Debuff(S.Forbearance) and S.DivineShield:CooldownRemainsP() > Player:GCD() and
        S.LayonHands:CooldownRemainsP() > Player:GCD() and Cache.EnemiesCount[20] >= 1 then
        return S.BlessingofProtection:Cast()
    end

    if Player:CanAttack(Target) then

        Ranged = function()

            if Player:AffectingCombat() then
                -- if S.HammerofWrath:IsReadyP() and Target:IsInRange(30) and (Player:BuffP(S.AvengingWrath) or Player:BuffP(S.Crusade) or Target:HealthPercentage()<=20) then
                -- return S.HammerofWrath:Cast()
                -- end

                if S.BladeofJustice:IsCastable() and Target:IsInRange(15) then
                    return S.BladeofJustice:Cast()
                end

                if S.Judgment:IsCastable() and Target:IsInRange(30) then
                    return S.Judgment:Cast()
                end
            end

        end


        Cooldowns = function()


            -- use_item,name=spare_meat_hook


            -- avenging_wrath,if=(holy_power>=4&time<5|holy_power>=3
            -- &(time>5|runeforge.the_magistrates_judgment)|holy_power>=2&runeforge.vanguards_momentum&talent.final_reckoning|talent.holy_avenger&cooldown.holy_avenger.remains=0)
            -- &(!talent.seraphim|!talent.final_reckoning|cooldown.seraphim.remains>0)

            if S.AvengingWrath:IsReadyP()
                and (
                (Player:HolyPower() >= 4 and HL.CombatTime() < 5 or Player:HolyPower() >= 3
                    and (HL.CombatTime() > 5 or IsEquippedItem("The Magistrates Judgment")) or
                    Player:HolyPower() >= 2 and IsEquippedItem("Vanguard's Momentum") and S.FinalReckoning:IsAvailable()
                    or S.HolyAvenger:IsAvailable() and S.HolyAvenger:CooldownUp())
                    and
                    (
                    not S.Seraphim:IsAvailable() or not S.FinalReckoning:IsAvailable() or S.Seraphim:CooldownRemains() >
                        0)
                )
            then
                return S.AvengingWrath:Cast()
            end

            -- crusade,if=holy_power>=5&time<5|holy_power>=3&time>5
            if S.Crusade:IsReadyP() and
                (Player:HolyPower() >= 5 and HL.CombatTime() < 5 or Player:HolyPower() >= 4 and HL.CombatTime() > 5) then
                return S.Crusade:Cast()
            end

            -- ashen_hallow


            -- holy_avenger,if=time_to_hpg=0&holy_power<=2&(buff.avenging_wrath.up|talent.crusade&(cooldown.crusade.remains=0|buff.crusade.up)|fight_remains<20)

            if S.HolyAvenger:IsReadyP() and TimeToHPG > 0 and Player:HolyPower() <= 2
                and
                (
                Player:BuffP(S.AvengingWrath) or
                    S.Crusade:IsAvailable() and (S.Crusade:CooldownUp() or Player:Buff(S.Crusade)) or
                    Target:TimeToDie() < 20) then
                return S.HolyAvenger:Cast()
            end

            -- final_reckoning,if=(holy_power>=4&time<8|holy_power>=3&(time>=8|spell_targets.divine_storm>=2&covenant.kyrian))
            -- &(cooldown.avenging_wrath.remains>gcd|cooldown.crusade.remains&(!buff.crusade.up|buff.crusade.stack>=10))
            -- &(time_to_hpg>0|holy_power=5)&(!talent.seraphim|buff.seraphim.up)&(!raid_event.adds.exists|raid_event.adds.up|raid_event.adds.in>40)
            -- &(!buff.avenging_wrath.up|holy_power=5|cooldown.hammer_of_wrath.remains|spell_targets.divine_storm>=2&covenant.kyrian)
            if S.FinalReckoning:IsReadyP() and
                (
                (
                    Player:HolyPower() >= 4 and HL.CombatTime() < 8 or
                        Player:HolyPower() >= 3 and (HL.CombatTime() >= 8 or Cache.EnemiesCount[12] >= 2 and
                            covenantID == 1))
                    and
                    (
                    S.AvengingWrath:CooldownRemains() > Player:GCD() or
                        not S.Crusade:CooldownUp() and (not Player:Buff(S.Crusade) or Player:BuffStackP(S.Crusade) >= 10
                        ))
                    and (TimeToHPG > 0 or Player:HolyPower() == 5) and
                    (not S.Seraphim:IsAvailable() or Player:Buff(S.Seraphim))
                    and
                    (
                    not Player:BuffP(S.AvengingWrath) or Player:HolyPower() == 5 or not S.HammerofWrath:CooldownUp() or
                        Cache.EnemiesCount[12] >= 2 and covenantID == 1)) then
                return S.FinalReckoning:Cast()
            end

        end




        Finishers = function()


            -- variable,name=ds_castable,value=spell_targets.divine_storm>=2|buff.empyrean_power.up&!debuff.judgment.up&!buff.divine_purpose.up

            if (true) then
                VarDsCastable = (
                    (
                        Cache.EnemiesCount[12] >= 2 and I.tempest:IsEquipped() or
                            Cache.EnemiesCount[8] >= 2 and not I.tempest:IsEquipped())
                        or (Player:BuffP(S.EmpyreanPowerBuff)
                            and not Target:Debuff(S.JudgmentDebuff)
                            and not Player:BuffP(S.DivinePurposeBuff)
                            or
                            (
                            Cache.EnemiesCount[12] >= 2 and I.tempest:IsEquipped() or
                                Cache.EnemiesCount[8] >= 2 and not I.tempest:IsEquipped())
                            and Player:BuffP(S.Crusade)
                            and Player:BuffStackP(S.Crusade) < 10))
                    and RubimRH.AoEON()
            end

            -- seraphim,if=(cooldown.avenging_wrath.remains>15|cooldown.crusade.remains>15)&!talent.final_reckoning&(!talent.execution_sentence|spell_targets.divine_storm>=5)&(!raid_event.adds.exists|raid_event.adds.in>40|raid_event.adds.in<gcd|raid_event.adds.up)&(!covenant.kyrian|cooldown.divine_toll.remains<9)|fight_remains<15&fight_remains>5|buff.crusade.up&buff.crusade.stack<10

            if S.Seraphim:IsReadyP()
                and
                (
                (
                    (
                        not S.Crusade:IsAvailable() and Player:BuffP(S.AvengingWrath) or
                            S.AvengingWrath:CooldownRemainsP() > 25 or not RubimRH.CDsON())
                        or (Player:BuffP(S.Crusade) or S.Crusade:CooldownRemainsP() > 25 or not RubimRH.CDsON()))
                    -- and (not S.FinalReckoning:IsAvailable() or S.FinalReckoning:CooldownRemainsP()<10 or not RubimRH.CDsON())
                    and
                    (
                    not S.ExecutionSentence:IsAvailable() or S.ExecutionSentence:CooldownRemainsP() < 10 or
                        not RubimRH.CDsON())) then
                return S.Seraphim:Cast()
            end

            -- execution_sentence,if=(buff.crusade.down&cooldown.crusade.remains>10|buff.crusade.stack>=3|cooldown.avenging_wrath.remains>10)&(!talent.final_reckoning|cooldown.final_reckoning.remains>10)&target.time_to_die>8&(spell_targets.divine_storm<5|talent.executioners_wrath)

            if S.ExecutionSentence:IsReadyP() and RubimRH.CDsON() and
                (Cache.EnemiesCount[12] <= 3 or not RubimRH.AoEON()) and Target:IsInRange(30) and
                (
                (
                    not S.Crusade:IsAvailable() or Player:BuffDownP(S.Crusade) and S.Crusade:CooldownRemainsP() > 10 or
                        not RubimRH.CDsON()) or
                    Player:BuffStackP(S.Crusade) >= 3 or
                    S.AvengingWrath:CooldownRemainsP() > 10 or
                    Target:Debuff(S.FinalReckoning)) then
                return S.ExecutionSentence:Cast()
            end

            -- radiant_decree,if=(buff.crusade.down&cooldown.crusade.remains>5|buff.crusade.stack>=3|cooldown.avenging_wrath.remains>5)
            --&(!talent.final_reckoning|cooldown.final_reckoning.remains>5)
            if IsUsableSpell('Radiant Decree') and Player:HolyPower() >= 3 and S.RadiantDecree:CooldownUp() and
                Target:IsInRange(6)
                and
                (
                (
                    not Player:Buff(S.Crusade) or S.Crusade:CooldownRemainsP() > 5 or Player:BuffStackP(S.Crusade) >= 3
                        or S.AvengingWrath:CooldownRemains() > 5))
                and (not S.FinalReckoning:IsAvailable() or S.FinalReckoning:CooldownRemains() > 5)
            then
                return S.RadiantDecree:Cast()
            end


            -- divine_storm,if=variable.ds_castable&!buff.vanquishers_hammer.up&((!talent.crusade|cooldown.crusade.remains>gcd*3)&(!talent.execution_sentence|cooldown.execution_sentence.remains>gcd*6|cooldown.execution_sentence.remains>gcd*4&holy_power>=4|target.time_to_die<8|spell_targets.divine_storm>=5|!talent.seraphim&cooldown.execution_sentence.remains>gcd*2)&(!talent.final_reckoning|cooldown.final_reckoning.remains>gcd*6|cooldown.final_reckoning.remains>gcd*4&holy_power>=4|!talent.seraphim&cooldown.final_reckoning.remains>gcd*2)|talent.holy_avenger&cooldown.holy_avenger.remains<gcd*3|buff.holy_avenger.up|buff.crusade.up&buff.crusade.stack<10)

            if S.DivineStorm:IsReadyP() and Target:IsInRange(12)
                and VarDsCastable and not Player:Buff(S.VanquishersHammer)
                and
                ((not S.Crusade:IsAvailable() or S.Crusade:CooldownRemainsP() > Player:GCD() * 3 or not RubimRH.CDsON())
                    and
                    (
                    not RubimRH.CDsON() or not S.ExecutionSentence:IsAvailable() or
                        S.ExecutionSentence:CooldownRemainsP() > Player:GCD() * 3 or
                        (
                        Cache.EnemiesCount[12] >= 3 and I.tempest:IsEquipped() or
                            Cache.EnemiesCount[8] >= 3 and not I.tempest:IsEquipped()))
                    or
                    (
                    Cache.EnemiesCount[12] >= 2 and I.tempest:IsEquipped() or
                        Cache.EnemiesCount[8] >= 2 and not I.tempest:IsEquipped()) and
                    (
                    S.HolyAvenger:IsAvailable() and S.HolyAvenger:CooldownRemainsP() < Player:GCD() * 3 or
                        Player:BuffP(S.Crusade) and Player:BuffStackP(S.Crusade) < 10)) then
                return S.DivineStorm:Cast()
            end

            -- templars_verdict,if=(!talent.crusade|cooldown.crusade.remains>gcd*3)&(!talent.execution_sentence|cooldown.execution_sentence.remains>gcd*6|cooldown.execution_sentence.remains>gcd*4&holy_power>=4|target.time_to_die<8|!talent.seraphim&cooldown.execution_sentence.remains>gcd*2)&(!talent.final_reckoning|cooldown.final_reckoning.remains>gcd*6|cooldown.final_reckoning.remains>gcd*4&holy_power>=4|!talent.seraphim&cooldown.final_reckoning.remains>gcd*2)|talent.holy_avenger&cooldown.holy_avenger.remains<gcd*3|buff.holy_avenger.up|buff.crusade.up&buff.crusade.stack<10

            if S.TemplarsVerdict:IsReadyP() and Target:IsInRange(9)
                and
                ((not S.Crusade:IsAvailable() or S.Crusade:CooldownRemainsP() > Player:GCD() * 3 or not RubimRH.CDsON())
                    and
                    (
                    not RubimRH.CDsON() or not S.ExecutionSentence:IsAvailable() or
                        S.ExecutionSentence:CooldownRemainsP() > Player:GCD() * 3 and
                        (
                        (
                            Cache.EnemiesCount[15] <= 3 and I.tempest:IsEquipped() or
                                Cache.EnemiesCount[10] <= 3 and not I.tempest:IsEquipped()) or not RubimRH.AoEON()))
                    -- and (not S.FinalReckoning:IsAvailable() or S.FinalReckoning:CooldownRemainsP()>Player:GCD()*3 or not RubimRH.CDsON())
                    --	and (and not S.Necrolord:Convenant or S.VanquishersHammer:CooldownRemainsP()>Player:GCD())
                    or S.HolyAvenger:IsAvailable() and S.HolyAvenger:CooldownRemainsP() < Player:GCD() * 3 or
                    Player:BuffP(S.HolyAvenger) or Player:BuffP(S.Crusade) and Player:BuffStackP(S.Crusade) < 10 or
                    Player:BuffP(S.VanquishersHammer)) then
                return S.TemplarsVerdict:Cast()
            end
        end


        Generators = function()


            if RubimRH.AoEON() then
                --burst AOE

                if S.AvengingWrath:IsReadyP() and Player:BuffDownP(S.AvengingWrath) and RubimRH.CDsON()
                    and (Player:HolyPower() >= 3 or S.HolyAvenger:IsAvailable() and S.HolyAvenger:CooldownRemainsP() == 0
                    )
                    and Cache.EnemiesCount[15] >= 3 then
                    return S.AvengingWrath:Cast()
                end

                if S.Crusade:IsReadyP() and Player:BuffDownP(S.Crusade) and RubimRH.CDsON()
                    and (Player:HolyPower() >= 3 or S.HolyAvenger:IsAvailable()
                        and S.HolyAvenger:CooldownRemainsP() == 0) and Cache.EnemiesCount[15] >= 3 then
                    return S.Crusade:Cast()
                end

                if S.DivineToll:IsCastable() and RubimRH.CDsON() and Player:HolyPower() <= 2 and
                    Cache.EnemiesCount[15] >= 3
                    and not Player:PrevGCD(1, S.Judgment) then
                    return S.DivineToll:Cast()
                end

                if IsUsableSpell('Radiant Decree') and Player:HolyPower() >= 3 and S.RadiantDecree:CooldownUp() and
                    Target:IsInRange(6)
                    and
                    (
                    (
                        not Player:Buff(S.Crusade) or S.Crusade:CooldownRemainsP() > 5 or Player:BuffStackP(S.Crusade) >=
                            3 or S.AvengingWrath:CooldownRemains() > 5))
                    and (not S.FinalReckoning:IsAvailable() or S.FinalReckoning:CooldownRemains() > 5)
                then
                    return S.RadiantDecree:Cast()
                end

            end

            -- call_action_list,name=finishers,if=Player:HolyPower()=5|(debuff.judgment.up|Player:HolyPower()=4)&buff.divine_resonance.up|buff.holy_avenger.up
            if Player:HolyPower() >= 5 or
                (Target:Debuff(S.Judgment) or Player:HolyPower() >= 4) and Player:BuffP(S.DivineResonance) or
                Player:BuffP(S.HolyAvenger) then
                if Finishers() ~= nil then
                    return Finishers()
                end
            end

            -- vanquishers_hammer,if=!runeforge.dutybound_gavel|not S.FinalReckoning:IsAvailable()&!talent.execution_sentence|fight_remains<8
            if S.VanquishersHammer:IsReadyP()
                and (IsEquippedItem("Dutybound Gavel")
                    or S.FinalReckoning:IsAvailable()
                    and not S.ExecutionSentence:IsAvailable()
                    or Target:TimeToDie() < 8) then
                return S.VanquishersHammer:Cast()
            end

            -- hammer_of_wrath,if=runeforge.the_mad_paragon|covenant.venthyr&cooldown.ashen_hallow.remains>210
            -- if S.HammerofWrath:IsReady() and (IsEquippedItem("Mad Paragon") or covenantID == 2 and S.AshenHallow:CooldownRemains()>210) then
            --     return S.HammerofWrath:Cast()
            --     end

            -- wake_of_ashes,if=Player:HolyPower()<=2&talent.ashes_to_dust&(not S.AvengingWrath:CooldownUp() or not S.Crusade:CooldownUp())
            if S.WakeofAshes:IsReadyP() and RubimRH:CDsON() and Target:IsInRange(6) and Player:HolyPower() <= 2 and
                S.AshestoDust:IsAvailable() and (not S.AvengingWrath:CooldownUp() or not S.Crusade:CooldownUp()) then
                return S.WakeofAshes:Cast()
            end

            -- divine_toll,if=Player:HolyPower()<=2&!debuff.judgment.up&(!talent.seraphim|buff.seraphim.up)
            --&(!raid_event.adds.exists|raid_event.adds.in>30|raid_event.adds.up)
            --&not S.FinalReckoning:IsAvailable()&(!talent.execution_sentence|fight_remains<8|spell_targets.divine_storm>=5)
            --&(cooldown.avenging_wrath.remains>15|cooldown.crusade.remains>15|fight_remains<8)
            if S.DivineToll:IsCastable() and RubimRH.CDsON() and (
                Player:HolyPower() <= 2 and not Target:Debuff(S.JudgmentDebuff) and
                    (not S.Seraphim:IsAvailable() or Player:Buff(S.Seraphim))
                    and Cache.EnemiesCount[15] >= 1
                    and not S.FinalReckoning:IsAvailable() and
                    (not S.ExecutionSentence:IsAvailable() or Target:TimeToDie() < 8 or Cache.EnemiesCount[15] >= 5)
                    and (S.AvengingWrath:CooldownRemains() > 15 or S.Crusade:CooldownRemains() > 15 or
                        Target:TimeToDie() < 8)) then
                return S.DivineToll:Cast()
            end


            -- judgment,if=!debuff.judgment.up&(Player:HolyPower()>=1&runeforge.the_magistrates_judgment|Player:HolyPower()>=2)
            if S.Judgment:IsReadyP() and Target:IsInRange(20) and not Target:Debuff(S.JudgmentDebuff) and
                (Player:HolyPower() >= 1 and IsEquippedItem("Magistrates Judgment") or Player:HolyPower() >= 2) then
                return S.Judgment:Cast()
            end

            -- wake_of_ashes,if=(Player:HolyPower()=0|Player:HolyPower()<=2&S.BladeofJustice:CooldownRemains()>gcd*2)
            --&(!raid_event.adds.exists|raid_event.adds.in>20|raid_event.adds.up)&(!talent.seraphim|cooldown.seraphim.remains>5|covenant.kyrian)
            --&(!talent.execution_sentence|S.ExecutionSentence:CooldownRemains()>15|target.time_to_die<8|spell_targets.divine_storm>=5)
            --&(not S.FinalReckoning:IsAvailable()|S.FinalReckoning:CooldownRemains()>15|fight_remains<8)&(not S.AvengingWrath:CooldownUp() or not S.Crusade:CooldownUp())

            if S.WakeofAshes:IsReadyP() and RubimRH:CDsON() and Target:IsInRange(6)
                and (
                (
                    Player:HolyPower() == 0 or
                        Player:HolyPower() <= 2 and S.BladeofJustice:CooldownRemainsP() > Player:GCD() * 2)
                    and (not S.Seraphim:IsAvailable() or S.Seraphim:CooldownRemains() > 5 or covenantID == 1)
                    and
                    (
                    not S.ExecutionSentence:IsAvailable() or S.ExecutionSentence:CooldownRemainsP() > 15 or
                        Target:TimeToDie() < 8 or Cache.EnemiesCount[12] >= 5)
                    and
                    (
                    not S.FinalReckoning:IsAvailable() or S.FinalReckoning:CooldownRemainsP() > 15 or
                        Target:TimeToDie() < 8)
                    and (not S.AvengingWrath:CooldownUp() or not S.Crusade:CooldownUp())
                )
            then
                return S.WakeofAshes:Cast()
            end


            -- call_action_list,name=finishers,if=Player:HolyPower()>=3&buff.crusade.up&buff.crusade.stack<10
            if Player:HolyPower() >= 3 and Player:Buff(S.Crusade) and Player:BuffStackP(S.Crusade) < 10 then
                if Finishers() ~= nil then
                    return Finishers()
                end
            end

            -- exorcism
            if S.Exorcism:IsReadyP() and Target:IsInRange(6) then
                return S.Exorcism:Cast()
            end

            -- blade_of_justice,if=conduit.expurgation&Player:HolyPower()<=3
            if S.BladeofJustice:IsReadyP() and Target:IsInRange(12)

                and Player:HolyPower() <= 3 then
                return S.BladeofJustice:Cast()
            end

            -- judgment,if=!debuff.judgment.up
            if S.Judgment:IsReadyP() and Target:IsInRange(20) and not Target:Debuff(S.JudgmentDebuff) then
                return S.Judgment:Cast()
            end

            -- hammer_of_wrath
            -- if S.HammerofWrath:IsCastable() and Target:IsInRange(20) then
            --     return S.HammerofWrath:Cast()
            --     end


            -- blade_of_justice,if=Player:HolyPower()<=3
            if S.BladeofJustice:IsReadyP() and Target:IsInRange(12)
                and Player:HolyPower() <= 3 then
                return S.BladeofJustice:Cast()
            end


            -- call_action_list,name=finishers,if=(target.health.pct<=20|buff.avenging_wrath.up|buff.crusade.up|buff.empyrean_power.up)
            if (
                Target:HealthPercentage() <= 20 or Player:BuffP(S.AvengingWrath) or Player:BuffP(S.Crusade) or
                    Player:BuffP(S.EmpyreanPowerBuff)) then
                if Finishers() ~= nil then
                    return Finishers()
                end
            end

            -- consecration,if=!consecration.up&spell_targets.divine_storm>=2
            if S.Consecration:IsReadyP() and consecrationdrop and ConsecrationTime() < Player:GCD()
            then
                return S.Consecration:Cast()
            end

            -- crusader_strike,if=cooldown.crusader_strike.charges_fractional>=1.75&(Player:HolyPower()<=2|Player:HolyPower()<=3&S.BladeofJustice:CooldownRemains()>gcd*2|Player:HolyPower()=4&S.BladeofJustice:CooldownRemains()>gcd*2&cooldown.judgment.remains>gcd*2)

            if S.CrusaderStrike:IsReady() and Target:IsInRange(9)
                and (S.CrusaderStrike:ChargesFractional() >= 1.75
                    and
                    (
                    Player:HolyPower() <= 2 or
                        Player:HolyPower() <= 3 and S.BladeofJustice:CooldownRemainsP() > Player:GCD() * 2 or
                        Player:HolyPower() == 4 and S.BladeofJustice:CooldownRemainsP() > Player:GCD() * 2 and
                        S.Judgment:CooldownRemainsP() > Player:GCD() * 2)) then
                return S.CrusaderStrike:Cast()
            end

            -- call_action_list,name=finishers
            if Finishers() ~= nil then
                return Finishers()
            end

            -- consecration,if=!consecration.up
            if S.Consecration:IsReadyP() and consecrationdrop and ConsecrationTime() < Player:GCD()
            then
                return S.Consecration:Cast()
            end

            -- crusader_strike
            if S.CrusaderStrike:IsReadyP() and Target:IsInRange(8)
            then
                return S.CrusaderStrike:Cast()
            end

            -- arcane_torrent
            -- if S.ArcaneTorrent:IsReadyP() and Target:IsInRange(8) and Cache.EnemiesCount[12]>=1
            -- then
            --            return S.ArcaneTorrent:Cast()
            --            end

            -- consecration
            if S.Consecration:IsReadyP() and consecrationdrop
            then
                return S.Consecration:Cast()
            end

        end

        if select(8, UnitCastingInfo("target")) == false and Target:CastPercentage() > math.random(43, 87) and
            RubimRH.InterruptsON() and S.Rebuke:IsReady(8) and Player:AffectingCombat() then
            return S.Rebuke:Cast()
        end

        if not Target:IsInRange(10) then
            if Ranged() ~= nil then
                return Ranged()
            end
        end

        --actions+=/call_action_list,name=cooldowns
        if Target:IsInRange(10) and RubimRH.CDsON() then
            if Cooldowns() ~= nil then
                return Cooldowns()
            end
        end

        --actions+=/call_action_list,name=generators
        if Generators() ~= nil then
            return Generators()
        end

    end
    -- Out of Combat
    if not Player:AffectingCombat() then


        if RubimRH.QueuedSpell():IsReadyQueue() then
            return RubimRH.QueuedSpell():Cast()
        end

        if S.FlashofLight:IsCastable() and Player:HealthPercentage() < 85 and Player:BuffStackP(S.SelfLessHealerBuff) ==
            4 and Cache.EnemiesCount[15] == 0 then
            return S.FlashofLight:Cast()
        end

        -- if S.DevotionAura:IsCastable() and not Player:BuffP(S.DevotionAura) then
        -- return S.DevotionAura:Cast()
        -- end
        if S.RetributionAura:IsCastable() and not Player:BuffP(S.RetributionAura) then
            return S.RetributionAura:Cast()
        end

        -- if I.healthstone:IsReady() and Player:HealthPercentage() <= 50 then
        -- return S.healthstone:Cast()
        -- end

        -- if I.healingpot:IsReady() and Player:HealthPercentage() <= 30 then
        -- return S.healingpot:Cast()
        -- end


        -- if S.Steward:IsCastable() and I.phialofserenity:Count() <= 1 and Cache.EnemiesCount[20] == 0 then
        --     return S.Steward:Cast()
        -- end

        if not RubimRH.queuedSpell[1]:CooldownUp() or Cache.EnemiesCount[20] == 0 or not Player:AffectingCombat() then
            RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
        end

        return 0, "Interface\\Addons\\Rubim-RH\\Media\\prot.tga"

    end

    return 0, 135328
end

RubimRH.Rotation.SetAPL(70, APL);

local function PASSIVE()

end

RubimRH.Rotation.SetPASSIVE(70, PASSIVE);
