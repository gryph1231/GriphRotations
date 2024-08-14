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

if not Spell.Shaman then
    Spell.Shaman = {};
end

RubimRH.Spell[263] = {
autoattack = Spell(20572), -- blood fury
Bloodlust = Spell(2825),
primalstrike = Spell(73899),
BloodlustPVP = Spell(204361),
bloodlust = Spell(32182),
Hailstorm = Spell(334195),
Windstrike = Spell(115356),	
AncestralSpirit = Spell(2008),
ChainLightning = Spell(188443),
EarthElemental = Spell(198103),
AstralShift = Spell(108271),
EarthbindTotem = Spell(2484),
CapacitorTotem = Spell(192058),
FlameShock = Spell(188389),
ChainHeal = Spell(1064),
EarthernWeapon = Spell(392375),
FlametongueWeapon = Spell(318038),
WindfuryWeapon = Spell(33757),
FrostShock = Spell(196840),
FrostShockz = Spell(287712), --haymaker
LightningShield = Spell(192106),
GhostWolf = Spell(2645),
Purge = Spell(370),
HealingStreamTotem = Spell(5394),
LegacyOfTheFrostWitch = Spell(384451),
TremorTotem = Spell(8143),
PrimordialWave = Spell(375982),
PrimordialWavez = Spell(274738), --ancestral call
PrimordialWaveBuff = Spell(375986),
HealingSurge = Spell(8004),
WaterWalking = Spell(546),
Hex = Spell(51514),
WindShear = Spell(57994),
StormBringer = Spell(201846),
LightningBolt = Spell(188196),
CleanseSpirit = Spell(51886),
CrashLightning = Spell(187874),
CrashLightningBuff = Spell(187878),
ChainLightningBuff = Spell(333964),
EarthShield = Spell(974),
FeralLunge = Spell(196884),
FeralSpirit = Spell(51533),
LavaLash = Spell(60103),
SpiritWalk = Spell(58875),
StormStrike = Spell(17364),
WindfuryTotem = Spell(8512),
WindfuryBuff = Spell(327942),
Ascendance = Spell(114051),
DoomWinds = Spell(384352),
DoomWindsz = Spell(265221), --fireblood
FireNova = Spell(333974),
LashingFlames = Spell(334168),
VesperTotem = Spell(324386),
DoorofShadows = Spell(300728),
MaelstromWeapon = Spell(344179),
StormKeeper = Spell(320137),
ChainHarvest = Spell(320674),
-- FaeTransfusion = Spell(),
ElementalBlast = Spell(117014),
Sundering = Spell(197214),
Sunderingz = Spell(69070), --rocket jump
IceStrike = Spell(342240),
EarthenSpike = Spell(188089),
CrashingStorm = Spell(192246),
WinfuryTotemBuff = Spell(327942),
HotHandBuff = Spell(215785),
AshenCatalystBuff = Spell(390371),
Berserking = Spell(26297),
healthstone = Spell(291944),
healingpot = Spell(176108),
Shamanism = Spell(193876),
FeralSpiritBuff = Spell(333957),
}

local S = RubimRH.Spell[263]
local G = RubimRH.Spell[1] -- General Skills

local function UpdateWFB()
    if S.StormStrike:IsReadyMorph() then
        S.Windstrike = Spell(17364)
    end
    S.StormStrike.TextureSpellID = { 115356 }

    S.Windstrike.TextureSpellID = { 115356 }
end

if not Item.Shaman then Item.Shaman = {} end

Item.Shaman.Enhancement = {


};

local I = Item.Shaman.Enhancement;

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

local function range25AC()
   local inCombat25 = 0
		for id = 1, 40 do
		local unitID = "nameplate" .. id
		if UnitAffectingCombat("target", unitID) and IsItemInRange(10645, unitID) then
			inCombat25 = inCombat25 + 1
		end
   end
   return inCombat25
end

