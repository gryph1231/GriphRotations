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

-- Spells
RubimRH.Spell[104] = {
Quake = Spell(240447),
Prowl = Spell(5215),
Pull = Spell(8921),
TravelForm = Spell(783),
Moonfire = Spell(8921),
MoonfireDebuff = Spell(164812),
Swipe = Spell(213771),
GalacticGuardianBuff = Spell(213708),
Thrash = Spell(77758),
ThrashDebuff = Spell(192090),
ToothandClaw = Spell(135286),
Raze = Spell(400254),
Razez = Spell(287712), --haymaker
Mangle = Spell(33917),
Maul = Spell(6807),
Ironfur = Spell(192081),
FrenziedRegeneration = Spell(22842),
ThornsofIron = Spell(400222),
ReinforcedFur = Spell(393618),
HeartoftheWild = Spell(319454),
Barkskin = Spell(22812),
BearForm = Spell(5487),
Incarnation = Spell(102558),
Berserking = Spell(26297),
Berserk = Spell(106951),
GoreBuff = Spell(93622),
Dash = Spell(1850),
Regrowth = Spell(8936),
RegrowthMouseover = Spell(291944), --regeneratin
ViciousCycleMangleBuff = Spell(372019),
ViciousCycleMaulBuff = Spell(372015),
SouloftheForest = Spell(158477),
DreamOfCenarius = Spell(372152),
Maul = Spell(6807),
SurvivalInstincts = Spell(61336),
RageoftheSleeper = Spell(200851),
Renewal = Spell(108238),	
Soothe = Spell(2908),
SkullBash = Spell(106839),
NaturesVigil = Spell(124974),
CatForm = Spell(768),
MarkOfTheWild = Spell(1126),
Hibernate = Spell(2637),
EntanglingRoots = Spell(339),
Typhoon = Spell(132469),
Typhoonz = Spell(20549), --war stomp
StampedingRoar = Spell(77764),
StampedingRoarz = Spell(68992), --darkflight
Vortex = Spell(102793),
Growl = Spell(6795),
autoattack = Spell(255654),
};

local S = RubimRH.Spell[104];
local G = RubimRH.Spell[1];

--S.Raze.TextureSpellID = { 258082 } --Icy Claws

-- Items
if not Item.Druid then
    Item.Druid = {}
end

Item.Druid.Guardian = {
    tx1 = Item(118330),
    tx2 = Item(114616),
    HPIcon = Item(169451),
};

local I = Item.Druid.Guardian;

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


local function TargetinRange(range_check)
	if range_check then
		if IsActionInRange(range_check,"target") then
			return true
		else
			return false
		end
	else
		return false	
	end
end

local function RangeCount(range_check,checkinteractdistance)
	local range_counter = 0
		
		if range_check and not checkinteractdistance then
			for i=1,40 do
				local unitID = "nameplate" .. i
				if UnitExists("nameplate"..i) then           
					local nameplate_guid = UnitGUID("nameplate"..i) 
					local npc_id = select(6, strsplit("-",nameplate_guid))
					if npc_id ~='120651' and npc_id ~='161895' then
						if UnitCanAttack("player",unitID) and IsActionInRange(range_check,unitID) and UnitHealthMax(unitID) > 5
						and UnitName(unitID) ~= "Incorporeal Being" then
							range_counter = range_counter + 1
						end                    
					end
				end
			end
		elseif not range_check and checkinteractdistance then
			for i=1,40 do
				local unitID = "nameplate" .. i
				if UnitExists("nameplate"..i) then           
					local nameplate_guid = UnitGUID("nameplate"..i) 
					local npc_id = select(6, strsplit("-",nameplate_guid))
					if npc_id ~='120651' and npc_id ~='161895' then
						if UnitCanAttack("player",unitID) and CheckInteractDistance(unitID, checkinteractdistance) and UnitHealthMax(unitID) > 5
						and UnitName(unitID) ~= "Incorporeal Being" then
							range_counter = range_counter + 1
						end                    
					end
				end
			end
		else
			range_counter = 0
		end
	
	return range_counter
