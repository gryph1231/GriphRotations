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

    BlessingofFreedom = Spell(1044),
    BlindingLight = Spell(115750),
    SenseUndead = Spell(5502),

CleanseToxins = Spell(213644),
    autoattack = Spell(291944), -- regeneratin
    wristsx = Spell(255647), -- lights judgmenet
    tempestofthelightbringer = Spell(383396),

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
    FinalStand = Spell(204077),
    Consecration             = Spell(26573),
    CrusaderStrike           = Spell(35395),
    DivineShield             = Spell(642),
    DivineSteed              = Spell(190784),
    FlashofLight             = Spell(19750),
    HammerofJustice          = Spell(853),
    HandofReckoning          = Spell(62124),
    Rebuke                   = Spell(96231),
    ShieldoftheRighteous     = Spell(53600),
    WordofGlory              = Spell(85673),
    -- Talents
    AvengingWrath            = Spell(31884),
    HammerofWrath            = Spell(24275),
    HolyAvenger              = Spell(105809),
    HolyAvengerBuff          = Spell(105809),
    LayonHands               = Spell(633),
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
    intercession           = Spell(105809),
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
    -- Pool


    -- Pool                                  = Spell(999910),
    Pool = Spell(397799),


    lust1 = Spell(57724),
    lust2 = Spell(57723),
    lust3 = Spell(80354),
    lust4 = Spell(95809),
    lust5 = Spell(264689),
    lustAT                   = Spell(20549), -- war stomp

    EyeofTyr = Spell(387174),
   

    ArdentDefender             = Spell(31850),
    ArdentDefenderBuff         = Spell(31850),
    AvengersShield             = Spell(31935),
    GuardianofAncientKings     = Spell(86659),

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
    drums = Item(193470),

    HPIcon = Item(169451),
    tx1 = Item(118330),
    tx2 = Item(114616),
};
local I = Item.Paladin.Protection;


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



local function mitigate()
    if Player:AffectingCombat() then
      
            for id = 1, 40 do

                local spell = {'Savage Peck', 'Barkbreaker','Shield of Light','Savage Blade', 'Dark Claw','Jade Serpent Strike',
                                'Bloodletting Sweep','Stormslam','Deathspike','Infused Strike','Haunting Gaze',
                                'Arcane Cleave','Dragon Strike','Frigid Shard','Searing Blows',
                                'Lightning Strike','Brutalize','Savage Strike','Void Slash', 'Severing Slash', 'Ice Cutter'}
                                local unitID = "nameplate" .. id
                local name, text, texture, startTimeMS, endTimeMS, isTradeSkill, castID, notInterruptible, spellId = UnitCastingInfo(unitID)
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

local function kickprio()
    -- list of m+ abilities that should be kicked
    local KickSpells = {
        'Mystic Blast','Monotonous Lecture','Arcane Missiles','Astral Bomb','Healing Touch', -- AA
        'Suppress', 'Drifting Embers',  --CoS
        'Thunderous Bolt','Holy Radiance','Cleansing Flames','Unruly Yell','Rune of Healing','Etch', 'Surge',-- HoV
        'Roaring Blaze','Lightning Bolt','Flashfire','Cinderbolt', --RLP
        'Shadow Mend','Shadow Bolts','Domination','Rending Voidlash','Void Bolt','Death Blast','Necrotic Burst','Plague Spit', --SMBG
        'Tidal Burst','Haunting Gaze','Haunting Scream','Cat Nap','Defiling Mist', --TotJS
        'Erratic Growth','Mystic Vapors','Heavy Tome','Waking Bane','Icy Bindings','Illusionary Bolt',--AV
        'Disruptive Shout','Tempest','Stormbolt','Death Bolt Volley','Dominate','Storm Shock','Bloodcurdling Shout','Storm Bolt', 'Thunderstrike', 'Desacrating Blow',-- NO

    }

    local currentSpell = select(1, UnitCastingInfo('target'))

    for i = 1, #KickSpells do
        if currentSpell == KickSpells[i] then
            return true
        end
    end

    return false
end

