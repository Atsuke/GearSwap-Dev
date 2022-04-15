version = "3.0"

--[[
	Big shoutout to Tunaliz https://github.com/Tunaliz for the amazing work he did, especially on the HUD.  
	His code was a fantastic starting point	I fixed some bugs in the existing code,
	added/removed/modified things to suit my needs and then built all of my lua's in a similar style. 
--]]

--[[
		Custom commands:
		
		Can bind these to keys or use in macros ex: /console gs c toggle melee
		
		gs c toggle idlemode			Change Idle Mode
		gs c toggle runspeed			Toggles locking on / off AF Feet
		gs c toggle meleemode			Change Idle Mode    
		gs c toggle enmity				Toggle casting modes between regular and Enmity for Utsusemi
		gs c toggle melee				Toggle Melee mode on / off and locking of weapons  
		gs c toggle thMode				Toggle Treasure Hunter Mode on or off
		gs c dnc voke					Uses either Provoke or Animated Flourish depending on subjob

		HUD Functions:
		gs c hud hide					Toggles the Hud entirely on or off
		gs c hud hidemode				Toggles the Modes section of the HUD on or off
		gs c hud hidejob				Toggles the job section of the HUD on or off
		gs c hud hidebattle				Toggles the Battle section of the HUD on or off
		gs c hud hidetools				Toggles the Tools section of the HUD on or off
		gs c hud lite					Toggles the HUD in lightweight style for less screen estate usage. Also on ALT-END
		gs c hud keybinds				Toggles Display of the HUD keybindings (my defaults) You can change just under the binds in the Gearsets file.
		gs c hud setcolor sections		Cycles colors for sections
		gs c hud setcolor options		Cycles colors for options
		gs c hud setcolor keybinds		Cycles colors for keybinds
		gs c hud setcolor selection		Cycles colors for selection
		gs c hud setcolor tools			Cycles colors for selection

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
-- TP threshold where weapons gets locked. 
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
toolColors:set('green')

textHideMode:set(false)		-- Change to toggle default visibility of Mode section
textHideOptions:set(false)	-- Change to toggle defautl visibility of Options sections
textHideJob:set(false)		-- Change to toggle default visibility of job Section
textHideBattle:set(true)	-- Change to toggle default visibility for battle section
textHideHUD:set(false)		-- Change to toggle default setting for hud visibility
useLightMode:set(false)		-- Change to toggle default setting for lite mode
keybinds:set(true)			-- Change to toggle default setting for keybind visibility
textHideTools:set(false)	-- Change to toggle the default setting of the tool counter


-- Optional. Swap to your sch macro sheet / book
-- set_macros(2,29) -- Sheet, Book

--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
-- Define your modes: 
-- You can add or remove modes in the table below, they will get picked up in the cycle automatically. 
-- to define sets for idle if you add more modes, name them: sets.idle.mymode and add 'mymode' in the group.

idleModes   = M('Regain', 'Regen','DT')
meleeModes  = M('TP', 'Hybrid', 'DT')

-- No point in enmity modes for Utsusemi if we aren't /NIN

	enmityModes = M('Normal', 'Enmity')
	
	------------------------------------------------------------------------------------------------
    ------------------------------------------ Keybinds --------------------------------------------
    ------------------------------------------------------------------------------------------------
	
	-- Setup your Key Bindings here:
    
	windower.send_command('bind f9 gs c toggle idlemode')			-- F9 to change Idle Mode
	windower.send_command('bind !f9 gs c toggle runspeed')			-- Alt-F9 toggles locking on / off Herald's Gaiters
	windower.send_command('bind f10 gs c toggle meleemode')			-- F9 to change Idle Mode    
	windower.send_command('bind f11 gs c toggle enmity')			-- F11 Toggle casting modes between regular and Enmity
	windower.send_command('bind f12 gs c toggle melee')				-- F12 Toggle Melee mode on / off and locking of weapons  
	windower.send_command('bind ^end gs c hud keybinds')			-- CTRL-End to toggle Keybinds
	

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
keybinds_on['key_bind_element_cycle'] = '(INSERT)'
keybinds_on['key_bind_movespeed_lock'] = '(ALT-F9)'
keybinds_on['key_bind_lock_weapon'] = '(F12) '


-- Remember to unbind your keybinds on job change.
function user_unload()
	send_command('unbind insert')
	send_command('unbind !insert')
	send_command('unbind delete')
	send_command('unbind !delete')
	send_command('unbind f9')
	send_command('unbind !f9')
	send_command('unbind f10')
	send_command('unbind f12')
	send_command('unbind home')
	send_command('unbind !home')
	send_command('unbind end')
	send_command('unbind !end')
	send_command('unbind !f10')	
	send_command('unbind `f10')
   	      	
end

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

--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
include('/libs/DNC_Lib.lua')            -- leave this as is. NO TOUCHEY!   
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

select_default_macro_book()

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
	--Maxixi
	AF.Head     =   "Maxixi Tiara +1"
	AF.Body     =   "Maxixi Casaque +3"
	AF.Hands    =   "Maxixi Bangles +3"
	AF.Legs     =  	"Maxixi Tights +1"
	AF.Feet     =   "Maxixi Toe Shoes +1"
	
	--Horos
	RELIC.Head  =   { name="Horos Tiara +3", augments={'Enhances "Trance" effect',}}
	RELIC.Body  =   { name="Horos Casaque +3", augments={'Enhances "No Foot Rise" effect',}}
	RELIC.Hands =   { name="Horos Bangles +3", augments={'Enhances "Fan Dance" effect',}}
	RELIC.Legs  =   { name="Horos Tights +3", augments={'Enhances "Saber Dance" effect',}}
	RELIC.Feet  =   { name="Horos T. Shoes +3", augments={'Enhances "Closed Position" effect',}}

	--Maculele
	EMPY.Head   =   "Maculele Tiara +1"
	EMPY.Body   =   "Macu. Casaque +1"
	EMPY.Hands  =   "Macu. Bangles +1"
	EMPY.Legs   =   "Charis Tights +2"
	EMPY.Feet   =   "Macu. Toe Shoes +1"

	-- Define your JSE Capes here. 
	Senuna = {} -- leave this empty
	Toetapper = {} -- leave this empty
	
	Toetapper.RF = { name="Toetapper Mantle", augments={'"Store TP"+4','"Dual Wield"+2','"Rev. Flourish"+29','Weapon skill damage +2%',}}
	Senuna.DA =  { name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
	Senuna.WSD = { name="Senuna's Mantle", augments={'DEX+20','DEX+10','Weapon skill damage +10%',}}
	Senuna.AGI = { name="Senuna's Mantle", augments={'AGI+20','Accuracy+20 Attack+20','AGI+10','Weapon skill damage +10%',}}

	
	
	------------------------------------------------------------------------------------------------
    ---------------------------------------- Precast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------
	
	sets.precast = {}   -- leave this empty
	sets.precast.WS= {}	-- leave this empty
	sets.buff = {}		-- leave this empty
	
	sets.precast['Utsusemi'] = {
			
		ammo = "Sapience Orb",
		head = Herc.Head.WSD,
		body = "Malignance Tabard",
		hands = { name="Leyline Gloves", augments={'Accuracy+12','Mag. Acc.+10','"Mag.Atk.Bns."+1',}},
		neck = "Magoraga Beads",
		waist = "Sailfi Belt +1",
		left_ear = "Etiolation Earring",
		right_ear = "Loquac. Earring",
		left_ring = "Gelatinous Ring +1",
		right_ring = "Prolix Ring",
	}

    sets.precast['No Foot Rise'] = {body = RELIC.Body}
	
	sets.precast['Provoke'] = {
	
		ammo = "Sapience Orb",
		head = "Halitus Helm",
		body = "Emet Harness +1",
		hands = RELIC.Hands,
		legs = "Zoar Subligar +1",
		feet = "Nyame Sollerets",
		neck = "Unmoving Collar +1",
		waist = "Engraved Belt",
		left_ear = "Genmei Earring",
		right_ear = "Friomisi Earring",
		left_ring = "Defending Ring",
		right_ring = "Provocare Ring",
		back = Senuna.DA,
	}
    
	sets.precast.Waltz = { 

		ammo = "Yamarang",
		head = RELIC.Head,
		body = AF.Body,
		hands = "Nyame Gauntlets",
		legs = "Nyame Flanchard",
		feet = "Nyame Sollerets",
		neck = { name = "Etoile Gorget +2", augments={'Path: A',}},
		waist = "Chaac Belt",
		left_ear = "Odnowa Earring +1",
		right_ear = "Etiolation Earring",
		left_ring = "Defending Ring",
		right_ring = "Gelatinous Ring +1",
		back=Senuna.DA,
	}
	
    sets.precast.WaltzSelf = set_combine(sets.precast.Waltz)
    
	sets.precast.Samba = {

		head = AF.Head,
		back = Senuna.DA
	}
    
	sets.precast.Jig = {

		legs = RELIC.Legs,
		feet = AF.Feet,
	}
	
	sets.precast['Violent Flourish'] = {

		ammo = "Yamarang",
		head = "Malignance Chapeau",
		body = RELIC.Body,
		hands = "Malignance Gloves",
		legs = "Malignance Tights",
		feet = "Malignance Boots",
		neck = { name="Etoile Gorget +2", augments={'Path: A',}},
		waist = "Eschan Stone",
		left_ear = "Odr Earring",
		right_ear = "Hermetic Earring",
		left_ring = "Defending Ring",
		right_ring = "Warden's Ring",
		back = Senuna.DA,
	}
	
	sets.precast.Step = {

		ammo = "Yamarang",
		head = "Malignance Chapeau",
		body = AF.Body,
		hands = AF.Hands,
		legs = "Malignance Tights",
		feet = RELIC.Feet,
		neck = { name = "Etoile Gorget +2", augments={'Path: A',}},
		waist ="Eschan Stone",
		left_ear = "Telos Earring",
		right_ear = "Odr Earring",
		left_ring = "Cacoethic Ring",
		right_ring = "Varar Ring +1",
		back = Senuna.DA,
	}   
    
	sets.precast['Animated Flourish'] = sets.precast['Provoke']
	
	sets.precast['Reverse Flourish'] = {

		hands = EMPY.Hands,
		back = Toetapper.RF,
	}

    ------------------------------------------------------------------------------------------------
    ------------------------------------- Weapon Skill Sets ----------------------------------------
    ------------------------------------------------------------------------------------------------
	
	sets.buff['Climactic Flourish'] = {head = EMPY.Head, body="Meg. Cuirie +2"}
	sets.midcast = {}
    
	sets.precast.WS = {
	
		ammo = "C. Palug Stone",
		head = Herc.Head.WSD,
		body = "Meg. Cuirie +2",
		hands = AF.Hands,
		legs = RELIC.Legs,
		feet = Herc.Feet.WSD,
		neck = "Fotia Gorget",
		waist = "Fotia Belt",
		left_ear = "Ishvara Earring",
		right_ear = "Odr Earring",
		left_ring = "Regal Ring",
		right_ring = "Ilabrat Ring",
		back = Senuna.WSD,
	}

    sets.precast['Exenterator'] = set_combine(sets.precast.WS,{
		
		head = "Malignance Chapeau",
		right_ear = "Brutal Earring",
		left_ring = "Regal Ring",
		back = Senuna.AGI,
	})

    sets.precast['Pyrrhic Kleos'] = set_combine(sets.precast.WS,{
		
		head = Herc.Head.WSD,
    	neck = { name="Etoile Gorget +2", augments={'Path: A',}},
		
	})
	
    sets.precast['Evisceration'] = set_combine(sets.precast.WS,{
		
		head = "Mummu Bonnet +2",
		body = "Abnoba Kaftan",
		legs = RELIC.Legs,
		feet = Herc.Feet.WSD,
		neck = { name="Etoile Gorget +2", augments={'Path: A',}},
		waist = "Grunfeld Rope",
	})

    sets.precast["Rudra's Storm"] = set_combine(sets.precast.WS,{
		body = Herc.Body.WSD,
		neck = { name="Etoile Gorget +2", augments={'Path: A',}},
		waist = "Grunfeld Rope",
	})
	
	sets.precast['Shark Bite'] = sets.precast["Rudra's Storm"]

    sets.precast['Aeolian Edge'] = set_combine(sets.precast.WS,{ 
		body = Herc.Body.MAB,
		hands = "Meg. Gloves +2",
		legs = RELIC.Legs,
		feet = Herc.Feet.WSD,
		neck = { name="Etoile Gorget +2", augments={'Path: A',}},
		waist = "Eschan Stone",
		left_ear = "Ishvara Earring",
		right_ear = "Hecate's Earring",
		left_ring = "Regal Ring",
		right_ring = "Persis Ring",
		back = Toetapper.RF,
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
		back = Senuna.DA,
	}
	
	sets.idle.Regen = set_combine(sets.idle.Regain, {
	
		body = "Meg. Cuirie +2",
		hands = "Meg. Gloves +2",
		neck = "Sanctity Necklace",
		left_ring = "Woltaris Ring",
	
	})
	
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


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Engaged Sets ------------------------------------------
	------------------------------------------------------------------------------------------------
    -- We will switch to these every time we engage and return to them after ever ws while fighting
	
	sets.engaged = {}  -- leave this empty

    sets.engaged.TP = {
	
		ammo = "Yamarang",
		head = Adh.Head.A,
		body = "Gleti's Cuirass",
		hands = Adh.Hands.A,
		legs = "Malignance Tights",
		feet = "Malignance Boots",
		neck = { name = "Etoile Gorget +2", augments={'Path: A',}},
		waist = "Windbuffet Belt",
		left_ear = "Telos Earring",
		right_ear = "Sherida Earring",
		left_ring = "Epona's Ring",
		right_ring = "Ilabrat Ring",
		back = Senuna.DA,
	}
	
	sets.engaged.Hybrid = {
	
		ammo = "Yamarang",
		head = "Malignance Chapeau",
		body = "Gleti's Cuirass",
		hands = "Malignance Gloves",
		legs = "Malignance Tights",
		feet = "Malignance Boots",
		neck = { name="Etoile Gorget +2", augments={'Path: A',}},
		waist = "Windbuffet Belt",
		left_ear = "Telos Earring",
		right_ear = "Sherida Earring",
		left_ring = "Epona's Ring",
		right_ring = "Ilabrat Ring",
		back = Senuna.DA,
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
		back = Senuna.DA,
	}
	
	
	------------------------------------------------------------------------------------------------
    ----------------------------------------- Misc. Sets -------------------------------------------
	------------------------------------------------------------------------------------------------
	
	--	Note that movespeed is sets.me this is a holdover from the way the movespeed equip 
	--	helper function expects its input. I'll get around to fixing it eventually
	--	but this works for now
	
	sets.me = {} -- leave this empty
	
	sets.me.movespeed = {feet = "Tandava Crackows",}
	sets.adoulin = {body = "Councilor's Garb",}
end
