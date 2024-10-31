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
SummarilyDispatched    = Spell(381990),
KeepItRolling          = Spell(381989),
SSAudacity             = Spell(197834),
Audacity               = Spell(381845),
AudacityBuff           = Spell(386270),
SubterfugeBuff         = Spell(115192),
Subterfuge             = Spell(108208),
ThistleTea             = Spell(381623),
HiddenOpportunity      = Spell(383281),
autoattack             = Spell(274738), --ancestral call
ImprovedBetweentheEyes = Spell(235484),
ColdBlood              = Spell(382245),
ShadowDance            = Spell(185313),
ShadowDanceBuff        = Spell(185422),
DeftManeuvers          = Spell(381878),
AcrobaticStrikes       = Spell(196924),
LoadedDiceBuff         = Spell(256171),
EchoingReprimand       = Spell(470669),
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
KidneyShot             = Spell(408),
Deadshot               = Spell(272935),
Distract               = Spell(1725),
CoupdeGrace            = Spell(441776),
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
Shiv                   = Spell(5938),
WilloftheForsaken      = Spell(7744),
CloakofShadows         = Spell(31224),
Alacrity               = Spell(193539),
AlacrityBuff           = Spell(193538),
DeeperStratagem        = Spell(193531),
DeviousStratagem       = Spell(394321),
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
Blind                  = Spell(2094),
LoadedDice             = Spell(256170),
AceUpYourSleeve        = Spell(278676),
CheapShot              = Spell(1833),
CrimsonVial            = Spell(185311),
Feint                  = Spell(1966),
Gouge                  = Spell(1776),
Kick                   = Spell(1766),
Broadside              = Spell(193356),
BuriedTreasure         = Spell(199600),
GrandMelee             = Spell(193358),
SkullandCrossbones     = Spell(199603),
RuthlessPrecision      = Spell(193357),
TrueBearing            = Spell(193359),
Evasion                = Spell(5277),
WoundPoison            = Spell(8679),
Crackshot              = Spell(423703),
UnderhandedUpperhand   = Spell(424044),
Potion                 = Spell(176108),
HeartseekingHealthInjector = Spell(452831),
lust1    = Spell(57724),
lust2    = Spell(57723),
lust3    = Spell(80354),
lust4    = Spell(95809),
lust5    = Spell(264689),
lustAT                 = Spell(155145), --arcane torrent
Supercharger           = Spell(470347),
}

local S = RubimRH.Spell[260]

if not Item.Rogue then Item.Rogue = {}; end

Item.Rogue.Outlaw = {
  HPIcon = Item(169451),
};

local I = Item.Rogue.Outlaw;

local function num(val)
    if val then
        return 1
    else
        return 0
    end
end


--- As buff is "hidden" from the client but we get apply/refresh events for it
do
  local RtBExpiryTime = GetTime()
  function RtB_Remains(BypassRecovery)
    local Remains = RtBExpiryTime - GetTime() - HL.RecoveryOffset(BypassRecovery)
    return Remains >= 0 and Remains or 0
  end

  HL:RegisterForSelfCombatEvent(
    function(_, _, _, _, _, _, _, _, _, _, _, SpellID)
      if SpellID == 315508 then
        RtBExpiryTime = GetTime() + 30
      end
    end,
    "SPELL_AURA_APPLIED"
  )
  HL:RegisterForSelfCombatEvent(
    function(_, _, _, _, _, _, _, _, _, _, _, SpellID)
      if SpellID == 315508 then
        RtBExpiryTime = GetTime() + math.min(39, 30 + RtB_Remains(true))
      end
    end,
    "SPELL_AURA_REFRESH"
  )
  HL:RegisterForSelfCombatEvent(
    function(_, _, _, _, _, _, _, _, _, _, _, SpellID)
      if SpellID == 315508 then
        RtBExpiryTime = GetTime()
      end
    end,
    "SPELL_AURA_REMOVED"
  )
end


  -- 

-- Rotation Var
local ShouldReturn; --Used to get the return string
local ComboPoints, ComboPointsDeficit
local Energy, EnergyRegen, EnergyDeficit, EnergyTimeToMax, EnergyMaxOffset
-- Stable Energy Prediction
local PrevEnergyTimeToMaxPredicted, PrevEnergyPredicted = 0, 0
local function EnergyTimeToMaxStable(MaxOffset)
  local EnergyTimeToMaxPredicted = Player:EnergyTimeToMaxPredicted(nil, MaxOffset)
  if EnergyTimeToMaxPredicted < PrevEnergyTimeToMaxPredicted
    or (EnergyTimeToMaxPredicted - PrevEnergyTimeToMaxPredicted) > 0.5 then
    PrevEnergyTimeToMaxPredicted = EnergyTimeToMaxPredicted
  end
  return PrevEnergyTimeToMaxPredicted
