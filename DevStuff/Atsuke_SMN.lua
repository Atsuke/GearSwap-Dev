--include('global.lua') -- Just a collection of functions that I use in all my GearSwaps. See below (after this code block)
 
--set_macros(1,2) -- Sheet, Book



include('organizer-lib') -- Remove if you dont use Organizer
--------------------------------------------------------------------------------------------------------------
res = require('resources')      -- leave this as is    
texts = require('texts')        -- leave this as is    
include('Modes.lua')            -- leave this as is    

--------------------------------------------------------------------------------------------------------------
idleModes = M('normal', 'dt', 'mdt')
nukeModes = M('normal', 'acc')

-- Setting this to true will stop the text spam, and instead display modes in a UI.
-- Currently in construction.
use_UI = true
hud_x_pos = 1400    --important to update these if you have a smaller screen
hud_y_pos = 200     --important to update these if you have a smaller screen
hud_draggable = true
hud_font_size = 10
hud_transparency = 200 -- a value of 0 (invisible) to 255 (no transparency at all)
hud_font = 'Impact'




include('SMN_Lib.lua')  
validateTextInformation()


function get_sets()
 
    -- My formatting is very easy to follow. All sets that pertain to my character doing things are under 'me'.
    -- All sets that are equipped to faciliate my avatar's behaviour or abilities are under 'avatar', eg, Perpetuation, Blood Pacts, etc
     
    sets.me = {}
    sets.avatar = {}
	
     
    -- Your idle set when you DON'T have an avatar out
    -- sets.me.idle.normal = {
        -- main="",
        -- sub="",
        -- ranged="",
        -- ammo="",
        -- head="",
        -- neck="",
        -- lear="",
        -- rear="",
        -- body="",
        -- hands="",
        -- lring="",
        -- rring="",
        -- back="",
        -- waist="",
        -- legs="",
        -- feet=""
    -- }
     
	 
	  -- sets.me.idle.normal.dt = {
        -- main="",
        -- sub="",
        -- ranged="",
        -- ammo="",
        -- head="",
        -- neck="",
        -- lear="",
        -- rear="",
        -- body="",
        -- hands="",
        -- lring="",
        -- rring="",
        -- back="",
        -- waist="",
        -- legs="",
        -- feet=""
    -- }
	 
	 
	  -- sets.me.idle.normal.mdt = {
        -- main="",
        -- sub="",
        -- ranged="",
        -- ammo="",
        -- head="",
        -- neck="",
        -- lear="",
        -- rear="",
        -- body="",
        -- hands="",
        -- lring="",
        -- rring="",
        -- back="",
        -- waist="",
        -- legs="",
        -- feet=""
    -- }
	 
	 

	 
	 
    -- Your MP Recovered Whilst Resting Set
    sets.me.resting = { 
        main="",
        sub="",
        ranged="",
        ammo="",
        head="",
        neck="",
        lear="",
        rear="",
        body="",
        hands="",
        lring="",
        rring="",
        back="",
        waist="",
        legs="",
        feet=""
    }
     
    -----------------------
    -- Perpetuation Related
    -----------------------
     
    -- Avatar's Out --  
    -- This is the base for all perpetuation scenarios, as seen below
    sets.avatar.perp = {
        main="",
        sub="",
        ranged="",
        ammo="",
        head="",
        neck="",
        lear="",
        rear="",
        body="",
        hands="",
        lring="",
        rring="",
        back="",
        waist="",
        legs="",
        feet=""
    }
 
    -- The following sets base off of perpetuation, so you can consider them idle sets.
    -- Set the relevant gear, bearing in mind it will overwrite the perpetuation item for that slot!
     
    -- When we want our avatar to stay alive
    sets.avatar.tank = set_combine(sets.avatar.perp,{
        main="",
        sub="",
        ranged="",
        ammo="",
        head="",
        neck="",
        lear="",
        rear="",
        body="",
        hands="",
        lring="",
        rring="",
        back="",
        waist="",
        legs="",
        feet=""
    })
     
    -- When we want our avatar to shred
    sets.avatar.melee = set_combine(sets.avatar.perp,{
        main="",
        sub="",
        ranged="",
        ammo="",
        head="",
        neck="",
        lear="",
        rear="",
        body="",
        hands="",
        lring="",
        rring="",
        back="",
        waist="",
        legs="",
        feet=""
    })
     
    -- When we want our avatar to hit
    sets.avatar.acc = set_combine(sets.avatar.perp,{
        main="",
        sub="",
        ranged="",
        ammo="",
        head="",
        neck="",
        lear="",
        rear="",
        body="",
        hands="",
        lring="",
        rring="",
        back="",
        waist="",
        legs="",
        feet=""
    })
     
    -- When Avatar's Favori s active
    sets.avatar.favor = set_combine(sets.avatar.perp,{
        main="",
        sub="",
        ranged="",
        ammo="",
        head="",
        neck="",
        lear="",
        rear="",
        body="",
        hands="",
        lring="",
        rring="",
        back="",
        waist="",
        legs="",
        feet=""
    })
     
    ----------------------------
    -- Summoning Skill Related
    -- Including all blood pacts
    ----------------------------
     
    -- + Summoning Magic. This is a base set for max skill and blood pacts and we'll overwrite later as and when we need to
    sets.avatar.skill = {
        main="",
        sub="",
        ranged="",
        ammo="",
        head="",
        neck="",
        lear="",
        rear="",
        body="",
        hands="",
        lring="",
        rring="",
        back="",
        waist="",
        legs="",
        feet=""
    }
     
    -------------------------
    -- Individual Blood Pacts
    -------------------------
     
    -- Physical damage
    sets.avatar.atk = set_combine(sets.avatar.skill,{
        main="",
        sub="",
        ranged="",
        ammo="",
        head="",
        neck="",
        lear="",
        rear="",
        body="",
        hands="",
        lring="",
        rring="",
        back="",
        waist="",
        legs="",
        feet=""
    })
     
    -- Magic Attack
    sets.avatar.mab = set_combine(sets.avatar.skill,{
        main="",
        sub="",
        ranged="",
        ammo="",
        head="",
        neck="",
        lear="",
        rear="",
        body="",
        hands="",
        lring="",
        rring="",
        back="",
        waist="",
        legs="",
        feet=""
    })
 
    -- Hybrid
    sets.avatar.hybrid = set_combine(sets.avatar.skill,{
        main="",
        sub="",
        ranged="",
        ammo="",
        head="",
        neck="",
        lear="",
        rear="",
        body="",
        hands="",
        lring="",
        rring="",
        back="",
        waist="",
        legs="",
        feet=""
    })
     
    -- Magic Accuracy
    sets.avatar.macc = set_combine(sets.avatar.skill,{
        main="",
        sub="",
        ranged="",
        ammo="",
        head="",
        neck="",
        lear="",
        rear="",
        body="",
        hands="",
        lring="",
        rring="",
        back="",
        waist="",
        legs="",
        feet=""
    })
     
    -- Buffs
    sets.avatar.buff = set_combine(sets.avatar.skill,{
        main="",
        sub="",
        ranged="",
        ammo="",
        head="",
        neck="",
        lear="",
        rear="",
        body="",
        hands="",
        lring="",
        rring="",
        back="",
        waist="",
        legs="",
        feet=""
    })
     
    -- Other
    sets.avatar.other = set_combine(sets.avatar.skill,{
        main="",
        sub="",
        ranged="",
        ammo="",
        head="",
        neck="",
        lear="",
        rear="",
        body="",
        hands="",
        lring="",
        rring="",
        back="",
        waist="",
        legs="",
        feet=""
    })
     
    -- Combat Related Sets
     
    -- Melee
    -- The melee set combines with perpetuation, because we don't want to be losing all our MP whilst we swing our Staff
    -- Anything you equip here will overwrite the perpetuation/refresh in that slot.
    sets.me.melee = set_combine(sets.avatar.perp,{
        main="",
        sub="",
        ranged="",
        ammo="",
        head="",
        neck="",
        lear="",
        rear="",
        body="",
        hands="",
        lring="",
        rring="",
        back="",
        waist="",
        legs="",
        feet=""
    })
     
    -- Shattersoul. Weapon Skills do not work off perpetuation as it only stays equipped for a moment
    sets.me["Shattersoul"] = {
        main="",
        sub="",
        ranged="",
        ammo="",
        head="",
        neck="",
        lear="",
        rear="",
        body="",
        hands="",
        lring="",
        rring="",
        back="",
        waist="",
        legs="",
        feet=""
    }
    sets.me["Garland of Bliss"] = {
        main="",
        sub="",
        ranged="",
        ammo="",
        head="",
        neck="",
        lear="",
        rear="",
        body="",
        hands="",
        lring="",
        rring="",
        back="",
        waist="",
        legs="",
        feet=""
    }
     
    -- Feel free to add new weapon skills, make sure you spell it the same as in game. These are the only two I ever use though
 
    ---------------
    -- Casting Sets
    ---------------
     
    sets.precast = {}
    sets.midcast = {}
    sets.aftercast = {}
     
    ----------
    -- Precast
    ----------
     
    -- Generic Casting Set that all others take off of. Here you should add all your fast cast  
    sets.precast.casting = {
        main="",
        sub="",
        ranged="",
        ammo="",
        head="",
        neck="",
        lear="",
        rear="",
        body="",
        hands="",
        lring="",
        rring="",
        back="",
        waist="",
        legs="",
        feet=""
    }   
     
    -- Summoning Magic Cast time - gear
    sets.precast.summoning = set_combine(sets.precast.casting,{
        main="",
        sub="",
        ranged="",
        ammo="",
        head="",
        neck="",
        lear="",
        rear="",
        body="",
        hands="",
        lring="",
        rring="",
        back="",
        waist="",
        legs="",
        feet=""
    })
     
    -- Enhancing Magic, eg. Siegal Sash, etc
    sets.precast.enhancing = set_combine(sets.precast.casting,{
        main="",
        sub="",
        ranged="",
        ammo="",
        head="",
        neck="",
        lear="",
        rear="",
        body="",
        hands="",
        lring="",
        rring="",
        back="",
        waist="",
        legs="",
        feet=""
    })
 
    -- Stoneskin casting time -, works off of enhancing -
    sets.precast.stoneskin = set_combine(sets.precast.enhancing,{
        main="",
        sub="",
        ranged="",
        ammo="",
        head="",
        neck="",
        lear="",
        rear="",
        body="",
        hands="",
        lring="",
        rring="",
        back="",
        waist="",
        legs="",
        feet=""
    })
     
    -- Curing Precast, Cure Spell Casting time -
    sets.precast.cure = set_combine(sets.precast.casting,{
        main="",
        sub="",
        ranged="",
        ammo="",
        head="",
        neck="",
        lear="",
        rear="",
        body="",
        hands="",
        lring="",
        rring="",
        back="",
        waist="",
        legs="",
        feet=""
    })
     
    ---------------------
    -- Ability Precasting
    ---------------------
     
    -- Blood Pact Ability Delay
    sets.precast.bp = {
        main="",
        sub="",
        ranged="",
        ammo="",
        head="",
        neck="",
        lear="",
        rear="",
        body="",
        hands="",
        lring="",
        rring="",
        back="",
        waist="",
        legs="",
        feet=""
    }
     
    -- Mana Cede
    sets.precast["Mana Cede"] = {
        main="",
        sub="",
        ranged="",
        ammo="",
        head="",
        neck="",
        lear="",
        rear="",
        body="",
        hands="",
        lring="",
        rring="",
        back="",
        waist="",
        legs="",
        feet=""
    }
     
    -- Astral Flow  
    sets.precast["Astral Flow"] = {
        main="",
        sub="",
        ranged="",
        ammo="",
        head="",
        neck="",
        lear="",
        rear="",
        body="",
        hands="",
        lring="",
        rring="",
        back="",
        waist="",
        legs="",
        feet=""
    }
     
    -- Elemental Siphon, eg, Tatsumaki Thingies, Esper Stone, etc
    sets.precast.siphon = set_combine(sets.avatar.skill,{
        main="",
        sub="",
        ranged="",
        ammo="",
        head="",
        neck="",
        lear="",
        rear="",
        body="",
        hands="",
        lring="",
        rring="",
        back="",
        waist="",
        legs="",
        feet=""
    })
     
    ----------
    -- Midcast
    ----------
     
    -- We handle the damage and etc. in Pet Midcast later
     
    -- Whatever you want to equip mid-cast as a catch all for all spells, and we'll overwrite later for individual spells
    sets.midcast.casting = {
        main="",
        sub="",
        ranged="",
        ammo="",
        head="",
        neck="",
        lear="",
        rear="",
        body="",
        hands="",
        lring="",
        rring="",
        back="",
        waist="",
        legs="",
        feet=""
    }
     
    -- Enhancing
    sets.midcast.enhancing = set_combine(sets.midcast.casting,{
        main="",
        sub="",
        ranged="",
        ammo="",
        head="",
        neck="",
        lear="",
        rear="",
        body="",
        hands="",
        lring="",
        rring="",
        back="",
        waist="",
        legs="",
        feet=""
    })
     
    -- Stoneskin
    sets.midcast.stoneskin = set_combine(sets.midcast.enhancing,{
        main="",
        sub="",
        ranged="",
        ammo="",
        head="",
        neck="",
        lear="",
        rear="",
        body="",
        hands="",
        lring="",
        rring="",
        back="",
        waist="",
        legs="",
        feet=""
    })
     
    -- Cure Potency
    sets.midcast.cure = set_combine(sets.midcast.casting,{
        main="",
        sub="",
        ranged="",
        ammo="",
        head="",
        neck="",
        lear="",
        rear="",
        body="",
        hands="",
        lring="",
        rring="",
        back="",
        waist="",
        legs="",
        feet=""
    })
     
	
