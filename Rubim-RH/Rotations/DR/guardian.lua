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

if not Spell.Druid then
    Spell.Druid = {};
end


RubimRH.Spell[104] = {
    lust1 = Spell(57724),
    lust2 = Spell(57723),
    lust3 = Spell(80354),
    lust4 = Spell(95809),
    lust5 = Spell(264689),
    lustAT = Spell(155145),


   autoattack = Spell(291944), --regeneratin
-- Racials

Typhoon = Spell(132469),
StampedingRoar = Spell(77761),
Rebirth = Spell(20484),
Berserking                            = Spell(26297),
Shadowmeld                            = Spell(58984),
-- Abilities
Barkskin                              = Spell(22812),
BearForm                              = Spell(5487),
CatForm                               = Spell(768),
FerociousBite                         = Spell(22568),
MarkoftheWild                         = Spell(1126),
Moonfire                              = Spell(8921),
Prowl                                 = Spell(5215),
Shred                                 = Spell(5221),
Dash = Spell(1850),
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
Thrash = Spell(77758),
Swipe = Spell(213771),
ThrashDebuff = Spell(192090),
-- Thrash = MultiSpell(777589,106830),
-- ThrashCat = Spell(106830),
-- Swipe = MultiSpell(213771,106785),
-- SwipeCat = Spell(106785),
Vortex = Spell(102793),
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
-- Other
Soothe = Spell(2908),
Renewal = Spell(108238),
 -- Abilities
 Mangle                                = Spell(33917),
 -- Talents
 Berserk                               = Spell(50334),
 BristlingFur                          = Spell(155835),
 Maul                                  = Spell(6807),
 Incarnation                           = Spell(102558),
 Pulverize                             = Spell(80313),
 RageoftheSleeper                      = Spell(200851),
 SouloftheForest                       = Spell(158477),
 ViciousCycle                          = Spell(371999),
 -- Buffs
 BerserkBuff                           = Spell(50334),
 GalacticGuardianBuff                  = Spell(213708),
 GoreBuff                              = Spell(93662),
 IncarnationBuff                       = Spell(102558),
 ToothandClawBuff                      = Spell(135286),
 ViciousCycleMaulBuff                  = Spell(372015),
 ViciousCycleMangleBuff                = Spell(372019),
 -- Debuffs
 ToothandClawDebuff                    = Spell(135601),
IncapacitatingRoar = Spell(99),

}

local S = RubimRH.Spell[104]

if not Item.Druid then Item.Druid = {}; end

Item.Druid.Guardian = {
    trink2 = Item(184016, { 13, 14 }), --Skulker's Wing
    trink = Item(179350, { 13, 14 }), --???
    lust = Item(164978), --drums of fury
    HPIcon = Item(169451),
    tx1 = Item(118330),
    tx2 = Item(114616),
};

local I = Item.Druid.Guardian;




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


    -- use_items
    if RubimRH.CDsON() and Target:IsInRange(8) then
        local ShouldReturn = UseItems();
        if ShouldReturn then return ShouldReturn; end
    end


