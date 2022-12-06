--- Localize Vars
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
local MouseOver = Unit.MouseOver;
-- Lua
local pairs = pairs;
local tableconcat = table.concat;
local tostring = tostring;
local tableinsert = table.insert;

if not Spell.Rogue then
    Spell.Rogue = {};
end

RubimRH.Spell[261] = {


ShadowyDuel = Spell(207736),

UnleashHeartOfAzeroth = Spell(256948), -- spatial rift
ColdBlood = Spell(213981),
ShadowBlades = Spell(121471),
Shadowstrike = Spell(185438),
Backstab = Spell(53),
Rupture = Spell(1943),
ShadowDance = Spell(185313),
ShurikenToss = Spell(114014),
ShurikenStorm = Spell(197835),
SymbolsofDeath = Spell(212283),
ShurikenTornado = Spell(277925),
SecretTechnique = Spell(280719),
Eviscerate = Spell(196819),
Perforate = Spell(277673),
Nightstalker = Spell(14062),
DarkShadow = Spell(245687),
ShadowDanceBuff = Spell(185422),
	stopcasting = Spell(291944), --regeneratin
	WoundPoison = Spell(8679),
	CripplingPoison = Spell(3408),
	InstantPoison = Spell(315584),
	lust1 = Spell(57724),
	lust2 = Spell(57723),
	lust3 = Spell(80354),
	lust4 = Spell(95809),
	lust5 = Spell(264689),
	CondensedLifeForce = Spell(299358),
	UnleashHeartOfAzeroth = Spell(256948), -- spatial rift
	BloodOfTheEnemy = Spell(297108),
	BloodOfTheEnemy2 = Spell(298273),
	BloodOfTheEnemy3 = Spell(298277),
	ConcentratedFlame = Spell(295373),
	ConcentratedFlame2 = Spell(299349),
	ConcentratedFlame3 = Spell(299353),
	GuardianOfAzeroth = Spell(295840),
	GuardianOfAzeroth2 = Spell(299355),
	GuardianOfAzeroth3 = Spell(299358),
	FocusedAzeriteBeam = Spell(295258),
	FocusedAzeriteBeam2 = Spell(299336),
	FocusedAzeriteBeam3 = Spell(299338),
	PurifyingBlast = Spell(295337),
	PurifyingBlast2 = Spell(299345),
	PurifyingBlast3 = Spell(299347),
	TheUnboundForce = Spell(298452),
	TheUnboundForce2 = Spell(299376),
	TheUnboundForce3 = Spell(299378),
	RippleInSpace = Spell(302731),
	RippleInSpace2 = Spell(302982),
	RippleInSpace3 = Spell(302983),
	WorldveinResonance = Spell(295186),
	WorldveinResonance2 = Spell(298628),
	WorldveinResonance3 = Spell(299334),
	MemoryOfLucidDreams = Spell(298357),
	MemoryOfLucidDreams2 = Spell(299372),
	MemoryOfLucidDreams3 = Spell(299374),
	trink2 = Spell(59547), -- gift of naaru
	ConcentratedFlamedebuff     = Spell(295368),
	FocusedAzeriteBeam = Spell(295258),
	KidneyShot = Spell(408),

    Berserking = Spell(26297),
    Darkflight = Spell(68992),
	Distract = Spell(1725),
	lustAT = Spell(155145),

    WaterStrider = Spell(118089),
    BugMount = Spell(243795),
	razorcoral = Spell(303568),
	ConductiveInk = Spell(302565),
  
  
   
    DeeperStratagem = Spell(193531),
   
    Stealth = Spell(1784),
    Vanish = Spell(1856),
    VanishBuff = Spell(11327),
    Shivv = Spell(248744),
   
    WilloftheForsaken = Spell(7744),
    CloakofShadows = Spell(31224),
	trink = Spell(265221),
  
   
    DeathfromAbove = Spell(269513),
    DeeperStratagem = Spell(193531),
  
    GhostlyStrike = Spell(196937),
   
    MarkedforDeath = Spell(137619),
  
  
    SliceandDice = Spell(315496),
    Vigor = Spell(14983),
	Exhaustion = Spell(57723),
	Blind = Spell(2094),
  
    CurseoftheDreadblades = Spell(202665),
  
   
	
	CheapShot = Spell(1833),
	Dismantle= Spell(207777),
    CrimsonVial = Spell(185311),
    Feint = Spell(1966),
 
    Kick = Spell(1766),
    Sprint = Spell(2983),
  
	Evasion = Spell(5277),
	
}