end

local function EnergyPredictedStable()
  local EnergyPredicted = Player:EnergyPredicted()
  if EnergyPredicted > PrevEnergyPredicted
    or (EnergyPredicted - PrevEnergyPredicted) > 9 then
    PrevEnergyPredicted = EnergyPredicted
  end
  return PrevEnergyPredicted
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

RtB_BuffsList = {
  S.Broadside,
  S.BuriedTreasure,
  S.GrandMelee,
  S.RuthlessPrecision,
  S.SkullandCrossbones,
  S.TrueBearing
}

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
    local RtBRemains = RtB_Remains()
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

-- RtB rerolling strategy, return true if we should reroll
local function RtB_Reroll(ForceLoadedDice)
  if not Cache.APLVar.RtB_Reroll then
    
      Cache.APLVar.RtB_Reroll = false
      RtB_Buffs()
      -- # Variables that define the reroll rules for Roll the Bones Default rule: reroll if the only buff that will be rolled away is Buried Treasure, or Grand Melee in single target without upcoming adds
      -- actions+=/variable,name=rtb_reroll,value=rtb_buffs.will_lose=(rtb_buffs.will_lose.buried_treasure+rtb_buffs.will_lose.grand_melee
      -- &spell_targets.blade_flurry<2&raid_event.adds.in>12&raid_event.adds.count<2)
      Cache.APLVar.RtB_Reroll = RtB_Buffs() == num(checkBuffWillLose(S.BuriedTreasure)) + (num(checkBuffWillLose(S.GrandMelee) and num(EnemiesBFCount < 2)))

      -- # If Loaded Dice is talented, then keep any 1 buff from Roll the Bones but roll it into 2 buffs when Loaded Dice is active. Also reroll 2 buffs with loaded dice up if broadside, ruthless precision and true bearing are all missing and loaded dice is up
      -- actions+=/variable,name=rtb_reroll,if=talent.loaded_dice,value=(rtb_buffs.will_lose<=buff.loaded_dice.up)
      -- |buff.loaded_dice.up&rtb_buffs.will_lose<3&(!rtb_buffs.will_lose.broadside|buff.broadside.remains<11)
      -- &(!rtb_buffs.will_lose.ruthless_precision|buff.ruthless_precision.remains<11)&(!rtb_buffs.will_lose.true_bearing
      -- |buff.true_bearing.remains<11)
      Cache.APLVar.RtB_Reroll = S.LoadedDice:IsAvailable() and (Cache.APLVar.RtB_Buffs.Will_Lose.Total <= num(Player:BuffUp(S.LoadedDiceBuff) or ForceLoadedDice))
      or Player:BuffUp(S.LoadedDiceBuff) and Cache.APLVar.RtB_Buffs.Will_Lose.Total < 3 and (not checkBuffWillLose(S.Broadside) or Player:BuffRemains(S.Broadside) < 11)
      and (not checkBuffWillLose(S.RuthlessPrecision) or Player:BuffRemains(S.RuthlessPrecision) < 11) and (not checkBuffWillLose(S.TrueBearing) or Player:BuffRemains(S.TrueBearing) < 11)

      -- # If all active Roll the Bones buffs are ahead of its container buff and have under 40s remaining or with supercharger talented,
      -- then reroll again with Loaded Dice active in an attempt to get even more buffs
      -- actions+=/variable,name=rtb_reroll,value=variable.rtb_reroll&rtb_buffs.longer=0|rtb_buffs.normal=0&rtb_buffs.longer>=1
      -- &buff.loaded_dice.up&(rtb_buffs<6&rtb_buffs.max_remains<39|talent.supercharger)
      Cache.APLVar.RtB_Reroll = Cache.APLVar.RtB_Reroll and Cache.APLVar.RtB_Buffs.Longer == 0 or Cache.APLVar.RtB_Buffs.Normal == 0
        and Cache.APLVar.RtB_Buffs.Longer >= 1 and (Player:BuffUp(S.LoadedDiceBuff) or ForceLoadedDice)
        and (RtB_Buffs() <= 6 and Cache.APLVar.RtB_Buffs.MaxRemains <= 39 or S.Supercharger:IsAvailable())

      --# Non supercharger builds should avoid rerolls when we will not have time remaining on the fight or add wave to recoup the opportunity cost of the global
      -- actions+=/variable,name=rtb_reroll,op=reset,if=!talent.supercharger&!(raid_event.adds.remains>12|raid_event.adds.up
      -- &(raid_event.adds.in-raid_event.adds.remains)<6|target.time_to_die>12)|fight_remains<12
      if not S.Supercharger:IsAvailable() and (Target:FilteredTimeToDie("<", 12) or HL.BossFilteredFightRemains("<", 12)) then
        Cache.APLVar.RtB_Reroll = false
      end
    end
  

  return Cache.APLVar.RtB_Reroll
