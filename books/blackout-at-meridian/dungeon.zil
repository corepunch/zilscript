;"Room descriptions, object details, messages and companion choices."

<SYNTAX HELP = V-BOOK-HELP>
<SYNONYM HELP HINT HINTS>
<SYNTAX USE OBJECT = V-USE>
<SYNTAX LISTEN = V-BOOK-LISTEN>


<ROUTINE MSG-VERSION () <TELL "Blackout at Meridian|An original superhero adventure, AdventureArena 2026|Release " N ,RELEASEID CR>>

;"What an English reader's world needs besides words: room lists run together
  and the way to each room is a compass word."
<ROUTINE SETUP-ROOM-LISTS () <SETG COMPACT-ROOM-LISTS T>>
<ROUTINE WALK-TO-BRIDGE ()
 <COND (<EQUAL? ,HERE ,DISPATCH> <DO-WALK ,P?NORTH>) (T <DO-WALK ,P?WEST>)>>
<ROUTINE WALK-TO-RELAY () <DO-WALK ,P?EAST>>


<ROUTINE MSG-SCORE-HERO ()
 <TELL "Hero: ">>

<ROUTINE MSG-SCORE-UNREGISTERED ()
 <TELL ", no profile registered yet." CR>>

<ROUTINE MSG-SCORE-OPEN-CLASS ()
 <TELL " (">>

<ROUTINE MSG-SCORE-CLOSE-CLASS ()
 <TELL ")" CR>>

<ROUTINE MSG-OPENING ()
 <TELL "At nine o'clock the storm took Meridian's power, and then someone took the relay station that should have brought it back. A guard drone now holds the station, and on Meridian Bridge a tram full of passengers hangs from a broken cable over the river. You are the city's newest hero, and tonight is your first call. Get to the bridge. (Type HELP at any time for how to play.)" CR CR>
 <TELL D ,HERE CR>>

<ROUTINE MSG-HELP-HOW ()
 <TELL "Type commands such as LOOK, EXAMINE BOARD or NORTH. Each hero action rolls d100 against one of your ranks, and higher rolls are better. A failure costs Health, and at 0 Health your night is over. READ SHEET shows your ranks, DIAGNOSE your Health and Karma, and NAME SHEET gives your hero a name." CR>>

<ROUTINE MSG-HELP-UNREGISTERED ()
 <TELL "Right now: examine the profiles on the duty board and CHOOSE BULWARK, ARC or LENS." CR>>

<ROUTINE MSG-HELP-RESCUE (AT-BRIDGE)
 <COND (.AT-BRIDGE <TELL "You are on the bridge. RESCUE the PASSENGERS before going east." CR>)
       (T <TELL "Right now: go north to the bridge and RESCUE the PASSENGERS." CR>)>>

<ROUTINE MSG-HELP-RELAY ()
 <TELL "Right now: in the relay station, STRIKE the DRONE or DISABLE the CONSOLE. USE KIT restores up to 20 Health once, for 10 Karma." CR>>

<ROUTINE MSG-USE ()
 <TELL "Say what you want to do with " THE ,PRSO "." CR>>

<ROUTINE MSG-LISTEN-DISPATCH ()
 <TELL "Only the rain on the glass." CR>>

<ROUTINE MSG-LISTEN-BRIDGE ()
 <TELL "Rain, wind, and the cable creaking over the river." CR>>

<ROUTINE MSG-LISTEN-RELAY-DRONE-DOWN ()
 <TELL "The deep hum of the console, and nothing else." CR>>

<ROUTINE MSG-LISTEN-RELAY ()
 <TELL "The deep hum of the console and the high whine of the drone's rotors." CR>>

<ROUTINE MSG-DEFAULT-NAME ()
 <TELL "Meridian">>

<ROUTINE MSG-CLASS-BULWARK ()
 <TELL "Bulwark">>

<ROUTINE MSG-CLASS-ARC ()
 <TELL "Arc">>

<ROUTINE MSG-CLASS-LENS ()
 <TELL "Lens">>

<ROUTINE MSG-HERO-HURT (HEALTH MAX)
 <TELL " (Health " N .HEALTH " of " N .MAX ".)" CR>>

<ROUTINE MSG-LOSS-RELAY ()
 <TELL "Your knees give way on the concrete floor. The rescue crew drags you out into the rain, and behind you the drone keeps its watch over the dark city.">>

