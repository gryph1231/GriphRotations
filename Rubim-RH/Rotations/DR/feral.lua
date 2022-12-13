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
local MultiSpell = HL.MultiSpell;
-- Lua
local pairs = pairs;
local tableconcat = table.concat;
local tostring = tostring;
local tableinsert = table.insert;

if not Spell.Druid then
    Spell.Druid = {};
end


--Spell
RubimRH.Spell[103] = {
    -- Racials
  Berserking                            = Spell(26297),
--   Shadowmeld                            = Spell(58984),
  Pool = Spell(58984),
  RakeOpenerDebuff = Spell(163505),
  -- Abilities
  Barkskin                              = Spell(22812),
  BearForm                              = Spell(5487),
  CatForm                               = Spell(768),
  FerociousBite                         = Spell(22568),
  MarkoftheWild                         = Spell(1126),
  Moonfire                              = Spell(8921),
  Prowl                                 = Spell(5215),
  Shred                                 = Spell(5221),
  -- Talents
  ConvoketheSpirits                     = Spell(391528),
  FrenziedRegeneration                  = Spell(22842),
  HeartoftheWild                        = Spell(319454),
  Innervate                             = Spell(29166),
  Ironfur                               = Spell(192081),
  Maim                                  = Spell(22570),
  MightyBash                            = Spell(5211),
  MoonkinForm                           = MultiSpell(24858,197625),
  Rake                                  = Spell(1822),
  Rip                                   = Spell(1079),
  SkullBash                             = Spell(106839),
  Starfire                              = Spell(194153),
  Starsurge                             = MultiSpell(78674,197626),
  Sunfire                               = Spell(93402),
  SurvivalInstincts                     = Spell(61336),
  Swipe                                 = MultiSpell(213764,213771),
  ThrashDebuff                          = MultiSpell(192090,106830), -- bear
  Thrash                                = MultiSpell(77758,106830), -- cat
  WildCharge                            = MultiSpell(16979,49376),
  -- Buffs
  FrenziedRegenerationBuff              = Spell(22842),
  HeartoftheWildBuff                    = Spell(319454),
  IronfurBuff                           = Spell(192081),
  MarkoftheWildBuff                     = Spell(1126),
  -- Debuffs
  MoonfireDebuff                        = Spell(164812),
  RakeDebuff                            = Spell(155722),
  RipDebuff                             = Spell(1079),
  SunfireDebuff                         = Spell(164815),
  -- Covenant Abilities
  AdaptiveSwarmCov                      = Spell(325727),
  AdaptiveSwarmCovDebuff                = Spell(325733),
  AdaptiveSwarmCovHeal                  = Spell(325748),
  AstralCommunion                       = Spell(202359),
  ConvoketheSpiritsCov                  = Spell(323764),
  EmpowerBond                           = Spell(326647),
  Fleshcraft                            = Spell(324631),
  KindredSpirits                        = Spell(326434),
  KindredEmpowermentEnergizeBuff        = Spell(327022),
  RavenousFrenzy                        = Spell(323546),
  RavenousFrenzyBuff                    = Spell(323546),
  RavenousFrenzySHBuff                  = Spell(355315),
  -- Soulbind Abilities
  ThrillSeeker                          = Spell(331586),
  ThrillSeekerBuff                      = Spell(331939),
  -- Conduit Effects
  DeepAllegiance                        = Spell(341378),
  PreciseAlignment                      = Spell(340706),
  PustuleEruption                       = Spell(351094),
  SavageCombatant                       = Spell(340609),
  SavageCombatantBuff                   = Spell(340613),
  SuddenAmbushBuff                      = Spell(340698),
  TasteForBlood                         = Spell(340682),
  VolatileSolvent                       = Spell(323074),
  -- Legendary Effects
  OathoftheElderDruidBuff               = Spell(338643),
  -- Trinket Effects (SL)
  AcquiredAxeBuff                       = Spell(368656),
  AcquiredSwordBuff                     = Spell(368657),
  AcquiredWandBuff                      = Spell(368654),
  ScarsofFraternalStrifeBuff4           = Spell(368638),
  TormentedInsightBuff                  = Spell(355321),
  -- Talents
  AdaptiveSwarm                         = Spell(391888),
  ApexPredatorsCraving                  = Spell(391881),
  Berserk                               = Spell(106951),
  Bloodtalons                           = Spell(319439),
  BrutalSlash                           = Spell(202028),
  FeralFrenzy                           = Spell(274837),
  Incarnation                           = Spell(102543),
  LunarInspiration                      = Spell(155580),

  LIMoonfire                            = Spell(155625), -- Lunar Inspiration Moonfire
  Predator                              = Spell(202021),
  PrimalWrath                           = Spell(285381),
  RipandTear                            = Spell(391347),
  Sabertooth                            = Spell(202031),
  SouloftheForest                       = Spell(158476),
  TearOpenWounds                        = Spell(391785),
  TigersFury                            = Spell(5217),
  -- Buffs
  ApexPredatorsCravingBuff              = Spell(391882),
  BloodtalonsBuff                       = Spell(145152),
  Clearcasting                          = Spell(135700),
  -- Debuffs
  AdaptiveSwarmDebuff                   = Spell(391889),
  AdaptiveSwarmHeal                     = Spell(391891),
  LIMoonfireDebuff                      = Spell(155625),


}

