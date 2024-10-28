--- ============================ HEADER ============================
--- ======= LOCALIZE =======
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
local mathmin = math.min
local mathmax = math.max
local BoolToInt = HL.Utils.BoolToInt

RubimRH.Spell[259] = {
--   CloakofShadows          = Spell(31224),
  CrimsonVial             = Spell(185311),
--   Evasion                 = Spell(5277),
--   Feint                   = Spell(1966),
  Blind                   = Spell(2094),
  CheapShot               = Spell(1833),
  ColdBlood               = Spell(382245),
--   FlayedwingToxin         = Spell(345545),
--   FullMomentum            = Spell(459228),
  Kick                    = Spell(1766),
  KidneyShot              = Spell(408),
--   PickPocket              = Spell(921),
--   Sap                     = Spell(6770),
  Shiv                    = Spell(5938),
  SliceandDice            = Spell(315496),
--   Shadowstep              = Spell(36554),
--   Sprint                  = Spell(2983),
--   TricksoftheTrade        = Spell(57934),
--   AcrobaticStrikes        = Spell(455143),
--   Alacrity                = Spell(193539),
  ClearTheWitnessesBuff   = Spell(457178),
--   CoupDeGrace             = Spell(441776),
  DarkestNight            = Spell(457058),
  DarkestNightBuff        = Spell(457280),
--   DeeperStratagem         = Spell(193531),
  DeathStalkersMark       = Spell(457052),
  DeathStalkersMarkDebuff = Spell(457129),
--   DoubleJeopardy          = Spell(454430),
--   EscalatingBlade         = Spell(441786),
--   EdgeCase                = Spell(453457),
  FateboundCoin           = Spell(453012),
  FateboundCoinHeads      = Spell(456479),
  FateboundCoinTails      = Spell(452538),
  FateboundLuckyCoin      = Spell(461818),
--   FatefulEnding           = Spell(454428),
--   FazedDebuff             = Spell(441224),
--   FindWeakness            = Spell(91023),
--   FindWeaknessDebuff      = Spell(316220),
--   FlawlessForm            = Spell(441321),
--   FlawlessFormBuff        = Spell(441326),
--   FollowTheBlood          = Spell(457068),
  HandOfFate              = Spell(452536),
--   ImprovedAmbush          = Spell(381620),
  FateboundInevitability  = Spell(454434),
--   Inevitability           = Spell(382512),
--   LingeringDarkness       = Spell(457056),
--   LingeringDarknessBuff   = Spell(457273),
--   MarkedforDeath          = Spell(137619),
  MomentumOfDespair       = Spell(457067),
  Nightstalker            = Spell(14062),
--   ResoundingClarity       = Spell(381622),
--   Reverberation           = Spell(394332),
--   SealFate                = Spell(14190),
--   Sepsis                  = Spell(385408),
  SepsisBuff              = Spell(375939),
--   ShadowDance             = Spell(185313), -- Base Spell
--   ShadowDanceTalent       = Spell(394930),
--   ShadowDanceBuff         = Spell(185422),
  Subterfuge              = Spell(108208),
  SubterfugeBuff          = Spell(115192),
  ThistleTea              = Spell(381623),
--   TricksterDistract       = Spell(441587),
--   UnseenBlade             = Spell(441146),
--   UnseenBladeBuff         = Spell(459485),
--   Vigor                   = Spell(14983),
  Stealth                 = Spell(1784),
  Stealth2                = Spell(115191),
  Vanish                  = Spell(1856),
  VanishBuff              = Spell(11327),
  VanishBuff2             = Spell(115193),
--   WithoutATrace           = Spell(382513),
  Ambush                  = Spell(8676),
--   AmbushOverride          = Spell(430023),
--   AmplifyingPoison        = Spell(381664),
  AmplifyingPoisonDebuff  = Spell(383414),
  AmplifyingPoisonDebuffDeathmark = Spell(394328),
--   CripplingPoisonDebuff   = Spell(3409),
--   DeadlyPoison            = Spell(2823),
  DeadlyPoisonDebuff      = Spell(2818),
  DeadlyPoisonDebuffDeathmark = Spell(394324),
  Envenom                 = Spell(32645),
  FanofKnives             = Spell(51723),
  Garrote                 = Spell(703),
  GarroteDeathmark        = Spell(360830),
  Mutilate                = Spell(1329),
  PoisonedKnife           = Spell(185565),
  Rupture                 = Spell(1943),
  RuptureDeathmark        = Spell(360826),
--   WoundPoison             = Spell(8679),
--   WoundPoisonDebuff       = Spell(8680),
  ArterialPrecision       = Spell(400783),
--   AtrophicPoisonDebuff    = Spell(392388),
  BlindsideBuff           = Spell(121153),
  CausticSpatter          = Spell(421975),
  CausticSpatterDebuff    = Spell(421976),
  CrimsonTempest          = Spell(121411),
--   CutToTheChase           = Spell(51667),
--   DashingScoundrel        = Spell(381797),
  Deathmark               = Spell(360194),
--   Doomblade               = Spell(381673),
--   DragonTemperedBlades    = Spell(381801),
--   Elusiveness             = Spell(79008),
  ImprovedGarrote         = Spell(381632),
  ImprovedGarroteBuff     = Spell(392401),
  ImprovedGarroteAura     = Spell(392403),
  IndiscriminateCarnage   = Spell(381802),
  IndiscriminateCarnageAura = Spell(385754),
  IndiscriminateCarnageBuff = Spell(385747),
  InternalBleeding        = Spell(154953),
  Kingsbane               = Spell(385627),
  LightweightShiv         = Spell(394983),
  MasterAssassin          = Spell(255989),
  MasterAssassinBuff      = Spell(256735),
  PreyontheWeak           = Spell(131511),
  PreyontheWeakDebuff     = Spell(255909),
  SanguineBlades          = Spell(200806),
  ScentOfBlood            = Spell(381799),
  ScentOfBloodBuff        = Spell(394080),
  SerratedBoneSpike       = Spell(385424),
  SerratedBoneSpikeDebuff = Spell(394036),
  ShivDebuff              = Spell(319504),
  ShroudedSuffocation     = Spell(385478),
  ThrownPrecision         = Spell(381629),
  VenomRush               = Spell(152152),
  ViciousVenoms           = Spell(381634),
  FinalityRuptureBuff      = Spell(385951),
  HeartseekingHealthInjector = Spell(452831),
  autoattack              = Spell(59752), -- will to survive (human racial)
};
local S = RubimRH.Spell[259];

