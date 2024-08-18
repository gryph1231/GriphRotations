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
 UrsolsVortex = Spell(102793),
 Soothe = Spell(2908),
 Typhoon = Spell(132469),
 StampedingRoar = Spell(106898),
 SolarBeam = Spell(78675),
 Rebirth = Spell(20484),
 IncapacitatingRoar = Spell(99),
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
ProtectorofthePack                    = Spell(378986),
Rake                                  = Spell(1822),
Renewal                               = Spell(108238),
Rip                                   = Spell(1079),
SkullBash                             = Spell(106839),
Starfire                              = Spell(194153),
Starsurge                             = MultiSpell(78674,197626),
Sunfire                               = Spell(93402),
SurvivalInstincts                     = Spell(61336),
Thrash                                = MultiSpell(77758,106830),
WildCharge                            = MultiSpell(16979,49376),
-- Buffs
FrenziedRegenerationBuff              = Spell(22842),
HeartoftheWildBuff                    = Spell(319454),
IronfurBuff                           = Spell(192081),
MarkoftheWildBuff                     = Spell(1126),
PoPHealBuff                           = Spell(395336),
-- Debuffs
MoonfireDebuff                        = Spell(164812),
RakeDebuff                            = Spell(155722),
RipDebuff                             = Spell(1079),
SunfireDebuff                         = Spell(164815),
ThrashDebuff                          = MultiSpell(106830,192090),
-- Other
Pool                                  = Spell(999910),
-- Abilities
EclipseLunar                          = Spell(48518),
EclipseSolar                          = Spell(48517),
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
OrbitBreaker                          = Spell(383197),
OrbitalStrike                         = Spell(390378),
PowerofGoldrinn                       = Spell(394046),
PrimordialArcanicPulsar               = Spell(393960),
RattletheStars                        = Spell(393954),
Solstice                              = Spell(343647),
SouloftheForest                       = Spell(114107),
Starfall                              = Spell(191034),
Starlord                              = Spell(202345),
Starweaver                            = Spell(393940),
StellarFlare                          = Spell(202347),
Swipe                                 = Spell(213764),
TwinMoons                             = Spell(279620),
UmbralEmbrace                         = Spell(393760),
UmbralIntensity                       = Spell(383195),
WaningTwilight                        = Spell(393956),
WarriorofElune                        = Spell(202425),
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
DreamstateBuff                        = Spell(424248), -- T31 2pc
IncarnationBuff                       = Spell(390414),
PAPBuff                               = Spell(393961),
RattledStarsBuff                      = Spell(393955),
SolsticeBuff                          = Spell(343648),
StarfallBuff                          = Spell(191034),
StarlordBuff                          = Spell(279709),
StarweaversWarp                       = Spell(393942),
StarweaversWeft                       = Spell(393944),
UmbralEmbraceBuff                     = Spell(393763),
WarriorofEluneBuff                    = Spell(202425),
-- Debuffs
FungalGrowthDebuff                    = Spell(81281),
StellarFlareDebuff                    = Spell(202347),
-- Tier 29 Effects
GatheringStarstuff                    = Spell(394412),
TouchtheCosmos                        = Spell(394414),
-- Legendary Effects
BOATArcaneLegBuff                     = Spell(339946),
BOATNatureLegBuff                     = Spell(339943),
OnethsClearVisionBuff                 = Spell(339797),
OnethsPerceptionBuff                  = Spell(339800),
TimewornDreambinderBuff               = Spell(340049),
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

-- Rotation Variables
local VarInit = false
local VarNoCDTalent
local VarWrathBaseAsp
local VarStarfireBaseAsp
local VarSolarEclipseST
local VarOnUseTrinket
local VarIsAoe
local VarIsCleave
local VarPassiveAsp
local VarCDConditionST
local VarCDConditionAoE
local VarEnterEclipse
local VarEnterSolar
local VarConvokeCondition
local PAPValue
local CAIncBuffUp
local CAIncBuffRemains


-- CA/Incarnation Variable
local CaInc = S.IncarnationTalent:IsAvailable() and S.Incarnation or S.CelestialAlignment

-- Eclipse Variables
local EclipseInAny = false
local EclipseInBoth = false
local EclipseInLunar = false
local EclipseInSolar = false
local EclipseLunarNext = false
local EclipseSolarNext = false
local EclipseAnyNext = false




HL:RegisterForEvent(function()
  CaInc = S.IncarnationTalent:IsAvailable() and S.Incarnation or S.CelestialAlignment
  VarInit = false
end, "SPELLS_CHANGED", "LEARNED_SPELL_IN_TAB")

-- Enemy Variables