local function stunprio()
    -- list of m+ abilities that should be stunned
    local stunspells = {
        'Mystic Blast','Monotonous Lecture','Arcane Missiles','Astral Bomb','Healing Touch','Astral Whirlwind', -- AA
        'Drifting Embers','Quelling Strike','Sound Alarm','Eye Storm','Hypnosis',  --CoS
        'Thunderous Bolt','Holy Radiance','Unruly Yell', 'Rune of Healing','Etch','Surge',-- HoV
        'Lightning Bolt','Flashfire', 'Tectonic Slam','Cold Claws','Ice Shield','Flame Dance','Cinderbolt',--RLP
        'Shadow Mend','Shadow Bolts','Domination','Rending Voidlash','Death Blast','Plague Spit','Cry of Anguish', --SMBG
        'Tidal Burst','Haunting Gaze','Haunting Scream','Cat Nap','Defiling Mist','Leg Sweep', --TotJS
        'Mystic Vapors','Shriek','Piercing Shards','Waking Bane','Icy Bindings','Illusionary Bolt','Null Stomp',--AV
        'Rally the Clan','Tempest','Stormbolt','Grasp of the Dead','Dominate','Storm Shock','Bloodcurdling Shout','Storm Bolt', 'Desacrating Blow',-- NO

    }

    local currentSpell = select(1, UnitCastingInfo('target'))

    for i = 1, #stunspells do
        if currentSpell == stunspells[i] then
            return true
        end
    end

    return false
end


