--4.15.2016
-------------------------------------------------------------------------------------------------------------------
-- Global settings
-------------------------------------------------------------------------------------------------------------------
 
-- You'll need the Shortcuts addon to handle the auto-targetting of the custom pact commands.
-- I really recommend if you use this, it's on a full keyboard it uses a lot of keybinds.  If you are imaginative there is enough keybinds using window and app key to go around though.  A supported macro keyboard also helps.  I use a Strix Tactic Pro that a windower developer kindly made work with Windower.
--
 
display_hud = true -- can toggle with app/menu key + 0
display_states = true -- can toggle with app/menu key + 8
--app/menu key + 9 will force the hud to refresh in case of any bugs/to trouble shoot bugs
base_icon_dir = 'C:\Program Files (x86)\PlayOnline\Windower\addons\GearSwap\data\icons' --had to use absolute pathing, set this to the icon directory
hud_x_pos = 1500 --important to update these if you have a smaller screen
hud_y_pos = 200
hud_draggable = true -- really recommend leaving it false for now, after the icons were introduced it gets kind of buggy.
hud_font_size = 12
hud_icon_width = 32 --the size of icons from plugins folder, if you change the icons in icon folder you gave above, set the width height here
hud_icon_height = 32 --the size of icons from plugins folder, if you change the icons in icon folder you gave above, set the width height here
hud_transparency = 220 -- a value of 0 (invisible) to 255 (no transparency at all)
debug_gs1 = false --outputs info if you're trying to debug sets
--Whether to let organizer see these sets or not, or to leave them at home, cramped inventory means I don't need to always have all these
usemephitas = false --will equip mephitas +1 ring if you are near full mana, can be useful to do just before conduit etc
use_melee = true
use_enfeeb = false
use_player_mab = true
use_resistant = false
conduit_lock = false
--shattersoul_set = true
--use_bliss = true
--use_cataclysm = true
exp_rings = false
load_debugging = false
useall_bp_reduction_gear = true --if doing salvage useful to use all the bp reduction gear you can

cureIV = false --Macros use cure3 or cure4
if player.sub_job == 'WHM' or player.sub_job == 'RDM' then
	cureIV = true
end


