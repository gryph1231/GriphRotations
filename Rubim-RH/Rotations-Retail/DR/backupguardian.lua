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
RubimRH.Spell[104] = {
Quake = Spell(240447),

MassEntanglement = Spell(102359),
forceofnature = Spell(205636),
Vortex = Spell(102793),
vortex = Spell(58984),
FrenziedRegeneration = Spell(22842),
Thrash = Spell(20549), --warstomp
ThrashDebuff = Spell(192090),
Mangle = Spell(33917),
Ironfur = Spell(192081),
StarfallBuff = Spell(191034),
TravelForm = Spell(783),
BearForm = Spell(5487),
CatForm = Spell(768),
Rebirth = Spell(20484),
EntanglingRoots = Spell(339),
Cyclone = Spell(33786),
cyclone = Spell(287712),
swiftmend = Spell(18562),
typhoon = Spell(209749),
Rejuvenation = Spell(774),
WildGrowth = Spell(48438),
RemoveCorruption = Spell(2782),
Dash = Spell(1850),
StampedingRoar = Spell(106898),
RavenousFrenzy = Spell(323546),
ConvoketheSpirits = Spell(323764),
Berserk = Spell(106951),
Berserking = Spell(26297),
    Gore                                    = Spell(210706),
    GoreBuff                                = Spell(93622),
    GoryFur                                 = Spell(201671),
    Mangle                                  = Spell(33917),
    Maul                                    = Spell(6807),
    Moonfire                                = Spell(8921),
    MoonfireDebuff                          = Spell(164812),
    Sunfire                                 = Spell(197630),
    SunfireDebuff                           = Spell(164815),
    Starsurge                               = Spell(197626),
    LunarEmpowerment                        = Spell(164547),
    SolarEmpowerment                        = Spell(164545),
    LunarStrike                             = Spell(197628),
    Wrath                                   = Spell(197629),
    Regrowth                                = Spell(8936),
    Swipe                                   = Spell(213771),
    Thrash                                  = Spell(77758),
    ThrashDebuff                            = Spell(192090),
    ThrashCat                               = Spell(106830),
	ThrashBearDebuff                        = Spell(192090),
    Prowl                                   = Spell(5215),
	LayeredMane                           = Spell(279552),
    -- Talents
    BalanceAffinity                         = Spell(197488),
    BloodFrenzy                             = Spell(203962),
    Brambles                                = Spell(203953),
    BristlingFur                            = Spell(155835),
    Earthwarden                             = Spell(203974),
    EarthwardenBuff                         = Spell(203975),
    FeralAffinity                           = Spell(202155),
    GalacticGuardian                        = Spell(203964),
    GalacticGuardianBuff                    = Spell(213708),
    GuardianOfElune                         = Spell(155578),
    GuardianOfEluneBuff                     = Spell(213680),
    Incarnation                             = Spell(102558),
    LunarBeam                               = Spell(204066),
    Pulverize                               = Spell(80313),
    PulverizeBuff                           = Spell(158792),
    RestorationAffinity                     = Spell(197492),
    SouloftheForest                         = Spell(158477),
    MightyBash                              = Spell(5211),
    Typhoon                                 = Spell(132469),
    Entanglement                            = Spell(102359),
	IncarnationBuff                       = Spell(102558),
    -- Artifact
    RageoftheSleeper                        = Spell(200851),
    -- Defensive
    SurvivalInstincts                       = Spell(61336),
    Barkskin                                = Spell(22812),
    -- Utility
    Growl                                   = Spell(6795),
    SkullBash                               = Spell(106839),
	RemoveCorruption                        = Spell(2782),
	IncapacitatingRoar                      = Spell(99),
    -- Affinity
    FerociousBite                           = Spell(22568),
    HealingTouch                            = Spell(5185),
    Rake                                    = Spell(1822),
    RakeDebuff                              = Spell(155722),
    Rejuvenation                            = Spell(774),
    Rip                                     = Spell(1079),
    Shred                                   = Spell(5221),
    Swiftmend                               = Spell(18562),
	WildChargeTalent                      = Spell(102401),
    WildChargeBear                        = Spell(16979),
    -- Shapeshift
    BearForm                                = Spell(5487),
    CatForm                                 = Spell(768),
    MoonkinForm                             = Spell(197625),
    TravelForm                              = Spell(783),
	HeartEssence                            = Spell(298554),
    SharpenedClawsBuff                      = Spell(279943),
Steward = Spell(324739),
	lust1 = Spell(57724),
	lust2 = Spell(57723),
	lust3 = Spell(80354),
	lust4 = Spell(95809),
	lust5 = Spell(264689),
	lustAT = Spell(155145), --fireblood
	rez = Spell(20594),--stoneskin
trinket= Spell(59547), -- gift of narru
healingpot = Spell(176108), --pot ID
healthstone = Spell(291944), -- regen
phialofserenity = Spell(20549), -- war stomp

};



