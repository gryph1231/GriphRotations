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

if not Spell.Monk then
    Spell.Monk = {};
end

RubimRH.Spell[269] = {

MarkoftheCrane = Spell(228287),

 -- Racials
  Bloodlust                             = Spell(2825),
  ArcaneTorrent                         = Spell(25046),
  Berserking                            = Spell(26297),
  BloodFury                             = Spell(20572),
  GiftoftheNaaru                        = Spell(59547),
  fortifyingbrew                        = Spell(58984),--shadowmeld
  QuakingPalm                           = Spell(107079),
  expelharm                             = Spell(265221),
  AncestralCall                         = Spell(274738),

  -- Abilities
  TigerPalm                             = Spell(100780),
  RisingSunKick                         = Spell(107428),
  FistsofFury                           = Spell(113656),
  SpinningCraneKick                     = Spell(101546),
  StormEarthandFire                     = Spell(137639),
  FlyingSerpentKick                     = Spell(101545),
  FlyingSerpentKick2                    = Spell(115057),
  TouchofDeath                          = Spell(322109),
  CracklingJadeLightning                = Spell(117952),
  BlackoutKick                          = Spell(100784),
  BlackoutKickBuff                      = Spell(116768),
  DanceofChijiBuff                      = Spell(325202),
DanceofChijiBuffAzerite = Spell(286585),
  -- Talents
  ChiWave                               = Spell(115098),
  ChiBurst                              = Spell(123986),
  FistoftheWhiteTiger                   = Spell(261947),
  HitCombo                              = Spell(196741),
  InvokeXuentheWhiteTiger               = Spell(123904),
  RushingJadeWind                       = Spell(261715),
  WhirlingDragonPunch                   = Spell(152175),
  WhirlingDragonPunchBuff = Spell(196742),
  Serenity                              = Spell(152173),
ConflictandStrife = Spell(169900),
  -- Artifact
  StrikeOfTheWindlord                   = Spell(205320),
  	lust1 = Spell(57724),
	lust2 = Spell(57723),
	lust3 = Spell(80354),
	lust4 = Spell(95809),
	lust5 = Spell(264689),
lustAT = Spell(155145),
  -- Defensive
  TouchofKarma                          = Spell(122470),
  DiffuseMagic                          = Spell(122783), --Talent
  DampenHarm                            = Spell(122278), --Talent

  -- Utility
  Detox                                 = Spell(218164),
  Effuse                                = Spell(116694),
  EnergizingElixir                      = Spell(115288), --Talent
  TigersLust                            = Spell(116841), --Talent
  LegSweep                              = Spell(119381), 
  Disable                               = Spell(116095),
  HealingElixir                         = Spell(122281), --Talent
  Paralysis                             = Spell(115078),
  SpearHandStrike                       = Spell(116705),

  -- Legendaries
  TheEmperorsCapacitor                  = Spell(235054),
ChiEnergy = Spell(337571),
  -- Tier Set
  PressurePoint                         = Spell(247255),

  -- Azerite Traits
  SwiftRoundhouse                       = Spell(277669),
  SwiftRoundhouseBuff                   = Spell(278710),
  FortifyingBrew = Spell(243435),
  RingofPeace = Spell(116844),
  -- PvP Abilities
  ReverseHarm                           = Spell(287771),
  ExpelHarm = Spell(322101),
  --8.2 Essences
  UnleashHeartOfAzeroth                 = Spell(280431),
  BloodOfTheEnemy                       = Spell(297108),
  BloodOfTheEnemy2                      = Spell(298273),
  BloodOfTheEnemy3                      = Spell(298277),
  ConcentratedFlame                     = Spell(295373),
  ConcentratedFlame2                    = Spell(299349),
  ConcentratedFlame3                    = Spell(299353),
  GuardianOfAzeroth                     = Spell(295840),
  GuardianOfAzeroth2                    = Spell(299355),
  GuardianOfAzeroth3                    = Spell(299358),
  FocusedAzeriteBeam                    = Spell(295258),
  FocusedAzeriteBeam2                   = Spell(299336),
  FocusedAzeriteBeam3                   = Spell(299338),
  PurifyingBlast                        = Spell(295337),
  PurifyingBlast2                       = Spell(299345),
  PurifyingBlast3                       = Spell(299347),
  TheUnboundForce                       = Spell(298452),
  TheUnboundForce2                      = Spell(299376),
  TheUnboundForce3                      = Spell(299378),
  RippleInSpace                         = Spell(302731),
  RippleInSpace2                        = Spell(302982),
  RippleInSpace3                        = Spell(302983),
  WorldveinResonance                    = Spell(295186),
  WorldveinResonance2                   = Spell(298628),
  WorldveinResonance3                   = Spell(299334),
  MemoryOfLucidDreams                   = Spell(298357),
  MemoryOfLucidDreams2                  = Spell(299372),
  MemoryOfLucidDreams3                  = Spell(299374),

  -- Misc
  --PoolEnergy                            = Spell(9999000010)
	
}

