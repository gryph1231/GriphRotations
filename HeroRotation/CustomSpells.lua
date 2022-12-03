function table.removeKey(t, k)
    local i = 0
    local keys, values = {}, {}
    for k, v in pairs(t) do
        i = i + 1
        keys[i] = k
        values[i] = v
    end

    while i > 0 do
        if keys[i] == k then
            table.remove(keys, i)
            table.remove(values, i)
            break
        end
        i = i - 1
    end

    local a = {}
    for i = 1, #keys do
        a[keys[i]] = values[i]
    end

    return a
end


local HR = HeroRotation;
local HL = HeroLib;
local Cache = HeroCache;
local Unit = HL.Unit;
local Player = Unit.Player;
local Target = Unit.Target;
local Spell = HL.Spell;
local Item = HL.Item;
local Focus, MouseOver = Unit.Focus, Unit.MouseOver;
local Arena, Boss, Nameplate = Unit.Arena, Unit.Boss, Unit.Nameplate;
local Party, Raid = Unit.Party, Unit.Raid;
-- HeroLib

local Pet = Unit.Pet


local MultiSpell = HL.MultiSpell

-- Lua
local pairs = pairs
local tableinsert = table.insert
local GetTime = GetTime
-- File Locals
local PlayerSpecs = {}
local ListenedSpells = {}
local Custom = {
  Whitelist = {},
  Blacklist = {}
}
local MultiSpells = {}


HL:RegisterForSelfCombatEvent(
  function(_, _, _, _, _, _, _, _, _, _, _, SpellID)
    for i = 1, #PlayerSpecs do
      local ListenedSpell = ListenedSpells[PlayerSpecs[i]][SpellID]
      if ListenedSpell then
        ListenedSpell.LastCastTime = GetTime()
        ListenedSpell.LastHitTime = GetTime() + ListenedSpell:TravelTime()
      end
    end
  end,
  "SPELL_CAST_SUCCESS"
)

-- Pet On Cast Success Listener
HL:RegisterForPetCombatEvent(
  function(_, _, _, _, _, _, _, _, _, _, _, SpellID)
    for i = 1, #PlayerSpecs do
      local ListenedSpell = ListenedSpells[PlayerSpecs[i]][SpellID]
      if ListenedSpell then
        ListenedSpell.LastCastTime = GetTime()
        ListenedSpell.LastHitTime = GetTime() + ListenedSpell:TravelTime()
      end
    end
  end,
  "SPELL_CAST_SUCCESS"
)

-- Player Aura Applied Listener
HL:RegisterForSelfCombatEvent(
  function(_, _, _, _, _, _, _, _, _, _, _, SpellID)
    for i = 1, #PlayerSpecs do
      local ListenedSpell = ListenedSpells[PlayerSpecs[i]][SpellID]
      if ListenedSpell then
        ListenedSpell.LastAppliedOnPlayerTime = GetTime()
      end
    end
  end,
  "SPELL_AURA_APPLIED"
)

-- Player Aura Removed Listener
HL:RegisterForSelfCombatEvent(
  function(_, _, _, _, _, _, _, _, _, _, _, SpellID)
    for i = 1, #PlayerSpecs do
      local ListenedSpell = ListenedSpells[PlayerSpecs[i]][SpellID]
      if ListenedSpell then
        ListenedSpell.LastRemovedFromPlayerTime = GetTime()
      end
    end
  end,
  "SPELL_AURA_REMOVED"
)

-- Register spells to listen for a given class (based on SpecID).
function Player:RegisterListenedSpells(SpecID)
  PlayerSpecs = {}
  ListenedSpells = {}
  -- Fetch registered spells during the init
  local PlayerClass = HL.SpecID_ClassesSpecs[SpecID][1]
  for Spec, Spells in pairs(HL.Spell[PlayerClass]) do
    tableinsert(PlayerSpecs, Spec)
    ListenedSpells[Spec] = {}
    for _, Spell in pairs(Spells) do
      ListenedSpells[Spec][Spell:ID()] = Spell
    end
  end
  -- Add Spells based on the Whitelist
  for SpellID, Spell in pairs(Custom.Whitelist) do
    for i = 1, #PlayerSpecs do
      ListenedSpells[PlayerSpecs[i]][SpellID] = Spell
    end
  end
  -- Remove Spells based on the Blacklist
  for i = 1, #Custom.Blacklist do
    local SpellID = Custom.Blacklist[i]
    for k = 1, #PlayerSpecs do
      local Spec = PlayerSpecs[k]
      if ListenedSpells[Spec][SpellID] then
        ListenedSpells[Spec][SpellID] = nil
      end
    end
  end
