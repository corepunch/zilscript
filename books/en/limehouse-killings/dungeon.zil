<DIRECTIONS NORTH EAST WEST SOUTH NE NW SE SW UP DOWN IN OUT>
<VERSION ZIP>
<CONSTANT RELEASEID 1>

; === GLOBAL FLAGS ===

<GLOBAL GAME-WON <>>
<GLOBAL GAME-LOST <>>
<GLOBAL GAME-ENDED <>>
<GLOBAL STUDY-UNLOCKED <>>
<GLOBAL SECRET-PASSAGE-FOUND <>>
<GLOBAL SECRET-PASSAGE-OPEN <>>
<GLOBAL CIPHER-SOLVED <>>
<GLOBAL CIPHER-STAGE 0>
<GLOBAL POISON-IDENTIFIED <>>
<GLOBAL KILLER-ACCUSED <>>
<GLOBAL CORRECT-ACCUSATION <>>
<GLOBAL INSPECTOR-PRESENT <>>
<GLOBAL EVIDENCE-FOUND 0>
<GLOBAL SUSPECTS-INTERVIEWED 0>
<GLOBAL HUDSON-INTERVIEWED <>>
<GLOBAL LADY-INTERVIEWED <>>
<GLOBAL MORIARTY-INTERVIEWED <>>
<GLOBAL HUDSON-KEY-GIVEN <>>
<GLOBAL HUDSON-MOTIVE-REVEALED <>>
<GLOBAL LADY-ALIBI-CLAIMED <>>
<GLOBAL MORIARTY-POISON-KNOWN <>>
<GLOBAL DEAD-LETTER-FOUND <>>
<GLOBAL KNIFE-FOUND <>>
<GLOBAL LOCKED-BOX-OPENED <>>
<GLOBAL POISON-BOTTLE-FOUND <>>
<GLOBAL SECRET-LEDGER-FOUND <>>
<GLOBAL BANK-STATEMENT-FOUND <>>
<GLOBAL PLAYER-HEALTH 3>
<GLOBAL CASE-ACT 1>
<GLOBAL HUDSON-CONFRONTED <>>
<GLOBAL LADY-CONFRONTED <>>
<GLOBAL MORIARTY-CONFRONTED <>>
<GLOBAL BOX-CLUE-SEEN <>>
<GLOBAL LETTER-PRESENTED <>>
<GLOBAL POISON-PRESENTED <>>
<GLOBAL MOTIVE-PRESENTED <>>
<GLOBAL FOOTPRINT-DETAIL-FOUND <>>
<GLOBAL CABINET-CLUE-SEEN <>>
<GLOBAL WRONG-ATTEMPTS 0>
<GLOBAL BELL-WIRE-PULLED <>>
<GLOBAL SCORE-MAX 65>
<GLOBAL RANKINGS
    <LTABLE "Bystander"
         "Witness"
         "Investigator"
         "Detective"
         "Master Detective">>

; === ROOMS ===

<ROOM ASHWORTH-MANOR-GATE
      (IN ROOMS)
      (DESC "Ashworth Manor Gate")
      (ACTION GATE-FCN)
      (NORTH TO ASHWORTH-ENTRANCE-HALL)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL FOG GATES PATH)>

<ROOM ASHWORTH-ENTRANCE-HALL
      (IN ROOMS)
      (DESC "Ashworth Manor Entrance Hall")
      (ACTION ENTRANCE-HALL-FCN)
      (NORTH TO STUDY IF STUDY-DOOR IS OPEN ELSE "The study door is closed.")
      (SOUTH TO ASHWORTH-MANOR-GATE)
      (EAST TO LIBRARY)
      (WEST TO DINING-ROOM)
      (DOWN TO KITCHEN)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL CHANDELIER PORTRAITS RUG STUDY-DOOR BELL-WIRE FOG
              CASE-TOPIC EXPERIMENTS-TOPIC POISON-TOPIC)>

<ROOM STUDY
      (IN ROOMS)
      (DESC "Study")
      (ACTION STUDY-FCN)
      (SOUTH TO ASHWORTH-ENTRANCE-HALL IF STUDY-DOOR IS OPEN ELSE "The study door is closed.")
      (SW TO GARDEN IF WINDOW IS OPEN ELSE "The window is closed.")
	  (DOWN TO SECRET-PASSAGE IF CIPHER-SOLVED)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL DESK FIREPLACE WINDOW CHALK-OUTLINE STUDY-DOOR FOG
              MORIARTY-TOPIC HUDSON-NAME ASHWORTH-NAME)>

<ROOM LIBRARY
      (IN ROOMS)
      (DESC "Library")
      (ACTION LIBRARY-FCN)
      (WEST TO ASHWORTH-ENTRANCE-HALL)
      (EAST TO SECRET-PASSAGE IF CIPHER-SOLVED)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL BOOKSHELF READING-DESK FIREPLACE COLORED-MARKERS FOG
              EXPERIMENTS-TOPIC POISON-TOPIC)>

<ROOM DINING-ROOM
      (IN ROOMS)
      (DESC "Dining Room")
      (ACTION DINING-ROOM-FCN)
      (EAST TO ASHWORTH-ENTRANCE-HALL)
      (NORTH TO PANTRY)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL TABLE PORTRAITS WINE-CABINET FOG
              MARRIAGE-TOPIC ALIBI-TOPIC CASE-TOPIC)>

<ROOM KITCHEN
      (IN ROOMS)
      (DESC "Kitchen")
      (ACTION KITCHEN-FCN)
      (UP TO ASHWORTH-ENTRANCE-HALL)
      (WEST TO GARDEN)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL POTS HEARTH SERVANT-BELL DRAWER KETTLE FOG)>

<ROOM GARDEN
      (IN ROOMS)
      (DESC "Garden")
      (ACTION GARDEN-FCN)
      (EAST TO KITCHEN)
      (NORTH TO GREENHOUSE)
      (SOUTH TO SERVANTS-QUARTERS)
	  (NE TO STUDY IF WINDOW IS OPEN ELSE "The study window is closed.")
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL FOUNTAIN HEDGES FOG)>

<ROOM GREENHOUSE
      (IN ROOMS)
      (DESC "Greenhouse")
      (ACTION GREENHOUSE-FCN)
      (SOUTH TO GARDEN)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL PLANTS LABELS BENCH FOG)>

<ROOM SERVANTS-QUARTERS
      (IN ROOMS)
      (DESC "Servants' Quarters")
      (ACTION SERVANTS-QUARTERS-FCN)
      (NORTH TO GARDEN)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL BEDS TRUNK UNIFORMS FOG
              MASTER-TOPIC ALIBI-TOPIC KEY-TOPIC MORIARTY-TOPIC)>

<ROOM SECRET-PASSAGE
      (IN ROOMS)
      (DESC "Secret Passage")
      (ACTION SECRET-PASSAGE-FCN)
      (WEST TO LIBRARY)
      (UP TO STUDY)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL STONE-WALLS COBWEBS DUST FOG)>

