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

-- trinkets


trink = Spell(59547), -- gift of naaru
trink2 = Spell(26297), --berserking

stopcasting = Spell(274738), --ancestral call
 -- Racials
  Bloodlust                             = Spell(2825),
  ArcaneTorrent                         = Spell(25046),
  Berserking                            = Spell(26297),
  BloodFury                             = Spell(33697),
  healingpot = Spell(176108),
  fortifyingbrew                        = Spell(58984),--shadowmeld
  QuakingPalm                           = Spell(107079),
  expelharm                             = Spell(265221),
  AncestralCall                         = Spell(274738),
WeaponsofOrder = Spell(310454),
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
  DanceofChijiBuffAzerite               = Spell(286585),
  -- Talents
  ChiWave                               = Spell(115098),
  ChiBurst                              = Spell(123986),
  FistoftheWhiteTiger                   = Spell(261947),
  HitCombo                              = Spell(196741),
  InvokeXuentheWhiteTiger               = Spell(123904),
  RushingJadeWind                       = Spell(261715),
  WhirlingDragonPunch                   = Spell(152175),
  WhirlingDragonPunchBuff               = Spell(196742),
  Serenity                              = Spell(152173),
  ConflictandStrife                     = Spell(169900),
  -- Artifact
  StrikeOfTheWindlord                   = Spell(205320),
  	lust1 = Spell(57724),
	lust2 = Spell(57723),
	lust3 = Spell(80354),
	lust4 = Spell(95809),
	lust5 = Spell(264689),
    lustAT = Spell(155145),
	CalculatedStrikes = Spell(336526),
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
  ChiEnergy                             = Spell(337571),
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

  -- Misc
  --PoolEnergy                            = Spell(9999000010)
	
}

local S = RubimRH.Spell[269] 

if not Item.Monk then Item.Monk = {}; end

