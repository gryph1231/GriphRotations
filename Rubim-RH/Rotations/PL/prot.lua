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
BulwarkofRighteousFuryBuff            = Spell(386652),
Sentinel = Spell(389539),
BlessingofFreedom           = Spell(1044),
BlindingLight               = Spell(115750),
-- SenseUndead                 = Spell(5502),

CleanseToxins               = Spell(213644),
autoattack                  = Spell(291944), -- regeneratin
tempestofthelightbringer    = Spell(383396),

DivineSteedBuff             = Spell(221883),
BlessingofProtection        = Spell(1022),
Forbearance                 = Spell(25771),
-- Racials
AncestralCall               = Spell(274738),
ArcanePulse                 = Spell(260364),
ArcaneTorrent               = Spell(155145),
BagofTricks                 = Spell(312411),
Berserking                  = Spell(26297),
BloodFury                   = Spell(20572),
-- Fireblood                             = Spell(265221),
GiftoftheNaaru              = Spell(59542),
-- Abilities
ShiningLightFreeBuff                  = Spell(327510),
InmostLight                           = Spell(405757),
MomentofGloryBuff                     = Spell(327193),
FinalStand                  = Spell(204077),
Consecration                = Spell(26573),
CrusaderStrike              = Spell(35395),
DivineShield                = Spell(642),
DivineSteed                 = Spell(190784),
FlashofLight                = Spell(19750),
HammerofJustice             = Spell(853),
HandofReckoning             = Spell(62124),
Rebuke                      = Spell(96231),
ShieldoftheRighteous        = Spell(53600),
WordofGlory                 = Spell(85673),
-- Talents
AvengingWrath               = Spell(31884),
HammerofWrath               = Spell(24275),
HolyAvenger                 = Spell(105809),
HolyAvengerBuff             = Spell(105809),
LayonHands                  = Spell(633),

-- Covenants (Shadowlands)
BlessingofFreedomz = Spell(5502), -- turn evil focus macro kb to sense undead
AshenHallow                 = Spell(316958),
BlessingofAutumn            = Spell(328622),
BlessingofSpring            = Spell(328282),
BlessingofSummer            = Spell(328620),
BlessingofWinter            = Spell(328281),
DivinePurpose               = Spell(223817),
-- DivineTollCov                         = Spell(304971),
DoorofShadows               = Spell(300728),
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
RetributionAura             = Spell(183435),
-- Buffs
BlessingofSpellWarding = Spell(204018),
Intercession                = Spell(391054),
intercession                = Spell(105809),
trinket                     = Spell(59547), -- gift of narru
CleanseToxinsFocus = Spell(20594), --stone form
WordofGloryFocus = Spell(215652), --shield of virtue
BlessingofProtectionFocus = Spell(204018),-- blessing of spellwarding
BlessingofSacrifice = Spell(6940),
LayonHandsFocus = Spell(172321),--seraphim
BastionofLightBuff                    = Spell(378974),

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
local G = RubimRH.Spell[1]; -- General Skills

