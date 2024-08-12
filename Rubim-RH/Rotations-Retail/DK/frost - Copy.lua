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

if not Spell.DeathKnight then
    Spell.DeathKnight = {};
end

RubimRH.Spell[251] = {
RaiseAlly = Spell(61999),
    -- Racials
	  healthstone = Spell(291944), --regeneratin
  healingpot = Spell(176108), --potion in ggl
	  	lust1 = Spell(57724),
	lust2 = Spell(57723),
	lust3 = Spell(80354),
	lust4 = Spell(95809),
	lust5 = Spell(264689),
	lustAT = Spell(265221), -- fireblood

    ArcaneTorrent = Spell(50613),
    Berserking = Spell(26297),
    BloodFury = Spell(20572),
    GiftoftheNaaru = Spell(59547),

    -- Utility
    ControlUndead = Spell(45524),
    DeathGrip = Spell(49576),
    MindFreeze = Spell(47528),
    PathOfFrost = Spell(3714),
    WraithWalk = Spell(212552),
    ChillStreak = Spell(204160),

    -- Defensive
    AntiMagicShell = Spell(48707),
    DeathStrike = Spell(49998),
    IceboundFortitude = Spell(48792),
    DarkSuccor = Spell(101568),
    DeathGrip = Spell(49576),
    DeathsAdvance = Spell(48265),
    DeathPact = Spell(48743),

    -- Everything
    BreathofSindragosaBuff                = Spell(152279),
    RemorselessWinter                     = Spell(196770),
	RemorselessWinterz                    = Spell(179057),
    GatheringStorm                        = Spell(194912),
    GlacialAdvance                        = Spell(194913),
    Frostscythe                           = Spell(207230),
    FrostStrike                           = Spell(49143),
	FrostStrikez                          = Spell(162243),
	Frostscythez                          = Spell(211881),
    HowlingBlast                          = Spell(49184),
	HowlingBlastz                         = Spell(162794),
    RimeBuff                              = Spell(59052),
    KillingMachineBuff                    = Spell(51124),
    RunicAttenuation                      = Spell(207104),
    Obliterate                            = Spell(49020),
	Obliteratez                           = Spell(198013),
    HornofWinter                          = Spell(57330),
    ArcaneTorrent                         = Spell(50613),
    PillarofFrost                         = Spell(51271),
    ChainsofIce                           = Spell(45524),
	ChainsofIcez                          = Spell(188499),
    ColdHeartBuff                         = Spell(281209),
    PillarofFrostBuff                     = Spell(51271),
    FrostwyrmsFury                        = Spell(279302),
    EmpowerRuneWeaponBuff                 = Spell(47568),
    BloodFury                             = Spell(20572),
    Berserking                            = Spell(26297),
    EmpowerRuneWeapon                     = Spell(47568),
    BreathofSindragosa                    = Spell(152279),
    ColdHeart                             = Spell(281208),
    RazoriceDebuff                        = Spell(51714),
    FrozenPulseBuff                       = Spell(194909),
    FrozenPulse                           = Spell(194909),
    FrostFeverDebuff                      = Spell(55095),
    IcyTalonsBuff                         = Spell(194879),
    Obliteration                          = Spell(281238),
    DeathStrike                           = Spell(49998),
    DeathStrikeBuff                       = Spell(101568),
    FrozenTempest                         = Spell(278487),
    UnholyStrengthBuff                    = Spell(53365),
    
Lichborne = Spell(49039),

    -- PVP

    Transfusion = Spell(288977),
	
	-- Azerite
	IcyCitadel                            = Spell(272718),
    IcyCitadelBuff                        = Spell(272719),
	
	  --8.2 Essences
  UnleashHeartOfAzeroth = Spell(280431),
  BloodOfTheEnemy       = Spell(297108),
  BloodOfTheEnemy2      = Spell(298273),
  BloodOfTheEnemy3      = Spell(298277),
  ConcentratedFlameDebuff= Spell(295368),
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
  RecklessForceBuff     = Spell(302932),
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
  RecklessForceCounter  = Spell(298409),
  RecklessForceCounter2 = Spell(302917)
}

local S = RubimRH.Spell[251] 

if not Item.DeathKnight then Item.DeathKnight = {}; end

Item.DeathKnight.Frost = {
	trink2 = Item(159617, { 13, 14 }),
	trink = Item(169311, { 13, 14 }),
	healingpot = Item(169451), --astral healing pot
    healthstone = Item(5512), --health stone
	drumsoffury = Item(120257),
   
};

