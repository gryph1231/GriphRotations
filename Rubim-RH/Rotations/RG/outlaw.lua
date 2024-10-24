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
SummarilyDispatched    = Spell(381990),
KeepitRolling          = Spell(381989),
SSAudacity             = Spell(197834),
ShadowRunner           = Spell(378807),
Audacity               = Spell(381845),
AudacityBuff           = Spell(386270),
SubterfugeBuff         = Spell(115192),
Subterfuge             = Spell(108208),
ThistleTea             = Spell(381623),
HiddenOpportunity      = Spell(383281),
autoattack             = Spell(274738), -- ancestral call
ImprovedBetweentheEyes = Spell(235484),
ColdBlood              = Spell(382245),
ShadowDance            = Spell(185313),
ShadowDanceBuff        = Spell(185422),
DeftManeuvers          = Spell(381878),
AcrobaticStrikes       = Spell(196924),
Sepsis                 = Spell(385408), --check if this is buff or just talent/spell
LoadedDiceBuff         = Spell(256171),
ViciousFollowup        = Spell(394879),
EchoingReprimand       = Spell(385616),
EchoingReprimandCP2    = Spell(323558),
EchoingReprimandCP3    = Spell(323559),
EchoingReprimandCP4    = Spell(323560),
EchoingReprimandCP5    = Spell(354838),
BladeRush              = Spell(271877),
CripplingPoison        = Spell(3408),
AtrophicPoison         = Spell(381637),
InstantPoison          = Spell(315584),
NumbingPoison          = Spell(5761),
ImprovedAdrenalineRush = Spell(395422),
FantheHammer           = Spell(381846),
WithoutATrace          = Spell(382513),
SwiftSlasher           = Spell(381988),
Shadowstep             = Spell(36554),
CounttheOdds           = Spell(381982),
Dreadblades            = Spell(343142),
Detection              = Spell(56814),
KidneyShot             = Spell(408),
Deadshot               = Spell(272935),
Berserking             = Spell(26297),
Darkflight             = Spell(68992),
Distract               = Spell(1725),
lust1    = Spell(57724),
lust2    = Spell(57723),
lust3    = Spell(80354),
lust4    = Spell(95809),
lust5    = Spell(264689),
lustAT                 = Spell(155145), --arcane torrent
WaterStrider           = Spell(118089),
BugMount               = Spell(243795),
razorcoral             = Spell(303568),
CoupdeGrace            = Spell(441776),
ConductiveInk          = Spell(302565),
AdrenalineRush         = Spell(13750),
Ambush                 = Spell(8676),
BetweentheEyes         = Spell(315341),
BladeFlurry            = Spell(13877),
Shadowmeld             = Spell(135201),
Opportunity            = Spell(195627),
PistolShot             = Spell(185763),
RolltheBones           = Spell(315508),
Dispatch               = Spell(2098),
SinisterStrike         = Spell(193315),
ImprovedAmbush         = Spell(381620),
Stealth                = Spell(1784),
Stealth2               = Spell(115191),
FindWeakness           = Spell(91023),
FindWeaknessDebuff     = Spell(316220),
KillingSpreeDamageDebuff = Spell(424564),
Vanish                 = Spell(1856),
VanishBuff             = Spell(11327),
VanishBuff2            = Spell(115193),
LuckyCoin = Spell(461818),
Shiv                   = Spell(5938),
WilloftheForsaken      = Spell(7744),
CloakofShadows         = Spell(31224),
Alacrity               = Spell(193539),
AlacrityBuff           = Spell(193538),
Anticipation           = Spell(114015),
CannonballBarrage      = Spell(185767),
DeathfromAbove         = Spell(152150),
DeeperStratagem        = Spell(193531),
DeviousStratagem       = Spell(394321),
SecretStratagem        = Spell(394320),
HandOfFate             = Spell(452536),
FlawlessForm           = Spell(441321),
FlawlessFormBuff       = Spell(441326),
DirtyTricks            = Spell(108216),
GhostlyStrike          = Spell(196937),
KillingSpree           = Spell(51690),
MarkedforDeath         = Spell(137619),
QuickDraw              = Spell(196938),
GreenSkinsWickers      = Spell(386823), --386823 --394131
GreenskinsWickersBuff  = Spell(394131),
SliceandDice           = Spell(315496),
Vigor                  = Spell(14983),
Ruthlessness           = Spell(14161),
Exhaustion             = Spell(57723),
PrecisionShot          = Spell(428377),
Blind                  = Spell(2094),
Blunderbuss            = Spell(202895),
CurseoftheDreadblades  = Spell(202665),
HiddenBlade            = Spell(202754),
LoadedDice             = Spell(256170),
DeadshotBuff           = Spell(272940),
AceUpYourSleeve        = Spell(278676),
Legacyofwaycrest       = Spell(199368), --BRH debuff
SnakeEyes              = Spell(275846),
SnakeEyesBuff          = Spell(275863),
CheapShot              = Spell(1833),
CrimsonVial            = Spell(185311),
Feint                  = Spell(1966),
Gouge                  = Spell(1776),
Kick                   = Spell(1766),
Sprint                 = Spell(2983),
Broadside              = Spell(193356),
BuriedTreasure         = Spell(199600),
GrandMelee             = Spell(193358),
SkullandCrossbones     = Spell(199603),
GCBoon                 = Spell(20572),
RuthlessPrecision      = Spell(193357),
TrueBearing            = Spell(193359),
Evasion                = Spell(5277),
WoundPoison            = Spell(8679),
Supercharger = Spell(470347),
chronofaded            = Spell(404141),
Crackshot              = Spell(423703),
UnderhandedUpperhand   = Spell(424044),
SepsisBuff             = Spell(375939),
shadetarget            = Spell(350209),
Potion                 = Spell(176108),

}

local S = RubimRH.Spell[260]

if not Item.Rogue then Item.Rogue = {}; end

Item.Rogue.Outlaw = {
    tx1 = Item(118330),
    tx2 = Item(114616),
    drums = Item(219905),
    HPIcon = Item(169451),
    HPpotID = Item(207023),
};

