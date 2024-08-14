--- Localize Vars
-- Addon
local addonName, addonTable = ...;
-- HeroLib
local HL = HeroLib;
local Cache = HeroCache;
local Unit = HL.Unit;
local Player = Unit.Player;
local Pet = Unit.Pet;
local Target = Unit.Target;
local Spell = HL.Spell;
local Item = HL.Item;
-- Spells

--Survival
RubimRH.Spell[255] = {
    CoordinatedAssault = Spell(360952),
    CoordinatedAssaultz = Spell(265221), --fireblood
    KillCommand = Spell(259489),
    Carve = Spell(187708),
    SerpentSting = Spell(259491),
    RaptorStrikeEagle = Spell(265189),
    RaptorStrike = Spell(186270),
    CounterShot = Spell(147362),
	Steward = Spell(324739),
    CallPet = Spell(883),
    Intimidation = Spell(19577),
    MendPet = Spell(136),
    RevivePet = Spell(982),
    SteelTrapDebuff = Spell(162487),
    SteelTrap = Spell(162488),
	FlankersAdvantage = Spell(263186),
    AMurderofCrows = Spell(131894),
    PheromoneBomb = Spell(270323),
    Spearhead = Spell(360966),
    Spearheadz = Spell(69070),
    VolatileBomb = Spell(271045),
    ShrapnelBomb = Spell(270335),
    ShrapnelBombDebuff = Spell(270339),
    WildfireBomb = Spell(259495),
	RuthlessMarauder = Spell(385718),
    FeignDeath = Spell(5384),
	PheromoneBombDebuff = Spell(270332),
    Stampede = Spell(201430),
    FuryoftheEagleTalent = Spell(213415),
    FuryoftheEagle = Spell(203415),
    GuerrillaTactics = Spell(264332),
    WildfireBombDebuff = Spell(269747),
	VolatileBombDebuff = Spell(271049),
    WildfireBombDebuff = Spell(269747),
    Chakrams = Spell(259391),
    Butchery = Spell(212436),
	foodanddrink = Spell(308433),
    WildfireInfusion = Spell(271014),
    FuryStrikes = Spell(425830),
    InternalBleedingDebuff = Spell(270343),
    FlankingStrike = Spell(269751),
    VipersVenomBuff = Spell(268552),
    KillShot = Spell(320976),
	AlphaPredator = Spell(269737),
    TermsofEngagement = Spell(265895),
    TipoftheSpearBuff = Spell(260286),
    MongooseBiteEagle = Spell(265888),
    MongooseBite = Spell(259387),
    BirdsofPrey = Spell(260331),
    Ranger = Spell(385695),
    MongooseFury = Spell(259388),
    ExplosiveShot = Spell(212431),
    autoattack = Spell(287712), --haymaker
    VipersVenom = Spell(268501),
    AspectoftheTurtle = Spell(186265),
    Exhilaration = Spell(109304),
    FreezingTrap = Spell(187650),
	FreezingTrapz = Spell(255654), --bullrush
    AspectoftheEagle = Spell(186289),
    Muzzle = Spell(187707),
    TranqShot = Spell(19801),
    Harpoon = Spell(190925),
    DeadlyDuo = Spell(19801),
    WingClip = Spell(195645),
	Bombardier = Spell(389880),
    LatentPoison = Spell(273284),
	ContainedExplosion = Spell(426344),
    LatentPoisonDebuff = Spell(378015),
    HydrasBite = Spell(260241),
	CoordinatedKill = Spell(385739),
	ResonatingArrow = Spell(308491),
	DeathChakramDebuff = Spell(375893),
	DeathChakram = Spell(375891),
	DeathChakramz = Spell(260364), --arcane pulse
	Dashz = Spell(274738), --ancestral call
};

local S = RubimRH.Spell[255]

-- Items
if not Item.Hunter then
    Item.Hunter = {}
end

Item.Hunter.Survival = {
healingpoticon = Item(169451),
tx1 = Item(118330),
tx2 = Item(114616),
};
local I = Item.Hunter.Survival;

local function num(val)
    if val then
        return 1
    else
        return 0
    end
