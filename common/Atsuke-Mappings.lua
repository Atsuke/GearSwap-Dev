version = "3.0"

-------------------------------------------------------------------------------------------------------------------
-- Spell mappings allow defining a general category or description that each of sets of related
-- spells all fall under.
-------------------------------------------------------------------------------------------------------------------


spell_maps = {
    ['Cure']='Cure',['Cure II']='Cure',['Cure III']='Cure',['Cure IV']='Cure',['Cure V']='Cure',['Cure VI']='Cure',
    ['Full Cure']='Cure',
    ['Cura']='Curaga',['Cura II']='Curaga',['Cura III']='Curaga',
    ['Curaga']='Curaga',['Curaga II']='Curaga',['Curaga III']='Curaga',['Curaga IV']='Curaga',['Curaga V']='Curaga',
    -- Status Removal doesn't include Esuna or Sacrifice, since they work differently than the rest
    ['Poisona']='StatusRemoval',['Paralyna']='StatusRemoval',['Silena']='StatusRemoval',['Blindna']='StatusRemoval',['Cursna']='StatusRemoval',
    ['Stona']='StatusRemoval',['Viruna']='StatusRemoval',['Erase']='StatusRemoval',
    ['Barfire']='BarElement',['Barstone']='BarElement',['Barwater']='BarElement',['Baraero']='BarElement',['Barblizzard']='BarElement',['Barthunder']='BarElement',
    ['Barfira']='BarElement',['Barstonra']='BarElement',['Barwatera']='BarElement',['Baraera']='BarElement',['Barblizzara']='BarElement',['Barthundra']='BarElement',
    ['Raise']='Raise',['Raise II']='Raise',['Raise III']='Raise',['Arise']='Raise',
    ['Reraise']='Reraise',['Reraise II']='Reraise',['Reraise III']='Reraise',['Reraise IV']='Reraise',
    ['Protect']='Protect',['Protect II']='Protect',['Protect III']='Protect',['Protect IV']='Protect',['Protect V']='Protect',
    ['Shell']='Shell',['Shell II']='Shell',['Shell III']='Shell',['Shell IV']='Shell',['Shell V']='Shell',
    ['Protectra']='Protectra',['Protectra II']='Protectra',['Protectra III']='Protectra',['Protectra IV']='Protectra',['Protectra V']='Protectra',
    ['Shellra']='Shellra',['Shellra II']='Shellra',['Shellra III']='Shellra',['Shellra IV']='Shellra',['Shellra V']='Shellra',
    ['Regen']='Regen',['Regen II']='Regen',['Regen III']='Regen',['Regen IV']='Regen',['Regen V']='Regen',
    ['Refresh']='Refresh',['Refresh II']='Refresh',['Refresh III']='Refresh',
    ['Teleport-Holla']='Teleport',['Teleport-Dem']='Teleport',['Teleport-Mea']='Teleport',['Teleport-Altep']='Teleport',['Teleport-Yhoat']='Teleport',
    ['Teleport-Vahzl']='Teleport',['Recall-Pashh']='Teleport',['Recall-Meriph']='Teleport',['Recall-Jugner']='Teleport',
    ['Valor Minuet']='Minuet',['Valor Minuet II']='Minuet',['Valor Minuet III']='Minuet',['Valor Minuet IV']='Minuet',['Valor Minuet V']='Minuet',
    ["Knight's Minne"]='Minne',["Knight's Minne II"]='Minne',["Knight's Minne III"]='Minne',["Knight's Minne IV"]='Minne',["Knight's Minne V"]='Minne',
    ['Advancing March']='March',['Victory March']='March',
    ['Sword Madrigal']='Madrigal',['Blade Madrigal']='Madrigal',
    ["Hunter's Prelude"]='Prelude',["Archer's Prelude"]='Prelude',
    ['Sheepfoe Mambo']='Mambo',['Dragonfoe Mambo']='Mambo',
    ['Raptor Mazurka']='Mazurka',['Chocobo Mazurka']='Mazurka',
    ['Sinewy Etude']='Etude',['Dextrous Etude']='Etude',['Vivacious Etude']='Etude',['Quick Etude']='Etude',['Learned Etude']='Etude',['Spirited Etude']='Etude',['Enchanting Etude']='Etude',
    ['Herculean Etude']='Etude',['Uncanny Etude']='Etude',['Vital Etude']='Etude',['Swift Etude']='Etude',['Sage Etude']='Etude',['Logical Etude']='Etude',['Bewitching Etude']='Etude',
    ["Mage's Ballad"]='Ballad',["Mage's Ballad II"]='Ballad',["Mage's Ballad III"]='Ballad',
    ["Army's Paeon"]='Paeon',["Army's Paeon II"]='Paeon',["Army's Paeon III"]='Paeon',["Army's Paeon IV"]='Paeon',["Army's Paeon V"]='Paeon',["Army's Paeon VI"]='Paeon',
    ['Fire Carol']='Carol',['Ice Carol']='Carol',['Wind Carol']='Carol',['Earth Carol']='Carol',['Lightning Carol']='Carol',['Water Carol']='Carol',['Light Carol']='Carol',['Dark Carol']='Carol',
    ['Fire Carol II']='Carol',['Ice Carol II']='Carol',['Wind Carol II']='Carol',['Earth Carol II']='Carol',['Lightning Carol II']='Carol',['Water Carol II']='Carol',['Light Carol II']='Carol',['Dark Carol II']='Carol',
    ['Foe Lullaby']='Lullaby',['Foe Lullaby II']='Lullaby',['Horde Lullaby']='Lullaby',['Horde Lullaby II']='Lullaby',
    ['Fire Threnody']='Threnody',['Ice Threnody']='Threnody',['Wind Threnody']='Threnody',['Earth Threnody']='Threnody',['Lightning Threnody']='Threnody',['Water Threnody']='Threnody',['Light Threnody']='Threnody',['Dark Threnody']='Threnody',
    ['Fire Threnody II']='Threnody',['Ice Threnody II']='Threnody',['Wind Threnody II']='Threnody',['Earth Threnody II']='Threnody',['Lightning Threnody II']='Threnody',['Water Threnody II']='Threnody',['Light Threnody II']='Threnody',['Dark Threnody II']='Threnody',
    ['Battlefield Elegy']='Elegy',['Carnage Elegy']='Elegy',
    ['Foe Requiem']='Requiem',['Foe Requiem II']='Requiem',['Foe Requiem III']='Requiem',['Foe Requiem IV']='Requiem',['Foe Requiem V']='Requiem',['Foe Requiem VI']='Requiem',['Foe Requiem VII']='Requiem',
    ['Utsusemi: Ichi']='Utsusemi',['Utsusemi: Ni']='Utsusemi',['Utsusemi: San']='Utsusemi',
    ['Katon: Ichi'] = 'ElementalNinjutsu',['Suiton: Ichi'] = 'ElementalNinjutsu',['Raiton: Ichi'] = 'ElementalNinjutsu',
    ['Doton: Ichi'] = 'ElementalNinjutsu',['Huton: Ichi'] = 'ElementalNinjutsu',['Hyoton: Ichi'] = 'ElementalNinjutsu',
    ['Katon: Ni'] = 'ElementalNinjutsu',['Suiton: Ni'] = 'ElementalNinjutsu',['Raiton: Ni'] = 'ElementalNinjutsu',
    ['Doton: Ni'] = 'ElementalNinjutsu',['Huton: Ni'] = 'ElementalNinjutsu',['Hyoton: Ni'] = 'ElementalNinjutsu',
    ['Katon: San'] = 'ElementalNinjutsu',['Suiton: San'] = 'ElementalNinjutsu',['Raiton: San'] = 'ElementalNinjutsu',
    ['Doton: San'] = 'ElementalNinjutsu',['Huton: San'] = 'ElementalNinjutsu',['Hyoton: San'] = 'ElementalNinjutsu',
    ['Banish']='Banish',['Banish II']='Banish',['Banish III']='Banish',['Banishga']='Banish',['Banishga II']='Banish',
    ['Holy']='Holy',['Holy II']='Holy',['Drain']='Drain',['Drain II']='Drain',['Drain III']='Drain',['Aspir']='Aspir',['Aspir II']='Aspir',
    ['Absorb-Str']='Absorb',['Absorb-Dex']='Absorb',['Absorb-Vit']='Absorb',['Absorb-Agi']='Absorb',['Absorb-Int']='Absorb',['Absorb-Mnd']='Absorb',['Absorb-Chr']='Absorb',
    ['Absorb-Acc']='Absorb',['Absorb-TP']='Absorb',['Absorb-Attri']='Absorb',
    ['Enlight']='Enlight',['Enlight II']='Enlight',['Endark']='Endark',['Endark II']='Endark',
    ['Burn']='ElementalEnfeeble',['Frost']='ElementalEnfeeble',['Choke']='ElementalEnfeeble',['Rasp']='ElementalEnfeeble',['Shock']='ElementalEnfeeble',['Drown']='ElementalEnfeeble',
    ['Pyrohelix']='Helix',['Cryohelix']='Helix',['Anemohelix']='Helix',['Geohelix']='Helix',['Ionohelix']='Helix',['Hydrohelix']='Helix',['Luminohelix']='Helix',['Noctohelix']='DarkHelix',
    ['Pyrohelix II']='Helix',['Cryohelix II']='Helix',['Anemohelix II']='Helix',['Geohelix II']='Helix',['Ionohelix II']='Helix',['Hydrohelix II']='Helix',['Luminohelix II']='Helix',['Noctohelix II']='DarkHelix',
    ['Firestorm']='Storm',['Hailstorm']='Storm',['Windstorm']='Storm',['Sandstorm']='Storm',['Thunderstorm']='Storm',['Rainstorm']='Storm',['Aurorastorm']='Storm',['Voidstorm']='Storm',
    ['Firestorm II']='Storm',['Hailstorm II']='Storm',['Windstorm II']='Storm',['Sandstorm II']='Storm',['Thunderstorm II']='Storm',['Rainstorm II']='Storm',['Aurorastorm II']='Storm',['Voidstorm II']='Storm',
    ['Fire Maneuver']='Maneuver',['Ice Maneuver']='Maneuver',['Wind Maneuver']='Maneuver',['Earth Maneuver']='Maneuver',['Thunder Maneuver']='Maneuver',['Water Maneuver']='Maneuver',['Light Maneuver']='Maneuver',['Dark Maneuver']='Maneuver',
    ['Enstone']='Enspell',['Enwater']='Enspell',['Enaero']='Enspell',['Enfire']='Enspell',['Enblizzard']='Enspell',['Enthunder']='Enspell',
    ['Gain-AGI']='Gain',['Gain-CHR']='Gain',['Gain-DEX']='Gain',['Gain-INT']='Gain',['Gain-MND']='Gain',['Gain-STR']='Gain',['Gain-VIT']='Gain',
	['Kurayami: Ichi'] = 'EnfeeblingNinjutsu', ['Hojo: Ichi'] = 'EnfeeblingNinjutsu', ['Dokumori: Ichi'] = 'EnfeeblingNinjutsu', ['Jubaku: Ichi'] = 'EnfeeblingNinjutsu',
	['Kurayami: Ni'] = 'EnfeeblingNinjutsu', ['Hojo: Ni'] = 'EnfeeblingNinjutsu', ['Aisha: Ichi'] = 'EnfeeblingNinjutsu', ['Yurin: Ichi'] = 'EnfeeblingNinjutsu', 
}

