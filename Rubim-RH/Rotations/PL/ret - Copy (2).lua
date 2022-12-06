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
autoattack = Spell(20572), -- blood fury
BlessingofProtection = Spell(1022),
BlessingofFreedom = Spell(1044),
ShieldofVengeance = Spell(184662),
HammerofJustice = Spell(853),
DivineShield = Spell(642),
ArcaneTorrent = Spell(155145),
WakeofAshes = Spell(255937),
HandofHindrance = Spell(183218),
FlashofLight = Spell(19750),
DivineResonance = Spell(355455),
trinket= Spell(59547), -- gift of narru

BladeofJustice = Spell(184575),
Consecration = Spell(26573),
CrusaderStrike = Spell(35395),
DivineJudgment = Spell(271580),
DivineHammer = Spell(198034),
DivinePurpose = Spell(223817),
DivinePurposeBuff = Spell(223819),
DivineStorm = Spell(53385),
ExecutionSentence = Spell(343527),
GreaterJudgment = Spell(218718),
HolyWrath = Spell(210220),
Judgment = Spell(20271),
JudgmentDebuff = Spell(197277),
JusticarsVengeance = Spell(215661),
TemplarsVerdict = Spell(85256),
TheFiresofJustice = Spell(203316),
TheFiresofJusticeBuff = Spell(209785),
Zeal = Spell(217020),
FinalVerdict = Spell(198038),
Forbearance = Spell(25771),
-- Offensive
AvengingWrath = Spell(31884),
Crusade = Spell(231895),
--Talent
Inquisition = Spell(84963),
DivineJudgement = Spell(271580),
HammerofWrath = Spell(24275),
RighteousVerdict = Spell(267610),
-- Azerite Power
EmpyreanPowerAzerite = Spell(286390),
EmpyreanPowerBuffAzerite = Spell(286393),
DivineStormBuffAzerite = Spell(278523),
DivineRight = Spell(277678),

-- Defensive
SelfLessHealerBuff = Spell(114250),

LayonHands = Spell(633),
WordofGlory = Spell(85673),
EmpyreanPowerBuffTalent = Spell(326733),
Steward = Spell(324739),

Rebuke = Spell(96231),
DivineSteed = Spell(190784),
DivineSteedBuff = Spell(221886),
SeethingRage = Spell(297126),
-- Legendaries
LiadrinsFuryUnleashed = Spell(208408),
ScarletInquisitorsExpurgation = Spell(248289),
WhisperoftheNathrezim = Spell(207635),
-- PvP Talent
HammerOfReckoning = Spell(247675),
HammerOfReckoningBuff = Spell(247677),
HandOfHidrance = Spell(183218),
CondensedLifeForce = Spell(299358),
DevotionAura = Spell(465),		  
RetributionAura = Spell(183435),
EyeforanEye = Spell(205191),
lust1 = Spell(57724),
lust2 = Spell(57723),
lust3 = Spell(80354),
lust4 = Spell(95809),
lust5 = Spell(264689),

trink2 = Spell(59752), -- human trinket (will to survive)
ConcentratedFlamedebuff     = Spell(295368),
FocusedAzeriteBeam = Spell(295258),
VanquishersHammer = Spell(328204),
Berserking = Spell(26297),
FinalReckoning = Spell(343721),
lustAT = Spell(265221), -- fireblood
Seraphim = Spell(152262),
WaterStrider = Spell(118089),
BugMount = Spell(243795),

ConsecrationBuff = Spell(188370),
healthstone = Spell(291944),
healingpot = Spell(176108),
DivineToll = Spell(304971),
HolyAvenger = Spell(105809),

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
trinket = Item(178751, { 13, 14 }),
healingpot = Item(171267), --astral healing pot
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




local VarDsCastable



