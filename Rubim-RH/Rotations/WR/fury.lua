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

if not Spell.Warrior then
    Spell.Warrior = {};
end



RubimRH.Spell[72] = {
BerserkerStance = Spell(386196),
  autoattack = Spell(274738), --ancestral call

  EnragedReneration = Spell(184364),
  lust1 = Spell(57724),
  lust2 = Spell(57723),
  lust3 = Spell(80354),
  lust4 = Spell(95809),
  lust5 = Spell(264689),
    lustAT = Spell(265221), -- fireblood
  execute = Spell(135358),
    -- AncestralCall                         = Spell(274738),
    ArcaneTorrent                         = Spell(50613),
    BagofTricks                           = Spell(312411),
    Berserking                            = Spell(26297),
    BloodFury                             = Spell(20572),
    -- Abilities
    BattleShout                           = Spell(6673),
    Charge                                = Spell(100),
    HeroicThrow                           = Spell(57755),
    Pummel                                = Spell(6552),
    Slam                                  = Spell(1464),
    odynsfury                             = Spell(28880),--Gift of Naru
    VictoryRush                           = Spell(34428),
    -- Talents
    Avatar                                = Spell(107574),
    BerserkerRage                         = Spell(18499),
    BloodandThunder                       = Spell(384277),
    DoubleTime                            = Spell(103827),
    FrothingBerserker                     = Spell(215571),
    IntimidatingShout                     = Spell(5246),
    HeroicLeap                            = Spell(6544),
    ImpendingVictory                      = Spell(202168),
    OverwhelmingRage                      = Spell(382767),
    RallyingCry                           = Spell(97462),
    Shockwave                             = Spell(46968),
    SonicBoom                             = Spell(390725),
    SpearofBastion                        = Spell(376079),
    StormBolt                             = Spell(107570),
    ThunderousRoar                        = Spell(384318),
    TitanicThrow                          = Spell(384090),
    TitansTorment                         = Spell(390135),
    WreckingThrow                         = Spell(384110),
    -- Buffs
    AvatarBuff                            = Spell(107574),
    BattleShoutBuff                       = Spell(6673),
    -- Debuffs
    SpearofBastionDebuff                  = Spell(376080),
    -- Covenant Abilities (Shadowlands)
    AncientAftershock                     = Spell(325886),
    Condemn                               = MultiSpell(330325, 330334, 317485, 317349),
    CondemnDebuff                         = Spell(317491),
    ConquerorsBanner                      = Spell(324143),
    ConquerorsFrenzyBuff                  = Spell(343672),
    ElysianMightBuff                      = Spell(311193),
    Fleshcraft                            = Spell(324631),

    -- Conduits (Shadowlands)
    AshenJuggernaut                       = Spell(335232),
    AshenJuggernautBuff                   = Spell(335234),
    MercilessBonegrinder                  = Spell(335260),
    MercilessBonegrinderBuff              = Spell(346574),
    -- Pool
    Pool                                  = Spell(999910),



 -- Abilities
 Bloodbath                             = Spell(335096),
 CrushingBlow                          = Spell(335097),
 Execute                               = Spell(280735),
 Whirlwind                             = Spell(190411),
 -- Talents
 Annihilator                           = Spell(383916),
 Bloodthirst                           = Spell(23881),
 Cruelty                               = Spell(392931),
 Frenzy                                = Spell(335077),
 Massacre                              = Spell(206315),
 MeatCleaver                           = Spell(280392),
 OdynsFury                             = Spell(385059),
 Onslaught                             = Spell(315720),
 RagingBlow                            = Spell(85288),
 Rampage                               = Spell(184367),
 Ravager                               = Spell(228920),
 RecklessAbandon                       = Spell(202751),
 Recklessness                          = Spell(1719),
 StormofSwords                         = Spell(388903),
 SuddenDeath                           = Spell(280721),
 Tenderize                             = Spell(388933),
 WrathandFury                          = Spell(392936),
 -- Buffs
 EnrageBuff                            = Spell(184362),
 FrenzyBuff                            = Spell(335082),
 MeatCleaverBuff                       = Spell(85739),
 RecklessnessBuff                      = Spell(1719),
 SuddenDeathBuff                       = Spell(280776),
 LightsJudgment = Spell(255647),
 -- Debuffs
 SiegebreakerDebuff                    = Spell(280773),
 -- Conduits (Shadowlands)
 ViciousContempt                       = Spell(337302),
 -- Legendary Effects (Shadowlands)
 WilloftheBerserkerBuff                = Spell(335594),




}

