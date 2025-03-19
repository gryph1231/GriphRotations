--- Localize Vars
-- Addon
-- local RubimRH = LibStub("AceAddon-3.0"):GetAddon("RubimRH")
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
	autoattack                 = Spell(291944), --Regeneratin"
	lust1                      = Spell(57724),
	lust2                      = Spell(57723),
	lust3                      = Spell(80354),
	lust4                      = Spell(95809),
	lust5                      = Spell(264689),
	lustAT                     = Spell(265221), -- fireblood
	BattleShout                = Spell(6673),
	Charge                     = Spell(100),
	HeroicThrow                = Spell(57755),
	Pummel                     = Spell(6552),
	Slam                       = Spell(1464),
	VictoryRush                = Spell(34428),
	DefensiveStance            = Spell(386208),
	-- Talents
	Avatar                     = Spell(107574),
	BerserkerRage              = Spell(18499),
	BerserkersTorment          = Spell(390123),
	BloodandThunder            = Spell(384277),
	DoubleTime                 = Spell(103827),
	CrushingForce              = Spell(382764),
	FrothingBerserker          = Spell(215571),
	Hurricane                  = Spell(390563),
	ImmovableObject            = Spell(394307),
	IntimidatingShout          = Spell(5246),
	HeroicLeap                 = Spell(6544),
	ImpendingVictory           = Spell(202168),
	OverwhelmingRage           = Spell(382767),
	RallyingCry                = Spell(97462),
	RumblingEarth              = Spell(275339),
	Shockwave                  = Spell(46968),
	SonicBoom                  = Spell(390725),
	ChampionsSpear             = Spell(376079),
	SpellReflection            = Spell(23920),
	StormBolt                  = Spell(107570),
	ThunderClap                = MultiSpell(6343),
	ThunderousRoar             = Spell(384318),
	TitanicThrow               = Spell(384090),
	WreckingThrow              = Spell(384110),
	Demolish                   = Spell(436358),
	BrutalVitality             = Spell(384036),
	ColossalMight              = Spell(429634),
	ColossalMightBuff          = Spell(440989),
	ThunderBlast               = Spell(435607),
	ThunderBlastBuff           = Spell(435615),

	-- Buffs
	AvatarBuff                 = Spell(107574),
	BattleShoutBuff            = Spell(6673),
	ElysianMightBuff           = Spell(386286),
	HurricaneBuff              = Spell(390581),
	WarMachineBuff             = Spell(262232),
	-- Debuffs
	MarkofFyralathDebuff       = Spell(414532),
	ThunderousRoarDebuff       = Spell(397364),
	-- Pool
	Pool                       = Spell(999910),
	-- Abilities
	BattleStance               = Spell(386164),
	Devastate                  = Spell(20243),
	Execute                    = Spell(163201),
	ShieldBlock                = Spell(2565),
	ShieldSlam                 = Spell(23922),
	-- Talents
	BitterImmunity             = Spell(383762),
	Avatar                     = Spell(107574),
	BarbaricTraining           = Spell(390675),
	Bolster                    = Spell(280001),
	BoomingVoice               = Spell(202743),
	ChampionsBulwark           = Spell(386328),
	DemoralzingShout          = Spell(1160),
	EnduringDefenses           = Spell(386027),
	HeavyRepercussions         = Spell(203177),
	IgnorePain                 = Spell(190456),
	SpellBlock                 = Spell(392966),
	Taunt                      = Spell(355),
	Intervene                  = Spell(3411),
	ImpenetrableWall           = Spell(384072),
	Juggernaut                 = Spell(393967),
	LastStand                  = Spell(12975),
	Massacre                   = Spell(281001),
	Ravager                    = Spell(228920),
	Rend                       = Spell(394062),
	Revenge                    = Spell(6572),
	SeismicReverberation       = Spell(382956),
	ShieldCharge               = Spell(385952),
	ShieldWall                 = Spell(871),
	SuddenDeath                = Spell(29725),
	UnnervingFocus             = Spell(384042),
	UnstoppableForce           = Spell(275336),
	DisruptingShout            = Spell(386071),
	ChallengingShout           = Spell(1161),
	CrashingThunder            = Spell(436707),
	-- Buffs
	-- AvatarBuff                 = Spell(401150),
	EarthenTenacityBuff        = Spell(410218), -- T30 4P
	FervidBuff                 = Spell(425517), -- T31 2P
	LastStandBuff              = Spell(12975),
	RallyingCryBuff            = Spell(97463),
	RevengeBuff                = Spell(5302),
	SeeingRedBuff              = Spell(386486),
	ShieldBlockBuff            = Spell(132404),
	ShieldWallBuff             = Spell(871),
	SuddenDeathBuff            = Spell(52437),
	ViolentOutburstBuff        = Spell(386478),
	VanguardsDeterminationBuff = Spell(394056), -- T29 2P
	-- Debuffs
	RendDebuff                 = Spell(388539),
	Potion                     = Spell(176108),
	

}

