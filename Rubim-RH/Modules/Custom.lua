function table.removeKey(t, k)
    local i = 0
    local keys, values = {}, {}
    for k, v in pairs(t) do
        i = i + 1
        keys[i] = k
        values[i] = v
    end

    while i > 0 do
        if keys[i] == k then
            table.remove(keys, i)
            table.remove(values, i)
            break
        end
        i = i - 1
    end

    local a = {}
    for i = 1, #keys do
        a[keys[i]] = values[i]
    end

    return a
end

local HL = HeroLib;
local Cache = HeroCache;
local Unit = HL.Unit;
local Player = Unit.Player;
local Target = Unit.Target;
local Spell = HL.Spell;
local Item = HL.Item;

--- ============================   CUSTOM   ============================
local function round2(num, idp)
    mult = 10 ^ (idp or 0)
    return math.floor(num * mult + 0.5) / mult
end

local function ttd(unit)
    unit = unit or "target";
    if thpcurr == nil then
        thpcurr = 0
    end
    if thpstart == nil then
        thpstart = 0
    end
    if timestart == nil then
        timestart = 0
    end
    if UnitExists(unit) and not UnitIsDeadOrGhost(unit) then
        if currtar ~= UnitGUID(unit) then
            priortar = currtar
            currtar = UnitGUID(unit)
        end
        if thpstart == 0 and timestart == 0 then
            thpstart = UnitHealth(unit)
            timestart = GetTime()
        else
            thpcurr = UnitHealth(unit)
            timecurr = GetTime()
            if thpcurr >= thpstart then
                thpstart = thpcurr
                timeToDie = 999
            else
                if ((timecurr - timestart) == 0) or ((thpstart - thpcurr) == 0) then
                    timeToDie = 999
                else
                    timeToDie = round2(thpcurr / ((thpstart - thpcurr) / (timecurr - timestart)), 2)
                end
            end
        end
    elseif not UnitExists(unit) or currtar ~= UnitGUID(unit) then
        currtar = 0
        priortar = 0
        thpstart = 0
        timestart = 0
        timeToDie = 9999999999999999
    end
    if timeToDie == nil then
        return 99999999
    else
        return timeToDie
    end
end

function DiyingIn()
    HL.GetEnemies(10, true); -- Blood Boil
    totalmobs = 0
    dyingmobs = 0
    for _, CycleUnit in pairs(Cache.Enemies[10]) do
        totalmobs = totalmobs + 1;
        if CycleUnit:TimeToDie() <= 20 then
            dyingmobs = dyingmobs + 1;
        end
    end
    if dyingmobs == 0 then
        return 0
    else
        return totalmobs / dyingmobs
    end
end

function GetTotalMobs()
    local totalmobs = 0
    for reference, unit in pairs(activeUnitPlates) do
        if CheckInteractDistance(unit, 3) then
            totalmobs = totalmobs + 1
        end
    end
    return totalmobs
end

function GetMobsDying()
    local totalmobs = 0
    local dyingmobs = 0
    for reference, unit in pairs(activeUnitPlates) do
        if CheckInteractDistance(unit, 3) then
            totalmobs = totalmobs + 1
            if ttd(unit) <= 6 then
                dyingmobs = dyingmobs + 1
            end
        end
    end

    if totalmobs == 0 then
        return 0
    end

    return (dyingmobs / totalmobs) * 100
end

function GetMobs(spellId)
    local totalmobs = 0
    for reference, unit in pairs(activeUnitPlates) do
        if IsSpellInRange(GetSpellInfo(spellId), unit) then
            totalmobs = totalmobs + 1
        end
    end
    return totalmobs
end

local SpellsInterrupt = {
    194610, 198405, 194657, 199514, 199589, 216197, --Maw of Souls
    -- PvP Spells
	118, -- Polymorph
    20066, -- Repentance
    51514, -- Hex
    19386, -- Wyvern Sting
    5782, -- Fear
    33786, -- Cyclone
    605, -- Mind Control 
    982, -- Revive Pet 
    32375, -- Mass Dispel 
    203286, -- Greatest Pyroblast
    116858, -- Chaos Bolt 
    20484, -- Rebirth
    203155, -- Sniper Shot 
    47540, -- Penance
    596, -- Prayer of Healing
    2060, -- Heal
    2061, -- Flash Heal
    32546, -- Binding Heal                        (priest, holy)
    33076, -- Prayer of Mending
    64843, -- Divine Hymn
    120517, -- Halo                                (priest, holy/disc)
    186263, -- Shadow Mend
    194509, -- Power Word: Radiance
    265202, -- Holy Word: Salvation                (priest, holy)
    289666, -- Greater Heal                        (priest, holy)
    740, -- Tranquility
    8936, -- Regrowth
    48438, -- Wild Growth
    289022, -- Nourish                             (druid, restoration)
    1064, -- Chain Heal
    8004, -- Healing Surge
    73920, -- Healing Rain
    77472, -- Healing Wave
    197995, -- Wellspring                          (shaman, restoration)
    207778, -- Downpour                            (shaman, restoration)
    19750, -- Flash of Light
    82326, -- Holy Light
    116670, -- Vivify
    124682, -- Enveloping Mist
    191837, -- Essence Font
    209525, -- Soothing Mist
    227344, -- Surging Mist                        (monk, mistweaver)
	
	
	
	
	
	
	0
}

local function ShouldInterrupt()
    local importantCast = false
    local castName, _, _, _, castStartTime, castEndTime, _, _, notInterruptable, spellID = UnitCastingInfo("target")

    if castName == nil then
        local castName, nameSubtext, text, texture, startTimeMS, endTimeMS, isTradeSkill, notInterruptible = UnitChannelInfo("unit")
    end

    if spellID == nil or notInterruptable == true then
        return false
    end

    for i, v in ipairs(SpellsInterrupt) do
        if spellID == v then
            importantCast = true
            break
        end
    end

    if spellID == nil or castInterruptable == false then
        return false
    end

    if int_smart == false then
        importantCast = false
    end

    if importantCast == false then
        return false
    end

    local timeSinceStart = (GetTime() * 1000 - castStartTime) / 1000
    local timeLeft = ((GetTime() * 1000 - castEndTime) * -1) / 1000
    local castTime = castEndTime - castStartTime
    local currentPercent = timeSinceStart / castTime * 100000
    local interruptPercent = math.random(10, 30)
    if currentPercent >= interruptPercent then
        return true
    end
    return false
end

local movedTimer = 0
function RubimRH.lastMoved()
    if Player:IsMoving() then
        movedTimer = GetTime()
    end
    return GetTime() - movedTimer
end

local playerGUID
local damageAmounts, damageTimestamps = {}, {}
local damageInLast3Seconds = 0
local lastMeleeHit = 0

