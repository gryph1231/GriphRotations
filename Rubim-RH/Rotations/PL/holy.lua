--- Localize Vars
-- Addon
local addonName, addonTable = ...;
-- HeroLib
local HL = HeroLib;
local Cache = HeroCache;
local Unit = HL.Unit;
local Player = Unit.Player;
local Target = Unit.Target;
local MouseOver = Unit.MouseOver;
local Spell = HL.Spell;
local Item = HL.Item;
local pairs = pairs;

RubimRH.Spell[65] = {
    BeaconofVirtue = Spell(200025),
    WordofGlory = Spell(85673),
    WordofGloryP1 = Spell(265221), --fireblood
    WordofGloryP2 = Spell(20594), --stoneform
    WordofGloryP3 = Spell(214202), --rule of law
    WordofGloryP4 = Spell(223306), --bestow faith
    HolyShock = Spell(20473),
    HolyShockP1 = Spell(20549), --war stomp
    HolyShockP2 = Spell(291944), --regeneratin
    HolyShockP3 = Spell(255647), --lights judgment
    HolyShockP4 = Spell(28880), --gift of the narru
    HolyShockTarget = Spell(210294), --divine favor
    HammerofWrath = Spell(24275),
    InfusionofLight = Spell(54149),
    Consecration = Spell(26573),
    Judgment = Spell(275773),
    CrusaderStrike = Spell(35395),
    AvengingWrath = Spell(31884),
    FlashofLight = Spell(19750),
    BlessingofFreedom = Spell(1044),
    ShieldoftheRighteous = Spell(415091),
    BlessingofProtection = Spell(1022),
    Forbearance = Spell(25771),
    BlindingLight = Spell(115750),
    LightoftheMartyr = Spell(448005),
    DevotionAura = Spell(465),
    DivineShield = Spell(642),
    LayonHands = Spell(633),
    LayonHandsP1 = Spell(32223), --crusader aura
    LayonHandsP2 = Spell(62124), --hand of reckoning
    LayonHandsP3 = Spell(317920), --concentration aura
    LayonHandsP4 = Spell(105809), --holy avenger
    BlessingofSacrificeP1 = Spell(6940),
    BlessingofSacrificeP2 = Spell(5502), --sense undead
    BlessingofSacrificeP3 = Spell(85222), --light of dawn
    BlessingofSacrificeP4 = Spell(7328), --redemption
    HammerofJustice = Spell(853),
    DivineToll = Spell(375576),
    -- HandofDivinity = Spell(414273),
    -- HandofDivinityz = Spell(105809), --holy avenger
    -- TyrsDeliverance = Spell(200652),
    Rebuke = Spell(96231),
    autoattack = Spell(190784), --divine steed
    AuraMastery = Spell(31821),
    Intercession = Spell(391054),
    DivineProtection = Spell(498),
    Cleanse = Spell(4987),
    CleanseP1 = Spell(172321), --seraphim
    CleanseP2 = Spell(156910), --beacon of faith
    CleanseP3 = Spell(148039), --barrier of faith
    CleanseP4 = Spell(155145), --arcane torrent
    HolyPrism = Spell(114165),
    -- HolyPrismP = Spell(183435), --retribution aura
    -- HolyPrismP1 = Spell(414176), --daybreak
    -- HolyPrismP2 = Spell(),
    -- HolyPrismP3 = Spell(183998), --lotm
    -- HolyPrismP4 = Spell(59752), --human racial
    BlessingofSummer = Spell(388007),
    Potion = Spell(176108),
    SetFocus = Spell(31884), --avenging wrath
    ClearFocus = Spell(200652), --tyrs deliverance
};
--unused icons: hand of div, holy light, trink2,
local S = RubimRH.Spell[65]

if not Item.Paladin then
    Item.Paladin = {};
end

Item.Paladin.Holy = {
    tx1 = Item(118330),
    tx2 = Item(114616),
    HPIcon = Item(169451),
};
local I = Item.Paladin.Holy;