enfeeb_maps = {
    ['Dia']='potency', ['Dia II']='potency', ['Dia III']='potency',
    ['Bio']='potency', ['Bio II']='potency', ['Bio III']='potency',
    ['Paralyze']='mndpot', ['Paralyze II']='mndpot', 
    ['Slow']='mndpot', ['Slow II']='mndpot', 
    ['Addle']='mndpot', ['Addle II']='mndpot',
    ['Sleep']='macc', ['Sleep II']='macc', ['Sleepga']='macc', 
    ['Silence']='macc', 
    ['Inundation']='macc', 
    ['Dispel']='macc', 
    ['Break']='macc', 
    ['Bind']='macc', 
    ['Blind']='intpot', ['Blind II']='intpot', 
    ['Gravity']='potency', ['Gravity II']='potency',
    -- We leave Fazzle and FrazzleII as pure macc to help land it in cases its a high resist. 
    -- This lets us follow up with a high potency Frazzle3 
    ['Frazzle']='macc', ['Frazzle II']='macc', ['Frazzle III']='skillmndpot', 
    ['Distract']='skillmndpot', ['Distract II']='skillmndpot', ['Distract III']='skillmndpot', 
    ['Poison']='skillpot', ['Poison II']='skillpot', ['Poisonga']='skillpot',
}

 rolls = {
        ["Corsair's Roll"]   = {lucky=5, unlucky=9, bonus="Experience Points"},
        ["Ninja Roll"]       = {lucky=4, unlucky=8, bonus="Evasion"},
        ["Hunter's Roll"]    = {lucky=4, unlucky=8, bonus="Accuracy"},
        ["Chaos Roll"]       = {lucky=4, unlucky=8, bonus="Attack"},
        ["Magus's Roll"]     = {lucky=2, unlucky=6, bonus="Magic Defense"},
        ["Healer's Roll"]    = {lucky=3, unlucky=7, bonus="Cure Potency Received"},
        ["Puppet Roll"]      = {lucky=4, unlucky=8, bonus="Pet Magic Accuracy/Attack"},
        ["Choral Roll"]      = {lucky=2, unlucky=6, bonus="Spell Interruption Rate"},
        ["Monk's Roll"]      = {lucky=3, unlucky=7, bonus="Subtle Blow"},
        ["Beast Roll"]       = {lucky=4, unlucky=8, bonus="Pet Attack"},
        ["Samurai Roll"]     = {lucky=2, unlucky=6, bonus="Store TP"},
        ["Evoker's Roll"]    = {lucky=5, unlucky=9, bonus="Refresh"},
        ["Rogue's Roll"]     = {lucky=5, unlucky=9, bonus="Critical Hit Rate"},
        ["Warlock's Roll"]   = {lucky=4, unlucky=8, bonus="Magic Accuracy"},
        ["Fighter's Roll"]   = {lucky=5, unlucky=9, bonus="Double Attack Rate"},
        ["Drachen Roll"]     = {lucky=3, unlucky=7, bonus="Pet Accuracy"},
        ["Gallant's Roll"]   = {lucky=3, unlucky=7, bonus="Defense"},
        ["Wizard's Roll"]    = {lucky=5, unlucky=9, bonus="Magic Attack"},
        ["Dancer's Roll"]    = {lucky=3, unlucky=7, bonus="Regen"},
        ["Scholar's Roll"]   = {lucky=2, unlucky=6, bonus="Conserve MP"},
        ["Bolter's Roll"]    = {lucky=3, unlucky=9, bonus="Movement Speed"},
        ["Caster's Roll"]    = {lucky=2, unlucky=7, bonus="Fast Cast"},
        ["Courser's Roll"]   = {lucky=3, unlucky=9, bonus="Snapshot"},
        ["Blitzer's Roll"]   = {lucky=4, unlucky=9, bonus="Attack Delay"},
        ["Tactician's Roll"] = {lucky=5, unlucky=8, bonus="Regain"},
        ["Allies's Roll"]    = {lucky=3, unlucky=10, bonus="Skillchain Damage"},
        ["Miser's Roll"]     = {lucky=5, unlucky=7, bonus="Save TP"},
        ["Companion's Roll"] = {lucky=2, unlucky=10, bonus="Pet Regain and Regen"},
        ["Avenger's Roll"]   = {lucky=4, unlucky=8, bonus="Counter Rate"},
    }