if not Item.Rogue then
    Item.Rogue = {}
end

Item.Rogue.Assassination = {
    HPIcon = Item(169451),
};

local I = Item.Rogue.Assassination;

local function ComputeNighstalkerPMultiplier()
    if S.Nightstalker:IsAvailable() and Player:StealthUp(true, false, true) then
      return 1 + (0.05 * S.Nightstalker:TalentRank())
    end
    return 1
end

local function ComputeImprovedGarrotePMultiplier()
    if S.ImprovedGarrote:IsAvailable() and (Player:BuffUp(S.ImprovedGarroteAura, nil, true)
      or Player:BuffUp(S.ImprovedGarroteBuff, nil, true) or Player:BuffUp(S.SepsisBuff, nil, true)) then
      return 1.5
    end
    return 1
end

S.Garrote:RegisterPMultiplier(ComputeNighstalkerPMultiplier, ComputeImprovedGarrotePMultiplier)
S.Rupture:RegisterPMultiplier(ComputeNighstalkerPMultiplier, { S.FinalityRuptureBuff, 1.3 })

S.Garrote:RegisterAuraTracking()

local function num(val)
    if val then
        return 1
    else
        return 0
    end
end

local function ScentSaturatedVar()
    if not S.ScentOfBlood:IsAvailable() then
      return true
    end
    return Player:BuffStack(S.ScentOfBloodBuff) >= mathmin(20, S.ScentOfBlood:TalentRank() * 2 * MeleeEnemies10yCount)
end

-- Master Assassin Remains Check
local function MasterAssassinAuraUp()
  return Player:BuffRemains(S.MasterAssassinBuff) == 9999
end

local function MasterAssassinRemains()
  -- Currently stealthed (i.e. Aura)
  if MasterAssassinAuraUp() then
    return Player:GCDRemains() + 3
  end
  -- Broke stealth recently (i.e. Buff)
  return Player:BuffRemains(S.MasterAssassinBuff)
end

-- local function IsDebuffRefreshable(TargetUnit, Spell, PandemicThreshold)
--     local PandemicThreshold = PandemicThreshold or Spell:PandemicThreshold()
--     --if Tier284pcEquipped and TargetUnit:DebuffUp(S.Vendetta) then
--     --  PandemicThreshold = PandemicThreshold * 0.5
--     --end
--     return TargetUnit:DebuffRefreshable(Spell, PandemicThreshold)
-- end

local function DebuffRefreshableAOE(debuff,pandemic)
	local RipRefreshable10 = 0
	local MissingRip10 = 0

    for id = 1, 40 do
		local unitID = "nameplate" .. id
		local _,_,_,_,_,expirationTime = AuraUtil.FindAuraByName(debuff,unitID,"PLAYER|HARMFUL")
		
		if AuraUtil.FindAuraByName(debuff,unitID,"PLAYER|HARMFUL") then
			timerRip = expirationTime - GetTime()
		else
			timerRip = nil
		end

		if timerRip and pandemic then 
			if UnitCanAttack("player", unitID) and IsItemInRange(32321, unitID) and timerRip <= pandemic then
				RipRefreshable10 = RipRefreshable10 + 1
			end
		end
		
		if UnitCanAttack("player", unitID) and IsItemInRange(32321, unitID) and UnitName(unitID) ~= "Orb of Ascendance" and not AuraUtil.FindAuraByName(debuff,unitID,"PLAYER|HARMFUL") then
			MissingRip10 = MissingRip10 + 1
		end
	end

	return RipRefreshable10 + MissingRip10
end

local function PoisonedBleeds()
    garrote_count = 0 
    rupture_count = 0 
    ib_count = 0

    for id = 1, 40 do
        local unitID = "nameplate" .. id

		if AuraUtil.FindAuraByName("Garrote",unitID,"PLAYER|HARMFUL") then
			garrote_count = garrote_count + 1 + 1 * num(AuraUtil.FindAuraByName("Deathmark",unitID,"PLAYER|HARMFUL"))
		end
		if AuraUtil.FindAuraByName("Rupture",unitID,"PLAYER|HARMFUL") then
			rupture_count = rupture_count + 1 + 1 * num(AuraUtil.FindAuraByName("Deathmark",unitID,"PLAYER|HARMFUL"))
		end
		if AuraUtil.FindAuraByName("Internal Bleeding",unitID,"PLAYER|HARMFUL") then
			ib_count = ib_count + 1
		end
	end

	return garrote_count + rupture_count + ib_count
