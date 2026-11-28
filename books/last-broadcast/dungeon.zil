<DIRECTIONS NORTH EAST WEST SOUTH NE NW SE SW UP DOWN IN OUT>
<GLOBAL LB-WON <>>
<GLOBAL LB-CLOCK <>>
<GLOBAL LB-SOUND <>>
<GLOBAL LB-PROVENANCE <>>
<GLOBAL LB-TRACE <>>
<GLOBAL LB-WEAPON <>>
<GLOBAL LB-ROUTE <>>
<GLOBAL LB-RUTH-CLEARED <>>
<GLOBAL LB-EDITH-CLEARED <>>
<GLOBAL LB-TOMAS-CLEARED <>>
<GLOBAL LB-MOTIVE <>>
<GLOBAL LB-RECONSTRUCTED <>>
<GLOBAL LB-STAIN-SEEN <>>
<GLOBAL LB-LEDGER-SEEN <>>
<GLOBAL LB-DRESSING-SEEN <>>
<GLOBAL LB-RECEIPT-SEEN <>>

<ROOM LB-LANDING (IN ROOMS) (DESC "Saint Bride Landing")
	(LDESC "You are on the landing stage below the station, where the mail boat ties up in better weather. Rain drives across the planks, and every few seconds a wave bursts over the breakwater and runs back hissing between them. A salt-crusted station clock is bolted to an iron post at the head of the landing. Ahead, through the station's open door, a hall light swings on its bracket. The station hall lies to the north, and there is nowhere else to go on a night like this.")
	(NORTH TO LB-HALL) (GLOBAL LB-DOORS) (FLAGS RLANDBIT ONBIT)>
<ROOM LB-HALL (IN ROOMS) (DESC "Station Hall")
	(LDESC "This is the hall of the station, a narrow room of varnished pine that smells of paraffin and wet oilskins. Water from the coats on their pegs has made a dark pool on the floor, and a freshly lettered appeal board hangs beside the door. Whoever killed Vane is still shut in here with the people who wanted to save his station. Vane's office is to the north, the studio to the east and the kitchen to the west. Wooden stairs climb up to the bunkroom, and the landing stage is back to the south.")
	(NORTH TO LB-OFFICE) (EAST TO LB-STUDIO) (WEST TO LB-KITCHEN) (UP TO LB-BUNKROOM) (SOUTH TO LB-LANDING) (GLOBAL LB-DOORS) (FLAGS RLANDBIT ONBIT)>
<ROOM LB-OFFICE (IN ROOMS) (DESC "Vane's Office")
	(ACTION LB-OFFICE-F)
	(SOUTH TO LB-HALL) (DOWN TO LB-PASSAGE IF LB-HATCH IS OPEN ELSE "The hatch is bolted shut; its square spindle takes a spanner.") (GLOBAL LB-HATCH LB-DOORS) (FLAGS RLANDBIT ONBIT)>
<ROOM LB-STUDIO (IN ROOMS) (DESC "Broadcast Studio")
	(LDESC "This is the broadcast studio, a small square room hung all round with brown felt to deaden the sound. In here the storm is only a pressure against the walls, and your own breathing seems loud. A microphone stands in the middle of the floor, a small red lamp glowing at its collar. Ruth Bell waits beside it, murmuring to herself in the trained voice of an announcer. The hall is back to the west, and a door with a glass panel leads east into the control room.")
	(WEST TO LB-HALL) (EAST TO LB-CONTROL) (GLOBAL LB-VANE LB-BROADCAST LB-DOORS) (FLAGS RLANDBIT ONBIT)>
<ROOM LB-CONTROL (IN ROOMS) (ACTION LB-CONTROL-LOOK) (DESC "Control Room")
	(WEST TO LB-STUDIO) (NORTH TO LB-CUTTING) (SOUTH TO LB-WORKSHOP) (GLOBAL LB-DOORS) (FLAGS RLANDBIT ONBIT)>
<ROOM LB-CUTTING (IN ROOMS) (ACTION LB-CUTTING-LOOK) (DESC "Disc Cutting Room")
	(SOUTH TO LB-CONTROL) (EAST TO LB-ARCHIVE) (GLOBAL LB-DOORS) (FLAGS RLANDBIT ONBIT)>
<ROOM LB-ARCHIVE (IN ROOMS) (ACTION LB-ARCHIVE-LOOK) (DESC "Record Archive")
	(WEST TO LB-CUTTING) (GLOBAL LB-DOORS) (FLAGS RLANDBIT ONBIT)>