local function APL()
    ConsecrationTime()
        HL.GetEnemies("Melee");
        HL.GetEnemies(5);
        HL.GetEnemies(6);
        HL.GetEnemies(8);
        HL.GetEnemies(9);
        HL.GetEnemies(10);
        HL.GetEnemies(11);
        HL.GetEnemies(12);
        HL.GetEnemies(15);
        HL.GetEnemies(14);
        HL.GetEnemies(16);
        HL.GetEnemies(20);
        HL.GetEnemies(25);
        HL.GetEnemies(30);

        -- Spell Queue
        if Player:IsChanneling() or Player:IsCasting() then
        return 0, "Interface\\Addons\\Rubim-RH\\Media\\channel.tga"
        end

        if S.LayonHands:IsReady() and Player:HealthPercentage() <= 20 and not Player:Debuff(S.Forbearance) and S.DivineShield:CooldownRemains()>Player:GCD() then
        return S.LayonHands:Cast()
        end
        covenantID = C_Covenants.GetActiveCovenantID()
        print(covenantID)
        -- if I.healthstone:IsReady() and I.healthstone:Count()>=1 and Player:HealthPercentage() <= 30 and Player:AffectingCombat() then
        -- return S.healthstone:Cast()
        -- end

        if I.healingpot:IsReady() and I.healingpot:Count()>=1 and Player:HealthPercentage() <= 30 and Player:AffectingCombat() then
        return S.healingpot:Cast()
        end

        if S.ShieldofVengeance:IsCastable() and Player:HealthPercentage() <= 65 and Player:AffectingCombat() then
        return S.ShieldofVengeance:Cast()
        end
        if S.ShieldofVengeance:IsCastable() and Player:HealthPercentage() <= 85  and (Player:InArena() or Player:InBattlegrounds()) then
        return S.ShieldofVengeance:Cast()
        end


        if S.FlashofLight:IsCastable() and (Player:InArena() or Player:InBattlegrounds()) and Player:HealthPercentage() < 50  and Player:BuffStackP(S.SelfLessHealerBuff)==4  then
        return S.FlashofLight:Cast()
        end

        if S.lustAT:ID() ==  RubimRH.queuedSpell[1]:ID() and not Player:Debuff(S.lust1) and not Player:Debuff(S.lust2) and not Player:Debuff(S.lust3) and not Player:Debuff(S.lust4) and not Player:Debuff(S.lust5) and (I.drums:IsReady()) then
        return S.lustAT:Cast() -- BIND LUST KEYBIND IN BINDPAD TO ARCANE TORRENT
        end

        if S.lustAT:ID() ==  RubimRH.queuedSpell[1]:ID() and (Player:Debuff(S.lust1) or Player:Debuff(S.lust2) or Player:Debuff(S.lust3) or Player:Debuff(S.lust4) or Player:Debuff(S.lust5)) then
        RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
        end

        if S.FlashofLight:ID() ==  RubimRH.queuedSpell[1]:ID() and Player:BuffStackP(S.SelfLessHealerBuff)<4 then
        RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
        end


        if  S.DivineShield:ID() ==  RubimRH.queuedSpell[1]:ID() and Player:DebuffP(S.Forbearance) then
        RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
        end
        if  S.BlessingofProtection:ID() ==  RubimRH.queuedSpell[1]:ID() and Player:DebuffP(S.Forbearance) then
        RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
        end
        if  S.LayonHands:ID() ==  RubimRH.queuedSpell[1]:ID() and Player:DebuffP(S.Forbearance) or S.LayonHands:ID() ==  RubimRH.queuedSpell[1]:ID() and Player:InArena() then
        RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
        end

        if  S.DivineSteed:ID() ==  RubimRH.queuedSpell[1]:ID() and Player:BuffP(S.DivineSteedBuff) then
        RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
        end

        if RubimRH.QueuedSpell():IsReadyQueue() then
        return RubimRH.QueuedSpell():Cast()
        end

        if not RubimRH.queuedSpell[1]:CooldownUp() or Cache.EnemiesCount[20]==0 or not Player:AffectingCombat() then
        RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
        end


        if S.EyeforanEye:IsCastable() and S.EyeforanEye:IsAvailable() and Player:HealthPercentage() <= 75 and Cache.EnemiesCount[20]>=1 and not Player:BuffP(S.ShieldofVengeance) then
        return S.EyeforanEye:Cast()
        end

        if S.DivineShield:IsReady() and Player:HealthPercentage() <= 50 and not Player:Debuff(S.Forbearance) and not Player:BuffP(S.ShieldofVengeance) and Player:InArena() then
        return S.DivineShield:Cast()
        end

        if S.DivineShield:IsReady() and Player:HealthPercentage() <= 40 and not Player:Debuff(S.Forbearance) and not Player:BuffP(S.ShieldofVengeance) then
        return S.DivineShield:Cast()
        end

        if S.LayonHands:IsReady() and Player:HealthPercentage() <= 20 and not Player:Debuff(S.Forbearance) and not Player:InArena() and S.DivineShield:CooldownRemains()>Player:GCD() then
        return S.LayonHands:Cast()
        end

        if S.BlessingofProtection:IsReady() and not Player:BuffP(S.ShieldofVengeance) and Player:HealthPercentage() <= 35 and not Player:Debuff(S.Forbearance) and S.DivineShield:CooldownRemainsP()>Player:GCD() and S.LayonHands:CooldownRemainsP()>Player:GCD() and Cache.EnemiesCount[20]>=1 then
        return S.BlessingofProtection:Cast()
        end

        if Player:CanAttack(Target) then

        if I.trinket:IsReady() and Target:IsInRange(12) and I.trinket:IsEquipped() and RubimRH.CDsON() then
        return S.trinket:Cast()
        end	 

    Ranged = function()

        if Player:AffectingCombat() then
        if S.HammerofWrath:IsCastable() and Target:IsInRange(30) and (Player:BuffP(S.AvengingWrath) or Player:BuffP(S.Crusade) or Target:HealthPercentage()<=20) then
        return S.HammerofWrath:Cast()
        end

        if S.BladeofJustice:IsCastable() and Target:IsInRange(15)  then
        return S.BladeofJustice:Cast()
        end

        if S.Judgment:IsCastable() and Target:IsInRange(30) then
        return S.Judgment:Cast()
        end
    end

    end


    Cooldowns = function()

        -- shield_of_vengeance

        -- holy_avenger,if=time_to_hpg=0&
        -- ((buff.avenging_wrath.up|buff.crusade.up)
        -- |(buff.avenging_wrath.down&cooldown.avenging_wrath.remains>40|buff.crusade.down&cooldown.crusade.remains>40))


        -- avenging_wrath,if=(Player:HolyPower()>=4&time<5|Player:HolyPower()>=3&time>5|talent.holy_avenger.enabled&cooldown.holy_avenger.remains=0)&time_to_hpg=0


        if S.AvengingWrath:IsReadyP() and Player:BuffDownP(S.AvengingWrath) and 
        ((Player:HolyPower()>=4 and HL.CombatTime()<5) or 
        (Player:HolyPower()>=3 and HL.CombatTime()>5) or 
        (S.HolyAvenger:IsAvailable() and S.HolyAvenger:CooldownRemainsP() == 0)) then 
        return S.AvengingWrath:Cast()
        end

        -- crusade,if=(Player:HolyPower()>=4&time<5|Player:HolyPower()>=3&time>5|talent.holy_avenger.enabled&cooldown.holy_avenger.remains=0)&time_to_hpg=0

        if S.Crusade:IsReadyP() and Player:BuffDownP(S.Crusade) and 
        ((Player:HolyPower()>=4 and HL.CombatTime()<5) or 
        (Player:HolyPower()>=3 and HL.CombatTime()>5) or 
        (S.HolyAvenger:IsAvailable() and S.HolyAvenger:CooldownRemainsP() == 0)) then 
        return S.Crusade:Cast()
        end

        -- ashen_hallow		  

        -- holy_avenger,if=time_to_hpg=0&((buff.avenging_wrath.up|buff.crusade.up)|(buff.avenging_wrath.down&cooldown.avenging_wrath.remains>40|buff.crusade.down&cooldown.crusade.remains>40))

        if S.HolyAvenger:IsReadyP() and 
        ((Player:BuffP(S.AvengingWrath) or Player:BuffP(S.Crusade)) 
        or (not Player:BuffP(S.AvengingWrath) and S.AvengingWrath:CooldownRemains()>40 or not Player:BuffP(S.Crusade) and S.Crusade:CooldownRemains()>40)) then
        return S.HolyAvenger:Cast()
        end	

        -- final_reckoning,if=Player:HolyPower()>=3&cooldown.avenging_wrath.remains>gcd&time_to_hpg=0&(!talent.seraphim.enabled|buff.seraphim.up)

    end




    Finishers = function()


        --finishers

        -- variable,name=ds_castable,value=spell_targets.divine_storm>=2|buff.empyrean_power.up&debuff.judgment.down&buff.divine_purpose.down|spell_targets.divine_storm>=2&buff.crusade.up&buff.crusade.stack<10

        if (true) then
        VarDsCastable = ((Cache.EnemiesCount[14] >= 2 and I.tempest:IsEquipped() or Cache.EnemiesCount[10] >= 2 and not I.tempest:IsEquipped())
        or (Player:BuffP(S.EmpyreanPowerBuffTalent)
        and not Target:Debuff(S.JudgmentDebuff) 
        and not Player:BuffP(S.DivinePurposeBuff) 
        or (Cache.EnemiesCount[14] >= 2 and I.tempest:IsEquipped() or Cache.EnemiesCount[10] >= 2 and not I.tempest:IsEquipped())
        and Player:BuffP(S.Crusade) 
        and Player:BuffStackP(S.Crusade)<10))
        and RubimRH.AoEON()
        end

        -- seraphim,if=((!talent.crusade.enabled&buff.avenging_wrath.up|cooldown.avenging_wrath.remains>25)|(buff.crusade.up|cooldown.crusade.remains>25))&(not S.FinalReckoning:IsAvailable().enabled|cooldown.final_reckoning.remains<10)&(S.ExecutionSentence:IsAvailable()|S.ExecutionSentence:CooldownRemains()<10)&time_to_hpg=0

        if S.Seraphim:IsReadyP() 
        and (((not S.Crusade:IsAvailable() and Player:BuffP(S.AvengingWrath) or S.AvengingWrath:CooldownRemainsP()>25 or not RubimRH.CDsON()) 
        or (Player:BuffP(S.Crusade) or S.Crusade:CooldownRemainsP()>25 or not RubimRH.CDsON())) 
        -- and (not S.FinalReckoning:IsAvailable() or S.FinalReckoning:CooldownRemainsP()<10 or not RubimRH.CDsON()) 
        and (not S.ExecutionSentence:IsAvailable() or S.ExecutionSentence:CooldownRemainsP()<10 or not RubimRH.CDsON())) then
        return S.Seraphim:Cast()
        end

        -- vanquishers_hammer,if=(not S.FinalReckoning:IsAvailable().enabled|cooldown.final_reckoning.remains>gcd*10|debuff.final_reckoning.up)&(S.ExecutionSentence:IsAvailable()|S.ExecutionSentence:CooldownRemains()>gcd*10|debuff.execution_sentence.up)|spell_targets.divine_storm>=2

        --TO BE ADDED



        -- execution_sentence,if=spell_targets.divine_storm<=3&((!talent.crusade.enabled|buff.crusade.down&cooldown.crusade.remains>10)|buff.crusade.stack>=3|cooldown.avenging_wrath.remains>10|debuff.final_reckoning.up)&time_to_hpg=0

        if S.ExecutionSentence:IsReadyP() and RubimRH.CDsON() and (Cache.EnemiesCount[12] <= 3 or not RubimRH.AoEON()) and Target:IsInRange(30) and
        ((not S.Crusade:IsAvailable() or Player:BuffDownP(S.Crusade) and S.Crusade:CooldownRemainsP()>10 or not RubimRH.CDsON()) or
        Player:BuffStackP(S.Crusade)>=3 or
        S.AvengingWrath:CooldownRemainsP()>10 or
        Target:Debuff(S.FinalReckoning)) then
        return S.ExecutionSentence:Cast()
        end

        -- divine_storm,if=variable.ds_castable&!buff.vanquishers_hammer.up
        -- &((!talent.crusade.enabled|cooldown.crusade.remains>gcd*3)
        -- &(S.ExecutionSentence:IsAvailable()|S.ExecutionSentence:CooldownRemains()>gcd*3|spell_targets.divine_storm>=3)
        -- |spell_targets.divine_storm>=2&(talent.holy_avenger.enabled&cooldown.holy_avenger.remains<gcd*3|buff.crusade.up&buff.crusade.stack<10))

        if S.DivineStorm:IsReadyP() and Target:IsInRange(12)
        and VarDsCastable and not Player:Buff(S.VanquishersHammer) 
        and ((not S.Crusade:IsAvailable() or S.Crusade:CooldownRemainsP()>Player:GCD()*3 or not RubimRH.CDsON()) 
        and (not RubimRH.CDsON() or not S.ExecutionSentence:IsAvailable() or S.ExecutionSentence:CooldownRemainsP()>Player:GCD()*3 or (Cache.EnemiesCount[14] >= 3 and I.tempest:IsEquipped() or Cache.EnemiesCount[10] >= 3 and not I.tempest:IsEquipped())) 
        or (Cache.EnemiesCount[14] >= 2 and I.tempest:IsEquipped() or Cache.EnemiesCount[10] >= 2 and not I.tempest:IsEquipped()) and (S.HolyAvenger:IsAvailable() and S.HolyAvenger:CooldownRemainsP()<Player:GCD()*3 or Player:BuffP(S.Crusade) and Player:BuffStackP(S.Crusade)<10)) then
        return S.DivineStorm:Cast()
        end


        -- templars_verdict,if=
        -- (!talent.crusade.enabled|cooldown.crusade.remains>gcd*3)
        -- &(S.ExecutionSentence:IsAvailable()|S.ExecutionSentence:CooldownRemains()>gcd*3&spell_targets.divine_storm<=3)
        -- &(not S.FinalReckoning:IsAvailable().enabled|cooldown.final_reckoning.remains>gcd*3)
        -- &(!covenant.necrolord.enabled|cooldown.vanquishers_hammer.remains>gcd)
        -- |talent.holy_avenger.enabled&cooldown.holy_avenger.remains<gcd*3|buff.holy_avenger.up|buff.crusade.up&buff.crusade.stack<10|buff.vanquishers_hammer.up

        if S.TemplarsVerdict:IsReadyP() and Target:IsInRange(9)
        and ((not S.Crusade:IsAvailable() or S.Crusade:CooldownRemainsP()>Player:GCD()*3 or not RubimRH.CDsON()) 
        and (not RubimRH.CDsON() or not S.ExecutionSentence:IsAvailable() or S.ExecutionSentence:CooldownRemainsP() > Player:GCD() * 3 and ((Cache.EnemiesCount[14] <= 3 and I.tempest:IsEquipped() or Cache.EnemiesCount[10] <= 3 and not I.tempest:IsEquipped()) or not RubimRH.AoEON())) 
        -- and (not S.FinalReckoning:IsAvailable() or S.FinalReckoning:CooldownRemainsP()>Player:GCD()*3 or not RubimRH.CDsON()) 
        --	and (and not S.Necrolord:Convenant or S.VanquishersHammer:CooldownRemainsP()>Player:GCD())
        or S.HolyAvenger:IsAvailable() and S.HolyAvenger:CooldownRemainsP()<Player:GCD()*3 or Player:BuffP(S.HolyAvenger) or Player:BuffP(S.Crusade) and Player:BuffStackP(S.Crusade) < 10 or Player:BuffP(S.VanquishersHammer)) then
        return S.TemplarsVerdict:Cast()
        end
    end


    Generators = function()

    
        -- if RubimRH.AoEON() then
        -- --BIG AOE

        --     if S.AvengingWrath:IsReadyP() and Player:BuffDownP(S.AvengingWrath) and RubimRH.CDsON()
        --     and (Player:HolyPower()>=3 or S.HolyAvenger:IsAvailable() and S.HolyAvenger:CooldownRemainsP() == 0)
        --     and Cache.EnemiesCount[14] >= 3 then 
        --     return S.AvengingWrath:Cast()
        --     end		  

        --     if S.Crusade:IsReadyP() and Player:BuffDownP(S.Crusade) and RubimRH.CDsON()
        --     and (Player:HolyPower()>=3 or S.HolyAvenger:IsAvailable() 
        --     and S.HolyAvenger:CooldownRemainsP() == 0) and Cache.EnemiesCount[14] >= 3 then 
        --     return S.Crusade:Cast()
        --     end




        --     if S.DivineToll:IsCastable() and RubimRH.CDsON() and not Target:Debuff(S.JudgmentDebuff) 
        --     and S.Judgment:CooldownRemains()>Player:GCD() and Player:HolyPower() <=2  and Cache.EnemiesCount[14] >= 3 
        --     and not Player:PrevGCD(1, S.Judgment) then
        --     return S.DivineToll:Cast()
        --     end

        --     if S.DivineStorm:IsCastable() and (Target:Debuff(S.JudgmentDebuff) or S.Judgment:CooldownRemains()>Player:GCD()) 
        --     and (Player:HolyPower()== 5 or Player:HolyPower() >=3 or Player:BuffP(S.EmpyreanPowerBuffTalent) or Player:BuffP(S.DivinePurposeBuff)) 
        --     and (Cache.EnemiesCount[14] >= 3 and I.tempest:IsEquipped() or Cache.EnemiesCount[10] >= 3 and not I.tempest:IsEquipped()) then
        --     return S.DivineStorm:Cast()
        --     end

        --     if S.WakeofAshes:IsReadyP() and RubimRH:CDsON() and Target:IsInRange(6) 
        --     and Player:HolyPower() <=2 and Cache.EnemiesCount[6]>=3 then
        --     return S.WakeofAshes:Cast()
        --     end

        -- end

        -- call_action_list,name=finishers,if=Player:HolyPower()=5|(debuff.judgment.up|Player:HolyPower()=4)&buff.divine_resonance.up|buff.holy_avenger.up
        if Player:HolyPower() >= 5 or (Target:Debuff(S.Judgment) or Player:HolyPower() >= 4) and Player:BuffP(S.DivineResonance) or Player:BuffP(S.HolyAvenger)  then
            if Finishers() ~= nil then
            return Finishers()
            end
            end	

        -- vanquishers_hammer,if=!runeforge.dutybound_gavel|not S.FinalReckoning:IsAvailable()&!talent.execution_sentence|fight_remains<8
            if S.VanquishersHammer:IsReadyP() and (IsEquippedItem("Dutybound Gavel") or S.FinalReckoning:IsAvailable() and not S.ExecutionSentence:IsAvailable() or Target:TimeToDie()<8) then 
            return S.VanquishersHammer:Cast()
            end

        -- hammer_of_wrath,if=runeforge.the_mad_paragon|covenant.venthyr&cooldown.ashen_hallow.remains>210
        if S.HammerofWrath:IsReadyP() and (IsEquippedItem("Mad Paragon") or S.AshenHallow:CooldownRemains()>210) then 
            return S.HammerofWrath:Cast()
            end

        -- wake_of_ashes,if=Player:HolyPower()<=2&talent.ashes_to_dust&(not S.AvengingWrath:CooldownUp() or not S.Crusade:CooldownUp())
            if S.WakeofAshes:IsReadyP() and RubimRH:CDsON() and Target:IsInRange(6) and Player:HolyPower() <=2 and S.AshestoDust:IsAvailable() and (not S.AvengingWrath:CooldownUp() or not S.Crusade:CooldownUp())  then
            return S.WakeofAshes:Cast()
            end

        -- divine_toll,if=Player:HolyPower()<=2&!debuff.judgment.up&(!talent.seraphim|buff.seraphim.up)
        --&(!raid_event.adds.exists|raid_event.adds.in>30|raid_event.adds.up)
        --&not S.FinalReckoning:IsAvailable()&(!talent.execution_sentence|fight_remains<8|spell_targets.divine_storm>=5)&(cooldown.avenging_wrath.remains>15|cooldown.crusade.remains>15|fight_remains<8)
            if S.DivineToll:IsCastable() and RubimRH.CDsON() and (
                Player:HolyPower() <=2 and not Target:Debuff(S.JudgmentDebuff) and (not S.Seraphim:IsAvailable() or Player:Buff(S.Seraphim)) 
                and Cache.EnemiesCount[14] >= 1 
            and not S.FinalReckoning:IsAvailable() and (not S.ExecutionSentence:IsAvailable() or Target:TimeToDie()<8 or Cache.EnemiesCount[14] >= 5) and (S.AvengingWrath:CooldownRemains()>15 or S.Crusade:CooldownRemains()>15 or Target:TimeToDie()<8)) then
            return S.DivineToll:Cast()
            end        
        
        -- judgment,if=!debuff.judgment.up&(Player:HolyPower()>=1&runeforge.the_magistrates_judgment|Player:HolyPower()>=2)
        if S.Judgment:IsReadyP()  and Target:IsInRange(20) and not Target:Debuff(S.JudgmentDebuff) and (Player:HolyPower() >=1 and IsEquippedItem("Magistrates Judgment") or Player:HolyPower() >=2) then
            return S.Judgment:Cast()
            end
        
        -- wake_of_ashes,if=(Player:HolyPower()=0|Player:HolyPower()<=2&S.BladeofJustice:CooldownRemains()>gcd*2)
        --&(!raid_event.adds.exists|raid_event.adds.in>20|raid_event.adds.up)&(!talent.seraphim|cooldown.seraphim.remains>5|covenant.kyrian)
        --&(!talent.execution_sentence|S.ExecutionSentence:CooldownRemains()>15|target.time_to_die<8|spell_targets.divine_storm>=5)
        --&(not S.FinalReckoning:IsAvailable()|S.FinalReckoning:CooldownRemains()>15|fight_remains<8)&(not S.AvengingWrath:CooldownUp() or not S.Crusade:CooldownUp())

        if S.WakeofAshes:IsReadyP() and RubimRH:CDsON() and Target:IsInRange(6) 
        and (
            (Player:HolyPower() == 0 or Player:HolyPower() <=2 and S.BladeofJustice:CooldownRemainsP() > Player:GCD()*2) 
        and (not S.Seraphim:IsAvailable() or S.Seraphim:CooldownRemains()>5 or covenantID == 1) 
        and (not S.ExecutionSentence:IsAvailable() or S.ExecutionSentence:CooldownRemainsP()>15 or Target:TimeToDie()<8 or Cache.EnemiesCount[12]>=5)
        and (not S.FinalReckoning:IsAvailable() or S.FinalReckoning:CooldownRemainsP()>15 or Target:TimeToDie()<8)
        and (not S.AvengingWrath:CooldownUp() or not S.Crusade:CooldownUp())    
        )
        then
        return S.WakeofAshes:Cast()
        end
  
        
        -- call_action_list,name=finishers,if=Player:HolyPower()>=3&buff.crusade.up&buff.crusade.stack<10
        if Player:HolyPower() >= 3 and Player:Buff(S.Crusade) and Player:BuffStackP(S.Crusade)<10 then
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
        and select(2, C_Soulbinds.IsConduitInstalledInSoulbind(soulbindID, conduitID)) == 182462 --check
        and Player:HolyPower()<=3 then
            return S.BladeofJustice:Cast()
            end          
        
        -- judgment,if=!debuff.judgment.up
        if S.Judgment:IsReadyP() and Target:IsInRange(20) and not Target:Debuff(S.JudgmentDebuff) then
            return S.Judgment:Cast()
            end        
        
        -- hammer_of_wrath
        if S.HammerofWrath:IsReadyP() and Target:IsInRange(20) then
            return S.HammerofWrath:Cast()
            end        
                
        
        -- blade_of_justice,if=Player:HolyPower()<=3
        if S.BladeofJustice:IsReadyP() and Target:IsInRange(12) 
            and Player:HolyPower()<=3 then
            return S.BladeofJustice:Cast()
            end          
               
        
        -- call_action_list,name=finishers,if=(target.health.pct<=20|buff.avenging_wrath.up|buff.crusade.up|buff.empyrean_power.up)
          if (Target:HealthPercentage()<=20 or Player:BuffP(S.AvengingWrath) or Player:BuffP(S.Crusade) or Player:BuffP(S.EmpyreanPowerBuffTalent)) then
        if Finishers() ~= nil then
        return Finishers()
        end
        end	    
        
        -- consecration,if=!consecration.up&spell_targets.divine_storm>=2
        if S.Consecration:IsReadyP() and Target:IsInRange(8) and Cache.EnemiesCount[12]>=2 and ConsecrationTime()<Player:GCD() and 
        then
                   return S.Consecration:Cast()
                   end    
        
        -- crusader_strike,if=cooldown.crusader_strike.charges_fractional>=1.75&(Player:HolyPower()<=2|Player:HolyPower()<=3&S.BladeofJustice:CooldownRemains()>gcd*2|Player:HolyPower()=4&S.BladeofJustice:CooldownRemains()>gcd*2&cooldown.judgment.remains>gcd*2)

        if S.CrusaderStrike:IsReady() and Target:IsInRange(9)
        and (S.CrusaderStrike:ChargesFractional()>=1.75 
        and (Player:HolyPower()<=2 or Player:HolyPower()<=3 and S.BladeofJustice:CooldownRemainsP()>Player:GCD()*2 or Player:HolyPower()==4 and S.BladeofJustice:CooldownRemainsP()>Player:GCD()*2 and S.Judgment:CooldownRemainsP()>Player:GCD()*2)) then
        return S.CrusaderStrike:Cast()
        end  
        
        -- call_action_list,name=finishers
          if Finishers() ~= nil then
        return Finishers()
        end      
        
        -- consecration,if=!consecration.up
        if S.Consecration:IsReadyP() and Target:IsInRange(8) and Cache.EnemiesCount[12]>=1 and ConsecrationTime()<Player:GCD()
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
        if S.Consecration:IsReadyP() and Target:IsInRange(8) and Cache.EnemiesCount[12]>=1
 then
            return S.Consecration:Cast()
            end    

        -- -- call_action_list,name=finishers,if=
  
  
        -- -- Player:HolyPower()>=5|buff.holy_avenger.up|debuff.final_reckoning.up|debuff.execution_sentence.up|buff.memory_of_lucid_dreams.up|buff.seething_rage.up


        -- if (Player:HolyPower() >= 5 or Player:BuffP(S.HolyAvenger) or Target:Debuff(S.FinalReckoning) or Target:Debuff(S.ExecutionSentence) or Player:BuffP(S.SeethingRage))  then
        -- if Finishers() ~= nil then
        -- return Finishers()
        -- end
        -- end	



        -- if S.DivineToll:IsReadyP() and RubimRH.CDsON() and not Target:Debuff(S.JudgmentDebuff) and Cache.EnemiesCount[12]>=1
        -- and ((Player:HolyPower()<=2 or Player:HolyPower()<=4 
        -- and (S.BladeofJustice:CooldownRemainsP()>Player:GCD()*2 or Target:Debuff(S.ExecutionSentence) or Target:Debuff(S.FinalReckoning)))
        -- -- and (not S.FinalReckoning:IsAvailable() or S.FinalReckoning:CooldownRemainsP()>Player:GCD()*10 or not RubimRH.CDsON())
        -- and (not RubimRH.CDsON() or not S.ExecutionSentence:IsAvailable() or S.ExecutionSentence:CooldownRemainsP()>Player:GCD()*10)) then
        -- return S.DivineToll:Cast()
        -- end


        -- -- wake_of_ashes,if=(holy_power=0|holy_power<=2&cooldown.blade_of_justice.remains>gcd*2)&(!raid_event.adds.exists|raid_event.adds.in>20|raid_event.adds.up)
        -- -- &(!talent.seraphim|cooldown.seraphim.remains>5|covenant.kyrian)
        -- -- &(!talent.execution_sentence|cooldown.execution_sentence.remains>15|target.time_to_die<8|spell_targets.divine_storm>=5)
        -- -- &(!talent.final_reckoning|cooldown.final_reckoning.remains>15|fight_remains<8)
        -- -- &(cooldown.avenging_wrath.remains|cooldown.crusade.remains)

        -- -- if S.WakeofAshes:IsReadyP() and RubimRH:CDsON() and Target:IsInRange(6) 
        -- -- and (
        -- --     (Player:HolyPower() == 0 or Player:HolyPower() <=2 and S.BladeofJustice:CooldownRemainsP() > Player:GCD()*2) 
        -- -- and (not S.Seraphim:IsAvailable() or S.Seraphim:CooldownRemains()>5 or covenantID == XXXX) 
        -- -- and (not S.ExecutionSentence:IsAvailable() or S.ExecutionSentence:CooldownRemainsP()>15 or Target:TimeToDie()<8 or Cache.EnemiesCount[12]>=5)
        -- -- and (not S.FinalReckoning:IsAvailable() or S.FinalReckoning:CooldownRemainsP()>15 or Target:TimeToDie()<8)
        -- -- and (not S.AvengingWrath:CooldownUp() or not S.Crusade:CooldownUp())    
        -- -- )
        -- -- then
        -- -- return S.WakeofAshes:Cast()
        -- -- end


        -- -- hammer_of_wrath,if=Player:HolyPower()<=4
        -- if S.HammerofWrath:IsReady() and Target:IsInRange(30) and Player:HolyPower() <= 4  then
        -- return S.HammerofWrath:Cast()
        -- end



        -- -- blade_of_justice,if=Player:HolyPower()<=3
        -- if S.BladeofJustice:IsReady() and Player:HolyPower() <= 3 and Target:IsInRange(15)  then
        -- return S.BladeofJustice:Cast()
        -- end





        -- -- -- judgment,if=!debuff.judgment.up&(Player:HolyPower()<=2|Player:HolyPower()<=4&S.BladeofJustice:CooldownRemains()>gcd*2)
        -- if S.Judgment:IsReady() and not Target:Debuff(S.JudgmentDebuff) and Target:IsInRange(30) and (Player:HolyPower() <= 2 or Player:HolyPower()<=4 and S.BladeofJustice:CooldownRemainsP()>Player:GCD()*2) then
        -- return S.Judgment:Cast()
        -- end
        -- -- if S.Judgment:IsReady() and not Target:Debuff(S.JudgmentDebuff) and Target:IsInRange(30) and 
        -- -- (Player:HolyPower() <= 2
        -- -- or Player:HolyPower()<=4 and S.BladeofJustice:CooldownRemainsP()>Player:GCD()*2
        -- -- )

        -- -- then
        -- -- return S.Judgment:Cast()
        -- -- end


        -- -- call_action_list,name=finishers,if=(target.health.pct<=20|buff.avenging_wrath.up|buff.crusade.up|buff.empyrean_power.up)
        -- if (Target:HealthPercentage()<=20 or Player:BuffP(S.AvengingWrath) or Player:BuffP(S.Crusade) or Player:BuffP(S.EmpyreanPowerBuffTalent)) then
        -- if Finishers() ~= nil then
        -- return Finishers()
        -- end
        -- end	


        -- -- crusader_strike,if=
        -- -- cooldown.crusader_strike.charges_fractional>=1.75
        -- -- &(Player:HolyPower()<=2|Player:HolyPower()<=3&S.BladeofJustice:CooldownRemains()>gcd*2|Player:HolyPower()=4&S.BladeofJustice:CooldownRemains()>gcd*2&cooldown.judgment.remains>gcd*2)

        -- if S.CrusaderStrike:IsReady() and Target:IsInRange(9)
        -- and (S.CrusaderStrike:ChargesFractional()>=1.75 
        -- and (Player:HolyPower()<=2 or Player:HolyPower()<=3 and S.BladeofJustice:CooldownRemainsP()>Player:GCD()*2 or Player:HolyPower()==4 and S.BladeofJustice:CooldownRemainsP()>Player:GCD()*2 and S.Judgment:CooldownRemainsP()>Player:GCD()*2)) then
        -- return S.CrusaderStrike:Cast()
        -- end


        -- -- call_action_list,name=finishers

        -- if Finishers() ~= nil then
        -- return Finishers()
        -- end

        -- -- -- consecration,if=time_to_hpg>gcd
        -- -- if S.Consecration:IsReadyP() and (not Player:IsMoving() and Cache.EnemiesCount[8]>=1 or Player:IsMoving() and Cache.EnemiesCount[6]>=1) then
        -- -- return S.Consecration:Cast()
        -- -- end


        -- -- crusader_strike,if=Player:HolyPower()<=4
        -- if S.CrusaderStrike:IsReady() and Target:IsInRange(9) and Player:HolyPower()<=4 then
        -- return S.CrusaderStrike:Cast()
        -- end



        -- -- arcane_torrent,if=Player:HolyPower()<=4
        -- if S.ArcaneTorrent:IsReady() and RubimRH.CDsON() and Cache.EnemiesCount[8]>=1 and Player:HolyPower()<=4 then
        -- return S.ArcaneTorrent:Cast()
        -- end

        -- -- consecration,if=time_to_hpg>gcd
        -- if S.Consecration:IsReadyP() and (not Player:IsMoving() and Cache.EnemiesCount[8]>=1 or Player:IsMoving() and Cache.EnemiesCount[6]>=1) then
        -- return S.Consecration:Cast()
        -- end


end


-- if S.Rebuke:IsReady(30) and RubimRH.db.profile.mainOption.useInterrupts and Target:IsInterruptible()  then
-- return S.Rebuke:Cast()
-- end

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

if S.FlashofLight:IsCastable() and Player:HealthPercentage() < 85  and Player:BuffStackP(S.SelfLessHealerBuff)==4 and Cache.EnemiesCount[15]==0 then
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


if S.Steward:IsCastable() and I.phialofserenity:Count()<= 1 and Cache.EnemiesCount[20]==0 then
return S.Steward:Cast()
end

if not RubimRH.queuedSpell[1]:CooldownUp() or Cache.EnemiesCount[20]==0 or not Player:AffectingCombat() then
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