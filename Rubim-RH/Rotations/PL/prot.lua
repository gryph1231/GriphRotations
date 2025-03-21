--- ============================ HEADER ============================
--- ======= LOCALIZE =======
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

--- ============================ CONTENT ===========================
--- ======= APL LOCALS =======
-- luacheck: max_line_length 9999

-- Spells
RubimRH.Spell[66] = {
-- 42422
Repentance = Spell(20066),
TurnEvil = Spell(10326),
SanctificationBuff                    = Spell(424616), -- T31, 2pc
SanctificationEmpowerBuff             = Spell(424622), -- T31, 2pc
BulwarkofRighteousFury                = Spell(386653),

BulwarkofRighteousFuryBuff            = Spell(386652),
Sentinel = Spell(389539),
BlessingofFreedom           = Spell(1044),
BlindingLight               = Spell(115750),
-- SenseUndead                 = Spell(5502),
SacredWeapon                         = Spell(432472),
SacredWeaponBuff                     = Spell(432502),
CleanseToxins               = Spell(213644),
autoattack                  = Spell(291944), -- regeneratin
BlessedAssuranceBuff                 = Spell(433019),
tempestofthelightbringer    = Spell(383396),

DivineSteedBuff             = Spell(221883),
BlessingofProtection        = Spell(1022),
Forbearance                 = Spell(25771),
-- Racials
AncestralCall               = Spell(274738),
ArcanePulse                 = Spell(260364),
ArcaneTorrent               = Spell(155145),
BagofTricks                 = Spell(312411),
LightsGuidance = Spell(427445),
LightsDeliverance                    = Spell(425518),

Berserking                  = Spell(26297),
BloodFury                   = Spell(20572),
-- Fireblood                             = Spell(265221),
GiftoftheNaaru              = Spell(59542),
-- Abilities
ShiningLightFreeBuff                  = Spell(327510),
RighteousProtector                    = Spell(204074),

InmostLight                           = Spell(405757),
MomentofGloryBuff                     = Spell(327193),
FinalStand                  = Spell(204077),
Consecration                = Spell(26573),
CrusaderStrike              = Spell(35395),


Redoubt                               = Spell(280373),
RedoubtBuff                           = Spell(280375),

DivineShield                = Spell(642),
DivineSteed                 = Spell(190784),
FlashofLight                = Spell(19750),
HammerofJustice             = Spell(853),
DivineGuidanceBuff                   = Spell(433106),
Sanctuary = Spell(379021),
HandofReckoning             = Spell(62124),
Rebuke                      = Spell(96231),
ShieldoftheRighteous        = Spell(53600),
WordofGlory                 = Spell(85673),
RefiningFire                          = Spell(469883),

-- Talents
AvengingWrath               = Spell(31884),
HolyBulwark = Spell(432459),
HammerofWrath               = Spell(24275),
HolyAvenger                 = Spell(105809),
HammerofLight = Spell(427453),
HoL = Spell(427445),
HolyAvengerBuff             = Spell(105809),
LayonHands                  = Spell(633),
ShaketheHeavens                      = Spell(431533),
-- Buffs
LightsDeliveranceBuff                = Spell(433674),
ShaketheHeavensBuff                  = Spell(431536),

-- Covenants (Shadowlands)
BlessingofFreedomfocus = Spell(145067),-- turn evil

-- DivineTollCov                         = Spell(304971),
DoorofShadows               = Spell(300728),
HammerandAnvil                       = Spell(433718),

Fleshcraft                  = Spell(324631),
Soulshape                   = Spell(310143),
SummonSteward               = Spell(324739),
VanquishersHammer           = Spell(328204),
VanquishersHammerBuff       = Spell(328204),
-- Soulbinds/Conduits (Shadowlands)
Expurgation                 = Spell(339371),
PustuleEruption             = Spell(351094),
VengefulShock               = Spell(340006),
VengefulShockDebuff         = Spell(340007),
VolatileSolvent             = Spell(323074),
VolatileSolventHumanBuff    = Spell(323491),
-- Auras
ConcentrationAura           = Spell(317920),
CrusaderAura                = Spell(32223),
DevotionAura                = Spell(465),
OfDuskandDawn                         = Spell(409441),

RetributionAura             = Spell(183435),
-- Buffs
BlessingofSpellwarding = Spell(204018),
Intercession                = Spell(391054),
intercession                = Spell(59752),--will to survive human racial
-- trinket                     = Spell(59547), -- gift of narru
CleanseToxinsFocus = Spell(20594), --stone form
WordofGloryFocus = Spell(215652), --shield of virtue
BlessingofProtectionFocus = Spell(5502),-- sense undead
BlessingofSacrifice = Spell(6940),
--/cast [@focus] Blessing of Sacrifice - use BoS KB
LayonHandsFocus = Spell(32223),--crusader aura
-- /cast [@focus,exists]Blessing of Freedom;Blessing of Freedom
-- bind to turn evil GGL
-- /cast [@focus] Cleanse Toxins
-- bind to stone form GGL
-- /cast [@focus] word of glory
-- bind to shield of virtue GGL
-- /cast [@focus] Blessing of Protection
-- bind to sense undead GGL
-- /cast [@focus] Lay on Hands
-- bind to crusader aura GGL
BastionofLightBuff                    = Spell(378974),
BlessingofDawnBuff                    = Spell(385127),
BlessingofDuskBuff                    = Spell(385126),
AvengingWrathBuff           = Spell(31884),
ConsecrationBuff            = Spell(188370),
DivinePurposeBuff           = Spell(223819),
ScarsofFraternalStrifeBuff4 = Spell(368638),
ShieldoftheRighteousBuff    = Spell(132403),
TemptationBuff              = Spell(234143),
-- Debuffs
CruelGarroteDebuff          = Spell(230011),
-- Legendary Effects
DivineResonanceBuff         = Spell(355455),
FinalVerdictBuff            = Spell(337228),
-- Pool

Entangled = Spell(408556),
-- Pool                                  = Spell(999910),
Pool = Spell(397799),

deepchill = Spell(391634),
--thunderous drums buff spell id 444257
HSicon = Spell(255647),--lights judgment
lust1    = Spell(57724),
lust2    = Spell(57723),
lust3    = Spell(80354),
lust4    = Spell(95809),
lust5    = Spell(264689),
lustAT   = Spell(20549), -- war stomp
EmpoweredConsecration = Spell(424622),
EyeofTyr = Spell(387174),
FrostShock = Spell(385963),
IcyBindings = Spell(377488),

ArdentDefender         = Spell(31850),
AvengersShield         = Spell(31935),
GuardianofAncientKings = Spell(86659),

HammeroftheRighteous   = Spell(53595),
Judgment               = Spell(275779),
JudgmentDebuff         = Spell(197277),
ShiningLightBuff           = Spell(327510),
ShiningLightBuffStack           = Spell(182104),
-- Talents
BlessedHammer          = Spell(204019),
CrusadersJudgment      = Spell(204023),
MomentofGlory          = Spell(327193),
SanctifiedWrath        = Spell(171648),
DivineToll             = Spell(375576),



BastionofLight = Spell(378974),



};
local S = RubimRH.Spell[66];

