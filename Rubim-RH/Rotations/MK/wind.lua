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

if not Spell.Monk then
    Spell.Monk = {};
end



-- Rotation Var
local Enemies5y
local Enemies8y
local EnemiesCount8y
local XuenActive
local VarXuenOnUse = false
local VarHoldXuen = false
local VarHoldSEF = false
local VarSerenityBurst = false
local VarBoKNeeded = false
local VarHoldTod = false
local VarFoPPreChan = 0



RubimRH.Spell[269] = {
    lust1 = Spell(57724),
    lust2 = Spell(57723),
    lust3 = Spell(80354),
    lust4 = Spell(95809),
    lust5 = Spell(264689),
    lustAT = Spell(155145),


   autoattack = Spell(274738), --ancestral call
    FaelineStomp             = Spell(388193),
    SoothingMist             = Spell(115175),
    AncestralCall            = Spell(274738),
    ArcaneTorrent            = Spell(25046),
    BagofTricks              = Spell(312411),
    Berserking               = Spell(26297),
    BloodFury                = Spell(20572),
    GiftoftheNaaru           = Spell(59547),
    Fireblood                = Spell(265221),
    LightsJudgment           = Spell(255647),
    QuakingPalm              = Spell(107079),
    Shadowmeld               = Spell(58984),
    CraneVortex              = Spell(388848),
    -- Abilities
    CracklingJadeLightning   = Spell(117952),
    ExpelHarm                = Spell(322101),
    LegSweep                 = Spell(119381),
    Provoke                  = Spell(115546),
    Resuscitate              = Spell(115178),
    RisingSunKick            = Spell(107428),
    Roll                     = Spell(109132),
    TigerPalm                = Spell(100780),
    TouchofDeath             = Spell(322109),
    Transcendence            = Spell(101643),
    TranscendenceTransfer    = Spell(119996),
    Vivify                   = Spell(116670),
    -- Talents125174
    BonedustBrew             = Spell(386276),
    Celerity                 = Spell(115173),
    ChiBurst                 = Spell(123986),
    ChiTorpedo               = Spell(115008),
    ChiWave                  = Spell(115098),
    DampenHarm               = Spell(122278),
    Detox                    = Spell(218164),
    Disable                  = Spell(116095),
    DiffuseMagic             = Spell(122783),
    EyeoftheTiger            = Spell(196607),
    InnerStrengthBuff        = Spell(261769),
    Paralysis                = Spell(115078),
    RingofPeace              = Spell(116844),
    RushingJadeWind          = Spell(116847),
    SpearHandStrike          = Spell(116705),
    SummonWhiteTigerStatue   = Spell(388686),
    TigerTailSweep           = Spell(264348),
    TigersLust               = Spell(116841),
    -- Buffs
    BonedustBrewBuff         = Spell(386276),
    DampenHarmBuff           = Spell(122278),
    RushingJadeWindBuff      = Spell(116847),
    -- Debuffs
    -- Item Effects
    TheEmperorsCapacitorBuff = Spell(235054),
    -- Misc
    PoolEnergy               = Spell(999995),
    StopFoF                  = Spell(59752), -- will to survive

    -- Abilities
    SkyReach                    = Spell(392991),
    BlackoutKick                = Spell(100784),
    FlyingSerpentKick           = Spell(101545),
    FlyingSerpentKickLand       = Spell(115057),
    SpinningCraneKick           = Spell(101546),
    FortifyingBrewBuff          = Spell(120954),
    -- Talents
    BonedustBrew                = Spell(386276),
    FaelineHarmony              = Spell(391412),
    FistsofFury                 = Spell(113656),
    HitCombo                    = Spell(196740),
    InvokeXuenTheWhiteTiger     = Spell(123904),
    MarkoftheCrane              = Spell(220357),
    Serenity                    = Spell(152173),
    ShadowboxingTreads          = Spell(392982),
    StormEarthAndFire           = Spell(137639),
    StormEarthAndFireFixate     = Spell(221771),
    StrikeoftheWindlord         = Spell(392983),
    TeachingsoftheMonastery     = Spell(116645),
    Thunderfist                 = Spell(392985),
    WhirlingDragonPunch         = Spell(152175),
    XuensBattlegear             = Spell(392993),
    -- Defensive
    FortifyingBrew              = Spell(243435),
    TouchofKarma                = Spell(122470),
    TouchofKarmaBuff            = Spell(125174),
    -- Buffs
    ChiEnergyBuff               = Spell(393057),
    BlackoutKickBuff            = Spell(116768),
    DanceofChijiBuff            = Spell(325202),
    HitComboBuff                = Spell(196741),
    PowerStrikesBuff            = Spell(129914),
    SerenityBuff                = Spell(152173),
    StormEarthAndFireBuff       = Spell(137639),
    TeachingsoftheMonasteryBuff = Spell(202090),
    WhirlingDragonPunchBuff     = Spell(196742),
    -- Debuffs
    MarkoftheCraneDebuff        = Spell(228287),
    SkyreachExhaustionDebuff    = Spell(393050),
    -- Tier 29 Effects
    FastFeet                    = Spell(388809),
    KicksofFlowingMomentumBuff  = Spell(394944),
    FistsofFlowingMomentumBuff  = Spell(394949),




}

local S = RubimRH.Spell[269]

if not Item.Monk then Item.Monk = {}; end

Item.Monk.Windwalker = {
    trink2 = Item(184016, { 13, 14 }), --Skulker's Wing
    trink = Item(179350, { 13, 14 }), --???
    lust = Item(164978), --drums of fury
    HPIcon = Item(169451),
    tx1 = Item(118330),
    tx2 = Item(114616),
};

local I = Item.Monk.Windwalker;


local function num(val)
    if val then
        return 1
    else
        return 0
    end
end


local function EnergyTimeToMaxPredicted()
    return math.floor(Player:EnergyTimeToMaxPredicted() * 10 + 0.5) / 10;
end

local function ComboStrike(SpellObject)
    return (not Player:PrevGCD(1, SpellObject))
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




local function MotCCounter()
    if not S.MarkoftheCrane:IsAvailable() then return 0; end
    local Count = 0

    
    local MotCCounter = 0
    for id = 1, 40 do
    local unitID = "nameplate" .. id
    local count =select(3, AuraUtil.FindAuraByName("Mark of the Crane",unitID,"PLAYER|HARMFUL"))
    if UnitCanAttack("player", unitID) and IsItemInRange(33069, unitID) and count then
        MotCCounter = MotCCounter + 1
    end
    end
    return MotCCounter

end

local function SCKModifier()
    if not S.MarkoftheCrane:IsAvailable() then return 0; end
    local Count = MotCCounter()
    local Mod = 1
    if Count > 0 then
        Mod = Mod * (1 + (Count * 0.18))
    end
    Mod = Mod * (1 + (0.1 * 2)) -- *2 crane vortex
    Mod = Mod * (1 + (0.3 * num(Player:Buff(S.KicksofFlowingMomentumBuff))))
    Mod = Mod * (1 + (0.05 * 2)) --*2 fast feed r2
    return Mod
