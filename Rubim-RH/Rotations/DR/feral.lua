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
	DireFixation = Spell(417710),
	DireFixationDebuff = Spell(417713),
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
	--brutal_slash,target_if=min:target.time_to_die,if=(cooldown.brutal_slash.full_recharge_time<4|target.time_to_die<5)&!((variable.need_bt|buff.bs_inc.up)&buff.bt_brutal_slash.up)
	if S.BrutalSlash:IsReadyQueue() and S.BrutalSlash:FullRechargeTimeP() < 4 and not ((need_bloodtalons or bs_inc) and BrutalSlashBT()) then
		return S.BrutalSlash:Cast()
	end
	
	--thrash_cat,if=dot.thrash_cat.remains<3&(!buff.sudden_ambush.up|!talent.doubleclawed_rake.enabled)&!talent.thrashing_claws
	if S.Thrash:IsReadyMorph() and ThrashRefreshableAOE((S.CircleofLifeandDeath:IsAvailable() and 3.6 or 4.5)) >= 1 and (not Player:Buff(S.SuddenAmbushBuff) or not S.DoubleClawedRake:IsAvailable()) and not S.ThrashingClaws:IsAvailable() then
		return S.Thrash:Cast()
	end
	
	--prowl,target_if=max:dot.rake.pmultiplier<1.6|dot.rake.refreshable,if=(dot.rake.pmultiplier<1.6|dot.rake.refreshable)&!(variable.need_bt&buff.bt_rake.up)
	if S.ProwlIncarn:IsReadyMorph() and not AuraUtil.FindAuraByName("Prowl", "player") and (Target:PMultiplier(S.Rake) < 1.6 or Target:DebuffRefreshableP(S.RakeDebuff, S.CircleofLifeandDeath:IsAvailable() and 3.6 or 4.5)) and not (need_bloodtalons and RakeBT()) then
		return S.Prowl:Cast()
	end	
	
	--rake,target_if=max:(dot.rake.pmultiplier<1.6|dot.rake.refreshable)*druid.rake.ticks_gained_on_refresh,if=(buff.sudden_ambush.up&persistent_multiplier>dot.rake.pmultiplier|dot.rake.refreshable)&!(variable.need_bt&buff.bt_rake.up)
	if S.Rake:IsReadyQueue() and TargetinRange(nil,"Rake") and (Target:PMultiplier(S.Rake) < 1.6 or Target:DebuffRefreshableP(S.RakeDebuff, S.CircleofLifeandDeath:IsAvailable() and 3.6 or 4.5)) and (Player:Buff(S.SuddenAmbushBuff) and Player:PMultiplier(S.Rake) > Target:PMultiplier(S.Rake) or Target:DebuffRefreshableP(S.RakeDebuff, S.CircleofLifeandDeath:IsAvailable() and 3.6 or 4.5)) and not (need_bloodtalons and RakeBT()) then
		return S.Rake:Cast()
	end

	--thrash_cat,if=refreshable&!talent.thrashing_claws
	if S.Thrash:IsReadyMorph() and ThrashRefreshableAOE((S.CircleofLifeandDeath:IsAvailable() and 3.6 or 4.5)) >= 1 and not S.ThrashingClaws:IsAvailable() then
		return S.Thrash:Cast()
	end

	--brutal_slash,if=!(variable.need_bt&buff.bt_brutal_slash.up)
	if S.BrutalSlash:IsReadyQueue() and not (need_bloodtalons and BrutalSlashBT()) then
		return S.BrutalSlash:Cast()
	end
	
	--swipe_cat,if=spell_targets.swipe_cat>4&!(variable.need_bt&buff.bt_swipe.up)
	if S.SwipeCat:IsReadyMorph() and RangeCount(10) > 4 and not (need_bloodtalons and SwipeBT()) then
		return S.SwipeCat:Cast()
	end

	--moonfire_cat,target_if=max:(3*refreshable)+dot.adaptive_swarm_damage.ticking,if=dot.moonfire.refreshable&!(variable.need_bt&buff.bt_moonfire.up)
	if IsUsableSpell("Moonfire") and TargetinRange(nil,"Moonfire") and S.LunarInspiration:IsAvailable() and Target:DebuffRefreshableP(S.MoonfireCat, S.CircleofLifeandDeath:IsAvailable() and 3.8 or 4.8) and not (need_bloodtalons and MoonfireBT()) then
		return S.Moonfire:Cast()
	end
	
	--swipe_cat,if=!(variable.need_bt&buff.bt_swipe.up)
	if S.SwipeCat:IsReadyMorph() and RangeCount(10) >= 1 and not (need_bloodtalons and SwipeBT()) then
		return S.SwipeCat:Cast()
	end
	
	--shred,target_if=max:target.time_to_die,if=(spell_targets.swipe_cat<4|talent.dire_fixation.enabled)&!buff.sudden_ambush.up&!(variable.easy_swipe&talent.wild_slashes)&!(variable.need_bt&buff.bt_shred.up)
	if S.Shred:IsReadyQueue() and TargetinRange(nil,"Shred") and (RangeCount(10) < 4 or (S.DireFixation:IsAvailable() and not Target:DebuffP(S.DireFixationDebuff))) and not Player:BuffP(S.SuddenAmbushBuff) and not (need_bloodtalons and ShredBT()) then
		return S.Shred:Cast()
	end	
	
	--thrash_cat,if=!(variable.need_bt&buff.bt_thrash.up)
	if S.Thrash:IsReadyMorph() and RangeCount(10) >= 1 and not (need_bloodtalons and ThrashBT()) then
		return S.Thrash:Cast()
	end
	
	--shred,target_if=max:target.time_to_die,if=!variable.easy_swipe&variable.need_bt&buff.bt_shred.down
	if S.Shred:IsReadyQueue() and TargetinRange(nil,"Shred") and need_bloodtalons and not ShredBT() then
		return S.Shred:Cast()
	end	
	
	--moonfire_cat,target_if=max:dot.moonfire.ticks_gained_on_refresh,if=variable.need_bt&buff.bt_moonfire.down
	if IsUsableSpell("Moonfire") and TargetinRange(nil,"Moonfire") and S.LunarInspiration:IsAvailable() and need_bloodtalons and not MoonfireBT() then
		return S.Moonfire:Cast()
	end

	--rake,target_if=max:((dot.rake.pmultiplier<=persistent_multiplier)*25)+druid.rake.ticks_gained_on_refresh,if=variable.need_bt&buff.bt_rake.down
	if S.Rake:IsReadyQueue() and TargetinRange(nil,"Rake") and Target:PMultiplier(S.Rake) <= Player:PMultiplier(S.Rake) and need_bloodtalons and not RakeBT() then
		return S.Rake:Cast()
	end
	
	return nil
