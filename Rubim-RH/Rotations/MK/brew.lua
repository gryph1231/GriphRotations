--- ============================ HEADER ============================
--- ======= LOCALIZE =======
-- Addon
local addonName, addonTable = ...
-- HeroLib
local HL     = HeroLib
local Cache  = HeroCache
local Unit   = HL.Unit
local Player = Unit.Player
local Target = Unit.Target
local Pet    = Unit.Pet
local Spell  = HL.Spell
local Item   = HL.Item
local mainAddon = RubimRH

RubimRH.Spell[268] = {
    lust1 = Spell(57724),
    lust2 = Spell(57723),
    lust3 = Spell(80354),
    lust4 = Spell(95809),
    lust5 = Spell(264689),
    lustAT = Spell(155145),
  FaelineStomp             = Spell(388193),
  SoothingMist             = Spell(115175),
  AncestralCall            = Spell(274738),
  ArcaneTorrent            = Spell(25046),
  BagofTricks              = Spell(312411),
  Berserking               = Spell(26297),
  BloodFury                = Spell(20572),
  GiftoftheNaaru           = Spell(59547),
  Fireblood                = Spell(265221),
  LightsJudgment           = Spell(255647),
  QuakingPalm              = Spell(107079),
  Shadowmeld               = Spell(58984),
  CraneVortex              = Spell(388848),
  -- Abilities
  CracklingJadeLightning   = Spell(117952),
  ExpelHarm                = Spell(322101),
  LegSweep                 = Spell(119381),
  Provoke                  = Spell(115546),
  Resuscitate              = Spell(115178),
  RisingSunKick            = Spell(107428),
  Roll                     = Spell(109132),
  TigerPalm                = Spell(100780),
  TouchofDeath             = Spell(322109),
  Transcendence            = Spell(101643),
  TranscendenceTransfer    = Spell(119996),
  Vivify                   = Spell(116670),
  -- Talents125174
  BonedustBrew             = Spell(386276),
  Celerity                 = Spell(115173),
  ChiBurst                 = Spell(123986),
  ChiTorpedo               = Spell(115008),
  ChiWave                  = Spell(115098),
  DampenHarm               = Spell(122278),
  Detox                    = Spell(218164),
  Disable                  = Spell(116095),
  DiffuseMagic             = Spell(122783),
  EyeoftheTiger            = Spell(196607),
  InnerStrengthBuff        = Spell(261769),
  Paralysis                = Spell(115078),
  RingofPeace              = Spell(116844),
  RushingJadeWind          = Spell(116847),
  SpearHandStrike          = Spell(116705),
  SummonWhiteTigerStatue   = Spell(388686),
  TigerTailSweep           = Spell(264348),
  TigersLust               = Spell(116841),
  -- Buffs
  BonedustBrewBuff         = Spell(386276),
  DampenHarmBuff           = Spell(122278),
  RushingJadeWindBuff      = Spell(116847),
  -- Debuffs
  -- Item Effects
  TheEmperorsCapacitorBuff = Spell(235054),
  -- Misc
  PoolEnergy               = Spell(999995),
  StopFoF                  = Spell(59752), -- will to survive
  -- Abilities
  FallenOrder            = Spell(326860),
  WeaponsofOrder         = Spell(387184),
  BlackoutKick           = Spell(205523),
  BreathOfFire           = Spell(115181),
  Clash                  = Spell(324312),
  InvokeNiuzaoTheBlackOx = Spell(132578),
  KegSmash               = Spell(121253),
  SpinningCraneKick      = Spell(322729),
  -- Debuffs
  BreathOfFireDotDebuff  = Spell(123725),
  -- Talents
  BlackoutCombo          = Spell(196736),
  BlackoutComboBuff      = Spell(228563),
  BlackOxBrew            = Spell(115399),
  BobAndWeave            = Spell(280515),
  CelestialFlames        = Spell(325177),
  ExplodingKeg           = Spell(325153),
  HighTolerance          = Spell(196737),
  LightBrewing           = Spell(325093),
  SpecialDelivery        = Spell(196730),
  Spitfire               = Spell(242580),
  SummonBlackOxStatue    = Spell(115315),
  -- Defensive
  CelestialBrew          = Spell(322507),
  ElusiveBrawlerBuff     = Spell(195630),
  FortifyingBrew         = Spell(115203),
  FortifyingBrewBuff     = Spell(115203),
  PurifyingBrew          = Spell(119582),
  PurifiedChiBuff        = Spell(325092),
  Shuffle                = Spell(215479),
  -- Legendary Effects (Shadowlands)
  CharredPassions        = Spell(338140),
  MightyPour             = Spell(337994),
  -- Stagger Levels
  HeavyStagger           = Spell(124273),
  ModerateStagger        = Spell(124274),
  LightStagger           = Spell(124275),
}