local S = RubimRH.Spell[103]

if not Item.Druid then Item.Druid = {}; end

Item.Druid.Feral = {

    lust = Item(164978), --drums of fury
    HPIcon = Item(169451),
    tx1 = Item(118330),
    tx2 = Item(114616),
};

local I = Item.Druid.Feral;


local function HealthPotionSelected()

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


        -- Rotation Variables
    local VarsInit = false
    local VarSwipeVShred
    local VarPWVFB
    local BossFightRemains = 11111
    local FightRemains = 11111
    

    -- Berserk/Incarnation Variables
    local BsInc = S.Incarnation:IsAvailable() and S.Incarnation or S.Berserk
    
    
    

    
    HL:RegisterForEvent(function()
      BsInc = S.Incarnation:IsAvailable() and S.Incarnation or S.Berserk
      VarInit = false
    end, "PLAYER_TALENT_UPDATE")
    
    HL:RegisterForEvent(function()
      BossFightRemains = 11111
      FightRemains = 11111
      VarInit = false
    end, "PLAYER_REGEN_ENABLED")
    
    HL:RegisterForEvent(function()
      S.AdaptiveSwarm:RegisterInFlight()
    end, "LEARNED_SPELL_IN_TAB")
    S.AdaptiveSwarm:RegisterInFlight()
    
 

    
    -- PMultiplier and Damage Registrations
    local function ComputeRakePMultiplier()
      return Player:IsStealthed() and 1.6 or 1
    end
    S.Rake:RegisterPMultiplier(S.RakeDebuff, ComputeRakePMultiplier)
    
    local function SwipeBleedMult()
      return (Target:Debuff(S.RipDebuff) or Target:Debuff(S.RakeDebuff) or Target:Debuff(S.ThrashDebuff)) and 1.2 or 1;
    end
    
    -- Functions for Bloodtalons
    local BtTriggers = {
      S.Rake,
      S.LIMoonfire,
      S.Thrash,
      S.BrutalSlash,
      S.Swipe,
      S.Shred,
      S.FeralFrenzy,
    }
    
    local function BTBuffUp(Trigger)
      if not S.Bloodtalons:IsAvailable() then return false end
      return Trigger:TimeSinceLastCast() < math.min(5, S.BloodtalonsBuff:TimeSinceLastAppliedOnPlayer())
    end
    
    local function BTBuffDown(Trigger)
      return not BTBuffUp(Trigger)
    end
    
    function CountActiveBtTriggers()
      local ActiveTriggers = 0
      for i = 1, #BtTriggers do
        if BTBuffUp(BtTriggers[i]) then ActiveTriggers = ActiveTriggers + 1 end
      end
      return ActiveTriggers
    end
    
    local function TicksGainedOnRefresh(Spell)
      local AddedDuration = 0
      local MaxDuration = 0
      -- Added TickTime variable, as Rake and Moonfire don't have tick times in DBC
      local TickTime = 0
      if Spell == S.RipDebuff then
        AddedDuration = (4 + Player:ComboPoints() * 4)
        MaxDuration = 31.2
        TickTime = Spell:TickTime()
      else
        AddedDuration = Spell:BaseDuration()
        MaxDuration = Spell:MaxDuration()
        TickTime = Spell:TickTime()
      end
    
      local OldTicks = Target:DebuffTicksRemain(Spell)
      local OldTime = Target:DebuffRemains(Spell)
      local NewTime = AddedDuration + OldTime
      if NewTime > MaxDuration then NewTime = MaxDuration end
      local NewTicks = NewTime / TickTime
      return NewTicks - OldTicks
    end
    

    
    local function InitVars()
      -- variable,name=swipe_v_shred,value=2
      VarSwipeVShred = 2
      -- variable,name=pw_v_fb,op=setif,value=0,condition=talent.tear_open_wounds.enabled&talent.rip_and_tear.enabled,value_else=4
      VarPWVFB = (S.TearOpenWounds:IsAvailable() and S.RipandTear:IsAvailable()) and 0 or 4
    
      VarsInit = true
    end
    
    -- APL Functions
    local function Precombat()
      -- flask
      -- food
      -- augmentation
      -- snapshot_stats
      -- Manually added: Group buff check
      if S.MarkoftheWild:IsReady() and (not Player:Buff(S.MarkoftheWildBuff)) then
        return S.MarkoftheWild:Cast()
      end
      -- cat_form
      if S.CatForm:IsReady() and not Player:Buff(S.CatForm) then
        return S.CatForm:Cast()
    end
      -- prowl
      if S.Prowl:IsReady() and not Player:Buff(S.Prowl)  then
        return S.Prowl:Cast()
    end
      -- Manually added: wild_charge
    --   if S.WildCharge:IsReady() and (not Target:IsInRange(8)) then
    --     return S.WildCharge:Cast()
    -- end
      -- Manually added: rake
      if S.Rake:IsReady() then
        return S.Rake:Cast()
    end
    end
    
    local function Clearcasting()
      -- thrash_cat,target_if=refreshable
      if S.Thrash:IsReady() and Target:DebuffRemains(S.ThrashDebuff)<15*0.3 then
        return S.Thrash:Cast()
    end
      -- swipe_cat,if=spell_targets.swipe_cat>variable.swipe_v_shred
      if S.Swipe:IsReady() and (Enemies12y > VarSwipeVShred) then
        return S.Swipe:Cast()
    end
      -- shred
      if S.Shred:IsReady() then
        return S.Shred:Cast()
    end
      -- brutal_slash
      if S.BrutalSlash:IsReady() then
        return S.BrutalSlash:Cast()
    end
    end
    
    local function BuilderCycle()
      -- run_action_list,name=clearcasting,if=buff.clearcasting.react
      if (Player:Buff(S.Clearcasting)) then
        local ShouldReturn = Clearcasting(); if ShouldReturn then return ShouldReturn; end
        return S.Pool:Cast()
    end

      -- rake,target_if=max:ticks_gained_on_refresh,if=refreshable|buff.sudden_ambush.up
      if S.Rake:IsReady() and Target:DebuffRemains(S.RakeDebuff)<3 or Player:Buff(S.SuddenAmbushBuff) then
        return S.Rake:Cast()
    end
      -- moonfire_cat,target_if=refreshable
      if S.LIMoonfire:IsReady() and Target:DebuffRemains(S.MoonfireDebuff)<3 then
        return S.LIMoonfire:Cast()
    end
      -- pool_resource,for_next=1
      -- thrash_cat,target_if=refreshable
      if S.Thrash:IsReady() and Target:DebuffRemains(S.ThrashDebuff)<3 then
        return S.Thrash:Cast()
    end
      -- brutal_slash
      if S.BrutalSlash:IsReady() then
        return S.BrutalSlash:Cast()
    end
      -- swipe_cat,if=spell_targets.swipe_cat>variable.swipe_v_shred
      if S.Swipe:IsReady() and (Enemies12y > VarSwipeVShred) then
        return S.Swipe:Cast()
    end
      -- shred
      if S.Shred:IsReady() then
        return S.Shred:Cast()
    end
    end
    
    local function BerserkBuilders()
      -- rake,target_if=refreshable
      if S.Rake:IsReady()  and Target:DebuffRemains(S.RakeDebuff)<3 and Player:ComboPoints()<5  then
        return S.Rake:Cast()
    end
      -- swipe_cat,if=spell_targets.swipe_cat>variable.swipe_v_shred
      if S.Swipe:IsReady() and (Enemies12y > VarSwipeVShred) then
        return S.Swipe:Cast()
    end
      -- shred
      if S.Shred:IsReady() then
        return S.Shred:Cast()
    end
    end
    
    local function Finisher()
      -- primal_wrath,if=spell_targets.primal_wrath>variable.pw_v_fb
      if S.PrimalWrath:IsReady() and (Enemies12y > VarPWVFB) then
        return S.PrimalWrath:Cast()
    end
      -- primal_wrath,target_if=refreshable,if=spell_targets.primal_wrath>1
      if S.PrimalWrath:IsReady() and Target:DebuffRemains(S.PrimalWrath)<3 and (Enemies12y > 1) then
        return S.PrimalWrath:Cast()
    end
      -- rip,target_if=refreshable
      if S.Rip:IsReady() and Target:DebuffRemains(S.Rip)<3 then
        return S.Rip:Cast()
    end
      -- pool_resource,for_next=1
      -- ferocious_bite,max_energy=1
      if S.FerociousBite:IsReady() then
        return S.FerociousBite:Cast()
    end
      -- ferocious_bite,if=(buff.bs_inc.up&talent.soul_of_the_forest.enabled)
      if S.FerociousBite:IsReady() and (Player:Buff(BsInc) and S.SouloftheForest:IsAvailable()) then
        return S.FerociousBite:Cast()
    end
    end
    
    local function Cooldown()
      -- berserk
      if S.Berserk:IsReady() then
        return S.Berserk:Cast()
    end
      -- incarnation
      if S.Incarnation:IsReady() then
        return S.Incarnation:Cast()
    end
      -- convoke_the_spirits,if=buff.tigers_fury.up&combo_points<3|fight_remains<5
      if S.ConvoketheSpirits:IsReady() and (Player:Buff(S.TigersFury) and Player:ComboPoints() < 3 or FightRemains < 5) then
        return S.ConvoketheSpirits:Cast()
    end
    --   if S.ConvoketheSpiritsCov:IsReady() and (Player:Buff(S.TigersFury) and Player:ComboPoints() < 3 or FightRemains < 5) then
    --     return S.ConvoketheSpiritsCov:Cast()
    -- end
      -- berserking
      if S.Berserking:IsReady() then
        return S.Berserking:Cast()
    end
      -- shadowmeld,if=buff.tigers_fury.up&buff.bs_inc.down&combo_points<4&buff.sudden_ambush.down&dot.rake.pmultiplier<1.6&energy>40&druid.rake.ticks_gained_on_refresh>spell_targets.swipe_cat*2-2&target.time_to_die>5
    --   if S.Shadowmeld:IsReady() and (Player:Buff(S.TigersFury) and not Player:Buff(BsInc) and Player:ComboPoints() < 4 and not Player:Buff(S.SuddenAmbushBuff) and Target:PMultiplier(S.Rake) < 1.6 and Player:Energy() > 40 and TicksGainedOnRefresh(S.RakeDebuff) > EnemiesCount11y * 2 - 2 and Target:TimeToDie() > 5) then
    --     return S.Shadowmeld:Cast()
    -- end


    end
    
    local function Owlweaving()
      if (Player:Buff(S.MoonkinForm)) then
        -- starsurge
        if S.Starsurge:IsReady() then
            return S.Starsurge:Cast()
        end
        -- sunfire,line_cd=4*gcd
        if S.Sunfire:IsReady() and (S.Sunfire:TimeSinceLastCast() > 4 * Player:GCD()) then
            return S.Sunfire:Cast()
        end
        -- moonfire,line_cd=4*gcd
        if S.Moonfire:IsReady() and (S.Moonfire:TimeSinceLastCast() > 4 * Player:GCD()) then
            return S.Moonfire:Cast()
        end
      end
      -- Manually added: moonkin_form,if=!buff.moonkin_form.up
      if S.MoonkinForm:IsReady() and (not Player:Buff(S.MoonkinForm)) then
        return S.MoonkinForm:Cast()
    end
    end
    
    local function Bloodtalons()
      -- rake,target_if=max:druid.rake.ticks_gained_on_refresh,if=(!ticking|(1.2*persistent_multiplier>=dot.rake.pmultiplier)|(active_bt_triggers=2&refreshable))&buff.bt_rake.down
      if S.Rake:IsReady() and (BTBuffDown(S.Rake)) and Player:ComboPoints()<5 then
        return S.Rake:Cast()
    end
      -- lunar_inspiration,if=refreshable&buff.bt_moonfire.down
      if S.LunarInspiration:IsAvailable() and S.LIMoonfire:IsReady() and (Target:DebuffRefreshable(S.LIMoonfireDebuff) and BTBuffDown(S.LIMoonfire)) then
        return S.LunarInspiration:Cast()
    end
      -- thrash_cat,target_if=refreshable&buff.bt_thrash.down
      if S.Thrash:IsReady() and (BTBuffDown(S.Thrash)) then
        return S.Thrash:Cast()
    end
      -- brutal_slash,if=buff.bt_brutal_slash.down
      if S.BrutalSlash:IsReady() and (BTBuffDown(S.BrutalSlash)) then
        return S.BrutalSlash:Cast()
    end
      -- swipe_cat,if=buff.bt_swipe.down
      if S.Swipe:IsReady() and (BTBuffDown(S.Swipe)) then
        return S.Swipe:Cast()
    end
      -- shred,if=buff.bt_shred.down
      if S.Shred:IsReady() and (BTBuffDown(S.Shred)) then
        return S.Shred:Cast()
    end
      -- swipe_cat,if=buff.bt_swipe.down
      if S.Swipe:IsReady() and (BTBuffDown(S.Swipe)) then
        return S.Swipe:Cast()
    end
      -- thrash_cat,if=buff.bt_thrash.down
      if S.Thrash:IsReady() and (BTBuffDown(S.Thrash)) then
        return S.Thrash:Cast()
    end
      -- rake,if=buff.bt_rake.down&combo_points>4
      if S.Rake:IsReady() and (BTBuffDown(S.Rake) and Player:ComboPoints() > 4) then
        return S.Rake:Cast()
    end
    end




