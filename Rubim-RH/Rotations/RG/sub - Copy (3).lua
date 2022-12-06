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

if not Spell.Rogue then
    Spell.Rogue = {};
end

RubimRH.Spell[261] = {
	trink2z = Spell(260364), --arcane pulse
	EchoingReprimand = Spell(323547),
	EchoingReprimandCP2 = Spell(323558),
	EchoingReprimandCP3 = Spell(323559),
	EchoingReprimandCP4 = Spell(323560),
	NumbingPoison = Spell(5761),
	BlackPowder = Spell(319175),
	ShadowyDuel = Spell(207736),
smokebomb = Spell(212182),
	ColdBlood = Spell(213981),
	ShadowBlades = Spell(121471),
	Shadowstrike = Spell(185438),
	Backstab = Spell(53),
	Rupture = Spell(1943),
	ShadowDance = Spell(185313),
	ShurikenToss = Spell(114014),
	ShurikenStorm = Spell(197835),
	SymbolsofDeath = Spell(212283),
	ShurikenTornado = Spell(277925),
	SecretTechnique = Spell(280719),
	Eviscerate = Spell(196819),
	Perforate = Spell(277673),
	Nightstalker = Spell(14062),
	DarkShadow = Spell(245687),
	ShadowDanceBuff = Spell(185422),
	stopcasting = Spell(291944), --regeneratin
	WoundPoison = Spell(8679),
	CripplingPoison = Spell(3408),
	InstantPoison = Spell(315584),
	lust1 = Spell(57724),
	lust2 = Spell(57723),
	lust3 = Spell(80354),
	lust4 = Spell(95809),
	lust5 = Spell(264689),
ShadowFocus = Spell(108209),
Alacrity = Spell(193539),
	trink2 = Spell(59547), -- gift of naaru
MasterofShadows = Spell(196976),
	KidneyShot = Spell(408),
    Berserking = Spell(26297),
    Darkflight = Spell(68992),
	Distract = Spell(1725),
	lustAT = Spell(155145),
	Gloomblade = Spell(200758),
SymbolsofDeathAutoCrit = Spell(227151),
    DeeperStratagem = Spell(193531),
    Stealth = Spell(1784),
    Vanish = Spell(1856),
    VanishBuff = Spell(11327),
    Shiv = Spell(248744),  
    WilloftheForsaken = Spell(7744),
    CloakofShadows = Spell(31224),
	trink = Spell(265221), 
    DeathfromAbove = Spell(269513),
    DeeperStratagem = Spell(193531),
    GhostlyStrike = Spell(196937),
    MarkedforDeath = Spell(137619),
    SliceandDice = Spell(315496),
    Vigor = Spell(14983),
	Exhaustion = Spell(57723),
	Blind = Spell(2094),
    CurseoftheDreadblades = Spell(202665),
	CheapShot = Spell(1833),
	Dismantle= Spell(207777),
    CrimsonVial = Spell(185311),
    Feint = Spell(1966),
	EnvelopingShadows = Spell(238104),
    Kick = Spell(1766),
    Sprint = Spell(2983),
	Evasion = Spell(5277),
	Subterfuge = Spell(108208),
	FindWeakness = Spell(316220),
	Steward = Spell(324739),
	WeaponMaster = Spell(193537),
}

local S = RubimRH.Spell[261] 

if not Item.Rogue then Item.Rogue = {}; end

Item.Rogue.Sub = {
	trink2 = Item(178811, { 13, 14 }),
	trink = Item(169311, { 13, 14 }),
	lust = Item(164978),
	phialofserenity = Item(177278),

   
};

local I = Item.Rogue.Sub;

local RtB_BuffsList = {
    S.Broadside,
    S.BuriedTreasure,
    S.GrandMelee,
    S.SkullandCrossbones,
    S.RuthlessPrecision,
    S.TrueBearing
};

local function num(val)
    if val then
        return 1
    else
        return 0
    end
end

local function CPMaxSpend()
    return RubimRH.Spell[261].DeeperStratagem:IsAvailable() and 6 or 5;
end

local function EnergyTimeToMaxRounded()
    return math.floor(Player:EnergyTimeToMaxPredicted() * 10 + 0.5) / 10;
end





local snd_condition


local stealth_threshold


local VarDsCastable