local S = RubimRH.Spell[261] 

if not Item.Rogue then Item.Rogue = {}; end

Item.Rogue.Sub = {
	trink2 = Item(159617, { 13, 14 }),
	trink = Item(169311, { 13, 14 }),
	lust = Item(164978)
   
};

local I = Item.Rogue.Sub;

local RtB_BuffsList = {
    S.Broadside,
    S.BuriedTreasure,
    S.GrandMelee,
    S.SkullandCrossbones,
    S.RuthlessPrecision,
    S.TrueBearing
};

local function num(val)
    if val then
        return 1
    else
        return 0
    end
end

local function CPMaxSpend()
    return RubimRH.Spell[261].DeeperStratagem:IsAvailable() and 6 or 5;
end

local function RtB_BuffRemains ()
    if not Cache.APLVar.RtB_BuffRemains then
        Cache.APLVar.RtB_BuffRemains = 0;
        for i = 1, #RtB_BuffsList do
            if Player:Buff(RtB_BuffsList[i]) then
                Cache.APLVar.RtB_BuffRemains = Player:BuffRemainsP(RtB_BuffsList[i]);
                break ;
            end
        end
    end
    return Cache.APLVar.RtB_BuffRemains;
end

local function DetermineEssenceRanks()
  S.BloodOfTheEnemy = S.BloodOfTheEnemy2:IsAvailable() and S.BloodOfTheEnemy2 or S.BloodOfTheEnemy
  S.BloodOfTheEnemy = S.BloodOfTheEnemy3:IsAvailable() and S.BloodOfTheEnemy3 or S.BloodOfTheEnemy
  S.MemoryOfLucidDreams = S.MemoryOfLucidDreams2:IsAvailable() and S.MemoryOfLucidDreams2 or S.MemoryOfLucidDreams
  S.MemoryOfLucidDreams = S.MemoryOfLucidDreams3:IsAvailable() and S.MemoryOfLucidDreams3 or S.MemoryOfLucidDreams
  S.PurifyingBlast = S.PurifyingBlast2:IsAvailable() and S.PurifyingBlast2 or S.PurifyingBlast
  S.PurifyingBlast = S.PurifyingBlast3:IsAvailable() and S.PurifyingBlast3 or S.PurifyingBlast
  S.RippleInSpace = S.RippleInSpace2:IsAvailable() and S.RippleInSpace2 or S.RippleInSpace
  S.RippleInSpace = S.RippleInSpace3:IsAvailable() and S.RippleInSpace3 or S.RippleInSpace
  S.ConcentratedFlame = S.ConcentratedFlame2:IsAvailable() and S.ConcentratedFlame2 or S.ConcentratedFlame
  S.ConcentratedFlame = S.ConcentratedFlame3:IsAvailable() and S.ConcentratedFlame3 or S.ConcentratedFlame
  S.TheUnboundForce = S.TheUnboundForce2:IsAvailable() and S.TheUnboundForce2 or S.TheUnboundForce
  S.TheUnboundForce = S.TheUnboundForce3:IsAvailable() and S.TheUnboundForce3 or S.TheUnboundForce
  S.WorldveinResonance = S.WorldveinResonance2:IsAvailable() and S.WorldveinResonance2 or S.WorldveinResonance
  S.WorldveinResonance = S.WorldveinResonance3:IsAvailable() and S.WorldveinResonance3 or S.WorldveinResonance
  S.FocusedAzeriteBeam = S.FocusedAzeriteBeam2:IsAvailable() and S.FocusedAzeriteBeam2 or S.FocusedAzeriteBeam
  S.FocusedAzeriteBeam = S.FocusedAzeriteBeam3:IsAvailable() and S.FocusedAzeriteBeam3 or S.FocusedAzeriteBeam
end



local function EnergyTimeToMaxRounded()
    return math.floor(Player:EnergyTimeToMaxPredicted() * 10 + 0.5) / 10;
end





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
 
