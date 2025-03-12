local addonName, addonTable = ...;
local HL = HeroLib;
local Cache = HeroCache;
local Unit = HL.Unit;
local Player = Unit.Player;
local Target = Unit.Target;
local Spell = HL.Spell;
local Item = HL.Item;
local MouseOver = Unit.MouseOver;
local pairs = pairs;
local tableconcat = table.concat;
local tostring = tostring;
local tableinsert = table.insert;

if not Spell.Paladin then
    Spell.Paladin = {};
end

RubimRH.Spell[70] = {
   


    autoattack = Spell(59752), -- will to survive (human racial)
    TotLB = Spell(383396),
    VanguardofJustice = Spell(406545),
    Repentance = Spell(20066),
    TurnEvil = Spell(10326),
    CleanseToxins = Spell(213644),
    ArcanePulse = Spell(260364),
    ArcaneTorrent = Spell(50613),
    BagofTricks = Spell(312411),
    Berserking = Spell(26297),
    BloodFury = Spell(20572),
    Fireblood = Spell(265221),
    GiftoftheNaaru = Spell(59542),
    BlessingofSacrifice = Spell(6940),
    RadiantGlory = Spell(458359),
    WordofGloryFocus = Spell(5502), --sense undead
    CleanseToxinsFocus = Spell(20594), --stone form
    LayonHandsFocus = Spell(172321),--seraphim
    BlessingofProtectionFocus = Spell(28880),-- gift of naaru
    Consecration = Spell(26573),
    CrusaderStrike = Spell(35395),
    DivineShield = Spell(642),
    DivineSteed = Spell(190784),
    FlashofLight = Spell(19750),
    HammerofJustice = Spell(853),
    HandofReckoning = Spell(62124),
    Judgment = Spell(20271),
    Rebuke = Spell(96231),
    ShieldoftheRighteous = Spell(53600),
    WordofGlory = Spell(85673),
    AvengingWrath = Spell(31884),
    HammerofWrath = Spell(24275),
    HolyAvenger = Spell(105809),
    LayonHands = Spell(633),
    Seraphim = Spell(152262),
    ZealotsParagon = Spell(391142),
    BladeofVengeance = Spell(403826),
    ConcentrationAura = Spell(317920),
    CrusaderAura = Spell(32223),
    DevotionAura = Spell(465),
    RetributionAura = Spell(183435),
    AvengingWrathBuff = Spell(31884),
    BlessingofDuskBuff = Spell(385126),
    ConsecrationBuff = Spell(188370),
    DivinePurposeBuff = Spell(223819),
    HolyAvengerBuff = Spell(105809),
    SeraphimBuff = Spell(152262),
    ShieldoftheRighteousBuff = Spell(132403),
    DivineProtection = Spell(403876),
    ConsecratedBlade = Spell(404834),
    ConsecrationDebuff = Spell(204242),
    JudgmentDebuff = Spell(197277),
    Pool = Spell(999910),
    VoidRift = Spell(440313),
    TemplarsVerdict = Spell(85256),
    AshestoDust = Spell(383300),
    BladeofJustice = Spell(184575),
    BladeofWrath = Spell(231832),
    BlessedChampion = Spell(403010),
    BoundlessJudgment = Spell(405278),
    Crusade = Spell(231895),
    DivineAuxiliary = Spell(406158),
    LightsGuidance = Spell(427445),
    DivineHammer = Spell(198034),
    DivineHammerz = Spell(190784), --divine steed
    DivineResonance = Spell(384027),
    DivineStorm = Spell(53385),
    DivineToll = Spell(375576),
    BlessingofAnsheBuff = Spell(445206),
    EmpyreanLegacy = Spell(387170),
    EmpyreanPower = Spell(326732),
    ExecutionSentence = Spell(343527),
    ExecutionersWill = Spell(406940),
    ExecutionersWrath = Spell(387196),
    Exorcism = Spell(383185),
    Expurgation = Spell(383344),
    VengefulWrath = Spell(406835),
    FinalReckoning = Spell(343721),
    FinalVerdict = Spell(383328),
    HammerofLight = Spell(427453),
    FiresofJustice = Spell(203316),
    HolyBlade = Spell(383342),
    Potion = Spell(176108),
    JusticarsVengeance = Spell(215661),
    Burst = Spell(243237),
    RighteousVerdict = Spell(267610),
    ShieldofVengeance = Spell(184662),
    TemplarSlash = Spell(406647),
    TemplarStrike = Spell(407480),
    VanguardsMomentum = Spell(383314),
    WakeofAshes = Spell(403695), --truths wake
    WakeofAshesz = Spell(255937), --truths wake
    Zeal = Spell(269569),
    DivineArbiter = Spell(404306),
    DivineArbiterBuff = Spell(406975),
    DivineResonanceBuff = Spell(384029),
    EmpyreanPowerBuff = Spell(326733),
    divineprotection = Spell(210256), -- blessing of sanctuary
    BlessingofFreedom = Spell(1044),
    BlessingofFreedomz = Spell(145067), --turn evil
    BlindingLight = Spell(115750),
    SenseUndead = Spell(5502),
    EmpyreanLegacyBuff = Spell(387178),
    Entangling = Spell(408556),
    deepchill = Spell(391634),
    lust1 = Spell(57724),
    lust2 = Spell(57723),
    lust3 = Spell(80354),
    lust4 = Spell(95809),
    lust5 = Spell(264689),
    lustAT = Spell(255647), -- war stomp
    IcyBindings = Spell(377488),
    FrostShock = Spell(385963),
    DivineSteedBuff = Spell(221886),
    BlessingofProtection = Spell(1022),
    Forbearance = Spell(25771),
    CrusadingStrikes = Spell(404542),
    DivinePurpose = Spell(223817),
    DoorofShadows = Spell(300728),
    Fleshcraft = Spell(324631),
    Soulshape = Spell(310143),
    SummonSteward = Spell(324739),
    VanquishersHammer = Spell(328204),
    VanquishersHammerBuff = Spell(328204),
    PustuleEruption = Spell(351094),
    VengefulShock = Spell(340006),
    VengefulShockDebuff = Spell(340007),
    VolatileSolvent = Spell(323074),
    VolatileSolventHumanBuff = Spell(323491),
    Intercession = Spell(391054),
    intercession = Spell(105809), --holy avenger
    trinket = Spell(59547), -- gift of narru
    ScarsofFraternalStrifeBuff4 = Spell(368638),
    TemptationBuff = Spell(234143),
    CruelGarroteDebuff = Spell(230011),
    FinalVerdictBuff = Spell(337228),
    CrusadeTalent = Spell(384392),
    mhweapcast = Spell(383185), --exorcism
    CrusadeBuffRG = Spell(454373), --with rg talent
    CrusadeBuff = Spell(231895),
    TWW_S2_2pcBuff = Spell(1216828), -- Winning Streak
    TWW_S2_4pcBuff = Spell(1216837), -- AllIn
    ExpurgationDebuff = Spell(383346),
    Jurisdiction = Spell(402971),
    HolyFlames = Spell(406545),
}