S.EyeofTyr.TextureSpellID = { 209202 }
S.DivineToll.TextureSpellID = { 304971 }





-- Items
if not Item.Paladin then
Item.Paladin = {}
end
Item.Paladin.Protection = {

HPIcon = Item(169451),
drums = Item(219905),

};
local I = Item.Paladin.Protection;



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


local function HPGTo2Dawn()
  if not S.OfDuskandDawn:IsAvailable() then return -1 end
  return 6 - GetCurrentHPGCount() - (Player:BuffStack(S.BlessingofDawnBuff) * 3)
end





local function APL()
inRange5 = RangeCount(5)
inRange8 = RangeCount(8)
inRange10 = RangeCount(10)
inRange15 = RangeCount(15)
inRange20 = RangeCount(20)
inRange25 = RangeCount(25)
inRange30 = RangeCount(30)
targetRange5 = C_Item.IsItemInRange(8149, "target")
targetRange8 = C_Item.IsItemInRange(34368, "target")
targetRange10 = C_Item.IsItemInRange(32321, "target")
targetRange15 = C_Item.IsItemInRange(33069, "target")
targetRange20 = C_Item.IsItemInRange(10645, "target")
targetRange25 = C_Item.IsItemInRange(24268, "target")
targetRange30 = C_Item.IsItemInRange(835, "target")
TrackHealthLossPerSecond()

HPpercentloss = GetHealthLossPerSecond()

-- print(Player:SpellHaste())
-- print(aoeTTD())

if Player:IsChanneling() or Player:IsCasting() then
return 0, "Interface\\Addons\\Rubim-RH\\Media\\channel.tga"
end

local iconEoT = C_Spell.GetSpellInfo(387174).iconID



if iconEoT == 5342121 then
canCastHoL = true
else
canCastHoL = false
end

local lostimer = GetTime() - losCheckTimer
local los

if lostimer < Player:GCD() then
los = true
else
los = false
end




if not IsReady("Intercession",nil,nil,1,1) or not UnitIsDeadOrGhost("focus") or rezcharges==0 or S.Intercession:TimeSinceLastCast()<=10 or timesincefocusdeath()<=2 then
  NoIntercession = true
else
  NoIntercession = false
end

local isTanking, status, threatpct, rawthreatpct, threatvalue = UnitDetailedThreatSituation("player", "target")
local inInstance, instanceType = IsInInstance()

-- local level, affixIDs, wasEnergized = C_ChallengeMode.GetActiveKeystoneInfo()
-- local highkey = 2

local castchannelTime = math.random(250, 500) / 1000

local startTimeMS = select(4, UnitCastingInfo('target')) or 0
local currentTimeMS = GetTime() * 1000
local elapsedTimeca = (startTimeMS > 0) and (currentTimeMS - startTimeMS) or 0
local castTime = elapsedTimeca / 1000
local startTimeMS = select(4, UnitCastingInfo('target')) or select(4, UnitChannelInfo('target')) or 0
local currentTimeMS = GetTime() * 1000
local elapsedTimech = (startTimeMS > 0) and (currentTimeMS - startTimeMS) or 0
local channelTime = elapsedTimech / 1000
isEnraged = (AuraUtil.FindAuraByName("Enrage", "target") or UnitChannelInfo("target") == "Ragestorm" or AuraUtil.FindAuraByName("Frenzy", "target"))

WordofGlorycast = (AuraUtil.FindAuraByName("Divine Purpose", "player") or Player:BuffUp(S.ShiningLightFreeBuff) or AuraUtil.FindAuraByName("Bastion of Light", "player"))

if UnitClassification("target") == "worldboss"
or UnitClassification("target") == "rareelite"
or UnitClassification("target") == "elite"
or UnitClassification("target") == "rare"
or Target:IsAPlayer() then
elite = true
else
elite = false
end

local spellname, _, _, _, _, _, _, _, _ = UnitCastingInfo("target")
if spellname == "Icy Shard" and Player:HealthPercentage()<70  then
  mitigateNWBoss = true
else
  mitigateNWBoss = false
end


if  (spellname == "Oblivion Wave" or spellname == "Charged Shield" or spellname == "Lava Fist" or spellname =="Crush" or spellname =="Terrifying Slam" or spellname =="Subjugate" or spellname =="Oozing Smash" or spellname =="Obsidian Beam" or spellname =="Igneous Hammer" or spellname =="Void Corruption" or spellname =="Shadowflame Slash") then
  MagicTankBuster = true
else
  MagicTankBuster = false
end

if select(1,UnitChannelInfo('target')) == "Molten Flurry" then
  mitigateGBBoss = true
else
  mitigateGBBoss = false
end






if S.Intercession:Charges()== nil or S.Intercession:CooldownRemains()>Player:GCD() then
rezcharges = 0
else
rezcharges=S.Intercession:Charges()
end

if Target:Exists() and getCurrentDPS() and getCurrentDPS()>0 then
targetTTD = UnitHealth('target')/getCurrentDPS()
else targetTTD = 8888
end


local targetdying = (aoeTTD() < 5 or targetTTD<5)


aoerangecheck = (inRange10>=1 and not Player:IsMoving() or inRange8>=1  and Player:IsMoving())

local currentSpeed, runSpeed, flightSpeed, swimSpeed = GetUnitSpeed("player")

-- BASE_MOVEMENT_SPEED is 7 yards per second (default unmounted ground speed)
local baseSpeed = 7

-- Convert speeds to percentage relative to base movement speed
local speedPercent = (currentSpeed / baseSpeed) * 100

