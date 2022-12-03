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
local HeroRotation = HR;

local HL = HeroLib;
local Cache = HeroCache;
local Unit = HL.Unit;
local Player = Unit.Player;
local Target = Unit.Target;
local Spell = HL.Spell;
local Item = HL.Item;

--- ============================   CUSTOM   ============================


local movedTimer = 0
function HR.lastMoved()
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

function HR.lastSwing()
    if lastMeleeHit > 0 then
        return GetTime() - lastMeleeHit
    end
    return 0
end

function HR.getLastDamage()
    return damageInLast3Seconds
end

function HR.clearLastDamage()
    damageInLast3Seconds = 0
end

function HR.LastDamage()
    local IncomingDPS = (damageInLast3Seconds / UnitHealthMax("player")) * 100
    return (math.floor((IncomingDPS * ((100) + 0.5)) / (100)))
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

