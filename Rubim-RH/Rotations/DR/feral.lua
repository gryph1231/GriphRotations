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
	AdaptiveSwarm = Spell(391888),
	SuddenAmbushBuff = Spell(391974),
	AdaptiveSwarmDebuff = Spell(391889),
	--AdaptiveSwarmz = Spell(291944), --Regeneratin
    PoweroftheMoon = Spell(273389),
	RelentlessPredator = Spell(393771),
    PrimalWrath = Spell(285381),
	TearOpenWounds = Spell(391785),
	Typhoon = Spell(132469),
	Typhoonz = Spell(20549), --war stomp
	MightyBash = Spell(5211),
	Maim = Spell(22570),
	SmolderingFrenzy = Spell(422751),
	Predator = Spell(202021),
	RampantFerocity = Spell(391709),
	RavageAbilityBear = Spell(441605),
	RavageAbilityCat = Spell(441591),
	BerserkHeartoftheLion = Spell(391174),
	FountofStrength = Spell(441675),
	Ravage = Spell(441583),
	WildpowerSurge = Spell(441691),
	FelinePotentialBuff = Spell(441701),
	RavageBuffFeral = Spell(441585),
	RavageBuffGuardian = Spell(441602),
	Renewal = Spell(108238),
	BloodseekerVinesDebuff = Spell(439531),
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
    Potion = Spell(176108),
    autoattack = Spell(287712), --haymaker
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

local function tier31equipped()
    local items = {
        -- "Benevolent Embersage's Casque",
        -- "Benevolent Embersage's Wisdom",
        -- "Benevolent Embersage's Robe",
        -- "Benevolent Embersage's Talons",
        -- "Benevolent Embersage's Leggings",
		
		"Bough of the Autumn Blaze",
		"Mantle of the Autumn Blaze",
		"Handguards of the Autumn Blaze",
		"Pants of the Autumn Blaze",
		"Chestroots of the Autumn Blaze",
    }

    local count = 0

    for _, itemName in ipairs(items) do
        if IsEquippedItem(itemName) then
            count = count + 1
        end
    end

    return count
end

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
        name2 = x:sub(-5)
    end

    if Target:Exists() then
        if name2 == 'Dummy' then
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
			timerRip = expirationTime - GetTime()
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
			timerThrash = expirationTime - GetTime()
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

-- PMultiplier and Damage Registrations
local function ComputeRakePMultiplier()
	--return Player:BuffUp(S.TigersFury) and 1.6 or 1
	return 1 + (num(IsStealthed() or Player:BuffUp(S.SuddenAmbushBuff) or S.SuddenAmbushBuff:TimeSinceLastRemovedOnPlayer() < 0.5) * 0.6) + (num(Player:BuffUp(S.TigersFury) or S.TigersFury:TimeSinceLastAppliedOnPlayer() < 0.5                             ) * 0.21                             )
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

-- local function MissingMOTW()
-- 	local missing = 0

-- 	-- if AuraUtil.FindAuraByName("Mark of the Wild","player") then
-- 	-- 	motwremains = select(6,AuraUtil.FindAuraByName("Mark of the Wild","player")) - GetTime()
-- 	-- else
-- 	-- 	motwremains = 0
-- 	-- end

-- 	for i = 1,40 do
-- 		local party_unitID = "party" .. i
-- 		local raid_unitID = "raid" .. i

-- 		if UnitInParty("player") then
-- 			if IsSpellInRange("Mark of the Wild",party_unitIDID) and (select(1,AuraUtil.FindAuraByName("Mark of the Wild", "party_unitID")) ~= "Mark of the Wild" or (select(1,AuraUtil.FindAuraByName("Mark of the Wild", "party_unitID")) == "Mark of the Wild" 
-- 			and select(6,AuraUtil.FindAuraByName("Mark of the Wild","party_unitID")) and (select(6,AuraUtil.FindAuraByName("Mark of the Wild","party_unitID")) - GetTime()) < 300)) then
-- 				missing = missing + 1
-- 			end
-- 		elseif UnitInRaid("player") then
-- 			if IsSpellInRange("Mark of the Wild",raid_unitID) and (select(1,AuraUtil.FindAuraByName("Mark of the Wild", "raid_unitID")) ~= "Mark of the Wild" or (select(1,AuraUtil.FindAuraByName("Mark of the Wild", "raid_unitID")) == "Mark of the Wild" 
-- 			and select(6,AuraUtil.FindAuraByName("Mark of the Wild","raid_unitID")) and (select(6,AuraUtil.FindAuraByName("Mark of the Wild","raid_unitID")) - GetTime()) < 300)) then
-- 				missing = missing + 1
-- 			end
-- 		end
-- 	end

-- 	return missing
-- end

