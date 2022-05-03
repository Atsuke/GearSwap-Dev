version = "3.0"
pName = player.name

-- Saying hello
windower.add_to_chat(8,'----- Welcome back to your BLU.lua, '..pName..' -----')

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
	
	
end

--------------------------------------------------------------------------------------------------------------
----------------------------------------------- Pre Cast -----------------------------------------------------
--------------------------------------------------------------------------------------------------------------
--called before every action

function precast(spell)

    local spell_recasts = windower.ffxi.get_spell_recasts()
	 
    -- Detect Silence and yell at you to use echo drops.    
    if (spell.action_type == 'ninjutsu' or spell.action_type == 'Blue Magic') and buffactive['Silence'] then 
        cancel_spell()
        --send_command('input /item "Echo Drops" <me>')     
        add_to_chat(8, '****** ['..spell.name..' CANCELED - Use Echo Drops] ******')
        return        
    end   
	
	-- If sneak is active when using, cancel before completion
	if (spell.name == 'Spectral Jig' or spell.name == 'Sneak') and buffactive.sneak then
        
		windower.ffxi.cancel_buff(71)
    end
	
	
	-- Waltzes that heal us is a different set than waltzes for others
	if spell.type == 'Waltz' and spell.target.type == 'SELF' then
        equip(sets.precast.WaltzSelf)
    end   
	
	if spell.type == 'WhiteMagic' or spell.type == 'BlackMagic' then
     
        -- Stoneskin Precast
        if spell.name == 'Stoneskin' then
         
            windower.ffxi.cancel_buff(37)--[[Cancels stoneskin, not delayed incase you get a Quick Cast]]
            equip(sets.precast.stoneskin)
             
        -- Cure Precast
        elseif spell.name:match('Cure') or spell.name:match('Cura') then
         
            equip(sets.precast.cure)         
        -- Enhancing Magic
        elseif spell.skill == 'Magic' then
         
            equip(sets.precast.enhancing)            
            if spell.name == 'Sneak' then
                windower.ffxi.cancel_buff(71)--[[Cancels Sneak]]
            end
        else       
            -- For everything else we go with max fastcast
            equip(sets.precast.casting)                   
        end
    end
	
	if spell.type == 'BlueMagic' then
		equip(sets.precast.Blue_Magic)
	end
	
	if spell.type == 'WeaponSkill' then
        
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
	
	--Catchall for the various Utsusemi Spells
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

	-- Iterate through the spell maps to find current spell and equip appropriate set
	if spell.skill == 'Blue Magic' then
        for category,spell_list in pairs(blue_magic_maps) do
            if spell_list:contains(spell.english) then
                
				equip(sets.midcast['Blue Magic'][category])
				if category == 'Magical' then
					if spell.element == world.weather_element and (get_weather_intensity() == 2 and spell.element ~= elements.weak_to[world.day_element]) then
						equip({waist="Hachirin-no-Obi"})
					end
				end
				
				if category == 'Healing' and spell.target.type == 'SELF' then
					equip(sets.midcast['Blue Magic'].HealingSelf)
				end
				break -- exit the loop or you're gonna have a bad time.
			end
		end
	end
	
	-- Check for normal enhancing magic not dependent on blu skill
	if spell.skill == 'Enhancing Magic' and no_skill_spells_list:contains(spell.english) then
        
		equip(sets.midcast.EnhancingDuration)
		
		if spell.name == 'Refresh' then
            equip(sets.midcast.Refresh)
        end
    end
	
	--Check for active JA's
	if buffactive['Burst Affinity'] then equip(sets.buff['Burst Affinity'])	end
	if buffactive['Efflux'] then equip(sets.buff['Efflux']) end
	if buffactive['Diffusion'] then equip(sets.buff['Diffusion']) end
	if buffactive['Burst Affinity'] then equip(sets.midcast.Magic_Burst) end
	
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
				
			-- cycles through your available idle modes
            elseif commandArgs[2] == 'idlemode' then
                idleModes:cycle()
			
			-- cycles through your available "Engaged" modes
            elseif commandArgs[2] == 'meleemode' then
                meleeModes:cycle()                 
				
			elseif commandArgs[2] == 'ranged' then
                rangedModes:cycle()                 
			
			elseif commandArgs[2] == 'matchsc' then
                matchsc:cycle()                               
                validateTextInformation()
			end	
		
		elseif commandArgs[1] == 'dnc' then
			if commandArgs[2] == 'voke' then
				handle_voke()
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