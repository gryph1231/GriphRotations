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
local MultiSpell = HL.MultiSpell;
local Item = HL.Item;
local MouseOver = Unit.MouseOver;
-- Lua
local pairs = pairs;
local tableconcat = table.concat;
local tostring = tostring;
local tableinsert = table.insert;

if not Spell.Mage then
    Spell.Mage = {};
end


RubimRH.Spell[63] = {
Counterspell = Spell(2139),
ArcaneExplosion = Spell(1449),
Frostbolt = Spell(116),
Pyroblast = Spell(11366),
FireBlast = Spell(319836),
FireBlastTalent = Spell(108853),
FrostNova = Spell(122),
ArcaneIntellect = Spell(1459),
autoattack = Spell(291944), -- regeneratin
BlazingBarrier = Spell(235313),
blazingbarrier = Spell(20549), -- war stomp
lust1 = Spell(57724),
lust2 = Spell(57723),
lust3 = Spell(80354),
lust4 = Spell(95809),
lust5 = Spell(264689),
TimeWarp                   = Spell(80353), 
Fireball = Spell(133),
HotStreak = Spell(48108),
Scorch = Spell(2948),
MirrorImage = Spell(55342),
PhoenixFlames = Spell(257541),
Combustion = Spell(190319),
combustion = Spell(265221),
HeatingUp = Spell(48107),
SunKingsBlessing = Spell(383886),
RuneofPower = Spell(116011),
Meteor = Spell(153561),
Pyroclasm = Spell(269650),
ShiftingPower = Spell(382440),
ConeofCold = Spell(120),
IceNova = Spell(157997),
IceBlock = Spell(45438),
DragonsBreath = Spell(31661),
BlastWave = Spell(157981),
SunKingsBlessing = Spell(383886),
}

local S = RubimRH.Spell[63]

if not Item.Mage then Item.Mage = {}; end

Item.Mage.Fire = {
    trink = Item(178751, { 13, 14 }),

    bracer = Item(168978),
    rez = Item(158379),
    drums = Item(193470),

    HPIcon = Item(169451),
    tx1 = Item(118330),
    tx2 = Item(114616),
};

local I = Item.Mage.Fire;



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




local function kickprio()
    -- list of m+ abilities that should be kicked
    local KickSpells = {
        'Mystic Blast','Monotonous Lecture','Arcane Missiles','Astral Bomb','Healing Touch', -- AA
        'Suppress', 'Drifting Embers',  --CoS
        'Thunderous Bolt','Holy Radiance','Cleansing Flames','Unruly Yell','Rune of Healing','Etch', 'Surge',-- HoV
        'Roaring Blaze','Lightning Bolt','Flashfire','Cinderbolt', --RLP
        'Shadow Mend','Shadow Bolts','Domination','Rending Voidlash','Void Bolt','Death Blast','Necrotic Burst','Plague Spit', --SMBG
        'Tidal Burst','Haunting Gaze','Haunting Scream','Cat Nap','Defiling Mist', --TotJS
        'Erratic Growth','Mystic Vapors','Heavy Tome','Waking Bane','Icy Bindings','Illusionary Bolt',--AV
        'Disruptive Shout','Tempest','Stormbolt','Death Bolt Volley','Dominate','Storm Shock','Bloodcurdling Shout','Storm Bolt', 'Thunderstrike', 'Desacrating Blow',-- NO

    }

    local currentSpell = select(1, UnitCastingInfo('target'))

    for i = 1, #KickSpells do
        if currentSpell == KickSpells[i] then
            return true
        end
    end

    return false
end

local function stunprio()
    -- list of m+ abilities that should be stunned
    local stunspells = {
        'Mystic Blast','Monotonous Lecture','Arcane Missiles','Astral Bomb','Healing Touch','Astral Whirlwind', -- AA
        'Drifting Embers','Quelling Strike','Sound Alarm','Eye Storm','Hypnosis',  --CoS
        'Thunderous Bolt','Holy Radiance', 'Rune of Healing','Etch','Surge',-- HoV
        'Lightning Bolt','Flashfire', 'Tectonic Slam','Cold Claws','Ice Shield','Flame Dance','Cinderbolt',--RLP
        'Shadow Mend','Shadow Bolts','Domination','Rending Voidlash','Death Blast','Plague Spit','Cry of Anguish', --SMBG
        'Tidal Burst','Haunting Gaze','Haunting Scream','Cat Nap','Defiling Mist','Leg Sweep', --TotJS
        'Mystic Vapors','Shriek','Piercing Shards','Waking Bane','Icy Bindings','Illusionary Bolt','Null Stomp',--AV
        'Rally the Clan','Tempest','Stormbolt','Grasp of the Dead','Dominate','Storm Shock','Bloodcurdling Shout','Storm Bolt', 'Desacrating Blow',-- NO

    }

    local currentSpell = select(1, UnitCastingInfo('target'))

    for i = 1, #stunspells do
        if currentSpell == stunspells[i] then
            return true
        end
    end

    return false
