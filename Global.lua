function set_macros(sheet,book)
    if book then 
        send_command('@input /macro book '..tostring(book)..';wait .1;input /macro set '..tostring(sheet))
        return
    end
    send_command('@input /macro set '..tostring(sheet))
end
 
function set_style(sheet)
    send_command('@input /lockstyleset '..sheet)
end
 
bp_physical=S{'Punch','Rock Throw','Barracuda Dive','Claw','Axe Kick','Shock Strike','Camisado','Regal Scratch',
	'Poison Nails','Moonlit Charge','Crescent Fang','Rock Buster','Tail Whip','Double Punch','Megalith Throw',
	'Double Slap','Eclipse Bite','Mountain Buster','Spinning Dive','Predator Claws','Rush','Chaotic Strike','Crag Throw','Volt Strike'
}

bp_hybrid=S{'Burning Strike','Flaming Crush'}

bp_magical=S{'Inferno','Earthen Fury','Tidal Wave','Aerial Blast','Diamond Dust','Judgment Bolt','Searing Light','Howling Moon',
	'Ruinous Omen','Fire II','Stone II','Water II','Aero II','Blizzard II','Thunder II','Thunderspark','Somnolence','Meteorite','Fire IV',
	'Stone IV','Water IV','Aero IV','Blizzard IV','Thunder IV','Nether Blast','Meteor Strike','Geocrush','Grand Fall','Wind Blade',
	'Heavenly Strike','Thunderstorm','Level ? Holy','Holy Mist','Lunar Bay','Night Terror','Conflag Strike'
}

bp_debuff=S{'Lunar Cry','Mewing Lullaby','Nightmare','Lunar Roar','Slowga','Ultimate Terror','Sleepga','Eerie Eye',
	'Tidal Roar','Diamond Storm','Shock Squall','Pavor Nocturnus'
}

bp_buff=S{'Shining Ruby','Frost Armor','Rolling Thunder','Crimson Howl','Lightning Armor','Ecliptic Growl','Hastega',
	'Noctoshield','Ecliptic Howl','Dream Shroud','Earthen Armor','Fleet Wind','Inferno Howl','Soothing Ruby','Heavenward Howl',
	'Soothing Current','Hastega II','Crystal Blessing'}

bp_other=S{'Healing Ruby','Raise II','Aerial Armor','Reraise II','Whispering Wind','Glittering Ruby','Earthen Ward','Spring Water','Healing Ruby II'
} 

AvatarList=S{'Shiva','Ramuh','Garuda','Leviathan','Diabolos','Titan','Fenrir','Ifrit','Carbuncle','Fire Spirit','Air Spirit','Ice Spirit',
	'Thunder Spirit','Light Spirit','Dark Spirit','Earth Spirit','Water Spirit','Cait Sith','Alexander','Odin','Atomos'
	}

spirit_element={Fire='Fire Spirit',Earth='Earth Spirit',Water='Water Spirit',Wind='Air Spirit',Ice='Ice Spirit',Lightning='Thunder Spirit',Light='Light Spirit',Dark='Dark Spirit'}

spirit_conflict={Fire='Ice',Earth='Lightning',Water='Fire',Wind='Earth',Ice='Wind',Lightning='Water',Light='Dark',Dark='Light'}