local I = Item.Rogue.Outlaw;

local function num(val)
    if val then
        return 1
    else
        return 0
    end
end

-- Rotation Var
local Enemies30y, EnemiesBF, EnemiesBFCount
local ShouldReturn; -- Used to get the return string
local BladeFlurryRange = 6
local  ComboPoints, ComboPointsDeficit
local Energy, EnergyRegen, EnergyDeficit, EnergyTimeToMax, EnergyMaxOffset
-- Stable Energy Prediction
local PrevEnergyTimeToMaxPredicted, PrevEnergyPredicted = 0, 0
local function EnergyTimeToMaxStable (MaxOffset)
  local EnergyTimeToMaxPredicted = Player:EnergyTimeToMaxPredicted(nil, MaxOffset)
  if EnergyTimeToMaxPredicted < PrevEnergyTimeToMaxPredicted
    or (EnergyTimeToMaxPredicted - PrevEnergyTimeToMaxPredicted) > 0.5 then
    PrevEnergyTimeToMaxPredicted = EnergyTimeToMaxPredicted
  end
  return PrevEnergyTimeToMaxPredicted
end

local function EnergyPredictedStable ()
  local EnergyPredicted = Player:EnergyPredicted()
  if EnergyPredicted > PrevEnergyPredicted
    or (EnergyPredicted - PrevEnergyPredicted) > 9 then
    PrevEnergyPredicted = EnergyPredicted
  end
  return PrevEnergyPredicted
end

local function StealthSpell()
  return S.Subterfuge:IsAvailable() and S.Stealth2 or S.Stealth
end
  
local function VanishBuffSpell()
  return S.Subterfuge:IsAvailable() and S.VanishBuff2 or S.VanishBuff
end
  
-- Stealth
local function Stealth(Stealth, Setting)
  if (not Player:AffectingCombat() and Player:CanAttack(Target)) and Stealth:IsCastable() and Player:StealthDown() then
  return StealthSpell():Cast()
  end

  return false
end
  
-- Ensure that the functions are defined at the correct place
local EchoingReprimandCP2 = Spell(323558)
local EchoingReprimandCP3 = Spell(323559)
local EchoingReprimandCP4 = Spell(323560)
local EchoingReprimandCP5 = Spell(354838)

-- Define AnimachargedCP function
local function AnimachargedCP()
    if Player:BuffUp(EchoingReprimandCP2) then
        return 2
    elseif Player:BuffUp(EchoingReprimandCP3) then
        return 3
    elseif Player:BuffUp(EchoingReprimandCP4) then
        return 4
    elseif Player:BuffUp(EchoingReprimandCP5) then
        return 5
    end
    return -1
end

-- Define EffectiveComboPoints() function
local function EffectiveComboPoints()
    local ComboPoints = Player:ComboPoints()
    if (ComboPoints == 2 and Player:BuffUp(EchoingReprimandCP2)) or 
       (ComboPoints == 3 and Player:BuffUp(EchoingReprimandCP3)) or 
       (ComboPoints == 4 and Player:BuffUp(EchoingReprimandCP4)) or 
       (ComboPoints == 5 and Player:BuffUp(EchoingReprimandCP5)) then
        return 7
    end
    return ComboPoints
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

local function EnergyTimeToMaxRounded()
    return math.floor(Player:EnergyTimeToMaxPredicted() * 10 + 0.5) / 10;
end

--- ======= ACTION LISTS =======
local RtB_BuffsList = {
    S.Broadside,
    S.BuriedTreasure,
    S.GrandMelee,
    S.RuthlessPrecision,
    S.SkullandCrossbones,
    S.TrueBearing
  }

local enableRtBDebugging = false
  -- Get the number of Roll the Bones buffs currently on
local function RtB_Buffs ()
  if not Cache.APLVar.RtB_Buffs then
    Cache.APLVar.RtB_Buffs = {}
    Cache.APLVar.RtB_Buffs.Will_Lose = {}
    Cache.APLVar.RtB_Buffs.Will_Lose.Total = 0
    Cache.APLVar.RtB_Buffs.Total = 0
    Cache.APLVar.RtB_Buffs.Normal = 0
    Cache.APLVar.RtB_Buffs.Shorter = 0
    Cache.APLVar.RtB_Buffs.Longer = 0
    Cache.APLVar.RtB_Buffs.MinRemains = 0
    Cache.APLVar.RtB_Buffs.MaxRemains = 0
    local RtBRemains = RtBRemains()
    for i = 1, #RtB_BuffsList do
      local Remains = Player:BuffRemains(RtB_BuffsList[i])
      if Remains > 0 then
        Cache.APLVar.RtB_Buffs.Total = Cache.APLVar.RtB_Buffs.Total + 1
      if Remains > Cache.APLVar.RtB_Buffs.MaxRemains then
        Cache.APLVar.RtB_Buffs.MaxRemains = Remains
      end

      if Remains < Cache.APLVar.RtB_Buffs.MinRemains then
        Cache.APLVar.RtB_Buffs.MinRemains = Remains
      end

      local difference = math.abs(Remains - RtBRemains)

      if difference <= 0.5 then
        Cache.APLVar.RtB_Buffs.Normal = Cache.APLVar.RtB_Buffs.Normal + 1
        Cache.APLVar.RtB_Buffs.Will_Lose[RtB_BuffsList[i]:Name()] = true
        Cache.APLVar.RtB_Buffs.Will_Lose.Total = Cache.APLVar.RtB_Buffs.Will_Lose.Total + 1
      elseif Remains > RtBRemains then
        Cache.APLVar.RtB_Buffs.Longer = Cache.APLVar.RtB_Buffs.Longer + 1
      else
        Cache.APLVar.RtB_Buffs.Shorter = Cache.APLVar.RtB_Buffs.Shorter + 1
        Cache.APLVar.RtB_Buffs.Will_Lose[RtB_BuffsList[i]:Name()] = true
        Cache.APLVar.RtB_Buffs.Will_Lose.Total = Cache.APLVar.RtB_Buffs.Will_Lose.Total + 1
      end
    end
  end
  end
  return Cache.APLVar.RtB_Buffs.Total