<ROOM LB-WORKSHOP (IN ROOMS) (DESC "Service Workshop")
	(LDESC "This is the service workshop, a low room that smells of solder and machine oil. Coils of wire and the gutted cases of old receivers crowd the shelves, and burn marks freckle the long workbench. The control room is up a step to the north. An iron ladder goes down to the generator room, and the floor trembles faintly with its engine.")
	(NORTH TO LB-CONTROL) (DOWN TO LB-GENERATOR) (GLOBAL LB-LADDER) (FLAGS RLANDBIT ONBIT)>
<ROOM LB-GENERATOR (IN ROOMS) (DESC "Generator Room")
	(LDESC "You are in the generator room, under the workshop. A diesel generator fills most of the space, thumping steadily, and the smell of hot oil is thick enough to taste. Beside it a small recording instrument ticks over a drum of paper. An iron ladder leads up to the workshop, and the cable passage begins to the north.")
	(UP TO LB-WORKSHOP) (NORTH TO LB-PASSAGE) (GLOBAL LB-LADDER) (FLAGS RLANDBIT ONBIT)>
<ROOM LB-PASSAGE (IN ROOMS) (DESC "Cable Passage")
	(ACTION LB-PASSAGE-F)
	(SOUTH TO LB-GENERATOR) (UP TO LB-OFFICE IF LB-HATCH IS OPEN ELSE "The hatch is bolted shut; a square spindle faces you.") (GLOBAL LB-HATCH) (FLAGS RLANDBIT ONBIT)>
<ROOM LB-KITCHEN (IN ROOMS) (ACTION LB-KITCHEN-LOOK) (DESC "Station Kitchen")
	(EAST TO LB-HALL) (WEST TO LB-TELEGRAPH) (GLOBAL LB-VANE LB-BROADCAST LB-DOORS) (FLAGS RLANDBIT ONBIT)>
<ROOM LB-TELEGRAPH (IN ROOMS) (DESC "Telegraph Room")
	(LDESC "This is the telegraph room, hardly bigger than a cupboard and crowded with glass batteries and coils of wire. The brass sounder of the telegraph clicks to itself, and Tomas Vale, the operator, sits hunched at the key without a word. The kitchen is back to the east. Iron stairs climb up through a trapdoor to the aerial platform, and cold air comes down them.")
	(EAST TO LB-KITCHEN) (UP TO LB-PLATFORM) (GLOBAL LB-VANE LB-BROADCAST) (FLAGS RLANDBIT ONBIT)>
<ROOM LB-PLATFORM (IN ROOMS) (DESC "Aerial Platform")
	(LDESC "You are on the aerial platform, on the roof of the station and open to the full force of the gale. The aerial wires climb from here into the dark, humming in the wind, and a green signal lamp shines on the wet iron. Cold rain drives across the platform in sheets. Iron stairs lead down to the telegraph room. A covered walk runs across the roof to the bunkroom.")
	(DOWN TO LB-TELEGRAPH) (EAST TO LB-BUNKROOM) (GLOBAL LB-COVERED-WALK) (FLAGS RLANDBIT ONBIT)>
<ROOM LB-BUNKROOM (IN ROOMS) (DESC "Staff Bunkroom")
	(LDESC "This is the staff bunkroom, under the eaves at the top of the house. Four iron bunks stand against the walls, and the rain is loud just overhead. Ada Mercer, the station engineer, sits very straight on a hard chair beneath a maintenance roster pinned to the wall. The stairs lead down to the hall. A door opens onto the covered walk, which crosses the roof to the aerial platform.")
	(DOWN TO LB-HALL) (WEST TO LB-PLATFORM) (GLOBAL LB-VANE LB-BROADCAST LB-COVERED-WALK LB-DOORS) (FLAGS RLANDBIT ONBIT)>

<OBJECT LB-CASEBOOK (IN ADVENTURER) (DESC "casebook") (SYNONYM CASEBOOK NOTEBOOK CASE BOOK NOTE NOTES COLUMNS)  (FLAGS TAKEBIT) (SIZE 0) (INTERACTIONS "") (ACTION LB-CASEBOOK-F)>
<OBJECT LB-STATION-CLOCK (IN LB-LANDING) (DESC "station clock") (SYNONYM CLOCK TIME SALT POST) (ADJECTIVE STATION SPRING RUNNING SALT-CRUSTED) (FLAGS NDESCBIT) (INTERACTIONS "") (ACTION LB-STATION-CLOCK-F)>