local S = RubimRH.Spell[73]

-- Items
if not Item.Warrior then Item.Warrior = {} end
Item.Warrior.Protection = {
	drums = Item(193470),
	HPIcon = Item(169451),
	tx1 = Item(118330),
	tx2 = Item(114616),
};

local I = Item.Warrior.Protection;

S.ThunderClap.TextureSpellID = { 136105 }

local function num(val)
	if val then return 1 else return 0 end
end

local function bool(val)
	return val ~= 0
end

local function GetCastPercentage(unit)
	local castingInfo = select(4, UnitCastingInfo(unit))
	local channelingInfo = select(4, UnitChannelInfo(unit))

	if castingInfo then
		local startTime, endTime = castingInfo, select(5, UnitCastingInfo(unit))
		local currentTime = GetTime() * 1000
		return math.min(100, math.max(0, (currentTime - startTime) / (endTime - startTime) * 100))
	elseif channelingInfo then
		local startTime, endTime = channelingInfo, select(5, UnitChannelInfo(unit))
		local currentTime = GetTime() * 1000
		return math.min(100, math.max(0, (endTime - currentTime) / (endTime - startTime) * 100))
	end

	return 0
end

local function SpellReflect()
	-- Check for casts targeting the player
	for i = 1, 40 do
		local unitID = "nameplate" .. i
		local unitIDtarget = unitID .. "target"
		if UnitIsUnit("player", unitIDtarget) and GetCastPercentage(unitID) > 90 then
			local spellName = select(1, UnitCastingInfo(unitID))
			local dangerousCasts = {
				"Terrifying Slam", "Water Bolt", "Cursed Slash", "Brackish Bolt",
				"Shadow Bolt", "Poison Bolt", "Void Bolt", "Acid Bolt", "Web Bolt",
				"Umbral Weave", "Grimweave Blast", "Shadows of Doubt", "Shadowflame Bolt",
				"Lava Fist", "Shadowflame Slash", "Corrupt", "Spirit Bolt",
				"Acid Expulsion", "Decomposing Acid", "Soul Split", "Anima Slash",
				"Anima Injection", "Volatile Acid", "Overgrowth", "Night Bolt",
				"Frostbolt Volley", "Frozen Binds", "Frostbolt", "Necrotic Bolt",
				"Spew Disease", "Molten Metal", "Stone Bolt", "Arcing Void",
				"Alloy Bolt", "Censoring Gear", "Shadow Claw", "Seismic Smash", "Charged Shield", "Iced Spritzer",
				"Rock Lance", "Mudslide", "Backwash", "Blood Blast", "Trickshot ", "Flamethrowe", "Lightning Bolt",
				"Surveying Beam",
				"Cinderblast", "Necrotic Bolt", "Withering Discharge", "Decaying Strike", "Flame Bolt",
				"Wicklighter Bolt", "Candleflame Bolt",
				"Scrap Rockets", "Electric Blast",
			}
			for _, dangerousCast in ipairs(dangerousCasts) do
				if spellName == dangerousCast then
					return true
				end
			end
		end
	end

	-- Check for dangerous debuffs on the player
	local dangerousDebuffs = {
		"Stalking Shadows", "Splice", "Void Rush", "Twilight Flames",
		"Debilitating Poison", "Putrid Waters", "Stygian Seed",
		"Abyssal Blast", "Noxious Fog", "Disease Cloud",
		"Clinging Darkness", "Shadow Well", "Sticky Sludge", "Alpha Cannon", "Echo Blade", "Well of Darkness",
		"Festering Void", "Crude weapons", "Wicklighter Barrage", "Creeping Shadow",
	}
	for _, debuff in ipairs(dangerousDebuffs) do
		if AuraUtil.FindAuraByName(debuff, "player", "HARMFUL") then
			return true
		end
	end
end

local function IgnorePainValue()
	if Player:BuffUp(S.IgnorePain) then
		local IPBuffInfo = Player:BuffInfo(S.IgnorePain, nil, true)
		return IPBuffInfo.points[1]
	else
		return 0
	end
