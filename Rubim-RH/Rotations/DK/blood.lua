    --- ============================ HEADER ============================
    local addonName, addonTable = ...;
    local HL = HeroLib;
    local Cache = HeroCache;
    local Unit = HL.Unit;
    local Player = Unit.Player;
    local Target = Unit.Target;
    local MouseOver = Unit.MouseOver;
    local Spell = HL.Spell;
    local Item = HL.Item;
    
    -- Items
    if not Item.DeathKnight then
        Item.DeathKnight = { };
    end
    Item.DeathKnight.Blood = {
        SephuzSecret = Item(132452, { 11, 12 }), --11/12
    }
    
    RubimRH.Spell[250] = {
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

 lust1    = Spell(57724),
 lust2    = Spell(57723),
 lust3    = Spell(80354),
 lust4    = Spell(95809),
 lust5    = Spell(264689),
 lustAT   = Spell(155145), -- arcane torrent
 autoattack = Spell(59752), -- will to survive (human racial)

 DeathGrip = Spell(49576),
 DeathCharge = Spell(444347),
 Lichborne = Spell(20549), -- war stomp
 RaiseAlly = Spell(61999),
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
  -- Talents
  BloodBoil                             = Spell(50842),
  BloodTap                              = Spell(221699),
  Blooddrinker                          = Spell(206931),
  Bonestorm                             = Spell(194844),
  Coagulopathy                          = Spell(391477),
  Consumption                           = Spell(274156),
  DancingRuneWeapon                     = Spell(49028),
  DeathsCaress                          = Spell(195292),
  GorefiendsGrasp                       = Spell(108199),
  HeartStrike                           = Spell(206930),
  Heartbreaker                          = Spell(221536),
  InsatiableBlade                       = Spell(377637),
  Marrowrend                            = Spell(195182),
  RapidDecomposition                    = Spell(194662),
  RelishinBlood                         = Spell(317610),
  RuneTap                               = Spell(194679),
  SanguineGround                        = Spell(391458),
  ShatteringBone                        = Spell(377640),
  TighteningGrasp                       = Spell(206970),
  Tombstone                             = Spell(219809),
  VampiricBlood                         = Spell(55233),
  -- Buffs
  BoneShieldBuff                        = Spell(195181),
  CoagulopathyBuff                      = Spell(391481),
  ConsumptionBuff                       = Spell(274156),
  CrimsonScourgeBuff                    = Spell(81141),
  DancingRuneWeaponBuff                 = Spell(81256),
  HemostasisBuff                        = Spell(273947),
  IceboundFortitudeBuff                 = Spell(48792),
  RuneTapBuff                           = Spell(194679),
  VampiricBloodBuff                     = Spell(55233),
  VampiricStrengthBuff                  = Spell(408356), -- Tier 30 4pc
    }
    
    local S = RubimRH.Spell[250]
    
    if not Item.DeathKnight then Item.DeathKnight = {}; end

    Item.DeathKnight.Blood = {
        HPIcon = Item(169451),
    
    
    };
    
    local I = Item.DeathKnight.Blood;
    -- Rotation Var
    local ShouldReturn; -- Used to get the return string
    -- Rotation Var
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
    

    local function BloodPlagueDebuff()
        local inRange15 = 0
        local FSAoe = 0
        
            for id = 1, 40 do
                local unitID = "nameplate" .. id
                if UnitCanAttack("player", unitID) and C_Item.IsItemInRange(33069, unitID) then
                    inRange15 = inRange15 + 1
                end
            end
            
            for id = 1, 40 do
            local unitID = "nameplate" .. id
                if UnitCanAttack("player", unitID) and C_Item.IsItemInRange(33069, unitID) and AuraUtil.FindAuraByName("Blood Plague",unitID,"PLAYER|HARMFUL") then
                    FSAoe = FSAoe + 1
                end
            end
            WObloodplague = inRange15 - FSAoe
        
            return WObloodplague
        end

--- ===== Rotation Variables =====
local VarDeathStrikeDumpAmt = S.ReapersMark:IsAvailable() and 35 or 50
local VarDeathStrikePreEssenceDumpAmt = 20
local VarBoneShieldRefreshValue = S.ReapersMark:IsAvailable() and 6 or 11
local VarHeartStrikeRPDRW = 21 + num(S.Heartbreaker:IsAvailable()) * 2
local VarBoneShieldStacks
local IsTanking
local EnemiesMelee
local EnemiesMeleeCount
local HeartStrikeCount
local UnitsWithoutBloodPlague
local Ghoul = HL.GhoulTable

-- ===== Event Registrations =====