local function num(val)
    if val then
        return 1
    else
        return 0
    end
end

local function Spender()
    if IsReady("Word of Glory") and los == false then
        if C_Spell.IsSpellInRange("Word of Glory",LowestAlly("UnitID")) and (LowestAlly("HP") < 90 or (not Player:AffectingCombat() and LowestAlly("HP") < 95)) then
            if LowestAlly("UnitID") == "player" then
                return S.WordofGlory:Cast()
            elseif LowestAlly("UnitID") == "party1" then
                return S.WordofGloryP1:Cast()
            elseif LowestAlly("UnitID") == "party2" then
                return S.WordofGloryP2:Cast()
            elseif LowestAlly("UnitID") == "party3" then
                return S.WordofGloryP3:Cast()
            elseif LowestAlly("UnitID") == "party4" then
                return S.WordofGloryP4:Cast()
            end
        elseif UnitGetTotalHealAbsorbs("player") > UnitHealthMax("player") / 5 and C_Spell.IsSpellInRange("Holy Shock","player") then
            return S.WordofGlory:Cast()
        elseif UnitGetTotalHealAbsorbs("party1") > UnitHealthMax("player") / 5 and C_Spell.IsSpellInRange("Holy Shock","party1") then
            return S.WordofGloryP1:Cast()
        elseif UnitGetTotalHealAbsorbs("party2") > UnitHealthMax("player") / 5 and C_Spell.IsSpellInRange("Holy Shock","party2") then
            return S.WordofGloryP2:Cast()
        elseif UnitGetTotalHealAbsorbs("party3") > UnitHealthMax("player") / 5 and C_Spell.IsSpellInRange("Holy Shock","party3") then
            return S.WordofGloryP3:Cast()
        elseif UnitGetTotalHealAbsorbs("party4") > UnitHealthMax("player") / 5 and C_Spell.IsSpellInRange("Holy Shock","party4") then
            return S.WordofGloryP4:Cast()
        end
    end

    if IsReady("Shield of the Righteous") and TargetinRange(5) and UnitCanAttack("player","target") and (Target:AffectingCombat() or C_Spell.IsCurrentSpell(6603)) then
        return S.ShieldoftheRighteous:Cast()
    end  

    return nil
end

local function BlessingReady(blessing)
    if blessing then
        if blessing == "Summer" and C_Spell.GetSpellInfo("Blessing of Summer").iconID == 3636845 then
            return true
        elseif blessing == "Autumn" and C_Spell.GetSpellInfo("Blessing of Summer").iconID == 3636843 then
            return true
        elseif blessing == "Winter" and C_Spell.GetSpellInfo("Blessing of Summer").iconID == 3636846 then
            return true
        elseif blessing == "Spring" and C_Spell.GetSpellInfo("Blessing of Summer").iconID == 3636844 then
            return true
        else
            return false
        end
    else
        return false
    end

    return false
end

local function BlessingofSummer()
    -- C_Spell.GetSpellInfo("Blessing of Summer").iconID == 3636845 --summer
    -- C_Spell.GetSpellInfo("Blessing of Summer").iconID == 3636843 --autumn
    -- C_Spell.GetSpellInfo("Blessing of Summer").iconID == 3636846 --winter
    -- C_Spell.GetSpellInfo("Blessing of Summer").iconID == 3636844 --spring

    if Player:AffectingCombat() then
        if IsReady("Blessing of Summer") and BlessingReady("Summer") and AuraUtil.FindAuraByName("Avenging Wrath", "player") then
            return Item(178675):Cast()
        end

        if IsReady("Blessing of Autumn") and BlessingReady("Autumn") and (S.DivineToll:CooldownDown() or S.HolyPrism:CooldownDown() or S.AvengingWrath:CooldownDown() or S.HolyPrism:CooldownDown()) then
            return Item(178675):Cast()
        end

        if IsReady("Blessing of Spring") and BlessingReady("Spring") and ((MissingHealth(85) >= 3 or MissingHealth(75) >= 2) or Player:HealthPercentage() < 65) then
            return Item(178675):Cast()
        end
    end

    if IsReady("Blessing of Winter") and BlessingReady("Winter") and (Player:ManaPercentage() < 80 or (Player:ManaPercentage() < 90 and Player:AffectingCombat())) then
        return Item(178675):Cast()
    end

    return nil
