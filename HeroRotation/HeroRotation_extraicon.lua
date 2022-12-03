local name, addon = ...
HeroRotationExtra = true
-- HeroRotationExtraVer = 01102018
local safeColor = true
local tostring, tonumber, print = tostring, tonumber, print

local function round2(num, idp)
    mult = 10 ^ (idp or 0)
    return math.floor(num * mult + 0.5) / mult
end

function roundscale(num, idp)
    mult = 10 ^ (idp or 0)
    return math.floor(num * mult + 0.5) / mult
end

 HR.topIcons = CreateFrame("Frame", nil, UIParent, "BackdropTemplate")
 HR.topIcons:SetBackdrop(nil)
 HR.topIcons:SetFrameStrata("TOOLTIP")
 HR.topIcons:SetToplevel(true)
 HR.topIcons:SetSize(240, 30) 
 HR.topIcons:SetPoint("TOPLEFT", -29, 12) 
 HR.topIcons.texture =  HR.topIcons:CreateTexture(nil, "OVERLAY")
 HR.topIcons.texture:SetAllPoints(true)
 HR.topIcons.texture:SetColorTexture(0, 0, 0, 0)

if safeColor then
     HR.topIcons.texture:SetColorTexture(0, 0, 0, 1)
end

 HR.topIcons:SetScale(1)
 HR.topIcons:Show(1)

 HR.ccIcon = CreateFrame("Frame", nil,  HR.topIcons, "BackdropTemplate") -- was missed
 HR.ccIcon:SetBackdrop(nil)
 HR.ccIcon:SetSize(1, 1)
 HR.ccIcon:SetPoint("TOPLEFT",  HR.topIcons, 0, 0)
 HR.ccIcon.texture =  HR.ccIcon:CreateTexture(nil, "OVERLAY")
 HR.ccIcon.texture:SetAllPoints(true)
 HR.ccIcon.texture:SetColorTexture(0, 1, 1, 0)
 HR.ccIcon:SetScale(1)
 HR.ccIcon:Show(1)

 HR.kickIcon = CreateFrame("Frame", nil,  HR.topIcons, "BackdropTemplate")
 HR.kickIcon:SetBackdrop(nil)
 HR.kickIcon:SetSize(1, 1)
 HR.kickIcon:SetPoint("TOPLEFT",  HR.topIcons, 30, 0)
 HR.kickIcon.texture =  HR.kickIcon:CreateTexture(nil, "OVERLAY")
 HR.kickIcon.texture:SetAllPoints(true)
 HR.kickIcon.texture:SetColorTexture(0, 1, 1, 0)
 HR.kickIcon:SetScale(1)
 HR.kickIcon:Show(1)

 HR.stIcon = CreateFrame("Frame", nil, HR.topIcons, "BackdropTemplate")
 HR.stIcon:SetBackdrop(nil)
 HR.stIcon:SetSize(30, 30)
 HR.stIcon:SetPoint("TOPLEFT", HR.topIcons, 60, 0) 
 HR.stIcon.texture = HR.stIcon:CreateTexture(nil, "OVERLAY")
 HR.stIcon.texture:SetAllPoints(true)
 HR.stIcon.texture:SetColorTexture(0, 1, 0, 0)
 HR.stIcon:SetScale(1)
 HR.stIcon:Show(1)

 HR.aoeIcon = CreateFrame("Frame", nil,  HR.topIcons, "BackdropTemplate")
 HR.aoeIcon:SetBackdrop(nil)
 HR.aoeIcon:SetSize(30, 30)
 HR.aoeIcon:SetPoint("TOPLEFT",  HR.topIcons, 90, 0) 
 HR.aoeIcon.texture =  HR.aoeIcon:CreateTexture(nil, "OVERLAY")
 HR.aoeIcon.texture:SetAllPoints(true)
 HR.aoeIcon.texture:SetColorTexture(1, 1, 0, 0)
 HR.aoeIcon:SetScale(1)
 HR.aoeIcon:Show(1)

 HR.gladiatorIcon = CreateFrame("Frame", nil,  HR.topIcons, "BackdropTemplate")
 HR.gladiatorIcon:SetBackdrop(nil)
 HR.gladiatorIcon:SetSize(30, 30)
 HR.gladiatorIcon:SetPoint("TOPLEFT",  HR.topIcons, 120, 0) 
 HR.gladiatorIcon.texture =  HR.gladiatorIcon:CreateTexture(nil, "OVERLAY")
 HR.gladiatorIcon.texture:SetAllPoints(true)
 HR.gladiatorIcon.texture:SetColorTexture(0, 0, 1, 0)
 HR.gladiatorIcon:SetScale(1)
 HR.gladiatorIcon:Show(1)

 HR.passiveIcon = CreateFrame("Frame", nil,  HR.topIcons, "BackdropTemplate")
 HR.passiveIcon:SetBackdrop(nil)
 HR.passiveIcon:SetSize(30, 30)
 HR.passiveIcon:SetPoint("TOPLEFT",  HR.topIcons, 150, 0) 
 HR.passiveIcon.texture =  HR.passiveIcon:CreateTexture(nil, "OVERLAY")
 HR.passiveIcon.texture:SetAllPoints(true)
 HR.passiveIcon.texture:SetColorTexture(1, 0, 0, 0)
 HR.passiveIcon:SetScale(1)
 HR.passiveIcon:Show(1)

