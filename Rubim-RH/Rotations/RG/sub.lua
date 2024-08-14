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

if not Spell.Rogue then
    Spell.Rogue = {};
end

RubimRH.Spell[261] = {
	EchoingReprimand = Spell(323547),
	EchoingReprimandCP2 = Spell(323558),
	EchoingReprimandCP3 = Spell(323559),
	EchoingReprimandCP4 = Spell(323560),
	NumbingPoison = Spell(5761),
	BlackPowder = Spell(319175),
	SilentStorm = Spell(385727),
	ColdBlood = Spell(382245),
	ShadowBlades = Spell(121471),
	Shadowstrike = Spell(185438),
	Backstab = Spell(53),
	Rupture = Spell(1943),
	ShadowDance = Spell(185313),
	ShurikenToss = Spell(114014),
	ShurikenStorm = Spell(197835),
	SymbolsofDeath = Spell(212283),
	ShurikenTornado = Spell(277925),
	SecretTechnique = Spell(280719),
	Eviscerate = Spell(196819),
	PerforatedVeins = Spell(394254),
	Nightstalker = Spell(14062),
	DarkShadow = Spell(245687),
	ShadowDanceBuff = Spell(185422),
	WoundPoison = Spell(8679),
	CripplingPoison = Spell(3408),
	InstantPoison = Spell(315584),
	AtrophicPoison = Spell(381637),
	KidneyShot = Spell(408),
	Gloomblade = Spell(200758),
    FinalityRupture = Spell(385951),
	Distract = Spell(1725),
	LingeringShadow = Spell(382524),
	LingeringShadowBuff = Spell(385960),
    SealFate = Spell(14190),
    DanseMacabre = Spell(382528),
	DanseMacabreBuff = Spell(393969),
	TheRotton = Spell(382015),
	FindWeakness = Spell(316220),
    DeeperStratagem = Spell(193531),
    Stealth = Spell(1784),
    ThistleTea = Spell(381623),
    Vanish = Spell(1856),
    PremeditationBuff = Spell(343173),
    MasterofShadows = Spell(196976),
    ShadowFocus = Spell(108209),
    VanishBuff = Spell(11327),
    Shiv = Spell(5938),
    autoattack = Spell(274738), -- ancestral call
    ImprovedShurikenStorm = Spell(319951),
    Gouge = Spell(1776),
    WilloftheForsaken = Spell(7744),
    CloakofShadows = Spell(31224),
    DarkBrew = Spell(382504),
    SecretStratagem = Spell(394320),
    GhostlyStrike = Spell(196937),
    MarkedforDeath = Spell(137619),
    SliceandDice = Spell(315496),
    Vigor = Spell(14983),
	Blind = Spell(2094),
	Alacrity = Spell(193539),
	CheapShot = Spell(1833),
	Premeditation = Spell(343160),
    CrimsonVial = Spell(185311),
    Feint = Spell(1966),
    Kick = Spell(1766),
    Sprint = Spell(2983),
	Evasion = Spell(5277),
	Flagellation = Spell(384631),
	SubterfugeBuff = Spell(115192),
	Healthstonez = Spell(260364), --arcane pulse
}

local S = RubimRH.Spell[261] 

if not Item.Rogue then Item.Rogue = {}; end

Item.Rogue.Sub = {
    trink = Item(184016, { 13, 14 }),
    drums = Item(193470),
    HPIcon = Item(169451),
    brez_wrist = Item(198327),
    tx1 = Item(118330),
    tx2 = Item(114616),
	--Healthstone = Item(5512),
};

local I = Item.Rogue.Sub;

local function num(val)
    if val then
        return 1
    else
        return 0
    end
end

local function CPMaxSpend()
	if S.DeeperStratagem:IsAvailable() and S.SecretStratagem:IsAvailable() then	
		return 7
    elseif S.DeeperStratagem:IsAvailable() and not S.SecretStratagem:IsAvailable() or not S.DeeperStratagem:IsAvailable() and S.SecretStratagem:IsAvailable() then
		return 6
    else
		return 5
    end
end

local function EnergyTimeToMaxRounded()
    return math.floor(Player:EnergyTimeToMaxPredicted() * 10 + 0.5) / 10;
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