--IsReady(427453,1) and C_Spell.GetSpellInfo("Wake of Ashes").iconID == 5342121

local S = RubimRH.Spell[70]
local G = RubimRH.Spell[1] -- General Skills

S.AvengingWrath.TextureSpellID = { 55748 }
S.Crusade.TextureSpellID = { 55748 }
S.CrusaderStrike.TextureSpellID = { 342348 }
S.WakeofAshes.TextureSpellID = { 403695 }
S.DivineToll.TextureSpellID = { 304971 }

-- Items
if not Item.Paladin then Item.Paladin = {} end

Item.Paladin.Retribution = {

    HPIcon = Item(169451),

};

local I = Item.Paladin.Retribution;

-- local function Princess()
--     if los == false and UnitExists('focus') and C_Spell.IsSpellInRange("Flash of Light", "focus") then
--         if IsReady("Intercession",nil,nil,1,1) and UnitIsDeadOrGhost("focus") and (rezcharges>=1 or level ==0) then
--             if IsReady("Intercession") then
--                 return S.intercession:Cast()
--             elseif Player:HolyPower() < 3 then
--                 if IsReady("Judgment") and TargetinRange(5) then
--                     return S.Judgment:Cast()
--                 end

--                 if IsReady("Hammer of Wrath") and TargetinRange(30) then
--                     return S.HammerofWrath:Cast()
--                 end

--                 if IsReady("Blade of Justice") then
--                     return S.BladeofJustice:Cast()
--                 end
--             end
--         end

--         if IsReady("Lay on Hands") and GetFocusTargetHealthPercentage()<30 and not AuraUtil.FindAuraByName("Forbearance", "focus", "HARMFUL") then
--             return S.LayonHandsFocus:Cast()
--         end

--         if IsReady("Blessing of Freedom") and (freedom() or Player:DebuffUp(S.Entangled) or AuraUtil.FindAuraByName("Time Sink", "focus", "HARMFUL") or AuraUtil.FindAuraByName("Containment Beam", "focus", "HARMFUL")) then
--             return S.BlessingofFreedomz:Cast()
--         end

--         -- if IsReady("Blessing of Protection") and RangeCount(30) > 2 and GetFocusTargetHealthPercentage()<40 and not AuraUtil.FindAuraByName("Forbearance", "focus", "HARMFUL") then
--         --     return S.BlessingofProtectionFocus:Cast()
--         -- end

--         if IsReady("Blessing of Sacrifice") and (GetFocusTargetHealthPercentage() < 60 or mitigate()) then
--             return S.BlessingofSacrifice:Cast()
--         end

