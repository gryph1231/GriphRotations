--- Localize Vars
-- Addon
local RubimRH = LibStub("AceAddon-3.0"):GetAddon("RubimRH")
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
local MultiSpell = HL.MultiSpell;

local mainAddon = RubimRH
RubimRH.Spell[73] = {

    lust1 = Spell(57724),
    lust2 = Spell(57723),
    lust3 = Spell(80354),
    lust4 = Spell(95809),
    lust5 = Spell(264689),
      lustAT = Spell(265221), -- fireblood
      Ravagerz                              = Spell(312411),
      AncestralCall                         = Spell(274738),
      ArcaneTorrent                         = Spell(50613),
      -- BagofTricks                           = Spell(312411),
      Berserking                            = Spell(26297),
      BloodFury                             = Spell(20572),
      -- Abilities
      BattleShout                           = Spell(6673),
      Charge                                = Spell(100),
      HeroicThrow                           = Spell(57755),
      Pummel                                = Spell(6552),
      Slam                                  = Spell(1464),
      odynsfury                             = Spell(28880),--Gift of Naru
      VictoryRush                           = Spell(34428),
      -- Talents
      Avatar                                = Spell(107574),
      BerserkerRage                         = Spell(18499),
      BloodandThunder                       = Spell(384277),
      DoubleTime                            = Spell(103827),
      FrothingBerserker                     = Spell(215571),
      IntimidatingShout                     = Spell(5246),
      HeroicLeap                            = Spell(6544),
      ImpendingVictory                      = Spell(202168),
      OverwhelmingRage                      = Spell(382767),
      RallyingCry                           = Spell(97462),
      Shockwave                             = Spell(46968),
      SonicBoom                             = Spell(390725),
      SpearofBastion                        = Spell(376079),
      StormBolt                             = Spell(107570),
      ThunderousRoar                        = Spell(384318),
      TitanicThrow                          = Spell(384090),
      TitansTorment                         = Spell(390135),
      WreckingThrow                         = Spell(384110),
      -- Buffs
      AvatarBuff                            = Spell(107574),
      BattleShoutBuff                       = Spell(6673),
      -- Debuffs
      SpearofBastionDebuff                  = Spell(376080),
      -- Covenant Abilities (Shadowlands)
      AncientAftershock                     = Spell(325886),
      Condemn                               = MultiSpell(330325, 330334, 317485, 317349),
      CondemnDebuff                         = Spell(317491),
      ConquerorsBanner                      = Spell(324143),
      ConquerorsFrenzyBuff                  = Spell(343672),
      ElysianMightBuff                      = Spell(311193),
      Fleshcraft                            = Spell(324631),
      SpearofBastionCov                     = Spell(307865),
      SpearofBastionCovBuff                 = Spell(307871),
      -- Conduits (Shadowlands)
      AshenJuggernaut                       = Spell(335232),
      AshenJuggernautBuff                   = Spell(335234),
      MercilessBonegrinder                  = Spell(335260),
      MercilessBonegrinderBuff              = Spell(346574),
      -- Pool
      Pool                                  = Spell(999910),
    -- Abilities
  Devastate                             = Spell(20243),
  Execute                               = Spell(163201),
  ShieldBlock                           = Spell(2565),
  ShieldSlam                            = Spell(23922),
  -- Talents
  BoomingVoice                          = Spell(202743),
  DemoralizingShout                     = Spell(1160),
  IgnorePain                            = Spell(190456),
  Intervene                             = Spell(3411),
  LastStand                             = Spell(12975),
  Ravager                               = Spell(228920),
  
  Rend                                  = Spell(394062),
  Revenge                               = Spell(6572),
  ShieldCharge                          = Spell(385952),
  ShieldWall                            = Spell(871),
  ThunderClap                           = Spell(6343),
  UnstoppableForce                      = Spell(275336),
  -- Buffs
  LastStandBuff                         = Spell(12975),
  RallyingCryBuff                       = Spell(97463),
  RevengeBuff                           = Spell(5302),
  SeeingRedBuff                         = Spell(386486),
  ShieldBlockBuff                       = Spell(132404),
  ShieldWallBuff                        = Spell(871),
  ViolentOutburstBuff                   = Spell(386478),

}

local S = RubimRH.Spell[73]

-- Items
if not Item.Warrior then Item.Warrior = {} end
Item.Warrior.Protection = {
    trink = Item(184016, { 13, 14 }),
    drums = Item(193470),
    HPIcon = Item(169451),
    tx1 = Item(118330),
    tx2 = Item(114616),
};
local I = Item.Warrior.Protection;