sets.movement = { 
	left_ear="Evans earring",
	waist="Lucidity sash",
	feet="Herald's Gaiters"
}

sets.adoulinmovement = { 
	body="Councilor's Garb"
}
    ------------
    -- Aftercast
    ------------
     
    -- I don't use aftercast sets, as we handle what to equip later depending on conditions using a function, eg, do we have an avatar out?
 
end
 
-- function precast(spell)
 
    -- -- Don't swap if we're in the middle of something or our pet's doing something
    -- -- Stops macro spam from interfering with an action GS is already handling
    -- if midaction() or pet_midaction() then
        -- return
    -- end
     
    -- -- If we're doing a blood pact, equip our delay set IF Apogee or Astral Conduit are not active
    -- if (spell.type == 'BloodPactRage' or spell.type == 'BloodPactWard') and not (buffactive['Astral Conduit'] or buffactive['Apogee']) then
     
        -- equip(sets.precast.bp)
         
    -- elseif spell.type == 'SummonerPact' then
     
        -- -- This chunk of code handles Elemental Siphon. It will look at the current day and weather and cancel the spell to summon
        -- -- the right elemental. Your elemental siphon macro should summon a Dark Spirit to trigger this check
         
        -- -- These use the included lists in global.lua to determine the right spirit to summon
             
        -- if spell.name == 'Dark Spirit' then
            -- if world.weather_element == 'Dark' then
             
                -- -- Dark Weather is active, lets the spell go ahead and equips summoning precast
                -- equip(sets.precast.summoning)
                 
            -- elseif world.weather_element ~= 'None' and spirit_conflict[world.day_element] ~= world.weather_element then
             
                -- -- It's not dark weather but there is some weather up, cancels dark and summons the right spirit
                -- cancel_spell()
                -- send_command('input /ma "%s" <me>':format(spirit_element[world.weather_element]))
                -- equip(sets.precast.summoning)
                 
            -- elseif world.day_element == 'Dark' then
             
                -- -- It's darksday so allow the dark spirit to go ahead and equip summoning
                -- equip(sets.precast.summoning)
                 
            -- else
             
                -- -- There is no weather up and it's not darksday, so summon the current day's spirit
                -- cancel_spell()              
                -- send_command('input /ma "%s" <me>':format(spirit_element[world.day_element]))
                -- equip(sets.precast.summoning)
                 
            -- end
        -- else
         
            -- -- We're not summoning Dark Spirit, so we don't want to Siphon, which means we're summoning an avatar
            -- equip(sets.precast.summoning)
             
        -- end
         
    -- -- Moving on to other types of magic
    -- elseif spell.type == 'WhiteMagic' or spell.type == 'BlackMagic' then
     
        -- -- Stoneskin Precast
        -- if spell.name == 'Stoneskin' then
         
            -- windower.ffxi.cancel_buff(37)--[[Cancels stoneskin, not delayed incase you get a Quick Cast]]
            -- equip(sets.precast.stoneskin)
             
        -- -- Cure Precast
        -- elseif spell.name:match('Cure') or spell.name:match('Cura') then
         
            -- equip(sets.precast.cure)
             
        -- -- Enhancing Magic
        -- elseif spell.skill == 'Enhancing Magic' then
         
            -- equip(sets.precast.enhancing)
             
            -- if spell.name == 'Sneak' then
                -- windower.ffxi.cancel_buff(71)--[[Cancels Sneak]]
            -- end
        -- else
         
            -- -- For everything else we go with max fastcast
            -- equip(sets.precast.casting)
             
        -- end
         
    -- -- Summoner Abilities
    -- -- We use a catch all here, if the set exists for an ability, use it
    -- -- This way we don't need to write a load of different code for different abilities, just make a set
     
    -- elseif sets.precast[spell.name] then
        -- equip(sets.precast[spell.name])
    -- end
     