local S = RubimRH.Spell[269] 

if not Item.Monk then Item.Monk = {}; end

Item.Monk.Windwalker = {
	trink2 = Item(159617, { 13, 14 }),
	trink = Item(169311, { 13, 14 }),
	lust = Item(164978)
   
};

local I = Item.Monk.Windwalker;


local function num(val)
    if val then
        return 1
    else
        return 0
    end
end

local function GetEnemiesCount(range)
    if range == nil then range = 10 end
	 -- Unit Update - Update differently depending on if splash data is being used
	if RubimRH.AoEON() then       
	        if RubimRH.db.profile[62].useSplashData == "Enabled" then	
                HL.GetEnemies(range, nil, true, Target)
                return Cache.EnemiesCount[range]
            else
                return active_enemies()
            end
    else
        return 1
    end
end



local function EnergyTimeToMaxPredicted()
    return math.floor(Player:EnergyTimeToMaxPredicted() * 10 + 0.5) / 10;
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
 
 local IsTanking = Player:IsTankingAoE(8) or Player:IsTanking(Target)

 
 	if Player:IsChanneling() or Player:IsCasting() then
        return 0, "Interface\\Addons\\Rubim-RH\\Media\\channel.tga"
    end

 
-- Out of Combat
if not Player:AffectingCombat() then

	
	






	if not RubimRH.queuedSpell[1]:CooldownUp() or not Target:IsInRange(10) or not Player:AffectingCombat() then
		RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
	end
	
	return 0, "Interface\\Addons\\Rubim-RH\\Media\\mount2.tga"
end 

	
   if S.TouchofKarma:IsReady() and IsTanking and Player:HealthPercentage() <= 85 and Cache.EnemiesCount[12] >= 1 then
    	return S.TouchofKarma:Cast()
    end
	
if S.FortifyingBrew:IsReadyP() and Player:HealthPercentage()<=40 then 
return S.fortifyingbrew:Cast()
end
if S.DiffuseMagic:IsReadyP() and Player:HealthPercentage()<=20 then 
return S.DiffuseMagic:Cast()
end


	    -- if S.ConcentratedFlame:IsReady() and EnergyTimeToMaxPredicted() > 1 and (not Player:BuffP(S.BladeFlurry) or HL.CombatTime()<5) and (not Target:Debuff(S.ConcentratedFlamedebuff) or S.ConcentratedFlame:FullRechargeTimeP() < Player:GCD()) then
    	-- return S.UnleashHeartOfAzeroth:Cast()
    -- end
	

	
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
	
	if not RubimRH.queuedSpell[1]:CooldownUp() or not Target:IsInRange(12) or not Player:AffectingCombat() then
		RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
	end
	
	



	-- if I.trink:IsReady() and Target:IsInRange(12) and I.trink:IsEquipped() and (not Target:Debuff(S.razorcoral) or not Target:Debuff(S.ConductiveInk) and Target:HealthPercentage()<32 and Target:HealthPercentage()>=32 or not Target:Debuff(S.ConductiveInk) and (Target:DebuffStack(S.razorcoral) >= 20-10*num(Target:Debuff(S.BloodOfTheEnemy))) and Player:BuffRemainsP(S.AdrenalineRush)>18) then
         -- return S.trink:Cast()
     -- end
	 
	-- if I.trink2:IsReady() and Target:IsInRange(12) and I.trink2:IsEquipped() and (Player:BuffP(S.AdrenalineRush) or S.AdrenalineRush:CooldownRemainsP() > 20) then
        -- return S.trink2:Cast()
    -- end 
	
	if Target:Debuff(S.Paralysis) then
	return 136035
	end
	
if Player:CanAttack(Target) then 
	


-- Opener
    Opener = function()