end



local function Finish_Condition()
  -- actions+=/variable,name=Finish_Condition(),value=combo_points>=cp_max_spend-1-(stealthed.all&talent.crackshot|
  -- (talent.hand_of_fate|talent.flawless_form)&talent.hidden_opportunity&(buff.audacity.up|buff.opportunity.up))
  return ComboPoints >= CPMaxSpend() - 1 - num((Player:StealthUp(true, true) and S.Crackshot:IsAvailable()
    or (S.HandOfFate:IsAvailable() or S.FlawlessForm:IsAvailable()) and S.HiddenOpportunity:IsAvailable()
    and (Player:BuffUp(S.AudacityBuff) or Player:BuffUp(S.Opportunity))))
end

local function Ambush_Condition()
  --ambush_condition,value=(talent.hidden_opportunity|combo_points.deficit>=2+talent.improved_ambush+buff.broadside.up)&energy>=50
  return (S.HiddenOpportunity:IsAvailable() or ComboPointsDeficit >= 2 + num(S.ImprovedAmbush:IsAvailable()) + num(Player:BuffUp(S.Broadside))) and Energy >= 50
end

local function Vanish_DPS_Condition()
  return (not Player:IsTanking(Target) and not Target:IsAPlayer()) or target_is_dummy()
end

local function Stealth()
  --cold_blood,if=variable.Finish_Condition()
  if IsReady("Cold Blood") and Player:BuffDown(S.ColdBlood) and TargetinRange(5) and Finish_Condition() then
    return S.ColdBlood:Cast()
  end
  --between_the_eyes,if=variable.Finish_Condition()&talent.crackshot&(!buff.shadowmeld.up|stealthed.rogue)
  if IsReady("Between the Eyes") and TargetinRange(30) and Finish_Condition() and S.Crackshot:IsAvailable() and (not Player:BuffUp(S.Shadowmeld) or Player:StealthUp(true, false)) then
    return S.BetweentheEyes:Cast()
  end
  --dispatch,if=variable.Finish_Condition()
  if IsReady("Dispatch") and TargetinRange(5) and Finish_Condition() then
    return S.Dispatch:Cast()
  end
  --pistol_shot,if=talent.crackshot&talent.fan_the_hammer.rank>=2&buff.opportunity.stack>=6&(buff.broadside.up&combo_points<=1|buff.greenskins_wickers.up)
  if IsReady("Pistol Shot") and C_Item.IsItemInRange(835, "target") and S.Crackshot:IsAvailable() and S.FantheHammer:TalentRank() >= 2 and Player:BuffStack(S.Opportunity) >= 6 and (Player:BuffUp(S.Broadside) and ComboPoints <= 1 or Player:BuffUp(S.GreenskinsWickersBuff)) then
    return S.PistolShot:Cast()
  end
  --***NOT PART of SimC*** Condition duplicated from build to Show SS Icon in stealth with audacity buff
  if IsReady("Ambush") and S.HiddenOpportunity:IsAvailable() and Player:BuffUp(S.AudacityBuff) then
    return S.SSAudacity:Cast()
  end
  --ambush,if=talent.hidden_opportunity
  if IsReady("Ambush") and TargetinRange(5) and S.HiddenOpportunity:IsAvailable() then
    return S.Ambush:Cast()
  end

  return nil
end
  
local function Finish()
  --between_the_eyes,if=!talent.crackshot&(buff.between_the_eyes.remains<4|talent.improved_between_the_eyes|talent.greenskins_wickers)&!buff.greenskins_wickers.up
  if IsReady("Between the Eyes") and TargetinRange(30) and not S.Crackshot:IsAvailable() and (Player:BuffRemains(S.BetweentheEyes) < 4 or S.ImprovedBetweenTheEyes:IsAvailable() or S.GreenskinsWickers:IsAvailable()) and Player:BuffDown(S.GreenskinsWickers) then
    return S.BetweentheEyes:Cast()
  end
  --between_the_eyes,if=talent.crackshot&(buff.ruthless_precision.up|buff.between_the_eyes.remains<4)
  if IsReady("Between the Eyes") and TargetinRange(30) and S.Crackshot:IsAvailable() and (Player:BuffUp(S.RuthlessPrecision) or Player:BuffRemains(S.BetweentheEyes) < 4) then
    return S.BetweentheEyes:Cast()
  end
  --cold_blood
  if IsReady("Cold Blood") and TargetinRange(5) then
    return S.ColdBlood:Cast()
  end
  --coup_de_grace
  if IsReady("Coup de Grace") and TargetinRange(5) then
    return S.CoupdeGrace:Cast()
  end
  --dispatch
  if IsReady("Dispatch") and TargetinRange(5) then
    return S.Dispatch:Cast()
  end

  return nil