end

if not loscheck then
    loscheck = CreateFrame("Frame")
end

local losCheckTimer = 0

local frame = loscheck
frame:RegisterEvent("UI_ERROR_MESSAGE")
frame:SetScript("OnEvent", function(self,event,errorType,message)
	if message == 'Target not in line of sight' then
		losCheckTimer = GetTime()
	end	
end)

local function APL()
--------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------Functions/Top priorities----------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
--(IsResting("player") == true and not Player:CanAttack(Target)) or 
if Player:IsCasting() or Player:IsChanneling() then
    return 0, "Interface\\Addons\\Rubim-RH\\Media\\channel.tga"
elseif 
--(IsResting("player") == true and not Player:CanAttack(Target)) or Player:IsDeadOrGhost() or 
AuraUtil.FindAuraByName("Drink", "player") or AuraUtil.FindAuraByName("Food", "player") or AuraUtil.FindAuraByName("Food & Drink", "player") then
    return 0, "Interface\\Addons\\Rubim-RH\\Media\\mount2.tga"
end

if true then
    lostimer = GetTime() - losCheckTimer
    
    if lostimer < Player:GCD() then
        los = true
    else
        los = false
    end

    inInstance, instanceType = IsInInstance()

	trinket1 = GetInventoryItemID("player", 13)
	
	trinket2 = GetInventoryItemID("player", 14)

    if trinket1 then
	    trinket1ready = C_Item.IsUsableItem(trinket1) and GetItemCooldown(trinket1) == 0 and C_Item.IsEquippedItem(trinket1)
    else
        trinket1ready = false
    end
	
    if trinket2 then
	    trinket2ready = C_Item.IsUsableItem(trinket2) and GetItemCooldown(trinket2) == 0 and C_Item.IsEquippedItem(trinket2)
    else
        trinket2ready = false
    end

	_,_,_,_,_,_,_,notInterruptible,_ = UnitCastingInfo("target")
	
	start_time_cast_ms = select(4, UnitCastingInfo('target')) or 0
	
	current_time_ms = GetTime() * 1000
	
	elapsed_time_cast_ca = (start_time_cast_ms > 0) and (current_time_ms - start_time_cast_ms) or 0
	
	cast_time = elapsed_time_cast_ca / 1000

	start_time_channel_ms = select(4, UnitChannelInfo('target')) or 0
	
	elapsed_time_channel_ch = (start_time_channel_ms > 0) and (current_time_ms - start_time_channel_ms) or 0
	
	channel_time = elapsed_time_channel_ch / 1000
end
--Afflicted Soul
--if instanceType == "dungeon" then
if UnitName("mouseover") == "Afflicted Soul" or UnitExists("focus") then
    if UnitName("focus") == "Afflicted Soul" and C_Spell.IsSpellInRange("Holy Shock","focus") then
        if IsReady("Flash of Light") and IsKeyDown('F') and not Player:IsMoving() then
            return S.FlashofLight:Cast()
        end
    
        if IsReady("Cleanse") then
            return S.Cleanse:Cast()
        end

        if LowestAlly("HP") >= 25 then
            if IsReady("Word of Glory") and Player:HolyPower() >= 3 then
                return S.WordofGlory:Cast()
            end

            if IsReady("Holy Shock") then
                return S.HolyShock:Cast()
            end 
        
            -- if S.LightoftheMartyrFocus:IsCastableQueue() and Player:HealthPercentage() > 75 then
            --     return S.LightoftheMartyrFocus:Cast()
            -- end 

            -- if IsReady("Holy Prism") and MissingHealth(85) == 0 and S.HolyShock:CooldownRemains() > Player:GCD() then
            --     return S.HolyPrism:Cast()
            -- end 

            -- if S.FlashofLight:IsCastableQueue() and not Player:IsMoving() then
            --     return S.FlashofLight:Cast()
            -- end
        end
    end

    if not UnitExists("focus") and UnitName("mouseover") == "Afflicted Soul" and not UnitIsDeadOrGhost("mouseover") then
        return S.SetFocus:Cast()
    end

    if UnitExists("focus") and UnitName("focus") ~= "Afflicted Soul" or (UnitIsDeadOrGhost("focus") or not C_Spell.IsSpellInRange("Cleanse","focus")) then
        return S.ClearFocus:Cast()
    end