<OBJECT LB-BOARD (IN LB-HALL) (DESC "appeal board") (SYNONYM BOARD SCHEDULE ENTRY ORDER) (ADJECTIVE APPEAL) (FLAGS NDESCBIT READBIT) (INTERACTIONS "") (ACTION LB-BOARD-F)>
<OBJECT LB-OFFICE-CLOCK (IN LB-OFFICE) (DESC "office clock") (SYNONYM CLOCK HANDS) (ADJECTIVE OFFICE ELECTRIC SYNCHRONOUS STOPPED WINDING) (FLAGS NDESCBIT) (INTERACTIONS "COMPARE:LB-CHART") (ACTION LB-OFFICE-CLOCK-F)>
<OBJECT LB-BODY (IN LB-OFFICE) (DESC "Julian Vane's body") (SYNONYM BODY CORPSE JULIAN WOUND EAR VANE BRUISE CHAIR) (ADJECTIVE JULIAN VANE DEAD VANES JULIANS STIFF BLUNT HEAD BRASS) (FLAGS NDESCBIT) (INTERACTIONS "COMPARE:LB-WEIGHT") (ACTION LB-BODY-F)>
<OBJECT LB-HATCH (IN LOCAL-GLOBALS) (DESC "service hatch") (SYNONYM HATCH SPINDLE BOLT SMEAR) (ADJECTIVE SERVICE SQUARE FLUSH OPEN OFFICE) (FLAGS NDESCBIT DOORBIT) (INTERACTIONS "USE-WITH:LB-SPANNER,LB-STYLUS;OPEN:LB-SPANNER;UNLOCK:LB-SPANNER") (ACTION LB-HATCH-F)>
<OBJECT LB-RUTH (IN LB-STUDIO) (DESC "Ruth Bell") (SYNONYM BELL RUTH ANNOUNCER WOMAN) (ADJECTIVE RUTH BELL) (FLAGS NDESCBIT ACTORBIT ARTICLEBIT) (INTERACTIONS "TELL:LB-MICROPHONE,LB-BROADCAST,LB-VANE,LB-DISC;SHOW:LB-DISC") (ACTION LB-RUTH-F)>
<OBJECT LB-MICROPHONE (IN LB-STUDIO) (DESC "microphone") (SYNONYM MICROPHONE MIKE LAMP MIC HEATER) (ADJECTIVE RED STUDIO HEATER WARM SUPPLY TINY) (FLAGS NDESCBIT) (INTERACTIONS "") (ACTION LB-MICROPHONE-F)>
<OBJECT LB-PLAYER (IN LB-CONTROL) (DESC "gramophone") (SYNONYM GRAMOPHONE PLAYER TURNTABLE PHONOGRAPH PICKUP PLATTER) (ADJECTIVE SPRING-DRIVEN BROADCAST) (FLAGS NDESCBIT CONTBIT OPENBIT SEARCHBIT) (CAPACITY 50) (INTERACTIONS "USE-WITH:LB-STYLUS,LB-SPANNER") (ACTION LB-PLAYER-F)>
<OBJECT LB-SWITCH (IN LB-CONTROL) (DESC "routing switch") (SYNONYM SWITCH ROUTING LEVER GUARD MARK) (ADJECTIVE ROUTING MIC DISC WAX WITNESS) (FLAGS NDESCBIT) (INTERACTIONS "") (ACTION LB-SWITCH-F)>
<OBJECT LB-CUTTER (IN LB-CUTTING) (DESC "disc cutter") (SYNONYM CUTTER MACHINE LACQUER COVER CRADLE ARM TURNTABLE) (ADJECTIVE DISC LACQUER CUTTING) (FLAGS NDESCBIT CONTBIT SEARCHBIT) (CAPACITY 20) (INTERACTIONS "") (ACTION LB-CUTTER-F)>
<OBJECT LB-REGISTER (IN LB-CUTTING) (DESC "cutter register") (SYNONYM REGISTER LOG LOGBOOK ENTRY ENTRIES) (ADJECTIVE CUTTER CUTTING) (FLAGS NDESCBIT READBIT) (INTERACTIONS "COMPARE:LB-DISC") (ACTION LB-REGISTER-F)>
<OBJECT LB-SLEEVE (IN LB-ARCHIVE) (DESC "cardboard sleeve") (SYNONYM SLEEVE ENVELOPE CARDBOARD FLAP) (ADJECTIVE CARDBOARD RECORD STIFF REHEARSAL ARCHIVE) (FLAGS NDESCBIT CONTBIT SEARCHBIT) (CAPACITY 30)  (INTERACTIONS "") (ACTION LB-SLEEVE-F)>
<OBJECT LB-DISC (IN LB-SLEEVE) (DESC "lacquer disc") (SYNONYM DISC RECORD GROOVE EDGE BAND LABEL) (ADJECTIVE LACQUER RECORDED APPEAL ALUMINIUM-BASED ALUMINIUM CHIPPED SIX-MINUTE ARCHIVE) (FLAGS TAKEBIT READBIT) (SIZE 2) (LDESC "A lacquer disc lies here.") (INTERACTIONS "PUT:LB-PLAYER,LB-SLEEVE;COMPARE:LB-REGISTER;SHOW:LB-RUTH,LB-ADA") (ACTION LB-DISC-F)>
<OBJECT LB-LEDGER (IN LB-ARCHIVE) (DESC "wage ledger") (SYNONYM LEDGER WAGES WAGE ACCOUNTS BOOK FIGURES) (ADJECTIVE WAGE) (FLAGS NDESCBIT TAKEBIT READBIT) (SIZE 1) (LDESC "A wage ledger lies here.") (INTERACTIONS "SHOW:LB-ADA") (ACTION LB-LEDGER-F)>
<OBJECT LB-WORKBENCH (IN LB-WORKSHOP) (DESC "workbench")
	(SYNONYM WORKBENCH BENCH) (ADJECTIVE SERVICE SOLDER)
	(FLAGS NDESCBIT) (INTERACTIONS "") (ACTION LB-WORKBENCH-F)>
