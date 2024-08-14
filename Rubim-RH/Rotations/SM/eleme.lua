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

if not Spell.Shaman then
    Spell.Shaman = {};
end


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------SPELLS/ITEMS-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



RubimRH.Spell[262] = {
  TotemMastery                          = Spell(210643),
  StormkeeperBuff                       = Spell(191634),
  Stormkeeper                           = Spell(191634),
  FireElemental                         = Spell(198067),
  StormElemental                        = Spell(192249),
  ElementalBlast                        = Spell(117014),
  LavaBurst                             = Spell(51505),
  ChainLightning                        = Spell(188443),
  FlameShock                            = Spell(188389),
  FlameShockDebuff                      = Spell(188389),
  WindGustBuff                          = Spell(263806),
  Ascendance                            = Spell(114050),
  Icefury                               = Spell(210714),
  IcefuryBuff                           = Spell(210714),
  LiquidMagmaTotem                      = Spell(192222),
  Earthquake                            = Spell(61882),
  MasteroftheElements                   = Spell(16166),
  MasteroftheElementsBuff               = Spell(260734),
  LavaSurgeBuff                         = Spell(77762),
  AscendanceBuff                        = Spell(114050),
  FrostShock                            = Spell(196840),
  LavaBeam                              = Spell(114074),
  SurgeofPowerBuff                      = Spell(285514),
  NaturalHarmony                        = Spell(278697),
  SurgeofPower                          = Spell(262303),
  LightningBolt                         = Spell(188196),
  EarthShock                            = Spell(8042),
  CalltheThunder                        = Spell(260897),
  EchooftheElementals                   = Spell(275381),
  ResonanceTotemBuff                    = Spell(202192),
  WindShear                             = Spell(57994),
  BloodFury                             = Spell(20572),
  Berserking                            = Spell(26297),
  Fireblood                             = Spell(265221),
  AncestralCall                         = Spell(274738),
  Purge									= Spell(370),
  CleanseSpirit							= Spell(51886),
  PrimalElementalist                    = Spell(117013),
  EyeOfTheStorm                         = Spell(157375), 
  CallLightning                         = Spell(157348),    
  AstralShift                           = Spell(108271),    

lightningshield =  Spell(312411), -- bag of tricks
LightningShield = Spell(192106),

 
lustAT = Spell(155145),
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



}
local S = RubimRH.Spell[262] 


if not Item.Shaman then Item.Shaman = {}; end
Item.Shaman.Elemental = {
    -- Legendaries
	trink2 = Item(159617, { 13, 14 }),

	trink = Item(169311, { 13, 14 }),

	lust = Item(164978)
   
	
};
local I = Item.Shaman.Elemental;






local function num(val)
  if val then return 1 else return 0 end
end

local function bool(val)
  return val ~= 0
end

function TotemMastery()
    for i = 1, 5 do
        local active, totemName, startTime, duration, textureId  = GetTotemInfo(i)
        if active == true and textureId == 511726 then
            return startTime + duration - GetTime()
        end
    end
    return 0
end



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
	HL.GetEnemies(25, true);
	HL.GetEnemies(30, true);
	HL.GetEnemies(35, true);
	HL.GetEnemies(35, true);


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------OUT OF COMBAT ROTATION-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



if not Player:AffectingCombat() then


          if Player:IsChanneling() or (Player:IsCasting() and not (Player:IsCasting(S.WaterStrider) or Player:IsCasting(S.BugMount))) then
        return 0, "Interface\\Addons\\Rubim-RH\\Media\\mount.tga"
    end
	
	   if S.LightningBolt:IsCastable() and Target:IsInRange(40) and not Player:IsMoving() and not Player:PrevGCDP(1, S.LightningBolt) then
        return S.LightningBolt:Cast()
    end


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------OOC ROTATION-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------






    if S.LightningShield:IsCastableP() and not Player:BuffP(S.LightningShield) then
      return S.lightningshield:Cast()
    end


    if S.FlameShock:IsCastableP() and Target:DebuffRemainsP(S.FlameShockDebuff) <= 6 and Target:IsInRange(40) then
      return S.FlameShock:Cast()
    end

    if S.LavaBurst:CooldownRemains() >= 1 and Player:Maelstrom() >= 60 and Target:IsInRange(40) then        
          return S.EarthShock:Cast()
    end
	
	   if S.LavaBurst:IsCastableP() and Target:IsInRange(40) and not Player:IsMoving() then
      return S.LavaBurst:Cast()
    end
	
    if S.LightningBolt:IsCastable() and Target:IsInRange(40) and not Player:IsMoving() then
        return S.LightningBolt:Cast()
    end





		    if not RubimRH.queuedSpell[1]:CooldownUp() or not Target:IsInRange(10) or not Player:AffectingCombat() then
		RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
	end
	
	return 0, "Interface\\Addons\\Rubim-RH\\Media\\mount2.tga"
end 



--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------SPELL QUEUES-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	 
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



--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------IN-COMBAT ROTATION-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



    if S.LightningShield:IsCastableP() and not Player:BuffP(S.LightningShield) then
      return S.lightningshield:Cast()
    end


    if S.FlameShock:IsCastableP() and Target:DebuffRemainsP(S.FlameShockDebuff) <= 6 and Target:IsInRange(40) then
      return S.FlameShock:Cast()
    end

    if S.LavaBurst:CooldownRemains() >= 1 and Player:Maelstrom() >= 60 and Target:IsInRange(40) then        
          return S.EarthShock:Cast()
    end
	
	   if S.LavaBurst:IsCastableP() and Target:IsInRange(40) and not Player:IsMoving() then
      return S.LavaBurst:Cast()
    end
	
    if S.LightningBolt:IsCastable() and Target:IsInRange(40) and not Player:IsMoving() then
        return S.LightningBolt:Cast()
    end



   if S.FlameShock:IsCastableP() and Target:IsInRange(40) and not Player:IsMoving() then
      return S.FlameShock:Cast()
    end














	

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------END OF ROTATION-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------




    return 0, 135328
end




RubimRH.Rotation.SetAPL(262, APL);

local function PASSIVE()
    
end

RubimRH.Rotation.SetPASSIVE(262, PASSIVE);