<ROOM PANTRY
      (IN ROOMS)
      (DESC "Pantry")
      (ACTION PANTRY-FCN)
      (SOUTH TO DINING-ROOM)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL SHELVES FOG)>

; === OBJECTS ===

<OBJECT TELEGRAM
      (INTERACTIONS "READ:MAGNIFYING-GLASS;PUT:LOCKED-BOX,LEATHER-ROLL,DRAWER,TRUNK;SHOW:MR-HUDSON,LADY-ASHWORTH,DR-MORIARTY,INSPECTOR;GIVE:MR-HUDSON,LADY-ASHWORTH,DR-MORIARTY")
      (IN ASHWORTH-MANOR-GATE)
      (DESC "creased telegram")
      (FDESC "A stone holds down a creased telegram.")
      (LDESC "A rain-spotted telegram lies here.")
      (SYNONYM TELEGRAM MESSAGE)
      (ADJECTIVE CREASED RAIN-SPOTTED PINNED)
      (FLAGS TAKEBIT READBIT)
      (ACTION TELEGRAM-F)>

<OBJECT STUDY-DOOR
      (IN LOCAL-GLOBALS)
      (DESC "study door")
      (LDESC "A solid oak door separates the entrance hall from the study. Its brass lock is old but substantial.")
      (SYNONYM DOOR ENTRANCE BOLT)
      (ADJECTIVE STUDY OAK SOUTH SOLID WOODEN LOCKED)
      (FLAGS DOORBIT NDESCBIT)
      ;"Only a key or a pick is a sensible thing to try in this lock."
      (INTERACTIONS "OPEN:KEYRING,LOCKPICK-SET;UNLOCK:KEYRING,LOCKPICK-SET")
      (ACTION STUDY-DOOR-F)>

; --- Evidence Objects ---

<OBJECT DEAD-LETTER
      (INTERACTIONS "READ:MAGNIFYING-GLASS;PUT:LOCKED-BOX,LEATHER-ROLL,DRAWER,TRUNK;SHOW:MR-HUDSON,LADY-ASHWORTH,DR-MORIARTY,INSPECTOR;GIVE:MR-HUDSON,LADY-ASHWORTH,DR-MORIARTY")
      (IN STUDY)
      (DESC "unsent letter")
      (LDESC "An unsent letter, its paper yellowed with age, lies here.")
      (SYNONYM LETTER PAPER DEAD-LETTER ENVELOPE)
      (ADJECTIVE UNSENT DEAD YELLOWED)
      (FLAGS NDESCBIT TAKEBIT READBIT INVISIBLE)
      (ACTION DEAD-LETTER-F)>

<OBJECT BLOOD-STAINED-KNIFE
      (INTERACTIONS "PUT:LOCKED-BOX,LEATHER-ROLL,DRAWER,TRUNK;SHOW:MR-HUDSON,LADY-ASHWORTH,DR-MORIARTY,INSPECTOR;GIVE:MR-HUDSON,LADY-ASHWORTH,DR-MORIARTY")
      (IN GARDEN)
      (DESC "blood-stained knife")
      (LDESC "A blood-stained knife lies here.")
      (SYNONYM KNIFE BLADE WEAPON BLOOD-STAINED-KNIFE DAGGER)
      (ADJECTIVE BLOOD-STAINED BLOOD STAINED SURGICAL SURGEONS NARROW FINE)
      (FLAGS NDESCBIT TAKEBIT WEAPONBIT INVISIBLE)
      (ACTION BLOOD-STAINED-KNIFE-F)>

<OBJECT LOCKED-BOX
      (IN STUDY)
      (DESC "locked box")
      (SYNONYM BOX CONTAINER DIAL ENGRAVINGS ENGRAVING)
      (ADJECTIVE LOCKED LETTERED NAME ORNATE SMALL NAME-DIAL)
      (FLAGS NDESCBIT CONTBIT SEARCHBIT TURNBIT)
      ;"The dial takes a name and nothing else; the box has no keyhole."
      (INTERACTIONS "ALIGN:MORIARTY-TOPIC,HUDSON-NAME,ASHWORTH-NAME")
      (ACTION LOCKED-BOX-F)>

<OBJECT POISON-BOTTLE
      (INTERACTIONS "USE-ON:PLANTS;READ:MAGNIFYING-GLASS;PUT:LOCKED-BOX,LEATHER-ROLL,DRAWER,TRUNK;SHOW:MR-HUDSON,LADY-ASHWORTH,DR-MORIARTY,INSPECTOR;GIVE:MR-HUDSON,LADY-ASHWORTH,DR-MORIARTY")
      (IN STUDY)
      (DESC "poison bottle")
      (LDESC "A small glass bottle with a faded label lies here.")
      (SYNONYM BOTTLE VIAL POISON-BOTTLE LABEL)
      (ADJECTIVE POISON SMALL GLASS FADED POISONOUS)
      (FLAGS NDESCBIT TAKEBIT READBIT)
      (ACTION POISON-BOTTLE-F)>

<OBJECT SECRET-LEDGER
      (INTERACTIONS "READ:MAGNIFYING-GLASS;PUT:LOCKED-BOX,LEATHER-ROLL,DRAWER,TRUNK;SHOW:MR-HUDSON,LADY-ASHWORTH,DR-MORIARTY,INSPECTOR;GIVE:MR-HUDSON,LADY-ASHWORTH,DR-MORIARTY")
      (IN LIBRARY)
      (DESC "secret ledger")
      (LDESC "A leather-bound ledger lies here.")
      (SYNONYM LEDGER BOOK ACCOUNT ACCOUNTS)
      (ADJECTIVE SECRET LEATHER LEATHER-BOUND)
      (FLAGS NDESCBIT TAKEBIT READBIT)
      (ACTION SECRET-LEDGER-F)>

; --- Tool Objects ---

<OBJECT MAGNIFYING-GLASS
      (INTERACTIONS "USE-ON:FOOTPRINT-CAST,SECRET-LEDGER,DEAD-LETTER,POISON-BOTTLE,BLOOD-STAINED-KNIFE,WAX-SEAL;PUT:LOCKED-BOX,LEATHER-ROLL,DRAWER,TRUNK;SHOW:MR-HUDSON,LADY-ASHWORTH,DR-MORIARTY,INSPECTOR;GIVE:MR-HUDSON,LADY-ASHWORTH,DR-MORIARTY")
      (IN ASHWORTH-ENTRANCE-HALL)
      (DESC "magnifying glass")
      (LDESC "A brass magnifying glass lies here.")
      (SYNONYM GLASS LENS MAGNIFIER HANDLE)
      (ADJECTIVE MAGNIFYING BRASS CLEAR)
      (FLAGS NDESCBIT TAKEBIT TRANSBIT)
      (ACTION MAGNIFYING-GLASS-F)>

