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

if not Spell.Rogue then
    Spell.Rogue = {};
end

RubimRH.Spell[260] = {
    --INTERRUPTS
    SummarilyDispatched    = Spell(381990),
    KeepitRolling          = Spell(381989),
    ShadowRunner           = Spell(378807),
    Audacity               = Spell(381845),
    AudacityBuff           = Spell(386270),
    SubterfugeBuff         = Spell(115192),
    Subterfuge             = Spell(108208),
    ThistleTea             = Spell(381623),
    HiddenOpportunity      = Spell(383281),
    autoattack             = Spell(274738), -- ancestral call
    ImprovedBetweentheEyes = Spell(235484),
    ColdBlood              = Spell(382245),
    ShadowDance            = Spell(185313),
    ShadowDanceBuff        = Spell(185422),
    DeftManeuvers          = Spell(381878),
    AcrobaticStrikes       = Spell(196924),
    Sepsis                 = Spell(385408), --check if this is buff or just talent/spell
    --Dungeons
    --Enrage
    LoadedDiceBuff         = Spell(256171),
    ViciousFollowup        = Spell(394879),
    EchoingReprimand       = Spell(385616),
    EchoingReprimandCP2    = Spell(323558),
    EchoingReprimandCP3    = Spell(323559),
    EchoingReprimandCP4    = Spell(323560),
    EchoingReprimandCP5    = Spell(354838),
    BladeRush              = Spell(271877),
    CripplingPoison        = Spell(3408),
    AtrophicPoison         = Spell(381637),
    InstantPoison          = Spell(315584),
    NumbingPoison          = Spell(5761),
    lust1                  = Spell(57724),
    lust2                  = Spell(57723),
    lust3                  = Spell(80354),
    lust4                  = Spell(95809),
    lust5                  = Spell(264689),
	ImprovedAdrenalineRush = Spell(395422),
    FantheHammer           = Spell(381846),
    SwiftSlasher           = Spell(381988),
    Shadowstep = Spell(36554),
    CounttheOdds           = Spell(381982),
    Dreadblades            = Spell(343142),
    Detection              = Spell(56814),
    KidneyShot             = Spell(408),
    Deadshot               = Spell(272935),
    Berserking             = Spell(26297),
    Darkflight             = Spell(68992),
    Distract               = Spell(1725),
    lustAT                 = Spell(155145), --arcane torrent
    WaterStrider           = Spell(118089),
    BugMount               = Spell(243795),
    razorcoral             = Spell(303568),
    ConductiveInk          = Spell(302565),
    AdrenalineRush         = Spell(13750),
    Ambush                 = Spell(8676),
    BetweentheEyes         = Spell(315341),
    BladeFlurry            = Spell(13877),
    Shadowmeld             = Spell(135201),
    DeviousStratagem       = Spell(394321),
    Opportunity            = Spell(195627),
    PistolShot             = Spell(185763),
    RolltheBones           = Spell(315508),
    Dispatch               = Spell(2098),
    SinisterStrike         = Spell(193315),
    ImprovedAmbush         = Spell(381620),
    -- Stealth                = Spell(1784),
    -- Stealth                = Spell(115191),

    Stealth                = MultiSpell(115191, 1784),
    FindWeakness           = Spell(91023),
    FindWeaknessDebuff     = Spell(316220),
    Vanish                 = Spell(1856),
    VanishBuff             = Spell(11327),
    Shiv                   = Spell(5938),
    -- Riposte = Spell(199754), -- evasion
    WilloftheForsaken      = Spell(7744),
    CloakofShadows         = Spell(31224),
    Alacrity               = Spell(193539),
    AlacrityBuff           = Spell(193538),
    Anticipation           = Spell(114015),
    CannonballBarrage      = Spell(185767),
    DeathfromAbove         = Spell(152150),
    DeeperStratagem        = Spell(193531),
    DirtyTricks            = Spell(108216),
    GhostlyStrike          = Spell(196937),
    KillingSpree           = Spell(51690),
    MarkedforDeath         = Spell(137619),
    QuickDraw              = Spell(196938),
    GreenSkinsWickers      = Spell(386823), --386823 --394131
    GreenSkinsWickersBuff  = Spell(394131),
    SliceandDice           = Spell(315496),
    Vigor                  = Spell(14983),
    Exhaustion             = Spell(57723),
    PrecisionShot          = Spell(428377),
    Blind                  = Spell(2094),
    Blunderbuss            = Spell(202895),
    CurseoftheDreadblades  = Spell(202665),
    HiddenBlade            = Spell(202754),
    LoadedDice             = Spell(256170),
    DeadshotBuff           = Spell(272940),
    AceUpYourSleeve        = Spell(278676),
    Legacyofwaycrest = Spell(199368), --BRH debuff

    SnakeEyes              = Spell(275846),
    SnakeEyesBuff          = Spell(275863),
    CheapShot              = Spell(1833),
    CrimsonVial            = Spell(185311),
    Feint                  = Spell(1966),
    Gouge                  = Spell(1776),
    Kick                   = Spell(1766),
    Sprint                 = Spell(2983),
    Broadside              = Spell(193356),
    BuriedTreasure         = Spell(199600),
    GrandMelee             = Spell(193358),
    SkullandCrossbones     = Spell(199603),
    GCBoon                 = Spell(20572),
    RuthlessPrecision      = Spell(193357),
    TrueBearing            = Spell(193359),
    Evasion                = Spell(5277),
    WoundPoison            = Spell(8679),
    chronofaded = Spell(404141),
    audacitySS = Spell(20594), --stone form
    Crackshot              = Spell(423703),
    UnderhandedUpperHand   = Spell(424044),
    SepsisBuff             = Spell(375939),
    shadetarget = Spell(350209),
}

local S = RubimRH.Spell[260]

if not Item.Rogue then Item.Rogue = {}; end

Item.Rogue.Outlaw = {
    tx1 = Item(118330),
    tx2 = Item(114616),
    drums = Item(193470),
    HPIcon = Item(169451),
    HPpotID = Item(191380),
};

local I = Item.Rogue.Outlaw;

local function num(val)
    if val then
        return 1
    else
        return 0
    end
end




local function CPMaxSpend()
    if S.DeeperStratagem:IsAvailable() and S.DeviousStratagem:IsAvailable() then
        return 7
    elseif S.DeeperStratagem:IsAvailable() and not S.DeviousStratagem:IsAvailable() or not S.DeeperStratagem:IsAvailable() and S.DeviousStratagem:IsAvailable() then
        return 6
    else
        return 5
    end
end

local function EnergyTimeToMaxRounded()
    return math.floor(Player:EnergyTimeToMaxPredicted() * 10 + 0.5) / 10;
end


local function EnergyTimeToMaxRounded()
    return math.floor(Player:EnergyTimeToMaxPredicted() * 10 + 0.5) / 10;
end