local S = RubimRH.Spell[268]

-- Rotation Var
local ShouldReturn; -- Used to get the return string
-- Items
if not Item.Monk then Item.Monk = {} end
Item.Monk.Brewmaster = {
    trink2 = Item(184016, { 13, 14 }), --Skulker's Wing
    trink = Item(179350, { 13, 14 }), --???
    lust = Item(164978), --drums of fury
    HPicon = Item(169451),
    tx1 = Item(118330),
    tx2 = Item(114616),
};

local I = Item.Monk.Brewmaster;


-- local BossTarget:TimeToDie() = 11111
-- local Target:TimeToDie() = 11111
-- HL:RegisterForEvent(function()
--     VarFoPPreChan = 0
--     BossTarget:TimeToDie() = 11111
--     Target:TimeToDie() = 11111
-- end, "PLAYER_REGEN_ENABLED")


function HealthPotionSelected()

    local HealthPotionIDs = {
        191380, 191379, 191378

    }

    for _, HealthPotionID in ipairs(HealthPotionIDs) do
        if Item(HealthPotionID):IsUsable() then
            return Item(HealthPotionID)
        end
    end
end


local function UseItems()

    local trinket1 = GetInventoryItemID("player", 13) 
    local trinket2 = GetInventoryItemID("player", 14) 
    local trinket1ready = IsUsableItem(trinket1) and GetItemCooldown(trinket1) == 0 and IsEquippedItem(trinket1)
    local trinket2ready = IsUsableItem(trinket2) and GetItemCooldown(trinket2) == 0 and IsEquippedItem(trinket2)
    
      if trinket1ready then
          return I.tx1:Cast()      
        end
      if trinket2ready then
          return I.tx2:Cast()
      end
  end

  local function ShouldPurify()
    -- Old return. Leaving this hear for now, in case we want to revert.
    --return S.PurifyingBrew:ChargesFractional() >= 1.8 and (Player:DeBuff(S.HeavyStagger) or Player:DeBuff(S.ModerateStagger) or Player:DeBuff(S.LightStagger))
    local StaggerFull = Player:StaggerFull() or 0
    -- if there's no stagger, just exist so we don't have to calculate anything
    if StaggerFull == 0 then return false end
    local StaggerCurrent = 0
    local StaggerSpell = nil
    if Player:Buff(S.LightStagger) then
      StaggerSpell = S.LightStagger
    elseif Player:Buff(S.ModerateStagger) then
      StaggerSpell = S.ModerateStagger
    elseif Player:Buff(S.HeavyStagger) then
      StaggerSpell = S.HeavyStagger
    end
    if StaggerSpell then
      local spellTable = Player:DebuffInfo(StaggerSpell, false, true)
      StaggerCurrent = spellTable.points[2]
    end
    -- if=stagger.amounttototalpct>=0.7&(((target.cooldown.pause_action.remains>=20|time<=10|target.cooldown.pause_action.duration=0)&cooldown.invoke_niuzao_the_black_ox.remains<5)|buff.invoke_niuzao_the_black_ox.up)
    -- APL Note: Cast PB during the Niuzao window, but only if recently hit.
    if ((StaggerCurrent > 0 and StaggerCurrent >= StaggerFull * 0.7) and (S.InvokeNiuzaoTheBlackOx:CooldownRemains() < 5 or Player:Buff(S.InvokeNiuzaoTheBlackOx))) then
      return true
    end
    -- if=buff.invoke_niuzao_the_black_ox.up&buff.invoke_niuzao_the_black_ox.remains<8
    if (Player:Buff(S.InvokeNiuzaoTheBlackOx) and Player:BuffRemains(S.InvokeNiuzaoTheBlackOx) < 8) then
      return true
    end
    -- if=cooldown.purifying_brew.charges_fractional>=1.8&(cooldown.invoke_niuzao_the_black_ox.remains>10|buff.invoke_niuzao_the_black_ox.up)
    if (S.PurifyingBrew:ChargesFractional() >= 1.8 and (S.InvokeNiuzaoTheBlackOx:CooldownRemains() > 10 or Player:Buff(S.InvokeNiuzaoTheBlackOx))) then
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
    if S.CelestialBrew:IsCastable() and (not Player:Buff(S.BlackoutComboBuff) and Player:IncomingDamageTaken(1999) > (UnitHealthMax("player") * 0.1 + Player:StaggerLastTickDamage(4)) and Player:BuffStack(S.ElusiveBrawlerBuff) < 2) then
        return S.SpinningCraneKick:Cast()
    end
    if S.PurifyingBrew:IsCastable() and ShouldPurify() then
        return S.SpinningCraneKick:Cast()
    end
    
    if S.DampenHarm:IsCastable() and not Player:Buff(S.FortifyingBrewBuff) and (Player:NeedPanicHealing() or Player:HealthPercentage() <= 50) then
        return S.SpinningCraneKick:Cast()
    end
    
    if S.FortifyingBrew:IsCastable() and not Player:Buff(S.DampenHarmBuff) and (Player:NeedPanicHealing() or Player:HealthPercentage() <= 35) then
        return S.SpinningCraneKick:Cast()
    end
  
     if S.DiffuseMagic:IsCastable() and not Player:Buff(S.DampenHarmBuff) and not Player:Buff(S.FortifyingBrewBuff) and (Player:NeedMajorHealing() or Player:HealthPercentage() <= 45) then
        return S.SpinningCraneKick:Cast()
    end
  
  
  
  end
  

