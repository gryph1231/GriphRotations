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
Tempestz = Spell(20549), --war stomp
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
StoneBulwarkTotem = Spell(108270),
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
WindRushTotem = Spell(192077),
ElementalSpirits = Spell(242624),
Skyfury = Spell(462854),
}

local S = RubimRH.Spell[263]
local G = RubimRH.Spell[1] -- General Skills
S.StoneBulwarkTotem.TextureSpellID = { 255654 } --bullrush
S.Skyfury.TextureSpellID = { 8512 } --windfurry totem

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

--LOS CHECK
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



local function FSTargets()
local inRange15 = 0
local FSAoe = 0

    for id = 1, 40 do
		local unitID = "nameplate" .. id
		if UnitCanAttack("player", unitID) and C_Item.IsItemInRange(33069, unitID) then
			inRange15 = inRange15 + 1
		end
	end
	
    for id = 1, 40 do
    local unitID = "nameplate" .. id
		if UnitCanAttack("player", unitID) and C_Item.IsItemInRange(33069, unitID) and AuraUtil.FindAuraByName("Flame Shock",unitID,"PLAYER|HARMFUL") then
			FSAoe = FSAoe + 1
		end
	end

	return FSAoe
end

local function AOE()
	if IsReady("Tempest",1) and Player:BuffStack(S.MaelstromWeapon) >= 10 and C_Spell.GetSpellInfo("Lightning Bolt").iconID == 5927653 then
		return S.Tempestz:Cast()
	end

	if IsReady("Windstrike",1) and Player:BuffUp(S.Ascendance) then
		return S.Windstrike:Cast()
	end

	if IsReady("Primordial Wave",1) and IsReady("Tempest") and RubimRH.CDsON() then
		return S.PrimordialWave:Cast()
	end

	if IsReady("Lava Lash",1) and AuraUtil.FindAuraByName("Flame Shock", "target", "HARMFUL") and (FSTargets() < RangeCount(10)) and FSTargets() < 6 then
		return S.LavaLash:Cast()
	end

	if IsReady("Feral Spirit") and RubimRH.CDsON() then
		return S.FeralSpirit:Cast()
	end

	if IsReady("Lightning Bolt",1) and Player:BuffStack(S.MaelstromWeapon) >= 5 and (AuraUtil.FindAuraByName("Primordial Wave", "player") and Player:BuffRemains(S.PrimordialWaveBuff) < 3) and C_Spell.GetSpellInfo("Lightning Bolt").iconID == 136048 then
		return S.LightningBolt:Cast()
	end
		
	if C_Spell.GetSpellInfo("Lightning Bolt").iconID ~= 5927653 then
		--review this line
		if IsReady("Chain Lightning",1) and ((Player:BuffStack(S.MaelstromWeapon) >= 5 and AuraUtil.FindAuraByName("Arc Discharge", "player")) or Player:BuffStack(S.MaelstromWeapon) >= 8) then
			return S.ChainLightning:Cast()
		end
	end

	if IsReady("Fire Nova") and ((TargetinRange(8) and FSTargets() >= 1) or FSTargets() >= 6) then
		return S.FireNova:Cast()
	end

	if IsReady("Doom Winds") and TargetinRange(8) and RubimRH.CDsON() then
		return S.DoomWinds:Cast()
	end

	if IsReady("Crash Lightning") and TargetinRange(8) and (not AuraUtil.FindAuraByName("Crash Lightning", "player") or AuraUtil.FindAuraByName("Doom Winds", "player")) then
		return S.CrashLightning:Cast()
	end

	if IsReady("Sundering") and RubimRH.CDsON() then
		return S.Sundering:Cast()
	end

	if IsReady("Stormstrike",1) then
		return S.Stormstrike:Cast()
	end

	if IsReady("Flame Shock",1) and not AuraUtil.FindAuraByName("Flame Shock", "target", "HARMFUL") then
		return S.FlameShock:Cast()
	end

	if IsReady("Lava Lash",1) then
		return S.LavaLash:Cast()
	end

	if IsReady("Crash Lightning") and TargetinRange(8) then
		return S.CrashLightning:Cast()
	end

	if IsReady("Frost Shock",1) then
		return S.FrostShock:Cast()
	end

	return nil
