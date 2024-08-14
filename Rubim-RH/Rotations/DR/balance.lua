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

RubimRH.Spell[102] = {
-- Abilities
  EclipseLunar                          = Spell(48518),
  EclipseSolar                          = Spell(48517),
  Wrath                                 = Spell(190984),
  -- Talents
  AetherialKindling                     = Spell(327541),
  AstralSmolder                         = Spell(394058),
  BalanceofAllThings                    = Spell(394048),
  CelestialAlignment                    = Spell(102560), -- 194223 without Orbital Strike, 383410 with Orbital Strike
  ElunesGuidance                        = Spell(393991),
  ForceofNature                         = Spell(205636),
  FungalGrowth                          = Spell(392999),
  FuryofElune                           = Spell(202770),
  --Incarnation                           = MultiSpell(102560,390414), -- 102560 without Orbital Strike, 390414 with Orbital Strike
  IncarnationTalent                     = Spell(394013),
  NaturesBalance                        = Spell(202430),
  OrbitBreaker                          = Spell(383197),
  OrbitalStrike                         = Spell(390378),
  PowerofGoldrinn                       = Spell(394046),
  PrimordialArcanicPulsar               = Spell(393960),
  RattletheStars                        = Spell(393954),
  Solstice                              = Spell(343647),
  SouloftheForest                       = Spell(114107),
  Starfall                              = Spell(191034),
  Starlord                              = Spell(202345),
  Starweaver                            = Spell(393940),
  Moonfire                              = Spell(8921),
  Sunfire                               = Spell(93402),
  StellarFlare                          = Spell(202347),
  Swipe                                 = Spell(213764),
  TwinMoons                             = Spell(279620),
  UmbralEmbrace                         = Spell(393760),
  UmbralIntensity                       = Spell(383195),
  WaningTwilight                        = Spell(393956),
  WarriorofElune                        = Spell(202425),
  WildMushroom                          = Spell(88747),
  -- New Moon Phases
  FullMoon                              = Spell(274283),
  HalfMoon                              = Spell(274282),
  NewMoon                               = Spell(274281),
  -- Buffs
  BOATArcaneBuff                        = Spell(394050),
  BOATNatureBuff                        = Spell(394049),
  CABuff                                = Spell(383410),
  IncarnationBuff                       = Spell(390414),
  PAPBuff                               = Spell(393961),
  RattledStarsBuff                      = Spell(393955),
  SolsticeBuff                          = Spell(343648),
  StarfallBuff                          = Spell(191034),
  StarlordBuff                          = Spell(279709),
  StarweaversWarp                       = Spell(393942),
  StarweaversWeft                       = Spell(393944),
  UmbralEmbraceBuff                     = Spell(393763),
  WarriorofEluneBuff                    = Spell(202425),
  -- Debuffs
  FungalGrowthDebuff                    = Spell(81281),
  StellarFlareDebuff                    = Spell(202347),
  -- Tier 29 Effects
  GatheringStarstuff                    = Spell(394412),
  TouchtheCosmos                        = Spell(394414),
  -- Legendary Effects
  BOATArcaneLegBuff                     = Spell(339946),
  BOATNatureLegBuff                     = Spell(339943),
  OnethsClearVisionBuff                 = Spell(339797),
  OnethsPerceptionBuff                  = Spell(339800),
  TimewornDreambinderBuff               = Spell(340049)
}
local S = RubimRH.Spell[102] 


if not Item.Druid then Item.Druid = {}; end
Item.Druid.Balance = {


	
};
local I = Item.Druid.Balance;
local ShouldReturn;

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

local function AOE()
    -- Keep Moonfire and Sunfire on targets
    if S.Moonfire:IsReady() and Target:DebuffRemainsP(S.MoonfireDebuff) < Player:GCD() then
        return S.Moonfire:Cast()
    end
    
    if S.Sunfire:IsReady() and Target:DebuffRemainsP(S.SunfireDebuff) < Player:GCD() then
        return S.Sunfire:Cast()
    end
    
    -- Get into Eclipse or activate cooldowns
	if RubimRH.CDsON() then
		if S.Eclipse:IsReady() then
			return S.Eclipse:Cast()
		elseif S.CelestialAlignment:IsReady() then
			return S.CelestialAlignment:Cast()
		end
	end
    
    -- Cast Starfall if Astral Power is available
    if S.Starfall:IsReady() and Player:AstralPower() >= 50 then
        return S.Starfall:Cast()
    end

    -- Cast Fury of Elune
    if S.FuryofElune:IsReady() then
        return S.FuryofElune:Cast()
    end
    
    -- Use Astral Communion when low on Astral Power
    if S.AstralCommunion:IsReady() and Player:AstralPower() < 20 then
        return S.AstralCommunion:Cast()
    end
    
    -- Cast Stellar Flare on targets that will live for more than 8 seconds
    if S.StellarFlare:IsReady() and Target:DebuffRemainsP(S.StellarFlareDebuff) < Player:GCD() and Target:TimeToDie() > 8 then
        return S.StellarFlare:Cast()
    end
    
    -- Spam Starfire
    if S.Starfire:IsReady() then
        return S.Starfire:Cast()
    end
