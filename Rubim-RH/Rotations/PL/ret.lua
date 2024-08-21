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
VanguardofJustice = Spell(406545),
-- Racials
Repentance = Spell(20066),
TurnEvil = Spell(10326),
--  AncestralCall                         = Spell(274738),
CleanseToxins = Spell(213644),
ArcanePulse                           = Spell(260364),
ArcaneTorrent                         = Spell(50613),
BagofTricks                           = Spell(312411),
Berserking                            = Spell(26297),
BloodFury                             = Spell(20572),
Fireblood                             = Spell(265221),
GiftoftheNaaru                        = Spell(59542),
-- Abilities
BlessingofSacrifice = Spell(6940),
WordofGloryFocus = Spell(5502), --sense undead
CleanseToxinsFocus = Spell(20594), --stone form
LayonHandsFocus = Spell(172321),--seraphim
BlessingofProtectionFocus = Spell(28880),-- gift of naaru
Consecration                          = Spell(26573),
CrusaderStrike                         = Spell(35395),
-- crusaderstrike = Spell(205191), -- eye for an eye
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


BlessingofDuskBuff                    = Spell(385126),
ConsecrationBuff                      = Spell(188370),
DivinePurposeBuff                     = Spell(223819),
HolyAvengerBuff                       = Spell(105809),
SeraphimBuff                          = Spell(152262),
ShieldoftheRighteousBuff              = Spell(132403),
DivineProtection = Spell(403876),
-- Debuffs

ConsecratedBlade = Spell(404834),
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
Burst = Spell(243237),
RighteousVerdict                      = Spell(267610),
ShieldofVengeance                     = Spell(184662),
TemplarSlash                          = Spell(406647),
TemplarStrike                         = Spell(407480),
VanguardsMomentum                     = Spell(383314),
WakeofAshes                           = Spell(255937),
Zeal                                  = Spell(269569),
-- Buffs
DivineArbiter = Spell(404306),
CrusadeBuff                           = Spell(231895),
DivineArbiterBuff                     = Spell(406975),
DivineResonanceBuff                   = Spell(384029),

EmpyreanPowerBuff                     = Spell(326733),
divineprotection = Spell(210256), -- blessing of sanctuary
BlessingofFreedom = Spell(1044),
BlessingofFreedomfocus = Spell(145067),-- turn evil

BlindingLight = Spell(115750),
SenseUndead = Spell(5502),
EmpyreanLegacyBuff = Spell(387178),
Entangling = Spell(408556),

deepchill = Spell(391634),
lust1                    = Spell(57724),
lust2                    = Spell(57723),
lust3                    = Spell(80354),
lust4                    = Spell(95809),
lust5                    = Spell(264689),
lustAT                   = Spell(255647), -- war stomp
IcyBindings = Spell(377488),

FrostShock = Spell(385963),
DivineSteedBuff          = Spell(221886),
BlessingofProtection     = Spell(1022),
Forbearance              = Spell(25771),
-- Racials
RadiantGlory = Spell(458359),
CrusadingStrikes = Spell(404542),
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
mhweapcast = Spell(383185), --exorcism

}

local S = RubimRH.Spell[70]
local G = RubimRH.Spell[1] -- General Skills

S.AvengingWrath.TextureSpellID = { 31884 }
S.Crusade.TextureSpellID = { 55748 }
S.CrusaderStrike.TextureSpellID = { 342348 }

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
legendary = Item(206448), --Fyrakk leggo
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



-- local frame = CreateFrame("Frame")
-- frame:RegisterEvent("PLAYER_TALENT_UPDATE")
-- frame:SetScript("OnEvent", UpdateTemplarsVerdictSpellId)







Ranged = function()

if Player:AffectingCombat() and Target:AffectingCombat() then
if IsReady("Hammer of Wrath") and targetRange30 and (awup or crusadeup or Target:HealthPercentage()<=20) then
return S.HammerofWrath:Cast()
end



if IsReady("Judgment") and targetRange30 then
return S.Judgment:Cast()
end

if IsReady("Divine Toll") and targetRange30 and RubimRH.CDsON() then
return S.DivineToll:Cast()
end


end

end


Cooldowns = function()



-- execution_sentence,if=(!buff.crusade.up&cooldown.crusade.remains>15|buff.crusade.stack=10|cooldown.avenging_wrath.remains<0.75
--|cooldown.avenging_wrath.remains>15)&(holy_power>=4&time<5|holy_power>=3&time>5|holy_power>=2&talent.divine_auxiliary)&(target.time_to_die>8&!talent.executioners_will|target.time_to_die>12)
if IsReady("Execution Sentence") and targetRange20 and ((not crusadeup and S.Crusade:CooldownRemains() > 10 
or crusadestacks == 10 or S.AvengingWrath:CooldownRemains() > 10 or S.RadiantGlory:IsAvailable()) 
and (HolyPower >= 3 or HolyPower >= 2 and S.DivineAuxiliary:IsAvailable()) and (aoeTTD() > 8 or Target:TimeToDie()>8)) then
return S.ExecutionSentence:Cast()
end

