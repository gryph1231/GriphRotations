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
autoattack             = Spell(59752), -- will to survive (human racial)
lust1 = Spell(57724),
lust2 = Spell(57723),
lust3 = Spell(80354),
lust4 = Spell(95809),
lust5 = Spell(264689),
lustAT = Spell(265221), -- fireblood
BattleShout                           = Spell(6673),
Charge                                = Spell(100),
HeroicThrow                           = Spell(57755),
Pummel                                = Spell(6552),
Slam                                  = Spell(1464),
VictoryRush                           = Spell(34428),
DefensiveStance                       = Spell(386208),
-- Talents
Avatar                                = Spell(107574),
BerserkerRage                         = Spell(18499),
BerserkersTorment                     = Spell(390123),
BloodandThunder                       = Spell(384277),
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
RumblingEarth                         = Spell(275339),
Shockwave                             = Spell(46968),
SonicBoom                             = Spell(390725),
ChampionsSpear                        = Spell(376079),
SpellReflection                       = Spell(23920),
StormBolt                             = Spell(107570),
ThunderClap                           = MultiSpell(6343),
ThunderousRoar                        = Spell(384318),
TitanicThrow                          = Spell(384090),
WreckingThrow                         = Spell(384110),
-- Buffs
AvatarBuff                            = Spell(107574),
BattleShoutBuff                       = Spell(6673),
ElysianMightBuff                      = Spell(386286),
HurricaneBuff                         = Spell(390581),
WarMachineBuff                        = Spell(262232),
-- Debuffs
MarkofFyralathDebuff                  = Spell(414532),
ThunderousRoarDebuff                  = Spell(397364),
-- Pool
Pool                                  = Spell(999910),
-- Abilities
BattleStance                          = Spell(386164),
Devastate                             = Spell(20243),
Execute                               = Spell(163201),
ShieldBlock                           = Spell(2565),
ShieldSlam                            = Spell(23922),
-- Talents
BitterImmunity = Spell(383762),
Avatar                                = Spell(401150),
BarbaricTraining                      = Spell(390675),
Bolster                               = Spell(280001),
BoomingVoice                          = Spell(202743),
ChampionsBulwark                      = Spell(386328),
DemoralizingShout                     = Spell(1160),
EnduringDefenses                      = Spell(386027),
HeavyRepercussions                    = Spell(203177),
IgnorePain                            = Spell(190456),
SpellBlock 							  = Spell(392966),
Taunt 								  = Spell(355),
Intervene                             = Spell(3411),
ImpenetrableWall                      = Spell(384072),
Juggernaut                            = Spell(393967),
LastStand                             = Spell(12975),
Massacre                              = Spell(281001),
Ravager                               = Spell(228920),
Rend                                  = Spell(394062),
Revenge                               = Spell(6572),
SeismicReverberation                  = Spell(382956),
ShieldCharge                          = Spell(385952),
ShieldWall                            = Spell(871),
SuddenDeath                           = Spell(29725),
UnnervingFocus                        = Spell(384042),
UnstoppableForce                      = Spell(275336),
-- Buffs
AvatarBuff                            = Spell(401150),
EarthenTenacityBuff                   = Spell(410218), -- T30 4P
FervidBuff                            = Spell(425517), -- T31 2P
LastStandBuff                         = Spell(12975),
RallyingCryBuff                       = Spell(97463),
RevengeBuff                           = Spell(5302),
SeeingRedBuff                         = Spell(386486),
ShieldBlockBuff                       = Spell(132404),
ShieldWallBuff                        = Spell(871),
SuddenDeathBuff                       = Spell(52437),
ViolentOutburstBuff                   = Spell(386478),
VanguardsDeterminationBuff            = Spell(394056), -- T29 2P
-- Debuffs
RendDebuff                            = Spell(388539),
Potion 								  = Spell(176108),
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
				"Alloy Bolt", "Censoring Gear", "Shadow Claw"
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
		"Clinging Darkness", "Shadow Well"
	}
	for _, debuff in ipairs(dangerousDebuffs) do
		if AuraUtil.FindAuraByName(debuff, "player", "HARMFUL") then
			return true
		end
	end
  
	return false
  end