<OBJECT LEATHER-ROLL
      (INTERACTIONS "PUT:LOCKED-BOX,LEATHER-ROLL,DRAWER,TRUNK;SHOW:MR-HUDSON,LADY-ASHWORTH,DR-MORIARTY,INSPECTOR;GIVE:MR-HUDSON,LADY-ASHWORTH,DR-MORIARTY")
      (IN DRAWER)
      (DESC "leather roll")
      (FDESC "A leather roll lies in the open drawer.")
      (LDESC "A leather roll lies here.")
      (SYNONYM ROLL WRAP)
      (ADJECTIVE LEATHER)
      (FLAGS CONTBIT TAKEBIT)
      (CAPACITY 5)
      (SIZE 3)
      (ACTION LEATHER-ROLL-F)>

<OBJECT LOCKPICK-SET
      (INTERACTIONS "USE-ON:WINDOW,STUDY-DOOR;PUT:LOCKED-BOX,LEATHER-ROLL,DRAWER,TRUNK;SHOW:MR-HUDSON,LADY-ASHWORTH,DR-MORIARTY,INSPECTOR;GIVE:MR-HUDSON,LADY-ASHWORTH,DR-MORIARTY")
      (IN LEATHER-ROLL)
      (DESC "lockpick set")
      (LDESC "A set of metal picks, their tips worn from use, lies here.")
      (SYNONYM SET PICKS TOOLS LOCKPICK LOCKPICK-SET PICK)
      (ADJECTIVE LOCKPICK BURGLAR BURGLARS METAL FINE STEEL THIN)
      (FLAGS TAKEBIT TOOLBIT)
      (ACTION LOCKPICK-SET-F)>

<OBJECT LANTERN
      (INTERACTIONS "PUT:LOCKED-BOX,LEATHER-ROLL,DRAWER,TRUNK;SHOW:MR-HUDSON,LADY-ASHWORTH,DR-MORIARTY,INSPECTOR;GIVE:MR-HUDSON,LADY-ASHWORTH,DR-MORIARTY")
      (IN SERVANTS-QUARTERS)
      (DESC "lantern")
      (LDESC "A brass lantern lies here.")
      (SYNONYM LANTERN LAMP LIGHT)
      (ADJECTIVE OIL BRASS CLEAN FULL)
      (FLAGS NDESCBIT TAKEBIT LIGHTBIT)
      (ACTION LANTERN-F)>

<OBJECT KEYRING
      (INTERACTIONS "PUT:LOCKED-BOX,LEATHER-ROLL,DRAWER,TRUNK;SHOW:MR-HUDSON,LADY-ASHWORTH,DR-MORIARTY,INSPECTOR;GIVE:MR-HUDSON,LADY-ASHWORTH,DR-MORIARTY")
      (IN MR-HUDSON)
      (DESC "keyring")
      (LDESC "A ring of keys lies here.")
      (SYNONYM KEYRING KEYS KEY)
      (ADJECTIVE STUDY WARDED LONG)
      (FLAGS TAKEBIT TOOLBIT)
      (ACTION KEYRING-F)>

; --- Clue Objects ---

<OBJECT TORN-PAGE
      (INTERACTIONS "READ:MAGNIFYING-GLASS;PUT:LOCKED-BOX,LEATHER-ROLL,DRAWER,TRUNK;SHOW:MR-HUDSON,LADY-ASHWORTH,DR-MORIARTY,INSPECTOR;GIVE:MR-HUDSON,LADY-ASHWORTH,DR-MORIARTY")
      (IN LIBRARY)
      (DESC "torn page")
      (LDESC "A torn page, covered in handwritten notes, lies here.")
      (SYNONYM PAGE FRAGMENT TORN-PAGE PAPER NOTES)
      (ADJECTIVE TORN HANDWRITTEN)
      (FLAGS NDESCBIT TAKEBIT READBIT)
      (ACTION TORN-PAGE-F)>

<OBJECT COLORED-MARKERS
      (INTERACTIONS "")
      (IN LIBRARY)
      (DESC "colored markers")
      (LDESC "Small ribbons of color, tied to the bookshelves. Red, blue, green, and yellow markers suggest an organizational system.")
      (SYNONYM RIBBONS MARKERS TAGS MARKER RIBBON TAG)
      (ADJECTIVE COLORED COLOURED SMALL RED BLUE GREEN YELLOW)
      (FLAGS NDESCBIT PLURALBIT)
      (ACTION COLORED-MARKERS-F)>

<OBJECT FOOTPRINT-CAST
      (INTERACTIONS "PUT:LOCKED-BOX,LEATHER-ROLL,DRAWER,TRUNK;SHOW:MR-HUDSON,LADY-ASHWORTH,DR-MORIARTY,INSPECTOR;GIVE:MR-HUDSON,LADY-ASHWORTH,DR-MORIARTY")
      (IN GARDEN)
      (DESC "footprint cast")
      (LDESC "A plaster cast of a boot print lies here.")
      (SYNONYM CAST FOOTPRINT-CAST MOLD FOOTPRINT IMPRESSION MOULD PRINT)
      (ADJECTIVE PLASTER FOOTPRINT BOOT)
      (FLAGS NDESCBIT TAKEBIT)
      (ACTION FOOTPRINT-CAST-F)>

<OBJECT WAX-SEAL
      (INTERACTIONS "PUT:LOCKED-BOX,LEATHER-ROLL,DRAWER,TRUNK;SHOW:MR-HUDSON,LADY-ASHWORTH,DR-MORIARTY,INSPECTOR;GIVE:MR-HUDSON,LADY-ASHWORTH,DR-MORIARTY")
      (IN DINING-ROOM)
      (DESC "wax seal")
      (LDESC "A broken wax seal lies here.")
      (SYNONYM SEAL STAMP WAX-SEAL SIGIL)
      (ADJECTIVE WAX BROKEN CRIMSON)
      (FLAGS NDESCBIT TAKEBIT)
      (ACTION WAX-SEAL-F)>

<OBJECT BANK-STATEMENT
      (INTERACTIONS "READ:MAGNIFYING-GLASS;PUT:LOCKED-BOX,LEATHER-ROLL,DRAWER,TRUNK;SHOW:MR-HUDSON,LADY-ASHWORTH,DR-MORIARTY,INSPECTOR;GIVE:MR-HUDSON,LADY-ASHWORTH,DR-MORIARTY")
      (IN LOCKED-BOX)
      (DESC "bank statement")
      (FDESC "A bank statement rests inside the opened box.")
      (LDESC "A bank statement lies here.")
      (SYNONYM STATEMENT RECEIPT BANK-STATEMENT RECORD)
      (ADJECTIVE BANK OVERDRAWN)
      (FLAGS TAKEBIT READBIT)
      (ACTION BANK-STATEMENT-F)>

; --- Furniture/Scenery Objects ---