local function AOEBuilder()
	--thrash_cat,if=refreshable&!talent.thrashing_claws&!(variable.need_bt&buff.bt_thrash.up)
	if IsReady('Thrash') and ThrashRefreshableAOE((S.CircleofLifeandDeath:IsAvailable() and 3.6 or 4.5)) >= 1 and not S.ThrashingClaws:IsAvailable() and not (need_bloodtalons and ThrashBT()) then
		return S.Thrash:Cast()
	end

	--brutal_slash,target_if=min:time_to_die,if=(cooldown.brutal_slash.full_recharge_time<4|time_to_die<4|raid_event.adds.remains<4|(buff.bs_inc.up&spell_targets>=3-hero_tree.druid_of_the_claw))&!(variable.need_bt&buff.bt_swipe.up&(buff.bs_inc.down|spell_targets<3-hero_tree.druid_of_the_claw))
	if IsReady('Brutal Slash') and (S.BrutalSlash:FullRechargeTime() < 4 or (bs_inc and RangeCount(8) >= 3 - num(Player:HeroTreeID() == 21))) and not (need_bloodtalons and BrutalSlashBT() and (not bs_inc or RangeCount(8) < 3 - num(Player:HeroTreeID() == 21))) then
		return S.BrutalSlash:Cast()
	end

	--swipe_cat,if=time_to_die<4|(talent.wild_slashes&spell_targets.swipe_cat>4&!(variable.need_bt&buff.bt_swipe.up))
	if IsReady('Swipe') and not S.BrutalSlash:IsAvailable() and RangeCount(8) > 4 and S.WildSlashes:IsAvailable() and not (need_bloodtalons and SwipeBT()) then
		return S.SwipeCat:Cast()
	end

	--prowl,target_if=dot.rake.refreshable|dot.rake.pmultiplier<1.4,if=!(variable.need_bt&buff.bt_rake.up)  &action.rake.ready&gcd.remains=0&!buff.sudden_ambush.up&!variable.cc_capped
	if IsReady('Prowl') and TargetinRange(5) and (Target:DebuffRefreshable(S.RakeDebuff, S.CircleofLifeandDeath:IsAvailable() and 3.6 or 4.5) or Target:PMultiplier(S.Rake) < 1.4 and not (need_bloodtalons and RakeBT()) and IsReady('Rake') and Player:GCDRemains() < 0.7 and not Player:BuffUp(S.SuddenAmbushBuff) and not VarCCCapped) then
		return S.Prowl:Cast()
	end	
		
	--rake,target_if=refreshable,if=talent.doubleclawed_rake&!(variable.need_bt&buff.bt_rake.up)&!variable.cc_capped
	if IsReady('Rake') and TargetinRange(5) and Target:DebuffRefreshable(S.RakeDebuff, S.CircleofLifeandDeath:IsAvailable() and 3.6 or 4.5) and S.DoubleClawedRake:IsAvailable() and not (need_bloodtalons and RakeBT()) and not VarCCCapped then
		return S.Rake:Cast()
	end

	--swipe_cat,if=talent.wild_slashes&spell_targets.swipe_cat>3&!(variable.need_bt&buff.bt_swipe.up)
	if IsReady('Swipe') and not S.BrutalSlash:IsAvailable() and S.WildSlashes:IsAvailable() and RangeCount(8) > 3 and not (need_bloodtalons and SwipeBT()) then
		return S.SwipeCat:Cast()
	end

	--moonfire_cat,target_if=refreshable,if=!(variable.need_bt&buff.bt_moonfire.up)&!variable.cc_capped
	if IsReady('Moonfire') and TargetinRange(40) and S.LunarInspiration:IsAvailable() and Target:DebuffRefreshable(S.MoonfireCat, S.CircleofLifeandDeath:IsAvailable() and 3.8 or 4.8) and not (need_bloodtalons and MoonfireBT()) and not VarCCCapped then
		return S.Moonfire:Cast()
	end

	--rake,target_if=refreshable,if=!(variable.need_bt&buff.bt_rake.up)&!variable.cc_capped
	if IsReady('Rake') and TargetinRange(5) and Target:DebuffRefreshable(S.RakeDebuff, S.CircleofLifeandDeath:IsAvailable() and 3.6 or 4.5) and not (need_bloodtalons and RakeBT()) and not VarCCCapped then
		return S.Rake:Cast()
	end

	--brutal_slash,if=!(variable.need_bt&buff.bt_swipe.up)
	if IsReady('Brutal Slash') and RangeCount(8) >= 1 and not (need_bloodtalons and BrutalSlashBT()) then
		return S.BrutalSlash:Cast()
	end

	--swipe_cat,if=!(variable.need_bt&buff.bt_swipe.up)
	if IsReady('Swipe') and not S.BrutalSlash:IsAvailable() and RangeCount(8) >= 1 and not (need_bloodtalons and SwipeBT()) then
		return S.SwipeCat:Cast()
	end

	--shred,if=!buff.sudden_ambush.up&!variable.easy_swipe&!(variable.need_bt&buff.bt_shred.up)
	if IsReady('Shred') and TargetinRange(5) and not Player:BuffUp(S.SuddenAmbushBuff) and not (need_bloodtalons and ShredBT()) then
		return S.Shred:Cast()
	end

	--thrash_cat,if=!talent.thrashing_claws&!(variable.need_bt&buff.bt_thrash.up)
	if IsReady('Thrash') and RangeCount(8) >= 1 and ThrashRefreshableAOE((S.CircleofLifeandDeath:IsAvailable() and 3.6 or 4.5)) >= 1 and not S.ThrashingClaws:IsAvailable() and not (need_bloodtalons and ThrashBT()) then
		return S.Thrash:Cast()
	end

	--rake,target_if=max:ticks_gained_on_refresh,if=talent.doubleclawed_rake&buff.sudden_ambush.up&variable.need_bt&buff.bt_rake.down
	if IsReady('Rake') and TargetinRange(5) and S.DoubleClawedRake:IsAvailable() and Player:BuffUp(S.SuddenAmbushBuff) and need_bloodtalons and not RakeBT() then
		return S.Rake:Cast()
	end

	--moonfire_cat,target_if=max:ticks_gained_on_refresh,if=variable.need_bt&buff.bt_moonfire.down
	if C_Spell.IsSpellUsable("Moonfire") and TargetinRange(40) and S.LunarInspiration:IsAvailable() and need_bloodtalons and not MoonfireBT() then
		return S.Moonfire:Cast()
	end

	--rake,target_if=max:ticks_gained_on_refresh,if=buff.sudden_ambush.up&variable.need_bt&buff.bt_rake.down
	if IsReady('Rake') and TargetinRange(5) and Player:BuffUp(S.SuddenAmbushBuff) and need_bloodtalons and not RakeBT() then
		return S.Rake:Cast()
	end

	--shred,if=variable.need_bt&buff.bt_shred.down&!variable.easy_swipe
	if IsReady('Shred') and TargetinRange(5) and need_bloodtalons and not ShredBT() then
		return S.Shred:Cast()
	end

	--rake,target_if=dot.rake.pmultiplier<1.6,if=variable.need_bt&buff.bt_rake.down
	if IsReady('Rake') and TargetinRange(5) and need_bloodtalons and not RakeBT() and Target:PMultiplier(S.Rake) < 1.6 then
		return S.Rake:Cast()
	end

	--thrash_cat,if=variable.need_bt&buff.bt_shred.down
	if IsReady('Thrash') and RangeCount(10) >= 1 and need_bloodtalons and not ThrashBT() then
		return S.Thrash:Cast()
	end

	return nil
