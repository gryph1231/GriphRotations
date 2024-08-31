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
local Delay      = C_Timer.After;
-- Lua
local pairs = pairs;
local tableconcat = table.concat;
local tostring = tostring;
local tableinsert = table.insert;

if not Spell.Warrior then
Spell.Warrior = {};
end



RubimRH.Spell[72] = {
autoattack = Spell(274738), --ancestral call
lust1 = Spell(57724),
lust2 = Spell(57723),
lust3 = Spell(80354),
lust4 = Spell(95809),
lust5 = Spell(264689),
lustAT = Spell(28730), -- arcane turrent

--Fireblood                             = Spell(265221), used for bloodthirst and bloodbath until ggl fixed pixels

-- Racials
AncestralCall                         = Spell(274738),
ArcaneTorrent                         = Spell(50613),
BagofTricks                           = Spell(312411),
Berserking                            = Spell(26297),
BloodFury                             = Spell(20572),
LightsJudgment                        = Spell(255647),
-- Abilities
BattleShout                           = Spell(6673),
BattleStance                          = Spell(386164),
Charge                                = Spell(100),
HeroicThrow                           = Spell(57755),
Pummel                                = Spell(6552),
Slam                                  = Spell(1464),
VictoryRush                           = Spell(34428),
EnragedRegeneration = Spell(184364),
DefensiveStance                       = Spell(386208),
-- Talents
Avatar                                = Spell(107574),
BerserkerRage                         = Spell(18499),
BerserkersTorment                     = Spell(390123),
Bladestorm                            = MultiSpell(227847, 389774),
BloodandThunder                       = Spell(384277),
ChampionsSpear                        = Spell(376079),
DoubleTime                            = Spell(103827),
CrushingForce                         = Spell(382764),
FrothingBerserker                     = Spell(215571),
Hurricane                             = Spell(390563),
ImmovableObject                       = Spell(394307),
IntimidatingShout                     = Spell(5246),
HeroicLeap                            = Spell(6544),
ImpendingVictory                      = Spell(202168),
OverwhelmingRage                      = Spell(382767),
RallyingCry                           = Spell(97462),
Ravager                               = Spell(228920),
RumblingEarth                         = Spell(275339),
Shockwave                             = Spell(46968),
SonicBoom                             = Spell(390725),
SpellReflection                       = Spell(23920),
StormBolt                             = Spell(107570),
ThunderClap                           = Spell(6343),
ThunderousRoar                        = Spell(384318),
TitanicThrow                          = Spell(384090),
WreckingThrow                         = Spell(384110),
-- Buffs
AvatarBuff                            = Spell(107574),
BattleShoutBuff                       = Spell(6673),
ChampionsMightBuff                    = Spell(386286),
HurricaneBuff                         = Spell(390581),
WarMachineBuff                        = Spell(262232),
-- Debuffs
ChampionsMightDebuff                  = Spell(376080),
MarkofFyralathDebuff                  = Spell(414532),
ThunderousRoarDebuff                  = Spell(397364),
-- Pool
Pool                                  = Spell(999910),



-- Abilities
BerserkerStance                       = Spell(386196),
Bloodbath                             = Spell(335096),
CrushingBlow                          = Spell(335097),
Execute                               = MultiSpell(5308, 280735),
Whirlwind                             = Spell(190411),
-- Talents
AngerManagement                       = Spell(152278),
AshenJuggernaut                       = Spell(392536),
Bloodthirst                           = Spell(23881),
DancingBlades                         = Spell(391683),
ImprovedWhilwind                      = Spell(12950),
Massacre                              = Spell(206315),
OdynsFury                             = Spell(385059),
Onslaught                             = Spell(315720),
RagingBlow                            = Spell(85288),
Rampage                               = Spell(184367),
RecklessAbandon                       = Spell(396749),
Recklessness                          = Spell(1719),
Tenderize                             = Spell(388933),
TitanicRage                           = Spell(394329),
TitansTorment                         = Spell(390135),
WrathandFury                          = Spell(392936),
-- Buffs
AshenJuggernautBuff                   = Spell(392537),
BloodcrazeBuff                        = Spell(393951),
DancingBladesBuff                     = Spell(391688),
EnrageBuff                            = Spell(184362),
FuriousBloodthirstBuff                = Spell(423211), -- T31 2pc
MeatCleaverBuff                       = Spell(85739),
MercilessAssaultBuff                  = Spell(409983),
RecklessnessBuff                      = Spell(1719),
SuddenDeathBuff                       = Spell(280776),
-- Debuffs
GushingWoundDebuff                    = Spell(385042),
OdynsFuryDebuff                       = Spell(385060),



-- Abilities
ThunderBlastAbility                   = Spell(435222),
-- Talents
CrashingThunder                       = Spell(436707),
ThunderBlast                          = Spell(435607),
-- Buffs
BurstofPowerBuff                      = Spell(437121),
ThunderBlastBuff                      = Spell(435615),




}


