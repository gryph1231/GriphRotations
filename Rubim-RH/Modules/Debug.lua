---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by Rubim.
--- DateTime: 01/06/2018 02:34
---

local pvpRub = false
local debugRub = false

rotationMode = "Disabled"
local OneTimeRubim = nil

local AceGUI = LibStub("AceGUI-3.0")
-- Create the frame container

function debugGuiShow()
    local debugGUI = AceGUI:Create("Frame")
    debugGUI:SetTitle("Debug - Icon")
    debugGUI:SetStatusText("Rubim")
    debugGUI:SetCallback("OnClose", function(widget)
        AceGUI:Release(widget)
    end)
    -- Fill Layout - the TabGroup widget will fill the whole frame
    debugGUI:SetLayout("List")
    --rogueGUI:SetLayout("Fill")
    debugGUI:SetWidth(400)
    debugGUI:SetHeight(400)

    local label = AceGUI:Create("Label")
    label:SetText("Stuff.")
    debugGUI:AddChild(label)

    local sizeZ = AceGUI:Create("EditBox")
    --sizeZ:GetText(select(1, RubimRH.DebugFrame:GetSize()))
    sizeZ:SetText(select(1, RubimRH.DebugFrame:GetSize()))
    sizeZ:SetLabel("Size Z:")
    sizeZ:SetWidth(300)
    sizeZ:SetCallback("OnEnterPressed", function(widget, event, text)
        RubimRH.DebugFrame:SetSize(text, select(2, RubimRH.DebugFrame:GetSize()))
    end)
    debugGUI:AddChild(sizeZ)
    local sizeX = AceGUI:Create("EditBox")
    --sizeZ:GetText(select(1, RubimRH.DebugFrame:GetSize()))
    sizeX:SetText(select(2, RubimRH.DebugFrame:GetSize()))
    sizeX:SetLabel("Size X:")
    sizeX:SetWidth(300)
    sizeX:SetCallback("OnEnterPressed", function(widget, event, text)
        RubimRH.DebugFrame:SetSize(select(1, RubimRH.DebugFrame:GetSize()), text)
    end)
    debugGUI:AddChild(sizeX)

    local green = AceGUI:Create("EditBox")
    --sizeZ:GetText(select(1, RubimRH.DebugFrame:GetSize()))
    green:SetText(select(1, RubimRH.DebugFrame:GetSize()))
    green:SetLabel("Color:")
    green:SetWidth(300)
    green:SetCallback("OnEnterPressed", function(widget, event, text)
        local r, g, b, a = text:match("([^,]+),([^,]+),([^,]+)")
        RubimRH.DebugFrame.texture:SetColorTexture(r, g, b, a)
    end)
    debugGUI:AddChild(green)

    local debugTexture = AceGUI:Create("EditBox")
    --debugTexture:SetText(select(2, RubimRH.DebugFrame:GetSize()))
    debugTexture:SetLabel("Texture:")
    debugTexture:SetWidth(300)
    debugTexture:SetCallback("OnEnterPressed", function(widget, event, text)
        RubimRH.DebugFrame.texture:SetTexture(text)
    end)
    debugGUI:AddChild(debugTexture)

    debugGUI:Show()
end