local combatLOG = CreateFrame("Frame")
combatLOG:RegisterEvent("PLAYER_LOGIN")
combatLOG:SetScript("OnEvent", function(self, event)
    playerGUID = UnitGUID("player")
    self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
    self:SetScript("OnEvent", function()
        local timestamp, event, arg3, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, arg12, arg13, arg14, arg15, arg16 = CombatLogGetCurrentEventInfo()
        if destGUID ~= playerGUID then
            return
        end
        local amount = nil
        if event == "SPELL_DAMAGE" or event == "SPELL_PERIODIC_DAMAGE" or event == "RANGE_DAMAGE" then
            amount = arg15
            --amount = camount
        elseif event == "SWING_DAMAGE" then
            lastMeleeHit = GetTime()
            amount = arg12
        elseif event == "ENVIRONMENTAL_DAMAGE" then
            amount = arg13
        end
        if amount then
            -- Record new damage at the top of the log:
            tinsert(damageAmounts, 1, amount)
            tinsert(damageTimestamps, 1, timestamp)
            -- Clear out old entries from the bottom, and add up the remaining ones:
            local cutoff = timestamp - 3
            damageInLast3Seconds = 0
            for i = #damageTimestamps, 1, -1 do
                local timestamp = damageTimestamps[i]
                if timestamp < cutoff then
                    damageTimestamps[i] = nil
                    damageAmounts[i] = nil
                else
                    damageInLast3Seconds = damageInLast3Seconds + damageAmounts[i]
                end
            end
        end
    end)
end)

function RubimRH.lastSwing()
    if lastMeleeHit > 0 then
        return GetTime() - lastMeleeHit
    end
    return 0
end

function RubimRH.getLastDamage()
    return damageInLast3Seconds
end

function RubimRH.clearLastDamage()
    damageInLast3Seconds = 0
end

function RubimRH.LastDamage()
    local IncomingDPS = (damageInLast3Seconds / UnitHealthMax("player")) * 100
    return (math.floor((IncomingDPS * ((100) + 0.5)) / (100)))
end

function RubimRH.SetFramePos(frame, x, y, w, h)
    local xOffset0 = 1
    if frame == nil then
        return
    end
    if GetCVar("gxMaximize") == "0" then
        xOffset0 = 0.9411764705882353
    end
    xPixel, yPixel, wPixel, hPixel = x, y, w, h
    xRes, yRes = string.match(({ GetScreenResolutions() })[GetCurrentResolution()], "(%d+)x(%d+)");
    uiscale = UIParent:GetScale();
    XCoord = xPixel * (768.0 / xRes) * GetMonitorAspectRatio() / uiscale / xOffset0
    YCoord = yPixel * (768.0 / yRes) / uiscale;
    Weight = wPixel * (768.0 / xRes) * GetMonitorAspectRatio() / uiscale
    Height = hPixel * (768.0 / yRes) / uiscale;
    if x and y then
        frame:SetPoint("TOPLEFT", XCoord, YCoord)
    end
    if w and h then
        frame:SetSize(Weight, Height)
    end
end

function RubimRH.ColorOnOff(boolean)
    if boolean == true then
        return "|cFF00FF00"
    else
        return "|cFFFF0000"
    end
end

-- Target Valid
function RubimRH.TargetIsValid(override)
    local override = override or false

    local unitReaction = UnitReaction("Player", "Target") or 0
    if not override and unitReaction >= 4 and not Player:AffectingCombat() then
        return false
    end

    local isValid = false

    if Target:Exists() and Player:CanAttack(Target) and not Target:IsDeadOrGhost() then
        isValid = true
    end

    return isValid
end

-- will be replaced
function RubimRH.azerite(slot, azeriteID)
    local IsArmor = C_AzeriteEmpoweredItem.IsAzeriteEmpoweredItem(ItemLocation:CreateFromEquipmentSlot(slot));
    if IsArmor == true then
        local azeriteLearned = C_AzeriteEmpoweredItem.IsPowerSelected(ItemLocation:CreateFromEquipmentSlot(slot), azeriteID);
        if azeriteLearned == true then
            return true
        else
            return false
        end
    end
    return false
end

function RubimRH.DebugPrint(Text)
    if RubimRH.db.profile.mainOption.debug == true then
        print("DEBUG: " .. Text)
    end
end


--NeP RIP
RubimRH.Buttons = {}

local nBars = {
    "ActionButton",
    "MultiBarBottomRightButton",
    "MultiBarBottomLeftButton",
    "MultiBarRightButton",
    "MultiBarLeftButton"
}

local lastSpell = 0
-- local function UpdateButtons()
    -- lastSpell = 0
    -- wipe(RubimRH.Buttons)
    -- for _, group in ipairs(nBars) do
        -- for i = 1, 12 do
            -- local button = _G[group .. i]
            -- if button then
                -- local actionType, id = _G.GetActionInfo(_G.ActionButton_CalculateAction(button, "LeftButton"))
                -- if actionType == 'spell' then
                    -- --local spell = GetSpellInfo(id)
                    -- local spell = id
                    -- if spell then
                        -- RubimRH.Buttons[spell] = button
                        -- --RubimRH.Buttons[spell].glow = false
                        -- --RubimRH.Buttons[spell].text = RubimRH.Buttons[spell]:CreateFontString('ButtonText')
                        -- --RubimRH.Buttons[spell].text:SetFont("Fonts\\ARIALN.TTF", 22, "OUTLINE")
                        -- --RubimRH.Buttons[spell].text:SetPoint("CENTER", RubimRH.Buttons[spell])
                        -- --RubimRH.Buttons[spell].GlowTexture = RubimRH.Buttons[spell]:CreateTexture(nil, "TOOLTIP")
                        -- --RubimRH.Buttons[spell].GlowTexture:SetScale(0.8)
                        -- --RubimRH.Buttons[spell].GlowTexture:SetAlpha(0.5)
                        -- --RubimRH.Buttons[spell].GlowTexture:SetPoint("CENTER")
                        -- --RubimRH.Buttons[spell] = button:GetName()
                    -- end
                -- end
            -- end
        -- end
    -- end

-- end

-- RubimRH.Listener:Add('NeP_Buttons', 'ACTIVE_TALENT_GROUP_CHANGED', function()
    -- UpdateButtons()
-- end)

-- RubimRH.Listener:Add('NeP_Buttons', 'PLAYER_PVP_TALENT_UPDATE', function()
    -- UpdateButtons()
-- end)

-- RubimRH.Listener:Add('NeP_Buttons', 'PLAYER_ENTERING_WORLD', function()
    -- UpdateButtons()
-- end)

-- RubimRH.Listener:Add('NeP_Buttons', 'ACTIONBAR_SLOT_CHANGED', function()
    -- UpdateButtons()
-- end)

-- RubimRH.Listener:Add('NeP_Buttons', 'PLAYER_TALENT_UPDATE', function()
    -- UpdateButtons()
-- end)

function RubimRH.HideButtonGlow(spellID)
    local isString = (type(spellID) == "string")

    if isString and spellID == "All" then
        for i, button in pairs(RubimRH.Buttons) do
            --if button.glow == true then
                button.glow = false
                button.GlowTexture:SetTexture(nil)
                --button.text:SetText("")
                --button.NormalTexture:SetColorTexture(0, 0, 0, 0)
                --ActionButton_HideOverlayGlow(button)
            --end
        end
        return
    end

    if RubimRH.Buttons[spellID] ~= nil then
        --RubimRH.Buttons[spellID].GlowTexture:SetTexture(nil)
        --RubimRH.Buttons[spellID].glow = false
        --RubimRH.Buttons[spellID].text:SetText("")
        --RubimRH.Buttons[spellID].NormalTexture:SetColorTexture(0, 0, 0, 0)
        --for i, button in pairs(RubimRH.Buttons) do
        --button.NormalTexture:SetColorTexture(0, 0, 0, 0)
        --ActionButton_HideOverlayGlow(button)
        --end
    end