local RtB_BuffsList = {
    S.Broadside,
    S.BuriedTreasure,
    S.GrandMelee,
    S.RuthlessPrecision,
    S.SkullandCrossbones,
    S.TrueBearing
}

local function RtB_Buffs()
    if not Cache.APLVar.RtB_Buffs then
        Cache.APLVar.RtB_Buffs = {}
        Cache.APLVar.RtB_Buffs.Total = 0
        Cache.APLVar.RtB_Buffs.Normal = 0
        Cache.APLVar.RtB_Buffs.Shorter = 0
        Cache.APLVar.RtB_Buffs.Longer = 0
		local RtBRemains = RtBRemains()
        for i = 1, #RtB_BuffsList do
            local Remains = Player:BuffRemains(RtB_BuffsList[i])
            if Remains > 0 then
                Cache.APLVar.RtB_Buffs.Total = Cache.APLVar.RtB_Buffs.Total + 1
				
                if math.abs(Remains - RtBRemains) < 0.1 then
                    Cache.APLVar.RtB_Buffs.Normal = Cache.APLVar.RtB_Buffs.Normal + 1
					
                elseif math.abs(Remains - RtBRemains) >= 0.1 and Remains > RtBRemains then
                    Cache.APLVar.RtB_Buffs.Longer = Cache.APLVar.RtB_Buffs.Longer + 1
					
                elseif math.abs(Remains - RtBRemains) >= 0.1 and Remains < RtBRemains then
                    Cache.APLVar.RtB_Buffs.Shorter = Cache.APLVar.RtB_Buffs.Shorter + 1
                end
	
            end
        end
    end
	return Cache.APLVar.RtB_Buffs.Total
end

local function MaxRtB_BuffRemains()
    if not Cache.APLVar.MaxRtB_BuffRemains then
        Cache.APLVar.MaxRtB_BuffRemains = 0;
        for i = 1, #RtB_BuffsList do
            if Player:Buff(RtB_BuffsList[i]) then
				if Player:BuffRemains(RtB_BuffsList[i]) > Cache.APLVar.MaxRtB_BuffRemains then
					Cache.APLVar.MaxRtB_BuffRemains = Player:BuffRemains(RtB_BuffsList[i])
				end
            end
        end
    end
    return Cache.APLVar.MaxRtB_BuffRemains;
end


local function stealth()
	--blade_flurry,if=talent.subterfuge&talent.hidden_opportunity&spell_targets>=2&buff.blade_flurry.remains<gcd
    if S.BladeFlurry:IsReady() and (Player:BuffRemains(S.ShadowDanceBuff) > Player:GCDRemains() or Player:BuffRemains(S.SubterfugeBuff) > Player:GCDRemains()) and targetRange8 and (S.Subterfuge:IsAvailable() and S.HiddenOpportunity:IsAvailable() 
    and inRange10>= 2 and Player:BuffRemains(S.BladeFlurry) < Player:GCDRemains()) then
        return S.BladeFlurry:Cast()
    end




	--cold_blood,if=variable.finish_condition
    if S.ColdBlood:IsReady() and targetRange8 and not Player:Buff(S.ColdBlood) and finish_condition then
        return S.ColdBlood:Cast()
    end

	--between_the_eyes,if=variable.finish_condition&talent.crackshot
    if S.BetweentheEyes:IsReady() and (Player:BuffRemains(S.ShadowDanceBuff) > Player:GCDRemains() or Player:BuffRemains(S.SubterfugeBuff) > Player:GCDRemains() or Player:Buff(S.VanishBuff))  and targetRange30 and finish_condition and S.Crackshot:IsAvailable() then
        return S.BetweentheEyes:Cast()
    end

    --dispatch,if=variable.finish_condition
	if S.Dispatch:IsReady() and targetRange8 and finish_condition 
    and (S.ShadowDance:CooldownRemains()>Player:GCD() 
    and S.Vanish:CooldownRemains()>Player:GCD() or not RubimRH.CDsON() or S.BetweentheEyes:CooldownRemains()>Player:GCD()) then
		return S.Dispatch:Cast()    
	end
	--pistol_shot,if=talent.crackshot&talent.fan_the_hammer.rank>=2&buff.opportunity.stack>=6&(buff.broadside.up&combo_points<=1|buff.greenskins_wickers.up)
    if S.PistolShot:IsReady() and not finish_condition and S.Ambush:TimeSinceLastCast()>0.5 and S.PistolShot:TimeSinceLastCast()>0.5 and S.BladeFlurry:TimeSinceLastCast()>0.5 and targetRange30 and S.Crackshot:IsAvailable() 
    and fthrank >= 2 and Player:BuffStack(S.Opportunity) >= 6 and (Player:Buff(S.Broadside) and Player:ComboPoints() <= 1 or Player:Buff(S.GreenSkinsWickersBuff)) then
        return S.PistolShot:Cast()
    end
		--ambush,if=talent.hidden_opportunity&(buff.audacity.up|buff.sepsis_buff.up)
        if S.Ambush:IsReady() and not finish_condition and S.PistolShot:TimeSinceLastCast()>0.5 and S.BladeFlurry:TimeSinceLastCast()>0.5 and targetRange8 and S.HiddenOpportunity:IsAvailable() and (Player:Buff(S.AudacityBuff) ) and Player:ComboPoints()<=5 then
            return S.audacitySS:Cast()
        end
	--ambush,if=talent.hidden_opportunity
    if S.Ambush:IsReady() and S.PistolShot:TimeSinceLastCast()>0.5 and S.BladeFlurry:TimeSinceLastCast()>0.5 and targetRange8 and S.HiddenOpportunity:IsAvailable() and not finish_condition then
        return S.Ambush:Cast()
    end
end

