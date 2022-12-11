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
RubimRH.Spell[270] = {
	Vivify = Spell(116670),
	VivifyPlayer = Spell(28880), --gift of naaru
	VivifyP1 = Spell(260364), --arcane pulse
	VivifyP2 = Spell(312411), --bag of tricks
	VivifyP3 = Spell(256948), --spatial rift
	VivifyP4 = Spell(107079), --quaking palm
	InstantVivify = Spell(392883),
	EssenceFont = Spell(191837),
	EssenceFontBuff = Spell(191840),
	AncientTeachings = Spell(388026),
	RenewingMist = Spell(115151),
	RenewingMistPlayer = Spell(287712), --haymaker
	RenewingMistP1 = Spell(291944), --regeneration
	RenewingMistP2 = Spell(274738), --ancestral call
	RenewingMistP3 = Spell(265221), --fireblood
	RenewingMistP4 = Spell(20589), --escape artist
	HealingElixir = Spell(122281),
	DiffuseMagic = Spell(122783),
	DiffuseMagicz = Spell(115546), --provoke
	FaelineStomp = Spell(388193),
	FaelineStompBuff = Spell(389391),
	LegSweep = Spell(119381),
	RisingSunKick = Spell(107428),
	SpinningCraneKick = Spell(101546),
	LifeCocoon = Spell(116849),
	LifeCocoonPlayer = Spell(312924), --hyper organic
	LifeCocoonP1 = Spell(59752), --perception
	LifeCocoonP2 = Spell(125355), --healing sphere
	LifeCocoonP3 = Spell(227344), --surging mist
	LifeCocoonP4 = Spell(233759), --grapple weapon
	ChiJi = Spell(325197),
	RingofPeace = Spell(116844),
	TouchofDeath = Spell(322109),
	TigerPalm = Spell(100780),
	ChiWave = Spell(115098),
	EnvelopingMist = Spell(124682),
	EnvelopingMistPlayer = Spell(20549), --warstomp
	EnvelopingMistP1 = Spell(26297), --berserking
	EnvelopingMistP2 = Spell(155145), --arcane torrent
	EnvelopingMistP3 = Spell(20572), --bloodfury
	EnvelopingMistP4 = Spell(20594), --stoneform
	EnvelopingMistInvoke = Spell(343820),
	TeachingsoftheMastery = Spell(202090),
	BlackoutKick = Spell(100784),
	Revival = Spell(115310),
	ThunderTea = Spell(116680),
	DampenHarm = Spell(122278),
	DampenHarmz = Spell(116841), --tigers lust
	Detox = Spell(115450),
	DetoxPlayer = Spell(101643), --transcendence
	DetoxP1 = Spell(119996), --transcendence transfer
	DetoxP2 = Spell(58984), --shadowmeld
	DetoxP3 = Spell(243435), --fortifying brew
	DetoxP4 = Spell(197908), --mana tea
	SpearHandStrike = Spell(116705),
	SpearHandStrikez = Spell(115178), --resuscitate
	BonedustBrew = Spell(386276),
	BonedustBrewz = Spell(209584), --zen focus tea
	HealingPot = Spell(115072), --expel harm
	SoothingMist = Spell(115175),
	
--Detox List
	--Azure Vault
		--ErraticGrowth 
		--Waking Bane
		--Dragon Strike
	--Ruby Life Pools
		--Stormslam
	--Neltharus
	--Bracken Hollow
		--Withering
		--Withering Poison
		--Withering Contagion
	--Nokhud Offensive
		--Energy Surge(target)
		--Conductive Strike
		--Frightful Roar
	--Uldaman
		--Diseased Bite
		--Burning Heat(target)
	--Halls of Infusion
		--Binding Winds
		--Frost Shock
		--Waterlogged
	--Algeth'ar Academy
}

local S = RubimRH.Spell[270]

if not Item.Monk then Item.Monk = {}; end

Item.Monk.Mistweaver = {

};

local I = Item.Monk.MistWeaver;