end

local function SCKMax()
    if not S.MarkoftheCrane:IsAvailable() then return true; end
    local Count = MotCCounter()
    if (Enemies12y == Count or Count >= 5) then return true; end
    return false
end


-- EquipItemByName(itemId or "itemName" or "itemLink"[, slot])

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

local function BDBSetup()
    -- bonedust_brew,if=spinning_crane_kick.max&chi>=4
    if S.BonedustBrew:IsReady() and Target:IsInRange(8) and (SCKMax() and Player:Chi() >= 4) then
        return S.BonedustBrew:Cast()
    end
    -- blackout_kick,target_if=min:debuff.mark_of_the_crane.remains,if=combo_strike&!talent.whirling_dragon_punch
    if S.BlackoutKick:IsReady() and Target:IsInRange(8) and
        (ComboStrike(S.BlackoutKick) and not S.WhirlingDragonPunch:IsAvailable()) then
        return S.BlackoutKick:Cast()
    end

    -- rising_sun_kick,target_if=min:debuff.mark_of_the_crane.remains,if=combo_strike&chi>=5
    if S.RisingSunKick:IsReady() and Target:IsInRange(8) and (ComboStrike(S.RisingSunKick) and Player:Chi() >= 5) then
        return S.RisingSunKick:Cast()
    end
    -- tiger_palm,target_if=min:debuff.mark_of_the_crane.remains+(debuff.skyreach_exhaustion.up*20),if=combo_strike&chi.max-chi>=2
    if S.TigerPalm:IsReady() and (Target:IsInRange(10) and S.SkyReach:IsAvailable() or Target:IsInRange(8)) and
        (ComboStrike(S.TigerPalm) and Player:ChiDeficit() >= 2) and
        (Target:IsInRange(10) and S.SkyReach:IsAvailable() or Target:IsInRange(8)) then
        return Cast(S.TigerPalm)
    end
    -- rising_sun_kick,target_if=min:debuff.mark_of_the_crane.remains,if=combo_strike&active_enemies>=2
    if S.RisingSunKick:IsReady() and Target:IsInRange(8) and (ComboStrike(S.RisingSunKick) and Enemies10y >= 2) then
        return S.RisingSunKick:Cast()
    end
end

local function CDSerenity()
    -- summon_white_tiger_statue,if=pet.xuen_the_white_tiger.active
    if S.SummonWhiteTigerStatue:IsReady() and (XuenActive) and Target:IsInRange(5) then
        return S.SummonWhiteTigerStatue:Cast()
    end
    -- invoke_xuen_the_white_tiger,if=!variable.hold_xuen&talent.bonedust_brew&cooldown.bonedust_brew.remains<=5|fight_remains<25
    if S.InvokeXuenTheWhiteTiger:IsReady() and Target:IsInRange(8) and
        (
        (not VarHoldXuen) and S.BonedustBrew:IsAvailable() and S.BonedustBrew:CooldownRemains() <= 5 or Target:TimeToDie() < 25
        ) then
        return S.InvokeXuenTheWhiteTiger:Cast()
    end
    -- invoke_xuen_the_white_tiger,if=!variable.hold_xuen&!talent.bonedust_brew&(cooldown.rising_sun_kick.remains<2)|fight_remains<25
    if S.InvokeXuenTheWhiteTiger:IsReady() and Target:IsInRange(8) and
        (
        (not VarHoldXuen) and (not S.BonedustBrew:IsAvailable()) and S.RisingSunKick:CooldownRemains() < 2 or
            Target:TimeToDie() < 25) then
        return S.InvokeXuenTheWhiteTiger:Cast()
    end
    -- bonedust_brew,if=!buff.bonedust_brew.up&(cooldown.serenity.up|cooldown.serenity.remains>15|fight_remains<30&fight_remains>10)|fight_remains<10
    if S.BonedustBrew:IsReady() and Target:IsInRange(8) and
        (
        not Player:Buff(S.BonedustBrewBuff) and
            (S.Serenity:CooldownUp() or S.Serenity:CooldownRemains() > 15 or Target:TimeToDie() < 30 and Target:TimeToDie() > 10) or
            Target:TimeToDie() < 10) then
        return S.BonedustBrew:Cast()
    end
    -- serenity,if=pet.xuen_the_white_tiger.active|cooldown.invoke_xuen_the_white_tiger.remains>10|!talent.invoke_xuen_the_white_tiger|fight_remains<15
    if S.Serenity:IsReady() and Target:IsInRange(8) and
        (
        XuenActive or S.InvokeXuenTheWhiteTiger:CooldownRemains() > 10 or (not S.InvokeXuenTheWhiteTiger:IsAvailable())
            or
            Target:TimeToDie() < 15) then
        return S.Serenity:Cast()
    end
    -- With Xuen: touch_of_death,if=combo_strike&(fight_remains>60|pet.xuen_the_white_tiger.active&buff.bonedust_brew.up|(cooldown.invoke_xuen_the_white_tiger.remains>fight_remains)&buff.bonedust_brew.up|fight_remains<10)
    -- Without Xuen: touch_of_death,if=combo_strike&target.health=0&(fight_remains>60|buff.bonedust_brew.up|fight_remains<10)
    -- Skipping last line, as target.health=0 would end the fight...
    if S.TouchofDeath:IsReady() and Target:IsInRange(8) and
        (
        S.InvokeXuenTheWhiteTiger:IsAvailable() and
            (
            ComboStrike(S.TouchofDeath) and
                (
                Target:TimeToDie() > 60 or XuenActive and Player:Buff(S.BonedustBrewBuff) or
                    (S.InvokeXuenTheWhiteTiger:CooldownRemains() > Target:TimeToDie()) and Player:Buff(S.BonedustBrewBuff) or
                    Target:TimeToDie() < 10))) then
        return S.TouchofDeath:Cast()
    end
    -- touch_of_karma,if=fight_remains>90|fight_remains<10
    -- if S.TouchofKarma:IsReady() and Target:IsInRange(8) and RubimRH.CDsON() and
    --     (Target:TimeToDie() > 90 or Target:TimeToDie() < 10) then
    --     return S.TouchofDeath:Cast()
    -- end
    if (Player:Buff(S.SerenityBuff) or Target:TimeToDie() < 20) and Target:IsInRange(8) then
        -- ancestral_call,if=buff.serenity.up|fight_remains<20
        if S.AncestralCall:IsReady() then
            return S.AncestralCall:Cast()
        end
        -- blood_fury,if=buff.serenity.up|fight_remains<20
        if S.BloodFury:IsReady() then
            return S.BloodFury:Cast()
        end
        -- fireblood,if=buff.serenity.up|fight_remains<20
        if S.Fireblood:IsReady() then
            return S.Fireblood:Cast()
        end
        -- berserking,if=buff.serenity.up|fight_remains<20
        if S.Berserking:IsReady() then
            return S.Berserking:Cast()
        end
        -- bag_of_tricks,if=buff.serenity.up|fight_remains<20
        if S.BagofTricks:IsReady() then
            return S.BagofTricks:Cast()
        end
    end
    -- lights_judgment
    if S.LightsJudgment:IsReady() and Target:IsInRange(8) then
        return S.LightsJudgment:Cast()
    end
    -- use_items
    if RubimRH.CDsON() and Target:IsInRange(8) then
        local ShouldReturn = UseItems();
        if ShouldReturn then return ShouldReturn; end
    end
