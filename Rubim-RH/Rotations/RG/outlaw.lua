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
    CounttheOdds           = Spell(381982),
    CounttheOddsConduit    = Spell(341546),
    Regrowth               = Spell(8936),
    WildGrowth             = Spell(48438),
    SwiftSlasher           = Spell(381988),
    Nourish                = Spell(289022),
    ChainHeal              = Spell(1064),
    HealingSurge           = Spell(8004),
    ShadowDance            = Spell(185313),
    ShadowDanceBuff        = Spell(185422),
    ClosestTarget = Spell(256948), -- spatial rift
    HealingRain      = Spell(73920),
    Wellspring       = Spell(197995),
    Downpour         = Spell(207778),
    FlashofLight     = Spell(19750),
    HolyLight        = Spell(82326),
    Vivify           = Spell(116670),
    EnvelopingMist   = Spell(124682),
    EssenceFont      = Spell(191837),
    SoothingMist     = Spell(209525),
    SurgingMist      = Spell(227344),
    DeftManeuvers    = Spell(381878),
    AcrobaticStrikes = Spell(196924),
    --Dungeons
    --Enrage
    LoadedDiceBuff = Spell(256171),

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
    FantheHammer = Spell(381846),
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
    EchoingReprimand = Spell(385616),
    EchoingReprimandCP2 = Spell(323558),
    EchoingReprimandCP3 = Spell(323559),
    EchoingReprimandCP4 = Spell(323560),
    EchoingReprimandCP5 = Spell(354838),
    BladeRush = Spell(271877),
    CripplingPoison = Spell(3408),
    InstantPoison = Spell(315584),
    NumbingPoison = Spell(5761),
    lust1 = Spell(57724),
    lust2 = Spell(57723),
    lust3 = Spell(80354),
    lust4 = Spell(95809),
    lust5 = Spell(264689),
    KidneyShot = Spell(408),
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
    Shadowmeld = Spell(135201),
    DeviousStratagem = Spell(394321),
    Opportunity = Spell(195627),
    PistolShot = Spell(185763),
    RolltheBones = Spell(315508),
    Dispatch = Spell(2098),
    SinisterStrike = Spell(193315),
    ImprovedAmbush = Spell(381620),
    Stealth = MultiSpell(1784, 115191),
    FindWeakness = Spell(91023),
    FindWeaknessDebuff = Spell(316220),
    Vanish = Spell(1856),
    VanishBuff = Spell(11327),
    Shiv = Spell(5938),
    -- Riposte = Spell(199754), -- evasion
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
    GreenSkinsWickers = Spell(386823), --386823 --394131
    GreenSkinsWickersBuff = Spell(394131),
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
    mantle = Spell(340094),
    WoundPoison = Spell(8679),

}

local S = RubimRH.Spell[260]

if not Item.Rogue then Item.Rogue = {}; end

