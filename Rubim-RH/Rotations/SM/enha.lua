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

if not Spell.Shaman then
    Spell.Shaman = {};
end

RubimRH.Spell[263] = {
Bloodlust = Spell(2825),
primalstrike = Spell(73899),
BloodlustPVP = Spell(204361),
bloodlust = Spell(32182),
Hailstorm = Spell(334195),
Windstrike = Spell(115356),	
AncestralSpirit = Spell(2008),
ChainLightning = Spell(188443),
EarthElemental = Spell(198103),
AstralShift = Spell(108271),
EarthbindTotem = Spell(2484),
CapacitorTotem = Spell(192058),
FlameShock = Spell(188389),
ChainHeal = Spell(1064),
FlametongueWeapon = Spell(318038),
FrostShock = Spell(196840),
LightningShield = Spell(192106),
GhostWolf = Spell(2645),
Purge = Spell(370),
HealingStreamTotem = Spell(5394),
TremorTotem = Spell(8143),
HealingSurge = Spell(8004),
WaterWalking = Spell(546),
Hex = Spell(51514),
WindShear = Spell(57994),
LightningBolt = Spell(188196),
CleanseSpirit = Spell(51886),
CrashLightning = Spell(187874),
EarthShield = Spell(974),
FeralLunge = Spell(196884),
FeralSpirit = Spell(51533),
LavaLash = Spell(60103),
SpiritWalk = Spell(58875),
StormStrike = Spell(17364),
WindfuryTotem = Spell(8512),
WindfuryWeapon = Spell(33757),
Ascendance = Spell(114051),
FireNova = Spell(333974),
LashingFlames = Spell(334046),
-- DoomWinds = Spell(),
-- PrimalLavaActuators = Spell(),
PrimordialWave = Spell(326059), 
VesperTotem = Spell(324386),
DoorofShadows = Spell(300728),
MaelstromWeapon = Spell(344179),
StormKeeper = Spell(320137),
ChainHarvest = Spell(320674),
-- FaeTransfusion = Spell(),
ElementalBlast = Spell(117014),
Sundering = Spell(197214),
IceStrike = Spell(342240),
EarthenSpike = Spell(188089),
CrashingStorm = Spell(192246),
WinfuryTotemBuff = Spell(327942),
HotHand = Spell(201900),
Steward = Spell(324739),
lust1 = Spell(57724),
lust2 = Spell(57723),
lust3 = Spell(80354),
lust4 = Spell(95809),
lust5 = Spell(264689),
Berserking = Spell(26297),
healthstone = Spell(291944),
healingpot = Spell(176108),
PrimordialWaveBuff = Spell(327164),
Shamanism = Spell(193876),
FeralSpiritBuff = Spell(333957),
}

local S = RubimRH.Spell[263]
local G = RubimRH.Spell[1] -- General Skills


local function UpdateWFB()
    if S.StormStrike:IsReadyMorph() then
        S.Windstrike = Spell(17364)
    end
    S.StormStrike.TextureSpellID = { 115356 }

    S.Windstrike.TextureSpellID = { 115356 }

end

-- Items
if not Item.Shaman then Item.Shaman = {} end
Item.Shaman.Enhancement = {
-- DoomWinds = Item(),
-- PrimalLavaActuators = Item(),

phialofserenity = Item(177278),
    trinket = Item(172666, { 13, 14 }),
	healingpot = Item(169451), --astral healing pot
    healthstone = Item(5512), --health stone
};
local I = Item.Shaman.Enhancement;


local EnemyRanges = { 10, 15, 50 }
local function UpdateRanges()
    for _, i in ipairs(EnemyRanges) do
        HL.GetEnemies(i);
    end
end


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

local function ConcerationTime()
    for i = 1, 5 do
        local active, totemName, startTime, duration, textureId = GetTotemInfo(i)
        if active == true then
            return startTime + duration - GetTime()
        end
    end
    return 0
