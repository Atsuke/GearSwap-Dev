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
		gs c toggle runspeed            Toggles locking on / off AF Feet
		gs c toggle idlemode            Toggles between Refresh and DT idle mode. Activating Sublimation JA will auto replace refresh set for sublimation set. DT set will superceed both.        
		gs c toggle regenmode           Toggles between Hybrid, Duration and Potency mode for regen set  
		gs c toggle nukemode            Toggles between Normal and Accuracy mode for midcast Nuking sets (MB included)  
		gs c toggle matchsc             Toggles auto swapping element to match the last SC that just happenned.
		gs c toggle autoconvert			Toggles autoconvert modes 
		
		Casting functions:
		these are to set fewer macros (2 cycle, 5 cast) to save macro space when playing lazily with controler
        
		gs c nuke cycle              	Cycles element type for nuking & SC
		gs c nuke cycledown				Cycles element type for nuking & SC	in reverse order	
		gs c nuke t1                    Cast tier 1 nuke of saved element 
		gs c nuke t2                    Cast tier 2 nuke of saved element 
		gs c nuke t3                    Cast tier 3 nuke of saved element 
		gs c nuke t4                    Cast tier 4 nuke of saved element 
		gs c nuke t5                    Cast tier 5 nuke of saved element 
		gs c nuke ra1                   Cast tier 1 -ra nuke of saved element 
		gs c nuke ra2                   Cast tier 2 -ra nuke of saved element 
		gs c nuke ra3                   Cast tier 3 -ra nuke of saved element 	
		
		gs c geo geocycle				Cycles Geomancy Spell
		gs c geo geocycledown			Cycles Geomancy Spell in reverse order
		gs c geo indicycle				Cycles IndiColure Spell
		gs c geo indicycledown			Cycles IndiColure Spell in reverse order
		gs c geo geo					Cast saved Geo Spell
		gs c geo indi					Cast saved Indi Spell

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
		gs c nuke Dark                  Set Element Type to Dark DO NOTE the Element needs a Capital letter. 
		gs c nuke Light                 Set Element Type to Light DO NOTE the Element needs a Capital letter. 
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
autorunspeed = true
auto_CP_Cape = false
-- TP treshold where weapons gets locked. 
lockWeaponTP = 500
--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
-- HUD Initial setup and Positioning
--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
hud_x_pos = 1200		--important to update these if you have a smaller screen
hud_y_pos = 50			--important to update these if you have a smaller screen
hud_draggable = true	
hud_font_size = 9
hud_transparency = 150	-- a value of 0 (invisible) to 255 (no transparency at all)
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

textHideMode:set(false)		-- Change to toggle default visibility of Mode section
textHideOptions:set(false)	-- Change to toggle defautl visibility of Options sections
textHideJob:set(false)		-- Change to toggle default visibility of job Section
textHideBattle:set(false)	-- Change to toggle default visibility for battle section
textHideHUD:set(false)		-- Change to toggle default setting for hud visibility
useLightMode:set(false)		-- Change to toggle default setting for lite mode
keybinds:set(true)			-- Change to toggle default setting for keybind visibility
textHideTools:set(true)		-- Change to toggle the default setting of the tool counter

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


-- Optional. Swap to your sch macro sheet / book
set_macros(1,5) -- Sheet, Book   
--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
-- Define your modes: 
-- You can add or remove modes in the table below, they will get picked up in the cycle automatically. 
-- to define sets for idle if you add more modes, name them: sets.me.idle.mymode and add 'mymode' in the group.
-- to define sets for regen if you add more modes, name them: sets.midcast.regen.mymode and add 'mymode' in the group.
-- Same idea for nuke modes. 
idleModes = M('normal', 'dt', 'mdt')
-- To add a new mode to nuking, you need to define both sets: sets.midcast.nuking.mynewmode as well as sets.midcast.MB.mynewmode
nukeModes = M('normal', 'acc')
convertModes = M('OFF', 'AUTO')

-- Defults when you load the job / lua
geomancy:set('Geo-Frailty')			-- Geo Spell Default        (when you first load lua / change jobs the saved spells is this one)
indicolure:set('Indi-Fury')			-- Indi Spell Default       (when you first load lua / change jobs the saved spells is this one)
entrustindi:set('Indi-Haste')		-- Enttrust Spell Default   (when you first load lua / change jobs the saved spells is this one)

