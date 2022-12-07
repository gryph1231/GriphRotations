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

if not Spell.Evoker then
    Spell.Evoker = {};
end


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------SPELLS/ITEMS-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



RubimRH.Spell[1467] = {
  -- Racials
  TailSwipe                             = Spell(368970),
  WingBuffet                            = Spell(357214),
  -- Abilities
  AzureStrike                           = Spell(362969),
  BlessingoftheBronze                   = Spell(364342),
  DeepBreath                            = Spell(357210),
  Disintegrate                          = Spell(356995),
  FireBreath                            = Spell(357208), -- with and without Font of Magic
  LivingFlame                           = Spell(361469),
  -- Talents
  BlastFurnace                          = Spell(375510),
  ObsidianScales                        = Spell(363916),
  TipTheScales                          = Spell(370553),
  -- Buffs/Debuffs
  BlessingoftheBronzeBuff               = Spell(381748),
  FireBreathDebuff                      = Spell(357209),
  LeapingFlamesBuff                     = Spell(370901),
  -- External Buffs
  PowerInfusionBuff                     = Spell(10060),
  -- Utility
  Quell                                 = Spell(351338),
  -- Covenant
  BoonoftheCovenants                    = Spell(387168),
  -- Other
  Pool                                  = Spell(999910),

  Animosity                             = Spell(375797),
  ArcaneVigor                           = Spell(386342),
  Burnout                               = Spell(375801),
  Causality                             = Spell(375777),
  ChargedBlast                          = Spell(370455),
  Dragonrage                            = Spell(375087),
  EngulfingBlaze                        = Spell(370837),
  EssenceAttunement                     = Spell(375722),
  EternitySurge                         = Spell(359073), -- with and without Font of Magic
  EternitysSpan                         = Spell(375757),
  EverburningFlame                      = Spell(370819),
  FeedtheFlames                         = Spell(369846),
  Firestorm                             = Spell(368847),
  FontofMagic                           = Spell(375783),
  Pyre                                  = Spell(357211),
  RubyEmbers                            = Spell(365937),
  Scintillation                         = Spell(370821),
  ShatteringStar                        = Spell(370452),
  Snapfire                              = Spell(370783),
  Tyranny                               = Spell(376888),
  Volatility                            = Spell(369089),
  -- Buffs
  BurnoutBuff                           = Spell(375802),
  ChargedBlastBuff                      = Spell(370454),
  EssenceBurstBuff                      = Spell(359618),
  SnapfireBuff                          = Spell(370818),
  -- Debuffs
  LivingFlameDebuff                     = Spell(361500),




}






local S = RubimRH.Spell[1467] 


if not Item.Evoker then Item.Evoker = {}; end
Item.Evoker.Balance = {
    HPIcon = Item(169451),
    tx1 = Item(118330),
    tx2 = Item(114616),

	
};
local I = Item.Evoker.Balance;




-- Rotation Var
local ShouldReturn; -- Used to get the return string

-- Variables

local EnemyRanges = { 40 }
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
    return val
end

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

	HL.GetEnemies("Melee");
	HL.GetEnemies(5, true);
    HL.GetEnemies(8, true);
    HL.GetEnemies(10, true);
	HL.GetEnemies(15, true);
	HL.GetEnemies(20, true);
	HL.GetEnemies(25, true);
	HL.GetEnemies(30, true);
	HL.GetEnemies(35, true);
	HL.GetEnemies(40, true);

    LeftCtrl = IsLeftControlKeyDown();
    LeftShift = IsLeftShiftKeyDown();
    LeftAlt = IsLeftAltKeyDown();




    IsTanking = Player:IsTankingAoE(8) or Player:IsTanking(Target)

    if Player:HealthPercentage() <= 25 and Player:AffectingCombat() and IsUsableItem(191380) and
        GetItemCooldown(191380) == 0 and GetItemCount(191380) >= 1
        and (not Player:InArena() and not Player:InBattlegrounds()) then
        return I.HPIcon:Cast()
end




