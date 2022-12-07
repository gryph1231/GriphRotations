--- Localize Vars
-- Addon
local addonName, addonTable = ...;
-- HeroLib
local HL = HeroLib;
local Cache = HeroCache;
local Unit = HL.Unit;
local Player = Unit.Player;
local Pet = Unit.Pet;
local Focus = Unit.Focus;
local Nameplate = Unit.Nameplate;
local Target = Unit.Target;
local Spell = HL.Spell;
local Item = HL.Item;
local mainAddon = RubimRH

-- Spells
RubimRH.Spell[253] = {
    ArcaneTorrent = Spell(80483),
    AncestralCall = Spell(274738),
    Berserking = Spell(26297),
    BerserkingBuff = Spell(26297),
    BloodFury = Spell(20572),
    BloodFuryBuff = Spell(20572),
    SpiritMendz = Spell(28880), --gift of naaru
    LightsJudgment = Spell(255647),
    Shadowmeld = Spell(58984),
    CallPet = Spell(883),
    MendPet = Spell(136),
    RevivePet = Spell(982),
	Dashz = Spell(287712), --haymaker
    AspectoftheWild = Spell(193530),
	WildSpirits = Spell(328231),
    BarbedShot = Spell(217200),
    Frenzy = Spell(272790),
    BeastCleaveBuff = Spell(268877),
    BestialWrath = Spell(19574),
    CobraShot = Spell(193455),
	KillShot = Spell(53351),
    KillCommand = Spell(34026),
    ResonatingArrow = Spell(308491),
    Multishot = Spell(2643),
    AMurderofCrows = Spell(131894),
    AnimalCompanion = Spell(267116),
    AspectoftheBeast = Spell(191384),
    Barrage = Spell(120360),
	FortitudeoftheBear = Spell(388035),
	FortitudeoftheBearz = Spell(291944), --regeneration
    BindingShot = Spell(109248),
    ChimaeraShot = Spell(53209),
    WailingArrow = Spell(392060),
    WailingArrowz = Spell(274738), --ancestral call
    WildCall = Spell(185789),
    DireBeast = Spell(120679),
    WildInstincts = Spell(378442),
    CalloftheWild = Spell(361582),
    KillerInstinct = Spell(273887),
    OnewiththePack = Spell(199528),
    ScentofBlood = Spell(193532),
    SpittingCobra = Spell(194407),
    Stampede = Spell(201430),
    ThrilloftheHunt = Spell(257944),
    VenomousBite = Spell(257891),
	Trinkz = Spell(265221), --fireblood
	StunGrenadeBuff = Spell(165534),
    AspectoftheTurtle = Spell(186265),
    Exhilaration = Spell(109304),
    AspectoftheCheetah = Spell(186257),
    CounterShot = Spell(147362),
    TranqShot = Spell(19801),
    Disengage = Spell(781),
    FreezingTrap = Spell(187650),
    FreezingTrapz = Spell(255654), --bullrush
    FeignDeath = Spell(5384),
    TarTrap = Spell(187698),
    ConcusiveShot = Spell(5116),
    Intimidation = Spell(19577),
	BloodBolt = Spell(288962),
	SoulShape = Spell(310143),
	foodanddrink = Spell(308433),
	AlphaPredator = Spell(269737),
	Flare = Spell(1543),
	KillCleave = Spell(378207),
	DeathChakram = Spell(375891),
	DeathChakramz = Spell(260364), --arcane pulse
}
local S = RubimRH.Spell[253]

if not Item.Hunter then Item.Hunter = {}; end

Item.Hunter.BeastMastery = {
healingpoticon = Item(169451)
};
local I = Item.Hunter.BeastMastery;

local function bool(val)
    return val ~= 0
end

local function PetActive()
local petActive = false

    if Pet:Exists() then
        petActive = true
    end

    if Pet:IsActive() then
        petActive = true
    end

    if Pet:IsDeadOrGhost() then
        petActive = false
    end

    return petActive
end

