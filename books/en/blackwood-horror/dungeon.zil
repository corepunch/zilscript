<DIRECTIONS NORTH EAST WEST SOUTH NE NW SE SW UP DOWN IN OUT LAND>
<VERSION ZIP>
<CONSTANT RELEASEID 1>

; === GLOBAL FLAGS ===

<GLOBAL VALVE-TURNED-FLAG <>>
<GLOBAL STEAM-DOOR-OPEN <>>
<GLOBAL LANTERN-LIT-FLAG <>>
<GLOBAL CHAPEL-UNLOCKED <>>
<GLOBAL DRAWER-UNLOCKED <>>
<GLOBAL SAFE-UNLOCKED <>>
<GLOBAL CHAINS-CUT-FLAG <>>
<GLOBAL GAME-WON <>>
<GLOBAL PATIENT-STATE 0> ;"0=absent, 1=aware, 2=twitching, 3=liberated"
<GLOBAL PATIENT-LORE 0> ;"count of distinct lore discoveries and first-time topics"
<GLOBAL PATIENT-FILE-LORE <>>
<GLOBAL WALL-SCRATCHES-LORE <>>
<GLOBAL STRAITJACKET-LORE <>>
<GLOBAL BOILER-LIT <>>
<GLOBAL BOILER-HEAT 0>
<GLOBAL CABINET-THAWED <>>
<GLOBAL HINT-KEY 0>
<GLOBAL HINT-LEVEL 0>
<GLOBAL SCORE-MAX 68>
<GLOBAL RANKINGS
    <LTABLE "Confused Patient"
         "Curious Inmate"
         "Asylum Explorer"
         "Sanitarium Survivor">>
<GLOBAL WHISPER-TABLE
    <LTABLE 0
        "A voice, barely audible, rasps: “help... me...”"
        "You hear your name whispered -- impossible, you never told anyone you were coming."
        "A child's voice whispers something in a language you don't recognize."
        "The walls seem to breathe a single word: “run.”">>

; === ROOMS ===

<ROOM SANITARIUM-GATE
      (IN ROOMS)
      (DESC "Sanitarium Gate")
      (LDESC "You are standing at the gates of Blackwood Sanitarium. The rusted iron gates hang open. A brass plaque has worked loose at one corner. Crows crowd the dead oak beside it without making a sound. The gravel path stops here; the way in lies open to the north, under rows of black windows.")
      (NORTH TO SANITARIUM-ENTRANCE)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL SANITARIUM-BUILDING DEAD-OAK-TREE)>

<ROOM SANITARIUM-ENTRANCE
      (IN ROOMS)
      (DESC "Sanitarium Entrance Hall")
      (LDESC "You are in the entrance hall of the sanitarium. Half of the grand staircase has fallen in, and the plaster dust on the floor shows no footprints but yours. Black mold has crept up the peeling wallpaper. Reception is to the west, and the patient ward lies to the east. A sagging door stands half-open to the north, narrow stairs go down to the basement, and the gates are back to the south.")
      (SOUTH TO SANITARIUM-GATE)
      (WEST TO RECEPTION-ROOM)
      (NORTH TO OPERATING-THEATER)
      (EAST TO PATIENT-WARD)
      (DOWN TO BASEMENT-STAIRS)
      (UP "The grand staircase ends at a collapsed landing. There is no way up.")
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL SANITARIUM-BUILDING DEAD-OAK-TREE)>

<ROOM RECEPTION-ROOM
      (IN ROOMS)
      (DESC "Reception Room")
      (ACTION RECEPTION-ROOM-FCN)
      (EAST TO SANITARIUM-ENTRANCE)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL FILING-CABINETS)>

<ROOM OPERATING-THEATER
      (IN ROOMS)
      (DESC "Operating Theater")
      (ACTION OPERATING-THEATER-FCN)
      (SOUTH TO SANITARIUM-ENTRANCE)
      (FLAGS RLANDBIT ONBIT)>

<ROOM PATIENT-WARD
      (IN ROOMS)
      (DESC "Patient Ward")
      (ACTION PATIENT-WARD-FCN)
      (WEST TO SANITARIUM-ENTRANCE)
      (NORTH TO MORGUE IF CHAINS-CUT-FLAG ELSE "The heavy door at the far end is still bound shut.")
      (FLAGS RLANDBIT ONBIT)>

<ROOM MORGUE
      (IN ROOMS)
      (DESC "Morgue")
      (ACTION MORGUE-FCN)
      (SOUTH TO PATIENT-WARD)
      (FLAGS RLANDBIT ONBIT)
      (VALUE 10)>

<ROOM BASEMENT-STAIRS
      (IN ROOMS)
      (DESC "Basement Stairs")
      (LDESC "You are on a narrow stone staircase that runs from the hall down into the basement. Every step is wet, and each one is colder than the last. From somewhere below comes a slow, steady dripping. The stairs climb up to the entrance hall and go on down to the basement corridor.")
      (UP TO SANITARIUM-ENTRANCE)
      (DOWN TO BASEMENT-CORRIDOR)
      (FLAGS RLANDBIT ONBIT)>

<ROOM BASEMENT-CORRIDOR
      (IN ROOMS)
      (DESC "Basement Corridor")
      (ACTION BASEMENT-CORRIDOR-FCN)
      (UP TO BASEMENT-STAIRS)
      (EAST TO BOILER-ROOM)
      (WEST TO STORAGE-ROOM)
      (NORTH PER FLOODED-PASSAGE)
      (FLAGS RLANDBIT ONBIT)>

<ROOM BOILER-ROOM
      (IN ROOMS)
      (DESC "Boiler Room")
      (ACTION BOILER-ROOM-FCN)
      (WEST TO BASEMENT-CORRIDOR)
      (FLAGS RLANDBIT ONBIT)>

<ROOM STORAGE-ROOM
      (IN ROOMS)
      (DESC "Storage Room")
      (ACTION STORAGE-ROOM-FCN)
      (EAST TO BASEMENT-CORRIDOR)
      (FLAGS RLANDBIT ONBIT)>

<ROOM FLOODING-CHAMBER
      (IN ROOMS)
      (DESC "Flooded Chamber")
      (ACTION FLOODING-CHAMBER-FCN)
      (SOUTH TO BASEMENT-CORRIDOR)
      (NORTH TO ISOLATION-WARD)
      (EAST TO HYDROTHERAPY-ROOM IF STEAM-DOOR-OPEN ELSE "The metal door to the east is corroded shut.")
      (FLAGS RLANDBIT)>

<ROOM HYDROTHERAPY-ROOM
      (IN ROOMS)
      (DESC "Hydrotherapy Room")
      (ACTION HYDROTHERAPY-ROOM-FCN)
      (WEST TO FLOODING-CHAMBER)
      (FLAGS RLANDBIT)>

<ROOM ISOLATION-WARD
      (IN ROOMS)
      (DESC "Isolation Ward")
      (LDESC "This is the isolation ward, a narrow hall lined with heavy cell doors, each with a small barred window. Between the doors, thousands of scratches have been cut by fingernails, row upon row. Your lantern light shakes on them. One set of scratches stops at shoulder height; the next begins lower, as if the hand that made it had slid down the wall. To the north lies a room of scorched concrete, and the flooded chamber is back to the south.")
      (SOUTH TO FLOODING-CHAMBER)
      (NORTH TO ELECTROSHOCK-THEATER)
      (FLAGS RLANDBIT)
      (VALUE 5)>

<ROOM ELECTROSHOCK-THEATER
      (IN ROOMS)
      (DESC "Electroshock Theater")
      (LDESC "You are in the electroshock theater, a bare room of scorched concrete that still smells faintly of burning. In the middle, a metal chair is bolted to the floor, facing a machine of dials and electrodes. Stone stairs climb east toward an observation deck, and a heavy door stands ajar to the west, on a padded cell. The isolation ward is back to the south.")
      (SOUTH TO ISOLATION-WARD)
      (EAST TO OBSERVATION-DECK)
      (WEST TO PADDED-CELL)
      (FLAGS RLANDBIT)
      (VALUE 8)>

<ROOM PADDED-CELL
      (IN ROOMS)
      (DESC "Padded Cell")
      (LDESC "This is a padded cell, hardly wider than your outstretched arms. The padding on the walls is torn and rotting, and in places dark writing shows through the splits. The air is damp and sour. The heavy door to the east is the only way out, back to the electroshock theater.")
      (EAST TO ELECTROSHOCK-THEATER)
      (FLAGS RLANDBIT)
      (VALUE 5)>