local I = Item.DeathKnight.Frost;


local function num(val)
    if val then
        return 1
    else
        return 0
    end
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

	
	
	if Player:IsChanneling() or Player:IsCasting() then
        return 0, "Interface\\Addons\\Rubim-RH\\Media\\channel.tga"
    end



	if not RubimRH.queuedSpell[1]:CooldownUp() or not Target:IsInRange(10) or not Player:AffectingCombat() then
		RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
	end
	
	return 0, 236208
end 

-- Spell Queue
	if Player:IsChanneling() or Player:IsCasting() then
		return 0, "Interface\\Addons\\Rubim-RH\\Media\\channel.tga"
    end
	
	

	
	    if S.ConcentratedFlame:IsReady() and EnergyTimeToMaxRounded() > 1 and (not Player:BuffP(S.BladeFlurry) or HL.CombatTime()<5) and (not Target:Debuff(S.ConcentratedFlamedebuff) or S.ConcentratedFlame:FullRechargeTimeP() < Player:GCD()) then
    	return S.UnleashHeartOfAzeroth:Cast()
    end
	

	
	if S.lustAT:ID() ==  RubimRH.queuedSpell[1]:ID() and not Player:Debuff(S.lust1) and not Player:Debuff(S.lust2) and not Player:Debuff(S.lust3) and not Player:Debuff(S.lust4) and not Player:Debuff(S.lust5) and (I.drumsoffury:IsReady()) then
    	return S.lustAT:Cast() -- BIND LUST KEYBIND IN BINDPAD TO ARCANE TORRENT
	end
	
	if S.lustAT:ID() ==  RubimRH.queuedSpell[1]:ID() and (Player:Debuff(S.lust1) or Player:Debuff(S.lust2) or Player:Debuff(S.lust3) or Player:Debuff(S.lust4) or Player:Debuff(S.lust5)) then
		RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
	end
	
	
	if RubimRH.QueuedSpell():IsReadyQueue() and S.BloodOfTheEnemy:ID() ==  RubimRH.QueuedSpell():ID()  then
    	return S.UnleashHeartOfAzeroth:Cast()
	end	
	
	if S.RaiseAlly:ID() ==  RubimRH.queuedSpell[1]:ID() and Player:RunicPower()<30 then
		RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
	end
	

	if RubimRH.QueuedSpell():IsReadyQueue() then
        return RubimRH.QueuedSpell():Cast()
    end
	
	if not RubimRH.queuedSpell[1]:CooldownUp() or not Target:IsInRange(12) or not Player:AffectingCombat() then
		RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
	end
	
	

 if I.healthstone:IsReady() and Player:HealthPercentage() <= 50 then
        return S.healthstone:Cast()
    end

if I.healingpot:IsReady() and Player:HealthPercentage() <= 30 then
        return S.healingpot:Cast()
    end
	


	-- if I.trink:IsReady() and Target:IsInRange(12) and I.trink:IsEquipped() and (not Target:Debuff(S.razorcoral) or not Target:Debuff(S.ConductiveInk) and Target:HealthPercentage()<32 and Target:HealthPercentage()>=32 or not Target:Debuff(S.ConductiveInk) and (Target:DebuffStack(S.razorcoral) >= 20-10*num(Target:Debuff(S.BloodOfTheEnemy))) and Player:BuffRemainsP(S.AdrenalineRush)>18) then
         -- return S.trink:Cast()
     -- end
	 
	-- if I.trink2:IsReady() and Target:IsInRange(12) and I.trink2:IsEquipped() and (Player:BuffP(S.AdrenalineRush) or S.AdrenalineRush:CooldownRemainsP() > 20) then
        -- return S.trink2:Cast()
    -- end 
	
  if S.DeathStrike:IsReady() and Player:HealthPercentage()<60 and Target:IsInRange(12) and Player:BuffP(S.DarkSuccor) then
  return S.DeathStrike:Cast()
  end
  	
	
  if S.Lichborne:IsReady() and Player:HealthPercentage()<70 then
  return S.Lichborne:Cast()
  end
  
  if S.IceboundFortitude:IsReady() and Player:HealthPercentage()<50 then
  return S.IceboundFortitude:Cast()
  end
	
	
if Player:CanAttack(Target) then 
	
		
	--AOE 
	
	
		
if Cache.EnemiesCount[12]>=2 and RubimRH.AoEON() and Target:IsInRange(12) then	
	
