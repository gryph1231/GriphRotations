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


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------SPELLS/ITEMS-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



RubimRH.Spell[260] = {

BladeRush = Spell(271877),

stopcasting = Spell(291944), -- regeneratin

 
CripplingPoison = Spell(3408),
cripplingpoison = Spell(260364), -- arcane pulse
InstantPoison = Spell(315584),
instantpoison = Spell(274738), --ancestral call
 

lust1 = Spell(57724),
lust2 = Spell(57723),
lust3 = Spell(80354),
lust4 = Spell(95809),
lust5 = Spell(264689),

		  --8.2 Essences
		  CondensedLifeForce = Spell(299358),
  UnleashHeartOfAzeroth = Spell(280431),
  BloodOfTheEnemy       = Spell(297108),
  BloodOfTheEnemy2      = Spell(298273),
  BloodOfTheEnemy3      = Spell(298277),
  ConcentratedFlame     = Spell(295373),
  ConcentratedFlame2    = Spell(299349),
  ConcentratedFlame3    = Spell(299353),
  GuardianOfAzeroth     = Spell(295840),
  GuardianOfAzeroth2    = Spell(299355),
  GuardianOfAzeroth3    = Spell(299358),
  FocusedAzeriteBeam    = Spell(295258),
  FocusedAzeriteBeam2   = Spell(299336),
  FocusedAzeriteBeam3   = Spell(299338),
  PurifyingBlast        = Spell(295337),
  PurifyingBlast2       = Spell(299345),
  PurifyingBlast3       = Spell(299347),
  TheUnboundForce       = Spell(298452),
  TheUnboundForce2      = Spell(299376),
  TheUnboundForce3      = Spell(299378),
  RippleInSpace         = Spell(302731),
  RippleInSpace2        = Spell(302982),
  RippleInSpace3        = Spell(302983),
  WorldveinResonance    = Spell(295186),
  WorldveinResonance2   = Spell(298628),
  WorldveinResonance3   = Spell(299334),
  MemoryOfLucidDreams   = Spell(298357),
  MemoryOfLucidDreams2  = Spell(299372),
  MemoryOfLucidDreams3  = Spell(299374),
  trink2 = Spell(59547), -- gift of naaru
	  ConcentratedFlamedebuff     = Spell(295368),
	FocusedAzeriteBeam = Spell(295258),
	KYWAY = Spell(288979),
	KidneyShot = Spell(408),
	
    AceUpYourSleeve = Spell(278676),
    Deadshot = Spell(272935),
    Berserking = Spell(26297),

    Darkflight = Spell(68992),

    -- Debuff List
	Distract = Spell(1725),
lustAT = Spell(155145),

bagoftricks = Spell(312411),
    	--Mount
    WaterStrider = Spell(118089),
    BugMount = Spell(243795),
razorcoral = Spell(303568),
ConductiveInk = Spell(302565),
    -- Abilities
    AdrenalineRush = Spell(13750),
    Ambush = Spell(8676),
    BetweentheEyes = Spell(315341),
    BladeFlurry = Spell(13877),
    DeeperStratagem = Spell(193531),
    Opportunity = Spell(195627),
    PistolShot = Spell(185763),
    RolltheBones = Spell(315508),
    Dispatch = Spell(2098),
    SinisterStrike = Spell(193315),
    Stealth = Spell(1784),
    Vanish = Spell(1856),
    VanishBuff = Spell(11327),
    Shivv = Spell(248744),
    Riposte = Spell(199754), -- evasion
    WilloftheForsaken = Spell(7744),
    CloakofShadows = Spell(31224),
    -- Talents
	trink = Spell(265221),
    Alacrity = Spell(193539),
    AlacrityBuff = Spell(193538),
    Anticipation = Spell(114015),
    CannonballBarrage = Spell(185767),
    DeathfromAbove = Spell(152150),
    DeeperStratagem = Spell(193531),
    DirtyTricks = Spell(108216),
    GhostlyStrike = Spell(196937),
    KillingSpree = Spell(51690),
    MarkedforDeath = Spell(137619),
    QuickDraw = Spell(196938),
    Tricks = Spell(57934),
    ToTT = Spell(58984),
    SliceandDice = Spell(315496),
    Vigor = Spell(14983),
    -- Artifact
	Exhaustion = Spell(57723),
	Blind = Spell(2094),
    Blunderbuss = Spell(202895),
    CurseoftheDreadblades = Spell(202665),
    HiddenBlade = Spell(202754),
    LoadedDice = Spell(256171),
    DeadshotBuff = Spell(272940),
	AceUpYourSleeve = Spell(278676),
	SnakeEyes = Spell(275846),
	SnakeEyesBuff = Spell(275863),
    -- Defensive
	DS = Spell(642),
	CheapShot = Spell(1833),
	Dismantle= Spell(207777),
    CrimsonVial = Spell(185311),
    Feint = Spell(1966),
    -- Utility
    Gouge = Spell(1776),
    Kick = Spell(1766),
    Sprint = Spell(2983),
    -- Roll the Bones
    Broadside = Spell(193356),
    BuriedTreasure = Spell(199600),
    GrandMelee = Spell(193358),
    SkullandCrossbones = Spell(199603),
	GCBoon = Spell(20572),
    RuthlessPrecision = Spell(193357),
    TrueBearing = Spell(193359),
	Evasion = Spell(5277),

}
local S = RubimRH.Spell[260] 