end

local function Serenity()
    -- strike_of_the_windlord,if=active_enemies<3
    if S.StrikeoftheWindlord:IsReady() and (Enemies10y < 3) and Target:IsInRange(8) then
        return S.StrikeoftheWindlord:Cast()
    end
    -- faeline_stomp,if=combo_strike&(!talent.faeline_harmony|debuff.fae_exposure_damage.remains<1)
    if S.FaelineStomp:IsReady() and Target:IsInRange(8) and
        (
        ComboStrike(S.FaelineStomp) and
            ((not S.FaelineHarmony:IsAvailable()) or Target:DebuffRemains(S.FaeExposureDebuff) < 1)) then
        return S.FaelineStomp:Cast()
    end
    -- blackout_kick,target_if=min:debuff.mark_of_the_crane.remains,if=combo_strike&buff.teachings_of_the_monastery.stack=3
    if S.BlackoutKick:IsReady() and Target:IsInRange(8) and
        (ComboStrike(S.BlackoutKick) and Player:BuffStack(S.TeachingsoftheMonasteryBuff) == 3) then
        return S.BlackoutKick:Cast()
    end
    -- fists_of_fury,if=buff.serenity.remains<1
    -- fists_of_fury_cancel
    if S.FistsofFury:IsReady() and Target:IsInRange(8) and (not Player:IsChanneling(S.FistsofFury)) and
        (Player:BuffRemains(S.SerenityBuff) < 1) then
        return S.FistsofFury:Cast()
    end
    -- blackout_kick,target_if=min:debuff.mark_of_the_crane.remains,if=combo_strike&active_enemies=3&buff.teachings_of_the_monastery.stack=2
    if S.BlackoutKick:IsReady() and Target:IsInRange(8) and
        (ComboStrike(S.BlackoutKick) and Enemies10y == 3 and Player:BuffStack(S.TeachingsoftheMonasteryBuff) == 2) then
        return S.BlackoutKick:Cast()
    end
    -- spinning_crane_kick,if=combo_strike&(active_enemies>3|active_enemies>2&spinning_crane_kick.modifier>=2.3)
    if S.SpinningCraneKick:IsReady() and Target:IsInRange(10) and
        (ComboStrike(S.SpinningCraneKick) and (Enemies10y > 3 or Enemies10y > 2 and SCKModifier() >= 2.3)) then
        return S.SpinningCraneKick:Cast()
    end
    -- strike_of_the_windlord,if=active_enemies>=3
    if S.StrikeoftheWindlord:IsReady() and Target:IsInRange(8) and (Enemies10y >= 3) then
        return S.StrikeoftheWindlord:Cast()
    end
    -- spinning_crane_kick,if=combo_strike&active_enemies>1
    if S.SpinningCraneKick:IsReady() and Target:IsInRange(10) and (ComboStrike(S.SpinningCraneKick) and Enemies10y > 1) then
        return S.SpinningCraneKick:Cast()
    end
    -- whirling_dragon_punch,if=active_enemies>1
    if S.WhirlingDragonPunch:IsReady() and Target:IsInRange(8) and (Enemies10y > 1) then
        return S.WhirlingDragonPunch:Cast()
    end
    -- blackout_kick,target_if=min:debuff.mark_of_the_crane.remains,if=active_enemies>=3&cooldown.fists_of_fury.remains&talent.shadowboxing_treads
    if S.BlackoutKick:IsReady() and Target:IsInRange(8) and
        (Enemies10y >= 3 and S.FistsofFury:CooldownDown() and S.ShadowboxingTreads:IsAvailable()) then
        return S.BlackoutKick:Cast()
    end
    -- rushing_jade_wind,if=!buff.rushing_jade_wind.up&active_enemies>=3
    if S.RushingJadeWind:IsReady() and Target:IsInRange(8) and
        (not Player:Buff(S.RushingJadeWindBuff) and Enemies10y >= 3
        ) then
        return S.RushingJadeWind:Cast()
    end
    -- rising_sun_kick,target_if=min:debuff.mark_of_the_crane.remains
    if S.RisingSunKick:IsReady() and Target:IsInRange(8) then
        return S.RisingSunKick:Cast()
    end
    -- spinning_crane_kick,if=combo_strike&buff.dance_of_chiji.up
    if S.SpinningCraneKick:IsReady() and Target:IsInRange(10) and
        (ComboStrike(S.SpinningCraneKick) and Player:Buff(S.DanceofChijiBuff)) then
        return S.SpinningCraneKick:Cast()
    end
    -- blackout_kick,target_if=min:debuff.mark_of_the_crane.remains,if=combo_strike
    if S.BlackoutKick:IsReady() and Target:IsInRange(8) and (ComboStrike(S.BlackoutKick)) then
        return S.BlackoutKick:Cast()
    end
    -- whirling_dragon_punch
    if S.WhirlingDragonPunch:IsReady() and Target:IsInRange(8) then
        return S.WhirlingDragonPunch:Cast()
    end
    -- tiger_palm,target_if=min:debuff.mark_of_the_crane.remains,if=talent.teachings_of_the_monastery&buff.teachings_of_the_monastery.stack<3
    if S.TigerPalm:IsReady() and (Target:IsInRange(10) and S.SkyReach:IsAvailable() or Target:IsInRange(8)) and
        (S.TeachingsoftheMonastery:IsAvailable() and Player:BuffStack(S.TeachingsoftheMonasteryBuff) < 3) then
        return S.TigerPalm:Cast()
    end
end

local function APL()
    --------------------------------------------------------------------------------------------------------------------------------------------
    ----------------------------------------------------------Range-Checks/Variables------------------------------------------------------------
    --------------------------------------------------------------------------------------------------------------------------------------------
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




local XuenActive = (S.InvokeXuenTheWhiteTiger:TimeSinceLastCast() <= 24)
-- print(XuenActive)
local VarHoldXuen = ((not S.InvokeXuenTheWhiteTiger:IsAvailable() or S.InvokeXuenTheWhiteTiger:CooldownRemains() > Target:TimeToDie()   
  or    Target:TimeToDie() - S.InvokeXuenTheWhiteTiger:CooldownRemains() < 120 and    ((
            S.Serenity:IsAvailable() and Target:TimeToDie() > S.Serenity:CooldownRemains() and
                S.Serenity:CooldownRemains() > 10) or
            (
            S.StormEarthAndFire:FullRechargeTime() < Target:TimeToDie() and S.StormEarthAndFire:FullRechargeTime() > 15
            )
            or (S.StormEarthAndFire:Charges() == 0 and S.StormEarthAndFire:CooldownRemains() < Target:TimeToDie()))))