local S = RubimRH.Spell[72]


S.Bloodbath.TextureSpellID = { 265221 }
S.Bloodthirst.TextureSpellID = { 265221 }
S.Ravager.TextureSpellID = { 228920 }
S.Bladestorm.TextureSpellID = { 228920 }

if not Item.Warrior then Item.Warrior = {}; end

Item.Warrior.Fury = {
  drums = Item(193470),

HPIcon = Item(169451),
};

local I = Item.Warrior.Fury;

local function num(val)
  if val then
      return 1
  else
      return 0
  end
end




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

if AuraUtil.FindAuraByName("Battle Shout","player") then
battleshoutremains = select(6,AuraUtil.FindAuraByName("Battle Shout","player")) - GetTime()
else
battleshoutremains = 0
end
local bloodbath = AuraUtil.FindAuraByName("Bloodbath","player") 
local level, affixIDs, wasEnergized = C_ChallengeMode.GetActiveKeystoneInfo()
local EnrageUp = AuraUtil.FindAuraByName("Enrage","player")

HPpercentloss = MyHealthTracker.GetPredictedHealthLoss() * 3

validmobsinrange8y = combatmobs40() * .6
validmobsinrange30y = combatmobs40() * .6
validmobsinrange10y = combatmobs40() * .6

if (inRange10 > validmobsinrange10y or instanceType=='raid') and combatmobs40() > 0 then
  aoecds10y = true
  else
    aoecds10y = false
  end
  


-- print(IsReady("Execute") and S.Execute:CooldownRemains()<0.55)

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
if inRange30 >= 1 and Player:AffectingCombat() then
if Player:HealthPercentage()<=30 and  (IsUsableItem(191380) == true and
GetItemCooldown(191380) == 0 and GetItemCount(191380) >= 1 or IsUsableItem(207023) == true and
GetItemCooldown(207023) == 0 and GetItemCount(207023) >= 1)
and (not Player:InArena() and not Player:InBattlegrounds()) then
return I.HPIcon:Cast()
end


if IsReady("Rallying Cry") and Player:HealthPercentage()<50 then
  return S.RallyingCry:Cast()
end

if IsReady("Enraged Regeneration") and Player:HealthPercentage()<50 then
  return S.EnragedRegeneration:Cast()
end

if IsReady("Spell Reflection") and Player:HealthPercentage()<20 then
  return S.SpellReflection:Cast()
end

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

if (not IsReady(RubimRH.queuedSpell[1]:ID(),nil,nil,1) or not Player:AffectingCombat() or inRange30 == 0 or not Target:Exists()) then
  RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
  end
if IsReady(RubimRH.queuedSpell[1]:ID(),nil,nil,1) then
return RubimRH.QueuedSpell():Cast()
end




-- print('aoecds10y:',aoecds10y)
-- print('bs is ready:',S.Bladestorm:IsCastable())
-- print('avatar cd remains>9:',S.Avatar:CooldownRemains() >= 9)


