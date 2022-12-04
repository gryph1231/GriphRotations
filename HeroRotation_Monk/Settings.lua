--- ============================ HEADER ============================
--- ======= LOCALIZE =======
-- Addon
local addonName, addonTable = ...
-- HeroRotation
local HR = HeroRotation
-- HeroLib
local HL = HeroLib
-- File Locals
local GUI = HL.GUI
local CreateChildPanel = GUI.CreateChildPanel
local CreatePanelOption = GUI.CreatePanelOption
local CreateARPanelOption = HR.GUI.CreateARPanelOption
local CreateARPanelOptions = HR.GUI.CreateARPanelOptions

--- ============================ CONTENT ============================
-- All settings here should be moved into the GUI someday.
HR.GUISettings.APL.Monk = {
  Commons = {
    Enabled = {

   HealthPotion = true,
      Trinkets = true,
      Potions = true,
    },
    DisplayStyle = {
      
    HealthPotion = "Main Icon",
      Potions = "Suggested",
      -- Covenant = "Suggested",
      Trinkets = "Suggested",
      Items = "Suggested"
    },
    HealthPotionHealth = 30,
    DampenHarmHP = 60,
    FortifyingBrewHP = 40,
    DiffuseMagicHP = 65,
    -- {Display GCD as OffGCD, ForceReturn}
    GCDasOffGCD = {
      -- Abilities
      LegSweep = true,
      -- RingOfPeace = true,
      -- Paralysis = true,
    },
    -- {Display OffGCD as OffGCD, ForceReturn}
    OffGCDasOffGCD = {
      -- Racials
      Racials = true,
      -- Abilities
      Interrupts = true,
    }
  },
  Brewmaster = {
    PotionType = {
      Selected = "Power",
    },
    -- DisplayStyle
    DisplayStyle = {

    },
    -- {Display GCD as OffGCD, ForceReturn}
    GCDasOffGCD = {
      -- Abilities
      InvokeNiuzaoTheBlackOx = true,
      TouchOfDeath           = true,
    },
    -- {Display OffGCD as OffGCD, ForceReturn}
    OffGCDasOffGCD = {
      -- Racials
      -- Abilities
      BlackOxBrew            = true,
      PurifyingBrew          = true,
    }
  },
  Windwalker = {
    PotionType = {
      Selected = "Power",
    },
TouchofKarmaHP = 65,
    -- DisplayStyle
    DisplayStyle = {
  
    },
    IgnoreToK = false,
    -- IgnoreFSK = true,
    -- {Display GCD as OffGCD, ForceReturn}
    GCDasOffGCD = {
      -- Abilities

    },
    -- {Display OffGCD as OffGCD, ForceReturn}
    OffGCDasOffGCD = {
      -- Racials
      -- Abilities
      EnergizingElixir        = true,
      Serenity                = true,
      StormEarthAndFire       = true,
    }
  


  },
  Mistweaver = {
    PotionType = {
      Selected = "Power",
    },
    -- Defensives

    -- DisplayStyle
    DisplayStyle = {

    },
    -- {Display GCD as OffGCD, ForceReturn}
    GCDasOffGCD = {
      -- Abilities
      InvokeYulonTheJadeSerpent = true,
      InvokeChiJiTheRedCrane    = true,
      SummonJadeSerpentStatue   = true,
      RenewingMist              = true,
      TouchOfDeath              = true,
      FortifyingBrew            = true,
    },
    -- {Display OffGCD as OffGCD, ForceReturn}
    OffGCDasOffGCD = {
      -- Racials
      -- Abilities
      ThunderFocusTea         = true,
    }
  }
};
HR.GUI.LoadSettingsRecursively(HR.GUISettings)

-- Child Panels
local ARPanel = HR.GUI.Panel
local CP_Monk = CreateChildPanel(ARPanel, "Monk")
local CP_Windwalker = CreateChildPanel(CP_Monk, "Windwalker")
local CP_Brewmaster = CreateChildPanel(CP_Monk, "Brewmaster")
local CP_Mistweaver = CreateChildPanel(CP_Monk, "Mistweaver")
-- Monk
CreateARPanelOptions(CP_Monk, "APL.Monk.Commons")
CreatePanelOption("Slider", CP_Monk, "APL.Monk.Commons.HealthPotionHealth", {0, 100, 1}, "Healing Potion HP Threshold", "Set the HP threshold for when to suggest Healing Potion use.)")
CreatePanelOption("Slider", CP_Monk, "APL.Monk.Commons.DampenHarmHP", {0, 100, 1}, "Dampen Harm HP Threshold", "Set the HP threshold for when to suggest Dampen Harm use.)")
CreatePanelOption("Slider", CP_Monk, "APL.Monk.Commons.FortifyingBrewHP", {0, 100, 1}, "Fortifying Brew HP Threshold", "Set the HP threshold for when to suggest Fortifying Brew use.)")
CreatePanelOption("Slider", CP_Monk, "APL.Monk.Commons.DiffuseMagicHP", {0, 100, 1}, "Diffuse Magic HP Threshold", "Set the HP threshold for when to suggest Diffuse Magic use.)")



-- Windwalker
CreateARPanelOptions(CP_Windwalker, "APL.Monk.Windwalker")
CreatePanelOption("CheckButton", CP_Windwalker, "APL.Monk.Windwalker.IgnoreToK", "Ignore Touch of Karma", "Enable this setting to allow you to ignore Touch of Karma without stalling the rotation. (NOTE: Touch of Karma will never be suggested if this is enabled)")
-- CreatePanelOption("CheckButton", CP_Windwalker, "APL.Monk.Windwalker.IgnoreFSK", "Ignore Flying Serpent Kick", "Enable this setting to allow you to ignore Flying Serpent Kick without stalling the rotation. (NOTE: Flying Serpent Kick will never be suggested if this is enabled)")
CreatePanelOption("Slider", CP_Windwalker, "APL.Monk.Windwalker.TouchofKarmaHP", {0, 100, 1}, "Touch of Karma HP Threshold", "Set the HP threshold for when to suggest Touch of Karma use.)")


-- Brewmaster
CreateARPanelOptions(CP_Brewmaster, "APL.Monk.Brewmaster")


-- Mistweaver
CreateARPanelOptions(CP_Mistweaver, "APL.Monk.Mistweaver")

