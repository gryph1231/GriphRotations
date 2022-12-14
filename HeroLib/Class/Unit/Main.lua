--- ============================ HEADER ============================
--- ======= LOCALIZE =======
-- Addon
local addonName, HL = ...
-- HeroLib
local Cache, Utils = HeroCache, HL.Utils
local Unit, UnitGUIDMap = HL.Unit, HL.UnitGUIDMap
local Player, Pet, Target = Unit.Player, Unit.Pet, Unit.Target
local Focus, MouseOver = Unit.Focus, Unit.MouseOver
local Arena, Boss, Nameplate = Unit.Arena, Unit.Boss, Unit.Nameplate
local Party, Raid = Unit.Party, Unit.Raid
local Spell = HL.Spell
local Item = HL.Item
-- Lua
local tonumber = tonumber
-- File Locals

-- Blizzard API Mappings
local UnitGUID = UnitGUID
local UnitName = UnitName
local UnitExists = UnitExists
local UnitIsVisible = UnitIsVisible
local UnitLevel = UnitLevel
local UnitCanAttack = UnitCanAttack
local UnitIsPlayer = UnitIsPlayer
local UnitHealth = UnitHealth
local UnitHealthMax = UnitHealthMax
local UnitIsDeadOrGhost = UnitIsDeadOrGhost
local UnitAffectingCombat = UnitAffectingCombat
local UnitIsUnit = UnitIsUnit
local UnitClassification = UnitClassification
local UnitThreatSituation = UnitThreatSituation
local GetUnitSpeed = GetUnitSpeed

function Unit:Cache()
  self:RemoveUnitGUIDMapEntry()
  self.UnitExists = UnitExists(self.UnitID) or false
  self.UnitGUID = UnitGUID(self.UnitID)
  self.UnitName = UnitName(self.UnitID)
  self.UnitCanBeAttacked = UnitCanAttack("player", self.UnitID) or false
  self.UnitNPCID = self:NPCID(true)
  if self.UnitGUID and self.UnitID then
    self:AddUnitGUIDMapEntry()
  end
  -- Level?
  -- IsDummy?
  -- IsAPlayer?
  -- Classification?
end

--- ============================ CONTENT ============================
-- Get the unit ID.
function Unit:ID()
  return self.UnitID
end

-- Get the unit GUID.
function Unit:GUID()
  if self.UseCache then
    return self.UnitGUID
  end
  return UnitGUID(self.UnitID)
end

-- Get the unit Name.
function Unit:Name()
  if self.UseCache then
    return self.UnitName
  end
  return UnitName(self.UnitID)
end

-- Get if the unit Exists and is visible.
function Unit:Exists()
  if self.UseCache then
    return self.UnitExists and UnitIsVisible(self.UnitID)
  end
  return UnitExists(self.UnitID) and UnitIsVisible(self.UnitID)
end

-- Get the unit NPC ID.
function Unit:NPCID(BypassCache)
  if not BypassCache and self.UseCache and self.UnitNPCID then
    return self.UnitNPCID
  end

  local GUID = self:GUID()
  if GUID then
    local UnitInfo = Cache.UnitInfo[GUID]
    if not UnitInfo then
      UnitInfo = {}
      Cache.UnitInfo[GUID] = UnitInfo
    end
    if not UnitInfo.NPCID then
      local type, _, _, _, _, npcid = strsplit('-', GUID)
      if type == "Creature" or type == "Pet" or type == "Vehicle" then
        UnitInfo.NPCID = tonumber(npcid)
      else
        UnitInfo.NPCID = -2
      end
    end
    return UnitInfo.NPCID
  end
  return -1
end

-- Get the level of the unit
function Unit:Level()
  return UnitLevel(self.UnitID)
end

-- Get if an unit with a given NPC ID is in the Boss list and has less HP than the given ones.
function Unit:IsInBossList(NPCID, HP)
  local NPCID = NPCID or self:NPCID()
  local HP = HP or 100
  local ThisUnit
  for _, ThisUnit in pairs(Boss) do
    if ThisUnit:Exists() and ThisUnit:NPCID() == NPCID and ThisUnit:HealthPercentage() <= HP then
      return true
    end
  end
  return false
end

-- Get if the unit CanAttack the other one.
function Unit:CanAttack(Other)
  if self.UnitID == "player" and Other.UseCache then
    return Other.UnitCanBeAttacked
  end
  return UnitCanAttack(self.UnitID, Other.UnitID)
end