<ROUTINE MSG-LOSS-BRIDGE ()
 <TELL "Your grip fails and you fall against the rails. The crew pulls the passengers down without you and carries you off the bridge in their net.">>

<ROUTINE MSG-LOSS-ENDING ()
 <TELL " Meridian will need another hero tonight." CR CR "THE END: CARRIED FROM THE STORM" CR CR>>

<ROUTINE MSG-LEAP-BRIDGE ()
 <TELL "You look down at the river and think better of it. The passengers need you up here." CR>>

<ROUTINE MSG-LEAP-IDLE ()
 <TELL "You bounce on your heels, ready for anything." CR>>

<ROUTINE MSG-SETUP ()
 <TELL "Choose the hero you’ll play as: Bulwark, Arc or Lens. Examine each profile before deciding. You can give your hero a name on the character sheet. Choosing a profile starts the mission." CR>>

<ROUTINE MSG-DISPATCH-LOOK-REGISTERED ()
 <TELL "In Meridian's emergency dispatch office, your profile on the duty board now carries the red ACTIVE stamp. Every other building you can see through the window is dark. The street door leads north to Meridian Bridge.">>

<ROUTINE MSG-BRIDGE-LOOK-START ()
 <TELL "You are on Meridian Bridge, in the full force of the rain. ">>

<ROUTINE MSG-BRIDGE-LOOK-RESCUED ()
 <TELL "The empty tram still hangs through the broken rails from its overhead cable, but its passengers are safe with the rescue crew below. The relay station stands at the east end of the bridge, its door forced open, and the way east is clear.">>

<ROUTINE MSG-BRIDGE-LOOK-HANGING ()
 <TELL "The front carriage of a tram hangs through the broken rails. Every time it swings, the overhead cable pulls a little straighter. Faces crowd the high end of the tram. Far below, the rescue crew holds a net over the river. The relay station stands at the east end of the bridge, but the passengers come first.">>

<ROUTINE MSG-BRIDGE-LOOK-END ()
 <TELL " Dispatch is back to the south." CR>>

<ROUTINE MSG-RELAY-LOOK-START ()
 <TELL "You are inside the relay station, a concrete hall warm enough to fog your wet sleeves. The relay console at the far end is lit brighter than anything left on the skyline. ">>

<ROUTINE MSG-RELAY-LOOK-DRONE-DOWN ()
 <TELL "The guard drone lies dark on the floor in front of it. ">>

<ROUTINE MSG-RELAY-LOOK-DRONE-UP ()
 <TELL "A guard drone hovers in front of it, its red eye following you. ">>

<ROUTINE MSG-RELAY-LOOK-KIT-EMPTY ()
 <TELL "The emergency kit hangs open and empty beside the door, which leads back west to the bridge." CR>>

<ROUTINE MSG-RELAY-LOOK-KIT-FULL ()
 <TELL "An emergency kit is clipped to the wall beside the door, which leads back west to the bridge." CR>>

<ROUTINE MSG-PROFILE-VANGUARD ()
 <TELL "Bulwark is built for heavy rescue and close combat: great Strength and Endurance, but little Reason. Health 120, Karma 26.">>

<ROUTINE MSG-PROFILE-ARC ()
 <TELL "Arc moves fast and throws lightning: top Agility and Power, light on Strength. Health 90, Karma 50.">>

<ROUTINE MSG-PROFILE-LENS ()
 <TELL "Lens reads machines and bends kinetic fields: high Reason and Intuition, but fragile in a fight. Health 60, Karma 90.">>

<ROUTINE MSG-PROFILE-IS-YOURS ()
 <TELL " This is your profile.">>

<ROUTINE MSG-PROFILE-TO-CHOOSE ()
 <TELL " To take it on, choose it.">>

<ROUTINE MSG-PROFILE-TAKE ()
 <TELL "The card stays pinned to the board. Choose it, and dispatch sends that hero." CR>>

<ROUTINE MSG-CHOOSE-ALREADY-1 ()
 <TELL "You are already registered as ">>

<ROUTINE MSG-CHOOSE-ALREADY-2 ()
 <TELL ". Dispatch does not change heroes in the middle of a call." CR>>

<ROUTINE MSG-CHOOSE-REGISTERED-1 ()
 <TELL "Dispatch registers you as ">>

<ROUTINE MSG-CHOOSE-REGISTERED-2 ()
 <TELL ". Your ranks:" CR>>