local function APL()
    HL.GetEnemies("Melee");
    HL.GetEnemies(8);
    HL.GetEnemies(10);
    HL.GetEnemies(12);
    HL.GetEnemies(15);
    HL.GetEnemies(20);
    HL.GetEnemies(25);
    HL.GetEnemies(30);
    HL.GetEnemies(35);
    HL.GetEnemies(40);
    Enemies5y = Cache.EnemiesCount[5]
    Enemies8y = Cache.EnemiesCount[8]
    Enemies10y = Cache.EnemiesCount[10]
    Enemies12y = Cache.EnemiesCount[12]
    Enemies15y = Cache.EnemiesCount[15]
    Enemies20y = Cache.EnemiesCount[20]
    Enemies25y = Cache.EnemiesCount[25]
    Enemies30y = Cache.EnemiesCount[30]
    Enemies35y = Cache.EnemiesCount[35]
    Enemies40y = Cache.EnemiesCount[40]

    -- Enemies10ySplash = Target:GetEnemiesInSplashRange(10)
    --  if Player:AffectingCombat() then
    --     BossTarget:TimeToDie() = HL.BossTarget:TimeToDie()(nil, true)
    --     Target:TimeToDie() = BossTarget:TimeToDie()
    --     if Target:TimeToDie() == 11111 then
    --       Target:TimeToDie() = HL.Target:TimeToDie()(Enemies10ySplash, false)
    --     end
    -- end


    if select(8, UnitCastingInfo("target")) == false and Target:CastPercentage() > math.random(43, 87) and
        RubimRH.InterruptsON() and S.SpearHandStrike:IsReadyQueue(8) and Player:AffectingCombat() then
        return S.SpearHandStrike:Cast()
    end


    if (S.CracklingJadeLightning:ID()== RubimRH.queuedSpell[1]:ID() 
    or S.ChiBurst:ID() == RubimRH.queuedSpell[1]:ID()
    or S.Vivify:ID() == RubimRH.queuedSpell[1]:ID()
    or S.SoothingMist:ID() == RubimRH.queuedSpell[1]:ID())
    and Player:MovingFor() > Player:GCD() then
        RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }

    end

    if not RubimRH.queuedSpell[1]:CooldownUp() or not Target:IsInRange(10) or not Player:AffectingCombat() then
        RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
    end

    if RubimRH.QueuedSpell():IsReadyQueue() then
        return RubimRH.QueuedSpell():Cast()
    end


  
    if Player:IsCasting() or Player:IsChanneling() then
        return 0, "Interface\\Addons\\Rubim-RH\\Media\\channel.tga"
    elseif Player:IsDeadOrGhost() or AuraUtil.FindAuraByName("Drink", "player") or
        AuraUtil.FindAuraByName("Food", "player") or AuraUtil.FindAuraByName("Food & Drink", "player") then
        return 0, "Interface\\Addons\\Rubim-RH\\Media\\griph.tga"
    end


    IsTanking = Player:IsTankingAoE(8) or Player:IsTanking(Target)



    if (not Player:InArena() and not Player:InBattlegrounds())
        and Player:HealthPercentage() <= 30
    then
        local HealthPotionSelected = HealthPotionSelected()
        if HealthPotionSelected and HealthPotionSelected:IsReady() then
            return I.HPIcon:Cast()
        end
    end


