--- Localize Vars
-- Addon
local addonName, addonTable = ...;
-- HeroLib
local HL = HeroLib;
local Cache = HeroCache;
local Unit = HL.Unit;
local Player = Unit.Player;
local Pet = Unit.Pet;
local Focus = Unit.Focus;
local Nameplate = Unit.Nameplate;
local Target = Unit.Target;
local Spell = HL.Spell;
local Item = HL.Item;
local mainAddon = RubimRH

-- Spells
RubimRH.Spell[253] = {
    AncestralCall = Spell(274738),
    Berserking = Spell(26297),
    BerserkingBuff = Spell(26297),
    BloodFury = Spell(20572),
    BloodFuryBuff = Spell(20572),
    Bloodshed = Spell(321530),
    DireBeast = Spell(120679),
    SpiritMendz = Spell(28880), --gift of naaru
    HuntersMark = Spell(257284),
    Shadowmeld = Spell(58984),
    CallPet = Spell(883),
    MendPet = Spell(136),
    RevivePet = Spell(982),
	Dashz = Spell(287712), --haymaker
    AspectoftheWild = Spell(193530),
	WildSpirits = Spell(328231),
    BarbedShot = Spell(217200),
    BarbedShotFocus = Spell(260364), --arcane pulse
	BarbedShotP1 = Spell(69041), --rocket barrage
	BarbedShotP2 = Spell(20594), --stoneform
	BarbedShotP3 = Spell(781), --disengage
	BarbedShotP4 = Spell(1513), --scare beast
    Frenzy = Spell(272790),
    BeastCleaveBuff = Spell(268877),
    BestialWrath = Spell(19574),
    CobraShot = Spell(193455),
    ClearFocus = Spell(255647), --LightsJudgment
    SetFocus = Spell(68992), --Darkflight
    PetAttack = Spell(107079), --QuakingPalm
	KillShot = Spell(53351),
    KillCommand = Spell(34026),
    ResonatingArrow = Spell(308491),
    Multishot = Spell(2643),
    AMurderofCrows = Spell(131894),
    AnimalCompanion = Spell(267116),
    AspectoftheBeast = Spell(191384),
    Barrage = Spell(120360),
	FortitudeoftheBear = Spell(388035),
	FortitudeoftheBearz = Spell(291944), --regeneration
    BindingShot = Spell(109248),
    ChimaeraShot = Spell(53209),
    WailingArrow = Spell(392060),
    ArcaneTorrent = Spell(80483),
    CalloftheWild = Spell(359844),
    CalloftheWildz = Spell(69070), --rocket jump
    WailingArrowz = Spell(274738), --ancestral call
    WildCall = Spell(185789),
	AutoShotz = Spell(255654),--bull rush
    WildInstincts = Spell(378442),
    KillerInstinct = Spell(273887),
    OnewiththePack = Spell(199528),
    Savagery = Spell(424557),
    ScentofBlood = Spell(193532),
    ScatterShot = Spell(213691),
    SpittingCobra = Spell(194407),
    Stampede = Spell(201430),
    ThrilloftheHunt = Spell(257944),
    VenomousBite = Spell(257891),
	Trinkz = Spell(265221),
	StunGrenadeBuff = Spell(165534),
    AspectoftheTurtle = Spell(186265),
    Exhilaration = Spell(109304),
    AspectoftheCheetah = Spell(186257),
    CounterShot = Spell(147362),
    CounterShotz = Spell(256948), --spatial rift 
    TranqShot = Spell(19801),
    Disengage = Spell(781),
    FreezingTrap = Spell(187650),
    FreezingTrapz = Spell(265221), --fireblood
    FeignDeath = Spell(5384),
    TarTrap = Spell(187698),
    ConcusiveShot = Spell(5116),
    Intimidation = Spell(19577),
	BloodBolt = Spell(288962),
	SoulShape = Spell(310143),
	foodanddrink = Spell(308433),
	AlphaPredator = Spell(269737),
	Flare = Spell(1543),
	KillCleave = Spell(378207),
	DeathChakram = Spell(375891),
	Potion = Spell(176108),
}
local S = RubimRH.Spell[253]

