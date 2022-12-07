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

if not Spell.Evoker then
    Spell.Evoker = {};
end


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------SPELLS/ITEMS-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



RubimRH.Spell[1467] = {
  -- Racials
  TailSwipe                             = Spell(368970),
  WingBuffet                            = Spell(357214),
  -- Abilities
  AzureStrike                           = Spell(362969),
  BlessingoftheBronze                   = Spell(364342),
  DeepBreath                            = Spell(357210),
  Disintegrate                          = Spell(356995),
  FireBreath                            = Spell(357208), -- with and without Font of Magic
  LivingFlame                           = Spell(361469),
  -- Talents
  BlastFurnace                          = Spell(375510),
  ObsidianScales                        = Spell(363916),
  TipTheScales                          = Spell(370553),
  -- Buffs/Debuffs
  BlessingoftheBronzeBuff               = Spell(381748),
  FireBreathDebuff                      = Spell(357209),
  LeapingFlamesBuff                     = Spell(370901),
  -- External Buffs
  PowerInfusionBuff                     = Spell(10060),
  -- Utility
  Quell                                 = Spell(351338),
  -- Covenant
  BoonoftheCovenants                    = Spell(387168),
  -- Other
  Pool                                  = Spell(999910),

  Animosity                             = Spell(375797),
  ArcaneVigor                           = Spell(386342),
  Burnout                               = Spell(375801),
  Causality                             = Spell(375777),
  ChargedBlast                          = Spell(370455),
  Dragonrage                            = Spell(375087),
  EngulfingBlaze                        = Spell(370837),
  EssenceAttunement                     = Spell(375722),
  EternitySurge                         = Spell(359073), -- with and without Font of Magic
  EternitysSpan                         = Spell(375757),
  EverburningFlame                      = Spell(370819),
  FeedtheFlames                         = Spell(369846),
  Firestorm                             = Spell(368847),
  FontofMagic                           = Spell(375783),
  Pyre                                  = Spell(357211),
  RubyEmbers                            = Spell(365937),
  Scintillation                         = Spell(370821),
  ShatteringStar                        = Spell(370452),
  Snapfire                              = Spell(370783),
  Tyranny                               = Spell(376888),
  Volatility                            = Spell(369089),
  -- Buffs
  BurnoutBuff                           = Spell(375802),
  ChargedBlastBuff                      = Spell(370454),
  EssenceBurstBuff                      = Spell(359618),
  SnapfireBuff                          = Spell(370818),
  -- Debuffs
  LivingFlameDebuff                     = Spell(361500),




}






local S = RubimRH.Spell[1467] 


if not Item.Evoker then Item.Evoker = {}; end
Item.Evoker.Balance = {
    -- Legendaries
	trink2 = Item(159617, { 13, 14 }),

	trink = Item(169311, { 13, 14 }),

	lust = Item(164978),
       healingpot = Item(169451), --astral healing pot
    healthstone = Item(5512), --health stone
	
};
local I = Item.Evoker.Balance;




-- Rotation Var
local ShouldReturn; -- Used to get the return string

-- Variables

local EnemyRanges = { 40 }
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
    return val
end


local function GetEnemiesCount(range)
  -- Unit Update - Update differently depending on if splash data is being used
  if RubimRH.AoEON() then
    if RubimRH.db.profile[1467].useSplashData == "Enabled" then
      HL.GetEnemies(range, nil, true, Target)
      return Cache.EnemiesCount[range]
    else
      UpdateRanges()
      return active_enemies()
    end
  else
    return 1
  end
end

local function FutureAstralPower()
    local AstralPower = Player:AstralPower()
    if not Player:IsCasting() then
        return AstralPower
    else
        if Player:IsCasting(S.NewnMoon) then
            return AstralPower + 10
        elseif Player:IsCasting(S.HalfMoon) then
            return AstralPower + 20
        elseif Player:IsCasting(S.FullMoon) then
            return AstralPower + 40
        elseif Player:IsCasting(S.StellarFlare) then
            return AstralPower + 8
        elseif Player:IsCasting(S.Wrath) then
            return AstralPower + 8
        elseif Player:IsCasting(S.Starfire) then
            return AstralPower + 12
        else
            return AstralPower
        end
    end