end
  
local function checkBuffWillLose(buff)
  return (Cache.APLVar.RtB_Buffs.Will_Lose and Cache.APLVar.RtB_Buffs.Will_Lose[buff]) and true or false
end
  --RtB rerolling strategy, return true if we should reroll
local function RtB_Reroll()
  if not Cache.APLVar.RtB_Reroll then
    Cache.APLVar.RtB_Reroll = false
    RtB_Buffs()
    --variable,name=rtb_reroll,value=rtb_buffs.will_lose=(rtb_buffs.will_lose.buried_treasure+rtb_buffs.will_lose.grand_melee&spell_targets.blade_flurry<2&raid_event.adds.in>12&raid_event.adds.count<2)
    Cache.APLVar.RtB_Reroll = RtB_Buffs() == num(checkBuffWillLose(S.BuriedTreasure)) + (num(checkBuffWillLose(S.GrandMelee) and num(RangeCount(10) < 2)))
    --variable,name=rtb_reroll,if=talent.loaded_dice,value=(rtb_buffs.will_lose<=buff.loaded_dice.up)|buff.loaded_dice.up&rtb_buffs.will_lose<3&(!rtb_buffs.will_lose.broadside|buff.broadside.remains<11)&(!rtb_buffs.will_lose.ruthless_precision|buff.ruthless_precision.remains<11)&(!rtb_buffs.will_lose.true_bearing|buff.true_bearing.remains<11)
    Cache.APLVar.RtB_Reroll = S.LoadedDice:IsAvailable() and Cache.APLVar.RtB_Buffs.Will_Lose.Total <= num(Player:BuffUp(S.LoadedDiceBuff)) or Player:BuffUp(S.LoadedDiceBuff) and Cache.APLVar.RtB_Buffs.Will_Lose.Total < 3 and (not checkBuffWillLose(S.Broadside) or Player:BuffRemains(S.Broadside) < 11) and (not checkBuffWillLose(S.RuthlessPrecision) or Player:BuffRemains(S.RuthlessPrecision) < 11) and (not checkBuffWillLose(S.TrueBearing) or Player:BuffRemains(S.TrueBearing) < 11)                                                                                                                         
    --variable,name=rtb_reroll,value=variable.rtb_reroll&rtb_buffs.longer=0|rtb_buffs.normal=0&rtb_buffs.longer>=1&buff.loaded_dice.up&(rtb_buffs<6&rtb_buffs.max_remains<39|talent.supercharger)
    Cache.APLVar.RtB_Reroll = Cache.APLVar.RtB_Reroll and Cache.APLVar.RtB_Buffs.Longer == 0 or Cache.APLVar.RtB_Buffs.Normal == 0 and Cache.APLVar.RtB_Buffs.Longer >= 1 and Player:BuffUp(S.LoadedDiceBuff) and (RtB_Buffs() < 6 and Cache.APLVar.RtB_Buffs.MaxRemains <= 39 or S.Supercharger:IsAvailable())
  end
  return Cache.APLVar.RtB_Reroll
end
  
-- # Use finishers if at -1 from max combo points, or -2 in Stealth with Crackshot
local function Finish_Condition() 
  -- actions+=/variable,name=finish_condition,value=effective_combo_points>=cp_max_spend-1-(stealthed.all
  -- &talent.crackshot|(talent.hand_of_fate|talent.flawless_form)&talent.hidden_opportunity&(buff.audacity.up|buff.opportunity.up))
  return EffectiveComboPoints() >= CPMaxSpend() - 1 - ((Player:StealthUp(true, true) and S.Crackshot:IsAvailable() and 1 or 0) +((S.HandOfFate:IsAvailable() or S.FlawlessForm:IsAvailable()) and S.HiddenOpportunity:IsAvailable() and (Player:BuffUp(S.AudacityBuff) or Player:BuffUp(S.Opportunity)) and 1 or 0))
  end

  -- # Ensure we want to cast Ambush prior to triggering a Stealth cooldown
  local function Ambush_Condition()
  -- actions+=/variable,name=ambush_condition,value=(talent.hidden_opportunity|combo_points.deficit>=2+talent.improved_ambush+buff.broadside.up)&energy>=50
    return (S.HiddenOpportunity:IsAvailable() or ComboPointsDeficit >=2 + num(S.ImprovedAmbush:IsAvailable()) + num(Player:BuffUp(S.Broadside))) and Energy >= 50
  end

  -- Determine if we are allowed to use Vanish offensively in the current situation
  local function Vanish_DPS_Condition()
  -- You can vanish if we've set the UseDPSVanish setting, and we're either not tanking or we're solo but the DPS vanish while solo flag is set).
    return (not Player:IsTanking(Target) or Target:IsAPlayer() or IsInInstance())
end
  
local function Stealth()
  -- if S.BladeFlurry:IsReady() then
  --   if S.DeftManeuvers:IsAvailable() and not Finish_Condition() and (inRange10 >= 3 and ComboPointsDeficit == inRange10 + num(Player:BuffUp(S.Broadside)) or inRange10 >= 5) then
  --     return S.BladeFlurry:Cast()
  --   end
  -- end
  
    --cold_blood,if=variable.finish_condition
    if IsReady("Cold Blood") and Player:BuffDown(S.ColdBlood) and TargetinRange(5) and Finish_Condition() then
      return S.ColdBlood:Cast()
    end
    --between_the_eyes,if=variable.finish_condition&talent.crackshot&(!buff.shadowmeld.up|stealthed.rogue)
    if IsReady("Between the Eyes") and C_Item.IsItemInRange(835, "target") and Finish_Condition() and S.Crackshot:IsAvailable() and (not Player:BuffUp(S.Shadowmeld) or Player:StealthUp(true, false)) then
      return S.BetweentheEyes:Cast()
    end
    --dispatch,if=variable.finish_condition
    if IsReady("Dispatch") and TargetinRange(5) and Finish_Condition() then
      return S.Dispatch:Cast()
    end
    --pistol_shot,if=talent.crackshot&talent.fan_the_hammer.rank>=2&buff.opportunity.stack>=6&(buff.broadside.up&combo_points<=1|buff.greenskins_wickers.up)
    if IsReady("Pistol Shot") and C_Item.IsItemInRange(835, "target") and S.Crackshot:IsAvailable() and S.FantheHammer:TalentRank() >= 2 and Player:BuffStack(S.Opportunity) >= 6 and (Player:BuffUp(S.Broadside) and ComboPoints <= 1 or Player:BuffUp(S.GreenskinsWickersBuff)) and not Finish_Condition() then
      return S.PistolShot:Cast()
    end
    --NOT PART of SimC Condition duplicated from build to Show SS Icon in stealth with audacity buff
    if IsReady("Ambush") and S.HiddenOpportunity:IsAvailable() and Player:BuffUp(S.AudacityBuff) and not Finish_Condition() then
      return S.SSAudacity:Cast()
    end
    --ambush,if=talent.hidden_opportunity
    if IsReady("Ambush") and TargetinRange(5) and S.HiddenOpportunity:IsAvailable() and not Finish_Condition() then
      return S.Ambush:Cast()
    end
  end

  