local function FSTargets()
local inRange15 = 0
local FSAoe = 0

    for id = 1, 40 do
		local unitID = "nameplate" .. id
		if UnitCanAttack("player", unitID) and IsItemInRange(33069, unitID) then
			inRange15 = inRange15 + 1
		end
	end
	
    for id = 1, 40 do
    local unitID = "nameplate" .. id
		if UnitCanAttack("player", unitID) and IsItemInRange(33069, unitID) and AuraUtil.FindAuraByName("Flame Shock",unitID,"PLAYER|HARMFUL") then
			FSAoe = FSAoe + 1
		end
	end

	return FSAoe
end

local function allMobsinRange(range)
local totalRange40 = 0
local allMobsinRange = false

	for id = 1, 40 do
		local unitID = "nameplate" .. id
		if UnitCanAttack("player", unitID) and IsItemInRange(4945, unitID)
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

local function APL()
HL.GetEnemies(8, true);
HL.GetEnemies(10, true);
HL.GetEnemies(12, true);
HL.GetEnemies(15, true);
HL.GetEnemies(25, true);
allMobsinRange()
range25AC()
FSTargets()
--------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------Functions/Top priorities-------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
if Player:IsCasting() or Player:IsChanneling() then
	return 0, "Interface\\Addons\\Rubim-RH\\Media\\channel.tga"
elseif Player:IsDeadOrGhost() or AuraUtil.FindAuraByName("Drink", "player") or AuraUtil.FindAuraByName("Food", "player") 
or AuraUtil.FindAuraByName("Food & Drink", "player") or AuraUtil.FindAuraByName("Feign Death", "player") or AuraUtil.FindAuraByName("Ghost Wolf", "player") then
	return 0, "Interface\\Addons\\Rubim-RH\\Media\\mount2.tga"
end

local name, text, texture, startTimeMS, endTimeMS, isTradeSkill, castID, notInterruptible, spellId = UnitCastingInfo("target")
tarSpeed,_,_,_ = GetUnitSpeed('target')

local hasMainHandEnchant, mainHandExpiration, mainHandCharges, mainHandEnchantID, hasOffHandEnchant, offHandExpiration, offHandCharges, offHandEnchantID = GetWeaponEnchantInfo()

if hasMainHandEnchant ~= true then
	mhenchantremains = 0
elseif hasMainHandEnchant == true then 
	mhenchantremains = mainHandExpiration*0.001
end
if hasOffHandEnchant ~= true then
	ohenchantremains = 0
elseif hasOffHandEnchant == true then 
	ohenchantremains = offHandExpiration*0.001
end
--------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------Out of Combat-------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
if not Player:AffectingCombat() then
	if S.WindfuryWeapon:IsCastableQueue() and mhenchantremains < 300 then
		return S.WindfuryWeapon:Cast()
	end

	if S.FlametongueWeapon:IsCastableQueue() and ohenchantremains < 300 then
		return S.FlametongueWeapon:Cast()
	end

	if S.LightningShield:IsCastableQueue() and not Player:BuffP(S.LightningShield) then
		return S.LightningShield:Cast()
	end
end
--------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------Spell Queue--------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
if not RubimRH.queuedSpell[1]:CooldownUp() or not Player:AffectingCombat() or AuraUtil.FindAuraByName("Ghost Wolf", "player") then
	RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
end

if S.CapacitorTotem:ID() == RubimRH.queuedSpell[1]:ID() then
	return S.CapacitorTotem:Cast()
end

if S.TremorTotem:ID() == RubimRH.queuedSpell[1]:ID() then
	return S.TremorTotem:Cast()
end

if S.EarthbindTotem:ID() == RubimRH.queuedSpell[1]:ID() then
	return S.EarthbindTotem:Cast()
end

if S.GhostWolf:ID() == RubimRH.queuedSpell[1]:ID() then
	return S.GhostWolf:Cast()
end

if S.PrimordialWave:ID() == RubimRH.queuedSpell[1]:ID() then
	return S.PrimordialWavez:Cast()
end

if S.EarthElemental:ID() == RubimRH.queuedSpell[1]:ID() then
	return S.EarthElemental:Cast()
