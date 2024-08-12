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

if not Spell.Warlock then
Spell.Warlock = {};
end

RubimRH.Spell[265] = {
autoattack             = Spell(59752), -- will to survive (human racial)



lust1                    = Spell(57724),
lust2                    = Spell(57723),
lust3                    = Spell(80354),
lust4                    = Spell(95809),
lust5                    = Spell(264689),
lustAT                   = Spell(20549), -- war stomp


}

local S = RubimRH.Spell[265]
local G = RubimRH.Spell[1] -- General Skills




-- Items
if not Item.Warlock then Item.Warlock = {} end

Item.Warlock.Affliction = {
phialofserenity = Item(177278),
tempest = Item(171416),
HPIcon = Item(169451),
tx1 = Item(118330),
tx2 = Item(114616),
healingpot = Item(187802),
healingpoticon = Item(169451),
HealthStone = Item(5512), --health stone
drums = Item(193470),

};
local I = Item.Warlock.Affliction;



local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_TALENT_UPDATE")
frame:SetScript("OnEvent", UpdateTemplarsVerdictSpellId)




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


    

    local function kickprio()
        -- list of m+ abilities that should be kicked
        local KickSpells = {
            'Mystic Blast', 'Monotonous Lecture', 'Arcane Missiles', 'Astral Bomb',
            'Healing Touch',    -- AA
            'Suppress',
            'Drifting Embers', 'Bewitch', --CoS
            'Thunderous Bolt', 'Holy Radiance', 'Cleansing Flames', 'Unruly Yell', 'Rune of Healing', 'Etch',
            'Surge',            -- HoV
            'Roaring Blaze', 'Lightning Bolt', 'Flashfire',
            'Cinderbolt',       --RLP
            'Shadow Mend', 'Shadow Bolts', 'Domination', 'Rending Voidlash', 'Void Bolt', 'Death Blast', 'Necrotic Burst',
            'Plague Spit',      --SMBG
            'Tidal Burst', 'Haunting Gaze', 'Haunting Scream', 'Cat Nap',
            'Defiling Mist',    --TotJS
            'Erratic Growth', 'Mystic Vapors', 'Heavy Tome', 'Waking Bane', 'Icy Bindings',
            'Illusionary Bolt', --AV
            'Disruptive Shout', 'Tempest', 'Stormbolt', 'Death Bolt Volley', 'Dominate', 'Storm Shock',
            'Bloodcurdling Shout', 'Storm Bolt', 'Thunderstrike',
            'Desacrating Blow', -- NO
    
        }
    
    local currentspellchannel = select(1,UnitChannelInfo('target'))
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
            'Mystic Blast', 'Monotonous Lecture', 'Arcane Missiles', 'Astral Bomb', 'Healing Touch',
            'Astral Whirlwind', -- AA
            'Drifting Embers', 'Quelling Strike', 'Sound Alarm', 'Eye Storm',
            'Hypnosis',         --CoS
            'Thunderous Bolt', 'Holy Radiance', 'Rune of Healing', 'Etch',
            'Surge',            -- HoV
            'Lightning Bolt', 'Flashfire', 'Tectonic Slam', 'Cold Claws', 'Ice Shield', 'Flame Dance',
            'Cinderbolt',       --RLP
            'Shadow Mend', 'Shadow Bolts', 'Domination', 'Rending Voidlash', 'Death Blast', 'Plague Spit',
            'Cry of Anguish',   --SMBG
            'Tidal Burst', 'Haunting Gaze', 'Haunting Scream', 'Cat Nap', 'Defiling Mist',
            'Leg Sweep',        --TotJS
            'Mystic Vapors', 'Shriek', 'Piercing Shards', 'Waking Bane', 'Icy Bindings', 'Illusionary Bolt',
            'Null Stomp',       --AV
            'Rally the Clan', 'Tempest', 'Stormbolt', 'Grasp of the Dead', 'Dominate', 'Storm Shock', 'Bloodcurdling Shout',
            'Storm Bolt',
            'Desacrating Blow', -- NO
    
        }
    
    local currentspellchannel = select(1,UnitChannelInfo('target'))
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
            'Mystic Blast', 'Monotonous Lecture', 'Arcane Missiles', 'Astral Bomb', 'Healing Touch',
            'Astral Whirlwind', -- AA
            'Drifting Embers', 'Quelling Strike', 'Sound Alarm', 'Eye Storm',
            'Hypnosis',         --CoS
            'Thunderous Bolt', 'Holy Radiance', 'Rune of Healing', 'Etch',
            'Surge',            -- HoV
            'Lightning Bolt', 'Flashfire', 'Tectonic Slam', 'Cold Claws', 'Ice Shield', 'Flame Dance',
            'Cinderbolt',       --RLP
            'Shadow Mend', 'Shadow Bolts', 'Domination', 'Rending Voidlash', 'Death Blast', 'Plague Spit',
            'Cry of Anguish',   --SMBG
            'Tidal Burst', 'Haunting Gaze', 'Haunting Scream', 'Cat Nap', 'Defiling Mist',
            'Leg Sweep',        --TotJS
            'Mystic Vapors', 'Shriek', 'Piercing Shards', 'Waking Bane', 'Icy Bindings', 'Illusionary Bolt',
            'Null Stomp',       --AV
            'Rally the Clan', 'Tempest', 'Stormbolt', 'Grasp of the Dead', 'Dominate', 'Storm Shock', 'Bloodcurdling Shout',
            'Storm Bolt',
            'Desacrating Blow', -- NO
    
        }
        
        local currentspellchannel = select(1,UnitChannelInfo('target'))
        local currentspellcast = select(1, UnitCastingInfo('target'))
        
        for i = 1, #blindspells do
        if currentspellcast == blindspells[i] or currentspellchannel == blindspells[i] then
        return true
        end
        end
        
        return false
        end
    
        local function combatmobs40()
            local totalmobsincombat = 0
        
            for id = 1, 40 do
                local unitID = "nameplate" .. id
                local unitName = UnitName(unitID)
                if (UnitCanAttack("player", unitID) and UnitHealthMax(unitID) > 5
                 and UnitAffectingCombat(unitID) and IsItemInRange(835, unitID) 
                 or (unitName and string.sub(unitName, -5) == "Dummy" and IsItemInRange(32321, unitID))) then
                    totalmobsincombat = totalmobsincombat + 1
                end
            end
        
            return totalmobsincombat
        end