end

local function Finish()
	--primal_wrath,if=(dot.primal_wrath.refreshable|(talent.tear_open_wounds.enabled|(spell_targets.swipe_cat>4&!talent.rampant_ferocity.enabled)))&spell_targets.primal_wrath>1&talent.primal_wrath.enabled
	if S.PrimalWrath:IsReadyQueue() and RubimRH.AoEON() and RangeCount(10) > 1 and S.PrimalWrath:IsAvailable() and (RipRefreshableAOE((S.CircleofLifeandDeath:IsAvailable() and 2.9 or 3.6)) >= 1 or (S.TearOpenWounds:IsAvailable() or (RangeCount(10) > 4 and not S.RampantFerocity:IsAvailable()))) then
		return S.PrimalWrath:Cast()
	end	

	--rip,target_if=((set_bonus.tier31_2pc&cooldown.feral_frenzy.remains<2&dot.rip.remains<10)|(time<8|buff.bloodtalons.up|!talent.bloodtalons.enabled|(buff.bs_inc.up&dot.rip.remains<2))&refreshable)&(!talent.primal_wrath.enabled|spell_targets.swipe_cat=1)&!(buff.smoldering_frenzy.up&dot.rip.remains>2)
	if S.Rip:IsReadyQueue() and TargetinRange(nil,"Rip") and ((tier31equipped() >= 2 and RubimRH.CDsON() and S.FeralFrenzy:CooldownRemains() < 2 and Target:DebuffRemains(S.Rip) < 10) or (Player:Buff(S.BloodtalonsBuff) or not S.Bloodtalons:IsAvailable() or (bs_inc and Target:DebuffRemains(S.Rip) < 2)) and Target:DebuffRefreshableP(S.Rip, S.CircleofLifeandDeath:IsAvailable() and 5.8 or 7.2)) and (not S.TearOpenWounds:IsAvailable() or RangeCount(10) == 1 or not RubimRH.AoEON()) and not (Player:Buff(S.SmolderingFrenzy) and Target:DebuffRemains(S.Rip) > 2) then
		return S.Rip:Cast()
	end	
	
	--pool_resource,for_next=1,if=!action.tigers_fury.ready&buff.apex_predators_craving.down
    --ferocious_bite,max_energy=1,target_if=max:target.time_to_die,if=buff.apex_predators_craving.down&(!buff.bs_inc.up|(buff.bs_inc.up&!talent.soul_of_the_forest.enabled))
	if S.FerociousBite:IsReadyQueue() and TargetinRange(nil,"Ferocious Bite") and (not Player:BuffP(S.ApexPredatorBuff) and (not bs_inc or (bs_inc and not S.SoulOfTheForest:IsAvailable()))) then
		if not Player:BuffP(S.ApexPredatorBuff) and TargetinRange(nil,"Ferocious Bite") and (Player:BuffRemains(S.SmolderingFrenzy) > Player:GCD() or not Player:Buff(S.SmolderingFrenzy)) then
			if not S.TigersFury:IsReadyQueue() and Player:Energy() < 50 then
				return 0, "Interface\\Addons\\Rubim-RH\\Media\\mount2.tga" 
			elseif S.TigersFury:IsReadyQueue() or Player:Energy() >= 50 or Player:BuffRemains(S.SmolderingFrenzy) < Player:GCD() then
				return S.FerociousBite:Cast()
			end
		end
	end
	
    --ferocious_bite,target_if=max:target.time_to_die,if=(buff.bs_inc.up&talent.soul_of_the_forest.enabled)|buff.apex_predators_craving.up
	if S.FerociousBite:IsReadyQueue() and TargetinRange(nil,"Ferocious Bite") and ((bs_inc and S.SoulOfTheForest:IsAvailable()) or Player:BuffP(S.ApexPredatorBuff)) then
		return S.FerociousBite:Cast()
	end
