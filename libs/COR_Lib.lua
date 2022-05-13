version = "3.0"
pName = player.name

-- Saying hello
windower.add_to_chat(8,'----- Welcome back to your COR.lua, '..pName..' -----')

runspeedslot = 'legs'


--------------------------------------------------------------------------------------------------------------
------------------------------------------------ HUD STUFF ---------------------------------------------------
--------------------------------------------------------------------------------------------------------------

meleeing = M('AUTO', 'OFF', 'ON')
lock = M('OFF', 'ON')
mBurst = M(false)
runspeed = M('OFF', 'ON')
oldElement = elements.current
mBurstOldValue = mBurst.value
matchsc = M('OFF', 'AUTO', 'ON')
MB_Window = 0   
time_start = 0

setupTextWindow()

-- Called every time we gain or lose a buff.
function buff_change(buff,gain)
    if buff == "Doom" then
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
        --send_command('input /item "Echo Drops" <me>')     
        add_to_chat(8, '****** ['..spell.name..' CANCELED - Use Echo Drops] ******')
        return        
    end   
	
	-- If sneak is active when using, cancel before completion
	if spell.name == 'Spectral Jig' and buffactive.sneak then
        
		windower.ffxi.cancel_buff(71)
    end
	
	if spell.english == 'Fold' and buffactive['Bust'] == 2 then
        if sets.precast.FoldDoubleBust then
            equip(sets.precast.FoldDoubleBust)
            
        end
    end
	
	-- CorsairRoll. Our bread and butter
	if (spell.type == 'CorsairRoll' or spell.english == "Double-Up") then
       
		if sets.precast.CorsairRoll[spell.name] then
			equip(sets.precast.CorsairRoll[spell.name])        
		else
						
			equip(sets.precast.CorsairRoll.Duration)
        end
        if luzafMode.value == 'ON' then
            equip(sets.precast.LuzafRing)
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
	
	-- Ranged Attack
	if spell.action_type == 'Ranged Attack' then
        equip(sets.precast.RA)
		special_ammo_check()
        
    elseif spell.type == 'WeaponSkill' then
        if spell.skill == 'Marksmanship' then
            special_ammo_check()
        end
        
		-- Replace TP-bonus gear if not needed.
		if elemental_ws:contains(spell.name) then
			-- Matching double weather (w/o day conflict).
			if spell.element == world.weather_element and (get_weather_intensity() == 2 and spell.element ~= element.weak_to[world.day_element]) then
				equip({waist="Hachirin-no-Obi"})
				-- Matching day and weather.
			elseif spell.element == world.day_element and spell.element == world.weather_element then
				equip({waist="Hachirin-no-Obi"})
			-- Match day or weather.
            elseif spell.element == world.day_element or spell.element == world.weather_element then
                equip({waist="Hachirin-no-Obi"})
            end
        end
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
    if spell.type == 'CorsairShot' then
		--We always want light and dark shots to have the best acc possible since they do no dmg anyway. 
		if(spell.english == 'Light Shot' or spell.english == 'Dark Shot') then
			equip(sets.midcast['CorsairShot'].ACC)
		else
			equip(sets.midcast['CorsairShot'][quickDrawModes.value])
		end
	    
		if (spell.english ~= 'Light Shot' and spell.english ~= 'Dark Shot') then
            -- Matching double weather (w/o day conflict).
            if spell.element == world.weather_element and (get_weather_intensity() == 2 and spell.element ~= elements.weak_to[world.day_element]) then
                equip({waist="Hachirin-no-Obi"})
            
            -- Matching day and weather.
            elseif spell.element == world.day_element and spell.element == world.weather_element then
                equip({waist="Hachirin-no-Obi"})
            
            -- Match day or weather.
            elseif spell.element == world.day_element or spell.element == world.weather_element then
                equip({waist="Hachirin-no-Obi"})
            end
        end
	end	
    
	if spell.action_type == 'Ranged Attack' then
        if buffactive['Triple Shot'] then
            equip(set_combine(sets.midcast.RA[rangedModes.current],sets.TripleShot))
            if buffactive['Aftermath: Lv.3'] and player.equipment.ranged == "Armageddon" then
                equip(sets.TripleShotCritical)
            end
		else
			equip(sets.midcast.RA[rangedModes.current])		
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
    
	if (not player.status) then
		return
    elseif player.status == 'Engaged' then -- We're engaged. Weapons out in a hostile manner
	
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
-------------------------------------------- Special Ammo Check ----------------------------------------------
--------------------------------------------------------------------------------------------------------------

-- Stop if Animikii/Hauksbok equipped
function special_ammo_check()
    
    if no_shoot_ammo:contains(player.equipment.ammo) then
        cancel_spell()
		add_to_chat(123, '** Action Canceled: [ '.. player.equipment.ammo .. ' equipped!! ] **')
        return
    end
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
				
			elseif commandArgs[2] == 'ranged' then
                rangedModes:cycle()                 
			
			elseif commandArgs[2] == 'luzaf' then
                luzafMode:cycle()
			elseif commandArgs[2] == 'matchsc' then
                matchsc:cycle()                               
                validateTextInformation()
			end	
		
		elseif commandArgs[1] == 'dnc' then
			if commandArgs[2] == 'voke' then
				handle_voke()
				
			end
		elseif commandArgs[1] == 'roll1' then --handle cycling of roll_1
			if not commandArgs[2] then
				windower.add_to_chat(123, 'Not a valid command dummy')
				return
			end
			local arg2 = commandArgs[2]:lower()
			
			if arg2 == 'cycle' then
				roll_1:cycle()
			elseif arg2 == 'cycledown' then
				roll_1:cycleback()
			elseif arg2 == 'roll' then
				send_command('@input /ja "'..roll_1.current..'"')
			end
		elseif commandArgs[1] == 'roll2' then --handle cycleing of roll_2
			if not commandArgs[2] then
				windower.add_to_chat(123, 'Not a valid command dummy')
				return
			end
			
			local arg2 = commandArgs[2]:lower()
			
			if arg2 == 'cycle' then
				roll_2:cycle()
			elseif arg2 == 'cycledown' then
				roll_2:cycleback()
			elseif arg2 == 'roll' then
				send_command('@input /ja "'..roll_2.current..'"')
			end
		elseif commandArgs[1] == 'qd' then
			if not commandArgs[2] then
				windower.add_to_chat(123, 'Not a valid command dummy')
				return
			end
			
			local arg2 = commandArgs[2]:lower()
			
			if arg2 == 'mode' then
				quickDrawModes:cycle()
			elseif (arg2 == 'cycle' or arg2 == 'cycledown') then
				if arg2 == 'cycle' then
					elements:cycle()
					 oldElement = elements.current
				elseif arg2 == 'cycledown' then
					elements:cycleback()
					 oldElement = elements.current
				end
			elseif arg2 == 'shoot' then
				send_command('@input /ja "'..quickdraw[elements.current]..'"')
			end
			
		end
    end
	
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