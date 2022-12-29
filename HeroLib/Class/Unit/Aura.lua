--- ============================ HEADER ============================
--- ======= LOCALIZE =======
-- Addon
local addonName, HL = ...
-- HeroLib
local Cache, Utils = HeroCache, HL.Utils
local Unit = HL.Unit
local Player, Pet, Target = Unit.Player, Unit.Pet, Unit.Target
local Focus, MouseOver = Unit.Focus, Unit.MouseOver
local Arena, Boss, Nameplate = Unit.Arena, Unit.Boss, Unit.Nameplate
local Party, Raid = Unit.Party, Unit.Raid
local Spell = HL.Spell
local Item = HL.Item
-- Lua
local unpack = unpack
-- File Locals

local GetPlayerAuraBySpellID = C_UnitAuras.GetPlayerAuraBySpellID


--- ============================ CONTENT ============================
-- buff.foo.up (does return the buff table and not only true/false)
do
  --  1      2     3      4            5           6             7           8           9                      10          11          12            13                14            15       16     17      18
  -- name, icon, count, dispelType, duration, expirationTime, caster, canStealOrPurge, nameplateShowPersonal, spellID, canApplyAura, isBossAura, casterIsPlayer, nameplateShowAll, timeMod, value1, value2, value3
  local UnitBuff = UnitBuff
  local UnitID
  local function _UnitBuff()
    local Buffs = {}
    for i = 1, HL.MAXIMUM do
      local Infos = { UnitBuff(UnitID, i) }
      if not Infos[10] then break end
      Buffs[i] = Infos
    end
    return Buffs
  end

  function Unit:Buff(Spell, Index, AnyCaster)
    local GUID = self:GUID()
    if GUID then
      UnitID = self.UnitID
      local Buffs = Cache.Get("UnitInfo", GUID, "Buffs", _UnitBuff)
      for i = 1, #Buffs do
        local Buff = Buffs[i]
        if Spell:ID() == Buff[10] then
          local Caster = Buff[7]
          if AnyCaster or Caster == "player" then
            if Index then
              if type(Index) == "number" then
                return Buff[Index]
              else
                return unpack(Buff)
              end
            else
              return true
            end
          end
        end
      end
    end
    return false
  end
end

--[[*
  * @function Unit:BuffDown
  * @desc Get if the buff is down.
  * @simc buff.foo.down
  *
  * @param {object} Spell - Spell to check.
  * @param {number|array} [Index] - The index of the attribute to retrieve when calling the spell info.
  * @param {boolean} [AnyCaster] - Check from any caster ?
  *
  * @returns {boolean}
  *]]
function Unit:BuffDown(Spell, Index, AnyCaster)
  return (not self:Buff(Spell, Index, AnyCaster))
end

--[[*
  * @function Unit:BuffRemains
  * @desc Get the remaining time, if there is any, on a buff.
  * @simc buff.foo.remains
  *
  * @param {object} Spell - Spell to check.
  * @param {boolean} [AnyCaster] - Check from any caster ?
  * @param {string|number} [Offset] - The offset to apply, can be a string for a known method or directly the offset value in seconds.
  *
  * @returns {number}
  *]]
function Unit:BuffRemains(Spell, AnyCaster, Offset)
  local ExpirationTime = self:Buff(Spell, 6, AnyCaster)
  if ExpirationTime then
    if ExpirationTime == 0 then
      return 9999
    end
    if Offset then
      ExpirationTime = HL.OffsetRemains(ExpirationTime, Offset)
    end
    -- Stealth-like buffs (Subterfurge and Master Assassin) are delayed but within aura latency
    if Spell:ID() == 115192 or Spell:ID() == 256735 then
      ExpirationTime = ExpirationTime - 0.3
    end
    local Remains = ExpirationTime - HL.GetTime()
    return Remains >= 0 and Remains or 0
  else
    return 0
  end
end

--[[*
  * @function Unit:BuffRemainsP
  * @override Unit:BuffRemains
  * @desc Offset defaulted to "Auto" which is ideal in most cases to improve the prediction.
  *
  * @param {string|number} [Offset="Auto"]
  *
  * @returns {number}
  *]]
function Unit:BuffRemainsP(Spell, AnyCaster, Offset)
  return self:BuffRemains(Spell, AnyCaster, Offset or "Auto")
end

function Unit:BuffP(Spell, AnyCaster, Offset)
  return self:BuffRemains(Spell, AnyCaster, Offset or "Auto") > 0
end

function Unit:BuffDownP(Spell, AnyCaster, Offset)
  return self:BuffRemains(Spell, AnyCaster, Offset or "Auto") == 0