end

if S.FeralSpirit:ID() == RubimRH.queuedSpell[1]:ID() then
	return S.FeralSpirit:Cast()
end

if S.Sundering:ID() == RubimRH.queuedSpell[1]:ID() then
	return S.Sunderingz:Cast()
end

if S.DoomWinds:ID() == RubimRH.queuedSpell[1]:ID() then
	return S.DoomWindsz:Cast()
end

if RubimRH.QueuedSpell():IsReadyQueue() and not S.DoomWinds:ID() == RubimRH.queuedSpell[1]:ID() then
    return RubimRH.QueuedSpell():Cast()
end
--------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------Interrupts---------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
if S.WindShear:IsReadyQueue() and notInterruptible == false and Target:CastPercentage() > math.random(43,87) and RubimRH.InterruptsON() and Target:AffectingCombat() then
	return S.WindShear:Cast()
end
--------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------Cooldowns----------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
if RubimRH.CDsON() then
	if S.FeralSpirit:IsReadyQueue(10) then
		return S.FeralSpirit:Cast()
	end
end
--------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------Rotation-----------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
if not IsCurrentSpell(6603) and Player:CanAttack(Target) and Target:AffectingCombat() and Target:IsInRange(20) then
	return S.autoattack:Cast()
end	

if S.WindfuryWeapon:IsCastableQueue() and mhenchantremains < 10 then
	return S.WindfuryWeapon:Cast()
end

if S.FlametongueWeapon:IsCastableQueue() and ohenchantremains < 10 then
	return S.FlametongueWeapon:Cast()
end

