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
RighteousProtector = Spell(204074),

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

AllyoftheLight = Spell(394714),

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

local function combatmobs40()
local totalRange40 = 0


for id = 1, 40 do
local unitID = "nameplate" .. id
if UnitCanAttack("player", unitID) and Cache.EnemiesCount[40]
and UnitHealthMax(unitID) > 5 and UnitAffectingCombat(unitID) then
totalRange40 = totalRange40 + 1
end
end


return totalRange40


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

local function freedom()
if Player:AffectingCombat() then

for id = 1, 40 do

local spell = {'Crystalline Rupture',}
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

local function mitigate()
if Player:AffectingCombat() then

for id = 1, 40 do

local spell = {'Savage Peck', 'Barkbreaker','Shield of Light','Savage Blade', 'Dark Claw','Jade Serpent Strike',
'Bloodletting Sweep','Stormslam','Deathspike','Infused Strike','Haunting Gaze',
'Arcane Cleave','Dragon Strike','Frigid Shard','Searing Blows',
'Lightning Strike','Brutalize','Savage Strike','Void Slash', 'Severing Slash', 'Ice Cutter','Lightning Breath','Thunder Jaw',}
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
'Mystic Blast','Monotonous Lecture','Arcane Missiles','Astral Bomb','Healing Touch','Astral Whirlwind', -- AA
'Drifting Embers','Quelling Strike','Sound Alarm','Eye Storm','Hypnosis',  --CoS
'Thunderous Bolt','Holy Radiance', 'Rune of Healing','Etch','Surge',-- HoV
'Lightning Bolt','Flashfire', 'Tectonic Slam','Cold Claws','Ice Shield','Flame Dance','Cinderbolt',--RLP
'Shadow Mend','Shadow Bolts','Domination','Rending Voidlash','Death Blast','Plague Spit','Cry of Anguish', --SMBG
'Tidal Burst','Haunting Gaze','Haunting Scream','Cat Nap','Defiling Mist','Leg Sweep', --TotJS
'Mystic Vapors','Shriek','Piercing Shards','Waking Bane','Icy Bindings','Illusionary Bolt','Null Stomp',--AV
'Rally the Clan','Tempest','Stormbolt','Grasp of the Dead','Dominate','Storm Shock','Bloodcurdling Shout','Storm Bolt', 'Desacrating Blow',-- NO

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
    'Mystic Blast','Monotonous Lecture','Arcane Missiles','Astral Bomb','Healing Touch','Astral Whirlwind', -- AA
    'Drifting Embers','Quelling Strike','Sound Alarm','Eye Storm','Hypnosis',  --CoS
    'Thunderous Bolt','Holy Radiance', 'Rune of Healing','Etch','Surge',-- HoV
    'Lightning Bolt','Flashfire', 'Tectonic Slam','Cold Claws','Ice Shield','Flame Dance','Cinderbolt',--RLP
    'Shadow Mend','Shadow Bolts','Domination','Rending Voidlash','Death Blast','Plague Spit','Cry of Anguish', --SMBG
    'Tidal Burst','Haunting Gaze','Haunting Scream','Cat Nap','Defiling Mist','Leg Sweep', --TotJS
    'Mystic Vapors','Shriek','Piercing Shards','Waking Bane','Icy Bindings','Illusionary Bolt','Null Stomp',--AV
    'Rally the Clan','Tempest','Stormbolt','Grasp of the Dead','Dominate','Storm Shock','Bloodcurdling Shout','Storm Bolt', 'Desacrating Blow',-- NO
    
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







--- ======= ACTION LISTS =======
local function APL()
                mitigate()
                kickprio()
                stunprio()
                blindprio()
                freedom()
                combatmobs40()

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
                IsTanking = Player:IsTankingAoE(8) or Player:IsTanking(Target)

                local startTimeMS = select(4, UnitCastingInfo('target')) or 0
                local currentTimeMS = GetTime() * 1000
                local elapsedTimeca = (startTimeMS > 0) and (currentTimeMS - startTimeMS) or 0
                castTime = elapsedTimeca / 1000
                local startTimeMS = select(4, UnitCastingInfo('target')) or select(4, UnitChannelInfo('target')) or 0
                local currentTimeMS = GetTime() * 1000
                local elapsedTimech = (startTimeMS > 0) and (currentTimeMS - startTimeMS) or 0
                channelTime = elapsedTimech/1000

                WordofGlorycast = (
                Player:HolyPower() >= 3 or Player:BuffP(S.DivinePurposeBuff) or Player:BuffP(S.ShiningLight) or
                Player:Buff(S.BastionofLight))

                if UnitClassification("target") == "worldboss" 
                or UnitClassification("target") == "rareelite" 
                or UnitClassification("target") == "elite"
                or UnitClassification("target") == "rare" 
                or Target:IsAPlayer() then
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


