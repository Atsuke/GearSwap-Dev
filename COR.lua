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

idleModes   = M('Regen','DT')
meleeModes  = M('TP', 'Hybrid', 'DT')
rangedModes = M('STP', 'ACC')
luzafMode   = M('ON','OFF')
quickDrawModes = M('STP', 'DMG', 'ACC', 'TH')

	
	------------------------------------------------------------------------------------------------
    ------------------------------------------ Keybinds --------------------------------------------
    ------------------------------------------------------------------------------------------------
	
	-- Setup your Key Bindings here:
    
    windower.send_command('bind f9 gs c toggle idlemode')              -- F9 to change Idle Mode
	windower.send_command('bind !f9 gs c toggle runspeed') 		       -- Alt-F9 toggles locking on / off Herald's Gaiters
	windower.send_command('bind f10 gs c toggle meleemode')            -- F10 to change engaged Mode    
    windower.send_command('bind f11 gs c toggle ranged')			   -- F11 Toggle ranged modes
	windower.send_command('bind f12 gs c toggle melee')			       -- F12 Toggle Melee mode on / off and locking of weapons  
    windower.send_command('bind ^end gs c hud keybinds')               -- CTRL-End to toggle Keybinds
	windower.send_command('bind insert gs c toggle luzaf')             -- insert to toggle Luzaf Mode on or off
	windower.send_command('bind delete gs c toggle qd')                -- delete to toggle QD Modes 
	

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
keybinds_on['key_bind_luzaf_mode'] = '(INSERT) '
keybinds_on['key_bind_QD_mode'] = '(DELETE) '

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
include('Kuvira_AugGear.lua') -- I list all my Augmented gears in a sidecar file since it's shared across many jobs. 
    
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
    AF.Head = "Laksa. Tricorne +2"
    AF.Body = "Laksa. Frac +2"
    AF.Hands = "Laksa. Gants +1"
    AF.Legs = "Laksa. Trews +1"
    AF.Feet = "Laksa. Bottes +1"

    --Lanun
    RELIC.Head = { name="Lanun Tricorne +1", augments={'Enhances "Winning Streak" effect',}}
    RELIC.Body = { name="Lanun Frac +3", augments={'Enhances "Loaded Deck" effect',}}
    RELIC.Hands = { name="Lanun Gants +1", augments={'Enhances "Fold" effect',}}
    RELIC.Legs = { name="Lanun Trews", augments={'Enhances "Snake Eye" effect',}}
    RELIC.Feet = { name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}}
	
    --Chasseur
    EMPY.Head = "Chass. Tricorne +1"
    EMPY.Body = "Chasseur's Frac +1"
    EMPY.Hands = "Chasseur's Gants +1"
    EMPY.Legs = "Chas. Culottes +1"
    EMPY.Feet = "Chass. Bottes +1"
	
	-- Define your ammo preferences here.
	RAbullet = "Chrono Bullet"
    RAccbullet = "Chrono Bullet"
    WSbullet = "Chrono Bullet"
    MAbullet = "Living Bullet"
    QDbullet = "Bronze Bullet"
	
	-- NEVER AGAIN!
	no_shoot_ammo = S{"Animikii Bullet", "Hauksbok Bullet", "Bronze Bullet"}
	
	-- Define your JSE Capes here. 
	Camulus = {} -- leave this empty
	
	Camulus.RATP     = { name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Store TP"+10',}}
	Camulus.STRWSD   = { name="Camulus's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}
	Camulus.MeleeTP  = { name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+5','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
	Camulus.SnapShot = { name="Camulus's Mantle", augments={'"Snapshot"+10',}}
	Camulus.AGIWSD   = { name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%',}}
	
	------------------------------------------------------------------------------------------------
    ---------------------------------------- Precast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------
	
	sets.precast = {}   -- leave this empty
	sets.precast.WS= {}	-- leave this empty
	sets.precast.CorsairRoll = {}
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
		
		ammo = RAbullet,
		head = "Chass. Tricorne +1",
		body = "Laksa. Frac +2",
		hands = { name="Carmine Fin. Ga.", augments={'Rng.Atk.+15','"Mag.Atk.Bns."+10','"Store TP"+5',}},
		legs = { name="Adhemar Kecks", augments={'AGI+10','"Rapid Shot"+10','Enmity-5',}},
		feet = "Meg. Jam. +2",
		neck = "Marked Gorget",
		waist = "Yemaya Belt",
		left_ear = "Beyla Earring",
		right_ear = "Enervating Earring",
		left_ring = "Cacoethic Ring +1",
		right_ring = "Ilabrat Ring",
		back = Camulus.SnapShot,
	}
	
	sets.precast.CorsairRoll.Duration = {
		range={ name="Compensator", augments={'DMG:+15','Rng.Atk.+15','"Mag.Atk.Bns."+15',}},
		ammo="Chrono Bullet",
		head={ name="Lanun Tricorne +1", augments={'Enhances "Winning Streak" effect',}},
		hands="Chasseur's Gants +1",
		neck="Regal Necklace",	
	}
	
	sets.precast.LuzafRing = set_combine(sets.precast.CorsairRoll.Duration,{right_ring = "Luzaf's Ring"})
	
	
	sets.precast['Snake Eye'] = {legs = RELIC.Legs}
    sets.precast['Wild Card'] = {feet = RELIC.Feet}
    sets.precast['Random Deal'] = {body = RELIC.Body}
	sets.precast.CorsairRoll["Caster's Roll"] = set_combine(sets.precast.CorsairRoll.Duration, {legs = EMPY.Legs})
    sets.precast.CorsairRoll["Courser's Roll"] = set_combine(sets.precast.CorsairRoll.Duration, {feet = EMPY.Feet})
    sets.precast.CorsairRoll["Blitzer's Roll"] = set_combine(sets.precast.CorsairRoll.Duration, {head = EMPY.Head})
    sets.precast.CorsairRoll["Tactician's Roll"] = set_combine(sets.precast.CorsairRoll.Duration, {body = EMPY.Body})
    sets.precast.CorsairRoll["Allies' Roll"] = set_combine(sets.precast.CorsairRoll, {hands = EMPY.Hands})

    sets.precast.FoldDoubleBust = {hands="Lanun Gants +3"}
	
	------------------------------------------------------------------------------------------------
    ---------------------------------------- Midcast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------
	sets.midcast = {} --Leave this empty
	sets.midcast.RA = {}
	
	
	sets.midcast.RA = {
		head = "Meghanada Visor +1",
		body = "Laksa. Frac +2",
		hands = "Meg. Gloves +2",
		legs = "Meg. Chausses +2",
		feet = "Meg. Jam. +2",
		neck = "Iskur Gorget",
		waist = "Yemaya Belt",
		left_ear = "Telos Earring",
		right_ear = "Enervating Earring",
		left_ring = "Garuda Ring",
		right_ring = "Ilabrat Ring",
		back = Camulus.RATP,
	}
	
	sets.midcast.RA['STP'] = set_combine(sets.midcast.RA, {head = 'Dampening Tam'})
	sets.midcast.RA['ACC'] = set_combine(sets.midcast.RA, {head = 'Blistering Sallet +1'})
	
	sets.TripleShot = set_combine(sets.midcast.RA,{
		body = EMPY.Body,
		hands = RELIC.Hands,
	})
	
	--no Armageddon so no point. 
	sets.TripleShotCritical = sets.TripleShot
	
	
	sets.midcast['CorsairShot'] = {
		
		ammo = QDbullet,
		head = { name="Herculean Helm", augments={'"Mag.Atk.Bns."+23','STR+5','Damage taken-1%','Accuracy+17 Attack+17','Mag. Acc.+16 "Mag.Atk.Bns."+16',}},
		body = { name="Lanun Frac +3", augments={'Enhances "Loaded Deck" effect',}},
		hands = { name="Carmine Fin. Ga.", augments={'Rng.Atk.+15','"Mag.Atk.Bns."+10','"Store TP"+5',}},
		legs = { name="Herculean Trousers", augments={'Pet: "Mag.Atk.Bns."+4','DEX+7','Weapon skill damage +6%',}},
		feet = { name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
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
	sets.midcast['CorsairShot']['ACC'] = sets.midcast['CorsairShot']
	sets.midcast['CorsairShot']['TH'] = set_combine(sets.precast['Corsairshot'], sets.TH)
	
    ------------------------------------------------------------------------------------------------
    ------------------------------------- Weapon Skill Sets ----------------------------------------
    ------------------------------------------------------------------------------------------------
	
	sets.buff['Sneak Attack'] = {hands = EMPY.Hands}
	sets.buff['Trick Attack'] = {hands= AF.Hands}
	
    
	sets.precast.WS = {
		
		ammo = "Chrono Bullet",
		head = "Meghanada Visor +1",
		body = "Laksa. Frac +2",
		hands = "Meg. Gloves +2",
		legs = "Meg. Chausses +2",
		feet = { name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
		neck = "Fotia Gorget",
		waist = "Fotia Belt",
		left_ear = "Beyla Earring",
		right_ear = "Volley Earring",
		left_ring = "Garuda Ring",
		right_ring = "Ilabrat Ring",
		back = Camulus.AGIWSD
	}

    sets.precast['Last Stand'] = sets.precast.WS

	
    sets.precast['Leaden Salute'] = set_combine(sets.precast.WS,{
		ammo = WSbullet,
		head = "Pixie Hairpin +1",
		body = { name="Lanun Frac +3", augments={'Enhances "Loaded Deck" effect',}},
		hands = { name="Carmine Fin. Ga.", augments={'Rng.Atk.+15','"Mag.Atk.Bns."+10','"Store TP"+5',}},
		legs = { name="Herculean Trousers", augments={'Pet: "Mag.Atk.Bns."+4','DEX+7','Weapon skill damage +6%',}},
		neck = "Sanctity Necklace",
		waist = "Eschan Stone",
		left_ear = "Friomisi Earring",
		right_ear = { name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		left_ring="Dingir Ring",
		right_ring = "Archon Ring",
		
	})

    sets.precast["Savage Blade"] = {
		ammo = WSbullet,
		head = { name="Herculean Helm", augments={'Accuracy+1','MND+9','Weapon skill damage +7%','Accuracy+5 Attack+5','Mag. Acc.+9 "Mag.Atk.Bns."+9',}},
		body = "Laksa. Frac +2",
		hands = "Meg. Gloves +2",
		legs = { name="Herculean Trousers", augments={'Pet: "Mag.Atk.Bns."+4','DEX+7','Weapon skill damage +6%',}},
		feet = { name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
		neck = "Lissome Necklace",
		waist = "Grunfeld Rope",
		left_ear = "Brutal Earring",
		right_ear = { name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		left_ring = "Ifrit Ring",
		right_ring = "Rajas Ring",
		back = Camulus.STRWSD
	}

    sets.precast['Requiescat'] = set_combine(sets.precast.WS,{ 
		head = { name="Adhemar Bonnet", augments={'DEX+10','AGI+10','Accuracy+15',}},
		body = "Laksa. Frac +2",
		hands = "Meg. Gloves +2",
		legs = "Meg. Chausses +2",
		feet = { name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
		neck = "Fotia Gorget",
		waist = "Fotia Belt",
		left_ear = "Telos Earring",
		right_ear = { name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		left_ring = "Epona's Ring",
		right_ring = "Apate Ring",
		back = { name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+5','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	})
	
	sets.precast['Wildfire'] = {
		head = { name="Herculean Helm", augments={'Accuracy+1','MND+9','Weapon skill damage +7%','Accuracy+5 Attack+5','Mag. Acc.+9 "Mag.Atk.Bns."+9',}},
		body = { name="Lanun Frac +3", augments={'Enhances "Loaded Deck" effect',}},
		hands = "Meg. Gloves +2",
		legs = { name="Herculean Trousers", augments={'Pet: "Mag.Atk.Bns."+4','DEX+7','Weapon skill damage +6%',}},
		feet = { name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
		neck = "Sanctity Necklace",
		waist = "Eschan Stone",
		left_ear = "Friomisi Earring",
		right_ear = "Hecate's Earring",
		left_ring = "Dingir Ring",
		right_ring = "Garuda Ring",
		back = Camulus.AGIWSD,
}
	
	

    ------------------------------------------------------------------------------------------------
    ----------------------------------------- Idle Sets --------------------------------------------
    ------------------------------------------------------------------------------------------------
    sets.idle = {} -- leave this empty
 	
	
	sets.idle.Regen = set_combine(sets.idle.Regain, {
	
		body = "Meg. Cuirie +2",
		hands = "Meg. Gloves +2",
		neck = "Sanctity Necklace",
		left_ring = "Woltaris Ring",
	
	})
	
	sets.idle.DT = {
		ammo = "Chrono Bullet",
		head = "Meghanada Visor +1",
		body = "Meg. Cuirie +2",
		hands = "Meg. Gloves +2",
		legs = "Meg. Chausses +2",
		feet = "Malignance Boots",
		neck = "Loricate Torque +1",
		waist = "Sailfi Belt +1",
		left_ear = "Odnowa Earring +1",
		right_ear = "Etiolation Earring",
		left_ring = "Epona's Ring",
		right_ring = "Defending Ring",
		back = { name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+5','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	
	}


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Engaged Sets ------------------------------------------
	------------------------------------------------------------------------------------------------
    -- We will switch to these every time we engage and return to them after ever ws while fighting
	
	sets.engaged = {}  -- leave this empty

    sets.engaged.TP = {
		ammo = "Chrono Bullet",
		head = { name="Adhemar Bonnet", augments={'DEX+10','AGI+10','Accuracy+15',}},
		body = "Meg. Cuirie +2",
		hands = { name="Adhemar Wristbands", augments={'DEX+10','AGI+10','Accuracy+15',}},
		legs = "Meg. Chausses +2",
		feet = "Malignance Boots",
		neck = "Iskur Gorget",
		waist = "Sailfi Belt +1",
		left_ear = "Telos Earring",
		right_ear = "Suppanomimi",
		left_ring = "Epona's Ring",
		right_ring = "Petrov Ring",
		back = { name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+5','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
	}
	
	sets.engaged.Hybrid = sets.engaged.TP
	
	sets.engaged.DT = {
		ammo = "Chrono Bullet",
		head = "Meghanada Visor +1",
		body = "Meg. Cuirie +2",
		hands = "Meg. Gloves +2",
		legs = "Meg. Chausses +2",
		feet = "Malignance Boots",
		neck = "Loricate Torque +1",
		waist = "Sailfi Belt +1",
		left_ear = "Odnowa Earring +1",
		right_ear = "Etiolation Earring",
		left_ring = "Epona's Ring",
		right_ring = "Defending Ring",
		back = { name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+5','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
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
		waist = "Chaac Belt",
    
	}
	
	sets.me = {} -- leave this empty
	
	sets.me.movespeed = {legs = "Carmine Cuisses +1",}
end