-- end
 
-- function midcast(spell)
 
    -- -- If our pet is doing something, prevents us swapping equipment too early
    -- if pet_midaction() then
        -- return
    -- end
     
    -- -- No need to annotate all this, it's fairly logical. Just equips the relevant sets for the relevant magic
    -- if spell.type == 'WhiteMagic' or spell.type == 'BlackMagic' then
        -- if spell.name == 'Stoneskin' then
            -- equip(sets.midcast.stoneskin)
        -- elseif spell.name:match('Cure') or spell.name:match('Cura') then
            -- equip(sets.midcast.cure)
        -- elseif spell.skill == 'Enhancing Magic' then
            -- equip(sets.midcast.enhancing)
            -- if spell.name:match('Protect') or spell.name:match('Shell') then
                -- equip({rring="Sheltered Ring"})
            -- end
        -- else
            -- equip(sets.midcast.casting)
        -- end
    -- elseif spell.name == 'Elemental Siphon' then
     
        -- -- Siphon Set
        -- equip(sets.precast.siphon)
         
        -- -- Checks if pet matches weather
        -- if pet.element == world.weather_element then
            -- equip(sets.precast.siphon,{main="Chatoyant Staff"--[[Take advantage of the weather boost]]})
        -- end
         
    -- -- And our catch all, if a set exists for this spell use it
    -- elseif sets.midcast[spell.name] then
        -- equip(sets.midcast[spell.name])
         
    -- -- Remember those WS Sets we defined? :)
    -- elseif sets.me[spell.name] then
        -- equip(sets.me[spell.name])
    -- end