end
  
local function StealthCDs()
  if TargetinRange(5) then
    --vanish,if=talent.underhanded_upper_hand&talent.subterfuge&talent.crackshot&buff.adrenaline_rush.up&variable.Finish_Condition()&(!cooldown.between_the_eyes.ready&buff.ruthless_precision.up|buff.adrenaline_rush.remains<3|buff.supercharge_1.up|buff.supercharge_2.up|cooldown.vanish.full_recharge_time<15|fight_remains<8)
    if IsReady("Vanish") and Vanish_DPS_Condition() and S.UnderhandedUpperhand:IsAvailable() and S.Subterfuge:IsAvailable() and S.Crackshot:IsAvailable() and Player:BuffUp(S.AdrenalineRush) and Finish_Condition() and (not IsReady("Between the Eyes") and Player:BuffUp(S.RuthlessPrecision) or Player:BuffRemains(S.AdrenalineRush) < 3 or Player:ChargedComboPoints() > 0 or S.Vanish:FullRechargeTime() < 15) then
      return S.Vanish:Cast()
    end
    --vanish,if=talent.underhanded_upper_hand&talent.subterfuge&!talent.crackshot&buff.adrenaline_rush.up&(variable.ambush_condition|!talent.hidden_opportunity)&(!cooldown.between_the_eyes.ready&buff.ruthless_precision.up|buff.ruthless_precision.down|buff.adrenaline_rush.remains<3)
    if IsReady("Vanish") and Vanish_DPS_Condition() and S.UnderhandedUpperhand:IsAvailable() and S.Subterfuge:IsAvailable() and not S.Crackshot:IsAvailable() and Player:BuffUp(S.AdrenalineRush) and (Ambush_Condition() or not S.HiddenOpportunity:IsAvailable()) and (not IsReady("Between the Eyes") and Player:BuffUp(S.RuthlessPrecision) or Player:BuffDown(S.RuthlessPrecision) or Player:BuffRemains(S.AdrenalineRush)) then
      return S.Vanish:Cast()
    end
    --vanish,if=!talent.underhanded_upper_hand&!talent.crackshot&talent.hidden_opportunity&!buff.audacity.up&buff.opportunity.stack<buff.opportunity.max_stack&variable.ambush_condition
    if IsReady("Vanish") and Vanish_DPS_Condition() and not S.UnderhandedUpperhand:IsAvailable() and not S.Crackshot:IsAvailable() and S.HiddenOpportunity:IsAvailable() and Player:BuffDown(S.AudacityBuff) and Player:BuffStack(S.Opportunity) < 6 and Ambush_Condition() then
      return S.Vanish:Cast()
    end
    --vanish,if=!talent.underhanded_upper_hand&!talent.crackshot&!talent.hidden_opportunity&talent.fateful_ending&(!buff.fatebound_lucky_coin.up&(buff.fatebound_coin_tails.stack>=5|buff.fatebound_coin_heads.stack>=5)|buff.fatebound_lucky_coin.up&!cooldown.between_the_eyes.ready)
    if IsReady("Vanish") and Vanish_DPS_Condition() and not S.UnderhandedUpperhand:IsAvailable() and not S.Crackshot:IsAvailable() and not S.HiddenOpportunity():IsAvailable() and not S.FatefulEnding:IsAvailable() and (Player:BuffDown(S.LuckyCoin) and (FBcoinTailsstacks >= 5 or FBcoinHeadsstacks >= 5) or Player:BuffUp(S.LuckyCoin) and not IsReady("Between the Eyes")) then
      return S.Vanish:Cast()
    end
    --vanish,if=!talent.underhanded_upper_hand&!talent.crackshot&!talent.hidden_opportunity&!talent.fateful_ending&talent.take_em_by_surprise&!buff.take_em_by_surprise.up
    if IsReady("Vanish") and Vanish_DPS_Condition() and not S.UnderhandedUpperhand:IsAvailable() and not S.Crackshot:IsAvailable() and not S.HiddenOpportunity:IsAvailable() and not S.FatefulEnding:IsAvailable() and S.TakeEmBySurprise:IsAvailable() and Player:BuffDown(S.TakeEmBySurpriseBuff) then
      return S.Vanish:Cast()
    end
  end

  return nil
