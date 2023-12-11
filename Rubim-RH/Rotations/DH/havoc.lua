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

if not Spell.DemonHunter then
    Spell.DemonHunter = {};
end


RubimRH.Spell[577] = {
 -- Abilities
 Annihilation                          = Spell(201427),
 BladeDance                            = Spell(188499),
 Blur                                  = Spell(198589),
 ChaosStrike                           = Spell(162794),
 DeathSweep                            = Spell(210152),
 DemonsBite                            = Spell(162243),
 FelRush                               = Spell(195072),
 Metamorphosis                         = Spell(191427),
 autoattack             = Spell(135201), -- shadow meld call
 ThrowGlaive                           = Spell(185123),
 -- Talents
 AFireInside                           = Spell(427775),
 AnyMeansNecessary                     = Spell(388114),
 BlindFury                             = Spell(203550),
 BurningWound                          = Spell(391189),
 ChaosTheory                           = Spell(389687),
 ChaoticTransformation                 = Spell(388112),
 CycleofHatred                         = Spell(258887),
 DemonBlades                           = Spell(203555),
 EssenceBreak                          = Spell(258860),
 EyeBeam                               = Spell(198013),
 FelBarrage                            = Spell(258925),
 FelEruption                           = Spell(211881),
 FirstBlood                            = Spell(206416),
 FuriousGaze                           = Spell(343311),
 FuriousThrows                         = Spell(393029),
 GlaiveTempest                         = Spell(342817),
 Inertia                               = Spell(427640),
 Initiative                            = Spell(388108),
 InnerDemon                            = Spell(389693),
 IsolatedPrey                          = Spell(388113),
 Momentum                              = Spell(206476),
 Ragefire                              = Spell(388107),
 RestlessHunter                        = Spell(390142),
 SerratedGlaive                        = Spell(390154),
 ShatteredDestiny                      = Spell(388116),
 Soulrend                              = Spell(388106),
 Soulscar                              = Spell(388106),
 TacticalRetreat                       = Spell(389688),
 TrailofRuin                           = Spell(258881),
 UnboundChaos                          = Spell(347461),
 VengefulRetreat                       = Spell(198793),
 -- Buffs
 ChaosTheoryBuff                       = Spell(390195),
 FuriousGazeBuff                       = Spell(343312),
 InertiaBuff                           = Spell(427641),
 InitiativeBuff                        = Spell(391215),
 InnerDemonBuff                        = Spell(390145),
 MetamorphosisBuff                     = Spell(162264),
 MomentumBuff                          = Spell(208628),
 TacticalRetreatBuff                   = Spell(389890),
 UnboundChaosBuff                      = Spell(347462),
 -- Debuffs
 BurningWoundDebuff                    = Spell(391191),
 EssenceBreakDebuff                    = Spell(320338),
 SerratedGlaiveDebuff                  = Spell(390155),

    Glide                                 = Spell(131347),
    ImmolationAura                        = Spell(258920),
    ImmolationAuraBuff                    = Spell(258920),
    -- Talents
    ChaosNova                             = Spell(179057),
    CollectiveAnguish                     = Spell(390152),
    Demonic                               = Spell(213410),
    ElysianDecree                         = Spell(390163),
    Felblade                              = Spell(232893),
    FirstoftheIllidari                    = Spell(235893),
    FoddertotheFlame                      = Spell(391429),
    SigilofFlame                          = MultiSpell(204596, 389810), -- 204596: Base ID, 389810: Precise
    SigilofMisery                         = MultiSpell(207684, 389813), -- 207684: Base ID, 389813: Precise
    SoulSigils                            = Spell(395446),
    TheHunt                               = Spell(370965),
    -- Utility
    Disrupt                               = Spell(183752),
    -- Buffs
    -- Debuffs
    SigilofFlameDebuff                    = Spell(204598),
    SigilofMiseryDebuff                   = Spell(207685),
    -- Other
    Pool                                  = Spell(999910),

	lust1 = Spell(57724),
	lust2 = Spell(57723),
	lust3 = Spell(80354),
	lust4 = Spell(95809),
	lust5 = Spell(264689),
	ArcaneTorrent = Spell(155145),
    lustAT = Spell(188501), -- spectral site
	trink = Spell(274738),
}

local S = RubimRH.Spell[577] 

if not Item.DemonHunter then Item.DemonHunter = {}; end

Item.DemonHunter.Havoc = {

};

local I = Item.DemonHunter.Havoc;


S.Annihilation.TextureSpellID = { 204317 }
S.DeathSweep.TextureSpellID = { 199552 }
S.Metamorphosis.TextureSpellID = { 187827 }



local function num(val)
    if val then
        return 1
    else
        return 0
    end
end


local function RangeCount(spellName)
    local range_counter = 0

    if spellName then
        for i = 1, 40 do
            local unitID = "nameplate" .. i
            if UnitExists(unitID) then           
                local nameplate_guid = UnitGUID(unitID) 
                local npc_id = select(6, strsplit("-", nameplate_guid))
                if npc_id ~= '120651' and npc_id ~= '161895' then
                    if UnitCanAttack("player", unitID) and IsSpellInRange(spellName, unitID) == 1 and UnitHealthMax(unitID) > 5 then
                        range_counter = range_counter + 1
                    end                    
                end
            end
        end
    end

    return range_counter
end

local function TargetInRange(spellName)
    if spellName and IsSpellInRange(spellName, "target") == 1 then
        return true
    else
        return false    
    end
end

local function target_is_dummy()
    local x = UnitName("target")
    local targetisdummy = false

    if x then
        name = x:sub(-5)
    end

    if Target:Exists() then
        if name == 'Dummy' or name == 'elist' then
            targetisdummy = true
        end
    else
        targetisdummy = false
    end

    return targetisdummy
end