end

local function Finish()
	--primal_wrath,target_if=max:dot.bloodseeker_vines.ticking,if=spell_targets.primal_wrath>1&((dot.primal_wrath.remains<6.5&!buff.bs_inc.up|dot.primal_wrath.refreshable)|(!talent.rampant_ferocity.enabled&(spell_targets.primal_wrath>1&!dot.bloodseeker_vines.ticking&!buff.ravage.up|spell_targets.primal_wrath>6+talent.ravage)))
	if IsReady("Primal Wrath") and RubimRH.AoEON() and RangeCount(8) > 1 and S.PrimalWrath:IsAvailable() and (RipRefreshableAOE(6.5) >= 1 and not bs_inc or RipRefreshableAOE((S.CircleofLifeandDeath:IsAvailable() and 2.9 or 3.6)) >= 1) or (not S.RampantFerocity:IsAvailable() and (RangeCount(8) > 1 and not Target:DebuffUp(S.BloodseekerVinesDebuff and not Player:BuffUp(S.RavageBuffFeral) or RangeCount(8) > 6 + num(S.Ravage:IsAvailable())))) then
		return S.PrimalWrath:Cast()
	end	

	--rip,target_if=refreshable,if=(!talent.primal_wrath|spell_targets=1)&(buff.bloodtalons.up|!talent.bloodtalons)&(buff.tigers_fury.up|dot.rip.remains<cooldown.tigers_fury.remains)&(remains<fight_remains|remains<4&buff.ravage.up)
	if IsReady("Rip") and TargetinRange(5) and Target:DebuffRefreshable(S.Rip, S.CircleofLifeandDeath:IsAvailable() and 5.8 or 7.2) and (not S.PrimalWrath:IsAvailable() or RangeCount(8) == 1 or not RubimRH.AoEON()) and (Player:BuffUp(S.BloodtalonsBuff) or not S.Bloodtalons:IsAvailable()) and (Player:BuffUp(S.TigersFury) or Target:DebuffRemains(S.Rip) < S.TigersFury:CooldownRemains() or not RubimRH.CDsON()) then
		return S.Rip:Cast()
 	end

	--pool_resource,for_next=1
	if Player:Energy() < 50 then
		return 0, "Interface\\Addons\\Rubim-RH\\Media\\mount2.tga"
	end

	--ferocious_bite,max_energy=1,target_if=max:dot.bloodseeker_vines.ticking,if=!buff.bs_inc.up
	if IsReady("Ferocious Bite") and TargetinRange(5) and not bs_inc and (Player:Energy() >= 50 or bs_inc) then
		return Item(183480):Cast()
	end

	--ferocious_bite,target_if=max:dot.bloodseeker_vines.ticking
	if IsReady("Ferocious Bite") and TargetinRange(5) then
		return Item(183480):Cast()
	end
end