-- print(castTime)
-- print(channelTime)

                validmobsinrange8y =Enemies8y/.7
                if validmobsinrange8y>combatmobs40() and combatmobs40()>0 then
                    aoecds8y = true
                else
                    aoecds8y = false
                end
                
                validmobsinrange10y =Enemies10y/.7 -- at least 70% of mobs in combat (within 40 yards) are in range of 12y
                if validmobsinrange10y>combatmobs40() and combatmobs40()>0 then
                aoecds10y = true
                else
                aoecds10y = false
                end

                consecrationdrop = (
                (Player:CanAttack(Target) and Target:IsInRange(5) and aoecds10y) or Cache.EnemiesCount[5] >= 3)




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


                if Player:PrevGCD(1, S.CleanseToxins) then
                RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
                end


                if RubimRH.QueuedSpell():IsReadyQueue() then
                return RubimRH.QueuedSpell():Cast()
                end



                if (not RubimRH.queuedSpell[1]:CooldownUp() or not Player:AffectingCombat() or Cache.EnemiesCount[20] == 0) then
                RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
                end

                --Freedom
                if S.BlessingofFreedom:IsReady() and freedom() and Enemies15y>=1 then
                    return S.BlessingofFreedom:Cast()
                end

                --Kick
                if (castTime>0.35 or channelTime>0.35) and 
                RubimRH.InterruptsON() and S.Rebuke:IsReady(8) and Player:AffectingCombat() and kickprio() then
                return S.Rebuke:Cast()
                end

                if (castTime>0.1 or channelTime>0.1)  
                and select(8, UnitCastingInfo("target")) == false and
                RubimRH.InterruptsON() and S.AvengersShield:IsReady(20) and Player:AffectingCombat() and (S.DivineToll:CooldownRemains()>Player:GCD() or not RubimRH.CDsON()) then
                return S.AvengersShield:Cast()
                end

                --Stun

                if (castTime>0.1 or channelTime>0.1)  
                and RubimRH.InterruptsON() and S.HammerofJustice:IsReady(10) and Player:AffectingCombat() and stunprio() then
                return S.HammerofJustice:Cast()
                end

                --Blind
                if (castTime>0.1 or channelTime>0.1) and S.HammerofJustice:CooldownRemains()>Player:GCD()
                and RubimRH.InterruptsON() and S.BlindingLight:IsReady() and Enemies8y >=1 and Player:AffectingCombat() and blindprio() then
                return S.BlindingLight:Cast()
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



                 HPpercentloss = MyHealthTracker.GetPredictedHealthLoss()*3