end
--end
--------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------Out of Combat---------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
if not Player:AffectingCombat() then
    if IsReady("Devotion Aura") and not AuraUtil.FindAuraByName("Devotion Aura", "player") then
        return S.DevotionAura:Cast()
    end
end
--------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------Spell Queue-----------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
if not IsReady(RubimRH.queuedSpell[1]:ID(),nil,nil,1)
or (S.FlashofLight:ID() == RubimRH.queuedSpell[1]:ID() and (C_Spell.IsCurrentSpell(19750) or Player:IsMoving()))
or (S.BlessingofProtection:ID() == RubimRH.queuedSpell[1]:ID() and Player:DebuffUp(S.Forbearance))
or (S.HammerofJustice:ID() == RubimRH.queuedSpell[1]:ID() and not IsReady("Hammer of Justice",1,nil,1))
or (S.DivineShield:ID() == RubimRH.queuedSpell[1]:ID() and Player:DebuffUp(S.Forbearance))
--or (S.TyrsDeliverance:ID() == RubimRH.queuedSpell[1]:ID() and (Player:IsMoving() or (not IsReady("Tyr's Deliverance",nil,nil,1) and not IsReady("Hand of Divinity",nil,nil,1))))
or ((S.Intercession:ID() == RubimRH.queuedSpell[1]:ID() and (Player:PrevGCD(1, S.Intercession) or IsKeyDown('RightButton')))) then
	RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
end

-- if S.TyrsDeliverance:ID() == RubimRH.queuedSpell[1]:ID() and not Player:IsMoving() then
--     if IsReady("Tyr's Deliverance") then
-- 	    return S.TyrsDeliverance:Cast()
--     end

--     -- if IsReady("Hand of Divinity") then
-- 	--     return S.HandofDivinityz:Cast()
--     -- end
-- end

if S.DivineToll:ID() == RubimRH.queuedSpell[1]:ID() and IsReady("Divine Toll") and IsReady("Blessing of Summer") and BlessingReady("Summer") then
    return Item(178675):Cast()
end

if S.BeaconofVirtue:ID() == RubimRH.queuedSpell[1]:ID() and IsReady("Beacon of Virtue") and IsReady("Blessing of Summer") and BlessingReady("Summer") then
    return Item(178675):Cast()
end

if IsReady(RubimRH.queuedSpell[1]:ID(),nil,nil,1) then
    return RubimRH.QueuedSpell():Cast()