end



local function CaInc()
  return S.Incarnation:IsAvailable() and S.Incarnation or S.CelestialAlignment
end

local function AP_Check(spell)
  local APGen = 0
  local CurAP = Player:AstralPower()
  if spell == S.Sunfire or spell == S.Moonfire then 
    APGen = 3
  elseif spell == S.StellarFlare or spell == S.Wrath then
    APGen = 8
  elseif spell == S.Incarnation or spell == S.CelestialAlignment then
    APGen = 40
  elseif spell == S.ForceofNature then
    APGen = 20
  elseif spell == S.Starfire then
    APGen = 12
  end
  
  if S.ShootingStars:IsAvailable() then 
    APGen = APGen + 4
  end
  if S.NaturesBalance:IsAvailable() then
    APGen = APGen + 2
  end
  
  if CurAP + APGen < Player:AstralPowerMax() then
    return true
  else
    return false
  end
end

-- Variables
local VarAzSs = 0;
local VarAzAp = 0;
local VarSfTargets = 0;

HL:RegisterForEvent(function()
  VarAzSs = 0
  VarAzAp = 0
  VarSfTargets = 0
end, "PLAYER_REGEN_ENABLED")

-- Enrage debuff function
local function HasDispellableEnrage()
    if Target:HasBuffList(RubimRH.List.PvEEnragePurge) then
        return true
	else 
	    return false
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





local function EvaluateCycleSunfire(TargetUnit)
  return (TargetUnit:DebuffRefreshableCP(S.SunfireDebuff)) and (AP_Check(S.Sunfire) and math.floor (TargetUnit:TimeToDie() / (2 * Player:SpellHaste())) * EnemiesCount >= math.ceil (math.floor (2 / EnemiesCount) * 1.5) + 2 * EnemiesCount and (EnemiesCount > 1 + num(S.TwinMoons:IsAvailable()) or TargetUnit:DebuffP(S.MoonfireDebuff)) and (not bool(VarAzSs) or not Player:BuffP(CaInc()) or not Player:PrevGCDP(1, S.Sunfire)) and (Player:BuffRemainsP(CaInc()) > TargetUnit:DebuffRemainsP(S.SunfireDebuff) or not Player:BuffP(CaInc())))
end

local function EvaluateCycleMoonfire(TargetUnit)
  return (TargetUnit:DebuffRefreshableCP(S.MoonfireDebuff)) and (AP_Check(S.Moonfire) and math.floor (TargetUnit:TimeToDie() / (2 * Player:SpellHaste())) * EnemiesCount >= 6 and (not bool(VarAzSs) or not Player:BuffP(CaInc()) or not Player:PrevGCDP(1, S.Moonfire)) and (Player:BuffRemainsP(CaInc()) > TargetUnit:DebuffRemainsP(S.MoonfireDebuff) or not Player:BuffP(CaInc())))
end

local function EvaluateCycleStellarFlare(TargetUnit)
  return (TargetUnit:DebuffRefreshableCP(S.StellarFlareDebuff)) and (AP_Check(S.StellarFlare) and math.floor (TargetUnit:TimeToDie() / (2 * Player:SpellHaste())) >= 5 and (not bool(VarAzSs) or not Player:BuffP(CaInc()) or not Player:PrevGCDP(1, S.StellarFlare)) and not Player:IsCasting(S.StellarFlare))
end

local dotrequirements