local slowThreshold = 90
if speedPercent < slowThreshold and Player:IsMoving() then
    freedomme = true
else
    freedomme = false
end


if ( Player:BuffRemains(S.ShieldoftheRighteousBuff)<Player:GCD() or (Player:HolyPower()>=5 or Player:BuffRemains(S.ShieldoftheRighteousBuff)<13-Player:GCD()*4 or not Player:BuffUp(S.ShiningLightFreeBuff) and Player:BuffStack(S.ShiningLightBuffStack)==2 and Player:HealthPercentage()<60) and not IsReady(427453,1)) and (targetRange8 or inRange8>=1)  then
  useSoTR = true
else
  useSoTR = false
end

-- if AuraUtil.FindAuraByName("Shield of the Righetous", "target", "PLAYER|HARMFUL") then
--   shieldoftherighteousdebuffremains = select(6, AuraUtil.FindAuraByName("Shield of the Righetous", "target", "PLAYER|HARMFUL")) - GetTime()
-- else
--   shieldoftherighteousdebuffremains = 0
-- end

local useAD = not AuraUtil.FindAuraByName("Divine Shield", "player") and not AuraUtil.FindAuraByName("Eye of Tyr","target","PLAYER|HARMFUL") and not AuraUtil.FindAuraByName("Guardian of Ancient Kings", "player") and not AuraUtil.FindAuraByName("Blessing of Spellwarding", "player")
local useDS = not AuraUtil.FindAuraByName("Ardent Defender", "player") and not AuraUtil.FindAuraByName("Eye of Tyr","target","PLAYER|HARMFUL") and not AuraUtil.FindAuraByName("Guardian of Ancient Kings", "player") and not AuraUtil.FindAuraByName("Blessing of Spellwarding", "player")
local useGoAK = not AuraUtil.FindAuraByName("Divine Shield", "player") and not AuraUtil.FindAuraByName("Guardian of Ancient Kings", "player") and not AuraUtil.FindAuraByName("Eye of Tyr","target","PLAYER|HARMFUL") and not AuraUtil.FindAuraByName("Ardent Defender", "player") and not AuraUtil.FindAuraByName("Blessing of Spellwarding", "player")
local useEoT = not AuraUtil.FindAuraByName("Divine Shield", "player") and not AuraUtil.FindAuraByName("Ardent Defender", "player") and not AuraUtil.FindAuraByName("Guardian of Ancient Kings", "player") and not AuraUtil.FindAuraByName("Blessing of Spellwarding", "player")
local useBoSW = not AuraUtil.FindAuraByName("Divine Shield", "player") and not AuraUtil.FindAuraByName("Ardent Defender", "player") and not AuraUtil.FindAuraByName("Guardian of Ancient Kings", "player") and not AuraUtil.FindAuraByName("Eye of Tyr","target","PLAYER|HARMFUL")


if S.Intercession:ID() == RubimRH.queuedSpell[1]:ID() and (not S.Intercession:CooldownUp() or partyOrRaidDead() == 0 or rezcharges==0) then
RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
end

if S.HammerofJustice:ID() == RubimRH.queuedSpell[1]:ID() and (not Target:Exists() or not Player:CanAttack(Target)) then
RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
end



if S.lustAT:ID() == RubimRH.queuedSpell[1]:ID()
and Player:DebuffDown(S.lust1) and Player:DebuffDown(S.lust2) and Player:CanAttack(Target) and GetItemCount(219905) >= 1 and 
Player:DebuffDown(S.lust3) and Player:DebuffDown(S.lust4) and Player:DebuffDown(S.lust5) and (I.drums:IsReady()) then
return S.lustAT:Cast() -- BIND LUST KEYBIND IN BINDPAD TO ARCANE TORRENT
end

if S.lustAT:ID() == RubimRH.queuedSpell[1]:ID() and
(
Player:DebuffUp(S.lust1) or Player:DebuffUp(S.lust2) or Player:DebuffUp(S.lust3) or Player:DebuffUp(S.lust4) or
Player:DebuffUp(S.lust5)) then
RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
end


if S.FlashofLight:ID() == RubimRH.queuedSpell[1]:ID() and Player:IsMoving() then
RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
end

if S.DivineShield:ID() == RubimRH.queuedSpell[1]:ID() and Player:DebuffUp(S.Forbearance) then
RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
end
if S.BlessingofProtection:ID() == RubimRH.queuedSpell[1]:ID() and (Player:DebuffUp(S.Forbearance) or not S.BlessingofProtection:IsAvailable()) then
RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
end
if S.LayonHands:ID() == RubimRH.queuedSpell[1]:ID() and Player:DebuffUp(S.Forbearance) then
RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
end

if S.DivineSteed:ID() == RubimRH.queuedSpell[1]:ID() and AuraUtil.FindAuraByName("Divine Steed", "player") then
RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
end
if S.Intercession:ID() == RubimRH.queuedSpell[1]:ID() and IsReady("Intercession") and rezcharges>=1 then
return S.intercession:Cast()
  end

  if S.AvengersShield:ID() == RubimRH.queuedSpell[1]:ID() and (not IsReady("Avenger's Shield") or not Target:Exists() or not Player:CanAttack(Target) or Target:IsDeadOrGhost()) then
    RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
      end
    
if IsReady(RubimRH.queuedSpell[1]:ID(),nil,nil,1) then
return RubimRH.QueuedSpell():Cast()
end

if (not IsReady(RubimRH.queuedSpell[1]:ID(),nil,nil,1) or (inRange30 == 0 or not Target:Exists()) and S.Consecration:ID() ~= RubimRH.queuedSpell[1]:ID()) then
  RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
  end

        --- seasonal affix
        if targetRange8 and TWWS1AffixMobsInRange()>=6 and IsReady("Blinding Light") and RubimRH.InterruptsON() then
          return S.BlindingLight:Cast()
          end
      if targetRange8 and TWWS1AffixMobsInRange()>=6 and IsReady("Arcane Torrent") and RubimRH.InterruptsON() then
        return S.ArcaneTorrent:Cast()
        end