local function Finish()
  -- # Finishers Use Between the Eyes to keep the crit buff up, but on cooldown if Improved/Greenskins, and avoid overriding Greenskins
  -- actions.finish=between_the_eyes,if=!talent.crackshot
  -- &(buff.between_the_eyes.remains<4|talent.improved_between_the_eyes|talent.greenskins_wickers)
  -- &!buff.greenskins_wickers.up
  if IsReady("Between the Eyes") and targetRange30 and not S.Crackshot:IsAvailable() and (Player:BuffRemains(S.BetweentheEyes) < 4 or S.ImprovedBetweenTheEyes:IsAvailable() or S.GreenskinsWickers:IsAvailable()) and Player:BuffDown(S.GreenskinsWickers) then
    return S.BetweentheEyes:Cast()
  end

  if IsReady("Between the Eyes") and targetRange30 and S.Crackshot:IsAvailable() and (Player:BuffUp(S.RuthlessPrecision) or Player:BuffRemains(S.BetweentheEyes)<4) then
      return S.BetweentheEyes:Cast()
    end
  

  if IsReady("Cold Blood") and targetRange8 then
    return S.ColdBlood:Cast()
  end

  -- actions.finish+=/coup_de_grace
  if IsReady("Coup de Grace") and targetRange8 then
    return S.CoupdeGrace:Cast()
  end

  -- actions.finish+=/dispatch
  if IsReady("Dispatch") and targetRange8 then
    return S.Dispatch:Cast()
  end
end
  



local function StealthCDs()

if IsReady("Vanish") and Vanish_DPS_Condition() and S.AdrenalineRush:CooldownRemains()>45 and S.Vanish:Charges()==2 and Finish_Condition() then
    return S.Vanish:Cast()
  end

---+=+=+=+CHECK supercharge lines
-- vanish,if=talent.underhanded_upper_hand&talent.subterfuge&talent.crackshot&buff.adrenaline_rush.up&variable.finish_condition&(!cooldown.between_the_eyes.ready&buff.ruthless_precision.up
-- |buff.adrenaline_rush.remains<3|buff.supercharge_1.up|buff.supercharge_2.up|cooldown.vanish.full_recharge_time<15|fight_remains<8)
if IsReady("Vanish") and Vanish_DPS_Condition() and S.UnderhandedUpperhand:IsAvailable() and S.Subterfuge:IsAvailable() and S.Crackshot:IsAvailable() and Player:BuffUp(S.AdrenalineRush) and Finish_Condition() and (not IsReady("Between the Eyes") and Player:BuffUp(S.RuthlessPrecision) 
or Player:BuffRemains(S.AdrenalineRush)<3 or AuraUtil.FindAuraByName("Supercharge", "player") or S.Vanish:FullRechargeTime()<15) then
  return S.Vanish:Cast()
end


    -- vanish,if=talent.underhanded_upper_hand&talent.subterfuge&!talent.crackshot&buff.adrenaline_rush.up&(variable.ambush_condition|!talent.hidden_opportunity)&(!cooldown.between_the_eyes.ready
    -- &buff.ruthless_precision.up|buff.ruthless_precision.down|buff.adrenaline_rush.remains<3)

  if IsReady("Vanish") and Vanish_DPS_Condition() and S.UnderhandedUpperhand:IsAvailable() and S.Subterfuge:IsAvailable()  and not S.Crackshot:IsAvailable() and Player:BuffUp(S.AdrenalineRush) and (Ambush_Condition() or not S.HiddenOpportunity:IsAvailable()) and (not IsReady("Between the Eyes") 
  and Player:BuffUp(S.RuthlessPrecision) or Player:BuffDown(S.RuthlessPrecision) or Player:BuffRemains(S.AdrenalineRush)) then
    return S.Vanish:Cast()
  end
  

  -- vanish,if=!talent.underhanded_upper_hand&!talent.crackshot&talent.hidden_opportunity&!buff.audacity.up&buff.opportunity.stack<buff.opportunity.max_stack&variable.ambush_condition
  if IsReady("Vanish") and Vanish_DPS_Condition() and not S.UnderhandedUpperhand:IsAvailable() and not S.Crackshot:IsAvailable() and S.HiddenOpportunity:IsAvailable() and Player:BuffDown(S.AudacityBuff) and Player:BuffStack(S.Opportunity)<6 and  Ambush_Condition() then
    return S.Vanish:Cast()
  end


  -- vanish,if=!talent.underhanded_upper_hand&!talent.crackshot&!talent.hidden_opportunity&talent.fateful_ending&(!buff.fatebound_lucky_coin.up&(buff.fatebound_coin_tails.stack>=5|buff.fatebound_coin_heads.stack>=5)|buff.fatebound_lucky_coin.up&!cooldown.between_the_eyes.ready)
  if IsReady("Vanish") and Vanish_DPS_Condition() and not S.UnderhandedUpperhand:IsAvailable() and not S.Crackshot:IsAvailable() and not S.HiddenOpportunity():IsAvailable() and not S.FatefulEnding:IsAvailable() and (Player:BuffDown(S.LuckyCoin) and (FBcoinTailsstacks >= 5 or FBcoinHeadsstacks >=5) or Player:BuffUp(S.LuckyCoin) and not IsReady("Between the Eyes")) then
    return S.Vanish:Cast()
  end



  -- vanish,if=!talent.underhanded_upper_hand&!talent.crackshot&!talent.hidden_opportunity&!talent.fateful_ending&talent.take_em_by_surprise&!buff.take_em_by_surprise.up
  if IsReady("Vanish") and Vanish_DPS_Condition() and not S.UnderhandedUpperhand:IsAvailable() and not S.Crackshot:IsAvailable() and not S.HiddenOpportunity:IsAvailable() and not S.FatefulEnding:IsAvailable() and S.TakeEmBySurprise:IsAvailable() and Player:BuffDown(S.TakeEmBySurpriseBuff) then
    return S.Vanish:Cast()
  end

  -- shadowmeld,if=variable.finish_condition&!cooldown.vanish.ready
  if S.Shadowmeld:IsAvailable() and S.Shadowmeld:IsReady() and Finish_Condition() and not IsReady("Vanish") then
    return S.Shadowmeld:Cast()
  end

