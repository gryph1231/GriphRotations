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
local pairs             = pairs;
local tableconcat       = table.concat;
local tostring          = tostring;
local tableinsert       = table.insert;
local MultiSpell        =HL.MultiSpell

if not Spell.Priest then
Spell.Priest = {};
end

RubimRH.Spell[258] = {

--SPELLS GO HERE 
 -- Racials
 AncestralCall               = Spell(274738),
 ArcanePulse                 = Spell(260364),
 ArcaneTorrent               = Spell(50613),
 BagofTricks                 = Spell(312411),
 Berserking                  = Spell(26297),
 BerserkingBuff              = Spell(26297),
 BloodFury                   = Spell(20572),
 BloodFuryBuff               = Spell(20572),
 Fireblood                   = Spell(265221),
 LightsJudgment              = Spell(255647),
 -- Abilities
 DeathAndMadness             = Spell(321291),
 DesperatePrayer             = Spell(19236),
 HolyNova                    = Spell(132157), -- Melee, 12
 MindBlast                   = Spell(8092),
 MindSear                    = Spell(48045), -- Splash, 10
 PowerInfusion               = Spell(10060),
 PowerWordFortitude          = Spell(21562),
 PowerWordShield             = Spell(17),
 ShadowWordDeath             = Spell(32379),
 ShadowWordPain              = Spell(589),
 ShadowWordPainDebuff        = Spell(589),
 FlashHeal                   = Spell(2061),
 Smite                       = Spell(585),
 Renew                       = Spell(139),
 Fade                        = Spell(586),

 -- Talents
 Mindgames                   = Spell(375901),
 Manipulation                = Spell(390996),
 Shadowfiend                 = Spell(34433),
 CrystallineReflection       = Spell(373457),
 Rhapsody                    = Spell(390622),
 PowerWordLife               = Spell(373481),
 TwistofFate                 = Spell(390972),
 -- Buffs
 AberrantSpellforgeBuff      = Spell(451895),
 PowerWordFortitudeBuff      = Spell(21562),
 RhapsodyBuff                = Spell(390636),
 SpymastersReportBuff        = Spell(451199), -- Stacking buff from before using Spymaster's Web trinket
 SpymastersWebBuff           = Spell(444959), -- Buff from using Spymaster's Web trinket
 TwistofFateBuff             = Spell(390978),
 -- Debuffs
 -- Other
autoattack                   = Spell(33697),
EmpoweredSurges             = Spell(453799),
PerfectedForm               = Spell(453917),

--leave these in here to track drums/lust usage and use spell q macro
lustAT = Spell(155145),
lust1 = Spell(57724),
lust2 = Spell(57723),
lust3 = Spell(80354),
lust4 = Spell(95809),
lust5 = Spell(264689),
 -- Abilities
 VoidWraithAbility           = Spell(451235),
 -- Talents
 DepthofShadows              = Spell(451308),
 DevourMatter                = Spell(451840),
 EntropicRift                = Spell(447444),
 InnerQuietus                = Spell(448278),
 VoidBlast                   = Spell(450405),
 VoidEmpowerment             = Spell(450138),
 VoidWraith                  = Spell(451234),
 -- Base Spells
 MindFlay                    = Spell(15407),
 Shadowform                  = Spell(232698),
 VampiricTouch               = Spell(34914),
 VoidBolt                    = Spell(205448),
 VoidEruption                = Spell(228260), -- Splash, 10
 -- Talents
 DarkAscension               = Spell(391109),
 Deathspeaker                = Spell(392507),
 DevouringPlague             = Spell(335467),
 Dispersion                  = Spell(47585),
 DistortedReality            = Spell(409044),
 DivineStar                  = Spell(122121),
 Halo                        = Spell(120644),
 InescapableTorment          = Spell(373427),
 InsidiousIre                = Spell(373212),
 Mindbender                  = Spell(200174),
 MindDevourer                = Spell(373202),
 MindFlayInsanity            = Spell(391403),
 MindMelt                    = Spell(391090),
 MindSpike                   = Spell(73510),
 MindSpikeInsanity           = Spell(407466),
 MindsEye                    = Spell(407470),
 Misery                      = Spell(238558),
 PsychicLink                 = Spell(199484),
 ShadowCrash                 = Spell(205385), -- Splash, 8
 ShadowCrashTarget           = Spell(457042),
 Silence                     = Spell(15487),
 UnfurlingDarkness           = Spell(341273),
 VoidTorrent                 = Spell(263165),
 Voidtouched                 = Spell(407430),
 WhisperingShadows           = Spell(406777),
 -- Buffs
 DarkAscensionBuff           = Spell(391109),
 DarkEvangelismBuff          = Spell(391099),
 DeathspeakerBuff            = Spell(392511),
 DevouredFearBuff            = Spell(373319), -- Idol of Y'Shaarj buff
 DevouredPrideBuff           = Spell(373316), -- Idol of Y'Shaarj buff
 MindDevourerBuff            = Spell(373204),
 MindFlayInsanityBuff        = Spell(391401),
 MindMeltBuff                = Spell(391092),
 MindSpikeInsanityBuff       = Spell(407468),
 ShadowformBuff              = Spell(232698),
 UnfurlingDarknessBuff       = Spell(341282),
 VoidformBuff                = Spell(194249),
 -- Debuffs
 DevouringPlagueDebuff       = Spell(335467),
 VampiricTouchDebuff         = Spell(34914),

}