-- avenging_wrath,if=(holy_power>=4&time<5|holy_power>=3&(time>5|!talent.vanguard_of_justice)|holy_power>=2&talent.divine_auxiliary
--&(cooldown.execution_sentence.remains=0|cooldown.final_reckoning.remains=0))&(!raid_event.adds.up|target.time_to_die>10)
if IsReady("Avenging Wrath") and not S.RadiantGlory:IsAvailable() and targetRange10 and ((HolyPower >= 4 and HL.CombatTime() < 5 or HolyPower >= 3 
and (HL.CombatTime() > 5 or not S.VanguardofJustice:IsAvailable()) or HolyPower >= 2 and S.DivineAuxiliary:IsAvailable() 
and (S.ExecutionSentence:CooldownUp() or S.FinalReckoning:CooldownUp())) or DSrange>=3) then
return S.AvengingWrath:Cast()
end

--crusade,if=holy_power>=5&time<5|holy_power>=3&time>5
if IsReady("Crusade") and not S.RadiantGlory:IsAvailable() and targetRange10 and (HolyPower >= 5 and HL.CombatTime() < 5 or HolyPower >= 3 and HL.CombatTime() > 5) then
return S.Crusade:Cast()
end

-- final_reckoning,if=(holy_power>=4&time<8|holy_power>=3&(time>=8|!talent.vanguard_of_justice)|holy_power>=2&talent.divine_auxiliary)
--&(cooldown.avenging_wrath.remains>10|cooldown.crusade.remains&(!buff.crusade.up|buff.crusade.stack>=10))&(!raid_event.adds.exists|raid_event.adds.up|raid_event.adds.in>40)

if IsReady("Final Reckoning")  
and targetRange5 
and (aoecds8y or target_is_dummy())
and (HolyPower >= 4 and HL.CombatTime() < 8 
or S.RadiantGlory:IsAvailable()
or HolyPower >= 3 and (HL.CombatTime() >= 8 or not S.VanguardofJustice:IsAvailable()) or HolyPower >= 2 and S.DivineAuxiliary:IsAvailable()) 
and (S.AvengingWrath:CooldownRemains() > 10 or S.Crusade:CooldownRemains() > 10 and (not crusadeup or  crusadestacks >= 10)) then
return S.FinalReckoning:Cast()
end

if I.legendary:CooldownRemains()<1 and C_Item.IsEquippedItem(206448)
and RubimRH.CDsON()
and targetRange5 
and (aoecds8y or target_is_dummy())
and (AuraUtil.FindAuraByName("Avenging Wrath","player") or AuraUtil.FindAuraByName("Crusade","player") or  (S.AvengingWrath:CooldownRemains()>45  or S.Crusade:CooldownRemains()>45 and S.Crusade:IsAvailable()) )
and not Target:IsMoving()
then
return S.mhweapcast:Cast()
end


end




Finishers = function()


-- divine_storm,if=variable.ds_castable&(!talent.crusade|cooldown.crusade.remains>gcd*3&rubimrhcdson|!rubimrhcdson|buff.crusade.up&buff.crusade.stack<10)
if IsReady("Divine Storm") 
and VarDSCastable and (not S.Crusade:IsAvailable() or S.Crusade:CooldownRemains() > Player:GCD() * 3 and RubimRH.CDsON() 
or not RubimRH.CDsON() or crusadeup and crusadestacks < 10 or S.RadiantGlory:IsAvailable()) 
then
return S.DivineStorm:Cast() 
end

-- justicars_vengeance,if=(!talent.crusade|cooldown.crusade.remains>gcd*3&rubimrhcdson|!rubimrhcdson|buff.crusade.up&buff.crusade.stack<10)
if IsReady("Justicar's Vengeance")  and targetRange20 and (not S.Crusade:IsAvailable() or S.Crusade:CooldownRemains() > Player:GCD() * 3 and RubimRH.CDsON() 
or not RubimRH.CDsON() or crusadeup and crusadestacks < 10 or S.RadiantGlory:IsAvailable()) then 
return S.JusticarsVengeance:Cast()
end

--templars_verdict,if=(!talent.crusade|cooldown.crusade.remains>gcd*3&rubimrhcdson|!rubimrhcdson|buff.crusade.up&buff.crusade.stack<10)
if (IsReady("Final Verdict") or IsReady("Templar's Verdict")) and targetRange20 and (not S.Crusade:IsAvailable() or S.Crusade:CooldownRemains() > Player:GCD() * 3 and RubimRH.CDsON() 
or not RubimRH.CDsON() or crusadeup and crusadestacks < 10 or S.RadiantGlory:IsAvailable()) then
return S.TemplarsVerdict:Cast()
end


