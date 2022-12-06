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

--- ============================ CONTENT ===========================
--- ======= APL LOCALS =======
-- luacheck: max_line_length 9999

-- Spells
RubimRH.Spell[66] = {
DivineProtection = Spell(498),
DevotionAura = Spell(465),
RetributionAura = Spell(183435),

DivinePurpose = Spell(223819),

	lust1 = Spell(57724),
	lust2 = Spell(57723),
	lust3 = Spell(80354),
	lust4 = Spell(95809),
	lust5 = Spell(264689),
	lustAT = Spell(265221), --fireblood

	BlessingofProtection = Spell(1022),
BlessingofFreedom = Spell(1044),

HammerofJustice = Spell(853),
DivineShield = Spell(642),
ArcaneTorrent = Spell(155145),
DivineSteed = Spell(190784),
FlashofLight = Spell(19750),


trinket= Spell(59547), -- gift of narru
healingpot = Spell(176108), --pot ID
healthstone = Spell(291944), -- regen


BlessingofSacrifice = Spell(6940),

	ArcaneTorrent = Spell(155145),
    Seraphim = Spell(152262),
	
    ShieldoftheRighteous = Spell(53600),
    AvengingWrath = Spell(31884),
    SeraphimBuff = Spell(152262),
    AvengingWrathBuff = Spell(31884),
    AvengersValorBuff = Spell(197561),
    AvengerShield = Spell(31935),
CleanseToxins = Spell(213644),
    AvengersShield = Spell(31935),
    Judgment = Spell(275779),
    CrusadersJudgment = Spell(204023),
    Consecration = Spell(26573),
    BlessedHammer = Spell(204019),
    HammeroftheRighteous = Spell(53595),
    ArdentDefender = Spell(31850),
    GuardianofAncientKings = Spell(86659),
    HandoftheProtector = Spell(213652),
    BlessingofSacrifice = Spell(6940),
    BlessingofFreedom = Spell(1044),
    Forbearance = Spell(25771),
    LayonHands = Spell(633),
    ConsecrationBuff = Spell(188370),
    LightoftheProtector = Spell(184092),
    ShieldoftheRighteousBuff = Spell(132403),
    InqusitionDebuff = Spell(206891),
    Inqusition = Spell(207028),
  HammerofWrath = Spell(24275),
    Rebuke = Spell(96231),
	DivineShield = Spell(642),
		DS = Spell(20549),

	BlessingofProtection = Spell(1022),
	ShiningLight = Spell(327510),

	-- divinesteed= Spell(),
WordofGlory = Spell(85673),
	BlindingLight = Spell(115750),
	MomentofGlory = Spell(327193),
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
};






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


local S = RubimRH.Spell[66];
local G = RubimRH.Spell[1]; -- General Skills

-- Items
if not Item.Paladin then
    Item.Paladin = {}
end
Item.Paladin.Protection = {
   trink = Item(172666, { 13, 14 }),


drumsoffury = Item(120257),
    healingpot = Item(169451), --astral healing pot
    healthstone = Item(5512), --health stone

};
local I = Item.Paladin.Protection;


-- Variables

local EnemyRanges = { 8,10,12,20 }
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



local function ConcerationTime()
    for i = 1, 5 do
        local active, totemName, startTime, duration, textureId = GetTotemInfo(i)
        if active == true then
            return startTime + duration - GetTime()
        end
    end
    return 0
end

local function UpdateCDs()
    if RubimRH.config.cooldown then
        for i, spell in pairs(OffensiveCDs) do
            if not spell:IsEnabledCD() then
                RubimRH.delSpellDisabledCD(spell:ID())
            end
        end

    end
    if not RubimRH.config.cooldown then
        for i, spell in pairs(OffensiveCDs) do
            if spell:IsEnabledCD() then
                RubimRH.addSpellDisabledCD(spell:ID())
            end
        end
    end
end