--DEFENSIVES---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
if Player:AffectingCombat() and inRange20>=1 then

  --health pot -- will need to update item ID of HPs as expansions progress
  if  Player:HealthPercentage() <= 20 and not Player:BuffUp(S.DivineShield) and (IsUsableItem(211880) == true and GetItemCooldown(211880) == 0 and GetItemCount(211880) >= 1 or IsUsableItem(211878) == true and GetItemCooldown(211878) == 0 and GetItemCount(211878) >= 1 or IsUsableItem(211879) == true and GetItemCooldown(211879) == 0 and GetItemCount(211879) >= 1) and (not Player:InArena() and not Player:InBattlegrounds()) then
  return I.HPIcon:Cast()
  end
  
  --abnout to die need heals or immunity
  if IsReady("Divine Shield") and Player:HealthPercentage() < 20 then
  return S.DivineShield:Cast()
  end
  
  if IsReady("Lay on Hands") and Player:HealthPercentage() < 20 and S.DivineShield:CooldownDown() then
  return S.LayonHands:Cast()
  end


  if IsReady("Blessing of Spellwarding") and (MagicTankBuster or magicdefensives() or AuraUtil.FindAuraByName("Honey Marinade", "player", "HARMFUL") ) and useBoSW then
    return S.BlessingofSpellwarding:Cast()
    end

  
  if  mitigateboss() or mitigateNWBoss or mitigateGBBoss or mitigatedng() then 
  

    if IsReady("Blessing of Spellwarding") and useBoSW  and ( MagicTankBuster or AuraUtil.FindAuraByName("Honey Marinade", "player", "HARMFUL")) then
      return S.BlessingofSpellwarding:Cast()
      end

  if IsReady("Guardian of Ancient Kings") and useGoAK  then
  return S.GuardianofAncientKings:Cast()
  end

    
  if IsReady("Ardent Defender")  and useAD then
    return S.ArdentDefender:Cast()
    end
    
  
  if IsReady("Divine Shield")  and S.FinalStand:IsAvailable() and useDS then
  return S.DivineShield:Cast()
  end
  

  if IsReady("Eye of Tyr")  and targetRange8 and useEoT then
  return S.EyeofTyr:Cast()
  end



  
  end
  
  --actively use defensives if not on a boss with tank busters or if key is low -- basically want to make sure defensives are being used 
  --during boss encounters with tank busters and low key if health is dropping (probably some chaos pulling going on in to the boss in this scenario) 
  if Player:AffectingCombat() then

  
  if IsReady("Guardian of Ancient Kings") 
  and (HPpercentloss > 12
  and Player:HealthPercentage() < 60 or Player:HealthPercentage() < 45)
  and useGoAK then
  return S.GuardianofAncientKings:Cast()
  end
  
  if IsReady("Ardent Defender")
  and (HPpercentloss > 12
  and Player:HealthPercentage() <65 or Player:HealthPercentage() < 50)
  and  useAD then
  return S.ArdentDefender:Cast()
  end
  

  if IsReady("Divine Shield")  and S.ArdentDefender:CooldownDown() and S.GuardianofAncientKings:CooldownDown() and S.FinalStand:IsAvailable()
  and (HPpercentloss > 12
  and Player:HealthPercentage() < 40 or Player:HealthPercentage() < 30)
  and useDS then
  return S.DivineShield:Cast()
  end
  

  if IsReady("Eye of Tyr")  and S.ArdentDefender:CooldownDown() and S.GuardianofAncientKings:CooldownDown() and Player:HolyPower()<=2 and S.LightsGuidance:IsAvailable() and targetRange8 and useEoT and (HPpercentloss > 10 and Player:HealthPercentage()<70 or Player:HealthPercentage()<55) then
    return S.EyeofTyr:Cast()
    end
  end
  
  if NoIntercession then
  
  --  if about to die and shield up
  if IsReady("Word of Glory") and not IsReady(427453,1) and Player:HealthPercentage()<60 and (Player:BuffUp(S.DivinePurposeBuff) or Player:BuffUp(S.ShiningLightFreeBuff) or Player:BuffRemains(S.ShieldoftheRighteousBuff)>=5 or Player:BuffRemains(S.DivineShield)>=5 or inRange8 == 0 and Player:IsMoving()) then
    return S.WordofGlory:Cast() 
    end
  
    if IsReady("Shield of the Righteous") and (Player:HealthPercentage()<90 and Player:BuffRemains(S.ShieldoftheRighteousBuff)<3 or Player:HolyPower()>=5 and not IsReady(427453,1)) and (targetRange10 or inRange10>=1) then
    return S.ShieldoftheRighteous:Cast()
    end
  end
  

  
  end
  

--KICKS STUNS and BLINDS---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
if (castTime > 0.5 or channelTime > 0.5) and select(8, UnitCastingInfo("target")) == false and RubimRH.InterruptsON() and not isEnraged and UnitExists("target") and Player:CanAttack(Target) and not Target:IsDeadOrGhost() then
  -- -- kick on GCD
  -- if IsReady("Divine Toll") and targetRange30 and RubimRH.CDsON() and (kickprio() or Target:IsAPlayer() or UnitName("target") == "Orb of Ascendance") and (S.AvengersShield:CooldownRemains() > Player:GCD() or inRange20>=3) then
  --   return S.DivineToll:Cast()
  --   end
  -- kick on GCD
  if IsReady("Avenger's Shield") and not IsReady("Rebuke",1) and targetRange30 and (kickprio() or Target:IsAPlayer() or UnitName("target") == "Orb of Ascendance") and (S.DivineToll:CooldownRemains() > Player:GCD() or not RubimRH.CDsON()) then
  return S.AvengersShield:Cast()
  end
  
  -- kick on GCD
  if IsReady("Rebuke") and targetRange5 and (kickprio() or Target:IsAPlayer() or UnitName("target") == "Orb of Ascendance" ) and Player:GCDRemains()<0.5 then
  return S.Rebuke:Cast()
  end
  
  --Stun
  if IsReady("Hammer of Justice") and targetRange10 and (stunprio() or Target:IsAPlayer() or UnitName("target") == "Orb of Ascendance") then
  return S.HammerofJustice:Cast()
  end
  
  --Blind
  if targetRange10 and IsReady("Blinding Light")  and inRange8 >= 1 and (blindprio() or Target:IsAPlayer()) then
  return S.BlindingLight:Cast()
  end
  end
  



------PRINCESS FUNCTION------------------------------------------------------------------------------------------------------------------------------------------------
------PRINCESS FUNCTION------------------------------------------------------------------------------------------------------------------------------------------------
------PRINCESS FUNCTION------------------------------------------------------------------------------------------------------------------------------------------------

  if los == false and UnitExists('focus') and (C_Spell.IsSpellInRange("Flash of Light", "focus") or C_Spell.IsSpellInRange("Intercession", "focus")) then 