local function RenewingMistCycle()
local RenewingMistCheck = 0
     
        for i=1,40 do
			local unitID = LowestAlly("ALL", "UnitID")
            if UnitExists(unitID) and UnitHealth('player') < UnitHealthMax('player') and not AuraUtil.FindAuraByName("Renewing Mist",unitID,"PLAYER|HELPFUL") then
				RenewingMistCheck = unitID
			else
				RenewingMistCheck = 777
			end
        end
		
		if RenewingMistCheck == 777 then
			if UnitExists('player') and UnitHealth('player') < UnitHealthMax('player') and not AuraUtil.FindAuraByName("Renewing Mist",'player',"PLAYER|HELPFUL") then
				RenewingMistCheck = 'player'
			elseif UnitExists('party1') and UnitHealth('party1') < UnitHealthMax('party1') and not AuraUtil.FindAuraByName("Renewing Mist",'party1',"PLAYER|HELPFUL") then
				RenewingMistCheck = 'party1'
			elseif UnitExists('party2') and UnitHealth('party2') < UnitHealthMax('party2') and not AuraUtil.FindAuraByName("Renewing Mist",'party2',"PLAYER|HELPFUL") then
				RenewingMistCheck = 'party2'
			elseif UnitExists('party3') and UnitHealth('party3') < UnitHealthMax('party3') and not AuraUtil.FindAuraByName("Renewing Mist",'party3',"PLAYER|HELPFUL") then
				RenewingMistCheck = 'party3'
			elseif UnitExists('party4') and UnitHealth('party4') < UnitHealthMax('party4') and not AuraUtil.FindAuraByName("Renewing Mist",'party4',"PLAYER|HELPFUL") then
				RenewingMistCheck = 'party4'
			end
		end
    
	if RenewingMistCheck ~= 0 and RenewingMistCheck ~= 777 then
		return RenewingMistCheck
	end
end

local function EnvelopingMistCycle()
local EnvelopingMistCheck = 0
     
        for i=1,40 do
			local unitID = LowestAlly("ALL", "UnitID")
            if UnitExists(unitID) and UnitHealth('player') < UnitHealthMax('player') and not AuraUtil.FindAuraByName("Enveloping Mist",unitID,"PLAYER|HELPFUL") then
				EnvelopingMistCheck = unitID
			else
				EnvelopingMistCheck = 777
			end
        end
		
		if EnvelopingMistCheck == 777 then
			if UnitExists('player') and UnitHealth('player') < UnitHealthMax('player') and not AuraUtil.FindAuraByName("Enveloping Mist",'player',"PLAYER|HELPFUL") then
				EnvelopingMistCheck = 'player'
			elseif UnitExists('party1') and UnitHealth('party1') < UnitHealthMax('party1') and not AuraUtil.FindAuraByName("Enveloping Mist",'party1',"PLAYER|HELPFUL") then
				EnvelopingMistCheck = 'party1'
			elseif UnitExists('party2') and UnitHealth('party2') < UnitHealthMax('party2') and not AuraUtil.FindAuraByName("Enveloping Mist",'party2',"PLAYER|HELPFUL") then
				EnvelopingMistCheck = 'party2'
			elseif UnitExists('party3') and UnitHealth('party3') < UnitHealthMax('party3') and not AuraUtil.FindAuraByName("Enveloping Mist",'party3',"PLAYER|HELPFUL") then
				EnvelopingMistCheck = 'party3'
			elseif UnitExists('party4') and UnitHealth('party4') < UnitHealthMax('party4') and not AuraUtil.FindAuraByName("Enveloping Mist",'party4',"PLAYER|HELPFUL") then
				EnvelopingMistCheck = 'party4'
			end
		end
    
	if EnvelopingMistCheck ~= 0 and EnvelopingMistCheck ~= 777 then
		return EnvelopingMistCheck
	end
end

function IsDummy(NPCID)

	if NPCID then
		GUID = UnitGUID(NPCID)
		if GUID then
			local Type, _, _, _, _, UnitIDzFromGUID = strsplit('-', GUID)
			UnitIDz = tonumber(UnitIDzFromGUID)
		end
	end
	
	if GUID and (UnitIDz == 31146 or UnitIDz == 31144 or UnitIDz == 32666 or UnitIDz == 32667 or UnitIDz == 46647 or UnitIDz == 114832 or UnitIDz == 153292
	or UnitIDz == 67127 or UnitIDz == 87317 or UnitIDz == 87318 or UnitIDz == 87320 or UnitIDz == 88314 or UnitIDz == 88316 or UnitIDz == 87760
	or UnitIDz == 29310 or UnitIDz == 29308 or UnitIDz == 27483 or UnitIDz == 26632 or UnitIDz == 26630 or UnitIDz == 31134 or UnitIDz == 29266 
	or UnitIDz == 87761 or UnitIDz == 87762 or UnitIDz == 88288 or UnitIDz == 88289 or UnitIDz == 113964 or UnitIDz == 113966 or UnitIDz == 103397
	or UnitIDz == 103404 or UnitIDz == 103402 or UnitIDz == 107555 or UnitIDz == 107556 or UnitIDz == 92164 or UnitIDz == 92165 or UnitIDz == 92166
	or UnitIDz == 101956 or UnitIDz == 102045 or UnitIDz == 102048 or UnitIDz == 102052 or UnitIDz == 144081 or UnitIDz == 144082 or UnitIDz == 144085 
	or UnitIDz == 144086 or UnitIDz == 126781 or UnitIDz == 131983 or UnitIDz == 131989 or UnitIDz == 131992 or UnitIDz == 154564 or UnitIDz == 154567
	or UnitIDz == 154580 or UnitIDz == 154583 or UnitIDz == 154585 or UnitIDz == 154586 or UnitIDz == 160325 or UnitIDz == 173942 or UnitIDz == 175449
	or UnitIDz == 175450 or UnitIDz == 175451 or UnitIDz == 175452 or UnitIDz == 175455 or UnitIDz == 175456 or UnitIDz == 175462 or UnitIDz == 174565
	or UnitIDz == 174566 or UnitIDz == 174567 or UnitIDz == 174568 or UnitIDz == 174569 or UnitIDz == 174570 or UnitIDz == 174571 or UnitIDz == 174484
	or UnitIDz == 174487 or UnitIDz == 174488 or UnitIDz == 174491 or UnitIDz == 65310) then
		return true
	else
		return false
	end