<ROOM OBSERVATION-DECK
      (IN ROOMS)
      (DESC "Observation Deck")
      (LDESC "You are on the observation deck, a long, narrow room where the doctors once watched their treatments. A one-way mirror fills one side of it, and a narrow desk runs beneath it, worn smooth along its edge. Stone stairs lead down to the west, and a door to the north opens into the administrative wing.")
      (WEST PER UNLIT-STAIRWAY)
      (NORTH TO ADMINISTRATIVE-WING)
      (FLAGS RLANDBIT ONBIT)>

<ROOM ADMINISTRATIVE-WING
      (IN ROOMS)
      (DESC "Administrative Wing")
      (LDESC "This is the administrative wing, and it smells of damp paper and old ink. Filing cabinets lie overturned on their sides, and loose papers have spilled from them across the floor like dirty snow. The director’s office is to the east and the staff quarters to the north. The observation deck is back to the south.")
      (SOUTH TO OBSERVATION-DECK)
      (EAST TO DIRECTORS-OFFICE)
      (NORTH TO STAFF-QUARTERS)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL FILING-CABINETS)>

<ROOM DIRECTORS-OFFICE
      (IN ROOMS)
      (DESC "Director's Office")
      (ACTION DIRECTORS-OFFICE-FCN)
      (WEST TO ADMINISTRATIVE-WING)
      (FLAGS RLANDBIT ONBIT)>

<ROOM STAFF-QUARTERS
      (IN ROOMS)
      (DESC "Staff Quarters")
      (LDESC "These are the staff quarters, where the night nurses slept between their rounds. Narrow iron beds stand in two rows, stripped down to their springs, and a bank of dented lockers leans crookedly at the far end. The cafeteria is to the west, and the administrative wing is back to the south.")
      (SOUTH TO ADMINISTRATIVE-WING)
      (WEST TO CAFETERIA)
      (FLAGS RLANDBIT ONBIT)>

<ROOM CAFETERIA
      (IN ROOMS)
      (DESC "Cafeteria")
      (LDESC "This is the staff cafeteria. A long serving counter runs down one side under a grey skin of dust, and the chairs are stacked upside down on the tables, as if someone meant to come back and mop. A wooden door with a cracked pane leads north into the garden, and the staff quarters are back to the east.")
      (EAST TO STAFF-QUARTERS)
      (NORTH TO OVERGROWN-GARDEN)
      (FLAGS RLANDBIT ONBIT)>

<ROOM OVERGROWN-GARDEN
      (IN ROOMS)
      (DESC "Overgrown Garden")
      (ACTION OVERGROWN-GARDEN-FCN)
      (SOUTH TO CAFETERIA)
      (NORTH TO CHAPEL IF CHAPEL-UNLOCKED ELSE "The chapel door is locked.")
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL SANITARIUM-BUILDING DEAD-OAK-TREE)>

<ROOM CHAPEL
      (IN ROOMS)
      (DESC "Chapel")
      (ACTION CHAPEL-FCN)
      (SOUTH TO OVERGROWN-GARDEN)
      (FLAGS RLANDBIT ONBIT)
      (VALUE 15)
      (GLOBAL TOPIC-MORDECAI TOPIC-TREATMENT TOPIC-IDENTITY TOPIC-SANITARIUM TOPIC-CHAPEL)>

; === OBJECTS ===

<OBJECT IRON-GATES
        (IN SANITARIUM-GATE)
        (SYNONYM GATE GATES BARS)
        (ADJECTIVE IRON RUSTED BLACK OLD SANITARIUM)
        (DESC "iron gate")
        (INTERACTIONS "")
        (LDESC "The rusted iron gates stand open. Flakes of old black paint cling to bars bent by years of weather.")
        (FLAGS NDESCBIT OPENBIT)
        (ACTION IRON-GATES-F)>

<OBJECT BRASS-PLAQUE
        (IN SANITARIUM-GATE)
        (SYNONYM PLAQUE BRASS SIGN NAMEPLATE)
        (ADJECTIVE BRASS CORRODED BOLTED)
        (DESC "brass plaque")
        (INTERACTIONS "")
        (LDESC "A brass plaque hangs askew.")
        (FLAGS READBIT NDESCBIT) ;"The gate's description tells of it."
        (TEXT "Beneath the corrosion you can read: “Blackwood Sanitarium - Est. 1898 - Closed by Order 1952”")
        (SIZE 5)
        (ACTION BRASS-PLAQUE-F)>

<OBJECT THEATER-DOOR
        (IN SANITARIUM-ENTRANCE)
        (SYNONYM DOOR)
        (ADJECTIVE HALF-OPEN THEATER OPERATING JAMMED SAGGING)
        (DESC "door to the operating theater")
        (INTERACTIONS "")
        (ACTION THEATER-DOOR-F)
        (FLAGS NDESCBIT) ;"The hall's description tells of it."
        (LDESC "A theater door stands ajar to the north.")>

<OBJECT OAK-DESK
        (IN RECEPTION-ROOM)
        (SYNONYM DESK)
        (ADJECTIVE HEAVY OAK DUSTY WOODEN)
        (DESC "oak desk")
        (INTERACTIONS "")
        (DESCFCN OAK-DESK-DESC-F)
        (FLAGS CONTBIT OPENBIT SURFACEBIT)
        (TEXT "A thick skin of dust coats the oak. The desk has three drawers. The top two are broken and empty. The bottom drawer appears intact but is locked tight.")
        (ACTION DESK-F)>

<OBJECT PATIENT-FILE
        (IN BOTTOM-DRAWER)
        (SYNONYM FILE FOLDER RECORDS RECORD DOCUMENT)
        (ADJECTIVE PATIENT CONFIDENTIAL)
        (DESC "patient file")
        (INTERACTIONS "")
        (FDESC "A confidential patient file lies open in the drawer, its contents disturbing.")
        (LDESC "A file folder marked “Patient 189 - CONFIDENTIAL” lies here.")
        (FLAGS TAKEBIT READBIT)
        (SIZE 3)
        (VALUE 2)
        (ACTION PATIENT-FILE-F)>

<OBJECT BRASS-KEY
        (IN RECEPTION-ROOM)
        (SYNONYM KEY)
        (ADJECTIVE RECEPTION BRASS SMALL DRAWER 3 THREE)
        (DESC "reception key")
        (INTERACTIONS "")
        (FDESC "A small brass key lies among the papers.")
        (LDESC "A small brass key lies here.")
        (FLAGS TAKEBIT INVISIBLE)
        (SIZE 2)
        (TEXT "A small brass key with the number “3” engraved on its head. It's ice cold despite being indoors.")
        (ACTION BRASS-KEY-F)>

<OBJECT RECEPTION-PAPERS
        (IN RECEPTION-ROOM)
        (SYNONYM PAPERS PAPER FORMS INVOICES INVOICE FORM GLINT GLINTS)
        (ADJECTIVE SCATTERED ADMISSION WET GREY DAMP)
        (DESC "scattered papers")
        (INTERACTIONS "")
        (FLAGS NDESCBIT PLURALBIT)
        (ACTION RECEPTION-PAPERS-F)>

<OBJECT OPERATING-TABLE
        (IN OPERATING-THEATER)
        (SYNONYM TABLE)
        (ADJECTIVE OPERATING STAINED METAL BROWN CENTRAL)
        (DESC "operating table")
        (ACTION OPERATING-TABLE-F)
        (FLAGS NDESCBIT SURFACEBIT CONTBIT OPENBIT)
        (TEXT "A dead lamp hangs above the metal trays. The table itself is stained dark brown. Leather restraints dangle from all four corners. Deep gouges mar the metal surface, as if someone struggled violently against the bindings.")>

<OBJECT METAL-CABINET
        (IN OPERATING-THEATER)
        (SYNONYM CABINET CUPBOARD)
        (ADJECTIVE METAL MEDICAL)
        (DESC "metal cabinet")
        (INTERACTIONS "")
        (DESCFCN CABINET-DESC-F)
        (FLAGS CONTBIT)
        (CAPACITY 10)
        (ACTION CABINET-F)>

<OBJECT SCALPEL
        (IN METAL-CABINET)
        (SYNONYM SCALPEL KNIFE BLADE)
        (ADJECTIVE SURGICAL RUSTY SHARP RUSTED STAINED)
        (DESC "rusty scalpel")
        (INTERACTIONS "")
        (LDESC "A rusty surgical scalpel lies here.")
        (FLAGS TAKEBIT WEAPONBIT TOOLBIT)
        (SIZE 3)
        (ACTION SCALPEL-F)>

<OBJECT ETHER-BOTTLE
        (IN METAL-CABINET)
        (SYNONYM BOTTLE ETHER CHLOROFORM FLASK)
        (ADJECTIVE ETHER GLASS FADED)
        (DESC "bottle of ether")
        (INTERACTIONS "")
        (LDESC "A glass bottle labeled “Ether - Handle with Care” stands here.")
        (FLAGS TAKEBIT)
        (SIZE 5)
        (ACTION ETHER-F)>

