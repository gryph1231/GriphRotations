--- ============================ HEADER ============================
--- ======= LOCALIZE =======
-- Addon
local addonName, addonTable = ...
-- HeroDBC
local DBC = HeroDBC.DBC
-- HeroLib
local HL = HeroLib
local Cache = HeroCache
local Unit = HL.Unit
local Player = Unit.Player
local Target = Unit.Target
local Spell = HL.Spell
local MultiSpell = HL.MultiSpell
local Item = HL.Item
-- HeroRotation
local HR = HeroRotation
local AoEON = HR.AoEON
local CDsON = HR.CDsON
-- Lua
local mathmin = math.min
local mathabs = math.abs

--- ============================ CONTENT ============================
--- ======= APL LOCALS =======
-- Commons
local Everyone = HR.Commons.Everyone
local Rogue = HR.Commons.Rogue

-- GUI Settings
local Settings = {
  General = HR.GUISettings.General,
  Commons = HR.GUISettings.APL.Rogue.Commons,
  Commons2 = HR.GUISettings.APL.Rogue.Commons2,
  Outlaw = HR.GUISettings.APL.Rogue.Outlaw,
}

-- Define S/I for spell and item arrays
local S = Spell.Rogue.Outlaw
local I = Item.Rogue.Outlaw

-- Create table to exclude above trinkets from On Use function
local OnUseExcludes = {
}

S.Dispatch:RegisterDamageFormula(
  -- Dispatch DMG Formula (Pre-Mitigation):
  --- Player Modifier
    -- AP * CP * EviscR1_APCoef * Aura_M * NS_M * DS_M * DSh_M * SoD_M * Finality_M * Mastery_M * Versa_M
  --- Target Modifier
    -- Ghostly_M * Sinful_M
  function ()
    return
      --- Player Modifier
        -- Attack Power
        Player:AttackPowerDamageMod() *
        -- Combo Points
        Rogue.CPSpend() *
        -- Eviscerate R1 AP Coef
        0.3 *
        -- Aura Multiplier (SpellID: 137036)
        1.0 *
        -- Versatility Damage Multiplier
        (1 + Player:VersatilityDmgPct() / 100) *
      --- Target Modifier
        -- Ghostly Strike Multiplier
        (Target:DebuffUp(S.GhostlyStrike) and 1.1 or 1)
  end
)

-- Rotation Var
local Enemies30y, EnemiesBF, EnemiesBFCount
local ShouldReturn; -- Used to get the return string
local BladeFlurryRange = 6
local BetweenTheEyesDMGThreshold
local EffectiveComboPoints, ComboPoints, ComboPointsDeficit
local Energy, EnergyRegen, EnergyDeficit, EnergyTimeToMax, EnergyMaxOffset
local Interrupts = {
  { S.Blind, "Cast Blind (Interrupt)", function () return true end },
}

-- Utils
local function num(val)
  if val then return 1 else return 0 end
end


do
    local DeeperStratagem = Spell(193531)
    local DeviousStratagem = Spell(394321)
  function CPMaxSpend()
    if DeeperStratagem:IsAvailable() and DeviousStratagem:IsAvailable() then
    return 7
    elseif DeeperStratagem:IsAvailable() and not DeviousStratagem:IsAvailable() or not DeeperStratagem:IsAvailable() and DeviousStratagem:IsAvailable() then
    return 6
    else
    return 5
    end
  end
  end
  
-- Stable Energy Prediction
local PrevEnergyTimeToMaxPredicted, PrevEnergyPredicted = 0, 0
local function EnergyTimeToMaxStable (MaxOffset)
  local EnergyTimeToMaxPredicted = Player:EnergyTimeToMaxPredicted(nil, MaxOffset)
  if EnergyTimeToMaxPredicted < PrevEnergyTimeToMaxPredicted 
    or (EnergyTimeToMaxPredicted - PrevEnergyTimeToMaxPredicted) > 0.5 then
    PrevEnergyTimeToMaxPredicted = EnergyTimeToMaxPredicted
  end
  return PrevEnergyTimeToMaxPredicted
end
local function EnergyPredictedStable ()
  local EnergyPredicted = Player:EnergyPredicted()
  if EnergyPredicted > PrevEnergyPredicted
    or (EnergyPredicted - PrevEnergyPredicted) > 9 then
    PrevEnergyPredicted = EnergyPredicted
  end
  return PrevEnergyPredicted
end

