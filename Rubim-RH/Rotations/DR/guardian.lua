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
local MultiSpell = HL.MultiSpell


-- Spells
RubimRH.Spell[104] = {
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
 -- Other
 Pool                                  = Spell(999910),
 
   -- Talents
   BoundlessMoonlight                    = Spell(424058),
   LunarCalling                          = Spell(429523),
   LunarInsight                          = Spell(429530),
   MoonGuardian                          = Spell(429520),
 -- Abilities
 Mangle                                = Spell(33917),
 -- Talents
 Berserk                               = Spell(50334),
 BristlingFur                          = Spell(155835),
 FlashingClaws                         = Spell(393427),
 FuryofNature                          = Spell(370695),
 Incarnation                           = Spell(102558),
 LunarBeam                             = Spell(204066),
 Maul                                  = Spell(6807),
 Pulverize                             = Spell(80313),
 RageoftheSleeper                      = Spell(200851),
 Raze                                  = Spell(400254),
 ReinforcedFur                         = Spell(393618),
 SouloftheForest                       = Spell(158477),
 Swipe                                 = Spell(213771),
 ThornsofIron                          = Spell(400222),
 -- Buffs
 DreamofCenariusBuff                   = Spell(372152),
 GalacticGuardianBuff                  = Spell(213708),
 GoreBuff                              = Spell(93622),
 ToothandClawBuff                      = Spell(135286),
 ViciousCycleMaulBuff                  = Spell(372015),
 ViciousCycleMangleBuff                = Spell(372019),
Growl = Spell(6795),
  -- Abilities
  RavageAbilityBear                     = Spell(441605),
  RavageAbilityCat                      = Spell(441591),
  -- Talents
  FountofStrength                       = Spell(441675),
  Ravage                                = Spell(441583),
  WildpowerSurge                        = Spell(441691),
  RemoveCorruption = Spell(2782),
  -- Buffs
  FelinePotentialBuff                   = Spell(441701),
  RavageBuffFeral                       = Spell(441585),
  RavageBuffGuardian                    = Spell(441602),
autoattack                  = Spell(291944), -- regeneratin
IncapacitatingRoar = Spell(99),
lustAT = Spell(155145),
lust1 = Spell(57724),
lust2 = Spell(57723),
lust3 = Spell(80354),
lust4 = Spell(95809),
lust5 = Spell(264689),
StampedingRoar = Spell(106898),

};




local S = RubimRH.Spell[104];

S.StampedingRoar.TextureSpellID = { 255654 }

local G = RubimRH.Spell[1];

--S.Raze.TextureSpellID = { 258082 } --Icy Claws

-- Items
if not Item.Druid then
    Item.Druid = {}
end

Item.Druid.Guardian = {

	HPIcon = Item(169451),
	drums = Item(219905),
};

local I = Item.Druid.Guardian;

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

--- ===== Rotation Variables =====
local VarIFBuild = S.ThornsofIron:IsAvailable() and S.ReinforcedFur:IsAvailable()
local VarRipWeaving = S.PrimalFury:IsAvailable() and S.FluidForm:IsAvailable() and S.WildpowerSurge:IsAvailable()
local MeleeRange, AoERange

local ActiveMitigationNeeded
local IsTanking
local UseMaul



HL:RegisterForEvent(function()
	VarIFBuild = S.ThornsofIron:IsAvailable() and S.ReinforcedFur:IsAvailable()
	VarRipWeaving = S.PrimalFury:IsAvailable() and S.FluidForm:IsAvailable() and S.WildpowerSurge:IsAvailable()
  end, "SPELLS_CHANGED", "LEARNED_SPELL_IN_TAB")

  --=== CastCycle Functions =====
  local function EvaluateCycleMoonfire()
	-- if=buff.bear_form.up&(((!ticking&target.time_to_die>12)|(refreshable&target.time_to_die>12))&active_enemies<7&talent.fury_of_nature.enabled)|(((!ticking&target.time_to_die>12)|(refreshable&target.time_to_die>12))&active_enemies<4&!talent.fury_of_nature.enabled)
	-- Note: Simplified.
	return ((Target:DebuffDown(S.MoonfireDebuff) and Target:TimeToDie() > 12) or (Target:DebuffRefreshable(S.MoonfireDebuff) and Target:TimeToDie() > 12)) and (RangeCount(8) < 7 and S.FuryofNature:IsAvailable() or RangeCount(8) < 4 and not S.FuryofNature:IsAvailable())
  end
  
  local function EvaluateCyclePulverize()
	-- target_if=dot.thrash_bear.stack>2
	return Target:DebuffStack(S.ThrashBearDebuff) > 2
  end
  
  local function EvaluateCycleThrash()
	-- target_if=refreshable|(dot.thrash_bear.stack<5&talent.flashing_claws.rank=2|dot.thrash_bear.stack<4&talent.flashing_claws.rank=1|dot.thrash_bear.stack<3&!talent.flashing_claws.enabled)
	return Target:DebuffRefreshable(S.ThrashBearDebuff) or (Target:DebuffStack(S.ThrashBearDebuff) < 5 and S.FlashingClaws:TalentRank() == 2 or Target:DebuffStack(S.ThrashBearDebuff) < 4 and S.FlashingClaws:TalentRank() == 1 or Target:DebuffStack(S.ThrashBearDebuff) < 3 and not S.FlashingClaws:IsAvailable())
  end
  