end

local function Bear()
	-- if S.Moonfire:IsReady(40) and Target:DebuffRefreshableP(S.MoonfireDebuff, 4) then
		-- return S.Moonfire:Cast()
	-- end

	if S.Thrash:IsReadyMorph(10) and (Target:DebuffRefreshableP(S.ThrashDebuff, 3.39) or Target:DebuffStackP(S.ThrashDebuff) < 5) then
		return S.Thrash:Cast()	
	end

	if S.Incarnation:IsReady(10) and RubimRH.CDsON() then
		return S.Incarnation:Cast()
	end

	if S.Berserking:IsReady(10) and RubimRH.CDsON() and bs_inc then
		return S.Berserking:Cast()
	end

	--maul,if=(buff.rage_of_the_sleeper.up&buff.tooth_and_claw.stack>0&active_enemies<=6&!talent.raze.enabled&variable.If_build=0)|(buff.rage_of_the_sleeper.up&buff.tooth_and_claw.stack>0&active_enemies=1&talent.raze.enabled&variable.If_build=0)
	if S.Maul:IsReady(10) and ((Player:BuffP(S.RageoftheSleeper) and Player:BuffStackP(S.ToothandClaw) > 0 and RangeCount(37) <= 6 and not S.Raze:IsAvailable() and not VarIFBuild) or (Player:BuffP(S.RageoftheSleeper) and Player:BuffStackP(S.ToothandClaw) > 0 and RangeCount(37) == 1 and S.Raze:IsAvailable() and not VarIFBuild)) then
		return S.Maul:Cast()
	end

	--raze,if=buff.rage_of_the_sleeper.up&buff.tooth_and_claw.stack>0&variable.If_build=0&active_enemies>1
	if S.Raze:IsReady(10) and Player:BuffP(S.RageoftheSleeper) and Player:BuffStackP(S.ToothandClaw) > 0 and not VarIFBuild and RangeCount(37) > 1 then
		return S.Razez:Cast()	
	end

	--maul,if=(((buff.incarnation.up|buff.berserk_bear.up)&active_enemies<=5&!talent.raze.enabled&(buff.tooth_and_claw.stack>=1))&variable.If_build=0)|(((buff.incarnation.up|buff.berserk_bear.up)&active_enemies=1&talent.raze.enabled&(buff.tooth_and_claw.stack>=1))&variable.If_build=0)
	if S.Maul:IsReady(10) and (((bs_inc and RangeCount(37) <= 5 and not S.Raze:IsAvailable() and (Player:BuffStackP(S.ToothandClaw) >= 1)) and not VarIFBuild) or ((bs_inc and RangeCount(37) == 1 and S.Raze:IsAvailable() and (Player:BuffStackP(S.ToothandClaw) >= 1)) and not VarIFBuild)) then
		return S.Maul:Cast()
	end

	--raze,if=(buff.incarnation.up|buff.berserk_bear.up)&(variable.If_build=0)&active_enemies>1
	if S.Raze:IsReady(10) and bs_inc and not VarIFBuild and RangeCount(37) > 1 then
		return S.Razez:Cast()	
	end

	--ironfur,target_if=!debuff.tooth_and_claw_debuff.up,if=!buff.ironfur.up&rage>50&!cooldown.pause_action.remains&variable.If_build=0&!buff.rage_of_the_sleeper.up|rage>90&variable.If_build=0&!buff.rage_of_the_sleeper.up
	if S.Ironfur:IsReady(15) and not Player:BuffP(S.ToothandClaw) and not Player:BuffP(S.Ironfur) and Player:Rage() > 50 and not VarIFBuild and not Player:BuffP(S.RageoftheSleeper) or Player:Rage() > 90 and not VarIFBuild and not Player:BuffP(S.RageoftheSleeper) then
		return S.Ironfur:Cast()
	end

	--ironfur,if=rage>90&variable.If_build=1|(buff.incarnation.up|buff.berserk_bear.up)&rage>20&variable.If_build=1
	if S.Ironfur:IsReady(15) and (Player:Rage() > 90 and VarIFBuild or bs_inc and Player:Rage() > 20 and VarIFBuild) then
		return S.Ironfur:Cast()
	end

	--raze,if=(buff.tooth_and_claw.up)&active_enemies>1
	if S.Raze:IsReady(10) and Player:BuffP(S.ToothandClaw) and RangeCount(37) > 1 then
		return S.Razez:Cast()	
	end

	--raze,if=(variable.If_build=0)&active_enemies>1
	if S.Raze:IsReady(10) and not VarIFBuild and RangeCount(37) > 1 then
		return S.Razez:Cast()	
	end

	--mangle,if=buff.gore.up&active_enemies<11|buff.vicious_cycle_mangle.stack=3
	if S.Mangle:IsReady(10) and (Player:BuffP(S.GoreBuff) and RangeCount(37) < 11 or Player:BuffStackP(S.ViciousCycleMangleBuff) == 3) then
		return S.Mangle:Cast()
	end

	--maul,if=(buff.tooth_and_claw.up&active_enemies<=5&!talent.raze.enabled)|(buff.tooth_and_claw.up&active_enemies=1&talent.raze.enabled)
	if S.Maul:IsReady(10) and ((Player:BuffP(S.ToothandClaw) and RangeCount(37) <= 5 and not S.Raze:IsAvailable()) or (Player:BuffP(S.ToothandClaw) and RangeCount(37) == 1 and S.Raze:IsAvailable())) then
		return S.Maul:Cast()
	end

	--maul,if=(active_enemies<=5&!talent.raze.enabled&variable.If_build=0)|(active_enemies=1&talent.raze.enabled&variable.If_build=0)
	if S.Maul:IsReady(10) and ((RangeCount(37) <= 5 and not S.Raze:IsAvailable() and not VarIFBuild) or (RangeCount(37) == 1 and S.Raze:IsAvailable() and not VarIFBuild)) then
		return S.Maul:Cast()
	end

	--thrash_bear,target_if=active_enemies>=5
	if S.Thrash:IsReadyMorph(10) and RangeCount(37) >= 5 then
		return S.Thrash:Cast()	
	end

	--swipe,if=buff.incarnation_guardian_of_ursoc.down&buff.berserk_bear.down&active_enemies>=11
	if S.Swipe:IsReadyMorph(10) and not bs_inc and RangeCount(37) >= 11 then
		return S.Swipe:Cast()	
	end

	--mangle,if=(buff.incarnation.up&active_enemies<=4)|(buff.incarnation.up&talent.soul_of_the_forest.enabled&active_enemies<=5)|((rage<90)&active_enemies<11)|((rage<85)&active_enemies<11&talent.soul_of_the_forest.enabled)
	if S.Mangle:IsReady(10) and ((bs_inc and RangeCount(37) <= 4) or (bs_inc and S.SouloftheForest:IsAvailable() and RangeCount(37) <= 5) or (Player:Rage() < 90 and RangeCount(37) < 11) or (Player:Rage() < 85 and RangeCount(37) < 11 and S.SouloftheForest:IsAvailable())) then
		return S.Mangle:Cast()
	end

	if S.Thrash:IsReadyMorph(10) and RangeCount(37) >= 1 then
		return S.Thrash:Cast()	
	end

	if S.Swipe:IsReadyMorph(10) and RangeCount(37) >= 1 then
		return S.Swipe:Cast()	
	end

	return nil
