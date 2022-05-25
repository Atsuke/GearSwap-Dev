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
		gs c toggle ranged            	Toggle Ranged attack modes
		gs c dnc voke					Uses either Provoke or Animated Flourish depending on subjob
		
		gs c roll1 cycle				Cycles through roll 1
		gs c roll1 cycledown			Cycles backwards through roll 1
		gs c roll1 roll					Uses the selected Phantom Roll
		
		gs c roll2 cycle				Cycles through roll 2
		gs c roll2 cycledown			Cycles backwards through roll 2
		gs c roll2 roll					Uses the selected Phantom Roll
		
		gs c qd mode					Cycles through available Quickdraw modes
		gs c qd cycle					Cycles through Quickdraw elements
		gs c qd cycledown				Cycles backward through Quickdraw elements
		gs c qd shoot					Fires Quickdraw of the selected element
		
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

-- Optional. Swap to your COR macro sheet / book
 set_macros(2,21) -- Sheet, Book   

--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
-- Define your modes: 
-- You can add or remove modes in the table below, they will get picked up in the cycle automatically. 
-- Each mode needs to have a corresponding set in order to work.  ex: sets.idle.Regen

idleModes   = M('Regen','DT')
meleeModes  = M('TP', 'Hybrid', 'DT', 'Acc')
rangedModes = M('STP', 'ACC')
luzafMode   = M('ON','OFF')
quickDrawModes = M('STP', 'DMG', 'ACC', 'TH')

roll_1:set('Chaos Roll')     -- Roll 1 Default        (when you first load lua / change jobs the saved roll is this one)
roll_2:set('Samurai Roll')   -- Roll 2 Default        (when you first load lua / change jobs the saved roll is this one)	
	------------------------------------------------------------------------------------------------
    ------------------------------------------ Keybinds --------------------------------------------
    ------------------------------------------------------------------------------------------------
	
	-- Setup your Key Bindings here:
    
	windower.send_command('bind f9 gs c toggle idlemode')              -- F9 to change Idle Mode
	windower.send_command('bind !f9 gs c toggle runspeed') 		       -- Alt-F9 toggles locking on / off runspeed gear
	windower.send_command('bind f10 gs c toggle meleemode')            -- F10 to change engaged Mode    
	windower.send_command('bind f11 gs c toggle ranged')			   -- F11 Toggle ranged modes
	windower.send_command('bind !F11 gs c qd mode') 	               -- delete to toggle QD Modes 
	windower.send_command('bind f12 gs c toggle melee')			       -- F12 Toggle Melee mode on / off and locking of weapons  
	windower.send_command('bind insert gs c qd cycle') 		           -- insert to cycle QD Elements
	windower.send_command('bind !insert gs c qd cycledown')	           -- Alt + insert to cycleback QD Elements
	windower.send_command('bind delete gs c toggle luzaf')             -- Delete to toggle Luzaf Mode on or off
	windower.send_command('bind pageup gs c roll1 cycle')			   -- cycle roll 1
	windower.send_command('bind !pageup gs c roll1 cycledown')		   -- cycledown roll 1
	windower.send_command('bind pagedown gs c roll2 cycle')			   -- cycle roll 
	windower.send_command('bind !pagedown gs c roll2 cycledown')	   -- cycledown roll 2
	

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
keybinds_on['key_bind_ranged'] = '(F11) '
keybinds_on['key_bind_lock_weapon'] = '(F12) '
keybinds_on['key_bind_element_cycle'] = '(INSERT) '
keybinds_on['key_bind_luzaf_mode'] = '(DELETE) '
keybinds_on['key_bind_QD_mode'] = '(ALT-F11) '
keybinds_on['key_bind_roll_1'] = '(PgUp) '
keybinds_on['key_bind_roll_2'] = '(PgDwn) '

-- Set the tools you would like to track while tool tracker is set to on. 
-- Tools can be in inventory or wardrobe.  
-- Set value to empty string if you dont want to track a tool.  Ex. tool_4 = ''

tool_1 = "Chrono bullet"
tool_2 = "Shihei"
tool_3 = "Trump Card"
tool_4 = ""

-- Set these values for the text displayed in the hud
tools_on = {}
tools_on['tool_1'] = 'Chrono Bullet: '
tools_on['tool_2'] = "Shihei: "
tools_on['tool_3'] = "Cards: "
tools_on['tool_4'] = ""