end

function RubimRH.OLDShowButtonGlow(spellID)
    RubimRH.HideButtonGlow("All")
    if RubimRH.Buttons[spellID] ~= nil then
        if lastSpell > 0 and spellID ~= lastSpell then
            --RubimRH.Buttons[spellID].glow = false
           -- RubimRH.Buttons[spellID].GlowTexture:SetTexture(nil)
            lastSpell = spellID
        end
        --ActionButton_ShowOverlayGlow(RubimRH.Buttons[spellID])
        --RubimRH.Buttons[spellID].text:SetText("|cffff0000=>|r")
        RubimRH.Buttons[spellID].GlowTexture:SetTexture("Interface\\Addons\\Rubim-RH\\Media\\combat.tga")
        RubimRH.Buttons[spellID].glow = true
        lastSpell = spellID
    end
end

function RubimRH.ShowButtonGlowQueue(spellID)
    if RubimRH.Buttons[spellID] ~= nil then
        RubimRH.Buttons[spellID].GlowTexture:SetTexture("Interface\\Addons\\Rubim-RH\\Media\\disarmed.tga")
    end
end

local activeFrame = CreateFrame('Frame', 'ShowIcon', _G.UIParent, "BackdropTemplate")
activeFrame:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background",
                         edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
                         tile = true, tileSize = 16, edgeSize = 16,
                         insets = { left = 4, right = 4, top = 4, bottom = 4 }
});


activeFrame:SetBackdropColor(0,0,0,0);
activeFrame.texture = activeFrame:CreateTexture()
activeFrame.texture:SetTexture("Interface/Addons/Rubim-RH/Media/combat.tga")
activeFrame.texture:SetPoint("CENTER")
activeFrame:SetFrameStrata('HIGH')
activeFrame:Hide()

local display = CreateFrame('Frame', 'Faceroll_Info', activeFrame, "BackdropTemplate")
display:SetClampedToScreen(true)
display:SetSize(0, 0)
display:SetPoint("TOP")
display:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background",
                     edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
                     tile = true, tileSize = 16, edgeSize = 16,
                     insets = { left = 4, right = 4, top = 4, bottom = 4 }
});
display:SetBackdropColor(0,0,0,1);
display.text = display:CreateFontString('Nothing')
display.text:SetFont("Fonts\\ARIALN.TTF", 16)
display.text:SetPoint("CENTER", display)

function RubimRH.ShowButtonGlow(spellID)

    if RubimRH.db.profile.mainOption.glowactionbar == false then
        return
    end

    local spellButton = RubimRH.Buttons[spellID]
    if not spellButton then return end
    local bSize = spellButton:GetWidth()
    activeFrame:SetSize(bSize+5, bSize+5)
    --display:SetSize(display.text:GetStringWidth()+20, display.text:GetStringHeight()+20)
    activeFrame.texture:SetSize(activeFrame:GetWidth()-5,activeFrame:GetHeight()-5)
    activeFrame:SetPoint("CENTER", spellButton, "CENTER")
    --display:SetPoint("TOP", spellButton, 0, display.text:GetStringHeight()+20)
    --spell = '|cff'..NeP.Color.."Spell:|r "..spell
    --local isTargeting = '|cff'..NeP.Color..tostring(_G.UnitIsUnit("target", target or 'player'))
    --target = '|cff'..NeP.Color.."\nTarget:|r"..(_G.UnitName(target or 'player') or '')
    --display.text:SetText(spell..target.."("..isTargeting..")")
    activeFrame:Show()
end

function RubimRH.HideButtonGlow()
    activeFrame:Hide()
end

function RubimRH.print(text, color)
    print("|cff828282RRH: |r" .. text)
end

function RubimRH.GetCurrentLatency()
    local latency = select(3,GetNetStats())	
	local percentlatency = latency * 0.001
	
	return percentlatency or 0
	
end

--------------------------------------
-- ElvyUI Fix
--------------------------------------
local handled = {["Frame"] = true}
local object = CreateFrame("Frame")
object.t = object:CreateTexture(nil,"BACKGROUND")
local OldTexelSnappingBias = object.t:GetTexelSnappingBias()

local function Fix(frame)
    if (frame and not frame:IsForbidden()) and frame.PixelSnapDisabled and not frame.PixelSnapTurnedOff then
        if frame.SetSnapToPixelGrid then
            frame:SetTexelSnappingBias(OldTexelSnappingBias)
        elseif frame.GetStatusBarTexture then
            local texture = frame:GetStatusBarTexture()
            if texture and texture.SetSnapToPixelGrid then                
                texture:SetTexelSnappingBias(OldTexelSnappingBias)
            end
        end
        frame.PixelSnapTurnedOff = true 
    end
end

local function addapi(object)
    local mt = getmetatable(object).__index
        if mt.DisabledPixelSnap then 
        if mt.SetSnapToPixelGrid then hooksecurefunc(mt, 'SetSnapToPixelGrid', Fix) end
        if mt.SetStatusBarTexture then hooksecurefunc(mt, 'SetStatusBarTexture', Fix) end
        if mt.SetColorTexture then hooksecurefunc(mt, 'SetColorTexture', Fix) end
        if mt.SetVertexColor then hooksecurefunc(mt, 'SetVertexColor', Fix) end
        if mt.CreateTexture then hooksecurefunc(mt, 'CreateTexture', Fix) end
        if mt.SetTexCoord then hooksecurefunc(mt, 'SetTexCoord', Fix) end
        if mt.SetTexture then hooksecurefunc(mt, 'SetTexture', Fix) end
    end
end

addapi(object)
addapi(object:CreateTexture())
addapi(object:CreateFontString())
addapi(object:CreateMaskTexture())
object = EnumerateFrames()
while object do
    if not object:IsForbidden() and not handled[object:GetObjectType()] then
        addapi(object)
        handled[object:GetObjectType()] = true
    end

    object = EnumerateFrames(object)
end

--------------------------------------
-- MSG Addon
--------------------------------------
-- UPDATED 8.0.1 Macro
--/script C_ChatInfo.SendAddonMessage("grip", UnitName("player"), "RAID")
C_ChatInfo.RegisterAddonMessagePrefix("grip") --Fix BFA 8.0.1
C_ChatInfo.RegisterAddonMessagePrefix("bark") --Fix BFA 8.0.1
C_ChatInfo.RegisterAddonMessagePrefix("swap") --Fix BFA 8.0.1
C_ChatInfo.RegisterAddonMessagePrefix("bop") --Fix BFA 8.0.1

-- Leap handler
local spellId = 73325
local debuffDuration = 5

-- create the spell icon to show on raid frame
RubimRH.addLeapIcon = function(parentFrame)
    local frame = CreateFrame("Frame",nil,parentFrame)
    frame:SetFrameStrata("HIGH")
    frame:SetWidth(RubimRH.iconWidth)
    frame:SetHeight(RubimRH.iconHeight)
    frame:SetAlpha(RubimRH.iconAlpha)
    
    local texture = frame:CreateTexture(nil,"HIGH")
    texture:SetTexture(select(3, GetSpellInfo(spellId)))
    texture:SetAllPoints(frame)
    frame.texture = texture
    
    frame:SetPoint(RubimRH.position,0,0)
    
    local cooldown = CreateFrame("COOLDOWN", nil, frame, "CooldownFrameTemplate")
    cooldown:SetCooldown(GetTime(), debuffDuration)
    cooldown:SetAllPoints(frame)
    cooldown:SetDrawEdge(false)
    cooldown:SetHideCountdownNumbers(IsAddOnLoaded("OmniCC") or false)
    
    frame:Show()
    C_Timer.After(debuffDuration, function()
            frame:Hide()
    end)
