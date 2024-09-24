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
-- Racials
--   AncestralCall                         = Spell(274738),
--   ArcaneTorrent                         = Spell(50613),
--   BagofTricks                           = Spell(312411),
--   Berserking                            = Spell(26297),
--   BloodFury                             = Spell(20572),
--   Fireblood                             = Spell(265221),
--   LightsJudgment                        = Spell(255647),
-- Abilities
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
SpellBlock = Spell(392966),
Taunt = Spell(355),
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


local function num(val)
if val then return 1 else return 0 end
end

local function bool(val)
return val ~= 0
end



local function IgnorePainWillNotCap()
	if Player:BuffUp(S.IgnorePain) then
	local NewAbsorb = Player:AttackPowerDamageMod() * 4.375 * (1 + Player:VersatilityDmgPct() / 100)
	local IPBuffTable = Player:AuraInfo(S.IgnorePain, nil, true)
	local OldAbsorb = IPBuffTable.points[1]

	if IPBuffTable == nil then
		IPBuffTable = 0
	else
		IPBuffTable = Player:AuraInfo(S.IgnorePain, nil, true)
	end
	if IPBuffTable.points[1] == nil then
		IPBuffTable = 0
	else
		OldAbsorb = IPBuffTable.points[1]
	end
	-- Ignore Pain appears to cap at 30% of player's max health
	-- https://github.com/simulationcraft/simc/blob/dragonflight/engine/class_modules/sc_warrior.cpp#L7789 as of Sept 21, 2023
	return OldAbsorb + NewAbsorb < Player:MaxHealth() * 0.3
	else
	return true
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


-- A bit of logic to decide whether to pre-cast-rage-dump on ignore pain.
local function SuggestRageDump(RageFromSpell)
	-- Get RageMax from setting (default 80)
	local RageMax = 85
	-- If the setting value is lower than 35, it's not possible to cast Ignore Pain, so just return false
	if (RageMax < 35 or Player:Rage() < 35) then return false end
	local ShouldPreRageDump = false
	-- Make sure we have enough Rage to cast IP, that it's not on CD, and that we shouldn't use Shield Block
	local AbleToCastIP = (Player:Rage() >= 35 and not pressshieldblock)
	if AbleToCastIP and (Player:Rage() + RageFromSpell >= RageMax or S.DemoralizingShout:IsReady()) then
	-- should pre-dump rage into IP if rage + RageFromSpell >= RageMax or Demo Shout is ready
	shouldPreRageDump = true
	end
	if shouldPreRageDump and targetRange8 then
	if IgnorePainWillNotCap() then
	return S.IgnorePain:Cast()
	else
	return S.Revenge:Cast()
	end
	end
end



local function AoE()
	--thunder_clap,if=dot.rend.remains<=1
	if S.ThunderClap:IsCastable() and (Target:DebuffRemains(S.RendDebuff) <= 1) and targetRange8 then
	SuggestRageDump(5)
	return S.ThunderClap:Cast()
	end
	-- shield_slam,if=(set_bonus.tier30_2pc|set_bonus.tier30_4pc)&spell_targets.thunder_clap<=7|buff.earthen_tenacity.up
	-- Note: If set_bonus.tier30_2pc is true, then tier30_4pc would be true also, so just checking for 2pc.
	if S.ShieldSlam:IsCastable() and (tierequipped()>1 and inRange8 <= 7 or Player:BuffUp(S.EarthenTenacityBuff)) and targetRange8 then
	return S.ShieldSlam:Cast()
	end
	-- thunder_clap,if=buff.violent_outburst.up&spell_targets.thunderclap>6&buff.avatar.up&talent.unstoppable_force.enabled
	if S.ThunderClap:IsCastable() and targetRange8 and (Player:BuffUp(S.ViolentOutburstBuff) and inRange8 > 6 and Player:BuffUp(S.AvatarBuff) and S.UnstoppableForce:IsAvailable()) then
	SuggestRageDump(5)
	return S.ThunderClap:Cast()
	end
	--revenge,if=rage>=70&talent.seismic_reverberation.enabled&spell_targets.revenge>=3
	if S.Revenge:IsReady() and targetRange8 and (Player:Rage() >= 70 and S.SeismicReverberation:IsAvailable() and inRange8 >= 3) then
	return S.Revenge:Cast()
	end
	--shield_slam,if=rage<=60|buff.violent_outburst.up&spell_targets.thunderclap<=7
	if S.ShieldSlam:IsCastable() and (Player:Rage() <= 60 or Player:BuffUp(S.ViolentOutburstBuff) and inRange8 <= 7) and targetRange8 then
	SuggestRageDump(20)
	return S.ShieldSlam:Cast()
	end
	--thunder_clap
	if S.ThunderClap:IsCastable() and targetRange8  then
	SuggestRageDump(5)
	return S.ThunderClap:Cast()
	end
	--revenge,if=rage>=30|rage>=40&talent.barbaric_training.enabled
	if S.Revenge:IsReady() and targetRange8 and (Player:Rage() >= 30 or Player:Rage() >= 40 and S.BarbaricTraining:IsAvailable()) then
	return S.Revenge:Cast()
	end