end

local function ST()
	if IsReady("Tempest",1) and Player:BuffStack(S.MaelstromWeapon) >= 10 and C_Spell.GetSpellInfo("Lightning Bolt").iconID == 5927653 then
		return S.Tempestz:Cast()
	end

	if IsReady("Windstrike",1) and Player:BuffUp(S.Ascendance) then
		return S.Windstrike:Cast()
	end

	if IsReady("Feral Spirit") and RubimRH.CDsON() then
		return S.FeralSpirit:Cast()
	end

	if IsReady("Primordial Wave",1) and IsReady("Tempest") and RubimRH.CDsON() then
		return S.PrimordialWave:Cast()
	end

	if IsReady("Lightning Bolt",1) and Player:BuffStack(S.MaelstromWeapon) >= 10 and C_Spell.GetSpellInfo("Lightning Bolt").iconID == 136048 then
		return S.LightningBolt:Cast()
	end

	if IsReady("Doom Winds",1) and RubimRH.CDsON() then
		return S.DoomWinds:Cast()
	end

	if IsReady("Stormstrike",1) then
		return S.Stormstrike:Cast()
	end

	if IsReady("Lightning Bolt",1) and Player:BuffStack(S.MaelstromWeapon) >= 5 and C_Spell.GetSpellInfo("Lightning Bolt").iconID == 136048 then
		return S.LightningBolt:Cast()
	end

	if IsReady("Sundering") and RubimRH.CDsON() and TargetinRange(8) then
		return S.Sundering:Cast()
	end

	if IsReady("Flame Shock",1) and not Target:DebuffUp(S.FlameShock) then
		return S.FlameShock:Cast()
	end

	if IsReady("Lava Lash",1) then
		return S.LavaLash:Cast()
	end

	if IsReady("Crash Lightning") and TargetinRange(8) then
		return S.CrashLightning:Cast()
	end

	if IsReady("Fire Nova") and ((TargetinRange(8) and FSTargets() >= 1) or FSTargets() >= 6) then
		return S.FireNova:Cast()
	end

	if IsReady("Frost Shock",1) then
		return S.FrostShock:Cast()
	end
	
	return nil
end

local function APL()

	if UnitExists('focus') and AuraUtil.FindAuraByName('Earth Shield','focus') then
        _, _, earthshieldstack = AuraUtil.FindAuraByName('Earth Shield','focus')
    else
        earthshieldstack = 0
    end


	local lostimer = GetTime() - losCheckTimer
	local los
	
	if lostimer < Player:GCD() then
		los = true
	else
		los = false
	end
--------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------Functions/Top priorities-------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
if Player:IsCasting() or Player:IsChanneling() then
	return 0, "Interface\\Addons\\Rubim-RH\\Media\\channel.tga"
elseif Player:IsDeadOrGhost() or AuraUtil.FindAuraByName("Drink", "player") or AuraUtil.FindAuraByName("Food", "player") 
or AuraUtil.FindAuraByName("Food & Drink", "player") or AuraUtil.FindAuraByName("Ghost Wolf", "player") then
	return 0, "Interface\\Addons\\Rubim-RH\\Media\\griph.tga"
end

-- local name, text, texture, startTimeMS, endTimeMS, isTradeSkill, castID, notInterruptible, spellId = UnitCastingInfo("target")
-- tarSpeed,_,_,_ = GetUnitSpeed('target')

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
	if IsReady("Windfury Weapon") and mhenchantremains < 300 then
		return S.WindfuryWeapon:Cast()
	end

	if IsReady("Flametongue Weapon") and ohenchantremains < 300 then
		return S.FlametongueWeapon:Cast()
	end

	if IsReady("Lightning Shield") and not Player:BuffUp(S.LightningShield) then
		return S.LightningShield:Cast()
	end

	if IsReady("Skyfury") and not Player:BuffUp(S.Skyfury) then
		return S.Skyfury:Cast()
	end
	
	if 	los == false and UnitExists('focus') and C_Spell.IsSpellInRange("Earth Shield", "focus") then 
		if IsReady("Earth Shield") and earthshieldstack<7 then
			return S.EarthShield:Cast()
		end
	end