<OBJECT BED-FRAMES
        (IN PATIENT-WARD)
        (SYNONYM BEDS FRAMES BED FRAME BEDFRAME BEDFRAMES)
        (ADJECTIVE RUSTED BED METAL RUSTY)
        (DESC "bed frames")
        (LDESC "Rusted bed frames line the corridor.")
        (FLAGS NDESCBIT PLURALBIT) ;"The ward's description tells of them and the drawing."
        (ACTION BED-FRAMES-F)
        (TEXT "Dozens of bed frames line the walls. The mattresses have rotted away, leaving only rusted springs and metal frames. Some still have restraint straps attached.")>

<OBJECT CHILD-DRAWING
        (IN PATIENT-WARD)
        (SYNONYM DRAWING PICTURE CRAYON ART SKETCH)
        (ADJECTIVE CHILD CRAYON CHILDS BRITTLE)
        (DESC "child's drawing")
        (INTERACTIONS "")
        (FLAGS NDESCBIT READBIT)
        (ACTION CHILD-DRAWING-F)>

<OBJECT HEAVY-DOOR
        (IN PATIENT-WARD)
        (SYNONYM DOOR)
        (ADJECTIVE HEAVY SEALED LOCKED MORGUE WOODEN SCRATCHED)
        (DESC "heavy door")
        (INTERACTIONS "")
        (LDESC "At the far end, a heavy door sealed with chains blocks further passage. Scratches cover the door's surface, as if made by desperate fingers.")
        (FLAGS NDESCBIT)
        (ACTION HEAVYDOOR-F)>

<OBJECT CHAINS
        (IN PATIENT-WARD)
        (SYNONYM CHAINS CHAIN PADLOCK STRAP FASTENING)
        (ADJECTIVE THICK IRON SLACK LEATHER RESTRAINT RUSTED)
        (DESC "chains")
        (INTERACTIONS "CUT:SCALPEL,COAL-SHOVEL;ATTACK:SCALPEL,COAL-SHOVEL")
        (LDESC "Thick chains secure the heavy door.")
        (FLAGS NDESCBIT PLURALBIT) ;"The ward's description tells of them while they hold."
        (VALUE 4)
        (ACTION CHAINS-F)>

<OBJECT REFRIGERATED-DRAWERS
        (IN MORGUE)
        (SYNONYM DRAWERS DRAWER REFRIGERATOR UNITS UNIT GLOW)
        (ADJECTIVE REFRIGERATED METAL COLD FAINT GREEN)
        (DESC "refrigerated drawers")
        (INTERACTIONS "")
        (FLAGS NDESCBIT CONTBIT PLURALBIT)
        (ACTION DRAWERS-F)>

<OBJECT DISSECTION-TABLE
        (IN MORGUE)
        (SYNONYM TABLE)
        (ADJECTIVE DISSECTION AUTOPSY STEEL STAINLESS METAL)
        (DESC "dissection table")
        (FLAGS NDESCBIT SURFACEBIT CONTBIT OPENBIT)
        (ACTION DISTABLE-F)>

<OBJECT STONE-STEPS
	(IN BASEMENT-STAIRS) (DESC "stone staircase")
	(SYNONYM STAIRCASE STAIRS STEP STEPS STONE) (ADJECTIVE NARROW STONE WET COLD)
	(INTERACTIONS "") (FLAGS NDESCBIT) (ACTION STONE-STEPS-F)
	(TEXT "Water beads on every step. At the bottom it runs in two thin tracks where the wheels of a stretcher wore the stone away.")>

<OBJECT CANVAS-BUNDLE
        (IN DISSECTION-TABLE)
        (SYNONYM BUNDLE CANVAS BODY CORPSE)
        (ADJECTIVE WRAPPED CANVAS HUMAN-SHAPED STAINED ROTTED DISCOLORED)
        (DESC "canvas bundle")
        (INTERACTIONS "")
        (LDESC "A human-shaped bundle wrapped in stained canvas lies here.")
        (FLAGS NDESCBIT TAKEBIT)
        (SIZE 50)
        (ACTION BUNDLE-F)>

<OBJECT STRANGE-SERUM
        (IN REFRIGERATED-DRAWERS)
        (SYNONYM SERUM VIAL LIQUID COMPOUND)
        (ADJECTIVE STRANGE GLOWING GLASS LUMINOUS)
        (DESC "vial of serum")
        (INTERACTIONS "")
        (FDESC "Inside the open refrigerated drawer, a vial of glowing serum gives off an eerie luminescence.")
        (LDESC "A vial of glowing serum lies here, pulsing faintly.")
        (FLAGS TAKEBIT)
        (SIZE 4)
        (ACTION SERUM-F)>

<OBJECT MORDECAI-JOURNAL
        (IN MORGUE)
        (SYNONYM JOURNAL DIARY NOTEBOOK BOOK)
        (ADJECTIVE DOCTOR MORDECAI PERSONAL DOCTORS)
        (DESC "doctor's journal")
        (INTERACTIONS "")
        (LDESC "Dr. Mordecai's journal lies here.")
        (FLAGS NDESCBIT READBIT TAKEBIT)
        (TEXT "The subject showed remarkable resilience. But the serum... it changed something fundamental. Patient 237 died on the table, yet I swear I saw movement hours later. The eyes... the eyes opened. I have made a terrible mistake. God forgive me, I must seal this place.")
        (SIZE 6)
        (ACTION JOURNAL-F)>

<OBJECT PIPES
        (IN BASEMENT-CORRIDOR)
        (SYNONYM PIPES PIPE CEILING)
        (ADJECTIVE RUSTED DRIPPING RUSTY ANCIENT CORRODED METAL BASEMENT BOILER)
        (DESC "rusty pipes")
        (ACTION PIPES-F)
        (FLAGS NDESCBIT PLURALBIT)>

<OBJECT VALVE
        (IN BASEMENT-CORRIDOR)
        (SYNONYM VALVE WHEEL)
        (ADJECTIVE PIPE METAL WHEEL LARGE RUSTY)
        (DESC "metal valve")
        (INTERACTIONS "")
        (FLAGS NDESCBIT TURNBIT)
        (ACTION VALVE-F)>

<OBJECT IRON-BOILER
        (IN BOILER-ROOM)
        (SYNONYM BOILER FURNACE FIREBOX)
        (ADJECTIVE IRON MASSIVE HULKING SOOTY)
        (DESC "iron boiler")
        (INTERACTIONS "BURN:OIL-LANTERN")
        (FLAGS NDESCBIT CONTBIT OPENBIT LIGHTBIT BURNBIT)
        (CAPACITY 20)
        (ACTION BOILER-F)>

<OBJECT COAL-SHOVEL
        (IN IRON-BOILER)
        (SYNONYM SHOVEL SPADE)
        (ADJECTIVE COAL STURDY HEAVY WOODEN)
        (DESC "coal shovel")
        (INTERACTIONS "")
        (LDESC "A sturdy coal shovel lies here.")
        (FLAGS NDESCBIT TAKEBIT TOOLBIT)
        (SIZE 10)
        (ACTION SHOVEL-F)>

<OBJECT COAL-BIN
        (IN BOILER-ROOM)
        (SYNONYM BIN HOPPER)
        (ADJECTIVE COAL IRON)
        (DESC "coal bin")
        (INTERACTIONS "")
        (FLAGS NDESCBIT CONTBIT)
        (ACTION COAL-BIN-F)>

<OBJECT LUMP-OF-COAL
        (IN COAL-BIN)
        (SYNONYM COAL LUMP FUEL)
        (ADJECTIVE BLACK DUSTY SOLID DENSE OLD BITUMINOUS DIRTY DRY FRESH BURNING)
        (DESC "lump of coal")
        (INTERACTIONS "PUT:IRON-BOILER")
        (LDESC "A lump of coal lies here.")
        (FLAGS TAKEBIT)
        (SIZE 4)
        (ACTION COAL-F)>

<OBJECT WORKBENCH
        (IN BOILER-ROOM)
        (SYNONYM BENCH TABLE WORKBENCH TOOLS TOOL)
        (ADJECTIVE WORK ANCIENT RUSTED)
        (DESC "workbench")
        (FLAGS NDESCBIT SURFACEBIT CONTBIT)
        (ACTION WORKBENCH-F)>

<OBJECT FLASHLIGHT
        (IN WORKBENCH)
        (SYNONYM FLASHLIGHT LIGHT TORCH)
        (ADJECTIVE ELECTRIC OLD-FASHIONED HEAVY METAL DEAD)
        (DESC "flashlight")
        (INTERACTIONS "")
        (LDESC "An old-fashioned electric flashlight lies here.")
        (FLAGS TAKEBIT LIGHTBIT)
        (SIZE 5)
        (ACTION FLASHLIGHT-F)>