local function APL()
    --------------------------------------------------------------------------------------------------------------------------------------------
    ----------------------------------------------------------Range-Checks/Variables------------------------------------------------------------
    --------------------------------------------------------------------------------------------------------------------------------------------
    HL.GetEnemies(5);
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


--rotation variables for multispells
    --executeit = (IsUsableSpell('Execute') and S.Execute:CooldownUp() and Target:IsInRange(8))
    --condemnit = (IsUsableSpell('Condemn') and S.Condemn:CooldownUp() and Target:IsInRange(8))

    --bloodthirstit = (IsUsableSpell('Bloodthirst') and S.Bloodthirst:CooldownUp() and Target:IsInRange(8))
    --bloodbathit = (IsUsableSpell('Bloodbath') and S.Bloodbath:CooldownUp() and Target:IsInRange(8))

    --ragingblowit = (IsUsableSpell('Raging Blow') and S.RagingBlow:CooldownUp() and Target:IsInRange(8))
    --crushingblowit = (IsUsableSpell('Crushing Blow') and S.CrushingBlow:CooldownUp() and Target:IsInRange(8))

    -- Enrage check
    --EnrageUp = Player:Buff(S.EnrageBuff)

    --------------------------------------------------------------------------------------------------------------------------------------------
    ----------------------------------------------------------Interrupts/Queues-----------------------------------------------------------------
    --------------------------------------------------------------------------------------------------------------------------------------------



    if not RubimRH.queuedSpell[1]:CooldownUp() or not Target:IsInRange(10) or not Player:AffectingCombat() then
        RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
    end

    if RubimRH.QueuedSpell():IsReadyQueue() then
        return RubimRH.QueuedSpell():Cast()
    end



    if Player:IsCasting() or Player:IsChanneling() then
        return 0, "Interface\\Addons\\Rubim-RH\\Media\\channel.tga"
    elseif Player:IsDeadOrGhost() or AuraUtil.FindAuraByName("Drink", "player") or
        AuraUtil.FindAuraByName("Food", "player") or AuraUtil.FindAuraByName("Food & Drink", "player") or AuraUtil.FindAuraByName("Shroud of Concealment", "player") then
        return 0, "Interface\\Addons\\Rubim-RH\\Media\\griph.tga"
    end


    --------------------------------------------------------------------------------------------------------------------------------------------
    ----------------------------------------------------------Defensives/Pots-------------------------------------------------------------------
    --------------------------------------------------------------------------------------------------------------------------------------------
    IsTanking = Player:IsTankingAoE(12) or Player:IsTanking(Target)

    if Player:HealthPercentage() <= 25 and Player:AffectingCombat() and IsUsableItem(191380) and
        GetItemCooldown(191380) == 0 and GetItemCount(191380) >= 1
        and (not Player:InArena() and not Player:InBattlegrounds()) then
        return I.HPIcon:Cast()
    end









    

    --------------------------------------------------------------------------------------------------------------------------------------------
    ----------------------------------------------------------PreCombat/OutofCombat-------------------------------------------------------------
    --------------------------------------------------------------------------------------------------------------------------------------------
        if not Player:AffectingCombat() and Enemies30y == 0  then

          

            if S.MarkoftheWild:IsReady() and not Player:BuffP(S.MarkoftheWildBuff) and RubimRH.InterruptsON() then
                return S.MarkoftheWild:Cast()
            end
            
            




        end


        
    --------------------------------------------------------------------------------------------------------------------------------------------
    ----------------------------------------------------------Opener----------------------------------------------------------------------------
    --------------------------------------------------------------------------------------------------------------------------------------------

        if HL.CombatTime() < 4 and Target:IsInRange(15) then
  













        end


    --------------------------------------------------------------------------------------------------------------------------------------------
    ---------------------------------------------------------------------CDsON------------------------------------------------------------------
    --------------------------------------------------------------------------------------------------------------------------------------------
    if Player:AffectingCombat() and RubimRH.CDsON()  and Player:CanAttack(Target) and not Target:IsDeadOrGhost() then

            if Target:IsInRange(10) then
                local ShouldReturn = UseItems();
                if ShouldReturn then return ShouldReturn; end
            end




    end

    --------------------------------------------------------------------------------------------------------------------------------------------
    ----------------------------------------------------------StartRotation---------------------------------------------------------------------
    --------------------------------------------------------------------------------------------------------------------------------------------

    if Target:Exists() and Player:CanAttack(Target) and not Target:IsDeadOrGhost() then

        if not IsCurrentSpell(6603) and Player:CanAttack(Target)
        and Target:AffectingCombat() and Target:IsInRange(10) then
        return S.autoattack:Cast()
        end

        if select(8, UnitCastingInfo("target")) == false and Target:CastPercentage() > math.random(43, 87) and
        RubimRH.InterruptsON() and S.SkullBash:IsReadyQueue(8) and Player:AffectingCombat() then
        return S.SkullBash:Cast()
        end

        if S.CatForm:IsReady() and not Player:BuffP(S.CatForm) then
            return S.CatForm:Cast()
        end


    



    --------------------------------------------------------------------------------------------------------------------------------------------
    ----------------------------------------------------------Single Target---------------------------------------------------------------------
    --------------------------------------------------------------------------------------------------------------------------------------------