-- Use Howling Blast Icon Howling Blast, only if you have a Rime Icon Rime proc.
      if S.HowlingBlast:IsReady() and (Player:BuffP(S.RimeBuff)) then
            return S.HowlingBlast:Cast()
        end

-- Use Frost Strike Icon Frost Strike, if you have 90+ Runic Power.
       if S.FrostStrike:IsReady() and Player:RunicPower()>=90 then
            return S.FrostStrike:Cast()
        end     

-- Use Frostscythe Icon Frostscythe, if you have a Killing Machine Icon Killing Machine proc.
       if S.Frostscythe:IsReady() and Player:BuffP(S.KillingMachineBuff) then
            return S.Frostscythe:Cast()
        end     


-- Use Remorseless Winter Icon Remorseless Winter on cooldown.
        if S.RemorselessWinter:IsReady() and RubimRH.CDsON() then
            return S.RemorselessWinter:Cast()
        end


-- Use Frostscythe Icon Frostscythe.
       if S.Frostscythe:IsReady() then
            return S.Frostscythe:Cast()
        end    


-- Use Frost Strike Icon Frost Strike, if you have 70+ Runic Power.	
       if S.FrostStrike:IsReady() and Player:RunicPower()>=70 then
            return S.FrostStrike:Cast()
        end  

	
end
	
	
	
	
	--ST	
if Cache.EnemiesCount[12]<2 or not RubimRH.AoEON() and Target:IsInRange(12) then	
	
-- Use Chains of Ice Icon Chains of Ice, if you have 20 stacks (try to use at the end of Pillar of Frost Icon Pillar of Frost when the strength bonus is at the highest — if you have 3 Icy Citadel Icon Icy Citadel traits, save Chains of Ice for after Pillar of Frost).
        if S.ChainsofIce:IsReady() and Player:BuffStackP(S.ColdHeartBuff) >= 20  then
            return S.ChainsofIce:Cast()
        end


-- Use Frostwyrm's Fury Icon Frostwyrm's Fury at the end of  Pillar of Frost and after Chains of Ice Icon Chains of Ice, or after Pillar of Frost and during Icy Citadel if you have 3 Icy Citadel traits.
  -- if S.FrostwyrmsFury:IsReady() and (Player:BuffRemainsP(S.PillarofFrostBuff) <= Player:GCD() or Player:BuffRemainsP(S.PillarofFrostBuff) < 8 and S.IcyCitadel:AzeriteRank() > 2) then
            -- return S.FrostwyrmsFury:Cast()
        -- end


-- Use Remorseless Winter Icon Remorseless Winter, if using Gathering Storm Icon Gathering Storm.
     if S.RemorselessWinter:IsReady()  and S.GatheringStorm:IsAvailable() then
            return S.RemorselessWinter:Cast()
        end


-- Use Howling Blast Icon Howling Blast, only if you have a Rime Icon Rime proc.

     if S.HowlingBlast:IsReady() and (Player:BuffP(S.RimeBuff)) then
            return S.HowlingBlast:Cast()
        end


-- Use Obliterate Icon Obliterate, if you have 4 or more Runes.
        if S.Obliterate:IsReady() and Player:Rune()>=4 then
            return S.Obliterate:Cast()
        end


-- Use Frost Strike Icon Frost Strike, if you have 90+ Runic Power.
       if S.FrostStrike:IsReady() and Player:RunicPower()>=90 then
            return S.FrostStrike:Cast()
        end     



-- Use Obliterate Icon Obliterate, if you have a Killing Machine Icon Killing Machine proc.
       if S.Obliterate:IsReady() and Player:BuffP(S.KillingMachineBuff) then
            return S.Obliterate:Cast()
        end     



-- Use Frost Strike Icon Frost Strike, if you have 70+ Runic Power.
       if S.FrostStrike:IsReady() and Player:RunicPower()>=70 then
            return S.FrostStrike:Cast()
        end     


-- Use Obliterate Icon Obliterate.
       if S.Obliterate:IsReady() then
            return S.Obliterate:Cast()
        end     


-- Use Frost Strike Icon Frost Strike.
       if S.FrostStrike:IsReady()  then
            return S.FrostStrike:Cast()
        end     


end

end
    return 0, 135328
end




RubimRH.Rotation.SetAPL(251, APL);

local function PASSIVE()
    
end

RubimRH.Rotation.SetPASSIVE(251, PASSIVE);