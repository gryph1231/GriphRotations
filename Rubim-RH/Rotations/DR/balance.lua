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

if not Spell.Druid then
    Spell.Druid = {};
end


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------SPELLS/ITEMS-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



RubimRH.Spell[102] = {

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
Starweaver = Spell(393940),
AetherialKindling = Spell(327541),
OrbitBreaker = Spell(383197),
SolsticeBuff = Spell(343648),
CABuff = Spell(383410),
    MoonkinForm                           = Spell(24858),
    Wrath                                 = Spell(190984),
    FuryofElune                           = Spell(202770),
    CelestialAlignmentBuff                = Spell(194223),
    IncarnationBuff                       = Spell(102560),
    CelestialAlignment                    = Spell(194223),
    Incarnation                           = Spell(102560),
    ForceofNature                         = Spell(205636),
    Sunfire                               = Spell(93402),
    SunfireDebuff                         = Spell(164815),
    Moonfire                              = Spell(8921),
    Regrowth                              = Spell(8936),
    MoonfireDebuff                        = Spell(164812),
    StellarFlare                          = Spell(202347),
	StellarFlareDebuff                    = Spell(202347),
    Starfire                              = Spell(194153),
    LunarEmpowermentBuff                  = Spell(164547),
    SolarEmpowermentBuff                  = Spell(164545),
    Starsurge                             = Spell(78674),
    OnethsIntuitionBuff                   = Spell(209406),
    Starfall                              = Spell(191034),
    StarlordBuff                          = Spell(279709),
    NewMoon                               = Spell(274281),
    HalfMoon                              = Spell(274282),
    FullMoon                              = Spell(274283),
    WarriorofEluneBuff                    = Spell(202425),
    BloodFury                             = Spell(20572),
    Berserking                            = Spell(26297),
    ArcaneTorrent                         = Spell(50613),
    LightsJudgment                        = Spell(255647),
    WarriorofElune                        = Spell(202425),
    SunblazeBuff                          = Spell(274399),
    OwlkinFrenzyBuff                      = Spell(157228),
    SolarBeam                             = Spell(78675),
	LivelySpirit                          = Spell(279642),
	LivelySpiritBuff                      = Spell(279646),
	StreakingStars                        = Spell(272871),
	ShootingStars                         = Spell(202342),
	Barkskin                              = Spell(22812),
	Soothe                                = Spell(2908),
	Innervate                             = Spell(29166),
	Renewal                               = Spell(108238),
    Typhoon                               = Spell(132469),
	MightyBash                            = Spell(5211),
	ArcanicPulsarBuff                     = Spell(287790),
    ArcanicPulsar                         = Spell(287773),
	StarlordBuff                          = Spell(279709),
    Starlord                              = Spell(202345),
	-- 8.2 Essences
	RavenousFrenzy = Spell(323546),
	healingpot = Spell(176108),
    SolarBeam                             = Spell(78675),
ConvoketheSpirits = Spell(323764),
KindredEmpowermentEnergize = Spell(338142),
    Thorns                                = Spell(236696),
    TwinMoons                             = Spell(279620),
	ShootingStars                         = Spell(202342),
    NaturesBalance                        = Spell(202430),
    Barkskin                              = Spell(22812),
    Renewal                               = Spell(108238),
    SolarBeam                             = Spell(78675),
    ShiverVenomDebuff                     = Spell(301624),
    CyclotronicBlast                      = Spell(167672),
    AzsharasFontofPowerBuff               = Spell(296962),
StellarDrift = Spell(202354),
stopcasting = Spell(291944),
 GaurdianAffinity = Spell(197491),
lustAT = Spell(155145),
lust1 = Spell(57724),
lust2 = Spell(57723),
lust3 = Spell(80354),
lust4 = Spell(95809),
lust5 = Spell(264689),
IncapacitatingRoar = Spell(99),
incapacitatingroar = Spell(22568), --ferocious bite
KindredSpirits = Spell(326434),
EclipseLunar = Spell(48518),
EclipseSolar = Spell(48517),

}
local S = RubimRH.Spell[102] 


if not Item.Druid then Item.Druid = {}; end
Item.Druid.Balance = {
    -- Legendaries
	trink2 = Item(159617, { 13, 14 }),

	trink = Item(169311, { 13, 14 }),

	lust = Item(164978),
       healingpot = Item(169451), --astral healing pot
    healthstone = Item(5512), --health stone
	
};
local I = Item.Druid.Balance;




