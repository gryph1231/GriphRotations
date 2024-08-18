    --- ============================ HEADER ============================
    local addonName, addonTable = ...;
    local HL = HeroLib;
    local Cache = HeroCache;
    local Unit = HL.Unit;
    local Player = Unit.Player;
    local Target = Unit.Target;
    local MouseOver = Unit.MouseOver;
    local Spell = HL.Spell;
    local Item = HL.Item;
    
    -- Items
    if not Item.DeathKnight then
        Item.DeathKnight = { };
    end
    Item.DeathKnight.Blood = {
        SephuzSecret = Item(132452, { 11, 12 }), --11/12
    }
    
    RubimRH.Spell[250] = {
        ArcaneTorrent = Spell(50613),
        Berserking = Spell(26297),
        BloodFury = Spell(20572),
        ActiveMitigation = Spell(180612),
        BloodBoil = Spell(50842),
        BloodDrinker = Spell(206931),
        BloodMirror = Spell(206977),
        BloodPlague = Spell(55078),
        BloodShield = Spell(77535),
        SoulReaper = Spell(343294),
        BoneShield = Spell(195181),
        AntiMagicZone = Spell(51052),
        BoneShieldBuff = Spell(195181),
        Bonestorm = Spell(194844),
        Lichborne = Spell(49039),
        Consumption = Spell(274156),
        CrimsonScourge = Spell(81141),
        DancingRuneWeapon = Spell(49028),
        DancingRuneWeaponBuff = Spell(81256),
        DeathandDecay = Spell(43265),
        DeathsCaress = Spell(195292),
        DeathStrike = Spell(49998),
        DeathsAdvance = Spell(48265),
        HemostasisBuff = Spell(273947),
        HeartBreaker = Spell(221536),
        HeartStrike = Spell(206930),
        HeartStrikez = Spell(287712), --haymaker
        Marrowrend = Spell(195182),
        MindFreeze = Spell(47528),
        Ossuary = Spell(219786),
        AbominationLimb = Spell(383269),
        RapidDecomposition = Spell(194662),
        RuneStrike = Spell(210764),
        RuneStrikeTalent = Spell(19217),
        UmbilicusEternus = Spell(193249),
        WraithWalk = Spell(212552),
        BlindingSleet = Spell(207167),
        IceboundFortitude = Spell(48792),
        VampiricBlood = Spell(55233),
        Coagulopathy = Spell(391481),
        IcyTalonsBuff = Spell(194879),
        PathOfFrost = Spell(3714),
        RuneTap = Spell(194679),
        Tombstone = Spell(219809),
        HaemostasisBuff = Spell(235558),
        SephuzBuff = Spell(208052),
        MurderousIntent = Spell(207018),
        Intimidated = Spell(206891),
        DeathChain = Spell(203173),
        DeathGrip = Spell(49576),
        autoattack = Spell(20549), --warstomp
        RaiseDead = Spell(46585),
        DarkCommand = Spell(56222),
        Asphyxiate = Spell(221562),
        GorefiendsGrasp = Spell(108199),
        RaiseAlly = Spell(61999),
        DeathCoil = Spell(47541),
    }
    
    local S = RubimRH.Spell[250]
    
    local I = Item.DeathKnight.Blood;
    
    -- Rotation Var
    local ShouldReturn; -- Used to get the return string
    -- Rotation Var
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
    
    local function Mitigate()
        -- if IsReady("Death Strike",1) and HPpercentloss > 7 and Player:HealthPercentage() <  then
        --     return S.DeathStrike:Cast()
        -- end  
    
        if IsReady("Vampiric Blood") and ((HPpercentloss > 7 and Player:HealthPercentage() < 75
        and (not AuraUtil.FindAuraByName("Lichborne", "player") and not AuraUtil.FindAuraByName("Icebound Fortitude", "player") or HPpercentloss > 21))
        or in_trouble)	then
            return S.VampiricBlood:Cast()
        end
        
        if IsReady("Lichborne") and ((HPpercentloss > 7 and Player:HealthPercentage() < 70
        and (not AuraUtil.FindAuraByName("Vampiric Blood", "player") and not AuraUtil.FindAuraByName("Icebound Fortitude", "player") or HPpercentloss > 21))
        or in_trouble) then
            return S.Lichborne:Cast()
        end
    
        if IsReady("Icebound Fortitude") and ((HPpercentloss > 18 and Player:HealthPercentage() < 50
        and (not AuraUtil.FindAuraByName("Lichborne", "player") and not AuraUtil.FindAuraByName("Vampiric Blood", "player") or HPpercentloss > 36))
        or in_trouble) then
            return S.IceboundFortitude:Cast()
        end
    
        return nil
    end
    
    local function Rotation()
        if AuraUtil.FindAuraByName("Dancing Rune Weapon", "player") then
            if IsReady("Marrowrend",1) and not AuraUtil.FindAuraByName("Bonestorm", "player") and Player:BuffRemains(S.DancingRuneWeaponBuff) <= Player:GCD() * 3
            and not AuraUtil.FindAuraByName("Abomination Limb", "player") and S.AbominationLimb:CooldownRemains() > 20 then
                return S.Marrowrend:Cast()
            end
    
            if IsReady("Consumption") and RangeCount(8) >= 1 and RangeCount(8) > RangeCount(30) * .75 then
                return S.Consumption:Cast()
            end
            
            if IsReady("Death and Decay") and tarnotmoving and RangeCount(8) > RangeCount(30) * .75 and UnitCanAttack("player","target") and not AuraUtil.FindAuraByName("Death and Decay", "player") and TargetinRange(8) and not Player:IsMoving() then
                return S.DeathandDecay:Cast()
            end
    
            if IsReady("Soul Reaper",1) and Target:HealthPercentage() < 35 then
                return S.SoulReaper:Cast()
            end
    
            if IsReady("Marrowrend",1) and Player:BuffStack(S.BoneShieldBuff) == 0 then
                return S.Marrowrend:Cast()
            end       
    
            if IsReady("Blood Boil") and RangeCount(8) >= 1 and S.BloodBoil:FullRechargeTime() < Player:GCD() then
                return S.BloodBoil:Cast()
            end   
    
            if IsReady("Bonestorm") and RubimRH.CDsON() and RangeCount(8) >= 1 and (Player:BuffStack(S.BoneShieldBuff) == 5 or (AuraUtil.FindAuraByName("Death and Decay", "player") and not Player:IsMoving())) then
                return S.Bonestorm:Cast()
            end 
    
            if IsReady("Death Strike",1) and (Player:RunicPower() >= 70 or Player:BuffRemains(S.Coagulopathy) <= Player:GCD()) then
                return S.DeathStrike:Cast()
            end  
    
            if IsReady("Heart Strike",1) then
                return S.HeartStrikez:Cast()
            end 
        end
    
        if not AuraUtil.FindAuraByName("Dancing Rune Weapon", "player") then
            if IsReady("Marrowrend",1) and AuraUtil.FindAuraByName("Bone Shield", "player") and Player:BuffRemains(S.BoneShieldBuff) < 3 then
                return S.Marrowrend:Cast()
            end
    
            if IsReady("Death and Decay") and tarnotmoving and RangeCount(8) > RangeCount(30) * .75 and UnitCanAttack("player","target") and not AuraUtil.FindAuraByName("Death and Decay", "player") and TargetinRange(8) and not Player:IsMoving() then
                return S.DeathandDecay:Cast()
            end
    
            if IsReady("Consumption") and RangeCount(8) >= 1 and RangeCount(8) > RangeCount(30) * .75 then
                return S.Consumption:Cast()
            end
    
            if IsReady("Soul Reaper",1) and Target:HealthPercentage() < 35 then
                return S.SoulReaper:Cast()
            end
    
            if IsReady("Marrowrend",1) and Player:BuffStack(S.BoneShieldBuff) <= 5 and Player:BuffRemains(S.BoneShieldBuff) > 10 and S.DancingRuneWeapon:CooldownRemains() > 3
            and not AuraUtil.FindAuraByName("Abomination Limb", "player") and (not RubimRH.CDsON() or (S.AbominationLimb:CooldownRemains() > 7 and S.DancingRuneWeapon:CooldownRemains() > 7)) then
                return S.Marrowrend:Cast()
            end 
    
            if IsReady("Dancing Rune Weapon") and tarnotmoving and RangeCount(8) > RangeCount(30) * .75 and RubimRH.CDsON() then
                return S.DancingRuneWeapon:Cast()
            end
    
            if IsReady("Bonestorm") and RubimRH.CDsON() and (Player:BuffStack(S.BoneShieldBuff) == 5 or (AuraUtil.FindAuraByName("Death and Decay", "player") and not Player:IsMoving())) then
                return S.Bonestorm:Cast()
            end 
    
            if IsReady("Death Strike",1) and (Player:RunicPower() >= 70 or Player:BuffRemains(S.IcyTalonsBuff) <= Player:GCD()) then
                return S.DeathStrike:Cast()
            end  
    
            if IsReady("Blood Boil") and RangeCount(8) >= 1 and S.BloodBoil:FullRechargeTime() < Player:GCD() then
                return S.BloodBoil:Cast()
            end  
    
            if IsReady("Heart Strike",1) then
                return S.HeartStrikez:Cast()
            end 
        end
    
        return nil
    end
    
    local function APL()
        print(IsReady("Heart Strike",1))
    --------------------------------------------------------------------------------------------------------------------------------------------
    ----------------------------------------------------------Functions/Top priorities----------------------------------------------------------
    --------------------------------------------------------------------------------------------------------------------------------------------
    if Player:IsCasting() or Player:IsChanneling() then
        return 0, "Interface\\Addons\\Rubim-RH\\Media\\channel.tga"
    elseif AuraUtil.FindAuraByName("Drink", "player") or AuraUtil.FindAuraByName("Food", "player") or AuraUtil.FindAuraByName("Food & Drink", "player") then
        return 0, "Interface\\Addons\\Rubim-RH\\Media\\mount2.tga"
    end
    
    local isTanking, status, threatpct, rawthreatpct, threatvalue = UnitDetailedThreatSituation("player", "target")
    
    HPpercentloss = MyHealthTracker.GetPredictedHealthLoss() * 3
    
    tarnotmoving = GetUnitSpeed("target") == 0
    
    elite = UnitClassification("target") == "worldboss" or UnitClassification("target") == "rareelite" or UnitClassification("target") == "elite" or UnitClassification("target") == "rare" or target_is_dummy() or Target:IsAPlayer()
    
    in_trouble = HPpercentloss > 0 and Player:HealthPercentage() < 20
    
    _,_,_,_,_,_,_,notInterruptible,_ = UnitCastingInfo("target")
        
    start_time_cast_ms = select(4, UnitCastingInfo('target')) or 0
    
    current_time_ms = GetTime() * 1000
    
    elapsed_time_cast_ca = (start_time_cast_ms > 0) and (current_time_ms - start_time_cast_ms) or 0
    
    cast_time = elapsed_time_cast_ca / 1000
    
    start_time_channel_ms = select(4, UnitChannelInfo('target')) or 0
    
    elapsed_time_channel_ch = (start_time_channel_ms > 0) and (current_time_ms - start_time_channel_ms) or 0
    
    channel_time = elapsed_time_channel_ch / 1000
    --------------------------------------------------------------------------------------------------------------------------------------------
    ----------------------------------------------------------Out of Combat---------------------------------------------------------------------
    --------------------------------------------------------------------------------------------------------------------------------------------
    if not Player:AffectingCombat() then
        if IsReady("Path of Frost") and not AuraUtil.FindAuraByName("Path of Frost", "player") and IsSwimming() then
            return S.PathOfFrost:Cast()
        end
    end
    --------------------------------------------------------------------------------------------------------------------------------------------
    ----------------------------------------------------------Spell Queue-----------------------------------------------------------------------
    --------------------------------------------------------------------------------------------------------------------------------------------
    if (not IsReady(RubimRH.queuedSpell[1]:ID(),nil,nil,1))
    or (S.DeathCoil:ID() == RubimRH.queuedSpell[1]:ID() and (not Player:CanAttack(Target) or TargetinRange(10)))
    or ((S.RaiseAlly:ID() == RubimRH.queuedSpell[1]:ID() and (Player:PrevGCD(1, S.RaiseAlly) or IsKeyDown('RightButton')))) then
        RubimRH.queuedSpell = { RubimRH.Spell[1].Empty, 0 }
    end
    
    if S.DeathCoil:ID() == RubimRH.queuedSpell[1]:ID() and Player:CanAttack(Target) then
        if TargetinRange(8) then
            if not C_Spell.IsCurrentSpell(6603) and not IsStealthed() then
                return S.autoattack:Cast()
            end
        elseif IsReady("Death Grip",1) and not TargetinRange(10) then 
            return S.DeathGrip:Cast()
        elseif IsReady("Death Coil",1) and not TargetinRange(10) then 
            return S.DeathCoil:Cast()
        elseif IsReady("Dark Command",1) and not TargetinRange(10) then 
            return S.DarkCommand:Cast()
        end
    end
    
    if IsReady(RubimRH.queuedSpell[1]:ID(),nil,nil,1) and S.DeathCoil:ID() ~= RubimRH.queuedSpell[1]:ID() then
        return RubimRH.QueuedSpell():Cast()
    end
    --------------------------------------------------------------------------------------------------------------------------------------------
    ---------------------------------------------------------Interrupts & Tranq-----------------------------------------------------------------
    --------------------------------------------------------------------------------------------------------------------------------------------
    if RubimRH.InterruptsON() then 
        if IsReady("Mind Freeze",1) and notInterruptible == false and (cast_time > Player:GCDRemains() + 0.47 or channel_time > Player:GCDRemains() + 0.47) then
            return S.MindFreeze:Cast()
        end
    end
    --------------------------------------------------------------------------------------------------------------------------------------------
    ----------------------------------------------------------Cooldowns-------------------------------------------------------------------------
    --------------------------------------------------------------------------------------------------------------------------------------------
    if RubimRH.CDsON() and Target:AffectingCombat() then
        if IsReady("Raise Dead") and tarnotmoving and RangeCount(8) > RangeCount(30) * .75 then
            return S.RaiseDead:Cast()
        end
    end
    --------------------------------------------------------------------------------------------------------------------------------------------
    ----------------------------------------------------------Rotation--------------------------------------------------------------------------
    --------------------------------------------------------------------------------------------------------------------------------------------
    if UnitCanAttack('player','target') and not Target:IsDeadOrGhost() and (Target:AffectingCombat() or C_Spell.IsCurrentSpell(6603)) then
        if IsReady("Dark Command",1) and isTanking == false then
            return S.DarkCommand:Cast()
        end
    
        if not C_Spell.IsCurrentSpell(6603) and TargetinRange(20) then
            return S.autoattack:Cast()
        end
    
        if not Player:IsTankingAoE(8) and RangeCount(8) >= 1 and RangeCount(8) > RangeCount(30) * .75  and not target_is_dummy() and IsResting("player") == false and not Target:IsAPlayer() and not in_trouble then
            if IsReady("Blood Boil") then
                return S.BloodBoil:Cast()
            end
        end
    
        if Mitigate() then
            return Mitigate()
        end
    
        if Rotation() then
            return Rotation()
        end
    end
        return 0, "Interface\\Addons\\Rubim-RH\\Media\\mount2.tga"
    end
    
    RubimRH.Rotation.SetAPL(250, APL);
    
    local function PASSIVE()
    end
    
    RubimRH.Rotation.SetPASSIVE(250, PASSIVE);
    