--         if IsReady("Word of Glory") and GetFocusTargetHealthPercentage() < 45 and (WordofGlorycast or Player:HolyPower() >= 3) then
--             return S.WordofGloryFocus:Cast()
--         end

--         -- if IsReady("Cleanse Toxins") and (GetAppropriateCureSpellfocus() == 'Poison' or GetAppropriateCureSpellfocus()=='Disease') and Player:HealthPercentage() > 80 then
--         --     return S.CleanseToxinsFocus:Cast()
--         -- end
--     end

--     return nil
-- end

local function Cooldowns()
--potion,if=buff.avenging_wrath.up|buff.crusade.up|debuff.execution_sentence.up|fight_remains<30
	-- if TargetinRange(10) and RubimRH.CDsON() and not Player:InArena() and not Player:InBattlegrounds() and (avengingwrathbuff >= 17 or Player:BuffRemains(S.Crusade) >= 17 or Target:DebuffUp(S.ExecutionSentence)) then
    --     if potion_ready then
	-- 	    return S.Potion:Cast()
    --     end
	-- end            
    
    if RubimRH.CDsON() and TargetinRange(20) and (AuraUtil.FindAuraByName("Avenging Wrath", "player") 
    or AuraUtil.FindAuraByName("Crusade", "player") or S.AvengingWrath:CooldownRemains() > 17 or S.Crusade:CooldownRemains() > 17) then

    
        if trinket1ready and trinket1 ~= 202612 and trinket1 ~= 203729 and (trinket1 ~= 203963 or trinket1 ~= 193701 or not Player:IsMoving()) 
        and (trinket1 ~= 207167 or avengingwrathbuff >= 17 or crusadebuff >= 17 
        or (S.RadiantGlory:IsAvailable() and crusadebuff >= 8)) then
           return Item(118330):Cast()
        end
        
        if trinket2ready and trinket2 ~= 202612 and trinket2 ~= 203729 and (trinket2 ~= 203963 or trinket2 ~= 193701 or not Player:IsMoving()) 
        and (trinket2 ~= 207167 or avengingwrathbuff >= 17 or crusadebuff >= 17 
        or (S.RadiantGlory:IsAvailable() and crusadebuff >= 8)) then
            return Item(114616):Cast()
        end
    end

  -- execution_sentence,if=(!buff.crusade.up&cooldown.crusade.remains>15|buff.crusade.stack=10|cooldown.avenging_wrath.remains<0.75|cooldown.avenging_wrath.remains>15|talent.radiant_glory)&(holy_power>=4&time<5|holy_power>=3&time>5|
  --(holy_power>=2|time<5)&(talent.divine_auxiliary|talent.radiant_glory))&(cooldown.divine_hammer.remains>5|buff.divine_hammer.up|!talent.divine_hammer)&(target.time_to_die>8&!talent.executioners_will|target.time_to_die>12)&cooldown.wake_of_ashes.remains<gcd


    if IsReady("Execution Sentence") and TargetinRange(30) and ((not AuraUtil.FindAuraByName("Crusade", "player") and S.Crusade:CooldownRemains() > 15 
    or crusadestack == 10 or  S.AvengingWrath:CooldownRemains() < 0.75 or  S.AvengingWrath:CooldownRemains() > 15 or S.RadiantGlory:IsAvailable()) and ( Player:HolyPower()>=4 and HL.CombatTime() < 5 or Player:HolyPower() >= 3 and HL.CombatTime() > 5 
    or (Player:HolyPower() >= 2 or HL.CombatTime() < 5)  and (S.DivineAuxiliary:IsAvailable() or S.RadiantGlory:IsAvailable())) and (S.DivineHammer:CooldownRemains() > 5 or Player:BuffUp(S.DivineHammer) or not S.DivineHammer:IsAvailable())
    and (aoeTTD() > 8 and not S.ExecutionersWill:IsAvailable() or aoeTTD() > 12) and S.WakeofAshes:CooldownRemains() < Player:GCD()) then
    return S.ExecutionSentence:Cast()
end   

 
    if TargetinRange(10) and RubimRH.CDsON() then
--avenging_wrath,if=(holy_power>=4&time<5|holy_power>=3&time>5|holy_power>=2&talent.divine_auxiliary&(cooldown.execution_sentence.remains=0|cooldown.final_reckoning.remains=0))&(!raid_event.adds.up|target.time_to_die>10)    
        if IsReady("Avenging Wrath") and not S.RadiantGlory:IsAvailable() and ((Player:HolyPower() >= 4 and HL.CombatTime() < 5 or Player:HolyPower() >= 3 and HL.CombatTime() > 5 or Player:HolyPower() >= 2 and S.DivineAuxiliary:IsAvailable() and (S.ExecutionSentence:CooldownRemains() == 0 or S.FinalReckoning:CooldownRemains() == 0))) then
            return S.AvengingWrath:Cast()
        end    
        