if not Item.Rogue then Item.Rogue = {}; end
Item.Rogue.Outlaw = {
    -- Legendaries
	trink2 = Item(159617, { 13, 14 }),

	trink = Item(169311, { 13, 14 }),

	lust = Item(164978)
   
	
};
local I = Item.Rogue.Outlaw;




--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------ROLL THE BONES FUNCTIONS-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

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


local function RtB_Buffs ()
    if not Cache.APLVar.RtB_Buffs then
        Cache.APLVar.RtB_Buffs = 0;
        for i = 1, #RtB_BuffsList do
            if Player:BuffP(RtB_BuffsList[i]) then
                Cache.APLVar.RtB_Buffs = Cache.APLVar.RtB_Buffs + 1;
            end
        end
    end
    return Cache.APLVar.RtB_Buffs;
end


local function EnergyTimeToMaxRounded()
    -- Round to the nearesth 10th to reduce prediction instability on very high regen rates
    return math.floor(Player:EnergyTimeToMaxPredicted() * 10 + 0.5) / 10;
end








local function APL()



--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------START OF ROTATION-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


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
 


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------OUT OF COMBAT ROTATION-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



if not Player:AffectingCombat() then

		     if Player:BuffRemainsP(S.CripplingPoison)>300 and  Player:IsCasting(S.CripplingPoison) then
    		 return S.stopcasting:Cast()
     end
	  		     if Player:BuffRemainsP(S.InstantPoison)>300 and  Player:IsCasting(S.InstantPoison) then
    		 return S.stopcasting:Cast()
     end 
			     if S.InstantPoison:IsCastable() and Player:BuffRemainsP(S.InstantPoison)< 300 and not Player:IsCasting(S.InstantPoison) then
    		 return S.InstantPoison:Cast()
     end
	
	 		     if S.CripplingPoison:IsCastable() and Player:BuffRemainsP(S.CripplingPoison)< 300 and not Player:IsCasting(S.CripplingPoison) then
    		 return S.CripplingPoison:Cast()
     end
	 
	

	   
  if Player:IsChanneling() or Player:IsCasting() then
        return 0, "Interface\\Addons\\Rubim-RH\\Media\\mount.tga"
    end
	


	
    
    	  if S.Ambush:IsReady() and not Player:IsTanking(Target) and Target:IsInRange(S.Ambush) and Player:BuffP(S.Stealth) then
    	return S.Ambush:Cast()
    end

          if S.Stealth:IsCastable() and not Player:Buff(S.Stealth) and not Player:Buff(S.VanishBuff) then
		return S.Stealth:Cast()
    end
  

          if S.CrimsonVial:IsCastable() and Cache.EnemiesCount[8] == 0 and Player:HealthPercentage() <= 75 and Player:EnergyDeficit() == 0 then
		return S.CrimsonVial:Cast()
    end
	
	 
            
        if S.MarkedforDeath:IsCastable() and Player:ComboPointsDeficit() >= CPMaxSpend() - 1  and  Target:IsInRange(30) then
            return S.MarkedforDeath:Cast()
    end
    
		
	     if S.RolltheBones:IsCastable()
		and Cache.EnemiesCount[25]>=1		 
		 and RtB_Buffs() < 2 
		 and (Player:BuffP(S.LoadedDice) or not Player:BuffP(S.GrandMelee) and not Player:BuffP(S.RuthlessPrecision))
		 then
    		 return S.RolltheBones:Cast()
     end

    if Player:ComboPoints() >= 1 then

	     if S.SliceandDice:IsCastable() 
 and Cache.EnemiesCount[25]>=1 and not Player:BuffP(S.SliceandDice)
		 then
    		 return S.SliceandDice:Cast()
     end