-- Rotation Var
local ShouldReturn; -- Used to get the return string

-- Variables
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


local function RangeCount(spellName)
    local range_counter = 0

    if spellName then
        for i = 1, 40 do
            local unitID = "nameplate" .. i
            if UnitExists(unitID) then           
                local nameplate_guid = UnitGUID(unitID) 
                local npc_id = select(6, strsplit("-", nameplate_guid))
                if npc_id ~= '120651' and npc_id ~= '161895' then
                    if UnitCanAttack("player", unitID) and IsSpellInRange(spellName, unitID) == 1 and UnitHealthMax(unitID) > 5 then
                        range_counter = range_counter + 1
                    end                    
                end
            end
        end
    end

    return range_counter
end

local function TargetInRange(spellName)
    if spellName and IsSpellInRange(spellName, "target") == 1 then
        return true
    else
        return false    
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






local function EvaluateCycleSunfire(TargetUnit)
  return (TargetUnit:DebuffRefreshableCP(S.SunfireDebuff)) and (AP_Check(S.Sunfire) and math.floor (TargetUnit:TimeToDie() / (2 * Player:SpellHaste())) * inRange45 >= math.ceil (math.floor (2 / inRange45) * 1.5) + 2 * EnemiesCount and (EnemiesCount > 1 + num(S.TwinMoons:IsAvailable()) or TargetUnit:DebuffP(S.MoonfireDebuff)) and (not bool(VarAzSs) or not Player:BuffP(CaInc()) or not Player:PrevGCDP(1, S.Sunfire)) and (Player:BuffRemainsP(CaInc()) > TargetUnit:DebuffRemainsP(S.SunfireDebuff) or not Player:BuffP(CaInc())))
end

local function EvaluateCycleMoonfire(TargetUnit)
  return (TargetUnit:DebuffRefreshableCP(S.MoonfireDebuff)) and (AP_Check(S.Moonfire) and math.floor (TargetUnit:TimeToDie() / (2 * Player:SpellHaste())) * inRange45 >= 6 and (not bool(VarAzSs) or not Player:BuffP(CaInc()) or not Player:PrevGCDP(1, S.Moonfire)) and (Player:BuffRemainsP(CaInc()) > TargetUnit:DebuffRemainsP(S.MoonfireDebuff) or not Player:BuffP(CaInc())))
end

local function EvaluateCycleStellarFlare(TargetUnit)
  return (TargetUnit:DebuffRefreshableCP(S.StellarFlareDebuff)) and (AP_Check(S.StellarFlare) and math.floor (TargetUnit:TimeToDie() / (2 * Player:SpellHaste())) >= 5 and (not bool(VarAzSs) or not Player:BuffP(CaInc()) or not Player:PrevGCDP(1, S.StellarFlare)) and not Player:IsCasting(S.StellarFlare))
end

local dotrequirements

local function APL()
    inRange45 = RangeCount("Starfire")
    inRange10 = RangeCount("Shred")

    targetRange45 = TargetInRange("Starfire")
    targetRange10 = TargetInRange("Shred")


    if Player:IsCasting() or Player:IsChanneling() then
        return 0, "Interface\\Addons\\Rubim-RH\\Media\\channel.tga"
    elseif Player:IsDeadOrGhost() or AuraUtil.FindAuraByName("Drink", "player") 
    or AuraUtil.FindAuraByName("Food", "player") or AuraUtil.FindAuraByName("Food & Drink", "player") then
        return 0, "Interface\\Addons\\Rubim-RH\\Media\\mount2.tga"
    end


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
	
		if S.Cyclone:ID() ==  RubimRH.queuedSpell[1]:ID() and targetRange45 then
		return S.cyclone:Cast()
	end
	
			if S.Cyclone:ID() ==  RubimRH.queuedSpell[1]:ID() and not targetRange45 then
		RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
	end
	
			if S.Typhoon:ID() ==  RubimRH.queuedSpell[1]:ID() and targetRange45 then
		return S.typhoon:Cast()
	end
	
			if S.Typhoon:ID() ==  RubimRH.queuedSpell[1]:ID() and not targetRange45 then
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