end

local OffensiveCDs = {
    S.AvengingWrath,
    S.Crusade,

}

local function UpdateCDs()
    if RubimRH.CDsON() then
        for i, spell in pairs(OffensiveCDs) do
            if not spell:IsEnabledCD() then
                RubimRH.delSpellDisabledCD(spell:ID())
            end
        end

    end
    if not RubimRH.CDsON() then
        for i, spell in pairs(OffensiveCDs) do
            if spell:IsEnabledCD() then
                RubimRH.addSpellDisabledCD(spell:ID())
            end
        end
    end
end


local function APL()

	HL.GetEnemies("Melee");
	HL.GetEnemies(5);
	HL.GetEnemies(6);
    HL.GetEnemies(8);
	HL.GetEnemies(9);
    HL.GetEnemies(10);
	HL.GetEnemies(11);
	HL.GetEnemies(12);
	HL.GetEnemies(15);
	HL.GetEnemies(14);
	HL.GetEnemies(16);
	HL.GetEnemies(20);
	HL.GetEnemies(25);
	HL.GetEnemies(30);
 

 
-- Out of Combat
if not Player:AffectingCombat() and not Player:BuffP(S.GhostWolf) then

        if S.LightningShield:IsCastable() and not Player:BuffP(S.LightningShield) and Cache.EnemiesCount[25]==0 then
            return S.LightningShield:Cast()
        end

        -- if S.WindfuryWeapon:IsCastable() and Player:BuffRemainsP(S.WindfuryWeapon) <500 then
            -- return S.WindfuryWeapon:Cast()
        -- end
		
		-- if S.FlametongueWeapon:IsCastable() and Player:BuffRemainsP(S.FlametongueWeapon)<500 then
            -- return S.FlametongueWeapon:Cast()
        -- end
		
        -- if S.WindfuryTotem:IsCastable() and not Player:BuffP(S.WinfuryTotemBuff) and Cache.EnemiesCount[25]>=1 and not Player:PrevGCD(1, S.WindfuryTotem) then
            -- return S.WindfuryTotem:Cast()
        -- end

        if S.HealingSurge:IsReady() and Player:BuffStackP(S.MaelstromWeapon)>=5 and Cache.EnemiesCount[20]==0 and Player:HealthPercentage()<70 then
            return S.HealingSurge:Cast()
        end


 -- if I.healthstone:IsReady() and Player:HealthPercentage() <= 50 then
        -- return S.healthstone:Cast()
    -- end

    if I.healingpot:IsReady() and Player:HealthPercentage() <= 30 then
        return S.healingpot:Cast()
    end
	

  if S.Steward:IsCastable() and I.phialofserenity:Count()<= 1 and Cache.EnemiesCount[20]==0 then
        return S.Steward:Cast()
    end
	

	
	return 0, 237581
end 



-- Spell Queue
	if Player:IsChanneling() or Player:IsCasting() then
		return 0, "Interface\\Addons\\Rubim-RH\\Media\\channel.tga"
    end

	 	if  S.HealingSurge:ID() ==  RubimRH.queuedSpell[1]:ID() and (Player:BuffP(S.GhostWolf) or Player:BuffStackP(S.MaelstromWeapon)<5 ) then
    		RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
	end	
	 	if  S.Hex:ID() ==  RubimRH.queuedSpell[1]:ID() and (Player:BuffP(S.GhostWolf) or Player:IsMoving()) then
    		RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
	end	

	 	if  S.GhostWolf:ID() ==  RubimRH.queuedSpell[1]:ID() and Player:BuffP(S.GhostWolf) then
    		RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
	end	

