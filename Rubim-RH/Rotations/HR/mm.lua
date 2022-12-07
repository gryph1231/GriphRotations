-- 4/4/2019 rewrite
local addonName, addonTable = ...;
local HL = HeroLib;
local Cache = HeroCache;
local Unit = HL.Unit;
local Pet = Unit.Pet;
local Player = Unit.Player;
local Target = Unit.Target;
local Spell = HL.Spell;
local Item = HL.Item;

RubimRH.Spell[254] = {
    SummonPet = Spell(883),
    HuntersMarkDebuff = Spell(257284),
    HuntersMark = Spell(257284),
    DoubleTap = Spell(260402),
    Trueshot = Spell(288613),
    AimedShot = Spell(19434),
    UnerringVisionBuff = Spell(274446),
    UnerringVision = Spell(274444),
    CallingtheShots = Spell(260404),
    SurgingShots = Spell(287707),
    Streamline = Spell(260367),
    FocusedFire = Spell(278531),
    RapidFire = Spell(257044),
    Berserking = Spell(26297),
    BloodFury = Spell(20572),
    CarefulAim = Spell(260228),
    ExplosiveShot = Spell(212431),
    ExplosiveShotz = Spell(287712), --haymaker
    Barrage = Spell(120360),
    AMurderofCrows = Spell(131894),
    SerpentSting = Spell(271788),
    SerpentStingDebuff = Spell(271788),
    ArcaneShot = Spell(185358),
    MasterMarksmanBuff = Spell(269576),
    PreciseShotsBuff = Spell(260242),
    IntheRhythm = Spell(264198),
    PiercingShot = Spell(198670),
    SteadyFocus = Spell(193533),
    SteadyShot = Spell(56641),
    TrickShotsBuff = Spell(257622),
    Multishot = Spell(257620),
    SurvivalOfTheFittest = Spell(264735),
    Exhilaration = Spell(109304),
    AspectoftheTurtle = Spell(186265),
    CounterShot = Spell(147362),
	RazorFragments = Spell(388998),
	KillShot = Spell(53351),
	DeathChakram = Spell(375891),
	DeathChakramz = Spell(260364), --arcane pulse
	Volley = Spell(260243),
    Bulletstorm = Spell(389020),
    FreezingTrap = Spell(187650),
	FreezingTrapz = Spell(255654), --bullrush
}

local S = RubimRH.Spell[254]

if not Item.Hunter then
    Item.Hunter = {}
end

Item.Hunter.Marksmanship = {
}

local I = Item.Hunter.Marksmanship



S.AimedShot:RegisterInFlight()

local function GetEnemiesCount()
  if RubimRH.AoEON() then
    if RubimRH.db.profile[254].useSplashData == "Enabled" then
      RubimRH.UpdateSplashCount(Target, 10)
      return RubimRH.GetSplashCount(Target, 10)
    else
      UpdateRanges()
      --return GetEnemiesCount()
	  return active_enemies()
    end
  else
    return 1
  end
end

local function APL ()

--------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------Functions/Top priorities----------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
if Player:IsCasting() or Player:IsChanneling() then
	return 0, "Interface\\Addons\\Rubim-RH\\Media\\channel.tga"
elseif Player:IsDeadOrGhost() or AuraUtil.FindAuraByName("Drink", "player") or AuraUtil.FindAuraByName("Food", "player") 
or AuraUtil.FindAuraByName("Food & Drink", "player") or AuraUtil.FindAuraByName("Feign Death", "player") then
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
if not RubimRH.queuedSpell[1]:CooldownUp() or not Player:AffectingCombat() then
	RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
end

if S.FreezingTrap:ID() == RubimRH.queuedSpell[1]:ID() then
	return S.FreezingTrapz:Cast()
end

if RubimRH.QueuedSpell():IsReadyQueue() and S.DoubleTap:ID() ~= RubimRH.queuedSpell[1]:ID() and S.DeathChakram:ID() ~= RubimRH.queuedSpell[1]:ID() and S.FreezingTrap:ID() ~= RubimRH.queuedSpell[1]:ID() then
    return RubimRH.QueuedSpell():Cast()
end
--------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------Interrupts & Tranq-----------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------