end

local function CDs()
  --adrenaline_rush,if=!buff.adrenaline_rush.up&(!variable.Finish_Condition()|!talent.improved_adrenaline_rush)|talent.crackshot&talent.improved_adrenaline_rush&combo_points<=2&!buff.loaded_dice.up
  if IsReady("Adrenaline Rush") and TargetinRange(5) and RubimRH.CDsON() and (not Player:BuffUp(S.AdrenalineRush) and (not Finish_Condition() or not S.ImprovedAdrenalineRush:IsAvailable()) or S.Crackshot:IsAvailable() and S.ImprovedAdrenalineRush:IsAvailable() and ComboPoints <= 2 and not Player:BuffUp(S.LoadedDiceBuff)) then
    return S.AdrenalineRush:Cast() 
  end 
  --blade_flurry,if=spell_targets>=2&buff.blade_flurry.remains<gcd
  if IsReady("Blade Flurry") then
    if RangeCount(8) >= 2 and Player:BuffRemains(S.BladeFlurry) < Player:GCD() then
      return S.BladeFlurry:Cast()
    end
  end
  --blade_flurry,if=talent.deft_maneuvers&!variable.Finish_Condition()&(spell_targets>=3&combo_points.deficit=spell_targets+buff.broadside.up|spell_targets>=5)
  if IsReady("Blade Flurry") then
    if S.DeftManeuvers:IsAvailable() and not Finish_Condition() and (RangeCount(8) >= 3 and ComboPointsDeficit == RangeCount(8) + num(Player:BuffUp(S.Broadside)) or RangeCount(8) >= 5) then
      return S.BladeFlurry:Cast()
    end
  end
  --roll_the_bones,if=variable.rtb_reroll|rtb_buffs=0
  if IsReady("Roll the Bones") then
    if (RtB_Reroll() or RtB_Buffs() == 0)  then
      return S.RolltheBones:Cast()
    end
  end
  --keep_it_rolling,if=rtb_buffs>=4&(rtb_buffs.min_remains<2|buff.broadside.up)
   if IsReady("Keep It Rolling") and RtB_Buffs() >= 4 and (Cache.APLVar.RtB_Buffs.MinRemains < 2 or Player:BuffUp(S.Broadside)) then
    return S.KeepItRolling:Cast()
  end 
  --ghostly_strike,if=combo_points<cp_max_spend
   if IsReady("Ghostly Strike") and TargetinRange(5) and Player:ComboPoints() < CPMaxSpend() then
    return S.GhostlyStrike:Cast()
  end 
  --killing_spree,if=variable.Finish_Condition()&!stealthed.all
   if IsReady("Killing Spree") and TargetinRange(10) and RubimRH.CDsON() and Finish_Condition() and not Player:StealthUp(true, true) then
    return S.KillingSpree:Cast()
  end 
  --call_action_list,name=stealth_cds,if=!stealthed.all
  if RubimRH.CDsON() and not Player:StealthUp(true, true)  then
    ShouldReturn = StealthCDs()
    if ShouldReturn then return ShouldReturn end
  end 
  --blade_rush,if=energy.base_time_to_max>4&!stealthed.all  
  if IsReady("Blade Rush") and TargetinRange(5) and EnergyTimeToMax > 4 and not Player:StealthUp(true, true) then
    return S.BladeRush:Cast()
  end
  if RubimRH.CDsON() and TargetinRange(5) and Player:BuffUp(S.BetweentheEyes) then
    if Player:BuffRemains(S.SubterfugeBuff) >= 4 and not AuraUtil.FindAuraByName("Tempered Potion", "player") and not target_is_dummy() then
      if ((IsUsableItem(212263) == true and GetItemCooldown(212263) == 0 and GetItemCount(212263) >= 1) 
      or (IsUsableItem(212264) == true and GetItemCooldown(212264) == 0 and GetItemCount(212264) >= 1)
      or (IsUsableItem(212265) == true and GetItemCooldown(212265) == 0 and GetItemCount(212265) >= 1)) then
          return S.Potion:Cast()
      end
    end
    --use_items,slots=trinket1,if=buff.between_the_eyes.up|trinket.1.has_stat.any_dps|fight_remains<=20
    if trinket1ready then
      return Item(118330):Cast()
    end
    --use_items,slots=trinket2,if=buff.between_the_eyes.up|trinket.2.has_stat.any_dps|fight_remains<=20
    if trinket2ready then
        return Item(114616):Cast()
    end
  end

  return nil
