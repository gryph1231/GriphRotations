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
    lust1                  = Spell(57724),
    lust2                  = Spell(57723),
    lust3                  = Spell(80354),
    lust4                  = Spell(95809),
    lust5                  = Spell(264689),
	lustAT                 = Spell(155145), --arcane torrent

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
	PerforatedVeins         = Spell(382518),
	PerforatedVeinsBuff     = Spell(394254),

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
	FlagellationPersist = Spell(394758),
	TheRotten               = Spell(382015),
	TheRottenBuff           = Spell(394203),
	SubterfugeBuff = Spell(115192),
	Healthstonez = Spell(260364), --arcane pulse
	Sepsis = Spell(385408),
	InvigoratingShadowdust = Spell(382523),
	Shadowcraft = Spell(426594),
}

local S = RubimRH.Spell[261] 

if not Item.Rogue then Item.Rogue = {}; end

Item.Rogue.Sub = {
    trink = Item(184016, { 13, 14 }),
    drums = Item(193470),
    HPIcon = Item(169451),
    tx1 = Item(118330),
    tx2 = Item(114616),
    HPpotID = Item(191380),
};

local I = Item.Rogue.Sub;

local function num(val)
    if val then
        return 1
    else
        return 0
    end
end


local function RangeCount(spellName)
    local range_counter = 0

    if spellName then
        for i = 1, 40 do
            local unitID = "nameplate" .. i
            if UnitExists(unitID) then           
                local nameplate_guid = UnitGUID(unitID) 
                local npc_id = select(6, strsplit("-", nameplate_guid))
                if npc_id ~= '120651' and npc_id ~= '161895' then
                    if UnitCanAttack("player", unitID) and IsSpellInRange(spellName, unitID) == 1 and UnitHealthMax(unitID) > 5 then
                        range_counter = range_counter + 1
                    end                    
                end
            end
        end
    end

    return range_counter
end

local function TargetInRange(spellName)
    if spellName and IsSpellInRange(spellName, "target") == 1 then
        return true
    else
        return false    
    end
end

local function target_is_dummy()
    local x = UnitName("target")
    local targetisdummy = false

    if x then
        name = x:sub(-5)
    end

    if Target:Exists() then
        if name == 'Dummy' or name == 'elist' then
            targetisdummy = true
        end
    else
        targetisdummy = false
    end

    return targetisdummy
end