quickdraw = {['Earth']="Earth Shot",      ['Water']="Water Shot",      ['Air']="Wind Shot",     ['Fire']="Fire Shot",    ['Ice']="Ice Shot",     ['Lightning']="Thunder Shot", ['Light']="Light Shot", ['Dark']="Dark Shot"}

elements =  M('Ice', 'Air', 'Dark', 'Light', 'Earth', 'Lightning', 'Water', 'Fire')
ninElements = M('Earth', 'Air', 'Ice', 'Fire', 'Water', 'Lightning')

element = {}
element.weak_to = {['Light']='Dark', ['Dark']='Light', ['Fire']='Ice', ['Ice']='Wind', ['Wind']='Earth', ['Earth']='Lightning',
        ['Lightning']='Water', ['Water']='Fire'}

element.strong_to = {['Light']='Dark', ['Dark']='Light', ['Fire']='Water', ['Ice']='Fire', ['Wind']='Ice', ['Earth']='Wind',
        ['Lightning']='Earth', ['Water']='Lightning'}

enspellElements =  M('Ice', 'Air', 'Earth', 'Lightning', 'Water', 'Fire')

nukes = {}
nukes.t1 = {['Earth']="Stone",      ['Water']="Water",      ['Air']="Aero",     ['Fire']="Fire",    ['Ice']="Blizzard",     ['Lightning']="Thunder", ['Light']="Thunder", ['Dark']="Blizzard"}
nukes.t2 = {['Earth']="Stone II",   ['Water']="Water II",   ['Air']="Aero II",  ['Fire']="Fire II", ['Ice']="Blizzard II",  ['Lightning']="Thunder II", ['Light']="Thunder II", ['Dark']="Blizzard II"}
nukes.t3 = {['Earth']="Stone III",  ['Water']="Water III",  ['Air']="Aero III", ['Fire']="Fire III",['Ice']="Blizzard III", ['Lightning']="Thunder III", ['Light']="Thunder III", ['Dark']="Blizzard III"}
nukes.t4 = {['Earth']="Stone IV",   ['Water']="Water IV",   ['Air']="Aero IV",  ['Fire']="Fire IV", ['Ice']="Blizzard IV",  ['Lightning']="Thunder IV", ['Light']="Thunder IV", ['Dark']="Blizzard IV"}
nukes.t5 = {['Earth']="Stone V",    ['Water']="Water V",    ['Air']="Aero V",   ['Fire']="Fire V",  ['Ice']="Blizzard V",   ['Lightning']="Thunder V", ['Light']="Thunder V", ['Dark']="Blizzard V"}
nukes.helix2 = {['Earth']="Geohelix II",  ['Water']="Hydrohelix II", ['Air']="Anemohelix II",['Fire']="Pyrohelix II", ['Ice']="Cryohelix II", ['Lightning']="Ionohelix II",    ['Light']="Luminohelix II", ['Dark']="Noctohelix II"}
nukes.helix = {['Earth']="Geohelix",  ['Water']="Hydrohelix", ['Air']="Anemohelix",['Fire']="Pyrohelix", ['Ice']="Cryohelix", ['Lightning']="Ionohelix",    ['Light']="Luminohelix", ['Dark']="Noctohelix"}
nukes.storm = {['Earth']="Sandstorm", ['Water']="Rainstorm",  ['Air']="Windstorm", ['Fire']="Firestorm", ['Ice']="Hailstorm", ['Lightning']="Thunderstorm", ['Light']="Aurorastorm", ['Dark']="Voidstorm"}
nukes.storm2 = {['Earth']="Sandstorm II", ['Water']="Rainstorm II",  ['Air']="Windstorm II", ['Fire']="Firestorm II", ['Ice']="Hailstorm II", ['Lightning']="Thunderstorm II", ['Light']="Aurorastorm II", ['Dark']="Voidstorm II"}
nukes.enspell = {['Earth']="Enstone", ['Water']="Enwater",  ['Air']="Enaero", ['Fire']="Enfire", ['Ice']="Enblizzard", ['Lightning']="Enthunder", ['Light']="Enthunder", ['Dark']="Enblizzard"}
nukes.ra1 = {['Earth']="Stonera",    ['Water']="Watera",    ['Air']="Aera",    ['Fire']="Fira",    ['Ice']="Blizzara",    ['Lightning']="Thundara",    ['Light']="Thundara",    ['Dark']="Blizzara"}
nukes.ra2 = {['Earth']="Stonera II", ['Water']="Watera II", ['Air']="Aera II", ['Fire']="Fira II", ['Ice']="Blizzara II", ['Lightning']="Thundara II", ['Light']="Thundara II", ['Dark']="Blizzara II"}
nukes.ra3 = {['Earth']="Stonera III",['Water']="Watera III",['Air']="Aera III",['Fire']="Fira III",['Ice']="Blizzara III",['Lightning']="Thundara III",['Light']="Thundara III",['Dark']="Blizzara III"}