end

-- Add spells in the Listened Spells Whitelist
function Spell:AddToListenedSpells()
  Custom.Whitelist[self.SpellID] = self
end

-- Add spells in the Listened Spells Blacklist
function Spell:RemoveFromListenedSpells()
  tableinsert(Custom.Blacklist, self.SpellID)
end

function MultiSpell:AddToMultiSpells()
  tableinsert(MultiSpells, self)
end

HL:RegisterForEvent(
  function(Event, Arg1)
    for _, ThisMultiSpell in pairs(MultiSpells) do
      ThisMultiSpell:Update()
    end
  end,
  "PLAYER_LOGIN", "SPELLS_CHANGED"
)








local function GetTexture (Object)
    -- Spells
    local SpellID = Object.SpellID;
    if SpellID then
        if Object.TextureSpellID ~= nil then
            if #Object.TextureSpellID == 1 then
                return GetSpellTexture(Object.TextureSpellID[1]);
            else
                return Object.TextureSpellID[2];
            end
        else
            return GetSpellTexture(SpellID);
        end

    end
    -- Items
    local ItemID = Object.ItemID;
    if ItemID then
        if Object.TextureSpellID ~= nil then
            if #Object.TextureSpellID == 1 then
                return GetSpellTexture(Object.TextureSpellID[1]);
            else
                return Object.TextureSpellID[2];
            end
        else
            local _, _, _, _, _, _, _, _, _, texture = GetItemInfo(ItemID);
            return texture
        end
    end
end

HR.castSpellSequence = {}
local lastCast = 1

function HR.CastSequence()
    if not Player:AffectingCombat() then
        lastCast = 1
        return nil
    end

    if HR.castSpellSequence ~= nil and Player:PrevGCD(1, HR.castSpellSequence[lastCast]) then
        lastCast = lastCast + 1
    end

    if lastCast > #HR.castSpellSequence then
        HR.castSpellSequence = {}
        return nil
    end

    return HR.castSpellSequence[lastCast]
end

HR.queuedSpellAuto = { HR.Spell[1].Empty, 0 }
function Spell:QueueAuto(powerExtra)
    local powerEx = powerExtra or 0
    HR.queuedSpellAuto = { self, powerEx }
end

-- Essence fix for QueueSkill
local Essences = {   
  Spell(297108),
  Spell(298273),
  Spell(298277),
  Spell(295373),
  Spell(299349),
  Spell(299353),
  Spell(295840),
  Spell(299355),
  Spell(299358),
  Spell(295258),
  Spell(299336),
  Spell(299338),
  Spell(295337),
  Spell(299345),
  Spell(299347),
  Spell(298452),
  Spell(299376),
  Spell(299378),
  Spell(302731),
  Spell(302982),
  Spell(302983),
  Spell(295186),
  Spell(298628),
  Spell(299334),
  Spell(298357),
  Spell(299372),
  Spell(299374),
}

HR.queuedSpell = { HR.Spell[1].Empty, 0 }
function Spell:Queue(powerExtra, bypassRemove)
    local bypassRemove = bypassRemove or false
    local powerEx = powerExtra or 0
    -- if self:ID() == HR.queuedSpell[1]:ID() and bypassRemove == false then
        -- HR.print("|cFFFF0000Removed from Queue:|r " .. GetSpellLink(self:ID()))
        -- HR.queuedSpell = { HR.Spell[1].Empty, 0 }
        -- HR.playSoundR("Interface\\Addons\\Rubim-RH\\Media\\queuecast.ogg")
        -- return
    -- end

    if self:IsAvailable() then	
	-- Essence fix for QueueSkill
		for i = 1, #Essences do		
		    local EssencesID = Essences[i]:ID()
		    -- If an Essence is queued
			if self:ID() == EssencesID then
			    HR.queuedSpell = {HR.Spell[1].UnleashHeartOfAzeroth, 0}
				-- HR.playSoundR("Interface\\Addons\\Rubim-RH\\Media\\queue.ogg")
			    -- print("Queued ID = " .. GetSpellLink(self:ID()))
			    -- print("Compared Essence ID = " .. EssencesID)
                return
		    -- If not Essence, return classic queue spell
			else	
                HR.queuedSpell = { self, powerEx }
                -- HR.print("|cFFFFFF00Queued:|r " .. GetSpellLink(self:ID()))
                -- HR.playSoundR("Interface\\Addons\\Rubim-RH\\Media\\queue.ogg")
                return
			end
		end
    end
    -- HR.print("|cFFFF0000Can't Queue:|r " .. GetSpellLink(self:ID()))

