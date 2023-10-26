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
local mainAddon = RubimRH
local MouseOver = Unit.MouseOver;

-- Spells
RubimRH.Spell[103] = {
    Regrowth = Spell(8936),
    CatForm = Spell(768),
    BearForm = Spell(5487),
    Prowl = Spell(5215),
    ProwlIncarn = Spell(102547),
	IncapacitatingRoar = Spell(99),
	AdaptiveSwarmDebuff = Spell(391889),
	AdaptiveSwarm = Spell(391888),
	AdaptiveSwarmHeal = Spell(391891),
    JungleStalkerBuff = Spell(252071),
    Berserk = Spell(106951),
    TigersFury = Spell(5217),
    Berserking = Spell(26297),
	AshamanesGuidance = Spell(391548),
    FeralFrenzy = Spell(274837),
    Incarnation = Spell(102543),
    Shadowmeld = Spell(58984),
    Rake = Spell(1822),
    TravelForm = Spell(783),
    Hibernate = Spell(2637),
    RakeDebuff = Spell(155722),
    ShadowmeldBuff = Spell(58984),
    FerociousBite = Spell(22568),
	DoubleClawedRake = Spell(391700),
	TearOpenWounds = Spell(391785),
    PredatorySwiftness = Spell(69369),
    ApexPredatorBuff = Spell(391882),
    MomentofClarity = Spell(236068),
    SavageRoar = Spell(52610),
    SavageRoarBuff = Spell(52610),
    Rip = Spell(1079),
    FerociousBiteMaxEnergy = Spell(22568),
    BrutalSlash = Spell(202028),
    Thrash = Spell(106830),
    MoonfireCat = Spell(155625),
    Moonfire = Spell(8921),
    PredatorRevealed = Spell(408468),
    Clearcasting = Spell(135700),
    SwipeCat = Spell(106785),
    OverflowingPower = Spell(405189),
    StampedingRoar = Spell(77764),
    StampedingRoarz = Spell(68992), --darkflight
    Shred = Spell(5221),
    Rebirth = Spell(20484),
    RemoveCorruption = Spell(2782),
    EntanglingRoots = Spell(339),
    CircleofLifeandDeath = Spell(400320),
    LunarInspiration = Spell(155580),
    Sabertooth = Spell(391722),
	RipDebuff = Spell(1079),
	AdaptiveSwarm = Spell(391888),
	SuddenAmbushBuff = Spell(391974),
	AdaptiveSwarmDebuff = Spell(391889),
	--AdaptiveSwarmz = Spell(291944), --Regeneratin
    PoweroftheMoon = Spell(273389),
	RelentlessPredator = Spell(393771),
    PrimalWrath = Spell(285381),
	PrimalWrathTalent = Spell(391785),
	Typhoon = Spell(132469),
	Typhoonz = Spell(20549), --war stomp
	MightyBash = Spell(5211),
	Maim = Spell(22570),
    autoattack = Spell(255654), --bull rush
	Renewal = Spell(108238),	
	SkullBash = Spell(106839),
    IronJawsBuff = Spell(276026),
	WildChargeCat = Spell(102401),
	WildCharge = Spell(49376),
	SurvivalInstincts = Spell(61336),
	Thorns = Spell(467),
	ThrashDebuff = Spell(405233),
	MarkOfTheWild = Spell(1126),
	ThrashingClaws = Spell(405300),
	Soothe = Spell(2908),
	Vortex = Spell(102793),
    Convoke = Spell(391528),
	WildSlashes = Spell(390864),
    Bloodtalons = Spell(319439),
    BloodtalonsBuff = Spell(145152),
    SoulOfTheForest = Spell(158476),
};
local S = RubimRH.Spell[103];

-- Items
if not Item.Druid then
    Item.Druid = {}
end

Item.Druid.Feral = {
    tx1 = Item(118330),
    tx2 = Item(114616),
    HPIcon = Item(169451),
};
local I = Item.Druid.Feral;

S.AdaptiveSwarm:RegisterInFlight()

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

local function target_is_dummy()
    local x = UnitName("target")
    local targetisdummy = false

    if x then
        name = x:sub(-5)
    end

    if Target:Exists() then
        if name == 'Dummy' then
            targetisdummy = true
        end
    else
        targetisdummy = false
    end

    return targetisdummy
end

local function RipRefreshableAOE(pandemic)
local RipRefreshable10 = 0
local MissingRip10 = 0

    for id = 1, 40 do
		local unitID = "nameplate" .. id
		local _,_,_,_,_,expirationTime = AuraUtil.FindAuraByName("Rip",unitID,"PLAYER|HARMFUL")
		
		if AuraUtil.FindAuraByName("Rip",unitID,"PLAYER|HARMFUL") then
			timerRip = expirationTime - HL.GetTime()
		else
			timerRip = nil
		end

		if timerRip and pandemic then 
			if UnitCanAttack("player", unitID) and IsItemInRange(32321, unitID) and UnitName(unitID) ~= "Incorporeal Being" and timerRip <= pandemic then
				RipRefreshable10 = RipRefreshable10 + 1
			end
		end
		
		if UnitCanAttack("player", unitID) and IsItemInRange(32321, unitID) and UnitName(unitID) ~= "Incorporeal Being" and not AuraUtil.FindAuraByName("Rip",unitID,"PLAYER|HARMFUL") then
			MissingRip10 = MissingRip10 + 1
		end
	end

	return RipRefreshable10 + MissingRip10
end

local function ThrashRefreshableAOE(pandemic)
local ThrashRefreshable10 = 0
local MissingThrash10 = 0

    for id = 1, 40 do
		local unitID = "nameplate" .. id
		local _,_,_,_,_,expirationTime = AuraUtil.FindAuraByName("Thrash",unitID,"PLAYER|HARMFUL")
		
		if AuraUtil.FindAuraByName("Thrash",unitID,"PLAYER|HARMFUL") then
			timerThrash = expirationTime - HL.GetTime()
		else
			timerThrash = nil
		end

		if timerThrash and pandemic then 
			if UnitCanAttack("player", unitID) and IsItemInRange(32321, unitID) and UnitName(unitID) ~= "Incorporeal Being" and timerThrash <= pandemic then
				ThrashRefreshable10 = ThrashRefreshable10 + 1
			end
		end
		
		if UnitCanAttack("player", unitID) and IsItemInRange(32321, unitID) and UnitName(unitID) ~= "Incorporeal Being" and not AuraUtil.FindAuraByName("Thrash",unitID,"PLAYER|HARMFUL") then
			MissingThrash10 = MissingThrash10 + 1
		end
	end

	return ThrashRefreshable10 + MissingThrash10
