--- Localize Vars
local RubimRH = LibStub("AceAddon-3.0"):GetAddon("RubimRH")
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
local mainAddon = RubimRH

-- Spells
RubimRH.Spell[72] = {
	
	
	Polymorph = Spell(118),
Repentance = Spell(20066),
HexPvP = Spell(51514),
WyvernSting = Spell(19386),
Fear = Spell(5782),
Cyclone = Spell(33786),
MindControl = Spell(605),
RevivePet = Spell(982),
MassDispel  = Spell(32375),
GreatestPyroblast = Spell(203286),
ChaosBolt = Spell(116858),
Rebirth = Spell(20484),
SniperShot = Spell(203155),
Penance = Spell(47540),
PrayerofHealing = Spell(596),
HealPvP = Spell(2060),
FlashHeal = Spell(2061),
BindingHeal = Spell(32546),
PrayerofMending = Spell(33076),
DivineHymn = Spell(64843),
Halo = Spell(120517),
ShadowMend = Spell(186263),
PowerWordRadiance = Spell(194509),
HolyWordSalvation = Spell(265202),
GreaterHeal = Spell(289666),
Tranquility = Spell(740),
Regrowth = Spell(8936),
WildGrowth = Spell(48438),
Nourish = Spell(289022),
ChainHeal = Spell(1064),
HealingSurge = Spell(8004),
HealingRain = Spell(73920),
Wellspring = Spell(197995),
Downpour = Spell(207778),
FlashofLight = Spell(19750),
HolyLight = Spell(82326),
Vivify = Spell(116670),
EnvelopingMist = Spell(124682),
EssenceFont = Spell(191837),
SoothingMist = Spell(209525),
SurgingMist = Spell(227344),

--Dungeons
	DarkLotus = Spell(328740),
    DrainFluids = Spell(334748),
    MeatShield = Spell(323190),
    NecroticBolt = Spell(320462),
    FrostboltVolley = Spell(328667),
    ShadowWell = Spell(320571),
    RaspingScream = Spell(324293),
    Goresplatter = Spell(338353),
    RepairFlesh = Spell(327130), -- channel
    Bonemend = Spell(335143),
    SpiritBolt = Spell(323057),
    BramblethornCoat = Spell(324776),
    NourishTheForest = Spell(324914),
    StimulateResistance = Spell(326046),
    StimulateRegeneration = Spell(340544), -- channel
    ParasiticPacification = Spell(337235),
    ParasiticIncapacitation = Spell(337251),
    ParasiticDomination = Spell(337253),
    HarvestEssence = Spell(322938), -- channel
    BurdenofKnowledge = Spell(317963),
    DarkLash = Spell(317959),
    RebelliousFist = Spell(327413),
    DarkLance = Spell(327481),
    ForswornDoctrine = Spell(317936),
    InsidiousVenom = Spell(317661),
    InternalStrife = Spell(327648),
    ForcedConfession = Spell(328331),
    GreaterMending = Spell(328295),
    DarkPulse = Spell(328137),
    CurseofObliteration = Spell(325876),
    WickedBolt = Spell(338003),
    CollectSins = Spell(325700),
    TurntoStone = Spell(326607),
    VolleyofPower = Spell(323552),
    BoltofPower = Spell(323538),
    Scribe = Spell(328707),
    DeathsEmbrace = Spell(333875),
    Shadowcore = Spell(334076),
    Heal = Spell(332706),
    ShadowWordPain = Spell(332707),
    Smite = Spell(332705),
    HealingWave = Spell(332612),
    Hex = Spell(332605),
    LightningDischarge = Spell(332608),
    Lubricate = Spell(331379),
    SelfCleaningCycle = Spell(332084),
    Frostbolt = Spell(320008),
    BarkArmor = Spell(321764),
    WonderGrow = Spell(328016),
    BindingFungus = Spell(329917),
    CreepyCrawlers = Spell(329239),
    CorrosiveGunk = Spell(319070),
    GrippingInfection = Spell(328180),
    PestilenceBolt = Spell(328094),
    ViralGlobs = Spell(321999),
    EnvelopingWebbing = Spell(328475),
    DrainEssence = Spell(320861),
    SapLifeblood = Spell(321105),
    Engorge = Spell(334653), -- channel
    HungeringDrain = Spell(319654),
    CurseofSuppression = Spell(326836),
    Stoneskin = Spell(322433),
    GloomBurst = Spell(326837),
    BarbedShackles = Spell(335305),
    ExplosiveAnger = Spell(336277),
    FieryCantrip = Spell(326952),
    PlagueBolt = Spell(320120),
    NecromanticBolt = Spell(320300),
    DemoralizingShout = Spell(330562),
    BattleTrance = Spell(342139),
    BindSoul = Spell(330810),
    BoneSpear = Spell(342675),
    GraveSpike = Spell(341771),
    NecroticBoltVolley = Spell(330868),
    SpiritFrost = Spell(330875),
    FieryCantrip = Spell(326952),
    NecroticBoltToP = Spell(330784),
    MeatShieldToP = Spell(341977),
    WitheringDischarge = Spell(341969),
    DecayingFilth = Spell(330703),

	
	
	
	IntimidatingShout = Spell(5246),
    ArcaneTorrent = Spell(80483),
    AncestralCall = Spell(274738),
    Berserking = Spell(26297),
    BloodFury = Spell(20572),
    Fireblood = Spell(265221),
    GiftoftheNaaru = Spell(59547),
    LightsJudgment = Spell(255647),
    -- Abilities
    BattleShout = Spell(6673),
    BerserkerRage = Spell(18499),
    Bloodthirst = Spell(23881),
    Charge = Spell(100),
    Execute = Spell(5308),
    HeroicLeap = Spell(6544),
    HeroicThrow = Spell(57755),
    RagingBlow = Spell(85288),
    Rampage = Spell(184367),
    Recklessness = Spell(1719),
    VictoryRush = Spell(34428),
    Whirlwind = Spell(190411),
    WhirlwindPassive = Spell(12950),
    WhirlwindBuff = Spell(85739),
    EnragedRegeneration = Spell(184364),
    Enrage = Spell(184362),
    Condemn = Spell(317485),
    -- Talents
    WarMachine = Spell(262231),
    EndlessRage = Spell(202296),
    FreshMeat = Spell(215568),
    DoubleTime = Spell(103827),
    ImpendingVictory = Spell(202168),
    StormBolt = Spell(107570),
    InnerRage = Spell(215573),
    FuriousSlash = Spell(100130),
    FuriousSlashBuff = Spell(202539),
    Carnage = Spell(202922),
    Massacre = Spell(206315),
    FrothingBerserker = Spell(215571),
    MeatCleaver = Spell(280392),
    MeatCleaverBuff = Spell(280392),
    DragonRoar = Spell(118000),
    Bladestorm = Spell(46924),
    RecklessAbandon = Spell(202751),
    AngerManagement = Spell(152278),
    SiegeBreaker = Spell(280772),
    SiegeBreakerTalent = Spell(16037),
    SiegeBreakerDebuff = Spell(280773),
    SuddenDeath = Spell(280721),
    SuddenDeathBuff = Spell(280776),
    SuddenDeathBuffLeg = Spell(225947),
    Victorious = Spell(32216),
    -- Defensive
    RallyingCry = Spell(97462),
    -- Utility
    Pummel = Spell(6552),
    PiercingHowl = Spell(12323),
    -- Legendaries
    FujiedasFury = Spell(207776),
    StoneHeart = Spell(225947),
	CrushingBlow = Spell(335097),
	Onslaught = Spell(315720),
    -- Misc
	Frenzy = Spell(355082),
    UmbralMoonglaives = Spell(242553),
		lust1 = Spell(57724),
	lust2 = Spell(57723),
	lust3 = Spell(80354),
	lust4 = Spell(95809),
	lust5 = Spell(264689),
	lustAT = Spell(155145),
	
    SpellReflection = Spell(216890),
    -- Azerite
	Bloodbath = Spell(113344),
	Spear = Spell(307865),
		healingpot = Spell(176108), --phial/pots

	Ancestor = Spell(274738),
}

