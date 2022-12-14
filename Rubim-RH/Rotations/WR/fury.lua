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
local MultiSpell = HL.MultiSpell;
-- Lua
local pairs = pairs;
local tableconcat = table.concat;
local tostring = tostring;
local tableinsert = table.insert;

if not Spell.Warrior then
    Spell.Warrior = {};
end



RubimRH.Spell[72] = {
BerserkerStance = Spell(386196),
  autoattack = Spell(274738), --ancestral call

  EnragedReneration = Spell(184364),
  lust1 = Spell(57724),
  lust2 = Spell(57723),
  lust3 = Spell(80354),
  lust4 = Spell(95809),
  lust5 = Spell(264689),
    lustAT = Spell(265221), -- fireblood
  execute = Spell(135358),
    -- AncestralCall                         = Spell(274738),
    ArcaneTorrent                         = Spell(50613),
    BagofTricks                           = Spell(312411),
    Berserking                            = Spell(26297),
    BloodFury                             = Spell(20572),
    -- Abilities
    BattleShout                           = Spell(6673),
    Charge                                = Spell(100),
    HeroicThrow                           = Spell(57755),
    Pummel                                = Spell(6552),
    Slam                                  = Spell(1464),
    odynsfury                             = Spell(28880),--Gift of Naru
    VictoryRush                           = Spell(34428),
    -- Talents
    Avatar                                = Spell(107574),
    BerserkerRage                         = Spell(18499),
    BloodandThunder                       = Spell(384277),
    DoubleTime                            = Spell(103827),
    FrothingBerserker                     = Spell(215571),
    IntimidatingShout                     = Spell(5246),
    HeroicLeap                            = Spell(6544),
    ImpendingVictory                      = Spell(202168),
    OverwhelmingRage                      = Spell(382767),
    RallyingCry                           = Spell(97462),
    Shockwave                             = Spell(46968),
    SonicBoom                             = Spell(390725),
    SpearofBastion                        = Spell(376079),
    SpearofBastionz                       = Spell(260364), --arcane pulse
    StormBolt                             = Spell(107570),
    ThunderousRoar                        = Spell(384318),
    TitanicThrow                          = Spell(384090),
    TitansTorment                         = Spell(390135),
    WreckingThrow                         = Spell(384110),
    TitanicRage                           = Spell(394329),
	ShatteringThrow                       = Spell(64382),
    -- Buffs
    AvatarBuff                            = Spell(107574),
    BattleShoutBuff                       = Spell(6673),
    -- Debuffs
    SpearofBastionDebuff                  = Spell(376080),
    -- Covenant Abilities (Shadowlands)
    AncientAftershock                     = Spell(325886),
    Condemn                               = MultiSpell(330325, 330334, 317485, 317349),
    CondemnDebuff                         = Spell(317491),
    ConquerorsBanner                      = Spell(324143),
    ConquerorsFrenzyBuff                  = Spell(343672),
    ElysianMightBuff                      = Spell(311193),
    Fleshcraft                            = Spell(324631),

    -- Conduits (Shadowlands)
    AshenJuggernaut                       = Spell(335232),
    AshenJuggernautBuff                   = Spell(335234),
    MercilessBonegrinder                  = Spell(335260),
    MercilessBonegrinderBuff              = Spell(346574),
    -- Pool
    Pool                                  = Spell(999910),



 -- Abilities
 Bloodbath                             = Spell(335096),
 CrushingBlow                          = Spell(335097),
 Execute                               = Spell(280735),
 Whirlwind                             = Spell(190411),
 -- Talents
 Annihilator                           = Spell(383916),
 Bloodthirst                           = Spell(23881),
 Cruelty                               = Spell(392931),
 Frenzy                                = Spell(335077),
 Massacre                              = Spell(206315),
 MeatCleaver                           = Spell(280392),
 OdynsFury                             = Spell(385059),
 Onslaught                             = Spell(315720),
 RagingBlow                            = Spell(85288),
 Rampage                               = Spell(184367),
 Ravager                               = Spell(228920),
 Ravagerz                              = Spell(265221), --fireblood
 RecklessAbandon                       = Spell(202751),
 Recklessness                          = Spell(1719),
 StormofSwords                         = Spell(388903),
 SuddenDeath                           = Spell(280721),
 Tenderize                             = Spell(388933),
 WrathandFury                          = Spell(392936),
 -- Buffs
 EnrageBuff                            = Spell(184362),
 FrenzyBuff                            = Spell(335082),
 MeatCleaverBuff                       = Spell(85739),
 RecklessnessBuff                      = Spell(1719),
 SuddenDeathBuff                       = Spell(280776),
 BitterImmunity                        = Spell(383762),
 ImprovedWhirlwindTalent               = Spell(12950),
 MeatCleaverTalent					   = Spell(280392),
 LightsJudgment = Spell(255647),
 -- Debuffs
 SiegebreakerDebuff                    = Spell(280773),
 -- Conduits (Shadowlands)
 ViciousContempt                       = Spell(337302),
 -- Legendary Effects (Shadowlands)
 WilloftheBerserkerBuff                = Spell(335594),
}