end

-- Leap Highlight on raid frame depending on the current asker name and if our spell cd is ready
RubimRH.Leaphighlight = function(target)
    local hasGrid2 = IsAddOnLoaded("Grid2")
    local hasElvUIParty = _G["ElvUF_Party"] and _G["ElvUF_Party"]:IsVisible()
    local hasElvUIRaid = _G["ElvUF_Raid"] and _G["ElvUF_Raid"]:IsVisible()
    --local isOnCD = GetSpellCooldown(73325)
    
    
    -- Check Spell Cooldown and show custom status
    local IsOnCD = false;
    local name = GetSpellInfo(73325);
    local start, duration, enabled = GetSpellCooldown(name);
    -- msg when grip up
	local msg1 = "Grip pas up, sorry"
	-- msg if grip down
    local msg2 = "Grip up, no stress"    
    
    -- spell on cd
    if ( start > 0 and duration > 1.5) then
        print("DEMANDE DE GRIP DE "..target.."MAIS CD PAS UP") -- TO DO CUSTOMIZE A BIT BETTER
        
        -- if spell is not available, whisp our target to tell the spell is on cd
        SendChatMessage(msg1, "WHISPER", nil, target)
        
        IsOnCD = true;
    else
        print("GRIP URGENT SUR "..target.." !!") -- TO DO CUSTOMIZE A BIT BETTER
        SendChatMessage(msg2, "WHISPER", nil, target)
        IsOnCD = false;
    end    
    
    
    -- Fix Raid Group 8.0.1 + cooldown verification
    if hasElvUIRaid and IsOnCD == false  then
        for i=1, 8 do
            for j=1, 5 do
                local f = _G["ElvUF_RaidGroup"..i.."UnitButton"..j]
                if f and f.unit and UnitName(f.unit) == target then
                    RubimRH.addLeapIcon(f)
                    return
                end
            end
        end
        
        -- Fix Party Group 8.0.1 + cooldown verification
    elseif hasElvUIParty and IsOnCD == false then
        for i=1, 8 do
            for j=1, 5 do
                local f = _G["ElvUF_PartyGroup"..i.."UnitButton"..j]
                if f and f.unit and UnitName(f.unit) == target then
                    RubimRH.addLeapIcon(f)
                    return
                end
            end
        end
        
    elseif hasGrid2 and IsOnCD == false then
        local layout = Grid2LayoutFrame
        
        if layout then
            local children = {layout:GetChildren()}
            for _, child in ipairs(children) do
                if child:IsVisible() then
                    local frames = {child:GetChildren()}
                    for _, f in ipairs(frames) do
                        if f.unit and UnitName(f.unit) == target then
                            RubimRH.addLeapIcon(f)
                            return
                        end
                    end
                end
            end
        end
    else
        if IsOnCD == false then
            for i=1, 40 do
                local f = _G["CompactRaidFrame"..i]
                if f and f.unitExists and f.unit and UnitName(f.unit) == target then
                    RubimRH.addLeapIcon(f)
                    return
                end
            end
        end
        -- Fix party group
        -- for i=1, 5 do
        --   local f = _G["CompactPartyFrameMember"..i]
        -- if f and f.unitExists and f.unit and UnitName(f.unit) == target then
        --   RubimRH.addLeapIcon(f)
        --  return
        -- end
        -- end
        
        
        if IsOnCD == false then
            for i=1, 4 do
                for j=1, 5 do
                    local f = _G["CompactRaidGroup"..i.."Member"..j]
                    if f and f.unitExists and f.unit and UnitName(f.unit) == target then
                        RubimRH.addLeapIcon(f)
                        return
                    end
                end
                
            end
        end
    end
end

-- Leap message handler return player name
function LeapMessage(e, prefix, message)    
    local actionasked = prefix
	if prefix == "grip" then
        --message contains the players name
        RubimRH.Leaphighlight(message)
    end	
	return actionasked
end


function RubimRH.AskedForLeap()
    if actionasked == "grip" then
	    return true
	else
	    return false
    end		
end

function RubimRH.AskedForBark()
    if HandleChatMsgAddon() == true then
	    return true
	else
	    return false	
    end		
end

function RubimRH.AskedForSwap()
    if HandleChatMsgAddon() == true then
	    return true
	else
	    return false
    end		
end

function RubimRH.AskedForBop()
    if HandleChatMsgAddon() == true then
	    return true
	else
	    return false
    end		
end

--- Core DB Saved Var
-- @usage Automata.GetDB('core', 'icon')
function RubimRH.GetDB( option, key )
    local tempStr = "return RubimRH.db.profile." .. option .. "." .. key
    local temp = loadstring( tempStr )( )
    
    if not temp then
        RubimRH.Print( "Error: " .. tempStr )
        return
    end
    
    return temp
end











-- MyHealthTracker.lua
MyHealthTracker = {}
local frame = CreateFrame("Frame")
local playerHealthPercentage = (UnitHealth("player") / UnitHealthMax("player")) * 100 -- Set initial health percentage
local inCombat = false
local healthLossValues = {}
local healthLossWindow = 3 
local updateInterval = 1
local timeSinceLastUpdate = 0
local predictedHealthLoss = 0 -- Define predicted health loss as a module-level variable

local function OnEvent(self, event, ...)
    if event == "PLAYER_REGEN_DISABLED" then
        inCombat = true
        playerHealthPercentage = (UnitHealth("player") / UnitHealthMax("player")) * 100
        healthLossValues = {}
    elseif event == "PLAYER_REGEN_ENABLED" then
        inCombat = false
    elseif event == "COMBAT_LOG_EVENT_UNFILTERED" then
        local timestamp, subevent, _, sourceGUID, _, _, _, destGUID, _, _, _, spellID, _, _, amount, overkill, school, resisted, blocked, absorbed, critical, glancing, crushing, isOffHand = CombatLogGetCurrentEventInfo()

        if subevent == "SWING_DAMAGE" or subevent == "RANGE_DAMAGE" or subevent == "SPELL_DAMAGE" or subevent == "SPELL_PERIODIC_DAMAGE" then
            if destGUID == UnitGUID("player") then
                local currentHealth = UnitHealth("player")
                local maxHealth = UnitHealthMax("player")
                local newHealthPercentage = (currentHealth / maxHealth) * 100

                local healthLoss = playerHealthPercentage - newHealthPercentage

                if healthLoss > 0 then
                    table.insert(healthLossValues, {loss = healthLoss, time = GetTime()})
                end

                playerHealthPercentage = newHealthPercentage
            end
        end
    end
end

function MyHealthTracker.GetPredictedHealthLoss()
    local currentTime = GetTime()
    local sum = 0
    local count = 0

    for i = #healthLossValues, 1, -1 do
        local value = healthLossValues[i]
        if currentTime - value.time <= healthLossWindow then
            sum = sum + value.loss
            count = count + 1
        else
            table.remove(healthLossValues, i)
        end
    end

    if count == 0 then
        return 0
    end

    local averageHealthLoss = sum / count
    local averageHealthLossPerSecond = averageHealthLoss / healthLossWindow
    return averageHealthLoss