-- For what these frames here? They have wrong SetPoint anyway
function  HR.Arena1Icon(texture)
     HR.class1Icon.texture:SetTexture(texture)
end

function  HR.Arena2Icon(texture)
     HR.class2Icon.texture:SetTexture(texture)
end

function  HR.Arena3Icon(texture)
     HR.class3Icon.texture:SetTexture(texture)
end
 HR.class1Icon = CreateFrame("Frame", nil,  HR.topIcons, "BackdropTemplate")
 HR.class1Icon:SetBackdrop(nil)
 HR.class1Icon:SetFrameStrata("TOOLTIP")
 HR.class1Icon:SetSize(30, 30)
 HR.class1Icon:SetPoint("TOPLEFT",  HR.topIcons, 121, 0) --12
 HR.class1Icon.texture =  HR.class1Icon:CreateTexture(nil, "OVERLAY")
 HR.class1Icon.texture:SetAllPoints(true)
 HR.class1Icon.texture:SetColorTexture(1, 0, 0, 0)
 HR.class1Icon:SetScale(1)
 HR.class1Icon:Show(1)

 HR.class2Icon = CreateFrame("Frame", nil,  HR.topIcons, "BackdropTemplate")
 HR.class2Icon:SetBackdrop(nil)
 HR.class2Icon:SetFrameStrata("TOOLTIP")
 HR.class2Icon:SetSize(30, 30)
 HR.class2Icon:SetPoint("TOPLEFT",  HR.topIcons, 151, 0) --12
 HR.class2Icon.texture =  HR.class2Icon:CreateTexture(nil, "OVERLAY")
 HR.class2Icon.texture:SetAllPoints(true)
 HR.class2Icon.texture:SetColorTexture(1, 0, 0, 0)
 HR.class2Icon:SetScale(1)
 HR.class2Icon:Show(1)

 HR.class3Icon = CreateFrame("Frame", nil,  HR.topIcons, "BackdropTemplate")
 HR.class3Icon:SetBackdrop(nil)
 HR.class3Icon:SetFrameStrata("TOOLTIP")
 HR.class3Icon:SetSize(30, 30)
 HR.class3Icon:SetPoint("TOPLEFT",  HR.topIcons, 181, 0) --12
 HR.class3Icon.texture =  HR.class3Icon:CreateTexture(nil, "OVERLAY")
 HR.class3Icon.texture:SetAllPoints(true)
 HR.class3Icon.texture:SetColorTexture(1, 0, 0, 0)
 HR.class3Icon:SetScale(1)
 HR.class3Icon:Show(1)

