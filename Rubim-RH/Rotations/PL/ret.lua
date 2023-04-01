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
    autoattack             = Spell(59752), -- will to survive (human racial)
    TotLB = Spell(383396),
 -- Racials
--  AncestralCall                         = Spell(274738),
 ArcanePulse                           = Spell(260364),
 ArcaneTorrent                         = Spell(50613),
 BagofTricks                           = Spell(312411),
 Berserking                            = Spell(26297),
 BloodFury                             = Spell(20572),
 Fireblood                             = Spell(265221),
 GiftoftheNaaru                        = Spell(59542),
 -- Abilities
 Consecration                          = Spell(26573),
 CrusaderStrike                        = Spell(35395),
 crusaderstrike = Spell(205191), -- eye for an eye
 DivineShield                          = Spell(642),
 DivineSteed                           = Spell(190784),
 FlashofLight                          = Spell(19750),
 HammerofJustice                       = Spell(853),
 HandofReckoning                       = Spell(62124),
 Judgment                              = Spell(20271),
 Rebuke                                = Spell(96231),
 ShieldoftheRighteous                  = Spell(53600),
 WordofGlory                           = Spell(85673),
 -- Talents
 AvengingWrath                         = Spell(31884),
 HammerofWrath                         = Spell(24275),
 HolyAvenger                           = Spell(105809),
 LayonHands                            = Spell(633),
 Seraphim                              = Spell(152262),
 ZealotsParagon                        = Spell(391142),
 -- Auras
 ConcentrationAura                     = Spell(317920),
 CrusaderAura                          = Spell(32223),
 DevotionAura                          = Spell(465),
 RetributionAura                       = Spell(183435),
 -- Buffs
 AvengingWrathBuff                     = Spell(31884),
 BlessingofDuskBuff                    = Spell(385126),
 ConsecrationBuff                      = Spell(188370),
 DivinePurposeBuff                     = Spell(223819),
 HolyAvengerBuff                       = Spell(105809),
 SeraphimBuff                          = Spell(152262),
 ShieldoftheRighteousBuff              = Spell(132403),
 DivineProtection = Spell(403876),
 -- Debuffs
 ConsecrationDebuff                    = Spell(204242),
 JudgmentDebuff                        = Spell(197277),
 -- Pool
 Pool                                  = Spell(999910),


 TemplarsVerdict                       = Spell(85256),
 -- Talents
 AshestoDust                           = Spell(383300),
 BladeofJustice                        = Spell(184575),
 BladeofWrath                          = Spell(231832),
 BlessedChampion                       = Spell(403010),
 BoundlessJudgment                     = Spell(405278),
 Crusade                               = Spell(231895),
 DivineAuxiliary                       = Spell(406158),
 DivineHammer                          = Spell(198034),
 DivineResonance                       = Spell(384027),
 DivineStorm                           = Spell(53385),
 DivineToll                            = Spell(375576),
 EmpyreanLegacy                        = Spell(387170),
 EmpyreanPower                         = Spell(326732),
 ExecutionSentence                     = Spell(343527),
 ExecutionersWrath                     = Spell(387196),
 Exorcism                              = Spell(383185),
 Expurgation                           = Spell(383344),
 FinalReckoning                        = Spell(343721),
 FinalVerdict                          = Spell(383328),
 FiresofJustice                        = Spell(203316),
 HolyBlade                             = Spell(383342),
 JusticarsVengeance                    = Spell(215661),
 RadiantDecree                         = Spell(383469),
 RadiantDecreeTalent                   = Spell(384052),
 RighteousVerdict                      = Spell(267610),
 ShieldofVengeance                     = Spell(184662),
 TemplarSlash                          = Spell(406647),
 TemplarStrike                         = Spell(407480),
 VanguardsMomentum                     = Spell(383314),
 WakeofAshes                           = Spell(255937),
 Zeal                                  = Spell(269569),
 -- Buffs
 CrusadeBuff                           = Spell(231895),
 DivineArbiterBuff                     = Spell(406975),
 DivineResonanceBuff                   = Spell(384029),
 EmpyreanLegacyBuff                    = Spell(387178),
 EmpyreanPowerBuff                     = Spell(326733),