local function AreaTTD()
    local currHealth = {}
    local currHealthMax = {}
    local areaTTD = {}
    
        for id = 1, 40 do
            local unitID = "nameplate" .. id
            if UnitCanAttack("player", unitID) and UnitAffectingCombat(unitID) 
            and ((UnitHealth(unitID) / UnitHealthMax(unitID)) * 100) < 100 then
                table.insert(currHealth, UnitHealth(unitID))
                table.insert(currHealthMax, UnitHealthMax(unitID))
                if #currHealthMax >= 1 then
                    for id = 1, #currHealthMax do
                        dps = (currHealthMax[#currHealth] - currHealth[#currHealth]) / HL.CombatTime("nameplate" .. #currHealthMax)
                        areaTTD[#currHealthMax] = currHealth[#currHealth] / dps
                    end
                end
            end
        end
        
        local count = 1
        local highest = 0
    
        for count = 1, #currHealthMax do
            if areaTTD[count] > highest then 
                highest = areaTTD[count]
            end
            count = count + 1
        end
        
        if highest ~= 0 then
            return highest
        else
            return 9999
        end
    
    end
    
    local function TargetTTD()
        local currHealth = {}
        local currHealthMax = {}
        local allGUID = {}
        local areaTTD = {}
        local areaTTD_Predicted = {}
        local areaDPS = {}
        local count = 1
        local highest = 0
    
        for id = 1, 40 do
            local unitID = "nameplate" .. id
            if UnitCanAttack("player", unitID)
                and ((UnitHealth(unitID) / UnitHealthMax(unitID)) * 100) < 100 then
                if UnitGUID('Target') then
                    currTarget = UnitGUID('Target')
                end
    
                table.insert(allGUID, UnitGUID(unitID))
                table.insert(currHealth, UnitHealth(unitID))
                table.insert(currHealthMax, UnitHealthMax(unitID))
    
                if #allGUID >= 1 and UnitGUID('Target') then
                    while (UnitGUID('Target') ~= allGUID[count]) do
                        count = count + 1
                        break
                    end
                end
    
                if #currHealthMax >= 1 then
                    for id = 1, #currHealthMax do
                        dps = (currHealthMax[#currHealth] - currHealth[#currHealth]) /
                            HL.CombatTime("nameplate" .. #currHealthMax)
                        if #currHealthMax ~= count then
                            areaTTD[#currHealthMax] = currHealth[#currHealth] / dps
                            --areaTTD_Predicted[#currHealthMax] = currHealth[#currHealth] / (dps + playerDPS)
                        else
                            areaTTD_Predicted[#currHealthMax] = currHealth[#currHealth] / dps
                        end
                    end
                end
            end
        end
        if target_is_dummy() then
            return 8675309
        elseif #currHealthMax >= 1 and areaTTD_Predicted[count] then
            return areaTTD_Predicted[count]
        else
            return 1
        end
    end

local function kickprio()
    -- list of m+ abilities that should be kicked
    local KickSpells = {
        'Scar Soul', 'Spirited Defense', 'Spellbind', 'Soul Bolt','Soul Volley','Drain Essence','Infected Thorn','Ruinous Bolt','Bramble Bolt', -- Waycrest M
        "Bwonsamdi's Mantle", 'Mending Word','Fiery Enchant','Wildfire','Unstable Hex','Noxious Stench','Dino Might','Terrifying Screech','Noxious Stench',   -- AD
        'Soul Blast','Spirit Blast','Arcane Blitz','Fel Frenzy', --BRH
        'Healing Wave','Wrath','Hex','Water Bolt','Frostbolt','Mind Flay','Aquablast', --TotT
        'Unnerving Screech','Curse of Isolation','Tormenting Eye',--DHT
        'Choking Vines','Enraged Growth','Healing Waters','Toxic Bloom','Revitalize','Pyroblast','Arcane Blast','Frostbolt',--Everbloom
        'Chronomelt','Infinite Bolt','Enervate','Infinite Bolt Volley','Stonebolt','Pulverizing Creations','Binding Grasp','Epoch Bolt','Displace Chronosequence',
        'Dizzying Sands','Time Beam','Rocket Bolt Volley',--DotI

    }
    local currentspellchannel = select(1,UnitChannelInfo('target'))
    local currentspellcast = select(1, UnitCastingInfo('target'))
    
    for i = 1, #KickSpells do
    if currentspellcast == KickSpells[i] or currentspellchannel == KickSpells[i] then
    return true
    end
    end
    
    return false
    end

    local function UseItems()
        local trinket1 = GetInventoryItemID("player", 13)
        local trinket2 = GetInventoryItemID("player", 14)
        local trinket1ready = IsUsableItem(trinket1) and GetItemCooldown(trinket1) == 0 and IsEquippedItem(trinket1)
        local trinket2ready = IsUsableItem(trinket2) and GetItemCooldown(trinket2) == 0 and IsEquippedItem(trinket2)
    
        if trinket1ready 
        and ((Player:MovingFor() < 0.2 and not Player:IsMoving()) and trinket1 == 203963 or trinket1 ~= 203963) and trinket1 ~= 203729
         then
            return I.tx1:Cast()
        end
        if trinket2ready 
        and ((Player:MovingFor() < 0.2 and not Player:IsMoving()) and trinket2 == 203963 or trinket2 ~= 203963) and trinket2 ~= 203729
         then
            return I.tx2:Cast()
        end
        
        return nil
    end

    local function tierequipped()
        local items = {
            "Screaming Torchfiend's Burning Scowl",-- (Helm - Tindral Sageswift)
           "Screaming Torchfiend's Horned Memento",-- (Shoulders - Smolderon)
           "Screaming Torchfiend's Binding", -- (Chest - Nymue)
           "Screaming Torchfiend's Grasp",--  (Gloves - Igira the Cruel)
           "Screaming Torchfiend's Blazewraps", -- (Legs - Larodar, Keeper of the Flame)
        }
    
        local count = 0
    
        for _, itemName in ipairs(items) do
            if IsEquippedItem(itemName) then
                count = count + 1
            end
        end
    
        return count
    end


--     local Var3MinTrinket = false
-- local VarBladeDance = false
-- local VarPoolingForBladeDance = false
-- local VarPoolingForEyeBeam = false
-- local VarWaitingForEssenceBreak = false
-- local VarWaitingForMomentum = false
-- local VarHoldingMeta = false
local VarImmoMaxStacks = (S.AFireInside:IsAvailable()) and 5 or 1
-- -- local GCDMax = Player:GCD() + 0.25
-- local CombatTime = 0
-- local VarTrinketSyncSlot = 0
-- local VarUseEyeBeamFuryCondition = false
-- local BossFightRemains = 11111
-- local FightRemains = 11111

    local function MetaEnd()
        if not Player:Buff(S.FelBarrage) then
          -- death_sweep,if=buff.fel_barrage.down
          if S.DeathSweep:IsReady() and not targetRange5 then
            return S.DeathSweep:Cast()
          end
          -- annihilation,if=buff.fel_barrage.down
          if S.Annihilation:IsReady() and not targetRange5 then
            return S.Annihilation:Cast()
        end
        end
      end
      
      local function UseFelRush()
        return  S.FelRush:Charges() == 2
      end


      local function EvalutateTargetIfFilterDemonsBite(Target)
        -- target_if=min:debuff.burning_wound.remains
        return Target:DebuffRemains(S.BurningWoundDebuff) or Target:DebuffRemains(S.BurningWoundLegDebuff)
      end
      
      local function EvaluateTargetIfDemonsBite(Target)
        -- if=talent.burning_wound&debuff.burning_wound.remains<4&active_dot.burning_wound<(spell_targets>?3)
        return S.BurningWound:IsAvailable() and Target:DebuffRemains(S.BurningWoundDebuff) < 4 and S.BurningWoundDebuff:AuraActiveCount() < math.min(inRange10, 3)
      end


local function APL()
    TargetTTD()
    AreaTTD()
    target_is_dummy()


inRange5 = RangeCount("Chaos Strike")
inRange10 = RangeCount("Disrupt")
inRange15 = RangeCount("Felblade")
inRange20 = RangeCount("Fel Eruption")
inRange30 = RangeCount("Consume Magic")
inRange40 = RangeCount("Throw Glaive")

targetRange5 = TargetInRange("Chaos Strike")
targetRange10 = TargetInRange("Disrupt")
targetRange15 = TargetInRange("Felblade")
targetRange20 = TargetInRange("Fel Eruption")
targetRange30 = TargetInRange("Consume Magic")
targetRange40 = TargetInRange("Throw Glaive")


GCDMax = Player:GCD() + 0.25


if Player:IsCasting() or Player:IsChanneling() then
	return 0, "Interface\\Addons\\Rubim-RH\\Media\\channel.tga"
elseif Player:IsDeadOrGhost() or AuraUtil.FindAuraByName("Drink", "player") 
or AuraUtil.FindAuraByName("Food", "player") or AuraUtil.FindAuraByName("Food & Drink", "player") then
    return 0, "Interface\\Addons\\Rubim-RH\\Media\\griph.tga"
end


if (not RubimRH.queuedSpell[1]:CooldownUp() or not RubimRH.queuedSpell[1]:IsAvailable()) and S.lustAT:ID() ~= RubimRH.queuedSpell[1]:ID() then
	RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
end

if S.lustAT:ID() == RubimRH.queuedSpell[1]:ID() and (Player:DebuffP(S.lust1) or Player:DebuffP(S.lust2) or Player:DebuffP(S.lust3) or Player:DebuffP(S.lust4) or Player:DebuffP(S.lust5)) then
	RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
end

if S.lustAT:ID() == RubimRH.queuedSpell[1]:ID() and not Player:DebuffP(S.lust1) and not Player:DebuffP(S.lust2) and not Player:DebuffP(S.lust3) and not Player:DebuffP(S.lust4) and not Player:DebuffP(S.lust5) and IsUsableItem(193470) and GetItemCooldown(193470) == 0 then
	return S.lustAT:Cast() -- BIND LUST KEYBIND IN BINDPAD TO ARCANE TORRENT
end

if (inRange30==0 or not Player:AffectingCombat()) then
	RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
end

if RubimRH.QueuedSpell():IsReadyQueue() then
	return RubimRH.QueuedSpell():Cast()
end


if RubimRH.InterruptsON() and Player:CanAttack(Target) and Player:AffectingCombat()  then
	
    local isEnraged = (AuraUtil.FindAuraByName("Enrage", "target") or UnitChannelInfo("target") == "Ragestorm" or AuraUtil.FindAuraByName("Frenzy", "target"))

    --Kick

	if S.Disrupt:IsReady() 
     and kickprio() 
    and targetRange10 and (castTime > castchannelTime+0.5 or channelTime > castchannelTime+0.5)  and select(8, UnitCastingInfo("target")) == false  and not isEnraged then
		return S.Disrupt:Cast()
	end
end



if Player:AffectingCombat() and Player:CanAttack(Target) then 
  -- Manually added: Defensive Blur
  if S.Blur:IsCastable() and Player:HealthPercentage() <= 45 and inRange20>=1 then
    return S.Blur:Cast() 
end
if HL.CombatTime()>1 and not IsCurrentSpell(6603) and targetRange20 then
    return S.autoattack:Cast()
end
  -- retarget_auto_attack,line_cd=1,target_if=min:debuff.burning_wound.remains,if=talent.burning_wound&talent.demon_blades&active_dot.burning_wound<(spell_targets>?3)
  -- retarget_auto_attack,line_cd=1,target_if=min:!target.is_boss,if=talent.burning_wound&talent.demon_blades&active_dot.burning_wound=(spell_targets>?3)
  -- variable,name=blade_dance,value=talent.first_blood|talent.trail_of_ruin|talent.chaos_theory&buff.chaos_theory.down|spell_targets.blade_dance1>1
  VarBladeDance = (S.FirstBlood:IsAvailable() or S.TrailofRuin:IsAvailable() or S.ChaosTheory:IsAvailable() and not Player:Buff(S.ChaosTheoryBuff) or inRange10 > 1)
  -- variable,name=pooling_for_blade_dance,value=variable.blade_dance&fury<(75-talent.demon_blades*20)&cooldown.blade_dance.remains<gcd.max
  VarPoolingForBladeDance = (VarBladeDance and Player:Fury() < (75 - num(S.DemonBlades:IsAvailable()) * 20) and S.BladeDance:CooldownRemains() < GCDMax)
  -- variable,name=pooling_for_eye_beam,value=talent.demonic&!talent.blind_fury&cooldown.eye_beam.remains<(gcd.max*3)&fury.deficit>30
  VarPoolingForEyeBeam = S.Demonic:IsAvailable() and not S.BlindFury:IsAvailable() and S.EyeBeam:CooldownRemains() < (GCDMax * 2) and Player:FuryDeficit() > 30
  -- variable,name=waiting_for_momentum,value=talent.momentum&!buff.momentum.up|talent.inertia&!buff.inertia.up
  -- variable,name=waiting_for_momentum,value=talent.momentum&!buff.momentum.up
  VarWaitingForMomentum = S.Momentum:IsAvailable() and not Player:Buff(S.MomentumBuff) or S.Inertia:IsAvailable() and not Player:Buff(S.InertiaBuff)
  -- variable,name=holding_meta,value=(talent.demonic&talent.essence_break)&variable.3min_trinket&fight_remains>cooldown.metamorphosis.remains+30+talent.shattered_destiny*60&cooldown.metamorphosis.remains<20&cooldown.metamorphosis.remains>action.eye_beam.execute_time+gcd.max*(talent.inner_demon+2)
  local EyeBeamExecuteTime = math.max(S.EyeBeam:BaseDuration(), Player:GCD())
  VarHoldingMeta = (S.Demonic:IsAvailable() and S.EssenceBreak:IsAvailable()) and TargetTTD() > S.Metamorphosis:CooldownRemains() + 30 + num(S.ShatteredDestiny:IsAvailable()) * 60 and S.Metamorphosis:CooldownRemains() < 20 and S.Metamorphosis:CooldownRemains() > EyeBeamExecuteTime + GCDMax * (num(S.InnerDemon:IsAvailable()) + 2)

  -- immolation_aura,if=talent.ragefire&active_enemies>=3&(cooldown.blade_dance.remains|debuff.essence_break.down)
  if S.ImmolationAura:IsCastable() and (S.Ragefire:IsAvailable() and inRange10 >= 3 and (S.BladeDance:CooldownDown() or not Target:Debuff(S.EssenceBreakDebuff))) then
    return S.ImmolationAura:Cast() 
end


  -- immolation_aura,if=talent.a_fire_inside&talent.inertia&buff.unbound_chaos.down&full_recharge_time<gcd.max*2&debuff.essence_break.down
  if S.ImmolationAura:IsCastable() and (S.AFireInside:IsAvailable() and S.Inertia:IsAvailable() and not Player:Buff(S.UnboundChaosBuff) and S.ImmolationAura:FullRechargeTime() < GCDMax * 2 and not Target:Debuff(S.EssenceBreakDebuff)) then
    return S.ImmolationAura:Cast() 
end
  ---- fel_rush,if=buff.unbound_chaos.up&(action.immolation_aura.charges=2&debuff.essence_break.down|prev_gcd.1.eye_beam&buff.inertia.up&buff.inertia.remains<3)
--   if S.FelRush:IsCastable() and UseFelRush() and (Player:Buff(S.UnboundChaosBuff) and (S.ImmolationAura:Charges() == 2 and not Target:Debuff(S.EssenceBreakDebuff) or Player:PrevGCDP(1, S.EyeBeam) and Player:Buff(S.InertiaBuff) and Player:BuffRemains(S.InertiaBuff) < 3)) then
--     return S.FelRush:Cast() 
-- end
  -- the_hunt,if=time<10&buff.potion.up&(!talent.inertia|buff.metamorphosis.up&debuff.essence_break.down)

  -- immolation_aura,if=talent.inertia&(cooldown.eye_beam.remains<gcd.max*2|buff.metamorphosis.up)&cooldown.essence_break.remains<gcd.max*3&buff.unbound_chaos.down&buff.inertia.down&debuff.essence_break.down
  if S.ImmolationAura:IsCastable() and (S.Inertia:IsAvailable() and (S.EyeBeam:CooldownRemains() < GCDMax * 2 or Player:Buff(S.MetamorphosisBuff)) and S.EssenceBreak:CooldownRemains() < GCDMax * 3 and not Player:Buff(S.UnboundChaosBuff) and not Player:Buff(S.InertiaBuff) and not Target:Debuff(S.EssenceBreakDebuff)) then
    return S.ImmolationAura:Cast() 
end
  -- immolation_aura,if=talent.inertia&buff.unbound_chaos.down&(full_recharge_time<cooldown.essence_break.remains|!talent.essence_break)&debuff.essence_break.down&(buff.metamorphosis.down|buff.metamorphosis.remains>6)&cooldown.blade_dance.remains&(fury<75|cooldown.blade_dance.remains<gcd.max*2)
  if S.ImmolationAura:IsCastable() and (S.Inertia:IsAvailable() and not Player:Buff(S.UnboundChaosBuff) and (S.ImmolationAura:FullRechargeTime() < S.EssenceBreak:CooldownRemains() or not S.EssenceBreak:IsAvailable()) and not Target:Debuff(S.EssenceBreakDebuff) and (not Player:Buff(S.MetamorphosisBuff) or Player:BuffRemains(S.MetamorphosisBuff) > 6) and S.BladeDance:CooldownDown() and (Player:Fury() < 75 or S.BladeDance:CooldownRemains() < GCDMax * 2)) then
    return S.ImmolationAura:Cast() 
end
--   -- fel_rush,if=buff.unbound_chaos.up&(buff.unbound_chaos.remains<gcd.max*2|target.time_to_die<gcd.max*2)
--   if S.FelRush:IsCastable() and UseFelRush() and (Player:Buff(S.UnboundChaosBuff) and (Player:BuffRemains(S.UnboundChaosBuff) < GCDMax * 2 or Target:TimeToDie() < GCDMax * 2)) then
--     return S.FelRush:Cast() 
-- end
--   -- fel_rush,if=talent.inertia&buff.inertia.down&buff.unbound_chaos.up&cooldown.eye_beam.remains+3>buff.unbound_chaos.remains&(cooldown.blade_dance.remains|cooldown.essence_break.up)
--   if S.FelRush:IsCastable() and UseFelRush() and (S.Inertia:IsAvailable() and not Player:Buff(S.InertiaBuff) and Player:Buff(S.UnboundChaosBuff) and S.EyeBeam:CooldownRemains() + 3 > Player:BuffRemains(S.UnboundChaosBuff) and (S.BladeDance:CooldownDown() or S.EssenceBreak:CooldownUp())) then
--     return S.FelRush:Cast() 
-- end
--   -- fel_rush,if=buff.unbound_chaos.up&talent.inertia&buff.inertia.down&(buff.metamorphosis.up|cooldown.essence_break.remains>10)
--   if S.FelRush:IsCastable() and UseFelRush() and (Player:Buff(S.UnboundChaosBuff) and S.Inertia:IsAvailable() and not Player:Buff(S.InertiaBuff) and (Player:Buff(S.MetamorphosisBuff) or S.EssenceBreak:CooldownRemains() > 10)) then
--     return S.FelRush:Cast() 
-- end

 if RubimRH.CDsON() and Player:CanAttack(Target) and targetRange10 then
    if UseItems() then
		return UseItems()
    end
  -- Note: CDsON check is within Cooldown(), as the function also includes trinkets and potions
    if S.Metamorphosis:IsCastable() and (not S.Demonic:IsAvailable()) then
        return S.Metamorphosis:Cast() 
    end
      -- metamorphosis,if=talent.demonic&(!talent.chaotic_transformation&cooldown.eye_beam.remains|cooldown.eye_beam.remains>20&(!variable.blade_dance|prev_gcd.1.death_sweep|prev_gcd.2.death_sweep)|fight_remains<25+talent.shattered_destiny*70&cooldown.eye_beam.remains&cooldown.blade_dance.remains)&buff.inner_demon.down
      if S.Metamorphosis:IsCastable() and (S.Demonic:IsAvailable() and (not S.ChaoticTransformation:IsAvailable() and S.EyeBeam:CooldownDown() or S.EyeBeam:CooldownRemains() > 20 
      and (not VarBladeDance or Player:PrevGCDP(1, S.DeathSweep) or Player:PrevGCDP(2, S.DeathSweep)) or TargetTTD() < 25 + num(S.ShatteredDestiny:IsAvailable()) * 70 and S.EyeBeam:CooldownDown() and S.BladeDance:CooldownDown()) 
      and not Player:Buff(S.InnerDemonBuff)) then
        return S.Metamorphosis:Cast() 
    end
    
    -- elysian_decree,if=(active_enemies>desired_targets|raid_event.adds.in>30)&debuff.essence_break.down
    if  S.ElysianDecree:IsCastable() and (not Target:Debuff(S.EssenceBreakDebuff)) then
        return S.ElysianDecree:Cast() 
    end
end
  -- call_action_list,name=meta_end,if=buff.metamorphosis.up&buff.metamorphosis.remains<gcd.max&active_enemies<3
  if Player:Buff(S.MetamorphosisBuff) and Player:BuffRemains(S.MetamorphosisBuff) < GCDMax and inRange10 < 3 then
    local ShouldReturn = MetaEnd(); if ShouldReturn then return ShouldReturn; end
  end
  -- pick_up_fragment,type=demon,if=demon_soul_fragments>0&(cooldown.eye_beam.remains<6|buff.metamorphosis.remains>5)&buff.empowered_demon_soul.remains<3|fight_remains<17
  -- pick_up_fragment,mode=nearest,type=lesser,if=fury.deficit>=45&(!cooldown.eye_beam.ready|fury<30)
  -- TODO: Can't detect when orbs actually spawn, we could possibly show a suggested icon when we DON'T want to pick up souls so people can avoid moving?
  -- annihilation,if=buff.inner_demon.up&cooldown.metamorphosis.remains<=gcd*3
  if S.Annihilation:IsReady() and (Player:Buff(S.InnerDemonBuff) and S.Metamorphosis:CooldownRemains() <= Player:GCD() * 3) then
    return S.Annihilation:Cast() 
end
--   -- vengeful_retreat,use_off_gcd=1,if=cooldown.eye_beam.remains<0.3&cooldown.essence_break.remains<gcd.max*2&time>5&fury>=30&gcd.remains<0.1&talent.inertia
--   if S.VengefulRetreat:IsCastable() and (S.EyeBeam:CooldownRemains() < 0.3 and S.EssenceBreak:CooldownRemains() < GCDMax * 2 and HL.CombatTime() > 5 and Player:Fury() >= 30 and S.Inertia:IsAvailable()) then
--     return S.VengefulRetreat:Cast() 
-- end
--   -- vengeful_retreat,use_off_gcd=1,if=talent.initiative&talent.essence_break&time>1&(cooldown.essence_break.remains>15|cooldown.essence_break.remains<gcd.max&(!talent.demonic|buff.metamorphosis.up|cooldown.eye_beam.remains>15+(10*talent.cycle_of_hatred)))&(time<30|gcd.remains-1<0)&(!talent.initiative|buff.initiative.remains<gcd.max|time>4)
--   if S.VengefulRetreat:IsCastable() and (S.Initiative:IsAvailable() and S.EssenceBreak:IsAvailable() and HL.CombatTime() > 1 and (S.EssenceBreak:CooldownRemains() > 15 or S.EssenceBreak:CooldownRemains() < GCDMax and (not S.Demonic:IsAvailable() or Player:Buff(S.MetamorphosisBuff) or S.EyeBeam:CooldownRemains() > 15 + (10 * num(S.CycleofHatred:IsAvailable())))) and (HL.CombatTime() < 30 or Player:GCDRemains() - 1 < 0) and (not S.Initiative:IsAvailable() or Player:BuffRemains(S.InitiativeBuff) < GCDMax or HL.CombatTime() > 4)) then
--     return S.VengefulRetreat:Cast() 
-- end
--   -- vengeful_retreat,use_off_gcd=1,if=talent.initiative&talent.essence_break&time>1&(cooldown.essence_break.remains>15|cooldown.essence_break.remains<gcd.max*2&(buff.initiative.remains<gcd.max&!variable.holding_meta&cooldown.eye_beam.remains<=gcd.remains&(raid_event.adds.in>(40-talent.cycle_of_hatred*15))&fury>30|!talent.demonic|buff.metamorphosis.up|cooldown.eye_beam.remains>15+(10*talent.cycle_of_hatred)))&(buff.unbound_chaos.down|buff.inertia.up)
--   if S.VengefulRetreat:IsCastable() and (S.Initiative:IsAvailable() and S.EssenceBreak:IsAvailable() and HL.CombatTime() > 1 and (S.EssenceBreak:CooldownRemains() > 15 or S.EssenceBreak:CooldownRemains() < GCDMax * 2 and (Player:BuffRemains(S.InitiativeBuff) < GCDMax and not VarHoldingMeta and S.EyeBeam:CooldownRemains() <= Player:GCDRemains() and Player:Fury() > 30 or not S.Demonic:IsAvailable() or Player:Buff(S.MetamorphosisBuff) or S.EyeBeam:CooldownRemains() > 15 + (10 * num(S.CycleofHatred:IsAvailable())))) and (not Player:Buff(S.UnboundChaosBuff) or Player:Buff(S.InertiaBuff))) then
--     return S.VengefulRetreat:Cast() 
-- end
--   -- vengeful_retreat,use_off_gcd=1,if=talent.initiative&!talent.essence_break&time>1&((!buff.initiative.up|prev_gcd.1.death_sweep&cooldown.metamorphosis.up&talent.chaotic_transformation)&talent.initiative)
--   if S.VengefulRetreat:IsCastable() and (S.Initiative:IsAvailable() and not S.EssenceBreak:IsAvailable() and HL.CombatTime() > 1 and ((not Player:Buff(S.InitiativeBuff) or Player:PrevGCDP(1, S.DeathSweep) and S.Metamorphosis:CooldownUp() and S.ChaoticTransformation:IsAvailable()) and S.Initiative:IsAvailable())) then
--     return S.VengefulRetreat:Cast() 
-- end
--   -- fel_rush,if=talent.momentum.enabled&buff.momentum.remains<gcd.max*2&cooldown.eye_beam.remains<=gcd.max&debuff.essence_break.down&cooldown.blade_dance.remains
--   if S.FelRush:IsCastable() and UseFelRush() and (S.Momentum:IsAvailable() and Player:BuffRemains(S.MomentumBuff) < GCDMax * 2 and S.EyeBeam:CooldownRemains() <= GCDMax and not Target:Debuff(S.EssenceBreakDebuff) and S.BladeDance:CooldownDown()) then
--     return S.FelRush:Cast() 
-- end
--   -- fel_rush,if=talent.inertia.enabled&!buff.inertia.up&buff.unbound_chaos.up&(buff.metamorphosis.up|cooldown.eye_beam.remains>action.immolation_aura.recharge_time&cooldown.eye_beam.remains>4)&debuff.essence_break.down&cooldown.blade_dance.remains
--   if S.FelRush:IsCastable() and UseFelRush() and (S.Inertia:IsAvailable() and not Player:Buff(S.InertiaBuff) and Player:Buff(S.UnboundChaosBuff) and (Player:Buff(S.MetamorphosisBuff) or S.EyeBeam:CooldownRemains() > S.ImmolationAura:Recharge() and S.EyeBeam:CooldownRemains() > 4) and not Target:Debuff(S.EssenceBreakDebuff) and S.BladeDance:CooldownDown()) then
--     return S.FelRush:Cast() 
-- end
  -- essence_break,if=(active_enemies>desired_targets|raid_event.adds.in>40)&(buff.metamorphosis.remains>gcd.max*3|cooldown.eye_beam.remains>10)&(!talent.tactical_retreat|buff.tactical_retreat.up|time<10)&(buff.vengeful_retreat_movement.remains<gcd.max*0.5|time>0)&cooldown.blade_dance.remains<=3.1*gcd.max|fight_remains<6
  -- TODO: Handle vengeful_retreat_movement
  if S.EssenceBreak:IsCastable() and ((Player:BuffRemains(S.MetamorphosisBuff) > GCDMax * 3 or S.EyeBeam:CooldownRemains() > 10) and (not S.TacticalRetreat:IsAvailable() or Player:Buff(S.TacticalRetreatBuff) or HL.CombatTime() < 10) and S.BladeDance:CooldownRemains() <= 3.1 * GCDMax or FightRemains < 6) then
    return S.EssenceBreak:Cast() 
end
  -- death_sweep,if=variable.blade_dance&(!talent.essence_break|cooldown.essence_break.remains>gcd.max*2)&buff.fel_barrage.down
  if S.DeathSweep:IsReady() and (VarBladeDance and (not S.EssenceBreak:IsAvailable() or S.EssenceBreak:CooldownRemains() > GCDMax * 2) and not Player:Buff(S.FelBarrage)) then
    return S.DeathSweep:Cast() 
end
  -- the_hunt,if=debuff.essence_break.down&(time<10|cooldown.metamorphosis.remains>10|!equipped.algethar_puzzle_box)&(raid_event.adds.in>90|active_enemies>3|time_to_die<10)&(debuff.essence_break.down&(!talent.furious_gaze|buff.furious_gaze.up|set_bonus.tier31_4pc)|!set_bonus.tier30_2pc)&time>10
  if S.TheHunt:IsCastable() and (not Target:Debuff(S.EssenceBreakDebuff) and (HL.CombatTime() < 10 or S.Metamorphosis:CooldownRemains() > 10 or not I.AlgetharPuzzleBox:IsEquipped()) and (inRange10 == 1 or inRange10 > 3 or FightRemains < 10) and (not Target:Debuff(S.EssenceBreakDebuff) and (not S.FuriousGaze:IsAvailable() or Player:Buff(S.FuriousGazeBuff) or tierequipped()==4) or tierequipped()==4) and HL.CombatTime() > 10) then
    return S.TheHunt:Cast() 
end
  -- fel_barrage,if=active_enemies>desired_targets|raid_event.adds.in>30&fury.deficit<20&buff.metamorphosis.down
  if S.FelBarrage:IsCastable() and (inRange10 > 1 or inRange10 == 1 and Player:FuryDeficit() < 20 and not Player:Buff(S.MetamorphosisBuff)) then
    return S.FelBarrage:Cast() 
end
  -- glaive_tempest,if=(active_enemies>desired_targets|raid_event.adds.in>10)&(debuff.essence_break.down|active_enemies>1)&buff.fel_barrage.down
  if S.GlaiveTempest:IsReady() and ((not Target:Debuff(S.EssenceBreakDebuff) or inRange10 > 1) and not Player:Buff(S.FelBarrage)) then
    return S.GlaiveTempest:Cast() 
end
  -- annihilation,if=buff.inner_demon.up&cooldown.eye_beam.remains<=gcd&buff.fel_barrage.down
  if S.Annihilation:IsReady() and (Player:Buff(S.InnerDemonBuff) and S.EyeBeam:CooldownRemains() <= Player:GCD() and not Player:Buff(S.FelBarrage)) then
    return S.Annihilation:Cast() 
end
--   -- fel_rush,if=talent.momentum.enabled&cooldown.eye_beam.remains<=gcd.max&buff.momentum.remains<5&buff.metamorphosis.down
--   if S.FelRush:IsCastable() and UseFelRush() and (S.Momentum:IsAvailable() and S.EyeBeam:CooldownRemains() <= GCDMax and Player:BuffRemains(S.MomentumBuff) < 5 and not Player:Buff(S.MetamorphosisBuff)) then
--     return S.FelRush:Cast() 
-- end
  -- eye_beam,if=active_enemies>desired_targets|raid_event.adds.in>(40-talent.cycle_of_hatred*15)&!debuff.essence_break.up&(cooldown.metamorphosis.remains>30-talent.cycle_of_hatred*15|cooldown.metamorphosis.remains<gcd.max*2&(!talent.essence_break|cooldown.essence_break.remains<gcd.max*1.5))&(buff.metamorphosis.down|buff.metamorphosis.remains>gcd.max|!talent.restless_hunter)&(talent.cycle_of_hatred|!talent.initiative|cooldown.vengeful_retreat.remains>5|time<10)&buff.inner_demon.down|fight_remains<15
  if S.EyeBeam:IsReady() and (not Target:Debuff(S.EssenceBreakDebuff) and (S.Metamorphosis:CooldownRemains() > 30 - num(S.CycleofHatred:IsAvailable()) * 15 or S.Metamorphosis:CooldownRemains() < GCDMax * 2 and (not S.EssenceBreak:IsAvailable() or S.EssenceBreak:CooldownRemains() < GCDMax * 1.5)) and (not Player:Buff(S.MetamorphosisBuff) or Player:BuffRemains(S.MetamorphosisBuff) > GCDMax or not S.RestlessHunter:IsAvailable()) and (S.CycleofHatred:IsAvailable() or not S.Initiative:IsAvailable() or S.VengefulRetreat:CooldownRemains() > 5 or HL.CombatTime() < 10) and not Player:Buff(S.InnerDemonBuff) or TargetTTD() < 15) then
    return S.EyeBeam:Cast() 
end
  -- blade_dance,if=variable.blade_dance&(cooldown.eye_beam.remains>5|equipped.algethar_puzzle_box&cooldown.metamorphosis.remains>(cooldown.blade_dance.duration)|!talent.demonic|(raid_event.adds.in>cooldown&raid_event.adds.in<25))&buff.fel_barrage.down|set_bonus.tier31_2pc
  if S.BladeDance:IsReady() and (VarBladeDance and (S.EyeBeam:CooldownRemains() > 5 or not S.Demonic:IsAvailable()) and not Player:Buff(S.FelBarrage) or tierequipped()==2) then
    return S.BladeDance:Cast() 
end
  -- sigil_of_flame,if=talent.any_means_necessary&debuff.essence_break.down&active_enemies>=4
  if S.SigilofFlame:IsCastable() and (S.AnyMeansNecessary:IsAvailable() and not Target:Debuff(S.EssenceBreakDebuff) and inRange10 >= 4) then
    return S.SigilofFlame:Cast() 
end
  -- throw_glaive,if=talent.soulscar&(active_enemies>desired_targets|raid_event.adds.in>full_recharge_time+9)&spell_targets>=(2-talent.furious_throws)&!debuff.essence_break.up&(full_recharge_time<gcd.max*3|active_enemies>1)&!set_bonus.tier31_2pc
  if S.ThrowGlaive:IsCastable() and (S.Soulscar:IsAvailable() and inRange10 >= (2 - num(S.FuriousThrows:IsAvailable())) and not Target:Debuff(S.EssenceBreakDebuff) and (S.ThrowGlaive:FullRechargeTime() < GCDMax * 3 or inRange10 > 1) and tierequipped()<2) then
    return S.ThrowGlaive:Cast() 
end
  -- immolation_aura,if=active_enemies>=2&fury<70&debuff.essence_break.down
  if S.ImmolationAura:IsCastable() and (inRange10 >= 2 and Player:Fury() < 70 and not Target:Debuff(S.EssenceBreakDebuff)) then
    return S.ImmolationAura:Cast() 
end
  -- annihilation,if=!variable.pooling_for_blade_dance&(cooldown.essence_break.remains|!talent.essence_break)&buff.fel_barrage.down|set_bonus.tier30_2pc
  if S.Annihilation:IsReady() and (not VarPoolingForBladeDance and (S.EssenceBreak:CooldownDown() or not S.EssenceBreak:IsAvailable()) and not Player:Buff(S.FelBarrage) or tierequipped()==4) then
    return S.Annihilation:Cast() 
end
  -- felblade,if=fury.deficit>=40&talent.any_means_necessary&debuff.essence_break.down|talent.any_means_necessary&debuff.essence_break.down
  if S.Felblade:IsCastable() and targetRange15 and (Player:FuryDeficit() >= 40 and S.AnyMeansNecessary:IsAvailable() and not Target:Debuff(S.EssenceBreakDebuff) or S.AnyMeansNecessary:IsAvailable() and not Target:Debuff(S.EssenceBreakDebuff)) then
    return S.Felblade:Cast() 
end
  -- sigil_of_flame,if=fury.deficit>=40&talent.any_means_necessary
  if S.SigilofFlame:IsCastable() and (Player:FuryDeficit() >= 40 and S.AnyMeansNecessary:IsAvailable()) then
    return S.SigilofFlame:Cast() 
end
  -- throw_glaive,if=talent.soulscar&(active_enemies>desired_targets|raid_event.adds.in>full_recharge_time+9)&spell_targets>=(2-talent.furious_throws)&!debuff.essence_break.up&!set_bonus.tier31_2pc
  if S.ThrowGlaive:IsReady() and (S.Soulscar:IsAvailable() and inRange20 >= (2 - num(S.FuriousThrows:IsAvailable())) and not Target:Debuff(S.EssenceBreakDebuff) and tierequipped()<2) then
    return S.ThrowGlaive:Cast() 
end
  -- immolation_aura,if=buff.immolation_aura.stack<buff.immolation_aura.max_stack&(!talent.ragefire|active_enemies>desired_targets|raid_event.adds.in>15)&buff.out_of_range.down&(!buff.unbound_chaos.up|!talent.unbound_chaos)&(recharge_time<cooldown.essence_break.remains|!talent.essence_break&cooldown.eye_beam.remains>recharge_time)
  if S.ImmolationAura:IsCastable() and (Player:BuffStack(S.ImmolationAuraBuff) < VarImmoMaxStacks and targetRange10 and (not Player:Buff(S.UnboundChaosBuff) or not S.UnboundChaos:IsAvailable()) and (S.ImmolationAura:Recharge() < S.EssenceBreak:CooldownRemains() or not S.EssenceBreak:IsAvailable() and S.EyeBeam:CooldownRemains() > S.ImmolationAura:Recharge())) then
    return S.ImmolationAura:Cast() 
end
  -- throw_glaive,if=talent.soulscar&cooldown.throw_glaive.full_recharge_time<cooldown.blade_dance.remains&set_bonus.tier31_2pc&buff.fel_barrage.down&!variable.pooling_for_eye_beam
  if S.ThrowGlaive:IsReady() and (S.Soulscar:IsAvailable() and S.ThrowGlaive:FullRechargeTime() < S.BladeDance:CooldownRemains() and tierequipped()==2 and not Player:Buff(S.FelBarrage) and not VarPoolingForEyeBeam) then
    return S.ThrowGlaive:Cast() 
end
  -- chaos_strike,if=!variable.pooling_for_blade_dance&!variable.pooling_for_eye_beam&buff.fel_barrage.down
  if S.ChaosStrike:IsReady() and (not VarPoolingForBladeDance and not VarPoolingForEyeBeam and not Player:Buff(S.FelBarrage)) then
    return S.ChaosStrike:Cast() 
end
  -- sigil_of_flame,if=raid_event.adds.in>15&fury.deficit>=30&buff.out_of_range.down
  if S.SigilofFlame:IsCastable() and (inRange10 == 1 and Player:FuryDeficit() >= 30 and targetRange30) then
    return S.SigilofFlame:Cast() 
end
  -- felblade,if=fury.deficit>=40
  if S.Felblade:IsCastable() and targetRange15 and (Player:FuryDeficit() >= 40) then
    return S.Felblade:Cast() 
end
--   -- fel_rush,if=!talent.momentum&talent.demon_blades&!cooldown.eye_beam.ready&(charges=2|(raid_event.movement.in>10&raid_event.adds.in>10))&(buff.unbound_chaos.down)&(recharge_time<cooldown.essence_break.remains|!talent.essence_break)
--   if S.FelRush:IsCastable() and UseFelRush() and (not S.Momentum:IsAvailable() and S.DemonBlades:IsAvailable() and S.EyeBeam:CooldownDown() and not Player:Buff(S.UnboundChaosBuff) and (S.FelRush:Recharge() < S.EssenceBreak:CooldownRemains() or not S.EssenceBreak:IsAvailable())) then
--     return S.FelRush:Cast() 
-- end
  -- demons_bite,target_if=min:debuff.burning_wound.remains,if=talent.burning_wound&debuff.burning_wound.remains<4&active_dot.burning_wound<(spell_targets>?3)
  if S.DemonsBite:IsCastable() and S.BurningWound:IsAvailable() and S.BurningWound:IsAvailable() and Target:DebuffRemains(S.BurningWoundDebuff) < 4 and S.BurningWoundDebuff:AuraActiveCount() < math.min(inRange10, 3) then
    return S.DemonsBite:Cast() 
end
--   -- fel_rush,if=!talent.momentum&!talent.demon_blades&spell_targets>1&(charges=2|(raid_event.movement.in>10&raid_event.adds.in>10))&(buff.unbound_chaos.down)
--   if S.FelRush:IsCastable() and UseFelRush() and (not S.Momentum:IsAvailable() and not S.DemonBlades:IsAvailable() and inRange10 > 1 and not Player:Buff(S.UnboundChaosBuff)) then
--     return S.FelRush:Cast() 
-- end
  -- sigil_of_flame,if=raid_event.adds.in>15&fury.deficit>=30&buff.out_of_range.down
  if S.SigilofFlame:IsCastable() and (Player:FuryDeficit() >= 30 and targetRange30) then
    return S.SigilofFlame:Cast() 
end
  -- demons_bite
  if S.DemonsBite:IsCastable() then
    return S.DemonsBite:Cast() 
end
--   -- fel_rush,if=talent.momentum&buff.momentum.remains<=20
--   if S.FelRush:IsCastable() and UseFelRush() and (S.Momentum:IsAvailable() and Player:BuffRemains(S.MomentumBuff) <= 20) then
--     return S.FelRush:Cast() 
-- end
--   -- fel_rush,if=movement.distance>15|(buff.out_of_range.up&!talent.momentum)
--   if S.FelRush:IsCastable() and (not targetRange10 and not S.Momentum:IsAvailable() and UseFelRush()) then
--     return S.FelRush:Cast() 
--   end
  -- vengeful_retreat,if=!talent.initiative&movement.distance>15
--   if S.VengefulRetreat:IsCastable() and (not S.Initiative:IsAvailable() and not targetRange10) then
--    return S.VengefulRetreat:Cast()
--   end
  -- throw_glaive,if=(talent.demon_blades|buff.out_of_range.up)&!debuff.essence_break.up&buff.out_of_range.down&!set_bonus.tier31_2pc
  if S.ThrowGlaive:IsReady() and ((S.DemonBlades:IsAvailable() or not targetRange10) and not Target:Debuff(S.EssenceBreakDebuff) and targetRange30 and tierequipped() <3) then
    return S.ThrowGlaive:Cast()
end
end




	
    return 0, "Interface\\Addons\\Rubim-RH\\Media\\griph.tga"
end




RubimRH.Rotation.SetAPL(577, APL);

local function PASSIVE()
    
end

RubimRH.Rotation.SetPASSIVE(577, PASSIVE);