local function APL()

	HL.GetEnemies("Melee");
	HL.GetEnemies(5, true);
    HL.GetEnemies(8, true);
    HL.GetEnemies(10, true);
	HL.GetEnemies(15, true);
	HL.GetEnemies(20, true);
	HL.GetEnemies(25, true);
	HL.GetEnemies(30, true);
	HL.GetEnemies(35, true);
	HL.GetEnemies(40, true);

    LeftCtrl = IsLeftControlKeyDown();
    LeftShift = IsLeftShiftKeyDown();
    LeftAlt = IsLeftAltKeyDown();


    if I.healingpot:IsReady() and Player:HealthPercentage() <= 35 and Player:AffectingCombat() then
        return S.healingpot:Cast()
    end

	-- if (Player:IsCasting(S.Wrath) or Player:IsCasting(S.Starfire)) and Player:AstralPower()>90 then
		-- return S.stopcasting:Cast()
    -- end	
	
	-- if Player:IsCasting(S.Starfire) and not Player:BuffP(S.EclipseLunar) and Player:BuffP(S.EclipseSolar) then
        -- return S.stopcasting:Cast()
    -- end
	-- if Player:IsCasting(S.Wrath) and not Player:BuffP(S.EclipseSolar) and Player:BuffP(S.EclipseLunar) then
		-- return S.stopcasting:Cast()
    -- end	
	
		-- if Player:IsCasting(S.StellarFlare) and Target:DebuffRemains(S.StellarFlare)>5.5 then
		-- return S.stopcasting:Cast()
    -- end	

	if   IsLeftAltKeyDown() then
		return S.stopcasting:Cast()
    end	

 if Player:IsChanneling() or Player:IsCasting() then
        return 0, 136213
    end

    if GetShapeshiftForm() ~= 4 and not Player:BuffP(S.CatForm) and not Player:BuffP(S.TravelForm) and not Player:BuffP(S.BearForm) then
        return S.MoonkinForm:Cast()
    end
	
	
	
	
		if S.lustAT:ID() ==  RubimRH.queuedSpell[1]:ID() and not Player:Debuff(S.lust1) and not Player:Debuff(S.lust2) and not Player:Debuff(S.lust3) and not Player:Debuff(S.lust4) and not Player:Debuff(S.lust5) then
    	return S.lustAT:Cast() -- BIND LUST KEYBIND IN BINDPAD TO ARCANE TORRENT
	end
	
	if S.lustAT:ID() ==  RubimRH.queuedSpell[1]:ID() and (Player:Debuff(S.lust1) or Player:Debuff(S.lust2) or Player:Debuff(S.lust3) or Player:Debuff(S.lust4) or Player:Debuff(S.lust5)) then
		RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
	end
	
	
	if not RubimRH.queuedSpell[1]:CooldownUp() or not Player:AffectingCombat() then
		RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
	end
	
		if S.Cyclone:ID() ==  RubimRH.queuedSpell[1]:ID() and Target:IsInRange(45) then
		return S.cyclone:Cast()
	end
	
			if S.Cyclone:ID() ==  RubimRH.queuedSpell[1]:ID() and not Target:IsInRange(45) then
		RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
	end
	
			if S.Typhoon:ID() ==  RubimRH.queuedSpell[1]:ID() and Target:IsInRange(45) then
		return S.typhoon:Cast()
	end
	
			if S.Typhoon:ID() ==  RubimRH.queuedSpell[1]:ID() and not Target:IsInRange(45) then
		RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
	end
	
		-- if S.Typhoon:ID() ==  RubimRH.queuedSpell[1]:ID() then
		-- return S.typhoon:Cast()
	-- end	
		if S.Vortex:ID() ==  RubimRH.queuedSpell[1]:ID() then
		return S.vortex:Cast()
	end

	if RubimRH.QueuedSpell():IsReadyQueue() then
        return RubimRH.QueuedSpell():Cast()
    end
	
	
	
	
	
	   if S.Barkskin:IsCastableP() and Player:HealthPercentage() < 35 then
        return S.Barkskin:Cast()
    end	
	
	


	
