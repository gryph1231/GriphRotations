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

if not Spell.Warrior then
    Spell.Warrior = {};
end


RubimRH.Spell[71] = {
--INTERRUPTS
--PVP
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

	-- Racials
	
    ArcaneTorrent = Spell(80483),
    AncestralCall = Spell(274738),
    Berserking = Spell(26297),
    BloodFury = Spell(20572),
    Fireblood = Spell(265221),
    GiftoftheNaaru = Spell(59547),
    LightsJudgment = Spell(255647),

    -- Abilities
    BattleShout = Spell(6673),
    Skullsplitter = Spell(260643),
    DeadlyCalm = Spell(262228),
    DeadlyCalmBuff = Spell(262228),
    Bladestorm = Spell(227847),
    ColossusSmash = Spell(167105),
    Warbreaker = Spell(262161),
    Ravager = Spell(152277),
    ColossusSmashDebuff = Spell(208086),
    Cleave = Spell(845),
	cleave = Spell(155145),
    Slam = Spell(1464),
    CrushingAssaultBuff = Spell(278826),
    MortalStrike = Spell(12294),
    OverpowerBuff = Spell(7384),
    Dreadnaught = Spell(262150),
    ExecutionersPrecisionBuff = Spell(272866),
    Overpower = Spell(7384),
    Execute = Spell(163201),
    SweepingStrikesBuff = Spell(260708),
    TestofMight = Spell(275529),
    TestofMightBuff = Spell(275540),
    DeepWoundsDebuff = Spell(262115),
    SuddenDeathBuff = Spell(52437),
    StoneHeartBuff = Spell(225947),
    SweepingStrikes = Spell(260708),
    Whirlwind = Spell(1680),
    FervorofBattle = Spell(202316),
    Rend = Spell(772),
    RendDebuff = Spell(772),
    AngerManagement = Spell(152278),
    SeismicWave = Spell(277639),
    Charge = Spell(100),
    BloodFury = Spell(20572),
    Berserking = Spell(26297),
    ArcaneTorrent = Spell(50613),
    LightsJudgment = Spell(255647),
    Fireblood = Spell(265221),
    AncestralCall = Spell(274738),
    Avatar = Spell(107574),
    Massacre = Spell(281001),
    Condemn = Spell(330334),
    -- Defensive
    RallyingCry = Spell(97462),
    DefensiveStance = Spell(197690),
    DiebytheSword = Spell(118038),
    Victorious = Spell(32216),
    VictoryRush = Spell(34428),
    ImpendingVictory = Spell(202168),

    -- Utility
    HeroicLeap = Spell(6544), -- Unused
    Disarm = Spell(236077),
    Pummel = Spell(6552),
    Hamstring = Spell(1715),
    SharpenBlade = Spell(198817),
    SpellReflection = Spell(216890),
    Shockwave = Spell(46968),
    ShatteredDefensesBuff = Spell(248625),
    PreciseStrikesBuff = Spell(209492),
    Piercinghowl = Spell(12323),
	Intimidatingshout = Spell(5246),
    -- Misc
    WeightedBlade = Spell(253383),
healingpot = Spell(176108),
    -- Azerite
    TestofMight = Spell(275529),
    TestofMightBuff = Spell(275540),
    SeismicWave = Spell(277639),
    DeathSentence = Spell(198500),
	
}

local S = RubimRH.Spell[71] 

if not Item.Warrior then Item.Warrior = {}; end

Item.Warrior.Arms = {
	trink = Item(184016, { 13, 14 }),
    trink2 = Item(179350, { 13, 14 }),
    drums = Item(172233),
    healingpot = Item(171267),
	healthstone = Item(5512),

};

local I = Item.Warrior.Arms;


local function num(val)
    if val then
        return 1
    else
        return 0
    end
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


 
	if I.healingpot:IsReady() and Player:HealthPercentage() <= 30 and (not Player:InArena() and not Player:InBattlegrounds()) then
		return S.healingpot:Cast()
    end
	
if not Player:AffectingCombat() then
	


	if S.BattleShout:IsReady() and Player:BuffRemains(S.BattleShout)<300 then
        return S.BattleShout:Cast()
    end











	if not RubimRH.queuedSpell[1]:CooldownUp() or not Target:IsInRange(10) or not Player:AffectingCombat() then
		RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
	end
	
	return 892447