local function Builder()
	--thrash_cat,if=refreshable&!talent.thrashing_claws&!(variable.need_bt&buff.bt_thrash.up)
	if IsReady("Thrash") and ThrashRefreshableAOE((S.CircleofLifeandDeath:IsAvailable() and 3.6 or 4.5)) >= 1 and not S.ThrashingClaws:IsAvailable() and not (need_bloodtalons and ThrashBT()) then
		return S.Thrash:Cast()
	end
	--brutal_slash,target_if=min:time_to_die,if=(cooldown.brutal_slash.full_recharge_time<4|time_to_die<4|raid_event.adds.remains<4|(buff.bs_inc.up&spell_targets>=3-hero_tree.druid_of_the_claw))&!(variable.need_bt&buff.bt_swipe.up&(buff.bs_inc.down|spell_targets<3-hero_tree.druid_of_the_claw))
	if IsReady("Brutal Slash") and (S.BrutalSlash:FullRechargeTime() < 4 or (bs_inc and RangeCount(8) >= 3 - num(Player:HeroTreeID() == 21))) and not (need_bloodtalons and BrutalSlashBT() and (not bs_inc or RangeCount(8) < 3 - num(Player:HeroTreeID() == 21))) then
		return S.BrutalSlash:Cast()
	end

	--swipe_cat,if=time_to_die<4|(talent.wild_slashes&spell_targets.swipe_cat>4&!(variable.need_bt&buff.bt_swipe.up))
	if IsReady("Swipe") and not S.BrutalSlash:IsAvailable() and RangeCount(8) > 4 and S.WildSlashes:IsAvailable() and not (need_bloodtalons and SwipeBT()) then
		return S.SwipeCat:Cast()
	end

	--prowl,target_if=dot.rake.refreshable|dot.rake.pmultiplier<1.4,if=!(variable.need_bt&buff.bt_rake.up)&action.rake.ready&gcd.remains=0&!buff.sudden_ambush.up&!variable.cc_capped
	if IsReady("Prowl") and TargetinRange(5) and (Target:DebuffRefreshable(S.RakeDebuff, S.CircleofLifeandDeath:IsAvailable() and 3.6 or 4.5) or Target:PMultiplier(S.Rake) < 1.4 and not (need_bloodtalons and RakeBT()) and IsReady("Rake") and Player:GCDRemains() < 0.7 and not Player:BuffUp(S.SuddenAmbushBuff) and not VarCCCapped) then
		return S.Prowl:Cast()
	end

	--rake,target_if=refreshable,if=talent.doubleclawed_rake&!(variable.need_bt&buff.bt_rake.up)&!variable.cc_capped
	if IsReady("Rake") and TargetinRange(5) and Target:DebuffRefreshable(S.RakeDebuff, S.CircleofLifeandDeath:IsAvailable() and 3.6 or 4.5) and S.DoubleClawedRake:IsAvailable() and not (need_bloodtalons and RakeBT()) and not VarCCCapped then
		return S.Rake:Cast()
	end

	--swipe_cat,if=talent.wild_slashes&spell_targets.swipe_cat>3&!(variable.need_bt&buff.bt_swipe.up)
	if IsReady("Swipe") and not S.BrutalSlash:IsAvailable() and S.WildSlashes:IsAvailable() and RangeCount(8) > 3 and not (need_bloodtalons and SwipeBT()) then
		return S.SwipeCat:Cast()
	end

	--moonfire_cat,target_if=refreshable,if=!(variable.need_bt&buff.bt_moonfire.up)&!variable.cc_capped
	if IsReady("Moonfire") and TargetinRange(40) and S.LunarInspiration:IsAvailable() and Target:DebuffRefreshable(S.MoonfireCat, S.CircleofLifeandDeath:IsAvailable() and 3.8 or 4.8) and not (need_bloodtalons and MoonfireBT()) and not VarCCCapped then
		return S.Moonfire:Cast()
	end

	--rake,target_if=refreshable,if=!(variable.need_bt&buff.bt_rake.up)&!variable.cc_capped
	if IsReady("Rake") and TargetinRange(5) and Target:DebuffRefreshable(S.RakeDebuff, S.CircleofLifeandDeath:IsAvailable() and 3.6 or 4.5) and not (need_bloodtalons and RakeBT()) and not VarCCCapped then
		return S.Rake:Cast()
	end

	--brutal_slash,if=!(variable.need_bt&buff.bt_swipe.up)
	if IsReady("Brutal Slash") and RangeCount(8) >= 1 and not (need_bloodtalons and BrutalSlashBT()) then
		return S.BrutalSlash:Cast()
	end

	--swipe_cat,if=!(variable.need_bt&buff.bt_swipe.up)
	if IsReady("Swipe") and not S.BrutalSlash:IsAvailable() and RangeCount(8) >= 1 and not (need_bloodtalons and SwipeBT()) then
		return S.SwipeCat:Cast()
	end

	--shred,if=!buff.sudden_ambush.up&!variable.easy_swipe&!(variable.need_bt&buff.bt_shred.up)
	if IsReady("Shred") and TargetinRange(5) and not Player:BuffUp(S.SuddenAmbushBuff) and not (need_bloodtalons and ShredBT()) then
		return S.Shred:Cast()
	end

	--thrash_cat,if=!talent.thrashing_claws&!(variable.need_bt&buff.bt_thrash.up)
	if IsReady("Thrash") and RangeCount(8) >= 1 and ThrashRefreshableAOE((S.CircleofLifeandDeath:IsAvailable() and 3.6 or 4.5)) >= 1 and not S.ThrashingClaws:IsAvailable() and not (need_bloodtalons and ThrashBT()) then
		return S.Thrash:Cast()
	end

	--rake,target_if=max:ticks_gained_on_refresh,if=talent.doubleclawed_rake&buff.sudden_ambush.up&variable.need_bt&buff.bt_rake.down
	if IsReady("Rake") and TargetinRange(5) and S.DoubleClawedRake:IsAvailable() and Player:BuffUp(S.SuddenAmbushBuff) and need_bloodtalons and not RakeBT() then
		return S.Rake:Cast()
	end

	--moonfire_cat,target_if=max:ticks_gained_on_refresh,if=variable.need_bt&buff.bt_moonfire.down
	if IsReady("Moonfire") and TargetinRange(40) and S.LunarInspiration:IsAvailable() and need_bloodtalons and not MoonfireBT() then
		return S.Moonfire:Cast()
	end

	--rake,target_if=max:ticks_gained_on_refresh,if=buff.sudden_ambush.up&variable.need_bt&buff.bt_rake.down
	if IsReady("Rake") and TargetinRange(5) and Player:BuffUp(S.SuddenAmbushBuff) and need_bloodtalons and not RakeBT() then
		return S.Rake:Cast()
	end

	--shred,if=variable.need_bt&buff.bt_shred.down&!variable.easy_swipe
	if IsReady("Shred") and TargetinRange(5) and need_bloodtalons and not ShredBT() then
		return S.Shred:Cast()
	end

	--rake,target_if=dot.rake.pmultiplier<1.6,if=variable.need_bt&buff.bt_rake.down
	if IsReady("Rake") and TargetinRange(5) and need_bloodtalons and not RakeBT() and Target:PMultiplier(S.Rake) < 1.6 then
		return S.Rake:Cast()
	end

	--thrash_cat,if=variable.need_bt&buff.bt_shred.down
	if IsReady("Thrash") and RangeCount(10) >= 1 and need_bloodtalons and not ThrashBT() then
		return S.Thrash:Cast()
	end

	return nil
