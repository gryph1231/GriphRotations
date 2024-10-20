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

if not Spell.DeathKnight then
    Spell.DeathKnight = {};
end

RubimRH.Spell[251] = {
	 -- Abilities
     DeathandDecay                         = Spell(43265),
     DeathCoil                             = Spell(47541),
     -- Talents
     AbominationLimb                       = Spell(383269),
     AntiMagicBarrier                      = Spell(205727),
     AntiMagicShell                        = Spell(48707),
     AntiMagicZone                         = Spell(51052),
     Asphyxiate                            = Spell(221562),
     Assimilation                          = Spell(374383),
     ChainsofIce                           = Spell(45524),
     CleavingStrikes                       = Spell(316916),
     DeathStrike                           = Spell(49998),
     EmpowerRuneWeapon                     = Spell(47568),
     IceboundFortitude                     = Spell(48792),
     IcyTalons                             = Spell(194878),
     RaiseDead                             = Spell(46585),
     RunicAttenuation                      = Spell(207104),
     SacrificialPact                       = Spell(327574),
     SoulReaper                            = Spell(343294),
     UnholyGround                          = Spell(374265),
     UnyieldingWill                        = Spell(457574),
     -- Buffs
     AbominationLimbBuff                   = Spell(383269),
     DeathandDecayBuff                     = Spell(188290),
     DeathStrikeBuff                       = Spell(101568),
     EmpowerRuneWeaponBuff                 = Spell(47568),
     IcyTalonsBuff                         = Spell(194879),
     RuneofHysteriaBuff                    = Spell(326918),
     UnholyStrengthBuff                    = Spell(53365),
     -- Debuffs
     BloodPlagueDebuff                     = Spell(55078),
     FrostFeverDebuff                      = Spell(55095),
     MarkofFyralathDebuff                  = Spell(414532),
     SoulReaperDebuff                      = Spell(343294),
     VirulentPlagueDebuff                  = Spell(191587),
     -- Racials
     AncestralCall                         = Spell(274738),
     ArcanePulse                           = Spell(260364),
     ArcaneTorrent                         = Spell(50613),
     BagofTricks                           = Spell(312411),
     Berserking                            = Spell(26297),
     BloodFury                             = Spell(20572),
     Fireblood                             = Spell(265221),
     LightsJudgment                        = Spell(255647),
     -- Interrupts
     MindFreeze                            = Spell(47528),
     -- Custom
     Lichborne = Spell(20549), -- war stomp
RaiseAlly = Spell(61999),
-- Talents
DarkTalons                            = Spell(436687),
Exterminate                           = Spell(441378),
ReapersMark                           = Spell(439843),
-- Buffs
ExterminateBuff                       = Spell(441416),
PainfulDeathBuff                      = Spell(447954),
-- Debuffs
ReapersMarkDebuff                     = Spell(434765),

  -- Talents
  AFeastofSouls                         = Spell(444072),
  ApocalypseNow                         = Spell(444040),
  -- Buffs
  AFeastofSoulsBuff                     = Spell(440861),
  MograinesMightBuff                    = Spell(444505),
  -- Debuffs
  TrollbaneSlowDebuff                   = Spell(444834),

 -- Abilities
 VampiricStrikeAction                  = Spell(433895),
 -- Talents
 GiftoftheSanlayn                      = Spell(434152),
 VampiricStrike                        = Spell(433901),
 -- Buffs
 EssenceoftheBloodQueenBuff            = Spell(433925),
 GiftoftheSanlaynBuff                  = Spell(434153),
 InflictionofSorrowBuff                = Spell(460049),
 VampiricStrikeBuff                    = Spell(433899),
 -- Debuffs
 InciteTerrorDebuff                    = Spell(458478),
-- Abilities
FrostStrike                           = Spell(49143),
HowlingBlast                          = Spell(49184),
-- Talents
ArcticAssault                         = Spell(456230),
Avalanche                             = Spell(207142),
BitingCold                            = Spell(377056),
Bonegrinder                           = Spell(377098),
BreathofSindragosa                    = Spell(152279),
ChillStreak                           = Spell(305392),
ColdHeart                             = Spell(281208),
EnduringStrength                      = Spell(377190),
FrigidExecutioner                     = Spell(377073),
DeathGrip = Spell(49576),
Frostscythe                           = Spell(207230),
FrostwyrmsFury                        = Spell(279302),
GatheringStorm                        = Spell(194912),
GlacialAdvance                        = Spell(194913),
HornofWinter                          = Spell(57330),
Icebreaker                            = Spell(392950),
Icecap                                = Spell(207126),
Obliterate                            = Spell(49020),
Obliteration                          = Spell(281238),
PillarofFrost                         = Spell(51271),
RageoftheFrozenChampion               = Spell(377076),
RemorselessWinter                     = Spell(196770),
ShatteredFrost                        = Spell(455993),
ShatteringBlade                       = Spell(207057),
SmotheringOffense                     = Spell(435005),
TheLongWinter                         = Spell(456240),
UnleashedFrenzy                       = Spell(376905),
-- Buffs
BonegrinderFrostBuff                  = Spell(377103),
ColdHeartBuff                         = Spell(281209),
KillingMachineBuff                    = Spell(51124),
PillarofFrostBuff                     = Spell(51271),
RimeBuff                              = Spell(59052),
UnleashedFrenzyBuff                   = Spell(376907),
-- Debuffs
RazoriceDebuff                        = Spell(51714),

lust1    = Spell(57724),
lust2    = Spell(57723),
lust3    = Spell(80354),
lust4    = Spell(95809),
lust5    = Spell(264689),
lustAT   = Spell(155145), -- war stomp
autoattack = Spell(59752), -- will to survive (human racial)






}

local S = RubimRH.Spell[251] 

if not Item.DeathKnight then Item.DeathKnight = {}; end

Item.DeathKnight.Frost = {
    HPIcon = Item(169451),


};

local I = Item.DeathKnight.Frost;


local function num(val)
    if val then
        return 1
    else
        return 0
    end
end



--- ===== Rotation Variables =====
local VarPillarCD = (S.Icecap:IsAvailable()) and 45 or 60
local MainHandLink, OffHandLink
local MainHandRuneforge, OffHandRuneforge
local UsingRazorice, UsingFallenCrusader
local Var2HCheck
local VarRWBuffs = S.GatheringStorm:IsAvailable() or S.BitingCold:IsAvailable()
local VarSTPlanning, VarAddsRemain, VarSendingCDs
local VarRimeBuffs, VarRPBuffs, VarCDCheck
local VarOblitPoolingTime, VarBreathPoolingTime
local VarPoolingRunes, VarPoolingRP
local VarGAPriority, VarBreathDying
local EnemiesMeleeCount
local GCDMax


local function FFTargets()
    -- local inRange15 = 0
    local FSAoe = 0
    
        -- for id = 1, 40 do
        --     local unitID = "nameplate" .. id
        --     if UnitCanAttack("player", unitID) and C_Item.IsItemInRange(33069, unitID) then
        --         inRange15 = inRange15 + 1
        --     end
        -- end
        
        for id = 1, 40 do
        local unitID = "nameplate" .. id
            if UnitCanAttack("player", unitID) and C_Item.IsItemInRange(33069, unitID) and AuraUtil.FindAuraByName("Frost Fever",unitID,"PLAYER|HARMFUL") then
                FSAoe = FSAoe + 1
            end
        end
    
        return FSAoe
    end


local function SetSpellVariables()
    VarBreathRPCost = 17
    VarStaticRimeBuffs = S.RageoftheFrozenChampion:IsAvailable() or S.Icebreaker:IsAvailable()
    VarBreathRPThreshold = 60
    VarERWBreathRPTrigger = 70
    VarERWBreathRuneTrigger = 3
    VarOblitRunePooling = 4
    VarBreathRimeRPThreshold = 60
  end
  SetSpellVariables()

  --- ===== Weapon Variables =====
local function SetWeaponVariables()
    MainHandLink = GetInventoryItemLink("player", 16) or ""
    OffHandLink = GetInventoryItemLink("player", 17) or ""
    MainHandRuneforge = select(3, strsplit(":", MainHandLink))
    OffHandRuneforge = select(3, strsplit(":", OffHandLink))
    UsingRazorice = (MainHandRuneforge == "3370" or OffHandRuneforge == "3370")
    UsingFallenCrusader = (MainHandRuneforge == "3368" or OffHandRuneforge == "3368")
    Var2HCheck = IsEquippedItemType("Two-Hand")
  end
  SetWeaponVariables()





  HL:RegisterForEvent(function()
    VarRWBuffs = S.GatheringStorm:IsAvailable() or S.BitingCold:IsAvailable()

    SetWeaponVariables()
    SetSpellVariables()
  end, "PLAYER_EQUIPMENT_CHANGED", "SPELLS_CHANGED", "LEARNED_SPELL_IN_TAB")