end

function HR.QueuedSpell()
    return HR.queuedSpell[1] or HR.Spell[1].Empty
end

function HR.QueuedSpellAuto()
    return HR.queuedSpellAuto[1] or HR.Spell[1].Empty
end

--/run HR.queuedSpell ={ HR.Spell[103].Prowl, 0 }


local movedTimer = 0
function Unit:MovingFor()
    if not self:IsMoving() then
        movedTimer = GetTime()
    end
    return GetTime() - movedTimer
end



function Spell:IsQueuedPowerCheck(powerEx)
    local powerExtra = powerEx or 0
    if HR.queuedSpell[1] == HR.Spell[1].Empty and HR.queuedSpellAuto[1] == HR.Spell[1].Empty then
        return false
    end

    local powerCostQ, queuedSpellCD, queuedSpellID
    if HR.queuedSpell[1] == HR.Spell[1].Empty then
        powerCostQ = GetSpellPowerCost(HR.queuedSpellAuto[1]:ID())
        queuedSpellCD = HR.queuedSpellAuto[1]:CooldownRemains()
        queuedSpellID = HR.queuedSpellAuto[1]:ID()
    else
        powerCostQ = GetSpellPowerCost(HR.queuedSpell[1]:ID())
        queuedSpellCD = HR.queuedSpell[1]:CooldownRemains()
        queuedSpellID = HR.queuedSpell[1]:ID()
    end

    local powerCost = GetSpellPowerCost(self:ID())
    local costType = nil
    local costTypeQ = nil
    local costs = 0
    local costsQ = 0

    for i = 1, #powerCost do
        if powerCost[i].cost > 0 then
            costType = powerCost[i].type
            break
        end
    end

    for i = 1, #powerCostQ do
        if powerCostQ[i].cost > 0 or powerCostQ[i].costPerSec > 0 or powerCostQ[i].costPercent > 0 then
            costTypeQ = powerCostQ[i].type
            costsQ = powerCostQ[i].cost
            break
        end
    end

    if costType == 3 and queuedSpellCD >= Player:EnergyTimeToX(costsQ) then
        return true
    end

    if self:ID() == queuedSpellID then
        return false
    end

    if costType ~= costTypeQ then
        return false
    end
    return true
end

function Spell:IsAvailable(CheckPet)
    return CheckPet and IsSpellKnown(self.SpellID, true) or IsPlayerSpell(self.SpellID);
end



function Spell:CooldownRemains(BypassRecovery)
    local StartTime, Duration = self:CooldownInfo()
    if StartTime == 0 then return 0 end
    local CD = StartTime + Duration - GetTime() - HL.RecoveryOffset(BypassRecovery)
  
    return CD > 0 and CD or 0
  end


-- function Spell:CooldownRemains(BypassRecovery, Offset)
--     if HR.Spell[HR.playerSpec].Spells ~= nil then
--         for i, v in pairs(HeroRotationDB[HR.playerSpec].Spells) do
--             if v.spellID == self:ID() and v.isActive == false then
--                 return 1000
--             end
--         end
--     end

--     -- if self:IsEnabled() == false then
--     --     return 1000
--     -- end

--     -- if self:IsEnabledCD() == false or self:IsEnabledCleave() == false then
--     --     return 1000
--     -- end

--     local SpellInfo = Cache.SpellInfo[self.SpellID]
--     if not SpellInfo then
--         SpellInfo = {}
--         Cache.SpellInfo[self.SpellID] = SpellInfo
--     end
--     local Cooldown = Cache.SpellInfo[self.SpellID].Cooldown
--     local CooldownNoRecovery = Cache.SpellInfo[self.SpellID].CooldownNoRecovery
--     if (not BypassRecovery and not Cooldown) or (BypassRecovery and not CooldownNoRecovery) then
--         if BypassRecovery then
--             CooldownNoRecovery = self:ComputeCooldown(BypassRecovery)
--         else
--             Cooldown = self:ComputeCooldown()
--         end
--     end
--     if Offset then
--         return BypassRecovery and math.max(HL.OffsetRemains(CooldownNoRecovery, Offset), 0) or math.max(HL.OffsetRemains(Cooldown, Offset), 0)
--     else
--         return BypassRecovery and CooldownNoRecovery or Cooldown
--     end
-- end

