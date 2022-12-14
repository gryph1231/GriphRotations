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

if not Spell.Warrior then
    Spell.Warrior = {};
end

RubimRH.Spell[71] = {
BloodFury = Spell(20572),
ColossusSmashDebuff = Spell(208086),
Juggernaut = Spell(383290),
Execute = Spell(281000),
SweepingStrikes = Spell(260708),
Bladestorm = Spell(227847),
ThunderClap = Spell(396719),
BloodAndThunder = Spell(384277),
Rend = Spell(772),
RendDebuff = Spell(388539),
Avatar = Spell(107574),
BlademastersTorment = Spell(390138),
Warbreaker = Spell(262161),
ColossusSmash = Spell(262161),
TestOfMightBuff = Spell(385013),
TestOfMight = Spell(385008),
Pummel = Spell(6552),
ThunderousRoar = Spell(384318),
Cleave = Spell(845),
Overpower = Spell(7384),
WhirlWind = Spell(1680),
MortalStrike = Spell(12294),
ExecutionersPrecision = Spell(386633),
Dreadnaught = Spell(262150),
Battlelord = Spell(386630),
DeepWoundsDebuff = Spell(262115),
SuddenDeath = Spell(52437),
Massacre = Spell(281001),
StormOfSwords = Spell(385512),
Slam = Spell(1464),
BattleStance = Spell(386164),
WarlordsTorment = Spell(390140),
CrushingForce = Spell(382764),
TideOfBlood = Spell(386357),
MercilessBonegrinder = Spell(383317),
Skullsplitter = Spell(260643),
FervorOfBattle = Spell(202316),
WreckingThrow = Spell(384110),
ImpendingVictory = Spell(202168),
DieByTheSword = Spell(118038),
}

local S = RubimRH.Spell[71] 

if not Item.Warrior then Item.Warrior = {}; end

Item.Warrior.Arms = {
healingpoticon = Item(169451),
tx1 = Item(118330),
--tx2 = Item(114616),
HPIcon = Item(169451),
};

local I = Item.Warrior.Arms;

function HealthPotionSelected()
    local HealthPotionIDs = {
        191380, 191379, 191378
    }

    for _, HealthPotionID in ipairs(HealthPotionIDs) do
        if Item(HealthPotionID):IsUsable() then
            return Item(HealthPotionID)
        end
    end
end

local function MissingAOERend()
local RendRefreshable8 = 0
local MissingRend8 = 0

    for id = 1, 40 do
		local unitID = "nameplate" .. id
		local _,_,_,_,_,expirationTime = AuraUtil.FindAuraByName("Rend",unitID,"PLAYER|HARMFUL")
		
		if AuraUtil.FindAuraByName("Rend",unitID,"PLAYER|HARMFUL") then
			timerRend = expirationTime - HL.GetTime()
		else
			timerRend = nil
		end

		if timerRend then 
			if UnitCanAttack("player", unitID) and IsItemInRange(34368, unitID) and timerRend <= 4 then
				RendRefreshable8 = RendRefreshable8 + 1
			end
		end
		
		if UnitCanAttack("player", unitID) and IsItemInRange(34368, unitID) and not AuraUtil.FindAuraByName("Rend",unitID,"PLAYER|HARMFUL") then
			MissingRend8 = MissingRend8 + 1
		end
	end

	return RendRefreshable8 + MissingRend8
end

local function UseItems()
local trinket1 = GetInventoryItemID("player", 13) 
local trinket2 = GetInventoryItemID("player", 14) 
local trinket1ready = IsUsableItem(trinket1) and GetItemCooldown(trinket1) == 0 and IsEquippedItem(trinket1)
local trinket2ready = IsUsableItem(trinket2) and GetItemCooldown(trinket2) == 0 and IsEquippedItem(trinket2)
 
	if trinket1ready then
		return I.tx1:Cast()      
	end
  
	-- if trinket2ready then
		-- return I.tx2:Cast()
	-- end

end

