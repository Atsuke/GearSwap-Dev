version = "3.0"
pName = player.name

-- Saying hello
windower.add_to_chat(8,'----- Welcome back to your DNC.lua, '..pName..' -----')

runspeedslot = 'feet'

--------------------------------------------------------------------------------------------------------------
------------------------------------------------ HUD STUFF ---------------------------------------------------
--------------------------------------------------------------------------------------------------------------

meleeing = M('AUTO', 'OFF', 'ON')
lock = M('OFF', 'ON')
mBurst = M(false)
runspeed = M('OFF', 'ON')
oldElement = elements.current
mBurstOldValue = mBurst.value
matchsc = M('AUTO', 'OFF', 'ON')
MB_Window = 0   
time_start = 0

setupTextWindow()


--validateTextInformation()

-- Called every time we gain or lose a buff.
function buff_change(buff,gain)
    if (buff == 'Climactic Flourish' and gain) then
		equip(sets.buff['Climactic Flourish'])
	end
	
	if buff == "doom" then
        if gain then
            equip(sets.buff.Doom)
            send_command('@input /p Doomed.')
            disable('ring1','ring2','waist')
        else
            enable('ring1','ring2','waist')
			idle()
        end
    end
    
	validateTextInformation()
end

--------------------------------------------------------------------------------------------------------------
----------------------------------------------- Pre Cast -----------------------------------------------------
--------------------------------------------------------------------------------------------------------------

--called before every action

function precast(spell)

    local spell_recasts = windower.ffxi.get_spell_recasts()

    -- Detect Silence and yell at you to use echo drops.    
    if spell.action_type == 'ninjutsu' and buffactive['Silence'] then 
        cancel_spell()
        --send_command('input /item "Echo Drops" <me>')     
        add_to_chat(8, '****** ['..spell.name..' CANCELED - Use Echo Drops] ******')
        return        
    end   
	
	-- If sneak is active when using, cancel before completion
	if spell.name == 'Spectral Jig' and buffactive.sneak then
		windower.ffxi.cancel_buff(71)
    end
	
	--Check for Climactic Flourish
	if spell.type == "WeaponSkill" then
        if buffactive['Climactic Flourish'] then
			equip(sets.buff['Climactic Flourish'])
        end
	end
	
	-- Waltzes that heal us is a different set than waltzes for others
	if spell.type == 'Waltz' then
		if  spell.target.type == 'SELF' then
			equip(sets.precast.WaltzSelf)
		else
			equip(sets.precast.Waltz)
		end
    end   
	
	-- automatically change to DT mode when activating Fan Dance
	if buffactive['Fan Dance'] then
		meleeModes:set('DT')
    end
	
	--catchall for our various Jigs
	if spell.type == 'Jig' then
		equip(sets.precast.Jig)
	end
	
	--Catchall for our various steps
	if spell.type == 'Step' then
		equip(sets.precast.Step)
	end
	
	--Catchall for the various Utsusem Spells
	if spell.name:contains('Utsusemi') then
		equip(sets.precast['Utsusemi'])
	end
	
	--In case we need to use warcry as a hate tool. 
	if(enmityModes.current == 'Enmity') then
		if spell.name:contains('Warcry') then
			equip(sets.precast['Provoke'])
		end
	end
	
	-- We use a catch all here, if the set exists for an ability, 
	-- use it. This way we don't need to write a load of different
	-- code for different abilities, just make a set
	
	if sets.precast[spell.name] then
        equip(sets.precast[spell.name])
	end

end

--------------------------------------------------------------------------------------------------------------
----------------------------------------------- Mid Cast -----------------------------------------------------
--------------------------------------------------------------------------------------------------------------

-- called after casting begins but before completion. 
-- This is for things like MAB gear or Enmity+

function midcast(spell)
    if(enmityModes.current == 'Enmity') then
		if spell.name:contains('Utsusemi') then
			equip(sets.precast['Provoke'])
		end
	end
end

--------------------------------------------------------------------------------------------------------------
----------------------------------------------- After Cast ---------------------------------------------------
--------------------------------------------------------------------------------------------------------------

-- called after each cast. 
-- We just call the idle function as it contains our logic.

function aftercast(spell) 
    idle()
end

--------------------------------------------------------------------------------------------------------------
--------------------------------------------------- Idle -----------------------------------------------------
--------------------------------------------------------------------------------------------------------------

-- This function is called after every action, and handles which set to equip depending on what we're doing