<OBJECT DESK
      (INTERACTIONS "")
      (IN STUDY)
      (DESC "mahogany desk")
      (LDESC "A mahogany desk, its surface scarred with use. Three drawers, one locked, contain the remnants of Lord Ashworth's work.")
      (SYNONYM DESK PAPERS DRAWERS DRAWER)
      (ADJECTIVE MAHOGANY SCARRED WOODEN)
      (FLAGS NDESCBIT)
      (ACTION DESK-F)>

<OBJECT FIREPLACE
      (INTERACTIONS "")
      (IN STUDY)
      (DESC "fireplace")
      (LDESC "A stone fireplace, its hearth cold. Ashes and a locked box remain from the last fire.")
      (SYNONYM FIREPLACE HEARTH ASHES ASH FIRE GRATE MANTELPIECE MANTEL PANEL CHIMNEY BREAST STAIR)
      (ADJECTIVE STONE COLD CHIMNEY)
      (FLAGS NDESCBIT)
      (ACTION FIREPLACE-F)>

<OBJECT WINDOW
      (IN STUDY)
      (DESC "window")
      (LDESC "A tall window, its glass clouded with age. The latch is rusted but intact, looking out to the garden.")
      (SYNONYM WINDOW GLASS LATCH CATCH)
      (ADJECTIVE TALL CLOUDED RUSTED)
      (FLAGS NDESCBIT)
      (INTERACTIONS "OPEN:LOCKPICK-SET;UNLOCK:LOCKPICK-SET")
      (ACTION WINDOW-F)>

<OBJECT BOOKSHELF
      (INTERACTIONS "")
      (IN LIBRARY)
      (DESC "bookshelf")
      (LDESC "Floor-to-ceiling shelves, filled with books of every description. Colored markers dot the spines, suggesting a hidden pattern.")
      (SYNONYM BOOKSHELVES BOOKSHELF SHELVES BOOKCASE SHELF BOOKS FOLIOS TITLES SPINE SPINES)
      (ADJECTIVE FLOOR-TO-CEILING)
      (FLAGS NDESCBIT)
      (ACTION BOOKSHELF-F)>

<OBJECT READING-DESK
      (INTERACTIONS "")
      (IN LIBRARY)
      (DESC "reading desk")
      (LDESC "A wooden desk, its surface scattered with papers. A torn page lies among them, its message waiting to be read.")
      (SYNONYM DESK PAPERS)
      (ADJECTIVE READING WOODEN SCATTERED)
      (FLAGS NDESCBIT)
      (ACTION READING-DESK-F)>

; Distinct marked books let the parser track the documented color sequence.
<OBJECT RED-BOOK
      (INTERACTIONS "")
      (IN LIBRARY)
      (DESC "red-marked book")
      (SYNONYM BOOK)
      (ADJECTIVE RED RED-MARKED COLORED COLOURED MARKED)
      (FLAGS NDESCBIT)
      (ACTION CIPHER-BOOK-F)>

<OBJECT BLUE-BOOK
      (INTERACTIONS "")
      (IN LIBRARY)
      (DESC "blue-marked book")
      (SYNONYM BOOK)
      (ADJECTIVE BLUE BLUE-MARKED COLORED COLOURED MARKED)
      (FLAGS NDESCBIT)
      (ACTION CIPHER-BOOK-F)>

<OBJECT GREEN-BOOK
      (INTERACTIONS "")
      (IN LIBRARY)
      (DESC "green-marked book")
      (SYNONYM BOOK)
      (ADJECTIVE GREEN GREEN-MARKED COLORED COLOURED MARKED)
      (FLAGS NDESCBIT)
      (ACTION CIPHER-BOOK-F)>

<OBJECT YELLOW-BOOK
      (INTERACTIONS "")
      (IN LIBRARY)
      (DESC "yellow-marked book")
      (SYNONYM BOOK)
      (ADJECTIVE YELLOW YELLOW-MARKED COLORED COLOURED MARKED)
      (FLAGS NDESCBIT)
      (ACTION CIPHER-BOOK-F)>

<OBJECT TABLE
      (INTERACTIONS "")
      (IN DINING-ROOM)
      (DESC "dining table")
      (LDESC "A long dining table, set for two but used by only one. Wax seals and place settings tell a story of interrupted meals.")
      (SYNONYM TABLE)
      (ADJECTIVE DINING LONG)
      (FLAGS NDESCBIT)
      (ACTION TABLE-F)>

<OBJECT WINE-CABINET
      (IN DINING-ROOM)
      (DESC "wine cabinet")
      (LDESC "A glass-fronted cabinet stands unlatched. One bottle-shaped gap interrupts the dust on its medicinal-wine shelf.")
      (SYNONYM CABINET WINE-CABINET SHELF)
      (ADJECTIVE WINE GLASS GLASS-FRONTED UNLATCHED MEDICINAL)
      (FLAGS NDESCBIT CONTBIT SEARCHBIT)
      (INTERACTIONS "")
      (ACTION WINE-CABINET-F)>

<OBJECT POTS
      (INTERACTIONS "")
      (IN KITCHEN)
      (DESC "copper pots")
      (LDESC "Copper pots, tarnished with age, hang from the kitchen ceiling. They have cooked many meals, but none recently.")
      (SYNONYM POTS POT PAN PANS RACK)
      (ADJECTIVE COPPER TARNISHED)
      (FLAGS NDESCBIT PLURALBIT)
      (ACTION POTS-F)>

<OBJECT HEARTH
      (INTERACTIONS "")
      (IN KITCHEN)
      (DESC "cold hearth")
      (LDESC "A stone hearth, cold and empty. The last fire burned long ago.")
      (SYNONYM HEARTH ASHES ASH LINTEL)
      (ADJECTIVE COLD STONE EMPTY)
      (FLAGS NDESCBIT)
      (ACTION HEARTH-F)>

<OBJECT SERVANT-BELL
      (INTERACTIONS "")
      (IN KITCHEN)
      (DESC "servant bell")
      (LDESC "A servant bell, its rope leading up to the servant's quarters. A pull summons the staff.")
      (SYNONYM BELL ROPE)
      (ADJECTIVE SERVANT SERVANTS HANGING)
      (FLAGS NDESCBIT)
      (ACTION SERVANT-BELL-F)>

<OBJECT KETTLE
      (INTERACTIONS "READ:MAGNIFYING-GLASS")
      (IN LOCAL-GLOBALS)
      (DESC "blue kettle")
      (LDESC "A blue enamel kettle waits on the range, warm enough to mist its spout.")
      (SYNONYM KETTLE POT TEA CARD STEAM)
      (ADJECTIVE BLUE ENAMEL WARM HOT)
      (FLAGS NDESCBIT READBIT)
      (ACTION KETTLE-F)>