function HealthPotionSelected()
    local HealthPotionIDs = {
        191380, 191379, 191378
    }

    for _, HealthPotionID in ipairs(HealthPotionIDs) do
        if Item(HealthPotionID):IsUsable() then
            return Item(HealthPotionID)
        end
    end
end

function IsDummy(NPCID)

	if NPCID then
		GUID = UnitGUID(NPCID)
		if GUID then
			local Type, _, _, _, _, UnitIDzFromGUID = strsplit('-', GUID)
			UnitIDz = tonumber(UnitIDzFromGUID)
		end
	end
	
	if GUID and (UnitIDz == 31146 or UnitIDz == 31144 or UnitIDz == 32666 or UnitIDz == 32667 or UnitIDz == 46647 or UnitIDz == 114832 or UnitIDz == 153292
	or UnitIDz == 67127 or UnitIDz == 87317 or UnitIDz == 87318 or UnitIDz == 87320 or UnitIDz == 88314 or UnitIDz == 88316 or UnitIDz == 87760
	or UnitIDz == 29310 or UnitIDz == 29308 or UnitIDz == 27483 or UnitIDz == 26632 or UnitIDz == 26630 or UnitIDz == 31134 or UnitIDz == 29266 
	or UnitIDz == 87761 or UnitIDz == 87762 or UnitIDz == 88288 or UnitIDz == 88289 or UnitIDz == 113964 or UnitIDz == 113966 or UnitIDz == 103397
	or UnitIDz == 103404 or UnitIDz == 103402 or UnitIDz == 107555 or UnitIDz == 107556 or UnitIDz == 92164 or UnitIDz == 92165 or UnitIDz == 92166
	or UnitIDz == 101956 or UnitIDz == 102045 or UnitIDz == 102048 or UnitIDz == 102052 or UnitIDz == 144081 or UnitIDz == 144082 or UnitIDz == 144085 
	or UnitIDz == 144086 or UnitIDz == 126781 or UnitIDz == 131983 or UnitIDz == 131989 or UnitIDz == 131992 or UnitIDz == 154564 or UnitIDz == 154567
	or UnitIDz == 154580 or UnitIDz == 154583 or UnitIDz == 154585 or UnitIDz == 154586 or UnitIDz == 160325 or UnitIDz == 173942 or UnitIDz == 175449
	or UnitIDz == 175450 or UnitIDz == 175451 or UnitIDz == 175452 or UnitIDz == 175455 or UnitIDz == 175456 or UnitIDz == 175462 or UnitIDz == 174565
	or UnitIDz == 174566 or UnitIDz == 174567 or UnitIDz == 174568 or UnitIDz == 174569 or UnitIDz == 174570 or UnitIDz == 174571 or UnitIDz == 174484
	or UnitIDz == 174487 or UnitIDz == 174488 or UnitIDz == 174491 or UnitIDz == 65310 or UnitIDz == 198594 or UnitIDz == 189632) then
		return true
	else
		return false
	end

end


local function allMobsinRange(range)
local totalRange40 = 0
local allMobsinRange = false

	for id = 1, 40 do
		local unitID = "nameplate" .. id
		local x = UnitName(unitID)
			if x then
				name = x:sub(-5)
			end
		if UnitCanAttack("player",unitID) and (UnitAffectingCombat(unitID) or IsDummy(unitID)) and UnitHealthMax(unitID) > 5 then
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

local function APL()
IsDummy()
HealthPotionSelected()
UseItems()
MissingAOERend()
allMobsinRange(range)
HL.GetEnemies("Melee")
HL.GetEnemies(5, true)
HL.GetEnemies(8, true)
HL.GetEnemies(10, true)
HL.GetEnemies(11, true)
HL.GetEnemies(12, true)
HL.GetEnemies(15, true)
HL.GetEnemies(17, true)
HL.GetEnemies(20, true)
HL.GetEnemies(22, true)
HL.GetEnemies(25, true)
HL.GetEnemies(30, true)