if Player:CanAttack(Target) and Target:AffectingCombat() or (Player:AffectingCombat() or Target:IsDummy()) then 





if S.GaurdianAffinity:IsAvailable() and Player:BuffP(S.BearForm) then


if S.FrenziedRegeneration:IsReady()  and Player:HealthPercentage()<80 then
return S.FrenziedRegeneration:Cast()
end

if S.IncapacitatingRoar:IsReady()  and Cache.EnemiesCount[10]>=1 and Player:HealthPercentage()<20 then
return S.incapacitatingroar:Cast()
end

  if S.Ironfur:IsReadyP() and Cache.EnemiesCount[10]>=1 then
        return S.Ironfur:Cast()
    end
	
if (not Target:Debuff(S.ThrashDebuff) or Target:DebuffRemainsP(S.ThrashDebuff)<13 and Target:Debuff(S.ThrashDebuff)) and Cache.EnemiesCount[12]>=1  then
		return S.Thrash:Cast()
	end
	
  if S.Mangle:IsReadyP() and Target:IsInRange(10) then
        return S.Mangle:Cast()
    end
 
end




  if S.Berserking:IsCastableP() and Target:IsInRange(40) and Player:BuffP(S.CelestialAlignmentBuff) then
        return S.Berserking:Cast()
    end



	
	
	
if Player:BuffP(S.MoonkinForm) then	

	--AOE------------------------------------


if HL.CombatTime()<3 and Player:AstralPower()<90 and (not Player:BuffP(S.EclipseLunar) and not Player:BuffP(S.EclipseSolar)) then


-- Apply and maintain  Moonfire, Sunfire Icon Sunfire on all targets if they will live longer than 8-seconds.
	    if S.Sunfire:IsCastableP(40) and Target:DebuffRemainsP(S.SunfireDebuff) < 5.4 and Target:TimeToDie()> 12  and active_enemies()>=2 then
        return S.Sunfire:Cast()
    end
	


	if S.Starfire:IsCastableP(40) and Player:BuffP(S.EclipseLunar) and (not Player:IsMoving() or Player:BuffP(S.StarfallBuff) and S.StellarDrift:IsAvailable() or Player:BuffP(S.WarriorofEluneBuff)) then
        return S.Starfire:Cast()
    end
	
    if S.Wrath:IsCastableP(40) and Player:BuffP(S.EclipseSolar) and (not Player:IsMoving() or Player:BuffP(S.StarfallBuff) and S.StellarDrift:IsAvailable()) then
        return S.Wrath:Cast()
    end

    if S.Wrath:IsCastableP(40) and S.Wrath:Count()>=1  and (not Player:IsMoving() or Player:BuffP(S.StarfallBuff) and S.StellarDrift:IsAvailable()) then
        return S.Wrath:Cast()
    end

   if S.Starfire:IsCastableP(40) and S.Starfire:Count()>=1  and (not Player:IsMoving() or Player:BuffP(S.StarfallBuff) and S.StellarDrift:IsAvailable() or Player:BuffP(S.WarriorofEluneBuff)) then
        return S.Starfire:Cast()
    end
	
end


if active_enemies() >=2 then
	
if S.CelestialAlignment:IsReadyP() and RubimRH.CDsON() and Player:AstralPower()>=45 and Target:IsInRange(40) and (not Player:BuffP(S.EclipseLunar) or not Player:BuffP(S.EclipseSolar)) then
return S.CelestialAlignment:Cast()
end
	
	
-- Maintain Starfall to consume Astral Power.
    if S.Starfall:IsReadyP() and Cache.EnemiesCount[45]>=2 and Player:BuffRemainsP(S.StarfallBuff)<Player:GCD()*1.5 then
        return S.Starfall:Cast()
    end
	

	
	if S.Starfire:IsCastableP(40) and Player:BuffP(S.WarriorofEluneBuff) then
        return S.Starfire:Cast()
    end
	