end

-- buff.foo.duration
function Unit:BuffDuration(Spell, AnyCaster)
  return self:Buff(Spell, 5, AnyCaster) or 0
end

-- buff.foo.stack
function Unit:BuffStack(Spell, AnyCaster)
  return self:Buff(Spell, 3, AnyCaster) or 0
end

--[[*
  * @function Unit:BuffStackP
  * @override Unit:BuffStack
  * @desc Offset defaulted to "Auto" which is ideal in most cases to improve the prediction.
  *
  * @param {string|number} [Offset="Auto"]
  *
  * @returns {number}
  *]]
function Unit:BuffStackP(Spell, AnyCaster, Offset)
  if self:BuffRemainsP(Spell, AnyCaster, Offset) then
    return self:BuffStack(Spell, AnyCaster)
  else
    return 0
  end
end

-- buff.foo.refreshable (doesn't exists on SimC atm tho)
function Unit:BuffRefreshable(Spell, PandemicThreshold, AnyCaster, Offset)
  return self:BuffRemains(Spell, AnyCaster, Offset) <= PandemicThreshold
end

--[[*
  * @function Unit:BuffRefreshableP
  * @override Unit:BuffRefreshable
  * @desc Offset defaulted to "Auto" which is ideal in most cases to improve the prediction.
  *
  * @param {string|number} [Offset="Auto"]
  *
  * @returns {number}
  *]]
function Unit:BuffRefreshableP(Spell, PandemicThreshold, AnyCaster, Offset)
  return self:BuffRefreshable(Spell, PandemicThreshold, AnyCaster, Offset or "Auto")
end

--[[*
  * @function Unit:BuffRefreshableC
  * @override Unit:BuffRefreshable
  * @desc Automaticaly calculates the pandemicThreshold from enum table.
  *
  * @param
  *
  * @returns {number}
  *]]
function Unit:BuffRefreshableC(Spell, AnyCaster, Offset)
  return self:BuffRefreshable(Spell, Spell:PandemicThreshold(), AnyCaster, Offset)
end

--[[*
  * @function Unit:BuffRefreshableCP
  * @override Unit:BuffRefreshableP
  * @desc Automaticaly calculates the pandemicThreshold from enum table with prediction.
  *
  * @param
  *
  * @returns {number}
  *]]
function Unit:BuffRefreshableCP(Spell, AnyCaster, Offset)
  return self:BuffRefreshableP(Spell, Spell:PandemicThreshold(), AnyCaster, Offset)
end

-- hot.foo.ticks_remain
function Unit:BuffTicksRemainP(Spell)
  local Remains = self:BuffRemainsP(Spell)
  if Remains == 0 then
    return 0
  else
    return math.ceil(Remains / Spell:TickTime())
  end
end

-- debuff.foo.up or dot.foo.up (does return the debuff table and not only true/false)
do
  --  1     2      3         4          5           6           7           8                   9              10         11            12           13               14            15       16      17      18
  -- name, icon, count, dispelType, duration, expirationTime, caster, canStealOrPurge, nameplateShowPersonal, spellID, canApplyAura, isBossAura, casterIsPlayer, nameplateShowAll, timeMod, value1, value2, value3
  local UnitDebuff = UnitDebuff
  local UnitID
  local function _UnitDebuff()
    local Debuffs = {}
    for i = 1, HL.MAXIMUM do
      local Infos = { UnitDebuff(UnitID, i) }
      if not Infos[10] then break end
      Debuffs[i] = Infos
    end
    return Debuffs
  end

  function Unit:Debuff(Spell, Index, AnyCaster)
    local GUID = self:GUID()
    if GUID then
      UnitID = self.UnitID
      local Debuffs = Cache.Get("UnitInfo", GUID, "Debuffs", _UnitDebuff)
      for i = 1, #Debuffs do
        local Debuff = Debuffs[i]
        if Spell:ID() == Debuff[10] then
          local Caster = Debuff[7]
          if AnyCaster or Caster == "player" or Caster == "pet" then
            if Index then
              if type(Index) == "number" then
                return Debuff[Index]
              else
                return unpack(Debuff)
              end
            else
              return true
            end
          end
        end
      end
    end
    return false
  end
end

--[[*
  * @function Unit:DebuffDown
  * @desc Get if the debuff is down.
  * @simc debuff.foo.down
  *
  * @param {object} Spell - Spell to check.
  * @param {number|array} [Index] - The index of the attribute to retrieve when calling the spell info.
  * @param {boolean} [AnyCaster] - Check from any caster ?
  *
  * @returns {boolean}
  *]]
function Unit:DebuffDown(Spell, Index, AnyCaster)
  return (not self:Debuff(Spell, Index, AnyCaster))
end

--[[*
  * @function Unit:DebuffRemains
  * @desc Get the remaining time, if there is any, on a debuff.
  * @simc debuff.foo.remains, dot.foo.remains
  *
  * @param {object} Spell - Spell to check.
  * @param {boolean} [AnyCaster] - Check from any caster ?
  * @param {string|number} [Offset] - The offset to apply, can be a string for a known method or directly the offset value in seconds.
  *
  * @returns {number}
  *]]
function Unit:DebuffRemains(Spell, AnyCaster, Offset)
  local ExpirationTime = self:Debuff(Spell, 6, AnyCaster)
  if ExpirationTime then
    if Offset then
      ExpirationTime = HL.OffsetRemains(ExpirationTime, Offset)
    end
    local Remains = ExpirationTime - HL.GetTime()
    return Remains >= 0 and Remains or 0
  else
    return 0
  end
end

--[[*
  * @function Unit:DebuffRemainsP
  * @override Unit:DebuffRemains
  * @desc Offset defaulted to "Auto" which is ideal in most cases to improve the prediction.
  *
  * @param {string|number} [Offset="Auto"]
  *
  * @returns {number}
  *]]
function Unit:DebuffRemainsP(Spell, AnyCaster, Offset)
  return self:DebuffRemains(Spell, AnyCaster, Offset or "Auto")
end

function Unit:DebuffP(Spell, AnyCaster, Offset)
  return self:DebuffRemains(Spell, AnyCaster, Offset or "Auto") > 0
end

function Unit:DebuffDownP(Spell, AnyCaster, Offset)
  return self:DebuffRemains(Spell, AnyCaster, Offset or "Auto") == 0
end

-- debuff.foo.duration or dot.foo.duration
function Unit:DebuffDuration(Spell, AnyCaster)
  return self:Debuff(Spell, 5, AnyCaster) or 0
end

-- debuff.foo.stack or dot.foo.stack
function Unit:DebuffStack(Spell, AnyCaster)
  return self:Debuff(Spell, 3, AnyCaster) or 0
end

--[[*
  * @function Unit:DebuffStackP
  * @override Unit:DebuffStack
  * @desc Offset defaulted to "Auto" which is ideal in most cases to improve the prediction.
  *
  * @param {string|number} [Offset="Auto"]
  *
  * @returns {number}
  *]]
function Unit:DebuffStackP(Spell, AnyCaster, Offset)
  if self:DebuffP(Spell, AnyCaster, Offset) then
    return self:DebuffStack(Spell, AnyCaster)
  else
    return 0
  end
end

-- debuff.foo.refreshable or dot.foo.refreshable
function Unit:DebuffRefreshable(Spell, PandemicThreshold, AnyCaster, Offset)
  return self:DebuffRemains(Spell, AnyCaster, Offset) <= PandemicThreshold
end

--[[*
  * @function Unit:DebuffRefreshableP
  * @override Unit:DebuffRefreshable
  * @desc Offset defaulted to "Auto" which is ideal in most cases to improve the prediction.
  *
  * @param {string|number} [Offset="Auto"]
  *
  * @returns {number}
  *]]
function Unit:DebuffRefreshableP(Spell, PandemicThreshold, AnyCaster, Offset)
  return self:DebuffRefreshable(Spell, PandemicThreshold, AnyCaster, Offset or "Auto")
end

--[[*
  * @function Unit:DebuffRefreshableC
  * @override Unit:DebuffRefreshable
  * @desc Automaticaly calculates the pandemicThreshold from enum table.
  *
  * @param
  *
  * @returns {number}
  *]]
function Unit:DebuffRefreshableC(Spell, AnyCaster, Offset)
  return self:DebuffRefreshable(Spell, Spell:PandemicThreshold(), AnyCaster, Offset)
end

--[[*
  * @function Unit:DebuffRefreshableCP
  * @override Unit:DebuffRefreshableP
  * @desc Automaticaly calculates the pandemicThreshold from enum table with prediction.
  *
  * @param
  *
  * @returns {number}
  *]]
function Unit:DebuffRefreshableCP(Spell, AnyCaster, Offset)
  return self:DebuffRefreshableP(Spell, Spell:PandemicThreshold(), AnyCaster, Offset)
end

-- dot.foo.ticks_remain
function Unit:DebuffTicksRemainP(Spell)
  local Remains = self:DebuffRemainsP(Spell)
  if Remains == 0 then
    return 0
  else
    return math.ceil(Remains / Spell:TickTime())
  end
end

-- buff.bloodlust.up
do
  local HeroismBuff = {
    Spell(90355), -- Ancient Hysteria
    Spell(2825), -- Bloodlust
    Spell(32182), -- Heroism
    Spell(160452), -- Netherwinds
    Spell(80353), -- Time Warp
    Spell(178207), -- Drums of Fury
    Spell(35475), -- Drums of War
    Spell(230935), -- Drums of Montain
    Spell(256740) -- Drums of Maelstrom
  }
  local ThisUnit, _Remains
  local function _HasHeroism()
    for i = 1, #HeroismBuff do
      local Buff = HeroismBuff[i]
      if ThisUnit:Buff(Buff, nil, true) then
        return _Remains and ThisUnit:BuffRemains(Buff, true) or true
      end
    end
    return false
  end

  local function _HasHeroismP(Offset)
    for i = 1, #HeroismBuff do
      local Buff = HeroismBuff[i]
      if ThisUnit:Buff(Buff, nil, true) then
        return _Remains and ThisUnit:BuffRemainsP(Buff, true, Offset or "Auto") or true
      end
    end
    return false
  end

  function Unit:HasHeroism(Remains)
    local GUID = self:GUID()
    if GUID then
      local Key = Remains and "Remains" or "Up"
      ThisUnit, _Remains = self, Remains
      return Cache.Get("UnitInfo", GUID, "HasHeroism", Key, _HasHeroism)
    end
    return Remains and 0 or false
  end

  function Unit:HasHeroismP(Remains)
    local GUID = self:GUID()
    if GUID then
      local Key = Remains and "Remains" or "Up"
      ThisUnit, _Remains = self, Remains
      return Cache.Get("UnitInfo", GUID, "HasHeroismP", Key, _HasHeroismP)
    end
    return Remains and 0 or false
  end
end
function Unit:HasHeroismRemains()
  return self:HasHeroism(true)
end

function Unit:HasHeroismRemainsP()
  return self:HasHeroismP(true)
end

function Unit:HasNotHeroism()
  return (not self:HasHeroism())
end
--- ============================ CONTENT ============================
-- Note: BypassRecovery is a common arg of this module because by default, in order to improve the prediction, we take in account the remaining time of the GCD or the current cast (whichever is higher).
--       Although sometimes we might want to ignore this and return the "raw" value, which this arg is for.

-- Get the AuraInfo (from UnitAura).
-- Only returns Stack, Duration, ExpirationTime, Index by default. Except if the Full argument is truthy then it is the UnitAura call that is returned.
  do
    local GUID, SpellID, UnitID
    local AuraStack, AuraDuration, AuraExpirationTime, AuraSpellID, Index
  
    function Unit:AuraInfo(ThisSpell, Filter, Full)
      GUID = self:GUID()
      if not GUID then return end
  
      SpellID = ThisSpell:ID()
  
      -- Use GetPlayerAuraBySpellID if we are checking a player buff as it is more performant and finds more things
      if GUID == Player:GUID() then
        if Full then
          return GetPlayerAuraBySpellID(SpellID)
        else
          local spellTable = GetPlayerAuraBySpellID(SpellID)
          if type(spellTable) ~= "table" then return nil end
          AuraDuration = spellTable.duration
          AuraExpirationTime = spellTable.expirationTime
          AuraStack = spellTable.applications
          return AuraStack, AuraDuration, AuraExpirationTime
        end
      end
  
      UnitID = self:ID()
      Index = 1
      while true do
        _, _, AuraStack, _, AuraDuration, AuraExpirationTime, _, _, _, AuraSpellID = UnitAura(UnitID, Index, Filter)
  
        -- Returns no value if the aura was not found.
        if not AuraSpellID then return end
  
        -- Returns the info once we match the spell ids.
        if AuraSpellID == SpellID then
          if Full then
            return UnitAura(UnitID, Index, Filter)
          else
            return AuraStack, AuraDuration, AuraExpirationTime, Index
          end
          --return Full and UnitAura(UnitID, Index, Filter) or AuraStack, AuraDuration, AuraExpirationTime, Index
        end
  
        Index = Index + 1
      end
    end
  end
  
  -- Get the BuffInfo (from AuraInfo).
  function Unit:BuffInfo(ThisSpell, AnyCaster, Full)
    local Filter = AnyCaster and "HELPFUL" or "HELPFUL|PLAYER"
  
    return self:AuraInfo(ThisSpell, Filter, Full)
  end