-- variable,name=hold_sef,op=set,value=cooldown.bonedust_brew.up&cooldown.storm_earth_and_fire.charges<2&chi<3|buff.bonedust_brew.remains<8
local VarHoldSEF = ( S.BonedustBrew:CooldownUp() and S.StormEarthAndFire:Charges() < 2 and Player:Chi() < 3 or  Player:BuffRemains(S.BonedustBrew) < 8)
-- print(S.StormEarthAndFire:FullRechargeTime())
-- print(Player:GetEnemiesInMeleeRange(10))

-- print('TP: ',ComboStrike(S.TigerPalm))
-- print('BOK: ',ComboStrike(S.BlackoutKick))


    --------------------------------------------------------------------------------------------------------------------------------------------
    ----------------------------------------------------------Interrupts/Queues-----------------------------------------------------------------
    --------------------------------------------------------------------------------------------------------------------------------------------

    if select(8, UnitCastingInfo("target")) == false and Target:CastPercentage() > math.random(43, 87) and
        RubimRH.InterruptsON() and S.SpearHandStrike:IsReadyQueue(8) and Player:AffectingCombat() then
        return S.SpearHandStrike:Cast()
    end


    if (S.CracklingJadeLightning:ID()== RubimRH.queuedSpell[1]:ID() 
    or S.ChiBurst:ID() == RubimRH.queuedSpell[1]:ID()
    or S.Vivify:ID() == RubimRH.queuedSpell[1]:ID()
    or S.SoothingMist:ID() == RubimRH.queuedSpell[1]:ID())
    and Player:MovingFor() > Player:GCD() then
        RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }

    end

    if not RubimRH.queuedSpell[1]:CooldownUp() or not Target:IsInRange(10) or not Player:AffectingCombat() then
        RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
    end

    if RubimRH.QueuedSpell():IsReadyQueue() then
        return RubimRH.QueuedSpell():Cast()
    end


    if Player:IsChanneling(S.FistsofFury) and Player:ChannelPercentage() < 80 and Player:BuffRemains(S.SerenityBuff) < 1
        and S.Serenity:IsAvailable() then
        return S.StopFoF:Cast()
    end


    if Player:IsCasting() or Player:IsChanneling() and not Player:IsChanneling(S.SpinningCraneKick) then
        return 0, "Interface\\Addons\\Rubim-RH\\Media\\channel.tga"
    elseif Player:IsDeadOrGhost() or AuraUtil.FindAuraByName("Drink", "player") or
        AuraUtil.FindAuraByName("Food", "player") or AuraUtil.FindAuraByName("Food & Drink", "player") then
        return 0, "Interface\\Addons\\Rubim-RH\\Media\\griph.tga"
    end


    --------------------------------------------------------------------------------------------------------------------------------------------
    ----------------------------------------------------------Defensives/Pots-------------------------------------------------------------------
    --------------------------------------------------------------------------------------------------------------------------------------------


    IsTanking = Player:IsTankingAoE(8) or Player:IsTanking(Target)

    if Player:HealthPercentage() <= 25 and Player:AffectingCombat() and IsUsableItem(191380) and
        GetItemCooldown(191380) == 0 and GetItemCount(191380) >= 1
        and (not Player:InArena() and not Player:InBattlegrounds()) then
        return I.HPIcon:Cast()
end