-- CastCycle/CastTargetIf Functions
local function EvaluateCycleSunfireST(Target)
    -- target_if=refreshable&remains<2&(target.time_to_die-remains)>6
    local Remains = Target:DebuffRemains(S.SunfireDebuff)
    return (Target:DebuffRefreshable(S.SunfireDebuff) and Remains < 2 and (targetTTD - Remains) > 6)
  end
  
  local function EvaluateCycleSunfireST2(Target)

    -- target_if=refreshable&astral_power.deficit>variable.passive_asp+energize_amount
    return (Target:DebuffRefreshable(S.SunfireDebuff) and APDeficit > VarPassiveAsp + EnergizeAmountSunfire)
  end
  
  local function EvaluateCycleMoonfireST(Target)
    -- target_if=refreshable&remains<2&(target.time_to_die-remains)>6
    local Remains = Target:DebuffRemains(S.MoonfireDebuff)
    return (Target:DebuffRefreshable(S.MoonfireDebuff) and Remains < 2 and (targetTTD - Remains) > 6)
  end
  
  local function EvaluateCycleMoonfireST2(Target)
    -- target_if=refreshable&astral_power.deficit>variable.passive_asp+energize_amount
    return (Target:DebuffRefreshable(S.MoonfireDebuff) and APDeficit > VarPassiveAsp + EnergizeAmountMoonfire)
  end
  
  local function EvaluateCycleStellarFlareST(Target)
    -- target_if=refreshable&astral_power.deficit>variable.passive_asp+energize_amount&remains<2&(target.time_to_die-remains)>8
    local Remains = Target:DebuffRemains(S.StellarFlareDebuff)
    return (Target:DebuffRefreshable(S.StellarFlareDebuff) and APDeficit > VarPassiveAsp + EnergizeAmountStellarFlare and Remains < 2 and (targetTTD - Remains) > 8)
  end
  
  local function EvaluateCycleStellarFlareST2(Target)
    -- target_if=refreshable&astral_power.deficit>variable.passive_asp+energize_amount
    return (Target:DebuffRefreshable(S.StellarFlareDebuff) and APDeficit > VarPassiveAsp + EnergizeAmountStellarFlare)
  end
  
  local function EvaluateCycleSunfireAoE(Target)
    -- target_if=refreshable&(target.time_to_die-remains)>6-(spell_targets%2)&astral_power.deficit>variable.passive_asp+energize_amount
    return (Target:DebuffRefreshable(S.SunfireDebuff) and (targetTTD - Target:DebuffRemains(S.SunfireDebuff)) > 6 - (GetMobsInCombat() / 2) and APDeficit > VarPassiveAsp + EnergizeAmountSunfire)
  end
  
  local function EvaluateCycleMoonfireAoE(Target)
    -- target_if=refreshable&(target.time_to_die-remains)>6&astral_power.deficit>variable.passive_asp+energize_amount
    return (Target:DebuffRefreshable(S.MoonfireDebuff) and (targetTTD - Target:DebuffRemains(S.MoonfireDebuff)) > 6 and APDeficit > VarPassiveAsp + EnergizeAmountMoonfire)
  end
  
  local function EvaluateCycleStellarFlareAoE(Target)
    -- target_if=refreshable&(target.time_to_die-remains-spell_targets.starfire)>8+spell_targets.starfire
    return (Target:DebuffRefreshable(S.StellarFlareDebuff) and (targetTTD - Target:DebuffRemains(S.StellarFlareDebuff) - GetMobsInCombat()) > 8 + GetMobsInCombat())
  end
  
  local function EvaluateCycleSunfireFallthru(Target)
    -- target_if=dot.moonfire.remains>remains*22%18
    return (Target:DebuffRemains(S.MoonfireDebuff) > (Target:DebuffRemains(S.SunfireDebuff) * 22 / 18))
  end
  
  -- Other Functions
  local function EclipseCheck()
    EclipseInAny = (Player:BuffUp(S.EclipseSolar) or Player:BuffUp(S.EclipseLunar))
    EclipseInBoth = (Player:BuffUp(S.EclipseSolar) and Player:BuffUp(S.EclipseLunar))
    EclipseInLunar = (Player:BuffUp(S.EclipseLunar) and Player:BuffDown(S.EclipseSolar))
    EclipseInSolar = (Player:BuffUp(S.EclipseSolar) and Player:BuffDown(S.EclipseLunar))
    EclipseLunarNext = (not EclipseInAny and (S.Starfire:Count() == 0 and S.Wrath:Count() > 0 or Player:IsCasting(S.Wrath))) or EclipseInSolar
    EclipseSolarNext = (not EclipseInAny and (S.Wrath:Count() == 0 and S.Starfire:Count() > 0 or Player:IsCasting(S.Starfire))) or EclipseInLunar
    EclipseAnyNext = (not EclipseInAny and S.Wrath:Count() > 0 and S.Starfire:Count() > 0)
  end
  
  local function InitVars()
    -- variable,name=no_cd_talent,value=!talent.celestial_alignment&!talent.incarnation_chosen_of_elune|druid.no_cds
    VarNoCDTalent = not S.CelestialAlignment:IsAvailable() and not S.IncarnationTalent:IsAvailable() or not RubimRH.CDsON()
    -- variable,name=on_use_trinket,value=0
    VarOnUseTrinket = 0

  
    VarInit = true
  end
  
  local function Precombat()
    -- flask
    -- food
    -- augmentation
    -- snapshot_stats
    -- Manually added: Group buff check


    -- wrath
    if S.Wrath:IsCastable() and not Player:IsCasting(S.Wrath) and not Player:IsMoving() then
        return S.Wrath:Cast()
    end
    -- wrath
    if S.Wrath:IsCastable() and not Player:IsMoving() and (Player:IsCasting(S.Wrath) and S.Wrath:Count() == 2 or Player:PrevGCD(1, S.Wrath) and S.Wrath:Count() == 1) then
        return S.Wrath:Cast()
    end
    -- stellar_flare
    if S.StellarFlare:IsCastable() then
        return S.StellarFlare:Cast()
    end
    -- starfire,if=!talent.stellar_flare
    if S.Starfire:IsCastable() and starfirecastmoving and (not S.StellarFlare:IsAvailable()) then
        return S.Starfire:Cast()
    end
  end
  
  local function Fallthru()
    -- starfall,if=variable.is_aoe
    if S.Starfall:IsReady() and (VarIsAoe) then
        return S.Starfall:Cast()
    end
    -- starsurge
    if S.Starsurge:IsReady() then
        return S.Starsurge:Cast()
    end
    -- wild_mushroom,if=!variable.is_aoe
    if S.WildMushroom:IsReady() and (not VarIsAoe) then
        return S.WildMushroom:Cast()
    end
    -- sunfire,target_if=dot.moonfire.remains>remains*22%18
    if S.Sunfire:IsCastable() and EvaluateCycleSunfireFallthru(Target) then
        return S.Sunfire:Cast()
    end
    -- moonfire
    if S.Moonfire:IsCastable() then
        return S.Moonfire:Cast()
    end
  end
  
  local function St()


    if S.Starfire:TimeSinceLastCast()>C_Spell.GetSpellInfo("Starfire").castTime*.001-0.1 and (S.Starfire:Count()==2 or S.Starfire:Count() ==1 and not Player:IsCasting(S.Starfire)) then
        caststarfire = true
    else
        caststarfire = false
    end
    if IsReady("Moonfire") and  Moonfiredebuff < 22*0.3 + Player:GCDRemains() then
      return S.Moonfire:Cast()
  end
    if IsReady("Sunfire") and  Sunfiredebuff< 18*0.3 + Player:GCDRemains() then
        return S.Sunfire:Cast()
    end
    

    
    if IsReady("Stellar Flare") and  StellarFlareDebuff < 24*0.3 + Player:GCDRemains()  then
        return S.StellarFlare:Cast()
    end
    if IsReady("Berserking") and RubimRH.CDsON() and AuraUtil.FindAuraByName("Incarnation: Chosen of Elune", "player") then
        return S.Berserking:Cast()
    end
    if IsReady("Incarnation: Chosen of Elune") and RubimRH.CDsON() then
        return S.Incarnation:Cast()
    end
    
    -- -- variable,name=solar_eclipse_st,value=buff.primordial_arcanic_pulsar.value<520&cooldown.ca_inc.remains>5&spell_targets.starfire<3|set_bonus.tier31_2pc
    -- VarSolarEclipseST = PAPValue < 520 and CaInc:CooldownRemains() > 5 and GetMobsInCombat() < 3 or Player:HasTier(31, 2)
    -- -- variable,name=enter_eclipse,value=eclipse.any_next|variable.solar_eclipse_st&buff.eclipse_solar.up&(buff.eclipse_solar.remains<action.starfire.cast_time)|!variable.solar_eclipse_st&buff.eclipse_lunar.up&(buff.eclipse_lunar.remains<action.wrath.cast_time)
    VarEnterEclipse = (EclipseAnyNext or VarSolarEclipseST and Player:BuffUp(S.EclipseSolar) and (Player:BuffRemains(S.EclipseSolar) < S.Starfire:CastTime()) or not VarSolarEclipseST and Player:BuffUp(S.EclipseLunar) and (Player:BuffRemains(S.EclipseLunar) < S.Wrath:CastTime()))
    -- -- warrior_of_elune,if=variable.solar_eclipse_st&(variable.enter_eclipse|buff.eclipse_solar.remains<7)
    -- if S.WarriorofElune:IsCastable() and (VarSolarEclipseST and (VarEnterEclipse or Player:BuffRemains(S.EclipseSolar) < 7)) then
    --     return S.WarriorofElune:Cast()
    -- end
    -- -- starfire,if=variable.enter_eclipse&(variable.solar_eclipse_st|buff.eclipse_solar.up)
    -- if S.Starfire:IsCastable() and not Player:IsMoving() and (VarEnterEclipse and (VarSolarEclipseST or Player:BuffUp(S.EclipseSolar))) then
    --     return S.Starfire:Cast()
    -- end
    -- starfire,if=variable.enter_eclipse&(variable.solar_eclipse_st|buff.eclipse_solar.up)

    if IsReady("Starfire") and starfirecastmoving and (S.Starfire:Count() == 2 or S.Starfire:Count() == 1 and not Player:IsCasting(S.Starfire) and caststarfire ) and not AuraUtil.FindAuraByName("Eclipse (Solar)", "player") then
        return S.Starfire:Cast()
    end


    if IsReady("Starsurge") and (Player:BuffStack(S.StarlordBuff)<3 and AuraUtil.FindAuraByName("Balance of All Things", "player") or Player:AstralPower()>80) then
        return S.Starsurge:Cast()
    end
    
    if IsReady("Wrath") then
        return S.Wrath:Cast()
    end
    
    


    if IsReady("Moonfire") and S.Moonfire:TimeSinceLastCast()>S.Sunfire:TimeSinceLastCast() then
      return S.Moonfire:Cast()
    end
    if IsReady("Sunfire") and S.Sunfire:TimeSinceLastCast()>S.Moonfire:TimeSinceLastCast() then
      return S.Sunfire:Cast()
    end