local function APL()
	HL.GetEnemies("Melee");
	HL.GetEnemies(5, true);
    HL.GetEnemies(8, true);
    HL.GetEnemies(10, true);
	HL.GetEnemies(11, true);
	HL.GetEnemies(12, true);
	HL.GetEnemies(15, true);
	HL.GetEnemies(17, true);
	HL.GetEnemies(20, true);
	HL.GetEnemies(22, true);
	HL.GetEnemies(25, true);
	HL.GetEnemies(30, true);

	if Player:IsChanneling() or Player:IsCasting() then
        return 0, "Interface\\Addons\\Rubim-RH\\Media\\channel.tga"
    end

        if (true) then
            snd_condition = Player:BuffP(S.SliceandDice) or Cache.EnemiesCount[10]>=6 and RubimRH.AoEON()
			end
			
			
			-- variable,name=stealth_threshold,value=25+talent.vigor.enabled*20+talent.master_of_shadows.enabled*20+talent.shadow_focus.enabled*25+talent.alacrity.enabled*20+25*(spell_targets.shuriken_storm>=4)
        if (true) then
            stealth_threshold = 25+num(S.Vigor:IsAvailable())*2+num(S.MasterofShadows:IsAvailable())*20+num(S.ShadowFocus:IsAvailable())*25+num(S.Alacrity:IsAvailable())*20+25*num(Cache.EnemiesCount[10]>=4 and RubimRH.AoEON())
			end
			
			
-- variable,name=shd_threshold,value=cooldown.shadow_dance.charges_fractional>=1.75
        if (true) then
            shd_threshold = S.ShadowDance:ChargesFractional()>=1.75
			end

-- variable,name=shd_combo_points,value=combo_points.deficit>=2+buff.shadow_blades.up
-- variable,name=shd_combo_points,value=combo_points.deficit<=1,if=variable.use_priority_rotation&spell_targets.shuriken_storm>=4

        if (true) then
            shd_combopoints = (Player:ComboPointsDeficit()>=2 +num(Player:BuffP(S.ShadowBlades))) or (Player:ComboPointsDeficit()<=1 and Cache.EnemiesCount[10]>=4 and RubimRH.AoEON())
			end



	if (not Player:Buff(S.Stealth) and not Player:Buff(S.VanishBuff) and not Target:Debuff(S.Blind)) and Player:AffectingCombat() and (Target:IsAPlayer() or Player:InArena() or Player:InBattlegrounds()) then




   if S.CrimsonVial:IsCastable() and Player:HealthPercentage() <= 70 then
		return S.CrimsonVial:Cast()
    end

    if S.smokebomb:IsCastable() and Player:HealthPercentage() <= 90 and Cache.EnemiesCount[20]>=1 and (not Player:Buff(S.Stealth) and not Player:Buff(S.VanishBuff) and not Target:Debuff(S.Blind)) then
		return S.smokebomb:Cast()
    end
	
if S.CheapShot:IsReady("Melee") and HL.CombatTime() <= 4 and Player:AffectingCombat() and not Target:Buff(S.Evasion) and not Target:Debuff(S.KidneyShot) and not Target:Debuff(S.CheapShot) and not Target:Debuff(S.Blind) then
        return S.CheapShot:Cast()
    end

    if S.KidneyShot:IsReady("Melee") and not Target:Debuff(S.CheapShot) and not Target:Buff(S.Evasion) and not Target:Debuff(S.KidneyShot) and Player:ComboPoints() >= 5 and not Target:Debuff(S.Blind) then
        return S.KidneyShot:Cast()
    end
	
	end








