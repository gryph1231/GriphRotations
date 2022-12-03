--- ============================ HEADER ============================
--- ======= LOCALIZE =======
-- Addon
local addonName, addonTable = ...
-- HeroDBC
local DBC        = HeroDBC.DBC
-- HeroLib
local HL         = HeroLib
local Cache      = HeroCache
local Unit       = HL.Unit
local Player     = Unit.Player
local Target     = Unit.Target
local Pet        = Unit.Pet
local Spell      = HL.Spell
local MultiSpell = HL.MultiSpell
local Item       = HL.Item
-- HeroRotation
local HR         = HeroRotation
local AoEON      = HR.AoEON
local CDsON      = HR.CDsON
local Cast       = HR.Cast
-- Lua
-- WoW API
local UnitHealthMax = UnitHealthMax


--- ============================ CONTENT ===========================
--- ======= APL LOCALS =======
-- luacheck: max_line_length 9999

-- Spells
local S = Spell.Monk.Brewmaster
local I = Item.Monk.Brewmaster

-- Create table to exclude above trinkets from On Use function
local OnUseExcludes = {
  -- I.TrinketName:ID(),
}

-- Rotation Var
local Enemies5y
local Enemies8y
local EnemiesCount8
local EnemiesCount10
local EnemiesCount12
local EnemiesCount15
local IsTanking

-- Interrupts
local Stuns = {
  { S.LegSweep, "Cast Leg Sweep (Stun)", function () return true end },
  { S.Paralysis, "Cast Paralysis (Stun)", function () return true end },
}

-- GUI Settings
local Everyone = HR.Commons.Everyone
local Monk = HR.Commons.Monk
local Settings = {
  General    = HR.GUISettings.General,
  Commons    = HR.GUISettings.APL.Monk.Commons,
  Brewmaster = HR.GUISettings.APL.Monk.Brewmaster
}

-- Legendary variables
local CharredPassionsEquipped = Player:HasLegendaryEquipped(86)
local ShaohaosMightEquipped = Player:HasLegendaryEquipped(89)

HL:RegisterForEvent(function()
  CharredPassionsEquipped = Player:HasLegendaryEquipped(86)
  ShaohaosMightEquipped = Player:HasLegendaryEquipped(89)
end, "PLAYER_EQUIPMENT_CHANGED")

-- Player Covenant
-- 0: none, 1: Kyrian, 2: Venthyr, 3: Night Fae, 4: Necrolord
local CovenantID = Player:CovenantID()

-- Update CovenantID if we change Covenants
HL:RegisterForEvent(function()
  CovenantID = Player:CovenantID()
end, "COVENANT_CHOSEN")

local function UseItems()
  -- use_items
  local TrinketToUse = Player:GetUseableTrinkets(OnUseExcludes)
  if TrinketToUse then
    return Cast(S.trinket1) 
  end
end

-- I am going keep this function in place in case it is needed in the future.
-- The code is sound for a smoothing of damage intake.
-- However this is not needed in the current APL.
-- Hijacked this function to easily handle the APL's multiple purify lines -- Cilraaz
local function ShouldPurify()
  -- Old return. Leaving this hear for now, in case we want to revert.
  --return S.PurifyingBrew:ChargesFractional() >= 1.8 and (Player:DebuffUp(S.HeavyStagger) or Player:DebuffUp(S.ModerateStagger) or Player:DebuffUp(S.LightStagger))
  local StaggerFull = Player:StaggerFull() or 0
  -- if there's no stagger, just exist so we don't have to calculate anything
  if StaggerFull == 0 then return false end
  local StaggerCurrent = 0
  local StaggerSpell = nil
  if Player:BuffUp(S.LightStagger) then
    StaggerSpell = S.LightStagger
  elseif Player:BuffUp(S.ModerateStagger) then
    StaggerSpell = S.ModerateStagger
  elseif Player:BuffUp(S.HeavyStagger) then
    StaggerSpell = S.HeavyStagger
  end
  if StaggerSpell then
    local spellTable = Player:DebuffInfo(StaggerSpell, false, true)
    StaggerCurrent = spellTable.points[2]
  end
  -- if=stagger.amounttototalpct>=0.7&(((target.cooldown.pause_action.remains>=20|time<=10|target.cooldown.pause_action.duration=0)&cooldown.invoke_niuzao_the_black_ox.remains<5)|buff.invoke_niuzao_the_black_ox.up)
  -- APL Note: Cast PB during the Niuzao window, but only if recently hit.
  if ((StaggerCurrent > 0 and StaggerCurrent >= StaggerFull * 0.7) and (S.InvokeNiuzaoTheBlackOx:CooldownRemains() < 5 or Player:BuffUp(S.InvokeNiuzaoTheBlackOx))) then
    return true
  end
  -- if=buff.invoke_niuzao_the_black_ox.up&buff.invoke_niuzao_the_black_ox.remains<8
  if (Player:BuffUp(S.InvokeNiuzaoTheBlackOx) and Player:BuffRemains(S.InvokeNiuzaoTheBlackOx) < 8) then
    return true
  end
  -- if=cooldown.purifying_brew.charges_fractional>=1.8&(cooldown.invoke_niuzao_the_black_ox.remains>10|buff.invoke_niuzao_the_black_ox.up)
  if (S.PurifyingBrew:ChargesFractional() >= 1.8 and (S.InvokeNiuzaoTheBlackOx:CooldownRemains() > 10 or Player:BuffUp(S.InvokeNiuzaoTheBlackOx))) then
    return true
  end
  return false