-- function Spell:CooldownRemainsTrue(BypassRecovery, Offset)
--     local SpellInfo = Cache.SpellInfo[self.SpellID]
--     if not SpellInfo then
--         SpellInfo = {}
--         Cache.SpellInfo[self.SpellID] = SpellInfo
--     end
--     local Cooldown = Cache.SpellInfo[self.SpellID].Cooldown
--     local CooldownNoRecovery = Cache.SpellInfo[self.SpellID].CooldownNoRecovery
--     if (not BypassRecovery and not Cooldown) or (BypassRecovery and not CooldownNoRecovery) then
--         if BypassRecovery then
--             CooldownNoRecovery = self:ComputeCooldown(BypassRecovery)
--         else
--             Cooldown = self:ComputeCooldown()
--         end
--     end
--     if Offset then
--         return BypassRecovery and math.max(HL.OffsetRemains(CooldownNoRecovery, Offset), 0) or math.max(HL.OffsetRemains(Cooldown, Offset), 0)
--     else
--         return BypassRecovery and CooldownNoRecovery or Cooldown
--     end
-- end

--[[*
  * @function Spell:CooldownRemainsP
  * @override Spell:CooldownRemains
  * @desc Offset defaulted to "Auto" which is ideal in most cases to improve the prediction.
  *
  * @param {string|number} [Offset="Auto"]
  *
  * @returns {number}
  *]]
  
function Spell:IsCastable(Range, AoESpell, ThisUnit)
    if not self:IsAvailable() or self:IsQueuedPowerCheck() then
        return false
    end
	
	local currentZoneID = select(8, GetInstanceInfo())
    HR.Spell[998] = {
        RepeatPerformance = Spell(301244),
    }
    local S = HR.Spell[998]
	
	-- Queens Court - Repeat Performance debuff checker
	if currentZoneID == 2164 and Player:DebuffRemainsP(S.RepeatPerformance) > 0 then
	    if Player:PrevGCD(1) ~= self:ID() then
	        return true
		else
		    return false
		end
	end
	
    if Range then
        local RangeUnit = ThisUnit or Target;
        return self:IsLearned() and self:CooldownUp() and RangeUnit:IsInRange(Range, AoESpell);
    else
        return self:IsLearned() and self:CooldownUp();
    end
end

function Spell:IsCastableQueue(Range, AoESpell, ThisUnit)

	if Range then
        local RangeUnit = ThisUnit or Target;
        return self:IsLearned() and self:CooldownRemains() <= 0.2 and RangeUnit:IsInRange(Range, AoESpell);
    else
        return self:IsLearned() and self:CooldownRemains() <= 0.2;
    end
end

function HR.TargetIsValid(override)
    local override = override or false

    local unitReaction = UnitReaction("Player", "Target") or 0
    if not override and unitReaction >= 4 and not Player:AffectingCombat() then
        return false
    end

    local isValid = false

    if Target:Exists() and Player:CanAttack(Target) and not Target:IsDeadOrGhost() then
        isValid = true
    end

    return isValid
end


function Spell:IsReadyQueue(Range, AoESpell, ThisUnit)
    if not HR.TargetIsValid() then
        return false
    end
	

    return self:IsCastableQueue(Range, AoESpell, ThisUnit) and self:IsUsable();
end

function Spell:SanityChecks()
    if self:IsQueuedPowerCheck() then
        return false
    end

    -- if self:IsEnabled() == false then
    --     return false
    -- end

    -- if self:IsEnabledCD() == false or self:IsEnabledCleave() == false then
    --     return false
    -- end

    if not Target:Exists() then
        return false
    end
end

function Spell:IsReady(Range, AoESpell, ThisUnit)

    if self:SanityChecks() == false then
        return false
    end

    if not self:IsAvailable() then
        return false
    end
	
	local currentZoneID = select(8, GetInstanceInfo())
    HR.Spell[998] = {
        RepeatPerformance = Spell(301244),
    }
    local S = HR.Spell[998]
	
	-- Queens Court - Repeat Performance debuff checker
	if currentZoneID == 2164 and Player:DebuffRemainsP(S.RepeatPerformance) > 0 then
	    if Player:PrevGCD(1) ~= self:ID() then
	        return true
		else
		    return false
		end
	end
	
    return self:IsCastable(Range, AoESpell, ThisUnit) and self:IsUsable();