<ROUTINE MSG-PROFILE-ATTACK ()
 <TELL "Tearing up the duty board will not get anyone off the bridge." CR>>

<ROUTINE MSG-BOARD-LOOK-UNREGISTERED ()
 <TELL "Three profile cards are pinned to the board, one for each kind of hero dispatch can send: Bulwark, Arc and Lens." CR>>

<ROUTINE MSG-BOARD-LOOK-BULWARK ()
 <TELL "The Bulwark card is marked ACTIVE in red pen. The Arc and Lens cards wait for another night." CR>>

<ROUTINE MSG-BOARD-LOOK-ARC ()
 <TELL "The Arc card is marked ACTIVE in red pen. The Bulwark and Lens cards wait for another night." CR>>

<ROUTINE MSG-BOARD-LOOK-LENS ()
 <TELL "The Lens card is marked ACTIVE in red pen. The Bulwark and Arc cards wait for another night." CR>>

<ROUTINE MSG-DUTY-BOARD-TAKE ()
 <TELL "The board is screwed to the wall. The cards are what matter." CR>>

<ROUTINE MSG-DUTY-BOARD-ATTACK ()
 <TELL "Tearing up the duty board will not get anyone off the bridge." CR>>

<ROUTINE MSG-WINDOW-EXAMINE ()
 <TELL "Through the streaked glass the city is a black shape under the clouds. Out over the river, the red warning light of a stalled tram swings in the wind." CR>>

<ROUTINE MSG-WINDOW-OPEN ()
 <TELL "The window is painted shut, and the storm can stay outside." CR>>

<ROUTINE MSG-WINDOW-CLOSE ()
 <TELL "It is already shut." CR>>

<ROUTINE MSG-WINDOW-RUB ()
 <TELL "The glass is cold. The rain is on the other side of it." CR>>

<ROUTINE MSG-WINDOW-ATTACK ()
 <TELL "Dispatch has enough to repair tonight." CR>>

<ROUTINE MSG-SHEET-HERO ()
 <TELL "Hero: ">>

<ROUTINE MSG-SHEET-UNREGISTERED ()
 <TELL CR "No profile registered yet. Choose Bulwark, Arc or Lens at the duty board." CR>>

<ROUTINE MSG-SHEET-OPEN-CLASS ()
 <TELL " (">>

<ROUTINE MSG-SHEET-CLOSE-CLASS ()
 <TELL ")" CR>>

<ROUTINE MSG-NAME-REFUSED-1 ()
 <TELL "The dispatch board shows only plain letters, digits and punctuation. Your name stays ">>

<ROUTINE MSG-NAME-REFUSED-2 ()
 <TELL "." CR>>

<ROUTINE MSG-NAME-BLANK-1 ()
 <TELL "No name entered. Dispatch will keep calling you ">>

<ROUTINE MSG-NAME-BLANK-2 ()
 <TELL "." CR>>

<ROUTINE MSG-NAME-STORED ()
 <TELL "Registered hero name: ">>

<ROUTINE MSG-SHEET-DROP ()
 <TELL "You keep your character sheet. Dispatch needs it to know who you are." CR>>

<ROUTINE MSG-SHEET-ATTACK ()
 <TELL "Your sheet is the only paperwork you have tonight. Keep it in one piece." CR>>

<ROUTINE MSG-CHECK-STRENGTH ()
 <TELL "Strength check. ">>

<ROUTINE MSG-CHECK-AGILITY ()
 <TELL "Agility check. ">>

<ROUTINE MSG-CHECK-POWER ()
 <TELL "Power check. ">>

<ROUTINE MSG-TRAM-EXAMINE-RESCUED ()
 <TELL "The empty carriage creaks on its cable. Nobody is inside now." CR>>

<ROUTINE MSG-TRAM-EXAMINE ()
 <TELL "The front carriage has jumped the rails and hangs nose-down over the river. Only the cable holds it. People are still inside, waving at you." CR>>

<ROUTINE MSG-TRAM-LISTEN-RESCUED ()
 <TELL "Only the cable, creaking." CR>>

<ROUTINE MSG-TRAM-LISTEN ()
 <TELL "Over the rain you hear a child crying and someone counting out loud to stay calm." CR>>

<ROUTINE MSG-TRAM-PUSH ()
 <TELL "Push it, and it falls. The passengers need it held, not pushed." CR>>

