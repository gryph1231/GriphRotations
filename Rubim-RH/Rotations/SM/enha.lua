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
autoattack = Spell(274738), -- ancestral call
Bloodlust = Spell(2825),
primalstrike = Spell(73899),
BloodlustPVP = Spell(204361),
bloodlust = Spell(32182),
Hailstorm = Spell(334195),
HailstormBuff = Spell(334196),
Windstrike = Spell(115356),	
AncestralSpirit = Spell(2008),
AncestralGuidance = Spell(108281),
ChainLightning = Spell(188443),
EarthElemental = Spell(198103),
AstralShift = Spell(108271),
EarthbindTotem = Spell(2484),
CapacitorTotem = Spell(192058),
ConvergingStormsBuff = Spell(198300),
FlameShock = Spell(188389),
ChainHeal = Spell(1064),
ElementalAssault = Spell(210853),
Stormblast = Spell(319930),
Thunderstorm = Spell(51490),
EarthernWeapon = Spell(392375),
FlametongueWeapon = Spell(318038),
WindfuryWeapon = Spell(33757),
StaticAccumulation = Spell(384411),
FrostShock = Spell(196840),
LightningShield = Spell(192106),
GhostWolf = Spell(2645),
Purge = Spell(370),
HealingStreamTotem = Spell(5394),
LegacyOfTheFrostWitch = Spell(384451),
TremorTotem = Spell(8143),
HealingSurge = Spell(8004),
WaterWalking = Spell(546),
Hex = Spell(51514),
WindShear = Spell(57994),
Stormbringer = Spell(201846),
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
Stormstrike = Spell(17364),
WindfuryTotem = Spell(8512),
WindfuryTotemBuff = Spell(327942),
Ascendance = Spell(114051),
DoomWinds = Spell(384352),
FireNova = Spell(333974),
LightningLasso = Spell(305483),
MoltenAssault = Spell(334033),
LashingFlames = Spell(334046),
LashingFlamesDebuff = Spell(334168),
PrimordialWave = Spell(375982), 
VesperTotem = Spell(324386),
LavaBurst = Spell(51505),
DoorofShadows = Spell(300728),
MaelstromWeapon = Spell(344179),
StormKeeper = Spell(320137),
ChainHarvest = Spell(320674),
ElementalBlast = Spell(117014),
Sundering = Spell(197214),
Sunderingz = Spell(69070), --rocket jump
IceStrike = Spell(342240),
EarthenSpike = Spell(188089),
CrashingStorms = Spell(334308),
WinfuryTotemBuff = Spell(327942),
HotHand = Spell(201900),
ThorimsInvocation = Spell(384444),
Berserking = Spell(26297),
SplinteredElementsBuff = Spell(382043),
DeeplyRootedElements = Spell(378270),
healthstone = Spell(291944),
healingpot = Spell(176108),
PrimordialWaveBuff = Spell(375986),
Shamanism = Spell(193876),
SwirlingMaelstrom = Spell(384359),
OverflowingMaelstrom = Spell(384149),
FeralSpiritBuff = Spell(333957),
ElementalSpirits = Spell(242624),
}

local S = RubimRH.Spell[263]
local G = RubimRH.Spell[1] -- General Skills

-- start, duration, enabled = GetSpellCooldown(115356);
-- WindstrikeCooldown = duration - (GetTime() - start)

-- if WindstrikeCooldown < 0 then 
	-- WindstrikeCooldown = 0
-- end

local function UpdateWFB()
    if S.Stormstrike:IsReadyMorph() then
        S.Windstrike = Spell(17364)
    end
	
    S.Stormstrike.TextureSpellID = { 115356 }
    S.Windstrike.TextureSpellID = { 115356 }
end

if not Item.Shaman then Item.Shaman = {} end