-- Out of Combat
if not Player:AffectingCombat() then
	
	if S.InstantPoison:IsCastable() and Player:BuffRemainsP(S.InstantPoison) < 300 and not Player:IsCasting(S.InstantPoison) then
    	return S.InstantPoison:Cast()
    end
	
	if S.NumbingPoison:IsCastable() and Player:BuffRemainsP(S.NumbingPoison) < 300 and not Player:IsCasting(S.NumbingPoison) then
    	return S.NumbingPoison:Cast()
    end

    if Player:ComboPoints() >= 1 then
		if S.SliceandDice:IsCastable() and Cache.EnemiesCount[25] >= 1 and not Player:BuffP(S.SliceandDice) then
			return S.SliceandDice:Cast()
		end
	end

	
	if S.Steward:IsCastable() and I.phialofserenity:Count() <= 1 and Cache.EnemiesCount[20] == 0 then
        return S.Steward:Cast()
    end
	
    if S.Stealth:IsCastable() and not Player:Buff(S.Stealth) and not Player:Buff(S.VanishBuff) then
		return S.Stealth:Cast()
    end
	  
   if S.ColdBlood:IsCastable() and not Player:BuffP(S.ColdBlood) and Player:BuffP(S.Stealth) then
		return S.ColdBlood:Cast()
    end

    if S.CrimsonVial:IsCastable() and Cache.EnemiesCount[8] == 0 and Player:HealthPercentage() <= 75 and Player:EnergyDeficit() == 0 then
		return S.CrimsonVial:Cast()
    end

	if not RubimRH.queuedSpell[1]:CooldownUp() or not Target:IsInRange(10) or not Player:AffectingCombat() then
		RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
	end
	
	return 0, "Interface\\Addons\\Rubim-RH\\Media\\mount2.tga"
end 


	if RubimRH.QueuedSpell():IsReadyQueue() then
        return RubimRH.QueuedSpell():Cast()
    end
	
	if not RubimRH.queuedSpell[1]:CooldownUp() or not Target:IsInRange(10) or not Player:AffectingCombat() then
		RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
	end
	


   actions = function()

-- variable,name=snd_condition,value=buff.slice_and_dice.up|spell_targets.shuriken_storm>=6
-- Used to determine whether cooldowns wait for SnD based on targets.
-- call_action_list,name=cds
            if cooldowns() ~= nil and RubimRH.CDsON() then
                return cooldowns()
            end
-- Check CDs at first
-- run_action_list,name=stealthed,if=stealthed.all
            if stealth() ~= nil then
                return stealth()
            end
-- Run fully switches to the Stealthed Rotation (by doing so, it forces pooling if nothing is available).
-- slice_and_dice,if=spell_targets.shuriken_storm<6&fight_remains>6&buff.slice_and_dice.remains<gcd.max&combo_points>=4-(time<10)*2
if S.SliceandDice:IsCastable() and Cache.EnemiesCount[10]<6 and Player:BuffRemainsP(S.SliceandDice)<Player:GCD() and Player:ComboPoints()>=4 - num(HL.CombatTime()<10)*2 then 
return S.SliceandDice:Cast()
end
-- Apply Slice and Dice at 2+ CP during the first 10 seconds, after that 4+ CP if it expires within the next GCD or is not up
-- variable,name=use_priority_rotation,value=priority_rotation&spell_targets.shuriken_storm>=2
-- Only change rotation if we have priority_rotation set and multiple targets up.
-- call_action_list,name=stealth_cds,if=variable.use_priority_rotation
            if stealth_cds() ~= nil then
                return stealth_cds()
            end
-- Priority Rotation? Let's give a crap about energy for the stealth CDs (builder still respect it). Yup, it can be that simple.
-- variable,name=stealth_threshold,value=25+talent.vigor.enabled*20+talent.master_of_shadows.enabled*20+talent.shadow_focus.enabled*25+talent.alacrity.enabled*20+25*(spell_targets.shuriken_storm>=4)
-- Used to define when to use stealth CDs or builders
-- call_action_list,name=stealth_cds,if=energy.deficit<=variable.stealth_threshold
            if stealth_cds() ~= nil and Player:EnergyDeficit()<= stealth_threshold then
                return stealth_cds()
            end
-- Consider using a Stealth CD when reaching the energy threshold
-- call_action_list,name=finish,if=combo_points=animacharged_cp
            if finish() ~= nil and 
			(Player:BuffP(S.EchoingReprimandCP2) and Player:ComboPoints() == 2 
			or Player:BuffP(S.EchoingReprimandCP3) and Player:ComboPoints() == 3 
			or Player:BuffP(S.EchoingReprimandCP4) and Player:ComboPoints() == 4) then
                return finish()
            end
-- call_action_list,name=finish,if=combo_points.deficit<=1|fight_remains<=1&combo_points>=3|buff.symbols_of_death_autocrit.up&combo_points>=4
            if finish() ~= nil and (Player:ComboPointsDeficit() <=1 or Player:Buff(S.SymbolsofDeathAutoCrit) and Player:ComboPoints()>=4) then
                return finish()
            end
