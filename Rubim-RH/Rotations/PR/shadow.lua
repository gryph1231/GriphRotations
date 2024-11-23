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
-- Lua
local pairs = pairs;
local tableconcat = table.concat;
local tostring = tostring;
local tableinsert = table.insert;

if not Spell.Priest then
Spell.Priest = {};
end

RubimRH.Spell[258] = {

--SPELLS GO HERE 
-- https://github.com/herotc/hero-rotation/blob/thewarwithin/HeroRotation_Priest/Priest.lua 
-- is a good resource
















autoattack                             = Spell(33697),

--leave these in here to track drums/lust usage and use spell q macro
lustAT = Spell(155145),
lust1 = Spell(57724),
lust2 = Spell(57723),
lust3 = Spell(80354),
lust4 = Spell(95809),
lust5 = Spell(264689),

}

local S = RubimRH.Spell[258]
local G = RubimRH.Spell[1] -- General Skills




-- Items
if not Item.Priest then Item.Priest = {} end
Item.Priest.Shadow = {

HPIcon = Item(169451), --healing pot icon
drumsoffury = Item(120257),
};
local I = Item.Priest.Shadow;



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
--mob tracking for mobs in combat
local function combatmobs40()
local totalRange40 = 0

for id = 1, 15 do -- Keep this at 15 to limit the checks
local unitID = "nameplate" .. id
if UnitCanAttack("player", unitID) 
and C_Spell.IsSpellInRange("Lightning Bolt", unitID)
and UnitHealthMax(unitID) > 5 
and (UnitAffectingCombat(unitID) or string.sub(UnitName(unitID), -5) == "Dummy") then
totalRange40 = totalRange40 + 1
end
end

return totalRange40
end



local function aoe()

--put AOE rotation here








end



local function st()

--put ST rotation here








end


local function APL()

--these functions are for tracking kicks/cast timers


local startTimeMS = select(4, UnitCastingInfo('target')) or 0
local currentTimeMS = GetTime() * 1000
local elapsedTimeca = (startTimeMS > 0) and (currentTimeMS - startTimeMS) or 0
local castTime = elapsedTimeca / 1000
local startTimeMS = select(4, UnitCastingInfo('target')) or select(4, UnitChannelInfo('target')) or 0
local currentTimeMS = GetTime() * 1000
local elapsedTimech = (startTimeMS > 0) and (currentTimeMS - startTimeMS) or 0
local channelTime = elapsedTimech / 1000

if Target:Exists() and getCurrentDPS() and getCurrentDPS()>0 then
targetTTD = UnitHealth('target')/getCurrentDPS()
else targetTTD = 8888
end


if Player:IsCasting() or Player:IsChanneling() then
return 0, "Interface\\Addons\\Rubim-RH\\Media\\channel.tga"
elseif Player:IsDeadOrGhost() or AuraUtil.FindAuraByName("Drink", "player") or AuraUtil.FindAuraByName("Food", "player") or AuraUtil.FindAuraByName("Food & Drink", "player") then
return 0, "Interface\\Addons\\Rubim-RH\\Media\\griph.tga"
end 

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------SPELL QUEUES-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

if S.lustAT:ID() ==  RubimRH.queuedSpell[1]:ID() and Player:DebuffDown(S.lust1) and Player:DebuffDown(S.lust2) and Player:DebuffDown(S.lust3) and Player:DebuffDown(S.lust4) and Player:DebuffDown(S.lust5) then
return S.lustAT:Cast() -- BIND LUST KEYBIND IN BINDPAD TO ARCANE TORRENT
end

if S.lustAT:ID() ==  RubimRH.queuedSpell[1]:ID() and (Player:DebuffUp(S.lust1) or Player:DebuffUp(S.lust2) or Player:DebuffUp(S.lust3) or Player:DebuffUp(S.lust4) or Player:Debuff(S.lust5)) then
RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
end


if (not IsReady(RubimRH.queuedSpell[1]:ID(),nil,nil,1) or not Player:AffectingCombat() or RangeCount(30) == 0 )
then
RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
end

if IsReady(RubimRH.queuedSpell[1]:ID(),nil,nil,1) then
return RubimRH.QueuedSpell():Cast()
end


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------DEFENSIVES-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--put all your defensives here if you want it to call or just handle manually
if (( Player:AffectingCombat()  or C_Spell.IsCurrentSpell(6603)) and Player:CanAttack(Target)  and not Target:IsDeadOrGhost())  then 

if  Player:HealthPercentage() <= 20  and (IsUsableItem(211880) == true and GetItemCooldown(211880) == 0 and GetItemCount(211880) >= 1 or IsUsableItem(211878) == true and GetItemCooldown(211878) == 0 and GetItemCount(211878) >= 1 or IsUsableItem(211879) == true and GetItemCooldown(211879) == 0 and GetItemCount(211879) >= 1) and (not Player:InArena() and not Player:InBattlegrounds()) then
return I.HPIcon:Cast()
end




--add anything else you want to do top priority in combat -- kicks, handling affix, any other defensives
--always start auto attack
if not C_Spell.IsCurrentSpell(6603) and TargetRange(30) then
    return S.autoattack:Cast()
    end

if (castTime > 0.1 or channelTime > 0.1) and select(8, UnitCastingInfo("target")) == false and RubimRH.InterruptsON() then
--replace with your interrupt and uncomment out
    -- if IsReady("Wind Shear") and targetRange40 and kickprio()  then
    -- return S.WindShear:Cast()
    -- end
    
    end








if aoe() ~= nil and RubimRH.AoEON() and (RangeCount(40)>=2 and not Player:AffectingCombat() or combatmobs40()>=2) and TargetinRange(40) then
return aoe()
end




if st()~= nil and TargetinRange(40) then
return st()
end



end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------OUT OF COMBAT-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--write out of combat rotation here

if not Player:AffectingCombat() then







end




return 0, "Interface\\Addons\\Rubim-RH\\Media\\priest.tga"
end 





RubimRH.Rotation.SetAPL(258, APL);

local function PASSIVE()

end

RubimRH.Rotation.SetPASSIVE(258, PASSIVE);