if Player:IsCasting() or Player:IsChanneling() and not Player:IsChanneling(S.SpinningCraneKick) then
    return 0, "Interface\\Addons\\Rubim-RH\\Media\\channel.tga"
elseif Player:IsDeadOrGhost() or AuraUtil.FindAuraByName("Drink", "player") or
    AuraUtil.FindAuraByName("Food", "player") or AuraUtil.FindAuraByName("Food & Drink", "player") then
    return 0, "Interface\\Addons\\Rubim-RH\\Media\\griph.tga"
end

	
		if S.lustAT:ID() ==  RubimRH.queuedSpell[1]:ID() and not Player:Debuff(S.lust1) and not Player:Debuff(S.lust2) and not Player:Debuff(S.lust3) and not Player:Debuff(S.lust4) and not Player:Debuff(S.lust5) then
    	return S.lustAT:Cast() -- BIND LUST KEYBIND IN BINDPAD TO ARCANE TORRENT
	end
	
	if S.lustAT:ID() ==  RubimRH.queuedSpell[1]:ID() and (Player:Debuff(S.lust1) or Player:Debuff(S.lust2) or Player:Debuff(S.lust3) or Player:Debuff(S.lust4) or Player:Debuff(S.lust5)) then
		RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
	end
	
	
	if not RubimRH.queuedSpell[1]:CooldownUp() or not Player:AffectingCombat() then
		RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
	end
	

	if RubimRH.QueuedSpell():IsReadyQueue() then
        return RubimRH.QueuedSpell():Cast()
    end
	
	
	

	



	
if Player:CanAttack(Target) and Target:AffectingCombat() or (Player:AffectingCombat() or Target:IsDummy()) then 

    if  Target:IsInRange(8) then
        local ShouldReturn = UseItems();
        if ShouldReturn then return ShouldReturn; end
    end





--- opener



-- In this Dragonflight rotation guide, we provide the best Devastation Evoker rotation for for all talent builds in both dungeons and raids for the Dragonflight Launch.
-- NEW Dragonflight
-- NEW Infographic
-- Overview
-- Gear
-- Talent Builds
-- Abilities & Talents
-- Rotation
-- Stats
-- Consumables
-- Macros & Addons
-- WeakAuras
-- Common Terms
-- Common Questions
-- Leveling
-- Hotfixes
-- About the Author

-- This guide is written and maintained by Preheat, previously a World First raider and founding member of Liquid. Preheat plays Evoker and Mage and has participated in the MDI and multiple Race to World First events over the years. He has also commentated multiple community events such as the Keystone Masters, numerous charity events, and the Team Liquid Race to World First. For all things Evoker and Mage, you can find him in his Discord, on Twitter, posting videos to YouTube, and streaming on Twitch.


-- A note from the Author
-- Devastation Evoker Rotations in Dragonflight
-- In the simplest terms, Devastation Evoker primarily deals damage by applying  Fire Breath to deal damage over time, spending Essence and  Essence Burst on  Disintegrate, and casting  Living Flame as filler.  Dragonrage is the primary cooldown and  Eternity Surge is a short cooldown that deals heavy damage, increasing in targets as you empower it.
-- Devastation Evoker Rotation Basics
-- There are two main builds for Devastation Evoker:  Feed the Flames and  Everburning Flame.  Everburning Flame uses  Firestorm in single target, which makes it very prone to losing damage when a target moves. For this reason, I only recommend it for sustained cleave. The aim of both builds is to maintain the  Fire Breath damage over time on the enemy while spending Essence on  Disintegrate.

