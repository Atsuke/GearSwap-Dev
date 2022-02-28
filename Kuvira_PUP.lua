----------------------------------------------------------------------------------------
--  __  __           _                     __   _____                        _
-- |  \/  |         | |                   / _| |  __ \                      | |
-- | \  / | __ _ ___| |_ ___ _ __    ___ | |_  | |__) |   _ _ __  _ __   ___| |_ ___
-- | |\/| |/ _` / __| __/ _ \ '__|  / _ \|  _| |  ___/ | | | '_ \| '_ \ / _ \ __/ __|
-- | |  | | (_| \__ \ ||  __/ |    | (_) | |   | |   | |_| | |_) | |_) |  __/ |_\__ \
-- |_|  |_|\__,_|___/\__\___|_|     \___/|_|   |_|    \__,_| .__/| .__/ \___|\__|___/
--                                                         | |   | |
--                                                         |_|   |_|
-----------------------------------------------------------------------------------------
--[[

    Originally Created By: Faloun
    Programmers: Arrchie, Kuroganashi, Byrne, Tuna
    Testers:Arrchie, Kuroganashi, Haxetc, Patb, Whirlin, Petsmart
    Contributors: Xilkk, Byrne, Blackhalo714

    ASCII Art Generator: http://www.network-science.de/ascii/
    
]]

-- Initialization function for this job file.
-- IMPORTANT: Make sure to also get the Mote-Include.lua file (and its supplementary files) to go with this.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include("Mote-Include.lua")
    include('organizer-lib')
end

function user_setup()
    -- Alt-F10 - Toggles Kiting Mode.

    --[[
        F9 - Cycle Offense Mode (the offensive half of all 'hybrid' melee modes).
        
        These are for when you are fighting with or without Pet
        When you are IDLE and Pet is ENGAGED that is handled by the Idle Sets
    ]]
    state.OffenseMode:options("MasterPet", "Master", "Trusts")

    --[[
        Ctrl-F9 - Cycle Hybrid Mode (the defensive half of all 'hybrid' melee modes).
        
        Used when you are Engaged with Pet
        Used when you are Idle and Pet is Engaged
    ]]
    state.HybridMode:options("Normal", "Acc", "TP", "DT", "Regen", "Ranged")

    --[[
        Alt-F12 - Turns off any emergency mode
        
        Ctrl-F10 - Cycle type of Physical Defense Mode in use.
        F10 - Activate emergency Physical Defense Mode. Replaces Magical Defense Mode, if that was active.
    ]]
    state.PhysicalDefenseMode:options("PetDT", "MasterDT")

    --[[
        Alt-F12 - Turns off any emergency mode

        F11 - Activate emergency Magical Defense Mode. Replaces Physical Defense Mode, if that was active.
    ]]
    state.MagicalDefenseMode:options("PetMDT")

    --[[ IDLE Mode Notes:

        F12 - Update currently equipped gear, and report current status.
        Ctrl-F12 - Cycle Idle Mode.
        
        Will automatically set IdleMode to Idle when Pet becomes Engaged and you are Idle
    ]]
    state.IdleMode:options("Idle", "MasterDT")

    --Various Cycles for the different types of PetModes
    state.PetStyleCycleTank = M {"NORMAL", "DD", "MAGIC", "SPAM"}
    state.PetStyleCycleMage = M {"NORMAL", "HEAL", "SUPPORT", "MB", "DD"}
    state.PetStyleCycleDD = M {"NORMAL", "BONE", "SPAM", "OD", "ODACC"}

    --The actual Pet Mode and Pet Style cycles
    --Default Mode is Tank
    state.PetModeCycle = M {"TANK", "DD", "MAGE"}
    --Default Pet Cycle is Tank
    state.PetStyleCycle = state.PetStyleCycleTank

    --Toggles
    --[[
        Alt + E will turn on or off Auto Maneuver
    ]]
    state.AutoMan = M(false, "Auto Maneuver")

    --[[
        //gs c toggle autodeploy
    ]]
    state.AutoDeploy = M(false, "Auto Deploy")

    --[[
        Alt + D will turn on or off Lock Pet DT
        (Note this will block all gearswapping when active)
    ]]
    state.LockPetDT = M(false, "Lock Pet DT")

    --[[
        Alt + (tilda) will turn on or off the Lock Weapon
    ]]
    state.LockWeapon = M(false, "Lock Weapon")

    --[[
        //gs c toggle setftp
    ]]
    state.SetFTP = M(false, "Set FTP")

   --[[
        This will hide the entire HUB
        //gs c hub all
    ]]
    state.textHideHUB = M(false, "Hide HUB")

    --[[
        This will hide the Mode on the HUB
        //gs c hub mode
    ]]
    state.textHideMode = M(false, "Hide Mode")

    --[[
        This will hide the State on the HUB
        //gs c hub state
    ]]
    state.textHideState = M(false, "Hide State")

    --[[
        This will hide the Options on the HUB
        //gs c hub options
    ]]
    state.textHideOptions = M(false, "Hide Options")

    --[[
        This will toggle the HUB lite mode
        //gs c hub lite
    ]]  
    state.useLightMode = M(false, "Toggles Lite mode")

    --[[
        This will toggle the default Keybinds set up for any changeable command on the window
        //gs c hub keybinds
    ]]
    state.Keybinds = M(true, "Hide Keybinds")

    --[[ 
        This will toggle the CP Mode 
        //gs c toggle CP 
    ]] 
    state.CP = M(false, "CP") 
    CP_CAPE = "Aptitude Mantle +1" 

    --[[
        Enter the slots you would lock based on a custom set up.
        Can be used in situation like Salvage where you don't want
        certain pieces to change.

        //gs c toggle customgearlock
        ]]
    state.CustomGearLock = M(false, "Custom Gear Lock")
    --Example customGearLock = T{"head", "waist"}
    customGearLock = T{}

    send_command("bind !f7 gs c cycle PetModeCycle")
    send_command("bind ^f7 gs c cycleback PetModeCycle")
    send_command("bind !f8 gs c cycle PetStyleCycle")
    send_command("bind ^f8 gs c cycleback PetStyleCycle")
    send_command("bind !e gs c toggle AutoMan")
    send_command("bind !d gs c toggle LockPetDT")
    send_command("bind !f6 gs c predict")
    send_command("bind ^` gs c toggle LockWeapon")
    send_command("bind home gs c toggle setftp")
    send_command("bind PAGEUP gs c toggle autodeploy")
    send_command("bind PAGEDOWN gs c hide keybinds")
    send_command("bind end gs c toggle CP") 
    send_command("bind = gs c clear")

    select_default_macro_book()

    -- Adjust the X (horizontal) and Y (vertical) position here to adjust the window
    -- pos_x = 2250
    -- pos_y = 370
    pos_x = 1150
    pos_y = 0
    setupTextWindow(pos_x, pos_y)
    