end

local function IgnorePainWNCap()
	local IPCAP = UnitHealthMax('Player') * .3
	local IPVALUE = IgnorePainValue()

	if IPVALUE + 0.9 <= IPCAP then
		return true
	else
		return false
	end
end

local function Rotation()
	if IsReady("Avatar") and RubimRH.CDsON() and TargetinRange(8) then
		return S.Avatar:Cast()
	end

	if IsReady("Shield Block") and Player:Rage() >= 30 and RangeCount(15) >= 1 and (( not Player:BuffUp(S.ShieldBlockBuff) and Player:BuffRemains(S.ShieldBlockBuff) > Player:GCD()) or Player:BuffDown(S.ShieldBlockBuff)) then
		return S.ShieldBlock:Cast()
	end

	if IsReady("Demoralizing Shout") and TargetinRange(5) and S.BoomingVoice:IsAvailable() then
		return S.DemoralzingShout:Cast()
	end

	if IsReady("Ravager") and RubimRH.CDsON() and TargetinRange(5) and RangeCount(8) >= 1 then
		return S.Ravager:Cast()
	end
	
	if IsReady("Thunderous Roar") and RubimRH.CDsON() and TargetinRange(5) and RangeCount(8) >= 1 then
		return S.ThunderousRoar:Cast()
	end
	
	if IsReady("Demolish")  and RubimRH.CDsON() and TargetinRange(10) then
		return S.Demolish:Cast()
	end
	-- or ((Player:BuffUp(S.IgnorePain) and Player:BuffRemains(S.IgnorePain) < Player:GCD()) or Player:BuffDown(S.IgnorePain)))
	if IsReady("Ignore Pain") and IgnorePainWNCap() and TargetinRange(10) and (Player:Rage() > 80)  then
		return S.IgnorePain:Cast()
	end

	if IsReady(376079) and RubimRH.CDsON() and S.ChampionsSpear:IsAvailable() and TargetinRange(5) then
		return S.ChampionsSpear:Cast()
	end

    if IsReady("Impending Victory") and TargetinRange(5) then
		return S.ImpendingVictory:Cast()
	end

	if IsReady("Thunder Clap") and RangeCount(10) >= 2 and C_Spell.GetSpellInfo("Thunder Clap").iconID == 460957 then
		return Spell(115942):Cast()
	end

	if Player:BuffUp(S.ViolentOutburstBuff) then
		if IsReady("Shield Slam") and RangeCount(8) >= 2 and RangeCount(8) < 4 then
			return S.ShieldSlam:Cast()
		end

		if IsReady("Thunder Clap") and RangeCount(10) >= 4 then
			return Spell(115942):Cast()
		end
	end

	if IsReady("Shield Slam") and TargetinRange(5) then
		return S.ShieldSlam:Cast()
	end
	if IsReady("Revenge") and TargetinRange(5) and S.Demolish:IsAvailable() then
		return S.Revenge:Cast()
	end
	if IsReady("Revenge") and TargetinRange(5) and not S.Demolish:IsAvailable() and (Player:Rage()>=50 or Player:BuffUp(S.RevengeBuff)) and (Player:BuffUp(S.ShieldBlockBuff) and Player:BuffUp(S.IgnorePain) and Player:BuffRemains(S.IgnorePain) > Player:GCD()) then
		return S.Revenge:Cast()
	end

	if IsReady("Thunder Clap") and RangeCount(8) >= 1 then
		return Spell(115942):Cast()
	end
	if IsReady("Execute") and TargetinRange(5) and RangeCount(8) < 4 and (Player:BuffUp(S.ShieldBlockBuff) and Player:BuffUp(S.IgnorePain)) then
		return S.Execute:Cast()
	end
	return nil
end

