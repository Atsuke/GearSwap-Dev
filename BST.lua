version = "3.0"

--[[
	Big shoutout to Tunaliz https://github.com/Tunaliz for the amazing work he did, especially on the HUD.  
	His code was a fantastic starting point	I fixed some bugs in the existing code,
	added/removed/modified things to suit my needs and then built all of my lua's in a similar style. 
--]]

--[[
        Custom commands:
        Shorthand versions for each strategem type that uses the version appropriate for the current Arts.
    
        Toggle Function: 
        gs c toggle melee               Toggle Melee mode on / off and locking of weapons
        gs c toggle mb                  Toggles Magic Burst Mode on / off.
        gs c toggle runspeed            Toggles locking on / off Herald's Gaiters
        gs c toggle idlemode            Toggles between Refresh and DT idle mode. Activating Sublimation JA will auto replace refresh set for sublimation set. DT set will superceed both.        
        gs c toggle petmode				Toggles pet modes 
        gs c toggle nukemode            Toggles between Normal and Accuracy mode for midcast Nuking sets (MB included)  
        gs c toggle matchsc             Toggles auto swapping element to match the last SC that just happenned.
		gs c toggle thMode            	Toggle Treasure Hunter Mode on or off
		gs c toggle enmity				Toggle enmity modes
		gs c toggle autoconvert			Toggles autoconvert modes
                
        
        Nuke Functions:
        gs c nuke cycle                 Cycles element type for nuking & SC
        gs c nuke cycledown             Cycles element type for nuking & SC in reverse order    
        gs c nuke t1                    Cast tier 1 nuke of saved element 
        gs c nuke t2                    Cast tier 2 nuke of saved element
		
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
no_swap_gear = S{"Warp Ring", "Dim. Ring (Dem)", "Dim. Ring (Holla)", "Dim. Ring (Mea)",
              "Trizek Ring", "Echad Ring", "Facility Ring", "Capacity Ring"}

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

-- Set the tools you would like to track while tool tracker is set to on. 
-- Tools can be in inventory or wardrobe.  
-- Set value to empty string if you dont want to track a tool.  Ex. tool_4 = ''

tool_1 = "Pet Food Theta"
tool_2 = ""
tool_3 = ""
tool_4 = ""

-- Set these values for the text displayed in the hud
tools_on = {}
tools_on['tool_1'] = 'Pet Food Theta: '
tools_on['tool_2'] = ""
tools_on['tool_3'] = ""
tools_on['tool_4'] = ""

-- set level for low tool warning
tool_warning = 20


-- Optional. Swap to your bst macro sheet / book
set_macros(2,27) -- Sheet, Book   
--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
-- Define your modes: 
-- You can add or remove modes in the table below, they will get picked up in the cycle automatically. 
-- to define sets for idle if you add more modes, name them: sets.me.idle.mymode and add 'mymode' in the group.
-- to define sets for regen if you add more modes, name them: sets.midcast.regen.mymode and add 'mymode' in the group.
-- Same idea for nuke modes. 
idleModes = M('Regen','DT', 'Pet', 'Regain')
meleeModes = M('TP', 'DT', 'Pet', 'Master + Pet')
petModes = M('TP', 'DT', 'Regen')
convertModes = M('OFF', 'AUTO')
treasureHunter = M('OFF', 'ON')
enmityModes = M('Normal', 'Enmity')

-- Setup your Key Bindings here:
    windower.send_command('bind insert gs c nuke cycle')				-- Insert Cycles Nuke element
    windower.send_command('bind !insert gs c nuke cycledown')			-- ALT+Insert Cycles Nuke element in reverse order 
    windower.send_command('bind f9 gs c toggle idlemode')				-- F9 to change Idle Mode    
    windower.send_command('bind !f9 gs c toggle runspeed')				-- Alt+F9 toggles locking on / off Herald's Gaiters
    windower.send_command('bind f12 gs c toggle melee')					-- F12 Toggle Melee mode on / off and locking of weapons
	windower.send_command('bind f10 gs c toggle meleemode')				-- F10 to change Melee Mode
    windower.send_command('bind f11 gs c toggle petmode')				-- F11 to change Pet Mode          	   
    windower.send_command('bind ^end gs c hud keybinds')				-- CTRL-End to toggle Keybinds
	windower.send_command('bind PAGEDOWN gs c toggle autoconvert')		-- PAGEDOWN to toggle Convert Mode
	windower.send_command('bind !t gs c toggle thMode')					-- ALT+T to toggle Treasure Hunter Mode
	windower.send_command('bind delete gs c toggle enmity')				-- DELETE to toggle enmity Mode
	

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
keybinds_on['key_bind_pet'] = '(Delete)'
keybinds_on['key_bind_lock_weapon'] = '(F12)'
keybinds_on['key_bind_movespeed_lock'] = '(ALT-F9)'
keybinds_on['key_bind_melee'] = '(F10) '
keybinds_on['key_bind_petModes'] = '(F11)'
keybinds_on['key_bind_convert_mode'] = '(PgDwn)'
keybinds_on['key_bind_treasure_hunter'] = '(ALT-T)'
keybinds_on['key_bind_enmity'] = '(DELETE) '

-- Remember to unbind your keybinds on job change.
function user_unload()
    send_command('unbind insert')
	send_command('unbind !insert')
    send_command('unbind f9')
    send_command('unbind !f9')
	send_command('unbind f10')
	send_command('unbind f11')
    send_command('unbind f12')
	send_command('unbind !f10')	
    send_command('unbind `f10')
	send_command('unbind `delete')
	send_command('unbind PAGEDOWN')
	send_command('unbind !t')
   	      	
end

--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
include('libs/BST_Lib.lua')     -- leave this as is    
refreshType = idleModes[1]      -- leave this as is     
--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------

-- Actions you want to be able to 'tag' treasure hunter with when TH mode is set to ON.
TH_Actions = S{'Stone', 'Aero', 'Fire', 'Water', 'Blizzard', 'Thunder', 'Dia', 'Dia II', 'Diaga'}

--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
--						 ____                _         __  __                     
--						|  _ \ ___  __ _  __| |_   _  |  \/  | _____   _____  ___ 
--						| |_) / _ \/ _` |/ _` | | | | | |\/| |/ _ \ \ / / _ \/ __|
--						|  _ <  __/ (_| | (_| | |_| | | |  | | (_) \ V /  __/\__ \
--						|_| \_\___|\__,_|\__,_|\__, | |_|  |_|\___/ \_/ \___||___/
--						                       |___/                                           
--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------

ready_moves = {}
-- Categorized list of Ready moves
ready_moves.physical = S{'Foot Kick','Whirl Claws','Sheep Charge','Lamb Chop','Head Butt','Wild Oats',
    'Leaf Dagger','Claw Cyclone','Razor Fang','Crossthrash','Nimble Snap','Cyclotail','Rhino Attack',
    'Power Attack','Mandibular Bite','Big Scissors','Grapple','Spinning Top','Double Claw','Frogkick',
    'Blockhead','Brain Crush','Tail Blow','Scythe Tail','Ripper Fang','Chomp Rush','Needleshot',
    'Recoil Dive','Sudden Lunge','Spiral Spin','Wing Slap','Beak Lunge','Suction','Back Heel',
    'Fantod','Tortoise Stomp','Sensilla Blades','Tegmina Buffet','Pentapeck','Sweeping Gouge',
    'Somersault','Tickling Tendrils','Pecking Flurry','Sickle Slash','Disembowel','Extirpating Salvo',
    'Mega Scissors','Rhinowrecker','Hoof Volley','Fluid Toss','Fluid Spread'}

ready_moves.magic_atk= S{'Dust Cloud','Cursed Sphere','Venom','Toxic Spit','Bubble Shower','Drainkiss',
    'Silence Gas','Dark Spore','Fireball','Plague Breath','Snow Cloud','Charged Whisker','Corrosive Ooze',
    'Aqua Breath','Stink Bomb','Nectarous Deluge','Nepenthic Plunge','Pestilent Plume','Foul Waters',
    'Acid Spray','Infected Leech','Gloom Spray','Venom Shower'}

ready_moves.magic_acc = S{'Sheep Song','Scream','Dream Flower','Roar','Predatory Glare','Gloeosuccus',
    'Palsy Pollen','Soporific','Geist Wall','Toxic Spit','Numbing Noise','Spoil','Hi-Freq Field',
    'Sandpit','Sandblast','Venom Spray','Filamented Hold','Queasyshroom','Numbshroom','Spore','Shakeshroom',
    'Infrasonics','Chaotic Eye','Blaster','Purulent Ooze','Intimidate','Noisome Powder','Acid Mist',
    'Choke Breath','Jettatura','Nihility Song','Molting Plumage','Swooping Frenzy','Spider Web'}

ready_moves.multi_hit = S{'Pentapeck','Tickling Tendrils','Sweeping Gouge','Chomp Rush','Wing Slap',
    'Pecking Flurry'}

-- ready_moves.tp = S{'Foot Kick','Dust Cloud','Snow Cloud','Sheep Song','Sheep Charge','Lamb Chop',
    -- 'Head Butt','Scream','Dream Flower','Wild Oats','Leaf Dagger','Claw Cyclone','Razor Fang','Roar',
    -- 'Gloeosuccus','Palsy Pollen','Soporific','Cursed Sphere','Somersault','Geist Wall','Numbing Noise',
    -- 'Frogkick','Nimble Snap','Cyclotail','Spoil','Rhino Attack','Hi-Freq Field','Sandpit','Sandblast',
    -- 'Mandibular Bite','Metallic Body','Bubble Shower','Grapple','Spinning Top','Double Claw','Spore',
    -- 'Filamented Hold','Blockhead','Fireball','Tail Blow','Plague Breath','Brain Crush','Infrasonics',
    -- 'Needleshot','Chaotic Eye','Blaster','Ripper Fang','Intimidate','Recoil Dive','Water Wall',
    -- 'Sudden Lunge','Noisome Powder','Wing Slap','Beak Lunge','Suction','Drainkiss','Acid Mist',
    -- 'TP Drainkiss','Back Heel','Jettatura','Choke Breath','Fantod','Charged Whisker','Purulent Ooze',
    -- 'Corrosive Ooze','Tortoise Stomp','Aqua Breath','Sensilla Blades','Tegmina Buffet','Sweeping Gouge',
    -- 'Tickling Tendrils','Pecking Flurry','Pestilent Plume','Foul Waters','Spider Web','Gloom Spray',
    -- 'Disembowel','Extirpating Salvo','Rhinowrecker','Venom Shower','Fluid Toss','Fluid Spread','Digest'}

-- List of Pet Buffs and Ready moves exclusively modified by Pet TP Bonus gear.
ready_moves.buff = S{'Wild Carrot','Bubble Curtain','Scissor Guard','Secretion','Rage','Harden Shell',
    'TP Drainkiss','Fantod','Rhino Guard','Zealous Snort','Frenzied Rage','Digest'}
	
-- List of Jug Modes that will cancel if Call Beast is used (Bestial Loyalty-only jug pets, HQs generally).
call_beast_cancel = S{'Vis. Broth','Ferm. Broth','Bubbly Broth','Windy Greens','Bug-Ridden Broth','Tant. Broth',
    'Glazed Broth','Slimy Webbing','Deepwater Broth','Venomous Broth','Heavenly Broth'}

-- moves we want to equip enmity gear for. 	
enmity_plus_moves = S{'Provoke','Berserk','Warcry','Aggressor','Holy Circle','Sentinel','Last Resort',
    'Souleater','Vallation','Swordplay', 'Animated Flourish'}


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
    -- All sets that are equipped to faciliate my pet's behaviour or abilities are under 'pet', eg, Perpetuation, Blood Pacts, etc
      
    sets.me = {}        		-- leave this empty
    sets.buff = {} 				-- leave this empty
    sets.me.Idle = {}			-- leave this empty
	sets.pet = {} 				-- leave this empty
    sets.pet.Idle = {}			-- leave this empty
    
	-- Optional 
	include('Atsuke_AugGear.lua') -- I list all my Augmented gears in a sidecar file since it's shared across many jobs. 

	 
    -- JSE
    AF = {}         -- leave this empty
    RELIC = {}      -- leave this empty
    EMPY = {}       -- leave this empty


    -- Fill this with your own JSE. 
    -- Totemic
    AF.Head     =   "Totemic Helm +2"
    AF.Body     =   "Tot. Jackcoat +2"
    AF.Hands    =   "Totemic Gloves +3"
    AF.Legs     =  	"Tot. Trousers +2"
    AF.Feet     =   "Tot. Gaiters +2"

    -- Ankusa
    RELIC.Head  =   { name="Ankusa Helm +3", augments={'Enhances "Killer Instinct" effect',}}
    RELIC.Body  =   { name="An. Jackcoat +3", augments={'Enhances "Feral Howl" effect',}}
    RELIC.Hands =   { name="Ankusa Gloves +1", augments={'Enhances "Beast Affinity" effect',}}
    RELIC.Legs  =   { name="Ankusa Trousers +2", augments={'Enhances "Familiar" effect',}}
    RELIC.Feet  =   { name="Ankusa Gaiters +3", augments={'Enhances "Beast Healer" effect',}}

    -- Nukumi
    EMPY.Head   =   "Nuk. Cabasset +1"
    EMPY.Body   =   "Nukumi Gausape +1"
    EMPY.Hands  =   "Nukumi Manoplas +1"
    EMPY.Legs   =   "Nukumi Quijotes +1"
    EMPY.Feet   =   "Nukumi Ocreae +1"



    -- Define JSE Capes
    Artio = {}
    Artio.TP = { name="Artio's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+3','"Dbl.Atk."+10','Damage taken-5%',}}
	Artio.STRDA = { name="Artio's Mantle", augments={'STR+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}}
	Artio.REWARD= { name="Artio's Mantle", augments={'MND+20','Pet: "Regen"+10','Pet: "Regen"+5',}}
	Artio.MNDWSD= { name="Artio's Mantle", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Weapon skill damage +10%',}}
	
	------------------------------------------------------------------------------------------------
	----------------------------------------- Idle Sets --------------------------------------------
	------------------------------------------------------------------------------------------------

    -- Your idle set
    	
	sets.me.Regen = {
		head = "Meghanada Visor +2",
		body = "Meg. Cuirie +2",
		hands = "Meg. Gloves +2",
		legs = "Meg. Chausses +2",
		feet = "Meg. Jam. +2",
		neck = "Sanctity Necklace",
		left_ring = "Meghanada Ring",
		right_ring = "Defending Ring",
		back = Artio.REWARD,
	}
	

    -- Your idle DT set
    sets.me.DT ={
        head = "Nyame Helm",
		body = "Nyame Mail",
		hands = "Nyame Gauntlets",
		legs = "Nyame Flanchard",
		feet = "Nyame Sollerets",
		right_ring ="Defending Ring",
		back = Artio.TP
    }
    
	sets.me.Regain = {
		head = "Gleti's Mask",
		body = "Gleti's Cuirass",
		hands = "Gleti's Gauntlets",
		legs = "Gleti's Breeches",
		feet = "Gleti's Boots",
		back = Artio.REWARD,
	}
	
	--Pet regen for when we are both Idle
	sets.me.Pet = {
		head = { name="Anwig Salade", augments={'Attack+3','Pet: "Regen"+1','Attack+3','Pet: Damage taken -10%',}},
		neck = "Empath Necklace",
		waist = "Isa Belt",
		back = Artio.REWARD
	}
	-- Your MP Recovered Whilst Resting Set
    sets.me.resting = { 
		
    }
    
    sets.me.latent_refresh = {waist="Fucho-no-obi"}     

	------------------------------------------------------------------------------------------------
	----------------------------------------- Engaged Sets -----------------------------------------
	------------------------------------------------------------------------------------------------
   
	-- Combat Related Sets
	sets.me.Engaged = {}
	
    sets.me.Engaged.TP = {
		
		head = "Malignance Chapeau",
		body = "Malignance Tabard",
		hands = "Malignance Gloves",
		legs = "Malignance Tights",
		feet = "Malignance Boots",
		neck = "Shulmanu Collar",
		waist = "Reiki Yotai",
		left_ear = "Sherida Earring",
		right_ear = "Suppanomimi",
		left_ring = "Hetairoi Ring",
		right_ring = "Epona's Ring",
		back = Artio.TP
    }
     
	sets.me.Engaged.DT = set_combine(sets.me.Engaged.TP, {right_ring="Defending Ring"})
	

	--------------------------------------------------------------------------------------------------------------
	------------------------------------------------ Buff Sets ---------------------------------------------------
	--------------------------------------------------------------------------------------------------------------
	
	sets.buff.Doom = {
		neck = "Nicander's Necklace",
		left_ring = "Blenmot's Ring",
		waist = "Gishdubar Sash",
	}
	
	sets.buff['Killer Instinct'] = {body = EMPY.Body}
   
	
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
		ammo = "Sapience Orb",
		hands = { name="Leyline Gloves", augments={'Accuracy+12','Mag. Acc.+10','"Mag.Atk.Bns."+1',}},
		neck = "Voltsurge Torque",
		waist = { name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear = "Loquac. Earring",
		right_ear = "Etiolation Earring",
		left_ring = "Prolix Ring",
    }

      
    -- Curing Precast, Cure Spell Casting time -
    sets.precast.cure = set_combine(sets.precast.casting,{
		right_ear = "Mendi. Earring",
    })
	
	sets.precast.Waltz = {
		head = AF.Head,
		body = "Gleti's Cuirass", --10
		hands = "Nyame Gauntlets",
		legs = "Dashing Subligar",  --10
		feet = "Nyame Sollerets",
		left_ear = "Odnowa Earring +1",
		right_ear = "Etiolation Earring",
		left_ring = "Defending Ring",
		right_ring = "Gelatinous Ring +1",
	
	}
	
	sets.precast.WaltzSelf = sets.precast.Waltz
    
	--JA precasts
	sets.precast['Spur'] = {feet = EMPY.Feet, back = "Artio's Mantle",}
	sets.precast['Call Beast'] = {hands = RELIC.Hands,}
	sets.precast['Bestial Loyalty'] = sets.precast['Call Beast']
	sets.precast['Tame'] = {head = AF.Head}
	sets.precast['Killer Instinct'] = {head = RELIC.Head}
	sets.precast.Ready = {legs = "Gleti's Breeches"}
	
	sets.precast['Feral Howl'] = {
		head = "Malignance Chapeau",
		body = RELIC.Body,
		hands = "Malignance Gloves",
		legs = "Malignance Tights",
		feet = "Malignance Boots",
		neck = "Sanctity Necklace",
		waist = "Eschan Stone",
		left_ear = "Hermetic Earring",
		left_ring = "Metamorph Ring",
		right_ring = "Karka Ring",
	
	}	
	
	sets.precast['Charm'] = {
		head = AF.Head,
		body = RELIC.Body,
		hands = RELIC.Hands,
		legs = RELIC.Legs,
		feet = RELIC.Feet,
		neck = "Unmoving Collar +1",
		waist = "Chaac Belt",
		left_ear = "Handler's Earring",
		right_ear = "Handler's Earring +1",
		left_ring = "Metamorph Ring",
	
	}
	
	sets.precast['Reward'] = {
		
		head = "Bison Warbonnet",
		body = AF.Body,
		hands = "Malignance Gloves",
		legs = RELIC.Legs,
		feet = RELIC.Feet,
		neck = "Phalaina Locket",
		waist = "Engraved Belt",
		left_ring = "Persis Ring",
		right_ring = "Karka Ring",
		back = Artio.REWARD
	}
	
	
	--------------------------------------------------------------------------------------------------------------
	----------------------------------------------- Mid Cast -----------------------------------------------------
	--------------------------------------------------------------------------------------------------------------

    -- Whatever you want to equip mid-cast as a catch all for all spells, and we'll overwrite later for individual spells
    sets.midcast.casting = {
		
    }
    
    sets.midcast.nuking.normal = {
		
    }
    
    sets.midcast.IntEnfeebling =  sets.midcast.nuking.normal
    sets.midcast.MndEnfeebling =  sets.midcast.nuking.normal
	
    -- Enhancing
    sets.midcast.enhancing = set_combine(sets.midcast.casting,{
		
    })
    sets.midcast.storm = sets.midcast.enhancing    
    
 	sets.midcast.cure = {} -- Leave This Empty
    
	-- Cure Potency
    sets.midcast.cure.normal = set_combine(sets.midcast.casting,{
		
    })
    
	sets.midcast.cure.weather = set_combine(sets.midcast.cure.normal,{

    })    
	
	------------------------------------------------------------------------------------------------
	--------------------------------------- WeaponSkill Sets ---------------------------------------
	------------------------------------------------------------------------------------------------
 
    sets.precast["Decimation"] = {
		ammo = "Focal Orb",
		head = RELIC.Head,
		body = "Gleti's Cuirass",
		hands = "Gleti's Gauntlets",
		legs = "Meg. Chausses +2",
		feet = "Gleti's Boots",
		neck = "Fotia Gorget",
		waist = "Fotia Belt",
		left_ear = "Sherida Earring",
		right_ear = "Brutal Earring",
		left_ring = "Regal Ring",
		right_ring = "Epona's Ring",
		back = Artio.STRDA
    }
	
    sets.precast["Ruinator"] = sets.precast['Decimation']
    
	sets.precast["Onslaught"] = {} -- does anybody actually make Guttler?	  
	
	sets.precast["Rampage"] = {
		--head 'Blistering Sallet +1',
		body = "Gleti's Cuirass",
		hands = "Gleti's Gauntlets",
		legs = "Gleti's Breeches",
		feet = "Gleti's Boots",
		neck = "Fotia Gorget",
		waist = "Fotia Belt",
		left_ear = "Sherida Earring",
		right_ear = "Brutal Earring",
		left_ring = "Regal Ring",
		right_ring = "Epona's Ring",
		--back = Artio.STRCRIT
	}
	
	sets.precast["Calamityy"] = {
		ammo = "Focal Orb",
		head = RELIC.Head,
		body = "Gleti's Cuirass",
		hands = AF.Hands,
		legs = "Gleti's Breeches",
		feet = "Gleti's Boots",
		neck = "Rep. Plat. Medal",
		waist = { name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear = "Ishvara Earring",
		right_ear = "Thrud Earring",
		left_ring = "Regal Ring",
		right_ring = "Rajas Ring",
		--back = artio.STRWSD
    }
	sets.precast['Mistral Axe'] = sets.precast['Calamity']
	
	sets.precast["Primal Rend"] = {
		ammo = "Focal Orb",
		head = RELIC.Head,
		body = "Nyame Mail",
		hands = AF.Hands,
		legs = "Nyame Flanchard",
		feet = "Shukuyu Sune-Ate",
		neck = "Sanctity Necklace",
		waist = "Eschan Stone",
		left_ear = "Friomisi Earring",
		right_ear = "Thrud Earring",
		left_ring = "Karka Ring",
		right_ring = "Persis Ring",
		back = Artio.MNDWSD
    }
	
	sets.precast["Cloudsplitter"] = sets.precast['Primal Rend']
	
	--------------------------------------------------------------------------------------------------------------
	------------------------------------------------- Pet Sets ---------------------------------------------------
	--------------------------------------------------------------------------------------------------------------
	
	sets.pet = {}
		
	-- Pet out but not doing anything
	sets.pet.Regen = {
		head = { name="Anwig Salade", augments={'Attack+3','Pet: "Regen"+1','Attack+3','Pet: Damage taken -10%',}},
		neck = "Empath Necklace",
		waist = "Isa Belt",
		back = Artio.REWARD
	}
	
	-- Have pet and it is doing all the work.  Note the capitalization of Idle and Engaged.  This is important as we are calling player and pet state.
	sets.pet.TP = { -- sets.pet.TP
		head = "Tali'ah Turban +2",
		body = RELIC.Body,
		hands = "Gleti's Gauntlets",
		legs = RELIC.Legs,
		feet = "Valorous Greaves",
		neck = "Shulmanu Collar",
		waist = "Incarnation Sash",
		left_ear = "Enmerkar Earring",
		right_ear = "Domes. Earring",
		left_ring = "C. Palug Ring",
		right_ring = "Varar Ring +1",
	}
		
	sets.pet.DT = {
		--head = { name="Anwig Salade", augments={'Attack+3','Pet: "Regen"+1','Attack+3','Pet: Damage taken -10%',}},
		body = AF.Body, --10
		hands = "Gleti's Gauntlets", --8
		feet = RELIC.Feet,
		neck = "Empath Necklace",
		waist = "Isa Belt", --3
		left_ear = "Enmerkar Earring", --3
		right_ear = "Handler's Earring +1", --4
	}
	

	--------------------------------------------------------------------------------------------------------------
	--------------------------------------------- Hybrid Sets ----------------------------------------------------
	--------------------------------------------------------------------------------------------------------------
	sets.MasterPet = {} -- Leave this empty
	
	sets.MasterPet.TP = {
		
		head = "Heyoka Cap",
		body = "Malignance Tabard",
		hands = "Malignance Gloves",
		legs = "Malignance Tights",
		feet = "Malignance Boots",
		neck = "Shulmanu Collar",
		waist = "Reiki Yotai",
		left_ear = "Telos Earring",
		right_ear = "Suppanomimi",
		left_ring = "Hetairoi Ring",
		right_ring = "Epona's Ring",
		back = Artio.TP
	}
	

	--------------------------------------------------------------------------------------------------------------
	----------------------------------------------- Ready Moves --------------------------------------------------
	--------------------------------------------------------------------------------------------------------------

	sets.pet.physical = {
		head = Emicho.Head.PetATK,
		body = Valorous.Body.PETATK,
		hands = EMPY.Hands,
		legs = "Gleti's Breeches",
		feet = "Gleti's Boots",
		neck = "Shulmanu Collar",
		waist = "Incarnation Sash",
		left_ear = "Enmerkar Earring",
		right_ear = "Domes. Earring",
		left_ring = "Varar Ring +1",
		right_ring = "C. Palug Ring",
	}
	
	
	sets.pet.magic_atk = {
		head = "Nyame Helm",
		body = Valorous.Body.PETATK,
		hands = EMPY.Hands,
		legs = Valorous.Legs.PetMAB,
		feet = "Nyame Sollerets",
		neck = "Adad Amulet",
		waist = "Incarnation Sash",
		left_ear = "Enmerkar Earring",
		right_ear = "Handler's Earring +1",
		right_ring = "C. Palug Ring",
	}
	
	
	sets.pet.magic_acc = {
		head = "Nyame Helm",
		body = "Nyame Mail",
		hands = "Nyame Gauntlets",
		legs = "Nyame Flanchard",
		feet = "Nyame Sollerets",
		neck = "Adad Amulet",
		waist = "Incarnation Sash",
		left_ear = "Enmerkar Earring",
		right_ear = "Handler's Earring +1",
		right_ring = "C. Palug Ring",
	}
	
	
	sets.pet.multi_hit = {
		head = Emicho.Head.PetATK,
		body = Valorous.Body.PETATK,
		hands = EMPY.Hands,
		legs = Emicho.Legs.PetATK,
		feet = "Gleti's Boots",
		neck = "Shulmanu Collar",
		waist = "Incarnation Sash",
		left_ear = "Domes. Earring",
		right_ear = "Enmerkar Earring",
		left_ring = "Varar Ring +1",
		right_ring = "C. Palug Ring",
	}
	
	sets.pet.tp = {}	
	
	sets.pet.buff = {hands = EMPY.Hands,}
		
	
	--------------------------------------------------------------------------------------------------------------
	-------------------------------------------------- Misc. -----------------------------------------------------
	--------------------------------------------------------------------------------------------------------------
  
	-- Movespeedset
    sets.me.movespeed = {}
	
	-- For running faster in Adoulin
	sets.adoulin = {body = "Councilor's Garb",}
	
	-- Because Treasure Hunter totally works just keep lying to yourself.
	sets.TH = {
		ammo = "Per. Lucky Egg",
		head = "Wh. Rarab Cap +1",
		legs = "Volte Hose",
		waist = "Chaac Belt",
	}
	
	sets.Enmity = {
		ammo = "Sapience Orb",
		head = "Halitus Helm",
		body = "Emet Harness +1",
		hands = "Meg. Gloves +2",
		legs = "Zoar Subligar +1",
		neck = "Unmoving Collar +1",
		left_ring = "Provocare Ring",
		right_ring = "Defending Ring",
		back = "Agema Cape",
	}
	
    ------------
    -- Aftercast
    ------------
      
    -- I don't use aftercast sets, as we handle what to equip later depending on conditions using a function.
	
end