<OBJECT SHELVES
        (IN STORAGE-ROOM)
        (SYNONYM SHELVES SHELF LINEN)
        (ADJECTIVE SAGGING DAMP)
        (DESC "shelves")
        (INTERACTIONS "")
        (FLAGS NDESCBIT CONTBIT SEARCHBIT SURFACEBIT PLURALBIT)
        (CAPACITY 40)
        (ACTION SHELVES-F)>

<OBJECT MEDICAL-BAG
        (IN SHELVES)
        (SYNONYM BAG SATCHEL)
        (ADJECTIVE MEDICAL LEATHER DOCTOR OLD DOCTORS CRACKED WORN)
        (DESC "medical bag")
        (INTERACTIONS "")
        (FDESC "An old leather medical bag sags on a lower shelf.")
        (LDESC "An old leather medical bag lies here.")
        (FLAGS CONTBIT OPENABLEBIT SEARCHBIT TAKEBIT)
        (CAPACITY 15)
        (SIZE 10)
        (ACTION MEDICAL-BAG-F)>

<OBJECT BANDAGES
        (IN MEDICAL-BAG)
        (SYNONYM BANDAGES BANDAGE CLOTH ROLL)
        (ADJECTIVE YELLOWED CLEAN CLOTH)
        (DESC "roll of bandages")
        (INTERACTIONS "")
        (LDESC "A roll of clean bandages lies here.")
        (FLAGS TAKEBIT)
        (SIZE 3)
        (ACTION BANDAGES-F)>

<OBJECT MORPHINE-VIAL
        (IN MEDICAL-BAG)
        (SYNONYM VIAL MORPHINE)
        (ADJECTIVE MORPHINE GLASS SMALL SEALED)
        (DESC "morphine vial")
        (INTERACTIONS "")
        (LDESC "A sealed glass vial of morphine lies here.")
        (FLAGS TAKEBIT)
        (SIZE 2)
        (ACTION MORPHINE-VIAL-F)>

<OBJECT OIL-LANTERN
        (IN SHELVES)
        (SYNONYM LANTERN LAMP)
        (ADJECTIVE OIL OLD BRASS)
        (DESC "brass oil lantern")
        (INTERACTIONS "")
        (FDESC "An old oil lantern stands on one shelf, its glass furred with dust.")
        (LDESC "An old oil lantern stands here.")
        (FLAGS TAKEBIT LIGHTBIT FLAMEBIT)
        (SIZE 8)
        (ACTION LANTERN-F)>

<OBJECT MEDICAL-RECORDS
        (IN SHELVES)
        (SYNONYM RECORDS FILES PAPERS RECORD FILE SHEAF)
        (ADJECTIVE MEDICAL OLD YELLOWED WATER-DAMAGED)
        (DESC "sheaf of medical records")
        (INTERACTIONS "")
        (FDESC "A sheaf of yellowed medical records has slumped against the shelf's back board.")
        (LDESC "A sheaf of yellowed medical records lies here.")
        (FLAGS TAKEBIT READBIT)
        (TEXT "Most records are water-damaged, but one file remains legible: Patient 189 - Subject shows unusual resistance to sedation. Transferred to isolation ward for observation.")
        (SIZE 4)
        (ACTION RECORDS-F)>

<OBJECT STANDING-WATER
        (IN FLOODING-CHAMBER)
        (SYNONYM WATER FLOOD PUDDLE)
        (ADJECTIVE STANDING ANKLE COLD MURKY FOUL)
        (DESC "standing water")
        (ACTION STANDING-WATER-F)
        (FLAGS NDESCBIT)>

<OBJECT SEALED-DOOR
        (IN FLOODING-CHAMBER)
        (SYNONYM DOOR)
        (ADJECTIVE SEALED EAST METAL CORRODED)
        (DESC "sealed door")
        (INTERACTIONS "")
        (LDESC "A door to the east is sealed shut.")
        (FLAGS NDESCBIT)
        (ACTION SEALED-DOOR-F)>

<OBJECT PORCELAIN-TUBS
        (IN HYDROTHERAPY-ROOM)
        (SYNONYM TUBS TUB BATH BATHS)
        (ADJECTIVE PORCELAIN LARGE STAINED CRACKED)
        (DESC "porcelain tubs")
        (INTERACTIONS "")
        (FLAGS NDESCBIT CONTBIT PLURALBIT)
        (ACTION TUBS-F)>

<OBJECT SOGGY-NOTEBOOK
        (IN PORCELAIN-TUBS)
        (SYNONYM NOTEBOOK BOOK DIARY)
        (ADJECTIVE SOGGY WET WATER-DAMAGED)
        (DESC "soggy notebook")
        (INTERACTIONS "")
        (FDESC "A soggy notebook lies in an inch of rust-brown water in the last tub.")
        (LDESC "A water-damaged notebook lies here.")
        (FLAGS TAKEBIT READBIT)
        (TEXT "...water treatment...hours submerged...screaming stopped...Dr. M approved extended sessions...")
        (SIZE 3)
        (ACTION SOGGY-NOTEBOOK-F)>

<OBJECT MEDICINE-CABINET
        (IN HYDROTHERAPY-ROOM)
        (SYNONYM CABINET CUPBOARD FROST)
        (ADJECTIVE MEDICINE MEDICAL FROSTED FROZEN GLASS THAWED WHITE THICK)
        (DESC "medicine cabinet")
        (INTERACTIONS "")
        (LDESC "A medicine cabinet is sealed beneath a skin of white frost.")
        ;"The room's description follows the frost as it melts."
        (FLAGS CONTBIT OPENABLEBIT NDESCBIT)
        (ACTION MEDICINE-CABINET-F)>

<OBJECT SYRINGE
        (IN MEDICINE-CABINET)
        (SYNONYM SYRINGE NEEDLE)
        (ADJECTIVE MEDICAL GLASS STEEL SHARP EMPTY)
        (DESC "syringe")
        (INTERACTIONS "")
        (FDESC "A glass syringe rests on the shelf of the open medicine cabinet.")
        (LDESC "A glass syringe lies here.")
        (FLAGS TAKEBIT)
        (SIZE 2)
        (VALUE 3)
        (ACTION SYRINGE-F)>

<OBJECT CELL-DOORS
        (IN ISOLATION-WARD)
        (SYNONYM DOORS DOOR CELLS CELL)
        (ADJECTIVE CELL HEAVY BARRED METAL SOLID SMALL)
        (DESC "cell doors")
        (ACTION CELL-DOORS-F)
        (FLAGS NDESCBIT PLURALBIT)>

<OBJECT WALL-SCRATCHES
        (IN ISOLATION-WARD)
        (SYNONYM SCRATCHES MARKS TALLIES WRITING WORDS MESSAGE SCRATCH MARK TALLY)
        (ADJECTIVE WALL SCRATCH DEEP FINGERNAIL)
        (DESC "wall scratches")
        (INTERACTIONS "")
        (LDESC "Thousands of scratch marks cover the cell walls.")
        (FLAGS NDESCBIT PLURALBIT) ;"The ward's description tells of them."
        (VALUE 2)
        (ACTION WALL-SCRATCHES-F)>

<OBJECT SHOCK-CHAIR
        (IN ELECTROSHOCK-THEATER)
        (SYNONYM CHAIR SEAT)
        (ADJECTIVE SHOCK ELECTRIC METAL ELECTROSHOCK COLD BOLTED)
        (DESC "electroshock chair")
        (INTERACTIONS "")
        (ACTION SHOCK-CHAIR-F)
        (FLAGS NDESCBIT)>

<OBJECT SHOCK-MACHINE
        (IN ELECTROSHOCK-THEATER)
        (SYNONYM MACHINE EQUIPMENT ELECTRODES ELECTRODE SWITCH DIAL DIALS)
        (ADJECTIVE SHOCK ELECTRIC ELECTROSHOCK)
        (DESC "shock machine")
        (INTERACTIONS "")
        (ACTION SHOCK-MACHINE-F)
        (FLAGS NDESCBIT)>

<OBJECT PADCELL-DOOR
        (IN ELECTROSHOCK-THEATER)
        (SYNONYM DOOR)
        (ADJECTIVE HEAVY WEST PADDED STEEL REINFORCED WARPED)
        (DESC "heavy door to the padded cell")
        (INTERACTIONS "")
        (ACTION PADCELL-DOOR-F)
        (FLAGS NDESCBIT)>