HL:RegisterForEvent(function()
  VarDeathStrikeDumpAmt = S.ReapersMark:IsAvailable() and 35 or 50
  VarDeathStrikePreEssenceDumpAmt = 20
  VarBoneShieldRefreshValue = S.ReapersMark:IsAvailable() and 6 or 11
  VarHeartStrikeRPDRW = 21 + num(S.Heartbreaker:IsAvailable()) * 2
end, "SPELLS_CHANGED", "LEARNED_SPELL_IN_TAB")

--- ===== Helper Functions =====
local function UnitsWithoutBP(enemies)
  local WithoutBPCount = 0
  for _, CycleUnit in pairs(enemies) do
    if not CycleUnit:DebuffUp(S.BloodPlagueDebuff) then
      WithoutBPCount = WithoutBPCount + 1
    end
  end
  return WithoutBPCount
end



local function DRWBPTicking()
    -- DRW will apply BP if we've casted Blood Boil or Death's Caress since it was summoned.
    return Player:BuffUp(S.DancingRuneWeaponBuff) and (S.BloodBoil:TimeSinceLastCast() < S.DancingRuneWeapon:TimeSinceLastCast() or S.DeathsCaress:TimeSinceLastCast() < S.DancingRuneWeapon:TimeSinceLastCast())
  end
  
  --- ===== Rotation Functions =====
  local function Precombat()
    -- flask
    -- food
    -- augmentation
    -- snapshot_stats
    -- Manually added: Openers
    if IsReady("Deaths Caress") and TargetinRange(10) and Player:IsMoving() and C_Spell.IsCurrentSpell(6603) then
        return S.DeathsCaress:Cast()
    end
    if IsReady("Marrowrend") and TargetinRange(10) and Player:IsMoving() and C_Spell.IsCurrentSpell(6603) then
        return S.Marrowrend:Cast()
    end
  end
  


  local function Defensives()
    -- Rune Tap Emergency
    if IsReady("Rune Tap") and TargetinRange(10) and IsTanking and Player:HealthPercentage() <= 60 and Player:Rune() >= 3 and S.RuneTap:Charges() >= 1 and Player:BuffDown(S.RuneTapBuff) then
        return S.RuneTap:Cast()
    end
    -- Active Mitigation
    if Player:ActiveMitigationNeeded() and S.Marrowrend:TimeSinceLastCast() > 2.5 and S.DeathStrike:TimeSinceLastCast() > 2.5 then
      if IsReady("Death Strike") and TargetinRange(8) and Player:BuffStack(S.BoneShieldBuff) > 7 then
        return S.DeathStrike:Cast()
    end
      if IsReady("Marrowrend") and TargetinRange(10) then
        return S.Marrowrend:Cast()
    end
      if IsReady("Death Strike") and TargetinRange(8) then
        return S.DeathStrike:Cast()
    end
    end
    -- Icebound Fortitude
    if IsReady("Icebound Fortitude") and TargetinRange(15) and IsTanking and Player:HealthPercentage() <= 50 and Player:BuffDown(S.DancingRuneWeaponBuff) and Player:BuffDown(S.VampiricBloodBuff) then
        return S.IceboundFortitude:Cast()
    end
    -- Vampiric Blood
    if IsReady("Vampiric Blood") and TargetinRange(15) and IsTanking and Player:HealthPercentage() <= 60 and Player:BuffDown(S.DancingRuneWeaponBuff) and Player:BuffDown(S.IceboundFortitudeBuff) and Player:BuffDown(S.VampiricBloodBuff) then
        return S.VampiricBlood:Cast()
    end
    -- Death Strike Healing
    -- Note: If under 50% health (or 70% health, if RP is above VarDeathStrikeDumpAmt).
    if IsReady("Death Strike") and TargetinRange(8) and Player:HealthPercentage() <= 50 + (Player:RunicPower() > VarDeathStrikeDumpAmt and 20 or 0) and not Player:HealingAbsorbed() then
    return S.DeathStrike:Cast()
    end
  end
  


  local function Deathbringer()
    -- variable,name=death_strike_dump_amount,value=35
    -- variable,name=bone_shield_refresh_value,value=6
    -- Note: Above variables set in variable declarations and Event Registrations.
    -- variable,name=heart_strike_rp_drw,value=(21+spell_targets.heart_strike*talent.heartbreaker.enabled*2)
    VarHeartStrikeRPDRW = 21 + EnemiesMeleeCount * num(S.Heartbreaker:IsAvailable()) * 2
    -- potion,if=buff.dancing_rune_weapon.up
    -- if Settings.Commons.Enabled.Potions and Player:BuffUp(S.DancingRuneWeaponBuff) then
    --   local PotionSelected = Everyone.PotionSelected()
    --   if PotionSelected and PotionSelected:IsReady() then
    --     if Cast(PotionSelected, nil, Settings.CommonsDS.DisplayStyle.Potions) then return "potion deathbringer 2"; end
    --   end
    -- end
    -- blood_tap,if=rune<=1
    if RubimRH.CDsON() and IsReady("Blood Tap") and (Player:Rune() <= 1) and TargetinRange(10) then
        return S.BloodTap:Cast()
    end
    -- raise_dead
    if IsReady("Raise Dead") and GetUnitName("pet") == nil and TargetinRange(30) and C_Spell.IsCurrentSpell(6603) then
        return S.RaiseDead:Cast()
      end
    if RubimRH.CDsON() and S.DancingRuneWeapon:CooldownUp() then
      -- blood_fury,if=cooldown.dancing_rune_weapon.ready
      if IsReady("Blood Fury") and TargetinRange(10) then
        return S.BloodFury:Cast()
    end
      -- berserking,if=cooldown.dancing_rune_weapon.ready
      if IsReady("Berserking") and TargetinRange(10) then
        return S.Berserking:Cast()
    end
    end
    -- deaths_caress,if=!buff.bone_shield.up
    if IsReady("Deaths Caress") and TargetinRange(10) and (Player:BuffDown(S.BoneShieldBuff)) then
        return S.DeathsCaress:Cast()
    end
    -- death_strike,if=buff.coagulopathy.remains<=gcd|runic_power.deficit<35
    if IsReady("Death Strike") and TargetinRange(8) and (Player:BuffRemains(S.CoagulopathyBuff) <= Player:GCD() or Player:RunicPowerDeficit() < 35) then
        return S.DeathStrike:Cast()
    end
    -- blood_boil,if=dot.reapers_mark.ticking&(dot.reapers_mark.remains<2*gcd|charges_fractional>=1.5)
    if IsReady("Blood Boil") and TargetinRange(10) and (Target:DebuffUp(S.ReapersMarkDebuff) and (Target:DebuffRemains(S.ReapersMarkDebuff) < 2 * Player:GCD() or S.BloodBoil:ChargesFractional() >= 1.5)) then
        return S.BloodBoil:Cast()
    end
    -- consumption,if=dot.reapers_mark.ticking&dot.blood_plague.ticking
    if IsReady("Consumption") and TargetinRange(10) and (Target:DebuffUp(S.ReapersMarkDebuff) and Target:DebuffUp(S.BloodPlagueDebuff)) then
        return S.Consumption:Cast()
    end
    -- soul_reaper,if=active_enemies=1&target.time_to_pct_35<5&target.time_to_die>(dot.soul_reaper.remains+5)
    if IsReady("Soul Reaper") and TargetinRange(10) and (EnemiesMeleeCount == 1 and Target:TimeToX(35) < 5 and Target:TimeToDie() > (Target:DebuffRemains(S.SoulReaperDebuff) + 5)) then
        return S.SoulReaper:Cast()
    end
    -- blood_boil,if=(dot.reapers_mark.ticking&(pet.dancing_rune_weapon.active&!drw.bp_ticking))|!dot.blood_plague.ticking|(charges_fractional>=1&dot.reapers_mark.ticking&buff.coagulopathy.remains>2*gcd)
    if IsReady("Blood Boil") and TargetinRange(10) and ((Target:DebuffUp(S.ReapersMarkDebuff) and (Player:BuffUp(S.DancingRuneWeaponBuff) and not DRWBPTicking())) or Target:DebuffDown(S.BloodPlagueDebuff) or (S.BloodBoil:ChargesFractional() >= 1 and Target:DebuffUp(S.ReapersMarkDebuff) and Player:BuffRemains(S.CoagulopathyBuff) > 2 * Player:GCD())) then
        return S.BloodBoil:Cast()
    end
    -- death_and_decay,if=((dot.reapers_mark.ticking)&!death_and_decay.ticking)|!buff.death_and_decay.up
    if IsReady("Death and Decay") and GetRangeTimer()>1.5 and TargetinRange(5) and ((Target:DebuffUp(S.ReapersMarkDebuff) and not dndActive) or Player:BuffDown(S.DeathandDecayBuff)) then
        return S.DeathandDecay:Cast()
    end
    -- marrowrend,if=(buff.exterminate_painful_death.up|buff.exterminate.up)&(runic_power.deficit>20&buff.coagulopathy.remains>2*gcd)
    if IsReady("Marrowrend") and TargetinRange(10) and ((Player:BuffUp(S.PainfulDeathBuff) or Player:BuffUp(S.ExterminateBuff)) and (Player:RunicPowerDeficit() > 20 and Player:BuffRemains(S.CoagulopathyBuff) > 2 * Player:GCD())) then
        return S.Marrowrend:Cast()
    end
    -- -- abomination_limb,if=dot.reapers_mark.ticking
    -- if RubimRH.CDsON() and IsReady("Abomination Limb") and (Target:DebuffUp(S.ReapersMarkDebuff)) then
    --     return S.AbominationLimb:Cast()
    -- end
    -- reapers_mark,if=!dot.reapers_mark.ticking&dot.blood_plague.ticking
    if IsReady("Reaper's Mark") and TargetinRange(10) and (Target:DebuffDown(S.ReapersMarkDebuff) and Target:DebuffDown(S.BloodPlagueDebuff)) then
        return S.ReapersMark:Cast()
    end
    -- bonestorm,if=buff.death_and_decay.up&buff.bone_shield.stack>5&cooldown.dancing_rune_weapon.remains>=10&(dot.reapers_mark.ticking)
    if RubimRH.CDsON() and TargetinRange(10) and IsReady("Bonestorm") and (Player:BuffUp(S.DeathandDecayBuff) and VarBoneShieldStacks > 5 and S.DancingRuneWeapon:CooldownRemains() >= 10 and Target:DebuffUp(S.ReapersMarkDebuff)) then
        return S.Bonestorm:Cast()
    end
    ---- abomination_limb
    -- if RubimRH.CDsON() and IsReady("Abomination Limb") then
    --     return S.AbominationLimb:Cast()
    -- end
    -- blooddrinker,if=buff.coagulopathy.remains>3*gcd&!buff.dancing_rune_weapon.up
    if IsReady("Blooddrinker") and TargetinRange(10) and (Player:BuffRemains(S.CoagulopathyBuff) > 3 * Player:GCD() and Player:BuffDown(S.DancingRuneWeaponBuff)) then
        return S.Blooddrinker:Cast()
    end
    -- dancing_rune_weapon,if=buff.coagulopathy.remains>2*gcd
    if RubimRH.CDsON() and TargetinRange(10) and IsReady("Dancing Rune Weapon") and (Player:BuffRemains(S.CoagulopathyBuff) > 2 * Player:GCD()) then
        return S.DancingRuneWeapon:Cast()
    end
    -- bonestorm,if=buff.death_and_decay.up&buff.bone_shield.stack>5&cooldown.dancing_rune_weapon.remains>=10
    if RubimRH.CDsON() and TargetinRange(10) and IsReady("Bonestorm") and (Player:BuffUp(S.DeathandDecayBuff) and VarBoneShieldStacks > 5 and S.DancingRuneWeapon:CooldownRemains() >= 10) then
        return S.Bonestorm:Cast()
    end
    -- tombstone,if=buff.death_and_decay.up&buff.bone_shield.stack>5&runic_power.deficit>=30&cooldown.dancing_rune_weapon.remains>=10
    if IsReady("Tombstone") and TargetinRange(8) and (Player:BuffUp(S.DeathandDecayBuff) and VarBoneShieldStacks > 5 and Player:RunicPowerDeficit() >= 30 and S.DancingRuneWeapon:CooldownRemains() >= 10) then
        return S.Tombstone:Cast()
    end
    -- marrowrend,if=!dot.bonestorm.ticking&(buff.bone_shield.stack<variable.bone_shield_refresh_value&runic_power.deficit>20|buff.bone_shield.remains<=3)
    if IsReady("Marrowrend") and TargetinRange(8) and (not bonestormActive and (VarBoneShieldStacks < VarBoneShieldRefreshValue and Player:RunicPowerDeficit() > 20 or Player:BuffRemains(S.BoneShieldBuff) <= 3)) then
        return S.Marrowrend:Cast()
    end
    -- blood_boil,if=charges_fractional>=1.5|(full_recharge_time<=gcd.max)
    if IsReady("Blood Boil") and TargetinRange(10) and (S.BloodBoil:ChargesFractional() >= 1.5 or (S.BloodBoil:FullRechargeTime() <= Player:GCD())) then
        return S.BloodBoil:Cast()
    end
    -- consumption
    if IsReady("Consumption") and TargetinRange(10) then
        return S.Consumption:Cast()
    end
    -- death_strike,if=runic_power.deficit<=variable.heart_strike_rp_drw|runic_power>=variable.death_strike_dump_amount
    if IsReady("Death Strike") and TargetinRange(8) and (Player:RunicPowerDeficit() <= VarHeartStrikeRPDRW or Player:RunicPower() >= VarDeathStrikeDumpAmt) then
        return S.DeathStrike:Cast()
    end
    -- blood_boil,if=charges_fractional>=1.5&buff.hemostasis.stack<5&cooldown.reapers_mark.remains>5
    if IsReady("Blood Boil") and TargetinRange(10) and (S.BloodBoil:ChargesFractional() >= 1.5 and Player:BuffStack(S.HemostasisBuff) < 5 and S.ReapersMark:CooldownRemains() > 5) then
        return S.BloodBoil:Cast()
    end
    -- heart_strike,if=rune>=1|rune.time_to_2<gcd|runic_power.deficit>=variable.heart_strike_rp_drw
    if IsReady("Heart Strike") and TargetinRange(8) and (Player:Rune() >= 1 or Player:RuneTimeToX(2) < Player:GCD() or Player:RunicPowerDeficit() >= VarHeartStrikeRPDRW) then
        return S.HeartStrike:Cast()
    end
  end
  
  local function Sanlayn()
    -- variable,name=death_strike_dump_amount,value=50
    -- variable,name=death_strike_pre_essence_dump_amount,value=20
    -- variable,name=bone_shield_refresh_value,value=11
    -- Note: Above variables set in variable declarations and Event Registrations.
    -- variable,name=heart_strike_rp_drw,value=(21+spell_targets.heart_strike*talent.heartbreaker.enabled*2)
    VarHeartStrikeRPDRW = 21 + EnemiesMeleeCount * num(S.Heartbreaker:IsAvailable()) * 2
    -- death_strike,if=buff.coagulopathy.remains<=gcd
    if IsReady("Death Strike") and TargetinRange(8) and (Player:BuffRemains(S.CoagulopathyBuff) <= Player:GCD()) then
        return S.DeathStrike:Cast()
    end
    -- raise_dead
    if IsReady("Raise Dead") and GetUnitName("pet") == nil and TargetinRange(20) and C_Spell.IsCurrentSpell(6603) and RubimRH.CDsON() then
        return S.RaiseDead:Cast()
      end
    -- potion,if=buff.dancing_rune_weapon.up
    -- if Settings.Commons.Enabled.Potions and Player:BuffUp(S.DancingRuneWeaponBuff) then
    --   local PotionSelected = Everyone.PotionSelected()
    --   if PotionSelected and PotionSelected:IsReady() then
    --     if Cast(PotionSelected, nil, Settings.CommonsDS.DisplayStyle.Potions) then return "potion sanlayn 6"; end
    --   end
    -- end
    if RubimRH.CDsON() and S.DancingRuneWeapon:CooldownUp() then
      -- blood_fury,if=cooldown.dancing_rune_weapon.ready
      if IsReady("Blood Fury") and TargetinRange(8) then
        return S.BloodFury:Cast()
    end
      -- berserking,if=cooldown.dancing_rune_weapon.ready
      if IsReady("Berserking") and TargetinRange(8) then
        return S.Berserking:Cast()
    end
    end
    -- blood_tap,if=rune<3
    if RubimRH.CDsON() and TargetinRange(8) and IsReady("Blood Tap") and (Player:Rune() < 3) then
        return S.BloodTap:Cast()
    end
    -- blood_boil,if=!dot.blood_plague.ticking|(dot.blood_plague.remains<10&buff.vampiric_blood.up)
    if IsReady("Blood Boil") and TargetinRange(8) and (Target:DebuffDown(S.BloodPlagueDebuff) or (Target:DebuffRemains(S.BloodPlagueDebuff) < 10 and Player:BuffUp(S.VampiricBloodBuff))) then
        return S.BloodBoil:Cast()
    end
    -- -- abomination_limb,if=buff.coagulopathy.remains>=2*gcd&(!buff.essence_of_the_blood_queen.up|buff.essence_of_the_blood_queen.remains>=3*gcd)&(!buff.vampiric_blood.up|buff.vampiric_blood.remains>=6*gcd)
    -- if RubimRH.CDsON() and IsReady("Abomination Limb") and (Player:BuffRemains(S.CoagulopathyBuff) >= 2 * Player:GCD() and (Player:BuffDown(S.EssenceoftheBloodQueenBuff) or Player:BuffRemains(S.EssenceoftheBloodQueenBuff) >= 3 * Player:GCD()) and (Player:BuffDown(S.VampiricBloodBuff) or Player:BuffRemains(S.VampiricBloodBuff) >= 6 * Player:GCD())) then
    --     return S.AbominationLimb:Cast()
    -- end
    -- blood_boil,if=cooldown.vampiric_blood.remains<3*gcd&buff.coagulopathy.remains>=gcd
    if IsReady("Blood Boil") and TargetinRange(8) and (S.VampiricBlood:CooldownRemains() < 3 * Player:GCD() and Player:BuffRemains(S.CoagulopathyBuff) >= Player:GCD()) then
        return S.BloodBoil:Cast()
    end
    -- heart_strike,if=buff.vampiric_blood.up&(buff.vampiric_blood.remains<2*gcd)
    if IsReady("Heart Strike") and TargetinRange(8) and (Player:BuffUp(S.VampiricBloodBuff) and (Player:BuffRemains(S.VampiricBloodBuff) < 2 * Player:GCD())) then
        return S.HeartStrike:Cast()
    end
    -- bonestorm,if=(!buff.vampiric_blood.up&buff.death_and_decay.up)&buff.bone_shield.stack>5&cooldown.dancing_rune_weapon.remains>=10&buff.coagulopathy.remains>3*gcd
    if RubimRH.CDsON() and TargetinRange(10) and IsReady("Bonestorm") and ((Player:BuffDown(S.VampiricBloodBuff) and Player:BuffUp(S.DeathandDecayBuff)) and VarBoneShieldStacks > 5 and S.DancingRuneWeapon:CooldownRemains() >= 10 and Player:BuffRemains(S.CoagulopathyBuff) > 3 * Player:GCD()) then
        return S.Bonestorm:Cast()
    end
    -- tombstone,if=(!buff.vampiric_blood.up&buff.death_and_decay.up)&buff.bone_shield.stack>5&runic_power.deficit>=30&cooldown.dancing_rune_weapon.remains>=10&buff.coagulopathy.remains>2*gcd
    if IsReady("Tombstone") and TargetinRange(8) and ((Player:BuffDown(S.VampiricBloodBuff) and Player:BuffUp(S.DeathandDecayBuff)) and VarBoneShieldStacks > 5 and Player:RunicPowerDeficit() >= 30 and S.DancingRuneWeapon:CooldownRemains() >= 10 and Player:BuffRemains(S.CoagulopathyBuff) > 2 * Player:GCD()) then
        return S.Tombstone:Cast()
    end
    -- dancing_rune_weapon,if=buff.coagulopathy.remains>=2*gcd&(!buff.essence_of_the_blood_queen.up|buff.essence_of_the_blood_queen.remains>=3*gcd)&(!buff.vampiric_blood.up|buff.vampiric_blood.remains>=6*gcd)
    if RubimRH.CDsON() and TargetinRange(10) and IsReady("Dancing Rune Weapon") and (Player:BuffRemains(S.CoagulopathyBuff) >= 2 * Player:GCD() and (Player:BuffDown(S.EssenceoftheBloodQueenBuff) or Player:BuffRemains(S.EssenceoftheBloodQueenBuff) >= 3 * Player:GCD()) and (Player:BuffDown(S.VampiricBloodBuff) or Player:BuffRemains(S.VampiricBloodBuff) >= 6 * Player:GCD())) then
        return S.DancingRuneWeapon:Cast()
    end
    -- death_strike,if=!buff.vampiric_strike.up&cooldown.vampiric_blood.remains<=30&runic_power>variable.death_strike_pre_essence_dump_amount&buff.essence_of_the_blood_queen.stack>=3
    if IsReady("Death Strike") and TargetinRange(8) and (Player:BuffDown(S.VampiricStrikeBuff) and S.VampiricBlood:CooldownRemains() <= 30 and Player:RunicPower() > VarDeathStrikePreEssenceDumpAmt and Player:BuffStack(S.EssenceoftheBloodQueenBuff) >= 3) then
        return S.DeathStrike:Cast()
    end
    -- heart_strike,if=(buff.vampiric_blood.up)&(buff.coagulopathy.remains>2*gcd)
    if IsReady("Heart Strike") and TargetinRange(8) and (Player:BuffUp(S.VampiricBloodBuff) and (Player:BuffRemains(S.CoagulopathyBuff) > 2 * Player:GCD())) then
        return S.HeartStrike:Cast()
    end
    -- consumption,if=buff.vampiric_blood.remains<=3|buff.infliction_of_sorrow.up|cooldown.vampiric_blood.remains>5
    if IsReady("Consumption") and TargetinRange(8) and (Player:BuffRemains(S.VampiricBloodBuff) <= 3 or Player:BuffUp(S.InflictionofSorrowBuff) or S.VampiricBlood:CooldownRemains() > 5) then
        return S.Consumption:Cast()
    end
    -- death_strike,if=buff.vampiric_blood.up&(buff.coagulopathy.remains<2*gcd|(runic_power.deficit<=variable.heart_strike_rp_drw&buff.incite_terror.stack>=3))
    if IsReady("Death Strike") and TargetinRange(8) and (Player:BuffUp(S.VampiricBloodBuff) and (Player:BuffRemains(S.CoagulopathyBuff) < 2 * Player:GCD() or (Player:RunicPowerDeficit() <= VarHeartStrikeRPDRW and Target:DebuffStack(S.InciteTerrorDebuff) >= 3))) then
        return S.DeathStrike:Cast()
    end
    -- heart_strike,if=buff.vampiric_strike.up|buff.infliction_of_sorrow.up&((talent.consumption.enabled&buff.consumption.up)|!talent.consumption.enabled)&dot.blood_plague.ticking&dot.blood_plague.remains>20
    if IsReady("Heart Strike") and TargetinRange(8) and (Player:BuffUp(S.VampiricStrikeBuff) or Player:BuffUp(S.InflictionofSorrowBuff) and ((S.Consumption:IsAvailable() and Player:BuffUp(S.ConsumptionBuff)) or not S.Consumption:IsAvailable()) and Target:DebuffUp(S.BloodPlagueDebuff) and Target:DebuffRemains(S.BloodPlagueDebuff) > 20) then
        return S.HeartStrike:Cast()
    end
    -- vampiric_blood,if=buff.coagulopathy.up
    if IsReady("Vampiric Blood") and TargetinRange(8) and (Player:BuffUp(S.CoagulopathyBuff)) then
        return S.VampiricBlood:Cast()
    end
    -- deaths_caress,if=!buff.bone_shield.up
    if IsReady("Deaths Caress") and TargetinRange(8) and (Player:BuffDown(S.BoneShieldBuff)) then
        return S.DeathsCaress:Cast()
    end
    -- death_and_decay,if=!buff.death_and_decay.up|(buff.crimson_scourge.up&(!buff.vampiric_blood.up|buff.vampiric_blood.remains>3*gcd))
    if IsReady("Death and Decay") and GetRangeTimer()>1.5 and TargetinRange(5) and (Player:BuffDown(S.DeathandDecayBuff) or (Player:BuffUp(S.CrimsonScourgeBuff) and (Player:BuffDown(S.VampiricBloodBuff) or Player:BuffRemains(S.VampiricBloodBuff) > 3 * Player:GCD()))) then
        return S.DeathandDecay:Cast()
    end
    -- marrowrend,if=!dot.bonestorm.ticking&(buff.bone_shield.stack<variable.bone_shield_refresh_value&runic_power.deficit>20|buff.bone_shield.remains<=3)
    if IsReady("Marrowrend")  and TargetinRange(10) and (not bonestormActive and (VarBoneShieldStacks < VarBoneShieldRefreshValue and Player:RunicPowerDeficit() > 20 or Player:BuffRemains(S.BoneShieldBuff) <= 3)) then
        return S.Marrowrend:Cast()
    end
    -- death_strike,if=runic_power.deficit<=variable.heart_strike_rp_drw|runic_power>=variable.death_strike_dump_amount
    if IsReady("Death Strike")  and TargetinRange(8) and (Player:RunicPowerDeficit() <= VarHeartStrikeRPDRW or Player:RunicPower() >= VarDeathStrikeDumpAmt) then
        return S.DeathStrike:Cast()
    end
    -- heart_strike,if=rune>1
    if IsReady("Heart Strike")  and TargetinRange(8) and (Player:Rune() > 1) then
        return S.HeartStrike:Cast()
    end
    -- bonestorm,if=buff.death_and_decay.up&buff.bone_shield.stack>5&cooldown.dancing_rune_weapon.remains>=10
    if RubimRH.CDsON()  and TargetinRange(10) and IsReady("Bonestorm") and (Player:BuffUp(S.DeathandDecayBuff) and VarBoneShieldStacks > 5 and S.DancingRuneWeapon:CooldownRemains() >= 10) then
        return S.Bonestorm:Cast()
    end
    -- tombstone,if=buff.death_and_decay.up&buff.bone_shield.stack>5&runic_power.deficit>=30&cooldown.dancing_rune_weapon.remains>=10
    if IsReady("Tombstone")  and TargetinRange(10) and (Player:BuffUp(S.DeathandDecayBuff) and VarBoneShieldStacks > 5 and Player:RunicPowerDeficit() >= 30 and S.DancingRuneWeapon:CooldownRemains() >= 10) then
        return S.Tombstone:Cast()
    end
    -- soul_reaper,if=active_enemies=1&target.time_to_pct_35<5&target.time_to_die>(dot.soul_reaper.remains+5)
    if IsReady("Soul Reaper")  and TargetinRange(10) and (EnemiesMeleeCount == 1 and Target:TimeToX(35) < 5 and Target:TimeToDie() > (Target:DebuffRemains(S.SoulReaperDebuff) + 5)) then
        return S.SoulReaper:Cast()
    end
    -- blood_boil,if=charges>=2|(full_recharge_time<=gcd.max)
    if IsReady("Blood Boil") and TargetinRange(10) and (S.BloodBoil:Charges() >= 2 or (S.BloodBoil:FullRechargeTime() <= Player:GCD())) then
        return S.BloodBoil:Cast()
    end
  end


