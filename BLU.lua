version = "3.0"

--[[
	Big shoutout to Tunaliz https://github.com/Tunaliz for the amazing work he did, especially on the HUD.  
	His code was a fantastic starting point	I fixed some bugs in the existing code,
	added/removed/modified things to suit my needs and then built all of my lua's in a similar style. 
--]]

--[[
		Custom commands:
       
		Can bind these to keys or use in macros ex: /console gs c toggle melee
	
		gs c toggle idlemode            Change Idle Mode
		gs c toggle runspeed 		    Toggles locking on / off Carmine Cuisses +1
		gs c toggle meleemode           Change Melee Mode    
		gs c toggle melee			    Toggle Melee mode on / off and locking of weapons  
		gs c dnc voke					Uses either Provoke or Animated Flourish depending on subjob
		
		HUD Functions:
		gs c hud hide                   Toggles the Hud entirely on or off
		gs c hud hidemode               Toggles the Modes section of the HUD on or off
		gs c hud hidejob                Toggles the job section of the HUD on or off
		gs c hud hidebattle             Toggles the Battle section of the HUD on or off
		gs c hud hidetools				Toggles the Tools section of the HUD on or off
		gs c hud lite                   Toggles the HUD in lightweight style for less screen estate usage. Also on ALT-END
		gs c hud keybinds               Toggles Display of the HUD keybindings (my defaults) You can change just under the binds in the Gearsets file.
		gs c hud setcolor sections      Cycles colors for sections
		gs c hud setcolor options       Cycles colors for options
		gs c hud setcolor keybinds      Cycles colors for keybinds
		gs c hud setcolor selection     Cycles colors for selection
		gs c hud setcolor tools     	Cycles colors for selection
		
		Alternatively you can also add the color after those command like: //gs c hud setcolor options blue
        
--]]