end

local function Cooldowns()
	--incarnation,if=target.time_to_die>17|target.time_to_die=fight_remains
	if (IsReady("Incarnation") and S.Incarnation:IsAvailable()) and TargetinRange(8) and RubimRH.CDsON() then
		return S.Incarnation:Cast()
	end
	--berserk,if=buff.tigers_fury.up&(target.time_to_die>12|target.time_to_die=fight_remains)
	if (IsReady("Berserk") and S.Berserk:IsAvailable()) and TargetinRange(8) and RubimRH.CDsON() and Player:BuffUp(S.TigersFury) then
		return S.Berserk:Cast()
	end	
	--berserking,if=buff.bs_inc.up
	if IsReady("Berserking") and TargetinRange(8) and RubimRH.CDsON() and (Player:BuffRemains(S.Incarnation) >= 12 or Player:BuffRemains(S.Berserk) >= 12) then
		return S.Berserking:Cast()
	end

	--potion,if=buff.bs_inc.up|fight_remains<32|(!variable.lastZerk&variable.lastConvoke&cooldown.convoke_the_spirits.remains<10)
	-- if TargetinRange(10) and RubimRH.CDsON() and IsUsableItem(191382) and GetItemCooldown(191382) == 0 and GetItemCount(191382) >= 1 and not Player:InArena() and not Player:InBattlegrounds() and (Player:BuffRemains(S.Berserk) > 15 or Player:BuffRemains(S.Incarnation) > 15) and not AuraUtil.FindAuraByName("Elemental Potion of Ultimate Power", "player") then
	-- 	return S.Potion:Cast()
	-- end

	--use_item,slot=trinket1,if=variable.trinket_1_buffs&(buff.bs_inc.up|((buff.tigers_fury.up&cooldown.tigers_fury.remains>20)&(cooldown.convoke_the_spirits.remains<4|cooldown.convoke_the_spirits.remains>45|(variable.trinket_2_buffs&cooldown.convoke_the_spirits.remains-trinket.2.cooldown.remains>0)|!talent.convoke_the_spirits&(cooldown.bs_inc.remains>40|cooldown.bs_inc.remains-trinket.2.cooldown.remains>0))))&(!trinket.2.has_cooldown|trinket.2.cooldown.remains|variable.trinket_priority=1)|trinket.1.proc.any_dps.duration>=fight_remains
	if trinket1ready and RubimRH.CDsON() and ((bs_inc and (not S.Convoke:IsAvailable() or S.Convoke:CooldownRemains() < 10)) or (S.Convoke:CooldownRemains() == 0 or (not S.Convoke:IsAvailable() and bs_inc))) then
		return I.tx1:Cast()
	end

	--use_item,slot=trinket2,if=variable.trinket_2_buffs&(buff.bs_inc.up|((buff.tigers_fury.up&cooldown.tigers_fury.remains>20)&(cooldown.convoke_the_spirits.remains<4|cooldown.convoke_the_spirits.remains>45|(variable.trinket_1_buffs&cooldown.convoke_the_spirits.remains-trinket.1.cooldown.remains>0)|!talent.convoke_the_spirits&(cooldown.bs_inc.remains>40|cooldown.bs_inc.remains-trinket.1.cooldown.remains>0))))&(!trinket.1.has_cooldown|trinket.1.cooldown.remains|variable.trinket_priority=2)|trinket.2.proc.any_dps.duration>=fight_remains

	--feral_frenzy,if=combo_points<=1|buff.bs_inc.up&combo_points<=2
	if IsReady("Feral Frenzy") and TargetinRange(5) and RubimRH.CDsON() and (Player:ComboPoints() <= 1 or (bs_inc and Player:ComboPoints() <= 2)) then
		return S.FeralFrenzy:Cast()
	end

	--convoke_the_spirits,if=fight_remains<5|(cooldown.bs_inc.remains>45|buff.bs_inc.up|!talent.berserk_heart_of_the_lion)&(buff.tigers_fury.up&(combo_points<=4|buff.bs_inc.up&combo_points<=3)&(target.time_to_die>5-talent.ashamanes_guidance.enabled|target.time_to_die=fight_remains))
	if IsReady("Convoke the Spirits") and TargetinRange(5) and RubimRH.CDsON() and (S.Berserk:CooldownRemains() > 45 or bs_inc or not S.BerserkHeartoftheLion:IsAvailable()) and Player:BuffUp(S.TigersFury) and (Player:ComboPoints() <= 4 or (bs_inc and Player:ComboPoints() <= 3)) then
		return Item(186687):Cast()
	end

	return nil
end

local function APL()
--print(select(1,AuraUtil.FindAuraByName("Mark of the Wild", "player")))
--print("Target: ",Target:PMultiplier(S.Rake)," Player: ",Player:PMultiplier(S.Rake))
--------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------Functions/Top priorities----------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
if Player:IsCasting() or Player:IsChanneling() then
	return 0, "Interface\\Addons\\Rubim-RH\\Media\\channel.tga"