ninjaNukes = {}
ninjaNukes.t1 = {['Earth']="Doton: Ichi",      ['Water']="Suiton: Ichi",      ['Air']="Huton: Ichi",     ['Fire']="Katon: Ichi",    ['Ice']="Hyoton: Ichi",     ['LightIching']="Raiton: Ichi"}
ninjaNukes.t2 = {['Earth']="Doton: Ni",        ['Water']="Suiton: Ni",        ['Air']="Huton: Ni",       ['Fire']="Katon: Ni",      ['Ice']="Hyoton: Ni",       ['LightNing']="Raiton: Ni"}
ninjaNukes.t3 = {['Earth']="Doton: San",       ['Water']="Suiton: San",       ['Air']="Huton: San",      ['Fire']="Katon: San",     ['Ice']="Hyoton: San",      ['LightSanng']="Raiton: San"}
 

storms = S{"Aurorastorm", "Voidstorm", "Firestorm", "Sandstorm", "Rainstorm", "Windstorm", "Hailstorm", "Thunderstorm",
		"Aurorastorm II", "Voidstorm II", "Firestorm II", "Sandstorm II", "Rainstorm II", "Windstorm II", "Hailstorm II", "Thunderstorm II"}

elements.storm_of = {['Light']="Aurorastorm", ['Dark']="Voidstorm", ['Fire']="Firestorm", ['Earth']="Sandstorm",
        ['Water']="Rainstorm", ['Wind']="Windstorm", ['Ice']="Hailstorm", ['Lightning']="Thunderstorm",['Light']="Aurorastorm II",
		['Dark']="Voidstorm II", ['Fire']="Firestorm II", ['Earth']="Sandstorm II", ['Water']="Rainstorm II", ['Wind']="Windstorm II",
		['Ice']="Hailstorm II", ['Lightning']="Thunderstorm II"}