<OBJECT BELL-WIRE
      (INTERACTIONS "")
      (IN ASHWORTH-ENTRANCE-HALL)
      (DESC "bell wire")
      (LDESC "A thin servant-bell wire runs beside the study door.")
      (SYNONYM WIRE CORD)
      (ADJECTIVE BELL SERVANT THIN SERVANT-BELL CROOKED)
      (FLAGS NDESCBIT)
      (ACTION BELL-WIRE-F)>

<OBJECT DRAWER
      (INTERACTIONS "")
      (IN KITCHEN)
      (DESC "drawer")
      (LDESC "A drawer in the counter.")
      (SYNONYM DRAWER)
      (ADJECTIVE COUNTER WOODEN)
      (FLAGS NDESCBIT CONTBIT SEARCHBIT)
      (CAPACITY 10)
      (ACTION DRAWER-F)>

<OBJECT FOUNTAIN
      (INTERACTIONS "")
      (IN GARDEN)
      (DESC "fountain")
      (LDESC "A stone fountain, dry and silent. Coins lie at the bottom, wishes unfulfilled.")
      (SYNONYM FOUNTAIN BASIN)
      (ADJECTIVE STONE DRY EMPTY TARNISHED)
      (FLAGS NDESCBIT)
      (ACTION FOUNTAIN-F)>

<OBJECT HEDGES
      (INTERACTIONS "")
      (IN GARDEN)
      (DESC "overgrown hedges")
      (LDESC "Tall hedges, their branches thick and tangled. They hide secrets in their shadows.")
      (SYNONYM HEDGES HEDGE BUSHES BUSH BRANCHES BRANCH GLINT GLINTS)
      (ADJECTIVE OVERGROWN TALL THICK TANGLED BLACK)
      (FLAGS NDESCBIT PLURALBIT)
      (ACTION HEDGES-F)>

<OBJECT PLANTS
      (IN GREENHOUSE)
      (DESC "exotic plants")
      (LDESC "Exotic plants from around the world, their leaves and flowers a splash of color in the gray manor.")
      (SYNONYM FLOWERS PLANTS PLANT FLOWER WOLFSBANE ACONITUM)
      (ADJECTIVE PURPLE EXOTIC GREENHOUSE LABELED)
      (FLAGS NDESCBIT PLURALBIT)
      (INTERACTIONS "")
      (ACTION PLANTS-F)>

<OBJECT LABELS
      (INTERACTIONS "")
      (IN GREENHOUSE)
      (DESC "plant labels")
      (LDESC "Small labels marking the plants. They identify species and their properties.")
      (SYNONYM LABELS LABEL)
      (ADJECTIVE PLANT SMALL CURLED PAPER)
      (FLAGS NDESCBIT PLURALBIT)
      (ACTION LABELS-F)>

<OBJECT BENCH
      (INTERACTIONS "")
      (IN GREENHOUSE)
      (DESC "potting bench")
      (LDESC "A wooden potting bench, its surface covered in soil and tools. Labels identify the plants it tends.")
      (SYNONYM BENCH STEMS GROOVE STAGING POTS POT)
      (ADJECTIVE POTTING WOODEN CUT)
      (FLAGS NDESCBIT)
      (ACTION BENCH-F)>

<OBJECT BEDS
      (INTERACTIONS "")
      (IN SERVANTS-QUARTERS)
      (DESC "servant beds")
      (LDESC "Simple beds for the household staff, their sheets worn but clean.")
      (SYNONYM BEDS BED LINEN BLANKETS BLANKET)
      (ADJECTIVE NARROW SERVANT SIMPLE EMPTY)
      (FLAGS NDESCBIT PLURALBIT)
      (ACTION BEDS-F)>

<OBJECT TRUNK
      (INTERACTIONS "OPEN:KEYRING,LOCKPICK-SET")
      (IN SERVANTS-QUARTERS)
      (DESC "trunk")
      (LDESC "A large wooden trunk, its lid heavy.")
      (SYNONYM TRUNK CHEST LID)
      (ADJECTIVE WOODEN LARGE HEAVY)
      (FLAGS NDESCBIT CONTBIT SEARCHBIT)
      (ACTION TRUNK-F)
      (CAPACITY 20)>

<OBJECT TRUNK-LETTER
      (INTERACTIONS "READ:MAGNIFYING-GLASS;PUT:LOCKED-BOX,LEATHER-ROLL,DRAWER,TRUNK;SHOW:MR-HUDSON,LADY-ASHWORTH,DR-MORIARTY,INSPECTOR;GIVE:MR-HUDSON,LADY-ASHWORTH,DR-MORIARTY")
      (IN TRUNK)
      (DESC "folded note")
      (LDESC "A folded note, its edges worn, lies here.")
      (SYNONYM NOTE MESSAGE WARNING)
      (ADJECTIVE FOLDED WORN)
      (FLAGS TAKEBIT READBIT)
      (TEXT "The letter is addressed to Mr. Hudson from an unknown sender. It reads: “The master's experiments have gone too far. If anything happens to me, the evidence is in the study. Burn this after reading.” The signature is illegible.")
      (ACTION TRUNK-LETTER-F)>

<OBJECT UNIFORMS
      (INTERACTIONS "")
      (IN TRUNK)
      (DESC "servant uniforms")
      (LDESC "Servant uniforms, their fabric worn from use. They hang on hooks, waiting for their next wearer.")
      (SYNONYM UNIFORMS CLOTHES UNIFORM CLOTHING)
      (ADJECTIVE SERVANT WORN)
      (FLAGS NDESCBIT PLURALBIT)
      (ACTION UNIFORMS-F)>

<OBJECT STONE-WALLS
      (INTERACTIONS "")
      (IN SECRET-PASSAGE)
      (DESC "stone walls")
      (LDESC "Wet stone walls, slick with moisture. They have stood for centuries.")
      (SYNONYM WALLS WALL MORTAR STEPS STAIRS STAIR CHIMNEY BREAST)
      (ADJECTIVE STONE WET SLICK STUDY CHIMNEY)
      (FLAGS NDESCBIT PLURALBIT)
	  (ACTION STONE-WALLS-F)>

<OBJECT COBWEBS
      (INTERACTIONS "")
      (IN SECRET-PASSAGE)
      (DESC "cobwebs")
      (LDESC "Dusty cobwebs fill the air, undisturbed for years.")
      (SYNONYM COBWEBS WEB WEBS COBWEB STRANDS)
      (ADJECTIVE DUSTY TORN)
      (FLAGS NDESCBIT PLURALBIT)
	  (ACTION COBWEBS-F)>

<OBJECT DUST
      (IN SECRET-PASSAGE)
      (DESC "dust")
      (LDESC "Overlapping scuffs cross the passage dust.")
      (SYNONYM DUST SCUFF SCUFFS TRAIL MARKS HEEL)
      (ADJECTIVE PASSAGE OVERLAPPING BROAD HEEL RECENT)
      (FLAGS NDESCBIT)
      (INTERACTIONS "")
	  (ACTION DUST-F)>