local S = RubimRH.Spell[72]

if not Item.Warrior then Item.Warrior = {}; end

Item.Warrior.Fury = {
healingpoticon = Item(169451),
tx1 = Item(118330),
tx2 = Item(114616),
HPIcon = Item(169451),
};

local I = Item.Warrior.Fury;


function HealthPotionSelected()
    local HealthPotionIDs = {
        191380, 191379, 191378
    }

    for _, HealthPotionID in ipairs(HealthPotionIDs) do
        if Item(HealthPotionID):IsUsable() then
            return Item(HealthPotionID)
        end
    end
end



local function UseItems()
local trinket1 = GetInventoryItemID("player", 13) 
local trinket2 = GetInventoryItemID("player", 14) 
local trinket1ready = IsUsableItem(trinket1) and GetItemCooldown(trinket1) == 0 and IsEquippedItem(trinket1)
local trinket2ready = IsUsableItem(trinket2) and GetItemCooldown(trinket2) == 0 and IsEquippedItem(trinket2)
        
	if trinket1ready then
		return I.tx1:Cast()      
	end
  
	if trinket2ready then
		return I.tx2:Cast()
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
	or UnitIDz == 174487 or UnitIDz == 174488 or UnitIDz == 174491 or UnitIDz == 65310 or UnitIDz == 198594 or UnitIDz == 189632) then
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

local function APL()
HL.GetEnemies(8, true);
HL.GetEnemies(10, true);
HL.GetEnemies(25, true);
HealthPotionSelected()
IsDummy()
allMobsinRange()
UseItems()
--------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------Functions/Top priorities----------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
if Player:IsCasting() or Player:IsChanneling() then
	return 0, "Interface\\Addons\\Rubim-RH\\Media\\channel.tga"
elseif Player:IsDeadOrGhost() or AuraUtil.FindAuraByName("Drink", "player") or AuraUtil.FindAuraByName("Food", "player") or AuraUtil.FindAuraByName("Food & Drink", "player") then
	return 0, "Interface\\Addons\\Rubim-RH\\Media\\griph.tga"
end 

tarSpeed,_,_,_ = GetUnitSpeed('target')
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

if RubimRH.QueuedSpell():IsReadyQueue() and S.Ravager:ID() ~= RubimRH.queuedSpell[1]:ID() and S.Recklessness:ID() ~= RubimRH.queuedSpell[1]:ID() 
and S.SpearofBastion:ID() ~= RubimRH.queuedSpell[1]:ID() and S.Avatar:ID() ~= RubimRH.queuedSpell[1]:ID() and S.OdynsFury:ID() ~= RubimRH.queuedSpell[1]:ID()
and S.ThunderousRoar:ID() ~= RubimRH.queuedSpell[1]:ID() and S.Onslaught:ID() ~= RubimRH.queuedSpell[1]:ID() then
    return RubimRH.QueuedSpell():Cast()
end
--------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------Interrupts------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
if S.Pummel:IsReadyQueue(8) and select(8, UnitCastingInfo("target")) == false and Target:CastPercentage() > math.random(43, 87) and RubimRH.InterruptsON() and Player:AffectingCombat() then
	return S.Pummel:Cast()