local ShouldReturn;

local function num(val)
  if val then return 1 else return 0 end
end

local function bool(val)
  return val ~= 0
end


local function IgnorePainWillNotCap()
	if Player:Buff(S.IgnorePain) then
	  local absorb = Player:AttackPowerDamageMod() * 3.5 * (1 + Player:VersatilityDmgPct() / 100)
	  local spellTable = Player:AuraInfo(S.IgnorePain, nil, true)
	  local IPAmount = spellTable.points[1]
	  --return IPAmount < (0.5 * mathfloor(absorb * 1.3))
	  -- Ignore Pain appears to cap at 2 times its absorb value now
	  return IPAmount < absorb
	else
	  return true
	end
  end
  
  local function IgnorePainValue()
	if Player:Buff(S.IgnorePain) then
	  local IPBuffInfo = Player:BuffInfo(S.IgnorePain, nil, true)
	  return IPBuffInfo.points[1]
	else
	  return 0
	end
  end
  
  local function ShouldPressShieldBlock()
	-- shield_block,if=(buff.shield_block.down|buff.shield_block.remains<cooldown.shield_slam.remains)&target.health.pct>20
	return IsTanking and S.ShieldBlock:IsReady() and 
	-- ((
		not Player:Buff(S.ShieldBlockBuff) 
	-- or Player:BuffRemains(S.ShieldBlockBuff) < S.ShieldSlam:CooldownRemains())
	 and not Player:Buff(S.LastStandBuff) and Target:HealthPercentage() > 20
	--)
  end
  
  -- A bit of logic to decide whether to pre-cast-rage-dump on ignore pain.
  local function SuggestRageDump(RageFromSpell)
	-- Get RageMax from setting (default 80)
	local RageMax = 85
	-- If the setting value is lower than 35, it's not possible to cast Ignore Pain, so just return false
	if (RageMax < 35 or Player:Rage() < 35) then return false end
	local ShouldPreRageDump = false
	-- Make sure we have enough Rage to cast IP, that it's not on CD, and that we shouldn't use Shield Block
	local AbleToCastIP = (Player:Rage() >= 35 and not ShouldPressShieldBlock())
	if AbleToCastIP and (Player:Rage() + RageFromSpell >= RageMax or S.DemoralizingShout:IsReady()) then
	  -- should pre-dump rage into IP if rage + RageFromSpell >= RageMax or Demo Shout is ready
		shouldPreRageDump = true
	end
	if shouldPreRageDump and Target:IsInRange(8) then
	  if IgnorePainWillNotCap() then
		return S.IgnorePain:Cast()
	  else
		return S.Revenge:Cast()
	end
	end
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

local function HealthPotionSelected()

    local HealthPotionIDs = {
        191380, 191379, 191378

    }

    for _, HealthPotionID in ipairs(HealthPotionIDs) do
        if Item(HealthPotionID):IsUsable() then
            return Item(HealthPotionID)
        end
    end
end