if not Item.Hunter then Item.Hunter = {}; end

Item.Hunter.BeastMastery = {
tx1 = Item(118330),
tx2 = Item(114616),
healingpoticon = Item(169451)
};
local I = Item.Hunter.BeastMastery;

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

local function PetActive()
	local petActive = false

    if Pet:Exists() then
        petActive = true
    end

    if Pet:IsActive() then
        petActive = true
    end

    if Pet:IsDeadOrGhost() then
        petActive = false
    end

    return petActive
end

local function CleaveCount()
	local cleave_counter = 0
     
        for i=1,40 do
			local unitID = "nameplate" .. i
            if UnitExists("nameplate"..i) then           
                local nameplate_guid = UnitGUID("nameplate"..i) 
                local npc_id = select(6, strsplit("-",nameplate_guid))
                if npc_id ~='120651' and npc_id ~='161895' then
                    if UnitCanAttack("player",unitID) and IsActionInRange(37,unitID) and UnitHealthMax(unitID) > 5
					and UnitName(unitID) ~= "Incorporeal Being"	then
                        cleave_counter = cleave_counter + 1
                    end                    
                end
            end
        end
    
    return cleave_counter
end

local function FocusinRange(range_check)
	if range_check then
		if IsActionInRange(range_check,"focus") then
			return true
		else
			return false
		end
	else
		return false	
	end
end

local function APL()
--------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------Functions/Top priorities----------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
if Focus:Exists() and not FocusinRange(38) then
	return S.ClearFocus:Cast()
end

if Player:IsCasting() or Player:IsChanneling() or (IsCurrentAction(13) or IsCurrentAction(14)) then
	return 0, "Interface\\Addons\\Rubim-RH\\Media\\channel.tga"
elseif Player:IsDeadOrGhost() or AuraUtil.FindAuraByName("Drink", "player") or AuraUtil.FindAuraByName("Food", "player") or AuraUtil.FindAuraByName("Food & Drink", "player") or AuraUtil.FindAuraByName("Feign Death", "player")
or AuraUtil.FindAuraByName("Aspect of the Turtle", "player") then
	return 0, "Interface\\Addons\\Rubim-RH\\Media\\mount2.tga"
end 

local tolerance = select(4, GetNetStats())/1000 + 0.3

local name, text, texture, startTimeMS, endTimeMS, isTradeSkill, castID, notInterruptible, spellId = UnitCastingInfo("target")
local nameFOCUS, textFOCUS, textureFOCUS, startTimeMSFOCUS, endTimeMSFOCUS, isTradeSkillFOCUS, castIDFOCUS, notInterruptibleFOCUS, spellIdFOCUS = UnitCastingInfo("focus")

local elite = UnitClassification("target") == "worldboss" or UnitClassification("target") == "rareelite" or UnitClassification("target") == "elite" or UnitClassification("target") == "rare" or target_is_dummy() or Target:IsAPlayer()

--CHANGE TO 12 WHEN NOT USING BLOODLETTING CONDUIT
local BarbRechargeTime = 12 / (1 + GetHaste('player')/100)

local start, duration, enabled = GetSpellCooldown(388035);

local FortoftheBearCD = duration - (GetTime() - start)

if FortoftheBearCD < 0 then FortoftheBearCD = 0 end

local start, duration, enabled = GetSpellCooldown(90361);

local SpiritMendCD = duration - (GetTime() - start)

if SpiritMendCD < 0 then SpiritMendCD = 0 end

local start, duration, enabled = GetSpellCooldown(61684);

local DashCD = duration - (GetTime() - start)

if DashCD < 0 then DashCD = 0 end

local trinket1 = GetInventoryItemID("player", 13)

local trinket2 = GetInventoryItemID("player", 14)

local start, duration, enabled = GetItemCooldown(trinket1);

local trinket1_cd = duration - (GetTime() - start)

if trinket1_cd < 0 then trinket1_cd = 0 end