--- ===== Rotation Functions =====
local function Precombat()

	if IsReady("Moonfire") and (targetRange40 and Target:AffectingCombat() or targetRange20) then
		return S.Moonfire:Cast()
	end

	-- Manually added: thrash_bear
	if IsReady("Thrash") and targetRange8 then
		return S.ThrashBear:Cast()
	end
	-- Manually added: mangle
	if IsReady("Mangle") and targetRange5 then
		return S.Mangle:Cast()
	end
  end

  local function Defensives()
	if Player:HealthPercentage() < 65 and IsReady("Frenzied Regeneration") and Player:BuffDown(S.FrenziedRegenerationBuff) and not Player:HealingAbsorbed() then
		return S.FrenziedRegeneration:Cast()
	end
	if IsReady("Regrowth") and Player:BuffUp(S.DreamofCenariusBuff) and (Player:BuffDown(S.PoPHealBuff) and Player:HealthPercentage() < 65 or Player:BuffUp(S.PoPHealBuff) and Player:HealthPercentage() < 65) then
		return S.Regrowth:Cast()
	end
	if IsReady("Renewal") and Player:HealthPercentage() < 50 then
		return S.Renewal:Cast()
	end
	if IsReady("Ironfur") and (Player:BuffDown(S.IronfurBuff) or Player:BuffStack(S.IronfurBuff) < 2 and Player:BuffRefreshable(S.Ironfur)) then
		return S.Ironfur:Cast()
	end
  end

  local function Bear()
	-- maul,if=buff.ravage.up&active_enemies>1
	if IsReady("Ravage") and (Player:BuffUp(S.RavageBuffGuardian) and RangeCount(8) > 1) then
		return S.RavageAbilityBear:Cast()
	end
	-- heart_of_the_Wild,if=(talent.heart_of_the_wild.enabled&!talent.rip.enabled)|talent.heart_of_the_wild.enabled&buff.feline_potential_counter.stack=6&active_enemies<3
	if RubimRH.CDsON() and IsReady("Heart of the Wild") and (not S.Rip:IsAvailable() or Player:BuffStack(S.FelinePotentialBuff) == 6 and RangeCount(8) < 3)  and targetRange10 then
		return S.HeartoftheWild:Cast()
	end
	-- moonfire,cycle_targets=1,if=buff.bear_form.up&(((!ticking&target.time_to_die>12)|(refreshable&target.time_to_die>12))&active_enemies<7&talent.fury_of_nature.enabled)|(((!ticking&target.time_to_die>12)|(refreshable&target.time_to_die>12))&active_enemies<4&!talent.fury_of_nature.enabled)
	if IsReady("Moonfire") and Player:BuffUp(S.BearForm) and EvaluateCycleMoonfire()  and (targetRange40 and Target:AffectingCombat() or targetRange20)  then
		return S.Moonfire:Cast()
	end
	-- thrash_bear,target_if=refreshable|(dot.thrash_bear.stack<5&talent.flashing_claws.rank=2|dot.thrash_bear.stack<4&talent.flashing_claws.rank=1|dot.thrash_bear.stack<3&!talent.flashing_claws.enabled)
	if IsReady("Thrash") and EvaluateCycleThrash() and targetRange8 then
		return S.ThrashBear:Cast()
	end
	-- bristling_fur,if=!cooldown.pause_action.remains&cooldown.rage_of_the_sleeper.remains>8
	-- Note: Handled in Defensives().
	-- barkskin,if=buff.bear_form.up
	-- Note: Handled in Defensives().
	-- lunar_beam
	if RubimRH.CDsON() and IsReady("Lunar Beam") and aoerangecheck then
		return S.LunarBeam:Cast()
	end
	-- convoke_the_spirits,if=(talent.wildpower_surge.enabled&buff.cat_form.up&buff.feline_potential.up)|!talent.wildpower_surge.enabled
	if RubimRH.CDsON() and IsReady("Convoke the Spirits") and targetRange10 then
		return S.ConvoketheSpirits:Cast()
	end
	-- berserk_bear
	if RubimRH.CDsON() and IsReady("Berserk") and targetRange10 then
		return S.Berserk:Cast()
	end
	-- incarnation
	if RubimRH.CDsON() and IsReady("Incarnation: Guardian of Ursoc") and targetRange10 then
		return S.Incarnation:Cast()
	end
	-- rage_of_the_sleeper,if=(((buff.incarnation_guardian_of_ursoc.down&cooldown.incarnation_guardian_of_ursoc.remains>60)|buff.berserk_bear.down)&rage>40&(!talent.convoke_the_spirits.enabled)|(buff.incarnation_guardian_of_ursoc.up|buff.berserk_bear.up)&rage>40&(!talent.convoke_the_spirits.enabled)|(talent.convoke_the_spirits.enabled)&rage>40)
	if RubimRH.CDsON() and targetRange10 
	and (not IsEncounterInProgress(Boss)) 
	and IsReady("Rage of the Sleeper") 
	and (((Player:BuffDown(S.Incarnation) and S.Incarnation:CooldownRemains() > 60) 
	or Player:BuffDown(S.Berserk)) and Player:Rage() > 40 and not S.ConvoketheSpirits:IsAvailable()
	 or (Player:BuffUp(S.Incarnation) or Player:BuffUp(S.Berserk)) and Player:Rage() > 40 and not S.ConvoketheSpirits:IsAvailable() 
	 or S.ConvoketheSpirits:IsAvailable() and Player:Rage() > 40) then
		return S.RageoftheSleeper:Cast()
	end

	-- maul,if=buff.ravage.up&active_enemies<2
	if IsReady("Ravage") and (Player:BuffUp(S.RavageBuffGuardian) and RangeCount(8) < 2) then
		return S.RavageAbilityBear:Cast()
	end
	-- raze,if=(buff.tooth_and_claw.stack>1|buff.tooth_and_claw.remains<1+gcd)&variable.If_build=1&active_enemies>1
	if IsReady("Raze") and ((Player:BuffStack(S.ToothandClawBuff) > 1 or Player:BuffRemains(S.ToothandClawBuff) < 1 + Player:GCD()) and VarIFBuild and RangeCount(8) > 1) then
		return S.Raze:Cast()
	end
	-- thrash_bear,if=active_enemies>=5&talent.lunar_calling.enabled
	if IsReady("Thrash") and (RangeCount(8) >= 5 and S.LunarCalling:IsAvailable()) and targetRange8  then
		return S.ThrashBear:Cast()
	end
	-- ironfur,target_if=!debuff.tooth_and_claw.up,if=!buff.ironfur.up&rage>50&!cooldown.pause_action.remains&variable.If_build=0&!buff.rage_of_the_sleeper.up|rage>90&variable.If_build=0|!debuff.tooth_and_claw.up&!buff.ironfur.up&rage>50&!cooldown.pause_action.remains&variable.If_build=0&!buff.rage_of_the_sleeper.up
	if IsReady("Ironfur") and targetRange15 and (Player:BuffDown(S.IronfurBuff) and Player:Rage() > 50 and IsTanking and not VarIFBuild and Player:BuffDown(S.RageoftheSleeper) or Player:Rage() > 90 and not VarIFBuild or Player:BuffDown(S.ToothandClawBuff) and Player:BuffDown(S.IronfurBuff) and Player:Rage() > 50 and IsTanking and not VarIFBuild and Player:BuffDown(S.RageoftheSleeper)) then
		return S.Ironfur:Cast()
	end
	-- ironfur,if=!buff.ravage.up&((rage>40&variable.If_build=1&cooldown.rage_of_the_sleeper.remains>3&talent.rage_of_the_sleeper.enabled|(buff.incarnation.up|buff.berserk_bear.up)&rage>20&variable.If_build=1&cooldown.rage_of_the_sleeper.remains>3&talent.rage_of_the_sleeper.enabled|rage>90&variable.If_build=1&!talent.fount_of_strength.enabled|rage>110&variable.If_build=1&talent.fount_of_strength.enabled|(buff.incarnation.up|buff.berserk_bear.up)&rage>20&variable.If_build=1&buff.rage_of_the_sleeper.up&talent.rage_of_the_sleeper.enabled))
	if IsReady("Ironfur") and targetRange15 and (Player:BuffDown(S.RavageBuffGuardian) and (Player:Rage() > 40 and VarIFBuild and S.RageoftheSleeper:CooldownRemains() > 3 and S.RageoftheSleeper:IsAvailable() or (Player:BuffUp(S.Incarnation) or Player:BuffUp(S.Berserk)) and Player:Rage() > 20 and VarIFBuild and S.RageoftheSleeper:CooldownRemains() > 3 and S.RageoftheSleeper:IsAvailable() or Player:Rage() > 90 and VarIFBuild and not S.FountofStrength:IsAvailable() or Player:Rage() > 110 and VarIFBuild and S.FountofStrength:IsAvailable() or (Player:BuffUp(S.Incarnation) or Player:BuffUp(S.Berserk)) and Player:Rage() > 20 and VarIFBuild and Player:BuffUp(S.RageoftheSleeper) and S.RageoftheSleeper:IsAvailable())) then
		return S.Ironfur:Cast()
	end
	-- ironfur,if=!buff.ravage.up&((rage>40&variable.If_build=1&!talent.rage_of_the_sleeper.enabled|(buff.incarnation.up|buff.berserk_bear.up)&rage>20&variable.If_build=1&!talent.rage_of_the_sleeper.enabled|(buff.incarnation.up|buff.berserk_bear.up)&rage>20&variable.If_build=1&!talent.rage_of_the_sleeper.enabled))
	if IsReady("Ironfur") and targetRange15 and (Player:BuffDown(S.RavageBuffGuardian) and (Player:Rage() > 40 and VarIFBuild and not S.RageoftheSleeper:IsAvailable() or (Player:BuffUp(S.Incarnation) or Player:BuffUp(S.Berserk)) and Player:Rage() > 20 and VarIFBuild and not S.RageoftheSleeper:IsAvailable() or (Player:BuffUp(S.Incarnation) or Player:BuffUp(S.Berserk)) and Player:Rage() > 20 and VarIFBuild and not S.RageoftheSleeper:IsAvailable())) then
		return S.Ironfur:Cast()
	end
	-- ferocious_bite,if=(buff.cat_form.up&buff.feline_potential.up&active_enemies<3&(buff.incarnation.up|buff.berserk_bear.up)&!dot.rip.refreshable)
	if IsReady("Ferocious Bite") and targetRange8 and (Player:BuffUp(S.CatForm) and Player:BuffStack(S.FelinePotentialBuff) == 6 and RangeCount(8) < 3 and (Player:BuffUp(S.Incarnation) or Player:BuffUp(S.Berserk)) and not Target:DebuffRefreshable(S.RipDebuff)) then
		return S.FerociousBite:Cast()
	end
	-- rip,if=(buff.cat_form.up&buff.feline_potential.up&active_enemies<3&(!buff.incarnation.up|!buff.berserk_bear.up))|(buff.cat_form.up&buff.feline_potential.up&active_enemies<3&(buff.incarnation.up|buff.berserk_bear.up)&refreshable)
	if IsReady("Rip")  and targetRange8 and ((Player:BuffUp(S.CatForm) and Player:BuffStack(S.FelinePotentialBuff) == 6 and RangeCount(8) < 3 and (Player:BuffDown(S.Incarnation) or Player:BuffDown(S.Berserk))) or (Player:BuffUp(S.CatForm) and Player:BuffStack(S.FelinePotentialBuff) == 6 and RangeCount(8) < 3 and (Player:BuffUp(S.Incarnation) or Player:BuffUp(S.Berserk)) and Target:DebuffRefreshable(S.RipDebuff))) then
		return S.Rip:Cast()
	end
	-- raze,if=variable.If_build=1&buff.vicious_cycle_maul.stack=3&active_enemies>1&!talent.ravage.enabled
	if IsReady("Raze")  and targetRange8 and (VarIFBuild and Player:BuffStack(S.ViciousCycleMaulBuff) == 3 and RangeCount(8) > 1 and not S.Ravage:IsAvailable()) then
		return S.Raze:Cast()
	end
	-- mangle,if=buff.gore.up&active_enemies<11|buff.incarnation_guardian_of_ursoc.up&buff.feline_potential_counter.stack<6&talent.wildpower_surge.enabled
	if IsReady("Mangle")  and targetRange5 and (Player:BuffUp(S.GoreBuff) and RangeCount(8) < 11 or Player:BuffUp(S.Incarnation) and Player:BuffStack(S.FelinePotentialBuff) < 6 and S.WildpowerSurge:IsAvailable()) then
		return S.Mangle:Cast()
	end
	-- raze,if=variable.If_build=0&(active_enemies>1|(buff.tooth_and_claw.up)&active_enemies>1|buff.vicious_cycle_maul.stack=3&active_enemies>1)
	if IsReady("Raze") and targetRange8  and (not VarIFBuild and (RangeCount(8) > 1 or Player:BuffUp(S.ToothandClawBuff) and RangeCount(8) > 1 or Player:BuffStack(S.ViciousCycleMaulBuff) == 3 and RangeCount(8) > 1)) then
		return S.Raze:Cast()
	end
	-- shred,if=cooldown.rage_of_the_sleeper.remains<=52&buff.feline_potential_counter.stack=6&!buff.cat_form.up&!dot.rake.refreshable&active_enemies<3&talent.fluid_form.enabled
	if IsReady("Shred") and targetRange8 and (S.RageoftheSleeper:CooldownRemains() <= 52 and Player:BuffStack(S.FelinePotentialBuff) == 6 and Player:BuffDown(S.CatForm) and not Target:DebuffRefreshable(S.RakeDebuff) and RangeCount(8) < 3 and S.FluidForm:IsAvailable()) then
		return S.Shred:Cast()
	end
	-- rake,if=cooldown.rage_of_the_sleeper.remains<=52&buff.feline_potential_counter.stack=6&!buff.cat_form.up&active_enemies<3&talent.fluid_form.enabled
	if IsReady("Rake") and targetRange8 and (S.RageoftheSleeper:CooldownRemains() <= 52 and Player:BuffStack(S.FelinePotentialBuff) == 6 and Player:BuffDown(S.CatForm) and RangeCount(8) < 3 and S.FluidForm:IsAvailable()) then
		return S.Rake:Cast()
	end
	-- mangle,if=buff.cat_form.up&talent.fluid_form.enabled
	if IsReady("Mangle") and targetRange5 and (Player:BuffUp(S.CatForm) and S.FluidForm:IsAvailable()) then
		return S.Mangle:Cast()
	end
	-- maul,if=variable.If_build=1&(((buff.tooth_and_claw.stack>1|buff.tooth_and_claw.remains<1+gcd)&active_enemies<=5&!talent.raze.enabled)|((buff.tooth_and_claw.stack>1|buff.tooth_and_claw.remains<1+gcd)&active_enemies=1&talent.raze.enabled)|((buff.tooth_and_claw.stack>1|buff.tooth_and_claw.remains<1+gcd)&active_enemies<=5&!talent.raze.enabled))
	if IsReady("Maul") and targetRange5 and UseMaul and (VarIFBuild and (((Player:BuffStack(S.ToothandClawBuff) > 1 or Player:BuffRemains(S.ToothandClawBuff) < 1 + Player:GCD()) and RangeCount(8) <= 5 and not S.Raze:IsAvailable()) or ((Player:BuffStack(S.ToothandClawBuff) > 1 or Player:BuffRemains(S.ToothandClawBuff) < 1 + Player:GCD()) and RangeCount(8) == 1 and S.Raze:IsAvailable()) or ((Player:BuffStack(S.ToothandClawBuff) > 1 or Player:BuffRemains(S.ToothandClawBuff) < 1 + Player:GCD()) and RangeCount(8) <= 5 and not S.Raze:IsAvailable()))) then
		return S.Maul:Cast()
	end
	-- maul,if=variable.If_build=0&((buff.tooth_and_claw.up&active_enemies<=5&!talent.raze.enabled)|(buff.tooth_and_claw.up&active_enemies=1&talent.raze.enabled))
	if IsReady("Maul") and targetRange5 and UseMaul and (not VarIFBuild and ((Player:BuffUp(S.ToothandClawBuff) and RangeCount(8) <= 5 and not S.Raze:IsAvailable()) or (Player:BuffUp(S.ToothandClawBuff) and RangeCount(8) == 1 and S.Raze:IsAvailable()))) then
		return S.Maul:Cast()
	end
	-- maul,if=(active_enemies<=5&!talent.raze.enabled&variable.If_build=0)|(active_enemies=1&talent.raze.enabled&variable.If_build=0)|buff.vicious_cycle_maul.stack=3&active_enemies<=5&!talent.raze.enabled
	if IsReady("Maul") and targetRange5 and UseMaul and ((RangeCount(8) <= 5 and not S.Raze:IsAvailable() and not VarIFBuild) or (RangeCount(8) == 1 and S.Raze:IsAvailable() and not VarIFBuild) or Player:BuffStack(S.ViciousCycleMaulBuff) == 3 and RangeCount(8) <= 5 and not S.Raze:IsAvailable()) then
		return S.Maul:Cast()
	end
	-- thrash_bear,if=active_enemies>=5
	if IsReady("Thrash") and targetRange8  and (RangeCount(8) >= 5) then
		return S.ThrashBear:Cast()
	end
	-- mangle,if=(buff.incarnation.up&active_enemies<=4)|(buff.incarnation.up&talent.soul_of_the_forest.enabled&active_enemies<=5)|((rage<88)&active_enemies<11)|((rage<83)&active_enemies<11&talent.soul_of_the_forest.enabled)
	if IsReady("Mangle") and targetRange5  and ((Player:BuffUp(S.Incarnation) and RangeCount(8) <= 4) or (Player:BuffUp(S.Incarnation) and S.SouloftheForest:IsAvailable() and RangeCount(8) <= 5) and ((Player:Rage() < 88) and RangeCount(8) < 11) or ((Player:Rage() < 83) and RangeCount(8) < 11 and S.SouloftheForest:IsAvailable())) then
		return S.Mangle:Cast()
	end
	-- thrash_bear,if=active_enemies>1
	if IsReady("Thrash") and targetRange8 and (RangeCount(8) > 1) then
		return S.ThrashBear:Cast()
	end
	-- pulverize,target_if=dot.thrash_bear.stack>2
	if IsReady("Pulverize") and targetRange8  and EvaluateCyclePulverize() then
		return S.Pulverize:Cast()
	end
	-- thrash_bear
	if IsReady("Thrash") and targetRange8 then
		return S.ThrashBear:Cast()
	end
	-- moonfire,if=buff.galactic_guardian.up&buff.bear_form.up&talent.boundless_moonlight.enabled
	if IsReady("Moonfire")  and (targetRange40 and Target:AffectingCombat() or targetRange20) and (Player:BuffUp(S.GalacticGuardianBuff) and Player:BuffUp(S.BearForm) and S.BoundlessMoonlight:IsAvailable()) then
		return S.Moonfire:Cast()
	end
	-- rake,if=cooldown.rage_of_the_sleeper.remains<=52&rage<40&active_enemies<3&!talent.lunar_insight.enabled&talent.fluid_form.enabled&energy>70&refreshable&variable.ripweaving=1
	if IsReady("Rake")  and targetRange8 and (S.RageoftheSleeper:CooldownRemains() <= 52 and Player:Rage() < 40 and RangeCount(8) < 3 and not S.LunarInsight:IsAvailable() and S.FluidForm:IsAvailable() and Player:Energy() > 70 and Target:DebuffRefreshable(S.RakeDebuff) and VarRipWeaving) then
		return S.Rake:Cast()
	end
	-- shred,if=cooldown.rage_of_the_sleeper.remains<=52&rage<40&active_enemies<3&!talent.lunar_insight.enabled&talent.fluid_form.enabled&energy>70&!buff.rage_of_the_sleeper.up&variable.ripweaving=1
	if IsReady("Shred") and targetRange8 and (S.RageoftheSleeper:CooldownRemains() <= 52 and Player:Rage() < 40 and RangeCount(8) < 3 and not S.LunarInsight:IsAvailable() and S.FluidForm:IsAvailable() and Player:Energy() > 70 and Player:BuffDown(S.RageoftheSleeper) and VarRipWeaving) then
		return S.Shred:Cast()
	end
	-- rip,if=buff.cat_form.up&!dot.rip.ticking&active_enemies<3&variable.ripweaving=1
	if IsReady("Rip") and targetRange8 and (Player:BuffUp(S.CatForm) and Target:DebuffDown(S.RipDebuff) and RangeCount(8) < 3 and VarRipWeaving) then
		return S.Rip:Cast()
	end
	-- ferocious_bite,if=dot.rip.ticking&combo_points>4&active_enemies<3&variable.ripweaving=1
	if IsReady("Ferocious Bite") and targetRange8 and (Target:DebuffUp(S.RipDebuff) and Player:ComboPoints() > 4 and RangeCount(8) < 3 and VarRipWeaving) then
		return S.FerociousBite:Cast()
	end
	-- starsurge,if=talent.starsurge.enabled&rage<20
	if IsReady("Starsurge") and targetRange40 and Target:AffectingCombat() and (Player:Rage() < 20) then
		return S.Starsurge:Cast()
	end
	-- swipe_bear,if=(talent.lunar_insight.enabled&active_enemies>4)|!talent.lunar_insight.enabled|talent.lunar_insight.enabled&active_enemies<2
	if IsReady("Swipe") and targetRange8 and ((S.LunarInsight:IsAvailable() and RangeCount(8) > 4) or not S.LunarInsight:IsAvailable() or S.LunarInsight:IsAvailable() and RangeCount(8) < 2) then
		return S.Swipe:Cast()
	end
	-- moonfire,if=(talent.lunar_insight.enabled&active_enemies>1)&buff.bear_form.up
	if IsReady("Moonfire") and ((S.LunarInsight:IsAvailable() and RangeCount(10) > 1) and Player:BuffUp(S.BearForm)) and (targetRange40 and Target:AffectingCombat() or targetRange20) then
		return S.Moonfire:Cast()
	end
  end
  