-- Apply and maintain  Moonfire, Sunfire Icon Sunfire on all targets if they will live longer than 8-seconds.
	    if S.Sunfire:IsCastableP(40) and Target:DebuffRemainsP(S.SunfireDebuff) < 5.4 and Target:TimeToDie()> 14  then
        return S.Sunfire:Cast()
    end
	

    if S.Moonfire:IsCastableP(40) and Target:DebuffRemainsP(S.MoonfireDebuff) < 6.6 and Target:TimeToDie()> 14 and Player:BuffP(S.EclipseSolar) then
        return S.Moonfire:Cast()
    end
	
    if S.StellarFlare:IsCastableP(40) and Target:DebuffRemainsP(S.StellarFlareDebuff)<5.5 and Target:TimeToDie()> 14 then
        return S.StellarFlare:Cast()
    end


	-- if RubimRH.AoEON() and Target:DebuffRemainsP(S.MoonfireDebuff) >= S.Moonfire:BaseDuration() * 0.90  and Target:DebuffRemainsP(S.SunfireDebuff)>= S.Sunfire:BaseDuration() * 0.90 and not Player:IsChanneling() and active_enemies() >= 2 and active_enemies() < 100 and CombatTime("player") > 0 and Player:BuffP(S.EclipseSolar) and 
-- (
    -- not IsSpellInRange(8921, "target") or   
    -- (
        -- CombatTime("target") == 0 and
        -- not Player:InPvP()
    -- ) 
-- ) and
-- (
    -- MultiDots(30, S.SunfireDebuff, 14, 1) >= 1 or MultiDots(30, S.MoonfireDebuff, 14, 1) >= 1 or
    -- (
        -- CombatTime("target") == 0 and
        -- not Player:InPvP()
    -- ) 
-- ) then 
    -- return 133015 
   -- end


-- Keep Fury of Elune (if talented) on cooldown.


    if S.WarriorofElune:IsReadyP() and RubimRH.CDsON() and Target:IsInRange(40) then
        return S.WarriorofElune:Cast()
    end


    if S.FuryofElune:IsCastableP() and RubimRH.CDsON() and Target:IsInRange(40) then
        return S.FuryofElune:Cast()
    end


    if S.Wrath:IsCastableP(40) and S.Wrath:Count()>=1 and (not Player:IsMoving() or Player:BuffP(S.StarfallBuff) and S.StellarDrift:IsAvailable()) then
        return S.Wrath:Cast()
    end

   if S.Starfire:IsCastableP(40) and S.Starfire:Count()>=1 and (not Player:IsMoving() or Player:BuffP(S.StarfallBuff) and S.StellarDrift:IsAvailable() or Player:BuffP(S.WarriorofEluneBuff)) then
        return S.Starfire:Cast()
    end

-- Cast Starsurge when available. Try to keep enough Astral Power for Starfall when its low duration.
  -- if S.Starsurge:IsReadyP(40) and ((Player:BuffP(S.EclipseLunar) or Player:BuffP(S.EclipseSolar)) and (Player:BuffP(S.Starfall) and Player:AstralPower()>=75 or Player:AstralPower()>=90))  then
        -- return S.Starsurge:Cast()
    -- end
	

	-- if S.Starfire:IsCastableP(40) and Player:BuffP(S.EclipseSolar) and active_enemies()>4 and (not Player:IsMoving() or Player:BuffP(S.StarfallBuff) and S.StellarDrift:IsAvailable() or Player:BuffP(S.WarriorofEluneBuff)) then
        -- return S.Starfire:Cast()
    -- end 
	
-- Cast the Eclipse appropriate filler to try to fill up your Astral Power for the next Eclipse.	
	if S.Starfire:IsCastableP(40) and Player:BuffP(S.EclipseLunar) and (not Player:IsMoving() or Player:BuffP(S.StarfallBuff) and S.StellarDrift:IsAvailable() or Player:BuffP(S.WarriorofEluneBuff)) then
        return S.Starfire:Cast()
    end
	
    if S.Wrath:IsCastableP(40) and Player:BuffP(S.EclipseSolar) and (not Player:IsMoving() or Player:BuffP(S.StarfallBuff) and S.StellarDrift:IsAvailable()) then
        return S.Wrath:Cast()
    end