end

local function allMobsinRange(range)
local totalRange40 = 0
local allMobsinRange = false

	for id = 1, 40 do
		local unitID = "nameplate" .. id
		local x = UnitName(unitID)
			if x then
				name = x:sub(-5)
			end
		if UnitCanAttack("player",unitID) and (UnitAffectingCombat(unitID) or IsDummy(unitID)) and UnitHealthMax(unitID) > 5 then
			totalRange40 = totalRange40 + 1
		end
    end

	if range == totalRange40 and totalRange40 >= 1 then
		allMobsinRange = true
	else
		allMobsinRange = false
	end

	return allMobsinRange
	
end

-- local function CanDetox()
	-- for i=1,40 do 
		-- local DebuffTypePlayer = select(5, UnitDebuff("player", i))
		-- local DebuffTypeP1 = select(5, UnitDebuff("party1", i))
		-- local DebuffTypeP2 = select(5, UnitDebuff("party2", i))
		-- local DebuffTypeP3 = select(5, UnitDebuff("party3", i))
		-- local DebuffTypeP4 = select(5, UnitDebuff("party4", i))
		
		-- if DebuffTypePlayer == "Magic" or DebuffType == "Disease" or DebuffType == "Poison" then
			-- target = 'player'
		-- elseif DebuffTypeP1 == "Magic" or DebuffType == "Disease" or DebuffType == "Poison" then
			-- target = 'party1'
		-- elseif DebuffTypeP2 == "Magic" or DebuffType == "Disease" or DebuffType == "Poison" then
			-- target = 'party2'
		-- elseif DebuffTypeP3 == "Magic" or DebuffType == "Disease" or DebuffType == "Poison" then
			-- target = 'party3'
		-- elseif DebuffTypeP3 == "Magic" or DebuffType == "Disease" or DebuffType == "Poison" then
			-- target = 'party4'
		-- end
	-- end

	-- return target
-- end

local function APL()
RenewingMistCycle()
EnvelopingMistCycle()
IsDummy()
allMobsinRange()
HL.GetEnemies(8, true);
HL.GetEnemies(10, true);
--------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------Functions/Top priorities----------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
if Player:IsCasting() or (Player:IsChanneling() and (not Player:BuffP(S.EssenceFontBuff) or not Player:IsChanneling(S.EssenceFont))) then
	return 0, "Interface\\Addons\\Rubim-RH\\Media\\channel.tga"
elseif Player:IsDeadOrGhost() or AuraUtil.FindAuraByName("Drink", "player") or AuraUtil.FindAuraByName("Food", "player") or AuraUtil.FindAuraByName("Food & Drink", "player") then
	return 0, "Interface\\Addons\\Rubim-RH\\Media\\mount2.tga"
end 