-- Initialize variables, if not yet done
if not VarsInit then InitVars() end
-- Precombat
if not Player:AffectingCombat() then
  local ShouldReturn = Precombat(); if ShouldReturn then return ShouldReturn; end
end
-- Interrupts
-- prowl
if S.Prowl:IsReady() then
    return S.Prowl:Cast()
end
-- tigers_fury,if=energy.deficit>40|buff.bs_inc.up
if S.TigersFury:IsReady() and RubimRH.CDsON() and (Player:EnergyDeficit() > 40 or Player:Buff(BsInc)) then
    return S.TigersFury:Cast()
end
-- cat_form,if=!buff.cat_form.up&energy>50
if S.CatForm:IsReady() and (Player:Energy() > 50) and not Player:Buff(S.CatForm) then
    return S.CatForm:Cast()
end
-- auto_attack,if=!buff.prowl.up&!buff.shadowmeld.up
-- call_action_list,name=cooldown
if RubimRH.CDsON() then
  local ShouldReturn = Cooldown(); if ShouldReturn then return ShouldReturn; end
end
-- adaptive_swarm,target_if=((!dot.adaptive_swarm_damage.ticking|dot.adaptive_swarm_damage.remains<2)&(dot.adaptive_swarm_damage.stack<3|!dot.adaptive_swarm_heal.stack>1)&!action.adaptive_swarm_heal.in_flight&!action.adaptive_swarm_damage.in_flight&!action.adaptive_swarm.in_flight)&target.time_to_die>5|active_enemies>2&!dot.adaptive_swarm_damage.ticking&energy<35&target.time_to_die>5
if S.AdaptiveSwarm:IsReady() then
    return S.AdaptiveSwarm:Cast()