--- ===== Helper Functions =====
local function DeathStrikeHeal()
    return ((Player:HealthPercentage() < 55 and Player:BuffUp(S.DeathStrikeBuff)))
  end
  
  --- ===== CastTargetIf Filter Functions =====
  local function EvaluateTargetIfFilterFrostStrike(TargetUnit)
    -- target_if=max:((talent.shattering_blade&debuff.razorice.stack=5)*5)+(debuff.razorice.stack+1)%(debuff.razorice.remains+1)*death_knight.runeforge.razorice
    return (num(S.ShatteringBlade:IsAvailable() and TargetUnit:DebuffStack(S.RazoriceDebuff) == 5) * 5) + (TargetUnit:DebuffStack(S.RazoriceDebuff) + 1) / (TargetUnit:DebuffRemains(S.RazoriceDebuff) + 1) * num(UsingRazorice)
  end
  
  local function EvaluateTargetIfFilterObliterate(TargetUnit)
    -- target_if=max:(debuff.razorice.stack+1)%(debuff.razorice.remains+1)*death_knight.runeforge.razorice+((hero_tree.deathbringer&debuff.reapers_mark_debuff.down)*5)
    return (TargetUnit:DebuffStack(S.RazoriceDebuff) + 1) / (TargetUnit:DebuffRemains(S.RazoriceDebuff) + 1) * num(UsingRazorice) + (num(Player:HeroTreeID() == 33 and Target:DebuffDown(S.ReapersMarkDebuff)) * 5)
  end
  
  local function EvaluateTargetIfFilterRazoriceStacks(TargetUnit)
    -- target_if=max:(debuff.razorice.stack)
    return TargetUnit:DebuffStack(S.RazoriceDebuff)
  end
  
  local function EvaluateTargetIfFilterRazoriceStacksModified(TargetUnit)
    -- target_if=max:(debuff.razorice.stack+1)%(debuff.razorice.remains+1)*death_knight.runeforge.razorice
    return (TargetUnit:DebuffStack(S.RazoriceDebuff) + 1) / (TargetUnit:DebuffRemains(S.RazoriceDebuff) + 1) * num(UsingRazorice)
  end
  
  --- ===== CastTargetIf Condition Functions =====
  local function EvaluateTargetIfFrostStrikeAoE(TargetUnit)
    -- if=!variable.pooling_runic_power&debuff.razorice.stack=5&talent.shattering_blade&(talent.shattered_frost|active_enemies<4)
    -- Note: Variable, talent, and enemy count checks performed before CastTargetIf.
    return TargetUnit:DebuffStack(S.RazoriceDebuff) == 5
  end
  
  local function EvaluateTargetIfFrostStrikeObliteration(TargetUnit)
    -- if=debuff.razorice.stack=5&talent.shattering_blade&talent.a_feast_of_souls&buff.a_feast_of_souls.up&!talent.arctic_assault
    -- Note: All but RazoriceDebuff stacks checked before CastTargetIf.
    return TargetUnit:DebuffStack(S.RazoriceDebuff)
  end
  
  local function EvaluateTargetIfFrostStrikeObliteration2(TargetUnit)
    -- if=(rune<2|variable.rp_buffs|debuff.razorice.stack=5&talent.shattering_blade|hero_tree.rider_of_the_apocalypse)&!variable.pooling_runic_power&(!talent.glacial_advance|active_enemies=1|talent.shattered_frost)
    -- Note: '&!variable.pooling_runic_power&(!talent.glacial_advance|active_enemies=1|talent.shattered_frost)' performed before CastTargetIf.
    return Player:Rune() < 2 or VarRPBuffs or TargetUnit:DebuffStack(S.RazoriceDebuff) == 5 and S.ShatteringBlade:IsAvailable()
  end
  
  local function EvaluateTargetIfGlacialAdvanceAoE(TargetUnit)
    -- if=!variable.pooling_runic_power&(variable.ga_priority|debuff.razorice.stack<5)
    -- Note: pooling_runic_power check performed before CastTargetIf.
    return VarGAPriority or TargetUnit:DebuffStack(S.RazoriceDebuff) < 5
  end
  
  local function EvaluateTargetIfGlacialAdvanceObliteration(TargetUnit)
    -- if=(variable.ga_priority|debuff.razorice.stack<5)&(!death_knight.runeforge.razorice&(debuff.razorice.stack<5|debuff.razorice.remains<gcd*3)|((variable.rp_buffs|rune<2)&active_enemies>1))
    return (VarGAPriority or TargetUnit:DebuffStack(S.RazoriceDebuff) < 5) and (not UsingRazorice and (TargetUnit:DebuffStack(S.RazoriceDebuff) < 5 or TargetUnit:DebuffRemains(S.RazoriceDebuff) < Player:GCD() * 3) or ((VarRPBuffs or Player:Rune() < 2) and EnemiesMeleeCount > 1))
  end
  
  --- ===== CastCycle Functions =====
  local function EvaluateCycleReapersMarkCDs(TargetUnit)
    -- target_if=first:!debuff.reapers_mark_debuff.up
    return TargetUnit:DebuffDown(S.ReapersMarkDebuff)
  end
  