end



local function APL()

    kickprio()
    stunprio()

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


    if UnitClassification("target") == "worldboss" or UnitClassification("target") == "rareelite" or UnitClassification("target") == "elite"
    or UnitClassification("target") == "rare" or Target:IsAPlayer() then
        elite = true
    else
        elite = false
    end

    

    if S.TimeWarp:ID() == RubimRH.queuedSpell[1]:ID() 
    and not Player:Debuff(S.lust1) and not Player:Debuff(S.lust2) and
        not Player:Debuff(S.lust3) and not Player:Debuff(S.lust4) and not Player:Debuff(S.lust5) and (I.drums:IsReady()) then
        return S.TimeWarp:Cast() -- BIND LUST KEYBIND IN BINDPAD TO ARCANE TORRENT
    end

    if S.TimeWarp:ID() == RubimRH.queuedSpell[1]:ID() and
        (
        Player:Debuff(S.lust1) or Player:Debuff(S.lust2) or Player:Debuff(S.lust3) or Player:Debuff(S.lust4) or
            Player:Debuff(S.lust5)) then
        RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
    end


    --------------------------------------------------------------------------------------------------------------------------------------------
    ----------------------------------------------------------Interrupts/Queues-----------------------------------------------------------------
    --------------------------------------------------------------------------------------------------------------------------------------------






    if (Player:IsCasting() or Player:IsChanneling()) and not Player:Buff(S.HeatingUp) and S.FireBlastTalent:Charges()>0 then
        return 0, "Interface\\Addons\\Rubim-RH\\Media\\channel.tga"
    elseif Player:IsDeadOrGhost() or AuraUtil.FindAuraByName("Drink", "player") or
        AuraUtil.FindAuraByName("Food", "player") or AuraUtil.FindAuraByName("Food & Drink", "player") then
        return 0, "Interface\\Addons\\Rubim-RH\\Media\\griph.tga"
    end


    --------------------------------------------------------------------------------------------------------------------------------------------
    ----------------------------------------------------------Defensives/Pots-------------------------------------------------------------------
    --------------------------------------------------------------------------------------------------------------------------------------------
    if RubimRH.QueuedSpell():IsReadyQueue() then
        return RubimRH.QueuedSpell():Cast()
    end



    if (not RubimRH.queuedSpell[1]:CooldownUp() or not Player:AffectingCombat() or Cache.EnemiesCount[20] == 0) then
        RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
    end


--     if (Target:CastPercentage() > 26 and Target:CastPercentage() <86 or Target:IsChanneling()) and 
--     RubimRH.InterruptsON() and S.Counterspell:IsReady(40) and Player:AffectingCombat() and kickprio() then
--     return S.Counterspell:Cast()
-- end

if (Target:CastPercentage() > 26 and Target:CastPercentage() <86 or Target:IsChanneling()) and select(8, UnitCastingInfo("target")) == false and
RubimRH.InterruptsON() and S.Counterspell:IsReady(20) and Player:AffectingCombat() then
return S.Counterspell:Cast()
end



    IsTanking = (Player:IsTankingAoE(8) or Player:IsTanking(Target))

    if Player:HealthPercentage() <= 25 and Player:AffectingCombat() and IsUsableItem(191380) and
        GetItemCooldown(191380) == 0 and GetItemCount(191380) >= 1 
        and (not Player:InArena() and not Player:InBattlegrounds()) then
        return I.HPIcon:Cast()
    end



    --------------------------------------------------------------------------------------------------------------------------------------------
    ----------------------------------------------------------StartRotation---------------------------------------------------------------------
    --------------------------------------------------------------------------------------------------------------------------------------------

    if Target:Exists() and Player:CanAttack(Target) and not Target:IsDeadOrGhost()  then
        -- and Player:AffectingCombat() or Target:AffectingCombat()

        if not IsCurrentSpell(6603) and Player:CanAttack(Target)
        and Target:AffectingCombat() and Player:AffectingCombat() and Target:IsInRange(20) then
        return S.autoattack:Cast()
    end
    -- use_items
    if RubimRH.CDsON() and Target:IsInRange(40) and not Target:IsDeadOrGhost() and Player:CanAttack(Target) and Player:AffectingCombat() then
        local ShouldReturn = UseItems();
        if ShouldReturn then return ShouldReturn; end
    end

    if S.IceBlock:IsReady() and Player:HealthPercentage()<25 then
        return S.IceBlock:Cast()
    end

    if S.BlazingBarrier:IsCastable() and not Player:Buff(S.BlazingBarrier) and Player:HealthPercentage()<60 and Cache.EnemiesCount[25] >= 1 and Player:AffectingCombat() then
        return S.blazingbarrier:Cast()
    end

  


    if Target:IsInRange(40)  then



      if S.MirrorImage:IsReady() and RubimRH.CDsON() then
        return S.MirrorImage:Cast()
    end
