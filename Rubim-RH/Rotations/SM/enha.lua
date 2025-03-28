--- Localize Vars
-- Addon
local addonName, addonTable = ...;
-- HeroLib
local HL = HeroLib;
local Cache = HeroCache;
local Unit = HL.Unit;
local Player = Unit.Player;
local Target = Unit.Target;
local MultiSpell = HL.MultiSpell

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

	primalstrike = Spell(73899),
	BloodlustPVP = Spell(204361),
	bloodlust = Spell(32182),

	AncestralSpirit = Spell(2008),
	AncestralGuidance = Spell(108281),

	EarthbindTotem = Spell(2484),

	ChainHeal = Spell(1064),

	Thunderstorm = Spell(51490),
	EarthernWeapon = Spell(392375),

	lustAT = Spell(155145),
	lust1 = Spell(57724),
	lust2 = Spell(57723),
	lust3 = Spell(80354),
	lust4 = Spell(95809),
	lust5 = Spell(264689),

	GhostWolf = Spell(2645),
	Purge = Spell(370),
	HealingStreamTotem = Spell(5394),


	TremorTotem = Spell(8143),

	WaterWalking = Spell(546),
	Hex = Spell(51514),

	Stormbringer = Spell(201846),

	CleanseSpirit = Spell(51886),
	CleanseSpiritz = Spell(265221), --fireblood

	ChainLightningBuff = Spell(333964),

	FeralLunge = Spell(196884),

	SpiritWalk = Spell(58875),

	LightningLasso = Spell(305483),

	VesperTotem = Spell(324386),

	DoorofShadows = Spell(300728),
	MaelstromWeapon = Spell(344179),
	StormKeeper = Spell(320137),
	ChainHarvest = Spell(320674),

	StoneBulwarkTotem = Spell(108270),


	EarthenSpike = Spell(188089),

	WinfuryTotemBuff = Spell(327942),

	healthstone = Spell(291944),
	healingpot = Spell(176108),

	Shamanism = Spell(193876),

	WindRushTotem = Spell(192077),

	Skyfury = Spell(462854),
	PoisonCleansingTotem = Spell(383013),

	---
	---



	-- Talents
	AncestralSwiftness  = Spell(443454),
	ElementalReverb     = Spell(443418),
	PrimordialCapacity  = Spell(443448),
	-- Abilities
	TempestAbility      = Spell(452201),
	TempestOverload     = Spell(463351),
	-- Talents
	ArcDischarge        = Spell(455096),
	AwakeningStorms     = Spell(455129),
	RollingThunder      = Spell(454026),
	Supercharge         = Spell(455110),
	Tempest             = Spell(454009),
	-- Buffs
	ArcDischargeBuff    = Spell(470532),
	AwakeningStormsBuff = Spell(462131),
	TempestBuff         = Spell(454015),
	AmplificationCore   = Spell(445029),
	Earthsurge          = Spell(455590),
	LivelyTotems        = Spell(445034),
	SurgingTotem        = MultiSpell(444995, 1221348),
	SurgingTotemz       = Spell(121093), --gift af naru
	TotemicRebound      = Spell(445025),
	TotemicReboundBuff  = Spell(458269),


	-- Racials
	AncestralCall          = Spell(274738),
	BagofTricks            = Spell(312411),
	Berserking             = Spell(26297),
	BloodFury              = Spell(33697),
	Fireblood              = Spell(265221),
	-- Abilities
	Bloodlust              = MultiSpell(2825, 32182), -- Bloodlust/Heroism
	FlameShock             = MultiSpell(188389, 470411),
	FlametongueWeapon      = Spell(318038),
	FrostShock             = Spell(196840),
	HealingSurge           = Spell(8004),
	LightningBolt          = Spell(188196),
	LightningShield        = Spell(192106),
	-- Talents
	AstralShift            = Spell(108271),
	CapacitorTotem         = Spell(192058),
	ChainLightning         = Spell(188443),
	EarthElemental         = Spell(198103),
	EarthShield            = Spell(974),
	EarthShieldFocus       = Spell(20594), --stoneform
	ElementalBlast         = Spell(117014),
	ElementalBlastBuff1    = Spell(173183),
	ElementalBlastBuff2    = Spell(173184),
	ElementalBlastBuff3    = Spell(118522),
	ElementalOrbit         = Spell(383010),
	LavaBurst              = Spell(51505),
	DeeplyRootedElements   = Spell(378270),
	NaturesSwiftness       = Spell(378081),
	PrimordialWave         = Spell(375982),
	PrimordialStorm        = Spell(1218047),
	VoltaicBlazeBuff       = Spell(470058),
	SpiritwalkersGrace     = Spell(79206),
	TotemicRecall          = Spell(108285),
	WindShear              = Spell(57994),
	WindShearz             = Spell(68992), --Darkflight kick@focus
	-- Buffs
	EarthShieldOtherBuff   = Spell(974),
	EarthShieldBuff        = Spell(383648),
	LightningShieldBuff    = Spell(192106),
	PrimordialWaveBuff     = Spell(375986),
	PrimordialStormBuff    = Spell(1218125),
	SpiritwalkersGraceBuff = Spell(79206),
	SplinteredElementsBuff = Spell(382043),
	-- Debuffs
	IceStrikePassive       = Spell(466467),
	FlameShockDebuff       = Spell(188389),
	LightningRodDebuff     = Spell(197209),
	-- Other Class Debuffs
	ChaosBrandDebuff       = Spell(1490),
	HuntersMarkDebuff      = Spell(257284),
	-- Trinket Effects
	SpymastersReportBuff   = Spell(451199), -- Stacking buff from before using Spymaster's Web trinket
	SpymastersWebBuff      = Spell(444959), -- Buff from using Spymaster's Web trinket


	-- Abilities
	VoltaicBlazeAbility       = Spell(470057),
	Windstrike                = Spell(115356),
	-- Talents
	AlphaWolf                 = Spell(198434),
	Ascendance                = Spell(114051),
	AshenCatalyst             = Spell(390370),
	ConvergingStorms          = Spell(384363),
	CrashLightning            = Spell(187874),
	CrashingStorms            = Spell(334308),
	DoomWinds                 = Spell(384352),
	ElementalAssault          = Spell(210853),
	ElementalSpirits          = Spell(262624),
	FeralSpirit               = Spell(51533),
	FireNova                  = Spell(333974),
	FlowingSpirits            = Spell(469314),
	Hailstorm                 = Spell(334195),
	HotHand                   = Spell(201900),
	IceStrike                 = MultiSpell(342240, 470194),
	LashingFlames             = Spell(334046),
	LavaLash                  = Spell(60103),
	LegacyoftheFrostWitch     = Spell(384450),
	MoltenAssault             = Spell(334033),
	OverflowingMaelstrom      = Spell(384149),
	RagingMaelstrom           = Spell(384143),
	StaticAccumulation        = Spell(384411),
	Stormblast                = Spell(319930),
	Stormflurry               = Spell(344357),
	Stormstrike               = Spell(17364),
	Sundering                 = Spell(197214),
	SwirlingMaelstrom         = Spell(384359),
	ThorimsInvocation         = Spell(384444),
	UnrelentingStorms         = Spell(470490),
	UnrulyWinds               = Spell(390288),
	VoltaicBlaze              = Spell(470053),
	WindfuryTotem             = Spell(8512),
	WindfuryWeapon            = Spell(33757),
	WitchDoctorsAncestry      = Spell(384447),
	-- Buffs
	AscendanceBuff            = Spell(114051),
	AshenCatalystBuff         = Spell(390371),
	ConvergingStormsBuff      = Spell(198300),
	CracklingThunderBuff      = Spell(409834),
	CrashLightningBuff        = Spell(187878),
	CLCrashLightningBuff      = Spell(333964),
	DoomWindsBuff             = Spell(466772),
	EarthenWeaponBuff         = Spell(392375),
	FeralSpiritBuff           = Spell(333957),
	GatheringStormsBuff       = Spell(198300),
	HailstormBuff             = Spell(334196),
	HotHandBuff               = Spell(215785),
	IceStrikeBuff             = Spell(384357),
	LegacyoftheFrostWitchBuff = Spell(384451),
	MaelstromWeaponBuff       = Spell(344179),
	StormsurgeBuff            = Spell(201846),
	WindfuryTotemBuff         = Spell(327942),
	WhirlingAirBuff           = Spell(453409),
	WhirlingFireBuff          = Spell(453405),
	StormblastBuff            = Spell(470466),

	-- Debuffs
	LashingFlamesDebuff       = Spell(334168),
	-- Elemental Spirits Buffs
	CracklingSurgeBuff        = Spell(224127),
	IcyEdgeBuff               = Spell(224126),
	MoltenWeaponBuff          = Spell(224125),
	-- Tier 29 Buffs
	MaelstromofElementsBuff   = Spell(394677),
	-- Tier 30 Buffs
	VolcanicStrengthBuff      = Spell(409833),
	ElectrostaticWagerBuff    = Spell(1223410), -- TWW S2 4pc
	ElectrostaticWagerDmg     = Spell(1223332), -- TWW S2 4pc

}

local S = RubimRH.Spell[263]
local G = RubimRH.Spell[1]                        -- General Skills
S.VoltaicBlazeAbility.TextureSpellID = { 255654 } --bullrush
S.FlameShock.TextureSpellID = { 291944 }          --regeneratin
S.PrimordialWave.TextureSpellID = { 375982 }
S.SurgingTotem.TextureSpellID = { 455630 }
-- S.WhirlingAirBuff.TextureSpellID = { 453409}
-- S.Skyfury.TextureSpellID = { 8512 } --windfurry totem

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

LastSKCast = 0
LastSKBuff = 0
LastRollingThunderTick = 0
FeralSpiritCount = 0
CracklingSurgeStacks = 0
IcyEdgeStacks = 0
MoltenWeaponStacks = 0
TempestMaelstrom = 0
--- ============================ CONTENT ============================
HL:RegisterForSelfCombatEvent(
	function(...)
		local SourceGUID, _, _, _, _, _, _, _, SpellID = select(4, ...)
		if SourceGUID == Player:GUID() and SpellID == 191634 then
			LastSKCast = GetTime()
		end
	end
	, "SPELL_CAST_SUCCESS"
)

HL:RegisterForSelfCombatEvent(
	function(...)
		local DestGUID, _, _, _, SpellID = select(8, ...)
		if DestGUID == Player:GUID() and SpellID == 191634 then
			LastSKBuff = GetTime()
			C_Timer.After(0.1, function()
				if LastSKBuff ~= LastSKCast then
					LastRollingThunderTick = LastSKBuff
				end
			end)
		end
	end
	, "SPELL_AURA_APPLIED", "SPELL_AURA_APPLIED_DOSE"
)

--- ===== Wolf and Wolf Buffs Tracker =====
HL:RegisterForSelfCombatEvent(
	function(...)
		local SpellID = select(12, ...)
		if SpellID == 262627 then
			FeralSpiritCount = FeralSpiritCount + 1
			C_Timer.After(15, function()
				FeralSpiritCount = FeralSpiritCount - 1
			end)
		end
	end
	, "SPELL_SUMMON"
)

HL:RegisterForCombatEvent(
	function(...)
		local DestGUID, _, _, _, SpellID = select(8, ...)
		if DestGUID == Player:GUID() then
			if SpellID == 224125 then -- Molten Weapon Buff
				MoltenWeaponStacks = MoltenWeaponStacks + 1
			elseif SpellID == 224126 then -- Icy Edge Buff
				IcyEdgeStacks = IcyEdgeStacks + 1
			elseif SpellID == 224127 then -- Crackling Surge Buff
				CracklingSurgeStacks = CracklingSurgeStacks + 1
			end
		end
	end
	, "SPELL_AURA_APPLIED"
)

HL:RegisterForCombatEvent(
	function(...)
		local DestGUID, _, _, _, SpellID = select(8, ...)
		if DestGUID == Player:GUID() then
			if SpellID == 224125 then -- Molten Weapon Buff
				MoltenWeaponStacks = MoltenWeaponStacks - 1
			elseif SpellID == 224126 then -- Icy Edge Buff
				IcyEdgeStacks = IcyEdgeStacks - 1
			elseif SpellID == 224127 then -- Crackling Surge Buff
				CracklingSurgeStacks = CracklingSurgeStacks - 1
			end
		end
	end
	, "SPELL_AURA_REMOVED"
)

--- ===== Fire Elemental Tracker =====
FireElemental = {
	GreaterActive = false,
	LesserActive = false
}
StormElemental = {
	GreaterActive = false,
	LesserActive = false
}

HL:RegisterForSelfCombatEvent(
	function(...)
		local DestGUID, _, _, _, SpellID = select(8, ...)
		-- Fire Elemental. SpellIDs are without and with Primal Elementalist
		if SpellID == 188592 or SpellID == 118291 then
			FireElemental.GreaterActive = true
			C_Timer.After(30, function()
				FireElemental.GreaterActive = false
			end)
		elseif SpellID == 462992 or SpellID == 462991 then
			FireElemental.LesserActive = true
			C_Timer.After(15, function()
				FireElemental.LesserActive = false
			end)
			-- Storm Elemental. SpellIDs are without and with Primal Elementalist
		elseif SpellID == 157299 or SpellID == 157319 then
			StormElemental.GreaterActive = true
			C_Timer.After(30, function()
				StormElemental.GreaterActive = false
			end)
		elseif SpellID == 462993 or SpellID == 462990 then
			StormElemental.LesserActive = true
			C_Timer.After(15, function()
				StormElemental.LesserActive = false
			end)
		end
	end
	, "SPELL_SUMMON"
)

--- ===== Tempest Maelstrom Counter =====
HL:RegisterForSelfCombatEvent(
	function(...)
		local SpellID = select(12, ...)
		if SpellID == 344179 then
			TempestMaelstrom = TempestMaelstrom + 1
			if TempestMaelstrom >= 40 then
				TempestMaelstrom = TempestMaelstrom - 40
			end
		end
	end
	, "SPELL_AURA_APPLIED", "SPELL_AURA_APPLIED_DOSE"
)
--- ===== Rotation Variables =====
local HasMainHandEnchant, HasOffHandEnchant
local MHEnchantTimeRemains, OHEnchantTimeRemains
local MHEnchantID, OHEnchantID
local MaelstromStacks
local MaxMaelstromStacks = S.RagingMaelstrom:IsAvailable() and 10 or 5
local MaxAshenCatalystStacks = 8
local MaxConvergingStormsStacks = 6
local MaxTempestStacks = 2
local VarMinTalentedCDRemains = 1000
local VarTargetNatureMod, VarExpectedLBFunnel, VarExpectedCLFunnel

local MaxEBCharges = S.LavaBurst:IsAvailable() and 2 or 1
local TIAction = S.LightningBolt


--- ===== Event Registrations =====
HL:RegisterForEvent(function()
	MaxEBCharges = S.LavaBurst:IsAvailable() and 2 or 1
end, "SPELLS_CHANGED", "LEARNED_SPELL_IN_TAB")



HL:RegisterForEvent(function()
	TIAction = S.LightningBolt
end, "PLAYER_REGEN_ENABLED")

--- ===== Helper Functions =====


local function TotemFinder(Totem)
	for i = 1, 6, 1 do
		local _, TotemName = Player:GetTotemInfo(i)
		if Totem:Name() == TotemName then
			return true
		end
	end
end

local function AlphaWolfMinRemains()
	if not S.AlphaWolf:IsAvailable() or Player:BuffDown(S.FeralSpiritBuff) then return 0 end
	local AWStart = math.min(S.CrashLightning:TimeSinceLastCast(), S.ChainLightning:TimeSinceLastCast())
	if AWStart > 8 or AWStart > S.FeralSpirit:TimeSinceLastCast() then return 0 end
	return 8 - AWStart
end

--- ===== Register Damage Formulas =====
S.LightningBolt:RegisterDamageFormula(
	function()
		return
		-- Spell Power
			GetSpellBonusDamage(4) *
			-- 131.1% modifier
			1.311 *
			-- Mastery bonus
			(1 + Player:MasteryPct() / 100) *
			-- 3% bonus from Amplification Core if Surging Totem is active
			((S.AmplificationCore:IsAvailable() and TotemFinder(S.SurgingTotem)) and 1.03 or 1)
	end
)

S.ChainLightning:RegisterDamageFormula(
	function()
		local MaxTargets = S.CrashingStorms:IsAvailable() and 5 or 3
		return
		-- Spell Power
			GetSpellBonusDamage(4) *
			-- 73.025% modifier
			0.73025 *
			-- Mastery bonus
			(1 + Player:MasteryPct() / 100) *
			-- Crashing Storms bonus
			(S.CrashingStorms:IsAvailable() and 1.4 or 1) *
			-- 3% bonus from Amplification Core if Surging Totem is active
			((S.AmplificationCore:IsAvailable() and TotemFinder(S.SurgingTotem)) and 1.03 or 1) *
			-- Targets
			math.min(RangeCount(10), MaxTargets)
	end
)