--------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------Functions/Top priorities----------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
if Player:IsCasting() or Player:IsChanneling() then
	return 0, "Interface\\Addons\\Rubim-RH\\Media\\channel.tga"
elseif Player:IsDeadOrGhost() or AuraUtil.FindAuraByName("Drink", "player") or AuraUtil.FindAuraByName("Food", "player") 
or AuraUtil.FindAuraByName("Food & Drink", "player") then
	return 0, "Interface\\Addons\\Rubim-RH\\Media\\mount2.tga"
end

start, duration, enabled = GetSpellCooldown("Execute");
ExecuteCD = duration - (GetTime() - start)

if ExecuteCD <= Player:GCDRemains() * 1.05 then 
	ExecuteCD = 0
end
--------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------Out of Combat---------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
if not Player:AffectingCombat() then


end
--------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------Spell Queue-----------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
if not RubimRH.queuedSpell[1]:CooldownUp() or not Player:AffectingCombat() then
	RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
end

if RubimRH.QueuedSpell():IsReadyQueue() then
    return RubimRH.QueuedSpell():Cast()
end
--------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------Interrupts------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
if S.Pummel:IsReadyQueue(8) and select(8, UnitCastingInfo("target")) == false and Target:CastPercentage() > math.random(43, 87) and RubimRH.InterruptsON() and Player:AffectingCombat() then
	return S.Pummel:Cast()
end
--------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------Cooldowns-------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
if S.ImpendingVictory:IsReady(8) and Player:HealthPercentage() <= 30 then
	return S.ImpendingVictory:Cast()
end
	
if S.DieByTheSword:IsCastable() and Player:AffectingCombat() and Player:HealthPercentage() <= 15 then
	return S.DieByTheSword:Cast()
end

if RubimRH.CDsON() then
	if Target:IsInRange(10) and (allMobsinRange(Cache.EnemiesCount[8]) or IsResting()) then
	local ShouldReturn = UseItems();
		if ShouldReturn then 
			return ShouldReturn; 
		end
	end

	if S.BloodFury:IsReadyQueue(8) and Target:DebuffRemainsP(S.ColossusSmashDebuff) >= 7 then
		return S.BloodFury:Cast()
	end
end
--------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------Rotation--------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
if S.BattleStance:IsCastableQueue() and not Player:BuffP(S.BattleStance) then
	return S.BattleStance:Cast()
end