<OBJECT SHELVES
      (INTERACTIONS "")
      (IN PANTRY)
      (DESC "pantry shelves")
      (LDESC "Shelves filled with food and wine. Some items are old, others relatively fresh.")
      (SYNONYM SHELVES SHELF PRESERVES SPICES SPICE JARS JAR PACKETS PACKET)
      (ADJECTIVE PANTRY OLD FRESH)
      (FLAGS NDESCBIT PLURALBIT)
      (ACTION SHELVES-F)>

<OBJECT FOXGLOVE
      (INTERACTIONS "PUT:LOCKED-BOX,LEATHER-ROLL,DRAWER,TRUNK;SHOW:MR-HUDSON,LADY-ASHWORTH,DR-MORIARTY,INSPECTOR;GIVE:MR-HUDSON,LADY-ASHWORTH,DR-MORIARTY")
      (IN PANTRY)
      (DESC "foxglove")
      (LDESC "A bottle of dried foxglove leaves lies here, a skull inked on its label.")
      (SYNONYM FOXGLOVE DIGITALIS LEAVES SKULL)
      (ADJECTIVE DRIED MEDICINAL)
      (FLAGS NDESCBIT TAKEBIT)
      (ACTION FOXGLOVE-F)>

<OBJECT CHARCOAL
      (INTERACTIONS "PUT:LOCKED-BOX,LEATHER-ROLL,DRAWER,TRUNK;SHOW:MR-HUDSON,LADY-ASHWORTH,DR-MORIARTY,INSPECTOR;GIVE:MR-HUDSON,LADY-ASHWORTH,DR-MORIARTY")
      (IN PANTRY)
      (DESC "charcoal")
      (LDESC "A tin of powdered charcoal lies here.")
      (SYNONYM CHARCOAL COAL POWDER TIN)
      (ADJECTIVE POWDERED MEDICINAL)
      (FLAGS NDESCBIT TAKEBIT)
      (ACTION CHARCOAL-F)>

; === GLOBAL OBJECTS ===

<OBJECT FOG
      (INTERACTIONS "")
      (IN LOCAL-GLOBALS)
      (DESC "fog")
      (LDESC "Cold river fog curls through the manor gates.")
      (SYNONYM FOG MIST HAZE)
      (ADJECTIVE COLD RIVER DAMP)
      (FLAGS NDESCBIT)
      (ACTION FOG-F)>

<OBJECT GATES
      (INTERACTIONS "")
      (DESC "iron gates")
      (LDESC "The iron gates stand open, their bars red with rust.")
      (SYNONYM GATES GATE BARS LATCH)
      (ADJECTIVE IRON RUSTED RUSTY STURDY WET)
      (FLAGS NDESCBIT PLURALBIT)
      (ACTION GATES-F)>

<OBJECT PATH
      (INTERACTIONS "")
      (DESC "gravel path")
      (LDESC "A gravel path leads north through the fog to Ashworth Manor.")
      (SYNONYM PATH WALKWAY DRIVE)
      (ADJECTIVE GRAVEL)
      (FLAGS NDESCBIT)
      (ACTION PATH-F)>

<OBJECT HALL-TABLE
      (INTERACTIONS "")
      (IN ASHWORTH-ENTRANCE-HALL)
      (DESC "hall table")
      (SYNONYM TABLE)
      (ADJECTIVE HALL POLISHED)
      (FLAGS NDESCBIT)
      (ACTION HALL-TABLE-F)>

<OBJECT CHANDELIER
      (INTERACTIONS "")
      (DESC "chandelier")
      (LDESC "A dusty crystal chandelier hangs above the entrance hall.")
      (SYNONYM CHANDELIER LIGHT CRYSTAL CRYSTALS EDGES)
      (ADJECTIVE DUSTY CRYSTAL DULL)
      (FLAGS NDESCBIT)
      (ACTION CHANDELIER-F)>

<OBJECT PORTRAITS
      (INTERACTIONS "")
      (DESC "family portraits")
      (LDESC "Portraits of the Ashworth family line the walls.")
      (SYNONYM PORTRAITS PAINTINGS PICTURES PORTRAIT PAINTING PICTURE)
      (ADJECTIVE FAMILY ASHWORTH)
      (FLAGS NDESCBIT PLURALBIT)
      (ACTION PORTRAITS-F)>

<OBJECT RUG
      (INTERACTIONS "")
      (DESC "Persian rug")
      (LDESC "A faded Persian rug covers the entrance-hall floor.")
      (SYNONYM RUG CARPET MAT)
      (ADJECTIVE PERSIAN FADED ELEGANT)
      (FLAGS NDESCBIT)
      (ACTION RUG-F)>

<OBJECT CHALK-OUTLINE
      (INTERACTIONS "")
      (DESC "chalk outline")
      (LDESC "A chalk outline marks the place where Lord Ashworth's body was found.")
      (SYNONYM OUTLINE CHALK-OUTLINE BODY DROPS CARPET FURROW)
      (ADJECTIVE CHALK BODY TURKEY DARK BLOOD)
      (FLAGS NDESCBIT)
      (ACTION CHALK-OUTLINE-F)>

; === NPCs ===

<OBJECT MR-HUDSON
      (IN SERVANTS-QUARTERS)
      (DESC "Mr. Hudson")
      (LDESC "Mr. Hudson, the butler, stands nervously in the servants' quarters. His expression is troubled, his hands fidgeting with a keyring.")
      (SYNONYM HUDSON BUTLER MR-HUDSON MAN)
      (ADJECTIVE MR MISTER NERVOUS TROUBLED)
      ;"He never leaves his quarters, whose description follows his mood."
      (FLAGS ACTORBIT NDESCBIT)
      (ACTION MR-HUDSON-F)>

<OBJECT LADY-ASHWORTH
      (IN DINING-ROOM)
      (DESC "Lady Ashworth")
      (SYNONYM ASHWORTH WIFE LADY-ASHWORTH WIDOW WOMAN)
      (ADJECTIVE LADY COLD)
      (FLAGS NDESCBIT ACTORBIT)
      (ACTION LADY-ASHWORTH-F)>

<OBJECT DR-MORIARTY
      (IN LIBRARY)
      (DESC "Dr. Moriarty")
      (LDESC "Dr. Moriarty stands by the bookshelf, his expression arrogant and dismissive. He regards you with cool intelligence.")
      (SYNONYM MORIARTY DR-MORIARTY DOCTOR SCIENTIST MAN)
      (ADJECTIVE DR DOCTOR ARROGANT DR.)
      (FLAGS ACTORBIT NDESCBIT)
      (ACTION DR-MORIARTY-F)>

<OBJECT INSPECTOR
      (DESC "Inspector Lestrade")
      (LDESC "Inspector Lestrade of Scotland Yard stands in the entrance hall, his expression professional and skeptical. He waits for your evidence.")
      (SYNONYM LESTRADE OFFICER DETECTIVE POLICE SCOTLAND-YARD YARDMAN INSPECTOR POLICEMAN)
      (ADJECTIVE INSPECTOR SCOTLAND SKEPTICAL OFFICER)
      (FLAGS ACTORBIT NDESCBIT ARTICLEBIT)
      (ACTION INSPECTOR-F)>