end

local function Mitigation()
	if S.Regrowth:IsCastable() and Player:Buff(S.DreamOfCenarius) and  Player:BuffRemains(S.DreamOfCenarius) < 10 and HPpercentloss > 0 and Player:HealthPercentage() < 70 then
		return S.Regrowth:Cast()
	end

	if S.RageoftheSleeper:IsCastable() and ((HPpercentloss > 7 and Player:HealthPercentage() < 75
	and (not Player:BuffP(S.SurvivalInstincts) and not Player:BuffP(S.Barkskin) or HPpercentloss > 21))
	or in_trouble)	then
		return S.RageoftheSleeper:Cast()
	end
	
	if S.Barkskin:IsCastable() and ((HPpercentloss > 7 and Player:HealthPercentage() < 70
	and (not Player:BuffP(S.RageoftheSleeper) and not Player:BuffP(S.SurvivalInstincts) or HPpercentloss > 21))
	or in_trouble) then
		return S.Barkskin:Cast()
	end

	if S.SurvivalInstincts:IsCastable() and ((HPpercentloss > 18 and Player:HealthPercentage() < 50
	and (not Player:BuffP(S.RageoftheSleeper) and not Player:BuffP(S.Barkskin) or HPpercentloss > 36))
	or in_trouble) then
		return S.SurvivalInstincts:Cast()
	end

	if S.NaturesVigil:IsCastable() and HPpercentloss > 0 and Player:HealthPercentage() < 35 then
		return S.NaturesVigil:Cast()
	end

	if S.FrenziedRegeneration:IsCastable() and not Player:BuffP(S.FrenziedRegeneration)
	and ((HPpercentloss > 0 and Player:HealthPercentage() < 55) or (bs_inc and Player:HealthPercentage() < 90)) then
		return S.FrenziedRegeneration:Cast()
	end

	if S.Regrowth:IsCastable() and Player:Buff(S.DreamOfCenarius) and Player:BuffRemains(S.DreamOfCenarius) >= 10 and Player:HealthPercentage() < 70 and (HPpercentloss > 0 and Player:HealthPercentage() < 35
	and not Player:BuffP(S.FrenziedRegeneration) or HPpercentloss > 3) then
		return S.Regrowth:Cast()
	end

	if S.Renewal:IsCastable() and Player:HealthPercentage() < 70 and (HPpercentloss > 0 and Player:HealthPercentage() < 35
	and not Player:BuffP(S.FrenziedRegeneration) or HPpercentloss > 3) then
		return S.Renewal:Cast()
	end

	if Player:HealthPercentage() < 25 and HPpercentloss > 0 and (IsUsableItem(191379) or IsUsableItem(191378) or IsUsableItem(191380)) and (GetItemCooldown(191380) == 0 or GetItemCooldown(191379) == 0 or GetItemCooldown(191378) == 0) and (GetItemCount(191380) >= 1 or GetItemCount(191379) >= 1 or GetItemCount(191378) >= 1) and (not Player:InArena() and not Player:InBattlegrounds()) then
		return I.HPIcon:Cast()
	end

	return nil
