-- Basic White Bitch Gearswap by Cambion

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
end

-- Setup variables that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff['Climactic Flourish'] = buffactive['climactic flourish'] or false
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.
-------------------------------------------------------------------------------------------------------------------

windower.send_command('bind f9 gs c cycleOffense')

-- Gear Modes

function user_setup()
    -- Haste = 0
    -- DW_needed = 0
    --DW = true
    -- moving = false
    state.OffenseMode:options('Hybrid', 'DT')
	update_combat_form()
    -- determine_haste_group()
end


function user_unload()
	windower.send_command('unbind f9')
end


-- Define sets and vars used by this job file.
function init_gear_sets()

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Precast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.precast.JA['No Foot Rise'] = {body="Horos Casaque +3"}
    
	sets.precast.Waltz = { 
		ammo="Yamarang",
		head={ name="Horos Tiara +3", augments={'Enhances "Trance" effect',}},
		body="Maxixi Casaque +2",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck={ name="Etoile Gorget +2", augments={'Path: A',}},
		waist="Chaac Belt",
		left_ear="Odnowa Earring +1",
		right_ear="Etiolation Earring",
		left_ring="Gelatinous Ring +1",
		right_ring="Defending Ring",
		back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	}
	
    sets.precast.WaltzSelf = set_combine(sets.precast.Waltz)
    
	sets.precast.Samba = {
		head= "Maxixi Tiara +1",
		back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
	}
    
	sets.precast.Jig = {
			head= "Maxixi Toe Shoes +1",
			legs= "Horos Tights +3",
	}
	
    -- Dont touch these. Have to define the sets before we can call subsets.
	sets.precast.flourish ={}
	sets.precast.Flourish2 ={}
	sets.precast.Flourish3 ={}
	
	sets.precast.Step = {
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet={ name="Horos T. Shoes +3", augments={'Enhances "Closed Position" effect',}},
		neck={ name="Etoile Gorget +2", augments={'Path: A',}},
		waist="Eschan Stone",
		left_ear="Odr Earring",
		right_ear="Sherida Earring",
		left_ring="Epona's Ring",
		right_ring="Rajas Ring",
		back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	}   
    
	sets.precast.Flourish2['Reverse Flourish'] = {
		hands="Macu. Bangles +1",
		back={ name="Toetapper Mantle", augments={'"Store TP"+4','"Dual Wield"+2','"Rev. Flourish"+29','Weapon skill damage +2%',}},
	}
    
	sets.precast.Flourish3['Climactic Flourish'] = {head="Maculele Tiara +1"}
	
	sets.buff['Climactic Flourish'] = {head="Maculele Tiara +1", body="Meg. Cuirie +2"}

    ------------------------------------------------------------------------------------------------
    ------------------------------------- Weapon Skill Sets ----------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.precast.WS = {
		ammo="C. Palug Stone",
		head={ name="Herculean Helm", augments={'"Conserve MP"+3','INT+2','Weapon skill damage +8%','Mag. Acc.+1 "Mag.Atk.Bns."+1',}},
		body="Meg. Cuirie +2",
		hands="Maxixi Bangles +3",
		legs={ name="Horos Tights +3", augments={'Enhances "Saber Dance" effect',}},
		feet={ name="Herculean Boots", augments={'Accuracy+4','Mag. Acc.+27','Weapon skill damage +8%','Mag. Acc.+19 "Mag.Atk.Bns."+19',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Ishvara Earring",
		right_ear="Odr Earring",
		left_ring="Thundersoul Ring",
		right_ring="Ilabrat Ring",
		back={ name="Senuna's Mantle", augments={'DEX+20','DEX+10','Weapon skill damage +10%',}},
	}

    sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS,{
		head="Malignance Chapeau",
		right_ear="Brutal Earring",
		left_ring="Stormsoul Ring",
		back={ name="Senuna's Mantle", augments={'AGI+20','Accuracy+20 Attack+20','AGI+10','Weapon skill damage +10%',}},
	})

    sets.precast.WS['Pyrrhic Kleos'] = set_combine(sets.precast.WS,{
		head={ name="Herculean Helm", augments={'"Conserve MP"+3','INT+2','Weapon skill damage +8%','Mag. Acc.+1 "Mag.Atk.Bns."+1',}},
    	neck={ name="Etoile Gorget +2", augments={'Path: A',}},
		
	})
	
    sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS,{
		head="Mummu Bonnet +2",
		body="Abnoba Kaftan",
		legs={ name="Horos Tights +3", augments={'Enhances "Saber Dance" effect',}},
		feet={ name="Herculean Boots", augments={'Accuracy+4','Mag. Acc.+27','Weapon skill damage +8%','Mag. Acc.+19 "Mag.Atk.Bns."+19',}},
		neck={ name="Etoile Gorget +2", augments={'Path: A',}},
		waist="Grunfeld Rope",
	})

    sets.precast.WS['Rudra\'s Storm'] = set_combine(sets.precast.WS,{
		body={ name="Herculean Vest", augments={'AGI+8','Pet: Mag. Acc.+14','Weapon skill damage +10%','Accuracy+16 Attack+16',}},
		neck={ name="Etoile Gorget +2", augments={'Path: A',}},
		waist="Grunfeld Rope",
	})

    sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS,{ 
		body={ name="Herculean Vest", augments={'Pet: STR+8','"Mag.Atk.Bns."+13','Accuracy+17 Attack+17','Mag. Acc.+20 "Mag.Atk.Bns."+20',}},
		hands="Meg. Gloves +2",
		legs={ name="Horos Tights +3", augments={'Enhances "Saber Dance" effect',}},
		feet={ name="Herculean Boots", augments={'Accuracy+4','Mag. Acc.+27','Weapon skill damage +8%','Mag. Acc.+19 "Mag.Atk.Bns."+19',}},
		neck={ name="Etoile Gorget +2", augments={'Path: A',}},
		waist="Eschan Stone",
		left_ear="Ishvara Earring",
		right_ear="Hecate's Earring",
		left_ring="Thundersoul Ring",
		right_ring="Persis Ring",
		back={ name="Toetapper Mantle", augments={'"Store TP"+4','"Dual Wield"+2','"Rev. Flourish"+29','Weapon skill damage +2%',}},
	})

    ------------------------------------------------------------------------------------------------
    ----------------------------------------- Idle Sets --------------------------------------------
    ------------------------------------------------------------------------------------------------
    sets.idle = {
		head="Gleti's Mask",
		body="Gleti's Cuirass",
		hands="Gleti's Gauntlets",
		legs="Gleti's Breeches",
		feet="Gleti's Boots",
	}


    ------------------------------------------------------------------------------------------------
    -------------------------------------- Dual Wield Sets -----------------------------------------
	------------------------------------------------------------------------------------------------
    -- * DNC Native DW Trait: 30% DW
    -- * DNC Job Points DW Gift: 5% DW 

    -- No Magic Haste (39% DW to cap)
    sets.engaged.DW = {
		ammo="Yamarang",
		head="Malignance Chapeau",
		body="Gleti's Cuirass",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck={ name="Etoile Gorget +2", augments={'Path: A',}},
		waist="Windbuffet Belt",
		left_ear="Telos Earring",
		right_ear="Sherida Earring",
		left_ring="Epona's Ring",
		right_ring="Ilabrat Ring",
		back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	}
	
	sets.engaged.DT = {
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Warder's Charm +1",
		waist="Engraved Belt",
		left_ear="Telos Earring",
		right_ear="Sherida Earring",
		left_ring="Defending Ring",
		right_ring="Warden's Ring",
		back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	
	
	}

    -- -- 15% Magic Haste (32% DW to cap)
    -- sets.engaged.DW.LowHaste = {}

    -- -- 30% Magic Haste (21% DW to cap)
    -- sets.engaged.DW.MidHaste = {}

    -- -- 35% Magic Haste (16% DW to cap)
    -- sets.engaged.DW.HighHaste = {}

    -- -- 45% Magic Haste (1% DW to cap)
    -- sets.engaged.DW.MaxHaste = {}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.type == "WeaponSkill" then
        if state.Buff['Climactic Flourish'] then
            equip(sets.buff['Climactic Flourish'])
        end
    end
    if spell.type=='Waltz' and spell.target.type == 'SELF' then
        equip(sets.precast.WaltzSelf)
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------
function job_buff_change(buff,gain)
    if buff == 'Climactic Flourish' then
        handle_equipping_gear(player.status)
    end