spirits = S{"LightSpirit", "DarkSpirit", "FireSpirit", "EarthSpirit", "WaterSpirit", "AirSpirit", "IceSpirit", "ThunderSpirit"}
elements.spirit_of = {['Light']="Light Spirit", ['Dark']="Dark Spirit", ['Fire']="Fire Spirit", ['Earth']="Earth Spirit",
        ['Water']="Water Spirit", ['Wind']="Air Spirit", ['Ice']="Ice Spirit", ['Lightning']="Thunder Spirit"}

runes = S{'Lux', 'Tenebrae', 'Ignis', 'Gelus', 'Flabra', 'Tellus', 'Sulpor', 'Unda'}
elements.rune_of = {['Light']='Lux', ['Dark']='Tenebrae', ['Fire']='Ignis', ['Ice']='Gelus', ['Wind']='Flabra',
     ['Earth']='Tellus', ['Lightning']='Sulpor', ['Water']='Unda'}



avatars = M('Carbuncle', 'Fenrir', 'Ifrit', 'Titan', 'Leviathan', 'Garuda', 'Shiva', 'Ramuh', 'Diabolos', 'Cait Sith', 'Siren')

carbuncle_rage = M('Searing Light', 'Poison Nails', 'Meteorite', 'Holy Mist')
carbuncle_ward = M('Healing Ruby', 'Shining Ruby', 'Glittering Ruby', 'Healing Ruby II', 'Soothing Ruby', 'Pacifying Ruby')
fenrir_rage = M('Howling Moon', 'Moonlit Charge', 'Crescent Fang', 'Eclipse Bite', 'Lunar Bay', 'Impact')
fenrir_ward = M('Lunar Cry', 'Lunar Roar', 'Ecliptic Growl', 'Ecliptic Howl', 'Heavenward Howl')
ifrit_rage = M('Inferno', 'Punch', 'Fire II', 'Burning Strike', 'Double Punch', 'Fire IV', 'Flaming Crush', 'Meteor Strike', 'Conflag Strike')
ifrit_ward = M('Crimson Howl', 'Inferno Howl')
titan_rage = M('Earthen Fury', 'Rock Throw', 'Stone II', 'Rock Buster', 'Megalith Throw', 'Stone IV', 'Mountain Buster', 'Geocrush', 'Crag Throw')
titan_ward = M('Earthen Ward', 'Earthen Armor')
leviathan_rage = M('Tidal Wave', 'Barracuda Dive', 'Water II', 'Tail Whip', 'Water IV', 'Spinning Dive', 'Grand Fall')
leviathan_ward = M('Slowga', 'Spring Water', 'Tidal Roar', 'Soothing Current')
garuda_rage = M('Aerial Blast', 'Claw', 'Aero II', 'Aero IV', 'Predator Claws', 'Wind Blade')
garuda_ward = M('Aerial Armor', 'Whispering Wind', 'Hastega', 'Fleet Wind', 'Hastega II')
shiva_rage = M('Diamond Dust', 'Axe Kick', 'Blizzard II', 'Double Slap', 'Blizzard IV', 'Rush', 'Heavenly Strike')
shiva_ward = M('Frost Armor', 'Sleepga', 'Diamond Storm', 'Crystal Blessing')
ramuh_rage = M('Judgment Bolt', 'Shock Strike', 'Thunder II', 'Thunderspark', 'Thunder IV', 'Chaotic Strike', 'Thunderstorm', 'Volt Strike')
ramuh_ward = M('Rolling Thunder', 'Lightning Armor', 'Shock Squall')
diabolos_rage = M('Ruinous Omen', 'Camisado', 'Nether Blast', 'Night Terror', 'Blindside')
diabolos_ward = M('Somnolence', 'Nightmare', 'Ultimate Terror', 'Noctoshield', 'Dream Shroud', 'Pavor Nocturnus')
cait_sith_rage = M('Regal Scratch', 'Level ? Holy', 'Regal Gash')
cait_sith_ward = M('Altana\'s Favor', 'Raise II', 'Mewing Lulaby', 'Reraise II', 'Eerie Eye')
siren_rage = M('Clarsach Call', 'Welt', 'Roundhouse', 'Sonic Buffet', 'Tornado II', 'Hysteric Assault')
siren_ward = M('Lunatic Voice', 'Katabatic Blades', 'Chinook', 'Bitter Elegy', 'Wind\'s Blessing')
alexander_ward = M('Perfect Defense')