-- Finish at 4+ without DS or with SoD crit buff, 5+ with DS (outside stealth)
-- call_action_list,name=finish,if=spell_targets.shuriken_storm>=4&combo_points>=4
            if finish() ~= nil and (Cache.EnemiesCount[10]>=4 and Player:ComboPoints()>=4 and RubimRH.AoEON()) then
                return finish()
            end
-- With DS also finish at 4+ against 4 targets (outside stealth)
-- call_action_list,name=build,if=energy.deficit<=variable.stealth_threshold
            if builders() ~= nil and Player:EnergyDeficit()<stealth_threshold then
                return builders()
            end
-- Use a builder when reaching the energy threshold














end



 builders = function()
-- shuriken_storm,if=spell_targets>=2
if S.ShurikenStorm:IsCastable() and Cache.EnemiesCount[10]>=2 and RubimRH.AoEON() then
return S.ShurikenStorm:Cast()
end
-- serrated_bone_spike,if=cooldown.serrated_bone_spike.charges_fractional>=2.75|soulbind.lead_by_example.enabled&!buff.lead_by_example.up
-- gloomblade
if S.Gloomblade:IsCastable() and Target:IsInRange(10) then
return S.Gloomblade:Cast()
end
-- backstab
if S.Backstab:IsCastable() and Target:IsInRange(10) then
return S.Backstab:Cast()
end








end


 cooldowns = function()
