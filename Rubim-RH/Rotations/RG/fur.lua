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
local MultiSpell = HL.MultiSpell;

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
    SummarilyDispatched    = Spell(381990),
    KeepitRolling          = Spell(381989),
    ShadowRunner           = Spell(378807),
    Audacity               = Spell(381845),
    AudacityBuff           = Spell(386270),
    SubterfugeBuff         = Spell(115192),
    SubterfugeStealthBuff  = Spell(115191),
    SubterfugeVanishBuff   = Spell(115193),
    Subterfuge             = Spell(108208),
    ThistleTea             = Spell(381623),
    HiddenOpportunity      = Spell(383281),
    autoattack             = Spell(274738), -- ancestral call
    ImprovedBetweentheEyes = Spell(235484),
    Penance                = Spell(47540),
    ColdBlood              = Spell(382245),
    ShadowDance            = Spell(185313),
    ShadowDanceBuff        = Spell(185422),
    ClosestTarget          = Spell(256948), -- spatial rift
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
    DeftManeuvers          = Spell(381878),
    AcrobaticStrikes       = Spell(196924),
    Sepsis = Spell(385408),--check if this is buff or just talent/spell
    --Dungeons
    --Enrage
    LoadedDiceBuff         = Spell(256171),
    ViciousFollowup        = Spell(394879),
    EchoingReprimand       = Spell(385616),
    EchoingReprimandCP2    = Spell(323558),
    EchoingReprimandCP3    = Spell(323559),
    EchoingReprimandCP4    = Spell(323560),
    EchoingReprimandCP5    = Spell(354838),
    BladeRush              = Spell(271877),
    CripplingPoison        = Spell(3408),
    AtrophicPoison         = Spell(381637),
    InstantPoison          = Spell(315584),
    NumbingPoison          = Spell(5761),
    lust1                  = Spell(57724),
    lust2                  = Spell(57723),
    lust3                  = Spell(80354),
    lust4                  = Spell(95809),
    ImprovedAdrenalineRush = Spell(395422),
    lust5                  = Spell(264689),
    FantheHammer           = Spell(381846),
    SwiftSlasher           = Spell(381988),
    CounttheOdds           = Spell(381982),
    Dreadblades            = Spell(343142),
    KidneyShot             = Spell(408),
    Deadshot               = Spell(272935),
    Berserking             = Spell(26297),
    Darkflight             = Spell(68992),
    Distract               = Spell(1725),
    lustAT                 = Spell(155145), --arcane torrent
    WaterStrider           = Spell(118089),
    BugMount               = Spell(243795),
    razorcoral             = Spell(303568),
    ConductiveInk          = Spell(302565),
    AdrenalineRush         = Spell(13750),
    Ambush                 = Spell(8676),
    BetweentheEyes         = Spell(315341),
    BladeFlurry            = Spell(13877),
    Shadowmeld             = Spell(135201),
    DeviousStratagem       = Spell(394321),
    Opportunity            = Spell(195627),
    PistolShot             = Spell(185763),
    RolltheBones           = Spell(315508),
    Dispatch               = Spell(2098),
    SinisterStrike         = Spell(193315),
    ImprovedAmbush         = Spell(381620),
    -- Stealth                = Spell(1784),
    Stealth   = MultiSpell(115191,1784),
    FindWeakness           = Spell(91023),
    FindWeaknessDebuff     = Spell(316220),
    Vanish                 = Spell(1856),
    VanishBuff             = Spell(11327),
    Shiv                   = Spell(5938),
    -- Riposte = Spell(199754), -- evasion
    WilloftheForsaken      = Spell(7744),
    CloakofShadows         = Spell(31224),
    Alacrity               = Spell(193539),
    AlacrityBuff           = Spell(193538),
    Anticipation           = Spell(114015),
    CannonballBarrage      = Spell(185767),
    DeathfromAbove         = Spell(152150),
    DeeperStratagem        = Spell(193531),
    DirtyTricks            = Spell(108216),
    GhostlyStrike          = Spell(196937),
    KillingSpree           = Spell(51690),
    MarkedforDeath         = Spell(137619),
    QuickDraw              = Spell(196938),
    GreenSkinsWickers      = Spell(386823), --386823 --394131
    GreenSkinsWickersBuff  = Spell(394131),
    SliceandDice           = Spell(315496),
    Vigor                  = Spell(14983),
    Exhaustion             = Spell(57723),
    Blind                  = Spell(2094),
    Blunderbuss            = Spell(202895),
    CurseoftheDreadblades  = Spell(202665),
    HiddenBlade            = Spell(202754),
    LoadedDice             = Spell(256170),
    DeadshotBuff           = Spell(272940),
    AceUpYourSleeve        = Spell(278676),
    SnakeEyes              = Spell(275846),
    SnakeEyesBuff          = Spell(275863),
    CheapShot              = Spell(1833),
    CrimsonVial            = Spell(185311),
    Feint                  = Spell(1966),
    Gouge                  = Spell(1776),
    Kick                   = Spell(1766),
    Sprint                 = Spell(2983),
    Broadside              = Spell(193356),
    BuriedTreasure         = Spell(199600),
    GrandMelee             = Spell(193358),
    SkullandCrossbones     = Spell(199603),
    GCBoon                 = Spell(20572),
    RuthlessPrecision      = Spell(193357),
    TrueBearing            = Spell(193359),
    Evasion                = Spell(5277),
    WoundPoison            = Spell(8679),
}

local S = RubimRH.Spell[260]

if not Item.Rogue then Item.Rogue = {}; end

Item.Rogue.Outlaw = {
    trink = Item(184016, { 13, 14 }),
    drums = Item(193470),
    HPIcon = Item(169451),
    tx1 = Item(118330),
    tx2 = Item(114616),
    HPpotID = Item(191380),
};

local I = Item.Rogue.Outlaw;

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