end

local function Berserk()
	--call_action_list,name=finisher,if=combo_points=5&!(buff.overflowing_power.stack<=1&active_bt_triggers=2&buff.bloodtalons.stack<=1&set_bonus.tier30_4pc)
	if Finish() and Player:ComboPoints() == 5 then
		return Finish()
	end

	--call_action_list,name=aoe_builder,if=spell_targets.swipe_cat>1
	if AOEBuilder() and RangeCount(10) > 1 then
		return AOEBuilder()
	end

	--prowl,if=!(buff.bt_rake.up&active_bt_triggers=2)&action.rake.ready&gcd.remains=0&!buff.sudden_ambush.up&(dot.rake.refreshable|dot.rake.pmultiplier<1.4)&!buff.shadowmeld.up
	if S.ProwlIncarn:IsReadyMorph() and not AuraUtil.FindAuraByName("Prowl", "player") and TargetinRange(nil,"Rake") and not (RakeBT() and BloodTalonTriggers() == 2) and S.Rake:IsReadyQueue() and Player:GCDRemains() < 0.7 and not Player:Buff(S.SuddenAmbushBuff) and (Target:DebuffRefreshableP(S.RakeDebuff, S.CircleofLifeandDeath:IsAvailable() and 3.6 or 4.5) or Target:PMultiplier(S.Rake) < 1.4) then
		return S.Prowl:Cast()
	end	

	--rake,if=!(buff.bt_rake.up&active_bt_triggers=2)&(refreshable|buff.sudden_ambush.up&persistent_multiplier>dot.rake.pmultiplier)
	if S.Rake:IsReadyQueue() and TargetinRange(nil,"Rake") and not (RakeBT() and BloodTalonTriggers() == 2) and (Target:DebuffRefreshableP(S.RakeDebuff, S.CircleofLifeandDeath:IsAvailable() and 3.6 or 4.5) or Player:BuffP(S.SuddenAmbushBuff) and Player:PMultiplier(S.Rake) > Target:PMultiplier(S.Rake)) then
		return S.Rake:Cast()
	end
	
	--shred,if=active_bt_triggers=2&buff.bt_shred.down
	if S.Shred:IsReadyQueue() and TargetinRange(nil,"Shred") and BloodTalonTriggers() == 2 and not ShredBT() then
		return S.Shred:Cast()
	end

	--brutal_slash,if=active_bt_triggers=2&buff.bt_brutal_slash.down
	if S.BrutalSlash:IsReadyQueue() and RubimRH.AoEON() and RangeCount(10) >= 1 and BloodTalonTriggers() == 2 and not BrutalSlashBT() then
		return S.BrutalSlash:Cast()
	end

	--moonfire_cat,if=active_bt_triggers=2&buff.bt_moonfire.down
	if IsUsableSpell("Moonfire") and TargetinRange(nil,"Moonfire") and S.LunarInspiration:IsAvailable() and BloodTalonTriggers() == 2 and not MoonfireBT() then
		return S.Moonfire:Cast()
	end

	--thrash_cat,if=active_bt_triggers=2&buff.bt_thrash.down&!talent.thrashing_claws&variable.need_bt
	if S.Thrash:IsReadyMorph() and RubimRH.AoEON() and RangeCount(10) >= 1 and BloodTalonTriggers() == 2 and not ThrashBT() and not S.ThrashingClaws:IsAvailable() and need_bloodtalons then
		return S.Thrash:Cast()
	end
	
	--moonfire_cat,if=refreshable
	if IsUsableSpell("Moonfire") and TargetinRange(nil,"Moonfire") and S.LunarInspiration:IsAvailable() and Target:DebuffRefreshableP(S.MoonfireCat, S.CircleofLifeandDeath:IsAvailable() and 3.8 or 4.8) then
		return S.Moonfire:Cast()
	end

	--brutal_slash,if=cooldown.brutal_slash.charges>1&(!talent.dire_fixation.enabled|debuff.dire_fixation.up)
	if S.BrutalSlash:IsReadyQueue() and RangeCount(10) >= 1 and S.BrutalSlash:ChargesP() > 1 and (not S.DireFixation:IsAvailable() or Target:Debuff(S.DireFixationDebuff)) then
		return S.BrutalSlash:Cast()
	end

	--shred
	if S.Shred:IsReadyQueue() and TargetinRange(nil,"Shred") then
		return S.Shred:Cast()
	end

	return nil