if S.IncapacitatingRoar:IsReady()  and inRange10>=1 and Player:HealthPercentage()<20 then
return S.incapacitatingroar:Cast()
end

  if S.Ironfur:IsReadyP() and inRange10>=1 then
        return S.Ironfur:Cast()
    end
	
if (not Target:Debuff(S.ThrashDebuff) or Target:DebuffRemainsP(S.ThrashDebuff)<13 and Target:Debuff(S.ThrashDebuff)) and inRange10>=1  then
		return S.Thrash:Cast()
	end
	
  if S.Mangle:IsReadyP() and targetRange10 then
        return S.Mangle:Cast()
    end
 
end




  if S.Berserking:IsCastableP() and targetRange45 and Player:BuffP(S.CelestialAlignmentBuff) then
        return S.Berserking:Cast()
    end



	
	if not Player:Buff(S.MoonkinForm) then
        return S.MoonkinForm:Cast()
    end
	
if Player:BuffP(S.MoonkinForm) then	

	--AOE------------------------------------


if HL.CombatTime()<3 and Player:AstralPower()<90 and (not Player:BuffP(S.EclipseLunar) and not Player:BuffP(S.EclipseSolar)) then


-- Apply and maintain  Moonfire, Sunfire Icon Sunfire on all targets if they will live longer than 8-seconds.
	    if S.Sunfire:IsCastableP() and targetRange45  and Target:DebuffRemainsP(S.SunfireDebuff) < 5.4 and Target:TimeToDie()> 12  and inRange45>=2 then
        return S.Sunfire:Cast()
    end
	


	if S.Starfire:IsCastableP() and targetRange45  and Player:BuffP(S.EclipseLunar) and (not Player:IsMoving() or Player:BuffP(S.StarfallBuff) and S.StellarDrift:IsAvailable() or Player:BuffP(S.WarriorofEluneBuff)) then
        return S.Starfire:Cast()
    end
	
    if S.Wrath:IsCastableP() and targetRange45  and Player:BuffP(S.EclipseSolar) and (not Player:IsMoving() or Player:BuffP(S.StarfallBuff) and S.StellarDrift:IsAvailable()) then
        return S.Wrath:Cast()
    end

    if S.Wrath:IsCastableP() and targetRange45  and S.Wrath:Count()>=1  and (not Player:IsMoving() or Player:BuffP(S.StarfallBuff) and S.StellarDrift:IsAvailable()) then
        return S.Wrath:Cast()
    end

   if S.Starfire:IsCastableP() and targetRange45  and S.Starfire:Count()>=1  and (not Player:IsMoving() or Player:BuffP(S.StarfallBuff) and S.StellarDrift:IsAvailable() or Player:BuffP(S.WarriorofEluneBuff)) then
        return S.Starfire:Cast()
    end
	
end



  

-- print(Player:SpellHaste())
    -- variable,name=is_aoe,value=spell_targets.starfall>(1+(!talent.aetherial_kindling&!talent.starweaver))&talent.starfall
    VarIsAoe = (inRange45 > (1 + num(not S.AetherialKindling:IsAvailable() and not S.Starweaver:IsAvailable())) and S.Starfall:IsAvailable())
    VarPassiveAsp = 6 / Player:SpellHaste() + 
    num(S.NaturesBalance:IsAvailable()) + 
    num(S.OrbitBreaker:IsAvailable()) * num(Target:Debuff(S.MoonfireDebuff)) * num(Player:BuffStack(S.OrbitBreaker) > (27 - 2 * num(Player:Buff(S.SolsticeBuff)))) * 40
    CAIncBuffUp = Player:Buff(S.CABuff) or Player:Buff(S.IncarnationBuff)
    CAIncBuffRemains = 0
    if CAIncBuffUp then
      CAIncBuffRemains = S.Incarnation:IsAvailable() and Player:BuffRemains(S.IncarnationBuff) or Player:BuffRemains(S.CABuff)
    end
  
-- print( S.FullMoon:ExecuteTime())