end

local function ImprovedGarroteRemains()
    -- Currently stealthed (i.e. Aura)
    if Player:BuffUp(S.ImprovedGarroteAura) then
      return Player:GCDRemains() + 3
    end
    -- Broke stealth recently (i.e. Buff)
    return Player:BuffRemains(S.ImprovedGarroteBuff)
end

local function aoe_dot()
    --crimson_tempest,target_if=min:remains,if=spell_targets>=2&variable.dot_finisher_condition&refreshable&target.time_to_die-remains>6
    if IsReady("Crimson Tempest") and DebuffRefreshableAOE("Crimson Tempest",3) >= 2 and dot_finisher_condition then
        return S.CrimsonTempest:Cast()
    end

    --garrote,cycle_targets=1,if=combo_points.deficit>=1&(pmultiplier<=1)&refreshable&!variable.regen_saturated&target.time_to_die-remains>12
    if IsReady("Garrote") and TargetinRange(5) and (Player:ComboPointsDeficit() >= 1 and Target:PMultiplier(S.Garrote) <= 1 and Target:DebuffRefreshable(S.Garrote, S.Garrote:PandemicThreshold()) and not regen_saturated) then
        return S.Garrote:Cast()
    end

    --rupture,cycle_targets=1,if=variable.dot_finisher_condition&refreshable&(!dot.kingsbane.ticking|buff.cold_blood.up)&(!variable.regen_saturated&(talent.scent_of_blood.rank=2|talent.scent_of_blood.rank<=1&(buff.indiscriminate_carnage.up|target.time_to_die-remains>15)))&target.time_to_die-remains>(7+(talent.dashing_scoundrel*5)+(variable.regen_saturated*6))&!buff.darkest_night.up
    if IsReady("Rupture") and TargetinRange(5) and (dot_finisher_condition and Target:DebuffRefreshable(S.Rupture, S.Rupture:PandemicThreshold()) and (not Target:DebuffUp(S.Kingsbane) or Player:BuffUp(S.ColdBlood)) and (not regen_saturated and (S.ScentOfBlood:TalentRank() == 2 or S.ScentOfBlood:TalentRank() <= 1 and Player:BuffUp(S.IndiscriminateCarnageBuff))) and not Player:BuffUp(S.DarkestNightBuff)) then 
        return S.Rupture:Cast()
    end

    --rupture,cycle_targets=1,if=variable.dot_finisher_condition&refreshable&(!dot.kingsbane.ticking|buff.cold_blood.up)&variable.regen_saturated&!variable.scent_saturation&target.time_to_die-remains>19&!buff.darkest_night.up
    if IsReady("Rupture") and TargetinRange(5) and (dot_finisher_condition and Target:DebuffRefreshable(S.Rupture, S.Rupture:PandemicThreshold()) and (not Target:DebuffUp(S.Kingsbane) or Player:BuffUp(S.ColdBlood)) and regen_saturated and not ScentSaturatedVar() and not Player:BuffUp(S.DarkestNightBuff)) then 
        return S.Rupture:Cast()
    end

    --garrote,if=refreshable&combo_points.deficit>=1&(pmultiplier<=1|remains<=tick_time&spell_targets.fan_of_knives>=3)&(remains<=tick_time*2&spell_targets.fan_of_knives>=3)&(target.time_to_die-remains)>4&master_assassin_remains=0
    if IsReady("Garrote") and TargetinRange(5) and (Target:DebuffRefreshable(S.Garrote, S.Garrote:PandemicThreshold()) and Player:ComboPointsDeficit() >= 1 and (Target:PMultiplier(S.Garrote) <= 1 or Target:DebuffRemains(S.Garrote) <= BleedTickTime and MeleeEnemies10yCount >= 3) and (Target:DebuffRemains(S.Garrote) <= BleedTickTime * 2 and MeleeEnemies10yCount >= 3) and MasterAssassinRemains() <= 0) then
        return S.Garrote:Cast()
    end

    return nil
end