local function APL()
	-- print(IsReady("Thunder Blast") , TargetinRange(10) , RangeCount(10) > 10  , (Player:BuffStack(S.ThunderBlastBuff) == 2 and Player:BuffStack(S.BurstofPowerBuff) <= 1 and Player:BuffUp(S.AvatarBuff) and S.UnstoppableForce:IsAvailable()))
	--------------------------------------------------------------------------------------------------------------------------------------------
	-------------------------------------------------------Functions/Top priorities-------------------------------------------------------------
	--------------------------------------------------------------------------------------------------------------------------------------------

	if Player:IsCasting() or Player:IsChanneling() then
		return 0, "Interface\\Addons\\Rubim-RH\\Media\\channel.tga"
	elseif Player:IsDeadOrGhost() or AuraUtil.FindAuraByName("Drink", "player") or AuraUtil.FindAuraByName("Food", "player")
		or AuraUtil.FindAuraByName("Food & Drink", "player") or AuraUtil.FindAuraByName("Ghost Wolf", "player") then
		return 0, "Interface\\Addons\\Rubim-RH\\Media\\griph.tga"
	end

	trinket1 = GetInventoryItemID("player", 13)

	trinket2 = GetInventoryItemID("player", 14)

	if trinket1 then
		trinket1ready = C_Item.IsUsableItem(trinket1) and GetItemCooldown(trinket1) == 0 and
			C_Item.IsEquippedItem(trinket1)
	else
		trinket1ready = false
	end

	if trinket2 then
		trinket2ready = C_Item.IsUsableItem(trinket2) and GetItemCooldown(trinket2) == 0 and
			C_Item.IsEquippedItem(trinket2)
	else
		trinket2ready = false
	end

	local useSW = not AuraUtil.FindAuraByName("Last Stand", "player") and
		not AuraUtil.FindAuraByName("Spell Block", "player") and not AuraUtil.FindAuraByName("Rallying Cry", "player") and
		not AuraUtil.FindAuraByName("Demoralizing Shout", "target", "PLAYER|HARMFUL") and
		not AuraUtil.FindAuraByName("Shield Wall", "player")
	local useLS = not AuraUtil.FindAuraByName("Shield Wall", "player") and
		not AuraUtil.FindAuraByName("Spell Block", "player") and not AuraUtil.FindAuraByName("Rallying Cry", "player") and
		not AuraUtil.FindAuraByName("Demoralizing Shout", "target", "PLAYER|HARMFUL")
	local useSB = not AuraUtil.FindAuraByName("Last Stand", "player") and
		not AuraUtil.FindAuraByName("Shield Wall", "player") and not AuraUtil.FindAuraByName("Rallying Cry", "player") and
		not AuraUtil.FindAuraByName("Demoralizing Shout", "target", "PLAYER|HARMFUL") and
		not AuraUtil.FindAuraByName("Spell Reflection", "player")
	local useRC = not AuraUtil.FindAuraByName("Last Stand", "player") and
		not AuraUtil.FindAuraByName("Shield Wall", "player") and not AuraUtil.FindAuraByName("Rallying Cry", "player") and
		not AuraUtil.FindAuraByName("Demoralizing Shout", "target", "PLAYER|HARMFUL") and
		not AuraUtil.FindAuraByName("Spell Reflection", "player")

	-- local Boss = {
	-- 	"Avanoxx", "Orator Krix'vizk", "Fangs of the Queen", "The Coaglamation", "Izo, the Grand Splicer",
	-- 	"Speaker Shadowcrown", "Anub'Ikkaj", "E.D.N.A",
	-- 	"Master Machinists Brokk and Dorlita", "Skarmorak", "Mistcaller", "Blightbone", "Amarth", "Surgeon Stitchflesh",
	-- 	"General Umbriss", "Drahga Shadowburner", "Geezle Gigazap"
	-- 	"Erudax, the Duke of Below", "Ki'katal the Harvester", "Forgemaster Throngus", "Viq'Goth", "Bone Spear",
	-- }

	local level, affixIDs, wasEnergized = C_ChallengeMode.GetActiveKeystoneInfo()
	local highkey = 2

	-- validmobsinrange8y = combatmobs40() * .7
	-- validmobsinrange30y = combatmobs40() * .7

	-- if RangeCount(8) > validmobsinrange8y and combatmobs40() > 0 then
	-- 	aoecds8y = true
	-- else
	-- 	aoecds8y = false
	-- end

	local castchannelTime = math.random(250, 500) / 1000

	local startTimeMS = select(4, UnitCastingInfo('target')) or 0

	local currentTimeMS = GetTime() * 1000

	local elapsedTimeca = (startTimeMS > 0) and (currentTimeMS - startTimeMS) or 0

	castTime = elapsedTimeca / 1000

	local startTimeMS = select(4, UnitCastingInfo('target')) or select(4, UnitChannelInfo('target')) or 0

	local currentTimeMS = GetTime() * 1000

	local elapsedTimech = (startTimeMS > 0) and (currentTimeMS - startTimeMS) or 0

	channelTime = elapsedTimech / 1000

	--tankBuster = select(1, UnitCastingInfo("target")) == "Obsidian Beam" or select(1, UnitCastingInfo("target")) == "Terrifying Slam"

	TrackHealthLossPerSecond()

	HPpercentloss = GetHealthLossPerSecond()

	-- print(HPpercentloss)

	local isEnraged = (AuraUtil.FindAuraByName("Enrage", "target") or UnitChannelInfo("target") == "Ragestorm" or AuraUtil.FindAuraByName("Frenzy", "target"))

	local isTanking, status, threatpct, rawthreatpct, threatvalue = UnitDetailedThreatSituation("player", "target")

	in_trouble = HPpercentloss > 0 and Player:HealthPercentage() < 20

	useDefensive = not AuraUtil.FindAuraByName("Demoralizing Shout", "target", "PLAYER|HARMFUL") and
		(not AuraUtil.FindAuraByName("Avatar", "player") and S.ImmovableObject:IsAvailable() or not S.ImmovableObject:IsAvailable()) and
		not AuraUtil.FindAuraByName("Shield Wall", "player") and not AuraUtil.FindAuraByName("Last Stand", "player")
	--------------------------------------------------------------------------------------------------------------------------------------------
	------------------------------------------------------------Out of Combat-------------------------------------------------------------------
	--------------------------------------------------------------------------------------------------------------------------------------------
	if not Player:AffectingCombat() then
		if IsReady("Battle Shout") and Player:BuffDown(S.BattleShoutBuff) then
			return S.BattleShout:Cast()
		end
	end
	--------------------------------------------------------------------------------------------------------------------------------------------
	-------------------------------------------------------------Spell Queue--------------------------------------------------------------------
	--------------------------------------------------------------------------------------------------------------------------------------------
	if not RubimRH.queuedSpell[1]:CooldownUp() or not Player:AffectingCombat() or RangeCount(20) == 0 then
		RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
	end

	if S.HeroicThrow:ID() == RubimRH.queuedSpell[1]:ID() and (targetRange8 or not targetRange30) then
		RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
	end

	if IsReady(RubimRH.queuedSpell[1]:ID(), nil, nil, 1) then
		return RubimRH.QueuedSpell():Cast()
	end
	--------------------------------------------------------------------------------------------------------------------------------------------
	-------------------------------------------------------------Interrupts---------------------------------------------------------------------
	--------------------------------------------------------------------------------------------------------------------------------------------
	if RubimRH.InterruptsON() then
		if IsReady("Pummel") and TargetinRange(nil,"Pummel") and (castTime > castchannelTime + 0.5 or channelTime > castchannelTime + 0.5) and select(8, UnitCastingInfo("target")) == false then
			return S.Pummel:Cast()
		end

		if IsReady("Disrupting Shout") and S.Pummel:CooldownRemains() > 1 and TargetinRange(8) and (castTime > castchannelTime + 0.5 or channelTime > castchannelTime + 0.5) and select(8, UnitCastingInfo("target")) == false then
			return S.DisruptingShout:Cast()
		end
	end
	--------------------------------------------------------------------------------------------------------------------------------------------
	-------------------------------------------------------------Defensives/Cooldowns-----------------------------------------------------------
	--------------------------------------------------------------------------------------------------------------------------------------------
	if Player:AffectingCombat() then
		if IsReady("Spell Reflection") and SpellReflect() then
			return S.SpellReflection:Cast()
		end

		if IsReady("Impending Victory") and (Player:HealthPercentage() < 35 or mitigateboss() or mitigatedng()) then
			return S.ImpendingVictory:Cast()
		end

		if IsReady("Defensive Stance") and (Player:HealthPercentage() < 75 or mitigateboss() or mitigatedng()) and not Player:BuffUp(S.DefensiveStance) then
			return S.DefensiveStance:Cast()
		end

		if IsReady("Battle Stance") and (Player:HealthPercentage() >= 100 and Player:BuffUp(S.IgnorePain) and not mitigateboss() and not mitigatedng()) and not Player:BuffUp(S.BattleStance) then
			return S.BattleStance:Cast()
		end

		if IsReady("Rallying Cry") and (Player:HealthPercentage() < 35 or mitigateboss() or mitigatedng()) then
			return S.RallyingCry:Cast()
		end

		if IsReady("Spell Block") and (Player:HealthPercentage() < 35 or mitigateboss() or mitigatedng()) then
			return S.SpellBlock:Cast()
		end
	end

	if Player:AffectingCombat() then
		if (mitigateboss() or mitigateNWBoss or mitigateGBBoss) or mitigatedng() then
			if IsReady("Shield Wall") and Player:BuffDown(S.ShieldWallBuff) and useSW then
				return S.ShieldWall:Cast()
			end

			if IsReady("Last Stand") and useLS then
				return S.LastStand:Cast()
			end

			if IsReady("Spell Block") and useSB and SpellReflect() then
				return S.SpellBlock:Cast()
			end

			if IsReady("Rallying Cry") and useRC then
				return S.RallyingCry:Cast()
			end
		end

		--actively use defensives if not on a boss with tank busters or if key is low -- basically want to make sure defensives are being used
		--during boss encounters with tank busters and low key if health is dropping (probably some chaos pulling going on in to the boss in this scenario)
		--if not IsEncounterInProgress(Boss) or level < highkey then
			if IsReady("Shield Wall")
				and (HPpercentloss > 5
					and Player:HealthPercentage() < 65 or Player:BuffDown(S.IgnorePain))
				and useSW then
				return S.ShieldWall:Cast()
			end

			if IsReady("Last Stand")
				and (HPpercentloss > 10
					and Player:HealthPercentage() < 65 or Player:HealthPercentage() < 50)
				and useLS then
				return S.LastStand:Cast()
			end


			if IsReady("Spell Block") and SpellReflect()
				and (HPpercentloss > 10
					and Player:HealthPercentage() < 40 or Player:HealthPercentage() < 25)
				and useSB then
				return S.SpellBlock:Cast()
			end


			if IsReady("Rallying Cry")
				and (HPpercentloss > 10
					and Player:HealthPercentage() < 65 or Player:HealthPercentage() < 50)
				and useRC then
				return S.RallyingCry:Cast()
			end
		--end

		if Player:HealthPercentage() < 25
			and ((C_Item.IsUsableItem(211879) and GetItemCooldown(211879) == 0 and GetItemCount(211879) >= 1)
				or (C_Item.IsUsableItem(211878) and GetItemCooldown(211878) == 0 and GetItemCount(211878) >= 1)
				or (C_Item.IsUsableItem(211880) and GetItemCooldown(211880) == 0 and GetItemCount(211880) >= 1)) then
			return I.HPIcon:Cast()
		end
	end
	--------------------------------------------------------------------------------------------------------------------------------------------
	-------------------------------------------------------------Rotation-----------------------------------------------------------------------
	--------------------------------------------------------------------------------------------------------------------------------------------
	if UnitCanAttack('player', 'target') and not Target:IsDeadOrGhost() and (Target:AffectingCombat() or C_Spell.IsCurrentSpell(6603)) then
		if not C_Spell.IsCurrentSpell(6603) and Player:CanAttack(Target) and Target:AffectingCombat() and Target:IsInRange(20) then
			return S.autoattack:Cast()
		end

		-- --hold aggro
		-- if TargetinRange(30) and isTanking == false and not Target:IsAPlayer() and Target:AffectingCombat() and not UnitInRaid("player") then
		-- 	if IsReady("Taunt") then
		-- 		return S.Taunt:Cast()
		-- 	end

		-- 	if IsReady("Heroic Throw") and not TargetinRange(8) and S.Taunt:CooldownDown() then
		-- 		return S.HeroicThrow:Cast()
		-- 	end

		-- 	if IsReady("Challenging Shout") and RangeCount(10) >= 1 and S.Taunt:CooldownDown() then
		-- 		return S.ChallengingShout:Cast()
		-- 	end

		-- 	if IsReady("Disrupting Shout") and RangeCount(10) >= 1 and S.Taunt:CooldownDown() then
		-- 		return S.DisruptingShout:Cast()
		-- 	end
		-- end

		-- if not Player:IsTankingAoE(8)and TargetinRange(10) and RangeCount(10) and not target_is_dummy() and IsResting("player") == false and not Target:IsAPlayer() and not in_trouble then
		-- 	if IsReady("Thunder Clap")  then
		-- 		return Spell(115942):Cast()
		-- 	end
		-- end

		if RubimRH.CDsON() then
			--use_items,slots=trinket1,if=buff.between_the_eyes.up|trinket.1.has_stat.any_dps|fight_remains<=20
			if trinket1ready then
				return Item(118330):Cast()
			end
			--use_items,slots=trinket2,if=buff.between_the_eyes.up|trinket.2.has_stat.any_dps|fight_remains<=20
			if trinket2ready then
				return Item(114616):Cast()
			end
		end

		if Rotation() then
			return Rotation()
		end
	end

	return 0, "Interface\\Addons\\Rubim-RH\\Media\\mount2.tga"
end

RubimRH.Rotation.SetAPL(73, APL);