if inRange45 >=2 then
	
    -- DOT targets with  Moonfire and  Sunfire with 100% uptime. This is very important due to our mastery. This is the first global priority.
    -- Apply and maintain  Moonfire, Sunfire Icon Sunfire on all targets if they will live longer than 8-seconds.
    if S.Sunfire:IsCastableP() and targetRange45  and Target:DebuffRemainsP(S.SunfireDebuff) < 5.4 and Target:TimeToDie()> 8  then
        return S.Sunfire:Cast()
    end
	

    if S.Moonfire:IsCastableP() and targetRange45  and Target:DebuffRemainsP(S.MoonfireDebuff) < 6.6 and Target:TimeToDie()> 8 and Player:BuffP(S.EclipseSolar) then
        return S.Moonfire:Cast()
    end
    -- Get into Eclipse ASAP or Press your Cooldowns. If you are going to use cooldowns on AOE you just activate after you get everything DOTted. The Eclipse priority on AOE is Lunar for 3 targets and more and Solar for 2.
    
    if S.Wrath:IsCastableP() and targetRange45 and inRange45>=2  and S.Wrath:Count()>=1 and (not Player:IsMoving() or Player:BuffP(S.StarfallBuff) and S.StellarDrift:IsAvailable()) then
        return S.Wrath:Cast()
    end

   if S.Starfire:IsCastableP() and targetRange45 and inRange45<=2 and S.Starfire:Count()>=1 and (not Player:IsMoving() or Player:BuffP(S.StarfallBuff) and S.StellarDrift:IsAvailable() or Player:BuffP(S.WarriorofEluneBuff)) then
        return S.Starfire:Cast()
    end

    --  Starfall until you are 0 Astral Power.  Starsurge is still the spender on 2 targets if you do not have  Aetherial Kindling or  Starweaver.
        if S.Starsurge:IsReadyP() and inRange45<=2 and (not S.AetherialKindling:IsAvailable() and not S.Starweaver:IsAvailable()) then
            return S.Starsurge:Cast()
        end
        -- Maintain Starfall to consume Astral Power.
    if S.Starfall:IsReadyP() and Player:AstralPower()>0 then
        return S.Starfall:Cast()
    end
    -- Do not let yourself cap to 3  Wild Mushroom. They do a ton of AOD damage. If you have  Waning Twilight you might want to make sure your  Wild Mushroom DOT is up as long as possible.
    -- Use  Fury of Elune as often as possible. It is very good AP generation.
    
    if S.FuryofElune:IsCastableP() and RubimRH.CDsON() and targetRange45 then
        return S.FuryofElune:Cast()
    end

    -- Try to use  Full Moon inside of Incarn or Pulsar procs if possible. If it is not possible make sure you do not cap Moons. Cycle Half / New Moon outside of your cooldowns.

        if S.FullMoon:IsCastable() and (Player:AstralPowerDeficit() > VarPassiveAsp + S.FullMoon:EnergizeAmount() and (Player:BuffRemains(S.EclipseLunar) > S.FullMoon:ExecuteTime() or Player:BuffRemains(S.EclipseSolar) > S.FullMoon:ExecuteTime()) and (CAIncBuffUp or S.HalfMoon:ChargesFractional() > 2.5 and PAPValue <= 520 and CaInc:CooldownRemains() > 10 or FightRemains < 10)) then
            return S.FullMoon:Cast()
          end     
    --  Stellar Flare targets that will live longer than 8 seconds assuming the trash pack also takes longer than 30 seconds and you will not overcap on AP.
    -- Spam  Starfire on 3+ targets,  Wrath on 2 targets. You also  Wrath on 3 targets whenever you are in your  Incarnation: Chosen of Elune.


if S.CelestialAlignment:IsReadyP() and RubimRH.CDsON() and Player:AstralPower()>=45 and targetRange45 and (not Player:BuffP(S.EclipseLunar) or not Player:BuffP(S.EclipseSolar)) then
return S.CelestialAlignment:Cast()
end
	
	
-- Maintain Starfall to consume Astral Power.
    if S.Starfall:IsReadyP() and inRange45>=2 and Player:BuffRemainsP(S.StarfallBuff)<Player:GCD()*1.5 then
        return S.Starfall:Cast()
    end
	

	
	if S.Starfire:IsCastableP() and targetRange45  and Player:BuffP(S.WarriorofEluneBuff) then
        return S.Starfire:Cast()
    end
	


	
    if S.StellarFlare:IsCastableP() and targetRange45  and Target:DebuffRemainsP(S.StellarFlareDebuff)<5.5 and Target:TimeToDie()> 14 then
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


    if S.WarriorofElune:IsReadyP() and RubimRH.CDsON() and targetRange45 then
        return S.WarriorofElune:Cast()
    end


    if S.FuryofElune:IsCastableP() and RubimRH.CDsON() and targetRange45 then
        return S.FuryofElune:Cast()
    end


