--- ======= LOCALIZE =======
-- Addon
local addonName, addonTable = ...;
-- HeroLib
local HL = HeroLib;
local Cache = HeroCache;
local Unit = HL.Unit;
local Player = Unit.Player;
local Target = Unit.Target;
local Spell = HL.Spell;
local Item = HL.Item;
local pairs = pairs;
local select = select;

RubimRH.Spell[261] = {
    ArcanePulse = Spell(260364),
    ArcaneTorrent = Spell(25046),
    Berserking = Spell(26297),
    BloodFury = Spell(20572),
    LightsJudgment = Spell(255647),
    Shadowmeld = Spell(58984),
    Backstab = Spell(53),
	SliceandDice = Spell(315496),
    Eviscerate = Spell(196819),
    Nightblade = Spell(195452),
    ShadowBlades = Spell(121471),
    ShurikenComboBuff = Spell(245640),
    ShadowDance = Spell(185313),
    ShadowDanceBuff = Spell(185422),
    Shadowstrike = Spell(185438),
    ShurikenStorm = Spell(197835),
    ShurikenToss = Spell(114014),
    Stealth = Spell(1784),
    Stealth2 = Spell(115191), -- w/ Subterfuge Talent
    SymbolsofDeath = Spell(212283),
    Vanish = Spell(1856),
    VanishBuff = Spell(11327),
    VanishBuff2 = Spell(115193), -- w/ Subterfuge Talent
    Alacrity = Spell(193539),
    DarkShadow = Spell(245687),
    DeeperStratagem = Spell(193531),
    EnvelopingShadows = Spell(238104),
    FindWeaknessDebuff = Spell(91021),
    Gloomblade = Spell(200758),
    MarkedforDeath = Spell(137619),
    MasterofShadows = Spell(196976),
    Nightstalker = Spell(14062),
    SecretTechnique = Spell(280719),
    ShadowFocus = Spell(108209),
    ShurikenTornado = Spell(277925),
    Subterfuge = Spell(108208),
    Vigor = Spell(14983),
    BladeInTheShadows = Spell(275896),
    NightsVengeancePower = Spell(273418),
    NightsVengeanceBuff = Spell(273424),
    SharpenedBladesPower = Spell(272911),
    SharpenedBladesBuff = Spell(272916),
    Feint = Spell(1966),
    Blind = Spell(2094),
    CheapShot = Spell(1833),
    Kick = Spell(1766),
    KidneyShot = Spell(408),
    Sprint = Spell(2983),
	Sap = Spell(6770),
	ColdBlood = Spell(213981),
	Shiv = Spell(248744),
	SmokeBomb = Spell (212182),
	DFA = Spell (269513),
	Duel = Spell (207736),
    TheDreadlordsDeceit = Spell(228224),
    CloakofShadows = Spell(31224),
    CrimsonVial = Spell(185311),
    Feint = Spell(1966),
    Evasion = Spell(5277),
	ReplicatingShadows = Spell(286121),
}

-- Items
if not Item.DemonHunter then 
	Item.DemonHunter = {}; 
end
Item.Rogue.Subtlety = {
	Plumage = Item(159617, { 13, 14 }),
};

local I = Item.Rogue.Subtlety;
local S = RubimRH.Spell[261]

-- Rotation Var
local EnemyRanges = {25, 20, 12, 10, 8, 6, 5, 4}
local function UpdateRanges()
  for _, i in ipairs(EnemyRanges) do
    HL.GetEnemies(i);
  end
end

-- Main APL
local function APL()
HL.GetEnemies("Melee");
UpdateRanges()

if Player:IsChanneling() then
    return 0, "Interface\\Addons\\Rubim-RH\\Media\\channel.tga"
end
 
-- Queue

	if QueueSkill() ~= nil then
		return QueueSkill()
	end
	
	if not RubimRH.queuedSpell[1]:IsCastable() or not Player:AffectingCombat() then
		RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
	end

-- Out of Combat
	if not Player:AffectingCombat() then
	
	 	if S.Stealth:IsCastable() and not Player:Buff(S.Stealth) and not Player:Buff(S.VanishBuff) then
			return S.Stealth:Cast()
		end
		
		-- if S.SliceandDice:IsReady() and Cache.EnemiesCount[25] >= 1 and Player:BuffRemainsP(S.SliceandDice) <= 10 then
			-- return S.SliceandDice:Cast()
		-- end
	
	end

-- Cooldowns
	if RubimRH.CDsON() and (Player:AffectingCombat() or Target:IsDummy()) then
	
	end

-- Rotation
if Player:AffectingCombat() or Target:IsDummy() then 

	if S.SymbolsofDeath:IsReady() and Player:BuffP(S.ShadowDanceBuff) then
		return S.SymbolsofDeath:Cast()
	end

	-- if S.SliceandDice:IsReady() and (not Player:BuffP(S.SliceandDice) or (Player:BuffRemainsP(S.SliceandDice) <= 5 and Player:ComboPoints() >= 5)) then
		-- return S.SliceandDice:Cast()
	-- end

	if S.Eviscerate:IsReady("Melee") and Player:ComboPoints() >= 5 then
		return S.Eviscerate:Cast()
	end
	
	if S.ShurikenStorm:IsReady() and Player:ComboPoints() < 5 and ((Cache.EnemiesCount[10] == 2 and not Player:BuffP(S.ShadowDanceBuff)) or (Cache.EnemiesCount[10] >= 3 and Player:BuffP(S.ShadowDanceBuff))) then
		return S.ShurikenStorm:Cast()
	end
	
	if S.Shadowstrike:IsReady() and Player:ComboPoints() < 5 and Cache.EnemiesCount[10] <= 2 then
		return S.Shadowstrike:Cast()
	end
	
	if S.Backstab:IsReady("Melee") and Player:ComboPoints() < 5 and Cache.EnemiesCount[10] == 1 then
		return S.Backstab:Cast()
	end

end
	return 0, "Interface\\Addons\\Rubim-RH\\Media\\mount2.tga"
end

RubimRH.Rotation.SetAPL(261, APL)

local function PASSIVE()
    return RubimRH.Shared()
end

RubimRH.Rotation.SetPASSIVE(261, PASSIVE)
