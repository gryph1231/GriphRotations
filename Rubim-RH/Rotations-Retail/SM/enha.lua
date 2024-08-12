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

    APL ()
    -- Opener
    if HL.CombatTime() < 10 then
        if not Player:Buff(S.WindfuryTotem) and S.WindfuryTotem:IsReady() then
            return S.WindfuryTotem:Cast()
        end
        if S.FlameShock:IsReady() and not Target:Debuff(S.FlameShock) then
            return S.FlameShock:Cast()
        end
        if S.FeralSpirit:IsReady() then
            return S.FeralSpirit:Cast()
        end
        if S.PrimordialWave:IsReady() then
            return S.PrimordialWave:Cast()
        end
        if S.LavaLash:IsReady() and Cache.EnemiesCount[10] >= 2 and Target:Debuff(S.FlameShock) then
            return S.LavaLash:Cast()
        end
        if S.LightningBolt:IsReady() and Player:BuffStack(S.MaelstromWeapon) >= 10 and Player:Buff(S.PrimordialWave) then
            return S.LightningBolt:Cast()
        end
        if (S.CrashLightning:IsReady() or S.ChainLightning:IsReady()) and Player:Buff(S.FeralSpirit) then
            return S.AlphaWolf:Cast()
        end
        if S.Stormstrike:IsReady() then
            return S.Stormstrike:Cast()
        end
        if (S.LightningBolt:IsReady() or S.ChainLightning:IsReady()) and Player:BuffStack(S.MaelstromWeapon) >= 5 then
            return S.Ascendance:Cast()
        end
        if S.Ascendance:IsReady() and Target:IsInRange(5) then
            return S.Windstrike:Cast()
        end
        if S.DoomWinds:IsReady() and S.Stormstrike:IsReady() then
            return S.DoomWinds:Cast()
        end
        if S.ElementalBlast:IsReady() and Player:BuffStack(S.MaelstromWeapon) >= 8 then
            return S.ElementalBlast:Cast()
        end
        if S.LavaBurst:IsReady() and Player:BuffStack(S.MaelstromWeapon) >= 8 then
            return S.LavaBurst:Cast()
        end
    end

    -- AOE
    if Cache.EnemiesCount[10] >= 2 then
        if not Player:Buff(S.WindfuryTotem) and S.WindfuryTotem:IsReady() then
            return S.WindfuryTotem:Cast()
        end
        if S.FeralSpirit:IsReady() then
            return S.FeralSpirit:Cast()
        end
        if S.Ascendance:IsReady() and S.ThorimsInvocation:IsReady() and Player:BuffStack(S.ChainLightning) then
            return S.Ascendance:Cast()
        end
        if S.LightningBolt:IsReady() and Player:Buff(S.PrimordialWave) and Player:BuffStack(S.MaelstromWeapon) == 10 and S.FlameShock:MaxDebuffTargets() then
            return S.LightningBolt:Cast()
        end
        if S.DoomWinds:IsReady() then
            return S.DoomWinds:Cast()
        end
        if S.CrashLightning:IsReady() and (not Player:Buff(S.CrashLightning) or Player:Buff(S.DoomWinds)) then
            return S.CrashLightning:Cast()
end
if S.Sundering:IsReady() and Player:Buff(S.DoomWinds) then
return S.Sundering:Cast()
end
if S.FireNova:IsReady() and S.FlameShock:MaxDebuffTargets() >= 6 then
return S.FireNova:Cast()
end
if S.PrimordialWave:IsReady() then
return S.PrimordialWave:Cast()
end
if S.Windstrike:IsReady() then
return S.Windstrike:Cast()
end
if S.LavaLash:IsReady() and Target:Debuff(S.FlameShock) and not Target:Debuff(S.LashingFlames) then
return S.LavaLash:Cast()
end
if S.FlameShock:IsReady() and not Target:Debuff(S.FlameShock) then
return S.FlameShock:Cast()
end
if S.LavaLash:IsReady() and Target:Debuff(S.FlameShock) then
return S.LavaLash:Cast()
end
if S.IceStrike:IsReady() and S.Hailstorm:IsReady() then
return S.IceStrike:Cast()
end
if S.FrostShock:IsReady() and Player:Buff(S.Hailstorm) then
return S.FrostShock:Cast()
end
if S.Sundering:IsReady() then
return S.Sundering:Cast()
end
if S.FireNova:IsReady() and S.FlameShock:MaxDebuffTargets() >= 4 then
return S.FireNova:Cast()
end
if S.ElementalBlast:IsReady() and Cache.EnemiesCount[10] <= 3 then
return S.ElementalBlast:Cast()
end
if S.ChainLightning:IsReady() and Player:BuffStack(S.MaelstromWeapon) >= 8 then
return S.ChainLightning:Cast()
end
if S.CrashLightning:IsReady() and Player:Buff(S.ChainLightning) then
return S.CrashLightning:Cast()
end
if S.LavaLash:IsReady() and Player:Buff(S.CrashLightning) and Player:BuffStack(S.AshenCatalyst) >= 8 then
return S.LavaLash:Cast()
end
if S.Windstrike:IsReady() then
return S.Windstrike:Cast()
end
if S.Stormstrike:IsReady() and Player:Buff(S.CrashLightning) then
return S.Stormstrike:Cast()
end
if S.LavaLash:IsReady() and Player:Buff(S.CrashLightning) then
return S.LavaLash:Cast()
end
if S.IceStrike:IsReady() and Player:Buff(S.CrashLightning) then
return S.IceStrike:Cast()
end
if S.FireNova:IsReady() and S.FlameShock:MaxDebuffTargets() >= 2 then
return S.FireNova:Cast()
end
if S.CrashLightning:IsReady() then
return S.CrashLightning:Cast()
end
if S.LavaLash:IsReady() then
return S.LavaLash:Cast()
end
if S.Stormstrike:IsReady() then
return S.Stormstrike:Cast()
end
if S.IceStrike:IsReady() then
     return S.IceStrike:Cast()
    end
    if S.ChainLightning:IsReady() and Player:BuffStack(S.MaelstromWeapon) >= 5 then
        return S.ChainLightning:Cast()
    end
    if S.FlameShock:IsReady() then
        return S.FlameShock:Cast()
    end
    if S.FrostShock:IsReady() then
        return S.FrostShock:Cast()
    end
    if S.WindfuryTotem:IsReady() and Player:BuffRemains(S.WindfuryTotem) <= 10 then
        return S.WindfuryTotem:Cast()
    end