end
--------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------Cooldowns-------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
if S.EnragedReneration:IsCastableQueue() and (S.BitterImmunity:CooldownDown() or not S.BitterImmunity:IsAvailable())
and Player:AffectingCombat() and Player:HealthPercentage() <= 30 then
	return S.EnragedReneration:Cast()
end

if S.BitterImmunity:IsCastableQueue() and (S.EnragedReneration:CooldownDown() or not S.EnragedReneration:IsAvailable())
and Player:AffectingCombat() and Player:HealthPercentage() <= 30 then
	return S.BitterImmunity:Cast()
end

if Player:HealthPercentage() <= 25 and Player:AffectingCombat() and (IsUsableItem(191379) or IsUsableItem(191378)  or IsUsableItem(191380)) and
        (GetItemCooldown(191380) == 0 or GetItemCooldown(191379) == 0 or GetItemCooldown(191378) == 0) and (GetItemCount(191380) >= 1 or GetItemCount(191379) >= 1 or GetItemCount(191378) >= 1)
        and (not Player:InArena() and not Player:InBattlegrounds()) then
        return I.HPIcon:Cast()
    end

if S.BerserkerStance:IsCastableQueue() and not Player:BuffP(S.BerserkerStance) then
	return S.BerserkerStance:Cast()
end

if S.BloodFury:IsReadyQueue(8) and RubimRH.CDsON() then
	return S.BloodFury:Cast()
end

if RubimRH.CDsON() and Player:BuffP(S.EnrageBuff) then
	if Target:IsInRange(10) then
	local ShouldReturn = UseItems();
		if ShouldReturn then 
			return ShouldReturn; 
		end
	end