<OBJECT LB-STYLUS (IN LB-WORKSHOP) (DESC "playback stylus") (SYNONYM STYLUS NEEDLE) (ADJECTIVE PLAYBACK STEEL SAPPHIRE SMALL WORKSHOP) (FLAGS NDESCBIT TAKEBIT) (SIZE 0) (LDESC "A playback stylus lies here.") (INTERACTIONS "USE-ON:LB-PLAYER,LB-HATCH") (ACTION LB-STYLUS-F)>
<OBJECT LB-SPANNER (IN LB-WORKSHOP) (DESC "service spanner") (SYNONYM SPANNER WRENCH TOOL SOCKET) (ADJECTIVE SERVICE SQUARE SQUARE-SOCKET LARGE WORKSHOP) (FLAGS TAKEBIT TOOLBIT) (SIZE 1) (LDESC "A service spanner lies here.") (INTERACTIONS "USE-ON:LB-HATCH,LB-PLAYER") (ACTION LB-SPANNER-F)>
<OBJECT LB-GENERATOR-MACHINE (IN LB-GENERATOR) (DESC "lighting generator") (SYNONYM GENERATOR DIESEL MOTOR ENGINE ACCUMULATORS INSTRUMENT RECORDER DRUM) (ADJECTIVE LIGHTING DIESEL MECHANICAL) (FLAGS NDESCBIT) (INTERACTIONS "") (ACTION LB-GENERATOR-F)>
<OBJECT LB-CHART (IN LB-GENERATOR) (DESC "voltage chart") (SYNONYM CHART TRACE VOLTAGE) (ADJECTIVE VOLTAGE GENERATOR MECHANICAL) (FLAGS TAKEBIT READBIT) (SIZE 0) (LDESC "A voltage chart lies here.") (INTERACTIONS "COMPARE:LB-OFFICE-CLOCK") (ACTION LB-CHART-F)>
<OBJECT LB-STAIN (IN LB-PASSAGE) (DESC "passage stain") (SYNONYM STAIN BLOOD PRINT FOOTPRINT HEEL DIAMOND) (ADJECTIVE PASSAGE HEEL BLOODY BLOOD DILUTED) (FLAGS NDESCBIT) (INTERACTIONS "COMPARE:LB-BOOTS") (ACTION LB-STAIN-F)>
<OBJECT LB-EDITH (IN LB-KITCHEN) (DESC "Dr Edith Shaw") (SYNONYM SHAW EDITH DOCTOR PHYSICIAN) (ADJECTIVE EDITH DR SHAW DOCTOR) (FLAGS NDESCBIT ACTORBIT ARTICLEBIT) (INTERACTIONS "TELL:LB-BAG,LB-DRESSING,LB-BROADCAST,LB-VANE;SHOW:LB-DRESSING") (ACTION LB-EDITH-F)>
<OBJECT LB-TABLE (IN LB-KITCHEN) (DESC "kitchen table") (SYNONYM TABLE GLASS TUMBLER) (ADJECTIVE KITCHEN BROKEN COLD) (FLAGS NDESCBIT) (INTERACTIONS "") (ACTION LB-TABLE-F)>
<OBJECT LB-BAG (IN LB-KITCHEN) (DESC "medical bag") (SYNONYM BAG SATCHEL CLASP) (ADJECTIVE MEDICAL LEATHER PRIVATE EDITH) (FLAGS NDESCBIT CONTBIT SEARCHBIT) (CAPACITY 20)  (INTERACTIONS "") (ACTION LB-BAG-F)>
<OBJECT LB-DRESSING (IN LB-BAG) (DESC "bloodied dressing") (SYNONYM DRESSING BANDAGE GAUZE FRAGMENTS INITIALS) (ADJECTIVE BLOODIED MEDICAL BLOODY RUTH) (FLAGS TAKEBIT READBIT) (SIZE 0) (LDESC "A bloodied dressing lies here.") (INTERACTIONS "SHOW:LB-EDITH") (ACTION LB-DRESSING-F)>
<OBJECT LB-TOMAS (IN LB-TELEGRAPH) (DESC "Tomas Vale") (SYNONYM VALE TOMAS OPERATOR MAN) (ADJECTIVE TOMAS VALE TELEGRAPH) (FLAGS NDESCBIT ACTORBIT ARTICLEBIT) (INTERACTIONS "TELL:LB-RECEIPT,LB-BROADCAST,LB-VANE;SHOW:LB-RECEIPT") (ACTION LB-TOMAS-F)>
<OBJECT LB-TELEGRAPH-MACHINE (IN LB-TELEGRAPH) (DESC "telegraph") (SYNONYM TELEGRAPH KEY SOUNDER TAPE LANDLINE) (ADJECTIVE TWO-WAY) (FLAGS NDESCBIT) (INTERACTIONS "") (ACTION LB-TELEGRAPH-F)>
<OBJECT LB-RECEIPT (IN LB-TELEGRAPH) (DESC "telegraph receipt") (SYNONYM RECEIPT TRANSMISSION STRIP STAMPS MESSAGE) (ADJECTIVE TELEGRAPH STAMPED MAINLAND OUTGOING) (FLAGS TAKEBIT READBIT) (SIZE 0) (LDESC "A telegraph receipt lies here.") (INTERACTIONS "SHOW:LB-TOMAS") (ACTION LB-RECEIPT-F)>
<OBJECT LB-AERIAL (IN LB-PLATFORM) (DESC "aerial") (SYNONYM AERIAL ANTENNA WIRE RAIN) (ADJECTIVE WET IRON) (FLAGS NDESCBIT) (INTERACTIONS "") (ACTION LB-AERIAL-F)>
<OBJECT LB-LAMP (IN LB-PLATFORM) (DESC "signal lamp") (SYNONYM LAMP SIGNAL LIGHT) (ADJECTIVE SIGNAL GREEN TRANSMITTER RED) (FLAGS NDESCBIT) (INTERACTIONS "") (ACTION LB-LAMP-F)>
<OBJECT LB-ADA (IN LB-BUNKROOM) (DESC "Ada Mercer") (SYNONYM MERCER ADA ENGINEER WOMAN) (ADJECTIVE ADA MERCER) (FLAGS NDESCBIT ACTORBIT ARTICLEBIT) (INTERACTIONS "TELL:LB-BOOTS,LB-ROSTER,LB-DISC,LB-WEIGHT,LB-BROADCAST,LB-VANE,LB-LEDGER,LB-STAIN;SHOW:LB-LEDGER,LB-DISC,LB-BOOTS,LB-WEIGHT") (ACTION LB-ADA-F)>
<OBJECT LB-BOOTS (IN LB-BUNKROOM) (DESC "pair of leather boots") (SYNONYM BOOTS BOOT SOLES PATCH REPAIR PAIR SOLE HEEL STITCHING) (ADJECTIVE LEATHER ADA WORN REPAIRED LEFT SQUARE HEEL) (FLAGS TAKEBIT) (SIZE 1) (LDESC "A pair of leather boots stands here.") (INTERACTIONS "COMPARE:LB-STAIN;SHOW:LB-ADA") (ACTION LB-BOOTS-F)>
<OBJECT LB-ROSTER (IN LB-BUNKROOM) (DESC "maintenance roster") (SYNONYM ROSTER MAINTENANCE DUTY SCHEDULE) (ADJECTIVE MAINTENANCE SIGNED) (FLAGS NDESCBIT READBIT) (INTERACTIONS "") (ACTION LB-ROSTER-F)>
<OBJECT LB-VANE (IN LOCAL-GLOBALS) (DESC "Julian Vane") (SYNONYM VANE OWNER JULIAN) (ADJECTIVE JULIAN VANE) (FLAGS NDESCBIT) (INTERACTIONS "") (ACTION LB-VANE-F)>
<OBJECT LB-BROADCAST (IN LOCAL-GLOBALS) (DESC "broadcast") (SYNONYM BROADCAST APPEAL ALIBI VOICE SOUND MURDER RECORDING) (ADJECTIVE APPEAL RECORDED SIX-MINUTE) (FLAGS NDESCBIT) (INTERACTIONS "") (ACTION LB-BROADCAST-F)>