--     -- sunfire,target_if=refreshable&remains<2&(target.time_to_die-remains)>6
--     if S.Sunfire:IsCastable() and EvaluateCycleSunfireST(Target) then
--         return S.Sunfire:Cast()
--     end
--     -- variable,name=cd_condition_st,value=!druid.no_cds&(cooldown.ca_inc.remains<5&!buff.ca_inc.up&(target.time_to_die>15&buff.primordial_arcanic_pulsar.value<480|fight_remains<25+10*talent.incarnation_chosen_of_elune))
--     VarCDConditionST = RubimRH.CDsON() and (CaInc:CooldownRemains() < 5 and not CAIncBuffUp and (targetTTD> 15 and PAPValue < 480 or aoeTTD() < 25 + 10 * num(S.Incarnation:IsAvailable())))
--     -- moonfire,target_if=refreshable&remains<2&(target.time_to_die-remains)>6
--     if S.Moonfire:IsCastable() and EvaluateCycleMoonfireST then
--         return S.Moonfire:Cast()
--     end
--     -- stellar_flare,target_if=refreshable&astral_power.deficit>variable.passive_asp+energize_amount&remains<2&(target.time_to_die-remains)>8
--     if S.StellarFlare:IsCastable() and EvaluateCycleStellarFlareST(Target) then
--         return S.StellarFlare:Cast()
--     end
--     -- cancel_buff,name=starlord,if=buff.starlord.remains<2&(buff.primordial_arcanic_pulsar.value>=550&!buff.ca_inc.up&buff.starweavers_warp.up|buff.primordial_arcanic_pulsar.value>=560&buff.starweavers_weft.up)
--     -- if Settings.Balance.ShowCancelStarlord and Player:BuffUp(S.StarlordBuff) and Player:BuffRemains(S.StarlordBuff) < 2 and (PAPValue >= 550 and not CAIncBuffUp and Player:BuffUp(S.StarweaversWarp) or PAPValue >= 560 and Player:BuffUp(S.StarweaversWeft)) then
--     --   if HR.CastAnnotated(S.Starlord, false, "CANCEL") then return "cancel_buff starlord st 11"; end
--     -- end
--     -- starfall,if=buff.primordial_arcanic_pulsar.value>=550&!buff.ca_inc.up&buff.starweavers_warp.up&!buff.starweavers_weft.up
--     if S.Starfall:IsReady() and (PAPValue >= 550 and not CAIncBuffUp and Player:BuffUp(S.StarweaversWarp) and Player:BuffDown(S.StarweaversWeft)) then
--         return S.Starfall:Cast()
--     end
--     -- starsurge,if=buff.primordial_arcanic_pulsar.value>=560&buff.starweavers_weft.up
--     if S.Starsurge:IsReady() and (PAPValue >= 560 and Player:BuffUp(S.StarweaversWeft)) then
--         return S.Starsurge:Cast()
--     end
--     -- starfire,if=buff.dreamstate.up&variable.cd_condition_st&eclipse.in_lunar
--     if S.Starfire:IsReady() and not Player:IsMoving() and (Player:BuffUp(S.DreamstateBuff) and VarCDConditionST and EclipseInLunar) then
--         return S.Starfire:Cast()
--     end
--     -- wrath,if=buff.dreamstate.up&variable.cd_condition_st&buff.eclipse_solar.up
--     if S.Wrath:IsReady() and not Player:IsMoving() and (Player:BuffUp(S.DreamstateBuff) and VarCDConditionST and Player:BuffUp(S.EclipseSolar)) then
--         return S.Wrath:Cast()
--     end
--     -- starsurge,if=buff.touch_the_cosmos.up&variable.cd_condition_st
--     if S.Starsurge:IsReady() and (Player:BuffUp(S.TouchtheCosmos) and VarCDConditionST) then
--         return S.Starsurge:Cast()
--     end
--     if RubimRH.CDsON() then
--       -- celestial_alignment,if=variable.cd_condition_st
--       if S.CelestialAlignment:IsCastable() and (VarCDConditionST) then
--         return S.CelestialAlignment:Cast()
--     end
--       -- incarnation,if=variable.cd_condition_st
--       if S.Incarnation:IsCastable() and (VarCDConditionST) then
--         return S.Incarnation:Cast()
--     end
--     end

