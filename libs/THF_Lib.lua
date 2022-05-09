version = "3.0"
pName = player.name

-- Saying hello
windower.add_to_chat(8,'----- Welcome back to your THF.lua, '..pName..' -----')

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


-- Called every time we gain or lose a buff.
function buff_change(buff,gain)
    
	--Check for SA/TA. Dont want to swap hands or feet if we are using SA/TA to proc TH. 
	if (buff == 'Sneak Attack' and gain) and treasureHunter.current == 'OFF' then
		equip(sets.buff['Sneak Attack'])
	end
	
	if (buff == 'Trick Attack' and gain) and treasureHunter.current == 'OFF' then
		equip(sets.buff['Trick Attack'])
	end
	
	if buff == "doom" then
        if gain then
            equip(sets.buff.Doom)
            send_command('@input /p Doomed.')
            disable('ring1','ring2','waist', 'neck')
        else
            enable('ring1','ring2','waist', 'neck')
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
        --send_command('input /item "Echo Drops" <me>') -- uncomment this line for auto echo drops.     
        add_to_chat(8, '****** ['..spell.name..' CANCELED - Use Echo Drops] ******')
        return        
    end   
	
	-- If sneak is active when using, cancel before completion
	if spell.name == 'Spectral Jig' and buffactive.sneak then
        
		windower.ffxi.cancel_buff(71)
    end
	
	-- --Check for SA/TA. Dont want to swap hands or feet if we are using SA/TA to proc TH. 
	-- if (buff == 'Sneak Attack' and gain) and treasureHunter.current == 'OFF' then
		-- equip(sets.buff['Sneak Attack'])
	-- end
	
	-- if (buff == 'Trick Attack' and gain) and treasureHunter.current == 'OFF' then
		-- equip(sets.buff['Trick Attack'])
	-- end
	
	-- Waltzes that heal us is a different set than waltzes for others
	if spell.type == 'Waltz' then
		if  spell.target.type == 'SELF' then
			equip(sets.precast.WaltzSelf)
		else
			equip(sets.precast.Waltz)
		end
    end   
	
	-- Ranged Attack
	if spell.action_type == 'Ranged Attack' then
		equip(sets.precast.RA)
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
	
	-- Again we use a catchall here. Unlikely it will be needed since THF doesnt really do Midcast
	if sets.midcast[spell.name] then
        equip(sets.midcast[spell.name])
    end
end

--------------------------------------------------------------------------------------------------------------
----------------------------------------------- After Cast ---------------------------------------------------
--------------------------------------------------------------------------------------------------------------

-- called after each cast. 
-- We just call the idle function as it contains our logic and updates our HUD

function aftercast(spell) 
    idle()
end

--------------------------------------------------------------------------------------------------------------
--------------------------------------------------- Idle -----------------------------------------------------
--------------------------------------------------------------------------------------------------------------

-- This function is called after every action, and handles which set to equip depending on what we're doing

function idle()
    
    if player.status == 'Engaged' then -- We're engaged. Weapons out in a hostile manner
	
		if treasureHunter.current == 'ON' then -- We are engaged and laboring under the delusion that TH works.
			equip(set_combine(sets.engaged[meleeModes.value], sets.TH))
		else
			equip(sets.engaged[meleeModes.value])
		end		
    else
       equip(sets.idle[idleModes.value]) -- currently not engaged.             
	end

	validateTextInformation() -- updates the HUD
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
                --idle()
			
			-- cycles through your available "Engaged" modes
            elseif commandArgs[2] == 'meleemode' then
                meleeModes:cycle()                 
				--idle()
			elseif commandArgs[2] == 'enmity' then
                enmityModes:cycle()                 
				--idle()
			elseif commandArgs[2] == 'thMode' then
                treasureHunter:cycle()
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
-- function select_default_macro_book()
    -- -- Default macro set/book
    -- if player.sub_job == 'WAR' then
        -- set_macros(2, 29)
    -- elseif player.sub_job == 'NIN' then
        -- set_macros(5, 29)
    -- elseif player.sub_job == 'SAM' then
        -- set_macros(8, 29)
    -- else
        -- set_macro_page(2, 2)
    -- end
-- end