-- Out of Combat
if not Player:AffectingCombat() then

	if (Player:BuffRemainsP(S.CripplingPoison)>300 and Player:IsCasting(S.CripplingPoison) or Player:BuffRemainsP(S.InstantPoison)>300 and Player:IsCasting(S.InstantPoison) or Player:BuffRemainsP(S.WoundPoison)>300 and Player:IsCasting(S.WoundPoison))then
		return S.stopcasting:Cast()
    end
	

	if S.CripplingPoison:IsCastable() and Player:BuffRemainsP(S.CripplingPoison)< 300 and not Player:IsCasting(S.CripplingPoison) then
    	return S.CripplingPoison:Cast()
    end
	
	if S.InstantPoison:IsCastable() and Player:BuffRemainsP(S.InstantPoison)< 300 and not Player:IsCasting(S.InstantPoison) and (not IsInInstance() == "arena" and not IsInInstance() == "battlegrounds") then
    	return S.InstantPoison:Cast()
    end
	
	if S.WoundPoison:IsCastable() and Player:BuffRemainsP(S.WoundPoison)< 300 and not Player:IsCasting(S.WoundPoison) and (IsInInstance() == "arena" or IsInInstance() == "battlegrounds") then
    	return S.WoundPoison:Cast()
    end
	
		if S.ColdBlood:IsCastable() and not Player:BuffP(S.ColdBlood) and Player:BuffP(S.Stealth) then
    	return S.ColdBlood:Cast()
    end
	
	
  
	if Player:IsChanneling() or Player:IsCasting() then
        return 0, "Interface\\Addons\\Rubim-RH\\Media\\mount.tga"
    end

    -- if S.Ambush:IsReady() and not Player:IsTanking(Target) and Target:IsInRange(S.Ambush) and Player:BuffP(S.Stealth) then
    	-- return S.Ambush:Cast()
    -- end

    if S.Stealth:IsCastable() and not Player:Buff(S.Stealth) and not Player:Buff(S.VanishBuff) then
		return S.Stealth:Cast()
    end
  
    if S.CrimsonVial:IsCastable() and Cache.EnemiesCount[8] == 0 and Player:HealthPercentage() <= 75 and Player:EnergyDeficit() == 0 then
		return S.CrimsonVial:Cast()
    end
	
    if S.MarkedforDeath:IsCastable() and Player:ComboPointsDeficit() >= CPMaxSpend() - 1  and  Target:IsInRange(30) then
        return S.MarkedforDeath:Cast()
    end
	

   if Player:ComboPoints() >= 1 then
		if S.SliceandDice:IsCastable() and Cache.EnemiesCount[25]>=1 and not Player:BuffP(S.SliceandDice) then
			return S.SliceandDice:Cast()
		end
	end

	if not RubimRH.queuedSpell[1]:CooldownUp() or not Target:IsInRange(10) or not Player:AffectingCombat() then
		RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
	end
	
	return 0, "Interface\\Addons\\Rubim-RH\\Media\\mount2.tga"
end 

-- Spell Queue
	if Player:IsChanneling() or Player:IsCasting() then
		return 0, "Interface\\Addons\\Rubim-RH\\Media\\mount.tga"
    end
	
	
	-- actions.essences=concentrated_flame,if=energy.time_to_max>1&!buff.blade_flurry.up&(!dot.concentrated_flame_burn.ticking&!action.concentrated_flame.in_flight|full_recharge_time<gcd.max)
	
	

	
	if S.lustAT:ID() ==  RubimRH.queuedSpell[1]:ID() and not Player:Debuff(S.lust1) and not Player:Debuff(S.lust2) and not Player:Debuff(S.lust3) and not Player:Debuff(S.lust4) and not Player:Debuff(S.lust5) then
    	return S.lustAT:Cast() -- BIND LUST KEYBIND IN BINDPAD TO ARCANE TORRENT
	end
	
	if S.lustAT:ID() ==  RubimRH.queuedSpell[1]:ID() and (Player:Debuff(S.lust1) or Player:Debuff(S.lust2) or Player:Debuff(S.lust3) or Player:Debuff(S.lust4) or Player:Debuff(S.lust5)) then
		RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
	end
	
	if RubimRH.QueuedSpell():IsReadyQueue() and S.BloodOfTheEnemy:ID() ==  RubimRH.QueuedSpell():ID()  then
    	return S.UnleashHeartOfAzeroth:Cast()
	end	  	 

	if RubimRH.QueuedSpell():IsReadyQueue() then
        return RubimRH.QueuedSpell():Cast()
    end
	
	if not RubimRH.queuedSpell[1]:CooldownUp() or not Target:IsInRange(10) or not Player:AffectingCombat() then
		RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
	end
	





    if S.Evasion:IsReady() and Player:HealthPercentage() <= 85 and Cache.EnemiesCount[12] >= 1 then
    	return S.Evasion:Cast()
    end
		
	
	if I.trink:IsReady() and Target:IsInRange(12) and I.trink:IsEquipped() and (not Target:Debuff(S.razorcoral) or not Target:Debuff(S.ConductiveInk) and Target:HealthPercentage()<32 and Target:HealthPercentage()>=32 or not Target:Debuff(S.ConductiveInk) and (Target:DebuffStack(S.razorcoral) >= 20-10*num(Target:Debuff(S.BloodOfTheEnemy)))) then
         return S.trink:Cast()
     end

	-- if S.Kick:IsReady(12) and Target:IsInterruptible() and RubimRH.InterruptsON() and Player:GCDRemains() < 0.25 then
		-- return S.Kick:Cast()
    -- end
	
	if S.CloakofShadows:IsReady() and Player:HealthPercentage() < 20 then
		return S.CloakofShadows:Cast()
	end
	
	
	     if S.ShadowyDuel:IsReady() and Target:HealthPercentage()<35 then
        return S.ShadowyDuel:Cast()
    end