--- ======= ACTION LISTS =======
local function APL()
    mitigate()
    kickprio()
    stunprio()

    local level, affixIDs, wasEnergized = C_ChallengeMode.GetActiveKeystoneInfo()

    ActiveMitigationNeeded = Player:ActiveMitigationNeeded()
    IsTanking = Player:IsTankingAoE(8) or Player:IsTanking(Target)


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

    wordofglorycast = (
        Player:HolyPower() >= 3 or Player:BuffP(S.DivinePurposeBuff) or Player:BuffP(S.ShiningLight) or
            Player:Buff(S.BastionofLight))

            if UnitClassification("target") == "worldboss" or UnitClassification("target") == "rareelite" or UnitClassification("target") == "elite"
            or UnitClassification("target") == "rare" or Target:IsAPlayer() then
                elite = true
            else
                elite = false
            end
    -- Define a list of dungeon boss encounter IDs
        local Boss = {
        'Overgrown Ancient','Crawth', -- Algeth'ar Academy
        'Melidrussa Chillworn','Kokia Blazehoof','Kyrakka and Erkhart Stormvein', -- Ruby Life Pools
        'Leymor','Umbrelskul','Azureblade', -- Azure Vault
        'The Raging Tempest','Teera and Maruuk','Balakar Khan', -- Nokhud Offensive
        -- Court of Stars - nothing
        'Hyrja','God-King Skovald','Odyn', 'Hymdall',-- Halls of Valor
        'Sadana Bloodfury', -- Shadowmoon Burial Grounds
        'Liu Flameheart',-- Temple of the Jade Serpent
        --

        }

        -- local spellName, _, _, startTimeMS, endTimeMS = UnitChannelInfo(unit)
        -- local currentTimeMS = GetTime() * 1000
        -- local elapsedMS = currentTimeMS - startTimeMS
        -- local durationMS = endTimeMS - startTimeMS
        -- local percentage = (elapsedMS / durationMS) * 100

        if RubimRH.CDsON() and Target:IsInRange(5) and not Target:IsDeadOrGhost() and Player:CanAttack(Target) and Player:AffectingCombat() then
            local ShouldReturn = UseItems();
            if ShouldReturn then return ShouldReturn; end
        end
        


    if Player:HealthPercentage() <= 25 and Player:AffectingCombat() and IsUsableItem(191380) and
        GetItemCooldown(191380) == 0 and GetItemCount(191380) >= 1 and S.LayonHands:CooldownRemains()>0.5 
        and (not Player:InArena() and not Player:InBattlegrounds()) then
        return I.HPIcon:Cast()
    end

    if S.lustAT:ID() == RubimRH.queuedSpell[1]:ID() 
    and not Player:Debuff(S.lust1) and not Player:Debuff(S.lust2) and
        not Player:Debuff(S.lust3) and not Player:Debuff(S.lust4) and not Player:Debuff(S.lust5) and (I.drums:IsReady()) then
        return S.lustAT:Cast() -- BIND LUST KEYBIND IN BINDPAD TO ARCANE TORRENT
    end

    if S.lustAT:ID() == RubimRH.queuedSpell[1]:ID() and
        (
        Player:Debuff(S.lust1) or Player:Debuff(S.lust2) or Player:Debuff(S.lust3) or Player:Debuff(S.lust4) or
            Player:Debuff(S.lust5)) then
        RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
    end


    if S.FlashofLight:ID() == RubimRH.queuedSpell[1]:ID() and Player:IsMoving() then
        RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
    end

    
    if S.Intercession:ID() == RubimRH.queuedSpell[1]:ID() and S.Intercession:IsReady() and Player:HolyPower()>=3 then
        return S.intercession:Cast() -- BIND LUST KEYBIND IN BINDPAD TO ARCANE TORRENT
    end



    if S.Intercession:ID() == RubimRH.queuedSpell[1]:ID() and (Player:HolyPower()<3 or not S.Intercession:IsReady()) then
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

    --Kick
        if (Target:CastPercentage() > 26 and Target:CastPercentage() <86 or Target:IsChanneling()) and 
            RubimRH.InterruptsON() and S.Rebuke:IsReady(8) and Player:AffectingCombat() and kickprio() then
            return S.Rebuke:Cast()
        end

        if (Target:CastPercentage() > 26 and Target:CastPercentage() <86 or Target:IsChanneling()) and select(8, UnitCastingInfo("target")) == false and
        RubimRH.InterruptsON() and S.AvengersShield:IsReady(20) and Player:AffectingCombat() and (S.DivineToll:CooldownRemains()>Player:GCD() or not RubimRH.CDsON()) then
        return S.AvengersShield:Cast()
    end

    --Stun
        if (Target:CastPercentage() > 20 and Target:CastPercentage() <86 or Target:IsChanneling()) and 
            RubimRH.InterruptsON() and S.HammerofJustice:IsReady(10) and Player:AffectingCombat() and stunprio() then
            return S.HammerofJustice:Cast()
        end

        if S.HammerofWrath:IsReady() and UnitName('target') == 'Explosives' then
            return S.HammerofWrath:Cast()
        end

        if S.Judgment:IsCastableQueue() and UnitName('target') == 'Explosives' then
            return S.Judgment:Cast()
        end

        if S.AvengersShield:IsCastableQueue() and UnitName('target') == 'Explosives' then
            return S.AvengersShield:Cast()
        end



        -- if S.HammerofJustice:IsReady(8) and UnitName('target') == 'Spiteful Shade' then
        --     return S.HammerofJustice:Cast()
        -- end

    if not IsCurrentSpell(6603) and Player:CanAttack(Target)
        and Target:AffectingCombat() and Player:AffectingCombat() and Target:IsInRange(20) then
        return S.autoattack:Cast()
    end



    -------------DEFENSIVES_-------------
