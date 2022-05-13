version = "3.0"
pName = player.name

-- Saying hello
windower.add_to_chat(8,'----- Welcome back to your BST.lua, '..pName..' -----')

runspeedslot = 'feet'

--------------------------------------------------------------------------------------------------------------
-- HUD STUFF
--------------------------------------------------------------------------------------------------------------
wantedSc = tier1sc[elements.current]
scTier2 = M(false)
meleeing = M('AUTO', 'OFF', 'ON')
lock = M('OFF', 'ON')
mBurst = M(false)
runspeed = M('OFF', 'ON')
--autoRunState = M('OFF', 'ON', 'AUTO'
oldElement = elements.current
mBurstOldValue = mBurst.value
matchsc = M('AUTO', 'ON','OFF')
MB_Window = 0   
time_start = 0
autoConvert = true


petMode = 'me'
Master_State = "Idle"
Pet_State = "Idle"
Hybrid_State = "Idle"

setupTextWindow()


function buff_change(name,gain,buff_details)
    
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

function precast(spell)
	if (pet.isvalid and pet_midaction() and not spell.type == "Monster") or spell.type == "Item" then
		return
	end
	
    local spell_recasts = windower.ffxi.get_spell_recasts()
	local ability_recasts = windower.ffxi.get_ability_recasts()
	
	if meleeing.value == "AUTO" then
        if player.tp >= lockWeaponTP then
            lock:set('ON')
        else
            lock:set('OFF')
        end
        lockMainHand(lock.value, pet)
    end
	
	
    -- Dont like automatically using echo drops so instead we alert you to being silenced --    
    if spell.action_type == 'Magic' and buffactive['Silence'] then 
        cancel_spell()
        --send_command('input /item "Echo Drops" <me>')     
        add_to_chat(8, '****** ['..spell.name..' CANCELED - Use Echo Drops] ******')
        return        
    end       
	
	-- Don't swap if we're in the middle of something or our pet's doing something
    -- Stops macro spam from interfering with an action GS is already handling
	if midaction() or pet_midaction() then
        return
    end
    
	-- Cancel call beast so we dont waste HQ jugs.
	if spell.name == 'Call Beast' and call_beast_cancel:contains(player.equipment.ammo) then
		cancel_spell()
		add_to_chat(123, spell.name..' Canceled: [HQ Jug Pet]')
	end
		 
	-- Dont swap to precast if using Unleash.
	if (spell.type == 'Monster' and not buffactive['Unleash']) then
     
        equip(sets.precast.Ready)
		
	end
	
	-- Waltzes that heal us is a different set than waltzes for others
	if spell.type == 'Waltz' then
		if  spell.target.type == 'SELF' then
			equip(sets.precast.WaltzSelf)
		else
			equip(sets.precast.Waltz)
		end
    end   
	
	if spell.action_type  == 'Magic' and spell_recasts[spell.recast_id] > 0 then
        cancel_spell()
        downgradenuke(spell)
        add_to_chat(8, '****** ['..spell.name..' CANCELED - Spell on Cooldown] ******')
        return
    end    

    -- Moving on to other types of magic
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
    
	-- Job Abilities
    -- We use a catch all here, if the set exists for an ability, use it
    -- This way we don't need to write a load of different code for different abilities, just make a set
    
	--If Killer Instinct is active during WS (except for Primal/Cloudsplitter where Sacro Body is superior), equip Nukumi Gausape +1.
    if spell.type:lower() == 'weaponskill' and buffactive['Killer Instinct'] then
        if spell.english ~= "Primal Rend" and spell.english ~= "Cloudsplitter" then
            equip(sets.buff['Killer Instinct'])
        end
    end
	
	if enmity_plus_moves:contains(spell.english) and enmityModes.current == 'Enmity' then
		equip(sets.Enmity)
	end
		
    if sets.precast[spell.name] then
        equip(sets.precast[spell.name])        
    end
    
end

--------------------------------------------------------------------------------------------------------------
----------------------------------------------- Mid Cast -----------------------------------------------------
--------------------------------------------------------------------------------------------------------------

function midcast(spell)
    
	if (pet.isvalid and pet_midaction() and not spell.type == "Monster") or spell.type == "Item" then
		return
	end
	
	-- Get the spell mapping, since we'll be passing it to various functions and checks.
    local spellMap = get_spell_map(spell)    
    
	-- No need to annotate all this, it's fairly logical. Just equips the relevant sets for the relevant magic
    if spell.name:match('Cure') or spell.name:match('Cura') then
        if spell.element == world.weather_element or spell.element == world.day_element then
            equip(sets.midcast.cure.weather)
        else
            equip(sets.midcast.cure.normal)
        end
    
	elseif spell.skill == 'Enfeebling Magic' and spell.type == 'BlackMagic' then -- to do: better rule for this.
        equip(sets.midcast.IntEnfeebling)
    
	elseif spell.skill == 'Enfeebling Magic' and spell.type == 'WhiteMagic' then -- to do: better rule for this.
        equip(sets.midcast.MndEnfeebling)
    
	elseif spell.type == 'BlackMagic' then
    
		if mBurst.value == true then
            equip(sets.midcast.MB[nukeModes.current])
        else
            equip(sets.midcast.nuking[nukeModes.current])
        end
    else
        equip(sets.midcast.casting)
    end
    
	-- And our catch all, if a set exists for this spell name, use it
    if sets.midcast[spell.name] then
        equip(sets.midcast[spell.name])
    
	-- Catch all for tiered spells (use mapping), basically if no set for spell name, check set for spell mapping. AKA Drain works for all Drain tiers.
    elseif sets.midcast[spellMap] then
        equip(sets.midcast[spellMap])
    
	-- Remember those WS Sets we defined? :) sets.me["Insert Weaponskill"] are basically how I define any non-magic spells sets, aka, WS, JA, Idles, etc.
    elseif sets.me[spell.name] then
        equip(sets.me[spell.name])
    end
	
	if TH_Actions:contains(spell.name) and treasureHunter.current == 'ON' then
		equip(sets.TH)
	end
	