local function Rotation()
	if IsReady("Ravager") and RubimRH.CDsON() and TargetinRange(5) and RangeCount(8) >= 1 and GetRangeTimer()>1.5 and HL.CombatTime() > 2 then
		return S.Ravager:Cast()
	end

	if IsReady("Avatar") and RubimRH.CDsON() and TargetinRange(5) then
		return S.Avatar:Cast()
	end

	if IsReady("Shield Block") and Player:Rage() >= 30 and RangeCount(10) >= 1 and ((Player:BuffUp(S.ShieldBlockBuff) and Player:BuffRemains(S.ShieldBlockBuff) < Player:GCD()) or Player:BuffDown(S.ShieldBlockBuff) or S.ShieldBlock:Charges() == 2) then
		return S.ShieldBlock:Cast()
	end

	if IsReady("Ignore Pain") and TargetinRange(10) and (Player:Rage() > 85 or ((Player:BuffUp(S.IgnorePain) and Player:BuffRemains(S.IgnorePain) < Player:GCD()) or Player:BuffDown(S.IgnorePain))) then
		return S.IgnorePain:Cast()
	end

	if IsReady(376079) and RubimRH.CDsON() and TargetinRange(5) and S.ChampionsSpear:IsAvailable() then
		return S.ChampionsSpear:Cast()
	end

	if IsReady("Thunder Clap") and RangeCount(8) >= 2 and C_Spell.GetSpellInfo("Thunder Clap").iconID == 460957 then
		return Spell(115942):Cast()
	end

	if Player:BuffUp(S.ViolentOutburstBuff) then
		if IsReady("Shield Slam") and RangeCount(8) >= 2 and RangeCount(8) < 4 then
			return S.ShieldSlam:Cast()
		end

		if IsReady("Thunder Clap") and RangeCount(8) >= 4 then
			return Spell(115942):Cast()
		end
	end

	if S.ShieldCharge:IsReady() and TargetinRange(5) then
		return S.ShieldCharge:Cast()
	end

	if S.ShieldSlam:IsReady() and TargetinRange(5) then
		return S.ShieldSlam:Cast()
	end

	if S.Execute:IsReady() and TargetinRange(5) and Player:Rage() >= 60 then
		return S.Execute:Cast()
	end

	if S.Revenge:IsReady() and TargetinRange(5) and Player:Rage() >= 60 then
		return S.Revenge:Cast()
	end

	if IsReady("Thunder Clap") and RangeCount(8) >= 1 then
		return Spell(115942):Cast()
	end

	return nil
end

local function APL()
--------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------Functions/Top priorities-------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
if Player:IsCasting() or Player:IsChanneling() then
	return 0, "Interface\\Addons\\Rubim-RH\\Media\\channel.tga"
elseif Player:IsDeadOrGhost() or AuraUtil.FindAuraByName("Drink", "player") or AuraUtil.FindAuraByName("Food", "player") 
or AuraUtil.FindAuraByName("Food & Drink", "player") or AuraUtil.FindAuraByName("Ghost Wolf", "player") then
	return 0, "Interface\\Addons\\Rubim-RH\\Media\\griph.tga"
end


local castchannelTime = math.random(250, 500) / 1000

local startTimeMS = select(4, UnitCastingInfo('target')) or 0

local currentTimeMS = GetTime() * 1000

local elapsedTimeca = (startTimeMS > 0) and (currentTimeMS - startTimeMS) or 0

castTime = elapsedTimeca / 1000

local startTimeMS = select(4, UnitCastingInfo('target')) or select(4, UnitChannelInfo('target')) or 0

local currentTimeMS = GetTime() * 1000

local elapsedTimech = (startTimeMS > 0) and (currentTimeMS - startTimeMS) or 0

channelTime = elapsedTimech/1000

--tankBuster = select(1, UnitCastingInfo("target")) == "Obsidian Beam" or select(1, UnitCastingInfo("target")) == "Terrifying Slam"

HPpercentloss = GetHealthLossPerSecond()

local isEnraged = (AuraUtil.FindAuraByName("Enrage", "target") or UnitChannelInfo("target") == "Ragestorm" or AuraUtil.FindAuraByName("Frenzy", "target"))

local isTanking, status, threatpct, rawthreatpct, threatvalue = UnitDetailedThreatSituation("player", "target")

in_trouble = HPpercentloss > 0 and Player:HealthPercentage() < 20

useDefensive = not AuraUtil.FindAuraByName("Demoralizing Shout","target","PLAYER|HARMFUL") and  (not AuraUtil.FindAuraByName("Avatar", "player") and S.ImmovableObject:IsAvailable() or not S.ImmovableObject:IsAvailable()) and not AuraUtil.FindAuraByName("Shield Wall", "player") and not AuraUtil.FindAuraByName("Last Stand", "player")
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