-- The overall rotation of both builds can be oversimplified as the following steps:
-- Use  Dragonrage
-- Maintain  Fire Breath damage over time on the enemy. Use  Fire Breath on cooldown.
-- Use  Shattering Star to amplify  Eternity Surge (when it lines up) and  Disintegrate.
-- Use  Eternity Surge on cooldown.
-- In AoE: Spend  Essence Burst and Essence on  Pyre.
-- In Single Target / Cleave: Spend  Essence Burst and Essence on  Disintegrate.
-- Generate  Essence Burst while waiting on Essence (Two sources for  Essence Burst:  Living Flame,  Azure Strike)
-- Note: In some cases you will want to delay your first use of  Dragonrage. More information on this later.
-- Devastation Evoker Opener
-- The rotations below are based off of the  Feed the Flames Cooldown Reduction Build. To see the rotation for the  Everburning Flame Build, select the associated toggle.
-- Devastation Evoker Opener Rotation
-- Alternate Talent Builds:
-- Everburning Flame Fire Breath Extension Build
-- Individual Talent Changes:
-- No  Shattering Star
-- Precast  Living Flame
-- Precast  Firestorm
-- Use normal rotation if delaying  Dragonrage (See Single Target Rotation and Priority)
-- Use  Dragonrage with trinkets.
-- Without  Bloodlust, your first  Dragonrage of the fight should be delayed as long as possible without losing a usage during the encounter.
-- Rank 1 Empower  Fire Breath. For the duration of  Dragonrage, Empower  Fire Breath at rank 1 on cooldown
-- Rank 3 Empower  Fire Breath. For the duration of  Dragonrage, Empower  Fire Breath at rank 3 on cooldown
--  Firestorm on cooldown regardless of  Snapfire procs if  Fire Breath will remain on the target by the time the cast finishes, unless the  Fire Breath damage over time will last until the next  Fire Breath cooldown is available. Basically we just want enough extensions to last until the next  Fire Breath.
--  Shattering Star to apply the damage increase debuff on cooldown. During  Dragonrage and  Bloodlust, hold it until you have enough Essence and  Essence Burst to chain 3  Disintegrate casts or  Eternity Surge and 2  Disintegrate casts.
--  Tip the Scales - Instant  Fire Breath (Can be delayed for the 2nd  Fire Breath as needed to fit it inside of  Dragonrage)
--  Tip the Scales - Instant  Eternity Surge (Can be delayed for the 2nd  Eternity Surge as needed to fit it inside of  Dragonrage)
--  Disintegrate with  Essence Burst. Use up all  Essence Burst procs. You can cast  Disintegrate again after the 3rd tick of  Disintegrate to overlap them without losing damage
--  Disintegrate if Essence is capped or nearing cap. You can cast  Disintegrate again after the 3rd tick of  Disintegrate to overlap them without losing damage.
-- Instant cast  Living Flame with  Burnout to gain  Essence Burst if not capped on Essence and  Essence Burst to gain  Essence Burst
-- Without  Burnout, use  Azure Strike to gain  Essence Burst
-- Cast  Living Flame to gain  Essence Burst when  Burnout is unavailable ( Azure Strike instead if talented into  Engulfing Blaze)
-- At this point, things repeat during  Dragonrage
-- In the last 2 seconds of  Dragonrage, use  Burnout procs or  Azure Strike to exit with 2 stacks of  Essence Burst
-- Proceed with normal rotation when  Dragonrage fades