end

local function Build()
  --ambush,if=talent.hidden_opportunity&buff.audacity.up
  if IsReady("Ambush") and TargetinRange(5) and S.HiddenOpportunity:IsAvailable() and Player:BuffUp(S.AudacityBuff) then
    return S.Ambush:Cast()
  end
  --pistol_shot,if=talent.fan_the_hammer&talent.audacity&talent.hidden_opportunity&buff.opportunity.up&!buff.audacity.up
  if IsReady("Pistol Shot") and TargetinRange(30) and S.FantheHammer:IsAvailable() and S.Audacity:IsAvailable() and S.HiddenOpportunity:IsAvailable() and Player:BuffUp(S.Opportunity) and Player:BuffDown(S.AudacityBuff) then
    return S.PistolShot:Cast()
  end
  --pistol_shot,if=talent.fan_the_hammer&buff.opportunity.up&(buff.opportunity.stack>=buff.opportunity.max_stack|buff.opportunity.remains<2)
  if IsReady("Pistol Shot") and TargetinRange(30) and S.FantheHammer:IsAvailable() and Player:BuffUp(S.Opportunity) and (Player:BuffStack(S.Opportunity) >= 6 or Player:BuffRemains(S.Opportunity) < 2) then
    return S.PistolShot:Cast()
  end
  --pistol_shot,if=talent.fan_the_hammer&buff.opportunity.up&(combo_points.deficit>=(1+(talent.quick_draw+buff.broadside.up)*(talent.fan_the_hammer.rank+1))|combo_points<=talent.ruthlessness)
  if IsReady("Pistol Shot") and TargetinRange(30) and S.FantheHammer:IsAvailable() and Player:BuffUp(S.Opportunity) and (ComboPointsDeficit>=(1+(num(S.QuickDraw:IsAvailable())+num(Player:BuffUp(S.Broadside)))*(S.FantheHammer:TalentRank() + 1)) or ComboPoints <= num(S.Ruthlessness:IsAvailable())) then
    return S.PistolShot:Cast()
  end
  --pistol_shot,if=!talent.fan_the_hammer&buff.opportunity.up&(energy.base_deficit>energy.regen*1.5|combo_points.deficit<=1+buff.broadside.up|talent.quick_draw.enabled|talent.audacity.enabled&!buff.audacity.up)
  if IsReady("Pistol Shot") and TargetinRange(30) and not S.FantheHammer:IsAvailable() and Player:BuffUp(S.Opportunity) and (EnergyDeficit > EnergyRegen*1.5 or ComboPointsDeficit <= 1 + num(Player:BuffUp(S.Broadside)) or S.QuickDraw:IsAvailable() or S.Audacity:IsAvailable() and Player:BuffDown(S.AudacityBuff)) then
    return S.PistolShot:Cast()
  end
  if Player:BuffUp(S.AudacityBuff) and Player:Energy() < 50 and S.HiddenOpportunity:IsAvailable() then
    return 0, "Interface\\Addons\\Rubim-RH\\Media\\griph.tga"
    --ambush,if=talent.hidden_opportunity&buff.audacity.up
  elseif IsReady("Ambush") and S.HiddenOpportunity:IsAvailable() and TargetinRange(5) then
    return S.Ambush:Cast()
  end
  --sinister_strike
  if IsReady("Sinister Strike") and TargetinRange(5) then
      return S.SinisterStrike:Cast()
  end

  return nil
end

local function APL()
--RtB_Buffs()
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Functions & Variables-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
if Player:IsCasting() or Player:IsChanneling() then
	return 0, "Interface\\Addons\\Rubim-RH\\Media\\channel.tga"
elseif Player:IsDeadOrGhost() or AuraUtil.FindAuraByName("Drink", "player") or AuraUtil.FindAuraByName("Food", "player") or AuraUtil.FindAuraByName("Food and Drink", "player") or (IsResting("player") and not Player:CanAttack(Target)) then
  return 0, "Interface\\Addons\\Rubim-RH\\Media\\griph.tga"
end

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

local FBcoinbuff = (AuraUtil.FindAuraByName('Fatebound Coin (Heads)','player') or AuraUtil.FindAuraByName('Fatebound Coin (Tails)','player'))

local isTanking, status, threatpct, rawthreatpct, threatvalue = UnitDetailedThreatSituation("player", "target")

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

ComboPoints = Player:ComboPoints()

ComboPointsDeficit = Player:ComboPointsDeficit()


EnergyMaxOffset = Player:BuffUp(S.AdrenalineRush, nil, true) and -50 or 0 -- For base_time_to_max emulation

