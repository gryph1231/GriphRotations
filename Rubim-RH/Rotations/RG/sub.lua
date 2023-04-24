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
	trink2z = Spell(260364), --arcane pulse
	EchoingReprimand = Spell(323547),
	EchoingReprimandz = Spell(265221), --fireblood
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
	stopcasting = Spell(291944), --regeneratin
	WoundPoison = Spell(8679),
	CripplingPoison = Spell(3408),
	InstantPoison = Spell(315584),
	AtrophicPoison = Spell(381637),
	KidneyShot = Spell(408),
    Berserking = Spell(26297),
	Gloomblade = Spell(200758),
    FinalityRupture = Spell(385951),
	Distract = Spell(1725),
	LingeringShadow = Spell(385960),
    SealFate = Spell(14190),
    DanseMacabre = Spell(393969),
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
	Exhaustion = Spell(57723),
	Blind = Spell(2094),
	Alacrity = Spell(193539),
    CurseoftheDreadblades = Spell(202665),
	CheapShot = Spell(1833),
	Premeditation = Spell(343160),
    CrimsonVial = Spell(185311),
    Feint = Spell(1966),
    Kick = Spell(1766),
    Sprint = Spell(2983),
	Evasion = Spell(5277),
	Flagellation = Spell(384631),
	CrimsonVialz = Spell(26297), --berserking
	SubterfugeBuff = Spell(115192),
}

local S = RubimRH.Spell[261] 

if not Item.Rogue then Item.Rogue = {}; end