--     -- variable,name=convoke_condition,value=buff.ca_inc.remains>4|(cooldown.ca_inc.remains>30|variable.no_cd_talent)&(buff.eclipse_lunar.remains>4|buff.eclipse_solar.remains>4)
--     VarConvokeCondition = (CAIncBuffRemains > 4 or (CaInc:CooldownRemains() > 30 or VarNoCDTalent) and (Player:BuffRemains(S.EclipseLunar) > 4 or Player:BuffRemains(S.EclipseSolar) > 4))
--     -- starsurge,if=talent.convoke_the_spirits&cooldown.convoke_the_spirits.ready&variable.convoke_condition
--     if S.Starsurge:IsReady() and (S.ConvoketheSpirits:IsAvailable() and S.ConvoketheSpirits:IsCastable() and VarConvokeCondition) then
--         return S.Starsurge:Cast()
--     end
--     -- convoke_the_spirits,if=variable.convoke_condition
--     if S.ConvoketheSpirits:IsCastable() and RubimRH.CDsON() and (VarConvokeCondition) then
--         return S.ConvoketheSpirits:Cast()
--     end
--     -- astral_communion,if=astral_power.deficit>variable.passive_asp+energize_amount
--     if S.AstralCommunion:IsCastable() and (APDeficit > VarPassiveAsp + EnergizeAmountAstralCommunion) then
--         return S.AstralCommunion:Cast()
--     end
--     -- force_of_nature,if=astral_power.deficit>variable.passive_asp+energize_amount
--     if S.ForceofNature:IsCastable() and RubimRH.CDsON() and (APDeficit > VarPassiveAsp + EnergizeAmountForceofNature) then
--         return S.ForceofNature:Cast()
--     end
--     -- fury_of_elune,if=target.time_to_die>2&(buff.ca_inc.remains>3|cooldown.ca_inc.remains>30&buff.primordial_arcanic_pulsar.value<=280|buff.primordial_arcanic_pulsar.value>=560&astral_power>50)|fight_remains<10
--     if S.FuryofElune:IsCastable() and (targetTTD > 2 and (CAIncBuffRemains > 3 or CaInc:CooldownRemains() > 30 and PAPValue <= 280 or PAPValue >= 560 and Player:AstralPowerP() > 50) or aoeTTD() < 10) then
--         return S.FuryofElune:Cast()
--     end
--     -- starfall,if=buff.starweavers_warp.up&!buff.starweavers_weft.up
--     if S.Starfall:IsReady() and (Player:BuffUp(S.StarweaversWarp) and Player:BuffDown(S.StarweaversWeft)) then
--         return S.Starfall:Cast()
--     end
--     -- variable,name=starsurge_condition1,value=talent.starlord&buff.starlord.stack<3|(buff.balance_of_all_things_arcane.stack+buff.balance_of_all_things_nature.stack)>2&buff.starlord.remains>4
--     local VarStarsurgeCondition1 = (S.Starlord:IsAvailable() and Player:BuffStack(S.StarlordBuff) < 3 or (Player:BuffStack(S.BOATArcaneBuff) + Player:BuffStack(S.BOATNatureBuff)) > 2 and Player:BuffRemains(S.StarlordBuff) > 4)
--     -- wrath,if=buff.gathering_starstuff.stack=3&astral_power.deficit>variable.passive_asp+energize_amount
--     if S.Wrath:IsReady() and (Player:BuffStack(S.GatheringStarstuff) == 3 and APDeficit > VarPassiveAsp + EnergizeAmountWrath) then
--         return S.Wrath:Cast()
--     end
--     -- -- cancel_buff,name=starlord,if=buff.starlord.remains<2&variable.starsurge_condition1
--     -- if Settings.Balance.ShowCancelStarlord and Player:BuffUp(S.StarlordBuff) and Player:BuffRemains(S.StarlordBuff) < 2 and VarStarsurgeCondition1 then
--     --   if HR.CastAnnotated(S.Starlord, false, "CANCEL") then return "cancel_buff starlord st 40"; end
--     -- end
--     -- starsurge,if=variable.starsurge_condition1
--     if S.Starsurge:IsReady() and (VarStarsurgeCondition1) then
--         return S.Starsurge:Cast()
--     end
--     -- sunfire,target_if=refreshable&astral_power.deficit>variable.passive_asp+energize_amount
--     if S.Sunfire:IsCastable() and EvaluateCycleSunfireST2(Target) then
--         return S.Sunfire:Cast()
--     end
--     -- moonfire,target_if=refreshable&astral_power.deficit>variable.passive_asp+energize_amount
--     if S.Moonfire:IsCastable() and EvaluateCycleMoonfireST2(Target) then
--         return S.Moonfire:Cast()
--     end
--     -- stellar_flare,target_if=refreshable&astral_power.deficit>variable.passive_asp+energize_amount
--     if S.StellarFlare:IsCastable() and EvaluateCycleStellarFlareST2(Target) then
--         return S.StellarFlare:Cast()
--     end
--     -- new_moon,if=astral_power.deficit>variable.passive_asp+energize_amount&(buff.ca_inc.up|charges_fractional>2.5&buff.primordial_arcanic_pulsar.value<=520&cooldown.ca_inc.remains>10|fight_remains<10)
--     if S.NewMoon:IsCastable() and (APDeficit > VarPassiveAsp + EnergizeAmountNewMoon and (CAIncBuffUp or S.NewMoon:ChargesFractional() > 2.5 and PAPValue <= 520 and CaInc:CooldownRemains() > 10 or aoeTTD() < 10)) then
--         return S.NewMoon:Cast()
--     end
--     -- half_moon,if=astral_power.deficit>variable.passive_asp+energize_amount&(buff.eclipse_lunar.remains>execute_time|buff.eclipse_solar.remains>execute_time)&(buff.ca_inc.up|charges_fractional>2.5&buff.primordial_arcanic_pulsar.value<=520&cooldown.ca_inc.remains>10|fight_remains<10)
--     if S.HalfMoon:IsCastable() and (APDeficit > VarPassiveAsp + EnergizeAmountHalfMoon and (Player:BuffRemains(S.EclipseLunar) > S.HalfMoon:ExecuteTime() or Player:BuffRemains(S.EclipseSolar) > S.HalfMoon:ExecuteTime()) and (CAIncBuffUp or S.HalfMoon:ChargesFractional() > 2.5 and PAPValue <= 520 and CaInc:CooldownRemains() > 10 or aoeTTD() < 10)) then
--         return S.HalfMoon:Cast()
--     end
--     -- full_moon,if=astral_power.deficit>variable.passive_asp+energize_amount&(buff.eclipse_lunar.remains>execute_time|buff.eclipse_solar.remains>execute_time)&(buff.ca_inc.up|charges_fractional>2.5&buff.primordial_arcanic_pulsar.value<=520&cooldown.ca_inc.remains>10|fight_remains<10)
--     if S.FullMoon:IsCastable() and (APDeficit > VarPassiveAsp + EnergizeAmountFullMoon and (Player:BuffRemains(S.EclipseLunar) > S.FullMoon:ExecuteTime() or Player:BuffRemains(S.EclipseSolar) > S.FullMoon:ExecuteTime()) and (CAIncBuffUp or S.HalfMoon:ChargesFractional() > 2.5 and PAPValue <= 520 and CaInc:CooldownRemains() > 10 or aoeTTD() < 10)) then
--         return S.FullMoon:Cast()
--     end
--     -- variable,name=starsurge_condition2,value=buff.starweavers_weft.up|astral_power.deficit<variable.passive_asp+action.wrath.energize_amount+(action.starfire.energize_amount+variable.passive_asp)*(buff.eclipse_solar.remains<(gcd.max*3))|talent.astral_communion&cooldown.astral_communion.remains<3|buff.ca_inc.up&cooldown.full_moon.ready&astral_power.deficit+variable.passive_asp<action.full_moon.energize_amount|fight_remains<5
--     local VarStarsurgeCondition2 = (Player:BuffUp(S.StarweaversWeft) or APDeficit < VarPassiveAsp + EnergizeAmountWrath + (EnergizeAmountStarfire + VarPassiveAsp) * (num(Player:BuffRemains(S.EclipseSolar) < Player:GCD() * 3)) or S.AstralCommunion:IsAvailable() and S.AstralCommunion:CooldownRemains() < 3 or CAIncBuffUp and S.FullMoon:CooldownUp() and APDeficit + VarPassiveAsp < EnergizeAmountFullMoon or aoeTTD() < 5)
--     -- cancel_buff,name=starlord,if=buff.starlord.remains<2&variable.starsurge_condition2
--     -- if Settings.Balance.ShowCancelStarlord and Player:BuffUp(S.StarlordBuff) and Player:BuffRemains(S.StarlordBuff) < 2 and VarStarsurgeCondition2 then
--     --   if HR.CastAnnotated(S.Starlord, false, "CANCEL") then return "cancel_buff starlord st 53"; end
--     -- end
--     -- starsurge,if=variable.starsurge_condition2
--     if S.Starsurge:IsReady() and (VarStarsurgeCondition2) then
--         return S.Starsurge:Cast()
--     end
--     -- wrath
--     if S.Wrath:IsCastable() and not Player:IsMoving() then
--         return S.Wrath:Cast()
--     end
--     -- run_action_list,name=fallthru
--     local ShouldReturn = Fallthru(); if ShouldReturn then return ShouldReturn; end
--     -- if HR.CastAnnotated(S.Pool, false, "MOVING") then return "Pool ST due to movement and no fallthru"; end
  end
  
  local function AoE()