elseif Player:IsDeadOrGhost() or AuraUtil.FindAuraByName("Drink", "player") or AuraUtil.FindAuraByName("Food", "player") or AuraUtil.FindAuraByName("Food & Drink", "player") or Player:BuffUp(S.TravelForm)
or (Player:BuffUp(S.Prowl) and not Player:BuffUp(S.Incarnation) and AuraUtil.FindAuraByName("Mark of the Wild", "player") and S.Rake:ID() ~= RubimRH.queuedSpell[1]:ID()) then
	return 0, "Interface\\Addons\\Rubim-RH\\Media\\mount2.tga"
end 

if true then
	-- variable,name=effective_energy,op=set,value=energy+(40*buff.clearcasting.stack)+(3*energy.regen)+(50*(cooldown.tigers_fury.remains<3.5))
	VarEffectiveEnergy = Player:Energy() + (40 * Player:BuffStack(S.Clearcasting)) + (3 * Player:EnergyRegen()) + (50 * num(S.TigersFury:CooldownRemains() < 3.5))
	-- variable,name=time_to_pool,op=set,value=((115-variable.effective_energy-(23*buff.incarnation.up))%energy.regen)
	VarTimeToPool = ((115 - VarEffectiveEnergy - (23 * num(Player:BuffUp(S.Incarnation)))) / Player:EnergyRegen())

	VarCCCapped = Player:BuffStack(S.Clearcasting) == (1 + num(S.MomentofClarity:IsAvailable()))

	evaluate_cycle_adaptive_swarm = (((not Target:DebuffUp(S.AdaptiveSwarmDebuff) or Target:DebuffRemains(S.AdaptiveSwarmDebuff) < 2) and (Target:DebuffStack(S.AdaptiveSwarmDebuff) < 3 or Player:BuffStack(S.AdaptiveSwarmHeal) <= 1) and (not S.AdaptiveSwarm:InFlight())) and (TargetTTD() > 5 or Player:BuffUp(S.Incarnation)) or RangeCount(10) > 2 and not Target:DebuffUp(S.AdaptiveSwarmDebuff) and Player:Energy() < 35 and (TargetTTD() > 5 or Player:BuffUp(S.Incarnation)))

	elite = UnitClassification("target") == "worldboss" or UnitClassification("target") == "rareelite" or UnitClassification("target") == "elite" or UnitClassification("target") == "rare" or target_is_dummy() or Target:IsAPlayer()
	
	boss = UnitClassification("target") == "elite" and UnitLevel('target') == -1
	
	need_bloodtalons = (S.Bloodtalons:IsAvailable() and Player:BuffStack(S.BloodtalonsBuff) < 2)
	
	proccing_bt = BloodTalonTriggers() == 2 and need_bloodtalons

	bs_inc = Player:BuffUp(S.Berserk) or Player:BuffUp(S.Incarnation)

	--bs_inc_up = (S.Incarnation:IsAvailable() and S.Incarnation:CooldownUp()) or (not S.Incarnation:IsAvailable() and S.Berserk:CooldownUp()) or not RubimRH.CDsON()

	trinket1 = GetInventoryItemID("player", 13)
	
	trinket2 = GetInventoryItemID("player", 14)
	
	isEnraged = AuraUtil.FindAuraByName("Enrage", "target") or UnitChannelInfo("target") == "Ragestorm" or AuraUtil.FindAuraByName("Frenzy", "target")
	
	trinket1ready = IsUsableItem(trinket1) and GetItemCooldown(trinket1) == 0 and IsEquippedItem(trinket1)
	
	trinket2ready = IsUsableItem(trinket2) and GetItemCooldown(trinket2) == 0 and IsEquippedItem(trinket2)

	channeling = select(1,UnitChannelInfo('target'))
	
	casting = select(1, UnitCastingInfo('target'))

	name, realm = UnitName('target')

	_,_,_,_,_,_,_,notInterruptible,_ = UnitCastingInfo("target")
	
	start_time_cast_ms = select(4, UnitCastingInfo('target')) or 0
	
	current_time_ms = GetTime() * 1000
	
	elapsed_time_cast_ca = (start_time_cast_ms > 0) and (current_time_ms - start_time_cast_ms) or 0
	
	cast_time = elapsed_time_cast_ca / 1000

	start_time_channel_ms = select(4, UnitChannelInfo('target')) or 0
	
	elapsed_time_channel_ch = (start_time_channel_ms > 0) and (current_time_ms - start_time_channel_ms) or 0
	
	channel_time = elapsed_time_channel_ch / 1000

	motw = select(1,AuraUtil.FindAuraByName("Mark of the Wild", "player"))

	if AuraUtil.FindAuraByName("Mark of the Wild","player") then
		motwremains = select(6,AuraUtil.FindAuraByName("Mark of the Wild","player")) - GetTime()
	else
		motwremains = 0
	end
end
--------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------Out of Combat---------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
if not Player:AffectingCombat() and not IsStealthed() and (IsResting("player") == false or Player:CanAttack(Target)) then
	-- if IsReady("Mark of the Wild") and (motw ~= 'Mark of the Wild' or (motw == 'Mark of the Wild' and motw_remains and motw_remains < 300)) then
	-- 	return S.MarkOfTheWild:Cast()
    -- end
	
	if IsReady("Prowl") and not Player:BuffUp(S.Incarnation) and S.Prowl:TimeSinceLastCast() > 4 and S.Prowl:CooldownRemains() < Player:GCD() and Player:BuffUp(S.CatForm) then
		return S.Prowl:Cast()
    end
