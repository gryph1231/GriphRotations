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
local MultiSpell = HL.MultiSpell

-- Lua
local pairs = pairs;
local tableconcat = table.concat;
local tostring = tostring;
local tableinsert = table.insert;

if not Spell.Shaman then
    Spell.Shaman = {};
end


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------SPELLS/ITEMS-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



RubimRH.Spell[262] = {
  autoattack                  = Spell(291944), -- regeneratin
  AncestralCall                         = Spell(274738),
    BagofTricks                           = Spell(312411),
    Berserking                            = Spell(26297),
    EarthbindTotem = Spell(2484),
    Purge = Spell(370),

    BloodFury                             = Spell(33697),
    Fireblood                             = Spell(265221),
    -- Abilities
    Skyfury = Spell(274738),--ancestral call
    Bloodlust                             = MultiSpell(2825,32182), -- Bloodlust/Heroism
    FlameShock                            = Spell(188389),
    FlametongueWeapon                     = Spell(318038),
    FrostShock                            = Spell(196840),
    AncestralGuidance = Spell(108281),
    HealingSurge                          = Spell(8004),
    LightningBolt                         = Spell(188196),
    -- LightningShield                       = Spell(192106),
    ThunderstrikeWard = Spell(192106), -- lightning shield
    -- Talents
    AstralShift                           = Spell(108271),
    CapacitorTotem                        = Spell(192058),
    ChainLightning                        = Spell(188443),
    EarthElemental                        = Spell(198103),
    EarthShield                           = Spell(974),
    ElementalBlast                        = Spell(117014),
    ElementalOrbit                        = Spell(383010),
    LavaBurst                             = Spell(51505),
    DeeplyRootedElements                  = Spell(378270),
    NaturesSwiftness                      = Spell(378081),
    PrimordialWave                        = Spell(375982),
    SpiritwalkersGrace                    = Spell(79206),
    TotemicRecall                         = Spell(108285),
    WindShear                             = Spell(57994),
    -- Buffs
    EarthShieldOtherBuff                  = Spell(974),
    EarthShieldSelfBuff                   = Spell(383648),
    LightningShieldBuff                   = Spell(192106),
    PrimordialWaveBuff                    = Spell(375986),
    SpiritwalkersGraceBuff                = Spell(79206),
    SplinteredElementsBuff                = Spell(382043),
    -- Debuffs
    FlameShockDebuff                      = Spell(188389),
    -- Misc
    Pool                                  = Spell(999910),
    StoneBulwarkTotem = Spell(383017), -- stoneskin totem
    GustofWind = Spell(192063),

 Thunderstorm = Spell(51490),
lustAT = Spell(155145),
lust1 = Spell(57724),
lust2 = Spell(57723),
lust3 = Spell(80354),
lust4 = Spell(95809),
lust5 = Spell(264689),
CleanseSpirit = Spell(51886),
GhostWolf = Spell(2645),
-- Abilities
EarthShock                            = Spell(8042),
Earthquake                            = MultiSpell(61882, 462620),
FireElemental                         = Spell(198067),
-- Talents
Ascendance                            = Spell(114050),
EchoChamber                           = Spell(382032),
EchooftheElements                     = Spell(333919),
EchoesofGreatSundering                = Spell(384087),
ElectrifiedShocks                     = Spell(382086),
EyeoftheStorm                         = Spell(381708),
FlowofPower                           = Spell(385923),
FluxMelting                           = Spell(381776),
FusionofElements                      = Spell(462840),
Icefury                               = Spell(210714),
ImprovedFlametongueWeapon             = Spell(382027),
LavaBeam                              = Spell(114074),
LightningRod                          = Spell(210689),
LiquidMagmaTotem                      = Spell(192222),
MagmaChamber                          = Spell(381932),
MasteroftheElements                   = Spell(16166),
MountainsWillFall                     = Spell(381726),
PoweroftheMaelstrom                   = Spell(191861),
PrimalElementalist                    = Spell(117013),
SearingFlames                         = Spell(381782),
SkybreakersFieryDemise                = Spell(378310),
SplinteredElements                    = Spell(382042),
StormElemental                        = Spell(192249),
Stormkeeper                           = Spell(191634),
SurgeofPower                          = Spell(262303),
SwellingMaelstrom                     = Spell(384359),
-- ThunderstrikeWard                     = Spell(462757),
-- Buffs
AscendanceBuff                        = Spell(114050),
EchoesofGreatSunderingBuff            = Spell(384088),
FluxMeltingBuff                       = Spell(381777),
FusionofElementsFire                  = Spell(462843),
FusionofElementsNature                = Spell(462841),
IcefuryBuff                           = Spell(210714),
LavaSurgeBuff                         = Spell(77762),
MagmaChamberBuff                      = Spell(381933),
MasteroftheElementsBuff               = Spell(260734),
PoweroftheMaelstromBuff               = Spell(191877),
StormkeeperBuff                       = Spell(191634),
SurgeofPowerBuff                      = Spell(285514),
-- Debuffs
ElectrifiedShocksDebuff               = Spell(382089),
LightningRodDebuff                    = Spell(197209),

  -- Abilities
  TempestAbility                        = Spell(452201),
  TempestOverload                       = Spell(463351),
  -- Talents
  Tempest                               = Spell(454009),

    -- Talents
    AncestralSwiftness                    = Spell(443454),
    PrimordialCapacity                    = Spell(443448),

}
local S = RubimRH.Spell[262] 