end

local function OnUpdate(self, elapsed)
    
    if inCombat then
        timeSinceLastUpdate = timeSinceLastUpdate + elapsed

        if timeSinceLastUpdate >= updateInterval then
            predictedHealthLoss = MyHealthTracker.GetPredictedHealthLoss() * 3 -- Predicted health loss over the next 5 seconds
            -- print("Predicted health loss:", predictedHealthLoss) -- Print the predicted health loss
            timeSinceLastUpdate = 0
        end
    end
end

frame:SetScript("OnEvent", OnEvent)
frame:SetScript("OnUpdate", OnUpdate)
frame:RegisterEvent("PLAYER_REGEN_DISABLED") -- Enter combat
frame:RegisterEvent("PLAYER_REGEN_ENABLED") -- Leave combat
frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED") -- Combat log event















-- ExistingLuaFile.lua

-- Add the following code to your existing Lua file

_G.partyOrRaidDead = function()
    local deadCount = 0

    local function checkDeadOrGhost(unitID)
        if UnitExists(unitID) and UnitIsDeadOrGhost(unitID) then
            deadCount = deadCount + 1
        end
    end

    -- Check party members
    local numPartyMembers = GetNumGroupMembers(LE_PARTY_CATEGORY_HOME)
    for i = 1, numPartyMembers - 1 do -- Subtract 1 to exclude the player themselves
        local unitID = "party" .. i
        checkDeadOrGhost(unitID)
    end

    -- Check raid members
    local numRaidMembers = GetNumGroupMembers(LE_PARTY_CATEGORY_INSTANCE)
    for i = 1, numRaidMembers do
        local unitID = "raid" .. i
        checkDeadOrGhost(unitID)
    end

    return deadCount
end

-- Create a new frame
local frame = CreateFrame("Frame")


















--- Roll the Bones Tracking
--- As buff is "hidden" from the client but we get apply/refresh events for it
do
    local RtBExpiryTime = GetTime()
    function RubimRH.RtBRemains(BypassRecovery)
      local Remains = RtBExpiryTime - GetTime() - HL.RecoveryOffset(BypassRecovery)
      return Remains >= 0 and Remains or 0
    end
  
    HL:RegisterForSelfCombatEvent(
      function(_, _, _, _, _, _, _, _, _, _, _, SpellID)
        if SpellID == 315508 then
          RtBExpiryTime = GetTime() + 30
        end
      end,
      "SPELL_AURA_APPLIED"
    )
    HL:RegisterForSelfCombatEvent(
      function(_, _, _, _, _, _, _, _, _, _, _, SpellID)
        if SpellID == 315508 then
          RtBExpiryTime = GetTime() + math.min(40, 30 + RubimRH.RtBRemains(true))
        end
      end,
      "SPELL_AURA_REFRESH"
    )
    HL:RegisterForSelfCombatEvent(
      function(_, _, _, _, _, _, _, _, _, _, _, SpellID)
        if SpellID == 315508 then
          RtBExpiryTime = GetTime()
        end
      end,
      "SPELL_AURA_REMOVED"
    )
  end
  



-- --- Roll the Bones Tracking
-- --- As buff is "hidden" from the client but we get apply/refresh events for it
-- do
--     local RtBExpiryTime = GetTime()
--     function RubimRH.RtBRemains(BypassRecovery)
--       local Remains = RtBExpiryTime - GetTime() - HL.RecoveryOffset(BypassRecovery)
--       return Remains >= 0 and Remains or 0
--     end
  
--     HL:RegisterForSelfCombatEvent(
--       function(_, _, _, _, _, _, _, _, _, _, _, SpellID)
--         if SpellID == 315508 then
--           RtBExpiryTime = GetTime() + 30
--         end
--       end,
--       "SPELL_AURA_APPLIED"
--     )
--     HL:RegisterForSelfCombatEvent(
--       function(_, _, _, _, _, _, _, _, _, _, _, SpellID)
--         if SpellID == 315508 then
--           RtBExpiryTime = GetTime() + mathmin(40, 30 + RubimRH.RtBRemains(true))
--         end
--       end,
--       "SPELL_AURA_REFRESH"
--     )
--     HL:RegisterForSelfCombatEvent(
--       function(_, _, _, _, _, _, _, _, _, _, _, SpellID)
--         if SpellID == 315508 then
--           RtBExpiryTime = GetTime()
--         end
--       end,
--       "SPELL_AURA_REMOVED"
--     )
--   end


  
-- -- --- Fan the Hammer Tracking
-- -- do
-- --     local OpportunityBuff = Spell(195627)
-- --     local FanCP = 0
-- --     local FanStart = GetTime()
  
-- --     function RubimRH.FanTheHammerCP()
-- --       if (GetTime() - FanStart) < 0.5 and FanCP > 0 then
-- --         if FanCP > Player:ComboPoints() then
-- --           return FanCP
-- --         else
-- --           FanCP = 0
-- --         end
-- --       end
  
-- --       return 0
-- --     end
  
-- --     -- Reset counter on energize
-- --     HL:RegisterForSelfCombatEvent(
-- --       function(_, _, _, _, _, _, _, _, _, _, _, SpellID, _, _, Amount, Over )
-- --         if SpellID == 185763 then
-- --           if (GetTime() - FanStart) > 0.5 then
-- --             -- Subsequent Fan the Hammer procs are reduced by 1 CP
-- --             FanCP = mathmin(RubimRH.CPMaxSpend(), Player:ComboPoints() + Amount + (mathmax(0, Amount - 1) * mathmin(2, Player:BuffStack(OpportunityBuff) - 1)))
-- --             FanStart = GetTime()
-- --           end
-- --         end
-- --       end,
-- --       "SPELL_ENERGIZE"
-- --     )
-- --   end
  




-- -- -- Base Crit Tracker (mainly for Outlaw)
-- -- do
-- --     local BaseCritChance = Player:CritChancePct()
-- --     local BaseCritChecksPending = 0
-- --     local function UpdateBaseCrit()
-- --       if not Player:AffectingCombat() then
-- --         BaseCritChance = Player:CritChancePct()
-- --         HL.Debug("Base Crit Set to: " .. BaseCritChance)
-- --       end
-- --       if BaseCritChecksPending == nil or BaseCritChecksPending < 0 then
-- --         BaseCritChecksPending = 0
-- --       else
-- --         BaseCritChecksPending = BaseCritChecksPending - 1
-- --       end
-- --       if BaseCritChecksPending > 0 then
-- --         C_Timer.After(3, UpdateBaseCrit)
-- --       end
-- --     end
-- --     HL:RegisterForEvent(
-- --       function ()
-- --         if BaseCritChecksPending == 0 then
-- --           C_Timer.After(3, UpdateBaseCrit)
-- --           BaseCritChecksPending = 2
-- --         end
-- --       end,
-- --       "PLAYER_EQUIPMENT_CHANGED"
-- --     )
  
-- --     function RubimRH.BaseAttackCrit()
-- --       return BaseCritChance
-- --     end
-- --   end






























































































































