--- ======= ACTION LISTS =======
local function APL()
    local Precombat
	HL.GetEnemies("Melee");
	HL.GetEnemies(5, true);
	HL.GetEnemies(6, true);
    HL.GetEnemies(8, true);
	HL.GetEnemies(9, true);
    HL.GetEnemies(10, true);
	HL.GetEnemies(11, true);
	HL.GetEnemies(12, true);
	HL.GetEnemies(14, true);
	HL.GetEnemies(16, true);
	HL.GetEnemies(20, true);
	HL.GetEnemies(25, true);
	HL.GetEnemies(30, true);
	
    UpdateRanges()
    UpdateCDs()
    Precombat = function()
        -- flask
        -- food
        -- augmentation
        -- snapshot_stats
        -- potion
    end
	

    -- if I.healthstone:IsReady() and Player:HealthPercentage() <= 50 then
        -- return S.healthstone:Cast()
    -- end



    if I.healingpot:IsReady() and Player:HealthPercentage() <= 35 and Player:AffectingCombat() then
        return S.healingpot:Cast()
    end


	
	
	if S.lustAT:ID() ==  RubimRH.queuedSpell[1]:ID() and not Player:Debuff(S.lust1) and not Player:Debuff(S.lust2) and not Player:Debuff(S.lust3) and not Player:Debuff(S.lust4) and not Player:Debuff(S.lust5) and (I.drumsoffury:IsReady()) then
    	return S.lustAT:Cast() -- BIND LUST KEYBIND IN BINDPAD TO ARCANE TORRENT
	end
	
	if S.lustAT:ID() ==  RubimRH.queuedSpell[1]:ID() and (Player:Debuff(S.lust1) or Player:Debuff(S.lust2) or Player:Debuff(S.lust3) or Player:Debuff(S.lust4) or Player:Debuff(S.lust5)) then
		RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
	end
	
	  -- if I.trink:IsReady() and Cache.EnemiesCount[5]>=1 and I.trink:IsEquipped() and RubimRH.CDsON() then
         -- return S.trinket:Cast()
     -- end	 
	 
		-- if S.trinket:ID() ==  RubimRH.queuedSpell[1]:ID() and I.trink:IsReady() and not Player:IsMoving() and I.trink:IsEquipped() then
    	-- return S.trinket:Cast()
	-- end
	
	-- if S.trinket:ID() ==  RubimRH.queuedSpell[1]:ID() and (not I.trink:IsReady() or Player:IsMoving() or not I.trink:IsEquipped()) then
		-- RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
	-- end
	
	
	
	 	if  S.FlashofLight:ID() ==  RubimRH.queuedSpell[1]:ID() and Player:IsMoving() then
    		RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
	end



		if RubimRH.QueuedSpell():IsReadyQueue() then
        return RubimRH.QueuedSpell():Cast()
    end
	
	
	if (not RubimRH.queuedSpell[1]:CooldownUp() or not Player:AffectingCombat() or Cache.EnemiesCount[20]==0) then 
        RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
    end
	
	
	
	  -- if S.Rebuke:IsReady(30) and RubimRH.db.profile.mainOption.useInterrupts and Target:IsInterruptible() and Target:IsInRange(10)  then
        -- return S.Rebuke:Cast()
    -- end

	
		
    -- call precombat
    if not Player:AffectingCombat() then
	
		if S.WordofGlory:IsCastable() and Player:HealthPercentage() < 85  and (Player:HolyPower() >= 3 or Player:BuffP(S.DivinePurpose) or Player:BuffP(S.ShiningLight)) then
        return S.WordofGlory:Cast()
    end
	if S.DevotionAura:IsCastable() and not Player:BuffP(S.DevotionAura) then
        return S.DevotionAura:Cast()
    end
		if S.MomentofGlory:IsCastable() and Cache.EnemiesCount[25]>=1 and RubimRH.CDsON() then
        return S.MomentofGlory:Cast()
    end
	
		
	-- if LowestAlly("ALL", "HP") <= 90 and (S.LightofTheProtector:IsCastable() or S.HandoftheProtector:IsCastable()) then
        -- return S.LightofTheProtector1:Cast("ALL")
    -- end

	

        return 0, "Interface\\Addons\\Rubim-RH\\Media\\prot.tga"
    end



		if S.ArdentDefender:IsReadyP() and (Player:NeedPanicHealing() or Player:NeedMajorHealing()) and Player:HealthPercentage() <= 40 then
            return S.ArdentDefender:Cast()
        end


		if S.ArdentDefender:IsReadyP() and (Player:NeedPanicHealing() or Player:NeedMajorHealing()) and Player:HealthPercentage() <= 25 and S.LayonHands:CooldownRemains()>1 then
            return S.ArdentDefender:Cast()
        end
	
        if S.ArdentDefender:IsReadyP() and Player:HealthPercentage() <= 70 and not Player:Buff(S.GuardianofAncientKings) and (Player:NeedPanicHealing() or Player:NeedMajorHealing()) then
            return S.ArdentDefender:Cast()
        end	
	
        if S.GuardianofAncientKings:IsReadyP() and (Player:NeedPanicHealing() or Player:NeedMajorHealing()) and Player:HealthPercentage() <= 65 and not Player:Buff(S.ArdentDefender) then
            return S.GuardianofAncientKings:Cast()
        end
 
    
	

	if S.LayonHands:IsReadyP() and Player:HealthPercentage()<= 25 and not Player:Debuff(S.Forbearance) then
		return S.LayonHands:Cast()
	end
	

	
	
			if S.DivineShield:IsReadyP() and Player:HealthPercentage()<= 25 and not Player:DebuffP(S.Forbearance) and not Player:BuffP(S.ArdentDefender) and S.ArdentDefender:CooldownRemains()>1 then
		return S.DivineShield:Cast()
	end

	
	if S.BlessingofProtection:IsReadyP() and Player:HealthPercentage()<= 30 and not Player:DebuffP(S.Forbearance) and S.DivineShield:CooldownRemains() > 1 and S.LayonHands:CooldownRemains() > 1 and not Player:BuffP(S.ArdentDefender) then
		return S.BlessingofProtection:Cast()
	end
		
	
	-- if S.WordofGlory:IsReadyP() and Player:HealthPercentage() < 55 and (Player:HolyPower() >= 3 or Player:BuffP(S.DivinePurpose) or Player:BuffP(S.ShiningLight)) then
        -- return S.WordofGlory:Cast() 
    -- end
	
	if S.WordofGlory:IsReadyP() and Player:HealthPercentage() < 70 and Player:BuffP(S.DivinePurpose) and Player:BuffP(S.ShieldoftheRighteousBuff) then
        return S.WordofGlory:Cast() 
    end
	
	if S.WordofGlory:IsReadyP() and Player:HealthPercentage() < 70 and Player:HolyPower() >= 3 and Player:BuffP(S.ShieldoftheRighteousBuff) then
        return S.WordofGlory:Cast() 
    end
	
	if S.WordofGlory:IsReadyP() and Player:HealthPercentage() < 70 and Player:BuffP(S.ShiningLight) then
        return S.WordofGlory:Cast() 
    end
	if S.WordofGlory:IsReadyP() and Player:HealthPercentage() < 55 and Player:HolyPower() >= 3 then
        return S.WordofGlory:Cast() 
    end	
	