-- fist_of_the_white_tiger,target_if=min:debuff.mark_of_the_crane.remains,if=chi.max-chi>=3
if S.FistoftheWhiteTiger:IsReadyP() and (Player:ChiDeficit() >= 3) then
return S.FistoftheWhiteTiger:Cast()
end


-- expel_harm,if=talent.chi_burst.enabled&chi.max-chi>=3
 if S.ExpelHarm:IsReadyP() and S.ChiBurst:IsAvailable() and Player:ChiDeficit() >= 3 then
      return S.expelharm:Cast()
    end



-- tiger_palm,target_if=min:debuff.mark_of_the_crane.remains+(debuff.recently_rushing_tiger_palm.up*20),if=combo_strike&chi.max-chi>=2
 if S.TigerPalm:IsReadyP() and (not Player:PrevGCD(1, S.TigerPalm) and Player:ChiDeficit() >= 2) then
      return S.TigerPalm:Cast()
    end
	


-- expel_harm
 if S.ExpelHarm:IsReadyP() then
      return S.expelharm:Cast()
    end


-- tiger_palm,target_if=min:debuff.mark_of_the_crane.remains+(debuff.recently_rushing_tiger_palm.up*20),if=chi.max-chi>=2
 if S.TigerPalm:IsReadyP() and (Player:ChiDeficit() >= 2) then
      return S.TigerPalm:Cast()
    end


end



-- # Serenity Cooldowns
    CDsSerenity = function()
-- actions.cd_serenity=variable,name=serenity_burst,op=set,value=cooldown.serenity.remains<1|fight_remains<20
 if S.Serenity:IsReadyP() and (S.Serenity:CooldownRemainsP()<1 or Target:TimeToDie()<20 and Target:IsBoss()) then
      return S.Serenity:Cast()
    end
-- actions.cd_serenity+=/invoke_xuen_the_white_tiger,if=!variable.hold_xuen|fight_remains<25
 if S.InvokeXuentheWhiteTiger:IsReadyP() then
      return S.InvokeXuentheWhiteTiger:Cast()
    end
-- actions.cd_serenity+=/guardian_of_azeroth,if=fight_remains>185|variable.serenity_burst|fight_remains<35
-- actions.cd_serenity+=/worldvein_resonance,if=variable.serenity_burst
-- actions.cd_serenity+=/blood_of_the_enemy,if=variable.serenity_burst
-- actions.cd_serenity+=/concentrated_flame,if=(cooldown.serenity.remains|cooldown.concentrated_flame.charges=2)&!dot.concentrated_flame_burn.remains&(cooldown.rising_sun_kick.remains&cooldown.fists_of_fury.remains|fight_remains<8)
-- actions.cd_serenity+=/the_unbound_force
-- actions.cd_serenity+=/purifying_blast
-- actions.cd_serenity+=/reaping_flames,if=target.time_to_pct_20>30|target.health.pct<=20|target.time_to_die<2
-- actions.cd_serenity+=/focused_azerite_beam
-- actions.cd_serenity+=/memory_of_lucid_dreams,if=energy<40
-- actions.cd_serenity+=/ripple_in_space
-- actions.cd_serenity+=/blood_fury,if=fight_remains>125|variable.serenity_burst
-- actions.cd_serenity+=/berserking,if=fight_remains>185|variable.serenity_burst
-- actions.cd_serenity+=/arcane_torrent,if=chi.max-chi>=1
-- actions.cd_serenity+=/lights_judgment
-- actions.cd_serenity+=/fireblood,if=fight_remains>125|variable.serenity_burst
-- actions.cd_serenity+=/ancestral_call,if=fight_remains>125|variable.serenity_burst
-- actions.cd_serenity+=/bag_of_tricks,if=variable.serenity_burst
-- actions.cd_serenity+=/use_item,name=ashvanes_razor_coral
-- actions.cd_serenity+=/touch_of_death,if=target.health.pct<=15
 if S.TouchofDeath:IsReadyP() and Target:HealthPercentage() <= 15 then
      return S.TouchofDeath:Cast()
    end
-- actions.cd_serenity+=/touch_of_karma,interval=90,pct_health=0.5

-- actions.cd_serenity+=/serenity,if=cooldown.rising_sun_kick.remains<2|fight_remains<15
 if S.Serenity:IsReadyP() and (S.RisingSunKick:CooldownRemainsP()<2 or Target:TimeToDie()<15 and Target:IsBoss()) and Target:IsInRange(10) then
      return S.Serenity:Cast()
    end