if Target:MaxDistanceToPlayer(true) < 8 and S.FeralLunge:ID() ==  RubimRH.queuedSpell[1]:ID() then
		RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
	end
	
 -- if I.healthstone:IsReady() and Player:HealthPercentage() <= 50 then
        -- return S.healthstone:Cast()
    -- end

    if I.healingpot:IsReady() and Player:HealthPercentage() <= 30 then
        return S.healingpot:Cast()
    end


    if S.AstralShift:IsReady() and Player:HealthPercentage() <= 45 then
        return S.AstralShift:Cast()
    end
	

	if RubimRH.QueuedSpell():IsReadyQueue() then
        return RubimRH.QueuedSpell():Cast()
    end
	
	
	if  S.Bloodlust:ID() ==  RubimRH.queuedSpell[1]:ID() and S.Bloodlust:IsReadyP() then
    	return S.bloodlust:Cast()
	end	
	
	if not RubimRH.queuedSpell[1]:CooldownUp() or not Target:IsInRange(12) or not Player:AffectingCombat() then
		RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
	end





 


if Player:CanAttack(Target) and Player:AffectingCombat() then



    Ranged = function()

	
	end

	
    Cooldowns = function()
        -- if S.Bloodlust:IsReadyP() then
            -- return S.bloodlust:Cast()
        -- end
		
-- windstrike
        if S.Windstrike:IsReadyMorph() and Target:IsInRange(30) then
            return S.StormStrike:Cast()
        end


-- berserking,if=!talent.ascendance.enabled|buff.ascendance.up
        if S.Berserking:IsReady() and (not S.Ascendance:IsAvailable() or Player:BuffP(S.Ascendance)) then
            return S.Berserking:Cast()
        end


-- feral_spirit
        if S.FeralSpirit:IsReady() and Target:IsInRange(10) then
            return S.FeralSpirit:Cast()
        end

-- ascendance
        if S.Ascendance:IsReady() and Target:IsInRange(10) then
            return S.Ascendance:Cast()
        end


    end




    AoE = function()
-- frost_shock,if=buff.hailstorm.up
        if S.FrostShock:IsReady() and Player:BuffP(S.Hailstorm) and Target:IsInRange(40) then
            return S.FrostShock:Cast()
        end


-- windfury_totem,if=runeforge.doom_winds.equipped&buff.doom_winds_debuff.down
        -- if S.WindfuryTotem:IsReady() and I.DoomWinds:IsEquipped() and not Target:Debuff(S.DoomWinds) hen
            -- return S.WindfuryTotem:Cast()
        -- end


-- flame_shock,target_if=refreshable,cycle_targets=1,if=talent.fire_nova.enabled|talent.lashing_flames.enabled|covenant.necrolord
        if S.FlameShock:IsReady() and Target:IsInRange(40) and not Target:Debuff(S.FlameShock) and (S.FireNova:IsAvailable() or S.LashingFlames:IsAvailable()) --cause necrolord was chosen and didnt know way to track this yet) 
		then
            return S.FlameShock:Cast()
        end


-- primordial_wave,target_if=min:dot.flame_shock.remains,cycle_targets=1,if=!buff.primordial_wave.up
        if S.PrimordialWave:IsReady() and Target:Debuff(S.FlameShock) and not Player:BuffP(S.PrimordialWaveBuff) and Target:IsInRange(40) then
            return S.PrimordialWave:Cast()
        end


-- fire_nova,if=active_dot.flame_shock>=3
        if S.FireNova:IsReady() and (MultiDots(12, S.FlameShock, 10, 3) >= 1) and Target:IsInRange(10) then
            return S.FireNova:Cast()
        end


-- vesper_totem
       -- if S.VesperTotem:IsReady() and Target:IsInRange(8) and RubimRH.CDsON() then
            -- return S.VesperTotem:Cast()
        -- end



-- lightning_bolt,if=buff.primordial_wave.up&(buff.stormkeeper.up|buff.maelstrom_weapon.stack>=5)
        if S.LightningBolt:IsReady() and Player:BuffP(S.PrimordialWaveBuff) and (Player:BuffP(S.StormKeeper) or Player:BuffStackP(S.MaelstromWeapon)>=5) and Target:IsInRange(40) then
            return S.LightningBolt:Cast()
        end