end

function Spell:IsReadyP(Range, AoESpell, ThisUnit)
    if not self:IsAvailable() or self:IsQueuedPowerCheck() then
        return false
    end

    if HeroRotationDB[HR.playerSpec].Spells ~= nil then
        for i, v in pairs(HeroRotationDB[HR.playerSpec].Spells) do
            if v.spellID == self:ID() and v.isActive == false then
                return false
            end
        end
    end

    -- if self:IsEnabled() == false then
    --     return false
    -- end

    -- if self:IsEnabledCD() == false or self:IsEnabledCleave() == false then
    --     return false
    -- end
	
	local currentZoneID = select(8, GetInstanceInfo())
    HR.Spell[998] = {
        RepeatPerformance = Spell(301244),
    }
    local S = HR.Spell[998]
	
	-- Queens Court - Repeat Performance debuff checker
	if currentZoneID == 2164 and Player:DebuffRemainsP(S.RepeatPerformance) > 0 then
	    if Player:PrevGCD(1) ~= self:ID() then
	        return true
		else
		    return false
		end
	end

    if HeroRotationDB.mainOption.startattack then

        if Target:Exists() then
            if self:IsCastable(Range, AoESpell, ThisUnit) and self:IsUsable() then
                return true
            end
        end

        local range = self:MaximumRange()
        if range == 0 or range > 8 then
            range = 10
        else
            range = 8
        end
        HL.GetEnemies(8, true)
        if self:IsMelee() and Cache.EnemiesCount[8] >= 1 then
            return self:IsCastableP(nil, nil, nil) and self:IsUsableP();
        end
    end

    if not HR.TargetIsValid() then
        return false
    end

    return self:IsCastableP(Range, AoESpell, ThisUnit) and self:IsUsableP();
end

function Spell:IsCastableP(Range, AoESpell, ThisUnit, BypassRecovery, Offset)
    if not self:IsAvailable() or self:IsQueuedPowerCheck() then
        return false
    end
	
	local currentZoneID = select(8, GetInstanceInfo())
    HR.Spell[998] = {
        RepeatPerformance = Spell(301244),
    }
    local S = HR.Spell[998]
	
	-- Queens Court - Repeat Performance debuff checker
	if currentZoneID == 2164 and Player:DebuffRemainsP(S.RepeatPerformance) > 0 then
	    if Player:PrevGCD(1) ~= self:ID() then
	        return true
		else
		    return false
		end
	end
	    
	if Range then
        local RangeUnit = ThisUnit or Target
        return self:IsLearned() and self:CooldownRemainsP(BypassRecovery or true, Offset or "Auto") == 0 and RangeUnit:IsInRange(Range, AoESpell)
    else
        return self:IsLearned() and self:CooldownRemainsP(BypassRecovery or true, Offset or "Auto") == 0
    end
end

function Spell:IsCastableMorph(Range, AoESpell, ThisUnit)
    -- if self:IsEnabled() == false then
    --     return false
    -- end
	
	local currentZoneID = select(8, GetInstanceInfo())
    HR.Spell[998] = {
        RepeatPerformance = Spell(301244),
    }
    local S = HR.Spell[998]
	
	-- Queens Court - Repeat Performance debuff checker
	if currentZoneID == 2164 and Player:DebuffRemainsP(S.RepeatPerformance) > 0 then
	    if Player:PrevGCD(1) ~= self:ID() then
	        return true
		else
		    return false
		end
	end
	
    if Range then
        local RangeUnit = ThisUnit or Target;
        return self:IsLearned() and self:CooldownUp() and RangeUnit:IsInRange(Range, AoESpell);
    else
        return self:IsLearned() and self:CooldownUp();
    end
end

function Spell:IsReadyMorph(Range, AoESpell, ThisUnit)
    -- if self:IsEnabled() == false then
    --     return false
    -- end
	
	local currentZoneID = select(8, GetInstanceInfo())
    HR.Spell[998] = {
        RepeatPerformance = Spell(301244),
    }
    local S = HR.Spell[998]
	
	-- Queens Court - Repeat Performance debuff checker
	if currentZoneID == 2164 and Player:DebuffRemainsP(S.RepeatPerformance) > 0 then
	    if Player:PrevGCD(1) ~= self:ID() then
	        return true
		else
		    return false
		end
	end

    -- if self:IsEnabledCD() == false or self:IsEnabledCleave() == false then
    --     return false
    -- end

    if not HR.TargetIsValid() then
        return false
    end

    return self:IsCastableMorph(Range, AoESpell, ThisUnit) and self:IsUsable();