--- ===== CastTargetIf Filter Functions =====
local function EvaluateTargetIfFilterLightningRodRemains()
	-- target_if=min:debuff.lightning_rod.remains
	return Target:DebuffRemains(S.LightningRodDebuff)
end

local function EvaluateTargetIfFilterPrimordialWave()
	return Target:DebuffRemains(S.FlameShockDebuff)
end

--- ===== CastTargetIf Condition Functions =====
local function EvaluateTargetIfPrimordialWave()
	return Target:BuffDown(S.PrimordialWaveBuff)
end

local function EvaluateTargetIfFilterLavaLash()
	return Target:DebuffRemains(S.LashingFlamesDebuff)
end

--- ===== CastCycle Functions =====
local function EvaluateCycleFlameShock()
	return Target:DebuffRefreshable(S.FlameShockDebuff)
end




--LOS CHECK
if not loscheck then
	loscheck = CreateFrame("Frame")
end

local losCheckTimer = 0

local frame = loscheck
frame:RegisterEvent("UI_ERROR_MESSAGE")
frame:SetScript("OnEvent", function(self, event, errorType, message)
	if message == 'Target not in line of sight' then
		losCheckTimer = GetTime()
	end
end)

--Invalid Target CHECK
if not InvalidTargetcheck then
	InvalidTargetcheck = CreateFrame("Frame")
end

local InvalidTargetCheckTimer = 0

local frame = InvalidTargetcheck
frame:RegisterEvent("UI_ERROR_MESSAGE")
frame:SetScript("OnEvent", function(self, event, errorType, message)
	if message == 'Invalid target' then
		InvalidTargetCheckTimer = GetTime()
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
		if UnitCanAttack("player", unitID) and C_Item.IsItemInRange(33069, unitID) and AuraUtil.FindAuraByName("Flame Shock", unitID, "PLAYER|HARMFUL") then
			FSAoe = FSAoe + 1
		end
	end

	return FSAoe
end

local function UseItems(item)
	local trinket1 = GetInventoryItemID("player", 13)
	local trinket2 = GetInventoryItemID("player", 14)
	local trinket1ready = C_Item.IsUsableItem(trinket1) and C_Item.IsEquippedItem(trinket1) and
		select(2, C_Item.GetItemCooldown(trinket1)) < 1.5
	local trinket2ready = C_Item.IsUsableItem(trinket2) and C_Item.IsEquippedItem(trinket2) and
		select(2, C_Item.GetItemCooldown(trinket2)) < 1.5
	local trinketblacklist = 202612

	if RubimRH.CDsON() and (AuraUtil.FindAuraByName("Doom Winds", "player") or S.DoomWinds:CooldownRemains() < 3) and TargetinRange(5) then
		if trinket1ready and trinket1 ~= trinketblacklist then
			return Item(118330):Cast()
		end

		if trinket2ready and trinket2ready ~= trinketblacklist then
			return Item(114616):Cast()
		end
	end
	return nil
end





local function tremortotem()
	if Player:AffectingCombat() then
		for id = 1, 10 do
			local spell = { "Repulsive Visage", "Horrifying Shrill", "Terrorize", "Terrifying Slam", "Howling Fear",
				"Rasping Scream", "Terrifying Roar",

			}
			local unitID = "nameplate" .. id
			local name, text, texture, startTimeMS, endTimeMS, isTradeSkill, castID, notInterruptible, SpellID =
				UnitCastingInfo(unitID)
			local spellName, _, _, startTimeMS, endTimeMS = UnitChannelInfo(unitID)

			for idx = 1, #spell do
				if UnitCanAttack("player", unitID) and (name == spell[idx] or spellName == spell[idx]) then
					return true
				end
			end
		end
	end
	return false
end





local function defensives()
	if Player:AffectingCombat() then
		for id = 1, 15 do
			local spell = {
				"Call of the Brood", "Massive Slam", "Viscous Darkness", "Dark Pulse", "Dark Floes", "Shadowy Decay",
				"Erosive Spray", "Ground Pound", "Void Outburst", "Earth Shatterer", "Crystalline Eruption",
				"Void Discharge", "Furious Thrashing", "Acid Nova", "Wrath of Zolramus",
				"Dark Shroud", "Shattering Bellow", "Crushing Slam", "Fiery Ricochet", "Umbral Wind", "Commanding Roar",
				"Forge Weapon", "Void Surge", "Vociferous Indoctrination", "Tremor Slam",

			}
			local unitID = "nameplate" .. id
			local name, text, texture, startTimeMS, endTimeMS, isTradeSkill, castID, notInterruptible, spellId =
				UnitCastingInfo(unitID)
			local spellName, _, _, startTimeMS, endTimeMS = UnitChannelInfo(unitID)

			for idx = 1, #spell do
				if UnitCanAttack("player", unitID) and (name == spell[idx] or spellName == spell[idx]) then
					return true
				end
			end
		end
	end
	return false
end


local function SurgingTotemDown()
	local totemName1 = select(2, GetTotemInfo(1))
	local totemName2 = select(2, GetTotemInfo(2))
	local totemName3 = select(2, GetTotemInfo(3))
	local totemName4 = select(2, GetTotemInfo(4))

	if totemName1 == 'Surging Totem' or totemName2 == 'Surging Totem' or totemName3 == 'Surging Totem' or totemName4 == 'Surging Totem' then
		return true
	else
		return false
	end
end














--- ===== Rotation Functions =====
--- ===== Rotation Functions =====
local function Precombat()
	-- flask
	-- food
	-- augmentation
	-- windfury_weapon
	-- flametongue_weapon
	-- lightning_shield
	-- Note: Moved shields and weapon buffs to APL().
	-- windfury_totem
	-- if S.WindfuryTotem:IsReady() and (Player:BuffDown(S.WindfuryTotemBuff, true) or S.WindfuryTotem:TimeSinceLastCast() > 90) then
	-- 	return S.WindfuryTotem:Cast()
	-- end
	-- variable,name=trinket1_is_weird,value=trinket.1.is.algethar_puzzle_box|trinket.1.is.manic_grieftorch|trinket.1.is.elementium_pocket_anvil|trinket.1.is.beacon_to_the_beyond
	-- variable,name=trinket2_is_weird,value=trinket.2.is.algethar_puzzle_box|trinket.2.is.manic_grieftorch|trinket.2.is.elementium_pocket_anvil|trinket.2.is.beacon_to_the_beyond
	-- Note: Handled in trinket definitions.
	-- variable,name=min_talented_cd_remains,value=((cooldown.feral_spirit.remains%(4*talent.witch_doctors_ancestry.enabled))+1000*!talent.feral_spirit.enabled)>?(cooldown.doom_winds.remains+1000*!talent.doom_winds.enabled)>?(cooldown.ascendance.remains+1000*!talent.ascendance.enabled)
	-- variable,name=target_nature_mod,value=(1+debuff.chaos_brand.up*debuff.chaos_brand.value)*(1+(debuff.hunters_mark.up*target.health.pct>=80)*debuff.hunters_mark.value)
	-- variable,name=expected_lb_funnel,value=action.lightning_bolt.damage*(1+debuff.lightning_rod.up*variable.target_nature_mod*(1+buff.primordial_wave.up*active_dot.flame_shock*buff.primordial_wave.value)*debuff.lightning_rod.value)
	-- variable,name=expected_cl_funnel,value=action.chain_lightning.damage*(1+debuff.lightning_rod.up*variable.target_nature_mod*(active_enemies>?(3+2*talent.crashing_storms.enabled))*debuff.lightning_rod.value)
	-- Note: Moved to APL(), as we probably should be checking this during the fight.
	-- snapshot_stats
	-- Manually added openers:
	-- primordial_wave
	if RubimRH.CDsON() and IsReady("Primordial Wave") and TargetinRange(10) then
		return Spell(326059):Cast()
	end
	-- feral_spirit
	if IsReady("Feral Spirit") and TargetinRange(20) and not S.FlowingSpirits:IsAvailable() then
		return S.FeralSpirit:Cast()
	end
	-- flame_shock
	if IsReady("Flame Shock") and TargetinRange(30) then
		return S.FlameShock:Cast()
	end
end


------------------------------------OPENERS---------------------------------------------------------------
-- =====================================================================================================--

local function SingleTotemicOpen()
	-- flame_shock,if=!ticking
	if IsReady("Flame Shock") and TargetinRange(40) and (Target:DebuffDown(S.FlameShockDebuff)) then
		return S.FlameShock:Cast()
	end
	-- lava_lash,if=!pet.surging_totem.active&talent.lashing_flames.enabled&debuff.lashing_flames.down
	if IsReady("Lava Lash") and TargetinRange(5) and ((S.LashingFlames:IsAvailable() and Target:DebuffDown(S.LashingFlamesDebuff)) or Player:BuffUp(S.HotHandBuff)) then
		return S.LavaLash:Cast()
	end
	-- surging_totem
	if IsReady("Surging Totem") and TargetinRange(5) and (numTargetsHit < RangeCount(8) or not SurgingTotemDown()) then
		return S.SurgingTotem:Cast()
	end
	-- primordial_wave
	if IsReady("Primordial Wave") and cancastPS == false and TargetinRange(10) then
		return Spell(326059):Cast()
	end

	if Player:BuffUp(S.LegacyoftheFrostWitchBuff) then
		-- feral_spirit,if=buff.legacy_of_the_frost_witch.up
		if IsReady("Feral Spirit") and TargetinRange(10) then
			return S.FeralSpirit:Cast()
		end
		-- doom_winds,if=buff.legacy_of_the_frost_witch.up
		if IsReady("Doom Winds") and Player:BuffDown(S.DoomWindsBuff) and TargetinRange(5) then
			return S.DoomWinds:Cast()
		end
		-- primordial_storm,if=(buff.maelstrom_weapon.stack>=10)&buff.legacy_of_the_frost_witch.up
		if IsReady("Primordial Storm") and cancastPS == true and C_Spell.GetSpellInfo("Primordial Wave").iconID == 643246
			and TargetinRange(40) and (Player:BuffStack(S.MaelstromWeapon) >= 10) then
			return Spell(326059):Cast()
		end
	end
	-- lava_lash,if=buff.hot_hand.up
	if IsReady("Lava Lash") and TargetinRange(8) and (Player:BuffUp(S.HotHandBuff)) then
		return S.LavaLash:Cast()
	end
	if Player:BuffUp(S.LegacyoftheFrostWitchBuff) then
		-- stormstrike,if=buff.doom_winds.up&buff.legacy_of_the_frost_witch.up
		if IsReady("Stormstrike") and TargetinRange(8) and (Player:BuffUp(S.DoomWindsBuff)) then
			return S.Stormstrike:Cast()
		end
		-- sundering,if=buff.legacy_of_the_frost_witch.up
		if IsReady("Sundering") and TargetinRange(10) then
			return S.Sundering:Cast()
		end
	end
	if (MaelstromStacks >= 10) then
		-- elemental_blast,if=buff.maelstrom_weapon.stack=10
		if IsReady("Elemental Blast") and TargetinRange(30) then
			return S.ElementalBlast:Cast()
		end
		-- lightning_bolt,if=buff.maelstrom_weapon.stack=10
		if IsReady("Lightning Bolt") and TargetinRange(30) then
			return S.LightningBolt:Cast()
		end
	end
	-- stormstrike
	if IsReady("Stormstrike") and TargetinRange(8) then
		return S.Stormstrike:Cast()
	end
	-- lava_lash
	if IsReady("Lava Lash") and TargetinRange(8) then
		return S.LavaLash:Cast()
	end
end
--   local function Single()

--   -- feral_spirit,if=talent.elemental_spirits.enabled
--   if IsReady("Feral Spirit") and TargetinRange(30) and not S.FlowingSpirits:IsAvailable() and (S.ElementalSpirits:IsAvailable()) then
-- 	return S.FeralSpirit:Cast()
-- end
--   -- windstrike,if=talent.thorims_invocation.enabled&buff.maelstrom_weapon.stack>0&ti_lightning_bolt&!talent.elemental_spirits.enabled
--   if IsReady("Windstrike") and TargetinRange(30) and (S.ThorimsInvocation:IsAvailable() and MaelstromStacks > 0 and TIAction == S.LightningBolt and not S.ElementalSpirits:IsAvailable()) and C_Spell.GetSpellInfo("Stormstrike").iconID == 1029585 then
-- 	return S.Windstrike:Cast()
-- end
--   -- primordial_wave,if=!dot.flame_shock.ticking&talent.molten_assault.enabled&(raid_event.adds.in>action.primordial_wave.cooldown|raid_event.adds.in<6)
-- if IsReady("Primordial Wave") and cancastPS==false and TargetinRange(40) and (Target:DebuffDown(S.FlameShockDebuff) and S.MoltenAssault:IsAvailable()) then
-- 	return Spell(326059):Cast()
-- end
--   -- lava_lash,if=talent.lashing_flames.enabled&debuff.lashing_flames.down
--   if IsReady("Lava Lash") and TargetinRange(8) and (S.LashingFlames:IsAvailable() and Target:DebuffDown(S.LashingFlamesDebuff)) then
-- 	return S.LavaLash:Cast()
-- end
--   -- stormstrike,if=buff.maelstrom_weapon.stack<2&cooldown.ascendance.remains=0
--   if IsReady("Stormstrike") and TargetinRange(8) and (MaelstromStacks < 2 and S.Ascendance:CooldownUp()) then
-- 	return S.Stormstrike:Cast()
-- end
--   -- feral_spirit
--   if IsReady("Feral Spirit") and not S.FlowingSpirits:IsAvailable() then
-- 	return S.FeralSpirit:Cast()
-- end
--   -- ascendance,if=dot.flame_shock.ticking&(ti_lightning_bolt&active_enemies=1&raid_event.adds.in>=action.ascendance.cooldown%2)&buff.maelstrom_weapon.stack>=2
--   if RubimRH.CDsON() and IsReady("Ascendance") and TargetinRange(8) and Target:DebuffDown(S.FlameShockDebuff) and (TIAction == S.LightningBolt and RangeCount(10) == 1) and MaelstromStacks >= 2)) then
-- 	return S.Ascendance:Cast()
-- end
--   -- tempest,if=buff.maelstrom_weapon.stack=buff.maelstrom_weapon.max_stack|(buff.tempest.stack=buff.tempest.max_stack&(tempest_mael_count>30|buff.awakening_storms.stack=2)&buff.maelstrom_weapon.stack>=5)
--   if IsReady("Tempest") and TargetinRange(40) and tempest  and (MaelstromStacks == MaxMaelstromStacks or (Player:BuffStack(S.TempestBuff) == MaxTempestStacks and (TempestMaelstrom > 30 or Player:BuffStack(S.AwakeningStormsBuff) == 2) and MaelstromStacks >= 5)) then
-- 	return S.TempestAbility:Cast()
-- end
--   -- elemental_blast,if=buff.maelstrom_weapon.stack=buff.maelstrom_weapon.max_stack&talent.elemental_spirits.enabled&feral_spirit.active>=6&(charges_fractional>=1.8|buff.ascendance.up)
--   if IsReady("Elemental Blast") and TargetinRange(40) and (MaelstromStacks == MaxMaelstromStacks and S.ElementalSpirits:IsAvailable() and FeralSpiritCount >= 6 and (S.ElementalBlast:ChargesFractional() >= 1.8 or Player:BuffUp(S.AscendanceBuff))) then
-- 	return S.ElementalBlast:Cast()
-- end
--   -- windstrike,if=talent.thorims_invocation.enabled&buff.maelstrom_weapon.stack>0&ti_lightning_bolt&charges=max_charges
--   if IsReady("Windstrike") and TargetinRange(30) and (S.ThorimsInvocation:IsAvailable() and MaelstromStacks > 0 and TIAction == S.LightningBolt and S.Windstrike:Charges() == S.Windstrike:MaxCharges()) and C_Spell.GetSpellInfo("Stormstrike").iconID == 1029585 then
-- 	return S.Windstrike:Cast()
-- end
--   -- doom_winds,if=raid_event.adds.in>=action.doom_winds.cooldown&talent.elemental_spirits.enabled&talent.ascendance.enabled&buff.maelstrom_weapon.stack>=2
--   if RubimRH.CDsON() and IsReady("Doom Winds") and TargetinRange(8) and (S.ElementalSpirits:IsAvailable() and S.Ascendance:IsAvailable() and MaelstromStacks >= 2) then
-- 	return S.DoomWinds:Cast()
-- end
--   -- windstrike,if=talent.thorims_invocation.enabled&buff.maelstrom_weapon.stack>0&ti_lightning_bolt
--   if IsReady("Windstrike") and TargetinRange(30) and (S.ThorimsInvocation:IsAvailable() and MaelstromStacks > 0 and TIAction == S.LightningBolt) and C_Spell.GetSpellInfo("Stormstrike").iconID == 1029585 then
-- 	return S.Windstrike:Cast()
-- end
--   -- flame_shock,if=!ticking&talent.ashen_catalyst.enabled
--   if IsReady("Flame Shock")  and TargetinRange(40) and (Target:DebuffDown(S.FlameShockDebuff) and not S.AshenCatalyst:IsAvailable()) then
-- 	return S.FlameShock:Cast()
-- end
--   -- lightning_bolt,if=buff.maelstrom_weapon.stack=buff.maelstrom_weapon.max_stack&buff.primordial_wave.up
--   if IsReady("Lightning Bolt") and TargetinRange(40) and (MaelstromStacks >= MaxMaelstromStacks and Player:BuffUp(S.PrimordialWaveBuff)) then
-- 	return S.LightningBolt:Cast()
-- end
--   -- tempest,if=(!talent.overflowing_maelstrom.enabled&buff.maelstrom_weapon.stack>=5)|(buff.maelstrom_weapon.stack>=10-2*talent.elemental_spirits.enabled)
--   if IsReady("Tempest") and TargetinRange(40) and tempest  and ((not S.OverflowingMaelstrom:IsAvailable() and MaelstromStacks >= 5) or (MaelstromStacks >= 10 - 2 * num(S.ElementalSpirits:IsAvailable()))) then
-- 	return S.TempestAbility:Cast()
-- end
--   -- primordial_wave,if=(raid_event.adds.in>action.primordial_wave.cooldown|raid_event.adds.in<6)&!talent.deeply_rooted_elements.enabled
-- if IsReady("Primordial Wave") and cancastPS==false and TargetinRange(40) and (not S.DeeplyRootedElements:IsAvailable()) then
-- 	return Spell(326059):Cast()
-- end
--   -- elemental_blast,if=buff.maelstrom_weapon.stack>=8&feral_spirit.active>=4&(!buff.ascendance.up|charges_fractional>=1.8)
--   if IsReady("Elemental Blast") and TargetinRange(40) and (MaelstromStacks >= 8 and FeralSpiritCount >= 4 and (Player:BuffUp(S.AscendanceBuff) or S.ElementalBlast:ChargesFractional() >= 1.8)) then
-- 	return S.ElementalBlast:Cast()
-- end
--   -- lightning_bolt,if=buff.maelstrom_weapon.stack>=8+2*talent.legacy_of_the_frost_witch.enabled
--   if IsReady("Lightning Bolt") and TargetinRange(40) and (MaelstromStacks >= 8 + 2 * num(S.LegacyoftheFrostWitch:IsAvailable())) then
-- 	return S.LightningBolt:Cast()
-- end
--   -- lightning_bolt,if=buff.maelstrom_weapon.stack>=5&!talent.legacy_of_the_frost_witch.enabled&(talent.deeply_rooted_elements.enabled|!talent.overflowing_maelstrom.enabled|!talent.witch_doctors_ancestry.enabled)
--   if IsReady("Lightning Bolt") and TargetinRange(40) and (MaelstromStacks >= 5 and not S.LegacyoftheFrostWitch:IsAvailable() and (S.DeeplyRootedElements:IsAvailable() or not S.OverflowingMaelstrom:IsAvailable() or not S.WitchDoctorsAncestry:IsAvailable())) then
-- 	return S.LightningBolt:Cast()
-- end
--   -- voltaic_blaze,if=talent.elemental_spirits.enabled&!talent.witch_doctors_ancestry.enabled
--   if IsReady("Voltaic Blaze") and Player:BuffUp(S.VoltaicBlazeBuff)  and TargetinRange(40) and (S.ElementalSpirits:IsAvailable() and not S.WitchDoctorsAncestry:IsAvailable()) then
-- 	return S.VoltaicBlazeAbility:Cast()
-- end
--   -- lightning_bolt,if=buff.arc_discharge.up&talent.deeply_rooted_elements.enabled
--   if IsReady("Lightning Bolt") and TargetinRange(40) and (Player:BuffUp(S.ArcDischargeBuff) and S.DeeplyRootedElements:IsAvailable()) then
-- 	return S.LightningBolt:Cast()
-- end
--   -- lava_lash,if=buff.hot_hand.up|(buff.ashen_catalyst.stack=buff.ashen_catalyst.max_stack)
--   if IsReady("Lava Lash") and TargetinRange(8) and (Player:BuffUp(S.HotHandBuff) or (Player:BuffStack(S.AshenCatalystBuff) == MaxAshenCatalystStacks)) then
-- 	return S.LavaLash:Cast()
-- end
--   -- stormstrike,if=buff.doom_winds.up|(talent.stormblast.enabled&buff.stormsurge.up&charges=max_charges)
--   if IsReady("Stormstrike") and TargetinRange(8) and (Player:BuffUp(S.DoomWindsBuff) or (S.Stormblast:IsAvailable() and Player:BuffUp(S.StormsurgeBuff) and S.Stormstrike:Charges() == S.Stormstrike:MaxCharges())) then
-- 	return S.Stormstrike:Cast()
-- end
--   -- lava_lash,if=talent.lashing_flames.enabled&!buff.doom_winds.up
--   if IsReady("Lava Lash") and TargetinRange(8) and (S.LashingFlames:IsAvailable() and Player:BuffDown(S.DoomWindsBuff)) then
-- 	return S.LavaLash:Cast()
-- end
--   -- voltaic_blaze,if=talent.elemental_spirits.enabled&!buff.doom_winds.up
--   if IsReady("Voltaic Blaze") and Player:BuffUp(S.VoltaicBlazeBuff) and TargetinRange(40) and (S.ElementalSpirits:IsAvailable() and Player:BuffDown(S.DoomWindsBuff)) then
-- 	return S.VoltaicBlazeAbility:Cast()
-- end
--   -- crash_lightning,if=talent.unrelenting_storms.enabled&talent.elemental_spirits.enabled&!talent.deeply_rooted_elements.enabled
--   if IsReady("Crash Lightning") and TargetinRange(8) and (S.UnrelentingStorms:IsAvailable() and S.ElementalSpirits:IsAvailable() and not S.DeeplyRootedElements:IsAvailable()) then
-- 	return S.CrashLightning:Cast()
-- end
--   -- ice_strike,if=talent.elemental_assault.enabled&talent.swirling_maelstrom.enabled&talent.witch_doctors_ancestry.enabled
--   if IsReady("Ice Strike") and C_Spell.GetSpellInfo("Frost Shock").iconID == 135855 and TargetinRange(40) and (S.ElementalAssault:IsAvailable() and S.SwirlingMaelstrom:IsAvailable() and S.WitchDoctorsAncestry:IsAvailable()) then
-- 	return S.IceStrike:Cast()
-- end
--   -- stormstrike
--   if IsReady("Stormstrike") and TargetinRange(8) then
-- 	return S.Stormstrike:Cast()
-- end
--   -- lightning_bolt,if=buff.maelstrom_weapon.stack>=5&talent.ascendance.enabled&!talent.legacy_of_the_frost_witch.enabled
--   if IsReady("Lightning Bolt") and TargetinRange(40) and (MaelstromStacks >= 5 and S.Ascendance:IsAvailable() and not S.LegacyoftheFrostWitch:IsAvailable()) then
-- 	return S.LightningBolt:Cast()
-- end
--   -- crash_lightning,if=talent.unrelenting_storms.enabled
--   if IsReady("Crash Lightning") and TargetinRange(8) and (S.UnrelentingStorms:IsAvailable()) then
-- 	return S.CrashLightning:Cast()
-- end
--   -- voltaic_blaze
--   if IsReady("Voltaic Blaze") and Player:BuffUp(S.VoltaicBlazeBuff) and TargetinRange(40) then
-- 	return S.VoltaicBlazeAbility:Cast()
-- end
--   -- sundering,if=!talent.elemental_spirits.enabled&raid_event.adds.in>=action.sundering.cooldown
--   if IsReady("Sundering") and TargetinRange(10) and (not S.ElementalSpirits:IsAvailable()) then
-- 	return S.Sundering:Cast()
-- end
--   -- frost_shock,if=buff.hailstorm.up&buff.ice_strike.up&talent.swirling_maelstrom.enabled&talent.ascendance.enabled
--   if IsReady("Frost Shock") and TargetinRange(40) and (Player:BuffUp(S.HailstormBuff) and Player:BuffUp(S.IceStrikeBuff) and S.SwirlingMaelstrom:IsAvailable() and S.Ascendance:IsAvailable()) then
-- 	return S.FrostShock:Cast()
-- end
--   -- elemental_blast,if=buff.maelstrom_weapon.stack>=5&feral_spirit.active>=4&talent.deeply_rooted_elements.enabled&(charges_fractional>=1.8|(buff.molten_weapon.stack+buff.icy_edge.stack>=4))&!talent.flowing_spirits.enabled
--   if IsReady("Elemental Blast") and TargetinRange(40) and (MaelstromStacks >= 5 and FeralSpiritCount >= 4 and S.DeeplyRootedElements:IsAvailable() and (S.ElementalBlast:ChargesFractional() >= 1.8 or (MoltenWeaponStacks + IcyEdgeStacks >= 4)) and not S.FlowingSpirits:IsAvailable()) then
-- 	return S.ElementalBlast:Cast()
-- end
--   -- crash_lightning,if=talent.alpha_wolf.enabled&feral_spirit.active&alpha_wolf_min_remains=0
--   if IsReady("Crash Lightning") and TargetinRange(8) and (S.AlphaWolf:IsAvailable() and Player:BuffUp(S.FeralSpiritBuff) and AlphaWolfMinRemains() == 0) then
-- 	return S.CrashLightning:Cast()
-- end
--   -- flame_shock,if=!ticking&!talent.tempest.enabled
--   if IsReady("Flame Shock")  and TargetinRange(40) and (Target:DebuffDown(S.FlameShockDebuff) and not S.Tempest:IsAvailable()) then
-- 	return S.FlameShock:Cast()
-- end
--   -- doom_winds,if=raid_event.adds.in>=action.doom_winds.cooldown&talent.elemental_spirits.enabled
--   if RubimRH.CDsON() and IsReady("Doom Winds") and TargetinRange(8) and (S.ElementalSpirits:IsAvailable()) then
-- 	return S.DoomWinds:Cast()
-- end
--   -- lava_lash,if=talent.elemental_assault.enabled&talent.tempest.enabled&talent.molten_assault.enabled&talent.deeply_rooted_elements.enabled&dot.flame_shock.ticking
--   if IsReady("Lava Lash") and TargetinRange(8) and (S.ElementalAssault:IsAvailable() and S.Tempest:IsAvailable() and S.MoltenAssault:IsAvailable() and S.DeeplyRootedElements:IsAvailable() and Target:DebuffUp(S.FlameShockDebuff)) then
-- 	return S.LavaLash:Cast()
-- end
--   -- ice_strike,if=talent.elemental_assault.enabled&talent.swirling_maelstrom.enabled
--   if IsReady("Ice Strike") and C_Spell.GetSpellInfo("Frost Shock").iconID == 135855 and TargetinRange(40) and (S.ElementalAssault:IsAvailable() and S.SwirlingMaelstrom:IsAvailable()) then
-- 	return S.IceStrike:Cast()
-- end
--   -- lightning_bolt,if=buff.arc_discharge.up
--   if IsReady("Lightning Bolt") and TargetinRange(40) and (Player:BuffUp(S.ArcDischargeBuff)) then
-- 	return S.LightningBolt:Cast()
-- end
--   -- crash_lightning,if=talent.unrelenting_storms.enabled
--   -- Note: Duplicate line of crash_lightning single 52.
--   -- lava_lash,if=talent.elemental_assault.enabled&talent.tempest.enabled&talent.molten_assault.enabled&dot.flame_shock.ticking
--   if IsReady("Lava Lash") and TargetinRange(8) and (S.ElementalAssault:IsAvailable() and S.Tempest:IsAvailable() and S.MoltenAssault:IsAvailable() and Target:DebuffUp(S.FlameShockDebuff)) then
-- 	return S.LavaLash:Cast()
-- end
--   -- frost_shock,if=buff.hailstorm.up&buff.ice_strike.up&talent.swirling_maelstrom.enabled&talent.tempest.enabled
--   if IsReady("Frost Shock") and TargetinRange(40) and (Player:BuffUp(S.HailstormBuff) and Player:BuffUp(S.IceStrikeBuff) and S.SwirlingMaelstrom:IsAvailable() and S.Tempest:IsAvailable()) then
-- 	return S.FrostShock:Cast()
-- end
--   -- flame_shock,if=!ticking
--   if IsReady("Flame Shock")  and TargetinRange(40) and (Target:DebuffDown(S.FlameShockDebuff)) then
-- 	return S.FlameShock:Cast()
-- end
--   -- lava_lash,if=talent.lashing_flames.enabled
--   if IsReady("Lava Lash") and TargetinRange(8) and (S.LashingFlames:IsAvailable()) then
-- 	return S.LavaLash:Cast()
-- end
--   -- ice_strike,if=!buff.ice_strike.up
--   if IsReady("Ice Strike") and C_Spell.GetSpellInfo("Frost Shock").iconID == 135855 and TargetinRange(40) and (Player:BuffDown(S.IceStrikeBuff)) then
-- 	return S.IceStrike:Cast()
-- end
--   -- frost_shock,if=buff.hailstorm.up
--   if IsReady("Frost Shock") and TargetinRange(40) and (Player:BuffUp(S.HailstormBuff)) then
-- 	return S.FrostShock:Cast()
-- end
--   -- crash_lightning,if=talent.converging_storms.enabled
--   if IsReady("Crash Lightning") and TargetinRange(8) and (S.ConvergingStorms:IsAvailable()) then
-- 	return S.CrashLightning:Cast()
-- end
--   -- lava_lash
--   if IsReady("Lava Lash") and TargetinRange(8) then
-- 	return S.LavaLash:Cast()
-- end
--   -- ice_strike
--   if IsReady("Ice Strike") and C_Spell.GetSpellInfo("Frost Shock").iconID == 135855 and TargetinRange(40) then
-- 	return S.IceStrike:Cast()
-- end
--   -- windstrike
--   if IsReady("Windstrike") and TargetinRange(30) and C_Spell.GetSpellInfo("Stormstrike").iconID == 1029585 then
-- 	return S.Windstrike:Cast()
-- end
--   -- stormstrike
--   if IsReady("Stormstrike") and TargetinRange(8) then
-- 	return S.Stormstrike:Cast()
-- end
--   -- sundering,if=raid_event.adds.in>=action.sundering.cooldown
--   if IsReady("Sundering") and TargetinRange(10) then
-- 	return S.Sundering:Cast()
-- end
--   -- frost_shock
--   if IsReady("Frost Shock") and TargetinRange(40) then
-- 	return S.FrostShock:Cast()
-- end
--   -- crash_lightning
--   if IsReady("Crash Lightning") and TargetinRange(8) then
-- 	return S.CrashLightning:Cast()
-- end
--   -- fire_nova,if=active_dot.flame_shock
--   if IsReady("Fire Nova") and TargetinRange(8) and AuraUtil.FindAuraByName("Flame Shock", "target", "PLAYER|HARMFUL")) then
-- 	return S.FireNova:Cast()
-- end
--   -- earth_elemental
-- --   if IsReady("Earth Elemental") and TargetinRange(10) then
-- -- 	return S.EarthElemental:Cast()
-- -- end
--   -- flame_shock
--   if IsReady("Flame Shock")  and TargetinRange(40) then
-- 	return S.FlameShock:Cast()
-- end