local S = RubimRH.Spell[72]

if not Item.Warrior then
    Item.Warrior = {}
end
Item.Warrior.Fury = {
    healingpot = Item(171267),
	drums = Item(172233),


};

local I = Item.Warrior.Fury;
-- Rotation Var
local ShouldReturn; -- Used to get the return string
local EnemyRanges = { "Melee", 5, 12 }
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

S.ExecuteDefault = Spell(5308)
S.ExecuteMassacre = Spell(280735)
local function UpdateExecuteID()
    S.Execute = S.Massacre:IsAvailable() and S.ExecuteMassacre or S.ExecuteDefault
end

local OffensiveCDs = {
   
    S.Recklessness,
    S.SiegeBreaker,
    S.Bladestorm,
    
    
}

local function UpdateCDs()
    if RubimRH.CDsON() then
        for i, spell in pairs(OffensiveCDs) do
            if not spell:IsEnabledCD() then
                RubimRH.delSpellDisabledCD(spell:ID())
            end
        end

    end
    if not RubimRH.CDsON() then
        for i, spell in pairs(OffensiveCDs) do
            if spell:IsEnabledCD() then
                RubimRH.addSpellDisabledCD(spell:ID())
            end
        end
    end
end

local function ExecuteRange ()
	return S.Massacre:IsAvailable() and 35 or 20;