local DummyUnits = {
  -- City (SW, Orgri, ...)
  [31146] = true, -- Raider's Training Dummy
  [31144] = true, -- Training Dummy
  [32666] = true, -- Training Dummy
  [32667] = true, -- Training Dummy
  [46647] = true, -- Training Dummy
  [114832] = true, -- PvP Training Dummy
  [153292] = true, -- Training Dummy
  -- MoP Shrine of Two Moons
  [67127] = true, -- Training Dummy
  -- WoD Alliance Garrison
  [87317] = true, -- Mage Tower Damage Training Dummy
  [87318] = true, -- Mage Tower Damage Dungeoneer's Training Dummy (& Garrison)
  [87320] = true, -- Mage Tower Damage Raider's Training Dummy
  [88314] = true, -- Tanking Dungeoneer's Training Dummy
  [88316] = true, -- Healing Training Dummy ----> FRIENDLY
  -- WoD Horde Garrison
  [87760] = true, -- Mage Tower Damage Training Dummy
  [87761] = true, -- Mage Tower Damage Dungeoneer's Training Dummy (& Garrison)
  [87762] = true, -- Mage Tower Damage Raider's Training Dummy
  [88288] = true, -- Tanking Dungeoneer's Training Dummy
  [88289] = true, -- Healing Training Dummy ----> FRIENDLY
  -- Legion Druid Class Order Hall
  [113964] = true, -- Raider's Training Dummy
  [113966] = true, -- Dungeoneer's Training Dummy
  -- Legion Mage Class Order Hall
  [103397] = true, -- Greater Bullwark Construct
  [103404] = true, -- Bullwark Construct
  [103402] = true, -- Lesser Bullwark Construct
  -- Legion Priest Class Order Hall
  [107555] = true, -- Bound void Wraith
  [107556] = true, -- Bound void Walker
  -- Legion Rogue Class Order Hall
  [92164] = true, -- Training Dummy
  [92165] = true, -- Dungeoneer's Training Dummy
  [92166] = true, -- Raider's Training Dummy
  -- Legion Warlock Class Order Hall
  [101956] = true, -- Rebellious Fel Lord
  [102045] = true, -- Rebellious WrathGuard
  [102048] = true, -- Rebellious Felguard
  [102052] = true, -- Rebellious imp
  -- BfA Dazar'Alor
  [144081] = true, -- Training Dummy
  [144082] = true, -- Training Dummy
  [144085] = true, -- Training Dummy
  [144086] = true, -- Raider's Training Dummy
  -- BfA Boralus
  [126781] = true, -- Training Dummy
  [131983] = true, -- Raider's Training Dummy
  [131989] = true, -- Training Dummy
  [131992] = true, -- Dungeoneer's Training Dummy
  -- Shadowlands Kyrian
  [154564] = true, -- Valiant's Humility
  [154567] = true, -- Purity's Cleaning
  [154580] = true, -- Reinforced Guardian
  [154583] = true, -- Starlwart Guardian
  [154585] = true, -- Valiant's Resolve
  [154586] = true, -- Stalwart Phalanx
  [160325] = true, -- Humility's Obedience
  -- Shadowlands Venthyr
  [173942] = true, -- Training Dummy
  [175449] = true, -- Raider's Training Dummy
  [175450] = true, -- Dungeoneer's Training Dummy
  [175451] = true, -- Dungeoneer's Tanking Dummy
  [175452] = true, -- Raider's Tanking Dummy
  [175455] = true, -- Cleave Training Dummy
  [175456] = true, -- Swarm Training Dummy
  [175462] = true, -- Sinfall Fiend
  -- Shadowlands Night Fae
  [174565] = true, -- Dungeoneer's Tanking Dummy
  [174566] = true, -- Raider's Tanking Dummy
  [174567] = true, -- Raider's Training Dummy
  [174568] = true, -- Dungeoneer's Training Dummy
  [174569] = true, -- Training Dummy
  [174570] = true, -- Swarm Training Dummy
  [174571] = true, -- Cleave Training Dummy
  -- Shadowlands Necrolord
  [174484] = true, -- Dungeoneer's Training Dummy
  [174487] = true, -- Training Dummy
  [174488] = true, -- Raider's Training Dummy
  [174491] = true, -- Tanking Dummy
  -- Other
  [65310] = true, -- Turnip Punching Bag
}
function Unit:IsDummy()
  local NPCID = self:NPCID()
  return NPCID >= 0 and DummyUnits[NPCID] == true
end

-- Get if the unit is a Player or not.
function Unit:IsAPlayer()
  return UnitIsPlayer(self.UnitID)
end

-- Get the unit Health.
function Unit:Health()
  return UnitHealth(self.UnitID) or -1
end

-- Get the unit MaxHealth.
function Unit:MaxHealth()
  return UnitHealthMax(self.UnitID) or -1
end

-- Get the unit Health Percentage
function Unit:HealthPercentage()
  return self:Health() ~= -1 and self:MaxHealth() ~= -1 and self:Health() / self:MaxHealth() * 100
end

-- Get if the unit Is Dead Or Ghost.
function Unit:IsDeadOrGhost()
  return UnitIsDeadOrGhost(self.UnitID)
end

-- Get if the unit Affecting Combat.
function Unit:AffectingCombat()
  return UnitAffectingCombat(self.UnitID)
end

-- Get if two unit are the same.
function Unit:IsUnit(Other)
  return UnitIsUnit(self.UnitID, Other.UnitID)
end

-- Get unit classification
function Unit:Classification()
  return UnitClassification(self.UnitID) or ""
end

-- Get if we are Tanking or not the Unit.
function Unit:IsTanking(Other, ThreatThreshold)
  local ThreatThreshold = ThreatThreshold or 2
  local ThreatSituation = UnitThreatSituation(self.UnitID, Other.UnitID)
  return ThreatSituation and ThreatSituation >= ThreatThreshold or false
end

function Unit:IsTankingAoE(Radius, ThreatSituation)
  local Radius = Radius or 8
  HL.GetEnemies(Radius, true)
  local IsTankingAOE = false
  for _, Unit in pairs(Cache.Enemies[Radius]) do
    if self:IsTanking(Unit, ThreatSituation) then
      IsTankingAOE = true
    end
  end
  return IsTankingAOE
end

-- Get if the unit is moving or not.
function Unit:IsMoving()
  return GetUnitSpeed(self.UnitID) ~= 0
end