end
 
--------------------------------------------------------------------------------------------------------------
--------------------------------------------- Pet Mid Cast ---------------------------------------------------
--------------------------------------------------------------------------------------------------------------
 
 function pet_midcast(spell)
 
    -- Our pet is doing something
	for category,spell_list in pairs(ready_moves) do
		if spell_list:contains(spell.english) then
			equip(sets.pet[category])
			break -- exit the loop or you're gonna have a bad time.
		end
	end
end

function AFAC_Helper(spell)
	
	send_command('input /ja "'..temp_spell..'" <t>;')
end
 



--------------------------------------------------------------------------------------------------------------
----------------------------------------------- After Cast ---------------------------------------------------
--------------------------------------------------------------------------------------------------------------
 
function aftercast(spell) 
    
	if pet_midaction() or spell.type == "Item" then
		return
	end
	
    idle(pet)
end

function pet_aftercast(spell)
     
    idle(pet)
end

--------------------------------------------------------------------------------------------------------------
------------------------------------------------ Pet Change --------------------------------------------------
--------------------------------------------------------------------------------------------------------------

function pet_change(pet, gain)
    if (not (gain and pet_midaction())) then
		-- When cast a summon
	end
	idle(pet)
	
end


--------------------------------------------------------------------------------------------------------------
--------------------------------------------------- Idle -----------------------------------------------------
--------------------------------------------------------------------------------------------------------------

function idle(pet)
    -- This function is called after every action, and handles which set to equip depending on what we're doing
    -- We check if we're meleeing because we don't want to idle in melee gear when we're only engaged for trusts
	
	-- trying to check player status when zoning was throwing errors due to there not being a player status to check. If no status we wait until there is.
	if (not player.status) then
		return
	elseif pet.isvalid then --We have a pet out.
        petMode = 'pet'	
    else -- We dont have a pet out
		currentRage = ''
		currentWard = ''
        petMode = 'me' 
   
	end
	equip(customizeSet())
	validateTextInformation()
	
end

--------------------------------------------------------------------------------------------------------------
----------------------------------------------- Status Change ------------------------------------------------
--------------------------------------------------------------------------------------------------------------

function status_change(new,old)
    if new == 'Engaged' then  
        -- If we engage check our meleeing status
		Master_State = new
        idle(pet)
         
    elseif new == 'Resting' then
     
        -- We're resting
        equip(sets.me.resting)          
    else
        idle(pet)
    end
	
end

function pet_status_change(new, old)
	--Just let our idle function deal with it.
	if pet.status then
		Pet_State = new
	end
	idle(pet)
   
   
end


--------------------------------------------------------------------------------------------------------------
---------------------------------------------- Customize Set -------------------------------------------------
--------------------------------------------------------------------------------------------------------------