end

-- # Essences



local function APL()
    -- Unit Update
    HL.GetEnemies(8);
    HL.GetEnemies(10);
    HL.GetEnemies(12);
	HL.GetEnemies(20);
	
	
	
	if (Target:IsCasting(S.Polymorph)
or Target:IsCasting(S.DarkLotus)
or Target:IsCasting(S.Repentance)
or Target:IsCasting(S.HexPvP)
or Target:IsCasting(S.WyvernSting)
or Target:IsCasting(S.Fear)
or Target:IsCasting(S.Cyclone)
or Target:IsCasting(S.MindControl)
or Target:IsCasting(S.RevivePet)
or Target:IsCasting(S.MassDispel)
or Target:IsCasting(S.GreatestPyroblast)
or Target:IsCasting(S.ChaosBolt)
or Target:IsCasting(S.Rebirth)
or Target:IsCasting(S.SniperShot)
or Target:IsCasting(S.Penance)
or Target:IsCasting(S.PrayerofHealing)
or Target:IsCasting(S.HealPvP)
or Target:IsCasting(S.FlashHeal)
or Target:IsCasting(S.BindingHeal)
or Target:IsCasting(S.PrayerofMending)
or Target:IsCasting(S.DivineHymn)
or Target:IsCasting(S.Halo)
or Target:IsCasting(S.ShadowMend)
or Target:IsCasting(S.PowerWordRadiance)
or Target:IsCasting(S.HolyWordSalvation)
or Target:IsCasting(S.GreaterHeal)
or Target:IsCasting(S.Tranquility)
or Target:IsCasting(S.Regrowth)
or Target:IsCasting(S.WildGrowth)
or Target:IsCasting(S.Nourish)
or Target:IsCasting(S.ChainHeal)
or Target:IsCasting(S.HealingSurge)
or Target:IsCasting(S.HealingRain)
or Target:IsCasting(S.Wellspring)
or Target:IsCasting(S.Downpour)
or Target:IsCasting(S.FlashofLight)
or Target:IsCasting(S.HolyLight)
or Target:IsCasting(S.Vivify)
or Target:IsCasting(S.EnvelopingMist)
or Target:IsCasting(S.EssenceFont)
or Target:IsCasting(S.SoothingMist)
or Target:IsCasting(S.SurgingMist)
or Target:IsCasting(S.DrainFluids)
or Target:IsCasting(S.MeatShield)
or Target:IsCasting(S.NecroticBolt)
or Target:IsCasting(S.FrostboltVolley)
or Target:IsCasting(S.ShadowWell)
or Target:IsCasting(S.RaspingScream)
or Target:IsCasting(S.Goresplatter)
or Target:IsChanneling(S.RepairFlesh)
or Target:IsCasting(S.Bonemend)
or Target:IsCasting(S.SpiritBolt)
or Target:IsCasting(S.BramblethornCoat)
or Target:IsCasting(S.NourishTheForest)
or Target:IsCasting(S.StimulateResistance)
or Target:IsChanneling(S.StimulateRegeneration)
or Target:IsCasting(S.ParasiticPacification)
or Target:IsCasting(S.ParasiticIncapacitation)
or Target:IsCasting(S.ParasiticDomination)
or Target:IsChanneling(S.HarvestEssence)
or Target:IsCasting(S.BurdenofKnowledge)
or Target:IsCasting(S.DarkLash)
or Target:IsCasting(S.RebelliousFist)
or Target:IsCasting(S.DarkLance)
or Target:IsCasting(S.ForswornDoctrine)
or Target:IsCasting(S.InsidiousVenom)
or Target:IsCasting(S.InternalStrife)
or Target:IsCasting(S.ForcedConfession)
or Target:IsCasting(S.GreaterMending)
or Target:IsCasting(S.DarkPulse)
or Target:IsCasting(S.CurseofObliteration)
or Target:IsCasting(S.WickedBolt)
or Target:IsCasting(S.CollectSins)
or Target:IsCasting(S.TurntoStone)
or Target:IsCasting(S.VolleyofPower)
or Target:IsCasting(S.BoltofPower)
or Target:IsCasting(S.Scribe)
or Target:IsCasting(S.DeathsEmbrace)
or Target:IsCasting(S.Shadowcore)
or Target:IsCasting(S.Heal)
or Target:IsCasting(S.ShadowWordPain)
or Target:IsCasting(S.Smite)
or Target:IsCasting(S.HealingWave)
or Target:IsCasting(S.Hex)
or Target:IsCasting(S.LightningDischarge)
or Target:IsCasting(S.Lubricate)
or Target:IsCasting(S.SelfCleaningCycle)
or Target:IsCasting(S.Frostbolt)
or Target:IsCasting(S.BarkArmor)
or Target:IsCasting(S.WonderGrow)
or Target:IsCasting(S.BindingFungus)
or Target:IsCasting(S.CreepyCrawlers)
or Target:IsCasting(S.CorrosiveGunk)
or Target:IsCasting(S.GrippingInfection)
or Target:IsCasting(S.PestilenceBolt)
or Target:IsCasting(S.ViralGlobs)
or Target:IsCasting(S.EnvelopingWebbing)
or Target:IsCasting(S.DrainEssence)
or Target:IsCasting(S.SapLifeblood)
or Target:IsCasting(S.Engorge)
or Target:IsCasting(S.HungeringDrain)
or Target:IsCasting(S.CurseofSuppression)
or Target:IsCasting(S.Stoneskin)
or Target:IsCasting(S.GloomBurst)
or Target:IsCasting(S.BarbedShackles)
or Target:IsCasting(S.ExplosiveAnger)
or Target:IsCasting(S.FieryCantrip)
or Target:IsCasting(S.PlagueBolt)
or Target:IsCasting(S.NecromanticBolt)
or Target:IsCasting(S.DemoralizingShout)
or Target:IsCasting(S.BattleTrance)
or Target:IsChanneling(S.BindSoul)
or Target:IsCasting(S.BoneSpear)
or Target:IsCasting(S.GraveSpike)
or Target:IsCasting(S.NecroticBoltVolley)
or Target:IsCasting(S.SpiritFrost)
or Target:IsCasting(S.FieryCantrip)
or Target:IsCasting(S.NecroticBoltToP)
or Target:IsCasting(S.MeatShieldToP)
or Target:IsCasting(S.WitheringDischarge)
or Target:IsCasting(S.DecayingFilth))	
	and Target:CastPercentage()> 35 and RubimRH.InterruptsON() and S.Pummel:IsReady(8) then
	return S.Pummel:Cast()
	end
  

	if S.lustAT:ID() ==  RubimRH.queuedSpell[1]:ID() and not Player:Debuff(S.lust1) and not Player:Debuff(S.lust2) and not Player:Debuff(S.lust3) and not Player:Debuff(S.lust4) and not Player:Debuff(S.lust5) and (I.drums:IsReady()) then
    	return S.lustAT:Cast() -- BIND LUST KEYBIND IN BINDPAD TO ARCANE TORRENT
	end
	
	if S.lustAT:ID() ==  RubimRH.queuedSpell[1]:ID() and (Player:Debuff(S.lust1) or Player:Debuff(S.lust2) or Player:Debuff(S.lust3) or Player:Debuff(S.lust4) or Player:Debuff(S.lust5)) then
		RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
	end
	
	if I.healingpot:IsReady() and Player:HealthPercentage() <= 25 and (not Player:InArena() and not Player:InBattlegrounds()) then
		return S.healingpot:Cast()
    end


		