-- actions.cd_serenity+=/bag_of_tricks
end

-- CDS SEF
    CDsSEF = function()
-- invoke_xuen_the_white_tiger,if=!variable.hold_xuen|fight_remains<25
 if S.InvokeXuentheWhiteTiger:IsReadyP() and Target:IsInRange(10) then
      return S.InvokeXuentheWhiteTiger:Cast()
    end
-- Storm, Earth, and Fire Cooldowns
-- arcane_torrent,if=chi.max-chi>=1
-- Use Arcane Torrent if you are missing at least 1 Chi
-- touch_of_death,if=target.health.pct<=15&buff.storm_earth_and_fire.down
 if S.TouchofDeath:IsReadyP() and Target:HealthPercentage() <= 15 and not Player:BuffP(S.StormEarthandFire) then
      return S.TouchofDeath:Cast()
    end
-- blood_of_the_enemy,if=cooldown.fists_of_fury.remains<2|fight_remains<12
-- guardian_of_azeroth
-- worldvein_resonance
-- concentrated_flame,if=!dot.concentrated_flame_burn.remains&((!talent.whirling_dragon_punch.enabled|cooldown.whirling_dragon_punch.remains)&cooldown.rising_sun_kick.remains&cooldown.fists_of_fury.remains&buff.storm_earth_and_fire.down)|fight_remains<8
-- the_unbound_force
-- purifying_blast
-- reaping_flames,if=target.time_to_pct_20>30|target.health.pct<=20
-- focused_azerite_beam
-- memory_of_lucid_dreams,if=energy<40
-- ripple_in_space


-- storm_earth_and_fire,if=cooldown.storm_earth_and_fire.charges=2|fight_remains<20
-- |buff.seething_rage.up
-- |(cooldown.blood_of_the_enemy.remains+1>cooldown.storm_earth_and_fire.full_recharge_time
-- |!essence.blood_of_the_enemy.major)&cooldown.fists_of_fury.remains<10&chi>=2&cooldown.whirling_dragon_punch.remains<12

 if S.StormEarthandFire:IsReadyP() and (S.StormEarthandFire:Count()==2 or S.FistsofFury:CooldownRemainsP()<10 and Player:Chi()>=2 and S.WhirlingDragonPunch:CooldownRemainsP()<12) and Target:IsInRange(10) then
      return S.StormEarthandFire:Cast()
    end
-- use_item,name=lustrous_golden_plumage
-- touch_of_karma,interval=90,pct_health=0.5
-- blood_fury,if=fight_remains>125|buff.storm_earth_and_fire.up|fight_remains<20
-- Use Blood Fury if Touch of Death's cooldown is greater than 30 (this includes while ToD is currently active), or off cooldown when you are holding onto ToD, or when the target is about to die
-- berserking,if=fight_remains>185|buff.storm_earth_and_fire.up|fight_remains<20
-- lights_judgment
-- fireblood,if=fight_remains>125|buff.storm_earth_and_fire.up|fight_remains<20
-- ancestral_call,if=fight_remains>185|buff.storm_earth_and_fire.up|fight_remains<20
-- bag_of_tricks,if=buff.storm_earth_and_fire.down
end
	
--AoE
    AoE = function()
-- actions.aoe
-- action,conditions
-- whirling_dragon_punch,if=buff.whirling_dragon_punch.up

 if S.WhirlingDragonPunch:IsReadyP() and Player:BuffP(S.WhirlingDragonPunchBuff) and Cache.EnemiesCount[8]>=1  then
      return S.WhirlingDragonPunch:Cast()
    end
-- Actions.AoE is intended for use with Hectic_Add_Cleave and currently needs to be optimized
-- energizing_elixir,if=chi.max-chi>=2&energy.time_to_max>2|chi.max-chi>=4

 if S.EnergizingElixir:IsReadyP() and (Player:ChiDeficit() >= 2 and EnergyTimeToMaxPredicted()> 2 or Player:ChiDeficit() >= 4) then
      return S.EnergizingElixir:Cast()
    end
-- spinning_crane_kick,if=combo_strike&(buff.dance_of_chiji.up|buff.dance_of_chiji_azerite.up)
 if S.SpinningCraneKick:IsReadyP() and not Player:PrevGCD(1, S.SpinningCraneKick) and (Player:BuffP(S.DanceofChijiBuff) or Player:BuffP(S.DanceofChijiBuffAzerite))  then
      return S.SpinningCraneKick:Cast()
    end