function idle()
    
    if (player.status == 'Engaged') then -- We're engaged. Weapons out in a hostile manner   
       
        equip(sets.engaged[meleeModes.value])               
    else
       equip(sets.idle[idleModes.value]) -- currently not engaged.
	end

	validateTextInformation() -- updates the HUD
end 

--------------------------------------------------------------------------------------------------------------
---------------------------------------------- Handle Provoke ------------------------------------------------
--------------------------------------------------------------------------------------------------------------

-- Function to allow one macro for Provoke or Animated Flourish
-- Tries for Provoke first due to higher enmity value

function handle_voke()
	
	local ability_recasts = windower.ffxi.get_ability_recasts()
	
	
	if player.sub_job == 'WAR' then --Are you /WAR?

	spell = 'Provoke' --YOU ARE! GREAT! Lets lead with Provoke
	
	if ability_recasts[5] > 0 then --Is Provoke Ready?
        --It wasn't. Bummer.
	    add_to_chat(8, '****** ['..spell..' CANCELED - Provoke on Cooldown, Trying Animated Flourish] ******')
		
		spell = 'Animated Flourish'  -- Fine then. We have other options. 
		
		--Check every possible combination of Finishing Moves because they are each their own buff. Good design choices SE. 
		if ((buffactive[381] or buffactive[382] or buffactive[383] or buffactive[384] or buffactive[385] or buffactive[588]) and ability_recasts[221] == 0) then
				send_command('@input /ja "'..spell..'"') --We had finishing moves. Yay! Lets make the monster mad at us.
		else
			add_to_chat(8, '****** ['..spell..' CANCELED - Animated Flourish on Cooldown, try stabbing it.] ******') -- No dice on Animated Flourish either. Give it the old climactic/Rudra's. That always pulls hate
		end   
	
	else --Provoke was ready. Woohoo! Lets poke the angry monster
		send_command('@input /ja "'..spell..'"')
	end
		--return
	elseif player.sub_job ~= 'WAR' then -- You are not /WAR.  You're one of them bandwagon /DRG's aren't you?
		spell = 'Animated Flourish'
		send_command('@input /ja "'..spell..'"') --Don't need to check for Finishing moves here because if you arent /WAR you only have the one voke and you are watching your Finishing Moves anyway right? 
	end
	
end

--------------------------------------------------------------------------------------------------------------
---------------------------------------------- Status Change -------------------------------------------------
--------------------------------------------------------------------------------------------------------------

-- called every time our status changes. Idle, Engaged, Dead, etc.
-- for our purposes we just refer it back to idle.

function status_change(new,old)
    idle()
end

--------------------------------------------------------------------------------------------------------------
---------------------------------------------- Self Command --------------------------------------------------
--------------------------------------------------------------------------------------------------------------


function self_command(command)
    hud_command(command)
    local commandArgs = command
     
    if #commandArgs:split(' ') >= 2 then
        commandArgs = T(commandArgs:split(' '))
		
		-- these are your toggle commands.  macros will look like:
		-- /console gs c toggle command
		-- Can also keybind these. All of them are by default.
        if commandArgs[1] == 'toggle' then
			-- //gs c toggle melee will toggle lock weapon on and off.
            -- This basically locks the slots that will cause you to lose TP if changing them,
            -- As well as equip your melee set if you're engaged
			if commandArgs[2] == 'melee' then
                meleeing:cycle()
                lockMainHand(meleeing.value)
            
			-- toggle runspeed lock
            elseif commandArgs[2] == 'runspeed' then
                runspeed:cycle()
                updateRunspeedGear(runspeed.value, runspeedslot)
			
			-- cycles through your available idle modes
            elseif commandArgs[2] == 'idlemode' then
                idleModes:cycle()			
			-- cycles through your available "Engaged" modes
            elseif commandArgs[2] == 'meleemode' then
                meleeModes:cycle() 
			elseif commandArgs[2] == 'enmity' then
                enmityModes:cycle()       
			end		
		
		elseif commandArgs[1] == 'dnc' then
			if commandArgs[2] == 'voke' then
				handle_voke()
				
			end
		end
    end
	
	--validateTextInformation()
	idle()
end

--------------------------------------------------------------------------------------------------------------
------------------------------------------ Select Default Macro Book -----------------------------------------
--------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'WAR' then
        set_macros(2, 29)
    elseif player.sub_job == 'NIN' then
        set_macros(5, 29)
    elseif player.sub_job == 'SAM' then
        set_macros(8, 29)
    else
        set_macro_page(2, 2)
    end
end