end

local function Precombat()

  
  -- -- flask
  -- -- food
  -- -- augmentation
  -- -- snapshot_stats
  -- -- potion
  -- -- Note: Not adding potion, as they're not needed pre-combat any longer
  -- -- fleshcraft
  -- if S.Fleshcraft:IsCastable() then
  --   if Cast(S.Fleshcraft, nil, Settings.Commons.DisplayStyle.Covenant) then return "fleshcraft precombat 2"; end
  -- end
  -- -- chi_burst,if=!covenant.night_fae
  -- if S.ChiBurst:IsCastable() and (CovenantID ~= 3) and Target:IsInRange(12) then
  --   if Cast(S.ChiBurst, nil, nil, not Target:IsInRange(40)) then return "chi_burst precombat 6"; end
  -- end
  -- -- chi_wave
  -- if S.ChiWave:IsCastable() then
  --   if Cast(S.ChiWave, nil, nil, not Target:IsInRange(40)) then return "chi_wave precombat 10"; end
  -- end
  -- -- Manually added openers
  -- if S.RushingJadeWind:IsCastable() and #Enemies8y >= 1 then
  --   if Cast(S.RushingJadeWind, nil, nil, not Target:IsInMeleeRange(8)) then return "rushing_jade_wind precombat 4"; end
  -- end
  -- if S.KegSmash:IsCastable() and Target:IsInRange(15) then 
  --   if Cast(S.KegSmash, nil, nil, not Target:IsInRange(40)) then return "keg_smash precombat 8"; end
  -- end
end

local function Defensives()
  if S.CelestialBrew:IsCastable() and (Player:BuffDown(S.BlackoutComboBuff) and Player:IncomingDamageTaken(1999) > (UnitHealthMax("player") * 0.1 + Player:StaggerLastTickDamage(4)) and Player:BuffStack(S.ElusiveBrawlerBuff) < 2) then
    return Cast(S.CelestialBrew) 
  end
  if S.PurifyingBrew:IsCastable() and ShouldPurify() then
    return Cast(S.PurifyingBrew)
   end
  
  if S.DampenHarm:IsCastable() and Player:BuffDown(S.FortifyingBrewBuff) and (Player:NeedPanicHealing() or Player:HealthPercentage() <= Settings.Brewmaster.DampenHarmHP) then
    return Cast(S.DampenHarm)
  end
  
  if S.FortifyingBrew:IsCastable() and Player:BuffDown(S.DampenHarmBuff) and (Player:NeedPanicHealing() or Player:HealthPercentage() <= Settings.Brewmaster.FortifyingBrewHP) then
    return Cast(S.FortifyingBrew) 
  end

   if S.DiffuseMagic:IsCastable() and Player:BuffDown(S.DampenHarmBuff) and Player:BuffDown(S.FortifyingBrewBuff) and (Player:NeedMajorHealing() or Player:HealthPercentage() <= Settings.Brewmaster.DiffuseMagicHP) then
    return Cast(S.DiffuseMagic) 
  end



end