-- Cast Starsurge when available. Try to keep enough Astral Power for Starfall when its low duration.
  -- if S.Starsurge:IsReadyP(40) and ((Player:BuffP(S.EclipseLunar) or Player:BuffP(S.EclipseSolar)) and (Player:BuffP(S.Starfall) and Player:AstralPower()>=75 or Player:AstralPower()>=90))  then
        -- return S.Starsurge:Cast()
    -- end
	

	-- if S.Starfire:IsCastableP() and targetRange45  and Player:BuffP(S.EclipseSolar) and active_enemies()>4 and (not Player:IsMoving() or Player:BuffP(S.StarfallBuff) and S.StellarDrift:IsAvailable() or Player:BuffP(S.WarriorofEluneBuff)) then
        -- return S.Starfire:Cast()
    -- end 
	
-- Cast the Eclipse appropriate filler to try to fill up your Astral Power for the next Eclipse.	
	if S.Starfire:IsCastableP() and targetRange45  and Player:BuffP(S.EclipseLunar) and (not Player:IsMoving() or Player:BuffP(S.StarfallBuff) and S.StellarDrift:IsAvailable() or Player:BuffP(S.WarriorofEluneBuff)) then
        return S.Starfire:Cast()
    end
	
    if S.Wrath:IsCastableP() and targetRange45  and Player:BuffP(S.EclipseSolar) and (not Player:IsMoving() or Player:BuffP(S.StarfallBuff) and S.StellarDrift:IsAvailable()) then
        return S.Wrath:Cast()
    end


end	
	
	





        if (true) then
		    variableaoe = RubimRH.AoEON() and (inRange45>1 and (not S.Starlord:IsAvailable() or S.StellarDrift:IsAvailable()) or inRange45>2)
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

    if S.Moonfire:IsCastableP() and targetRange45  and Target:DebuffRemainsP(S.MoonfireDebuff) < 6.6 and Target:TimeToDie()> 12 and dotrequirements then
        return S.Moonfire:Cast()
    end
	


-- sunfire,target_if=refreshable&target.time_to_die>12,if=ap_check&variable.dot_requirements

	    if S.Sunfire:IsCastableP() and targetRange45  and Target:DebuffRemainsP(S.SunfireDebuff) < 5.4 and Target:TimeToDie()> 12 and dotrequirements then
        return S.Sunfire:Cast()
    end


-- stellar_flare,target_if=refreshable&target.time_to_die>16,if=ap_check&variable.dot_requirements
    if S.StellarFlare:IsCastableP() and targetRange45  and Target:DebuffRemainsP(S.StellarFlareDebuff)<5.5 and Target:TimeToDie()> 12 and dotrequirements then
        return S.StellarFlare:Cast()
    end



-- force_of_nature,if=ap_check
    if S.ForceofNature:IsCastableP() and targetRange45  then
        return S.ForceofNature:Cast()
    end



-- kindred_spirits,if=((buff.eclipse_solar.remains>10|buff.eclipse_lunar.remains>10)
-- &cooldown.ca_inc.remains>30
-- &(buff.primordial_arcanic_pulsar.value<240|!runeforge.primordial_arcanic_pulsar.equipped))|buff.primordial_arcanic_pulsar.value>=270|cooldown.ca_inc.ready
-- &(astral_power>90|variable.is_aoe)

    -- if S.KindredSpirits:IsCastableP() and targetRange45  and
	-- (((Player:BuffRemainsP(S.EclipseSolar)>10 or Player:BuffRemainsP(S.EclipseLunar)>10)
	-- and S.CelestialAlignment:CooldownRemainsP()>30 and RubimRH.CDsON()
	-- and ( Player:CanAttack(Target))) or S.CelestialAlignment:CooldownRemainsP()==0
	-- and (Player:AstralPower()>90 or variableaoe))
	
	-- then
        -- return S.KindredSpirits:Cast()
    -- end