if not Item.Shaman then Item.Shaman = {}; end
Item.Shaman.Elemental = {

  HPIcon = Item(169451),

   
	
};
local I = Item.Shaman.Elemental;




local function num(val)
  if val then
      return 1
  else
      return 0
  end
end


local function bool(val)
  return val ~= 0
end



if not loscheck then
  loscheck = CreateFrame("Frame")
end

local losCheckTimer = 0

local frame = loscheck
frame:RegisterEvent("UI_ERROR_MESSAGE")
frame:SetScript("OnEvent", function(self,event,errorType,message)
  if message == 'Target not in line of sight' then
      losCheckTimer = GetTime()
  end	
end)



local function APL()

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------START OF ROTATION-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


inRange5 = RangeCount(5)
inRange8 = RangeCount(8)
inRange10 = RangeCount(10)
inRange15 = RangeCount(15)
inRange20 = RangeCount(20)
inRange25 = RangeCount(25)
inRange30 = RangeCount(30)
inRange40 = RangeCount("Lightning Bolt")

targetRange5 = C_Item.IsItemInRange(8149, "target")
targetRange8 = C_Item.IsItemInRange(34368, "target")
targetRange10 = C_Item.IsItemInRange(32321, "target")
targetRange15 = C_Item.IsItemInRange(33069, "target")
targetRange20 = C_Item.IsItemInRange(10645, "target")
targetRange25 = C_Item.IsItemInRange(24268, "target")
targetRange30 = C_Item.IsItemInRange(835, "target")
targetRange40 = C_Spell.IsSpellInRange("Lightning Bolt", "target")


local hasMainHandEnchant, mainHandExpiration, mainHandCharges, mainHandEnchantID, hasOffHandEnchant, offHandExpiration, offHandCharges, offHandEnchantID = GetWeaponEnchantInfo()

local lostimer = GetTime() - losCheckTimer
local los

if lostimer < Player:GCD() then
    los = true
else
    los = false
end

local isTanking, status, threatpct, rawthreatpct, threatvalue = UnitDetailedThreatSituation("player", "target")
local inInstance, instanceType = IsInInstance()

local level, affixIDs, wasEnergized = C_ChallengeMode.GetActiveKeystoneInfo()
local highkey = 4

local castchannelTime = math.random(250, 500) / 1000

local startTimeMS = select(4, UnitCastingInfo('target')) or 0
local currentTimeMS = GetTime() * 1000
local elapsedTimeca = (startTimeMS > 0) and (currentTimeMS - startTimeMS) or 0
local castTime = elapsedTimeca / 1000
local startTimeMS = select(4, UnitCastingInfo('target')) or select(4, UnitChannelInfo('target')) or 0
local currentTimeMS = GetTime() * 1000
local elapsedTimech = (startTimeMS > 0) and (currentTimeMS - startTimeMS) or 0
local channelTime = elapsedTimech / 1000

if UnitClassification("target") == "worldboss"
or UnitClassification("target") == "rareelite"
or UnitClassification("target") == "elite"
or UnitClassification("target") == "rare"
or Target:IsAPlayer() then
elite = true
else
elite = false
end


local cancast = (not Player:IsMoving() or AuraUtil.FindAuraByName("Spiritwalker's Grace", "player") or AuraUtil.FindAuraByName("Stormkeeper","player") or AuraUtil.FindAuraByName("Nature's Swiftness","player"))
HPpercentloss = MyHealthTracker.GetPredictedHealthLoss() * 3

validmobsinrange10y = combatmobs40() * .7
validmobsinrange30y = combatmobs40() * .7
        
if Target:Exists() and getCurrentDPS() and getCurrentDPS()>0 then
  targetTTD = UnitHealth('target')/getCurrentDPS()
  else targetTTD = 8888
  end
  
      local targetdying =  targetTTD<5

if Player:IsCasting() or Player:IsChanneling() then
	return 0, "Interface\\Addons\\Rubim-RH\\Media\\channel.tga"