end
--------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------Spell Queue-----------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
if IsReady("Cat Form") and Player:PrevGCD(1, S.IncapacitatingRoar) and S.IncapacitatingRoar:TimeSinceLastCast() < Player:GCD() * 2 then
	return S.CatForm:Cast()
end

if S.Rake:ID() == RubimRH.queuedSpell[1]:ID() then
	if not S.Rake:CooldownUp() or not TargetinRange(nil,"Rake") or not Player:CanAttack(Target) or not Player:BuffUp(S.Prowl) then
		RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
	end
end

if S.Rake:ID() == RubimRH.queuedSpell[1]:ID() then
	if S.TigersFury:CooldownUp() and not Player:BuffUp(S.TigersFury) then
		return S.TigersFury:Cast()
	end

	if S.Rake:CooldownUp() and Player:BuffUp(S.TigersFury) or not S.TigersFury:CooldownUp() then
		return S.Rake:Cast()
	end	
end

if not IsReady(RubimRH.queuedSpell[1]:ID(),nil,nil,1) or not Player:AffectingCombat() 
or (S.CatForm:ID() == RubimRH.queuedSpell[1]:ID() and Player:BuffUp(S.CatForm))
or (S.BearForm:ID() == RubimRH.queuedSpell[1]:ID() and Player:BuffUp(S.BearForm))
or (S.FeralFrenzy:ID() == RubimRH.queuedSpell[1]:ID() and (not TargetinRange(nil,"Feral Frenzy") or not Player:CanAttack(Target)))
or (S.EntanglingRoots:ID() == RubimRH.queuedSpell[1]:ID() and Player:PrevGCD(1, S.EntanglingRoots))
or (S.RemoveCorruption:ID() == RubimRH.queuedSpell[1]:ID() and Player:PrevGCD(1, S.RemoveCorruption))
or (S.Regrowth:ID() == RubimRH.queuedSpell[1]:ID() and (Player:PrevGCD(1, S.Regrowth) or (Player:IsMoving() and not Player:BuffUp(S.PredatorySwiftness))))
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

if IsReady(RubimRH.queuedSpell[1]:ID(),nil,nil,1) and S.FeralFrenzy:ID() ~= RubimRH.queuedSpell[1]:ID() then
    return RubimRH.QueuedSpell():Cast()
end
--------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------Interrupts & Tranq-----------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
if RubimRH.InterruptsON() and not IsStealthed() then 
	if S.Hibernate:IsReady() and TargetinRange(nil,"Hibernate") and notInterruptible == false and cast_time > 0 and name == "Incorporeal Being" then
		return S.Hibernate:Cast()
	end
	
	if S.SkullBash:IsReady() and TargetinRange(5) and notInterruptible == false and (cast_time > Player:GCDRemains() + 0.47 or channel_time > Player:GCDRemains() + 0.47) then
		return S.SkullBash:Cast()
	end

	-- if S.Soothe:IsReady(40) and (isEnraged and RubimRH.InterruptsON() and Player:AffectingCombat() and (TargetTTD() > 4 or Player:BuffUp(S.Incarnation))) then
		-- return S.Soothe:Cast()
	-- end
end
--------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------Cooldowns-------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
if IsReady("Regrowth") and Player:BuffUp(S.PredatorySwiftness) and not (need_bloodtalons and BloodTalonTriggers() == 2) and ((Player:HealthPercentage() <= 85 and RangeCount(30) == 0) or (Player:HealthPercentage() < 40 and Player:EnergyTimeToMaxPredicted() > Player:GCD())) then
	return S.Regrowth:Cast()
end

if IsReady("Renewal") and Player:AffectingCombat() and Player:HealthPercentage() < 35 then
	return S.Renewal:Cast()
end

if Player:HealthPercentage() < 30 and Player:AffectingCombat() 
and (IsUsableItem(191379) or IsUsableItem(191378) or IsUsableItem(191380) or IsUsableItem(211879))
and (GetItemCooldown(191380) == 0 or GetItemCooldown(191379) == 0 or GetItemCooldown(191378) == 0 or GetItemCooldown(211879) == 0) 
and (GetItemCount(191380) >= 1 or GetItemCount(191379) >= 1 or GetItemCount(191378) >= 1 or GetItemCount(211879) >= 1) 
and (not Player:InArena() and not Player:InBattlegrounds()) then
	return I.HPIcon:Cast()
end
--------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------Rotation--------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
if IsReady("CatForm") and Player:CanAttack(Target) and not Player:BuffUp(S.BearForm) and not Player:BuffUp(S.CatForm) and S.Regrowth:TimeSinceLastCast() > Player:GCD() then
	return S.CatForm:Cast()
end

-- if trinket2ready and Player:CanAttack(Target) and TargetinRange(8) and Player:BuffUp(S.CatForm) and Player:AffectingCombat() and not IsStealthed() and (((TargetTTD() > 10 or Player:BuffUp(S.Incarnation)) or (UnitClassification("target") == "worldboss" and (TargetTTD() > 6 or Player:BuffUp(S.Incarnation)))) or RangeCount(10) > 1) and name ~= "Spiteful Shade" then
-- 	return I.tx2:Cast()
-- end