local function APL()
    combatmobs40()
    blindprio()
    stunprio()
    kickprio()


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

        local level, affixIDs, wasEnergized = C_ChallengeMode.GetActiveKeystoneInfo()

     
        tarSpeed, _, _, _ = GetUnitSpeed('target')
        consecrationdrop = Target:IsInRange(8) and
        (Player:MovingFor() <= Player:GCD() or ( tarSpeed == 0))

    
        -- Spell Queue
        if Player:IsChanneling() or Player:IsCasting() then
        return 0, "Interface\\Addons\\Rubim-RH\\Media\\channel.tga"
        end



--item ids for wotlk range checks with nameplate
--<5 37727
--<8 34368
--<10 32321
--<15 33069
--<20 10645
--<25 13289
--<30 835
--<35 18904
--<40 4945 -- check

        IsTanking = Player:IsTankingAoE(8) or Player:IsTanking(Target)
        HPpercentloss = MyHealthTracker.GetPredictedHealthLoss() * 3


        validmobsinrange8y = combatmobs40() * .7
        validmobsinrange15y = combatmobs40() * .7
    
    
        if Enemies8y > validmobsinrange8y and combatmobs40() > 0 then
            aoecds8y = true
        else
            aoecds8y = false
        end
    
        if Enemies15y > validmobsinrange15y and combatmobs40() > 0 then
            aoecds15y = true
        else
            aoecds15y = false
        end
    
-- print('total mobs in 8y range:', Enemies8y)
-- print('70% mobs 40y in combat:',validmobsinrange8y)

local startTimeMS = select(4, UnitCastingInfo('target')) or 0
local currentTimeMS = GetTime() * 1000
local elapsedTimeca = (startTimeMS > 0) and (currentTimeMS - startTimeMS) or 0
castTime = elapsedTimeca / 1000
local startTimeMS = select(4, UnitCastingInfo('target')) or select(4, UnitChannelInfo('target')) or 0
local currentTimeMS = GetTime() * 1000
local elapsedTimech = (startTimeMS > 0) and (currentTimeMS - startTimeMS) or 0
channelTime = elapsedTimech/1000