<ROUTINE MSG-TRAM-ATTACK ()
 <TELL "There are people inside it." CR>>

<ROUTINE MSG-TRAM-TRY-RESCUE ()
 <TELL "The whole carriage would lurch. RESCUE THE PASSENGERS and hand them down to the crew one at a time." CR>>

<ROUTINE MSG-TRAM-RESCUE-UNREGISTERED ()
 <TELL "Register a profile at dispatch first." CR>>

<ROUTINE MSG-TRAM-RESCUE-RESCUED ()
 <TELL "Everyone is already safe." CR>>

<ROUTINE MSG-TRAM-RESCUED-NOW ()
 <TELL "You steady the carriage and pass the passengers down, one by one, to the crew's net. The last of them, a boy in a yellow raincoat, will not let go of your hand until his feet are on the ground. (Karma +10.) The way east to the relay station is open." CR>>

<ROUTINE MSG-TRAM-RESCUE-FAILED ()
 <TELL "The cable slips and the carriage lurches. A passenger cries out; you take a hit, but the crew braces its net below. You can try the rescue again.">>

<ROUTINE MSG-CREW-EXAMINE-RESCUED ()
 <TELL "The crew is wrapping the passengers in foil blankets on the riverbank. The chief gives you a thumbs-up." CR>>

<ROUTINE MSG-CREW-EXAMINE ()
 <TELL "Firefighters in yellow coats stand below the bridge with a net, shouting up to you through the rain." CR>>

<ROUTINE MSG-CREW-TELL-RESCUED ()
 <TELL "The chief shouts up: \"Everybody's out! That drone came from the relay station. Go and shut it down!\"" CR>>

<ROUTINE MSG-CREW-TELL ()
 <TELL "The chief cups her hands: \"We'll catch them, but that cable won't hold for long. Get them out!\"" CR>>

<ROUTINE MSG-CREW-ATTACK ()
 <TELL "They are on your side." CR>>

<ROUTINE MSG-CREW-LISTEN ()
 <TELL "Radios crackle and somebody counts down the strands left on the cable." CR>>

<ROUTINE MSG-RAILS-EXAMINE ()
 <TELL "The steel rails are bent outward where the carriage went through. Beyond the gap there is only rain and the river." CR>>

<ROUTINE MSG-RAILS-CLIMB-ON ()
 <TELL "You lean out over the gap. It is a long way down to the river." CR>>

<ROUTINE MSG-RAILS-TAKE ()
 <TELL "The rails are bolted into the bridge and bent past repair." CR>>

<ROUTINE MSG-RAILS-RUB ()
 <TELL "Cold, wet steel, still humming with the strain of the carriage." CR>>

<ROUTINE MSG-RAILS-ATTACK ()
 <TELL "The rails have taken enough damage tonight." CR>>

<ROUTINE MSG-CABLE-EXAMINE-RESCUED ()
 <TELL "With the carriage empty, the overhead cable has stopped singing in the wind." CR>>

<ROUTINE MSG-CABLE-EXAMINE ()
 <TELL "The overhead cable sags under the carriage. As you watch, another strand snaps." CR>>

<ROUTINE MSG-CABLE-LISTEN ()
 <TELL "It creaks and sings in the wind." CR>>

<ROUTINE MSG-CABLE-RUB ()
 <TELL "It is dead. No power runs through it tonight, which is the one piece of luck in this storm." CR>>

<ROUTINE MSG-CABLE-ATTACK ()
 <TELL "That cable is all that holds the tram up." CR>>

<ROUTINE MSG-CABLE-TRY-RESCUE ()
 <TELL "You don't take hold. The cable is keeping an entire carriage out of the river. The rescue crew can catch the passengers if you pass them down." CR>>

<ROUTINE MSG-CABLE-TAKE-RESCUED ()
 <TELL "The cable can hang there until the city has power to repair it." CR>>

<ROUTINE MSG-DRONE-EXAMINE-DISABLED ()
 <TELL "The drone lies on its back, rotors still. Its red eye has gone dark." CR>>

<ROUTINE MSG-DRONE-EXAMINE (INTEGRITY MAX)
 <TELL "A black guard drone the size of a car door, hovering on four rotors. Its red eye tracks every move you make. Integrity " N .INTEGRITY " of " N .MAX "." CR>>

<ROUTINE MSG-DRONE-LISTEN-DISABLED ()
 <TELL "Silence." CR>>