end


		    if not RubimRH.queuedSpell[1]:CooldownUp() or not Target:IsInRange(10) or not Player:AffectingCombat() then
		RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
	end
	
	return 0, "Interface\\Addons\\Rubim-RH\\Media\\mount2.tga"
end 


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------IN-COMBAT ROTATION-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
            if S.AdrenalineRush:IsReady() and not Player:BuffP(S.AdrenalineRush) and EnergyTimeToMaxRounded() > 1 and not Player:BuffP(S.Stealth) and RubimRH.CDsON() then
                return S.AdrenalineRush:Cast()
            end



--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------SPELL QUEUES-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  if Player:IsChanneling() or Player:IsCasting() then
        return 0, "Interface\\Addons\\Rubim-RH\\Media\\mount.tga"
    end
	 
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
	
	
	if S.Gouge:ID() ==  RubimRH.QueuedSpell():ID()  and (Target:Debuff(S.CheapShot) or not Target:IsInRange(10) or not Player:AffectingCombat() or Player:Buff(S.Stealth) or Target:Debuff(S.BetweentheEyes) or Player:Buff(S.VanishBuff) or Target:Debuff(S.Blind)) then 
    	RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
	end
	

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------DEFENSIVES/TRINKETS-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



     if S.Evasion:IsReady() and Player:HealthPercentage() <= 70 and Cache.EnemiesCount[12]>=1 then
    		return S.Evasion:Cast()
    end
	
	if I.trink:IsReady() and Target:IsInRange(12) and I.trink:IsEquipped() and (not Target:Debuff(S.razorcoral) or not Target:Debuff(S.ConductiveInk) and Target:HealthPercentage()<32 and Target:HealthPercentage()>=32 or not Target:Debuff(S.ConductiveInk) and (Target:DebuffStack(S.razorcoral) >= 20-10*num(Target:Debuff(S.BloodOfTheEnemy))) and Player:BuffRemainsP(S.AdrenalineRush)>18) then
         return S.trink:Cast()
     end	 
	 
	  if I.trink2:IsReady() and Target:IsInRange(12) and I.trink2:IsEquipped() and (Player:BuffP(S.AdrenalineRush) or S.AdrenalineRush:CooldownRemainsP()>20) then
         return S.trink2:Cast()
     end 
	  if S.Kick:IsReady(12) and Target:IsInterruptible() and RubimRH.InterruptsON() and Player:GCDRemains()<0.25 then
        return S.Kick:Cast()
    end
	
	if S.CloakofShadows:IsReady() and Player:HealthPercentage()<20 then
	return S.CloakofShadows:Cast()
	end
	
	
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------PVP-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	

	-- if S.Vanish:IsReady() and not Player:Buff(S.Stealth) and (Player:HealthPercentage()<20 and Cache.EnemiesCount[12]>=1 or Player:IsTankingAoE(12) and Player:HealthPercentage()<=70 and Cache.EnemiesCount[12]>=3) then
	-- return S.Vanish:Cast()
	-- end
	
-- if S.Dismantle:IsReady() and Target:IsInRange(10) and not Target:Debuff(S.Dismantle) and Target:HealthPercentage()<60 then
-- return S.Dismantle:Cast()
-- end


        -- if S.Riposte:IsCastable() and Cache.EnemiesCount[12] >= 1 and Player:HealthPercentage() <= 65 then
		-- return S.Riposte:Cast()
    -- end


          -- if S.CrimsonVial:IsCastable() and  Player:HealthPercentage()<70 then
		-- return S.CrimsonVial:Cast()
    -- end