local S = RubimRH.Spell[258]
local G = RubimRH.Spell[1] -- General Skills




-- Items
if not Item.Priest then Item.Priest = {} end
Item.Priest.Shadow = {

HPIcon = Item(169451), --healing pot icon
drumsoffury = Item(120257),
};
local I = Item.Priest.Shadow;



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
--mob tracking for mobs in combat
local function combatmobs40()
local totalRange40 = 0

for id = 1, 15 do -- Keep this at 15 to limit the checks
local unitID = "nameplate" .. id
if UnitCanAttack("player", unitID) 
and C_Spell.IsSpellInRange("Lightning Bolt", unitID)
and UnitHealthMax(unitID) > 5 
and (UnitAffectingCombat(unitID) or string.sub(UnitName(unitID), -5) == "Dummy") then
totalRange40 = totalRange40 + 1
end
end

return totalRange40
end



local function aoe()

--put AOE rotation here
if IsReady("Dark Ascension") and RubimRH.CDsON() then
  return S.DarkAscension:Cast()
end

if IsReady("Power Infusion") and RubimRH.CDsON() then
  return S.PowerInfusion:Cast()
end
if IsReady("Mind Flay: Insanity") and Player:BuffUp(S.MindFlayInsanityBuff) and TargetinRange(40) then
  return S.MindFlayInsanity:Cast()
end

if IsReady("Devouring Plague") and RubimRH.CDsON() then
    return S.DevouringPlague:Cast()
  end
if IsReady("Shadowfiend") and RubimRH.CDsON() then
    return S.Shadowfiend:Cast()
  end
if IsReady("Shadow Crash") and not Player:IsMoving() and TargetinRange(40) and VTremains<3 then
    return S.ShadowCrash:Cast()
  end
  if IsReady("Halo") and not Player:IsMoving() and TargetinRange(40) and VTremains<3 then
    return S.Halo:Cast()
  end
  if IsReady("Vampiric Touch") and not Player:IsMoving() and TargetinRange(40) and VTremains<3 then
    return S.VampiricTouch:Cast()
  end
  if IsReady("Shadow Word: Pain") and TargetinRange(40) and SWPremains<3 then
    return S.ShadowWordPain:Cast()
  end

  if IsReady("Shadow Word: Death") and TargetinRange(40) then
    return S.ShadowWordDeath:Cast()
  end

  if IsReady("Mind Blast") and not Player:IsMoving() and TargetinRange(40) then
    return S.MindBlast:Cast()
  end

  if IsReady("Mind Flay") and not Player:IsMoving() and TargetinRange(40) then
    return S.MindFlay:Cast()
  end




end



local function st()

--put ST rotation here
if IsReady("Dark Ascension") and RubimRH.CDsON() then
  return S.DarkAscension:Cast()
end

if IsReady("Power Infusion") and RubimRH.CDsON() then
  return S.PowerInfusion:Cast()