--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
-- Setup your Key Bindings here:  
	windower.send_command('bind insert gs c nuke cycle')				-- Insert Cycles Nuke element
	windower.send_command('bind !insert gs c nuke cycledown')			-- ALT+Insert Cycles Nuke element in reverse order   
    windower.send_command('bind end gs c geo geocycle')					-- END Cycles Geomancy Spell
	windower.send_command('bind !end gs c geo geocycledown')			-- ALT+END Cycles Geomancy Spell in reverse order	
    windower.send_command('bind home gs c geo indicycle')				-- Home Cycles IndiColure Spell
	windower.send_command('bind !home gs c geo indicycledown')			-- ALT+Home Cycles IndiColure Spell in reverse order	
    windower.send_command('bind delete gs c geo entrustcycle')			-- DELETE Cycles Entrust IndiColure Spell
	windower.send_command('bind !delete gs c geo entrustcledown')		-- ALT-DELETE Cycles Entrust IndiColure Spell in reverse order	
	windower.send_command('bind !f9 gs c toggle runspeed')				-- Alt-F9 toggles locking on / off Herald's Gaiters	
	windower.send_command('bind !f10 gs c toggle nukemode')				-- Alt-F10 to change Nuking Mode
	windower.send_command('bind F10 gs c toggle matchsc')				-- F10 to change Match SC Mode         
	windower.send_command('bind f12 gs c toggle melee')					-- F12 Toggle Melee mode on / off and locking of weapons
	windower.send_command('bind f9 gs c toggle idlemode')				-- F9 Toggles between MasterRefresh or MasterDT when no luopan is out
	windower.send_command('bind @end gs c hud lite')					-- Alt-End to toggle light hud version       
	windower.send_command('bind ^end gs c hud keybinds')				-- CTRL-End to toggle Keybinds
	windower.send_command('bind PAGEDOWN gs c toggle autoconvert')		-- PAGEDOWN to toggle Convert Mode
--[[
    This gets passed in when the Keybinds is turned on.
    Each one matches to a given variable within the text object
    IF you changed the Default Keybind above, Edit the ones below so it can be reflected in the hud using "//gs c hud keybinds" command
]]	
					
keybinds_on = {}
keybinds_on['key_bind_idle'] = '(F9) '
keybinds_on['key_bind_regen'] = '(END) '
keybinds_on['key_bind_casting'] = '(ALT-F10) '
keybinds_on['key_bind_matchsc'] = '(F10)'

keybinds_on['key_bind_element_cycle'] = '(INS) '
keybinds_on['key_bind_geo_cycle'] = '(END) '
keybinds_on['key_bind_indi_cycle'] = '(HOME) '
keybinds_on['key_bind_entrust_cycle'] = '(DELETE) '
keybinds_on['key_bind_lock_weapon'] = '(F12) '
keybinds_on['key_bind_movespeed_lock'] = '(ALT-F9) '
keybinds_on['key_bind_convert_mode'] = '(PgDwn)'


-- Remember to unbind your keybinds on job change.
function user_unload()
    send_command('unbind insert')
	send_command('unbind !insert')
    send_command('unbind end')
    send_command('unbind !end')
	send_command('unbind @end')
	send_command('unbind ^end')
	send_command('unbind home')
	send_command('unbind !home')
	send_command('unbind delete')
	send_command('unbind !delete')
    send_command('unbind f9')
    send_command('unbind !f9')
	send_command('unbind f10')
    send_command('unbind !f10')
	send_command('unbind f12')
	send_command('unbind ^PAGEDOWN')
end

--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
include('/libs/GEO_Lib.lua')          -- leave this as is     
--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------