--   end


local function SingleTotemic()
	if HL.CombatTime() < 20 then
		local ShouldReturn = SingleTotemicOpen(); if ShouldReturn then return ShouldReturn; end
	end
	if IsReady("Surging Totem") and TargetinRange(5) and not SurgingTotemDown() or (numTargetsHit < RangeCount(8)) then
		return S.SurgingTotem:Cast()
	end
	-- ascendance,if=ti_lightning_bolt&pet.surging_totem.remains>4&(buff.totemic_rebound.stack>=3|buff.maelstrom_weapon.stack>0)
	if RubimRH.CDsON() and IsReady("Ascendance") and TargetinRange(8) and (TIAction == S.LightningBolt and (Player:BuffStack(S.TotemicReboundBuff) > 3) or MaelstromStacks > 0 or not UnitInRaid("player")) then
		return S.Ascendance:Cast()
	end
	if IsReady("Flame Shock") and TargetinRange(40) and (Target:DebuffDown(S.FlameShockDebuff) and S.AshenCatalyst:IsAvailable()) then
		return S.FlameShock:Cast()
	end
	-- lava_lash,if=buff.hot_hand.up
	if IsReady("Lava Lash") and TargetinRange(8) and Player:BuffUp(S.HotHandBuff) then
		return S.LavaLash:Cast()
	end
	--   feral_spirit
	if IsReady("Feral Spirit") and TargetinRange(10) and ((S.DoomWinds:CooldownRemains() > 30 or S.DoomWinds:CooldownRemains() < 7) and (S.PrimordialWave:CooldownRemains() < 20 or Player:BuffUp(S.PrimordialStormBuff) or not S.PrimordialStorm:IsAvailable())) then
		return S.FeralSpirit:Cast()
	end
	-- primordial_wave,if=!dot.flame_shock.ticking&talent.molten_assault.enabled&(raid_event.adds.in>action.primordial_wave.cooldown|raid_event.adds.in<6)
	if RubimRH.CDsON() and IsReady("Primordial Wave") and cancastPS == false and TargetinRange(40) and not (Target:DebuffDown(S.FlameShockDebuff)) then
		return Spell(326059):Cast()
	end
	-- doom_winds,if=raid_event.adds.in>=action.doom_winds.cooldown&!talent.elemental_spirits.enabled&buff.legacy_of_the_frost_witch.up
	if RubimRH.CDsON() and IsReady("Doom Winds") and TargetinRange(8) and Player:BuffDown(S.DoomWindsBuff) and (Player:BuffUp(S.LegacyoftheFrostWitchBuff)) then
		return S.DoomWinds:Cast()
	end
	-- primordial_storm,if=(buff.maelstrom_weapon.stack>=10)&(buff.legacy_of_the_frost_witch.up|!talent.legacy_of_the_frost_witch.enabled)&(cooldown.doom_winds.remains>=15|buff.doom_winds.up)
	if RubimRH.CDsON() and IsReady("Primordial Wave") and cancastPS == true and C_Spell.GetSpellInfo("Primordial Wave").iconID == 643246
		and TargetinRange(40) and (Player:BuffStack(S.MaelstromWeapon) >= 10) and (Player:BuffUp(S.LegacyoftheFrostWitchBuff)
			or not S.LegacyoftheFrostWitch:IsAvailable()) and (S.DoomWinds:CooldownRemains() >= 15 or Player:BuffUp(S.DoomWindsBuff)) then
		return Spell(326059):Cast()
	end
	-- sundering,if=buff.ascendance.up&pet.surging_totem.active&talent.earthsurge.enabled&buff.legacy_of_the_frost_witch.up&buff.totemic_rebound.stack>=5&buff.earthen_weapon.stack>=2
	if IsReady("Sundering") and TargetinRange(10) and (Player:BuffUp(S.AscendanceBuff) and TotemFinder(S.SurgingTotem) and S.Earthsurge:IsAvailable() and Player:BuffUp(S.LegacyoftheFrostWitchBuff) and Player:BuffStack(S.TotemicReboundBuff) >= 5 and Player:BuffStack(S.EarthenWeaponBuff) >= 2) then
		return S.Sundering:Cast()
	end
	-- windstrike,if=talent.thorims_invocation.enabled&buff.maelstrom_weapon.stack>0&ti_lightning_bolt&!talent.elemental_spirits.enabled
	if IsReady("Windstrike") and TargetinRange(30) and (S.ThorimsInvocation:IsAvailable() and MaelstromStacks > 0 and TIAction == S.LightningBolt and not S.ElementalSpirits:IsAvailable()) and C_Spell.GetSpellInfo("Stormstrike").iconID == 1029585 then
		return S.Windstrike:Cast()
	end
	-- sundering,if=buff.legacy_of_the_frost_witch.up&cooldown.ascendance.remains>=10&pet.surging_totem.active&buff.totemic_rebound.stack>=3&!buff.ascendance.up
	if IsReady("Sundering") and TargetinRange(10) and (Player:BuffUp(S.LegacyoftheFrostWitchBuff) and Player:BuffStack(S.TotemicReboundBuff) >= 3 and Player:BuffDown(S.AscendanceBuff)) then
		return S.Sundering:Cast()
	end
	-- crash_lightning,if=talent.unrelenting_storms.enabled&talent.alpha_wolf.enabled&alpha_wolf_min_remains=0&buff.earthen_weapon.stack>=8
	if IsReady("Crash Lightning") and TargetinRange(8) and (S.UnrelentingStorms:IsAvailable() and S.AlphaWolf:IsAvailable() and AlphaWolfMinRemains() == 0 and Player:BuffStack(S.EarthenWeaponBuff) >= 8) then
		return S.CrashLightning:Cast()
	end
	-- lava_burst,if=!talent.thorims_invocation.enabled&buff.maelstrom_weapon.stack>=10&buff.whirling_air.down
	if IsReady("Lava Burst") and TargetinRange(40) and (not S.ThorimsInvocation:IsAvailable() and MaelstromStacks >= 10 and Player:BuffDown(S.WhirlingAirBuff)) then
		return S.LavaBurst:Cast()
	end
	-- elemental_blast,if=buff.maelstrom_weapon.stack=buff.maelstrom_weapon.max_stack&talent.elemental_spirits.enabled&feral_spirit.active>=6&(charges_fractional>=1.8|buff.ascendance.up)
	if IsReady("Elemental Blast") and TargetinRange(40) and ((MaelstromStacks >= 10) and (Player:BuffDown(S.PrimordialStormBuff) or Player:BuffRemains(S.PrimordialStormBuff) > 4)) then
		return S.ElementalBlast:Cast()
	end
	-- stormstrike,if=buff.doom_winds.up&buff.legacy_of_the_frost_witch.up
	if IsReady("Stormstrike") and TargetinRange(8) and (Player:BuffUp(S.DoomWindsBuff) and Player:BuffUp(S.LegacyoftheFrostWitchBuff)) then
		return S.Stormstrike:Cast()
	end
	-- lightning_bolt,if=(buff.maelstrom_weapon.stack>=10)&(buff.primordial_storm.down|buff.primordial_storm.remains>4)
	if IsReady("Lightning Bolt") and TargetinRange(40) and (MaelstromStacks >= 10) and not (Player:BuffUp(S.PrimordialStormBuff) or Player:BuffUp(S.PrimordialStormBuff)) then
		return S.LightningBolt:Cast()
	end
	-- crash_lightning,if=talent.unrelenting_storms.enabled&talent.alpha_wolf.enabled&alpha_wolf_min_remains=0
	if IsReady("Crash Lightning") and TargetinRange(8) and (Player:BuffStack(S.ElectrostaticWagerBuff) >= 4) then
		return S.CrashLightning:Cast()
	end
	-- stormstrike,if=buff.doom_winds.up&buff.legacy_of_the_frost_witch.up
	if IsReady("Stormstrike") and TargetinRange(8) and (Player:BuffUp(S.DoomWindsBuff) or (Player:BuffStack(S.StormblastBuff) > 1)) then
		return S.Stormstrike:Cast()
	end
	-- lava_lash,if=buff.hot_hand.up
	if IsReady("Lava Lash") and TargetinRange(8) and (Player:BuffUp(S.WhirlingFireBuff) or (Player:BuffStack(S.AshenCatalystBuff) >= 8)) then
		return S.LavaLash:Cast()
	end
	-- stormstrike,if=buff.doom_winds.up&buff.legacy_of_the_frost_witch.up
	if IsReady("Stormstrike") and TargetinRange(8) then
		return S.Stormstrike:Cast()
	end
	-- lava_lash,if=buff.hot_hand.up
	if IsReady("Lava Lash") and TargetinRange(8) and (S.MoltenAssault:IsAvailable()) then
		return S.LavaLash:Cast()
	end
	-- crash_lightning,if=talent.unrelenting_storms.enabled&talent.alpha_wolf.enabled&alpha_wolf_min_remains=0     <-------Make TWWIS2
	if IsReady("Crash Lightning") and TargetinRange(8) and (Player:BuffStack(S.ElectrostaticWagerBuff) > 4) then
		return S.CrashLightning:Cast()
	end
	-- voltaic_blaze,if=buff.whirling_earth.up
	if IsReady("Voltaic Blaze") and Player:BuffUp(S.VoltaicBlazeBuff) and TargetinRange(40) then
		return S.VoltaicBlazeAbility:Cast()
	end
	if IsReady("Crash Lightning") and TargetinRange(8) and (S.UnrelentingStorms:IsAvailable()) then
		return S.CrashLightning:Cast()
	end
	-- ice_strike,if=!buff.ice_strike.up
	if IsReady("Ice Strike") and C_Spell.GetSpellInfo("Frost Shock").iconID == 135855 and TargetinRange(40) and Player:BuffDown(S.IceStrikeBuff) then
		return S.IceStrike:Cast()
	end
	-- crash_lightning,if=talent.unrelenting_storms.enabled&talent.alpha_wolf.enabled&alpha_wolf_min_remains=0
	if IsReady("Crash Lightning") and TargetinRange(8) then
		return S.CrashLightning:Cast()
	end
	-- frost_shock,if=buff.hailstorm.up
	if IsReady("Frost Shock") and TargetinRange(40) then
		return S.FrostShock:Cast()
	end
	-- fire_nova,if=active_dot.flame_shock
	if IsReady("Fire Nova") and TargetinRange(8) and not (Target:DebuffDown(S.FlameShockDebuff)) then
		return S.FireNova:Cast()
	end
	-- flame_shock,if=!ticking&talent.lashing_flames.enabled
	if IsReady("Flame Shock") and TargetinRange(40) then
		return S.FlameShock:Cast()
	end