local S = RubimRH.Spell[72]

if not Item.Warrior then Item.Warrior = {}; end

Item.Warrior.Fury = {

    lust = Item(164978), --drums of fury
    HPIcon = Item(169451),
    tx1 = Item(118330),
    tx2 = Item(114616),
};

local I = Item.Warrior.Fury;


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
    executeit = (IsUsableSpell('Execute') and S.Execute:CooldownUp() and Target:IsInRange(8))
    condemnit = (IsUsableSpell('Condemn') and S.Condemn:CooldownUp() and Target:IsInRange(8))

    bloodthirstit = (IsUsableSpell('Bloodthirst') and S.Bloodthirst:CooldownUp() and Target:IsInRange(8))
    bloodbathit = (IsUsableSpell('Bloodbath') and S.Bloodbath:CooldownUp() and Target:IsInRange(8))

    ragingblowit = (IsUsableSpell('Raging Blow') and S.RagingBlow:CooldownUp() and Target:IsInRange(8))
    crushingblowit = (IsUsableSpell('Crushing Blow') and S.CrushingBlow:CooldownUp() and Target:IsInRange(8))

    -- Enrage check
    EnrageUp = Player:Buff(S.EnrageBuff)

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


    if (Cache.EnemiesCount[30] or Target:IsInRange(15)) and Player:AffectingCombat() then

        if S.RallyingCry:IsCastable() and (not Player:Buff(S.EnragedReneration) or Player:Buff(S.EnragedReneration) and Player:HealthPercentage()<25) and Player:HealthPercentage()<50 then
            return S.RallyingCry:Cast()
        end

        if S.EnragedReneration:IsCastable() and (not Player:Buff(S.RallyingCry) or Player:Buff(S.RallyingCry) and Player:HealthPercentage()<25) and Player:HealthPercentage()<50 then
            return S.EnragedReneration:Cast()
        end
      
        -- if S.BerserkerRage:IsCastable() and Player:IsFeared() then
        --     return S.BerserkerRage:Cast()
        -- end


        if Player:HealthPercentage() < 50 and RubimRH.InterruptsON() then
            if S.VictoryRush:IsReady(8) then
                return S.VictoryRush:Cast()
            end
            if S.ImpendingVictory:IsReady(8) then
                return S.ImpendingVictory:Cast()
            end

          end










    end
    

    --------------------------------------------------------------------------------------------------------------------------------------------
    ----------------------------------------------------------PreCombat/OutofCombat-------------------------------------------------------------
    --------------------------------------------------------------------------------------------------------------------------------------------
        if not Player:AffectingCombat() and Enemies30y == 0  then

          

            if S.BattleShout:IsCastable() and not Player:BuffP(S.BattleShoutBuff) and RubimRH.InterruptsON() then
                return S.BattleShout:Cast()
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

      -- arcane_torrent,if=rage<40&!buff.recklessness.up
      if S.ArcaneTorrent:IsCastable() and (Player:Rage() < 40 and not Player:Buff(S.RecklessnessBuff)) then
        return S.ArcaneTorrent:Cast() 
      end   

    --    lights_judgment,if=buff.recklessness.down&debuff.siegebreaker.down
       if S.LightsJudgment:IsCastable() and (not Player:Buff(S.RecklessnessBuff) and not Target:Debuff(S.SiegebreakerDebuff)) then
        return S.LightsJudgment:Cast() 
    end  
    --    bag_of_tricks,if=buff.recklessness.down&debuff.siegebreaker.down&buff.enrage.up
       if S.BagofTricks:IsCastable() and (not Player:Buff(S.RecklessnessBuff) and not Target:Debuff(S.SiegebreakerDebuff) and EnrageUp) then
        return S.BagofTricks:Cast() 
    end  
      -- berserking,if=buff.recklessness.up
      if S.Berserking:IsCastable() and (Player:Buff(S.RecklessnessBuff)) and Target:IsInRange(8)  then
        return S.Berserking:Cast() 
    end  
      -- blood_fury
      if S.BloodFury:IsCastable() and Target:IsInRange(8)  then
        return S.BloodFury:Cast() 
    end  
      -- fireblood
    --   if S.Fireblood:IsCastable() then
    --     return S.Fireblood:Cast() 
    -- end 
    --   -- ancestral_call
    --   if S.AncestralCall:IsCastable() and Target:IsInRange(8)  then
    --     return S.AncestralCall:Cast() 
    --   end
    -- avatar,if=talent.titans_torment&buff.enrage.up&(buff.elysian_might.up|!runeforge.elysian_might|!covenant.kyrian)
    if S.Avatar:IsCastable() and EnrageUp and Target:IsInRange(8) and (S.TitansTorment:IsAvailable() and EnrageUp and (Player:Buff(S.ElysianMightBuff) or (not ElysianMightEquipped) or CovenantID ~= 1)) then
        return S.Avatar:Cast() 
      end
    -- avatar,if=!talent.titans_torment&(buff.recklessness.up|target.time_to_die<20)
    if S.Avatar:IsCastable() and EnrageUp and Target:IsInRange(8) and ((not S.TitansTorment:IsAvailable()) and (Player:Buff(S.RecklessnessBuff) or Target:TimeToDie() < 20)) then
        return S.Avatar:Cast() 
      end
    -- recklessness,if=talent.annihilator&cooldown.avatar.remains<1|cooldown.avatar.remains>40|!talent.avatar|target.time_to_die<20
    if S.Recklessness:IsCastable() and EnrageUp and Target:IsInRange(8) and Target:IsInRange(8)  and (S.Annihilator:IsAvailable() and S.Avatar:CooldownRemains() < 1 or S.Avatar:CooldownRemains() > 40 or (not S.Avatar:IsAvailable()) or Target:TimeToDie() < 20) then
        return S.Recklessness:Cast() 
      end
    -- recklessness,if=!talent.annihilator
    if S.Recklessness:IsCastable() and EnrageUp and (not S.Annihilator:IsAvailable()) and Target:IsInRange(8)then
        return S.Recklessness:Cast() 
      end

    -- spear_of_bastion,if=buff.enrage.up&(buff.recklessness.up|buff.avatar.up|target.time_to_die<20)
    if S.SpearofBastion:IsCastable() and Target:IsInRange(8) and (EnrageUp and (Player:Buff(S.RecklessnessBuff) or Player:Buff(S.AvatarBuff) or Target:TimeToDie() < 20)) then
        return S.SpearofBastion:Cast() 
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
        RubimRH.InterruptsON() and S.Pummel:IsReadyQueue(8) and Player:AffectingCombat() then
        return S.Pummel:Cast()
        end

        if S.BerserkerStance:IsCastable() and not Player:BuffP(S.BerserkerStance) then
            return S.BerserkerStance:Cast()
        end  



    --------------------------------------------------------------------------------------------------------------------------------------------
    ----------------------------------------------------------AOE-------------------------------------------------------------------------------
    --------------------------------------------------------------------------------------------------------------------------------------------

  -- whirlwind,if=spell_targets.whirlwind>1&!buff.meat_cleaver.up|raid_event.adds.in<2&!buff.meat_cleaver.up
  if S.Whirlwind:IsCastable() and RubimRH.AoEON() and (Enemies10y > 1 and Target:IsInRange(8) and (S.MeatCleaver:IsAvailable() and not Player:Buff(S.MeatCleaverBuff))) then
    return S.Whirlwind:Cast() 
  end







    --------------------------------------------------------------------------------------------------------------------------------------------
    ----------------------------------------------------------Single Target---------------------------------------------------------------------
    --------------------------------------------------------------------------------------------------------------------------------------------

    if S.Ravager:IsCastable() and EnrageUp and Target:IsInRange(5) and RubimRH.CDsON() then
        return S.Ravager:Cast() 
    end

 -- Execute,if=buff.ashen_juggernaut.up&buff.ashen_juggernaut.remains<gcd
 if executeit and (Player:Buff(S.AshenJuggernautBuff) and Player:BuffRemains(S.AshenJuggernautBuff) < Player:GCD())  then
    return S.Execute:Cast()
 end
  -- thunderous_roar,if=buff.enrage.up&(spell_targets.whirlwind>1|raid_event.adds.in>15)
  if S.ThunderousRoar:IsCastable() and Target:IsInRange(8) and RubimRH.CDsON() and (EnrageUp) then
    return S.ThunderousRoar:Cast()
 end
  -- crushing_blow,if=talent.wrath_and_fury
  if crushingblowit and S.WrathandFury:IsAvailable() then
    return S.CrushingBlow:Cast()
 end

  -- Execute,if=buff.enrage.up
  if executeit and EnrageUp then
    return S.Execute:Cast()
 end
  -- odyns_fury,if=!talent.annihilator&buff.enrage.up&(spell_targets.whirlwind>1|raid_event.adds.in>15)
  if S.OdynsFury:IsCastable() and Target:IsInRange(8) and ((not S.Annihilator:IsAvailable()) and EnrageUp) then
    return S.OdynsFury:Cast()
 end
  -- rampage,if=buff.recklessness.up|buff.enrage.remains<gcd|(rage>110&talent.overwhelming_rage)|(rage>80&!talent.overwhelming_rage)|buff.frenzy.remains<gcd
  if S.Rampage:IsReady(8) and (Player:Buff(S.RecklessnessBuff) or Player:BuffRemains(S.EnrageBuff) < Player:GCD() or (Player:Rage() > 110 and S.OverwhelmingRage:IsAvailable()) or (Player:Rage() > 80 and not S.OverwhelmingRage:IsAvailable()) or Player:BuffRemains(S.FrenzyBuff) < Player:GCD()) then
    return S.Rampage:Cast()
 end
  -- Execute
  if executeit then
    return S.Execute:Cast()
 end
  -- bloodthirst,if=buff.enrage.down|(talent.annihilator&!buff.recklessness.up)
  if  S.Bloodthirst:IsReady(8) and (not EnrageUp or (S.Annihilator:IsAvailable() and not Player:Buff(S.RecklessnessBuff))) then
    return S.Bloodthirst:Cast()
 end

  -- odyns_fury,if=talent.annihilator&buff.enrage.up&(spell_targets.whirlwind>1|raid_event.adds.in>15)
  if S.OdynsFury:IsCastable() and Target:IsInRange(8) and (S.Annihilator:IsAvailable() and EnrageUp) then
    return S.OdynsFury:Cast()