end

local function FocusTimeToMaxRounded()
    return math.floor(Player:FocusTimeToMaxPredicted() * 10 + 0.5) / 10;
end

local function UpdateWFB()
    if S.ShrapnelBomb:IsReadyMorph() then
        S.WildfireBomb = Spell(270335)
    elseif S.VolatileBomb:IsReadyMorph() then
        S.WildfireBomb = Spell(271045)
    elseif S.PheromoneBomb:IsReadyMorph() then
        S.WildfireBomb = Spell(270323)
    else
        S.WildfireBomb = Spell(259495)
    end
end

S.ShrapnelBomb.TextureSpellID = { 269747 }
S.PheromoneBomb.TextureSpellID = { 269747 }
S.VolatileBomb.TextureSpellID = { 269747 }
S.WildfireBomb.TextureSpellID = { 269747 }

local function RangeCount(range_check)
local range_counter = 0
    
	if range_check then
		for i=1,40 do
			local unitID = "nameplate" .. i
			if UnitExists("nameplate"..i) then           
				local nameplate_guid = UnitGUID("nameplate"..i) 
				local npc_id = select(6, strsplit("-",nameplate_guid))
				if npc_id ~='120651' and npc_id ~='161895' then
					if UnitCanAttack("player",unitID) and IsActionInRange(range_check,unitID) and UnitHealthMax(unitID) > 5
					and UnitName(unitID) ~= "Incorporeal Being" then
						range_counter = range_counter + 1
					end                    
				end
			end
		end
	else
		range_counter = 0
	end
    
    return range_counter
end

local function TargetinRange(range_check)
	if range_check then
		if IsActionInRange(range_check,"target") then
			return true
		else
			return false
		end
	else
		return false	
	end
end