local function Defensive()
	if ShouldPressShieldBlock() then
		return S.ShieldBlock:Cast()
	end
	-- shield_wall,if=!buff.last_stand.up&!buff.rallying_cry.up
	if S.ShieldWall:IsCastable() and (not Player:Buff(S.LastStandBuff) and not Player:Buff(S.RallyingCryBuff)) and (Player:HealthPercentage()<55 and Player:NeedPanicHealing() or Player:HealthPercentage()<35) then
		return S.ShieldWall:Cast()
	end
	-- last_stand,if=!buff.shield_wall.up&!buff.rallying_cry.up
	if S.LastStand:IsCastable() and (not Player:Buff(S.ShieldBlockBuff) and S.ShieldBlock:Recharge() > 1) and (Player:HealthPercentage()<55 and Player:NeedPanicHealing() or Player:HealthPercentage()<55) then
	return S.LastStand:Cast()
	end
	-- rallying_cry,if=!buff.last_stand.up&!buff.shield_wall.up
	if S.RallyingCry:IsCastable() and (not Player:Buff(S.LastStandBuff) and not Player:Buff(S.ShieldWallBuff)) and (Player:HealthPercentage()<55 and Player:NeedPanicHealing() or Player:HealthPercentage()<60) then
		return S.RallyingCry:Cast()
	end
  
	-- demoralizing_shout,if=!buff.last_stand.up&!buff.shield_wall.up&!buff.rallying_cry.up
	if S.DemoralizingShout:IsCastable() and (not Player:Buff(S.LastStandBuff) and not Player:Buff(S.ShieldWallBuff) and not Player:Buff(S.RallyingCryBuff)) and (Player:HealthPercentage()<85 and Player:NeedPanicHealing() or Player:HealthPercentage()<70)then
		return S.DemoralizingShout:Cast()
	end
  
	if Player:HealthPercentage() < 70 then
	  if S.VictoryRush:IsReady() then
		return S.VictoryRush:Cast()
	end
	  if S.ImpendingVictory:IsReady() then
		return S.ImpendingVictory:Cast()
	end
	end
  end
  
  local function Aoe()

	-- ignore_pain,if=rage.deficit>=35&buff.ignore_pain.value<health.max*0.3
	if S.IgnorePain:IsReady() and (Player:RageDeficit() >= 35 and IgnorePainValue() < Player:MaxHealth() * 0.3) then
		return S.IgnorePain:Cast()
	end
	-- spear_of_bastion
	if S.SpearofBastion:IsCastable() and Target:IsInRange(8) and RubimRH.CDsON() then
	  SuggestRageDump(20)
	  return S.SpearofBastion:Cast()
	end
	-- thunderous_roar
	if S.ThunderousRoar:IsCastable() and Target:IsInRange(8) and RubimRH.CDsON() then
	  SuggestRageDump(10)
	  return S.ThunderousRoar:Cast()
	end
	-- ravager
	if S.Ravager:IsCastable() and (Target:IsInRange(5) or Enemies8y>=2) and RubimRH.CDsON() then
	  SuggestRageDump(10)
	  return S.Ravager:Cast()
	end
	-- shockwave
	if S.Shockwave:IsCastable() and Target:IsInRange(5) then
	  SuggestRageDump(10)
	  return S.Shockwave:Cast()
	end
	-- shield_charge
	if S.ShieldCharge:IsCastable() and Target:IsInRange(5) then
		return S.ShieldCharge:Cast()
	end
  
	-- revenge,if=rage.deficit>30
	if S.Revenge:IsReady() and (not ShouldPressShieldBlock()) and (Player:RageDeficit() > 30) then
		return S.Revenge:Cast()
	end
	-- thunder_clap
	if S.ThunderClap:IsCastable() and Target:IsInRange(8) then
	  SuggestRageDump(5)
	  return S.ThunderClap:Cast()
	end
	-- titanic_throw
	if S.TitanicThrow:IsCastable() and RubimRH.CDsON() and Target:IsInRange(8) then
		return S.TitanicThrow:Cast()
	end
	-- rend,if=!talent.thunderclap&!talent.blood_and_thunder
	if S.Rend:IsReady() and (not ShouldPressShieldBlock()) and ((not S.ThunderClap:IsAvailable()) and not S.BloodandThunder:IsAvailable()) then
		return S.Rend:Cast()
	end
	-- shield_slam
	if S.ShieldSlam:IsCastable()  and Target:IsInRange(8) then
	  SuggestRageDump(20)
	  return S.ShieldSlam:Cast()
	end
	-- execute
	if S.Execute:IsReady() and not ShouldPressShieldBlock() and Target:IsInRange(8) then
		return S.Execute:Cast()
	end
	-- devastate
	if S.Devastate:IsCastable() and Target:IsInRange(8) then
		return S.Devastate:Cast()
	end
	-- impending_victory
	if S.ImpendingVictory:IsReady() and Target:IsInRange(8) then
		return S.ImpendingVictory:Cast()
	end
	-- storm_bolt
	-- if S.StormBolt:IsCastable() then
	--   if Cast(S.StormBolt, nil, nil, not Target:IsInRange(20)) then return "storm_bolt aoe 30"; end
	-- end
  end
  
  local function Generic()
	-- ignore_pain,if=(rage.deficit>=35&buff.ignore_pain.value<health.max*0.3*0.5)|buff.ignore_pain.remains<gcd
	if S.IgnorePain:IsReady() and ((Player:RageDeficit() >= 35 and IgnorePainValue() < Player:MaxHealth() * 0.3 * 0.5) or Player:BuffRemains(S.IgnorePain) < Player:GCD()) then
		return S.IgnorePain:Cast()
	end
	-- ravager
	if S.Ravager:IsCastable() and (Target:IsInRange(5) or Enemies8y>=2) and RubimRH.CDsON() then
	  SuggestRageDump(10)
	  return S.Ravager:Cast()
	end
	-- thunderous_roar
	if S.ThunderousRoar:IsCastable() and Target:IsInRange(5) and RubimRH.CDsON() then
	  SuggestRageDump(10)
	  return S.ThunderousRoar:Cast()
	end
	-- spear_of_bastion
	if S.SpearofBastion:IsCastable()  and Target:IsInRange(8) and RubimRH.CDsON() then
	  SuggestRageDump(20)
	  return S.SpearofBastion:Cast()
	end
	-- shield_charge
	if S.ShieldCharge:IsCastable() and Target:IsInRange(5) then
		return S.ShieldCharge:Cast()
	end
	-- shockwave
	-- if S.Shockwave:IsCastable()  and Target:IsInRange(8) then
	--   SuggestRageDump(10)
	--   return S.Shockwave:Cast()
	-- end
	-- execute
	if S.Execute:IsReady() and not ShouldPressShieldBlock()  and Target:IsInRange(8) then
		return S.Execute:Cast()
	end
	-- shield_slam
	if S.ShieldSlam:IsReady() and Target:IsInRange(8) then
	  SuggestRageDump(20)
	  return S.ShieldSlam:Cast()
	end
	-- thunder_clap,if=active_enemies>=2|(talent.rend&talent.blood_and_thunder)
	if S.ThunderClap:IsCastable() and Target:IsInRange(8) and (Enemies8y >= 2 or (S.Rend:IsAvailable() and S.BloodandThunder:IsAvailable())) then
	  SuggestRageDump(5)
	  return S.ThunderClap:Cast()
	end
	if (not ShouldPressShieldBlock()) then
	  -- rend,if=!talent.thunderclap&!talent.blood_and_thunder
	  if S.Rend:IsReady() and ((not S.ThunderClap:IsAvailable()) and not S.BloodandThunder:IsAvailable()) then
		return S.Rend:Cast()
	end
	  -- revenge,if=rage.deficit>30&active_enemies>=2
	  if S.Revenge:IsReady() and (Player:RageDeficit() > 30 and Enemies8y >= 2) then
		return S.Revenge:Cast()
	end
	end
	-- titanic_throw,if=active_enemies>=2
	if S.TitanicThrow:IsReady() and (Enemies8y >= 2) then
		return S.TitanicThrow:Cast()
	end
	-- devastate
	if S.Devastate:IsReady() then
		return S.Devastate:Cast()
	end
	-- heroic_throw
	if S.HeroicThrow:IsReady() and not Target:IsInRange(8) and Target:IsInRange(30) and (Target:AffectingCombat() or Player:AffectingCombat()) then
		return S.HeroicThrow:Cast()
	end
	-- titanic_throw
	if S.TitanicThrow:IsReady() then
		return S.TitanicThrow:Cast()
	end
	-- thunder_clap
	if S.ThunderClap:IsReady() and Target:IsInRange(8) then
	  SuggestRageDump(5)
	  return S.ThunderClap:Cast()
	end
	-- revenge,if=rage.deficit>30
	if S.Revenge:IsReady() and Target:IsInRange(8) and (not ShouldPressShieldBlock()) and (Player:RageDeficit() > 30) then
		return S.Revenge:Cast()
	end
	-- impending_victory
	if S.ImpendingVictory:IsReady() then
		return S.ImpendingVictory:Cast()
	end
	-- storm_bolt
	-- if S.StormBolt:IsCastable() then
	--   if Cast(S.StormBolt, nil, nil, not Target:IsInRange(20)) then return "storm_bolt generic 38"; end
	-- end
  end
  
  --- ======= ACTION LISTS =======
  local function APL()

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
    HealthPotionSelected()