function customizeSet()
	local Custom_Set = sets.me.Engaged
	
	if (player.status == 'Idle' or player.status == '') and player.hp > 0 then -- Player is alive but not doing anything
		
		if petMode == 'me' then -- No Pet
			Custom_Set = sets.me[idleModes.value]
			Hybrid_State = 'Idle'
		
		elseif(petMode == 'pet' and Pet_State == 'Engaged') then -- We have a pet and it is engaged
			
			if idleModes.current == 'Regen' then
				Custom_Set = sets.me.Regen
				Hybrid_State = 'Master'
			elseif idleModes.current == 'Pet' then
				Custom_Set = sets.pet[petModes.value]
				Hybrid_State = 'Pet Only'
			elseif idleModes.current == 'DT' then -- priority given to Master DT
				Hybrid_State = 'Master + Pet'
				if petModes.current == 'TP' then
					Custom_Set = set_combine(sets.pet.TP, sets.me.DT)
				elseif petModes.current == 'DT' then
					Custom_Set = set_combine(sets.pet.DT, sets.me.DT)
				end
			end		
		elseif(petMode == 'pet' and Pet_State == 'Idle') then
			-- if idleModes.value == 'Pet' then
				-- Custom_Set = set_combine(sets.me[idleModes.value], sets.pet[petModes.value])	
			-- else
				Custom_Set = sets.me[idleModes.current] 
			-- end
		end
		
	elseif (player.status == "Engaged" and player.hp > 0) then
		
		if PetMode == 'me' then -- Seriously why are you engaged without a pet? You are a pet job dummy and a squishy one at that. 
			Custom_Set = sets.me.Engaged --You are so screwed. Good luck!
			Hybrid_State = 'Master'
		elseif(petMode == 'pet') then --No need to check pet state. It will engage as soon as you have aggro. Good pet.
			
			if meleeModes.current == 'Pet' then -- Priority given to pet 
				Custom_Set = sets.pet[petModes.value]
				Hybrid_State = 'Pet'
			elseif meleeModes.current == 'TP' then -- priority given to master
				if petModes.current == 'TP' then
					Hybrid_State = 'Master + Pet'
					Custom_Set = sets.MasterPet.TP
				elseif petModes.current == 'DT' then
					Custom_Set = set_combine(sets.MasterPet.TP, sets.pet.DT)
				end
			elseif meleeModes.current == 'DT' then -- priority given to master
				if petModes.current == 'TP' then
					Hybrid_State = 'Master + Pet'
					Custom_Set = set_combine(sets.MasterPet.TP, sets.me.DT) -- 
				elseif petModes.current == 'DT' then
					Custom_Set = set_combine(sets.MasterPet.TP, sets.me.DT, sets.pet.DT) 
				end
				
			end
		
		end
	
	end
	
	return Custom_Set

end

--------------------------------------------------------------------------------------------------------------
---------------------------------------------- Self Command --------------------------------------------------
--------------------------------------------------------------------------------------------------------------

function self_command(command)
    hud_command(command)
    local commandArgs = command
     
    if #commandArgs:split(' ') >= 2 then
        commandArgs = T(commandArgs:split(' '))
        
        if commandArgs[1] == 'toggle' then
            if commandArgs[2] == 'melee' then
                -- //gs c toggle melee will toggle melee mode on and off.
                -- This basically locks the slots that will cause you to lose TP if changing them,
                -- As well as equip your melee set if you're engaged
                meleeing:cycle()
                lockMainHand(meleeing.value, pet)

            elseif commandArgs[2] == 'mb' then
                -- //gs c toggle mb will toggle mb mode on and off.
                -- You need to toggle prioritisation yourself
                mBurst:toggle()
                updateMB(mBurst.value)
            elseif commandArgs[2] == 'runspeed' then
                runspeed:cycle()
                
				updateRunspeedGear(runspeed.value, runspeedslot, pet)
				
            elseif commandArgs[2] == 'idlemode' then
                idleModes:cycle()
            elseif commandArgs[2] == 'meleemode' then
                meleeModes:cycle()
				validateTextInformation()
			elseif commandArgs[2] == 'petmode' then
                petModes:cycle()                 
                validateTextInformation() 
			elseif commandArgs[2] == 'autoconvert' then
				convertModes:cycle()
            elseif commandArgs[2] == 'thMode' then
                treasureHunter:cycle()
			elseif commandArgs[2] == 'enmity' then
                enmityModes:cycle()     			
			end
        
        elseif commandArgs[1]:lower() == 'nuke' then
            if not commandArgs[2] then
                windower.add_to_chat(123,'No element type given.')
                return
            end
            
            local nuke = commandArgs[2]:lower()
            
            if (nuke == 'cycle' or nuke == 'cycledown') then
                if nuke == 'cycle' then
                    elements:cycle()
                    oldElement = elements.current
                elseif nuke == 'cycledown' then 
                    elements:cycleback() 
                    oldElement = elements.current
                end         
                updateSC(elements.current, scTier2.value)                    
                validateTextInformation()

            elseif (nuke == 'air' or nuke == 'ice' or nuke == 'fire' or nuke == 'water' or nuke == 'lightning' or nuke == 'earth' or nuke == 'light' or nuke == 'dark') then
                local newType = commandArgs[2]
                elements:set(newType)
                updateSC(elements.current, scTier2.value)                
                validateTextInformation()
            elseif not nukes[nuke] then
                windower.add_to_chat(123,'Unknown element type: '..tostring(commandArgs[2]))
                return              
            else        
                -- Leave out target; let Shortcuts auto-determine it.
                send_command('@input /ma "'..nukes[nuke][elements.current]..'"')     
            end
        
		elseif commandArgs[1]:lower() == 'sc' then
            if not commandArgs[2] then
                windower.add_to_chat(123,'No element type given.')
                return
            end
        elseif commandArgs[1] == 'dnc' then
			if commandArgs[2] == 'voke' then
				handle_voke()	
			end
		
		
		end
	end
	idle(pet)
end