end

local function APL()
RangeCount()
TargetinRange()
--------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------Functions/Top priorities----------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
if Player:IsCasting() or Player:IsChanneling() then
	return 0, "Interface\\Addons\\Rubim-RH\\Media\\channel.tga"
elseif Player:IsDeadOrGhost() or AuraUtil.FindAuraByName("Drink", "player") or AuraUtil.FindAuraByName("Food", "player") 
or AuraUtil.FindAuraByName("Food & Drink", "player") or (IsStealthed() and AuraUtil.FindAuraByName("Mark of the Wild", "player")) or Player:Buff(S.TravelForm) then
	return 0, "Interface\\Addons\\Rubim-RH\\Media\\mount2.tga"
end 
--print(Player:IsTankingAoE(37))
if true then
	bs_inc = Player:BuffP(S.Berserk) or Player:BuffP(S.Incarnation)
	
	HPpercentloss = MyHealthTracker.GetPredictedHealthLoss() * 3
	
	elite = UnitClassification("target") == "worldboss" or UnitClassification("target") == "rareelite" or UnitClassification("target") == "elite" or UnitClassification("target") == "rare" or target_is_dummy() or Target:IsAPlayer()
	
	in_trouble = HPpercentloss > 0 and Player:HealthPercentage() < 20
	
	--VarIFBuild = (S.ThornsofIron:IsAvailable() and S.ReinforcedFur:IsAvailable())
	--VarIFBuild = S.ThornsofIron:IsAvailable()
	VarIFBuild = (S.ThornsofIron:IsAvailable() and S.ReinforcedFur:IsAvailable()) 
	or (Player:HealthPercentage() < 85 and HPpercentloss > 0 and RangeCount(38) >= 1)
	or (HPpercentloss > 5 and RangeCount(38) >= 1)
	
	trinket1 = GetInventoryItemID("player", 13)
	
	trinket2 = GetInventoryItemID("player", 14)
	
	trinket1ready = IsUsableItem(trinket1) and GetItemCooldown(trinket1) == 0 and IsEquippedItem(trinket1)
	
	trinket2ready = IsUsableItem(trinket2) and GetItemCooldown(trinket2) == 0 and IsEquippedItem(trinket2)
	
	name, realm = UnitName('target')

	name1, text, texture, startTimeMS, endTimeMS, isTradeSkill, castID, notInterruptible, spellId = UnitCastingInfo("target")
	
	start_time_cast_ms = select(4, UnitCastingInfo('target')) or 0
	
	end_time_cast_ms = select(5, UnitCastingInfo('target')) or 0
	
	current_time_ms = GetTime() * 1000
	
	elapsed_time_cast_ca = (start_time_cast_ms > 0) and (current_time_ms - start_time_cast_ms) or 0
	
	cast_time = elapsed_time_cast_ca / 1000
	
	cast_time_remaining = ((end_time_cast_ms - start_time_cast_ms) / 1000) - cast_time > 0 and ((end_time_cast_ms - start_time_cast_ms) / 1000) - cast_time or 9999
	
	start_time_channel_ms = select(4, UnitChannelInfo('target')) or 0
	
	end_time_channel_ms = select(5, UnitChannelInfo('target')) or 0
	
	elapsed_time_channel_ch = (start_time_channel_ms > 0) and (current_time_ms - start_time_channel_ms) or 0
	
	channel_time = elapsed_time_channel_ch / 1000
	
	channel_time_remaining = ((end_time_channel_ms - start_time_channel_ms) / 1000) - channel_time > 0 and ((end_time_channel_ms - start_time_channel_ms) / 1000) - channel_time or 9999