bp_physical=S{'Punch','Rock Throw','Barracuda Dive','Claw','Axe Kick','Shock Strike','Camisado','Regal Scratch',
	'Poison Nails','Moonlit Charge','Crescent Fang','Rock Buster','Tail Whip','Double Punch','Megalith Throw',
	'Double Slap','Eclipse Bite','Mountain Buster','Spinning Dive','Predator Claws','Rush','Chaotic Strike','Crag Throw',
	'Volt Strike', 'Welt', 'Roundhouse', 'Hysteric Assault'
}

bp_hybrid=S{'Burning Strike','Flaming Crush'}

bp_magical=S{'Inferno','Earthen Fury','Tidal Wave','Aerial Blast','Diamond Dust','Judgment Bolt','Searing Light','Howling Moon',
	'Ruinous Omen','Fire II','Stone II','Water II','Aero II','Blizzard II','Thunder II','Thunderspark','Somnolence','Meteorite','Fire IV',
	'Stone IV','Water IV','Aero IV','Blizzard IV','Thunder IV','Nether Blast','Meteor Strike','Geocrush','Grand Fall','Wind Blade',
	'Heavenly Strike','Thunderstorm','Level ? Holy','Holy Mist','Lunar Bay','Night Terror','Conflag Strike', 'Clarsach Call',
	'Sonic Buffet', 'Tornado II'
}

bp_debuff=S{'Lunar Cry','Mewing Lullaby','Nightmare','Lunar Roar','Slowga','Ultimate Terror','Sleepga','Eerie Eye',
	'Tidal Roar','Diamond Storm','Shock Squall','Pavor Nocturnus', 'Lunatic Voice', 'Bitter Elegy'
}