--- ======= ACTION LISTS =======
local RtB_BuffsList = {
  S.Broadside,
  S.BuriedTreasure,
  S.GrandMelee,
  S.RuthlessPrecision,
  S.SkullandCrossbones,
  S.TrueBearing
}
local function RtB_List (Type, List)
  if not Cache.APLVar.RtB_List then Cache.APLVar.RtB_List = {} end
  if not Cache.APLVar.RtB_List[Type] then Cache.APLVar.RtB_List[Type] = {} end
  local Sequence = table.concat(List)
  -- All
  if Type == "All" then
    if not Cache.APLVar.RtB_List[Type][Sequence] then
      local Count = 0
      for i = 1, #List do
        if Player:BuffUp(RtB_BuffsList[List[i]]) then
          Count = Count + 1
        end
      end
      Cache.APLVar.RtB_List[Type][Sequence] = Count == #List and true or false
    end
  -- Any
  else
    if not Cache.APLVar.RtB_List[Type][Sequence] then
      Cache.APLVar.RtB_List[Type][Sequence] = false
      for i = 1, #List do
        if Player:BuffUp(RtB_BuffsList[List[i]]) then
          Cache.APLVar.RtB_List[Type][Sequence] = true
          break
        end
      end
    end
  end
  return Cache.APLVar.RtB_List[Type][Sequence]
end
-- Get the number of Roll the Bones buffs currently on
local function RtB_Buffs ()
  if not Cache.APLVar.RtB_Buffs then
    Cache.APLVar.RtB_Buffs = 0
    for i = 1, #RtB_BuffsList do
      if Player:BuffUp(RtB_BuffsList[i]) then
        Cache.APLVar.RtB_Buffs = Cache.APLVar.RtB_Buffs + 1
      end
    end
  end
  return Cache.APLVar.RtB_Buffs
end

local function RtB_BuffRemains()
  if not Cache.APLVar.RtB_BuffRemains then
      Cache.APLVar.RtB_BuffRemains = 0;
      for i = 1, #RtB_BuffsList do
          if Player:BuffUp(RtB_BuffsList[i]) then
              Cache.APLVar.RtB_BuffRemains = Player:BuffRemains(RtB_BuffsList[i]);
              break;
          end
      end
  end
  return Cache.APLVar.RtB_BuffRemains;
end



local function UseItems()
  -- use_items
  local TrinketToUse = Player:GetUseableTrinkets(OnUseExcludes)
  -- print(TrinketToUse:ID())
  if TrinketToUse and tonumber(TrinketToUse:ID()) == GetInventoryItemID("player", 13) then
    return Cast(S.TRINKET1, nil, Settings.Commons.DisplayStyle.Trinkets)
  elseif TrinketToUse and tonumber(TrinketToUse:ID()) == GetInventoryItemID("player", 14) then
    return Cast(S.TRINKET2, nil, Settings.Commons.DisplayStyle.Trinkets)
  end
end