end

local function CDs()
 
    --adrenaline_rush,if=!buff.adrenaline_rush.up&(!variable.finish_condition|!talent.improved_adrenaline_rush)|talent.crackshot&talent.improved_adrenaline_rush&combo_points<=2&!buff.loaded_dice.up
    if IsReady("Adrenaline Rush") and TargetinRange(8) and RubimRH.CDsON() and (not Player:BuffUp(S.AdrenalineRush) and (not Finish_Condition() or not S.ImprovedAdrenalineRush:IsAvailable()) or S.Crackshot:IsAvailable() and S.ImprovedAdrenalineRush:IsAvailable() and ComboPoints <= 2 and not Player:BuffUp(S.LoadedDiceBuff)) then
      return S.AdrenalineRush:Cast() 
    end 
    --blade_flurry,if=spell_targets>=2&buff.blade_flurry.remains<gcd
    if IsReady("Blade Flurry") then
      if RangeCount(8) >= 2 and Player:BuffRemains(S.BladeFlurry) < Player:GCD() then
        return S.BladeFlurry:Cast()
      end
    end
    --blade_flurry,if=talent.deft_maneuvers&!variable.finish_condition&(spell_targets>=3&combo_points.deficit=spell_targets+buff.broadside.up|spell_targets>=5)
    if IsReady("Blade Flurry") then
      if S.DeftManeuvers:IsAvailable() and not Finish_Condition() and (RangeCount(8) >= 3 and ComboPointsDeficit == RangeCount(8) + num(Player:BuffUp(S.Broadside)) or RangeCount(8) >= 5) then
        return S.BladeFlurry:Cast()
      end
    end
    --roll_the_bones,if=variable.rtb_reroll|rtb_buffs=0
    if IsReady("Roll the Bones") then
      if RtB_Reroll() or RtB_Buffs() == 0 then
        return S.RolltheBones:Cast()
      end
    end
    --keep_it_rolling,if=rtb_buffs>=4&(rtb_buffs.min_remains<2|buff.broadside.up)
     if IsReady("Keep It Rolling") and RtB_Buffs() >= 4 and (Cache.APLVar.RtB_Buffs.MinRemains < 2 or Player:BuffUp(S.Broadside)) then
      return S.KeepItRolling:Cast()
    end 
    --ghostly_strike,if=combo_points<cp_max_spend
     if IsReady("Ghostly Strike") and TargetinRange(8) and EffectiveComboPoints() < CPMaxSpend() then
      return S.GhostlyStrike:Cast()
    end 
    --killing_spree,if=variable.Finish_Condition()&!stealthed.all
     if IsReady("Killing Spree") and TargetinRange(10) and RubimRH.CDsON() and Finish_Condition() and not Player:StealthUp(true, true) and not targetdying then
      return S.KillingSpree:Cast()
    end 
    --call_action_list,name=stealth_cds,if=!stealthed.all
    if RubimRH.CDsON() and not Player:StealthUp(true, true) and TargetinRange(8) then
      ShouldReturn = StealthCDs()
      if ShouldReturn then return ShouldReturn end
    end 
    --thistle_tea,if=!buff.thistle_tea.up&(energy.base_deficit>=100|fight_remains<charges*6)
    if IsReady("Thistle Tea") and RubimRH.CDsON() and RangeCount(30) >= 1 and not Player:BuffUp(S.ThistleTea) and EnergyDeficit >= 100 then
      return S.ThistleTea:Cast()
    end  
    --blade_rush,if=energy.base_time_to_max>4&!stealthed.all  
    if IsReady("Blade Rush") and TargetinRange(5) and EnergyTimeToMax > 4 and not Player:StealthUp(true, true) then
      return S.BladeRush:Cast()
    end
    if RubimRH.CDsON() and TargetinRange(8) and Player:BuffUp(S.BetweentheEyes) then
      --use_items,slots=trinket1,if=buff.between_the_eyes.up|trinket.1.has_stat.any_dps|fight_remains<=20
      if trinket1ready then
        return Item(118330):Cast()
      end
      --use_items,slots=trinket2,if=buff.between_the_eyes.up|trinket.2.has_stat.any_dps|fight_remains<=20
      if trinket2ready then
          return Item(114616):Cast()
      end
    end

  end