end


Generators = function()

if RubimRH.AoEON() and inRange20>=6 then


if IsReady("Avenging Wrath") and not S.RadiantGlory:IsAvailable() and not awup and RubimRH.CDsON() and targetRange8 then   
return S.AvengingWrath:Cast()
end

if IsReady("Crusade") and not S.RadiantGlory:IsAvailable() and not crusadeup and RubimRH.CDsON() and targetRange8 then                        
return S.Crusade:Cast()
end

if IsReady("Final Reckoning") 
and RubimRH.CDsON() 
and targetRange8
and (aoecds8y or target_is_dummy())
and inRange5>=1 then                        
return S.FinalReckoning:Cast()
end

if IsReady("Divine Storm") and HolyPower>=5 and targetRange10 then                        
return S.DivineStorm:Cast()
end



if IsReady("Wake of Ashes")
and RubimRH.CDsON() 
and (HolyPower<=2 or S.RadiantGlory:IsAvailable() and (not crusadeup and not awup))
and (aoecds8y or target_is_dummy())
and targetRange8  
and inRange8 >=1
and (not S.FinalReckoning:IsAvailable() or S.FinalReckoning:CooldownRemains() > 5 )
then
return S.WakeofAshes:Cast()
end


if IsReady("Divine Toll") and  (aoecds8y or target_is_dummy()) and HolyPower<=2 and RubimRH.CDsON() and targetRange20 and inRange20>=1 
and (not S.FinalReckoning:IsAvailable() or S.FinalReckoning:CooldownRemains() > 5 ) 
and (not S.WakeofAshes:IsAvailable() or S.WakeofAshes:CooldownRemains() > 5 ) 
then
return S.DivineToll:Cast()
end



end


-- call_action_list,name=finishers,if=holy_power=5|buff.echoes_of_wrath.up&set_bonus.tier31_4pc&talent.crusading_strikes|(debuff.judgment.up|holy_power=4)&buff.divine_resonance.up&!set_bonus.tier31_2pc          
if (HolyPower ==5 or AuraUtil.FindAuraByName("Echoes of Wrath", "player") 
and tierequipped()>=4 and S.CrusadingStrikes:IsAvailable()
or (AuraUtil.FindAuraByName("Judgment","target","PLAYER|HARMFUL") 
or HolyPower==4) and  AuraUtil.FindAuraByName("Divine Resonance", "player")
and tierequipped()<2) then
if Finishers() ~= nil then
return Finishers()
end
end

--wake_of_ashes,if=holy_power<=2&(cooldown.avenging_wrath.remains>6|cooldown.crusade.remains>6)
--&(!talent.execution_sentence|cooldown.execution_sentence.remains>4|target.time_to_die<8)&(!raid_event.adds.exists|raid_event.adds.in>20|raid_event.adds.up)
if IsReady("Wake of Ashes") and (aoecds8y or target_is_dummy()) and RubimRH.CDsON() and targetRange8 and HolyPower<=2 
and (HolyPower<=2 and ( S.AvengingWrath:CooldownRemains()>6 or S.Crusade:CooldownRemains()>6 ) and (not S.ExecutionSentence:IsAvailable() or S.ExecutionSentence:CooldownRemains() > 4 or (aoeTTD() < 8 or Target:TimeToDie()<8))
or S.RadiantGlory:IsAvailable() and (not crusadeup and not awup) and HolyPower<=3)
then
return S.WakeofAshes:Cast()
end



-- blade_of_justice,if=!dot.expurgation.ticking&set_bonus.tier31_2pc
if IsReady("Blade of Justice") and targetRange20 and not AuraUtil.FindAuraByName("Expurgation","target","PLAYER|HARMFUL") and tierequipped()>=2 then
return S.BladeofJustice:Cast()
end

-- divine_toll,if=holy_power<=2&(!raid_event.adds.exists|raid_event.adds.in>30|raid_event.adds.up)&(cooldown.avenging_wrath.remains>15|cooldown.crusade.remains>15|fight_remains<8)
if IsReady("Divine Toll") and (aoecds8y or target_is_dummy()) and targetRange30 and HolyPower<=2 and RubimRH.CDsON() and (S.AvengingWrath:CooldownRemains() > 15 or S.Crusade:CooldownRemains() > 15 or S.RadiantGlory:IsAvailable()) then
return S.DivineToll:Cast()
end


-- judgment,if=dot.expurgation.ticking&!buff.echoes_of_wrath.up&set_bonus.tier31_2pc
if IsReady("Judgment") and targetRange30 and AuraUtil.FindAuraByName("Expurgation","target","PLAYER|HARMFUL") and not AuraUtil.FindAuraByName("Echoes of Wrath", "player") and tierequipped()>=2 then
return S.Judgment:Cast()
end


