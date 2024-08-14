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
    AMurderofCrows = Spell(131894),
    PheromoneBomb = Spell(270323),
    Spearhead = Spell(360966),
    Spearheadz = Spell(69070),
    VolatileBomb = Spell(271045),
    ShrapnelBomb = Spell(270335),
    ShrapnelBombDebuff = Spell(270339),
    WildfireBomb = Spell(259495),
    FeignDeath = Spell(5384),
    GuerrillaTactics = Spell(264332),
    WildfireBombDebuff = Spell(269747),
    Chakrams = Spell(259391),
    Butchery = Spell(212436),
	foodanddrink = Spell(308433),
    WildfireInfusion = Spell(271014),
    InternalBleedingDebuff = Spell(270343),
    FlankingStrike = Spell(269751),
    VipersVenomBuff = Spell(268552),
    KillShot = Spell(320976),
    TermsofEngagement = Spell(265895),
    TipoftheSpearBuff = Spell(260286),
    MongooseBiteEagle = Spell(265888),
    MongooseBite = Spell(259387),
    BirdsofPrey = Spell(260331),
    MongooseFury = Spell(259388),
    ExplosiveShot = Spell(212431),
    ExplosiveShotz = Spell(287712), --haymaker
    VipersVenom = Spell(268501),
    AspectoftheTurtle = Spell(186265),
    Exhilaration = Spell(109304),
    FreezingTrap = Spell(187650),
	FreezingTrapz = Spell(255654), --bullrush
    AspectoftheEagle = Spell(186289),
    Muzzle = Spell(187707),
    TranqShot = Spell(19801),
    DeadlyDuo = Spell(19801),
    WingClip = Spell(195645),
    LatentPoison = Spell(273284),
    LatentPoisonDebuff = Spell(378015),
    HydrasBite = Spell(260241),
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
healingpoticon = Item(169451)
};
local I = Item.Hunter.Survival;

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

-- Rotation Var
local ShouldReturn;
local EnemyRanges = { 8, 40, "Melee" }
local function UpdateRanges()
    for _, i in ipairs(EnemyRanges) do
        HL.GetEnemies(i);
    end
end

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

--- APL Main
local function APL ()
HL.GetEnemies("Melee");
HL.GetEnemies(5, true);
HL.GetEnemies(8, true);
HL.GetEnemies(10, true);
HL.GetEnemies(20, true);
HL.GetEnemies(25, true);
HL.GetEnemies(40, true);
--------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------Functions/Top priorities----------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
if Player:IsCasting() or Player:IsChanneling() then
	return 0, "Interface\\Addons\\Rubim-RH\\Media\\channel.tga"
elseif Player:IsDeadOrGhost() or AuraUtil.FindAuraByName("Drink", "player") or AuraUtil.FindAuraByName("Food", "player") 
or AuraUtil.FindAuraByName("Food & Drink", "player") or AuraUtil.FindAuraByName("Feign Death", "player") then
	return 0, "Interface\\Addons\\Rubim-RH\\Media\\mount2.tga"
end 

local name, text, texture, startTimeMS, endTimeMS, isTradeSkill, castID, notInterruptible, spellId = UnitCastingInfo("target")

start, duration, enabled = GetSpellCooldown(61684);
DashCD = duration - (GetTime() - start)

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

if RubimRH.QueuedSpell():IsReadyQueue() and S.CoordinatedAssault:ID() ~= RubimRH.queuedSpell[1]:ID() and S.DeathChakram:ID() ~= RubimRH.queuedSpell[1]:ID() then
    return RubimRH.QueuedSpell():Cast()
end
--------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------Interrupts & Tranq-----------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
if S.Muzzle:IsReadyQueue(5) and notInterruptible == false and Target:CastPercentage() > math.random(43,87) and RubimRH.InterruptsON() and Target:AffectingCombat() then
	return S.Muzzle:Cast()
end
--------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------Cooldowns-------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
if S.Exhilaration:IsCastable() and Player:AffectingCombat() and Player:HealthPercentage() <= 35 then
	return S.Exhilaration:Cast()
end