-- shield_of_the_righteous,if=debuff.judgment.up&(debuff.vengeful_shock.up|!conduit.vengeful_shock.enabled)



-- shield_of_the_righteous,if=holy_power=5|buff.holy_avenger.up|holy_power=4&talent.sanctified_wrath.enabled&buff.avenging_wrath.up
-- judgment,target_if=min:debuff.judgment.remains,if=charges=2|!talent.crusaders_judgment.enabled
-- avengers_shield,if=debuff.vengeful_shock.down&conduit.vengeful_shock.enabled
-- hammer_of_wrath
-- avengers_shield
-- judgment,target_if=min:debuff.judgment.remains
-- vanquishers_hammer
-- consecration,if=!consecration.up
-- divine_toll
-- blessed_hammer,strikes=2.4,if=charges=3
-- ashen_hallow
-- hammer_of_the_righteous,if=charges=2
-- word_of_glory,if=buff.vanquishers_hammer.up
-- blessed_hammer,strikes=2.4
-- hammer_of_the_righteous
-- lights_judgment
-- arcane_torrent
-- consecration
-- word_of_glory,if=buff.shining_light_free.up&!covenant.necrolord




    if S.AvengingWrath:IsReadyP() and (Player:BuffP(S.SeraphimBuff) or S.Seraphim:CooldownRemains() < 2 or not S.Seraphim:IsAvailable() or Cache.EnemiesCount[12]>=5) and Player:BuffDownP(S.AvengingWrathBuff) and RubimRH.CDsON() and Cache.EnemiesCount[12]>=1 then
        return S.AvengingWrath:Cast()
    end
	
	if S.MomentofGlory:IsReadyP() and Cache.EnemiesCount[12]>=1 and RubimRH.CDsON() then
        return S.MomentofGlory:Cast()
    end
	
	
    if S.Seraphim:IsReadyP() and Player:HolyPower() >= 3 and S.Seraphim:IsAvailable() and Cache.EnemiesCount[12]>=1 then
        return S.Seraphim:Cast()
    end


    if S.ShieldoftheRighteous:IsReady() and Cache.EnemiesCount[8]>=1 and not Player:BuffP(S.ShieldoftheRighteousBuff) and (Player:HolyPower() >= 3 or Player:BuffP(S.DivinePurpose)) then
        return S.ShieldoftheRighteous:Cast()
    end
	
	  if S.ShieldoftheRighteous:IsReady() and Cache.EnemiesCount[8]>=1 and Player:BuffP(S.DivinePurpose) and Player:HealthPercentage()>=55 then
        return S.ShieldoftheRighteous:Cast()
    end
	
    if S.ShieldoftheRighteous:IsReady() and Cache.EnemiesCount[8]>=1 and Player:HolyPower() >= 5 then
        return S.ShieldoftheRighteous:Cast()
    end	

    if S.AvengersShield:IsReadyP() and Player:IsMoving() and Target:IsInRange(30) then
        return S.AvengersShield:Cast()
    end


	if S.Consecration:IsReadyP() and not Player:Buff(S.ConsecrationBuff) and (not Player:IsMoving() and Cache.EnemiesCount[10]>=1 or Player:IsMoving() and Cache.EnemiesCount[6]>=1) then
        return S.Consecration:Cast()
    end
	
 
    if S.AvengersShield:IsReadyP() and Cache.EnemiesCount[20]>=2 and Target:IsInRange(30) then
        return S.AvengersShield:Cast()
    end
	

    if S.Judgment:IsReadyP() and Target:IsInRange(30) then
        return S.Judgment:Cast()
    end

	
	if S.HammerofWrath:IsReadyP() and Target:IsInRange(30) and Target:HealthPercentage()<=20 then
        return S.HammerofWrath:Cast()
    end

	
    if S.AvengersShield:IsReadyP() and Target:IsInRange(30) then
        return S.AvengersShield:Cast()
    end
	


    if S.BlessedHammer:IsReadyP() and Cache.EnemiesCount[16]>=1 then
        return S.BlessedHammer:Cast()
    end
	

    -- if S.HammeroftheRighteous:IsReadyP(12) then
        -- return S.HammeroftheRighteous:Cast()
    -- end
	
	 

        -- -- if S.ConcentratedFlame:IsReadyP(30) then
            -- -- return S.UnleashHeartOfAzeroth:Cast()
        -- -- end
		
	

	if S.Consecration:IsReadyP() and Cache.EnemiesCount[10]>=1  then
        return S.Consecration:Cast()
    end
	
    return 0, 135328
end

RubimRH.Rotation.SetAPL(66, APL)

local function PASSIVE()


end
RubimRH.Rotation.SetPASSIVE(66, PASSIVE)