--crusade,if=holy_power>=5&time<5|holy_power>=3&time>5    
        if IsReady("Crusade") and not S.RadiantGlory:IsAvailable() and ((Player:HolyPower() >= 5 and HL.CombatTime() < 5) or (Player:HolyPower() >= 3 and HL.CombatTime() > 5)) then
            return S.Crusade:Cast()
        end
        

--final_reckoning,if=(holy_power>=4&time<8|holy_power>=3&time>=8|holy_power>=2&(talent.divine_auxiliary|talent.radiant_glory))
-- &(cooldown.avenging_wrath.remains>10|cooldown.crusade.remains&(!buff.crusade.up|buff.crusade.stack>=10)|talent.radiant_glory
-- &(buff.avenging_wrath.up|talent.crusade&cooldown.wake_of_ashes.remains<gcd))&(!raid_event.adds.exists|raid_event.adds.up|raid_event.adds.in>40)
        if IsReady("Final Reckoning") and finalreckoningdrop and ((Player:HolyPower() >= 4 and HL.CombatTime() < 8 or Player:HolyPower() >= 3
         and HL.CombatTime() >= 8 or Player:HolyPower() >= 2 and (S.DivineAuxiliary:IsAvailable() or S.RadiantGlory:IsAvailable())) 
         and (S.AvengingWrath:CooldownRemains() > 10 or S.Crusade:CooldownDown() and (not AuraUtil.FindAuraByName("Crusade", "player")  or crusadestack >= 10) 
         and (not AuraUtil.FindAuraByName("Crusade", "player")  or crusadestack >= 10) or S.RadiantGlory:IsAvailable() and (avengingwrathbuff
          or S.Crusade:IsAvailable() and S.WakeofAshes:CooldownRemains() < Player:GCD()))) then
            return S.FinalReckoning:Cast()
        end    
        -- if crusadebuff or Player:BuffUp(S.AvengingWrathBuff) then
        -- local ShouldReturn = UseItems();
        -- if ShouldReturn then return ShouldReturn; end
        -- end
        
    end
      
    return nil
end

local function Finishers()
--hammer_of_light
    if IsReady(427453) and TargetinRange(10) and hol_ready then
        return S.WakeofAshes:Cast() 
    end

--divine_hammer,if=holy_power=5
    if IsReady("Divine Hammer") and TargetinRange(8) and Player:HolyPower() == 5 then
        return S.DivineHammer:Cast() 
    end


--justicars_vengeance,if=(!talent.crusade|cooldown.crusade.remains>gcd*3|buff.crusade.up&buff.crusade.stack<10|talent.radiant_glory)
-- &!buff.hammer_of_light_ready.up&(!buff.divine_hammer.up|cooldown.divine_hammer.remains>110&holy_power>=4)    
    if IsReady("Justicar's Vengeance") and TargetinRange(8) and (not S.Crusade:IsAvailable() or ((S.Crusade:CooldownRemains() > Player:GCD() * 3) 
    or not RubimRH.CDsON()) or (AuraUtil.FindAuraByName("Crusade", "player")  and crusadestack < 10) or S.RadiantGlory:IsAvailable())
     and (not AuraUtil.FindAuraByName("Divine Hammer", "player") or S.DivineHammer:CooldownRemains() > 110 and Player:HolyPower() >= 4) then 
        return S.JusticarsVengeance:Cast()
    end    
    
    if S.DivineStorm:IsReady() and DSrange and (VarDSCastable and  not hol_ready and (S.DivineHammer:CooldownDown() or Player:BuffUp(S.DivineHammer) or not S.DivineHammer:IsAvailable()) and (not S.Crusade:IsAvailable() 
    or S.Crusade:CooldownRemains() > Player:GCD() * 3 or AuraUtil.FindAuraByName("Crusade", "player") and crusadestack < 10 or S.RadiantGlory:IsAvailable())) then
        return S.DivineStorm:Cast() 
    end


--justicars_vengeance,if=(!talent.crusade|cooldown.crusade.remains>gcd*3|buff.crusade.up&buff.crusade.stack<10|talent.radiant_glory)&!buff.hammer_of_light_ready.up&(cooldown.divine_hammer.remains|buff.divine_hammer.up|!talent.divine_hammer)
if IsReady("Justicar's Vengeance") and TargetinRange(8) and ((not S.Crusade:IsAvailable() or ((S.Crusade:CooldownRemains() > Player:GCD() * 3) or not RubimRH.CDsON()) or (AuraUtil.FindAuraByName("Crusade", "player") and crusadestack < 10) 
or S.RadiantGlory:IsAvailable()) and not hol_ready and (S.DivineHammer:CooldownDown() or Player:BuffUp(S.DivineHammer) 
or not S.DivineHammer:IsAvailable() or not RubimRH.CDsON())) then
   return S.JusticarsVengeance:Cast()
end 