if Player:CanAttack(Target) and Player:BuffUp(S.CatForm) and ((Player:AffectingCombat() and not IsStealthed()) or Player:BuffUp(S.Incarnation)) then
	--prowl,if=buff.bs_inc.down&!buff.prowl.up

	if not C_Spell.IsCurrentSpell(6603) and TargetinRange(8) and not IsStealthed() then
		return S.autoattack:Cast()
	end
	--tigers_fury,if=(energy.deficit>35|combo_points=5|combo_points>=3&dot.rip.refreshable&buff.bloodtalons.up)&(fight_remains<=15|(cooldown.bs_inc.remains>20&target.time_to_die>5)|(cooldown.bs_inc.ready&target.time_to_die>12|target.time_to_die=fight_remains))
	if IsReady("Tiger's Fury") and RubimRH.CDsON() and TargetinRange(8) and (Player:EnergyDeficit() > 35 or Player:ComboPoints() == 5 or (Player:ComboPoints() >= 3 and Target:DebuffRefreshable(S.Rip) and Player:BuffUp(S.BloodtalonsBuff))) and (S.Berserk:CooldownRemains() > 20 or S.Berserk:CooldownUp() or S.Incarnation:CooldownRemains() > 20 or S.Incarnation:CooldownUp()) then
		return S.TigersFury:Cast()
	end
	--rake,target_if=max:refreshable+(persistent_multiplier>dot.rake.pmultiplier),if=buff.shadowmeld.up|buff.prowl.up
	if IsReady("Rake") and TargetinRange(5) and Player:BuffUp(S.ProwlIncarn) and (Target:AffectingCombat() or target_is_dummy()) and (Target:DebuffRefreshable(S.RakeDebuff, S.CircleofLifeandDeath:IsAvailable() and 3.6 or 4.5) or Player:PMultiplier(S.Rake) > Target:PMultiplier(S.Rake)) then
		return S.Rake:Cast()
	end
	--adaptive_swarm,target_if=dot.adaptive_swarm_damage.stack<3&(!dot.adaptive_swarm_damage.ticking|dot.adaptive_swarm_damage.remains<2),if=!action.adaptive_swarm_damage.in_flight&(spell_targets=1|!talent.unbridled_swarm)&(dot.rip.ticking|hero_tree.druid_of_the_claw)
    if IsReady("Adaptive Swarm") and TargetinRange(40) and evaluate_cycle_adaptive_swarm and not (need_bloodtalons and BloodTalonTriggers() == 2) then
		return S.AdaptiveSwarm:Cast()    
	end
	--ferocious_bite,if=buff.apex_predators_craving.up&!(variable.need_bt&active_bt_triggers=2)
	if IsReady("Ferocious Bite") and TargetinRange(5) and Player:BuffUp(S.ApexPredatorBuff) and not (need_bloodtalons and BloodTalonTriggers() == 2) then
		return Item(183480):Cast()
	end
	--call_action_list,name=cooldown,if=dot.rip.ticking
	if Cooldowns() and RubimRH.CDsON() and (Target:DebuffUp(S.Rip) or RangeCount(8) > 1) then
		return Cooldowns()
	end
	--rip,if=spell_targets=1&hero_tree.wildstalker&!(talent.raging_fury&talent.veinripper)&(buff.bloodtalons.up|!talent.bloodtalons)&(dot.rip.remains<5&buff.tigers_fury.remains>10&combo_points>=3|((buff.tigers_fury.remains<3&combo_points=5)|buff.tigers_fury.remains<=1)&buff.tigers_fury.up&combo_points>=3&remains<cooldown.tigers_fury.remains)
	if IsReady("Rip") and TargetinRange(5) and Player:HeroTreeID() == 22 and not (S.RagingFury:IsAvailable() and S.Veinripper:IsAvailable()) and (Player:BuffUp(S.BloodtalonsBuff) or not S.Bloodtalons:IsAvailable()) and ((Target:DebuffRemains(S.Rip) < 5 and Player:BuffRemains(S.TigersFury) > 10 and Player:ComboPoints() >= 3) or (((Player:BuffRemains(S.TigersFury) < 3 and Player:ComboPoints() == 5) or Player:BuffRemains(S.TigersFury) <= 1) and Player:BuffUp(S.TigersFury) and Player:ComboPoints() >= 3 and Target:DebuffRemains(S.Rip) < S.TigersFury:CooldownRemains())) then
		return S.Rip:Cast()
	end
	--call_action_list,name=finisher,if=combo_points=5
	if Finish() and Player:ComboPoints() == 5 then
		return Finish()
	end
	--call_action_list,name=builder,if=spell_targets.swipe_cat=1&combo_points<5&(variable.time_to_pool<=0|!variable.need_bt|variable.proccing_bt)
	if Builder() and (RangeCount(8) == 1 or not RubimRH.AoEON()) and Player:ComboPoints() < 5 and (VarTimeToPool <= 0 or not need_bloodtalons or proccing_bt) then
		return Builder()
	end
	--call_action_list,name=aoe_builder,if=spell_targets.swipe_cat>=2&combo_points<5&(variable.time_to_pool<=0|!variable.need_bt|variable.proccing_bt)
	if AOEBuilder() and RubimRH.AoEON() and RangeCount(8) >= 2 and Player:ComboPoints() < 5 and (VarTimeToPool <= 0 or not need_bloodtalons or proccing_bt) then
		return AOEBuilder()
	end
end
    return 0, "Interface\\Addons\\Rubim-RH\\Media\\mount2.tga"
end

RubimRH.Rotation.SetAPL(103, APL)

local function PASSIVE()
    return RubimRH.Shared()
end
RubimRH.Rotation.SetPASSIVE(103, PASSIVE)