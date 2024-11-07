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
 
 FirstAscendant                        = Spell(462440),

 StormFrenzyBuff                       = Spell(462725),

 -- Tier Bonuses
 MaelstromSurgeBuff                    = Spell(457727), -- TWWS1 4pc
  ElementalReverb                       = Spell(443418),


  LightningShield                       = Spell(192106),


  -- Other Class Debuffs
  ChaosBrandDebuff                      = Spell(1490),
  HuntersMarkDebuff                     = Spell(257284),
  -- Trinket Effects
  SpymastersReportBuff                  = Spell(451199), -- Stacking buff from before using Spymaster's Web trinket
  SpymastersWebBuff                     = Spell(444959), -- Buff from using Spymaster's Web trinket
  AmplificationCore                     = Spell(445029),
  Earthsurge                            = Spell(455590),
  LivelyTotems                          = Spell(445034),
  SurgingTotem                          = Spell(444995),
  TotemicRebound                        = Spell(445025),

AncestralCall                         = Spell(274738),
BagofTricks                           = Spell(312411),
Berserking                            = Spell(26297),
EarthbindTotem = Spell(2484),
Purge = Spell(370),

BloodFury                             = Spell(33697),
Fireblood                             = Spell(265221),
-- Abilities
Skyfury = Spell(462854),
Bloodlust                             = MultiSpell(2825,32182), -- Bloodlust/Heroism
WindRushTotem = Spell(192077),
FlameShock                            = Spell(470411),
FlametongueWeapon                     = Spell(318038),
FrostShock                            = Spell(196840),
AncestralGuidance = Spell(108281),
HealingSurge                          = Spell(8004),
LightningBolt                         = Spell(188196),
ThunderstrikeWard = Spell(462757), 
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
TremorTotem = Spell(8143),
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
StoneBulwarkTotem = Spell(108270), 
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
-- Talents
ArcDischarge                          = Spell(455096),
AwakeningStorms                       = Spell(455129),
RollingThunder                        = Spell(454026),
Supercharge                           = Spell(455110),
-- Buffs
ArcDischargeBuff                      = Spell(455097),
AwakeningStormsBuff                   = Spell(462131),
TempestBuff                           = Spell(454015),
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
SwellingMaelstrom                     = Spell(381707),
-- ThunderstrikeWard                     = Spell(462757),
-- Buffs
AscendanceBuff                        = Spell(114050),
EchoesofGreatSunderingBuff            = Spell(384088),
FluxMeltingBuff                       = Spell(381777),
PoisonCleansingTotem = Spell(383013),
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