if S.Wrath:TimeSinceLastCast()>C_Spell.GetSpellInfo("Wrath").castTime*.001-0.1 and (S.Wrath:Count()==2  or S.Wrath:Count() ==1 and not Player:IsCasting(S.Wrath)) then
    castwrath = true
else
    castwrath = false
end


if IsReady("Moonfire") and  Moonfiredebuff < 22*0.3 + Player:GCDRemains() then
  return S.Moonfire:Cast()
end

if IsReady("Sunfire") and  Sunfiredebuff< 18*0.3 + Player:GCDRemains()  then
    return S.Sunfire:Cast()
end


if IsReady("Stellar Flare") and StellarFlareDebuff < 24*0.3 + Player:GCDRemains()   then
    return S.StellarFlare:Cast()
end
if IsReady("Berserking") and RubimRH.CDsON() and AuraUtil.FindAuraByName("Incarnation: Chosen of Elune", "player") then
    return S.Berserking:Cast()
end
if IsReady("Incarnation: Chosen of Elune") and RubimRH.CDsON() then
    return S.Incarnation:Cast()
end
    -- -- variable,name=enter_solar,value=spell_targets.starfire<3
    -- local VarEnterSolar = GetMobsInCombat() < 3
    -- -- starfire,if=variable.enter_solar&(eclipse.any_next|buff.eclipse_solar.remains<action.starfire.cast_time)
    -- if S.Starfire:IsCastable() and not Player:IsMoving() and (VarEnterSolar and (EclipseAnyNext or Player:BuffRemains(S.EclipseSolar) < S.Starfire:CastTime())) then
    --     return S.Starfire:Cast()
    -- end
    -- -- wrath,if=!variable.enter_solar&(eclipse.any_next|buff.eclipse_lunar.remains<action.wrath.cast_time)
    -- if S.Wrath:IsCastable() and not Player:IsMoving() and (not VarEnterSolar and (EclipseAnyNext or Player:BuffRemains(S.EclipseLunar) < S.Wrath:CastTime())) then
    --     return S.Wrath:Cast()
    -- end


    if IsReady("Wrath") and not Player:IsMoving() and (S.Wrath:Count() == 2 or S.Wrath:Count() == 1 and not Player:IsCasting(S.Wrath) and castwrath ) and not AuraUtil.FindAuraByName("Eclipse (Lunar)", "player") then
        return S.Wrath:Cast()
    end

if IsReady("Starfall") then
    return S.Starfall:Cast()
end

if IsReady("Starfire") and starfirecastmoving then
    return S.Starfire:Cast()
end


if IsReady("Moonfire") and S.Moonfire:TimeSinceLastCast()>S.Sunfire:TimeSinceLastCast() then
  return S.Moonfire:Cast()
end
if IsReady("Sunfire") and S.Sunfire:TimeSinceLastCast()>S.Moonfire:TimeSinceLastCast() then
  return S.Sunfire:Cast()
end