local function TargetTTD()
    local currHealth = {}
    local currHealthMax = {}
    local allGUID = {}
    local areaTTD = {}
    local areaTTD_Predicted = {}
    local areaDPS = {}
    local count = 1
    local highest = 0

    for id = 1, 40 do
        local unitID = "nameplate" .. id
        if UnitCanAttack("player", unitID)
            and ((UnitHealth(unitID) / UnitHealthMax(unitID)) * 100) < 100 then
            if UnitGUID('Target') then
                currTarget = UnitGUID('Target')
            end

            table.insert(allGUID, UnitGUID(unitID))
            table.insert(currHealth, UnitHealth(unitID))
            table.insert(currHealthMax, UnitHealthMax(unitID))

            if #allGUID >= 1 and UnitGUID('Target') then
                while (UnitGUID('Target') ~= allGUID[count]) do
                    count = count + 1
                    break
                end
            end

            if #currHealthMax >= 1 then
                for id = 1, #currHealthMax do
                    dps = (currHealthMax[#currHealth] - currHealth[#currHealth]) /
                        HL.CombatTime("nameplate" .. #currHealthMax)
                    if #currHealthMax ~= count then
                        areaTTD[#currHealthMax] = currHealth[#currHealth] / dps
                        --areaTTD_Predicted[#currHealthMax] = currHealth[#currHealth] / (dps + playerDPS)
                    else
                        areaTTD_Predicted[#currHealthMax] = currHealth[#currHealth] / dps
                    end
                end
            end
        end
    end
    if target_is_dummy() then
        return 8675309
    elseif #currHealthMax >= 1 and areaTTD_Predicted[count] then
        return areaTTD_Predicted[count]
    else
        return 1
    end
end

local function mitigate()
    if Player:AffectingCombat() then
        for id = 1, 40 do
            local spell = {

                'Decay Spray', 'Gushing Ooze',                                                     --BH
                'Static Surge', 'Hailstorm', "Tempest's Fury", 'Deep Chill', 'Overpowering Croak', --halls of infusion
                'Shatter',                                                                         --neltharions lair
                'Magma Eruption', 'Might of the Forge', 'Volatile Mutation', 'Candescent Tempest', -- neltharus
                'Shocking Quake', 'Crushing Stomp', 'Thunderous Clap', 'Wing Buffet',              -- Uldaman
                'Tantrum', 'Festering Harvest',                                                    --underrot
                'Cyclone Shield', 'Skyfall Nova',                                                  --VP
                'Shattering Bellow',                                                               -- freehold
            }
            local unitID = "nameplate" .. id
            local name, text, texture, startTimeMS, endTimeMS, isTradeSkill, castID, notInterruptible, spellId =
                UnitCastingInfo(unitID)
            local spellName, _, _, startTimeMS, endTimeMS = UnitChannelInfo(unitID)

            for idx = 1, #spell do
                if UnitCanAttack("player", unitID) and (name == spell[idx] or spellName == spell[idx]) then
                    return true
                end
            end
        end
    end
    return false
end



local function CPMaxSpend()
    if S.DeeperStratagem:IsAvailable() and S.DeviousStratagem:IsAvailable() then
        return 7
    elseif S.DeeperStratagem:IsAvailable() and not S.DeviousStratagem:IsAvailable() or not S.DeeperStratagem:IsAvailable() and S.DeviousStratagem:IsAvailable() then
        return 6
    else
        return 5
    end
end

--- ======= ACTION LISTS =======
local RtB_BuffsList = {
    S.Broadside,
    S.BuriedTreasure,
    S.GrandMelee,
    S.RuthlessPrecision,
    S.SkullandCrossbones,
    S.TrueBearing
}

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

local function EnergyTimeToMaxRounded()
    return math.floor(Player:EnergyTimeToMaxPredicted() * 10 + 0.5) / 10;
end
-- Get the number of Roll the Bones buffs currently on
-- Get the number of Roll the Bones buffs currently on
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

-- RtB rerolling strategy, return true if we should reroll
local function RtB_Reroll()
    if not Cache.APLVar.RtB_Reroll then
        RtB_Buffs() -- Update cache

        -- Rule 0: Never reroll Skull and Crossbones
        if Player:BuffRemains(S.SkullandCrossbones) >= 2 or RtB_Buffs() >= 3 or RtB_Buffs() == 2 and Player:Buff(S.GrandMelee)
            and Player:Buff(S.SkullandCrossbones) or RtB_Buffs() == 2 and not Player:Buff(S.GrandMelee) then
            Cache.APLVar.RtB_Reroll = false
        elseif RtB_Buffs() == 0 or RtB_Buffs() == 2 and Player:Buff(S.GrandMelee) and not Player:Buff(S.SkullandCrossbones) 
        or RtB_Buffs()==1 and RtB_BuffRemains()<2
        then
            Cache.APLVar.RtB_Reroll = true
        else
            -- Rule 1: Reroll any single buff that is not Skull and Crossbones
            local shouldRerollSingleBuff = RtB_Buffs() == 1

            -- Rule 2: Reroll any 2 buffs that contains Grand Melee, except for Skull and Crossbones + Grand Melee
            local shouldRerollDoubleBuff = RtB_Buffs() == 2 and Player:Buff(S.GrandMelee)

            -- With Hidden Opportunity, prioritize rerolling for Skull and Crossbones over everything else
            local willLoseSkullAndCrossbones = S.HiddenOpportunity:IsAvailable() and
                (not Player:Buff(S.SkullandCrossbones)
                    or Player:BuffRemains(S.SkullandCrossbones) <= RubimRH.RtBRemains())
            local notInShadowDanceOrSubterfuge = not Player:Buff(S.ShadowDanceBuff) and not Player:Buff(S.SubterfugeBuff)

            Cache.APLVar.RtB_Reroll = shouldRerollSingleBuff or shouldRerollDoubleBuff or
                (willLoseSkullAndCrossbones and notInShadowDanceOrSubterfuge)

            -- If you don't need to reroll according to the above conditions and you have either Keep it Rolling or Count the Odds, check for additional reroll conditions
            --
        end
    end

    return Cache.APLVar.RtB_Reroll
end

local function kickprio()
    -- list of m+ abilities that should be kicked
    local KickSpells = {


    }

    local currentspellchannel = select(1, UnitChannelInfo('target'))
    local currentspellcast = select(1, UnitCastingInfo('target'))

    for i = 1, #KickSpells do
        if currentspellcast == KickSpells[i] or currentspellchannel == KickSpells[i] then
            return true
        end
    end

    return false
end

local function stunprio()
    -- list of m+ abilities that should be stunned
    local stunspells = {


    }

    local currentspellchannel = select(1, UnitChannelInfo('target'))
    local currentspellcast = select(1, UnitCastingInfo('target'))

    for i = 1, #stunspells do
        if currentspellcast == stunspells[i] or currentspellchannel == stunspells[i] then
            return true
        end
    end

    return false
end


local function blindprio()
    -- list of m+ abilities that should be stunned
    local blindspells = {

    }

    local currentspellchannel = select(1, UnitChannelInfo('target'))
    local currentspellcast = select(1, UnitCastingInfo('target'))

    for i = 1, #blindspells do
        if currentspellcast == blindspells[i] or currentspellchannel == blindspells[i] then
            return true
        end
    end

    return false
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

local function APL()
    -- kickprio()
    -- stunprio()
    -- blindprio()
    TargetTTD()
    mitigate()
print(S.Dispatch:IsCastable())
    HL.GetEnemies(8, true);
    HL.GetEnemies(10, true);
    HL.GetEnemies(12, true);
    HL.GetEnemies(20, true);
    HL.GetEnemies(25, true);
    HL.GetEnemies(30, true);

    IsTanking = (Player:IsTankingAoE(8) or Player:IsTanking(Target))

    local level, affixIDs, wasEnergized = C_ChallengeMode.GetActiveKeystoneInfo()
    highkey = 10

    castchannelTime = math.random(275, 500) / 1000
    local startTimeMS = select(4, UnitCastingInfo('target')) or 0
    local currentTimeMS = GetTime() * 1000
    local elapsedTimeca = (startTimeMS > 0) and (currentTimeMS - startTimeMS) or 0
    castTime = elapsedTimeca / 1000
    local startTimeMS = select(4, UnitCastingInfo('target')) or select(4, UnitChannelInfo('target')) or 0
    local currentTimeMS = GetTime() * 1000
    local elapsedTimech = (startTimeMS > 0) and (currentTimeMS - startTimeMS) or 0
    channelTime = elapsedTimech / 1000

    HPpercentloss = MyHealthTracker.GetPredictedHealthLoss() * 3

    --------------------------------------------------------------------------------------------------------------------------------------------------------
    -------------------------------------------------------------Functions/Top Priorities-------------------------------------------------------------------
    --------------------------------------------------------------------------------------------------------------------------------------------------------
    if Player:IsCasting() or Player:IsChanneling() then
        return 0, "Interface\\Addons\\Rubim-RH\\Media\\channel.tga"
    elseif Player:IsDeadOrGhost() or AuraUtil.FindAuraByName("Drink", "player") or AuraUtil.FindAuraByName("Food", "player") or AuraUtil.FindAuraByName("Food & Drink", "player") or AuraUtil.FindAuraByName("Shroud of Concealment", "player") then
        return 0, "Interface\\Addons\\Rubim-RH\\Media\\mount2.tga"
    end

    local trinket1 = GetInventoryItemID("player", 13)
    local trinket2 = GetInventoryItemID("player", 14)
    local trinket1ready = IsUsableItem(trinket1) and GetItemCooldown(trinket1) == 0 and IsEquippedItem(trinket1)
    local trinket2ready = IsUsableItem(trinket2) and GetItemCooldown(trinket2) == 0 and IsEquippedItem(trinket2)

    SnDAS = select(16, AuraUtil.FindAuraByName("Slice and Dice", "player"))

    if SnDAS == nil then
        SnDAS = 0
    end

    if S.SwiftSlasher:IsAvailable() then
        maxsndpercent = 50 + CPMaxSpend() * 2
    else
        maxsndpercent = 50
    end

    if S.FantheHammer:IsAvailable() then
        fthrank = 2
    else
        fthrank = 0
    end

    if  AuraUtil.FindAuraByName("Stealth", "player") or  Player:Buff(S.VanishBuff) then
        stealthbasic = true
    else
        stealthbasic = false
    end

    if  AuraUtil.FindAuraByName("Stealth", "player") or  Player:Buff(S.VanishBuff) 
    or Player:Buff(S.SubterfugeBuff) or Player:Buff(S.ShadowDanceBuff) then
        stealthall = true
    else
        stealthall = false
    end


    if Player:BuffP(S.EchoingReprimandCP2) or Player:BuffP(S.EchoingReprimandCP3) or Player:BuffP(S.EchoingReprimandCP4) or Player:BuffP(S.EchoingReprimandCP5) then
        erbuff = true
    else
        erbuff = false
    end

    if (Player:BuffP(S.EchoingReprimandCP2) and Player:ComboPoints() == 2) or (Player:BuffP(S.EchoingReprimandCP3) and Player:ComboPoints() == 3) or (Player:BuffP(S.EchoingReprimandCP4) and Player:ComboPoints() == 4) or (Player:BuffP(S.EchoingReprimandCP5) and Player:ComboPoints() == 5) then
        ercp = true
    else
        ercp = false
    end

    if ercp == true then
        effective_combo_points = 7
    else
        effective_combo_points = Player:ComboPoints()
    end

    if Player:Buff(S.Broadside) or Player:Buff(S.Opportunity) then
        finishCPminus = 1
    else
        finishCPminus = 0
    end

    if UnitClassification("target") == "worldboss" or UnitClassification("target") == "rareelite" or UnitClassification("target") == "elite"
    or UnitClassification("target") == "rare" or target_is_dummy() or Target:IsAPlayer() then
        elite = true
    else
        elite = false
    end

    if true then
        stealthedcto = (S.CounttheOdds:IsAvailable() and
            (stealthbasic or Player:Buff(S.Shadowmeld) or Player:Buff(S.ShadowDanceBuff)))

        ambushcondition = (Player:Energy() >= 50 and
            (S.HiddenOpportunity:IsAvailable() or Player:Buff(S.ViciousFollowup) or
                Player:ComboPointsDeficit() >= 2 + num(S.ImprovedAmbush:IsAvailable()) + num(Player:Buff(S.Broadside))))

        -- # Finish at 6 (5 with Summarily Dispatched talented) CP or CP Max-1, whichever is greater of the two

        -- actions+=/variable,name=finish_condition,value=combo_points>=((cp_max_spend-1)<?(6-talent.summarily_dispatched))|effective_combo_points>=cp_max_spend
        finishcondition = (Player:ComboPoints() >=
            math.max(CPMaxSpend() - 1, 6 - num(S.SummarilyDispatched:IsAvailable()))
            or effective_combo_points >= CPMaxSpend())

        -- if Player:BuffP(S.Broadside) or Player:BuffP(S.Opportunity) or Player:BuffP(S.AudacityBuff) then
        --     finishcondition = effective_combo_points >= CPMaxSpend() - 1
        -- else
        --     finishcondition = effective_combo_points >= CPMaxSpend()
        -- end



        vanishcondition = (S.HiddenOpportunity:IsAvailable() or not S.ShadowDance:IsAvailable() or not S.ShadowDance:CooldownUp())

        if S.DeftManeuvers:IsAvailable() and S.AcrobaticStrikes:IsAvailable() then
            bfrange = 12
        else
            bfrange = 10
        end

        bladeflurrysync = (Cache.EnemiesCount[bfrange] < 2 or
            (Player:BuffRemainsP(S.BladeFlurry) > 1 + num(S.KillingSpree:IsAvailable())))

        mfdcondition = (Player:ComboPoints() >=
            CPMaxSpend() -
            (num(Player:BuffP(S.Broadside)) + num(Player:BuffP(S.Opportunity)) * num(S.QuickDraw:IsAvailable())) and
            S.MarkedforDeath:IsCastable(10))

        killing_spree_vanish_sync = (not IsEquippedItem("Sigil of the Master Assassin") or S.Vanish:CooldownRemainsP() > 10)
        -- variable,name=vanish_opportunity_condition,value=!talent.shadow_dance&talent.fan_the_hammer.rank+talent.quick_draw+talent.audacity<talent.count_the_odds+talent.keep_it_rolling

    end
    --------------------------------------------------------------------------------------------------------------------------------------------------------
    -----------------------------------------------------------------Spell Queue----------------------------------------------------------------------------
    --------------------------------------------------------------------------------------------------------------------------------------------------------
    if not RubimRH.queuedSpell[1]:CooldownUp() then
        RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
    end

    if S.lustAT:ID() == RubimRH.queuedSpell[1]:ID() and (Player:Debuff(S.lust1) or Player:Debuff(S.lust2) or Player:Debuff(S.lust3) or Player:Debuff(S.lust4) or Player:Debuff(S.lust5)) then
        RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
    end

    if S.lustAT:ID() == RubimRH.queuedSpell[1]:ID() and not Player:Debuff(S.lust1) and not Player:Debuff(S.lust2) and not Player:Debuff(S.lust3) and not Player:Debuff(S.lust4) and not Player:Debuff(S.lust5) and IsUsableItem(193470) and GetItemCooldown(193470) == 0 then
        return S.lustAT:Cast() -- BIND LUST KEYBIND IN BINDPAD TO ARCANE TORRENT
    end

    if S.KidneyShot:ID() == RubimRH.queuedSpell[1]:ID() and (Target:Debuff(S.CheapShot) or Target:Debuff(S.KidneyShot) or Target:Debuff(S.Blind) or Target:Debuff(S.Gouge)) then
        RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
    end

    if S.Gouge:ID() == RubimRH.queuedSpell[1]:ID() and (Target:Debuff(S.CheapShot) or Target:Debuff(S.KidneyShot) or Target:Debuff(S.Blind)) then
        RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
    end

    if RubimRH.QueuedSpell():IsReadyQueue() and S.ShadowDance:ID() ~= RubimRH.queuedSpell[1]:ID() then
        return RubimRH.QueuedSpell():Cast()
    end




    --------------------------------------------------------------------------------------------------------------------------------------------------------
    -----------------------------------------------------------------Explosives------------------------------------------------------------------------------
    --------------------------------------------------------------------------------------------------------------------------------------------------------
    if S.PistolShot:IsCastable() and UnitName('target') == 'Explosives' then
        return S.PistolShot:Cast()
    end
    -- if S.KidneyShot:IsReady(8) and UnitName('target') == 'Spiteful Shade' and Player:ComboPoints()>=4 then
    --     return S.KidneyShot:Cast()
    -- end
    --------------------------------------------------------------------------------------------------------------------------------------------------------
    -----------------------------------------------------------------Interrupts-----------------------------------------------------------------------------
    --------------------------------------------------------------------------------------------------------------------------------------------------------
    -- Kick
    if not AuraUtil.FindAuraByName("Stealth", "player") and Player:CanAttack(Target) then
        if (castTime > castchannelTime or channelTime > castchannelTime) and
            RubimRH.InterruptsON() and S.Kick:IsReady(8) and Player:AffectingCombat() and select(8, UnitCastingInfo("target")) == false
        -- and kickprio()
        then
            return S.Kick:Cast()
        end


        --Stun

        -- if (castTime>castchannelTime or channelTime>castchannelTime)
        -- and RubimRH.InterruptsON() and S.KidneyShot:IsReady(8) and Player:AffectingCombat() and stunprio() then
        -- return S.KidneyShot:Cast()
        -- end


        --Blind

        -- if (castTime>castchannelTime or channelTime>castchannelTime)
        -- and RubimRH.InterruptsON() and S.Blind:IsReady(15) and Player:AffectingCombat() and blindprio() then
        -- return S.Blind:Cast()
        -- end


        local isEnraged = (AuraUtil.FindAuraByName("Enrage", "target") or UnitChannelInfo("target") == "Ragestorm" or AuraUtil.FindAuraByName("Frenzy", "target"))


        if (isEnraged and RubimRH.InterruptsON() and S.Shiv:IsCastable(8) and Player:AffectingCombat() and TargetTTD() > 4) then
            return S.Shiv:Cast()
        end
    end

  
    --------------------------------------------------------------------------------------------------------------------------------------------------------
    -----------------------------------------------------------------Stealth--------------------------------------------------------------------------------
    --------------------------------------------------------------------------------------------------------------------------------------------------------
    if (stealthbasic or Player:Buff(S.Shadowmeld)) then
        if S.BladeFlurry:IsCastable() and not AuraUtil.FindAuraByName("Stealth", "player") and Player:AffectingCombat() and ((RubimRH.AoEON() and (not Player:BuffP(S.BladeFlurry) or Player:BuffRemainsP(S.BladeFlurry) < Player:GCD()) and Cache.EnemiesCount[bfrange] >= 2)) then
            return S.BladeFlurry:Cast()
        end
    
        if S.ColdBlood:IsCastable() and Target:IsInRange(30) and not Player:BuffP(S.ColdBlood) and Target:IsInRange(8) and finishcondition and Player:CanAttack(Target) then
            return S.ColdBlood:Cast()
        end
        
        if S.Dispatch:IsCastable() and Target:IsInRange(8) and finishcondition and Player:CanAttack(Target) then
            return S.Dispatch:Cast()
        end
    
        if S.Ambush:IsReady() and  not AuraUtil.FindAuraByName("Stealth", "player") and not finishcondition 
        and Target:IsInRange(8) and Player:CanAttack(Target) 
        and (stealthedcto or stealthbasic and S.FindWeakness:IsAvailable() and not Target:Debuff(S.FindWeaknessDebuff) 
        or S.HiddenOpportunity:IsAvailable()) then
            return S.Ambush:Cast()
        end
    end
    --------------------------------------------------------------------------------------------------------------------------------------------------------
    -----------------------------------------------------------------Cooldowns/defensives/heals-------------------------------------------------------------
    --------------------------------------------------------------------------------------------------------------------------------------------------------
    if Player:AffectingCombat() and not AuraUtil.FindAuraByName("Stealth", "player") then
        if not IsCurrentSpell(6603) and not Player:Buff(S.VanishBuff) 
        and Player:CanAttack(Target) and not Target:IsDeadOrGhost() and Target:IsInRange(20) then
            return S.autoattack:Cast()
        end
    


    --        --healing pots
           if I.HPpotID:IsReady() and Player:HealthPercentage() <= 35 and HPpercentloss >0 then
           return I.HPIcon:Cast()
           end




        --auto feint
        if S.Feint:IsCastable() and mitigate() and Player:AffectingCombat() and not AuraUtil.FindAuraByName("Stealth", "player") then
            return S.Feint:Cast()
        end


        if S.CrimsonVial:IsCastable() and (Player:HealthPercentage() <= 30 or HPpercentloss > 10 and Player:HealthPercentage() < 40)
            and Player:AffectingCombat() then
            return S.CrimsonVial:Cast()
        end

        if S.Evasion:IsCastable() and (Cache.EnemiesCount[10] >= 1 or Target:IsInRange(10)) 
        and IsTanking 
        and (Player:HealthPercentage() < 55 
        or HPpercentloss > 10 and Player:HealthPercentage() < 65) 
        then
            return S.Evasion:Cast()
        end


        if RubimRH.CDsON() and Target:IsInRange(5) and not Target:IsDeadOrGhost() and Player:CanAttack(Target) 
        and Player:AffectingCombat() and not AuraUtil.FindAuraByName("Stealth", "player") then
            local ShouldReturn = UseItems();
            if ShouldReturn then return ShouldReturn; end
        end

        
  
        if RubimRH.CDsON() and Target:IsInRange(10) and Player:CanAttack(Target) and Player:AffectingCombat() and S.AdrenalineRush:IsCastable() and not AuraUtil.FindAuraByName("Stealth", "player") and not Player:BuffP(S.AdrenalineRush)
            and (not S.ImprovedAdrenalineRush:IsAvailable() or Player:ComboPoints() <= 2) then
            return S.AdrenalineRush:Cast()
        end


        if S.BladeFlurry:IsCastable() and not AuraUtil.FindAuraByName("Stealth", "player") and ((RubimRH.AoEON() 
        and (not Player:BuffP(S.BladeFlurry)
                or Player:BuffRemainsP(S.BladeFlurry) < Player:GCD()) and Cache.EnemiesCount[bfrange] >= 2)) then
            return S.BladeFlurry:Cast()
        end

        if S.RolltheBones:IsCastable() and Cache.EnemiesCount[30] >= 1 and not Player:BuffP(S.VanishBuff)
            and not Player:BuffP(S.ShadowDanceBuff) and not Player:Debuff(S.Dreadblades)
            and (RtB_Buffs() == 0 or RtB_Reroll()) then
            return S.RolltheBones:Cast()
        end

        if S.KeepitRolling:IsCastable() and not RtB_Reroll() and (((num(Player:Buff(S.Broadside))) + (num(Player:Buff(S.TrueBearing)))
                + (num(Player:Buff(S.SkullandCrossbones))) + (num(Player:Buff(S.RuthlessPrecision)))) > 2 and (not Player:Buff(S.ShadowDanceBuff)
                or RtB_Buffs() >= 6) and RubimRH.CDsON()) then
            return S.KeepitRolling:Cast()
        end


        if S.BladeRush:IsCastable() and Target:IsInRange(5) and Player:CanAttack(Target) and not Player:Debuff(S.Dreadblades) and EnergyTimeToMaxRounded()>Player:GCD()
        and (EnergyTimeToMaxRounded() > (4 + num(AuraUtil.FindAuraByName("Stealth", "player")) - (Cache.EnemiesCount[bfrange] / 3)) or Cache.EnemiesCount[bfrange]>2 and Player:EnergyDeficit()>50) 
        and Player:AffectingCombat() and not Target:Debuff(S.Blind) 
        and (Target:Debuff(S.BetweentheEyes) or TargetTTD()<3 and not Target:Debuff(S.BetweentheEyes) or S.BetweentheEyes:CooldownRemains()>Player:GCD())
        and not Player:Buff(S.Stealth) and not Player:BuffP(S.VanishBuff) and bladeflurrysync then
           return S.BladeRush:Cast()
       end

    

       if S.BladeRush:IsCastable() and Target:IsInRange(5) and Player:CanAttack(Target)
       and not Player:Debuff(S.Dreadblades) and not Player:Buff(S.ShadowDanceBuff) and not Player:Buff(S.SubterfugeBuff)
        and Player:AffectingCombat() and not Target:Debuff(S.Blind) and not Player:BuffP(S.Stealth) and not Player:BuffP(S.VanishBuff) 
        and (Target:Debuff(S.BetweentheEyes) or S.BetweentheEyes:CooldownRemains() > Player:GCD()) and (Cache.EnemiesCount[bfrange] == 1 
        and EnergyTimeToMaxRounded() > 4 or (Player:BuffP(S.BladeFlurry) and (Player:EnergyDeficit() > 50 and Cache.EnemiesCount[bfrange] > 1
         or Cache.EnemiesCount[bfrange] > 3))) then
           return S.BladeRush:Cast()
       end
    --------------------------------------------------------------------------------------------------------------------------------------------------------
    -----------------------------------------------------------------Stealth CDs------------------------------------------------------------------------------
    --------------------------------------------------------------------------------------------------------------------------------------------------------
    if RubimRH.CDsON() and not AuraUtil.FindAuraByName("Stealth", "player") and not Player:Buff(S.SubterfugeBuff)
        and not Player:Buff(S.AudacityBuff)
        and Target:IsInRange(bfrange) and Player:CanAttack(Target) and Player:AffectingCombat() then
        if S.Vanish:IsCastable() then
            -- actions.stealth_cds=variable,name=vanish_condition,value=talent.hidden_opportunity|!talent.shadow_dance|!cooldown.shadow_dance.ready
            if S.HiddenOpportunity:IsAvailable() or not S.ShadowDance:IsAvailable() or not S.ShadowDance:CooldownUp() then
                -- actions.stealth_cds+=/vanish,if=talent.find_weakness&!talent.audacity&debuff.find_weakness.down&variable.ambush_condition&variable.vanish_condition
                -- actions.stealth_cds+=/vanish,if=talent.hidden_opportunity&!buff.audacity.up&(variable.vanish_opportunity_condition|buff.opportunity.stack<buff.opportunity.max_stack)&variable.ambush_condition&variable.vanish_condition
                -- actions.stealth_cds+=/vanish,if=(!talent.find_weakness|talent.audacity)&!talent.hidden_opportunity&variable.finish_condition&variable.vanish_condition
                if not Player:Buff(S.ShadowDanceBuff) and S.FindWeakness:IsAvailable() and not S.Audacity:IsAvailable() and not Target:Debuff(S.FindWeaknessDebuff) and ambushcondition then
                    return S.Vanish:Cast()
                end
                if S.HiddenOpportunity:IsAvailable() then
                    -- actions.stealth_cds+=/variable,name=vanish_opportunity_condition,value=!talent.shadow_dance&talent.fan_the_hammer.rank+talent.quick_draw+talent.audacity<talent.count_the_odds+talent.keep_it_rolling
                    local VanishOpportunityCondition = not S.ShadowDance:IsAvailable()
                        and
                        (fthrank + num(S.QuickDraw:IsAvailable()) + num(S.Audacity:IsAvailable()) < num(S.CounttheOdds:IsAvailable()) + num(S.KeepitRolling:IsAvailable()))
                    if not Player:Buff(S.ShadowDanceBuff) and not Player:Buff(S.AudacityBuff) and (VanishOpportunityCondition or Player:BuffStack(S.Opportunity) < (S.FantheHammer:IsAvailable() and 6 or 1)) and ambushcondition
                        and (num(S.HiddenOpportunity:IsAvailable()) + num(finishcondition)) == 1 then
                        return S.Vanish:Cast()
                    end
                end
                if (not S.FindWeakness:IsAvailable() or not S.Audacity:IsAvailable()) and not S.HiddenOpportunity:IsAvailable() and finishcondition then
                    return S.Vanish:Cast()
                end
            end
        end
        if S.ShadowDance:IsCastable() and Target:Debuff(S.BetweentheEyes) and (not S.GhostlyStrike:IsAvailable() or Target:Debuff(S.GhostlyStrike)) then
            if Player:BuffRemains(S.BladeFlurry) > 3 and Cache.EnemiesCount[10] >= 5 and Player:Buff(S.SliceandDice)
                and not Player:Buff(S.AudacityBuff) and not Player:Buff(S.SubterfugeBuff) 

            then
                return S.ShadowDance:Cast()
            elseif
            -- actions.stealth_cds+=/variable,name=shadow_dance_condition,value=talent.shadow_dance&debuff.between_the_eyes.up&(!talent.ghostly_strike|debuff.ghostly_strike.up)&(!talent.dreadblades|!cooldown.dreadblades.ready)&(!talent.hidden_opportunity|!buff.audacity.up&(talent.fan_the_hammer.rank<2|!buff.opportunity.up))
            -- actions.stealth_cds+=/shadow_dance,if=!talent.keep_it_rolling&variable.shadow_dance_condition&buff.slice_and_dice.up&(variable.finish_condition|talent.hidden_opportunity)&(!talent.hidden_opportunity|!cooldown.vanish.ready)
            -- actions.stealth_cds+=/shadow_dance,if=talent.keep_it_rolling&variable.shadow_dance_condition&(cooldown.keep_it_rolling.remains<=30|cooldown.keep_it_rolling.remains>120&(variable.finish_condition|talent.hidden_opportunity))

                (not S.Dreadblades:IsAvailable() or not S.Dreadblades:CooldownUp())
                and (not S.HiddenOpportunity:IsAvailable() or not Player:Buff(S.AudacityBuff) and (fthrank < 2 or not Player:Buff(S.Opportunity))) then
                if S.KeepitRolling:IsAvailable() then
                    if (S.KeepitRolling:CooldownRemains() <= 30 or S.KeepitRolling:CooldownRemains() > 120
                            and (finishcondition or S.HiddenOpportunity:IsAvailable())) then
                        return S.ShadowDance:Cast()
                    end
                else
                    if Player:Buff(S.SliceandDice) and (num(S.HiddenOpportunity:IsAvailable()) + num(finishcondition)) == 1
                        and (not S.HiddenOpportunity:IsAvailable() or not S.Vanish:CooldownUp()) then
                        return S.ShadowDance:Cast()
                    end
                end
            end
        end
    end

    --------------------------------------------------------------------------------------------------------------------------------------------------------
    -----------------------------------------------------------------Cooldowns------------------------------------------------------------------------------
    --------------------------------------------------------------------------------------------------------------------------------------------------------
    if S.MarkedforDeath:IsCastable() and Target:IsInRange(10) and Player:CanAttack(Target) 
    and (Player:ComboPointsDeficit() >= CPMaxSpend() - 1 and not ((Player:ComboPoints() == 2 and Player:Buff(S.EchoingReprimandCP2)) 
    or (Player:ComboPoints() == 3 and Player:Buff(S.EchoingReprimandCP3)) or (Player:ComboPoints() == 4 and Player:Buff(S.EchoingReprimandCP4)))) then
        return S.MarkedforDeath:Cast()
    end


	-- dreadblades,if=!(variable.stealthed_cto|stealthed.basic|talent.hidden_opportunity&stealthed.rogue)
    -- &combo_points<=2&(!talent.marked_for_death|!cooldown.marked_for_death.ready)&target.time_to_die>=10
        if S.Dreadblades:IsCastable() and Target:IsInRange(8) and RubimRH.CDsON() and (not (stealthedcto or stealthbasic or S.HiddenOpportunity:IsAvailable() and stealthall) 
        and Player:ComboPoints()<=2 and (not S.MarkedforDeath:IsAvailable() or not S.MarkedforDeath:CooldownUp()) and TargetTTD()>=10) then
            return S.Dreadblades:Cast()
        end

        if S.KillingSpree:IsCastable() and RubimRH.CDsON() and not stealthall and bladeflurrysync and Target:Debuff(S.BetweentheEyes) and Player:EnergyDeficit() > 50 then
            return S.KillingSpree:Cast()
        end
    end



    --------------------------------------------------------------------------------------------------------------------------------------------------------
    -----------------------------------------------------------------Stealth CTO----------------------------------------------------------------------------
    --------------------------------------------------------------------------------------------------------------------------------------------------------
    if stealthedcto and Target:IsInRange(bfrange) then
        if S.BladeFlurry:IsCastable() and not AuraUtil.FindAuraByName("Stealth", "player") and ((RubimRH.AoEON() and (not Player:BuffP(S.BladeFlurry) or Player:BuffRemainsP(S.BladeFlurry) < Player:GCD()) and Cache.EnemiesCount[bfrange] >= 2)) then
            return S.BladeFlurry:Cast()
        end
    
        if Player:CanAttack(Target) and Target:IsInRange(8) then
            if S.ColdBlood:IsCastable() and not Player:BuffP(S.ColdBlood) and finishcondition then
                return S.ColdBlood:Cast()
            end
            
            if S.Dispatch:IsCastable() and finishcondition then
                return S.Dispatch:Cast()
            end
            
            if S.Ambush:IsReady() and not AuraUtil.FindAuraByName("Stealth", "player") 
            and (stealthedcto or stealthbasic and S.FindWeakness:IsAvailable() and not Target:Debuff(S.FindWeaknessDebuff) 
            or S.HiddenOpportunity:IsAvailable()) then
                return S.Ambush:Cast()
            end
        end
    end


    --------------------------------------------------------------------------------------------------------------------------------------------------------
    -----------------------------------------------------------------Finishers------------------------------------------------------------------------------
    --------------------------------------------------------------------------------------------------------------------------------------------------------
    if finishcondition then
        -- between_the_eyes,if=target.time_to_die>3&(debuff.between_the_eyes.remains<4|talent.greenskins_wickers&!buff.greenskins_wickers.up
        -- |!talent.greenskins_wickers&talent.improved_between_the_eyes&buff.ruthless_precision.up)
        -- Finishers BtE to keep the Crit debuff up, if RP is up, or for Greenskins, unless the target is about to die.

        if S.BetweentheEyes:IsCastable(20)
            and UnitName('target') ~= 'Spiteful Shade'
            and TargetTTD() > 3
            and not Target:Debuff(S.Blind) and not AuraUtil.FindAuraByName("Stealth", "player") and Player:AffectingCombat() and not Player:Buff(S.VanishBuff)
            and (Target:DebuffRemainsP(S.BetweentheEyes) < 4 or S.GreenSkinsWickers:IsAvailable() and not Player:Buff(S.GreenSkinsWickersBuff)
                or not S.GreenSkinsWickers:IsAvailable() and S.ImprovedBetweentheEyes:IsAvailable() and Player:Buff(S.RuthlessPrecision)) then
            return S.BetweentheEyes:Cast()
        end
    end

    -- if S.SliceandDice:IsCastable() and S.SwiftSlasher:IsAvailable() and
    --     (SnDAS ~= maxsndpercent
    --         or Player:BuffRemainsP(S.SliceandDice) <= Player:GCD() * 2)
    --     and Target:IsInRange(10) and Player:ComboPoints() >= CPMaxSpend() then
    --     return S.SliceandDice:Cast()
    -- end

    if finishcondition then
        if S.SliceandDice:IsCastable() and not S.SwiftSlasher:IsAvailable() and not Player:BuffP(S.GrandMelee) and Target:IsInRange(10) and Player:BuffRemainsP(S.SliceandDice) < Player:GCD() * 2 then
            return S.SliceandDice:Cast()
        end

        if S.ColdBlood:IsCastable() and Target:IsInRange(30) and not Player:BuffP(S.ColdBlood) then
            return S.ColdBlood:Cast()
        end

        if S.Dispatch:IsCastable(8) and not Target:Debuff(S.Blind) and Player:AffectingCombat() and not Player:Buff(S.VanishBuff) then
            --and SnDAS == maxsndpercent
            return S.Dispatch:Cast()
        end
    end
    
    --------------------------------------------------------------------------------------------------------------------------------------------------------
    -----------------------------------------------------------------Builders-------------------------------------------------------------------------------
    --------------------------------------------------------------------------------------------------------------------------------------------------------


    if not RubimRH.LastCast(S.MarkedforDeath, 1) and not AuraUtil.FindAuraByName("Stealth", "player") and not Target:Debuff(S.Blind) 
	and not Target:IsDeadOrGhost() and Player:CanAttack(Target) and Player:AffectingCombat() and not finishcondition then
		--(not finishcondition or SnDAS ~= maxsndpercent)
		-- if S.EchoingReprimand:CooldownRemainsP() <= 10 and not Player:Buff(S.VanishBuff) 
		-- and (((Player:ComboPoints() == 1 - num(Player:BuffP(S.Broadside))) and Player:Buff(S.EchoingReprimandCP2)) 
		-- or ((Player:ComboPoints() == 2 - num(Player:BuffP(S.Broadside))) and Player:Buff(S.EchoingReprimandCP3)) 
		-- or ((Player:ComboPoints() == 3 - num(Player:BuffP(S.Broadside))) and Player:Buff(S.EchoingReprimandCP4))) then
		--     if S.PistolShot:IsCastable(20) and not Player:BuffP(S.Opportunity) then
		--         return S.PistolShot:Cast()
		--     end
		-- end

		if S.GhostlyStrike:IsCastable(8) and Target:DebuffRemains(S.GhostlyStrike) <= 3
		 and (Cache.EnemiesCount[bfrange] <= 2 or Player:Debuff(S.Dreadblades)) and not Player:Buff(S.SubterfugeBuff) and TargetTTD()>=5 then
			return S.GhostlyStrike:Cast()
		end


		-- ambush,if=(talent.hidden_opportunity|talent.keep_it_rolling)
		-- &(buff.audacity.up|buff.sepsis_buff.up|buff.subterfuge.up&cooldown.keep_it_rolling.ready)
		-- |talent.find_weakness&debuff.find_weakness.down
		if S.Ambush:IsReady() and not Target:IsDeadOrGhost() and Target:IsInRange(8) and 
		((S.HiddenOpportunity:IsAvailable() or S.KeepitRolling:IsAvailable()) 
		and (Player:Buff(S.AudacityBuff) or Player:Buff(S.Sepsis) or not Player:Buff(S.SubterfugeBuff) and S.KeepitRolling:CooldownUp())
		or S.FindWeakness:IsAvailable() and not Target:Debuff(S.FindWeaknessDebuff)) then
			return S.Ambush:Cast()
		end

		-- pistol_shot,if=talent.fan_the_hammer&talent.audacity&talent.hidden_opportunity&buff.opportunity.up&!buff.audacity.up
		-- &!buff.subterfuge.up&!buff.shadow_dance.up
		if S.PistolShot:IsCastable(20) and S.FantheHammer:IsAvailable() and S.Audacity:IsAvailable() 
		and S.HiddenOpportunity:IsAvailable() and Player:Buff(S.Opportunity) and not Player:Buff(S.AudacityBuff)
		 and not Player:Buff(S.SubterfugeBuff) and not Player:Buff(S.ShadowDanceBuff) then
			return S.PistolShot:Cast()
		end

		-- pistol_shot,if=buff.greenskins_wickers.up&(!talent.fan_the_hammer&buff.opportunity.up|buff.greenskins_wickers.remains<1.5)
		if S.PistolShot:IsCastable(20) and Player:Buff(S.GreenSkinsWickersBuff) and (not S.FantheHammer:IsAvailable() 
		and Player:Buff(S.Opportunity) or Player:BuffRemains(S.GreenSkinsWickersBuff) < 2) then
			return S.PistolShot:Cast()
		end

		-- pistol_shot,if=talent.fan_the_hammer&buff.opportunity.up&(buff.opportunity.stack>=buff.opportunity.max_stack|buff.opportunity.remains<2)
		if S.PistolShot:IsCastable(20) and S.FantheHammer:IsAvailable() and Player:Buff(S.Opportunity) 
		and (Player:BuffStack(S.Opportunity) >= 6 or Player:BuffRemains(S.Opportunity) < 2) then
			return S.PistolShot:Cast()
		end

		-- pistol_shot,if=talent.fan_the_hammer&buff.opportunity.up&combo_points.deficit>((1+talent.quick_draw)*talent.fan_the_hammer.rank)
		-- &!buff.dreadblades.up&(!talent.hidden_opportunity|!buff.subterfuge.up&!buff.shadow_dance.up)
		if S.PistolShot:IsCastable(20) and S.FantheHammer:IsAvailable() and Player:Buff(S.Opportunity) 
		and Player:ComboPointsDeficit() > (1 + num(S.QuickDraw:IsAvailable()) * fthrank) and not Player:Debuff(S.Dreadblades) 
		and (not S.HiddenOpportunity:IsAvailable() or not Player:Buff(S.SubterfugeBuff) and not Player:Buff(S.ShadowDanceBuff)) then
			return S.PistolShot:Cast()
		end


		if S.EchoingReprimand:IsCastable(8) and not Player:Debuff(S.Dreadblades) then
			return S.EchoingReprimand:Cast()
		end
		--POOL

		-- ambush,if=talent.hidden_opportunity|talent.find_weakness&debuff.find_weakness.down
		if S.Ambush:IsReady() and not Target:IsDeadOrGhost() and Player:CanAttack(Target) and Target:IsInRange(8) 
		and (S.HiddenOpportunity:IsAvailable() or S.FindWeakness:IsAvailable() and not Target:Debuff(S.FindWeaknessDebuff)) then
			return S.Ambush:Cast()
		end

		-- pistol_shot,if=!talent.fan_the_hammer&buff.opportunity.up&(energy.base_deficit>energy.regen*1.5|!talent.weaponmaster
		-- &combo_points.deficit<=1+buff.broadside.up|talent.quick_draw.enabled|talent.audacity.enabled&!buff.audacity.up)
		if S.PistolShot:IsCastable(20) and not S.FantheHammer:IsAvailable() and Player:Buff(S.Opportunity) and (Player:EnergyDeficit()>Player:EnergyRegen()*1.5 
		or not S.Weaponmaster:IsAvailable() and Player:ComboPoints()<=1 + num(Player:Buff(S.Broadside)) or S.QuickDraw:IsAvailable() or S.Audacity:IsAvailable() and not Player:Buff(S.AudacityBuff)) then
			return S.PistolShot:Cast()
		end

		if S.SinisterStrike:IsCastable(8) and not stealthall and not Player:Buff(S.AudacityBuff) then
			return S.SinisterStrike:Cast()
		end

    end

    --------------------------------------------------------------------------------------------------------------------------------------------------------
    --------------------------------------------------------------------OOR---------------------------------------------------------------------------------
    --------------------------------------------------------------------------------------------------------------------------------------------------------
    if not Target:IsInRange(bfrange) and not Target:Debuff(S.Blind) and not AuraUtil.FindAuraByName("Stealth", "player") 
    and Player:AffectingCombat() and not Player:Buff(S.VanishBuff) then
        if S.BetweentheEyes:IsCastable(20) and EnergyTimeToMaxRounded() <= Player:GCD() and Player:ComboPoints() >= CPMaxSpend() then
            return S.BetweentheEyes:Cast()
        end

        if S.PistolShot:IsCastable(20) and Player:AffectingCombat() and Player:EnergyDeficitPredicted() < 25 and (Player:ComboPointsDeficit() >= 1 or EnergyTimeToMaxRounded() <= Player:GCD()) then
            return S.PistolShot:Cast()
        end
    end
    --------------------------------------------------------------------------------------------------------------------------------------------------------
    -----------------------------------------------------------------Out of Combat--------------------------------------------------------------------------
    --------------------------------------------------------------------------------------------------------------------------------------------------------
    if not Player:AffectingCombat() and not Player:BuffP(S.VanishBuff) then
        if S.Stealth:CooldownUp() and not AuraUtil.FindAuraByName("Stealth", "player") and (IsResting("player") == false or Player:CanAttack(Target)) then
            return S.Stealth:Cast()
        end

        if S.CrimsonVial:IsCastable() and Cache.EnemiesCount[25] == 0 and Player:HealthPercentage() < 100 and Player:EnergyDeficit() == 0 then
            return S.CrimsonVial:Cast()
        end

        if S.InstantPoison:IsCastable() and not Player:Buff(S.WoundPoison) and Player:BuffRemainsP(S.InstantPoison) < 300 and not Player:IsCasting(S.InstantPoison) and not Player:IsMoving() then
            return S.InstantPoison:Cast()
        end

        if S.CripplingPoison:IsCastable() and not S.NumbingPoison:IsAvailable() and not S.AtrophicPoison:IsAvailable() and not Player:BuffP(S.NumbingPoison) and not Player:BuffP(S.AtrophicPoison) and Player:BuffRemainsP(S.CripplingPoison) < 300 and not Player:IsCasting(S.CripplingPoison) and not Player:IsMoving() then
            return S.CripplingPoison:Cast()
        end

        if S.AtrophicPoison:IsCastable() and Player:BuffRemainsP(S.AtrophicPoison) < 300 and not Player:IsCasting(S.AtrophicPoison) and not Player:IsMoving() then
            return S.AtrophicPoison:Cast()
        end

        if S.NumbingPoison:IsCastable() and Player:BuffRemainsP(S.NumbingPoison) < 300 and not Player:IsCasting(S.NumbingPoison) and not Player:IsMoving() then
            return S.NumbingPoison:Cast()
        end

        if (IsResting("player") == false or Player:CanAttack(Target) and Player:IsMoving()) and Player:ComboPoints() >= CPMaxSpend() then
            if S.SliceandDice:IsCastable() and Player:BuffRemainsP(S.SliceandDice) < 8 and Cache.EnemiesCount[30] >= 1 then
                return S.SliceandDice:Cast()
            end
        end

        if S.RolltheBones:IsCastable()
            and (IsResting("player") == false or Player:IsMoving())
            and Cache.EnemiesCount[30] >= 1
            and (AuraUtil.FindAuraByName("Stealth", "player")) and not Player:Debuff(S.Dreadblades)
            and (RtB_Buffs() == 0 or RtB_Reroll()) then
            return S.RolltheBones:Cast()
        end

        if not RubimRH.queuedSpell[1]:CooldownUp() or not Target:IsInRange(10) or not Player:AffectingCombat() then
            RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
        end
        return 0, "Interface\\Addons\\Rubim-RH\\Media\\mount2.tga"
    end

    return 0, "Interface\\Addons\\Rubim-RH\\Media\\mount2.tga"
end

RubimRH.Rotation.SetAPL(260, APL);

local function PASSIVE()

end

RubimRH.Rotation.SetPASSIVE(260, PASSIVE);