if (IsReady("Final Verdict") or IsReady("Templar's Verdict")) and (TargetinRange(nil, "Final Verdict") or TargetinRange(nil, "Templar's Verdict")) and (( not S.Crusade:IsAvailable() or S.Crusade:CooldownRemains() > Player:GCD() * 3
 or AuraUtil.FindAuraByName("Crusade", "player")  and crusadestack < 10 or S.RadiantGlory:IsAvailable()) and not S.HammerofLight:IsReady() and (S.DivineHammer:CooldownDown() or Player:BuffUp(S.DivineHammer) or not S.DivineHammer:IsAvailable())) then
    return S.TemplarsVerdict:Cast()
end 

return nil
end



local function Generators()
--call_action_list,name=finishers,if=holy_power=5|holy_power=4&buff.divine_resonance.up
if (Player:HolyPower() == 5 or Player:HolyPower() == 4 and Player:BuffUp(S.DivineResonanceBuff) 
or Player:BuffUp(S.TWW_S2_4pcBuff)) and S.WakeofAshes:CooldownDown() then
    if Finishers() ~= nil then
        return Finishers()
    end
end

--templar_slash,if=buff.templar_strikes.remains<gcd*2
--blade_of_justice,if=!dot.expurgation.ticking&talent.holy_flames&cooldown.divine_toll.remains
if IsReady("Blade of Justice") and TargetinRange(nil, "Blade of Justice")
 and (Target:DebuffDown(S.ExpurgationDebuff) and S.HolyFlames:IsAvailable() and S.DivineToll:CooldownDown()) then
    return S.BladeofJustice:Cast()
end
--wake_of_ashes,if=(!talent.lights_guidance|holy_power>=2&talent.lights_guidance)&(cooldown.avenging_wrath.remains>6|cooldown.crusade.remains>6|talent.radiant_glory)&(!talent.execution_sentence|cooldown.execution_sentence.remains>4|target.time_to_die<8)&(!raid_event.adds.exists|raid_event.adds.in>10|raid_event.adds.up)
if IsReady("Wake of Ashes") and RubimRH.CDsON() and TargetinRange(8) and ((not S.LightsGuidance:IsAvailable() or Player:HolyPower() >= 2 and S.LightsGuidance:IsAvailable()) and (S.AvengingWrath:CooldownRemains() > 6 or S.Crusade:CooldownRemains() > 6 or S.RadiantGlory:IsAvailable()) and (not S.ExecutionSentence:IsAvailable() or S.ExecutionSentence:CooldownRemains() > 4)) then
    return S.WakeofAshes:Cast()
end
--divine_toll,if=holy_power<=2&(!raid_event.adds.exists|raid_event.adds.in>10|raid_event.adds.up)&(cooldown.avenging_wrath.remains>15|cooldown.crusade.remains>15|talent.radiant_glory|fight_remains<8)
if IsReady("Divine Toll") and TargetinRange(8) and RubimRH.CDsON() and Player:HolyPower() <= 2 and (S.AvengingWrath:CooldownRemains() > 15 or S.Crusade:CooldownRemains() > 15 or S.RadiantGlory:IsAvailable()) then
    return S.DivineToll:Cast()
end
--call_action_list,name=finishers
if Finishers() ~= nil then
    return Finishers()
end
--templar_slash,if=buff.templar_strikes.remains<gcd&spell_targets.divine_storm>=2
if IsReady("Templar Slash") and not S.CrusadingStrikes:IsAvailable() and TargetinRange(5) and DSrange >= 2 then
    return S.CrusaderStrike:Cast()
end
--blade_of_justice,if=spell_targets.divine_storm>=2&talent.blade_of_vengeance
if IsReady("Blade of Justice") and TargetinRange(nil, "Blade of Justice") and DSrange >= 2 and S.BladeofVengeance:IsAvailable() then
    return S.BladeofJustice:Cast()
end
--hammer_of_wrath,if=(spell_targets.divine_storm<2|!talent.blessed_champion)&buff.blessing_of_anshe.up
if IsReady("Hammer of Wrath") and (DSrange < 2 or not S.BlessedChampion:IsAvailable()) and Player:BuffUp(S.BlessingofAnsheBuff) then
    return S.HammerofWrath:Cast()
end   
--templar_strike
if IsReady("Templar Strike") and TargetinRange(5) and not S.CrusadingStrikes:IsAvailable() then
    return S.CrusaderStrike:Cast()
end
--judgment
if IsReady("Judgment") and TargetinRange(30) then
    return S.Judgment:Cast()
end
--blade_of_justice
if IsReady("Blade of Justice") and TargetinRange(nil, "Blade of Justice") then
    return S.BladeofJustice:Cast()
end
--hammer_of_wrath,if=(spell_targets.divine_storm<2|!talent.blessed_champion)
if IsReady("Hammer of Wrath") and TargetinRange(30) and (DSrange < 2 or not S.BlessedChampion:IsAvailable()) then
    return S.HammerofWrath:Cast()