end

-- local function Aoe()
--   -- feral_spirit,if=talent.elemental_spirits.enabled|talent.alpha_wolf.enabled
--   if IsReady("Feral Spirit") and not S.FlowingSpirits:IsAvailable() and (S.ElementalSpirits:IsAvailable() or S.AlphaWolf:IsAvailable()) then
--     return S.FeralSpirit:Cast()
--   end

-- -- ascendance,if=dot.flame_shock.ticking&ti_chain_lightning
-- if RubimRH.CDsON() and IsReady("Ascendance") and TargetinRange(8) and FSTargets() > 0 and TIAction == S.ChainLightning then
--   return S.Ascendance:Cast()
-- end
-- if S.TempestAbility:IsReady() and (Player:BuffDown(S.ArcDischargeBuff) and ((MaelstromStacks == MaxMaelstromStacks and not S.RagingMaelstrom:IsAvailable()) or (MaelstromStacks >= 8)) or (MaelstromStacks >= 5 and (TempestMaelstrom > 30 or Player:BuffStack(S.AwakeningStormsBuff) == 2))) then
--   return S.TempestAbility:Cast()
-- end
--    -- doom_winds,if=ti_chain_lightning&(buff.legacy_of_the_frost_witch.up|!talent.legacy_of_the_frost_witch.enabled)
-- if RubimRH.CDsON() and IsReady("Doom Winds") and TargetinRange(8) and (TIAction == S.ChainLightning and (Player:BuffUp(S.LegacyoftheFrostWitchBuff) or not S.LegacyoftheFrostWitch:IsAvailable())) then
--   return S.DoomWinds:Cast()
-- end
-- -- windstrike,target_if=min:debuff.lightning_rod.remains,if=talent.thorims_invocation.enabled&buff.maelstrom_weapon.stack>0&ti_chain_lightning
-- if IsReady("Windstrike") and TargetinRange(30) and (S.ThorimsInvocation:IsAvailable() and MaelstromStacks > 0 and TIAction == S.ChainLightning) and C_Spell.GetSpellInfo("Stormstrike").iconID == 1029585 then
--   return S.Windstrike:Cast()
-- end
--   -- crash_lightning,if=talent.crashing_storms.enabled&((talent.unruly_winds.enabled&active_enemies>=10)|active_enemies>=15)
--   if IsReady("Crash Lightning") and TargetinRange(8) and (S.CrashingStorms:IsAvailable() and ((S.UnrulyWinds:IsAvailable() and RangeCount(10) >= 10) or RangeCount(10) >= 15)) then
--     return S.CrashLightning:Cast()
--   end
--   -- lightning_bolt,target_if=min:debuff.lightning_rod.remains,if=(!talent.tempest.enabled|(tempest_mael_count<=10&buff.awakening_storms.stack<=1))&((active_dot.flame_shock=active_enemies|active_dot.flame_shock=6)&buff.primordial_wave.up&buff.maelstrom_weapon.stack=buff.maelstrom_weapon.max_stack&(!buff.splintered_elements.up|fight_remains<=12|raid_event.adds.remains<=gcd))
--   if IsReady("Lightning Bolt") and TargetinRange(40) and ((not S.Tempest:IsAvailable() or (TempestMaelstrom <= 10 and Player:BuffStack(S.AwakeningStormsBuff) <= 1)) and ((FSTargets() == RangeCount(10) or FSTargets() >= 6) and Player:BuffUp(S.PrimordialWaveBuff) and MaelstromStacks == MaxMaelstromStacks and (Player:BuffDown(S.SplinteredElementsBuff)))) then
--     return S.LightningBolt:Cast()
--   end
--   -- voltaic_blaze,if=buff.maelstrom_weapon.stack<=8
--   if IsReady("Voltaic Blaze") and TargetinRange(40) and Player:BuffUp(S.VoltaicBlazeBuff) and (MaelstromStacks <= 8) then
--     return S.VoltaicBlazeAbility:Cast()
--   end
--   -- lava_lash,if=talent.molten_assault.enabled&(talent.primordial_wave.enabled|talent.fire_nova.enabled)&dot.flame_shock.ticking&(active_dot.flame_shock<active_enemies)&active_dot.flame_shock<6
--   if IsReady("Lava Lash") and TargetinRange(8) and (S.MoltenAssault:IsAvailable() and (S.PrimordialWave:IsAvailable() or S.FireNova:IsAvailable()) and Target:DebuffUp(S.FlameShockDebuff) and (FSTargets() < RangeCount(10)) and FSTargets() < 6) then
--     return S.LavaLash:Cast()
--   end
--   -- primordial_wave,target_if=min:dot.flame_shock.remains,if=!buff.primordial_wave.up
-- if IsReady("Primordial Wave") and cancastPS==false and TargetinRange(40) and (Player:BuffDown(S.PrimordialWaveBuff)) then
--     return Spell(326059):Cast()
--   end
--   -- chain_lightning,target_if=min:debuff.lightning_rod.remains,if=buff.arc_discharge.up&buff.maelstrom_weapon.stack>=5
--   if IsReady("Chain Lightning") and TargetinRange(40) and (Player:BuffUp(S.ArcDischargeBuff) and MaelstromStacks >= 5) then
--     return S.ChainLightning:Cast()
--   end
--   -- elemental_blast,target_if=min:debuff.lightning_rod.remains,if=(!talent.elemental_spirits.enabled|(talent.elemental_spirits.enabled&(charges=max_charges|feral_spirit.active>=2)))&buff.maelstrom_weapon.stack=buff.maelstrom_weapon.max_stack&(!talent.crashing_storms.enabled|active_enemies<=3)
--   if IsReady("Elemental Blast") and TargetinRange(40) and ((not S.ElementalSpirits:IsAvailable() or (S.ElementalSpirits:IsAvailable() and (S.ElementalBlast:Charges() == MaxEBCharges or FeralSpiritCount >= 2))) and MaelstromStacks == MaxMaelstromStacks and (not S.CrashingStorms:IsAvailable() or RangeCount(10) <= 3)) then
--     return S.ElementalBlast:Cast()
--   end
--   -- chain_lightning,target_if=min:debuff.lightning_rod.remains,if=(buff.maelstrom_weapon.stack=buff.maelstrom_weapon.max_stack&!talent.raging_maelstrom.enabled)|(buff.maelstrom_weapon.stack>=7)
--   if IsReady("Chain Lightning") and TargetinRange(40) and ((MaelstromStacks == MaxMaelstromStacks and not S.RagingMaelstrom:IsAvailable()) or (MaelstromStacks >= 8)) then
--     return S.ChainLightning:Cast()
--   end
--   -- feral_spirit
--   if IsReady("Feral Spirit") and not S.FlowingSpirits:IsAvailable() then
--     return S.FeralSpirit:Cast()
--   end
--   -- doom_winds,if=ti_chain_lightning&(buff.legacy_of_the_frost_witch.up|!talent.legacy_of_the_frost_witch.enabled)
--   if RubimRH.CDsON() and IsReady("Doom Winds") and TargetinRange(8) and (TIAction == S.ChainLightning and (Player:BuffUp(S.LegacyoftheFrostWitchBuff) or not S.LegacyoftheFrostWitch:IsAvailable())) then
--     return S.DoomWinds:Cast()
--   end
--   -- crash_lightning,if=(buff.doom_winds.up&active_enemies>=4)|!buff.crash_lightning.up|(talent.alpha_wolf.enabled&feral_spirit.active&alpha_wolf_min_remains=0)
--   if IsReady("Crash Lightning") and TargetinRange(8) and ((Player:BuffUp(S.DoomWindsBuff) and RangeCount(10) >= 4) or Player:BuffDown(S.CrashLightningBuff) or (S.AlphaWolf:IsAvailable() and Player:BuffUp(S.FeralSpiritBuff))) then
--     return S.CrashLightning:Cast()
--   end
--   -- sundering,if=buff.doom_winds.up|talent.earthsurge.enabled
--   if IsReady("Sundering") and TargetinRange(10) and (Player:BuffUp(S.DoomWindsBuff) or S.Earthsurge:IsAvailable()) then
--     return S.Sundering:Cast()
--   end
--   -- fire_nova,if=active_dot.flame_shock=6|(active_dot.flame_shock>=4&active_dot.flame_shock=active_enemies)
--   if IsReady("Fire Nova") and TargetinRange(8) and (FSTargets() == 6 or (FSTargets() >= 4 and FSTargets() >= RangeCount(10))) then
--     return S.FireNova:Cast()
--   end
--   -- stormstrike,if=talent.stormblast.enabled&talent.stormflurry.enabled
--   if IsReady("Stormstrike") and TargetinRange(8) and (S.Stormblast:IsAvailable() and S.Stormflurry:IsAvailable()) then
--     return S.Stormstrike:Cast()
--   end
--   -- voltaic_blaze
--   if IsReady("Voltaic Blaze") and TargetinRange(40) and Player:BuffUp(S.VoltaicBlazeBuff) then
--     return S.VoltaicBlazeAbility:Cast()
--   end
--   -- lava_lash,target_if=min:debuff.lashing_flames.remains,if=talent.lashing_flames.enabled
--   if IsReady("Lava Lash") and TargetinRange(8) and (S.LashingFlames:IsAvailable()) then
--     return S.LavaLash:Cast()
--   end
--   -- lava_lash,if=talent.molten_assault.enabled&dot.flame_shock.ticking
--   if IsReady("Lava Lash") and TargetinRange(8) and (S.MoltenAssault:IsAvailable() and Target:DebuffUp(S.FlameShockDebuff)) then
--     return S.LavaLash:Cast()
--   end
--   -- ice_strike,if=talent.hailstorm.enabled&!buff.ice_strike.up
--   if IsReady("Ice Strike") and C_Spell.GetSpellInfo("Frost Shock").iconID == 135855 and TargetinRange(40) and (S.Hailstorm:IsAvailable() and Player:BuffDown(S.IceStrikeBuff)) then
--     return S.IceStrike:Cast()
--   end
--   -- frost_shock,if=talent.hailstorm.enabled&buff.hailstorm.up
--   if IsReady("Frost Shock") and TargetinRange(40) and (S.Hailstorm:IsAvailable() and Player:BuffUp(S.HailstormBuff)) then
--     return S.FrostShock:Cast()
--   end
--   -- sundering
--   if IsReady("Sundering") and TargetinRange(10) then
--     return S.Sundering:Cast()
--   end
--   -- flame_shock,if=talent.molten_assault.enabled&!ticking
--   if IsReady("Flame Shock") and TargetinRange(40) and (S.MoltenAssault:IsAvailable() and Target:DebuffDown(S.FlameShockDebuff)) then
--     return S.FlameShock:Cast()
--   end
--   -- flame_shock,target_if=min:dot.flame_shock.remains,if=(talent.fire_nova.enabled|talent.primordial_wave.enabled)&(active_dot.flame_shock<active_enemies)&active_dot.flame_shock<6
--   if IsReady("Flame Shock") and TargetinRange(40) and ((S.FireNova:IsAvailable() or S.PrimordialWave:IsAvailable()) and (FSTargets() < RangeCount(10)) and FSTargets() < 6) then
--     return S.FlameShock:Cast()
--   end
--   -- fire_nova,if=active_dot.flame_shock>=3
--   if IsReady("Fire Nova") and TargetinRange(8) and (FSTargets() >= 3) then
--     return S.FireNova:Cast()
--   end
--   -- stormstrike,if=buff.crash_lightning.up&(talent.deeply_rooted_elements.enabled|buff.converging_storms.stack=buff.converging_storms.max_stack)
--   if IsReady("Stormstrike") and TargetinRange(8) and (Player:BuffUp(S.CrashLightningBuff) and (S.DeeplyRootedElements:IsAvailable() or Player:BuffStack(S.ConvergingStormsBuff) == MaxConvergingStormsStacks)) then
--     return S.Stormstrike:Cast()
--   end
--   -- crash_lightning,if=talent.crashing_storms.enabled&buff.cl_crash_lightning.up&active_enemies>=4
--   if IsReady("Crash Lightning") and TargetinRange(8) and (S.CrashingStorms:IsAvailable() and Player:BuffUp(S.CLCrashLightningBuff) and RangeCount(10) >= 4) then
--     return S.CrashLightning:Cast()
--   end
--   -- windstrike
--   if IsReady("Windstrike") and TargetinRange(30) and C_Spell.GetSpellInfo("Stormstrike").iconID == 1029585 then
--     return S.Windstrike:Cast()
--   end
--   -- stormstrike
--   if IsReady("Stormstrike") and TargetinRange(8) then
--     return S.Stormstrike:Cast()
--   end
--   -- ice_strike
--   if IsReady("Ice Strike") and C_Spell.GetSpellInfo("Frost Shock").iconID == 135855 and TargetinRange(40) then
--     return S.IceStrike:Cast()
--   end
--   -- lava_lash
--   if IsReady("Lava Lash")  and TargetinRange(8) then
--     return S.LavaLash:Cast()
--   end
--   -- crash_lightning
--   if IsReady("Crash Lightning") and TargetinRange(8) then
--     return S.CrashLightning:Cast()
--   end
--   -- fire_nova,if=active_dot.flame_shock>=2
--   if IsReady("Fire Nova") and TargetinRange(8) and (FSTargets() >= 2) then
--     return S.FireNova:Cast()
--   end
--   -- elemental_blast,target_if=min:debuff.lightning_rod.remains,if=(!talent.elemental_spirits.enabled|(talent.elemental_spirits.enabled&(charges=max_charges|feral_spirit.active>=2)))&buff.maelstrom_weapon.stack>=5&(!talent.crashing_storms.enabled|active_enemies<=3)
--   if IsReady("Elemental Blast") and TargetinRange(40) and ((not S.ElementalSpirits:IsAvailable() or (S.ElementalSpirits:IsAvailable() and (S.ElementalBlast:Charges() == MaxEBCharges or FeralSpiritCount >= 2))) and MaelstromStacks >= 5 and (not S.CrashingStorms:IsAvailable() or RangeCount(10) <= 3)) then
--     return S.ElementalBlast:Cast()
--   end
--   -- chain_lightning,target_if=min:debuff.lightning_rod.remains,if=buff.maelstrom_weapon.stack>=5
--   if IsReady("Chain Lightning") and TargetinRange(40) and (MaelstromStacks >= 5) then
--     return S.ChainLightning:Cast()
--   end
--   -- flame_shock,if=!ticking
--   if IsReady("Flame Shock") and TargetinRange(40) and (Target:DebuffDown(S.FlameShockDebuff)) then
--     return S.FlameShock:Cast()
--   end
--   -- frost_shock,if=!talent.hailstorm.enabled
--   if IsReady("Frost Shock") and TargetinRange(40) and (not S.Hailstorm:IsAvailable()) then
--     return S.FrostShock:Cast()
--   end
-- end
local function AoeTotemicOpen()
	if IsReady("Surging Totem") and TargetinRange(5) and (numTargetsHit < RangeCount(8) or not SurgingTotemDown()) then
		return S.SurgingTotem:Cast()
	end

	
	-- flame_shock,if=!ticking
	if RubimRH.CDsON() and IsReady("Beserking") and TargetinRange(8) and (S.Doomwinds:CooldownRemains() or S.PrimordialWave:CooldownRemains()) then
		return S.Berserking:Cast()
	end

	-- flame_shock,if=!ticking
	if IsReady("Flame Shock") and TargetinRange(40) and (Target:DebuffDown(S.FlameShockDebuff)) then
		return S.FlameShock:Cast()
	end

	-- ((FSTargets() == RangeCount(10) or FSTargets() >= 6))
	if IsReady("Primordial Wave") and cancastPS == false and TargetinRange(10) then
		return Spell(326059):Cast()
	end

	-- feral_spirit,if=buff.legacy_of_the_frost_witch.up
	if IsReady("Feral Spirit") and TargetinRange(10) and (MaelstromStacks >= 8) then
		return S.FeralSpirit:Cast()
	end

	if IsReady("Crash Lightning") and TargetinRange(5) and ((Player:BuffStack(S.ElectrostaticWagerBuff) > 9 and Player:BuffUp(S.DoomWindsBuff)) or Player:BuffDown(S.CrashLightningBuff)) then
		return S.CrashLightning:Cast()
	end
	-- doom_winds,if=buff.legacy_of_the_frost_witch.up
	if IsReady("Doom Winds") and Player:BuffDown(S.DoomWindsBuff) and TargetinRange(5) and (MaelstromStacks >= 8) then
		return S.DoomWinds:Cast()
	end
	-- primordial_storm,if=(buff.maelstrom_weapon.stack>=10)&buff.legacy_of_the_frost_witch.up
	if IsReady("Primordial Storm") and cancastPS == true and C_Spell.GetSpellInfo("Primordial Wave").iconID == 643246
		and TargetinRange(40) and (Player:BuffStack(S.MaelstromWeapon) >= 9) and (Player:BuffUp(S.LegacyoftheFrostWitchBuff) or not S.LegacyoftheFrostWitch:IsAvailable()) then
		return Spell(326059):Cast()
	end
	-- lava_lash
	if IsReady("Lava Lash") and TargetinRange(8) and (Player:BuffUp(S.HotHandBuff) or Player:BuffUp(S.LegacyoftheFrostWitchBuff) and Player:BuffUp(S.WhirlingFireBuff)) then
		return S.LavaLash:Cast()
	end
	-- sundering,if=buff.legacy_of_the_frost_witch.up
	if IsReady("Sundering") and TargetinRange(10) and Player:BuffUp(S.LegacyoftheFrostWitchBuff) then
		return S.Sundering:Cast()
	end
	if MaelstromStacks >= 10 then
		if IsReady("Elemental Blast") and TargetinRange(10) then
			return S.ElementalBlast:Cast()
		end
		-- doom_winds,if=buff.legacy_of_the_frost_witch.up
		if IsReady("Chain Lightning") and TargetinRange(8) then
			return S.ChainLightning:Cast()
		end
	end
	-- primordial_storm,if=(buff.maelstrom_weapon.stack>=10)&buff.legacy_of_the_frost_witch.up
	if IsReady("Primordial Wave") and cancastPS == true and C_Spell.GetSpellInfo("Primordial Wave").iconID == 643246
		and TargetinRange(40) and (Player:BuffStack(S.MaelstromWeapon) >= 9) and (Player:BuffUp(S.LegacyoftheFrostWitchBuff) or not S.LegacyoftheFrostWitch:IsAvailable()) then
		return Spell(326059):Cast()
	end
	if IsReady("Frost Shock") and TargetinRange(8) and S.Hailstorm:IsAvailable() and Player:BuffUp(S.HailstormBuff) then
		return S.FrostShock:Cast()
	end
	-- surging_totem

	if IsReady("Stormstrike") and TargetinRange(8) then
		return S.Stormstrike:Cast()
	end

	if IsReady("Lava Lash") and TargetinRange(8) then
		return S.LavaLash:Cast()
	end