--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
--              ______                   _                  
--             / _____)        _     _  (_)                 
--            ( (____  _____ _| |_ _| |_ _ ____   ____  ___ 
--             \____ \| ___ (_   _|_   _) |  _ \ / _  |/___)
--             _____) ) ____| | |_  | |_| | | | ( (_| |___ |
--            (______/|_____)  \__)  \__)_|_| |_|\___ (___/ 
--                                              (_____|    
--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
-- Set this to true and as soon as you move you swap into movespeed set, and revert when stationary
-- Set it to false and the movespeed toggle is manual. 
autorunspeed = false
auto_CP_Cape = false
lockWeaponTP = 500 -- TP treshold where weapons gets locked. 
--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
-- HUD Initial setup and Positioning
--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
hud_x_pos = 1150    --important to update these if you have a smaller screen
hud_y_pos = 50      --important to update these if you have a smaller screen
hud_draggable = true
hud_font_size = 9
hud_transparency = 150 -- a value of 0 (invisible) to 255 (no transparency at all)
hud_font = 'Impact'
hud_padding = 10
--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
include('Atsuke-Includes.lua') -- Leave as is. NO TOUCHY
--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
-- Customize HUD looks and content
-- Colors: ('red', 'blue', 'green', 'white', 'yellow', 'cyan', 'magenta', 'black', 'orange')

sectionsColors:set('green')
keybindsColors:set('orange')
optionsColors:set('white')
selectionColors:set('blue')   
toolColors:set('green')

textHideMode:set(false)		-- Change to toggle default visibility of Mode section
textHideOptions:set(false)	-- Change to toggle defautl visibility of Options sections
textHideJob:set(false)		-- Change to toggle default visibility of job Section
textHideBattle:set(true)	-- Change to toggle default visibility for battle section
textHideHUD:set(false)		-- Change to toggle default setting for hud visibility
useLightMode:set(false)		-- Change to toggle default setting for lite mode
keybinds:set(true)			-- Change to toggle default setting for keybind visibility
textHideTools:set(false)	-- Change to toggle the default setting of the tool counter

-- Optional. Swap to your BLU macro sheet / book
 set_macros(2,22) -- Sheet, Book   

--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
-- Define your modes: 
-- You can add or remove modes in the table below, they will get picked up in the cycle automatically. 
-- Each mode needs to have a corresponding set in order to work.  ex: sets.idle.Regen

idleModes   = M('Regain','DT', 'Refresh')
meleeModes  = M('TP', 'Hybrid', 'DT', 'Acc')

	------------------------------------------------------------------------------------------------
    ------------------------------------------ Keybinds --------------------------------------------
    ------------------------------------------------------------------------------------------------
	
	-- Setup your Key Bindings here:
    
	windower.send_command('bind f9 gs c toggle idlemode')              -- F9 to change Idle Mode
	windower.send_command('bind !f9 gs c toggle runspeed') 		       -- Alt-F9 toggles locking on / off runspeed gear
	windower.send_command('bind f10 gs c toggle meleemode')            -- F10 to change engaged Mode    
	windower.send_command('bind f12 gs c toggle melee')			       -- F12 Toggle Melee mode on / off and locking of weapons  
	

	--[[
    This gets passed in when the Keybinds is turned on.
    Each one matches to a given variable within the text object
    IF you changed the Default Keybind above, Edit the ones below so
	it can be reflected in the hud using "//gs c hud keybinds" command
	]]

keybinds_on = {}
keybinds_on['key_bind_idle'] = '(F9) '
keybinds_on['key_bind_movespeed_lock'] = '(ALT-F9)'
keybinds_on['key_bind_melee'] = '(F10) '
keybinds_on['key_bind_lock_weapon'] = '(F12) '

-- Set the tools you would like to track while tool tracker is set to on. 
-- Tools can be in inventory or wardrobe.  
-- Set value to empty string if you dont want to track a tool.  Ex. tool_4 = ''

tool_1 = "Shihei"
tool_2 = ""
tool_3 = ""
tool_4 = ""

-- Set these values for the text displayed in the hud
tools_on = {}
tools_on['tool_1'] = 'Shihei: '
tools_on['tool_2'] = ""
tools_on['tool_3'] = ""
tools_on['tool_4'] = ""

-- set level for low tool warning
tool_warning = 20

-- Remember to unbind your keybinds on job change.
function user_unload()

	send_command('unbind f9')
	send_command('unbind !f9')
	send_command('unbind f10')
	send_command('unbind !f10')
	send_command('unbind f12')
	      	
end
--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
include('/libs/BLU_Lib.lua')            -- leave this as is. NO TOUCHEY!   
--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------

elemental_ws = S{"Sanguine Blade", "Flash Nova"}

--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
                --  _____                  __      __        _       _     _
                -- / ____|                 \ \    / /       (_)     | |   | |
                --| |  __  ___  __ _ _ __   \ \  / /_ _ _ __ _  __ _| |__ | | ___  ___
                --| | |_ |/ _ \/ _` | '__|   \ \/ / _` | '__| |/ _` | '_ \| |/ _ \/ __|
                --| |__| |  __/ (_| | |       \  / (_| | |  | | (_| | |_) | |  __/\__ \
                -- \_____|\___|\__,_|_|        \/ \__,_|_|  |_|\__,_|_.__/|_|\___||___/
--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------    

-- Setup your Gear Sets below:
function get_sets()

--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
-- I list all my Augmented gears in a sidecar file since it's shared across many jobs. This is optional but
-- makes changing augs without updating multiple sets much easier. 
include('Kuvira_AugGear.lua')  
--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------

	----------------------------------------------------------
	-- Auto CP Cape: Will put on CP cape automatically when
	-- fighting Apex mobs and job is not mastered
	----------------------------------------------------------
	CP_CAPE = "Mecisto. Mantle" -- Put your CP cape here
	----------------------------------------------------------
   
	------------------------------------------------------------------------------------------------
	------------------------------------------ JSE Sets --------------------------------------------
	------------------------------------------------------------------------------------------------
	
	--define jse capes/armors below. Only have to update one spot as we reforge
	-- JSE
	AF = {}         -- leave this empty
	RELIC = {}      -- leave this empty
	EMPY = {}       -- leave this empty
	
	-- Fill this with your own JSE. 
    --Laksamana
	AF.Head  = "Assim. Keffiyeh +1"
	AF.Body  = "Assim. Jubbah +2"
	AF.Hands = "Assim. Bazu. +1"
	AF.Legs  = "Assim. Shalwar +1"
	AF.Feet  = "Assim. Charuqs +1"

	--Lanun
	RELIC.Head  = { name="Luh. Keffiyeh +1", augments={'Enhances "Convergence" effect',}}
	RELIC.Body  = { name="Luhlaza Jubbah +3", augments={'Enhances "Enchainment" effect',}}
	RELIC.Hands = { name="Luh. Bazubands +1", augments={'Enhances "Azure Lore" effect',}}
	RELIC.Legs  = { name="Luhlaza Shalwar +2", augments={'Enhances "Assimilation" effect',}}
	RELIC.Feet  = { name="Luhlaza Charuqs +1", augments={'Enhances "Diffusion" effect',}}
	
	--Chasseur
	EMPY.Head  = "Hashishin Kavuk +1"
	EMPY.Body  = "Hashishin Mintan +1"
	EMPY.Hands = "Hashi. Bazu. +1"
	EMPY.Legs  = "Hashishin Tayt +1"
	EMPY.Feet  = "Hashi. Basmak +1"
	
		
	-- Define your JSE Capes here. 
	Rosmerta = {} -- leave this empty
	Cornflower = {} -- leave this empty
	
	Rosmerta.Nuke = { name="Rosmerta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Magic Damage +8','"Mag.Atk.Bns."+10','Phys. dmg. taken-10%',}}
	Rosmerta.TP   = { name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Damage taken-5%',}}
	Rosmerta.STR  = { name="Rosmerta's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}
	
	
	------------------------------------------------------------------------------------------------
	---------------------------------------- Precast Sets ------------------------------------------
	------------------------------------------------------------------------------------------------
	
	sets.precast = {}   -- leave this empty
	sets.precast.WS= {}	-- leave this empty
	sets.buff = {}  -- leave this empty
	
	sets.precast.casting = {
		ammo = "Sapience Orb",
		head = Psycloth.Head.FC,
		body = RELIC.Body,
		hands = { name="Leyline Gloves", augments={'Accuracy+14','Mag. Acc.+13','"Mag.Atk.Bns."+13','"Fast Cast"+2',}},
		legs = "Aya. Cosciales +2",
		waist = { name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear = "Loquac. Earring",
		right_ear = "Etiolation Earring",
		left_ring = "Kishar Ring",
		right_ring = "Prolix Ring",
		back = { name="Fi Follet Cape +1", augments={'Path: A',}},
	}
	
	sets.precast.Blue_Magic = set_combine(sets.precast.casting, {body = EMPY.Body,})
	
	sets.precast['Provoke'] = {
	
		ammo = "Sapience Orb",
		body = "Emet Harness +1",
		legs = "Zoar Subligar +1",
		feet = "Nyame Sollerets",
		neck = "Unmoving Collar +1",
		left_ear = "Genmei Earring",
		right_ear = "Friomisi Earring",
		left_ring = "Defending Ring",
		right_ring = "Provocare Ring",
	}
    
	sets.precast['Animated Flourish'] = sets.precast['Provoke']
	
	sets.precast.Waltz = {}
	
    sets.precast.WaltzSelf = set_combine(sets.precast.Waltz)
	
	------------------------------------------------------------------------------------------------
	---------------------------------------- Midcast Sets ------------------------------------------
	------------------------------------------------------------------------------------------------
	sets.midcast = {} --Leave this empty
	sets.midcast['Blue Magic'] = {
		
		ammo = "Mavi Tathlum",
        head = RELIC.Head,
        body = AF.Body,
        --hands = "Rawhide Gloves",
        legs = EMPY.Legs,
        feet = RELIC.Feet,
        --neck = "Mirage Stole +2",
        right_ear = "Njordr Earring",
        left_ring = "Stikini Ring",
	
	}

    sets.midcast['Blue Magic'].Physical = set_combine(sets.midcast['Blue Magic'], {
		
        body = RELIC.Body,
        hands = "Jhakri Cuffs +2",
        legs = RELIC.Legs,
        feet = RELIC.Feet,
        neck = "Rep. Plat. Medal",
        left_ring = "Ifrit Ring",
        right_ring = "Ilabrat Ring",
        --back = gear.BLU_WS2_Cape,
        waist = "Sailfi Belt +1",
	
	})

    sets.midcast['Blue Magic'].PhysicalStr = sets.midcast['Blue Magic'].Physical

    sets.midcast['Blue Magic'].PhysicalDex = set_combine(sets.midcast['Blue Magic'].Physical, {
		waist="Grunfeld Rope"
	})

    sets.midcast['Blue Magic'].PhysicalVit = sets.midcast['Blue Magic'].Physical

    sets.midcast['Blue Magic'].PhysicalAgi = set_combine(sets.midcast['Blue Magic'].Physical, {})

    sets.midcast['Blue Magic'].PhysicalInt = set_combine(sets.midcast['Blue Magic'].Physical, {
		ammo = "Ghastly Tathlum +1",
		left_ear = "Regal Earring",
		
	})

    sets.midcast['Blue Magic'].PhysicalMnd = set_combine(sets.midcast['Blue Magic'].PhysicalInt, {})

    sets.midcast['Blue Magic'].PhysicalChr = set_combine(sets.midcast['Blue Magic'].Physical, {ear1="Regal Earring", ear2="Enchntr. Earring +1"})

    sets.midcast['Blue Magic'].Magical = {
		
		ammo = "Ghastly Tathlum +1",
		head = "Jhakri Coronal +1",
		body = Amal.Body.D,
		hands = Amal.Hands.D,
		legs = RELIC.Legs,
		feet = "Jhakri Pigaches +1",
		neck = "Sanctity Necklace",
		waist = "Eschan Stone",
		left_ear = "Hecate's Earring",
		right_ear = "Friomisi Earring",
		left_ring = "Jhakri Ring",
		right_ring = "Fenrir Ring",
		back = Rosmerta.Nuke,
	
	}

    sets.midcast['Blue Magic'].MagicalDark = set_combine(sets.midcast['Blue Magic'].Magical, {
		head = "Pixie Hairpin +1",
		right_ring = "Archon Ring",
	})

    sets.midcast['Blue Magic'].MagicalLight = set_combine(sets.midcast['Blue Magic'].Magical, {})

    sets.midcast['Blue Magic'].MagicalMnd = set_combine(sets.midcast['Blue Magic'].Magical, {
		right_ring = "Stikini Ring"
	
	})

    sets.midcast['Blue Magic'].MagicalDex = set_combine(sets.midcast['Blue Magic'].Magical, {
		right_ring = "Ilabrat Ring",
	})

    sets.midcast['Blue Magic'].MagicalVit = set_combine(sets.midcast['Blue Magic'].Magical, {})

    sets.midcast['Blue Magic'].MagicalChr = set_combine(sets.midcast['Blue Magic'].Magical, {
		left_ear = "Regal Earring",
	
	})

    sets.midcast['Blue Magic'].MagicAccuracy = {
		--ammo = "Pemphredo Tathlum",
        head = AF.Head,
        body = Amal.Body.D,
        hands = "Malignance Gloves",
        legs = AF.Legs,
        feet = "Malignance Boots",
        neck = "Sanctity Necklace",
        left_ear = "Regal Earring",
        right_ear = "Gwati Earring",
        left_ring = "Stikini Ring",
        right_ring = "Kishar Ring",
        back = "Kumbira Cape",
        waist = "Luminary Sash",
	}

    sets.midcast['Blue Magic'].Breath = set_combine(sets.midcast['Blue Magic'].Magical, {head = RELIC.Head})

    sets.midcast['Blue Magic'].StunPhysical = set_combine(sets.midcast['Blue Magic'].MagicAccuracy, {
		hands = "Malignance Gloves",
		feet = "Malignance Boots",
		waist = "Eschan Stone",
	
	})

    sets.midcast['Blue Magic'].StunMagical = sets.midcast['Blue Magic'].MagicAccuracy

    sets.midcast['Blue Magic'].Healing = {}

    sets.midcast['Blue Magic'].HealingSelf = set_combine(sets.midcast['Blue Magic'].Healing, {})

    sets.midcast['Blue Magic']['White Wind'] = set_combine(sets.midcast['Blue Magic'].Healing, {

		neck="Sanctity Necklace",
        ear2="Etiolation Earring",
	
	})

    sets.midcast['Blue Magic'].Buff = sets.midcast['Blue Magic']
    sets.midcast['Blue Magic'].Refresh = set_combine(sets.midcast['Blue Magic'], {head="Amalric Coif +1", waist="Gishdubar Sash", back="Grapevine Cape"})
    sets.midcast['Blue Magic'].SkillBasedBuff = sets.midcast['Blue Magic']

    sets.midcast['Blue Magic']['Occultation'] = set_combine(sets.midcast['Blue Magic'], {
		
		hands = EMPY.Hands,
        left_ear = "Njordr Earring",
	
	}) -- 1 shadow per 50 skill

    sets.midcast['Blue Magic']['Carcharian Verve'] = set_combine(sets.midcast['Blue Magic'].Buff, {})

    sets.midcast['Enhancing Magic'] = {
		--ammo = "Pemphredo Tathlum",
        head = "Carmine Mask +1",
        body = Telchine.Head.en,
        hands = Telchine.Hands.en,
        legs = "Carmine Cuisses +1",
        feet = Telchine.Head.en,
        neck = "Incanter's Torque",
        --left_ear = "Mimir Earring",
        right_ear = "Andoaa Earring",
        left_ring = "Stikini Ring",
        back = "Fi Follet Cape +1",
        --waist = "Olympus Sash",
	
	}

    sets.midcast.EnhancingDuration = {
		head = Telchine.Head.en,
		legs = Telchine.Legs.en,
		feet = Telchine.Feet.en, 
	}

    sets.midcast.Refresh = set_combine(sets.midcast.EnhancingDuration, {
		waist="Gishdubar Sash",
	
	})
    sets.midcast.Stoneskin = set_combine(sets.midcast.EnhancingDuration, {waist="Siegel Sash"})

    sets.midcast.Phalanx = set_combine(sets.midcast.EnhancingDuration, {})

    sets.midcast.Aquaveil = set_combine(sets.midcast.EnhancingDuration, {})

    sets.midcast['Enfeebling Magic'] = set_combine(sets.midcast['Blue Magic'].MagicAccuracy, {})
	
	sets.midcast.Magic_Burst = set_combine(sets.midcast['Blue Magic'].Magical, {
	
		right_ring = "Mujin Band",
	
	})
	
	------------------------------------------------------------------------------------------------
    ----------------------------------------- Buff Sets --------------------------------------------
    ------------------------------------------------------------------------------------------------
	sets.buff = {}  -- leave this empty
	
	sets.buff['Burst Affinity'] = {feet = EMPY.Feet}
	sets.buff['Efflux'] = {legs = EMPY.Legs}
	sets.buff['Diffusion'] = {feet = RELIC.Feet}
	sets.buff.Doom = {} 
	
    ------------------------------------------------------------------------------------------------
    ------------------------------------- Weapon Skill Sets ----------------------------------------
    ------------------------------------------------------------------------------------------------
	
	sets.precast.WS = {
		ammo = "Mantoptera Eye",
		head = Herc.Head.WSD,
		body = AF.Body,
		hands = "Jhakri Cuffs +2",
		legs = RELIC.Legs,
		feet = Herc.Feet.TA,
		neck = "Rep. Plat. Medal",
		waist = { name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear = "Brutal Earring",
		right_ear = { name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		left_ring = "Ifrit Ring",
		right_ring = "Apate Ring",
		back = Rosmerta.STR,
	}

	sets.precast["Savage Blade"] = sets.precast.WS

	sets.precast['Requiescat'] = set_combine(sets.precast.WS,{
		head = RELIC.Head,
		body = RELIC.Body,
		hands = RELIC.Hands,
		--legs = "Gleti's Breeches",
		feet = RELIC.Feet,
		neck = "Fotia Gorget",
		waist = "Fotia Belt",
		left_ring = "Epona's Ring",
		right_ring = "Rajas Ring",
		--back = 
	
	})
	
	sets.precast['Chant Du Cygne'] = {
		ammo = "Falcon Eye",
		head = Adh.Head.B,
		body = AF.Body,
		hands = Adh.Hands.B,
		legs = Herc.Legs.WSD,
		feet = Herc.Feet.TA,
		neck = "Fotia Gorget",
		waist = "Fotia Belt",
		left_ear = "Odr Earring",
		right_ear = "Telos Earring",
		left_ring = "Epona's Ring",
		right_ring = "Ilabrat Ring",
		--back={ name="Rosmerta's Cape", augments={'INT+20','Magic Damage +8','"Mag.Atk.Bns."+10',}},
	
	}
	
	sets.precast['Sanguine Blade'] = {
		ammo = "Ghastly Tathlum +1",
        head = "Pixie Hairpin +1",
        body = Amal.Body.D,
        hands = Amal.Hands.D,
        legs = RELIC.Legs,
        feet = Herc.Feet.MAB,
        neck = "Sanctity Necklace",
        waist = "Eschan Stone",
		left_ear = "Moonshade Earring",
        right_ear = "Regal Earring",
        left_ring = "Arvina Ringlet +1",
        right_ring = "Archon Ring",
        back = Rosmerta.Nuke,
        	
	}
	
	sets.precast['Expiacion'] = sets.precast['Savage Blade']

	sets.precast['True Strike'] = sets.precast['Savage Blade']
	
	sets.precast['Judgment'] = sets.precast['True Strike']
	
	sets.precast['Black Halo'] = set_combine(sets.precast['Savage Blade'], {
		ear2="Regal Earring",
	})

	sets.precast['Realmrazer'] = sets.precast['Requiescat']
    
	sets.precast['Flash Nova'] = set_combine(sets.precast['Sanguine Blade'], {
		head = Herc.Head.MAB
	})

    ------------------------------------------------------------------------------------------------
    ----------------------------------------- Idle Sets --------------------------------------------
    ------------------------------------------------------------------------------------------------
	
	sets.idle = {} -- leave this empty
 		
	sets.idle.Regain = {
		head = "Gleti's Mask",
		body = "Gleti's Cuirass",
		hands = "Gleti's Gauntlets",
		legs = "Gleti's Breeches",
		feet = "Gleti's Boots",
		neck = "Sibyl Scarf",
		right_ring = "Defending Ring",
		right_ear = "Infused Earring",
		back = Rosmerta.TP
	}
	
	sets.idle.DT = {
		head = { name="Blistering Sallet +1", augments={'Path: A',}},
		body = "Ayanmo Corazza +2",
		hands = "Malignance Gloves",
		legs = "Aya. Cosciales +2",
		feet = "Malignance Boots",
		neck = "Loricate Torque +1",
		right_ring = "Defending Ring",
		right_ear = "Infused Earring",
		back = Rosmerta.TP
	}
	
	sets.idle.Refresh = set_combine(sets.idle.Regain,{
		body = RELIC.Body,
		legs = Rawhide.Legs.Refresh,
		neck = "Sibyl Scarf",
		
	})

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Engaged Sets ------------------------------------------
	------------------------------------------------------------------------------------------------
    -- We will switch to these every time we engage and return to them after ever ws while fighting
	
	sets.engaged = {}  -- leave this empty

    sets.engaged.TP = {
		ammo = "Mantoptera Eye",
		head = Adh.Head.B,
		body = Adh.Body.B,
		hands = Adh.Hands.B,
		legs = { name="Samnuha Tights", augments={'STR+1','"Triple Atk."+2',}},
		feet = Herc.Feet.TA,
		neck = "Lissome Necklace",
		waist = "Reiki Yotai",
		left_ear = "Brutal Earring",
		right_ear = "Suppanomimi",
		left_ring = "Epona's Ring",
		right_ring = "Petrov Ring",
		back = Rosmerta.TP,
	}
	
	sets.engaged.Hybrid = set_combine(sets.engaged.TP, {
		
		head = { name="Blistering Sallet +1", augments={'Path: A',}},
		hands = "Malignance Gloves",
		feet = "Malignance Boots",
		neck = "Loricate Torque +1",
	
	})
	
	sets.engaged.DT = {
		ammo = "Amar Cluster",
		head = { name="Blistering Sallet +1", augments={'Path: A',}},
		body = "Ayanmo Corazza +2",
		hands = "Malignance Gloves",
		legs = "Aya. Cosciales +2",
		feet = "Malignance Boots",
		neck = "Loricate Torque +1",
		waist = "Reiki Yotai",
		left_ear = "Odnowa Earring +1",
		right_ear = "Suppanomimi",
		left_ring = "Epona's Ring",
		right_ring = "Defending Ring",
		back = Rosmerta.TP
	}
	
	sets.engaged.Acc = set_combine(sets.engaged.TP,{})
	
	
	------------------------------------------------------------------------------------------------
	----------------------------------------- Misc. Sets -------------------------------------------
	------------------------------------------------------------------------------------------------
	
	--	Note that movespeed is sets.me this is a holdover from the way the movespeed equip 
	--	helper function expects its input. I'll get around to fixing it eventually
	--	but this works for now
	
	sets.TH = {
		ammo = "Per. Lucky Egg",
		head = "Wh. Rarab Cap +1",
		waist = "Chaac Belt",
    
	}
	
	sets.me = {} -- leave this empty
	
	sets.me.movespeed = {legs = "Carmine Cuisses +1",}
	sets.adoulin = {body = "Councilor's Garb",}
end