<ROUTINE MSG-DRONE-LISTEN ()
 <TELL "Its rotors whine, high and steady." CR>>

<ROUTINE MSG-DRONE-TELL-DISABLED ()
 <TELL "It says nothing at all." CR>>

<ROUTINE MSG-DRONE-TELL ()
 <TELL "The drone answers with a burst of static: \"RESTRICTED AREA. LEAVE NOW.\"" CR>>

<ROUTINE MSG-DRONE-TAKE-DISABLED ()
 <TELL "It is heavier than it looks, and the police will want it. Leave it where it fell." CR>>

<ROUTINE MSG-DRONE-TAKE ()
 <TELL "It slides out of reach and its eye flares red. You would have to fight it." CR>>

<ROUTINE MSG-DRONE-DISABLE-DISABLED ()
 <TELL "It is already out of action." CR>>

<ROUTINE MSG-DRONE-ATTACK-UNREGISTERED ()
 <TELL "Register a profile at dispatch first." CR>>

<ROUTINE MSG-DRONE-ATTACK-DISABLED ()
 <TELL "The drone is already out of action." CR>>

<ROUTINE MSG-DRONE-CHECK ()
 <TELL "Fighting check. ">>

<ROUTINE MSG-DRONE-DOWN ()
 <TELL "The drone crashes to the floor and its red eye goes dark. (Karma +10.) The console is unguarded." CR>>

<ROUTINE MSG-DRONE-HIT (INTEGRITY MAX)
 <TELL "Your blow lands and the drone staggers, sparks pouring from one rotor. Integrity " N .INTEGRITY " of " N .MAX "." CR>>

<ROUTINE MSG-DRONE-MISS ()
 <TELL "The drone slides aside, and your blow meets only air." CR>>

<ROUTINE MSG-DRONE-COUNTER ()
 <TELL "Its stun beam catches you.">>

<ROUTINE MSG-CONSOLE-EXAMINE ()
 <TELL "A wall of dark screens around a single manual bypass lever, the only control that still answers by hand. Pull it, and the city takes back its own power.">>

<ROUTINE MSG-CONSOLE-EXAMINE-NOT-DISABLED ()
 <TELL " The drone hovers between you and it. You could fight it first, taking its return fire, or risk a Reason check to reach the lever directly.">>

<ROUTINE MSG-CONSOLE-RUB ()
 <TELL "It is warm and trembling under the load it should not be carrying." CR>>

<ROUTINE MSG-CONSOLE-TAKE ()
 <TELL "It is bolted into the concrete." CR>>

<ROUTINE MSG-CONSOLE-ATTACK ()
 <TELL "Smash the console and the city stays dark for weeks. The lever will do." CR>>

<ROUTINE MSG-CONSOLE-DISABLE-UNREGISTERED ()
 <TELL "Register a profile at dispatch first." CR>>

<ROUTINE MSG-CONSOLE-WIN-START ()
 <TELL "You throw the bypass lever. The hum of the hall drops to a murmur, the screens wake one by one, and the relay returns to local control. Across the river, Meridian lights up street by street. On the bridge, the boy in the yellow raincoat points up at the first lit window, and the rescue crew cheers. (Karma +20.)" CR CR "Your radio crackles, and dispatch calls your name: ">>

<ROUTINE MSG-CONSOLE-WIN-END ()
 <TELL ". Meridian is safe." CR CR "THE END: THE LIGHTS OF MERIDIAN" CR CR>>

<ROUTINE MSG-CONSOLE-COUNTER ()
 <TELL "The drone's beam catches you before you reach the lever.">>

<ROUTINE MSG-CHECK-REASON ()
 <TELL "Reason check. ">>

<ROUTINE MSG-KIT-EXAMINE-BOOSTED ()
 <TELL "The kit hangs open and empty." CR>>

<ROUTINE MSG-KIT-EXAMINE ()
 <TELL "A red emergency recovery kit, clipped to the wall. It works once, costs 10 Karma to activate, and restores up to 20 Health." CR>>

<ROUTINE MSG-KIT-OPEN ()
 <TELL "Through the clear flap you can see a single dose. You can inspect it without breaking the seal. USE KIT when you're ready to spend 10 Karma." CR>>

<ROUTINE MSG-KIT-TAKE ()
 <TELL "It is clipped to the wall. Use it where it hangs." CR>>

<ROUTINE MSG-KIT-ATTACK ()
 <TELL "You may need what is inside it." CR>>