local function Build()
  -- actions.build+=/echoing_reprimand
  if RubimRH.CDsON() and IsReady("Echoing Reprimand")  and targetRange8 then
    return S.EchoingReprimand:Cast()
  end

  -- actions.build+=/ambush,if=talent.hidden_opportunity&buff.audacity.up
  if IsReady("Ambush") and S.HiddenOpportunity:IsAvailable() and Player:BuffUp(S.AudacityBuff) and targetRange8  then
    return S.Ambush:Cast()
  end

  -- # With Audacity + Hidden Opportunity + Fan the Hammer, consume Opportunity to proc Audacity any time Ambush is not available
  -- actions.build+=/pistol_shot,if=talent.fan_the_hammer&talent.audacity&talent.hidden_opportunity&buff.opportunity.up&!buff.audacity.up
  if IsReady("Pistol Shot") and S.FantheHammer:IsAvailable() and S.Audacity:IsAvailable() and S.HiddenOpportunity:IsAvailable() and Player:BuffUp(S.Opportunity) and Player:BuffDown(S.AudacityBuff) and targetRange30 then
    return S.PistolShot:Cast()
  end

  -- # With Fan the Hammer, consume Opportunity as a higher priority if at max stacks or if it will expire
  -- actions.build+=/pistol_shot,if=talent.fan_the_hammer&buff.opportunity.up&(buff.opportunity.stack>=buff.opportunity.max_stack|buff.opportunity.remains<2)
  if IsReady("Pistol Shot") and S.FantheHammer:IsAvailable() and Player:BuffUp(S.Opportunity) and (Player:BuffStack(S.Opportunity) >= 6 or Player:BuffRemains(S.Opportunity) < 2) and targetRange30 then
    return S.PistolShot:Cast()
  end

  -- # With Fan the Hammer, consume Opportunity if it will not overcap CPs, or with 1 CP at minimum
  -- actions.build+=/pistol_shot,if=talent.fan_the_hammer&buff.opportunity.up&(combo_points.deficit>=(1+(talent.quick_draw+buff.broadside.up)
  -- *(talent.fan_the_hammer.rank+1))|combo_points<=talent.ruthlessness)
  if IsReady("Pistol Shot") and S.FantheHammer:IsAvailable() and Player:BuffUp(S.Opportunity) and (ComboPointsDeficit>=(1+(num(S.QuickDraw:IsAvailable())+num(Player:BuffUp(S.Broadside)))*(S.FantheHammer:TalentRank()+1)) or ComboPoints <= num(S.Ruthlessness:IsAvailable())) and targetRange30 then
    return S.PistolShot:Cast()
  end

  -- #If not using Fan the Hammer, then consume Opportunity based on energy, when it will exactly cap CPs, or when using Quick Draw
  -- actions.build+=/pistol_shot,if=!talent.fan_the_hammer&buff.opportunity.up&(energy.base_deficit>energy.regen*1.5|combo_points.deficit<=1+buff.broadside.up
  -- |talent.quick_draw.enabled|talent.audacity.enabled&!buff.audacity.up)
  if IsReady("Pistol Shot") and not S.FantheHammer:IsAvailable() and Player:BuffUp(S.Opportunity) and (EnergyDeficit > EnergyRegen*1.5 or ComboPointsDeficit <= 1 + num(Player:BuffUp(S.Broadside)) or S.QuickDraw:IsAvailable() or S.Audacity:IsAvailable() and Player:BuffDown(S.AudacityBuff)) and targetRange30 then
    return S.PistolShot:Cast()
  end

  if S.Ambush:IsCastable() and Player:Energy()<50 and S.HiddenOpportunity:IsAvailable() then
    return 0, "Interface\\Addons\\Rubim-RH\\Media\\griph.tga"
    -- actions.build+=/ambush,if=talent.hidden_opportunity&buff.audacity.up
  elseif IsReady("Ambush") and S.HiddenOpportunity:IsAvailable() and targetRange8 then
    return S.Ambush:Cast()
  end

  -- actions.build+=/sinister_strike
  if IsReady("Sinister Strike") and targetRange8 then
      return S.SinisterStrike:Cast()
  end
end

local function APL()
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

ComboPoints = Player:ComboPoints()
ComboPointsDeficit = Player:ComboPointsDeficit()
EnergyMaxOffset = Player:BuffUp(S.AdrenalineRush, nil, true) and -50 or 0 -- For base_time_to_max emulation
Energy = EnergyPredictedStable()
EnergyRegen = Player:EnergyRegen()
EnergyTimeToMax = EnergyTimeToMaxStable(EnergyMaxOffset) -- energy.base_time_to_max
EnergyDeficit = Player:EnergyDeficitPredicted(nil, EnergyMaxOffset) -- energy.base_deficit

if AuraUtil.FindAuraByName('Fatebound Coin (Heads)','player') then
  _, _, FBcoinHeadsstacks = AuraUtil.FindAuraByName('Fatebound Coin (Heads)','player')
else
  FBcoinHeadsstacks = 0
end

if AuraUtil.FindAuraByName('Fatebound Coin (Tails)','player') then
  _, _, FBcoinTailsstacks = AuraUtil.FindAuraByName('Fatebound Coin (Tails)','player')
else
  FBcoinTailsstacks = 0
end

if AuraUtil.FindAuraByName('Fatebound Coin (Tails)','player') then
  _, _, FBcoinTailsstacks = AuraUtil.FindAuraByName('Fatebound Coin (Tails)','player')
else
  FBcoinTailsstacks = 0
end


trinket1 = GetInventoryItemID("player", 13)
	
trinket2 = GetInventoryItemID("player", 14)

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


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Functions & Variables-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------=====-----------------------------------------------------------------------------------
if Player:IsCasting() or Player:IsChanneling() then
	return 0, "Interface\\Addons\\Rubim-RH\\Media\\channel.tga"
elseif Player:IsDeadOrGhost() or AuraUtil.FindAuraByName("Drink", "player") or AuraUtil.FindAuraByName("Food", "player") or AuraUtil.FindAuraByName("Food & Drink", "player") then
    return 0, "Interface\\Addons\\Rubim-RH\\Media\\griph.tga"
end

if Target:Exists() and getCurrentDPS() and getCurrentDPS()>0 then
  targetTTD = UnitHealth('target')/getCurrentDPS()
else 
  targetTTD = 8888
end
    
local targetdying =  targetTTD<6
local isTanking, status, threatpct, rawthreatpct, threatvalue = UnitDetailedThreatSituation("player", "target")