end

local function Builder()
	--thrash_cat,if=refreshable&(!talent.dire_fixation.enabled|talent.dire_fixation.enabled&debuff.dire_fixation.up)&buff.clearcasting.react&!talent.thrashing_claws.enabled
	if S.Thrash:IsReadyMorph() and RangeCount(10) >= 1 and ThrashRefreshableAOE((S.CircleofLifeandDeath:IsAvailable() and 3.6 or 4.5)) >= 1 and (not S.DireFixation:IsAvailable() or S.DireFixation:IsAvailable() and Target:Debuff(S.DireFixationDebuff)) and Player:Buff(S.Clearcasting) and not S.ThrashingClaws:IsAvailable() then
		return S.Thrash:Cast()
	end	
	
	--shred,if=(buff.clearcasting.react|(talent.dire_fixation.enabled&!debuff.dire_fixation.up))&!(variable.need_bt&buff.bt_shred.up)
	if S.Shred:IsReadyQueue() and TargetinRange(nil,"Shred") and (Player:Buff(S.Clearcasting) or (S.DireFixation:IsAvailable() and not Target:Debuff(S.DireFixationDebuff))) and not (need_bloodtalons and ShredBT()) then
		return S.Shred:Cast()
	end
	
	--brutal_slash,if=cooldown.brutal_slash.full_recharge_time<4&!(variable.need_bt&buff.bt_brutal_slash.up)
	if S.BrutalSlash:IsReadyQueue() and RangeCount(10) >= 1 and S.BrutalSlash:FullRechargeTimeP() < 4 and not (need_bloodtalons and BrutalSlashBT()) then
		return S.BrutalSlash:Cast()
	end	
	
	--pool_resource,if=!action.rake.ready&(dot.rake.refreshable|(buff.sudden_ambush.up&persistent_multiplier>dot.rake.pmultiplier&dot.rake.remains>6))&!buff.clearcasting.react&!(variable.need_bt&buff.bt_rake.up)
	if not S.Rake:IsReadyQueue() and TargetinRange(8) and (Target:DebuffRefreshableP(S.RakeDebuff, S.CircleofLifeandDeath:IsAvailable() and 3.6 or 4.5) or (Player:BuffP(S.SuddenAmbushBuff) and Player:PMultiplier(S.Rake) > Target:PMultiplier(S.Rake) and (Target:DebuffRemainsP(S.RakeDebuff) > (S.CircleofLifeandDeath:IsAvailable() and 3.6 or 4.5)))) and not Player:BuffP(S.Clearcasting) and not (need_bloodtalons and RakeBT()) then
		return 0, "Interface\\Addons\\Rubim-RH\\Media\\mount2.tga"
	end

	--rake,if=(refreshable|buff.sudden_ambush.up&persistent_multiplier>dot.rake.pmultiplier)&!(variable.need_bt&buff.bt_rake.up)
	if S.Rake:IsReadyQueue() and TargetinRange(nil,"Rake") and (Target:DebuffRefreshableP(S.RakeDebuff, S.CircleofLifeandDeath:IsAvailable() and 3.6 or 4.5) or Player:BuffP(S.SuddenAmbushBuff) and Player:PMultiplier(S.Rake) > Target:PMultiplier(S.Rake)) and not (need_bloodtalons and RakeBT()) then
		return S.Rake:Cast()
	end

	--moonfire_cat,target_if=refreshable
	if IsUsableSpell("Moonfire") and TargetinRange(nil,"Moonfire") and S.LunarInspiration:IsAvailable() and Target:DebuffRefreshableP(S.MoonfireCat, S.CircleofLifeandDeath:IsAvailable() and 3.8 or 4.8) then
		return S.Moonfire:Cast()
	end

	--thrash_cat,target_if=refreshable&!talent.thrashing_claws.enabled
	if S.Thrash:IsReadyMorph() and RangeCount(10) >= 1 and ThrashRefreshableAOE((S.CircleofLifeandDeath:IsAvailable() and 3.6 or 4.5)) >= 1 and not S.ThrashingClaws:IsAvailable() then
		return S.Thrash:Cast()
	end

	--brutal_slash,if=!(variable.need_bt&buff.bt_brutal_slash.up)
	if S.BrutalSlash:IsReadyQueue() and RangeCount(10) >= 1 and not (need_bloodtalons and BrutalSlashBT()) then
		return S.BrutalSlash:Cast()
	end
	
	--swipe_cat,if=spell_targets.swipe_cat>1|(talent.wild_slashes.enabled&(debuff.dire_fixation.up|!talent.dire_fixation.enabled))
	if S.SwipeCat:IsReadyMorph() and RangeCount(10) >= 1 and (RangeCount(10) > 1 or (S.WildSlashes:IsAvailable() and (Target:DebuffP(S.DireFixationDebuff) or not S.DireFixation:IsAvailable()))) then
		return S.SwipeCat:Cast()
	end

	--shred,if=!(variable.need_bt&buff.bt_shred.up)
	if S.Shred:IsReadyQueue() and TargetinRange(nil,"Shred") and not (need_bloodtalons and ShredBT()) then
		return S.Shred:Cast()
	end

	--moonfire_cat,if=variable.need_bt&buff.bt_moonfire.down
	if IsUsableSpell("Moonfire") and TargetinRange(nil,"Moonfire") and S.LunarInspiration:IsAvailable() and need_bloodtalons and not MoonfireBT() then
		return S.Moonfire:Cast()
	end
	
	--swipe_cat,if=variable.need_bt&buff.bt_swipe.down
	if S.SwipeCat:IsReadyMorph() and RangeCount(10) >= 1 and need_bloodtalons and not SwipeBT() then
		return S.SwipeCat:Cast()
	end
	
	--rake,if=variable.need_bt&buff.bt_rake.down&persistent_multiplier>=dot.rake.pmultiplier
	if S.Rake:IsReadyQueue() and TargetinRange(nil,"Rake") and need_bloodtalons and not RakeBT() and Player:PMultiplier(S.Rake) >= Target:PMultiplier(S.Rake) then
		return S.Rake:Cast()
	end
	
	--thrash_cat,if=variable.need_bt&buff.bt_thrash.down
	if S.Thrash:IsReadyMorph() and RangeCount(10) >= 1 and need_bloodtalons and not ThrashBT() then
		return S.Thrash:Cast()
	end
	
	return nil