-- Items
if not Item.Paladin then
Item.Paladin = {}
end
Item.Paladin.Protection = {
trink = Item(178751, { 13, 14 }),

bracer = Item(168978),
rez = Item(158379),
drums = Item(193470),

HPIcon = Item(169451),
tx1 = Item(118330),
tx2 = Item(114616),
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

local function APL()

  inRange5 = RangeCount(5)
  inRange8 = RangeCount(8)
  inRange10 = RangeCount(10)
  inRange15 = RangeCount(15)
  inRange20 = RangeCount(20)
  inRange25 = RangeCount(25)
  inRange30 = RangeCount(30)
  targetRange5 = IsItemInRange(8149, "target")
  targetRange8 = IsItemInRange(34368, "target")
  targetRange10 = IsItemInRange(32321, "target")
  targetRange15 = IsItemInRange(33069, "target")
  targetRange20 = IsItemInRange(10645, "target")
  targetRange25 = IsItemInRange(24268, "target")
  targetRange30 = IsItemInRange(835, "target")

            local lostimer = GetTime() - losCheckTimer
            local los
            
            if lostimer < Player:GCD() then
                los = true
            else
                los = false
            end

            local isTanking, status, threatpct, rawthreatpct, threatvalue = UnitDetailedThreatSituation("player", "target")
            local inInstance, instanceType = IsInInstance()

            local level, affixIDs, wasEnergized = C_ChallengeMode.GetActiveKeystoneInfo()
            local highkey = 4

            local castchannelTime = math.random(250, 500) / 1000

            local startTimeMS = select(4, UnitCastingInfo('target')) or 0
            local currentTimeMS = GetTime() * 1000
            local elapsedTimeca = (startTimeMS > 0) and (currentTimeMS - startTimeMS) or 0
            local castTime = elapsedTimeca / 1000
            local startTimeMS = select(4, UnitCastingInfo('target')) or select(4, UnitChannelInfo('target')) or 0
            local currentTimeMS = GetTime() * 1000
            local elapsedTimech = (startTimeMS > 0) and (currentTimeMS - startTimeMS) or 0
            local channelTime = elapsedTimech / 1000

            WordofGlorycast = (
            AuraUtil.FindAuraByName("Divine Purpose", "player") or Player:Buff(S.ShiningLightFreeBuff) or AuraUtil.FindAuraByName("Bastion of Light", "player") or Player:HolyPower()>=3)

            if UnitClassification("target") == "worldboss"
            or UnitClassification("target") == "rareelite"
            or UnitClassification("target") == "elite"
            or UnitClassification("target") == "rare"
            or Target:IsAPlayer() then
            elite = true
            else
            elite = false
            end

            local incorporeal = UnitName('target') == 'Incorporeal Being' and not AuraUtil.FindAuraByName("Imprison","target","HARMFUL") and not AuraUtil.FindAuraByName("Freezing Trap","target","HARMFUL")  
            and not AuraUtil.FindAuraByName("Blind","target","HARMFUL")  and not AuraUtil.FindAuraByName("Turn Evil","target","HARMFUL")  and not AuraUtil.FindAuraByName("Repentance","target","HARMFUL")  
            -- Define a list of dungeon boss encounter IDs
            local Boss = {
            'The Raging Tempest', 'Teera', 'Balakar Khan','Maruuk',                   -- Nokhud Offensive
            'Hackclaw"s War-Band','Gutshot','Decatriarch Wratheye', -- Brakenhide hollow
            'Emberon','Chrono-Lord Deios', -- udlaman: legacy of tyr
            'Crawth', 'Overgrown Ancient', --Academy
            'Leymor','Umbrelskul', -- Azure vault
            'Kokia Blazehoof','Erkhart Stormvein', 'Defier Draghar','Flamegullet','Thunderhead',--RLP
            'Decatriarch Wratheye',--BHH
            'Forgemaster Gorek', --neltharus
            'Primal Tsunami', -- HoI


            }

            HPpercentloss = MyHealthTracker.GetPredictedHealthLoss() * 3

            validmobsinrange10y = combatmobs40() * .7
            validmobsinrange30y = combatmobs40() * .7
if S.Intercession:Charges()== nil then
  rezcharges = 0
else
  rezcharges=S.Intercession:Charges()
end
            local useAD = not AuraUtil.FindAuraByName("Divine Shield", "player") and not AuraUtil.FindAuraByName("Eye of Tyr","target","PLAYER|HARMFUL") and not AuraUtil.FindAuraByName("Guardian of Ancient Kings", "player")
            local useDS = not AuraUtil.FindAuraByName("Ardent Defender", "player") and not AuraUtil.FindAuraByName("Eye of Tyr","target","PLAYER|HARMFUL") and not AuraUtil.FindAuraByName("Guardian of Ancient Kings", "player")
            local useGoAK = not AuraUtil.FindAuraByName("Divine Shield", "player") and not AuraUtil.FindAuraByName("Eye of Tyr","target","PLAYER|HARMFUL") and not AuraUtil.FindAuraByName("Ardent Defender", "player")
            local useEoT = not AuraUtil.FindAuraByName("Divine Shield", "player") and not AuraUtil.FindAuraByName("Ardent Defender", "player") and not AuraUtil.FindAuraByName("Guardian of Ancient Kings", "player")


            if S.Intercession:ID() == RubimRH.queuedSpell[1]:ID() and S.Intercession:CooldownUp() 
            and Player:HolyPower() < 3 and partyOrRaidDead() >= 1 and (rezcharges>=1 or level == 0) then
            if S.Judgment:IsReady() and targetRange30 then
            return S.Judgment:Cast()
            end

            if S.BlessedHammer:IsReady() then
            return S.BlessedHammer:Cast()
            end
            end

            if S.Intercession:ID() == RubimRH.queuedSpell[1]:ID() and S.Intercession:IsReady() and (rezcharges>=1 or level == 0)
            and Player:HolyPower() >= 3 then
            return S.intercession:Cast() 
            end


            if S.Intercession:ID() == RubimRH.queuedSpell[1]:ID() and (not S.Intercession:CooldownUp() or partyOrRaidDead() == 0 or rezcharges>=1) then
            RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
            end
      


            if S.lustAT:ID() == RubimRH.queuedSpell[1]:ID()
            and not Player:Debuff(S.lust1) and not Player:Debuff(S.lust2) and Player:CanAttack(Target) and 
            not Player:Debuff(S.lust3) and not Player:Debuff(S.lust4) and not Player:Debuff(S.lust5) and (I.drums:IsReady()) then
            return S.lustAT:Cast() -- BIND LUST KEYBIND IN BINDPAD TO ARCANE TORRENT
            end

            if S.lustAT:ID() == RubimRH.queuedSpell[1]:ID() and
            (
            Player:Debuff(S.lust1) or Player:Debuff(S.lust2) or Player:Debuff(S.lust3) or Player:Debuff(S.lust4) or
            Player:Debuff(S.lust5)) then
            RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
            end


            if S.FlashofLight:ID() == RubimRH.queuedSpell[1]:ID() and Player:IsMoving() then
            RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
            end

            if S.DivineShield:ID() == RubimRH.queuedSpell[1]:ID() and Player:DebuffP(S.Forbearance) then
            RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
            end
            if S.BlessingofProtection:ID() == RubimRH.queuedSpell[1]:ID() and Player:DebuffP(S.Forbearance) then
            RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
            end
            if S.LayonHands:ID() == RubimRH.queuedSpell[1]:ID() and Player:DebuffP(S.Forbearance) then
            RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
            end

            if S.DivineSteed:ID() == RubimRH.queuedSpell[1]:ID() and AuraUtil.FindAuraByName("Divine Steed", "player") then
            RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
            end


            if RubimRH.QueuedSpell():IsReadyQueue() then
            return RubimRH.QueuedSpell():Cast()
            end



            if (not RubimRH.queuedSpell[1]:CooldownUp() or not Player:AffectingCombat() or inRange30 == 0) then
            RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
            end

            if S.TurnEvil:IsReady() and incorporeal and targetRange10 and not Player:IsMoving() then
              return S.TurnEvil:Cast()
              end
     
            if S.Repentance:IsReady() and incorporeal and targetRange30 and not Player:IsMoving() then
              return S.Repentance:Cast()
              end

            if S.HammerofJustice:IsReady() and incorporeal and targetRange10 then
              return S.HammerofJustice:Cast()
              end



            if not IsCurrentSpell(6603) and Player:CanAttack(Target)
            and Target:AffectingCombat() and Player:AffectingCombat() and targetRange20 then
            return S.autoattack:Cast()
            end


            --health pot -- will need to update item ID of HPs as expansions progress
            if inRange30 >= 1 and Player:HealthPercentage() <= 30 and Player:AffectingCombat() and (IsUsableItem(191380) == true and
            GetItemCooldown(191380) == 0 and GetItemCount(191380) >= 1 or IsUsableItem(207023) == true and
            GetItemCooldown(207023) == 0 and GetItemCount(207023) >= 1)
            and (not Player:InArena() and not Player:InBattlegrounds()) then
            return I.HPIcon:Cast()
            end

            --abnout to die need heals or immunity
            if S.DivineShield:IsReady() and inRange30 >= 1 and Player:HealthPercentage() < 20  and Player:AffectingCombat() then
            return S.DivineShield:Cast()
            end

            if S.LayonHands:IsReady()  and Player:AffectingCombat() and Player:HealthPercentage() < 20 and S.DivineShield:CooldownRemains() > Player:GCD() and not Player:Debuff(S.Forbearance)
            and inRange30 >= 1 then
            return S.LayonHands:Cast()
            end

            if ((IsEncounterInProgress(Boss) or level>highkey) and mitigatedng()) then 

            if S.GuardianofAncientKings:IsReady()  and S.ArdentDefender:TimeSinceLastCast() > 0.5 
            and inRange30 >= 1 and useGoAK then
            return S.GuardianofAncientKings:Cast()
            end

            if S.DivineShield:IsReady() and not Player:Debuff(S.Forbearance) and S.FinalStand:IsAvailable() and useDS  then
            return S.DivineShield:Cast()
            end


            if S.ArdentDefender:IsReady()  and S.GuardianofAncientKings:TimeSinceLastCast() > 0.5
            and inRange30 >= 1 and useAD then
            return S.ArdentDefender:Cast()
            end

            --  if about to die and shield up
            if S.WordofGlory:IsReady() and not Player:HealingAbsorbed() and Player:HealthPercentage() <= 45
            and WordofGlorycast then
            return S.WordofGlory:Cast()
            end


            if S.EyeofTyr:IsReady()  and HPpercentloss > 5 
            and (inRange8>= 1 or targetRange8) and useEoT then
            return S.EyeofTyr:Cast()
            end
            end



 
            -- defensives for trash on M+ key <= level 3
            if (not IsEncounterInProgress(Boss) or level <= highkey)  then
                if S.DivineShield:IsReady() and not Player:Debuff(S.Forbearance) and S.FinalStand:IsAvailable() 
                and inRange30 >= 1
                and HPpercentloss > 12
                and Player:HealthPercentage() < 30
                and useDS then
                return S.DivineShield:Cast()
                end


                if S.GuardianofAncientKings:IsReady() and S.ArdentDefender:TimeSinceLastCast() > 0.5 
                and inRange30 >= 1 
                and (HPpercentloss > 12
                and Player:HealthPercentage() < 65 or Player:HealthPercentage() < 50)
                and useGoAK then
                return S.GuardianofAncientKings:Cast()
                end

                if S.ArdentDefender:IsReady() and S.GuardianofAncientKings:TimeSinceLastCast() > 0.5
                and inRange30 >= 1
                and (HPpercentloss > 12
                and Player:HealthPercentage() <60 or Player:HealthPercentage() < 45)
                and  useAD then
                return S.ArdentDefender:Cast()
                end

                --  if about to die and shield up
                if S.WordofGlory:IsReady() and not Player:HealingAbsorbed() and Player:HealthPercentage() <= 45
                and WordofGlorycast then
                return S.WordofGlory:Cast()
                end


                if S.EyeofTyr:IsReady() and HPpercentloss > 5 and Player:HealthPercentage() < 70
                and (inRange8>= 1 or targetRange8) and useEoT then
                return S.EyeofTyr:Cast()
                end
                

            end

                
          





            -------------DEFENSIVES_-------------
            if Target:Exists() and Player:CanAttack(Target) and (inRange30>=1 or Player:AffectingCombat() or Target:AffectingCombat() and not Target:IsDeadOrGhost()) then


              if S.HandofReckoning:IsReady() and targetRange30 and isTanking==false then
              return S.HandofReckoning:Cast()
              end
                -- heals/active mitigation
                -- cast word of glory on us if it's a) free or b) probably not going to drop sotr
                if S.WordofGlory:IsReady() and not Player:HealingAbsorbed() and Player:HealthPercentage() <= 65
                and (WordofGlorycast and Player:BuffRemains(S.ShieldoftheRighteousBuff) >= Player:GCD() * 3 ) then
                return S.WordofGlory:Cast()
                end

                if S.WordofGlory:IsReady() and not Player:HealingAbsorbed() and Player:HealthPercentage() <= 45
                and WordofGlorycast and Player:BuffStack(S.ShiningLightBuffStack)<2 and Player:BuffRemains(S.ShieldoftheRighteousBuff)>2  then
                return S.WordofGlory:Cast()
                end



                if S.ShieldoftheRighteous:IsReady() and (targetRange8 or inRange8 >= 1)
                and Player:BuffRemains(S.ShieldoftheRighteousBuff) < 2
                then
                return S.ShieldoftheRighteous:Cast()
                end


                -- no enemies/out of target range heal/HP == 5 or if about to die and shield up
                if S.WordofGlory:IsReady() and not Player:HealingAbsorbed() and (Player:HealthPercentage() < 55
                and inRange30 == 0 and Player:HolyPower() == 5
                or Player:HealthPercentage() < 45 and Player:BuffRemains(S.ShieldoftheRighteousBuff) >= 3
                and WordofGlorycast )
                then
                return S.WordofGlory:Cast()
                end
            

            if S.ShieldoftheRighteous:IsReady() and (targetRange8 or inRange8>=1) 
            and (Player:BuffRemains(S.ShieldoftheRighteousBuff) < 2
            and (Player:ActiveMitigationNeeded()
            or Player:HealthPercentage() <= 80)) then
            return S.ShieldoftheRighteous:Cast()
            end


            if S.BastionofLight:IsReadyP() and inRange8 >= 1 and RubimRH.CDsON() then
            return S.BastionofLight:Cast()
            end



            if S.WordofGlory:IsReadyP() and not Player:HealingAbsorbed() and Player:HealthPercentage() < 65  and (Player:HolyPower()>=3 or WordofGlorycast) and 
            Player:BuffRemains(S.ShieldoftheRighteousBuff) > 5 then
            return S.WordofGlory:Cast()
            end


            if S.WordofGlory:IsReadyP() and not Player:HealingAbsorbed() and WordofGlorycast and 
            (Player:HealthPercentage() < 70  and inRange30 == 0) then
            return S.WordofGlory:Cast()
            end

            -- if S.BlessingofProtection:IsReadyP() and Player:HealthPercentage() <= 20
            --     and not Player:DebuffP(S.Forbearance) and
            --     S.DivineShield:CooldownRemains() > Player:GCD()
            --     and not Player:BuffP(S.ArdentDefender) and S.ArdentDefender:CooldownRemains() > Player:GCD()
            --     and not Player:Buff(S.GuardianofAncientKings) and S.GuardianofAncientKings:CooldownRemains() > Player:GCD()
            --     and S.LayonHands:CooldownRemains() > Player:GCD() and
            --     inRange10 >= 1 then
            --     return S.BlessingofProtection:Cast()
            -- end

            ------princess function for focus------------------------------------------------------------------------------------------------------------------------------------------------
            ------princess function for focus------------------------------------------------------------------------------------------------------------------------------------------------
            ------princess function for focus------------------------------------------------------------------------------------------------------------------------------------------------

                if los == false and UnitExists('focus') and IsSpellInRange("Flash of Light", "focus")==1 then 
                    if S.Intercession:IsCastable() and Player:HolyPower()>=3 and UnitIsDeadOrGhost("focus") and (rezcharges>=1 or level ==0) then
                        return S.intercession:Cast()
                    end

                    if S.LayonHands:IsReady() and GetFocusTargetHealthPercentage()<30 and not AuraUtil.FindAuraByName("Forbearance", "focus", "HARMFUL") then
                        return S.LayonHandsFocus:Cast()
                    end
                    if S.BlessingofProtection:IsReady() and inRange30>2 and GetFocusTargetHealthPercentage()<40 and not AuraUtil.FindAuraByName("Forbearance", "focus", "HARMFUL") then
                        return S.BlessingofProtectionFocus:Cast()
                    end
                    if S.BlessingofSacrifice:IsReady() and (GetFocusTargetHealthPercentage()<60 or mitigate()) then
                        return S.BlessingofSacrifice:Cast()
                    end
                    if S.WordofGlory:IsReady() and GetFocusTargetHealthPercentage()<45 and (WordofGlorycast or Player:HolyPower()>=3) then
                        return S.WordofGloryFocus:Cast()
                    end
                    if S.CleanseToxins:IsReady() and (GetAppropriateCureSpellfocus()=='Poison' or GetAppropriateCureSpellfocus()=='Disease') and Player:HealthPercentage()>80 then
                        return S.CleanseToxinsFocus:Cast()
                    end
                    
                end


            ------princess function for focus------------------------------------------------------------------------------------------------------------------------------------------------
            ------princess function for focus------------------------------------------------------------------------------------------------------------------------------------------------
            ------princess function for focus------------------------------------------------------------------------------------------------------------------------------------------------
                if S.CleanseToxins:IsReady() and (GetAppropriateCureSpell()=='Poison' or GetAppropriateCureSpell()=='Disease') then
                    return S.CleanseToxins:Cast()
                end
                if los == false and UnitExists('focus') and IsSpellInRange("Flash of Light", "focus")==1  then
                             -- --Freedom
                             if S.BlessingofFreedom:IsReady() and (freedom() or Player:Debuff(S.Entangled) or AuraUtil.FindAuraByName("Time Sink", "focus", "HARMFUL") or AuraUtil.FindAuraByName("Containment Beam", "focus", "HARMFUL"))  then
                             return S.BlessingofFreedomz:Cast()
                             end
                end


                -- --Freedom
                if S.BlessingofFreedom:IsReady() and (freedom() or AuraUtil.FindAuraByName("Icy Bindings", "player", "HARMFUL") 
                or AuraUtil.FindAuraByName("Frost Shock", "player", "HARMFUL") or AuraUtil.FindAuraByName("Deep Chill", "player", "HARMFUL") or Player:Debuff(S.Entangled))  then
                return S.BlessingofFreedom:Cast()
                end
                
            if RubimRH.CDsON() and inRange8 >= 1 then
            if RubimRH.CDsON() and targetRange8
            and (AuraUtil.FindAuraByName("Avenging Wrath", "player") or S.AvengingWrath:CooldownRemains()>20)
            and not Target:IsDeadOrGhost() and Player:CanAttack(Target) and Player:AffectingCombat() then
            local ShouldReturn = UseItems();
            if ShouldReturn then return ShouldReturn; end
            end

            if S.Sentinel:IsReadyP() and not AuraUtil.FindAuraByName("Sentinel", "player") then
              return S.AvengingWrath:Cast()
              end

            if S.AvengingWrath:IsReadyP() and not AuraUtil.FindAuraByName("Avenging Wrath", "player") then
            return S.AvengingWrath:Cast()
            end

            if S.HolyAvenger:IsReadyP() and (AuraUtil.FindAuraByName("Avenging Wrath", "player") or S.AvengingWrath:CooldownRemains() > 60) then
            return S.HolyAvenger:Cast()
            end

            if S.MomentofGlory:IsReadyP() and Player:PrevGCD(1, S.AvengersShield) and not S.AvengersShield:CooldownUp() then
            return S.MomentofGlory:Cast()
            end
            end


         
           if (castTime > 0.1 or channelTime > 0.1) and select(8, UnitCastingInfo("target")) == false and RubimRH.InterruptsON() and not isEnraged then

            -- kick on GCD
            if S.AvengersShield:IsReady() and targetRange30 and kickprio() and (S.DivineToll:CooldownRemains() > Player:GCD() or not RubimRH.CDsON()) then
            return S.AvengersShield:Cast()
            end

            -- kick on GCD
            if S.Rebuke:IsReady() and kickprio() and targetRange8 then
            return S.Rebuke:Cast()
            end

            --Stun
            if S.HammerofJustice:IsReady() and targetRange10 and stunprio() then
            return S.HammerofJustice:Cast()
            end

            --Blind
            if targetRange10 and S.BlindingLight:IsReady() and inRange8 >= 1 and blindprio() then
            return S.BlindingLight:Cast()
            end
          end


  -- divine_toll,if=(!raid_event.adds.exists|raid_event.adds.in>10)
  if RubimRH.CDsON() and S.DivineToll:IsReady() and targetRange30 and inRange30>=3 and HL.CombatTime()>2 then
    return S.DivineToll:Cast()
end
  -- avengers_shield,if=spell_targets.avengers_shield>2|buff.moment_of_glory.up
  if S.AvengersShield:IsCastable() and targetRange30 and (inRange30 > 2 or Player:Buff(S.MomentofGloryBuff)) then
    return S.AvengersShield:Cast()
end

 -- consecration,if=buff.sanctification.stack=buff.sanctification.max_stack
 if S.Consecration:IsCastable() and (targetRange8 and not Player:IsMoving() or targetRange5 and  Player:IsMoving()) and (Player:BuffStack(S.SanctificationBuff) == 5 or not AuraUtil.FindAuraByName("Consecration", "player")) then
    return S.Consecration:Cast()
end
  -- shield_of_the_righteous,if=(((!talent.righteous_protector.enabled|cooldown.righteous_protector_icd.remains=0)&holy_power>2)|buff.bastion_of_light.up|buff.divine_purpose.up)&(!buff.sanctification.up|buff.sanctification.stack<buff.sanctification.max_stack)
  -- TODO: Find a way to track RighteousProtector ICD.
  if S.ShieldoftheRighteous:IsReady() and targetRange8 and ((Player:HolyPower() > 2 or Player:Buff(S.BastionofLightBuff) or Player:Buff(S.DivinePurposeBuff)) and (not Player:Buff(S.SanctificationBuff) or Player:BuffStack(S.SanctificationBuff) < 5)) then
    return S.ShieldoftheRighteous:Cast()
end
  -- judgment,target_if=min:debuff.judgment.remains,if=spell_targets.shield_of_the_righteous>3&buff.bulwark_of_righteous_fury.stack>=3&holy_power<3
  if S.Judgment:IsReady() and targetRange30 and (inRange10 > 3 and Player:BuffStack(S.BulwarkofRighteousFuryBuff) >= 3 and Player:HolyPower() < 3) then
    return S.Judgment:Cast()
end

  -- judgment,target_if=min:debuff.judgment.remains,if=!buff.sanctification_empower.up&set_bonus.tier31_2pc
  if S.Judgment:IsReady() and targetRange30 and (not Player:Buff(S.SanctificationEmpowerBuff) and tierequipped()>=2) then
    return S.Judgment:Cast()
end
  -- hammer_of_wrath
  if S.HammerofWrath:IsReady() and targetRange30 then
    return S.HammerofWrath:Cast()
end
  -- judgment,target_if=min:debuff.judgment.remains,if=charges>=2|full_recharge_time<=gcd.max
  if S.Judgment:IsReady() and targetRange30 and (S.Judgment:Charges() >= 2 or S.Judgment:FullRechargeTime() <= Player:GCD() + 0.25) then
    return S.Judgment:Cast()
end

  -- divine_toll,if=(!raid_event.adds.exists|raid_event.adds.in>10)
  if RubimRH.CDsON() and S.DivineToll:IsReady()  and targetRange30 and inRange30>=3 then
    return S.DivineToll:Cast()
end
  -- avengers_shield
  if S.AvengersShield:IsCastable() and targetRange30 then
    return S.AvengersShield:Cast()
end
  -- judgment,target_if=min:debuff.judgment.remains
  if S.Judgment:IsReady() and targetRange30 then
    return S.Judgment:Cast()
end
  -- consecration,if=!consecration.up&(!buff.sanctification.stack=buff.sanctification.max_stack|!set_bonus.tier31_2pc)
  if S.Consecration:IsCastable() and  (targetRange8 and not Player:IsMoving() or targetRange5 and  Player:IsMoving()) and (not Player:Buff(S.ConsecrationBuff) and (Player:BuffStack(S.SanctificationBuff) ~= 5 or tierequipped()<2)) then
    return S.Consecration:Cast()
end
  -- eye_of_tyr,if=talent.inmost_light.enabled&raid_event.adds.in>=45|spell_targets.shield_of_the_righteous>=3
  if RubimRH.CDsON() and targetRange8 and S.EyeofTyr:IsCastable() and (S.InmostLight:IsAvailable() or inRange8 >= 3) then
    return S.EyeofTyr:Cast()
end
  -- blessed_hammer
  if S.BlessedHammer:IsCastable() and targetRange8 then
    return S.BlessedHammer:Cast()
end
  -- hammer_of_the_righteous
  if S.HammeroftheRighteous:IsCastable() and targetRange8 then
    return S.HammeroftheRighteous:Cast()
end
  -- crusader_strike
  if S.CrusaderStrike:IsCastable()  and targetRange8 then
    return S.CrusaderStrike:Cast()
end
  -- eye_of_tyr,if=!talent.inmost_light.enabled&raid_event.adds.in>=60|spell_targets.shield_of_the_righteous>=3
  if RubimRH.CDsON() and targetRange8 and S.EyeofTyr:IsCastable() and (not S.InmostLight:IsAvailable() or inRange8 >= 3) then
    return S.EyeofTyr:Cast()
end
  -- word_of_glory,if=buff.shining_light_free.up
  if S.WordofGlory:IsReady()  and (Player:Buff(S.ShiningLightFreeBuff)) and  Player:HealthPercentage() <= 80 then
            return S.WordofGlory:Cast()
            end


  -- consecration,if=!buff.sanctification_empower.up
  if S.Consecration:IsCastable() and (targetRange8 and not Player:IsMoving() or targetRange5 and  Player:IsMoving()) and (not Player:Buff(S.SanctificationEmpowerBuff)) then
    return S.Consecration:Cast()
end

    end

        -- call precombat
        if not Player:AffectingCombat() then
            if S.WordofGlory:IsCastable() and not Player:HealingAbsorbed() and Player:HealthPercentage() < 75 and
            (Player:HolyPower() >= 3 or AuraUtil.FindAuraByName("Divine Purpose", "player")  or Player:Buff(S.ShiningLightFreeBuff) ) then
            return S.WordofGlory:Cast()
            end

            if S.DevotionAura:IsCastable() and not AuraUtil.FindAuraByName("Devotion Aura", "player") then
            return S.DevotionAura:Cast()
            end

            if S.BlessedHammer:IsCastable() and Player:IsMoving() and IsResting("player") == false 
            and inRange30 >= 1 and inRange10 == 0 
            and (S.BlessedHammer:ChargesFractional() >= 2.9 and Player:HolyPower() < 5 or
            S.BlessedHammer:ChargesFractional() >= 0.9 and Player:HolyPower() < 3)
            then
            return S.BlessedHammer:Cast()
            end




            return 0, "Interface\\Addons\\Rubim-RH\\Media\\prot.tga"
        end

return 0, 135328
end

RubimRH.Rotation.SetAPL(66, APL)

-- local function PASSIVE()

-- end

-- RubimRH.Rotation.SetPASSIVE(66, PASSIVE)
