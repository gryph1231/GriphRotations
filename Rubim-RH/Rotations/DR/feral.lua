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

--- ============================ CONTENT ===========================
--- ======= APL LOCALS =======
-- luacheck: max_line_length 9999

-- Spells
RubimRH.Spell[103] = {
    Regrowth = Spell(8936),
    CatForm = Spell(768),
    BearForm = Spell(5487),
    Prowl = Spell(5215),
    IncarnationBuff = Spell(102543),
    JungleStalkerBuff = Spell(252071),
    Berserk = Spell(106951),
    TigersFury = Spell(5217),
    Berserking = Spell(26297),
    FeralFrenzy = Spell(274837),
    Incarnation = Spell(102543),
    Shadowmeld = Spell(58984),
    Rake = Spell(1822),
    TravelForm = Spell(783),
    RakeDebuff = Spell(155722),
    ShadowmeldBuff = Spell(58984),
    FerociousBite = Spell(22568),
    PredatorySwiftness = Spell(69369),
    ApexPredatorBuff = Spell(252752),
    MomentofClarity = Spell(236068),
    SavageRoar = Spell(52610),
    SavageRoarBuff = Spell(52610),
    Rip = Spell(1079),
    FerociousBiteMaxEnergy = Spell(22568),
    BrutalSlash = Spell(202028),
    Thrash = Spell(106830),
    MoonfireCat = Spell(155625),
    Clearcasting = Spell(135700),
    SwipeCat = Spell(106785),
    StampedingRoar = Spell(77764),
    Shred = Spell(5221),
    Rebirth = Spell(20484),
    EntanglingRoots = Spell(339),
    LunarInspiration = Spell(155580),
    MoonfireCatDebuff = Spell(155625),
    Sabertooth = Spell(391722),
    PoweroftheMoon = Spell(273389),
    PrimalWrath = Spell(285381),
	Typhoon = Spell(132469),
	MightyBash = Spell(5211),
	Maim = Spell(22570),	
	ApexBuff = Spell(391882),	
	SkullBash = Spell(106839),
    IronJawsBuff = Spell(276026),
	WildChargeCat = Spell(102401),
	SurvivalInstincts = Spell(61336),
	Thorns = Spell(467),
	MarkOfTheWild = Spell(1126),
	MarkOfTheWildz = Spell(58984), --shadowmeld
	Soothe = Spell(2908),
	Vortex = Spell(102793),
	Vortexz = Spell(68992), --darkflight
    Convoke = Spell(391528),
    Bloodtalons = Spell(319439),
    BloodtalonsBuff = Spell(145152),
    SoulOfTheForest = Spell(158476),
	StartAttack = Spell(287712), --haymaker
};
local S = RubimRH.Spell[103];

-- Items
if not Item.Druid then
    Item.Druid = {}
end

Item.Druid.Feral = {
};
local I = Item.Druid.Feral;

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

local function BloodTalonTriggers()
local a = 0
local b = 0
local c = 0
local d = 0

	for id = 1, 40 do
		if S.Shred:TimeSinceLastCast() < 4 then
			a = 1
		end
		
		if S.Rake:TimeSinceLastCast() < 4 then
			b = 1
		end
		
		if S.BrutalSlash:TimeSinceLastCast() < 4 then
			c = 1
		end
		
		if S.Thrash:TimeSinceLastCast() < 4 then
			d = 1
		end
    end

	return a + b + c + d
end

local function ShredBT()
local check = false

	if S.Shred:TimeSinceLastCast() < 4 then
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

local function ThrashRefreshable()
local ThrashRefreshable10 = 0
local MissingThrash10 = 0

    for id = 1, 40 do
		local unitID = "nameplate" .. id
		local _,_,_,_,_,expirationTime = AuraUtil.FindAuraByName("Thrash",unitID,"PLAYER|HARMFUL")
		
		if AuraUtil.FindAuraByName("Thrash",unitID,"PLAYER|HARMFUL") then
			timer = expirationTime - HL.GetTime()
		else
			timer = nil
		end

		if timer then 
			if UnitCanAttack("player", unitID) and IsItemInRange(34368, unitID) and timer <= 4 then
				ThrashRefreshable10 = ThrashRefreshable10 + 1
			end
		end
		
		if UnitCanAttack("player", unitID) and IsItemInRange(34368, unitID) and not AuraUtil.FindAuraByName("Thrash",unitID,"PLAYER|HARMFUL") then
			MissingThrash10 = MissingThrash10 + 1
		end
	end

	return ThrashRefreshable10 + MissingThrash10
