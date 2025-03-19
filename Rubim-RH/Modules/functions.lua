-- Addon
local addonName, addonTable = ...
-- HeroLib
local HL = HeroLib
local Cache = HeroCache
local Unit = HL.Unit
local Player = Unit.Player
local Target = Unit.Target
local Pet = Unit.Pet
local Spell = HL.Spell
local Item = HL.Item

function target_is_dummy()
    local x = UnitName("target")
    local targetisdummy = false

    if x then
        name2 = x:sub(-5)
    end

    if Target:Exists() then
        if name2 == 'Dummy' or name2 == 'rfist' then
            targetisdummy = true
        end
    else
        targetisdummy = false
    end

    return targetisdummy
end

local function num(val)
    if val then
        return 1
    else
        return 0
    end
end

function AreaTTD()
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

function TargetTTD()
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
	elseif #currHealthMax >= 1 and areaTTD_Predicted[count] then
		return areaTTD_Predicted[count]
	else
		return 1
	end
end

function RangeCount(range,spell_range_check)
	local range_counter = 0
		
		if range and not spell_range_check then
			if range == 5 then
				input = 8149
			elseif range == 8 then
				input = 34368
			elseif range == 10 then
				input = 32321
			elseif range == 15 then
				input = 33069
			elseif range == 20 then
				input = 10645
			elseif range == 25 then
				input = 24268
			elseif range == 30 then
				input = 835
			else
				local input = nil
			end

			for i=1,40 do
				local unitID = "nameplate" .. i
				if UnitExists("nameplate"..i) then           
					local nameplate_guid = UnitGUID("nameplate"..i) 
					local npc_id = select(6, strsplit("-",nameplate_guid))
					if npc_id ~='120651' and npc_id ~='161895' then
						if UnitCanAttack("player",unitID) and C_Item.IsItemInRange(input, unitID) and UnitHealthMax(unitID) > 5
						and UnitName(unitID) ~= "Incorporeal Being" then
							range_counter = range_counter + 1
						end                    
					end
				end
			end
		elseif spell_range_check and not range then
			for i=1,40 do
				local unitID = "nameplate" .. i
				if UnitExists("nameplate"..i) then           
					local nameplate_guid = UnitGUID("nameplate"..i) 
					local npc_id = select(6, strsplit("-",nameplate_guid))
					if npc_id ~='120651' and npc_id ~='161895' then
						if UnitCanAttack("player",unitID) and C_Spell.IsSpellInRange(spell_range_check, unitID) and UnitHealthMax(unitID) > 5
						and UnitName(unitID) ~= "Incorporeal Being" then
							range_counter = range_counter + 1
						end                    
					end
				end
			end
		else
			range_counter = 0
		end

	return range_counter
end

function TargetinRange(range,spell_range_check)
	if range and not spell_range_check then
		if range == 5 then
			input = 8149
		elseif range == 8 then
			input = 34368
		elseif range == 10 then
			input = 32321
		elseif range == 15 then
			input = 33069
		elseif range == 20 then
			input = 10645
		elseif range == 25 then
			input = 24268
		elseif range == 30 then
			input = 1404
		else
			local input = nil
		end

		if C_Item.IsItemInRange(input,"target") then
			return true
		else
			return false
		end
	elseif spell_range_check and not range then
		if C_Spell.IsSpellInRange(spell_range_check,"target") then
			return true
		else
			return false
		end	
	else
		return false
	end
end

function MissingHealth(healthPercent)
	if healthPercent then
        check = 
        num(C_Spell.IsSpellInRange("Flash of Light","player") and ((UnitHealth("player") / UnitHealthMax("player")) * 100) <= healthPercent) +
        num(C_Spell.IsSpellInRange("Flash of Light","party1") and ((UnitHealth("party1") / UnitHealthMax("party1")) * 100) <= healthPercent) +
        num(C_Spell.IsSpellInRange("Flash of Light","party2") and ((UnitHealth("party2") / UnitHealthMax("party2")) * 100) <= healthPercent) +
        num(C_Spell.IsSpellInRange("Flash of Light","party3") and ((UnitHealth("party3") / UnitHealthMax("party3")) * 100) <= healthPercent) +
        num(C_Spell.IsSpellInRange("Flash of Light","party4") and ((UnitHealth("party4") / UnitHealthMax("party4")) * 100) <= healthPercent)
	else
		check = 0
	end
	
	return check
end

function AutoSpreadTarget()
    for id = 1, 5 do
        if UnitExists("party1") and UnitExists("Party1target") and UnitCanAttack("player", "Party1target") and not UnitIsDeadOrGhost("Party1target") and C_Spell.IsSpellInRange('Barbed Shot', 'Party1target') and UnitAffectingCombat("Party1target") then
            if not AuraUtil.FindAuraByName("Barbed Shot","Party1target","PLAYER|HARMFUL") then
                party1target_health = UnitHealth("Party1target")
            else
                party1target_health = 0
            end
        else
            party1target_health = 0
        end

        if UnitExists("party2") and UnitExists("Party2target") and UnitCanAttack("player", "Party2target") and not UnitIsDeadOrGhost("Party2target") and C_Spell.IsSpellInRange('Barbed Shot', 'Party2target') and UnitAffectingCombat("Party2target") then
            if not AuraUtil.FindAuraByName("Barbed Shot","Party2target","PLAYER|HARMFUL") then
                party2target_health = UnitHealth("Party2target")
            else
                party2target_health = 0
            end
        else
            party2target_health = 0
        end

        if UnitExists("party3") and UnitExists("Party3target") and UnitCanAttack("player", "Party3target") and not UnitIsDeadOrGhost("Party3target") and C_Spell.IsSpellInRange('Barbed Shot', 'Party3target') and UnitAffectingCombat("Party3target") then
            if not AuraUtil.FindAuraByName("Barbed Shot","Party3target","PLAYER|HARMFUL") then
                party3target_health = UnitHealth("Party3target")
            else
                party3target_health = 0
            end
        else
            party3target_health = 0
        end

        if UnitExists("party4") and UnitExists("Party4target") and UnitCanAttack("player", "Party4target") and not UnitIsDeadOrGhost("Party4target") and C_Spell.IsSpellInRange('Barbed Shot', 'Party4target') and UnitAffectingCombat("Party4target") then
            if not AuraUtil.FindAuraByName("Barbed Shot","Party4target","PLAYER|HARMFUL") then
                party4target_health = UnitHealth("Party4target")
            else
                party4target_health = 0
            end
        else
            party4target_health = 0
        end
    end

    if party1target_health ~= 0 and party1target_health ~= 0 and party1target_health ~= 0 and party1target_health ~= 0 then
        if party1target_health >= party2target_health and party1target_health >= party3target_health and party1target_health >= party4target_health then
            highest_guid = "Party1target"
        elseif party2target_health >= party1target_health and party2target_health >= party3target_health and party2target_health >= party4target_health then
            highest_guid = "Party2target"
        elseif party3target_health >= party1target_health and party3target_health >= party2target_health and party3target_health >= party4target_health then
            highest_guid = "Party3target"
        elseif party4target_health >= party1target_health and party4target_health >= party2target_health and party4target_health >= party3target_health then
            highest_guid = "Party4target"
        end
    else
        highest_guid = nil
    end
    
    return highest_guid