end	
	
	





        if (true) then
		    variableaoe = RubimRH.AoEON() and (active_enemies()>1 and (not S.Starlord:IsAvailable() or S.StellarDrift:IsAvailable()) or active_enemies()>2)
			end

-- variable,name=dot_requirements,value=
-- (buff.ca_inc.remains>5
-- &(buff.ravenous_frenzy.remains>5|!buff.ravenous_frenzy.up)|!buff.ca_inc.up|astral_power<30)
-- &(!buff.kindred_empowerment_energize.up|astral_power<30)
-- &(buff.eclipse_solar.remains>gcd.max|buff.eclipse_lunar.remains>gcd.max)

        if (true) then
		    dotrequirements = ((Player:BuffRemainsP(S.CelestialAlignmentBuff)>5
			and (Player:BuffRemainsP(S.RavenousFrenzy)>5 or not Player:BuffP(S.RavenousFrenzy)) or not Player:BuffP(S.CelestialAlignmentBuff) or Player:AstralPower()<30)
			and (not Player:BuffP(S.KindredEmpowermentEnergize) or Player:AstralPower()<30)
			and (Player:BuffRemainsP(S.EclipseSolar)>Player:GCD() or Player:BuffRemainsP(S.EclipseLunar)>Player:GCD()))
			end

-- moonfire,target_if=refreshable&target.time_to_die>12,if=ap_check&variable.dot_requirements

    if S.Moonfire:IsCastableP(40) and Target:DebuffRemainsP(S.MoonfireDebuff) < 6.6 and Target:TimeToDie()> 12 and dotrequirements then
        return S.Moonfire:Cast()
    end
	


-- sunfire,target_if=refreshable&target.time_to_die>12,if=ap_check&variable.dot_requirements

	    if S.Sunfire:IsCastableP(40) and Target:DebuffRemainsP(S.SunfireDebuff) < 5.4 and Target:TimeToDie()> 12 and dotrequirements then
        return S.Sunfire:Cast()
    end


-- stellar_flare,target_if=refreshable&target.time_to_die>16,if=ap_check&variable.dot_requirements
    if S.StellarFlare:IsCastableP(40) and Target:DebuffRemainsP(S.StellarFlareDebuff)<5.5 and Target:TimeToDie()> 12 and dotrequirements then
        return S.StellarFlare:Cast()
    end



-- force_of_nature,if=ap_check
    if S.ForceofNature:IsCastableP(40) then
        return S.ForceofNature:Cast()
    end



-- kindred_spirits,if=((buff.eclipse_solar.remains>10|buff.eclipse_lunar.remains>10)
-- &cooldown.ca_inc.remains>30
-- &(buff.primordial_arcanic_pulsar.value<240|!runeforge.primordial_arcanic_pulsar.equipped))|buff.primordial_arcanic_pulsar.value>=270|cooldown.ca_inc.ready
-- &(astral_power>90|variable.is_aoe)

    -- if S.KindredSpirits:IsCastableP(40) and
	-- (((Player:BuffRemainsP(S.EclipseSolar)>10 or Player:BuffRemainsP(S.EclipseLunar)>10)
	-- and S.CelestialAlignment:CooldownRemainsP()>30 and RubimRH.CDsON()
	-- and ( Player:CanAttack(Target))) or S.CelestialAlignment:CooldownRemainsP()==0
	-- and (Player:AstralPower()>90 or variableaoe))
	
	-- then
        -- return S.KindredSpirits:Cast()
    -- end