if IsReady("Intercession",nil,nil,1,1) and UnitIsDeadOrGhost("focus") and rezcharges>=1 and S.Intercession:TimeSinceLastCast()>10 then
  if IsReady("Intercession") and timesincefocusdeath()>2 then
  return S.intercession:Cast()
  elseif Player:HolyPower() < 3 then
  if IsReady("Judgment",1) then
  return S.Judgment:Cast()
  end
  
  if IsReady("Hammer of Wrath",1) then
  return S.HammerofWrath:Cast()
  end
  
  if IsReady("Blessed Hammer") and S.BlessedHammer:Charges()>=1  then
  return S.BlessedHammer:Cast()
  end
  end
  end

    if IsReady("Intercession") and UnitIsDeadOrGhost("focus") and rezcharges>=1 and S.Intercession:TimeSinceLastCast()>10 then
    return S.intercession:Cast()
    end

    if IsReady("Lay on Hands") and not UnitIsDeadOrGhost("focus") and Player:GCDRemains()<0.5 and GetFocusTargetHealthPercentage()<30 and not AuraUtil.FindAuraByName("Forbearance", "focus", "HARMFUL") then
    return S.LayonHandsFocus:Cast()
    end
    if IsReady("Blessing of Protection") and not AuraUtil.FindAuraByName("Blessing of Sacrifice", "focus", "HARMFUL") and not UnitIsDeadOrGhost("focus") 
     and (AuraUtil.FindAuraByName("Raging Gaze", "focus", "HARMFUL")  or  GetFocusTargetHealthPercentage()<50 and inRange30>2 
     or AuraUtil.FindAuraByName("Morbid Fixation", "focus", "HARMFUL") and inRange30>=1) and not AuraUtil.FindAuraByName("Forbearance", "focus", "HARMFUL") then
    return S.BlessingofProtectionFocus:Cast()
    end
    if IsReady("Blessing of Sacrifice") and not AuraUtil.FindAuraByName("Blessing of Protection", "focus", "HARMFUL") and not UnitIsDeadOrGhost("focus") 
    and (AuraUtil.FindAuraByName("Homing Missile", "focus", "HARMFUL")
     or AuraUtil.FindAuraByName("Burning Fermentation", "focus", "HARMFUL") or AuraUtil.FindAuraByName("Raging Gaze", "focus", "HARMFUL")
       or GetFocusTargetHealthPercentage()<40 or blessingofsacrificefocus()  
      or AuraUtil.FindAuraByName("Putrid Waters", "focus", "HARMFUL") or AuraUtil.FindAuraByName("Void Rift", "focus", "HARMFUL") ) then
    return S.BlessingofSacrifice:Cast()
    end
    if IsReady("Word of Glory") and not UnitIsDeadOrGhost("focus") and GetFocusTargetHealthPercentage()<60 and (WordofGlorycast or Player:HolyPower()>=3) and HPpercentloss<10 and Player:HealthPercentage()>75 then
    return S.WordofGloryFocus:Cast()
    end
    if IsReady("Cleanse Toxins") and RubimRH.InterruptsON() and not UnitIsDeadOrGhost("focus") and (AuraUtil.FindAuraByName("Void Rift", "focus", "HARMFUL") or GetAppropriateCureSpell("focus")=='Poison' or GetAppropriateCureSpell("focus")=='Disease') and Player:HealthPercentage()>80 then
    return S.CleanseToxinsFocus:Cast()
    end

    if IsReady("Blessing of Freedom") and not UnitIsDeadOrGhost("focus") 
    and (freedom() 
    or Player:DebuffUp(S.Entangled) 
    or AuraUtil.FindAuraByName("Containment Beam", "focus", "HARMFUL") 
    or AuraUtil.FindAuraByName("Ensnaring Shadows", "focus", "HARMFUL")
    or AuraUtil.FindAuraByName("Silk Binding", "focus", "HARMFUL")
    or AuraUtil.FindAuraByName("Web Bolt", "focus", "HARMFUL")
    or AuraUtil.FindAuraByName("Frostbolt", "focus", "HARMFUL")
    or AuraUtil.FindAuraByName("Ambush", "focus", "HARMFUL")
    or AuraUtil.FindAuraByName("Burning Shadows", "focus", "HARMFUL")
    or AuraUtil.FindAuraByName("Molten Metal", "focus", "HARMFUL")
    or AuraUtil.FindAuraByName("Stinging Assault", "focus", "HARMFUL")
    or AuraUtil.FindAuraByName("Crushing Leap", "focus", "HARMFUL")
  )  then
    return S.BlessingofFreedomfocus:Cast()
    end
    
    end

------ROTATION START------------------------------------------------------------------------------------------------------------------------------------------------
------ROTATION START------------------------------------------------------------------------------------------------------------------------------------------------
------ROTATION START------------------------------------------------------------------------------------------------------------------------------------------------
 
      if Target:Exists() and Player:CanAttack(Target) and not Target:IsDeadOrGhost() and (Player:AffectingCombat() or Target:AffectingCombat() or C_Spell.IsCurrentSpell(6603)) then

        if not C_Spell.IsCurrentSpell(6603) and Player:CanAttack(Target)
        and Target:AffectingCombat() and Player:AffectingCombat() and targetRange20 then
        return S.autoattack:Cast()
        end 

        -- if IsReady("Blessing of Freedom") and Player:IsMoving() and freedomme == true then
        --   return S.BlessingofFreedom:Cast() 
        --   end
        

        --hold aggro
        if targetRange30 and isTanking == false and not Target:IsAPlayer() and Target:AffectingCombat() and not UnitInRaid("player") and UnitName("target") ~= "Cleave Training Dummy" then 
            if IsReady("Hand of Reckoning") and S.AvengersShield:TimeSinceLastCast()>0.5 and S.AvengersShield:CooldownDown() and S.Judgment:TimeSinceLastCast()>0.5 and S.Judgment:CooldownDown() then
            return S.HandofReckoning:Cast()
            end
            --aoe pull aggro 
            if IsReady("Avenger's Shield") and inRange30>=3 and S.HandofReckoning:CooldownDown() then
            return S.AvengersShield:Cast()
            end
            --judgment pull aggro if judgment debuff not up
            if IsReady("Judgment") and Target:DebuffDown(S.JudgmentDebuff) and S.HandofReckoning:CooldownDown() then
            return S.Judgment:Cast()
            end
            --AS pull aggro if judgment debuff up
            if IsReady("Avenger's Shield") and inRange30>=1 and S.HandofReckoning:CooldownDown() then
            return S.AvengersShield:Cast()
            end
            --pull aggro if AS down even if target has judgment debuff
            if IsReady("Judgment") and S.HandofReckoning:CooldownDown() then
            return S.Judgment:Cast()
            end
        end





        if IsReady("Cleanse Toxins") and (AuraUtil.FindAuraByName("Void Rift", "player", "HARMFUL") or GetAppropriateCureSpell("player")=='Poison' or GetAppropriateCureSpell("player")=='Disease') and RubimRH.InterruptsON() then
          return S.CleanseToxins:Cast()
          end