local name, text, texture, startTimeMS, endTimeMS, isTradeSkill, castID, notInterruptible, spellId = UnitCastingInfo("target")
inInstance, instanceType = IsInInstance()
local Mana = UnitPower("Player", 0)
tarSpeed,_,_,_ = GetUnitSpeed('target')
--------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------Out of Combat---------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
if not Player:AffectingCombat() and not Player:IsChanneling(S.EssenceFont) and not IsResting() then
	if GroupedBelow(85) >= 3 then
		if S.EssenceFont:IsCastable() then
			return S.EssenceFont:Cast()	
		end
	
		if S.ChiWave:IsCastable() then
			return S.ChiWave:Cast()	
		end
	end


	if LowestAlly("ALL", "HP") <= 85 then
		if S.Vivify:IsCastable() and Mana >= 9500 and Player:BuffP(S.InstantVivify) then
			if LowestAlly("ALL", "UnitID") == "player" and UnitExists("player") and not UnitIsDeadOrGhost("player") then
				return S.VivifyPlayer:Cast()
			end
			if LowestAlly("ALL", "UnitID") == "party1" and UnitExists("party1") and not UnitIsDeadOrGhost("party1") then
				return S.VivifyP1:Cast()
			end
			if LowestAlly("ALL", "UnitID") == "party2" and UnitExists("party2") and not UnitIsDeadOrGhost("party2") then
				return S.VivifyP2:Cast()
			end
			if LowestAlly("ALL", "UnitID") == "party3" and UnitExists("party3") and not UnitIsDeadOrGhost("party3") then
				return S.VivifyP3:Cast()
			end
			if LowestAlly("ALL", "UnitID") == "party4" and UnitExists("party4") and not UnitIsDeadOrGhost("party4") then
				return S.VivifyP4:Cast()
			end
		end
	end

	if LowestAlly("ALL", "HP") <= 75 then
		if S.EnvelopingMist:IsCastable() and not Player:IsMoving() and Mana >= 12000 then
			if EnvelopingMistCycle() == "player" and not AuraUtil.FindAuraByName("Enveloping Mist",'player',"PLAYER|HELPFUL")
			and UnitExists("player") and not UnitIsDeadOrGhost("player") then
				return S.EnvelopingMistPlayer:Cast()
			end
			if EnvelopingMistCycle() == "party1" and not AuraUtil.FindAuraByName("Enveloping Mist",'party1',"PLAYER|HELPFUL")
			and UnitExists("party1") and not UnitIsDeadOrGhost("party1") then
				return S.EnvelopingMistP1:Cast()
			end
			if EnvelopingMistCycle() == "party2" and not AuraUtil.FindAuraByName("Enveloping Mist",'party2',"PLAYER|HELPFUL")
			and UnitExists("party2") and not UnitIsDeadOrGhost("party2") then
				return S.EnvelopingMistP2:Cast()
			end
			if EnvelopingMistCycle() == "party3" and not AuraUtil.FindAuraByName("Enveloping Mist",'party3',"PLAYER|HELPFUL")
			and UnitExists("party3") and not UnitIsDeadOrGhost("party3") then
				return S.EnvelopingMistP3:Cast()
			end
			if EnvelopingMistCycle() == "party4" and not AuraUtil.FindAuraByName("Enveloping Mist",'party4',"PLAYER|HELPFUL")
			and UnitExists("party4") and not UnitIsDeadOrGhost("party4") then
				return S.EnvelopingMistP4:Cast()
			end
		end
	end

	if LowestAlly("ALL", "HP") < 100 and RenewingMistCycle() ~= nil then
		if S.RenewingMist:IsCastable() and Mana >= 4500 then
			if RenewingMistCycle() == "player" and UnitExists("player") and not UnitIsDeadOrGhost("player") then
				return S.RenewingMistPlayer:Cast()
			end
			if RenewingMistCycle() == "party1" and UnitExists("party1") and not UnitIsDeadOrGhost("party1") then
				return S.RenewingMistP1:Cast()
			end
			if RenewingMistCycle() == "party2" and UnitExists("party2") and not UnitIsDeadOrGhost("party2") then
				return S.RenewingMistP2:Cast()
			end
			if RenewingMistCycle() == "party3" and UnitExists("party3") and not UnitIsDeadOrGhost("party3") then
				return S.RenewingMistP3:Cast()
			end
			if RenewingMistCycle() == "party4" and UnitExists("party4") and not UnitIsDeadOrGhost("party4") then
				return S.RenewingMistP4:Cast()
			end
		end
	end

end
--------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------Spell Queue-----------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
if not RubimRH.queuedSpell[1]:CooldownUp() or not Player:AffectingCombat() then
	RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
end

if S.FaelineStomp:ID() == RubimRH.queuedSpell[1]:ID() then
	return S.FaelineStomp:Cast()
end

if S.RingofPeace:ID() == RubimRH.queuedSpell[1]:ID() then
	return S.RingofPeace:Cast()
end

if S.Revival:ID() == RubimRH.queuedSpell[1]:ID() then
	return S.Revival:Cast()
end

if S.ChiJi:ID() == RubimRH.queuedSpell[1]:ID() then
	return S.ChiJi:Cast()
end

if S.Detox:ID() == RubimRH.queuedSpell[1]:ID() then
	return S.Detox:Cast()
end

if S.LegSweep:ID() == RubimRH.queuedSpell[1]:ID() then
	return S.LegSweep:Cast()