if Player:HealthPercentage() <= 25 and Player:AffectingCombat() and IsUsableItem(187802) 
and GetItemCooldown(187802) == 0 and GetItemCount(187802) >= 1 
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

	if Cache.EnemiesCount[10] >= 2 and RubimRH.AoEON() then
	
		if (S.PheromoneBomb:IsReadyMorph(10) or S.ShrapnelBomb:IsReadyMorph(10) or S.VolatileBomb:IsReadyMorph(10))
		and S.WildfireBomb:FullRechargeTimeP() < Player:GCD() then
			return S.WildfireBomb:Cast()
		end
		
		if S.Spearhead:IsReadyQueue(40) and RubimRH.CDsON() and Target:DebuffP(S.DeathChakramDebuff) then
			return S.Spearheadz:Cast()
		end
		
		if S.DeathChakram:IsReadyQueue(40) and (RubimRH.CDsON() or S.DeathChakram:ID() == RubimRH.queuedSpell[1]:ID()) then
			return S.DeathChakramz:Cast()
		end
		
		if S.CoordinatedAssault:IsReadyQueue(8) and (RubimRH.CDsON() or S.CoordinatedAssault:ID() == RubimRH.queuedSpell[1]:ID()) then
			return S.CoordinatedAssaultz:Cast()
		end
		
		if S.KillShot:IsReadyQueue(40) and Player:BuffP(S.CoordinatedAssault) then
			return S.KillShot:Cast()
		end
		
		if S.ExplosiveShot:IsReadyQueue(40) then
			return S.ExplosiveShotz:Cast()
		end
		
		if S.Butchery:IsCastableQueue() and Player:Focus() >= 30 and S.Butchery:FullRechargeTimeP() < Player:GCD() then
			return S.Butchery:Cast()
		end
		
		if (S.PheromoneBomb:IsReadyMorph(10) or S.ShrapnelBomb:IsReadyMorph(10) or S.VolatileBomb:IsReadyMorph(10)) then
			return S.WildfireBomb:Cast()
		end

		if S.Butchery:IsCastableQueue() and Player:Focus() >= 30 and (Target:DebuffP(S.ShrapnelBombDebuff) or S.WildfireBomb:FullRechargeTimeP() > 5) then
			return S.Butchery:Cast()
		end

		if S.MongooseBite:IsReadyQueue(8) and Target:DebuffStackP(S.LatentPoison) >= 8 then
			return S.MongooseBite:Cast()
		end
		
		if S.KillCommand:IsReadyQueue(50) and Player:Focus() < 60 and S.KillCommand:FullRechargeTimeP() < Player:GCD() then
			return S.KillCommand:Cast()
		end
		
		if S.KillShot:IsReadyQueue(40) then
			return S.KillShot:Cast()
		end
		
		if S.MongooseBite:IsReadyQueue(8) then
			return S.MongooseBite:Cast()
		end

	elseif Cache.EnemiesCount[10] < 2 or not RubimRH.AoEON() then

		if S.Spearhead:IsReadyQueue(40) and RubimRH.CDsON() and Target:DebuffP(S.DeathChakramDebuff) then
			return S.Spearheadz:Cast()
		end

		if S.DeathChakram:IsReadyQueue(40) and (RubimRH.CDsON() or S.DeathChakram:ID() == RubimRH.queuedSpell[1]:ID()) then
			return S.DeathChakramz:Cast()
		end
		
		if S.KillShot:IsReadyQueue(40) and Player:BuffP(S.CoordinatedAssault) then
			return S.KillShot:Cast()
		end
		
		if S.MongooseBite:IsReadyQueue(8) and Player:BuffRemainsP(S.MongooseFury) < Player:GCD() then
			return S.MongooseBite:Cast()
		end

		if S.KillShot:IsReadyQueue(40) then
			return S.KillShot:Cast()
		end
		
		if S.FlankingStrike:IsReadyQueue(5) and Player:Focus() < 60 then
			return S.FlankingStrike:Cast()
		end
		
		if S.CoordinatedAssault:IsReadyQueue(8) and (RubimRH.CDsON() or S.CoordinatedAssault:ID() == RubimRH.queuedSpell[1]:ID()) then
			return S.CoordinatedAssaultz:Cast()
		end
		
		if S.PheromoneBomb:IsReadyMorph(10) and Player:Focus() < 43 and not Player:BuffP(S.MongooseFury) then
			return S.WildfireBomb:Cast()
		end
		
		if S.KillCommand:IsReadyQueue(50) and Player:Focus() < 71 and S.KillCommand:FullRechargeTimeP() < Player:GCD() then
			return S.KillCommand:Cast()
		end
		
		if (S.PheromoneBomb:IsReadyMorph(10) or S.ShrapnelBomb:IsReadyMorph(10) or S.VolatileBomb:IsReadyMorph(10)) 
		and S.WildfireBomb:FullRechargeTimeP() < Player:GCD() then
			return S.WildfireBomb:Cast()
		end
		
		if S.MongooseBite:IsReadyQueue(8) and Player:BuffP(S.MongooseFury) or Player:Focus() > 61 then
			return S.MongooseBite:Cast()
		end

		if S.ExplosiveShot:IsReadyQueue(40) then
			return S.ExplosiveShotz:Cast()
		end
		
		if (S.PheromoneBomb:IsReadyMorph(10) or S.ShrapnelBomb:IsReadyMorph(10) or S.VolatileBomb:IsReadyMorph(8)) then
			return S.WildfireBomb:Cast()
		end

	end
end
    return 0, "Interface\\Addons\\Rubim-RH\\Media\\mount2.tga"
end

RubimRH.Rotation.SetAPL(255, APL);

local function PASSIVE()

end

RubimRH.Rotation.SetPASSIVE(255, PASSIVE);
