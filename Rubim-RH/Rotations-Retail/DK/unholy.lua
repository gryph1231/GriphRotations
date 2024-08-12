--- Localize Vars
-- Addon
local addonName, addonTable = ...;
-- HeroLib
local HL = HeroLib;
local Cache = HeroCache;
local Unit = HL.Unit;
local Player = Unit.Player;
local Pet = Unit.Pet;
local Target = Unit.Target;
local Spell = HL.Spell;
local Item = HL.Item;
local MouseOver = Unit.MouseOver;
-- Lua
local pairs = pairs;
local tableconcat = table.concat;
local tostring = tostring;
local tableinsert = table.insert;

if not Spell.DeathKnight then
Spell.DeathKnight = {};
end

RubimRH.Spell[252] = {
autoattack             = Spell(59752), -- will to survive (human racial)



lust1                    = Spell(57724),
lust2                    = Spell(57723),
lust3                    = Spell(80354),
lust4                    = Spell(95809),
lust5                    = Spell(264689),
lustAT                   = Spell(20549), -- war stomp

 -- Abilities
 DeathAndDecay                         = Spell(43265),
 DeathCoil                             = Spell(47541),
 -- Talents
 AbominationLimb                       = Spell(383269),
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
 -- Buffs
 AbominationLimbBuff                   = Spell(383269),
 DeathAndDecayBuff                     = Spell(188290),
 DeathsDueBuff                         = Spell(324165), -- SL Covenant. Remove after DF launch?
 EmpowerRuneWeaponBuff                 = Spell(47568),
 IcyTalonsBuff                         = Spell(194879),
 UnholyStrengthBuff                    = Spell(53365),
 DeathStrikeBuff                       = Spell(101568),
 -- Debuffs
 BloodPlague                     = Spell(55078),
 FrostFever                     = Spell(55095),
 SoulReaperDebuff                      = Spell(343294),
 VirulentPlague                  = Spell(191587),
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
 Pool                                  = Spell(999910),
-- Abilities
  -- Talents
  Apocalypse                            = Spell(275699),
  ArmyoftheDamned                       = Spell(276837),
  ArmyoftheDead                         = Spell(42650),
  BurstingSores                         = Spell(207264),
  ClawingShadows                        = Spell(207311),
  CoilofDevastation                     = Spell(390270),
  CommanderoftheDead                    = Spell(390259),
  DarkTransformation                    = Spell(63560),
  Defile                                = Spell(152280),
  EbonFever                             = Spell(207269),
  Epidemic                              = Spell(207317),
  EternalAgony                          = Spell(390268),
  FesteringStrike                       = Spell(85948),
  Festermight                           = Spell(377590),
  GhoulishFrenzy                        = Spell(377587),
  ImprovedDeathCoil                     = Spell(377580),
  InfectedClaws                         = Spell(207272),
  Morbidity                             = Spell(377592),
  Outbreak                              = Spell(77575),
  Pestilence                            = Spell(277234),
  Plaguebringer                         = Spell(390175),
  RottenTouch                           = Spell(390275),
  ScourgeStrike                         = Spell(55090),
  SummonGargoyle                        = Spell(207349),
--   SummonGargoyle                        = Spell(49206),
  Superstrain                           = Spell(390283),
  UnholyAssault                         = Spell(207289),
  UnholyBlight                          = Spell(115989),
  UnholyCommand                         = Spell(316941),
  UnholyPact                            = Spell(319230),
  VileContagion                         = Spell(390279),
  -- Buffs
  FestermightBuff                       = Spell(377591),
  PlaguebringerBuff                     = Spell(390178),
  RunicCorruptionBuff                   = Spell(51460),
  SuddenDoomBuff                        = Spell(81340),
  UnholyAssaultBuff                     = Spell(207289),
  -- Debuffs
  DeathRotDebuff                        = Spell(377540),
  FesteringWound                 = Spell(194310),
  UnholyBlightDebuff                    = Spell(115994),




}

local S = RubimRH.Spell[252]
local G = RubimRH.Spell[1] -- General Skills




-- Items
if not Item.DeathKnight then Item.DeathKnight = {} end