-- celestial_alignment,if=(astral_power>90
-- &(buff.kindred_empowerment_energize.up|!covenant.kyrian)|covenant.night_fae|variable.is_aoe|

if S.CelestialAlignment:IsReadyP() and (RubimRH.CDsON() and Player:AstralPower()>=90 and targetRange45 or variableaoe and RubimRH.CDsON()) then
return S.CelestialAlignment:Cast()
end	


-- incarnation,if=(astral_power>90&(buff.kindred_empowerment_energize.up|!covenant.kyrian)|covenant.night_fae|variable.is_aoe|buff.bloodlust.up&buff.bloodlust.remains<30+((9*runeforge.primordial_arcanic_pulsar.equipped)+(conduit.precise_alignment.time_value)))&!buff.ca_inc.up&(!covenant.night_fae|cooldown.convoke_the_spirits.up|interpolated_fight_remains<cooldown.convoke_the_spirits.remains+6|interpolated_fight_remains%%180<30+(conduit.precise_alignment.time_value))
if S.Incarnation:IsReadyP() and (RubimRH.CDsON() and Player:AstralPower()>=90 and targetRange45 or variableaoe and RubimRH.CDsON()) then
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
  if S.Starsurge:IsReadyP() and targetRange45 and (S.Starlord:IsAvailable() and  Player:AstralPower()>90 and Player:BuffStackP(S.StarlordBuff)<3) then
        return S.Starsurge:Cast()
    end
  if S.Starsurge:IsReadyP()  and targetRange45 and (S.Starlord:IsAvailable() and Player:BuffP(S.StarlordBuff) and Player:BuffStackP(S.StarlordBuff)<3) then
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
    if S.Wrath:IsCastableP() and targetRange45  and S.Wrath:Count()>=1  and (not Player:IsMoving() or Player:BuffP(S.StarfallBuff) and S.StellarDrift:IsAvailable()) then
        return S.Wrath:Cast()
    end

   if S.Starfire:IsCastableP() and targetRange45  and S.Starfire:Count()>=1  and (not Player:IsMoving() or Player:BuffP(S.StarfallBuff) and S.StellarDrift:IsAvailable() or Player:BuffP(S.WarriorofEluneBuff)) then
        return S.Starfire:Cast()
    end
	




-- Cast any remaining short Cooldowns such as Fury of Elune Icon Fury of Elune, Warrior of Elune Icon Warrior of Elune, or Force of Nature Icon Force of Nature.
   if S.WarriorofElune:IsReadyP() and RubimRH.CDsON() and targetRange45 then
        return S.WarriorofElune:Cast()
    end


    if S.FuryofElune:IsCastableP() and RubimRH.CDsON() and targetRange45 then
        return S.FuryofElune:Cast()
    end


-- Cast the  Eclipse appropriate filler to try to fill up your Astral Power for the next Eclipse Icon Eclipse.
   if S.Wrath:IsCastableP() and targetRange45  and Player:BuffP(S.EclipseSolar) and (not Player:IsMoving() or Player:BuffP(S.StarfallBuff) and S.StellarDrift:IsAvailable()) then
        return S.Wrath:Cast()
    end
	
	if S.Starfire:IsCastableP() and targetRange45  and Player:BuffP(S.EclipseLunar) and (not Player:IsMoving() or Player:BuffP(S.StarfallBuff) and S.StellarDrift:IsAvailable() or Player:BuffP(S.WarriorofEluneBuff)) then
        return S.Starfire:Cast()
    end
	
 




-- Apply and maintain Moonfire Icon Moonfire, Sunfire Icon Sunfire, and Stellar Flare Icon Stellar Flare (if talented) on the target(s).
    if S.Sunfire:IsCastableP() and targetRange45  and Target:DebuffRemains(S.MoonfireDebuff)>Target:DebuffRemains(S.SunfireDebuff) and not Player:PrevGCD(1, S.Sunfire) then
        return S.Sunfire:Cast()
    end
	
	    if S.Moonfire:IsCastableP() and targetRange45  then
        return S.Moonfire:Cast()
    end
	    if S.Sunfire:IsCastableP() and targetRange45  then
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

	if not RubimRH.queuedSpell[1]:CooldownUp() or not targetRange10 or not Player:AffectingCombat() then
		RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
	end
	
    return 0, "Interface\\Addons\\Rubim-RH\\Media\\griph.tga"
    end 


    return 0, "Interface\\Addons\\Rubim-RH\\Media\\griph.tga"
end 

RubimRH.Rotation.SetAPL(102, APL);

local function PASSIVE()
   -- print(GetEnemiesCount());
    return RubimRH.Shared()
end

RubimRH.Rotation.SetPASSIVE(102, PASSIVE);