divineprotection = Spell(210256), -- blessing of sanctuary
    BlessingofFreedom = Spell(1044),
    BlindingLight = Spell(115750),
    SenseUndead = Spell(5502),




    lust1                    = Spell(57724),
    lust2                    = Spell(57723),
    lust3                    = Spell(80354),
    lust4                    = Spell(95809),
    lust5                    = Spell(264689),
    lustAT                   = Spell(20549), -- war stomp

    
    DivineSteedBuff          = Spell(221886),
    BlessingofProtection     = Spell(1022),
    Forbearance              = Spell(25771),
    -- Racials
  
 
    DivinePurpose            = Spell(223817),
    -- DivineTollCov                         = Spell(304971),
    DoorofShadows            = Spell(300728),
    Fleshcraft               = Spell(324631),
    Soulshape                = Spell(310143),
    SummonSteward            = Spell(324739),
    VanquishersHammer        = Spell(328204),
    VanquishersHammerBuff    = Spell(328204),
    -- Soulbinds/Conduits (Shadowlands)
   
    PustuleEruption          = Spell(351094),
    VengefulShock            = Spell(340006),
    VengefulShockDebuff      = Spell(340007),
    VolatileSolvent          = Spell(323074),
    VolatileSolventHumanBuff = Spell(323491),
    -- Auras
  
    -- Buffs
    Intercession             = Spell(391054),
    intercession           = Spell(105809), --holy avenger
    trinket                  = Spell(59547), -- gift of narru

    
    ScarsofFraternalStrifeBuff4 = Spell(368638),
    
    TemptationBuff              = Spell(234143),
    -- Debuffs
    
    CruelGarroteDebuff          = Spell(230011),
    -- Legendary Effects
  
    FinalVerdictBuff            = Spell(337228),
  

    CrusadeTalent       = Spell(384392),
 

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
    drums = Item(193470),
};
local I = Item.Paladin.Retribution;


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



local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_TALENT_UPDATE")
frame:SetScript("OnEvent", UpdateTemplarsVerdictSpellId)



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



local VerdictSpell = (S.FinalVerdict:IsAvailable()) and S.FinalVerdict or S.TemplarsVerdict



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

HolyPower = Player:HolyPower()

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



    IsTanking = Player:IsTankingAoE(8) or Player:IsTanking(Target)


    if Player:HealthPercentage() <= 25 and Player:AffectingCombat() and (IsUsableItem(191379) or IsUsableItem(191378)  or IsUsableItem(191380)) 
    and (GetItemCooldown(191380) == 0 or GetItemCooldown(191379) == 0 or GetItemCooldown(191378) == 0) 
    and (GetItemCount(191380) >= 1 or GetItemCount(191379) >= 1 or GetItemCount(191378) >= 1) 
    and (not Player:InArena() and not Player:InBattlegrounds()) then
        return I.HPIcon:Cast()
    end



    if S.ShieldofVengeance:IsCastable() and Player:HealthPercentage() <= 65 and
        (Player:InArena() or Player:InBattlegrounds() or Target:IsAPlayer()) then
        return S.ShieldofVengeance:Cast()
    end


    if S.FlashofLight:IsCastable() and (Player:InArena() or Player:InBattlegrounds()) and Player:HealthPercentage() < 50
        and Player:BuffStackP(S.SelfLessHealerBuff) == 4 then
        return S.FlashofLight:Cast()
    end


    
    if S.Intercession:ID() == RubimRH.queuedSpell[1]:ID() and S.Intercession:IsReady() then
        return S.intercession:Cast() -- BIND LUST KEYBIND IN BINDPAD TO ARCANE TORRENT
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


    if RubimRH.QueuedSpell():IsReadyQueue() then
        return RubimRH.QueuedSpell():Cast()
    end

    if not RubimRH.queuedSpell[1]:CooldownUp() 
    or Cache.EnemiesCount[20] == 0 
    or not Player:AffectingCombat()
         then
        RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
    end


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

    if S.DivineProtection:IsReady() and not Player:BuffP(S.ShieldofVengeance) and Player:HealthPercentage() <= 35 
        and S.DivineShield:CooldownRemainsP() > Player:GCD() and
        S.LayonHands:CooldownRemainsP() > Player:GCD() and Cache.EnemiesCount[20] >= 1 then
        return S.divineprotection:Cast()
    end

    if S.ShieldofVengeance:IsCastable() and Player:HealthPercentage() <= 55 and Player:AffectingCombat() 
    and not Player:Buff(S.DivineProtection) and not Player:Buff(S.DivineShield) and Cache.EnemiesCount[20] >= 1 then
        return S.ShieldofVengeance:Cast()
    end


    if S.WordofGlory:IsCastable() and (S.LayonHands:CooldownRemains()>Player:GCD() or Player:Debuff(S.Forbearance)) 
    and Player:HealthPercentage()<60 and HolyPower>=3 and not Player:Buff(S.DivineShield) and
    not Player:BuffP(S.ShieldofVengeance) and not Player:Buff(S.DivineProtection) then
    return S.WordofGlory:Cast()