Item.DeathKnight.Unholy = {
phialofserenity = Item(177278),
tempest = Item(171416),
HPIcon = Item(169451),
tx1 = Item(118330),
tx2 = Item(114616),
healingpot = Item(187802),
healingpoticon = Item(169451),
HealthStone = Item(5512), --health stone
drums = Item(193470),

};
local I = Item.DeathKnight.Unholy;


    

local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_TALENT_UPDATE")
frame:SetScript("OnEvent", UpdateTemplarsVerdictSpellId)




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
            'Mystic Blast', 'Monotonous Lecture', 'Arcane Missiles', 'Astral Bomb',
            'Healing Touch',    -- AA
            'Suppress',
            'Drifting Embers', 'Bewitch', --CoS
            'Thunderous Bolt', 'Holy Radiance', 'Cleansing Flames', 'Unruly Yell', 'Rune of Healing', 'Etch',
            'Surge',            -- HoV
            'Roaring Blaze', 'Lightning Bolt', 'Flashfire',
            'Cinderbolt',       --RLP
            'Shadow Mend', 'Shadow Bolts', 'Domination', 'Rending Voidlash', 'Void Bolt', 'Death Blast', 'Necrotic Burst',
            'Plague Spit',      --SMBG
            'Tidal Burst', 'Haunting Gaze', 'Haunting Scream', 'Cat Nap',
            'Defiling Mist',    --TotJS
            'Erratic Growth', 'Mystic Vapors', 'Heavy Tome', 'Waking Bane', 'Icy Bindings',
            'Illusionary Bolt', --AV
            'Disruptive Shout', 'Tempest', 'Stormbolt', 'Death Bolt Volley', 'Dominate', 'Storm Shock',
            'Bloodcurdling Shout', 'Storm Bolt', 'Thunderstrike',
            'Desacrating Blow', -- NO
    
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
    
    local function stunprio()
        -- list of m+ abilities that should be stunned
        local stunspells = {
            'Mystic Blast', 'Monotonous Lecture', 'Arcane Missiles', 'Astral Bomb', 'Healing Touch',
            'Astral Whirlwind', -- AA
            'Drifting Embers', 'Quelling Strike', 'Sound Alarm', 'Eye Storm',
            'Hypnosis',         --CoS
            'Thunderous Bolt', 'Holy Radiance', 'Rune of Healing', 'Etch',
            'Surge',            -- HoV
            'Lightning Bolt', 'Flashfire', 'Tectonic Slam', 'Cold Claws', 'Ice Shield', 'Flame Dance',
            'Cinderbolt',       --RLP
            'Shadow Mend', 'Shadow Bolts', 'Domination', 'Rending Voidlash', 'Death Blast', 'Plague Spit',
            'Cry of Anguish',   --SMBG
            'Tidal Burst', 'Haunting Gaze', 'Haunting Scream', 'Cat Nap', 'Defiling Mist',
            'Leg Sweep',        --TotJS
            'Mystic Vapors', 'Shriek', 'Piercing Shards', 'Waking Bane', 'Icy Bindings', 'Illusionary Bolt',
            'Null Stomp',       --AV
            'Rally the Clan', 'Tempest', 'Stormbolt', 'Grasp of the Dead', 'Dominate', 'Storm Shock', 'Bloodcurdling Shout',
            'Storm Bolt',
            'Desacrating Blow', -- NO
    
        }
    
    local currentspellchannel = select(1,UnitChannelInfo('target'))
    local currentspellcast = select(1, UnitCastingInfo('target'))
    
    for i = 1, #stunspells do
    if currentspellcast == stunspells[i] or currentspellchannel == stunspells[i] then
    return true
    end
    end
    
    return false
    end
    
        local function combatmobs40()
            local totalmobsincombat = 0
        
            for id = 1, 40 do
                local unitID = "nameplate" .. id
                local unitName = UnitName(unitID)
                if (UnitCanAttack("player", unitID) and UnitHealthMax(unitID) > 5
                 and UnitAffectingCombat(unitID) and IsItemInRange(835, unitID) 
                 or (unitName and string.sub(unitName, -5) == "Dummy" and IsItemInRange(32321, unitID))) then
                    totalmobsincombat = totalmobsincombat + 1
                end
            end
        
            return totalmobsincombat
        end