end
--------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------Rotation--------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
if Player:AffectingCombat() and Player:CanAttack(Target) then
	if not IsCurrentSpell(6603) and Target:IsInRange(10) then
		return S.autoattack:Cast()
	end

		
		if  Cache.EnemiesCount[10] >= 2 and S.Whirlwind:IsCastableQueue() and (S.ImprovedWhirlwindTalent:IsAvailable() or S.MeatCleaverTalent:IsAvailable()) and not Player:BuffP(S.MeatCleaverBuff) then
			return S.Whirlwind:Cast()
		end

		if S.Ravager:IsCastable() and RubimRH.CDsON() and Player:BuffP(S.EnrageBuff) and (allMobsinRange(Cache.EnemiesCount[8]) or IsResting()) and Target:IsInRange(8) and tarSpeed == 0 then
			return S.Ravager:Cast()
		end

		if S.Recklessness:IsReadyQueue(8) and S.Recklessness:IsAvailable() and (RubimRH.CDsON() or S.Recklessness:ID() == RubimRH.queuedSpell[1]:ID()) then
			return S.Recklessness:Cast()
		end
		
		if S.SpearofBastion:IsCastableQueue() and S.SpearofBastion:IsAvailable() then
			if RubimRH.CDsON() and Player:BuffP(S.EnrageBuff) and Player:BuffP(S.RecklessnessBuff) and (allMobsinRange(Cache.EnemiesCount[25]) or IsResting()) and Target:IsInRange(8) and tarSpeed == 0 then
				return S.SpearofBastion:Cast()
			elseif S.SpearofBastion:ID() == RubimRH.queuedSpell[1]:ID() then
				return S.SpearofBastionz:Cast()
			end	
		end
		
		if S.Avatar:IsReadyQueue(8) and S.Avatar:IsAvailable() and (RubimRH.CDsON() or S.Avatar:ID() == RubimRH.queuedSpell[1]:ID()) then
			return S.Avatar:Cast()
		end

		if S.ThunderousRoar:IsCastableQueue() and (RubimRH.CDsON() or S.ThunderousRoar:ID() == RubimRH.queuedSpell[1]:ID()) 
		and Player:BuffP(S.EnrageBuff) and Cache.EnemiesCount[8] >= 1 and (allMobsinRange(Cache.EnemiesCount[8]) or IsResting()) then
			return S.ThunderousRoar:Cast()
		end

		if S.OdynsFury:IsReadyQueue(8) and S.OdynsFury:IsAvailable() and Player:BuffP(S.EnrageBuff) and (RubimRH.CDsON() or S.OdynsFury:ID() == RubimRH.queuedSpell[1]:ID()) then
			return S.OdynsFury:Cast()
		end
		
	
		-- J	25.63	whirlwind,if=spell_targets.whirlwind>1&talent.improved_whirlwind&!buff.meat_cleaver.up|raid_event.adds.in<2&talent.improved_whirlwind&!buff.meat_cleaver.up
		if S.Whirlwind:IsCastable() and Cache.EnemiesCount[10]>1 and S.ImprovedWhirlwindTalent:IsAvailable() and not Player:Buff(S.MeatCleaverBuff) then
			return S.Whirlwind:Cast()
		end
		-- 0.00	execute,if=buff.ashen_juggernaut.up&buff.ashen_juggernaut.remains<gcd
		if IsUsableSpell('Execute') and Player:Buff(S.AshenJuggernautBuff) and Player:BuffP(S.EnrageBuff) and S.Execute:CooldownUp() and Target:IsInRange(8) then
			return S.Execute:Cast()
		end
		
		-- 0.00	thunderous_roar,if=buff.enrage.up&(spell_targets.whirlwind>1|raid_event.adds.in>15)\
		if S.ThunderousRoar:IsCastableQueue() and Player:Buff(S.EnrageBuff) and Cache.EnemiesCount[10]>1 then
			return S.ThunderousRoar:Cast()
		end
		
		-- K	1.70	odyns_fury,if=active_enemies>1&buff.enrage.up&raid_event.adds.in>15
		if S.OdynsFury:IsCastableQueue() and Player:Buff(S.EnrageBuff) and Cache.EnemiesCount[10]>1 then
			return S.OdynsFury:Cast()
		end
		-- L	140.91	crushing_blow,if=talent.wrath_and_fury&buff.enrage.up
				if S.WrathandFury:IsAvailable() and Player:Buff(S.EnrageBuff) and ((IsUsableSpell('Crushing Blow') and S.CrushingBlow:CooldownUp() and Target:IsInRange(8))) then
			return S.RagingBlow:Cast()
		end
		-- M	27.70	execute,if=buff.enrage.up
		if IsUsableSpell('Execute') and Player:BuffP(S.EnrageBuff) and S.Execute:CooldownUp() and Target:IsInRange(8) then
			return S.Execute:Cast()
		end
		-- N	3.00	odyns_fury,if=buff.enrage.up&raid_event.adds.in>15
		if S.OdynsFury:IsCastableQueue() and Player:Buff(S.EnrageBuff) and Cache.EnemiesCount[10]>=1 then
			return S.OdynsFury:Cast()
		end


		-- O	74.05	rampage,if=buff.recklessness.up|buff.enrage.remains<gcd|(rage>110&talent.overwhelming_rage)|(rage>80&!talent.overwhelming_rage)
		if S.Rampage:IsReadyQueue() and (Player:Buff(S.RecklessnessBuff) or Player:BuffRemains(S.EnrageBuff)<Player:GCD() or (Player:Rage()>110 and S.OverwhelmingRage:IsAvailable()) or (Player:Rage()>80 and not S.OverwhelmingRage:IsAvailable())) then
			return S.Rampage:Cast()
		end


		-- P	0.55	execute
		if IsUsableSpell('Execute') and S.Execute:CooldownUp() and Target:IsInRange(8) then
			return S.Execute:Cast()
		end


		-- 0.00	bloodbath,if=buff.enrage.up&talent.reckless_abandon&!talent.wrath_and_fury
		if Player:Buff(S.EnrageBuff) and S.RecklessAbandon:IsAvailable() and not S.WrathandFury:IsAvailable() and ((IsUsableSpell('Bloodbath') and S.Bloodbath:CooldownUp() and Target:IsInRange(8))) then
			return S.Bloodthirst:Cast()
		end


		-- Q	3.37	bloodthirst,if=buff.enrage.down|(talent.annihilator&!buff.recklessness.up)
		if (not Player:Buff(S.EnrageBuff) or (S.Annihilator:IsAvailable() and not Player:Buff(S.RecklessnessBuff))) and ((IsUsableSpell('Bloodthirst') and S.Bloodthirst:CooldownUp() and Target:IsInRange(8))) then
			return S.Bloodthirst:Cast()
		end



		-- 0.00	onslaught,if=!talent.annihilator&buff.enrage.up|talent.tenderize
	if S.Onslaught:IsReadyQueue(8) and (not S.Annihilator:IsAvailable() and Player:BuffP(S.EnrageBuff) or S.Tenderize:IsAvailable()) then
			return S.Onslaught:Cast()
		end


		-- R	8.46	raging_blow,if=charges>1&talent.wrath_and_fury
		if S.RagingBlow:Charges()>1 and S.WrathandFury:IsAvailable() and ((IsUsableSpell('Raging Blow') and S.RagingBlow:CooldownUp() and Target:IsInRange(8))) then
			return S.RagingBlow:Cast()
		end

		-- S	0.87	crushing_blow,if=charges>1&talent.wrath_and_fury
		if S.CrushingBlow:Charges()>1 and S.WrathandFury:IsAvailable() and ((IsUsableSpell('Crushing Blow') and S.CrushingBlow:CooldownUp() and Target:IsInRange(8))) then
			return S.RagingBlow:Cast()
		end
		-- T	0.06	bloodbath,if=buff.enrage.down|!talent.wrath_and_fury
		if ((not Player:Buff(S.EnrageBuff) or not S.WrathandFury:IsAvailable()) and ((IsUsableSpell('Bloodbath') and S.Bloodbath:CooldownUp() and Target:IsInRange(8)))) then
			return S.Bloodthirst:Cast()
		end



		-- 0.00	crushing_blow,if=buff.enrage.up&talent.reckless_abandon
		if Player:Buff(S.EnrageBuff) and S.RecklessAbandon:IsAvailable() and ((IsUsableSpell('Crushing Blow') and S.CrushingBlow:CooldownUp() and Target:IsInRange(8))) then
			return S.RagingBlow:Cast()
		end
		-- 0.00	bloodthirst,if=!talent.wrath_and_fury
		if  not S.WrathandFury:IsAvailable() and ((IsUsableSpell('Bloodthirst') and S.Bloodthirst:CooldownUp() and Target:IsInRange(8))) then
			return S.Bloodthirst:Cast()
		end


		-- U	10.97	raging_blow,if=charges>=1
		if S.RagingBlow:Charges()>=1 and  ((IsUsableSpell('Raging Blow') and S.RagingBlow:CooldownUp() and Target:IsInRange(8))) then
			return S.RagingBlow:Cast()
		end


		-- V	3.33	rampage
		if S.Rampage:IsReadyQueue(8) then
			return S.Rampage:Cast()
		end


		-- 0.00	slam,if=talent.annihilator
		if S.Slam:IsReadyQueue() and S.Annihilator:IsAvailable() then
			return S.Slam:Cast()
		end


		-- W	5.55	bloodbath
		if ((IsUsableSpell('Bloodbath') and S.Bloodbath:CooldownUp() and Target:IsInRange(8))) then
			return S.Bloodthirst:Cast()
		end



		-- X	0.32	raging_blow
		if  ((IsUsableSpell('Raging Blow') and S.RagingBlow:CooldownUp() and Target:IsInRange(8))) then
			return S.RagingBlow:Cast()
		end


		-- Y	0.00	crushing_blow
		if  ((IsUsableSpell('Crushing Blow') and S.CrushingBlow:CooldownUp() and Target:IsInRange(8))) then
			return S.RagingBlow:Cast()
		end



		-- Z	4.68	whirlwind
		if S.Whirlwind:IsReadyQueue(8) then
			return S.Whirlwind:Cast()
		end


		-- Sample Sequence

end
	return 0, "Interface\\Addons\\Rubim-RH\\Media\\griph.tga"
end

RubimRH.Rotation.SetAPL(72, APL);

local function PASSIVE()

end

RubimRH.Rotation.SetPASSIVE(72, PASSIVE);