-- fists_of_fury,if=energy.time_to_max>execute_time-1|chi.max-chi<=1|buff.storm_earth_and_fire.remains
 if S.FistsofFury:IsReadyP() and Cache.EnemiesCount[8]>=1 and (EnergyTimeToMaxPredicted()> 3 or Player:ChiDeficit() <=1 or Player:BuffP(S.StormEarthandFire)) then
      return S.FistsofFury:Cast()
    end
-- rising_sun_kick,target_if=min:debuff.mark_of_the_crane.remains,if=(talent.whirling_dragon_punch.enabled&cooldown.rising_sun_kick.duration>cooldown.whirling_dragon_punch.remains+4)&(cooldown.fists_of_fury.remains>3|chi>=5)
 if S.RisingSunKick:IsReadyP() and (S.WhirlingDragonPunch:IsAvailable() and S.WhirlingDragonPunch:CooldownRemainsP() < 4.7 and (S.FistsofFury:CooldownRemainsP()>3 or Player:Chi()>=5)) then
      return S.RisingSunKick:Cast()
    end
-- rushing_jade_wind,if=buff.rushing_jade_wind.down
 if S.RushingJadeWind:IsReadyP() and not Player:BuffP(S.RushingJadeWind) then
      return S.RushingJadeWind:Cast()
    end
-- spinning_crane_kick,if=combo_strike&
-- ((chi>3|cooldown.fists_of_fury.remains>6)
-- &(chi>=5|cooldown.fists_of_fury.remains>2)
-- |energy.time_to_max<=3)

 if S.SpinningCraneKick:IsReadyP() and not Player:PrevGCD(1, S.SpinningCraneKick) 
 and ((Player:Chi()>3 or S.FistsofFury:CooldownRemainsP()>6)
 and (Player:Chi()>=5 or S.FistsofFury:CooldownRemainsP()>2)
 or EnergyTimeToMaxPredicted()<=3) then
      return S.SpinningCraneKick:Cast()
    end

-- expel_harm,if=chi.max-chi>=1+essence.conflict_and_strife.major
 if S.ExpelHarm:IsReadyP() and Player:ChiDeficit() >=1 then
      return S.expelharm:Cast()
    end

-- fist_of_the_white_tiger,target_if=min:debuff.mark_of_the_crane.remains,if=chi.max-chi>=3
if S.FistoftheWhiteTiger:IsReadyP() and (Player:ChiDeficit() >= 3)  then
return S.FistoftheWhiteTiger:Cast()
end

-- chi_burst,if=chi.max-chi>=2
 if S.ChiBurst:IsReadyP() and S.ChiBurst:IsAvailable() and Player:ChiDeficit() >= 2 then
      return S.ChiBurst:Cast()
    end
	
-- tiger_palm,target_if=min:debuff.mark_of_the_crane.remains,if=chi.max-chi>=2&(!talent.hit_combo.enabled|combo_strike)
 if S.TigerPalm:IsReadyP() and (Player:ChiDeficit() >= 2 and (not S.HitCombo:IsAvailable() or not Player:PrevGCD(1, S.TigerPalm))) then
      return S.TigerPalm:Cast()
    end

-- chi_wave,if=combo_strike
 if S.ChiWave:IsReadyP() and not Player:PrevGCD(1, S.ChiWave) then
      return S.ChiWave:Cast()
    end
	
-- flying_serpent_kick,if=buff.bok_proc.down,interrupt=1


-- blackout_kick,target_if=min:debuff.mark_of_the_crane.remains,if=combo_strike
-- &(buff.bok_proc.up|talent.hit_combo.enabled&prev_gcd.1.tiger_palm&chi=2&cooldown.fists_of_fury.remains<3|chi.max-chi<=1&prev_gcd.1.spinning_crane_kick)	

 if S.BlackoutKick:IsReadyP() and (not Player:PrevGCD(1, S.BlackoutKick) 
 and (Player:BuffP(S.BlackoutKickBuff) or S.HitCombo:IsAvailable() and Player:PrevGCD(1, S.TigerPalm) and Player:Chi()==2 and S.FistsofFury:CooldownRemainsP()<3 or Player:ChiDeficit() <= 1 and Player:PrevGCD(1, S.SpinningCraneKick))) then
      return S.BlackoutKick:Cast()
    end