--     local DungeonRoute = Player:IsInParty() and not Player:IsInRaid()
--     -- moonfire,target_if=refreshable&(target.time_to_die-remains)>6&astral_power.deficit>variable.passive_asp+energize_amount,if=fight_style.dungeonroute
--     if S.Moonfire:IsCastable() and (DungeonRoute) and EvaluateCycleMoonfireAoE(Target) then
--         return S.Moonfire:Cast()
--     end
--     -- variable,name=cd_condition_aoe,value=!druid.no_cds&(cooldown.ca_inc.remains<5&!buff.ca_inc.up&(target.time_to_die>10&buff.primordial_arcanic_pulsar.value<500|fight_remains<25+10*talent.incarnation_chosen_of_elune))
--     VarCDConditionAoE =  RubimRH.CDsON() and (CaInc:CooldownRemains() < 5 and not CAIncBuffUp and (targetTTD > 10 and PAPValue < 500 or aoeTTD() < 25 + 10 * num(S.Incarnation:IsAvailable())))
--     -- sunfire,target_if=refreshable&(target.time_to_die-remains)>6-(spell_targets%2)&astral_power.deficit>variable.passive_asp+energize_amount
--     if S.Sunfire:IsCastable() and EvaluateCycleSunfireAoE(Target) then
--         return S.Sunfire:Cast()
--     end
--     -- moonfire,target_if=refreshable&(target.time_to_die-remains)>6&astral_power.deficit>variable.passive_asp+energize_amount,if=!fight_style.dungeonroute
--     if S.Moonfire:IsCastable() and (not DungeonRoute) and EvaluateCycleMoonfireAoE(Target) then
--         return S.Moonfire:Cast()
--     end
--     -- stellar_flare,target_if=refreshable&(target.time_to_die-remains-spell_targets.starfire)>8+spell_targets.starfire,if=astral_power.deficit>variable.passive_asp+energize_amount&spell_targets.starfire<(11-talent.umbral_intensity.rank-talent.astral_smolder.rank)&variable.cd_condition_aoe
--     if S.StellarFlare:IsCastable() and EvaluateCycleStellarFlareAoE(Target) and (APDeficit > VarPassiveAsp + EnergizeAmountStellarFlare and GetMobsInCombat() < (11 - S.UmbralIntensity:TalentRank() - S.AstralSmolder:TalentRank()) and VarCDConditionAoE) then
--         return S.StellarFlare:Cast()
--     end
--     -- variable,name=starfall_condition1,value=variable.cd_condition_aoe&(talent.orbital_strike&astral_power.deficit<variable.passive_asp+8*spell_targets|buff.touch_the_cosmos.up)|astral_power.deficit<(variable.passive_asp+8+12*(buff.eclipse_lunar.remains<4|buff.eclipse_solar.remains<4))
--     local VarStarfallCondition1 = (VarCDConditionAoE and (S.OrbitalStrike:IsAvailable() and APDeficit < VarPassiveAsp + 8 * GetMobsInCombat() or Player:BuffUp(S.TouchtheCosmos)) or APDeficit < (VarPassiveAsp + 8 + 12 * num(Player:BuffRemains(S.EclipseLunar) < 4 or Player:BuffRemains(S.EclipseSolar) < 4)))
--     -- cancel_buff,name=starlord,if=buff.starlord.remains<2&variable.starfall_condition1
--     -- if Settings.Balance.ShowCancelStarlord and Player:BuffUp(S.StarlordBuff) and Player:BuffRemains(S.StarlordBuff) < 2 and VarStarfallCondition1 then
--     --   if HR.CastAnnotated(S.Starlord, false, "CANCEL") then return "cancel_buff starlord aoe 9.5"; end
--     -- end
--     -- starfall,if=variable.starfall_condition1
--     if S.Starfall:IsReady() and (VarStarfallCondition1) then
--         return S.Starfall:Cast()
--     end
--     -- starfire,if=buff.dreamstate.up&variable.cd_condition_aoe&buff.eclipse_lunar.up
--     if S.Starfire:IsReady() and not Player:IsMoving() and (Player:BuffUp(S.DreamstateBuff) and VarCDConditionAoE and Player:BuffUp(S.EclipseLunar)) then
--         return S.Starfire:Cast()
--     end
--     if RubimRH.CDsON() then
--       -- celestial_alignment,if=variable.cd_condition_aoe
--       if S.CelestialAlignment:IsCastable() and (VarCDConditionAoE) then
--         return S.CelestialAlignment:Cast()
--     end
--       -- incarnation,if=variable.cd_condition_aoe
--       if S.Incarnation:IsCastable() and (VarCDConditionAoE) then
--         return S.Incarnation:Cast()
--     end
--     end
--     -- warrior_of_elune
--     if S.WarriorofElune:IsCastable() then
--         return S.WarriorofElune:Cast()
--     end
--     -- variable,name=enter_solar,value=spell_targets.starfire<3
--     local VarEnterSolar = GetMobsInCombat() < 3
--     -- starfire,if=variable.enter_solar&(eclipse.any_next|buff.eclipse_solar.remains<action.starfire.cast_time)
--     if S.Starfire:IsCastable() and not Player:IsMoving() and (VarEnterSolar and (EclipseAnyNext or Player:BuffRemains(S.EclipseSolar) < S.Starfire:CastTime())) then
--         return S.Starfire:Cast()
--     end
--     -- wrath,if=!variable.enter_solar&(eclipse.any_next|buff.eclipse_lunar.remains<action.wrath.cast_time)
--     if S.Wrath:IsCastable() and not Player:IsMoving() and (not VarEnterSolar and (EclipseAnyNext or Player:BuffRemains(S.EclipseLunar) < S.Wrath:CastTime())) then
--         return S.Wrath:Cast()
--     end
--     -- wild_mushroom,if=astral_power.deficit>variable.passive_asp+20&(!talent.waning_twilight|dot.fungal_growth.remains<2&target.time_to_die>7&!prev_gcd.1.wild_mushroom)
--     if S.WildMushroom:IsCastable() and (APDeficit > VarPassiveAsp + 20 and (not S.WaningTwilight:IsAvailable() or Target:DebuffRemains(S.FungalGrowthDebuff) < 2 and targetTTD > 7 and not Player:PrevGCDP(1, S.WildMushroom))) then
--         return S.WildMushroom:Cast()
--     end
--     -- fury_of_elune,if=target.time_to_die>2&(buff.ca_inc.remains>3|cooldown.ca_inc.remains>30&buff.primordial_arcanic_pulsar.value<=280|buff.primordial_arcanic_pulsar.value>=560&astral_power>50)|fight_remains<10
--     if S.FuryofElune:IsCastable() and (targetTTD > 2 and (CAIncBuffRemains > 3 or CaInc:CooldownRemains() > 30 and PAPValue <= 280 or PAPValue >= 560 and Player:AstralPowerP() > 50) or aoeTTD() < 10) then
--         return S.FuryofElune:Cast()
--     end
--     -- variable,name=starfall_condition2,value=target.time_to_die>4&(buff.starweavers_warp.up|talent.starlord&buff.starlord.stack<3)
--     local VarStarfallCondition2 = (targetTTD > 4 and (Player:BuffUp(S.StarweaversWarp) or S.Starlord:IsAvailable() and Player:BuffStack(S.StarlordBuff) < 3))
--     -- -- cancel_buff,name=starlord,if=buff.starlord.remains<2&variable.starfall_condition2
--     -- if Settings.Balance.ShowCancelStarlord and Player:BuffUp(S.StarlordBuff) and Player:BuffRemains(S.StarlordBuff) < 2 and VarStarfallCondition2 then
--     --   if HR.CastAnnotated(S.Starlord, false, "CANCEL") then return "cancel_buff starlord aoe 23"; end
--     -- end
--     -- starfall,if=variable.starfall_condition2
--     if S.Starfall:IsReady() and (VarStarfallCondition2) then
--         return S.Starfall:Cast()
--     end
--     -- full_moon,if=astral_power.deficit>variable.passive_asp+energize_amount&(buff.eclipse_lunar.remains>execute_time|buff.eclipse_solar.remains>execute_time)&(buff.ca_inc.up|charges_fractional>2.5&buff.primordial_arcanic_pulsar.value<=520&cooldown.ca_inc.remains>10|fight_remains<10)
--     if S.FullMoon:IsCastable() and (APDeficit > VarPassiveAsp + EnergizeAmountFullMoon and (Player:BuffRemains(S.EclipseLunar) > S.FullMoon:ExecuteTime() or Player:BuffRemains(S.EclipseSolar) > S.FullMoon:ExecuteTime()) and (CAIncBuffUp or S.HalfMoon:ChargesFractional() > 2.5 and PAPValue <= 520 and CaInc:CooldownRemains() > 10 or aoeTTD() < 10)) then
--         return S.FullMoon:Cast()
--     end
--     -- starsurge,if=buff.starweavers_weft.up&spell_targets.starfire<3
--     if S.Starsurge:IsReady() and (Player:BuffUp(S.StarweaversWeft) and GetMobsInCombat() < 3) then
--         return S.Starsurge:Cast()
--     end
--     -- stellar_flare,target_if=refreshable&(target.time_to_die-remains-spell_targets.starfire)>8+spell_targets.starfire,if=astral_power.deficit>variable.passive_asp+energize_amount&spell_targets.starfire<(11-talent.umbral_intensity.rank-talent.astral_smolder.rank)
--     if S.StellarFlare:IsCastable() and EvaluateCycleStellarFlareAoE(Target) and (APDeficit > VarPassiveAsp + EnergizeAmountStellarFlare and GetMobsInCombat() < (11 - S.UmbralIntensity:TalentRank() - S.AstralSmolder:TalentRank())) then
--         return S.StellarFlare:Cast()
--     end
--     -- astral_communion,if=astral_power.deficit>variable.passive_asp+energize_amount
--     if S.AstralCommunion:IsCastable() and (APDeficit > VarPassiveAsp + EnergizeAmountAstralCommunion) then
--       return S.AstralCommunion:Cast()
--     end
--     -- convoke_the_spirits,if=astral_power<50&spell_targets.starfall<3+talent.elunes_guidance&(buff.eclipse_lunar.remains>4|buff.eclipse_solar.remains>4)
--     if S.ConvoketheSpirits:IsCastable() and  RubimRH.CDsON() and (Player:AstralPowerP() < 50 and GetMobsInCombat() < 3 + num(S.ElunesGuidance:IsAvailable()) and (Player:BuffRemains(S.EclipseLunar) > 4 or Player:BuffRemains(S.EclipseSolar) > 4)) then
--         return S.ConvoketheSpirits:Cast()
--     end
--     -- new_moon,if=astral_power.deficit>variable.passive_asp+energize_amount
--     if S.NewMoon:IsCastable() and (APDeficit > VarPassiveAsp + EnergizeAmountNewMoon) then
--         return S.NewMoon:Cast()
--     end
--     -- half_moon,if=astral_power.deficit>variable.passive_asp+energize_amount&(buff.eclipse_lunar.remains>execute_time|buff.eclipse_solar.remains>execute_time)
--     if S.HalfMoon:IsCastable() and (APDeficit > VarPassiveAsp + EnergizeAmountHalfMoon and (Player:BuffRemains(S.EclipseLunar) > S.FullMoon:ExecuteTime() or Player:BuffRemains(S.EclipseSolar) > S.FullMoon:ExecuteTime())) then
--       return S.HalfMoon:Cast()
--     end
--     -- force_of_nature,if=astral_power.deficit>variable.passive_asp+energize_amount
--     if S.ForceofNature:IsCastable() and (APDeficit > VarPassiveAsp + EnergizeAmountForceofNature) then
--         return S.ForceofNature:Cast()
--     end
--     -- starsurge,if=buff.starweavers_weft.up&spell_targets.starfire<17
--     if S.Starsurge:IsReady() and (Player:BuffUp(S.StarweaversWeft) and GetMobsInCombat() < 17) then
--         return S.Starsurge:Cast()
--     end
--     -- starfire,if=spell_targets>(3-(buff.dreamstate.up|buff.balance_t31_4pc_buff_lunar.stack>buff.balance_t31_4pc_buff_solar.stack))&buff.eclipse_lunar.up|eclipse.in_lunar
--     local T314pcLunarStack = 0
--     local T314pcSolarStack = 0
--     if Player:BuffUp(S.EclipseLunar) then
--       local EclipseLunarBuffInfo = Player:BuffInfo(S.EclipseLunar, nil, true)
--       local EclipseLunarValue = EclipseLunarBuffInfo.points[1]
--       local T314pcLunarStack = (EclipseLunarValue - 15) / 2
--     end
--     if Player:BuffUp(S.EclipseSolar) then
--       local EclipseSolarBuffInfo = Player:BuffInfo(S.EclipseSolar, nil, true)
--       local EclipseSolarValue = EclipseSolarBuffInfo.points[1]
--       local T314pcSolarStack = (EclipseSolarValue - 15) / 2
--     end
--     if S.Starfire:IsCastable() and not Player:IsMoving() and (GetMobsInCombat() > (3 - (num(Player:BuffUp(S.DreamstateBuff) or T314pcLunarStack > T314pcSolarStack))) and Player:BuffUp(S.EclipseLunar) or EclipseInLunar) then
--         return S.Starfire:Cast()
--     end
--     -- wrath
--     if S.Wrath:IsCastable() and not Player:IsMoving() then
--    return S.Wrath:Cast()
--     end
--     -- run_action_list,name=fallthru
--     local ShouldReturn = Fallthru(); if ShouldReturn then return ShouldReturn; end
--     -- if HR.CastAnnotated(S.Pool, false, "MOVING") then return "Pool AoE due to movement and no fallthru"; end
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

  --- ======= MAIN =======
  local function APL()

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