--- ===== Rotation Functions =====
local function Precombat()
    
    if IsReady("Howling Blast") and Player:IsMoving() and C_Spell.IsCurrentSpell(6603) and TargetinRange(30) then
      return S.HowlingBlast:Cast()
    end
    if IsReady("Remorseless Winter") and TargetinRange(10) and Player:IsMoving() and C_Spell.IsCurrentSpell(6603) then
        return S.RemorselessWinter:Cast()
    end
  end




  local function AoE()
    -- obliterate,target_if=max:(debuff.razorice.stack+1)%(debuff.razorice.remains+1)*death_knight.runeforge.razorice+((hero_tree.deathbringer&debuff.reapers_mark_debuff.down)*5),if=buff.killing_machine.react&talent.cleaving_strikes&buff.death_and_decay.up
    if IsReady("Obliterate") and TargetinRange(5) and (Player:BuffUp(S.KillingMachineBuff) and S.CleavingStrikes:IsAvailable() and Player:BuffUp(S.DeathandDecayBuff)) and EvaluateTargetIfFilterObliterate then
   return S.Obliterate:Cast()
    end
    -- howling_blast,target_if=!dot.frost_fever.ticking
    -- Note: Instead of iterating targets, checking AuraActiveCount.
    if IsReady("Howling Blast") and TargetinRange(30) and (FFTargets() < EnemiesMeleeCount) then
        return S.HowlingBlast:Cast()
    end
    -- frost_strike,target_if=max:((talent.shattering_blade&debuff.razorice.stack=5)*5)+(debuff.razorice.stack+1)%(debuff.razorice.remains+1)*death_knight.runeforge.razorice,if=!variable.pooling_runic_power&debuff.razorice.stack=5&talent.shattering_blade&(talent.shattered_frost|active_enemies<4)
    if IsReady("Frost Strike") and TargetinRange(5) and (not VarPoolingRP and S.ShatteringBlade:IsAvailable() and (S.ShatteredFrost:IsAvailable() or EnemiesMeleeCount < 4)) and EvaluateTargetIfFilterFrostStrike then
        return S.FrostStrike:Cast()
    end
    -- howling_blast,if=buff.rime.react
    if IsReady("Howling Blast") and TargetinRange(30) and (Player:BuffUp(S.RimeBuff)) then
        return S.HowlingBlast:Cast()
    end
    -- glacial_advance,target_if=max:(debuff.razorice.stack),if=!variable.pooling_runic_power&(variable.ga_priority|debuff.razorice.stack<5)
    if IsReady("Glacial Advance") and TargetinRange(10) and (not VarPoolingRP) and (EvaluateTargetIfFilterRazoriceStacks or EvaluateTargetIfGlacialAdvanceAoE) then
        return S.GlacialAdvance:Cast()
    end
    -- obliterate
    if IsReady("Obliterate") and TargetinRange(5) then
        return S.Obliterate:Cast()
    end
    -- frost_strike,target_if=max:((talent.shattering_blade&debuff.razorice.stack=5)*5)+(debuff.razorice.stack+1)%(debuff.razorice.remains+1)*death_knight.runeforge.razorice,if=!variable.pooling_runic_power
    if IsReady("Frost Strike") and TargetinRange(5) and (not VarPoolingRP) and EvaluateTargetIfFilterFrostStrike then
        return S.FrostStrike:Cast()
    end
    -- horn_of_winter,if=rune<2&runic_power.deficit>25&(!talent.breath_of_sindragosa|variable.true_breath_cooldown>cooldown.horn_of_winter.duration-15)
    if IsReady("Horn of Winter") and TargetinRange(10) and (Player:Rune() < 2 and Player:RunicPowerDeficit() > 25 and (not S.BreathofSindragosa:IsAvailable() or VarTrueBreathCD > 30)) then
        return S.HornofWinter:Cast()
    end
    -- arcane_torrent,if=runic_power.deficit>25
    if RubimRH.CDsON() and TargetinRange(8) and IsReady("Arcane Torrent") and (Player:RunicPowerDeficit() > 25) then
        return S.ArcaneTorrent:Cast()
    end
  end
  
  local function Breath()
    -- obliterate,target_if=max:(debuff.razorice.stack+1)%(debuff.razorice.remains+1)*death_knight.runeforge.razorice+((hero_tree.deathbringer&debuff.reapers_mark_debuff.down)*5),if=buff.killing_machine.react=2
    if IsReady("Obliterate") and TargetinRange(5) and (Player:BuffStack(S.KillingMachineBuff) == 2) and EvaluateTargetIfFilterObliterate then
        return S.Obliterate:Cast()
    end
    -- howling_blast,if=variable.rime_buffs&runic_power>(variable.breath_rime_rp_threshold-(talent.rage_of_the_frozen_champion*(dbc.effect.842306.base_value%10)))|!dot.frost_fever.ticking
    -- Note: dbc.effect.842306.base_value as of 11.0.0.55793 is 60.
    if IsReady("Howling Blast") and TargetinRange(30) and (VarRimeBuffs and Player:RunicPower() > (VarBreathRimeRPThreshold - (num(S.RageoftheFrozenChampion:IsAvailable()) * 6)) or Target:DebuffDown(S.FrostFeverDebuff)) then
        return S.HowlingBlast:Cast()
    end
    -- horn_of_winter,if=rune<2&runic_power.deficit>30&(!buff.empower_rune_weapon.up|runic_power<variable.breath_rp_cost*2*gcd.max)
    if IsReady("Horn of Winter") and TargetinRange(10) and (Player:Rune() < 2 and Player:RunicPowerDeficit() > 30 and (Player:BuffDown(S.EmpowerRuneWeaponBuff) or Player:RunicPower() < VarBreathRPCost * 2 * Player:GCD())) then
        return S.HornofWinter:Cast()
    end
    -- obliterate,target_if=max:(debuff.razorice.stack+1)%(debuff.razorice.remains+1)*death_knight.runeforge.razorice+((hero_tree.deathbringer&debuff.reapers_mark_debuff.down)*5),if=buff.killing_machine.react|runic_power.deficit>20
    if IsReady("Obliterate") and TargetinRange(5) and (Player:BuffUp(S.KillingMachineBuff) or Player:RunicPowerDeficit() > 20) then
        return S.Obliterate:Cast()
    end
    -- remorseless_winter,if=variable.breath_dying
    if IsReady("Remorseless Winter") and TargetinRange(10) and (VarBreathDying) then
        return S.RemorselessWinter:Cast()
    end
    -- death_and_decay,if=!death_and_decay.ticking&(variable.st_planning&talent.unholy_ground&runic_power.deficit>=10&!talent.obliteration|variable.breath_dying)
    if IsReady("Death and Decay") and TargetinRange(5) and (Player:BuffDown(S.DeathandDecayBuff) and (VarSTPlanning and S.UnholyGround:IsAvailable() and Player:RunicPowerDeficit() >= 10 and not S.Obliteration:IsAvailable() or VarBreathDying)) then
        return S.DeathandDecay:Cast()
    end
    -- howling_blast,if=variable.breath_dying
    if IsReady("Howling Blast") and TargetinRange(30) and (VarBreathDying) then
        return S.HowlingBlast:Cast()
    end
    -- arcane_torrent,if=runic_power<60
    if IsReady("Arcane Torrent") and TargetinRange(8) and (Player:RunicPower() < 60) then
        return S.ArcaneTorrent:Cast()
    end
    -- howling_blast,if=buff.rime.react
    if IsReady("Howling Blast") and TargetinRange(30) and (Player:BuffUp(S.RimeBuff)) then
        return S.HowlingBlast:Cast()
    end
  end
  
  local function ColdHeart()
    -- chains_of_ice,if=fight_remains<gcd&(rune<2|!buff.killing_machine.react&(!main_hand.2h&buff.cold_heart.stack>=4|main_hand.2h&buff.cold_heart.stack>8)|buff.killing_machine.react&(!main_hand.2h&buff.cold_heart.stack>8|main_hand.2h&buff.cold_heart.stack>10))
    if IsReady("Chains of Ice") and TargetinRange(30) and (FightRemains < Player:GCD() and (Player:Rune() < 2 or Player:BuffDown(S.KillingMachineBuff) and (not Var2HCheck and Player:BuffStack(S.ColdHeartBuff) >= 4 or Var2HCheck and Player:BuffStack(S.ColdHeartBuff) > 8) or Player:BuffUp(S.KillingMachineBuff) and (not Var2HCheck and Player:BuffStack(S.ColdHeartBuff) > 8 or Var2HCheck and Player:BuffStack(S.ColdHeartBuff) > 10))) then
        return S.ChainsofIce:Cast()
    end
    -- chains_of_ice,if=!talent.obliteration&buff.pillar_of_frost.up&buff.cold_heart.stack>=10&(buff.pillar_of_frost.remains<gcd*(1+(talent.frostwyrms_fury&cooldown.frostwyrms_fury.ready))|buff.unholy_strength.up&buff.unholy_strength.remains<gcd)
    if IsReady("Chains of Ice") and TargetinRange(30) and (not S.Obliteration:IsAvailable() and Player:BuffUp(S.PillarofFrostBuff) and Player:BuffStack(S.ColdHeartBuff) >= 10 and (Player:BuffRemains(S.PillarofFrostBuff) < Player:GCD() * (1 + num(S.FrostwyrmsFury:IsAvailable() and S.FrostwyrmsFury:IsReady())) or Player:BuffUp(S.UnholyStrengthBuff) and Player:BuffRemains(S.UnholyStrengthBuff) < Player:GCD())) then
        return S.ChainsofIce:Cast()
    end
    -- chains_of_ice,if=!talent.obliteration&death_knight.runeforge.fallen_crusader&!buff.pillar_of_frost.up&cooldown.pillar_of_frost.remains>15&(buff.cold_heart.stack>=10&buff.unholy_strength.up|buff.cold_heart.stack>=13)
    if IsReady("Chains of Ice") and TargetinRange(30) and (not S.Obliteration:IsAvailable() and UsingFallenCrusader and Player:BuffDown(S.PillarofFrostBuff) and S.PillarofFrost:CooldownRemains() > 15 and (Player:BuffStack(S.ColdHeartBuff) >= 10 and Player:BuffUp(S.UnholyStrengthBuff) or Player:BuffStack(S.ColdHeartBuff) >= 13)) then
        return S.ChainsofIce:Cast()
    end
    -- chains_of_ice,if=!talent.obliteration&!death_knight.runeforge.fallen_crusader&buff.cold_heart.stack>=10&!buff.pillar_of_frost.up&cooldown.pillar_of_frost.remains>20
    if IsReady("Chains of Ice") and TargetinRange(30) and (not S.Obliteration:IsAvailable() and not UsingFallenCrusader and Player:BuffStack(S.ColdHeartBuff) >= 10 and Player:BuffDown(S.PillarofFrostBuff) and S.PillarofFrost:CooldownRemains() > 20) then
        return S.ChainsofIce:Cast()
    end
    -- chains_of_ice,if=talent.obliteration&!buff.pillar_of_frost.up&(buff.cold_heart.stack>=14&buff.unholy_strength.up|buff.cold_heart.stack>=19|cooldown.pillar_of_frost.remains<3&buff.cold_heart.stack>=14)
    if IsReady("Chains of Ice")  and TargetinRange(30) and (S.Obliteration:IsAvailable() and Player:BuffDown(S.PillarofFrostBuff) and (Player:BuffStack(S.ColdHeartBuff) >= 14 and Player:BuffUp(S.UnholyStrengthBuff) or Player:BuffStack(S.ColdHeartBuff) >= 19 or S.PillarofFrost:CooldownRemains() < 3 and Player:BuffStack(S.ColdHeartBuff) >= 14)) then
        return S.ChainsofIce:Cast()
    end
  end
  
  local function Cooldowns()
    -- potion,if=(talent.pillar_of_frost&buff.pillar_of_frost.up|!talent.pillar_of_frost&buff.empower_rune_weapon.up|!talent.pillar_of_frost&!talent.empower_rune_weapon|active_enemies>=2&buff.pillar_of_frost.up)|fight_remains<25
    -- if Settings.Commons.Enabled.Potions and ((S.PillarofFrost:IsAvailable() and Player:BuffUp(S.PillarofFrostBuff) or not S.PillarofFrost:IsAvailable() and Player:BuffUp(S.EmpowerRuneWeaponBuff) or not S.PillarofFrost:IsAvailable() and not S.EmpowerRuneWeapon:IsAvailable() or EnemiesMeleeCount >= 2 and Player:BuffUp(S.PillarofFrostBuff)) or BossFightRemains < 25) then
    --   local PotionSelected = Everyone.PotionSelected()
    --   if PotionSelected and PotionSelected:IsReady() then
    --     if Cast(PotionSelected, nil, Settings.CommonsDS.DisplayStyle.Potions) then return "potion cooldowns 2"; end
    --   end
    -- end
    -- abomination_limb,if=talent.obliteration&!buff.pillar_of_frost.up&variable.sending_cds|fight_remains<15
    -- abomination_limb,if=!talent.obliteration&variable.sending_cds
    -- Note: Combined the lines.
    if S.AbominationLimb:IsCastable()  and TargetinRange(10) and ((S.Obliteration:IsAvailable() and Player:BuffDown(S.PillarofFrostBuff) and VarSendingCDs or BossFightRemains < 15) or (not S.Obliteration:IsAvailable() and VarSendingCDs)) then
        return S.AbominationLimb:Cast()
    end
    -- remorseless_winter,if=variable.rw_buffs&variable.sending_cds&(!talent.arctic_assault|!buff.pillar_of_frost.up)&fight_remains>10
    if IsReady("Remorseless Winter")  and TargetinRange(10) and (VarRWBuffs and VarSendingCDs and (not S.ArcticAssault:IsAvailable() or Player:BuffDown(S.PillarofFrostBuff)) and FightRemains > 10) then
        return S.RemorselessWinter:Cast()
    end
    -- chill_streak,if=variable.sending_cds&(!talent.arctic_assault|!buff.pillar_of_frost.up)
    if IsReady("Chill Streak")  and TargetinRange(10) and (VarSendingCDs and (not S.ArcticAssault:IsAvailable() or Player:BuffDown(S.PillarofFrostBuff))) then
        return S.ChillStreak:Cast()
    end
    -- reapers_mark,target_if=first:debuff.reapers_mark_debuff.down,if=!talent.breath_of_sindragosa&(buff.pillar_of_frost.up|cooldown.pillar_of_frost.remains>10)|talent.breath_of_sindragosa
    if IsReady("Reaper's Mark")  and TargetinRange(10) and EvaluateCycleReapersMarkCDs and (not S.BreathofSindragosa:IsAvailable() and (Player:BuffUp(S.PillarofFrostBuff) or S.PillarofFrost:CooldownRemains() > 10) or S.BreathofSindragosa:IsAvailable()) then
        return S.ReapersMark:Cast()
    end
    -- empower_rune_weapon,if=talent.obliteration&!talent.breath_of_sindragosa&buff.pillar_of_frost.up|fight_remains<20
    if IsReady("Empower Rune Weapon")  and TargetinRange(10) and (S.Obliteration:IsAvailable() and not S.BreathofSindragosa:IsAvailable() and Player:BuffUp(S.PillarofFrostBuff) or BossFightRemains < 20) then
        return S.EmpowerRuneWeapon:Cast()
    end
    -- empower_rune_weapon,if=buff.breath_of_sindragosa.up&runic_power<variable.erw_breath_rp_trigger&rune<variable.erw_breath_rune_trigger
    if IsReady("Empower Rune Weapon")  and TargetinRange(10) and (Player:BuffUp(S.BreathofSindragosa) and Player:RunicPower() < VarERWBreathRPTrigger and Player:Rune() < VarERWBreathRuneTrigger) then
        return S.EmpowerRuneWeapon:Cast()
    end
    -- empower_rune_weapon,if=!talent.breath_of_sindragosa&!talent.obliteration&!buff.empower_rune_weapon.up&rune<5&(cooldown.pillar_of_frost.remains<7|buff.pillar_of_frost.up|!talent.pillar_of_frost)
    if IsReady("Empower Rune Weapon")  and TargetinRange(10) and (not S.BreathofSindragosa:IsAvailable() and not S.Obliteration:IsAvailable() and Player:BuffDown(S.EmpowerRuneWeaponBuff) and Player:Rune() < 5 and (S.PillarofFrost:CooldownRemains() < 7 or Player:BuffUp(S.PillarofFrostBuff) or not S.PillarofFrost:IsAvailable())) then
        return S.EmpowerRuneWeapon:Cast()
    end
    -- pillar_of_frost,if=talent.obliteration&!talent.breath_of_sindragosa&variable.sending_cds|fight_remains<20
    if IsReady("Pillar of Frost")  and TargetinRange(10) and (S.Obliteration:IsAvailable() and not S.BreathofSindragosa:IsAvailable() and VarSendingCDs or BossFightRemains < 20) then
        return S.PillarofFrost:Cast()
    end
    -- pillar_of_frost,if=talent.breath_of_sindragosa&variable.sending_cds&cooldown.breath_of_sindragosa.remains&buff.unleashed_frenzy.up
    if IsReady("Pillar of Frost")  and TargetinRange(10) and (S.BreathofSindragosa:IsAvailable() and VarSendingCDs and S.BreathofSindragosa:CooldownDown() and Player:BuffUp(S.UnleashedFrenzyBuff)) then
        return S.PillarofFrost:Cast()
    end
    -- pillar_of_frost,if=!talent.obliteration&!talent.breath_of_sindragosa&variable.sending_cds
    if IsReady("Pillar of Frost")  and TargetinRange(10) and (not S.Obliteration:IsAvailable() and not S.BreathofSindragosa:IsAvailable() and VarSendingCDs) then
        return S.PillarofFrost:Cast()
    end
    -- breath_of_sindragosa,use_off_gcd=1,if=!buff.breath_of_sindragosa.up&runic_power>variable.breath_rp_threshold&(rune<2|runic_power>80)&(cooldown.pillar_of_frost.ready&variable.sending_cds|fight_remains<30)|(time<10&rune<1)
    if IsReady("Breath of Sindragosa")  and TargetinRange(10) and (Player:BuffDown(S.BreathofSindragosa) and Player:RunicPower() > VarBreathRPThreshold and (Player:Rune() < 2 or Player:RunicPower() > 80) and (S.PillarofFrost:CooldownUp() and VarSendingCDs or BossFightRemains < 30) or (HL.CombatTime() < 10 and Player:Rune() < 1)) then
        return S.BreathofSindragosa:Cast()
    end
    -- -- frostwyrms_fury,if=hero_tree.rider_of_the_apocalypse&talent.apocalypse_now&variable.sending_cds&(!talent.breath_of_sindragosa&buff.pillar_of_frost.up|buff.breath_of_sindragosa.up)|fight_remains<20
    -- if IsReady("Frostwyrm's Fury") and (Player:HeroTreeID() == 32 and S.ApocalypseNow:IsAvailable() and VarSendingCDs and (not S.BreathofSindragosa:IsAvailable() and Player:BuffUp(S.PillarofFrostBuff) or Player:BuffUp(S.BreathofSindragosa)) or BossFightRemains < 30) then
    --     return S.FrostwyrmsFury:Cast()
    -- end
    -- -- frostwyrms_fury,if=!talent.apocalypse_now&active_enemies=1&(talent.pillar_of_frost&buff.pillar_of_frost.up&!talent.obliteration|!talent.pillar_of_frost)&(!raid_event.adds.exists|(raid_event.adds.in>15+raid_event.adds.duration|talent.absolute_zero&raid_event.adds.in>15+raid_event.adds.duration))|fight_remains<3
    -- if IsReady("Frostwyrm's Fury") and (not S.ApocalypseNow:IsAvailable() and EnemiesMeleeCount == 1 and (S.PillarofFrost:IsAvailable() and Player:BuffUp(S.PillarofFrostBuff) and not S.Obliteration:IsAvailable() or not S.PillarofFrost:IsAvailable()) or BossFightRemains < 3) then
    --     return S.FrostwyrmsFury:Cast()
    -- end
    -- -- frostwyrms_fury,if=!talent.apocalypse_now&active_enemies>=2&(talent.pillar_of_frost&buff.pillar_of_frost.up|raid_event.adds.exists&raid_event.adds.up&raid_event.adds.in<cooldown.pillar_of_frost.remains-raid_event.adds.in-raid_event.adds.duration)
    -- if IsReady("Frostwyrm's Fury") and (not S.ApocalypseNow:IsAvailable() and EnemiesMeleeCount >= 2 and (S.PillarofFrost:IsAvailable() and Player:BuffUp(S.PillarofFrostBuff))) then
    --     return S.FrostwyrmsFury:Cast()
    -- end
    -- -- frostwyrms_fury,if=!talent.apocalypse_now&talent.obliteration&(talent.pillar_of_frost&buff.pillar_of_frost.up&!main_hand.2h|!buff.pillar_of_frost.up&main_hand.2h&cooldown.pillar_of_frost.remains|!talent.pillar_of_frost)&(buff.pillar_of_frost.remains<gcd|(buff.unholy_strength.up&buff.unholy_strength.remains<gcd)|(talent.bonegrinder.rank=2&buff.bonegrinder_frost.up&buff.bonegrinder_frost.remains<gcd))&(debuff.razorice.stack=5|!death_knight.runeforge.razorice&!talent.glacial_advance|talent.shattering_blade)
    -- if IsReady("Frostwyrm's Fury") and (not S.ApocalypseNow:IsAvailable() and S.Obliteration:IsAvailable() and (S.PillarofFrost:IsAvailable() and Player:BuffUp(S.PillarofFrostBuff) and not Var2HCheck or Player:BuffDown(S.PillarofFrostBuff) and Var2HCheck and S.PillarofFrost:CooldownDown() or not S.PillarofFrost:IsAvailable()) and (Player:BuffRemains(S.PillarofFrostBuff) < Player:GCD() or (Player:BuffUp(S.UnholyStrengthBuff) and Player:BuffRemains(S.UnholyStrengthBuff) < Player:GCD()) or (S.Bonegrinder:TalentRank() == 2 and Player:BuffUp(S.BonegrinderFrostBuff) and Player:BuffRemains(S.BonegrinderFrostBuff) < Player:GCD())) and (Target:DebuffStack(S.RazoriceDebuff) == 5 or not UsingRazorice and not S.GlacialAdvance:IsAvailable() or S.ShatteringBlade:IsAvailable())) then
    --     return S.FrostwyrmsFury:Cast()
    -- end
    -- raise_dead,use_off_gcd=1
    if IsReady("Raise Dead") and GetUnitName("pet") == nil and TargetinRange(30) and C_Spell.IsCurrentSpell(6603) then
      return S.RaiseDead:Cast()
    end
    -- soul_reaper,if=fight_remains>5&target.time_to_pct_35<5&target.time_to_pct_0>5&active_enemies<=1&(talent.obliteration&(buff.pillar_of_frost.up&!buff.killing_machine.react&rune>2|!buff.pillar_of_frost.up|buff.killing_machine.react<2&!buff.exterminate.up&buff.pillar_of_frost.remains<gcd)|talent.breath_of_sindragosa&(buff.breath_of_sindragosa.up&runic_power>50|!buff.breath_of_sindragosa.up)|!talent.breath_of_sindragosa&!talent.obliteration)
    if IsReady("Soul Reaper")  and TargetinRange(5) and (FightRemains > 5 and Target:TimeToX(35) < 5 and Target:TimeToX(0) > 5 and EnemiesMeleeCount <= 1 and (S.Obliteration:IsAvailable() and (Player:BuffUp(S.PillarofFrostBuff) and Player:BuffDown(S.KillingMachineBuff) and Player:Rune() > 2 or Player:BuffDown(S.PillarofFrostBuff) or Player:BuffStack(S.KillingMachineBuff) < 2 and Player:BuffDown(S.ExterminateBuff) and Player:BuffRemains(S.PillarofFrostBuff) < Player:GCD()) or S.BreathofSindragosa:IsAvailable() and (Player:BuffUp(S.BreathofSindragosa) and Player:RunicPower() > 50 or Player:BuffDown(S.BreathofSindragosa)) or not S.BreathofSindragosa:IsAvailable() and not S.Obliteration:IsAvailable())) then
        return S.SoulReaper:Cast()
    end
    -- frostscythe,if=!buff.killing_machine.react&(!talent.arctic_assault|!buff.pillar_of_frost.up)
    if IsReady("Frostscythe")  and TargetinRange(5) and (Player:BuffDown(S.KillingMachineBuff) and (not S.ArcticAssault:IsAvailable() or Player:BuffDown(S.PillarofFrostBuff))) then
        return S.Frostscythe:Cast()
    end
    -- any_dnd,if=!buff.death_and_decay.up&variable.adds_remain&(buff.pillar_of_frost.up&buff.killing_machine.react&(talent.enduring_strength|buff.pillar_of_frost.remains>5)|!buff.pillar_of_frost.up&(cooldown.death_and_decay.charges=2|cooldown.pillar_of_frost.remains>cooldown.death_and_decay.duration|!talent.the_long_winter&cooldown.pillar_of_frost.remains<gcd.max*2)|fight_remains<15)&(active_enemies>5|talent.cleaving_strikes&active_enemies>=2)
    if IsReady("Death and Decay") and TargetinRange(5) and (Player:BuffDown(S.DeathandDecayBuff) and VarAddsRemain and (Player:BuffUp(S.PillarofFrostBuff) and Player:BuffUp(S.KillingMachineBuff) and (S.EnduringStrength:IsAvailable() or Player:BuffRemains(S.PillarofFrostBuff) > 5) or Player:BuffDown(S.PillarofFrostBuff) and (S.DeathandDecay:Charges() == 2 or S.PillarofFrost:CooldownRemains() > S.DeathandDecay:Cooldown() or not S.TheLongWinter:IsAvailable() and S.PillarofFrost:CooldownRemains() < Player:GCD() * 2) or BossFightRemains < 15) and (EnemiesMeleeCount > 5 or S.CleavingStrikes:IsAvailable() and EnemiesMeleeCount >= 2)) then
        return S.DeathandDecay:Cast()
    end
  end
  
  local function HighPrioActions()
    -- mind_freeze,if=target.debuff.casting.react
    -- local ShouldReturn = Everyone.Interrupt(S.MindFreeze, Settings.CommonsDS.DisplayStyle.Interrupts, StunInterrupts); if ShouldReturn then return ShouldReturn; end
    -- invoke_external_buff,name=power_infusion,if=(buff.pillar_of_frost.up|!talent.pillar_of_frost)&(talent.obliteration|talent.breath_of_sindragosa&buff.breath_of_sindragosa.up|!talent.breath_of_sindragosa&!talent.obliteration)
    -- Note: Not handling external buffs.
    -- antimagic_shell,if=runic_power.deficit>40&death_knight.first_ams_cast<time&(!talent.breath_of_sindragosa|talent.breath_of_sindragosa&variable.true_breath_cooldown>cooldown.antimagic_shell.duration)
    -- In simc, the default of this setting is 20s.
    -- TODO: Maybe make this a setting?
    -- local VarAMSCD = S.AntiMagicBarrier:IsAvailable() and 40 or 60
    -- VarAMSCD = S.UnyieldingWill:IsAvailable() and VarAMSCD + 20 or VarAMSCD
    -- if RubimRH.CDsON() and IsReady("Anti-Magic Shell") and (Player:RunicPowerDeficit() > 40 and 20 < HL.CombatTime() and (not S.BreathofSindragosa:IsAvailable() or S.BreathofSindragosa:IsAvailable() and VarTrueBreathCD > VarAMSCD)) then
    --     return S.AntiMagicShell:Cast()
    -- end
    -- howling_blast,if=!dot.frost_fever.ticking&active_enemies>=2&(!talent.obliteration|talent.obliteration&(!cooldown.pillar_of_frost.ready|buff.pillar_of_frost.up&!buff.killing_machine.react))
    if IsReady("Howling Blast")  and TargetinRange(30) and (Target:DebuffDown(S.FrostFeverDebuff) and EnemiesMeleeCount >= 2 and (not S.Obliteration:IsAvailable() or S.Obliteration:IsAvailable() and (S.PillarofFrost:CooldownDown() or Player:BuffUp(S.PillarofFrostBuff) and Player:BuffDown(S.KillingMachineBuff)))) then
        return S.HowlingBlast:Cast()
    end
    -- glacial_advance,if=variable.ga_priority&variable.rp_buffs&talent.obliteration&talent.breath_of_sindragosa&!buff.pillar_of_frost.up&!buff.breath_of_sindragosa.up&cooldown.breath_of_sindragosa.remains>variable.breath_pooling_time
    if IsReady("Glacial Advance")  and TargetinRange(10) and (VarGAPriority and VarRPBuffs and S.Obliteration:IsAvailable() and S.BreathofSindragosa:IsAvailable() and Player:BuffDown(S.PillarofFrostBuff) and Player:BuffDown(S.BreathofSindragosa) and S.BreathofSindragosa:CooldownRemains() > VarBreathPoolingTime) then
        return S.GlacialAdvance:Cast()
    end
    -- glacial_advance,if=variable.ga_priority&variable.rp_buffs&talent.breath_of_sindragosa&!buff.breath_of_sindragosa.up&cooldown.breath_of_sindragosa.remains>variable.breath_pooling_time
    if IsReady("Glacial Advance")  and TargetinRange(10) and (VarGAPriority and VarRPBuffs and S.BreathofSindragosa:IsAvailable() and Player:BuffDown(S.BreathofSindragosa) and S.BreathofSindragosa:CooldownRemains() > VarBreathPoolingTime) then
        return S.GlacialAdvance:Cast()
    end
    -- glacial_advance,if=variable.ga_priority&variable.rp_buffs&!talent.breath_of_sindragosa&talent.obliteration&!buff.pillar_of_frost.up&!talent.shattered_frost
    if IsReady("Glacial Advance")  and TargetinRange(10) and (VarGAPriority and VarRPBuffs and not S.BreathofSindragosa:IsAvailable() and S.Obliteration:IsAvailable() and Player:BuffDown(S.PillarofFrostBuff) and not S.ShatteredFrost:IsAvailable()) then
        return S.GlacialAdvance:Cast()
    end
    -- frost_strike,target_if=max:((talent.shattering_blade&debuff.razorice.stack=5)*5)+(debuff.razorice.stack+1)%(debuff.razorice.remains+1)*death_knight.runeforge.razorice,if=active_enemies=1&variable.rp_buffs&talent.obliteration&talent.breath_of_sindragosa&!buff.pillar_of_frost.up&!buff.breath_of_sindragosa.up&cooldown.breath_of_sindragosa.remains>variable.breath_pooling_time
    if IsReady("Frost Strike")  and TargetinRange(5) and EvaluateTargetIfFilterFrostStrike and (EnemiesMeleeCount == 1 and VarRPBuffs and S.Obliteration:IsAvailable() and S.BreathofSindragosa:IsAvailable() and Player:BuffDown(S.PillarofFrostBuff) and Player:BuffDown(S.BreathofSindragosa) and S.BreathofSindragosa:CooldownRemains() > VarBreathPoolingTime) then
        return S.FrostStrike:Cast()
    end
    -- frost_strike,target_if=max:((talent.shattering_blade&debuff.razorice.stack=5)*5)+(debuff.razorice.stack+1)%(debuff.razorice.remains+1)*death_knight.runeforge.razorice,if=active_enemies=1&variable.rp_buffs&talent.breath_of_sindragosa&!buff.breath_of_sindragosa.up&cooldown.breath_of_sindragosa.remains>variable.breath_pooling_time
    if IsReady("Frost Strike")  and TargetinRange(5) and EvaluateTargetIfFilterFrostStrike and (EnemiesMeleeCount == 1 and VarRPBuffs and S.BreathofSindragosa:IsAvailable() and Player:BuffDown(S.BreathofSindragosa) and S.BreathofSindragosa:CooldownRemains() > VarBreathPoolingTime) then
        return S.FrostStrike:Cast()
    end
    -- frost_strike,target_if=max:((talent.shattering_blade&debuff.razorice.stack=5)*5)+(debuff.razorice.stack+1)%(debuff.razorice.remains+1)*death_knight.runeforge.razorice,if=active_enemies=1&variable.rp_buffs&!talent.breath_of_sindragosa&talent.obliteration&!buff.pillar_of_frost.up
    if IsReady("Frost Strike")  and TargetinRange(5) and EvaluateTargetIfFilterFrostStrike and (EnemiesMeleeCount == 1 and VarRPBuffs and not S.BreathofSindragosa:IsAvailable() and S.Obliteration:IsAvailable() and Player:BuffDown(S.PillarofFrostBuff)) then
        return S.FrostStrike:Cast()
    end
  end
  
  local function Obliteration()
    -- obliterate,target_if=max:(debuff.razorice.stack+1)%(debuff.razorice.remains+1)*death_knight.runeforge.razorice+((hero_tree.deathbringer&debuff.reapers_mark_debuff.down)*5),if=buff.killing_machine.react&(buff.exterminate.up|fight_remains<gcd*2)
    if IsReady("Obliterate")  and TargetinRange(5) and EvaluateTargetIfFilterObliterate and (Player:BuffUp(S.KillingMachineBuff) and (Player:BuffUp(S.ExterminateBuff) or BossFightRemains < Player:GCD() * 2)) then
        return S.Obliterate:Cast()
    end
    -- howling_blast,if=buff.killing_machine.react<2&buff.pillar_of_frost.remains<gcd&variable.rime_buffs
    if IsReady("Howling Blast")  and TargetinRange(30) and (Player:BuffStack(S.KillingMachineBuff) < 2 and Player:BuffRemains(S.PillarofFrostBuff) < Player:GCD() and VarRimeBuffs) then
        return S.HowlingBlast:Cast()
    end
    -- glacial_advance,if=buff.killing_machine.react<2&buff.pillar_of_frost.remains<gcd&!buff.death_and_decay.up&variable.ga_priority
    if IsReady("Glacial Advance")  and TargetinRange(10) and (Player:BuffStack(S.KillingMachineBuff) < 2 and Player:BuffRemains(S.PillarofFrostBuff) < Player:GCD() and Player:BuffDown(S.DeathandDecayBuff) and VarGAPriority) then
        return S.GlacialAdvance:Cast()
    end
    -- frost_strike,target_if=max:((talent.shattering_blade&debuff.razorice.stack=5)*5)+(debuff.razorice.stack+1)%(debuff.razorice.remains+1)*death_knight.runeforge.razorice,if=buff.killing_machine.react<2&buff.pillar_of_frost.remains<gcd&!buff.death_and_decay.up
    if IsReady("Frost Strike")  and TargetinRange(5) and EvaluateTargetIfFilterFrostStrike and (Player:BuffStack(S.KillingMachineBuff) < 2 and Player:BuffRemains(S.PillarofFrostBuff) < Player:GCD() and Player:BuffDown(S.DeathandDecayBuff)) then
        return S.FrostStrike:Cast()
    end
    -- frost_strike,target_if=max:((talent.shattering_blade&debuff.razorice.stack=5)*5)+(debuff.razorice.stack+1)%(debuff.razorice.remains+1)*death_knight.runeforge.razorice,if=debuff.razorice.stack=5&talent.shattering_blade&talent.a_feast_of_souls&buff.a_feast_of_souls.up
    if IsReady("Frost Strike") and EvaluateTargetIfFilterFrostStrike and EvaluateTargetIfFrostStrikeObliteration and (S.ShatteringBlade:IsAvailable() and S.AFeastofSouls:IsAvailable() and Player:BuffUp(S.AFeastofSoulsBuff)) then
        return S.FrostStrike:Cast()
    end
    -- obliterate,target_if=max:(debuff.razorice.stack+1)%(debuff.razorice.remains+1)*death_knight.runeforge.razorice,if=buff.killing_machine.react
    if IsReady("Obliterate")  and TargetinRange(5) and (Player:BuffUp(S.KillingMachineBuff)) and EvaluateTargetIfFilterRazoriceStacksModified then
        return S.Obliterate:Cast()
    end
    -- howling_blast,target_if=!dot.frost_fever.ticking,if=!buff.killing_machine.react
    -- Note: Instead of iterating targets, checking AuraActiveCount.
    if IsReady("Howling Blast")  and TargetinRange(30) and (Player:BuffDown(S.KillingMachineBuff) and FFTargets() < EnemiesMeleeCount) then
        return S.HowlingBlast:Cast()
    end
    -- glacial_advance,target_if=max:(debuff.razorice.stack),if=(variable.ga_priority|debuff.razorice.stack<5)&(!death_knight.runeforge.razorice&(debuff.razorice.stack<5|debuff.razorice.remains<gcd*3)|((variable.rp_buffs|rune<2)&active_enemies>1))
    if IsReady("Glacial Advance")  and TargetinRange(10) and (EvaluateTargetIfFilterRazoriceStacks or EvaluateTargetIfGlacialAdvanceObliteration) then
        return S.GlacialAdvance:Cast()
    end
    -- frost_strike,target_if=max:((talent.shattering_blade&debuff.razorice.stack=5)*5)+(debuff.razorice.stack+1)%(debuff.razorice.remains+1)*death_knight.runeforge.razorice,if=(rune<2|variable.rp_buffs|debuff.razorice.stack=5&talent.shattering_blade)&!variable.pooling_runic_power&(!talent.glacial_advance|active_enemies=1|talent.shattered_frost)
    if IsReady("Frost Strike")  and TargetinRange(5) and (EvaluateTargetIfFilterFrostStrike or EvaluateTargetIfFrostStrikeObliteration2) and (not VarPoolingRP and (not S.GlacialAdvance:IsAvailable() or EnemiesMeleeCount == 1 or S.ShatteredFrost:IsAvailable())) then
        return S.FrostStrike:Cast()
    end
    -- howling_blast,if=buff.rime.react
    if IsReady("Howling Blast")  and TargetinRange(30) and (Player:BuffUp(S.RimeBuff)) then
        return S.HowlingBlast:Cast()
    end
    -- frost_strike,target_if=max:((talent.shattering_blade&debuff.razorice.stack=5)*5)+(debuff.razorice.stack+1)%(debuff.razorice.remains+1)*death_knight.runeforge.razorice,if=!variable.pooling_runic_power&(!talent.glacial_advance|active_enemies=1|talent.shattered_frost)
    if IsReady("Frost Strike")  and TargetinRange(5) and EvaluateTargetIfFilterFrostStrike and (not VarPoolingRP and (not S.GlacialAdvance:IsAvailable() or EnemiesMeleeCount == 1 or S.ShatteredFrost:IsAvailable())) then
        return S.FrostStrike:Cast()
    end
    -- glacial_advance,target_if=max:(debuff.razorice.stack),if=!variable.pooling_runic_power&variable.ga_priority
    if IsReady("Glacial Advance")  and TargetinRange(10) and (not VarPoolingRP and VarGAPriority) and EvaluateTargetIfFilterRazoriceStacks then
        return S.GlacialAdvance:Cast()
    end
    -- frost_strike,target_if=max:((talent.shattering_blade&debuff.razorice.stack=5)*5)+(debuff.razorice.stack+1)%(debuff.razorice.remains+1)*death_knight.runeforge.razorice,if=!variable.pooling_runic_power
    if IsReady("Frost Strike")  and TargetinRange(5) and (not VarPoolingRP) and EvaluateTargetIfFilterFrostStrike then
        return S.FrostStrike:Cast()
    end
    -- horn_of_winter,if=rune<3
    if IsReady("Horn of Winter")  and TargetinRange(10) and (Player:Rune() < 3) then
        return S.HornofWinter:Cast()
    end
    -- arcane_torrent,if=rune<1&runic_power<30
    if RubimRH.CDsON()  and TargetinRange(8) and IsReady("Arcane Torrent") and (Player:Rune() < 1 and Player:RunicPower() < 30) then
        return S.ArcaneTorrent:Cast()
    end
    -- howling_blast,if=!buff.killing_machine.react
    if IsReady("Howling Blast")  and TargetinRange(30) and (Player:BuffDown(S.KillingMachineBuff)) then
        return S.HowlingBlast:Cast()
    end
  end





  local function SingleTarget()
    -- frost_strike,if=talent.a_feast_of_souls&debuff.razorice.stack=5&talent.shattering_blade&buff.a_feast_of_souls.up
    if IsReady("Frost Strike")  and TargetinRange(5) and (S.AFeastofSouls:IsAvailable() and Target:DebuffStack(S.RazoriceDebuff) == 5 and S.ShatteringBlade:IsAvailable() and Player:BuffUp(S.AFeastofSoulsBuff)) then
        return S.FrostStrike:Cast()
    end
    -- obliterate,if=buff.killing_machine.react=2|buff.exterminate.up
    if IsReady("Obliterate")  and TargetinRange(5) and (Player:BuffStack(S.KillingMachineBuff) == 2 or Player:BuffUp(S.ExterminateBuff)) then
        return S.Obliterate:Cast()
    end
    -- horn_of_winter,if=(!talent.breath_of_sindragosa|variable.true_breath_cooldown>cooldown.horn_of_winter.duration-15)&cooldown.pillar_of_frost.remains<variable.oblit_pooling_time
    if IsReady("Horn of Winter") and TargetinRange(10) and ((not S.BreathofSindragosa:IsAvailable() or VarTrueBreathCD > 30) and S.PillarofFrost:CooldownRemains() < VarOblitPoolingTime) then
        return S.HornofWinter:Cast()
    end
    -- frost_strike,if=(debuff.razorice.stack=5&talent.shattering_blade)|(rune<2&!talent.icebreaker)
    if IsReady("Frost Strike") and TargetinRange(5) and ((Target:DebuffStack(S.RazoriceDebuff) == 5 and S.ShatteringBlade:IsAvailable()) or (Player:Rune() < 2 and not S.Icebreaker:IsAvailable())) then
        return S.FrostStrike:Cast()
    end
    -- howling_blast,if=variable.rime_buffs&(!talent.breath_of_sindragosa|talent.rage_of_the_frozen_champion|cooldown.breath_of_sindragosa.remains)
    if IsReady("Howling Blast") and TargetinRange(30) and (VarRimeBuffs and (not S.BreathofSindragosa:IsAvailable() or S.RageoftheFrozenChampion:IsAvailable() or S.BreathofSindragosa:CooldownDown())) then
        return S.HowlingBlast:Cast()
    end
    -- obliterate,if=buff.killing_machine.react&!variable.pooling_runes
    if IsReady("Obliterate") and TargetinRange(5) and (Player:BuffUp(S.KillingMachineBuff) and not VarPoolingRunes) then
        return S.Obliterate:Cast()
    end
    -- glacial_advance,if=!variable.pooling_runic_power&!death_knight.runeforge.razorice&(debuff.razorice.stack<5|debuff.razorice.remains<gcd*3)
    if IsReady("Glacial Advance") and TargetinRange(10) and (not VarPoolingRP and not UsingRazorice and (Target:DebuffStack(S.RazoriceDebuff) < 5 or Target:DebuffRemains(S.RazoriceDebuff) < Player:GCD() * 3)) then
        return S.GlacialAdvance:Cast()
    end
    -- frost_strike,if=!variable.pooling_runic_power&(variable.rp_buffs|(!talent.shattering_blade&runic_power.deficit<20))
    if IsReady("Frost Strike") and TargetinRange(5)  and (not VarPoolingRP and (VarRPBuffs or (not S.ShatteringBlade:IsAvailable() and Player:RunicPowerDeficit() < 20))) then
        return S.FrostStrike:Cast()
    end
    -- howling_blast,if=buff.rime.react&(!talent.breath_of_sindragosa|talent.rage_of_the_frozen_champion|cooldown.breath_of_sindragosa.remains)
    if IsReady("Howling Blast") and TargetinRange(30) and (Player:BuffUp(S.RimeBuff) and (not S.BreathofSindragosa:IsAvailable() or S.RageoftheFrozenChampion:IsAvailable() or S.BreathofSindragosa:CooldownDown())) then
        return S.HowlingBlast:Cast()
    end
    -- frost_strike,if=!variable.pooling_runic_power&!(main_hand.2h|talent.shattering_blade)
    if IsReady("Frost Strike") and TargetinRange(5) and (not VarPoolingRP and not (Var2HCheck or S.ShatteringBlade:IsAvailable())) then
        return S.FrostStrike:Cast()
    end
    -- obliterate,if=!variable.pooling_runes
    if IsReady("Obliterate")  and TargetinRange(5) and (not VarPoolingRunes) then
        return S.Obliterate:Cast()
    end
    -- frost_strike,if=!variable.pooling_runic_power
    if IsReady("Frost Strike")  and TargetinRange(5) and (not VarPoolingRP) then
        return S.FrostStrike:Cast()
    end
    -- any_dnd,if=talent.breath_of_sindragosa&!buff.breath_of_sindragosa.up&!variable.true_breath_cooldown&rune<2&!buff.death_and_decay.up
    if IsReady("Death and Decay") and TargetinRange(5) and (S.BreathofSindragosa:IsAvailable() and Player:BuffDown(S.BreathofSindragosa) and not bool(VarTrueBreathCD) and Player:Rune() < 2 and Player:BuffDown(S.DeathandDecayBuff)) then
        return S.DeathandDecay:Cast()
    end
    -- howling_blast,if=!dot.frost_fever.ticking
    if IsReady("Howling Blast")  and TargetinRange(30)  and (Target:DebuffDown(S.FrostFeverDebuff)) then
        return S.HowlingBlast:Cast()
    end
    -- horn_of_winter,if=rune<2&runic_power.deficit>25&(!talent.breath_of_sindragosa|variable.true_breath_cooldown>cooldown.horn_of_winter.duration-15)
    if IsReady("Horn of Winter")  and TargetinRange(10) and (Player:Rune() < 2 and Player:RunicPowerDeficit() > 25 and (not S.BreathofSindragosa:IsAvailable() or VarTrueBreathCD > 30)) then
        return S.HornofWinter:Cast()
    end
    -- arcane_torrent,if=!talent.breath_of_sindragosa&runic_power.deficit>20
    if RubimRH.CDsON() and TargetinRange(8) and IsReady("Arcane Torrent") and (not S.BreathofSindragosa:IsAvailable() and Player:RunicPowerDeficit() > 20) then
        return S.ArcaneTorrent:Cast()
    end
  end
  


  
