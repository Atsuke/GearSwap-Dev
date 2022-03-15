version = "3.0"
pName = player.name

-- Saying hello
windower.add_to_chat(8,'----- Welcome back to your NIN.lua, '..pName..' -----')

runspeedslot = 'feet'

--------------------------------------------------------------------------------------------------------------
------------------------------------------------ HUD STUFF ---------------------------------------------------
--------------------------------------------------------------------------------------------------------------

meleeing = M('AUTO', 'OFF', 'ON')
lock = M('OFF', 'ON')
mBurst = M(false)
runspeed = M('OFF', 'ON')
oldElement = ninElements.current
mBurstOldValue = mBurst.value
matchsc = M('AUTO', 'OFF', 'ON')
MB_Window = 0   
time_start = 0

setupTextWindow()


--validateTextInformation()

-- Called every time we gain or lose a buff.
function buff_change(buff,gain)
    
end

--------------------------------------------------------------------------------------------------------------
----------------------------------------------- Pre Cast -----------------------------------------------------
--------------------------------------------------------------------------------------------------------------

--called before every action

function precast(spell)
	local spellMap = get_spell_map(spell)
    local spell_recasts = windower.ffxi.get_spell_recasts()

    -- Detect Silence and yell at you to use echo drops.    
    if spell.action_type == 'ninjutsu' and buffactive['Silence'] then 
        cancel_spell()
        --send_command('input /item "Echo Drops" <me>')     
        add_to_chat(8, '****** ['..spell.name..' CANCELED - Use Echo Drops] ******')
        return        
    end   
	
	if spell.skill == 'Ninjutsu' then
		--Catchall for the various Utsusem Spells
		if spell.name:contains('Utsusemi') then
			equip(sets.precast['Utsusemi'])
		
		else
			equip(sets.precast.casting)
		end
	end
	
	-- If sneak is active when using, cancel before completion
	if spell.name == 'Spectral Jig' and buffactive.sneak then
        
		windower.ffxi.cancel_buff(71)
    end 
	
	-- Waltzes that heal us is a different set than waltzes for others
	if spell.type == 'Waltz' and spell.target.type == 'SELF' then
        equip(sets.precast.WaltzSelf)
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
	local spellMap = get_spell_map(spell)
    
		if spell.name:contains('Utsusemi') then
			equip(sets.midcast['Utsusemi'][enmityModes.current])
		end
	
	if spell.skill == 'Ninjutsu' then
		if spellMap == 'ElementalNinjutsu' then
			if mBurst.value == true then
				equip(sets.midcast.MB[nukeModes.current])
			else
				equip(sets.midcast.nuking[nukeModes.current])
			end
		elseif spellMap == 'EnfeeblingNinjutsu' then
				equip(sets.midcast.enfeeble)
		end
	end
	
	if sets.midcast[spell.name] then
       	equip(sets.midcast[spell.name])
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
	if player.status == 'Engaged' then -- We're engaged. Weapons out in a hostile manner
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
	    add_to_chat(8, '****** ['..spell..' CANCELED - Provoke on Cooldown] ******')
	else --Provoke was ready. Woohoo! Lets poke the angry monster
		send_command('@input /ja "'..spell..'"')
	end
	
	elseif player.sub_job == "DNC" then
		spell = 'Animated Flourish'
		if ((buffactive[381] or buffactive[382] or buffactive[383] or buffactive[384] or buffactive[385] or buffactive[588]) and ability_recasts[221] == 0) then
				send_command('@input /ja "'..spell..'"') --We had finishing moves. Yay! Lets make the monster mad at us.
		else
			add_to_chat(8, '****** ['..spell..' CANCELED - Animated Flourish on Cooldown.] ******') -- No dice on Animated Flourish either.
		end   
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
			
			elseif commandArgs[2] == 'mb' then
                -- //gs c toggle mb will toggle mb mode on and off.
                -- You need to toggle prioritisation yourself
                mBurst:toggle()
                updateMB(mBurst.value)
			
			-- cycles through your available idle modes
            elseif commandArgs[2] == 'idlemode' then
                idleModes:cycle()
              
			-- cycles through your available "Engaged" modes
            elseif commandArgs[2] == 'meleemode' then
                meleeModes:cycle()                 
				
			elseif commandArgs[2] == 'enmity' then
                enmityModes:cycle() 
			elseif commandArgs[2] == 'nukemode' then
                nukeModes:cycle() 
			elseif commandArgs[2] == 'matchsc' then
                matchsc:cycle()                                
			end		
		
		elseif commandArgs[1] == 'dnc' then
			if commandArgs[2] == 'voke' then
				handle_voke()	
			end

        elseif commandArgs[1]:lower() == 'nuke' then
            if not commandArgs[2] then
                windower.add_to_chat(123,'No element type given.')
                return
            end
            
            local nuke = commandArgs[2]:lower()
            
            if (nuke == 'cycle' or nuke == 'cycledown') then
                if nuke == 'cycle' then
                    ninElements:cycle()
                    oldElement = ninElements.current
                elseif nuke == 'cycledown' then 
                    ninElements:cycleback() 
                    oldElement = ninElements.current
					
                end         

            elseif (nuke == 'air' or nuke == 'ice' or nuke == 'fire' or nuke == 'water' or nuke == 'lightning' or nuke == 'earth') then
                local newType = commandArgs[2]
                ninElements:set(newType)
            elseif not ninjaNukes[nuke] then
                windower.add_to_chat(123,'Unknown element type: '..tostring(commandArgs[2]))
                return              
            else        
                -- Leave out target; let Shortcuts auto-determine it.
                send_command('@input /ma "'..ninjaNukes[nuke][ninElements.current]..'"')     
            end
		
		end		
		
    end
	idle()
	validateTextInformation()
	
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