end
--------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------Interrupts & Tranq-----------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
if RubimRH.InterruptsON() then 
    -- if IsReady("Rebuke") and (cast_time > Player:GCDRemains() + 0.47 or channel_time > Player:GCDRemains() + 0.47) then
    --     if C_Spell.IsSpellInRange("Rebuke","mouseover") and notInterruptibleMouseover == false then
    --         return S.Rebuke:Cast()
    --     end

    --     if C_Spell.IsSpellInRange("Rebuke","target") and notInterruptibleTarget == false then
    --         return S.Rebuke:Cast()
    --     end
    -- end
    
    if IsReady("Rebuke") and TargetinRange(nil,"Rebuke") and notInterruptible == false and (cast_time > Player:GCDRemains() + 0.47 or channel_time > Player:GCDRemains() + 0.47) then
        return S.Rebuke:Cast()
    end

    if IsReady("Cleanse") and UnitName("focus") ~= "Afflicted Soul" and los == false and LowestAlly("HP") > 30 then
        if GetAppropriateCureSpell('player') == 'Poison' or GetAppropriateCureSpell('player') == 'Disease' or GetAppropriateCureSpell('player') == 'Magic'
        and ((not AuraUtil.FindAuraByName("Icy Bindings", "player", "HARMFUL") and not AuraUtil.FindAuraByName("Deep Chill", "player", "HARMFUL")) or not IsReady("Blessing of Freedom")) then
            return S.Cleanse:Cast()
        end
        if GetAppropriateCureSpell('party1') == 'Poison' or GetAppropriateCureSpell('party1') == 'Disease' or GetAppropriateCureSpell('party1') == 'Magic' and C_Spell.IsSpellInRange("Holy Shock","party1") then
            return S.CleanseP1:Cast()
        end
        if GetAppropriateCureSpell('party2') == 'Poison' or GetAppropriateCureSpell('party2') == 'Disease' or GetAppropriateCureSpell('party2') == 'Magic' and C_Spell.IsSpellInRange("Holy Shock","party2") then
            return S.CleanseP2:Cast()
        end
        if GetAppropriateCureSpell('party3') == 'Poison' or GetAppropriateCureSpell('party3') == 'Disease' or GetAppropriateCureSpell('party3') == 'Magic' and C_Spell.IsSpellInRange("Holy Shock","party3") then
            return S.CleanseP3:Cast()
        end
        if GetAppropriateCureSpell('party4') == 'Poison' or GetAppropriateCureSpell('party4') == 'Disease' or GetAppropriateCureSpell('party4') == 'Magic' and C_Spell.IsSpellInRange("Holy Shock","party4") then
            return S.CleanseP4:Cast()
        end
    end