local function Variables()
    -- variable,name=st_planning,value=active_enemies=1&(raid_event.adds.in>15|!raid_event.adds.exists)
    VarSTPlanning = EnemiesMeleeCount == 1 or not RubimRH.AoEON()
    -- variable,name=adds_remain,value=active_enemies>=2&(!raid_event.adds.exists|raid_event.adds.exists&raid_event.adds.remains>5)
    VarAddsRemain = EnemiesMeleeCount >= 2 and RubimRH.AoEON()
    -- variable,name=sending_cds,value=(variable.st_planning|variable.adds_remain)
    VarSendingCDs = VarSTPlanning or VarAddsRemain
    -- variable,name=rime_buffs,value=buff.rime.react&(variable.static_rime_buffs|talent.avalanche&!talent.arctic_assault&debuff.razorice.stack<5)
    VarRimeBuffs = Player:BuffUp(S.RimeBuff) and (VarStaticRimeBuffs or S.Avalanche:IsAvailable() and not S.ArcticAssault:IsAvailable() and Target:DebuffStack(S.RazoriceDebuff) < 5)
    -- variable,name=rp_buffs,value=talent.unleashed_frenzy&(buff.unleashed_frenzy.remains<gcd.max*3|buff.unleashed_frenzy.stack<3)|talent.icy_talons&(buff.icy_talons.remains<gcd.max*3|buff.icy_talons.stack<(3+(2*talent.smothering_offense)+(2*talent.dark_talons)))
    VarRPBuffs = S.UnleashedFrenzy:IsAvailable() and (Player:BuffRemains(S.UnleashedFrenzyBuff) < Player:GCD() * 3 or Player:BuffStack(S.UnleashedFrenzyBuff) < 3) or S.IcyTalons:IsAvailable() and (Player:BuffRemains(S.IcyTalonsBuff) < Player:GCD() * 3 or Player:BuffStack(S.IcyTalonsBuff) < (3 + (2 * num(S.SmotheringOffense:IsAvailable())) + (2 * num(S.DarkTalons:IsAvailable()))))
    -- variable,name=cooldown_check,value=talent.pillar_of_frost&buff.pillar_of_frost.up&(talent.obliteration&buff.pillar_of_frost.remains>10|!talent.obliteration)|!talent.pillar_of_frost&buff.empower_rune_weapon.up|!talent.pillar_of_frost&!talent.empower_rune_weapon|active_enemies>=2&buff.pillar_of_frost.up
    VarCDCheck = S.PillarofFrost:IsAvailable() and Player:BuffUp(S.PillarofFrostBuff) and (S.Obliteration:IsAvailable() and Player:BuffRemains(S.PillarofFrostBuff) > 10 or not S.Obliteration:IsAvailable()) or not S.PillarofFrost:IsAvailable() and Player:BuffUp(S.EmpowerRuneWeaponBuff) or not S.PillarofFrost:IsAvailable() and not S.EmpowerRuneWeapon:IsAvailable() or EnemiesMeleeCount >= 2 and Player:BuffUp(S.PillarofFrostBuff)
    -- variable,name=true_breath_cooldown,op=setif,value=cooldown.breath_of_sindragosa.remains,value_else=cooldown.pillar_of_frost.remains,condition=cooldown.breath_of_sindragosa.remains>cooldown.pillar_of_frost.remains
    VarTrueBreathCD = (S.BreathofSindragosa:CooldownRemains() > S.PillarofFrost:CooldownRemains()) and S.BreathofSindragosa:CooldownRemains() or S.PillarofFrost:CooldownRemains()
    -- variable,name=oblit_pooling_time,op=setif,value=((cooldown.pillar_of_frost.remains+1)%gcd.max)%((rune+1)*((runic_power+5)))*100,value_else=3,condition=runic_power<35&rune<2&cooldown.pillar_of_frost.remains<10
    VarOblitPoolingTime = 3
    if Player:RunicPower() < 35 and Player:Rune() < 2 and S.PillarofFrost:CooldownRemains() < 10 then
      VarOblitPoolingTime = ((S.PillarofFrost:CooldownRemains() + 1) / GCDMax) / ((Player:Rune() + 1) * (Player:RunicPower() + 5)) * 100
    end
    -- variable,name=breath_pooling_time,op=setif,value=((variable.true_breath_cooldown+1)%gcd.max)%((rune+1)*(runic_power+20))*100,value_else=2,condition=runic_power.deficit>10&variable.true_breath_cooldown<10
    VarBreathPoolingTime = 2
    if Player:RunicPowerDeficit() > 10 and VarTrueBreathCD < 10 then
      VarBreathPoolingTime = ((VarTrueBreathCD + 1) / GCDMax) / ((Player:Rune() + 1) * (Player:RunicPower() + 20)) * 100
    end
    -- variable,name=pooling_runes,value=rune<variable.oblit_rune_pooling&talent.obliteration&(!talent.breath_of_sindragosa|variable.true_breath_cooldown)&cooldown.pillar_of_frost.remains<variable.oblit_pooling_time
    VarPoolingRunes = Player:Rune() < VarOblitRunePooling and S.Obliteration:IsAvailable() and (not S.BreathofSindragosa:IsAvailable() or bool(VarTrueBreathCD)) and S.PillarofFrost:CooldownRemains() < VarOblitPoolingTime
    -- variable,name=pooling_runic_power,value=talent.breath_of_sindragosa&(variable.true_breath_cooldown<variable.breath_pooling_time|fight_remains<30&!cooldown.breath_of_sindragosa.remains)|talent.obliteration&(!talent.breath_of_sindragosa|cooldown.breath_of_sindragosa.remains>30)&runic_power<35&cooldown.pillar_of_frost.remains<variable.oblit_pooling_time
    VarPoolingRP = S.BreathofSindragosa:IsAvailable() and (VarTrueBreathCD < VarBreathPoolingTime or FightRemains < 30 and S.BreathofSindragosa:CooldownUp()) or S.Obliteration:IsAvailable() and (not S.BreathofSindragosa:IsAvailable() or S.BreathofSindragosa:CooldownRemains() > 30) and Player:RunicPower() < 35 and S.PillarofFrost:CooldownRemains() < VarOblitPoolingTime
    -- variable,name=ga_priority,value=(!talent.shattered_frost&talent.shattering_blade&active_enemies>=4)|(!talent.shattered_frost&!talent.shattering_blade&active_enemies>=2)
    VarGAPriority = (not S.ShatteredFrost:IsAvailable() and S.ShatteringBlade:IsAvailable() and EnemiesMeleeCount >= 4) or (not S.ShatteredFrost:IsAvailable() and not S.ShatteringBlade:IsAvailable() and EnemiesMeleeCount >= 2)
    -- variable,name=breath_dying,value=runic_power<variable.breath_rp_cost*2&rune.time_to_2>runic_power%variable.breath_rp_cost
    VarBreathDying = Player:RunicPower() < VarBreathRPCost * 2 and Player:RuneTimeToX(2) > Player:RunicPower() / VarBreathRPCost
  end