function IsDummy(NPCID)

	if NPCID then
		GUID = UnitGUID(NPCID)
		if GUID then
			local Type, _, _, _, _, UnitIDzFromGUID = strsplit('-', GUID)
			UnitIDz = tonumber(UnitIDzFromGUID)
		end
	end
	
	if GUID and (UnitIDz == 31146 or UnitIDz == 31144 or UnitIDz == 32666 or UnitIDz == 32667 or UnitIDz == 46647 or UnitIDz == 114832 or UnitIDz == 153292
	or UnitIDz == 67127 or UnitIDz == 87317 or UnitIDz == 87318 or UnitIDz == 87320 or UnitIDz == 88314 or UnitIDz == 88316 or UnitIDz == 87760
	or UnitIDz == 29310 or UnitIDz == 29308 or UnitIDz == 27483 or UnitIDz == 26632 or UnitIDz == 26630 or UnitIDz == 31134 or UnitIDz == 29266 
	or UnitIDz == 87761 or UnitIDz == 87762 or UnitIDz == 88288 or UnitIDz == 88289 or UnitIDz == 113964 or UnitIDz == 113966 or UnitIDz == 103397
	or UnitIDz == 103404 or UnitIDz == 103402 or UnitIDz == 107555 or UnitIDz == 107556 or UnitIDz == 92164 or UnitIDz == 92165 or UnitIDz == 92166
	or UnitIDz == 101956 or UnitIDz == 102045 or UnitIDz == 102048 or UnitIDz == 102052 or UnitIDz == 144081 or UnitIDz == 144082 or UnitIDz == 144085 
	or UnitIDz == 144086 or UnitIDz == 126781 or UnitIDz == 131983 or UnitIDz == 131989 or UnitIDz == 131992 or UnitIDz == 154564 or UnitIDz == 154567
	or UnitIDz == 154580 or UnitIDz == 154583 or UnitIDz == 154585 or UnitIDz == 154586 or UnitIDz == 160325 or UnitIDz == 173942 or UnitIDz == 175449
	or UnitIDz == 175450 or UnitIDz == 175451 or UnitIDz == 175452 or UnitIDz == 175455 or UnitIDz == 175456 or UnitIDz == 175462 or UnitIDz == 174565
	or UnitIDz == 174566 or UnitIDz == 174567 or UnitIDz == 174568 or UnitIDz == 174569 or UnitIDz == 174570 or UnitIDz == 174571 or UnitIDz == 174484
	or UnitIDz == 174487 or UnitIDz == 174488 or UnitIDz == 174491 or UnitIDz == 65310) then
		return true
	else
		return false
	end

end

local function allMobsinRange(range)
local totalRange40 = 0
local allMobsinRange = false

	for id = 1, 40 do
		local unitID = "nameplate" .. id
		local x = UnitName(unitID)
			if x then
				name = x:sub(-5)
			end
		if UnitCanAttack("player",unitID) and (UnitAffectingCombat(unitID) or IsDummy(unitID)) and UnitHealthMax(unitID) > 5 then
			totalRange40 = totalRange40 + 1
		end
    end

	if range == totalRange40 and totalRange40 >= 1 then
		allMobsinRange = true
	else
		allMobsinRange = false
	end

	return allMobsinRange
	
end

local function CleaveCount()
local cleave_counter = 0
     
        for i=1,40 do
			local unitID = "nameplate" .. i
            if UnitExists("nameplate"..i) then           
                local nameplate_guid = UnitGUID("nameplate"..i) 
                local npc_id = select(6, strsplit("-",nameplate_guid))
                if npc_id ~='120651' and npc_id ~='161895' then
                    if UnitCanAttack("player",unitID) and IsActionInRange(37,unitID) and UnitHealthMax(unitID) > 5 then
                        cleave_counter = cleave_counter + 1
                    end                    
                end
            end
        end
    
    return cleave_counter
end

local function KCRange()
local check = false

--25y from pet, 25y from target
if IsActionInRange(39,"player") and IsItemInRange(24268,"target") then
	check = true
--10y from pet, 40y from target
elseif IsItemInRange(32321,"pet") and IsItemInRange(28767,"target") then
	check = true
--5y from pet, 45y from target
elseif IsItemInRange(37727,"pet") and IsItemInRange(32698,"target") then
	check = true
--40y from pet, 10y from target
elseif IsItemInRange(34471,"pet") and IsItemInRange(32321,"target") then
	check = true