; Conversation topics are global so ASK ... ABOUT ... can resolve them from
; the listener's room without requiring the referenced person or clue nearby.
; Each witness's room also lists the topics that witness offers in its GLOBAL,
; so the question identifies the intended person.
<OBJECT MASTER-TOPIC
      (IN GLOBAL-OBJECTS)
      (DESC "master")
      (SYNONYM MASTER LORD EMPLOYER HUSBAND)

	  (ACTION CONVERSATION-TOPIC-F)>
<OBJECT ALIBI-TOPIC
      (IN GLOBAL-OBJECTS)
      (DESC "alibi")
      (SYNONYM ALIBI WHEREABOUTS)
	  (ACTION CONVERSATION-TOPIC-F)>
<OBJECT KEY-TOPIC
      (IN GLOBAL-OBJECTS)
      (DESC "key")
      (SYNONYM KEY)
      (ADJECTIVE STUDY)
	  (ACTION CONVERSATION-TOPIC-F)>
<OBJECT MORIARTY-TOPIC
      (IN GLOBAL-OBJECTS)
      (DESC "Moriarty")
      (SYNONYM MORIARTY DOCTOR)
      (ADJECTIVE DR DOCTOR DR.)
	  (ACTION CONVERSATION-TOPIC-F)>
; The other two names on the locked box's dial. Moriarty's is MORIARTY-TOPIC.
; All three names are global, like the other topics, so a witness can be asked
; about someone who is in another room.
<OBJECT HUDSON-NAME
      (IN GLOBAL-OBJECTS)
      (DESC "Mr. Hudson")
      (SYNONYM HUDSON BUTLER)
      (ADJECTIVE MR MISTER)
      (FLAGS NDESCBIT)
	  (ACTION CONVERSATION-TOPIC-F)>
<OBJECT ASHWORTH-NAME
      (IN GLOBAL-OBJECTS)
      (DESC "Lady Ashworth")
      (SYNONYM ASHWORTH WIDOW)
      (ADJECTIVE LADY)
      (FLAGS NDESCBIT)
	  (ACTION CONVERSATION-TOPIC-F)>
<OBJECT MARRIAGE-TOPIC
      (IN GLOBAL-OBJECTS)
      (DESC "marriage")
      (SYNONYM MARRIAGE RELATIONSHIP)
	  (ACTION CONVERSATION-TOPIC-F)>
<OBJECT EXPERIMENTS-TOPIC
      (IN GLOBAL-OBJECTS)
      (DESC "experiments") (FLAGS PLURALBIT)
      (SYNONYM EXPERIMENTS RESEARCH EXPERIMENT)
      (ADJECTIVE MEDICINAL)
	  (ACTION CONVERSATION-TOPIC-F)>
<OBJECT POISON-TOPIC
      (IN GLOBAL-OBJECTS)
      (DESC "poison")
      (SYNONYM POISON WOLFSBANE)
	  (ACTION CONVERSATION-TOPIC-F)>
<OBJECT CASE-TOPIC
      (IN GLOBAL-OBJECTS)
      (DESC "investigation")
      (SYNONYM CASE MURDER INVESTIGATION CRIME EVIDENCE)
	  (ACTION CONVERSATION-TOPIC-F)>

<GLOBAL HERE ASHWORTH-MANOR-GATE>

<OBJECT PLACE-SETTINGS
      (INTERACTIONS "")
	(IN DINING-ROOM)
	(DESC "dinner cutlery")
	(SYNONYM CUTLERY SETTINGS PLATE SOUP SPOON FORK KNIFE KNIVES BOWL PLACES)
	(ADJECTIVE DINNER BLUNT HEAVY TABLE UNTOUCHED)
	(FLAGS NDESCBIT)
	(ACTION PLACE-SETTINGS-F)>

<OBJECT WHITE-ROSE
      (INTERACTIONS "")
	(IN GARDEN)
	(DESC "white rose")
	(SYNONYM ROSE BLOOM PETALS FLOWER STEM)
	(ADJECTIVE WHITE)
	(FLAGS NDESCBIT)
	(ACTION WHITE-ROSE-F)>

<OBJECT TELEGRAM-STONE (IN ASHWORTH-MANOR-GATE) (DESC "smooth stone")
    (SYNONYM STONE PEBBLE) (ADJECTIVE SMOOTH FLAT)
    (FLAGS NDESCBIT) (INTERACTIONS "")
    (TEXT "It fits in a palm. Its underside is dry and white against the wet gravel.")
    (ACTION TELEGRAM-STONE-F)>

<OBJECT KITCHEN-STAIRS (IN ASHWORTH-ENTRANCE-HALL) (DESC "kitchen stairs")
    (SYNONYM STAIRS STEPS STAIRCASE) (ADJECTIVE KITCHEN SERVICE)
    (FLAGS NDESCBIT PLURALBIT) (INTERACTIONS "")
    (TEXT "The narrow treads dip in the middle. Servants carrying trays have taken this way down for years.")
    (ACTION KITCHEN-STAIRS-F)>

<OBJECT HUDSON-SPOON (IN SERVANTS-QUARTERS) (DESC "silver spoon")
    (SYNONYM SPOON SILVERWARE) (ADJECTIVE SILVER POLISHED)
    (FLAGS NDESCBIT) (INTERACTIONS "")
    (TEXT "Hudson has rubbed the maker’s stamp almost flat. His cloth goes over the same spot each time footsteps pass outside.")
    (ACTION HUDSON-SPOON-F)>

<OBJECT PANTRY-APPLES (IN PANTRY) (DESC "stored apples")
    (SYNONYM APPLES APPLE FRUIT STRAW) (ADJECTIVE STORED WRINKLED)
    (FLAGS NDESCBIT PLURALBIT) (INTERACTIONS "")
    (TEXT "The winter apples sit apart on straw so a bad one cannot spoil its neighbours. One has shrivelled around its stalk.")
    (ACTION PANTRY-APPLES-F)>

<OBJECT PANTRY-DUST (IN PANTRY) (DESC "charcoal dust")
    (SYNONYM DUST POWDER) (ADJECTIVE CHARCOAL BLACK)
    (FLAGS NDESCBIT) (INTERACTIONS "")
    (TEXT "A black crescent on the shelf matches the base of the charcoal jar. Even the cook’s fingerprints have left pale gaps in it.")
    (ACTION PANTRY-DUST-F)>

<OBJECT OUTSIDE-WINDOW (IN GARDEN) (DESC "study window")
    (SYNONYM WINDOW SILL) (ADJECTIVE STUDY GARDEN)
    (FLAGS NDESCBIT) (INTERACTIONS "")
    (TEXT "The sill is low enough to step over from the flower bed. A rusty crescent shows where the catch scraped across the frame.")
    (ACTION OUTSIDE-WINDOW-F)>

