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
local MultiSpell = HL.MultiSpell


FullMoonLastCast = nil
OrbitBreakerStacks = 0


local Item = HL.Item;
local MouseOver = Unit.MouseOver;
-- Lua
local pairs = pairs;
local tableconcat = table.concat;
local tostring = tostring;
local tableinsert = table.insert;

if not Spell.Druid then
    Spell.Druid = {};
end

RubimRH.Spell[102] = {


-- Racials
Berserking                            = Spell(26297),
Shadowmeld                            = Spell(58984),
-- Abilities
Barkskin                              = Spell(22812),
BearForm                              = Spell(5487),
CatForm                               = Spell(768),
FerociousBite                         = Spell(22568),
MarkoftheWild                         = Spell(1126),
Moonfire                              = Spell(8921),
Prowl                                 = MultiSpell(5215,102547),
Regrowth                              = Spell(8936),
Shred                                 = Spell(5221),
-- Talents
AstralInfluence                       = Spell(197524),
ConvoketheSpirits                     = Spell(391528),
FluidForm                             = Spell(449193),
FrenziedRegeneration                  = Spell(22842),
HeartoftheWild                        = Spell(319454),
Innervate                             = Spell(29166),
Ironfur                               = Spell(192081),
Maim                                  = Spell(22570),
MightyBash                            = Spell(5211),
MoonkinForm                           = MultiSpell(24858,197625),
NaturesVigil                          = Spell(124974),
PrimalFury                            = Spell(159286),
ProtectorofthePack                    = Spell(378986),
Rake                                  = Spell(1822),
Renewal                               = Spell(108238),
Rip                                   = Spell(1079),
SkullBash                             = Spell(106839),
Starfire                              = Spell(194153),
Starsurge                             = MultiSpell(78674,197626),
Sunfire                               = Spell(93402),
SurvivalInstincts                     = Spell(61336),
ThrashBear                            = Spell(77758),
ThrashCat                             = Spell(106830),
Typhoon                               = Spell(132469),
WildCharge                            = MultiSpell(16979,49376),
-- Buffs
FrenziedRegenerationBuff              = Spell(22842),
HeartoftheWildBuff                    = Spell(319454),
IronfurBuff                           = Spell(192081),
MarkoftheWildBuff                     = Spell(1126),
PoPHealBuff                           = Spell(395336),
SpymastersReportBuff                  = Spell(451199), -- Stacking buff from before using Spymaster's Web trinket
SpymastersWebBuff                     = Spell(444959), -- Buff from using Spymaster's Web trinket
-- Debuffs
MoonfireDebuff                        = Spell(164812),
RakeDebuff                            = Spell(155722),
RipDebuff                             = Spell(1079),
SunfireDebuff                         = Spell(164815),
ThrashBearDebuff                      = Spell(192090),
ThrashCatDebuff                       = Spell(405233),


  -- Talents
  BoundlessMoonlight                    = Spell(424058),
  LunarCalling                          = Spell(429523),
  LunarInsight                          = Spell(429530),
  MoonGuardian                          = Spell(429520),
 -- Talents
 ControloftheDream                     = Spell(434249),
 EarlySpring                           = Spell(428937),
 PoweroftheDream                       = Spell(434220),
 TreantsoftheMoon                      = Spell(428544),
 -- Buffs
 HarmonyoftheGroveBuff                 = Spell(428735),

 -- Abilities
 EclipseLunar                          = Spell(48518),
 EclipseSolar                          = Spell(48517),
 Starfall                              = Spell(191034),
 Wrath                                 = Spell(190984),
 -- Talents
 AetherialKindling                     = Spell(327541),
 AstralCommunion                       = Spell(400636),
 AstralSmolder                         = Spell(394058),
 BalanceofAllThings                    = Spell(394048),
 CelestialAlignment                    = MultiSpell(194223,383410), -- 194223 without Orbital Strike, 383410 with Orbital Strike
 ElunesGuidance                        = Spell(393991),
 ForceofNature                         = Spell(205636),
 FungalGrowth                          = Spell(392999),
 FuryofElune                           = Spell(202770),
 Incarnation                           = MultiSpell(102560,390414), -- 102560 without Orbital Strike, 390414 with Orbital Strike
 IncarnationTalent                     = Spell(394013),
 NaturesBalance                        = Spell(202430),
 NaturesGrace                          = Spell(450347),
 OrbitBreaker                          = Spell(383197),
 OrbitalStrike                         = Spell(390378),
 PowerofGoldrinn                       = Spell(394046),
 PrimordialArcanicPulsar               = Spell(393960),
 RattletheStars                        = Spell(393954),
 Solstice                              = Spell(343647),
 SouloftheForest                       = Spell(114107),
 Starlord                              = Spell(202345),
 Starweaver                            = Spell(393940),
 StellarFlare                          = Spell(202347),
 Swipe                                 = Spell(213764),
 TouchtheCosmos                        = Spell(450356),
 TwinMoons                             = Spell(279620),
 UmbralEmbrace                         = Spell(393760),
 UmbralIntensity                       = Spell(383195),
 WaningTwilight                        = Spell(393956),
 WarriorofElune                        = Spell(202425),
 WhirlingStars                         = Spell(468743),
 WildMushroom                          = Spell(88747),
 WildSurges                            = Spell(406890),
 -- New Moon Phases
 FullMoon                              = Spell(274283),
 HalfMoon                              = Spell(274282),
 NewMoon                               = Spell(274281),
 -- Buffs
 BOATArcaneBuff                        = Spell(394050),
 BOATNatureBuff                        = Spell(394049),
 CABuff                                = Spell(383410),
 DreamstateBuff                        = Spell(450346),
 IncarnationBuff                       = Spell(390414),
 PAPBuff                               = Spell(393961),
 RattledStarsBuff                      = Spell(393955),
 SolsticeBuff                          = Spell(343648),
 StarfallBuff                          = Spell(191034),
 StarlordBuff                          = Spell(279709),
 StarweaversWarp                       = Spell(393942),
 StarweaversWeft                       = Spell(393944),
 TouchtheCosmosBuff                    = Spell(450360),
 UmbralEmbraceBuff                     = Spell(393763),
 WarriorofEluneBuff                    = Spell(202425),
 -- Debuffs
 FungalGrowthDebuff                    = Spell(81281),
 StellarFlareDebuff                    = Spell(202347),
 -- Tier 29 Effects
 GatheringStarstuff                    = Spell(394412),
 -- Legendary Effects
 BOATArcaneLegBuff                     = Spell(339946),
 BOATNatureLegBuff                     = Spell(339943),
 OnethsClearVisionBuff                 = Spell(339797),
 OnethsPerceptionBuff                  = Spell(339800),
 TimewornDreambinderBuff               = Spell(340049),



 -- Racials
 UrsolsVortex = Spell(102793),
 Soothe = Spell(2908),
 StampedingRoar = Spell(106898),
 SolarBeam = Spell(78675),
 Rebirth = Spell(20484),
 IncapacitatingRoar = Spell(99),

Thrash                                = MultiSpell(77758,106830),

ThrashDebuff                          = MultiSpell(106830,192090),
-- Other
Pool                                  = Spell(999910),

autoattack                  = Spell(291944), -- regeneratin

lustAT = Spell(155145),
lust1 = Spell(57724),
lust2 = Spell(57723),
lust3 = Spell(80354),
lust4 = Spell(95809),
lust5 = Spell(264689),







}
local S = RubimRH.Spell[102] 


