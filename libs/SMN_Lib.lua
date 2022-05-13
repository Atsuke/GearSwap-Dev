version = "3.0"
pName = player.name

-- Saying hello
windower.add_to_chat(8,'----- Welcome back to your SMN.lua, '..pName..' -----')

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
oldAvatar = avatars.current
currentRage = ''
currentWard = ''
mBurstOldValue = mBurst.value
matchsc = M('AUTO', 'ON','OFF')
MB_Window = 0   
time_start = 0
autoConvert = true
autobp = true
temp_spell = ''


petMode = 'me'
Master_State = "Idle"
Pet_State = "Idle"
Hybrid_State = "Idle"

setupTextWindow()

Buff = 
    {
        ['Ebullience'] = false, 
        ['Rapture'] = false, 
        ['Perpetuance'] = false,
        ['Immanence'] = false,
        ['Penury'] = false,
        ['Parsimony'] = false,
        ['Celerity'] = false,
        ['Alacrity'] = false,
        ['Klimaform'] = false,
        ['Sublimation: Activated'] = false
    }
    
-- Reset the state vars tracking strategems.
function update_active_strategems(name, gain)
    Buff['Ebullience'] = buffactive['Ebullience'] or false
    Buff['Rapture'] = buffactive['Rapture'] or false
    Buff['Perpetuance'] = buffactive['Perpetuance'] or false
    Buff['Immanence'] = buffactive['Immanence'] or false
    Buff['Penury'] = buffactive['Penury'] or false
    Buff['Parsimony'] = buffactive['Parsimony'] or false
    Buff['Celerity'] = buffactive['Celerity'] or false
    Buff['Alacrity'] = buffactive['Alacrity'] or false
    Buff['Klimaform'] = buffactive['Klimaform'] or false
end

-- function update_sublimation()
    -- Buff['Sublimation: Activated'] = buffactive['Sublimation: Activated'] or false
    -- if Buff['Sublimation: Activated'] then
        -- refreshType = "sublimation"
    -- else
        -- refreshType = "refresh"
    -- end
    -- if midaction() then
        -- return
    -- else
        -- idle(pet)
    -- end
-- end

function buff_refresh(name,buff_details)
    -- Update SCH statagems when a buff refreshes.
    update_active_strategems()
    --update_sublimation()
    validateTextInformation()
end

function buff_change(name,gain,buff_details)
    -- Update SCH statagems when a buff is gained or lost.
    update_active_strategems()
    --update_sublimation()
	if buff == "Doom" then
        if gain then
            equip(sets.buff.Doom)
            send_command('@input /p Doomed.')
            disable('ring1','ring2','waist', 'neck')
        else
            enable('ring1','ring2','waist', 'neck')
			
        end
    end
	idle(pet)
    --validateTextInformation()
end

--------------------------------------------------------------------------------------------------------------
----------------------------------------------- Pre Cast -----------------------------------------------------
--------------------------------------------------------------------------------------------------------------