-- crash_lightning,if=talent.crashing_storm.enabled|buff.crash_lightning.down
        if S.CrashLightning:IsReady() and (S.CrashingStorm:IsAvailable() or not Player:BuffP(S.CrashLightning)) and Target:IsInRange(6) then
            return S.CrashLightning:Cast()
        end

-- lava_lash,target_if=min:debuff.lashing_flames.remains,cycle_targets=1,if=talent.lashing_flames.enabled
        if S.LavaLash:IsReady() and Target:DebuffRemains(S.LashingFlames)<Player:GCD() and S.LashingFlames:IsAvailable() and Target:IsInRange(10) then
            return S.LavaLash:Cast()
        end


-- crash_lightning
        if S.CrashLightning:IsReady() and Cache.EnemiesCount[6]>=2 and Target:IsInRange(6) then
            return S.CrashLightning:Cast()
        end


-- chain_lightning,if=buff.stormkeeper.up
        if S.ChainLightning:IsReady() and Player:BuffP(S.StormKeeper) and Target:IsInRange(40) then
            return S.ChainLightning:Cast()
        end


-- chain_harvest,if=buff.maelstrom_weapon.stack>=5
        if S.ChainHarvest:IsReady() and Player:BuffStackP(S.MaelstromWeapon)>=5 and RubimRH.CDsON() and Target:IsInRange(40) then
            return S.ChainHarvest:Cast()
        end


-- elemental_blast,if=buff.maelstrom_weapon.stack>=5
        if S.ElementalBlast:IsReady() and Player:BuffStackP(S.MaelstromWeapon)>=5 and Target:IsInRange(40) then
            return S.ElementalBlast:Cast()
        end


-- stormkeeper,if=buff.maelstrom_weapon.stack>=5
        if S.StormKeeper:IsReady() and Player:BuffStackP(S.MaelstromWeapon)>=5 and Target:IsInRange(40) then
            return S.StormKeeper:Cast()
        end


-- chain_lightning,if=buff.maelstrom_weapon.stack=10
        if S.ChainLightning:IsReady() and Player:BuffStackP(S.MaelstromWeapon)==10 and Target:IsInRange(40) then
            return S.ChainLightning:Cast()
        end

-- flame_shock,target_if=refreshable,cycle_targets=1,if=talent.fire_nova.enabled
        if S.FlameShock:IsReady() and Target:DebuffRemains(S.FlameShock)<5.4 and S.FireNova:IsAvailable() and Target:IsInRange(40) then
            return S.FlameShock:Cast()
        end

-- sundering
        if S.Sundering:IsReady() and RubimRH.CDsON() and Target:IsInRange(8) then
            return S.Sundering:Cast()
        end

-- lava_lash,target_if=min:debuff.lashing_flames.remains,cycle_targets=1,if=runeforge.primal_lava_actuators.equipped&buff.primal_lava_actuators.stack>6
        -- if S.LavaLash:IsReady() and Target:DebuffRemains(S.LashingFlames)<Player:GCD() and I.PrimalLavaActuators:IsEquipped() and Player:BuffStackP(S.PrimalLavaActuators)>6 then
            -- return S.LavaLash:Cast()
        -- end



-- stormstrike
        if S.StormStrike:IsReady() and Target:IsInRange(10) then
            return S.StormStrike:Cast()
        end

        if S.primalstrike:IsReady() and Target:IsInRange(10) then
            return S.StormStrike:Cast()
        end

-- lava_lash
        if S.LavaLash:IsReady() and Target:IsInRange(10) then
            return S.LavaLash:Cast()
        end


-- flame_shock,target_if=refreshable,cycle_targets=1
        if S.FlameShock:IsReady() and Target:DebuffRemains(S.FlameShock)<5.4 and Target:IsInRange(40) then
            return S.FlameShock:Cast()
        end