end

-- Single Target Priority
if S.FeralSpirit:IsReady() then
    return S.FeralSpirit:Cast()
end
if S.Ascendance:IsReady() then
    return S.Ascendance:Cast()
end
if S.DoomWinds:IsReady() then
    return S.DoomWinds:Cast()
end
if S.Windstrike:IsReady() and Player:Buff(S.Ascendance) then
    return S.Windstrike:Cast()
end
if S.LavaLash:IsReady() and (Player:Buff(S.HotHand) or Player:BuffStack(S.AshenCatalyst) >= 7) then
    return S.LavaLash:Cast()
end
if S.WindfuryTotem:IsReady() and not Player:Buff(S.WindfuryTotem) then
    return S.WindfuryTotem:Cast()
end
if S.Stormstrike:IsReady() and Player:Buff(S.DoomWinds) then
    return S.Stormstrike:Cast()
end
if S.IceStrike:IsReady() and Player:Buff(S.DoomWinds) then
    return S.IceStrike:Cast()
end
if S.CrashLightning:IsReady() and Player:Buff(S.DoomWinds) then
    return S.CrashLightning:Cast()
end
if S.Sundering:IsReady() and Player:Buff(S.DoomWinds) then
    return S.Sundering:Cast()
end
if S.PrimordialWave:IsReady() then
    return S.PrimordialWave:Cast()
end
if S.FlameShock:IsReady() and not Target:Debuff(S.FlameShock) then
    return S.FlameShock:Cast()
end
if S.LightningBolt:IsReady() and Player:BuffStack(S.MaelstromWeapon) >= 8 and Player:Buff(S.PrimordialWave) then
    return S.LightningBolt:Cast()
end
if S.ElementalBlast:IsReady() and Player:BuffStack(S.MaelstromWeapon) >= 8 and (Player:BuffStack(S.ElementalBlastCharges) >= 2 or Player:Buff(S.ElementalSpirits)) then
    return S.ElementalBlast:Cast()
end
if S.ElementalBlast:IsReady() and Player:BuffStack(S.MaelstromWeapon) >= 8 and Player:BuffStack(S.ElementalBlastCharges) >= 2 then
    return S.ElementalBlast:Cast()
end
if S.IceStrike:IsReady() then
    return S.IceStrike:Cast()
end
if S.Stormstrike:IsReady() and Player:Buff(S.MaelstromofElements) and Player:BuffStack(S.MaelstromWeapon)<= 5 then
return S.Stormstrike:Cast()
end
if S.FrostShock:IsReady() and Player:Buff(S.Hailstorm) then
return S.FrostShock:Cast()
end
if S.LavaLash:IsReady() and Target:DebuffRemains(S.FlameShock) <= 5 then
return S.LavaLash:Cast()
end
if S.Stormstrike:IsReady() and Player:Buff(S.DeeplyRootedElements) then
return S.Stormstrike:Cast()
end
if S.ElementalBlast:IsReady() and Player:BuffStack(S.MaelstromWeapon) >= 5 and (Player:BuffStack(S.ElementalBlastCharges) >= 2 or Player:Buff(S.ElementalSpirits)) then
return S.ElementalBlast:Cast()
end
if S.ElementalBlast:IsReady() and Player:BuffStack(S.MaelstromWeapon) >= 5 and Player:BuffStack(S.ElementalBlastCharges) >= 2 then
return S.ElementalBlast:Cast()
end
if S.LavaBurst:IsReady() and Player:BuffStack(S.MaelstromWeapon) >= 5 then
return S.LavaBurst:Cast()
end
if S.LightningBolt:IsReady() and Player:BuffStack(S.MaelstromWeapon) == 10 then
return S.LightningBolt:Cast()
end
if S.Stormstrike:IsReady() then
return S.Stormstrike:Cast()
end
if S.WindfuryTotem:IsReady() and Player:BuffRemains(S.WindfuryTotem) <= 10 then
return S.WindfuryTotem:Cast()
end
if S.IceStrike:IsReady() then
return S.IceStrike:Cast()
end
if S.LavaLash:IsReady() then
return S.LavaLash:Cast()
end
if S.LightningBolt:IsReady() and Player:BuffStack(S.MaelstromWeapon) >= 5 then
return S.LightningBolt:Cast()
end
if S.Sundering:IsReady() then
return S.Sundering:Cast()
end
if S.FireNova:IsReady() then
return S.FireNova:Cast()
end
if S.FrostShock:IsReady() then
return S.FrostShock:Cast()
end
if S.CrashLightning:IsReady() then
return S.CrashLightning:Cast()
end
if S.FlameShock:IsReady() then
return S.FlameShock:Cast()
end
if S.WindfuryTotem:IsReady() then
return S.WindfuryTotem:Cast()
end

end

    return 0, 135328
end




RubimRH.Rotation.SetAPL(263, APL);

local function PASSIVE()
    
end

RubimRH.Rotation.SetPASSIVE(263, PASSIVE);