--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------ROLL THE BONES-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



	     if S.RolltheBones:IsCastable() 
 and (Cache.EnemiesCount[12]>=2 and not Player:BuffP(S.BladeFlurry) or Cache.EnemiesCount[12]<2)
 and RtB_Buffs() < 2 and not Player:BuffP(S.GrandMelee) and not Player:BuffP(S.RuthlessPrecision)
		 then
    		 return S.RolltheBones:Cast()
     end


	     if S.RolltheBones:IsCastable() 
 and (Cache.EnemiesCount[12]>=2 and not Player:BuffP(S.BladeFlurry) or Cache.EnemiesCount[12]<2)
 and (S.Deadshot:AzeriteRank() >= 1 and RtB_Buffs() < 2 and (Player:BuffP(S.LoadedDice) or not Player:BuffP(S.Broadside)))
		 then
    		 return S.RolltheBones:Cast()
     end	
	

	
	     if S.RolltheBones:IsCastable() 
 and (Cache.EnemiesCount[12]>=2 and not Player:BuffP(S.BladeFlurry) or Cache.EnemiesCount[12]<2) 
 and S.AceUpYourSleeve:AzeriteRank() >= 1 and S.AceUpYourSleeve:AzeriteRank() >= S.Deadshot:AzeriteRank() and RtB_Buffs() < 2  
		 and (Player:BuffP(S.LoadedDice) or Player:BuffRemainsP(S.RuthlessPrecision) <= S.BetweentheEyes:CooldownRemainsP())
		 then
    		 return S.RolltheBones:Cast()
     end	
	


	     if S.RolltheBones:IsCastable() 
  and (Cache.EnemiesCount[12]>=2 and not Player:BuffP(S.BladeFlurry) or Cache.EnemiesCount[12]<2) 
 and RtB_Buffs() - num(Player:BuffP(S.SkullandCrossbones))<2
 and (Player:BuffP(S.LoadedDice) 
 or not Player:BuffP(S.GrandMelee) 
 and not Player:BuffP(S.RuthlessPrecision) 
 and not Player:BuffP(S.Broadside))
 then
    		 return S.RolltheBones:Cast()
     end	


	     if S.RolltheBones:IsCastable() and Player:BuffP(S.LoadedDice) 
		 and (Cache.EnemiesCount[12]>=2 and not Player:BuffP(S.BladeFlurry) or Cache.EnemiesCount[12]<2)
		 and (RtB_Buffs() - num(Player:BuffP(S.BuriedTreasure))<2 or RtB_BuffRemains() < 3)
		 then
    		 return S.RolltheBones:Cast()
     end
	 
	 
    if S.RolltheBones:IsCastable() 
	and RtB_BuffRemains() <= 3 
			then
        return S.RolltheBones:Cast()
    end
	
	
	
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------ANYTHING AFTER ROLLING-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	

	if S.BladeFlurry:IsCastable() and Cache.EnemiesCount[12]>1 and not Player:BuffP(S.BladeFlurry) and RubimRH.AoEON() then
		return S.BladeFlurry:Cast()
    end
	 

	if not Player:Buff(S.Stealth) and not Player:Buff(S.VanishBuff) then
    if Target:IsInRange(S.SinisterStrike) then
        if RubimRH.CDsON() then
        if S.ConcentratedFlame:IsReadyP() and EnergyTimeToMaxRounded() > 1 and not Player:BuffP(S.BladeFlurry) and (not Target:Debuff(S.ConcentratedFlamedebuff) and S.ConcentratedFlame:TimeSinceLastCast() > 1  or S.ConcentratedFlame:ChargesFractional() >= 1.75)  then
            return S.UnleashHeartOfAzeroth:Cast()
        end
		
            if S.AdrenalineRush:IsReady() and not Player:BuffP(S.AdrenalineRush) and EnergyTimeToMaxRounded() > 1 then
                return S.AdrenalineRush:Cast()
            end
        end
		
        if S.MarkedforDeath:IsReady() then
            if Target:FilteredTimeToDie("<", Player:ComboPointsDeficit() * 1.5) or (Target:FilteredTimeToDie("<", 2) and Player:ComboPointsDeficit() > 0)
                    or (((Cache.EnemiesCount[30] == 1 and Player:BuffRemainsP(S.TrueBearing) > 15 - (Player:BuffP(S.AdrenalineRush) and 5 or 0))
                    or Target:IsDummy()) and not Player:IsStealthed(true, true) and Player:ComboPointsDeficit() >= CPMaxSpend() - 1) then
                return S.MarkedforDeath:Cast()
            elseif not Player:IsStealthed(true, true) and Player:ComboPointsDeficit() >= CPMaxSpend() - 1 then
                return S.MarkedforDeath:Cast()
            end
        end

    end
	end
 
    if Player:ComboPoints() >= CPMaxSpend() - (num(Player:BuffP(S.Broadside)) + num(Player:BuffP(S.Opportunity))) * num(S.QuickDraw:IsAvailable() and (not S.MarkedforDeath:IsAvailable() or S.MarkedforDeath:CooldownRemainsP() > 1)) and not Player:Buff(S.Stealth) and not Player:Buff(S.VanishBuff) then

    if S.SliceandDice:IsAvailable() and S.SliceandDice:IsReady()
            and (Target:FilteredTimeToDie(">", Player:BuffRemainsP(S.SliceandDice)) or Player:BuffRemainsP(S.SliceandDice) == 0)
            and Player:BuffRemainsP(S.SliceandDice) < (1 + Player:ComboPoints()) * 1.8 then
        return S.SliceandDice:Cast()
    end




    if S.BetweentheEyes:IsReady(20) and not Target:Debuff(S.Blind) 
	and (Player:BuffP(S.RuthlessPrecision) 
    or S.AceUpYourSleeve:AzeriteRank() >= 2 
	or S.Deadshot:AzeriteRank() >= 2
	or S.AceUpYourSleeve:AzeriteRank() >= 1 and S.Deadshot:AzeriteRank() >= 1)
	and RtB_Buffs() >= 1 
	and not Player:BuffP(S.DeadshotBuff)  
	then
        return S.BetweentheEyes:Cast()
    end


    if S.BetweentheEyes:IsReady(20) and not Target:Debuff(S.Blind) and (S.AceUpYourSleeve:AzeriteRank() >= 1 or S.Deadshot:AzeriteRank() >= 1) and not Player:BuffP(S.DeadshotBuff) then
        return S.BetweentheEyes:Cast()
    end
	

    if S.Dispatch:IsReady(12) and not Target:Debuff(S.Blind) then
        return S.Dispatch:Cast()
    end
	

    if S.BetweentheEyes:IsReady(20) and not Target:IsInRange(11) and not Player:BuffP(S.DeadshotBuff) and Target:AffectingCombat() then
        return S.BetweentheEyes:Cast()
    end
	
    end
	
	
	
	
	
  	if not Player:Buff(S.Stealth) then

    if S.PistolShot:IsReady(20)
			and  not Target:Debuff(S.Blind) 
			and (S.QuickDraw:IsAvailable() or S.KYWAY:AzeriteRank() < 2) and Player:BuffP(S.Opportunity) and (Player:BuffStackP(S.KYWAY)<14 or Player:Energy() < 45)
		then
        return S.PistolShot:Cast()
    end
	
	    if S.PistolShot:IsReady(20)
			and  not Target:Debuff(S.Blind) 
			and Player:BuffP(S.Opportunity) and Player:BuffP(S.DeadshotBuff)
		then
        return S.PistolShot:Cast()
    end


    if S.SinisterStrike:IsReady(12) and not Target:Debuff(S.Blind) then
        return S.SinisterStrike:Cast()
    end
	
	-- if S.bagoftricks:IsReady(20) and EnergyTimeToMaxRounded() > 1 and (not Player:BuffP(S.BladeFlurry) or Cache.EnemiesCount[12]<2) and RtB_Buffs() >= 1 then
        -- return S.bagoftricks:Cast()
    -- end	
	
	end
	

    -- OutofRange Pistol Shot
    if not Target:IsInRange(10) and not Target:Debuff(S.Blind) and S.PistolShot:IsReady(20) and not Player:Buff(S.Stealth) and Target:AffectingCombat()
            and Player:EnergyDeficitPredicted() < 25 and (Player:ComboPointsDeficit() >= 1 or EnergyTimeToMaxRounded() <= 1.2 or Player:BuffP(S.DeadshotBuff)) then
        return S.PistolShot:Cast()
    end
	
	
			    if not RubimRH.queuedSpell[1]:CooldownUp() or not Target:IsInRange(10) or not Player:AffectingCombat() then
		RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
	end	
	
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------END OF ROTATION-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------




    return 0, 135328
end




RubimRH.Rotation.SetAPL(260, APL);

local function PASSIVE()
    
end

RubimRH.Rotation.SetPASSIVE(260, PASSIVE);