Energy = EnergyPredictedStable()

EnergyRegen = Player:EnergyRegen()

EnergyTimeToMax = EnergyTimeToMaxStable(EnergyMaxOffset) -- energy.base_time_to_max

EnergyDeficit = Player:EnergyDeficitPredicted(nil, EnergyMaxOffset) -- energy.base_deficit

startTimeMS = (select(4, UnitCastingInfo('target')) or select(4, UnitChannelInfo('target')) or 0)

elapsedTimeca = ((startTimeMS > 0) and (GetTime() * 1000 - startTimeMS) or 0)

elapsedTimech = ((startTimeMS > 0) and (GetTime() * 1000 - startTimeMS) or 0)

channelTime = elapsedTimech / 1000

castTime = elapsedTimeca / 1000

castchannelTime = math.random(275, 500) / 1000

isEnraged = (AuraUtil.FindAuraByName("Enrage", "target") or UnitChannelInfo("target") == "Ragestorm" or AuraUtil.FindAuraByName("Frenzy", "target"))

local level, affixIDs, wasEnergized = C_ChallengeMode.GetActiveKeystoneInfo()

--local SnDAS = select(16, AuraUtil.FindAuraByName("Slice and Dice", "player"))
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Out of Combat-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
if not Player:AffectingCombat() and Player:BuffDown(S.VanishBuff) then
  if RangeCount(30) >= 1 and not TargetinRange(5) and Player:IsMoving() then
    if IsReady("Roll the Bones") and (RtB_Reroll() or RtB_Buffs() == 0) then
      return S.RolltheBones:Cast()
    end
  end

	if IsReady("Stealth") and not AuraUtil.FindAuraByName("Stealth", "player") and not Player:BuffUp(S.VanishBuff) and not Player:BuffUp(S.VanishBuff2) and not Player:DebuffUp(S.KillingSpreeDamageDebuff) and not Player:DebuffUp(S.HeartseekingHealthInjector) then
		return S.Stealth:Cast()
	end

  if IsReady("Adrenaline Rush") and RubimRH.CDsON() and not Finish_Condition() and S.UnderhandedUpperhand:IsAvailable() and Player:BuffDown(S.AdrenalineRush) and Player:BuffDown(S.VanishBuff) then
    return S.AdrenalineRush:Cast()
  end

	if IsReady("Crimson Vial") and RangeCount(20) == 0 and Player:HealthPercentage() < 75 and Player:EnergyDeficit() == 0 then
		return S.CrimsonVial:Cast()
	end

  if not Player:IsMoving() and not Player:AffectingCombat() then 
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
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
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
	if IsReady("Ambush") and S.HiddenOpportunity:IsAvailable() then
		return S.Ambush:Cast()
  elseif IsReady("Sinister Strike") and not S.HiddenOpportunity:IsAvailable() then
    return S.SinisterStrike:Cast()
	end	
end

if S.lustAT:ID() == RubimRH.queuedSpell[1]:ID()
and Player:DebuffDown(S.lust1) and Player:DebuffDown(S.lust2) and Player:CanAttack(Target) and GetItemCount(219905) >= 1 and 
Player:DebuffDown(S.lust3) and Player:DebuffDown(S.lust4) and Player:DebuffDown(S.lust5)  then
return S.lustAT:Cast() -- BIND LUST KEYBIND IN BINDPAD TO ARCANE TORRENT
end

if S.lustAT:ID() == RubimRH.queuedSpell[1]:ID() and (Player:DebuffUp(S.lust1) or Player:DebuffUp(S.lust2) or Player:DebuffUp(S.lust3) or Player:DebuffUp(S.lust4) or Player:DebuffUp(S.lust5)) then
RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
end

if not RubimRH.queuedSpell[1]:CooldownUp() or not RubimRH.queuedSpell[1]:IsAvailable() or not Player:AffectingCombat()
or (S.KidneyShot:ID() == RubimRH.queuedSpell[1]:ID() and (Target:DebuffUp(S.CheapShot) or Target:DebuffUp(S.KidneyShot) or Target:DebuffUp(S.Blind) or Target:DebuffUp(S.Gouge))) 
or (S.Gouge:ID() == RubimRH.queuedSpell[1]:ID() and (Target:DebuffUp(S.CheapShot) or Target:DebuffUp(S.KidneyShot) or Target:DebuffUp(S.Blind))) then
	RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
end