local function vanish()
    --pool_resource,for_next=1,extra_amount=45
    if Player:Energy() < 45 then
        return 0, "Interface\\Addons\\Rubim-RH\\Media\\mount2.tga"
    end
    --vanish,if=!buff.fatebound_lucky_coin.up&effective_combo_points>=variable.effective_spend_cp&(buff.fatebound_coin_tails.stack>=5|buff.fatebound_coin_heads.stack>=5)
    if IsReady("Vanish") and Player:BuffDown(S.FateboundLuckyCoin) and Player:ComboPoints() >= EffectiveCPSpend and (Player:BuffStack(S.FateboundCoinTails) >= 5 or Player:BuffStack(S.FateboundCoinHeads) >= 5) then
        return S.Vanish:Cast()
    end
    --vanish,if=!talent.master_assassin&!talent.indiscriminate_carnage&talent.improved_garrote&cooldown.garrote.up&(dot.garrote.pmultiplier<=1|dot.garrote.refreshable)&(debuff.deathmark.up|cooldown.deathmark.remains<4)&combo_points.deficit>=(spell_targets.fan_of_knives>?4)
    if IsReady("Vanish") and not S.MasterAssassin:IsAvailable() and not S.IndiscriminateCarnage:IsAvailable() and S.ImprovedGarrote:IsAvailable() and S.Garrote:CooldownUp() and (Target:PMultiplier(S.Garrote) <= 1 or Target:DebuffRefreshable(S.Garrote, S.Garrote:PandemicThreshold())) and (Target:DebuffUp(S.Deathmark) or S.Deathmark:CooldownRemains() < 4) and Player:ComboPointsDeficit() >= mathmin(MeleeEnemies10yCount, 4) then
        return S.Vanish:Cast()
    end
    --pool_resource,for_next=1,extra_amount=45
    if Player:Energy() < 45 then
        return 0, "Interface\\Addons\\Rubim-RH\\Media\\mount2.tga"
    end
    --vanish,if=talent.indiscriminate_carnage&talent.improved_garrote&cooldown.garrote.up&(dot.garrote.pmultiplier<=1|dot.garrote.refreshable)&spell_targets.fan_of_knives>2&(target.time_to_die-remains>15|raid_event.adds.in>20)
    if IsReady("Vanish") and S.IndiscriminateCarnage:IsAvailable() and S.ImprovedGarrote:IsAvailable() and S.Garrote:CooldownUp() and (Target:PMultiplier(S.Garrote) <= 1 or Target:DebuffRefreshable(S.Garrote, S.Garrote:PandemicThreshold())) and MeleeEnemies10yCount > 2 then
        return S.Vanish:Cast()
    end
    --vanish,if=talent.master_assassin&dot.garrote.remains>3&debuff.deathmark.up&dot.kingsbane.remains<=6+3*talent.subterfuge.rank&(debuff.shiv.up|debuff.deathmark.remains<4)
    if IsReady("Vanish") and S.MasterAssassin:IsAvailable() and Target:DebuffRemains(S.Garrote) > 3 and Target:DebuffUp(S.Deathmark) and Target:DebuffRemains(S.Kingsbane) <= 6 + 3 * S.Subterfuge:TalentRank() and (Target:DebuffUp(S.ShivDebuff) or Target:DebuffRemains(S.Deathmark) < 4) then
        return S.Vanish:Cast()
    end
    --vanish,if=talent.improved_garrote&cooldown.garrote.up&(dot.garrote.pmultiplier<=1|dot.garrote.refreshable)&(debuff.deathmark.up|cooldown.deathmark.remains<4)&raid_event.adds.in>30
    if IsReady("Vanish") and S.ImprovedGarrote:IsAvailable() and S.Garrote:CooldownUp() and (Target:PMultiplier(S.Garrote) <= 1 or Target:DebuffRefreshable(S.Garrote, S.Garrote:PandemicThreshold())) and (Target:DebuffUp(S.Deathmark) or S.Deathmark:CooldownRemains() < 4) then
        return S.Vanish:Cast()
    end
    
    return nil
end

local function shiv()
    --shiv,if=talent.arterial_precision&variable.shiv_condition&spell_targets.fan_of_knives>=4&dot.crimson_tempest.ticking
    if IsReady("Shiv") and S.ArterialPrecision:IsAvailable() and shiv_condition and MeleeEnemies10yCount >= 4 and Target:DebuffUp(S.CrimsonTempest) then
        return S.Shiv:Cast()
    end
    --shiv,if=!talent.lightweight_shiv.enabled&variable.shiv_kingsbane_condition&(dot.kingsbane.ticking&dot.kingsbane.remains<8|!dot.kingsbane.ticking&cooldown.kingsbane.remains>=20)&(!talent.crimson_tempest.enabled|variable.single_target|dot.crimson_tempest.ticking)
    if IsReady("Shiv") and not S.LightweightShiv:IsAvailable() and shiv_kingsbane_condition and (Target:DebuffUp(S.Kingsbane) and Target:DebuffRemains(S.Kingsbane) < 8 or not Target:DebuffUp(S.Kingsbane) and S.Kingsbane:CooldownRemains() >= 20) and (not S.CrimsonTempest:IsAvailable() or single_target or Target:DebuffUp(S.CrimsonTempest)) then
        return S.Shiv:Cast()
    end
    --shiv,if=talent.lightweight_shiv.enabled&variable.shiv_kingsbane_condition&(dot.kingsbane.ticking|cooldown.kingsbane.remains<=1)
    if IsReady("Shiv") and S.LightweightShiv:IsAvailable() and shiv_kingsbane_condition and (Target:DebuffUp(S.Kingsbane) or S.Kingsbane:CooldownRemains() <= 1) then
        return S.Shiv:Cast()
    end
    --shiv,if=talent.arterial_precision&variable.shiv_condition&debuff.deathmark.up
    if IsReady("Shiv") and S.ArterialPrecision:IsAvailable() and shiv_condition and S.Deathmark:AnyDebuffUp() then
        return S.Shiv:Cast()
    end
    --shiv,if=!talent.kingsbane&!talent.arterial_precision&variable.shiv_condition&(!talent.crimson_tempest.enabled|variable.single_target|dot.crimson_tempest.ticking)
    if IsReady("Shiv") and not S.Kingsbane:IsAvailable() and not S.ArterialPrecision:IsAvailable() and shiv_condition and (not S.CrimsonTempest:IsAvailable() or single_target or Target:DebuffUp(S.CrimsonTempest)) then
        return S.Shiv:Cast()
    end
    --shiv,if=fight_remains<=cooldown.shiv.charges*8
    return nil
end