end

local function Cooldowns()
	--incarnation,target_if=max:target.time_to_die,if=(target.time_to_die<fight_remains&target.time_to_die>25)|target.time_to_die=fight_remains
	if S.Incarnation:IsReadyQueue() and TargetinRange(8) and RubimRH.CDsON() then
		return S.Incarnation:Cast()
	end

	--edited for practicality
	--berserk,if=fight_remains<25|talent.convoke_the_spirits.enabled&(fight_remains<cooldown.convoke_the_spirits.remains|(variable.align_cds&(action.feral_frenzy.ready&(combo_points<3|(time<10&combo_points<4))|time<10&combo_points<4)&cooldown.convoke_the_spirits.remains<10))
	if S.Berserk:IsReadyQueue() and TargetinRange(8) and RubimRH.CDsON() and (S.FeralFrenzy:IsReadyQueue() or Player:BuffRemains(S.SmolderingFrenzy) > 4) and Player:ComboPoints() < 3 and S.Convoke:CooldownRemains() < 10 then
		return S.Berserk:Cast()
	end	

	--use_item,name=ashes_of_the_embersoul,if=((buff.smoldering_frenzy.up&(!talent.convoke_the_spirits.enabled|cooldown.convoke_the_spirits.remains<10))|!set_bonus.tier31_4pc&(cooldown.convoke_the_spirits.remains=0|!talent.convoke_the_spirits.enabled&buff.bs_inc.up))
	if trinket1ready and ((Player:BuffP(S.SmolderingFrenzy) and (not S.Convoke:IsAvailable() or S.Convoke:CooldownRemains() < 10)) or tier31equipped() < 4 and (S.Convoke:CooldownRemains() == 0 or not S.Convoke:IsAvailable() and bs_inc)) then
		return I.tx1:Cast()
	end

	--berserking,if=!variable.align_3minutes|buff.bs_inc.up
	if S.Berserking:IsReadyQueue() and TargetinRange(8) and RubimRH.CDsON() and (Player:BuffRemainsP(S.Incarnation) >= 12 or Player:BuffRemainsP(S.Berserk) >= 12) then
		return S.Berserking:Cast()
	end
	
	if TargetinRange(10) and RubimRH.CDsON() and IsUsableItem(191382) and GetItemCooldown(191382) == 0 and GetItemCount(191382) >= 1 and not Player:InArena() and not Player:InBattlegrounds() and (Player:BuffRemains(S.Berserk) > 15 or Player:BuffRemains(S.Incarnation) > 15) and not AuraUtil.FindAuraByName("Elemental Potion of Ultimate Power", "player") then
		return S.Potion:Cast()
	end

	--edited for practicality
	--convoke_the_spirits,target_if=max:target.time_to_die,if=fight_remains<5|(buff.smoldering_frenzy.up|!set_bonus.tier31_4pc)&(dot.rip.remains>4-talent.ashamanes_guidance&buff.tigers_fury.up&(combo_points<=2)|buff.bs_inc.up&combo_points<=3)&(debuff.dire_fixation.up|!talent.dire_fixation.enabled|spell_targets.swipe_cat>1)&(target.time_to_die>5-talent.ashamanes_guidance.enabled|target.time_to_die=fight_remains)
	if S.Convoke:IsReadyQueue() and TargetinRange(8) and RubimRH.CDsON() and (Player:Buff(S.SmolderingFrenzy) or tier31equipped() < 4) and (Target:DebuffRemains(S.Rip) > 4 - num(S.AshamanesGuidance:IsAvailable() and Player:Buff(S.TigersFury) and (Player:ComboPoints() <= 2 or bs_inc and Player:ComboPoints() <= 3))) and (Target:Debuff(S.DireFixationDebuff) or not S.DireFixation:IsAvailable() or RangeCount(10) > 1) and (TargetTTD() > 8 - num(S.AshamanesGuidance:IsAvailable()) or Player:BuffP(S.Incarnation)) then
		return S.Convoke:Cast()
	end	
	
	--convoke_the_spirits,target_if=max:target.time_to_die,if=fight_remains<5|(buff.smoldering_frenzy.up|!set_bonus.tier31_4pc)&(dot.rip.remains>4-talent.ashamanes_guidance&buff.tigers_fury.up&combo_points<2)&(debuff.dire_fixation.up|!talent.dire_fixation.enabled|spell_targets.swipe_cat>1)&((target.time_to_die<fight_remains&target.time_to_die>5-talent.ashamanes_guidance.enabled)|target.time_to_die=fight_remains)
	-- if S.Convoke:IsReadyQueue() and TargetinRange(8) and RubimRH.CDsON() and (Player:Buff(S.SmolderingFrenzy) or tier31equipped() < 4) and (Target:DebuffRemains(S.Rip) > 4 - num(S.AshamanesGuidance:IsAvailable() and Player:Buff(S.TigersFury) and Player:ComboPoints() < 2)) and (Target:Debuff(S.DireFixationDebuff) or not S.DireFixation:IsAvailable() or RangeCount(10) > 1) then
	-- 	return S.Convoke:Cast()
	-- end	
	
	--convoke_the_spirits,if=buff.smoldering_frenzy.up&buff.smoldering_frenzy.remains<5.1-talent.ashamanes_guidance
	if S.Convoke:IsReadyQueue() and TargetinRange(8) and RubimRH.CDsON() and Player:Buff(S.SmolderingFrenzy) and Player:BuffRemains(S.SmolderingFrenzy) < 5.1 - num(S.AshamanesGuidance:IsAvailable()) then
		return S.Convoke:Cast()
	end

	-- if trinket2ready then
	-- 	return I.tx2:Cast()
	-- end

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
elseif Player:IsDeadOrGhost() or AuraUtil.FindAuraByName("Drink", "player") or AuraUtil.FindAuraByName("Food", "player") or AuraUtil.FindAuraByName("Food & Drink", "player") or Player:Buff(S.TravelForm)
or (Player:Buff(S.Prowl) and not Player:BuffP(S.Incarnation) and AuraUtil.FindAuraByName("Mark of the Wild", "player") and S.Rake:ID() ~= RubimRH.queuedSpell[1]:ID()) then
	return 0, "Interface\\Addons\\Rubim-RH\\Media\\mount2.tga"