end
--------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------Spell Queue--------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
if (not RubimRH.queuedSpell[1]:CooldownUp() or not Player:AffectingCombat() or RangeCount(30)==0)
or (S.GhostWolf:ID() == RubimRH.queuedSpell[1]:ID() and AuraUtil.FindAuraByName("Ghost Wolf", "player")) then
	RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
end

if IsReady(RubimRH.queuedSpell[1]:ID(),nil,nil,1) and S.DoomWinds:ID() ~= RubimRH.queuedSpell[1]:ID() then
    return RubimRH.QueuedSpell():Cast()
end
--------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------Interrupts---------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
if IsReady("Wind Shear") and notInterruptible == false and Target:CastPercentage() > math.random(43,87) and RubimRH.InterruptsON() and Target:AffectingCombat() then
	return S.WindShear:Cast()
end
--------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------Cooldowns----------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
if RangeCount(30) >= 1 and Player:HealthPercentage() <= 20 and Player:AffectingCombat() and (IsUsableItem(211880) == true and GetItemCooldown(211880) == 0 and GetItemCount(211880) >= 1 or IsUsableItem(211878) == true and GetItemCooldown(211878) == 0 and GetItemCount(211878) >= 1 or IsUsableItem(211879) == true and GetItemCooldown(211879) == 0 and GetItemCount(211879) >= 1) and (not Player:InArena() and not Player:InBattlegrounds()) then
	return I.HPIcon:Cast()
  end
--------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------Rotation-----------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
if RubimRH.CDsON() and Target:IsInRange(20) and not Target:IsDeadOrGhost() and Player:CanAttack(Target) and Player:AffectingCombat() and (not targetdying or target_is_dummy()) then
    local ShouldReturn = UseItems();
    if ShouldReturn then return ShouldReturn; end
  end

if IsReady("Windfury Weapon") and mhenchantremains < 10 then
	return S.WindfuryWeapon:Cast()
end

if IsReady("Flametongue Weapon") and ohenchantremains < 10 then
	return S.FlametongueWeapon:Cast()
end

-- if S.WindfuryTotem:IsReadyQueue(8) and (Player:MovingFor() <= Player:GCD() or (allMobsinRange(Cache.EnemiesCount[10]) and tarSpeed == 0)) and not Player:BuffUp(S.WindfuryBuff) then
	-- return S.WindfuryTotem:Cast()
-- end

if UnitCanAttack('player','target') and not Target:IsDeadOrGhost() and (Target:AffectingCombat() or C_Spell.IsCurrentSpell(6603)) then
	if not C_Spell.IsCurrentSpell(6603) and Player:CanAttack(Target) and Target:AffectingCombat() and Target:IsInRange(20) then
		return S.autoattack:Cast()
	end	

	if RubimRH.CDsON() then
		if IsReady("Berserking") and TargetinRange(10) and Player:BuffUp(S.Ascendance) then
			return S.Berserking:Cast()
		end
	
		if IsReady("Feral Spirit") then
			return S.FeralSpirit:Cast()
		end

		if IsReady("DoomWinds") and TargetinRange(10) then
			return S.DoomWinds:Cast()
		end
	end

	if RangeCount(15) >= 2 and RubimRH.AoEON() then	
		if AOE() then
			return AOE()
		end
	elseif RangeCount(15) < 2 or not RubimRH.AoEON() then
		if ST() then
			return ST()
		end
	end
end

    return 0, "Interface\\Addons\\Rubim-RH\\Media\\griph.tga"
end




RubimRH.Rotation.SetAPL(263, APL);

local function PASSIVE()
    
end

RubimRH.Rotation.SetPASSIVE(263, PASSIVE);