if Player:IsCasting() or Player:IsChanneling() then
return 0, "Interface\\Addons\\Rubim-RH\\Media\\channel.tga"
elseif Player:IsDeadOrGhost() or AuraUtil.FindAuraByName("Drink", "player") or AuraUtil.FindAuraByName("Food", "player") or AuraUtil.FindAuraByName("Food & Drink", "player") then
return 0, "Interface\\Addons\\Rubim-RH\\Media\\griph.tga"
end 



-- --------------------------------------------------------------------------------------------------------------------------------------------
-- ----------------------------------------------------------Interrupts------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------------------------------------------------
if RubimRH.InterruptsON() and Player:CanAttack(Target) and Player:AffectingCombat()  then
--Kick
if IsReady("Pummel") 
and kickprio() and targetRange8 and (castTime > castchannelTime+0.5 or channelTime > castchannelTime+0.5)  and select(8, UnitCastingInfo("target")) == false  and not isEnraged then
return S.Pummel:Cast()
end

if IsReady("Storm Bolt") 
and stunprio() and targetRange20 and (castTime > castchannelTime+0.5 or channelTime > castchannelTime+0.5)  and select(8, UnitCastingInfo("target")) == false  and not isEnraged then
return S.StormBolt:Cast()
end

end


-- --------------------------------------------------------------------------------------------------------------------------------------------
-- ----------------------------------------------------------Rotation--------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------------------------------------------------
if (Target:AffectingCombat() or Player:AffectingCombat()) and Player:CanAttack(Target) and not Target:IsDeadOrGhost() and targetRange10 then 
if not C_Spell.IsCurrentSpell(6603) and targetRange20 then
return S.autoattack:Cast()
end


if Player:HealthPercentage() <=60 then
if IsReady("Victory Rush") and not S.ImpendingVictory:IsAvailable() then
return S.VictoryRush:Cast()
end
if IsReady("Impending Victory")   then
return S.ImpendingVictory:Cast()
end
end

if RubimRH.CDsON() then
local ShouldReturn = UseItems();
if ShouldReturn then return ShouldReturn; end

end