Swipe = IsUsableSpell('Swipe') and S.Swipe:CooldownUp()
Thrash = IsUsableSpell('Thrash') and S.Thrash:CooldownUp()

    --------------------------------------------------------------------------------------------------------------------------------------------
    ----------------------------------------------------------Interrupts/Queues-----------------------------------------------------------------
    --------------------------------------------------------------------------------------------------------------------------------------------

    if select(8, UnitCastingInfo("target")) == false and Target:CastPercentage() > math.random(32, 87) and Target:IsInRange(5) 
    and S.ConvoketheSpirits:CooldownRemains()<58 and not S.ConvoketheSpirits:CooldownUp() and not Player:Buff(S.Prowl) and
        RubimRH.InterruptsON() and S.SkullBash:IsReadyQueue(15) and Player:AffectingCombat() then
        return S.SkullBash:Cast()
    end

    if (
        select(4, UnitAura("target", 1)) == "" and RubimRH.InterruptsON() and Target:TimeToDie()>3 and S.Soothe:IsCastableQueue(40) and
            Player:AffectingCombat() and Target:TimeToDie() > 4) then
        return S.Soothe:Cast()
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


    --------------------------------------------------------------------------------------------------------------------------------------------
    ----------------------------------------------------------Defensives/Pots-------------------------------------------------------------------
    --------------------------------------------------------------------------------------------------------------------------------------------


    IsTanking = (Player:IsTankingAoE(8) or Player:IsTanking(Target))

    if Player:HealthPercentage() <= 25 and Player:AffectingCombat() and (IsUsableItem(191379) or IsUsableItem(191378)  or IsUsableItem(191380)) and
    (GetItemCooldown(191380) == 0 or GetItemCooldown(191379) == 0 or GetItemCooldown(191378) == 0) and (GetItemCount(191380) >= 1 or GetItemCount(191379) >= 1 or GetItemCount(191378) >= 1)
    and (not Player:InArena() and not Player:InBattlegrounds()) then
    return I.HPIcon:Cast()
    end


        if S.FrenziedRegeneration:IsCastable() and RubimRH.CDsON() and (Player:HealthPercentage()<77 and Player:NeedPanicHealing() or Player:HealthPercentage()<67) and not Player:Buff(S.FrenziedRegenerationBuff) then 
            return S.FrenziedRegeneration:Cast()
        end

        if S.SurvivalInstincts:IsCastable() and RubimRH.CDsON() and (Player:HealthPercentage()<75 and Player:NeedPanicHealing() or Player:HealthPercentage()<60) and not Player:Buff(S.Barkskin) then 
            return S.SurvivalInstincts:Cast()
        end

        if S.Barkskin:IsCastable() and RubimRH.CDsON() and (Player:HealthPercentage()<83 and Player:NeedPanicHealing() or Player:HealthPercentage()<73) and not Player:Buff(S.SurvivalInstincts) then 
            return S.Barkskin:Cast()
        end

        if S.Renewal:IsCastable() and RubimRH.CDsON() and Player:HealthPercentage()<40 
        --  and S.FrenziedRegeneration:Charges()<1
          then 
            return S.Renewal:Cast()
        end

-- print( Target:DebuffStack(S.ThrashDebuff))


-- print( RubimRH.incdmg5secs(Player))



--0 regular/no shapeshift
--1 bear
--2 cat
--3 travel/bird form
--4 moonkin
--5

        if S.MarkoftheWild:IsCastable() and Player:BuffRemains(S.MarkoftheWildBuff)<300 then 
            return S.MarkoftheWild:Cast()
        end