--------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------Cooldowns-------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
if S.Exhilaration:IsCastable() and Player:AffectingCombat() and Player:HealthPercentage() <= 35 then
	return S.Exhilaration:Cast()
end
--------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------Rotation--------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
if Player:AffectingCombat() and Player:CanAttack(Target) then

	if RubimRH.AoEON() then
		if S.KillShot:IsReadyQueue(44) and Player:BuffP(S.RazorFragments) then
			return S.KillShot:Cast()
		end
		
		if S.ExplosiveShot:IsReadyQueue(44) then
			return S.ExplosiveShotz:Cast()
		end
		
		if S.DoubleTap:IsReadyQueue(44) and (S.DoubleTap:ID() == RubimRH.queuedSpell[1]:ID() or RubimRH.CDsON())
		and ((S.RapidFire:CooldownRemainsP() <= Player:GCD() and Target:HealthPercentage() < 70)
		or (S.RapidFire:CooldownRemainsP() <= Player:GCD() and Target:HealthPercentage() >= 70)) then
			return S.DoubleTap:Cast()
		end
		
		if S.DeathChakram:IsReadyQueue(44) and (S.DeathChakram:ID() == RubimRH.queuedSpell[1]:ID() or RubimRH.CDsON()) then
			return S.DeathChakramz:Cast()
		end

		if S.RapidFire:IsReadyQueue(44) and Player:BuffP(S.TrickShotsBuff) then
			return S.RapidFire:Cast()
		end
		
		-- if S.Trueshot:IsReadyQueue(44) and RubimRH.CDsON() then
			-- return S.Trueshot:Cast()
		-- end
		
		if S.AimedShot:IsReadyQueue(44) and not Player:IsMoving()
		and Player:BuffP(S.TrickShotsBuff) and (not Player:BuffP(S.PreciseShotsBuff) or Player:BuffP(S.Trueshot)) then
			return S.AimedShot:Cast()
		end
		
		if S.Multishot:IsReadyQueue(44) and (not Player:BuffP(S.TrickShotsBuff) or Player:BuffP(S.PreciseShotsBuff) or Player:BuffStackP(S.Bulletstorm) >= 10) then
			return S.Multishot:Cast()
		end

		if S.SteadyShot:IsReadyQueue(44) then
			return S.SteadyShot:Cast()
		end
		
	elseif not RubimRH.AoEON() then
	
		if S.KillShot:IsReadyQueue(44) then
			return S.KillShot:Cast()
		end
		
		if S.ExplosiveShot:IsReadyQueue(44) then
			return S.ExplosiveShotz:Cast()
		end
		
		if S.DoubleTap:IsReadyQueue(44) and (S.DoubleTap:ID() == RubimRH.queuedSpell[1]:ID() or RubimRH.CDsON())
		and ((S.RapidFire:CooldownRemainsP() <= Player:GCD() and Target:HealthPercentage() < 70)
		or (S.RapidFire:CooldownRemainsP() <= Player:GCD() and Target:HealthPercentage() >= 70)) then
			return S.DoubleTap:Cast()
		end
		
		if S.DeathChakram:IsReadyQueue(44) and (S.DeathChakram:ID() == RubimRH.queuedSpell[1]:ID() or RubimRH.CDsON()) then
			return S.DeathChakramz:Cast()
		end

		if S.RapidFire:IsReadyQueue(44) then
			return S.RapidFire:Cast()
		end
		
		if S.AimedShot:IsReadyQueue(44) and not Player:IsMoving()
		and (not Player:BuffP(S.PreciseShotsBuff) or Player:BuffP(S.Trueshot)) then
			return S.AimedShot:Cast()
		end

		if S.ArcaneShot:IsReadyQueue(44) and Player:BuffP(S.PreciseShotsBuff) then
			return S.ArcaneShot:Cast()
		end
		
		if S.SteadyShot:IsReadyQueue(44) then
			return S.SteadyShot:Cast()
		end

	end
end
	return 0, "Interface\\Addons\\Rubim-RH\\Media\\mount2.tga"
end


RubimRH.Rotation.SetAPL(254, APL)

local function PASSIVE()

end

RubimRH.Rotation.SetPASSIVE(254, PASSIVE)