------CDS------------------------------------------------------------------------------------------------------------------------------------------------
if RubimRH.CDsON() then 

  -- avenging_wrath
  if IsReady("Avenging Wrath") and targetRange10 and AuraUtil.FindAuraByName("Consecration", "player") then
    return S.AvengingWrath:Cast()
  end
  -- Manually added: sentinel
  -- Note: Simc has back-end code for Protection Paladin to replace AW with Sentinel when talented.
  if IsReady("Sentinel") and targetRange10 and AuraUtil.FindAuraByName("Consecration", "player") then
    return S.Sentinel:Cast()
  end

  -- moment_of_glory,if=(buff.avenging_wrath.remains<15|(time>10))
  if IsReady("Moment of Glory") and targetRange10 and (Player:BuffRemains(S.AvengingWrathBuff) < 15 or HL.CombatTime() > 10) then
    return S.MomentofGlory:Cast()
  end

  -- divine_toll,if=spell_targets.shield_of_the_righteous>=3
  if  IsReady("Divine Toll") and inRange30 >= 3 and HL.CombatTime()>2 then
    return S.DivineToll:Cast()
  end

  if IsReady("Bastion of Light") and targetRange10 and (Player:BuffUp(S.AvengingWrathBuff) or S.AvengingWrath:CooldownRemains() <= 30) then
return S.BastionofLight:Cast() 
  end



  -- bastion_of_light,if=buff.avenging_wrath.up|cooldown.avenging_wrath.remains<=30
  if IsReady("Bastion of Light") and (Player:BuffUp(S.AvengingWrathBuff) or S.AvengingWrath:CooldownRemains() <= 30) then
    return S.BastionofLight:Cast()
  end

  if (Player:BuffUp(S.AvengingWrath) or Player:BuffUp(S.Sentinel)) and targetRange8 then
    local ShouldReturn = UseItems();
    if ShouldReturn then return ShouldReturn; end
  end

end

if S.Sanctuary:IsAvailable() then
  consecrationtimer = 4
else
  consecrationtimer = 0
end
if IsReady("Consecration") and aoerangecheck and (Player:BuffDown(S.ConsecrationBuff) or S.Consecration:TimeSinceLastCast()>10 + consecrationtimer - Player:GCD()*2 and S.HammerofLight:TimeSinceLastCast()> 10 + consecrationtimer - Player:GCD()*2 ) then
  return S.Consecration:Cast()
end
-- start of standard rotation


if IsReady("Judgment") and (S.Judgment:Charges() >= 2 or S.Judgment:FullRechargeTime() <= Player:GCD()) and targetRange30 then
  return S.Judgment:Cast()
end


-- hammer_of_light,if=buff.hammer_of_light_free.remains<2|buff.shake_the_heavens.remains<1|!buff.shake_the_heavens.up|cooldown.eye_of_tyr.remains<1.5|fight_remains<2

if targetRange8 and IsReady(427453,1) and (Player:BuffRemains(S.LightsDeliveranceBuff) < 2 
or Player:BuffRemains(S.ShaketheHeavensBuff) < 1 or Player:BuffDown(S.ShaketheHeavensBuff) 
or S.EyeofTyr:CooldownRemains() < 1.5 or aoeTTD() < 2) then
  return S.EyeofTyr:Cast()
  end

  -- eye_of_tyr,if=(hpg_to_2dawn=5|!talent.of_dusk_and_dawn.enabled)&talent.lights_guidance.enabled

  -- eye_of_tyr,if=(hpg_to_2dawn=1|buff.blessing_of_dawn.stack>0)&talent.lights_guidance.enabled

  if (RubimRH.CDsON() or S.LightsGuidance:IsAvailable()) and IsReady("Eye of Tyr") and targetRange8 and (S.LightsGuidance:IsAvailable() and ((HPGTo2Dawn() == 5 or not S.OfDuskandDawn:IsAvailable()) or (HPGTo2Dawn() == 1 or Player:BuffStack(S.BlessingofDawnBuff) > 0))) then
   return S.EyeofTyr:Cast()
  end


 -- shield_of_the_righteous,if=(!talent.righteous_protector.enabled|cooldown.righteous_protector_icd.remains=0)&!buff.hammer_of_light_ready.up
 local RighteousProtectorICD = 999
 if S.RighteousProtector:IsAvailable() then
   local LastCast = math.min(S.ShieldoftheRighteous:TimeSinceLastCast(), S.WordofGlory:TimeSinceLastCast())
   RighteousProtectorICD = math.max(0, 1 - math.min(S.ShieldoftheRighteous:TimeSinceLastCast(), S.WordofGlory:TimeSinceLastCast()))
 end

 if NoIntercession then

--  shield_of_the_righteous,if=!buff.hammer_of_light_ready.up&(buff.luck_of_the_draw.up&((holy_power+judgment_holy_power>=5)|(!talent.righteous_protector.enabled|cooldown.righteous_protector_icd.remains=0)))

--  shield_of_the_righteous,if=!buff.hammer_of_light_ready.up&set_bonus.thewarwithin_season_2_4pc&((holy_power+judgment_holy_power>5)|(holy_power+judgment_holy_power>=5&cooldown.righteous_protector_icd.remains=0))