end
  -- onslaught,if=!talent.annihilator&buff.enrage.up|talent.tenderize
  if S.Onslaught:IsReady() and Target:IsInRange(8) and ((not S.Annihilator:IsAvailable()) and EnrageUp or S.Tenderize:IsAvailable()) then
    return S.Onslaught:Cast()
 end
  -- raging_blow,if=charges>1&talent.wrath_and_fury
  if S.RagingBlow:IsReady(8) and (S.RagingBlow:Charges() > 1 and S.WrathandFury:IsAvailable()) then
    return S.RagingBlow:Cast()
 end
  -- bloodbath,if=buff.enrage.down|!talent.wrath_and_fury
  if bloodbathit and (not EnrageUp or not S.WrathandFury:IsAvailable()) then
    return S.Bloodbath:Cast()
 end

  -- bloodthirst,if=!talent.wrath_and_fury
  if S.Bloodthirst:IsReady(8) and not S.WrathandFury:IsAvailable() then
    return S.Bloodthirst:Cast()
 end
  -- raging_blow,if=charges>1
  if S.RagingBlow:IsReady(8) and S.RagingBlow:Charges() > 1 then
    return S.RagingBlow:Cast()
 end
  -- rampage
  if S.Rampage:IsReady(8) then
    return S.Rampage:Cast()
 end
  -- slam,if=talent.storm_of_swords
  if S.Slam:IsReady(8) and (S.StormofSwords:IsAvailable()) then
    return S.Slam:Cast()
 end
  -- bloodbath
  if bloodbathit then
    return S.Bloodbath:Cast()
 end

  -- crushing_blow/raging blow
  if S.RagingBlow:IsReady(8) then
    return S.RagingBlow:Cast()
 end

  -- crushing_blow/raging blow
  if crushingblowit then
    return S.CrushingBlow:Cast()
 end


  -- whirlwind
  if S.Whirlwind:IsCastable() and Target:IsInRange(8) then
    return S.Whirlwind:Cast()
 end

  -- wrecking_throw
  if S.WreckingThrow:IsCastable() and Target:IsInRange(30) then
    return S.WreckingThrow:Cast()
 end


        

        if Player:AffectingCombat() then
            return 0, 135328
        end
         
    


        end

        return 0, "Interface\\Addons\\Rubim-RH\\Media\\griph.tga"
    end

RubimRH.Rotation.SetAPL(72, APL);

local function PASSIVE()

end

RubimRH.Rotation.SetPASSIVE(72, PASSIVE);