--- ======= MAIN =======
local function APL ()

    Enemies5y = Player:GetEnemiesInMeleeRange(5) -- Multiple Abilities
    Enemies8y = Player:GetEnemiesInMeleeRange(8) -- Multiple Abilities
    Enemies10y = Player:GetEnemiesInMeleeRange(10) -- Multiple Abilities
    Enemies12y = Player:GetEnemiesInMeleeRange(12) -- Multiple Abilities
    Enemies15y = Player:GetEnemiesInMeleeRange(15) -- Multiple Abilities
    Enemies20y = Player:GetEnemiesInRange(20)
    Enemies25y = Player:GetEnemiesInRange(25)
    EnemiesCount8 = #Enemies8y -- AOE Toogle
    EnemiesCount10 = #Enemies10y -- AOE Toogle
    EnemiesCount12 = #Enemies12y -- AOE Toogle
    EnemiesCount15 = #Enemies15y -- AOE Toogle
    EnemiesCount20 = #Enemies20y -- AOE Toogle
    EnemiesCount25 = #Enemies25y -- AOE Toogle

  RtB_BuffRemains()
  RtB_Buffs()
  

  if Player:IsMounted() then return HR.Cast(S.mounted) end 




  if (not HR.queuedSpell[1]:CooldownUp() or not Player:AffectingCombat() or EnemiesCount25 == 0) then
    HR.queuedSpell = { HR.Spell[1].Empty, 0 }
  end

  if HR.QueuedSpell():IsReadyQueue() then
    return Cast(HR.QueuedSpell())
  end





  IsTanking = Player:IsTankingAoE(8) or Player:IsTanking(Target)



  if Settings.Commons.Enabled.HealthPotion
      and (not Player:InArena() and not Player:InBattlegrounds())
      and Player:HealthPercentage() <= Settings.Commons.HealthPotionHealth
  then
    local HPicon = Item(169451);
    local HealthPotionSelected = Everyone.HealthPotionSelected()
    if HealthPotionSelected and HealthPotionSelected:IsReady() then
      return HR.Cast(HPicon)
    end
  end





    --------------------------------------------------------------------------------------------------------------------------------------------
    ----------------------------------------------------------Functions/Top priorities----------------------------------------------------------
    --------------------------------------------------------------------------------------------------------------------------------------------
    if Player:IsCasting() or Player:IsChanneling() then
      return HR.Cast(S.channeling)
  elseif Player:IsDeadOrGhost() or AuraUtil.FindAuraByName("Drink", "player") or
      AuraUtil.FindAuraByName("Food", "player") or AuraUtil.FindAuraByName("Food & Drink", "player") then
      return HR.Cast(S.MPI)
  end

  SnDAS = select(16, AuraUtil.FindAuraByName("Slice and Dice", "player"))
  if SnDAS == nil then
      SnDAS = 0
  end

  if Player:BuffUp(S.EchoingReprimandCP2) or Player:BuffUp(S.EchoingReprimandCP3) or Player:BuffUp(S.EchoingReprimandCP4)
      or Player:BuffUp(S.EchoingReprimandCP5) then
      erbuff = true
  else
      erbuff = false
  end

  if (Player:BuffUp(S.EchoingReprimandCP2) and Player:ComboPoints() == 2) or
      (Player:BuffUp(S.EchoingReprimandCP3) and Player:ComboPoints() == 3)
      or (Player:BuffUp(S.EchoingReprimandCP4) and Player:ComboPoints() == 4) or
      (Player:BuffUp(S.EchoingReprimandCP5) and Player:ComboPoints() == 5) then
      ercp = true
  else
      ercp = false
  end

  if ercp == true then
      effective_combo_points = 7
  else
      effective_combo_points = Player:ComboPoints()
  end

  --Reroll BT + GM or single buffs early other than Broadside, TB with Shadowdust, or SnC with Blunderbuss
  if true then
      rtb_reroll = (
          RtB_Buffs() < 2 and
              (
              not Player:BuffUp(S.Broadside) and
                  (not S.FanTheHammer:IsAvailable() or not Player:BuffUp(S.SkullandCrossbones)) and
                  (not IsEquippedItem("Shadowdust Locket") or not Player:BuffUp(S.TrueBearing))))
          or (RtB_Buffs() == 2 and Player:BuffUp(S.BuriedTreasure) and Player:BuffUp(S.GrandMelee))

      --Ensure we get full Ambush CP gains and aren't rerolling Count the Odds buffs away
      ambush_condition = Player:ComboPointsDeficit() >= 2 + num(Player:BuffUp(S.Broadside)) and
          UnitPower("player", 3) >= 50 and (not S.CountTheOdds:IsAvailable() or RtB_BuffRemains() >= 10)

      if S.BetweentheEyes:IsReadyQueue(20) then
          --Always attempt to use BtE at 5+ CP, regardless of CP gen waste
          finishcondition = effective_combo_points >= 5
      elseif Target:DebuffUp(S.Flagellation) and Target:DebuffRemains(S.Flagellation) <= Player:GCD() then
          --Finish at 2+ in the last GCD of Flagellation
          finishcondition = effective_combo_points >= 2
      else
          --Finish at max possible CP without overflowing bonus combo points
          finishcondition = (
              Player:ComboPoints() >=
                  CPMaxSpend() - num(Player:BuffUp(S.Broadside)) -
                  (
                  num(Player:BuffUp(S.Opportunity)) *
                      (num(S.QuickDraw:IsAvailable()) or num(S.FanTheHammer:IsAvailable())))) or
              effective_combo_points >= CPMaxSpend()
      end

      bladeflurrysync = EnemiesCount12 < 2 or
          (Player:BuffRemains(S.BladeFlurry) > 1 + num(S.KillingSpree:IsAvailable()))

      mfdcondition = Player:ComboPoints() >=
          CPMaxSpend() -
          (num(Player:BuffUp(S.Broadside)) + num(Player:BuffUp(S.Opportunity)) * num(S.QuickDraw:IsAvailable())) and
          S.MarkedforDeath:IsReadyQueue(10)

      if IsEquippedItem("Sigil of the Master Assassin") and not S.MarkedforDeath:IsAvailable() then
          --value=(!cooldown.between_the_eyes.ready&variable.finish_condition)|(cooldown.between_the_eyes.ready&variable.ambush_condition)
          vanish_ma_condition = (not S.BetweentheEyes:CooldownUp() and finishcondition) or
              (S.BetweentheEyes:CooldownUp() and ambush_condition)
      elseif IsEquippedItem("Sigil of the Master Assassin") and S.MarkedforDeath:IsAvailable() and finishcondition then
          --vanish,if=variable.vanish_ma_condition&master_assassin_remains=0&variable.blade_flurry_sync
          vanish_ma_condition = finishcondition
      end
      --variable,name=killing_spree_vanish_sync,value=!runeforge.mark_of_the_master_assassin|cooldown.vanish.remains>10|master_assassin_remains>2
      killing_spree_vanish_sync = not IsEquippedItem("Sigil of the Master Assassin") or
          S.Vanish:CooldownRemains() > 10 or Player:BuffRemains(S.mantle) > 2
  end
  --print(finishcondition)
  --------------------------------------------------------------------------------------------------------------------------------------------
  ----------------------------------------------------------Interrupts & Shiv-----------------------------------------------------------------
  --------------------------------------------------------------------------------------------------------------------------------------------
  if select(8, UnitCastingInfo("target")) == false and Target:CastPercentage() > math.random(43, 87) and
      HR.InterruptsON() and S.Kick:IsReadyQueue(8) and Player:AffectingCombat() then
      return HR.Cast(S.Kick)
  end

  if (select(4, UnitAura("target", 1)) == "enrage"
      or AuraUtil.FindAuraByName("Undying Rage", "target")
      or AuraUtil.FindAuraByName("Enrage", "target")
      or AuraUtil.FindAuraByName("Unholy Frenzy", "target")
      or AuraUtil.FindAuraByName("Angering Shriek", "target")
      or AuraUtil.FindAuraByName("Loyal Beasts", "target")
      or AuraUtil.FindAuraByName("Frenzy", "target")
      or AuraUtil.FindAuraByName("Motivational Clubbing", "target")
      or AuraUtil.FindAuraByName("Motivated", "target")
      or AuraUtil.FindAuraByName("Seething Rage", "target")
      or AuraUtil.FindAuraByName("Vengeful Rage", "target")
      or AuraUtil.FindAuraByName("Raging Tantrum", "target")
      or AuraUtil.FindAuraByName("Death Wish", "target")
      or AuraUtil.FindAuraByName("Battle Trance", "target"))
      and HR.InterruptsON() and S.Shiv:IsReadyQueue(8) and Player:AffectingCombat() and Target:TimeToDie() > 4 then
      return HR.Cast(S.Shiv)
  end
  --------------------------------------------------------------------------------------------------------------------------------------------
  ----------------------------------------------------------Out of Combat---------------------------------------------------------------------
  --------------------------------------------------------------------------------------------------------------------------------------------
  if not Player:AffectingCombat() and not Player:BuffUp(S.VanishBuff) then
      if S.Stealth:IsCastableQueue() and not Player:BuffUp(S.Stealth) and
          (IsResting("player") == false or Player:CanAttack(Target)) then
          return HR.Cast(S.Stealth)
      end

      if S.CrimsonVial:IsCastableQueue() and EnemiesCount12 == 0 and Player:HealthPercentage() < 100 and
          Player:EnergyDeficit() == 0 then
          return HR.Cast(S.CrimsonVial)
      end

      if S.InstantPoison:IsCastableQueue() and not Player:BuffUp(S.WoundPoison) and
          Player:BuffRemains(S.InstantPoison) < 300 and not Player:IsCasting(S.InstantPoison) and
          not Player:IsMoving() then
          return HR.Cast(S.InstantPoison)
      end

      -- if S.CripplingPoison:IsCastableQueue() and not Player:BuffUp(S.NumbingPoison) and Player:BuffRemains(S.CripplingPoison) < 300 and not Player:IsCasting(S.CripplingPoison) and not Player:IsMoving() then
      -- return S.CripplingPoison:Cast()
      -- end

      if S.NumbingPoison:IsCastableQueue() and not Player:BuffUp(S.CripplingPoison) and
          not Player:BuffUp(S.CripplingPoison) and Player:BuffRemains(S.NumbingPoison) < 300 and
          not Player:IsCasting(S.NumbingPoison) and not Player:IsMoving() then
          return HR.Cast(S.NumbingPoison)
      end

      if IsResting("player") == false and Player:ComboPoints() >= CPMaxSpend() then
          if S.SliceandDice:IsCastableQueue() and Player:BuffRemains(S.SliceandDice) < 8 and
              EnemiesCount25 >= 1 then
              return HR.Cast(S.SliceandDice)
          end
      end

      if S.RolltheBones:IsCastableQueue() and IsResting("player") == false and EnemiesCount25 >= 1
          and ((not Player:BuffUp(S.mantle) or Player:BuffUp(S.Stealth))
              and not Player:DebuffUp(S.Dreadblades) and not Target:DebuffUp(S.Flagellation)
              and (RtB_Buffs() == 0 or rtb_reroll)) then
          return HR.Cast(S.RolltheBones)
      end

      if not HR.queuedSpell[1]:CooldownUp() or not Target:IsInRange(10) or not Player:AffectingCombat() then
          HR.queuedSpell = { HR.Spell[1].Empty, 0 }
      end

      return HR.Cast(S.MPI)
  end
  --------------------------------------------------------------------------------------------------------------------------------------------
  ----------------------------------------------------------Spell Queue-----------------------------------------------------------------------
  --------------------------------------------------------------------------------------------------------------------------------------------
  if not HR.queuedSpell[1]:CooldownUp() or not Target:IsInRange(10) or
      (not Player:AffectingCombat() and not Player:BuffUp(S.VanishBuff)) then
      HR.queuedSpell = { HR.Spell[1].Empty, 0 }
  end

  if S.lustAT:ID() == HR.queuedSpell[1]:ID() and
      (
      Player:DebuffUp(S.lust1) or Player:DebuffUp(S.lust2) or Player:DebuffUp(S.lust3) or Player:DebuffUp(S.lust4) or
          Player:DebuffUp(S.lust5)) then
      HR.queuedSpell = { HR.Spell[1].Empty, 0 }
  end

  if S.lustAT:ID() == HR.queuedSpell[1]:ID() and not Player:DebuffUp(S.lust1) and not Player:DebuffUp(S.lust2) and
      not Player:DebuffUp(S.lust3) and not Player:DebuffUp(S.lust4) and not Player:DebuffUp(S.lust5) and
      (I.drums:IsReadyQueue()) then
      return S.lustAT:Cast() -- BIND LUST KEYBIND IN BINDPAD TO ARCANE TORRENT
  end

  if S.KidneyShot:ID() == HR.queuedSpell[1]:ID() and Target:DebuffUp(S.CheapShot) then
      HR.queuedSpell = { HR.Spell[1].Empty, 0 }
  end

  if S.Gouge:ID() == HR.queuedSpell[1]:ID() and
      (
      Target:DebuffUp(S.CheapShot) or not Target:IsInRange(10) or not Player:AffectingCombat() or Player:BuffUp(S.Stealth)
          or Target:DebuffUp(S.BetweentheEyes) or Player:BuffUp(S.VanishBuff) or Target:DebuffUp(S.Blind)) then
      HR.queuedSpell = { HR.Spell[1].Empty, 0 }
  end

  if HR.QueuedSpell():IsReadyQueue() and S.Dreadblades:ID() ~= HR.queuedSpell[1]:ID() and
      S.Flagellation:ID() ~= HR.queuedSpell[1]:ID() then
      return HR.QueuedSpell():Cast()
  end

  if S.Flagellation:ID() == HR.queuedSpell[1]:ID() and finishcondition and Player:CanAttack(Target) and
      Target:IsInRange(10) and not Player:BuffUp(S.Stealth) and not Player:BuffUp(S.VanishBuff) and RtB_Buffs() >= 1 and
      bladeflurrysync and (S.Dreadblades:CooldownRemains() <= 7 + (num(Player:BuffUp(S.TrueBearing)) * 3.5)) then
      return S.Flagellationz:Cast()
  end

  if S.Dreadblades:ID() == HR.queuedSpell[1]:ID() and Player:ComboPoints() <= 2 and not finishcondition and
      Player:CanAttack(Target) and Target:IsInRange(10) and not Player:BuffUp(S.Stealth) and
      not Player:BuffUp(S.VanishBuff) and RtB_Buffs() >= 1 and bladeflurrysync then
      return HR.Cast(S.Dreadblades)
  end
  --------------------------------------------------------------------------------------------------------------------------------------------
  ----------------------------------------------------------Explosives------------------------------------------------------------------------
  --------------------------------------------------------------------------------------------------------------------------------------------
  if S.PistolShot:IsReadyQueue() and UnitName('target') == 'Explosives' then
      return HR.Cast(S.PistolShot)
  end
  --------------------------------------------------------------------------------------------------------------------------------------------
  ----------------------------------------------------------Cooldowns-------------------------------------------------------------------------
  --------------------------------------------------------------------------------------------------------------------------------------------
  if not IsCurrentSpell(6603) and not Player:BuffUp(S.Stealth) and not Player:BuffUp(S.VanishBuff) and
      Player:CanAttack(Target)
      and Target:AffectingCombat() and Target:IsInRange(20) then
      return HR.Cast(S.autoattack)
  end

  if Settings.Commons.Enabled.Trinkets and Target:IsInRange(8) then
    local ShouldReturn = UseItems();
    if ShouldReturn then return ShouldReturn; end
  end

  if S.BladeFlurry:IsCastableQueue() and
      (
      not Player:BuffUp(S.VanishBuff) and not Player:BuffUp(S.Stealth) and
          (
          HR.AoEON() and (not Player:BuffUp(S.BladeFlurry) or Player:BuffRemains(S.BladeFlurry) < Player:GCD())
              and EnemiesCount12 >= 2)) then
      return HR.Cast(S.BladeFlurry)
  end

  if S.RolltheBones:IsCastableQueue() and EnemiesCount25 >= 1 and not Player:BuffUp(S.VanishBuff)
      and (not Player:BuffUp(S.mantle)
          and not Player:DebuffUp(S.Dreadblades)
          and (RtB_Buffs() == 0 or rtb_reroll)) then
      return HR.Cast(S.RolltheBones)
  end

  if S.Flagellation:IsReadyQueue() and not Player:BuffUp(S.Stealth) and Target:IsInRange(10) and Player:CanAttack(Target)
      and HR.CDsON() and Player:AffectingCombat() and finishcondition and bladeflurrysync and
      (S.Dreadblades:CooldownRemains() <= 7 + (num(Player:BuffUp(S.TrueBearing)) * 3.5)) then
      return S.Flagellationz:Cast()
  end

  if IsEquippedItem("Sigil of the Master Assassin") and Target:IsInRange(10) and Player:CanAttack(Target) and
      not Player:BuffUp(S.Stealth)
      and ((finishcondition and UnitPower("player", 3) >= 32) or UnitPower("player", 3) >= 50) and SnDAS == 64 then
      if S.Vanish:IsReadyQueue() and Player:GCDRemains() <= 0.5 and Player:AffectingCombat() and
          Player:BuffRemains(S.mantle) == 0 and bladeflurrysync and vanish_ma_condition then
          return HR.Cast(S.Vanish)
      end

      if Player:BuffUp(S.mantle) and Player:BuffUp(S.VanishBuff) then
          if S.Dispatch:IsCastableQueue(8) and finishcondition then
              return HR.Cast(S.Dispatch)
          end

          if S.Ambush:IsCastableQueue(8) then
              return HR.Cast(S.Ambush)
          end
      end
  end

  if S.AdrenalineRush:IsCastableQueue() and not Player:BuffUp(S.Stealth) and not Player:BuffUp(S.AdrenalineRush) and
      Target:IsInRange(9) and Player:CanAttack(Target)
      and HR.CDsON() and Player:AffectingCombat() and
      (not S.ImprovedAdrenalineRush:IsAvailable() or Player:ComboPoints() <= 2) then
      return HR.Cast(S.AdrenalineRush)
  end

  if S.Dreadblades:IsCastableQueue() and Player:ComboPoints() <= 2 and Player:CanAttack(Target) and
      Target:IsInRange(10) and not Player:BuffUp(S.Stealth) and Player:AffectingCombat()
      and (not S.MarkedforDeath:IsAvailable() or not S.MarkedforDeath:CooldownUp())
      and (not S.Flagellation:IsAvailable() or Target:DebuffRemains(S.Flagellation) > Player:GCD() * 2) then
      return HR.Cast(S.Dreadblades)
  end

  if S.MarkedforDeath:IsCastableQueue() and Target:IsInRange(11) and Player:CanAttack(Target)
      and
      (
      Player:ComboPointsDeficit() >= CPMaxSpend() - 1 and
          not
          (
          (Player:ComboPoints() == 2 and Player:BuffUp(S.EchoingReprimandCP2)) or
              (Player:ComboPoints() == 3 and Player:BuffUp(S.EchoingReprimandCP3)) or
              (Player:ComboPoints() == 4 and Player:BuffUp(S.EchoingReprimandCP4)))) then
      return HR.Cast(S.MarkedforDeath)
  end

  if S.BladeRush:IsReadyQueue() and HR.CDsON() and not HR.LastCast(S.Vanish, 1) and Player:AffectingCombat()
      and not Target:DebuffUp(S.Blind)
      and not Player:BuffUp(S.Stealth) and not Player:BuffUp(S.VanishBuff) and Target:IsInRange(5)
      and
      (
      EnemiesCount12 == 1 and EnergyTimeToMaxRounded() > 2 or
          (EnemiesCount12 > 1 and Player:BuffUp(S.BladeFlurry))
          or S.BladeFlurry:CooldownRemains() >= 10) then
      return HR.Cast(S.BladeRush)
  end

  if IsEquippedItem("Shadowdust Locket") and Target:IsInRange(10) and Player:CanAttack(Target) and
      not Player:BuffUp(S.Stealth) then
      if S.Vanish:IsReadyQueue() and Player:GCDRemains() <= 0.5 and Player:AffectingCombat() and finishcondition
          and S.Flagellation:IsAvailable() and not S.Flagellation:CooldownUp() and
          (not S.Dreadblades:IsAvailable() or not S.Dreadblades:CooldownUp() or not Target:DebuffUp(S.Flagellation)) then
          return HR.Cast(S.Vanish)
      end

      if Player:BuffUp(S.VanishBuff) then
          if S.Dispatch:IsCastableQueue(8) and finishcondition then
              return HR.Cast(S.Dispatch)
          end

          if S.Ambush:IsCastableQueue(8) then
              return HR.Cast(S.Ambush)
          end
      end
  end
  --------------------------------------------------------------------------------------------------------------------------------------------
  ----------------------------------------------------------Echoing Reprimand-----------------------------------------------------------------
  --------------------------------------------------------------------------------------------------------------------------------------------
  -- if (Player:ComboPoints() == 2 and Player:BuffUp(S.EchoingReprimandCP2)) or (Player:ComboPoints() == 3 and Player:BuffUp(S.EchoingReprimandCP3)) or (Player:ComboPoints() == 4 and Player:BuffUp(S.EchoingReprimandCP4)) then
  -- if S.BetweentheEyes:IsReadyQueue(20) and not Target:DebuffUp(S.Blind) and not Player:BuffUp(S.Stealth) and not Player:BuffUp(S.VanishBuff) and Player:AffectingCombat() then
  -- return HR.Cast(S.BetweentheEyes)
  -- end

  -- if S.Dispatch:IsReadyQueue(8) and not Target:DebuffUp(S.Blind) and not Player:BuffUp(S.Stealth) and not Player:BuffUp(S.VanishBuff) and Player:AffectingCombat() then
  -- return HR.Cast(S.Dispatch)
  -- end
  -- end
  --------------------------------------------------------------------------------------------------------------------------------------------
  ----------------------------------------------------------Finishers-------------------------------------------------------------------------
  --------------------------------------------------------------------------------------------------------------------------------------------
  if finishcondition then
      if S.BetweentheEyes:IsReadyQueue(20) and Target:TimeToDie() > 3 and not Target:DebuffUp(S.Blind) and
          not Player:BuffUp(S.Stealth) and Player:AffectingCombat() and not Player:BuffUp(S.VanishBuff)
          and
          (
          Target:DebuffRemains(S.BetweentheEyes) < 4 or
              (
              (S.GreenSkinsWickers:IsAvailable() and not Player:BuffUp(S.GreenSkinsWickersBuff)) or
                  (not S.GreenSkinsWickers:IsAvailable() and Player:BuffUp(S.RuthlessPrecision)))) then
          return HR.Cast(S.BetweentheEyes)
      end
  end

  if S.SliceandDice:IsReadyQueue() and
      (SnDAS ~= 64 or (SnDAS == 64 and Player:BuffRemains(S.SliceandDice) <= Player:GCD() * 2))
      and Target:IsInRange(10) and Player:ComboPoints() >= CPMaxSpend() and not Player:BuffUp(S.mantle) then
      return HR.Cast(S.SliceandDice)
  end

  if finishcondition then
      if S.SliceandDice:IsReadyQueue() and not S.SwiftSlasher:IsAvailable() and not Player:BuffUp(S.GrandMelee) and
          Target:IsInRange(10)
          and Player:BuffRemains(S.SliceandDice) < Player:GCD() * 2 and not Player:BuffUp(S.mantle) then
          return HR.Cast(S.SliceandDice)
      end

      if S.Dispatch:IsReadyQueue(8) and not Target:DebuffUp(S.Blind) and not Player:BuffUp(S.Stealth) and
          Player:AffectingCombat() and not Player:BuffUp(S.VanishBuff)
          and (SnDAS == 64 or not S.SwiftSlasher:IsAvailable()) then
          if S.ColdBlood:IsReadyQueue(8) and not Player:BuffUp(S.ColdBlood) and not S.GreenSkinsWickers:IsAvailable()
              and not Player:BuffUp(S.mantle) and bladeflurrysync then
              return HR.Cast(S.ColdBlood)
          end
          if S.Dispatch:IsReadyQueue(8) then
              return HR.Cast(S.Dispatch)
          end
      end
  end
  --------------------------------------------------------------------------------------------------------------------------------------------
  ----------------------------------------------------------Builders--------------------------------------------------------------------------
  --------------------------------------------------------------------------------------------------------------------------------------------
  if not HR.LastCast(S.MarkedforDeath, 1) and not Player:BuffUp(S.Stealth) and not Target:DebuffUp(S.Blind) and
      not Player:BuffUp(S.VanishBuff) and Player:AffectingCombat()
      and (not finishcondition or (S.SwiftSlasher:IsAvailable() and SnDAS ~= 64)) then
      if S.EchoingReprimand:CooldownRemains() <= 10 and SnDAS == 64
          and (
          ((Player:ComboPoints() == 1 - num(Player:BuffUp(S.Broadside))) and Player:BuffUp(S.EchoingReprimandCP2))
              or ((Player:ComboPoints() == 2 - num(Player:BuffUp(S.Broadside))) and Player:BuffUp(S.EchoingReprimandCP3))
              or ((Player:ComboPoints() == 3 - num(Player:BuffUp(S.Broadside))) and Player:BuffUp(S.EchoingReprimandCP4))
          ) then
          if S.PistolShot:IsReadyQueue(20) and not Player:BuffUp(S.Opportunity) then
              return HR.Cast(S.PistolShot)
          end
      end
      --(not finishcondition or (S.SwiftSlasher:IsAvailable() and SnDAS ~= 64))
      -- if not ((UnitClassification("target") == "minus" and UnitClassification("target") == "trivial" and UnitClassification("target") == "normal") or Player:InDungeonOrRaid()) then
      -- if S.GhostlyStrike:IsReadyQueue(8) and (Target:DebuffUp(S.BetweentheEyes) or UnitClassification("target") == "worldboss") and Target:TimeToDie() > 4 then
      -- return S.GhostlyStrike:Cast()
      -- end
      -- end

      if S.EchoingReprimand:IsReadyQueue(8) then
          return S.EchoingReprimand:Cast()
      end

      if S.PistolShot:IsReadyQueue(20)
          and
          (
          (
              Player:BuffUp(S.GreenSkinsWickersBuff) and Player:BuffUp(S.Opportunity) and
                  (not S.FanTheHammer:IsAvailable() or Player:BuffRemains(S.GreenSkinsWickersBuff) < 2))
              or
              (
              S.FanTheHammer:IsAvailable() and Player:BuffUp(S.Opportunity) and
                  (Player:BuffStack(S.Opportunity) >= 6 or Player:BuffRemains(S.Opportunity) < 2))
              or
              (
              S.FanTheHammer:IsAvailable() and Player:BuffUp(S.Opportunity) and Player:ComboPointsDeficit() > 4 and
                  not Player:DebuffUp(S.Dreadblades))) then
          if S.ColdBlood:IsCastableQueue() and not Player:BuffUp(S.ColdBlood) and
              (
              (Player:BuffUp(S.Opportunity) and Player:BuffUp(S.GreenSkinsWickersBuff)) or
                  (Player:BuffUp(S.GreenSkinsWickersBuff) and Player:BuffRemains(S.GreenSkinsWickersBuff) < 2))
              and not Player:BuffUp(S.mantle) and bladeflurrysync then
              return HR.Cast(S.ColdBlood)
          end
          if S.PistolShot:IsReadyQueue(20) then
              return HR.Cast(S.PistolShot)
          end
      end

      if Player:EnergyTimeToMaxPredicted() <= Player:GCD() * 2 or Player:DebuffUp(S.Dreadblades) or
          Target:DebuffUp(S.Flagellation)
          or SnDAS ~= 64 or Player:BuffUp(S.mantle) or RtB_Buffs() >= 5 or erbuff == true or
          (not Target:DebuffUp(S.BetweentheEyes) and S.BetweentheEyes:CooldownUp())
          or (Player:BuffUp(S.BladeFlurry) and EnemiesCount12 >= 2) or
          S.Flagellation:ID() == HR.queuedSpell[1]:ID() or S.Dreadblades:ID() == HR.queuedSpell[1]:ID() then
          if S.Ambush:IsReadyQueue(8) then
              return HR.Cast(S.Ambush)
          end

          -- pistol_shot,if=!talent.fan_the_hammer&BuffUp.opportunity.up&(energy.base_deficit>energy.regen*1.5|!talent.weaponmaster&combo_points.deficit<=1+BuffUp.broadside.up|talent.quick_draw.enabled|talent.audacity.enabled&!BuffUp.audacity.up)
          if S.PistolShot:IsReadyQueue(20)
              and
              (
              not S.FanTheHammer:IsAvailable() and Player:BuffUp(S.Opportunity) and
                  (
                  Player:EnergyTimeToMaxPredicted() > 1.5 or
                      S.Weaponmaster:IsAvailable() and Player:ComboPointsDeficit() <= 1 + num(Player:BuffUp(S.Broadside))
                      or S.QuickDraw:IsAvailable() or S.Audacity:IsAvailable() and not Player:BuffUp(S.Audacity))) then
              return HR.Cast(S.PistolShot)
          end

          if S.SinisterStrike:IsReadyQueue(8) then
              return HR.Cast(S.SinisterStrike)
          end
      end
  end
  --------------------------------------------------------------------------------------------------------------------------------------------
  ----------------------------------------------------------OOR Pistol Shot / BTE-------------------------------------------------------------
  --------------------------------------------------------------------------------------------------------------------------------------------
  if not Target:IsInRange(11) and not Target:DebuffUp(S.Blind) and not Player:BuffUp(S.Stealth) and
      Player:AffectingCombat() then
      if S.BetweentheEyes:IsReadyQueue(20) and EnergyTimeToMaxRounded() <= Player:GCD() and
          Player:ComboPoints() >= CPMaxSpend() then
          return HR.Cast(S.BetweentheEyes)
      end

      if S.PistolShot:IsReadyQueue(20) and Player:AffectingCombat() and Player:EnergyDeficitPredicted() < 25 and
          (Player:ComboPointsDeficit() >= 1 or EnergyTimeToMaxRounded() <= Player:GCD()) then
          return HR.Cast(S.PistolShot)
      end

  end




  if Player:IsMounted() then return HR.Cast(S.mounted)
  elseif Player:AffectingCombat() then
    return HR.Cast(S.combat)
  else
    return HR.Cast(S.MPI)
  end

  end




local function Init ()
  HR.Print("OL rogue should be up to date. @griph#9817 on discord if any issues")
end

HR.SetAPL(260, APL, Init)