-- print(HPpercentloss)


        --------------------ROTATION START-------------------------------------ROTATION START-----------------

        --------------------ROTATION START-------------------------------------ROTATION START-----------------

        --------------------ROTATION START-------------------------------------ROTATION START-----------------


        --------------------DEFENSIVES -----------------        --------------------DEFENSIVES -----------------

        --------------------DEFENSIVES -----------------        --------------------DEFENSIVES -----------------

        --------------------DEFENSIVES -----------------        --------------------DEFENSIVES -----------------


        if Player:AffectingCombat() then

            --health pot -- will need to update item ID of HPs as expansions progress
            if Enemies20y>=1 and Player:HealthPercentage() <= 25 and Player:AffectingCombat() and IsUsableItem(191380) and
            GetItemCooldown(191380) == 0 and GetItemCount(191380) >= 1 and S.LayonHands:CooldownRemains()>0.5 
            and (not Player:InArena() and not Player:InBattlegrounds()) then
            return I.HPIcon:Cast()
            end

            if S.DivineShield:IsCastable() and not Player:Debuff(S.Forbearance) 
            and Enemies12y >= 1  
            and Player:HealthPercentage()<25 then
            return S.DivineShield:Cast()
            end

            -- defensives for trash on M+ key <= level 13
            if (not IsEncounterInProgress(Boss) or level <=13) then


                if S.DivineShield:IsCastable() and not Player:Debuff(S.Forbearance) and S.FinalStand:IsAvailable() 
                and Enemies12y >= 1  
                and HPpercentloss>20
                and Player:HealthPercentage()<50
                and (not Player:Buff(S.GuardianofAncientKings) or S.GuardianofAncientKings:CooldownRemains()>Player:GCD())
                and (not Player:Buff(S.ArdentDefender) or S.ArdentDefender:CooldownRemains()>Player:GCD()) then
                return S.DivineShield:Cast()
                end

                if S.LayonHands:IsReadyP() and Player:HealthPercentage() <= 25 and S.DivineShield:CooldownRemains()>Player:GCD() and not Player:Debuff(S.Forbearance) 
                and Cache.EnemiesCount[30] >= 1 then
                return S.LayonHands:Cast()
                end

                if S.GuardianofAncientKings:IsCastable() and S.ArdentDefender:TimeSinceLastCast()>0.5
                and Enemies12y >= 1  
                and HPpercentloss>12
                and Player:HealthPercentage()<65
                and not Player:Buff(S.DivineShield) and (not Player:Buff(S.ArdentDefenderBuff)) then
                return S.GuardianofAncientKings:Cast()
                end

                if S.ArdentDefender:IsCastable() and S.GuardianofAncientKings:TimeSinceLastCast()>0.5
                and Enemies12y >= 1  
                and HPpercentloss>12
                and Player:HealthPercentage()<55
                and not Player:Buff(S.DivineShield) and not Player:Buff(S.GuardianofAncientKings) and not Player:Buff(S.ArdentDefenderBuff) then
                return S.ArdentDefender:Cast()
                end

                if S.EyeofTyr:IsCastable() and
                Cache.EnemiesCount[10] >= 1  and Player:NeedMajorHealing() and Player:HealthPercentage()<85 
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

            end



            -- cast word of glory on us if it's a) free or b) probably not going to drop sotr
            if S.WordofGlory:IsReady() and Player:HealthPercentage() <= 70 and not Player:HealingAbsorbed() and 
            (Player:BuffRemains(S.ShieldoftheRighteousBuff) >= 5 or Player:Buff(S.DivinePurposeBuff) or Player:Buff(S.ShiningLight) or Player:HealthPercentage()<45) then
            return S.WordofGlory:Cast()
            end
                
            if S.ShieldoftheRighteous:IsReady() and (Target:IsInRange(8) or Enemies12y)
            and Player:BuffRemains(S.ShieldoftheRighteousBuff) < 2
            then
            return S.ShieldoftheRighteous:Cast()
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


            --------------------DPS rotation start -----------------       --------------------DPS rotation start -----------------
            --------------------DPS rotation start -----------------       --------------------DPS rotation start -----------------
            --------------------DPS rotation start -----------------       --------------------DPS rotation start -----------------
            --------------------DPS rotation start -----------------       --------------------DPS rotation start -----------------
            if Player:CanAttack(Target) and not Target:IsDeadOrGhost() 
            and (Target:AffectingCombat() or Player:AffectingCombat()) then 
                    
                    --start attack if not already
                    if not IsCurrentSpell(6603) and Target:IsInRange(20) then
                        return S.autoattack:Cast()
                    end


                --------------------CDS -----------------        --------------------CDS -----------------

                --------------------CDS -----------------        --------------------CDS -----------------

                --------------------CDS -----------------        --------------------CDS -----------------


                if RubimRH.CDsON() and Target:IsInRange(10) then

                    if S.AvengingWrath:IsReadyP() and not Player:BuffP(S.AvengingWrathBuff) then
                    return S.AvengingWrath:Cast()
                    end

                    if S.BastionofLight:IsReadyP() and Player:Buff(S.AvengingWrathBuff) then
                    return S.BastionofLight:Cast()
                    end
            
                    if S.MomentofGlory:IsReadyP() and Player:PrevGCD(1, S.AvengersShield) and not S.AvengersShield:CooldownUp() then
                    return S.MomentofGlory:Cast()
                    end

                    if Target:IsInRange(8) then
                    local ShouldReturn = UseItems();
                    if ShouldReturn then return ShouldReturn; end
                    end

                end

                --------------------DEFAULT ROTATION -----------------        --------------------DEFAULT ROTATION -----------------

                --------------------DEFAULT ROTATION -----------------        --------------------DEFAULT ROTATION -----------------

                --------------------DEFAULT ROTATION -----------------        --------------------DEFAULT ROTATION -----------------


            if S.ShieldoftheRighteous:IsReady() and Target:IsInRange(5) and
            (
            Target:Debuff(S.JudgmentDebuff) or
            not Player:Buff(S.ShieldoftheRighteousBuff) and
            (Player:NeedMajorHealing() or Player:NeedPanicHealing()))
            then
            return S.ShieldoftheRighteous:Cast()
            end


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

            if S.BlessedHammer:IsReadyP() and Enemies12y >= 1 and S.BlessedHammer:ChargesFractional() >= 2.9 then
            return S.BlessedHammer:Cast()
            end

            -- hammer_of_the_righteous,if=charges=2
            if S.HammeroftheRighteous:IsReadyP() and Enemies10y >= 1 and Target:IsInRange(8) and 
            S.HammeroftheRighteous:ChargesFractional() >= 2.9 then
            return S.HammeroftheRighteous:Cast()
            end


            -- blessed_hammer,strikes=2.4

            if S.BlessedHammer:IsReadyP() and Enemies12y >= 1 then
            return S.BlessedHammer:Cast()
            end


            -- hammer_of_the_righteous
            if S.HammeroftheRighteous:IsReadyP() and Enemies10y >= 1 and Target:IsInRange(8) then
            return S.HammeroftheRighteous:Cast()
            end


            if S.WordofGlory:IsReady() 
            and Player:Buff(S.ShiningLight) 
            and (Player:HealthPercentage()<75 
            or Player:BuffRemains(S.ShiningLight)<3
            and Player:HealthPercentage()<80)
            then
            return S.WordofGlory:Cast()
            end


            if S.Judgment:IsReadyP() and Target:IsInRange(30) then
            return S.Judgment:Cast()
            end
            -- consecration

            if S.Consecration:IsReadyP() and (consecrationdrop or Target:IsInRange(5) and Player:CanAttack(Target)) then
            return S.Consecration:Cast()
            end


        end -- end of dps rotation

    end -- end of rotation (in combat)