end
--------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------Cooldowns-------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
--if Player:AffectingCombat() then
    if Player:AffectingCombat() then
        if IsReady("Divine Shield") and Player:HealthPercentage() < 25 and not AuraUtil.FindAuraByName("Wall of Hate", "player") and not AuraUtil.FindAuraByName("Forbearance", "player", "HARMFUL") then
            return S.DivineShield:Cast()
        end

        if trinket1ready and Player:HealthPercentage() < 40 and ((S.HolyShock:Charges() == 0 and not Spender()) or LowestAlly("UnitID") ~= "player" or MissingHealth(70,1) >= 3 or Player:HealthPercentage() < 30) and not AuraUtil.FindAuraByName("Divine Shield", "player") then
            return I.tx1:Cast()
        end
    end

    if IsReady("Lay on Hands") and los == false and Player:GCDRemains() < 0.5 then
        if LowestAlly("HP") < 20 and UnitAffectingCombat(LowestAlly("UnitID")) and ((not Spender() and not IsReady("Holy Shock")) or MissingHealth(35,1) >= 2) then
            if C_Spell.IsSpellInRange("Holy Shock",LowestAlly("UnitID")) then
                if LowestAlly("UnitID") == "player" and not trinket1ready and not AuraUtil.FindAuraByName("Wall of Hate", "player") and not AuraUtil.FindAuraByName("Forbearance", "player", "HARMFUL") then
                    return S.LayonHands:Cast()
                elseif LowestAlly("UnitID") == "party1" and not AuraUtil.FindAuraByName("Forbearance", "party1", "HARMFUL") then
                    return S.LayonHandsP1:Cast()
                elseif LowestAlly("UnitID") == "party2" and not AuraUtil.FindAuraByName("Forbearance", "party2", "HARMFUL") then
                    return S.LayonHandsP2:Cast()
                elseif LowestAlly("UnitID") == "party3" and not AuraUtil.FindAuraByName("Forbearance", "party3", "HARMFUL") then
                    return S.LayonHandsP3:Cast()
                elseif LowestAlly("UnitID") == "party4" and not AuraUtil.FindAuraByName("Forbearance", "party4", "HARMFUL") then
                    return S.LayonHandsP4:Cast()
                end
            end
        end
    end
    
    if Player:AffectingCombat() then
        if Player:ManaPercentage() < 15 and not AuraUtil.FindAuraByName("Divine Shield", "player") and C_Item.IsUsableItem(191386) and GetItemCooldown(191386) == 0 and GetItemCount(191386) >= 1 and not Player:InArena() and not Player:InBattlegrounds() then
            return S.Potion:Cast()
        end

        if Player:HealthPercentage() < 30 and not AuraUtil.FindAuraByName("Divine Shield", "player") and not AuraUtil.FindAuraByName("Wall of Hate", "player") and C_Item.IsUsableItem(207023) and GetItemCooldown(207023) == 0 and GetItemCount(207023) >= 1 and (not Player:InArena() and not Player:InBattlegrounds()) then
            return I.HPIcon:Cast()
        end

        if IsReady("Divine Protection") and Player:HealthPercentage() < 70 and ((S.HolyShock:Charges() == 0 and not Spender()) or LowestAlly("UnitID") ~= "player" or MissingHealth(70,1) >= 3 or Player:HealthPercentage() < 20) and not AuraUtil.FindAuraByName("Wall of Hate", "player") and not AuraUtil.FindAuraByName("Divine Shield", "player") then
            return S.DivineProtection:Cast()
        end

        if IsReady("Blessing of Sacrifice") and los == false then
            if LowestAlly("HP") <= 35 and Player:HealthPercentage() >= 90 then
                if C_Spell.IsSpellInRange("Blessing of Sacrifice",LowestAlly("UnitID")) and UnitAffectingCombat(LowestAlly("UnitID")) then
                    if LowestAlly("UnitID") == "party1" then
                    --and (UnitGroupRolesAssigned("party1") == "DAMAGER" or UnitGroupRolesAssigned("party1") == "HEALER") then
                        return S.BlessingofSacrificeP1:Cast()
                    elseif LowestAlly("UnitID") == "party2" then
                    --and (UnitGroupRolesAssigned("party1") == "DAMAGER" or UnitGroupRolesAssigned("party1") == "HEALER") then
                        return S.BlessingofSacrificeP2:Cast() 
                    elseif LowestAlly("UnitID") == "party3" then
                    --and (UnitGroupRolesAssigned("party1") == "DAMAGER" or UnitGroupRolesAssigned("party1") == "HEALER") then
                        return S.BlessingofSacrificeP3:Cast()
                    elseif LowestAlly("UnitID") == "party4" then
                    --and (UnitGroupRolesAssigned("party1") == "DAMAGER" or UnitGroupRolesAssigned("party1") == "HEALER") then
                        return S.BlessingofSacrificeP4:Cast()
                    end
                end
            end
        end

        if IsReady("Blessing of Freedom") and LowestAlly("HP") > 15 and (AuraUtil.FindAuraByName("Icy Bindings", "player", "HARMFUL") or AuraUtil.FindAuraByName("Deep Chill", "player", "HARMFUL") or (AuraUtil.FindAuraByName("Entangled", "player", "HARMFUL") and LowestAlly("HP") > 50) or AuraUtil.FindAuraByName("Time Sink", "player", "HARMFUL")) then
            return S.BlessingofFreedom:Cast()
        end
    end
--end
--------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------Rotation--------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
if not C_Spell.IsCurrentSpell(6603) and TargetinRange(8) and UnitCanAttack("player","target") and not Target:IsDeadOrGhost() then
    return S.autoattack:Cast()
end

if BlessingofSummer() and RubimRH.CDsON() then
	return BlessingofSummer()
end

if IsReady("Divine Toll") and RubimRH.CDsON() then
    if (MissingHealth(70,1) >= 3 or MissingHealth(50,1) >= 2) or MissingHealth(40) >= 2 then
        if IsReady("Blessing of Summer") and BlessingReady("Summer") then
            return Item(178675):Cast()
        end

        if IsReady("Divine Toll") then
            return S.DivineToll:Cast()
        end
    end