-- shadow_dance,use_off_gcd=1,if=!buff.shadow_dance.up&buff.shuriken_tornado.up&buff.shuriken_tornado.remains<=3.5
if S.ShadowDance:IsReady() and RubimRH.CDsON() and Target:IsInRange(10) and not Player:BuffP(S.ShadowDanceBuff) and Player:BuffP(S.ShurikenTornado) and Player:BuffRemainsP(S.ShurikenTornado)<=3.5 then
return S.ShadowDance:Cast()
end
-- Use Dance off-gcd before the first Shuriken Storm from Tornado comes in.
-- symbols_of_death,use_off_gcd=1,if=buff.shuriken_tornado.up&buff.shuriken_tornado.remains<=3.5
if S.SymbolsofDeath:IsReady() and RubimRH.CDsON() and Target:IsInRange(10) and Player:BuffP(S.ShurikenTornado) and Player:BuffRemainsP(S.ShurikenTornado)<=3.5 then
return S.SymbolsofDeath:Cast()
end
-- (Unless already up because we took Shadow Focus) use Symbols off-gcd before the first Shuriken Storm from Tornado comes in.
-- flagellation,if=variable.snd_condition&!stealthed.mantle
-- flagellation_cleanse,if=debuff.flagellation.remains<2
-- vanish,if=(runeforge.mark_of_the_master_assassin&combo_points.deficit<=1-talent.deeper_strategem.enabled|runeforge.deathly_shadows&combo_points<1)&buff.symbols_of_death.up&buff.shadow_dance.up&master_assassin_remains=0&buff.deathly_shadows.down
-- pool_resource,for_next=1,if=talent.shuriken_tornado.enabled&!talent.shadow_focus.enabled
-- Pool for Tornado pre-SoD with ShD ready when not running SF.
-- shuriken_tornado,if=energy>=60&variable.snd_condition&cooldown.symbols_of_death.up&cooldown.shadow_dance.charges>=1
if S.ShurikenTornado:IsReady() and RubimRH.CDsON() and Cache.EnemiesCount[10]>=1 and Player:Energy()>=60 and snd_condition and S.SymbolsofDeath:CooldownUp() and S.ShadowDance:ChargesFractional()>=1 then
return S.ShurikenTornado:Cast()
end
-- Use Tornado pre SoD when we have the energy whether from pooling without SF or just generally.
-- serrated_bone_spike,cycle_targets=1,if=variable.snd_condition&!dot.serrated_bone_spike_dot.ticking&target.time_to_die>=21|fight_remains<=5&spell_targets.shuriken_storm<3
-- sepsis,if=variable.snd_condition&combo_points.deficit>=1
-- symbols_of_death,if=variable.snd_condition&(talent.enveloping_shadows.enabled|cooldown.shadow_dance.charges>=1)&(!talent.shuriken_tornado.enabled|talent.shadow_focus.enabled|cooldown.shuriken_tornado.remains>2)
if S.SymbolsofDeath:IsReady() and snd_condition and RubimRH.CDsON() and Target:IsInRange(10) and (S.EnvelopingShadows:IsAvailable() or S.ShadowDance:ChargesFractional()>=1) and (not S.ShurikenTornado:IsAvailable() or S.ShadowFocus:IsAvailable() or S.ShurikenTornado:CooldownRemains()>2) then
return S.SymbolsofDeath:Cast()
end
-- Use Symbols on cooldown (after first SnD) unless we are going to pop Tornado and do not have Shadow Focus.
-- marked_for_death,target_if=min:target.time_to_die,if=raid_event.adds.up&(target.time_to_die<combo_points.deficit|!stealthed.all&combo_points.deficit>=cp_max_spend)
-- If adds are up, snipe the one with lowest TTD. Use when dying faster than CP deficit or not stealthed without any CP.
-- marked_for_death,if=raid_event.adds.in>30-raid_event.adds.duration&combo_points.deficit>=cp_max_spend
-- If no adds will die within the next 30s, use MfD on boss without any CP.
-- shadow_blades,if=variable.snd_condition&combo_points.deficit>=2
if S.SymbolsofDeath:IsReady() and snd_condition and RubimRH.CDsON() and Target:IsInRange(10) and Player:ComboPointsDeficit()>=2 then
return S.SymbolsofDeath:Cast()
end
-- echoing_reprimand,if=variable.snd_condition&combo_points.deficit>=2&(variable.use_priority_rotation|spell_targets.shuriken_storm<=4)
if S.EchoingReprimand:IsReady() and snd_condition and RubimRH.CDsON()  and Player:ComboPointsDeficit()>=2 and (Target:IsInRange(10) or Cache.EnemiesCount[10]<=4) then
return S.EchoingReprimand:Cast()
end
-- shuriken_tornado,if=talent.shadow_focus.enabled&variable.snd_condition&buff.symbols_of_death.up
if S.ShurikenTornado:IsReady() and RubimRH.CDsON() and Cache.EnemiesCount[10]>=1 and S.ShadowFocus:IsAvailable() and snd_condition and S.SymbolsofDeath:CooldownUp() then
return S.ShurikenTornado:Cast()
end
-- With SF, if not already done, use Tornado with SoD up.
-- shadow_dance,if=!buff.shadow_dance.up&fight_remains<=8+talent.subterfuge.enabled
if S.ShadowDance:IsReady() and RubimRH.CDsON() and Target:IsInRange(10) and not Player:BuffP(S.ShadowDanceBuff) and S.Subterfuge:IsAvailable() then
return S.ShadowDance:Cast()
end
-- potion,if=buff.bloodlust.react|fight_remains<30|buff.symbols_of_death.up&(buff.shadow_blades.up|cooldown.shadow_blades.remains<=10)
-- blood_fury,if=buff.symbols_of_death.up
-- berserking,if=buff.symbols_of_death.up
-- fireblood,if=buff.symbols_of_death.up
-- ancestral_call,if=buff.symbols_of_death.up
-- use_items,if=buff.symbols_of_death.up|fight_remains<20
-- Default fallback for usable items: Use with Symbols of Death.

















end

   finish = function()