local function stealth_cds()
	--vanish,if=talent.hidden_opportunity&!talent.crackshot&!buff.audacity.up&(variable.vanish_opportunity_condition|buff.opportunity.stack<buff.opportunity.max_stack)&variable.ambush_condition
    if S.Vanish:IsCastable() and not basic_rtb_reroll and Player:Buff(S.SliceandDice) and S.BetweentheEyes:CooldownUp() and targetRange8 and (IsInInstance() or target_is_dummy() or Target:IsAPlayer() or Player:CanAttack(Target)) 
    and S.HiddenOpportunity:IsAvailable() and not S.Crackshot:IsAvailable() and not Player:Buff(S.AudacityBuff) and Player:GCDRemains()<0.25
    and (vanish_opportunity_condition or Player:BuffStack(S.Opportunity) < 6) and ambushcondition then
        return S.Vanish:Cast()
    end
	
	--vanish,if=(!talent.hidden_opportunity|talent.crackshot)&variable.finish_condition
    if S.Vanish:IsCastable() and not basic_rtb_reroll and Player:Buff(S.SliceandDice) and S.BetweentheEyes:CooldownUp() and Player:GCDRemains()<0.25+tolerance and targetRange8 and (IsInInstance() or target_is_dummy() or Target:IsAPlayer() or Player:CanAttack(Target)) 
    and (not S.HiddenOpportunity:IsAvailable() or S.Crackshot:IsAvailable()) and finish_condition then
        return S.Vanish:Cast()
    end

	--shadow_dance,if=talent.crackshot&variable.finish_condition
    if S.ShadowDance:IsCastable() and not basic_rtb_reroll and Player:Buff(S.SliceandDice) and S.BetweentheEyes:CooldownUp() and Player:GCDRemains()<0.25+tolerance and targetRange8 
    and S.Crackshot:IsAvailable() and finish_condition then
        return S.ShadowDance:Cast()
    end

	--shadow_dance,if=!talent.keep_it_rolling&variable.shadow_dance_condition&buff.slice_and_dice.up&(variable.finish_condition|talent.hidden_opportunity)&(!talent.hidden_opportunity|!cooldown.vanish.ready)
    if S.ShadowDance:IsCastable() and not basic_rtb_reroll and S.BetweentheEyes:CooldownUp() and Player:GCDRemains()<0.25+tolerance and targetRange8 and not S.KeepitRolling:IsAvailable() and shadow_dance_condition 
    and Player:Buff(S.SliceandDice) and (finish_condition or S.HiddenOpportunity:IsAvailable()) 
    and (not S.HiddenOpportunity:IsAvailable() or not S.Vanish:CooldownUp()) then
        return S.ShadowDance:Cast()
    end

    --shadow_dance,if=talent.keep_it_rolling&variable.shadow_dance_condition&(cooldown.keep_it_rolling.remains<=30|cooldown.keep_it_rolling.remains>120&(variable.finish_condition|talent.hidden_opportunity))
    if S.ShadowDance:IsCastable() and not basic_rtb_reroll and Player:Buff(S.SliceandDice) and S.BetweentheEyes:CooldownUp() and Player:GCDRemains()<0.25+tolerance and targetRange8 and S.KeepitRolling:IsAvailable() 
    and shadow_dance_condition and (S.KeepitRolling:CooldownRemains() <= 30 or S.KeepitRolling:CooldownRemains() > 120 
    and (finish_condition or S.HiddenOpportunity:IsAvailable())) then
        return S.ShadowDance:Cast()
    end
end

local function builders()


	--echoing_reprimand
    if S.EchoingReprimand:IsReady() and not finish_condition and targetRange8  then
        return S.EchoingReprimand:Cast()
    end
		--ambush,if=talent.hidden_opportunity&(buff.audacity.up|buff.sepsis_buff.up)
        if S.Ambush:IsReady() and not finish_condition and S.PistolShot:TimeSinceLastCast()>0.5 and S.BladeFlurry:TimeSinceLastCast()>0.5 and targetRange8 and S.HiddenOpportunity:IsAvailable() and (Player:Buff(S.AudacityBuff) ) and Player:ComboPoints()<=5 then
            return S.audacitySS:Cast()
        end
	--ambush,if=talent.hidden_opportunity&(buff.audacity.up|buff.sepsis_buff.up)
    if S.Ambush:IsReady() and not finish_condition and S.PistolShot:TimeSinceLastCast()>0.5 and S.BladeFlurry:TimeSinceLastCast()>0.5 and targetRange8 and S.HiddenOpportunity:IsAvailable() and (Player:Buff(S.AudacityBuff) or Player:Buff(S.SepsisBuff)) and Player:ComboPoints()<=5 then
        return S.Ambush:Cast()
    end
	
    --pistol_shot,if=talent.fan_the_hammer&talent.audacity&talent.hidden_opportunity&buff.opportunity.up&!buff.audacity.up
    if S.PistolShot:IsReady() and not finish_condition and S.Ambush:TimeSinceLastCast()>0.5 and S.PistolShot:TimeSinceLastCast()>0.5 and S.BladeFlurry:TimeSinceLastCast()>0.5 and targetRange30 and Player:ComboPoints()<=5 
    and S.FantheHammer:IsAvailable() and S.Audacity:IsAvailable() and S.HiddenOpportunity:IsAvailable() 
    and Player:Buff(S.Opportunity) and not Player:Buff(S.AudacityBuff) then
        return S.PistolShot:Cast()
    end
	
    --pistol_shot,if=buff.greenskins_wickers.up&(!talent.fan_the_hammer&buff.opportunity.up|buff.greenskins_wickers.remains<1.5)
    if S.PistolShot:IsReady() and not finish_condition and S.Ambush:TimeSinceLastCast()>0.5 and S.PistolShot:TimeSinceLastCast()>0.5 and S.BladeFlurry:TimeSinceLastCast()>0.5 and targetRange30 and Player:ComboPoints()<=5 
    and Player:Buff(S.GreenSkinsWickersBuff) and (not S.FantheHammer:IsAvailable() 
    and Player:Buff(S.Opportunity) or Player:BuffRemains(S.GreenSkinsWickersBuff) < 1.5) then
        return S.PistolShot:Cast()
    end
	
    --pistol_shot,if=talent.fan_the_hammer&buff.opportunity.up&(buff.opportunity.stack>=buff.opportunity.max_stack|buff.opportunity.remains<2)
    if S.PistolShot:IsReady() and not finish_condition and S.Ambush:TimeSinceLastCast()>0.5 and S.PistolShot:TimeSinceLastCast()>0.5 and S.BladeFlurry:TimeSinceLastCast()>0.5 and targetRange30 and Player:ComboPoints()<=5 
    and S.FantheHammer:IsAvailable() and Player:Buff(S.Opportunity) 
    and (Player:BuffStack(S.Opportunity) >= 6 or Player:BuffRemains(S.Opportunity) < 2) then
        return S.PistolShot:Cast()
    end
	
	--pistol_shot,if=talent.fan_the_hammer&buff.opportunity.up&combo_points.deficit>((1+talent.quick_draw)*talent.fan_the_hammer.rank)&(cooldown.vanish.remains>10&cooldown.shadow_dance.remains>5|!talent.crackshot|talent.fan_the_hammer.rank<=1)
    if S.PistolShot:IsReady() and not finish_condition and S.Ambush:TimeSinceLastCast()>0.5 and S.PistolShot:TimeSinceLastCast()>0.5 and S.BladeFlurry:TimeSinceLastCast()>0.5 and targetRange30 and Player:ComboPoints()<=5 and S.FantheHammer:IsAvailable() 
    and Player:Buff(S.Opportunity) and Player:ComboPointsDeficit() > ((1 + num(S.QuickDraw:IsAvailable())) * fthrank) 
    and (not RubimRH.CDsON() or (S.Vanish:CooldownRemains()>10 and S.ShadowDance:CooldownRemains()>5 or not S.Crackshot:IsAvailable() or fthrank <= 1)) then
        return S.PistolShot:Cast()
    end
	
    --pistol_shot,if=!talent.fan_the_hammer&buff.opportunity.up&(energy.base_deficit>energy.regen*1.5|combo_points.deficit<=1+buff.broadside.up|talent.quick_draw.enabled|talent.audacity.enabled&!buff.audacity.up)
    if S.PistolShot:IsReady() and not finish_condition and S.Ambush:TimeSinceLastCast()>0.5 and S.PistolShot:TimeSinceLastCast()>0.5 and S.BladeFlurry:TimeSinceLastCast()>0.5 and targetRange30 and Player:ComboPoints()<=5 
    and not S.FantheHammer:IsAvailable() and Player:Buff(S.Opportunity) 
    and (Player:EnergyDeficit() > Player:EnergyRegen() * 1.5 or Player:ComboPointsDeficit() <= 1 + num(Player:Buff(S.Broadside)) 
    or S.QuickDraw:IsAvailable() or S.Audacity:IsAvailable() and not Player:Buff(S.AudacityBuff)) then
        return S.PistolShot:Cast()
    end
	
    --sinister_strike
    if S.SinisterStrike:IsReady() and not finish_condition and not Player:Buff(S.Opportunity) and S.Vanish:TimeSinceLastCast()>0.5 and targetRange8 and Player:ComboPoints()<=5 and not stealthall then
        return S.SinisterStrike:Cast()
    end