if Player:AffectingCombat() then 

     

            -- defensives for trash
            if (not IsEncounterInProgress(Boss) or level <=13) then


                if S.DivineShield:IsCastable() and not Player:Debuff(S.Forbearance)  and S.FinalStand:IsAvailable() and 
                Cache.EnemiesCount[10] >= 1  and (Player:NeedPanicHealing() and Player:HealthPercentage()<30 or Player:HealthPercentage()<20) and not Player:Buff(S.ArdentDefenderBuff) 
                and not Player:Buff(S.GuardianofAncientKings) and S.GuardianofAncientKings:CooldownRemains()>Player:GCD() 
                and S.ArdentDefender:CooldownRemains()>Player:GCD() and S.LayonHands:CooldownRemains()>Player:GCD() then
            return S.DivineShield:Cast()
            end

            if S.LayonHands:IsReadyP() and Player:HealthPercentage() <= 25 and not Player:Debuff(S.Forbearance) and
            not Player:InArena() and Cache.EnemiesCount[30] >= 1 then
            return S.LayonHands:Cast()
        end

                        if S.GuardianofAncientKings:IsCastable()  and S.ArdentDefender:TimeSinceLastCast()>0.5 and 
                        Cache.EnemiesCount[10] >= 1 and (Player:NeedPanicHealing() and Player:HealthPercentage()<55 or Player:HealthPercentage()<35) 
                        and not Player:Buff(S.DivineShield) and (not Player:Buff(S.ArdentDefenderBuff)) then
                            return S.GuardianofAncientKings:Cast()
                    end
                        if S.ArdentDefender:IsCastable() and S.GuardianofAncientKings:TimeSinceLastCast()>0.5 and
                        Cache.EnemiesCount[10] >= 1 and (Player:NeedMajorHealing() and Player:HealthPercentage()<55 or Player:HealthPercentage()<50) 
                        and not Player:Buff(S.DivineShield) and not Player:Buff(S.GuardianofAncientKings) and not Player:Buff(S.ArdentDefenderBuff) then
                            return S.ArdentDefender:Cast()
                    end

                        if S.EyeofTyr:IsCastable() and
                        Cache.EnemiesCount[10] >= 1  and (Player:NeedMajorHealing() and Player:HealthPercentage()<85 or Player:HealthPercentage()<80 
                        or ActiveMitigationNeeded and not Player:Buff(S.ShieldoftheRighteousBuff)) 
                        and (Cache.EnemiesCount[8] >= 1 or Target:IsInRange(8)) and not Player:Buff(S.DivineShield) and not Player:Buff(S.GuardianofAncientKings) then
                        return S.EyeofTyr:Cast()
                    end

            end

            -- defensives for bosses
            if (mitigate() and level> 13 ) then


                if S.DivineShield:IsCastable() and not Player:Debuff(S.Forbearance) and S.FinalStand:IsAvailable() and 
                Cache.EnemiesCount[10] >= 1  
                and not Player:Buff(S.ArdentDefenderBuff) and S.ArdentDefender:CooldownRemains()>Player:GCD()
                and not Player:Buff(S.GuardianofAncientKings) and S.GuardianofAncientKings:CooldownRemains()>Player:GCD() 
                and not Target:Debuff(S.EyeofTyr)
            then
            return S.DivineShield:Cast()
            end
            
            if S.LayonHands:IsReadyP() and Player:HealthPercentage() <= 25 and not Player:Debuff(S.Forbearance) and S.DivineShield:CooldownRemains()>Player:GCD() and
            not Player:InArena() and Cache.EnemiesCount[30] >= 1 then
            return S.LayonHands:Cast()
        end
                    if S.GuardianofAncientKings:IsCastable() and S.ArdentDefender:TimeSinceLastCast()>0.5 and 
                    Cache.EnemiesCount[10] >= 1 
                    and not Player:Buff(S.DivineShield) and (not Player:Buff(S.ArdentDefenderBuff)) then
                        return S.GuardianofAncientKings:Cast()
                end
                    if S.ArdentDefender:IsCastable() and S.GuardianofAncientKings:TimeSinceLastCast()>0.5 and
                    Cache.EnemiesCount[10] >= 1 
                    and not Player:Buff(S.DivineShield) and not Player:Buff(S.GuardianofAncientKings) and not Player:Buff(S.ArdentDefenderBuff) then
                        return S.ArdentDefender:Cast()
                end

                    if S.EyeofTyr:IsCastable()  and
                    Cache.EnemiesCount[10] >= 1  
                    and not Player:Buff(S.ShieldoftheRighteousBuff)
                    and not Player:Buff(S.ArdentDefenderBuff) and S.ArdentDefender:CooldownRemains()>Player:GCD()
                    and not Player:Buff(S.GuardianofAncientKings) and S.GuardianofAncientKings:CooldownRemains()>Player:GCD() 
                    and (Cache.EnemiesCount[8] >= 1 or Target:IsInRange(8)) and not Player:Buff(S.DivineShield) and not Player:Buff(S.GuardianofAncientKings) then
                    return S.EyeofTyr:Cast()
                end

   

                -- if S.BlessingofProtection:IsCastable() and not Player:Debuff(S.Forbearance) and 
                --     Cache.EnemiesCount[10] >= 1  
                --     and not Player:Buff(S.DivineShield) and S.DivineShield:CooldownRemains()>Player:GCD()
                --     and not Player:Buff(S.ArdentDefenderBuff) and S.ArdentDefender:CooldownRemains()>Player:GCD()
                --     and not Player:Buff(S.GuardianofAncientKings) and S.GuardianofAncientKings:CooldownRemains()>Player:GCD() 
                --     and not Target:Debuff(S.EyeofTyr)
                -- then
                -- return S.BlessingofProtection:Cast()
                -- end

            end

        -- cast word of glory on us if it's a) free or b) probably not going to drop sotr
        if S.WordofGlory:IsReady() and Player:HealthPercentage() <= 70 and not Player:HealingAbsorbed() and 
          (Player:BuffRemains(S.ShieldoftheRighteousBuff) >= 5 or Player:Buff(S.DivinePurposeBuff) or Player:Buff(S.ShiningLight) or Player:HealthPercentage()<45) then
        return S.WordofGlory:Cast()
        end
              
        if S.ShieldoftheRighteous:IsReady() and Target:IsInRange(5) 
        and (Player:BuffRemains(S.ShieldoftheRighteousBuff) < 2
        and (ActiveMitigationNeeded 
        or Player:HealthPercentage() <=80)) then
            return S.ShieldoftheRighteous:Cast()
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

    if S.BlessingofProtection:IsReadyP() and Player:HealthPercentage() <= 20 
    and not Player:DebuffP(S.Forbearance) and
        S.DivineShield:CooldownRemains() > Player:GCD() 
        and not Player:BuffP(S.ArdentDefender) and S.ArdentDefender:CooldownRemains()>Player:GCD()
        and not Player:Buff(S.GuardianofAncientKings) and S.GuardianofAncientKings:CooldownRemains()>Player:GCD()
        and S.LayonHands:CooldownRemains() > Player:GCD() and
        Cache.EnemiesCount[10] >= 1 then
        return S.BlessingofProtection:Cast()
    end