Item.Rogue.Sub = {
    trink = Item(184016, { 13, 14 }),
    drums = Item(193470),
    HPIcon = Item(169451),
    tx1 = Item(118330),
    tx2 = Item(114616),
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
        if UnitCanAttack("player", unitID) and UnitAffectingCombat(unitID) 
        and ((UnitHealth(unitID) / UnitHealthMax(unitID)) * 100) < 100 then
            if UnitGUID('Target') and UnitAffectingCombat('Target') then
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

	if #currHealthMax >= 1 then
		return areaTTD_Predicted[count]
	else
		return nil
	end
end

-- local function ClosestRupture()
-- local ruptures_applied = 0
-- local closest_target = nil
-- local allGUID40 = {}
-- local allGUID30 = {}
-- local allGUID20 = {}
-- local allGUID15 = {}
-- local allGUID10 = {}
-- local allGUID8 = {}
-- local allGUID5 = {}

    -- for id = 1, 40 do
        -- local unitID = "nameplate" .. id
        -- if UnitCanAttack("player", unitID) and IsItemInRange(4945, unitID) and not UnitGUID('Target') then
            -- table.insert(allGUID40, UnitGUID(unitID))
		-- elseif UnitCanAttack("player", unitID) and IsItemInRange(835, unitID) and not UnitGUID('Target') then
            -- table.insert(allGUID30, UnitGUID(unitID))
		-- elseif UnitCanAttack("player", unitID) and IsItemInRange(10645, unitID) and not UnitGUID('Target') then
            -- table.insert(allGUID20, UnitGUID(unitID))
		-- elseif UnitCanAttack("player", unitID) and IsItemInRange(33069, unitID) and not UnitGUID('Target') then
            -- table.insert(allGUID15, UnitGUID(unitID))
		-- elseif UnitCanAttack("player", unitID) and IsItemInRange(32321, unitID) and not UnitGUID('Target') then
            -- table.insert(allGUID10, UnitGUID(unitID))
		-- elseif UnitCanAttack("player", unitID) and IsItemInRange(34368, unitID) and not UnitGUID('Target') then
            -- table.insert(allGUID8, UnitGUID(unitID))
		-- elseif UnitCanAttack("player", unitID) and IsItemInRange(37727, unitID) and not UnitGUID('Target') then
            -- table.insert(allGUID5, UnitGUID(unitID))
			
			
			-- -- if #allGUID40 >= 1 then 
				-- -- count40 = count40 + 1
			-- -- elseif #allGUID30 >= 1 then
				-- -- count30 = count30 + 1
			-- -- elseif #allGUID20 >= 1 then
				-- -- count20 = count20 + 1
			-- -- elseif #allGUID15 >= 1 then
				-- -- count15 = count15 + 1
			-- -- elseif #allGUID10 >= 1 then
				-- -- count10 = count10 + 1
			-- -- elseif #allGUID8 >= 1 then
				-- -- count8 = count8 + 1
			-- -- elseif #allGUID5 >= 1 then
				-- -- count5 = count5 + 1
			-- -- end
        -- end
    -- end
-- return #allGUID40
	-- -- for id = 1, 40 do
	-- -- local unitID = "nameplate" .. id
		-- -- local unitID = "nameplate" .. id
		-- -- if UnitCanAttack("player",unitID) and AuraUtil.FindAuraByName("Rupture",unitID,"PLAYER|HARMFUL") then
			-- -- rupture_targets = rupture_targets + 1
		-- -- end
    -- -- end

-- end

local function Build()
	if S.ShurikenStorm:IsCastable(13) and Cache.EnemiesCount[13] >= 2 + num(S.Gloomblade:IsAvailable() and Player:BuffRemainsP(S.LingeringShadow) >= 4 or Player:BuffP(S.PerforatedVeins)) then
		return S.ShurikenStorm:Cast()
	end

	if S.Gloomblade:IsReady(8) and S.Gloomblade:IsAvailable() then
		return S.Gloomblade:Cast()
	end

	if S.Backstab:IsReady(8) and not S.Gloomblade:IsAvailable() then
		return S.Backstab:Cast()
	end
	
	return nil
end

local function CDS()
local trinket1 = GetInventoryItemID("player", 13)
local trinket2 = GetInventoryItemID("player", 14)
local trinket1ready = IsUsableItem(trinket1) and GetItemCooldown(trinket1) == 0 and IsEquippedItem(trinket1)
local trinket2ready = IsUsableItem(trinket2) and GetItemCooldown(trinket2) == 0 and IsEquippedItem(trinket2)

	if S.ShadowDance:IsReady(8) and not Player:BuffP(S.ShadowDanceBuff) and Player:BuffP(S.ShurikenTornado) and Player:GCDRemains() <= 0.2 then
		return S.ShadowDance:Cast()
	end

	-- if S.Vanish:IsReady(8) and Player:BuffStack(S.DanseMacabre) > 3 and Player:ComboPoints() <= 2 and (S.SecretTechnique:CooldownRemainsP() >= 30 or not S.SecretTechnique:IsAvailable()) then
		-- return S.Vanish:Cast()
	-- end
	
	if S.SymbolsofDeath:IsReady(8) and rotten_condition and snd_condition and (not S.Flagellation:IsAvailable() and (Player:ComboPoints() <= 1 or not S.TheRotton:IsAvailable()) or S.Flagellation:CooldownRemainsP() > 10 or S.Flagellation:CooldownUp() and Player:ComboPoints() >= 5) then
		return S.SymbolsofDeath:Cast()
	end
	
	if S.ShadowBlades:IsReady(8) and snd_condition and Player:ComboPointsDeficit() >= 2 then
		return S.ShadowBlades:Cast()
	end
	
	if S.ShurikenTornado:IsReady(8) and snd_condition and Player:BuffP(S.SymbolsofDeath) and Player:ComboPoints() <= 2 and (not Player:BuffP(S.PremeditationBuff) or Cache.EnemiesCount[13] > 4) then
		return S.ShurikenTornado:Cast()
	end

	if S.ShurikenTornado:IsReady(8) and S.ShadowDance:CooldownUp() and not stealthed_all and Cache.EnemiesCount[13] >= 3 and not S.Flagellation:IsAvailable() then
		return S.ShurikenTornado:Cast()
	end
	
	if S.ThistleTea:IsCastable() and (S.SymbolsofDeath:CooldownRemainsP() >= 3 and not Player:BuffP(S.ThistleTea) and (Player:EnergyDeficit() >= 100 and (Player:ComboPointsDeficit() >= 2 or Cache.EnemiesCount[13] >= 3) or S.ThistleTea:ChargesFractional() >= 2.75 and Player:BuffP(S.ShadowDanceBuff)) or Player:BuffRemainsP(S.ShadowDanceBuff) >= 4 and not Player:BuffP(S.ThistleTea) and Cache.EnemiesCount[13] >= 3) then
		return S.ThistleTea:Cast()
	end
	
	if trinket1ready and Cache.EnemiesCount[8] >= 1 and (Player:BuffP(S.SymbolsofDeath) or S.SymbolsofDeath:CooldownRemainsP() >= 14) then
		return I.tx1:Cast()
	end
	
	return nil
end

local function Finish()
	if S.SliceandDice:IsCastable() and not premed_snd_condition and Cache.EnemiesCount[13] < 6 and not Player:BuffP(S.ShadowDanceBuff) and Player:BuffRemainsP(S.SliceandDice) < 8 then
		return S.SliceandDice:Cast()
	end
	
	if S.Rupture:IsReady(8) and not skip_rupture and Target:TimeToDie() - Target:DebuffRemainsP(S.Rupture) > 6 and Target:DebuffRemainsP(S.Rupture) < 8 then
		return S.Rupture:Cast()
	end
	
	if S.Rupture:IsReady(8) and not skip_rupture and Player:BuffP(S.FinalityRupture) and S.ShadowDance:CooldownRemainsP() < 12 and RubimRH.CDsON() and S.ShadowDance:ChargesFractional() <= 1 and Cache.EnemiesCount[13] == 1 and (S.DarkBrew:IsAvailable() or S.DanseMacabre:IsAvailable()) then
		return S.Rupture:Cast()
	end
	
	if S.ColdBlood:IsReady(8) and not Player:BuffP(S.ColdBlood) and secret_condition and S.SecretTechnique:CooldownUp() then
		return S.ColdBlood:Cast()
	end
	
	if S.SecretTechnique:IsReady(5) and secret_condition and (not S.ColdBlood:IsAvailable() or Player:BuffP(S.ColdBlood) or S.ColdBlood:CooldownRemainsP() > Player:BuffRemainsP(S.ShadowDanceBuff) - 2) then
		return S.SecretTechnique:Cast()
	end

	if S.Rupture:IsReady(8) and not skip_rupture and Target:DebuffRemainsP(S.Rupture) < S.SymbolsofDeath:CooldownRemainsP() + 10 and S.SymbolsofDeath:CooldownRemainsP() <= 5 and Target:TimeToDie() - Target:DebuffRemainsP(S.Rupture) > S.SymbolsofDeath:CooldownRemainsP() + 5 then
		return S.Rupture:Cast()
	end
	
	if S.BlackPowder:IsCastable() and Cache.EnemiesCount[13] >= 3 or not bp_used_for_danse and Player:BuffP(S.ShadowDanceBuff) and Cache.EnemiesCount[13] == 2 and S.DanseMacabre:IsAvailable() then
		return S.BlackPowder:Cast()
	end
	
	if S.Eviscerate:IsReady(8) then
		return S.Eviscerate:Cast()
	end
	
	return nil
end

local function Stealth_CDS()
	-- if S.Vanish:IsReady(8) and (not S.DanseMacabre:IsAvailable() or Cache.EnemiesCount[13] >= 3) and not shd_threshold and Player:ComboPointsDeficit() > 1 then
		-- return S.Vanish:Cast()
	-- end

	if S.ShadowDance:IsReady(8) and (shd_combo_points and (Player:BuffRemainsP(S.SymbolsofDeath) >= (2.2 - num(S.Flagellation:IsAvailable())) or shd_threshold) or S.ShadowDance:MaxCharges() == 2 and S.SecretTechnique:CooldownRemainsP() <= 9 and (Cache.EnemiesCount[13] <= 3 or S.DanseMacabre:IsAvailable()) or Target:DebuffP(S.Flagellation) or Cache.EnemiesCount[13] >= 4 and S.SymbolsofDeath:CooldownRemainsP() > 10) and rotten_threshold then
		return S.ShadowDance:Cast()
	end

	return nil
end

local function Stealthed()
	if S.ShurikenStorm:IsCastable() and gloomblade_condition and Player:BuffP(S.SilentStorm) and not Target:DebuffP(S.FindWeakness) and S.ImprovedShurikenStorm:IsAvailable() or Player:ComboPoints() <= 1 and not shuriken_storm_used_for_danse and Cache.EnemiesCount[13] == 2 and S.DanseMacabre:IsAvailable() then
		return S.ShurikenStorm:Cast()
	end

	if S.Gloomblade:IsReady(8) and gloomblade_condition and (not gloomblade_used_for_danse or Cache.EnemiesCount[13] ~= 2) then
		return S.Gloomblade:Cast()
	end

	if Finish() and Player:ComboPoints() >= CPMaxSpend() then
		return Finish()
	end

	if Finish() and Player:BuffP(S.ShurikenTornado) and Player:ComboPointsDeficit() <= 2 then
		return Finish()
	end

	if Finish() and Cache.EnemiesCount[13] >= 4 - num(S.SealFate:IsAvailable()) and Player:ComboPoints() >= 4 then
		return Finish()
	end

	if Finish() and Player:ComboPointsDeficit() <= 1 + (num(S.SealFate:IsAvailable()) or num(S.DeeperStratagem:IsAvailable()) or num(S.SecretStratagem:IsAvailable())) then
		return Finish()
	end

	if S.ShurikenStorm:IsCastable() and Cache.EnemiesCount[13] >= 3 + num(Player:BuffP(S.TheRotton)) and (not Player:BuffP(S.PremeditationBuff) or Cache.EnemiesCount[13] >= 7) then
		return S.ShurikenStorm:Cast()
	end
	
	if S.Shadowstrike:IsReady(8) and Target:IsInRange(10) and Target:DebuffRemainsP(S.FindWeakness) <= 1 or S.SymbolsofDeath:CooldownRemainsP() < 18 and Target:DebuffRemainsP(S.FindWeakness) < S.SymbolsofDeath:CooldownRemainsP() then
		return S.Shadowstrike:Cast()
	end
	
	if S.Shadowstrike:IsReady(8) and Target:IsInRange(10) then
		return S.Shadowstrike:Cast()
	end
	
	return nil
end

local function APL()
target_is_dummy()
TargetTTD()
HL.GetEnemies(5);
HL.GetEnemies(8);
HL.GetEnemies(10);
HL.GetEnemies(13);
HL.GetEnemies(20);
HL.GetEnemies(30);
--------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------Functions/Top priorities----------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
if Player:IsCasting() or Player:IsChanneling() then
	return 0, "Interface\\Addons\\Rubim-RH\\Media\\channel.tga"
elseif Player:IsDeadOrGhost() or AuraUtil.FindAuraByName("Drink", "player") or AuraUtil.FindAuraByName("Food", "player") or AuraUtil.FindAuraByName("Food & Drink", "player") or AuraUtil.FindAuraByName("Shroud of Concealment", "player") then
    return 0, "Interface\\Addons\\Rubim-RH\\Media\\mount2.tga"
end

if UnitClassification("target") == "worldboss" or UnitClassification("target") == "rareelite" or UnitClassification("target") == "elite"
or UnitClassification("target") == "rare" or target_is_dummy() or Target:IsAPlayer() then
	elite = true
else
	elite = false
end

if target_is_dummy() then
	rupture_hp_threshold = 8675309
elseif Target:IsAPlayer() then
	rupture_hp_threshold = UnitHealth('player') / 2
elseif IsInGroup() then
	rupture_hp_threshold = UnitHealth('player') * GetNumGroupMembers()
else
	rupture_hp_threshold = UnitHealth('player')
end

if true then
	rotten_condition = not Player:BuffP(S.PremeditationBuff) and Cache.EnemiesCount[13] == 1 or not S.TheRotton:IsAvailable() or Cache.EnemiesCount[13] > 1
	
	snd_condition = Player:BuffP(S.SliceandDice) or Cache.EnemiesCount[13] >= CPMaxSpend()
	
	stealthed_all = Player:BuffP(S.Stealth) or Player:BuffP(S.VanishBuff) or Player:BuffP(S.ShadowDanceBuff) or Player:BuffP(S.SubterfugeBuff)
	
	secret_condition = RubimRH.CDsON() and (Player:BuffP(S.ShadowDanceBuff) and (Player:BuffStack(S.DanseMacabre) >= 3 or S.DanseMacabre:IsAvailable()) and (not Player:BuffP(S.PremeditationBuff) or Cache.EnemiesCount[13] ~= 2))

	premed_snd_condition = S.Premeditation:IsAvailable() and Cache.EnemiesCount[13] < 5
	--add and nearest target doesnt have rupture in for skip during sd
	skip_rupture = (TargetTTD() and TargetTTD() < 12) or not elite or UnitName('target') == 'Explosives' or UnitName('target') == 'Spiteful Shade' or (Player:BuffP(S.ThistleTea) and Cache.EnemiesCount[13] == 1 or Player:BuffP(S.ShadowDanceBuff))

	bp_used_for_danse = Player:BuffP(S.ShadowDanceBuff) and S.BlackPowder:TimeSinceLastCast() < S.ShadowDance:TimeSinceLastCast()

	gloomblade_used_for_danse = Player:BuffP(S.ShadowDanceBuff) and S.Gloomblade:TimeSinceLastCast() < S.ShadowDance:TimeSinceLastCast()

	shuriken_storm_used_for_danse = Player:BuffP(S.ShadowDanceBuff) and S.ShurikenStorm:TimeSinceLastCast() < S.ShadowDance:TimeSinceLastCast()

	shd_threshold = S.ShadowDance:ChargesFractional() >= 0.75 + num(S.ShadowDance:MaxCharges() == 2)
	
	rotten_threshold = not Player:BuffP(S.TheRotton) or Cache.EnemiesCount[13] > 1

	shd_combo_points = Player:ComboPoints() <= 1 or (Player:ComboPointsDeficit() <= 1 and Cache.EnemiesCount[13] > (4 - 2 * num(S.ShurikenTornado:IsAvailable()))) or (Cache.EnemiesCount[13] == (4 - num(S.SealFate:IsAvailable())))
	
	gloomblade_condition = Player:BuffStack(S.DanseMacabre) < 5 and (Player:ComboPointsDeficit() == 2 or Player:ComboPointsDeficit() == 3) and (Player:BuffP(S.PremeditationBuff) or Player:ComboPoints() < 7) and (Cache.EnemiesCount[13] <= 8 or S.LingeringShadow:IsAvailable())

	stealth_threshold = 25 + num(S.Vigor:IsAvailable()) * 20 + num(S.MasterofShadows:IsAvailable()) * 20 + num(S.ShadowFocus:IsAvailable()) * 25 + num(S.Alacrity:IsAvailable()) * 20 + 25 * (num(Cache.EnemiesCount[13] >= 4))
end
--------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------Out of Combat---------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
if not Player:AffectingCombat() and not Player:BuffP(S.VanishBuff) then
    if S.Stealth:IsCastableQueue() and not Player:Buff(S.Stealth) and (IsResting("player") == false or Player:CanAttack(Target)) then
        return S.Stealth:Cast()
    end

    if S.CrimsonVial:IsCastableQueue() and Cache.EnemiesCount[25] == 0 and Player:HealthPercentage() < 100 and Player:EnergyDeficit() == 0 then
        return S.CrimsonVial:Cast()
    end

    if S.InstantPoison:IsCastableQueue() and not Player:Buff(S.WoundPoison) and Player:BuffRemainsP(S.InstantPoison) < 300 and not Player:IsCasting(S.InstantPoison) and not Player:IsMoving() then
        return S.InstantPoison:Cast()
    end

    if S.CripplingPoison:IsCastableQueue() and not S.NumbingPoison:IsAvailable() and not S.AtrophicPoison:IsAvailable() and not Player:BuffP(S.NumbingPoison) and not Player:BuffP(S.AtrophicPoison) and Player:BuffRemainsP(S.CripplingPoison) < 300 and not Player:IsCasting(S.CripplingPoison) and not Player:IsMoving() then
        return S.CripplingPoison:Cast()
    end
	
    if S.AtrophicPoison:IsCastableQueue() and Player:BuffRemainsP(S.AtrophicPoison) < 300 and not Player:IsCasting(S.AtrophicPoison) and not Player:IsMoving() then
        return S.AtrophicPoison:Cast()
    end
	
    if S.NumbingPoison:IsCastableQueue() and Player:BuffRemainsP(S.NumbingPoison) < 300 and not Player:IsCasting(S.NumbingPoison) and not Player:IsMoving() then
        return S.NumbingPoison:Cast()
    end

    if IsResting("player") == false 
	and ((Player:ComboPoints() == 1 and (Player:BuffRemainsP(S.SliceandDice) < 9 or not Player:BuffP(S.SliceandDice)))
	or (Player:ComboPoints() == 2 and (Player:BuffRemainsP(S.SliceandDice) < 14 or not Player:BuffP(S.SliceandDice)))
	or (Player:ComboPoints() == 3 and (Player:BuffRemainsP(S.SliceandDice) < 18 or not Player:BuffP(S.SliceandDice)))
	or (Player:ComboPoints() == 4 and (Player:BuffRemainsP(S.SliceandDice) < 23 or not Player:BuffP(S.SliceandDice)))
	or (Player:ComboPoints() == 5 and (Player:BuffRemainsP(S.SliceandDice) < 27 or not Player:BuffP(S.SliceandDice)))
	or (Player:ComboPoints() == 6 and (Player:BuffRemainsP(S.SliceandDice) < 32 or not Player:BuffP(S.SliceandDice)))
	or (Player:ComboPoints() == 7 and (Player:BuffRemainsP(S.SliceandDice) < 36 or not Player:BuffP(S.SliceandDice)))) then
		if S.SliceandDice:IsCastable() and Cache.EnemiesCount[30] >= 1 then
            return S.SliceandDice:Cast()
        end
    end
end

if AuraUtil.FindAuraByName("Stealth", "player") then
    return 0, "Interface\\Addons\\Rubim-RH\\Media\\mount2.tga"
end
--------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------Spell Queue-----------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
if not RubimRH.queuedSpell[1]:CooldownUp() or not Player:AffectingCombat() or Player:BuffP(S.VanishBuff) then
    RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
end

if S.KidneyShot:ID() == RubimRH.queuedSpell[1]:ID() and (Target:Debuff(S.CheapShot) or Target:Debuff(S.KidneyShot) or Target:Debuff(S.Blind) or Target:Debuff(S.Gouge)) then
    RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
end

if S.Gouge:ID() == RubimRH.queuedSpell[1]:ID() and (Target:Debuff(S.CheapShot) or Target:Debuff(S.KidneyShot) or Target:Debuff(S.Blind)) then
    RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
end

if RubimRH.QueuedSpell():IsReadyQueue() and S.ShadowDance:ID() ~= RubimRH.queuedSpell[1]:ID() then
    return RubimRH.QueuedSpell():Cast()
end
--------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------Interrupts & Tranq-----------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
if select(8, UnitCastingInfo("target")) == false and Target:CastPercentage() > math.random(27, 90) and RubimRH.InterruptsON() and S.Kick:IsCastableQueue(8) and Player:AffectingCombat() then
    return S.Kick:Cast()
end

if (select(4, UnitAura("target", 1)) == "" and RubimRH.InterruptsON() and S.Shiv:IsCastableQueue(8) and Player:AffectingCombat() and Target:TimeToDie() > 4) then
	return S.Shiv:Cast()
end
--------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------Cooldowns-------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
if Player:HealthPercentage() <= 25 and Player:AffectingCombat() and (IsUsableItem(191379) or IsUsableItem(191378) or IsUsableItem(191380)) and (GetItemCooldown(191380) == 0 or GetItemCooldown(191379) == 0 or GetItemCooldown(191378) == 0) and (GetItemCount(191380) >= 1 or GetItemCount(191379) >= 1 or GetItemCount(191378) >= 1) and (not Player:InArena() and not Player:InBattlegrounds()) then
	return I.HPIcon:Cast()
end
--------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------Rotation--------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
if Player:AffectingCombat() and Player:CanAttack(Target) then

	if S.ShurikenToss:IsReady(30) and not Target:IsInRange(8) and UnitName('target') == 'Explosives' then
		return S.ShurikenToss:Cast()
	end
	
	if CDS() and RubimRH.CDsON() then
		return CDS()
	end
	
    if S.SliceandDice:IsCastable() and Cache.EnemiesCount[13] < CPMaxSpend() and Player:BuffRemainsP(S.SliceandDice) < Player:GCD() and Player:ComboPoints() >= 4 then
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

	if Cache.EnemiesCount[13] >= (4 - num(S.SealFate:IsAvailable())) and Player:ComboPoints() >= 4 then
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