-- Out of Combat
if not Player:AffectingCombat() then
	
    -- if S.RushingJadeWind:IsCastableP() and not Player:Buff(S.RushingJadeWind) and Cache.EnemiesCount[15] >= 1 then
        -- return S.RushingJadeWind:Cast()
    -- end

	return 0, "Interface\\Addons\\Rubim-RH\\Media\\griph.tga"
end

-- Spell Queue


	if RubimRH.QueuedSpell():IsReadyQueue() then
        return RubimRH.QueuedSpell():Cast()
    end
	
	if not RubimRH.queuedSpell[1]:CooldownUp() or not Target:IsInRange(10) or not Player:AffectingCombat() then
		RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
	end
	
-- General
if Player:AffectingCombat() then


    if select(8, UnitCastingInfo("target")) == false and Target:CastPercentage() > math.random(43, 87) and
    RubimRH.InterruptsON() and S.SpearHandStrike:IsReadyQueue(8) and Player:AffectingCombat() then
    return S.SpearHandStrike:Cast()
end

if IsTanking and (Enemies15y>=1 or Target:IsInRange(15)) then
    local ShouldReturn = Defensives(); if ShouldReturn then return ShouldReturn; end
  end
 
  if RubimRH.CDsON() and Target:IsInRange(8) then
      local ShouldReturn = UseItems();
      if ShouldReturn then return ShouldReturn; end
    end
    -- invoke_niuzao_the_black_ox,if=buff.recent_purifies.value>=health.max*0.05&(target.cooldown.pause_action.remains>=20|time<=10|target.cooldown.pause_action.duration=0)
    -- APL Note: Cast Niuzao when we'll get at least 20 seconds of uptime. This is specific to the default enemy APL and will need adjustments for other enemies.
    -- Note: Using BossFilteredTarget:TimeToDie() instead of the above calculation
    if S.InvokeNiuzaoTheBlackOx:IsCastable() and (RubimRH.CDsON() and Target:TimeToDie()>8 or HL.BossFilteredTarget:TimeToDie()(">", 25)) and (Enemies12y>=1 or Target:IsInRange(12)) then
        return S.InvokeNiuzaoTheBlackOx:Cast()
    end
    
    -- touch_of_death,if=target.health.pct<=15
    if S.TouchofDeath:IsReady() and Target:HealthPercentage() <= 15 and not Target:IsDummy() then
        return S.SpinningCraneKick:Cast()
    end
    
    -- weapons_of_order
    if S.WeaponsofOrder:IsCastable() and (Enemies12y>=1 or Target:IsInRange(12)) then
        return S.WeaponsofOrder:Cast()
    end
    -- fallen_order
    if S.FallenOrder:IsCastable() and (Enemies12y>=1 or Target:IsInRange(12))  then
        return S.FallenOrder:Cast()
    end
    -- bonedust_brew,if=!debuff.bonedust_brew_debuff.up
    if S.BonedustBrew:IsCastable() and (not Target:Debuff(S.BonedustBrew)) and Target:IsInRange(5) then
        return S.BonedustBrew:Cast()
    end
  end
  -- purifying_brew,if=stagger.amounttototalpct>=0.7&(((target.cooldown.pause_action.remains>=20|time<=10|target.cooldown.pause_action.duration=0)&cooldown.invoke_niuzao_the_black_ox.remains<5)|buff.invoke_niuzao_the_black_ox.up)
  -- purifying_brew,if=buff.invoke_niuzao_the_black_ox.up&buff.invoke_niuzao_the_black_ox.remains<8
  -- purifying_brew,if=cooldown.purifying_brew.charges_fractional>=1.8&(cooldown.invoke_niuzao_the_black_ox.remains>10|buff.invoke_niuzao_the_black_ox.up)
  -- Handled via ShouldPurify()
  if RubimRH.CDsON() then
    -- black_ox_brew,if=cooldown.purifying_brew.charges_fractional<0.5
    if S.BlackOxBrew:IsCastable() and (Enemies12y>=1 or Target:IsInRange(12)) and S.PurifyingBrew:ChargesFractional() < 0.5 then
        return S.BlackOxBrew:Cast()
    end
    -- black_ox_brew,if=(energy+(energy.regen*cooldown.keg_smash.remains))<40&buff.blackout_combo.down&cooldown.keg_smash.up
    if S.BlackOxBrew:IsCastable() and (Enemies12y>=1 or Target:IsInRange(12)) and (Player:Energy() + (Player:EnergyRegen() * S.KegSmash:CooldownRemains())) < 40 and not Player:Buff(S.BlackoutComboBuff) and S.KegSmash:CooldownUp() then
        return S.BlackOxBrew:Cast()
    end
  end
  -- fleshcraft,if=cooldown.bonedust_brew.remains<4&soulbind.pustule_eruption.enabled&cooldown
  -- if S.Fleshcraft:IsCastable() and (S.BonedustBrew:CooldownRemains() < 4 and S.PustuleEruption:SoulbindEnabled()) then
  --   return S.Fleshcraft:Cast()
  -- end
  -- keg_smash,if=spell_targets>=2
  if S.KegSmash:IsCastable() and (Target:IsInRange(15)) then
    return S.KegSmash:Cast()
  end
  -- faeline_stomp,if=spell_targets>=2
  if S.FaelineStomp:IsCastable() and (Enemies10y >= 2) then
    return S.FaelineStomp:Cast()
  end
  -- keg_smash,if=buff.weapons_of_order.up
  if S.KegSmash:IsCastable() and (Player:Buff(S.WeaponsofOrder)) and Target:IsInRange(15) then
    return S.KegSmash:Cast()
  end
  -- celestial_brew,if=buff.blackout_combo.down&incoming_damage_1999ms>(health.max*0.1+stagger.last_tick_damage_4)&buff.elusive_brawler.stack<2
  -- Handled via Defensives()
  -- exploding_keg
  if S.ExplodingKeg:IsCastable() and Target:IsInRange(5)  and RubimRH.CDsON() then
    return S.ExplodingKeg:Cast()
  end
  -- tiger_palm,if=talent.rushing_jade_wind.enabled&buff.blackout_combo.up&buff.rushing_jade_wind.up
  if S.TigerPalm:IsReady() and Target:IsInRange(5) and (S.RushingJadeWind:IsAvailable() and Player:Buff(S.BlackoutComboBuff) and Player:Buff(S.RushingJadeWind)) then
    return S.TigerPalm:Cast()
  end

  -- breath_of_fire,if=buff.charred_passions.down&runeforge.charred_passions.equipped
  if S.BreathOfFire:IsCastable() and (CharredPassionsEquipped and not Player:Buff(S.CharredPassions)) and (Enemies12y>=1 or Target:IsInRange(10)) then
    return S.BreathOfFire:Cast()
  end

  -- blackout_kick
  if S.BlackoutKick:IsCastable() and Target:IsInRange(5) then
    return S.BlackoutKick:Cast()
  end
  --keg_smash
  if S.KegSmash:IsReady() and Target:IsInRange(15) then
    return S.KegSmash:Cast()
  end
  -- chi_burst,if=cooldown.faeline_stomp.remains>2&spell_targets>=2
  if S.ChiBurst:IsCastable() and (S.FaelineStomp:CooldownRemains() > 2 and Enemies10y >= 2 and Target:IsInRange(10)) then
    return S.SpinningCraneKick:Cast()
  end
  -- faeline_stomp
  if S.FaelineStomp:IsCastable() then
    return S.FaelineStomp:Cast()
  end
  -- touch_of_death
  if S.TouchofDeath:IsReady() and RubimRH.CDsON() and not Target:IsDummy() and Target:IsInRange(8) then
    return S.SpinningCraneKick:Cast()
  end