end
	
--ST		
	ST = function()
-- whirling_dragon_punch,if=buff.whirling_dragon_punch.up
 if S.WhirlingDragonPunch:IsReadyP() and Player:BuffP(S.WhirlingDragonPunchBuff) and Cache.EnemiesCount[8]>=1 then
      return S.WhirlingDragonPunch:Cast()
    end
-- Single Target Priority
-- energizing_elixir,if=chi.max-chi>=2&energy.time_to_max>3|chi.max-chi>=4&(energy.time_to_max>2|!prev_gcd.1.tiger_palm)
 if S.EnergizingElixir:IsReadyP() and (Player:ChiDeficit() >= 2 and EnergyTimeToMaxPredicted()> 3 or Player:ChiDeficit() >= 4 and (EnergyTimeToMaxPredicted()>2 or not Player:PrevGCD(1, S.TigerPalm))) then
      return S.EnergizingElixir:Cast()
    end
-- spinning_crane_kick,if=combo_strike&(buff.dance_of_chiji.up|buff.dance_of_chiji_azerite.up)
 if S.SpinningCraneKick:IsReadyP() and not Player:PrevGCD(1, S.SpinningCraneKick) and (Player:BuffP(S.DanceofChijiBuff) or Player:BuffP(S.DanceofChijiBuffAzerite))  then
      return S.SpinningCraneKick:Cast()
    end
-- fists_of_fury
 if S.FistsofFury:IsReadyP() and Cache.EnemiesCount[8]>=1  then
      return S.FistsofFury:Cast()
    end
-- rising_sun_kick,target_if=min:debuff.mark_of_the_crane.remains,if=cooldown.serenity.remains>1|!talent.serenity.enabled
 if S.RisingSunKick:IsReadyP() and (S.Serenity:CooldownRemainsP()>1 or not S.Serenity:IsAvailable()) then
      return S.RisingSunKick:Cast()
    end
-- Use RSK on targets without Mark of the Crane debuff, if possible, and if Serenity is at least 2 seconds away
-- rushing_jade_wind,if=buff.rushing_jade_wind.down&active_enemies>1
 if S.RushingJadeWind:IsReadyP() and not Player:BuffP(S.RushingJadeWind) and Cache.EnemiesCount[12]>1 then
      return S.RushingJadeWind:Cast()
    end
-- expel_harm,if=chi.max-chi>=1+essence.conflict_and_strife.major
 if S.ExpelHarm:IsReadyP() and Player:ChiDeficit() >= 1 then
      return S.expelharm:Cast()
    end

-- fist_of_the_white_tiger,target_if=min:debuff.mark_of_the_crane.remains,if=chi<3
if S.FistoftheWhiteTiger:IsReadyP() and Player:Chi() < 3 then
return S.FistoftheWhiteTiger:Cast()
end

-- chi_burst,if=chi.max-chi>=1
if S.ChiBurst:IsReadyP() and Player:ChiDeficit() >= 1 then
return S.ChiBurst:Cast()
end

-- Use CB if you are more than 0 Chi away from max and have 1 enemy, or are more than 1 Chi away from max
-- chi_wave
if S.ChiWave:IsReadyP() and Player:ChiDeficit() >= 1 then
return S.ChiWave:Cast()
end
-- tiger_palm,target_if=min:debuff.mark_of_the_crane.remains,if=combo_strike&chi.max-chi>=2&buff.storm_earth_and_fire.down
-- Use TP if you are 4 or more chi away from max and ToD and SEF are both not up
 if S.TigerPalm:IsReadyP() and not Player:PrevGCD(1, S.TigerPalm) and Player:ChiDeficit()>=2 and not Player:BuffP(S.StormEarthandFire) then
      return S.TigerPalm:Cast()
    end


