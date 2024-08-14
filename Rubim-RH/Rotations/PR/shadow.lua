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

if not Spell.Priest then
    Spell.Priest = {};
end

RubimRH.Spell[258] = {
ShadowForm = Spell(232698),
Smite = Spell(585),
PowerWordFortitude = Spell(21562),
  WhispersoftheDamned                   = Spell(275722),
  SearingDialogue                       = Spell(272788),
  DeathThroes                           = Spell(278659),
  ThoughtHarvester                      = Spell(288340),
  SpitefulApparitions                   = Spell(277682),
  MindBlast                             = Spell(8092),
  VampiricTouchDebuff                   = Spell(34914),
  VampiricTouch                         = Spell(34914),
  VoidEruption                          = Spell(228260),
  DarkAscension                         = Spell(280711),
  VoidformBuff                          = Spell(194249),
  MindSear                              = Spell(48045),
  HarvestedThoughtsBuff                 = Spell(288343),
  VoidBolt                              = Spell(205448),
  ShadowWordDeath                       = Spell(32379),
  SurrenderToMadness                    = Spell(193223),
  DarkVoid                              = Spell(263346),
  ShadowWordPainDebuff                  = Spell(589),
  Mindbender                            = Spell(200174),
  Shadowfiend                           = Spell(34433),
  ShadowCrash                           = Spell(205385),
  ShadowWordPain                        = Spell(589),
  Misery                                = Spell(238558),
  VoidTorrent                           = Spell(263165),
  MindFlay                              = Spell(15407),
  Berserking                            = Spell(26297),
  ShadowWordVoid                        = Spell(205351),
  LegacyOfTheVoid                       = Spell(193225),
  FortressOfTheMind                     = Spell(193195),
  Dispersion                            = Spell(47585),
  ShadowMend                            = Spell(186263),
  Silence                               = Spell(15487),
  ChorusofInsanity                      = Spell(278661),
  DispelMagic                           = Spell(528),
  PurifyDisease                         = Spell(213634),  
  MassDispell                           = Spell(32375),
  VampiricEmbrace                       = Spell(15286),
  PowerWordShield                       = Spell(17),
  WeakenedSoulDebuff                    = Spell(6788),
  BodyAndSoul                           = Spell(64129),


trinket= Spell(59547), -- gift of narru




	lust1 = Spell(57724),
	lust2 = Spell(57723),
	lust3 = Spell(80354),
	lust4 = Spell(95809),
	lust5 = Spell(264689),
	CondensedLifeForce = Spell(299358),
	UnleashHeartOfAzeroth = Spell(256948), -- spatial rift
	BloodOfTheEnemy = Spell(297108),
	BloodOfTheEnemy2 = Spell(298273),
	BloodOfTheEnemy3 = Spell(298277),
	ConcentratedFlame = Spell(295373),
	ConcentratedFlame2 = Spell(299349),
	ConcentratedFlame3 = Spell(299353),
	GuardianOfAzeroth = Spell(295840),
	GuardianOfAzeroth2 = Spell(299355),
	GuardianOfAzeroth3 = Spell(299358),
	FocusedAzeriteBeam = Spell(295258),
	FocusedAzeriteBeam2 = Spell(299336),
	FocusedAzeriteBeam3 = Spell(299338),
	PurifyingBlast = Spell(295337),
	PurifyingBlast2 = Spell(299345),
	PurifyingBlast3 = Spell(299347),
	TheUnboundForce = Spell(298452),
	TheUnboundForce2 = Spell(299376),
	TheUnboundForce3 = Spell(299378),
	RippleInSpace = Spell(302731),
	RippleInSpace2 = Spell(302982),
	RippleInSpace3 = Spell(302983),
	WorldveinResonance = Spell(295186),
	WorldveinResonance2 = Spell(298628),
	WorldveinResonance3 = Spell(299334),
	MemoryOfLucidDreams = Spell(298357),
	MemoryOfLucidDreams2 = Spell(299372),
	MemoryOfLucidDreams3 = Spell(299374),
	trink2 = Spell(59752), -- human trinket (will to survive)
	ConcentratedFlamedebuff     = Spell(295368),
	FocusedAzeriteBeam = Spell(295258),

	lustAT = Spell(265221), -- fireblood


  healthstone = Spell(291944),
  healingpot = Spell(176108),

	
}

local S = RubimRH.Spell[258]
local G = RubimRH.Spell[1] -- General Skills