end
--------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------Interrupts & Tranq-----------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
if RubimRH.InterruptsON() then
	if S.SpearHandStrike:IsReady(8) and notInterruptible == false and Target:CastPercentage() > math.random(43,87) and Target:AffectingCombat() then
		return S.SpearHandStrikez:Cast()
	end

	if S.Detox:IsCastable() and Mana >= 3250 and LowestAlly("ALL", "HP") >= 35 then
		if Player:CanAttack(Target) and IsSpellInRange("Detox", "target")
		and (AuraUtil.FindAuraByName("Energy Surge","target","HELPFUL")) then
			return S.Detox:Cast()
		end
		
		if UnitExists("player") and not UnitIsDeadOrGhost("player") and IsSpellInRange("Detox", "player")
		and (AuraUtil.FindAuraByName("Erratic Growth","player","HARMFUL") or AuraUtil.FindAuraByName("Waking Bane","player","HARMFUL") or AuraUtil.FindAuraByName("Dazzle","player","HARMFUL") 
		or AuraUtil.FindAuraByName("Stormslam","player","HARMFUL") or AuraUtil.FindAuraByName("Withering","player","HARMFUL") or AuraUtil.FindAuraByName("Conductive Strike","player","HARMFUL")
		or AuraUtil.FindAuraByName("Frightful Roar","HARMFUL") or AuraUtil.FindAuraByName("Diseased Bite","player","HARMFUL") or AuraUtil.FindAuraByName("Binding Winds","player","HARMFUL")
		or AuraUtil.FindAuraByName("Frost Shock","player","HARMFUL") or AuraUtil.FindAuraByName("Waterlogged","player","HARMFUL") or AuraUtil.FindAuraByName("Creeping Mold","player","HARMFUL")
		or AuraUtil.FindAuraByName("Withering Poison","player","HARMFUL") or AuraUtil.FindAuraByName("Withering Contagion","player","HARMFUL") or AuraUtil.FindAuraByName("Forbidden Knowledge","player","HARMFUL")
		or AuraUtil.FindAuraByName("Crystalline Rupture","player","HARMFUL") or AuraUtil.FindAuraByName("Monotonous Lecture","player","HARMFUL")) then
			return S.DetoxPlayer:Cast()
		end
		if UnitExists("party1") and not UnitIsDeadOrGhost("party1") and IsSpellInRange("Detox", "party1")
		and (AuraUtil.FindAuraByName("Erratic Growth","party1","HARMFUL") or AuraUtil.FindAuraByName("Waking Bane","party1","HARMFUL") or AuraUtil.FindAuraByName("Dazzle","party1","HARMFUL") 
		or AuraUtil.FindAuraByName("Stormslam","party1","HARMFUL") or AuraUtil.FindAuraByName("Withering","party1","HARMFUL") or AuraUtil.FindAuraByName("Conductive Strike","party1","HARMFUL")
		or AuraUtil.FindAuraByName("Frightful Roar","party1","HARMFUL") or AuraUtil.FindAuraByName("Diseased Bite","party1","HARMFUL") or AuraUtil.FindAuraByName("Binding Winds","party1","HARMFUL")
		or AuraUtil.FindAuraByName("Frost Shock","party1","HARMFUL") or AuraUtil.FindAuraByName("Waterlogged","party1","HARMFUL") or AuraUtil.FindAuraByName("Creeping Mold","party1","HARMFUL")
		or AuraUtil.FindAuraByName("Withering Poison","party1","HARMFUL") or AuraUtil.FindAuraByName("Withering Contagion","party1","HARMFUL") or AuraUtil.FindAuraByName("Forbidden Knowledge","party1","HARMFUL")
		or AuraUtil.FindAuraByName("Crystalline Rupture","party1","HARMFUL") or AuraUtil.FindAuraByName("Monotonous Lecture","party1","HARMFUL")) then
			return S.DetoxP1:Cast()
		end
		if UnitExists("party2") and not UnitIsDeadOrGhost("party2") and IsSpellInRange("Detox", "party2")
		and (AuraUtil.FindAuraByName("Erratic Growth","party2","HARMFUL") or AuraUtil.FindAuraByName("Waking Bane","party2","HARMFUL") or AuraUtil.FindAuraByName("Dazzle","party2","HARMFUL") 
		or AuraUtil.FindAuraByName("Stormslam","party2","HARMFUL") or AuraUtil.FindAuraByName("Withering","party2","HARMFUL") or AuraUtil.FindAuraByName("Conductive Strike","party2","HARMFUL")
		or AuraUtil.FindAuraByName("Frightful Roar","party2","HARMFUL") or AuraUtil.FindAuraByName("Diseased Bite","party2","HARMFUL") or AuraUtil.FindAuraByName("Binding Winds","party2","HARMFUL")
		or AuraUtil.FindAuraByName("Frost Shock","party2","HARMFUL") or AuraUtil.FindAuraByName("Waterlogged","party2","HARMFUL") or AuraUtil.FindAuraByName("Creeping Mold","party2","HARMFUL")
		or AuraUtil.FindAuraByName("Withering Poison","party2","HARMFUL") or AuraUtil.FindAuraByName("Withering Contagion","party2","HARMFUL") or AuraUtil.FindAuraByName("Forbidden Knowledge","party2","HARMFUL")
		or AuraUtil.FindAuraByName("Crystalline Rupture","party2","HARMFUL") or AuraUtil.FindAuraByName("Monotonous Lecture","party2","HARMFUL")) then
			return S.DetoxP2:Cast()
		end
		if UnitExists("party3") and not UnitIsDeadOrGhost("party3") and IsSpellInRange("Detox", "party3")
		and (AuraUtil.FindAuraByName("Erratic Growth","party3","HARMFUL") or AuraUtil.FindAuraByName("Waking Bane","party3","HARMFUL") or AuraUtil.FindAuraByName("Dazzle","party3","HARMFUL") 
		or AuraUtil.FindAuraByName("Stormslam","party3","HARMFUL") or AuraUtil.FindAuraByName("Withering","party3","HARMFUL") or AuraUtil.FindAuraByName("Conductive Strike","party3","HARMFUL")
		or AuraUtil.FindAuraByName("Frightful Roar","party3","HARMFUL") or AuraUtil.FindAuraByName("Diseased Bite","party3","HARMFUL") or AuraUtil.FindAuraByName("Binding Winds","party3","HARMFUL")
		or AuraUtil.FindAuraByName("Frost Shock","party3","HARMFUL") or AuraUtil.FindAuraByName("Waterlogged","party3","HARMFUL") or AuraUtil.FindAuraByName("Creeping Mold","party3","HARMFUL")
		or AuraUtil.FindAuraByName("Withering Poison","party3","HARMFUL") or AuraUtil.FindAuraByName("Withering Contagion","party3","HARMFUL") or AuraUtil.FindAuraByName("Forbidden Knowledge","party3","HARMFUL")
		or AuraUtil.FindAuraByName("Crystalline Rupture","party3","HARMFUL") or AuraUtil.FindAuraByName("Monotonous Lecture","party3","HARMFUL")) then
			return S.DetoxP3:Cast()
		end
		if UnitExists("party4") and not UnitIsDeadOrGhost("party4") and IsSpellInRange("Detox", "party4")
		and (AuraUtil.FindAuraByName("Erratic Growth","party4","HARMFUL") or AuraUtil.FindAuraByName("Waking Bane","party4","HARMFUL") or AuraUtil.FindAuraByName("Dazzle","party4","HARMFUL") 
		or AuraUtil.FindAuraByName("Stormslam","party4","HARMFUL") or AuraUtil.FindAuraByName("Withering","party4","HARMFUL") or AuraUtil.FindAuraByName("Conductive Strike","party4","HARMFUL")
		or AuraUtil.FindAuraByName("Frightful Roar","party4","HARMFUL") or AuraUtil.FindAuraByName("Diseased Bite","party4","HARMFUL") or AuraUtil.FindAuraByName("Binding Winds","party4","HARMFUL")
		or AuraUtil.FindAuraByName("Frost Shock","party4","HARMFUL") or AuraUtil.FindAuraByName("Waterlogged","party4","HARMFUL") or AuraUtil.FindAuraByName("Creeping Mold","party4","HARMFUL") 
		or AuraUtil.FindAuraByName("Withering Poison","party4","HARMFUL") or AuraUtil.FindAuraByName("Withering Contagion","party4","HARMFUL") or AuraUtil.FindAuraByName("Forbidden Knowledge","party4","HARMFUL")
		or AuraUtil.FindAuraByName("Crystalline Rupture","party4","HARMFUL") or AuraUtil.FindAuraByName("Monotonous Lecture","party4","HARMFUL")) then
			return S.DetoxP4:Cast()
		end
	end