validateTextInformation()

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
  
   ----------------------------------------------------------
	-- Auto CP Cape: Will put on CP cape automatically when
	-- fighting Apex mobs and job is not mastered
	----------------------------------------------------------
	CP_CAPE = "Mecisto. Mantle" -- Put your CP cape here
	----------------------------------------------------------

	-- My formatting is very easy to follow. All sets that pertain to my character doing things are under 'me'.
	-- All sets that are equipped to faciliate my.pan's behaviour or abilities are under .pan', eg, Perpetuation, Blood Pacts, etc
    
	sets.me = {}        -- leave this empty
	sets.pan = {}       -- leave this empty
	sets.me.idle = {}	-- leave this empty    
	sets.pan.idle = {}	-- leave this empty 

	-- sets starting with sets.me means you DONT have a luopan currently out.
	-- sets starting with sets.pan means you DO have a luopan currently out.
	
	include('Kuvira_AugGear.lua')	-- I list all my Augmented gears in a sidecar file since it's shared across many jobs. 
    
	-- JSE
	AF = {}         -- leave this empty
	RELIC = {}      -- leave this empty
	EMPY = {}       -- leave this empty
	-- Fill this with your own JSE. 
    
	--Geomancy
	AF.Head     =   "Geo. Galero +2"
	AF.Body     =   "Geomancy Tunic +2"
	AF.Hands    =   "Geo. Mitaines +3"
	AF.Legs     =   "Geo. Pants +2"
	AF.Feet     =   "Geo. Sandals +3"
	
	--Bagua
	RELIC.Head  =   "Bagua Galero +3"
	RELIC.Body  =   "Bagua Tunic +3"
	RELIC.Hands =   "Bagua Mitaines +1"
	RELIC.Legs  =   "RELIC.Legs"
	RELIC.Feet  =   "Bagua Sandals +1"

	--Azimuth
	EMPY.Head   =   "Azimuth Hood +1"
	EMPY.Body   =   "Azimuth Coat +1"
	EMPY.Hands  =   "Azimuth Gloves +1"
	EMPY.Legs   =   "Azimuth Tights +1"
	EMPY.Feet   =   "Azimuth Gaiters +1"
	
	-- Define JSE Capes
	Nantosuelta = {}
	Lifestream =  {}
	Lifestream.IndiDuration = { name="Lifestream Cape", augments={'Geomancy Skill +10','Indi. eff. dur. +18','Pet: Damage taken -5%',}}
	Nantosuelta.PetRegen    = { name="Nantosuelta's Cape", augments={'VIT+20','Eva.+20 /Mag. Eva.+20','Pet: "Regen"+10','Phys. dmg. taken-10%',}}
	Nantosuelta.MAB         = { name="Nantosuelta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}}
	Nantosuelta.FC          = { name="Nantosuelta's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10',}}
	

	-- Your idle set when you DON'T have a luopan out
	sets.me.idle.normal = {
		
		main = "Idris",
		sub = "Genmei Shield",
		range = { name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
		head = "Befouled Crown",
		body = AF.Body,
		hands = "Volte Gloves",
		legs = "Assid. Pants +1",
		feet = RELIC.Feet,
		neck = "Sibyl Scarf",
		waist = "Isa Belt",
		left_ear = "Odnowa Earring +1",
		right_ear = "Etiolation Earring",
		left_ring = "Fortified Ring",
		right_ring = "Defending Ring",
		back = Nantosuelta.PetRegen,
    }
	
    -- Your idle MasterDT set (Notice the sets.me, means no Luopan is out)
    sets.me.idle.dt = set_combine(sets.me.idle.normal,{
     
    })
    sets.me.idle.mdt = set_combine(sets.me.idle.normal,{
     
	})	
    -- Your MP Recovered Whilst Resting Set
    sets.me.resting = { 

    }
	
	sets.me.latent_refresh = {waist = "Fucho-no-obi"}
	
    ------------------------------------------------------------------------------------------------
	--------------------------------------- Luopan Sets --------------------------------------------
	------------------------------------------------------------------------------------------------
      
	-- Luopan's Out --  notice sets.pan 
	-- This is the base for all perpetuation scenarios, as seen below
	sets.pan.idle.normal = {
    
		main = "Idris",
		sub = "Genmei Shield",
		range = { name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
		head = EMPY.Head,
		body = "Mallquis Saio +2",
		hands = AF.Hands,
		legs = "Assid. Pants +1",
		feet = RELIC.Feet,
		neck = { name="Bagua Charm +2", augments={'Path: A',}},
		waist = "Isa Belt",
		left_ear = "Odnowa Earring +1",
		right_ear = "Etiolation Earring",
		left_ring = "Fortified Ring",
		right_ring = "Defending Ring",
		back = Nantosuelta.PetRegen,
    }
	
	-- This is when you have a Luopan out but want to sacrifice some slot for master DT, put those slots in.
    sets.pan.idle.dt = set_combine(sets.pan.idle.normal,{
       
    })   
    
	sets.pan.idle.mdt = set_combine(sets.pan.idle.normal,{
        
    })   
    
	-- Combat Related Sets
      
	-- Melee
	-- Anything you equip here will overwrite the perpetuation/refresh in that slot.
	-- No Luopan out
	-- they end in [idleMode] so it will derive from either the normal or the dt set depending in which mode you are then add the pieces filled in below.
	sets.me.melee = set_combine(sets.me.idle[idleMode],{
       
    })
	
	-- Luopan is out
	sets.pan.melee = set_combine(sets.pan.idle[idleMode],{
    
		range = { name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
        head = "Jhakri Coronal +1",
        body = "Jhakri Robe +2",
        hands = "Jhakri Cuffs +2",
        legs = "Jhakri Slops +2",
        feet = "Jhakri Pigaches +2",
        neck = "Sanctity Necklace",
        waist = "Windbuffet Belt +1",
        left_ear = "Mache Earring +1",
        right_ear = "Telos Earring",
        left_ring = "Jhakri Ring",
        right_ring = "Supershear Ring",
        back =  Nantosuelta.PetRegen,
    }) 
    
	------------------------------------------------------------------------------------------------
	-------------------------------------- Weaponskill Sets ----------------------------------------
	------------------------------------------------------------------------------------------------
	-- Example:
	sets.me["Flash Nova"] = {

    }

	sets.me["Realmrazer"] = {

    }
	
	sets.me["Exudation"] = {
	
		range = { name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
		head = "Jhakri Coronal +1",
		body = "Mallquis Saio +2",
		hands =  AF.Hands,
		legs = RELIC.Legs,
		feet = Merl.Feet.MAB,
		neck = "Erra Pendant",
		waist = "Grunfeld Rope",
		left_ear = "Malignance Earring",
		right_ear = "Telos Earring",
		left_ring = "Excelsis Ring",
		right_ring = "Evanescence Ring",
		back = Nantosuelta.MAB,
    } 
    
	-- Feel free to add new weapon skills, make sure you spell it the same as in game.
	
	------------------------------------------------------------------------------------------------
	---------------------------------------- Precast Sets ------------------------------------------
	------------------------------------------------------------------------------------------------
      
    sets.precast = {}               -- leave this empty    
    sets.midcast = {}               -- leave this empty    
    sets.aftercast = {}             -- leave this empty    
    sets.midcast.nuking = {}        -- leave this empty
    sets.midcast.MB = {}            -- leave this empty    
      
    -- Generic Casting Set that all others take off of. Here you should add all your fast cast  
    sets.precast.casting = {
        main = "Idris",
		range = { name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
		head = "Welkin Crown",
		body = Merl.Body.FC,
		hands = "Volte Gloves",
		legs = AF.Legs,
		feet = Merl.MAB,
		neck = "Incanter's Torque",
		waist = "Embla Sash",
		left_ear = "Malignance Earring",
		right_ear = "Loquac. Earring",
		left_ring = "Prolix Ring",
		right_ring = "Kishar Ring",
		back = Nantosuelta.FC,
    }   

    sets.precast.geomancy = set_combine(sets.precast.casting,{
        
    })
    -- Enhancing Magic, eg. Siegal Sash, etc
    sets.precast.enhancing = set_combine(sets.precast.casting,{
		waist = "Siegel Sash",
        neck = "Incanter's Torque",
    })
	
	sets.precast.nuke = set_combine(sets.precast.casting,{
	
		hands = RELIC.Hands,
	})
    -- Stoneskin casting time -, works off of enhancing -
    sets.precast.stoneskin = set_combine(sets.precast.enhancing,{
		head = "Umuthi Hat",
		legs = "Doyen Pants",
		neck = "Nodens Gorget",
		waist = "Siegel Sash",
    })
      
    -- Curing Precast, Cure Spell Casting time -
    sets.precast.cure = set_combine(sets.precast.casting,{
		main = "Daybreak",
		sub = "Ammurapi Shield",
		head = Van.Head.C,
		legs = "Doyen Pants",
		feet = Merl.Feet.MAB,
		neck = "Incanter's Torque",
		waist = "Embla Sash",
		left_ear = "Mendi. Earring",
		right_ear = "Loquac. Earring",
		left_ring = "Prolix Ring",
		back = Nantosuelta.FC,
    })
    sets.precast.regen = set_combine(sets.precast.casting,{

    })   
	
	---------------------
	-- Ability Precasting
	---------------------
	
	-- Fill up with your JSE! 
    sets.precast["Life Cycle"] = {body = AF.Body,}
    sets.precast["Bolster"] = {body = RELIC.Body,}
    sets.precast["Primeval Zeal"] = {head = RELIC.Head,}  
    sets.precast["Cardinal Chant"] = {head = AF.Head,}  
    sets.precast["Full Circle"] = {head = EMPY.Head,}  
    sets.precast["Curative Recantation"] = {hands = RELIC.Hands,}  
    sets.precast["Mending Halation"] = {legs = RELIC.Legs,}
    sets.precast["Radial Arcana"] = {feet = RELIC.Feet,}

	------------------------------------------------------------------------------------------------
	---------------------------------------- Mid Cast Sets -----------------------------------------
	------------------------------------------------------------------------------------------------
            
    -- Whatever you want to equip mid-cast as a catch all for all spells, and we'll overwrite later for individual spells
    
	sets.midcast.casting = {
    
		range = { name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
		head = RELIC.Head,
		body = RELIC.Body,
		hands = "Jhakri Cuffs +2",
		legs = RELIC.Legs,
		feet = Merl.Feet.MAB,
		neck = "Sanctity Necklace",
		waist = "Eschan Stone",
		left_ear = "Malignance Earring",
		right_ear = "Friomisi Earring",
		left_ring = "Jhakri Ring",
		right_ring = "Fenrir Ring",
		back = Nantosuelta.MAB,
    }
	
	---------------------
	-- Geo Spells
	---------------------
    sets.midcast.geo = set_combine(sets.midcast.casting,{
        main = "Idris",
		sub = "Genmei Shield",
		range = { name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
		head = Van.Head.C,
		body = Amal.Body.D,
		hands = Van.Hands.C,
		legs = RELIC.Legs,
		feet = "Azimuth Gaiters +1",
		neck = { name="Bagua Charm +2", augments={'Path: A',}},
		waist = "Austerity Belt",
		left_ear = "Gifted Earring",
		right_ear = "Fulla Earring",
		left_ring = "Stikini Ring",
		right_ring = "Kishar Ring",
		back = Lifestream.IndiDuration,
    })
	
	---------------------
	-- Indi Spells
	---------------------
    sets.midcast.indi = set_combine(sets.midcast.geo,{legs = RELIC.Legs,})
	
	-- For Entrusted Indi Spells
    sets.midcast.entrust = set_combine(sets.midcast.indi,{
		main = "Solstice",
        legs = RELIC.Legs,
    })

	sets.midcast.Obi = {waist = "Hachirin-no-Obi",}
	
	---------------------
	-- Nuking
	---------------------
	sets.midcast.nuking.normal = set_combine(sets.midcast.casting,{
        main = "Daybreak",
		sub = "Ammurapi Shield",
		range = { name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
		head = RELIC.Head,
		body = RELIC.Body,
		hands = Amal.Hands.D,
		legs = RELIC.Legs,
		feet = Merl.Feet.MAB,
		neck = "Sanctity Necklace",
		waist = "Eschan Stone",
		left_ear = "Malignance Earring",
		right_ear = "Friomisi Earring",
		left_ring = "Jhakri Ring",
		right_ring = "Fenrir Ring",
		back = Nantosuelta.MAB,
    })
	
	sets.midcast.MB.normal = set_combine(sets.midcast.nuking.normal, {
		
		body = "Ea Houppelande",
		legs = "Ea Slops",
		neck = "Mizu. Kubikazari",
		right_ring = "Mujin Band",
		
        
	})
    sets.midcast.nuking.acc = set_combine(sets.midcast.nuking.normal,{

    })
    sets.midcast.MB.acc = set_combine(sets.midcast.MB.normal, {

    })

	---------------------
	-- Enfeebling
	---------------------
	sets.midcast.IntEnfeebling = set_combine(sets.midcast.casting,{
        main = "Daybreak",
		sub = "Ammurapi Shield",
		range = { name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
		head = RELIC.Head,
		body = RELIC.Body,
		hands = AF.Hands,
		legs = RELIC.Legs,
		feet = AF.Hands,
		neck = "Incanter's Torque",
		waist = "Eschan Stone",
		left_ear = "Malignance Earring",
		right_ear = "Mendi. Earring",
		left_ring = "Jhakri Ring",
		right_ring = "Stikini Ring",
		back = Nantosuelta.FC,
    })
	sets.midcast.MndEnfeebling = set_combine(sets.midcast.IntEnfeebling,{
        
    })
	
	---------------------
	-- Enhancing
	---------------------
    sets.midcast.enhancing = set_combine(sets.midcast.casting,{
        main = "Daybreak",
        head = Telchine.Head.en ,
		body = Merl.Body.FC,
		hands = RELIC.Hands,
		legs = Telchine.Legs.en,
		feet = Telchine.Feet.en,
		neck = "Incanter's Torque",
		waist = "Embla Sash",
		left_ear = "Andoaa Earring",
		right_ear = "Loquac. Earring",
		left_ring = "Stikini Ring",
		right_ring = "Jhakri Ring",
		back = Nantosuelta.FC,
    })
	
    -- Stoneskin
    sets.midcast.stoneskin = set_combine(sets.midcast.enhancing,{
		legs = "Doyen Pants",
		neck = "Nodens Gorget",
		waist = "Siegel Sash",
    })
    
	-- Refresh
	sets.midcast.refresh = set_combine(sets.midcast.enhancing,{
		
    })
    
	-- Aquaveil
	sets.midcast.aquaveil = sets.midcast.refresh
	
	-- Drain
	sets.midcast["Drain"] = set_combine(sets.midcast.IntEnfeebling, {		
		head = "Pixie Hairpin +1",
		neck = "Erra Pendant",
		waist = "Fucho-no-Obi",
		left_ring = "Excelsis Ring",
		right_ring = "Evanescence Ring",
        
	})

	sets.midcast["Aspir"] = sets.midcast["Drain"]
     
    sets.midcast.cure = {} -- Leave This Empty
    
	---------------------
	-- Cures
	---------------------
	sets.midcast.cure.normal = set_combine(sets.midcast.casting,{
        main = "Daybreak",
		sub = "Genmei Shield",
		range = { name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
		head = Van.Head.ConMP,
		body = Merl.Body.FC,
		hands ="Jhakri Cuffs +2",
		legs = "Doyen Pants",
		feet = "Vanya Clogs",
		neck = "Nodens Gorget",
		waist = "Austerity Belt",
		left_ear = "Gifted Earring",
		right_ear = "Mendi. Earring",
		left_ring = "Stikini Ring",
		right_ring = "Kishar Ring",
		back = Nantosuelta.FC,
    })
    
	sets.midcast.cure.weather = set_combine(sets.midcast.cure.normal,{waist="Hachirin-no-Obi",})    
    
	-- Regen
	sets.midcast.regen = set_combine(sets.midcast.enhancing,{
        main = "Bolelabunga",
        sub = "Ammurapi Shield",
        head = Telchine.Head.en,
        --body = Telchine.Body.en,
        hands = Telchine.Hands.en,
        legs = Telchine.Legs.en,
        feet = Telchine.Feet.en,
        neck = "Incanter's Torque",
        
    }) 
   
    ------------
    -- Aftercast
    ------------
      
    -- I don't use aftercast sets, as we handle what to equip later depending on conditions using a function, eg, do we have a Luopan pan out?
	
	------------------------------------------------------------------------------------------------
    ----------------------------------------- Misc. Sets -------------------------------------------
	------------------------------------------------------------------------------------------------
	
	-- Movespeed boots
	sets.me.movespeed = {feet = AF.Feet}
	
	
	-- For running faster in Adoulin
	sets.adoulin = {body = "Councilor's Garb",}
end