--- ===== APL Main =====
local function APL()
local dndActive = IsDnDTicking()
local bonestormActive = IsBonestormTicking()


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


      if Player:IsCasting() or Player:IsChanneling() then
        return 0, "Interface\\Addons\\Rubim-RH\\Media\\channel.tga"
    elseif Player:IsDeadOrGhost() or AuraUtil.FindAuraByName("Drink", "player") or AuraUtil.FindAuraByName("Food", "player") 
    or AuraUtil.FindAuraByName("Food & Drink", "player") or AuraUtil.FindAuraByName("Ghost Wolf", "player") then
        return 0, "Interface\\Addons\\Rubim-RH\\Media\\griph.tga"
    end

    -- Get Enemies Count
    EnemiesMelee = RangeCount(8)
    if RubimRH.AoEON() then
      EnemiesMeleeCount = RangeCount(8)
    else
      EnemiesMeleeCount = 1
    end
  
    if (Player:CanAttack(Target) and Target:AffectingCombat() or Player:AffectingCombat()) then
      -- HeartStrike is limited to 5 targets maximum
      HeartStrikeCount = math.min(EnemiesMeleeCount, Player:BuffUp(S.DeathandDecayBuff) and 5 or 2)
  
      -- Check Units without Blood Plague
      UnitsWithoutBloodPlague = BloodPlagueDebuff()
  
      -- Are we actively tanking?
      IsTanking = Player:IsTankingAoE(8) or Player:IsTanking(Target)
  
      -- Bone Shield Stacks
      VarBoneShieldStacks = Player:BuffStack(S.BoneShieldBuff)
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
    
    if S.DeathCharge:ID() == RubimRH.queuedSpell[1]:ID() and AuraUtil.FindAuraByName("Death Charge", "player") then
        RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
        end

    if IsReady(RubimRH.queuedSpell[1]:ID(),nil,nil,1) then
        return RubimRH.QueuedSpell():Cast()
        end
        
        if not IsReady(RubimRH.queuedSpell[1]:ID(),nil,nil,1) or RangeCount(30) == 0 or not Target:Exists() or S.FrostwyrmsFury:ID() == RubimRH.queuedSpell[1]:ID() and Player:BuffDown(S.PillarofFrostBuff)  then
          RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
          end
        
    if Player:AffectingCombat() then
      -- call precombat
      if not Player:AffectingCombat() then
        local ShouldReturn = Precombat(); if ShouldReturn then return ShouldReturn; end
      end

      if RangeCount(30)>=1 and Player:AffectingCombat() then
        --health pot -- will need to update item ID of HPs as expansions progress
        if  Player:HealthPercentage() <= 20 and (IsUsableItem(211880) == true and GetItemCooldown(211880) == 0 and GetItemCount(211880) >= 1 or IsUsableItem(211878) == true and GetItemCooldown(211878) == 0 and GetItemCount(211878) >= 1 or IsUsableItem(211879) == true and GetItemCooldown(211879) == 0 and GetItemCount(211879) >= 1) and (not Player:InArena() and not Player:InBattlegrounds()) then
          return I.HPIcon:Cast()
          end
        end

      -- Defensives
      if IsTanking then
        local ShouldReturn = Defensives(); if ShouldReturn then return ShouldReturn; end
      end
      -- Interrupts
      if (castTime > 0.5 or channelTime > 0.5) and select(8, UnitCastingInfo("target")) == false and RubimRH.InterruptsON() and UnitExists("target") and Player:CanAttack(Target) and not Target:IsDeadOrGhost() then
        -- kick on GCD
        if IsReady("Mind Freeze",1) and (kickprio() or Target:IsAPlayer() or UnitName("target") == "Orb of Ascendance") and Player:GCDRemains()<0.5 then
          return S.MindFreeze:Cast()
          end
      
      
          end


        



      -- Display Pool icon if PoolDuringBlooddrinker is true
      if Player:IsChanneling(S.Blooddrinker) and Player:BuffUp(S.BoneShieldBuff) and UnitsWithoutBloodPlague == 0 and Player:CastRemains() > 0.2 then
        return 0, "Interface\\Addons\\Rubim-RH\\Media\\channel.tga"
        end
      -- auto_attack
      -- use_items
      if RubimRH.CDsON() then
        

        if Player:BuffUp(S.EmpowerRuneWeaponBuff) then
            local ShouldReturn = UseItems();
            if ShouldReturn then return ShouldReturn; end
          end

      end
      -- run_action_list,name=deathbringer,if=hero_tree.deathbringer
      if Player:HeroTreeID() == 33 or Player:Level() <= 70 then
        local ShouldReturn = Deathbringer(); if ShouldReturn then return ShouldReturn; end
        return 0, "Interface\\Addons\\Rubim-RH\\Media\\griph.tga"
      end
      -- run_action_list,name=sanlayn,if=hero_tree.sanlayn
      if Player:HeroTreeID() == 31 then
        local ShouldReturn = Sanlayn(); if ShouldReturn then return ShouldReturn; end
        return 0, "Interface\\Addons\\Rubim-RH\\Media\\griph.tga"      end
    end
  
        return 0, "Interface\\Addons\\Rubim-RH\\Media\\griph.tga"
    end
    
    RubimRH.Rotation.SetAPL(250, APL);
    
    local function PASSIVE()
    end
    
    RubimRH.Rotation.SetPASSIVE(250, PASSIVE);
    