end 

if true then
	evaluate_cycle_adaptive_swarm = (((not Target:DebuffP(S.AdaptiveSwarmDebuff) or Target:DebuffRemainsP(S.AdaptiveSwarmDebuff) < 2) and (Target:DebuffStackP(S.AdaptiveSwarmDebuff) < 3 or Player:BuffStackP(S.AdaptiveSwarmHeal) <= 1) and (not S.AdaptiveSwarm:InFlight())) and (TargetTTD() > 5 or Player:BuffP(S.Incarnation)) or RangeCount(10) > 2 and not Target:DebuffP(S.AdaptiveSwarmDebuff) and Player:Energy() < 35 and (TargetTTD() > 5 or Player:BuffP(S.Incarnation)))

	elite = UnitClassification("target") == "worldboss" or UnitClassification("target") == "rareelite" or UnitClassification("target") == "elite" or UnitClassification("target") == "rare" or target_is_dummy() or Target:IsAPlayer()
	
	boss = UnitClassification("target") == "elite" and UnitLevel('target') == -1
	
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
	if S.MarkOfTheWild:IsCastableQueue() and (motw ~= 'Mark of the Wild' or (motw == 'Mark of the Wild' and motw_remains and motw_remains < 300)) then
		return S.MarkOfTheWild:Cast()
    end
	
	if S.Prowl:IsCastable() and not Player:BuffP(S.Incarnation) and S.Prowl:TimeSinceLastCast() > 4 and S.Prowl:CooldownRemains() < Player:GCD() and Player:Buff(S.CatForm) then
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
	if not S.Rake:CooldownUp() or not TargetinRange(nil,"Rake") or not Player:CanAttack(Target) or not Player:BuffP(S.Prowl) then
		RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
	end