end

local function APL()
BloodTalonTriggers()
ShredBT()
RakeBT()
BrutalSlashBT()
ThrashBT()
ThrashRefreshable()
HL.GetEnemies(10, true);
HL.GetEnemies(12, true);
HL.GetEnemies(20, true);
HL.GetEnemies(25, true);
HL.GetEnemies(30, true);
--------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------Functions/Top priorities----------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
if Player:IsCasting() or Player:IsChanneling() then
	return 0, "Interface\\Addons\\Rubim-RH\\Media\\channel.tga"
elseif Player:IsDeadOrGhost() or AuraUtil.FindAuraByName("Drink", "player") or AuraUtil.FindAuraByName("Food", "player") 
or AuraUtil.FindAuraByName("Food & Drink", "player") or Player:BuffP(S.Prowl) or Player:BuffP(S.TravelForm) then
	return 0, "Interface\\Addons\\Rubim-RH\\Media\\mount2.tga"
end 

local name, text, texture, startTimeMS, endTimeMS, isTradeSkill, castID, notInterruptible, spellId = UnitCastingInfo("target")
--------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------Out of Combat---------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
if not Player:AffectingCombat() then
    if S.Prowl:IsCastable() and not Player:Buff(S.Prowl) and Player:Buff(S.CatForm) then
		return S.Prowl:Cast()
    end

    if S.MarkOfTheWild:IsCastable() and not AuraUtil.FindAuraByName("Mark of the Wild", "player") then
		return S.MarkOfTheWildz:Cast()
    end
end
--------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------Spell Queue-----------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
if not RubimRH.queuedSpell[1]:CooldownUp() or not Player:AffectingCombat() 
or (S.CatForm:ID() == RubimRH.queuedSpell[1]:ID() and Player:BuffP(S.CatForm))
or (S.BearForm:ID() == RubimRH.queuedSpell[1]:ID() and Player:BuffP(S.BearForm))
or (S.EntanglingRoots:ID() == RubimRH.queuedSpell[1]:ID() and Player:PrevGCD(1, S.EntanglingRoots)) then
	RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
end

if S.CatForm:ID() == RubimRH.queuedSpell[1]:ID() then
	return S.CatForm:Cast()
end

if S.BearForm:ID() == RubimRH.queuedSpell[1]:ID() then
	return S.BearForm:Cast()
end

if S.Convoke:ID() == RubimRH.queuedSpell[1]:ID() then
	return S.Convoke:Cast()
end

if S.Soothe:ID() == RubimRH.queuedSpell[1]:ID() then
	return S.Soothe:Cast()
end

if S.Vortex:ID() == RubimRH.queuedSpell[1]:ID() then
	return S.Vortexz:Cast()
end

if S.Berserk:ID() == RubimRH.queuedSpell[1]:ID() then
	return S.Berserk:Cast()
end

if S.MightyBash:ID() == RubimRH.queuedSpell[1]:ID() then
	return S.MightyBash:Cast()
end

if S.StampedingRoar:ID() == RubimRH.queuedSpell[1]:ID() then
	return S.StampedingRoar:Cast()
end

if S.TigersFury:ID() == RubimRH.queuedSpell[1]:ID() then
	return S.TigersFury:Cast()
end

if S.EntanglingRoots:ID() == RubimRH.queuedSpell[1]:ID() then
	return S.EntanglingRoots:Cast()
end

if S.Rebirth:ID() == RubimRH.queuedSpell[1]:ID() then
	return S.Rebirth:Cast()
end
--------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------Interrupts & Tranq-----------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
if S.SkullBash:IsReady(5) and notInterruptible == false and Target:CastPercentage() > math.random(37,81) and RubimRH.InterruptsON() and Target:AffectingCombat() then
	return S.SkullBash:Cast()