<OBJECT PADDING
        (IN PADDED-CELL)
        (SYNONYM PADDING WALLS WRITING WORDS MESSAGE WALL)
        (ADJECTIVE ROTTING TORN BLOOD DRIED PADDED DAMP SPONGY MOLDERING WET)
        (DESC "padded walls")
        (INTERACTIONS "")
        (ACTION PADDING-F)
        (FLAGS NDESCBIT PLURALBIT)>

<OBJECT STRAITJACKET
        (IN PADDED-CELL)
        (SYNONYM STRAITJACKET JACKET TAG LABEL)
        (ADJECTIVE STRAIT NAME COLLAR HEAVY CANVAS STAINED ROUGH STIFF)
        (DESC "straitjacket")
        (INTERACTIONS "")
        (FDESC "A straitjacket lies unbuckled on the floor, as if someone had only just slipped out of it.")
        (LDESC "A straitjacket lies here.")
        (FLAGS TAKEBIT READBIT)
        (TEXT "The tag reads a name you know. Your name. Dated 1947. Five years before the sanitarium closed.")
        (SIZE 15)
        (VALUE 1)
        (ACTION STRAITJACKET-F)>

<OBJECT ESCAPE-DOOR
        (IN PADDED-CELL)
        (SYNONYM DOOR)
        (ADJECTIVE EAST HEAVY ELECTROSHOCK THEATER SOLID)
        (DESC "door to the electroshock theater")
        (INTERACTIONS "")
        (ACTION ESCAPE-DOOR-F)
        (FLAGS NDESCBIT)>

<OBJECT ONE-WAY-MIRROR
        (IN OBSERVATION-DECK)
        (SYNONYM MIRROR WINDOW GLASS)
        (ADJECTIVE ONE-WAY)
        (DESC "one-way mirror")
        (ACTION MIRROR-F)
        (FLAGS NDESCBIT)>

<OBJECT OBSERVATION-LOGBOOK
        (IN OBSERVATION-DECK)
        (SYNONYM LOGBOOK LOG BOOK)
        (ADJECTIVE OBSERVATION CLINICAL)
        (DESC "observation logbook")
        (INTERACTIONS "")
        (FDESC "A clinical logbook lies open on the desk, as if the last observer had only stepped out.")
        (LDESC "The observation logbook lies here.")
        (FLAGS TAKEBIT READBIT)
        (TEXT "Session 47 - Patient 189. Subject required maximum voltage. Seizure lasted 4 minutes. Memory loss total. Subject claims to be “someone else” now. Dr. Mordecai pleased with results.")
        (SIZE 7)
        (ACTION OBSERVATION-LOGBOOK-F)>

<OBJECT CORRIDOR-DOOR
        (IN OBSERVATION-DECK)
        (SYNONYM DOOR)
        (ADJECTIVE NORTH ADMINISTRATIVE HEAVY WOODEN WARPED)
        (DESC "door to the administrative wing")
        (INTERACTIONS "")
        (ACTION CORRIDOR-DOOR-F)
        (FLAGS NDESCBIT)>

<OBJECT SCATTERED-PAPERS
        (IN ADMINISTRATIVE-WING)
        (SYNONYM PAPERS FILES DOCUMENTS PAPER FILE DOCUMENT ORDERS SCHEDULES)
        (ADJECTIVE SCATTERED MUNDANE)
        (DESC "scattered papers")
        (ACTION SCATTERED-PAPERS-F)
        (FLAGS NDESCBIT PLURALBIT)>

<OBJECT MASSIVE-DESK
        (IN DIRECTORS-OFFICE)
        (SYNONYM DESK DRAWERS TEXTS BOOKS)
        (ADJECTIVE MASSIVE WOOD WOODEN DARK POLISHED MEDICAL)
        (DESC "massive desk")
        (FLAGS NDESCBIT CONTBIT OPENBIT SURFACEBIT)
        (ACTION MASSIVE-DESK-F)>

<OBJECT HOLLOW-BOOK
        (IN DIRECTORS-OFFICE)
        (SYNONYM BOOK TOME VOLUME LATCH)
        (ADJECTIVE RED LEATHER HOLLOW BLANK BRASS)
        (DESC "red leather book")
        (INTERACTIONS "")
        (LDESC "A red leather book with a blank spine lies here.")
        (FLAGS NDESCBIT CONTBIT OPENABLEBIT TAKEBIT)
        (CAPACITY 5)
        (SIZE 6)
        (ACTION HOLLOW-BOOK-F)>

<OBJECT MORDECAI-PORTRAIT
        (IN DIRECTORS-OFFICE)
        (SYNONYM PORTRAIT PAINTING PICTURE)
        (ADJECTIVE MORDECAI DOCTOR DR HEINRICH)
        (DESC "portrait of Dr. Mordecai")
        (INTERACTIONS "")
        (FLAGS NDESCBIT)
        (ACTION PORTRAIT-F)>

<OBJECT WALL-SAFE
        (IN DIRECTORS-OFFICE)
        (SYNONYM SAFE)
        (ADJECTIVE WALL METAL LOCKED)
        (DESC "wall safe")
        (INTERACTIONS "OPEN:BRASS-KEY,SAFE-KEY,CHAPEL-KEY;UNLOCK:BRASS-KEY,SAFE-KEY,CHAPEL-KEY")
        (FLAGS NDESCBIT CONTBIT INVISIBLE)
        (ACTION WALL-SAFE-F)>

<OBJECT OFFICE-DOOR
        (IN DIRECTORS-OFFICE)
        (SYNONYM DOOR)
        (ADJECTIVE WEST HEAVY OFFICE ADMINISTRATIVE WARPED)
        (DESC "door to the administrative wing")
        (INTERACTIONS "")
        (ACTION OFFICE-DOOR-F)
        (FLAGS NDESCBIT)>

<OBJECT SAFE-KEY
        (IN HOLLOW-BOOK)
        (SYNONYM KEY)
        (ADJECTIVE SAFE NUMBERED SMALL BRASS)
        (DESC "safe key")
        (INTERACTIONS "")
        (LDESC "A small safe key with a numbered tag lies here.")
        (FLAGS TAKEBIT OPENBIT SEARCHBIT)
        (SIZE 1)
        (VALUE 2)
        (ACTION SAFE-KEY-F)>

<OBJECT MORDECAI-NOTES
        (IN WALL-SAFE)
        (SYNONYM NOTES JOURNAL PAPERS NOTE PACKET)
        (ADJECTIVE PRIVATE MORDECAI DR DOCTOR DOCTORS)
        (DESC "packet of private notes")
        (INTERACTIONS "")
        (FDESC "Private notes in a tight, obsessive hand detail experiments that should never have been conducted.")
        (LDESC "Dr. Mordecai's private notes lie here.")
        (FLAGS TAKEBIT READBIT)
        (TEXT "The experiment succeeded beyond expectations. Patient 189 has transcended death itself. But the cost... the screaming never stops. I hear it in my sleep. The chapel must remain locked. What I've created must never escape.")
        (SIZE 5)
        (ACTION MORDECAI-NOTES-F)>

<OBJECT CHAPEL-KEY
        (IN WALL-SAFE)
        (SYNONYM KEY)
        (ADJECTIVE CHAPEL IRON LARGE HEAVY COLD)
        (DESC "chapel key")
        (INTERACTIONS "")
        (FDESC "A heavy iron key lies among the safe's contents, its head carved with a cross.")
        (LDESC "A large iron key engraved with a cross lies here.")
        (FLAGS TAKEBIT)
        (SIZE 6)
        (VALUE 3)
        (ACTION CHAPEL-KEY-F)>

<OBJECT LOCKERS
        (IN STAFF-QUARTERS)
        (SYNONYM LOCKERS LOCKER BANK)
        (ADJECTIVE METAL DENTED CROOKED)
        (DESC "bank of lockers")
        (INTERACTIONS "")
        (FLAGS NDESCBIT CONTBIT)
        (ACTION LOCKERS-F)>

<OBJECT PHOTOGRAPH
        (IN LOCKERS)
        (SYNONYM PHOTOGRAPH PHOTO PICTURE)
        (ADJECTIVE OLD FADED STAFF)
        (DESC "photograph")
        (INTERACTIONS "")
        (FDESC "A photograph is tucked behind a nurse's uniform in one of the lockers.")
        (LDESC "A faded photograph of the sanitarium staff lies here.")
        (FLAGS TAKEBIT)
        (SIZE 1)
        (ACTION PHOTOGRAPH-F)>

<OBJECT SERVING-COUNTER
        (IN CAFETERIA)
        (SYNONYM COUNTER DUST MENUS MENU KITCHEN)
        (ADJECTIVE SERVING DUSTY)
        (DESC "serving counter")
        (FLAGS NDESCBIT SURFACEBIT CONTBIT OPENBIT)
        (ACTION COUNTER-F)>