end



local function Generic()
	-- shield_slam
	if S.ShieldSlam:IsCastable()  and targetRange8 then
	SuggestRageDump(20)
	return S.ShieldSlam:Cast()
	end
	-- thunder_clap,if=dot.rend.remains<=2&buff.violent_outburst.down
	if S.ThunderClap:IsCastable() and targetRange8 and (Target:DebuffRemains(S.RendDebuff) <= 2 and Player:BuffDown(S.ViolentOutburstBuff)) then
	SuggestRageDump(5)
	return S.ThunderClap:Cast()
	end
	-- execute,if=buff.sudden_death.up&talent.sudden_death.enabled
	if S.Execute:IsReady() and (Player:BuffUp(S.SuddenDeathBuff) and S.SuddenDeath:IsAvailable()) and targetRange8 then
	return S.Execute:Cast()
	end
	-- execute
	if S.Execute:IsReady() and targetRange8 then
	return S.Execute:Cast()
	end
	-- thunder_clap,if=(spell_targets.thunder_clap>1|cooldown.shield_slam.remains&!buff.violent_outburst.up)
	if S.ThunderClap:IsCastable() and (inRange8 > 1 or S.ShieldSlam:CooldownDown() and Player:BuffDown(S.ViolentOutburstBuff)) and targetRange8 then
	SuggestRageDump(5)
	return S.ThunderClap:Cast()
	end
	--revenge,if=
	--(rage>=80&target.health.pct>20|buff.revenge.up&target.health.pct<=20&rage<=18&cooldown.shield_slam.remains|buff.revenge.up&target.health.pct>20)
	--|(rage>=80&target.health.pct>35|buff.revenge.up&target.health.pct<=35&rage<=18&cooldown.shield_slam.remains|buff.revenge.up&target.health.pct>35)
	--&talent.massacre.enabled
	if S.Revenge:IsReady() and targetRange8 
	and ((Player:Rage() >= 80 and Target:HealthPercentage() > 20 or Player:BuffUp(S.RevengeBuff) and Target:HealthPercentage() <= 20 and Player:Rage() <= 18 and S.ShieldSlam:CooldownDown() or Player:BuffUp(S.RevengeBuff) and Target:HealthPercentage() > 20) 
	or (Player:Rage() >= 80 and Target:HealthPercentage() > 35 or Player:BuffUp(S.RevengeBuff) and Target:HealthPercentage() <= 35 and Player:Rage() <= 18 and S.ShieldSlam:CooldownDown() or Player:BuffUp(S.RevengeBuff) and Target:HealthPercentage() > 35) 
	and S.Massacre:IsAvailable()) then
	return S.Revenge:Cast()
	end
	-- execute,if=spell_targets.revenge=1
	if S.Execute:IsReady() and (inRange8 == 1) then
	return S.Execute:Cast()
	end
	-- revenge,if=target.health>20
	if S.Revenge:IsReady() and targetRange8 and (Target:HealthPercentage() > 20) then
	return S.Revenge:Cast()
	end
	-- thunder_clap,if=(spell_targets.thunder_clap>=1|cooldown.shield_slam.remains&buff.violent_outburst.up)
	if S.ThunderClap:IsCastable() and (inRange8 >= 1 or S.ShieldSlam:CooldownDown() and Player:BuffUp(S.ViolentOutburstBuff)) and targetRange8 then
	SuggestRageDump(5)
	return S.ThunderClap:Cast()
	end
	-- devastate
	if S.Devastate:IsCastable() then
	return S.Devastate:Cast()
	end