--     --------------------OUT OF COMBAT ROTATION -----------------        --------------------OUT OF COMBAT ROTATION -----------------

--     --------------------OUT OF COMBAT ROTATION -----------------        --------------------OUT OF COMBAT ROTATION -----------------

--     --------------------OUT OF COMBAT ROTATION -----------------        --------------------OUT OF COMBAT ROTATION -----------------

if not Player:AffectingCombat() then

        if S.WordofGlory:IsCastable() and Player:HealthPercentage() < 75 and
        (Player:HolyPower() >= 3 or Player:BuffP(S.DivinePurpose) or Player:BuffP(S.ShiningLight)) then
        return S.WordofGlory:Cast()
        end

        if S.DevotionAura:IsCastable() and not Player:BuffP(S.DevotionAura) then
        return S.DevotionAura:Cast()
        end
        
        if S.BlessedHammer:IsCastable() and Player:IsMoving() and IsResting("player") == false and Cache.EnemiesCount[40] >= 1 
        and Cache.EnemiesCount[15] == 0 and (S.BlessedHammer:ChargesFractional() >= 1.9 and Player:HolyPower()<5 or
        S.BlessedHammer:ChargesFractional() >= 1 and Player:HolyPower()<3) then
        return S.BlessedHammer:Cast()
        end
                    
        return 0, "Interface\\Addons\\Rubim-RH\\Media\\prot.tga" -- icon to display by default
end -- out of combat rotation end

return 0, 135328 --sword icon in combat
end -- END APL
        
RubimRH.Rotation.SetAPL(66, APL)

local function PASSIVE()
end
        
RubimRH.Rotation.SetPASSIVE(66, PASSIVE)