bp_buff=S{'Shining Ruby','Frost Armor','Rolling Thunder','Crimson Howl','Lightning Armor','Ecliptic Growl','Hastega',
	'Noctoshield','Ecliptic Howl','Dream Shroud','Earthen Armor','Fleet Wind','Inferno Howl','Soothing Ruby','Heavenward Howl',
	'Soothing Current','Hastega II','Crystal Blessing','Healing Ruby','Raise II','Aerial Armor','Reraise II',
	'Whispering Wind','Glittering Ruby','Earthen Ward','Spring Water','Healing Ruby II', 'Katabatic Blades', 'Wind\'s Blessing', 'Chinook', 'Perfect Defense'
}


geomancy = M('Geo-Acumen', 'Geo-Attunement', 'Geo-Barrier', 'Geo-STR', 'Geo-DEX', 'Geo-VIT', 'Geo-AGI', 'Geo-INT', 'Geo-MND', 'Geo-CHR', 'Geo-Fade',
             'Geo-Fend', 'Geo-Focus', 'Geo-Frailty', 'Geo-Fury', 'Geo-Gravity', 'Geo-Haste', 'Geo-Languor', 'Geo-Malaise', 'Geo-Paralysis', 
             'Geo-Poison', 'Geo-Precision', 'Geo-Refresh', 'Geo-Regen', 'Geo-Slip', 'Geo-Slow', 'Geo-Torpor', 'Geo-Vex', 'Geo-Voidance', 'Geo-Wilt')
indicolure = M('Indi-Acumen', 'Indi-Attunement', 'Indi-Barrier', 'Indi-STR', 'Indi-DEX', 'Indi-VIT', 'Indi-AGI', 'Indi-INT', 'Indi-MND', 'Indi-CHR', 'Indi-Fade',
             'Indi-Fend', 'Indi-Focus', 'Indi-Frailty', 'Indi-Fury', 'Indi-Gravity', 'Indi-Haste', 'Indi-Languor', 'Indi-Malaise', 'Indi-Paralysis', 
             'Indi-Poison', 'Indi-Precision', 'Indi-Refresh', 'Indi-Regen', 'Indi-Slip', 'Indi-Slow', 'Indi-Torpor', 'Indi-Vex', 'Indi-Voidance', 'Indi-Wilt')
entrustindi = M('Indi-Acumen', 'Indi-Attunement', 'Indi-Barrier', 'Indi-STR', 'Indi-DEX', 'Indi-VIT', 'Indi-AGI', 'Indi-INT', 'Indi-MND', 'Indi-CHR', 'Indi-Fade',
             'Indi-Fend', 'Indi-Focus', 'Indi-Frailty', 'Indi-Fury', 'Indi-Gravity', 'Indi-Haste', 'Indi-Languor', 'Indi-Malaise', 'Indi-Paralysis', 
             'Indi-Poison', 'Indi-Precision', 'Indi-Refresh', 'Indi-Regen', 'Indi-Slip', 'Indi-Slow', 'Indi-Torpor', 'Indi-Vex', 'Indi-Voidance', 'Indi-Wilt')

roll_1 = M("Corsair's Roll", "Ninja Roll", "Hunter's Roll", "Chaos Roll", "Magus's Roll", "Healer's Roll", "Puppet Roll", "Choral Roll", "Monk's Roll",
		   "Beast Roll", "Samurai Roll", "Evoker's Roll", "Rogue's Roll", "Warlock's Roll", "Fighter's Roll", "Drachen Roll", "Gallant's Roll", "Wizard's Roll",
		   "Dancer's Roll", "Scholar's Roll", "Bolter's Roll", "Caster's Roll", "Courser's Roll", "Blitzer's Roll", "Tactician's Roll", "Allies's Roll", 
		   "Miser's Roll", "Companion's Roll", "Avenger's Roll")

roll_2 = M("Corsair's Roll", "Ninja Roll", "Hunter's Roll", "Chaos Roll", "Magus's Roll", "Healer's Roll", "Puppet Roll", "Choral Roll", "Monk's Roll",
		   "Beast Roll", "Samurai Roll", "Evoker's Roll", "Rogue's Roll", "Warlock's Roll", "Fighter's Roll", "Drachen Roll", "Gallant's Roll", "Wizard's Roll",
		   "Dancer's Roll", "Scholar's Roll", "Bolter's Roll", "Caster's Roll", "Courser's Roll", "Blitzer's Roll", "Tactician's Roll", "Allies's Roll", 
		   "Miser's Roll", "Companion's Roll", "Avenger's Roll")