end





local function AoeTotemic()
	-- surging_totem
	if IsReady("Surging Totem") and TargetinRange(5) and (numTargetsHit < RangeCount(8) or not SurgingTotemDown()) then
		return S.SurgingTotem:Cast()
	end
	-- run_action_list,name=aoe_totemic_open,if=(cooldown.doom_winds.remains=0|cooldown.sundering.remains=0|!buff.hot_hand.up)&time<15
	if (S.DoomWinds:CooldownRemains() or S.Sundering:CooldownRemains() or Player:BuffDown(S.HotHandBuff)) and HL.CombatTime() < 15 then
		local ShouldReturn = AoeTotemicOpen(); if ShouldReturn then return ShouldReturn; end
	end
	-- -- ascendance,if=ti_chain_lightning
	-- if RubimRH.CDsON() and IsReady("Ascendance") and TargetinRange(8) and ((TIAction == S.ChainLightning) or not UnitInRaid("player")) then
	-- 	return S.Ascendance:Cast()
	-- end
	-- flame_shock,if=!ticking&talent.lashing_flames.enabled
	if IsReady("Flame Shock") and (Target:DebuffDown(S.FlameShockDebuff) and (S.AshenCatalyst:IsAvailable() or S.PrimordialWave:IsAvailable())) then
		return S.FlameShock:Cast()
	end
	-- crash_lightning,if=talent.crashing_storms.enabled&(active_enemies>=15-5*talent.unruly_winds.enabled)
	if IsReady("Crash Lightning") and TargetinRange(8) and (S.CrashingStorms:IsAvailable() and (RangeCount(10) >= 15 - 5 * num(S.UnrulyWinds:IsAvailable()))) then
		return S.CrashLightning:Cast()
	end
	--   feral_spirit
	if IsReady("Feral Spirit") and TargetinRange(10) and ((S.DoomWinds:CooldownRemains() >= 30 or S.DoomWinds:CooldownRemains() < 7) and
			(S.PrimordialWave:CooldownRemains() < 2) or Player:BuffUp(S.PrimordialStormBuff) or not (S.PrimordialStorm:IsAvailable())) then
		return S.FeralSpirit:Cast()
	end
	-- doom_winds,if=!talent.elemental_spirits.enabled&(buff.legacy_of_the_frost_witch.up|!talent.legacy_of_the_frost_witch.enabled)
	if RubimRH.CDsON() and IsReady("Doom Winds") and TargetinRange(10) and Player:BuffDown(S.DoomWindsBuff) and (not S.ElementalSpirits:IsAvailable()) then
		return S.DoomWinds:Cast()
	end
	if RubimRH.CDsON() and IsReady("Primordial Storm") and cancastPS == true and C_Spell.GetSpellInfo("Primordial Wave").iconID == 643246
		and TargetinRange(40) and ((MaelstromStacks >= 10) and (S.DoomWinds:CooldownRemains() > 3)) then
		return Spell(326059):Cast()
	end

	if RubimRH.CDsON() and IsReady("Primordial Wave") and cancastPS == false and TargetinRange(10) and (FSTargets() == RangeCount(10) or FSTargets() >= 6) then
		return Spell(326059):Cast()
	end

	-- -- windstrike
	-- if IsReady("Windstrike") and TargetinRange(30) and C_Spell.GetSpellInfo("Stormstrike").iconID == 1029585 then
	-- 	return S.Windstrike:Cast()
	-- end

	-- -- elemental_blast,if=(!talent.elemental_spirits.enabled|(talent.elemental_spirits.enabled&(charges=max_charges|feral_spirit.active>=2)))&buff.maelstrom_weapon.stack=buff.maelstrom_weapon.max_stack&(!talent.crashing_storms.enabled|active_enemies<=3)
	-- if IsReady("Elemental Blast") and TargetinRange(40) and ((not S.ElementalSpirits:IsAvailable() or (S.ElementalSpirits:IsAvailable() and
	-- 		(S.ElementalBlast:Charges() == S.ElementalBlast:MaxCharges() or FeralSpiritCount >= 2))) and MaelstromStacks == MaxMaelstromStacks and (not S.CrashingStorms:IsAvailable() or RangeCount(10) <= 3)) then
	-- 	return S.ElementalBlast:Cast()
	-- end

	-- lava_lash,if=talent.molten_assault.enabled&dot.flame_shock.ticking
	if IsReady("Lava Lash") and TargetinRange(8) and Player:BuffUp(S.HotHandBuff) then
		return S.LavaLash:Cast()
	end
	--------------------------------------------------------WWIS2 Tier bonus--------------------------------------------------
	-- chain_lightning,if=buff.maelstrom_weapon.stack>=10
	if IsReady("Crash Lightning") and TargetinRange(10) and (Player:BuffStack(S.ElectrostaticWagerBuff) > 8) then
		return S.CrashLightning:Cast()
	end
	-- sundering,if=buff.ascendance.up&pet.surging_totem.active&talent.earthsurge.enabled&(buff.legacy_of_the_frost_witch.up|!talent.legacy_of_the_frost_witch.enabled)
	if IsReady("Sundering") and TargetinRange(10) and (Player:BuffUp(S.DoomWindsBuff) or S.Earthsurge:IsAvailable() and
			(Player:BuffUp(S.LegacyoftheFrostWitchBuff) or not S.LegacyoftheFrostWitch:IsAvailable())) then
		return S.Sundering:Cast()
	end

	-- feral_spirit
	if IsReady("Crash Lightning") and (MaelstromStacks >= 10 and Player:BuffStack(S.ElectrostaticWagerBuff) > 4 and
			Player:BuffDown(S.CLCrashLightningBuff) and Player:BuffUp(S.DoomWindsBuff)) then
		return S.CrashLightning:Cast()
	end

	if IsReady("Elemental Blast") and TargetinRange(8) and (MaelstromStacks >= 10) then
		return S.ElementalBlast:Cast()
	end


	-- -- chain_lightning,target_if=min:debuff.lightning_rod.remains,if=buff.maelstrom_weapon.stack>=5
	-- if IsReady("Chain Lightning") and (MaelstromStacks >= 10 and Player:BuffDown(S.PrimordialStormBuff)) then
	-- 	return S.ChainLightning:Cast()
	-- end

	-- -- chain_lightning,target_if=min:debuff.lightning_rod.remains,if=buff.maelstrom_weapon.stack>=5
	-- if IsReady("Crash Lightning") and (Player:BuffUp(S.DoomWindsBuff) or Player:BuffDown(S.CrashLightningBuff) or (S.AlphaWolf:IsAvailable() and Player:BuffUp(S.FeralSpiritBuff) and AlphaWolfMinRemains() == 0)) then
	-- 	return S.CrashLightning:Cast()
	-- end

	-- if IsReady("Voltaic Blaze") and Player:BuffUp(S.VoltaicBlazeBuff) and TargetinRange(40) then
	-- 	return S.VoltaicBlazeAbility:Cast()
	-- end
	-- -- -- fire_nova,if=active_dot.flame_shock=6|(active_dot.flame_shock>=4&active_dot.flame_shock=active_enemies)
	-- -- if IsReady("Fire Nova") and TargetinRange(8) and (FSTargets() == 6 or (FSTargets() >= 4 and FSTargets() >= RangeCount(10))) then
	-- -- 	return S.FireNova:Cast()
	-- -- end

	-- lava_lash,target_if=min:debuff.lashing_flames.remains,if=talent.lashing_flames.enabled
	if IsReady("Lava Lash") and TargetinRange(8) and (S.MoltenAssault:IsAvailable() and Target:DebuffUp(S.FlameShockDebuff)) then
		return S.LavaLash:Cast()
	end

	-- frost_shock,if=talent.hailstorm.enabled&buff.hailstorm.up
	if IsReady("Frost Shock") and TargetinRange(40) and (S.Hailstorm:IsAvailable() and Player:BuffUp(S.HailstormBuff)) then
		return S.FrostShock:Cast()
	end
	-- crash_lightning,if=buff.doom_winds.up|!buff.crash_lightning.up|(talent.alpha_wolf.enabled&feral_spirit.active&alpha_wolf_min_remains=0)
	if IsReady("Crash Lightning") and TargetinRange(8) and (S.CrashingStorms:IsAvailable()) then
		return S.CrashLightning:Cast()
	end
	-- -- fire_nova,if=active_dot.flame_shock=6|(active_dot.flame_shock>=4&active_dot.flame_shock=active_enemies)
	-- if IsReady("Fire Nova") and TargetinRange(8) and (FSTargets() == 6 or (FSTargets() >= 4 and FSTargets() >= RangeCount(10))) then
	-- 	return S.FireNova:Cast()
	-- end
	if MaelstromStacks >= 5 and Player:BuffDown(S.PrimordialStormBuff) then
		-- elemental_blast,if=buff.maelstrom_weapon.stack>=5&!buff.primordial_storm.up
		if IsReady("Elemental Blast") then
			return S.ElementalBlast:Cast()
		end
		-- chain_lightning,if=buff.maelstrom_weapon.stack>=5&!buff.primordial_storm.up
		if IsReady("Chain Lightning") then
			return S.ChainLightning:Cast()
		end
	end

	-- -- sundering,if=buff.legacy_of_the_frost_witch.up
	-- if IsReady("Sundering") and TargetinRange(10) then
	-- 	return S.Sundering:Cast()
	-- end

	-- stormstrike
	if IsReady("Stormstrike") and TargetinRange(8) then
		return S.Stormstrike:Cast()
	end
	-- sundering,if=buff.doom_winds.up|talent.earthsurge.enabled&(buff.legacy_of_the_frost_witch.up|!talent.legacy_of_the_frost_witch.enabled)&pet.surging_totem.active
	if IsReady("Sundering") and TargetinRange(10) and (Player:BuffUp(S.DoomWindsBuff) or S.Earthsurge:IsAvailable() and (Player:BuffUp(S.LegacyoftheFrostWitchBuff) or not S.LegacyoftheFrostWitch:IsAvailable()) and TotemFinder(S.SurgingTotem)) then
		return S.Sundering:Cast()
	end

	-- -- fire_nova,if=active_dot.flame_shock>=3
	-- if IsReady("Fire Nova") and TargetinRange(8) and (FSTargets() >= 3) then
	-- 	return S.FireNova:Cast()
	-- end

	-- if IsReady("Voltaic Blaze") and Player:BuffUp(S.VoltaicBlazeBuff) and TargetinRange(40) then
	-- 	return S.VoltaicBlazeAbility:Cast()
	-- end

	-- -- ice_strike,if=talent.hailstorm.enabled&!buff.ice_strike.up
	-- if IsReady("Ice Strike") and C_Spell.GetSpellInfo("Frost Shock").iconID == 135855 and TargetinRange(40) and (S.Hailstorm:IsAvailable() and Player:BuffDown(S.IceStrikeBuff)) then
	-- 	return S.IceStrike:Cast()
	-- end
	-- frost_shock,if=talent.hailstorm.enabled&buff.hailstorm.up
	if IsReady("Frost Shock") and TargetinRange(40) and (S.Hailstorm:IsAvailable() and Player:BuffUp(S.HailstormBuff)) then
		return S.FrostShock:Cast()
	end

	-- sundering,if=(buff.legacy_of_the_frost_witch.up|!talent.legacy_of_the_frost_witch.enabled)&pet.surging_totem.active
	if IsReady("Sundering") and TargetinRange(10) and ((Player:BuffUp(S.LegacyoftheFrostWitchBuff) or not S.LegacyoftheFrostWitch:IsAvailable()) and TotemFinder(S.SurgingTotem)) then
		return S.Sundering:Cast()
	end

	-- flame_shock,if=talent.molten_assault.enabled&!ticking
	if IsReady("Flame Shock") and TargetinRange(40) and (S.MoltenAssault:IsAvailable() and Target:DebuffDown(S.FlameShockDebuff)) then
		return S.FlameShock:Cast()
	end

	-- -- fire_nova,if=active_dot.flame_shock>=2
	-- if IsReady("Fire Nova") and TargetinRange(8) and (FSTargets() >= 2) then
	-- 	return S.FireNova:Cast()
	-- end
	-- lightning_bolt,if=((active_dot.flame_shock=active_enemies|active_dot.flame_shock=6)&buff.primordial_wave.up&buff.maelstrom_weapon.stack=buff.maelstrom_weapon.max_stack&(!buff.splintered_elements.up|fight_remains<=12|raid_event.adds.remains<=gcd))
	if IsReady("Lightning Bolt") and TargetinRange(40) and ((FSTargets() == RangeCount(10) or FSTargets() >= 6) and Player:BuffUp(S.PrimordialWaveBuff) and MaelstromStacks == MaxMaelstromStacks and (Player:BuffDown(S.SplinteredElementsBuff))) then
		return S.LightningBolt:Cast()
	end

	-- lava_lash,if=talent.molten_assault.enabled&(talent.primordial_wave.enabled|talent.fire_nova.enabled)&dot.flame_shock.ticking&(active_dot.flame_shock<active_enemies)&active_dot.flame_shock<6
	if IsReady("Lava Lash") and TargetinRange(8) and (S.MoltenAssault:IsAvailable() and (S.PrimordialWave:IsAvailable() or S.FireNova:IsAvailable()) and Target:DebuffUp(S.FlameShockDebuff) and (FSTargets() < RangeCount(10)) and FSTargets() < 6) then
		return S.LavaLash:Cast()
	end
	-- primordial_wave,target_if=min:dot.flame_shock.remains,if=!buff.primordial_wave.up
	if RubimRH.CDsON() and IsReady("Primordial Wave") and TargetinRange(40) and (Player:BuffDown(S.PrimordialWaveBuff)) then
		return Spell(326059):Cast()
	end


	-- feral_spirit
	if IsReady("Feral Spirit") and TargetinRange(10) and not S.FlowingSpirits:IsAvailable() then
		return S.FeralSpirit:Cast()
	end
	-- -- doom_winds,if=buff.legacy_of_the_frost_witch.up|!talent.legacy_of_the_frost_witch.enabled
	-- if RubimRH.CDsON() and IsReady("Doom Winds") and TargetinRange(8) and (Player:BuffUp(S.LegacyoftheFrostWitchBuff) or not S.LegacyoftheFrostWitch:IsAvailable()) then
	-- 	return S.DoomWinds:Cast()
	-- end
	-- crash_lightning,if=buff.doom_winds.up|!buff.crash_lightning.up|(talent.alpha_wolf.enabled&feral_spirit.active&alpha_wolf_min_remains=0)
	if IsReady("Crash Lightning") and TargetinRange(8) and (Player:BuffUp(S.DoomWindsBuff) or Player:BuffDown(S.CrashLightningBuff) or (S.AlphaWolf:IsAvailable() and Player:BuffUp(S.FeralSpiritBuff) and AlphaWolfMinRemains() == 0)) then
		return S.CrashLightning:Cast()
	end


	-- voltaic_blaze

	-- lava_lash,target_if=min:debuff.lashing_flames.remains,if=talent.lashing_flames.enabled
	-- if IsReady("Lava Lash") and TargetinRange(8) and (S.LashingFlames:IsAvailable()) then
	-- 	return S.LavaLash:Cast()
	-- end
	-- -- lava_lash,if=talent.molten_assault.enabled&dot.flame_shock.ticking
	-- if IsReady("Lava Lash") and TargetinRange(8) and (S.MoltenAssault:IsAvailable() and Target:DebuffUp(S.FlameShockDebuff)) then
	-- 	return S.LavaLash:Cast()
	-- end




	-- flame_shock,target_if=min:dot.flame_shock.remains,if=(talent.fire_nova.enabled|talent.primordial_wave.enabled)&(active_dot.flame_shock<active_enemies)&active_dot.flame_shock<6
	if IsReady("Flame Shock") and TargetinRange(40) and ((S.FireNova:IsAvailable() or S.PrimordialWave:IsAvailable()) and (FSTargets() < RangeCount(10)) and FSTargets() < 6) then
		return S.FlameShock:Cast()
	end

	-- stormstrike,if=buff.crash_lightning.up&(talent.deeply_rooted_elements.enabled|buff.converging_storms.stack=buff.converging_storms.max_stack)
	if IsReady("Stormstrike") and TargetinRange(8) and (Player:BuffUp(S.CrashLightningBuff) and (S.DeeplyRootedElements:IsAvailable() or Player:BuffStack(S.ConvergingStormsBuff) == MaxConvergingStormsStacks)) then
		return S.Stormstrike:Cast()
	end
	-- crash_lightning,if=talent.crashing_storms.enabled&buff.cl_crash_lightning.up&active_enemies>=4
	if IsReady("Crash Lightning") and TargetinRange(8) and (S.CrashingStorms:IsAvailable() and Player:BuffUp(S.CLCrashLightningBuff) and RangeCount(10) >= 4) then
		return S.CrashLightning:Cast()
	end

	-- stormstrike
	if IsReady("Stormstrike") and TargetinRange(8) then
		return S.Stormstrike:Cast()
	end
	-- -- ice_strike
	-- if IsReady("Ice Strike") and C_Spell.GetSpellInfo("Frost Shock").iconID == 135855 and TargetinRange(40) then
	-- 	return S.IceStrike:Cast()
	-- end
	-- lava_lash
	if IsReady("Lava Lash") and TargetinRange(8) then
		return S.LavaLash:Cast()
	end
	-- crash_lightning
	if IsReady("Crash Lightning") and TargetinRange(8) then
		return S.CrashLightning:Cast()
	end

	-- elemental_blast,target_if=min:debuff.lightning_rod.remains,if=(!talent.elemental_spirits.enabled|(talent.elemental_spirits.enabled&(charges=max_charges|feral_spirit.active>=2)))&buff.maelstrom_weapon.stack>=5&(!talent.crashing_storms.enabled|active_enemies<=3)
	if IsReady("Elemental Blast") and TargetinRange(40) and ((not S.ElementalSpirits:IsAvailable() or (S.ElementalSpirits:IsAvailable() and (S.ElementalBlast:Charges() == MaxEBCharges or FeralSpiritCount >= 2))) and MaelstromStacks >= 5 and (not S.CrashingStorms:IsAvailable() or RangeCount(10) <= 3)) then
		return S.ElementalBlast:Cast()
	end
	-- flame_shock,if=!ticking
	if IsReady("Flame Shock") and TargetinRange(40) then
		return S.FlameShock:Cast()
	end