-- call_action_list,name=finishers,if=holy_power>=3&buff.crusade.up&buff.crusade.stack<10
if (HolyPower >= 3 and crusadeup and crusadestacks < 10) then
if Finishers() ~= nil then
return Finishers()
end
end


-- templar_slash,if=buff.templar_strikes.remains<gcd&spell_targets.divine_storm>=2
if IsReady("Templar Slash") and targetRange10 and (S.TemplarStrike:TimeSinceLastCast() + Player:GCD() < 4 and inRange10 >= 2) and not S.CrusadingStrikes:IsAvailable() then
return S.CrusaderStrike:Cast()
end


-- blade_of_justice,if=(holy_power<=3|!talent.holy_blade)&(spell_targets.divine_storm>=2&!talent.crusading_strikes|spell_targets.divine_storm>=4)
if IsReady("Blade of Justice") and targetRange20 and (HolyPower <= 3 or not S.HolyBlade:IsAvailable()) and (DSrange>=2 and not S.CrusadingStrikes:IsAvailable() or DSrange>=4) then
return S.BladeofJustice:Cast()
end

-- hammer_of_wrath,if=(spell_targets.divine_storm<2|!talent.blessed_champion|set_bonus.tier30_4pc)&(holy_power<=3|target.health.pct>20|!talent.vanguards_momentum)
if IsReady("Hammer of Wrath") and targetRange30 and (DSrange<2 or not S.BlessedChampion:IsAvailable() or tierequipped30()>=4) and (HolyPower <= 3 or Target:HealthPercentage() > 20 or not S.VanguardsMomentum:IsAvailable()) then
return S.HammerofWrath:Cast()
end

-- templar_slash,if=buff.templar_strikes.remains<gcd&spell_targets.divine_storm>=2
if IsReady("Templar Slash") and targetRange10 and (S.TemplarStrike:TimeSinceLastCast() + Player:GCD() < 4) and not S.CrusadingStrikes:IsAvailable() then
return S.CrusaderStrike:Cast()
end

-- judgment,if=!debuff.judgment.up&(holy_power<=3|!talent.boundless_judgment)
if IsReady("Judgment") and targetRange30 and (Target:DebuffDown(S.JudgmentDebuff) and (HolyPower <= 3 or not S.BoundlessJudgment:IsAvailable())) then
return S.Judgment:Cast()
end

-- blade_of_justice,if=holy_power<=3|!talent.holy_blade
if IsReady("Blade of Justice") and targetRange20 and (HolyPower <= 3 or not S.HolyBlade:IsAvailable()) then
return S.BladeofJustice:Cast()
end

-- call_action_list,name=finishers,if=(target.health.pct<=20|buff.avenging_wrath.up|buff.crusade.up|buff.empyrean_power.up)
if (Target:HealthPercentage() <= 20 or awup or crusadeup or Player:BuffUp(S.EmpyreanPowerBuff)) then
local ShouldReturn = Finishers(); if ShouldReturn then return ShouldReturn; end
end

-- consecration,if=!consecration.up&spell_targets.divine_storm>=2
if IsReady("Consecration") and targetRange8 and (Target:DebuffDown(S.ConsecrationDebuff) and inRange10 >= 2) and not S.ConsecratedBlade:IsAvailable() then
return S.Consecration:Cast()
end

-- divine_hammer,if=spell_targets.divine_storm>=2
if IsReady("Divine Hammer") and targetRange8 and (inRange10 >= 2) then
return S.DivineHammer:Cast()
end
-- crusader_strike,if=cooldown.crusader_strike.charges_fractional>=1.75&(holy_power<=2|holy_power<=3&cooldown.blade_of_justice.remains>gcd*2|holy_power=4&cooldown.blade_of_justice.remains>gcd*2&cooldown.judgment.remains>gcd*2)
if IsReady("Crusader Strike") and not S.CrusadingStrikes:IsAvailable() and targetRange8 and (S.CrusaderStrike:ChargesFractional() >= 1.75 
and (HolyPower <= 2 or HolyPower <= 3 and S.BladeofJustice:CooldownRemains() > Player:GCD() * 2 
or HolyPower == 4 and S.BladeofJustice:CooldownRemains() > Player:GCD() * 2 and S.Judgment:CooldownRemains() > Player:GCD() * 2)) then
return S.CrusaderStrike:Cast()
end

-- call_action_list,name=finishers
local ShouldReturn = Finishers(); if ShouldReturn then return ShouldReturn; end
-- templar_slash
if IsReady("Templar Slash") and targetRange10 and not S.CrusadingStrikes:IsAvailable() then
return S.CrusaderStrike:Cast()
end 
-- judgment,if=holy_power<=3|!talent.boundless_judgment
if IsReady("Judgment") and targetRange30 and (HolyPower <= 3 or not S.BoundlessJudgment:IsAvailable()) then
return S.Judgment:Cast()
end
-- hammer_of_wrath,if=holy_power<=3|target.health.pct>20|!talent.vanguards_momentum
if IsReady("Hammer of Wrath") and targetRange30 and (HolyPower <= 3 or Target:HealthPercentage() > 20 or not S.VanguardsMomentum:IsAvailable()) then
return S.HammerofWrath:Cast()
end
-- crusader_strike
if IsReady("Crusader Strike") and targetRange10 and not S.CrusadingStrikes:IsAvailable() then
return S.CrusaderStrike:Cast()
end