if IsReady(RubimRH.queuedSpell[1]:ID(),nil,nil,1) and S.Ambush:ID() ~= RubimRH.queuedSpell[1]:ID() then
    return RubimRH.QueuedSpell():Cast()
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Interrupts & Defensives---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
if Player:HealthPercentage() <= 20 and Player:AffectingCombat() and (not Player:InArena() and not Player:InBattlegrounds()) then
  if (IsUsableItem(211878) == true and GetItemCooldown(211878) == 0 and GetItemCount(211878) >= 1) 
  or (IsUsableItem(211879) == true and GetItemCooldown(211879) == 0 and GetItemCount(211879) >= 1)
  or (IsUsableItem(211880) == true and GetItemCooldown(211880) == 0 and GetItemCount(211880) >= 1)
    --hp wrists
  or (IsUsableItem(221806) == true and GetItemCooldown(221806) == 0) then
      return I.HPIcon:Cast()
  end
end

if RubimRH.InterruptsON() and not AuraUtil.FindAuraByName("Stealth", "player") and Player:CanAttack(Target) and Player:AffectingCombat() then
	--Kick
	if IsReady("Kick") and TargetinRange(5) and (castTime > castchannelTime+0.5 or channelTime > castchannelTime+0.5) and select(8, UnitCastingInfo("target")) == false and not isEnraged then
		return S.Kick:Cast()
	end
	--Shiv
	if IsReady("Shiv") and TargetinRange(5) and isEnraged then
		return S.Shiv:Cast()
	end
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Rotation------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
if UnitCanAttack('player','target') and not Target:IsDeadOrGhost() and (not AuraUtil.FindAuraByName("Stealth", "player") or Player:BuffUp(S.VanishBuff)) and ((Target:AffectingCombat() or target_is_dummy() or Player:BuffUp(S.VanishBuff)) or C_Spell.IsCurrentSpell(6603)) then
  if not C_Spell.IsCurrentSpell(6603) and C_Item.IsItemInRange(10645, "target") and Player:BuffDown(S.VanishBuff) and Player:BuffDown(S.Stealth) and Player:AffectingCombat() then
		return S.autoattack:Cast()
	end

  
if (isTanking == true or Player:IsTankingAoE(8)) and IsReady("Evasion") and RangeCount(30) and Player:HealthPercentage() <= 50 and Player:AffectingCombat() then
  return S.Evasion:Cast()
  end
  -- if IsReady("Crimson Vial") and inRange30 >= 1 and Player:HealthPercentage() <= 50 and Player:AffectingCombat() then
  --   return S.CrimsonVial:Cast()
  --   end
if IsReady("Cloak of Shadows") and RangeCount(30) >= 1 and Player:HealthPercentage() <= 20 and Player:AffectingCombat() then
return S.CloakofShadows:Cast()
end

  -- Fan the Hammer Combo Point Prediction
  if S.FantheHammer:IsAvailable() and S.PistolShot:TimeSinceLastCast() <= Player:GCDRemains() then
    ComboPoints = math.max(ComboPoints, FantheHammerCP())
    ComboPointsDeficit = Player:ComboPointsDeficit()
  end
	-- actions+=/call_action_list,name=cds
	if CDs() and RubimRH.CDsON() then
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

  return 0, "Interface\\Addons\\Rubim-RH\\Media\\griph.tga"
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Out of Range--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------=====-----------------------------------------------------------------------------------
if not TargetinRange(5) and Target:AffectingCombat() and Target:DebuffDown(S.Blind) and Player:CanAttack(Target) and not AuraUtil.FindAuraByName("Stealth", "player") and Player:BuffDown(S.VanishBuff) and Player:AffectingCombat() then
    if IsReady("Between the Eyes") and C_Item.IsItemInRange(835, "target") and EnergyTimeToMaxRounded() <= Player:GCD() and Finish_Condition() and S.Crackshot:IsAvailable() and (S.Vanish:CooldownRemains() > 45 and S.ShadowDance:CooldownRemains() > 15) then
        return S.BetweentheEyes:Cast()
    end

    if IsReady("Pistol Shot") and S.Ambush:TimeSinceLastCast() > 0.5 and S.PistolShot:TimeSinceLastCast() > 0.5 and S.BladeFlurry:TimeSinceLastCast() > 0.5 and C_Item.IsItemInRange(835, "target") and Player:EnergyDeficitPredicted() < 25 and (Player:ComboPointsDeficit() >= 1 or EnergyTimeToMaxRounded() <= Player:GCD()) then
        return S.PistolShot:Cast()
    end
end

    return 0, "Interface\\Addons\\Rubim-RH\\Media\\griph.tga"
end

RubimRH.Rotation.SetAPL(260, APL);

local function PASSIVE()

end

RubimRH.Rotation.SetPASSIVE(260, PASSIVE);