end







--- ======= ACTION LISTS =======
local function APL()

		--------------------------------------------------------------------------------------------------------------------------------------------
		----------------------------------------------------------Functions-----------------------------------------------------------------------
		--------------------------------------------------------------------------------------------------------------------------------------------

		inRange5 = RangeCount(5)
		inRange8 = RangeCount(8)
		inRange10 = RangeCount(10)
		inRange15 = RangeCount(15)
		inRange20 = RangeCount(20)
		inRange25 = RangeCount(25)
		inRange30 = RangeCount(30)
		targetRange5 = IsItemInRange(8149, "target")
		targetRange8 = IsItemInRange(34368, "target")
		targetRange10 = IsItemInRange(32321, "target")
		targetRange15 = IsItemInRange(33069, "target")
		targetRange20 = IsItemInRange(10645, "target")
		targetRange25 = IsItemInRange(24268, "target")
		targetRange30 = IsItemInRange(835, "target")
		local isEnraged = (AuraUtil.FindAuraByName("Enrage", "target") or UnitChannelInfo("target") == "Ragestorm" or AuraUtil.FindAuraByName("Frenzy", "target"))
		local isTanking, status, threatpct, rawthreatpct, threatvalue = UnitDetailedThreatSituation("player", "target")

		local pressshieldblock = isTanking ==true and S.ShieldBlock:IsReady() and ((Player:BuffDown(S.ShieldBlockBuff)  or Player:BuffRemains(S.ShieldBlockBuff) < S.ShieldSlam:CooldownRemains()) and Player:BuffDown(S.LastStandBuff) and Target:HealthPercentage() > 20)
		local useDefensive =   not AuraUtil.FindAuraByName("Demoralizing Shout","target","PLAYER|HARMFUL") and  (not AuraUtil.FindAuraByName("Avatar", "player") and S.ImmovableObject:IsAvailable() or not S.ImmovableObject:IsAvailable()) and not AuraUtil.FindAuraByName("Shield Wall", "player") and not AuraUtil.FindAuraByName("Last Stand", "player")


		HPpercentloss = GetHealthLossPerSecond()

		inInstance, instanceType = IsInInstance()

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

		-- Define a list of dungeon boss encounter IDs
		local Boss = {
		'The Raging Tempest', 'Teera', 'Balakar Khan','Maruuk',                   -- Nokhud Offensive
		'Hackclaw"s War-Band','Gutshot','Decatriarch Wratheye', -- Brakenhide hollow
		'Emberon','Chrono-Lord Deios', -- udlaman: legacy of tyr
		'Crawth', 'Overgrown Ancient', --Academy
		'Leymor','Umbrelskul', -- Azure vault
		'Kokia Blazehoof','Erkhart Stormvein', 'Defier Draghar','Flamegullet','Thunderhead',--RLP
		'Decatriarch Wratheye',--BHH
		'Chargath, Bane of Scales', 'Forgemaster Gorek', --neltharus
		'Primal Tsunami', -- HoI


		}


		
		validmobsinrange8y = combatmobs40() * .7
		validmobsinrange30y = combatmobs40() * .7

		if inRange8 > validmobsinrange8y and combatmobs40() > 0 then
		aoecds8y = true
		else
		aoecds8y = false
		end

		if Player:IsCasting() or Player:IsChanneling() or AuraUtil.FindAuraByName("Drink", "player") 
		or AuraUtil.FindAuraByName("Food", "player") or AuraUtil.FindAuraByName("Food & Drink", "player") then
		return 0, "Interface\\Addons\\Rubim-RH\\Media\\channel.tga"
		end 

		-- if Player:BuffUp(S.IgnorePain) then
		-- 	local IPBuffInfo = Player:BuffInfo(S.IgnorePain, nil, true)
		-- 	return IPBuffInfo.points[1]
		-- 	else
		-- 	return 0 
		-- 	end