-- arcane_torrent
--   if S.ArcaneTorrent:IsCastable() then
--     return S.DivineHammer:Cast()
--   end

-- consecration
if IsReady("Consecration") and targetRange10 and not S.ConsecratedBlade:IsAvailable() then
return S.Consecration:Cast()
end

-- divine_hammer
if IsReady("Divine Hammer") and targetRange10 then
return S.DivineHammer:Cast()
end


end -- end generators function
    if not loscheck then
        loscheck = CreateFrame("Frame")
    end
    
    local losCheckTimer = 0
    
    local frame = loscheck
    frame:RegisterEvent("UI_ERROR_MESSAGE")
    frame:SetScript("OnEvent", function(self,event,errorType,message)
        if message == 'Target not in line of sight' then
            losCheckTimer = GetTime()
        end	
    end)

local function APL()
local _,instanceType = IsInInstance()

inRange5 = RangeCount(5)
inRange8 = RangeCount(8)
inRange10 = RangeCount(10)
inRange15 = RangeCount(15)
inRange20 = RangeCount(20)
inRange25 = RangeCount(25)
inRange30 = RangeCount(30)
targetRange5 = C_Item.IsItemInRange(8149, "target")
targetRange8 = C_Item.IsItemInRange(34368, "target")
targetRange10 = C_Item.IsItemInRange(32321, "target")
targetRange15 = C_Item.IsItemInRange(33069, "target")
targetRange20 = C_Item.IsItemInRange(10645, "target")
targetRange25 = C_Item.IsItemInRange(24268, "target")
targetRange30 = C_Item.IsItemInRange(835, "target")


local awup = AuraUtil.FindAuraByName("Avenging Wrath","player")

local crusadeup = AuraUtil.FindAuraByName("Crusade","player")

if AuraUtil.FindAuraByName('Crusade','player') then
_, _, crusadestacks = AuraUtil.FindAuraByName('Crusade','player')
else
crusadestacks = 0
end


if AuraUtil.FindAuraByName("Divine Arbiter","player") then
DAstack = select(3,AuraUtil.FindAuraByName("Divine Arbiter","player"))
else
DAstack = 0
end

if true then
-- variable,name=ds_castable,value=(spell_targets.divine_storm>=3|spell_targets.divine_storm>=2&!talent.divine_arbiter|buff.empyrean_power.up)&!buff.empyrean_legacy.up&!(buff.divine_arbiter.up&buff.divine_arbiter.stack>24)
if S.TotLB:IsAvailable() then
DSrange = inRange15
else
DSrange = inRange8
end
VarDSCastable = ((DSrange >= 3 or DSrange >= 2 and not S.DivineArbiter:IsAvailable() or Player:BuffUp(S.EmpyreanPowerBuff)) and Player:BuffDown(S.EmpyreanLegacyBuff) and (Player:BuffDown(S.DivineArbiterBuff) or Player:BuffStack(S.DivineArbiterBuff) <= 24)) 

end
HolyPower = Player:HolyPower()
local level, affixIDs, wasEnergized = C_ChallengeMode.GetActiveKeystoneInfo()


TimeToHPG = ComputeTimeToHPG()

if Player:IsChanneling() or Player:IsCasting() then
return 0, "Interface\\Addons\\Rubim-RH\\Media\\channel.tga"
end


HPpercentloss = MyHealthTracker.GetPredictedHealthLoss() * 3

validmobsinrange8y = combatmobs40() * .6
validmobsinrange30y = combatmobs40() * .6


if (inRange8 > validmobsinrange8y or instanceType=='raid') and combatmobs40() > 0 then
aoecds8y = true
else
aoecds8y = false
end



if (inRange30 > validmobsinrange30y or instanceType=='raid') and combatmobs40() > 0 then
aoecds30y = true
else
aoecds30y = false
end
if Target:Exists() and getCurrentDPS() and getCurrentDPS()>0 then
targetTTD = UnitHealth('target')/getCurrentDPS()
else targetTTD = 8888
end

local targetdying = (aoeTTD() < 5 or targetTTD<5)



if S.Intercession:Charges()== nil then
rezcharges = 0
else
rezcharges=S.Intercession:Charges()
end