-- Cast Combustion on cooldown
    if S.Combustion:IsReady() and RubimRH.CDsON() then
        return S.combustion:Cast()
    end
    
    -- Fireball and Pyroblast always crit during Firestarter (above 90%)
    local FirestarterActive = Target:HealthPercentage() > 90
    

    
    -- -- Use Fire Blast to gain Hot Streak!, then cast Pyroblast.
        if S.FireBlastTalent:IsCastable() and not Player:Buff(S.HotStreak) and (Player:Buff(S.HeatingUp) or FirestarterActive) then
            return S.FireBlastTalent:Cast()
            end

    if S.Pyroblast:IsReady() and Player:Buff(S.HotStreak) then
    return S.Pyroblast:Cast()
    end
    
    -- Cast Rune of Power ahead of Sun King's Blessing hardcast Pyroblast when Sun King's Blessing is ready and Combustion is on cooldown
    if S.RuneofPower:IsReady() and S.SunKingsBlessing:TimeSinceLastCast() >= S.Combustion:CooldownRemains() 
    and not Player:IsMoving() and RubimRH.CDsON() and not Player:Buff(S.Combustion) and S.Combustion:CooldownRemains()>10 
    and not Player:Buff(S.RuneofPower) then
        return S.RuneofPower:Cast()
        end  

    -- Cast Meteor if Combustion cooldown is more than 30 seconds, or during Combustion.
    if S.Meteor:IsReady() and (S.Combustion:CooldownRemains() > 30 or Player:Buff(S.Combustion)) then
    return S.Meteor:Cast()
    end
    
    -- Cast Pyroblast hard-cast with Pyroclasm. Do this during Combustion once Fire Blast charges are low
    if S.Pyroblast:IsReady() and Player:Buff(S.Pyroclasm) and Player:Buff(S.Combustion) and S.FireBlastTalent:Charges() <= 1 then
    return S.Pyroblast:Cast()
    end


    -- Cast Shifting Power if Combustion, Rune of Power, and all charges of Fire Blast are on cooldown
    -- if S.ShiftingPower:IsReady() and S.Combustion:CooldownRemains() > 0 and S.RuneofPower:CooldownRemains() > 0 and S.FireBlast:Charges() == 0 then
    -- return S.ShiftingPower:Cast()
    -- end
    
    -- Cast Phoenix Flames to generate Heating Up in Combustion if there are less than 10 seconds left of Combustion.
    if S.PhoenixFlames:IsReady() and Player:BuffRemains(S.Combustion) < 10 and not Player:Buff(S.HeatingUp) then
    return S.PhoenixFlames:Cast()
    end



  

       
    -- Cast Scorch to generate Heating Up below 30%
        if S.Scorch:IsReady() and (Target:HealthPercentage() < 30 or Player:IsMoving()) then
        return S.Scorch:Cast()
        end

        if S.IceNova:IsReady() and Enemies12y>2 then
            return S.IceNova:Cast()
            end
    
        if S.DragonsBreath:IsReady() and Target:IsInRange(8) and Enemies10y>2 then
            return S.DragonsBreath:Cast()
            end
    
            if S.ConeofCold:IsReady() and Target:IsInRange(8) and  Enemies10y>2 then
                return S.ConeofCold:Cast()
                end
    
            if S.BlastWave:IsReady()  and Target:IsInRange(5) and Enemies8y>2  then
                return S.BlastWave:Cast()
                end
        
        -- Cast Fireball to generate Heating Up
        if S.Fireball:IsReady() then
        return S.Fireball:Cast()
        end



 


    end --end Out of range


   
         
    
    end -- end combat

    if not Player:AffectingCombat() then

      if S.ArcaneIntellect:IsCastable() and not Player:Buff(S.ArcaneIntellect) then
          return S.ArcaneIntellect:Cast()
      end

      if S.BlazingBarrier:IsCastable() and Player:IsMoving() and IsResting("player") == false and Cache.EnemiesCount[40] >= 1
  
      then
          return S.blazingbarrier:Cast()
      end

      return 0, "Interface\\Addons\\Rubim-RH\\Media\\griph.tga"
    end

    return 0, 135328
end

RubimRH.Rotation.SetAPL(63, APL);

local function PASSIVE()

end

RubimRH.Rotation.SetPASSIVE(63, PASSIVE);