local function cds()
    --deathmark,if=(variable.deathmark_condition&target.time_to_die>=10)|fight_remains<=20
    if IsReady("Deathmark") and TargetinRange(5) and deathmark_condition then
        return S.Deathmark:Cast()
    end
    --call_action_list,name=shiv
    if shiv() and TargetinRange(5) then
        return shiv()
    end
    --kingsbane,if=(debuff.shiv.up|cooldown.shiv.remains<6)&buff.envenom.up&(cooldown.deathmark.remains>=50|dot.deathmark.ticking)|fight_remains<=15
    if IsReady("Kingsbane") and TargetinRange(5) and ((Target:DebuffUp(S.ShivDebuff) or S.Shiv:CooldownRemains() < 6) and Player:BuffUp(S.Envenom) and (S.Deathmark:CooldownRemains() >= 50 or Target:DebuffUp(S.Deathmark))) then
        return S.Kingsbane:Cast()
    end
    --thistle_tea,if=!buff.thistle_tea.up&(dot.kingsbane.ticking|debuff.shiv.remains>=4)|spell_targets.fan_of_knives>=4&debuff.shiv.remains>=6|fight_remains<=cooldown.thistle_tea.charges*6

    --call_action_list,name=misc_cds

    --call_action_list,name=vanish,if=!stealthed.all&master_assassin_remains=0
    if vanish() and not Player:StealthUp(true, true) and MasterAssassinRemains() <= 0 then
        return vanish()
    end

    --cold_blood,use_off_gcd=1,if=(buff.fatebound_coin_tails.stack>0&buff.fatebound_coin_heads.stack>0)|debuff.shiv.up&(cooldown.deathmark.remains>50|!talent.inevitabile_end&effective_combo_points>=variable.effective_spend_cp)
    if IsReady("Cold Blood") and TargetinRange(5) and ((FBcoinTailsstacks > 0 and FBcoinHeadsstacks > 0) or Target:DebuffUp(S.ShivDebuff) and (S.Deathmark:CooldownRemains() > 50 or not S.FateboundInevitability:IsAvailable() and Player:ComboPoints() >= EffectiveCPSpend)) then
        return S.ColdBlood:Cast()
    end

    return nil
end

local function core_dot()
    -- garrote,if=combo_points.deficit>=1&(pmultiplier<=1)&refreshable&target.time_to_die-remains>12
    if IsReady("Garrote") and Player:ComboPointsDeficit() >= 1 and Target:PMultiplier(S.Garrote) <= 1 and Target:DebuffRefreshable(S.Garrote, S.Garrote:PandemicThreshold()) then
        return S.Garrote:Cast()
    end
    -- rupture,if=combo_points>=variable.effective_spend_cp&(pmultiplier<=1)&refreshable& target.time_to_die-remains>(4+(talent.dashing_scoundrel*5)+(variable.regen_saturated*6))   &(!buff.darkest_night.up|talent.caustic_spatter&!debuff.caustic_spatter.up)
    if IsReady("Rupture") and Player:ComboPoints() >= EffectiveCPSpend and Target:PMultiplier(S.Rupture) <= 1 and Target:DebuffRefreshable(S.Rupture, S.Rupture:PandemicThreshold()) and (not Player:BuffUp(S.DarkestNightBuff) or S.CausticSpatter:IsAvailable() and not Target:DebuffUp(S.CausticSpatterDebuff)) then
        return S.Rupture:Cast()
    end
    
    return nil
end

local function direct()
    --envenom,if=!buff.darkest_night.up&combo_points>=variable.effective_spend_cp&(variable.not_pooling|debuff.amplifying_poison.stack>=20|!variable.single_target)&!buff.vanish.up
    if IsReady("Envenom") and TargetinRange(5) and (Player:BuffDown(S.DarkestNightBuff) and Player:ComboPoints() >= EffectiveCPSpend and (not_pooling or Target:DebuffStack(S.AmplifyingPoisonDebuff) >= 20 or not single_target) and Player:BuffDown(S.VanishBuff) and Player:BuffDown(S.VanishBuff2)) then
        return S.Envenom:Cast()
    end
    --envenom,if=buff.darkest_night.up&effective_combo_points>=cp_max_spend
    if IsReady("Envenom") and TargetinRange(5) and Player:BuffUp(S.DarkestNightBuff) and Player:ComboPoints() >= CPMaxSpend() then
        return S.Envenom:Cast()
    end
    -- mutilate,if=variable.use_caustic_filler
    if IsReady("Mutilate") and TargetinRange(5) and use_caustic_filler then
        return S.Mutilate:Cast()
    end
    -- ambush,if=variable.use_caustic_filler
    if IsReady("Ambush")  and TargetinRange(5) and use_caustic_filler then
        return S.Ambush:Cast()
    end
    -- fan_of_knives,if=variable.use_filler&!priority_rotation&(spell_targets.fan_of_knives>=3-(talent.momentum_of_despair&talent.thrown_precision)|buff.clear_the_witnesses.up&!talent.vicious_venoms)
    if IsReady("Fan of Knives") and MeleeEnemies10yCount > 0 and RubimRH.AoEON() and (use_filler and (MeleeEnemies10yCount >= 3 - BoolToInt(S.MomentumOfDespair:IsAvailable() and S.ThrownPrecision:IsAvailable())) or Player:BuffUp(S.ClearTheWitnessesBuff) and not S.ViciousVenoms:IsAvailable()) then
        return S.FanofKnives:Cast()
    end
    -- fan_of_knives,target_if=!dot.deadly_poison_dot.ticking&(!priority_rotation|dot.garrote.ticking|dot.rupture.ticking),if=variable.use_filler&spell_targets.fan_of_knives>=3-(talent.momentum_of_despair&talent.thrown_precision)
    if IsReady("Fan of Knives") and DebuffRefreshableAOE("Deadly Poison",0) > 1 and (Target:DebuffUp(S.Garrote) or Target:DebuffUp(S.Rupture)) and use_filler and MeleeEnemies10yCount >= 3 - num((S.MomentofClarity:IsAvailable() and S.ThrownPrecision:IsAvailable())) then
        return S.FanofKnives:Cast()
    end                                                                                                                                                     
    -- ambush,if=variable.use_filler&(buff.blindside.up|stealthed.rogue)&(!dot.kingsbane.ticking|debuff.deathmark.down|buff.blindside.up)
    if IsReady("Ambush") and TargetinRange(5) and (use_filler and (Player:BuffUp(S.BlindsideBuff) or Player:StealthUp(true, false)) and (Target:DebuffDown(S.Kingsbane) or Target:DebuffDown(S.Deathmark) or Player:BuffUp(S.BlindsideBuff))) then
        return S.Ambush:Cast()
    end
    -- mutilate,target_if=!dot.deadly_poison_dot.ticking&!debuff.amplifying_poison.up,if=variable.use_filler&spell_targets.fan_of_knives=2
    if IsReady("Mutilate") and TargetinRange(5) and (use_filler and MeleeEnemies10yCount == 2 and Target:DebuffDown(S.DeadlyPoisonDebuff, true) and Target:DebuffDown(S.AmplifyingPoisonDebuff, true)) then
        return S.Mutilate:Cast()
    end
    -- mutilate,if=variable.use_filler
    if IsReady("Mutilate") and TargetinRange(5) and use_filler then
        return S.Mutilate:Cast()
    end
    return nil