local IsTanking = Player:IsTankingAoE(15) or Player:IsTanking(Target);

-- if S.Condemn:IsReady(5) then
	-- print('EXECUTE RDY')
-- else
	-- print('EXECUTE NOT RDY')
-- end

if Player:IsCasting() or Player:IsChanneling() or AuraUtil.FindAuraByName("Drink", "player") 
or AuraUtil.FindAuraByName("Food", "player") or AuraUtil.FindAuraByName("Food & Drink", "player") then
	return 0, "Interface\\Addons\\Rubim-RH\\Media\\channel.tga"
end 

--------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------Out of Combat---------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------

if not Player:AffectingCombat() then

	if S.BattleShout:IsCastable() and not Player:BuffP(S.BattleShoutBuff) then
		return S.BattleShout:Cast()
	end



	  return 0, "Interface\\Addons\\Rubim-RH\\Media\\griph.tga"
	end

--------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------Spell Queue-----------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------


if not RubimRH.queuedSpell[1]:CooldownUp() or not Player:AffectingCombat() or Enemies20y==0 then
	RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
end


if RubimRH.QueuedSpell():IsReadyQueue() then
    return RubimRH.QueuedSpell():Cast()
end



 
    if Player:HealthPercentage() <= 25 and Player:AffectingCombat() and IsUsableItem(191380) and
        GetItemCooldown(191380) == 0 and GetItemCount(191380) >= 1
        and (not Player:InArena() and not Player:InBattlegrounds()) then
        return I.HPIcon:Cast()
    end
	
    if Target:IsInRange(8) and RubimRH.CDsON() then
        local ShouldReturn = UseItems();
        if ShouldReturn then return ShouldReturn; end
    end
 
  
	if Player:AffectingCombat() then


	  
	  if IsTanking then
		local ShouldReturn = Defensive(); if ShouldReturn then return ShouldReturn; end
	  end

	  
	  if select(8, UnitCastingInfo("target")) == false and Target:CastPercentage() > math.random(43, 87) and
	  RubimRH.InterruptsON() and S.Pummel:IsCastableQueue(8) and Player:AffectingCombat() then
	  return S.Pummel:Cast()
	  end
	  
	  
	  if S.ShieldBlock:IsCastable() and Player:Rage() >= 30 and (IsTanking or Target:IsDummy()) and Player:AffectingCombat() and Cache.EnemiesCount[10] >= 1
	  and (not Player:BuffP(S.ShieldBlockBuff) or S.ShieldBlock:Charges() == 2)  then
		  return S.ShieldBlock:Cast()
	  end
	  

	  if RubimRH.CDsON() and (Player:Buff(S.AvatarBuff) or not S.Avatar:IsAvailable()) then
	
		
		if S.BloodFury:IsCastable() and RubimRH.CDsON() then
		return S.BloodFury:Cast()
	end
				
		if S.Berserking:IsCastable() and RubimRH.CDsON() then
			return S.Berserking:Cast()
	end
	
		if S.AncestralCall:IsCastable() and RubimRH.CDsON() then
			return S.AncestralCall:Cast()
		end
	  end

	  if S.Revenge:IsReady() and Target:IsInRange(8) and (Player:Buff(S.RevengeBuff) and (Target:HealthPercentage() > 20 or Enemies8y > 3) and S.ShieldSlam:CooldownRemains() > 0) then
		return S.Revenge:Cast()
	end

	  if S.IgnorePain:IsReady() and IgnorePainWillNotCap() and (Target:HealthPercentage() >= 20 and (Player:Rage() >= 85 and S.ShieldSlam:CooldownUp() and Player:Buff(S.ShieldBlockBuff) or Player:Rage() >= 60 and S.DemoralizingShout:CooldownUp() and S.BoomingVoice:IsAvailable() or Player:Rage() >= 70 and S.Avatar:CooldownUp() or Player:Rage() >= 40 and S.DemoralizingShout:CooldownUp() and S.BoomingVoice:IsAvailable() and Player:Buff(S.LastStandBuff) or Player:Rage() >= 55 and S.Avatar:CooldownUp() and Player:Buff(S.LastStandBuff) or Player:Rage() >= 80 or Player:Rage() >= 55 and S.ShieldSlam:CooldownUp() and Player:Buff(S.ViolentOutburstBuff) and Player:Buff(S.ShieldBlockBuff) or Player:Rage() >= 30 and S.ShieldSlam:CooldownUp() and Player:Buff(S.ViolentOutburstBuff) and Player:Buff(S.LastStandBuff) and Player:Buff(S.ShieldBlockBuff))) then
		return S.IgnorePain:Cast()
	end

	  if S.ShieldSlam:IsCastable() and (Player:Buff(S.ViolentOutburstBuff) and Player:Rage() <= 55) then
		SuggestRageDump(20)
		return S.ShieldSlam:Cast()
	end
	  if (RubimRH.CDsON()) then

		if S.ArcaneTorrent:IsCastable() and (Player:Rage() < 80) and RubimRH.CDsON() then
			return S.ArcaneTorrent:Cast()
		end
  
  
		if S.Avatar:IsCastable() and Target:IsInRange(5) and RubimRH.CDsON() then
			return S.Avatar:Cast()
		end

	  end

	  -- run_action_list,name=aoe,if=spell_targets.thunder_clap>3
	  if Enemies8y > 3 then
		local ShouldReturn = Aoe(); if ShouldReturn then return ShouldReturn; end
	  end

	  -- call_action_list,name=generic
	  local ShouldReturn = Generic(); if ShouldReturn then return ShouldReturn; end

	end






  return 0, 135328
end

RubimRH.Rotation.SetAPL(73, APL);

local function PASSIVE()
    return RubimRH.Shared()
end

RubimRH.Rotation.SetPASSIVE(73, PASSIVE);