end

if S.Rake:ID() == RubimRH.queuedSpell[1]:ID() then
	if S.TigersFury:CooldownUp() and not Player:BuffP(S.TigersFury) then
		return S.TigersFury:Cast()
	end

	if S.Rake:CooldownUp() and Player:BuffP(S.TigersFury) or not S.TigersFury:CooldownUp() then
		return S.Rake:Cast()
	end	
end

if not RubimRH.queuedSpell[1]:CooldownUp() or not Player:AffectingCombat() 
or (S.CatForm:ID() == RubimRH.queuedSpell[1]:ID() and Player:BuffP(S.CatForm))
or (S.BearForm:ID() == RubimRH.queuedSpell[1]:ID() and Player:BuffP(S.BearForm))
or (S.FeralFrenzy:ID() == RubimRH.queuedSpell[1]:ID() and (not TargetinRange(nil,"Feral Frenzy") or not Player:CanAttack(Target)))
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

if RubimRH.QueuedSpell():IsReadyQueue() and S.FeralFrenzy:ID() ~= RubimRH.queuedSpell[1]:ID() then
    return RubimRH.QueuedSpell():Cast()
end
--------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------Interrupts & Tranq-----------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
if RubimRH.InterruptsON() and not IsStealthed() then 
	if S.Hibernate:IsReadyQueue() and TargetinRange(nil,"Hibernate") and notInterruptible == false and cast_time > 0 and name == "Incorporeal Being" then
		return S.Hibernate:Cast()
	end
	
	if S.SkullBash:IsReadyQueue() and TargetinRange(5) and notInterruptible == false and (cast_time > Player:GCDRemains() + 0.47 or channel_time > Player:GCDRemains() + 0.47) then
		return S.SkullBash:Cast()
	end

	-- if S.Soothe:IsReady(40) and (isEnraged and RubimRH.InterruptsON() and Player:AffectingCombat() and (TargetTTD() > 4 or Player:BuffP(S.Incarnation))) then
		-- return S.Soothe:Cast()
	-- end
end
--------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------Cooldowns-------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
if S.Regrowth:IsCastable() and Player:BuffP(S.PredatorySwiftness) and not (need_bloodtalons and BloodTalonTriggers() == 2) and ((Player:HealthPercentage() <= 85 and RangeCount(30) == 0) or (Player:HealthPercentage() < 40 and Player:EnergyTimeToMaxPredicted() > Player:GCD())) then
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

-- if trinket2ready and Player:CanAttack(Target) and TargetinRange(8) and Player:BuffP(S.CatForm) and Player:AffectingCombat() and not IsStealthed() and (((TargetTTD() > 10 or Player:BuffP(S.Incarnation)) or (UnitClassification("target") == "worldboss" and (TargetTTD() > 6 or Player:BuffP(S.Incarnation)))) or RangeCount(10) > 1) and name ~= "Spiteful Shade" then
-- 	return I.tx2:Cast()
-- end