if Player:ComboPoints() >= CPMaxSpend() - 1 then



     if S.SliceandDice:IsReady() and Cache.EnemiesCount[12]<6 and not Player:Buff(S.ShadowDanceBuff) and (Target:FilteredTimeToDie(">", Player:BuffRemainsP(S.SliceandDice)) or Player:BuffRemainsP(S.SliceandDice) == 0)
	   and Player:BuffRemainsP(S.SliceandDice) < (1 + Player:ComboPoints()) * 1.8 then
        return S.SliceandDice:Cast()
    end

	
	if S.Rupture:IsReady("Melee") and not Target:DebuffP(S.Rupture) and (Target:FilteredTimeToDie(">", 6, -Target:DebuffRemainsP(S.Rupture)) or Target:TimeToDieIsNotValid()) and not Target:Debuff(S.Blind) and (not Player:BuffP(S.ShadowDanceBuff) or HL.CombatTime()<7) then
			return S.Rupture:Cast()
		end
	
    if S.DeathfromAbove:IsReady(20) and not Target:Debuff(S.Blind) then
        return S.DeathfromAbove:Cast()
    end
	
 	if S.SecretTechnique:IsReady() and not Target:Debuff(S.Blind) then
	return S.SecretTechnique:Cast()
	end
	
    if S.Eviscerate:IsReady(12) and not Target:Debuff(S.Blind) then
        return S.Eviscerate:Cast()
    end 	
		
end



if Player:ComboPoints() >= CPMaxSpend() - 2 and Cache.EnemiesCount[12]>= 4 then



     if S.SliceandDice:IsReady() and Cache.EnemiesCount[12]<6 and not Player:Buff(S.ShadowDanceBuff) and (Target:FilteredTimeToDie(">", Player:BuffRemainsP(S.SliceandDice)) or Player:BuffRemainsP(S.SliceandDice) == 0)
	   and Player:BuffRemainsP(S.SliceandDice) < (1 + Player:ComboPoints()) * 1.8 then
        return S.SliceandDice:Cast()
    end

	
	if S.Rupture:IsReady("Melee") and not Target:DebuffP(S.Rupture) and (Target:FilteredTimeToDie(">", 6, -Target:DebuffRemainsP(S.Rupture)) or Target:TimeToDieIsNotValid()) and not Target:Debuff(S.Blind) and (not Player:BuffP(S.ShadowDanceBuff) or HL.CombatTime()<7) then
			return S.Rupture:Cast()
		end
	
    if S.DeathfromAbove:IsReady(20) and not Target:Debuff(S.Blind) then
        return S.DeathfromAbove:Cast()
    end
	
 	if S.SecretTechnique:IsReady() and not Target:Debuff(S.Blind) then
	return S.SecretTechnique:Cast()
	end
	
    if S.Eviscerate:IsReady(12) and not Target:Debuff(S.Blind) then
        return S.Eviscerate:Cast()
    end 	
		