end   
--templar_slash
if IsReady("Templar Slash") and TargetinRange(5) and not S.CrusadingStrikes:IsAvailable() then
    return S.CrusaderStrike:Cast()
end
--crusader_strike
if IsReady("Crusader Strike") and TargetinRange(5) and not S.CrusadingStrikes:IsAvailable() then
    return S.CrusaderStrike:Cast()
end
--hmmer_of_wrath
if IsReady("Hammer of Wrath") and TargetinRange(30) then
    return S.HammerofWrath:Cast()
end


    return nil
end

local function APL()
    TrackHealthLossPerSecond()




----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--vars/top prio-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
if Player:IsCasting() or Player:IsChanneling() then
    return 0, "Interface\\Addons\\Rubim-RH\\Media\\channel.tga"
elseif AuraUtil.FindAuraByName("Drink", "player") or AuraUtil.FindAuraByName("Food", "player") or AuraUtil.FindAuraByName("Food & Drink", "player") then
    return 0, "Interface\\Addons\\Rubim-RH\\Media\\prot.tga"
end

local _, runSpeed, _, _ = GetUnitSpeed("player")
local percentSpeed = runSpeed/7*100

if percentSpeed>=200 then
fianlreckoningdrop = (TargetinRange(10) and not Player:IsMoving() or TargetinRange(8) and  Player:IsMoving())
else
 finalreckoningdrop = (TargetinRange(8) and not Player:IsMoving() or TargetinRange(5) and  Player:IsMoving())
end

if AuraUtil.FindAuraByName("Crusade", "player") then
    crusadestack = select(3, AuraUtil.FindAuraByName("Crusade", "player"))
else
    crusadestack = 0
end
if AuraUtil.FindAuraByName("Avenging Wrath", "player") then
    avengingwrathbuff = select(6, AuraUtil.FindAuraByName("Avenging Wrath", "player")) - GetTime()
else
    avengingwrathbuff = 0
end
if AuraUtil.FindAuraByName("Crusade", "player") then
    crusadebuff = select(6, AuraUtil.FindAuraByName("Crusade", "player")) - GetTime()
else
    crusadebuff = 0
end


if true then
    local _,instanceType = IsInInstance()

    if S.TotLB:IsAvailable() then
        DSrange = RangeCount(15)
    else
        DSrange = RangeCount(8)
    end
  -- variable,name=ds_castable,value=(spell_targets.divine_storm>=2|buff.empyrean_power.up|!talent.final_verdict&talent.tempest_of_the_lightbringer)
  --&!buff.empyrean_legacy.up&!(buff.divine_arbiter.up&buff.divine_arbiter.stack>24)

    VarDSCastable = (DSrange >= 2 or Player:BuffUp(S.EmpyreanPowerBuff) or not S.FinalVerdict:IsAvailable() and S.TotLB:IsAvailable())
    and Player:BuffDown(S.EmpyreanLegacyBuff) and not (Player:BuffUp(S.DivineArbiterBuff) and Player:BuffStack(S.DivineArbiterBuff) > 24)


    castchannelTime = math.random(250, 500) / 1000

    local level, affixIDs, wasEnergized = C_ChallengeMode.GetActiveKeystoneInfo()

    HPpercentloss = GetHealthLossPerSecond()

    potion_ready = (IsUsableItem(191382) and GetItemCooldown(191382) == 0 and GetItemCount(191382) >= 1) or (IsUsableItem(212265) and GetItemCooldown(212265) == 0 and GetItemCount(212265) >= 1) or (IsUsableItem(212264) and GetItemCooldown(212264) == 0 and GetItemCount(212264) >= 1) or (IsUsableItem(212263) and GetItemCooldown(212263) == 0 and GetItemCount(212263) >= 1)

    if S.Intercession:Charges() == nil then
        rezcharges = 0
    else
        rezcharges = S.Intercession:Charges()
    end

	trinket1 = GetInventoryItemID("player", 13)
	
	trinket2 = GetInventoryItemID("player", 14)

    hol_ready = C_Spell.GetSpellInfo("Wake of Ashes").iconID == 5342121

    if trinket1 then
	    trinket1ready = C_Item.IsUsableItem(trinket1) and GetItemCooldown(trinket1) == 0 and C_Item.IsEquippedItem(trinket1)
    else
        trinket1ready = false
    end
	
    if trinket2 then
	    trinket2ready = C_Item.IsUsableItem(trinket2) and GetItemCooldown(trinket2) == 0 and C_Item.IsEquippedItem(trinket2)
    else
        trinket2ready = false
    end

    local startTimeMS = select(4, UnitCastingInfo('target')) or 0
    local currentTimeMS = GetTime() * 1000
    local elapsedTimeca = (startTimeMS > 0) and (currentTimeMS - startTimeMS) or 0
    castTime = elapsedTimeca / 1000
    local startTimeMS = select(4, UnitCastingInfo('target')) or select(4, UnitChannelInfo('target')) or 0
    local currentTimeMS = GetTime() * 1000
    local elapsedTimech = (startTimeMS > 0) and (currentTimeMS - startTimeMS) or 0
    channelTime = elapsedTimech/1000

    isEnraged = (AuraUtil.FindAuraByName("Enrage", "target") or UnitChannelInfo("target") == "Ragestorm" or AuraUtil.FindAuraByName("Frenzy", "target"))