-- set level for low tool warning
tool_warning = 20

-- Remember to unbind your keybinds on job change.
function user_unload()
	send_command('unbind f9')
	send_command('unbind !f9')
	send_command('unbind f10')
	send_command('unbind f11')	
	send_command('unbind !f10')
	send_command('unbind f12')
	send_command('unbind insert')
	send_command('unbind !insert')
	send_command('unbind delete')
	send_command('unbind pageup')
	send_command('unbind !pageup')
	send_command('unbind pagedown')
	send_command('unbind !pagedown')
	send_command('unbind !end') 
	      	
end
--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
include('/libs/COR_Lib.lua')            -- leave this as is. NO TOUCHEY!   
--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------

elemental_ws = S{"Aeolian Edge", "Leaden Salute", "Wildfire"}

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
	AF.Head  = "Laksa. Tricorne +3"
	AF.Body  = "Laksa. Frac +2"
	AF.Hands = "Laksa. Gants +2"
	AF.Legs  = "Laksa. Trews +1"
	AF.Feet  = "Laksa. Bottes +3"

	--Lanun
	RELIC.Head  = { name="Lanun Tricorne +1", augments={'Enhances "Winning Streak" effect',}}
	RELIC.Body  = { name="Lanun Frac +3", augments={'Enhances "Loaded Deck" effect',}}
	RELIC.Hands = { name="Lanun Gants +1", augments={'Enhances "Fold" effect',}}
	RELIC.Legs  = { name="Lanun Trews", augments={'Enhances "Snake Eye" effect',}}
	RELIC.Feet  = { name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}}
	
	--Chasseur
	EMPY.Head  = "Chass. Tricorne +1"
	EMPY.Body  = "Chasseur's Frac +1"
	EMPY.Hands = "Chasseur's Gants +1"
	EMPY.Legs  = "Chas. Culottes +1"
	EMPY.Feet  = "Chass. Bottes +1"
	
	-- Define your ammo preferences here.
	RAbullet   = "Chrono Bullet"
	RAccbullet = "Chrono Bullet"
	WSbullet   = "Chrono Bullet"
	MAbullet   = "Living Bullet"
	QDbullet   = "Hauksbok Bullet"
	
	-- NEVER AGAIN!
	no_shoot_ammo = S{"Animikii Bullet", "Hauksbok Bullet"}
	
	-- Define your JSE Capes here. 
	Camulus = {} -- leave this empty
	
	Camulus.RATP     = { name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Store TP"+10',}}
	Camulus.STRWSD   = { name="Camulus's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}
	Camulus.MeleeTP  = { name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
	Camulus.SnapShot = { name="Camulus's Mantle", augments={'"Snapshot"+10',}}
	Camulus.AGIWSD   = { name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%',}}
	Camulus.LStand	 = { name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Weapon skill damage +10%','Phys. dmg. taken-10%',}}
	
	------------------------------------------------------------------------------------------------
	---------------------------------------- Precast Sets ------------------------------------------
	------------------------------------------------------------------------------------------------
	
	sets.precast = {}   -- leave this empty
	sets.precast.WS= {}	-- leave this empty
	sets.precast.CorsairRoll = {} -- leave this empty
	sets.buff = {}  -- leave this empty
	
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
	
	sets.precast.Waltz = { 
		
		ammo = "Yamarang",
		head = "Mummu Bonnet +2",
		-- body = AF.Body,
		hands = "Nyame Gauntlets",
		legs = "Nyame Flanchard",
		feet = "Rawhide Boots",
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
    
	sets.precast.RA={
		
		ammo = RAbullet,
		head = EMPY.Head,
		body = AF.Body,
		hands = RELIC.Hands,
		legs = Adh.Legs.D,
		feet = "Meg. Jam. +2",
		neck = "Marked Gorget",
		waist = "Yemaya Belt",
		back = Camulus.SnapShot,
	}
	
	sets.precast.CorsairRoll.Duration = {
		
		range = { name="Compensator", augments={'DMG:+15','Rng.Atk.+15','"Mag.Atk.Bns."+15',}},
		ammo = "Chrono Bullet",
		head = RELIC.Head,
		hands = EMPY.Hands,
		neck = "Regal Necklace",	
	}
	
	sets.precast.LuzafRing = set_combine(sets.precast.CorsairRoll.Duration,{right_ring = "Luzaf's Ring"})
	
	--JA precasts
	sets.precast['Snake Eye'] = {legs = RELIC.Legs}
    sets.precast['Wild Card'] = {feet = RELIC.Feet}
    sets.precast['Random Deal'] = {body = RELIC.Body}
	sets.precast['Fold'] = {body = RELIC.Hands}
	sets.precast.CorsairRoll["Caster's Roll"] = set_combine(sets.precast.CorsairRoll.Duration, {legs = EMPY.Legs})
    sets.precast.CorsairRoll["Courser's Roll"] = set_combine(sets.precast.CorsairRoll.Duration, {feet = EMPY.Feet})
    sets.precast.CorsairRoll["Blitzer's Roll"] = set_combine(sets.precast.CorsairRoll.Duration, {head = EMPY.Head})
    sets.precast.CorsairRoll["Tactician's Roll"] = set_combine(sets.precast.CorsairRoll.Duration, {body = EMPY.Body})
    sets.precast.CorsairRoll["Allies' Roll"] = set_combine(sets.precast.CorsairRoll, {hands = EMPY.Hands})
    sets.precast.FoldDoubleBust = {hands = RELIC.Hands}
	
	------------------------------------------------------------------------------------------------
	---------------------------------------- Midcast Sets ------------------------------------------
	------------------------------------------------------------------------------------------------
	sets.midcast = {} --Leave this empty
	sets.midcast.RA = {}
	
	
	sets.midcast.RA = {
	
		head = "Meghanada Visor +2",
		body = AF.Body,
		hands = "Malignance Gloves",
		legs = "Meg. Chausses +2",
		feet = "Meg. Jam. +2",
		neck = "Iskur Gorget",
		waist = "Yemaya Belt",
		left_ear = "Telos Earring",
		right_ear = "Enervating Earring",
		left_ring = "Dingir Ring",
		right_ring = "Ilabrat Ring",
		back = Camulus.RATP,
	}
	
	sets.midcast.RA['STP'] = set_combine(sets.midcast.RA, {
		
		head = "Ikenga's Hat",
		legs = "Ikenga's Trousers",
		left_ring = "Chirich Ring",
		right_ring = "Chirich Ring",
	})
	
	sets.midcast.RA['ACC'] = set_combine(sets.midcast.RA, {
		
		waist = "Eschan Stone",
		left_ear = "Beyla Earring",
		left_ring = "Cacoethic Ring",
		right_ring = "Cacoethic Ring +1",
	})
	
	sets.TripleShot = {
		
		head = "Oshosi Mask",
		body = EMPY.Body,
		hands = RELIC.Hands,
		legs = "Oshosi Trousers",
		feet = "Oshosi Leggings",
		back = Camulus.RATP
	}
	
	--no Armageddon so no point. 
	sets.TripleShotCritical = sets.TripleShot
	
	
	sets.midcast['CorsairShot'] = {
		
		ammo = QDbullet,
		head = Herc.Head.MAB,
		body = RELIC.Body,
		hands = Carm.Hands.D,
		legs = Herc.Legs.WSD,
		feet = RELIC.Feet,
		neck = "Sanctity Necklace",
		waist = "Eschan Stone",
		left_ear = "Friomisi Earring",
		right_ear = "Hecate's Earring",
		left_ring = "Dingir Ring",
		right_ring = "Arvina Ringlet +1",
		back = Camulus.AGIWSD,
	}
	
	
	sets.midcast['CorsairShot']['STP'] = sets.midcast['CorsairShot'] 
	sets.midcast['CorsairShot']['DMG'] = sets.midcast['CorsairShot']
	
	sets.midcast['CorsairShot']['ACC'] = set_combine(sets.midcast['CorsairShot'],{
		head = AF.Head,
		--body = RELIC.Body,
		hands = AF.Hands,
		legs = "Ikenga's Trousers",
		feet =  AF.Feet,
		right_ear = "Gwati Earring",
		right_ring = "Stikini Ring",
	
	})
		
	sets.midcast['CorsairShot']['TH'] = set_combine(sets.midcast['CorsairShot'],{
		head = "Wh. Rarab Cap +1",
		waist = "Chaac Belt",
	})
	
	--------------------------------------------------------------------------------------------------------------
	------------------------------------------------ Buff Sets ---------------------------------------------------
	--------------------------------------------------------------------------------------------------------------
	
	sets.buff.Doom = {
		neck = "Nicander's Necklace",
		left_ring = "Blenmot's Ring",
		waist = "Gishdubar Sash",
	}
	
   
    --------------------------------------------------------------------------------------------------------------
    -------------------------------------------- Weapon Skill Sets -----------------------------------------------
    --------------------------------------------------------------------------------------------------------------
	
    
	sets.precast.WS = {
		
		ammo = "Chrono Bullet",
		head = "Meghanada Visor +2",
		body = AF.Body,
		hands = "Meg. Gloves +2",
		legs = "Meg. Chausses +2",
		feet = RELIC.Feet,
		neck = "Fotia Gorget",
		waist = "Fotia Belt",
		left_ear = "Beyla Earring",
		right_ear = "Volley Earring",
		left_ring = "Garuda Ring",
		right_ring = "Ilabrat Ring",
		back = Camulus.AGIWSD
	}

    sets.precast['Last Stand'] = set_combine(sets.precast.WS,{back = Camulus.LStand,})

	
    sets.precast['Leaden Salute'] = set_combine(sets.precast.WS,{
		
		ammo = WSbullet,
		head = "Pixie Hairpin +1",
		body = RELIC.Body,
		hands = Carm.Hands.D,
		legs = Herc.Legs.WSD,
		neck = "Sanctity Necklace",
		waist = "Eschan Stone",
		left_ear = "Friomisi Earring",
		right_ear = { name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		left_ring="Dingir Ring",
		right_ring = "Archon Ring",
		
	})

    sets.precast["Savage Blade"] = {
		
		ammo = WSbullet,
		head = Herc.Head.WSD,
		body = AF.Body,
		hands = "Meg. Gloves +2",
		legs = Herc.Legs.WSD,
		feet = RELIC.Feet,
		neck = "Lissome Necklace",
		waist = { name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear = "Brutal Earring",
		right_ear = { name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		left_ring = "Ifrit Ring",
		right_ring = "Rajas Ring",
		back = Camulus.STRWSD
	}

    sets.precast['Requiescat'] = set_combine(sets.precast.WS,{ 
		
		head = Adh.Head.A,
		body = AF.Body,
		hands = Adh.Body.B,
		legs = "Meg. Chausses +2",
		feet = RELIC.Feet,
		neck = "Fotia Gorget",
		waist = "Fotia Belt",
		left_ear = "Telos Earring",
		right_ear = { name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		left_ring = "Epona's Ring",
		right_ring = "Apate Ring",
		back = Camulus.MeleeTP,
	})
	
	sets.precast['Wildfire'] = {
		
		head = Herc.Head.WSD,
		body = RELIC.Body,
		hands = "Meg. Gloves +2",
		legs = Herc.Legs.WSD,
		feet = RELIC.Feet,
		neck = "Sanctity Necklace",
		waist = "Eschan Stone",
		left_ear = "Friomisi Earring",
		right_ear = "Hecate's Earring",
		left_ring = "Dingir Ring",
		right_ring = "Garuda Ring",
		back = Camulus.LStand,
	}
	
	sets.precast['Evisceration'] = {
		
		ammo = "Chrono Bullet",
		head = Adh.Head.A,
		body = "Meg. Cuirie +2",
		hands = "Mummu Wrists +2",
		legs = "Meg. Chausses +2",
		feet = "Mummu Gamash. +2",
		neck = "Fotia Gorget",
		waist = "Fotia Belt",
		left_ear = "Odr Earring",
		right_ear = "Suppanomimi",
		left_ring = "Epona's Ring",
		right_ring = "Ilabrat Ring",
		back = Camulus.MeleeTP,
	}
	
	sets.precast['Aeolian Edge'] = {
		
		head = Herc.Head.MAB,
		body = RELIC.Body,
		hands = Carm.Hands.D,
		legs = Herc.Legs.MAB,
		feet = RELIC.Feet,
		neck = "Sanctity Necklace",
		waist = "Eschan Stone",
		left_ear = "Friomisi Earring",
		right_ear = "Hecate's Earring",
		left_ring = "Dingir Ring",
		right_ring = "Arvina Ringlet +1",
		back = Camulus.AGIWSD,
	}

    ------------------------------------------------------------------------------------------------
    ----------------------------------------- Idle Sets --------------------------------------------
    ------------------------------------------------------------------------------------------------
	
	sets.idle = {} -- leave this empty
 		
	sets.idle.Regen = {
		
		ammo = "Chrono Bullet",
		head = "Meghanada Visor +2",
		body = "Meg. Cuirie +2",
		hands = "Meg. Gloves +2",
		legs = "Meg. Chausses +2",
		feet = "Meg. Jam. +2",
		waist = "Lycopodium Sash",
		neck = "Bathy Choker +1",
		left_ring = "Chirich Ring",
		right_ring = "Chirich Ring",
	}
	
	sets.idle.DT = {
		ammo = "Chrono Bullet",
		head = "Meghanada Visor +2",
		body = "Meg. Cuirie +2",
		hands = "Malignance Gloves",
		legs = "Meg. Chausses +2",
		feet = "Malignance Boots",
		neck = "Loricate Torque +1",
		waist = "Sailfi Belt +1",
		left_ear = "Odnowa Earring +1",
		right_ear = "Etiolation Earring",
		left_ring = "Epona's Ring",
		right_ring = "Defending Ring",
		back = Camulus.MeleeTP,
	
	}

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Engaged Sets ------------------------------------------
	------------------------------------------------------------------------------------------------
    -- We will switch to these every time we engage and return to them after ever ws while fighting
	
	sets.engaged = {}  -- leave this empty

    sets.engaged.TP = {
	
		ammo = "Chrono Bullet",
		head = Adh.Head.B,
		body = Adh.Body.B,
		hands = Adh.Hands.B,
		legs = "Meg. Chausses +2",
		feet = "Malignance Boots",
		neck = "Iskur Gorget",
		waist = "Reiki Yotai",
		left_ear = "Telos Earring",
		right_ear = "Suppanomimi",
		left_ring = "Epona's Ring",
		right_ring = "Petrov Ring",
		back = Camulus.MeleeTP
	}
	
	sets.engaged.Hybrid = set_combine(sets.engaged.TP, {
		
		head = "Meghanada Visor +2",
		hands = "Malignance Gloves",
		body = "Meg. Cuirie +2",
		feet = "Malignance Boots",
		
	
	
	})
	
	sets.engaged.DT = {
		ammo = "Chrono Bullet",
		head = "Meghanada Visor +2",
		body = "Meg. Cuirie +2",
		hands = "Malignance Gloves",
		legs = "Meg. Chausses +2",
		feet = "Malignance Boots",
		neck = "Loricate Torque +1",
		waist = { name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear = "Odnowa Earring +1",
		right_ear = "Etiolation Earring",
		left_ring = "Epona's Ring",
		right_ring = "Defending Ring",
		back = Camulus.MeleeTP,
	}
	
	sets.engaged.Acc = set_combine(sets.engaged.TP,{
	
		ammo = "Chrono Bullet",
		head = "Meghanada Visor +2",
		body = "Meg. Cuirie +2",
		hands = { name="Gazu Bracelet +1", augments={'Path: A',}},
		legs = "Meg. Chausses +2",
		feet = "Malignance Boots",
		neck = "Lissome Necklace",
		waist = "Kentarch Belt",
		left_ear = "Telos Earring",
		right_ear = "Odr Earring",
		left_ring = "Cacoethic Ring",
		right_ring = "Cacoethic Ring +1",
		back = Camulus.MeleeTP
	})
	
	
	------------------------------------------------------------------------------------------------
	----------------------------------------- Misc. Sets -------------------------------------------
	------------------------------------------------------------------------------------------------
	
	--	Note that movespeed is sets.me this is a holdover from the way the movespeed equip 
	--	helper function expects its input. I'll get around to fixing it eventually
	--	but this works for now
	
	sets.TH ={
		--ammo = "Per. Lucky Egg",
		head = "Wh. Rarab Cap +1",
		waist = "Chaac Belt",
    
	}
	
	sets.me = {} -- leave this empty
	
	sets.me.movespeed = {legs = "Carmine Cuisses +1",}
	sets.adoulin = {body = "Councilor's Garb",}
end