<OBJECT LB-WEIGHT (IN LB-CUTTER) (DESC "brass counterweight") (SYNONYM COUNTERWEIGHT WEIGHT BRASS RIM DUST NOTCH LUG CRESCENT) (ADJECTIVE BRASS CUTTER LOOSE HEAVY BROKEN NOTCHED RETAINING) (FLAGS TAKEBIT) (SIZE 1) (LDESC "A brass counterweight rests here.") (INTERACTIONS "COMPARE:LB-BODY;SHOW:LB-ADA") (ACTION LB-WEIGHT-F)>

<OBJECT LB-HALL-LIGHT (IN LB-LANDING) (DESC "hall light")
    (SYNONYM LIGHT LAMP BULB) (ADJECTIVE HALL YELLOW)
    (FLAGS NDESCBIT) (INTERACTIONS "")
    (TEXT "Swinging on its bracket, the bulb sends a slow stripe of light across the landing. It stays lit between swings.")
    (ACTION LB-HALL-LIGHT-F)>

<OBJECT LB-HALL-STAIRS (IN LB-HALL) (DESC "station stairs")
    (SYNONYM STAIRS STEPS STAIRCASE) (ADJECTIVE STATION WOODEN)
    (FLAGS NDESCBIT PLURALBIT) (INTERACTIONS "")
    (TEXT "The middle of each tread is worn hollow. The stair creaks loudest at the turn below the bunkroom.")
    (ACTION LB-HALL-STAIRS-F)>