-- celestial_alignment,if=(astral_power>90
-- &(buff.kindred_empowerment_energize.up|!covenant.kyrian)|covenant.night_fae|variable.is_aoe|

if S.CelestialAlignment:IsReadyP() and (RubimRH.CDsON() and Player:AstralPower()>=90 and Target:IsInRange(40) or variableaoe and RubimRH.CDsON()) then
return S.CelestialAlignment:Cast()
end	


-- incarnation,if=(astral_power>90&(buff.kindred_empowerment_energize.up|!covenant.kyrian)|covenant.night_fae|variable.is_aoe|buff.bloodlust.up&buff.bloodlust.remains<30+((9*runeforge.primordial_arcanic_pulsar.equipped)+(conduit.precise_alignment.time_value)))&!buff.ca_inc.up&(!covenant.night_fae|cooldown.convoke_the_spirits.up|interpolated_fight_remains<cooldown.convoke_the_spirits.remains+6|interpolated_fight_remains%%180<30+(conduit.precise_alignment.time_value))
if S.Incarnation:IsReadyP() and (RubimRH.CDsON() and Player:AstralPower()>=90 and Target:IsInRange(40) or variableaoe and RubimRH.CDsON()) then
return S.Incarnation:Cast()
end	


-- fury_of_elune,if=eclipse.in_any&ap_check&buff.primordial_arcanic_pulsar.value<240&(dot.adaptive_swarm_damage.ticking|!covenant.necrolord)&variable.save_for_ca_inc
if S.FuryofElune:IsReadyP() and (Player:BuffP(S.EclipseLunar) or Player:BuffP(S.EclipseSolar)) then
return S.FuryofElune:Cast()
end	



-- starsurge,if=buff.oneths_clear_vision.up|buff.kindred_empowerment_energize.up|buff.ca_inc.up&(buff.ravenous_frenzy.remains<gcd.max*ceil(astral_power%30)&buff.ravenous_frenzy.up|!buff.ravenous_frenzy.up&!cooldown.ravenous_frenzy.ready|!covenant.venthyr)|astral_power>90&eclipse.in_any
  if S.Starsurge:IsReadyP(40) and Player:AstralPower()>90 and (Player:BuffP(S.EclipseLunar) or Player:BuffP(S.EclipseSolar))  then
        return S.Starsurge:Cast()
    end


-- starsurge,if=talent.starlord.enabled
-- &(buff.starlord.up|astral_power>90)&buff.starlord.stack<3
-- &(buff.eclipse_solar.up|buff.eclipse_lunar.up)&buff.primordial_arcanic_pulsar.value<270
-- &(cooldown.ca_inc.remains>10|!variable.convoke_desync&covenant.night_fae)
  if S.Starsurge:IsReadyP(40) and (S.Starlord:IsAvailable() and  Player:AstralPower()>90 and Player:BuffStackP(S.StarlordBuff)<3) then
        return S.Starsurge:Cast()
    end
  if S.Starsurge:IsReadyP(40) and (S.Starlord:IsAvailable() and Player:BuffP(S.StarlordBuff) and Player:BuffStackP(S.StarlordBuff)<3) then
        return S.Starsurge:Cast()
    end




-- new_moon,if=(buff.eclipse_lunar.up|(charges=2&recharge_time<5)|charges=3)&ap_check&variable.save_for_ca_inc



-- half_moon,if=(buff.eclipse_lunar.up&!covenant.kyrian|(buff.kindred_empowerment_energize.up&covenant.kyrian)|(charges=2&recharge_time<5)|charges=3|buff.ca_inc.up)&ap_check&variable.save_for_ca_inc



-- full_moon,if=(buff.eclipse_lunar.up&!covenant.kyrian|(buff.kindred_empowerment_energize.up&covenant.kyrian)|(charges=2&recharge_time<5)|charges=3|buff.ca_inc.up)&ap_check&variable.save_for_ca_inc



-- warrior_of_elune



-- starfire,if=eclipse.in_lunar|eclipse.solar_next|eclipse.any_next|buff.warrior_of_elune.up&buff.eclipse_lunar.up|(buff.ca_inc.remains<action.wrath.execute_time&buff.ca_inc.up)



-- wrath






	--ST------------------------------------
	


		
-- Get to 90 Astral Power and then press Celestial Alignment Icon Celestial Alignment / Incarnation: Chosen of Elune Icon Incarnation: Chosen of Elune (if talented).

	


-- Apply and maintain Moonfire Icon Moonfire, Sunfire Icon Sunfire, and Stellar Flare Icon Stellar Flare (if talented) on the target(s).

	

-- Cast two unempowered fillers (Wrath Icon Wrath or Starfire Icon Starfire) to enter the appropriate Eclipse Icon Eclipse state.
    if S.Wrath:IsCastableP(40) and S.Wrath:Count()>=1  and (not Player:IsMoving() or Player:BuffP(S.StarfallBuff) and S.StellarDrift:IsAvailable()) then
        return S.Wrath:Cast()
    end

   if S.Starfire:IsCastableP(40) and S.Starfire:Count()>=1  and (not Player:IsMoving() or Player:BuffP(S.StarfallBuff) and S.StellarDrift:IsAvailable() or Player:BuffP(S.WarriorofEluneBuff)) then
        return S.Starfire:Cast()
    end
	




-- Cast any remaining short Cooldowns such as Fury of Elune Icon Fury of Elune, Warrior of Elune Icon Warrior of Elune, or Force of Nature Icon Force of Nature.
   if S.WarriorofElune:IsReadyP() and RubimRH.CDsON() and Target:IsInRange(40) then
        return S.WarriorofElune:Cast()
    end


    if S.FuryofElune:IsCastableP() and RubimRH.CDsON() and Target:IsInRange(40) then
        return S.FuryofElune:Cast()
    end


-- Cast the  Eclipse appropriate filler to try to fill up your Astral Power for the next Eclipse Icon Eclipse.
   if S.Wrath:IsCastableP(40) and Player:BuffP(S.EclipseSolar) and (not Player:IsMoving() or Player:BuffP(S.StarfallBuff) and S.StellarDrift:IsAvailable()) then
        return S.Wrath:Cast()
    end
	
	if S.Starfire:IsCastableP(40) and Player:BuffP(S.EclipseLunar) and (not Player:IsMoving() or Player:BuffP(S.StarfallBuff) and S.StellarDrift:IsAvailable() or Player:BuffP(S.WarriorofEluneBuff)) then
        return S.Starfire:Cast()
    end
	
 




-- Apply and maintain Moonfire Icon Moonfire, Sunfire Icon Sunfire, and Stellar Flare Icon Stellar Flare (if talented) on the target(s).
    if S.Sunfire:IsCastableP(40) and Target:DebuffRemains(S.MoonfireDebuff)>Target:DebuffRemains(S.SunfireDebuff) and not Player:PrevGCD(1, S.Sunfire) then
        return S.Sunfire:Cast()
    end
	
	    if S.Moonfire:IsCastableP(40) then
        return S.Moonfire:Cast()
    end
	    if S.Sunfire:IsCastableP(40) then
        return S.Sunfire:Cast()
    end


	

end

end
  -- Out of Combat
if not Player:AffectingCombat() then






	if    IsLeftAltKeyDown() then
		return S.stopcasting:Cast()
    end	

 -- if Player:IsChanneling() or Player:IsCasting() then
        -- return 0, 136213
    -- end

	if not RubimRH.queuedSpell[1]:CooldownUp() or not Target:IsInRange(10) or not Player:AffectingCombat() then
		RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
	end
	
	return 0, 625999
end 


	return 0, 625999
end 

RubimRH.Rotation.SetAPL(1467, APL);

local function PASSIVE()
   -- print(GetEnemiesCount());
    return RubimRH.Shared()
end

RubimRH.Rotation.SetPASSIVE(1467, PASSIVE);