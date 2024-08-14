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
			input = 835
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

function mitigate()
    if Player:AffectingCombat() then
        for id = 1, 10 do
            local spell = {
                'Explosive Brand',--AV
                'Static Surge', 'Hailstorm', "Tempest's Fury", 'Deep Chill', 'Overpowering Croak', 'Inundate',--halls of infusion
                'Magma Eruption', 'Might of the Forge', 'Volatile Mutation', 'Candescent Tempest', -- neltharus
                'Shocking Quake', 'Crushing Stomp', 'Thunderous Clap', 'Wing Buffet',              -- Uldaman
                'Infinite Fury', 'Stonecracker Barrage',--DotI                                                                      
                'Volatile Mutation','Might of the Forge', -- Neltharus
                'Inferno', --RLP
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
        'Crushing Smash','Toxic Trap','Bone Bolt','Vicious Clawmangle','Infuse Corruption','Summon Lashers','Decaying Roots','Screech','Bloody Bite','Rotting Surge', --BRH
        'Spiked Carapace','Chain Lightning','Earthen Ward','Curse of Stone','Sonic Burst','Hasten','Throw Rock','Cleave','Hail of Stone','Time Blade',--Uldaman
        'Seismic Slam','Expulse','Demoralizing Shout','Spear Flurry','Elemental Focus','Dazzle','Ice Shard','Refreshing Tide','Thunderstrike','Boiling Rage','Tidal Divergence', --HoI
        'Chronomelt','Infinite Bolt','Enervate','Infinite Bolt Volley','Stonebolt','Pulverizing Creations','Binding Grasp','Displace Chronosequence',
        'Dizzying Sands','Time Beam','Rocket Bolt Volley',--DotI
        'Mystic Blast', 'Monotonous Lecture', 'Arcane Missiles', 'Astral Bomb','Astral Whirlwind',   -- AA
        'Tectonic Slam','Ice Shield','Cold Claws','Burning Ambition','Flame Dance','Thunderclap',       --RLP
        'Piercing Shards','Arcane Fury','Mystic Vapors','Waking Bane','Condensed Frost','Icy Bindings','Ice Cutter','Unstable Power','Tear Flesh','Null Stomp', --AV
        'Storm Bolt','Pierce','Swift Stab','Rally the Clan',"Hunter's Mark",'Hunt Prey','Arcing Strike','Tempest','Summon Squall','Necrotic Eruption','Rotting Wind','Mortal Strike','Swift Wind','Deadly Thunder', -- NO
        'Brutal Strike','Molten Core','Magma Conflagration','Explosive Concoction','Binding Spear','Magma Fist','Fired Up','Bone Toss','Mending Clay','Scorching Breath','Mote of Combustion','Pierce Marrow','Dragonbone Axe', -- neltharus
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
        'Crushing Smash','Toxic Trap','Bone Bolt','Vicious Clawmangle','Infuse Corruption','Summon Lashers','Decaying Roots','Screech','Bloody Bite','Rotting Surge', --BRH
        'Spiked Carapace','Chain Lightning','Earthen Ward','Curse of Stone','Sonic Burst','Hasten','Throw Rock','Cleave','Hail of Stone','Time Blade',--Uldaman
        'Seismic Slam','Expulse','Demoralizing Shout','Spear Flurry','Elemental Focus','Dazzle','Ice Shard','Refreshing Tide','Thunderstrike','Boiling Rage','Tidal Divergence', --HoI
        'Chronomelt','Infinite Bolt','Enervate','Infinite Bolt Volley','Stonebolt','Pulverizing Creations','Binding Grasp','Displace Chronosequence',
        'Dizzying Sands','Time Beam','Rocket Bolt Volley',--DotI
        'Mystic Blast', 'Monotonous Lecture', 'Arcane Missiles', 'Astral Bomb','Astral Whirlwind',   -- AA
        'Tectonic Slam','Ice Shield','Cold Claws','Burning Ambition','Flame Dance','Thunderclap',       --RLP
        'Piercing Shards','Arcane Fury','Mystic Vapors','Waking Bane','Condensed Frost','Icy Bindings','Ice Cutter','Unstable Power','Tear Flesh','Null Stomp', --AV
        'Storm Bolt','Pierce','Swift Stab','Rally the Clan',"Hunter's Mark",'Hunt Prey','Arcing Strike','Tempest','Summon Squall','Necrotic Eruption','Rotting Wind','Mortal Strike','Swift Wind','Deadly Thunder', -- NO
        'Brutal Strike','Molten Core','Magma Conflagration','Explosive Concoction','Binding Spear','Magma Fist','Fired Up','Bone Toss','Mending Clay','Scorching Breath','Mote of Combustion','Pierce Marrow','Dragonbone Axe', -- neltharus
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
        'Hideous Cackle','Decay Surge','Withering Burst','Earth Bolt','Infuse Corruption','Decaying Roots','Burst of Decay','Screech','Decay Surge', --BRH
        'Molten Core','Burning Roar','Mending Clay','Melt','Mote of Combustion','Lava Bolt','Molten Army', -- Neltharus
        'Expulse','Demoralizing Shout','Elemental Focus','Dazzle','Pyretic Burst','Cauterize','Refreshing Tide','Boiling Rage','Tidal Divergence','Water Bolt','Aqueous Barrier', -- HoI
        'Spiked Carapace','Stone Spike','Chain Lightning','Stone Bolt','Earthen Ward','Curse of Stone','Sonic Burst','Hasten', -- Uldaman
        'Chronomelt','Infinite Bolt','Enervate','Infinite Bolt Volley','Stonebolt','Pulverizing Creations','Binding Grasp','Displace Chronosequence',
        'Dizzying Sands','Time Beam','Rocket Bolt Volley',--DotI
        'Call of the Flock','Mana Void','Monotonous Lecture', 'Arcane Missiles','Astral Bomb',  -- AA
        'Icebolt','Ice Shield','Cold Claws','Cinderbolt','Lightning Bolt','Crackling Detonation','Thunder Bolt','Flashfire','Shock Blast',       --RLP
        'Mystic Vapors','Erratic Growth','Waking Bane','Condensed Frost','Icy Bindings', --AV
        'Storm Bolt','Disruptive Shout','Disruptive Shout','Stormbolt','Surge','Tempest','Summon Squall','Stormbolt','Thunderstrike','Death Bolt Volley','Death Bolt','Rotting Wind','Swift Wind','Bloodcurdling Shout','Deadly Thunder','Bloodcurdling Shout', -- NO
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

local initialTotalMaxHealth = 0
local combatStartTime = 0
local inCombat = false

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

-- Event Frame for tracking combat state
local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("PLAYER_REGEN_DISABLED") -- Player enters combat
eventFrame:RegisterEvent("PLAYER_REGEN_ENABLED") -- Player leaves combat

eventFrame:SetScript("OnEvent", function(_, event)
    if event == "PLAYER_REGEN_DISABLED" then
        inCombat = true
        combatStartTime = GetTime()
        initialTotalMaxHealth, _ = getTotalHealthOfCombatMobs()
    elseif event == "PLAYER_REGEN_ENABLED" then
        inCombat = false
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
    local currentDPS = getCurrentDPS()
    local totalCurrentHealth = select(2, getTotalHealthOfCombatMobs())

    if currentDPS and currentDPS > 0 then
        local TTD = totalCurrentHealth / currentDPS
        return TTD
    else
       return 8888
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

function mitigatedng()
    if Player:AffectingCombat() then
        for id = 1, 40 do
            local spell = {
            'Steel Barrage','Thunder Jaw','Fire Maw','Searing Blows', 'Stormslam',-- RLP boss
            'Savage Peck', 'Barkbreaker', --Academy boss
            'Erupting Fissure','Ice Cutter', 'Arcane Cleave','Dragon Strike',-- Azure vault boss
            'Brutalize','Rending Strike','Conductive Strike', -- NO boss
            'Decaystrike', -- BHH boss
            'Fiery Focus','Heated Swings',--neltharus boss
            'Wild Cleave', 'Sand Breath', --uldaman boss
            'Squall Buffet', --HoI
            }
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

function freedom()
    if Player:AffectingCombat() then
        for id = 1, 10 do
            local spell = { 'Crystalline Rupture','Arcane Lockdown', }
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





function combatmobs40()
    local totalRange40 = 0
   
    for id = 1, 10 do
        local unitID = "nameplate" .. id
        if UnitCanAttack("player", unitID) and C_Item.IsItemInRange(28767, unitID)
            and UnitHealthMax(unitID) > 5 and UnitAffectingCombat(unitID) then
            totalRange40 = totalRange40 + 1
        end
    end

    return totalRange40
end