local function TargetTTD()
	local currHealth = {}
	local currHealthMax = {}
	local allGUID = {}
	local areaTTD = {}
	local areaTTD_Predicted = {}
	local areaDPS = {}
	local count = 1
	local highest = 0

    for id = 1, 40 do
        local unitID = "nameplate" .. id
        if UnitCanAttack("player", unitID) 
        and ((UnitHealth(unitID) / UnitHealthMax(unitID)) * 100) < 100 then
            if UnitGUID('Target') then
                currTarget = UnitGUID('Target')
            end
			
            table.insert(allGUID, UnitGUID(unitID))
            table.insert(currHealth, UnitHealth(unitID))
            table.insert(currHealthMax, UnitHealthMax(unitID))
			
			if #allGUID >= 1 and UnitGUID('Target') then 
				while(UnitGUID('Target') ~= allGUID[count]) do
					count = count + 1
					break
				end
			end
			
            if #currHealthMax >= 1 then
                for id = 1, #currHealthMax do
				dps = (currHealthMax[#currHealth] - currHealth[#currHealth]) / HL.CombatTime("nameplate" .. #currHealthMax)
					if #currHealthMax ~= count then
						areaTTD[#currHealthMax] = currHealth[#currHealth] / dps
						--areaTTD_Predicted[#currHealthMax] = currHealth[#currHealth] / (dps + playerDPS)
					else
						areaTTD_Predicted[#currHealthMax] = currHealth[#currHealth] / dps
					end
                end
            end
        end
    end

	if target_is_dummy() then
		return 8675309
	elseif #currHealthMax >= 1 then
		return areaTTD_Predicted[count]
	else
		return 1
	end
end

local function Build()
	if S.ShurikenStorm:IsCastable() and Cache.EnemiesCount[12] >= 2 + num(S.Gloomblade:IsAvailable() and Player:BuffRemainsP(S.LingeringShadowBuff) >= 4 or Player:BuffP(S.PerforatedVeins)) then
		return S.ShurikenStorm:Cast()
	end

	if S.Gloomblade:IsReady(8) then
		return S.Gloomblade:Cast()
	end
	
	return nil
end

local function CDS()
local trinket1 = GetInventoryItemID("player", 13)
local trinket2 = GetInventoryItemID("player", 14)
local trinket1ready = IsUsableItem(trinket1) and GetItemCooldown(trinket1) == 0 and IsEquippedItem(trinket1)
local trinket2ready = IsUsableItem(trinket2) and GetItemCooldown(trinket2) == 0 and IsEquippedItem(trinket2)

	if S.ShadowDance:IsReady(8) and Player:GCDRemains() < 0.5 and not Player:BuffP(S.ShadowDanceBuff) and Player:BuffP(S.ShurikenTornado) then
		return S.ShadowDance:Cast()
	end

	if S.SymbolsofDeath:IsReady(8) and Player:GCDRemains() < 0.5 and Player:BuffP(S.ShurikenTornado) then
		return S.SymbolsofDeath:Cast()
	end

	if S.Vanish:IsReady(8) and Cache.EnemiesCount[12] < 7 and Player:Energy() >= 40 and Player:GCDRemains() < 0.5 and Player:BuffStack(S.DanseMacabreBuff) > 3 and Player:ComboPoints() <= 2 and (S.SecretTechnique:CooldownRemainsP() >= 30 or not S.SecretTechnique:IsAvailable()) then
		return S.Vanish:Cast()
	end
	
	if S.SymbolsofDeath:IsReady(8) and rotten_condition and snd_condition and (not S.Flagellation:IsAvailable() and (Player:ComboPoints() <= 1 or not S.TheRotton:IsAvailable()) or S.Flagellation:CooldownRemainsP() > 10 or (S.Flagellation:IsAvailable() and S.Flagellation:CooldownUp()) and Player:ComboPoints() >= 5) then
		return S.SymbolsofDeath:Cast()
	end
	
	if S.ShadowBlades:IsReady(8) and snd_condition and Player:ComboPointsDeficit() >= 2 then
		return S.ShadowBlades:Cast()
	end
	
	if S.ShurikenTornado:IsReady(8) and snd_condition and Player:BuffP(S.SymbolsofDeath) and Player:ComboPoints() <= 2 and (not Player:BuffP(S.PremeditationBuff) or Cache.EnemiesCount[12] > 4) then
		return S.ShurikenTornado:Cast()
	end

	if S.ShurikenTornado:IsReady(8) and S.ShadowDance:CooldownUp() and not stealthed_all and Cache.EnemiesCount[12] >= 3 and not S.Flagellation:IsAvailable() then
		return S.ShurikenTornado:Cast()
	end
	
	if S.ThistleTea:IsCastable() and (S.SymbolsofDeath:CooldownRemainsP() >= 3 and not Player:BuffP(S.ThistleTea) and (Player:EnergyDeficit() >= 100 and (Player:ComboPointsDeficit() >= 2 or Cache.EnemiesCount[12] >= 3) or S.ThistleTea:ChargesFractional() >= 2.75 and Player:BuffP(S.ShadowDanceBuff)) or Player:BuffRemainsP(S.ShadowDanceBuff) >= 4 and not Player:BuffP(S.ThistleTea) and Cache.EnemiesCount[12] >= 3) then
		return S.ThistleTea:Cast()
	end
	
	if trinket1ready and Cache.EnemiesCount[8] >= 1 and (Player:BuffP(S.SymbolsofDeath) or S.SymbolsofDeath:CooldownRemainsP() >= 8) then
		return I.tx1:Cast()
	end
	
	return nil
end

local function Finish()
	if S.SliceandDice:IsCastable() and not premed_snd_condition and Cache.EnemiesCount[12] < 6 and not Player:BuffP(S.ShadowDanceBuff) and Player:BuffRemainsP(S.SliceandDice) < 12.6 then
		return S.SliceandDice:Cast()
	end
	
	if S.SliceandDice:IsCastable() and premed_snd_condition and S.ShadowDance:ChargesFractional() < 1.75 and Player:BuffRemainsP(S.SliceandDice) < S.SymbolsofDeath:CooldownRemainsP() and (S.ShadowDance:CooldownUp() and Player:BuffRemainsP(S.SymbolsofDeath) - Player:BuffRemainsP(S.ShadowDanceBuff) < 1.2) then
		return S.SliceandDice:Cast()
	end
	
	if S.Rupture:IsReady(8) and not skip_rupture and TargetTTD() and TargetTTD() - Target:DebuffRemainsP(S.Rupture) > 6 and Target:DebuffRemainsP(S.Rupture) < 8.4 then
		return S.Rupture:Cast()
	end
	
	if S.Rupture:IsReady(8) and not skip_rupture and Player:BuffP(S.FinalityRupture) and S.ShadowDance:CooldownRemainsP() < 12 and S.ShadowDance:ChargesFractional() <= 1 and Cache.EnemiesCount[12] == 1 and (S.DarkBrew:IsAvailable() or S.DanseMacabre:IsAvailable()) then
		return S.Rupture:Cast()
	end
	
	if S.ColdBlood:IsReady(5) and not Player:BuffP(S.ColdBlood) and secret_condition and S.SecretTechnique:CooldownUp() then
		return S.ColdBlood:Cast()
	end
	
	if S.SecretTechnique:IsReady(8) and secret_condition and (not S.ColdBlood:IsAvailable() or Player:BuffP(S.ColdBlood) or S.ColdBlood:CooldownRemainsP() > Player:BuffRemainsP(S.ShadowDanceBuff) - 2) then
		return S.SecretTechnique:Cast()
	end

	if S.Rupture:IsReady(8) and not skip_rupture and Target:DebuffRemainsP(S.Rupture) < S.SymbolsofDeath:CooldownRemainsP() + 10 and S.SymbolsofDeath:CooldownRemainsP() <= 5 and TargetTTD() and TargetTTD() - Target:DebuffRemainsP(S.Rupture) > S.SymbolsofDeath:CooldownRemainsP() + 5 then
		return S.Rupture:Cast()
	end
	
	if S.BlackPowder:IsCastable() and Cache.EnemiesCount[12] >= 3 or not bp_used_for_danse and Player:BuffP(S.ShadowDanceBuff) and Cache.EnemiesCount[12] == 2 and S.DanseMacabre:IsAvailable() then
		return S.BlackPowder:Cast()
	end
	
	if S.Eviscerate:IsReady(8) then
		return S.Eviscerate:Cast()
	end
	
	return nil
end

local function Stealth_CDS()
	if S.Vanish:IsReady(8) and (not S.DanseMacabre:IsAvailable() or Cache.EnemiesCount[12] >= 3) and not shd_threshold and Player:ComboPointsDeficit() > 1 then
		return S.Vanish:Cast()
	end
	
	if S.ShadowDance:IsReady(8) and Player:GCDRemains() < 0.5 and (shd_combo_points and (Player:BuffRemainsP(S.SymbolsofDeath) >= (2.2 - num(S.Flagellation:IsAvailable())) or shd_threshold) or S.ShadowDance:MaxCharges() == 2 and S.SecretTechnique:CooldownRemainsP() <= 9 and (Cache.EnemiesCount[12] <= 3 or S.DanseMacabre:IsAvailable()) or Target:DebuffP(S.Flagellation) or Cache.EnemiesCount[12] >= 4 and S.SymbolsofDeath:CooldownRemainsP() > 10) and rotten_threshold then
		return S.ShadowDance:Cast()
	end

	return nil
end

local function Stealthed()
	if S.Shadowstrike:IsReady(8) and Player:BuffP(S.VanishBuff) and Cache.EnemiesCount[12] < 7 then
		return S.Shadowstrike:Cast()
	end

	if S.ShurikenStorm:IsCastable() and gloomblade_condition and Player:BuffP(S.SilentStorm) and not Target:DebuffP(S.FindWeakness) and S.ImprovedShurikenStorm:IsAvailable() or Player:ComboPoints() <= 1 and not shuriken_storm_used_for_danse and Cache.EnemiesCount[12] == 2 and S.DanseMacabre:IsAvailable() then
		return S.ShurikenStorm:Cast()
	end

	if S.Gloomblade:IsReady(8) and gloomblade_condition and (not gloomblade_used_for_danse or Cache.EnemiesCount[12] ~= 2) then
		return S.Gloomblade:Cast()
	end
	
	if Finish() and Player:ComboPoints() >= CPMaxSpend() then
		return Finish()
	end

	if Finish() and Player:BuffP(S.ShurikenTornado) and Player:ComboPointsDeficit() <= 2 then
		return Finish()
	end
	
	if Finish() and Cache.EnemiesCount[12] >= 4 - num(S.SealFate:IsAvailable()) and Player:ComboPoints() >= 4 then
		return Finish()
	end
	
	if Finish() and Player:ComboPointsDeficit() <= 1 + (num(S.SealFate:IsAvailable() or S.DeeperStratagem:IsAvailable() or S.SecretStratagem:IsAvailable())) then
		return Finish()
	end
	
	if S.ShurikenStorm:IsCastable() and Cache.EnemiesCount[12] >= 3 + num(Player:BuffP(S.TheRotton)) and (not Player:BuffP(S.PremeditationBuff) or Cache.EnemiesCount[12] >= 7) then
		return S.ShurikenStorm:Cast()
	end

	if S.Shadowstrike:IsReady(8) then
		return S.Shadowstrike:Cast()
	end
	
	return nil
end

local function Stun()
	local channeling = select(1,UnitChannelInfo('target'))
	local casting = select(1, UnitCastingInfo('target'))

    --Abilities that should be stunned
    local stun_spells = {
	'Mystic Blast', 'Monotonous Lecture', 'Arcane Missiles', 'Astral Bomb', 'Healing Touch',
	'Astral Whirlwind', --AA
	'Sound Alarm', 'Eye Storm',
	'Hypnosis',         --CoS
	'Holy Radiance',  'Etch', --HoV
	'Lightning Bolt', 'Flashfire', 'Tectonic Slam', 'Ice Shield',
	'Cinderbolt',       --RLP
	'Shadow Mend', 'Shadow Bolts', 'Domination', 'Rending Voidlash', 'Death Blast', 'Plague Spit',
	'Cry of Anguish',   --SMBG
	'Tidal Burst', 'Haunting Gaze', 'Haunting Scream', 'Cat Nap', 'Defiling Mist',
	'Leg Sweep',        --TotJS
	'Mystic Vapors', 'Shriek', 'Piercing Shards', 'Waking Bane', 'Icy Bindings', 'Illusionary Bolt',
	'Null Stomp',       --AV
	'Rally the Clan', 'Tempest', 'Stormbolt', 'Grasp of the Dead', 'Dominate', 'Storm Shock', 'Bloodcurdling Shout',
	'Storm Bolt',
	'Desacrating Blow', --NO
    }

	for i = 1, #stun_spells do
		if casting == stun_spells[i] or channeling == stun_spells[i] then
			return true
		elseif casting and Target:IsAPlayer() then
			return true
		end
	end

	return false
end

local function Blind()
	local channeling = select(1,UnitChannelInfo('target'))
	local casting = select(1, UnitCastingInfo('target'))

    --Abilities that should be blinded
    local blind_spells = {
	'Mystic Blast', 'Monotonous Lecture', 'Arcane Missiles', 'Astral Bomb', 'Healing Touch',
	'Astral Whirlwind', --AA
	'Sound Alarm', 'Eye Storm',
	'Hypnosis',         --CoS
	'Holy Radiance', 'Etch',          --HoV
	'Lightning Bolt', 'Flashfire', 'Tectonic Slam', 'Cold Claws', 'Ice Shield',
	'Cinderbolt',       --RLP
	'Shadow Mend', 'Shadow Bolts', 'Domination', 'Rending Voidlash', 'Death Blast', 'Plague Spit',
	'Cry of Anguish',   --SMBG
	'Tidal Burst', 'Haunting Gaze', 'Haunting Scream', 'Cat Nap', 'Defiling Mist',
	'Leg Sweep',        --TotJS
	'Mystic Vapors', 'Shriek', 'Piercing Shards', 'Waking Bane', 'Icy Bindings', 'Illusionary Bolt',
	'Null Stomp',       --AV
	'Rally the Clan', 'Tempest', 'Stormbolt', 'Grasp of the Dead', 'Dominate', 'Storm Shock', 'Bloodcurdling Shout',
	'Storm Bolt',
	'Desacrating Blow', --NO
    } 
    
    for i = 1, #blind_spells do
		if casting == blind_spells[i] or channeling == blind_spells[i] then
			return true
		elseif casting and Target:IsAPlayer() then
			return true
		end
    end
    
	return false
end

local function Kick()
	local channeling = select(1,UnitChannelInfo('target'))
	local casting = select(1, UnitCastingInfo('target'))
	
    --Abilities that should be kicked
    local kick_spells = {
	'Mystic Blast', 'Monotonous Lecture', 'Arcane Missiles', 'Astral Bomb',
	'Healing Touch',    --AA
	'Suppress',
	'Drifting Embers', 'Bewitch', --CoS
	'Thunderous Bolt', 'Holy Radiance', 'Cleansing Flames', 'Unruly Yell', 'Rune of Healing', 'Etch',
	'Surge',            --HoV
	'Roaring Blaze', 'Lightning Bolt', 'Flashfire',
	'Cinderbolt',       --RLP
	'Shadow Mend', 'Shadow Bolts', 'Domination', 'Rending Voidlash', 'Void Bolt', 'Death Blast', 'Necrotic Burst',
	'Plague Spit',      --SMBG
	'Tidal Burst', 'Haunting Gaze', 'Haunting Scream', 'Cat Nap',
	'Defiling Mist',    --TotJS
	'Erratic Growth', 'Mystic Vapors', 'Heavy Tome', 'Waking Bane', 'Icy Bindings',
	'Illusionary Bolt', --AV
	'Disruptive Shout', 'Tempest', 'Stormbolt', 'Death Bolt Volley', 'Dominate', 'Storm Shock',
	'Bloodcurdling Shout', 'Storm Bolt', 'Thunderstrike',
	'Desacrating Blow', --NO
    }

	for i = 1, #kick_spells do
		if casting == kick_spells[i] or channeling == kick_spells[i] then
			return true
		elseif casting and Target:IsAPlayer() then
			return true
		end
	end

	return false
end

local function APL()
Stun()
Blind()
Kick()
target_is_dummy()
TargetTTD()
HL.GetEnemies(5);
HL.GetEnemies(8);
HL.GetEnemies(12);
HL.GetEnemies(20);
HL.GetEnemies(25);
HL.GetEnemies(30);
HL.GetEnemies(40);
--------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------Functions/Top priorities----------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
if Player:IsCasting() or Player:IsChanneling() then
	return 0, "Interface\\Addons\\Rubim-RH\\Media\\channel.tga"
elseif Player:IsDeadOrGhost() or AuraUtil.FindAuraByName("Drink", "player") or AuraUtil.FindAuraByName("Food", "player") or AuraUtil.FindAuraByName("Food & Drink", "player") or AuraUtil.FindAuraByName("Shroud of Concealment", "player") then
    return 0, "Interface\\Addons\\Rubim-RH\\Media\\mount2.tga"
end

local healthstone_usabale,_ = IsUsableSpell(6262);

local start, duration, enabled = GetSpellCooldown(6262);
local healthstone_cooldown = duration - (GetTime() - start)

if healthstone_cooldown < 0 then 
	healthstone_cooldown = 0
end

if UnitClassification("target") == "worldboss" or UnitClassification("target") == "rareelite" or UnitClassification("target") == "elite"
or UnitClassification("target") == "rare" or target_is_dummy() or Target:IsAPlayer() then
	elite = true
else
	elite = false
end

local start_time_cast_ms = select(4, UnitCastingInfo('target')) or 0
local end_time_cast_ms = select(5, UnitCastingInfo('target')) or 0
local current_time_ms = GetTime() * 1000
local elapsed_time_cast_ca = (start_time_cast_ms > 0) and (current_time_ms - start_time_cast_ms) or 0
local cast_time = elapsed_time_cast_ca / 1000
local cast_time_remaining = ((end_time_cast_ms - start_time_cast_ms) / 1000) - cast_time > 0 and ((end_time_cast_ms - start_time_cast_ms) / 1000) - cast_time or 9999
local start_time_channel_ms = select(4, UnitChannelInfo('target')) or 0
local end_time_channel_ms = select(5, UnitChannelInfo('target')) or 0
local elapsed_time_channel_ch = (start_time_channel_ms > 0) and (current_time_ms - start_time_channel_ms) or 0
local channel_time = elapsed_time_channel_ch / 1000
local channel_time_remaining = ((end_time_channel_ms - start_time_channel_ms) / 1000) - channel_time > 0 and ((end_time_channel_ms - start_time_channel_ms) / 1000) - channel_time or 9999

if true then
	rotten_condition = not Player:BuffP(S.PremeditationBuff) and Cache.EnemiesCount[12] == 1 or not S.TheRotton:IsAvailable() or Cache.EnemiesCount[12] > 1
	
	snd_condition = Player:BuffP(S.SliceandDice) or Cache.EnemiesCount[12] >= CPMaxSpend()
	
	stealthed_all = Player:BuffP(S.VanishBuff) or Player:BuffP(S.ShadowDanceBuff) or Player:BuffP(S.SubterfugeBuff)
	
	secret_condition = (RubimRH.CDsON() or Player:BuffP(S.ShadowDanceBuff)) and (Player:BuffP(S.ShadowDanceBuff) and (Player:BuffStack(S.DanseMacabreBuff) >= 3 or not S.DanseMacabre:IsAvailable()) and (not Player:BuffP(S.PremeditationBuff) or Cache.EnemiesCount[12] ~= 2))

	premed_snd_condition = S.Premeditation:IsAvailable() and Cache.EnemiesCount[12] < 5
	
	skip_rupture = TargetTTD() and TargetTTD() < 12 or not elite or UnitName('target') == 'Spiteful Shade' or (Player:BuffP(S.ThistleTea) and Cache.EnemiesCount[12] == 1 or Player:BuffP(S.ShadowDanceBuff) and (Cache.EnemiesCount[12] == 1 or (Target:DebuffP(S.Rupture) and Cache.EnemiesCount[12] >= 2) or rupture_used_for_danse or (Player:BuffRemainsP(S.ShadowDanceBuff) < Player:GCD() + 2 and S.SecretTechnique:CooldownUp()) or Player:BuffRemainsP(S.ShadowDanceBuff) <= Player:GCD() * 1.15))

	bp_used_for_danse = Player:BuffP(S.ShadowDanceBuff) and S.BlackPowder:TimeSinceLastCast() < S.ShadowDance:TimeSinceLastCast()

	gloomblade_used_for_danse = Player:BuffP(S.ShadowDanceBuff) and S.Gloomblade:TimeSinceLastCast() < S.ShadowDance:TimeSinceLastCast()
	
	rupture_used_for_danse = Player:BuffP(S.ShadowDanceBuff) and S.Rupture:TimeSinceLastCast() < S.ShadowDance:TimeSinceLastCast()
	
	shuriken_storm_used_for_danse = Player:BuffP(S.ShadowDanceBuff) and S.ShurikenStorm:TimeSinceLastCast() < S.ShadowDance:TimeSinceLastCast()
	--shd_threshold = S.ShadowDance:ChargesFractional() >= 0.75 + num(S.ShadowDance:MaxCharges() == 2) <- Not taking talent, so left out
	shd_threshold = S.ShadowDance:ChargesFractional() and S.ShadowDance:ChargesFractional() >= 0.75 + num(S.ShadowDance:MaxCharges() == 2)
	
	rotten_threshold = not Player:BuffP(S.TheRotton) or Cache.EnemiesCount[12] > 1

	--Use stealth cooldowns on any combo point on 3 or 4 targets
	if Cache.EnemiesCount[12] == (4 - num(S.SealFate:IsAvailable())) then
		shd_combo_points = true
	--Use stealth cooldowns with high combo points when playing shuriken tornado or with high target counts
	elseif Cache.EnemiesCount[12] > (4 - 2 * num(S.ShurikenTornado:IsAvailable())) then
		shd_combo_points = Player:ComboPointsDeficit() <= 1
	else
	--CP thresholds for entering Shadow Dance Default to start dance with 0 or 1 combo point
		shd_combo_points = Player:ComboPoints() <= 1
	end
	
	gloomblade_condition = Player:BuffStack(S.DanseMacabreBuff) < 5 and (Player:ComboPointsDeficit() == 2 or Player:ComboPointsDeficit() == 3) and (Player:BuffP(S.PremeditationBuff) or Player:ComboPoints() < 7) and (Cache.EnemiesCount[12] <= 8 or S.LingeringShadow:IsAvailable())

	stealth_threshold = 25 + num(S.Vigor:IsAvailable()) * 20 + num(S.MasterofShadows:IsAvailable()) * 20 + num(S.ShadowFocus:IsAvailable()) * 25 + num(S.Alacrity:IsAvailable()) * 20 + 25 * (num(Cache.EnemiesCount[12] >= 4))
	
	tolerance = select(4, GetNetStats())/1000 + 0.3
end
--------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------Out of Combat---------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
if not Player:AffectingCombat() and not Player:BuffP(S.VanishBuff) then
    if S.Stealth:IsCastable() and not Player:BuffP(S.ShadowDanceBuff) and not Player:Buff(S.Stealth) and (IsResting("player") == false or Player:CanAttack(Target)) then
        return S.Stealth:Cast()
    end

    if S.CrimsonVial:IsCastable() and Cache.EnemiesCount[25] == 0 and Player:HealthPercentage() < 100 and Player:EnergyDeficit() == 0 then
        return S.CrimsonVial:Cast()
    end

    if S.InstantPoison:IsCastable() and not Player:Buff(S.WoundPoison) and Player:BuffRemainsP(S.InstantPoison) < 300 and not Player:IsCasting(S.InstantPoison) and not Player:IsMoving() then
        return S.InstantPoison:Cast()
    end

    if S.CripplingPoison:IsCastable() and ((not S.NumbingPoison:IsAvailable() and not S.AtrophicPoison:IsAvailable()) or Player:BuffP(S.CripplingPoison)) and not Player:BuffP(S.NumbingPoison) and not Player:BuffP(S.AtrophicPoison) and Player:BuffRemainsP(S.CripplingPoison) < 300 and not Player:IsCasting(S.CripplingPoison) and not Player:IsMoving() then
        return S.CripplingPoison:Cast()
    end
	
	if not Player:BuffP(S.CripplingPoison) then
		if S.AtrophicPoison:IsCastable() and Player:BuffRemainsP(S.AtrophicPoison) < 300 and not Player:IsCasting(S.AtrophicPoison) and not Player:IsMoving() then
			return S.AtrophicPoison:Cast()
		end
		
		if S.NumbingPoison:IsCastable() and Player:BuffRemainsP(S.NumbingPoison) < 300 and not Player:IsCasting(S.NumbingPoison) and not Player:IsMoving() then
			return S.NumbingPoison:Cast()
		end
	end

    if IsResting("player") == false 
	and ((Player:ComboPoints() == 1 and (Player:BuffRemainsP(S.SliceandDice) < 9 or not Player:BuffP(S.SliceandDice)))
	or (Player:ComboPoints() == 2 and (Player:BuffRemainsP(S.SliceandDice) < 14 or not Player:BuffP(S.SliceandDice)))
	or (Player:ComboPoints() == 3 and (Player:BuffRemainsP(S.SliceandDice) < 18 or not Player:BuffP(S.SliceandDice)))
	or (Player:ComboPoints() == 4 and (Player:BuffRemainsP(S.SliceandDice) < 23 or not Player:BuffP(S.SliceandDice)))
	or (Player:ComboPoints() == 5 and (Player:BuffRemainsP(S.SliceandDice) < 27 or not Player:BuffP(S.SliceandDice)))
	or (Player:ComboPoints() == 6 and (Player:BuffRemainsP(S.SliceandDice) < 32 or not Player:BuffP(S.SliceandDice)))
	or (Player:ComboPoints() == 7 and (Player:BuffRemainsP(S.SliceandDice) < 36 or not Player:BuffP(S.SliceandDice)))) then
		if S.SliceandDice:IsCastable() and Cache.EnemiesCount[40] >= 1 and Cache.EnemiesCount[12] == 0 then
            return S.SliceandDice:Cast()
        end
    end
end

if AuraUtil.FindAuraByName("Stealth", "player") and not Player:BuffP(S.VanishBuff) then
    return 0, "Interface\\Addons\\Rubim-RH\\Media\\mount2.tga"
end
--------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------Spell Queue-----------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
if not RubimRH.queuedSpell[1]:CooldownUp() or not Player:AffectingCombat() or Player:BuffP(S.VanishBuff) then
    RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
end

if S.ShurikenToss:ID() == RubimRH.queuedSpell[1]:ID() and (not Target:IsInRange(30) or Player:PrevGCD(1, S.ShurikenToss)) then
    RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
end

if S.KidneyShot:ID() == RubimRH.queuedSpell[1]:ID() and (Target:Debuff(S.CheapShot) or Target:Debuff(S.KidneyShot) or Target:Debuff(S.Blind) or Target:Debuff(S.Gouge) or Player:ComboPoints() == 0 or Player:Energy() < 15) then
    RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
end

if S.Gouge:ID() == RubimRH.queuedSpell[1]:ID() and (Target:Debuff(S.CheapShot) or Target:Debuff(S.KidneyShot) or Target:Debuff(S.Blind)) then
    RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
end

if RubimRH.QueuedSpell():IsReadyQueue() then
    return RubimRH.QueuedSpell():Cast()
end
--------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------Interrupts & Tranq-----------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
if RubimRH.InterruptsON() and Player:AffectingCombat() or Player:BuffP(S.VanishBuff) then
	--if ((cast_time > 0 and cast_time_remaining > tolerance) or (channel_time > 0 and channel_time_remaining > tolerance)) and ((cast_time > 0 and cast_time_remaining > TargetTTD()) or (channel_time > 0 and channel_time_remaining > TargetTTD())) then
	if (cast_time > 0 and cast_time_remaining > tolerance) or (channel_time > 0 and channel_time_remaining > tolerance) then	
		if S.Kick:IsReady(8) and Kick() and (cast_time > Player:GCDRemains() + 0.47 or channel_time > Player:GCDRemains() + 0.47) then
			return S.Kick:Cast()
		end

		if not Player:BuffP(S.ShadowDanceBuff) or ((cast_time_remaining < Player:BuffRemainsP(S.ShadowDanceBuff) or channel_time_remaining < Player:BuffRemainsP(S.ShadowDanceBuff)) and ((not S.SecretTechnique:CooldownUp() or not S.SecretTechnique:IsAvailable()) or (Player:BuffRemainsP(S.ShadowDanceBuff) > Player:GCD() + 2 and (cast_time_remaining < Player:GCD() + tolerance or channel_time_remaining < Player:GCD() + tolerance)))) then
			if S.KidneyShot:IsReady(8) and Stun() and (cast_time > Player:GCDRemains() + 0.47 or channel_time > Player:GCDRemains() + 0.47) then
				return S.KidneyShot:Cast()
			end

			if S.Blind:IsReady(15) and Blind() and (cast_time > Player:GCDRemains() + 0.47 or channel_time > Player:GCDRemains() + 0.47) then
				return S.Blind:Cast()
			end

			if Stun() and (cast_time > Player:GCDRemains() + 0.47 or channel_time > Player:GCDRemains() + 0.47) then
				if S.CheapShot:IsReady(8) and (Player:BuffP(S.ShadowDanceBuff) or Player:BuffP(S.VanishBuff)) then
					return S.CheapShot:Cast()
				elseif S.Vanish:IsReady(8) and not Player:BuffP(S.ShadowDanceBuff) and not Player:BuffP(S.VanishBuff) and Player:Energy() >= 40 and Player:GCDRemains() < 0.5 then
					return S.Vanish:Cast()
				end
			end
		end
	end
	
	if not Player:BuffP(S.ShadowDanceBuff) or not S.SecretTechnique:CooldownUp() or not S.SecretTechnique:IsAvailable() then
		if S.Shiv:IsReady(8) and select(4, UnitAura("target", 1)) == "" then
			return S.Shiv:Cast()
		end
	end
	
	-- if S.Kick:IsReady(8) and select(8, UnitCastingInfo("target")) == false and Target:CastPercentage() > math.random(27, 90) and RubimRH.InterruptsON() and Player:AffectingCombat() then
		-- return S.Kick:Cast()
	-- end
end
--------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------Cooldowns-------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
if Player:HealthPercentage() <= 45 and Player:AffectingCombat() and healthstone_usabale and healthstone_cooldown == 0 and GetItemCount(5512) >= 1 then
	return S.Healthstonez:Cast()
end

if Player:HealthPercentage() <= 25 and Player:AffectingCombat() and (IsUsableItem(191379) or IsUsableItem(191378) or IsUsableItem(191380)) and (GetItemCooldown(191380) == 0 or GetItemCooldown(191379) == 0 or GetItemCooldown(191378) == 0) and (GetItemCount(191380) >= 1 or GetItemCount(191379) >= 1 or GetItemCount(191378) >= 1) and (not Player:InArena() and not Player:InBattlegrounds()) then
	return I.HPIcon:Cast()
end
--------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------Rotation--------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
if Player:CanAttack(Target) and Player:AffectingCombat() or (Player:BuffP(S.VanishBuff) and Target:IsInRange(8)) then
	if not IsCurrentSpell(6603) and not Player:BuffP(S.Stealth) and not Player:Buff(S.VanishBuff) and Target:IsInRange(8) then
		return S.autoattack:Cast()
	end

	if CDS() and RubimRH.CDsON() then
		return CDS()
	end
	
    if S.SliceandDice:IsCastable() and Cache.EnemiesCount[12] < CPMaxSpend() and Player:BuffRemainsP(S.SliceandDice) < Player:GCD() and Player:ComboPoints() >= 4 then
        return S.SliceandDice:Cast()
    end
	
	if Stealthed() and stealthed_all then
		return Stealthed()
	end
	
	if Stealth_CDS() and Player:EnergyDeficit() <= stealth_threshold and RubimRH.CDsON() then
		return Stealth_CDS()
	end

	if Finish() and Player:ComboPoints() >= CPMaxSpend() then
		return Finish()
	end

	if Finish() and Player:ComboPointsDeficit() <= 1 + num(Player:BuffP(S.TheRotton)) then
		return Finish()
	end

	if Cache.EnemiesCount[12] >= (4 - num(S.SealFate:IsAvailable())) and Player:ComboPoints() >= 4 then
		return Finish()
	end

	if Build() and Player:EnergyDeficit() <= stealth_threshold then
		return Build()
	end
end
    return 0, "Interface\\Addons\\Rubim-RH\\Media\\mount2.tga"
end

RubimRH.Rotation.SetAPL(261, APL);

local function PASSIVE()
    
end

RubimRH.Rotation.SetPASSIVE(261, PASSIVE);