end
--------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------Cooldowns-------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
if S.Regrowth:IsCastable() and Player:BuffP(S.PredatorySwiftness) and Player:HealthPercentage() <= 85 and Cache.EnemiesCount[25] == 0 then
	return S.Regrowth:Cast()
end
--------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------Rotation--------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
if S.CatForm:IsCastable() and not Player:BuffP(S.CatForm) and not Player:BuffP(S.BearForm) then
	return S.CatForm:Cast()
end

if Player:BuffP(S.CatForm) and Player:AffectingCombat() then
--cds
-- if not IsCurrentSpell(6603) and not Player:BuffP(S.Prowl) and Player:CanAttack(Target) and Target:AffectingCombat() and Target:IsInRange(20) then
	-- return S.autoattack:Cast()
-- end	

if S.TigersFury:IsReady(10) and Player:EnergyDeficit() >= 50 then
	return S.TigersFury:Cast()
end

if S.Convoke:IsReady(10) and RubimRH.CDsON() and Player:BuffP(S.TigersFury) and Player:ComboPoints() < 3 then
	return S.Convoke:Cast()
end

if S.Berserk:IsReady(10) and RubimRH.CDsON() then
	return S.Berserk:Cast()
end

--aoe
if Cache.EnemiesCount[10] >= 2 and RubimRH.AoEON() then
	
	if S.PrimalWrath:IsReady(10) and Player:ComboPoints() >= 5 and (Player:EnergyTimeToMaxPredicted() <= Player:GCD() * 2 or Player:BuffP(S.Clearcasting)) then
		return S.PrimalWrath:Cast()
	end
	
	if S.FerociousBite:IsReady(10) and Player:BuffP(S.ApexBuff) and not Player:BuffP(S.Sabertooth) then
		return S.FerociousBite:Cast()
	end
	
	if S.Bloodtalons:IsAvailable() and not Player:BuffP(S.BloodtalonsBuff) and BloodTalonTriggers() >= 1 and Player:ComboPointsDeficit() >= 3 - BloodTalonTriggers() then
		if S.Rake:IsReady(10) and not RakeBT() and (not Target:DebuffP(S.RakeDebuff) or Target:DebuffRemainsP(S.RakeDebuff) < 4) then
			return S.Rake:Cast()
		elseif S.BrutalSlash:IsCastable() and not BrutalSlashBT() then
			return S.BrutalSlash:Cast()
		elseif S.Thrash:IsReadyMorph(10) and not ThrashBT() and ThrashRefreshable() >= 1 then
			return S.Thrash:Cast()
		elseif S.Shred:IsReady(10) and not ShredBT() then
			return S.Shred:Cast()
		elseif S.Thrash:IsReadyMorph(10) and not ThrashBT then
			return S.Thrash:Cast()
		elseif S.Rake:IsReady(10) and not RakeBT() and Player:ComboPoints() > 4 then
			return S.Rake:Cast()
		end
	end

	if Player:EnergyTimeToMaxPredicted() <= Player:GCD() * 2 or Player:BuffP(S.Clearcasting) then
		if S.Thrash:IsReadyMorph(10) and ThrashRefreshable() >= 1 then
			return S.Thrash:Cast()
		end

		if S.BrutalSlash:IsCastable() then
			return S.BrutalSlash:Cast()
		end

		if S.Rake:IsReady(10) and (not Target:DebuffP(S.RakeDebuff) or Target:DebuffRemainsP(S.RakeDebuff) < 4) then
			return S.Rake:Cast()
		end
		
		if Cache.EnemiesCount[10] <= 5 then
			if S.Shred:IsReady(10) then
				return S.Shred:Cast()
			end
		elseif Cache.EnemiesCount[10] > 5 then
			if S.Thrash:IsReadyMorph(10) then
				return S.Thrash:Cast()
			end
		end
	end
end
	
--apex proc
	if S.FerociousBite:IsReady(10) and Player:BuffP(S.ApexBuff) then
		return S.FerociousBite:Cast()
	end