end


--   local function Funnel()
-- 	-- feral_spirit,if=talent.elemental_spirits.enabled
-- 	if IsReady("Feral Spirit") and not S.FlowingSpirits:IsAvailable() and (S.ElementalSpirits:IsAvailable()) and not S.FlowingSpirits:IsAvailable() then
-- 		return S.FeralSpirit:Cast()
-- 	end
-- 	-- surging_totem
-- 	if IsReady("Surging Totem") and TargetinRange(5) and (not SurgingTotemDown() or numTargetsHit < RangeCount(8) ) then
-- 		return S.SurgingTotem:Cast()
-- 	end
-- 	-- ascendance
-- 	if RubimRH.CDsON() and IsReady("Ascendance") and TargetinRange(8) then
-- 		return S.Ascendance:Cast()
-- 	end
-- 	-- windstrike,if=(talent.thorims_invocation.enabled&buff.maelstrom_weapon.stack>0)|buff.converging_storms.stack=buff.converging_storms.max_stack
-- 	if IsReady("Windstrike") and TargetinRange(30) and ((S.ThorimsInvocation:IsAvailable() and MaelstromStacks > 0) or Player:BuffStack(S.ConvergingStormsBuff) == MaxConvergingStormsStacks) and C_Spell.GetSpellInfo("Stormstrike").iconID == 1029585 then
-- 		return S.Windstrike:Cast()
-- 	end
-- 	-- tempest,if=buff.maelstrom_weapon.stack=buff.maelstrom_weapon.max_stack|(buff.maelstrom_weapon.stack>=5&(tempest_mael_count>30|buff.awakening_storms.stack=2))
-- 	if IsReady("Tempest") and TargetinRange(40) and tempest  and (MaelstromStacks == MaxMaelstromStacks or (MaelstromStacks >= 5 and (TempestMaelstrom > 30 or Player:BuffStack(S.AwakeningStormsBuff) == 2))) then
-- 		return S.TempestAbility:Cast()
-- 	end
-- 	-- lightning_bolt,if=(active_dot.flame_shock=active_enemies|active_dot.flame_shock=6)&buff.primordial_wave.up&buff.maelstrom_weapon.stack=buff.maelstrom_weapon.max_stack&(!buff.splintered_elements.up|fight_remains<=12|raid_event.adds.remains<=gcd)
-- 	if IsReady("Lightning Bolt") and TargetinRange(40) and ((FSTargets() >= RangeCount(10) or FSTargets() >= 6) and Player:BuffUp(S.PrimordialWaveBuff) and MaelstromStacks == MaxMaelstromStacks and (Player:BuffDown(S.SplinteredElementsBuff) )) then
-- 		return S.LightningBolt:Cast()
-- 	end
-- 	-- elemental_blast,if=buff.maelstrom_weapon.stack>=5&talent.elemental_spirits.enabled&feral_spirit.active>=4
-- 	if IsReady("Elemental Blast") and TargetinRange(40) and (MaelstromStacks >= 5 and S.ElementalSpirits:IsAvailable() and FeralSpiritCount >= 4) then
-- 		return S.ElementalBlast:Cast()
-- 	end
-- 	-- lightning_bolt,if=talent.supercharge.enabled&buff.maelstrom_weapon.stack=buff.maelstrom_weapon.max_stack&(variable.expected_lb_funnel>variable.expected_cl_funnel)
-- 	if IsReady("Lightning Bolt") and TargetinRange(40) and (S.Supercharge:IsAvailable() and MaelstromStacks == MaxMaelstromStacks and (VarExpectedLBFunnel > VarExpectedCLFunnel)) then
-- 		return S.LightningBolt:Cast()
-- 	end
-- 	-- chain_lightning,if=(talent.supercharge.enabled&buff.maelstrom_weapon.stack=buff.maelstrom_weapon.max_stack)|buff.arc_discharge.up&buff.maelstrom_weapon.stack>=5
-- 	if S.ChainLightning:IsCastable() and ((S.Supercharge:IsAvailable() and MaelstromStacks == MaxMaelstromStacks) or Player:BuffUp(S.ArcDischargeBuff) and MaelstromStacks >= 5) then
-- 		return S.ChainLightning:Cast()
-- 	end
-- 	-- lava_lash,if=(talent.molten_assault.enabled&dot.flame_shock.ticking&(active_dot.flame_shock<active_enemies)&active_dot.flame_shock<6)|(talent.ashen_catalyst.enabled&buff.ashen_catalyst.stack=buff.ashen_catalyst.max_stack)
-- 	if IsReady("Lava Lash") and TargetinRange(8) and ((S.MoltenAssault:IsAvailable() and Target:DebuffUp(S.FlameShockDebuff) and (FSTargets() < RangeCount(10)) and FSTargets() < 6) or (S.AshenCatalyst:IsAvailable() and Player:BuffStack(S.AshenCatalystBuff) == MaxAshenCatalystStacks)) then
-- 		return S.LavaLash:Cast()
-- 	end
-- 	-- primordial_wave,target_if=min:dot.flame_shock.remains,if=!buff.primordial_wave.up
-- 	if IsReady("Primordial Wave") and TargetinRange(40) and (Player:BuffDown(S.PrimordialWaveBuff)) then
-- 		return Spell(326059):Cast()
-- 	end
-- 	-- elemental_blast,if=(!talent.elemental_spirits.enabled|(talent.elemental_spirits.enabled&(charges=max_charges|buff.feral_spirit.up)))&buff.maelstrom_weapon.stack=buff.maelstrom_weapon.max_stack
-- 	if IsReady("Elemental Blast") and TargetinRange(40) and ((not S.ElementalSpirits:IsAvailable() or (S.ElementalSpirits:IsAvailable() and (S.ElementalBlast:Charges() == S.ElementalBlast:MaxCharges() or Player:BuffUp(S.FeralSpiritBuff)))) and MaelstromStacks == MaxMaelstromStacks) then
-- 		return S.ElementalBlast:Cast()
-- 	end
-- 	-- feral_spirit
-- 	if IsReady("Feral Spirit") and not S.FlowingSpirits:IsAvailable() then
-- 		return S.FeralSpirit:Cast()
-- 	end
-- 	-- doom_winds
-- 	if RubimRH.CDsON() and IsReady("Doom Winds") and TargetinRange(8) then
-- 		return S.DoomWinds:Cast()
-- 	end
-- 	-- stormstrike,if=buff.converging_storms.stack=buff.converging_storms.max_stack
-- 	if IsReady("Stormstrike") and TargetinRange(8) and (Player:BuffStack(S.ConvergingStormsBuff) == MaxConvergingStormsStacks) then
-- 		return S.Stormstrike:Cast()
-- 	end
-- 	-- lava_burst,if=(buff.molten_weapon.stack>buff.crackling_surge.stack)&buff.maelstrom_weapon.stack=buff.maelstrom_weapon.max_stack
-- 	if IsReady("Lava Burst") and TargetinRange(40) and ((MoltenWeaponStacks > CracklingSurgeStacks) and MaelstromStacks == MaxMaelstromStacks) then
-- 		return S.LavaBurst:Cast()
-- 	end
-- 	-- lightning_bolt,if=buff.maelstrom_weapon.stack=buff.maelstrom_weapon.max_stack&(variable.expected_lb_funnel>variable.expected_cl_funnel)
-- 	if IsReady("Lightning Bolt") and TargetinRange(40) and (MaelstromStacks == MaxMaelstromStacks and (VarExpectedLBFunnel > VarExpectedCLFunnel)) then
-- 		return S.LightningBolt:Cast()
-- 	end
-- 	-- chain_lightning,if=buff.maelstrom_weapon.stack=buff.maelstrom_weapon.max_stack
-- 	if S.ChainLightning:IsCastable() and (MaelstromStacks == MaxMaelstromStacks) then
-- 		return S.ChainLightning:Cast()
-- 	end
-- 	-- crash_lightning,if=buff.doom_winds.up|!buff.crash_lightning.up|(talent.alpha_wolf.enabled&feral_spirit.active&alpha_wolf_min_remains=0)|(talent.converging_storms.enabled&buff.converging_storms.stack<buff.converging_storms.max_stack)
-- 	if IsReady("Crash Lightning") and TargetinRange(8) and (Player:BuffUp(S.DoomWindsBuff) or Player:BuffDown(S.CrashLightningBuff) or (S.AlphaWolf:IsAvailable() and Player:BuffUp(S.FeralSpiritBuff) and AlphaWolfMinRemains() == 0) or (S.ConvergingStorms:IsAvailable() and Player:BuffStack(S.ConvergingStormsBuff) < MaxConvergingStormsStacks)) then
-- 		return S.CrashLightning:Cast()
-- 	end
-- 	-- sundering,if=buff.doom_winds.up|talent.earthsurge.enabled
-- 	if IsReady("Sundering") and TargetinRange(10) and (Player:BuffUp(S.DoomWindsBuff) or S.Earthsurge:IsAvailable()) then
-- 		return S.Sundering:Cast()
-- 	end
-- 	-- fire_nova,if=active_dot.flame_shock=6|(active_dot.flame_shock>=4&active_dot.flame_shock=active_enemies)
-- 	if IsReady("Fire Nova") and TargetinRange(8) and (FSTargets() >= 6 or (FSTargets() >= 4 and FSTargets() >= RangeCount(10))) then
-- 		return S.FireNova:Cast()
-- 	end
-- 	-- ice_strike,if=talent.hailstorm.enabled&!buff.ice_strike.up
-- 	if IsReady("Ice Strike") and C_Spell.GetSpellInfo("Frost Shock").iconID == 135855 and TargetinRange(40) and (S.Hailstorm:IsAvailable() and Player:BuffDown(S.IceStrikeBuff)) then
-- 		return S.IceStrike:Cast()
-- 	end
-- 	-- frost_shock,if=talent.hailstorm.enabled&buff.hailstorm.up
-- 	if IsReady("Frost Shock") and TargetinRange(40) and (S.Hailstorm:IsAvailable() and Player:BuffUp(S.HailstormBuff)) then
-- 		return S.FrostShock:Cast()
-- 	end
-- 	-- sundering
-- 	if IsReady("Sundering") and  TargetinRange(8) then
-- 		return S.Sundering:Cast()
-- 	end
-- 	-- flame_shock,if=talent.molten_assault.enabled&!ticking
-- 	if IsReady("Flame Shock")  and TargetinRange(40) and (S.MoltenAssault:IsAvailable() and Target:DebuffDown(S.FlameShockDebuff)) then
-- 		return S.FlameShock:Cast()
-- 	end
-- 	-- flame_shock,target_if=min:dot.flame_shock.remains,if=(talent.fire_nova.enabled|talent.primordial_wave.enabled)&(active_dot.flame_shock<active_enemies)&active_dot.flame_shock<6
-- 	if IsReady("Flame Shock")  and TargetinRange(40) and ((S.FireNova:IsAvailable() or S.PrimordialWave:IsAvailable()) and (FSTargets() < RangeCount(10)) and FSTargets() < 6) then
-- 		return S.FlameShock:Cast()
-- 	end
-- 	-- fire_nova,if=active_dot.flame_shock>=3
-- 	if IsReady("Fire Nova") and TargetinRange(8) and (FSTargets() >= 3) then
-- 		return S.FireNova:Cast()
-- 	end
-- 	-- stormstrike,if=buff.crash_lightning.up&talent.deeply_rooted_elements.enabled
-- 	if IsReady("Stormstrike") and TargetinRange(8) and (Player:BuffUp(S.CrashLightningBuff) and S.DeeplyRootedElements:IsAvailable()) then
-- 		return S.Stormstrike:Cast()
-- 	end
-- 	-- crash_lightning,if=talent.crashing_storms.enabled&buff.cl_crash_lightning.up&active_enemies>=4
-- 	if IsReady("Crash Lightning") and TargetinRange(8) and (S.CrashingStorms:IsAvailable() and Player:BuffUp(S.CLCrashLightningBuff) and RangeCount(10) >= 4) then
-- 		return S.CrashLightning:Cast()
-- 	end
-- 	-- windstrike
-- 	if IsReady("Windstrike") and TargetinRange(30) and C_Spell.GetSpellInfo("Stormstrike").iconID == 1029585 then
-- 		return S.Windstrike:Cast()
-- 	end
-- 	-- stormstrike
-- 	if IsReady("Stormstrike") and TargetinRange(8) then
-- 		return S.Stormstrike:Cast()
-- 	end
-- 	-- ice_strike
-- 	if IsReady("Ice Strike") and C_Spell.GetSpellInfo("Frost Shock").iconID == 135855 and TargetinRange(40) then
-- 		return S.IceStrike:Cast()
-- 	end
-- 	-- lava_lash
-- 	if IsReady("Lava Lash") and TargetinRange(8) then
-- 		return S.LavaLash:Cast()
-- 	end
-- 	-- crash_lightning
-- 	if IsReady("Crash Lightning") and TargetinRange(8) then
-- 		return S.CrashLightning:Cast()
-- 	end
-- 	-- fire_nova,if=active_dot.flame_shock>=2
-- 	if IsReady("Fire Nova") and TargetinRange(8) and (FSTargets() >= 2) then
-- 		return S.FireNova:Cast()
-- 	end
-- 	-- elemental_blast,if=(!talent.elemental_spirits.enabled|(talent.elemental_spirits.enabled&(charges=max_charges|buff.feral_spirit.up)))&buff.maelstrom_weapon.stack>=5
-- 	if IsReady("Elemental Blast") and TargetinRange(40) and ((not S.ElementalSpirits:IsAvailable() or (S.ElementalSpirits:IsAvailable() and (S.ElementalBlast:Charges() == S.ElementalBlast:MaxCharges() or Player:BuffUp(S.FeralSpiritBuff)))) and MaelstromStacks >= 5) then
-- 		return S.ElementalBlast:Cast()
-- 	end
-- 	-- lava_burst,if=(buff.molten_weapon.stack>buff.crackling_surge.stack)&buff.maelstrom_weapon.stack>=5
-- 	if IsReady("Lava Burst") and TargetinRange(40) and ((MoltenWeaponStacks > CracklingSurgeStacks) and MaelstromStacks >= 5) then
-- 		return S.LavaBurst:Cast()
-- 	end
-- 	-- lightning_bolt,if=buff.maelstrom_weapon.stack>=5&(variable.expected_lb_funnel>variable.expected_cl_funnel)
-- 	if IsReady("Lightning Bolt") and TargetinRange(40) and (MaelstromStacks >= 5 and (VarExpectedLBFunnel > VarExpectedCLFunnel)) then
-- 		return S.LightningBolt:Cast()
-- 	end
-- 	-- chain_lightning,if=buff.maelstrom_weapon.stack>=5
-- 	if IsReady("Chain Lightning") and TargetinRange(40) and (MaelstromStacks >= 5) then
-- 		return S.ChainLightning:Cast()
-- 	end
-- 	-- flame_shock,if=!ticking
-- 	if IsReady("Flame Shock")  and TargetinRange(40) and (Target:DebuffDown(S.FlameShockDebuff)) then
-- 		return S.FlameShock:Cast()
-- 	end
-- 	-- frost_shock,if=!talent.hailstorm.enabled
-- 	if IsReady("Frost Shock") and TargetinRange(40) and (not S.Hailstorm:IsAvailable()) then
-- 		return S.FrostShock:Cast()
-- 	end
--   end