end

if IsReady("Mind Flay: Insanity") and Player:BuffUp(S.MindFlayInsanityBuff) and TargetinRange(40) then
  return S.MindFlayInsanity:Cast()
end

if IsReady("Devouring Plague") and RubimRH.CDsON() then
    return S.DevouringPlague:Cast()
  end

if IsReady("Shadowfiend") and RubimRH.CDsON() then
    return S.Shadowfiend:Cast()
  end

  if IsReady("Shadow Crash") and not Player:IsMoving() and TargetinRange(40) and VTremains<3 then
    return S.ShadowCrash:Cast()
  end

  if IsReady("Halo") and not Player:IsMoving() and TargetinRange(40) and VTremains<3 then
    return S.Halo:Cast()
  end

if IsReady("Vampiric Touch") and not Player:IsMoving() and TargetinRange(40) and VTremains<3 then
    return S.VampiricTouch:Cast()
  end

  if IsReady("Shadow Word: Pain") and TargetinRange(40) and SWPremains<3 then
    return S.ShadowWordPain:Cast()
  end

  if IsReady("Shadow Word: Death") and TargetinRange(40) then
    return S.ShadowWordDeath:Cast()
  end

  if IsReady("Mind Blast") and not Player:IsMoving() and TargetinRange(40) then
    return S.MindBlast:Cast()
  end

  if IsReady("Mind Flay") and not Player:IsMoving() and TargetinRange(40) then
    return S.MindFlay:Cast()
  end








end


local function APL()

    if AuraUtil.FindAuraByName("Power Word: Fortitude","player") then
        PWFremains = select(6,AuraUtil.FindAuraByName("Power Word: Fortitude","player")) - GetTime()
        else
        PWFremains = 0
        end
    
        if AuraUtil.FindAuraByName("Shadow Word: Pain","target","PLAYER|HARMFUL") then
        SWPremains = select(6,AuraUtil.FindAuraByName("Shadow Word: Pain","target","PLAYER|HARMFUL")) - GetTime()
            else
            SWPremains = 0 
        end

        if AuraUtil.FindAuraByName("Vampiric Touch","target","PLAYER|HARMFUL") then
            VTremains = select(6,AuraUtil.FindAuraByName("Vampiric Touch","target","PLAYER|HARMFUL")) - GetTime()
                else
                VTremains = 0 
            end
        local isTanking, status, threatpct, rawthreatpct, threatvalue = UnitDetailedThreatSituation("player", "target")
        
        --these functions are for tracking kicks/cast timers


local startTimeMS = select(4, UnitCastingInfo('target')) or 0
local currentTimeMS = GetTime() * 1000
local elapsedTimeca = (startTimeMS > 0) and (currentTimeMS - startTimeMS) or 0
local castTime = elapsedTimeca / 1000
local startTimeMS = select(4, UnitCastingInfo('target')) or select(4, UnitChannelInfo('target')) or 0
local currentTimeMS = GetTime() * 1000
local elapsedTimech = (startTimeMS > 0) and (currentTimeMS - startTimeMS) or 0
local channelTime = elapsedTimech / 1000

if Target:Exists() and getCurrentDPS() and getCurrentDPS()>0 then
targetTTD = UnitHealth('target')/getCurrentDPS()
else targetTTD = 8888
end


if Player:IsCasting() or Player:IsChanneling() then
return 0, "Interface\\Addons\\Rubim-RH\\Media\\channel.tga"
elseif Player:IsDeadOrGhost() or AuraUtil.FindAuraByName("Drink", "player") or AuraUtil.FindAuraByName("Food", "player") or AuraUtil.FindAuraByName("Food & Drink", "player") then
return 0, "Interface\\Addons\\Rubim-RH\\Media\\griph.tga"
end 

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------SPELL QUEUES-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

if S.lustAT:ID() ==  RubimRH.queuedSpell[1]:ID() and Player:DebuffDown(S.lust1) and Player:DebuffDown(S.lust2) and Player:DebuffDown(S.lust3) and Player:DebuffDown(S.lust4) and Player:DebuffDown(S.lust5) then
return S.lustAT:Cast() -- BIND LUST KEYBIND IN BINDPAD TO ARCANE TORRENT
end