--bloodtalons
	if S.Bloodtalons:IsAvailable() and not Player:BuffP(S.BloodtalonsBuff) and BloodTalonTriggers() >= 1 and Player:ComboPointsDeficit() >= 3 - BloodTalonTriggers() then
		if S.Rake:IsReady(10) and not RakeBT() and (not Target:DebuffP(S.RakeDebuff) or Target:DebuffRemainsP(S.RakeDebuff) < 4) then
			return S.Rake:Cast()
		elseif S.BrutalSlash:IsCastable() and not BrutalSlashBT() then
			return S.BrutalSlash:Cast()
		elseif S.Thrash:IsReadyMorph(10) and not ThrashBT() and ThrashRefreshable() >= 1 then
			return S.Thrash:Cast()
		elseif S.Shred:IsReady(10) and not ShredBT() then
			return S.Shred:Cast()
		elseif S.Thrash:IsReadyMorph(10) and not ThrashBT then
			return S.Thrash:Cast()
		elseif S.Rake:IsReady(10) and not RakeBT() and Player:ComboPoints() > 4 then
			return S.Rake:Cast()
		end
	end
	
--finisher
	if Player:ComboPoints() == 5 and (Cache.EnemiesCount[10] < 2 or not RubimRH.AoEON()) then
		if S.Rip:IsReady(10) and Target:DebuffRemainsP(S.Rip) < 7 then
			return S.Rip:Cast()
		end
	
		if S.FerociousBite:IsReady(10) and (Player:EnergyTimeToMaxPredicted() <= Player:GCD() * 2 or (Player:Energy() > 50 and S.TigersFury:CooldownUp())) and not Player:BuffP(S.Berserk) or (Player:BuffP(S.Berserk) and not S.SoulOfTheForest:IsAvailable()) then
			return S.FerociousBite:Cast()
		end
		
		if S.FerociousBite:IsReady(10) and Player:BuffP(S.Berserk) and S.SoulOfTheForest:IsAvailable() then
			return S.FerociousBite:Cast()
		end
	end
	
--berserk builder
	if Player:ComboPoints() < 5 and Player:BuffP(S.Berserk) then
		if S.Rake:IsReady(10) and Target:DebuffRemainsP(S.RakeDebuff) < 4 then
			return S.Rake:Cast()
		end
		
		if S.BrutalSlash:IsCastable() and Cache.EnemiesCount[10] >= 1 and BloodTalonTriggers() == 2 and not BrutalSlashBT() then
			return S.BrutalSlash:Cast()
		end
	
		if S.Shred:IsReady(10) then
			return S.Shred:Cast()
		end
	end

--builder
	if Player:ComboPoints() < 5 then
		if Player:BuffP(S.Clearcasting) then
			if S.Thrash:IsReadyMorph(10) and ThrashRefreshable() >= 1 then
				return S.Thrash:Cast()
			end
			
			if S.BrutalSlash:IsCastable() and Cache.EnemiesCount[10] >= 5 and S.MomentofClarity:IsAvailable() then
				return S.BrutalSlash:Cast()
			end
			
			if S.Shred:IsReady(10) then
				return S.Shred:Cast()
			end
		end
	
		if S.Rake:IsReady(10) and Target:DebuffRemainsP(S.RakeDebuff) < 4 then
			return S.Rake:Cast()
		end
		
		if S.Thrash:IsReadyMorph(10) and ThrashRefreshable() >= 1 then
			return S.Thrash:Cast()
		end
		
		if Player:EnergyTimeToMaxPredicted() <= Player:GCD() * 2 then
			if S.BrutalSlash:IsCastable() and Cache.EnemiesCount[10] >= 1 then
				return S.BrutalSlash:Cast()
			end
			
			if S.Shred:IsReady(10) then
				return S.Shred:Cast()
			end
		end
	end
end
    return 0, "Interface\\Addons\\Rubim-RH\\Media\\mount2.tga"
end

RubimRH.Rotation.SetAPL(103, APL)

local function PASSIVE()
    return RubimRH.Shared()
end
RubimRH.Rotation.SetPASSIVE(103, PASSIVE)