if not Item.Druid then Item.Druid = {}; end
Item.Druid.Balance = {
    trink = Item(178751, { 13, 14 }),

    bracer = Item(168978),
    rez = Item(158379),
    drums = Item(193470),
    
    HPIcon = Item(169451),
    tx1 = Item(118330),
    tx2 = Item(114616),

	
};
local I = Item.Druid.Balance;
local ShouldReturn;



local function num(val)
    if val then
        return 1
    else
        return 0
    end
end

local function bool(val)
    return val
end


--- ===== Rotation Variables =====
local VarPassiveAsp
local VarCAEffectiveCD
local VarCDCondition
local VarEclipse, VarEclipseRemains
local VarEnterLunar, VarBoatStacks
local VarConvokeCondition
local CAIncBuffUp
local CAInc = S.IncarnationTalent:IsAvailable() and S.Incarnation or S.CelestialAlignment
local CAIncCD = S.OrbitalStrike:IsAvailable() and 120 or (S.WhirlingStars:IsAvailable() and 80 or 180)
local ConvokeCD = S.ElunesGuidance:IsAvailable() and 60 or 120






local function defensives()
  if Player:AffectingCombat() then
      for id = 1, 15 do
          local spell = {
"Call of the Brood","Massive Slam","Ravenous Swarm","Void Rush","Fierce Stomping","Viscous Darkness","Dark Pulse","Splice","Dark Floes","Shadowy Decay",
"Erosive Spray","Ground Pound","Void Outburst","Earth Shatterer","Crystalline Eruption","Void Discharge","Furious Thrashing","Acid Nova","Wrath of Zolramus",
"Dark Shroud","Shattering Bellow","Crushing Slam","Fiery Ricochet","Umbral Wind","Commanding Roar","Forge Weapon","Void Surge",

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



HL:RegisterForEvent(function()
  CAInc = S.IncarnationTalent:IsAvailable() and S.Incarnation or S.CelestialAlignment
  CAIncCD = S.OrbitalStrike:IsAvailable() and 120 or (S.WhirlingStars:IsAvailable() and 80 or 180)
  ConvokeCD = S.ElunesGuidance:IsAvailable() and 60 or 120
end, "SPELLS_CHANGED", "LEARNED_SPELL_IN_TAB")



local function combatmobs40()
  local totalRange40 = 0

  for id = 1, 15 do -- Keep this at 15 to limit the checks
      local unitID = "nameplate" .. id
      if UnitCanAttack("player", unitID) 
          and C_Spell.IsSpellInRange("Wrath", unitID)
          and UnitHealthMax(unitID) > 5 
          and (UnitAffectingCombat(unitID) or string.sub(UnitName(unitID), -5) == "Dummy") then
          totalRange40 = totalRange40 + 1
      end
  end

  return totalRange40
end


--- ===== Helper Functions =====
local function EnergizeAmount(Spell)
  local TotalAsp = 0
  if Spell == S.Wrath then
    -- Calculate Wrath AsP
    TotalAsp = 8
    if S.WildSurges:IsAvailable() then
      TotalAsp = TotalAsp + 2
    end
    if S.SouloftheForest:IsAvailable() and Player:BuffUp(S.EclipseSolar) then
      TotalAsp = TotalAsp * 1.6
    end
  elseif Spell == S.Starfire then
    -- Calculate Starfire AsP
    TotalAsp = 10
    if S.WildSurges:IsAvailable() then
      TotalAsp = TotalAsp + 2
    end
    if Player:BuffUp(S.WarriorofEluneBuff) then
      TotalAsp = TotalAsp * 1.4
    end
    if S.SouloftheForest:IsAvailable() and Player:BuffUp(S.EclipseLunar) then
      local SotFBonus = (1 + 0.2 * combatmobs40())
      if SotFBonus > 1.6 then SotFBonus = 1.6 end
      TotalAsp = TotalAsp * SotFBonus
    end
  elseif Spell == S.Moonfire then
    -- Calculate Moonfire AsP
    TotalAsp = 6
    if S.MoonGuardian:IsAvailable() then
      TotalAsp = TotalAsp + 2
    end
  elseif Spell == S.Sunfire then
    -- Calculate Sunfire AsP
    TotalAsp = 6
  elseif Spell == S.NewMoon then
    -- Calculate New Moon AsP
    TotalAsp = 10
  elseif Spell == S.HalfMoon then
    -- Calculate Half Moon AsP
    TotalAsp = 20
  elseif Spell == S.FullMoon then
    -- Calculate Full Moon AsP
    TotalAsp = 40
  elseif Spell == S.ForceofNature then
    -- Calculate Force of Nature AsP
    TotalAsp = 20
  end
  return TotalAsp
end


HL:RegisterForSelfCombatEvent(function(dmgTime, _, _, _, _, _, _, _, _, _, _, spellID)
  if spellID == 202497 then
  OrbitBreakerStacks = OrbitBreakerStacks + 1
  end
  if spellID == 274283 then
    if (not S.NewMoon:IsAvailable()) or (S.NewMoon:IsAvailable() and (FullMoonLastCast == nil or dmgTime - FullMoonLastCast > 1.5)) then
     OrbitBreakerStacks = 0
    end
  end
end, "SPELL_DAMAGE")

HL:RegisterForSelfCombatEvent(function(castTime, _, _, _, _, _, _, _, _, _, _, spellID)
  if spellID == 274283 then
  FullMoonLastCast = castTime
  end
end, "SPELL_CAST_SUCCESS")











local function MFactive()
  local MFAoE = 0
  

    
      for id = 1, 40 do
      local unitID = "nameplate" .. id
      if UnitCanAttack("player", unitID) and C_Spell.IsSpellInRange("Moonfire", unitID) and AuraUtil.FindAuraByName("Moonfire",unitID,"PLAYER|HARMFUL") then
        MFAoE = MFAoE + 1
      end
    end
  
    return MFAoE
  end
  
--- ===== CastCycle Functions =====
local function EvaluateCycleMoonfireAoE()
  -- target_if=refreshable&(target.time_to_die-remains)>6&(!talent.treants_of_the_moon|spell_targets-active_dot.moonfire_dmg>6|cooldown.force_of_nature.remains>3&!buff.harmony_of_the_grove.up)
  return Target:DebuffRefreshable(S.MoonfireDebuff) and (Target:TimeToDie() - Target:DebuffRemains(S.MoonfireDebuff)) > 6 
  and (not S.TreantsoftheMoon:IsAvailable() or combatmobs40() - MFactive() > 6 
  or S.ForceofNature:CooldownRemains() > 3 and Player:BuffDown(S.HarmonyoftheGroveBuff))
end

local function EvaluateCycleMoonfireST()
  -- target_if=remains<3&(!talent.treants_of_the_moon|cooldown.force_of_nature.remains>3&!buff.harmony_of_the_grove.up)
  return Target:DebuffRemains(S.MoonfireDebuff) < 3 and (not S.TreantsoftheMoon:IsAvailable() or S.ForceofNature:CooldownRemains() > 3 and Player:BuffDown(S.HarmonyoftheGroveBuff))
end

local function EvaluateCycleMoonfireST2()
  -- target_if=refreshable&(!talent.treants_of_the_moon|cooldown.force_of_nature.remains>3&!buff.harmony_of_the_grove.up)
  return Target:DebuffRefreshable(S.MoonfireDebuff) and (not S.TreantsoftheMoon:IsAvailable() or S.ForceofNature:CooldownRemains() > 3 and Player:BuffDown(S.HarmonyoftheGroveBuff))
end

local function EvaluateCycleStellarFlareAoE()
  -- target_if=refreshable&(target.time_to_die-remains-target>7+spell_targets)
  return Target:DebuffRefreshable(S.StellarFlareDebuff)  and (Target:TimeToDie() - Target:DebuffRemains(S.StellarFlareDebuff) > 7 + combatmobs40())
end

local function EvaluateCycleStellarFlareST()
  -- target_if=refreshable&(target.time_to_die-remains-target>7+spell_targets)
  return Target:DebuffRefreshable(S.StellarFlareDebuff) and (Target:TimeToDie() - Target:DebuffRemains(S.StellarFlareDebuff) > 7 + combatmobs40())
end

local function EvaluateCycleSunfireAoE()
  -- target_if=refreshable&(target.time_to_die-remains)>6-(spell_targets%2)
  return Target:DebuffRefreshable(S.SunfireDebuff) and (Target:TimeToDie() - Target:DebuffRemains(S.SunfireDebuff)) > 6 - (combatmobs40() / 2)
end

local function EvaluateCycleSunfireST()
  -- target_if=remains<3
  return Target:DebuffRemains(S.SunfireDebuff) < 3
end

local function EvaluateCycleSunfireST2()
  -- target_if=refreshable
  return Target:DebuffRefreshable(S.SunfireDebuff)
end



--- ===== Rotation Functions =====
local function Precombat()
  -- flask
  -- food
  -- augmentation
  -- snapshot_stats
  -- variable,name=no_cd_talent,value=!talent.celestial_alignment&!talent.incarnation_chosen_of_elune|druid.no_cds
  -- variable,name=on_use_trinket,value=0
  -- variable,name=on_use_trinket,op=add,value=trinket.1.has_use_buff&!trinket.1.is.ovinaxs_mercurial_egg
  -- variable,name=on_use_trinket,op=add,value=(trinket.2.has_use_buff&!trinket.2.is.ovinaxs_mercurial_egg)*2
  -- Manually added: Group buff check
  if S.MarkoftheWild:IsCastable() and motwremains<300 then
return S.MarkoftheWild:Cast()
  end
  -- moonkin_form
  if S.MoonkinForm:IsCastable() and not Player:BuffUp(S.MoonkinForm) then
return S.MoonkinForm:Cast()
  end
  -- wrath
  if IsReady("Wrath") and not Player:IsCasting(S.Wrath) and not Player:IsMoving() then
return S.Wrath:Cast()
  end
  -- wrath
  if IsReady("Wrath") and (Player:IsCasting(S.Wrath) and S.Wrath:Count() == 2 or Player:PrevGCD(1, S.Wrath) and S.Wrath:Count() == 1) and not Player:IsMoving() then
return S.Wrath:Cast()
  end
  -- starfire,if=!talent.stellar_flare
  if IsReady("Starfire") and (not S.StellarFlare:IsAvailable())  and starfirecastmoving then
    return S.Starfire:Cast()
  end
  -- stellar_flare
  if IsReady("Stellar Flare") and not Player:IsMoving() then
    return S.StellarFlare:Cast()
  end
end  



local function ST()
  -- wrath,if=variable.enter_lunar&variable.eclipse&variable.eclipse_remains<cast_time&!variable.cd_condition
  if IsReady("Wrath") and (VarEnterLunar and VarEclipse and VarEclipseRemains < S.Wrath:CastTime() and not VarCDCondition) and not Player:IsMoving() then
    return S.Wrath:Cast()
  end
  -- starfire,if=!variable.enter_lunar&variable.eclipse&variable.eclipse_remains<cast_time&!variable.cd_condition
  if IsReady("Starfire") and (not VarEnterLunar and VarEclipse and VarEclipseRemains < S.Starfire:CastTime() and not VarCDCondition) and starfirecastmoving and starfireforeclipse then
    return S.Starfire:Cast()
  end
  -- sunfire,target_if=remains<3
  if IsReady("Sunfire") and EvaluateCycleSunfireST() then
    return S.Sunfire:Cast()
  end
  -- moonfire,target_if=remains<3&(!talent.treants_of_the_moon|cooldown.force_of_nature.remains>3&!buff.harmony_of_the_grove.up)
  if IsReady("Moonfire") and EvaluateCycleMoonfireST() then
    return S.Moonfire:Cast()
  end

  if RubimRH.CDsON() and VarCDCondition then
    -- celestial_alignment,if=variable.cd_condition
    if IsReady("Celestial Alignment") then
      return S.CelestialAlignment:Cast()
    end
    -- incarnation,if=variable.cd_condition
    if IsReady("Incarnation") then
      return S.Incarnation:Cast()
    end
    -- local ShouldReturn = UseItems();
    -- if ShouldReturn then return ShouldReturn; end
    
  end
  -- wrath,if=variable.enter_lunar&(!variable.eclipse|variable.eclipse_remains<cast_time)
  if IsReady("Wrath") and (VarEnterLunar and (not VarEclipse or VarEclipseRemains < S.Wrath:CastTime())) and not Player:IsMoving() then
    return S.Wrath:Cast()
  end
  -- starfire,if=!variable.enter_lunar&(!variable.eclipse|variable.eclipse_remains<cast_time)
  if IsReady("Starfire") and (not VarEnterLunar and (not VarEclipse or VarEclipseRemains < S.Starfire:CastTime())) and starfirecastmoving and starfireforeclipse then
    return S.Starfire:Cast()
  end
  -- starsurge,if=variable.cd_condition&astral_power.deficit>variable.passive_asp+action.force_of_nature.energize_amount
  if S.Starsurge:IsCastable() and (VarCDCondition and Player:AstralPowerDeficit() > VarPassiveAsp + EnergizeAmount(S.ForceofNature)) then
    return S.Starsurge:Cast()
  end
  -- force_of_nature,if=cooldown.ca_inc.remains<gcd.max&(!talent.convoke_the_spirits|cooldown.convoke_the_spirits.remains<gcd.max*3|cooldown.convoke_the_spirits.remains>cooldown.ca_inc.full_recharge_time|fight_remains<cooldown.convoke_the_spirits.remains+3)|cooldown.ca_inc.full_recharge_time+5+15*talent.control_of_the_dream>cooldown&(!talent.convoke_the_spirits|cooldown.convoke_the_spirits.remains+10+15*talent.control_of_the_dream>cooldown|fight_remains<cooldown.convoke_the_spirits.remains+cooldown.convoke_the_spirits.duration+5)&(fight_remains>cooldown+5|fight_remains<cooldown.ca_inc.remains+7)|talent.whirling_stars&talent.convoke_the_spirits&cooldown.convoke_the_spirits.remains>cooldown.force_of_nature.duration-10&fight_remains>cooldown.convoke_the_spirits.remains+6
  if IsReady("Force of Nature") and (CAInc:CooldownRemains() < Player:GCD() and (not S.ConvoketheSpirits:IsAvailable() or S.ConvoketheSpirits:CooldownRemains() < Player:GCD() * 3 or S.ConvoketheSpirits:CooldownRemains() > CAInc:FullRechargeTime() or Target:TimeToDie() < S.ConvoketheSpirits:CooldownRemains() + 3) or CAInc:FullRechargeTime() + 5 + 15 * num(S.ControloftheDream:IsAvailable()) > 60 and (not S.ConvoketheSpirits:IsAvailable() or S.ConvoketheSpirits:CooldownRemains() + 10 + 15 * num(S.ControloftheDream:IsAvailable()) > 60 or Target:TimeToDie() < S.ConvoketheSpirits:CooldownRemains() + ConvokeCD + 5) and (Target:TimeToDie() > 65 or Target:TimeToDie() < CAInc:CooldownRemains() + 7) or S.WhirlingStars:IsAvailable() and S.ConvoketheSpirits:IsAvailable() and S.ConvoketheSpirits:CooldownRemains() > 50 and Target:TimeToDie() > S.ConvoketheSpirits:CooldownRemains() + 6) then
    return S.ForceofNature:Cast()
  end
  -- fury_of_elune,if=5+variable.passive_asp<astral_power.deficit
  if IsReady("Fury of Elune") and (5 + VarPassiveAsp < Player:AstralPowerDeficit()) and RubimRH.CDsON() then
    return S.FuryofElune:Cast()
  end
  -- starfall,if=buff.starweavers_warp.up
  if IsReady("Starfall") and (Player:BuffUp(S.StarweaversWarp)) then
    return S.Starfall:Cast()
  end
  -- starsurge,if=talent.starlord&buff.starlord.stack<3
  if IsReady("Starsurge") and (S.Starlord:IsAvailable() and Player:BuffStack(S.StarlordBuff) < 3) then
    return S.Starsurge:Cast()
  end
  -- sunfire,target_if=refreshable
  if IsReady("Sunfire") and EvaluateCycleSunfireST2() then
    return S.Sunfire:Cast()
  end
  -- moonfire,target_if=refreshable&(!talent.treants_of_the_moon|cooldown.force_of_nature.remains>3&!buff.harmony_of_the_grove.up)
  if IsReady("Moonfire") and EvaluateCycleMoonfireST2() then
    return S.Moonfire:Cast()
  end
  -- stellar_flare,target_if=refreshable&(target.time_to_die-remains-target>7+spell_targets)
  if IsReady("Stellar Flare") and EvaluateCycleStellarFlareST() then
    return S.StellarFlare:Cast()
  end
  -- variable,name=convoke_condition,value=fight_remains<5|(buff.ca_inc.up|cooldown.ca_inc.remains>40)&(!hero_tree.keeper_of_the_grove|buff.harmony_of_the_grove.up|cooldown.force_of_nature.remains>15)
  VarConvokeCondition = (Target:TimeToDie() < 5 or (CAIncBuffUp or CAInc:CooldownRemains() > 40) and (Player:HeroTreeID() ~= 23 or Player:BuffUp(S.HarmonyoftheGroveBuff) or S.ForceofNature:CooldownRemains() > 15))
  -- starsurge,if=cooldown.convoke_the_spirits.remains<gcd.max*2&variable.convoke_condition
  if IsReady("Starsurge") and (S.ConvoketheSpirits:CooldownRemains() < Player:GCD() * 2 and VarConvokeCondition) then
    return S.Starsurge:Cast()
  end
  -- convoke_the_spirits,if=variable.convoke_condition
  if IsReady("Convoke the Spirits") and (VarConvokeCondition) then
    return S.ConvoketheSpirits:Cast()
  end
  -- starsurge,if=buff.starlord.remains>4&variable.boat_stacks>=3|fight_remains<4
  if IsReady("Starsurge") and (Player:BuffRemains(S.StarlordBuff) > 4 and VarBoatStacks >= 3 or Target:TimeToDie() < 4) then
    return S.Starsurge:Cast()
  end
  -- new_moon,if=astral_power.deficit>variable.passive_asp+energize_amount|fight_remains<20|cooldown.ca_inc.remains>15
  if S.NewMoon:IsCastable() and not Player:IsMoving() and (Player:AstralPowerDeficit() > VarPassiveAsp + EnergizeAmount(S.NewMoon) or Target:TimeToDie() < 20 or CAInc:CooldownRemains() > 15) then
    return S.NewMoon:Cast()
  end
  -- half_moon,if=astral_power.deficit>variable.passive_asp+energize_amount&(buff.eclipse_lunar.remains>execute_time|buff.eclipse_solar.remains>execute_time)|fight_remains<20|cooldown.ca_inc.remains>15
  if S.HalfMoon:IsCastable() and not Player:IsMoving() and (Player:AstralPowerDeficit() > VarPassiveAsp + EnergizeAmount(S.HalfMoon) and (Player:BuffRemains(S.EclipseLunar) > S.HalfMoon:ExecuteTime() or Player:BuffRemains(S.EclipseSolar) > S.HalfMoon:ExecuteTime()) or Target:TimeToDie() < 20 or CAInc:CooldownRemains() > 15) then
    return S.HalfMoon:Cast()
  end
  -- full_moon,if=astral_power.deficit>variable.passive_asp+energize_amount&(buff.eclipse_lunar.remains>execute_time|buff.eclipse_solar.remains>execute_time)|fight_remains<20|cooldown.ca_inc.remains>15
  if S.FullMoon:IsCastable() and not Player:IsMoving() and (Player:AstralPowerDeficit() > VarPassiveAsp + EnergizeAmount(S.FullMoon) and (Player:BuffRemains(S.EclipseLunar) > S.FullMoon:ExecuteTime() or Player:BuffRemains(S.EclipseSolar) > S.FullMoon:ExecuteTime()) or Target:TimeToDie() < 20 or CAInc:CooldownRemains() > 15) then
    return S.FullMoon:Cast()
  end
  -- starsurge,if=buff.starweavers_weft.up|buff.touch_the_cosmos.up
  if IsReady("Starsurge") and (Player:BuffUp(S.StarweaversWeft) or Player:BuffUp(S.TouchtheCosmosBuff)) then
    return S.Starsurge:Cast()
  end
  -- starsurge,if=astral_power.deficit<variable.passive_asp+action.wrath.energize_amount+(action.starfire.energize_amount+variable.passive_asp)*(buff.eclipse_solar.remains<(gcd.max*3))
  if S.Starsurge:IsCastable() and (Player:AstralPowerDeficit() < VarPassiveAsp + EnergizeAmount(S.Wrath) + (EnergizeAmount(S.Starfire) + VarPassiveAsp) * (num(Player:BuffRemains(S.EclipseSolar) < Player:GCD() * 3))) then
    return S.Starsurge:Cast()
  end
  -- force_of_nature,if=!hero_tree.keeper_of_the_grove
  if IsReady("Force of Nature") and (Player:HeroTreeID() ~= 23) then
    return S.ForceofNature:Cast()
  end
  -- wild_mushroom
  if IsReady("Wild Mushroom") then
    return S.WildMushroom:Cast()
  end
  -- starfire,if=talent.lunar_calling
  if IsReady("Starfire") and (S.LunarCalling:IsAvailable()) and starfirecastmoving and starfireforeclipse then
    return S.Starfire:Cast()
  end
  -- wrath
  if IsReady("Wrath") and not Player:IsMoving() then
    return S.Wrath:Cast()
  end

  if IsReady("Moonfire") and Player:IsMoving() and not Player:PrevGCD(1,S.Moonfire) then
    return S.Moonfire:Cast()
  end

  if IsReady("Sunfire") and Player:IsMoving() then
    return S.Sunfire:Cast()
  end

end

local function AoE()
  -- wrath,if=variable.enter_lunar&variable.eclipse&variable.eclipse_remains<cast_time
  if IsReady("Wrath") and (VarEnterLunar and VarEclipse and VarEclipseRemains < S.Wrath:CastTime()) and not Player:IsMoving() and wrathforeclipse then
    return S.Wrath:Cast()
  end
  -- starfire,if=!variable.enter_lunar&variable.eclipse&variable.eclipse_remains<cast_time
  if IsReady("Starfire") and (not VarEnterLunar and VarEclipse and VarEclipseRemains < S.Starfire:CastTime()) and starfirecastmoving then
    return S.Starfire:Cast()
  end
  -- starfall,if=astral_power.deficit<=variable.passive_asp+6
  if IsReady("Starfall") and (Player:AstralPowerDeficit() <= VarPassiveAsp + 6) then
    return S.Starfall:Cast()
  end
  -- sunfire,target_if=refreshable&(target.time_to_die-remains)>6-(spell_targets%2)
  if IsReady("Sunfire") and EvaluateCycleSunfireAoE() then
    return S.Sunfire:Cast()
  end
  -- moonfire,target_if=refreshable&(target.time_to_die-remains)>6&(!talent.treants_of_the_moon|spell_targets-active_dot.moonfire_dmg>6|cooldown.force_of_nature.remains>3&!buff.harmony_of_the_grove.up),if=!fight_style.dungeonroute&!fight_style.dungeonslice
  if IsReady("Moonfire") and EvaluateCycleMoonfireAoE() then
    return S.Moonfire:Cast()
  end
  -- wrath,if=variable.enter_lunar&(!variable.eclipse|variable.eclipse_remains<cast_time)
  if IsReady("Wrath") and (VarEnterLunar and (not VarEclipse or VarEclipseRemains < S.Wrath:CastTime())) and not Player:IsMoving() and wrathforeclipse then
    return S.Wrath:Cast()
  end
  -- starfire,if=!variable.enter_lunar&(!variable.eclipse|variable.eclipse_remains<cast_time)
  if IsReady("Starfire") and (not VarEnterLunar and (not VarEclipse or VarEclipseRemains < S.Starfire:CastTime())) and starfirecastmoving then
    return S.Starfire:Cast()
  end
  ----CHECK
  -- stellar_flare,target_if=refreshable&(target.time_to_die-remains-target>7+spell_targets),if=spell_targets<(11-talent.umbral_intensity.rank-(2*talent.astral_smolder)-talent.lunar_calling)
  if IsReady("Stellar Flare") and not Player:IsMoving() and EvaluateCycleStellarFlareAoE() and (combatmobs40() < (11 - S.UmbralIntensity:TalentRank() - (2 * num(S.AstralSmolder:IsAvailable())) - num(S.LunarCalling:IsAvailable()))) then
    return S.StellarFlare:Cast()
  end

  -- removed and (Target:TimeToDie() > 65 or CAInc:CooldownRemains() > Target:TimeToDie())
  -- force_of_nature,if=cooldown.ca_inc.remains<gcd.max&(!variable.eclipse|variable.eclipse_remains>6)|variable.eclipse_remains>=3&cooldown.ca_inc.remains>10+15*talent.control_of_the_dream&(fight_remains>cooldown+5|cooldown.ca_inc.remains>fight_remains)
  if IsReady("Force of Nature") and (CAInc:CooldownRemains() < Player:GCD() and (not VarEclipse or VarEclipseRemains > 6) or VarEclipseRemains >= 3 and CAInc:CooldownRemains() > 10 + 15 * num(S.ControloftheDream:IsAvailable()) ) then
    return S.ForceofNature:Cast()
  end
  -- fury_of_elune,if=variable.eclipse
  if IsReady("Fury of Elune") and (VarEclipse) and RubimRH.CDsON() then
    return S.FuryofElune:Cast()
  end
  -- -- call_action_list,name=pre_cd
  -- local ShouldReturn = UseItems();
  -- if ShouldReturn then return ShouldReturn; end

  if RubimRH.CDsON() and VarCDCondition then
    -- celestial_alignment,if=variable.cd_condition
    if IsReady("Celestial Alignment") then
      return S.CelestialAlignment:Cast()
    end
    -- incarnation,if=variable.cd_condition
    if IsReady("Incarnation") then
      return S.Incarnation:Cast()
    end
  end
  -- warrior_of_elune,if=!talent.lunar_calling&buff.eclipse_solar.remains<7|talent.lunar_calling
  if IsReady("Warrior of Elune") and (not S.LunarCalling:IsAvailable() and Player:BuffRemains(S.EclipseSolar) < 7 or S.LunarCalling:IsAvailable()) then
    return S.WarriorofElune:Cast()
  end
  -- starfire,if=(!talent.lunar_calling&spell_targets.starfire=1)&(buff.eclipse_solar.up&buff.eclipse_solar.remains<action.starfire.cast_time|eclipse.in_none)
  if IsReady("Starfire") and starfirecastmoving and ((not S.LunarCalling:IsAvailable() and combatmobs40() == 1) and (Player:BuffUp(S.EclipseSolar) and Player:BuffRemains(S.EclipseSolar) < S.Starfire:CastTime() or not VarEclipse)) then
    return S.Starfire:Cast()
  end
  -- starfall,if=buff.starweavers_warp.up|buff.touch_the_cosmos.up
  if IsReady("Starfall") and (Player:BuffUp(S.StarweaversWarp) or Player:BuffUp(S.TouchtheCosmosBuff)) then
    return S.Starfall:Cast()
  end
  -- starsurge,if=buff.starweavers_weft.up
  if IsReady("Starsurge") and (Player:BuffUp(S.StarweaversWeft)) then
    return S.Starsurge:Cast()
  end
  -- starfall
  if IsReady("Starfall") then
    return S.Starfall:Cast()
  end
  -- convoke_the_spirits,if=(!buff.dreamstate.up&!buff.umbral_embrace.up&spell_targets.starfire<7|spell_targets.starfire=1)&(fight_remains<5|(buff.ca_inc.up|cooldown.ca_inc.remains>40)&(!hero_tree.keeper_of_the_grove|buff.harmony_of_the_grove.up|cooldown.force_of_nature.remains>15))
  if RubimRH.CDsON() and IsReady("Convoke the Spirits") and ((Player:BuffDown(S.DreamstateBuff) and Player:BuffDown(S.UmbralEmbraceBuff) 
  and combatmobs40() < 7 or combatmobs40() == 1) and (Target:TimeToDie() < 5 or (CAIncBuffUp or CAInc:CooldownRemains() > 40) 
  and (Player:HeroTreeID() ~= 34 or Player:BuffUp(S.HarmonyoftheGroveBuff) or S.ForceofNature:CooldownRemains() > 15))) then
    return S.ConvoketheSpirits:Cast()
  end
  -- new_moon
  if IsReady("New Moon") and not Player:IsMoving() then
    return S.NewMoon:Cast()
  end
  -- half_moon
  if IsReady("Half Moon") and not Player:IsMoving() then
    return S.HalfMoon:Cast()
  end
  -- full_moon
  if IsReady("Full Moon") and not Player:IsMoving() then
    return S.FullMoon:Cast()
  end
  -- wild_mushroom
  if IsReady("Wild Mushroom") then
    return S.WildMushroom:Cast()
  end
  -- force_of_nature,if=!hero_tree.keeper_of_the_grove
  if IsReady("Force of Nature") and (Player:HeroTreeID() ~= 23) then
    return S.ForceofNature:Cast()
  end
  -- starfire,if=talent.lunar_calling|buff.eclipse_lunar.up&spell_targets.starfire>1
  if IsReady("Starfire") and starfirecastmoving and (S.LunarCalling:IsAvailable() or Player:BuffUp(S.EclipseLunar) and combatmobs40() > 1) then
  return S.Starfire:Cast()
  end
  -- wrath
  if IsReady("Wrath") and not Player:IsMoving() and wrathforeclipse then
    return S.Wrath:Cast()
  end


  if IsReady("Sunfire")  and Player:IsMoving() and not Player:PrevGCD(1,S.Sunfire)   then
    return S.Sunfire:Cast()
  end

  if IsReady("Moonfire") and Player:IsMoving() then
    return S.Moonfire:Cast()
  end
  



end

  --- ======= MAIN =======
  local function APL()
    TrackHealthLossPerSecond()
    HPpercentloss = GetHealthLossPerSecond()
    inRange5 = RangeCount(5)
    inRange8 = RangeCount(8)
    inRange10 = RangeCount(10)
    inRange15 = RangeCount(15)
    inRange20 = RangeCount(20)
    inRange25 = RangeCount(25)
    inRange30 = RangeCount(30)
    inRange40 = RangeCount("Moonfire")
    
    targetRange5 = C_Item.IsItemInRange(8149, "target")
    targetRange8 = C_Item.IsItemInRange(34368, "target")
    targetRange10 = C_Item.IsItemInRange(32321, "target")
    targetRange15 = C_Item.IsItemInRange(33069, "target")
    targetRange20 = C_Item.IsItemInRange(10645, "target")
    targetRange25 = C_Item.IsItemInRange(24268, "target")
    targetRange30 = C_Item.IsItemInRange(835, "target")
    targetRange40 = C_Spell.IsSpellInRange("Moonfire", "target")

    Enemies10ySplash =  Target:GetEnemiesInSplashRange(10)
      isTanking = Player:IsTankingAoE(8) or Player:IsTanking(Target)
     
  
      -- Check CA/Incarnation Buff Status
      CAIncBuffUp = Player:BuffUp(S.CABuff) or Player:BuffUp(S.IncarnationBuff)
      CAIncBuffRemains = 0
      if CAIncBuffUp then
        CAIncBuffRemains = S.IncarnationTalent:IsAvailable() and Player:BuffRemains(S.IncarnationBuff) or Player:BuffRemains(S.CABuff)
      end
  


      if C_UnitAuras.GetPlayerAuraBySpellID(48518,"player") then
        lunarremains = C_UnitAuras.GetPlayerAuraBySpellID(48518,"player").expirationTime - GetTime()
      else
        lunarremains = 0
      end
      if C_UnitAuras.GetPlayerAuraBySpellID(48517,"player") then
        solarremains = C_UnitAuras.GetPlayerAuraBySpellID(48517,"player").expirationTime - GetTime()
      else
        solarremains = 0
      end
  

      if C_UnitAuras.GetPlayerAuraBySpellID(1126,"player") then
        motwremains = C_UnitAuras.GetPlayerAuraBySpellID(1126,"player").expirationTime - GetTime()
      else
        motwremains = 0
      end

-- variable,name=eclipse,value=buff.eclipse_lunar.up|buff.eclipse_solar.up
VarEclipse = (C_UnitAuras.GetPlayerAuraBySpellID(48518,"player") or C_UnitAuras.GetPlayerAuraBySpellID(48517,"player"))

-- Player:BuffUp(S.EclipseLunar) or Player:BuffUp(S.EclipseSolar)
-- variable,name=eclipse_remains,value=buff.eclipse_lunar.remains<?buff.eclipse_solar.remains
VarEclipseRemains = math.max(lunarremains, solarremains)
-- variable,name=enter_lunar,value=talent.lunar_calling|spell_targets.starfire>2-(talent.umbral_intensity.rank+talent.soul_of_the_forest>1)
VarEnterLunar = (S.LunarCalling:IsAvailable() or combatmobs40() > 2 - num(S.UmbralIntensity:TalentRank() + num(S.SouloftheForest:IsAvailable()) > 1))
-- variable,name=boat_stacks,value=buff.balance_of_all_things_arcane.stack+buff.balance_of_all_things_nature.stack
VarBoatStacks = Player:BuffStack(S.BOATArcaneBuff) + Player:BuffStack(S.BOATNatureBuff)


    
   -- variable,name=passive_asp,value=6%spell_haste+talent.natures_balance+talent.orbit_breaker*dot.moonfire.ticking*(buff.orbit_breaker.stack>(27-2*buff.solstice.up))*24
   VarPassiveAsp = 6 / Player:SpellHaste() + num(S.NaturesBalance:IsAvailable()) + num(S.OrbitBreaker:IsAvailable()) * num(MFactive() > 0) * num(OrbitBreakerStacks > (27 - 2 * num(Player:BuffUp(S.SolsticeBuff)))) * 24
   -- variable,name=ca_effective_cd,value=cooldown.ca_inc.remains<?cooldown.force_of_nature.remains
   VarCAEffectiveCD = math.max(CAInc:CooldownRemains(), S.ForceofNature:CooldownRemains())
   -- variable,name=last_ca_inc,value=fight_remains<cooldown.ca_inc.duration+variable.ca_effective_cd
   VarLastCAInc = Target:TimeToDie() < CAIncCD + VarCAEffectiveCD
   -- variable,name=cd_condition,value=(fight_remains<(15+5*talent.incarnation_chosen_of_elune)*(1-talent.whirling_stars*0.2)|target.time_to_die>10&(!hero_tree.keeper_of_the_grove|buff.harmony_of_the_grove.up)
  --  &(!talent.whirling_stars|!talent.convoke_the_spirits|cooldown.convoke_the_spirits.remains<gcd.max*2|fight_remains<cooldown.convoke_the_spirits.remains+3|cooldown.convoke_the_spirits.remains>cooldown.ca_inc.full_recharge_time))
  --  &cooldown.ca_inc.ready&!buff.ca_inc.up
   VarCDCondition = (Target:TimeToDie() < (15 + 5 * num(S.Incarnation:IsAvailable())) * (1 - num(S.WhirlingStars:IsAvailable()) * 0.2) or Target:TimeToDie() > 10 and (Player:HeroTreeID() ~= 23 or Player:BuffUp(S.HarmonyoftheGroveBuff)) 
   and (not S.WhirlingStars:IsAvailable() or not S.ConvoketheSpirits:IsAvailable() or S.ConvoketheSpirits:CooldownRemains() < Player:GCD() * 2 or Target:TimeToDie() < S.ConvoketheSpirits:CooldownRemains() + 3 
   or S.ConvoketheSpirits:CooldownRemains() > CAInc:FullRechargeTime())) and CAInc:CooldownUp() and Player:BuffDown(CAInc)


wrathforeclipse = (CanCastWithTolerance("Wrath") and S.Wrath:Count() <=1 or S.Wrath:Count() ==2)
starfireforeclipse = (CanCastWithTolerance("Starfire") and S.Starfire:Count() <=1 or S.Starfire:Count() ==2) 
-- print(combatmobs40())


  
    local inInstance, instanceType = IsInInstance()
    
    local level, affixIDs, wasEnergized = C_ChallengeMode.GetActiveKeystoneInfo()
    local highkey = 4



starfirecastmoving = (AuraUtil.FindAuraByName("Warrior of Elune","player") or not Player:IsMoving())


            
    if Target:Exists() and getCurrentDPS() and getCurrentDPS()>0 then
      targetTTD = UnitHealth('target')/getCurrentDPS()
      else targetTTD = 8888
      end
      
          local targetdying =  targetTTD<5
    

          if AuraUtil.FindAuraByName("Sunfire","target","PLAYER|HARMFUL") then
            Sunfiredebuff = select(6,AuraUtil.FindAuraByName("Sunfire","target","PLAYER|HARMFUL")) - GetTime()
             else
                Sunfiredebuff = 0 
            end

            if AuraUtil.FindAuraByName("Moonfire","target","PLAYER|HARMFUL") then
                Moonfiredebuff = select(6,AuraUtil.FindAuraByName("Moonfire","target","PLAYER|HARMFUL")) - GetTime()
                 else
                    Moonfiredebuff = 0 
                end

                if AuraUtil.FindAuraByName("Stellar Flare","target","PLAYER|HARMFUL") then
                    StellarFlareDebuff = select(6,AuraUtil.FindAuraByName("Stellar Flare","target","PLAYER|HARMFUL")) - GetTime()
                     else
                        StellarFlareDebuff = 0 
                    end



    if Player:IsCasting() or Player:IsChanneling() then
        return 0, "Interface\\Addons\\Rubim-RH\\Media\\channel.tga"
    elseif Player:IsDeadOrGhost() or AuraUtil.FindAuraByName("Drink", "player") or AuraUtil.FindAuraByName("Food", "player") or AuraUtil.FindAuraByName("Food & Drink", "player") or  AuraUtil.FindAuraByName("Cat Form", "player") or  AuraUtil.FindAuraByName("Travel Form", "player") or  AuraUtil.FindAuraByName("Bear Form", "player") then
        return 0, "Interface\\Addons\\Rubim-RH\\Media\\griph.tga"
    end 
    

    


    if S.Rebirth:Charges()== nil then
        rezcharges = 0
        else
        rezcharges=S.Rebirth:Charges()
        end
    local castchannelTime = math.random(250, 500) / 1000

    local startTimeMS = select(4, UnitCastingInfo('target')) or 0
    local currentTimeMS = GetTime() * 1000
    local elapsedTimeca = (startTimeMS > 0) and (currentTimeMS - startTimeMS) or 0
    local castTime = elapsedTimeca / 1000
    local startTimeMS = select(4, UnitCastingInfo('target')) or select(4, UnitChannelInfo('target')) or 0
    local currentTimeMS = GetTime() * 1000
    local elapsedTimech = (startTimeMS > 0) and (currentTimeMS - startTimeMS) or 0
    local channelTime = elapsedTimech / 1000
    
                                --health pot -- will need to update item ID of HPs as expansions progress
                                if inRange30 >= 1 and Player:HealthPercentage() <= 30 and Player:AffectingCombat() and (IsUsableItem(191380) == true and
                                GetItemCooldown(191380) == 0 and GetItemCount(191380) >= 1 or IsUsableItem(207023) == true and
                                GetItemCooldown(207023) == 0 and GetItemCount(207023) >= 1)
                                and (not Player:InArena() and not Player:InBattlegrounds()) then
                                return I.HPIcon:Cast()
                                end


                                	 
if S.lustAT:ID() ==  RubimRH.queuedSpell[1]:ID() and Player:DebuffDown(S.lust1) and Player:DebuffDown(S.lust2) and Player:DebuffDown(S.lust3) and Player:DebuffDown(S.lust4) and Player:DebuffDown(S.lust5) then
    return S.lustAT:Cast() -- BIND LUST KEYBIND IN BINDPAD TO ARCANE TORRENT
  end
  
  if S.lustAT:ID() ==  RubimRH.queuedSpell[1]:ID() and (Player:DebuffUp(S.lust1) or Player:DebuffUp(S.lust2) or Player:DebuffUp(S.lust3) or Player:DebuffUp(S.lust4) or Player:Debuff(S.lust5)) then
  RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
  end
  
  if (not IsReady(RubimRH.queuedSpell[1]:ID(),nil,nil,1) or not Player:AffectingCombat() or inRange30 == 0) then
    RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
    end
  
  if IsReady(RubimRH.queuedSpell[1]:ID(),nil,nil,1) then
    return RubimRH.QueuedSpell():Cast()
  end
  

 

            -- print(IsReady("Intercession",nil,nil,1,1) , UnitIsDeadOrGhost("focus") , (rezcharges>=1 or level ==0) , los == false , UnitExists('focus') , C_Spell.IsSpellInRange("Flash of Light", "focus"))
            if IsReady("Rebirth",nil,nil,1,1) and UnitIsDeadOrGhost("focus") and (rezcharges>=1 or level ==0) then
                if IsReady("Rebirth") then
                  return S.Rebirth:Cast()
               
                end
              end
              


    if IsReady("Moonkin Form") and (not AuraUtil.FindAuraByName("Cat Form","player") and not AuraUtil.FindAuraByName("Travel Form","player") or Player:CanAttack(Target) and not Target:IsDeadOrGhost() and targetRange30) and not AuraUtil.FindAuraByName("Moonkin Form","player") and Player:IsMoving() then
        return S.MoonkinForm:Cast()
      end
  

    if IsReady("Mark of the Wild") and motwremains <300 and not Player:AffectingCombat()  and Player:IsMoving() then
        return S.MarkoftheWild:Cast()
      end


	-- --Shiv
	-- if IsReady("Soothe") and targetRange30 and Player:AffectingCombat() and targetTTD > 8 then
	-- 	return S.Soothe:Cast()
	-- end



    --   -- Precombat
      if not Player:AffectingCombat() and Player:CanAttack(Target) and not Target:IsDeadOrGhost() and C_Spell.IsCurrentSpell(6603) and targetRange40 then
        local ShouldReturn = Precombat(); if ShouldReturn then return ShouldReturn; end
      end

      if (( Player:AffectingCombat()  or C_Spell.IsCurrentSpell(6603)) and Player:CanAttack(Target)  and not Target:IsDeadOrGhost()) and not AuraUtil.FindAuraByName("Travel Form", "player") then 

        if IsReady("Moonkin Form") and ( Player:CanAttack(Target) and not Target:IsDeadOrGhost()) and targetRange40 and not AuraUtil.FindAuraByName("Moonkin Form","player") then
          return S.MoonkinForm:Cast()
        end
    


        if  Player:HealthPercentage() <= 20 and not IsReady("Renewal") and (IsUsableItem(211880) == true and GetItemCooldown(211880) == 0 and GetItemCount(211880) >= 1 or IsUsableItem(211878) == true and GetItemCooldown(211878) == 0 and GetItemCount(211878) >= 1 or IsUsableItem(211879) == true and GetItemCooldown(211879) == 0 and GetItemCount(211879) >= 1) and (not Player:InArena() and not Player:InBattlegrounds()) then
          return I.HPIcon:Cast()
          end
          if IsReady("Regrowth") and Player:HealthPercentage() <= 50 and inRange30>=1 and AuraUtil.FindAuraByName("Blooming Infusion", "player") then
            return S.Renewal:Cast()
            end

          if IsReady("Renewal") and Player:HealthPercentage() <= 35 and inRange30>=1 then
            return S.Renewal:Cast()
            end
          

if IsReady("Nature's Vigil") and (Player:HealthPercentage() <= 35 or HPpercentloss>9 and Player:HealthPercentage() <= 50 or defensives() and Player:HealthPercentage()<90) and inRange30>=1 and not AuraUtil.FindAuraByName("Barkskin", "player") then
  return S.NaturesVigil:Cast()
  end
  
  if IsReady("Barkskin") and (Player:HealthPercentage() <= 35 or HPpercentloss>9 and Player:HealthPercentage() <= 50 or defensives() and Player:HealthPercentage()<90)  and inRange30>=1 and not AuraUtil.FindAuraByName("Nature's Vigil", "player") then
  return S.Barkskin:Cast()
  end

  
          

          if (castTime > 0.1 or channelTime > 0.1) and select(8, UnitCastingInfo("target")) == false and RubimRH.InterruptsON() and not isEnraged then


            -- kick on GCD
            if IsReady("Solar Beam") and kickprio() and targetRange30 and Player:GCDRemains()<0.5 then
            return S.SolarBeam:Cast()
            end
    
          end





          
if not C_Spell.IsCurrentSpell(6603) and targetRange20 then
  return S.autoattack:Cast()
  end


-- -- berserking,if=variable.no_cd_talent|fight_remains<15
-- if RubimRH.CDsON() and S.Berserking:IsCastable() and Player:BuffUp(S.CelestialAlignment) then
--   return S.Berserking:Cast() 
-- end

-- warrior_of_elune,if=talent.lunar_calling|!talent.lunar_calling&variable.eclipse_remains>=7&cooldown.ca_inc.remains>20
if IsReady("Warrior of Elune") and (S.LunarCalling:IsAvailable() or (VarEclipseRemains >= 7 and CAInc:CooldownRemains() > 20)) then
  return S.WarriorofElune:Cast() 
end



    if AoE() ~= nil and RubimRH.AoEON() and (inRange40>=2 and not Player:AffectingCombat() or combatmobs40()>=2) and targetRange40 then
      return AoE()
    end
  
    if ST()~= nil and targetRange40 and (combatmobs40()<=1 or not RubimRH.AoEON()) then
      return ST()
    end

  end

        -- if HR.CastAnnotated(S.Pool, false, "WAIT/ST") then return "Wait for ST"; end
      
    

    return 0, "Interface\\Addons\\Rubim-RH\\Media\\griph.tga"
end 



RubimRH.Rotation.SetAPL(102, APL);

local function PASSIVE()
    return RubimRH.Shared()
end

RubimRH.Rotation.SetPASSIVE(102, PASSIVE);