--aoe




    -- Everburning Flame Fire Breath Extension Build
    -- Individual Talent Changes:
    -- No  Shattering Star
    -- No  Volatility
    -- In preparation for AoE, try to quickly build  Charged Blast stacks with  Disintegrate and  Azure Strike.
    -- Use  Dragonrage with stacks of  Charged Blast depending on the length of the pull, it can be worthwhile to hold until 18+ stacks of  Charged Blast.
    -- Empower  Fire Breath on cooldown. Empower rank depends on target count and how long targets will live. Generally speaking, you can use Rank 1 for 1-2 targets Rank 2 for 3 targets, Rank 3 for 4 targets, Rank 3 (or 4 with  Font of Magic) for 5 targets. For more information, click here.
    -- Rank 3 Empower  Fire Breath on cooldown
    --  Firestorm on cooldown regardless of  Snapfire procs if  Fire Breath will remain on the target by the time the cast finishes, unless the  Fire Breath damage over time will last until the next  Fire Breath cooldown is available
    --  Deep Breath at 2 or more targets. Delay your first use for when the lowest target reaches 30% or less health, so long as you get the same amount of total uses since  Tyranny makes it get the full effect of  Mastery: Giantkiller.
    --  Shattering Star to apply the damage increase debuff on cooldown
    -- Empower  Eternity Surge on cooldown. Empower level depends on targets within 12 yards of the target:
    --  Eternity Surge at Rank 2 for 3-4 targets - With  Eternity's Span
    --  Eternity Surge at Rank 3 for 5-6 targets - With  Eternity's Span
    --  Eternity Surge at Rank 4 for 7 or more targets - With  Eternity's Span
    -- Instant cast  Living Flame with  Burnout and  Leaping Flames if  Essence Burst is not capped at 2 stacks. In  Dragonrage, spend all  Essence Burst and use Essence to give yourself time to avoid capping because  Leaping Flames will provide 2  Essence Bursts.
    -- Use  Pyre in AoE with  Volatility:
    -- At 2 targets: Spend  Essence Burst and Essence on  Pyre with >=16  Charged Blast stacks (20 outside of  Dragonrage).
    -- At 3 targets: Spend  Essence Burst and Essence on  Pyre full time.
    -- Use  Pyre in AoE without  Volatility:
    -- At 3 targets: Spend  Essence Burst and Essence on  Pyre with >=10  Charged Blast stacks.
    -- At 4 targets: Spend  Essence Burst and Essence on  Pyre full time.
    -- Spend  Essence Burst and Essence on  Disintegrate at 2 targets.  Disintegrate high health targets (targets with 50-60% higher health percent than the average health percent of the pack) to make use of  Mastery: Giantkiller and gain  Charged Blast stacks
    -- At 3 or less targets: Instant cast  Living Flame with  Burnout
    -- At 3 or more targets: Cast  Azure Strike with  Protracted Talons
    -- When  Dragonrage is available in less than 10 seconds, stop casting  Pyre. For 3 or more targets, always build 18+ stacks of  Charged Blast for  Dragonrage
    -- When the pull is wrapping up (last 8 or so seconds of AoE), fully empower  Fire Breath to increase the upfront damage at the cost of damage over time.
    -- Avoid casting  Living Flame to save  Leaping Flames for the next pull, if it is happening in 30 seconds or less.
    -- Avoid casting  Pyre to save  Charged Blast for the next pull, if it is happening in 60 seconds or less.








--ST





-- Everburning Flame Fire Breath Extension Build
-- Individual Talent Changes:
-- No  Shattering Star
-- Rank 1 Empower  Fire Breath on cooldown, as long as  Dragonrage cooldown is longer than 10 seconds.
-- Rank 3 Empower  Fire Breath on cooldown, as long as  Dragonrage cooldown is longer than 10 seconds.
--  Firestorm on cooldown regardless of  Snapfire procs if  Fire Breath will remain on the target by the time the cast finishes, unless the  Fire Breath damage over time will last until the next  Fire Breath cooldown is available
--  Shattering Star to apply the damage increase debuff on cooldown
-- Empower  Eternity Surge at rank 1 on cooldown, as long as  Dragonrage cooldown is longer than 15 seconds.
-- Instant cast  Living Flame with  Burnout. Avoid capping Essence and  Essence Burst over  Burnout
-- Spend Essence and  Essence Burst on  Disintegrate. You can cast  Disintegrate again after the 3rd tick of  Disintegrate to overlap them without losing damage
-- Cast  Living Flame
-- Use  Azure Strike on the move
-- Use  Dragonrage when  Fire Breath and  Eternity Surge are ready, or if the fight has less than 30 seconds left. See opener for  Dragonrage rotation
-- Devastation Evoker Multi Ta








	
	return 0, 625999
end 


	return 0, 625999
end 

RubimRH.Rotation.SetAPL(1467, APL);

local function PASSIVE()
   -- print(GetEnemiesCount());
    return RubimRH.Shared()
end

RubimRH.Rotation.SetPASSIVE(1467, PASSIVE);