if S.HeroicThrow:ID() ==  RubimRH.queuedSpell[1]:ID() and Target:IsInRange(8)  then
		RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
	end
	
		--if S.BattleShout:IsCastableP() and Player:BuffRemainsP(S.BattleShout) < 300  then
		--return S.BattleShout:Cast()
--	end
	
	
if not Player:AffectingCombat() then


	if not RubimRH.queuedSpell[1]:CooldownUp() or not Target:IsInRange(10) or not Player:AffectingCombat() then 
		RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
	end
	
	
	return 0, 132347
end


if  S.IntimidatingShout:ID() ==  RubimRH.queuedSpell[1]:ID() and RubimRH.QueuedSpell():IsReadyQueue() then
		return S.IntimidatingShout:Cast()
	end	
	
   if RubimRH.QueuedSpell():IsReadyQueue() then
            return RubimRH.QueuedSpell():Cast()
        end
	
	
	if not RubimRH.queuedSpell[1]:CooldownUp() or not Target:IsInRange(10) or not Player:AffectingCombat() then
		RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
	end
	
	if S.EnragedRegeneration:IsReady() and Player:HealthPercentage() <= 60 then
		return S.EnragedRegeneration:Cast()
	end
	
	if S.RallyingCry:IsReady() and Player:HealthPercentage() <= 55 then
		return S.RallyingCry:Cast()
	end
		