local function APL()
    combatmobs40()
    stunprio()
    kickprio()

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

        local level, affixIDs, wasEnergized = C_ChallengeMode.GetActiveKeystoneInfo()

     
        tarSpeed, _, _, _ = GetUnitSpeed('target')
        consecrationdrop = Target:IsInRange(8) and
        (Player:MovingFor() <= Player:GCD() or ( tarSpeed == 0))

    
        -- Spell Queue
        if Player:IsChanneling() or Player:IsCasting() then
        return 0, "Interface\\Addons\\Rubim-RH\\Media\\channel.tga"
        end



--item ids for wotlk range checks with nameplate
--<5 37727
--<8 34368
--<10 32321
--<15 33069
--<20 10645
--<25 13289
--<30 835
--<35 18904
--<40 4945 -- check

        IsTanking = Player:IsTankingAoE(8) or Player:IsTanking(Target)
        HPpercentloss = MyHealthTracker.GetPredictedHealthLoss() * 3


        validmobsinrange8y = combatmobs40() * .7
        validmobsinrange15y = combatmobs40() * .7
    
    
        if Enemies8y > validmobsinrange8y and combatmobs40() > 0 then
            aoecds8y = true
        else
            aoecds8y = false
        end
    

        
        if Enemies15y > validmobsinrange15y and combatmobs40() > 0 then
            aoecds15y = true
        else
            aoecds15y = false
        end
    
-- print('total mobs in 8y range:', Enemies8y)
-- print('70% mobs 40y in combat:',validmobsinrange8y)