-- print(IgnorePainWillNotCap())
		--------------------------------------------------------------------------------------------------------------------------------------------
		----------------------------------------------------------Spell Queue-----------------------------------------------------------------------
		--------------------------------------------------------------------------------------------------------------------------------------------


		if not RubimRH.queuedSpell[1]:CooldownUp() or not Player:AffectingCombat() or inRange20==0 then
		RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
		end

		-- if S.HeroicThrow:ID() == RubimRH.queuedSpell[1]:ID() and targetRange5 then
		-- RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
		-- end

		if S.lustAT:ID() == RubimRH.queuedSpell[1]:ID()
		and Player:DebuffDown(S.lust1) and Player:DebuffDown(S.lust2) and Player:CanAttack(Target) and 
		Player:DebuffDown(S.lust3) and Player:DebuffDown(S.lust4) and Player:DebuffDown(S.lust5) and (I.drums:IsReady()) then
		return S.lustAT:Cast() -- BIND LUST KEYBIND IN BINDPAD TO ARCANE TORRENT
		end

		if S.lustAT:ID() == RubimRH.queuedSpell[1]:ID() and
		(
		Player:Debuff(S.lust1) or Player:Debuff(S.lust2) or Player:Debuff(S.lust3) or Player:Debuff(S.lust4) or
		Player:Debuff(S.lust5)) then
		RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
		end



		if RubimRH.QueuedSpell():IsReadyQueue() then
		return RubimRH.QueuedSpell():Cast()
		end


		--------------------------------------------------------------------------------------------------------------------------------------------
		----------------------------------------------------------Rotation-----------------------------------------------------------------------
		--------------------------------------------------------------------------------------------------------------------------------------------



		if Target:Exists() and Player:CanAttack(Target) and (Player:AffectingCombat() or Target:AffectingCombat() and not Target:IsDeadOrGhost()) then




			if not C_Spell.IsCurrentSpell(6603) and Player:CanAttack(Target)
			and Target:AffectingCombat() and Player:AffectingCombat() and targetRange20 then
			return S.autoattack:Cast()
			end 

			--health pot -- will need to update item ID of HPs as expansions progress
			if inRange30 >= 1 and Player:HealthPercentage() <= 30 and Player:AffectingCombat() and (IsUsableItem(191380) == true and
			GetItemCooldown(191380) == 0 and GetItemCount(191380) >= 1 or IsUsableItem(207023) == true and
			GetItemCooldown(207023) == 0 and GetItemCount(207023) >= 1)
			and (not Player:InArena() and not Player:InBattlegrounds()) then
			return I.HPIcon:Cast()
			end



			if S.Taunt:IsReady() and targetRange30 and isTanking==false and level>=1 then
			return S.Taunt:Cast()
			end


			if RubimRH.InterruptsON() and not isEnraged and S.Pummel:IsReady() and kickprio() and targetRange8 and (castTime > castchannelTime+0.5 or channelTime > castchannelTime+0.5)  and select(8, UnitCastingInfo("target")) == false  and not isEnraged then
				return S.Pummel:Cast()
				end
				if RubimRH.InterruptsON() and not isEnraged and S.StormBolt:IsReady() and stunprio() and targetRange20 and not isEnraged then
					return S.StormBolt:Cast()
					end
	
				if RubimRH.InterruptsON() and not isEnraged and S.Shockwave:IsReady() and stunprio() and targetRange8 and not isEnraged then
				return S.Shockwave:Cast()
				end
	
   
            if S.IntimidatingShout:IsReady() and targetRange8 and UnitName('target') == 'Incorporeal Being' and not AuraUtil.FindAuraByName("Storm Bolt","target","PLAYER|HARMFUL") and not AuraUtil.FindAuraByName("Blind","target","PLAYER|HARMFUL") and not AuraUtil.FindAuraByName("Turn Evil","target","PLAYER|HARMFUL") and not AuraUtil.FindAuraByName("Repentance","target","PLAYER|HARMFUL")  then
                return S.IntimidatingShout:Cast()
                end
				if S.StormBolt:IsReady() and targetRange8 and UnitName('target') == 'Incorporeal Being' and not AuraUtil.FindAuraByName("Storm Bolt","target","PLAYER|HARMFUL") and not AuraUtil.FindAuraByName("Blind","target","PLAYER|HARMFUL") and not AuraUtil.FindAuraByName("Turn Evil","target","PLAYER|HARMFUL") and not AuraUtil.FindAuraByName("Repentance","target","PLAYER|HARMFUL")  then
					return S.StormBolt:Cast()
					end

			if S.ShieldBlock:IsCastable() and Player:Rage() >= 30 and (isTanking or target_is_dummy()) and Player:AffectingCombat() and inRange10 >= 1
			and (Player:BuffDown(S.ShieldBlockBuff) or S.ShieldBlock:Charges() == 2)  then
			return S.ShieldBlock:Cast()
			end
	
	
			if S.IgnorePain:IsReady() and IgnorePainWillNotCap() and (Target:HealthPercentage() >= 20 and (Player:Rage() >= 85 and S.ShieldSlam:CooldownUp() and Player:BuffUp(S.ShieldBlockBuff) or Player:Rage() >= 60 
			and S.DemoralizingShout:CooldownUp() and S.BoomingVoice:IsAvailable() or Player:Rage() >= 70 and S.Avatar:CooldownUp() or Player:Rage() >= 40 and S.DemoralizingShout:CooldownUp() and S.BoomingVoice:IsAvailable() 
			and Player:BuffUp(S.LastStandBuff) or Player:Rage() >= 55 and S.Avatar:CooldownUp() and Player:BuffUp(S.LastStandBuff) or Player:Rage() >= 80 or Player:Rage() >= 55 and S.ShieldSlam:CooldownUp() and Player:BuffUp(S.ViolentOutburstBuff) 
			and Player:BuffUp(S.ShieldBlockBuff) or Player:Rage() >= 30 and S.ShieldSlam:CooldownUp() and Player:BuffUp(S.ViolentOutburstBuff) and Player:BuffUp(S.LastStandBuff) and Player:BuffUp(S.ShieldBlockBuff))) then
			return S.IgnorePain:Cast()
			end
	

				if S.ShieldWall:IsReady() and (targetRange30 or inRange30>=1) and Player:HealthPercentage()<25 then
				return S.ShieldWall:Cast()
				end
				if S.LastStand:IsReady() and HPpercentloss > 10 and Player:HealthPercentage()<30 and useDefensive and (targetRange30 or inRange30>=1) then
					return S.LastStand:Cast()
					end
				if S.RallyingCry:IsReady() and HPpercentloss > 10 and Player:HealthPercentage()<30 and (targetRange30 or inRange30>=1) and not AuraUtil.FindAuraByName("Last Stand", "player")  then
				return S.RallyingCry:Cast()
				end

				if S.SpellBlock:IsCastable() and HPpercentloss > 5 and not AuraUtil.FindAuraByName("Spell Reflection", "player") 
				and Player:HealthPercentage() < 30 and (targetRange20 or inRange20>=1) then
				return S.SpellBlock:Cast()
				end

			if ((IsEncounterInProgress(Boss) or level>highkey) and mitigatedng()) then 

				if S.LastStand:IsReady()  and useDefensive and (targetRange30 or inRange30>=1)  then
				return S.LastStand:Cast()
				end

				if S.ShieldWall:IsReady()  and useDefensive and (targetRange30 or inRange30>=1) then
				return S.ShieldWall:Cast()
				end
				if S.RallyingCry:IsReady() and useDefensive and (targetRange30 or inRange30>=1) and not AuraUtil.FindAuraByName("Last Stand", "player") then
				return S.RallyingCry:Cast()
				end

				if S.Avatar:IsCastable() and useDefensive and  targetRange10  and S.ImmovableObject:IsAvailable() then
				return S.Avatar:Cast()
				end
				if S.DemoralizingShout:IsCastable() and useDefensive and targetRange8 then
				return S.DemoralizingShout:Cast()
				end


			end


			if (not IsEncounterInProgress(Boss) or level <= highkey)  then
				if S.LastStand:IsReady() and useDefensive and (targetRange30 or inRange30>=1) 
				and HPpercentloss > 10
				and Player:HealthPercentage() < 60 then
				return S.LastStand:Cast()
				end

				if S.ShieldWall:IsReady() and HPpercentloss > 12
				and Player:HealthPercentage() < 55 and useDefensive and (targetRange30 or inRange30>=1) then
				return S.ShieldWall:Cast()
				end
				if S.Avatar:IsCastable() and HPpercentloss > 12 and useDefensive
				and Player:HealthPercentage() < 55 and targetRange10  and S.ImmovableObject:IsAvailable() then
				return S.Avatar:Cast()
				end
				if S.RallyingCry:IsReady() and useDefensive and (targetRange30 or inRange30>=1)  and not AuraUtil.FindAuraByName("Last Stand", "player") 
				and HPpercentloss > 10
				and Player:HealthPercentage() < 60 then
				return S.RallyingCry:Cast()
				end

				if S.DemoralizingShout:IsCastable() and HPpercentloss > 5 and useDefensive
				and Player:HealthPercentage() < 90 and targetRange8   then
				return S.DemoralizingShout:Cast()
				end

			end


			if S.ImpendingVictory:IsReady() and Player:HealthPercentage()<70 and targetRange8 then
				return S.ImpendingVictory:Cast()
			end

			if S.BitterImmunity:IsReady() and Player:HealthPercentage()<80 and inRange20>=1 and (GetAppropriateCureSpell()=='Poison' or GetAppropriateCureSpell()=='Disease' or GetAppropriateCureSpell()=='Curse' or Player:HealthPercentage()<50) then
				return S.BitterImmunity:Cast()
			end

			if S.Avatar:IsCastable() and targetRange5 and RubimRH.CDsON() and not S.ImmovableObject:IsAvailable() then
			return S.Avatar:Cast()
			end




			if S.IgnorePain:IsReady() and IgnorePainWillNotCap() and (Target:HealthPercentage() >= 20 and 
			(Player:RageDeficit() <= 15 and S.ShieldSlam:CooldownUp() 
			or Player:RageDeficit() <= 40 and S.ShieldCharge:CooldownUp() and S.ChampionsBulwark:IsAvailable() 
			or Player:RageDeficit() <= 20 and S.ShieldCharge:CooldownUp() 
			or Player:RageDeficit() <= 30 and S.DemoralizingShout:CooldownUp() and S.BoomingVoice:IsAvailable() 
			or Player:RageDeficit() <= 20 and S.Avatar:CooldownUp() 
			or Player:RageDeficit() <= 45 and S.DemoralizingShout:CooldownUp() and S.BoomingVoice:IsAvailable() and Player:BuffUp(S.LastStandBuff) and S.UnnervingFocus:IsAvailable() 
			or Player:RageDeficit() <= 30 and S.Avatar:CooldownUp() and Player:BuffUp(S.LastStandBuff) and S.UnnervingFocus:IsAvailable()
			or Player:RageDeficit() <= 20
			or Player:RageDeficit() <= 40 and S.ShieldSlam:CooldownUp() and Player:BuffUp(S.ViolentOutburstBuff) and S.HeavyRepercussions:IsAvailable() and S.ImpenetrableWall:IsAvailable() 
			or Player:RageDeficit() <= 55 and S.ShieldSlam:CooldownUp() and Player:BuffUp(S.ViolentOutburstBuff) and Player:BuffUp(S.LastStandBuff) and S.UnnervingFocus:IsAvailable() and S.HeavyRepercussions:IsAvailable() and S.ImpenetrableWall:IsAvailable()
			or Player:RageDeficit() <= 17 and S.ShieldSlam:CooldownUp() and S.HeavyRepercussions:IsAvailable()
			or Player:RageDeficit() <= 18 and S.ShieldSlam:CooldownUp() and S.ImpenetrableWall:IsAvailable())
			or (Player:Rage() >= 70
			or Player:BuffStack(S.SeeingRedBuff) == 7 and Player:Rage() >= 35) and S.ShieldSlam:CooldownRemains() <= 1 and Player:BuffRemains(S.ShieldBlockBuff) >= 4 and tierequipped()>=2) then
			return S.IgnorePain:Cast()
			end

				if RubimRH.CDsON() and targetRange8
				and (AuraUtil.FindAuraByName("Avatar", "player") or S.Avatar:CooldownRemains()>20) then
				local ShouldReturn = UseItems();
				if ShouldReturn then return ShouldReturn; end
				end
	

			-- last_stand,if=(target.health.pct>=90&talent.unnerving_focus.enabled|target.health.pct<=20&talent.unnerving_focus.enabled)|talent.bolster.enabled|set_bonus.tier30_2pc|set_bonus.tier30_4pc
			-- Note: If set_bonus.qtier30_4pc is true, then tier30_2pc would be true as well, so just check for 2pc
			if isTanking == true and targetRange15 and S.LastStand:IsCastable() and Player:BuffDown(S.ShieldWallBuff) and ((Target:HealthPercentage() >= 90 and S.UnnervingFocus:IsAvailable() or Target:HealthPercentage() <= 20 and S.UnnervingFocus:IsAvailable()) or S.Bolster:IsAvailable() or tierequipped()>1) then
			return S.LastStand:Cast()
			end
			-- ravager
			if RubimRH.CDsON() and S.Ravager:IsCastable() and targetRange5 and inRange8>=3 and aoecds8y == true and HL.CombatTime()>2  then
			SuggestRageDump(10)
			return S.Ravager:Cast()
			end
			--demoralizing_shout,if=talent.booming_voice.enabled
			if S.DemoralizingShout:IsCastable() and HPpercentloss>5 and (S.BoomingVoice:IsAvailable()) and targetRange10 and (not IsEncounterInProgress(Boss) or level <= highkey) then
			SuggestRageDump(30)
			return S.DemoralizingShout:Cast()
			end
			-- champions_spear
			if RubimRH.CDsON() and S.ChampionsSpear:IsCastable() and targetRange5 then
			SuggestRageDump(20)
			return S.ChampionsSpear:Cast()
			end
			-- thunderous_roar
			if RubimRH.CDsON() and S.ThunderousRoar:IsCastable() and targetRange8 and inRange10>=3 and aoecds8y == true and HL.CombatTime()>2 then
			return S.ThunderousRoar:Cast()
			end
			-- shield_slam,if=buff.fervid.up
			if S.ShieldSlam:IsReady() and (Player:BuffUp(S.FervidBuff)) and targetRange8 then
			SuggestRageDump(18)
			return S.ShieldSlam:Cast()
			end
			--   -- shockwave,if=talent.sonic_boom.enabled&buff.avatar.up&talent.unstoppable_force.enabled&!talent.rumbling_earth.enabled|talent.sonic_boom.enabled&talent.rumbling_earth.enabled&spell_targets.shockwave>=3
			--   if S.Shockwave:IsCastable() and targetRange5 and (S.SonicBoom:IsAvailable() and Player:BuffUp(S.AvatarBuff) and S.UnstoppableForce:IsAvailable() and not S.RumblingEarth:IsAvailable() or S.SonicBoom:IsAvailable() and S.RumblingEarth:IsAvailable() and inRange8 >= 3) then
			-- 	SuggestRageDump(10)
			-- 	return S.Shockwave:Cast()
			-- end
			-- shield_charge
			if S.ShieldCharge:IsCastable() and targetRange5 then
			SuggestRageDump(40)
			return S.ShieldCharge:Cast()
			end
			-- shield_block,if=buff.shield_block.duration<=10
			if pressshieldblock and targetRange8 then
			return S.ShieldBlock:Cast()
			end

			if AoE() ~= nil and inRange8>1 and RubimRH.AoEON() then
			return AoE()
			end
			

			--actions+=/call_action_list,name=generators
			if Generic() ~= nil then
			return Generic()
			end
			

		end
		--------------------------------------------------------------------------------------------------------------------------------------------
		----------------------------------------------------------Out of Combat---------------------------------------------------------------------
		--------------------------------------------------------------------------------------------------------------------------------------------

	if not Player:AffectingCombat() then

			if S.BattleShout:IsCastable() and Player:BuffDown(S.BattleShoutBuff) then
			return S.BattleShout:Cast()
			end



	return 0, "Interface\\Addons\\Rubim-RH\\Media\\griph.tga"
	end







return 0, 135328
end

RubimRH.Rotation.SetAPL(73, APL);