end
--------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------Cooldowns-------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
if S.HealingElixir:IsCastable() and not IsCurrentSpell("122281") and Player:AffectingCombat() and Player:HealthPercentage() <= 80 then
	return S.HealingElixir:Cast()
end

if Player:HealthPercentage() <= 25 and Player:AffectingCombat() and IsUsableItem(191380) and GetItemCooldown(191380) == 0 and GetItemCount(191380) >= 1 
and (not Player:InArena() and not Player:InBattlegrounds()) then
    return S.HealingPot:Cast()
end

if S.DampenHarm:IsCastable() and Player:AffectingCombat() and Player:HealthPercentage() <= 35 then
	return S.DampenHarmz:Cast()
end

if S.DiffuseMagic:IsCastable() and Player:AffectingCombat() and Player:HealthPercentage() <= 35 then
	return S.DiffuseMagicz:Cast()
end
--------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------Rotation--------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
if LowestAlly("ALL", "HP") <= 20 and (inInstance or Player:AffectingCombat()) then
	if S.LifeCocoon:IsCastable() and Mana >= 6000 then
		if LowestAlly("ALL", "UnitID") == "player" and (not IsUsableItem(191380) or GetItemCooldown(191380) > 3 or GetItemCount(191380) == 0)
		and UnitAffectingCombat("player") and UnitExists("player") and not UnitIsDeadOrGhost("player") then
			return S.LifeCocoonPlayer:Cast()
		end
		if LowestAlly("ALL", "UnitID") == "party1" and UnitAffectingCombat("party1") and UnitExists("party1") and not UnitIsDeadOrGhost("party1") then
			return S.LifeCocoonP1:Cast()
		end
		if LowestAlly("ALL", "UnitID") == "party2" and UnitAffectingCombat("party2") and UnitExists("party2") and not UnitIsDeadOrGhost("party2") then
			return S.LifeCocoonP2:Cast()
		end
		if LowestAlly("ALL", "UnitID") == "party3" and UnitAffectingCombat("party3") and UnitExists("party3") and not UnitIsDeadOrGhost("party3") then
			return S.LifeCocoonP3:Cast()
		end
		if LowestAlly("ALL", "UnitID") == "party4" and UnitAffectingCombat("party4") and UnitExists("party4") and not UnitIsDeadOrGhost("party4") then
			return S.LifeCocoonP4:Cast()
		end
	end