if Player:CanAttack(Target) and Player:BuffP(S.CatForm) and ((Player:AffectingCombat() and not IsStealthed()) or Player:BuffP(S.Incarnation)) then
	--tigers_fury,target_if=min:target.time_to_die,if=!set_bonus.tier31_4pc&talent.convoke_the_spirits.enabled|!buff.tigers_fury.up|energy.deficit>65|set_bonus.tier31_2pc&action.feral_frenzy.ready|target.time_to_die<15&talent.predator.enabled
	if S.TigersFury:IsReadyQueue() and TargetinRange(8) and ((tier31equipped() < 4 and S.Convoke:IsAvailable()) or not Player:BuffP(S.TigersFury) or Player:EnergyDeficit() > 65 or (tier31equipped() >= 2 and S.FeralFrenzy:IsReadyQueue()) or (TargetTTD() < 15 and S.Predator:IsAvailable())) then 
		return S.TigersFury:Cast()
	end	
	
	--rake,target_if=persistent_multiplier>dot.rake.pmultiplier,if=buff.prowl.up|buff.shadowmeld.up
	if S.Rake:IsReadyQueue() and TargetinRange(nil,"Rake") and Player:BuffP(S.ProwlIncarn) and (Target:AffectingCombat() or target_is_dummy()) and (Target:DebuffRefreshableP(S.RakeDebuff, S.CircleofLifeandDeath:IsAvailable() and 3.6 or 4.5) or Player:PMultiplier(S.Rake) > Target:PMultiplier(S.Rake)) then
		return S.Rake:Cast()
	end

	if not IsCurrentSpell(6603) and TargetinRange(8) and not IsStealthed() then
		return S.autoattack:Cast()
	end
	
	--adaptive_swarm,target_if=max:(1+dot.adaptive_swarm_damage.stack)*dot.adaptive_swarm_damage.stack<3*time_to_die,if=dot.adaptive_swarm_damage.stack<3&talent.unbridled_swarm.enabled&spell_targets.swipe_cat>1
    if S.AdaptiveSwarm:IsReadyQueue() and TargetinRange(nil,"Adaptive Swarm") and evaluate_cycle_adaptive_swarm and not (need_bloodtalons and BloodTalonTriggers() == 2) then
		return S.AdaptiveSwarm:Cast()    
	end
	
	--call_action_list,name=cooldown,if=(time>3|!talent.dire_fixation.enabled|debuff.dire_fixation.up&combo_points<4|spell_targets.swipe_cat>1)&!(spell_targets=1&talent.convoke_the_spirits.enabled)
	if Cooldowns() and RubimRH.CDsON() and (not S.DireFixation:IsAvailable() or Target:Debuff(S.DireFixationDebuff) and Player:ComboPoints() < 4 or RangeCount(10) > 1) and not (RangeCount(10) == 1 and S.Convoke:IsAvailable()) then
		return Cooldowns()
	end
	
	--call_action_list,name=cooldown,if=dot.rip.ticking|spell_targets.swipe_cat>1
	if Cooldowns() and RubimRH.CDsON() and (Target:Debuff(S.Rip) or RangeCount(10) > 1) then
		return Cooldowns()
	end
	
	--feral_frenzy,target_if=max:target.time_to_die,if=(combo_points<=2|combo_points<=3&buff.bs_inc.up)&(dot.rip.ticking|spell_targets.swipe_cat>1)&(!talent.dire_fixation.enabled|debuff.dire_fixation.up|spell_targets.swipe_cat>1)&(target.time_to_die>6|target.time_to_die=fight_remains)
	if S.FeralFrenzy:IsReadyQueue() and TargetinRange(nil,"Feral Frenzy") and (Player:ComboPoints() <= 2 or (Player:ComboPoints() <= 3 and bs_inc)) and (S.FeralFrenzy:ID() == RubimRH.queuedSpell[1]:ID() or ((RubimRH.CDsON() or (elite and (S.Incarnation:IsAvailable() and S.Incarnation:CooldownRemains() > 8) or (S.Convoke:IsAvailable() and S.Convoke:CooldownRemains() > 8))) and name ~= "Spiteful Shade" and name ~= "Incorporeal Being" and RipRefreshableAOE((S.CircleofLifeandDeath:IsAvailable() and 2.9 or 3.6)) == 0 and (not S.DireFixation:IsAvailable() or Target:Debuff(S.DireFixationDebuff) or RangeCount(10) > 1) and (AreaTTD() == nil or (AreaTTD() and AreaTTD() > 10) or Player:BuffP(S.Incarnation))) 
	or ((S.Convoke:IsAvailable() and S.Convoke:IsReadyQueue()) and RubimRH.CDsON() and Target:Debuff(S.Rip))) then
		return S.FeralFrenzy:Cast()
	end
	
	--ferocious_bite,target_if=max:target.time_to_die,if=buff.apex_predators_craving.up&(spell_targets.swipe_cat=1|!talent.primal_wrath.enabled|!buff.sabertooth.up)&!(variable.need_bt&active_bt_triggers=2)
	if S.FerociousBite:IsReadyQueue() and TargetinRange(nil,"Ferocious Bite") and Player:BuffP(S.ApexPredatorBuff) and (RangeCount(10) == 1 or not S.TearOpenWounds:IsAvailable() or not Player:BuffP(S.Sabertooth)) and not (need_bloodtalons and BloodTalonTriggers() == 2) then
		return S.FerociousBite:Cast()
	end

	if Berserk() and bs_inc then
		return Berserk()
	end

	--call_action_list,name=finisher,if=combo_points>=4
	if Finish() and Player:ComboPoints() >= 4 then
		return Finish()
	end
	
	--call_action_list,name=aoe_builder,if=spell_targets.swipe_cat>1&combo_points<4
	if AOEBuilder() and RubimRH.AoEON() and RangeCount(10) > 1 and Player:ComboPoints() < 4 then
		return AOEBuilder()
	end

	--call_action_list,name=builder,if=!buff.bs_inc.up&spell_targets.swipe_cat=1&combo_points<4
	if Builder() and not bs_inc and (RangeCount(10) <= 1 or not RubimRH.AoEON()) and Player:ComboPoints() < 4 then
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