if true then
  tolerance = select(4, GetNetStats())/1000 + 0.18

	elite = (UnitClassification("target") == "worldboss" or UnitClassification("target") == "rareelite" or UnitClassification("target") == "elite" or UnitClassification("target") == "rare" or target_is_dummy() or Target:IsAPlayer())

	level, affixIDs, wasEnergized = C_ChallengeMode.GetActiveKeystoneInfo()

	inInstance, instanceType = IsInInstance()

	local startTimeMS = (select(4, UnitCastingInfo('target')) or select(4, UnitChannelInfo('target')) or 0)

	local elapsedTimeca = ((startTimeMS > 0) and (GetTime() * 1000 - startTimeMS) or 0)

	local elapsedTimech = ((startTimeMS > 0) and (GetTime() * 1000 - startTimeMS) or 0)

	channelTime = elapsedTimech / 1000

	castTime = elapsedTimeca / 1000

  castchannelTime = math.random(275, 500) / 1000

	isEnraged = (AuraUtil.FindAuraByName("Enrage", "target") or UnitChannelInfo("target") == "Ragestorm" or AuraUtil.FindAuraByName("Frenzy", "target"))

	SnDAS = select(16, AuraUtil.FindAuraByName("Slice and Dice", "player"))
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Out of Combat-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------=====-----------------------------------------------------------------------------------
if not Player:AffectingCombat() and Player:BuffDown(S.VanishBuff)  then
    -- if IsReady("Blade Flurry") and RangeCount(15) == 0 and (RangeCount(40) >= 1 or Player:CanAttack(Target)) and Player:BuffUp(S.AdrenalineRush) and S.UnderhandedUpperhand:IsAvailable() then
    --     return S.BladeFlurry:Cast()
    -- end
    
	if IsReady("Stealth") and not AuraUtil.FindAuraByName("Stealth", "player") and not Player:DebuffUp(S.KillingSpreeDamageDebuff) and (not IsResting() or target_is_dummy()) then
		return S.Stealth:Cast()
	end

  if inRange30 >= 1 and not targetRange8 and Player:IsMoving() then
    if IsReady("Adrenaline Rush") and RubimRH.CDsON() and not Finish_Condition() and S.UnderhandedUpperhand:IsAvailable() and Player:BuffDown(S.AdrenalineRush) and Player:StealthUp(true, true) and Player:BuffDown(S.VanishBuff) then
      return S.AdrenalineRush:Cast()
    end

    if IsReady("Slice and Dice") and Finish_Condition() and Player:BuffRemains(S.SliceandDice) < 8 and (not AuraUtil.FindAuraByName("Stealth", "player") or not Target:Exists()) then
      return S.SliceandDice:Cast()
    end

    if IsReady("Roll the Bones") and (RtB_Reroll() or RtB_Buffs()==0) then
      return S.RolltheBones:Cast()
    end
  end

	if IsReady("Crimson Vial") and inRange20 == 0 and Player:HealthPercentage() < 75 and Player:EnergyDeficit() == 0 then
		return S.CrimsonVial:Cast()
	end

  if not Player:IsMoving() then 
    if IsReady("Instant Poison") and CanCastWithTolerance("Instant Poison") and S.InstantPoison:TimeSinceLastCast() > 2 and Player:BuffDown(S.WoundPoison) and Player:BuffRemains(S.InstantPoison) < 300 and not Player:IsCasting(S.InstantPoison) then
      return S.InstantPoison:Cast()
    end

    if IsReady("Crippling Poison") and CanCastWithTolerance("Crippling Poison") and S.CripplingPoison:TimeSinceLastCast() > 2 and not S.NumbingPoison:IsAvailable() and not S.AtrophicPoison:IsAvailable() and Player:BuffDown(S.NumbingPoison) and Player:BuffDown(S.AtrophicPoison) and Player:BuffRemains(S.CripplingPoison) < 300 and not Player:IsCasting(S.CripplingPoison) then
      return S.CripplingPoison:Cast()
    end

    if IsReady("Atrophic Poison") and CanCastWithTolerance("Atrophic Poison") and S.AtrophicPoison:TimeSinceLastCast() > 2 and Player:BuffRemains(S.AtrophicPoison) < 300 and not Player:IsCasting(S.AtrophicPoison) then
      return S.AtrophicPoison:Cast()
    end

    if IsReady("Numbing Poison") and CanCastWithTolerance("Numbing Poison") and S.NumbingPoison:TimeSinceLastCast() > 2 and Player:BuffRemains(S.NumbingPoison) < 300 and not Player:IsCasting(S.NumbingPoison) then
      return S.NumbingPoison:Cast()
    end
  end
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Spell Queue---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------=====-----------------------------------------------------------------------------------

if S.lustAT:ID() == RubimRH.queuedSpell[1]:ID()
and Player:DebuffDown(S.lust1) and Player:DebuffDown(S.lust2) and Player:CanAttack(Target) and GetItemCount(219905) >= 1 and 
Player:DebuffDown(S.lust3) and Player:DebuffDown(S.lust4) and Player:DebuffDown(S.lust5)  then
return S.lustAT:Cast() -- BIND LUST KEYBIND IN BINDPAD TO ARCANE TORRENT
end

if S.lustAT:ID() == RubimRH.queuedSpell[1]:ID() and (Player:DebuffUp(S.lust1) or Player:DebuffUp(S.lust2) or Player:DebuffUp(S.lust3) or Player:DebuffUp(S.lust4) or Player:DebuffUp(S.lust5)) then
RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
end

if IsReady(RubimRH.queuedSpell[1]:ID(),nil,nil,1) and S.Blind:ID() == RubimRH.queuedSpell[1]:ID() and not Target:Exists() then
  RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
end
if IsReady(RubimRH.queuedSpell[1]:ID(),nil,nil,1) and S.KidneyShot:ID() == RubimRH.queuedSpell[1]:ID() and (Target:DebuffUp(S.CheapShot) or not targetRange20) then
  RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
end

if IsReady(RubimRH.queuedSpell[1]:ID(),nil,nil,1) and S.Feint:ID() == RubimRH.queuedSpell[1]:ID() and Player:BuffUp(S.Feint) then
    RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
end