-- variable,name=premed_snd_condition,value=talent.premeditation.enabled&spell_targets.shuriken_storm<(5-covenant.necrolord)&!covenant.kyrian
-- While using Premeditation, avoid casting Slice and Dice when Shadow Dance is soon to be used, except for Kyrian
-- slice_and_dice,if=!variable.premed_snd_condition&spell_targets.shuriken_storm<6&!buff.shadow_dance.up&buff.slice_and_dice.remains<fight_remains&refreshable
if S.SliceandDice:IsCastable() and  Cache.EnemiesCount[10]<6 and not Player:Buff(S.ShadowDance) and Player:BuffRemainsP(S.SliceandDice)<4 and Player:BuffRemainsP(S.SliceandDice)<Target:TimeToDie() then
return S.SliceandDice:Cast()
end
-- slice_and_dice,if=variable.premed_snd_condition&cooldown.shadow_dance.charges_fractional<1.75&buff.slice_and_dice.remains<cooldown.symbols_of_death.remains&(cooldown.shadow_dance.ready&buff.symbols_of_death.remains-buff.shadow_dance.remains<1.2)
-- variable,name=skip_rupture,value=master_assassin_remains>0|!talent.nightstalker.enabled&talent.dark_shadow.enabled&buff.shadow_dance.up|spell_targets.shuriken_storm>=5
-- Helper Variable for Rupture. Skip during Master Assassin or during Dance with Dark and no Nightstalker.
-- rupture,if=!variable.skip_rupture&target.time_to_die-remains>6&refreshable
-- Keep up Rupture if it is about to run out.
-- secret_technique
if S.SecretTechnique:IsReady() and Target:IsInRange(10) then
return S.SecretTechnique:Cast()
end
-- rupture,cycle_targets=1,if=!variable.skip_rupture&!variable.use_priority_rotation&spell_targets.shuriken_storm>=2&target.time_to_die>=(5+(2*combo_points))&refreshable
-- Multidotting targets that will live for the duration of Rupture, refresh during pandemic.
-- rupture,if=!variable.skip_rupture&remains<cooldown.symbols_of_death.remains+10&cooldown.symbols_of_death.remains<=5&target.time_to_die-remains>cooldown.symbols_of_death.remains+5
-- Refresh Rupture early if it will expire during Symbols. Do that refresh if SoD gets ready in the next 5s.
-- black_powder,if=!variable.use_priority_rotation&spell_targets>=4-debuff.find_weakness.down
if S.BlackPowder:IsReady() and Cache.EnemiesCount[10]>=4 - num(Target:DebuffDown(S.FindWeakness)) and RubimRH.AoEON() then
return S.BlackPowder:Cast()
end
-- eviscerate   
if S.Eviscerate:IsReady() and Target:IsInRange(10) then
return S.Eviscerate:Cast()
end   
   
   
   end
   
   
   
   
   
   stealth_cds = function()
-- variable,name=shd_threshold,value=cooldown.shadow_dance.charges_fractional>=1.75

-- Helper Variable
-- vanish,if=(!variable.shd_threshold|!talent.nightstalker.enabled&talent.dark_shadow.enabled)&combo_points.deficit>1&!runeforge.mark_of_the_master_assassin
-- Vanish if we are capping on Dance charges. Early before first dance if we have no Nightstalker but Dark Shadow in order to get Rupture up (no Master Assassin).
-- pool_resource,for_next=1,extra_amount=40,if=race.night_elf
-- Pool for Shadowmeld + Shadowstrike unless we are about to cap on Dance charges. Only when Find Weakness is about to run out.
-- shadowmeld,if=energy>=40&energy.deficit>=10&!variable.shd_threshold&combo_points.deficit>1&debuff.find_weakness.remains<1
-- variable,name=shd_combo_points,value=combo_points.deficit>=2+buff.shadow_blades.up
-- CP thresholds for entering Shadow Dance
-- variable,name=shd_combo_points,value=combo_points.deficit>=3,if=covenant.kyrian
-- variable,name=shd_combo_points,value=combo_points.deficit<=1,if=variable.use_priority_rotation&spell_targets.shuriken_storm>=4
-- shadow_dance,if=variable.shd_combo_points&(variable.shd_threshold|buff.symbols_of_death.remains>=1.2|spell_targets.shuriken_storm>=4&cooldown.symbols_of_death.remains>10)
if S.ShadowDance:IsReady() and RubimRH.CDsON() and Target:IsInRange(10) and shd_combopoints and (shd_threshold or Player:BuffRemainsP(S.SymbolsofDeath)>=1.2 or Cache.EnemiesCount[10]>=4 and RubimRH.AoEON() and S.SymbolsofDeath:CooldownRemains()>10) then
return S.ShadowDance:Cast()
end
-- Dance during Symbols or above threshold.
-- shadow_dance,if=variable.shd_combo_points&fight_remains<cooldown.symbols_of_death.remains
if S.ShadowDance:IsReady() and RubimRH.CDsON() and Target:IsInRange(10) and shd_combopoints then
return S.ShadowDance:Cast()
end
-- Burn remaining Dances before the fight ends if SoD won't be ready in time.


end


  

   stealth = function()