--  shield_of_the_righteous,if=!set_bonus.thewarwithin_season_2_4pc&(!talent.righteous_protector.enabled|cooldown.righteous_protector_icd.remains=0)&!buff.hammer_of_light_ready.up


 if IsReady("Shield of the Righteous")  and (targetRange8 or inRange8>=1)  and ((not S.RighteousProtector:IsAvailable() or RighteousProtectorICD == 0) and canCastHoL==false) then
  return S.ShieldoftheRighteous:Cast()
end
end


if IsReady("Judgment") and targetRange30 and (inRange10 > 3 and Player:BuffStack(S.BulwarkofRighteousFuryBuff) >= 3 and Player:HolyPower() < 3) then
 return S.Judgment:Cast()
end



if IsReady("Avenger's Shield") and targetRange30 and (Player:BuffDown(S.BulwarkofRighteousFuryBuff) and S.BulwarkofRighteousFury:IsAvailable() and inRange10 >= 3) then
  return S.AvengersShield:Cast()
end

if Player:BuffUp(S.BlessedAssuranceBuff) and inRange15 < 3 and Player:BuffDown(S.AvengingWrathBuff) then
  -- hammer_of_the_righteous,if=buff.blessed_assurance.up&spell_targets.shield_of_the_righteous<3&!buff.avenging_wrath.up
  if IsReady("Hammer of the Righteous") and targetRange8 then
    return S.HammeroftheRighteous:Cast()
  end
  -- blessed_hammer,if=buff.blessed_assurance.up&spell_targets.shield_of_the_righteous<3&!buff.avenging_wrath.up
  if IsReady("Blessed Hammer") and (targetRange10 or inRange15>=1) then
    return S.BlessedHammer:Cast()
  end
end












-- crusader_strike,if=buff.blessed_assurance.up&spell_targets.shield_of_the_righteous<2&!buff.avenging_wrath.up
if IsReady("Crusader Strike") and targetRange8 and (Player:BuffUp(S.BlessedAssuranceBuff) and inRange10 < 2 and Player:BuffDown(S.AvengingWrathBuff)) then
  return S.CrusaderStrike:Cast()
end
-- judgment,target_if=min:debuff.judgment.remains,if=charges>=2|full_recharge_time<=gcd.max
if IsReady("Judgment")   and targetRange30 and (S.Judgment:Charges() >= 2 or S.Judgment:FullRechargeTime() <= Player:GCD() + 0.25) then
  return S.Judgment:Cast()
end
-- consecration,if=buff.divine_guidance.stack=5
if IsReady("Consecration")  and aoerangecheck and (Player:BuffStack(S.DivineGuidanceBuff) == 5) then
  return S.Consecration:Cast()
end
-- holy_armaments,if=next_armament=sacred_weapon&(!buff.sacred_weapon.up|(buff.sacred_weapon.remains<6&!buff.avenging_wrath.up&cooldown.avenging_wrath.remains<=30))
if IsReady("Sacred Weapon") and targetRange8 and (Player:BuffDown(S.SacredWeaponBuff) or (Player:BuffRemains(S.SacredWeaponBuff) < 6 and Player:BuffDown(S.AvengingWrathBuff) and S.AvengingWrath:CooldownRemains() <= 30)) then
  return S.SacredWeapon:Cast()
end
-- hammer_of_wrath
if IsReady("Hammer of Wrath") and targetRange30 then
  return S.HammerofWrath:Cast()
end
-- divine_toll,if=(!raid_event.adds.exists|raid_event.adds.in>10)
if RubimRH.CDsON() and IsReady("Divine Toll")  and targetRange30 and (inRange20>=2 or not RubimRH.AoEON()) then
  return S.DivineToll:Cast()
end
-- avengers_shield,if=talent.refining_fire.enabled&talent.lights_guidance.enabled
if IsReady("Avenger's Shield") and targetRange30 and (S.RefiningFire:IsAvailable() and S.LightsGuidance:IsAvailable()) then
  return S.AvengersShield:Cast()
end
-- judgment,target_if=min:debuff.judgment.remains,if=(buff.avenging_wrath.up&talent.hammer_and_anvil.enabled)
if IsReady("Judgment") and targetRange30 and (Player:BuffUp(S.AvengingWrathBuff) and S.HammerandAnvil:IsAvailable()) then
  return S.Judgment:Cast()
end
-- holy_armaments,if=next_armament=holy_bulwark&charges=2
if IsReady("Holy Bulwark") and targetRange8 and (S.HolyBulwark:Charges() == 2) then
  return S.HolyBulwark:Cast()
end
-- judgment,target_if=min:debuff.judgment.remains
if IsReady("Judgment") and targetRange30  then
  return S.Judgment:Cast()
end
-- avengers_shield,if=!buff.shake_the_heavens.up&talent.shake_the_heavens.enabled
if IsReady("Avenger's Shield") and targetRange30 and (Player:BuffDown(S.ShaketheHeavensBuff) and S.ShaketheHeavens:IsAvailable()) then
  return S.AvengersShield:Cast()
end

  -- hammer_of_the_righteous,if=(buff.blessed_assurance.up&spell_targets.shield_of_the_righteous<3)|buff.shake_the_heavens.up
  if IsReady("Hammer of the Righteous") and targetRange8 and (AuraUtil.FindAuraByName("Blessed Assurance","player")  and  inRange10<3 or AuraUtil.FindAuraByName("Shake the Heavens","player") ) then
    return S.HammeroftheRighteous:Cast()
  end
  -- blessed_hammer,if=buff.blessed_assurance.up&spell_targets.shield_of_the_righteous<3&!buff.avenging_wrath.up
  if IsReady("Blessed Hammer") and (targetRange10 or inRange15>=1) and  AuraUtil.FindAuraByName("Blessed Assurance","player")  and inRange10<3 and not  AuraUtil.FindAuraByName("Avenging Wrath","player")   then
    return S.BlessedHammer:Cast()
  end
  -- blessed_hammer,if=(buff.blessed_assurance.up&spell_targets.shield_of_the_righteous<3)|buff.shake_the_heavens.up
  if IsReady("Blessed Hammer") and (targetRange10 or inRange15>=1) and (AuraUtil.FindAuraByName("Blessed Assurance","player")  and inRange10<3 or AuraUtil.FindAuraByName("Shake the Heavens","player"))   then
    return S.BlessedHammer:Cast()
  end


-- crusader_strike,if=(buff.blessed_assurance.up&spell_targets.shield_of_the_righteous<2)|buff.shake_the_heavens.up
if IsReady("Crusader Strike") and targetRange8 and ((Player:BuffUp(S.BlessedAssuranceBuff) and inRange10 < 2) or Player:BuffUp(S.ShaketheHeavensBuff)) then
  return S.CrusaderStrike:Cast()
