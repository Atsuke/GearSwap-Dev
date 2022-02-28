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

-- Optional. Swap to your sch macro sheet / book
-- set_macros(2,29) -- Sheet, Book   

--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
-- Define your modes: 
-- You can add or remove modes in the table below, they will get picked up in the cycle automatically. 
-- to define sets for idle if you add more modes, name them: sets.idle.mymode and add 'mymode' in the group.

idleModes   = M('Regain', 'Regen','DT')
meleeModes  = M('TP', 'Hybrid', 'DT')
treasureHunter = M('OFF', 'ON')
enmityModes = M('Normal', 'Enmity')
	
	------------------------------------------------------------------------------------------------
    ------------------------------------------ Keybinds --------------------------------------------
    ------------------------------------------------------------------------------------------------
	
	-- Setup your Key Bindings here:
    
    windower.send_command('bind f9 gs c toggle idlemode')              -- F9 to change Idle Mode
	windower.send_command('bind !f9 gs c toggle runspeed') 		       -- Alt-F9 toggles locking on / off Herald's Gaiters
	windower.send_command('bind f10 gs c toggle meleemode')            -- F9 to change Idle Mode    
    windower.send_command('bind f11 gs c toggle enmity')			   -- F11 Toggle casting modes between regular and Enmity
	windower.send_command('bind f12 gs c toggle melee')			       -- F12 Toggle Melee mode on / off and locking of weapons  
    windower.send_command('bind ^end gs c hud keybinds')               -- CTRL-End to toggle Keybinds
	windower.send_command('bind insert gs c toggle thMode')            -- insert to toggle Treasure Hunter Mode on or off
	

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
keybinds_on['key_bind_treasure_hunter'] = '(INSERT)'
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
--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
include('/libs/THF_Lib.lua')            -- leave this as is. NO TOUCHEY!   
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
    --Pillager's
    AF.Head  = "Pill. Bonnet +1"
    AF.Body  = "Pillager's Vest +1"
    AF.Hands = "Pill. Armlets +1"
    AF.Legs  = "Pill. Culottes +1"
    AF.Feet  = "Pill. Poulaines +1"

    --Plunderer's
    RELIC.Head  ={ name="Plun. Bonnet +1", augments={'Enhances "Aura Steal" effect',}}
    RELIC.Body  ={ name="Plunderer's Vest +1", augments={'Enhances "Ambush" effect',}}
    RELIC.Hands ={ name="Plun. Armlets +3", augments={'Enhances "Perfect Dodge" effect',}}
    RELIC.Legs  ={ name="Plun. Culottes +1", augments={'Enhances "Feint" effect',}}
    RELIC.Feet  ={ name="Plun. Poulaines +2", augments={'Enhances "Assassin\'s Charge" effect',}}
	
    --Skulker
    EMPY.Head  ="Skulker's Bonnet +1"
    EMPY.Body  ="Skulker's Vest +1"
    EMPY.Hands ="Skulk. Armlets +1"
    EMPY.Legs  ="Skulk. Culottes +1"
    EMPY.Feet  ="Skulk. Poulaines +1"
	
	-- Define your JSE Capes here. 
	Toutatis = {} -- leave this empty
	
	Toutatis.TP  ={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dual Wield"+10','Damage taken-5%',}}
	Toutatis.WSD ={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Damage taken-5%',}}
	
	
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
		head = RELIC.Head,
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
    
	
	sets.precast['Utsusemi'] = {
		ammo = "Sapience Orb",
		head = Herc.Head.WSD,
		body = "Malignance Tabard",
		hands = { name="Leyline Gloves", augments={'Accuracy+12','Mag. Acc.+10','"Mag.Atk.Bns."+1',}},
		legs = "Gleti's Breeches",
		feet = "Gleti's Boots",
		neck = "Magoraga Beads",
		waist = "Sailfi Belt +1",
		left_ear = "Etiolation Earring",
		right_ear = "Loquac. Earring",
		left_ring = "Defending Ring",
		right_ring = "Prolix Ring",
		
	
	}
	
	
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
	
	sets.precast['Accomplice'] = {head = EMPY.Head}
	sets.precast['Collaborator'] = sets.precast['Accomplice']
	sets.precast['Hide'] = {body = AF.Body}
	sets.precast['Conspirator'] = {Body = EMPY.Body}
	sets.precast['Perfect Dodge'] = {hands = RELIC.Hands,}
	sets.precast['Feint'] = {legs = RELIC.Legs}
	sets.precast['Flee'] = {feet = AF.Feet}

    ------------------------------------------------------------------------------------------------
    ------------------------------------- Weapon Skill Sets ----------------------------------------
    ------------------------------------------------------------------------------------------------
	
	sets.buff['Sneak Attack'] = {hands = EMPY.Hands}
	sets.buff['Trick Attack'] = {hands= AF.Hands}
	sets.midcast = {}
    
	sets.precast.WS = {
		ammo = "C. Palug Stone",
		head = Herc.Head.WSD,
		body = Herc.Body.WSD,
		hands = "Meg. Gloves +2",
		legs = Herc.Legs.MAB,
		feet = Herc.Feet.WSD,
		neck = { name="Asn. Gorget +1", augments={'Path: A',}},
		waist = "Grunfeld Rope",
		left_ear = "Ishvara Earring",
		right_ear = "Odr Earring",
		left_ring = "Thundersoul Ring",
		right_ring = "Ilabrat Ring",
		back = Toutatis.WSD,
	}

    sets.precast['Exenterator'] = set_combine(sets.precast.WS,{
		head = "Malignance Chapeau",
		body = "Meg. Cuirie +2",
		neck = "Fotia Gorget",
		waist = "Fotia Belt",
		right_ear = "Brutal Earring",
		right_ear = "Sherida Earring",
		left_ring = "Stormsoul Ring",
		
	})

	
    sets.precast['Evisceration'] = set_combine(sets.precast.WS,{
		head = "Mummu Bonnet +2",
		body = "Abnoba Kaftan",
		legs = AF.Legs,
		feet = Herc.Feet.WSD,
		neck = { name="Asn. Gorget +1", augments={'Path: A',}},
		waist = "Grunfeld Rope",
	})

    sets.precast["Rudra's Storm"] = set_combine(sets.precast.WS,{
		
	})

    sets.precast['Aeolian Edge'] = set_combine(sets.precast.WS,{ 
		body = Herc.Body.MAB,
		hands = "Meg. Gloves +2",
		legs=Herc.Legs.MAB,
		feet = Herc.Feet.WSD,
		neck = "Sanctity Necklace",
		waist = "Eschan Stone",
		left_ear = "Ishvara Earring",
		right_ear = "Hecate's Earring",
		left_ring = "Thundersoul Ring",
		right_ring = "Persis Ring",
		back = Toutatis.WSD
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
		head = "Malignance Chapeau",
		body = "Gleti's Cuirass",
		hands = "Malignance Gloves",
		legs = "Malignance Tights",
		feet = RELIC.Feet,
		neck = { name = "Etoile Gorget +2", augments={'Path: A',}},
		waist = "Windbuffet Belt",
		left_ear = "Telos Earring",
		right_ear = "Sherida Earring",
		left_ring = "Epona's Ring",
		right_ring = "Ilabrat Ring",
		back = Toutatis.TP,
	}
	
	sets.engaged.Hybrid = {
		ammo = "Yamarang",
		head = "Malignance Chapeau",
		body = "Gleti's Cuirass",
		hands = "Malignance Gloves",
		legs = "Malignance Tights",
		feet = RELIC.Feet,
		neck={ name="Asn. Gorget +1", augments={'Path: A',}},
		waist = "Windbuffet Belt",
		left_ear = "Telos Earring",
		right_ear = "Sherida Earring",
		left_ring = "Epona's Ring",
		right_ring="Hetairoi Ring",
		back = Toutatis.TP
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
		back = Toutatis.TP
	}
	
	
	------------------------------------------------------------------------------------------------
    ----------------------------------------- Misc. Sets -------------------------------------------
	------------------------------------------------------------------------------------------------
	
	--	Note that movespeed is sets.me this is a holdover from the way the movespeed equip 
	--	helper function expects its input. I'll get around to fixing it eventually
	--	but this works for now
	sets.TH ={
    ammo = "Per. Lucky Egg",
    head = "Wh. Rarab Cap +1",
    hands = RELIC.Hands,
    feet = "Skulk. Poulaines +1",
    waist = "Chaac Belt",
    
}
	sets.me = {} -- leave this empty
	
	sets.me.movespeed = {feet = AF.Feet,}
end