<ROUTINE MSG-KIT-POWER-UNREGISTERED ()
 <TELL "Register a profile at dispatch first." CR>>

<ROUTINE MSG-KIT-POWER-BOOSTED ()
 <TELL "The kit is empty." CR>>

<ROUTINE MSG-KIT-UNHURT ()
 <TELL "You are unhurt. Keep the kit for when you need it." CR>>

<ROUTINE MSG-KIT-USED (GAINED HEALTH MAX KARMA)
 <TELL "You crack the kit open and press the patch to your ribs. You recover " N .GAINED " Health. (Health " N .HEALTH " of " N .MAX ", Karma " N .KARMA ".)" CR>>

<ROUTINE MSG-KIT-NO-KARMA (KARMA)
 <TELL "Activating the kit takes 10 Karma, and you have " N .KARMA "." CR>>

<ROUTINE MSG-RAIN-DISPATCH ()
 <TELL "Rain runs down the window in silver lines." CR>>

<ROUTINE MSG-RAIN-BRIDGE ()
 <TELL "The rain comes sideways across the bridge, cold enough to sting." CR>>

<ROUTINE MSG-RAIN-EXAMINE ()
 <TELL "Rain drums on the concrete roof of the hall." CR>>

<ROUTINE MSG-RAIN-LISTEN ()
 <TELL "A steady roar, broken only by thunder." CR>>

<ROUTINE MSG-RAIN-SMELL ()
 <TELL "Wet stone and the sharp smell of burned wiring." CR>>

<ROUTINE MSG-RAIN-TAKE ()
 <TELL "It runs through your fingers." CR>>

<ROUTINE MSG-CITY-EXAMINE ()
 <TELL "Meridian is dark from the river to the hills: no streetlights, no lit windows, only the storm." CR>>

<ROUTINE MSG-CITY-LISTEN ()
 <TELL "Car alarms, far away, and nothing else but the rain." CR>>

<ROUTINE MSG-RIVER-EXAMINE ()
 <TELL "The river is high and fast, brown with the storm." CR>>

<ROUTINE MSG-RIVER-SWIM ()
 <TELL "The current would take you under the bridge in seconds. The city needs you dry and alive." CR>>

<ROUTINE MSG-RIVER-DRINK ()
 <TELL "Not tonight, and not ever." CR>>

<ROUTINE MSG-RIVER-LISTEN ()
 <TELL "It roars against the piers of the bridge." CR>>

<ROUTINE MSG-BRIDGE-SPAN-DISPATCH ()
 <TELL "Meridian Bridge is a short run north through the rain." CR>>

<ROUTINE MSG-BRIDGE-SPAN-BRIDGE ()
 <TELL "An old steel bridge with tram rails down the middle, running out over the river to the relay station." CR>>

<ROUTINE MSG-BRIDGE-SPAN-EXAMINE ()
 <TELL "Through the door, the bridge runs west into the rain." CR>>

<ROUTINE MSG-BRIDGE-SPAN-THROUGH ()
 <TELL "You are standing on it." CR>>

<ROUTINE MSG-DISTANT-TRAM-EXAMINE ()
 <TELL "From here it is only a red warning light, swinging over the river. The bridge is to the north." CR>>

<ROUTINE MSG-DISTANT-TRAM-RESCUE ()
 <TELL "It is out on the bridge, to the north." CR>>

<ROUTINE MSG-STATION-INSIDE ()
 <TELL "You are inside it. All of the city's power runs through this hall." CR>>

<ROUTINE MSG-STATION-EXAMINE ()
 <TELL "A squat concrete building at the east end of the bridge, humming with power it should not have. Its steel door has been forced open." CR>>

<ROUTINE MSG-STATION-ALREADY-INSIDE ()
 <TELL "You are already inside." CR>>

<ROUTINE MSG-STATION-LISTEN ()
 <TELL "A deep electric hum, louder than the rain." CR>>

<ROUTINE MSG-STATION-DOOR-EXAMINE ()
 <TELL "The steel door of the relay station has been torn off its lock from the inside." CR>>

<ROUTINE MSG-STATION-DOOR-CLOSE ()
 <TELL "It is wrecked and will not close." CR>>

<ROUTINE MSG-STATION-DOOR-OPEN ()
 <TELL "It is already open, and it will stay that way." CR>>