-- Colors for elements
Colors = {
    ["Fire"] = "\\cs(204, 0, 0)", 
    ["Water"] = "\\cs(0, 102, 204)", 
    ["Air"] = "\\cs(51, 102, 0)", 
    ["Light"] = "\\cs(255, 255, 255)", 
    ["Earth"] = "\\cs(139, 139, 19)", 
    ["Ice"] = "\\cs(0, 204, 204)", 
    ["Lightning"] = "\\cs(102, 0, 204)",
    ['Dark']="\\cs(92, 92, 92)"
}

skillchains = {
    [288] = {id=288,english='Light',elements={'Light','Fire','Lightning','Wind'}, color=Colors[4]},
    [289] = {id=289,english='Darkness',elements={'Dark','Earth','Water','Ice'}, color=Colors[8]},
    [290] = {id=290,english='Gravitation',elements={'Earth', 'Dark'}, color=Colors[5]},
    [291] = {id=291,english='Fragmentation',elements={'Lightning','Wind'}, color=Colors[7]},
    [292] = {id=292,english='Distortion',elements={'Ice', 'Water'}, color=Colors[6]},
    [293] = {id=293,english='Fusion',elements={'Fire', 'Light'}, color=Colors[1]},
    [294] = {id=294,english='Compression',elements={'Dark'}, color=Colors[8]},
    [295] = {id=295,english='Liquefaction',elements={'Fire'}, color=Colors[1]},
    [296] = {id=296,english='Induration',elements={'Ice'}, color=Colors[6]},
    [297] = {id=297,english='Reverberation',elements={'Water'}, color=Colors[2]},
    [298] = {id=298,english='Transfixion', elements={'Light'}, color=Colors[4]},
    [299] = {id=299,english='Scission',elements={'Earth'}, color=Colors[5]},
    [300] = {id=300,english='Detonation',elements={'Wind'}, color=Colors[3]},
    [301] = {id=301,english='Impaction',elements={'Lightning'}, color=Colors[7]}
}



avatarColors = {
	["Carbuncle"] = Colors["Light"],
	["Fenrir"] = Colors["Dark"],
	["Ifrit"] = Colors["Fire"],
	["Titan"] = Colors['Earth'],
	["Leviathan"] = Colors['Water'],
	["Garuda"] = Colors['Air'],
	["Shiva"] = Colors['Ice'],
	["Ramuh"] = Colors['Lightning'],
	["Diabolos"] = Colors['Dark'],
	["Cait Sith"] = Colors['Light'],
	["Siren"] = Colors['Air'],
}

tier1sc =   {}
tier1sc['Ice'] = 'Induration'
tier1sc['Air'] ='Detonation'
tier1sc['Dark'] = 'Compression' 
tier1sc['Light'] = 'Transfixion'
tier1sc['Earth'] = 'Scission'
tier1sc['Lightning'] = 'Impaction'
tier1sc['Water'] = 'Reverberation'
tier1sc['Fire'] = 'Liquefaction'

tier2sc =   {}
tier2sc['Ice'] = 'Distortion'
tier2sc['Air'] ='Fragmentation'
tier2sc['Dark'] = 'Gravitation' 
tier2sc['Light'] = 'Fusion'
tier2sc['Earth'] = 'Gravitation'
tier2sc['Lightning'] = 'Fragmentation'
tier2sc['Water'] = 'Distortion'
tier2sc['Fire'] = 'Fusion'


areas = {}

-- City areas for town gear and behavior.
areas.Cities = S{
    "Ru'Lude Gardens",
    "Upper Jeuno",
    "Lower Jeuno",
    "Port Jeuno",
    "Port Windurst",
    "Windurst Waters",
    "Windurst Woods",
    "Windurst Walls",
    "Heavens Tower",
    "Port San d'Oria",
    "Northern San d'Oria",
    "Southern San d'Oria",
    "Port Bastok",
    "Bastok Markets",
    "Bastok Mines",
    "Metalworks",
    "Aht Urhgan Whitegate",
    "Tavnazian Safehold",
    "Nashmau",
    "Selbina",
    "Mhaura",
    "Norg",
    "Eastern Adoulin",
    "Western Adoulin",
    "Kazham",
    "Rabao",
    "Chocobo Circuit",
}
-- Adoulin areas, where Ionis will grant special stat bonuses.
areas.Adoulin = S{
    "Yahse Hunting Grounds",
    "Ceizak Battlegrounds",
    "Foret de Hennetiel",
    "Morimar Basalt Fields",
    "Yorcia Weald",
    "Yorcia Weald [U]",
    "Cirdas Caverns",
    "Cirdas Caverns [U]",
    "Marjami Ravine",
    "Kamihr Drifts",
    "Sih Gates",
    "Moh Gates",
    "Dho Gates",
    "Woh Gates",
    "Rala Waterways",
    "Rala Waterways [U]",
    "Outer Ra'Kaznar",
    "Outer Ra'Kaznar [U]"
}