function precast(spell)
	if (pet.isvalid and pet_midaction() and not spell.type == "SummonerPact") or spell.type == "Item" then
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
    
	-- Dont swap to precast if conduit of apogee are up.
	if (spell.type == 'BloodPactRage' or spell.type == 'BloodPactWard') and not (buffactive['Astral Conduit'] or buffactive['Apogee']) then
     
        equip(sets.precast.bp)
		
		if bpModes.value == "AUTO" and buffactive['Astral Flow'] then
			
			local temp = spell.name
			if ability_recasts[108] == 0 then
				cancel_spell()
				send_command('input /ja Apogee <me>; wait 1; input /ja "'..temp..'" <t>; wait 1; input /ja "'..temp..'" <t>; wait 1; input /ja "Astral Conduit" <me>; wait 1; input /ja "'..temp..'" <t>;')
				
			else
				send_command('input /ja "Astral Conduit" <me>; wait 1; input /ja "'..temp..'" <t>;')
			end
		end
	end
	
	-- conduit or apogee are up.
	-- autoconvert logic
	
	if (spell.type == 'BloodPactRage' or spell.type == 'BloodPactWard') and player.sub_job == 'RDM' and convertModes.current == 'AUTO' then -- Verifys you have the appropriate sub
		if spell.mp_cost > player.mp and ability_recasts[49] == 0 then
			local temp = spell.name
			cancel_spell()
			send_command('input /ja "Convert" <me>; wait 1; input /ja "'..temp..'" <t>')
				
		end
	end
	
	if spell.action_type  == 'Magic' and spell_recasts[spell.recast_id] > 0 then
        cancel_spell()
        downgradenuke(spell)
        add_to_chat(8, '****** ['..spell.name..' CANCELED - Spell on Cooldown, Downgrading spell] ******')
        return
    end    

    -- Moving on to other types of magic
    if spell.type == 'WhiteMagic' or spell.type == 'BlackMagic' or spell.type == 'SummonerPact' then
     
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
		-- Summoning magic is called SummonerPact by windower for some reason. This is misleading. This line if for pet summoning specific FC. 	
		elseif spell.type == 'SummonerPact' then
            equip(sets.precast.summoning)
        else       
            -- For everything else we go with max fastcast
            equip(sets.precast.casting)                   
        end
    end
    
	-- Job Abilities
    -- We use a catch all here, if the set exists for an ability, use it
    -- This way we don't need to write a load of different code for different abilities, just make a set
     
    if sets.precast[spell.name] then
        equip(sets.precast[spell.name])        
    end
    -- extends Fast cast set with Grimoire recast aligned 
    if buffactive['addendum: black'] or buffactive['dark arts'] then
        if spell.type == 'BlackMagic' then
            equip(sets.precast.grimoire)            
        end
    
	elseif buffactive['addendum: white'] or buffactive['light arts'] then
        if spell.type == 'WhiteMagic' then
            equip(sets.precast.grimoire)            
        end
    end
end

--------------------------------------------------------------------------------------------------------------
----------------------------------------------- Mid Cast -----------------------------------------------------
--------------------------------------------------------------------------------------------------------------