-- fae_transfusion
        -- if S.FaeTransfusion:IsReady() then
            -- return S.FaeTransfusion:Cast()
        -- end


-- frost_shock
        if S.FrostShock:IsReady() and Target:IsInRange(40) then
            return S.FrostShock:Cast()
        end

-- ice_strike
        if S.IceStrike:IsReady() and Target:IsInRange(10) then
            return S.IceStrike:Cast()
        end



-- chain_lightning,if=buff.maelstrom_weapon.stack>=5
        if S.ChainLightning:IsReady() and Player:BuffStackP(S.MaelstromWeapon)>=5 and Target:IsInRange(40) then
            return S.ChainLightning:Cast()
        end

-- fire_nova,if=active_dot.flame_shock>1
        if S.FireNova:IsReady() and (MultiDots(40, S.FlameShock, 10, 1) >= 1 or Target:Debuff(S.FlameShock)) and Target:IsInRange(10) then
            return S.FireNova:Cast()
        end

-- earthen_spike
        if S.EarthenSpike:IsReady() and Target:IsInRange(10) then
            return S.EarthenSpike:Cast()
        end


-- windfury_totem,if=buff.windfury_totem.remains<30
        -- if S.WindfuryTotem:IsReady() and not Player:BuffP(S.WinfuryTotemBuff) and not Player:PrevGCD(1, S.WindfuryTotem)  then
            -- return S.WindfuryTotem:Cast()
        -- end

	
end	


    SingleTarget = function()
	
-- primordial_wave,if=!buff.primordial_wave.up
        if S.PrimordialWave:IsReady() and Target:IsInRange(40) and not Player:BuffP(S.PrimordialWaveBuff) and (Cache.EnemiesCount[12]==1 or not RubimRH.AoEON()) then
            return S.PrimordialWave:Cast()
        end


-- windfury_totem,if=runeforge.doom_winds.equipped&buff.doom_winds_debuff.down
        -- if S.WindfuryTotem:IsReady() and I.DoomWinds:IsEquipped() and not Target:Debuff(S.DoomWinds) hen
            -- return S.WindfuryTotem:Cast()
        -- end

-- flame_shock,if=!ticking
        if S.FlameShock:IsReady() and not Target:Debuff(S.FlameShock) and Target:IsInRange(40) then
            return S.FlameShock:Cast()
        end

-- vesper_totem
        -- if S.VesperTotem:IsReady() and Target:IsInRange(8) and RubimRH.CDsON() then
            -- return S.VesperTotem:Cast()
        -- end

-- frost_shock,if=buff.hailstorm.up
        if S.FrostShock:IsReady() and Target:IsInRange(40) then
            return S.FrostShock:Cast()
        end


-- earthen_spike
        if S.EarthenSpike:IsReady() and Target:IsInRange(10) then
            return S.EarthenSpike:Cast()
        end

-- fae_transfusion
        -- if S.FaeTransfusion:IsReady() then
            -- return S.FaeTransfusion:Cast()
        -- end

-- lightning_bolt,if=buff.stormkeeper.up
        if S.LightningBolt:IsReady() and Player:BuffP(S.StormKeeper) and Target:IsInRange(40) then
            return S.LightningBolt:Cast()
        end


-- elemental_blast,if=buff.maelstrom_weapon.stack>=5
        if S.ElementalBlast:IsReady() and Player:BuffStackP(S.MaelstromWeapon)>=5 and Target:IsInRange(40) then
            return S.ElementalBlast:Cast()
        end


-- chain_harvest,if=buff.maelstrom_weapon.stack>=5
        if S.ChainHarvest:IsReady() and Target:IsInRange(40) and Player:BuffStackP(S.MaelstromWeapon)>=5 and RubimRH.CDsON() then
            return S.ChainHarvest:Cast()
        end

