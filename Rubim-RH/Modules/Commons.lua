--- ============================ HEADER ============================
--- ======= LOCALIZE =======
-- Addon
local addonName, RubimRH     = ...
local AoEON             = RubimRH.AoEON
local Cast              = RubimRH.Cast
local CastLeftNameplate = RubimRH.CastLeftNameplate
-- HeroLib
local HL                = HeroLib
local Cache, Utils      = HeroCache, HL.Utils
local Unit              = HL.Unit
local Player            = Unit.Player
local Target            = Unit.Target
local Spell             = HL.Spell
local Item              = HL.Item
-- Lua
local pairs             = pairs
local gsub              = string.gsub
-- API
local UnitInParty       = UnitInParty
local UnitInRaid        = UnitInRaid
-- File Locals
-- RubimRH.Commons              = {}
-- local Commons           = {}
-- RubimRH.Commons.Everyone     = Commons


--- ============================ CONTENT ============================
-- -- Num/Bool helper functions
-- function num(val)
--   if val then return 1 else return 0 end
-- end

-- function bool(val)
--   return val ~= 0
-- end

-- Is the current target valid?
function TargetIsValid()
  return Target:Exists() and Player:CanAttack(Target) and not Target:IsDeadOrGhost()
end

-- Is the current unit valid during cycle?
function UnitIsCycleValid(Unit, BestUnitTTD, TimeToDieOffset)
  return (not BestUnitTTD or Unit:FilteredTimeToDie(">", BestUnitTTD, TimeToDieOffset))
end

-- Is it worth to DoT the unit?
function CanDoTUnit(Unit, HealthThreshold)
  return Unit:Health() >= HealthThreshold or Unit:IsDummy()
end

-- Interrupt
-- function Commons.Interrupt(Spell, Setting, StunSpells)
--   if Settings.InterruptEnabled then
--     if (not Settings.InterruptCycle or not AoEON() or Target:IsInterruptible()) and Target:IsInterruptible() then
--       if Spell:IsCastable(true) and Target:IsSpellInRange(Spell) then
--         if Cast(Spell, nil, Setting) then return "Cast " .. Spell:Name() .. " (Interrupt)"; end
--       elseif Settings.InterruptWithStun and Target:CanBeStunned() then
--         if StunSpells then
--           for i = 1, #StunSpells do
--             if (StunSpells[i][1]:IsKnown() or StunSpells[i][1]:IsKnown(true)) and StunSpells[i][1]:IsCastable() and Target:IsSpellInRange(StunSpells[i][1]) and StunSpells[i][3]() then
--               if Cast(StunSpells[i][1], nil, Setting) then return StunSpells[i][2]; end
--             end
--           end
--         end
--       end
--     elseif Settings.InterruptCycle and AoEON() then
--       local SpellRange = (Spell.MaximumRange and Spell.MaximumRange > 0 and Spell.MaximumRange <= 100) and Spell.MaximumRange or 40
--       local Enemies = Player:GetEnemiesInRange(SpellRange)
--       local TargetGUID = Target:GUID()
--       for _, CycleUnit in pairs(Enemies) do
--         if CycleUnit:GUID() ~= TargetGUID and CycleUnit:IsInterruptible() then
--           if Spell:IsCastable(true) and CycleUnit:IsSpellInRange(Spell) then
--             CastLeftNameplate(CycleUnit, Spell)
--             break
--           elseif Settings.InterruptWithStun and CycleUnit:CanBeStunned() then
--             if StunSpells then
--               for i = 1, #StunSpells do
--                 if (StunSpells[i][1]:IsKnown() or StunSpells[i][1]:IsKnown(true)) and StunSpells[i][1]:IsCastable() and CycleUnit:IsSpellInRange(StunSpells[i][1]) and StunSpells[i][3]() then
--                   CastLeftNameplate(CycleUnit, StunSpells[i][1])
--                 end
--               end
--             end
--           end
--         end
--       end
--     end
--   end
-- end



-- Cycle Unit Helper
function CastCycle(Object, Enemies, Condition, OutofRange, OffGCD, DisplayStyle)
  if Condition(Target) then
    return Cast(Object, OffGCD, DisplayStyle, OutofRange)
  end
  if AoEON() then
    local TargetGUID = Target:GUID()
    for _, CycleUnit in pairs(Enemies) do
      if CycleUnit:GUID() ~= TargetGUID and Condition(CycleUnit) then
        CastLeftNameplate(CycleUnit, Object)
        break
      end
    end
  end