end

-- function SummerTarget(unit)
--     local currentSpec = GetSpecialization()
--     local currentSpecName = currentSpec and select(2, GetSpecializationInfo(currentSpec)) or "None"

--     for id = 1, 5 do
--         if 
        


-- end

function LowestAlly(check)
    for id = 1, 5 do
        if UnitExists("player") and not UnitIsDeadOrGhost("player") then
            player_health = ((UnitHealth("player") / UnitHealthMax("player")) * 100)
        else
            player_health = 100
        end

        if C_Spell.IsSpellInRange("Flash of Light","party1") and UnitExists("party1") and not UnitIsDeadOrGhost("party1") then
            party1_health = ((UnitHealth("party1") / UnitHealthMax("party1")) * 100)
        else
            party1_health = 100
        end

        if C_Spell.IsSpellInRange("Flash of Light","party2") and UnitExists("party2") and not UnitIsDeadOrGhost("party2") then
            party2_health = ((UnitHealth("party2") / UnitHealthMax("party2")) * 100)
        else
            party2_health = 100
        end

        if C_Spell.IsSpellInRange("Flash of Light","party3") and UnitExists("party3") and not UnitIsDeadOrGhost("party3") then
            party3_health = ((UnitHealth("party3") / UnitHealthMax("party3")) * 100)
        else
            party3_health = 100
        end

        if C_Spell.IsSpellInRange("Flash of Light","party4") and UnitExists("party4") and not UnitIsDeadOrGhost("party4") then
            party4_health = ((UnitHealth("party4") / UnitHealthMax("party4")) * 100)
        else
            party4_health = 100
        end
	end

    if player_health <= party1_health and player_health <= party2_health and player_health <= party3_health and player_health <= party4_health then
        lowest_percent = player_health
        lowest_guid = "player"
    elseif party1_health <= player_health and party1_health <= party2_health and party1_health <= party3_health and party1_health <= party4_health then
        lowest_percent = party1_health
        lowest_guid = "party1"
    elseif party2_health <= player_health and party2_health <= party1_health and party2_health <= party3_health and party2_health <= party4_health then
        lowest_percent = party2_health
        lowest_guid = "party2"
    elseif party3_health <= player_health and party3_health <= party1_health and party3_health <= party2_health and party3_health <= party4_health then
        lowest_percent = party3_health
        lowest_guid = "party3"
    elseif party4_health <= player_health and party4_health <= party1_health and party4_health <= party2_health and party4_health <= party3_health then
        lowest_percent = party4_health
        lowest_guid = "party4"
    end

    if check == "HP" then
        return lowest_percent
    elseif check == "UnitID" then
        return lowest_guid
    end
end

function IsReady(spell,range_check,aoe_check,queue,no_power_check)

    if spell and C_Spell.IsSpellUsable(tostring(spell)) then
        local start = C_Spell.GetSpellCooldown(tostring(spell)).startTime
        local duration = C_Spell.GetSpellCooldown(tostring(spell)).duration
        local enabled = C_Spell.GetSpellCooldown(tostring(spell)).isEnabled
        local usable, noMana = C_Spell.IsSpellUsable(tostring(spell))
        local range_counter = 0
        local in_range = false

        if range_check then
            for lActionSlot = 1, 120 do
                local lActionText = GetActionTexture(lActionSlot)
                local icon = C_Spell.GetSpellInfo(tostring(spell)).iconID
                --local name, rank, icon, castTime, minRange, maxRange, spellID, originalIcon = C_Spell.GetSpellInfo(tostring(spell))
                if lActionText == icon then
                    if UnitExists("target") then
                        in_range = IsActionInRange(lActionSlot,"target")
                        break
                    end
                end
            end
        end

        if duration and start then 
            cooldown_remains = tonumber(duration) - (GetTime() - tonumber(start))
            --gcd_remains = 1.5 / (GetHaste() + 1) - (GetTime() - tonumber(start))
        end

        if cooldown_remains and cooldown_remains < 0 then 
            cooldown_remains = 0 
        end
        
        -- if gcd_remains and gcd_remains < 0 then 
            -- gcd_remains = 0 
        -- end

        if aoe_check then
            if Spell then
                for i = 1, 40 do
                    local unitID = "nameplate" .. i
                    if UnitExists(unitID) then           
                        local nameplate_guid = UnitGUID(unitID) 
                        local npc_id = select(6, strsplit("-", nameplate_guid))
                        if npc_id ~= '120651' and npc_id ~= '161895' then
                            if UnitCanAttack("player", unitID) and C_Spell.IsSpellInRange(Spell, unitID) and UnitHealthMax(unitID) > 5 then
                                range_counter = range_counter + 1
                            end                    
                        end
                    end
                end
            end
        end

        --if usable and enabled and cooldown_remains - gcd_remains < 0.5 and gcd_remains < 0.5 then
        if (usable or no_power_check) and enabled and (cooldown_remains < 0.5 or (queue and cooldown_remains < 1.5)) and spell ~= 1 then
            if range_check then
                if in_range == true then 
                    return true
                else
                    return false
                end
            elseif aoe_check and not range_check then
                if range_counter >= aoe_check then
                    return true
                else
                    return false
                end
            elseif range_check and aoe_check then
                return 'Input range check or aoe check, not both'
            elseif not range_check and not aoe_check then
                return true
            end
        else
            return false
	    end
    else
        return false
    end