if IsReady(RubimRH.queuedSpell[1]:ID(),nil,nil,1) then
	return RubimRH.QueuedSpell():Cast()
end
--------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------Interrupts---------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
if RubimRH.InterruptsON() then
	if IsReady("Pummel") and TargetinRange(8) and (castTime > castchannelTime+0.5 or channelTime > castchannelTime+0.5) and select(8, UnitCastingInfo("target")) == false then
		return S.Pummel:Cast()
	end
end
--------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------Defensives/Cooldowns-----------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
if RubimRH.InterruptsON() then
	if IsReady("Spell Reflection") and SpellReflect() then
		return S.SpellReflection:Cast()
	end

	if IsReady("Defensive Stance") and (Player:HealthPercentage() < 75 or select(1, UnitCastingInfo("target")) == "Obsidian Beam" or select(1, UnitCastingInfo("target")) == "Seismic Smash") and not Player:BuffUp(S.DefensiveStance) then
		return S.DefensiveStance:Cast()
	end
	
	if IsReady("Battle Stance") and (Player:HealthPercentage() >= 75 and select(1, UnitCastingInfo("target")) ~= "Obsidian Beam" and select(1, UnitCastingInfo("target")) ~= "Seismic Smash") and not Player:BuffUp(S.BattleStance) then
		return S.BattleStance:Cast()
	end
end

if Player:AffectingCombat() and RangeCount(8) >= 1 and not Player:InArena() and not Player:InBattlegrounds() and RubimRH.InterruptsON() then
	if IsReady("Shield Wall") and not Player:BuffUp(S.ShieldWallBuff) and ((Player:HealthPercentage() < 50 or (Player:HealthPercentage() < 70 and S.ShieldWall:ChargesFractional() >= 1.75) or select(1, UnitCastingInfo("target")) == "Obsidian Beam" or select(1, UnitCastingInfo("target")) == "Terrifying Slam") or select(1, UnitCastingInfo("target")) == "Seismic Smash") then
		return S.ShieldWall:Cast()
	end	

	if IsReady("Last Stand") and (Player:HealthPercentage() < 35 or ((select(1, UnitCastingInfo("target")) == "Obsidian Beam" or select(1, UnitCastingInfo("target")) == "Seismic Smash" or select(1, UnitCastingInfo("target")) == "Terrifying Slam") and not Player:BuffUp(S.ShieldWallBuff) and not Player:BuffUp(S.SpellReflection))) then
		return S.LastStand:Cast()
	end	

	if IsReady("Impending Victory") and Player:HealthPercentage() < 45 and TargetinRange(5) then
		return S.ImpendingVictory:Cast()
	end	
	
	if Player:HealthPercentage() < 25 
	and ((C_Item.IsUsableItem(211879) and GetItemCooldown(211879) == 0 and GetItemCount(211879) >= 1)
	or (C_Item.IsUsableItem(211878) and GetItemCooldown(211878) == 0 and GetItemCount(211878) >= 1)
	or (C_Item.IsUsableItem(211880) and GetItemCooldown(211880) == 0 and GetItemCount(211880) >= 1)) then
		return I.HPIcon:Cast()
	end

	if IsReady("Demoralizing Shout") and RubimRH.CDsON() and (Player:HealthPercentage() < 75 or Player:Rage() < 20) then
		return S.DemoralizingShout:Cast()
	end
end
--------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------Rotation-----------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
if UnitCanAttack('player','target') and not Target:IsDeadOrGhost() and (Target:AffectingCombat() or C_Spell.IsCurrentSpell(6603)) then
	if not C_Spell.IsCurrentSpell(6603) and Player:CanAttack(Target) and Target:AffectingCombat() and Target:IsInRange(20) then
		return S.autoattack:Cast()
	end

	if not Player:IsTankingAoE(8) and RangeCount(8) > 1 and not target_is_dummy() and IsResting("player") == false and not Target:IsAPlayer() and not in_trouble then
		if IsReady("Thunder Clap") then
			return Spell(115942):Cast()
		end
	end


	if Rotation() then
		return Rotation()
	end
end

	return 0, "Interface\\Addons\\Rubim-RH\\Media\\griph.tga"
end

RubimRH.Rotation.SetAPL(73, APL);