if inRange10>=2 and RubimRH.AoEON() then

    -- whirlwind,if=buff.meat_cleaver.stack=0&talent.improved_whirlwind
    if IsReady("Whirlwind") and (Player:BuffDown(S.MeatCleaverBuff) and S.ImprovedWhilwind:IsAvailable()) then
      return S.Whirlwind:Cast()
    end
  -- recklessness,if=(!talent.anger_management&cooldown.avatar.remains<1&talent.titans_torment)|talent.anger_management|!talent.titans_torment
  if RubimRH.CDsON() and Player:PrevGCD(1, S.Rampage)   and IsReady("Recklessness") and ((not S.AngerManagement:IsAvailable() and S.Avatar:CooldownRemains() < 1 and S.TitansTorment:IsAvailable()) or S.AngerManagement:IsAvailable() or not S.TitansTorment:IsAvailable()) then
    return S.Recklessness:Cast()
  end
  -- avatar,if=talent.titans_torment&(buff.enrage.up|talent.titanic_rage)|!talent.titans_torment
  if RubimRH.CDsON() and S.Recklessness:CooldownDown()   and IsReady("Avatar") and (S.TitansTorment:IsAvailable() and (EnrageUp or S.TitanicRage:IsAvailable()) or not S.TitansTorment:IsAvailable()) then
    return S.Avatar:Cast()
  end
  -- thunderous_roar,if=buff.enrage.up
  if RubimRH.CDsON() and S.OdynsFury:CooldownDown()   and IsReady("Thunderous Roar") and (EnrageUp) then
    return S.ThunderousRoar:Cast()
  end
  -- champions_spear,if=buff.enrage.up
  if IsReady("Champion's Spear") and (EnrageUp) then
    return S.ChampionsSpear:Cast()
  end
  -- odyns_fury,if=dot.odyns_fury_torment_mh.remains<1&(buff.enrage.up|talent.titanic_rage)&cooldown.avatar.remains
  if RubimRH.CDsON() and S.Recklessness:CooldownDown()   and IsReady("Odyn's Fury") and (Target:DebuffRemains(S.OdynsFuryDebuff) < 1 and (EnrageUp or S.TitanicRage:IsAvailable()) and S.Avatar:CooldownDown()) then
    return S.OdynsFury:Cast()
  end

  -- execute,if=buff.enrage.up&buff.ashen_juggernaut.remains<=gcd&talent.ashen_juggernaut
  if IsReady("Execute")  and S.Execute:CooldownRemains()<0.6  and (EnrageUp and Player:BuffRemains(S.AshenJuggernautBuff) <= Player:GCD() and S.AshenJuggernaut:IsAvailable()) then
    return S.Execute:Cast()
  end
  -- rampage,if=rage.pct>85&cooldown.bladestorm.remains<=gcd&!debuff.champions_might.up
  if IsReady("Rampage") and (Player:RagePercentage() > 85 and S.Bladestorm:CooldownRemains() <= Player:GCD() and Target:DebuffDown(S.ChampionsMightDebuff)) then
    return S.Rampage:Cast()
  end
  -- bladestorm,if=buff.enrage.up&cooldown.avatar.remains>=9
  if RubimRH.CDsON() and S.ThunderousRoar:CooldownDown()   and IsReady("Bladestorm") and (EnrageUp and S.Avatar:CooldownRemains() >= 9) and S.OdynsFury:CooldownRemains()>Player:GCD() and S.ThunderousRoar:CooldownRemains()>Player:GCD() then
    return S.Bladestorm:Cast()
  end
  -- ravager,if=buff.enrage.up
  if IsReady("Ravager") and (EnrageUp) then
    return S.Ravager:Cast()
  end
  -- rampage,if=talent.anger_management
  if IsReady("Rampage") and (S.AngerManagement:IsAvailable()) then
    return S.Rampage:Cast()
  end
  -- bloodbath,if=buff.furious_bloodthirst.up
  if IsReady("Bloodbath") and bloodbath and (Player:BuffUp(S.FuriousBloodthirstBuff)) then
    return S.Bloodbath:Cast()
  end
  -- crushing_blow
  if IsReady("Crushing Blow") then
    return S.CrushingBlow:Cast()
  end
  -- onslaught,if=talent.tenderize|buff.enrage.up
  if IsReady("Onslaught") and (S.Tenderize:IsAvailable() or EnrageUp) then
    return S.Onslaught:Cast()
  end
  -- bloodbath,if=!dot.gushing_wound.remains
  if IsReady("Bloodbath") and bloodbath and (Player:BuffUp(S.FuriousBloodthirstBuff)) then
    return S.Bloodbath:Cast()
  end
  -- rampage,if=talent.reckless_abandon
  if IsReady("Rampage") and (S.RecklessAbandon:IsAvailable()) then
    return S.Rampage:Cast()
  end
  -- execute,if=buff.enrage.up&((target.health.pct>35&talent.massacre|target.health.pct>20)&buff.sudden_death.remains<=gcd)
  if IsReady("Execute")  and S.Execute:CooldownRemains()<0.6  and (EnrageUp and ((Target:HealthPercentage() > 35 and S.Massacre:IsAvailable() or Target:HealthPercentage() > 20) and Player:BuffRemains(S.SuddenDeathBuff) <= Player:GCD())) then
    return S.Execute:Cast()
  end
  -- bloodbath
  if IsReady("Bloodbath") and bloodbath then
    return S.Bloodbath:Cast()
  end
  -- bloodthirst
  if IsReady("Bloodthirst") then
    return S.Bloodthirst:Cast()
  end
  -- raging_blow
  if IsReady("Raging Blow") then
    return S.RagingBlow:Cast()
  end
  -- execute
  if IsReady("Execute")  and S.Execute:CooldownRemains()<0.6  then
    return S.Execute:Cast()
  end
  -- whirlwind
  if IsReady("Whirlwind") then
    return S.Whirlwind:Cast()
  end