-- Items
if not Item.Priest then Item.Priest = {} end
Item.Priest.Shadow = {

    trinket = Item(172666, { 13, 14 }),
	healingpot = Item(169451), --astral healing pot
    healthstone = Item(5512), --health stone
	drumsoffury = Item(120257),
};
local I = Item.Priest.Shadow;



local EnemyRanges = { 10, 5, 8, 12, 30, 35, 40 }
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



local OffensiveCDs = {

    -- S.MemoryOfLucidDreams,
    -- S.PurifyingBlast,
    -- S.ConcentratedFlame
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

local VarDsCastable

local function APL()
	HL.GetEnemies("Melee");
	HL.GetEnemies(5, true);
	HL.GetEnemies(6, true);
    HL.GetEnemies(8, true);
    HL.GetEnemies(10, true);
	HL.GetEnemies(11, true);
	HL.GetEnemies(12, true);
	HL.GetEnemies(13, true);
	HL.GetEnemies(14, true);
	HL.GetEnemies(15, true);
	HL.GetEnemies(17, true);
	HL.GetEnemies(20, true);
	HL.GetEnemies(22, true);
	HL.GetEnemies(25, true);
	HL.GetEnemies(30, true);
	HL.GetEnemies(35, true);
	HL.GetEnemies(40, true);
 

 
 
 


-- Spell Queue




	if Player:IsChanneling() or Player:IsCasting() then
		return 0, "Interface\\Addons\\Rubim-RH\\Media\\channel.tga"
    end
	
		  -- if I.trinket:IsReady() and Target:IsInRange(12) and I.trinket:IsEquipped() and RubimRH.CDsON() and Player:BuffP(S.Crusade) then
         -- return S.trinket:Cast()
     -- end	 
	 
 
 -- if I.healthstone:IsReady() and Player:HealthPercentage() <= 50 then
        -- return S.healthstone:Cast()
    -- end

    if I.healingpot:IsReady() and Player:HealthPercentage() <= 30 then
        return S.healingpot:Cast()
    end


	
	if S.lustAT:ID() ==  RubimRH.queuedSpell[1]:ID() and not Player:Debuff(S.lust1) and not Player:Debuff(S.lust2) and not Player:Debuff(S.lust3) and not Player:Debuff(S.lust4) and not Player:Debuff(S.lust5) and (I.drumsoffury:IsReady()) then
    	return S.lustAT:Cast() -- BIND LUST KEYBIND IN BINDPAD TO ARCANE TORRENT
	end
	
	if S.lustAT:ID() ==  RubimRH.queuedSpell[1]:ID() and (Player:Debuff(S.lust1) or Player:Debuff(S.lust2) or Player:Debuff(S.lust3) or Player:Debuff(S.lust4) or Player:Debuff(S.lust5)) then
		RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
	end





	if RubimRH.QueuedSpell():IsReadyQueue() then
        return RubimRH.QueuedSpell():Cast()
    end
	
	if not RubimRH.queuedSpell[1]:CooldownUp() or not Target:IsInRange(20) or not Player:AffectingCombat() then
		RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
	end






  






if Player:CanAttack(Target) and Target:IsInRange(40) then
--start writing in combat rotation here
if not Player:BuffP(S.ShadowForm) and S.ShadowForm:IsReadyP() then
return S.ShadowForm:Cast()
end




if active_enemies() >= 6 and RubimRH.AoEON() then


-- 6+ TARGETS
-- Use Shadowfiend Icon Shadowfiend/Mindbender Icon Mindbender on cooldown.




-- Cast Void Eruption Icon Void Eruption whenever available.




-- Use Surrender to Madness Icon Surrender to Madness if the target will die within 25s and you currently are not in Voidform Icon Voidform.




-- Cast Devouring Plague Icon Devouring Plague to dump Insanity if you are not talented into Searing Nightmare Icon Searing Nightmare.




-- Cast and maintain Vampiric Touch Icon Vampiric Touch on all targets if they live for 6 seconds or more (which applies Shadow Word: Pain Icon Shadow Word: Pain too if using Misery Icon Misery). Make sure you are doing this periodically to get the Unfurling Darkness Icon Unfurling Darkness benefit. If fighting 9 or more, you can safely stop casting Vampiric Touch if talented into Searing Nightmare Icon Searing Nightmare. See the below section for more detail.




-- Cast and maintain Shadow Word: Pain Icon Shadow Word: Pain on all targets. Disregard this step if you are using Misery Icon Misery or Searing Nightmare Icon Searing Nightmare.




-- Cast Shadow Crash Icon Shadow Crash if talented.




-- Dump Insanity using Searing Nightmare Icon Searing Nightmare if talented, only cast this twice per Mind Sear Icon Mind Sear channel.




-- Use Mind Sear Icon Mind Sear to fill. Recast after two Searing Nightmare Icon Searing Nightmare casts if talented.




-- For any amount of targets if you find yourself using Psychic Link Icon Psychic Link be sure to keep Vampiric Touch Icon Vampiric Touch active on as many targets as possible before casting Mind Blast Icon Mind Blast. This talent is generally inferior to Auspicious Spirits Icon Auspicious Spirits in almost every scenario, so use with caution.





end


-- 4-6 TARGETS
if active_enemies() >= 4 and active_enemies() < 6 and RubimRH.AoEON() then

-- Use Shadowfiend Icon Shadowfiend/Mindbender Icon Mindbender on cooldown.




-- Cast Void Eruption Icon Void Eruption whenever available.



-- Use Surrender to Madness Icon Surrender to Madness if the target will die within 25s and you currently are not in Voidform Icon Voidform.



-- Cast Void Bolt Icon Void Bolt at high priority to keep up Hungering Void Icon Hungering Void if talented Make sure you do not cap Insanity. Stop casting this at 5 or more targets.




-- Cast Devouring Plague Icon Devouring Plague to dump Insanity if you are not talented into Searing Nightmare Icon Searing Nightmare.




-- Cast and maintain Vampiric Touch Icon Vampiric Touch on all targets if they live for 6 seconds or more (which applies Shadow Word: Pain Icon Shadow Word: Pain too if using Misery Icon Misery). Make sure you are doing this periodically to get the Unfurling Darkness Icon Unfurling Darkness benefit.




-- Cast and maintain Shadow Word: Pain Icon Shadow Word: Pain on all targets. Disregard this step if you are using Misery Icon Misery or Searing Nightmare Icon Searing Nightmare.




-- Cast Shadow Crash Icon Shadow Crash if talented.




-- Cast Void Torrent Icon Void Torrent when you have both Shadow Word: Pain Icon Shadow Word: Pain and Vampiric Touch Icon Vampiric Touch active and you are not in Voidform Icon Voidform. Past 4 targets you should only keep using this if talented into Twist of Fate Icon Twist of Fate.




-- Dump Insanity using Searing Nightmare Icon Searing Nightmare if talented, only cast this twice per Mind Sear Icon Mind Sear channel.




-- Use Mind Sear Icon Mind Sear to fill. Recast after two Searing Nightmare Icon Searing Nightmare casts if talented.




end

-- 2-3 TARGETS
if active_enemies() >= 2 and active_enemies() < 4 and RubimRH.AoEON() then

-- Use Shadowfiend Icon Shadowfiend/Mindbender Icon Mindbender on cooldown.




-- Cast Void Eruption Icon Void Eruption whenever available.




-- Use Surrender to Madness Icon Surrender to Madness if the target will die within 25s and you currently are not in Voidform Icon Voidform.



-- Cast Void Bolt Icon Void Bolt at high priority to keep up Hungering Void Icon Hungering Void if talented Make sure you do not cap Insanity.




-- Cast Devouring Plague Icon Devouring Plague to dump Insanity.




-- Cast Void Bolt Icon Void Bolt if you will not cap Insanity.




-- Cast Shadow Word: Death Icon Shadow Word: Death on cooldown when the mobs are below 20% HP.




-- Cast and maintain Vampiric Touch Icon Vampiric Touch on all targets if they live for 6 seconds or more (which applies Shadow Word: Pain Icon Shadow Word: Pain too if using Misery Icon Misery). Make sure you are doing this periodically to get the Unfurling Darkness Icon Unfurling Darkness benefit.




-- Cast and maintain Shadow Word: Pain Icon Shadow Word: Pain on all targets. Disregard this step if you are using Misery Icon Misery or Searing Nightmare Icon Searing Nightmare.




-- Cast Shadow Crash Icon Shadow Crash if talented.




-- Cast Void Torrent Icon Void Torrent when you have both Shadow Word: Pain Icon Shadow Word: Pain and Vampiric Touch Icon Vampiric Touch active and you are not in Voidform Icon Voidform.




-- Cast Mind Blast Icon Mind Blast.




-- Use Mind Sear Icon Mind Sear to fill.



end





if S.ShadowWordPain:IsReadyP() and Target:DebuffRemainsP(S.ShadowWordPain)<3 then
return S.ShadowWordPain:Cast()
end

if S.MindBlast:IsReadyP() and not Player:IsMoving() then
return S.MindBlast:Cast()
end

-- if S.MindFlay:IsCastable() then
-- return S.MindFlay:Cast()
-- end


-- SINGLE TARGET ROTATION

-- Cast Void Eruption to enter Voidform whenever you get at least 40 Insanity. Once you reach level 58 you should line this up only when you also have Power Infusion ready.
if S.VoidEruption:IsReadyP() and Player:Insanity() >=40 then
return S.VoidEruption:Cast()
end


-- Cast Power Infusion with Voidform (after level 58).



-- Use the rest of your cooldowns to line them up, this includes Essences and trinkets.




-- Use Damnation or Searing Nightmare to easily apply DoTs before applying manually.




-- Apply and maintain Shadow Word: Pain and Vampiric Touch on your target, only refreshing them when they are about to fall off. If using Misery Icon Misery only refresh with Vampiric Touch. Make sure you are refreshing Vampiric Touch periodically to get the Unfurling Darkness Icon Unfurling Darkness benefit.




-- Cast Devouring Plague Icon Devouring Plague when you have at least 50 Insanity. There is no optimal refresh point like traditional DoTs, you just want to make sure you cast this enough to get maximum uptime for the Mastery benefit. Remember that refreshing Devouring Plague does NOT cause you to lose any damage, the damage left over in the old DoT gets carried over to the new one.




-- Cast Void Bolt Icon Void Bolt on cooldown in Voidform as long as you will not cap on Insanity (below 85).




-- Cast Shadow Word: Death Icon Shadow Word: Death on cooldown when the mobs are below 20% HP.




-- Use Surrender to Madness Icon Surrender to Madness if the target will die within 25s and you currently are not in Voidform Icon Voidform.




-- Use Shadowfiend Icon Shadowfiend/Mindbender Icon Mindbender whenever available, preferably when you have as much Haste as possible, or right before you enter Voidform Icon Voidform.




-- Cast Void Torrent Icon Void Torrent when you have both Shadow Word: Pain Icon Shadow Word: Pain and Vampiric Touch Icon Vampiric Touch active and you are not in Voidform Icon Voidform.




-- Cast all 3 Shadow Crash Icon Shadow Crash charges in a row on the same target as long as they only hit 1 target. Do not use it if you have less than 3 charges available and the debuff is not on the target.




-- Cast Mind Flay Icon Mind Flay in order to consume a Dark Thoughts Icon Dark Thoughts proc with Mind Blast Icon Mind Blast while channeling Mind Flay. If you have to you can also use this proc to help with movement.




-- Cast Mind Blast Icon Mind Blast on cooldown. Note: you do not need to use both charges at the same time when in Voidform, just make sure to not stay at 2 charges if possible.




-- Consume your Unfurling Darkness Icon Unfurling Darkness procs to make sure you do not lose the buff if you have this active/talented. Do not go out of your way to proc this every 15 seconds, see below for more detail.




-- Cast Mind Flay Icon Mind Flay as a filler when all of the above spells can not be cast or do not have to be cast, interrupting it whenever a higher priority spell becomes available.




-- Cast Shadow Word: Death Icon Shadow Word: Death when on the move, or spam Shadow Word: Pain Icon Shadow Word: Pain if Shadow Word: Death is on cooldown and you have to move.






	
end


-- Out of Combat
if not Player:AffectingCombat() then

--write out of combat rotation here

if Player:BuffRemainsP(S.PowerWordFortitude)<300 then
return S.PowerWordFortitude:Cast()
end


if not Player:BuffP(S.ShadowForm)  then
return S.ShadowForm:Cast()
end





if Player:CanAttack(Target) then

-- Pre-cast Vampiric Touch Icon Vampiric Touch.



-- Apply Shadow Word: Pain Icon Shadow Word: Pain.





if S.ShadowWordPain:IsCastable() and Target:DebuffRemainsP(S.ShadowWordPain)<3 then
return S.ShadowWordPain:Cast()
end








end



	
	if not RubimRH.queuedSpell[1]:CooldownUp() or not Target:IsInRange(10) or not Player:AffectingCombat() then
		RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
	end
	
	return 0, "Interface\\Addons\\Rubim-RH\\Media\\priest.tga"
end 


    return 0, 135328
end




RubimRH.Rotation.SetAPL(258, APL);

local function PASSIVE()
    
end

RubimRH.Rotation.SetPASSIVE(258, PASSIVE);