-- spinning_crane_kick,if=buff.chi_energy.stack>30-5*active_enemies&combo_strike&buff.storm_earth_and_fire.down
-- &(cooldown.rising_sun_kick.remains>2&cooldown.fists_of_fury.remains>2
-- |cooldown.rising_sun_kick.remains<3
-- &cooldown.fists_of_fury.remains>3&chi>3
-- |cooldown.rising_sun_kick.remains>3
-- &cooldown.fists_of_fury.remains<3&chi>4|chi.max-chi<=1&energy.time_to_max<2)
-- |buff.chi_energy.stack>10&fight_remains<7
 if S.SpinningCraneKick:IsReadyP() and (Player:BuffStackP(S.ChiEnergy) >30-num(active_enemies()*5) and not Player:PrevGCD(1, S.SpinningCraneKick) and not Player:BuffP(S.StormEarthandFire) 
 and (S.RisingSunKick:CooldownRemainsP()>2 and S.FistsofFury:CooldownRemainsP()>2
 or S.RisingSunKick:CooldownRemainsP()<3
 and S.FistsofFury:CooldownRemainsP()>3 and Player:Chi()>3
 or S.RisingSunKick:CooldownRemainsP()>3
 and S.FistsofFury:CooldownRemainsP()<3 and Player:Chi()>4 or Player:ChiDeficit()<=1 and EnergyTimeToMaxPredicted()<2)
 or Player:BuffStackP(S.ChiEnergy)>10 and Target:TimeToDie()<7) 
 then
      return S.SpinningCraneKick:Cast()
    end

-- blackout_kick,target_if=min:debuff.mark_of_the_crane.remains,if=
-- combo_strike
--&(talent.serenity.enabled&cooldown.serenity.remains<3
-- |cooldown.rising_sun_kick.remains>1&cooldown.fists_of_fury.remains>1
-- |cooldown.rising_sun_kick.remains<3&cooldown.fists_of_fury.remains>3&chi>2
-- |cooldown.rising_sun_kick.remains>3&cooldown.fists_of_fury.remains<3&chi>3
-- |chi>5|buff.bok_proc.up)
 
 -- Use BoK if both FoF and RSK are not close, or RSK is close and FoF is not close and you have more than 2 chi, or FoF is close RSK is not close and you have more than 3 chi, or you have more than 5 chi, or if you get a proc

 if S.BlackoutKick:IsReadyP() 
 and (not Player:PrevGCD(1, S.BlackoutKick) 
 and (S.Serenity:IsAvailable() and S.Serenity:CooldownRemainsP()<3 and RubimRH.CDsON()
 or S.RisingSunKick:CooldownRemainsP()>1 and S.FistsofFury:CooldownRemainsP()>1
 or S.RisingSunKick:CooldownRemainsP()<3 and S.FistsofFury:CooldownRemainsP()>3 and Player:Chi()>2
 or S.RisingSunKick:CooldownRemainsP()>3 and S.FistsofFury:CooldownRemainsP()<3 and Player:Chi()>3
or Player:BuffP(S.BlackoutKickBuff) or Player:Chi()>5)) then
      return S.BlackoutKick:Cast()
    end

-- tiger_palm,target_if=min:debuff.mark_of_the_crane.remains,if=combo_strike&chi.max-chi>=2
 if S.TigerPalm:IsReadyP() and not Player:PrevGCD(1, S.TigerPalm) and Player:ChiDeficit()>=2 then
      return S.TigerPalm:Cast()
    end

-- flying_serpent_kick,interrupt=1


-- Use FSK and interrupt it straight away


-- blackout_kick,target_if=min:debuff.mark_of_the_crane.remains,if=combo_strike&cooldown.fists_of_fury.remains<3&chi=2&prev_gcd.1.tiger_palm&energy.time_to_50<1
-- Use BoK if FoF is close and you have 2 chi and your last global was TP, or if you are about to cap energy and either your last gcd was TP or if you are less than 2 chi away from capping

 if S.BlackoutKick:IsReadyP() and not Player:PrevGCD(1, S.BlackoutKick) and S.FistsofFury:CooldownRemainsP()<3 and Player:Chi()==2 and Player:PrevGCD(1, S.TigerPalm) and Player:EnergyTimeToX(50, 0)<1 then
      return S.BlackoutKick:Cast()
    end




-- blackout_kick,target_if=min:debuff.mark_of_the_crane.remains,if=combo_strike&energy.time_to_max<2&(chi.max-chi<=1|prev_gcd.1.tiger_palm)	
 if S.BlackoutKick:IsReadyP() and not Player:PrevGCD(1, S.BlackoutKick) and EnergyTimeToMaxPredicted()<2 and (Player:ChiDeficit()<=1 or Player:PrevGCD(1, S.TigerPalm)) then
      return S.BlackoutKick:Cast()
    end


end	
	
	
--ALWAYS AVAILABLE
    Actions = function()