end

  -- Target If Helper
function CastTargetIf(Object, Enemies, TargetIfMode, TargetIfCondition, Condition, OutofRange, OffGCD, DisplayStyle)
  local TargetCondition = (not Condition or (Condition and Condition(Target)))
  if not AoEON() and TargetCondition then
    return Cast(Object, OffGCD, DisplayStyle, OutofRange)
  end
  if AoEON() then
    local BestUnit, BestConditionValue = nil, nil
    for _, CycleUnit in pairs(Enemies) do
      if (CycleUnit:AffectingCombat() or CycleUnit:IsDummy())
        and (not BestConditionValue or Utils.CompareThis(TargetIfMode, TargetIfCondition(CycleUnit), BestConditionValue)) then
        BestUnit, BestConditionValue = CycleUnit, TargetIfCondition(CycleUnit)
      end
    end
    if BestUnit then
      if TargetCondition and (BestUnit:GUID() == Target:GUID() or BestConditionValue == TargetIfCondition(Target)) then
        return Cast(Object, OffGCD, DisplayStyle, OutofRange)
      elseif ((Condition and Condition(BestUnit)) or not Condition) then
        CastLeftNameplate(BestUnit, Object)
      end
    end
  end
end

function GroupBuffMissing(spell)
  local range = 40
  local BotBBuffIDs = {
    [1] = 381758, -- Warrior
    [2] = 381752, -- Paladin
    [3] = 381749, -- Hunter (432655 Buff ID exists, but doesn't seem to be used)
    [4] = 381754, -- Rogue
    [5] = 381753, -- Priest
    [6] = 381732, -- Death Knight
    [7] = 381756, -- Shaman (432652? Unverified, but unlikely to be used, like the other extra Buff IDs)
    [8] = 381750, -- Mage
    [9] = 381757, -- Warlock
    [10] = 381751, -- Monk
    [11] = 381746, -- Druid (432658 Buff ID exists, but doesn't seem to be used)
    [12] = 381741, -- Demon Hunter
    [13] = 381748, -- Evoker (432658 Buff ID exists, but doesn't seem to be used)
  }
  if spell:ID() == 6673 then range = 100 end
  if Player:BuffDown(spell, true) then return true end
  -- Are we in a party or raid?
  local Group
  if UnitInRaid("player") then
    Group = Unit.Raid
  elseif UnitInParty("player") then
    Group = Unit.Party
  else
    return false
  end
  -- Check for the buff amongst group members.
  local TotalChars = 0
  local BuffedChars = 0
  for _, Char in pairs(Group) do
    if Char:Exists() and not Char:IsDeadOrGhost() and Char:IsInRange(range) and not (Player:IsInDelve() and Char:Name() == "Brann Bronzebeard") then
      TotalChars = TotalChars + 1
      if spell:ID() == 381748 then -- Blessing of the Bronze
        local _, _, CharClass = Char:Class()
        if Char:BuffUp(Spell(BotBBuffIDs[CharClass]), true) then
          BuffedChars = BuffedChars + 1
        end
      elseif Char:BuffDown(spell, true) then
        return true
      end
    end
  end
  if spell:ID() == 381748 and BuffedChars < TotalChars then return true end
  return false
end

function GetCurrentEmpowerData(stage)
  local CurrentStage = 0
  local StagesData = {}
  _, _, _, StartTimeMS, EndTimeMS, _, _, _, _, StageTotal = UnitChannelInfo("player")

  if StageTotal and StageTotal > 0 then
    local LastFinish = 0
    for i = 1, StageTotal do
      StagesData[i] = {
        Start = LastFinish,
        Finish = LastFinish + GetUnitEmpowerStageDuration("player", i - 1) / 1000
      }
      -- RubimRH.Print(" Start"..i..": "..StagesData[i].Start)
      -- RubimRH.Print("Finish"..i..": "..StagesData[i].Finish)
      LastFinish = StagesData[i].Finish
      if StartTimeMS / 1000 + LastFinish <= GetTime() then
        CurrentStage = i
      end
    end
  end

  if stage then
    return CurrentStage
  else
    return StagesData
  end
end
