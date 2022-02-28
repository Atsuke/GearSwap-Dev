--------------------------------------------------
--Generic Declaration
--------------------------------------------------
    Amal = {}
    Amal.Head = {}
    Amal.Body = {}
    Amal.Hands = {}
    Amal.Legs = {}
    Amal.Feet = {}
    Merl = {}
    Merl.Head = {}
    Merl.Body = {}
    Merl.Hands = {}
    Merl.Legs = {}
    Merl.Feet = {}
    Adh = {}
    Adh.Head = {}
    Adh.Body = {}
    Adh.Hands = {}
    Adh.Legs = {}
    Adh.Feet = {}
    Lustr = {}
    Lustr.Head = {}
    Lustr.Body = {}
    Lustr.Hands = {}
    Lustr.Legs = {}
    Lustr.Feet = {}
    Rao = {}
    Rao.Head = {}
    Rao.Body = {}
    Rao.Hands = {}
    Rao.Legs = {}
    Rao.Feet = {}
    Ryuo = {}
    Ryuo.Head = {}
    Ryuo.Body = {}
    Ryuo.Hands = {}
    Ryuo.Legs = {}
    Ryuo.Feet = {}
    Herc = {}
    Herc.Head = {}
    Herc.Body = {}
    Herc.Hands = {}
    Herc.Legs = {}
    Herc.Feet = {}
    Chiro = {}
    Chiro.Head = {}
    Chiro.Body = {}
    Chiro.Hands = {}
    Chiro.Legs = {}
    Chiro.Feet = {}
    Carm = {}
    Carm.Head = {}
    Carm.Body = {}
    Carm.Hands = {}
    Carm.Legs = {}
    Carm.Feet = {}
    Kayk = {}
    Kayk.Head = {}
    Kayk.Body = {}
    Kayk.Hands = {}
    Kayk.Legs = {}
    Kayk.Feet = {}
    Taeon = {}
    Taeon.Head = {}
    Taeon.Body = {}
    Taeon.Hands = {}
    Taeon.Legs = {}
    Taeon.Feet = {}
	Van = {}
	Van.Head = {}
	Van.Body = {}
	Van.Hands = {}
	Van.Legs = {}
	Van.Feet ={}
	Telchine = {}
	Telchine.Head = {}
	Telchine.Body = {}
	Telchine.Hands = {}
	Telchine.Legs = {}
	Telchine.Feet ={}
--------------------------------------------------
--------------------------------------------------    

-- This helps when your augment changes to only have 1 place to update. 



	Amal.Body.D			=	{ name="Amalric Doublet +1", augments={'MP+80','"Mag.Atk.Bns."+25','"Fast Cast"+4',}}
	Telchine.Head.en    =   { name="Telchine Cap", augments={'Enh. Mag. eff. dur. +8',}}
	Telchine.Legs.en    =   { name="Telchine Braconi", augments={'Enh. Mag. eff. dur. +10',}}
	Telchine.Feet.en    =   { name="Telchine Pigaches", augments={'Enh. Mag. eff. dur. +10',}}

    
	Merl.Body.FC		=	{ name="Merlinic Jubbah", augments={'"Fast Cast"+6','INT+1','Mag. Acc.+13','"Mag.Atk.Bns."+15',}}
	Merl.Legs.MB		=	{ name="Merlinic Shalwar", augments={'Mag. Acc.+28','Magic burst dmg.+9%','INT+2','"Mag.Atk.Bns."+15',}}
	Merl.Feet.MAB       =   { name="Merlinic Crackows", augments={'Mag. Acc.+13 "Mag.Atk.Bns."+13','"Conserve MP"+1','MND+9','Mag. Acc.+7','"Mag.Atk.Bns."+12',}}
	Van.Head.ConMP      =   { name="Vanya Hood", augments={'MND+10','Spell interruption rate down +15%','"Conserve MP"+6',}}
	Van.Hands.C         =   { name="Vanya Cuffs", augments={'MND+10','Spell interruption rate down +15%','"Conserve MP"+6',}}

	Herc.Feet.MAB       =   { name="Herculean Boots", augments={'"Mag.Atk.Bns."+23','MND+10',}}
	Herc.Hands.WSD      =   { name="Herculean Gloves", augments={'Weapon skill damage +4%','Pet: INT+9','Chance of successful block +4','Mag. Acc.+17 "Mag.Atk.Bns."+17',}}
	Herc.Legs.WSD       =    { name="Herculean Trousers", augments={'Pet: "Mag.Atk.Bns."+4','DEX+7','Weapon skill damage +6%',}}

	Rao.Head.C			=	{ name="Rao Kabuto +1", augments={'Pet: HP+125','Pet: Accuracy+20','Pet: Damage taken -4%',}}
	Rao.Body.C			=	{ name="Rao Togi +1", augments={'Pet: HP+125','Pet: Accuracy+20','Pet: Damage taken -4%',}}
	Rao.Hands.C			=	{ name="Rao Kote +1", augments={'Pet: HP+125','Pet: Accuracy+20','Pet: Damage taken -4%',}}
	Rao.Feet.C			=	{ name="Rao Sune-Ate +1", augments={'Pet: HP+125','Pet: Accuracy+20','Pet: Damage taken -4%',}}
	
	Ryuo.Hands.A		=	{ name="Ryuo Tekko +1", augments={'STR+12','DEX+12','Accuracy+20',}}
	Ryuo.Feet.D			=	{ name="Ryuo Sune-Ate +1", augments={'STR+12','Attack+25','Crit. hit rate+4%',}}



	Taeon.Head.PetDT    = { name="Taeon Chapeau", augments={'Pet: Accuracy+25 Pet: Rng. Acc.+25','Pet: "Dbl. Atk."+5','Pet: Damage taken -4%',}}
	Taeon.Body.PetDT    ={ name="Taeon Tabard", augments={'Pet: Accuracy+25 Pet: Rng. Acc.+25','Pet: "Dbl. Atk."+5','Pet: Damage taken -4%',}}
	Taeon.Hands.PetDT   ={ name="Taeon Gloves", augments={'Pet: Accuracy+23 Pet: Rng. Acc.+23','Pet: "Dbl. Atk."+5','Pet: Damage taken -4%',}}
	Taeon.Legs.PetDT    ={ name="Taeon Tights", augments={'Pet: Accuracy+20 Pet: Rng. Acc.+20','Pet: "Dbl. Atk."+5','Pet: Damage taken -4%',}}
	Taeon.Feet.PetDT    ={ name="Taeon Boots", augments={'Pet: Accuracy+25 Pet: Rng. Acc.+25','Pet: "Dbl. Atk."+5','Pet: Damage taken -4%',}}