<OBJECT LB-CONTROL-LIGHT (IN LB-CONTROL) (DESC "green light")
    (SYNONYM LIGHT LAMP BULB) (ADJECTIVE GREEN CONTROL)
    (FLAGS NDESCBIT) (INTERACTIONS "")
    (TEXT "The little lamp is wired to the transmitter. It shines just as green when the microphone is silent.")
    (ACTION LB-CONTROL-LIGHT-F)>

<OBJECT LB-LACQUER-CURL (IN LB-CUTTING) (DESC "curl of lacquer")
    (SYNONYM CURL SHAVING THREAD) (ADJECTIVE LACQUER THIN)
    (FLAGS NDESCBIT) (INTERACTIONS "")
    (TEXT "It is one long, fine shaving. The cutting needle lifts a thread like this as it carves a groove.")
    (ACTION LB-LACQUER-CURL-F)>

<OBJECT LB-ARCHIVE-PAPERS (IN LB-ARCHIVE) (DESC "archive papers")
    (SYNONYM PAPERS PAPER DRAUGHT DRAFT) (ADJECTIVE ARCHIVE COLD LOOSE)
    (FLAGS NDESCBIT READBIT PLURALBIT) (INTERACTIONS "")
    (TEXT "The loose sheets lift at one corner whenever air comes under the cutting-room door. Most are blank requisition forms.")
    (ACTION LB-ARCHIVE-PAPERS-F)>

<OBJECT LB-COVERED-WALK (IN LOCAL-GLOBALS) (DESC "covered walk")
    (SYNONYM WALK WALKWAY BOARDS) (ADJECTIVE COVERED WOODEN)
    (FLAGS NDESCBIT) (INTERACTIONS "")
    (TEXT "A strip of corrugated tin keeps the middle boards dry. Rain blows in on the aerial side.")
    (ACTION LB-COVERED-WALK-F)>

<OBJECT LB-TELEGRAPH-STAIRS (IN LB-TELEGRAPH) (DESC "platform stairs")
    (SYNONYM STAIRS STEPS STAIRCASE TRAPDOOR) (ADJECTIVE PLATFORM IRON)
    (FLAGS NDESCBIT PLURALBIT) (INTERACTIONS "")
    (TEXT "Clean drops hang from the lowest iron tread. Someone coming in from the platform brings the weather down with them.")
    (ACTION LB-TELEGRAPH-STAIRS-F)>

<OBJECT DETAIL-BRASS-DUST (IN LB-OFFICE) (DESC "brass dust")
    (SYNONYM GRAINS DUST CRESCENT GAP) (ADJECTIVE BRASS NARROW)
    (FLAGS NDESCBIT) (INTERACTIONS "")
    (TEXT "The grains lie thick at both ends of the crescent. Across the little gap the skin is entirely clean.")
    (ACTION DETAIL-BRASS-DUST-F)>

<OBJECT DETAIL-WINDING-KNOB (IN LB-OFFICE) (DESC "winding knob")
    (SYNONYM KNOB SPINDLE) (ADJECTIVE WINDING CLOCK)
    (FLAGS NDESCBIT) (INTERACTIONS "")
    (TEXT "The maker stamped SET beside it. The knob moves the hands, and has no ratchet to wind.")
    (ACTION DETAIL-WINDING-KNOB-F)>

<OBJECT DETAIL-HEATER-PLATE (IN LB-STUDIO) (DESC "heater plate")
    (SYNONYM PLATE LETTERING) (ADJECTIVE HEATER TINY)
    (FLAGS NDESCBIT READBIT) (INTERACTIONS "")
    (TEXT "The letters are punched straight into the metal. Alongside HEATER someone pencilled a little arrow pointing to the lamp.")
    (ACTION DETAIL-HEATER-PLATE-F)>