end
--------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------Out of Combat---------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
if not Player:AffectingCombat() then
	-- if S.MarkOfTheWild:IsCastable() and (not AuraUtil.FindAuraByName("Mark of the Wild", "player")
	-- or (AuraUtil.FindAuraByName("Mark of the Wild", "player") and Player:BuffRemains(S.MarkOfTheWild) < 300)) then
		-- return S.MarkOfTheWild:Cast()
    -- end
end
--------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------Spell Queue-----------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
if not RubimRH.queuedSpell[1]:CooldownUp() or IsStealthed()
or (not Player:AffectingCombat() and not S.Pull:ID() == RubimRH.queuedSpell[1]:ID())
or (S.CatForm:ID() == RubimRH.queuedSpell[1]:ID() and Player:BuffP(S.CatForm))
or (S.BearForm:ID() == RubimRH.queuedSpell[1]:ID() and Player:BuffP(S.BearForm))
or (S.EntanglingRoots:ID() == RubimRH.queuedSpell[1]:ID() and Player:PrevGCD(1, S.EntanglingRoots))
or (S.Pull:ID() == RubimRH.queuedSpell[1]:ID() and (not Player:CanAttack(Target) or not TargetinRange(39)))
or (S.Hibernate:ID() == RubimRH.queuedSpell[1]:ID() and (Player:PrevGCD(1, S.Hibernate) or IsKeyDown('RightButton')))
or (S.Pull:ID() == RubimRH.queuedSpell[1]:ID() and TargetinRange(37) and IsCurrentSpell(6603)) then
	RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
end