--- ======= ACTION LISTS =======
local function APL()

  if (Player:IsCasting() or Player:IsChanneling()) then return HR.Cast(S.channeling) end

  Enemies20y = Player:GetEnemiesInRange(20)

  if  S.CracklingJadeLightning:ID() ==  HR.queuedSpell[1]:ID() and Player:MovingFor()>Player:GCD() then
    HR.queuedSpell = { HR.Spell[1].Empty, 0 }
    end


  if (not HR.queuedSpell[1]:CooldownUp() or not Player:AffectingCombat() or #Enemies20y) then 
    HR.queuedSpell = { HR.Spell[1].Empty, 0 }
end

if HR.QueuedSpell():IsReadyQueue() then
  return Cast(HR.QueuedSpell()) 
 end


  Enemies5y = Player:GetEnemiesInMeleeRange(5) -- Multiple Abilities
  Enemies8y = Player:GetEnemiesInMeleeRange(8) -- Multiple Abilities
  Enemies10y = Player:GetEnemiesInMeleeRange(10) -- Multiple Abilities
  Enemies12y = Player:GetEnemiesInMeleeRange(12) -- Multiple Abilities
  Enemies15y = Player:GetEnemiesInMeleeRange(15) -- Multiple Abilities
  EnemiesCount8 = #Enemies8y -- AOE Toogle
  EnemiesCount10 = #Enemies10y -- AOE Toogle
  EnemiesCount12 = #Enemies12y -- AOE Toogle
  EnemiesCount15 = #Enemies15y -- AOE Toogle

  -- Are we tanking?
  IsTanking = Player:IsTankingAoE(8) or Player:IsTanking(Target)



  if Settings.Commons.Enabled.HealthPotion 
  and (not Player:InArena() and not Player:InBattlegrounds())  
  and Player:HealthPercentage() <= Settings.Commons.HealthPotionHealth
  then
    local HPicon = Item(169451);
    local HealthPotionSelected = Everyone.HealthPotionSelected()
    if HealthPotionSelected and HealthPotionSelected:IsReady() then
     return Cast(HPicon)
    end
  end


  --- In Combat
  if Everyone.TargetIsValid() then

    -- if Settings.Commons.Enabled.HealthPotion then
    --   local HealthPotionSelected = Everyone.HealthPotionSelected()
    --   if HealthPotionSelected and HealthPotionSelected:IsReady() then
    --     print("testing")
    --     -- if Cast(HealthPotionSelected, nil, Settings.Commons.DisplayStyle.HealthPotions) then return "I.HealthPotion"; end
    --   end
    -- end

    -- Precombat
    if not Player:AffectingCombat() then
      local ShouldReturn = Precombat(); if ShouldReturn then return ShouldReturn; end
    end
    -- Interrupts
    local ShouldReturn = Everyone.Interrupt(5, S.SpearHandStrike, Settings.Commons.OffGCDasOffGCD.SpearHandStrike, Interrupts) and Target:IsInRange(5) and Target:CastPercentage()>25 and Target:CastPercentage()<75; if ShouldReturn then return ShouldReturn; end


    if Player:AffectingCombat() or Target:AffectingCombat() then
    -- Defensives
    if IsTanking and (EnemiesCount15>=1 or Target:IsInRange(15)) then
      local ShouldReturn = Defensives(); if ShouldReturn then return ShouldReturn; end
    end
    -- use_item,name=scars_of_fraternal_strife,if=!buff.scars_of_fraternal_strife_4.up&time>1
    --[[if I.ScarsofFraternalStrife:IsEquippedAndReady() and Settings.Commons.Enabled.Trinkets and (Player:BuffDown(S.ScarsofFraternalStrifeBuff4) and HL.CombatTime() > 1) then
      if Cast(I.ScarsofFraternalStrife, nil, Settings.Commons.DisplayStyle.Trinkets) then return "scars_of_fraternal_strife main 1"; end
    end
    -- use_item,name=cache_of_acquired_treasures,if=buff.acquired_axe.up|fight_remains<25
    if I.CacheofAcquiredTreasures:IsEquippedAndReady() and (Player:BuffUp(S.AcquiredAxeBuff) or HL.FilteredFightRemains(Enemies8y, "<", 25)) then
      if Cast(I.CacheofAcquiredTreasures, nil, Settings.Commons.DisplayStyle.Trinkets) then return "cache_of_acquired_treasures main 2"; end
    end
    -- use_item,name=jotungeirr_destinys_call
    if I.Jotungeirr:IsEquippedAndReady() then
      if Cast(I.Jotungeirr, nil, Settings.Commons.DisplayStyle.Items) then return "jotungeirr_destinys_call main 3"; end
    end]]
    -- use_items
    if (Settings.Commons.Enabled.Trinkets) then
      local ShouldReturn = UseItems(); if ShouldReturn then return ShouldReturn; end
    end
    

    if CDsON() then
    
      -- invoke_niuzao_the_black_ox,if=buff.recent_purifies.value>=health.max*0.05&(target.cooldown.pause_action.remains>=20|time<=10|target.cooldown.pause_action.duration=0)
      -- APL Note: Cast Niuzao when we'll get at least 20 seconds of uptime. This is specific to the default enemy APL and will need adjustments for other enemies.
      -- Note: Using BossFilteredFightRemains instead of the above calculation
      if S.InvokeNiuzaoTheBlackOx:IsCastable() and (CDsON() and Target:TimeToDie()>8 or HL.BossFilteredFightRemains(">", 25)) and (EnemiesCount12>=1 or Target:IsInRange(12)) then
        return Cast(S.InvokeNiuzaoTheBlackOx)
       end
      
      -- touch_of_death,if=target.health.pct<=15
      if S.TouchofDeath:IsReady() and Target:HealthPercentage() <= 15 and not Target:IsDummy() then
        return Cast(S.TouchofDeath) 
       end
      
      -- weapons_of_order
      if S.WeaponsofOrder:IsCastable() and (EnemiesCount12>=1 or Target:IsInRange(12)) then
        if Cast(S.WeaponsofOrder, nil, Settings.Commons.DisplayStyle.Covenant) then return "weapons_of_order main 22"; end
      end
      -- fallen_order
      if S.FallenOrder:IsCastable() and (EnemiesCount12>=1 or Target:IsInRange(12))  then
        if Cast(S.FallenOrder, nil, Settings.Commons.DisplayStyle.Covenant) then return "fallen_order main 24"; end
      end
      -- bonedust_brew,if=!debuff.bonedust_brew_debuff.up
      if S.BonedustBrew:IsCastable() and (Target:DebuffDown(S.BonedustBrew)) and (EnemiesCount12>=1 or Target:IsInRange(12)) then
        if Cast(S.BonedustBrew, nil, Settings.Commons.DisplayStyle.Covenant) then return "bonedust_brew main 26"; end
      end
    end
    -- purifying_brew,if=stagger.amounttototalpct>=0.7&(((target.cooldown.pause_action.remains>=20|time<=10|target.cooldown.pause_action.duration=0)&cooldown.invoke_niuzao_the_black_ox.remains<5)|buff.invoke_niuzao_the_black_ox.up)
    -- purifying_brew,if=buff.invoke_niuzao_the_black_ox.up&buff.invoke_niuzao_the_black_ox.remains<8
    -- purifying_brew,if=cooldown.purifying_brew.charges_fractional>=1.8&(cooldown.invoke_niuzao_the_black_ox.remains>10|buff.invoke_niuzao_the_black_ox.up)
    -- Handled via ShouldPurify()
    if CDsON() then
      -- black_ox_brew,if=cooldown.purifying_brew.charges_fractional<0.5
      if S.BlackOxBrew:IsCastable() and (EnemiesCount12>=1 or Target:IsInRange(12)) and S.PurifyingBrew:ChargesFractional() < 0.5 then
        if Cast(S.BlackOxBrew, Settings.Brewmaster.OffGCDasOffGCD.BlackOxBrew) then return "black_ox_brew main 28"; end
      end
      -- black_ox_brew,if=(energy+(energy.regen*cooldown.keg_smash.remains))<40&buff.blackout_combo.down&cooldown.keg_smash.up
      if S.BlackOxBrew:IsCastable() and (EnemiesCount12>=1 or Target:IsInRange(12)) and (Player:Energy() + (Player:EnergyRegen() * S.KegSmash:CooldownRemains())) < 40 and Player:BuffDown(S.BlackoutComboBuff) and S.KegSmash:CooldownUp() then
        if Cast(S.BlackOxBrew, Settings.Brewmaster.OffGCDasOffGCD.BlackOxBrew) then return "black_ox_brew main 30"; end
      end
    end
    -- fleshcraft,if=cooldown.bonedust_brew.remains<4&soulbind.pustule_eruption.enabled&cooldown
    if S.Fleshcraft:IsCastable() and (S.BonedustBrew:CooldownRemains() < 4 and S.PustuleEruption:SoulbindEnabled()) then
      if Cast(S.Fleshcraft, nil, Settings.Commons.DisplayStyle.Covenant) then return "fleshcraft main 32"; end
    end
    -- keg_smash,if=spell_targets>=2
    if S.KegSmash:IsCastable() and (Target:IsInRange(15)) then
      if Cast(S.KegSmash, nil, nil, not Target:IsSpellInRange(S.KegSmash)) then return "keg_smash main 34"; end
    end
    -- faeline_stomp,if=spell_targets>=2
    if S.FaelineStomp:IsCastable() and (EnemiesCount10 >= 2) then
      if Cast(S.FaelineStomp, nil, Settings.Commons.DisplayStyle.Covenant) then return "faeline_stomp main 36"; end
    end
    -- keg_smash,if=buff.weapons_of_order.up
    if S.KegSmash:IsCastable() and (Player:BuffUp(S.WeaponsofOrder)) and Target:IsInRange(15) then
      if Cast(S.KegSmash, nil, nil, not Target:IsSpellInRange(S.KegSmash)) then return "keg_smash main 38"; end
    end
    -- celestial_brew,if=buff.blackout_combo.down&incoming_damage_1999ms>(health.max*0.1+stagger.last_tick_damage_4)&buff.elusive_brawler.stack<2
    -- Handled via Defensives()
    -- exploding_keg
    if S.ExplodingKeg:IsCastable() and EnemiesCount8>=1 and CDsON() then
      if Cast(S.ExplodingKeg, nil, nil, not Target:IsInRange(40)) then return "exploding_keg 39"; end
    end
    -- tiger_palm,if=talent.rushing_jade_wind.enabled&buff.blackout_combo.up&buff.rushing_jade_wind.up
    if S.TigerPalm:IsReady() and Target:IsInRange(5) and (S.RushingJadeWind:IsAvailable() and Player:BuffUp(S.BlackoutComboBuff) and Player:BuffUp(S.RushingJadeWind)) then
      return Cast(S.TigerPalm) 
     end
  
    -- breath_of_fire,if=buff.charred_passions.down&runeforge.charred_passions.equipped
    if S.BreathOfFire:IsCastable() and (CharredPassionsEquipped and Player:BuffDown(S.CharredPassions)) and (EnemiesCount12>=1 or Target:IsInRange(10)) then
      if Cast(S.BreathOfFire, nil, nil, not Target:IsInRange(12)) then return "breath_of_fire main 42"; end
    end

    -- blackout_kick
    if S.BlackoutKick:IsCastable() and Target:IsInRange(5) then
      return Cast(S.BlackoutKick)  
    end
    --keg_smash
    if S.KegSmash:IsReady() and Target:IsInRange(15) then
      if Cast(S.KegSmash, nil, nil, not Target:IsSpellInRange(S.KegSmash)) then return "keg_smash main 46"; end
    end
    -- chi_burst,if=cooldown.faeline_stomp.remains>2&spell_targets>=2
    if S.ChiBurst:IsCastable() and (S.FaelineStomp:CooldownRemains() > 2 and EnemiesCount10 >= 2 and Target:IsInRange(10)) then
      return Cast(S.ChiBurst) 
    end
    -- faeline_stomp
    if S.FaelineStomp:IsCastable() then
      if Cast(S.FaelineStomp, nil, Settings.Commons.DisplayStyle.Covenant) then return "faeline_stomp main 50"; end
    end
    -- touch_of_death
    if S.TouchofDeath:IsReady() and CDsON() and not Target:IsDummy() and Target:IsInRange(8) then
      if Cast(S.TouchofDeath, Settings.Brewmaster.GCDasOffGCD.TouchofDeath, nil, not Target:IsInMeleeRange(5)) then return "touch_of_death main 52"; end
    end
  -- rushing_jade_wind,if=buff.rushing_jade_wind.down
    if S.RushingJadeWind:IsCastable() and (Player:BuffDown(S.RushingJadeWind)) and (EnemiesCount12>=1 or Target:IsInRange(12)) then
      if Cast(S.RushingJadeWind, nil, nil, not Target:IsInMeleeRange(8)) then return "rushing_jade_wind main 54"; end
    end
    -- spinning_crane_kick,if=buff.charred_passions.up
    if S.SpinningCraneKick:IsReady() and (Player:BuffUp(S.CharredPassions)) and (EnemiesCount10>=1 or Target:IsInRange(10)) then
      if Cast(S.SpinningCraneKick, nil, nil, not Target:IsInMeleeRange(8)) then return "spinning_crane_kick main 56"; end
    end
    -- breath_of_fire,if=buff.blackout_combo.down&(buff.bloodlust.down|(buff.bloodlust.up&dot.breath_of_fire_dot.refreshable))
    if S.BreathOfFire:IsCastable() and (EnemiesCount12>=1 or Target:IsInRange(12)) and (Player:BuffDown(S.BlackoutComboBuff) and (Player:BloodlustDown() or (Player:BloodlustUp() and Target:BuffRefreshable(S.BreathOfFireDotDebuff)))) then
      if Cast(S.BreathOfFire, nil, nil, not Target:IsInMeleeRange(8)) then return "breath_of_fire main 58"; end
    end
    -- chi_burst
    if S.ChiBurst:IsCastable() and Target:IsInRange(12) then
      if Cast(S.ChiBurst) then return "chi_burst main 60"; end
    end
    -- chi_wave
    if S.ChiWave:IsCastable() and Target:IsInRange(12)  then
      if Cast(S.ChiWave, nil, nil, not Target:IsInRange(40)) then return "chi_wave main 62"; end
    end
    -- spinning_crane_kick,if=!runeforge.shaohaos_might.equipped&active_enemies>=3&cooldown.keg_smash.remains>gcd&(energy+(energy.regen*(cooldown.keg_smash.remains+execute_time)))>=65&(!talent.spitfire.enabled|!runeforge.charred_passions.equipped)
    if S.SpinningCraneKick:IsCastable() and (EnemiesCount10>=1 or Target:IsInRange(10)) and (not ShaohaosMightEquipped and EnemiesCount10 >= 3 and S.KegSmash:CooldownRemains() > Player:GCD() and (Player:Energy() + (Player:EnergyRegen() * (S.KegSmash:CooldownRemains() + S.SpinningCraneKick:ExecuteTime()))) >= 65 and ((not S.Spitfire:IsAvailable()) or not CharredPassionsEquipped)) then
      if Cast(S.SpinningCraneKick, nil, nil, not Target:IsInMeleeRange(8)) then return "spinning_crane_kick main 64"; end
    end
    -- tiger_palm,if=!talent.blackout_combo&cooldown.keg_smash.remains>gcd&(energy+(energy.regen*(cooldown.keg_smash.remains+gcd)))>=65
    if S.TigerPalm:IsCastable() and Target:IsInRange(5) and (not S.BlackoutCombo:IsAvailable() and S.KegSmash:CooldownRemains() > Player:GCD() and (Player:Energy() + (Player:EnergyRegen() * (S.KegSmash:CooldownRemains() + Player:GCD()))) >= 65) then
      return Cast(S.TigerPalm)
     end
    
    -- arcane_torrent,if=energy<31
    if S.ArcaneTorrent:IsCastable() and CDsON() and (Player:Energy() < 31) and Target:IsInRange(8) then
      if Cast(S.ArcaneTorrent, Settings.Commons.OffGCDasOffGCD.Racials, nil, not Target:IsInMeleeRange(8)) then return "arcane_torrent main 68"; end
    end
    -- fleshcraft,if=soulbind.volatile_solvent.enabled
    if S.Fleshcraft:IsCastable() and (S.VolatileSolvent:SoulbindEnabled()) then
      if Cast(S.Fleshcraft, nil, Settings.Commons.DisplayStyle.Covenant) then return "fleshcraft main 70"; end
    end
    -- rushing_jade_wind
    if S.RushingJadeWind:IsCastable() and (EnemiesCount12>=1 or Target:IsInRange(12))  then
      if Cast(S.RushingJadeWind, nil, nil, not Target:IsInMeleeRange(8)) then return "rushing_jade_wind main 72"; end
    end
    -- Manually added Pool filler
    -- if Cast(S.PoolEnergy) then return "Pool Energy"; end
  end
end
  if  Player:IsMounted() then return HR.Cast(S.mounted)
  elseif Player:AffectingCombat() then
    return HR.Cast(S.combat)
  else
  return HR.Cast(S.MPI)
  end


end

local function Init()
  HR.Print("Brewmaster Monk should be up to date. @griph#9817 on discord if any issues")
end

HR.SetAPL(268, APL, Init)