if Player:HealthPercentage() <= 100 and Player:AffectingCombat() and IsUsableItem(5512)  
and GetItemCount(5512) >= 1 or GetItemCount(5512) >= 1 or GetItemCount(5512) >= 1 
then
return I.HealthStone:Cast()
end



        if Player:HealthPercentage() <= 25 and Player:AffectingCombat() and (IsUsableItem(191379) or IsUsableItem(191378)  or IsUsableItem(191380)) 
        and (GetItemCooldown(191380) == 0 or GetItemCooldown(191379) == 0 or GetItemCooldown(191378) == 0) 
        and (GetItemCount(191380) >= 1 or GetItemCount(191379) >= 1 or GetItemCount(191378) >= 1) 
        and (not Player:InArena() and not Player:InBattlegrounds()) then
        return I.HPIcon:Cast()
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



        if RubimRH.QueuedSpell():IsReadyQueue() then
        return RubimRH.QueuedSpell():Cast()
        end

        if not RubimRH.queuedSpell[1]:CooldownUp() 
        or Cache.EnemiesCount[20] == 0 
        or not Player:AffectingCombat()
        then
        RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
        end





        if Target:AffectingCombat() or Player:AffectingCombat() and Player:CanAttack(Target) then 


        if not IsCurrentSpell(6603) and Player:CanAttack(Target) and not Target:IsDeadOrGhost()
        and Target:AffectingCombat() and Target:IsInRange(20) then
        return S.autoattack:Cast()
        end

        if RubimRH.CDsON() and Target:IsInRange(5)
        and not Target:IsDeadOrGhost() and Player:CanAttack(Target) and Player:AffectingCombat() then
        local ShouldReturn = UseItems();
        if ShouldReturn then return ShouldReturn; end
        end

        -- if S.HammerofWrath:IsReady() and UnitName('target') == 'Explosives' then
        -- return S.HammerofWrath:Cast()
        -- end

        -- if S.Judgment:IsReady() and UnitName('target') == 'Explosives' then
        -- return S.Judgment:Cast()
        -- end

        -- if (IsUsableSpell("Templar Slash") or S.TemplarStrike:IsReady() or S.CrusaderStrike:IsReady()) and UnitName('target') == 'Explosives' then
        -- return S.crusaderstrike:Cast()
        -- end

                -- --Kick
                -- if (castTime>0.35 or channelTime>0.35) and 
                -- RubimRH.InterruptsON() and S.Rebuke:IsReady(8) and Player:AffectingCombat() and kickprio() then
                -- return S.Rebuke:Cast()
                -- end

                -- --Stun

                -- if (castTime>0.1 or channelTime>0.1) and level>13 
                -- and RubimRH.InterruptsON() and S.HammerofJustice:IsReady(10) and Player:AffectingCombat() and stunprio() then
                -- return S.HammerofJustice:Cast()
                -- end

                -- --Blind
                -- if (castTime>0.1 or channelTime>0.1) and S.HammerofJustice:CooldownRemains()>Player:GCD() and level>13 
                -- and RubimRH.InterruptsON() and S.BlindingLight:IsReady() and Enemies8y >=1 and Player:AffectingCombat() and blindprio() then
                -- return S.BlindingLight:Cast()
                -- end





    



    




        end

            -- Out of Combat
            if not Player:AffectingCombat() then

                if RubimRH.QueuedSpell():IsReadyQueue() then
                return RubimRH.QueuedSpell():Cast()
                end

                if not RubimRH.queuedSpell[1]:CooldownUp() 
                or Cache.EnemiesCount[20] == 0 
                or not Player:AffectingCombat()
                then
                RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
                end





            return 0, "Interface\\Addons\\Rubim-RH\\Media\\griph.tga"
            end

    return 0, 135328
end -- end APL

RubimRH.Rotation.SetAPL(265, APL);

local function PASSIVE()

end

RubimRH.Rotation.SetPASSIVE(265, PASSIVE);