if S.Ambush:ID() == RubimRH.queuedSpell[1]:ID() then
	if not TargetinRange(5) or not Player:CanAttack(Target) or not Player:StealthUp(true, true) then
		RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
	end
end

if S.Ambush:ID() == RubimRH.queuedSpell[1]:ID() then
	if IsReady("Blade Flurry") and not Player:BuffUp(S.BladeFlurry) and RangeCount(5) >= 2 then
		return S.BladeFlurry:Cast()
	end	
  if IsReady("Between the Eyes") and Finish_Condition() then
		return S.BetweentheEyes:Cast()
	end
	if IsReady("Ambush") then
		return S.Ambush:Cast()
	end	
end

if not RubimRH.queuedSpell[1]:CooldownUp() or not RubimRH.queuedSpell[1]:IsAvailable() or not Player:AffectingCombat()
or (S.KidneyShot:ID() == RubimRH.queuedSpell[1]:ID() and (Target:DebuffUp(S.CheapShot) or Target:DebuffUp(S.KidneyShot) or Target:DebuffUp(S.Blind) or Target:DebuffUp(S.Gouge))) 
or (S.Gouge:ID() == RubimRH.queuedSpell[1]:ID() and (Target:DebuffUp(S.CheapShot) or Target:DebuffUp(S.KidneyShot) or Target:DebuffUp(S.Blind))) then
	RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
end
if IsReady(RubimRH.queuedSpell[1]:ID(),nil,nil,1) then
    return RubimRH.QueuedSpell():Cast()
end



if isTanking == true and IsReady("Evasion") and inRange30 >= 1 and Player:HealthPercentage() <= 50 and Player:AffectingCombat() then
  return S.Evasion:Cast()
  end
  -- if IsReady("Crimson Vial") and inRange30 >= 1 and Player:HealthPercentage() <= 50 and Player:AffectingCombat() then
  --   return S.CrimsonVial:Cast()
  --   end
if IsReady("Cloak of Shadows") and inRange30 >= 1 and Player:HealthPercentage() <= 20 and Player:AffectingCombat() then
return S.CloakofShadows:Cast()
end

--health pot -- will need to update item ID of HPs as expansions progress
if inRange30 >= 1 and Player:HealthPercentage() <= 20 and Player:AffectingCombat() and (IsUsableItem(211880) == true and GetItemCooldown(211880) == 0 and GetItemCount(211880) >= 1 or IsUsableItem(211878) == true and GetItemCooldown(211878) == 0 and GetItemCount(211878) >= 1 or IsUsableItem(211879) == true and GetItemCooldown(211879) == 0 and GetItemCount(211879) >= 1) and (not Player:InArena() and not Player:InBattlegrounds()) then
	return I.HPIcon:Cast()
  end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Interrupts & Tranq--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------=====-----------------------------------------------------------------------------------
if RubimRH.InterruptsON() and not AuraUtil.FindAuraByName("Stealth", "player") and Player:CanAttack(Target) and Player:AffectingCombat() then
	--Kick
	if IsReady("Kick") and targetRange5 and (castTime > castchannelTime+0.5 or channelTime > castchannelTime+0.5) and select(8, UnitCastingInfo("target")) == false and not isEnraged and (Target:IsAPlayer() or kickprio()) then
		return S.Kick:Cast()
	end

	--Shiv
	if IsReady("Shiv") and targetRange5 and isEnraged then
		return S.Shiv:Cast()
	end
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Rotation------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------=====-----------------------------------------------------------------------------------
if Player:CanAttack(Target) and not Target:IsDeadOrGhost() and (Player:AffectingCombat() or Player:BuffUp(S.VanishBuff))  and not AuraUtil.FindAuraByName("Stealth", "player") then
	if not C_Spell.IsCurrentSpell(6603) and targetRange20 and Player:BuffDown(S.VanishBuff) and Player:BuffDown(S.Stealth) then
		return S.autoattack:Cast()
	end

  -- Fan the Hammer Combo Point Prediction
  if S.FantheHammer:IsAvailable() and S.PistolShot:TimeSinceLastCast() <= Player:GCDRemains() then
    ComboPoints = math.max(ComboPoints, FantheHammerCP())
    ComboPointsDeficit = Player:ComboPointsDeficit()
  end

	-- actions+=/call_action_list,name=cds
	if CDs() then
		return CDs()
	end

	--actions+=/call_action_list,name=stealth,if=stealthed.all
	if Stealth() and Player:StealthUp(true, true) then
		return Stealth()
	end

	--actions+=/run_action_list,name=finish,if=variable.Finish_Condition()
	if Finish() and Finish_Condition() then
		return Finish()
	end

	-- actions+=/call_action_list,name=build
	if Build() and not Finish_Condition() then
		return Build()
	end
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Out of Range--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------=====-----------------------------------------------------------------------------------
    if not TargetinRange(10) and Target:DebuffDown(S.Blind) and Player:CanAttack(Target) and not AuraUtil.FindAuraByName("Stealth", "player") and Player:BuffDown(S.VanishBuff) and Player:AffectingCombat() then
        if IsReady("Between the Eyes") and targetRange30 and EnergyTimeToMaxRounded() <= Player:GCD() and Finish_Condition() and S.Crackshot:IsAvailable() and (S.Vanish:CooldownRemains() > 45 and S.ShadowDance:CooldownRemains() > 15) then
            return S.BetweentheEyes:Cast()
        end

        if IsReady("Pistol Shot") and S.Ambush:TimeSinceLastCast()>0.5 and S.PistolShot:TimeSinceLastCast()>0.5 and S.BladeFlurry:TimeSinceLastCast()>0.5 and targetRange30 and Player:EnergyDeficitPredicted() < 25 and (Player:ComboPointsDeficit() >= 1 or EnergyTimeToMaxRounded() <= Player:GCD()) then
            return S.PistolShot:Cast()
        end
    end

    return 0, "Interface\\Addons\\Rubim-RH\\Media\\griph.tga"
end

RubimRH.Rotation.SetAPL(260, APL);

local function PASSIVE()

end

RubimRH.Rotation.SetPASSIVE(260, PASSIVE);