local castchannelTime = math.random(250, 500) / 1000
local startTimeMS = select(4, UnitCastingInfo('target')) or 0
local currentTimeMS = GetTime() * 1000
local elapsedTimeca = (startTimeMS > 0) and (currentTimeMS - startTimeMS) or 0
local castTime = elapsedTimeca / 1000
local startTimeMS = select(4, UnitCastingInfo('target')) or select(4, UnitChannelInfo('target')) or 0
local currentTimeMS = GetTime() * 1000
local elapsedTimech = (startTimeMS > 0) and (currentTimeMS - startTimeMS) or 0
local channelTime = elapsedTimech/1000



isEnraged = (AuraUtil.FindAuraByName("Enrage", "target") or UnitChannelInfo("target") == "Ragestorm" or AuraUtil.FindAuraByName("Frenzy", "target"))



--health pot -- will need to update item ID of HPs as expansions progress
if inRange30 >= 1 and Player:HealthPercentage() <= 30 and Player:AffectingCombat() and (IsUsableItem(191380) == true and
GetItemCooldown(191380) == 0 and GetItemCount(191380) >= 1 or IsUsableItem(207023) == true and
GetItemCooldown(207023) == 0 and GetItemCount(207023) >= 1)
and (not Player:InArena() and not Player:InBattlegrounds()) then
return I.HPIcon:Cast()
end


if IsReady("Shield of Vengeance") and (Player:HealthPercentage() <= 65 or HPpercentloss>10) and
(Player:InArena() or Player:InBattlegrounds() or Target:IsAPlayer()) then
return S.ShieldofVengeance:Cast()
end

if S.HammerofJustice:ID() == RubimRH.queuedSpell[1]:ID() and (not Target:Exists() or not Player:CanAttack(Target)) then
RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
end

if S.Intercession:ID() == RubimRH.queuedSpell[1]:ID() and IsReady("Intercession") then
return S.intercession:Cast() -- BIND LUST KEYBIND IN BINDPAD TO ARCANE TORRENT
end

if S.lustAT:ID() == RubimRH.queuedSpell[1]:ID() and Player:DebuffDown(S.lust1) and Player:DebuffDown(S.lust2) and
Player:DebuffDown(S.lust3) and Player:DebuffDown(S.lust4) and Player:DebuffDown(S.lust5) and (I.drums:IsReady()) and Player:CanAttack(Target) then
return S.lustAT:Cast() -- BIND LUST KEYBIND IN BINDPAD TO ARCANE TORRENT
end

if S.lustAT:ID() == RubimRH.queuedSpell[1]:ID() and
(
Player:DebuffUp(S.lust1) or Player:DebuffUp(S.lust2) or Player:DebuffUp(S.lust3) or Player:DebuffUp(S.lust4) or
Player:DebuffUp(S.lust5)) then
RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
end

if S.FlashofLight:ID() == RubimRH.queuedSpell[1]:ID() and Player:BuffStack(S.SelfLessHealerBuff) < 4 then
RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
end


if S.DivineShield:ID() == RubimRH.queuedSpell[1]:ID() and Player:DebuffUp(S.Forbearance) then
RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
end
if S.BlessingofProtection:ID() == RubimRH.queuedSpell[1]:ID() and Player:DebuffUp(S.Forbearance) then
RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
end
if S.LayonHands:ID() == RubimRH.queuedSpell[1]:ID() and Player:DebuffUp(S.Forbearance) or
S.LayonHands:ID() == RubimRH.queuedSpell[1]:ID() and Player:InArena() then
RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
end


if IsReady(RubimRH.queuedSpell[1]:ID(),nil,nil,1) then
return RubimRH.QueuedSpell():Cast()
end


if (not IsReady(RubimRH.queuedSpell[1]:ID(),nil,nil,1) or not Player:AffectingCombat() or inRange30 == 0) then
RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
end

if Player:AffectingCombat() then 
if IsReady("Divine Shield") and Player:HealthPercentage() <= 50 and Player:DebuffDown(S.Forbearance) and
Player:BuffDown(S.ShieldofVengeance) and (Player:InArena() or Player:InBattlegrounds() or Target:IsAPlayer()) then
return S.DivineShield:Cast()
end

if IsReady("Divine Shield") and Player:DebuffDown(S.Forbearance) and ((Player:HealthPercentage() <= 40 and
Player:BuffDown(S.ShieldofVengeance) and Player:BuffDown(S.DivineProtection)) or Player:HealthPercentage()<=25) then
return S.DivineShield:Cast()
end

if IsReady("Lay on Hands") and Player:HealthPercentage() <= 25 and Player:DebuffDown(S.Forbearance) 
and S.DivineShield:CooldownRemains() > Player:GCD() then
return S.LayonHands:Cast()
end

if IsReady("Divine Protection") and Player:AffectingCombat() 
and Player:BuffDown(S.ShieldofVengeance) and (Player:HealthPercentage() <= 65 or HPpercentloss>10) and inRange20 >= 1 then
return S.divineprotection:Cast()
end