end
-- print("empleg down:",Player:BuffDown(S.EmpyreanLegacyBuff))
-- print("divinearb :",not (Player:BuffUp(S.DivineArbiterBuff) and Player:BuffStack(S.DivineArbiterBuff) > 24))


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--out of combat-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
if not Player:AffectingCombat() then
    -- if IsReady("Retribution Aura") and not Player:BuffUp(S.RetributionAura) then
    --     return S.RetributionAura:Cast()
    -- end

    if IsReady("Divine Shield") and Player:DebuffUp(S.Burst) and not Player:DebuffUp(S.Forbearance) and ((Player:HealthPercentage() <= 40 and not Player:BuffUp(S.ShieldofVengeance) and not Player:BuffUp(S.DivineProtection)) or Player:HealthPercentage() <= 20) then
        return S.DivineShield:Cast()
    end
            
    if IsReady("Lay on Hands") and Player:DebuffUp(S.Burst) and Player:HealthPercentage() <= 20 and not Player:DebuffUp(S.Forbearance) and S.DivineShield:CooldownRemains() > Player:GCD() then
        return S.LayonHands:Cast()
    end

    if IsReady("Word of Glory") and RangeCount(20) == 0 and Player:HealthPercentage()<75 and Player:HolyPower() >= 3  then
        return S.WordofGlory:Cast()
    end
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--spell queue---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
if (not IsReady(RubimRH.queuedSpell[1]:ID(),nil,nil,1) or (not Player:AffectingCombat() or RangeCount(30) == 0) and S.DivineSteed:ID() ~= RubimRH.queuedSpell[1]:ID())
or (S.FlashofLight:ID() == RubimRH.queuedSpell[1]:ID() and ((C_Spell.IsCurrentSpell(19750) or Player:IsMoving())))
or (S.BlessingofProtection:ID() == RubimRH.queuedSpell[1]:ID() and Player:DebuffUp(S.Forbearance))
or (S.HammerofJustice:ID() == RubimRH.queuedSpell[1]:ID() and (not IsReady("Hammer of Justice",nil,nil,1) or not TargetinRange(10)))
or (S.DivineShield:ID() == RubimRH.queuedSpell[1]:ID() and Player:DebuffUp(S.Forbearance))
or ((S.Intercession:ID() == RubimRH.queuedSpell[1]:ID() and (Player:PrevGCD(1, S.Intercession) or IsKeyDown('RightButton') or Player:IsMoving() or not UnitIsDeadOrGhost('mouseover')))) 
or (S.LayonHands:ID() == RubimRH.queuedSpell[1]:ID() and (Player:DebuffUpP(S.Forbearance) or Player:InArena())) then
	RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
end   



if S.lustAT:ID() == RubimRH.queuedSpell[1]:ID()
and Player:DebuffDown(S.lust1) and Player:DebuffDown(S.lust2) and Player:CanAttack(Target) and GetItemCount(219905) >= 1 and 
Player:DebuffDown(S.lust3) and Player:DebuffDown(S.lust4) and Player:DebuffDown(S.lust5) and (I.drums:IsReady()) then
return S.lustAT:Cast() -- BIND LUST KEYBIND IN BINDPAD TO ARCANE TORRENT
end

if S.lustAT:ID() == RubimRH.queuedSpell[1]:ID() and
(
Player:DebuffUp(S.lust1) or Player:DebuffUp(S.lust2) or Player:DebuffUp(S.lust3) or Player:DebuffUp(S.lust4) or
Player:DebuffUp(S.lust5)) then
RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
end

if S.Intercession:ID() == RubimRH.queuedSpell[1]:ID() and IsReady("Intercession") then
    return S.intercession:Cast() 
end