end


function GetNumDebuffs(unit)
    local index = 1
    local numDebuffs = 0

    while true do
        local aura = C_UnitAuras.GetDebuffDataByIndex(unit, index)
        if not aura then
            break
        end
        numDebuffs = numDebuffs + 1
        index = index + 1
    end

    return numDebuffs
end

function GetAppropriateCureSpell(unit)
    local debuffTypePoison = "Poison"
    local debuffTypeDisease = "Disease"
	local debuffTypeMagic = "Magic"
    local debuffTypeCurse = "Curse"

    local debuff_count = GetNumDebuffs(unit)

    for i = 1, debuff_count do
        local debuffType = C_UnitAuras.GetDebuffDataByIndex(tostring(unit), i).dispelName
        --if not debuffType then break end  -- No more debuffs, exit the loop
        local name = C_UnitAuras.GetDebuffDataByIndex(tostring(unit), i).name
        --if not name then break end  -- No more debuffs, exit the loop

        if debuffType == debuffTypePoison then
            return debuffTypePoison
        elseif debuffType == debuffTypeDisease then
            return debuffTypeDisease
        elseif debuffType == debuffTypeMagic then
            return debuffTypeMagic
        elseif debuffType == debuffTypeCurse then
            return debuffTypeCurse
        end
    end
 
    return nil  -- No poison or disease found
end



function tierequipped()
    local items = {
        "Lurking Specter's Tights",
        "Lurking Specter's Brigandine",
        "Lurking Specter's Handgrips",
        217207, -- "Lurking Specter's Handgrips"
        "Lurking Specter's Shoulderblades",
        "Lurking Specter's Visage",
        "Heartfire Sentinel's Forgehelm",
        "Heartfire Sentinel's Steelwings",
        "Heartfire Sentinel's Brigandine",
        "Heartfire Sentinel's Protectors",
        "Heartfire Sentinel's Faulds",
        "Lucid Shadewalker's Clawgrips",
        "Lucid Shadewalker's Chausses",
        "Lucid Shadewalker's Cuirass",
        "Lucid Shadewalker's Bladed Spaulders",
        "Lucid Shadewalker's Deathmask",

    }

    local count = 0

    for _, itemName in ipairs(items) do
        if C_Item.IsEquippedItem(itemName) then
            count = count + 1
        end
    end

    return count
end



function tierequipped30()
    local items = {

        "Zealous Pyreknight's Ailettes",
        "Zealous Pyreknight's Barbute",
        "Zealous Pyreknight's Jeweled Guantlets",
        "Zealous Pyreknight's Warplate",
        "Zealous Pyreknight's Cuisses",

    }

    local count = 0

    for _, itemName in ipairs(items) do
        if C_Item.IsEquippedItem(itemName) then
            count = count + 1
        end
    end

    return count
end



