--- ============================ HEADER ============================
--- ======= LOCALIZE =======
-- Addon
local addonName, addonTable = ...
-- HeroLib
local HL     = HeroLib
local Cache  = HeroCache
local Unit   = HL.Unit
local Player = Unit.Player
local Target = Unit.Target
local Pet    = Unit.Pet
local Spell  = HL.Spell
local Item   = HL.Item
local mainAddon = RubimRH

RubimRH.Spell[268] = {

	Blackoutkick = Spell(205523),
	blackoutkickz = Spell(265221), --fireblood
	KegSmash = Spell(121253),
	Spinningcranekick = Spell(322729),
	spinningcranekickz = Spell(260364), --arcanepulse
	BreathOfFire = Spell(115181),
	RushingJadeWind = Spell(116847),
	TigerPalm = Spell(100780),
	Touchofdeath = Spell(322109),
	Touchofdeathz = Spell(20549), --war stomp
	HealingElixir = Spell(122281),
	ExpelHarm = Spell(322101),
	Celestialbrew = Spell(322507),
	celestialbrewz = Spell(256948), --spatialrift
    HeavyStagger = Spell(124273),
    ModerateStagger = Spell(124274),
    LightStagger = Spell(124275),
    PurifyingBrew = Spell(119582),
    RingofPeace = Spell(116844),
    InvokeNiuzaotheBlackOx = Spell(132578),
    InvokeNiuzaotheBlackOxz = Spell(287712), --haymaker
    RingofPeace = Spell(116844),
    CracklingJadeLightning = Spell(117952),
    LegSweep = Spell(119381),
	Paralysis = Spell(115078),
	Weaponsoforder = Spell(310454),
	foodanddrink = Spell(225737),
	Zenmeditation = Spell(115176),
	SpiritualHealingPotionz = Spell(107079), --quaking palm
}

local S = RubimRH.Spell[268]

-- Rotation Var
local ShouldReturn; -- Used to get the return string
-- Items
if not Item.Monk then Item.Monk = {} end
Item.Monk.Brewmaster = {
  SpiritualHealingPotion = Item(171267),
  InvocationOfYulon     = Item(165568),
};

local I = Item.Monk.Brewmaster;

local function APL()
	HL.GetEnemies("Melee");
	HL.GetEnemies(5, true);
    HL.GetEnemies(8, true);
    HL.GetEnemies(10, true);
	HL.GetEnemies(11, true);
	HL.GetEnemies(12, true);
	HL.GetEnemies(15, true);
	HL.GetEnemies(17, true);
	HL.GetEnemies(20, true);
	HL.GetEnemies(22, true);
	HL.GetEnemies(25, true);
	HL.GetEnemies(30, true);
	
	
	if Player:IsChanneling() or Player:IsCasting() or Player:Buff(S.foodanddrink) or Player:Buff(S.Zenmeditation) then
		return 0, "Interface\\Addons\\Rubim-RH\\Media\\channel.tga"
    end

-- Out of Combat
if not Player:AffectingCombat() then
	
    -- if S.RushingJadeWind:IsCastableP() and not Player:Buff(S.RushingJadeWind) and Cache.EnemiesCount[15] >= 1 then
        -- return S.RushingJadeWind:Cast()
    -- end

	return 0, "Interface\\Addons\\Rubim-RH\\Media\\mount2.tga"
end

-- Spell Queue
	if RubimRH.QueuedSpell():CooldownUp() and S.InvokeNiuzaotheBlackOx:ID() == RubimRH.QueuedSpell():ID() then
        return S.InvokeNiuzaotheBlackOxz:Cast()
    end

	if RubimRH.QueuedSpell():CooldownUp() and S.Touchofdeath:ID() == RubimRH.QueuedSpell():ID() then
        return S.Touchofdeathz:Cast()
    end

	if RubimRH.QueuedSpell():IsReadyQueue() then
        return RubimRH.QueuedSpell():Cast()
    end
	
	if not RubimRH.queuedSpell[1]:CooldownUp() or not Target:IsInRange(10) or not Player:AffectingCombat() then
		RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
	end
	
-- General
if Player:AffectingCombat() then

    if S.HealingElixir:IsCastableP() and Cache.EnemiesCount[12] >= 1 and Player:HealthPercentage() <= 77 and S.HealingElixir:ChargesFractional() == 2 then
        return S.HealingElixir:Cast()
    end

    if S.HealingElixir:IsCastableP() and Cache.EnemiesCount[12] >= 1 and Player:HealthPercentage() <= 45 then
        return S.HealingElixir:Cast()
    end
	
    if I.SpiritualHealingPotion:IsReady() and Cache.EnemiesCount[12] >= 1 and Player:HealthPercentage() <= 30 then
        return S.SpiritualHealingPotionz:Cast()
    end

    if S.PurifyingBrew:IsCastableP() and 
	((S.PurifyingBrew:ChargesFractional() == 2 and Player:HealthPercentage() <= 85 and (Player:Debuff(S.HeavyStagger) or Player:Debuff(S.ModerateStagger) or Player:Debuff(S.LightStagger)))
	or (Player:HealthPercentage() <= 65 and (Player:Debuff(S.HeavyStagger) or Player:Debuff(S.ModerateStagger)))) then
        return S.PurifyingBrew:Cast()
    end
	
    if S.Celestialbrew:IsReady() and ((Player:HealthPercentage() <= 75 and (Player:Debuff(S.HeavyStagger) or Player:Debuff(S.ModerateStagger))) or
	Player:HealthPercentage() <= 60) then
        return S.celestialbrewz:Cast()
    end
	
    if S.ExpelHarm:IsReady() and Player:HealthPercentage() <= 60 then
        return S.ExpelHarm:Cast()
    end

    if S.Touchofdeath:IsReady(5) and Target:HealthPercentage() <= 15 then
        return S.Touchofdeathz:Cast()
    end

    if S.KegSmash:IsReady(15) then
        return S.KegSmash:Cast()
    end

    if S.Blackoutkick:IsReady(5) then
        return S.blackoutkickz:Cast()
    end
	
    if S.BreathOfFire:IsReady(12) then
        return S.BreathOfFire:Cast()
    end

    if S.RushingJadeWind:IsCastableP() and not Player:Buff(S.RushingJadeWind) and Cache.EnemiesCount[10] >= 1 then
        return S.RushingJadeWind:Cast()
    end

    if S.Spinningcranekick:IsCastableP() and Player:Energy() >= 60 and Cache.EnemiesCount[8] >= 3 and S.KegSmash:CooldownRemainsP() >= Player:GCD() then
        return S.spinningcranekickz:Cast()
    end

    if S.TigerPalm:IsReady(5) and Player:Energy() >= 60 and Cache.EnemiesCount[8] < 3 and S.KegSmash:CooldownRemainsP() >= Player:GCD() then
        return S.TigerPalm:Cast()
    end

end
    return 0, 135328
end
RubimRH.Rotation.SetAPL(268, APL);

local function PASSIVE()
    return RubimRH.Shared()
end

RubimRH.Rotation.SetPASSIVE(268, PASSIVE);