if S.Regrowth:ID() == RubimRH.queuedSpell[1]:ID() and Player:Buff(S.DreamOfCenarius) then
	if UnitExists("mouseover") and UnitIsFriend("mouseover","player") and IsSpellInRange("regrowth", "mouseover") then
		return S.RegrowthMouseover:Cast()
	elseif Player:HealthPercentage() < 100 then
		return S.Regrowth:Cast()
	else
		RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
	end
elseif S.Regrowth:ID() == RubimRH.queuedSpell[1]:ID() then
	RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
end

if S.Pull:ID() == RubimRH.queuedSpell[1]:ID() and Player:CanAttack(Target) then
	if TargetinRange(37) then
		if not IsCurrentSpell(6603) and not IsStealthed() then
			return S.autoattack:Cast()
		end
	elseif S.Moonfire:IsReady(40) and not TargetinRange(37) then 
		return S.Moonfire:Cast()
	end
end

if S.Typhoon:ID() == RubimRH.queuedSpell[1]:ID() then
	return S.Typhoonz:Cast()
end

if S.StampedingRoar:ID() == RubimRH.queuedSpell[1]:ID() then
	return S.StampedingRoarz:Cast()
end

if RubimRH.QueuedSpell():IsReadyQueue() and S.Regrowth:ID() ~= RubimRH.queuedSpell[1]:ID() then
    return RubimRH.QueuedSpell():Cast()
end
--------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------Interrupts & Tranq-----------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
if RubimRH.InterruptsON() and not IsStealthed() then 
	if S.Hibernate:IsReady(40) and notInterruptible == false and cast_time > 0 and name == "Incorporeal Being" then
		return S.Hibernate:Cast()
	end
	
	if S.SkullBash:IsReady(5) and notInterruptible == false and (cast_time > Player:GCDRemains() + 0.47 or channel_time > Player:GCDRemains() + 0.47) then
		return S.SkullBash:Cast()
	end

	if S.Soothe:IsReady(40) and (Player:HealthPercentage() > 45 or HPpercentloss < 5) and select(4, UnitAura("target", 1)) == "" then
		return S.Soothe:Cast()
	end
end
--------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------Cooldowns-------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
if RubimRH.CDsON() and Player:CanAttack(Target) then
	if trinket1ready and RangeCount(37) >= 1 then
		return I.tx1:Cast()
	end
end
--------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------Rotation--------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
if Player:CanAttack(Target) and TargetinRange(38) then
	if S.BearForm:IsCastable() and not Player:BuffP(S.BearForm) and not Player:BuffP(S.CatForm) then
		return S.BearForm:Cast()
	end

	if not IsCurrentSpell(6603) and not IsStealthed() then
		return S.autoattack:Cast()
	end
end

-- if HL.CombatTime() < Player:GCD() * 2 and RangeCount(37) > 1 and not target_is_dummy() and IsResting("player") == false then
-- 	if S.Thrash:IsCastableMorph() then
-- 		return S.Thrash:Cast()
-- 	elseif S.Swipe:IsCastableMorph() then
-- 		return S.Swipe:Cast()
-- 	end
-- end

if not Player:IsTankingAoE(37) and RangeCount(37) > 1 and not target_is_dummy() and IsResting("player") == false and not Target:IsAPlayer() and not in_trouble then
	if S.Thrash:IsCastableMorph() then
		return S.Thrash:Cast()
	elseif S.Swipe:IsCastableMorph() then
		return S.Swipe:Cast()
	end
end

if Player:AffectingCombat() then
	if Mitigation() and RangeCount(38) >= 1 then
		return Mitigation()
	end
	
	if Bear() and Player:CanAttack(Target) then
		return Bear()
	end
end
    return 0, "Interface\\Addons\\Rubim-RH\\Media\\mount2.tga"
end

RubimRH.Rotation.SetAPL(104, APL)

local function PASSIVE()


end
RubimRH.Rotation.SetPASSIVE(104, PASSIVE)