<OBJECT BELL
        (IN SERVING-COUNTER)
        (SYNONYM BELL CHIME BUTTON)
        (ADJECTIVE SERVICE COUNTER SMALL BRASS)
        (DESC "service bell")
        (INTERACTIONS "")
        (FDESC "A small brass service bell sits on the counter.")
        (LDESC "A small brass service bell sits here.")
        (FLAGS TAKEBIT OPENBIT SEARCHBIT)
        (SIZE 2)
        (ACTION BELL-F)>

<OBJECT GARDEN-DOOR
        (IN CAFETERIA)
        (SYNONYM DOOR PANE)
        (ADJECTIVE NORTH WOODEN GARDEN WARPED CRACKED)
        (DESC "door to the garden")
        (INTERACTIONS "")
        (ACTION GARDEN-DOOR-F)
        (FLAGS NDESCBIT)>

<OBJECT DEAD-GARDEN
        (IN OVERGROWN-GARDEN)
        (SYNONYM GARDEN WEEDS PLANTS ROSES ROSE)
        (ADJECTIVE DEAD OVERGROWN)
        (DESC "dead garden")
        (INTERACTIONS "DIG:COAL-SHOVEL")
        (ACTION DEAD-GARDEN-F)
        (FLAGS NDESCBIT)>

<OBJECT CHAPEL-DOOR
        (IN OVERGROWN-GARDEN)
        (SYNONYM DOOR LOCK INSCRIPTION WORDS)
        (ADJECTIVE CHAPEL HEAVY LOCKED OAK WOODEN IRON CARVED)
      (DESC "chapel door")
      (INTERACTIONS "OPEN:BRASS-KEY,SAFE-KEY,CHAPEL-KEY;UNLOCK:BRASS-KEY,SAFE-KEY,CHAPEL-KEY")
      (FLAGS NDESCBIT)
      (ACTION CHAPEL-DOOR-F)>

<OBJECT PEWS
        (IN CHAPEL)
        (SYNONYM PEWS BENCHES PEW BENCH)
        (ADJECTIVE WOODEN ANCIENT ROTTING COLD)
        (DESC "wooden pews")
        (INTERACTIONS "")
        (ACTION PEWS-F)
        (FLAGS NDESCBIT PLURALBIT)>

<OBJECT GREEN-CANDLES
        (IN CHAPEL)
        (SYNONYM CANDLES FLAMES CANDLE FLAME)
        (ADJECTIVE GREEN UNNATURAL WAX COLD DARK)
      (DESC "green candles")
      (INTERACTIONS "")
      (FLAGS NDESCBIT PLURALBIT)
      (ACTION GREEN-CANDLES-F)>

<OBJECT WOODEN-BOX
        (IN CHAPEL)
        (SYNONYM BOX CASE CASKET CLASP)
        (ADJECTIVE WOODEN LOCKED SMALL CARVED IRON RUSTED)
        (DESC "wooden box")
        (INTERACTIONS "OPEN:SCALPEL,COAL-SHOVEL,BRASS-KEY,SAFE-KEY,CHAPEL-KEY")
        (LDESC "A small wooden box carved with disturbing symbols sits here.")
        (FLAGS NDESCBIT CONTBIT OPENABLEBIT TAKEBIT)
        (CAPACITY 10)
        (SIZE 8)
        (ACTION WOODEN-BOX-F)>

<OBJECT ANCIENT-RELIC
        (IN WOODEN-BOX)
        (SYNONYM RELIC CROSS SILVER AMULET)
        (ADJECTIVE ANCIENT SILVER TARNISHED BLACK WARM)
        (DESC "silver relic")
        (INTERACTIONS "GIVE:PATIENT-189")
        (FDESC "Inside the wooden box, an ancient silver cross gleams with writhing symbols etched into its surface.")
        (LDESC "An ancient silver cross lies here, symbols writhing across its surface.")
        (FLAGS OPENBIT SEARCHBIT TAKEBIT)
        (SIZE 4)
        (VALUE 3)
        (ACTION ANCIENT-RELIC-F)>

<OBJECT PATIENT-189
        (IN CHAPEL)
        (SYNONYM PATIENT FIGURE BEING MONSTER SOUL GHOST SOMETHING)
        (ADJECTIVE PATIENT 189 PALE STILL GREEN)
        (DESC "Patient 189")
        (INTERACTIONS "INJECT:SYRINGE;GIVE:ANCIENT-RELIC,STRANGE-SERUM,SYRINGE,STRAITJACKET,PHOTOGRAPH,PATIENT-FILE;ATTACK:SCALPEL,COAL-SHOVEL;TELL:MORDECAI-JOURNAL,MORDECAI-NOTES,PHOTOGRAPH,STRANGE-SERUM,OBSERVATION-LOGBOOK,STRAITJACKET,PATIENT-FILE,PATIENT-LEDGER,MEDICAL-RECORDS,SOGGY-NOTEBOOK,CHAPEL-KEY,WOODEN-BOX")
        (FLAGS ACTORBIT NDESCBIT) ;"The chapel and the garden tell where it stands."
        (ACTION PATIENT-189-F)>

; === FORMER PSEUDO OBJECTS (replaced with real objects) ===

<OBJECT NEST
        (IN RECEPTION-ROOM)
        (SYNONYM NEST)
        (ADJECTIVE BIRD BIRDS OLD ABANDONED)
        (DESC "bird's nest")
        (FLAGS NDESCBIT)
        (ACTION NEST-PSEUDO)>

<OBJECT ASHES
        (IN RECEPTION-ROOM)
        (SYNONYM ASHES ASH SOOT CHAR)
        (ADJECTIVE COLD GREY GRAY)
        (DESC "ashes")
        (FLAGS NDESCBIT PLURALBIT)
        (ACTION ASHES-PSEUDO)>

<OBJECT INSTRUMENTS
        (IN OPERATING-THEATER)
        (SYNONYM INSTRUMENTS INSTRUMENT FORCEPS CLAMPS CLAMP)
        (ADJECTIVE MEDICAL SURGICAL RUSTY RUSTED CUTTING)
        (DESC "instruments")
        (FLAGS NDESCBIT PLURALBIT)
        (ACTION INSTRUMENTS-PSEUDO)>

<OBJECT TRAYS
        (IN OPERATING-THEATER)
        (SYNONYM TRAYS TRAY)
        (ADJECTIVE METAL INSTRUMENT COLD)
        (DESC "trays")
        (FLAGS NDESCBIT PLURALBIT)
        (ACTION TRAYS-PSEUDO)>

<OBJECT THEATER-BENCHES
        (IN OPERATING-THEATER)
        (SYNONYM BENCHES BENCH TIERS TIER)
        (ADJECTIVE WOODEN THEATER OPERATING DARK)
        (DESC "wooden benches")
        (FLAGS NDESCBIT PLURALBIT)
        (ACTION BENCHES-PSEUDO)>

<OBJECT COAL-DUST
        (IN BOILER-ROOM)
        (SYNONYM DUST SOOT)
        (ADJECTIVE COAL BLACK FINE DAMP)
        (DESC "coal dust")
        (INTERACTIONS "")
        (FLAGS NDESCBIT)
        (ACTION COAL-DUST-F)>

<OBJECT GARDEN-BENCHES
        (IN OVERGROWN-GARDEN)
        (SYNONYM BENCHES BENCH FOUNTAIN)
        (ADJECTIVE BROKEN STONE IVY MOSSY CRUMBLING)
        (DESC "stone benches")
        (FLAGS NDESCBIT PLURALBIT)
        (ACTION GARDEN-BENCHES-F)>

<OBJECT GRAND-STAIRCASE
        (IN SANITARIUM-ENTRANCE)
        (SYNONYM STAIRCASE STAIRS STAIRWAY STEPS LANDING BANISTER)
        (ADJECTIVE GRAND BROKEN COLLAPSED)
        (DESC "grand staircase")
        (FLAGS NDESCBIT)
        (ACTION GRAND-STAIRCASE-F)>

<OBJECT WALLPAPER
        (IN SANITARIUM-ENTRANCE)
        (SYNONYM WALLPAPER PAPER PLASTER MOULD MOLD)
        (ADJECTIVE VICTORIAN PEELING VICTORIAN-ERA WARPED MOLDY)
        (DESC "wallpaper")
        (INTERACTIONS "")
        (FLAGS NDESCBIT)
        (ACTION WALLPAPER-F)>

; === LOCAL-GLOBALS (objects visible from multiple rooms) ===