if debugRub then
    local dropDown = CreateFrame("FRAME", "DropDownMenu", UIParent, "UIDropDownMenuTemplate")
    dropDown:SetPoint("CENTER")
    dropDown:Hide()
    UIDropDownMenu_SetWidth(dropDown, 200)
    UIDropDownMenu_SetText(dropDown, "Nothing")

    -- Create and bind the initialization function to the dropdown menu
    UIDropDownMenu_Initialize(dropDown, function(self, level, menuList)
        local info = UIDropDownMenu_CreateInfo()
        if (level or 1) == 1 then
            --
            info.text, info.hasArrow = "Open Config", nil
            info.checked = nil
            info.func = function(self)
                PlaySound(891, "Master");
                debugGuiShow()
            end
            UIDropDownMenu_AddButton(info)
            --
            info.text, info.hasArrow = "Position", nil
            info.checked = nil
            info.func = function(self)
                PlaySound(891, "Master");
                local point, _, relativePoint, xOfs, yOfs = RubimRH.DebugFrame:GetPoint()
                print("POSITION: " .. point .. " , " .. relativePoint .. " , " .. xOfs .. " , " .. yOfs)
            end
            UIDropDownMenu_AddButton(info)
        end
    end)

    RubimRH.DebugFrame = CreateFrame("Frame", "DebugFrame")
    RubimRH.DebugFrame:SetBackdrop(nil)
    RubimRH.DebugFrame:SetFrameStrata("TOOLTIP")
    RubimRH.DebugFrame:SetSize(50, 50)
    RubimRH.DebugFrame:SetScale(1);
    RubimRH.DebugFrame:SetPoint("CENTER", 0, 0)
    RubimRH.DebugFrame.texture = RubimRH.DebugFrame:CreateTexture(nil, "TOOLTIP")
    RubimRH.DebugFrame.texture:SetAllPoints(true)
    RubimRH.DebugFrame.texture:SetColorTexture(0, 1, 0, 1.0)

    RubimRH.DebugText = RubimRH.DebugFrame:CreateFontString("DebugText", "OVERLAY")
    RubimRH.DebugText:SetFontObject(GameFontNormalSmall)
    RubimRH.DebugText:SetJustifyH("RIGHT") --
    RubimRH.DebugText:SetPoint("TOP", RubimRH.DebugFrame, "BOTTOM", 100, -100)
    RubimRH.DebugText:SetFont("Fonts\\FRIZQT__.TTF", 20)
    RubimRH.DebugText:SetShadowOffset(1, -1)

    RubimRH.DebugFrame:SetMovable(true)
    RubimRH.DebugFrame:EnableMouse(true)
    RubimRH.DebugFrame:SetScript("OnMouseDown", function(self, button)
        if button == "LeftButton" and not self.isMoving then
            self:StartMoving();
            self.isMoving = true;
        end
    end)
    RubimRH.DebugFrame:SetScript("OnMouseUp", function(self, button)
        if button == "LeftButton" and self.isMoving then
            local arg1, _, arg2, arg3, arg4 = RubimRH.DebugFrame:GetPoint()
            self:StopMovingOrSizing();
            self.isMoving = false;
            local point, _, relativePoint, xOfs, yOfs = RubimRH.DebugFrame:GetPoint()
            print("POSITION: " .. point .. " , " .. relativePoint .. " , " .. xOfs .. " , " .. yOfs)
        end

        if button == "RightButton" then
            ToggleDropDownMenu(1, nil, dropDown, "cursor", 3, -3)
        end
    end)
    RubimRH.DebugFrame:SetScript("OnHide", function(self)
        if (self.isMoving) then
            self:StopMovingOrSizing();
            self.isMoving = false;
        end
    end)

    RubimRH.DebugFrame:SetScript("OnUpdate", function()
        --se tiver com problemas, colocar um delay usando o GetTime()
        --if t - GetTime() <= 0.2 then
        --    local point, _, relativePoint, xOfs, yOfs = RubimRH.DebugFrame:GetPoint()
        --    RubimRH.DebugText:SetText(point .. " , " .. relativePoint .. " , " .. xOfs .. " , " .. yOfs)
        --t = GetTime()
        --		end
    end)
end

--RubimRH.DebugFrame:Hide()


if pvpRub then
    local pvpHelper = CreateFrame("Frame", nil, UIParent)
    local rotationText = pvpHelper:CreateFontString("DebugText", "OVERLAY")
    local healerStuff = pvpHelper:CreateFontString("DebugText3", "OVERLAY")
    pvpHelper:SetFrameStrata("BACKGROUND")
    pvpHelper:SetWidth(150) -- Set these to whatever height/width is needed
    pvpHelper:SetHeight(60) -- for your Texture
    pvpHelper:SetPoint("CENTER", 0, 0)
    pvpHelper.texture = pvpHelper:CreateTexture(nil, "TOOLTIP")
    pvpHelper.texture:SetAllPoints(true)
    pvpHelper.texture:SetColorTexture(0.2, 0.2, 0.2, 0.0)
    --pvpHelper.texture:SetAlpha()

    rotationText:SetFontObject(GameFontNormalSmall)
    rotationText:SetJustifyH("RIGHT") --
    rotationText:SetPoint("TOP", pvpHelper, "TOP", 0, 0)
    rotationText:SetFont("Fonts\\FRIZQT__.TTF", 20)
    rotationText:SetShadowOffset(1, -1)
    rotationText:SetText(rotationMode)

    local t = GetTime()
    pvpHelper:SetScript("OnUpdate", function()
        --se tiver com problemas, colocar um delay usando o GetTime()
        --if t - GetTime() <= 0.2 then
        if rotationMode ~= nil then
            rotationText:SetText(rotationMode)

        end
        --t = GetTime()
        --		end
    end)

    pvpHelper:SetMovable(true)
    pvpHelper:EnableMouse(true)
    pvpHelper:SetScript("OnMouseDown", function(self, button)
        if button == "LeftButton" and not self.isMoving then
            self:StartMoving();
            self.isMoving = true;
        end
    end)
    pvpHelper:SetScript("OnMouseUp", function(self, button)
        if button == "LeftButton" and self.isMoving then
            local arg1, _, arg2, arg3, arg4 = pvpHelper:GetPoint()
            self:StopMovingOrSizing();
            self.isMoving = false;
        end
    end)
    pvpHelper:SetScript("OnHide", function(self)
        if (self.isMoving) then
            self:StopMovingOrSizing();
            self.isMoving = false;
        end
    end)

    pvpHelper:Show()
end