local startTimeMS = select(4, UnitCastingInfo('target')) or 0
local currentTimeMS = GetTime() * 1000
local elapsedTimeca = (startTimeMS > 0) and (currentTimeMS - startTimeMS) or 0
castTime = elapsedTimeca / 1000
local startTimeMS = select(4, UnitCastingInfo('target')) or select(4, UnitChannelInfo('target')) or 0
local currentTimeMS = GetTime() * 1000
local elapsedTimech = (startTimeMS > 0) and (currentTimeMS - startTimeMS) or 0
channelTime = elapsedTimech/1000



        if Player:HealthPercentage() <= 25 and Player:AffectingCombat() and (IsUsableItem(191379) or IsUsableItem(191378)  or IsUsableItem(191380)) 
        and (GetItemCooldown(191380) == 0 or GetItemCooldown(191379) == 0 or GetItemCooldown(191378) == 0) 
        and (GetItemCount(191380) >= 1 or GetItemCount(191379) >= 1 or GetItemCount(191378) >= 1) 
        and (not Player:InArena() and not Player:InBattlegrounds()) then
        return I.HPIcon:Cast()
        end



        if S.lustAT:ID() == RubimRH.queuedSpell[1]:ID() and not Player:Debuff(S.lust1) and not Player:Debuff(S.lust2) and
        not Player:Debuff(S.lust3) and not Player:Debuff(S.lust4) and not Player:Debuff(S.lust5) and (I.drums:IsReady()) then
        return S.lustAT:Cast() -- BIND LUST KEYBIND IN BINDPAD TO ARCANE TORRENT
        end

        if S.lustAT:ID() == RubimRH.queuedSpell[1]:ID() and
        (
        Player:Debuff(S.lust1) or Player:Debuff(S.lust2) or Player:Debuff(S.lust3) or Player:Debuff(S.lust4) or
        Player:Debuff(S.lust5)) then
        RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
        end



        if RubimRH.QueuedSpell():IsReadyQueue() then
        return RubimRH.QueuedSpell():Cast()
        end

        if not RubimRH.queuedSpell[1]:CooldownUp() 
        or Cache.EnemiesCount[20] == 0 
        or not Player:AffectingCombat()
        then
        RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
        end


        if IsUsableSpell('Raise Dead') and S.RaiseDead:CooldownRemains()==0
        and (UnitExists("pet") ==false or UnitIsDeadOrGhost("pet")==true) then
            return S.RaiseDead:Cast()
        end

        if Target:AffectingCombat() or Player:AffectingCombat() and Player:CanAttack(Target) then 


        if not IsCurrentSpell(6603) and Player:CanAttack(Target) and not Target:IsDeadOrGhost()
        and Target:AffectingCombat() and Target:IsInRange(20) then
        return S.autoattack:Cast()
        end

        if RubimRH.CDsON() and Target:IsInRange(5)
        and not Target:IsDeadOrGhost() and Player:CanAttack(Target) and Player:AffectingCombat() then
        local ShouldReturn = UseItems();
        if ShouldReturn then return ShouldReturn; end
        end


        -- if S.HammerofWrath:IsReady() and UnitName('target') == 'Explosives' then
        -- return S.HammerofWrath:Cast()
        -- end

        -- if S.Judgment:IsReady() and UnitName('target') == 'Explosives' then
        -- return S.Judgment:Cast()
        -- end

        -- if (IsUsableSpell("Templar Slash") or S.TemplarStrike:IsReady() or S.CrusaderStrike:IsReady()) and UnitName('target') == 'Explosives' then
        -- return S.crusaderstrike:Cast()
        -- end

                -- --Kick
                if (castTime > 0.1 or channelTime > 0.1)
                and select(8, UnitCastingInfo("target")) == false and
                RubimRH.InterruptsON() and S.MindFreeze:IsReady(8) and Player:AffectingCombat() then
                return S.MindFreeze:Cast()
            end

                -- --Stun

                -- if (castTime>0.1 or channelTime>0.1) and level>13 
                -- and RubimRH.InterruptsON() and S.HammerofJustice:IsReady(10) and Player:AffectingCombat() and stunprio() then
                -- return S.HammerofJustice:Cast()
                -- end

                --     end


                  
                if HL.CombatTime() < 10 and Enemies12y>=1 then
                    if S.UnholyBlight:IsReady() and not Target:Debuff(S.VirulentPlague) then
                        return S.UnholyBlight:Cast()
                    end
            
                    if S.Outbreak:IsReady() and not Target:Debuff(S.VirulentPlague) then
                        return S.Outbreak:Cast()
                    end
            
                    if S.FesteringStrike:IsReady() then
                        return S.FesteringStrike:Cast()
                    end
            
                    if S.AbominationLimb:IsReady() then
                        return S.AbominationLimb:Cast()
                    end
            
                    if S.Defile:IsReady() and aoecds8y then
                        return S.Defile:Cast()
                    end
            
                    if S.SummonGargoyle:IsReady() and Player:UsePotion() then
                        return S.SummonGargoyle:Cast()
                    end
            
                    if S.DarkTransformation:IsReady() then
                        return S.DarkTransformation:Cast()
                    end
            
                    if S.DeathCoil:IsReady() and Player:RunicPower() >= 40 then
                        return S.DeathCoil:Cast()
                    end
            
                    if S.UnholyAssault:IsReady() then
                        return S.UnholyAssault:Cast()
                    end
            
                    if S.FesteringStrike:IsReady() then
                        return S.FesteringStrike:Cast()
                    end
            
                    if S.EmpowerRuneWeapon:IsReady() then
                        return S.EmpowerRuneWeapon:Cast()
                    end
            
                    if S.Apocalypse:IsReady() then
                        return S.Apocalypse:Cast()
                    end
                end


                --AOE

                if Enemies15y>=2 then
                    

                        -- Epidemic for AoE damage
                        if S.Epidemic:IsReady() and Enemies10y >= 4 then
                            return S.Epidemic:Cast()
                        end
                    
                        -- Death and Decay for AoE damage
                        if S.DeathAndDecay:IsReady() and aoecds8y then
                            return S.DeathAndDecay:Cast()
                        end
                    
                        -- Scourge Strike if standing in Death and Decay
                        if Player:Buff(S.DeathAndDecayBuff) and S.ScourgeStrike:IsReady() then
                            return S.ScourgeStrike:Cast()
                        end
                    
                        -- Festering Strike if Festering Wound stacks are low
                        if Target:DebuffStack(S.FesteringWound) < 1 and S.FesteringStrike:IsReady() then
                            return S.FesteringStrike:Cast()
                        end
                    
                        -- Maintain Virulent Plague
                        if not Target:Debuff(S.VirulentPlague) and (S.Outbreak:IsReady() or S.UnholyBlight:IsReady()) then
                            if S.UnholyBlight:IsReady() then
                                return S.UnholyBlight:Cast()
                            else
                                return S.Outbreak:Cast()
                            end
                        end
                    
                        -- Disease rotation
                        if S.Plaguebringer:IsReady() and Player:Buff(S.PlaguebringerBuff) then
                            if S.DarkTransformation:IsReady() then
                                return S.DarkTransformation:Cast()
                            end
                    
                            if S.AbominationLimb:IsReady() then
                                return S.AbominationLimb:Cast()
                            end
                    
                            if S.UnholyAssault:IsReady() then
                                return S.UnholyAssault:Cast()
                            end
                    
                            if S.SoulReaper:IsReady() and Target:HealthPercentage() < 35 then
                                return S.SoulReaper:Cast()
                            end
                    
                            if S.ScourgeStrike:IsReady() and Target:DebuffStack(S.FesteringWound) >= 1 then
                                return S.ScourgeStrike:Cast()
                            end
                        end
                    
                        -- Wound rotation
                        if S.BurstingSores:IsReady() then
                            if S.Apocalypse:IsReady() and Target:DebuffStack(S.FesteringWound) >= 4 then
                                return S.Apocalypse:Cast()
                            end
                    
                            if S.ScourgeStrike:IsReady() and Target:DebuffStack(S.FesteringWound) >= 1 then
                                return S.ScourgeStrike:Cast()
                            end
                    
                            if S.FesteringStrike:IsReady() and Target:DebuffStack(S.FesteringWound) < 4 then
                                return S.FesteringStrike:Cast()
                            end
                        end
                    
                        -- Death Coil if Runic Power is high
                        if Player:RunicPower() >= 80 and S.DeathCoil:IsReady() then
                            return S.DeathCoil:Cast()
                        end



                end





                
                    --ST
                if Enemies12y<2 then
                                -- Maintain Virulent Plague
                    if not Target:Debuff(S.VirulentPlague) and (S.Outbreak:IsReady() or S.UnholyBlight:IsReady()) then
                        if S.UnholyBlight:IsReady() then
                            return S.UnholyBlight:Cast()
                        else
                            return S.Outbreak:Cast()
                        end
                    end

                    -- Dark Transformation
                    if S.DarkTransformation:IsReady() then
                        return S.DarkTransformation:Cast()
                    end

                    -- Abomination Limb
                    if S.AbominationLimb:IsReady() then
                        return S.AbominationLimb:Cast()
                    end

                    -- Unholy Assault
                    if S.UnholyAssault:IsReady() then
                        return S.UnholyAssault:Cast()
                    end

                    -- Apocalypse with 4 or more Festering Wound stacks
                    if S.Apocalypse:IsReady() and Target:DebuffStack(S.FesteringWound) >= 4 then
                        return S.Apocalypse:Cast()
                    end

                    -- Soul Reaper if target's health is below 35%
                    if S.SoulReaper:IsReady() and Target:HealthPercentage() < 35 then
                        return S.SoulReaper:Cast()
                    end

                    -- Defile if Mastery Buff is about to expire or charges are capped
                    if S.Defile:IsReady() and 
                    (
                        -- Player:BuffRemains(S.MasteryBuff) <= 1.5 or --change to trinket
                    S.Defile:Charges() == 2 and aoecds8y
                    ) 
                    then
                        return S.Defile:Cast()
                    end

                    -- Scourge Strike if Festering Wound is present
                    if S.ScourgeStrike:IsReady() and Target:DebuffStack(S.FesteringWound) >= 1 then
                        return S.ScourgeStrike:Cast()
                    end

                    -- Festering Strike if Festering Wound stacks are low
                    if S.FesteringStrike:IsReady() and Target:DebuffStack(S.FesteringWound) < 4 then
                        return S.FesteringStrike:Cast()
                    end

                    -- Death Coil if Runic Power is high
                    if Player:RunicPower() >= 80 and S.DeathCoil:IsReady() then
                        return S.DeathCoil:Cast()
                    end    


                
                end







            end

            -- Out of Combat
            if not Player:AffectingCombat() then

                if RubimRH.QueuedSpell():IsReadyQueue() then
                return RubimRH.QueuedSpell():Cast()
                end

                if not RubimRH.queuedSpell[1]:CooldownUp() 
                or Cache.EnemiesCount[20] == 0 
                or not Player:AffectingCombat()
                then
                RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
                end





            return 0, "Interface\\Addons\\Rubim-RH\\Media\\griph.tga"
            end

    return 0, 135328
end -- end APL

RubimRH.Rotation.SetAPL(252, APL);

local function PASSIVE()

end

RubimRH.Rotation.SetPASSIVE(252, PASSIVE);