-- lightning_bolt,if=buff.maelstrom_weapon.stack=10
        if S.LightningBolt:IsReady() and Player:BuffStackP(S.MaelstromWeapon)==10 and Target:IsInRange(40) then
            return S.LightningBolt:Cast()
        end


-- lava_lash,if=buff.hot_hand.up|(runeforge.primal_lava_actuators.equipped&buff.primal_lava_actuators.stack>6)
        if S.LavaLash:IsReady() and Target:IsInRange(10) and ((Player:BuffP(S.HotHand))
		-- or (I.PrimalLavaActuators:IsEquipped() and Player:BuffStackP(S.PrimalLavaActuators)>6) 
		)
		then
            return S.LavaLash:Cast()
        end


-- stormstrike
        if S.StormStrike:IsReady() and Target:IsInRange(10) then
            return S.StormStrike:Cast()
        end
        if S.primalstrike:IsReady() and Target:IsInRange(10) then
            return S.StormStrike:Cast()
        end


-- stormkeeper,if=buff.maelstrom_weapon.stack>=5
        if S.StormKeeper:IsReady() and Target:IsInRange(40) and Player:BuffStackP(S.MaelstromWeapon)>=5 then
            return S.StormKeeper:Cast()
        end


-- lava_lash
        if S.LavaLash:IsReady() and Target:IsInRange(10) then
            return S.LavaLash:Cast()
        end


-- crash_lightning
        if S.CrashLightning:IsReady() and Target:IsInRange(6) and Cache.EnemiesCount[6]>=1 then
            return S.CrashLightning:Cast()
        end


-- flame_shock,target_if=refreshable
        if S.FlameShock:IsReady() and Target:DebuffRemains(S.FlameShock)<5.4 and Target:IsInRange(40) then
            return S.FlameShock:Cast()
        end


-- frost_shock
        if S.FrostShock:IsReady() and Target:IsInRange(40) then
            return S.FrostShock:Cast()
        end


-- ice_strike
        if S.IceStrike:IsReady() and Target:IsInRange(10) then
            return S.IceStrike:Cast()
        end


-- sundering
        if S.Sundering:IsReady() and RubimRH.CDsON() and Target:IsInRange(8) then
            return S.Sundering:Cast()
        end


-- fire_nova,if=active_dot.flame_shock
        if S.FireNova:IsReady() and Target:IsInRange(10) and (MultiDots(40, S.FlameShock, 10, 1) >= 1 or Target:Debuff(S.FlameShock)) and Cache.EnemiesCount[12]>=1 then
            return S.FireNova:Cast()
        end

-- lightning_bolt,if=buff.maelstrom_weapon.stack>=5
        if S.LightningBolt:IsReady() and Player:BuffStackP(S.MaelstromWeapon)>=10 and Target:IsInRange(40) then
            return S.LightningBolt:Cast()
        end

-- windfury_totem,if=buff.windfury_totem.remains<30	
        -- if S.WindfuryTotem:IsReady() and not Player:BuffP(S.WinfuryTotemBuff) and Target:IsInRange(20) and not Player:PrevGCD(1, S.WindfuryTotem)  then
            -- return S.WindfuryTotem:Cast()
        -- end

	
    end
	






   if not Target:IsInRange(12) then
    if Ranged() ~= nil then
        return Ranged()
    end
	end
	
	
   if Target:IsInRange(10) and RubimRH.CDsON() then
    if Cooldowns() ~= nil then
        return Cooldowns()
    end
	end
		
    if AoE() ~= nil and RubimRH.AoEON() and Cache.EnemiesCount[12]>1 then
        return AoE()
    end
	
    if SingleTarget() ~= nil then
        return SingleTarget()
    end
	
	
end

    return 0, 135328
end




RubimRH.Rotation.SetAPL(263, APL);

local function PASSIVE()
    
end

RubimRH.Rotation.SetPASSIVE(263, PASSIVE);