end

if IsReady("Beacon of Virtue") and LowestAlly("HP") >= 35 and (MissingHealth(85) >= 3 or MissingHealth(75) >= 2) then
    if IsReady("Blessing of Summer") and BlessingReady("Summer") then
        return Item(178675):Cast()
    end

    return S.BeaconofVirtue:Cast()
end

if Spender() and Player:HolyPower() >= 5 then
	return Spender()
end

if IsReady("Holy Prism") then
    if TargetinRange(nil,"Holy Prism") and UnitCanAttack("player","target") and (Target:AffectingCombat() or C_Spell.IsCurrentSpell(6603)) and MissingHealth(85) >= 2 then
        return S.HolyPrism:Cast()
    end

    -- if MissingHealth(85) <= 1 and (LowestAlly("HP") <= 40 or (not Player:AffectingCombat() and LowestAlly("HP") <= 80 and (not Spender() or Player:HolyPower() < 3) and not IsReady("Holy Shock"))) then
    --     if C_Spell.IsSpellInRange("Holy Prism",LowestAlly("UnitID")) then
    --         if LowestAlly("UnitID") == "player" then
    --             return S.HolyPrismP:Cast()
    --         elseif LowestAlly("UnitID") == "party1" then
    --             return S.HolyPrismP1:Cast()
    --         elseif LowestAlly("UnitID") == "party2" then
    --             return S.HolyPrismP2:Cast()
    --         elseif LowestAlly("UnitID") == "party3" then
    --             return S.HolyPrismP3:Cast()
    --         elseif LowestAlly("UnitID") == "party4" then
    --             return S.HolyPrismP4:Cast()
    --         end
    --     end
    -- end
end

if IsReady("Beacon of Virtue") and (MissingHealth(85) >= 3 or MissingHealth(75) >= 2) then
    return S.BeaconofVirtue:Cast()
end

-- if IsReady("Aura Mastery") and Player:AffectingCombat() and MissingHealth(50) >= 2 then
--     return S.AuraMastery:Cast()
-- end

if IsReady("Holy Shock") and (S.HolyShock:FullRechargeTime() < Player:GCD() or LowestAlly("HP") < 75) and los == false then
    if LowestAlly("HP") < 90 then
        if C_Spell.IsSpellInRange("Holy Shock",LowestAlly("UnitID")) then
            if LowestAlly("UnitID") == "player" then
                return S.HolyShock:Cast()
            elseif LowestAlly("UnitID") == "party1" then
                return S.HolyShockP1:Cast()
            elseif LowestAlly("UnitID") == "party2" then
                return S.HolyShockP2:Cast()
            elseif LowestAlly("UnitID") == "party3" then
                return S.HolyShockP3:Cast()
            elseif LowestAlly("UnitID") == "party4" then
                return S.HolyShockP4:Cast()
            end
        end
    elseif UnitGetTotalHealAbsorbs("player") > UnitHealthMax("player") / 10 and C_Spell.IsSpellInRange("Holy Shock","player") then
        return S.HolyShock:Cast()
    elseif UnitGetTotalHealAbsorbs("party1") > UnitHealthMax("player") / 10 and C_Spell.IsSpellInRange("Holy Shock","party1") then
        return S.HolyShockP1:Cast()
    elseif UnitGetTotalHealAbsorbs("party2") > UnitHealthMax("player") / 10 and C_Spell.IsSpellInRange("Holy Shock","party2") then
        return S.HolyShockP2:Cast()
    elseif UnitGetTotalHealAbsorbs("party3") > UnitHealthMax("player") / 10 and C_Spell.IsSpellInRange("Holy Shock","party3") then
        return S.HolyShockP3:Cast()
    elseif UnitGetTotalHealAbsorbs("party4") > UnitHealthMax("player") / 10 and C_Spell.IsSpellInRange("Holy Shock","party4") then
        return S.HolyShockP4:Cast()
    elseif UnitCanAttack("player","target") and TargetinRange(nil,"Holy Shock") and (Target:AffectingCombat() or C_Spell.IsCurrentSpell(6603)) and Player:ManaPercentage() > 35 then
        return S.HolyShockTarget:Cast()
    end