local S = RubimRH.Spell[104];
local G = RubimRH.Spell[1]; -- General Skills

-- Items
if not Item.Druid then
    Item.Druid = {}
end
Item.Druid.Guardian = {
    trink = Item(179342, { 13, 14 }),
	rez = Item(158379),
	drums = Item(172233),
    healingpot = Item(169451), --astral healing pot
    healthstone = Item(5512), --health stone
	phialofserenity = Item(177278), --phial of serenity

};
local I = Item.Druid.Guardian;


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




--- ======= ACTION LISTS =======
local function APL()
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

	

	
    if I.healingpot:IsReady() and Player:HealthPercentage() <= 35 and Player:AffectingCombat() then
        return S.healingpot:Cast()
    end


	if S.rez:ID() ==  RubimRH.queuedSpell[1]:ID() and I.rez:IsReady() then
    	return S.rez:Cast() -- BIND brez to stoneform
	end
	
	if S.rez:ID() ==  RubimRH.queuedSpell[1]:ID() and not I.rez:IsReady() then
		RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
	end	
	
	if S.lustAT:ID() ==  RubimRH.queuedSpell[1]:ID() and not Player:Debuff(S.lust1) and not Player:Debuff(S.lust2) and not Player:Debuff(S.lust3) and not Player:Debuff(S.lust4) and not Player:Debuff(S.lust5) and (I.drums:IsReady()) then
    	return S.lustAT:Cast() -- BIND LUST KEYBIND IN BINDPAD TO ARCANE TORRENT
	end
	
	if S.lustAT:ID() ==  RubimRH.queuedSpell[1]:ID() and (Player:Debuff(S.lust1) or Player:Debuff(S.lust2) or Player:Debuff(S.lust3) or Player:Debuff(S.lust4) or Player:Debuff(S.lust5)) then
		RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
	end
	
	  if I.trink:IsReady() and Cache.EnemiesCount[5]>=1 and I.trink:IsEquipped() and RubimRH.CDsON() then
         return S.trinket:Cast()
     end	 
	 
	
	

		if RubimRH.QueuedSpell():IsReadyQueue() then
        return RubimRH.QueuedSpell():Cast()
    end
	



	
	if (not RubimRH.queuedSpell[1]:CooldownUp() or not Player:AffectingCombat() or Cache.EnemiesCount[20]==0) then 
        RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
    end
	
    if IsTanking and Player:BuffP(S.BearForm) then	
	
	  --Frenzied Regeneration
      if Player:HealthPercentage() < 50 and S.FrenziedRegeneration:IsCastableP() and Player:Rage() > 10
        and not Player:Buff(S.FrenziedRegeneration) and not Player:HealingAbsorbed() then
        return S.FrenziedRegeneration:Cast()
      end
      if S.Ironfur:IsCastableP() and Player:Rage() >= S.Ironfur:Cost() + 1 and IsTanking and (not Player:Buff(S.Ironfur) 
        or (Player:BuffStack(S.Ironfur) < 2 and Player:BuffRefreshableP(S.Ironfur, 2.4))) then
        return S.Ironfur:Cast()
      end
      -- barkskin,if=buff.bear_form.up
      if S.Barkskin:IsCastableP() and Player:HealthPercentage() < 65 then
        return S.Barkskin:Cast()
      end

      -- Survival Instincts
      if S.SurvivalInstincts:IsCastableP() and Player:HealthPercentage() < 65 then
        return S.SurvivalInstincts:Cast()
      end
      -- bristling_fur,if=buff.bear_form.up
      if S.BristlingFur:IsCastableP() and Player:Rage() < 30 then
        return S.BristlingFur:Cast()
      end
	  
    end
	
-- START IN COMBAT ROTATION HERE
if Player:CanAttack(Target) then 

	
    -- bear_form
    if S.BearForm:IsCastableP() and Player:BuffDownP(S.BearForm) and not Player:BuffP(S.CatForm) and not Player:BuffP(S.TravelForm) and not Player:BuffP(S.MoonkinForm) then
      return S.BearForm:Cast()
    end
    if S.Berserking:IsReadyP() and Player:BuffP(S.BearForm) and RubimRH.CDsON() and Cache.EnemiesCount[8]>=1 then
      return S.Berserking:Cast()
    end

-- ravenous_frenzy
    if S.RavenousFrenzy:IsReadyP() and Cache.EnemiesCount[8]>=1 and RubimRH.CDsON() then
      return S.RavenousFrenzy:Cast()
    end