function mitigatedng()
    if Player:AffectingCombat() then
        for id = 1, 10 do
            local spell = {
"Rigorous Jab","Brutal Jab", "Savage Flurry","Blazing Strike",
"Terrifying Slam","Anima Slash","Shred Armor","Triple Bite","Mutilate",
"Brutal Strike","Lava Fist","Shadowflame Slash","Charged Shield",
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



function blessingofsacrificefocus()
    if Player:AffectingCombat() then
        for id = 1, 10 do
            local spell = {"Putrid Waters", "Fiery Ricochet","Silenced Speaker" ,"Earth Shatterer","Smash Rock", "Ground Pound","Commanding Roar","Rock Spike",
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



function magicdefensives()
    if Player:AffectingCombat() then
        for id = 1, 10 do
            local spell = {"Terrifying Roar","Cosmic Singularity" ,"Obsidian Beam" ,"Repulsive Visage" ,"Process of Elimination","Honey Marinade","Oblivion Wave",

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




function stunprio()
    local stunspells = {
        'Alarm Shrill','Toxic Trap','Bone Bolt','Vicious Clawmangle','Infuse Corruption','Summon Lashers','Decaying Roots','Screech','Bloody Bite','Rotting Surge', --BRH
        'Spiked Carapace','Chain Lightning','Earthen Ward','Curse of Stone','Sonic Burst','Hasten','Throw Rock','Cleave','Hail of Stone','Time Blade',--Uldaman
        'Seismic Slam','Expulse','Demoralizing Shout','Spear Flurry','Elemental Focus','Dazzle','Ice Shard','Refreshing Tide','Thunderstrike','Boiling Rage','Tidal Divergence', --HoI
        'Chronomelt','Infinite Bolt','Enervate','Infinite Bolt Volley','Stonebolt','Pulverizing Creations','Binding Grasp','Displace Chronosequence',
        'Dizzying Sands','Time Beam','Rocket Bolt Volley',--DotI
        'Mystic Blast', 'Monotonous Lecture', 'Arcane Missiles', 'Astral Bomb','Astral Whirlwind',   -- AA
        'Tectonic Slam','Ice Shield','Cold Claws','Burning Ambition','Flame Dance','Thunderclap',       --RLP
        'Piercing Shards','Arcane Fury','Mystic Vapors','Waking Bane','Condensed Frost','Icy Bindings','Ice Cutter','Unstable Power','Tear Flesh','Null Stomp', --AV
        'Storm Bolt','Pierce','Swift Stab','Rally the Clan',"Hunter's Mark",'Hunt Prey','Arcing Strike','Tempest','Summon Squall','Necrotic Eruption','Rotting Wind','Mortal Strike','Swift Wind','Deadly Thunder', -- NO
        'Brutal Strike','Molten Core','Magma Conflagration','Explosive Concoction','Binding Spear','Magma Fist','Fired Up','Bone Toss','Mending Clay','Scorching Breath','Mote of Combustion','Pierce Marrow','Dragonbone Axe', -- neltharus
    "Wind Up","Plant Seaforium Charge","Snipe","Reload","Surpise Inspection","Jettison Kelp","Fan of Knives","Activate Mech",
    "Boiling Flames","Rejuvenating Honey","Free Samples?","Honey Volley","Mole Frenzy","Wicklighter Bolt","Explosive Flame","Flame Bolt",
"Flaming Tether","Paranoid Mind","Drain Light","Detonate","Giga-Wallop","Tune Up","Greater Heal","Inner Fire","Fireball","Repentance",
"Battle Cry","Cinderblast","Fireball Volley","Embrace the Light","Surveying Beam","Harpoon","Trickshot","Blood Blast","Bloodthirsty Cackle",
"Maximum Distortion","Restorative Algae","Lightning Bolt","Unholy Fervor","Bind Soul","Bone Spear","Necrotic Bolt Volley",
"Necrotic Bolt","Meat Shield","Decaying Filth","Demoralizing Shout","Death Bolt","Iced Spritzer","Toxic Blades","Rock Lance","Furious Quake",
"Tectonic Barrier","Caustic Compound","Transmute","Lightning Bolt","Lightning Surge","Void Bolt",	
    
    }
    
    local currentspellchannel = select(1,UnitChannelInfo('target'))
    local currentspellcast = select(1, UnitCastingInfo('target'))
    
    for i = 1, #stunspells do
        if currentspellcast == stunspells[i] or currentspellchannel == stunspells[i] then
            if UnitName("target") ~= "Sister Briar" and UnitName("target") ~= "Lady Naz'jar" and UnitName("target") ~= "Sister Malady" and UnitName("target") ~= "Sister Solena" then
                return true
            end
        end
    end
    
    return false
end

function blindprio()
    local blindspells = {
        'Alarm Shrill','Toxic Trap','Bone Bolt','Vicious Clawmangle','Infuse Corruption','Summon Lashers','Decaying Roots','Screech','Bloody Bite','Rotting Surge', --BRH
        'Spiked Carapace','Chain Lightning','Earthen Ward','Curse of Stone','Sonic Burst','Hasten','Throw Rock','Cleave','Hail of Stone','Time Blade',--Uldaman
        'Seismic Slam','Expulse','Demoralizing Shout','Spear Flurry','Elemental Focus','Dazzle','Ice Shard','Refreshing Tide','Thunderstrike','Boiling Rage','Tidal Divergence', --HoI
        'Chronomelt','Infinite Bolt','Enervate','Infinite Bolt Volley','Stonebolt','Pulverizing Creations','Binding Grasp','Displace Chronosequence',
        'Dizzying Sands','Time Beam','Rocket Bolt Volley',--DotI
        'Mystic Blast', 'Monotonous Lecture', 'Arcane Missiles', 'Astral Bomb','Astral Whirlwind',   -- AA
        'Tectonic Slam','Ice Shield','Cold Claws','Burning Ambition','Flame Dance','Thunderclap',       --RLP
        'Piercing Shards','Arcane Fury','Mystic Vapors','Waking Bane','Condensed Frost','Icy Bindings','Ice Cutter','Unstable Power','Tear Flesh','Null Stomp', --AV
        'Storm Bolt','Pierce','Swift Stab','Rally the Clan',"Hunter's Mark",'Hunt Prey','Arcing Strike','Tempest','Summon Squall','Necrotic Eruption','Rotting Wind','Mortal Strike','Swift Wind','Deadly Thunder', -- NO
        'Brutal Strike','Molten Core','Magma Conflagration','Explosive Concoction','Binding Spear','Magma Fist','Fired Up','Bone Toss','Mending Clay','Scorching Breath','Mote of Combustion','Pierce Marrow','Dragonbone Axe', -- neltharus
    "Jagged Quarrel","Corrosive Gunk","Fiery Jaws","Defend", "Wind Up","Plant Seaforium Charge","Snipe","Reload","Surpise Inspection","Jettison Kelp","Fan of Knives","Activate Mech",
    "Boiling Flames","Rejuvenating Honey","Free Samples?","Honey Volley","Mole Frenzy","Wicklighter Bolt","Explosive Flame","Flame Bolt",
"Flaming Tether","Paranoid Mind","Drain Light","Detonate","Giga-Wallop","Tune Up","Greater Heal","Inner Fire","Fireball","Repentance",
"Battle Cry","Cinderblast","Fireball Volley","Embrace the Light","Surveying Beam","Harpoon","Trickshot","Blood Blast","Bloodthirsty Cackle",
"Maximum Distortion","Restorative Algae","Lightning Bolt","Unholy Fervor","Bind Soul","Bone Spear","Necrotic Bolt Volley",
"Necrotic Bolt","Meat Shield","Decaying Filth","Demoralizing Shout","Death Bolt","Iced Spritzer","Toxic Blades","Rock Lance","Furious Quake",
"Tectonic Barrier","Caustic Compound","Transmute","Lightning Bolt","Lightning Surge","Void Bolt",	
    }
        
    local currentspellchannel = select(1,UnitChannelInfo('target'))
    local currentspellcast = select(1, UnitCastingInfo('target'))
        
    for i = 1, #blindspells do
        if currentspellcast == blindspells[i] or currentspellchannel == blindspells[i] then
            if UnitName("target") ~= "Sister Briar" and UnitName("target") ~= "Lady Naz'jar" and UnitName("target") ~= "Sister Malady" and UnitName("target") ~= "Sister Solena" then
                return true
            end
        end
    end
  
    return false
end

function kickprio()
    local KickSpells = {
"Resonant Barrage",	"Web Bolt",	"Horrifying Shrill",	"Poison Bolt", "Silken Restraints",	"Revolting Volley",	"Venom Volley",	"Bloodstained Webmage",	"Web Bolt",	"Silk Binding",	"Twist Thoughts",	"Grimweave Blast",	
"Mending Web",	"Void Wave",	"Void Bolt",	"Night Bolt",	"Ensnaring Shadows",	"Abyssal Howl",	"Tormenting Beam",	"Umbral Barrier",	"Congealed Shadow",	"Silken Shell",	"Night Bolt",	"Shadow Bolt",	"Animate Shadows",	
"Acidic Eruption",	"Arcing Void",	"Howling Fear",	"Alloy Bolt",	"Restoring Metals",	"Piercing Wail",	"Censoring Gear",	"Stone Bolt",	"Molten Metal",	"Spirit Bolt",	"Harvest Essence",	"Bramblethorn Coat",	"Nourish the Forest",	
"Stimulate Resistance",	"Stimulate Regeneration",	"Spirit Bolt",	"Patty Cake",	"Consumption",	"Drain Fluids",	"Frostbolt",	"Bonemend",	"Rasping Scream",	"Necrotic Bolt",	
"Drain Fluids",	"Goresplatter",	"Drain Fluids",		"Enfeeble",	"Watertight Shell",	"Brackish Bolt",	"Bolstering Shout",	"Stinky Vomit",	"Water Bolt",	"Choking Waters",	"Earth Bolt",	"Mass Tremor",	"Shadowflame Bolt",	"Sear Mind",	
"Shadowflame Bolt",	"Shadowflame Bolt",	
"Boiling Flames","Rejuvenating Honey","Free Samples?","Honey Volley","Mole Frenzy","Wicklighter Bolt","Explosive Flame","Flame Bolt",
"Flaming Tether","Paranoid Mind","Drain Light","Detonate","Giga-Wallop","Tune Up","Greater Heal","Inner Fire","Fireball","Repentance",
"Battle Cry","Cinderblast","Fireball Volley","Embrace the Light","Surveying Beam","Harpoon","Trickshot","Blood Blast","Bloodthirsty Cackle",
"Maximum Distortion","Restorative Algae","Lightning Bolt","Unholy Fervor","Bind Soul","Bone Spear","Necrotic Bolt Volley",
"Necrotic Bolt","Meat Shield","Decaying Filth","Demoralizing Shout","Death Bolt","Iced Spritzer","Toxic Blades","Rock Lance","Furious Quake",
"Tectonic Barrier","Caustic Compound","Transmute","Lightning Bolt","Lightning Surge","Void Bolt",									
    }
    local currentspellchannel = select(1,UnitChannelInfo('target'))
    local currentspellcast = select(1, UnitCastingInfo('target'))
    
    for i = 1, #KickSpells do
        if currentspellcast == KickSpells[i] or currentspellchannel == KickSpells[i] then
            return true
        end
    end
    
    return false
end

-- local initialTotalMaxHealth = 0
-- local combatStartTime = 0
-- local inCombat = false

-- local function getTotalHealthOfCombatMobs()
--     local totalMaxHealth = 0
--     local totalCurrentHealth = 0

--     for i = 1, 40 do
--         local unitID = "nameplate" .. i
--         if UnitExists(unitID) and UnitCanAttack("player", unitID) and UnitAffectingCombat(unitID) then
--             totalMaxHealth = totalMaxHealth + UnitHealthMax(unitID)
--             totalCurrentHealth = totalCurrentHealth + UnitHealth(unitID)
--         end
--     end

--     return totalMaxHealth, totalCurrentHealth
-- end

-- -- Event Frame for tracking combat state
-- local eventFrame = CreateFrame("Frame")
-- eventFrame:RegisterEvent("PLAYER_REGEN_DISABLED") -- Player enters combat
-- eventFrame:RegisterEvent("PLAYER_REGEN_ENABLED") -- Player leaves combat

-- eventFrame:SetScript("OnEvent", function(_, event)
--     if event == "PLAYER_REGEN_DISABLED" then
--         inCombat = true
--         combatStartTime = GetTime()
--         initialTotalMaxHealth, _ = getTotalHealthOfCombatMobs()
--     elseif event == "PLAYER_REGEN_ENABLED" then
--         inCombat = false
--     end
-- end)

-- function getCurrentDPS()
--     if inCombat and combatStartTime > 0 then
--         local totalMaxHealth, totalCurrentHealth = getTotalHealthOfCombatMobs()
--         if totalMaxHealth > initialTotalMaxHealth then
--             initialTotalMaxHealth = totalMaxHealth
--         end

--         local totalDamageDone = initialTotalMaxHealth - totalCurrentHealth
--         local combatDuration = GetTime() - combatStartTime
--         return math.max(0, totalDamageDone / combatDuration)
--     else
--         return 0
--     end
-- end

-- function aoeTTD()
--     local currentDPS = getCurrentDPS()
--     local totalCurrentHealth = select(2, getTotalHealthOfCombatMobs())

--     if currentDPS and currentDPS > 0 then
--         local TTD = totalCurrentHealth / currentDPS
--         return TTD
--     else
--        return 8888
--     end
-- end







local initialTotalMaxHealth = 0
local combatStartTime = 0
local inCombat = false
local historicalDPS = {}

local function addToHistoricalDPS(dps)
    table.insert(historicalDPS, dps)
    if #historicalDPS > 5 then
        table.remove(historicalDPS, 1)
    end
end

local function getAverageHistoricalDPS()
    if #historicalDPS == 0 then
        return nil
    end
    local sum = 0
    for _, d in ipairs(historicalDPS) do
        sum = sum + d
    end
    return sum / #historicalDPS
end

local function getTotalHealthOfCombatMobs()
    local totalMaxHealth = 0
    local totalCurrentHealth = 0

    for i = 1, 40 do
        local unitID = "nameplate" .. i
        if UnitExists(unitID) and UnitCanAttack("player", unitID) and UnitAffectingCombat(unitID) then
            totalMaxHealth = totalMaxHealth + UnitHealthMax(unitID)
            totalCurrentHealth = totalCurrentHealth + UnitHealth(unitID)
        end
    end

    return totalMaxHealth, totalCurrentHealth
end

local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("PLAYER_REGEN_DISABLED")
eventFrame:RegisterEvent("PLAYER_REGEN_ENABLED")

eventFrame:SetScript("OnEvent", function(_, event)
    if event == "PLAYER_REGEN_DISABLED" then
        inCombat = true
        combatStartTime = GetTime()
        initialTotalMaxHealth, _ = getTotalHealthOfCombatMobs()
    elseif event == "PLAYER_REGEN_ENABLED" then
        inCombat = false
        if combatStartTime > 0 then
            local totalMaxHealth, totalCurrentHealth = getTotalHealthOfCombatMobs()
            local totalDamageDone = initialTotalMaxHealth - totalCurrentHealth
            local combatDuration = GetTime() - combatStartTime
            if combatDuration > 0 and totalDamageDone > 0 then
                local pullDPS = totalDamageDone / combatDuration
                addToHistoricalDPS(pullDPS)
            end
            combatStartTime = 0
            initialTotalMaxHealth = 0
        end
    end
end)

function getCurrentDPS()
    if inCombat and combatStartTime > 0 then
        local totalMaxHealth, totalCurrentHealth = getTotalHealthOfCombatMobs()
        if totalMaxHealth > initialTotalMaxHealth then
            initialTotalMaxHealth = totalMaxHealth
        end

        local totalDamageDone = initialTotalMaxHealth - totalCurrentHealth
        local combatDuration = GetTime() - combatStartTime
        return math.max(0, totalDamageDone / combatDuration)
    else
        return 0
    end
end

function aoeTTD()
    if not inCombat then
        return 8888
    end

    local currentDPS = getCurrentDPS()
    local totalCurrentHealth = select(2, getTotalHealthOfCombatMobs())

    if currentDPS > 0 then
        local TTD = totalCurrentHealth / currentDPS
        return TTD
    else
        local avgDPS = getAverageHistoricalDPS()
        if avgDPS then
            local TTD = totalCurrentHealth / avgDPS
            return TTD
        else
            return 8888
        end
    end
end



function GetFocusTargetHealthPercentage()
    if UnitExists("focus") then
        local health = UnitHealth("focus")
        local maxHealth = UnitHealthMax("focus")
        if maxHealth == 0 then
            return 0
        else
            return (health / maxHealth) * 100
        end
    else
        return nil -- No focus target
    end
end

function mitigateboss()
    if Player:AffectingCombat() then
        for id = 1, 40 do
            local spell = {
"Reaping Scythe",	"Hateful Strike",	"Keg Smash",	"Bottoms Uppercut",	"Cash Cannon",	"Electrocrush",	"Wallop",	"Sludge Claws",	
"Thunder Punch",	"Seismic Smash", "Slam","Oblivion Wave",
	"Igneous Hammer",	"Crystalline Smash",	"Crunch",	"Sever Flesh",	"Skullsplitter",	"Molten Flurry",	"Shadowflame Bolt",	
    "Crush", "Mutilate", 

            }
            local unitID = "nameplate" .. id
            local name, text, texture, startTimeMS, endTimeMS, isTradeSkill, castID, notInterruptible, spellId = UnitCastingInfo(unitID)
            -- local spellName, _, _, startTimeMS, endTimeMS = UnitChannelInfo(unitID)
    
            for idx = 1, #spell do
                if UnitCanAttack("player", unitID) and name == spell[idx] then
                    return true
                end
            end
        end
    end
    return false
end

function freedom()
    if Player:AffectingCombat() then
        for id = 1, 10 do
            local spell = { "Grasping Slash","Bursting Cocoon","Ground Pound","Bramble Burst", "Reaping Winds","Mass Tremor","Curse of Entropy", }
            local unitID = "nameplate" .. id
            local name, text, texture, startTimeMS, endTimeMS, isTradeSkill, castID, notInterruptible, spellId = UnitCastingInfo(unitID)
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





-- function combatmobs40()
--     local totalRange40 = 0
   
--     for id = 1, 10 do
--         local unitID = "nameplate" .. id
--         if UnitCanAttack("player", unitID) and C_Item.IsItemInRange(28767, unitID)
--             and UnitHealthMax(unitID) > 5 and UnitAffectingCombat(unitID) then
--             totalRange40 = totalRange40 + 1
--         end
--     end

--     return totalRange40
-- end




function UseItems(item)
    local trinket1 = GetInventoryItemID("player", 13)
    local trinket2 = GetInventoryItemID("player", 14)
    local trinket1ready = C_Item.IsUsableItem(trinket1) and C_Item.IsEquippedItem(trinket1) and select(2,C_Item.GetItemCooldown(trinket1)) < 1.5
    local trinket2ready = C_Item.IsUsableItem(trinket2) and C_Item.IsEquippedItem(trinket2) and select(2,C_Item.GetItemCooldown(trinket2)) < 1.5
    local trinketblacklist = 202612


    if trinket1ready and trinket1 ~= trinketblacklist then
        return Item(118330):Cast()
    end

    if trinket2ready and trinket2ready ~= trinketblacklist then
        return Item(114616):Cast()
    end
	
	return nil
end








function MissingHealth(healthPercent,without_virtue)
    if healthPercent then
        check = 
        num(C_Spell.IsSpellInRange("Flash of Light","player") and ((UnitHealth("player") / UnitHealthMax("player")) * 100) <= healthPercent and (not AuraUtil.FindAuraByName("Beacon of Virtue", "player") or not without_virtue)) +
        num(C_Spell.IsSpellInRange("Flash of Light","party1") and ((UnitHealth("party1") / UnitHealthMax("party1")) * 100) <= healthPercent and (not AuraUtil.FindAuraByName("Beacon of Virtue", "party1") or not without_virtue)) +
        num(C_Spell.IsSpellInRange("Flash of Light","party2") and ((UnitHealth("party2") / UnitHealthMax("party2")) * 100) <= healthPercent and (not AuraUtil.FindAuraByName("Beacon of Virtue", "party2") or not without_virtue)) +
        num(C_Spell.IsSpellInRange("Flash of Light","party3") and ((UnitHealth("party3") / UnitHealthMax("party3")) * 100) <= healthPercent and (not AuraUtil.FindAuraByName("Beacon of Virtue", "party3") or not without_virtue)) +
        num(C_Spell.IsSpellInRange("Flash of Light","party4") and ((UnitHealth("party4") / UnitHealthMax("party4")) * 100) <= healthPercent and (not AuraUtil.FindAuraByName("Beacon of Virtue", "party4") or not without_virtue))
    else
        check = 0
    end
    
    return check
end



-- Create a table to hold the spell cast tracking data and functions
SpellCastTracker = {}
local spellStartTime = {}

local previousTarget = nil

-- Function to check if the spell can be cast considering the tolerance
function SpellCastTracker.CanCastSpellWithTolerance(spellName, tolerance)
    local currentTime = GetTime()
    if spellStartTime[spellName] then
        local timeSinceLastCast = currentTime - spellStartTime[spellName]
        -- print("Time since last cast of " .. spellName .. ": " .. timeSinceLastCast) -- Debug print
        if timeSinceLastCast > tolerance then
            return true
        else
            return false
        end
    else
        return true -- Allow casting if the spell has never been cast
    end
end

-- Event handler function
local function OnEvent(self, event, unit, _, spellID)
    if unit == "player" then
        local spellName = C_Spell.GetSpellInfo(spellID).name
        if event == "UNIT_SPELLCAST_START" then
            spellStartTime[spellName] = GetTime()
            -- print("Spell started: " .. spellName .. " at " .. spellStartTime[spellName]) -- Debug print
        elseif event == "UNIT_SPELLCAST_INTERRUPTED" then
            spellStartTime[spellName] = nil -- Reset the start time when the spell cast is interrupted
            -- print("Spell interrupted: " .. spellName) -- Debug print
        end
    end
    

end

-- Create a frame to listen for relevant events
local frame = CreateFrame("Frame")
frame:RegisterEvent("UNIT_SPELLCAST_START")
frame:RegisterEvent("PLAYER_TARGET_CHANGED")
frame:RegisterEvent("UNIT_SPELLCAST_INTERRUPTED")
frame:SetScript("OnEvent", OnEvent)

-- Global function to check if a spell can be cast with tolerance
function CanCastWithTolerance(spellName)
    local castTime = (C_Spell.GetSpellInfo(spellName).castTime) * 0.001 -- Convert from milliseconds to seconds
    return SpellCastTracker.CanCastSpellWithTolerance(spellName, castTime + 0.5)
end






function TWWS1AffixMobsInRange()
	local range_counter = 0
		


			for i=1,10 do
				local unitID = "nameplate" .. i
				if UnitExists("nameplate"..i) then           
					local nameplate_guid = UnitGUID("nameplate"..i) 
				
						if UnitCanAttack("player",unitID) and C_Item.IsItemInRange(32321, unitID) and UnitName(unitID) == "Orb of Ascendance" then
							range_counter = range_counter + 1
						                    
					end
         			end
			end
	

	return range_counter
end










local HPGCount = 0

-- Table to store Holy Power-generating spells with their respective Holy Power gains
local HolyPowerSpells = {
    [387174] = 3,  -- Eye of Tyr generates 3 Holy Power
    [275779] = 1,  -- Judgment generates 1 Holy Power
    [24275]  = 1,  -- Hammer of Wrath generates 1 Holy Power
    [204019] = 1,  -- Blessed Hammer generates 1 Holy Power
}



-- Function to initialize the tracking of Holy Power generation
function InitializeHPGTracking()
    -- Reset Holy Power count
    HPGCount = 0

    -- Register event to track Holy Power gains from spell casts
    HL:RegisterForSelfCombatEvent(
        function(...)
            local SpellID = select(12, ...)  -- Get the SpellID from the event
            if HolyPowerSpells[SpellID] then
                HPGCount = HPGCount + HolyPowerSpells[SpellID]
            end
        end,
        "SPELL_CAST_SUCCESS"
    )

    -- Register event to reset Holy Power if needed (e.g., when a specific buff is applied)
    HL:RegisterForSelfCombatEvent(
        function(...)
            local SpellID = select(12, ...)
            if SpellID == 385127 then  -- Example: Reset Holy Power on specific SpellID (if needed)
                HPGCount = 0
            end
        end,
        "SPELL_AURA_APPLIED", "SPELL_AURA_APPLIED_DOSE"
    )
end

-- Function to get the current Holy Power count
function GetCurrentHPGCount()
    return HPGCount
end

-- Initialize the event tracking at the start
InitializeHPGTracking()



-- Global variables to store the health loss per second and the ticker reference
local healthLossPerSecond = 0 
local healthLossTicker = nil -- Stores the ticker reference

-- Function to start tracking health loss per second
function TrackHealthLossPerSecond()
    -- If a ticker already exists, don't create another one
    if healthLossTicker then
        return
    end

    local previousHealth = UnitHealth("player")
    local previousTime = GetTime()

    healthLossTicker = C_Timer.NewTicker(1, function(ticker)
        -- Cancel the ticker if the player is not in combat
        if not UnitAffectingCombat("player") then
            ticker:Cancel()
            healthLossTicker = nil -- Release the reference to the ticker
            healthLossPerSecond = 0 -- Reset the health loss to 0
            return
        end

        local currentHealth = UnitHealth("player")
        local currentTime = GetTime()

        -- Calculate time elapsed since last tick
        local timeElapsed = currentTime - previousTime
        local healthLost = previousHealth - currentHealth

        -- If no damage is taken, reset the health loss per second to 0
        if healthLost <= 0 then
            healthLossPerSecond = 0
        else
            -- Only calculate health loss if health has actually reduced
            if timeElapsed > 0 then
                healthLossPerSecond = (healthLost / UnitHealthMax("player")) * 100 / timeElapsed
            end
        end

        -- Update previous values for the next tick
        previousHealth = currentHealth
        previousTime = currentTime
    end)
end

-- Function to stop tracking health loss manually, if needed
function StopHealthLossTracking()
    if healthLossTicker then
        healthLossTicker:Cancel()
        healthLossTicker = nil -- Ensure the reference is cleared to prevent leaks
        healthLossPerSecond = 0 -- Reset health loss when stopped
    end
end

-- Function to get the health loss per second at any time
function GetHealthLossPerSecond()
    return healthLossPerSecond
end











-- Global variable to store the time counter
local rangeTimer = 0
local timerRunning = false
local ticker -- To prevent multiple tickers from running

-- Function to check if the target is in 5-yard range and manage the timer
function TrackRangeTimer()
    -- Check if the target is within 5 yards
    if IsItemInRange(8149, "target") then
        if not timerRunning then
            -- Start a new timer if not already running
            timerRunning = true
            rangeTimer = 0 -- Reset the timer to 0 when starting
            StartTimer()
        end
    else
        -- If the target is out of range, reset the timer
        StopTimer()
    end
end

-- Function to start counting up the timer
function StartTimer()
    -- Stop any existing ticker to avoid overlaps
    if ticker then
        ticker:Cancel()
    end

    -- Create a new ticker that increases the timer every second
    ticker = C_Timer.NewTicker(0.1, function()
        rangeTimer = rangeTimer + 0.1
        -- print("Target is in range for: " .. rangeTimer .. " seconds")
    end)
end

-- Function to stop the timer and reset it when the target is out of range
function StopTimer()
    if ticker then
        ticker:Cancel() -- Stop the ticker
        ticker = nil
    end
    timerRunning = false
    rangeTimer = 0
    -- print("Target is out of range, timer reset to 0")
end

-- Function to get the current range timer value
function GetRangeTimer()
    return rangeTimer
end

-- Create a frame to check the range periodically
local rangeCheckFrame = CreateFrame("Frame")
rangeCheckFrame:SetScript("OnUpdate", function(self, elapsed)
    TrackRangeTimer()
end)






-- Table for Death and Decay tracking
local DnDTable = {}

-- Table for Bonestorm tracking
local BonestormTable = {}

-- Function to check if Death and Decay is ticking
function IsDnDTicking()
    if next(DnDTable) == nil then
        return false
    end

    local isTicking = false
    for TarGUID, LastTick in pairs(DnDTable) do
        if GetTime() - LastTick < 1.25 then
            isTicking = true
        end
    end

    if isTicking and Player:BuffUp(SpellBlood.DeathAndDecayBuff) then
        return true
    end

    return false
end

-- Function to check if Bonestorm is ticking
function IsBonestormTicking()
    if next(BonestormTable) == nil then
        return false
    end

    for TarGUID, LastTick in pairs(BonestormTable) do
        if GetTime() - LastTick < 1.25 then
            return true
        end
    end

    return false
end



-- If you want to add them to HL (assuming HL is your framework):
HL.AddCoreOverride("Player.DnDTicking", IsDnDTicking, 250)
HL.AddCoreOverride("Player.BonestormTicking", IsBonestormTicking, 250)















-- Table to store GUIDs of mobs in combat with the player or party members
local mobsInCombat = {}

-- Function to extract NPC ID from a GUID (optional for debugging or advanced tracking)
local function GetNPCIDFromGUID(guid)
    local type, _, _, _, _, npcID = strsplit("-", guid)
    if type == "Creature" or type == "Vehicle" then
        return tonumber(npcID)
    end
    return nil
end

-- Function to handle combat log events
local function OnCombatLogEvent(self, event)
    local _, subEvent, _, sourceGUID, sourceName, _, _, destGUID, destName = CombatLogGetCurrentEventInfo()
    local playerGUID = UnitGUID("player")

    -- Check if the event is a relevant combat event involving you or your party
    if (subEvent == "SWING_DAMAGE" or subEvent == "SWING_MISSED" or subEvent == "SPELL_DAMAGE" 
       or subEvent == "SPELL_MISSED" or subEvent == "SPELL_PERIODIC_DAMAGE" or subEvent == "SPELL_PERIODIC_MISSED") then

        -- Prevent adding dead mobs back into the list and ensure we're only adding live mobs
        if subEvent ~= "UNIT_DIED" then
            if (UnitInParty(sourceName) or UnitInRaid(sourceName) or sourceGUID == playerGUID) and not mobsInCombat[destGUID] then
                mobsInCombat[destGUID] = GetTime()
                -- print("Added mob to combat: " .. destGUID .. " (NPC ID: " .. (GetNPCIDFromGUID(destGUID) or "Unknown") .. ")")
            elseif (UnitInParty(destName) or UnitInRaid(destName) or destGUID == playerGUID) and not mobsInCombat[sourceGUID] then
                mobsInCombat[sourceGUID] = GetTime()
                -- print("Added mob to combat: " .. sourceGUID .. " (NPC ID: " .. (GetNPCIDFromGUID(sourceGUID) or "Unknown") .. ")")
            end
        end

    elseif subEvent == "UNIT_DIED" then
        -- Remove the mob's GUID when it dies
        if mobsInCombat[destGUID] then
            -- print("Removing mob from combat (died): " .. destGUID .. " (NPC ID: " .. (GetNPCIDFromGUID(destGUID) or "Unknown") .. ")")
            mobsInCombat[destGUID] = nil
        end
    end
end

-- Function to reset mobs when combat ends (e.g., player leaves combat)
local function OnPlayerRegenEnabled(self, event)
    mobsInCombat = {}
    -- print("Player left combat. Resetting mobs in combat.")
end

-- Create a frame to listen for relevant events
local frame = CreateFrame("Frame")
frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
frame:RegisterEvent("PLAYER_REGEN_ENABLED")  -- Triggered when the player leaves combat
frame:SetScript("OnEvent", function(self, event, ...)
    if event == "COMBAT_LOG_EVENT_UNFILTERED" then
        OnCombatLogEvent(self, event, ...)
    elseif event == "PLAYER_REGEN_ENABLED" then
        OnPlayerRegenEnabled(self, event)
    end
end)

-- Function to get the number of mobs in combat
function GetMobsInCombat()
    local numMobsInCombat = 0

    for guid, _ in pairs(mobsInCombat) do
        numMobsInCombat = numMobsInCombat + 1
    end

    return numMobsInCombat
end





local frame = CreateFrame("Frame")
frame:RegisterEvent("UNIT_HEALTH")
frame:RegisterEvent("PLAYER_FOCUS_CHANGED")

local focusDeathTime
local isFocusDead = false
local currentFocusGUID

frame:SetScript("OnEvent", function(self, event, unit)
    if event == "UNIT_HEALTH" then
        if unit == "focus" then
            if UnitIsDead("focus") then
                if not isFocusDead then
                    isFocusDead = true
                    focusDeathTime = GetTime()
                end
            else
                if isFocusDead then
                    isFocusDead = false
                    focusDeathTime = nil
                end
            end
        end
    elseif event == "PLAYER_FOCUS_CHANGED" then
        if UnitExists("focus") then
            local newGUID = UnitGUID("focus")
            if newGUID ~= currentFocusGUID then
                currentFocusGUID = newGUID
                if UnitIsDead("focus") then
                    isFocusDead = true
                    focusDeathTime = GetTime()
                else
                    isFocusDead = false
                    focusDeathTime = nil
                end
            end
        else
            currentFocusGUID = nil
            isFocusDead = false
            focusDeathTime = nil
        end
    end
end)

function timesincefocusdeath()
    if focusDeathTime then
        return GetTime() - focusDeathTime
    else
        return 0
    end
end


