--- Class DB Saved Var
-- @usage RubimRH.GetClassDB(250, 'VP').Value
function RubimRH.GetClassDB( class, key )
    if type( key ) == "string" then
        key = [[']] .. key .. [[']]
    end
    
    --[[
        if RubimRH.db.profile.selectedProfile then
        local tempStr = "return RubimRH.db.profile.classprofile[".. RubimRH.db.profile.selectedProfile .. "]" .. "[" .. class .. "][" .. key .. "]"
    end--]]
    
    local tempStr = "return RubimRH.db.profile[" .. class .. "][" .. key .. "]"
    local temp = loadstring( tempStr )( )
    
    if not temp then
        RubimRH.Print( "Error: " .. tempStr )
        return
    end
    
    return temp
end


RubimRH.List.PvEInterrupts = {
      
    }
	
	RubimRH.List.MixedInterrupts = {
	   
    }
	
	RubimRH.List.CustomInterrupts = {}




    

 function RangeCount(spellName)
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

 function TargetInRange(spellName)
    if spellName and IsSpellInRange(spellName, "target") == 1 then
        return true
    else
        return false    
    end
end

function target_is_dummy()
    local x = UnitName("target")
    local targetisdummy = false

    if x then
        name = x:sub(-5)
    end

    if Target:Exists() then
        if name == 'Dummy' or name == 'elist' then
            targetisdummy = true
        end
    else
        targetisdummy = false
    end

    return targetisdummy
end

 function AreaTTD()