<OBJECT SANITARIUM-BUILDING
    (IN LOCAL-GLOBALS)
    (SYNONYM BUILDING SANITARIUM STRUCTURE FACADE WINDOW WINDOWS PANES)
    (ADJECTIVE ABANDONED VICTORIAN SANITARIUM BLACKWOOD CRUMBLING BLACK)
    (DESC "sanitarium building")
    (FLAGS NDESCBIT)
    (ACTION SANITARIUM-BUILDING-F)>

<OBJECT DEAD-OAK-TREE
    (IN LOCAL-GLOBALS)
    (SYNONYM TREE OAK CROWS)
    (ADJECTIVE DEAD BARE MASSIVE LEAFLESS GREY GRAY OAK)
    (DESC "dead oak tree")
    (FLAGS NDESCBIT CLIMBBIT)
    (ACTION DEAD-OAK-TREE-F)>

<OBJECT FILING-CABINETS
    (IN LOCAL-GLOBALS)
    (SYNONYM CABINETS CABINET DRAWERS FILES FILE DRAWER)
    (ADJECTIVE FILING FILE OVERTURNED EMPTY BENT RECEPTION)
    (DESC "filing cabinets")
    (INTERACTIONS "")
    (FLAGS NDESCBIT PLURALBIT)
    (ACTION FILING-CABINETS-F)>

; === TOPIC OBJECTS (ASK/TELL vocabulary for NPC interaction) ===

<OBJECT TOPIC-MORDECAI
    (IN LOCAL-GLOBALS)
    (SYNONYM MORDECAI DIRECTOR DOCTOR)
    (ADJECTIVE HEINRICH DR DOCTOR)
    (DESC "Dr. Mordecai")
    (FLAGS NDESCBIT)>

<OBJECT TOPIC-TREATMENT
    (IN LOCAL-GLOBALS)
    (SYNONYM TREATMENT EXPERIMENT SERUM THERAPY)
    (ADJECTIVE EXPERIMENTAL)
    (DESC "treatment")
    (FLAGS NDESCBIT)>

<OBJECT TOPIC-IDENTITY
    (IN LOCAL-GLOBALS)
    (SYNONYM NAME IDENTITY MEMORY PAST)
    (DESC "identity")
    (FLAGS NDESCBIT)>

<OBJECT TOPIC-SANITARIUM
    (IN LOCAL-GLOBALS)
    (SYNONYM SANITARIUM HOSPITAL BLACKWOOD)
    (ADJECTIVE BLACKWOOD)
    (DESC "sanitarium")
    (FLAGS NDESCBIT)>

<OBJECT TOPIC-CHAPEL
    (IN LOCAL-GLOBALS)
    (SYNONYM CHAPEL ALTAR)
    (DESC "chapel")
    (FLAGS NDESCBIT) (TEXT "Green wax has pooled in the cuts on the altar stone. From here you can trace the same marks back along the pews.") (ACTION TOPIC-CHAPEL-F)>

<OBJECT BOTTOM-DRAWER
        (IN OAK-DESK)
        (SYNONYM DRAWER)
        (ADJECTIVE BOTTOM STURDY LOCKED NUMBERED)
        (DESC "bottom drawer")
        (INTERACTIONS "OPEN:BRASS-KEY,SAFE-KEY,CHAPEL-KEY;UNLOCK:BRASS-KEY,SAFE-KEY,CHAPEL-KEY")
        (LDESC "The desk has a sturdy bottom drawer.")
        (FLAGS CONTBIT OPENABLEBIT SEARCHBIT NDESCBIT)
        (CAPACITY 10)
        (ACTION DRAWER-F)>

<OBJECT PATIENT-LEDGER
        (IN BOTTOM-DRAWER)
        (SYNONYM LEDGER BOOK RECORDS)
        (ADJECTIVE PATIENT LEATHER LEATHER-BOUND SWOLLEN DAMP)
        (DESC "patient ledger")
        (INTERACTIONS "")
        (FDESC "A leather-bound ledger, swollen with damp, lies beside it in the drawer.")
        (LDESC "A leather-bound ledger, swollen with damp, lies closed.")
        (FLAGS READBIT TAKEBIT)
        (TEXT "Patient 237 - Treatment discontinued. Subject expired during procedure. Dr. Mordecai.")
        (SIZE 8)
        (ACTION LEDGER-F)>

<OBJECT GRAVEL-PATH (IN SANITARIUM-GATE) (DESC "gravel path")
    (SYNONYM PATH GRAVEL TRACK) (ADJECTIVE GRAVEL NARROW)
    (ACTION GRAVEL-PATH-F) (FLAGS NDESCBIT) (INTERACTIONS "")
    (TEXT "Two broad wheel ruts run between the gates. A strip of grass grows down the middle.")>

<OBJECT BROKEN-GLASS (IN PATIENT-WARD) (DESC "broken glass")
    (SYNONYM GLASS SHARDS SPLINTERS) (ADJECTIVE BROKEN WINDOW)
    (ACTION BROKEN-GLASS-F) (FLAGS NDESCBIT) (INTERACTIONS "")
    (TEXT "The pieces are green at the edges. Under one bed a whole pane still holds the wire mesh that kept it from falling apart.")>

<OBJECT BASEMENT-SMOKE (IN BASEMENT-CORRIDOR) (DESC "coal smoke")
    (SYNONYM SMOKE SOOT) (ADJECTIVE COAL BLACK)
    (ACTION BASEMENT-SMOKE-F) (FLAGS NDESCBIT) (INTERACTIONS "")
    (TEXT "A black streak on the ceiling leads back to the boiler room. The air smells strongest at that doorway.")>

<OBJECT PIPE-DRIP (IN BASEMENT-CORRIDOR) (DESC "dripping water")
    (SYNONYM WATER DRIPS DRIP PUDDLE) (ADJECTIVE DRIPPING COLD)
    (ACTION PIPE-DRIP-F) (FLAGS NDESCBIT) (INTERACTIONS "")
    (TEXT "Each drop runs north along a shallow groove in the floor. You can hear it fall into deeper water.")>

<OBJECT RUBBER-HOSES (IN HYDROTHERAPY-ROOM) (DESC "rubber hoses")
    (SYNONYM HOSES HOSE) (ADJECTIVE RUBBER CRACKED)
    (ACTION RUBBER-HOSES-F) (FLAGS NDESCBIT PLURALBIT) (INTERACTIONS "")
    (TEXT "A nozzle hangs just above each tub. The rubber cracks into little squares where it bends over the rim.")>

<OBJECT SCORCHED-CONCRETE (IN ELECTROSHOCK-THEATER) (DESC "scorched concrete")
    (SYNONYM CONCRETE SCORCH MARKS) (ADJECTIVE SCORCHED BLACK)
    (ACTION SCORCHED-CONCRETE-F) (FLAGS NDESCBIT) (INTERACTIONS "")
    (TEXT "A black fan spreads across the concrete behind the machine. Its narrow end is just below the cable socket.")>

<OBJECT OBSERVATION-DESK (IN OBSERVATION-DECK) (DESC "observation desk")
    (SYNONYM DESK) (ADJECTIVE OBSERVATION NARROW)
    (ACTION OBSERVATION-DESK-F) (FLAGS NDESCBIT) (INTERACTIONS "")
    (TEXT "The front edge is worn smooth just where an observer could lean on it and write without taking their eyes off the glass.")>

<OBJECT STAFF-UNIFORM (IN LOCKERS) (DESC "uniform")
    (SYNONYM UNIFORM CLOTHING CLOTHES DRESS) (ADJECTIVE NURSE ROTTED STARCHED)
    (SIZE 0) (FLAGS NDESCBIT) (INTERACTIONS "") (ACTION STAFF-UNIFORM-F)>

<OBJECT STAFF-BEDS (IN STAFF-QUARTERS) (DESC "staff beds")
    (SYNONYM BEDS BED COTS SPRINGS) (ADJECTIVE STAFF NARROW IRON)
    (ACTION STAFF-BEDS-F) (FLAGS NDESCBIT PLURALBIT) (INTERACTIONS "")
    (TEXT "Each bed has a hook for a uniform at its foot. The hooks face the door, ready for a call in the night.")>

<OBJECT CORRIDOR-STEPS (IN BASEMENT-CORRIDOR) (DESC "stone stairs")
    (SYNONYM STAIRS STEPS STAIRCASE) (ADJECTIVE STONE WORN)
    (FLAGS NDESCBIT PLURALBIT) (INTERACTIONS "")
    (TEXT "The lowest step has two worn grooves, a stretcher wheel’s width apart.")
    (ACTION CORRIDOR-STEPS-F)>