end

local function stealthed()
    --pool_resource,for_next=1
    --ambush,if=!debuff.deathstalkers_mark.up&talent.deathstalkers_mark
    if IsReady("Ambush") and Target:DebuffDown(S.DeathStalkersMarkDebuff) and S.DeathStalkersMark:IsAvailable() then
        return S.Ambush:Cast()
    end
    --shiv,if=talent.kingsbane&(dot.kingsbane.ticking|cooldown.kingsbane.up)&(!debuff.shiv.up&debuff.shiv.remains<1)&buff.envenom.up
    if IsReady("Shiv") and S.Kingsbane:IsAvailable() and Player:BuffUp(S.Envenom) and (Target:DebuffUp(S.Kingsbane) or S.Kingsbane:CooldownUp()) and Target:DebuffDown(S.ShivDebuff) then
        return S.Shiv:Cast()
    end
    --envenom,if=effective_combo_points>=variable.effective_spend_cp&dot.kingsbane.ticking&buff.envenom.remains<=3&(debuff.deathstalkers_mark.up|buff.cold_blood.up)
    if IsReady("Envenom") and Player:ComboPoints() >= EffectiveCPSpend and Target:DebuffUp(S.Kingsbane) and Player:BuffRemains(S.Envenom) <= 3 and (Target:DebuffUp(S.DeathStalkersMark) or Player:BuffUp(S.ColdBlood)) then
        return S.Envenom:Cast()
    end
    --envenom,if=effective_combo_points>=variable.effective_spend_cp&buff.master_assassin_aura.up&variable.single_target&(debuff.deathstalkers_mark.up|buff.cold_blood.up)
    if IsReady("Envenom") and Player:ComboPoints() >= EffectiveCPSpend and Player:BuffUp(S.MasterAssassinBuff) and single_target and (Target:DebuffUp(S.DeathStalkersMark) or Player:BuffUp(S.ColdBlood)) then
        return S.Envenom:Cast()
    end
    --rupture,target_if=effective_combo_points>=variable.effective_spend_cp&buff.indiscriminate_carnage.up&refreshable&(!variable.regen_saturated|!variable.scent_saturation|!dot.rupture.ticking)&target.time_to_die>15
    if IsReady("Rupture") and Player:ComboPoints() >= EffectiveCPSpend and Player:BuffUp(S.IndiscriminateCarnageBuff) and Target:DebuffRefreshable(S.Rupture, S.Rupture:PandemicThreshold()) and (not regen_saturated or not ScentSaturatedVar() or Target:DebuffDown(S.Rupture)) then
        return S.Rupture:Cast()
    end
    --garrote,target_if=min:remains,if=stealthed.improved_garrote&(remains<12|pmultiplier<=1|(buff.indiscriminate_carnage.up&active_dot.garrote<spell_targets.fan_of_knives))&!variable.single_target&target.time_to_die-remains>2                                                                              
    if IsReady("Garrote") and ImprovedGarroteRemains() > 0 and (Target:DebuffRemains(S.Garrote) < 12 or Target:PMultiplier(S.Garrote) <= 1 or (Player:BuffUp(S.IndiscriminateCarnageBuff) and S.Garrote:AuraActiveCount() < MeleeEnemies10yCount)) and not single_target then
        return S.Garrote:Cast()
    end
    --garrote,if=stealthed.improved_garrote&(pmultiplier<=1|refreshable)&combo_points.deficit>=1+2*talent.shrouded_suffocation
    if IsReady("Garrote") and ImprovedGarroteRemains() > 0 and (Target:PMultiplier(S.Garrote) <= 1 or Target:DebuffRefreshable(S.Garrote, S.Garrote:PandemicThreshold())) and Player:ComboPointsDeficit() >= 1 + 2 * num(S.ShroudedSuffocation:IsAvailable()) then
        return S.Garrote:Cast()
    end
    return nil