-- end
 
-- function aftercast(spell)
 
    -- -- If our pet's doing something, Stop!
    -- if pet_midaction() then
        -- return
    -- end 
     
    -- -- If not a blood pact or summon
    -- if spell and (not spell.type or not string.find(spell.type,'BloodPact') and not AvatarList:contains(spell.name) or spell.interrupted) then
     
        -- -- Then initiate idle function to check which set should be equipped
        -- idle(pet)
         
    -- end
-- end
 
-- function pet_midcast(spell)
 
    -- -- Our pet is doing something
    -- if (spell.type == 'BloodPactRage' or spell.type == 'BloodPactWard') then
     
        -- -- We're going to check the lists in global.lua for matches and equip the relevant sets
         
        -- if bp_physical:contains(spell.name) then
         
            -- equip(sets.avatar.atk)
             
        -- elseif bp_hybrid:contains(spell.name) then
         
            -- equip(sets.avatar.hybrid)
            -- if pet.name == 'Ifrit' then
                -- equip({rring="Fervor Ring"})--[[Change rring to lring if you put Evoker's on your right hand]]
            -- end
             
        -- elseif bp_magical:contains(spell.name) then
         
            -- equip(sets.avatar.mab)
            -- if pet.name == 'Ifrit' then
                -- equip({rring="Fervor Ring"})--[[Change rring to lring if you put Evoker's on your right hand]]
            -- end
 
        -- elseif bp_debuff:contains(spell.name) then
         
            -- equip(sets.avatar.macc)
             
        -- elseif bp_buff:contains(spell.name) then
         
            -- equip(sets.avatar.buff)
             
        -- elseif bp_other:contains(spell.name) then
         
            -- equip(sets.avatar.other)
             
        -- elseif spell.name == 'Perfect Defense' then
         
            -- equip(sets.avatar.skill)
             
        -- else
         
            -- equip(sets.avatar.skill)
             
        -- end
    -- end 
-- end
 
-- function pet_aftercast(spell)
     
    -- -- Pet aftercast is simply a check for whether Conduit and Apogee are up, and then a call to our aftercast function
    -- -- We have a variable called autobp that we set to true or false with commands to auto repeat BPs for us
    -- if (buffactive['Apogee'] or buffactive['Astral Conduit']) and autobp then
        -- send_command('input /pet "%s" <t>':format(spell.name))
        -- return
    -- end
     
    -- idle(pet)
     
-- end
 
-- function idle(pet)
 
    -- -- This function is called after every action, and handles which set to equip depending on what we're doing
    -- -- We check if we're meleeing because we don't want to idle in melee gear when we're only engaged for trusts
     
    -- if favor then
     
        -- -- Avatar's favor takes priority!
        -- equip(sets.avatar.favor)
         
    -- elseif meleeing and player.status=='Engaged' then
     
        -- -- We're both engaged and meleeing
        -- equip(sets.me.melee)
         
    -- elseif pet.isvalid then
         
        -- -- We have a pet out but we're not meleeing, set the right idle set
        -- equip(sets.avatar[mode])
 
    -- else
     
        -- -- We're not meleeing and we have no pet out
        -- equip(sets.me.idle)
         
    -- end
-- end
 
-- function status_change(new,old)
    -- if new == 'Engaged' then
     
        -- -- If we engage check our meleeing status
        -- idle(pet)
         
    -- elseif new=='Resting' then
     
        -- -- We're resting
        -- equip(sets.me.resting)
    -- else
        -- idle(pet)
    -- end
	
	
	-- if areas.Cities:contains(world.area) and world.area:contains("Adoulin") then
		-- idleSet = set_combine(idleSet, sets.adoulinmovement)
	-- elseif  world.area:contains("Mog Garden") then
		-- idleSet = set_combine(idleSet, sets.farmer)
		-- --windower.send_command('input /ja Release <me>;wait 2;input /ma '..tosummon..' <me>')
	-- elseif buffactive["Quickening"] or buffactive["Fleet Wind"] or areas.Cities:contains(world.area) then
		-- idleSet = set_combine(idleSet, sets.movement)
	-- elseif state.movement.current == 'on' then 
		-- idleSet = set_combine(idleSet, sets.movement)
	-- end
	
	
	
	
	
	
	
	
 
-- end
 
-- function pet_change(pet,gain)
 
    -- -- When we summon or release an avatar
    -- idle(pet)
 
-- end
 
 
-- function self_command(command)
 
    -- local commandArgs = command
     
    -- -- This command takes //gs c avatar mode, where mode is what you want, eg, tank, acc, melee, etc
    -- if #commandArgs:split(' ') >= 2 then
        -- commandArgs = T(commandArgs:split(' '))
        -- if commandArgs[1] == 'avatar' then
            -- if commandArgs[2] then
                -- mode = tostring(commandArgs[2])
                -- equip(sets.avatar[mode])
                -- windower.add_to_chat(8,'----- Avatar set to '..mode..' mode! -----')
            -- end
        -- elseif commandArgs[1] == 'toggle' then
            -- if commandArgs[2] == 'auto' then
             
                -- -- //gs c toggle auto will toggle auto blood pacts on and off. Auto blood pact will make your GS repeat BPs under Apogee or Conduit
                -- -- And by repeat I mean repeat. If Conduit is up, it will SPAM the BP until Conduit is down
                -- if autobp then
                    -- autobp = false
                    -- windower.add_to_chat(8,'----- Auto BP mode Disabled -----')
                -- else
                    -- autobp = true
                    -- windower.add_to_chat(8,'----- Auto BP mode Enabled -----')
                -- end
            -- elseif commandArgs[2] == 'melee' then
             
                -- -- //gs c toggle melee will toggle melee mode on and off.
                -- -- This basically locks the slots that will cause you to lose TP if changing them,
                -- -- As well as equip your melee set if you're engaged
 
                -- if meleeing then
                    -- meleeing = false
                    -- enable('main','sub','ranged')
                    -- windower.add_to_chat(8,'----- Weapons Unlocked, WILL LOSE TP -----')
                    -- idle(pet)
                -- else
                    -- meleeing=true
                    -- disable('main','sub','ranged')
                    -- windower.add_to_chat(8,'----- Weapons Locked, WILL NOT LOSE TP -----')
                    -- idle(pet)
                -- end
                 
            -- elseif commandArgs[2] == 'favor' then
                     
                -- -- //gs c toggle favor will toggle Favor mode on and off.
                -- -- It won't automatically toggle, as some people like having favor active without the gear swaps for maximum effectiveness
                -- -- You need to toggle prioritisation yourself
                -- if favor then
                    -- favor = false
                    -- windower.add_to_chat(8,"----- Avatar's Favor Mode OFF -----")
                -- else
                    -- favor = true
                    -- windower.add_to_chat(8,"----- Avatar's Favor Mode ON -----")
                -- end
                 
            -- end
        -- end
    -- end
-- end
 
-- Required variables and their initial value
meleeing = false
autobp = false
favor = false
mode = "perp"