local start, duration, enabled = GetItemCooldown(trinket2);

local trinket2_cd = duration - (GetTime() - start)

if trinket2_cd < 0 then trinket2_cd = 0 end

local trinket1ready = IsUsableItem(trinket1) and trinket1_cd <= Player:GCDRemains() + tolerance and IsEquippedItem(trinket1)

local trinket2ready = IsUsableItem(trinket2) and trinket2_cd <= Player:GCDRemains() + tolerance and IsEquippedItem(trinket2)

--print("FRENZY: ", Pet:BuffRemains(S.Frenzy),"   GCD: ",Player:GCD())
--print(math.abs(Pet:BuffRemains(S.Frenzy) - Player:BuffRemainsP(S.BeastCleaveBuff)))
--------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------Out of Combat---------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
-- if not Player:AffectingCombat() then
-- 	if S.MendPet:IsCastable() and Pet:IsActive() and Cache.EnemiesCount[25] == 0 and Pet:HealthPercentage() > 0 and Pet:HealthPercentage() <= 85 and not Pet:Buff(S.MendPet) then
-- 		return S.MendPet:Cast() 
-- 	end
-- end
--------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------Spell Queue-----------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
if (not RubimRH.queuedSpell[1]:CooldownUp() and (S.BestialWrath:ID() ~= RubimRH.queuedSpell[1]:ID() or S.BestialWrath:CooldownRemainsP() > (12 + Player:GCD()) * S.BarbedShot:ChargesP()))
or (S.BestialWrath:ID() == RubimRH.queuedSpell[1]:ID() and not Player:CanAttack(Target)) 
or (S.WailingArrow:ID() == RubimRH.queuedSpell[1]:ID() and Player:IsMoving())
or (S.HuntersMark:ID() == RubimRH.queuedSpell[1]:ID() and Target:Debuff(S.HuntersMark))
or (S.Multishot:ID() == RubimRH.queuedSpell[1]:ID() and not TargetinRange(nil,"Auto Shot"))
or (S.ScatterShot:ID() == RubimRH.queuedSpell[1]:ID() and not TargetinRange(30)) or not Player:AffectingCombat() then
	RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
end

if S.FreezingTrap:ID() == RubimRH.queuedSpell[1]:ID() then
	return S.FreezingTrapz:Cast()
end

if S.CalloftheWild:ID() == RubimRH.queuedSpell[1]:ID() then
	return S.CalloftheWildz:Cast()
end

if RubimRH.QueuedSpell():IsReadyQueue() 
and S.BestialWrath:ID() ~= RubimRH.queuedSpell[1]:ID() 
and S.DeathChakram:ID() ~= RubimRH.queuedSpell[1]:ID()
and S.Multishot:ID()    ~= RubimRH.queuedSpell[1]:ID()
and S.HuntersMark:ID()  ~= RubimRH.queuedSpell[1]:ID() 
and S.FreezingTrap:ID() ~= RubimRH.queuedSpell[1]:ID() 
and S.WailingArrow:ID() ~= RubimRH.queuedSpell[1]:ID() then
    return RubimRH.QueuedSpell():Cast()
end

if S.BestialWrath:IsCastableQueue() and Player:AffectingCombat() and Pet:IsActive() and Player:CanAttack(Target) and TargetinRange(nil,"Auto Shot") and (S.BestialWrath:ID() == RubimRH.queuedSpell[1]:ID() or RubimRH.CDsON()) 
and (CleaveCount() == 1 or Player:BuffRemainsP(S.BeastCleaveBuff) > Player:GCD() * 1.25) and (S.BarbedShot:ChargesFractional() < 1 or not S.ScentofBlood:IsAvailable()) then
	return S.BestialWrath:Cast()
end
--------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------Interrupts & Tranq-----------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
if S.CounterShot:IsReadyQueue() and RubimRH.InterruptsON() then
	if TargetinRange(nil,"Auto Shot") and notInterruptible == false and Target:CastPercentage() > math.random(37,81) and Target:AffectingCombat() then
		return S.CounterShot:Cast()
	elseif FocusinRange(38) and notInterruptibleFOCUS == false and Focus:CastPercentage() > math.random(37,81) and Focus:AffectingCombat() then
		return S.CounterShotz:Cast()
	end
