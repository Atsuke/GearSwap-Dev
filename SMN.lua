version = "3.0"

--[[
	Big shoutout to Tunaliz https://github.com/Tunaliz for the amazing work he did, especially on the HUD.  
	His code was a fantastic starting point	I fixed some bugs in the existing code,
	added/removed/modified things to suit my needs and then built all of my lua's in a similar style. 
--]]

--[[
        Custom commands:
        Shorthand versions for each strategem type that uses the version appropriate for the current Arts.
        
		Commands for /sch because you should be /sch:
										Light Arts              Dark Arts
        gs c scholar light              Light Arts/Addendum
        gs c scholar dark                                       Dark Arts/Addendum
        gs c scholar cost               Penury                  Parsimony
        gs c scholar speed              Celerity                Alacrity
        gs c scholar aoe                Accession               Manifestation
        gs c scholar addendum           Addendum: White         Addendum: Black
    
        Toggle Function: 
        gs c toggle melee               Toggle Melee mode on / off and locking of weapons
        gs c toggle mb                  Toggles Magic Burst Mode on / off.
        gs c toggle runspeed            Toggles locking on / off Herald's Gaiters
        gs c toggle idlemode            Toggles between Refresh and DT idle mode. Activating Sublimation JA will auto replace refresh set for sublimation set. DT set will superceed both. 
		gs c toggle petmode				Toggles pet modes 		
        gs c toggle regenmode           Toggles between Hybrid, Duration and Potency mode for regen set  
        gs c toggle nukemode            Toggles between Normal and Accuracy mode for midcast Nuking sets (MB included)  
        gs c toggle matchsc             Toggles auto swapping element to match the last SC that just happenned.
		gs c toggle thMode            	Toggle Treasure Hunter Mode on or off
		gs c toggle autoconvert			Toggles autoconvert modes
                
        
        Nuke Functions:
        gs c nuke cycle                 Cycles element type for nuking & SC
        gs c nuke cycledown             Cycles element type for nuking & SC in reverse order    
        gs c nuke t1                    Cast tier 1 nuke of saved element 
        gs c nuke t2                    Cast tier 2 nuke of saved element 
       
        gs c nuke helix                 Cast helix nuke of saved element 
        gs c nuke storm                 Cast Storm buff of saved element  
		
		gs c summoner summon			Calls the selected avatar
		gs c summoner siphon			Starts elemental siphon process
		gs c summoner rage				Uses the currently selected rage
		gs c summoner ward				Uses the currently selected ward
		gs c summoner cycle             cycle through available avatars
		gs c summoner cycledown         cycle through available avatars
		gs c summoner cyclerage         cycle through avaialable rage bp's
		gs c summoner cycleragedown     cycle through avaialable rage bp's
        gs c summoner cycleward         cycle through avaialable ward bp's
        gs c summoner cyclewarddown     cycle through avaialable ward bp's

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
hud_y_pos = 50     --important to update these if you have a smaller screen
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


-- Optional. Swap to your smn macro sheet / book
set_macros(2,13) -- Sheet, Book   
--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
-- Define your modes: 
-- You can add or remove modes in the table below, they will get picked up in the cycle automatically. 
-- to define sets for idle if you add more modes, name them: sets.me.idle.mymode and add 'mymode' in the group.
-- to define sets for regen if you add more modes, name them: sets.midcast.regen.mymode and add 'mymode' in the group.
-- Same idea for nuke modes. 
idleModes = M('Refresh','DT', 'Pet')
meleeModes = M('TP', 'DT', 'Trust')
petModes = M('TP', 'DT')
bpModes = M('Normal', 'AUTO')
convertModes = M('OFF', 'AUTO')
treasureHunter = M('OFF', 'ON')

-- To add a new mode to nuking, you need to define both sets: sets.midcast.nuking.mynewmode as well as sets.midcast.MB.mynewmode
nukeModes = M('normal', 'acc')

-- Setup your Key Bindings here:
    windower.send_command('bind insert gs c nuke cycle')				-- Insert Cycles Nuke element
    windower.send_command('bind !insert gs c nuke cycledown')			-- ALT+Insert Cycles Nuke element in reverse order 
    windower.send_command('bind f9 gs c toggle idlemode')				-- F9 to change Idle Mode    
    windower.send_command('bind !f9 gs c toggle runspeed')				-- Alt+F9 toggles locking on / off Herald's Gaiters
    windower.send_command('bind f12 gs c toggle melee')					-- F12 Toggle Melee mode on / off and locking of weapons
    windower.send_command('bind delete gs c summoner cycle')			-- Cycle through available avatars
    windower.send_command('bind !delete gs c summoner cycledown')		-- Cycle through available avatars
	windower.send_command('bind end gs c summoner cycleward')			-- Change the currently selected bp ward
	windower.send_command('bind !end gs c summoner cyclewarddown')		-- Change the currently selected bp ward
	windower.send_command('bind home gs c summoner cyclerage')			-- HOME to toggle rage bp's
    windower.send_command('bind !home gs c summoner cycleragedown')		-- ALT+HOME to toggle rage bp's
	windower.send_command('bind f10 gs c toggle meleemode')				-- F10 to change Melee Mode
    windower.send_command('bind f11 gs c toggle petmode')				-- F11 to change Pet Mode          	   
    windower.send_command('bind ^end gs c hud keybinds')				-- CTRL-End to toggle Keybinds
	windower.send_command('bind PAGEUP gs c summoner autobp')			-- PAGEUP to toggle bp Mode
	windower.send_command('bind PAGEDOWN gs c toggle autoconvert')		-- PAGEDOWN to toggle Convert Mode
	windower.send_command('bind !t gs c toggle thMode')					-- ALT+T to toggle Treasure Hunter Mode
	

--[[
    This gets passed in when the Keybinds is turned on.
    Each one matches to a given variable within the text object
    IF you changed the Default Keybind above, Edit the ones below so it can be reflected in the hud using "//gs c hud keybinds" command
]]
keybinds_on = {}
keybinds_on['key_bind_idle'] = '(F9)'
keybinds_on['key_bind_element_cycle'] = '(INSERT)'
keybinds_on['key_bind_rage_cycle'] = '(HOME)'
keybinds_on['key_bind_ward_cycle'] = '(END)'
keybinds_on['key_bind_avatar'] = '(Delete)'
keybinds_on['key_bind_lock_weapon'] = '(F12)'
keybinds_on['key_bind_movespeed_lock'] = '(ALT-F9)'
keybinds_on['key_bind_melee'] = '(F10) '
keybinds_on['key_bind_petModes'] = '(F11)'
keybinds_on['key_bind_bpMode'] = '(PgUp)'
keybinds_on['key_bind_convert_mode'] = '(PgDwn)'
keybinds_on['key_bind_treasure_hunter'] = '(ALT-T)'

-- Remember to unbind your keybinds on job change.
function user_unload()
    send_command('unbind insert')
	send_command('unbind !insert')
    send_command('unbind delete')
	send_command('unbind !delete')
    send_command('unbind f9')
    send_command('unbind !f9')
	send_command('unbind f10')
	send_command('unbind f11')
    send_command('unbind f12')
    send_command('unbind home')
    send_command('unbind !home')
	send_command('unbind end')
    send_command('unbind !end')
	send_command('unbind !f10')	
    send_command('unbind `f10')
	send_command('unbind PAGEUP')
	send_command('unbind PAGEDOWN')
	send_command('unbind !t')
   	      	
end

-- Default Blood Pacts
-- Set the pacts that you want to set your rage and ward commands to on initial summoning of an avatar. 
-- NOTE: Take care with spelling or it wont work.
defaultbps = {}
defaultbps.Carbuncle = {['Rage'] = "Meteorite", ['Ward'] = "Healing Ruby II"}
defaultbps.Fenrir = {['Rage'] = "Impact", ['Ward'] = "Lunar Roar"}
defaultbps.Ifrit = {['Rage'] = "Flaming Crush", ['Ward'] = "Crimson Howl"}
defaultbps.Titan = {['Rage'] = "Crag Throw", ['Ward'] = "Earthen Armor"}
defaultbps.Leviathan = {['Rage'] = "Grand Fall", ['Ward'] = "Spring Water"}
defaultbps.Garuda = {['Rage'] = "Predator Claws", ['Ward'] = "Hastega II"}
defaultbps.Shiva = {['Rage'] = "Heavenly Strike", ['Ward'] = "Crystal Blessing"}
defaultbps.Ramuh = {['Rage'] = "Volt Strike", ['Ward'] = "Shock Squall"}
defaultbps.Diabolos = {['Rage'] = "Blindside", ['Ward'] = "Noctoshield"}
defaultbps["Cait Sith"] = {['Rage'] = "Regal Gash", ['Ward'] = "Mewing Lullaby"}
defaultbps.Siren = {['Rage'] = "Hysteric Assault", ['Ward'] = "Wind's Blessing"}
--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
include('libs/SMN_Lib.lua')     -- leave this as is    
refreshType = idleModes[1]      -- leave this as is     
--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------

-- Actions you want to be able to 'tag' treasure hunter with when TH mode is set to ON.
TH_Actions = S{'Stone', 'Aero', 'Fire', 'Water', 'Blizzard', 'Thunder', 'Dia', 'Dia II', 'Diaga'}
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
    -- All sets that are equipped to faciliate my avatar's behaviour or abilities are under 'avatar', eg, Perpetuation, Blood Pacts, etc
      
    sets.me = {}        		-- leave this empty
    sets.buff = {} 				-- leave this empty
    sets.me.Idle = {}			-- leave this empty
	sets.avatar = {} 			-- leave this empty
    sets.avatar.Idle = {}		-- leave this empty
    
	-- Optional 
	include('Atsuke_AugGear.lua') -- I list all my Augmented gears in a sidecar file since it's shared across many jobs. 

	 
    -- JSE
    AF = {}         -- leave this empty
    RELIC = {}      -- leave this empty
    EMPY = {}       -- leave this empty


    -- Fill this with your own JSE. 
    --Convokers
    AF.Head     =   "Convoker's Horn +3"
    AF.Body     =   "Con. Doublet +3"
    AF.Hands    =   "Convoker's Bracers +3"
    AF.Legs     =  	"Convo. Spats +2"
    AF.Feet     =   "Convo. Pigaches +3"

    --Glyphic
    RELIC.Head  =   "Glyphic Horn +3"
    RELIC.Body  =   "Glyphic Doublet +3"
    RELIC.Hands =   "Glyphic Bracers +3"
    RELIC.Legs  =   "Glyphic Spats +3"
    RELIC.Feet  =   "Glyph. Pigaches +3"

    --Beckoners
    EMPY.Head   =   "Beckoner's Horn +1"
    EMPY.Body   =   "Beck. Doublet +1"
    EMPY.Hands  =   "Beck. Bracers +1"
    EMPY.Legs   =   "Beck. Spats +1"
    EMPY.Feet   =   "Beck. Pigaches +1"



    -- Define JSE Capes
    SMNCape = {}
    SMNCape.PETMAB   =   { name="Campestres's Cape", augments={'Pet: M.Acc.+20 Pet: M.Dmg.+20','Pet: Magic Damage+10','"Cure" potency +10%','Phys. dmg. taken-10%',}}
    SMNCape.Physical =   { name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Pet: Attack+10 Pet: Rng.Atk.+10','Pet: Haste+10','Pet: Damage taken -5%',}}
	SMNCape.PetPDT   =   { name="Campestres's Cape", augments={'Pet: "Regen"+10','System: 1 ID: 1246 Val: 4',}}
	SMNCape.MAB      =   { name="Campestres's Cape", augments={'Pet: M.Acc.+20 Pet: M.Dmg.+20','Pet: Magic Damage+10','"Fast Cast"+10','Phys. dmg. taken-10%',}}

	------------------------------------------------------------------------------------------------
	----------------------------------------- Idle Sets --------------------------------------------
	------------------------------------------------------------------------------------------------

    -- Your idle set
    sets.me.Refresh = {
		main = "Nirvana",
		sub = "Elan Strap +1",
		ammo = "Sancus Sachet +1",
		head = AF.Head,
		body = Apo.Body.A,
		hands = { name="Asteria Mitts +1", augments={'Path: A',}},
		legs = { name="Assid. Pants +1", augments={'Path: A',}},
		feet = "Volte Gaiters",
		neck = "Sibyl Scarf",
		waist = "Lucidity Sash",
		left_ear = "C. Palug Earring",
		right_ear = { name="Moonshade Earring", augments={'Accuracy+4','Latent effect: "Refresh"+1',}},
		left_ring = "Defending Ring",
		right_ring = "Woltaris Ring",
		back = SMNCape.PETMAB,
		
    }
	
	sets.me.Pet = set_combine(sets.me.Refresh, {
		neck = "Caller's Pendant",
		back = SMNCape.PetPDT, 
		
	})

    -- Your idle Sublimation set combine from refresh or DT depening on mode.
    sets.me.sublimation = set_combine(sets.me.Refresh,{
    	
		waist = "Embla Sash",
		left_ring = "Woltaris Ring",
    })   
    -- Your idle DT set
    sets.me.DT = set_combine(sets.me.Idle[refreshType],{ --sets.me.DT
        main = "Malignance Pole", -- 20
		sub = "Kaja Grip", --5
		legs = "Nyame Flanchard", --8
		feet = "Nyame Sollerets", --7
		neck = { name="Smn. Collar +2", augments={'Path: A',}}, --5
		
    })  
    sets.me.Idle.mdt = set_combine(sets.me.Idle.DT,{
        
    })  
	-- Your MP Recovered Whilst Resting Set
    sets.me.resting = { 
		
    }
    
    sets.me.latent_refresh = {waist="Fucho-no-obi"}     

	------------------------------------------------------------------------------------------------
	----------------------------------------- Engaged Sets -----------------------------------------
	------------------------------------------------------------------------------------------------
   
	-- Combat Related Sets
    sets.me.Engaged = {
		main = "Nirvana",
		sub = "Kaja Grip",
		ammo = "Sancus Sachet +1",
		head = AF.Head,
		body = AF.Body,
		hands = AF.Hands,
		legs = AF.Feet,
		feet = RELIC.Feet,
		neck = { name="Smn. Collar +2", augments={'Path: A',}},
		waist = "Grunfeld Rope",
		left_ear = "C. Palug Earring",
		right_ear = "Telos Earring",
		left_ring = "Cacoethic Ring",
		right_ring = "Defending Ring",
		back = SMNCape.PETMAB,
    }
     
	sets.me.Engaged.refresh = sets.me.Idle.refresh
	sets.me.Engaged.DT = sets.me.Engaged
	sets.me.Engaged["Master+Pet"] = sets.me.Engaged
    -- Weapon Skills sets just add them by name.

  
	--------------------------------------------------------------------------------------------------------------
	------------------------------------------------ Buff Sets ---------------------------------------------------
	--------------------------------------------------------------------------------------------------------------
	sets.buff ={}
	
	sets.buff.Doom = {
		neck = "Nicander's Necklace",
		left_ring = "Blenmot's Ring",
		waist = "Gishdubar Sash",
	}
   
	
	--------------------------------------------------------------------------------------------------------------
	----------------------------------------------- Pre Cast -----------------------------------------------------
	--------------------------------------------------------------------------------------------------------------

    sets.precast = {}   		-- Leave this empty  
    sets.midcast = {}    		-- Leave this empty  
    sets.aftercast = {}  		-- Leave this empty  
	sets.midcast.nuking = {}	-- leave this empty
	sets.midcast.MB	= {}		-- leave this empty      
      
    -- Generic Casting Set that all others take off of. Here you should add all your fast cast 
    
    sets.precast.casting = {
		main = "Nirvana",
		ammo = "Sancus Sachet +1",
		head = Merl.Head.FC,
		body = "Zendik Robe",
		hands = "Volte Gloves",
		legs = Psycloth.Legs.FC,
		feet = Merl.Feet.Th,
		neck = "Voltsurge Torque",
		waist = "Witful Belt",
		left_ear = "Malignance Earring",
		right_ear = "Loquac. Earring",
		left_ring = "Prolix Ring",
		right_ring = "Kishar Ring",
		back = { name="Fi Follet Cape +1", augments={'Path: A',}},
    }

	sets.precast.summoning = set_combine(sets.precast.casting,{
	
		body = "Baayami Robe",
	
	})
	
	sets.precast.bp= {
		main = "Nirvana",
		sub ="Elan Strap +1",
		ammo = "Sancus Sachet +1",
		head = EMPY.Head,
		body = RELIC.Body,
		hands = RELIC.Hands,
		legs = RELIC.Legs,
		feet = RELIC.Feet,
		neck = { name="Smn. Collar +2", augments={'Path: A',}},
		waist = "Regal Belt",
		left_ear = "C. Palug Earring",
		right_ear = "Lodurr Earring",
		left_ring = "Fervor Ring",
		right_ring = "Evoker's Ring",
		back = { name="Conveyance Cape", augments={'Summoning magic skill +1','Pet: Enmity+11','Blood Pact Dmg.+4',}},
	}	

	sets.precast["Stun"] = {
		
	}
	
    -- Enhancing Magic, eg. Siegal Sash, etc
    sets.precast.enhancing = set_combine(sets.precast.casting,{
		waist = "Siegel Sash",
        
    })
  
    -- Stoneskin casting time -, works off of enhancing -
    sets.precast.stoneskin = set_combine(sets.precast.enhancing,{
		waist = "Siegel Sash",
		legs = "Doyen Pants",
    })
      
    -- Curing Precast, Cure Spell Casting time -
    sets.precast.cure = set_combine(sets.precast.casting,{
		legs = "Doyen Pants",	
		feet = Vanya.Feet.D,
    })
      
   
	
	--------------------------------------------------------------------------------------------------------------
	----------------------------------------------- Mid Cast -----------------------------------------------------
	--------------------------------------------------------------------------------------------------------------

	-----------------------------------------------------------------------------------------------
	-- Helix sets automatically derives from casting sets. SO DONT PUT ANYTHING IN THEM other than:
	-- Pixie in DarkHelix
	-- Boots that aren't arbatel +1 (15% of small numbers meh, amalric+1 does more)
	-- Belt that isn't Obi.
	-----------------------------------------------------------------------------------------------
    -- Make sure you have a non weather obi in this set. Helix get bonus naturally no need Obi.	
    sets.midcast.DarkHelix = sets.midcast["Helix"]
    -- Make sure you have a non weather obi in this set. Helix get bonus naturally no need Obi.	
    sets.midcast.Helix = {
		
		main = "Daybreak",
		sub = "Culminus",
		ammo = "Sancus Sachet +1",
		head = Merl.Head.FC,
		body = Merl.Body.MAB,
		hands = Merl.Hands.MAB,
		legs = Merl.Legs.MAB,
		feet = Merl.Feet.TH,
		neck = "Sanctity Necklace",
		waist = "Eschan Stone",
		left_ear = "Malignance Earring",
		right_ear = "Friomisi Earring",
		left_ring = "Persis Ring",
		right_ring = "Kishar Ring",
    }	

    -- Whatever you want to equip mid-cast as a catch all for all spells, and we'll overwrite later for individual spells
    sets.midcast.casting = {
		
    }

	sets.midcast["Sublimation"] = {}
    
    sets.midcast.nuking.normal = {
		main = "Daybreak",
		sub = "Ammurapi Shield",
		ammo = "Sancus Sachet +1",
		head = Merl.Head.FC,
		body = Merl.Body.MAB,
		hands = Merl.Hands.MAB,
		legs = Merl.Legs.MAB,
		feet = Merl.Feet.TH,
		neck = "Sanctity Necklace",
		waist = "Eschan Stone",
		left_ear = "Malignance Earring",
		right_ear = "Friomisi Earring",
		left_ring = "Persis Ring",
		right_ring = "Kishar Ring",
		
    }
    -- used with toggle, default: F10
    -- Pieces to swap from freen nuke to Magic Burst
    sets.midcast.MB.normal = {}
	
    sets.midcast.nuking.acc = {}
	
    -- used with toggle, default: F10
    -- Pieces to swap from freen nuke to Magic Burst
    sets.midcast.MB.acc = set_combine(sets.midcast.nuking.normal, {
	   
    })	
	
    -- Enfeebling
	sets.midcast["Stun"] = {
		
	}	
    sets.midcast.IntEnfeebling =  sets.midcast.nuking.normal
    sets.midcast.MndEnfeebling =  sets.midcast.nuking.normal
	
    -- Enhancing
    sets.midcast.enhancing = set_combine(sets.midcast.casting,{
		main = { name="Gada", augments={'Enh. Mag. eff. dur. +5','VIT+5','"Mag.Atk.Bns."+6',}},
		sub = "Ammurapi Shield",
		ammo = "Sapience Orb",
		head = Telchine.Head.en,
		--body = RELIC.Body,
		--hands = EMPY.hands,
		legs = Telchine.Legs.en,
		feet = Telchine.Feet.en,
		neck = "Incanter's Torque",
		waist = "Embla Sash",
		left_ear = "Mimir Earring",
		right_ear = "Andoaa Earring",
		left_ring = "Prolix Ring",
		right_ring = "Kishar Ring",
		back = { name="Fi Follet Cape +1", augments={'Path: A',}},
    })
    sets.midcast.storm = sets.midcast.enhancing    
    
	-- Stoneskin
    sets.midcast.stoneskin = set_combine(sets.midcast.enhancing,{
		neck = "Nodens Gorget",
		waist = "Siegel Sash",
		left_ear = "Earthcry Earring",
    })
	
    sets.midcast.refresh = sets.midcast.enhancing
    sets.midcast.aquaveil = sets.midcast.refresh
	
    sets.midcast["Drain"] = set_combine(sets.midcast.nuking, {
        --head="Pixie Hairpin +1",
		
		feet = Merl.Feet.Th,
		neck = "Erra Pendant",
		waist = "Fucho-no-Obi",
    })
	
    sets.midcast["Aspir"] = sets.midcast["Drain"]
 	
 	sets.midcast.cure = {} -- Leave This Empty
    
	-- Cure Potency
    sets.midcast.cure.normal = set_combine(sets.midcast.casting,{
		head = Vanya.Head.A,
		body = "Nyame Mail",
		hands = "Nyame Gauntlets",
		legs = "Nyame Flanchard",
		feet = Vanya.Feet.D,
		neck = "Phalaina Locket",
		waist = "Porous Rope",
		left_ear = "Mendi. Earring",
		right_ear = "Roundel Earring",
		left_ring = "Persis Ring",
		right_ring = "Defending Ring",
		back = SMNCape.PETMAB
    })
    
	sets.midcast.cure.weather = set_combine(sets.midcast.cure.normal,{
		main = "Chatoyant Staff",
		waist = "Hachirin-no-Obi",
    })    
	
	sets.midcast["Elemental Siphon"]={
		main = "Chatoyant Staff",
		sub = "Elan Strap +1",
		ammo = "Sancus Sachet +1",
		head = AF.Head,
		body = "Baayami Robe",
		hands = RELIC.Hands,
		legs = EMPY.Legs,
		feet = EMPY.Feet,
		neck = "Incanter's Torque",
		waist = "Hachirin-no-Obi",
		left_ear = "C. Palug Earring",
		right_ear = "Lodurr Earring",
		left_ring = "Zodiac Ring",
		right_ring = "Evoker's Ring",
		back = "Twilight Cape",
	}
	
	------------------------------------------------------------------------------------------------
	--------------------------------------- WeaponSkill Sets ---------------------------------------
	------------------------------------------------------------------------------------------------
 
    sets.precast["Shattersoul"] = {
		
		ammo = "Sancus Sachet +1",
		head = "Nyame Helm",
		body = "Nyame Mail",
		hands = "Nyame Gauntlets",
		legs = "Nyame Flanchard",
		feet = "Nyame Sollerets",
		neck = "Fotia Gorget",
		waist = "Fotia Belt",
		left_ear = "Malignance Earring",
		right_ear = "Ishvara Earring",
		left_ring = "Spiral Ring",
		right_ring = "Persis Ring",
		back = { name="Conveyance Cape", augments={'Summoning magic skill +1','Pet: Enmity+11','Blood Pact Dmg.+4',}},
		
    }
	
    sets.precast["Myrkr"] = {
		ammo = "Ghastly Tathlum +1",
		head = RELIC.head,
		body = AF.Body,
		hands = RELIC.hands,
		legs = RELIC.Legs,
		feet = EMPY.Feet,
		neck = "Sanctity Necklace",
		waist = "Fucho-no-Obi",
		left_ear = "Evans Earring",
		right_ear = "Etiolation Earring",
		left_ring = "Persis Ring",
		right_ring = "Zodiac Ring",
		back = "Fi Follet Cape +1",
    }
    
		  
    -- Feel free to add new weapon skills, make sure you spell it the same as in game. These are the only two I ever use though
	
	
	--------------------------------------------------------------------------------------------------------------
	---------------------------------------------- Avatar Sets ---------------------------------------------------
	--------------------------------------------------------------------------------------------------------------
	
	sets.avatar = {}
		
	-- Pet out but not doing anything
	sets.avatar.perp = { 
		main = "Nirvana",
		sub = "Kaja Grip",
		ammo = "Sancus Sachet +1",
		head = EMPY. Head,
		body = Apo.Body.A,
		hands = "Asteria Mitts +1",
		legs = Apo.Legs.A,
		feet = Apo.Feet.A,
		neck = { name="Smn. Collar +2", augments={'Path: A',}},
		waist ="Incarnation Sash",
		left_ear = "C. Palug Earring",
		right_ear = { name="Moonshade Earring", augments={'Accuracy+4','Latent effect: "Refresh"+1',}},
		left_ring = "C. Palug Ring",
		right_ring = "Woltaris Ring",
		back = SMNCape.PetPDT
	}
	
	-- Have pet and it is doing all the work.  Note the capitalization of Idle and Engaged.  This is important as we are calling player and pet state.
	sets.avatar.TP = { -- sets.avatar.TP
		main = "Nirvana",
		sub = "Kaja Grip",
		ammo = "Sancus Sachet +1",
		head = AF.Head,
		body = RELIC.Body,
		hands = AF.Hands,
		legs = { name="Assid. Pants +1", augments={'Path: A',}},
		feet = RELIC.Feet,
		neck = { name="Smn. Collar +2", augments={'Path: A',}},
		waist = "Incarnation Sash",
		left_ear = "C. Palug Earring",
		right_ear ="Enmerkar Earring", 
		left_ring = "C. Palug Ring",
		right_ring = "Varar Ring +1",
		back = SMNCape.Physical,
	}
		
	sets.avatar.DT = {
		head = Apo.Head.D, --4
		body = Telchine.Body.PetDT, --4
		hands = Telchine.Hands.PetDT, --4
		legs = Telchine.Legs.PetDT, --4
		feet = Telchine.Feet.PetDT, --4
		waist = "Isa Belt", --3
		left_ear = "Handler's Earring", --3
		right_ear = "Handler's Earring +1", --4
		back = SMNCape.PetPDT --5
	}
	

	--------------------------------------------------------------------------------------------------------------
	--------------------------------------------- Hybrid Sets ----------------------------------------------------
	--------------------------------------------------------------------------------------------------------------
	sets.MasterPet = {} -- Leave this empty
	
	sets.MasterPet.TP = {
	
		main = "Nirvana",
		sub = "Kaja Grip",
		ammo = "Sancus Sachet +1",
		head = AF.Head,
		body = AF.Body,
		hands = AF.Hands,
		legs = AF.Legs,
		feet = AF.Feet,
		neck = "Shulmanu Collar",
		waist = "Eschan Stone",
		left_ear = "C. Palug Earring",
		right_ear = "Telos Earring",
		left_ring = "C. Palug Ring",
		right_ring = "Hetairoi Ring",
		back = SMNCape.PetPDT,
	}
	

	--------------------------------------------------------------------------------------------------------------
	----------------------------------------------- Blood Pacts --------------------------------------------------
	--------------------------------------------------------------------------------------------------------------

	sets.avatar.atk = {
		main = "Nirvana",
		sub = "Elan Strap +1",
		ammo = "Sancus Sachet +1",
		head =  Helios.Head.BPDmg,
		body = RELIC.Body,
		hands = Merl.Hands.BPDmg,
		legs = Apo.Legs.D,
		feet = Apo.Feet.A,
		neck = { name="Smn. Collar +2", augments={'Path: A',}},
		waist = "Incarnation Sash",
		left_ear = "Gelos Earring",
		right_ear = "Domes. Earring",
		left_ring = "C. Palug Ring",
		right_ring = "Varar Ring +1",
		back = SMNCape.Physical
	}
	
	
	sets.avatar.mab = {
		main = { name="Grioavolr", augments={'Blood Pact Dmg.+5','Pet: INT+12','Pet: "Mag.Atk.Bns."+25',}},
		sub = "Elan Strap +1",
		ammo = "Sancus Sachet +1",
		head = RELIC.Head,
		body = Apo.Body.A,
		hands = Merl.Hands.BPDmg,
		legs = Apo.Legs.A,
		feet = Apo.Feet.A,
		neck = { name="Smn. Collar +2", augments={'Path: A',}},
		waist = "Regal Belt",
		left_ear = "Gelos Earring",
		right_ear = "Enmerkar Earring",
		left_ring = "Varar Ring +1",
		right_ring = "Varar Ring +1",
		back = SMNCape.MAB,
	}
	
	
	sets.avatar.hybrid = {
		main = "Nirvana",
		sub = "Elan Strap +1",
		ammo = "Sancus Sachet +1",
		head = RELIC.Head,
		body = Apo.Body.A,
		hands = Merl.Hands.BPDmg,
		legs = Apo.Legs.A,
		feet = Apo.Feet.A,
		neck = { name="Smn. Collar +2", augments={'Path: A',}},
		waist = "Regal Belt",
		left_ear = "Gelos Earring",
		right_ear = "Domes. Earring",
		left_ring = "Varar Ring +1",
		right_ring = "Varar Ring +1",
		back = SMNCape.PETMAB,
	}
	
	
	sets.avatar.macc = {
		main = "Nirvana",
		sub = "Elan Strap +1",
		ammo = "Sancus Sachet +1",
		head = AF.Head,
		body = AF.Body,
		hands = "Lamassu Mitts +1",
		legs = AF.Legs,
		feet = "Baayami Sabots",
		neck = { name="Smn. Collar +2", augments={'Path: A',}},
		waist = "Regal Belt",
		left_ear =  "C. Palug Earring",
		right_ear ="Enmerkar Earring",
		left_ring = "Fervor Ring",
		right_ring = "Evoker's Ring",
		back = { name="Conveyance Cape", augments={'Summoning magic skill +1','Pet: Enmity+11','Blood Pact Dmg.+4',}},
	}
	
	sets.avatar.skill = {
		sub = "Elan Strap +1",
		ammo = "Sancus Sachet +1",
		head = AF.Head,
		body = "Baayami Robe",
		hands = RELIC.Hands,
		legs = EMPY.Legs,
		feet = "Baayami Sabots",
		neck = "Incanter's Torque",
		waist = "Kobo Obi",
		left_ear =  "C. Palug Earring",
		right_ear = "Lodurr Earring",
		left_ring = "Fervor Ring",
		right_ring = "Evoker's Ring",
		back = { name="Conveyance Cape", augments={'Summoning magic skill +1','Pet: Enmity+11','Blood Pact Dmg.+4',}},
	}	
	
	sets.avatar.MB = set_combine(sets.avatar.mab, {
	
		hands = { name="Asteria Mitts +1", augments={'Path: A',}},
	})
	
	sets.avatar.buff = sets.avatar.skill
	
	
	--------------------------------------------------------------------------------------------------------------
	-------------------------------------------------- Misc. -----------------------------------------------------
	--------------------------------------------------------------------------------------------------------------
 
	sets.midcast.regen = {} 	-- leave this empty
	-- Normal hybrid well rounded Regen
    sets.midcast.regen.hybrid = {
		main = "Bolelabunga",
		sub = "Ammurapi Shield",
		ammo = "Incantor Stone",
		head = Telchine.Head.en,
		--body = RELIC.Body,
		--hands = EMPY.hands,
		legs = Telchine.Legs.en,
		feet = Telchine.Feet.en,
		neck = "Incanter's Torque",
		waist = "Embla Sash",
		left_ear = "Loquac. Earring",
		right_ear = "Malignance Earring",
		left_ring = "Prolix Ring",
		right_ring = "Kishar Ring",
		
    }
	-- Focus on Regen Duration 	
    sets.midcast.regen.duration = set_combine(sets.midcast.regen.hybrid,{
		
    }) 
	-- Focus on Regen Potency 	
    sets.midcast.regen.potency = set_combine(sets.midcast.regen.hybrid,{

    }) 
  
	-- Movespeedset
    sets.me.movespeed = {feet="Herald's Gaiters",}
	
	-- For running faster in Adoulin
	sets.adoulin = {body = "Councilor's Garb",}
	
	-- Because Treasure Hunter totally works just keep lying to yourself.
	sets.TH = {
		head = "Wh. Rarab Cap +1",
		feet = Merl.Feet.Th,
		waist = "Chaac Belt",
	}
    ------------
    -- Aftercast
    ------------
      
    -- I don't use aftercast sets, as we handle what to equip later depending on conditions using a function.
	
end