starfirecastmoving = (AuraUtil.FindAuraByName("Owlkin Frenzy","player") or not Player:IsMoving())
-- print(C_Spell.GetSpellInfo("Wrath").castTime)

    HPpercentloss = MyHealthTracker.GetPredictedHealthLoss() * 3
    
    validmobsinrange10y = combatmobs40() * .7
    validmobsinrange30y = combatmobs40() * .7
            
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

    -- Set required variables
    if Player:CanAttack(Target) and not VarInit then
      InitVars()
    end
  
    if Player:CanAttack(Target) or Player:AffectingCombat() then

  
      -- Determine amount of AP fed into Primordial Arcanic Pulsar
      PAPValue = 0
      if S.PrimordialArcanicPulsar:IsAvailable() then
        local spellTable = Player:BuffInfo(S.PAPBuff, false, true)
        if spellTable ~= nil then
          PAPValue = spellTable.points[1]
        end
      end
  
      -- Check CA/Incarnation Buff Status
      CAIncBuffUp = Player:BuffUp(S.CABuff) or Player:BuffUp(S.IncarnationBuff)
      CAIncBuffRemains = 0
      if CAIncBuffUp then
        CAIncBuffRemains = S.IncarnationTalent:IsAvailable() and Player:BuffRemains(S.IncarnationBuff) or Player:BuffRemains(S.CABuff)
      end
    end







if S.WildSurges:IsAvailable() then
    WSAPbonus = 2
else
    WSAPbonus = 0
end
if Player:BuffUp(S.WarriorofEluneBuff) then
    WoEBuff = 1.4
else
    WoEBuff = 1
  end
if S.SouloftheForest:IsAvailable() and Player:BuffUp(S.EclipseSolar) then
    local SotFBonusStarfire = (1 + 0.2 * GetMobsInCombat())
    if SotFBonusStarfire > 1.6 then 
        SotFBonusStarfire = 1.6 
        end
    SotFBonusWrath = 1.4
    