end

if inRange10<2 or not RubimRH.AoEON() then
  -- ravager,if=cooldown.recklessness.remains<gcd|buff.recklessness.up
  if IsReady("Ravager") and (S.Recklessness:CooldownRemains() < Player:GCD() or Player:BuffUp(S.RecklessnessBuff)) then
    return S.Ravager:Cast()
  end
  -- recklessness,if=!talent.anger_management|(talent.anger_management&cooldown.avatar.ready|cooldown.avatar.remains<gcd|cooldown.avatar.remains>30)
  if RubimRH.CDsON() and Player:PrevGCD(1, S.Rampage) and IsReady("Recklessness") and (not S.AngerManagement:IsAvailable() or (S.AngerManagement:IsAvailable() and S.Avatar:CooldownUp() or S.Avatar:CooldownRemains() < Player:GCD() or S.Avatar:CooldownRemains() > 30)) then
    return S.Recklessness:Cast()
  end
  -- avatar,if=!talent.titans_torment|(talent.titans_torment&(buff.enrage.up|talent.titanic_rage))
  if RubimRH.CDsON() and S.Recklessness:CooldownDown() and IsReady("Avatar") and (not S.TitansTorment:IsAvailable() or (S.TitansTorment:IsAvailable() and (EnrageUp or S.TitanicRage:IsAvailable()))) then
    return S.Avatar:Cast()
  end
  -- champions_spear,if=buff.enrage.up&((buff.furious_bloodthirst.up&talent.titans_torment)|!talent.titans_torment|target.time_to_die<20|active_enemies>1|!set_bonus.tier31_2pc)&raid_event.adds.in>15
  if IsReady("Champion's Spear") and (EnrageUp and ((Player:BuffUp(S.FuriousBloodthirstBuff) and S.TitansTorment:IsAvailable()) or not S.TitansTorment:IsAvailable() or FightRemains < 20 or inRange8 > 1 or not Player:HasTier(31, 2))) then
    return S.ChampionsSpear:Cast()
  end
  -- whirlwind,if=spell_targets.whirlwind>1&talent.improved_whirlwind&!buff.meat_cleaver.up|raid_event.adds.in<2&talent.improved_whirlwind&!buff.meat_cleaver.up
  if IsReady("Whirlwind") and (inRange8 > 1 and S.ImprovedWhilwind:IsAvailable() and Player:BuffDown(S.MeatCleaverBuff)) then
    return S.Whirlwind:Cast()
  end
  -- execute,if=buff.ashen_juggernaut.up&buff.ashen_juggernaut.remains<gcd
  if IsReady("Execute")  and S.Execute:CooldownRemains()<0.6  and (Player:BuffUp(S.AshenJuggernautBuff) and Player:BuffRemains(S.AshenJuggernautBuff) < Player:GCD()) then
    return S.Execute:Cast()
  end
  -- bladestorm,if=buff.enrage.up&(buff.avatar.up|buff.recklessness.up&talent.anger_management)
  if RubimRH.CDsON() and S.ThunderousRoar:CooldownDown() and IsReady("Bladestorm") and (EnrageUp and (Player:BuffUp(S.AvatarBuff) or Player:BuffUp(S.RecklessnessBuff) and S.AngerManagement:IsAvailable())) then
    return S.Bladestorm:Cast()
  end
  -- odyns_fury,if=buff.enrage.up&(spell_targets.whirlwind>1|raid_event.adds.in>15)&(talent.dancing_blades&buff.dancing_blades.remains<5|!talent.dancing_blades)
  if RubimRH.CDsON() and S.Recklessness:CooldownDown() and IsReady("Odyn's Fury") and (EnrageUp and (S.DancingBlades:IsAvailable() and Player:BuffRemains(S.DancingBladesBuff) < 5 or not S.DancingBlades:IsAvailable())) then
    return S.OdynsFury:Cast()
  end
  -- rampage,if=talent.anger_management&(buff.recklessness.up|buff.enrage.remains<gcd|rage.pct>85)
  if IsReady("Rampage") and (S.AngerManagement:IsAvailable() and (Player:BuffUp(S.RecklessnessBuff) or Player:BuffRemains(S.EnrageBuff) < Player:GCD() or Player:RagePercentage() > 85)) then
    return S.Rampage:Cast()
  end
  local BTCritChance = Player:CritChancePct() + num(Player:BuffUp(S.RecklessnessBuff)) * 20 + Player:BuffStack(S.MercilessAssaultBuff) * 10 + Player:BuffStack(S.BloodcrazeBuff) * 15
  -- bloodbath,if=set_bonus.tier30_4pc&action.bloodthirst.crit_pct_current>=95
  if IsReady("Bloodbath") and bloodbath and (Player:HasTier(30, 4) and BTCritChance >= 95) then
    return S.Bloodbath:Cast()
  end
  -- bloodthirst,if=(set_bonus.tier30_4pc&action.bloodthirst.crit_pct_current>=95)|(!talent.reckless_abandon&buff.furious_bloodthirst.up&buff.enrage.up&(!dot.gushing_wound.remains|buff.champions_might.up))
  if IsReady("Bloodthirst") and ((Player:HasTier(30, 4) and BTCritChance >= 95) or (not S.RecklessAbandon:IsAvailable() and Player:BuffUp(S.FuriousBloodthirstBuff) and EnrageUp and (Target:DebuffDown(S.GushingWoundDebuff) or Player:DebuffUp(S.ChampionsMightDebuff)))) then
    return S.Bloodthirst:Cast()
  end
  -- bloodbath,if=buff.furious_bloodthirst.up
  if IsReady("Bloodbath") and  bloodbath and (Player:BuffUp(S.FuriousBloodthirstBuff)) then
    return S.Bloodbath:Cast()
  end
  -- thunderous_roar,if=buff.enrage.up&(spell_targets.whirlwind>1|raid_event.adds.in>15)
  if RubimRH.CDsON() and S.OdynsFury:CooldownDown() and IsReady("Thunderous Roar") and (EnrageUp) then
    return S.ThunderousRoar:Cast()
  end
  -- onslaught,if=buff.enrage.up|talent.tenderize
  if IsReady("Onslaught") and (EnrageUp or S.Tenderize:IsAvailable()) then
    return S.Onslaught:Cast()
  end
  -- crushing_blow,if=buff.enrage.up
  if IsReady("Crushing Blow") and (EnrageUp) then
    return S.CrushingBlow:Cast()
  end
  -- rampage,if=talent.reckless_abandon&(buff.recklessness.up|buff.enrage.remains<gcd|rage.pct>85)
  if IsReady("Rampage") and (S.RecklessAbandon:IsAvailable() and (Player:BuffUp(S.RecklessnessBuff) or Player:BuffRemains(S.EnrageBuff) < Player:GCD() or Player:RagePercentage() > 85)) then
    return S.Rampage:Cast()
  end
  -- execute,if=buff.enrage.up&!buff.furious_bloodthirst.up&buff.ashen_juggernaut.up|buff.sudden_death.remains<=gcd&(target.health.pct>35&talent.massacre|target.health.pct>20)
  if IsReady("Execute")  and S.Execute:CooldownRemains()<0.6  and (EnrageUp and Player:BuffDown(S.FuriousBloodthirstBuff) and Player:BuffUp(S.AshenJuggernautBuff) or Player:BuffRemains(S.SuddenDeathBuff) <= Player:GCD() and (Target:HealthPercentage() > 35 and S.Massacre:IsAvailable() or Target:HealthPercentage() > 20)) then
    return S.Execute:Cast()
  end
  -- execute,if=buff.enrage.up
  if IsReady("Execute") and S.Execute:CooldownRemains()<0.6 and (EnrageUp) then
    return S.Execute:Cast()
  end
  -- rampage,if=talent.anger_management
  if IsReady("Rampage") and (S.AngerManagement:IsAvailable()) then
    return S.Rampage:Cast()
  end
  -- bloodbath,if=buff.enrage.up&talent.reckless_abandon&!talent.wrath_and_fury
  if IsReady("Bloodbath") and bloodbath and (EnrageUp and S.RecklessAbandon:IsAvailable() and not S.WrathandFury:IsAvailable()) then
    return S.Bloodbath:Cast()
  end
  -- rampage,if=target.health.pct<35&talent.massacre.enabled
  if IsReady("Rampage") and (Target:HealthPercentage() < 35 and S.Massacre:IsAvailable()) then
    return S.Rampage:Cast()
  end
  -- bloodthirst,if=buff.enrage.down|!buff.furious_bloodthirst.up
  if IsReady("Bloodthirst") and (not EnrageUp or Player:BuffDown(S.FuriousBloodthirstBuff)) then
    return S.Bloodthirst:Cast()
  end
  -- raging_blow,if=charges>1
  if IsReady("Raging Blow") and (S.RagingBlow:Charges() > 1) then
    return S.RagingBlow:Cast()
  end
  -- crushing_blow,if=charges>1
  if IsReady("Crushing Blow") and (S.CrushingBlow:Charges() > 1) then
    return S.CrushingBlow:Cast()
  end
  -- bloodbath,if=buff.enrage.down
  if IsReady("Bloodbath") and bloodbath and (not EnrageUp) then
    return S.Bloodbath:Cast()
  end
  -- crushing_blow,if=buff.enrage.up&talent.reckless_abandon
  if IsReady("Crushing Blow") and (EnrageUp and S.RecklessAbandon:IsAvailable()) then
    return S.CrushingBlow:Cast()
  end
  -- bloodthirst,if=!buff.furious_bloodthirst.up
  if IsReady("Bloodthirst") and (Player:BuffDown(S.FuriousBloodthirstBuff)) then
    return S.Bloodthirst:Cast()
  end
  -- raging_blow,if=charges>1
  if IsReady("Raging Blow") and (S.RagingBlow:Charges() > 1) then
    return S.RagingBlow:Cast()
  end
  -- rampage
  if IsReady("Rampage") then
    return S.Rampage:Cast()
  end
  -- bloodbath
  if IsReady("Bloodbath") and bloodbath then
    return S.Bloodbath:Cast()
  end
  -- raging_blow
  if IsReady("Raging Blow") then
    return S.RagingBlow:Cast()
  end
  -- crushing_blow
  if IsReady("Crushing Blow") then
    return S.CrushingBlow:Cast()
  end
  -- bloodthirst
  if IsReady("Bloodthirst")  then
    return S.Bloodthirst:Cast()
  end
  -- slam
  if IsReady("Slam") then
return S.Slam:Cast()
  end
end



end
--OOC

if not Player:AffectingCombat() then

if IsReady("Battle Shout") and battleshoutremains<300 then
return S.BattleShout:Cast()
end
if IsReady("Berserker Stance") and not AuraUtil.FindAuraByName("Berserker Stance","player")  then
  return S.BerserkerStance:Cast()
  end

 -- ooc end for 'if not Player:AffectingCombat() then'
return 0, "Interface\\Addons\\Rubim-RH\\Media\\griph.tga"

end



return 0, 135328
end -- end APL


RubimRH.Rotation.SetAPL(72, APL);

local function PASSIVE()

end

RubimRH.Rotation.SetPASSIVE(72, PASSIVE);