elseif Player:IsDeadOrGhost() or AuraUtil.FindAuraByName("Drink", "player") or AuraUtil.FindAuraByName("Food", "player") or AuraUtil.FindAuraByName("Food & Drink", "player") then
	return 0, "Interface\\Addons\\Rubim-RH\\Media\\griph.tga"
end 


    						--health pot -- will need to update item ID of HPs as expansions progress
						if inRange30 >= 1 and Player:HealthPercentage() <= 30 and Player:AffectingCombat() and (IsUsableItem(191380) == true and
						GetItemCooldown(191380) == 0 and GetItemCount(191380) >= 1 or IsUsableItem(207023) == true and
						GetItemCooldown(207023) == 0 and GetItemCount(207023) >= 1)
						and (not Player:InArena() and not Player:InBattlegrounds()) then
						return I.HPIcon:Cast()
						end


            if IsReady("Ancestral Guidance") and Player:HealthPercentage() <= 65 and inRange30>=1 and not AuraUtil.FindAuraByName("Stone Bulwark", "player") then
              return S.AncestralGuidance:Cast()
              end

            if IsReady("Astral Shift") and Player:HealthPercentage() <= 45  and inRange30>=1 and not AuraUtil.FindAuraByName("Stone Bulwark", "player") then
            return S.AstralShift:Cast()
            end
            if IsReady("Stone Bulwark Totem") and Player:HealthPercentage() <= 45  and inRange30>=1 and not AuraUtil.FindAuraByName("Astral Shift", "player") then
              return S.StoneBulwarkTotem:Cast()
              end

              if IsReady("Earth Elemental") and Player:HealthPercentage() <= 25  and inRange30>=1  then
                return S.EarthElemental:Cast()
                end

            if IsReady("Cleanse Spirit") and GetAppropriateCureSpell("player")=='Curse' then
              return S.CleanseSpirit:Cast()
          end
          if IsReady("Poison Cleansing Totem") and GetAppropriateCureSpell("player")=='Poison' then
            return S.PoisonCleansingTotem:Cast()
        end


        -- Enemies40y = Player:GetEnemiesInRange(40)
        -- Enemies10ySplash = Target:GetEnemiesInSplashRange(10)
        -- print(Player:Maelstrom())
        -- print('enemies40y:',#Enemies40y)
        -- print('splash10y:',#Enemies10ySplash)

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------SPELL QUEUES-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	 
if S.lustAT:ID() ==  RubimRH.queuedSpell[1]:ID() and Player:DebuffDown(S.lust1) and Player:DebuffDown(S.lust2) and Player:DebuffDown(S.lust3) and Player:DebuffDown(S.lust4) and Player:DebuffDown(S.lust5) then
  return S.lustAT:Cast() -- BIND LUST KEYBIND IN BINDPAD TO ARCANE TORRENT
end

if S.lustAT:ID() ==  RubimRH.queuedSpell[1]:ID() and (Player:DebuffUp(S.lust1) or Player:DebuffUp(S.lust2) or Player:DebuffUp(S.lust3) or Player:DebuffUp(S.lust4) or Player:Debuff(S.lust5)) then
RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
end

if (not IsReady(RubimRH.queuedSpell[1]:ID(),nil,nil,1) or not Player:AffectingCombat() or inRange30 == 0) or S.GhostWolf:ID() ==  RubimRH.queuedSpell[1]:ID() and AuraUtil.FindAuraByName("Ghost Wolf", "player") then
  RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
  end

if IsReady(RubimRH.queuedSpell[1]:ID(),nil,nil,1) then
  return RubimRH.QueuedSpell():Cast()
end



--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------IN-COMBAT ROTATION-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------




-- Cast  Storm Elemental on cooldown. If you are talented into  Echo of the Elementals, make sure not to cast it while your Elemental is still up. The previous Elemental always needs to naturally expire first.
--   Cast  Liquid Magma Totem to spread  Flame Shock on cooldown (and if the pack is not dead in the next 20 seconds).
--   Cast  Primordial Wave on cooldown.
--   Cast  Stormkeeper on cooldown.
--   Only use  Lava Burst when you have  Primordial Wave active, and you have already spread your  Flame Shock with  Liquid Magma Totem. You should never "naturally" cast a  Flame Shock.
--   Spend your Maelstrom Maelstrom on  Earthquake
--   Cast  Chain Lightning.



if Target:AffectingCombat() or Player:AffectingCombat() and Player:CanAttack(Target)  and not Target:IsDeadOrGhost() then 
    -- kick on GCD
    if IsReady("Spiritwalker's Grace") and targetRange40 and Player:MovingFor()>2 then
      return S.SpiritwalkersGrace:Cast()
      end
    -- kick on GCD
    if IsReady("Berserking") and targetRange40 and AuraUtil.FindAuraByName("Flame Shock","target","PLAYER|HARMFUL")  and AuraUtil.FindAuraByName("Stormkeeper","player") and AuraUtil.FindAuraByName("Primordial Wave","player")  then
      return S.Berserking:Cast()
      end

      if IsReady("Nature's Swiftness") and targetRange40 and (not AuraUtil.FindAuraByName("Stormkeeper","player") and AuraUtil.FindAuraByName("Primordial Wave","player") or Player:HealthPercentage()<30) then
        return S.NaturesSwiftness:Cast()
        end

        if IsReady("Healing Surge") and AuraUtil.FindAuraByName("Nature's Swiftness","player") and Player:HealthPercentage()<35 then
          return S.HealingSurge:Cast()
          end

  if not C_Spell.IsCurrentSpell(6603) and targetRange20 then
    return S.autoattack:Cast()
    end

  if (castTime > 0.1 or channelTime > 0.1) and select(8, UnitCastingInfo("target")) == false and RubimRH.InterruptsON() and not isEnraged then

    -- kick on GCD
    if IsReady("Wind Shear") and targetRange40 and kickprio()  then
    return S.WindShear:Cast()
    end

  end

  if IsReady("Flame Shock") and targetRange40 and not AuraUtil.FindAuraByName("Flame Shock","target","PLAYER|HARMFUL")  then
    return S.FlameShock:Cast()
    end
    if IsReady("Liquid Magma Totem") and targetRange40 and RubimRH.CDsON() then
      return S.LiquidMagmaTotem:Cast()
      end

    if IsReady("Storm Elemental") and targetRange40 and S.StormElemental:TimeSinceLastCast()>36 and RubimRH.CDsON()  then
      return S.StormElemental:Cast()
      end
      if IsReady("Primordial Wave") and targetRange40  then
        return S.PrimordialWave:Cast()
        end
  if IsReady("Stormkeeper") and targetRange40 and cancast and RubimRH.CDsON() then
    return S.Stormkeeper:Cast()
    end


if inRange40>=2 then


  if IsReady("Lava Burst") and targetRange40  and AuraUtil.FindAuraByName("Lava Surge","player")  then
    return S.LavaBurst:Cast()
    end

  if IsReady("Earthquake") and targetRange40 then
    return S.Earthquake:Cast()
    end

  if IsReady("Chain Lightning") and targetRange40 and cancast then
    return S.ChainLightning:Cast()
    end

  end
  -- Cast  Storm Elemental on cooldown. If you are talented into  Echo of the Elementals, make sure not to cast it while your Elemental is still up. The previous Elemental always needs to naturally expire first.
  --   Cast  Primordial Wave on cooldown.
  --   Cast  Stormkeeper on cooldown. Don't worry about buffing these  Lightning Bolts.
  --   Cast  Lava Burst if your next cast is a spender, so when you are over 47 Maelstrom Maelstrom.
  --   Cast  Earth Shock if you have  Master of the Elements active or you are close to capping Maelstrom Maelstrom.
  --   Use  Lightning Bolt as your Single Target Filler

  if inRange40<2 then



    if IsReady("Lava Burst") and targetRange40 and AuraUtil.FindAuraByName("Lava Surge","player")  then
      return S.LavaBurst:Cast()
      end
      if IsReady("Earth Shock") and targetRange40 and (AuraUtil.FindAuraByName("Master of the Elements", "player") or Player:Maelstrom()>70) then
        return S.EarthShock:Cast()
        end
        if IsReady("Lightning Bolt") and targetRange40 and cancast then
          return S.LightningBolt:Cast()
          end
  end


  end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------OUT OF COMBAT ROTATION-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



if not Player:AffectingCombat() then
  if IsReady("Skyfury") and not AuraUtil.FindAuraByName("Skyfury", "player") and Player:IsMoving() then
    return S.Skyfury:Cast()
    end
    if IsReady("Earth Shield") and not AuraUtil.FindAuraByName("Earth Shield", "player") and Player:IsMoving() then
      return S.EarthShield:Cast()
      end

      if IsReady("Earth Shield") and not AuraUtil.FindAuraByName("Earth Shield", "player") and Player:IsMoving() then
        return S.EarthShield:Cast()
        end
        if IsReady("Flametongue Weapon") and mainHandEnchantID~=5400 and Player:IsMoving() then
          return S.FlametongueWeapon:Cast()
          end
        if IsReady("Thunderstrike Ward") and offHandEnchantID~=7587 and Player:IsMoving() then
          return S.ThunderstrikeWard:Cast()
          end

end

return 0, "Interface\\Addons\\Rubim-RH\\Media\\griph.tga"
end 






RubimRH.Rotation.SetAPL(262, APL);

local function PASSIVE()
    
end

RubimRH.Rotation.SetPASSIVE(262, PASSIVE);