if Player:CanAttack(Target) and Target:IsInRange(8) then
	
	      if Player:Buff(S.Victorious) and Player:HealthPercentage()<65 and S.VictoryRush:IsReady() then
            return S.VictoryRush:Cast()
        end
		

 -- actions+=/rampage,if=cooldown.recklessness.remains<3&talent.reckless_abandon.enabled
 	    if S.Rampage:IsReady() and S.Recklessness:CooldownRemainsP()<3 and S.RecklessAbandon:IsAvailable() then
        return S.Rampage:Cast()
    end	
-- actions+=/recklessness,if=gcd.remains=0&((buff.bloodlust.up|talent.anger_management.enabled|raid_event.adds.in>10)|target.time_to_die>100|(talent.massacre.enabled&target.health.pct<35)|target.health.pct<20|target.time_to_die<15&raid_event.adds.in>10)&(spell_targets.whirlwind=1|buff.meat_cleaver.up)
	        if S.Recklessness:IsReady() and Player:GCDRemains()<0.2 and (Cache.EnemiesCount[12]>=2 and Player:Buff(S.WhirlwindBuff) and RubimRH.AoEON() or Cache.EnemiesCount[12]==1) then
        return S.Recklessness:Cast()
    end

	if RubimRH.CDsON() and S.DragonRoar:IsReady() and Cache.EnemiesCount[12]>=2 and Player:BuffP(S.Enrage) and Player:PrevGCD(1, S.Rampage) then
        return S.DragonRoar:Cast()
    end
	

-- actions+=/whirlwind,if=spell_targets.whirlwind>1&!buff.meat_cleaver.up|raid_event.adds.in<gcd&!buff.meat_cleaver.up
	        if S.Whirlwind:IsReady() and (Cache.EnemiesCount[10] >= 2 and not Player:Buff(S.WhirlwindBuff)) and RubimRH.AoEON() then
        return S.Whirlwind:Cast()
    end
		
-- actions.single_target=raging_blow,if=runeforge.will_of_the_berserker.equipped&buff.will_of_the_berserker.remains<gcd
--not going to use this leggo

-- actions.single_target+=/crushing_blow,if=runeforge.will_of_the_berserker.equipped&buff.will_of_the_berserker.remains<gcd
--not going to use this leggo


-- actions.single_target+=/siegebreaker,if=spell_targets.whirlwind>1|raid_event.adds.in>15
	if RubimRH.CDsON() and S.SiegeBreaker:IsReady()  then
        return S.SiegeBreaker:Cast()
    end