end

	
     if S.SliceandDice:IsReady() and Cache.EnemiesCount[12]<6 and HL.CombatTime()<5 and not Player:BuffP(S.SliceandDice) then
        return S.SliceandDice:Cast()
    end


	    if S.ConcentratedFlame:IsReady() and (EnergyTimeToMaxRounded() > 1 or HL.CombatTime()<5) and (not Target:Debuff(S.ConcentratedFlamedebuff) or S.ConcentratedFlame:FullRechargeTimeP() < Player:GCD()) and not Player:BuffP(S.ShadowDanceBuff) then
    	return S.UnleashHeartOfAzeroth:Cast()
    end
	
			if not S.SymbolsofDeath:CooldownUp() and S.SymbolsofDeath:CooldownRemainsP()<2 and Player:EnergyDeficitPredicted() > 60 and not Player:BuffP(S.ShadowDanceBuff) and Player:ComboPointsDeficit() >= 1 and HL.CombatTime()>=5 then
		return 0, "Interface\\Addons\\Rubim-RH\\Media\\mount.tga"
    end
	
			if not Player:BuffP(S.SymbolsofDeath) and not Player:BuffP(S.ShadowDanceBuff) and S.ShadowDance:ChargesFractional()>=1.7 and Player:EnergyDeficitPredicted() > 35 and Player:ComboPointsDeficit() >= 1 and HL.CombatTime()>=5 then
		return 0, "Interface\\Addons\\Rubim-RH\\Media\\mount.tga"
    end
			if not Player:BuffP(S.ShadowDanceBuff) and S.ShadowDance:ChargesFractional()>=1.75 and Player:EnergyDeficitPredicted() > 35 and Player:ComboPointsDeficit() >= 1 and HL.CombatTime()>=15 then
		return 0, "Interface\\Addons\\Rubim-RH\\Media\\mount.tga"
    end
	
  		if S.ShadowBlades:IsReady() and Player:BuffP(S.SymbolsofDeath) and RubimRH.CDsON() and Player:ComboPointsDeficit()>=1 then
        return S.ShadowBlades:Cast()
    end

	if S.SymbolsofDeath:IsReady() and RubimRH.CDsON() and HL.CombatTime()<5 and Player:BuffP(S.SliceandDice) then
        return S.SymbolsofDeath:Cast()
    end	
	
		if S.SymbolsofDeath:IsReady() and RubimRH.CDsON() and HL.CombatTime()>=5 then
        return S.SymbolsofDeath:Cast()
    end	
	
	   
	if S.ShadowDance:IsReady() and not Player:BuffP(S.ShadowDanceBuff) and Player:ComboPointsDeficit()>=3 and (Player:BuffP(S.SymbolsofDeath) or S.ShadowDance:ChargesFractional()>=1.75) then
        return S.ShadowDance:Cast()
    end
   
 	if S.ShurikenStorm:IsReady() and Cache.EnemiesCount[12]>= 3 then
	return S.ShurikenStorm:Cast()
	end
	
    if S.Shadowstrike:IsReady(25) and not Target:Debuff(S.Blind) then
        return S.Shadowstrike:Cast()
    end
	
	 	if S.ShurikenStorm:IsReady() and Cache.EnemiesCount[12]>= 2 then
	return S.ShurikenStorm:Cast()
	end
	
    if S.Backstab:IsReady(12) and not Target:Debuff(S.Blind) and (not Player:BuffP(S.VanishBuff) and not Player:BuffP(S.ShadowDanceBuff) and not Player:BuffP(S.Stealth)) then
        return S.Backstab:Cast()
    end
	
  
   



	-- Out of Range Pistol Shot
    if not Target:IsInRange(10) and not Target:Debuff(S.Blind) and S.ShurikenToss:IsReady(20) and not Player:Buff(S.Stealth) and Target:AffectingCombat()
    and Player:EnergyDeficitPredicted() < 25 and (Player:ComboPointsDeficit() >= 1 or EnergyTimeToMaxRounded() <= 1.2) then
        return S.ShurikenToss:Cast()
    end

    return 0, 135328
end




RubimRH.Rotation.SetAPL(261, APL);

local function PASSIVE()
    
end

RubimRH.Rotation.SetPASSIVE(261, PASSIVE);