local function APL()
	inRange5 = RangeCount(5)
	inRange8 = RangeCount(8)
	inRange10 = RangeCount(8)
	inRange15 = RangeCount(15)
	inRange20 = RangeCount(20)
	inRange25 = RangeCount(25)
	inRange30 = RangeCount(30)
	targetRange5 = C_Item.IsItemInRange(8149, "target")
	targetRange8 = C_Item.IsItemInRange(34368, "target")
	targetRange10 = C_Item.IsItemInRange(32321, "target")
	targetRange15 = C_Item.IsItemInRange(33069, "target")
	targetRange20 = C_Item.IsItemInRange(10645, "target")
	targetRange25 = C_Item.IsItemInRange(24268, "target")
	targetRange30 = C_Item.IsItemInRange(835, "target")
	targetRange40 = C_Spell.IsSpellInRange("Moonfire", "target")

	TrackHealthLossPerSecond()
	
	HPpercentloss = GetHealthLossPerSecond()
	
	
	
	


    if Player:IsCasting() or Player:IsChanneling() then
        return 0, "Interface\\Addons\\Rubim-RH\\Media\\channel.tga"
    elseif Player:IsDeadOrGhost() or AuraUtil.FindAuraByName("Drink", "player") or AuraUtil.FindAuraByName("Food", "player") or AuraUtil.FindAuraByName("Food & Drink", "player")
	 or  (AuraUtil.FindAuraByName("Cat Form", "player") or  AuraUtil.FindAuraByName("Travel Form", "player")) and not Player:AffectingCombat() and RangeCount(8)>=1 then
        return 0, "Interface\\Addons\\Rubim-RH\\Media\\griph.tga"
    end 
    
	local tanking, status, threatpct, rawthreatpct, threatvalue = UnitDetailedThreatSituation("player", "target")

	IsTanking = Player:IsTankingAoE(8) or Player:IsTanking(Target)

	aoerangecheck = (targetRange8 and not Player:IsMoving() or targetRange5 and Player:IsMoving())

	
	local lostimer = GetTime() - losCheckTimer
	local los
	
	if lostimer < Player:GCD() then
	los = true
	else
	los = false
	end

	local inInstance, instanceType = IsInInstance()
	
	local level, affixIDs, wasEnergized = C_ChallengeMode.GetActiveKeystoneInfo()

	local highkey = 2
	
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
	
	local Boss = {
	"Avanoxx",	"Orator Krix'vizk",	"Fangs of the Queen",	"The Coaglamation",	"Izo, the Grand Splicer",	"Speaker Shadowcrown",	"Anub'Ikkaj",	"E.D.N.A",	
	"Master Machinists Brokk and Dorlita",	"Skarmorak",	"Mistcaller",	"Blightbone",	"Amarth",	"Surgeon Stitchflesh",	"General Umbriss",	"Drahga Shadowburner",	
	"Erudax, the Duke of Below", "Ki'katal the Harvester", "Forgemaster Throngus", "Viq'Goth",
	
	
	}
	
	
	local spellname, _, _, _, _, _, _, _, _ = UnitCastingInfo("target")
	if spellname == "Icy Shard" and IsEncounterInProgress("Nalthor the Rimebinder") and Player:HealthPercentage()<70 and level>=highkey then
	  mitigateNWBoss = true
	else
	  mitigateNWBoss = false
	end
	
	
	if (IsEncounterInProgress(Boss) or IsEncounterInProgress("Void Speaker Eirich")) and (spellname == "Lava Fist" or spellname =="Crush" or spellname =="Terrifying Slam" or spellname =="Subjugate" or spellname =="Oozing Smash" or spellname =="Obsidian Beam" or spellname =="Igneous Hammer" or spellname =="Void Corruption" or spellname =="Shadowflame Slash") then
	  MagicTankBuster = true
	else
	  MagicTankBuster = false
	end
	
	if select(1,UnitChannelInfo('target')) == "Molten Flurry" and IsEncounterInProgress("Forgemaster Throngus") then
	  mitigateGBBoss = true
	else
	  mitigateGBBoss = false
	end
	
	if C_UnitAuras.GetPlayerAuraBySpellID(1126,"player") then
		motwremains = C_UnitAuras.GetPlayerAuraBySpellID(1126,"player").expirationTime - GetTime()
	  else
		motwremains = 0
	  end
	
	
	

	
	if Target:Exists() and getCurrentDPS() and getCurrentDPS()>0 then
	targetTTD = UnitHealth('target')/getCurrentDPS()
	else targetTTD = 8888
	end
	
	
	local targetdying = (aoeTTD() < 5 or targetTTD<5)
	

	
	-- if ( Player:BuffRemains(S.ShieldoftheRighteousBuff)<Player:GCD() or (Player:HolyPower()>=5 or Player:BuffRemains(S.ShieldoftheRighteousBuff)<13-Player:GCD()*4 or not Player:BuffUp(S.ShiningLightFreeBuff) and Player:BuffStack(S.ShiningLightBuffStack)==2 and Player:HealthPercentage()<60) and not IsReady(427453,1)) and (targetRange10 or inRange10>=1)  then
	--   useSoTR = true
	-- else
	--   useSoTR = false
	-- end
	
	
	
	
	local useDEF = not AuraUtil.FindAuraByName("Rage of the Sleeper", "player")  and not AuraUtil.FindAuraByName("Bristling Fur", "player") and not AuraUtil.FindAuraByName("Incarnation: Guardian of Ursoc", "player") and not AuraUtil.FindAuraByName("Survival Instincts", "player") and not AuraUtil.FindAuraByName("Barkskin", "player")


	
	
	if S.lustAT:ID() == RubimRH.queuedSpell[1]:ID()
	and Player:DebuffDown(S.lust1) and Player:DebuffDown(S.lust2) and Player:CanAttack(Target) and GetItemCount(219905) >= 1 and 
	Player:DebuffDown(S.lust3) and Player:DebuffDown(S.lust4) and Player:DebuffDown(S.lust5) and (I.drums:IsReady()) then
	return S.lustAT:Cast() -- BIND LUST KEYBIND IN BINDPAD TO ARCANE TORRENT
	end
	
	if S.lustAT:ID() == RubimRH.queuedSpell[1]:ID() and
	(
	Player:DebuffUp(S.lust1) or Player:DebuffUp(S.lust2) or Player:DebuffUp(S.lust3) or Player:DebuffUp(S.lust4) or
	Player:DebuffUp(S.lust5)) then
	RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
	end
	
	if not IsReady(RubimRH.queuedSpell[1]:ID(),nil,nil,1) or inRange30 == 0 or not Target:Exists() then
		RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
		end
		
	if IsReady(RubimRH.queuedSpell[1]:ID(),nil,nil,1) then
	return RubimRH.QueuedSpell():Cast()
	end
	

	
	  if IsReady("Bear Form") and (not AuraUtil.FindAuraByName("Cat Form","player")  and not AuraUtil.FindAuraByName("Travel Form","player") or Player:CanAttack(Target) and not Target:IsDeadOrGhost() and targetRange30) and Player:IsMoving() and not AuraUtil.FindAuraByName("Bear Form","player") then
        return S.BearForm:Cast()
      end
  

    if IsReady("Mark of the Wild") and motwremains <300 and not Player:AffectingCombat()  and Player:IsMoving() then
        return S.MarkoftheWild:Cast()
      end


	












    --   -- Precombat
	if not Player:AffectingCombat() and Player:CanAttack(Target) and not Target:IsDeadOrGhost() and C_Spell.IsCurrentSpell(6603) and targetRange30 then
        local ShouldReturn = Precombat(); if ShouldReturn then return ShouldReturn; end
      end

      if (( Player:AffectingCombat()  or C_Spell.IsCurrentSpell(6603)) and (Player:CanAttack(Target) or RangeCount(8)>=1) and not Target:IsDeadOrGhost())  then 

        if IsReady("Bear Form") and (targetRange30 or RangeCount(8)>=1) and not AuraUtil.FindAuraByName("Bear Form","player") then
          return S.BearForm:Cast()
        end
		
	  if  Player:HealthPercentage() <= 20 and not IsReady("Renewal") and (IsUsableItem(211880) == true and GetItemCooldown(211880) == 0 and GetItemCount(211880) >= 1 or IsUsableItem(211878) == true and GetItemCooldown(211878) == 0 and GetItemCount(211878) >= 1 or IsUsableItem(211879) == true and GetItemCooldown(211879) == 0 and GetItemCount(211879) >= 1) and (not Player:InArena() and not Player:InBattlegrounds()) then
		return I.HPIcon:Cast()
		end


        --hold aggro
        if targetRange30 and tanking == false and not Target:IsAPlayer() and Target:AffectingCombat() and not UnitInRaid("player") then 
            if IsReady("Growl")  then
            return S.Growl:Cast()
            end
            --aoe pull aggro 
			if IsReady("Moonfire")  then
				return S.Moonfire:Cast()
				end

        end



		  if IsReady("Remove Corruption") and (AuraUtil.FindAuraByName("Void Rift", "player", "HARMFUL") or GetAppropriateCureSpell("player")=='Poison' or GetAppropriateCureSpell("player")=='Curse') and RubimRH.InterruptsON() then
			return S.RemoveCorruption:Cast()
			end

		  		--- seasonal affix
			if  TWWS1AffixMobsInRange()>=6 and IsReady("Incapacitating Roar") and RubimRH.InterruptsON() then
				return S.IncapacitatingRoar:Cast()
				end
		  
  
		
          if (castTime > 0.1 or channelTime > 0.1) and select(8, UnitCastingInfo("target")) == false and RubimRH.InterruptsON() then


            -- kick on GCD
            if IsReady("Skull Bash") and kickprio() and targetRange8 and Player:GCDRemains()<0.5 then
            return S.SkullBash:Cast()
            end
    
          end


		  Enemies8y = Player:GetEnemiesInMeleeRange(8)

		
		  if Player:CanAttack(Target) or Player:AffectingCombat() then
			ActiveMitigationNeeded = Player:ActiveMitigationNeeded()
			IsTanking = Player:IsTankingAoE(8) or Player:IsTanking(Target)
		
			UseMaul = false
			if ((Player:Rage() >= S.Maul:Cost() + 20 and not IsTanking) or Player:RageDeficit() <= 10) then
			  UseMaul = true
			end
		
		  end
          
		  if not C_Spell.IsCurrentSpell(6603) and targetRange20 then
			return S.autoattack:Cast()
			end
	
			if (IsTanking and Player:BuffUp(S.BearForm)) and (RangeCount(20)>=1 or targetRange20) then
				local ShouldReturn = Defensives(); if ShouldReturn then return ShouldReturn; end
			  end

		  if Player:AffectingCombat() and inRange20>=1 and useDEF then

			if IsEncounterInProgress(Boss) and (mitigateboss() or mitigateNWBoss or mitigateGBBoss) or mitigatedng() then 

	-- incarnation
	if IsReady("Incarnation: Guardian of Ursoc") then
		return S.Incarnation:Cast()
	end

		if IsReady("Barkskin")   then
			return S.Barkskin:Cast()
		end
		if IsReady("Survival Instincts") then
			return S.SurvivalInstincts:Cast()
		end

		if IsReady("Rage of the Sleeper")  then
			return S.RageoftheSleeper:Cast()
		end

		if IsReady("Bristling Fur")  and (Player:Rage() < 65 ) then
			return S.BristlingFur:Cast()
		end

	end



	if not IsEncounterInProgress(Boss) or level<highkey then

			-- incarnation
	if IsReady("Incarnation: Guardian of Ursoc") then
		return S.Incarnation:Cast()
	end
		if IsReady("Barkskin") and ( (HPpercentloss > 12
		and Player:HealthPercentage() < 65 or Player:HealthPercentage() < 45)  ) then
			return S.Barkskin:Cast()
		end
		if IsReady("Survival Instincts") and (HPpercentloss > 12
		and Player:HealthPercentage() < 65 or Player:HealthPercentage() < 45) then
			return S.SurvivalInstincts:Cast()
		end

		if IsReady("Rage of the Sleeper") and ( (HPpercentloss > 12
		and Player:HealthPercentage() < 65 or Player:HealthPercentage() < 45)  ) then
			return S.RageoftheSleeper:Cast()
		end

		if IsReady("Bristling Fur") and (HPpercentloss > 12
		and Player:HealthPercentage() < 65 or Player:HealthPercentage() < 45) and (Player:Rage() < 65 ) then
			return S.BristlingFur:Cast()
		end
	end


	end



		if Bear() ~= nil and targetRange30 then
			return Bear()
		  end
		



	end

    return 0, "Interface\\Addons\\Rubim-RH\\Media\\griph.tga"
end

RubimRH.Rotation.SetAPL(104, APL)

local function PASSIVE()


end
RubimRH.Rotation.SetPASSIVE(104, PASSIVE)