end

local function ST()
    -- Keep Moonfire and Sunfire on targets
    if S.Moonfire:IsReady() and Target:DebuffRemainsP(S.MoonfireDebuff) < Player:GCD() then
        return S.Moonfire:Cast()
    end
    
    if S.Sunfire:IsReady() and Target:DebuffRemainsP(S.SunfireDebuff) < Player:GCD() then
        return S.Sunfire:Cast()
    end
    
    -- Cast Stellar Flare on targets
    if S.StellarFlare:IsReady() and Target:DebuffRemainsP(S.StellarFlareDebuff) < Player:GCD() then
        return S.StellarFlare:Cast()
    end
    
    -- Stay in Eclipse as often as possible
    if S.Eclipse:IsReady() and RubimRH.CDsON() then
        return S.Eclipse:Cast()
    end
    
    -- Cast Starsurge when Astral Power is capped
    if S.Starsurge:IsReady() and Player:AstralPower() >= 90 then
        return S.Starsurge:Cast()
    end
    
    -- Use minor cooldowns: Astral Communion and Fury of Elune
    if S.AstralCommunion:IsReady() then
        return S.AstralCommunion:Cast()
    end
    
    if S.FuryofElune:IsReady() then
        return S.FuryofElune:Cast()
    end
    
    -- Use Convoke the Spirits
    if S.ConvoketheSpirits:IsReady() then
        return S.ConvoketheSpirits:Cast()
    end
	-- Use New Moon and pool Astral Power for burst phases
	if S.NewMoon:IsReady() and Player:AstralPower() < 90 then
		return S.NewMoon:Cast()
	end

	-- Cast Starfire with Umbral Embrace proc during Eclipse
	if S.Starfire:IsReady() and Player:Buff(S.UmbralEmbrace) and Player:Buff(S.Eclipse) then
		return S.Starfire:Cast()
	end

	-- Cast Wrath as a builder to generate Astral Power
	if S.Wrath:IsReady() then
		return S.Wrath:Cast()
	end
end


local function APL()
ST()
AOE()
HL.GetEnemies(40)

--------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------Functions/Top priorities----------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
if Player:IsCasting() or Player:IsChanneling() then
	return 0, "Interface\\Addons\\Rubim-RH\\Media\\channel.tga"
elseif Player:IsDeadOrGhost() or AuraUtil.FindAuraByName("Drink", "player") or AuraUtil.FindAuraByName("Food", "player") or AuraUtil.FindAuraByName("Food & Drink", "player") or AuraUtil.FindAuraByName("Shroud of Concealment", "player") then
    return 0, "Interface\\Addons\\Rubim-RH\\Media\\mount2.tga"
end



--------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------Out of Combat---------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
if not Player:AffectingCombat() then

end
--------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------Spell Queue-----------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
if not RubimRH.queuedSpell[1]:CooldownUp() or not Player:AffectingCombat() or Player:BuffP(S.VanishBuff) then
    RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
end


if RubimRH.QueuedSpell():IsReadyQueue() then
    return RubimRH.QueuedSpell():Cast()
end
--------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------Interrupts & Tranq-----------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------



--------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------Cooldowns-------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------




--------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------Rotation--------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
if Player:CanAttack(Target) and Player:AffectingCombat() then



      
        
        -- Determine if AOE or ST rotation should be used
        if Cache.EnemiesCount[40] >= 3 then
            return AOE()
        else
            return ST()
        end
























end
	return 0, "Interface\\Addons\\Rubim-RH\\Media\\mount2.tga"
end 

RubimRH.Rotation.SetAPL(102, APL);

local function PASSIVE()
   -- print(GetEnemiesCount());
    return RubimRH.Shared()
end

RubimRH.Rotation.SetPASSIVE(102, PASSIVE);