if IsReady(RubimRH.queuedSpell[1]:ID(),nil,nil,1) then
    return RubimRH.QueuedSpell():Cast()
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--pvp-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
if Player:InArena() or Player:InBattlegrounds() or Target:IsAPlayer() then
    if IsReady("Shield of Vengeance") and (Player:HealthPercentage() <= 65 or HPpercentloss > 10) then
        return S.ShieldofVengeance:Cast()
    end
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--defensives----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
if Player:AffectingCombat() then 
    if RangeCount(30) >= 1 and Player:HealthPercentage() <= 35 and (IsUsableItem(211880) == true and GetItemCooldown(211880) == 0 and GetItemCount(211880) >= 1 or IsUsableItem(211878) == true and GetItemCooldown(211878) == 0 and GetItemCount(211878) >= 1 or IsUsableItem(211879) == true and GetItemCooldown(211879) == 0 and GetItemCount(211879) >= 1) and (not Player:InArena() and not Player:InBattlegrounds()) then
        return I.HPIcon:Cast()
      end

    if IsReady("Divine Shield") and not Player:DebuffUp(S.Forbearance) and ((Player:HealthPercentage() <= 35 and not Player:BuffUp(S.ShieldofVengeance) and not Player:BuffUp(S.DivineProtection)) or Player:HealthPercentage()<=25) then
        return S.DivineShield:Cast()
    end

    if IsReady("Lay on Hands") and Player:HealthPercentage() <= 25 and not Player:DebuffUp(S.Forbearance) and S.DivineShield:CooldownRemains() > Player:GCD() then
        return S.LayonHands:Cast()
    end

    if IsReady("Divine Protection") and not Player:BuffUp(S.ShieldofVengeance) and not Player:BuffUp(S.DivineShield) and (Player:HealthPercentage() <= 50 or HPpercentloss>10 and Player:HealthPercentage()<70) and RangeCount(20) >= 1 then
      return S.DivineProtection:Cast()
    end

    if IsReady("Shield of Vengeance") and (Player:HealthPercentage() <= 50 or HPpercentloss>10 and Player:HealthPercentage()<70) and not Player:BuffUp(S.DivineProtection) and not Player:BuffUp(S.DivineShield) and RangeCount(20) >= 1 then
        return S.ShieldofVengeance:Cast()
    end

    if IsReady("Word of Glory") and RangeCount(20) == 0 and Player:HealthPercentage() < 60  then
        return S.WordofGlory:Cast()
    end

    if IsReady("Word of Glory") and (not Player:InArena() and not Player:InBattlegrounds() and not Target:IsAPlayer()) and not Player:BuffUp(S.DivineShield) and (Player:HealthPercentage() < 60 and Player:HealthPercentage() >= 35 and not Player:BuffUp(S.ShieldofVengeance) and not Player:BuffUp(S.DivineProtection) or Player:HealthPercentage() < 35) then
        return S.WordofGlory:Cast()
    end
end

-- if IsReady("Blessing of Freedom") and (freedom() or AuraUtil.FindAuraByName("Icy Bindings", "player", "HARMFUL") or AuraUtil.FindAuraByName("Frost Shock", "player", "HARMFUL") or AuraUtil.FindAuraByName("Deep Chill", "player", "HARMFUL")) then
--     return S.BlessingofFreedom:Cast()
-- end

if IsReady("Cleanse Toxins") and RubimRH.InterruptsON() and S.CleanseToxins:TimeSinceLastCast() > 2 and (GetAppropriateCureSpell('player') == "Poison" or GetAppropriateCureSpell('player') == "Disease") then
    return S.CleanseToxins:Cast()
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--interrupts----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
if RubimRH.InterruptsON() and Player:CanAttack(Target) and Player:AffectingCombat()  then
    --Kick
    if IsReady("Rebuke") 
    and (kickprio() or Target:IsAPlayer())
    and TargetinRange(8) and (castTime > castchannelTime+0.5 or channelTime > castchannelTime+0.5) 
     and select(8, UnitCastingInfo("target")) == false  and not isEnraged then
    return S.Rebuke:Cast()
    end
    
    -- --Stun
    if IsReady("Hammer of Justice") and (stunprio() or Target:IsAPlayer())
    and TargetinRange(10) and (castTime>castchannelTime+0.5 or channelTime>castchannelTime+0.5) and not isEnraged then
    return S.HammerofJustice:Cast()
    end
    
    -- --blind
    if IsReady("Blinding Light") and (blindprio() or Target:IsAPlayer())
    and TargetinRange(8) and (castTime>castchannelTime+0.5 or channelTime>castchannelTime+0.5) and not isEnraged then
    return S.BlindingLight:Cast()
    end
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--rotation------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
if UnitCanAttack('player','target') and not Target:IsDeadOrGhost() and (Target:AffectingCombat() or C_Spell.IsCurrentSpell(6603)) then
    if not C_Spell.IsCurrentSpell(6603) and TargetinRange(8) then
        return S.autoattack:Cast()
    end

    -- if Princess() ~= nil then
    --     return Princess()
    -- end

    if RubimRH.CDsON() then
    --and aoecds8y 
        if Cooldowns() ~= nil then
            return Cooldowns()
        end
    end

    if Generators() ~= nil then
        return Generators()
    end
end
    return "Interface\\Addons\\Rubim-RH\\Media\\prot.tga", false
end

RubimRH.Rotation.SetAPL(70, APL);

local function PASSIVE()

end

RubimRH.Rotation.SetPASSIVE(70, PASSIVE);