Item.Shaman.Enhancement = {
    HPIcon = Item(169451),
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

local function target_is_dummy()
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

local function AOE()
	if S.LightningBolt:IsReady(40) and (FSTargets() == Cache.EnemiesCount[10] or FSTargets() == 6) and Player:BuffP(S.PrimordialWaveBuff) and Player:BuffStack(S.MaelstromWeapon) >= (5 + 5 * num(S.OverflowingMaelstrom:IsAvailable())) and not Player:BuffP(S.SplinteredElementsBuff) then
		return S.LightningBolt:Cast()
	end

	if S.LavaLash:IsReady(5) and S.MoltenAssault:IsAvailable() and (S.PrimordialWave:IsAvailable() or S.FireNova:IsAvailable()) and Target:DebuffP(S.FlameShock) and (FSTargets() < Cache.EnemiesCount[10]) and FSTargets() < 6 then
		return S.LavaLash:Cast()
	end

	if S.PrimordialWave:IsReady(40) and not Player:BuffP(S.PrimordialWaveBuff) and (FSTargets() >= Cache.EnemiesCount[10] or FSTargets() == 6) then
		return S.PrimordialWave:Cast()
	end

	if S.ElementalBlast:IsReady(40) and (not S.ElementalSpirits:IsAvailable() or (S.ElementalSpirits:IsAvailable() and (S.ElementalBlast:ChargesP() == 2 or Player:BuffP(S.FeralSpiritBuff)))) and Player:BuffStack(S.MaelstromWeapon) == 10 and (not S.CrashingStorms:IsAvailable() or Cache.EnemiesCount[10] <= 3) then
		return S.ElementalBlast:Cast()
	end

	if S.ChainLightning:IsReady(40) and Player:BuffStack(S.MaelstromWeapon) >= 10 then
		return S.ChainLightning:Cast()
	end

	if S.CrashLightning:IsReady(8) and (not Player:BuffP(S.CrashLightningBuff) or Player:Buff(S.DoomWinds)) then
		return S.CrashLightning:Cast()
	end

	if S.Sundering:IsReady(5) and RubimRH.CDsON() and Player:Buff(S.DoomWinds) and (allMobsinRange(Cache.EnemiesCount[10]) or target_is_dummy()) then
		return S.Sundering:Cast()
	end
	
	if S.FireNova:IsCastable() and (FSTargets() == 6 or (FSTargets() >= 4 and FSTargets() == Cache.EnemiesCount[10])) then
		return S.FireNova:Cast()
	end

	if S.Windstrike:IsReadyMorph(20) and S.ThorimsInvocation:IsAvailable() and S.ChainLightning:TimeSinceLastCast() < S.LightningBolt:TimeSinceLastCast() and Player:BuffStack(S.MaelstromWeapon) >= 1 then
		return S.Stormstrike:Cast()
	end

	if S.IceStrike:IsReady(5) and S.Hailstorm:IsAvailable() then
		return S.IceStrike:Cast()
	end

	if S.LavaLash:IsReady(5) and (not Target:DebuffP(S.LashingFlamesDebuff) or Target:DebuffRemainsP(S.LashingFlames) < Player:GCD()) and S.LashingFlames:IsAvailable() then
		return S.LavaLash:Cast()
	end

	if S.FrostShock:IsReady(20) and S.Hailstorm:IsAvailable() and Player:BuffP(S.HailstormBuff) then
		return S.FrostShock:Cast()
	end
	
	if S.LavaLash:IsReady(5) and S.MoltenAssault:IsAvailable() and Target:DebuffP(S.FlameShock) and (FSTargets() < Cache.EnemiesCount[10]) and FSTargets() < 6 then
		return S.LavaLash:Cast()
	end
	
	if S.Sundering:IsReady(5) and RubimRH.CDsON() and (allMobsinRange(Cache.EnemiesCount[10]) or target_is_dummy()) then
		return S.Sundering:Cast()
	end

	if S.FlameShock:IsReady(20) and S.MoltenAssault:IsAvailable() and not Target:DebuffP(S.FlameShock) then
		return S.FlameShock:Cast()
	end
	
	if S.FireNova:IsCastable() and FSTargets() >= 3 then
		return S.FireNova:Cast()
	end

	if S.Stormstrike:IsReady(5) and Player:BuffP(S.CrashLightningBuff) and (S.DeeplyRootedElements:IsAvailable() or Player:BuffStack(S.ConvergingStormsBuff) == 6) then
		return S.Stormstrike:Cast()
	end

	if S.CrashLightning:IsReady(8) and S.CrashingStorms:IsAvailable() and Player:BuffP(S.ChainLightningBuff) and Cache.EnemiesCount[10] >= 4 then
		return S.CrashLightning:Cast()
	end

	if S.Windstrike:IsReadyMorph(20) then
		return S.Stormstrike:Cast()
	end

	if S.Stormstrike:IsReady(5) then
		return S.Stormstrike:Cast()
	end

	if S.IceStrike:IsReady(5) then
		return S.IceStrike:Cast()
	end

	if S.LavaLash:IsReady(5) then
		return S.LavaLash:Cast()
	end

	if S.CrashLightning:IsReady(8) then
		return S.CrashLightning:Cast()
	end

	if S.FireNova:IsCastable() and FSTargets() >= 2 then
		return S.FireNova:Cast()
	end

	if S.ElementalBlast:IsReady(40) and (not S.ElementalSpirits:IsAvailable() or (S.ElementalSpirits:IsAvailable() and (S.ElementalBlast:ChargesP() == 2 or Player:BuffP(S.FeralSpiritBuff)))) and Player:BuffStack(S.MaelstromWeapon) >= 5 and (not S.CrashingStorms:IsAvailable() or Cache.EnemiesCount[10] <= 3) then
		return S.ElementalBlast:Cast()
	end

	if S.ChainLightning:IsReady(40) and Player:BuffStack(S.MaelstromWeapon) >= 5 then
		return S.ChainLightning:Cast()
	end

	if S.WindfuryTotem:IsCastable() and S.WindfuryTotem:IsAvailable() and not Player:BuffP(S.WindfuryTotemBuff) then
		return S.WindfuryTotem:Cast()
	end

	if S.FlameShock:IsReady(20) and not Target:Debuff(S.FlameShock) then
		return S.FlameShock:Cast()
	end

	if S.FrostShock:IsReady(20) and not S.Hailstorm:IsAvailable() then
		return S.FrostShock:Cast()
	end

	return nil
end

local function ST()
	if S.PrimordialWave:IsReady(40) and not Target:DebuffP(S.FlameShock) and S.LashingFlames:IsAvailable() then
		return S.PrimordialWave:Cast()
	end
	
	if S.FlameShock:IsReady(20) and not Target:DebuffP(S.FlameShock) and S.LashingFlames:IsAvailable() then
		return S.FlameShock:Cast()
	end

	--&feral_spirit.active>=4
	if S.ElementalBlast:IsReady(40) and Player:BuffStack(S.MaelstromWeapon) >= 5 and S.ElementalSpirits:IsAvailable() and Player:BuffP(S.FeralSpiritBuff) then
		return S.ElementalBlast:Cast()
	end

	-- --sundering,if=set_bonus.tier30_2pc&raid_event.adds.in>=40
	-- if S.Sundering:IsReady(8) and RubimRH.CDsON() then
		-- return S.Sundering:Cast()
	-- end

	if S.Windstrike:IsReadyMorph(20) and (S.ThorimsInvocation:IsAvailable() and Player:BuffStack(S.MaelstromWeapon) >= 1 and (S.DeeplyRootedElements:IsAvailable() or (S.Stormblast:IsAvailable() and Player:BuffP(S.Stormbringer)) or (S.ElementalAssault:IsAvailable() and Player:BuffStack(S.MaelstromWeapon) < (5 + 5 * num(S.OverflowingMaelstrom:IsAvailable()))) or S.LightningBolt:TimeSinceLastCast() < S.ChainLightning:TimeSinceLastCast())) then
		return S.Stormstrike:Cast()
	end

	if S.Stormstrike:IsReady(5) and (Player:BuffP(S.DoomWinds) or S.DeeplyRootedElements:IsAvailable() or (S.Stormblast:IsAvailable() and Player:BuffP(S.Stormbringer)) or (S.ElementalAssault:IsAvailable() and Player:BuffStack(S.MaelstromWeapon) < (5 + 5 * num(S.OverflowingMaelstrom:IsAvailable())))) then
		return S.Stormstrike:Cast()
	end

	if S.LavaLash:IsReady(5) and Player:BuffP(S.HotHand) then
		return S.LavaLash:Cast()
	end

	if S.WindfuryTotem:IsCastable() and S.WindfuryTotem:IsAvailable() and not Player:BuffP(S.WindfuryTotemBuff) then
		return S.WindfuryTotem:Cast()
	end

	if S.ElementalBlast:IsReady(40) and Player:BuffStack(S.MaelstromWeapon) >= 5 and S.ElementalBlast:ChargesP() == 2 then
		return S.ElementalBlast:Cast()
	end

	if S.LightningBolt:IsReady(40) and Player:BuffStack(S.MaelstromWeapon) >= 5 and Player:BuffP(S.PrimordialWaveBuff) and not Player:BuffP(S.SplinteredElementsBuff) then
		return S.LightningBolt:Cast()
	end

	if S.ChainLightning:IsReady(40) and Player:BuffStack(S.MaelstromWeapon) >= 5 and AuraUtil.FindAuraByName("Crackling Thunder", "player") then
		return S.ChainLightning:Cast()
	end
	
	if S.LightningBolt:IsReady(40) and Player:BuffStack(S.MaelstromWeapon) >= 5 and not AuraUtil.FindAuraByName("Crackling Thunder", "player") and Player:BuffP(S.Ascendance) and S.LightningBolt:TimeSinceLastCast() < S.ChainLightning:TimeSinceLastCast() then
		return S.LightningBolt:Cast()
	end
	
	if S.ElementalBlast:IsReady(40) and Player:BuffStack(S.MaelstromWeapon) >= 5 and (Player:BuffP(S.FeralSpiritBuff) or not S.ElementalSpirits:IsAvailable()) then
		return S.ElementalBlast:Cast()
	end

	if S.LavaBurst:IsReady(40) and not S.ThorimsInvocation:IsAvailable() and Player:BuffStack(S.MaelstromWeapon) >= 5 then
		return S.LavaBurst:Cast()
	end

	if S.LightningBolt:IsReady(40) and ((Player:BuffStack(S.MaelstromWeapon) == (5 + 5 * num(S.OverflowingMaelstrom:IsAvailable()))) or (S.StaticAccumulation:IsAvailable() and Player:BuffStack(S.MaelstromWeapon) >= 5)) and not Player:BuffP(S.PrimordialWaveBuff) then
		return S.LightningBolt:Cast()
	end

	if S.IceStrike:IsReady(5) and not Player:BuffP(S.DoomWinds) then
		return S.IceStrike:Cast()
	end

	if S.Sundering:IsReady(5) and Player:BuffP(S.DoomWinds) and (allMobsinRange(Cache.EnemiesCount[10]) or target_is_dummy()) then
		return S.Sundering:Cast()
	end

	if S.CrashLightning:IsReady(8) and Player:BuffP(S.DoomWinds) then
		return S.CrashLightning:Cast()
	end

	if S.PrimordialWave:IsReady(40) and RubimRH.CDsON() then
		return S.PrimordialWave:Cast()
	end

	if S.FlameShock:IsReady(20) and not Target:DebuffP(S.FlameShock) then
		return S.FlameShock:Cast()
	end

	if S.LavaLash:IsReady(5) and S.MoltenAssault:IsAvailable() and Target:DebuffRemainsP(S.FlameShock) < 8 then
		return S.LavaLash:Cast()
	end

	if S.IceStrike:IsReady(5) then
		return S.IceStrike:Cast()
	end

	if S.FrostShock:IsReady(20) and Player:BuffP(S.HailstormBuff) then
		return S.FrostShock:Cast()
	end

	if S.LavaLash:IsReady(5) then
		return S.LavaLash:Cast()
	end

	if S.Windstrike:IsReadyMorph(5) then
		return S.Stormstrike:Cast()
	end

	if S.Stormstrike:IsReady(5) then
		return S.Stormstrike:Cast()
	end

	if S.Sundering:IsReady(5) and RubimRH.CDsON() and (allMobsinRange(Cache.EnemiesCount[10]) or target_is_dummy()) then
		return S.Sundering:Cast()
	end

	if S.FireNova:IsCastable() and S.SwirlingMaelstrom:IsAvailable() and FSTargets() >= 1 and Player:BuffStack(S.MaelstromWeapon) < (5 + 5 * num(S.OverflowingMaelstrom:IsAvailable())) then
		return S.FireNova:Cast()
	end

	if S.LightningBolt:IsReady(40) and S.Hailstorm:IsAvailable() and Player:BuffStack(S.MaelstromWeapon) >= 5 and not Player:BuffP(S.PrimordialWaveBuff) then
		return S.LightningBolt:Cast()
	end
	
	if S.FrostShock:IsReady(20) then
		return S.FrostShock:Cast()
	end

	if S.CrashLightning:IsReady(8) then
		return S.CrashLightning:Cast()
	end
	
	if S.FireNova:IsCastable() and FSTargets() >= 1 then
		return S.FireNova:Cast()
	end

	if S.FlameShock:IsReady(20) then
		return S.FlameShock:Cast()
	end

	if S.LightningBolt:IsReady(40) and Player:BuffStack(S.MaelstromWeapon) >= 5 and not Player:BuffP(S.PrimordialWaveBuff) then
		return S.LightningBolt:Cast()
	end
	
	return nil
end

local function APL()
HL.GetEnemies(5, true);
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
	if S.WindfuryWeapon:IsCastable() and mhenchantremains < 300 then
		return S.WindfuryWeapon:Cast()
	end

	if S.FlametongueWeapon:IsCastable() and ohenchantremains < 300 then
		return S.FlametongueWeapon:Cast()
	end

	if S.EarthShield:IsCastable() and (not Player:BuffP(S.EarthShield) or Player:BuffStack(S.EarthShield) < 7)  then
		return S.EarthShield:Cast()
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

if S.LightningLasso:ID() == RubimRH.queuedSpell[1]:ID() then
	return S.LightningLasso:Cast()
end

if S.Thunderstorm:ID() == RubimRH.queuedSpell[1]:ID() then
	return S.Thunderstorm:Cast()
end

if S.PrimordialWave:ID() == RubimRH.queuedSpell[1]:ID() then
	return S.PrimordialWave:Cast()
end

if S.EarthbindTotem:ID() == RubimRH.queuedSpell[1]:ID() then
	return S.EarthbindTotem:Cast()
end

if S.GhostWolf:ID() == RubimRH.queuedSpell[1]:ID() then
	return S.GhostWolf:Cast()
end

if S.EarthElemental:ID() == RubimRH.queuedSpell[1]:ID() then
	return S.EarthElemental:Cast()
end

if S.FeralSpirit:ID() == RubimRH.queuedSpell[1]:ID() then
	return S.FeralSpirit:Cast()
end

if S.Sundering:ID() == RubimRH.queuedSpell[1]:ID() then
	return S.Sundering:Cast()
end

if S.DoomWinds:ID() == RubimRH.queuedSpell[1]:ID() then
	return S.DoomWinds:Cast()
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
if Player:HealthPercentage() <= 25 and Player:AffectingCombat() and (IsUsableItem(191379) or IsUsableItem(191378) or IsUsableItem(191380)) and (GetItemCooldown(191380) == 0 or GetItemCooldown(191379) == 0 or GetItemCooldown(191378) == 0) and (GetItemCount(191380) >= 1 or GetItemCount(191379) >= 1 or GetItemCount(191378) >= 1) and (not Player:InArena() and not Player:InBattlegrounds()) then
	return I.HPIcon:Cast()
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

-- if S.WindfuryTotem:IsReadyQueue(8) and (Player:MovingFor() <= Player:GCD() or (allMobsinRange(Cache.EnemiesCount[10]) and tarSpeed == 0)) and not Player:BuffP(S.WindfuryBuff) then
	-- return S.WindfuryTotem:Cast()
-- end

if Player:AffectingCombat() and Player:CanAttack(Target) and Target:IsInRange(40) then

	if RubimRH.CDsON() then
		if S.Berserking:IsReady(15) and Player:BuffP(S.Ascendance) then
			return S.Berserking:Cast()
		end
	
		if S.FeralSpirit:IsReady(15) then
			return S.FeralSpirit:Cast()
		end

		if S.DoomWinds:IsReady(15) then
			return S.DoomWinds:Cast()
		end
	end

	if Cache.EnemiesCount[15] >= 2 and RubimRH.AoEON() then	
		if AOE() then
			return AOE()
		end
	elseif Cache.EnemiesCount[15] < 2 or not RubimRH.AoEON() then
		if ST() then
			return ST()
		end
	end
end

    return 0, "Interface\\Addons\\Rubim-RH\\Media\\mount2.tga"
end




RubimRH.Rotation.SetAPL(263, APL);

local function PASSIVE()
    
end

RubimRH.Rotation.SetPASSIVE(263, PASSIVE);