-- HR.arena1.texture:SetColorTexture(0, 0.56, 0) -- Interrupt
-- HR.arena1.texture:SetColorTexture(0.56, 0, 0) -- Interrupt
 HR.arena1 = CreateFrame("Frame", nil,  HR.topIcons, "BackdropTemplate")
 HR.arena1:SetBackdrop(nil)
 HR.arena1:SetFrameStrata("TOOLTIP")
 HR.arena1:SetSize(175, 8)
 HR.arena1:SetPoint("TOPLEFT",  HR.topIcons, 213, -12) --12
 HR.arena1.texture =  HR.arena1:CreateTexture(nil, "OVERLAY")
 HR.arena1.texture:SetAllPoints(true)
 HR.arena1:SetScale(1)
 HR.arena1:Show(1)

 HR.arena12 = CreateFrame("Frame", nil,  HR.topIcons, "BackdropTemplate")
 HR.arena12:SetBackdrop(nil)
 HR.arena12:SetFrameStrata("TOOLTIP")
 HR.arena12:SetSize(8, 8)
 HR.arena12:SetPoint("TOPLEFT",  HR.topIcons, 213, -20) --12
 HR.arena12.texture =  HR.arena12:CreateTexture(nil, "OVERLAY")
 HR.arena12.texture:SetAllPoints(true)
 HR.arena12.texture:SetColorTexture(0, 0, 0, 0)
 HR.arena12:SetScale(1)
 HR.arena12:Show(1)

 HR.arena2 = CreateFrame("Frame", nil,  HR.topIcons, "BackdropTemplate")
 HR.arena2:SetBackdrop(nil)
 HR.arena2:SetFrameStrata("TOOLTIP")
 HR.arena2:SetSize(175, 8)
 HR.arena2:SetPoint("TOPLEFT",  HR.topIcons, 387, -12) --12
 HR.arena2.texture =  HR.arena2:CreateTexture(nil, "OVERLAY")
 HR.arena2.texture:SetAllPoints(true)
 HR.arena2:SetScale(1)
 HR.arena2:Show(1)

 HR.arena22 = CreateFrame("Frame", nil,  HR.topIcons, "BackdropTemplate")
 HR.arena22:SetBackdrop(nil)
 HR.arena22:SetFrameStrata("TOOLTIP")
 HR.arena22:SetSize(8, 8)
 HR.arena22:SetPoint("TOPLEFT",  HR.topIcons, 387, -20) --12
 HR.arena22.texture =  HR.arena22:CreateTexture(nil, "OVERLAY")
 HR.arena22.texture:SetAllPoints(true)
 HR.arena22.texture:SetColorTexture(0, 0, 0, 0)
 HR.arena22:SetScale(1)
 HR.arena22:Show(1)

 HR.arena3 = CreateFrame("Frame", nil,  HR.topIcons, "BackdropTemplate")
 HR.arena3:SetBackdrop(nil)
 HR.arena3:SetFrameStrata("TOOLTIP")
 HR.arena3:SetSize(175, 8)
 HR.arena3:SetPoint("TOPLEFT",  HR.topIcons, 561, -12) --12
 HR.arena3.texture =  HR.arena3:CreateTexture(nil, "OVERLAY")
 HR.arena3.texture:SetAllPoints(true)
 HR.arena3:SetScale(1)
 HR.arena3:Show(1)

 HR.arena32 = CreateFrame("Frame", nil,  HR.topIcons, "BackdropTemplate")
 HR.arena32:SetBackdrop(nil)
 HR.arena32:SetFrameStrata("TOOLTIP")
 HR.arena32:SetSize(8, 8)
 HR.arena32:SetPoint("TOPLEFT",  HR.topIcons, 561, -20) --12
 HR.arena32.texture =  HR.arena32:CreateTexture(nil, "OVERLAY")
 HR.arena32.texture:SetAllPoints(true)
 HR.arena32.texture:SetColorTexture(1, 0, 0, 0)
 HR.arena32:SetScale(1)
 HR.arena32:Show(1)

TargetColor = CreateFrame("Frame", "TargetColor",  HR.topIcons, "BackdropTemplate")
TargetColor:SetBackdrop(nil)
TargetColor:SetFrameStrata("TOOLTIP")
TargetColor:SetSize(1, 1)
TargetColor:SetScale(1)
TargetColor:SetPoint("TOPLEFT",  HR.topIcons, 737, -12)
TargetColor.texture = TargetColor:CreateTexture(nil, "OVERLAY")
TargetColor.texture:SetAllPoints(true)
TargetColor.texture:SetColorTexture(0, 0, 0, 1.0)