-- print(Target:TimeToDie())
-- print(BossTarget:TimeToDie())

    if S.TouchofKarma:IsReady() 
    and Enemies10y >= 1 
    and not Player:Buff(S.DampenHarmBuff) and not
        Player:Buff(S.FortifyingBrewBuff) and
        (
        Player:NeedPanicHealing() and Player:HealthPercentage() < 50 or
            RubimRH.CDsON() and Target:IsInRange(8) and IsTanking and Player:HealthPercentage() < 80) then
        return S.TouchofKarma:Cast()
    end

    if S.DampenHarm:IsReady()     and Enemies10y >= 1 and not Player:Buff(S.FortifyingBrewBuff) and
        (Player:HealthPercentage() <= 40) then
        return S.DampenHarm:Cast()
    end

    if S.FortifyingBrew:IsReady() and Enemies10y >= 1 and not Player:Buff(S.DampenHarmBuff) and
        ( Player:HealthPercentage() <= 35) then
        return S.FortifyingBrew:Cast()
    end

    if S.DiffuseMagic:IsReady()     and Enemies10y >= 1 and not Player:Buff(S.DampenHarmBuff) and not Player:Buff(S.FortifyingBrewBuff) and
        ( Player:HealthPercentage() <= 50) then
        return S.DiffuseMagic:Cast()
    end


    --------------------------------------------------------------------------------------------------------------------------------------------
    ----------------------------------------------------------StartRotation---------------------------------------------------------------------
    --------------------------------------------------------------------------------------------------------------------------------------------

    if Target:Exists() and Player:CanAttack(Target) and not Target:IsDeadOrGhost() then

        if not IsCurrentSpell(6603) and Player:CanAttack(Target)
        and Target:AffectingCombat() and Target:IsInRange(10) then
        return S.autoattack:Cast()
        end

        -- Manually added: Force landing from FSK
        -- if (not Settings.Windwalker.IgnoreFSK) and Player:PrevGCD(1, S.FlyingSerpentKick) and Target:IsInRange(5) then
        --   if Cast(S.FlyingSerpentKickLand) then return "flying_serpent_kick land"; end
        -- end

    --------------------------------------------------------------------------------------------------------------------------------------------
    ----------------------------------------------------------PreCombat-------------------------------------------------------------------------
    --------------------------------------------------------------------------------------------------------------------------------------------
        if not Player:AffectingCombat() then
                    -- summon_white_tiger_statue
            if S.SummonWhiteTigerStatue:IsReady() and RubimRH.CDsON() and Target:IsInRange(5) then
                return S.SummonWhiteTigerStatue:Cast()
            end
            -- expel_harm,if=chi<chi.max
            if S.ExpelHarm:IsReady() and (Player:Chi() < Player:ChiMax()) and Target:IsInRange(5) then
                return S.ExpelHarm:Cast()
            end
            -- chi_burst,if=!talent.faeline_stomp
            if S.ChiBurst:IsReady() and (not S.FaelineStomp:IsAvailable()) and Target:AffectingCombat() and Target:IsInRange(40) then
                return S.ChiBurst:Cast()
            end
            -- chi_wave
            if S.ChiWave:IsReady() and Target:AffectingCombat() and Target:IsInRange(40) then
                return S.ChiWave:Cast()
            end
        end

    --------------------------------------------------------------------------------------------------------------------------------------------
    ----------------------------------------------------------Opener----------------------------------------------------------------------------
    --------------------------------------------------------------------------------------------------------------------------------------------
    --call_action_list,name=opener,if=time<4&chi<5&!pet.xuen_the_white_tiger.active&!talent.serenity

        if HL.CombatTime() < 4 and Player:Chi() < 5 and not S.Serenity:IsAvailable() and (not XuenActive or not S.InvokeXuenTheWhiteTiger:IsAvailable()) then
  
            -- expel_harm,if=talent.chi_burst.enabled&chi.max-chi>=3
            if S.ExpelHarm:IsReady() and S.ChiBurst:IsAvailable() and Player:ChiDeficit() >= 3 and Target:IsInRange(8) then
                return S.ExpelHarm:Cast()
            end
            -- target_if=min:debuff.mark_of_the_crane.remains+(debuff.skyreach_exhaustion.up*20),if=combo_strike&chi.max-chi>=(2+buff.power_strikes.up)
            if S.TigerPalm:IsReady() and (Target:IsInRange(10) and S.SkyReach:IsAvailable() or Target:IsInRange(8)) and
                ComboStrike(S.TigerPalm) and Player:ChiDeficit() >= (2 + num(Player:Buff(S.PowerStrikesBuff))) then
                return S.TigerPalm:Cast()
            end
            -- chi_wave,if=chi.max-chi=2
            if S.ChiWave:IsReady() and (Player:ChiDeficit() >= 2) and Target:IsInRange(40) and Target:AffectingCombat() then
                return S.ChiWave:Cast()
            end
            -- expel_harm
            if S.ExpelHarm:IsReady() and Target:IsInRange(8) then
                return S.ExpelHarm:Cast()
            end
            -- tiger_palm,target_if=min:debuff.mark_of_the_crane.remains+(debuff.skyreach_exhaustion.up*20),if=chi.max-chi>=(2+buff.power_strikes.up)
            if S.TigerPalm:IsReady() and Player:ChiDeficit() >= (2 + num(Player:Buff(S.PowerStrikesBuff))) and
                (Target:IsInRange(10) and S.SkyReach:IsAvailable() or Target:IsInRange(8)) then
                return S.TigerPalm:Cast()
            end
        end


    --------------------------------------------------------------------------------------------------------------------------------------------
    ----------------------------------------------------------TP if not overcapping Chi or TotM-------------------------------------------------
    --------------------------------------------------------------------------------------------------------------------------------------------
    
    -- tiger_palm,target_if=min:debuff.mark_of_the_crane.remains+(debuff.skyreach_exhaustion.up*20),
    -- if=!buff.serenity.up&buff.teachings_of_the_monastery.stack<3&combo_strike&chi.max-chi>=(2+buff.power_strikes.up)
    -- &(!talent.invoke_xuen_the_white_tiger&!talent.serenity|(!talent.skyreach|time>5|pet.xuen_the_white_tiger.active))
    -- if S.TigerPalm:IsReady() and (Target:IsInRange(10) and S.SkyReach:IsAvailable() or Target:IsInRange(8)) then
    --     if not Player:Buff(S.SerenityBuff) and Player:BuffStack(S.TeachingsoftheMonasteryBuff)<3 and (ComboStrike(S.TigerPalm) 
    --     and Player:ChiDeficit() >= (2 + num(Player:Buff(S.PowerStrikesBuff)))) 
    --     and (not S.InvokeXuenTheWhiteTiger:IsAvailable() and not S.Serenity:IsAvailable() 
    --     or not S.SkyReach:IsAvailable() or HL.CombatTime()>5 or (not XuenActive or not S.InvokeXuenTheWhiteTiger:IsAvailable())) then
    -- return S.TigerPalm:Cast()
    -- end
    -- end

    --------------------------------------------------------------------------------------------------------------------------------------------
    ---------------------------------------------------------------------CDSEF------------------------------------------------------------------
    --------------------------------------------------------------------------------------------------------------------------------------------
    if not S.Serenity:IsAvailable() and S.StormEarthAndFire:IsAvailable() and RubimRH.CDsON() then
            -- summon_white_tiger_statue,if=pet.xuen_the_white_tiger.active
            if S.SummonWhiteTigerStatue:IsReady() and (XuenActive) and Target:IsInRange(5)  then
                return S.SummonWhiteTigerStatue:Cast()
            end

            -- invoke_xuen_the_white_tiger,if=!variable.hold_xuen&talent.bonedust_brew&cooldown.bonedust_brew.remains<=5&(active_enemies<3&chi>=3|active_enemies>=3&chi>=2)|fight_remains<25
            if S.InvokeXuenTheWhiteTiger:IsReady() and Target:IsInRange(8) 
            and ((not VarHoldXuen) and S.BonedustBrew:IsAvailable() and S.BonedustBrew:CooldownRemains() <= 5 and
                    (Enemies10y < 3 and Player:Chi() >= 3 or Enemies10y >= 3 and Player:Chi() >= 2) or Target:TimeToDie() < 25) then
                return S.InvokeXuenTheWhiteTiger:Cast()
            end

            -- invoke_xuen_the_white_tiger,if=!variable.hold_xuen&!talent.bonedust_brew&(cooldown.rising_sun_kick.remains<2)&chi>=3
            if S.InvokeXuenTheWhiteTiger:IsReady() and Target:IsInRange(8)  and
                ((not VarHoldXuen) and (not S.BonedustBrew:IsAvailable()) and S.RisingSunKick:CooldownRemains() < 2 and
                    Player:Chi() >= 3) then
                return S.InvokeXuenTheWhiteTiger:Cast()
            end

            -- storm_earth_and_fire,if=talent.bonedust_brew&(fight_remains<30&cooldown.bonedust_brew.remains<4&chi>=4|buff.bonedust_brew.up|!spinning_crane_kick.max&active_enemies>=3&cooldown.bonedust_brew.remains<=2&chi>=2)&(pet.xuen_the_white_tiger.active|cooldown.invoke_xuen_the_white_tiger.remains>cooldown.storm_earth_and_fire.full_recharge_time)
            if S.StormEarthAndFire:IsReady()  and Target:IsInRange(8) and
                (
                S.BonedustBrew:IsAvailable() and
                    (
                    Target:TimeToDie() < 30 and S.BonedustBrew:CooldownRemains() < 4 and Player:Chi() >= 4 or
                        Player:Buff(S.BonedustBrewBuff) and (not VarHoldSEF) or
                        (not SCKMax()) and Enemies10y >= 3 and S.BonedustBrew:CooldownRemains() <= 2 and Player:Chi() >= 2) and
                    (XuenActive or S.InvokeXuenTheWhiteTiger:CooldownRemains() > S.StormEarthAndFire:FullRechargeTime())) then
                return S.StormEarthAndFire:Cast()
            end

            -- bonedust_brew,if=(!buff.bonedust_brew.up&buff.storm_earth_and_fire.up&buff.storm_earth_and_fire.remains<11&spinning_crane_kick.max)|(!buff.bonedust_brew.up&fight_remains<30&fight_remains>10&spinning_crane_kick.max&chi>=4)|fight_remains<10
            if S.BonedustBrew:IsReady() and Target:IsInRange(8) and
                (
                (
                    not Player:Buff(S.BonedustBrewBuff) and Player:Buff(S.StormEarthAndFireBuff) and
                        Player:BuffRemains(S.StormEarthAndFireBuff) < 11 and SCKMax()) or
                    (
                    not Player:Buff(S.BonedustBrewBuff) and Target:TimeToDie() < 30 and Target:TimeToDie() > 10 and SCKMax() and
                        Player:Chi() >= 4) or Target:TimeToDie() < 10) then
                return S.BonedustBrew:Cast()
            end

            -- call_action_list,name=bdb_setup,if=!buff.bonedust_brew.up&talent.bonedust_brew&cooldown.bonedust_brew.remains<=2&(fight_remains>60&(cooldown.storm_earth_and_fire.charges>0|cooldown.storm_earth_and_fire.remains>10)&(pet.xuen_the_white_tiger.active|cooldown.invoke_xuen_the_white_tiger.remains>10|variable.hold_xuen)|((pet.xuen_the_white_tiger.active|cooldown.invoke_xuen_the_white_tiger.remains>13)&(cooldown.storm_earth_and_fire.charges>0|cooldown.storm_earth_and_fire.remains>13|buff.storm_earth_and_fire.up)))
            if (
                not Player:Buff(S.BonedustBrewBuff)  and S.BonedustBrew:IsAvailable() and S.BonedustBrew:CooldownRemains() <= 2
                    and
                    (
                    Target:TimeToDie() > 60 and (S.StormEarthAndFire:Charges() > 0 or S.StormEarthAndFire:CooldownRemains() > 10) and
                        (XuenActive or S.InvokeXuenTheWhiteTiger:CooldownRemains() > 10 or VarHoldXuen) or
                        (
                        (XuenActive or S.InvokeXuenTheWhiteTiger:CooldownRemains() > 13) and
                            (
                            S.StormEarthAndFire:Charges() > 0 or S.StormEarthAndFire:CooldownRemains() > 13 or
                                Player:Buff(S.StormEarthAndFireBuff))))) then
                local ShouldReturn = BDBSetup();
                if ShouldReturn then return ShouldReturn; end
            end

            -- storm_earth_and_fire,if=fight_remains<20|(cooldown.storm_earth_and_fire.charges=2&cooldown.invoke_xuen_the_white_tiger.remains>cooldown.storm_earth_and_fire.full_recharge_time)&cooldown.fists_of_fury.remains<=9&chi>=2&cooldown.whirling_dragon_punch.remains<=12
            if S.StormEarthAndFire:IsReady()  and Target:IsInRange(8) and
                (
                Target:TimeToDie() < 20 or
                    (
                    S.StormEarthAndFire:Charges() == 2 and
                        S.InvokeXuenTheWhiteTiger:CooldownRemains() > S.StormEarthAndFire:FullRechargeTime()) and
                    S.FistsofFury:CooldownRemains() <= 9 and Player:Chi() >= 2 and S.WhirlingDragonPunch:CooldownRemains() <= 12
                ) then
                return S.StormEarthAndFire:Cast()
            end

            -- touch_of_death,cycle_targets=1,if=combo_strike
            if S.TouchofDeath:IsReady()  and Target:IsInRange(8) and
                (
                (
                    S.InvokeXuenTheWhiteTiger:IsAvailable() and
                        (
                        ComboStrike(S.TouchofDeath) and
                            (
                            Target:TimeToDie() > 60 or
                                not Player:Buff(S.StormEarthAndFireBuff) and XuenActive and Player:Buff(S.BonedustBrewBuff) or
                                (S.InvokeXuenTheWhiteTiger:CooldownRemains() > Target:TimeToDie()) and Player:Buff(S.BonedustBrewBuff)
                                or Target:TimeToDie() < 10))) or
                    (
                    (not S.InvokeXuenTheWhiteTiger:IsAvailable()) and
                        (
                        ComboStrike(S.TouchofDeath) and
                            (
                            Target:TimeToDie() > 60 or not Player:Buff(S.StormEarthAndFireBuff) and Player:Buff(S.BonedustBrewBuff) or
                                Target:TimeToDie() < 10)))) then
                return S.TouchofDeath:Cast()
            end

            -- use_item,name=irideus_fragment,if=cooldown.invoke_xuen_the_white_tiger.remains>cooldown%%120|cooldown<=60&variable.hold_xuen|!talent.invoke_xuen_the_white_tiger
            if  Target:IsInRange(8) then
                local ShouldReturn = UseItems();
                if ShouldReturn then return ShouldReturn; end
            end

            -- touch_of_karma,target_if=max:target.time_to_die,if=fight_remains>90|pet.xuen_the_white_tiger.active|variable.hold_xuen|fight_remains<16
            -- if S.TouchofKarma:IsReady() and Target:IsInRange(8) and
            --     (
            --     (
            --         S.InvokeXuenTheWhiteTiger:IsAvailable() and
            --             (Target:TimeToDie() > 90 or XuenActive or VarHoldXuen or Target:TimeToDie() < 16)
            --         ) or ((not S.InvokeXuenTheWhiteTiger:IsAvailable()) and (Target:TimeToDie() > 159 or VarHoldXuen))) then
            --     return S.TouchofKarma:Cast()
            -- end

            -- ancestral_call,if=cooldown.invoke_xuen_the_white_tiger.remains>30|variable.hold_xuen|fight_remains<20
            if S.AncestralCall:IsReady()  and Target:IsInRange(8) and
                (S.InvokeXuenTheWhiteTiger:CooldownRemains() > 30 or VarHoldXuen or Target:TimeToDie() < 20) then
                return S.AncestralCall:Cast()
            end
            -- blood_fury,if=cooldown.invoke_xuen_the_white_tiger.remains>30|variable.hold_xuen|fight_remains<20
            if S.BloodFury:IsReady()  and Target:IsInRange(8) and
                (S.InvokeXuenTheWhiteTiger:CooldownRemains() > 30 or VarHoldXuen or Target:TimeToDie() < 20) then
                return S.BloodFury:Cast()
            end
            -- fireblood,if=cooldown.invoke_xuen_the_white_tiger.remains>30|variable.hold_xuen|fight_remains<10
            if S.Fireblood:IsReady() and Target:IsInRange(8) and
                (S.InvokeXuenTheWhiteTiger:CooldownRemains() > 30 or VarHoldXuen or Target:TimeToDie() < 10) then
                return S.Fireblood:Cast()
            end
            -- berserking,if=cooldown.invoke_xuen_the_white_tiger.remains>30|variable.hold_xuen|fight_remains<15
            if S.Berserking:IsReady()  and Target:IsInRange(8) and
                (S.InvokeXuenTheWhiteTiger:CooldownRemains() > 30 or VarHoldXuen or Target:TimeToDie() < 15
                ) then
                return S.Berserking:Cast()
            end
            -- bag_of_tricks,if=buff.storm_earth_and_fire.down
            if S.BagofTricks:IsReady()  and Target:IsInRange(8) and (not Player:Buff(S.StormEarthAndFireBuff)) then
                return S.BagofTricks:Cast()
            end
            -- lights_judgment
            if S.LightsJudgment:IsReady() and Target:IsInRange(8) then
                return S.LightsJudgment:Cast()
            end

                end
    --------------------------------------------------------------------------------------------------------------------------------------------
    ----------------------------------------------------------------CDSerenity------------------------------------------------------------------
    --------------------------------------------------------------------------------------------------------------------------------------------




        --5 targets

        -- Strike of the Windlord
        if Enemies10y >= 5 then
            -- if S.InvokeXuenTheWhiteTiger:IsReady() and Target:IsInRange(8) and RubimRH.CDsON() then
            --     return S.InvokeXuenTheWhiteTiger:Cast()
            -- end

            if S.TouchofDeath:IsReady() and Target:IsInRange(8) and RubimRH.CDsON() then
                return S.TouchofDeath:Cast()
            end
            
            if S.ExpelHarm:IsReady() and Target:IsInRange(8) and Player:Chi() < 6 and ComboStrike(S.ExpelHarm) then
                return S.ExpelHarm:Cast()
            end

            if S.TigerPalm:IsReady() and Target:IsInRange(8) and Player:Chi() < 5 and ComboStrike(S.TigerPalm) then
                return S.TigerPalm:Cast()
            end

            if S.StrikeoftheWindlord:IsReady() and Target:IsInRange(8) and RubimRH.CDsON() then
                return S.StrikeoftheWindlord:Cast()
            end

            -- Blackout Kick with 3 stacks of Teachings of the Monastery
            if S.BlackoutKick:IsReady() and ComboStrike(S.BlackoutKick) and
                Player:BuffStack(S.TeachingsoftheMonasteryBuff) ==
                3 and Target:IsInRange(8) then
                return S.BlackoutKick:Cast()
            end


            -- Spinning Crane Kick with Dance of Chi-Ji proc
            if S.SpinningCraneKick:IsReady() and ComboStrike(S.SpinningCraneKick) and Player:Buff(S.DanceofChijiBuff) and
                Target:IsInRange(10) then
                return S.SpinningCraneKick:Cast()
            end


            -- Fists of Fury
            if S.FistsofFury:IsReady() and ComboStrike(S.FistsofFury) and Target:IsInRange(8) then
                return S.FistsofFury:Cast()
            end

            -- Faeline Stomp if targets don’t have Faeline Harmony debuff
            -- if S.FaelineStomp:IsReady() and ComboStrike(S.FaelineStomp) and Target:IsInRange(8) and not Target:Debuff(S.FaelineHarmony) then
            --   return Cast(S.FaelineStomp)
            -- end

            -- Whirling Dragon Punch
            if S.WhirlingDragonPunch:IsReady() and ComboStrike(S.WhirlingDragonPunch) and Target:IsInRange(8) then
                return S.WhirlingDragonPunch:Cast()
            end

            -- Rushing Jade Wind
            if S.RushingJadeWind:IsReady() and Target:IsInRange(8) then
                return S.RushingJadeWind:Cast()
            end

            -- Spinning Crane Kick
            if S.SpinningCraneKick:IsReady() and ComboStrike(S.SpinningCraneKick) and Target:IsInRange(10) then
                return S.SpinningCraneKick:Cast()
            end

            -- Blackout Kick
            if S.BlackoutKick:IsReady() and ComboStrike(S.BlackoutKick) and Target:IsInRange(8) then
                return S.BlackoutKick:Cast()
            end

            -- Rising Sun Kick with Xuen's Battlegear crit buff
            if S.RisingSunKick:IsReady() and ComboStrike(S.RisingSunKick) and Player:Buff(S.XuensBattlegear) and
                Target:IsInRange(8) then
                return S.RisingSunKick:Cast()
            end

            -- Rising Sun Kick ONLY to trigger Whirling Dragon Punch
            if S.RisingSunKick:IsReady() and ComboStrike(S.RisingSunKick) and S.WhirlingDragonPunch:CooldownRemains() < 1
                and
                Target:IsInRange(8) then
                return S.RisingSunKick:Cast()
            end

            -- Faeline Stomp
            -- if S.FaelineStomp:IsReady() and ComboStrike(S.FaelineStomp) and Target:IsInRange(8) then
            --   return Cast(S.FaelineStomp)
            -- end

            -- Chi Burst
            if S.ChiBurst:IsReady() and ComboStrike(S.ChiBurst) and Target:IsInRange(40) then
                return S.ChiBurst:Cast()
            end

            -- Chi Wave
            if S.ChiWave:IsReady() and Target:IsInRange(40) then
                return S.ChiWave:Cast()
            end


            if S.ExpelHarm:IsReady() and ComboStrike(S.ExpelHarm) and Target:IsInRange(8) then
                return S.ExpelHarm:Cast()
            end

            if S.TigerPalm:IsReady() and ComboStrike(S.TigerPalm) and (S.SkyReach:IsAvailable() and Target:IsInRange(10) or Target:IsInRange(8)) then
                return S.TigerPalm:Cast()
            end

        end

        -- 2-4 targets
        if Enemies10y >= 2 and Enemies10y < 5 then



            -- if S.InvokeXuenTheWhiteTiger:IsReady() and Target:IsInRange(8) and RubimRH.CDsON() then
            --     return S.InvokeXuenTheWhiteTiger:Cast()
            -- end

            if S.TouchofDeath:IsReady() and Target:IsInRange(8) and RubimRH.CDsON() then
                return S.TouchofDeath:Cast()
            end
            
            if S.ExpelHarm:IsReady() and Target:IsInRange(8) and Player:Chi() < 6 and ComboStrike(S.ExpelHarm) then
                return S.ExpelHarm:Cast()
            end

            if S.TigerPalm:IsReady() and Target:IsInRange(8) and Player:Chi() < 5 and ComboStrike(S.TigerPalm) then
                return S.TigerPalm:Cast()
            end

            -- Blackout Kick with 3 stacks of Teachings of the Monastery
            if S.BlackoutKick:IsReady() and ComboStrike(S.BlackoutKick) and
                Player:BuffStack(S.TeachingsoftheMonasteryBuff) ==
                3 and Target:IsInRange(8) then
                return S.BlackoutKick:Cast()
            end

            -- Strike of the Windlord
            if S.StrikeoftheWindlord:IsReady() and Target:IsInRange(8) and RubimRH.CDsON() then
                return S.StrikeoftheWindlord:Cast()
            end

            -- Fists of Fury
            if S.FistsofFury:IsReady() and ComboStrike(S.FistsofFury) and Target:IsInRange(8) then
                return S.FistsofFury:Cast()
            end

            -- Faeline Stomp if targets don’t have Faeline Harmony debuff
            -- if S.FaelineStomp:IsReady() and ComboStrike(S.FaelineStomp) and Target:IsInRange(8) and not Target:Debuff(S.FaelineHarmony) then
            --   return Cast(S.FaelineStomp)
            -- end


            -- Spinning Crane Kick with Dance of Chi-Ji proc
            if S.SpinningCraneKick:IsReady() and ComboStrike(S.SpinningCraneKick) and Player:Buff(S.DanceofChijiBuff) and
                Target:IsInRange(10) then
                return S.SpinningCraneKick:Cast()
            end

            -- Whirling Dragon Punch
            if S.WhirlingDragonPunch:IsReady() and ComboStrike(S.WhirlingDragonPunch) and Target:IsInRange(8) then
                return S.WhirlingDragonPunch:Cast()
            end

            -- Blackout Kick
            if S.BlackoutKick:IsReady() and ComboStrike(S.BlackoutKick) and Target:IsInRange(8) then
                return S.BlackoutKick:Cast()
            end

            -- Rising Sun Kick with Xuen's Battlegear crit buff
            if S.RisingSunKick:IsReady() and ComboStrike(S.RisingSunKick) and Player:Buff(S.XuensBattlegear) and
                Target:IsInRange(8) then
                return S.RisingSunKick:Cast()
            end

            -- Rushing Jade Wind
            if S.RushingJadeWind:IsReady() and Target:IsInRange(8) then
                return S.RushingJadeWind:Cast()
            end

            -- Rising Sun Kick ONLY to trigger Whirling Dragon Punch
            if S.RisingSunKick:IsReady() and ComboStrike(S.RisingSunKick) and S.WhirlingDragonPunch:CooldownRemains() < 1
                and
                Target:IsInRange(8) then
                return S.RisingSunKick:Cast()
            end

            -- Spinning Crane Kick
            if S.SpinningCraneKick:IsReady() and ComboStrike(S.SpinningCraneKick) and Target:IsInRange(10) then
                return S.SpinningCraneKick:Cast()
            end

            -- Faeline Stomp
            -- if S.FaelineStomp:IsReady() and ComboStrike(S.FaelineStomp) and Target:IsInRange(8) then
            --   return Cast(S.FaelineStomp)
            -- end

               -- Chi Burst
            if S.ChiBurst:IsReady() and Target:IsInRange(40) then
                return S.ChiBurst:Cast()
            end

            -- Chi Wave
            if S.ChiWave:IsReady() and Target:IsInRange(40) then
                return S.ChiWave:Cast()
            end

            if S.ExpelHarm:IsReady() and ComboStrike(S.ExpelHarm) and Target:IsInRange(8) then
                return S.ExpelHarm:Cast()
            end

            if S.TigerPalm:IsReady() and ComboStrike(S.TigerPalm) and (S.SkyReach:IsAvailable() and Target:IsInRange(10) or Target:IsInRange(8)) then
                return S.TigerPalm:Cast()
            end


        end

        -- ST
        if Enemies10y == 1 then


            -- if S.InvokeXuenTheWhiteTiger:IsReady() and Target:IsInRange(8) and RubimRH.CDsON() then
            --     return S.InvokeXuenTheWhiteTiger:Cast()
            -- end

            if S.TouchofDeath:IsReady() and Target:IsInRange(8) and RubimRH.CDsON() then
                return S.TouchofDeath:Cast()
            end
            
            if S.ExpelHarm:IsReady() and Target:IsInRange(8) and Player:Chi() < 6 and ComboStrike(S.ExpelHarm) then
                return S.ExpelHarm:Cast()
            end

            if S.TigerPalm:IsReady() and Target:IsInRange(8) and Player:Chi() < 5 and ComboStrike(S.TigerPalm) then
                return S.TigerPalm:Cast()
            end

            -- Blackout Kick with 3 stacks of Teachings of the Monastery
            if S.BlackoutKick:IsReady() and Player:BuffStack(S.TeachingsoftheMonasteryBuff) == 3 and Target:IsInRange(8) then
                return S.BlackoutKick:Cast()
            end
            -- Strike of the Windlord
            if S.StrikeoftheWindlord:IsReady() and Target:IsInRange(8) and RubimRH.CDsON() then
                return S.StrikeoftheWindlord:Cast()
            end
            -- Faeline Stomp if targets don’t have Faeline Harmony debuff
            -- if S.FaelineStomp:IsReady() and ComboStrike(S.FaelineStomp) and Target:IsInRange(8) and not Target:Debuff(S.FaelineHarmony) then
            --   return Cast(S.FaelineStomp)
            -- end

            -- Rising Sun Kick with Xuen's Battlegear crit buff
            if S.RisingSunKick:IsReady() and ComboStrike(S.RisingSunKick) and Player:Buff(S.XuensBattlegear) and
                Target:IsInRange(8) then
                return S.RisingSunKick:Cast()
            end

            -- Fists of Fury
            if S.FistsofFury:IsReady() and ComboStrike(S.FistsofFury) and Target:IsInRange(8) then
                return S.FistsofFury:Cast()
            end

            -- Rising Sun Kick
            if S.RisingSunKick:IsReady() and ComboStrike(S.RisingSunKick) and Target:IsInRange(8) then
                return S.RisingSunKick:Cast()
            end

            -- Whirling Dragon Punch
            if S.WhirlingDragonPunch:IsReady() and ComboStrike(S.WhirlingDragonPunch) and Target:IsInRange(8) then
                return S.WhirlingDragonPunch:Cast()
            end

            -- Spinning Crane Kick with Dance of Chi-Ji proc
            if S.SpinningCraneKick:IsReady() and ComboStrike(S.SpinningCraneKick) and Player:Buff(S.DanceofChijiBuff) and
                Target:IsInRange(10) then
                return S.SpinningCraneKick:Cast()
            end

            -- Blackout Kick
            if S.BlackoutKick:IsReady() and ComboStrike(S.BlackoutKick) and Target:IsInRange(8) then
                return S.BlackoutKick:Cast()
            end

            -- Rushing Jade Wind
            if S.RushingJadeWind:IsReady() and ComboStrike(S.RushingJadeWind) and Target:IsInRange(8) then
                return S.RushingJadeWind:Cast()
            end

            -- Spinning Crane Kick
            if S.SpinningCraneKick:IsReady() and ComboStrike(S.SpinningCraneKick) and Target:IsInRange(10) then
                return S.SpinningCraneKick:Cast()
            end
        end


        -- Chi Wave
        if S.ChiWave:IsReady() and Target:IsInRange(40) then
            return S.ChiWave:Cast()
        end



        -- Chi Burst
        if S.ChiBurst:IsReady() and Target:IsInRange(40) then
            return S.ChiBurst:Cast()
        end

        if Enemies10y == 1 then

            if S.ExpelHarm:IsReady() and ComboStrike(S.ExpelHarm) and Target:IsInRange(8) then
                return S.ExpelHarm:Cast()
            end

            if S.TigerPalm:IsReady() and ComboStrike(S.TigerPalm) and (S.SkyReach:IsAvailable() and Target:IsInRange(10) or Target:IsInRange(8)) then
                return S.TigerPalm:Cast()
            end
        end

        if Player:AffectingCombat() then
            return 0, 135328
        end
         
    
end



    return 0, "Interface\\Addons\\Rubim-RH\\Media\\griph.tga"
end

RubimRH.Rotation.SetAPL(269, APL);

local function PASSIVE()

end

RubimRH.Rotation.SetPASSIVE(269, PASSIVE);