if Cache.EnemiesCount[10] > 2 and RubimRH.AoEON() and Player:AffectingCombat() and Player:CanAttack(Target) then

	if IsUsableSpell('Execute') and ExecuteCD == 0 and Target:IsInRange(8) and (Player:BuffP(S.Juggernaut) or Player:BuffRemainsP(S.Juggernaut) < Player:GCD()) then
		return S.Execute:Cast()
    end 

	if S.SweepingStrikes:IsCastable() and (S.Bladestorm:CooldownRemainsP() > 15 or not S.Bladestorm:IsAvailable()) then
		return S.SweepingStrikes:Cast()
	end
	
	if S.ThunderClap:IsCastable() and S.BloodAndThunder:IsAvailable() and S.Rend:IsAvailable() and MissingAOERend() >= 2 then
		return S.ThunderClap:Cast()
	end
	
	if S.Avatar:IsCastable() and RubimRH.CDsON() then
		return S.Avatar:Cast()
	end
	
	if S.Warbreaker:IsReady(8) and RubimRH.CDsON() and (allMobsinRange(Cache.EnemiesCount[12]) or IsResting()) then
		return S.Warbreaker:Cast()
	end

	if S.ColossusSmash:IsReady(8) and RubimRH.CDsON() and allMobsinRange(Cache.EnemiesCount[12]) then
		return S.ColossusSmash:Cast()
	end
	
    if S.ThunderousRoar:IsCastable() and RubimRH.CDsON() and Target:DebuffP(S.ColossusSmashDebuff) and (allMobsinRange(Cache.EnemiesCount[12]) or IsResting()) then
        return S.ThunderousRoar:Cast()
    end

	if S.Cleave:IsReady(8) then
		return S.Cleave:Cast()
	end

	if S.WhirlWind:IsCastable() and Player:Rage() > 70 then
		return S.WhirlWind:Cast()
	end
	
	if S.MortalStrike:IsReady(8) and Target:DebuffStackP(S.ExecutionersPrecision) == 2 or Target:DebuffRemainsP(S.DeepWoundsDebuff) <= Player:GCD() or S.Dreadnaught:IsAvailable() and S.Battlelord:IsAvailable() and Cache.EnemiesCount[8] <= 2 and Player:Rage() > 70 then
		return S.MortalStrike:Cast()
	end
	
	if IsUsableSpell('Execute') and ExecuteCD == 0 and Target:IsInRange(8) and (Player:BuffP(S.SuddenDeath) or (Target:HealthPercentage() < 20 or (S.Massacre:IsAvailable() and Target:HealthPercentage() < 35))) then
		return S.Execute:Cast()
    end 
	
    if S.Overpower:IsReady(8) and S.Overpower:ChargesFractional() == 2 and (not S.TestOfMight:IsAvailable() or S.TestOfMight:IsAvailable() and not Target:DebuffP(S.ColossusSmashDebuff) or S.Battlelord:IsAvailable()) or Player:Rage() < 70 then
        return S.Overpower:Cast()
    end

	if S.ThunderClap:IsCastable() then
		return S.ThunderClap:Cast()
	end

	if S.MortalStrike:IsReady(8) then
		return S.MortalStrike:Cast()
	end
	
	if S.Slam:IsReady(8) and S.CrushingForce:IsAvailable() and Player:Rage() > 30 and not S.FervorOfBattle:IsAvailable() then
		return S.Slam:Cast()
	end

elseif Cache.EnemiesCount[10] >= 1 and (Target:HealthPercentage() < 20 or (S.Massacre:IsAvailable() and Target:HealthPercentage() < 35)) and Player:AffectingCombat() and Player:CanAttack(Target) then

	if S.SweepingStrikes:IsCastable() and Cache.EnemiesCount[8] > 1 then
		return S.SweepingStrikes:Cast()
	end
	
	if S.Rend:IsReady(8) and Cache.EnemiesCount[8] > 1 and Target:DebuffRemainsP(S.RendDebuff) <= Player:GCD() and (not S.Warbreaker:IsAvailable() and Target:DebuffRemainsP(S.ColossusSmashDebuff) < 4) then
		return S.Rend:Cast()
	end

	if S.Avatar:IsCastable() and RubimRH.CDsON() and (S.ColossusSmash:CooldownUp() or Target:DebuffP(S.ColossusSmashDebuff)) then
		return S.Avatar:Cast()
	end
	
	if S.Warbreaker:IsReady(8) and RubimRH.CDsON() and (allMobsinRange(Cache.EnemiesCount[12]) or IsResting()) then
		return S.Warbreaker:Cast()
	end
	
	if S.ColossusSmash:IsReady(8) and RubimRH.CDsON() and allMobsinRange(Cache.EnemiesCount[12]) then
		return S.ColossusSmash:Cast()
	end
	
	if S.ThunderousRoar:IsCastable() and RubimRH.CDsON() and Target:DebuffP(S.ColossusSmashDebuff) and (allMobsinRange(Cache.EnemiesCount[12]) or IsResting()) then
		return S.ThunderousRoar:Cast()
	end
	
	if S.MortalStrike:IsReady(8) and Target:DebuffStackP(S.ExecutionersPrecision) == 2 or Target:DebuffRemainsP(S.DeepWoundsDebuff) <= Player:GCD() then
		return S.MortalStrike:Cast()
	end
	
	if S.Rend:IsReady(8) and Target:DebuffRemainsP(S.RendDebuff) <= Player:GCD() and not Target:DebuffP(S.ColossusSmashDebuff) then
		return S.Rend:Cast()
	end

	if IsUsableSpell('Execute') and ExecuteCD == 0 and Target:IsInRange(8) then
		return S.Execute:Cast()
    end
	
	if S.Overpower:IsReady(8) then
		return S.Overpower:Cast()
	end