end

--TO CHECK:
--pool_resource
--pmultiplier (see dot_finisher_condition)
--priority_rotation
--adjust pandemic & check IsDebuffRefreshable
local function APL()
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Functions & Variables-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
if Player:IsCasting() or Player:IsChanneling() then
    return 0, "Interface\\Addons\\Rubim-RH\\Media\\channel.tga"
elseif Player:IsDeadOrGhost() or AuraUtil.FindAuraByName("Drink", "player") or AuraUtil.FindAuraByName("Food", "player") or AuraUtil.FindAuraByName("Food and Drink", "player") or (IsResting("player") and not Player:CanAttack(Target)) then
    return 0, "Interface\\Addons\\Rubim-RH\\Media\\mount2.tga"
end

MeleeEnemies10yCount = RangeCount(10)
EnergyRegenCombined = Player:EnergyRegen() + PoisonedBleeds() * 6 / (2 * Player:SpellHaste())
EffectiveCPSpend = mathmax(Player:ComboPointsMax() - 2, 5 * num(S.HandOfFate:IsAvailable()))
--value=combo_points>=variable.effective_spend_cp&(pmultiplier<=1)
dot_finisher_condition = Player:ComboPoints() >= EffectiveCPSpend
--value=energy.regen_combined>30
regen_saturated = EnergyRegenCombined > 30
BleedTickTime = 2 * Player:SpellHaste(), 1 * Player:SpellHaste()
--value=!talent.master_assassin.enabled|dot.garrote.ticking
deathmark_ma_condition = not S.MasterAssassin:IsAvailable() or Target:DebuffUp(S.Garrote)
--value=!talent.kingsbane|cooldown.kingsbane.remains<=2
deathmark_kingsbane_condition = not S.Kingsbane:IsAvailable() or S.Kingsbane:CooldownRemains() <= 2
--value=!stealthed.rogue&buff.slice_and_dice.remains>5&dot.rupture.ticking&buff.envenom.up&!debuff.deathmark.up&variable.deathmark_ma_condition&variable.deathmark_kingsbane_condition
deathmark_condition = not Player:StealthUp(true, true) and Player:BuffRemains(S.SliceandDice) > 5 and Target:DebuffRemains(S.Rupture) and Player:BuffUp(S.Envenom) and not Target:DebuffUp(S.Deathmark) and deathmark_ma_condition and deathmark_kingsbane_condition
-- actions+=/variable,name=in_cooldowns,value=dot.deathmark.ticking|dot.kingsbane.ticking|debuff.shiv.up
in_cooldowns = Target:DebuffUp(S.Deathmark) or Target:DebuffUp(S.Kingsbane) or Target:DebuffUp(S.Shiv)
-- actions+=/variable,name=clip_envenom,value=buff.envenom.up&buff.envenom.remains.1<=1
clip_envenom = Player:BuffUp(S.Envenom) and Target:DebuffRemains(S.Envenom) <= 1
-- actions+=/variable,name=upper_limit_energy,value=energy.pct>=(50-10*talent.vicious_venoms.rank)
upper_limit_energy = Player:EnergyPercentage() >= (50 - 30 * BoolToInt(S.SanguineBlades:IsAvailable()) - 10 * S.ViciousVenoms:TalentRank())
-- actions+=/variable,name=avoid_tea,value=energy>40+50+5*talent.vicious_venoms.rank
avoid_tea = Player:Energy() > 40 + 50 + 5 * S.ViciousVenoms:TalentRank()
-- actions+=/variable,name=cd_soon,value=cooldown.kingsbane.remains<3&!cooldown.kingsbane.ready
cd_soon = S.Kingsbane:CooldownRemains() < 3 and not IsReady("Kingsbane")
--value=variable.in_cooldowns|!variable.cd_soon&variable.avoid_tea&buff.darkest_night.up|!variable.cd_soon&variable.avoid_tea&variable.clip_envenom|variable.upper_limit_energy|fight_remains<=20
not_pooling = in_cooldowns or not cd_soon and avoid_tea and Player:BuffUp(S.DarkestNightBuff) or not cd_soon and avoid_tea and clip_envenom or upper_limit_energy
single_target = MeleeEnemies10yCount < 2
--value=combo_points<=variable.effective_spend_cp&!variable.cd_soon|variable.not_pooling|!variable.single_target
use_filler = Player:ComboPoints() <= EffectiveCPSpend and not cd_soon or not_pooling or not single_target
--value=talent.caustic_spatter&dot.rupture.ticking&(!debuff.caustic_spatter.up|debuff.caustic_spatter.remains<=2)&combo_points.deficit>=1&!variable.single_target
use_caustic_filler = S.CausticSpatter:IsAvailable() and Target:DebuffUp(S.Rupture) and (not Target:DebuffUp(S.CausticSpatterDebuff) or Target:DebuffRemains(S.CausticSpatterDebuff) <= 2) and Player:ComboPointsDeficit() >= 1 and not single_target
--value=!debuff.shiv.up&dot.garrote.ticking&dot.rupture.ticking
shiv_condition = Target:DebuffDown(S.ShivDebuff) and Target:DebuffUp(S.Garrote) and Target:DebuffUp(S.Rupture)
--value=talent.kingsbane&buff.envenom.up&variable.shiv_condition
shiv_kingsbane_condition = S.Kingsbane:IsAvailable() and Player:BuffUp(S.Envenom) and shiv_condition
startTimeMS = (select(4, UnitCastingInfo('target')) or select(4, UnitChannelInfo('target')) or 0)
elapsedTimeca = ((startTimeMS > 0) and (GetTime() * 1000 - startTimeMS) or 0)
elapsedTimech = ((startTimeMS > 0) and (GetTime() * 1000 - startTimeMS) or 0)
channelTime = elapsedTimech / 1000
castTime = elapsedTimeca / 1000
castchannelTime = math.random(275, 500) / 1000
if AuraUtil.FindAuraByName('Fatebound Coin (Heads)','player') then
_, _, FBcoinHeadsstacks = AuraUtil.FindAuraByName('Fatebound Coin (Heads)','player')
else
FBcoinHeadsstacks = 0
end
if AuraUtil.FindAuraByName('Fatebound Coin (Tails)','player') then
_, _, FBcoinTailsstacks = AuraUtil.FindAuraByName('Fatebound Coin (Tails)','player')
else
FBcoinTailsstacks = 0
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Out of Combat-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
if not Player:AffectingCombat() and Player:BuffDown(S.VanishBuff) then
    if IsReady("Stealth") and not AuraUtil.FindAuraByName("Stealth", "player") and not Player:BuffUp(S.VanishBuff) and not Player:BuffUp(S.VanishBuff2) and not Player:DebuffUp(S.HeartseekingHealthInjector) then
        return S.Stealth:Cast()
    end
  
    if IsReady("Crimson Vial") and RangeCount(20) == 0 and Player:HealthPercentage() < 75 and Player:EnergyDeficit() == 0 then
        return S.CrimsonVial:Cast()
    end
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Spell Queue---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
if not RubimRH.queuedSpell[1]:CooldownUp() or not RubimRH.queuedSpell[1]:IsAvailable() or not Player:AffectingCombat()
or (S.KidneyShot:ID() == RubimRH.queuedSpell[1]:ID() and (Target:DebuffUp(S.CheapShot) or Target:DebuffUp(S.KidneyShot) or Target:DebuffUp(S.Blind))) then
	RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