-- rushing_jade_wind,if=buff.rushing_jade_wind.down
  if S.RushingJadeWind:IsCastable() and (not Player:Buff(S.RushingJadeWind)) and (Enemies12y>=1 or Target:IsInRange(12)) then
    return S.RushingJadeWind:Cast()
  end
  -- spinning_crane_kick,if=buff.charred_passions.up
  if S.SpinningCraneKick:IsReady() and (Player:Buff(S.CharredPassions)) and (Enemies10y>=1 or Target:IsInRange(10)) then
    return S.SpinningCraneKick:Cast()
  end
  -- breath_of_fire,if=buff.blackout_combo.down&(buff.bloodlust.down|(buff.bloodlust.up&dot.breath_of_fire_dot.refreshable))
  if S.BreathOfFire:IsCastable() and (Enemies12y>=1 or Target:IsInRange(12)) and (not Player:Buff(S.BlackoutComboBuff) and (Player:BloodlustDown() or (Player:BloodlustUp() and Target:BuffRefreshable(S.BreathOfFireDotDebuff)))) then
    return S.BreathOfFire:Cast()
  end
  -- chi_burst
  if S.ChiBurst:IsCastable() and Target:IsInRange(12) then
    return S.ChiBurst:Cast()
  end
  -- chi_wave
  if S.ChiWave:IsCastable() and Target:IsInRange(12)  then
    return S.ChiWave:Cast()
  end
  -- spinning_crane_kick,if=!runeforge.shaohaos_might.equipped&active_enemies>=3&cooldown.keg_smash.remains>gcd&(energy+(energy.regen*(cooldown.keg_smash.remains+execute_time)))>=65&(!talent.spitfire.enabled|!runeforge.charred_passions.equipped)
  if S.SpinningCraneKick:IsCastable() and (Enemies10y>=1 or Target:IsInRange(10)) and (not ShaohaosMightEquipped and Enemies10y >= 3 and S.KegSmash:CooldownRemains() > Player:GCD() and (Player:Energy() + (Player:EnergyRegen() * (S.KegSmash:CooldownRemains() + S.SpinningCraneKick:ExecuteTime()))) >= 65 and ((not S.Spitfire:IsAvailable()) or not CharredPassionsEquipped)) then
    return S.SpinningCraneKick:Cast()
  end
  -- tiger_palm,if=!talent.blackout_combo&cooldown.keg_smash.remains>gcd&(energy+(energy.regen*(cooldown.keg_smash.remains+gcd)))>=65
  if S.TigerPalm:IsCastable() and Target:IsInRange(5) and (not S.BlackoutCombo:IsAvailable() and S.KegSmash:CooldownRemains() > Player:GCD() and (Player:Energy() + (Player:EnergyRegen() * (S.KegSmash:CooldownRemains() + Player:GCD()))) >= 65) then
    return S.TigerPalm:Cast()
  end
  
  -- arcane_torrent,if=energy<31
  if S.ArcaneTorrent:IsCastable() and RubimRH.CDsON() and (Player:Energy() < 31) and Target:IsInRange(8) then
    return S.ArcaneTorrent:Cast() 
end
  -- fleshcraft,if=soulbind.volatile_solvent.enabled
--   if S.Fleshcraft:IsCastable() and (S.VolatileSolvent:SoulbindEnabled()) then
--     return S.Fleshcraft:Cast() 
-- end
  -- rushing_jade_wind
  if S.RushingJadeWind:IsCastable() and (Enemies12y>=1 or Target:IsInRange(12))  then
return S.RushingJadeWind:Cast() 
end
  -- Manually added Pool filler
  -- if Cast(S.PoolEnergy) then return "Pool Energy"; end
  if S.ExpelHarm:IsCastable() and (Enemies8y>=1 or Target:IsInRange(8))  then
    return S.ExpelHarm:Cast()
  end

  


    return 0, 135328
end
RubimRH.Rotation.SetAPL(268, APL);

local function PASSIVE()
    return RubimRH.Shared()
end

RubimRH.Rotation.SetPASSIVE(268, PASSIVE);