end

local function cooldowns()
    --adrenaline_rush,if=(!buff.adrenaline_rush.up|stealthed.all&talent.crackshot&talent.improved_adrenaline_rush)&(combo_points<=2|!talent.improved_adrenaline_rush)
    if S.AdrenalineRush:IsCastable() and targetRange8 and RubimRH.CDsON() and (not Player:Buff(S.AdrenalineRush) 
    or stealthall and S.Crackshot:IsAvailable() and S.ImprovedAdrenalineRush:IsAvailable() or RtB_Buffs()<=2 and Player:BuffRemains(S.AdrenalineRush) and MaxRtB_BuffRemains()<2 and not Player:Buff(S.LoadedDiceBuff)) and 
    (Player:ComboPoints() <= 2 or not S.ImprovedAdrenalineRush:IsAvailable()) then
        return S.AdrenalineRush:Cast()
    end
       --blade_flurry,if=(spell_targets>=2-talent.underhanded_upper_hand&!stealthed.rogue)&buff.blade_flurry.remains<gcd|talent.deft_maneuvers&spell_targets>=5&!variable.finish_condition
    if S.BladeFlurry:IsReady() and targetRange8
    and ((inRange10>= 2 - num(S.UnderhandedUpperHand:IsAvailable() and not AuraUtil.FindAuraByName("Stealth", "player"))) and Player:BuffRemains(S.BladeFlurry) < Player:GCD() 
    or S.DeftManeuvers:IsAvailable() and (inRange10>=5 or inRange10>= 3 and (inRange10 + num(Player:Buff(S.Broadside))) >=Player:ComboPointsDeficit()) and not finish_condition) then
        return S.BladeFlurry:Cast()
    end
	
	--roll_the_bones,if=variable.rtb_reroll|rtb_buffs.max_remains<=set_bonus.tier31_4pc+(cooldown.shadow_dance.remains<=1|cooldown.vanish.remains<=1)*6
	if S.RolltheBones:IsCastable()  and ((basic_rtb_reroll or rtb_reroll)
    or (MaxRtB_BuffRemains() <= num(tierequipped() >= 4)  + (num(RubimRH.CDsON())*(num(S.ShadowDance:CooldownRemains() <= 1) or num(S.Vanish:CooldownRemains() <= 1)))*6)) then
		return S.RolltheBones:Cast()
	end
    
	
    --keep_it_rolling,if=!variable.rtb_reroll&rtb_buffs>=3+set_bonus.tier31_4pc&(buff.shadow_dance.down|rtb_buffs>=6)
    -- if S.KeepitRolling:IsReady() and not RtB_Reroll() and RtB_Buffs() >= 3 + num(tierequipped() >= 4) and (not Player:Buff(S.ShadowDanceBuff) or RtB_Buffs() >= 6) then
        -- return S.KeepitRolling:Cast()
    -- end

    --ghostly_strike
    if S.GhostlyStrike:IsReady() and targetRange8 and RubimRH.CDsON() then
        return S.GhostlyStrike:Cast()
    end
	
    --blade_rush,if=variable.blade_flurry_sync&(energy.base_time_to_max>4-spell_targets%3)&!stealthed.all
    if S.BladeRush:IsReady() and targetRange8 and bladeflurrysync and (EnergyTimeToMaxRounded() > 4 - inRange10/ 3) and not stealthall then
        return S.BladeRush:Cast()
    end
	
    --call_action_list,name=stealth_cds,if=!stealthed.all
    if stealth_cds() and RubimRH.CDsON() and not stealthall and Player:GCDRemains()<0.2
    -- and (S.BetweentheEyes:CooldownUp() or not S.Crackshot:IsAvailable()) 
    then
		return stealth_cds()
    end
	
    --thistle_tea,if=!buff.thistle_tea.up&(energy.base_deficit>=100|fight_remains<charges*6)
    if S.ThistleTea:IsReady() and targetRange8 and not Player:Buff(S.ThistleTea) and Player:EnergyDeficit() >= 100 then
        return S.ThistleTea:Cast()
    end
	
    if UseItems() and RubimRH.CDsON() and targetRange8 and not Player:Buff(S.Stealth) and not Player:Buff(S.VanishBuff) then
		return UseItems()
    end
	
	return nil
end

local function finishers()
	--between_the_eyes,if=!talent.crackshot&(buff.between_the_eyes.remains<4|talent.improved_between_the_eyes|talent.greenskins_wickers|set_bonus.tier30_4pc)&!buff.greenskins_wickers.up
	if S.BetweentheEyes:IsReady() and targetRange30 and not S.Crackshot:IsAvailable() and (Player:BuffRemains(S.BetweentheEyes) < 4 or S.ImprovedBetweentheEyes:IsAvailable() or S.GreenSkinsWickers:IsAvailable() or tierequipped() >= 4)
     and not Player:Buff(S.GreenSkinsWickersBuff) then
		return S.BetweentheEyes:Cast()
	end

	--between_the_eyes,if=talent.crackshot&(cooldown.vanish.remains>45&cooldown.shadow_dance.remains>15)
	if S.BetweentheEyes:IsReady() and targetRange30 and S.Crackshot:IsAvailable() and ((Player:BuffRemains(S.ShadowDanceBuff) > Player:GCDRemains() or Player:BuffRemains(S.SubterfugeBuff) > Player:GCDRemains() or Player:Buff(S.VanishBuff))  and S.Vanish:CooldownRemains() > 45 and S.ShadowDance:CooldownRemains() > 15) then
		return S.BetweentheEyes:Cast()
	end

	--slice_and_dice,if=buff.slice_and_dice.remains<fight_remains&refreshable
	if S.SliceandDice:IsCastable() and targetRange8 and Player:BuffRemains(S.SliceandDice) < 5 and not Player:Buff(S.VanishBuff) then
		return S.SliceandDice:Cast()
	end

	--killing_spree,if=debuff.ghostly_strike.up|!talent.ghostly_strike
	if S.KillingSpree:IsReady() and targetRange8 and (Target:Debuff(S.GhostlyStrike) or not S.GhostlyStrike:IsAvailable()) then
		return S.KillingSpree:Cast()
	end
	
	--cold_blood
	if S.ColdBlood:IsReady() and not Player:Buff(S.ColdBlood) and targetRange8 then
		return S.ColdBlood:Cast()
	end
   
    -- dispatch
	if S.Dispatch:IsReady() and targetRange8 and finish_condition
    and (S.ShadowDance:CooldownRemains()>Player:GCD() 
    and S.Vanish:CooldownRemains()>Player:GCD() or not RubimRH.CDsON() or S.BetweentheEyes:CooldownRemains()>Player:GCD()) then
		return S.Dispatch:Cast()    
	end

	return nil