-- print(GetShapeshiftForm())

            -- Ensure you are in  Bear Form
            if S.BearForm:IsCastable() and not Player:Buff(S.BearForm) and Enemies20y >=1 
            and (IsResting("player") == false or Player:CanAttack(Target)) 
            and (not Player:IsMounted() and GetShapeshiftForm() ~= 3 and GetShapeshiftForm() ~= 5
            and (GetShapeshiftForm()==2 
            and not Player:Buff(S.Dash) 
            or GetShapeshiftForm()==2 
            and Enemies12y>=1
            or GetShapeshiftForm()~=2)) 
            then 
                return S.BearForm:Cast()
            end

    --------------------------------------------------------------------------------------------------------------------------------------------
    ----------------------------------------------------------StartRotation---------------------------------------------------------------------
    --------------------------------------------------------------------------------------------------------------------------------------------

    if Target:Exists() and Player:CanAttack(Target) and not Target:IsDeadOrGhost() then

        if not IsCurrentSpell(6603) and Player:CanAttack(Target)
        and Target:AffectingCombat() and Target:IsInRange(20) then
        return S.autoattack:Cast()
        end

            if  Target:IsInRange(8) and RubimRH.CDsON() then
                local ShouldReturn = UseItems();
                if ShouldReturn then return ShouldReturn; end
            end



            -- Ensure you are in  Bear Form
            if S.BearForm:IsCastable() and not Player:Buff(S.BearForm) and Enemies20y >=1 
            and (IsResting("player") == false or Player:CanAttack(Target)) 
            and (not Player:IsMounted() and GetShapeshiftForm() ~= 3 and GetShapeshiftForm() ~= 5
            and (GetShapeshiftForm()==2 
            and not Player:Buff(S.Dash) 
            or GetShapeshiftForm()==2 
            and Enemies12y>=1
            or GetShapeshiftForm()~=2)) 
            then 
                return S.BearForm:Cast()
            end

            if S.Berserking:IsCastable() and RubimRH.CDsON() and Target:IsInRange(10) then
                return S.Berserking:Cast()
            end 

            -- Cast  Rage of the Sleeper on cooldown
            if S.RageoftheSleeper:IsCastable() and RubimRH.CDsON() and Target:IsInRange(10) then
                return S.RageoftheSleeper:Cast()
            end 

            -- Cast  Heart of the Wild on cooldown
            if S.HeartoftheWild:IsCastable() and RubimRH.CDsON() and Target:IsInRange(10) then
                return S.HeartoftheWild:Cast()
            end 

            -- Cast  Convoke the Spirits on cooldown
            if S.ConvoketheSpirits:IsCastable() and RubimRH.CDsON() and Target:IsInRange(10) then
                return S.ConvoketheSpirits:Cast()
            end 

            -- Cast  Convoke the Spirits on cooldown
            if S.Incarnation:IsCastable() and RubimRH.CDsON() and Target:IsInRange(10) then
                return S.Incarnation:Cast()
            end 

            -- Cast  Berserk on cooldown
            if S.Berserk:IsCastable() and RubimRH.CDsON() and Target:IsInRange(10) then
                return S.Berserk:Cast()
            end 

            
            -- Maintain 100%  Moonfire uptime
            if S.Moonfire:IsCastable() and Target:IsInRange(40) and (Target:DebuffRemains(S.MoonfireDebuff)<Player:GCD() or Player:Buff(S.GalacticGuardianBuff) and Enemies12y<5) then
                return S.Moonfire:Cast()
            end

            -- Spend rage on either  Ironfur (defensively) or  Maul (offensively) to avoid capping
            if S.Ironfur:IsCastable() and Player:Rage()>40
            and (Player:BuffStack(S.IronfurBuff)<1 
            or Player:HealthPercentage()<80 and Player:BuffStack(S.IronfurBuff)<2)  
            and Enemies12y>=1 
            then
                return S.Ironfur:Cast()
            end

            if S.Maul:IsReady(10) and Player:Rage()>=85 and Enemies12y<5 then
                return S.Maul:Cast()
            end

            -- Cast  Thrash on cooldown
            if Thrash and Enemies12y>=1 and Target:DebuffStack(S.ThrashDebuff)<3  then
                return S.Thrash:Cast()
            end

            if S.Maul:IsReady(10) and Player:Buff(S.ToothandClawBuff) then
                return S.Maul:Cast()
            end

            -- Cast  Mangle on cooldown
            if S.Mangle:IsCastable() and Target:IsInRange(10) and Enemies12y<4 then
                return S.Mangle:Cast()
            end




            -- Cast  Thrash on cooldown
            if Thrash and Enemies12y>=1 then
                return S.Thrash:Cast()
            end



            if S.Maul:IsReady(10) then
                return S.Maul:Cast()
            end

            -- Fill empty GCDs with  Swipe on AoE and  Moonfire on Single target
            if S.Moonfire:IsCastable() and Target:IsInRange(40) and (Enemies12y==1 or not RubimRH.AoEON()) then
                return S.Moonfire:Cast()
            end

            if Swipe and Enemies12y>1 and RubimRH.AoEON() and Target:IsInRange(10) then
                return S.Swipe:Cast()
            end


      --Out of range

    if Target:IsInRange(40) and not Target:IsInRange(12) then
        if S.Moonfire:IsCastable() then
            return S.Moonfire:Cast()
        end



    end --end Out of range


        if Player:AffectingCombat() then
            return 0, 135328
        end
         
    
    end -- end combat



    return 0, "Interface\\Addons\\Rubim-RH\\Media\\griph.tga"
end

RubimRH.Rotation.SetAPL(104, APL);

local function PASSIVE()

end

RubimRH.Rotation.SetPASSIVE(104, PASSIVE);
