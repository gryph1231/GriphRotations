
--- Created by griph.
--- DateTime: 25NOV2022
---
local addonName, HR = ...;

local Cache = HeroCache

HeroRotation = HR;
local HL = HeroLib;
local onEvent = _G.onEvent
local CreateFrame = _G.CreateFrame
HR.Listener = {}
local listeners = {}

local frame = CreateFrame('Frame', 'HR_Events')
frame:SetScript('OnEvent', function(_, event, ...)
    if not listeners[event] then return end
    for k in pairs(listeners[event]) do
        listeners[event][k](...)
    end
end)

function HR.Listener.Add(_, name, event, callback)
    if not listeners[event] then
        frame:RegisterEvent(event)
        listeners[event] = {}
    end
    listeners[event][name] = callback
end

function HR.Listener.Remove(_, name, event)
    if listeners[event] then
        listeners[event][name] = nil
    end
end

function HR.Listener.Trigger(_, event, ...)
    onEvent(nil, event, ...)
end


function HL.GetTime(Reset)
    if not Cache.MiscInfo then Cache.MiscInfo = {} end
    if not Cache.MiscInfo.GetTime or Reset then
      Cache.MiscInfo.GetTime = GetTime()
    end
    return Cache.MiscInfo.GetTime
  end