end

	
local function APL()
RtB_Buffs()

inRange5 = RangeCount(5)
inRange8 = RangeCount(8)
inRange10 = RangeCount(10)
inRange15 = RangeCount(15)
inRange20 = RangeCount(20)
inRange25 = RangeCount(25)
inRange30 = RangeCount(30)
targetRange5 = IsItemInRange(8149, "target")
targetRange8 = IsItemInRange(34368, "target")
targetRange10 = IsItemInRange(32321, "target")
targetRange15 = IsItemInRange(33069, "target")
targetRange20 = IsItemInRange(10645, "target")
targetRange25 = IsItemInRange(24268, "target")
targetRange30 = IsItemInRange(835, "target")


-- --------------------------------------------------------------------------------------------------------------------------------------------
-- --Functions/Variables-----------------------------------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------------------------------------------------
if Player:IsCasting() or Player:IsChanneling() then
	return 0, "Interface\\Addons\\Rubim-RH\\Media\\channel.tga"
elseif Player:IsDeadOrGhost() or AuraUtil.FindAuraByName("Drink", "player") 
or AuraUtil.FindAuraByName("Food", "player") or AuraUtil.FindAuraByName("Food & Drink", "player") then
    return 0, "Interface\\Addons\\Rubim-RH\\Media\\griph.tga"
end


if true then
	tolerance = select(4, GetNetStats())/1000 + 0.18
    if (AuraUtil.FindAuraByName("Stealth", "player") or AuraUtil.FindAuraByName("Vanish", "player") or AuraUtil.FindAuraByName("Subterfuge", "player") or AuraUtil.FindAuraByName("Shadow Dance", "player")  or AuraUtil.FindAuraByName("Shadowmeld", "player")) then
        stealthall = true
    else
        stealthall = false
    end

	local will_lose_broadside = (Player:Buff(S.Broadside) and (math.abs(Player:BuffRemains(S.Broadside) - RtBRemains()) < 0.1 or math.abs(Player:BuffRemains(S.Broadside) - RtBRemains()) >= 0.1 and Player:BuffRemains(S.Broadside) < RtBRemains()))

	local will_lose_buried_treasure = (Player:Buff(S.BuriedTreasure) and (math.abs(Player:BuffRemains(S.BuriedTreasure) - RtBRemains()) < 0.1 or math.abs(Player:BuffRemains(S.BuriedTreasure) - RtBRemains()) >= 0.1 and Player:BuffRemains(S.BuriedTreasure) < RtBRemains()))

	local will_lose_grand_melee = (Player:Buff(S.GrandMelee) and (math.abs(Player:BuffRemains(S.GrandMelee) - RtBRemains()) < 0.1 or math.abs(Player:BuffRemains(S.GrandMelee) - RtBRemains()) >= 0.1 and Player:BuffRemains(S.GrandMelee) < RtBRemains()))

	local will_lose_ruthless_precision = (Player:Buff(S.RuthlessPrecision) and (math.abs(Player:BuffRemains(S.RuthlessPrecision) - RtBRemains()) < 0.1 or math.abs(Player:BuffRemains(S.RuthlessPrecision) - RtBRemains()) >= 0.1 and Player:BuffRemains(S.RuthlessPrecision) < RtBRemains()))

	local will_lose_skull_and_crossbones = (Player:Buff(S.SkullandCrossbones) and (math.abs(Player:BuffRemains(S.SkullandCrossbones) - RtBRemains()) < 0.1 or math.abs(Player:BuffRemains(S.SkullandCrossbones) - RtBRemains()) >= 0.1 and Player:BuffRemains(S.SkullandCrossbones) < RtBRemains()))

	local will_lose_true_bearing = (Player:Buff(S.TrueBearing) and (math.abs(Player:BuffRemains(S.TrueBearing) - RtBRemains()) < 0.1 or math.abs(Player:BuffRemains(S.TrueBearing) - RtBRemains()) >= 0.1 and Player:BuffRemains(S.TrueBearing) < RtBRemains()))

	local rtb_buffs_will_lose = (Cache.APLVar.RtB_Buffs.Shorter + Cache.APLVar.RtB_Buffs.Normal)

	-- if Player:Buff(S.Broadside) then print('will lose broadside: ', will_lose_broadside) end
	-- if Player:Buff(S.BuriedTreasure) then print('will lose buried treasure: ', will_lose_buried_treasure) end
	-- if Player:Buff(S.GrandMelee) then print('will lose grand melee: ', will_lose_grand_melee) end
	-- if Player:Buff(S.RuthlessPrecision) then print('will lose ruthless precision: ', will_lose_ruthless_precision) end
	-- if Player:Buff(S.SkullandCrossbones) then print('will lose skull and crossbones: ', will_lose_skull_and_crossbones) end
	-- if Player:Buff(S.TrueBearing) then print('will lose true bearing: ', will_lose_true_bearing) end
	-- print(rtb_buffs_will_lose)
	if not stealthall or (not Player:AffectingCombat() and not Player:Buff(S.VanishBuff)) or inRange30 == 0 then
		if S.Crackshot:IsAvailable() and S.HiddenOpportunity:IsAvailable() and tierequipped() < 4 then

			--Crackshot builds without T31 should reroll for True Bearing (or Broadside without Hidden Opportunity) if we won't lose over 1 buff
			--variable,name=rtb_reroll,if=talent.crackshot&talent.hidden_opportunity&!set_bonus.tier31_4pc,value=(!rtb_buffs.will_lose.true_bearing&talent.hidden_opportunity|!rtb_buffs.will_lose.broadside&!talent.hidden_opportunity)&rtb_buffs.will_lose<=1

			rtb_reroll = ((not will_lose_true_bearing and S.HiddenOpportunity:IsAvailable() or not will_lose_broadside and not S.HiddenOpportunity:IsAvailable()) and rtb_buffs_will_lose <= 1)
		elseif S.Crackshot:IsAvailable() and tierequipped() >= 4 then

			--Crackshot builds with T31 should reroll if we won't lose over 1 buff (2 with Loaded Dice), and if Broadside is not active for builds without Hidden Opportunity
			--variable,name=rtb_reroll,if=talent.crackshot&set_bonus.tier31_4pc,value=(rtb_buffs.will_lose<=1+buff.loaded_dice.up)&(talent.hidden_opportunity|!buff.broadside.up)

			rtb_reroll = (rtb_buffs_will_lose <= 1 + num(Player:Buff(S.LoadedDiceBuff))) and (S.HiddenOpportunity:IsAvailable() or not Player:Buff(S.Broadside))
		elseif not S.Crackshot:IsAvailable() and S.HiddenOpportunity:IsAvailable() then

			--Hidden Opportunity builds without Crackshot should reroll for Skull and Crossbones or any 2 buffs excluding Grand Melee in single target
			--variable,name=rtb_reroll,if=!talent.crackshot&talent.hidden_opportunity,value=!rtb_buffs.will_lose.skull_and_crossbones&(rtb_buffs.will_lose<2+rtb_buffs.will_lose.grand_melee&spell_targets.blade_flurry<2&raid_event.adds.in>10)	

			rtb_reroll = not will_lose_skull_and_crossbones and (rtb_buffs_will_lose < 2 + num(will_lose_grand_melee and inRange10< 2))
		else

			--Additional reroll rules if all active buffs will not be rolled away and we don't already have 5+ buffs
			--variable,name=rtb_reroll,value=variable.rtb_reroll|rtb_buffs.normal=0&rtb_buffs.longer>=1&rtb_buffs<5&rtb_buffs.max_remains<=39

			rtb_reroll = Cache.APLVar.RtB_Buffs.Normal == 0 and Cache.APLVar.RtB_Buffs.Longer >= 1 and RtB_Buffs() < 5 and MaxRtB_BuffRemains() <= 39

		end

	else

		rtb_reroll = false

	end