-- TOTEM AOE TRACKER + SWING DISPLACEMENT
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
local playerGUID = UnitGUID("player")
local lastResetTime = 0

local f = CreateFrame("Frame")
f:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
f:SetScript("OnEvent", function(self, event)
	self:COMBAT_LOG_EVENT_UNFILTERED(CombatLogGetCurrentEventInfo())
end)

function f:COMBAT_LOG_EVENT_UNFILTERED(...)
	local timestamp, subevent, _, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags = ...
	local spellId, spellName, spellSchool
	local amount, overkill, school, resisted, blocked, absorbed, critical, glancing, crushing, isOffHand

	if subevent == "SPELL_DAMAGE" or subevent == "SPELL_MISSED" then
		spellId, spellName, spellSchool, amount, overkill, school, resisted, blocked, absorbed, critical, glancing, crushing, isOffHand =
			select(12, ...)
	end
	--	if subevent == "SPELL_SUMMON" and sourceGUID == playerGUID and (destName == 'Magma Totem VII' or destName == 'Fire Elemental Totem') then	
	if subevent == "SPELL_SUMMON" and sourceGUID == playerGUID and destName == 'Surging Totem' then
		lastResetTime = GetTime()
		numTargetsHit = RangeCount(8)
		-- if destName == 'Magma Totem VII' then
		-- myTotemGUID = destGUID
		-- elseif destName == 'Fire Elemental Totem' then
		-- FEGUID = destGUID:sub(-10)
		-- end
		myTotemGUID = destGUID:sub(-10)
		--print('myTotemGUID: ',myTotemGUID)
	end
	--and ((spellId == 58732 or spellId == 13376) and sourceGUID:sub(-10) == myTotemGUID) then
	if (subevent == "SPELL_DAMAGE" or subevent == "SPELL_MISSED")
		and (spellId == 455622 and sourceGUID:sub(-10) == myTotemGUID) then
		--print('numTargetsHit: ',numTargetsHit,' myTotemGUID: ',myTotemGUID,'sourceGUID: ',sourceGUID:sub(-10))
		if GetTime() - lastResetTime > 1 then
			lastResetTime = GetTime()
			numTargetsHit = 0
		end
		numTargetsHit = numTargetsHit + 1
		lastResetTime = GetTime()
	end
end

--   local function combatmobs40()
-- 	local totalRange40 = 0

-- 	for id = 1, 15 do -- Keep this at 15 to limit the checks
-- 		local unitID = "nameplate" .. id
-- 		if UnitCanAttack("player", unitID)
-- 			and C_Spell.IsSpellInRange("Lightning Bolt", unitID)
-- 			and UnitHealthMax(unitID) > 5
-- 			and (UnitAffectingCombat(unitID) or string.sub(UnitName(unitID), -5) == "Dummy") then
-- 			totalRange40 = totalRange40 + 1
-- 		end
-- 	end

-- 	return totalRange40
--   end

local function FSTargets()
	local FSAoe = 0



	for id = 1, 40 do
		local unitID = "nameplate" .. id
		if UnitCanAttack("player", unitID) and C_Spell.IsSpellInRange("Lightning Bolt", unitID) and AuraUtil.FindAuraByName("Flame Shock", unitID, "PLAYER|HARMFUL") then
			FSAoe = FSAoe + 1
		end
	end

	return FSAoe
end