--45y from pet, 5y from target
elseif IsItemInRange(32698,"pet") and IsItemInRange(37727,"target") then
	check = true
--pet 30y from target
elseif IsActionInRange(38,"target") then
	check = true
end

	return check
end

local function APL()
CleaveCount()
allMobsinRange()
KCRange()
IsDummy()
HL.GetEnemies(25, true);
--------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------Functions/Top priorities----------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
if Player:IsCasting() or Player:IsChanneling() then
	return 0, "Interface\\Addons\\Rubim-RH\\Media\\channel.tga"
elseif Player:IsDeadOrGhost() or AuraUtil.FindAuraByName("Drink", "player") or AuraUtil.FindAuraByName("Food", "player") 
or AuraUtil.FindAuraByName("Food & Drink", "player") or AuraUtil.FindAuraByName("Feign Death", "player") then
	return 0, "Interface\\Addons\\Rubim-RH\\Media\\mount2.tga"
end 

tolerance = select(4, GetNetStats())/1000 + 0.2
local name, text, texture, startTimeMS, endTimeMS, isTradeSkill, castID, notInterruptible, spellId = UnitCastingInfo("target")

--CHANGE TO 12 WHEN NOT USING BLOODLETTING CONDUIT
BarbRechargeTime = 11 / (1 + GetHaste('player')/100)

start, duration, enabled = GetSpellCooldown(388035);
FortoftheBearCD = duration - (GetTime() - start)

if FortoftheBearCD < 0 then 
	FortoftheBearCD = 0
end

start, duration, enabled = GetSpellCooldown(90361);
SpiritMendCD = duration - (GetTime() - start)

if SpiritMendCD < 0 then 
	SpiritMendCD = 0
end

start, duration, enabled = GetSpellCooldown(61684);
DashCD = duration - (GetTime() - start)

if DashCD < 0 then 
	DashCD = 0
end

--print("FRENZY: ", Pet:BuffRemains(S.Frenzy),"   GCD: ",Player:GCD())
--print(math.abs(Pet:BuffRemains(S.Frenzy) - Player:BuffRemainsP(S.BeastCleaveBuff)))
--------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------Out of Combat---------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
if not Player:AffectingCombat() then
	-- if S.MendPet:IsCastable() and Pet:IsActive() and Cache.EnemiesCount[25] == 0 and Pet:HealthPercentage() > 0 and Pet:HealthPercentage() <= 85 and not Pet:Buff(S.MendPet) then
		-- return S.MendPet:Cast()
	-- end
end
--------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------Spell Queue-----------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
if (not RubimRH.queuedSpell[1]:CooldownUp() and (S.BestialWrath:ID() ~= RubimRH.queuedSpell[1]:ID() or S.BestialWrath:CooldownRemainsP() > (12 + Player:GCD()) * S.BarbedShot:ChargesP()))
or (S.BestialWrath:ID() == RubimRH.queuedSpell[1]:ID() and not Player:CanAttack(Target)) 
or (S.WailingArrow:ID() == RubimRH.queuedSpell[1]:ID() and Player:IsMoving()) or not Player:AffectingCombat() then
	RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
end

if S.WailingArrow:ID() == RubimRH.queuedSpell[1]:ID() then
	return S.WailingArrowz:Cast()
end

if S.FreezingTrap:ID() == RubimRH.queuedSpell[1]:ID() then
	return S.FreezingTrapz:Cast()
end

if RubimRH.QueuedSpell():IsReadyQueue() and S.BestialWrath:ID() ~= RubimRH.queuedSpell[1]:ID() and S.ResonatingArrow:ID() ~= RubimRH.queuedSpell[1]:ID() 
and S.DeathChakram:ID() ~= RubimRH.queuedSpell[1]:ID() and S.FreezingTrap:ID() ~= RubimRH.queuedSpell[1]:ID() then
    return RubimRH.QueuedSpell():Cast()
end

-- if S.BestialWrath:IsCastableQueue()
-- and (S.BestialWrath:ID() == RubimRH.queuedSpell[1]:ID() or RubimRH.CDsON()) 
-- and (CleaveCount() == 1 or Player:BuffRemainsP(S.BeastCleaveBuff) > Player:GCD() * 1.25)
-- and (S.BarbedShot:ChargesFractional() < 1 or not S.ScentofBlood:IsAvailable()) then
	-- return S.BestialWrath:Cast()