local currHealth = {}
local currHealthMax = {}
local areaTTD = {}

    for id = 1, 40 do
        local unitID = "nameplate" .. id
        if UnitCanAttack("player", unitID) and UnitAffectingCombat(unitID) 
        and ((UnitHealth(unitID) / UnitHealthMax(unitID)) * 100) < 100 then
            table.insert(currHealth, UnitHealth(unitID))
            table.insert(currHealthMax, UnitHealthMax(unitID))
            if #currHealthMax >= 1 then
                for id = 1, #currHealthMax do
                    dps = (currHealthMax[#currHealth] - currHealth[#currHealth]) / HL.CombatTime("nameplate" .. #currHealthMax)
                    areaTTD[#currHealthMax] = currHealth[#currHealth] / dps
                end
            end
        end
    end
    
    local count = 1
    local highest = 0

    for count = 1, #currHealthMax do
        if areaTTD[count] > highest then 
            highest = areaTTD[count]
        end
        count = count + 1
    end
    
	if highest ~= 0 then
		return highest
	else
		return 9999
	end

end

function TargetTTD()
    local currHealth = {}
    local currHealthMax = {}
    local allGUID = {}
    local areaTTD = {}
    local areaTTD_Predicted = {}
    local areaDPS = {}
    local count = 1
    local highest = 0

    for id = 1, 40 do
        local unitID = "nameplate" .. id
        if UnitCanAttack("player", unitID)
            and ((UnitHealth(unitID) / UnitHealthMax(unitID)) * 100) < 100 then
            if UnitGUID('Target') then
                currTarget = UnitGUID('Target')
            end

            table.insert(allGUID, UnitGUID(unitID))
            table.insert(currHealth, UnitHealth(unitID))
            table.insert(currHealthMax, UnitHealthMax(unitID))

            if #allGUID >= 1 and UnitGUID('Target') then
                while (UnitGUID('Target') ~= allGUID[count]) do
                    count = count + 1
                    break
                end
            end

            if #currHealthMax >= 1 then
                for id = 1, #currHealthMax do
                    dps = (currHealthMax[#currHealth] - currHealth[#currHealth]) /
                        HL.CombatTime("nameplate" .. #currHealthMax)
                    if #currHealthMax ~= count then
                        areaTTD[#currHealthMax] = currHealth[#currHealth] / dps
                        --areaTTD_Predicted[#currHealthMax] = currHealth[#currHealth] / (dps + playerDPS)
                    else
                        areaTTD_Predicted[#currHealthMax] = currHealth[#currHealth] / dps
                    end
                end
            end
        end
    end
    if target_is_dummy() then
        return 8675309
    elseif #currHealthMax >= 1 and areaTTD_Predicted[count] then
        return areaTTD_Predicted[count]
    else
        return 1
    end
end





function kickprio()
    -- list of m+ abilities that should be kicked
    local KickSpells = {

     
        'Hideous Cackle','Decay Surge','Withering Burst','Earthbolt','Infuse Corruption','Decaying Roots','Burst of Decay','Screech','Decay Surge', --BRH
        'Molten Core','Burning Roar','Mending Clay','Melt','Mote of Combustion','Lava Bolt','Molten Army', -- Neltharus
        'Expulse','Demoralizing Shout','Elemental Focus','Dazzle','Pyretic Burst','Cauterize','Refreshing Tide','Boiling Rage','Tidal Divergence','Water Bolt','Aqueous Barrier', -- HoI
        'Spiked Carapace','Stone Spike','Chain Lightning','Stone Bolt','Earthen Ward','Curse of Stone','Sonic Burst','Hasten', -- Uldaman
        'Chronomelt','Infinite Bolt','Enervate','Infinite Bolt Volley','Stonebolt','Pulverizing Creations','Binding Grasp','Displace Chronosequence',
        'Dizzying Sands','Time Beam','Rocket Bolt Volley',--DotI
        'Call of the Flock','Mana Void','Monotonous Lecture', 'Arcane Missiles','Astral Bomb',  -- AA
        'Icebolt','Ice Shield','Cold Claws','Cinderbolt','Lightning Bolt','Crackling Detonation','Thunder Bolt','Flashfire','Shock Blast',       --RLP
        'Mystic Vapors','Erratic Growth','Waking Bane','Condensed Frost','Icy Bindings', --AV
        'Storm Bolt','Disruptive Shout','Disruptive Shout','Stormbolt','Surge','Tempest','Summon Squall','Stormbolt','Thunderstrike','Death Bolt Volley','Death Bolt','Rotting Wind','Swift Wind','Bloodcurdling Shout','Deadly Thunder','Bloodcurdling Shout', -- NO

    }
    local currentspellchannel = select(1,UnitChannelInfo('target'))
    local currentspellcast = select(1, UnitCastingInfo('target'))
    
    for i = 1, #KickSpells do
    if currentspellcast == KickSpells[i] or currentspellchannel == KickSpells[i] then
    return true
    end
    end
    
    return false
    end

    function stunprio()
        local stunspells = {
            'Crushing Smash','Toxic Trap','Bone Bolt','Vicious Clawmangle','Infuse Corruption','Summon Lashers','Decaying Roots','Screech','Bloody Bite','Rotting Surge', --BRH
            'Spiked Carapace','Chain Lightning','Earthen Ward','Curse of Stone','Sonic Burst','Hasten','Throw Rock','Cleave','Hail of Stone','Time Blade',--Uldaman
            'Seismic Slam','Expulse','Demoralizing Shout','Spear Flurry','Elemental Focus','Dazzle','Ice Shard','Refreshing Tide','Thunderstrike','Boiling Rage','Tidal Divergence', --HoI
            'Chronomelt','Infinite Bolt','Enervate','Infinite Bolt Volley','Stonebolt','Pulverizing Creations','Binding Grasp','Displace Chronosequence',
            'Dizzying Sands','Time Beam','Rocket Bolt Volley',--DotI
            'Mystic Blast', 'Monotonous Lecture', 'Arcane Missiles', 'Astral Bomb','Astral Whirlwind',   -- AA
            'Tectonic Slam','Ice Shield','Cold Claws','Burning Ambition','Flame Dance','Thunderclap',       --RLP
            'Piercing Shards','Arcane Fury','Mystic Vapors','Waking Bane','Condensed Frost','Icy Bindings','Ice Cutter','Unstable Power','Tear Flesh','Null Stomp', --AV
            'Storm Bolt','Pierce','Swift Stab','Rally the Clan',"Hunter's Mark",'Hunt Prey','Arcing Strike','Tempest','Summon Squall','Necrotic Eruption','Rotting Wind','Mortal Strike','Swift Wind','Deadly Thunder', -- NO
            'Brutal Strike','Molten Core','Magma Conflagration','Explosive Concoction','Binding Spear','Magma Fist','Fired Up','Bone Toss','Mending Clay','Scorching Breath','Mote of Combustion','Pierce Marrow','Dragonbone Axe', -- neltharus
        }
        
        local currentspellchannel = select(1,UnitChannelInfo('target'))
        local currentspellcast = select(1, UnitCastingInfo('target'))
        
        for i = 1, #stunspells do
            if currentspellcast == stunspells[i] or currentspellchannel == stunspells[i] then
                if UnitName("target") ~= "Sister Briar" and UnitName("target") ~= "Lady Naz'jar" and UnitName("target") ~= "Sister Malady" and UnitName("target") ~= "Sister Solena" then
                    return true
                end
            end
        end
        
        return false
    end
    
    function blindprio()
        local blindspells = {
            'Crushing Smash','Toxic Trap','Bone Bolt','Vicious Clawmangle','Infuse Corruption','Summon Lashers','Decaying Roots','Screech','Bloody Bite','Rotting Surge', --BRH
            'Spiked Carapace','Chain Lightning','Earthen Ward','Curse of Stone','Sonic Burst','Hasten','Throw Rock','Cleave','Hail of Stone','Time Blade',--Uldaman
            'Seismic Slam','Expulse','Demoralizing Shout','Spear Flurry','Elemental Focus','Dazzle','Ice Shard','Refreshing Tide','Thunderstrike','Boiling Rage','Tidal Divergence', --HoI
            'Chronomelt','Infinite Bolt','Enervate','Infinite Bolt Volley','Stonebolt','Pulverizing Creations','Binding Grasp','Displace Chronosequence',
            'Dizzying Sands','Time Beam','Rocket Bolt Volley',--DotI
            'Mystic Blast', 'Monotonous Lecture', 'Arcane Missiles', 'Astral Bomb','Astral Whirlwind',   -- AA
            'Tectonic Slam','Ice Shield','Cold Claws','Burning Ambition','Flame Dance','Thunderclap',       --RLP
            'Piercing Shards','Arcane Fury','Mystic Vapors','Waking Bane','Condensed Frost','Icy Bindings','Ice Cutter','Unstable Power','Tear Flesh','Null Stomp', --AV
            'Storm Bolt','Pierce','Swift Stab','Rally the Clan',"Hunter's Mark",'Hunt Prey','Arcing Strike','Tempest','Summon Squall','Necrotic Eruption','Rotting Wind','Mortal Strike','Swift Wind','Deadly Thunder', -- NO
            'Brutal Strike','Molten Core','Magma Conflagration','Explosive Concoction','Binding Spear','Magma Fist','Fired Up','Bone Toss','Mending Clay','Scorching Breath','Mote of Combustion','Pierce Marrow','Dragonbone Axe', -- neltharus
        }
            
        local currentspellchannel = select(1,UnitChannelInfo('target'))
        local currentspellcast = select(1, UnitCastingInfo('target'))
            
        for i = 1, #blindspells do
            if currentspellcast == blindspells[i] or currentspellchannel == blindspells[i] then
                if UnitName("target") ~= "Sister Briar" and UnitName("target") ~= "Lady Naz'jar" and UnitName("target") ~= "Sister Malady" and UnitName("target") ~= "Sister Solena" then
                    return true
                end
            end
        end
      
        return false
    end

function mitigate()
    if Player:AffectingCombat() then
        for id = 1, 40 do
            local spell = {
                'Decay Spray', 'Gushing Ooze',                                                     --BH
                'Static Surge', 'Hailstorm', "Tempest's Fury", 'Deep Chill', 'Overpowering Croak', 'Inundate',--halls of infusion
                'Magma Eruption', 'Might of the Forge', 'Volatile Mutation', 'Candescent Tempest', -- neltharus
                'Shocking Quake', 'Crushing Stomp', 'Thunderous Clap', 'Wing Buffet',              -- Uldaman
                'Infinite Fury', 'Stonecracker Barrage',--DotI                                                                      
                'Volatile Mutation','Might of the Forge', -- Neltharus
                'Inferno', --RLP
            }
            local unitID = "nameplate" .. id
            local name, text, texture, startTimeMS, endTimeMS, isTradeSkill, castID, notInterruptible, spellId =
                UnitCastingInfo(unitID)
            local spellName, _, _, startTimeMS, endTimeMS = UnitChannelInfo(unitID)

            for idx = 1, #spell do
                if UnitCanAttack("player", unitID) and (name == spell[idx] or spellName == spell[idx]) then
                    return true
                end
            end
        end
    end
    return false
end






function tierequipped()
    local items = {
        "Lurking Specter's Tights",
        "Lurking Specter's Brigandine",
        "Lurking Specter's Handgrips",
        "Lurking Specter's Shoulderblades",
        "Lurking Specter's Visage",
        "Heartfire Sentinel's Forgehelm",
        "Heartfire Sentinel's Steelwings",
        "Heartfire Sentinel's Brigandine",
        "Heartfire Sentinel's Protectors",
        "Heartfire Sentinel's Faulds",

    }

    local count = 0

    for _, itemName in ipairs(items) do
        if IsEquippedItem(itemName) then
            count = count + 1
        end
    end

    return count
end



function tierequipped30()
    local items = {

        "Zealous Pyreknight's Ailettes",
        "Zealous Pyreknight's Barbute",
        "Zealous Pyreknight's Jeweled Guantlets",
        "Zealous Pyreknight's Warplate",
        "Zealous Pyreknight's Cuisses",

    }

    local count = 0

    for _, itemName in ipairs(items) do
        if IsEquippedItem(itemName) then
            count = count + 1
        end
    end

    return count
end


function UseItems()
    
    -- if not Item then Item = {}; end

    -- Item = {
    --     tx1 = Item(118330),
    --     tx2 = Item(114616),
    --     drums = Item(193470),
    --     HPIcon = Item(169451),
    --     HPpotID = Item(191380),
    -- };
    
    -- local I = Item;

    local trinket1 = GetInventoryItemID("player", 13)
    local trinket2 = GetInventoryItemID("player", 14)
    local trinket1ready = IsUsableItem(trinket1) and (GetItemCooldown(trinket1) == 0 and trinket1 ~= 193701 or trinket1 == 193701 and select(2,GetItemCooldown(trinket1)) <1.5) and  IsEquippedItem(trinket1)
    local trinket2ready = IsUsableItem(trinket2) and (GetItemCooldown(trinket2) == 0 and trinket2 ~= 193701 or trinket2 == 193701 and select(2,GetItemCooldown(trinket2)) <1.5) and  IsEquippedItem(trinket2)

    if trinket1ready 
    and (not Player:IsMoving() and (trinket1 == 203963 or trinket1 == 193701) or trinket1 ~= 203963 and trinket1 ~= 193701)
     then
        return Item(118330):Cast()
    end
    if trinket2ready 
    and (not Player:IsMoving() and (trinket2 == 203963 or trinket2 == 193701) or trinket2 ~= 203963 and  trinket2 ~= 193701)
     then
        return Item(114616):Cast()
    end
	
	return nil
end





function GetAppropriateCureSpell()
    local debuffTypePoison = "Poison"
    local debuffTypeDisease = "Disease"
    
    for i = 1, 40 do
        local name, _, _, debuffType = UnitDebuff("player", i)
        if not name then break end  -- No more debuffs, exit the loop

        if debuffType == debuffTypePoison then
            return debuffTypePoison
        elseif debuffType == debuffTypeDisease then
            return debuffTypeDisease
        end
    end
    
    return nil  -- No poison or disease found
end



function GetAppropriateCureSpellfocus()
    local debuffTypePoison = "Poison"
    local debuffTypeDisease = "Disease"
    
    for i = 1, 40 do
        local name, _, _, debuffType = UnitDebuff("focus", i)
        if not name then break end  -- No more debuffs, exit the loop

        if debuffType == debuffTypePoison then
            return debuffTypePoison
        elseif debuffType == debuffTypeDisease then
            return debuffTypeDisease
        end
    end
    
    return nil  -- No poison or disease found
end





function IsReady(spell, range_check, aoe_check)
    local start, duration, enabled = GetSpellCooldown(tostring(spell))
    local usable, noMana = IsUsableSpell(tostring(spell))
    local range_counter = 0

    if duration and start then
        cooldown_remains = tonumber(duration) - (GetTime() - tonumber(start))
        --gcd_remains = 1.5 / (GetHaste() + 1) - (GetTime() - tonumber(start))
    end

    if cooldown_remains and cooldown_remains < 0 then
        cooldown_remains = 0
    end

    -- if gcd_remains and gcd_remains < 0 then
    -- gcd_remains = 0
    -- end

    if aoe_check then
        if Spell then
            for i = 1, 40 do
                local unitID = "nameplate" .. i
                if UnitExists(unitID) then
                    local nameplate_guid = UnitGUID(unitID)
                    local npc_id = select(6, strsplit("-", nameplate_guid))
                    if npc_id ~= '120651' and npc_id ~= '161895' then
                        if UnitCanAttack("player", unitID) and IsSpellInRange(Spell, unitID) == 1 and UnitHealthMax(unitID) > 5 then
                            range_counter = range_counter + 1
                        end
                    end
                end
            end
        end
    end


    -- if usable and enabled and cooldown_remains - gcd_remains < 0.5 and gcd_remains < 0.5 then
    if usable and enabled and cooldown_remains < 0.5 then
        if range_check then
            if IsSpellInRange(tostring(spell), "target") then
                return true
            else
                return false
            end
        elseif aoe_check then
            if range_counter >= aoe_check then
                return true
            else
                return false
            end
        elseif range_check and aoe_check then
            return 'Input range check or aoe check, not both'
        elseif not range_check and not aoe_check then
            return true
        end
    else
        return false
    end
end



  

function combatmobs40()
    local totalRange40 = 0
   
    for id = 1, 40 do
        local unitID = "nameplate" .. id
        if UnitCanAttack("player", unitID) and  RangeCount("Hammer of Wrath")
            and UnitHealthMax(unitID) > 5 and UnitAffectingCombat(unitID) then
            totalRange40 = totalRange40 + 1
        end
    end

    return totalRange40
end



function RangeCount11()
    local range_counter = 0

  
        for i = 1, 40 do
            local unitID = "nameplate" .. i
            if UnitExists(unitID) then
                local nameplate_guid = UnitGUID(unitID)
                local npc_id = select(6, strsplit("-", nameplate_guid))
                if npc_id ~= '120651' and npc_id ~= '161895' then
                    if UnitCanAttack("player", unitID) and CheckInteractDistance(unitID,2) and UnitHealthMax(unitID) > 5 then
                        range_counter = range_counter + 1
                    end
                end
            end
        end
    

    return range_counter
end



function RangeCount10()
    local range_counter = 0

  
        for i = 1, 40 do
            local unitID = "nameplate" .. i
            if UnitExists(unitID) then
                local nameplate_guid = UnitGUID(unitID)
                local npc_id = select(6, strsplit("-", nameplate_guid))
                if npc_id ~= '120651' and npc_id ~= '161895' then
                    if UnitCanAttack("player", unitID) and CheckInteractDistance(unitID,3) and UnitHealthMax(unitID) > 5 then
                        range_counter = range_counter + 1
                    end
                end
            end
        end
    

    return range_counter
end



function combatmobs40()
    local totalRange40 = 0
   


    for id = 1, 40 do
        local unitID = "nameplate" .. id
        if UnitCanAttack("player", unitID) and RangeCount("Avenger's Shield")
            and UnitHealthMax(unitID) > 5 and UnitAffectingCombat(unitID) then
            totalRange40 = totalRange40 + 1
        end
    end


    return totalRange40
end







local initialTotalMaxHealth = 0
local combatStartTime = 0
local inCombat = false

local function getTotalHealthOfCombatMobs()
    local totalMaxHealth = 0
    local totalCurrentHealth = 0

    for i = 1, 40 do
        local unitID = "nameplate" .. i
        if UnitExists(unitID) and UnitCanAttack("player", unitID) and UnitAffectingCombat(unitID) then
            totalMaxHealth = totalMaxHealth + UnitHealthMax(unitID)
            totalCurrentHealth = totalCurrentHealth + UnitHealth(unitID)
        end
    end

    return totalMaxHealth, totalCurrentHealth
end

-- Event Frame for tracking combat state
local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("PLAYER_REGEN_DISABLED") -- Player enters combat
eventFrame:RegisterEvent("PLAYER_REGEN_ENABLED") -- Player leaves combat

eventFrame:SetScript("OnEvent", function(_, event)
    if event == "PLAYER_REGEN_DISABLED" then
        inCombat = true
        combatStartTime = GetTime()
        initialTotalMaxHealth, _ = getTotalHealthOfCombatMobs()
    elseif event == "PLAYER_REGEN_ENABLED" then
        inCombat = false
    end
end)

function getCurrentDPS()
    if inCombat and combatStartTime > 0 then
        local totalMaxHealth, totalCurrentHealth = getTotalHealthOfCombatMobs()
        if totalMaxHealth > initialTotalMaxHealth then
            initialTotalMaxHealth = totalMaxHealth
        end

        local totalDamageDone = initialTotalMaxHealth - totalCurrentHealth
        local combatDuration = GetTime() - combatStartTime
        return math.max(0, totalDamageDone / combatDuration)
    else
        return 0
    end
end



 function aoeTTD()
    local currentDPS = getCurrentDPS()
    local totalCurrentHealth = select(2, getTotalHealthOfCombatMobs())

    if currentDPS and currentDPS > 0 then
        local TTD = totalCurrentHealth / currentDPS
        return TTD
    else
       return 8888
    end
end




function GetFocusTargetHealthPercentage()
    if UnitExists("focus") then
        local health = UnitHealth("focus")
        local maxHealth = UnitHealthMax("focus")
        if maxHealth == 0 then
            return 0
        else
            return (health / maxHealth) * 100
        end
    else
        return nil -- No focus target
    end
end