if IsReady("Shield of Vengeance") and (Player:HealthPercentage() <= 65 or HPpercentloss>10) and Player:AffectingCombat() 
and Player:BuffDown(S.DivineProtection) and Player:BuffDown(S.DivineShield) and inRange20 >= 1 then
return S.ShieldofVengeance:Cast()
end

if IsReady("Word of Glory") 
and inRange20==0
and Player:HealthPercentage()<70 and HolyPower>=3 then
return S.WordofGlory:Cast()
end

if IsReady("Word of Glory") 
and HolyPower>=3 
and (not Player:InArena() and not Player:InBattlegrounds() and not Target:IsAPlayer())
and Player:BuffDown(S.DivineShield) 
and (Player:HealthPercentage()<55 
and Player:HealthPercentage()>=35 
and Player:BuffDown(S.ShieldofVengeance) 
and Player:BuffDown(S.DivineProtection) or Player:HealthPercentage()<35) then
return S.WordofGlory:Cast()
end





-- print(IsReady("Intercession",nil,nil,1,1) , UnitIsDeadOrGhost("focus") , (rezcharges>=1 or level ==0) , los == false , UnitExists('focus') , C_Spell.IsSpellInRange("Flash of Light", "focus"))
if IsReady("Intercession",nil,nil,1,1) and UnitIsDeadOrGhost("focus") and (rezcharges>=1 or level ==0) then
if IsReady("Intercession") then
return S.intercession:Cast()
elseif Player:HolyPower() < 3 then
if IsReady("Judgment",1) then
return S.Judgment:Cast()
end

if IsReady("Hammer of Wrath",1) then
return S.HammerofWrath:Cast()
end

if IsReady("Blade of Justice") then
return S.BladeofJustice:Cast()
end
end
end

end

------princess function for focus------------------------------------------------------------------------------------------------------------------------------------------------
------princess function for focus------------------------------------------------------------------------------------------------------------------------------------------------
------princess function for focus------------------------------------------------------------------------------------------------------------------------------------------------

if los == false and UnitExists('focus') and C_Spell.IsSpellInRange("Flash of Light", "focus") then 
if IsReady("Intercession") and Player:HolyPower()>=3 and UnitIsDeadOrGhost("focus") and (rezcharges>=1 or level ==0) then
return S.intercession:Cast()
end

if IsReady("Lay on Hands") and GetFocusTargetHealthPercentage()<30 and not AuraUtil.FindAuraByName("Forbearance", "focus", "HARMFUL") then
return S.LayonHandsFocus:Cast()
end
if IsReady("Blessing of Protection") and inRange30>2 and GetFocusTargetHealthPercentage()<40 and not AuraUtil.FindAuraByName("Forbearance", "focus", "HARMFUL") then
return S.BlessingofProtectionFocus:Cast()
end
if IsReady("Blessing of Sacrifice") and (GetFocusTargetHealthPercentage()<60 or mitigate()) then
return S.BlessingofSacrifice:Cast()
end
if IsReady("Word of Glory") and GetFocusTargetHealthPercentage()<45 and (WordofGlorycast or Player:HolyPower()>=3) then
return S.WordofGloryFocus:Cast()
end
if IsReady("Cleanse Toxins") and (GetAppropriateCureSpell("focus")=='Poison' or GetAppropriateCureSpell("focus")=='Disease') and Player:HealthPercentage()>80 then
return S.CleanseToxinsFocus:Cast()
end

end


------princess function for focus------------------------------------------------------------------------------------------------------------------------------------------------
------princess function for focus------------------------------------------------------------------------------------------------------------------------------------------------
------princess function for focus------------------------------------------------------------------------------------------------------------------------------------------------

-- print(targetRange30)
if Target:AffectingCombat() or Player:AffectingCombat() and Player:CanAttack(Target)  and not Target:IsDeadOrGhost() then 


if not C_Spell.IsCurrentSpell(6603) and targetRange20 then
return S.autoattack:Cast()
end

if IsReady("Cleanse Toxins") and S.CleanseToxins:TimeSinceLastCast()>2 and (GetAppropriateCureSpell("player") == "Poison" or GetAppropriateCureSpell("player") == "Disease") then
return S.CleanseToxins:Cast()
end

if IsReady("Hammer of Wrath") and UnitName('target') == 'Explosives' then
return S.HammerofWrath:Cast()
end

if IsReady("Judgment") and UnitName('target') == 'Explosives' then
return S.Judgment:Cast()
end

if RubimRH.InterruptsON() and Player:CanAttack(Target) and Player:AffectingCombat()  then
--Kick
if IsReady("Rebuke") 
and kickprio() 
and targetRange8 and (castTime > castchannelTime+0.5 or channelTime > castchannelTime+0.5)  and select(8, UnitCastingInfo("target")) == false  and not isEnraged then
return S.Rebuke:Cast()
end