end

local function TargetTTD()
	local currHealth = {}
	local currHealthMax = {}
	local allGUID = {}
	local areaTTD = {}
	local areaTTD_Predicted = {}
	local areaDPS = {}
	local count = 1
	local highest = 0

    for id = 1, 40 do
        local unitID = "nameplate" .. id
        if UnitCanAttack("player", unitID) 
        and ((UnitHealth(unitID) / UnitHealthMax(unitID)) * 100) < 100 then
            if UnitGUID('Target') then
                currTarget = UnitGUID('Target')
            end
			
            table.insert(allGUID, UnitGUID(unitID))
            table.insert(currHealth, UnitHealth(unitID))
            table.insert(currHealthMax, UnitHealthMax(unitID))
			
			if #allGUID >= 1 and UnitGUID('Target') then 
				while(UnitGUID('Target') ~= allGUID[count]) do
					count = count + 1
					break
				end
			end
			
            if #currHealthMax >= 1 then
                for id = 1, #currHealthMax do
				dps = (currHealthMax[#currHealth] - currHealth[#currHealth]) / HL.CombatTime("nameplate" .. #currHealthMax)
					if #currHealthMax ~= count then
						areaTTD[#currHealthMax] = currHealth[#currHealth] / dps
						--areaTTD_Predicted[#currHealthMax] = currHealth[#currHealth] / (dps + playerDPS)
					else
						areaTTD_Predicted[#currHealthMax] = currHealth[#currHealth] / dps
					end
                end
            end
        end
    end
	

	if target_is_dummy() then
		return 8675309
	elseif #currHealthMax >= 1 and areaTTD_Predicted[count] then
		return areaTTD_Predicted[count]
	else
		return 1
	end
end

-- PMultiplier and Damage Registrations
local function ComputeRakePMultiplier()
	--return Player:Buff(S.TigersFury) and 1.6 or 1
	return 1 + (num(IsStealthed() or Player:BuffP(S.SuddenAmbushBuff) or S.SuddenAmbushBuff:TimeSinceLastRemovedOnPlayer() < 0.5) * 0.6) + (num(Player:BuffP(S.TigersFury) or S.TigersFury:TimeSinceLastAppliedOnPlayer() < 0.5                             ) * 0.21                             )
end

S.Rake:RegisterPMultiplier(S.RakeDebuff, ComputeRakePMultiplier)

local function BloodTalonTriggers()
local a = 0
local b = 0
local c = 0
local d = 0
local e = 0
local f = 0
local g = 0

	for id = 1, 40 do
		if S.Shred:TimeSinceLastCast() < 4 and S.BloodtalonsBuff:TimeSinceLastAppliedOnPlayer() > S.Shred:TimeSinceLastCast() then
			a = 1
		end		
		if S.Rake:TimeSinceLastCast() < 4 and S.BloodtalonsBuff:TimeSinceLastAppliedOnPlayer() > S.Rake:TimeSinceLastCast() then
			b = 1
		end		
		if S.BrutalSlash:TimeSinceLastCast() < 4 and S.BloodtalonsBuff:TimeSinceLastAppliedOnPlayer() > S.BrutalSlash:TimeSinceLastCast() then
			c = 1
		end	
		if S.Thrash:TimeSinceLastCast() < 4 and S.BloodtalonsBuff:TimeSinceLastAppliedOnPlayer() > S.Thrash:TimeSinceLastCast() then
			d = 1
		end	
		if S.SwipeCat:TimeSinceLastCast() < 4 and S.BloodtalonsBuff:TimeSinceLastAppliedOnPlayer() > S.SwipeCat:TimeSinceLastCast() then
			e = 1
		end
		if S.MoonfireCat:TimeSinceLastCast() < 4 and S.BloodtalonsBuff:TimeSinceLastAppliedOnPlayer() > S.MoonfireCat:TimeSinceLastCast() then
			f = 1
		end
		if S.FeralFrenzy:TimeSinceLastCast() < 4 and S.BloodtalonsBuff:TimeSinceLastAppliedOnPlayer() > S.FeralFrenzy:TimeSinceLastCast() then
			g = 1
		end
    end

	return a + b + c + d + e + f + g
end

local function ShredBT()
local check = false

	if S.Shred:TimeSinceLastCast() < 4 then
		check = true
	end

	return check
end

local function SwipeBT()
local check = false

	if S.SwipeCat:TimeSinceLastCast() < 4 then
		check = true
	end

	return check
end

local function MoonfireBT()
local check = false

	if S.MoonfireCat:TimeSinceLastCast() < 4 then
		check = true
	end

	return check
end

local function RakeBT()
local check = false

	if S.Rake:TimeSinceLastCast() < 4 then
		check = true
	end

	return check
end

local function BrutalSlashBT()
local check = false

	if S.BrutalSlash:TimeSinceLastCast() < 4 then
		check = true
	end

	return check
end

local function ThrashBT()
local check = false

	if S.Thrash:TimeSinceLastCast() < 4 then
		check = true
	end

	return check
end

local function AOEBuilder()
	--brutal_slash,target_if=min:target.time_to_die,if=cooldown.brutal_slash.full_recharge_time<4|target.time_to_die<5
	if S.BrutalSlash:IsReady() and Cache.EnemiesCount[10] >= 1 and S.BrutalSlash:FullRechargeTimeP() < 4 then
		return S.BrutalSlash:Cast()
	end
	
	--thrash_cat,target_if=refreshable,if=buff.clearcasting.react|(spell_targets.thrash_cat>10|(spell_targets.thrash_cat>5&!talent.double_clawed_rake.enabled))&!talent.thrashing_claws
	if S.Thrash:IsReadyMorph() and Cache.EnemiesCount[10] >= 1 and (ThrashRefreshableAOE((S.CircleofLifeandDeath:IsAvailable() and 3.6 or 4.5)) >= 1 and (Player:BuffP(S.Clearcasting) or Cache.EnemiesCount[10] > 10 or (Cache.EnemiesCount[10] > 5 and not S.DoubleClawedRake:IsAvailable())) and not S.ThrashingClaws:IsAvailable()) then
		return S.Thrash:Cast()
	end
	
	--rake,target_if=buff.sudden_ambush.up&persistent_multiplier>dot.rake.pmultiplier|refreshable
	if S.Rake:IsReady(8) and (Player:BuffP(S.SuddenAmbushBuff) and Player:PMultiplier(S.Rake) > Target:PMultiplier(S.Rake) or Target:DebuffRefreshableP(S.RakeDebuff, S.CircleofLifeandDeath:IsAvailable() and 3.6 or 4.5)) then
		return S.Rake:Cast()
	end

	--thrash_cat,target_if=refreshable
	if S.Thrash:IsReadyMorph() and Cache.EnemiesCount[10] >= 1 and ThrashRefreshableAOE((S.CircleofLifeandDeath:IsAvailable() and 3.6 or 4.5)) >= 1 then
		return S.Thrash:Cast()
	end

	--brutal_slash
	if S.BrutalSlash:IsReady() and Cache.EnemiesCount[10] >= 1 then
		return S.BrutalSlash:Cast()
	end

	--moonfire_cat,target_if=refreshable,if=spell_targets.swipe_cat<5
	if IsUsableSpell("Moonfire") and Target:IsInRange(20) and S.LunarInspiration:IsAvailable() and Target:DebuffRefreshableP(S.MoonfireCat, S.CircleofLifeandDeath:IsAvailable() and 3.8 or 4.8) and Cache.EnemiesCount[10] < 5 then
		return S.Moonfire:Cast()
	end
	
	--swipe_cat
	if S.SwipeCat:IsReadyMorph() and Cache.EnemiesCount[10] >= 1 then
		return S.SwipeCat:Cast()
	end

	--moonfire_cat,target_if=refreshable
	if IsUsableSpell("Moonfire") and Target:IsInRange(20) and S.LunarInspiration:IsAvailable() and Target:DebuffRefreshableP(S.MoonfireCat, S.CircleofLifeandDeath:IsAvailable() and 3.8 or 4.8) then
		return S.Moonfire:Cast()
	end

	--shred,target_if=max:target.time_to_die,if=action.shred.damage>action.thrash_cat.damage&!buff.sudden_ambush.up
	if S.Shred:IsReady(8) and Cache.EnemiesCount[10] < 5 and not Player:BuffP(S.SuddenAmbushBuff) then
		return S.Shred:Cast()
	end

	--thrash_cat
	if S.Thrash:IsReadyMorph() and Cache.EnemiesCount[10] >= 1 then
		return S.Thrash:Cast()
	end

	return nil
end

local function Finish()
	--*changed
	--primal_wrath,if=((dot.primal_wrath.refreshable&!talent.circle_of_life_and_death.enabled)|dot.primal_wrath.remains<6|talent.tear_open_wounds.enabled)&spell_targets.primal_wrath>1&talent.primal_wrath.enabled
	if S.PrimalWrath:IsReady() and RubimRH.AoEON() and ((RipRefreshableAOE((S.CircleofLifeandDeath:IsAvailable() and 2.9 or 3.6)) >= 1) or S.TearOpenWounds:IsAvailable()) and Cache.EnemiesCount[12] > 1 and S.PrimalWrathTalent:IsAvailable() then
		return S.PrimalWrath:Cast()
	end

	--rip,target_if=refreshable
	if S.Rip:IsReady(8) and Target:DebuffRefreshableP(S.RipDebuff, S.CircleofLifeandDeath:IsAvailable() and 5.8 or 7.2) then
		return S.Rip:Cast()
	end
	
	--pool_resource,for_next=1,if=!action.tigers_fury.ready&buff.apex_predators_craving.down
    --ferocious_bite,max_energy=1,target_if=max:target.time_to_die,if=buff.apex_predators_craving.down&(!buff.bs_inc.up|(buff.bs_inc.up&!talent.soul_of_the_forest.enabled))
	if S.FerociousBite:IsReady(8) and (not Player:BuffP(S.ApexPredatorBuff) and (not bs_inc or (bs_inc and not S.SoulOfTheForest:IsAvailable()))) then
		if not Player:BuffP(S.ApexPredatorBuff) then
			if not S.TigersFury:IsReady(8) and Player:Energy() < 50 then
				return 0, "Interface\\Addons\\Rubim-RH\\Media\\mount2.tga" 
			elseif S.TigersFury:IsReady(8) or Player:Energy() >= 50 then
				return S.FerociousBite:Cast()
			end
		end
	end
	
    --ferocious_bite,target_if=max:target.time_to_die,if=(buff.bs_inc.up&talent.soul_of_the_forest.enabled)|buff.apex_predators_craving.up
	if S.FerociousBite:IsReady(8) and ((bs_inc and S.SoulOfTheForest:IsAvailable()) or Player:BuffP(S.ApexPredatorBuff)) then
		return S.FerociousBite:Cast()
	end
end

local function Bloodtalons()
	--brutal_slash,target_if=min:target.time_to_die,if=(cooldown.brutal_slash.full_recharge_time<4|target.time_to_die<5)&(buff.bt_brutal_slash.down&(buff.bs_inc.up|variable.need_bt))
	if S.BrutalSlash:IsReady() and RubimRH.AoEON() and Cache.EnemiesCount[10] >= 1 and (S.BrutalSlash:FullRechargeTimeP() < 4 or TargetTTD() < 5) and (not BrutalSlashBT() and (bs_inc or need_bloodtalons)) then
		return S.BrutalSlash:Cast()
	end	
	
	--prowl,if=action.rake.ready&gcd.remains=0&!buff.sudden_ambush.up&(dot.rake.refreshable|dot.rake.pmultiplier<1.4)&!buff.shadowmeld.up&buff.bt_rake.down&!buff.prowl.up&!buff.apex_predators_craving.up
	if S.ProwlIncarn:IsReadyMorph(8) and Player:BuffP(S.Incarnation) and not prowl_used_in_incarn and (S.Rake:IsReady(8) and Player:GCDRemains() < 0.7 and not Player:BuffP(S.SuddenAmbushBuff) and (Target:DebuffRefreshableP(S.RakeDebuff, S.CircleofLifeandDeath:IsAvailable() and 3.6 or 4.5) or Target:PMultiplier(S.Rake) < 1.4) and not RakeBT() and not IsStealthed() and not Player:BuffP(S.ApexPredatorBuff)) then
		return S.Prowl:Cast()
	end

	--rake,target_if=max:druid.rake.ticks_gained_on_refresh,if=(refreshable|buff.sudden_ambush.up&persistent_multiplier>dot.rake.pmultiplier)&buff.bt_rake.down
	if S.Rake:IsReady(8) and (Target:DebuffRefreshableP(S.RakeDebuff, S.CircleofLifeandDeath:IsAvailable() and 3.6 or 4.5) or Player:BuffP(S.SuddenAmbushBuff) and Player:PMultiplier(S.Rake) > Target:PMultiplier(S.Rake)) and not RakeBT() then
		return S.Rake:Cast()
	end	
	
	--rake,target_if=buff.sudden_ambush.up&persistent_multiplier>dot.rake.pmultiplier&buff.bt_rake.down
	if S.Rake:IsReady(8) and Player:BuffP(S.SuddenAmbushBuff) and Player:PMultiplier(S.Rake) > Target:PMultiplier(S.Rake) and not RakeBT() then
		return S.Rake:Cast()
	end

	--shred,if=buff.bt_shred.down&buff.clearcasting.react&spell_targets.swipe_cat=1
	if S.Shred:IsReady(8) and not ShredBT() and Player:BuffP(S.Clearcasting) and Cache.EnemiesCount[10] == 1 then
		return S.Shred:Cast()
	end
	
	--thrash_cat,target_if=refreshable,if=buff.bt_thrash.down&buff.clearcasting.react&spell_targets.swipe_cat=1&!talent.thrashing_claws.enabled
	if S.Thrash:IsReadyMorph() and RubimRH.AoEON() and Cache.EnemiesCount[10] >= 1 and ThrashRefreshableAOE((S.CircleofLifeandDeath:IsAvailable() and 3.6 or 4.5)) >= 1 and not ThrashBT() and Player:BuffP(S.Clearcasting) and Cache.EnemiesCount[10] == 1 and not S.ThrashingClaws:IsAvailable() then
		return S.Thrash:Cast()
	end

	--brutal_slash,if=buff.bt_brutal_slash.down
	if S.BrutalSlash:IsReady() and RubimRH.AoEON() and Cache.EnemiesCount[10] >= 1 and not BrutalSlashBT() then
		return S.BrutalSlash:Cast()
	end

	--moonfire_cat,if=refreshable&buff.bt_moonfire.down&spell_targets.swipe_cat=1
	if IsUsableSpell("Moonfire") and Target:IsInRange(20) and S.LunarInspiration:IsAvailable() and Target:DebuffRefreshableP(S.MoonfireCat, S.CircleofLifeandDeath:IsAvailable() and 3.8 or 4.8) and not MoonfireBT() and Cache.EnemiesCount[10] == 1 then
		return S.Moonfire:Cast()
	end

	--thrash_cat,target_if=refreshable,if=buff.bt_thrash.down&!talent.thrashing_claws.enabled
	if S.Thrash:IsReadyMorph() and RubimRH.AoEON() and Cache.EnemiesCount[10] >= 1 and ThrashRefreshableAOE((S.CircleofLifeandDeath:IsAvailable() and 3.6 or 4.5)) >= 1 and not ThrashBT() and not S.ThrashingClaws:IsAvailable() then
		return S.Thrash:Cast()
	end

	--shred,if=buff.bt_shred.down&spell_targets.swipe_cat=1&!talent.wild_slashes.enabled
	if S.Shred:IsReady(8) and not ShredBT() and Cache.EnemiesCount[10] == 1 and not S.WildSlashes:IsAvailable() then
		return S.Shred:Cast()
	end

	--swipe_cat,if=buff.bt_swipe.down&talent.wild_slashes.enabled
	if S.SwipeCat:IsReadyMorph() and RubimRH.AoEON() and Cache.EnemiesCount[10] >= 1 and not SwipeBT() and S.WildSlashes:IsAvailable() then
		return S.SwipeCat:Cast()
	end

	--moonfire_cat,target_if=max:ticks_gained_on_refresh,if=buff.bt_moonfire.down&spell_targets.swipe_cat<5
	if IsUsableSpell("Moonfire") and Target:IsInRange(20) and S.LunarInspiration:IsAvailable() and not MoonfireBT() and Cache.EnemiesCount[10] < 5 then
		return S.Moonfire:Cast()
	end

	--swipe_cat,if=buff.bt_swipe.down
	if S.SwipeCat:IsReadyMorph() and RubimRH.AoEON() and Cache.EnemiesCount[10] >= 1 and not SwipeBT() then
		return S.SwipeCat:Cast()
	end

	--moonfire_cat,target_if=max:ticks_gained_on_refresh,if=buff.bt_moonfire.down
	if IsUsableSpell("Moonfire") and Target:IsInRange(20) and S.LunarInspiration:IsAvailable() and not MoonfireBT() then
		return S.Moonfire:Cast()
	end

	--shred,target_if=max:target.time_to_die,if=action.shred.damage>action.thrash_cat.damage&buff.bt_shred.down&!buff.sudden_ambush.up
	if S.Shred:IsReady(8) and Cache.EnemiesCount[10] < 5 and not ShredBT() and not Player:BuffP(S.SuddenAmbushBuff) then
		return S.Shred:Cast()
	end

	--thrash_cat,if=buff.bt_thrash.down
	if S.Thrash:IsReadyMorph() and RubimRH.AoEON() and Cache.EnemiesCount[10] >= 1 and not ThrashBT() then
		return S.Thrash:Cast()
	end

	return nil
end

local function Berserk()
	--ferocious_bite,target_if=max:target.time_to_die,if=combo_points=5&dot.rip.remains>8&variable.zerk_biteweave&spell_targets.swipe_cat>1
	-- if S.FerociousBite:IsReady(8) and Player:ComboPoints() == 5 and Target:DebuffRemainsP(S.RipDebuff) > 8 and Cache.EnemiesCount[10] > 1 then
		-- return S.FerociousBite:Cast()
	-- end
	
	--call_action_list,name=finisher,if=combo_points=5&!(buff.overflowing_power.stack<=1&active_bt_triggers=2&buff.bloodtalons.stack<=1)
	if Finish() and Player:ComboPoints() == 5 and not (Player:BuffStackP(S.OverflowingPower) <= 1 and BloodTalonTriggers() == 2 and Player:BuffStackP(S.BloodtalonsBuff) <= 1) then
		return Finish()
	end
	
	--call_action_list,name=bloodtalons,if=spell_targets.swipe_cat>1
	if Bloodtalons() and Cache.EnemiesCount[10] > 1 then
		return Bloodtalons()
	end
	
	--prowl,if=!(buff.bt_rake.up&active_bt_triggers=2)&(action.rake.ready&gcd.remains=0&!buff.sudden_ambush.up&(dot.rake.refreshable|dot.rake.pmultiplier<1.4)&!buff.shadowmeld.up&cooldown.feral_frenzy.remains<44&!buff.apex_predators_craving.up)
	if S.ProwlIncarn:IsReadyMorph(8) and not (RakeBT() and BloodTalonTriggers() == 2) and (S.Rake:IsReady(8) and Player:GCDRemains() < 0.7 and not Player:BuffP(S.SuddenAmbushBuff) and (Target:DebuffRefreshableP(S.RakeDebuff, S.CircleofLifeandDeath:IsAvailable() and 3.6 or 4.5) or Target:PMultiplier(S.Rake) < 1.4) and S.FeralFrenzy:CooldownRemainsP() < 44 and not Player:BuffP(S.ApexPredatorBuff)) then
		return S.Prowl:Cast()
	end	
	
	--rake,if=!(buff.bt_rake.up&active_bt_triggers=2)&(refreshable|(buff.sudden_ambush.up&persistent_multiplier>dot.rake.pmultiplier&!dot.rake.refreshable))
	if S.Rake:IsReady(8) and not (RakeBT() and BloodTalonTriggers() == 2) and (Target:DebuffRefreshableP(S.RakeDebuff, S.CircleofLifeandDeath:IsAvailable() and 3.6 or 4.5) or (Player:BuffP(S.SuddenAmbushBuff) and Player:PMultiplier(S.Rake) > Target:PMultiplier(S.Rake) and not Target:DebuffRefreshableP(S.RakeDebuff, S.CircleofLifeandDeath:IsAvailable() and 3.6 or 4.5))) then
		return S.Rake:Cast()
	end

	--shred,if=active_bt_triggers=2&buff.bt_shred.down
	if S.Shred:IsReady(8) and BloodTalonTriggers() == 2 and not ShredBT() then
		return S.Shred:Cast()
	end

	--brutal_slash,if=active_bt_triggers=2&buff.bt_brutal_slash.down
	if S.BrutalSlash:IsReady() and RubimRH.AoEON() and Cache.EnemiesCount[10] >= 1 and BloodTalonTriggers() == 2 and not BrutalSlashBT() then
		return S.BrutalSlash:Cast()
	end

	--moonfire_cat,if=active_bt_triggers=2&buff.bt_moonfire.down
	if IsUsableSpell("Moonfire") and Target:IsInRange(20) and S.LunarInspiration:IsAvailable() and BloodTalonTriggers() == 2 and not MoonfireBT() then
		return S.Moonfire:Cast()
	end
	
	--thrash_cat,if=active_bt_triggers=2&buff.bt_thrash.down&!talent.thrashing_claws&variable.need_bt&(refreshable|talent.brutal_slash.enabled)
	if S.Thrash:IsReadyMorph() and RubimRH.AoEON() and Cache.EnemiesCount[10] >= 1 and BloodTalonTriggers() == 2 and not ThrashBT() and not S.ThrashingClaws:IsAvailable() and need_bloodtalons and (ThrashRefreshableAOE((S.CircleofLifeandDeath:IsAvailable() and 3.6 or 4.5)) >= 1 or S.BrutalSlash:IsAvailable()) then
		return S.Thrash:Cast()
	end
	
	--moonfire_cat,if=refreshable
	if IsUsableSpell("Moonfire") and Target:IsInRange(20) and S.LunarInspiration:IsAvailable() and Target:DebuffRefreshableP(S.MoonfireCat, S.CircleofLifeandDeath:IsAvailable() and 3.8 or 4.8) then
		return S.Moonfire:Cast()
	end

	--brutal_slash,if=cooldown.brutal_slash.charges>1
	if S.BrutalSlash:IsReady() and RubimRH.AoEON() and Cache.EnemiesCount[10] >= 1 and S.BrutalSlash:ChargesP() > 1 then
		return S.BrutalSlash:Cast()
	end

	--shred
	if S.Shred:IsReady(8) then
		return S.Shred:Cast()
	end

	return nil
end

local function Clearcasting()
	--thrash_cat,if=refreshable&!talent.thrashing_claws.enabled
	if S.Thrash:IsReadyMorph() and RubimRH.AoEON() and Cache.EnemiesCount[10] >= 1 and ThrashRefreshableAOE((S.CircleofLifeandDeath:IsAvailable() and 3.6 or 4.5)) >= 1 and not S.ThrashingClaws:IsAvailable() then
		return S.Thrash:Cast()
	end

	--swipe_cat,if=spell_targets.swipe_cat>1
	if S.SwipeCat:IsReadyMorph() and RubimRH.AoEON() and Cache.EnemiesCount[10] > 1 then
		return S.SwipeCat:Cast()
	end

	--brutal_slash,if=spell_targets.brutal_slash>2
	if S.BrutalSlash:IsReady() and RubimRH.AoEON() and Cache.EnemiesCount[10] > 2 then
		return S.BrutalSlash:Cast()
	end

	--shred
	if S.Shred:IsReady(8) then
		return S.Shred:Cast()
	end
	
	return nil
end

local function Builder()
	--run_action_list,name=clearcasting,if=buff.clearcasting.react
	if Clearcasting() and Player:BuffP(S.Clearcasting) then
		return Clearcasting()
	end

	--brutal_slash,if=cooldown.brutal_slash.full_recharge_time<4
	if S.BrutalSlash:IsReady() and RubimRH.AoEON() and Cache.EnemiesCount[10] >= 1 and S.BrutalSlash:FullRechargeTimeP() < 4 then
		return S.BrutalSlash:Cast()
	end
	
	--pool_resource,if=!action.rake.ready&(dot.rake.refreshable|(buff.sudden_ambush.up&persistent_multiplier>dot.rake.pmultiplier&dot.rake.remains>6))&!buff.clearcasting.react
	if not S.Rake:IsReady(8) and (Target:DebuffRefreshableP(S.RakeDebuff, S.CircleofLifeandDeath:IsAvailable() and 3.6 or 4.5) or (Player:BuffP(S.SuddenAmbushBuff) and Player:PMultiplier(S.Rake) > Target:PMultiplier(S.Rake) and (Target:DebuffRemainsP(S.RakeDebuff) > (S.CircleofLifeandDeath:IsAvailable() and 3.6 or 4.5)))) and not Player:BuffP(S.Clearcasting) then
		return 0, "Interface\\Addons\\Rubim-RH\\Media\\mount2.tga"
	end

	--rake,if=refreshable|(buff.sudden_ambush.up&persistent_multiplier>dot.rake.pmultiplier&dot.rake.remains>6)
	if S.Rake:IsReady(8) and (Target:DebuffRefreshableP(S.RakeDebuff, S.CircleofLifeandDeath:IsAvailable() and 3.6 or 4.5) or (Player:BuffP(S.SuddenAmbushBuff) and Player:PMultiplier(S.Rake) > Target:PMultiplier(S.Rake) and (Target:DebuffRemainsP(S.RakeDebuff) > (S.CircleofLifeandDeath:IsAvailable() and 3.6 or 4.5)))) then
		return S.Rake:Cast()
	end

	--run_action_list,name=clearcasting,if=buff.clearcasting.react
	if Clearcasting() and Player:BuffP(S.Clearcasting) then
		return Clearcasting()
	end

	--moonfire_cat,target_if=refreshable
	if IsUsableSpell("Moonfire") and Target:IsInRange(20) and S.LunarInspiration:IsAvailable() and Target:DebuffRefreshableP(S.MoonfireCat, S.CircleofLifeandDeath:IsAvailable() and 3.8 or 4.8) then
		return S.Moonfire:Cast()
	end

	--thrash_cat,target_if=refreshable&!talent.thrashing_claws.enabled
	if S.Thrash:IsReadyMorph() and RubimRH.AoEON() and Cache.EnemiesCount[10] >= 1 and ThrashRefreshableAOE((S.CircleofLifeandDeath:IsAvailable() and 3.6 or 4.5)) >= 1 and not S.ThrashingClaws:IsAvailable() then
		return S.Thrash:Cast()
	end

	--brutal_slash
	if S.BrutalSlash:IsReady() and RubimRH.AoEON() and Cache.EnemiesCount[10] >= 1 then
		return S.BrutalSlash:Cast()
	end

	--swipe_cat,if=spell_targets.swipe_cat>1|talent.wild_slashes.enabled
	if S.SwipeCat:IsReadyMorph() and RubimRH.AoEON() and Cache.EnemiesCount[10] >= 1 and (Cache.EnemiesCount[10] > 1 or S.WildSlashes:IsAvailable()) then
		return S.SwipeCat:Cast()
	end

	--shred
	if S.Shred:IsReady(8) then
		return S.Shred:Cast()
	end

	return nil
end

local function Cooldowns()
	-- local trinket1 = GetInventoryItemID("player", 13)
	-- local trinket2 = GetInventoryItemID("player", 14)
	-- local trinket1ready = IsUsableItem(trinket1) and GetItemCooldown(trinket1) == 0 and IsEquippedItem(trinket1)
	-- local trinket2ready = IsUsableItem(trinket2) and GetItemCooldown(trinket2) == 0 and IsEquippedItem(trinket2)
	
	--trinket 1
	-- if trinket1ready and Cache.EnemiesCount[8] >= 1 and Player:BuffP(S.Incarnation) then
		-- return I.tx1:Cast()
	-- end
	
	--trinket 2
	-- if trinket2ready then
		-- return I.tx2:Cast()
	-- end

	--incarnation
	if S.Incarnation:IsReady(10) and RubimRH.CDsON() then
		return S.Incarnation:Cast()
	end

	--berserk,if=(!variable.lastZerk)|(fight_remains<23)|(variable.lastZerk&!variable.lastConvoke)
	if S.Berserk:IsReady(10) and RubimRH.CDsON() and ((not last_convoke or TargetTTD() < 23 or (last_berserk and not last_convoke)) or not S.Convoke:IsAvailable()) then
		return S.Berserk:Cast()
	end

	--berserk,if=(variable.lastConvoke&cooldown.convoke_the_spirits.remains<10)
	if S.Berserk:IsReady(10) and RubimRH.CDsON() and ((last_convoke and S.Convoke:CooldownRemainsP() < 10) or not S.Convoke:IsAvailable()) then
		return S.Berserk:Cast()
	end

	--berserking,if=!variable.align_3minutes|buff.bs_inc.up
	if S.Berserking:IsReady(10) and RubimRH.CDsON() and (Player:BuffRemainsP(S.Incarnation) >= 12 or Player:BuffRemainsP(S.Berserk) >= 12) then
		return S.Berserking:Cast()
	end

	--convoke_the_spirits,if=fight_remains<5|(dot.rip.remains>5&buff.tigers_fury.up&(combo_points<2|(buff.bs_inc.up&combo_points=2))&(!variable.lastConvoke|!variable.lastZerk|buff.bs_inc.up))
	if S.Convoke:IsReady(10) and RubimRH.CDsON() and (TargetTTD() < 5 or (Target:DebuffRemainsP(S.RipDebuff) > 5 and Player:BuffP(S.TigersFury) and (Player:ComboPoints() < 2 or (bs_inc and Player:ComboPoints() == 2)) and (not last_convoke or not last_berserk or bs_inc))) then
		return S.Convoke:Cast()
	end
	
	return nil
end

local function APL()
HL.GetEnemies(5);
HL.GetEnemies(8);
HL.GetEnemies(10);
HL.GetEnemies(12);
HL.GetEnemies(20);
HL.GetEnemies(25);
HL.GetEnemies(30);
--print('Player: ', Player:PMultiplier(S.Rake), ' Target: ', Target:PMultiplier(S.Rake), ' BTTriggers: ', BloodTalonTriggers())
--------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------Functions/Top priorities----------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
if Player:IsCasting() or Player:IsChanneling() then
	return 0, "Interface\\Addons\\Rubim-RH\\Media\\channel.tga"
elseif Player:IsDeadOrGhost() or AuraUtil.FindAuraByName("Drink", "player") or AuraUtil.FindAuraByName("Food", "player") 
or AuraUtil.FindAuraByName("Food & Drink", "player") or (Player:Buff(S.Prowl) and not Player:BuffP(S.Incarnation) and AuraUtil.FindAuraByName("Mark of the Wild", "player") and not S.Rake:ID() == RubimRH.queuedSpell[1]:ID()) or Player:Buff(S.TravelForm) then
	return 0, "Interface\\Addons\\Rubim-RH\\Media\\mount2.tga"
end 

-- if Player:AffectingCombat() and not Player:Buff(S.CatForm) and not Player:Buff(S.Dash) and not Player:Buff(S.Prowl) then 
-- 	return S.CatForm:Cast()
-- end

if true then
	last_convoke = TargetTTD() < (60 + (num(S.AshamanesGuidance:IsAvailable()) * 60))

	last_berserk = TargetTTD() < 180

	evaluate_cycle_adaptive_swarm = (((not Target:DebuffP(S.AdaptiveSwarmDebuff) or Target:DebuffRemainsP(S.AdaptiveSwarmDebuff) < 2) and (Target:DebuffStackP(S.AdaptiveSwarmDebuff) < 3 or Player:BuffStackP(S.AdaptiveSwarmHeal) <= 1) and (not S.AdaptiveSwarm:InFlight())) and TargetTTD() > 5 or Cache.EnemiesCount[10] > 2 and not Target:DebuffP(S.AdaptiveSwarmDebuff) and Player:Energy() < 35 and TargetTTD() > 5)

	elite = UnitClassification("target") == "worldboss" or UnitClassification("target") == "rareelite" or UnitClassification("target") == "elite" or UnitClassification("target") == "rare" or target_is_dummy() or Target:IsAPlayer()
	
	prowl_used_in_incarn = Player:BuffP(S.Incarnation) and S.Prowl:TimeSinceLastCast() < S.Incarnation:TimeSinceLastCast()
	
	need_bloodtalons = (S.Bloodtalons:IsAvailable() and Player:BuffStackP(S.BloodtalonsBuff) < 2)
	
	bs_inc = Player:BuffP(S.Berserk) or Player:BuffP(S.Incarnation)
	
	trinket1 = GetInventoryItemID("player", 13)
	
	trinket2 = GetInventoryItemID("player", 14)
	
	isEnraged = AuraUtil.FindAuraByName("Enrage", "target") or UnitChannelInfo("target") == "Ragestorm" or AuraUtil.FindAuraByName("Frenzy", "target")
	
	trinket1ready = IsUsableItem(trinket1) and GetItemCooldown(trinket1) == 0 and IsEquippedItem(trinket1)
	
	trinket2ready = IsUsableItem(trinket2) and GetItemCooldown(trinket2) == 0 and IsEquippedItem(trinket2)

	channeling = select(1,UnitChannelInfo('target'))
	
	casting = select(1, UnitCastingInfo('target'))

	name, realm = UnitName('target')

	name1, text, texture, startTimeMS, endTimeMS, isTradeSkill, castID, notInterruptible, spellId = UnitCastingInfo("target")
	
	start_time_cast_ms = select(4, UnitCastingInfo('target')) or 0
	
	end_time_cast_ms = select(5, UnitCastingInfo('target')) or 0
	
	current_time_ms = GetTime() * 1000
	
	elapsed_time_cast_ca = (start_time_cast_ms > 0) and (current_time_ms - start_time_cast_ms) or 0
	
	cast_time = elapsed_time_cast_ca / 1000
	
	cast_time_remaining = ((end_time_cast_ms - start_time_cast_ms) / 1000) - cast_time > 0 and ((end_time_cast_ms - start_time_cast_ms) / 1000) - cast_time or 9999
	
	start_time_channel_ms = select(4, UnitChannelInfo('target')) or 0
	
	end_time_channel_ms = select(5, UnitChannelInfo('target')) or 0
	
	elapsed_time_channel_ch = (start_time_channel_ms > 0) and (current_time_ms - start_time_channel_ms) or 0
	
	channel_time = elapsed_time_channel_ch / 1000
	
	channel_time_remaining = ((end_time_channel_ms - start_time_channel_ms) / 1000) - channel_time > 0 and ((end_time_channel_ms - start_time_channel_ms) / 1000) - channel_time or 9999
end
--------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------Out of Combat---------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
if not Player:AffectingCombat() then
	-- if S.MarkOfTheWild:IsCastable() and (not AuraUtil.FindAuraByName("Mark of the Wild", "player")
	-- or (AuraUtil.FindAuraByName("Mark of the Wild", "player") and Player:BuffRemains(S.MarkOfTheWild) < 300)) then
		-- return S.MarkOfTheWild:Cast()
    -- end
	
	if S.Prowl:IsCastable() and S.Prowl:TimeSinceLastCast() > 4 and S.Prowl:CooldownRemains() < Player:GCD() and not Player:Buff(S.Prowl) and Player:Buff(S.CatForm) then
		return S.Prowl:Cast()
    end
end
--------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------Spell Queue-----------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
if S.CatForm:IsCastable() and Player:PrevGCD(1, S.IncapacitatingRoar) and S.IncapacitatingRoar:TimeSinceLastCast() < Player:GCD() * 2 then
	return S.CatForm:Cast()
end

if S.Rake:ID() == RubimRH.queuedSpell[1]:ID() then
	if not S.Rake:CooldownUp() or not Target:IsInRange(10) or not Player:CanAttack(Target) or not Player:BuffP(S.Prowl) then
		RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
	end
end

if S.Rake:ID() == RubimRH.queuedSpell[1]:ID() then
	if S.Rake:CooldownUp() and (Player:BuffP(S.TigersFury) or not S.TigersFury:CooldownUp() or not elite) then
		return S.Rake:Cast()
	end	
	
	if S.TigersFury:CooldownUp() and not Player:BuffP(S.TigersFury) and elite then
		return S.TigersFury:Cast()
	end
end

if not RubimRH.queuedSpell[1]:CooldownUp() or not Player:AffectingCombat() 
or (S.CatForm:ID() == RubimRH.queuedSpell[1]:ID() and Player:BuffP(S.CatForm))
or (S.BearForm:ID() == RubimRH.queuedSpell[1]:ID() and Player:BuffP(S.BearForm))
or (S.EntanglingRoots:ID() == RubimRH.queuedSpell[1]:ID() and Player:PrevGCD(1, S.EntanglingRoots))
or (S.RemoveCorruption:ID() == RubimRH.queuedSpell[1]:ID() and Player:PrevGCD(1, S.RemoveCorruption))
or (S.Regrowth:ID() == RubimRH.queuedSpell[1]:ID() and (Player:PrevGCD(1, S.Regrowth) or (Player:IsMoving() and not Player:BuffP(S.PredatorySwiftness))))
or (S.Hibernate:ID() == RubimRH.queuedSpell[1]:ID() and (Player:PrevGCD(1, S.Hibernate) or IsKeyDown('RightButton')))
or (S.Rebirth:ID() == RubimRH.queuedSpell[1]:ID() and (Player:PrevGCD(1, S.Rebirth) or IsKeyDown('RightButton'))) then
	RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
end

if S.Typhoon:ID() == RubimRH.queuedSpell[1]:ID() then
	return S.Typhoonz:Cast()
end

if S.StampedingRoar:ID() == RubimRH.queuedSpell[1]:ID() then
	return S.StampedingRoarz:Cast()
end

if RubimRH.QueuedSpell():IsReadyQueue() then
    return RubimRH.QueuedSpell():Cast()
end
--------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------Interrupts & Tranq-----------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
if RubimRH.InterruptsON() and not IsStealthed() then 
	if S.Hibernate:IsReady(20) and notInterruptible == false and cast_time > 0 and name == "Incorporeal Being" then
		return S.Hibernate:Cast()
	end
	
	if S.SkullBash:IsReady(5) and notInterruptible == false and (cast_time > Player:GCDRemains() + 0.47 or channel_time > Player:GCDRemains() + 0.47) then
		return S.SkullBash:Cast()
	end

	-- if S.Soothe:IsReady(40) and (isEnraged and RubimRH.InterruptsON() and Player:AffectingCombat() and TargetTTD() > 4) then
		-- return S.Soothe:Cast()
	-- end
end
--------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------Cooldowns-------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
if S.Regrowth:IsCastable() and Player:BuffP(S.PredatorySwiftness) and not (need_bloodtalons and BloodTalonTriggers() == 2)
and ((Player:HealthPercentage() <= 85 and Cache.EnemiesCount[25] == 0) or (Player:HealthPercentage() < 40 and Player:EnergyTimeToMaxPredicted() > Player:GCD())) then
	return S.Regrowth:Cast()
end

if S.Renewal:IsCastable() and Player:AffectingCombat() and Player:HealthPercentage() < 35 then
	return S.Renewal:Cast()
end

if Player:HealthPercentage() < 30 and Player:AffectingCombat() and (IsUsableItem(191379) or IsUsableItem(191378) or IsUsableItem(191380)) and (GetItemCooldown(191380) == 0 or GetItemCooldown(191379) == 0 or GetItemCooldown(191378) == 0) and (GetItemCount(191380) >= 1 or GetItemCount(191379) >= 1 or GetItemCount(191378) >= 1) and (not Player:InArena() and not Player:InBattlegrounds()) then
	return I.HPIcon:Cast()
end
--------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------Rotation--------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
if S.CatForm:IsCastable() and Player:CanAttack(Target) and not Player:BuffP(S.BearForm) and not Player:BuffP(S.CatForm) and S.Regrowth:TimeSinceLastCast() > Player:GCD() then
	return S.CatForm:Cast()
end

if trinket2ready and Player:CanAttack(Target) and Target:IsInRange(10) and Player:BuffP(S.CatForm) and Player:AffectingCombat() and not IsStealthed()
and ((TargetTTD() > 10 or (UnitClassification("target") == "worldboss" and TargetTTD() > 6)) or Cache.EnemiesCount[10] > 1) and name ~= "Spiteful Shade" then
	return I.tx2:Cast()
end

if Player:CanAttack(Target) and Player:BuffP(S.CatForm) and ((Player:AffectingCombat() and not IsStealthed()) or Player:BuffP(S.Incarnation)) then
	--tigers_fury,if=!talent.convoke_the_spirits.enabled&(!buff.tigers_fury.up|energy.deficit>65)
	if S.TigersFury:IsReady(10) and not S.Convoke:IsAvailable() and (not Player:BuffP(S.TigersFury) or Player:EnergyDeficit() > 65) then
		return S.TigersFury:Cast()
	end

	--tigers_fury,if=talent.convoke_the_spirits.enabled&(!variable.lastConvoke|(variable.lastConvoke&!buff.tigers_fury.up))
	if S.TigersFury:IsReady(10) and S.Convoke:IsAvailable() and (not last_convoke or (last_convoke and not Player:BuffP(S.TigersFury))) then
		return S.TigersFury:Cast()
	end

	--rake,target_if=1.4*persistent_multiplier>dot.rake.pmultiplier,if=buff.prowl.up|buff.shadowmeld.up
	if S.Rake:IsReady(8) and Player:BuffP(S.ProwlIncarn) and (Target:AffectingCombat() or target_is_dummy()) and 1.4 * Player:PMultiplier(S.Rake) > Target:PMultiplier(S.Rake) then
		return S.Rake:Cast()
	end

	if not IsCurrentSpell(6603) and not IsStealthed() and Target:IsInRange(8) and Player:CanAttack(Target) then
		return S.autoattack:Cast()
	end
	
    if S.AdaptiveSwarm:IsReady(20) and evaluate_cycle_adaptive_swarm and not (need_bloodtalons and BloodTalonTriggers() == 2) then
		return S.AdaptiveSwarm:Cast()    
	end
	
	if Cooldowns() and RubimRH.CDsON() then
		return Cooldowns()
	end
	
	--feral_frenzy,target_if=max:target.time_to_die,if=combo_points<2|combo_points<3&buff.bs_inc.up
	if S.FeralFrenzy:IsReady(8) and name ~= "Spiteful Shade" and elite and TargetTTD() > 6 and (Player:ComboPoints() < 2 or Player:ComboPoints() < 3 and bs_inc) then
		return S.FeralFrenzy:Cast()
	end

	--ferocious_bite,target_if=max:target.time_to_die,if=buff.apex_predators_craving.up&(spell_targets.swipe_cat=1|!talent.primal_wrath.enabled|!buff.sabertooth.up)&!(variable.need_bt&active_bt_triggers=2)
	if S.FerociousBite:IsReady(8) and Player:BuffP(S.ApexPredatorBuff) and (Cache.EnemiesCount[10] == 1 or not S.PrimalWrathTalent:IsAvailable() or not Player:BuffP(S.Sabertooth)) and not (need_bloodtalons and BloodTalonTriggers() == 2) then
		return S.FerociousBite:Cast()
	end

	if Berserk() and bs_inc then
		return Berserk()
	end

	-- if Finish() and Player:ComboPoints() >= 4 and Cache.EnemiesCount[10] > 1 then
		-- return Finish()
	-- end

	--tier set
	--wait,sec=combo_points=5,if=combo_points=4&buff.predator_revealed.react&energy.deficit>40
	if Player:ComboPoints() == 4 and Player:BuffP(S.PredatorRevealed) and Player:EnergyDeficit() > 40 and Cache.EnemiesCount[10] == 1 then 
		return 0, "Interface\\Addons\\Rubim-RH\\Media\\mount2.tga"
	end

	--call_action_list,name=finisher,if=combo_points>=4&!(combo_points=4&buff.bloodtalons.stack<=1&active_bt_triggers=2&spell_targets.swipe_cat=1)
	if Finish() and Player:ComboPoints() >= 4 and not (Player:ComboPoints() == 4 and Player:BuffStackP(S.BloodtalonsBuff) <= 1 and BloodTalonTriggers() == 2 and Cache.EnemiesCount[10] == 1) then
		return Finish()
	end

	if Bloodtalons() and need_bloodtalons and not bs_inc and Player:ComboPoints() < 5 then
		return Bloodtalons()
	end

	if AOEBuilder() and RubimRH.AoEON() and Cache.EnemiesCount[10] > 1 and S.PrimalWrathTalent:IsAvailable() then
		return AOEBuilder()
	end

	if Builder() and Player:ComboPoints() < 5 and not bs_inc then
		return Builder()
	end
end
    return 0, "Interface\\Addons\\Rubim-RH\\Media\\mount2.tga"
end

RubimRH.Rotation.SetAPL(103, APL)

local function PASSIVE()
    return RubimRH.Shared()
end
RubimRH.Rotation.SetPASSIVE(103, PASSIVE)