-- end
--------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------Interrupts & Tranq-----------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
if S.CounterShot:IsReadyQueue() and notInterruptible == false and Target:CastPercentage() > math.random(43,87) and RubimRH.InterruptsON() and Target:AffectingCombat() then
	return S.CounterShot:Cast()
end

if (select(4, UnitAura("target", 1)) == "enrage"
or AuraUtil.FindAuraByName("Undying Rage", "target") 
or AuraUtil.FindAuraByName("Enrage", "target") 
or AuraUtil.FindAuraByName("Unholy Frenzy", "target")
or AuraUtil.FindAuraByName("Angering Shriek", "target")
or AuraUtil.FindAuraByName("Loyal Beasts", "target")
or AuraUtil.FindAuraByName("Frenzy", "target")
or AuraUtil.FindAuraByName("Motivational Clubbing", "target")
or AuraUtil.FindAuraByName("Motivated", "target")
or AuraUtil.FindAuraByName("Seething Rage", "target")
or AuraUtil.FindAuraByName("Vengeful Rage", "target")
or AuraUtil.FindAuraByName("Raging Tantrum", "target")
or AuraUtil.FindAuraByName("Death Wish", "target")
or AuraUtil.FindAuraByName("Battle Trance", "target")) 
and RubimRH.InterruptsON() and S.TranqShot:IsReady() and Target:AffectingCombat() and Target:TimeToDie() > 4 then
	return S.TranqShot:Cast()
end
--------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------Cooldowns-------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
if IsSpellKnown(90361, true) and SpiritMendCD == 0 and IsActionInRange(39,"player") and Player:HealthPercentage() <= 85 then
	return S.SpiritMendz:Cast()
end

if S.Exhilaration:IsCastable() and Player:AffectingCombat() and Player:HealthPercentage() <= 35 then
	return S.Exhilaration:Cast()
end

if IsSpellKnown(388035, true) and FortoftheBearCD == 0 and Player:HealthPercentage() <= 30 then
	return S.FortitudeoftheBearz:Cast()
end

if Player:HealthPercentage() <= 25 and Player:AffectingCombat() and IsUsableItem(191380) and GetItemCooldown(191380) == 0 and GetItemCount(191380) >= 1 
and (not Player:InArena() and not Player:InBattlegrounds()) then
    return I.healingpoticon:Cast()