-- --Stun
if IsReady("Hammer of Justice") and stunprio() 
and targetRange10 and (castTime>castchannelTime+0.5 or channelTime>castchannelTime+0.5) and not isEnraged then
return S.HammerofJustice:Cast()
end

-- --blind
if IsReady("Blinding Light") and blindprio()
and targetRange8 and (castTime>castchannelTime+0.5 or channelTime>castchannelTime+0.5) and not isEnraged then
return S.BlindingLight:Cast()
end
local incorporeal = UnitName('target') == 'Incorporeal Being' and not AuraUtil.FindAuraByName("Imprison","target","HARMFUL") and not AuraUtil.FindAuraByName("Freezing Trap","target","HARMFUL")  

if IsReady("Turn Evil") and incorporeal and targetRange10 and not Player:IsMoving() then
return S.TurnEvil:Cast()
end

if IsReady("Repentance") and incorporeal and targetRange30 and not Player:IsMoving() then
return S.Repentance:Cast()
end

if IsReady("Hammer of Justice") and incorporeal and targetRange10 then
return S.HammerofJustice:Cast()
end





end

if IsReady("Cleanse Toxins") and (GetAppropriateCureSpell("player")=='Poison' or GetAppropriateCureSpell("player")=='Disease') then
return S.CleanseToxins:Cast()
end
if los == false and UnitExists('focus') and C_Spell.IsSpellInRange("Flash of Light", "focus")  then
-- --Freedom
if IsReady("Blessing of Freedom") and (freedom() or Player:DebuffUp(S.Entangled) or AuraUtil.FindAuraByName("Time Sink", "focus", "HARMFUL") or AuraUtil.FindAuraByName("Containment Beam", "focus", "HARMFUL"))  then
return S.BlessingofFreedomfocus:Cast()
end
end

if IsReady("Blessing of Freedom") and (freedom() or AuraUtil.FindAuraByName("Icy Bindings", "player", "HARMFUL") or AuraUtil.FindAuraByName("Frost Shock", "player", "HARMFUL") or AuraUtil.FindAuraByName("Deep Chill", "player", "HARMFUL"))  then
return S.BlessingofFreedom:Cast()
end

if RubimRH.CDsON() and targetRange20
and (AuraUtil.FindAuraByName("Avenging Wrath", "player") or AuraUtil.FindAuraByName("Crusade", "player") or (S.AvengingWrath:CooldownRemains()>20 or S.Crusade:CooldownRemains()>20) and not S.RadiantGlory:IsAvailable())
and not Target:IsDeadOrGhost() and Player:CanAttack(Target) and Player:AffectingCombat() and (not targetdying or target_is_dummy()) then
local ShouldReturn = UseItems();
if ShouldReturn then return ShouldReturn; end
end

if not targetRange20 then
if Ranged() ~= nil then
return Ranged()
end
end

if RubimRH.CDsON() then
if Cooldowns() ~= nil then
return Cooldowns()
end
end

if Generators() ~= nil then
return Generators()
end

end

-- Out of Combat
if not Player:AffectingCombat() then
if IsReady(RubimRH.queuedSpell[1]:ID(),nil,nil,1) then
return RubimRH.QueuedSpell():Cast()
end

if (not IsReady(RubimRH.queuedSpell[1]:ID(),nil,nil,1) or not Player:AffectingCombat() or inRange30 == 0) then
RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
end

if IsReady("Cleanse Toxins") and S.CleanseToxins:TimeSinceLastCast()>2 and (GetAppropriateCureSpell("focus") == "Poison" or GetAppropriateCureSpell("focus") == "Disease") then
return S.CleanseToxins:Cast()
end

if IsReady("Retribution Aura") and Player:BuffDown(S.RetributionAura) then
return S.RetributionAura:Cast()
end

if IsReady("Divine Shield") and Player:DebuffUp(S.Burst) and Player:DebuffDown(S.Forbearance) and ((Player:HealthPercentage() <= 40 and
Player:BuffDown(S.ShieldofVengeance) and Player:BuffDown(S.DivineProtection)) or Player:HealthPercentage()<=20) then
return S.DivineShield:Cast()
end

if IsReady("Lay on Hands") and Player:DebuffUp(S.Burst) and Player:HealthPercentage() <= 20 and Player:DebuffDown(S.Forbearance) 
and S.DivineShield:CooldownRemains() > Player:GCD() then
return S.LayonHands:Cast()
end

if IsReady("Word of Glory") and inRange20==0 and Player:HealthPercentage()<75 and HolyPower>=3 then
return S.WordofGlory:Cast()
end


return 0, "Interface\\Addons\\Rubim-RH\\Media\\prot.tga"
end

return 0, 135328
end -- end APL

RubimRH.Rotation.SetAPL(70, APL);

local function PASSIVE()

end

RubimRH.Rotation.SetPASSIVE(70, PASSIVE);