end

if S.TranqShot:IsReadyQueue() and TargetinRange(nil,"Auto Shot") and RubimRH.InterruptsON() and select(4, UnitAura("target", 1)) == "magic" and Target:AffectingCombat() 
and (Pet:BuffRemains(S.Frenzy) - Player:GCD() > tolerance or not Pet:BuffP(S.Frenzy)) and (not AuraUtil.FindAuraByName("Enrage", "target")
or (AuraUtil.FindAuraByName("Enrage", "target") and notInterruptible == false and S.CounterShot:IsReadyQueue() and TargetinRange(nil,"Auto Shot")))	then
	return S.TranqShot:Cast()
end
------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------Cooldowns-------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
-- if IsSpellKnown(90361, true) and SpiritMendCD == 0 and IsActionInRange(39,"player") and Player:HealthPercentage() <= 85 then
	-- return S.SpiritMendz:Cast()
-- end

if IsSpellKnown(388035, true) and FortoftheBearCD == 0 and Player:HealthPercentage() <= 30 then
	return S.FortitudeoftheBearz:Cast()
end

if Player:HealthPercentage() <= 25 and Player:AffectingCombat() and IsUsableItem(191380) and GetItemCooldown(191380) == 0 and GetItemCount(191380) >= 1 and (not Player:InArena() and not Player:InBattlegrounds()) then
    return I.healingpoticon:Cast()
end
--print(GetSpellBaseCooldown(217200))
--------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------Rotation--------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
if not IsAutoRepeatAction(38) and IsSpellInRange('Auto Shot', 'target') == 1 and Target:AffectingCombat() then
	return S.AutoShotz:Cast()
end