-- convoke_the_spirits,if=!druid.catweave_bear&!druid.owlweave_bear
    if S.ConvoketheSpirits:IsReadyP() and RubimRH.CDsON() and Cache.EnemiesCount[8]>=1 then
      return S.ConvoketheSpirits:Cast()
    end
-- berserk_bear,if=(buff.ravenous_frenzy.up|!covenant.venthyr)
    if S.Berserk:IsReadyP()  and (Player:BuffP(S.RavenousFrenzy) or RubimRH.CDsON()) and Cache.EnemiesCount[8]>=1 then
      return S.Berserk:Cast()
    end
-- incarnation,if=(buff.ravenous_frenzy.up|!covenant.venthyr)
    if S.Incarnation:IsReadyP()  and (Player:BuffP(S.RavenousFrenzy) or RubimRH.CDsON()) and Cache.EnemiesCount[8]>=1 then
      return S.Incarnation:Cast()
    end
-- empower_bond,if=(!druid.catweave_bear&!druid.owlweave_bear)|active_enemies>=2
    if S.Incarnation:IsReadyP()  and (Player:BuffP(S.RavenousFrenzy) or RubimRH.CDsON()) and Cache.EnemiesCount[8]>=1 then
      return S.Incarnation:Cast()
    end
-- barkskin,if=(talent.brambles.enabled)&(buff.bear_form.up)
    -- if S.Barkskin:IsReadyP()  and S.Brambles:IsAvailable() and Player:BuffP(S.BearForm) and Cache.EnemiesCount[8]>=1 then
      -- return S.Barkskin:Cast()
    -- end
	
	
	
-- adaptive_swarm,if=(!dot.adaptive_swarm_damage.ticking&!action.adaptive_swarm_damage.in_flight
-- &(!dot.adaptive_swarm_heal.ticking|dot.adaptive_swarm_heal.remains>3)
-- |dot.adaptive_swarm_damage.stack<3&dot.adaptive_swarm_damage.remains<5&dot.adaptive_swarm_damage.ticking)



-- moonfire,if=(buff.galactic_guardian.up&druid.owlweave_bear)&active_enemies<=3
    if S.Moonfire:IsReadyP()  and Player:BuffP(S.GalacticGuardianBuff) and Player:BuffP(S.MoonkinForm) and Cache.EnemiesCount[12]<=3 then
      return S.Moonfire:Cast()
    end


-- thrash_bear,target_if=refreshable|dot.thrash_bear.stack<3|(dot.thrash_bear.stack<4&runeforge.luffainfused_embrace.equipped)|active_enemies>=4



-- swipe,if=buff.incarnation_guardian_of_ursoc.down&buff.berserk_bear.down&active_enemies>=4



-- maul,if=buff.incarnation.up&active_enemies<2



-- maul,if=(buff.savage_combatant.stack>=1)&(buff.tooth_and_claw.up)&buff.incarnation.up&active_enemies=2



-- mangle,if=buff.incarnation.up&active_enemies<=3



-- moonfire,target_if=refreshable&active_enemies<=3



-- maul,if=(((buff.tooth_and_claw.stack>=2)|(buff.tooth_and_claw.up&buff.tooth_and_claw.remains<1.5)|(buff.savage_combatant.stack>=3))&active_enemies<3)



-- thrash_bear,if=active_enemies>1



-- moonfire,if=(buff.galactic_guardian.up&druid.catweave_bear)&active_enemies<=3|(buff.galactic_guardian.up&!druid.catweave_bear&!druid.owlweave_bear)&active_enemies<=3



-- mangle,if=((rage<90)&active_enemies<3)|((rage<85)&active_enemies<3&talent.soul_of_the_forest.enabled)



-- pulverize,target_if=dot.thrash_bear.stack>2



-- thrash_bear



-- maul,if=active_enemies<3



-- swipe_bear



-- ironfur,if=rage.deficit<40&buff.ironfur.remains<0.5

end

    if not Player:AffectingCombat() then

-- START OUT OF COMBAT ROTATION HERE

    -- bear_form
    if S.BearForm:IsCastableP() and Player:BuffDownP(S.BearForm) and not Player:BuffP(S.CatForm) and not Player:BuffP(S.TravelForm) and not Player:BuffP(S.MoonkinForm) then
      return S.BearForm:Cast()
    end

  if S.Steward:IsCastable() and I.phialofserenity:Count()<=1 and Cache.EnemiesCount[20]==0 then
        return S.Steward:Cast()
    end
	

        return 0, 625999
    end
	
    return 0, 135328
end

RubimRH.Rotation.SetAPL(104, APL)

local function PASSIVE()


end
RubimRH.Rotation.SetPASSIVE(104, PASSIVE)