<ROUTINE MSG-STATION-DOOR-KNOCK ()
 <TELL "Nobody inside is going to answer." CR>>


<ROUTINE STREET-DOOR-F ()
 <COND (<OR <NOT <EQUAL? ,PRSO ,STREET-DOOR>> ,PRSI> <RFALSE>)
       (<VERB? EXAMINE LOOK-INSIDE>
        <TELL "A steel street door, bowed inward a little by the wind. Through the narrow pane you can see Meridian Bridge. The release is on this side." CR>)
       (<VERB? THROUGH WALK-TO> <WALK-TO-BRIDGE> <RTRUE>)
       (<VERB? OPEN>
        <COND (<0? ,HERO-CLASS>
               <TELL "A hand from the desk covers the release. “Profile first. Then we know whose name to call if you go quiet.”" CR>)
              (T <TELL "You test the release. The wind tries to take the door from your hand; you let it swing shut until you're ready to step outside." CR>)>)
       (<VERB? CLOSE LOCK> <TELL "The door leans hard against its frame. Nothing is getting through it without a hand on the release." CR>)
       (<VERB? KNOCK LISTEN> <TELL "A loose fitting rattles against the pane. On the other side, the rain doesn't stop long enough to knock back." CR>)>>

<ROUTINE SCENE-REACTION ()
 <COND (,PRSI <RFALSE>)
       (<AND <EQUAL? ,PRSO ,DUTY-BOARD> <VERB? SEARCH LOOK-INSIDE>>
        <PERFORM ,V?EXAMINE ,DUTY-BOARD> <RTRUE>)
       (<AND <EQUAL? ,PRSO ,DUTY-BOARD> <VERB? RUB>>
        <TELL "One corner of the board is polished by years of fingertips. People have stood here before, weighing the same three cards." CR>)
       (<AND <EQUAL? ,PRSO ,WINDOW> <VERB? KNOCK>>
        <TELL "Your knuckle gives the glass a little tick. Across the street a signal lamp flashes once as a transformer gives out; for a second it looks like an answer." CR>)
       (<AND <EQUAL? ,PRSO ,WINDOW> <VERB? LISTEN>>
        <TELL "Rain hits the glass in sheets. Between gusts you can hear the rescue crew's whistles from the bridge." CR>)
       (<AND <EQUAL? ,PRSO ,TRAM> <VERB? KNOCK>>
        <COND (,RESCUED <TELL "You knock once. The empty tram answers like an enormous tin drum." CR>)
              (T <TELL "A child in a yellow coat taps back twice. Then a grown-up puts a steadying hand on his shoulder." CR>)>)
       (<AND <EQUAL? ,PRSO ,SUPPLIES> <VERB? SMELL>>
        <TELL "The case smells like disinfectant and wet concrete. It isn't an improvement on either." CR>)>>

<ROOM DISPATCH (DESC "Dispatch") (NORTH TO BRIDGE IF HERO-CLASS ELSE "Dispatch will not send an unregistered hero into the storm. Choose a profile first: Bulwark, Arc or Lens.") (OUT TO BRIDGE IF HERO-CLASS ELSE "Dispatch will not send an unregistered hero into the storm. Choose a profile first: Bulwark, Arc or Lens.")>

<ROOM BRIDGE (DESC "Meridian Bridge") (SOUTH TO DISPATCH) (EAST TO RELAY IF RESCUED ELSE "Not while the passengers are hanging over the river. Rescue them first.") (DOWN "The crew has the riverbank. The passengers need you up here.")>
<ROOM RELAY (DESC "Relay Station") (WEST TO BRIDGE) (OUT TO BRIDGE)>

<OBJECT STREET-DOOR (IN DISPATCH) (DESC "street door") (SYNONYM DOOR RELEASE PANE) (ADJECTIVE STREET STEEL NARROW) (FLAGS NDESCBIT DOORBIT) (ACTION STREET-DOOR-F)>

<OBJECT VANGUARD (DESC "Bulwark profile") (SYNONYM PROFILE BULWARK CARD) (ADJECTIVE BULWARK)>
<OBJECT ARC (DESC "Arc profile") (SYNONYM PROFILE ARC CARD) (ADJECTIVE ARC)>

<OBJECT LENS (DESC "Lens profile") (SYNONYM PROFILE LENS CARD) (ADJECTIVE LENS)>
<OBJECT DUTY-BOARD (DESC "duty board") (SYNONYM BOARD) (ADJECTIVE DUTY)>