end
-- avengers_shield,if=!talent.lights_guidance.enabled
if IsReady("Avenger's Shield") and targetRange30 and (not S.LightsGuidance:IsAvailable()) then
  return S.AvengersShield:Cast()
end
-- consecration,if=!consecration.up
if IsReady("Consecration") and aoerangecheck and (Player:BuffDown(S.ConsecrationBuff)) then
  return S.Consecration:Cast()
end
-- eye_of_tyr,if=(talent.inmost_light.enabled&raid_event.adds.in>=45|spell_targets.shield_of_the_righteous>=3)&!talent.lights_deliverance.enabled
-- Note: Ignoring CDsON if spec'd Templar Hero Tree.
if (RubimRH.CDsON() or S.LightsGuidance:IsAvailable()) and IsReady("Eye of Tyr") and targetRange8 and ((S.InmostLight:IsAvailable() and inRange10 == 1 or inRange10 >= 3) and not S.LightsDeliverance:IsAvailable()) then
  return S.EyeofTyr:Cast()
end
-- holy_armaments,if=next_armament=holy_bulwark
if IsReady("Holy Bulwark") and targetRange8 then
  return S.HolyBulwark:Cast()
end
-- blessed_hammer
if IsReady("Blessed Hammer") and (targetRange10 or inRange15>=1)then
  return S.BlessedHammer:Cast()
end
-- hammer_of_the_righteous
if IsReady("Hammer of the Righteous") and targetRange8 then
  return S.HammeroftheRighteous:Cast()
end
-- crusader_strike
if IsReady("Crusader Strike") and targetRange8 then
  return S.CrusaderStrike:Cast()
end
-- word_of_glory,if=buff.shining_light_free.up&(talent.blessed_assurance.enabled|(talent.lights_guidance.enabled&cooldown.hammerfall_icd.remains=0))
-- if S.WordofGlory:IsReady() and (Player:BuffUp(S.ShiningLightFreeBuff) and (S.BlessedAssurance:IsAvailable() or (S.LightsGuidance:IsAvailable() and HammerfallICD() == 0))) then
--   -- Is our health ok? Are we in a party with a wounded party member? Heal them instead.
--   if Player:HealthPercentage() > 90 and Player:IsInParty() and not Player:IsInRaid() then
--     for _, Char in pairs(Unit.Party) do
--       if Char:Exists() and Char:IsInRange(40) and Char:HealthPercentage() <= 80 then
--         if HR.CastAnnotated(S.WordofGlory, false, Char:Name()) then return "word_of_glory standard party 60"; end
--       end
--     end

if IsReady("Word of Glory") and (Player:BuffUp(S.ShiningLightFreeBuff) and S.LightsGuidance:IsAvailable() and S.WordofGlory:TimeSinceLastCast() > 1 and S.ShieldoftheRighteous:TimeSinceLastCast() > 1) and Player:HealthPercentage()<75 then
  return S.WordofGlory:Cast()
end

  
--     -- Nobody in the party needs it. We might as well heal ourselves for the extra block chance.
--     if Cast(S.WordofGlory, Settings.Protection.GCDasOffGCD.WordOfGlory) then return "word_of_glory standard self 62"; end
--   else
--     -- We're either solo, in a raid, or injured. Heal ourselves.
--     if Cast(S.WordofGlory, Settings.Protection.GCDasOffGCD.WordOfGlory) then return "word_of_glory standard self 64"; end
--   end
-- end
-- avengers_shield
if IsReady("Avenger's Shield") and targetRange30 then
  return S.AvengersShield:Cast()
end
-- eye_of_tyr,if=!talent.lights_deliverance.enabled

-- Note: Ignoring CDsON if spec'd Templar Hero Tree.
if (RubimRH.CDsON() or S.LightsGuidance:IsAvailable()) and IsReady("Eye of Tyr") and targetRange8 and (not S.LightsDeliverance:IsAvailable()) then
  return S.EyeofTyr:Cast()
end
-- word_of_glory,if=buff.shining_light_free.up

if IsReady("Word of Glory")  and Player:HealthPercentage() <= 65 and (Player:BuffUp(S.ShiningLightFreeBuff) ) then
  return S.WordofGlory:Cast()
  end


-- arcane_torrent,if=holy_power<5
-- if CDsON() and S.ArcaneTorrent:IsCastable() and (Player:HolyPower() < 5) then
--   if Cast(S.ArcaneTorrent, Settings.CommonsOGCD.OffGCDasOffGCD.Racials, nil, not Target:IsInRange(8)) then return "arcane_torrent standard 76"; end
-- end
-- consecration
if IsReady("Consecration") and aoerangecheck then
  return S.Consecration:Cast()
end





end -- END for in combat rotation


if not Player:AffectingCombat() then
if IsReady("Word of Glory") and not Player:HealingAbsorbed() and Player:HealthPercentage() < 75 and
(Player:HolyPower() >= 3 or AuraUtil.FindAuraByName("Divine Purpose", "player")  or Player:BuffUp(S.ShiningLightFreeBuff) ) then
return S.WordofGlory:Cast()
end

if IsReady("Devotion Aura") and not AuraUtil.FindAuraByName("Devotion Aura", "player") then
return S.DevotionAura:Cast()
end

if IsReady("Blessed Hammer") and S.BlessedHammer:Charges()>=1  and Player:IsMoving() and IsResting("player") == false 
and inRange30 >= 1 and inRange10 == 0 
and (S.BlessedHammer:ChargesFractional() >= 2.9 and Player:HolyPower() < 5 or
S.BlessedHammer:ChargesFractional() >= 0.9 and Player:HolyPower() < 3)
then
return S.BlessedHammer:Cast()
end
-- if IsReady("Consecration") and Player:BuffDown(S.ConsecrationBuff) and inRange30>=1 and Player:IsMoving()  and IsResting("player") == false  then
--   return S.Consecration:Cast()
--   end



return 0, "Interface\\Addons\\Rubim-RH\\Media\\prot.tga"
end

return 0, 135328
end

RubimRH.Rotation.SetAPL(66, APL)

local function PASSIVE()

end

RubimRH.Rotation.SetPASSIVE(66, PASSIVE)