local function target_is_dummy()
    local x = UnitName("target")
    local targetisdummy = false

    if x then
        name = x:sub(-5)
    end

    if Target:Exists() then
        if name == 'Dummy' or name == 'elist' then
            targetisdummy = true
        end
    else
        targetisdummy = false
    end

    return targetisdummy
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
                while (UnitGUID('Target') ~= allGUID[count]) do
                    count = count + 1
                    break
                end
            end

            if #currHealthMax >= 1 then
                for id = 1, #currHealthMax do
                    dps = (currHealthMax[#currHealth] - currHealth[#currHealth]) /
                        HL.CombatTime("nameplate" .. #currHealthMax)
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

local function tierequipped()
    local items = {
        "Blazing Dreamstalker's Scaled Hauberk",
        "Blazing Dreamstalker's Finest Hunt",
        "Blazing Dreamstalker's Flamewaker Horns",
        "Blazing Dreamstalker's Shellgreaves",
    }

    local count = 0

    for _, itemName in ipairs(items) do
        if IsEquippedItem(itemName) then
            count = count + 1
        end
    end

    return count
end

local function Cleave()
	--kill_shot,if=buff.coordinated_assault_empower.up&talent.birds_of_prey **CHECK
	if S.KillShot:IsReady() and TargetinRange(39) and Player:BuffP(S.CoordinatedAssault) and S.BirdsofPrey:IsAvailable() then
		return S.KillShot:Cast()
	end

	--death_chakram,if=cooldown.death_chakram.duration=45
	if S.DeathChakram:IsReady() and TargetinRange(39) and RubimRH.CDsON() then
		return S.DeathChakram:Cast()
	end

	--wildfire_bomb
	if (S.PheromoneBomb:IsReadyMorph() and TargetinRange(39) or S.ShrapnelBomb:IsReadyMorph() or S.VolatileBomb:IsReadyMorph()) then
		return S.WildfireBomb:Cast()
	end

	--stampede
	if S.Stampede:IsReady() and TargetinRange(38) and RubimRH.CDsON() then
		return S.Stampede:Cast()
	end

	--coordinated_assault,if=(cooldown.fury_of_the_eagle.remains|!talent.fury_of_the_eagle)
	-- if S.CoordinatedAssault:IsReady() and TargetinRange(38) and RubimRH.CDsON() and (S.FuryoftheEagle:CooldownDown() or not S.FuryoftheEagleTalent:IsAvailable()) then
		-- return S.CoordinatedAssault:Cast()
	-- end

	--explosive_shot
	if S.ExplosiveShot:IsReady() and TargetinRange(39) then
		return S.ExplosiveShot:Cast()
	end

	--carve,if=cooldown.wildfire_bomb.full_recharge_time>spell_targets%2
	if S.Carve:IsReady() and TargetinRange(38) and S.WildfireBomb:FullRechargeTimeP() > RangeCount(37) then
		return S.Carve:Cast()
	end

	--fury_of_the_eagle,if=cooldown.butchery.full_recharge_time>cast_time&raid_event.adds.exists|!talent.butchery **CHECK
	if S.FuryoftheEagle:IsReady() and RubimRH.CDsON() and TargetinRange(38) and S.Butchery:FullRechargeTimeP() > 3 or not S.Butchery:IsAvailable() then
		return S.FuryoftheEagle:Cast()
	end

	--butchery,if=raid_event.adds.exists
	if S.Butchery:IsReady() and TargetinRange(38) then
		return S.Butchery:Cast()
	end

	--butchery,if=(full_recharge_time<gcd|dot.shrapnel_bomb.ticking&(dot.internal_bleeding.stack<2|dot.shrapnel_bomb.remains<gcd|raid_event.adds.remains<10))&!raid_event.adds.exists
	if S.Butchery:IsReady() and TargetinRange(38) and (S.Butchery:FullRechargeTimeP() < Player:GCD() or Target:Debuff(S.ShrapnelBombDebuff) and (Target:DebuffStackP(S.InternalBleedingDebuff) < 2 or Target:DebuffRemains(S.ShrapnelBombDebuff) < Player:GCD())) then
		return S.Butchery:Cast()
	end

	--fury_of_the_eagle,if=!raid_event.adds.exists
	
	--carve,if=dot.shrapnel_bomb.ticking
	if S.Carve:IsReady() and TargetinRange(38) and Target:Debuff(S.ShrapnelBombDebuff) then
		return S.Carve:Cast()
	end

	--butchery,if=(!next_wi_bomb.shrapnel|!talent.wildfire_infusion)
	if S.Butchery:IsReady() and TargetinRange(38) and (not S.ShrapnelBomb:IsReady() or not S.WildfireInfusion:IsAvailable()) then
		return S.Butchery:Cast()
	end

	--mongoose_bite,target_if=max:debuff.latent_poison.stack,if=debuff.latent_poison.stack>8
	if S.MongooseBite:IsReady() and TargetinRange(38) and Target:DebuffStackP(S.LatentPoison) > 8 then
		return S.MongooseBite:Cast()
	end

	--raptor_strike,target_if=max:debuff.latent_poison.stack,if=debuff.latent_poison.stack>8
	if S.RaptorStrike:IsReady() and TargetinRange(38) and Target:DebuffStackP(S.LatentPoison) > 8 then
		return S.RaptorStrike:Cast()
	end

	--kill_command,target_if=min:bloodseeker.remains,if=focus+cast_regen<focus.max&full_recharge_time<gcd
	if S.KillCommand:IsReady() and TargetinRange(38) and Player:Focus() + 15 < 100 and S.KillCommand:FullRechargeTimeP() < Player:GCD() then
		return S.KillCommand:Cast()
	end

	--flanking_strike,if=focus+cast_regen<focus.max
	if S.FlankingStrike:IsReady() and TargetinRange(38) and Player:Focus() + 30 < 100 then
		return S.FlankingStrike:Cast()
	end

	--carve
	if S.Carve:IsReady() and TargetinRange(38) then
		return S.Carve:Cast()
	end

	--kill_shot,if=!buff.coordinated_assault.up
	if S.KillShot:IsReady() and TargetinRange(39) and not Player:Buff(S.CoordinatedAssault) then
		return S.KillShot:Cast()
	end

	--spearhead
	if S.Spearhead:IsReady() and TargetinRange(39) and RubimRH.CDsON() then
		return S.Spearhead:Cast()
	end

	--mongoose_bite,target_if=min:dot.serpent_sting.remains,if=buff.spearhead.remains
	if S.MongooseBite:IsReady() and TargetinRange(38) and Target:Debuff(S.SerpentSting) and Player:Buff(S.Spearhead) then
		return S.MongooseBite:Cast()
	end

	--serpent_sting,target_if=min:remains,if=refreshable&target.time_to_die>12&(!talent.vipers_venom|talent.hydras_bite)
	if S.SerpentSting:IsReady() and TargetinRange(39) and Target:DebuffRemains(S.SerpentSting) < 6 and TargetTTD() > 12 and (not S.VipersVenom:IsActive() or S.HydrasBite:IsAvailable()) then
		return S.SerpentSting:Cast()
	end

	--mongoose_bite,target_if=min:dot.serpent_sting.remains
	if S.MongooseBite:IsReady() and TargetinRange(38) then
		return S.MongooseBite:Cast()
	end

	--raptor_strike,target_if=min:dot.serpent_sting.remains
	if S.RaptorStrike:IsReady() and TargetinRange(38) then
		return S.RaptorStrike:Cast()
	end
	
	return nil
end

local function ST()
	--kill_shot,if=buff.coordinated_assault_empower.up
	if S.KillShot:IsReady() and TargetinRange(39) and Player:Buff(S.CoordinatedAssault) then
		return S.KillShot:Cast()
	end

	--wildfire_bomb,if=talent.spearhead&cooldown.spearhead.remains<2*gcd&full_recharge_time<gcd|talent.bombardier&(cooldown.coordinated_assault.remains<gcd&cooldown.fury_of_the_eagle.remains|buff.coordinated_assault.up&buff.coordinated_assault.remains<2*gcd)|full_recharge_time<gcd|prev.fury_of_the_eagle&set_bonus.tier31_2pc|buff.contained_explosion.remains&(next_wi_bomb.pheromone&dot.pheromone_bomb.refreshable|next_wi_bomb.volatile&dot.volatile_bomb.refreshable|next_wi_bomb.shrapnel&dot.shrapnel_bomb.refreshable)|cooldown.fury_of_the_eagle.remains<gcd&full_recharge_time<gcd&set_bonus.tier31_2pc|(cooldown.fury_of_the_eagle.remains<gcd&talent.ruthless_marauder&set_bonus.tier31_2pc)&!raid_event.adds.exists
	if (S.PheromoneBomb:IsReadyMorph() or S.ShrapnelBomb:IsReadyMorph() or S.VolatileBomb:IsReadyMorph()) and TargetinRange(39) and (S.Spearhead:IsAvailable() and S.Spearhead:CooldownRemainsP() < 2 * Player:GCD() and S.WildfireBomb:FullRechargeTimeP() < Player:GCD() or S.Bombardier:IsAvailable() and (S.CoordinatedAssault:CooldownRemainsP() < Player:GCD() and S.FuryoftheEagle:CooldownDown() or Player:Buff(S.CoordinatedAssault) and Player:BuffRemains(S.CoordinatedAssault) < 2 * Player:GCD()) or S.WildfireBomb:FullRechargeTimeP() < Player:GCD() or S.FuryoftheEagle:TimeSinceLastCast() < Player:GCD() and tierequipped() >= 2 or Player:Buff(S.ContainedExplosion) and (S.PheromoneBomb:IsReadyMorph() and Target:DebuffRemains(S.PheromoneBombDebuff) < 3 or S.VolatileBomb:IsReadyMorph() and Target:DebuffRemains(S.VolatileBombDebuff) < 3 or S.ShrapnelBomb:IsReadyMorph() and Target:DebuffRemains(S.ShrapnelBombDebuff) < 3) or S.FuryoftheEagle:CooldownRemainsP() < Player:GCD() and S.WildfireBomb:FullRechargeTimeP() < Player:GCD() and tierequipped() >= 2 or (S.FuryoftheEagle:CooldownRemainsP() < Player:GCD() and S.RuthlessMarauder:IsAvailable() and tierequipped() >= 2)) then                        
		return S.WildfireBomb:Cast()
	end

	--death_chakram,if=focus+cast_regen<focus.max|talent.spearhead&!cooldown.spearhead.remains&cooldown.fury_of_the_eagle.remains|talent.bombardier&!cooldown.fury_of_the_eagle.remains
	if S.DeathChakram:IsReady() and TargetinRange(39) and RubimRH.CDsON() and (Player:Focus() + RangeCount(38) * 3 < 100 or S.Spearhead:IsAvailable() and not S.Spearhead:CooldownUp() and S.FuryoftheEagle:CooldownUp() or S.Bombardier:IsAvailable() and not S.FuryoftheEagle:CooldownUp()) then
		return S.DeathChakram:Cast()
	end

	--mongoose_bite,if=prev.fury_of_the_eagle
	if S.MongooseBite:IsReady() and TargetinRange(38) and S.FuryoftheEagle:TimeSinceLastCast() < Player:GCD() then
		return S.MongooseBite:Cast()
	end
	
	--fury_of_the_eagle,interrupt_if=(cooldown.wildfire_bomb.full_recharge_time<gcd&talent.ruthless_marauder|!talent.ruthless_marauder),if=(!raid_event.adds.exists&set_bonus.tier31_2pc|raid_event.adds.exists&raid_event.adds.in>40&set_bonus.tier31_2pc)
	--and (S.WildfireBomb:FullRechargeTimeP() < Player:GCD() and S.RuthlessMarauder:IsAvailable() or not S.RuthlessMarauder:IsAvailable())
	if S.FuryoftheEagle:IsReady() and RubimRH.CDsON() and TargetinRange(38) then
		return S.FuryoftheEagle:Cast()
	end

	--spearhead,if=focus+action.kill_command.cast_regen>focus.max-10&(cooldown.death_chakram.remains|!talent.death_chakram)
	if S.Spearhead:IsReady() and TargetinRange(38) and (Player:Focus() + 15 > 100 - 10 and (S.DeathChakram:CooldownDown() or not S.DeathChakram:IsAvailable()))	then
		return S.Spearhead:Cast()
	end

	--kill_command,target_if=min:bloodseeker.remains,if=full_recharge_time<gcd&focus+cast_regen<focus.max&(buff.deadly_duo.stack>2|talent.flankers_advantage&buff.deadly_duo.stack>1|buff.spearhead.remains&dot.pheromone_bomb.remains)
	if S.KillCommand:IsReady() and TargetinRange(38) and (S.KillCommand:FullRechargeTime() < Player:GCD() and Player:Focus() + 15 < 100 and (Player:BuffStack(S.DeadlyDuo) > 2 or not S.FlankersAdvantage:IsAvailable() and Player:BuffStack(S.DeadlyDuo) > 1 or Player:Buff(S.Spearhead) and Target:Debuff(S.PheromoneBombDebuff))) then
		return S.KillCommand:Cast()
	end

	--**CHECK
	--mongoose_bite,if=active_enemies=1&target.time_to_die<focus%(variable.mb_rs_cost-cast_regen)*gcd|buff.mongoose_fury.up&buff.mongoose_fury.remains<gcd|buff.spearhead.remains
	if S.MongooseBite:IsReady() and TargetinRange(38) and (RangeCount(38) == 1 and TargetTTD() < Player:Focus() / 30 * Player:GCD() or Player:Buff(S.MongooseFury) and S.MongooseFury:CooldownRemains() < Player:GCD() or not Player:Buff(S.Spearhead)) then
		return S.MongooseBite:Cast()
	end

	--kill_shot,if=!buff.coordinated_assault.up&!buff.spearhead.up
	if S.KillShot:IsReady() and TargetinRange(39) and not Player:Buff(S.CoordinatedAssault) and not Player:Buff(S.Spearhead) then
		return S.KillShot:Cast()
	end

	--kill_command,target_if=min:bloodseeker.remains,if=full_recharge_time<gcd&focus+cast_regen<focus.max&dot.pheromone_bomb.remains&talent.fury_of_the_eagle&cooldown.fury_of_the_eagle.remains>gcd
	if S.KillCommand:IsReady() and TargetinRange(38) and (S.KillCommand:FullRechargeTimeP() < Player:GCD() and Player:Focus() + 15 < 100 and Target:Debuff(S.PheromoneBombDebuff) and S.FuryoftheEagle:IsAvailable() and S.FuryoftheEagle:CooldownRemains() < Player:GCD()) then
		return S.KillCommand:Cast()
	end

	--raptor_strike,if=active_enemies=1&target.time_to_die<focus%(variable.mb_rs_cost-cast_regen)*gcd
	if S.RaptorStrike:IsReady() and TargetinRange(38) and (RangeCount(38) == 1 and TargetTTD() < Player:Focus() / 30 * Player:GCD()) then
		return S.RaptorStrike:Cast()
	end

	--serpent_sting,target_if=min:remains,if=!dot.serpent_sting.ticking&target.time_to_die>7&!talent.vipers_venom
	if S.RaptorStrike:IsReady() and TargetinRange(39) and (not Target:Debuff(S.SerpentSting) and TargetTTD() > 7 and not S.VipersVenom:IsAvailable()) then
		return S.RaptorStrike:Cast()
	end

	--mongoose_bite,if=talent.alpha_predator&buff.mongoose_fury.up&buff.mongoose_fury.remains<focus%(variable.mb_rs_cost-cast_regen)*gcd|equipped.djaruun_pillar_of_the_elder_flame&buff.seething_rage.remains&active_enemies=1|next_wi_bomb.pheromone&cooldown.wildfire_bomb.remains<focus%(variable.mb_rs_cost-cast_regen)*gcd&set_bonus.tier31_2pc
	if S.MongooseBite:IsReady() and TargetinRange(38) and (S.AlphaPredator:IsAvailable() and Player:Buff(S.MongooseFury) and Player:BuffRemains(S.MongooseFury) < Player:Focus() / 30 * Player:GCD() or S.PheromoneBomb:IsReadyMorph() and S.WildfireBomb:CooldownRemains() < Player:Focus() / 30 * Player:GCD() and tierequipped() >= 2) then
		return S.MongooseBite:Cast()
	end

	--flanking_strike,if=focus+cast_regen<focus.max
	if S.FlankingStrike:IsReady() and TargetinRange(39) and Player:Focus() + 30 < 100 then
		return S.FlankingStrike:Cast()
	end

	--stampede
	if S.Stampede:IsReady() and TargetinRange(38) and RubimRH.CDsON() then
		return S.Stampede:Cast()
	end

	--coordinated_assault,if=(!talent.coordinated_kill&target.health.pct<20&(!buff.spearhead.remains&cooldown.spearhead.remains|!talent.spearhead)|talent.coordinated_kill&(!buff.spearhead.remains&cooldown.spearhead.remains|!talent.spearhead))&(!raid_event.adds.exists|raid_event.adds.in>90)
	-- if S.CoordinatedAssault:IsReady() and TargetinRange(38) and RubimRH.CDsON() and ((not S.CoordinatedKill:IsAvailable() and Target:HealthPercentage() < 20 and (not Player:Buff(S.Spearhead) and S.Spearhead:CooldownDown() or not S.Spearhead:IsAvailable()) or S.CoordinatedKill:IsAvailable() and (not Player:Buff(S.Spearhead) and S.Spearhead:CooldownDown() or not S.Spearhead:IsAvailable()))) then
		-- return S.CoordinatedAssault:Cast()
	-- end

	--wildfire_bomb,if=next_wi_bomb.pheromone&focus<variable.mb_rs_cost&set_bonus.tier31_2pc
	if (S.PheromoneBomb:IsReadyMorph() or S.ShrapnelBomb:IsReadyMorph() or S.VolatileBomb:IsReadyMorph()) and TargetinRange(38) and S.PheromoneBomb:IsReadyMorph() and Player:Focus() < 30 and tierequipped() >= 2 then
		return S.WildfireBomb:Cast()
	end

	--kill_command,target_if=min:bloodseeker.remains,if=full_recharge_time<gcd&focus+cast_regen<focus.max&(cooldown.flanking_strike.remains|!talent.flanking_strike)
	if S.KillCommand:IsReady() and TargetinRange(38) and (S.KillCommand:FullRechargeTimeP() < Player:GCD() and Player:Focus() + 30 < 100 and (S.FlankingStrike:CooldownDown() or not S.FlankingStrike:IsAvailable())) then
		return S.KillCommand:Cast()
	end

	--serpent_sting,target_if=min:remains,if=refreshable&!talent.vipers_venom
	if S.SerpentSting:IsReady() and TargetinRange(39) and Target:DebuffRemains(S.SerpentSting) < 7 and not S.VipersVenom:IsAvailable() then
		return S.SerpentSting:Cast()
	end

	--mongoose_bite,if=dot.shrapnel_bomb.ticking
	if S.MongooseBite:IsReady() and TargetinRange(38) and Target:Debuff(S.ShrapnelBombDebuff) then
		return S.MongooseBite:Cast()
	end

	--wildfire_bomb,if=raid_event.adds.in>cooldown.wildfire_bomb.full_recharge_time-(cooldown.wildfire_bomb.full_recharge_time%3.5)&(!dot.wildfire_bomb.ticking&focus+cast_regen<focus.max|active_enemies>1)
	if (S.PheromoneBomb:IsReadyMorph() or S.ShrapnelBomb:IsReadyMorph() or S.VolatileBomb:IsReadyMorph()) and TargetinRange(38) and (not (Target:Debuff(S.ShrapnelBombDebuff) and not Target:Debuff(S.PheromoneBombDebuff) and not Target:Debuff(S.VolatileBombDebuff)) and Player:Focus() + 10 < 100 or RangeCount(38) > 1)	then
		return S.WildfireBomb:Cast()
	end

	--mongoose_bite,target_if=max:debuff.latent_poison.stack,if=buff.mongoose_fury.up
	if S.MongooseBite:IsReady() and TargetinRange(38) and Player:Buff(S.MongooseFury) then
		return S.MongooseBite:Cast()
	end

	--explosive_shot,if=talent.ranger&(!raid_event.adds.exists|raid_event.adds.in>28)
	if S.ExplosiveShot:IsReady() and TargetinRange(39) and S.Ranger:IsAvailable() then
		return S.ExplosiveShot:Cast()
	end

	--fury_of_the_eagle,if=(!raid_event.adds.exists|raid_event.adds.exists&raid_event.adds.in>40)
	if S.FuryoftheEagle:IsReady() and RubimRH.CDsON() and TargetinRange(38) then
		return S.FuryoftheEagle:Cast()
	end

	--mongoose_bite
	if S.MongooseBite:IsReady() and TargetinRange(38) then
		return S.MongooseBite:Cast()
	end

	--raptor_strike,target_if=max:debuff.latent_poison.stack
	if S.RaptorStrike:IsReady() and TargetinRange(38) then
		return S.RaptorStrike:Cast()
	end

	--kill_command,target_if=min:bloodseeker.remains,if=focus+cast_regen<focus.max
	if S.KillCommand:IsReady() and TargetinRange(38) and Player:Focus() + 30 < 100 then
		return S.KillCommand:Cast()
	end

	--coordinated_assault,if=!talent.coordinated_kill&time_to_die>140
	-- if S.CoordinatedAssault:IsReady() and TargetinRange(38) and RubimRH.CDsON() and not S.CoordinatedKill:IsAvailable() and TargetTTD() > 140 then
		-- return S.CoordinatedAssault:Cast()
	-- end

	return nil
end

local function APL()
TargetinRange()
RangeCount()
target_is_dummy()
TargetTTD()
tierequipped()
--(S.WildfireBomb:FullRechargeTimeP() < Player:GCD() and S.RuthlessMarauder:IsAvailable() or not S.RuthlessMarauder:IsAvailable())
--------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------Functions/Top priorities----------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
local channel,_,_,_,_,_,_ = UnitChannelInfo('player')

if Player:IsCasting() or Player:IsChanneling() 
and (not channel == 'Fury of the Eagle' or (S.WildfireBomb:FullRechargeTimeP() > Player:GCD() and S.RuthlessMarauder:IsAvailable() or not S.RuthlessMarauder:IsAvailable())) then
	return 0, "Interface\\Addons\\Rubim-RH\\Media\\channel.tga"
elseif Player:IsDeadOrGhost() or AuraUtil.FindAuraByName("Drink", "player") or AuraUtil.FindAuraByName("Food", "player") or AuraUtil.FindAuraByName("Food & Drink", "player") or AuraUtil.FindAuraByName("Feign Death", "player") then
	return 0, "Interface\\Addons\\Rubim-RH\\Media\\mount2.tga"
end 

local name, text, texture, startTimeMS, endTimeMS, isTradeSkill, castID, notInterruptible, spellId = UnitCastingInfo("target")

start, duration, enabled = GetSpellCooldown(61684);
DashCD = duration - (GetTime() - start)

local trinket1 = GetInventoryItemID("player", 13)

local trinket2 = GetInventoryItemID("player", 14)

local trinket1ready = IsUsableItem(trinket1) and GetItemCooldown(trinket1) == 0 and IsEquippedItem(trinket1)

local trinket2ready = IsUsableItem(trinket2) and GetItemCooldown(trinket2) == 0 and IsEquippedItem(trinket2)

if DashCD < 0 then 
	DashCD = 0
end
--------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------Out of Combat---------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
if not Player:AffectingCombat() then

end
--------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------Spell Queue-----------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
if not RubimRH.queuedSpell[1]:CooldownUp() or not Player:AffectingCombat() then
	RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
end

if S.FreezingTrap:ID() == RubimRH.queuedSpell[1]:ID() then
	return S.FreezingTrapz:Cast()
end

if S.CoordinatedAssault:ID() == RubimRH.queuedSpell[1]:ID() then
	return S.CoordinatedAssaultz:Cast()
end

if RubimRH.QueuedSpell():IsReadyQueue() and S.CoordinatedAssault:ID() ~= RubimRH.queuedSpell[1]:ID() and S.DeathChakram:ID() ~= RubimRH.queuedSpell[1]:ID() then
    return RubimRH.QueuedSpell():Cast()
end
--------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------Interrupts & Tranq-----------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
if S.Muzzle:IsReadyQueue() and notInterruptible == false and Target:CastPercentage() > math.random(43,87) and RubimRH.InterruptsON() and Target:AffectingCombat() then
	return S.Muzzle:Cast()
end
--------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------Cooldowns-------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
if Player:AffectingCombat() and Pet:IsActive() and Player:CanAttack(Target) and TargetinRange(38) then
	-- if S.Exhilaration:IsCastable() and Player:AffectingCombat() and Player:HealthPercentage() <= 35 then
		-- return S.Exhilaration:Cast()
	-- end

	-- if Player:HealthPercentage() <= 25 and Player:AffectingCombat() and IsUsableItem(187802) and GetItemCooldown(187802) == 0 and GetItemCount(187802) >= 1 and (not Player:InArena() and not Player:InBattlegrounds()) then
		-- return I.healingpoticon:Cast()
	-- end

    if trinket1ready and RubimRH.CDsON() then
        return I.tx1:Cast()
    end
	
    if trinket2ready and RubimRH.CDsON() then
        return I.tx2:Cast()
    end
end
--------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------Rotation--------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
if Player:AffectingCombat() and Pet:IsActive() and Player:CanAttack(Target) then

	if not IsCurrentSpell(6603) and TargetinRange(38) then
		return S.autoattack:Cast()
	end

	if S.Harpoon:IsReady() and TargetinRange(38) and S.TermsofEngagement:IsAvailable() and Player:Focus() < 60 then
		return S.Harpoon:Cast()
	end

	if ST() and RangeCount(38) < 3 then
		return ST()
	end

	if Cleave() and RangeCount(38) > 2 then
		return Cleave()
	end

end
    return 0, "Interface\\Addons\\Rubim-RH\\Media\\mount2.tga"
end

RubimRH.Rotation.SetAPL(255, APL);

local function PASSIVE()

end

RubimRH.Rotation.SetPASSIVE(255, PASSIVE);
