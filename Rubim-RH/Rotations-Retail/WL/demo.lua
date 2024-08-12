-- Edit: Taste#0124
-- Updated to 8.2

-- Addon
local addonName, addonTable = ...

local mainAddon = RubimRH
local HL = HeroLib
local Cache = HeroCache
local Unit = HL.Unit
local Player = Unit.Player
local Target = Unit.Target
local Spell = HL.Spell
local Item = HL.Item
local Pet = Unit.Pet
local Arena = Unit.Arena;

RubimRH.Spell[266] = {
  -- Racials
  AncestralCall                         = Spell(274738),
  Berserking                            = Spell(26297),
  BloodFury                             = Spell(33702),
  Fireblood                             = Spell(265221),
  -- Abilities
  ShadowBolt                            = Spell(686),
  SummonDarkglare                       = Spell(205180),
  UnendingResolve                       = Spell(104773),
  -- Talents
  GrimoireofSacrifice                   = Spell(108503),
  GrimoireofSacrificeBuff               = Spell(196099),
  SoulConduit                           = Spell(215941),
  SummonSoulkeeper                      = Spell(386256),
  InquisitorsGaze                       = Spell(386344),
  InquisitorsGazeBuff                   = Spell(388068),
  Soulburn                              = Spell(385899),
  -- Buffs
  -- Debuffs
  -- Command Demon Abilities
  AxeToss                               = Spell(119914),
  Seduction                             = Spell(119909),
  ShadowBulwark                         = Spell(119907),
  SingeMagic                            = Spell(119905),
  SpellLock                             = Spell(119910),
  -- Base Abilities
  Felstorm                              = Spell(89751),
  HandofGuldan                          = Spell(105174), -- Splash, 8
  ShadowBoltLineCD                      = Spell(686),
  SummonPet                             = Spell(30146),
  -- Talents
  BilescourgeBombers                    = Spell(267211), -- Splash, 8
  CallDreadstalkers                     = Spell(104316),
  Demonbolt                             = Spell(264178),
  DemonicCalling                        = Spell(205145),
  DemonicStrength                       = Spell(267171),
  Doom                                  = Spell(603),
  GrandWarlocksDesign                   = Spell(387084),
  GrimoireFelguard                      = Spell(111898),
  Guillotine                            = Spell(386833),
  Implosion                             = Spell(196277), -- Splash, 8
  InnerDemons                           = Spell(267216),
  NetherPortal                          = Spell(267217),
  PowerSiphon                           = Spell(264130),
  ReignofTyranny                        = Spell(427684),
  SacrificedSouls                       = Spell(267214),
  SoulboundTyrant                       = Spell(334585),
  SoulStrike                            = Spell(428344),
  SummonDemonicTyrant                   = Spell(265187),
  SummonVilefiend                       = Spell(264119),
  TheExpendables                        = Spell(387600),
  -- Buffs
  DemonicCallingBuff                    = Spell(205146),
  DemonicCoreBuff                       = Spell(264173),
  DemonicPowerBuff                      = Spell(265273),
  NetherPortalBuff                      = Spell(267218),
  RiteofRuvaraadBuff                    = Spell(409725), -- T30 4pc
  -- Debuffs
  DoomDebuff                            = Spell(603),
  DoomBrandDebuff                       = Spell(423583), -- T31 2pc
  FromtheShadowsDebuff                  = Spell(270569),
};

local S = RubimRH.Spell[266]

-- Items
if not Item.Warlock then Item.Warlock = {} end
Item.Warlock.Demonology = {
  PotionofUnbridledFury        = Item(169299),
  AzsharasFontofPower          = Item(169314)
};
local I = Item.Warlock.Demonology;

-- Rotation Var
local ShouldReturn; -- Used to get the return string
local EnemiesCount;

local function num(val)
  if val then return 1 else return 0 end
end

local function bool(val)
  return val ~= 0
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


local function APL()

  inRange40 = RangeCount("Shadow Bolt")
  targetRange40 = TargetInRange("Shadow Bolt")

  if Player:IsCasting() or Player:IsChanneling() then
    return 0, "Interface\\Addons\\Rubim-RH\\Media\\channel.tga"
  elseif Player:IsDeadOrGhost() or AuraUtil.FindAuraByName("Drink", "player") 
  or AuraUtil.FindAuraByName("Food", "player") or AuraUtil.FindAuraByName("Food & Drink", "player") then
      return 0, "Interface\\Addons\\Rubim-RH\\Media\\griph.tga"
  end
  
if inRange40>=2 then

  -- Cast  Grimoire: Felguard before  Summon Demonic Tyrant, delay if necessary
    if S.GrimoireFelguard:IsReady() then
    return S.GrimoireFelguard:Cast()
  end
  -- Cast  Summon Vilefiend if talented into  Fel Invocation
  if S.SummonVilefiend:IsReady() then
    return S.SummonVilefiend:Cast()
  end
  -- Cast  Call Dreadstalkers
  if S.CallDreadstalkers:IsReady() then
    return S.CallDreadstalkers:Cast()
  end
  -- Cast  Felstorm
  if S.Felstorm:IsReady() then
    return S.Felstorm:Cast()
  end
  -- Cast  Demonic Strength
  if S.DemonicStrength:IsReady() then
    return S.DemonicStrength:Cast()
  end
  -- Cast  Guillotine
  if S.Guillotine:IsReady() then
    return S.Guillotine:Cast()
  end
  -- Cast  Bilescourge Bombers if the mobs are remaining stationary
  if S.BilescourgeBombers:IsReady() then
    return S.BilescourgeBombers:Cast()
  end
  -- Cast  Grimoire: Felguard when you have 4 or fewer Soul Shards
  if S.GrimoireFelguard:IsReady() and Player:SoulShardsP()<4 then
    return S.GrimoireFelguard:Cast()
  end
  -- Cast  Hand of Gul'dan with 4-5 Soul Shards
  if S.HandofGuldan:IsReady() and Player:SoulShardsP()>=4 then
    return S.HandofGuldan:Cast()
  end
  -- Cast  Implosion to explode your Wild Imps when there are 2 or more targets
  if S.Implosion:IsReady() and inRange40>=2 then
    return S.Implosion:Cast()
  end
  -- Cast  Demonbolt when available
  if S.Demonbolt:IsReady() then
    return S.Demonbolt:Cast()
  end
  -- Cast  Power Siphon when you have 2 or fewer  Demonic Core
  if S.PowerSiphon:IsReady() and Player:BuffStack(S.DemonicCoreBuff)<=2 then
    return S.PowerSiphon:Cast()
  end
  -- Cast  Shadow Bolt to generate Soul Shards
  if S.ShadowBolt:IsReady() then
    return S.ShadowBolt:Cast()
  end

end

    return 0, "Interface\\Addons\\Rubim-RH\\Media\\griph.tga"
end

RubimRH.Rotation.SetAPL(266, APL)