Item.Rogue.Outlaw = {
    trink = Item(184016, { 13, 14 }),
    drums = Item(193470),
    HPIcon = Item(169451),
    tx1 = Item(118330),
    tx2 = Item(114616),
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



local function EnergyTimeToMaxRounded()
    return math.floor(Player:EnergyTimeToMaxPredicted() * 10 + 0.5) / 10;
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

  local function UseItems()

    local trinket1 = GetInventoryItemID("player", 13) 
    local trinket2 = GetInventoryItemID("player", 14) 
    local trinket1ready = IsUsableItem(trinket1) and GetItemCooldown(trinket1) == 0 and IsEquippedItem(trinket1)
    local trinket2ready = IsUsableItem(trinket2) and GetItemCooldown(trinket2) == 0 and IsEquippedItem(trinket2)

      if trinket1ready and trinket1 ~= 193701 then
          return I.tx1:Cast()
        end
      if trinket2ready and trinket2 ~= 193701 then
          return I.tx2:Cast()
      end
  end


local function RtB_Buffs ()
    if not Cache.APLVar.RtB_Buffs then
      Cache.APLVar.RtB_Buffs = {}
      Cache.APLVar.RtB_Buffs.Total = 0
      Cache.APLVar.RtB_Buffs.Normal = 0
      Cache.APLVar.RtB_Buffs.Shorter = 0
      Cache.APLVar.RtB_Buffs.Longer = 0
      local RtBRemains = RtB_BuffRemains()
      for i = 1, #RtB_BuffsList do
        local Remains = Player:BuffRemains(RtB_BuffsList[i])
        if Remains > 0 then
          Cache.APLVar.RtB_Buffs.Total = Cache.APLVar.RtB_Buffs.Total + 1
          if Remains == RtBRemains then
            Cache.APLVar.RtB_Buffs.Normal = Cache.APLVar.RtB_Buffs.Normal + 1
          elseif Remains > RtBRemains then
            Cache.APLVar.RtB_Buffs.Longer = Cache.APLVar.RtB_Buffs.Longer + 1
          else
            Cache.APLVar.RtB_Buffs.Shorter = Cache.APLVar.RtB_Buffs.Shorter + 1
          end
        end
      end
    end
    return Cache.APLVar.RtB_Buffs.Total
  end



-- RtB rerolling strategy, return true if we should reroll
local function RtB_KiR_Reroll()
    if not Cache.APLVar.RtB_KiR_Reroll then
      -- actions+=/variable,name=rtb_reroll_kir_cto,if=talent.keep_it_rolling|talent.count_the_odds,value=(rtb_buffs.normal=0&rtb_buffs.longer>=1)&!(buff.broadside.up&buff.true_bearing.up&buff.skull_and_crossbones.up)&!(buff.broadside.remains>39|buff.true_bearing.remains>39|buff.ruthless_precision.remains>39|buff.skull_and_crossbones.remains>39)
      if not S.KeepitRolling:IsAvailable() and not S.CounttheOdds:IsAvailable() then
        Cache.APLVar.RtB_KiR_Reroll = false
      else
        RtB_Buffs() -- Regenerate cache
        if Cache.APLVar.RtB_Buffs.Normal == 0 and Cache.APLVar.RtB_Buffs.Longer > 0
          and not (Player:Buff(S.Broadside) and Player:Buff(S.TrueBearing) and Player:Buff(S.SkullandCrossbones))
          and not (Player:BuffRemains(S.Broadside) > 39 or Player:BuffRemains(S.TrueBearing) > 39
            or Player:BuffRemains(S.RuthlessPrecision) > 39 or Player:BuffRemains(S.SkullandCrossbones) > 39) then
          Cache.APLVar.RtB_KiR_Reroll = true
        else
          Cache.APLVar.RtB_KiR_Reroll = false
        end
      end
    end
  
    return Cache.APLVar.RtB_KiR_Reroll
  end
  

  local function RtB_Reroll()
    if not Cache.APLVar.RtB_Reroll then
     
        -- actions+=/variable,name=rtb_reroll,value=rtb_buffs<2&(!buff.broadside.up&(!talent.fan_the_hammer|!buff.skull_and_crossbones.up)&!buff.true_bearing.up|buff.loaded_dice.up)|rtb_buffs=2&(buff.buried_treasure.up&buff.grand_melee.up|!buff.broadside.up&!buff.true_bearing.up&buff.loaded_dice.up)
        if RtB_Buffs() == 2 then
          if Player:Buff(S.BuriedTreasure) and Player:Buff(S.GrandMelee) then
            Cache.APLVar.RtB_Reroll = true
          elseif Player:Buff(S.LoadedDiceBuff) and not Player:Buff(S.Broadside) and not Player:Buff(S.TrueBearing) then
            Cache.APLVar.RtB_Reroll = true
          end
        elseif RtB_Buffs() < 2
          and (not Player:Buff(S.Broadside) and (not S.FantheHammer:IsAvailable() or not Player:Buff(S.SkullandCrossbones))
            and not Player:Buff(S.TrueBearing) or Player:Buff(S.LoadedDiceBuff)) then
          Cache.APLVar.RtB_Reroll = true
        else
          Cache.APLVar.RtB_Reroll = false
        end
      end
       return Cache.APLVar.RtB_Reroll
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
    target_is_dummy()
    RtB_BuffRemains()
    RtB_Buffs()




    IsTanking = Player:IsTankingAoE(8) or Player:IsTanking(Target)

    --------------------------------------------------------------------------------------------------------------------------------------------
    ----------------------------------------------------------Functions/Top priorities----------------------------------------------------------
    --------------------------------------------------------------------------------------------------------------------------------------------
    if Player:IsCasting() or Player:IsChanneling() then
        return 0, "Interface\\Addons\\Rubim-RH\\Media\\channel.tga"
    elseif Player:IsDeadOrGhost() or AuraUtil.FindAuraByName("Drink", "player") or
        AuraUtil.FindAuraByName("Food", "player") or AuraUtil.FindAuraByName("Food & Drink", "player") or
        AuraUtil.FindAuraByName("Shroud of Concealment", "player") then
        return 0, "Interface\\Addons\\Rubim-RH\\Media\\griph.tga"
    end
    -- SnDAS = select(16, AuraUtil.FindAuraByName("Slice and Dice", "player"))
    -- if SnDAS == nil then
    --     SnDAS = 0
    -- end

    -- if S.SwiftSlasher:IsAvailable() then
    --     maxsndpercent = 50 + CPMaxSpend()*2
    -- else
    --     maxsndpercent = 50
    -- end



    if S.FantheHammer:IsAvailable() then
        fthrank = 2
    else
        fthrank = 0
    end

    if not Player:Buff(S.Stealth) and not Player:Buff(S.VanishBuff)  then
        stealthbasic = false
    else
        stealthbasic = true
    end

    if not Player:Buff(S.Stealth) and not Player:Buff(S.VanishBuff) and not Player:Buff(S.SubterfugeBuff) and not Player:Buff(S.ShadowDanceBuff) then
        stealthall = false
    else
        stealthall = true
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
    if Player:Buff(S.Broadside) or Player:Buff(S.Opportunity) then
        finishCPminus = 1
       else 
        finishCPminus = 0
       end

       
    --Reroll BT + GM or single buffs early other than Broadside, TB with Shadowdust, or SnC with Blunderbuss
    if true then

        -- variable,name=stealthedcto,value=talent.count_the_odds&(stealthed.basic|buff.shadowmeld.up|buff.shadow_dance.up)
        stealthedcto = S.CounttheOdds:IsAvailable() and
            (
            stealthbasic or Player:Buff(S.Shadowmeld) or Player:Buff(S.ShadowDanceBuff))


        -- variable,name=rtb_reroll,value=rtb_buffs<2&(!buff.broadside.up&(!talent.fan_the_hammer|!buff.skull_and_crossbones.up)
        -- &!buff.true_bearing.up|buff.loaded_dice.up)|rtb_buffs=2
        -- &(buff.buried_treasure.up&buff.grand_melee.up|!buff.broadside.up&!buff.true_bearing.up&buff.loaded_dice.up)
        -- rtb_reroll = RtB_Buffs() < 2 and
        --     (
        --     not Player:Buff(S.Broadside) and (not S.FantheHammer:IsAvailable() or not Player:Buff(S.SkullandCrossbones))
        --         and
        --         not Player:Buff(S.TrueBearing) or Player:Buff(S.LoadedDiceBuff)) or RtB_Buffs() == 2
        --     and
        --     (
        --     Player:Buff(S.BuriedTreasure) and Player:Buff(S.GrandMelee) or
        --         not Player:Buff(S.Broadside) and not Player:Buff(S.TrueBearing) and Player:Buff(S.LoadedDiceBuff))

        -- variable,name=ambushcondition,value=combo_points.deficit>=2+talent.improved_ambush+buff.broadside.up&energy>=50
        -- &(!talent.count_the_odds|buff.roll_the_bones.remains>=10)
        --Ensure we get full Ambush CP gains and aren't rerolling Count the Odds buffs away
        ambushcondition = (
            Player:ComboPointsDeficit() >= (2 + (num(S.ImprovedAmbush)) + (num(Player:Buff(S.Broadside)))) and
                Player:Energy() >= 50
                and (not S.CounttheOdds:IsAvailable() or RtB_BuffRemains() >= 10)
            )
   
        if S.BetweentheEyes:CooldownUp() then
            --Always attempt to use BtE at 5+ CP, regardless of CP gen waste
            finishcondition = effective_combo_points >= 5

        else
            -- variable,name=finish_condition,value=combo_points>=cp_max_spend-buff.broadside.up-(buff.opportunity.up*(talent.quick_draw|talent.fan_the_hammer))|effective_combo_points>=cp_max_spend

            --Finish at max possible CP without overflowing bonus combo points
            finishcondition = (Player:ComboPoints() >= CPMaxSpend() - (num(Player:Buff(S.Broadside))) - ((num(Player:Buff(S.Opportunity))) * ((num(S.QuickDraw:IsAvailable())) or (num(S.FantheHammer:IsAvailable())))) or 
                effective_combo_points >= CPMaxSpend())
        end


        -- variable,name=vanish_condition,value=talent.hidden_opportunity|!talent.shadow_dance|!cooldown.shadow_dance.ready
        vanishcondition = (
            S.HiddenOpportunity:IsAvailable() or not S.ShadowDance:IsAvailable() or not S.ShadowDance:CooldownUp()) 

        if S.DeftManeuvers:IsAvailable() and S.AcrobaticStrikes:IsAvailable() then
            bfrange = 12
        else
            bfrange = 10

        end

        bladeflurrysync = Cache.EnemiesCount[bfrange] < 2 or
            (Player:BuffRemainsP(S.BladeFlurry) > 1 + num(S.KillingSpree:IsAvailable()))

        mfdcondition = Player:ComboPoints() >=
            CPMaxSpend() -
            (num(Player:BuffP(S.Broadside)) + num(Player:BuffP(S.Opportunity)) * num(S.QuickDraw:IsAvailable())) and
            S.MarkedforDeath:IsCastableQueue(10)

        --variable,name=killing_spree_vanish_sync,value=!runeforge.mark_of_the_master_assassin|cooldown.vanish.remains>10|master_assassin_remains>2
        killing_spree_vanish_sync = not IsEquippedItem("Sigil of the Master Assassin") or
            S.Vanish:CooldownRemainsP() > 10 or Player:BuffRemainsP(S.mantle) > 2


        -- variable,name=vanishopportunitycondition,value=
        -- !talent.shadow_dance&talent.fan_the_hammer.rank+talent.quick_draw+talent.audacity<talent.count_the_odds+talent.keep_it_rolling

        vanishopportunitycondition = (
            not S.ShadowDance:IsAvailable() and
                (fthrank + (num(S.QuickDraw:IsAvailable())) + (num(S.Audacity:IsAvailable()))) <
                (num(S.CounttheOdds:IsAvailable()) + (num(S.KeepitRolling:IsAvailable())))
            )



            -- shadow_dance_condition,value=talent.shadow_dance&debuff.between_the_eyes.up
            -- &(!talent.ghostly_strike|debuff.ghostly_strike.up)
            -- &(!talent.dreadblades|!cooldown.dreadblades.ready)
            -- &(!talent.hidden_opportunity|!buff.audacity.up
            -- &(talent.fan_the_hammer.rank<2|!buff.opportunity.up))
        shadowdancecondition = (
            S.ShadowDance:IsAvailable() and (Target:DebuffP(S.BetweentheEyes) or (Cache.EnemiesCount[bfrange] > 1 and S.BetweentheEyes:CooldownRemainsP() >= 5))
                and (not S.GhostlyStrike:IsAvailable() or Target:DebuffP(S.GhostlyStrike)) and
                (not S.Dreadblades:IsAvailable() or not S.Dreadblades:CooldownUp())
                and (not S.HiddenOpportunity:IsAvailable() or not Player:Buff(S.AudacityBuff) 
                and (fthrank < 2 or not Player:Buff(S.Opportunity))
                )

            )



    end



--     print( ((num(Player:Buff(S.Broadside)))
--     + (num(Player:Buff(S.TrueBearing)))
--     + (num(Player:Buff(S.SkullandCrossbones)))
--     + (num(Player:Buff(S.RuthlessPrecision)))) 

-- )


    --------------------------------------------------------------------------------------------------------------------------------------------
    ----------------------------------------------------------Interrupts & Shiv-----------------------------------------------------------------
    --------------------------------------------------------------------------------------------------------------------------------------------
    if select(8, UnitCastingInfo("target")) == false and Target:CastPercentage() > math.random(27, 90) and
        RubimRH.InterruptsON() and S.Kick:IsCastableQueue(8) and Player:AffectingCombat() then
        return S.Kick:Cast()
    end

    if (
        select(4, UnitAura("target", 1)) == "" and RubimRH.InterruptsON() and S.Shiv:IsCastableQueue(8) and
            Player:AffectingCombat() and Target:TimeToDie() > 4) then
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

        if S.CripplingPoison:IsCastableQueue() and not S.NumbingPoison:IsAvailable() and
            not Player:BuffP(S.NumbingPoison) and Player:BuffRemainsP(S.CripplingPoison) < 300 and
            not Player:IsCasting(S.CripplingPoison) and not Player:IsMoving() then
            return S.CripplingPoison:Cast()
        end

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

        if S.RolltheBones:IsCastable() and (IsResting("player") == false or Player:CanAttack(Target)) and
            Enemies20y >= 1
            and ((not Player:BuffP(S.mantle) or Player:Buff(S.Stealth))
                and not Player:DebuffP(S.Dreadblades)
                and (RtB_Buffs() == 0 or RtB_Reroll() or RtB_KiR_Reroll())) then
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
        (IsUsableItem(193470) and GetItemCooldown(193470) == 0) then
        return S.lustAT:Cast() -- BIND LUST KEYBIND IN BINDPAD TO ARCANE TORRENT
    end

    if S.KidneyShot:ID() == RubimRH.queuedSpell[1]:ID() and (Target:Debuff(S.CheapShot) or Target:Debuff(S.Gouge) or Target:Debuff(S.Blind) or Target:Debuff(S.KidneyShot)) then
        RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
    end

    if S.CheapShot:ID() == RubimRH.queuedSpell[1]:ID() and (Target:Debuff(S.CheapShot) or Target:Debuff(S.Gouge) or Target:Debuff(S.Blind) or Target:Debuff(S.KidneyShot)) then
        RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
    end

    if S.Gouge:ID() == RubimRH.queuedSpell[1]:ID() and
        (
        Target:Debuff(S.CheapShot) or Target:Debuff(S.Gouge) or Target:Debuff(S.Blind) or Target:Debuff(S.KidneyShot) or Player:Buff(S.Stealth)
            or Player:Buff(S.VanishBuff)) then
        RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
    end


    if S.Dreadblades:ID() == RubimRH.queuedSpell[1]:ID() and Player:ComboPoints() <= 2 and not finishcondition and
        Player:CanAttack(Target) and Target:IsInRange(10) and not Player:BuffP(S.Stealth) and
        not Player:Buff(S.VanishBuff) and RtB_Buffs() >= 1 and bladeflurrysync then
        return S.Dreadblades:Cast()
    end
    if RubimRH.QueuedSpell():IsReadyQueue() then
        return RubimRH.QueuedSpell():Cast()
    end
    --------------------------------------------------------------------------------------------------------------------------------------------
    ----------------------------------------------------------Explosives------------------------------------------------------------------------
    --------------------------------------------------------------------------------------------------------------------------------------------
    if S.PistolShot:IsCastableQueue() and UnitName('target') == 'Explosives' then
        return S.PistolShot:Cast()
    end

    --------------------------------------------------------------------------------------------------------------------------------------------
    ----------------------------------------------------------Stealth-------------------------------------------------------------------------
    --------------------------------------------------------------------------------------------------------------------------------------------
    if (stealthbasic or Player:Buff(S.Shadowmeld)) then
        -- blade_flurry,if=talent.subterfuge&talent.hidden_opportunity&spell_targets>=2&!buff.blade_flurry.up
        if S.BladeFlurry:IsCastableQueue() and not Player:Buff(S.Stealth)  and Player:AffectingCombat() and 
            (
            (
                RubimRH.AoEON() and
                    (not Player:BuffP(S.BladeFlurry) or Player:BuffRemainsP(S.BladeFlurry) < Player:GCD())
                    and Cache.EnemiesCount[bfrange] >= 2)) then
            return S.BladeFlurry:Cast()
        end

        -- cold_blood,if=variable.finish_condition
        if S.ColdBlood:IsCastableQueue() and Target:IsInRange(8) and finishcondition and Player:CanAttack(Target) then
            return S.ColdBlood:Cast()
        end
        -- dispatch,if=variable.finish_condition
        if S.Dispatch:IsCastableQueue() and Target:IsInRange(8) and finishcondition and Player:CanAttack(Target) then
            return S.Dispatch:Cast()
        end
        -- ambush,if=variable.stealthedcto
        -- |stealthed.basic&talent.find_weakness&!debuff.find_weakness.up
        -- |talent.hidden_opportunity

        if S.Ambush:IsCastableQueue() and not finishcondition and Target:IsInRange(8) and Player:CanAttack(Target) and (stealthedcto
            or
            stealthbasic and S.FindWeakness:IsAvailable() and
            not Target:Debuff(S.FindWeaknessDebuff)
            or S.HiddenOpportunity:IsAvailable()) then
            return S.Ambush:Cast()
        end
    end


    --------------------------------------------------------------------------------------------------------------------------------------------
    ----------------------------------------------------------Cooldowns-------------------------------------------------------------------------
    --------------------------------------------------------------------------------------------------------------------------------------------

    if not IsCurrentSpell(6603) and not Player:BuffP(S.Stealth) and not Player:Buff(S.VanishBuff) and
        Player:CanAttack(Target) and not Target:IsDeadOrGhost()
        and Target:AffectingCombat() and Target:IsInRange(20) then
        return S.autoattack:Cast()
    end

    -- if Player:AffectingCombat() and Enemies8y>=1 and not Player:BuffP(S.Stealth) and not Target:Exists() then
    --     return S.ClosestTarget:Cast()
    -- end

    if Player:HealthPercentage() <= 25 and Player:AffectingCombat() and (IsUsableItem(191379) or IsUsableItem(191378)  or IsUsableItem(191380)) and
        (GetItemCooldown(191380) == 0 or GetItemCooldown(191379) == 0 or GetItemCooldown(191378) == 0) and (GetItemCount(191380) >= 1 or GetItemCount(191379) >= 1 or GetItemCount(191378) >= 1)
        and (not Player:InArena() and not Player:InBattlegrounds()) then
        return I.HPIcon:Cast()
    end


    if Target:IsInRange(8) and RubimRH.CDsON() and Player:CanAttack(Target) then
        local ShouldReturn = UseItems();
        if ShouldReturn then return ShouldReturn; end
    end

    if S.Evasion:IsCastableQueue() and (Enemies10y >= 1 or Target:IsInRange(10)) and Player:HealthPercentage() < 50 and
        IsTanking then
        return S.Evasion:Cast()
    end


    -- if IsEquippedItem("Ring of Collapsing Futures") and not Player:DebuffP(S.Temptation) and Player:CanAttack(Target) and
    --     Player:AffectingCombat() and not Player:Buff(S.VanishBuff) and not Player:Buff(S.Stealth)
    --     and Target:IsInRange(20) and IsUsableItem(142173) and GetItemCooldown(142173) == 0 then
    --     return S.Temptation:Cast()
    -- end

    if S.BladeFlurry:IsCastableQueue() and not Player:Buff(S.Stealth) and 
        (           (
            RubimRH.AoEON() and (not Player:BuffP(S.BladeFlurry) or Player:BuffRemainsP(S.BladeFlurry) < Player:GCD())
                and Cache.EnemiesCount[bfrange] >= 2)) then
        return S.BladeFlurry:Cast()
    end

    if S.RolltheBones:IsCastable() and Cache.EnemiesCount[30] >= 1 and not Player:BuffP(S.VanishBuff) and not Player:Buff(S.ShadowDance)
        and (not Player:BuffP(S.mantle)
            and not Player:DebuffP(S.Dreadblades)
            and (RtB_Buffs() == 0 or RtB_Reroll() or RtB_KiR_Reroll())) then
        return S.RolltheBones:Cast()
    end

    -- keep_it_rolling,if=!variable.rtb_reroll&(buff.broadside.up+buff.true_bearing.up+buff.skull_and_crossbones.up+buff.ruthless_precision.up)>2&(buff.shadow_dance.down|rtb_buffs>=6)
    if S.KeepitRolling:IsCastableQueue() and not RtB_Reroll()
        and
        (
            ((num(Player:Buff(S.Broadside)))
            + (num(Player:Buff(S.TrueBearing)))
            + (num(Player:Buff(S.SkullandCrossbones)))
            + (num(Player:Buff(S.RuthlessPrecision))))> 2
            and (not Player:Buff(S.ShadowDanceBuff) or RtB_Buffs()>= 6) and RubimRH.CDsON()) then
        return S.KeepitRolling:Cast()
    end


    --------------------------------------------------------------------------------------------------------------------------------------------
    ----------------------------------------------------------Stealth Cooldowns-----------------------------------------------------------------
    --------------------------------------------------------------------------------------------------------------------------------------------

    -- call_action_list,name=stealth_cds,if=!stealthed.all|talent.count_the_odds&!variable.stealthed_cto
    if RubimRH.CDsON() and (not stealthall or S.CounttheOdds:IsAvailable() and not stealthedcto)
        and Target:IsInRange(bfrange) and Player:CanAttack(Target) and
        Player:GCDRemains() <= 0.5 and Player:AffectingCombat() then

            -- vanish,if=talent.find_weakness&!talent.audacity&debuff.find_weakness.down&variable.ambush_condition&variable.vanish_condition
        if S.Vanish:IsCastableQueue() and S.FindWeakness:IsAvailable() and not S.Audacity:IsAvailable() and not Target:Debuff(S.FindWeaknessDebuff) and
            ambushcondition and vanishcondition then
            return S.Vanish:Cast()
        end

        -- vanish,if=talent.hidden_opportunity&!buff.audacity.up
        -- &(variable.vanish_opportunity_condition
        -- |buff.opportunity.stack<buff.opportunity.max_stack)
        -- &variable.ambush_condition&variable.vanish_condition
        if S.Vanish:IsCastableQueue() and S.HiddenOpportunity:IsAvailable() and not Player:Buff(S.AudacityBuff)
            and (vanishopportunitycondition or Player:BuffStack(S.Opportunity) < 6) and ambushcondition and
            vanishcondition then
            return S.Vanish:Cast()
        end

        -- vanish,if=(!talent.find_weakness|talent.audacity)&!talent.hidden_opportunity&variable.finish_condition&variable.vanish_condition
        if S.Vanish:IsCastableQueue() and (not S.FindWeakness:IsAvailable() or S.Audacity:IsAvailable()) and not S.HiddenOpportunity:IsAvailable() and
            finishcondition and vanishcondition then
            return S.Vanish:Cast()
        end

     
            if S.ShadowDance:IsCastableQueue() and not S.KeepitRolling:IsAvailable() and shadowdancecondition 
            and Player:Buff(S.SliceandDice) and (finishcondition or S.HiddenOpportunity:IsAvailable())
                and (not S.HiddenOpportunity:IsAvailable() or not S.Vanish:CooldownUp())
            then
                return S.ShadowDance:Cast()
            end

            -- shadow_dance,if=talent.keep_it_rolling&variable.shadow_dance_condition
            -- &(cooldown.keep_it_rolling.remains<=30|cooldown.keep_it_rolling.remains>120
            -- &(variable.finish_condition|talent.hidden_opportunity))
            if S.ShadowDance:IsCastableQueue() and S.KeepitRolling:IsAvailable() and shadowdancecondition
                and (S.KeepitRolling:CooldownRemains() <= 30 or
                    S.KeepitRolling:CooldownRemains() > 120 and (finishcondition or S.HiddenOpportunity:IsAvailable())) then
                return S.ShadowDance:Cast()
            end

        


    end



    --------------------------------------------------------------------------------------------------------------------------------------------
    ----------------------------------------------------------CooldownsContinued----------------------------------------------------------------
    --------------------------------------------------------------------------------------------------------------------------------------------


    if S.AdrenalineRush:IsCastableQueue() and not Player:BuffP(S.Stealth) and not Player:BuffP(S.AdrenalineRush) and
        Target:IsInRange(8) and Player:CanAttack(Target)
        and RubimRH.CDsON() and Player:AffectingCombat() and
        (not S.ImprovedAdrenalineRush:IsAvailable() or Player:ComboPoints() <= 2) then
        return S.AdrenalineRush:Cast()
    end

    -- dreadblades,if=!stealthed.all&combo_points<=2&(!talent.marked_for_death|!cooldown.marked_for_death.ready)
    -- &target.time_to_die>=10
    if S.Dreadblades:IsCastableQueue() and not stealthall 
    and RubimRH.CDsON() and Player:ComboPoints() <= 2 and Player:CanAttack(Target)
    and Target:IsInRange(10) and not Player:Buff(S.Stealth) and Player:AffectingCombat()
        and (not S.MarkedforDeath:IsAvailable() or not S.MarkedforDeath:CooldownUp()) then
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


    -- killing_spree,if=variable.blade_flurry_sync&!stealthed.rogue&debuff.between_the_eyes.up&energy.base_time_to_max>4
    if S.KillingSpree:IsCastableQueue() and RubimRH.CDsON() and not stealthall and bladeflurrysync and Target:Debuff(S.BetweentheEyes) and Player:EnergyDeficit()>50 then
        return S.KillingSpree:Cast()
    end

    
    -- blade_rush,if=variable.blade_flurry_sync&!buff.dreadblades.up&!buff.shadow_dance.up&energy.base_time_to_max>4&target.time_to_die>4
    if S.BladeRush:IsCastableQueue() and not Player:Debuff(S.Dreadblades) and not Player:Buff(S.ShadowDanceBuff) and not Player:Buff(S.SubterfugeBuff) and Player:AffectingCombat() 
        and not Target:Debuff(S.Blind)  
        

        -- and Player:EnergyDeficit()>50
        and not Player:BuffP(S.Stealth) and not Player:BuffP(S.VanishBuff) and Target:IsInRange(5)
        and (Target:Debuff(S.BetweentheEyes) or S.BetweentheEyes:CooldownRemains()>Player:GCD()) and
        (
        Cache.EnemiesCount[bfrange] == 1 and EnergyTimeToMaxRounded()>4 or
            (Player:BuffP(S.BladeFlurry) and (Player:EnergyDeficit()>50 and Cache.EnemiesCount[bfrange] > 1 or Cache.EnemiesCount[bfrange]>3))) then
        return S.BladeRush:Cast()
    end

    -- shadowmeld,if=!stealthed.all&(talent.count_the_odds&variable.finish_condition|!talent.weaponmaster.enabled&variable.ambushcondition)




    --------------------------------------------------------------------------------------------------------------------------------------------
    ----------------------------------------------------------StealthCTO-------------------------------------------------------------------------
    --------------------------------------------------------------------------------------------------------------------------------------------
    if stealthedcto then

        if S.BladeFlurry:IsCastableQueue() and
            (
            (
                RubimRH.AoEON() and
                    (not Player:BuffP(S.BladeFlurry) or Player:BuffRemainsP(S.BladeFlurry) < Player:GCD())
                    and Cache.EnemiesCount[bfrange] >= 2)) then
            return S.BladeFlurry:Cast()
        end

        if Player:CanAttack(Target) and Target:IsInRange(8) then
            -- cold_blood,if=variable.finish_condition
            if S.ColdBlood:IsCastableQueue() and finishcondition then
                return S.ColdBlood:Cast()
            end
            -- dispatch,if=variable.finish_condition
            if S.Dispatch:IsCastableQueue() and finishcondition then
                return S.Dispatch:Cast()
            end
            -- ambush,if=variable.stealthedcto
            -- |stealthed.basic&talent.find_weakness&!debuff.find_weakness.up
            -- |talent.hidden_opportunity
            if S.Ambush:IsCastableQueue() and (stealthedcto or stealthbasic and
                S.FindWeakness:IsAvailable() and not Target:Debuff(S.FindWeaknessDebuff)
                or S.HiddenOpportunity:IsAvailable()) then
                return S.Ambush:Cast()
            end
        end


    end


    --------------------------------------------------------------------------------------------------------------------------------------------
    ----------------------------------------------------------Finishers-------------------------------------------------------------------------
    --------------------------------------------------------------------------------------------------------------------------------------------
    if finishcondition then
        if S.BetweentheEyes:IsCastableQueue(20) and Target:TimeToDie() > 3 and not Target:Debuff(S.Blind) and
            not Player:Buff(S.Stealth) and Player:AffectingCombat() and not Player:Buff(S.VanishBuff)
            and
            (
            Target:DebuffRemainsP(S.BetweentheEyes) < 4 or
                (
                (S.GreenSkinsWickers:IsAvailable() and not Player:Buff(S.GreenSkinsWickersBuff)) or
                    (not S.GreenSkinsWickers:IsAvailable() and Player:Buff(S.RuthlessPrecision)))) then
            return S.BetweentheEyes:Cast()
        end
    end

    -- if S.SliceandDice:IsCastableQueue() and S.SwiftSlasher:IsAvailable() and
    --     (SnDAS ~= maxsndpercent
    --         or Player:BuffRemainsP(S.SliceandDice) <= Player:GCD() * 2)
    --     and Target:IsInRange(10) and Player:ComboPoints() >= CPMaxSpend() then
    --     return S.SliceandDice:Cast()
    -- end

    if finishcondition then
        if S.SliceandDice:IsCastableQueue() and not S.SwiftSlasher:IsAvailable() and not Player:Buff(S.GrandMelee) and
            Target:IsInRange(10)
            and Player:BuffRemainsP(S.SliceandDice) < Player:GCD() * 2 then
            return S.SliceandDice:Cast()
        end

        if S.ColdBlood:IsCastableQueue() then
            return S.ColdBlood:Cast()
        end
        if S.Dispatch:IsCastableQueue(8) and not Target:Debuff(S.Blind) and Player:AffectingCombat() and not Player:Buff(S.VanishBuff) 
        -- and SnDAS == maxsndpercent 
        then
            return S.Dispatch:Cast()
        end

    end

    --------------------------------------------------------------------------------------------------------------------------------------------
    ----------------------------------------------------------Builders--------------------------------------------------------------------------
    --------------------------------------------------------------------------------------------------------------------------------------------
    if not RubimRH.LastCast(S.MarkedforDeath, 1) and not Player:Buff(S.Stealth) and not Target:Debuff(S.Blind) and
        not Target:IsDeadOrGhost() and Player:CanAttack(Target) and Player:AffectingCombat()
        and
        -- (
            not finishcondition 
        -- or SnDAS ~= maxsndpercent) 
        then
        if S.EchoingReprimand:CooldownRemainsP() <= 10 and not Player:Buff(S.VanishBuff)
            and (
            ((Player:ComboPoints() == 1 - num(Player:BuffP(S.Broadside))) and Player:Buff(S.EchoingReprimandCP2))
                or ((Player:ComboPoints() == 2 - num(Player:BuffP(S.Broadside))) and Player:Buff(S.EchoingReprimandCP3))
                or ((Player:ComboPoints() == 3 - num(Player:BuffP(S.Broadside))) and Player:Buff(S.EchoingReprimandCP4))
            ) then
            if S.PistolShot:IsCastableQueue(20) and not Player:BuffP(S.Opportunity) then
                return S.PistolShot:Cast()
            end
        end
        -- ghostly_strike,if=debuff.ghostly_strike.remains<=3&(spell_targets.blade_flurry<=2|buff.dreadblades.up)&!buff.subterfuge.up&target.time_to_die>=5
        if S.GhostlyStrike:IsCastableQueue(8) and Target:DebuffRemains(S.GhostlyStrike)<=3 and (Cache.EnemiesCount[bfrange]<=2 or Player:Buff(S.Dreadblades)) and not Player:Buff(S.SubterfugeBuff) and Target:TimeToDie() >=5 then
        return S.GhostlyStrike:Cast()
                end

        if S.EchoingReprimand:IsCastableQueue(8) and not Target:IsDeadOrGhost() and not Player:Debuff(S.Dreadblades) then
            return S.EchoingReprimand:Cast()
        end


        -- ambush,if=talent.hidden_opportunity&buff.audacity.up|talent.find_weakness&debuff.find_weakness.down
        -- High priority Ambush line to apply Find Weakness or consume HO+Audacity buff before Pistol Shot
        if S.Ambush:IsReady() and not Target:IsDeadOrGhost() and Target:IsInRange(8) and
            (
            S.HiddenOpportunity:IsAvailable() and Player:Buff(S.AudacityBuff) or
                S.FindWeakness:IsAvailable() and not Target:Debuff(S.FindWeaknessDebuff)) then
            return S.Ambush:Cast()
        end
        -- talent.fan_the_hammer.enabled & talent.audacity.enabled & talent.hidden_opportunity.enabled & buff.opportunity.up & ! buff.audacity.up & ! buff.subterfuge.up & ! buff.shadow_dance.up
        if S.PistolShot:IsCastableQueue(20) and S.FantheHammer:IsAvailable() and S.Audacity:IsAvailable() and S.HiddenOpportunity:IsAvailable() and Player:Buff(S.Opportunity) and not Player:Buff(S.AudacityBuff) and not Player:Buff(S.SubterfugeBuff) and not Player:Buff(S.ShadowDanceBuff) then
            return S.PistolShot:Cast()
        end
        -- pistol_shot,if=buff.greenskins_wickers.up&(!talent.fan_the_hammer&buff.opportunity.up|buff.greenskins_wickers.remains<1.5)
        -- Use Greenskins Wickers buff immediately with Opportunity unless running Fan the Hammer
        if S.PistolShot:IsCastableQueue(20) and not Player:Buff(S.VanishBuff) and Player:Buff(S.GreenSkinsWickersBuff) and
            (
            not S.FantheHammer:IsAvailable() and Player:Buff(S.Opportunity) or
                Player:BuffRemains(S.GreenSkinsWickersBuff) < 2) then
            return S.PistolShot:Cast()
        end

        -- pistol_shot,if=talent.fan_the_hammer&buff.opportunity.up
        -- &(buff.opportunity.stack>=buff.opportunity.max_stack|buff.opportunity.remains<2)
        -- With Fan the Hammer, consume Opportunity at max stacks or if we will get max 4+ CP and Dreadblades is not up
        if S.PistolShot:IsCastableQueue(20) and S.FantheHammer:IsAvailable() and Player:Buff(S.Opportunity)
            and (Player:BuffStack(S.Opportunity) >= 6 or Player:BuffRemains(S.Opportunity) < 2) then
            return S.PistolShot:Cast()
        end

        -- pistol_shot,if=talent.fan_the_hammer&buff.opportunity.up
        -- &combo_points.deficit>((1+talent.quick_draw)*talent.fan_the_hammer.rank)
        -- &!buff.dreadblades.up&(!talent.hidden_opportunity|!buff.subterfuge.up&!buff.shadow_dance.up)
        if S.PistolShot:IsCastableQueue(20) and not Player:Buff(S.VanishBuff) and S.FantheHammer:IsAvailable() and Player:Buff(S.Opportunity)
            and Player:ComboPointsDeficit() > (1 + num(S.QuickDraw:IsAvailable()) * fthrank)
            and not Player:Debuff(S.Dreadblades) and
            (
            not S.HiddenOpportunity:IsAvailable() or
                not Player:Buff(S.SubterfugeBuff) and not Player:Buff(S.ShadowDanceBuff)
            ) then
            return S.PistolShot:Cast()
        end


        -- ambush,if=talent.hidden_opportunity|talent.find_weakness&debuff.find_weakness.down
        if S.Ambush:IsReady() and not Target:IsDeadOrGhost() and Player:CanAttack(Target) and Target:IsInRange(8) and
            (
            S.HiddenOpportunity:IsAvailable() or S.FindWeakness:IsAvailable() and not Target:Debuff(S.FindWeaknessDebuff)
            ) then
            return S.Ambush:Cast()
        end
        -- ambush,if=talent.hidden_opportunity|talent.find_weakness&debuff.find_weakness.down
        if S.Ambush:IsReady() and not Target:IsDeadOrGhost() and Player:CanAttack(Target) and Target:IsInRange(8) then
            return S.Ambush:Cast()
        end




            -- Use Pistol Shot with Opportunity if Combat Potency won't overcap energy, when it will exactly cap CP, or when using Quick Draw
            -- pistol_shot,if=!talent.fan_the_hammer&buff.opportunity.up&(energy.base_deficit>energy.regen*1.5|!talent.weaponmaster&combo_points.deficit<=1+buff.broadside.up|talent.quick_draw.enabled|talent.audacity.enabled&!buff.audacity.up)
            if S.PistolShot:IsCastableQueue(20) and not S.FantheHammer:IsAvailable() and Player:Buff(S.Opportunity) and
                (
                Player:EnergyDeficit() > Player:EnergyRegen() * 1.5
                    or
                    not S.Weaponmaster:IsAvailable() and Player:ComboPointsDeficit() <= (1 + num(Player:Buff(S.Broadside)))
                    or S.QuickDraw:IsAvailable() or S.Audacity:IsAvailable() and not Player:Buff(S.AudacityBuff)) then
                return S.PistolShot:Cast()
            end
            -- if S.PistolShot:IsCastableQueue(20) and not stealthall and not Player:Buff(S.AudacityBuff) and Player:Buff(S.Opportunity) then
            --     return S.PistolShot:Cast()
            -- end
            
            if S.SinisterStrike:IsCastableQueue(8) and not stealthall and not Player:Buff(S.AudacityBuff) then
                return S.SinisterStrike:Cast()
            end
        
            if S.SinisterStrike:IsCastableQueue(8) and Player:Energy()>=50 then
                return S.SinisterStrike:Cast()
            end
    end

    --------------------------------------------------------------------------------------------------------------------------------------------
    ----------------------------------------------------------OOR Pistol Shot / BTE-------------------------------------------------------------
    --------------------------------------------------------------------------------------------------------------------------------------------
    if not Target:IsInRange(bfrange) and not Target:Debuff(S.Blind) and not Player:Buff(S.Stealth) and
        Player:AffectingCombat() and not Player:Buff(S.VanishBuff) then
        if S.BetweentheEyes:IsCastableQueue(20) and EnergyTimeToMaxRounded() <= Player:GCD() and
            Player:ComboPoints() >= CPMaxSpend() then
            return S.BetweentheEyes:Cast()
        end

        if S.PistolShot:IsCastableQueue(20) and Player:AffectingCombat() and Player:EnergyDeficitPredicted() < 25 and
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