local showedOnce = false
local function ScaleFix()
	local resolution
	local DPI = GetScreenDPIScale()
    if GetCVar("gxMaximize") == "1" then 
	-- 	-- Fullscreen (only 8.2+)
	-- 	resolution = tonumber(string.match(GetCVar("gxFullscreenResolution"), "%d+x(%d+)")) --tonumber(strmatch(GetScreenResolutions(), "%dx(%d+)"))
	-- else 
		-- Windowed 
		resolution = select(2, GetPhysicalScreenSize()) --tonumber(string.match(GetCVar("gxWindowedResolution"), "%d+x(%d+)")) 

		-- Regarding Windows DPI
		-- Note: Full HD 1920x1080 offsets (100% X8 Y31 / 125% X9 Y38)
		-- You might need specific thing to get truth relative graphic area, so just contact me if you see this and can't find fix for DPI > 1 e.g. 100%
		if not showedOnce and GetScreenDPIScale() ~= 1 then 
			message("You use not 100% Windows DPI and this can may apply conflicts. Set own X and Y offsets in source.")
		end 
	end 	
	
	local myscale1 = 0.42666670680046 * (1080 / resolution)

     HR.topIcons:SetParent(nil)
     HR.topIcons:SetScale(myscale1) 
	 HR.topIcons:SetFrameStrata("TOOLTIP")
	 HR.topIcons:SetToplevel(true)
	
    if TargetColor then
        if not TargetColor:IsShown() then
            TargetColor:Show()
        end
        TargetColor:SetScale((0.71111112833023 * (1080 / resolution)) / (TargetColor:GetParent() and TargetColor:GetParent():GetEffectiveScale() or 1))
    end    
end

local function UpdateCVAR()
    if GetCVar("Contrast")~="50" then 
		SetCVar("Contrast", 50)
		print("Contrast should be 50")		
	end
    if GetCVar("Brightness")~="50" then 
		SetCVar("Brightness", 50) 
		print("Brightness should be 50")			
	end
    if GetCVar("Gamma")~="1.000000" then 
		SetCVar("Gamma", "1.000000") 
		print("Gamma should be 1")	
	end
    if GetCVar("colorblindsimulator")~="0" then SetCVar("colorblindsimulator", 0) end; 
    -- Not neccessary
    if GetCVar("RenderScale")~="1" then SetCVar("RenderScale", 1) end; 
	--[[
    if GetCVar("MSAAQuality")~="0" then SetCVar("MSAAQuality", 0) end;
    -- Could effect bugs if > 0 but FXAA should work, some people saying MSAA working too 
	local AAM = tonumber(GetCVar("ffxAntiAliasingMode"))
    if AAM > 2 and AAM ~= 6 then 		
		SetCVar("ffxAntiAliasingMode", 0) 
		print("You can't set higher AntiAliasing mode than FXAA or not equal to MSAA 8x")
	end
	]]
    if GetCVar("doNotFlashLowHealthWarning")~="1" then SetCVar("doNotFlashLowHealthWarning", 1) end; 
    -- WM removal
    if GetCVar("screenshotQuality")~="10" then SetCVar("screenshotQuality", 10) end;    
    -- UNIT_NAMEPLAYES_AUTOMODE (must be visible)
    if GetCVar("nameplateShowAll")=="0" then
        SetCVar("nameplateShowAll", 1)
		print("All nameplates should be visible")
    end
    if GetCVar("nameplateShowEnemies")~="1" then
        SetCVar("nameplateShowEnemies", 1) 
        print("Enemy nameplates should be enabled")
    end
end

local function ConsoleUpdate()
    UpdateCVAR()  
	ScaleFix()    
end 


 HR.Listener:Add('HR_Events', 'PLAYER_ENTERING_WORLD', ConsoleUpdate)
 HR.Listener:Add('HR_Events', 'UI_SCALE_CHANGED', ConsoleUpdate)
 HR.Listener:Add('HR_Events', 'DISPLAY_SIZE_CHANGED', ConsoleUpdate)
--VideoOptionsFrame:HookScript("OnHide", ConsoleUpdate)
--InterfaceOptionsFrame:HookScript("OnHide", UpdateCVAR)