end

if S.EnvelopingMist:IsCastable() and (inInstance or Player:AffectingCombat()) then
	if LowestAlly("ALL", "HP") <= 95 and Player:BuffStackP(S.EnvelopingMistInvoke) >= 3 then
		if LowestAlly("ALL", "UnitID") == "player" and UnitExists("player") and not UnitIsDeadOrGhost("player") then
			return S.EnvelopingMistPlayer:Cast()
		end
		if LowestAlly("ALL", "UnitID") == "party1" and UnitExists("party1") and not UnitIsDeadOrGhost("party1") then
			return S.EnvelopingMistP1:Cast()
		end
		if LowestAlly("ALL", "UnitID") == "party2" and UnitExists("party2") and not UnitIsDeadOrGhost("party2") then
			return S.EnvelopingMistP2:Cast()
		end
		if LowestAlly("ALL", "UnitID") == "party3" and UnitExists("party3") and not UnitIsDeadOrGhost("party3") then
			return S.EnvelopingMistP3:Cast()
		end
		if LowestAlly("ALL", "UnitID") == "party4" and UnitExists("party4") and not UnitIsDeadOrGhost("party4") then
			return S.EnvelopingMistP4:Cast()
		end
	end
end

-- if S.SpinningCraneKick:IsCastable() and Mana >= 2500 and Player:AffectingCombat() and Cache.EnemiesCount[8] >= 5 and Player:BuffP(S.FaelineStompBuff) then
	-- return S.SpinningCraneKick:Cast()
-- end

if ((LowestAlly("ALL", "HP") <= 45 and GroupedBelow(75) <= 2) or LowestAlly("ALL", "HP") <= 25) and (inInstance or Player:AffectingCombat()) then
	if S.Vivify:IsCastable() and Mana >= 9500 and Player:BuffP(S.InstantVivify) then
		if LowestAlly("ALL", "UnitID") == "player" and UnitExists("player") and not UnitIsDeadOrGhost("player") then
			return S.VivifyPlayer:Cast()
		end
		if LowestAlly("ALL", "UnitID") == "party1" and UnitExists("party1") and not UnitIsDeadOrGhost("party1") then
			return S.VivifyP1:Cast()
		end
		if LowestAlly("ALL", "UnitID") == "party2" and UnitExists("party2") and not UnitIsDeadOrGhost("party2") then
			return S.VivifyP2:Cast()
		end
		if LowestAlly("ALL", "UnitID") == "party3" and UnitExists("party3") and not UnitIsDeadOrGhost("party3") then
			return S.VivifyP3:Cast()
		end
		if LowestAlly("ALL", "UnitID") == "party4" and UnitExists("party4") and not UnitIsDeadOrGhost("party4") then
			return S.VivifyP4:Cast()
		end
	end
end

if LowestAlly("ALL", "HP") < 100 and RenewingMistCycle() ~= nil and (inInstance or Player:AffectingCombat()) then
	if S.RenewingMist:IsCastable() and Mana >= 4500 then
		if RenewingMistCycle() == "player" and UnitExists("player") and not UnitIsDeadOrGhost("player") and UnitAffectingCombat("player") then
			return S.RenewingMistPlayer:Cast()
		end
		if RenewingMistCycle() == "party1" and UnitExists("party1") and not UnitIsDeadOrGhost("party1") and UnitAffectingCombat("party1") then
			return S.RenewingMistP1:Cast()
		end
		if RenewingMistCycle() == "party2" and UnitExists("party2") and not UnitIsDeadOrGhost("party2") and UnitAffectingCombat("party2") then
			return S.RenewingMistP2:Cast()
		end
		if RenewingMistCycle() == "party3" and UnitExists("party3") and not UnitIsDeadOrGhost("party3") and UnitAffectingCombat("party3") then
			return S.RenewingMistP3:Cast()
		end
		if RenewingMistCycle() == "party4" and UnitExists("party4") and not UnitIsDeadOrGhost("party4") and UnitAffectingCombat("party4") then
			return S.RenewingMistP4:Cast()
		end
	end
end