<OBJECT DETAIL-WAX-DAB (IN LB-CONTROL) (DESC "wax dab")
    (SYNONYM DAB WAX SEAL) (ADJECTIVE WAX SWITCH)
    (FLAGS NDESCBIT) (INTERACTIONS "")
    (TEXT "Half the wax clings to the guard and half to the switch. Their edges meet at DISC like the halves of a torn ticket.")
    (ACTION DETAIL-WAX-DAB-F)>

<OBJECT DETAIL-CUTTING-NEEDLE (IN LB-CUTTING) (DESC "cutting needle")
    (SYNONYM NEEDLE POINT) (ADJECTIVE CUTTING)
    (FLAGS NDESCBIT) (INTERACTIONS "")
    (TEXT "A fine amber thread still clings to the point. It curls the same way as the shaving on the bench.")
    (ACTION DETAIL-CUTTING-NEEDLE-F)>

<OBJECT DETAIL-SQUARE-REPAIR (IN LB-PASSAGE) (DESC "square repair")
    (SYNONYM REPAIR PATCH DIAMOND) (ADJECTIVE SQUARE DIAGONAL)
    (FLAGS NDESCBIT) (INTERACTIONS "")
    (ACTION LB-HEEL-REPAIR-F)>

<OBJECT DETAIL-CUPS (IN LB-KITCHEN) (DESC "cups")
    (SYNONYM CUPS CUP SAUCER TEA) (ADJECTIVE COLD)
    (FLAGS NDESCBIT PLURALBIT) (INTERACTIONS "")
    (TEXT "One cup still has a spoon in it. The other has left three wet rings where its owner kept lifting it and putting it down.")
    (ACTION DETAIL-CUPS-F)>

<OBJECT DETAIL-BLACK-FELT (IN LB-WORKSHOP) (DESC "black felt")
    (SYNONYM FELT CLOTH) (ADJECTIVE BLACK)
    (FLAGS NDESCBIT) (INTERACTIONS "")
    (TEXT "The nap is worn thin in one short groove. A delicate point laid there would stay put even when the bench shook.")
    (ACTION DETAIL-BLACK-FELT-F)>

<OBJECT LB-DOORS (IN LOCAL-GLOBALS) (DESC "door")
    (SYNONYM DOOR DOORS DOORWAY PANEL) (ADJECTIVE PAINTED GLASS)
    (FLAGS NDESCBIT) (INTERACTIONS "")
    (TEXT "An ordinary painted door, swollen with the damp. Like every door in the station it stands open, and none of them has a lock worth the name.")
    (ACTION LB-DOORS-F)>

<OBJECT LB-SEA (IN LB-LANDING) (DESC "breakwater")
    (SYNONYM BREAKWATER WAVE WAVES SEA SPRAY PLANKS) (ADJECTIVE GREY STONE)
    (FLAGS NDESCBIT) (INTERACTIONS "")
    (TEXT "A long arm of piled grey stone shelters the landing. Every few waves one comes clean over the top and runs back across the planks.")
    (ACTION LB-SEA-F)>

<OBJECT LB-COATS (IN LB-HALL) (DESC "coats")
    (SYNONYM COATS COAT PEGS PEG OILSKINS POOL) (ADJECTIVE WET WOOL)
    (FLAGS NDESCBIT PLURALBIT) (INTERACTIONS "")
    (TEXT "A row of oilskins and one good wool overcoat hang from iron pegs, dripping onto the floor.")
    (ACTION LB-COATS-F)>

<OBJECT LB-CABINETS (IN LB-OFFICE) (DESC "filing cabinets")
    (SYNONYM CABINETS CABINET BOXES BOX FILES DRAWERS) (ADJECTIVE FILING DEED GREEN)
    (FLAGS NDESCBIT PLURALBIT) (INTERACTIONS "")
    (TEXT "Green steel cabinets and black japanned deed boxes, every one of them locked. Vane kept his papers where his staff could not reach them.")
    (ACTION LB-CABINETS-F)>

<OBJECT LB-FELT (IN LB-STUDIO) (DESC "studio felt")
    (SYNONYM FELT WALLS WALL) (ADJECTIVE BROWN STUDIO)
    (FLAGS NDESCBIT) (INTERACTIONS "")
    (TEXT "Brown felt, tacked over every inch of wall to swallow echoes. It is grey with dust along the top.")
    (ACTION LB-FELT-F)>

<OBJECT LB-VALVES (IN LB-CONTROL) (DESC "valves")
    (SYNONYM VALVES VALVE RACKS RACK TRANSMITTER) (ADJECTIVE ORANGE STEEL)
    (FLAGS NDESCBIT PLURALBIT) (INTERACTIONS "")
    (TEXT "Tall steel racks of valves glow orange behind wire mesh. They warm the room like a small fire.")
    (ACTION LB-VALVES-F)>

