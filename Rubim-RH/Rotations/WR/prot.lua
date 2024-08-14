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

local mainAddon = RubimRH
RubimRH.Spell[73] = {
    -- Racials
	RallyingCry = Spell(97462),
    BattleShout = Spell(6673),
    ArcaneTorrent = Spell(69179),
    Berserking = Spell(26297),
	Reflect = Spell(23920),
	ShieldBlockBuff = Spell(132404),
    Shadowmeld = Spell(58984),
    -- Abilities
	DefensiveStance = Spell(386208),
	DefensiveStancez = Spell(20594), --stoneform
	BattleStance = Spell(386164),
	BattleStancez = Spell(69070), --rocket jump
	CracklingThunder = Spell(203201),
    Ravager = Spell(22401),
    BattleCry = Spell(1719),
    StormBolt = Spell(107570),
    BerserkerRage = Spell(18499),
    Charge = Spell(100),
    DemoralizingShout = Spell(1160),
    Devastate = Spell(20243),
    FuriousSlash = Spell(100130),
    HeroicLeap = Spell(6544),
    HeroicThrow = Spell(57755),
    Revenge = Spell(6572),
    RevengeBuff = Spell(5302),
    ShieldSlam = Spell(23922),
    ThunderClap = Spell(6343),
    VictoryRush = Spell(34428),
    Victorious = Spell(32216),
	DragonRoar = Spell (23260),
    -- Talents
	BoomingVoice = Spell(202743),
	ShieldBash = Spell(35178),
	Bolster = Spell(280001),
    ImpendingVictory = Spell(202168),
    ImpendingVictoryProc = Spell(32216),
    Shockwave = Spell(46968),
    Vengeance = Spell(202572),
    VengeanceIP = Spell(202574),
    VengeanceRV = Spell(202573),
	Execute = Spell(163201), 
	UnstoppableForce = Spell(275336),
    -- Artifact
    NeltharionsFury = Spell(203524),
    -- Defensive
    IgnorePain = Spell(190456),
    LastStand = Spell(12975),
    Pummel = Spell(6552),
    ShieldBlock = Spell(2565),
    ShieldBlockB = Spell(132404),
    Avatar = Spell(107574),
	ShieldWall = Spell(871),
	FM = Spell(20594),
    Condemn = Spell(330325),
    Condemnz = Spell(68992), --darkflight
    trinket = Spell(155145),
    IntimidatingShout = Spell(5246),
}

local S = RubimRH.Spell[73]

-- Items
if not Item.Warrior then Item.Warrior = {} end
Item.Warrior.Protection = {
  trink = Item(159627, { 13, 14 }),
  healingpoticon = Item(169451),
};
local I = Item.Warrior.Protection;

local ShouldReturn;

local EnemyRanges = {}
local function UpdateRanges()
  for _, i in ipairs(EnemyRanges) do
    HL.GetEnemies(i);
  end
end

local function num(val)
  if val then return 1 else return 0 end
end

local function bool(val)
  return val ~= 0
end

local EnemyRanges = {5}
local function UpdateRanges()
  for _, i in ipairs(EnemyRanges) do
    HL.GetEnemies(i);
  end
end
-- Custom Warrior Protection functions

local function isCurrentlyTanking()
  -- is player currently tanking any enemies within 16 yard radius
  local IsTanking = Player:IsTankingAoE(16) or Player:IsTanking(Target);
  return IsTanking;
end

local function shouldCastIp()
  if Player:Buff(S.IgnorePain) then 
    local castIP = tonumber((GetSpellDescription(190456):match("%d+%S+%d"):gsub("%D","")))
    local IPCap = math.floor(castIP * 1.3);
    local currentIp = Player:Buff(S.IgnorePain, 16, true)

    -- Dont cast IP if we are currently at 50% of IP Cap remaining
    if currentIp  < (0.5 * IPCap) then
      return true
    else
      return false
    end
  else
    -- No IP buff currently
    return true
  end
end

local function DungeonBoss()
	local guid = UnitGUID('target')
	if guid then
		local unit_type = strsplit("-", guid)
		if not UnitIsPlayer('target') and Player:CanAttack(Target) then
			local _, _, _, _, _, npc_id = strsplit("-", guid)
			npcid = npc_id
		end
	end
	
	if (npcid == '150159' or npcid == '150222' or npcid == '155407' or npcid == '155157' or npcid == '144244' or npcid == '144246' or npcid == '144248' 
	or npcid == '152619' or npcid == '81305' or npcid == '80816' or npcid == '79852' or npcid == '83612' or npcid == '77803' or npcid == '79545' 
	or npcid == '80005' or npcid == '175616' or npcid == '176556' or npcid == '175646' or npcid == '176564' or npcid == '175806' or npcid == '175663' 
	or npcid == '175546' or npcid == '177269' or npcid == '114284' or npcid == '114261' or npcid == '114328' or npcid == '113971' or npcid == '114262' 
	or npcid == '114312' or npcid == '114247' or npcid == '114350' or npcid == '114790' or npcid == '116494') then
		DngBoss = true
	else
		DngBoss = false
	end
	
	return DngBoss
end

local function Dummy()
	local x = UnitName("target")
	local targetisdummy = false

	if x then
		name = x:sub(-5)
	end
	
	if Target:Exists() then
		if name == 'Dummy' then
			targetisdummy = true
		end
	else
		targetisdummy = false
	end

	return targetisdummy
end