<OBJECT WINDOW (DESC "window") (SYNONYM WINDOW GLASS)>
<OBJECT DOSSIER (DESC "character sheet") (SYNONYM SHEET DOSSIER) (ADJECTIVE CHARACTER)>

<OBJECT TRAM (DESC "tram") (SYNONYM TRAM CARRIAGE PASSENGERS PEOPLE) (ADJECTIVE FRONT)>
<OBJECT CREW (DESC "rescue crew") (SYNONYM CREW RESCUERS NET CHIEF) (ADJECTIVE RESCUE)>

<OBJECT RAILS (DESC "rails") (SYNONYM RAILS RAIL RAILING TRACKS) (ADJECTIVE BENT BROKEN) (FLAGS PLURALBIT)>
<OBJECT CABLE (DESC "cable") (SYNONYM CABLE WIRE) (ADJECTIVE OVERHEAD SAGGING)>

<OBJECT DRONE (DESC "guard drone") (SYNONYM DRONE EYE) (ADJECTIVE GUARD RED)>
<OBJECT CONSOLE (DESC "relay console") (SYNONYM CONSOLE RELAY LEVER SCREENS) (ADJECTIVE RELAY MANUAL)>

<OBJECT SUPPLIES (DESC "emergency kit") (SYNONYM KIT) (ADJECTIVE EMERGENCY RECOVERY)>
<OBJECT RAIN (DESC "rain") (SYNONYM RAIN STORM)>

<OBJECT CITY (DESC "city") (SYNONYM CITY MERIDIAN SKYLINE POWER) (ADJECTIVE DARK)>
<OBJECT RIVER (DESC "river") (SYNONYM RIVER CURRENT)>

<OBJECT BRIDGE-SPAN (DESC "bridge") (SYNONYM BRIDGE) (ADJECTIVE MERIDIAN)>
<OBJECT DISTANT-TRAM (DESC "tram") (SYNONYM TRAM) (ADJECTIVE DISTANT)>

<OBJECT STATION (DESC "relay station") (SYNONYM STATION BUILDING HALL) (ADJECTIVE RELAY CONCRETE)>
<OBJECT STATION-DOOR (DESC "station door") (SYNONYM DOOR DOORWAY) (ADJECTIVE STATION STEEL)>

<ROUTINE SUGGEST-ACTIONS ()
 <COND (<EQUAL? ,HERE ,DISPATCH>
  <COND (<0? ,HERO-CLASS>
   <CHOICE "profile.bulwark" "Choose Bulwark" "choose bulwark" ,CHOICE-INVESTIGATE 99>
   <CHOICE "profile.arc" "Choose Arc" "choose arc" ,CHOICE-INVESTIGATE 98>
   <CHOICE "profile.lens" "Choose Lens" "choose lens" ,CHOICE-INVESTIGATE 97>)
  (T <CHOICE "dispatch.go" "Go to the bridge" "north" ,CHOICE-INVESTIGATE 99>)>)
 (<EQUAL? ,HERE ,BRIDGE>
  <COND (,RESCUED <CHOICE "bridge.go" "Enter the relay" "east" ,CHOICE-INVESTIGATE 99>)
  (T <CHOICE "bridge.rescue" "Rescue the passengers" "rescue tram" ,CHOICE-INVESTIGATE 99>)>
  <CHOICE "bridge.back" "Return to dispatch" "south" ,CHOICE-INVESTIGATE 80>)
 (<EQUAL? ,HERE ,RELAY>
  <COND (<NOT ,DISABLED> <CHOICE "relay.strike" "Strike the drone" "strike drone" ,CHOICE-INVESTIGATE 99>)>
  <CHOICE "relay.bypass" "Throw the bypass lever" "disable console" ,CHOICE-INVESTIGATE 98>
  <COND (<AND <NOT ,BOOSTED> <L? <STAT ,HERO ,A-HEALTH> <MAX-STAT ,HERO ,A-HEALTH>>> <CHOICE "relay.kit" "Use the recovery kit" "use kit" ,CHOICE-INVESTIGATE 95>)>
  <CHOICE "relay.back" "Return to the bridge" "west" ,CHOICE-INVESTIGATE 80>)>
 <COND (<NOT <0? ,HERO-CLASS>> <CHOICE "hero.sheet" "Read character sheet" "read sheet" ,CHOICE-INVESTIGATE 90>)>>