if Player:AffectingCombat() and Player:CanAttack(Target) and Target:IsInRange(40) then

	if Cache.EnemiesCount[10] > 1 and RubimRH.AoEON() then
	
		if S.LavaLash:IsReadyQueue(8) and Target:DebuffP(S.FlameShock) and FSTargets() < 6 and FSTargets() < Cache.EnemiesCount[10] then
            return S.LavaLash:Cast()
        end
	
		if S.FlameShock:IsReadyQueue(40) and not Target:DebuffP(S.FlameShock) and FSTargets() < 6 then
			return S.FlameShock:Cast()
		end

		if S.LightningBolt:IsReadyQueue(40) and Player:BuffStack(S.MaelstromWeapon) == 10 and Player:BuffP(S.PrimordialWaveBuff) then
			return S.LightningBolt:Cast()
		end

		if S.ChainLightning:IsReadyQueue(40) and Player:BuffStack(S.MaelstromWeapon) == 10 then
			return S.ChainLightning:Cast()
		end
		
		if S.FireNova:IsCastableQueue() and FSTargets() == 6 then
			return S.FireNova:Cast()
		end

		if S.CrashLightning:IsReadyQueue(8) and Cache.EnemiesCount[8] >= 2 and not Player:BuffP(S.CrashLightningBuff) then
			return S.CrashLightning:Cast()
		end
		
		if S.PrimordialWave:IsReadyQueue(8) and RubimRH.CDsON() then
			return S.PrimordialWavez:Cast()
		end
		
		if S.LavaLash:IsReadyQueue(8) and Target:DebuffP(S.FlameShock) and not Target:DebuffP(S.LashingFlames) then
            return S.LavaLash:Cast()
        end

		if S.CrashLightning:IsReadyQueue(8) and Cache.EnemiesCount[8] >= 2 and Player:BuffP(S.ChainLightningBuff) then
			return S.CrashLightning:Cast()
		end

		if S.Sundering:IsReadyQueue(8) and RubimRH.CDsON() and allMobsinRange(Cache.EnemiesCount[10]) then
			return S.Sunderingz:Cast()
		end	

		if S.FireNova:IsCastableQueue() and FSTargets() >= 4 then
			return S.FireNova:Cast()
		end

		if S.LavaLash:IsReadyQueue(8) and Player:BuffP(S.CrashLightningBuff) then
			return S.LavaLash:Cast()
		end

		if S.ElementalBlast:IsReadyQueue(40) and Player:BuffP(S.FeralSpiritBuff) and Player:BuffStack(S.MaelstromWeapon) >= 8 then
			return S.ElementalBlast:Cast()
		end

		if S.StormStrike:IsReadyQueue(8) and Player:BuffP(S.CrashLightningBuff) then
			return S.StormStrike:Cast()
		end
		
		if S.CrashLightning:IsReadyQueue(8) and Cache.EnemiesCount[8] >= 2 then
			return S.CrashLightning:Cast()
		end

		if S.FireNova:IsCastableQueue() and FSTargets() >= 2 then
			return S.FireNova:Cast()
		end

		if S.FrostShock:IsReadyQueue(40) then
			return S.FrostShockz:Cast()
		end

		if S.ChainLightning:IsReadyQueue(40) and Player:BuffStack(S.MaelstromWeapon) >= 5 then
			return S.ChainLightning:Cast()
		end
	
	elseif Cache.EnemiesCount[10] == 1 or not RubimRH.AoEON() then
	
		if S.LavaLash:IsReadyQueue(8) and Player:BuffP(S.HotHandBuff) or Player:BuffStack(S.AshenCatalystBuff) >= 8 then
            return S.LavaLash:Cast()
        end
	
		if S.FlameShock:IsReadyQueue(40) and not Target:DebuffP(S.FlameShock) and FSTargets() < 6 then
			return S.FlameShock:Cast()
		end
	
		if S.LightningBolt:IsReadyQueue(40) and Player:BuffStack(S.MaelstromWeapon) == 10 and Player:BuffP(S.PrimordialWaveBuff) then
			return S.LightningBolt:Cast()
		end
	
		if S.PrimordialWave:IsReadyQueue(8) and RubimRH.CDsON() then
			return S.PrimordialWavez:Cast()
		end
	
		if S.ElementalBlast:IsReadyQueue(40) and Player:BuffP(S.FeralSpiritBuff) and Player:BuffStack(S.MaelstromWeapon) == 10 then
			return S.ElementalBlast:Cast()
		end
	
		if S.LavaLash:IsReadyQueue(8) and Target:DebuffP(S.FlameShock) and Target:DebuffRemainsP(S.FlameShock) < 4 then
			return S.LavaLash:Cast()
		end
	
		if S.ElementalBlast:IsReadyQueue(40) and Player:BuffStack(S.MaelstromWeapon) == 10 then
			return S.ElementalBlast:Cast()
		end
	
		if S.LightningBolt:IsReadyQueue(40) and Player:BuffStack(S.MaelstromWeapon) == 10 then
			return S.LightningBolt:Cast()
		end
	
		if S.StormStrike:IsReadyQueue(8) then
			return S.StormStrike:Cast()
		end
	
		if S.LavaLash:IsReadyQueue(8) then
			return S.LavaLash:Cast()
		end
	
		if S.Sundering:IsReadyQueue(8) and RubimRH.CDsON() then
			return S.Sunderingz:Cast()
		end
	
		if S.FireNova:IsCastableQueue() and FSTargets() >= 1 then
			return S.FireNova:Cast()
		end
	
		if S.LightningBolt:IsReadyQueue(40) and Player:BuffStack(S.MaelstromWeapon) >= 5 and not Player:BuffP(S.PrimordialWaveBuff) then
			return S.LightningBolt:Cast()
		end

		if S.FrostShock:IsReadyQueue(40) then
			return S.FrostShockz:Cast()
		end
		
		if S.CrashLightning:IsReadyQueue(8) then
			return S.CrashLightning:Cast()
		end
	
		if S.FlameShock:IsReadyQueue(40) then
			return S.FlameShock:Cast()
		end
	end
end

    return 0, "Interface\\Addons\\Rubim-RH\\Media\\mount2.tga"
end




RubimRH.Rotation.SetAPL(263, APL);

local function PASSIVE()
    
end

RubimRH.Rotation.SetPASSIVE(263, PASSIVE);