if (Player:AffectingCombat() or (IsAutoRepeatAction(38) and Target:AffectingCombat())) and Pet:IsActive() and Player:CanAttack(Target) and TargetinRange(nil,"Auto Shot") then
	if not Focus:Exists() and TargetinRange(nil,"Auto Shot") and elite then
		return S.SetFocus:Cast()
	end

	if IsSpellKnown(61684, true) and DashCD == 0 and not IsActionInRange(37,"target") and S.KillCommand:TimeSinceLastCast() > Player:GCD() then
		return S.Dashz:Cast()
	end

    if trinket1ready and Player:BuffRemains(S.CalloftheWild) > 10 then
        return I.tx1:Cast()
    end
	
	if TargetinRange(nil,"Auto Shot") and RubimRH.CDsON() and IsUsableItem(191382) and GetItemCooldown(191382) == 0 and GetItemCount(191382) >= 1 and not Player:InArena() and not Player:InBattlegrounds() and Player:BuffRemains(S.CalloftheWild) > 15 and not AuraUtil.FindAuraByName("Elemental Potion of Ultimate Power", "player") then
		return S.Potion:Cast()
	end

    -- if trinket2ready and TargetinRange(nil,"Auto Shot") and elite and TargetTTD() > 7 and (GetItemCooldown(trinket1) > 20 or S.CalloftheWild:CooldownRemains() > 20) then
        -- return I.tx2:Cast()
    -- end

	if CleaveCount() >= 2 and RubimRH.AoEON() then
		if S.BarbedShot:IsReadyQueue() and Pet:Buff(S.Frenzy) and Pet:BuffRemains(S.Frenzy) - Player:GCD() < tolerance then
			if AutoSpreadTarget() then
				if AutoSpreadTarget() == "Party1target" and IsActionInRange(37,"Party1target") and UnitHealth("Party1target") > UnitHealth("target") * 0.8 and UnitGUID("Party1target") ~= UnitGUID("focus") and ((UnitHealth("Party1target") / UnitHealthMax("Party1target")) * 100) < 100 then
					return S.BarbedShotP1:Cast()
				elseif AutoSpreadTarget() == "Party2target" and IsActionInRange(37,"Party2target") and UnitHealth("Party2target") > UnitHealth("target") * 0.8 and UnitGUID("Party2target") ~= UnitGUID("focus") and ((UnitHealth("Party2target") / UnitHealthMax("Party2target")) * 100) < 100 then
					return S.BarbedShotP2:Cast()
				elseif AutoSpreadTarget() == "Party3target" and IsActionInRange(37,"Party3target") and UnitHealth("Party3target") > UnitHealth("target") * 0.8 and UnitGUID("Party3target") ~= UnitGUID("focus") and ((UnitHealth("Party3target") / UnitHealthMax("Party3target")) * 100) < 100 then
					return S.BarbedShotP3:Cast()
				elseif AutoSpreadTarget() == "Party4target" and IsActionInRange(37,"Party4target") and UnitHealth("Party4target") > UnitHealth("target") * 0.8 and UnitGUID("Party4target") ~= UnitGUID("focus") and ((UnitHealth("Party4target") / UnitHealthMax("Party4target")) * 100) < 100 then
					return S.BarbedShotP4:Cast()
				end
			end
			if FocusinRange(38) and Focus:DebuffRemains(S.BarbedShot) < Target:DebuffRemains(S.BarbedShot) and (Focus:AffectingCombat() or target_is_dummy()) then
				return S.BarbedShotFocus:Cast()
			end
			if TargetinRange(nil,"Auto Shot") and (not Target:Debuff(S.BarbedShot) or Target:DebuffRemains(S.BarbedShot) < Focus:DebuffRemains(S.BarbedShot) or not Focus:Exists() or Target:GUID() == Focus:GUID()) then
				return S.BarbedShot:Cast()
			end
		end

		if Pet:Buff(S.Frenzy) and S.BarbedShot:CooldownRemainsP() + 0.15 < Pet:BuffRemains(S.Frenzy) and Pet:BuffRemains(S.Frenzy) <= Player:GCD() + tolerance then
			return 0, "Interface\\Addons\\Rubim-RH\\Media\\mount2.tga"
		end
		
		if RubimRH.QueuedSpell():IsReadyQueue() and TargetinRange(nil,"Auto Shot") and S.Multishot:ID() == RubimRH.queuedSpell[1]:ID() or S.HuntersMark:ID() == RubimRH.queuedSpell[1]:ID()or S.WailingArrow:ID() == RubimRH.queuedSpell[1]:ID() then
			return RubimRH.QueuedSpell():Cast()
		end

		-- if S.Exhilaration:IsCastable() and Player:AffectingCombat() and Player:HealthPercentage() <= 15 then
			-- return S.Exhilaration:Cast()
		-- end

		if S.Multishot:IsReadyQueue() and Player:BuffRemains(S.CalloftheWild) <= Player:GCD() and Player:BuffRemainsP(S.BeastCleaveBuff) <= Player:GCD() then
			return S.Multishot:Cast()
		end
		--and KCRange()
		if S.KillCommand:IsReadyQueue() and not (S.BestialWrath:CooldownUp() or (not RubimRH.CDsON() and not S.BestialWrath:ID() == RubimRH.queuedSpell[1]:ID()))
		and S.KillCommand:FullRechargeTimeP() <= Player:GCD() and S.AlphaPredator:IsAvailable() and S.KillCleave:IsAvailable() and Player:BuffP(S.BeastCleaveBuff) then
			return S.KillCommand:Cast()
		end
		
		if S.BarbedShot:IsReadyQueue() and (S.BarbedShot:FullRechargeTimeP() < Player:GCD()
		or (S.ScentofBlood:IsAvailable() and (RubimRH.CDsON() or S.BestialWrath:ID() == RubimRH.queuedSpell[1]:ID()) and S.BestialWrath:CooldownRemainsP() <= (12 + Player:GCD()) * S.BarbedShot:ChargesP())
		or (BarbRechargeTime < 8 + 2 * num(S.Savagery:IsAvailable()))) then
			if AutoSpreadTarget() then
				if AutoSpreadTarget() == "Party1target" and IsActionInRange(37,"Party1target") and UnitHealth("Party1target") > UnitHealth("target") * 0.8 and UnitGUID("Party1target") ~= UnitGUID("focus") and ((UnitHealth("Party1target") / UnitHealthMax("Party1target")) * 100) < 100 then
					return S.BarbedShotP1:Cast()
				elseif AutoSpreadTarget() == "Party2target" and IsActionInRange(37,"Party2target") and UnitHealth("Party2target") > UnitHealth("target") * 0.8 and UnitGUID("Party2target") ~= UnitGUID("focus") and ((UnitHealth("Party2target") / UnitHealthMax("Party2target")) * 100) < 100 then
					return S.BarbedShotP2:Cast()
				elseif AutoSpreadTarget() == "Party3target" and IsActionInRange(37,"Party3target") and UnitHealth("Party3target") > UnitHealth("target") * 0.8 and UnitGUID("Party3target") ~= UnitGUID("focus") and ((UnitHealth("Party3target") / UnitHealthMax("Party3target")) * 100) < 100 then
					return S.BarbedShotP3:Cast()
				elseif AutoSpreadTarget() == "Party4target" and IsActionInRange(37,"Party4target") and UnitHealth("Party4target") > UnitHealth("target") * 0.8 and UnitGUID("Party4target") ~= UnitGUID("focus") and ((UnitHealth("Party4target") / UnitHealthMax("Party4target")) * 100) < 100 then
					return S.BarbedShotP4:Cast()
				end
			end
			if FocusinRange(38) and Focus:DebuffRemains(S.BarbedShot) < Target:DebuffRemains(S.BarbedShot) and (Focus:AffectingCombat() or target_is_dummy()) then
				return S.BarbedShotFocus:Cast()
			end
			if TargetinRange(nil,"Auto Shot") and (not Target:Debuff(S.BarbedShot) or Target:DebuffRemains(S.BarbedShot) < Focus:DebuffRemains(S.BarbedShot) or not Focus:Exists() or Target:GUID() == Focus:GUID()) then
				return S.BarbedShot:Cast()
			end
		end

		if S.DeathChakram:IsReady() and (RubimRH.CDsON() or Player:BuffRemains(S.CalloftheWild) > 10) and (elite or S.DeathChakram:ID() == RubimRH.queuedSpell[1]:ID()) then
			return S.DeathChakram:Cast()
		end

		if S.Bloodshed:IsReadyQueue() and RubimRH.CDsON() then
			return S.Bloodshed:Cast()
		end

		if S.BestialWrath:IsCastableQueue() and (RubimRH.CDsON() or S.BestialWrath:ID() == RubimRH.queuedSpell[1]:ID()) then
			return S.BestialWrath:Cast()
		end
		--and KCRange()
		if S.KillCommand:IsReadyQueue() then
			return S.KillCommand:Cast()
		end
		
		if S.KillShot:IsReadyQueue() then
			return S.KillShot:Cast()
		end
		
		if S.DireBeast:IsReadyQueue() and RubimRH.CDsON() then
			return S.DireBeast:Cast()
		end
		
		if S.CobraShot:IsReadyQueue() and Player:FocusTimeToMaxPredicted() < Player:GCD() * 2 then
			return S.CobraShot:Cast()
		end
		
	elseif CleaveCount() < 2 or not RubimRH.AoEON() then
	
		if S.BarbedShot:IsReadyQueue() and ((Pet:Buff(S.Frenzy) and Pet:BuffRemains(S.Frenzy) - Player:GCD() < tolerance) or (Pet:BuffStack(S.Frenzy) < 3 and S.BestialWrath:CooldownUp() and (RubimRH.CDsON() or S.BestialWrath:ID() == RubimRH.queuedSpell[1]:ID()))) then
			if AutoSpreadTarget() then
				if AutoSpreadTarget() == "Party1target" and IsActionInRange(37,"Party1target") and UnitHealth("Party1target") > UnitHealth("target") * 0.8 and UnitGUID("Party1target") ~= UnitGUID("focus") and ((UnitHealth("Party1target") / UnitHealthMax("Party1target")) * 100) < 100 then
					return S.BarbedShotP1:Cast()
				elseif AutoSpreadTarget() == "Party2target" and IsActionInRange(37,"Party2target") and UnitHealth("Party2target") > UnitHealth("target") * 0.8 and UnitGUID("Party2target") ~= UnitGUID("focus") and ((UnitHealth("Party2target") / UnitHealthMax("Party2target")) * 100) < 100 then
					return S.BarbedShotP2:Cast()
				elseif AutoSpreadTarget() == "Party3target" and IsActionInRange(37,"Party3target") and UnitHealth("Party3target") > UnitHealth("target") * 0.8 and UnitGUID("Party3target") ~= UnitGUID("focus") and ((UnitHealth("Party3target") / UnitHealthMax("Party3target")) * 100) < 100 then
					return S.BarbedShotP3:Cast()
				elseif AutoSpreadTarget() == "Party4target" and IsActionInRange(37,"Party4target") and UnitHealth("Party4target") > UnitHealth("target") * 0.8 and UnitGUID("Party4target") ~= UnitGUID("focus") and ((UnitHealth("Party4target") / UnitHealthMax("Party4target")) * 100) < 100 then
					return S.BarbedShotP4:Cast()
				end
			end
			if FocusinRange(38) and Focus:DebuffRemains(S.BarbedShot) < Target:DebuffRemains(S.BarbedShot) and (Focus:AffectingCombat() or target_is_dummy()) then
				return S.BarbedShotFocus:Cast()
			end
			if TargetinRange(nil,"Auto Shot") and (not Target:Debuff(S.BarbedShot) or Target:DebuffRemains(S.BarbedShot) < Focus:DebuffRemains(S.BarbedShot) or not Focus:Exists() or Target:GUID() == Focus:GUID()) then
				return S.BarbedShot:Cast()
			end
		end

		if Pet:Buff(S.Frenzy) and S.BarbedShot:CooldownRemainsP() + 0.15 < Pet:BuffRemains(S.Frenzy) and Pet:BuffRemains(S.Frenzy) <= Player:GCD() + tolerance then
			return 0, "Interface\\Addons\\Rubim-RH\\Media\\mount2.tga"
		end
	
		if RubimRH.QueuedSpell():IsReadyQueue() and TargetinRange(nil,"Auto Shot") and S.Multishot:ID() == RubimRH.queuedSpell[1]:ID() or S.HuntersMark:ID() == RubimRH.queuedSpell[1]:ID() or S.WailingArrow:ID() == RubimRH.queuedSpell[1]:ID() then
			return RubimRH.QueuedSpell():Cast()
		end
	
		-- if S.Exhilaration:IsCastable() and Player:AffectingCombat() and Player:HealthPercentage() <= 15 then
			-- return S.Exhilaration:Cast()
		-- end
		--and KCRange()
		if S.KillCommand:IsReadyQueue() and not (S.BestialWrath:CooldownUp() or (not RubimRH.CDsON() and not S.BestialWrath:ID() == RubimRH.queuedSpell[1]:ID()))
		and S.KillCommand:FullRechargeTimeP() <= Player:GCD() and S.AlphaPredator:IsAvailable() then
			return S.KillCommand:Cast()
		end
	
		if S.DeathChakram:IsReady() and (RubimRH.CDsON() or Player:BuffRemains(S.CalloftheWild) > 10) and (elite or S.DeathChakram:ID() == RubimRH.queuedSpell[1]:ID()) then
			return S.DeathChakram:Cast()
		end
	
		if S.Bloodshed:IsReadyQueue() and RubimRH.CDsON() then
			return S.Bloodshed:Cast()
		end
	
		if S.BestialWrath:IsCastableQueue() and (RubimRH.CDsON() or S.BestialWrath:ID() == RubimRH.queuedSpell[1]:ID()) then
			return S.BestialWrath:Cast()
		end
		--and KCRange()
		if S.KillCommand:IsReadyQueue() then
			return S.KillCommand:Cast()
		end

		if S.BarbedShot:IsReadyQueue() and ((S.WildInstincts:IsAvailable() and Player:BuffP(S.CalloftheWild)) or S.BarbedShot:FullRechargeTimeP() < Player:GCD()
		or (S.ScentofBlood:IsAvailable() and S.BestialWrath:CooldownRemainsP() <= (12 + Player:GCD()) * S.BarbedShot:ChargesP() and (RubimRH.CDsON() or S.BestialWrath:ID() == RubimRH.queuedSpell[1]:ID()))
		or ((BarbRechargeTime < 8 + 2 * num(S.Savagery:IsAvailable())))) then
			if AutoSpreadTarget() then
				if AutoSpreadTarget() == "Party1target" and IsActionInRange(37,"Party1target") and UnitHealth("Party1target") > UnitHealth("target") * 0.8 and UnitGUID("Party1target") ~= UnitGUID("focus") and ((UnitHealth("Party1target") / UnitHealthMax("Party1target")) * 100) < 100 then
					return S.BarbedShotP1:Cast()
				elseif AutoSpreadTarget() == "Party2target" and IsActionInRange(37,"Party2target") and UnitHealth("Party2target") > UnitHealth("target") * 0.8 and UnitGUID("Party2target") ~= UnitGUID("focus") and ((UnitHealth("Party2target") / UnitHealthMax("Party2target")) * 100) < 100 then
					return S.BarbedShotP2:Cast()
				elseif AutoSpreadTarget() == "Party3target" and IsActionInRange(37,"Party3target") and UnitHealth("Party3target") > UnitHealth("target") * 0.8 and UnitGUID("Party3target") ~= UnitGUID("focus") and ((UnitHealth("Party3target") / UnitHealthMax("Party3target")) * 100) < 100 then
					return S.BarbedShotP3:Cast()
				elseif AutoSpreadTarget() == "Party4target" and IsActionInRange(37,"Party4target") and UnitHealth("Party4target") > UnitHealth("target") * 0.8 and UnitGUID("Party4target") ~= UnitGUID("focus") and ((UnitHealth("Party4target") / UnitHealthMax("Party4target")) * 100) < 100 then
					return S.BarbedShotP4:Cast()
				end
			end
			if FocusinRange(38) and Focus:DebuffRemains(S.BarbedShot) < Target:DebuffRemains(S.BarbedShot) and (Focus:AffectingCombat() or target_is_dummy()) then
				return S.BarbedShotFocus:Cast()
			end
			if TargetinRange(nil,"Auto Shot") and (not Target:Debuff(S.BarbedShot) or Target:DebuffRemains(S.BarbedShot) < Focus:DebuffRemains(S.BarbedShot) or not Focus:Exists() or Target:GUID() == Focus:GUID()) then
				return S.BarbedShot:Cast()
			end
		end

		if S.DireBeast:IsReadyQueue() and RubimRH.CDsON() then
			return S.DireBeast:Cast()
		end

		if S.KillShot:IsReadyQueue() then
			return S.KillShot:Cast()
		end

		if S.CobraShot:IsReadyQueue() and (Player:Focus() - S.CobraShot:Cost() + Player:FocusRegen() * (S.KillCommand:CooldownRemainsP() - 1) > S.KillCommand:Cost() or S.KillCommand:CooldownRemainsP() > 1 + Player:GCD()) or Player:BuffP(S.BestialWrath) then
			return S.CobraShot:Cast()
		end	
		
		-- if S.CobraShot:IsReadyQueue(39) then
			-- return S.CobraShot:Cast()
		-- end	
	end
	-- if not UnitIsUnit("target", "pettarget") then
		-- return S.PetAttack:Cast()
	-- end
end
    return 0, "Interface\\Addons\\Rubim-RH\\Media\\mount2.tga"
end

RubimRH.Rotation.SetAPL(253, APL);

local function PASSIVE()

end

RubimRH.Rotation.SetPASSIVE(253, PASSIVE);