-- auto_attack
-- Executed every time the actor is available.
-- spear_hand_strike,if=target.debuff.casting.react
-- variable,name=hold_xuen,op=set,value=cooldown.invoke_xuen_the_white_tiger.remains>fight_remains|fight_remains<120&fight_remains>cooldown.serenity.remains&cooldown.serenity.remains>10
-- Variable that will tell you if you will need to wait to cast ToD/do not want to cast it at all anymore
-- potion,if=(buff.serenity.up|buff.storm_earth_and_fire.up)&pet.xuen_the_white_tiger.active|fight_remains<=60
-- Use potion if Serenity is up, or both SEF and ToD are up, or the target will die within 60 seconds
-- call_action_list,name=serenity,if=buff.serenity.up
-- Call the Serenity action list if Serenity is currently up
-- call_action_list,name=opener,if=time<5&chi<5&!pet.xuen_the_white_tiger.active
            if Opener() ~= nil and Target:IsInRange(10) and HL.CombatTime()<5 and Player:Chi()<5 and S.InvokeXuentheWhiteTiger:CooldownRemainsP()<96 then
                return Opener()
            end
-- Use FotWT if you are missing at least 3 chi, And you either are about to cap energy, or serenity is about to come up, or FoF is coming up and you will cap energy soon
-- fist_of_the_white_tiger,target_if=min:debuff.mark_of_the_crane.remains,if=chi.max-chi>=3&(energy.time_to_max<1|energy.time_to_max<4&cooldown.fists_of_fury.remains<1.5)
if S.FistoftheWhiteTiger:IsReadyP() and Target:IsInRange(10) and (Player:ChiDeficit() >= 3 and (EnergyTimeToMaxPredicted()<1 or EnergyTimeToMaxPredicted()<4 and S.FistsofFury:CooldownRemainsP()<1.5)) then
return S.FistoftheWhiteTiger:Cast()
end
-- expel_harm,if=chi.max-chi>=1+essence.conflict_and_strife.major&(energy.time_to_max<1|cooldown.serenity.remains<2|energy.time_to_max<4&cooldown.fists_of_fury.remains<1.5)
 if S.ExpelHarm:IsReadyP() and Target:IsInRange(10) and Player:ChiDeficit() >= 1 and (EnergyTimeToMaxPredicted()<1 or S.Serenity:CooldownRemainsP()<2 or EnergyTimeToMaxPredicted()<4 and S.FistsofFury:CooldownRemainsP()<1.5) then
      return S.expelharm:Cast()
    end


-- tiger_palm,target_if=min:debuff.mark_of_the_crane.remains,if=combo_strike&chi.max-chi>=2&(energy.time_to_max<1|cooldown.serenity.remains<2|energy.time_to_max<4&cooldown.fists_of_fury.remains<1.5)
 if S.TigerPalm:IsReadyP() and Target:IsInRange(10) and (not Player:PrevGCD(1, S.TigerPalm) and Player:ChiDeficit() >= 2 and (EnergyTimeToMaxPredicted()<1 or S.Serenity:CooldownRemainsP()<2 or EnergyTimeToMaxPredicted()<4 and S.FistsofFury:CooldownRemainsP()<1.5))  then
      return S.TigerPalm:Cast()
    end

-- call_action_list,name=cd_sef,if=!talent.serenity.enabled
            if CDsSEF() ~= nil and not S.Serenity:IsAvailable() and RubimRH.CDsON() then
                return CDsSEF()
            end

-- call_action_list,name=cd_serenity,if=talent.serenity.enabled
            if CDsSerenity() ~= nil and S.Serenity:IsAvailable() and RubimRH.CDsON()  then
                return CDsSerenity()
            end

-- call_action_list,name=st,if=active_enemies<3
            if ST() ~= nil and (Cache.EnemiesCount[12]<3 or not RubimRH.AoEON()) and Target:IsInRange(10) then
                return ST()
            end
-- Call the ST action list if there are 2 or less enemies
-- call_action_list,name=aoe,if=active_enemies>=3
            if AoE() ~= nil and Cache.EnemiesCount[12]>=3 and RubimRH.AoEON()  then
                return AoE()
            end
-- Call the AoE action list if there are 3 or more enemies	
end





    if Actions() ~= nil then
        return Actions()
    end






end
    return 0, 135328
end




RubimRH.Rotation.SetAPL(269, APL);

local function PASSIVE()
    
end

RubimRH.Rotation.SetPASSIVE(269, PASSIVE);