elseif (Cache.EnemiesCount[10] <= 2 and Cache.EnemiesCount[10] >= 1) or not RubimRH.AoEON() and Player:AffectingCombat() and Player:CanAttack(Target) then
	
	if S.Rend:IsReady(8) and Target:DebuffRemainsP(S.RendDebuff) <= Player:GCD() or S.TideOfBlood:IsAvailable() and Player:CooldownRemainsP(S.Skullsplitter) <= Player:GCD() and (Player:CooldownRemainsP(S.ColossusSmash) <= Player:GCD() or Target:DebuffP(S.ColossusSmashDebuff)) and Target:DebuffRemainsP(S.RendDebuff) < Target:DebuffRemainsP(S.Rend) * 0.85 then
		return S.Rend:Cast()
	end

	if S.Avatar:IsCastable() and RubimRH.CDsON() and Target:DebuffP(S.ColossusSmashDebuff) then
		return S.Avatar:Cast()
	end

	if S.Warbreaker:IsReady(8) and RubimRH.CDsON() and (allMobsinRange(Cache.EnemiesCount[12]) or IsResting()) then
		return S.Warbreaker:Cast()
	end
	
	if S.ColossusSmash:IsReady(8) and RubimRH.CDsON() and allMobsinRange(Cache.EnemiesCount[12]) then
		return S.ColossusSmash:Cast()
	end
	
	if S.ThunderousRoar:IsCastable() and RubimRH.CDsON() and Target:DebuffP(S.ColossusSmashDebuff) and (allMobsinRange(Cache.EnemiesCount[12]) or IsResting()) then
		return S.ThunderousRoar:Cast()
	end

	if S.MortalStrike:IsReady(8) and (Target:DebuffStackP(S.ExecutionersPrecision) == 2 or Target:DebuffRemainsP(S.DeepWoundsDebuff) <= Player:GCD()) then
		return S.MortalStrike:Cast()
	end

	if IsUsableSpell('Execute') and ExecuteCD == 0 and Target:IsInRange(8) and Player:BuffP(S.SuddenDeath) then
		return S.Execute:Cast()
    end

    if S.Overpower:IsReady(8) and S.Overpower:ChargesFractional() == 2 and (not Target:DebuffP(S.ColossusSmashDebuff) or Player:Rage() < 32) then
        return S.Overpower:Cast()
    end

	if S.MortalStrike:IsReady(8) then
		return S.MortalStrike:Cast()
	end

	if S.Rend:IsReady(8) and Target:DebuffRemainsP(S.RendDebuff) < 6.3 then
		return S.Rend:Cast()
	end
	
	if S.WhirlWind:IsCastable(8) and S.StormOfSwords:IsAvailable() or S.FervorOfBattle:IsAvailable() then
		return S.WhirlWind:Cast()
	end

    if S.Overpower:IsReady(8) and ((not Target:DebuffP(S.ColossusSmashDebuff) and Player:Rage() < 65) or Player:Rage() < 32) then
        return S.Overpower:Cast()
    end

	if S.Cleave:IsReady(8) and not S.CrushingForce:IsAvailable() then
		return S.Cleave:Cast()
	end

	if S.Slam:IsReady(8) and Player:Rage() > 30 and not S.FervorOfBattle:IsAvailable() then
		return S.Slam:Cast()
	end
	
	if S.WreckingThrow:IsReady() and Target:AffectingCombat() then
		return S.WreckingThrow:Cast()
	end
end
    return 0, "Interface\\Addons\\Rubim-RH\\Media\\mount2.tga"
end


RubimRH.Rotation.SetAPL(71, APL);

local function PASSIVE()
    
end

RubimRH.Rotation.SetPASSIVE(71, PASSIVE);