fthrank = (S.FantheHammer:IsAvailable() and 2 or 0)

-- (With 4 set tier) Use :rtb: Roll the Bones:
-- If you have 0 buffs.
-- Reroll if you have 1 buff.
-- Reroll if you have 2 buffs and :loaded_dice: Loaded Dice is active.
-- If you don't have to reroll, you should still not let your buffs fully expire. Roll again when they have like 2 seconds remaining, so that the 4pc always activates.
-- If you are about to go into a stealth window, then roll early if your highest duration buff has under ~7 seconds remaining.

basic_rtb_reroll = S.RolltheBones:CooldownUp() and ((tierequipped()>=4 and (RtB_Buffs()<=1 or RtB_Buffs()==2 and Player:Buff(S.LoadedDiceBuff) or MaxRtB_BuffRemains()<3 or MaxRtB_BuffRemains()<7 and RubimRH.CDsON() and (S.Vanish:CooldownUp() or S.ShadowDance:CooldownUp()))
 or (tierequipped()<4 and (RtB_Buffs()==0 or RtB_Buffs()==1 and not Player:Buff(S.TrueBearing)))))

	local ercp = ((Player:Buff(S.EchoingReprimandCP2) and Player:ComboPoints() == 2) or (Player:Buff(S.EchoingReprimandCP3) and Player:ComboPoints() == 3) or (Player:Buff(S.EchoingReprimandCP4) and Player:ComboPoints() == 4) or (Player:Buff(S.EchoingReprimandCP5) and Player:ComboPoints() == 5))

	effective_combo_points = ercp == (true and 7 or Player:ComboPoints())
    
    trinket1 = GetInventoryItemID("player", 13)
	
	trinket2 = GetInventoryItemID("player", 14)

	trinket1ready = IsUsableItem(trinket1) and GetItemCooldown(trinket1) == 0 and IsEquippedItem(trinket1)
	
	trinket2ready = IsUsableItem(trinket2) and GetItemCooldown(trinket2) == 0 and IsEquippedItem(trinket2)

	elite = (UnitClassification("target") == "worldboss" or UnitClassification("target") == "rareelite" or UnitClassification("target") == "elite" or UnitClassification("target") == "rare" or target_is_dummy() or Target:IsAPlayer())

	--ambush_condition,value=(talent.hidden_opportunity|combo_points.deficit>=2+talent.improved_ambush+buff.broadside.up)&energy>=50
	ambushcondition = ((S.HiddenOpportunity:IsAvailable() or Player:ComboPointsDeficit() >= 2 + num(S.ImprovedAmbush:IsAvailable()) + num(Player:Buff(S.Broadside))) and Player:Energy() >= 50)

	vanishcondition = (S.HiddenOpportunity:IsAvailable() or not S.ShadowDance:IsAvailable() or not S.ShadowDance:CooldownUp())

	--shadow_dance_condition,value=buff.between_the_eyes.up&(!talent.hidden_opportunity|!buff.audacity.up&(talent.fan_the_hammer.rank<2|!buff.opportunity.up))&!talent.crackshot
	shadow_dance_condition = (Player:Buff(S.BetweentheEyes) and (not S.HiddenOpportunity:IsAvailable() or not Player:Buff(S.AudacityBuff) and (fthrank < 2 or not Player:Buff(S.Opportunity))) and not S.Crackshot:IsAvailable())

	--finish_condition,value=effective_combo_points>=cp_max_spend-1-(stealthed.all&talent.crackshot)
	finish_condition = (Player:ComboPoints() >= CPMaxSpend() - 1 - num(stealthall and S.Crackshot:IsAvailable()))

	bladeflurrysync = (inRange10< 2 or Player:BuffRemains(S.BladeFlurry) > Player:GCD())

	--variable,name=vanish_opportunity_condition,value=!talent.shadow_dance&talent.fan_the_hammer.rank+talent.quick_draw+talent.audacity<talent.count_the_odds+talent.keep_it_rolling
	vanish_opportunity_condition = (not S.ShadowDance:IsAvailable() and fthrank + num(S.QuickDraw:IsAvailable()) + num(S.Audacity:IsAvailable()) < num(S.CounttheOdds:IsAvailable()) + num(S.KeepitRolling:IsAvailable()))	

	level, affixIDs, wasEnergized = C_ChallengeMode.GetActiveKeystoneInfo()

	inInstance, instanceType = IsInInstance()

	local startTimeMS = (select(4, UnitCastingInfo('target')) or select(4, UnitChannelInfo('target')) or 0)

	local elapsedTimeca = ((startTimeMS > 0) and (GetTime() * 1000 - startTimeMS) or 0)

	local elapsedTimech = ((startTimeMS > 0) and (GetTime() * 1000 - startTimeMS) or 0)

	channelTime = elapsedTimech / 1000

	castTime = elapsedTimeca / 1000

    castchannelTime = math.random(275, 500) / 1000

	isEnraged = (AuraUtil.FindAuraByName("Enrage", "target") or UnitChannelInfo("target") == "Ragestorm" or AuraUtil.FindAuraByName("Frenzy", "target"))

	HPpercentloss = MyHealthTracker.GetPredictedHealthLoss() * 3

	SnDAS = select(16, AuraUtil.FindAuraByName("Slice and Dice", "player"))