function midcast(spell)
    
	if (pet.isvalid and pet_midaction() and not spell.type == "SummonerPact") or spell.type == "Item" then
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
    elseif spell.skill == 'Enhancing Magic' then
       
		equip(sets.midcast.enhancing)
        
		if spellMap == 'Storm' then
            equip(sets.midcast.storm)
        elseif spell.name:match('Protect') or spell.name:match('Shell') then
            equip({right_ring = "Sheltered Ring"})
        elseif spell.name:match('Refresh') then
            equip(sets.midcast.refresh)
        elseif spell.name:match('Regen') then
            equip(sets.midcast.regen.hybrid)
        elseif spell.name:match('Aquaveil') then
            equip(sets.midcast.aquaveil)
        elseif spell.name:match('Stoneskin') then
            equip(sets.midcast.stoneskin)
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
    
    end
    
    -- Dark based Helix gets "pixie hairpin +1"
    if spellMap == 'DarkHelix'then
        equip(sets.midcast.DarkHelix)
    end
    if spellMap == 'Helix' then
        equip(sets.midcast.Helix)
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
    if (spell.type == 'BloodPactRage' or spell.type == 'BloodPactWard') then
     
        -- We're going to check the lists in global.lua for matches and equip the relevant sets
         
        if bp_physical:contains(spell.name) then
         
            equip(sets.avatar.atk)
             
        elseif bp_hybrid:contains(spell.name) then
         
            equip(sets.avatar.hybrid)
            if pet.name == 'Ifrit' then
                equip({rring="Fervor Ring"})--[[Change rring to lring if you put Evoker's on your right hand]]
            end
             
        elseif bp_magical:contains(spell.name) then
			if mBurst.value == true then
				equip(sets.avatar.MB)
			else
				equip(sets.avatar.mab)
			end
            if pet.name == 'Ifrit' then
                equip({right_ring="Fervor Ring"})--[[Change rring to lring if you put Evoker's on your right hand]]
            end
 
        elseif bp_debuff:contains(spell.name) then
         
            equip(sets.avatar.macc)
             
        elseif bp_buff:contains(spell.name) then
         
            equip(sets.avatar.buff)
             
        elseif spell.name == 'Perfect Defense' then
         
            equip(sets.avatar.skill)
             
        else
         
            equip(sets.avatar.skill)
             
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
	
	-- Then initiate idle function to check which set should be equipped
    if not (spell.type == 'BloodPactRage' or spell.type == 'BloodPactWard') then
	
	update_active_strategems()
        
	end
	idle(pet)
end

function pet_aftercast(spell)
	
	-- Pet aftercast is simply a check for whether Conduit and Apogee are up, and then a call to our aftercast function
    -- We have a variable called autobp that we set to true or false with commands to auto repeat BPs for us
    if (buffactive['Apogee'] or buffactive['Astral Conduit']) and bpModes.current == 'AUTO' then
        -- temp_spell = spell.name
		-- coroutine.schedule(AFAC_Helper, 1)
		send_command('input /ja "%s" <t>':format(spell.name))
        --return	
    end
     
    idle(pet)
end

--------------------------------------------------------------------------------------------------------------
------------------------------------------------ Pet Change --------------------------------------------------
--------------------------------------------------------------------------------------------------------------

function pet_change(pet, gain)
    if (not (gain and pet_midaction())) then
		-- When cast a summon
	end
	if gain then
		set_defaultBP()
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
        petMode = 'avatar'	
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
                 
    elseif new == 'Resting' then
     
        -- We're resting
        equip(sets.me.resting)          
    else
       
    end
	 idle(pet)
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
		
		elseif(petMode == 'avatar' and Pet_State == 'Engaged') then -- We have a pet and it is engaged
			
			if idleModes.current == 'Refresh' then --Most refresh while maintaining free avatar
				Custom_Set = sets.avatar.perp
				Hybrid_State = 'Perpetuation'
			elseif idleModes.current == 'Pet' then
				Custom_Set = sets.avatar[petModes.value]
				Hybrid_State = 'Pet Only'
			elseif idleModes.current == 'DT' then -- priority given to Master DT
				Hybrid_State = 'Master + Pet'
				if petModes.current == 'TP' then
					Custom_Set = set_combine(sets.avatar.TP, sets.me.DT)
				elseif petModes.current == 'DT' then
					Custom_Set = set_combine(sets.avatar.DT, sets.me.DT)
				end
			end		
		elseif(petMode == 'avatar' and Pet_State == 'Idle') then
			Custom_Set = set_combine(sets.avatar.perp, sets.me[idleModes.value])	
		else
			Custom_Set = sets.avatar.perp --Pet is out. It is not engaged. Max refresh gear. 
		end
		
	elseif (player.status == "Engaged" and player.hp > 0) then
		
		if PetMode == 'me' then -- Seriously why are you engaged without a pet? You are a pet job dummy and a squishy one at that. 
			Custom_Set = sets.me.Engaged --You are so screwed. Good luck!
			Hybrid_State = 'Master'
		elseif(petMode == 'avatar') then --No need to check pet state. It will engage as soon as you have aggro. Good avatar.
			
			if meleeModes.current == 'Trust' then -- only engaged for trusts and not actually meleeing 
				Custom_Set = sets.avatar[petModes.value]
				Hybrid_State = 'Pet'
			elseif meleeModes.current == 'TP' then -- priority given to master
				if petModes.current == 'TP' then
					Hybrid_State = 'Master + Pet'
					Custom_Set = sets.MasterPet.TP -- #MeleeSMN4Lyfe!!
				elseif petModes.current == 'DT' then
					Custom_Set = set_combine(sets.MasterPet.TP, sets.avatar.DT)
				end
			elseif meleeModes.current == 'DT' then -- priority given to master
				if petModes.current == 'TP' then
					Hybrid_State = 'Master + Pet'
					Custom_Set = set_combine(sets.MasterPet.TP, sets.me.DT) -- #MeleeSMN4Lyfe!!
				elseif petModes.current == 'DT' then
					Custom_Set = set_combine(sets.MasterPet.TP, sets.me.DT, sets.avatar.DT) 
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
                idle(pet)
                if buffactive['Sublimation: Activated'] then                 
                    --update_sublimation()
                    validateTextInformation()
                -- We don't have sublimation ticking.
                else
                    validateTextInformation()
                end
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
			end		
        end
        
        if commandArgs[1]:lower() == 'scholar' then
            handle_strategems(commandArgs)
		
		
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
          
		-- We want to do Summoner Things
		elseif commandArgs[1]:lower() == 'summoner' then
			if not commandArgs[2] then
				windower.add_to_chat(123,'Gotta tell me what you want dipshit.')
				return
			end	
			
			local cmd = commandArgs[2]:lower() --capture the next arguement
			
			if (cmd == 'cycle' or cmd == 'cycledown') then
				if cmd == 'cycle' then
					avatars:cycle()
					oldAvatar = avatars.current
				elseif cmd == 'cycledown' then
					avatars:cycleback()
					oldAvatar = avatars.current
				end
				
			elseif (cmd == 'summon') then
				
				send_command('@input /ma "'..avatars.current..'"')
			
			elseif (cmd == 'cyclerage' or cmd == 'cycleragedown') then
				
				handle_rage_cycle(cmd)

			elseif (cmd == 'cycleward' or cmd == 'cyclewarddown') then
				
				handle_ward_cycle(cmd)
				
			elseif (cmd == 'rage') then
				
				send_command('@input /pet "'..currentRage..'"')
			
			elseif (cmd == 'ward') then
				
				send_command('@input /pet "'..currentWard..'"')
				
			elseif (cmd == 'siphon') then
				handle_siphoning()
			elseif (cmd == 'autobp') then
				bpModes:cycle()
			end
		end
    end
	idle(pet)
	--validateTextInformation()
end

--------------------------------------------------------------------------------------------------------------
-------------------------------------------- Handle Rage Cycle -----------------------------------------------
--------------------------------------------------------------------------------------------------------------

function handle_rage_cycle(cmd)
	if not pet.isvalid then
		return
	else
		--Carby
		if string.find(pet.name,'Carbuncle')then 
			if (cmd == 'cycleragedown') then
				carbuncle_rage:cycleback()
		else
			carbuncle_rage:cycle()
		end
			currentRage = carbuncle_rage.current
		end
	
		--Fenrir
		if string.find(pet.name,'Fenrir')then 
			if (cmd == 'cycleragedown') then
				fenrir_rage:cycleback()
		else
			fenrir_rage:cycle()			
		end
			currentRage = fenrir_rage.current
		end
	
		--Ifrit
		if string.find(pet.name,'Ifrit')then 
			if (cmd == 'cycleragedown') then
				ifrit_rage:cycleback()
		else
			ifrit_rage:cycle()			
		end
			currentRage = ifrit_rage.current
		end
		
		--Titan
		if string.find(pet.name,'Titan')then 
			if (cmd == 'cycleragedown') then
				titan_rage:cycleback()
		else
			titan_rage:cycle()			
		end
			currentRage = titan_rage.current
		end
		
		--Leviathan
		if string.find(pet.name,'Leviathan')then 
			if (cmd == 'cycleragedown') then
				leviathan_rage:cycleback()
		else
			leviathan_rage:cycle()			
		end
			currentRage = leviathan_rage.current
		end
		
		--Garuda
		if string.find(pet.name,'Garuda')then 
			if (cmd == 'cycleragedown') then
				garuda_rage:cycleback()
		else
			garuda_rage:cycle()			
		end
			currentRage = garuda_rage.current
		end
	
		--Shiva
		if string.find(pet.name,'Shiva')then 
			if (cmd == 'cycleragedown') then
				shiva_rage:cycleback()
		else
			shiva_rage:cycle()			
		end
			currentRage = shiva_rage.current
		end
	
		--Ramuh
		if string.find(pet.name,'Ramuh')then 
			if (cmd == 'cycleragedown') then
				ramuh_rage:cycleback()
		else
			ramuh_rage:cycle()			
		end
			currentRage = ramuh_rage.current
		end
		
		--Diabolos
		if string.find(pet.name,'Diabolos')then 
			if (cmd == 'cycleragedown') then
				diabolos_rage:cycleback()
		else
			diabolos_rage:cycle()			
		end
			currentRage = diabolos_rage.current
		end
		
		--Cait Sith
		if string.find(pet.name,'Cait Sith')then 
			if (cmd == 'cycleragedown') then
				cait_sith_rage:cycleback()
		else
			cait_sith_rage:cycle()			
		end
			currentRage = cait_sith_rage.current
		end
	
		--Siren
		if string.find(pet.name,'Siren')then 
			if (cmd == 'cycleragedown') then
				siren_rage:cycleback()
		else
			siren_rage:cycle()			
		end
			currentRage = siren_rage.current
		end
	end
end

--------------------------------------------------------------------------------------------------------------
-------------------------------------------- Handle Ward Cycle -----------------------------------------------
--------------------------------------------------------------------------------------------------------------

function handle_ward_cycle(cmd)
	if not pet.isvalid then
		return
	else
		--Carby
		if string.find(pet.name,'Carbuncle')then 
			if (cmd == 'cyclewarddown') then
				carbuncle_ward:cycleback()
		else
			carbuncle_ward:cycle()			
		end
			currentWard = carbuncle_ward.current
		end
	
		--Fenrir
		if string.find(pet.name,'Fenrir')then 
			if (cmd == 'cyclewarddown') then
				fenrir_ward:cycleback()
		else
			fenrir_ward:cycle()			
		end
			currentWard = fenrir_ward.current
		end
	
		--Ifrit
		if string.find(pet.name,'Ifrit')then 
			if (cmd == 'cyclewarddown') then
				ifrit_ward:cycleback()
		else
			ifrit_ward:cycle()			
		end
			currentWard = ifrit_ward.current
		end
		
		--Titan
		if string.find(pet.name,'Titan')then 
			if (cmd == 'cyclewarddown') then
				titan_ward:cycleback()
		else
			titan_ward:cycle()			
		end
			currentWard = titan_ward.current
		end
		
		--Leviathan
		if string.find(pet.name,'Leviathan')then 
			if (cmd == 'cyclewarddown') then
				leviathan_ward:cycleback()
		else
			leviathan_ward:cycle()
		end
			currentWard = leviathan_ward.current
		end
		
		--Garuda
		if string.find(pet.name,'Garuda')then 
			if (cmd == 'cyclewarddown') then
				garuda_ward:cycleback()
		else
			garuda_ward:cycle()			
		end
			currentWard = garuda_ward.current
		end
	
		--Shiva
		if string.find(pet.name,'Shiva')then 
			if (cmd == 'cyclewarddown') then
				shiva_ward:cycleback()
		else
			shiva_ward:cycle()			
		end
			currentWard = shiva_ward.current
		end
	
		--Ramuh
		if string.find(pet.name,'Ramuh')then 
			if (cmd == 'cyclewarddown') then
				ramuh_ward:cycleback()
		else
			ramuh_ward:cycle()			
		end
			currentWard = ramuh_ward.current
		end
		
		--Diabolos
		if string.find(pet.name,'Diabolos')then 
			if (cmd == 'cyclewarddown') then
				diabolos_ward:cycleback()
		else
			diabolos_ward:cycle()			
		end
			currentWard = diabolos_ward.current
		end
		
		--Cait Sith
		if string.find(pet.name,'Cait Sith')then 
			if (cmd == 'cyclewarddown') then
				cait_sith_ward:cycleback()
		else
			cait_sith_ward:cycle()			
		end
			currentWard = cait_sith_ward.current
		end
	
		--Siren
		if string.find(pet.name,'Siren')then 
			if (cmd == 'cyclewarddown') then
				siren_ward:cycleback()
		else
			siren_ward:cycle()			
		end
			currentWard = siren_ward.current
		end
	end
end


--------------------------------------------------------------------------------------------------------------
---------------------------------------------- Set Default BP ------------------------------------------------
--------------------------------------------------------------------------------------------------------------

function set_defaultBP()
	if not pet.isvalid then
		return
	else
		--Carby
		if string.find(pet.name,'Carbuncle')then 
			
			carbuncle_rage:set(defaultbps[pet.name].Rage)
			carbuncle_ward:set(defaultbps[pet.name].Ward)
			currentRage = carbuncle_rage.current
			currentWard = carbuncle_ward.current
		end
	
		--Fenrir
		if string.find(pet.name,'Fenrir')then 
			fenrir_rage:set(defaultbps[pet.name].Rage)
			fenrir_ward:set(defaultbps[pet.name].Ward)
			currentRage = fenrir_rage.current
			currentWard = fenrir_ward.current
		end
	
		--Ifrit
		if string.find(pet.name,'Ifrit')then 
			ifrit_rage:set(defaultbps[pet.name].Rage)
			ifrit_ward:set(defaultbps[pet.name].Ward)
			currentRage = ifrit_rage.current
			currentWard = ifrit_ward.current
		end
		
		--Titan
		if string.find(pet.name,'Titan')then 
			titan_rage:set(defaultbps[pet.name].Rage)
			titan_ward:set(defaultbps[pet.name].Ward)
			currentRage = titan_rage.current
			currentWard = titan_ward.current
		end
		
		--Leviathan
		if string.find(pet.name,'Leviathan')then 
			leviathan_rage:set(defaultbps[pet.name].Rage)
			leviathan_ward:set(defaultbps[pet.name].Ward)
			currentRage = leviathan_rage.current
			currentWard = leviathan_ward.current
		end
		
		--Garuda
		if string.find(pet.name,'Garuda')then 
			garuda_rage:set(defaultbps[pet.name].Rage)
			garuda_ward:set(defaultbps[pet.name].Ward)
			currentRage = garuda_rage.current
			currentWard = garuda_ward.current
		end
	
		--Shiva
		if string.find(pet.name,'Shiva')then 
			shiva_rage:set(defaultbps[pet.name].Rage)
			shiva_ward:set(defaultbps[pet.name].Ward)
			currentRage = shiva_rage.current
			currentWard = shiva_ward.current
		end
	
		--Ramuh
		if string.find(pet.name,'Ramuh')then 
			ramuh_rage:set(defaultbps[pet.name].Rage)
			ramuh_ward:set(defaultbps[pet.name].Ward)
			currentRage = ramuh_rage.current
			currentWard = ramuh_ward.current
		end
		
		--Diabolos
		if string.find(pet.name,'Diabolos')then 
			diabolos_rage:set(defaultbps[pet.name].Rage)
			diabolos_ward:set(defaultbps[pet.name].Ward)
			currentRage = diabolos_rage.current
			currentWard = diabolos_ward.current
		end
		
		--Cait Sith
		if string.find(pet.name,'Cait Sith')then 
			cait_sith_rage:set(defaultbps[pet.name].Rage)
			cait_sith_ward:set(defaultbps[pet.name].Ward)
			currentRage = cait_sith_rage.current
			currentWard = cait_sith_ward.current
		end
	
		--Siren
		if string.find(pet.name,'Siren')then 
			siren_rage:set(defaultbps[pet.name].Rage)
			siren_ward:set(defaultbps[pet.name].Ward)
			currentRage = siren_rage.current
			currentWard = siren_ward.current
		end
	end
end





--------------------------------------------------------------------------------------------------------------
-------------------------------------------- Handle Siphoning ------------------------------------------------
--------------------------------------------------------------------------------------------------------------

function handle_siphoning()
    if areas.Cities:contains(world.area) then
        add_to_chat(122, 'Cannot use Elemental Siphon in a city area.')
        return
    end
 
    local siphonElement
    local stormElementToUse
    local releasedAvatar
    local dontRelease
	
	--Doing our own thing here because the include file has Storm II's mapped and smn doesn't get those because we are not cool enough.
	storm_of = {['Light']="Aurorastorm", ['Dark']="Voidstorm", ['Fire']="Firestorm", ['Earth']="Sandstorm",
        ['Water']="Rainstorm", ['Wind']="Windstorm", ['Ice']="Hailstorm", ['Lightning']="Thunderstorm"}
   
    -- If we already have a spirit out, just use that.
    if pet.isvalid and spirits:contains(pet.name) then
        siphonElement = pet.element
        dontRelease = true
        -- If current weather doesn't match the spirit, but the spirit matches the day, try to cast the storm.
        if player.sub_job == 'SCH' and pet.element == world.day_element and pet.element ~= world.weather_element then
			
			stormElementToUse = pet.element
        end
    -- If we're subbing /sch, there are some conditions where we want to make sure specific weather is up.
    -- If current (single) weather is opposed by the current day, we want to change the weather to match
    -- the current day, if possible.
    elseif player.sub_job == 'SCH' and world.weather_element ~= 'None' then
        -- We can override single-intensity weather; leave double weather alone, since even if
        -- it's partially countered by the day, it's not worth changing.
        if get_weather_intensity() == 1 then
            
			-- If current weather is weak to the current day, it cancels the benefits for
            -- siphon.  Change it to the day's weather if possible (+0 to +20%), or any non-weak
            -- weather if not.
            -- If the current weather matches the current avatar's element (being used to reduce
            -- perpetuation), don't change it; just accept the penalty on Siphon.
            
			if world.weather_element == element.weak_to[world.day_element] and (not pet.isvalid or world.weather_element ~= pet.element) then
  
				stormElementToUse = world.day_element
            
			end
        end
    
	elseif player.sub_job == 'SCH' and world.weather_element == 'None' then
		stormElementToUse = world.day_element
	end
   
    -- If we decided to use a storm, set that as the spirit element to cast.
    if stormElementToUse then
        siphonElement = stormElementToUse
    elseif world.weather_element ~= 'None' and (get_weather_intensity() == 2 or world.weather_element ~= element.weak_to[world.day_element]) then
        siphonElement = world.weather_element
    else
        siphonElement = world.day_element
    end
   
    local command = ''
    local releaseWait = 0
    local elementused = ''
   
    if pet.isvalid and avatars:contains(pet.name) then
        command = command..'input /pet "Release" <me>;wait 1.1;'
        releasedAvatar = pet.name
        releaseWait = 10
    end
   
    if stormElementToUse then
        command = command..'input /ma "'..storm_of[stormElementToUse]..'" <me>;wait 5;'
        releaseWait = releaseWait - 4
	elementused = stormElementToUse
    end
   
    if not (pet.isvalid and spirits:contains(pet.name)) then
        command = command..'input /ma "'..elements.spirit_of[siphonElement]..'" <me>;wait 5;'
        releaseWait = releaseWait - 4
	elementused = siphonElement
    end
   
    command = command..'input /ja "Elemental Siphon" <me>;'
    releaseWait = releaseWait - 1
    releaseWait = releaseWait + 0.1
   
    if not dontRelease then
        if releaseWait > 0 then
            command = command..'wait '..tostring(releaseWait)..';'
        else
            command = command..'wait 1.1;'
        end
       
        command = command..'input /pet "Release" <me>;'
    end
   
    if releasedAvatar then
        command = command..'wait 1.1;input /ma "'..releasedAvatar..'" <me>'
    end
   
    send_command(command)
end
