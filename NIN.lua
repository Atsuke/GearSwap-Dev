version = "3.0"

--[[
	Big shoutout to Tunaliz https://github.com/Tunaliz for the amazing work he did, especially on the HUD.  
	His code was a fantastic starting point	I fixed some bugs in the existing code,
	added/removed/modified things to suit my needs and then built all of my lua's in a similar style. 
--]]

--[[
        Custom commands:
       
		Toggle Function: 
		gs c toggle melee               Toggle Melee mode on / off and locking of weapons
		gs c toggle mb                  Toggles Magic Burst Mode on / off.
		gs c toggle runspeed            Toggles locking on / off Herald's Gaiters
		gs c toggle idlemode            Toggles between Refresh and DT idle mode. Activating Sublimation JA will auto replace refresh set for sublimation set. DT set will superceed both.   
		gs c toggle nukemode            Toggles between Normal and Accuracy mode for midcast Nuking sets (MB included)  
		gs c toggle matchsc             Toggles auto swapping element to match the last SC that just happenned.
		
		Casting functions:
		these are to set fewer macros (2 cycle, 5 cast) to save macro space when playing lazily with controler
        
		gs c nuke cycle              	Cycles element type for nuking & SC
		gs c nuke cycledown				Cycles element type for nuking & SC	in reverse order	
		gs c nuke t1                    Cast tier 1 nuke of saved element 
		gs c nuke t2                    Cast tier 2 nuke of saved element 
		gs c nuke t3                    Cast tier 3 nuke of saved element 
		
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
		
		// OPTIONAL IF YOU WANT / NEED to skip the cycles...  
		gs c nuke Ice                   Set Element Type to Ice DO NOTE the Element needs a Capital letter. 
		gs c nuke Air                   Set Element Type to Air DO NOTE the Element needs a Capital letter. 
		gs c nuke Earth                 Set Element Type to Earth DO NOTE the Element needs a Capital letter. 
		gs c nuke Lightning             Set Element Type to Lightning DO NOTE the Element needs a Capital letter. 
		gs c nuke Water                 Set Element Type to Water DO NOTE the Element needs a Capital letter. 
		gs c nuke Fire                  Set Element Type to Fire DO NOTE the Element needs a Capital letter. 
        
        
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
hud_x_pos = 1150    	-- Important to update these if you have a smaller screen
hud_y_pos = 50      	-- Important to update these if you have a smaller screen
hud_draggable = true
hud_font_size = 9
hud_transparency = 150	-- A value of 0 (invisible) to 255 (no transparency at all)
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
toolColors:set('green') 

textHideMode:set(false) 	-- Change to toggle default visibility of Mode section
textHideOptions:set(false)	-- Change to toggle defautl visibility of Options sections
textHideJob:set(false)		-- Change to toggle default visibility of job Section
textHideBattle:set(true)	-- Change to toggle default visibility for battle section
textHideHUD:set(false)		-- Change to toggle default setting for hud visibility
useLightMode:set(false)		-- Change to toggle default setting for lite mode
keybinds:set(true)			-- Change to toggle default setting for keybind visibility
textHideTools:set(false)	-- Change to toggle the default setting of the tool counter


-- Optional. Swap to your sch macro sheet / book
set_macros(2,11) -- Sheet, Book   

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
    windower.send_command('bind insert gs c nuke cycle')				-- Insert Cycles Nuke element
    windower.send_command('bind !insert gs c nuke cycledown')			-- ALT+Insert Cycles Nuke element in reverse order 
    windower.send_command('bind f9 gs c toggle idlemode')				-- F9 to change Idle Mode
	windower.send_command('bind !f9 gs c toggle runspeed')				-- Alt-F9 toggles locking on / off Herald's Gaiters
	windower.send_command('bind f10 gs c toggle meleemode')				-- F9 to change Idle Mode    
    windower.send_command('bind f11 gs c toggle enmity')				-- F11 Toggle casting modes between regular and Enmity
	windower.send_command('bind !f11 gs c toggle nukemode')				-- Alt-F11 to change Nuking Mode
	windower.send_command('bind f12 gs c toggle melee')					-- F12 Toggle Melee mode on / off and locking of weapons
	windower.send_command('bind !F12 gs c toggle matchsc')				-- F10 to change Match SC Mode
    windower.send_command('bind ^end gs c hud keybinds')				-- CTRL-End to toggle Keybinds
	
	

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
keybinds_on['key_bind_matchsc'] = '(ALT-F12) '

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

-- set level for low tool warning
tool_warning = 20

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
	send_command('unbind !f12')
   	      	
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

include('Atsuke_AugGear.lua') -- I list all my Augmented gears in a sidecar file since it's shared across many jobs. 
  
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
    
	--Hachiya
    AF.Head  = "Hachi. Hatsu. +3"
    AF.Body  = "Hachi. Chain. +1"
    AF.Hands = "Hachiya Tekko +1"
    AF.Legs  = "Hachi. Hakama +1"
    AF.Feet  = "Hachiya Kyahan +2"

    --Mochizuki
    RELIC.Head  = { name="Mochi. Hatsuburi +3", augments={'Enhances "Yonin" and "Innin" effect',}}
    RELIC.Body  = { name="Mochi. Chainmail +3", augments={'Enhances "Sange" effect',}}
    RELIC.Hands = { name="Mochizuki Tekko +1", augments={'Enh. "Ninja Tool Expertise" effect',}}
    RELIC.Legs  = { name="Mochi. Hakama +3", augments={'Enhances "Mijin Gakure" effect',}}
    RELIC.Feet  = { name="Mochi. Kyahan +3", augments={'Enh. Ninj. Mag. Acc/Cast Time Red.',}}
	
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
	Andartia.NUKE	= { name="Andartia's Mantle", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10','Spell interruption rate down-10%',}}
	Andartia.AGI	= { name="Andartia's Mantle", augments={'AGI+20','Accuracy+20 Attack+20','AGI+4','Weapon skill damage +10%','Phys. dmg. taken-10%',}}
	
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
		feet = RELIC.Feet,
		neck = "Unmoving Collar +1",
		waist = "Engraved Belt",
		left_ear = "Genmei Earring",
		right_ear = "Friomisi Earring",
		left_ring = "Defending Ring",
		right_ring = "Provocare Ring",
		back = "Reiki Cloak",
	}
    
	sets.precast.Waltz = { 
		
		ammo = "Yamarang", --5
		head = "Mummu Bonnet +2",
		body = "Nyame Mail",
		hands = "Nyame Gauntlets",
		legs = "Dashing Subligar",  --10
		feet = "Rawhide Boots", --8
		left_ear = "Odnowa Earring +1",
		right_ear = "Etiolation Earring",
		left_ring = "Defending Ring",
		right_ring = "Gelatinous Ring +1",
	}
	
    sets.precast.WaltzSelf = set_combine(sets.precast.Waltz)
    	
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
		
	sets.precast.RA={
	
		head = "Malignance Chapeau",
		body = "Malignance Tabard",
		hands = "Malignance Gloves",
		legs = "Malignance Tights",
		feet = "Malignance Boots",
		neck = "Iskur Gorget",
		waist = "Eschan Stone",
		left_ear = "Telos Earring",
		left_ring = "Regal Ring",
		right_ring = "Cacoethic Ring",
		back = "Reiki Cloak",
	}
	
	--JA Precasts
	
	sets.precast['Mijin Gakure'] = {legs = RELIC.Legs}
	
	------------------------------------------------------------------------------------------------
	---------------------------------------- Mid Cast Sets -----------------------------------------
	------------------------------------------------------------------------------------------------
	sets.midcast = {}	-- leave this empty
	sets.midcast.nuking ={}	-- leave this empty
	sets.midcast.MB = {}	-- leave this empty
	sets.midcast['Utsusemi'] = {}	-- leave this empty
	
	sets.midcast['Futae'] = {hands = EMPY.Hands}
	
	sets.midcast.enfeeble = {
		
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

	sets.midcast.nuking['Normal'] = {
		
		ammo = "Ghastly Tathlum +1",
		head = RELIC.Head,
		body = Herc.Body.MAB,
		hands = EMPY.Hands,
		legs = Herc.Legs.MAB,
		feet = RELIC.Feet,
		neck = "Sanctity Necklace",
		waist = "Eschan Stone",
		left_ear = "Friomisi Earring",
		right_ear = "Hermetic Earring",
		left_ring = "Persis Ring",
		right_ring = "Dingir Ring",
		back = Andartia.NUKE,
	}
	
	sets.midcast.nuking['Acc'] = sets.midcast.nuking['Normal']
	
	sets.midcast.MB['Normal'] = set_combine(sets.midcast.nuking['Normal'], {
		feet = AF.Feet,
		left_ring = "Mujin Band",
	})
	
	sets.midcast.MB['Acc'] = sets.midcast.MB['Normal']
	
	sets.midcast['Utsusemi'].Normal = {feet = EMPY.Feet, back = Andartia.TP,}
	sets.midcast['Utsusemi'].Enmity = set_combine(sets.precast['Provoke'], sets.midcast['Utsusemi'].Normal)
    
	
	--------------------------------------------------------------------------------------------------------------
	------------------------------------------------ Buff Sets ---------------------------------------------------
	--------------------------------------------------------------------------------------------------------------
	
	sets.buff.Doom = {
		neck = "Nicander's Necklace",
		left_ring = "Blenmot's Ring",
		waist = "Gishdubar Sash",
	}
	
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
		neck ={ name="Ninja Nodowa +2", augments={'Path: A',}},
		waist = "Grunfeld Rope",
		left_ear = "Ishvara Earring",
		right_ear = "Odr Earring",
		left_ring = "Regal Ring",
		right_ring = "Ilabrat Ring",
		back = Andartia.TP,
	}

    sets.precast['Blade: Ten'] = set_combine(sets.precast.WS,{
		
		ammo = "C. Palug Stone",
		head = AF.Head,
		body = Herc.Body.WSD,
		hands = RELIC.Hands,
		legs = RELIC.Legs,
		feet = { name="Tatena. Sune. +1", augments={'Path: A',}},
		waist = { name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear = { name="Lugra Earring +1", augments={'Path: A',}},
		right_ear = "Ishvara Earring",
		left_ring = "Regal Ring",
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
		left_ring = "Regal Ring",
		right_ring = "Ilabrat Ring",
		back = Andartia.TP,
	}
	
	sets.precast['Blade: Hi'] = {
		
		ammo = "C. Palug Stone",
		head = "Mummu Bonnet +2",
		body = "Abnoba Kaftan",
		hands = "Mummu Wrists +2",
		legs = "Mummu Kecks +2",
		feet = "Mummu Gamash. +2",
		neck = { name="Ninja Nodowa +2", augments={'Path: A',}},
		waist = "Windbuffet Belt",
		left_ear = "Ishvara Earring",
		right_ear = "Brutal Earring",
		left_ring = "Hetairoi Ring",
		right_ring = "Ilabrat Ring",
		back = Andartia.AGI,
	}
	
	sets.precast['Blade: Teki'] = {
	
		ammo = "Seeth. Bomblet +1",
		head = RELIC.Head,
		body = Herc.Body.MAB,
		hands = { name="Leyline Gloves", augments={'Accuracy+12','Mag. Acc.+10','"Mag.Atk.Bns."+1',}},
		legs = RELIC.Legs,
		feet = Herc.Feet.WSD,
		neck = "Sanctity Necklace",
		waist = { name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear = "Hecate's Earring",
		right_ear = "Friomisi Earring",
		left_ring = "Regal Ring",
		right_ring = "Dingir Ring",
		back = Andartia.STRWSD,
	}
	
	sets.precast['Blade: Kamu'] ={ 
		
		ammo = "Seeth. Bomblet +1",
		head = Herc.Head.WSD,
		body = Herc.Body.WSD,
		hands = Herc.Hands.MAB,
		legs = { name="Tatena. Haidate +1", augments={'Path: A',}},
		feet = Herc.Feet.WSD,
		neck = { name="Ninja Nodowa +2", augments={'Path: A',}},
		waist = { name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear = { name="Lugra Earring +1", augments={'Path: A',}},
		right_ear = "Ishvara Earring",
		left_ring = "Apate Ring",
		right_ring = "Regal Ring",
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
	
		neck = "Bathy Choker +1",
		left_ring = "Woltaris Ring",
	})
	
    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Engaged Sets ------------------------------------------
	------------------------------------------------------------------------------------------------
    -- We will switch to these every time we engage and return to them after ever ws while fighting
	
	sets.engaged = {}  -- leave this empty

    sets.engaged.TP = {
		
		ammo = "Date Shuriken",
		head = Adh.Head.A,
		body = "Malignance Tabard",
		hands = Adh.Hands.A,
		legs = { name="Tatena. Haidate +1", augments={'Path: A',}},
		feet = { name="Tatena. Sune. +1", augments={'Path: A',}},
		neck = { name="Ninja Nodowa +2", augments={'Path: A',}},
		waist = "Reiki Yotai",
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
		neck = { name="Ninja Nodowa +2", augments={'Path: A',}},
		waist = "Windbuffet Belt",
		left_ear = "Telos Earring",
		right_ear = "Sherida Earring",
		left_ring = "Epona's Ring",
		right_ring = "Hetairoi Ring",
		back = Andartia.TP,
	}
	
	sets.engaged.Acc = {
		
		ammo = "Yamarang",
		head = "Malignance Chapeau",
		body = "Malignance Tabard",
		hands = { name="Tatena. Gote +1", augments={'Path: A',}},
		legs = { name="Tatena. Haidate +1", augments={'Path: A',}},
		feet = "Malignance Boots",
		neck = { name="Ninja Nodowa +2", augments={'Path: A',}},
		waist = "Windbuffet Belt",
		left_ear = "Telos Earring",
		right_ear = "Sherida Earring",
		left_ring = "Epona's Ring",
		right_ring ="Hetairoi Ring",
		back = Andartia.TP,
	}
	
	sets.engaged.DT = {
		
		head = "Malignance Chapeau",
		body = "Malignance Tabard",
		hands = "Malignance Gloves",
		legs = "Malignance Tights",
		feet = "Malignance Boots",
		neck = "Warder's Charm +1",
		waist = "Engraved Belt",
		left_ear = "Telos Earring",
		right_ear = "Sherida Earring",
		left_ring = "Defending Ring",
		right_ring = "Warden's Ring",
		back = Andartia.TP,
	}
	
	------------
    -- Aftercast
    ------------
      
    -- I don't use aftercast sets, as we handle what to equip later depending on conditions using a function
	
	------------------------------------------------------------------------------------------------
    ----------------------------------------- Misc. Sets -------------------------------------------
	------------------------------------------------------------------------------------------------
	
	--	Note that movespeed is sets.me this is a holdover from the way the movespeed equip 
	--	helper function expects its input. I'll get around to fixing it eventually
	--	but this works for now
	
	sets.me = {} -- leave this empty
	
	-- Movespeedset
	sets.me.movespeed = {feet = "Danzo Sune-Ate",}
	
	--Night time movement. 
	sets.nightMovement = {feet = AF.Feet,}
	
	-- For running faster in Adoulin
	sets.adoulin = {body = "Councilor's Garb",}
	
end