if S.lustAT:ID() ==  RubimRH.queuedSpell[1]:ID() and (Player:DebuffUp(S.lust1) or Player:DebuffUp(S.lust2) or Player:DebuffUp(S.lust3) or Player:DebuffUp(S.lust4) or Player:Debuff(S.lust5)) then
RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
end


if (not IsReady(RubimRH.queuedSpell[1]:ID(),nil,nil,1) or not Player:AffectingCombat() or RangeCount(30) == 0 )
then
RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
end

if IsReady(RubimRH.queuedSpell[1]:ID(),nil,nil,1) then
return RubimRH.QueuedSpell():Cast()
end


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------DEFENSIVES-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--put all your defensives here if you want it to call or just handle manually
if (( Player:AffectingCombat()  or C_Spell.IsCurrentSpell(6603)) and Player:CanAttack(Target)  and not Target:IsDeadOrGhost())  then 

if  Player:HealthPercentage() <= 20  and (IsUsableItem(211880) == true and GetItemCooldown(211880) == 0 and GetItemCount(211880) >= 1 or IsUsableItem(211878) == true and GetItemCooldown(211878) == 0 and GetItemCount(211878) >= 1 or IsUsableItem(211879) == true and GetItemCooldown(211879) == 0 and GetItemCount(211879) >= 1) and (not Player:InArena() and not Player:InBattlegrounds()) then
return I.HPIcon:Cast()
end

if (isTanking == true or Player:IsTankingAoE(8)) and IsReady("Power Word: Shield") and RangeCount(30)>=1 and (Player:HealthPercentage() <= 70 or Player:MovingFor()>Player:GCD()) and Player:AffectingCombat() then
    return S.PowerWordShield:Cast()
    end

    if (isTanking == true or Player:IsTankingAoE(8)) and IsReady("Fade") and RangeCount(30)>=1 and (Player:HealthPercentage() <= 90 or Player:MovingFor()>Player:GCD()) and Player:AffectingCombat() then
      return S.Fade:Cast()
      end

    if (isTanking == true or Player:IsTankingAoE(8)) and IsReady("Desperat Prayer") and RangeCount(30)>=1 and (Player:HealthPercentage() <= 50 or Player:MovingFor()>Player:GCD()) and Player:AffectingCombat() then
      return S.DesperatePrayer:Cast()
      end

      if (isTanking == true or Player:IsTankingAoE(8)) and IsReady("Dispersion") and RangeCount(30)>=1 and (Player:HealthPercentage() <= 10 or Player:MovingFor()>Player:GCD()) and Player:AffectingCombat() then
        return S.Dispersion:Cast()
        end


--add anything else you want to do top priority in combat -- kicks, handling affix, any other defensives
--always start auto attack
if not C_Spell.IsCurrentSpell(6603) and TargetRange(30) then
    return S.autoattack:Cast()
    end

if (castTime > 0.1 or channelTime > 0.1) and select(8, UnitCastingInfo("target")) == false and RubimRH.InterruptsON() then
-- replace with your interrupt and uncomment out
    if IsReady("Silence") and targetRange40 and kickprio()  then
    return S.Silence:Cast()
    end
    
    end








if aoe() ~= nil and RubimRH.AoEON() and (RangeCount(40)>=2 and not Player:AffectingCombat() or combatmobs40()>=2) and TargetinRange(40) then
return aoe()
end




if st()~= nil and TargetinRange(40) then
return st()
end



end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------OUT OF COMBAT-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--write out of combat rotation here

if not Player:AffectingCombat() then

    if IsReady("Shadowform") and not AuraUtil.FindAuraByName("Shadowform","player") then
        return S.Shadowform:Cast()
        end

    if IsReady("Power Word: Fortitude") and PWFremains<300 then
            return S.PowerWordFortitude:Cast()
            end    







end




return 0, "Interface\\Addons\\Rubim-RH\\Media\\griph.tga"
end 





RubimRH.Rotation.SetAPL(258, APL);

local function PASSIVE()

end

RubimRH.Rotation.SetPASSIVE(258, PASSIVE);