end
--------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------Rotation--------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
if Player:AffectingCombat() and Pet:IsActive() and Player:CanAttack(Target) and Target:IsInRange(40) then

	if IsSpellKnown(61684, true) and DashCD == 0 and not IsActionInRange(37,"target") and S.KillCommand:TimeSinceLastCast() > Player:GCD() then
		return S.Dashz:Cast()
	end

	if CleaveCount() >= 2 and RubimRH.AoEON() then
		if S.BarbedShot:IsReadyQueue(40) and Pet:Buff(S.Frenzy) and Pet:BuffRemains(S.Frenzy) - Player:GCD() < tolerance then
			return S.BarbedShot:Cast()
		end
	
		if Pet:Buff(S.Frenzy) and S.BarbedShot:CooldownRemainsP() < Pet:BuffRemains(S.Frenzy) and Pet:BuffRemains(S.Frenzy) <= Player:GCD() + tolerance then
			return 0, "Interface\\Addons\\Rubim-RH\\Media\\mount2.tga"
		end
	
		if S.Multishot:IsReadyQueue(40) and Player:GCD() - Player:BuffRemainsP(S.BeastCleaveBuff) > 0.25 then
			return S.Multishot:Cast()
		end
		
		if S.BarbedShot:IsReadyQueue(40) and (S.BarbedShot:FullRechargeTimeP() < Player:GCD()
		or ((RubimRH.CDsON() or S.BestialWrath:ID() == RubimRH.queuedSpell[1]:ID()) and S.BestialWrath:CooldownRemainsP() <= (12 + Player:GCD()) * S.BarbedShot:ChargesP())) then
			return S.BarbedShot:Cast()
		end

		-- if S.KillCommand:IsReadyQueue(50) and KCRange() and S.KillCommand:FullRechargeTimeP() <= Player:GCD() and S.AlphaPredator:IsAvailable() and S.KillCleave:IsAvailable() then
			-- return S.KillCommand:Cast()
		-- end

		if S.DeathChakram:IsReadyQueue(40) and (RubimRH.CDsON() or S.DeathChakram:ID() == RubimRH.queuedSpell[1]:ID()) then
			return S.DeathChakramz:Cast()
		end

		if S.BestialWrath:IsCastableQueue() and (RubimRH.CDsON() or S.BestialWrath:ID() == RubimRH.queuedSpell[1]:ID()) then
			return S.BestialWrath:Cast()
		end

		if S.KillCommand:IsReadyQueue(50) and KCRange() then
			return S.KillCommand:Cast()
		end
		
		if S.KillShot:IsReadyQueue(40) then
			return S.KillShot:Cast()
		end
		
		if S.CobraShot:IsReadyQueue(40) and Player:FocusTimeToMaxPredicted() < Player:GCD() * 2 then
			return S.CobraShot:Cast()
		end
	
	elseif CleaveCount() < 2 or not RubimRH.AoEON() then
		if S.BarbedShot:IsReadyQueue(40) and ((Pet:Buff(S.Frenzy) and Pet:BuffRemains(S.Frenzy) - Player:GCD() < tolerance) 
		or (Pet:BuffStack(S.Frenzy) < 3 and S.BestialWrath:CooldownUp() and (RubimRH.CDsON() or S.BestialWrath:ID() == RubimRH.queuedSpell[1]:ID()))) then
			return S.BarbedShot:Cast()
		end

		if Pet:Buff(S.Frenzy) and S.BarbedShot:CooldownRemainsP() < Pet:BuffRemains(S.Frenzy) and Pet:BuffRemains(S.Frenzy) <= Player:GCD() + tolerance then
			return 0, "Interface\\Addons\\Rubim-RH\\Media\\mount2.tga"
		end

		-- if S.KillCommand:IsReadyQueue(50) and KCRange() and S.KillCommand:FullRechargeTimeP() <= Player:GCD() and S.AlphaPredator:IsAvailable() then
			-- return S.KillCommand:Cast()
		-- end
	
		if S.DeathChakram:IsReadyQueue(40) and (RubimRH.CDsON() or S.DeathChakram:ID() == RubimRH.queuedSpell[1]:ID()) then
			return S.DeathChakramz:Cast()
		end
	
		if S.BestialWrath:IsCastableQueue() and (RubimRH.CDsON() or S.BestialWrath:ID() == RubimRH.queuedSpell[1]:ID()) then
			return S.BestialWrath:Cast()
		end
		
		if S.KillCommand:IsReadyQueue(50) and KCRange() then
			return S.KillCommand:Cast()
		end

		if S.BarbedShot:IsReadyQueue(40) and ((S.WildInstincts:IsAvailable() and Player:BuffP(S.CalloftheWild)) or S.BarbedShot:FullRechargeTimeP() < Player:GCD()
		or (S.ScentofBlood:IsAvailable() and S.BestialWrath:CooldownRemainsP() <= (12 + Player:GCD()) * S.BarbedShot:ChargesP() and (RubimRH.CDsON() or S.BestialWrath:ID() == RubimRH.queuedSpell[1]:ID()))) then
			return S.BarbedShot:Cast()
		end

		if S.KillShot:IsReadyQueue(40) then
			return S.KillShot:Cast()
		end

		if S.CobraShot:IsReadyQueue(40) and (Player:Focus() - S.CobraShot:Cost() + Player:FocusRegen() * (S.KillCommand:CooldownRemainsP() - 1) > S.KillCommand:Cost() or S.KillCommand:CooldownRemainsP() > 1 + Player:GCD()) or Player:BuffP(S.BestialWrath) then
			return S.CobraShot:Cast()
		end	
	end
end
    return 0, "Interface\\Addons\\Rubim-RH\\Media\\mount2.tga"
end

RubimRH.Rotation.SetAPL(253, APL);

local function PASSIVE()

end

RubimRH.Rotation.SetPASSIVE(253, PASSIVE);