end

if IsReady("Hammer of Wrath") and TargetinRange(nil,"Hammer of Wrath") and UnitCanAttack("player","target") and (Target:AffectingCombat() or C_Spell.IsCurrentSpell(6603)) then
    return S.HammerofWrath:Cast()
end

if IsReady("Judgment") and TargetinRange(nil,"Judgment") and UnitCanAttack("player","target") and (Target:AffectingCombat() or C_Spell.IsCurrentSpell(6603)) and Player:BuffRemains(S.InfusionofLight) < Player:GCD() then
    return S.Judgment:Cast()
end

if IsReady("Holy Shock") and los == false then
    if LowestAlly("HP") < 80 or (not Player:AffectingCombat() and LowestAlly("HP") < 95) then
        if C_Spell.IsSpellInRange("Holy Shock",LowestAlly("UnitID",true)) then
            if LowestAlly("UnitID") == "player" then
                return S.HolyShock:Cast()
            elseif LowestAlly("UnitID") == "party1" then
                return S.HolyShockP1:Cast()
            elseif LowestAlly("UnitID") == "party2" then
                return S.HolyShockP2:Cast()
            elseif LowestAlly("UnitID") == "party3" then
                return S.HolyShockP3:Cast()
            elseif LowestAlly("UnitID") == "party4" then
                return S.HolyShockP4:Cast()
            end
        end
    elseif UnitGetTotalHealAbsorbs("player") > UnitHealthMax("player") / 5 and C_Spell.IsSpellInRange("Holy Shock","player") then
        return S.HolyShock:Cast()
    elseif UnitGetTotalHealAbsorbs("party1") > UnitHealthMax("player") / 5 and C_Spell.IsSpellInRange("Holy Shock","party1") then
        return S.HolyShockP1:Cast()
    elseif UnitGetTotalHealAbsorbs("party2") > UnitHealthMax("player") / 5 and C_Spell.IsSpellInRange("Holy Shock","party2") then
        return S.HolyShockP2:Cast()
    elseif UnitGetTotalHealAbsorbs("party3") > UnitHealthMax("player") / 5 and C_Spell.IsSpellInRange("Holy Shock","party3") then
        return S.HolyShockP3:Cast()
    elseif UnitGetTotalHealAbsorbs("party4") > UnitHealthMax("player") / 5 and C_Spell.IsSpellInRange("Holy Shock","party4") then
        return S.HolyShockP4:Cast()
    end
end

if Spender() and Player:HolyPower() >= 3 then
	return Spender()
end

if IsReady("Judgment") and TargetinRange(nil,"Judgment") and UnitCanAttack("player","target") and (Target:AffectingCombat() or C_Spell.IsCurrentSpell(6603)) then
    return S.Judgment:Cast()
end

if IsReady("Crusader Strike") and TargetinRange(nil,"Crusader Strike") and UnitCanAttack("player","target") and (Target:AffectingCombat() or C_Spell.IsCurrentSpell(6603)) then
    return S.CrusaderStrike:Cast()
end 

if IsReady("Consecration") and UnitCanAttack("player","target") and not AuraUtil.FindAuraByName("Consecration", "player") and ((TargetinRange(8) and not Player:IsMoving()) or (TargetinRange(5) and Player:IsMoving())) then
    return S.Consecration:Cast()
end

	return 0, "Interface\\Addons\\Rubim-RH\\Media\\mount2.tga"
end

RubimRH.Rotation.SetAPL(65, APL);

local function PASSIVE()
end
RubimRH.Rotation.SetPASSIVE(65, PASSIVE);