local function tremortotem()
	if Player:AffectingCombat() then
		for id = 1, 10 do
			local spell = {"Repulsive Visage","Horrifying Shrill","Terrorize","Terrifying Slam","Howling Fear","Rasping Scream","Terrifying Roar",
  
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
  
  
  


local function defensives()
	if Player:AffectingCombat() then
		for id = 1, 15 do
			local spell = {
  "Call of the Brood","Massive Slam","Viscous Darkness","Dark Pulse","Dark Floes","Shadowy Decay",
  "Erosive Spray","Ground Pound","Void Outburst","Earth Shatterer","Crystalline Eruption","Void Discharge","Furious Thrashing","Acid Nova","Wrath of Zolramus",
  "Dark Shroud","Shattering Bellow","Crushing Slam","Fiery Ricochet","Umbral Wind","Commanding Roar","Forge Weapon","Void Surge","Vociferous Indoctrination", "Tremor Slam",
  
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
  

--- ===== Rotation Variables =====
local IsTanking
local VarMaelstrom
local VarMaelCap = 100 + 50 * num(S.SwellingMaelstrom:IsAvailable()) + 25 * num(S.PrimordialCapacity:IsAvailable())


HL:RegisterForEvent(function()
  VarMaelCap = 100 + 50 * num(S.SwellingMaelstrom:IsAvailable()) + 25 * num(S.PrimordialCapacity:IsAvailable())
  S.PrimordialWave:RegisterInFlightEffect(327162)
  S.PrimordialWave:RegisterInFlight()
  S.LavaBurst:RegisterInFlight()
end, "LEARNED_SPELL_IN_TAB")
S.PrimordialWave:RegisterInFlightEffect(327162)
S.PrimordialWave:RegisterInFlight()
S.LavaBurst:RegisterInFlight()


local function combatmobs40()
  local totalRange40 = 0

  for id = 1, 15 do -- Keep this at 15 to limit the checks
      local unitID = "nameplate" .. id
      if UnitCanAttack("player", unitID) 
          and C_Spell.IsSpellInRange("Lightning Bolt", unitID)
          and UnitHealthMax(unitID) > 5 
          and (UnitAffectingCombat(unitID) or string.sub(UnitName(unitID), -5) == "Dummy") then
          totalRange40 = totalRange40 + 1
      end
  end

  return totalRange40
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


local function FSTargets()
  local FSAoe = 0
  

    
      for id = 1, 40 do
      local unitID = "nameplate" .. id
      if UnitCanAttack("player", unitID) and C_Spell.IsSpellInRange("Lightning Bolt", unitID) and AuraUtil.FindAuraByName("Flame Shock",unitID,"PLAYER|HARMFUL") then
        FSAoe = FSAoe + 1
      end
    end
  
    return FSAoe
  end
  

  local function LRTargets()
    local LRAoe = 0
    
  
      
        for id = 1, 40 do
        local unitID = "nameplate" .. id
        if UnitCanAttack("player", unitID) and C_Spell.IsSpellInRange("Lightning Bolt", unitID) and AuraUtil.FindAuraByName("Lightning Rod",unitID,"PLAYER|HARMFUL") then
          LRAoe = LRAoe + 1
        end
      end
    
      return LRAoe
    end
    






local function aoe()


  if combatmobs40()>0 then 
    checktargets = combatmobs40()
  elseif target_is_dummy() then
    checktargets = inRange40
  else
    checktargets = 6
  end

if IsReady("Fire Elemental") and targetRange40 then
return S.FireElemental:Cast()
end


if IsReady("Storm Elemental") and targetRange40 then
return S.FireElemental:Cast()
end
if IsReady("Stormkeeper") and cancastAll and targetRange40 and RubimRH.CDsON() and (not S.Ascendance:IsAvailable() or S.Ascendance:CooldownRemains()<Player:GCD() or S.Ascendance:CooldownRemains()>10)  then
return S.Stormkeeper:Cast()
end


-- totemic_recall,if=cooldown.liquid_magma_totem.remains>15&(active_dot.flame_shock<(spell_targets.chain_lightning>?6)-2|talent.fire_elemental.enabled)
-- Reset LMT CD as early as possible. Always for Fire, only if you can dot up 3 more targets for Lightning.
if IsReady("Totemic Recall") and S.LiquidMagmaTotem:CooldownRemains()>15 and (FSTargets()<(checktargets)-2 or S.FireElemental:IsAvailable() and S.FireElemental:IsAvailable()) then
  return S.TotemicRecall:Cast()
  end
  if IsReady("Liquid Magma Totem") and targetRange40  then
    return S.LiquidMagmaTotem:Cast()
    end
    -- primordial_wave,target_if=min:dot.flame_shock.remains,if=buff.surge_of_power.up|!talent.surge_of_power.enabled|maelstrom<60-5*talent.eye_of_the_storm.enabled
    -- Spread Flame Shock via Primordial Wave using Surge of Power if possible.
   -- griph notes: FSremains>0 removed - added to hold up to 5 s for ascenance
    if IsReady("Primordial Wave") and targetRange40 and (RubimRH.CDsON() and Player:BuffUp(S.AscendanceBuff) or not RubimRH.CDsON() or not S.Ascendance:IsAvailable() or S.Ascendance:CooldownRemains()>5) and (Player:BuffUp(S.SurgeofPowerBuff) or not S.SurgeofPower:IsAvailable() or VarMaelstrom<60-5*num(S.EyeoftheStorm:IsAvailable())) then
      return S.PrimordialWave:Cast()
      end
      if IsReady("Ancestral Swiftness") and targetRange40  then
        return S.AncestralSwiftness:Cast()
        end

        -- flame_shock,target_if=refreshable,if=buff.surge_of_power.up&dot.flame_shock.remains<target.time_to_die-16&active_dot.flame_shock<(spell_targets.chain_lightning>?6)&!talent.liquid_magma_totem.enabled
        -- Spread Flame Shock using Surge of Power if LMT is not picked.
        -- and FSremains<targetTTD - 16 removed
if IsReady("Flame Shock") and targetRange40 and FSremains<7 and Player:BuffUp(S.SurgeofPowerBuff) and FSTargets()<checktargets and not S.LiquidMagmaTotem:IsAvailable() then
  return S.FlameShock:Cast()
end

-- flame_shock,target_if=refreshable,if=talent.fire_elemental.enabled&(buff.surge_of_power.up|!talent.surge_of_power.enabled)&dot.flame_shock.remains<target.time_to_die-5&(active_dot.flame_shock<6|dot.flame_shock.remains>0)
-- Spread and refresh Flame Shock using Surge of Power (if talented) up to 6.
-- and FSremains<targetTTD - 5 removed
if IsReady("Flame Shock")  and targetRange40 and FSremains<2 and S.FireElemental:IsAvailable() and (Player:BuffUp(S.SurgeofPowerBuff) or not S.SurgeofPower:IsAvailable()) and (FSTargets()<6 or FSremains>0) then
  return S.FlameShock:Cast()
end
if IsReady("Ascendance") and RubimRH.CDsON() and not Player:BuffUp(S.AscendanceBuff) then
  return S.Ascendance:Cast()
  end

  -- tempest,target_if=min:debuff.lightning_rod.remains,if=!buff.arc_discharge.up&(buff.surge_of_power.up|!talent.surge_of_power.enabled)
  if IsReady("Tempest") and tempest
  and cancastAll and targetRange40
  and Player:BuffDown(S.ArcDischargeBuff) and (Player:BuffUp(S.SurgeofPowerBuff) or not S.SurgeofPower:IsAvailable()) then
    return S.Tempest:Cast()
  end

  -- chain_lightning,if=active_enemies>=6&buff.surge_of_power.up
  if IsReady("Chain Lightning") and cancastnaturespells and targetRange40 and (combatmobs40()>6) and Player:BuffUp(S.SurgeofPowerBuff) then
    return S.ChainLightning:Cast()
    end


    -- Lava_burst,target_if=dot.flame_shock.remains>2,if=buff.primordial_wave.up&(buff.stormkeeper.up&spell_targets.chain_lightning>=6|buff.tempest.up)&maelstrom<60-5*talent.eye_of_the_storm.enabled&talent.surge_of_power.enabled
    -- Consume Primordial Wave buff immediately if you have Stormkeeper buff, fighting 6+ enemies and need maelstrom to spend.

    if IsReady("Lava Burst") and targetRange40  and cancastlavaburst
    and FSremains>2 
    and Player:BuffUp(S.PrimordialWaveBuff) 
    and (Player:BuffUp(S.StormkeeperBuff) and (combatmobs40()>6) or Player:BuffUp(S.TempestBuff)) 
    and VarMaelstrom<60-5*num(S.EyeoftheStorm:IsAvailable() 
    and S.SurgeofPower:IsAvailable()) then
      return S.LavaBurst:Cast()
      end

      -- lava_burst,target_if=dot.flame_shock.remains>2,if=buff.primordial_wave.up&(buff.primordial_wave.remains<4|buff.lava_surge.up)
      -- Cast Lava burst to consume Primordial Wave proc. Wait for Lava Surge proc if possible.
      if IsReady("Lava Burst") and targetRange40 and FSremains>2 and Player:BuffUp(S.PrimordialWaveBuff) and (Player:BuffRemains(S.PrimordialWaveBuff)<4 or Player:BuffUp(S.LavaSurgeBuff)) and cancastlavaburst then
        return S.LavaBurst:Cast()
        end
        -- lava_burst,target_if=dot.flame_shock.remains,if=cooldown_react&buff.lava_surge.up&!buff.master_of_the_elements.up&talent.master_of_the_elements.enabled&talent.fire_elemental.enabled
        -- *{Fire} Use Lava Surge proc to buff <anything> with Master of the Elements.
        if IsReady("Lava Burst") and targetRange40 and FSremains>1 and Player:BuffUp(S.LavaSurgeBuff) and Player:BuffDown(S.MasteroftheElementsBuff) and S.MasteroftheElements:IsAvailable() and S.FireElemental:IsAvailable() and cancastlavaburst then
          return S.LavaBurst:Cast()
          end

          -- elemental_blast,target_if=min:debuff.lightning_rod.remains,if=spell_targets.chain_lightning=2&(maelstrom>variable.mael_cap-30|cooldown.primordial_wave.remains<gcd&talent.surge_of_power.enabled|(buff.stormkeeper.up&spell_targets.chain_lightning>=6|buff.tempest.up)&talent.surge_of_power.enabled)
          -- 2t
          if IsReady("Elemental Blast")  and cancastAll and targetRange40 and LRremains>0 and ((combatmobs40()==2) and (VarMaelstrom>VarMaelCap - 30 or S.PrimordialWave:CooldownRemains()<Player:GCD() and S.SurgeofPower:IsAvailable() or (Player:BuffUp(S.StormkeeperBuff) and (combatmobs40()>=6) or Player:BuffUp(S.TempestBuff)) and S.SurgeofPower:IsAvailable())) then
            return S.ElementalBlast:Cast()
            end


            -- earthquake,if=cooldown.primordial_wave.remains<gcd&talent.surge_of_power.enabled&(buff.echoes_of_great_sundering_es.up|buff.echoes_of_great_sundering_eb.up|!talent.echoes_of_great_sundering.enabled)
            -- Activate Surge of Power if next global is Primordial wave. Respect Echoes of Great Sundering.
            if IsReady("Earthquake") and targetRange40 
            and S.PrimordialWave:CooldownRemains()<Player:GCD() and S.SurgeofPower:IsAvailable() and (Player:BuffUp(S.EchoesofGreatSunderingBuff) or not S.EchoesofGreatSundering:IsAvailable()) then
              return S.Earthquake:Cast()
            end


            -- earthquake,if=(lightning_rod=0&talent.lightning_rod.enabled|maelstrom>variable.mael_cap-30)&(buff.echoes_of_great_sundering_es.up|buff.echoes_of_great_sundering_eb.up|!talent.echoes_of_great_sundering.enabled)
            -- Spend if all Lightning Rods ran out or you are close to overcaping. Respect Echoes of Great Sundering.
  if IsReady("Earthquake") and targetRange40 
  and ((LRTargets() == 0 
  and S.LightningRod:IsAvailable() 
  or VarMaelstrom > VarMaelCap - 40) and 
  (Player:BuffUp(S.EchoesofGreatSunderingBuff) 
  or not S.EchoesofGreatSundering:IsAvailable())) then
    return S.Earthquake:Cast()
  end

  -- earthquake,if=(buff.stormkeeper.up&spell_targets.chain_lightning>=6|buff.tempest.up)&talent.surge_of_power.enabled&(buff.echoes_of_great_sundering_es.up|buff.echoes_of_great_sundering_eb.up|!talent.echoes_of_great_sundering.enabled)
  -- Spend to buff your follow-up Stormkeeper with Surge of Power on 6+ targets. Respect Echoes of Great Sundering.
if IsReady("Earthquake") and targetRange40 and (Player:BuffUp(S.StormkeeperBuff) and combatmobs40()>=6 or Player:BuffUp(S.TempestBuff)) 
and S.SurgeofPower:IsAvailable() and (Player:BuffUp(S.EchoesofGreatSunderingBuff) or not S.EchoesofGreatSundering:IsAvailable()) then
  return S.Earthquake:Cast()
end

  -- elemental_blast,target_if=min:debuff.lightning_rod.remains,if=talent.echoes_of_great_sundering.enabled&!buff.echoes_of_great_sundering_eb.up&(lightning_rod=0|maelstrom>variable.mael_cap-30|(buff.stormkeeper.up&spell_targets.chain_lightning>=6|buff.tempest.up)&talent.surge_of_power.enabled)
  -- Use the talents you selected. Spread Lightning Rod to as many targets as possible.
  if IsReady("Elemental Blast") and cancastAll and targetRange40 and (S.EchoesofGreatSundering:IsAvailable() and Player:BuffDown(S.EchoesofGreatSunderingBuff) and (LRTargets() == 0 or VarMaelstrom > VarMaelCap - 30 or (Player:BuffUp(S.StormkeeperBuff) and (combatmobs40()>=6) or Player:BuffUp(S.TempestBuff)) and S.SurgeofPower:IsAvailable())) then
    return S.ElementalBlast:Cast()
  end

  -- earth_shock,target_if=min:debuff.lightning_rod.remains,if=talent.echoes_of_great_sundering.enabled&!buff.echoes_of_great_sundering_es.up&(lightning_rod=0|maelstrom>variable.mael_cap-30|
  -- (buff.stormkeeper.up&spell_targets.chain_lightning>=6|buff.tempest.up)&talent.surge_of_power.enabled)
  -- Use the talents you selected. Spread Lightning Rod to as many targets as possible.
  if IsReady("Earth Shock") and targetRange40 and S.EchoesofGreatSundering:IsAvailable() and Player:BuffDown(S.EchoesofGreatSunderingBuff) and (LRTargets() == 0 or VarMaelstrom > VarMaelCap - 30 
  or (Player:BuffUp(S.StormkeeperBuff) and combatmobs40()>=6 or Player:BuffUp(S.TempestBuff)) and S.SurgeofPower:IsAvailable()) then
    return S.EarthShock:Cast()
  end
  -- icefury,if=talent.fusion_of_elements.enabled&!(buff.fusion_of_elements_nature.up|buff.fusion_of_elements_fire.up)
  -- Use Icefury for Fusion of Elements proc.
  if IsReady("Icefury") and C_Spell.GetSpellInfo("Frost Shock").iconID == 135855 and targetRange40 and (S.FusionofElements:IsAvailable() and not (Player:BuffUp(S.FusionofElementsNature) or Player:BuffUp(S.FusionofElementsFire))) then
    return S.Icefury:Cast()
  end

  -- lava_burst,target_if=dot.flame_shock.remains>2,if=talent.master_of_the_elements.enabled&!buff.master_of_the_elements.up&!buff.ascendance.up&talent.fire_elemental.enabled
  -- *{Fire} Proc Master of the Elements outside Ascendance.
  if IsReady("Lava Burst") and cancastlavaburst and targetRange40 and (S.MasteroftheElements:IsAvailable() and Player:BuffDown(S.MasteroftheElementsBuff) and Player:BuffDown(S.AscendanceBuff) and S.FireElemental:IsAvailable()) then
    return S.LavaBurst:Cast()
  end


  if IsReady("Lava Burst") and targetRange40 and Player:IsMoving() and Player:BuffUp(S.LavaSurgeBuff) then
    return S.LavaBurst:Cast()
  end

  -- chain_lightning
  if IsReady("Chain Lightning") and targetRange40 and cancastnaturespells then
    return S.ChainLightning:Cast()
  end

  if IsReady("Earth Shield") and not AuraUtil.FindAuraByName("Earth Shield", "player") and Player:HealthPercentage()<60 and Player:IsMoving() then
    return S.EarthShield:Cast()
    end
  -- flame_shock,moving=1,target_if=refreshable
  if IsReady("Flame Shock") and (FSremains<16 or S.FlameShock:TimeSinceLastCast()>Player:GCD() + 0.5) and Player:IsMoving() and targetRange40 then
    return S.FlameShock:Cast()
  end
  -- frost_shock,moving=1
  if IsReady("Frost Shock") and Player:IsMoving() and targetRange40 then
    return S.FrostShock:Cast()
  end







end



local function st()

-- fire_elemental
if IsReady("Fire Elemental") and RubimRH.CDsON() then
  return S.FireElemental:Cast()
end

-- storm_elemental
if IsReady("Storm Elemental") and RubimRH.CDsON() then
  return S.StormElemental:Cast()
end


-- stormkeeper
-- Just use Stormkeeper.
if IsReady("Stormkeeper") and cancastAll and RubimRH.CDsON() then
  return S.Stormkeeper:Cast()
end

-- primordial_wave,if=!buff.surge_of_power.up
-- Use Primordial Wave as much as possible.
if IsReady("Primordial Wave") and (Player:BuffDown(S.SurgeofPowerBuff)) then
  return S.PrimordialWave:Cast()
end


-- stormkeeper
-- Just use Stormkeeper.
if IsReady("Ancestral Swiftness") and RubimRH.CDsON() then
  return S.AncestralSwiftness:Cast()
end


-- ascendance,if=fight_remains>180|buff.spymasters_web.up|!(variable.spymaster_in_1st|variable.spymaster_in_2nd)
if IsReady("Ascendance") and RubimRH.CDsON() and not Player:BuffUp(S.AscendanceBuff) and (S.FirstAscendant:IsAvailable() or Player:BuffUp(S.SpymastersWebBuff) or not usespymaster) then
  return S.Ascendance:Cast()
end

--lightning_bolt,if=buff.stormkeeper.up&buff.surge_of_power.up&spell_targets.chain_lightning=2
--2t
if IsReady("Lightning Bolt") and cancastnaturespells and (Player:BuffUp(S.StormkeeperBuff) and Player:BuffUp(S.SurgeofPowerBuff) and (combatmobs40()==2) ) then
  return S.LightningBolt:Cast()
end


-- tempest,if=buff.surge_of_power.up
-- Surge of Power is strong and should be used. ©
if IsReady("Tempest")  and tempest
and (Player:BuffUp(S.SurgeofPowerBuff)) and cancastAll then
  return S.Tempest:Cast()
end

-- lightning_bolt,if=buff.surge_of_power.up
if IsReady("Lightning Bolt") and (Player:BuffUp(S.SurgeofPowerBuff)) and cancastnaturespells then
  return S.LightningBolt:Cast()
end

-- tempest,if=buff.surge_of_power.up
-- Surge of Power is strong and should be used. ©
if IsReady("Tempest")  and tempest
and Player:BuffStack(S.StormFrenzyBuff)==2 and not S.SurgeofPower:IsAvailable() and cancastAll then
  return S.Tempest:Cast()
end



if IsReady("Lightning Bolt") and (Player:BuffStack(S.StormFrenzyBuff)==2) and cancastnaturespells and Player:BuffStack(S.StormFrenzyBuff)==2 then
  return S.LightningBolt:Cast()
end



-- liquid_magma_totem,if=active_dot.flame_shock=0
-- Use LMT to apply Flame Shock.
if IsReady("Liquid Magma Totem") and FSTargets()==0  then
  return S.LiquidMagmaTotem:Cast()
end




-- flame_shock,if=(active_dot.flame_shock=0|dot.flame_shock.remains<6)&!buff.surge_of_power.up&!buff.master_of_the_elements.up&!talent.primordial_wave.enabled&!talent.liquid_magma_totem.enabled
-- Manually refresh Flame shock if better options are not talented.
if IsReady("Flame Shock") and (FSTargets()==0 or FSremains<6) and Player:BuffDown(S.SurgeofPowerBuff) and Player:BuffDown(S.MasteroftheElementsBuff) and not S.PrimordialWave:IsAvailable() and not S.LiquidMagmaTotem:IsAvailable() then
  return S.FlameShock:Cast()
end

-- earthquake,if=(buff.echoes_of_great_sundering_es.up|buff.echoes_of_great_sundering_eb.up)&(maelstrom>variable.mael_cap-15|fight_remains<5)
-- Spend if close to overcaping. Respect Echoes of Great Sundering.
if IsReady("Earthquake") and (Player:BuffUp(S.EchoesofGreatSunderingBuff)  and VarMaelstrom > VarMaelCap - 20 ) then
  return S.Earthquake:Cast()
end

-- elemental_blast,if=maelstrom>variable.mael_cap-15|fight_remains<5
if IsReady("Elemental Blast") and VarMaelstrom  > VarMaelCap - 20   and cancastAll then
  return S.ElementalBlast:Cast()
end

-- earth_shock,if=maelstrom>variable.mael_cap-15|fight_remains<5
if IsReady("Earth Shock") and VarMaelstrom  > VarMaelCap - 20 then
  return S.EarthShock:Cast()
end


-- earthquake,if=(buff.echoes_of_great_sundering_es.up|buff.echoes_of_great_sundering_eb.up)&(maelstrom>variable.mael_cap-15|fight_remains<5)
-- Spend if close to overcaping. Respect Echoes of Great Sundering.
if IsReady("Earthquake") and (Player:BuffUp(S.EchoesofGreatSunderingBuff)  and not S.SurgeofPower:IsAvailable() ) then
  return S.Earthquake:Cast()
end


-- elemental_blast,if=maelstrom>variable.mael_cap-15|fight_remains<5
if IsReady("Elemental Blast")  and not S.SurgeofPower:IsAvailable()    and cancastAll then
  return S.ElementalBlast:Cast()
end

-- earth_shock,if=maelstrom>variable.mael_cap-15|fight_remains<5
if IsReady("Earth Shock") and not S.SurgeofPower:IsAvailable() then
  return S.EarthShock:Cast()
end


-- icefury,if=!(buff.fusion_of_elements_nature.up|buff.fusion_of_elements_fire.up)
-- Use Icefury to proc Fusion of Elements.
if IsReady("Icefury") and C_Spell.GetSpellInfo("Frost Shock").iconID == 135855 and (not (Player:BuffUp(S.FusionofElementsNature) or Player:BuffUp(S.FusionofElementsFire))) then
  return S.Icefury:Cast()
end

-- lava_burst,target_if=dot.flame_shock.remains>2,if=!buff.master_of_the_elements.up
if IsReady("Lava Burst") and Player:BuffDown(S.MasteroftheElementsBuff) and  FSremains>2 and cancastlavaburst then
  return S.LavaBurst:Cast()
end
-- lava_burst,if=!buff.master_of_the_elements.up&buff.lava_surge.up

if IsReady("Lava Burst") and Player:BuffDown(S.MasteroftheElementsBuff) and Player:BuffUp(S.LavaSurgeBuff) and cancastlavaburst then
  return S.LavaBurst:Cast()
end



-- earthquake,if=(buff.echoes_of_great_sundering_es.up|buff.echoes_of_great_sundering_eb.up)&(buff.tempest.up|buff.stormkeeper.up)&talent.surge_of_power.enabled
-- Spend to activate Surge of Power buff for Tempest or Stormkeeper.
if IsReady("Earthquake") and (Player:BuffUp(S.EchoesofGreatSunderingBuff) and (Player:BuffUp(S.TempestBuff) or Player:BuffUp(S.StormkeeperBuff)) and S.SurgeofPower:IsAvailable()) then
  return S.Earthquake:Cast()
end

-- elemental_blast,if=(buff.tempest.up|buff.stormkeeper.up)&talent.surge_of_power.enabled
if IsReady("Elemental Blast") and (Player:BuffUp(S.TempestBuff) or Player:BuffUp(S.StormkeeperBuff)) and S.SurgeofPower:IsAvailable() and cancastAll then
  return S.ElementalBlast:Cast()
end

-- earth_shock,if=(buff.tempest.up|buff.stormkeeper.up)&talent.surge_of_power.enabled
if IsReady("Earth Shock") and (Player:BuffUp(S.TempestBuff) or Player:BuffUp(S.StormkeeperBuff)) and S.SurgeofPower:IsAvailable() then
  return S.EarthShock:Cast()
end

-- tempest
if IsReady("Tempest") and cancastAll and tempest
then
  return S.Tempest:Cast()
end

-- lightning_bolt
-- Filler spell. Always available. Always the bottom line.
if IsReady("Lightning Bolt") and cancastnaturespells then
  return S.LightningBolt:Cast()
end


if IsReady("Earth Shield") and not AuraUtil.FindAuraByName("Earth Shield", "player") and Player:HealthPercentage()<70 and Player:IsMoving() then
  return S.EarthShield:Cast()
  end

-- flame_shock,moving=1,target_if=refreshable
if IsReady("Flame Shock") and Player:IsMoving() and (FSremains<16 or S.FlameShock:TimeSinceLastCast()>1) then
return S.FlameShock:Cast()
end

-- frost_shock,moving=1
-- Frost Shock is our movement filler.
if IsReady("Frost Shock") and Player:IsMoving() then
  return S.FrostShock:Cast()
end




end










local function APL()

  local haveTotem1, totemName1, startTime1, duration1 = GetTotemInfo(1) --air + poison cleansing totem
  local remainingDura1 = (duration1 - (GetTime() - startTime1))
local haveTotem2, totemName2, startTime2, duration2 = GetTotemInfo(2) --earth
  local remainingDura2 = (duration2 - (GetTime() - startTime2))
local haveTotem3, totemName3, startTime3, duration3 = GetTotemInfo(3) --fire
  local remainingDura3 = (duration3 - (GetTime() - startTime3))
local haveTotem4, totemName4, startTime4, duration4 = GetTotemInfo(4) --water
  local remainingDura4 = (duration4 - (GetTime() - startTime4))
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------START OF ROTATION-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
TrackHealthLossPerSecond()
HPpercentloss = GetHealthLossPerSecond()

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

if (Player:CanAttack(Target) or Player:AffectingCombat()) then

  IsTanking = Player:IsTankingAoE(8) or Player:IsTanking(Target)

  -- Store our Maelstrom count into a variable



end

trinket1 = GetInventoryItemID("player", 13)
	
trinket2 = GetInventoryItemID("player", 14)

if trinket1 then
  trinket1ready = C_Item.IsUsableItem(trinket1) and GetItemCooldown(trinket1) == 0 and C_Item.IsEquippedItem(trinket1)
else
  trinket1ready = false
end
  
if trinket2 then
  trinket2ready = C_Item.IsUsableItem(trinket2) and GetItemCooldown(trinket2) == 0 and C_Item.IsEquippedItem(trinket2)
else
  trinket2ready = false
end

VarMaelstrom = Player:Maelstrom()
if AuraUtil.FindAuraByName("Lightning Rod","target","PLAYER|HARMFUL") then
  LRremains = select(6,AuraUtil.FindAuraByName("Lightning Rod","target","PLAYER|HARMFUL")) - GetTime()
   else
    LRremains = 0 
  end

  if AuraUtil.FindAuraByName("Flame Shock","target","PLAYER|HARMFUL") then
    FSremains = select(6,AuraUtil.FindAuraByName("Flame Shock","target","PLAYER|HARMFUL")) - GetTime()
     else
      FSremains = 0 
    end
if (C_Spell.GetSpellInfo("Lightning Bolt").iconID == 5927673 or C_Spell.GetSpellInfo("Lightning Bolt").iconID == 136048 or C_Spell.GetSpellInfo("Lightning Bolt").iconID == 5927653)
then
  tempest = true
else
  tempest = false
end


usespymaster = (Player:BuffStack(S.SpymastersReportBuff) > 35 and Player:PrevGCDP(1, S.Stormkeeper) or Player:BuffRemains(S.AscendanceBuff) > 12 and Player:BuffStack(S.SpymastersReportBuff) > 25) 


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

cancastAll = (not Player:IsMoving() or AuraUtil.FindAuraByName("Spiritwalker's Grace", "player"))
cancastlavaburst = (not Player:IsMoving() or AuraUtil.FindAuraByName("Spiritwalker's Grace", "player") or AuraUtil.FindAuraByName("Lava Surge", "player"))

cancastnaturespells = (not Player:IsMoving() or AuraUtil.FindAuraByName("Spiritwalker's Grace", "player") or AuraUtil.FindAuraByName("Stormkeeper","player") or AuraUtil.FindAuraByName("Nature's Swiftness","player"))



if Target:Exists() and getCurrentDPS() and getCurrentDPS()>0 then
targetTTD = UnitHealth('target')/getCurrentDPS()
else targetTTD = 8888
end


if Player:IsCasting() or Player:IsChanneling() then
return 0, "Interface\\Addons\\Rubim-RH\\Media\\channel.tga"
elseif Player:IsDeadOrGhost() or AuraUtil.FindAuraByName("Drink", "player") or AuraUtil.FindAuraByName("Food", "player") or AuraUtil.FindAuraByName("Food & Drink", "player") then
return 0, "Interface\\Addons\\Rubim-RH\\Media\\griph.tga"
end 



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


if (not IsReady(RubimRH.queuedSpell[1]:ID(),nil,nil,1) or not Player:AffectingCombat() or inRange30 == 0 or S.GhostWolf:ID() ==  RubimRH.queuedSpell[1]:ID() and AuraUtil.FindAuraByName("Ghost Wolf", "player"))
  then
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


if IsReady("Poison Cleansing Totem")  and totemName1 ~= "Poison Cleansing Totem" and (AuraUtil.FindAuraByName("Void Rift", "player", "HARMFUL") or GetAppropriateCureSpell("player")=='Poison') and RubimRH.InterruptsON() then
  return S.PoisonCleansingTotem:Cast()
  end
if IsReady("Cleanse Spirit") and totemName1 ~= "Poison Cleansing Totem"
and (AuraUtil.FindAuraByName("Void Rift", "player", "HARMFUL") or GetAppropriateCureSpell("player")=='Curse') and RubimRH.InterruptsON() and S.PoisonCleansingTotem:TimeSinceLastCast()>7 and S.CleanseSpirit:TimeSinceLastCast()>7 then
  return S.CleanseSpirit:Cast()
  end

  if IsReady("Totemic Recall")  and (S.PoisonCleansingTotem:CooldownRemains()>3 or S.WindRushTotem:CooldownRemains()>3 or S.TremorTotem:CooldownRemains()>3 or S.CapacitorTotem:CooldownRemains()>3)  then
    return S.TotemicRecall:Cast()
    end

if (( Player:AffectingCombat()  or C_Spell.IsCurrentSpell(6603)) and Player:CanAttack(Target)  and not Target:IsDeadOrGhost()) and not AuraUtil.FindAuraByName("Ghost Wolf", "player") then 


if RubimRH.CDsON() then
    --use_items,slots=trinket1,if=buff.between_the_eyes.up|trinket.1.has_stat.any_dps|fight_remains<=20
    if trinket1ready and (trinket1 ~= 220202 or usespymaster and trinket1 == 220202) then
      return Item(118330):Cast()
    end
    --use_items,slots=trinket2,if=buff.between_the_eyes.up|trinket.2.has_stat.any_dps|fight_remains<=20
    if trinket2ready and (trinket2 ~= 220202 or usespymaster and trinket2 == 220202) then
        return Item(114616):Cast()
    end
  end


  if  Player:HealthPercentage() <= 20  and (IsUsableItem(211880) == true and GetItemCooldown(211880) == 0 and GetItemCount(211880) >= 1 or IsUsableItem(211878) == true and GetItemCooldown(211878) == 0 and GetItemCount(211878) >= 1 or IsUsableItem(211879) == true and GetItemCooldown(211879) == 0 and GetItemCount(211879) >= 1) and (not Player:InArena() and not Player:InBattlegrounds()) then
    return I.HPIcon:Cast()
    end
    


if IsReady("Ancestral Guidance") and (Player:HealthPercentage() <= 35 or HPpercentloss>9 and Player:HealthPercentage() <= 50 or defensives() and Player:HealthPercentage()<90) and inRange30>=1 and not AuraUtil.FindAuraByName("Stone Bulwark", "player") then
return S.AncestralGuidance:Cast()
end

if IsReady("Astral Shift") and (Player:HealthPercentage() <= 35 or HPpercentloss>9 and Player:HealthPercentage() <= 50 or defensives() and Player:HealthPercentage()<90)  and inRange30>=1 and not AuraUtil.FindAuraByName("Stone Bulwark", "player") then
return S.AstralShift:Cast()
end
if IsReady("Stone Bulwark Totem") and (Player:HealthPercentage() <= 35 or HPpercentloss>9 and Player:HealthPercentage() <= 50 or defensives() and Player:HealthPercentage()<90) and inRange30>=1 and not AuraUtil.FindAuraByName("Astral Shift", "player") then
return S.StoneBulwarkTotem:Cast()
end

if IsReady("Earth Elemental") and IsTanking and Player:HealthPercentage() <= 35 and inRange30>=2 then
  return S.EarthElemental:Cast()
  end


if IsReady("Tremor Totem") and tremortotem() and RubimRH.InterruptsON() then
  return S.TremorTotem:Cast()
  end




if IsReady("Spiritwalker's Grace") and targetRange40 and (Player:MovingFor()>Player:GCD() or Player:BuffUp(S.AscendanceBuff) and Player:IsMoving()) and not AuraUtil.FindAuraByName("Stormkeeper","player") and not AuraUtil.FindAuraByName("Nature's Swiftness","player")  then
return S.SpiritwalkersGrace:Cast()
end

if IsReady("Nature's Swiftness") and not AuraUtil.FindAuraByName("Nature's Swiftness","player") and RubimRH.CDsON() and targetRange40  then
return S.NaturesSwiftness:Cast()
end

-- if IsReady("Healing Surge") and (AuraUtil.FindAuraByName("Nature's Swiftness","player") or AuraUtil.FindAuraByName("Spiritwalker's Grace","player")) and Player:HealthPercentage()<35 then
-- return S.HealingSurge:Cast()
-- end

if not C_Spell.IsCurrentSpell(6603) and targetRange20 then
return S.autoattack:Cast()
end

if (castTime > 0.1 or channelTime > 0.1) and select(8, UnitCastingInfo("target")) == false and RubimRH.InterruptsON() then

-- kick on GCD
if IsReady("Wind Shear") and targetRange40 and kickprio()  then
return S.WindShear:Cast()
end

end
        --- seasonal affix
        if TWWS1AffixMobsInRange()>=6 and IsReady("Thunderstorm") and RubimRH.InterruptsON() then
          return S.Thunderstorm:Cast()
          end



	if aoe() ~= nil and RubimRH.AoEON() and (inRange40>=2 and not Player:AffectingCombat() or combatmobs40()>=2) and targetRange40 then
		return aoe()
	end

-- Cast  Storm Elemental on cooldown. If you are talented into  Echo of the Elementals, make sure not to cast it while your Elemental is still up. The previous Elemental always needs to naturally expire first.
--   Cast  Primordial Wave on cooldown.
--   Cast  Stormkeeper on cooldown. Don't worry about buffing these  Lightning Bolts.
--   Cast  Lava Burst if your next cast is a spender, so when you are over 47 Maelstrom Maelstrom.
--   Cast  Earth Shock if you have  Master of the Elements active or you are close to capping Maelstrom Maelstrom.
--   Use  Lightning Bolt as your Single Target Filler

if st()~= nil and targetRange40 then
  return st()
end


  
-- if IsReady("Lava Burst") and targetRange40 and AuraUtil.FindAuraByName("Lava Surge","player")  then
-- return S.LavaBurst:Cast()
-- end
-- if IsReady("Earth Shock") and targetRange40 and (AuraUtil.FindAuraByName("Master of the Elements", "player") or VarMaelstrom>70) then
-- return S.EarthShock:Cast()
-- end
-- if IsReady("Lightning Bolt") and targetRange40 and cancast then
-- return S.LightningBolt:Cast()
-- end
-- end


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


-- if IsReady("Flametongue Weapon") and mainHandEnchantID~=5400 and Player:IsMoving() then
-- return S.FlametongueWeapon:Cast()
-- end
if IsReady("Thunderstrike Ward") and offHandEnchantID~=7587 and Player:IsMoving() then
return S.ThunderstrikeWard:Cast()
end
if IsReady("Lightning Shield") and Player:BuffDown(S.LightningShieldBuff) and Player:IsMoving() then
  return S.LightningShield:Cast()
  end
end

return 0, "Interface\\Addons\\Rubim-RH\\Media\\griph.tga"
end 






RubimRH.Rotation.SetAPL(262, APL);

local function PASSIVE()

end

RubimRH.Rotation.SetPASSIVE(262, PASSIVE);