end

-- function Spell:IsEnabled()
--     if HeroRotationDB.mainOption.disabledSpells[self.SpellID] ~= nil then
--         return false
--     end

--     return true
-- end

-- function Spell:IsEnabledCD()
--     if #HeroRotationDB.mainOption.disabledSpellsCD == 0 and HR.CDsON() then
--         return true
--     end

--     for i = 1, #HeroRotationDB.mainOption.disabledSpellsCD do
--         if self.SpellID == HeroRotationDB.mainOption.disabledSpellsCD[i].value then
--             return false
--         end
--     end
--     return true
-- end

-- function HR.addSpellDisabledCD(spellid)
--     local exists = false

--     if #HeroRotationDB.mainOption.disabledSpellsCD > 0 then
--         for i = 1, #HeroRotationDB.mainOption.disabledSpellsCD do
--             if spellid == HeroRotationDB.mainOption.disabledSpellsCD[i].value then
--                 exists = true
--             end
--         end
--     end

--     if exists == false then
--         table.insert(HeroRotationDB.mainOption.disabledSpellsCD, { text = GetSpellInfo(spellid), value = spellid })
--     end
-- end

-- function HR.delSpellDisabledCD(spellid)
--     if #HeroRotationDB.mainOption.disabledSpellsCD > 0 then
--         for i = 1, #HeroRotationDB.mainOption.disabledSpellsCD do
--             if spellid == HeroRotationDB.mainOption.disabledSpellsCD[i].value then
--                 table.remove(HeroRotationDB.mainOption.disabledSpellsCD, i)
--             end
--             break
--         end
--     end
-- end

-- function Spell:IsEnabledCleave()
--     if #HeroRotationDB.mainOption.disabledSpellsCleave == 0 and not HeroRotationDB.mainOption.smartCleave then
--         return true
--     end

--     for i = 1, #HeroRotationDB.mainOption.disabledSpellsCleave do
--         if self.SpellID == HeroRotationDB.mainOption.disabledSpellsCleave[i].value then
--             return false
--         end
--     end
--     return true
-- end

-- function HR.addSpellDisabledCleave(spellid)
--     local exists = false

--     if #HeroRotationDB.mainOption.disabledSpellsCleave > 0 then
--         for i = 1, #HeroRotationDB.mainOption.disabledSpellsCleave do
--             if spellid == HeroRotationDB.mainOption.disabledSpellsCleave[i].value then
--                 exists = true
--             end
--         end
--     end

--     if exists == false then
--         table.insert(HeroRotationDB.mainOption.disabledSpellsCleave, { text = GetSpellInfo(spellid), value = spellid })
--     end
-- end

-- function HR.delSpellDisabledCleave(spellid)
--     if #HeroRotationDB.mainOption.disabledSpellsCleave > 0 then
--         for i = 1, #HeroRotationDB.mainOption.disabledSpellsCleave do
--             if spellid == HeroRotationDB.mainOption.disabledSpellsCleave[i].value then
--                 table.remove(HeroRotationDB.mainOption.disabledSpellsCleave, i)
--             end
--             break
--         end
--     end
-- end

local GroundSpells = {
    [43265] = true,
    [152280] = true,
}

-- function Spell:Cast()
--     HR.ShowButtonGlow(self:ID())
--     return GetTexture(self)
-- end

function Item:Cast()
    return GetTexture(self)
end

function Spell:SetTexture(id)
    self.TextureID = id
end


-- Player On Cast Success Listener
HL:RegisterForSelfCombatEvent(function(_, _, _, _, _, _, _, _, _, _, _, SpellID)
    if SpellID == 49998 then
        HR.clearLastDamage()
    end

    if HR.QueuedSpellAuto().SpellID == SpellID then
        HR.queuedSpellAuto = { HR.Spell[1].Empty, 0 }
    end

  
   if HR.QueuedSpell().SpellID == SpellID then
        HR.queuedSpell = { HR.Spell[1].Empty, 0 }
        -- HR.print("|cFFFFFF00Queued:|r " .. GetSpellLink(SpellID) .. " casted!")
        -- HR.playSoundR("Interface\\Addons\\Rubim-RH\\Media\\queuecast.ogg")
    end
    for i = 1, #PlayerSpecs do
        local ListenedSpell = ListenedSpells[PlayerSpecs[i]][SpellID]
        if ListenedSpell then
          ListenedSpell.LastCastTime = GetTime()
          ListenedSpell.LastHitTime = GetTime() + ListenedSpell:TravelTime()
        end
      end
end, "SPELL_CAST_SUCCESS")