local function APL()
	SurgingTotemDown()

	local tslt = GetTime() - lastResetTime
	local tickrate = 6 * Player:SpellHaste() +
		0.8 --<----adjustment---- keep as low as possible; if spamming, up this number.


	if (tslt and tslt > tickrate) or (remainingDura1 and remainingDura1 <= Player:GCD()) then
		numTargetsHit = 0
	end



	local iconPW = C_Spell.GetSpellInfo(375982).iconID



	if iconPW == 643246 then
		cancastPS = true
	else
		cancastPS = false
	end


	local haveTotem1, totemName1, startTime1, duration1 = GetTotemInfo(1) --air + poison cleansing totem --SurgingTotem
	local remainingDura1 = (duration1 - (GetTime() - startTime1))
	local haveTotem2, totemName2, startTime2, duration2 = GetTotemInfo(2) --earth
	local remainingDura2 = (duration2 - (GetTime() - startTime2))
	local haveTotem3, totemName3, startTime3, duration3 = GetTotemInfo(3) --fire
	local remainingDura3 = (duration3 - (GetTime() - startTime3))
	local haveTotem4, totemName4, startTime4, duration4 = GetTotemInfo(4) --water
	local remainingDura4 = (duration4 - (GetTime() - startTime4))


	----Print-----
	--   print(Player:BuffDown(S.DoomWindsBuff))
	-- print('totem2',totemName2)

	-- print('totem3',totemName3)

	-- print('totem4',totemName4)





	TrackHealthLossPerSecond()
	HPpercentloss = GetHealthLossPerSecond()
	if UnitExists('focus') and AuraUtil.FindAuraByName('Earth Shield', 'focus') then
		_, _, earthshieldstack = AuraUtil.FindAuraByName('Earth Shield', 'focus')
	else
		earthshieldstack = 0
	end
	if (C_Spell.GetSpellInfo("Lightning Bolt").iconID == 5927673 or C_Spell.GetSpellInfo("Lightning Bolt").iconID == 136048 or C_Spell.GetSpellInfo("Lightning Bolt").iconID == 5927653)
	then
		tempest = true
	else
		tempest = false
	end


	local hasMainHandEnchant, mainHandExpiration, mainHandCharges, mainHandEnchantID, hasOffHandEnchant, offHandExpiration, offHandCharges, offHandEnchantID =
		GetWeaponEnchantInfo()

	local lostimer = GetTime() - losCheckTimer
	local los

	if lostimer < Player:GCD() then
		los = true
	else
		los = false
	end

	local ITimer = GetTime() - InvalidTargetCheckTimer
	local IT

	if ITimer < Player:GCD() then
		IT = true
	else
		IT = false
	end

	-- print(IT)

	local isTanking, status, threatpct, rawthreatpct, threatvalue = UnitDetailedThreatSituation("player", "target")
	local inInstance, instanceType = IsInInstance()

	local level, affixIDs, wasEnergized = C_ChallengeMode.GetActiveKeystoneInfo()
	local highkey = 4

	local castchannelTime = math.random(250, 500) / 1000

	local startTimeMS = select(4, UnitCastingInfo('target')) or 0
	local currentTimeMS = GetTime() * 1000
	local elapsedTimeca = (startTimeMS > 0) and (currentTimeMS - startTimeMS) or 0
	local castTime = elapsedTimeca / 1000
	local startTimeMS = select(4, UnitCastingInfo('target')) or select(4, UnitChannelInfo('target')) or 0
	local currentTimeMS = GetTime() * 1000
	local elapsedTimech = (startTimeMS > 0) and (currentTimeMS - startTimeMS) or 0
	local channelTime = elapsedTimech / 1000

	-- Calculate fight_remains
	-- Calculate fight_remains
	MaelstromStacks = Player:BuffStack(S.MaelstromWeaponBuff)

	-- Variables from Precombat
	-- variable,name=min_talented_cd_remains,value=((cooldown.feral_spirit.remains%(4*talent.witch_doctors_ancestry.enabled))+1000*!talent.feral_spirit.enabled)>?(cooldown.doom_winds.remains+1000*!talent.doom_winds.enabled)>?(cooldown.ascendance.remains+1000*!talent.ascendance.enabled)
	-- variable,name=target_nature_mod,value=(1+debuff.chaos_brand.up*debuff.chaos_brand.value)*(1+(debuff.hunters_mark.up*target.health.pct>=80)*debuff.hunters_mark.value)
	VarTargetNatureMod = (1 + num(Target:DebuffUp(S.ChaosBrandDebuff)) * 0.05) *
		(1 + num(Target:DebuffUp(S.HuntersMarkDebuff) and Target:HealthPercentage() >= 80) * 0.05)
	-- variable,name=expected_lb_funnel,value=action.lightning_bolt.damage*(1+debuff.lightning_rod.up*variable.target_nature_mod*(1+buff.primordial_wave.up*active_dot.flame_shock*buff.primordial_wave.value)*debuff.lightning_rod.value)
	local PWValue = 1.75 * S.LightningBolt:Damage()
	local LRValue = 0.2 * S.LightningBolt:Damage() * (Target:DebuffUp(S.LightningRodDebuff) and 1.75 or 1)
	VarExpectedLBFunnel = S.LightningBolt:Damage() *
		(1 + num(Target:DebuffUp(S.LightningRodDebuff)) * VarTargetNatureMod * (1 + num(Player:BuffUp(S.PrimordialWaveBuff)) * FSTargets() * PWValue) * LRValue)
	-- variable,name=expected_cl_funnel,value=action.chain_lightning.damage*(1+debuff.lightning_rod.up*variable.target_nature_mod*(active_enemies>?(3+2*talent.crashing_storms.enabled))*debuff.lightning_rod.value)
	VarExpectedCLFunnel = S.ChainLightning:Damage() *
		(1 + num(Target:DebuffUp(S.LightningRodDebuff)) * VarTargetNatureMod * math.min(RangeCount(10), 3 + 2 * num(S.CrashingStorms:IsAvailable())) * LRValue)


	if Player:PrevGCD(1, S.ChainLightning) then
		TIAction = S.ChainLightning
	elseif Player:PrevGCD(1, S.LightningBolt) then
		TIAction = S.LightningBolt
	end

	--------------------------------------------------------------------------------------------------------------------------------------------
	-------------------------------------------------------Functions/Top priorities-------------------------------------------------------------
	--------------------------------------------------------------------------------------------------------------------------------------------
	if Player:IsCasting() or Player:IsChanneling() then
		return 0, "Interface\\Addons\\Rubim-RH\\Media\\channel.tga"
	elseif Player:IsDeadOrGhost() or AuraUtil.FindAuraByName("Drink", "player") or AuraUtil.FindAuraByName("Food", "player") or AuraUtil.FindAuraByName("Food & Drink", "player") then
		return 0, "Interface\\Addons\\Rubim-RH\\Media\\griph.tga"
	end

	-- local name, text, texture, startTimeMS, endTimeMS, isTradeSkill, castID, notInterruptible, spellId = UnitCastingInfo("target")
	-- tarSpeed,_,_,_ = GetUnitSpeed('target')

	local hasMainHandEnchant, mainHandExpiration, mainHandCharges, mainHandEnchantID, hasOffHandEnchant, offHandExpiration, offHandCharges, offHandEnchantID =
		GetWeaponEnchantInfo()

	if hasMainHandEnchant ~= true then
		mhenchantremains = 0
	elseif hasMainHandEnchant == true then
		mhenchantremains = mainHandExpiration * 0.001
	end
	if hasOffHandEnchant ~= true then
		ohenchantremains = 0
	elseif hasOffHandEnchant == true then
		ohenchantremains = offHandExpiration * 0.001
	end

	--------------------------------------------------------------------------------------------------------------------------------------------
	-------------------------------------------------------------Spell Queue--------------------------------------------------------------------
	--------------------------------------------------------------------------------------------------------------------------------------------
	---

	if S.lustAT:ID() == RubimRH.queuedSpell[1]:ID() and Player:DebuffDown(S.lust1) and Player:DebuffDown(S.lust2) and Player:DebuffDown(S.lust3) and Player:DebuffDown(S.lust4) and Player:DebuffDown(S.lust5) then
		return S.lustAT:Cast() -- BIND LUST KEYBIND IN BINDPAD TO ARCANE TORRENT
	end

	if S.lustAT:ID() == RubimRH.queuedSpell[1]:ID() and (Player:DebuffUp(S.lust1) or Player:DebuffUp(S.lust2) or Player:DebuffUp(S.lust3) or Player:DebuffUp(S.lust4) or Player:Debuff(S.lust5)) then
		RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
	end
	if S.FeralLunge:ID() == RubimRH.queuedSpell[1]:ID() and (TargetinRange(8) or not TargetinRange(30)) then
		RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
	end

	if (not IsReady(RubimRH.queuedSpell[1]:ID(), nil, nil, 1) or not Player:AffectingCombat() or RangeCount(30) == 0 or S.GhostWolf:ID() == RubimRH.queuedSpell[1]:ID() and AuraUtil.FindAuraByName("Ghost Wolf", "player"))
	then
		RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
	end

	if S.Hex:ID() == RubimRH.queuedSpell[1]:ID() and IT == true then
		RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
	end
	if RubimRH.queuedSpell[1]:ID() ~= nil and IsPlayerSpell(RubimRH.queuedSpell[1]:ID(), true) == false then
		RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
	end

	if IsReady(RubimRH.queuedSpell[1]:ID(), nil, nil, 1) then
		return RubimRH.QueuedSpell():Cast()
	end




	--------------------------------------------------------------------------------------------------------------------------------------------
	-------------------------------------------------------------dispells---------------------------------------------------------------------
	--------------------------------------------------------------------------------------------------------------------------------------------

	if IsReady("Tremor Totem") and tremortotem() and RubimRH.InterruptsON() then
		return S.TremorTotem:Cast()
	end


	if IsReady("Poison Cleansing Totem") and (AuraUtil.FindAuraByName("Void Rift", "player", "HARMFUL") or GetAppropriateCureSpell("player") == 'Poison') and RubimRH.InterruptsON() then
		return S.PoisonCleansingTotem:Cast()
	end
	if IsReady("Cleanse Spirit") and totemName1 ~= "Poison Cleansing Totem"
		and (AuraUtil.FindAuraByName("Void Rift", "player", "HARMFUL") or GetAppropriateCureSpell("player") == 'Curse') and RubimRH.InterruptsON() and S.PoisonCleansingTotem:TimeSinceLastCast() > 7 and S.CleanseSpirit:TimeSinceLastCast() > 7 then
		return S.CleanseSpirit:Cast()
	end
	if IsReady("Cleanse Spirit") and RubimRH.InterruptsON() and S.CleanseSpirit:TimeSinceLastCast() > 7 and not AuraUtil.FindAuraByName("Ascendance", "player") then
		if (AuraUtil.FindAuraByName("Void Rift", "player", "HARMFUL") or AuraUtil.FindAuraByName("Enveloping Shadowflame", "player", "HARMFUL") or GetAppropriateCureSpell("player") == 'Curse') then
			return S.CleanseSpirit:Cast()
		end
	end
	if IsReady("Cleanse Spirit") and RubimRH.InterruptsON() and S.CleanseSpirit:TimeSinceLastCast() > 7 and not AuraUtil.FindAuraByName("Ascendance", "player") then
		if (AuraUtil.FindAuraByName("Void Rift", "focus", "HARMFUL") or AuraUtil.FindAuraByName("Enveloping Shadowflame", "focus", "HARMFUL") or GetAppropriateCureSpell("focus") == 'Curse') then
			return S.CleanseSpiritz:Cast()
		end
	end

	if IsReady("Totemic Recall") and not Player:BuffUp(S.AscendanceBuff) and (S.PoisonCleansingTotem:CooldownRemains() > 3 or S.TremorTotem:CooldownRemains() > 3 or S.CapacitorTotem:CooldownRemains() > 3) then
		return S.TotemicRecall:Cast()
	end
	if IsReady("Healing Surge") and Player:BuffStack(S.MaelstromWeapon) >= 5 and Player:HealthPercentage() < 35 and RangeCount(20) == 0 then
		return S.HealingSurge:Cast()
	end
	--------------------------------------------------------------------------------------------------------------------------------------------
	-------------------------------------------------------------defensives----------------------------------------------------------------------
	--------------------------------------------------------------------------------------------------------------------------------------------
	if RangeCount(30) >= 1 then
		if IsReady("Ancestral Guidance")
			and (Player:HealthPercentage() <= 35
				or HPpercentloss > 9 and Player:HealthPercentage() <= 30
				or defensives() and Player:HealthPercentage() < 20)
			and not AuraUtil.FindAuraByName("Stone Bulwark", "player") then
			return S.AncestralGuidance:Cast()
		end

		if IsReady("Astral Shift") and (Player:HealthPercentage() <= 35 or HPpercentloss > 9 and Player:HealthPercentage() <= 50 or defensives() and Player:HealthPercentage() < 90) and not AuraUtil.FindAuraByName("Stone Bulwark", "player") then
			return S.AstralShift:Cast()
		end
		if IsReady("Stone Bulwark Totem") and (Player:HealthPercentage() <= 35 or HPpercentloss > 9 and Player:HealthPercentage() <= 50 or defensives() and Player:HealthPercentage() < 90) and not AuraUtil.FindAuraByName("Astral Shift", "player") then
			return S.StoneBulwarkTotem:Cast()
		end

		if IsReady("Earth Elemental") and IsTanking and Player:HealthPercentage() <= 35 and RangeCount(30) >= 2 then
			return S.EarthElemental:Cast()
		end



		if IsReady("Healing Surge") and Player:BuffStack(S.MaelstromWeapon) >= 5 and Player:HealthPercentage() < 35 then
			return S.HealingSurge:Cast()
		end

		if IsReady("Healing Stream Totem") and Player:HealthPercentage() < 75 then
			return S.HealingStreamTotem:Cast()
		end

		if Player:HealthPercentage() <= 20 and (IsUsableItem(211880) == true and GetItemCooldown(211880) == 0 and GetItemCount(211880) >= 1 or IsUsableItem(211878) == true and GetItemCooldown(211878) == 0 and GetItemCount(211878) >= 1 or IsUsableItem(211879) == true and GetItemCooldown(211879) == 0 and GetItemCount(211879) >= 1) and (not Player:InArena() and not Player:InBattlegrounds()) then
			return I.HPIcon:Cast()
		end
	end
	--------------------------------------------------------------------------------------------------------------------------------------------
	-------------------------------------------------------------Rotation-----------------------------------------------------------------------
	--------------------------------------------------------------------------------------------------------------------------------------------
	if ((Player:AffectingCombat() or C_Spell.IsCurrentSpell(6603)) and Player:CanAttack(Target) and not Target:IsDeadOrGhost()) and not AuraUtil.FindAuraByName("Ghost Wolf", "player") then
		local ShouldReturn = UseItems();
		if ShouldReturn then return ShouldReturn; end
	end


	if (castTime > 0.75 or channelTime > 1.08) and RubimRH.InterruptsON() then
		-- kick on GCD
		if IsReady("Wind Shear") then
			if TargetinRange(40) and kickprio() and select(8, UnitCastingInfo("target")) == false then
				return S.WindShear:Cast()
			end

			if C_Spell.IsSpellInRange("Wind Shear", "focus") and kickprio(1) and select(8, UnitCastingInfo("focus")) == false then
				return S.WindShearz:Cast()
			end
		end
	end

	if IsReady("Earth Shield") and not AuraUtil.FindAuraByName("Earth Shield", "player") and Player:IsMoving() and Player:HealthPercentage() < 44 then
		return S.EarthShield:Cast()
	end

	--    --- seasonal affix
	--    if TWWS1AffixMobsInRange()>=6 and IsReady("Thunderstorm") and RubimRH.InterruptsON() then
	-- 	return S.Thunderstorm:Cast()
	-- 	end



	if IsReady("Windfury Weapon") and mhenchantremains < 300 then
		return S.WindfuryWeapon:Cast()
	end

	if IsReady("Flametongue Weapon") and ohenchantremains < 300 then
		return S.FlametongueWeapon:Cast()
	end

	-- if S.WindfuryTotem:IsReadyQueue(8) and (Player:MovingFor() <= Player:GCD() or (allMobsinRange(Cache.EnemiesCount[10]) and tarSpeed == 0)) and not Player:BuffUp(S.WindfuryBuff) then
	-- return S.WindfuryTotem:Cast()
	-- end

	if UnitCanAttack('player', 'target') and not Target:IsDeadOrGhost() and (Target:AffectingCombat() or C_Spell.IsCurrentSpell(6603)) then
		if not C_Spell.IsCurrentSpell(6603) and Player:CanAttack(Target) and Target:AffectingCombat() and Target:IsInRange(20) then
			return S.autoattack:Cast()
		end





		-- Weapon Buff Handling
		if Player:CanAttack(Target) or Player:AffectingCombat() or not Player:AffectingCombat() and RangeCount(40) >= 1 then
			-- Check weapon enchants
			HasMainHandEnchant, MHEnchantTimeRemains, _, MHEnchantID, HasOffHandEnchant, OHEnchantTimeRemains, _, OHEnchantID =
				GetWeaponEnchantInfo()
			-- windfury_weapon
			if (not HasMainHandEnchant or MHEnchantTimeRemains < 600000 or MHEnchantID ~= 5401) and IsReady("Windfury Weapon") then
				return S.WindfuryWeapon:Cast()
			end
			-- flametongue_weapon
			if (not HasOffHandEnchant or OHEnchantTimeRemains < 600000 or OHEnchantID ~= 5400) and IsReady("Flametongue Weapon") then
				return S.FlametongueWeapon:Cast()
			end
		end




		--------------------------------------------------------------------------------------------------------------------------------------------
		------------------------------------------------------------Call rotation functions-------------------------------------------------------------------
		--------------------------------------------------------------------------------------------------------------------------------------------
		if not AuraUtil.FindAuraByName("Hex", "target") then
			if UseItems() then
				return UseItems()
			end
			-- if TotemicOpener ~= nil and HL.CombatTime()<10 and (RangeCount(20)<2 ) and TargetinRange(40)   then
			-- 	return TotemicOpener()
			-- end
			-- if not S.SurgingTotem:IsAvailable() and Aoe() ~= nil and RubimRH.AoEON() and (RangeCount(20)>=2 ) and TargetinRange(40) then
			-- 	return Aoe()
			-- end
			if AoeTotemic() ~= nil and RubimRH.AoEON() and (RangeCount(20) >= 2) and TargetinRange(40) then
				return AoeTotemic()
			end

			-- if Funnel() ~= nil and RubimRH.AoEON() and (RangeCount(20)>=2 ) and TargetinRange(40) then
			-- 	return Funnel()
			-- end

			-- if not S.SurgingTotem:IsAvailable() and Single()~= nil and TargetinRange(40) and (RangeCount(20)<2 or not RubimRH.AoEON()) then
			--   return Single()
			-- end
			if SingleTotemic() ~= nil and TargetinRange(40) and (RangeCount(20) < 2 or not RubimRH.AoEON()) then
				return SingleTotemic()
			end
		end
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

		if IsReady("Lightning Shield") and Player:BuffRemains(S.LightningShield) < 300 then
			return S.LightningShield:Cast()
		end

		if IsReady("Skyfury") and Player:BuffRemains(S.Skyfury) < 300 then
			return S.Skyfury:Cast()
		end



		if los == false and UnitExists('focus') and C_Spell.IsSpellInRange("Earth Shield", "focus") and Player:IsMoving() then
			if IsReady("Earth Shield") and earthshieldstack < 7 then
				return S.EarthShieldFocus:Cast()
			end
		end

		if IsReady("Earth Shield")
			and Player:IsMoving()
			and (not Player:BuffUp(S.EarthShieldBuff)
				or Player:BuffUp(S.EarthShieldBuff)
				and Player:BuffStack(S.EarthShieldBuff) < 7) then
			return S.EarthShield:Cast()
		end

		-- print(S.SurgingTotem:IsAvailable())

		-- Precombat
		if not Player:AffectingCombat() and C_Spell.IsCurrentSpell(6603) then
			local ShouldReturn = Precombat(); if ShouldReturn then return ShouldReturn; end
		end
	end

	return 0, "Interface\\Addons\\Rubim-RH\\Media\\griph.tga"
end

RubimRH.Rotation.SetAPL(263, APL);

local function PASSIVE()

end

RubimRH.Rotation.SetPASSIVE(263, PASSIVE);