<OBJECT THEATER-STEPS (IN ELECTROSHOCK-THEATER) (DESC "stone stairs")
    (SYNONYM STAIRS STEPS STAIRCASE) (ADJECTIVE STONE WORN)
    (FLAGS NDESCBIT PLURALBIT) (INTERACTIONS "")
    (TEXT "The first few steps climb beside the chair. Higher up they turn behind the observation glass.")
    (ACTION THEATER-STEPS-F)>

<OBJECT DECK-STEPS (IN OBSERVATION-DECK) (DESC "stone stairs")
    (SYNONYM STAIRS STEPS STAIRCASE) (ADJECTIVE STONE WORN)
    (FLAGS NDESCBIT PLURALBIT) (INTERACTIONS "")
    (TEXT "The stairs take a sharp turn behind the mirror. From below, a patient could hear footsteps without seeing who was coming.")
    (ACTION DECK-STEPS-F)>

<OBJECT DETAIL-WHEEL-RUTS (IN SANITARIUM-GATE) (DESC "wheel ruts")
    (SYNONYM RUTS RUT TRACKS) (ADJECTIVE WHEEL BROAD)
    (FLAGS NDESCBIT PLURALBIT) (INTERACTIONS "")
    (TEXT "The grooves run in pairs. They deepen just inside the gates, as if the driver always braked in the same place.")>

<OBJECT DETAIL-WIRE-MESH (IN PATIENT-WARD) (DESC "wire mesh")
    (SYNONYM MESH WIRE GRID) (ADJECTIVE WIRE GREEN)
    (FLAGS NDESCBIT) (INTERACTIONS "")
    (TEXT "Every little square has trapped a chip of glass. Even where the pane has bowed, the wire keeps the chips in their rows.")>

<OBJECT DETAIL-DEAD-LAMP (IN OPERATING-THEATER) (DESC "dead lamp")
    (SYNONYM LAMP BULB REFLECTOR) (ADJECTIVE DEAD OVERHEAD)
    (ACTION DEAD-LAMP-F) (FLAGS NDESCBIT) (INTERACTIONS "")
    (TEXT "The silvering has peeled off the reflector in scales. Even a good bulb would throw a patchy light.")>

<OBJECT DETAIL-NOZZLE (IN HYDROTHERAPY-ROOM) (DESC "nozzle")
    (SYNONYM NOZZLE SPRAY) (ADJECTIVE RUBBER CRACKED)
    (FLAGS NDESCBIT) (INTERACTIONS "")
    (TEXT "White scale plugs all but one of the holes. The clear hole points straight down at the waterline.")>

<OBJECT DETAIL-MEMO (IN ADMINISTRATIVE-WING) (DESC "memo")
    (SYNONYM MEMO MEMORANDUM) (ADJECTIVE STAFF TYPED)
    (FLAGS NDESCBIT READBIT) (INTERACTIONS "")
    (TEXT "The typist went back over the word NOT. The O has punched a little hole right through the paper.")
    (ACTION DETAIL-MEMO-F)>

<OBJECT DETAIL-NAMEPLATE (IN DIRECTORS-OFFICE) (DESC "nameplate")
    (SYNONYM NAMEPLATE PLATE) (ADJECTIVE BRASS PORTRAIT)
    (FLAGS NDESCBIT READBIT) (INTERACTIONS "")
    (TEXT "The closing date is cut deeper than the rest. It was added after the plate had already been screwed to the frame.")
    (ACTION DETAIL-NAMEPLATE-F)>

<OBJECT DETAIL-BRASS-DOME (IN BELL) (DESC "brass dome")
    (SYNONYM DOME RIM) (ADJECTIVE BRASS BELL)
    (SIZE 0) (FLAGS NDESCBIT) (INTERACTIONS "")
    (TEXT "A bright nick on the inside rim shows where the hammer hits. The rest of the brass has gone green.")
    (ACTION DETAIL-BRASS-DOME-F)>

<OBJECT DETAIL-CARVED-SYMBOLS (IN CHAPEL) (DESC "carved symbols")
    (SYNONYM SYMBOLS CUTS MARKS SYMBOL) (ADJECTIVE CARVED STRANGE)
    (FLAGS NDESCBIT READBIT PLURALBIT) (INTERACTIONS "")
    (TEXT "The same hooked stroke begins each mark. On the pews you can see it clearly where a sleeve has rubbed the wood smooth.")
    (ACTION DETAIL-CARVED-SYMBOLS-F)>

<OBJECT BOOK-HOLLOW (IN HOLLOW-BOOK) (DESC "glued pages")
    (SYNONYM PAGES HOLLOW OUTLINE) (ADJECTIVE GLUED RUSTY)
    (SIZE 0) (FLAGS NDESCBIT PLURALBIT) (INTERACTIONS "")
    (ACTION BOOK-HOLLOW-F)>

<OBJECT CROSS-LINING (IN WOODEN-BOX) (DESC "box lining")
    (SYNONYM LINING HOLLOW PRINT) (ADJECTIVE BOX CROSS-SHAPED)
    (SIZE 0) (FLAGS NDESCBIT) (INTERACTIONS "")
    (ACTION CROSS-LINING-F)>

<OBJECT KEY-TAG (IN SAFE-KEY) (DESC "numbered tag")
    (SYNONYM TAG NUMBER LABEL) (ADJECTIVE NUMBERED STAMPED)
    (SIZE 0) (FLAGS NDESCBIT READBIT) (INTERACTIONS "")
    (TEXT "The number is stamped straight through the thin tin. On the back you can feel the little raised curves of the two zeroes.")
    (ACTION KEY-TAG-F)>

<OBJECT CROSS-ETCHING (IN ANCIENT-RELIC) (DESC "silver etching")
    (SYNONYM ETCHING LINES) (ADJECTIVE SILVER ETCHED)
    (SIZE 0) (FLAGS NDESCBIT READBIT) (INTERACTIONS "")
    (TEXT "Tilt the cross and one line shines while its neighbour turns black. The pattern seems to move even when your hand is steady.")
    (ACTION CROSS-ETCHING-F)>

; === SCENERY NAMED BY THE ROOM DESCRIPTIONS ===

<OBJECT HALL-DUST (IN SANITARIUM-ENTRANCE) (DESC "plaster dust")
    (SYNONYM DUST FOOTPRINTS FOOTPRINT PRINTS) (ADJECTIVE PLASTER WHITE)
    (FLAGS NDESCBIT) (ACTION HALL-DUST-F)>

<OBJECT RECEPTION-FIREPLACE (IN RECEPTION-ROOM) (DESC "fireplace")
    (SYNONYM FIREPLACE GRATE HEARTH CHIMNEY) (ADJECTIVE COLD IRON)
    (FLAGS NDESCBIT) (ACTION RECEPTION-FIREPLACE-F)>

<OBJECT THEATER-EXIT (IN OPERATING-THEATER) (DESC "sagging door")
    (SYNONYM DOOR) (ADJECTIVE SAGGING SOUTH JAMMED)
    (FLAGS NDESCBIT) (ACTION THEATER-EXIT-F)>

<OBJECT WARD-CURTAINS (IN PATIENT-WARD) (DESC "tattered curtains")
    (SYNONYM CURTAINS CURTAIN SCREENS) (ADJECTIVE TATTERED GREY)
    (FLAGS NDESCBIT PLURALBIT) (ACTION WARD-CURTAINS-F)>

<OBJECT HYDRO-TILES (IN HYDROTHERAPY-ROOM) (DESC "white tiles")
    (SYNONYM TILES TILE) (ADJECTIVE WHITE CRACKED)
    (FLAGS NDESCBIT PLURALBIT) (ACTION HYDRO-TILES-F)>

<OBJECT OFFICE-RUG (IN DIRECTORS-OFFICE) (DESC "worn rug")
    (SYNONYM RUG CARPET) (ADJECTIVE WORN PERSIAN)
    (FLAGS NDESCBIT) (ACTION OFFICE-RUG-F)>

<OBJECT CAFETERIA-FURNITURE (IN CAFETERIA) (DESC "stacked chairs")
    (SYNONYM CHAIRS CHAIR TABLES TABLE) (ADJECTIVE STACKED CAFETERIA)
    (FLAGS NDESCBIT PLURALBIT) (ACTION CAFETERIA-FURNITURE-F)>

<OBJECT GARDEN-PATH (IN OVERGROWN-GARDEN) (DESC "stone path")
    (SYNONYM PATH PATHS FLAGSTONES) (ADJECTIVE STONE GARDEN)
    (FLAGS NDESCBIT) (ACTION GARDEN-PATH-F)>

<OBJECT CHAPEL-EXTERIOR (IN OVERGROWN-GARDEN) (DESC "stone chapel")
    (SYNONYM CHAPEL) (ADJECTIVE SMALL STONE)
    (FLAGS NDESCBIT) (ACTION CHAPEL-EXTERIOR-F)>