local function APL()


    
    local useIBF = not AuraUtil.FindAuraByName("Lichborne", "player")
    local useLB = not AuraUtil.FindAuraByName("Icebound Fortitude", "player") 

    local startTimeMS = select(4, UnitCastingInfo('target')) or 0
    local currentTimeMS = GetTime() * 1000
    local elapsedTimeca = (startTimeMS > 0) and (currentTimeMS - startTimeMS) or 0
    local castTime = elapsedTimeca / 1000
    local startTimeMS = select(4, UnitCastingInfo('target')) or select(4, UnitChannelInfo('target')) or 0
    local currentTimeMS = GetTime() * 1000
    local elapsedTimech = (startTimeMS > 0) and (currentTimeMS - startTimeMS) or 0
    local channelTime = elapsedTimech / 1000
    -- S.FrostFeverDebuff:RegisterAuraTracking()
    -- S.MarkofFyralathDebuff:RegisterAuraTracking()
    -- print(GetUnitName("pet"))
    if Target:Exists() and getCurrentDPS() and getCurrentDPS()>0 then
        targetTTD = UnitHealth('target')/getCurrentDPS()
      else 
        targetTTD = 8888
      end
 
    if RubimRH.AoEON() then
      EnemiesMeleeCount = RangeCount(8)
    else
      EnemiesMeleeCount = 1
    end
  
    if Player:CanAttack(Target) or Player:AffectingCombat() then
      -- Calculate fight_remains
      BossFightRemains = targetTTD
      FightRemains = targetTTD

  
      -- Calculate GCDMax
      GCDMax = Player:GCD() + 0.25
    end
  
    if Player:CanAttack(Target) then
      -- call precombat
      if not Player:AffectingCombat() then
        local ShouldReturn = Precombat(); if ShouldReturn then return ShouldReturn; end
      end
      -- use DeathStrike on low HP or with proc in Solo Mode
      if IsReady("Death Strike") and DeathStrikeHeal() then
        return S.DeathStrike:Cast()
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
    


    if IsReady(RubimRH.queuedSpell[1]:ID(),nil,nil,1) then
        return RubimRH.QueuedSpell():Cast()
        end
        
        if not IsReady(RubimRH.queuedSpell[1]:ID(),nil,nil,1) or RangeCount(30) == 0 or not Target:Exists() or S.FrostwyrmsFury:ID() == RubimRH.queuedSpell[1]:ID() and Player:BuffDown(S.PillarofFrostBuff)  then
          RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
          end
        

          if RangeCount(30)>=1 and Player:AffectingCombat() then
  --health pot -- will need to update item ID of HPs as expansions progress
  if  Player:HealthPercentage() <= 20 and (IsUsableItem(211880) == true and GetItemCooldown(211880) == 0 and GetItemCount(211880) >= 1 or IsUsableItem(211878) == true and GetItemCooldown(211878) == 0 and GetItemCount(211878) >= 1 or IsUsableItem(211879) == true and GetItemCooldown(211879) == 0 and GetItemCount(211879) >= 1) and (not Player:InArena() and not Player:InBattlegrounds()) then
    return I.HPIcon:Cast()
    end


    
  if IsReady("Anti-Magic Shell") and Player:HealthPercentage() < 20 then
    return S.AntiMagicShell:Cast()
    end
    
    if IsReady("Anti-Magic Zone") and Player:HealthPercentage() < 40 and not Player:IsMoving() then
        return S.AntiMagicZone:Cast()
        end

    if IsReady("Death Pact") and Player:HealthPercentage() < 40 then
        return S.DeathPact:Cast()
        end

  if IsReady("Icebound Fortitude") and Player:HealthPercentage() < 50 and useIBF then
    return S.IceboundFortitude:Cast()
    end

    if IsReady("Lichborne") and Player:HealthPercentage() < 60 and useLB then
        return S.Lichborne:Cast()
        end

    end
    if (castTime > 0.5 or channelTime > 0.5) and select(8, UnitCastingInfo("target")) == false and RubimRH.InterruptsON() and UnitExists("target") and Player:CanAttack(Target) and not Target:IsDeadOrGhost() then
  -- kick on GCD
  if IsReady("Mind Freeze",1) and (kickprio() or Target:IsAPlayer() or UnitName("target") == "Orb of Ascendance") and Player:GCDRemains()<0.5 then
    return S.MindFreeze:Cast()
    end


    end


        if not C_Spell.IsCurrentSpell(6603) and Player:CanAttack(Target)
        and Target:AffectingCombat() and Player:AffectingCombat() and TargetinRange(20) then
        return S.autoattack:Cast()
        end 
      -- auto_attack

        --- seasonal affix
        if TargetinRange(8) and TWWS1AffixMobsInRange()>=5 and IsReady("Blinding Light") and RubimRH.InterruptsON() then
            return S.BlindingLight:Cast()
            end
        if TargetinRange(8) and TWWS1AffixMobsInRange()>=5 and IsReady("Arcane Torrent") and RubimRH.InterruptsON() then
          return S.ArcaneTorrent:Cast()
          end

      -- call_action_list,name=variables
      Variables()
    --  -- call_action_list,name=trinkets
    --   if Settings.Commons.Enabled.Trinkets or Settings.Commons.Enabled.Items then
    --     local ShouldReturn = Trinkets(); if ShouldReturn then return ShouldReturn; end
    --   end
      -- call_action_list,name=high_prio_actions
      if (Player:CanAttack(Target) or Target:AffectingCombat()) and not Target:IsDeadOrGhost() then
      local ShouldReturn = HighPrioActions(); if ShouldReturn then return ShouldReturn; end
      -- call_action_list,name=cooldowns


      if RubimRH.CDsON() then
        local ShouldReturn = Cooldowns(); if ShouldReturn then return ShouldReturn; end

        if Player:BuffUp(S.EmpowerRuneWeaponBuff) then
            local ShouldReturn = UseItems();
            if ShouldReturn then return ShouldReturn; end
          end

      end
    --   -- call_action_list,name=racials
    --   if RubimRH.CDsON() then
    --     local ShouldReturn = Racials(); if ShouldReturn then return ShouldReturn; end
    --   end
      -- call_action_list,name=cold_heart,if=talent.cold_heart&(!buff.killing_machine.up|talent.breath_of_sindragosa)&((debuff.razorice.stack=5|!death_knight.runeforge.razorice&!talent.glacial_advance&!talent.avalanche&!talent.arctic_assault)|fight_remains<=gcd)
      if S.ColdHeart:IsAvailable() and (Player:BuffDown(S.KillingMachineBuff) or S.BreathofSindragosa:IsAvailable()) and ((Target:DebuffStack(S.RazoriceDebuff) == 5 or not UsingRazorice and not S.GlacialAdvance:IsAvailable() and not S.Avalanche:IsAvailable() and not S.ArcticAssault:IsAvailable()) or targetTTD <= Player:GCD() + 0.5) then
        local ShouldReturn = ColdHeart(); if ShouldReturn then return ShouldReturn; end
      end
      -- run_action_list,name=breath,if=buff.breath_of_sindragosa.up
      if Player:BuffUp(S.BreathofSindragosa) and (Player:BuffUp(S.BreathofSindragosa)) then
        local ShouldReturn = Breath(); if ShouldReturn then return ShouldReturn; end
        return 0, "Interface\\Addons\\Rubim-RH\\Media\\griph.tga"
        end
      -- run_action_list,name=obliteration,if=talent.obliteration&buff.pillar_of_frost.up&!buff.breath_of_sindragosa.up
      if S.Obliteration:IsAvailable() and Player:BuffUp(S.PillarofFrostBuff) and Player:BuffDown(S.BreathofSindragosa) then
        local ShouldReturn = Obliteration(); if ShouldReturn then return ShouldReturn; end
        -- if HR.CastAnnotated(S.Pool, false, "WAIT") then return "Wait for Obliteration()"; end
        return 0, "Interface\\Addons\\Rubim-RH\\Media\\griph.tga"
      end
      -- call_action_list,name=aoe,if=active_enemies>=2
      if EnemiesMeleeCount >= 2 and RubimRH.AoEON() then
        local ShouldReturn = AoE(); if ShouldReturn then return ShouldReturn; end
      end
      -- call_action_list,name=single_target,if=active_enemies=1
      if EnemiesMeleeCount == 1 or not RubimRH.AoEON() then
        local ShouldReturn = SingleTarget(); if ShouldReturn then return ShouldReturn; end
      end
    end
    --   -- nothing to cast, wait for resouces
    --   if HR.CastAnnotated(S.Pool, false, "WAIT") then return "Wait/Pool Resources"; end


    if IsReady("Howling Blast") and not TargetinRange(8) and TargetinRange(30) then
        return S.HowlingBlast:Cast()
        end
    end












	return 0, "Interface\\Addons\\Rubim-RH\\Media\\griph.tga"
end


RubimRH.Rotation.SetAPL(251, APL);

local function PASSIVE()
    
end

RubimRH.Rotation.SetPASSIVE(251, PASSIVE);