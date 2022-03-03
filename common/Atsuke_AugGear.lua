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
    Vanya = {}
	Vanya.Head = {}
	Vanya.Body = {}
	Vanya.Hands = {}
	Vanya.Legs = {}
	Vanya.Feet ={}
	Taeon = {}
    Taeon.Head = {}
    Taeon.Body = {}
    Taeon.Hands = {}
    Taeon.Legs = {}
    Taeon.Feet = {}
	Psycloth = {}
    Psycloth.Head = {}
    Psycloth.Body = {}
    Psycloth.Hands = {}
    Psycloth.Legs = {}
    Psycloth.Feet = {}
	Telchine = {}
	Telchine.Head = {}
	Telchine.Body = {}
	Telchine.Hands = {}
	Telchine.Legs = {}
	Telchine.Feet ={}
	Apo = {}
	Apo.Head = {}
	Apo.Body = {}
	Apo.Hands = {}
	Apo.Legs = {}
	Apo.Feet ={}
	Helios = {}
	Helios.Head = {}
	Helios.Body = {}
	Helios.Hands = {}
	Helios.Legs = {}
	Helios.Feet = {}
	Samnuha = {}
	Samnuha.Legs = {}
	
--------------------------------------------------
--------------------------------------------------    

-- This helps when your augment changes to only have 1 place to update. 
    Helios.Head.BPDmg =   { name="Helios Band", augments={'Pet: "Dbl. Atk."+6','Blood Pact Dmg.+6',}}
	  
	Merl.Head.FC      =   { name="Merlinic Hood", augments={'"Mag.Atk.Bns."+27','"Fast Cast"+3','INT+8','Mag. Acc.+1',}}
	Merl.Body.MAB     =   { name="Merlinic Jubbah", augments={'Accuracy+10','"Mag.Atk.Bns."+30','Accuracy+2 Attack+2','Mag. Acc.+17 "Mag.Atk.Bns."+17',}}
	Merl.Feet.WSD     =   { name="Merlinic Crackows", augments={'Pet: "Regen"+1','STR+15','Weapon skill damage +7%','Accuracy+4 Attack+4','Mag. Acc.+14 "Mag.Atk.Bns."+14',}}
	Merl.Hands.MAB    =   { name="Merlinic Dastanas", augments={'"Triple Atk."+2','"Mag.Atk.Bns."+21','Magic Damage +16','Mag. Acc.+20 "Mag.Atk.Bns."+20',}}
	Merl.Hands.BPDmg  =   { name="Merlinic Dastanas", augments={'Pet: Mag. Acc.+21','Blood Pact Dmg.+9','Pet: "Mag.Atk.Bns."+13',}}
	Merl.Legs.MAB     =   { name="Merlinic Shalwar", augments={'"Mag.Atk.Bns."+11','INT+1','Crit.hit rate+3','Mag. Acc.+20 "Mag.Atk.Bns."+20',}}
	Merl.Feet.Th      =   { name="Merlinic Crackows", augments={'STR+2','Pet: Accuracy+19 Pet: Rng. Acc.+19','"Treasure Hunter"+2','Mag. Acc.+20 "Mag.Atk.Bns."+20',}}
	Merl.Feet.WSD     =   { name="Merlinic Crackows", augments={'Pet: "Regen"+1','STR+15','Weapon skill damage +7%','Accuracy+4 Attack+4','Mag. Acc.+14 "Mag.Atk.Bns."+14',}}
	
	Apo.Body.A        =   { name="Apo. Dalmatica +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}}
	Apo.Feet.A        =   { name="Apogee Pumps +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}}
	Apo.Legs.A        =   { name="Apogee Slacks +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}}
	Psycloth.Legs.FC  =   { name="Psycloth Lappas", augments={'MP+80','Mag. Acc.+15','"Fast Cast"+7',}}
	  
	Vanya.Head.A      =   { name="Vanya Hood", augments={'MP+50','"Cure" potency +7%','Enmity-6',}}
	Vanya.Feet.D      =   { name="Vanya Clogs", augments={'"Cure" potency +5%','"Cure" spellcasting time -15%','"Conserve MP"+6',}}
	  
	Telchine.Head.en  =   { name="Telchine Cap", augments={'Enh. Mag. eff. dur. +9',}}
	Telchine.Body.en  =   { name="Telchine Chas.", augments={'Enh. Mag. eff. dur. +10',}}
	Telchine.Hands.en =   { name="Telchine Gloves", augments={'Enh. Mag. eff. dur. +8',}}
	Telchine.Legs.en  =   { name="Telchine Braconi", augments={'Enh. Mag. eff. dur. +9',}}
	Telchine.Feet.en  =   { name="Telchine Pigaches", augments={'Enh. Mag. eff. dur. +9',}}

	Herc.Head.WSD  = { name= "Herculean Helm", augments={'"Conserve MP"+3','INT+2','Weapon skill damage +8%','Mag. Acc.+1 "Mag.Atk.Bns."+1',}}
	Herc.Body.WSD  = { name="Herculean Vest", augments={'AGI+8','Pet: Mag. Acc.+14','Weapon skill damage +10%','Accuracy+16 Attack+16',}}
	Herc.Body.MAB  = { name="Herculean Vest", augments={'Pet: STR+8','"Mag.Atk.Bns."+13','Accuracy+17 Attack+17','Mag. Acc.+20 "Mag.Atk.Bns."+20',}}
	Herc.Hands.WSD = { name="Herculean Gloves", augments={'Weapon skill damage +4%','Accuracy+10',}}
	Herc.Legs.MAB  = { name="Herculean Trousers", augments={'"Mag.Atk.Bns."+24','Phys. dmg. taken -2%','MND+14',}}
	Herc.Feet.WSD  = { name="Herculean Boots", augments={'Accuracy+4','Mag. Acc.+27','Weapon skill damage +8%','Mag. Acc.+19 "Mag.Atk.Bns."+19',}}

	Taeon.Head.Phalanx	=	{ name="Taeon Chapeau", augments={'DEF+3','"Conserve MP"+5','Phalanx +3',}}
	Taeon.Head.TP		=	{ name="Taeon Chapeau", augments={'Accuracy+20 Attack+20','"Triple Atk."+2','STR+5 DEX+5',}}
	Taeon.Body.Phalanx	=	{ name="Taeon Tabard", augments={'"Fast Cast"+2','Phalanx +3',}}
	Taeon.Hands.Phalanx =	{ name="Taeon Gloves", augments={'"Fast Cast"+5','Phalanx +3',}}
	Taeon.Legs.Phalanx	=	{ name="Taeon Tights", augments={'Accuracy+12 Attack+12','Spell interruption rate down -9%','Phalanx +3',}}
	Taeon.Feet.Phalanx	=	{ name="Taeon Boots", augments={'Spell interruption rate down -8%','Phalanx +3',}}
	
	Adh.Head.A          =   { name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}}
	Adh.Hands.A         =	{ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}}
	
	Samnuha.Legs        =   { name="Samnuha Tights", augments={'STR+7','"Dbl.Atk."+2','"Triple Atk."+1',}}