-- ======= ACTION LISTS =======
local function APL()
	DungeonBoss()
	Dummy()
 	HL.GetEnemies("Melee");
	HL.GetEnemies(5, true);
    HL.GetEnemies(8, true);
    HL.GetEnemies(10, true);
	HL.GetEnemies(11, true);
	HL.GetEnemies(12, true);
	HL.GetEnemies(15, true);
	HL.GetEnemies(17, true);
	HL.GetEnemies(20, true);
	HL.GetEnemies(22, true);
	HL.GetEnemies(25, true);
	HL.GetEnemies(30, true);
	
local IsTanking = Player:IsTankingAoE(10) or Player:IsTanking(Target);

if Player:IsCasting() or Player:IsChanneling() or AuraUtil.FindAuraByName("Drink", "player") 
or AuraUtil.FindAuraByName("Food", "player") or AuraUtil.FindAuraByName("Food & Drink", "player") then
	return 0, "Interface\\Addons\\Rubim-RH\\Media\\channel.tga"
end 

--------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------Out of Combat---------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------

if not Player:AffectingCombat() then

	if S.BattleShout:IsCastable() and not Player:BuffP(S.BattleShout) then
		return S.BattleShout:Cast()
	end

	if not RubimRH.queuedSpell[1]:CooldownUp() then
		RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
	end

	return 0, "Interface\\Addons\\Rubim-RH\\Media\\mount2.tga"
end

--------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------Spell Queue-----------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------

if RubimRH.QueuedSpell():IsReadyQueue() then
    return RubimRH.QueuedSpell():Cast()
end

if not RubimRH.queuedSpell[1]:CooldownUp() then
	RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
end

--------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------Cooldowns-------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------

if RubimRH.CDsON() and Player:AffectingCombat() then

	if S.DefensiveStance:IsCastable() and not Player:BuffP(S.DefensiveStance) and Player:HealthPercentage() <= 60 then
		return S.DefensiveStancez:Cast()
	end

	if S.BattleStance:IsCastable() and not Player:BuffP(S.BattleStance) and Player:HealthPercentage() >= 75 then
		return S.BattleStancez:Cast()
	end

	if S.ShieldWall:IsCastable() and Player:HealthPercentage() <= 50 and Cache.EnemiesCount[10] >= 1 then
		return S.ShieldWall:Cast()
	end

	if S.LastStand:IsCastable() and Player:HealthPercentage() <= 40 and Cache.EnemiesCount[10] >= 1 then
		return S.LastStand:Cast()
	end
	
	if Player:HealthPercentage() < 40 and IsUsableItem(187802) and GetItemCooldown(187802) == 0 and GetItemCount(187802) >= 1 then
		return I.healingpoticon:Cast()
	end
	
	if S.RallyingCry:IsCastable() and Player:HealthPercentage() <= 20 and Cache.EnemiesCount[10] >= 1 then
		return S.RallyingCry:Cast()
	end

	if S.Avatar:IsCastable() and Cache.EnemiesCount[10] >= 1 then
		return S.Avatar:Cast()
	end

end

--------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------Rotation------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------

if S.Pummel:IsReady(8) and notInterruptible == false and Target:CastPercentage() > math.random(43, 82) and RubimRH.InterruptsON() then
	return S.Pummel:Cast()
end

if S.ShieldBlock:IsCastable() and Player:Rage() >= 30 and (IsTanking or Dummy()) and Player:AffectingCombat() and Cache.EnemiesCount[10] >= 1
and (not Player:BuffP(S.ShieldBlockBuff) or S.ShieldBlock:Charges() == 2)  then
	return S.ShieldBlock:Cast()
end

if S.IgnorePain:IsCastable() and Player:Rage() >= 35 and (IsTanking or Dummy()) and Player:AffectingCombat()
and not Player:BuffP(S.IgnorePain) and (Player:HealthPercentage() <= 85 or Player:IncDmgPercentage() >= 2) then
	return S.IgnorePain:Cast()
end

if S.ImpendingVictory:IsReady(5) and (Player:Rage() >= 10 or Player:BuffP(S.ImpendingVictoryProc)) 
and Player:HealthPercentage() <= 70 then
	return S.ImpendingVictory:Cast()
end

if S.ThunderClap:IsCastable() and not Player:IsTankingAoE(8)
and Player:Rage() >= 30 and Cache.EnemiesCount[8] >= 2 then
	return S.ThunderClap:Cast()
end

if S.DemoralizingShout:IsCastable() 
and (Cache.EnemiesCount[8] >= 3 or ((UnitClassification("target") == "worldboss" or DungeonBoss() or Dummy()) and Target:IsInRange(8))
or (Player:BuffP(S.Avatar) and Cache.EnemiesCount[8] >= 2)) then
	return S.DemoralizingShout:Cast()
end

if S.ShieldSlam:IsReady(5) then
	return S.ShieldSlam:Cast()
end

if S.ImpendingVictory:IsReady(5) and (Player:Rage() >= 10 or Player:BuffP(S.ImpendingVictoryProc)) 
and Player:HealthPercentage() <= 70 then
	return S.ImpendingVictory:Cast()
end

if S.ThunderClap:IsCastable() 
and Player:Rage() >= 30 and Cache.EnemiesCount[8] >= 1 then
	return S.ThunderClap:Cast()
end

if IsUsableSpell('Condemn') and Target:IsInRange(5) and Player:Rage() >= 65 and (Target:HealthPercentage() > 80 or Target:HealthPercentage() < 20) then
	return S.Condemnz:Cast()
end

if S.Revenge:IsReady(5) and (Player:Rage() >= 65 or Player:BuffP(S.RevengeBuff)) then
	return S.Revenge:Cast()
end

	return 0, 135328
end

RubimRH.Rotation.SetAPL(73, APL);

local function PASSIVE()
    return RubimRH.Shared()
end

RubimRH.Rotation.SetPASSIVE(73, PASSIVE);