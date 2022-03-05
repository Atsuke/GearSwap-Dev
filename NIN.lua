version = "3.0"
--[[
        Custom commands:
       

        HUD Functions:
        gs c hud hide                   Toggles the Hud entirely on or off
        gs c hud hidemode               Toggles the Modes section of the HUD on or off
        gs c hud hidejob                Toggles the job section of the HUD on or off
        gs c hud hidebattle             Toggles the Battle section of the HUD on or off
        gs c hud lite                   Toggles the HUD in lightweight style for less screen estate usage. Also on ALT-END
        gs c hud keybinds               Toggles Display of the HUD keybindings (my defaults) You can change just under the binds in the Gearsets file.
        gs c hud setcolor sections      Cycles colors for sections
        gs c hud setcolor options       Cycles colors for options
        gs c hud setcolor keybinds      Cycles colors for keybinds
        gs c hud setcolor selection     Cycles colors for selection

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
-- TP treshold where weapons gets locked. 
lockWeaponTP = 500
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
include('Atsuke-Includes.lua')

--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
-- Customize HUD looks and content
-- Colors: ('red', 'blue', 'green', 'white', 'yellow', 'cyan', 'magenta', 'black', 'orange')

sectionsColors:set('green')
keybindsColors:set('orange')
optionsColors:set('white')
selectionColors:set('blue')   

textHideMode:set(false)
textHideOptions:set(false)
textHideJob:set(false)
textHideBattle:set(true)
textHideHUD:set(false)
useLightMode:set(false)
keybinds:set(true)
tools:set(true)

-- Optional. Swap to your sch macro sheet / book
-- set_macros(2,29) -- Sheet, Book   

--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
-- Define your modes: 
-- You can add or remove modes in the table below, they will get picked up in the cycle automatically. 
-- to define sets for idle if you add more modes, name them: sets.idle.mymode and add 'mymode' in the group.

idleModes   = M('Regen','DT')
meleeModes  = M('TP', 'Hybrid', 'DT', 'Acc')
nukeModes = M('Normal', 'Acc', 'Burst')
enmityModes = M('Normal', 'Enmity')
	
	------------------------------------------------------------------------------------------------
    ------------------------------------------ Keybinds --------------------------------------------
    ------------------------------------------------------------------------------------------------
	
	-- Setup your Key Bindings here:
    windower.send_command('bind insert gs c nuke cycle')               -- Insert Cycles Nuke element
    windower.send_command('bind !insert gs c nuke cycledown')          -- ALT+Insert Cycles Nuke element in reverse order 
    windower.send_command('bind f9 gs c toggle idlemode')              -- F9 to change Idle Mode
	windower.send_command('bind !f9 gs c toggle runspeed') 		       -- Alt-F9 toggles locking on / off Herald's Gaiters
	windower.send_command('bind f10 gs c toggle meleemode')            -- F9 to change Idle Mode    
    windower.send_command('bind f11 gs c toggle enmity')			   -- F11 Toggle casting modes between regular and Enmity
	windower.send_command('bind !f11 gs c toggle nukemode')     	   -- Alt-F11 to change Nuking Mode
	windower.send_command('bind f12 gs c toggle melee')			       -- F12 Toggle Melee mode on / off and locking of weapons  
    windower.send_command('bind ^end gs c hud keybinds')               -- CTRL-End to toggle Keybinds
	
	

	--[[
    This gets passed in when the Keybinds is turned on.
    Each one matches to a given variable within the text object
    IF you changed the Default Keybind above, Edit the ones below so
	it can be reflected in the hud using "//gs c hud keybinds" command
	]]

keybinds_on = {}
keybinds_on['key_bind_idle'] = '(F9) '
keybinds_on['key_bind_melee'] = '(F10) '
keybinds_on['key_bind_enmity'] = '(F11) '
keybinds_on['key_bind_casting'] = '(Alt-F11) '
keybinds_on['key_bind_element_cycle'] = '(INSERT)'
keybinds_on['key_bind_movespeed_lock'] = '(ALT-F9)'
keybinds_on['key_bind_lock_weapon'] = '(F12) '

-- Set the tools you would like to track while tool tracker is set to on. 
-- Tools can be in inventory or wardrobe.  
-- Set value to empty string if you dont want to track a tool.  Ex. tool_4 = ''

tool_1 = "Shihei"
tool_2 = "Inoshishinofuda"
tool_3 = "Chonofuda"
tool_4 = "Shikanofuda"

-- Set these values for the text displayed in the hud
tools_on = {}
tools_on['tool_1'] = 'Shihei: '
tools_on['tool_2'] = "Inoshishinofuda: "
tools_on['tool_3'] = "Chonofuda: "
tools_on['tool_4'] = "Shikanofuda: "

-- Remember to unbind your keybinds on job change.
function user_unload()
    send_command('unbind insert')
	send_command('unbind !insert')
    send_command('unbind delete')
	send_command('unbind !delete')
    send_command('unbind f9')
    send_command('unbind !f9')
	send_command('unbind f10')
	send_command('unbind !f11')
    send_command('unbind f12')
    send_command('unbind home')
    send_command('unbind !home')
	send_command('unbind end')
    send_command('unbind !end')
	send_command('unbind !f10')	
    send_command('unbind `f10')
   	      	
end
--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
include('/libs/NIN_Lib.lua')            -- leave this as is. NO TOUCHEY!   
--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------

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
--select_default_macro_book()
include('Atsuke_AugGear.lua') -- I list all my Augmented gears in a sidecar file since it's shared across many jobs. 
    
	------------------------------------------------------------------------------------------------
    ------------------------------------------ JSE Sets --------------------------------------------
    ------------------------------------------------------------------------------------------------
	--define jse capes/armors below. Only have to update one spot as we reforge
	-- JSE
    AF = {}         -- leave this empty
    RELIC = {}      -- leave this empty
    EMPY = {}       -- leave this empty
	
	-- Fill this with your own JSE. 
    --Hachiya
    AF.Head  = "Hachi. Hatsu. +1"
    AF.Body  = "Hachi. Chain. +1"
    AF.Hands = "Hachiya Tekko +1"
    AF.Legs  = "Hachi. Hakama +1"
    AF.Feet  = "Hachi. Kyahan +1"

    --Mochizuki
    RELIC.Head  = { name="Mochi. Hatsuburi +1", augments={'Enhances "Yonin" and "Innin" effect',}}
    RELIC.Body  = { name="Mochi. Chainmail +1", augments={'Enhances "Sange" effect',}}
    RELIC.Hands = { name="Mochizuki Tekko +1", augments={'Enh. "Ninja Tool Expertise" effect',}}
    RELIC.Legs  = { name="Mochi. Hakama +1", augments={'Enhances "Mijin Gakure" effect',}}
    RELIC.Feet  = { name="Mochi. Kyahan +1", augments={'Enh. Ninj. Mag. Acc/Cast Time Red.',}}
	
    --Hattori
    EMPY.Head  = "Hattori Zukin +1"
    EMPY.Body  = "Hattori Ningi +1"
    EMPY.Hands = "Hattori Tekko +1"
    EMPY.Legs  = "Hattori Hakama +1"
    EMPY.Feet  = "Hattori Kyahan +1"
	
	-- Define your JSE Capes here. 
	Andartia = {} -- leave this empty
	
	Andartia.TP     = { name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Damage taken-5%',}}
	Andartia.FC     = { name="Andartia's Mantle", augments={'Eva.+20 /Mag. Eva.+20','"Fast Cast"+10','Spell interruption rate down-10%',}}
	Andartia.STRWSD = { name="Andartia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}}
	
	------------------------------------------------------------------------------------------------
    ---------------------------------------- Precast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------
	
	sets.precast = {}   -- leave this empty
	sets.precast.WS= {}	-- leave this empty
	sets.buff = {}		-- leave this empty
	
	
	
	
	
	
	sets.precast.casting = {
			
		ammo = "Sapience Orb",
		head = Herc.Head.WSD,
		body = "Malignance Tabard",
		hands = { name="Leyline Gloves", augments={'Accuracy+12','Mag. Acc.+10','"Mag.Atk.Bns."+1',}},
		legs = "Malignance Tights",
		feet = "Malignance Boots",
		neck = "Voltsurge Torque",
		waist = "Windbuffet Belt",
		left_ear = "Etiolation Earring",
		right_ear = "Loquac. Earring",
		left_ring = "Kishar Ring",
		right_ring = "Prolix Ring",
		back = Andartia.FC
	
	}
   
   sets.precast['Utsusemi'] = set_combine(sets.precast.casting,{
				
		body = RELIC.Body,
		neck = "Magoraga Beads",
		
	})
	
	sets.precast['Provoke'] = {
	
		ammo = "Sapience Orb",
		-- head = RELIC.Head,
		body = "Emet Harness +1",
		-- hands = RELIC.Hands,
		legs = "Zoar Subligar +1",
		feet = "Nyame Sollerets",
		neck = "Unmoving Collar +1",
		waist = "Engraved Belt",
		left_ear = "Genmei Earring",
		right_ear = "Friomisi Earring",
		left_ring = "Defending Ring",
		right_ring = "Provocare Ring",
		back = "Reiki Cloak",
		
	}
    
	sets.precast.Waltz = { 
		ammo = "Yamarang",
		head = "Mummu Bonnet +2",
		-- body = AF.Body,
		hands = "Nyame Gauntlets",
		legs = "Nyame Flanchard",
		feet = "Rawhide Boots",
		-- neck = { name = "Etoile Gorget +2", augments={'Path: A',}},
		-- waist = "Chaac Belt",
		-- left_ear = "Odnowa Earring +1",
		-- right_ear = "Etiolation Earring",
		left_ring = "Defending Ring",
		right_ring = "Gelatinous Ring +1",
		-- back=Senuna.DA,
	}
	
    -- sets.precast.WaltzSelf = set_combine(sets.precast.Waltz)
    
	-- sets.precast.Samba = {
		-- head = AF.Head,
		-- back = Senuna.DA
	-- }
    
	-- sets.precast.Jig = {
			-- legs = RELIC.Legs,
			-- feet = AF.Feet,
	-- }
	
	sets.precast['Violent Flourish'] = {
		ammo = "Yamarang",
		head = "Malignance Chapeau",
		body = "Malignance Tabard",
		hands = "Malignance Gloves",
		legs = "Malignance Tights",
		feet = "Malignance Boots",
		waist = "Eschan Stone",
		left_ear = "Odr Earring",
		right_ear = "Hermetic Earring",
		left_ring = "Defending Ring",
		right_ring = "Warden's Ring",
		
	}
	
	sets.precast.Step = {
		ammo = "Yamarang",
		head = "Malignance Chapeau",
		body = "Malignance Tabard",
		hands = "Malignance Gloves",
		legs = "Malignance Tights",
		feet = "Malignance Boots",
		waist ="Eschan Stone",
		left_ear = "Telos Earring",
		right_ear = "Odr Earring",
		left_ring = "Cacoethic Ring",
		right_ring = "Varar Ring +1",
		
	}   
    
	sets.precast['Animated Flourish'] = sets.precast['Provoke']
	
	-- sets.precast['Reverse Flourish'] = {
		-- hands = EMPY.Hands,
		-- back = Toetapper.RF,
	-- }
	
	
	sets.precast.RA={
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck="Iskur Gorget",
		waist="Eschan Stone",
		left_ear="Telos Earring",
		left_ring="Stormsoul Ring",
		right_ring="Cacoethic Ring",
		back="Reiki Cloak",
	}
	
	
	sets.midcast = {}
	sets.midcast.nuking ={}
	sets.midcast.MB = {}
	sets.midcast['Utsusemi'] = {}
	
	sets.midcast.enfeeble={
    ammo = "Yamarang",
    head = AF.Head,
    body = "Malignance Tabard",
    hands = "Malignance Gloves",
    legs = "Malignance Tights",
    feet = AF.Feet,
    neck = "Incanter's Torque",
    waist = "Eschan Stone",
    right_ear = "Hermetic Earring",
	
	}

	sets.midcast.nuking['Normal']={
		ammo = "Ghastly Tathlum +1",
		head = RELIC.Head,
		body = Herc.Body.MAB,
		legs = Herc.Legs.MAB,
		feet = RELIC.Feet,
		neck = "Sanctity Necklace",
		waist = "Eschan Stone",
		left_ear = "Friomisi Earring",
		right_ear = "Hermetic Earring",
		left_ring = "Persis Ring",
		right_ring = "Dingir Ring",
	}
	
	sets.midcast.nuking['Acc']= sets.midcast.nuking['Normal']
	
	sets.midcast.MB['Normal'] = sets.midcast.nuking['Normal']
	sets.midcast.MB['Acc'] = sets.midcast.MB['Normal']
	
	
	sets.midcast['Utsusemi'].Normal = {feet = EMPY.Feet, back = Andartia.TP,}
	sets.midcast['Utsusemi'].Enmity = set_combine(sets.precast['Provoke'], sets.midcast['Utsusemi'].Normal)
    ------------------------------------------------------------------------------------------------
    ------------------------------------- Weapon Skill Sets ----------------------------------------
    ------------------------------------------------------------------------------------------------
	
	
	
    
	sets.precast.WS = {
		ammo = "C. Palug Stone",
		head = Herc.Head.WSD,
		body = Herc.Body.WSD,
		hands = "Meg. Gloves +2",
		legs = Herc.Legs.MAB,
		feet = Herc.Feet.WSD,
		waist = "Grunfeld Rope",
		left_ear = "Ishvara Earring",
		right_ear = "Odr Earring",
		left_ring = "Thundersoul Ring",
		right_ring = "Ilabrat Ring",
		back = Andartia.TP,
	}

    sets.precast['Blade: Ten'] = set_combine(sets.precast.WS,{
		ammo = "C. Palug Stone",
		head = AF.Head,
		body = { name="Agony Jerkin +1", augments={'Path: A',}},
		hands = RELIC.Hands,
		legs = "Jokushu Haidate",
		feet = { name="Tatena. Sune. +1", augments={'Path: A',}},
		waist = "Grunfeld Rope",
		left_ear = { name="Lugra Earring +1", augments={'Path: A',}},
		right_ear = "Ishvara Earring",
		left_ring = "Rajas Ring",
		right_ring = "Epona's Ring",
		back = Andartia.STRWSD,
		
	})

	sets.precast['Blade: Metsu'] = set_combine(sets.precast['Blade: Ten'],{
		ammo = "C. Palug Stone",
		right_ear = "Odr Earring",
	
	})
	
    sets.precast['Blade: Shun'] = {
		ammo = "C. Palug Stone",
		head = "Malignance Chapeau",
		body = "Malignance Tabard",
		hands = "Malignance Gloves",
		legs = "Jokushu Haidate",
		feet = "Malignance Boots",
		neck = "Fotia Gorget",
		waist = "Fotia Belt",
		left_ear = { name="Lugra Earring +1", augments={'Path: A',}},
		right_ear = "Odr Earring",
		left_ring = "Thundersoul Ring",
		right_ring = "Ilabrat Ring",
		back = Andartia.TP,
	}
	
	sets.precast['Blade: Teki'] = {
	
		ammo = "Seeth. Bomblet +1",
		head = RELIC.Head,
		body = Herc.Body.MAB,
		hands = { name="Leyline Gloves", augments={'Accuracy+12','Mag. Acc.+10','"Mag.Atk.Bns."+1',}},
		legs = Herc.Legs.MAB,
		feet = Herc.Feet.WSD,
		neck = "Sanctity Necklace",
		waist = "Eschan Stone",
		left_ear = "Hecate's Earring",
		right_ear = "Friomisi Earring",
		left_ring = "Spiral Ring",
		right_ring = "Dingir Ring",
		back = Andartia.STRWSD,
	
	
	}
	
	sets.precast['Blade: Chi'] = sets.precast['Blade: Teki']
	sets.precast['Blade: To'] = sets.precast['Blade: Teki']
	sets.precast['Blade: Ei'] = sets.precast['Blade: Teki']
	sets.precast['Blade: Yu'] = sets.precast['Blade: Teki']
    sets.precast['Aeolian Edge'] = sets.precast['Blade: Teki']

    ------------------------------------------------------------------------------------------------
    ----------------------------------------- Idle Sets --------------------------------------------
    ------------------------------------------------------------------------------------------------
    sets.idle = {} -- leave this empty
 	
	sets.idle.DT = {
		head = "Malignance Chapeau",
		body = "Malignance Tabard",
		hands = "Malignance Gloves",
		legs = "Nyame Flanchard",
		feet = "Nyame Sollerets",
		neck = "Warder's Charm +1",
		waist = "Engraved Belt",
		left_ear = "Telos Earring",
		right_ear = "Sherida Earring",
		left_ring = "Defending Ring",
		right_ring = "Warden's Ring",
	
	}

	sets.idle.Regen = set_combine(sets.idle.DT,{
	
		neck = "Sanctity Necklace",
		left_ring = "Woltaris Ring",
	
	})
	
    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Engaged Sets ------------------------------------------
	------------------------------------------------------------------------------------------------
    -- We will switch to these every time we engage and return to them after ever ws while fighting
	
	sets.engaged = {}  -- leave this empty

    sets.engaged.TP = {
		
		head = Adh.Head.A,
		body = "Malignance Tabard",
		hands = Adh.Hands.A,
		legs = { name="Tatena. Haidate +1", augments={'Path: A',}},
		feet = { name="Tatena. Sune. +1", augments={'Path: A',}},
		neck = "Sanctity Necklace",
		waist = "Windbuffet Belt",
		left_ear = "Telos Earring",
		right_ear = "Suppanomimi",
		left_ring = "Hetairoi Ring",
		right_ring = "Epona's Ring",
		back = Andartia.TP,
	}
	
	sets.engaged.Hybrid = {
		ammo = "Yamarang",
		hands = Adh.Hands.A,
		body = "Malignance Tabard",
		hands = Adh.Hands.A,
		legs = "Malignance Tights",
		feet = "Malignance Boots",
		neck = "Loricate Torque",
		waist = "Windbuffet Belt",
		left_ear = "Telos Earring",
		right_ear = "Sherida Earring",
		left_ring = "Epona's Ring",
		right_ring="Hetairoi Ring",
		back = Andartia.TP,
	}
	
	sets.engaged.Acc = {
		ammo = "Yamarang",
		head = "Malignance Chapeau",
		body = "Malignance Tabard",
		hands = "Malignance Gloves",
		llegs = "Malignance Tights",
		feet = "Malignance Boots",
		neck = "Sanctity Necklace",
		waist = "Windbuffet Belt",
		left_ear = "Telos Earring",
		right_ear = "Sherida Earring",
		left_ring = "Epona's Ring",
		right_ring="Hetairoi Ring",
		back = Andartia.TP,
	}
	
	sets.engaged.DT = {
		head = "Malignance Chapeau",
		body = "Malignance Tabard",
		hands = "Malignance Gloves",
		legs = "Nyame Flanchard",
		feet = "Nyame Sollerets",
		neck = "Warder's Charm +1",
		waist = "Engraved Belt",
		left_ear = "Telos Earring",
		right_ear = "Sherida Earring",
		left_ring = "Defending Ring",
		right_ring = "Warden's Ring",
		back = Andartia.TP,
	}
	
	
	------------------------------------------------------------------------------------------------
    ----------------------------------------- Misc. Sets -------------------------------------------
	------------------------------------------------------------------------------------------------
	
	--	Note that movespeed is sets.me this is a holdover from the way the movespeed equip 
	--	helper function expects its input. I'll get around to fixing it eventually
	--	but this works for now
	-- sets.TH ={
    -- ammo = "Per. Lucky Egg",
    -- head = "Wh. Rarab Cap +1",
    -- hands = RELIC.Hands,
    -- feet = "Skulk. Poulaines +1",
    -- waist = "Chaac Belt",
    
-- }
	sets.me = {} -- leave this empty
	
	sets.me.movespeed = {feet = "Danzo Sune-Ate",}
end