end

    if Player:CanAttack(Target) then


        if not IsCurrentSpell(6603) and Player:CanAttack(Target) and not Target:IsDeadOrGhost() and Target:AffectingCombat() and Target:IsInRange(20) then
            return S.autoattack:Cast()
        end


        if (IsUsableSpell("Templar Slash") or S.TemplarStrike:IsReady() or S.CrusaderStrike:IsReady()) and UnitName('target') == 'Explosives' then
            return S.crusaderstrike:Cast()
        end


        Ranged = function()

            if Player:AffectingCombat() then
                if S.HammerofWrath:IsReadyP() and Target:IsInRange(30) and (Player:BuffP(S.AvengingWrath) or Player:BuffP(S.Crusade) or Target:HealthPercentage()<=20) then
                return S.HammerofWrath:Cast()
                end

          
                if S.Judgment:IsCastable() and Target:IsInRange(30) then
                    return S.Judgment:Cast()
                end
            end

        end


        Cooldowns = function()

            if RubimRH.CDsON() and Target:IsInRange(5) and not Target:IsDeadOrGhost() and Player:CanAttack(Target) then
                local ShouldReturn = UseItems();
                if ShouldReturn then return ShouldReturn; end
            end
            

            if S.AvengingWrath:IsCastable() and (HolyPower >= 4 and HL.CombatTime() < 5 or HolyPower >= 3 and HL.CombatTime() > 5 or HolyPower >= 2 and S.DivineAuxiliary:IsAvailable() and (S.ExecutionSentence:CooldownUp() or S.FinalReckoning:CooldownUp())) then
                return S.AvengingWrath:Cast()
              end

              if S.Crusade:IsCastable() and (HolyPower >= 4 and HL.CombatTime() < 5 or HolyPower >= 3 and HL.CombatTime() >= 5) then
                return S.Crusade:Cast()
              end

              -- execution_sentence,if=(!buff.crusade.up&cooldown.crusade.remains>10|buff.crusade.stack=10|cooldown.avenging_wrath.remains>10)&(holy_power>=3|holy_power>=2&talent.divine_auxiliary)&target.time_to_die>8
              if S.ExecutionSentence:IsCastable() and ((not Player:Buff(S.CrusadeBuff) and S.Crusade:CooldownRemains() > 10 
              or Player:BuffStack(S.CrusadeBuff) == 1 or S.AvengingWrath:CooldownRemains() > 10) 
              and (HolyPower >= 3 or HolyPower >= 2 and S.DivineAuxiliary:IsAvailable()) and Target:TimeToDie() > 8) then
                return S.ExecutionSentence:Cast()
              end

              -- final_reckoning,if=(holy_power>=4&time<8|holy_power>=3&time>=8|holy_power>=2&talent.divine_auxiliary)&(cooldown.avenging_wrath.remains>gcd|cooldown.crusade.remains&(!buff.crusade.up|buff.crusade.stack>=10))&(time_to_hpg>0|holy_power=5|holy_power>=2&talent.divine_auxiliary)&(!raid_event.adds.exists|raid_event.adds.up|raid_event.adds.in>40)
              if S.FinalReckoning:IsCastable() and RubimRH.CDsON() and Target:IsInRange(5) and ((HolyPower >= 4 and HL.CombatTime() < 8 
              or HolyPower >= 3 and HL.CombatTime() >= 8 or HolyPower >= 2 and S.DivineAuxiliary:IsAvailable()) 
              and (S.AvengingWrath:CooldownRemains() > Player:GCD() or S.Crusade:CooldownDown() 
              and (not Player:Buff(S.CrusadeBuff) or Player:BuffStack(S.CrusadeBuff) >= 10)) 
              and (TimeToHPG > 0 or HolyPower == 5 or HolyPower >= 2 and S.DivineAuxiliary:IsAvailable())) then
                return S.FinalReckoning:Cast()
              end


        end




        Finishers = function()


            -- variable,name=ds_castable,value=spell_targets.divine_storm>=2|buff.empyrean_power.up&!debuff.judgment.up&!buff.divine_purpose.up

            if (true) then
                VarDsCastable = (
                    (
                        Cache.EnemiesCount[12] >= 2 and S.TotLB:IsAvailable() or
                            Cache.EnemiesCount[8] >= 2 and not S.TotLB:IsAvailable())
                        or (Player:BuffP(S.EmpyreanPowerBuff))
      
                    and RubimRH.AoEON())
            end

        

            -- radiant_decree,if=(buff.crusade.down&cooldown.crusade.remains>5|buff.crusade.stack>=3|cooldown.avenging_wrath.remains>5)
            --&(!talent.final_reckoning|cooldown.final_reckoning.remains>5)
            if IsUsableSpell('Radiant Decree') and HolyPower >= 3 and S.RadiantDecree:CooldownUp() and
                Target:IsInRange(5) and RubimRH.CDsON() 
                and
                (
                (
                    not Player:Buff(S.Crusade) or S.Crusade:CooldownRemainsP() > 5 or Player:BuffStackP(S.Crusade) >= 3
                        or S.AvengingWrath:CooldownRemains() > 5))
                and (not S.FinalReckoning:IsAvailable() or S.FinalReckoning:CooldownRemains() > 5)
            then
                return S.RadiantDecree:Cast()
            end

            if S.DivineStorm:IsReady() and (VarDsCastable and (not RubimRH.CDsON() or RubimRH.CDsON() and (not Player:Buff(S.EmpyreanLegacyBuff) 
            and (not (Player:Buff(S.DivineArbiterBuff) and Player:BuffStack(S.DivineArbiterBuff) > 24))
             and (((not S.Crusade:IsAvailable()) or S.Crusade:CooldownRemains() > Player:GCD() * 3) 
             and ((not S.ExecutionSentence:IsAvailable()) or S.DivineAuxiliary:IsAvailable() 
             or Target:TimeToDie() < 8 or S.ExecutionSentence:CooldownRemains() > Player:GCD() * 2) 
             and ((not S.FinalReckoning:IsAvailable()) or S.DivineAuxiliary or S.FinalReckoning:CooldownRemains() > Player:GCD() * 2) 
             or Player:Buff(S.CrusadeBuff) and Player:BuffStack(S.CrusadeBuff) < 10)))) then
                return S.DivineStorm:Cast() 
              end

              -- justicars_vengeance,if=(!talent.crusade|cooldown.crusade.remains>gcd*3)&(!talent.execution_sentence|talent.divine_auxiliary|target.time_to_die<8|cooldown.execution_sentence.remains>gcd*2)&(!talent.final_reckoning|talent.divine_auxiliary|cooldown.final_reckoning.remains>gcd*2)|buff.crusade.up&buff.crusade.stack<10
              if S.JusticarsVengeance:IsReady() and (not RubimRH.CDsON() or RubimRH.CDsON() and (((not S.Crusade:IsAvailable()) or S.Crusade:CooldownRemains() > Player:GCD() * 3) 
              and ((not S.ExecutionSentence:IsAvailable()) or S.DivineAuxiliary:IsAvailable() or Target:TimeToDie() < 8 
              or S.ExecutionSentence:CooldownRemains() > Player:GCD() * 2) 
              and ((not S.FinalReckoning:IsAvailable()) or S.DivineAuxiliary:IsAvailable() or S.FinalReckoning:CooldownRemains() > Player:GCD() * 2)
               or Player:Buff(S.CrusadeBuff) and Player:BuffStack(S.CrusadeBuff) < 10)) then
                return S.JusticarsVengeance:Cast()
              end

            --   templars_verdict,if=(!talent.crusade|cooldown.crusade.remains>gcd*3)&(!talent.execution_sentence|talent.divine_auxiliary|target.time_to_die<8|cooldown.execution_sentence.remains>gcd*2)&(!talent.final_reckoning|talent.divine_auxiliary|cooldown.final_reckoning.remains>gcd*2)|buff.crusade.up&buff.crusade.stack<10
              if VerdictSpell:IsReady() and (not RubimRH.CDsON() or RubimRH.CDsON() and (((not S.Crusade:IsAvailable()) or S.Crusade:CooldownRemains() > Player:GCD() * 3) 
              and ((not S.ExecutionSentence:IsAvailable()) or S.DivineAuxiliary:IsAvailable() or Target:TimeToDie() < 8 
              or S.ExecutionSentence:CooldownRemains() > Player:GCD() * 2) and ((not S.FinalReckoning:IsAvailable()) or S.DivineAuxiliary:IsAvailable() 
              or S.FinalReckoning:CooldownRemains() > Player:GCD() * 2) or Player:Buff(S.CrusadeBuff) and Player:BuffStack(S.CrusadeBuff) < 10)) then
                return VerdictSpell:Cast()
              end


        end


        Generators = function()


            if Target:AffectingCombat() or Player:AffectingCombat() and Player:CanAttack(Target) then 

                if RubimRH.AoEON() then
                    --burst AOE

                    if S.AvengingWrath:IsReadyP() and not Player:BuffP(S.AvengingWrath) and RubimRH.CDsON()
                        and (HolyPower >= 3 or S.HolyAvenger:IsAvailable() and S.HolyAvenger:CooldownRemainsP() == 0
                        )
                        and Cache.EnemiesCount[15] >= 3 then
                        return S.AvengingWrath:Cast()
                    end

                    if S.Crusade:IsReadyP() and not Player:BuffP(S.Crusade) and RubimRH.CDsON()
                        and (HolyPower >= 3 or S.HolyAvenger:IsAvailable()
                            and S.HolyAvenger:CooldownRemainsP() == 0) and Cache.EnemiesCount[15] >= 3 then
                        return S.Crusade:Cast()
                    end

                    if S.WakeofAshes:IsReady() and S.Judgment:CooldownRemains()>Player:GCD() 
                    and RubimRH.CDsON() and Target:IsInRange(5) and Cache.EnemiesCount[15]>=3 
                    and (not S.FinalReckoning:IsAvailable() or S.FinalReckoning:CooldownRemains() > 5)
                    then
                        return S.WakeofAshes:Cast()
                    end


                    if S.DivineToll:IsCastable() and RubimRH.CDsON() and HolyPower <= 2 and
                        Cache.EnemiesCount[15] >= 3
                        and not Player:PrevGCD(1, S.Judgment) then
                        return S.DivineToll:Cast()
                    end

                    if IsUsableSpell('Radiant Decree') and HolyPower >= 3 and S.RadiantDecree:CooldownUp() and
                        Target:IsInRange(5) and RubimRH.CDsON()
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


                -- call_action_list,name=finishers,if=holy_power=5|(debuff.judgment.up|holy_power=4)&buff.divine_resonance.up
                if (HolyPower >= 5 or (Target:Debuff(S.JudgmentDebuff) or HolyPower == 4) and Player:Buff(S.DivineResonanceBuff)) then
                    if Finishers() ~= nil then
                        return Finishers()
                    end
                end
                -- wake_of_ashes,if=holy_power<=2&(cooldown.avenging_wrath.remains|cooldown.crusade.remains)&(!talent.execution_sentence|cooldown.execution_sentence.remains>4|target.time_to_die<8)&(!raid_event.adds.exists|raid_event.adds.in>20|raid_event.adds.up)
                if S.WakeofAshes:IsCastable() and RubimRH.CDsON() and Target:IsInRange(5) and (HolyPower <= 2 and (S.AvengingWrath:CooldownDown() or S.Crusade:CooldownDown()) and ((not S.ExecutionSentence:IsAvailable()) or S.ExecutionSentence:CooldownRemains() > 4 or Target:TimeToDie() < 8)) then
                    return S.WakeofAshes:Cast()
                end
                -- divine_toll,if=holy_power<=2&!debuff.judgment.up&(!raid_event.adds.exists|raid_event.adds.in>30|raid_event.adds.up)&(cooldown.avenging_wrath.remains>15|cooldown.crusade.remains>15|fight_remains<8)
                if S.DivineToll:IsCastable() and (HolyPower <= 2 and not Target:Debuff(S.JudgmentDebuff) and ((not S.Seraphim:IsAvailable()) or Player:Buff(S.SeraphimBuff)) and (not S.FinalReckoning:IsAvailable()) and ((not S.ExecutionSentence) or Target:TimeToDie() < 8 or Cache.EnemiesCount[8] >= 5) and (S.AvengingWrath:CooldownRemains() > 15 or S.Crusade:CooldownRemains() > 15 or Target:TimeToDie() < 8)) then
                    return S.DivineToll:Cast()
                end
                -- call_action_list,name=finishers,if=holy_power>=3&buff.crusade.up&buff.crusade.stack<10
                if (HolyPower >= 3 and Player:Buff(S.CrusadeBuff) and Player:BuffStack(S.CrusadeBuff) < 10) then
                    if Finishers() ~= nil then
                        return Finishers()
                    end
                end
                -- templar_slash,if=buff.templar_strikes.remains<gcd&spell_targets.divine_storm>=2
                if IsUsableSpell("Templar Slash")  and (S.TemplarStrike:TimeSinceLastCast() + Player:GCD() < 4 and Cache.EnemiesCount[8] >= 2) then
                    return S.crusaderstrike:Cast()
                end
                -- judgment,if=!debuff.judgment.up&(holy_power<=3|!talent.boundless_judgment)&spell_targets.divine_storm>=2
                if S.Judgment:IsReady() and (not Target:Debuff(S.JudgmentDebuff) and (HolyPower <= 3 or not S.BoundlessJudgment:IsAvailable()) and Cache.EnemiesCount[8] >= 2) then
                    return S.Judgment:Cast()
                end
                -- blade_of_justice,if=(holy_power<=3|!talent.holy_blade)&spell_targets.divine_storm>=2
                if S.BladeofJustice:IsCastable() and ((HolyPower <= 3 or not S.HolyBlade:IsAvailable()) and Cache.EnemiesCount[8] >= 2) then
                    return S.BladeofJustice:Cast()
                end
                -- hammer_of_wrath,if=(spell_targets.divine_storm<2|!talent.blessed_champion)&(holy_power<=3|target.health.pct>20|!talent.vanguards_momentum)
                if S.HammerofWrath:IsReady() and ((Cache.EnemiesCount[8] < 2 or not S.BlessedChampion:IsAvailable()) and (HolyPower <= 3 or Target:HealthPercentage() > 20 or not S.VanguardsMomentum:IsAvailable())) then
                    return S.HammerofWrath:Cast()
                end
                -- templar_slash,if=buff.templar_strikes.remains<gcd
                if IsUsableSpell("Templar Slash") and (S.TemplarStrike:TimeSinceLastCast() + Player:GCD() < 4) then
                    return S.crusaderstrike:Cast()
                end
                -- blade_of_justice,if=holy_power<=3|!talent.holy_blade
                if S.BladeofJustice:IsCastable() and (HolyPower <= 3 or not S.HolyBlade:IsAvailable()) then
                    return S.BladeofJustice:Cast()
                end
                -- judgment,if=!debuff.judgment.up&(holy_power<=3|!talent.boundless_judgment)
                if S.Judgment:IsReady() and (not Target:Debuff(S.JudgmentDebuff) and (HolyPower <= 3 or not S.BoundlessJudgment:IsAvailable())) then
                    return S.Judgment:Cast()
                end
                -- call_action_list,name=finishers,if=(target.health.pct<=20|buff.avenging_wrath.up|buff.crusade.up|buff.empyrean_power.up)
                if (Target:HealthPercentage() <= 20 or Player:Buff(S.AvengingWrathBuff) or Player:Buff(S.CrusadeBuff) or Player:Buff(S.EmpyreanPowerBuff)) then
                    if Finishers() ~= nil then
                        return Finishers()
                    end
                end
                -- consecration,if=!consecration.up&spell_targets.divine_storm>=2
                if S.Consecration:IsCastable() and (not Target:Debuff(S.ConsecrationDebuff) and Cache.EnemiesCount[8] >= 2) then
                    return S.Consecration:Cast()
                end
                -- divine_hammer,if=spell_targets.divine_storm>=2
                if S.DivineHammer:IsCastable() and (Cache.EnemiesCount[8] >= 2) then
                    return S.DivineHammer:Cast()
                end
                -- crusader_strike,if=cooldown.crusader_strike.charges_fractional>=1.75&(holy_power<=2|holy_power<=3&cooldown.blade_of_justice.remains>gcd*2|holy_power=4&cooldown.blade_of_justice.remains>gcd*2&cooldown.judgment.remains>gcd*2)
                if S.CrusaderStrike:IsCastable() and (S.CrusaderStrike:ChargesFractional() >= 1.75 and (HolyPower <= 2 or HolyPower <= 3 and S.BladeofJustice:CooldownRemains() > Player:GCD() * 2 or HolyPower == 4 and S.BladeofJustice:CooldownRemains() > Player:GCD() * 2 and S.Judgment:CooldownRemains() > Player:GCD() * 2)) then
                    return S.crusaderstrike:Cast()
                end
                -- call_action_list,name=finishers
                if Finishers() ~= nil then
                    return Finishers()
                end
                -- templar_slash
                if IsUsableSpell("Templar Slash")  then
                    return S.crusaderstrike:Cast()
                end
                -- templar_strike
                if S.TemplarStrike:IsReady() then
                    return S.crusaderstrike:Cast()
                end
                -- judgment,if=holy_power<=3|!talent.boundless_judgment
                if S.Judgment:IsReady() and (HolyPower <= 3 or not S.BoundlessJudgment:IsAvailable()) then
                    return S.Judgment:Cast()
                end
                -- hammer_of_wrath,if=holy_power<=3|target.health.pct>20|!talent.vanguards_momentum
                if S.HammerofWrath:IsReady() and (HolyPower <= 3 or Target:HealthPercentage() > 20 or not S.VanguardsMomentum:IsAvailable()) then
                    return S.HammerofWrath:Cast()
                end
                -- crusader_strike
                if S.CrusaderStrike:IsCastable() then
                    return S.crusaderstrike:Cast()
                end
                -- arcane_torrent
                if S.ArcaneTorrent:IsCastable() then
                    return S.ArcaneTorrent:Cast()
                end
                -- consecration
                if S.Consecration:IsCastable() then
                    return S.Consecration:Cast()
                end
                -- divine_hammer
                if S.DivineHammer:IsCastable() then
                    return S.DivineHammer:Cast()
                end
            end
            
        end

        if select(8, UnitCastingInfo("target")) == false and Target:CastPercentage() > math.random(43, 87) and
            RubimRH.InterruptsON() and S.Rebuke:IsReady(8) and Player:AffectingCombat() then
            return S.Rebuke:Cast()
        end

        if not Target:IsInRange(20) then
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
    
        if not RubimRH.queuedSpell[1]:CooldownUp() 
        or Cache.EnemiesCount[20] == 0 
        or not Player:AffectingCombat()
        
         then
            RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
        end
    


        -- if Target:IsInRange(30) then
        --     return S.crusaderstrike:Cast()
        -- end

        if S.RetributionAura:IsCastable() and not Player:BuffP(S.RetributionAura) then
            return S.RetributionAura:Cast()
        end



        return 0, "Interface\\Addons\\Rubim-RH\\Media\\prot.tga"

    end

    return 0, 135328
end

RubimRH.Rotation.SetAPL(70, APL);

local function PASSIVE()

end

RubimRH.Rotation.SetPASSIVE(70, PASSIVE);