end
-- ferocious_bite,if=buff.apex_predators_craving.up
if S.FerociousBite:IsReady() and (Player:Buff(S.ApexPredatorsCravingBuff)) then
return S.FerociousBite:Cast()
end
-- feral_frenzy,if=combo_points<2
if S.FeralFrenzy:IsReady() and (Player:ComboPoints() < 2) then
    return S.FeralFrenzy:Cast()
end
-- call_action_list,name=finisher,if=combo_points=5
if (Player:ComboPoints() == 5) then
  local ShouldReturn = Finisher(); if ShouldReturn then return ShouldReturn; end
end
-- call_action_list,name=bloodtalons,if=buff.bloodtalons.down
if (not Player:Buff(S.BloodtalonsBuff)) then
  local ShouldReturn = Bloodtalons(); if ShouldReturn then return ShouldReturn; end
end
-- call_action_list,name=berserk_builders,if=combo_points<5&(buff.bs_inc.up|buff.shadowmeld.up|buff.prowl.up)
if (Player:ComboPoints() < 5 and (Player:Buff(BsInc) or Player:IsStealthed())) then
  local ShouldReturn = BerserkBuilders(); if ShouldReturn then return ShouldReturn; end
end
-- call_action_list,name=builder_cycle,if=combo_points<5
if (Player:ComboPoints() < 5) then
  local ShouldReturn = BuilderCycle(); if ShouldReturn then return ShouldReturn; end
end
-- call_action_list,name=owlweaving,if=buff.bs_inc.down&energy<80
if (Player:Buff(BsInc) and Player:Energy() < 80) then
  local ShouldReturn = Owlweaving(); if ShouldReturn then return ShouldReturn; end
end


        

        if Player:AffectingCombat() then
            return 0, 135328
        end
         
    
    end

        

        return 0, "Interface\\Addons\\Rubim-RH\\Media\\griph.tga"
    end

RubimRH.Rotation.SetAPL(103, APL);

local function PASSIVE()

end

RubimRH.Rotation.SetPASSIVE(103, PASSIVE);