Item.Monk.Windwalker = {
	trink2 = Item(184016, { 13, 14 }),--Skulker's Wing
	trink = Item(179350, { 13, 14 }), --???
	lust = Item(164978), --drums of fury
    healingpot = Item(171267), --astral healing pot
   
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


local EnemyRanges = { 10, 15, 50 }
local function UpdateRanges()
    for _, i in ipairs(EnemyRanges) do
        HL.GetEnemies(i);
    end
end

local serenityburst

local function APL()
	HL.GetEnemies("Melee");
	HL.GetEnemies(5);
	HL.GetEnemies(6);
    HL.GetEnemies(8);
	HL.GetEnemies(9);
    HL.GetEnemies(10);
	HL.GetEnemies(11);
	HL.GetEnemies(12);
	HL.GetEnemies(15);
	HL.GetEnemies(14);
	HL.GetEnemies(16);
	HL.GetEnemies(20);
	HL.GetEnemies(25);
	HL.GetEnemies(30);
	
 
 local IsTanking = Player:IsTankingAoE(8) or Player:IsTanking(Target)


 
 if Player:IsChanneling(S.FistsofFury) and S.FistsofFury:TimeSinceLastCast() >= 1 and Player:BuffP(S.StormEarthandFire) then
      return S.stopcasting:Cast()
    end


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


     -- if I.healthstone:IsReady() and Player:HealthPercentage() <= 50 then
        -- return S.healthstone:Cast()
    -- end


    if I.healingpot:IsReady() and Player:HealthPercentage() <= 35 and Player:AffectingCombat() then
        return S.healingpot:Cast()
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



	 

	if RubimRH.QueuedSpell():IsReadyQueue() then
        return RubimRH.QueuedSpell():Cast()
    end
	
	if not RubimRH.queuedSpell[1]:CooldownUp() or not Target:IsInRange(12) or not Player:AffectingCombat() then
		RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
	end
	
	



	if I.trink:IsReady() and Target:IsInRange(12) and I.trink:IsEquipped() and Player:BuffP(S.StormEarthandFire) then
         return S.trink:Cast()
     end
	 
	if I.trink2:IsReady() and Target:IsInRange(12) and I.trink2:IsEquipped() and Player:BuffP(S.StormEarthandFire) then
        return S.trink2:Cast()
    end 
	
	if Target:Debuff(S.Paralysis) then
	return 136035
	end
	
	
	
	
if Player:CanAttack(Target) then 
	


-- Opener
 
	



















	
	
	
	
	
	
	
-- --AoE
if RubimRH.AoEON() and Cache.EnemiesCount[12]>=3 then

if S.FistoftheWhiteTiger:IsReadyP() and Player:Chi() < 3 and EnergyTimeToMaxPredicted()<Player:GCD() and Target:IsInRange(10) then
return S.FistoftheWhiteTiger:Cast()
end

 if S.ExpelHarm:IsReadyP() and Player:ChiDeficit() >= 1 and EnergyTimeToMaxPredicted()<Player:GCD() and Target:IsInRange(10) then
      return S.expelharm:Cast()
    end


 if S.TigerPalm:IsReadyP() and Player:Chi()<4 and Target:IsInRange(10) and EnergyTimeToMaxPredicted()<Player:GCD() then
      return S.TigerPalm:Cast()
    end


if S.InvokeXuentheWhiteTiger:IsReadyP() and Target:IsInRange(10) and RubimRH.CDsON() then
      return S.InvokeXuentheWhiteTiger:Cast()
    end

 if S.WeaponsofOrder:IsReadyP() and RubimRH.CDsON() and Target:IsInRange(10) then
      return S.WeaponsofOrder:Cast()
    end
	
 if S.BloodFury:IsReadyP() and RubimRH.CDsON() and Player:BuffP(S.WeaponsofOrder) then
      return S.BloodFury:Cast()
    end
	

 if S.StormEarthandFire:IsReadyP() and (S.StormEarthandFire:ChargesFractional()==2 or S.FistsofFury:CooldownRemainsP()<10 and Player:Chi()>=2 and S.WhirlingDragonPunch:CooldownRemainsP()<12 or Player:BuffRemainsP(S.WeaponsofOrder)>8) and Target:IsInRange(10) and RubimRH.CDsON() then
      return S.StormEarthandFire:Cast()
    end

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


	
	
	
 if S.WhirlingDragonPunch:IsReadyP() and Player:BuffP(S.WhirlingDragonPunchBuff) and Cache.EnemiesCount[8]>=1 then
      return S.WhirlingDragonPunch:Cast()
    end
--CDS


 if S.SpinningCraneKick:IsReadyP() and not Player:PrevGCD(1, S.SpinningCraneKick) and Player:BuffP(S.DanceofChijiBuff) and Cache.EnemiesCount[12]>=1 then
      return S.SpinningCraneKick:Cast()
    end


 if S.FistsofFury:IsReadyP() and Cache.EnemiesCount[8]>=1 then
      return S.FistsofFury:Cast()
    end

 if S.RushingJadeWind:IsReadyP() and Cache.EnemiesCount[8]>=1 then
      return S.RushingJadeWind:Cast()
    end
	
 if S.TouchofDeath:IsReadyP() and Target:HealthPercentage() <= 15 and Target:IsInRange(10) then
      return S.TouchofDeath:Cast()
    end
	
 if S.ExpelHarm:IsReadyP() and Player:ChiDeficit() >= 1 and Target:IsInRange(10) then
      return S.expelharm:Cast()
    end
	
if S.FistoftheWhiteTiger:IsReadyP() and Player:Chi() < 3 then
return S.FistoftheWhiteTiger:Cast()
end

if S.ChiBurst:IsReadyP() and Cache.EnemiesCount[12]>=1 then
return S.ChiBurst:Cast()
end

  if S.RisingSunKick:IsReadyP() and not Player:Buff(S.WhirlingDragonPunchBuff) and S.FistsofFury:CooldownRemainsP()> 2 and Target:IsInRange(10) then
      return S.RisingSunKick:Cast()
    end
	
	

 if S.SpinningCraneKick:IsReadyP() and not Player:PrevGCD(1, S.SpinningCraneKick) 
 and ((Player:Chi()>3 or S.FistsofFury:CooldownRemainsP()>6)
 and (Player:Chi()>=5 or S.FistsofFury:CooldownRemainsP()>2)
 or EnergyTimeToMaxPredicted()<=3) and (Cache.EnemiesCount[12]>=2 and S.CalculatedStrikes:ConduitRank()>0 or Cache.EnemiesCount[12]>=3) then
      return S.SpinningCraneKick:Cast()
    end


	if S.ChiWave:IsReadyP() and Target:IsInRange(10) then
return S.ChiWave:Cast()
end

 if S.TigerPalm:IsReadyP() and Player:ChiDeficit()>=2 and Target:IsInRange(10) then
      return S.TigerPalm:Cast()
    end






end




	
	
	

if Cache.EnemiesCount[12]<3 or not RubimRH.AoEON() then	
	
--ST weapons of order buff		
if S.FistoftheWhiteTiger:IsReadyP() and Player:Chi() < 3 and EnergyTimeToMaxPredicted()<Player:GCD() and Target:IsInRange(10) then
return S.FistoftheWhiteTiger:Cast()
end

 if S.ExpelHarm:IsReadyP() and Player:ChiDeficit() >= 1 and EnergyTimeToMaxPredicted()<Player:GCD() and Target:IsInRange(10) then
      return S.expelharm:Cast()
    end


 if S.TigerPalm:IsReadyP() and Player:Chi()<4 and Target:IsInRange(10) and EnergyTimeToMaxPredicted()<Player:GCD() then
      return S.TigerPalm:Cast()
    end


if S.InvokeXuentheWhiteTiger:IsReadyP() and Target:IsInRange(10) and RubimRH.CDsON() then
      return S.InvokeXuentheWhiteTiger:Cast()
    end

 if S.WeaponsofOrder:IsReadyP() and RubimRH.CDsON() and Target:IsInRange(10) then
      return S.WeaponsofOrder:Cast()
    end
	
 if S.BloodFury:IsReadyP() and RubimRH.CDsON() and Player:BuffP(S.WeaponsofOrder) then
      return S.BloodFury:Cast()
    end
	

 if S.StormEarthandFire:IsReadyP() and (S.StormEarthandFire:ChargesFractional()==2 or S.FistsofFury:CooldownRemainsP()<10 and Player:Chi()>=2 and S.WhirlingDragonPunch:CooldownRemainsP()<12 or Player:BuffRemainsP(S.WeaponsofOrder)>8) and Target:IsInRange(10) and RubimRH.CDsON() then
      return S.StormEarthandFire:Cast()
    end
	
		
-- whirling_dragon_punch,if=raid_event.adds.in>cooldown.whirling_dragon_punch.duration*0.8|raid_event.adds.up
 if S.WhirlingDragonPunch:IsReadyP() and Player:BuffP(S.WhirlingDragonPunchBuff) and Cache.EnemiesCount[8]>=1 then
      return S.WhirlingDragonPunch:Cast()
    end

-- energizing_elixir,if=chi.max-chi>=2&energy.time_to_max>3|chi.max-chi>=4&(energy.time_to_max>2|!prev_gcd.1.tiger_palm)
 if S.EnergizingElixir:IsReadyP() and (Player:ChiDeficit() >= 2 and EnergyTimeToMaxPredicted()> 3 or Player:ChiDeficit() >= 4 and (EnergyTimeToMaxPredicted()>2 or not Player:PrevGCD(1, S.TigerPalm))) then
      return S.EnergizingElixir:Cast()
    end

-- spinning_crane_kick,if=(!talent.hit_combo.enabled&conduit.calculated_strikes.enabled|combo_strike)
-- &buff.dance_of_chiji.up&(raid_event.adds.in>buff.dance_of_chiji.remains-2|raid_event.adds.up)
 if S.SpinningCraneKick:IsReadyP() and (not S.HitCombo:IsAvailable() and S.CalculatedStrikes:ConduitRank() > 0 or not Player:PrevGCD(1, S.SpinningCraneKick)) and Player:BuffP(S.DanceofChijiBuff) then
      return S.SpinningCraneKick:Cast()
    end

-- rising_sun_kick,target_if=min:debuff.mark_of_the_crane.remains,if=cooldown.serenity.remains>1|!talent.serenity.enabled
 if S.RisingSunKick:IsReadyP() and Target:IsInRange(10) then
      return S.RisingSunKick:Cast()
    end

-- fists_of_fury,if=(raid_event.adds.in>cooldown.fists_of_fury.duration*0.8|raid_event.adds.up)
-- &(energy.time_to_max>execute_time-1|chi.max-chi<=1|buff.storm_earth_and_fire.remains<execute_time+1)|fight_remains<execute_time+1
 if S.FistsofFury:IsReadyP() and (S.WeaponsofOrder:CooldownRemainsP()>4 or Player:BuffP(S.WeaponsofOrder) or not RubimRH.CDsON()) and Cache.EnemiesCount[8]>=1 and (EnergyTimeToMaxPredicted()> 2 or Player:ChiDeficit() <=1 or Player:BuffRemainsP(S.StormEarthandFire)<4) then
      return S.FistsofFury:Cast()
    end

-- crackling_jade_lightning,if=buff.the_emperors_capacitor.stack>19&energy.time_to_max>execute_time-1&cooldown.rising_sun_kick.remains>execute_time|buff.the_emperors_capacitor.stack>14&(cooldown.serenity.remains<5&talent.serenity.enabled|cooldown.weapons_of_order.remains<5&covenant.kyrian|fight_remains<5)



-- rushing_jade_wind,if=buff.rushing_jade_wind.down&active_enemies>1
 if S.RushingJadeWind:IsReadyP() and not Player:BuffP(S.RushingJadeWind) and Cache.EnemiesCount[12]>1 then
      return S.RushingJadeWind:Cast()
    end


-- fist_of_the_white_tiger,target_if=min:debuff.mark_of_the_crane.remains,if=chi<3
if S.FistoftheWhiteTiger:IsReadyP() and Player:Chi() < 3 then
return S.FistoftheWhiteTiger:Cast()
end

-- expel_harm,if=chi.max-chi>=1
 if S.ExpelHarm:IsReadyP() and Player:ChiDeficit() >= 1 then
      return S.expelharm:Cast()
    end

-- chi_burst,if=chi.max-chi>=1&active_enemies=1&raid_event.adds.in>20|chi.max-chi>=2&active_enemies>=2
if S.ChiBurst:IsReadyP() and (Player:ChiDeficit() >= 1 or Player:ChiDeficit() >= 2 and Cache.EnemiesCount[12]>=2) then
return S.ChiBurst:Cast()
end

-- chi_wave
if S.ChiWave:IsReadyP() then
return S.ChiWave:Cast()
end


-- tiger_palm,target_if=min:debuff.mark_of_the_crane.remains+(debuff.recently_rushing_tiger_palm.up*20),if=combo_strike&chi.max-chi>=2&buff.storm_earth_and_fire.down
 if S.TigerPalm:IsReadyP() and not Player:PrevGCD(1, S.TigerPalm) and Player:ChiDeficit()>=2 and not Player:BuffP(S.StormEarthandFire) then
      return S.TigerPalm:Cast()
    end

-- spinning_crane_kick,if=buff.chi_energy.stack>30-5*active_enemies&buff.storm_earth_and_fire.down
-- &(cooldown.rising_sun_kick.remains>2&cooldown.fists_of_fury.remains>2|cooldown.rising_sun_kick.remains<3
-- &cooldown.fists_of_fury.remains>3&chi>3|cooldown.rising_sun_kick.remains>3&cooldown.fists_of_fury.remains<3&chi>4
-- |chi.max-chi<=1&energy.time_to_max<2)|buff.chi_energy.stack>10&fight_remains<7
 if S.SpinningCraneKick:IsReadyP() and (Player:BuffStackP(S.ChiEnergy) >30-num(active_enemies()*5) and not Player:BuffP(S.StormEarthandFire) 
 and (S.RisingSunKick:CooldownRemainsP()>2 and S.FistsofFury:CooldownRemainsP()>2 or S.RisingSunKick:CooldownRemainsP()<3
 and S.FistsofFury:CooldownRemainsP()>3 and Player:Chi()>3 or S.RisingSunKick:CooldownRemainsP()>3
 and S.FistsofFury:CooldownRemainsP()<3 and Player:Chi()>4 or Player:ChiDeficit()<=1 and EnergyTimeToMaxPredicted()<2)
 or Player:BuffStackP(S.ChiEnergy)>10 and Target:TimeToDie()<7)
 then
      return S.SpinningCraneKick:Cast()
    end

-- blackout_kick,target_if=min:debuff.mark_of_the_crane.remains,if=combo_strike
-- &(talent.serenity.enabled&cooldown.serenity.remains<3|cooldown.rising_sun_kick.remains>1
-- &cooldown.fists_of_fury.remains>1|cooldown.rising_sun_kick.remains<3&cooldown.fists_of_fury.remains>3
-- &chi>2|cooldown.rising_sun_kick.remains>3&cooldown.fists_of_fury.remains<3&chi>3|chi>5|buff.bok_proc.up)
 if S.BlackoutKick:IsReadyP() 
 and (not Player:PrevGCD(1, S.BlackoutKick) 
 and (S.Serenity:IsAvailable() and S.Serenity:CooldownRemainsP()<3 and RubimRH.CDsON()
 or S.RisingSunKick:CooldownRemainsP()>1 and S.FistsofFury:CooldownRemainsP()>1
 or S.RisingSunKick:CooldownRemainsP()<4 and S.FistsofFury:CooldownRemainsP()>2 and Player:Chi()>2
 or S.RisingSunKick:CooldownRemainsP()>2 and S.FistsofFury:CooldownRemainsP()<4 and Player:Chi()>3
or Player:BuffP(S.BlackoutKickBuff) or Player:Chi()>5)) then
      return S.BlackoutKick:Cast()
    end
	


	
	
	
	
	


end





end

    return 0, 135328
end




RubimRH.Rotation.SetAPL(269, APL);

local function PASSIVE()
    
end

RubimRH.Rotation.SetPASSIVE(269, PASSIVE);