else
    SotFBonusWrath = 1
    SotFBonusStarfire = 1
  end

  EnergizeAmountStarfire= (10 + WSAPbonus)*SotFBonusStarfire*WoEBuff
  EnergizeAmountWrath = (8 + WSAPbonus)*SotFBonusWrath


    EnergizeAmountStellarFlare = 12
    EnergizeAmountAstralCommunion = 60
    EnergizeAmountForceofNature = 20
    EnergizeAmountSunfire = 8
    EnergizeAmountMoonfire = 6
    EnergizeAmountNewMoon = 12
    EnergizeAmountHalfMoon = 24
    EnergizeAmountFullMoon = 50


        if Player:IsCasting(S.Wrath) ~= false then 
            APDeficit = Player:AstralPowerDeficit() - EnergizeAmountWrath
        elseif Player:IsCasting(S.Starfire)  ~= false then
            APDeficit = Player:AstralPowerDeficit() - EnergizeAmountStarfire
        elseif Player:IsCasting(S.StellarFlare)  ~= false then
            APDeficit = Player:AstralPowerDeficit() - EnergizeAmountStellarFlare
        elseif Player:IsCasting(S.NewMoon)  ~= false then
            APDeficit = Player:AstralPowerDeficit() - EnergizeAmountNewMoon
        elseif Player:IsCasting(S.HalfMoon)  ~= false then
            APDeficit = Player:AstralPowerDeficit() - EnergizeAmountHalfMoon
        elseif Player:IsCasting(S.FullMoon)  ~= false then
            APDeficit = Player:AstralPowerDeficit() - EnergizeAmountFullMoon
        else
        APDeficit = Player:AstralPowerDeficit()

        end




    if Player:IsCasting() or Player:IsChanneling() then
        return 0, "Interface\\Addons\\Rubim-RH\\Media\\channel.tga"
    elseif Player:IsDeadOrGhost() or AuraUtil.FindAuraByName("Drink", "player") or AuraUtil.FindAuraByName("Food", "player") or AuraUtil.FindAuraByName("Food & Drink", "player") or  AuraUtil.FindAuraByName("Travel Form", "player") then
        return 0, "Interface\\Addons\\Rubim-RH\\Media\\griph.tga"
    end 
    

    if true then
    
        



        if AuraUtil.FindAuraByName('Orbit Breaker','player') then
            _, _, OrbitBreakerStacks = AuraUtil.FindAuraByName('Orbit Breaker','player')
            else
                OrbitBreakerStacks = 0
            end
    
        elite = UnitClassification("target") == "worldboss" or UnitClassification("target") == "rareelite" or UnitClassification("target") == "elite" or UnitClassification("target") == "rare" or target_is_dummy() or Target:IsAPlayer()
        
        boss = UnitClassification("target") == "elite" and UnitLevel('target') == -1
        

        -- bs_inc = Player:BuffP(S.Berserk) or Player:BuffP(S.Incarnation)
        

        
        isEnraged = AuraUtil.FindAuraByName("Enrage", "target") or UnitChannelInfo("target") == "Ragestorm" or AuraUtil.FindAuraByName("Frenzy", "target")

    
        name, realm = UnitName('target')
    

        motw = select(1,AuraUtil.FindAuraByName("Mark of the Wild", "player"))
    
        if AuraUtil.FindAuraByName("Mark of the Wild","player") then
            motwremains = select(6,AuraUtil.FindAuraByName("Mark of the Wild","player")) - GetTime()
        else
            motwremains = 0
        end
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
  

  if S.Barkskin:IsCastable() and (inRange30>=1 and Player:HealthPercentage()<45) then
    return S.Barkskin:Cast()
    end
    if S.Renewal:IsCastable() and (inRange30>=1 and Player:HealthPercentage()<35) then
        return S.Renewal:Cast()
        end


  

            -- print(IsReady("Intercession",nil,nil,1,1) , UnitIsDeadOrGhost("focus") , (rezcharges>=1 or level ==0) , los == false , UnitExists('focus') , C_Spell.IsSpellInRange("Flash of Light", "focus"))
            if IsReady("Rebirth",nil,nil,1,1) and UnitIsDeadOrGhost("focus") and (rezcharges>=1 or level ==0) then
                if IsReady("Rebirth") then
                  return S.Rebirth:Cast()
               
                end
              end
              


-- print(OrbitBreakerStacks)
    if IsReady("Moonkin Form") and (not AuraUtil.FindAuraByName("Cat Form","player") and not AuraUtil.FindAuraByName("Travel Form","player") or Player:CanAttack(Target) and not Target:IsDeadOrGhost() and targetRange30) and not AuraUtil.FindAuraByName("Moonkin Form","player") and Player:IsMoving() then
        return S.MoonkinForm:Cast()
      end
  

    if IsReady("Mark of the Wild") and motwremains <300 and not Player:AffectingCombat()  and Player:IsMoving() then
        return S.MarkoftheWild:Cast()
      end


      if (castTime > 0.1 or channelTime > 0.1) and select(8, UnitCastingInfo("target")) == false and RubimRH.InterruptsON() and not isEnraged then


        -- kick on GCD
        if IsReady("Solar Beam") and kickprio() and targetRange30 and Player:GCDRemains()<0.5 then
        return S.SolarBeam:Cast()
        end

      end
	--Shiv
	if IsReady("Soothe") and targetRange30 and isEnraged and Player:AffectingCombat() and targetTTD > 8 then
		return S.Soothe:Cast()
	end


      if RubimRH.CDsON() and targetRange20
              
      and not Target:IsDeadOrGhost() and Player:CanAttack(Target) and Player:AffectingCombat() and (targetTTD>5 or target_is_dummy()) then
      local ShouldReturn = UseItems();
      if ShouldReturn then return ShouldReturn; end
      end


      
      if not C_Spell.IsCurrentSpell(6603) and Player:CanAttack(Target)
      and Target:AffectingCombat() and Player:AffectingCombat() and targetRange20 then
      return S.autoattack:Cast()
      end

    -- if Player:CanAttack(Target) and not Target:IsDeadOrGhost() and targetRange40 then
    --   -- Eclipse Check
      EclipseCheck()
    --   -- Precombat
      if not Player:AffectingCombat() and Player:CanAttack(Target) and not Target:IsDeadOrGhost() and targetRange40 then
        local ShouldReturn = Precombat(); if ShouldReturn then return ShouldReturn; end
      end
    --   -- variable,name=is_aoe,value=spell_targets.starfall>(1+(!talent.aetherial_kindling&!talent.starweaver))&talent.starfall
    --   VarIsAoe = (GetMobsInCombat() > (1 + num(not S.AetherialKindling:IsAvailable() and not S.Starweaver:IsAvailable())) and S.Starfall:IsAvailable())
    --   -- variable,name=is_cleave,value=spell_targets.starfire>1
    --   VarIsCleave = (GetMobsInCombat() > 1)
    --   -- variable,name=passive_asp,value=6%spell_haste+talent.natures_balance+talent.orbit_breaker*dot.moonfire.ticking*(buff.orbit_breaker.stack>(27-2*buff.solstice.up))*40
    --   VarPassiveAsp = 6 / Player:SpellHaste() + num(S.NaturesBalance:IsAvailable()) + num(S.OrbitBreaker:IsAvailable()) * num(Target:DebuffUp(S.MoonfireDebuff)) * num(OrbitBreakerStacks > (27 - 2 * num(Player:BuffUp(S.SolsticeBuff)))) * 40
    --   -- berserking,if=buff.ca_inc.remains>=20|variable.no_cd_talent|fight_remains<15
  
-- print(not RubimRH.AoEON())


      if Player:CanAttack(Target) and not Target:IsDeadOrGhost() and targetRange40 then

      if  RubimRH.AoEON() and (GetMobsInCombat()>=2 or inRange40>=2) then
        local ShouldReturn = AoE(); 
        if ShouldReturn then 
            return ShouldReturn; 
        end
    end
    
      if (not RubimRH.AoEON() or GetMobsInCombat()<2) then
        local ShouldReturn = St(); 
        if ShouldReturn then 
            return ShouldReturn; 
        end
      
        end

        -- if HR.CastAnnotated(S.Pool, false, "WAIT/ST") then return "Wait for ST"; end
      
    end

    return 0, "Interface\\Addons\\Rubim-RH\\Media\\griph.tga"
end 



RubimRH.Rotation.SetAPL(102, APL);

local function PASSIVE()
   -- print(GetEnemiesCount());
    return RubimRH.Shared()
end

RubimRH.Rotation.SetPASSIVE(102, PASSIVE);