end

if IsReady(RubimRH.queuedSpell[1]:ID(),nil,nil,1) and S.Ambush:ID() ~= RubimRH.queuedSpell[1]:ID() then
    return RubimRH.QueuedSpell():Cast()
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Interrupts & Defensives---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
if Player:HealthPercentage() <= 20 and Player:AffectingCombat() and (not Player:InArena() and not Player:InBattlegrounds()) then
    if (IsUsableItem(211878) == true and GetItemCooldown(211878) == 0 and GetItemCount(211878) >= 1) 
    or (IsUsableItem(211879) == true and GetItemCooldown(211879) == 0 and GetItemCount(211879) >= 1)
    or (IsUsableItem(211880) == true and GetItemCooldown(211880) == 0 and GetItemCount(211880) >= 1)
      --hp wrists
    or (IsUsableItem(221806) == true and GetItemCooldown(221806) == 0) then
        return I.HPIcon:Cast()
    end
end
  
if RubimRH.InterruptsON() and not AuraUtil.FindAuraByName("Stealth", "player") and Player:CanAttack(Target) and Player:AffectingCombat() then
    if IsReady("Kick") and TargetinRange(5) and (castTime > castchannelTime + 0.5 or channelTime > castchannelTime + 0.5) and select(8, UnitCastingInfo("target")) == false then
        return S.Kick:Cast()
    end
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Rotation------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
if UnitCanAttack('player','target') and not Target:IsDeadOrGhost() and (not AuraUtil.FindAuraByName("Stealth", "player") or Player:BuffUp(S.VanishBuff)) and ((Target:AffectingCombat() or target_is_dummy() or Player:BuffUp(S.VanishBuff)) or C_Spell.IsCurrentSpell(6603)) then
    if not C_Spell.IsCurrentSpell(6603) and C_Item.IsItemInRange(10645, "target") and Player:BuffDown(S.VanishBuff) and Player:BuffDown(S.Stealth) and Player:AffectingCombat() then
		return S.autoattack:Cast()
	end
    --call_action_list,name=stealthed,if=stealthed.rogue|stealthed.improved_garrote|master_assassin_remains>0
    if stealthed() and TargetinRange(5) and (Player:StealthUp(true, false) or ImprovedGarroteRemains() > 0 or MasterAssassinRemains() > 0) then
        return stealthed()
    end
    --call_action_list,name=cds
    if cds() and TargetinRange(5) and RubimRH.CDsON() then
        return cds()
    end
    --call_action_list,name=core_dot
    if core_dot() and TargetinRange(5) then
        return core_dot()
    end
    --call_action_list,name=aoe_dot,if=!variable.single_target
    if aoe_dot() and not single_target then
        return aoe_dot()
    end
    --call_action_list,name=direct
    if direct() then
        return direct()
    end
end
    return 0, "Interface\\Addons\\Rubim-RH\\Media\\mount2.tga"
end

RubimRH.Rotation.SetAPL(259, APL)