end 



	
	--PVP----------------------------------------------------------------------------------------------------------------
if Player:AffectingCombat() and (Target:IsAPlayer() or Player:InArena() or Player:InBattlegrounds()) then
	
	
	
	
	-- Impending Victory -> Cast when < 85% HP
        if S.ImpendingVictory:IsReady() and Target:IsInRange(8)
                and Player:HealthPercentage() <= 50 then
            return S.VictoryRush:Cast()
        end

        -- Victory Rush -> Cast when < 85% HP
        if Player:Buff(S.Victorious)
                and S.VictoryRush:IsReady() and Target:IsInRange(8)
                and Player:HealthPercentage() <= 50 then
            return S.VictoryRush:Cast()
        end
	
	
	
	
	

	end




	-- if I.trink:IsReady() and I.trink:IsEquipped() and Target:IsInRange(8) and RubimRH.CDsON() then
		-- return S.trink:Cast()
    -- end




	if RubimRH.QueuedSpell():IsReadyQueue() then
        return RubimRH.QueuedSpell():Cast()
    end
	
	if not RubimRH.queuedSpell[1]:CooldownUp() or not Target:IsInRange(10) or not Player:AffectingCombat() then
		RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
	end
	










--INTERRUPTS

	if (Target:IsCasting(S.Polymorph)
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
	and Target:CastPercentage()> 20 and RubimRH.InterruptsON() and S.Pummel:IsReady(8) then
	return S.Pummel:Cast()
	end
	

    Execute = function()

-- actions.execute=deadly_calm
	if S.DeadlyCalm:IsReady() and Target:IsInRange(8) then
        return S.DeadlyCalm:Cast()
    end


-- actions.execute+=/rend,if=remains<=duration*0.3
	if S.Rend:IsReady() and Target:IsInRange(8) and Target:DebuffRemains(S.RendDebuff)< 3 then
        return S.Rend:Cast()
    end


-- actions.execute+=/skullsplitter,if=rage<60&(!talent.deadly_calm.enabled|buff.deadly_calm.down)
	if S.Skullsplitter:IsReady() and Target:IsInRange(8) and Player:Rage()<60 and (not S.DeadlyCalm:IsAvailable() or not Player:Buff(S.DeadlyCalm)) then
        return S.Skullsplitter:Cast()
    end



-- actions.execute+=/avatar,if=cooldown.colossus_smash.remains<8&gcd.remains=0
	if S.Avatar:IsReady() and RubimRH.CDsON() and Target:IsInRange(8) and S.ColossusSmash:CooldownRemains()<8 and Player:GCDRemains() < 0.1 then
        return S.Avatar:Cast()
    end



-- actions.execute+=/ravager,if=buff.avatar.remains<18&!dot.ravager.remains
	if S.Ravager:IsReady() and RubimRH.CDsON() and Cache.EnemiesCount[8]>=1 and Player:BuffRemains(S.Avatar)< 1 and not Target:Debuff(S.Ravager) then
        return S.Ravager:Cast()
    end


-- actions.execute+=/cleave,if=spell_targets.whirlwind>1&dot.deep_wounds.remains<gcd
	if S.Cleave:IsReady() and Cache.EnemiesCount[8]>1 and Target:DebuffRemains(S.DeepWoundsDebuff)<Player:GCD() then
        return S.cleave:Cast()
    end


-- actions.execute+=/warbreaker
	if S.Warbreaker:IsReady() and Target:IsInRange(8) then
        return S.Warbreaker:Cast()
    end


-- actions.execute+=/colossus_smash
	if S.ColossusSmash:IsReady() and Target:IsInRange(8) then
        return S.ColossusSmash:Cast()
    end


-- actions.execute+=/condemn,if=debuff.colossus_smash.up|buff.sudden_death.react|rage>65
	if Player:Rage()>=20 and (Target:HealthPercentage()<=35 and S.Massacre:IsAvailable() or Target:HealthPercentage()>=80 or Target:HealthPercentage()<=20 or Player:Buff(S.SuddenDeathBuff))  and Target:IsInRange(8) and (Target:Debuff(S.ColossusSmashDebuff) or Player:Buff(S.SuddenDeathBuff) or Player:Rage()>65) then
        return S.Condemn:Cast()
    end


-- actions.execute+=/overpower,if=charges=2
	if S.Overpower:IsReady() and Target:IsInRange(8) and S.Overpower:ChargesFractional() == 2 then
        return S.Overpower:Cast()
    end


-- actions.execute+=/bladestorm,if=buff.deadly_calm.down&rage<50
	if S.Bladestorm:IsReady() and RubimRH.CDsON() and Target:IsInRange(8) and Player:Buff(S.DeadlyCalmBuff) and Player:Rage()<50 then
        return S.Bladestorm:Cast()
    end


-- actions.execute+=/mortal_strike,if=dot.deep_wounds.remains<=gcd
	if S.MortalStrike:IsReady() and Target:IsInRange(8) and Target:DebuffRemains(S.DeepWoundsDebuff)<= Player:GCD() then
        return S.MortalStrike:Cast()
    end


-- actions.execute+=/skullsplitter,if=rage<40
	if S.Skullsplitter:IsReady() and Target:IsInRange(8) and Player:Rage()<40 then
        return S.Skullsplitter:Cast()
    end


-- actions.execute+=/overpower
	if S.Overpower:IsReady() and Target:IsInRange(8) then
        return S.Overpower:Cast()
    end


-- actions.execute+=/condemn
	if Player:Rage()>=20 and (Target:HealthPercentage()<=35 and S.Massacre:IsAvailable() or Target:HealthPercentage()>=80 or Target:HealthPercentage()<=20 or Player:Buff(S.SuddenDeathBuff))  and Target:IsInRange(8) then
        return S.Condemn:Cast()
    end


-- actions.execute+=/execute
	if S.Execute:IsReady() and Target:IsInRange(8) then
        return S.Execute:Cast()
    end






end

    hac = function()
-- actions.hac=skullsplitter,if=rage<60&buff.deadly_calm.down
	if S.Skullsplitter:IsReady() and Target:IsInRange(8) and Player:Rage()<60 and not Player:Buff(S.DeadlyCalmBuff) then
        return S.Skullsplitter:Cast()
    end



-- actions.hac+=/avatar,if=cooldown.colossus_smash.remains<1
	if S.Avatar:IsReady() and RubimRH.CDsON() and Target:IsInRange(8) and S.ColossusSmash:CooldownRemains()<1 then
        return S.Avatar:Cast()
    end


-- actions.hac+=/cleave,if=dot.deep_wounds.remains<=gcd
	if S.Cleave:IsReady() and Target:IsInRange(8) and Target:DebuffRemains(S.DeepWoundsDebuff)<Player:GCD() then
        return S.cleave:Cast()
    end


-- actions.hac+=/warbreaker
	if S.Warbreaker:IsReady() and Target:IsInRange(8) then
        return S.Warbreaker:Cast()
    end


-- actions.hac+=/bladestorm
	if S.Bladestorm:IsReady() and RubimRH.CDsON() and Target:IsInRange(8) then
        return S.Bladestorm:Cast()
    end


-- actions.hac+=/ravager
	if S.Ravager:IsReady() and Cache.EnemiesCount[8]>=1 and RubimRH.CDsON() then
        return S.Ravager:Cast()
    end


-- actions.hac+=/colossus_smash
	if S.ColossusSmash:IsReady() and Target:IsInRange(8) then
        return S.ColossusSmash:Cast()
    end


-- actions.hac+=/rend,if=remains<=duration*0.3&buff.sweeping_strikes.up
	if S.Rend:IsReady() and Target:IsInRange(8) and Target:DebuffRemains(S.RendDebuff)< 3 and Player:Buff(S.SweepingStrikes) then
        return S.Rend:Cast()
    end

-- actions.hac+=/cleave
	if S.Cleave:IsReady() and Target:IsInRange(8) then
        return S.cleave:Cast()
    end


-- actions.hac+=/mortal_strike,if=buff.sweeping_strikes.up|dot.deep_wounds.remains<gcd&!talent.cleave.enabled
	if S.MortalStrike:IsReady() and Target:IsInRange(8) and (Player:Buff(S.SweepingStrikesBuff) or Target:DebuffRemains(S.DeepWoundsDebuff)<Player:GCD() and not S.Cleave:IsAvailable()) then
        return S.MortalStrike:Cast()
    end


-- actions.hac+=/overpower,if=talent.dreadnaught.enabled
	if S.Overpower:IsReady() and Target:IsInRange(8) and S.Dreadnaught:IsAvailable() then
        return S.Overpower:Cast()
    end


-- actions.hac+=/condemn
	if Player:Rage()>=20 and (Target:HealthPercentage()<=35 and S.Massacre:IsAvailable() or Target:HealthPercentage()>=80 or Target:HealthPercentage()<=20 or Player:Buff(S.SuddenDeathBuff)) and Target:IsInRange(8) then
        return S.Condemn:Cast()
    end


-- actions.hac+=/execute,if=buff.sweeping_strikes.up
	if S.Execute:IsReady() and Target:IsInRange(8) and Player:Buff(S.SweepingStrikesBuff) then
        return S.Execute:Cast()
    end

-- actions.hac+=/overpower
	if S.Overpower:IsReady() and Target:IsInRange(8) then
        return S.Overpower:Cast()
    end


-- actions.hac+=/whirlwind
	if S.Whirlwind:IsReady() and Cache.EnemiesCount[8]>=1 then
        return S.Whirlwind:Cast()
    end

end



    ST = function()
-- actions.single_target=avatar,if=cooldown.colossus_smash.remains<8&gcd.remains=0
	if S.Avatar:IsReady() and RubimRH.CDsON() and Target:IsInRange(8) and S.ColossusSmash:CooldownRemains()<8 and Player:GCDRemains() < 0.1 then
        return S.Avatar:Cast()
    end

-- actions.single_target+=/rend,if=remains<=duration*0.3
	if S.Rend:IsReady() and Target:IsInRange(8) and Target:DebuffRemains(S.RendDebuff)< 3 then
        return S.Rend:Cast()
    end

-- actions.single_target+=/cleave,if=spell_targets.whirlwind>1&dot.deep_wounds.remains<gcd
	if S.Cleave:IsReady() and Cache.EnemiesCount[8]>1 and Target:DebuffRemains(S.DeepWoundsDebuff)<Player:GCD() then
        return S.cleave:Cast()
    end

-- actions.single_target+=/warbreaker
	if S.Warbreaker:IsReady() and Target:IsInRange(8) then
        return S.Warbreaker:Cast()
    end

-- actions.single_target+=/colossus_smash
	if S.ColossusSmash:IsReady() and Target:IsInRange(8) then
        return S.ColossusSmash:Cast()
    end


-- actions.single_target+=/ravager,if=buff.avatar.remains<18&!dot.ravager.remains
	if S.Ravager:IsReady() and Cache.EnemiesCount[8]>=1 and RubimRH.CDsON() and Player:BuffRemains(S.Avatar)<18 and not Target:Debuff(S.Ravager) then
        return S.Ravager:Cast()
    end


-- actions.single_target+=/overpower,if=charges=2
	if S.Overpower:IsReady() and Target:IsInRange(8) and S.Overpower:ChargesFractional() == 2 then
        return S.Overpower:Cast()
    end


-- actions.single_target+=/bladestorm,if=buff.deadly_calm.down&(debuff.colossus_smash.up&rage<30|rage<70)
	if S.Bladestorm:IsReady() and RubimRH.CDsON() and Target:IsInRange(8) and (not Player:Buff(S.DeadlyCalmBuff) and Target:Debuff(S.ColossusSmashDebuff) and Player:Rage()<30 or Player:Rage()<70)then
        return S.Bladestorm:Cast()
    end

-- actions.single_target+=/mortal_strike,if=buff.overpower.stack>=2&buff.deadly_calm.down|(dot.deep_wounds.remains<=gcd&cooldown.colossus_smash.remains>gcd)
	if S.MortalStrike:IsReady() and Target:IsInRange(8) and (Player:BuffStack(S.Overpower)>= 2 and not Player:Buff(S.DeadlyCalmBuff) or (Target:DebuffRemains(S.DeepWoundsDebuff)<= Player:GCD() and S.ColossusSmash:CooldownRemains()>Player:GCD())) then
        return S.MortalStrike:Cast()
    end

-- actions.single_target+=/deadly_calm
	if S.DeadlyCalm:IsReady() and Target:IsInRange(8) then
        return S.DeadlyCalm:Cast()
    end


-- actions.single_target+=/skullsplitter,if=rage<60&buff.deadly_calm.down
	if S.Skullsplitter:IsReady() and Target:IsInRange(8) and Player:Rage()<60 and Player:Buff(S.DeadlyCalmBuff) then
        return S.Skullsplitter:Cast()
    end


-- actions.single_target+=/overpower
	if S.Overpower:IsReady() and Target:IsInRange(8) then
        return S.Overpower:Cast()
    end


-- actions.single_target+=/condemn,if=buff.sudden_death.react
	if Player:Rage()>=20 and (Target:HealthPercentage()<=35 and S.Massacre:IsAvailable() or Target:HealthPercentage()>=80 or Target:HealthPercentage()<=20 or Player:Buff(S.SuddenDeathBuff)) and Target:IsInRange(8) and Player:Buff(S.SuddenDeathBuff) then
        return S.Condemn:Cast()
    end


-- actions.single_target+=/execute,if=buff.sudden_death.react
	if S.Execute:IsReady() and Target:IsInRange(8) and Player:Buff(S.SuddenDeathBuff) then
        return S.Execute:Cast()
    end


-- actions.single_target+=/mortal_strike
	if S.MortalStrike:IsReady() and Target:IsInRange(8) then
        return S.MortalStrike:Cast()
    end


-- actions.single_target+=/whirlwind,if=talent.fervor_of_battle.enabled
	if S.Whirlwind:IsReady() and Cache.EnemiesCount[8]>=1 and S.FervorofBattle:IsAvailable() then
        return S.Whirlwind:Cast()
    end

-- actions.single_target+=/slam,if=!talent.fervor_of_battle.enabled
	if S.Slam:IsReady() and Target:IsInRange(8) and not S.FervorofBattle:IsAvailable() then
        return S.Slam:Cast()
    end



end







-- # Executed every time the actor is available.
-- actions=charge
-- actions+=/auto_attack
-- actions+=/potion
-- actions+=/blood_fury,if=debuff.colossus_smash.up
if S.BloodFury:IsReady() and Target:Debuff(S.ColossusSmash) and RubimRH.CDsON() then
return S.BloodFury:Cast()
end
-- actions+=/berserking,if=debuff.colossus_smash.remains>6
-- actions+=/arcane_torrent,if=cooldown.mortal_strike.remains>1.5&rage<50
-- actions+=/lights_judgment,if=debuff.colossus_smash.down&cooldown.mortal_strike.remains
-- actions+=/fireblood,if=debuff.colossus_smash.up
-- actions+=/ancestral_call,if=debuff.colossus_smash.up
-- actions+=/bag_of_tricks,if=debuff.colossus_smash.down&cooldown.mortal_strike.remains
-- actions+=/sweeping_strikes,if=spell_targets.whirlwind>1&(cooldown.bladestorm.remains>15|talent.ravager.enabled)
if S.SweepingStrikes:IsReady() and RubimRH.AoEON() and Cache.EnemiesCount[8]>1 and Target:IsInRange(8) and (S.Bladestorm:CooldownRemains()>15 or S.Ravager:IsAvailable()) then
return S.SweepingStrikes:Cast()
end
-- actions+=/run_action_list,name=hac,if=raid_event.adds.exists
    if hac() ~= nil and Cache.EnemiesCount[8]>1 and RubimRH.AoEON() then
        return hac()
    end
-- actions+=/run_action_list,name=execute,if=(talent.massacre.enabled&target.health.pct<35)|target.health.pct<20|(target.health.pct>80&covenant.venthyr)
    if Execute() ~= nil and (S.Massacre:IsAvailable() and Target:HealthPercentage()<35 or Target:HealthPercentage()<20 or Target:HealthPercentage()>80)then
        return Execute()
    end
-- actions+=/run_action_list,name=single_target
    if ST() ~= nil then
        return ST()
    end



    return 0, 135328
end




RubimRH.Rotation.SetAPL(71, APL);

local function PASSIVE()
    
end

RubimRH.Rotation.SetPASSIVE(71, PASSIVE);