-- shadowstrike,if=(buff.stealth.up|buff.vanish.up)&master_assassin_remains=0
-- If Stealth/vanish are up, use Shadowstrike to benefit from the passive bonus and Find Weakness, even if we are at max CP (unless using Master Assassin)
-- call_action_list,name=finish,if=buff.shuriken_tornado.up&combo_points.deficit<=2
            if finish() ~= nil and Player:Buff(S.ShurikenTornado) and PlayerComboPointsDeficit()<=2 then
                return finish()
            end
-- Finish at 3+ CP without DS / 4+ with DS with Shuriken Tornado buff up to avoid some CP waste situations.
-- call_action_list,name=finish,if=spell_targets.shuriken_storm>=4&combo_points>=4
            if finish() ~= nil and Cache.EnemiesCount[10]>=4 and RubimRH.AoEON() and Player:ComboPoints()>=4 then
                return finish()
            end
-- Also safe to finish at 4+ CP with exactly 4 targets. (Same as outside stealth.)
-- call_action_list,name=finish,if=combo_points.deficit<=1-(talent.deeper_stratagem.enabled&buff.vanish.up)
            if finish() ~= nil and Player:ComboPointsDeficit()<=1 - num(S.DeeperStratagem:IsAvailable() and Player:BuffP(S.VanishBuff))  then
                return finish()
            end
-- Finish at 4+ CP without DS, 5+ with DS, and 6 with DS after Vanish
-- shadowstrike,if=stealthed.sepsis&spell_targets.shuriken_storm<4
-- shiv,if=talent.nightstalker.enabled&runeforge.tiny_toxic_blade&spell_targets.shuriken_storm<5
-- shadowstrike,cycle_targets=1,if=debuff.find_weakness.remains<1&spell_targets.shuriken_storm<=3&target.time_to_die-remains>6
if S.Shadowstrike:IsReady() and Target:IsInRange(10) and Target:DebuffRemains(S.FindWeakness)<1 and Cache.EnemiesCount[10]<=3 then
return S.Shadowstrike:Cast()
end
-- Up to 3 targets keep up Find Weakness by cycling Shadowstrike.
-- shadowstrike,if=variable.use_priority_rotation&(debuff.find_weakness.remains<1|talent.weaponmaster.enabled&spell_targets.shuriken_storm<=4)
if S.Shadowstrike:IsReady() and Target:IsInRange(10) and (Target:DebuffRemains(S.FindWeakness)<1 or S.WeaponMaster:IsAvailable() and Cache.EnemiesCount[10]<=4) then
return S.Shadowstrike:Cast()
end
-- For priority rotation, use Shadowstrike over Storm with WM against up to 4 targets or if FW is running off (on any amount of targets)
-- shuriken_storm,if=spell_targets>=3+(buff.the_rotten.up|runeforge.akaaris_soul_fragment&conduit.deeper_daggers.rank>=7)&(buff.symbols_of_death_autocrit.up|!buff.premeditation.up|spell_targets>=5)
if S.ShurikenStorm:IsReady() and Cache.EnemiesCount[10]>=3 then
return S.ShurikenStorm:Cast()
end
-- shadowstrike,if=debuff.find_weakness.remains<=1|cooldown.symbols_of_death.remains<18&debuff.find_weakness.remains<cooldown.symbols_of_death.remains
if S.Shadowstrike:IsReady() and Target:IsInRange(10) and (Target:DebuffRemains(S.FindWeakness)<=1 or S.SymbolsofDeath:CooldownRemains()<1 and Target:DebuffRemains(S.FindWeakness)<S.SymbolsofDeath:CooldownRemains()) then
return S.Shadowstrike:Cast()
end
-- Shadowstrike to refresh Find Weakness and to ensure we can carry over a full FW into the next SoD if possible.
-- gloomblade,if=buff.perforated_veins.stack>=5&conduit.perforated_veins.rank>=13
-- shadowstrike
if S.Shadowstrike:IsReady() and Target:IsInRange(10) then
return S.Shadowstrike:Cast()
end
-- cheap_shot,if=!target.is_boss&combo_points.deficit>=1&buff.shot_in_the_dark.up&energy.time_to_40>gcd.max













end























            if actions() ~= nil then
                return actions()
            end



















    return 0, 135328
end




RubimRH.Rotation.SetAPL(261, APL);

local function PASSIVE()
    
end

RubimRH.Rotation.SetPASSIVE(261, PASSIVE);