<OBJECT LB-SHELVES (IN LB-ARCHIVE) (DESC "archive shelves")
    (SYNONYM SHELVES SHELF DISCS RECORDS) (ADJECTIVE ARCHIVE NUMBERED)
    (FLAGS NDESCBIT PLURALBIT) (INTERACTIONS "")
    (TEXT "Hundreds of discs in brown card sleeves, each numbered on the spine in the same neat hand. Dust lies evenly along every shelf.")
    (ACTION LB-SHELVES-F)>

<OBJECT LB-READING-TABLE (IN LB-ARCHIVE) (DESC "reading table")
    (SYNONYM TABLE) (ADJECTIVE READING DEAL)
    (FLAGS NDESCBIT) (INTERACTIONS "")
    (TEXT "A plain deal table, scarred by years of sleeves slid across it.")
    (ACTION LB-READING-TABLE-F)>

<OBJECT LB-WORKSHOP-SHELVES (IN LB-WORKSHOP) (DESC "workshop shelves")
    (SYNONYM SHELVES SHELF RECEIVERS RECEIVER COILS WIRE) (ADJECTIVE WORKSHOP GUTTED)
    (FLAGS NDESCBIT PLURALBIT) (INTERACTIONS "")
    (TEXT "Coils of wire, boxes of spare valves and the gutted cases of old receivers, kept for parts. It is all in better order than it looks.")
    (ACTION LB-WORKSHOP-SHELVES-F)>

<OBJECT LB-LADDER (IN LOCAL-GLOBALS) (DESC "iron ladder")
    (SYNONYM LADDER RUNGS) (ADJECTIVE IRON)
    (FLAGS NDESCBIT) (INTERACTIONS "")
    (TEXT "An iron ladder, its rungs worn bright, bolted to the wall of the shaft between the workshop and the generator room.")
    (ACTION LB-LADDER-F)>

<OBJECT LB-PIPES (IN LB-PASSAGE) (DESC "pipes")
    (SYNONYM PIPES PIPE CABLES CABLE WIRING TUNNEL) (ADJECTIVE LEAD COLD BRICK)
    (FLAGS NDESCBIT PLURALBIT) (INTERACTIONS "")
    (TEXT "Lead pipes and cloth-wrapped cables run along the brickwork in iron brackets, sweating with condensation.")
    (ACTION LB-PIPES-F)>

<OBJECT LB-RANGE (IN LB-KITCHEN) (DESC "kitchen range")
    (SYNONYM RANGE STOVE KETTLE OVEN) (ADJECTIVE KITCHEN IRON)
    (FLAGS NDESCBIT) (INTERACTIONS "")
    (TEXT "A black iron range, banked low for the night. The kettle on it ticks as it cools.")
    (ACTION LB-RANGE-F)>

<OBJECT LB-KITCHEN-WINDOW (IN LB-KITCHEN) (DESC "kitchen window")
    (SYNONYM WINDOW SINK) (ADJECTIVE KITCHEN)
    (FLAGS NDESCBIT) (INTERACTIONS "")
    (TEXT "Black glass with rain sheeting down it. You can see nothing outside, only lamplight and your own tired face.")
    (ACTION LB-KITCHEN-WINDOW-F)>

<OBJECT LB-BATTERIES (IN LB-TELEGRAPH) (DESC "glass batteries")
    (SYNONYM BATTERIES BATTERY JARS COILS WIRE) (ADJECTIVE GLASS)
    (FLAGS NDESCBIT PLURALBIT) (INTERACTIONS "")
    (TEXT "Rows of glass jars of acid, each holding a pair of plates, wired together to drive the landline.")
    (ACTION LB-BATTERIES-F)>

<OBJECT LB-BUNKS (IN LB-BUNKROOM) (DESC "iron bunks")
    (SYNONYM BUNKS BUNK BEDS BED CHAIR) (ADJECTIVE IRON HARD)
    (FLAGS NDESCBIT PLURALBIT) (INTERACTIONS "")
    (TEXT "Four iron bunks, the blankets folded square in the naval way. A hard chair stands between two of them.")
    (ACTION LB-BUNKS-F)>

<OBJECT LB-STATION (IN LB-LANDING) (DESC "station building")
    (SYNONYM STATION BUILDING) (ADJECTIVE WIRELESS)
    (FLAGS NDESCBIT) (INTERACTIONS "")
    (TEXT "Saint Bride station is a squat stone house with an aerial mast on its roof, every window lit. Its door stands open to the north, and the hall light swings just inside.")
    (ACTION LB-STATION-F)>
