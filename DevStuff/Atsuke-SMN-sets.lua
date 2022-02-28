--4.15.2016
--
--Table of Contents
--You can search the file for the #'s to aid in search, ex. Ctrl + F, input #11 to find the midcast section which contains healing, stoneskin, etc
--#1 Staves
--#2 JSE Cape
--#3 Magical Pacts
--#4 Ward Pacts
--#5 Physical Pacts
--#6 Hybrid Pacts
--#7 Toggled/Situational Sets 
--#8 Job Abilities
--#9 Fast Cast
--#10 Weapon Skills
--#11 Midcast Sets
--#12 Idle/DT Sets
--#13 Perp Sets
--#14 Avatar Melee/DT Sets
--#15 Engaged Sets 
--Simple guide to filling out sets:
--1) equip the gear for the desired set
--2) use //gs export lua and open the file in the exports folder
--3) copy and paste the gear into your set

--[#1 Staves ]--
--if you don't have 3 staff you can set them all to the same one, until you do get more.  Nirvana is the best avatarattackstaff, espiritus and griovalr techinically best for the other 2 with right augs
--if you're confused for any sets with augs or just wanna save time, just equip the gear and type //gs export lua and it will be in your data/export folder
bpmagicstaff={ name="Grioavolr", augments={'Blood Pact Dmg.+6','System: 1 ID: 1796 Val: 3','Pet: Mag. Acc.+15','Pet: "Mag.Atk.Bns."+28',}}
bpmagicaccstaff={ name="Grioavolr", augments={'Blood Pact Dmg.+6','System: 1 ID: 1796 Val: 3','Pet: Mag. Acc.+15','Pet: "Mag.Atk.Bns."+28',}}
smnskillstaff = { name="Espiritus", augments={'Summoning magic skill +15','Pet: Mag. Acc.+30','System: 2 ID: 153 Val: 3',}}
avatarattackstaff = "Nirvana"

--[#2 JSE Cape ]--
conveyance = { name="Conveyance Cape", augments={'Summoning magic skill +4','Blood Pact Dmg.+4','Blood Pact ab. del. II -3',}}
campestres = "Campestres's Cape"

--[#3 Magical Pacts ]--
--Used for Magical Blood Pacts
sets.petmab = { 
	head="Apogee Crown +1",
	hands={ name="Merlinic Dastanas", augments={'Pet: Mag. Acc.+16 Pet: "Mag.Atk.Bns."+16','Blood Pact Dmg.+9','System: 1 ID: 1792 Val: 8','Pet: Mag. Acc.+7','Pet: "Mag.Atk.Bns."+9',}},
	body="Apogee Dalmatica",
	legs="Apogee Slacks",
	feet="Apogee Pumps +1",
	main=bpmagicstaff,
	sub="Vox Grip",
	ammo="Seraphicaller",
	neck="Deino Collar",
	waist="Kobo Obi",
	left_ear="Gelos Earring",
	right_ear="Esper earring",
	left_ring="Speaker's Ring",
	right_ring="Evoker's ring",
	--back=conveyance
	back=campestres

	-- Example Helios --
	--head={ name="Helios Band", augments={'Pet: "Mag.Atk.Bns."+29','Pet: Crit.hit rate +4','Blood Pact Dmg.+4',}}, 
	--body={ name="Helios Jacket", augments={'Pet: "Mag.Atk.Bns."+28','Pet: Crit.hit rate +4','Blood Pact Dmg.+4',}},
	--hands={ name="Helios Gloves", augments={'Pet: "Mag.Atk.Bns."+28','Pet: Crit.hit rate +4','Blood Pact Dmg.+4',}},
	--legs={ name="Helios Spats", augments={'Pet: "Mag.Atk.Bns."+29','Pet: Crit.hit rate +4','Blood Pact Dmg.+5',}},
	--feet={ name="Helios Boots", augments={'Pet: "Mag.Atk.Bns."+28','Pet: Crit.hit rate +3','Blood Pact Dmg.+6',}},
}


--[#4 Ward Pacts ]--
--Max out Summoning Magic Skill
--this will be used for many types of wards, max your summoning skill for longer ward duration and more magic acc
--wards can be empowered by empy bonus your call on to use it or not
sets.smnskill = { 
	main=smnskillstaff,
	sub="Vox Grip",
	ammo="Seraphicaller",
	--head="Convoker's Horn +1",
	head="Beckoner's Horn +1",
	body="Beckoner's Doublet +1",
	hands="Lamassu Mitts +1",
	legs="Beckoner's spats +1",
	feet="Apogee Pumps",
	neck="Incanter's Torque",
	waist="Kobo Obi",
	left_ear="Summoning earring",
	right_ear="Andoaa earring",
	left_ring="Globidonta Ring",
	right_ring="Evoker's ring",
	back=conveyance
}
sets.midcast.Pet.BloodPactWard = { --uses the smnskill set as base, if you want to override anything in that set you may do so here
}
sets.midcast.Pet.BloodPactWard = set_combine(sets.smnskill,sets.midcast.Pet.BloodPactWard)

--you want to put tp bonus and + to hp here for stronger cures, smn skill won't matter this is for healing wards mostly
sets.midcast.Pet.TPBloodPactWard = set_combine(sets.smnskill,{
	head="Apogee Crown +1",
	hands="Apogee Mitts",
	body="Apogee Dalmatica",
	legs="Enticer's Pants",
	feet="Apogee Pumps"
})

sets.midcast.Pet.DebuffBloodPactWard = { --override your smnskill set here, these are wards that target monsters, I leave it as maxing out smn skill for magic accuracy, but you could put other things here
	main=bpmagicaccstaff,
	hands="Apogee Mitts",
	neck="Deino Collar",
	waist="Incarnation Sash",
}
sets.midcast.Pet.DebuffBloodPactWard = set_combine(sets.smnskill,sets.midcast.Pet.DebuffBloodPactWard)

sets.midcast.Pet.DebuffBloodPactWard.Acc = set_combine(sets.midcast.Pet.DebuffBloodPactWard,pet.petmabacc)

--[#5 Physical Pacts ]--
sets.midcast.Pet.PhysicalBloodPactRage = { --does physical damage only, like pred claws and spinning dive and volt strike
	main=avatarattackstaff,
	sub="Vox Grip",
	ammo="Seraphicaller",
	head="Apogee Crown +1",
	body="Convoker's Doublet +1",
	hands={ name="Merlinic Dastanas", augments={'Pet: Mag. Acc.+16 Pet: "Mag.Atk.Bns."+16','Blood Pact Dmg.+9','System: 1 ID: 1792 Val: 8','Pet: Mag. Acc.+7','Pet: "Mag.Atk.Bns."+9',}},
	legs="Apogee Slacks",
	neck="Empath necklace",
	waist="Mujin Obi",
	left_ear="Gelos Earring",
	right_ear="Esper earring",
	left_ring="Globidonta Ring",
	right_ring="Evoker's ring",
	--back=conveyance,
	back=campestres,
	feet="Apogee Pumps +1",
}
sets.midcast.Pet.PhysicalBloodPactRage.Acc = set_combine(sets.midcast.Pet.PhysicalBloodPactRage,{
	hands="Apogee Mitts"
})

--[#6 Hybrid Pacts ]--
sets.midcast.Pet.HybridBloodPactRage = { --At this time is only your flaming crush set
	main="Nirvana",
	sub="Vox Grip",
	ammo="Seraphicaller",
	head="Apogee Crown +1",
	hands={ name="Merlinic Dastanas", augments={'Pet: Mag. Acc.+16 Pet: "Mag.Atk.Bns."+16','Blood Pact Dmg.+9','System: 1 ID: 1792 Val: 8','Pet: Mag. Acc.+7','Pet: "Mag.Atk.Bns."+9',}},
	body="Apogee Dalmatica",
	legs="Apogee Slacks",
	feet="Apogee Pumps +1",
	neck="Deino Collar",
	waist="Incarnation Sash",
	left_ear="Gelos Earring",
	right_ear="Esper earring",
	left_ring="Speaker's Ring",
	right_ring="Fervor Ring",
	--back="Scintillating Cape"
	back=campestres,
}
sets.midcast.Pet.HybridBloodPactRage.Acc = set_combine(sets.midcast.Pet.HybridBloodPactRage,{
	main=bpmagicaccstaff,
	hands="Apogee Mitts"
})

sets.midcast.Pet.MagicalBloodPactRage = {
}

--This is where petmab set fills in anything you didn't specifically define
--basically petmab is the "default" set and you customize each situational set how you liked above
--this cuts down on the need to fill in the same items over and over for each set
sets.midcast.Pet.MagicalBloodPactRage = set_combine(sets.petmab,sets.midcast.Pet.MagicalBloodPactRage)
sets.midcast.Pet.MagicalBloodPactRage.Acc = set_combine(sets.midcast.Pet.MagicalBloodPactRage,pet.petmabacc)
sets.midcast.Pet.TPMagicalBloodPactRage = set_combine(sets.petmab,{legs="Enticer's Pants"})
sets.midcast.Pet.TPMagicalBloodPactRage.Acc = set_combine(sets.midcast.Pet.TPMagicalBloodPactRage,pet.petmabacc)
sets.midcast.Pet.IfritMagicalBloodPactRage = set_combine(sets.petmab,{left_ring="Speaker's Ring",right_ring="Fervor Ring"})
sets.midcast.Pet.IfritMagicalBloodPactRage.Acc = set_combine(sets.midcast.Pet.IfritMagicalBloodPactRage,sets.petmabacc)

--Helios Notes
--MAX: crit 20% mab 150 bpdmg 35
--AT: crit 19% mab 142 bpdmg 23
--MISSING: crit 1% mab 8 bpdmg 12

--[#7 Toggled/Situational Sets ]--
sets.cpmode = {back="Mecisto. Mantle"}
sets.wakeup = {neck="Sacrifice Torque"}--if you have a pet out and are slept, equipping this wakes you up

sets.latent_refresh = {sub="Oneiros grip",waist="Fucho-no-obi"}

--for when you wanna melee for self skill chains, aftermath, procing voidwatch, or just wanna crack some skulls the old fashioned way
sets.tplock = { 
	main="Nirvana"
	--main=bpmagicstaff
}
-- sets.kclub = {
	-- main="Kraken Club",
	-- sub="Genmei Shield", --10
-- }
-- sets.inwkr = {
	-- neck="Arciela's Grace +1"
-- }

--Feet is your biggest -perp slot, especially with apogee+1 being a massive -9.  Evans earring can help counter this, I keep moonshade on my right ear.  Lucidity helps too ofc.  This is automatically equipped when you use fleet wind, and if you're moving between points and then engaging things a lot (such as assault) I found I could be low mana, so this mostly fixed that.
sets.movement = { 
	left_ear="Evans earring",
	waist="Lucidity sash",
	feet="Herald's Gaiters"
}

--When you zone into mog gardens, what you wear, might have to hit f12 to force a gear update sometimes
sets.farmer = { 
	main="Hoe",
	body="Overalls",
	hands="Work gloves",
	legs="",
	--feet="Herald's Gaiters"
	feet="Thatch Boots"
}

--For more movement in Adoulin
sets.adoulinmovement = { 
	body="Councilor's Garb"
}

sets.crafting = {
	head="Magnifying Specs.",
	--left_ring="Artificer's Ring",
	left_ring="Craftmaster's Ring",
	right_ring="Orvail Ring",
	body="Weaver's Apron",
}

--[ Items To Keep with Organizer ]--
--if you use organizer and want to keep some things in inventory, weird I know but it works
sets.keep = {
	left_ring="Warp Ring",
	right_ring="Dim. Ring (Mea)",
	--right_ring="Mephitas's Ring +1"
}
if exp_rings then 
	sets.keep2 = {
		left_ring="Echad Ring",
		right_ring="Trizek Ring",
		back="Capacity Ring",
	}
end


--[#8 Job Abilities ]--

-- Precast sets to enhance JAs
sets.precast.JA['Astral Flow'] = {head="Glyphic Horn"}

sets.precast.JA['Mana Cede'] = {hands="Beckoner's bracers"}
sets.precast.JA['Elemental Siphon'] = {
	main=smnskillstaff,
	sub="Vox Grip",
	ammo="Esper Stone +1",
	head={ name="Telchine Cap", augments={'"Elemental Siphon"+30',}},
	body={ name="Telchine Chasuble", augments={'"Elemental Siphon"+30',}},
	hands={ name="Telchine Gloves", augments={'"Elemental Siphon"+30',}},
	legs={ name="Telchine Braconi", augments={'"Elemental Siphon"+30',}},
	feet="Beck. Pigaches +1",
	neck="Incanter's Torque",
	waist="Kobo Obi",
	--left_ear="",
	right_ear="Andoaa earring",
	left_ring="Zodiac Ring",--technically shouldn't use on light or darks day, going to add logic for it later
	right_ring="Evoker's Ring",
	back=conveyance
}




--TODO This if statement sucks. Kill it.




	-- Pact delay reduction gear
sets.precast.BloodPactWard = { --I just stack it all because when I do salvage or a gear slot is locked by a NM it's nice
	main="Nirvana",
	sub="Elan Strap +1",
	ammo="Sancus Sachet +1",
	head="Beckoner's Horn +1",
	body={ name="Glyphic Doublet +3", augments={'Reduces Sp. "Blood Pact" MP cost',}},
	hands={ name="Glyphic Bracers +3", augments={'Inc. Sp. "Blood Pact" magic burst dmg.',}},
	legs={ name="Glyphic Spats +3", augments={'Increases Sp. "Blood Pact" accuracy',}},
	feet={ name="Glyph. Pigaches +3", augments={'Inc. Sp. "Blood Pact" magic crit. dmg.',}},
	neck={ name="Smn. Collar +2", augments={'Path: A',}},
	waist="Kobo Obi",
	left_ear="Lodurr Earring",
	right_ear="C. Palug Earring",
	left_ring="Fervor Ring",
	right_ring="Evoker's Ring",
	back={ name="Conveyance Cape", augments={'Summoning magic skill +1','Pet: Enmity+11','Blood Pact Dmg.+4',}},
	--gift -10
}
-- delay 1: -15 cap (-20 equipped)
-- delay II: -10
-- gift: -10


sets.precast.BloodPactRage = sets.precast.BloodPactWard


sets.burstmode = {}
sets.burstmode.Burst = {
	hands="Glyphic Bracers +1"
}

--[#9 Fast Cast ]--

-- Fast cast sets for spells
sets.precast.FC = {
	main="Sucellus",--5
	sub="Chanter's Shield",--3 
	head={ name="Merlinic Hood", augments={'"Mag.Atk.Bns."+30','"Fast Cast"+6','MND+6','Mag. Acc.+4',}}, --14
	neck="Orunmila's Torque",--5
	left_ear="Enchntr. Earring +1",--2
	right_ear="Loquacious earring",--2
	hands={ name="Merlinic Dastanas", augments={'"Mag.Atk.Bns."+14','"Fast Cast"+6','INT+10','Mag. Acc.+11',}}, --6
	body="Merlinic Jubbah", --13
	left_ring="Prolix ring", -- 2
	right_ring="Rahab Ring", -- 2
	back="Swith cape +1", --4
	waist="Witful belt", --3
	legs="Psycloth Lappas", --7
	feet={ name="Merlinic Crackows", augments={'Mag. Acc.+18 "Mag.Atk.Bns."+18','"Fast Cast"+6','INT+8',}},--11

}
--ammo --+2
--max obtainable 81, 83 with ammo
--at 79 
--94 with rdm sub
--3 Quick cast
if player.sub_job == 'RDM' then
	sets.precast.FC = set_combine(sets.precast.FC, {
		left_ring="Lebeche Ring", --+2 QC -2 FC
		back="Perimede Cape", --+4 QC -4 FC
	})
end
--9 quick cast, 81 fastcast

sets.precast.FC['Stoneskin'] = {
waist="Siegel Sash", --8
}

sets.precast.FC['Cure'] = set_combine(sets.precast.FC, {
    main="Tamaxchi",
    sub="Genbu's shield",
    body="Heka's kalasiris",
    back="pahtli cape",
    feet="Chelona boots"
})


--[#10 Weapon Skills ]--
-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
-- Default set for any weaponskill that isn't any more specifically defined
sets.precast.WS = {}

sets.precast.WS['Myrkr'] = {}

sets.precast.PhysicalWS = {
	head="Blistering Sallet",
	body="Onca Suit",
	neck="Subtlety spectacles",
	right_ring="Cacoethic Ring",
	left_ring="Cacoethic Ring +1",
	left_ear="Zennaroi Earring",
	right_ear="Dignitary's Earring",
	waist="Olseni Belt",
	back="Penetrating Cape"
}

sets.precast.WS = sets.precast.PhysicalWS
if use_player_mab then
	sets.precast.MagicalWS = {
		ammo="Seraphicaller",
		head={ name="Merlinic Hood", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Mag. Acc.+7',}},
		--body="Count's Garb",
		body="Gyve Doublet",
		hands={ name="Merlinic Dastanas", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','MND+3','Mag. Acc.+11',}},
		legs="Gyve Trousers",
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+18 "Mag.Atk.Bns."+18','"Fast Cast"+6','INT+8',}},
		--neck="Satlada Necklace",
		neck="Sanctity Necklace",
		--waist="Eschan Stone",
		waist="Refoccilation stone",
		left_ear="Friomisi Earring",
		ear2="Ishvara earring",
		--right_ear="Hermetic Earring",
		left_ring="Fenrir Ring",
		right_ring="Fenrir Ring",
		back="Toro Cape",
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+18 "Mag.Atk.Bns."+18','"Fast Cast"+6','INT+8',}},
	}
	sets.precast.WS['Flash Nova'] = set_combine(sets.precast.MagicalWS, {
	})
	sets.precast.WS['Rock Crusher'] = set_combine(sets.precast.MagicalWS, {
	})
	sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.MagicalWS, {
	})
	sets.precast.WS['Shattersoul'] = set_combine(sets.precast.MagicalWS, {
	})
	sets.precast.WS['Cataclysm'] = set_combine(sets.precast.MagicalWS, {
	})
	sets.precast.WS['Shining Strike'] = set_combine(sets.precast.MagicalWS, {
	})
	sets.precast.WS['Garland of Bliss'] = set_combine(sets.precast.MagicalWS, {
	})
else 
	sets.precast.WS['Garland of Bliss'] = { --left mab in moghouse, so use empty set
	}

end


--[#11 Midcast Sets ]--
sets.midcast.Cure = {
	main="Serenity",
	head="Vanya hood",--10%
	body="Vanya robe",
	hands="Reveal. Mitts +1",--14%
	legs="Vanya slops",
	feet="Vanya clogs",--5%
	left_ear="Mendicant's earring",--5%
	right_ear="Roundel Earring",--5%
	--right_ring="Sirona's Ring",
	right_ring="Lebeche Ring",--3%, -5 enmity
	left_ring="Ephedra Ring",
	neck="Nodens Gorget",--5%
	waist="Witful Belt",
	back="Thaumaturge's Cape"
}

--Notes, but outdated
--power:787.25
--cure potency: 50+19+3 
--haste:8+3+3+5+3+3 = 25
--conserve mp: 18
--enmity:-10 + -5 + -5

sets.midcast.Cure.Aurora = {--When you are SCH subjob and cast aurorastorm it will use these items for much more potent Cure 3
	main="Chatoyant Staff",--10%
	waist="Hachirin-No-Obi",--10%
	back="Twilight Cape",--5%
}
--potency: 10+14+5+5+5+5+10=54%  caps at 50%
--d/w: 25%
--Power = floor(MND÷2) + floor(VIT÷4) + Healing Magic Skill
-- 264/2 + 185/4 + 483 = 132 + 46 + 483 = 661  caps at 700 

sets.midcast.Cure.Self = {--cure recieved gear
	--neck="Phalaina locket",
	waist="Gishdubar Sash",
}

sets.midcast.Weather = {
	back="Twilight Cape"
}

sets.midcast.Refresh = {}

sets.midcast.Refresh.Self = {
	waist="Gishdubar Sash",
}

sets.midcast.Cursna = {
	right_ring="Sirona's Ring",
	left_ring="Ephedra Ring",
	head="Vanya hood",
	feet="Vanya clogs",
}          
sets.midcast.Cursna.Self = {
	waist="Gishdubar Sash",
}

sets.midcast['Enhancing Magic'] = {
	neck="Incanter's Torque", --+10
	body={ name="Telchine Chasuble", augments={'"Elemental Siphon"+30',}}, --+12
	right_ear="andoaa earring", --+5
	--feet="Regal Pumps +1", --+10
}

sets.midcast.Stoneskin = {
	neck="Nodens Gorget", --+30
	left_ear="Earthcry Earring", --+10
	--legs="Shedier Seraweels",--+35
	legs="Haven Hose",--+20
	waist="Siegel Sash",--+20
	feet="Apogee Pumps +1",--for MND
}
--350  + 80 = 430 hp
sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'],sets.midcast.Stoneskin)

if use_player_mab then
	sets.midcast['Elemental Magic'] = {
		--main="Malevolence",
		main={ name="Malevolence", augments={'INT+10','Mag. Acc.+10','"Mag.Atk.Bns."+10','"Fast Cast"+5',}},
		sub="Culminus", 
		--head={ name="Merlinic Hood", augments={'"Mag.Atk.Bns."+30','"Fast Cast"+6','MND+6','Mag. Acc.+4',}}, 
		head={ name="Merlinic Hood", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Mag. Acc.+7',}},
		--neck="Satlada Necklace",
		neck="Sanctity Necklace",
		ear1="Friomisi Earring",
		--ear2="Hecate's Earring",
		ear2="Hermetic Earring",
		left_ring="Fenrir Ring",
		right_ring="Fenrir Ring",
		--waist="Eschan Stone",
		--waist="Yamabuki-no-Obi",
		--waist="Eschan Stone",
		waist="Refoccilation stone",
		--back="Toro Cape",
		back=campestres,
		--body="Witching Robe",
		--body="Count's Garb",
		body="Gyve Doublet",
		--hands="Psycloth Manillas",
		hands={ name="Merlinic Dastanas", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','MND+3','Mag. Acc.+11',}},
		legs="Gyve trousers",
		--feet="Tutyr Sabots"
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+18 "Mag.Atk.Bns."+18','"Fast Cast"+6','INT+8',}},--Acc+18 INT+32
	}
else
	sets.midcast['Elemental Magic'] = {
		--main="Malevolence",
		main={ name="Malevolence", augments={'INT+10','Mag. Acc.+10','"Mag.Atk.Bns."+10','"Fast Cast"+5',}},
		sub="Culminus", 
		--head={ name="Merlinic Hood", augments={'"Mag.Atk.Bns."+30','"Fast Cast"+6','MND+6','Mag. Acc.+4',}}, 
		--neck="Satlada Necklace",
		neck="Sanctity Necklace",
		body="Gyve Doublet",
		--waist="Eschan Stone",
		--hands="Psycloth Manillas",
		legs="Gyve trousers",
		back=campestres,
	}
end
if use_enfeeb then --mostly useful as sch subjob for dispel, or helping proc immunobreak on rdm sub
	sets.midcast['Enfeebling Magic'] = {
		main="Grioavlr",--Acc+14 INT+19
		--head="Befouled Crown",--Acc+20 Skill+16 INT+33
		head={ name="Merlinic Hood", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Mag. Acc.+7',}},--Acc+44 INT+29 
		neck="Imbodla Necklace",--INT+7 Skill+5
		--ear1="Psystorm Earring",
		ear1="Lempo Earring",
		ear2="Hermetic Earring",
		--ring1="Fenrir Ring",--Acc+2
		--ring2="Fenrir Ring",--Acc+2
		body="Vanya Robe",--Acc+21 Skill+20 INT+31
		hands="Reveal. Mitts +1",--Acc+11 INT+11
		waist="Channeler's Stone",--INT+10
		--body="Cohort Cloak",
		legs="Psycloth Lappas",--Acc+35 INT+40 Skill+18
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+18 "Mag.Atk.Bns."+18','"Fast Cast"+6','INT+8',}},--Acc+18 INT+32
		--feet="Psycloth Lappas",--Acc+35 INT+40 Skill+18
		--ammo="Kalboron stone"
	}
	--Totals:
	--Acc:145
	--INT:183
	--Skill:43
	--combined vs hard target:371
end
--
--    sets.midcast['Dark Magic'] = {
--    }

sets.midcast.interruption = {
	main=smnskillstaff,
	sub="Vox Grip",
	ammo="Seraphicaller",
	head="Convoker's Horn +1",
	hands="Lamassu Mitts +1",
	neck="Incanter's Torque",
	waist="Lucidity sash",
	left_ear="Evans Earring",
	right_ear="Andoaa earring",
	--left_ring="Fervor Ring",
	left_ring="Globidonta Ring",
	right_ring="Evoker's ring",
	back=conveyance
}

--sets.midcast.interruption = set_combine(sets.petmab,sets.midcast.interruption)
-- Avatar pact sets.  All pacts are Ability type.


-- Spirits cast magic spells, which can be identified in standard ways.

--    sets.midcast.Pet.WhiteMagic = {
--	    ammo="Seraphicaller",
--	    main="Tumafyrig",
--	    head="Convoker's Horn +1 +1",
--	    neck="Caller's Pendant",
--	    ear1="Andoaa earring",
--	    ear2="Summoning earring",
--	    body="Anhur Robe",
--	    hands="Glyphic Bracers +1 +1",
--	    ring1="Evoker's Ring",
--	    ring2="Globidonta Ring",
--	    back="Conveyance cape",
--	    waist="Lucidity sash",
--	    legs="Marduk's Shalwar +1",
--	    sub="Vox grip",
--	    feet="Marduk's crackows +1"
--    }

--    sets.midcast.Pet['Elemental Magic'] = set_combine(sets.midcast.Pet.BloodPactRage, {legs="Helios spats"})
-- 
--    sets.midcast.Pet['Elemental Magic'].Resistant = {}


--[#12 Idle/DT sets ]--

-- Resting sets
sets.resting = {
	main="Chatoyant Staff",
	sub="Oneiros grip",
	waist="Fucho-no-obi",
	legs="Assiduity pants +1",
}

-- Idle sets
sets.idle = {
	main="Nirvana",
	sub="Vox Grip",
	ammo="Seraphicaller",
	head="Convoker's Horn +1",
	--body="Shomonjijoe +1",
	body="Apogee Dalmatica",
	hands="Asteria Mitts +1",
	legs="Assiduity pants +1",
	feet={ name="Merlinic Crackows", augments={'STR+10','Pet: "Mag.Atk.Bns."+23','"Refresh"+2','Accuracy+4 Attack+4','Mag. Acc.+9 "Mag.Atk.Bns."+9',}},
	neck="Loricate Torque +1",
	waist="Lucidity Sash",
	left_ear="Evans Earring",
	right_ear="Moonshade Earring",
	left_ring="Defending Ring",
	right_ring="Gelatinous Ring +1",
	back="Solemnity Cape",--4
}
sets.damagetaken = {}
sets.damagetaken.None = {
}
sets.damagetaken.DT = {
	head="Blistering sallet",
	body="Onca Suit",--10
	hands="",
	legs="",
	feet="",
	neck="Loricate Torque +1", --6
	left_ring="Defending Ring",--10
	back="Solemnity Cape",--4
}
sets.damagetaken.PDT = { --
	--main="Earth Staff", --20
	main="Mafic Cudgel", --10
	sub="Genmei Shield", --10
	left_ring="Defending Ring",--10
	right_ring="Gelatinous Ring +1",--6
	left_ear="Etiolation Earring", --3mdt
	neck="Loricate Torque +1", --6
	head="Blistering sallet",
	body="Onca Suit", --10
	hands="",
	legs="",
	feet="",
	back="Solemnity Cape"--4
	--back="Umbra Cape"--6, 12 at night
}
sets.damagetaken.MDT = {--Shell V is around 24%
	left_ring="Defending Ring",--10
	body="Onca Suit",--10
	back="Solemnity Cape",--4
	left_ear="Etiolation Earring", --3mdt
	neck="Loricate Torque +1", --6
	--left_ring="Vengeful Ring",--magiceva
}
sets.pullmode = {
	main="Mafic Cudgel", --10
	sub="Genmei Shield", --10
	right_ring="Gelatinous Ring +1",--7
	left_ring="Defending Ring",--10
	left_ear="Etiolation Earring", --3mdt
	neck="Loricate Torque +1", --6
	feet="Hippomenes Socks +1",
	back="Solemnity Cape"--4
	--back="Umbra Cape"--6, 12 at night
}
--sets.damagetaken.MagicEvasion = {
	--left_ring="Vengeful Ring",--9
	--right_ring="Purity Ring",--10
	--back="Felicitas Cape +1",--10
	--body="Onca Suit" -- 252
	--body 91, hands 48, legs 118, feet 118
	--left_ear="Eabani Earrng", --8
	--right_ear="Flashward Earrng", --8
	--head 86
	--
--}
sets.petdamagetaken = {}
sets.petdamagetaken.DT = {
	--main=bpmagicstaff,
	main="Sucellus",
	neck="Empath Necklace",
	left_ear="Handler's Earring +1",
	--right_ear="Handler's Earring",
	right_ear="Rimeice earring",
	legs="Psycloth Lappas",
}

sets.precast.FC.PDT = set_combine(sets.precast.FC, sets.damagetaken.PDT)
sets.idle.PDT = {--mixes refresh with pdt
	ammo="Seraphicaller",
	head="Convoker's Horn +1",
	--body="Shomonjijoe +1",
	body="Apogee Dalmatica",
	hands="Asteria Mitts +1",
	legs="Assiduity pants +1",
	--feet="Convoker's Pigaches +1",
	waist="Fucho-no-obi",
	left_ear="Andoaa earring",
	right_ear="Moonshade Earring",
	right_ring="Gelatinous Ring +1", --6
	left_ring="Defending Ring", --10
	back="Solemnity Mantle"--4
}

-- perp costs:
-- spirits: 7
-- carby: 11 (5 with mitts)
-- fenrir: 13
-- others: 15
-- avatar's favor: free, if you minimized perp cost already, -4 a tick with no -perp gear.  Weird I know but it's true, test it yourself

-- Max useful -perp gear is 1 less than the perp cost (can't be reduced below 1)
-- Aim for -14 perp, and refresh in other slots.
--

-- -perp gear:
-- Grivardor: -5
-- Glyphic Horn: -4
-- Caller's Doublet +2/Glyphic Doublet: -4
-- Evoker's Ring: -1
-- Convoker's Pigaches: -4
-- total: -18

-- Can make due without either the head or the body, and use +refresh items in those slots.


sets.idle.PDT = {}
sets.idle.Spirit = set_combine(sets.midcast.Pet.BloodPactWard, {main="Nirvana",right_ear="Moonshade Earring",legs="Glyphic Spats +1"})

--[#13 Perp Sets ]--
sets.favor= {}
sets.favor.mpsaver={ -- don't sacrifice refresh gear for smn skill gear
	main="Nirvana",
	sub="Vox Grip",
	ammo="Seraphicaller",
	head="Beckoner's Horn +1",
	--body="Shomonjijoe +1",
	body="Apogee Dalmatica",
	hands="Asteria Mitts +1",
	legs="Assiduity Pants +1",
	feet={ name="Merlinic Crackows", augments={'STR+10','Pet: "Mag.Atk.Bns."+23','"Refresh"+2','Accuracy+4 Attack+4','Mag. Acc.+9 "Mag.Atk.Bns."+9',}},
	neck="Caller's Pendant",
	waist="Lucidity sash",
	left_ear="Evans earring",
	right_ear="Moonshade Earring",
	left_ring="Globidonta Ring",
	right_ring="Evoker's ring",
	--back=conveyance
	back=campestres
}
sets.favor.allout={ -- equip all the favor and smn skill you can while not losing MP
	main="Nirvana",
	sub="Vox Grip",
	ammo="Seraphicaller",
	head="Beckoner's Horn +1",
	body="Beck. Doublet +1",
	hands="Asteria Mitts +1",
	legs="Beck. Spats +1",
	feet={ name="Apogee Pumps", augments={'MP+60','Summoning magic skill +15','Blood Pact Dmg.+7',}},
	neck="Incanter's Torque",
	waist="Lucidity Sash",
	left_ear="Andoaa Earring",
	right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','Latent effect: "Refresh"+1',}},
	left_ring="Globidonta Ring",
	right_ring="Evoker's Ring",
	back=conveyance
}

sets.idle.Avatar = { 
	main="Nirvana",
	sub="Vox Grip",
	head="Beckoner's Horn +1",
	--body="Shomonjijoe +1",
	body="Apogee Dalmatica",
	hands="Asteria Mitts +1",
	legs="Assiduity pants +1",
	neck="Caller's Pendant",
	ammo="Seraphicaller",
	waist="Lucidity sash",
	left_ear="Evans earring",
	right_ear="Moonshade Earring",
	feet={ name="Merlinic Crackows", augments={'STR+10','Pet: "Mag.Atk.Bns."+23','"Refresh"+2','Accuracy+4 Attack+4','Mag. Acc.+9 "Mag.Atk.Bns."+9',}},
	left_ring="Globidonta Ring",
	right_ring="Evoker's ring",
	--back=conveyance
	back=campestres
}
sets.idle.Spirit = set_combine(sets.midcast.Pet.BloodPactWard, {main="Nirvana",left_ear="Moonshade Earring",legs="Glyphic Spats +1"})
sets.perp = sets.idle.Avatar
sets.engaged = sets.perp 
sets.engaged.Perp = sets.perp


-- -5 staff
--    head +2
--    body +3
-- -3 pants +2
--    hands +2
--    earring +1
-- -1 ring
-- -2 waist
-- -8 feet
-- -2 earring
-- Caller's Bracer's halve the perp cost after other costs are accounted for.
-- Using -10 (Gridavor, ring, Conv.feet), standard avatars would then cost 5, halved to 2.
-- We can then use Hagondes Coat and end up with the same net MP cost, but significantly better defense.
-- Weather is the same, but we can also use the latent on the pendant to negate the last point lost.
--sets.perp.Day = {body="Hagondes Coat +1"}
--sets.perp.Weather = {neck="Caller's Pendant",body="Hagondes Coat +1"}
sets.perp.Weather = {neck="Caller's Pendant"}
-- Carby: Mitts+Conv.feet = 1/tick perp.  Everything else should be +refresh
--    sets.perp.Carbuncle = {
--	    hands="Carbuncle Mitts"
--    }
sets.perp.Carbuncle = set_combine(sets.perp, {hands="Asteria Mitts +1"})
sets.perp['Cait Sith'] = set_combine(sets.perp, {hands="Lamassu Mitts +1"})
sets.perp.LightSpirit = set_combine(sets.midcast.Pet.BloodPactWard, {main=smnskillstaff,right_ear="Moonshade Earring",legs="Glyphic Spats +1"})
sets.perp.AirSpirit = set_combine(sets.midcast.Pet.BloodPactWard, {legs="Glyphic Spats +1"})
sets.perp.FireSpirit = set_combine(sets.midcast.Pet.BloodPactWard, {legs="Glyphic Spats +1"})
--can add other spirits too 

--    sets.perp.staff_and_grip = {main=gear.perp_staff}
--[#14 Avatar Melee/DT Sets ]--
sets.Avatar = {}
sets.Avatar.Haste = { --Warning! This set equipped whenever your pet is engaged, even if you aren't
	main=avatarattackstaff,
	sub="Vox Grip",
	waist="Moepapa Stone",--5
	left_ear="Rimeice earring",--3
	--back="Penetrating Cape",
	neck="Empath necklace",
	back=campestres--10
--	head="Beckoner's Horn +1",
--	--body="Shomonjijoe +1",
--	body="Apogee Dalmatica",
--	hands="Asteria Mitts +1",
--	legs="Assiduity pants +1",
--	feet="Apogee pumps +1",
--	feet={ name="Merlinic Crackows", augments={'STR+10','Pet: "Mag.Atk.Bns."+23','"Refresh"+2','Accuracy+4 Attack+4','Mag. Acc.+9 "Mag.Atk.Bns."+9',}},
--	ammo="Seraphicaller",
--	right_ear="Moonshade Earring",
--	left_ring="Globidonta Ring",
--	right_ring="Evoker's ring",
}
--Pet Haste: 18
sets.Avatar.Haste.Full = { --Warning! This set equipped whenever your pet is engaged, even if you aren't
}


--[#15 Engaged Sets ]--
if use_melee then
	sets.engaged.Melee = {
		main="Nirvana",
		sub="Flanged Grip",
		head="Blistering Sallet",
		body="Onca Suit",
		neck="Subtlety spectacles",
		right_ring="Cacoethic Ring",
		left_ring="Cacoethic Ring +1",
		left_ear="Zennaroi Earring",
		right_ear="Dignitary's Earring",
		waist="Olseni Belt",
		back="Penetrating Cape"
	}

	sets.meleehybrid = {
		neck="Empath Necklace",
		left_ear="Zennaroi Earring",
		right_ear="Cessance Earring",
		waist="Olseni Belt",
	}
else
	sets.engaged.Melee = {
		sub="Flanged Grip",
		head={ name="Telchine Cap", augments={'"Elemental Siphon"+30',}},
		body="Onca Suit",
		right_ring="Evoker's Ring",
	}
	
end
-- For future use, ignore for now -- 
-- Magic Accuracy setting, overrides gear above
-- commented section here (anything after -- are comments) for future versions
--sets.bp_magic_acc = {
--	main=bpmagicaccstaff,
--	hands="Apogee Mitts",
--	back=conveyance
--}
---- Physical Accuracy setting, overrides physical pact
--sets.bp_phys_acc = {
--	hands="Apogee Mitts",
--	back=conveyance
--}
---- Hybrid Accuracy setting, overrides hybrid pact
--sets.bp_hybrid_acc = {
--	main=bpmagicaccstaff,
--	hands="Apogee Mitts",
--	back=conveyance
--}

--sets.midcast.FastRecast = {
--	    main="Marin Staff",
--	    sub="Vivid Strap",
--	    ammo="Seraphicaller",
--	    head="Haruspex hat",
--	    neck="Jeweled collar",
--	    ear2="Loquacious earring",
--	    hands="Regimen mittens",
--	    body="Vanir cotehardie",
--	    ring1="Weatherspoon ring",
--	    ring2="Prolix ring",
--	    back="Swith cape",
--	    waist="Witful belt",
--	    legs="Lengo pants",
--	    feet="Glyph pigaches +1"
--}