-------------------------------------------------------------------------------------------------------------------
-- Key bindings, and toggles/switches using mote's libraries.  Feel free to change key bindings
-- ! = alt, ^ = ctrl, @ = windows key, # = menu key/app key, 
-- putting % after any of these disables the keybind if you are typing in a chat window
-------------------------------------------------------------------------------------------------------------------
-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Perp', 'Melee')
    state.CastingMode:options('Normal', 'Resistant','PDT')
    --state.IdleMode:options('Normal', 'PDT')
    state.damagetaken = M{['description']="Damage Taken",'None','PDT'}
    --state.damagetaken = M{['description']="Damage Taken",'None','DT', 'PDT', 'MDT'} --can use this line instead and cycle more damage resistance types
    state.petdamagetaken = M{['description']="Pet Damage Taken",'None','DT'}
    state.cpmode = M(false, 'CP Mode')
    state.movement = M(false, 'Movement Mode')
    state.tplock = M(false, 'Staff Lock')
    --state.kclub = M(false, 'Kraken Club')
    state.impactmode = M(false, 'Impact Debuff Mode')
    state.favor = M{['description'] = 'Favor Mode'}
    state.favor:options('mpsaver','allout')
    state.burstmode = M{['description'] = 'Burst Mode'}
    state.burstmode:options('Normal','Burst')
    state.pullmode = M(false, 'Pull Mode')
    state.bpmagicacc = M(false, 'BP Accuracy Mode')

    select_default_macro_book()
    send_command('bind @%numpad1 gs c smn carbuncle')
    send_command('bind @%numpad2 gs c smn fenrir')
    send_command('bind @%numpad3 gs c smn ifrit')
    send_command('bind @%numpad4 gs c smn titan')
    send_command('bind @%numpad5 gs c smn leviathan')
    send_command('bind @%numpad6 gs c smn garuda')
    send_command('bind @%numpad7 gs c smn shiva')
    send_command('bind @%numpad8 gs c smn ramuh')
    send_command('bind @%numpad9 gs c smn diabolos')
    send_command('bind @%numpad0 gs c smn caitsith')
    send_command('bind @%numpadenter gs c smn atomos')
    send_command('bind @%numpad. gs c smn lightspirit')

    send_command('bind !%delete input /ja "Avatar\'s Favor"')
    send_command('bind !%pagedown input /ja "Apogee"')
    send_command('bind !%end input /ja "Sublimation"')

    send_command('bind @%home gs c warpring')
    send_command('bind @%c input /ma "Dia" <t>')
    send_command('bind #0 gs c toggle_hud')
    send_command('bind #9 gs c force_hud_refresh')
    send_command('bind #8 gs c toggle_states')
    send_command('bind @%2 input /ma "Dia" <t>')

    if cureIV then
	    send_command('alias stp_m1 input /ma "Cure IV" <p0>')
	    send_command('alias stp_m2 input /ma "Cure IV" <p1>')
	    send_command('alias stp_m3 input /ma "Cure IV" <p2>')
	    send_command('alias stp_m4 input /ma "Cure IV" <p3>')
	    send_command('alias stp_m5 input /ma "Cure IV" <p4>')
	    send_command('alias stp_m6 input /ma "Cure IV" <p5>')
	    send_command('alias stp_m7 input /ma "Cure IV"')
    else
	    send_command('alias stp_m1 input /ma "Cure III" <p0>')
	    send_command('alias stp_m2 input /ma "Cure III" <p1>')
	    send_command('alias stp_m3 input /ma "Cure III" <p2>')
	    send_command('alias stp_m4 input /ma "Cure III" <p3>')
	    send_command('alias stp_m5 input /ma "Cure III" <p4>')
	    send_command('alias stp_m6 input /ma "Cure III" <p5>')
	    send_command('alias stp_m7 input /ma "Cure III"')
    end
    send_command('alias trust_wkr input /ma "August" <me>;wait 5;input /ma "Yoran-Oran (UC)" <me>;wait 5;input /ma "Qultada" <me>')
    send_command('alias trust_dmn input /ma "August" <me>;wait 5;input /ma "Yoran-Oran (UC)" <me>;wait 5;input /ma "Qultada" <me>;wait 5;input /ma "Selh\'teus" <me>;wait 5;input /ma "Ulmia" <me>')
    --send_command('alias trust_wkr input /ma "August" <me>;')
    
    --send_command('alias stp_m8 input /ma "Regen II"')
    send_command('alias stp_m8 gs c nukemode')
    --send_command('alias stp_m9 gs c supportmode')
    send_command('alias stp_m11 gs c release')
    send_command('alias stp_m12 input /pet "Retreat" <me>')
    send_command('alias stp_m13 input /pet "Assault" <t>')
    --send_command('alias stp_m14 input /ma "Light Spirit" <me>')

    --if you don't use a macro keyboard then you could use these
    send_command('bind ^%numpad1 gs c release')
    send_command('bind ^%numpad2 input /pet "Retreat" <me>')
    send_command('bind ^%numpad3 input /pet "Assault" <t>')

    send_command('alias stp_m11 gs c release')
    send_command('alias stp_m12 input /pet "Retreat" <me>')
    send_command('alias stp_m13 input /pet "Assault" <t>')
    --send_command('alias stp_m14 input /ma "Light Spirit" <me>')

    --shortcuts
    send_command('alias si input /ma sneak;wait 4;input /ma invisible')
    send_command('alias sn input /ma sneak')
    send_command('alias in input /ma invisible')
    send_command('alias f1 input /ma fire;wait 3.5;input /ma fire')
    send_command('alias t1 input /ma thunder;wait 3.5;input /ma thunder')
    send_command('alias p input /ma paralyna')
    send_command('alias l input /ma aurorastorm')
    send_command('alias po input /ma poisona')
    send_command('alias e input /ma erase')
    send_command('alias c input /ma cursna')
    send_command('alias s input /ma silena')
    send_command('alias b input /ma blindna')
    send_command('alias bu input /ma stoneskin;wait 4.9;input /ma aquaveil;wait 4.6;input /ma refresh;wait 4.5;input /ma regen')
    send_command('alias ss input /ma stoneskin')
    send_command('alias bl input /ma blink')
    send_command('alias r input /ma refresh')
    send_command('alias rr input /ma reraise')
    send_command('alias rg lua r gearswap')
    send_command('alias cl gs c conduit_lock')

    --alt
    send_command('bind !1 gs c pact cure')
    send_command('bind !2 gs c pact curaga')
    send_command('bind !3 gs c pact buffoffense')
    send_command('bind !4 gs c pact buffdefense')
    send_command('bind !5 gs c pact buffspecial')
    send_command('bind !6 gs c pact debuff1')
    send_command('bind !7 gs c pact debuff2')
    send_command('bind !8 gs c pact sleep')
    send_command('bind !9 gs c pact misc2')
    --send_command('bind !0 input /item "Ginger Cookie" <stnpc>; wait 1; input /item "Ginger Cookie" <lastst>; wait 1;input /item "Ginger Cookie" <lastst>') --halloween event.. >.>

    --ctrl
    send_command('bind ^1 gs c pact nuke2')
    send_command('bind ^2 gs c pact nuke4')
    send_command('bind ^3 gs c pact bp70')
    send_command('bind ^4 gs c pact bp75')
    send_command('bind ^5 gs c pact bprage1')
    send_command('bind ^6 gs c pact astralflow')
    send_command('bind ^7 gs c pact misc1')
    --send_command('bind ^9 gs c pact misc3')
    --send_command('bind ^9 input /pet "Release" <me>')

    --send_command('bind ^0 gs c pact misc4')

    --send_command('bind ^o gs c switchmode')
    
    send_command('bind !q gs c siphon')
    send_command('bind !o input /map')
    send_command('bind !%numpad+ input /map')
    send_command('bind !%numpad- gs c fleet_wind')
    send_command('bind f11 gs c cycle damagetaken')
    send_command('bind !f11 gs c cycle petdamagetaken')
    send_command('bind ^f11 gs c toggle pullmode')
    send_command('bind f10 gs c toggle movement')
    send_command('bind ^f10 gs c cycle favor')
    send_command('bind !f10 gs c cycle impactmode')
    send_command('bind !f9 gs c cycle burstmode')
    send_command('bind ^f9 gs c cycle bpmagicacc')
    --send_command('bind ^[ gs c cpmode')
    send_command('bind ^[ gs c toggle cpmode')
    send_command('bind ![ gs c toggle tplock')
    --send_command('bind !insert gs c toggle kclub')
    send_command('bind ^] gs c buffrotation')
    --send_command('bind %numpad1 setkey f8 down;wait .1;setkey f8 up;input /pet "Flaming Crush" <t>')
    --send_command('bind %numpad1 setkey f8 down;wait .1;setkey f8 up;wait .1;input /attack <t>')
    --send_command('bind %numpad3 input /ws "Garland of Bliss" <t>')
    --send_command('bind %numpad3 setkey f8 down;wait .1;setkey f8 up;wait .1;input /pet "Assault" <t>')
    --send_command('bind %numpad3 setkey f8 down;wait .1;setkey f8 up;input /pet "Sleepga" <t>')
    --send_command('bind %numpad3 input /pet "Flaming Crush" <t>')
    --send_command('bind !%numpad. gs c smn lightspirit')

    setup_hud() -- HUD for summoner, don't modify this line --
end
 
-------------------------------------------------------------------------------------------------------------------
-- Sets, modify these :D
-------------------------------------------------------------------------------------------------------------------
 
-- Define sets and vars used by this job file.
function init_gear_sets()
	require(player.name..'-SMN-sets.lua')
end

include(player.name..'-SMN-lib.lua') -- Leave this line to include all the library functionality --