<OBJECT WEDDING-RING (IN DINING-ROOM) (DESC "wedding ring")
    (SYNONYM RING BAND) (ADJECTIVE WEDDING GOLD)
    (FLAGS NDESCBIT) (INTERACTIONS "")
    (ACTION RING-DETAIL)>

<OBJECT MOURNING-RIBBON (IN DINING-ROOM) (DESC "mourning ribbon")
    (SYNONYM RIBBON BOW) (ADJECTIVE BLACK MOURNING)
    (FLAGS NDESCBIT INVISIBLE) (INTERACTIONS "")
    (TEXT "A crease marks the place where someone unpicked the bow. Lady Ashworth has smoothed it flat with her palm.")
    (ACTION MOURNING-RIBBON-F)>

<OBJECT HUDSON-BAG (IN SERVANTS-QUARTERS) (DESC "packed carpetbag")
    (SYNONYM CARPETBAG BAG FASTENINGS CLASPS) (ADJECTIVE PACKED CARPET)
    (FLAGS NDESCBIT INVISIBLE) (INTERACTIONS "")
    (ACTION HUDSON-BAG-F)>

<OBJECT MANOR-FACADE (IN ASHWORTH-MANOR-GATE) (DESC "manor house")
    (SYNONYM MANOR HOUSE FACADE) (ADJECTIVE ASHWORTH BRICK)
    (FLAGS NDESCBIT) (INTERACTIONS "")
    (TEXT "The fog parts first around the chimneys. Downstairs, a single lit window turns the gravel yellow beneath it.")
    (ACTION MANOR-FACADE-F)>

<OBJECT DETAIL-ASHWORTH-CREST (IN ASHWORTH-MANOR-GATE) (DESC "Ashworth crest")
    (SYNONYM CREST ARMS SHIELD) (ADJECTIVE ASHWORTH IRON)
    (FLAGS NDESCBIT) (INTERACTIONS "")
    (TEXT "Two iron hounds face each other across a shield. Rain has polished their muzzles bright.")
    (ACTION DETAIL-ASHWORTH-CREST-F)>

<OBJECT DETAIL-LIT-WINDOW (IN ASHWORTH-MANOR-GATE) (DESC "lit window")
    (SYNONYM WINDOW PANE) (ADJECTIVE LIT DOWNSTAIRS)
    (FLAGS NDESCBIT) (INTERACTIONS "")
    (TEXT "A bar of shadow divides the light. From the gate you can make out the window frame, but the curtains hide the room.")
    (ACTION DETAIL-LIT-WINDOW-F)>

<OBJECT DETAIL-CLEAN-CRYSTAL (IN ASHWORTH-ENTRANCE-HALL) (DESC "clean crystal")
    (SYNONYM CRYSTAL PRISM) (ADJECTIVE CLEAN SINGLE)
    (FLAGS NDESCBIT) (INTERACTIONS "")
    (TEXT "It hangs lower than its neighbours. The dust stops at the height where a raised dusting cloth could reach.")
    (ACTION DETAIL-CLEAN-CRYSTAL-F)>

<OBJECT DETAIL-FURROW (IN STUDY) (DESC "furrow")
    (SYNONYM FURROW GROOVE) (ADJECTIVE SHORT CARPET)
    (FLAGS NDESCBIT) (INTERACTIONS "")
    (TEXT "The nap lies flat in one direction. At the hearth it bunches up in a ridge, where the chair leg stopped.")
    (ACTION DETAIL-FURROW-F)>

<OBJECT STUDY-CHAIR (IN STUDY) (DESC "desk chair")
    (SYNONYM CHAIR LEG LEGS) (ADJECTIVE DESK LEATHER CHAIR)
    (FLAGS NDESCBIT) (INTERACTIONS "")
    (TEXT "Lord Ashworth's leather desk chair stands by the hearth, not at the desk. One leg has dragged a furrow through the carpet: someone pulled the chair to the fireplace and did not put it back.")
    (ACTION STUDY-CHAIR-F)>

<OBJECT DETAIL-INVENTORY-ENTRY (IN DINING-ROOM) (DESC "handwritten entry")
    (SYNONYM ENTRY HANDWRITING) (ADJECTIVE HANDWRITTEN WINE)
    (FLAGS NDESCBIT READBIT) (INTERACTIONS "")
    (TEXT "The usual wines are entered in ink. Someone squeezed the tincture into the margin in pencil, leaving no room for a quantity.")
    (ACTION DETAIL-INVENTORY-ENTRY-F)>

<OBJECT DETAIL-COINS (IN GARDEN) (DESC "coins")
    (SYNONYM COINS COIN COPPER) (ADJECTIVE TARNISHED)
    (FLAGS NDESCBIT PLURALBIT) (INTERACTIONS "")
    (TEXT "The coins have left green circles on the stone. One landed on its edge and stayed wedged in a crack.")
    (ACTION DETAIL-COINS-F)>

<OBJECT DETAIL-TEA-CARD (IN KITCHEN) (DESC "tea card")
    (SYNONYM CARD STRING) (ADJECTIVE TEA TIED)
    (FLAGS NDESCBIT READBIT) (INTERACTIONS "")
    (TEXT "Hudson used the clean side of an old order slip. A brown thumbprint has smudged the full stop after TEA FIRST.")
    (ACTION DETAIL-TEA-CARD-F)>

<OBJECT RAKE-MARKS (IN ASHWORTH-MANOR-GATE) (DESC "rake marks")
    (SYNONYM MARKS FAN FANS RAKING) (ADJECTIVE RAKE GRAVEL)
    (FLAGS NDESCBIT PLURALBIT) (INTERACTIONS "")
    (TEXT "The other fans have five neat ridges apiece. Here loose gravel has been pushed up against the doorstep.")
    (ACTION RAKE-MARKS-F)>


<OBJECT KITCHEN-RANGE (IN KITCHEN) (DESC "kitchen range")
    (SYNONYM RANGE STOVE OVEN) (ADJECTIVE KITCHEN IRON BLACK)
    (FLAGS NDESCBIT) (INTERACTIONS "")
    (TEXT "A black iron range fills the old chimney place. Its fire is banked low, and the kettle sits on the hot plate where Hudson left it.")
    (ACTION KITCHEN-RANGE-F)>

<OBJECT GARDEN-GREENHOUSE (IN GARDEN) (DESC "greenhouse")
    (SYNONYM GREENHOUSE GLASSHOUSE PANES PANE) (ADJECTIVE GLASS MISTED)
    (FLAGS NDESCBIT) (INTERACTIONS "")
    (TEXT "A small greenhouse stands at the north end of the garden. Its panes are misted from the warmth inside.")
    (ACTION GARDEN-GREENHOUSE-F)>