-- Pet On Cast Success Listener
HL:RegisterForPetCombatEvent(function(_, _, _, _, _, _, _, _, _, _, _, SpellID)
    for i = 1, #PlayerSpecs do
        local ListenedSpell = ListenedSpells[PlayerSpecs[i]][SpellID]
        if ListenedSpell then
          ListenedSpell.LastCastTime = GetTime()
          ListenedSpell.LastHitTime = GetTime() + ListenedSpell:TravelTime()
        end
      end
end, "SPELL_CAST_SUCCESS")

-- Player Aura Applied Listener
HL:RegisterForSelfCombatEvent(
  function(_, _, _, _, _, _, _, _, _, _, _, SpellID)
    for i = 1, #PlayerSpecs do
      local ListenedSpell = ListenedSpells[PlayerSpecs[i]][SpellID]
      if ListenedSpell then
        ListenedSpell.LastAppliedOnPlayerTime = GetTime()
      end
    end
  end,
  "SPELL_AURA_APPLIED"
)

-- Player Aura Removed Listener
HL:RegisterForSelfCombatEvent(
  function(_, _, _, _, _, _, _, _, _, _, _, SpellID)
    for i = 1, #PlayerSpecs do
      local ListenedSpell = ListenedSpells[PlayerSpecs[i]][SpellID]
      if ListenedSpell then
        ListenedSpell.LastRemovedFromPlayerTime = GetTime()
      end
    end
  end,
  "SPELL_AURA_REMOVED"
)


local lustBuffs = {
    Spell(80353),
    Spell(2825),
    Spell(32182),
    Spell(90355),
    Spell(160452),
    Spell(178207),
    Spell(35475),
    Spell(230935),
    Spell(256740),
}

function Unit:LustDuration()
    for i = 1, #HeroismBuff do
        local Buff = HeroismBuff[i]
        if self:Buff(Buff, nil, true) then
            return ThisUnit:BuffRemains(Buff, true) or 0
        end
    end
    return 0
end

function Spell:ArenaCast(arenaTarget)
    local arenaTarget = arenaTarget:ID()
    if UnitName(arenaTarget) == UnitName('arena1') then
        HR.Arena1Icon(self:Cast())
    elseif UnitName(arenaTarget) == UnitName('arena2') then
        HR.Arena2Icon(self:Cast())
    elseif UnitName(arenaTarget) == UnitName('arena3') then
        HR.Arena3Icon(self:Cast())
    end
end

-- Is the current unit valid during cycle ?
function HR.UnitIsCycleValid (Unit, BestUnitTTD, TimeToDieOffset)
    return not Unit:IsFacingBlacklisted() and not Unit:IsUserCycleBlacklisted() and (not BestUnitTTD or Unit:FilteredTimeToDie(">", BestUnitTTD, TimeToDieOffset));
end

-- GetSpellTexture cached function
local GetSpellTexture = GetSpellTexture -- remap default API, since if Blizzard change GetSpellTexture then you can just replace it in one space instead edit everything
local spelltexture = setmetatable({}, { __index = function(t, v)
            local pwr = GetSpellTexture(v)
            if pwr then
                t[v] = { 1, pwr }
                return t[v]
            end     
            return 0
end })

function CacheGetSpellTexture(a)
    return unpack(spelltexture[a]) 
end

function HR.GetDescription(spellID)
    local text = GetSpellDescription(spellID) 
    if not text then 
        return {0, 0} 
    end
    local deleted_space, numbers = string.gsub(text, "%s+", ''), {}
    deleted_space = string.gsub(deleted_space, "%d+%%", "")
    for num in string.gmatch(deleted_space, "%d+") do
        table.insert(numbers, tonumber(num))
    end
    if #numbers == 1 then
        return numbers
    end
    table.sort(numbers, function (x, y)
            return x > y
    end)
    return numbers
end