end


--------------------------------------------------------------------------------------------------------------------------------------------------------
--Out of Combat-----------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------
if not Player:AffectingCombat() and not Player:Buff(S.VanishBuff) and (IsResting("player") == false or Player:CanAttack(Target) or Player:StoppedFor()<5) then
    if S.BladeFlurry:IsReady() and Player:IsMoving() and targetRange8 and (Player:ComboPointsDeficit()>=3 or not Player:Buff(S.BladeFlurry)) and inRange10>=3 and not finish_condition then
        return S.BladeFlurry:Cast()
    end
		--ambush,if=talent.hidden_opportunity&(buff.audacity.up|buff.sepsis_buff.up)
        if S.Ambush:IsReady() and not finish_condition and S.PistolShot:TimeSinceLastCast()>0.5 and S.BladeFlurry:TimeSinceLastCast()>0.5 and targetRange8 and S.HiddenOpportunity:IsAvailable() and (Player:Buff(S.AudacityBuff) ) and Player:ComboPoints()<=5 then
            return S.audacitySS:Cast()
        end
        
    if S.Ambush:IsReady() and Player:IsMoving() and inRange10>=1 and targetRange8 then
        return S.Ambush:Cast()
    end

	if S.Stealth:IsUsableP() and S.Stealth:CooldownUp() and not AuraUtil.FindAuraByName("Stealth", "player") and RangeCount(10) == 0 and (IsResting("player") == false or Player:CanAttack(Target)) then
		return S.Stealth:Cast()
	end



	if inRange30 >= 1 and (not targetRange8 or not Player:CanAttack(Target)) and Player:IsMoving() and (IsInInstance() or Player:CanAttack(Target)) then
		if S.AdrenalineRush:IsCastable() and RubimRH.CDsON() and not finish_condition and S.UnderhandedUpperHand:IsAvailable() and not Player:Buff(S.AdrenalineRush) and stealthall and not Player:Buff(S.VanishBuff) and Player:BuffRemains(S.SliceandDice) < 8 then
			return S.AdrenalineRush:Cast()
		end

		if S.SliceandDice:IsCastable() and finish_condition and Player:BuffRemains(S.SliceandDice) < 8 then
			return S.SliceandDice:Cast()
		end
	
		if S.RolltheBones:IsCastable() and (rtb_reroll 
		or MaxRtB_BuffRemains() <= num(tierequipped() >= 4) * 3 + num(RubimRH.CDsON() and (S.ShadowDance:CooldownRemains() <= 1 or S.Vanish:CooldownRemains() <= 1)) * 5) then
			return S.RolltheBones:Cast()
		end
	end

	if S.CrimsonVial:IsCastable() and inRange20 == 0 and Player:HealthPercentage() < 75 and Player:EnergyDeficit() == 0 then
		return S.CrimsonVial:Cast()
	end
	
	if not Player:IsMoving() then 
		if S.InstantPoison:IsCastable() and S.InstantPoison:TimeSinceLastCast()>2 and not Player:Buff(S.WoundPoison) and Player:BuffRemains(S.InstantPoison) < 300 and not Player:IsCasting(S.InstantPoison) then
			return S.InstantPoison:Cast()
		end

		if S.CripplingPoison:IsCastable() and S.CripplingPoison:TimeSinceLastCast()>2 and not S.NumbingPoison:IsAvailable() and not S.AtrophicPoison:IsAvailable() and not Player:Buff(S.NumbingPoison) and not Player:Buff(S.AtrophicPoison) and Player:BuffRemains(S.CripplingPoison) < 300 and not Player:IsCasting(S.CripplingPoison) then
			return S.CripplingPoison:Cast()
		end

		if S.AtrophicPoison:IsCastable()and S.AtrophicPoison:TimeSinceLastCast()>2 and Player:BuffRemains(S.AtrophicPoison) < 300 and not Player:IsCasting(S.AtrophicPoison) then
			return S.AtrophicPoison:Cast()
		end

		if S.NumbingPoison:IsCastable() and S.NumbingPoison:TimeSinceLastCast()>2 and Player:BuffRemains(S.NumbingPoison) < 300 and not Player:IsCasting(S.NumbingPoison) then
			return S.NumbingPoison:Cast()
		end
	end
end

--------------------------------------------------------------------------------------------------------------------------------------------------------
--Spell Queue-------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------
if (not RubimRH.queuedSpell[1]:CooldownUp() or not RubimRH.queuedSpell[1]:IsAvailable()) and S.lustAT:ID() ~= RubimRH.queuedSpell[1]:ID() then
	RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
end

if S.lustAT:ID() == RubimRH.queuedSpell[1]:ID() and (Player:DebuffP(S.lust1) or Player:DebuffP(S.lust2) or Player:DebuffP(S.lust3) or Player:DebuffP(S.lust4) or Player:DebuffP(S.lust5)) then
	RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
end

if S.lustAT:ID() == RubimRH.queuedSpell[1]:ID() and not Player:DebuffP(S.lust1) and not Player:DebuffP(S.lust2) and not Player:DebuffP(S.lust3) and not Player:DebuffP(S.lust4) and not Player:DebuffP(S.lust5) and IsUsableItem(193470) and GetItemCooldown(193470) == 0 then
	return S.lustAT:Cast() -- BIND LUST KEYBIND IN BINDPAD TO ARCANE TORRENT
end

if S.Feint:ID() == RubimRH.queuedSpell[1]:ID() and Player:Buff(S.Feint) then
	RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
end


if S.KidneyShot:ID() == RubimRH.queuedSpell[1]:ID() and (Target:DebuffP(S.CheapShot) or Target:DebuffP(S.KidneyShot) or Target:DebuffP(S.Blind) or Target:DebuffP(S.Gouge)) then
	RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
end

if S.Gouge:ID() == RubimRH.queuedSpell[1]:ID() and (Target:DebuffP(S.CheapShot) or Target:DebuffP(S.KidneyShot) or Target:DebuffP(S.Blind)) then
	RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
end

if (inRange30==0 or not Player:AffectingCombat()) then
	RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
end

if RubimRH.QueuedSpell():IsReadyQueue() then
	return RubimRH.QueuedSpell():Cast()