end
-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------
function job_handle_equipping_gear(playerStatus, eventArgs)
    update_combat_form()
    --determine_haste_group()
end

function job_update(cmdParams, eventArgs)
    handle_equipping_gear(player.status)
end

-- function update_combat_form()
    -- if DW == true then
        -- state.CombatForm:set('DW')
    -- elseif DW == false then
        -- state.CombatForm:reset()
    -- end
-- end

function update_combat_form()
		
	if state.OffenseMode.value == 'Hybrid' then
		
		state.CombatForm:set('DW')
	end	
	
	if state.OffenseMode.value == 'DT' then
		
		state.CombatForm:set('DT')
	end	

end

function customize_melee_set(meleeSet)
    if state.Buff['Climactic Flourish'] then
		meleeSet = set_combine(meleeSet, sets.buff['Climactic Flourish'])
    end
    return meleeSet
end


function self_command(command)
    
    local commandArgs = command
     
    if #commandArgs:split(' ') >= 2 then
        commandArgs = T(commandArgs:split(' '))
        
        if commandArgs[1] == 'cycleOffense' then
			OffenseMode:cycle()
			
		end
		
	end
end
-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- function determine_haste_group()
    -- classes.CustomMeleeGroups:clear()
    -- if DW == true then
        -- if DW_needed <= 1 then
            -- classes.CustomMeleeGroups:append('MaxHaste')
        -- elseif DW_needed > 1 and DW_needed <= 9 then
            -- classes.CustomMeleeGroups:append('HighHaste')
        -- elseif DW_needed > 9 and DW_needed <= 21 then
            -- classes.CustomMeleeGroups:append('MidHaste')
        -- elseif DW_needed > 21 and DW_needed <= 39 then
            -- classes.CustomMeleeGroups:append('LowHaste')
        -- elseif DW_needed > 39 then
            -- classes.CustomMeleeGroups:append('')
        -- end
    -- end
-- end

-- function gearinfo(cmdParams, eventArgs)
    -- if cmdParams[1] == 'gearinfo' then
        -- if type(tonumber(cmdParams[2])) == 'number' then
            -- if tonumber(cmdParams[2]) ~= DW_needed then
            -- DW_needed = tonumber(cmdParams[2])
            -- DW = true
            -- end
        -- elseif type(cmdParams[2]) == 'string' then
            -- if cmdParams[2] == 'false' then
        	    -- DW_needed = 0
                -- DW = false
      	    -- end
        -- end
        -- if type(tonumber(cmdParams[3])) == 'number' then
          	-- if tonumber(cmdParams[3]) ~= Haste then
              	-- Haste = tonumber(cmdParams[3])
            -- end
        -- end
        -- if type(cmdParams[4]) == 'string' then
            -- if cmdParams[4] == 'true' then
                -- moving = true
            -- elseif cmdParams[4] == 'false' then
                -- moving = false
            -- end
        -- end
        -- if not midaction() then
            -- job_update()
        -- end
    -- end
-- end