end

function file_unload()
    send_command("unbind !f7")
    send_command("unbind ^f7")
    send_command("unbind !f8")
    send_command("unbind ^f8")
    send_command("unbind !e")
    send_command("unbind !d")
    send_command("unbind !f6")
    send_command("unbind ^`")
    send_command("unbind home")
    send_command("unbind PAGEUP")
    send_command("unbind PAGEDOWN")       
    send_command("unbind end")
    send_command("unbind =")
end

function job_setup()
    include("/libs/PUP_LIB.lua")
end

function init_gear_sets()
include("kuvira_AugGear.lua")
    --Table of Contents
    ---Gear Variables
    ---Master Only Sets
    ---Hybrid Only Sets
    ---Pet Only Sets
    ---Misc Sets

    -------------------------------------------------------------------------
    --  _____                  __      __        _       _     _
    -- / ____|                 \ \    / /       (_)     | |   | |
    --| |  __  ___  __ _ _ __   \ \  / /_ _ _ __ _  __ _| |__ | | ___  ___
    --| | |_ |/ _ \/ _` | '__|   \ \/ / _` | '__| |/ _` | '_ \| |/ _ \/ __|
    --| |__| |  __/ (_| | |       \  / (_| | |  | | (_| | |_) | |  __/\__ \
    -- \_____|\___|\__,_|_|        \/ \__,_|_|  |_|\__,_|_.__/|_|\___||___/
    -------------------------------------------------------------------------
    --[[
        This section is best ultilized for defining gear that is used among multiple sets
        You can simply use or ignore the below
    ]]
    Animators = {}
    --Animators.Range = "Animator P II"
    --Animators.Range = "Divinator II"
    Animators.Melee = "Animator P +1"
    --Animators.Melee = "Neo Animator"
    
    Visucius = {}
    Visucius.TP      = { name="Visucius's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+8','"Dbl.Atk."+10',}}
	Visucius.DA      = { name="Visucius's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Damage taken-5%',}}
	Visucius.CRIT    = { name="Visucius's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Crit.hit rate+10','Phys. dmg. taken-10%',}}
    Visucius.STRWSD  = { name="Visucius's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}
	Visucius.PetTank = { name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: "Regen"+10','System: 1 ID: 1247 Val: 4',}}
	Visucius.Hybrid  = { name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10','System: 1 ID: 1246 Val: 4',}}
	                  
    
    --Adjust to your reforge level
    --Sets up a Key, Value Pair
    AF = {}
    AF.Head = "Foire Taj +2"
    AF.Body = "Foire Tobe +2"
    AF.Hands = "Foire Dastanas +2"
    AF.Legs = "Foire Churidars +2"
    AF.Feet = "Foire Babouches +2"

    RELIC = {}
    RELIC.Head = "Pitre Taj +3" --Enhances Optimization
    RELIC.Body = "Pitre Tobe +3" --Enhances Overdrive
    RELIC.Hands = "Pitre Dastanas +3" --Enhances Fine-Tuning
    RELIC.Legs = "Pitre Churidars +3" --Enhances Ventriloquy
    RELIC.Feet = "Pitre Babouches +3" --Role Reversal

    EMPY = {}
    EMPY.Head = "Karagoz Capello +1"
    EMPY.Body = "Karagoz Farsetto +1"
    EMPY.Hands = "Karagoz Guanti +1"
    EMPY.Legs = "Karagoz Pantaloni +1"
    EMPY.Feet= "Karagoz Scarpe +1"

    sets.organizer = { 
        main="Midnights",
        sub="Puppetry Tobe",
        ammo="Sakpata's Fists",
        ear1="Neo Animator",
        ear2="Ohtas",
        hands="Tali'ah Gages +1",
        legs="Puppetry Churidars",
        feet="Divinator II",
        body="Tali'ah Crackows +2"
    }
    --------------------------------------------------------------------------------
    --  __  __           _               ____        _          _____      _
    -- |  \/  |         | |             / __ \      | |        / ____|    | |
    -- | \  / | __ _ ___| |_ ___ _ __  | |  | |_ __ | |_   _  | (___   ___| |_ ___
    -- | |\/| |/ _` / __| __/ _ \ '__| | |  | | '_ \| | | | |  \___ \ / _ \ __/ __|
    -- | |  | | (_| \__ \ ||  __/ |    | |__| | | | | | |_| |  ____) |  __/ |_\__ \
    -- |_|  |_|\__,_|___/\__\___|_|     \____/|_| |_|_|\__, | |_____/ \___|\__|___/
    --                                                  __/ |
    --                                                 |___/
    ---------------------------------------------------------------------------------
    --This section is best utilized for Master Sets
    --[[
        Will be activated when Pet is not active, otherwise refer to sets.idle.Pet
    ]]
    sets.idle = {
        main="Sakpata's Fists",
		range = "Animator P +1",
		ammo = "Automat. Oil +3",
		head = "Heyoka Cap",
		body = "Mpaca's Doublet",
		hands = "Mpaca's Gloves",
		legs = "Mpaca's Hose",
		feet = "Mpaca's Boots",
		neck = "Shulmanu Collar",
		waist = "Moonbow Belt",
		left_ear = "Enmerkar Earring",
		right_ear = "Telos Earring",
		left_ring = "C. Palug Ring",
		right_ring = "Niqmaddu Ring",
		back = Visucius.DA,
    }

    -------------------------------------Fastcast
    sets.precast.FC = {}

    -------------------------------------Midcast
    sets.midcast = {} --Can be left empty

    sets.midcast.FastRecast = {
       -- Add your set here 
    }

    -------------------------------------Kiting
    sets.Kiting = {}

    -------------------------------------JA
    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck = "Magoraga Beads"})

    -- Precast sets to enhance JAs
    sets.precast.JA = {} -- Can be left empty

    sets.precast.JA["Tactical Switch"] = {
        feet = EMPY.Feet
    }

    sets.precast.JA["Ventriloquy"] = {
        legs = RELIC.Legs
    }

    sets.precast.JA["Role Reversal"] = {
        feet = RELIC.Feet
    }

    sets.precast.JA["Overdrive"] = {
        body = RELIC.Body
    }

    sets.precast.JA["Repair"] = {
        ammo="Automat. Oil +3",
        feet= AF.Feet
    }

    sets.precast.JA["Maintenance"] = set_combine(sets.precast.JA["Repair"], {})

    sets.precast.JA.Maneuver = {
        neck = "Buffoon's Collar",
        body = EMPY.Body,
        hands = AF.Hands,
    }

    sets.precast.JA["Activate"] = {
	back=Visucius.DA,
        feet = "Mpaca's Boots"
    }

    sets.precast.JA["Deus Ex Automata"] = sets.precast.JA["Activate"]

    sets.precast.JA["Provoke"] = {}

    --Waltz set (chr and vit)
    sets.precast.Waltz = {
       feet = "Rawhide boots" 
    }

    sets.precast.Waltz["Healing Waltz"] = {}

    -------------------------------------WS
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        head = { name="Blistering Sallet +1", augments={'Path: A',}},
		body = "Mpaca's Doublet",
		hands = Ryuo.Hands.A,
		legs = "Mpaca's Hose",
		feet = "Mpaca's Boots",
		neck = "Fotia Gorget",
		waist = "Moonbow Belt",
		left_ear = "Brutal Earring",
		right_ear = { name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		left_ring = "Ifrit Ring",
		right_ring = "Niqmaddu Ring",
		back = Visucius.CRIT,
    }

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS["Stringing Pummel"] = set_combine(sets.precast.WS, {
		feet = Herc.Feet.MAB,
		waist = "Fotia Belt"		
	})
		
    sets.precast.WS["Victory Smite"] = set_combine(sets.precast.WS, {
        
    })
    sets.precast.WS["Howling Fist"] = set_combine(sets.precast.WS["Victory Smite"], {
        ear1 = "Schere Earring",
        neck = "Shulmanu Collar",
        body = "Tali'ah Manteel +2",
    })

    sets.precast.WS["Shijin Spiral"] = set_combine(sets.precast.WS, {
       
		body = "Tali'ah Manteel +2",
		hands = Herc.Hands.WSD,
		legs = Herc.Legs.WSD,
		feet = Herc.Feet.MAB,
		neck = "Fotia Gorget",
		waist = "Fotia Belt",
		left_ring = "Rajas Ring",
})

    -------------------------------------Idle
    --[[
        Pet is not active
        Idle Mode = MasterDT
    ]]
    sets.idle.MasterDT = {
        head = "Mpaca's Cap",
		body = "Mpaca's Doublet",
		hands = "Mpaca's Gloves",
		legs = "Mpaca's Hose",
		feet = "Malignance Boots",
		neck = "Loricate Torque +1",
		waist = "Moonbow Belt",
		left_ear = "Etiolation Earring",
		right_ear = "Infused Earring",
		left_ring = "C. Palug Ring",
		right_ring = "Defending Ring",
		back = Visucius.DA,
    }

    -------------------------------------Engaged
    --[[
        Offense Mode = Master
        Hybrid Mode = Normal
    ]]
    sets.engaged.Master = {
        ammo = "Automat. Oil +3",
		head = "Heyoka Cap",
		body = "Mpaca's Doublet",
		hands = "Mpaca's Gloves",
		legs = "Mpaca's Hose",
		feet = "Mpaca's Boots",
		neck = "Shulmanu Collar",
		waist = "Moonbow Belt",
		left_ear = "Enmerkar Earring",
		right_ear = "Telos Earring",
		left_ring = "C. Palug Ring",
		right_ring = "Niqmaddu Ring",
		back = Visucius.DA,
    }

    -------------------------------------Acc
    --[[
        Offense Mode = Master
        Hybrid Mode = Acc
    ]]
    sets.engaged.Master.Acc = set_combine(sets.engaged.Master, {
        ear1 = "Cessance Earring",
    })

    -------------------------------------TP
    --[[
        Offense Mode = Master
        Hybrid Mode = TP
    ]]
    sets.engaged.Master.TP = sets.engaged.Master

    -------------------------------------DT
    --[[
        Offense Mode = Master
        Hybrid Mode = DT
    ]]
    sets.engaged.Master.DT = set_combine(sets.engaged.Master, { 
        head = "Mpaca's Cap",
        ring2 = "Defending Ring"
    })

    ----------------------------------------------------------------------------------
    --  __  __         _           ___     _     ___      _
    -- |  \/  |__ _ __| |_ ___ _ _| _ \___| |_  / __| ___| |_ ___
    -- | |\/| / _` (_-<  _/ -_) '_|  _/ -_)  _| \__ \/ -_)  _(_-<
    -- |_|  |_\__,_/__/\__\___|_| |_| \___|\__| |___/\___|\__/__/
    -----------------------------------------------------------------------------------

    --[[
        These sets are designed to be a hybrid of player and pet gear for when you are
        fighting along side your pet. Basically gear used here should benefit both the player
        and the pet.
    ]]
    --[[
        Offense Mode = MasterPet
        Hybrid Mode = Normal
    ]]
    sets.engaged.MasterPet = {
        main = "Sakpata's Fists",
        ammo = "Automat. Oil +3",
		head = "Heyoka Cap",
		body = "Mpaca's Doublet",
		hands = "Mpaca's Gloves",
		legs = "Mpaca's Hose",
		feet = "Mpaca's Boots",
		neck = "Shulmanu Collar",
		waist = "Moonbow Belt",
		left_ear = "Enmerkar Earring",
		right_ear = "Telos Earring",
		left_ring = "C. Palug Ring",
		right_ring = "Niqmaddu Ring",
		back = Visucius.Hybrid,
    }

    -------------------------------------Acc
    --[[
        Offense Mode = MasterPet
        Hybrid Mode = Acc
    ]]
    sets.engaged.MasterPet.Acc = set_combine(sets.engaged.MasterPet, {
        head = "Mpaca's Cap",
        body = "Mpaca's Doublet",
    })

    -------------------------------------TP
    --[[
        Offense Mode = MasterPet
        Hybrid Mode = TP
    ]]
    sets.engaged.MasterPet.TP = sets.engaged.MasterPet

    -------------------------------------DT
    --[[
        Offense Mode = MasterPet
        Hybrid Mode = DT
    ]]
    sets.engaged.MasterPet.DT = set_combine(sets.engaged.MasterPet, {})

    -------------------------------------Regen
    --[[
        Offense Mode = MasterPet
        Hybrid Mode = Regen
    ]]
    sets.engaged.MasterPet.Regen = sets.engaged.MasterPet

    ----------------------------------------------------------------
    --  _____     _      ____        _          _____      _
    -- |  __ \   | |    / __ \      | |        / ____|    | |
    -- | |__) |__| |_  | |  | |_ __ | |_   _  | (___   ___| |_ ___
    -- |  ___/ _ \ __| | |  | | '_ \| | | | |  \___ \ / _ \ __/ __|
    -- | |  |  __/ |_  | |__| | | | | | |_| |  ____) |  __/ |_\__ \
    -- |_|   \___|\__|  \____/|_| |_|_|\__, | |_____/ \___|\__|___/
    --                                  __/ |
    --                                 |___/
    ----------------------------------------------------------------

    -------------------------------------Magic Midcast
    sets.midcast.Pet = sets.engaged.MasterPet

    sets.midcast.Pet.Cure = sets.engaged.MasterPet

    sets.midcast.Pet["Healing Magic"] = sets.engaged.MasterPet

    sets.midcast.Pet["Elemental Magic"] = sets.engaged.MasterPet

    sets.midcast.Pet["Enfeebling Magic"] = sets.engaged.MasterPet

    sets.midcast.Pet["Dark Magic"] = sets.engaged.MasterPet

    sets.midcast.Pet["Divine Magic"] = sets.engaged.MasterPet

    sets.midcast.Pet["Enhancing Magic"] = sets.engaged.MasterPet

    -------------------------------------Idle
    --[[
        This set will become default Idle Set when the Pet is Active 
        and sets.idle will be ignored
        Player = Idle and not fighting
        Pet = Idle and not fighting

        Idle Mode = Idle
    ]]
    sets.idle.Pet = set_combine(sets.idle, {})

    --[[
        If pet is active and you are idle and pet is idle
        Player = idle and not fighting
        Pet = idle and not fighting

        Idle Mode = MasterDT
    ]]
    sets.idle.Pet.MasterDT = set_combine(sets.idle.Pet, {})

    -------------------------------------Enmity
    sets.pet = {} -- Not Used

    --Equipped automatically
    sets.pet.Enmity = sets.engaged.MasterPet

    --[[
        Activated by Alt+D or
        F10 if Physical Defense Mode = PetDT
    ]]
    sets.pet.EmergencyDT = set_combine(sets.engaged.MasterPet, {
        head = Taeon.Head.PetDT,
		body = Taeon.Body.PetDT,
		hands = Taeon.Hands.PetDT,
		legs = Taeon.Legs.PetDT,
		feet = Taeon.Feet.PetDT,
		neck = "Shulmanu Collar",
		waist = "Klouskap Sash",
		left_ear = "Enmerkar Earring",
		right_ear = "Handler's Earring +1",
		left_ring = "C. Palug Ring",
		right_ring = "Defending Ring",
		back = Visucius.PetTank,
    })

    -------------------------------------Engaged for Pet Only
    --[[
      For Technical Users - This is layout of below
      sets.idle[idleScope][state.IdleMode][ Pet[Engaged] ][CustomIdleGroups] 

      For Non-Technical Users:
      If you the player is not fighting and your pet is fighting the first set that will activate is sets.idle.Pet.Engaged
      You can further adjust this by changing the HyrbidMode using Ctrl+F9 to activate the Acc/TP/DT/Regen/Ranged sets
    ]]
    --[[
        Idle Mode = Idle
        Hybrid Mode = Normal
    ]]
    sets.idle.Pet.Engaged = set_combine(sets.pet.EmergencyDT, {
        
        waist = "Klouskap Sash",
        --left_ear = "Burana Earring",
        ring2 = "Varar Ring",
        back = Visucius.PET,
    })

    --[[
        Idle Mode = Idle
        Hybrid Mode = Acc
    ]]
    sets.idle.Pet.Engaged.Acc = set_combine(sets.engaged.MasterPet, {
        head = "Rao Kabuto",
        main = "Ohtas",
        back = Visucius.PET,
        body = RELIC.Body,
        waist = "Klouskap Sash",
        ear1 = "Crepuscular Earring",
        ear2 = "Burana Earring",
        ring1 = "Varar Ring",
        ring2 = "Varar Ring",
    })

    --[[
        Idle Mode = Idle
        Hybrid Mode = TP
    ]]
    sets.idle.Pet.Engaged.TP = set_combine(sets.engaged.MasterPet, {
        head = "Rao Kabuto",
        main = "Ohtas",
        body = RELIC.Body,
        waist= " Klouskap Sash",
        ear1 = "Crepuscular Earring",
        ear2 = "Burana Earring",
        ring1 = "Varar Ring",
        ring2 = "Varar Ring",
        back = Visucius.PET,
    })

    --[[
        Idle Mode = Idle
        Hybrid Mode = DT
    ]]
    sets.idle.Pet.Engaged.DT = set_combine(sets.pet.EmergencyDT, {})

    --[[
        Idle Mode = Idle
        Hybrid Mode = Regen
    ]]
    sets.idle.Pet.Engaged.Regen = set_combine(sets.engaged.MasterPet, {
        head = RELIC.Head,
		neck = "Empath Necklace",
		waist = "Isa Belt",
		back = Visucius.Hybrid,
    })

    --[[
        Idle Mode = Idle
        Hybrid Mode = Ranged
    ]]
    sets.idle.Pet.Engaged.Ranged =set_combine(sets.idle.Pet.Engaged,{})

    -------------------------------------WS
    --[[
        WSNoFTP is the default weaponskill set used
    ]]
    sets.midcast.Pet.WSNoFTP = {
		head = Taeon.Head.PetD,
		body = Taeon.Body.PetDT,
		hands = "Mpaca's Gloves",
		legs = Taeon.Legs.PetDT,
		feet = "Mpaca's Boots",
		neck = "Shulmanu Collar",
		waist = "Incarnation Sash",
		left_ear = "Enmerkar Earring",
		left_ring = "C. Palug Ring",
		back = Visucius.Hybrid,
	
	}

    --[[
        If we have a pet weaponskill that can benefit from WSFTP
        then this set will be equipped
    ]]
    sets.midcast.Pet.WSFTP = {
		
		head = EMPY.Head,
		body = RELIC.Body,
		waist = "Klouskap Sash",
		back = "Dispersal Mantle",
	}

    --[[
        Base Weapon Skill Set
        Used by default if no modifier is found
    ]]
    sets.midcast.Pet.WS = {}

    --Chimera Ripper, String Clipper
    sets.midcast.Pet.WS["STR"] = set_combine(sets.midcast.Pet.WSNoFTP, {
	
	
	
	
	})

    -- Bone crusher, String Shredder
    sets.midcast.Pet.WS["VIT"] =set_combine(sets.midcast.Pet.WSNoFTP,{
            -- Add your gear here that would be different from sets.midcast.Pet.WSNoFTP
        
	})

    -- Cannibal Blade
    sets.midcast.Pet.WS["MND"] = set_combine(sets.midcast.Pet.WSNoFTP, {})

    -- Armor Piercer, Armor Shatterer
    sets.midcast.Pet.WS["DEX"] = set_combine(sets.midcast.Pet.WSNoFTP, {})

    -- Arcuballista, Daze
    sets.midcast.Pet.WS["DEXFTP"] =
        set_combine(
        sets.midcast.Pet.WSFTP,
        {
            -- Add your gear here that would be different from sets.midcast.Pet.WSFTP
            -- head = EMPY.Head
        }
    )

    ---------------------------------------------
    --  __  __ _             _____      _
    -- |  \/  (_)           / ____|    | |
    -- | \  / |_ ___  ___  | (___   ___| |_ ___
    -- | |\/| | / __|/ __|  \___ \ / _ \ __/ __|
    -- | |  | | \__ \ (__   ____) |  __/ |_\__ \
    -- |_|  |_|_|___/\___| |_____/ \___|\__|___/
    ---------------------------------------------
    -- Town Set
    sets.idle.Town = set_combine(sets.idle, {})

    -- Resting sets
    sets.resting = {
       -- Add your set here
    }

    sets.defense.MasterDT = sets.idle.MasterDT

    sets.defense.PetDT = sets.pet.EmergencyDT

    sets.defense.PetMDT = set_combine(sets.pet.EmergencyDT, {})
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book

    set_macro_page(1, 6)
    -- if player.sub_job == "WAR" then
    --     set_macro_page(3, 1)
    -- elseif player.sub_job == "NIN" then
    --     set_macro_page(3, 1)
    -- elseif player.sub_job == "DNC" then
    --     set_macro_page(3, 1)
    -- else
    --     set_macro_page(3, 1)
    -- end
end