if S.EssenceFont:IsCastable() and (LowestAlly("ALL", "HP") <= 80 or GroupedBelow(90) >= 2 or S.FaelineStomp:CooldownDown())
and Mana >= 18000 and Player:AffectingCombat() and Player:BuffRemainsP(S.AncientTeachings) <= Player:GCD() then
	return S.EssenceFont:Cast()
end

if S.RisingSunKick:IsReady(8) and Player:CanAttack(Target) and Mana >= 6250 and Player:AffectingCombat() and Player:BuffP(S.AncientTeachings) then
	if S.ThunderTea:IsCastable() and not Player:BuffP(S.ThunderTea) and (LowestAlly("ALL", "HP") <= 65 or GroupedBelow(75) >= 2) then
		return S.ThunderTea:Cast()
	end
	if S.RisingSunKick:IsReady(8) then
		return S.RisingSunKick:Cast()
	end
end

if S.BlackoutKick:IsReady(8) and Player:CanAttack(Target) and Player:AffectingCombat() and (Cache.EnemiesCount[8] >= 2 and Cache.EnemiesCount[8] <= 4 and Player:BuffP(S.FaelineStompBuff)) then
	return S.BlackoutKick:Cast()
end

if S.SpinningCraneKick:IsCastable() and Mana >= 2500 and Player:AffectingCombat() and Cache.EnemiesCount[10] >= 3
and (LowestAlly("ALL", "HP") >= 85 or Player:BuffP(S.FaelineStompBuff))	then
	return S.SpinningCraneKick:Cast()
end

if S.BlackoutKick:IsReady(8) and Player:CanAttack(Target) and Player:AffectingCombat() and Player:BuffStackP(S.TeachingsoftheMastery) >= 2 then
	return S.BlackoutKick:Cast()
end

if LowestAlly("ALL", "HP") <= 85 and (inInstance or Player:AffectingCombat()) then
	if S.Vivify:IsCastable() and Mana >= 9500 and Player:BuffP(S.InstantVivify) then
		if LowestAlly("ALL", "UnitID") == "player" and UnitExists("player") and not UnitIsDeadOrGhost("player") then
			return S.VivifyPlayer:Cast()
		end
		if LowestAlly("ALL", "UnitID") == "party1" and UnitExists("party1") and not UnitIsDeadOrGhost("party1") then
			return S.VivifyP1:Cast()
		end
		if LowestAlly("ALL", "UnitID") == "party2" and UnitExists("party2") and not UnitIsDeadOrGhost("party2") then
			return S.VivifyP2:Cast()
		end
		if LowestAlly("ALL", "UnitID") == "party3" and UnitExists("party3") and not UnitIsDeadOrGhost("party3") then
			return S.VivifyP3:Cast()
		end
		if LowestAlly("ALL", "UnitID") == "party4" and UnitExists("party4") and not UnitIsDeadOrGhost("party4") then
			return S.VivifyP4:Cast()
		end
	end
end

if S.EnvelopingMist:IsCastable() and EnvelopingMistCycle() ~= nil and (inInstance or Player:AffectingCombat()) then
    if LowestAlly("ALL", "HP") <= 50 and Cache.EnemiesCount[10] == 0 and not Player:IsMoving() then
        if EnvelopingMistCycle() == "player" and UnitExists("player") and not UnitIsDeadOrGhost("player") and UnitAffectingCombat("player") then
            return S.EnvelopingMistPlayer:Cast()
        end
        if EnvelopingMistCycle() == "party1" and UnitExists("party1") and not UnitIsDeadOrGhost("party1") and UnitAffectingCombat("party1") then
            return S.EnvelopingMistP1:Cast()
        end
        if EnvelopingMistCycle() == "party2" and UnitExists("party2") and not UnitIsDeadOrGhost("party2") and UnitAffectingCombat("party2") then
            return S.EnvelopingMistP2:Cast()
        end
        if EnvelopingMistCycle() == "party3" and UnitExists("party3") and not UnitIsDeadOrGhost("party3") and UnitAffectingCombat("party3") then
            return S.EnvelopingMistP3:Cast()
        end
        if EnvelopingMistCycle() == "party4" and UnitExists("party4") and not UnitIsDeadOrGhost("party4") and UnitAffectingCombat("party4") then
            return S.EnvelopingMistP4:Cast()
        end
    end
end

if S.TigerPalm:IsReady(8) and Player:CanAttack(Target) and Player:AffectingCombat() then
	return S.TigerPalm:Cast()
end

if S.TouchofDeath:IsReady(8) and Player:CanAttack(Target) and Player:AffectingCombat() then
	return S.TouchofDeath:Cast()
end

    return 0, "Interface\\Addons\\Rubim-RH\\Media\\mount2.tga"
end

RubimRH.Rotation.SetAPL(270, APL);

local function PASSIVE()

end

RubimRH.Rotation.SetPASSIVE(270, PASSIVE);