local function AreaTTD()
local currHealth = {}
local currHealthMax = {}
local areaTTD = {}

    for id = 1, 40 do
        local unitID = "nameplate" .. id
        if UnitCanAttack("player", unitID) and UnitAffectingCombat(unitID) 
        and ((UnitHealth(unitID) / UnitHealthMax(unitID)) * 100) < 100 then
            table.insert(currHealth, UnitHealth(unitID))
            table.insert(currHealthMax, UnitHealthMax(unitID))
            if #currHealthMax >= 1 then
                for id = 1, #currHealthMax do
                    dps = (currHealthMax[#currHealth] - currHealth[#currHealth]) / HL.CombatTime("nameplate" .. #currHealthMax)
                    areaTTD[#currHealthMax] = currHealth[#currHealth] / dps
                end
            end
        end
    end
    
    local count = 1
    local highest = 0

    for count = 1, #currHealthMax do
        if areaTTD[count] > highest then 
            highest = areaTTD[count]
        end
        count = count + 1
    end
    
	if highest ~= 0 then
		return highest
	else
		return 9999
	end

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
                while (UnitGUID('Target') ~= allGUID[count]) do
                    count = count + 1
                    break
                end
            end

            if #currHealthMax >= 1 then
                for id = 1, #currHealthMax do
                    dps = (currHealthMax[#currHealth] - currHealth[#currHealth]) /
                        HL.CombatTime("nameplate" .. #currHealthMax)
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
    elseif #currHealthMax >= 1 and areaTTD_Predicted[count] then
        return areaTTD_Predicted[count]
    else
        return 1
    end
end


local function kickprio()
    -- list of m+ abilities that should be kicked
    local KickSpells = {
        'Scar Soul', 'Spirited Defense', 'Spellbind', 'Soul Bolt','Soul Volley','Drain Essence','Infected Thorn','Ruinous Bolt','Bramble Bolt', -- Waycrest M
        "Bwonsamdi's Mantle", 'Mending Word','Fiery Enchant','Wildfire','Unstable Hex','Noxious Stench','Dino Might','Terrifying Screech',   -- AD
        'Soul Blast','Spirit Blast','Arcane Blitz','Fel Frenzy', --BRH
        'Healing Wave','Wrath','Hex','Water Bolt','Frostbolt','Mind Flay','Aquablast', --TotT
        'Thunderous Bolt', 'Holy Radiance', 'Cleansing Flames', 'Unruly Yell', 'Rune of Healing', 'Etch',
        'Surge',            -- HoV
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
        'Desacrating Blow', -- NO
        'Stone Bolt','Stone Gaze', -- neltharions lair

    }
end

local function mitigate()
    if Player:AffectingCombat() then
        for id = 1, 40 do
            local spell = {

                'Decay Spray', 'Gushing Ooze',                                                     --BH
                'Static Surge', 'Hailstorm', "Tempest's Fury", 'Deep Chill', 'Overpowering Croak', --halls of infusion
                'Shatter',                                                                         --neltharions lair
                'Magma Eruption', 'Might of the Forge', 'Volatile Mutation', 'Candescent Tempest', -- neltharus
                'Shocking Quake', 'Crushing Stomp', 'Thunderous Clap', 'Wing Buffet',              -- Uldaman
                'Tantrum', 'Festering Harvest',                                                    --underrot
                'Cyclone Shield', 'Skyfall Nova',                                                  --VP
                'Shattering Bellow',                                                               -- freehold
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

local function CPMaxSpend()
    if S.DeeperStratagem:IsAvailable()  then
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

local function tierequipped()
    local items = {
        "Lucid Shadewalker's Clawgrips",
        "Lucid Shadewalker's Chausses",
        "Lucid Shadewalker's Cuirass",
        "Lucid Shadewalker's Bladed Spaulders",
        "Lucid Shadewalker's Deathmask",
    }

    local count = 0

    for _, itemName in ipairs(items) do
        if IsEquippedItem(itemName) then
            count = count + 1
        end
    end

    return count
end

local function EnergyTimeToMaxRounded()
    return math.floor(Player:EnergyTimeToMaxPredicted() * 10 + 0.5) / 10;
end


local function UseItems()
    local trinket1 = GetInventoryItemID("player", 13)
    local trinket2 = GetInventoryItemID("player", 14)
    local trinket1ready = IsUsableItem(trinket1) and GetItemCooldown(trinket1) == 0 and IsEquippedItem(trinket1)
    local trinket2ready = IsUsableItem(trinket2) and GetItemCooldown(trinket2) == 0 and IsEquippedItem(trinket2)

    if trinket1ready 
    and ((Player:MovingFor() < 0.2 and not Player:IsMoving()) and trinket1 == 203963 or trinket1 ~= 203963) and trinket1 ~= 203729
     then
        return I.tx1:Cast()
    end
    if trinket2ready 
    and ((Player:MovingFor() < 0.2 and not Player:IsMoving()) and trinket2 == 203963 or trinket2 ~= 203963) and trinket2 ~= 203729
     then
        return I.tx2:Cast()
    end
	
	return nil
end





local function Build()
	if S.ShurikenStorm:IsCastable() and inRange10 >= 2 + num(S.Gloomblade:IsAvailable() and Player:BuffRemainsP(S.LingeringShadowBuff) >= 6 or Player:BuffP(S.PerforatedVeinsBuff)) then
		return S.ShurikenStorm:Cast()
	end

	if S.Gloomblade:IsReady() and targetRange8 then
		return S.Gloomblade:Cast()
	end
	if S.Backstab:IsReady() and targetRange8 then
		return S.Backstab:Cast()
	end

end

local function CDS()

	if S.ColdBlood:IsReady() and S.ColdBlood:IsAvailable() and targetRange10 and not S.SecretTechnique:IsAvailable() and Player:ComboPoints()>=5 then
		return S.ColdBlood:Cast() 
	end

	if S.Sepsis:IsReady() and snd_condition and S.Sepsis:IsAvailable() and targetRange10 and TargetTTD() >16 and (Player:Buff(S.PerforatedVeinsBuff) or not S.PerforatedVeins:IsAvailable()) then
		return S.Sepsis:Cast() 
	end
	-- symbols_of_death,if=variable.snd_condition&(!buff.the_rotten.up|!set_bonus.tier30_2pc)&buff.symbols_of_death.remains<=3
	-- &(!talent.flagellation|cooldown.flagellation.remains>10|buff.shadow_dance.remains>=2&talent.invigorating_shadowdust|cooldown.flagellation.up&combo_points>=5&!talent.invigorating_shadowdust)
	if S.SymbolsofDeath:IsReady() and snd_condition and targetRange8 and Player:GCDRemains() < 0.5 and not Player:Buff(S.TheRottenBuff) and Player:BuffRemains(S.SymbolsofDeath)<=3 and (not S.Flagellation:IsAvailable() or S.Flagellation:CooldownRemainsP()>10 
	or Player:BuffRemains(S.ShadowDanceBuff)>=2 and S.InvigoratingShadowdust:IsAvailable() or S.Flagellation:CooldownUp() and Player:ComboPoints()>=5 and not S.InvigoratingShadowdust:IsAvailable()) then
		return S.SymbolsofDeath:Cast()
	end

	-- shadow_blades,if=variable.snd_condition&(combo_points<=1|set_bonus.tier31_4pc)&(buff.flagellation_buff.up|buff.flagellation_persist.up|!talent.flagellation)
	if S.ShadowBlades:IsReady() and snd_condition and targetRange8 and Player:GCDRemains() < 0.5 and not Player:BuffP(S.ShadowDanceBuff) and (Player:ComboPoints()<=1 or tierequipped()==4) and (Player:Buff(S.Flagellation) or Player:Buff(S.FlagellationPersist) or not S.Flagellation:IsAvailable()) then
		return S.ShadowBlades:Cast()
	end

	-- echoing_reprimand,if=variable.snd_condition&combo_points.deficit>=3
	if S.EchoingReprimand:IsReady() and targetRange8 and snd_condition and Player:ComboPointsDeficit()>=3 then
		return S.EchoingReprimand:Cast()
	end

	-- shuriken_tornado,if=variable.snd_condition&buff.symbols_of_death.up&combo_points<=2&!buff.premeditation.up&(!talent.flagellation|cooldown.flagellation.remains>20)&spell_targets.shuriken_storm>=3
	if S.ShurikenTornado:IsReady() and targetRange8 and snd_condition and Player:BuffP(S.SymbolsofDeath) and Player:ComboPoints() <= 2 and not Player:BuffP(S.PremeditationBuff) and(not S.Flagellation:IsAvailable() or S.Flagellation:CooldownRemainsP()>20) and inRange10>=3 then
		return S.ShurikenTornado:Cast()
	end
	-- shuriken_tornado,if=variable.snd_condition&!buff.shadow_dance.up&!buff.flagellation_buff.up&!buff.flagellation_persist.up&!buff.shadow_blades.up&spell_targets.shuriken_storm<=2&!raid_event.adds.up
	if S.ShurikenTornado:IsReady() and targetRange8 and snd_condition and not Player:Buff(S.ShadowDanceBuff) and not Player:Buff(S.Flagellation) and not Player:Buff(S.FlagellationPersist) and not Player:Buff(S.ShadowBlades) and inRange10<=2 then
		return S.ShurikenTornado:Cast()
	end
	-- shadow_dance,if=!buff.shadow_dance.up&fight_remains<=8+talent.subterfuge.enabled

	if S.ShadowDance:IsReady() and targetRange8 and Player:GCDRemains() < 0.5 and not Player:BuffP(S.ShadowDanceBuff) then
		return S.ShadowDance:Cast()
	end

	
	if S.ThistleTea:IsCastable() and (S.SymbolsofDeath:CooldownRemainsP() >= 3 and not Player:BuffP(S.ThistleTea) and (Player:EnergyDeficit() >= 100 and (Player:ComboPointsDeficit() >= 2 or inRange10 >= 3) or S.ThistleTea:ChargesFractional() >= 2.75 and Player:BuffP(S.ShadowDanceBuff)) or Player:BuffRemainsP(S.ShadowDanceBuff) >= 4 and not Player:BuffP(S.ThistleTea) and inRange10 >= 3) then
		return S.ThistleTea:Cast()
	end
	


end

local function Finish()
	if S.SliceandDice:IsCastable() and not premed_snd_condition and inRange10 < 6 and not Player:BuffP(S.ShadowDanceBuff) and Player:BuffRemainsP(S.SliceandDice) < 12.6 then
		return S.SliceandDice:Cast()
	end
	
	if S.SliceandDice:IsCastable() and premed_snd_condition and S.ShadowDance:ChargesFractional() < 1.75 and Player:BuffRemainsP(S.SliceandDice) < S.SymbolsofDeath:CooldownRemainsP() and (S.ShadowDance:CooldownUp() and Player:BuffRemainsP(S.SymbolsofDeath) - Player:BuffRemainsP(S.ShadowDanceBuff) < 1.2) then
		return S.SliceandDice:Cast()
	end
	
	if S.Rupture:IsReady() and targetRange8 and not skip_rupture and TargetTTD() and TargetTTD() - Target:DebuffRemainsP(S.Rupture) > 6 and Target:DebuffRemainsP(S.Rupture) < 8.4 then
		return S.Rupture:Cast()
	end
	
	if S.Rupture:IsReady() and targetRange8 and not skip_rupture and Player:BuffP(S.FinalityRupture) and S.ShadowDance:CooldownRemainsP() < 12 and S.ShadowDance:ChargesFractional() <= 1 and inRange10 == 1 and (S.DarkBrew:IsAvailable() or S.DanseMacabre:IsAvailable()) then
		return S.Rupture:Cast()
	end
	
	if S.ColdBlood:IsReady() and targetRange8 and not Player:BuffP(S.ColdBlood) and secret_condition and S.SecretTechnique:CooldownUp() then
		return S.ColdBlood:Cast()
	end
	
	if S.SecretTechnique:IsReady() and targetRange8 and secret_condition and (not S.ColdBlood:IsAvailable() or Player:BuffP(S.ColdBlood) or S.ColdBlood:CooldownRemainsP() > Player:BuffRemainsP(S.ShadowDanceBuff) - 2) then
		return S.SecretTechnique:Cast()
	end

	if S.Rupture:IsReady() and targetRange8 and not skip_rupture and Target:DebuffRemainsP(S.Rupture) < S.SymbolsofDeath:CooldownRemainsP() + 10 and S.SymbolsofDeath:CooldownRemainsP() <= 5 and TargetTTD() and TargetTTD() - Target:DebuffRemainsP(S.Rupture) > S.SymbolsofDeath:CooldownRemainsP() + 5 then
		return S.Rupture:Cast()
	end
	
	if S.BlackPowder:IsCastable() and inRange10 >= 3 or not bp_used_for_danse and Player:BuffP(S.ShadowDanceBuff) and inRange10 == 2 and S.DanseMacabre:IsAvailable() then
		return S.BlackPowder:Cast()
	end
	
	if S.Eviscerate:IsReady() and targetRange8 then
		return S.Eviscerate:Cast()
	end
	if UseItems() and RubimRH.CDsON() and targetRange8 and not Player:Buff(S.Stealth) and not Player:Buff(S.VanishBuff) then
		return UseItems()
    end

end

local function Stealth_CDS()
	-- vanish,if=(combo_points.deficit>1|buff.shadow_blades.up&talent.invigorating_shadowdust)&!variable.shd_threshold&(cooldown.flagellation.remains>=60|!talent.flagellation|fight_remains<=(30*cooldown.vanish.charges))
	-- &(cooldown.symbols_of_death.remains>3|!set_bonus.tier30_2pc)&(cooldown.secret_technique.remains>=10|!talent.secret_technique|cooldown.vanish.charges>=2&talent.invigorating_shadowdust&(buff.the_rotten.up|!talent.the_rotten)&!raid_event.adds.up)



	if S.Vanish:IsReady() and targetRange8 and (Player:ComboPointsDeficit() > 1 or Player:Buff(S.ShadowBlades) and S.InvigoratingShadowdust:IsAvailable()) and not shd_threshold and (S.Flagellation:CooldownRemainsP()>=60 or not S.Flagellation:IsAvailable())
 and (S.SymbolsofDeath:CooldownRemainsP()>3 or  tierequipped()==4) and (S.SecretTechnique:CooldownRemainsP()>=10 or not S.SecretTechnique:IsAvailable() or S.Vanish:Charges()>=2 and S.InvigoratingShadowdust:IsAvailable() and (Player:Buff(S.TheRottenBuff) or not S.TheRotten:IsAvailable()) ) then
		return S.Vanish:Cast()
	end
	
	if S.ShadowDance:IsReady() and targetRange8 and Player:GCDRemains() < 0.5 and (shd_combo_points and (Player:BuffRemainsP(S.SymbolsofDeath) >= (2.2 - num(S.Flagellation:IsAvailable())) or shd_threshold) or S.ShadowDance:MaxCharges() == 2 and S.SecretTechnique:CooldownRemainsP() <= 9 and (inRange10 <= 3 or S.DanseMacabre:IsAvailable()) or Target:DebuffP(S.Flagellation) or inRange10 >= 4 and S.SymbolsofDeath:CooldownRemainsP() > 10) and rotten_threshold then
		return S.ShadowDance:Cast()
	end

end

local function Stealthed()
	if S.Shadowstrike:IsReady() and targetRange8 and Player:BuffP(S.VanishBuff) and inRange10 < 7 then
		return S.Shadowstrike:Cast()
	end

	if S.ShurikenStorm:IsCastable() and gloomblade_condition and Player:BuffP(S.SilentStorm) and not Target:DebuffP(S.FindWeakness) and S.ImprovedShurikenStorm:IsAvailable() or Player:ComboPoints() <= 1 and not shuriken_storm_used_for_danse and inRange10 == 2 and S.DanseMacabre:IsAvailable() then
		return S.ShurikenStorm:Cast()
	end

	if S.Gloomblade:IsReady() and targetRange8 and gloomblade_condition and (not gloomblade_used_for_danse or inRange10 ~= 2) then
		return S.Gloomblade:Cast()
	end
	
	if Finish() and Player:ComboPoints() >= CPMaxSpend() then
		return Finish()
	end

	if Finish() and Player:BuffP(S.ShurikenTornado) and Player:ComboPointsDeficit() <= 2 then
		return Finish()
	end
	
	if Finish() and inRange10 >= 4 - num(S.SealFate:IsAvailable()) and Player:ComboPoints() >= 4 then
		return Finish()
	end
	
	if Finish() and Player:ComboPointsDeficit() <= 1 + (num(S.SealFate:IsAvailable() or S.DeeperStratagem:IsAvailable() or S.SecretStratagem:IsAvailable())) then
		return Finish()
	end
	
	if S.ShurikenStorm:IsCastable() and inRange10 >= 3 + num(Player:BuffP(S.TheRottenBuff)) and (not Player:BuffP(S.PremeditationBuff) or inRange10 >= 7) then
		return S.ShurikenStorm:Cast()
	end

	if S.Shadowstrike:IsReady() and targetRange8 then
		return S.Shadowstrike:Cast()
	end

end



local function APL()
	inRange8 = RangeCount("Eviscerate")
	inRange10 = RangeCount("Pick Pocket")
	inRange20 = RangeCount("Blind")
	inRange25 = RangeCount("Shadowstep")
	inRange30 = RangeCount("Shuriken Toss")
	targetRange8 = TargetInRange("Eviscerate")
	targetRange10 = TargetInRange("Pick Pocket")
	targetRange20 = TargetInRange("Blind")
	targetRange25 = TargetInRange("Shadowstep")
	targetRange30 = TargetInRange("Shuriken Toss")
	
	-- print(inRange30)
	-- kickprio()
    -- stunprio()
    -- blindprio()
    mitigate()
target_is_dummy()
TargetTTD()



--------------------------------------------------------------------------------------------------------------------------------------------
--variables----------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
if true then
	level, affixIDs, wasEnergized = C_ChallengeMode.GetActiveKeystoneInfo()
	
	inInstance, instanceType = IsInInstance()

	local startTimeMS = (select(4, UnitCastingInfo('target')) or select(4, UnitChannelInfo('target')) or 0)

	local elapsedTimeca = ((startTimeMS > 0) and (GetTime() * 1000 - startTimeMS) or 0)
   
	local elapsedTimech = ((startTimeMS > 0) and (GetTime() * 1000 - startTimeMS) or 0)
	
	channelTime = elapsedTimech / 1000

	castTime = elapsedTimeca / 1000

    castchannelTime = math.random(275, 500) / 1000

	isEnraged = (AuraUtil.FindAuraByName("Enrage", "target") or UnitChannelInfo("target") == "Ragestorm" or AuraUtil.FindAuraByName("Frenzy", "target"))

	HPpercentloss = MyHealthTracker.GetPredictedHealthLoss() * 3
	rotten_condition = not Player:BuffP(S.PremeditationBuff) and inRange10 == 1 or not S.TheRotten:IsAvailable() or inRange10 > 1
	
	snd_condition = Player:BuffP(S.SliceandDice) or inRange10 >= CPMaxSpend()
	
	stealthed_all = Player:BuffP(S.VanishBuff) or Player:BuffP(S.ShadowDanceBuff) or Player:BuffP(S.SubterfugeBuff)
	
	secret_condition = (RubimRH.CDsON() or Player:BuffP(S.ShadowDanceBuff)) and (Player:BuffP(S.ShadowDanceBuff) and (Player:BuffStack(S.DanseMacabreBuff) >= 3 or not S.DanseMacabre:IsAvailable()) and (not Player:BuffP(S.PremeditationBuff) or inRange10 ~= 2))

	premed_snd_condition = S.Premeditation:IsAvailable() and inRange10 < 5
	
	skip_rupture = TargetTTD() and TargetTTD() < 12 or not elite or UnitName('target') == 'Spiteful Shade' or (Player:BuffP(S.ThistleTea) and inRange10 == 1 or Player:BuffP(S.ShadowDanceBuff) and (inRange10 == 1 or (Target:DebuffP(S.Rupture) and inRange10 >= 2) or rupture_used_for_danse or (Player:BuffRemainsP(S.ShadowDanceBuff) < Player:GCD() + 2 and S.SecretTechnique:CooldownUp()) or Player:BuffRemainsP(S.ShadowDanceBuff) <= Player:GCD() * 1.15))

	bp_used_for_danse = Player:BuffP(S.ShadowDanceBuff) and S.BlackPowder:TimeSinceLastCast() < S.ShadowDance:TimeSinceLastCast()

	gloomblade_used_for_danse = Player:BuffP(S.ShadowDanceBuff) and S.Gloomblade:TimeSinceLastCast() < S.ShadowDance:TimeSinceLastCast()
	
	rupture_used_for_danse = Player:BuffP(S.ShadowDanceBuff) and S.Rupture:TimeSinceLastCast() < S.ShadowDance:TimeSinceLastCast()
	
	shuriken_storm_used_for_danse = Player:BuffP(S.ShadowDanceBuff) and S.ShurikenStorm:TimeSinceLastCast() < S.ShadowDance:TimeSinceLastCast()
	--shd_threshold = S.ShadowDance:ChargesFractional() >= 0.75 + num(S.ShadowDance:MaxCharges() == 2) <- Not taking talent, so left out
	shd_threshold = S.ShadowDance:ChargesFractional() and S.ShadowDance:ChargesFractional() >= 0.75 + num(S.ShadowDance:MaxCharges() == 2)
	
	rotten_threshold = not Player:BuffP(S.TheRottenBuff) or inRange10 > 1

	--Use stealth cooldowns on any combo point on 3 or 4 targets
	if inRange10 == (4 - num(S.SealFate:IsAvailable())) then
		shd_combo_points = true
	--Use stealth cooldowns with high combo points when playing shuriken tornado or with high target counts
	elseif inRange10 > (4 - 2 * num(S.ShurikenTornado:IsAvailable())) then
		shd_combo_points = Player:ComboPointsDeficit() <= 1
	else
	--CP thresholds for entering Shadow Dance Default to start dance with 0 or 1 combo point
		shd_combo_points = Player:ComboPoints() <= 1
	end
	
	gloomblade_condition = Player:BuffStack(S.DanseMacabreBuff) < 5 and (Player:ComboPointsDeficit() == 2 or Player:ComboPointsDeficit() == 3) and (Player:BuffP(S.PremeditationBuff) or Player:ComboPoints() < 7) and (inRange10 <= 8 or S.LingeringShadow:IsAvailable())
	
	-- variable,name=stealth_threshold,value=20+talent.vigor.rank*25+talent.thistle_tea*20+talent.shadowcraft*20
	stealth_threshold = 20 + num(S.Vigor:IsAvailable()) * 25 + num(S.ThistleTea:IsAvailable()) * 20 + num(S.Shadowcraft:IsAvailable()) * 20 
	
	tolerance = select(4, GetNetStats())/1000 + 0.3
end


--------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------Functions/Top priorities----------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
if Player:IsCasting() or Player:IsChanneling() then
	return 0, "Interface\\Addons\\Rubim-RH\\Media\\channel.tga"
elseif Player:IsDeadOrGhost() or AuraUtil.FindAuraByName("Drink", "player") or AuraUtil.FindAuraByName("Food", "player") or AuraUtil.FindAuraByName("Food & Drink", "player") or AuraUtil.FindAuraByName("Shroud of Concealment", "player") and RtB_BuffRemains()>0 then
	return 0, "Interface\\Addons\\Rubim-RH\\Media\\griph.tga"
end
HPpercentloss = MyHealthTracker.GetPredictedHealthLoss() * 3


if UnitClassification("target") == "worldboss" or UnitClassification("target") == "rareelite" or UnitClassification("target") == "elite"
or UnitClassification("target") == "rare" or target_is_dummy() or Target:IsAPlayer() then
	elite = true
else
	elite = false
end


--------------------------------------------------------------------------------------------------------------------------------------------------------
--Out of Combat-----------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------
if not Player:AffectingCombat() and not Player:Buff(S.VanishBuff) and (IsResting("player") == false or Player:CanAttack(Target)) then
	-- if S.BladeFlurry:IsReady() and S.UnderhandedUpperHand:IsAvailable() and not Player:Buff(S.BladeFlurry) and ((S.AdrenalineRush:IsReady() and inRange30 >= 1) or Player:Buff(S.AdrenalineRush)) and (IsResting("player") == false or Player:CanAttack(Target)) and not AuraUtil.FindAuraByName("Stealth", "player") then
		-- return S.BladeFlurry:Cast()
	-- end

	if S.Stealth:IsUsableP() and S.Stealth:CooldownUp() and not AuraUtil.FindAuraByName("Stealth", "player") and (IsResting("player") == false or Player:CanAttack(Target)) then
		return S.Stealth:Cast()
	end



	if inRange30 >= 1 and (not targetRange8 or not Player:CanAttack(Target)) and Player:IsMoving() and (IsInInstance() or Player:CanAttack(Target)) then
	

		if S.SliceandDice:IsCastable() and finish_condition and Player:BuffRemains(S.SliceandDice) < 8 then
			return S.SliceandDice:Cast()
		end
	

	end

	if S.CrimsonVial:IsCastable() and inRange20 == 0 and Player:HealthPercentage() < 75 and Player:EnergyDeficit() == 0 then
		return S.CrimsonVial:Cast()
	end
	
	if not Player:IsMoving() then 
		if S.InstantPoison:IsCastable() and not Player:Buff(S.WoundPoison) and Player:BuffRemains(S.InstantPoison) < 300 and not Player:IsCasting(S.InstantPoison) then
			return S.InstantPoison:Cast()
		end

		if S.CripplingPoison:IsCastable() and not S.NumbingPoison:IsAvailable() and not S.AtrophicPoison:IsAvailable() and not Player:Buff(S.NumbingPoison) and not Player:Buff(S.AtrophicPoison) and Player:BuffRemains(S.CripplingPoison) < 300 and not Player:IsCasting(S.CripplingPoison) then
			return S.CripplingPoison:Cast()
		end

		if S.AtrophicPoison:IsCastable() and Player:BuffRemains(S.AtrophicPoison) < 300 and not Player:IsCasting(S.AtrophicPoison) then
			return S.AtrophicPoison:Cast()
		end

		if S.NumbingPoison:IsCastable() and Player:BuffRemains(S.NumbingPoison) < 300 and not Player:IsCasting(S.NumbingPoison) then
			return S.NumbingPoison:Cast()
		end
	end
end

--------------------------------------------------------------------------------------------------------------------------------------------------------
--Spell Queue-------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------
if (not RubimRH.queuedSpell[1]:CooldownUp() or not RubimRH.queuedSpell[1]:IsAvailable()) and S.lustAT:ID() ~= RubimRH.queuedSpell[1]:ID() then
	RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
end

if S.lustAT:ID() == RubimRH.queuedSpell[1]:ID() and (Player:DebuffP(S.lust1) or Player:DebuffP(S.lust2) or Player:DebuffP(S.lust3) or Player:DebuffP(S.lust4) or Player:DebuffP(S.lust5)) then
	RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
end

if S.lustAT:ID() == RubimRH.queuedSpell[1]:ID() and not Player:DebuffP(S.lust1) and not Player:DebuffP(S.lust2) and not Player:DebuffP(S.lust3) and not Player:DebuffP(S.lust4) and not Player:DebuffP(S.lust5) and IsUsableItem(193470) and GetItemCooldown(193470) == 0 then
	return S.lustAT:Cast() -- BIND LUST KEYBIND IN BINDPAD TO ARCANE TORRENT
end

if S.Feint:ID() == RubimRH.queuedSpell[1]:ID() and Player:Buff(S.Feint) then
	RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
end

if S.Feint:ID() == RubimRH.queuedSpell[1]:ID() and Player:Buff(S.Feint) then
	RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
end


if S.KidneyShot:ID() == RubimRH.queuedSpell[1]:ID() and (Target:DebuffP(S.CheapShot) or Target:DebuffP(S.KidneyShot) or Target:DebuffP(S.Blind) or Target:DebuffP(S.Gouge)) then
	RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
end

if S.Gouge:ID() == RubimRH.queuedSpell[1]:ID() and (Target:DebuffP(S.CheapShot) or Target:DebuffP(S.KidneyShot) or Target:DebuffP(S.Blind)) then
	RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
end

if (inRange30==0 or not Player:AffectingCombat()) then
	RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
end

if RubimRH.QueuedSpell():IsReadyQueue() then
	return RubimRH.QueuedSpell():Cast()
end
-- --------------------------------------------------------------------------------------------------------------------------------------------------------
-- --Interrupts/Tranqs/Dispels-----------------------------------------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------------------------------------------------------------
if RubimRH.InterruptsON() and not AuraUtil.FindAuraByName("Stealth", "player") and Player:CanAttack(Target) then
	--Kick
	if S.Kick:IsReady() and targetRange8 and (castTime > castchannelTime or channelTime > castchannelTime) and Player:AffectingCombat() and select(8, UnitCastingInfo("target")) == false then
		return S.Kick:Cast()
	end

	-- --Stun
	-- if S.KidneyShot:IsReady() and targetRange8 and (castTime>castchannelTime or channelTime>castchannelTime) and RubimRH.InterruptsON() and Player:AffectingCombat() and stunprio() then
		-- return S.KidneyShot:Cast()
	-- end

	--Shiv
	if S.Shiv:IsReady() and targetRange8 and isEnraged and Player:AffectingCombat() and TargetTTD() > 4 then
		return S.Shiv:Cast()
	end
end
-- --------------------------------------------------------------------------------------------------------------------------------------------------------
-- --Defensives--------------------------------------------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------------------------------------------------------------
if Player:AffectingCombat() and not AuraUtil.FindAuraByName("Stealth", "player") then
 
    if S.Feint:IsReady() and not Player:Buff(S.Feint) and inRange30>=1 and mitigate() then
        return S.Feint:Cast()
    end

    if Player:AffectingCombat() and not AuraUtil.FindAuraByName("Stealth", "player") and HPpercentloss > 0  then
        if I.HPpotID:IsReady() and Player:HealthPercentage() <= 35 then
            return I.HPIcon:Cast()
        end
        if S.Evasion:IsCastable() and inRange10>=1 and Player:HealthPercentage()<45 then
            return S.Evasion:Cast()
            end
            if S.CloakofShadows:IsCastable() and Player:HealthPercentage()<15 and HPpercentloss>25 then
                return S.CloakofShadows:Cast()
                end 
    end

end
--------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------Rotation--------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
if Player:AffectingCombat() and not AuraUtil.FindAuraByName("Stealth", "player") then
	if not IsCurrentSpell(6603) and not Player:Buff(S.VanishBuff)
		and Player:CanAttack(Target) and not Target:IsDeadOrGhost() and targetRange20 then
		return S.autoattack:Cast()
	end





	if CDS() and RubimRH.CDsON() then
		return CDS()
	end
	
    if S.SliceandDice:IsCastable() and inRange10 < CPMaxSpend() and Player:BuffRemainsP(S.SliceandDice) < Player:GCD() and Player:ComboPoints() >= 4 then
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

	if Finish() and Player:ComboPointsDeficit() <= 1 + num(Player:BuffP(S.TheRottenBuff)) then
		return Finish()
	end

	if Finish() and inRange10 >= 4 and Player:ComboPoints() >= 4 then
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