-- actions.single_target+=/rampage,if=buff.recklessness.up|(buff.enrage.remains<gcd|rage>90)|buff.frenzy.remains<1.5
	    if S.Rampage:IsReady() and (Player:Buff(S.Recklessness) or (Player:BuffRemainsP(S.Enrage) < Player:GCD() or Player:Rage() > 90) or Player:BuffRemainsP(S.Frenzy)<1.5) then
        return S.Rampage:Cast()
    end	
-- -- actions.single_target+=/condemn
   	-- if (Target:HealthPercentage()>=80 or Target:HealthPercentage()<35 and S.Massacre:IsAvailable() or Target:HealthPercentage()<20) and Target:IsInRange(8) and S.Condemn:TimeSinceLastCast()> 4.9 then
   		-- return S.Condemn:Cast()
   	-- end

    	-- if Player:Buff(S.SuddenDeathBuff) and Target:IsInRange(8) then
   		-- return S.Condemn:Cast()
   	-- end
 	
-- actions.single_target+=/condemn
   	if (Target:HealthPercentage()<35 and S.Massacre:IsAvailable() or Target:HealthPercentage()<20) and S.Condemn:TimeSinceLastCast()> 4.9 then
   		return S.Execute:Cast()
   	end

    	if Player:Buff(S.SuddenDeathBuff)  then
   		return S.Execute:Cast()
   	end
	
-- actions.single_target+=/bladestorm,if=buff.enrage.up&(spell_targets.whirlwind>1|raid_event.adds.in>45)
	if RubimRH.CDsON() and S.Bladestorm:IsReady() and Cache.EnemiesCount[12]>=1 and Player:BuffP(S.Enrage) then
        return S.Bladestorm:Cast()
    end
	

-- actions.single_target+=/bloodthirst,if=buff.enrage.down|conduit.vicious_contempt.rank>5&target.health.pct<35&!talent.cruelty.enabled
	
  	if S.Bloodthirst:IsReady() and not Player:Buff(S.Enrage) then
        return S.Bloodthirst:Cast()
    end	
	
	
-- actions.single_target+=/bloodbath,if=buff.enrage.down|conduit.vicious_contempt.rank>5&target.health.pct<35&!talent.cruelty.enabled
	
	if RubimRH.CDsON() and S.Bloodbath:IsReady() and not Player:BuffP(S.Enrage) then
        return S.Bloodbath:Cast()
    end
-- actions.single_target+=/dragon_roar,if=buff.enrage.up&(spell_targets.whirlwind>1|raid_event.adds.in>15)
	
	if RubimRH.CDsON() and S.DragonRoar:IsReady() and Cache.EnemiesCount[12]>=1 and Player:BuffP(S.Enrage) then
        return S.DragonRoar:Cast()
    end
	
	       if S.Onslaught:IsReady() then
    	return S.Onslaught:Cast()
    end
	
	
-- raging_blow,if=charges=2
	if S.RagingBlow:IsReady() and S.RagingBlow:Charges() == 2 then
        return S.RagingBlow:Cast()
    end
	
	if S.CrushingBlow:IsReady() and S.CrushingBlow:Charges() == 2 then
        return S.CrushingBlow:Cast()
    end
	
	      if S.Bloodthirst:IsReady() then
    	return S.Bloodthirst:Cast()
    end
       if S.Bloodbath:IsReady() then
    	return S.Bloodbath:Cast()
    end
	
    if S.RagingBlow:IsReady() then
    	return S.RagingBlow:Cast()
    end
	    if S.CrushingBlow:IsReady()  then
    	return S.CrushingBlow:Cast()
    end
    	
		      if Player:Buff(S.Victorious) and S.VictoryRush:IsReady() and Cache.EnemiesCount[12]==1 then
            return S.VictoryRush:Cast()
        end
		
	if S.Whirlwind:IsReady() and Cache.EnemiesCount[10] >= 1 then
        return S.Whirlwind:Cast()
    end
	
	
	
	end
    return 0, 135328
end


RubimRH.Rotation.SetAPL(72, APL);

local function PASSIVE()
   -- print(active_enemies());
    return RubimRH.Shared()
end

RubimRH.Rotation.SetPASSIVE(72, PASSIVE);