end

    if RubimRH.CDsON() and Cache.EnemiesCount[8] >= 1 then

        if S.Seraphim:IsReadyP() then
            return S.Seraphim:Cast()
        end


        if S.AvengingWrath:IsReadyP() and not Player:BuffP(S.AvengingWrathBuff) then
            return S.AvengingWrath:Cast()
        end

        if S.HolyAvenger:IsReadyP() and (Player:BuffP(S.AvengingWrathBuff) or S.AvengingWrath:CooldownRemains() > 60) then
            return S.HolyAvenger:Cast()
        end

        if S.MomentofGlory:IsReadyP() and Player:PrevGCD(1, S.AvengersShield) and not S.AvengersShield:CooldownUp() then
            return S.MomentofGlory:Cast()
        end

    end



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

    if S.DivineToll:IsReadyP() and Cache.EnemiesCount[15] >= 3 and Target:IsInRange(30) and RubimRH.CDsON() and
        (Player:BuffP(S.AvengingWrathBuff) or S.AvengingWrath:CooldownRemains() > 0) then
        return S.DivineToll:Cast()
    end

    if S.AvengersShield:IsReadyP() and Cache.EnemiesCount[15] >= 3 and Target:IsInRange(30) then
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
    if S.HammeroftheRighteous:IsReadyP() and Cache.EnemiesCount[10] >= 1 and Target:IsInRange(8) and 
        S.HammeroftheRighteous:ChargesFractional() >= 2.9 then
        return S.HammeroftheRighteous:Cast()
    end


    -- blessed_hammer,strikes=2.4

    if S.BlessedHammer:IsReadyP() and Cache.EnemiesCount[10] >= 1 then
        return S.BlessedHammer:Cast()
    end


    -- hammer_of_the_righteous
    if S.HammeroftheRighteous:IsReadyP() and Cache.EnemiesCount[10] >= 1 and Target:IsInRange(8) then
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