end
-- --------------------------------------------------------------------------------------------------------------------------------------------------------
-- --Interrupts/Tranqs/Dispels-----------------------------------------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------------------------------------------------------------
if RubimRH.InterruptsON() and not AuraUtil.FindAuraByName("Stealth", "player") and Player:CanAttack(Target) and Player:AffectingCombat()  then
	--Kick
	if S.Kick:IsReady() 
     and kickprio() 
    and targetRange8 and (castTime > castchannelTime+0.5 or channelTime > castchannelTime+0.5)  and select(8, UnitCastingInfo("target")) == false  and not isEnraged then
		return S.Kick:Cast()
	end

	-- --blind
	if S.Blind:IsReady() and blindprio() 
    and targetRange20 and (castTime>castchannelTime+0.5 or channelTime>castchannelTime+0.5) and not isEnraged then
		return S.Blind:Cast()
	end


	-- --Stun
	if S.KidneyShot:IsReady() and stunprio() 
    and targetRange8 and (castTime>castchannelTime+0.5 or channelTime>castchannelTime+0.5)  and not isEnraged then
		return S.KidneyShot:Cast()
	end

    if S.Blind:IsReady() and targetRange30 and not Player:IsMoving() and UnitName('target') == 'Incorporeal Being'  and not AuraUtil.FindAuraByName("Blind","target","PLAYER|HARMFUL") and not AuraUtil.FindAuraByName("Kidney Shot","target","PLAYER|HARMFUL") and not AuraUtil.FindAuraByName("Turn Evil","target","PLAYER|HARMFUL") and not AuraUtil.FindAuraByName("Repentance","target","PLAYER|HARMFUL") and not AuraUtil.FindAuraByName("Hammer of Justice","target","PLAYER|HARMFUL")  then
        return S.Blind:Cast()
        end
        
    if S.KidneyShot:IsReady() and targetRange10 and UnitName('target') == 'Incorporeal Being' and not AuraUtil.FindAuraByName("Blind","target","PLAYER|HARMFUL") and not AuraUtil.FindAuraByName("Kidney Shot","target","PLAYER|HARMFUL") and not AuraUtil.FindAuraByName("Turn Evil","target","PLAYER|HARMFUL") and not AuraUtil.FindAuraByName("Repentance","target","PLAYER|HARMFUL") and not AuraUtil.FindAuraByName("Hammer of Justice","target","PLAYER|HARMFUL") then
        return S.KidneyShot:Cast()
        end



	--Shiv
	if S.Shiv:IsReady() and targetRange8 and isEnraged and Player:AffectingCombat() and TargetTTD() > 8 and TargetTTD() <100 and UnitName("target")~= "Soul Thorns" then
		return S.Shiv:Cast()
	end
end
-- --------------------------------------------------------------------------------------------------------------------------------------------------------
-- --Defensives--------------------------------------------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------------------------------------------------------------
if Player:AffectingCombat() and not AuraUtil.FindAuraByName("Stealth", "player") then
 


    if S.Feint:IsReady() and not Player:Debuff(S.Legacyofwaycrest) and not Player:Buff(S.Feint) and level>5 and inRange30>=1 and (mitigate()  or
    AuraUtil.FindAuraByName("Dread Inferno", "player", "HARMFUL") or Player:Debuff(S.chronofaded) ) then
        return S.Feint:Cast()
    end

    if Player:AffectingCombat() and not AuraUtil.FindAuraByName("Stealth", "player") and HPpercentloss > 0  then
        if I.HPpotID:IsReady() and Player:HealthPercentage() <= 35 then
            return I.HPIcon:Cast()
        end
        if S.Evasion:IsCastable() and (Player:Debuff(S.shadetarget) and Player:HealthPercentage()<75 or inRange10>=1 and Player:HealthPercentage()<45) then
            return S.Evasion:Cast()
            end
            if S.CloakofShadows:IsCastable() and Player:HealthPercentage()<15 and HPpercentloss>25 then
                return S.CloakofShadows:Cast()
                end 
    end

end
--------------------------------------------------------------------------------------------------------------------------------------------
--Rotation----------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
--print('SubterfugeBuff: ',Player:BuffRemains(S.SubterfugeBuff),'  ShadowDanceBuff: ',Player:BuffRemains(S.ShadowDanceBuff), '  GCDRemains: ',Player:GCDRemains())
--print('Reroll: ',rtb_reroll,' Duration reroll: ',MaxRtB_BuffRemains() <= num(tierequipped() >= 4) * 3 + num(RubimRH.CDsON() and (S.ShadowDance:CooldownRemains() <= 1 or S.Vanish:CooldownRemains() <= 1)) * 5)
if Player:CanAttack(Target) and not Target:IsDeadOrGhost() and (Player:AffectingCombat() or Player:Buff(S.VanishBuff)) then
	if HL.CombatTime()>1 and not IsCurrentSpell(6603) and not Player:Buff(S.VanishBuff) and not Player:Buff(S.Stealth) and targetRange20 then
		return S.autoattack:Cast()
	end

    if RubimRH.CDsON() and Player:CanAttack(Target) then
        if trinket1ready and RangeCount(20) >= 1 then
            return I.tx1:Cast()
        end
    end

	-- actions+=/call_action_list,name=cds
	if cooldowns() then
		return cooldowns()
	end

	--actions+=/call_action_list,name=stealth,if=stealthed.all
	if stealth() and stealthall then
		return stealth()
	end

	--actions+=/run_action_list,name=finish,if=variable.finish_condition
	if finishers() and finish_condition then
		return finishers()
	end

	-- actions+=/call_action_list,name=build
	if builders() then
		return builders()
	end
end

-- --------------------------------------------------------------------------------------------------------------------------------------------------------
-- --Out of Range------------------------------------------------------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------------------------------------------------------------
    if not targetRange10 and not Target:Debuff(S.Blind) and Player:CanAttack(Target) and not AuraUtil.FindAuraByName("Stealth", "player") and not Player:Buff(S.VanishBuff) and Player:AffectingCombat() then
        if S.BetweentheEyes:IsReady() and targetRange30 and EnergyTimeToMaxRounded() <= Player:GCD() and finish_condition and S.Crackshot:IsAvailable() and (S.Vanish:CooldownRemains() > 45 and S.ShadowDance:CooldownRemains() > 15) then
            return S.BetweentheEyes:Cast()
        end

        if S.PistolShot:IsReady() and S.Ambush:TimeSinceLastCast()>0.5 and S.PistolShot:TimeSinceLastCast()>0.5 and S.BladeFlurry:TimeSinceLastCast()>0.5 and targetRange30 and Player:EnergyDeficitPredicted() < 25 and (Player:ComboPointsDeficit() >= 1 or EnergyTimeToMaxRounded() <= Player:GCD()) then
            return S.PistolShot:Cast()
        end
    end

    return 0, "Interface\\Addons\\Rubim-RH\\Media\\griph.tga"
end

RubimRH.Rotation.SetAPL(260, APL);

local function PASSIVE()

end

RubimRH.Rotation.SetPASSIVE(260, PASSIVE);