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
<GLOBAL GATE-SEEN <>>
<GLOBAL HALL-SEEN <>>
<GLOBAL STUDY-SEEN <>>
<GLOBAL LIBRARY-SEEN <>>
<GLOBAL GARDEN-SEEN <>>
<GLOBAL DINING-SEEN <>>
<GLOBAL KITCHEN-SEEN <>>
<GLOBAL GREENHOUSE-SEEN <>>
<GLOBAL SERVANTS-SEEN <>>
<GLOBAL PASSAGE-SEEN <>>
<GLOBAL PANTRY-SEEN <>>
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
      (GLOBAL CHANDELIER PORTRAITS RUG STUDY-DOOR BELL-WIRE FOG)>

<ROOM STUDY
      (IN ROOMS)
      (DESC "Study")
      (ACTION STUDY-FCN)
      (SOUTH TO ASHWORTH-ENTRANCE-HALL IF STUDY-DOOR IS OPEN ELSE "The study door is closed.")
      (SW TO GARDEN IF WINDOW IS OPEN ELSE "The window is closed.")
	  (DOWN TO SECRET-PASSAGE IF CIPHER-SOLVED)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL DESK FIREPLACE WINDOW CHALK-OUTLINE STUDY-DOOR FOG)>

<ROOM LIBRARY
      (IN ROOMS)
      (DESC "Library")
      (ACTION LIBRARY-FCN)
      (WEST TO ASHWORTH-ENTRANCE-HALL)
      (EAST TO SECRET-PASSAGE IF CIPHER-SOLVED)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL BOOKSHELF READING-DESK FIREPLACE COLORED-MARKERS FOG)>

<ROOM DINING-ROOM
      (IN ROOMS)
      (DESC "Dining Room")
      (ACTION DINING-ROOM-FCN)
      (EAST TO ASHWORTH-ENTRANCE-HALL)
      (NORTH TO PANTRY)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL TABLE PORTRAITS WINE-CABINET FOG)>

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
      (GLOBAL FOUNTAIN HEDGES BLOOD-STAINED-KNIFE FOG)>

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
      (GLOBAL BEDS TRUNK UNIFORMS MR-HUDSON FOG)>

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
      (GLOBAL SHELVES FOXGLOVE CHARCOAL FOG)>

; === OBJECTS ===

<OBJECT TELEGRAM
      (IN ASHWORTH-MANOR-GATE)
      (DESC "creased telegram")
      (FDESC "A creased [[telegram]] has been pinned beneath a stone beside the open gate.")
      (LDESC "A rain-spotted [[telegram]] lies here.")
      (SYNONYM TELEGRAM MESSAGE WIRE)
      (ADJECTIVE CREASED RAIN-SPOTTED PINNED)
      (FLAGS TAKEBIT READBIT)
      (ACTION TELEGRAM-F)>

<OBJECT STUDY-DOOR
      (IN LOCAL-GLOBALS)
      (DESC "study door")
      (LDESC "A solid oak door separates the entrance hall from the study. Its brass lock is old but substantial.")
      (SYNONYM DOOR ENTRANCE)
      (ADJECTIVE STUDY OAK SOUTH SOLID WOODEN LOCKED)
      (FLAGS DOORBIT NDESCBIT)
      (ACTION STUDY-DOOR-F)>

; --- Evidence Objects ---

<OBJECT DEAD-LETTER
      (IN STUDY)
      (DESC "unsent letter")
      (FDESC "A yellowed [[envelope->letter]] lies on the desk where you turned it up, addressed in a shaking hand.")
      (LDESC "An unsent [[letter]], its paper yellowed with age, lies here.")
      (SYNONYM LETTER NOTE PAPER DEAD-LETTER ENVELOPE)
      (ADJECTIVE DEAD UNSENT YELLOWED)
      (FLAGS TAKEBIT READBIT INVISIBLE)
      (ACTION DEAD-LETTER-F)>

<OBJECT BLOOD-STAINED-KNIFE
      (IN GARDEN)
      (DESC "blood-stained knife")
      (FDESC "A [[knife]] hangs in the hedge branches near the fountain, its blade dark with dried blood.")
      (LDESC "A blood-stained [[knife]] lies here.")
      (SYNONYM KNIFE BLADE WEAPON BLOOD-STAINED-KNIFE DAGGER)
      (ADJECTIVE BLOOD STAINED BLOOD-STAINED SURGICAL SURGEONS NARROW FINE)
      (FLAGS TAKEBIT WEAPONBIT INVISIBLE)
      (ACTION BLOOD-STAINED-KNIFE-F)>

<OBJECT LOCKED-BOX
      (IN STUDY)
      (DESC "locked box")
      (DESCFCN LOCKED-BOX-DESC-F)
      (SYNONYM BOX CONTAINER DIAL)
      (ADJECTIVE LOCKED LETTERED NAME)
      (FLAGS CONTBIT SEARCHBIT TURNBIT)
      (ACTION LOCKED-BOX-F)>

<OBJECT POISON-BOTTLE
      (IN STUDY)
      (DESC "poison bottle")
      (FDESC "A small glass [[bottle]] with a faded label sits on the mantelpiece.")
      (LDESC "A small glass [[bottle]] with a faded label lies here.")
      (SYNONYM BOTTLE VIAL POISON-BOTTLE)
      (ADJECTIVE POISON SMALL GLASS FADED POISONOUS)
      (FLAGS TAKEBIT READBIT)
      (ACTION POISON-BOTTLE-F)>

<OBJECT SECRET-LEDGER
      (IN LIBRARY)
      (DESC "secret ledger")
      (FDESC "A leather-bound [[ledger]] lies open on the reading desk, its pages filled with close entries.")
      (LDESC "A leather-bound [[ledger]] lies here.")
      (SYNONYM LEDGER BOOK ACCOUNT ACCOUNTS)
      (ADJECTIVE SECRET LEATHER LEATHER-BOUND)
      (FLAGS TAKEBIT READBIT)
      (ACTION SECRET-LEDGER-F)>

; --- Tool Objects ---

<OBJECT MAGNIFYING-GLASS
      (IN ASHWORTH-ENTRANCE-HALL)
      (DESC "magnifying glass")
      (FDESC "A [[magnifying glass->glass]] rests on the hall table, its brass handle worn smooth.")
      (LDESC "A brass [[magnifying glass->glass]] lies here.")
      (SYNONYM GLASS LENS MAGNIFIER)
      (ADJECTIVE MAGNIFYING BRASS CLEAR)
      (FLAGS TAKEBIT)
      (ACTION MAGNIFYING-GLASS-F)>

<OBJECT LEATHER-ROLL
      (IN DRAWER)
      (DESC "leather roll")
      (FDESC "A [[leather roll->roll]] lies in the open drawer.")
      (LDESC "A [[leather roll->roll]] lies here.")
      (SYNONYM ROLL WRAP)
      (ADJECTIVE LEATHER OPEN)
      (FLAGS CONTBIT TAKEBIT)
      (CAPACITY 5)
      (SIZE 3)>

<OBJECT LOCKPICK-SET
      (IN LEATHER-ROLL)
      (DESC "lockpick set")
      (LDESC "A set of metal [[picks]], their tips worn from use, lies here.")
      (SYNONYM SET PICKS TOOLS LOCKPICK LOCKPICK-SET PICK)
      (ADJECTIVE LOCKPICK BURGLAR BURGLARS METAL FINE STEEL THIN)
      (FLAGS TAKEBIT TOOLBIT)
      (ACTION LOCKPICK-SET-F)>

<OBJECT LANTERN
      (IN SERVANTS-QUARTERS)
      (DESC "lantern")
      (FDESC "An oil [[lantern]] sits on the trunk, its glass clean and its fuel full.")
      (LDESC "A brass [[lantern]] lies here.")
      (SYNONYM LAMP LIGHT LANTERN)
      (ADJECTIVE OIL BRASS CLEAN FULL)
      (FLAGS TAKEBIT LIGHTBIT)
      (ACTION LANTERN-F)>

<OBJECT KEYRING
      (IN MR-HUDSON)
      (DESC "keyring")
      (LDESC "A [[ring of keys->keyring]] lies here.")
      (SYNONYM KEYRING KEYS KEY RING)
      (ADJECTIVE STUDY WARDED)
      (FLAGS TAKEBIT TOOLBIT)
      (ACTION KEYRING-F)>

; --- Clue Objects ---

<OBJECT TORN-PAGE
      (IN LIBRARY)
      (DESC "torn page")
      (FDESC "A torn [[page]] lies on the reading desk, covered in handwritten notes.")
      (LDESC "A torn [[page]], covered in handwritten notes, lies here.")
      (SYNONYM PAGE FRAGMENT TORN-PAGE PAPER)
      (ADJECTIVE TORN HANDWRITTEN)
      (FLAGS TAKEBIT READBIT)
      (ACTION TORN-PAGE-F)>

<OBJECT COLORED-MARKERS
      (IN LIBRARY)
      (DESC "colored markers")
      (LDESC "Small ribbons of color, tied to the bookshelves. Red, blue, green, and yellow markers suggest an organizational system.")
      (SYNONYM MARKERS RIBBONS TAGS MARKER RIBBON TAG)
      (ADJECTIVE COLORED COLOURED SMALL RED BLUE GREEN YELLOW)
      (FLAGS NDESCBIT)
      (ACTION COLORED-MARKERS-F)>

<OBJECT FOOTPRINT-CAST
      (IN GARDEN)
      (DESC "footprint cast")
      (FDESC "A plaster [[cast->footprint cast]] of a footprint sits near the fountain, preserving the evidence.")
      (LDESC "A plaster [[cast->footprint cast]] of a boot print lies here.")
      (SYNONYM FOOTPRINT-CAST CAST MOLD FOOTPRINT IMPRESSION MOULD)
      (ADJECTIVE FOOTPRINT PLASTER BOOT)
      (FLAGS TAKEBIT)
      (ACTION FOOTPRINT-CAST-F)>

<OBJECT WAX-SEAL
      (IN DINING-ROOM)
      (DESC "wax seal")
      (FDESC "A crimson wax [[seal]] rests on the dining table, pressed with a sigil.")
      (LDESC "A broken wax [[seal]] lies here.")
      (SYNONYM SEAL STAMP WAX-SEAL)
      (ADJECTIVE WAX BROKEN CRIMSON)
      (FLAGS TAKEBIT)
      (ACTION WAX-SEAL-F)>

<OBJECT BANK-STATEMENT
      (IN LOCKED-BOX)
      (DESC "bank statement")
      (FDESC "A [[bank statement->statement]] rests inside the opened box.")
      (LDESC "A [[bank statement->statement]] lies here.")
      (SYNONYM STATEMENT RECEIPT BANK-STATEMENT RECORD)
      (ADJECTIVE BANK OVERDRAWN)
      (FLAGS TAKEBIT READBIT)
      (ACTION BANK-STATEMENT-F)>

; --- Furniture/Scenery Objects ---

<OBJECT DESK
      (IN STUDY)
      (DESC "mahogany desk")
      (LDESC "A mahogany desk, its surface scarred with use. Three drawers, one locked, contain the remnants of Lord Ashworth's work.")
      (SYNONYM DESK PAPERS DRAWERS DRAWER)
      (ADJECTIVE MAHOGANY SCARRED WOODEN)
      (FLAGS NDESCBIT)
      (ACTION DESK-F)>

<OBJECT FIREPLACE
      (IN STUDY)
      (DESC "fireplace")
      (LDESC "A stone fireplace, its hearth cold. Ashes and a locked box remain from the last fire.")
      (SYNONYM FIREPLACE HEARTH ASHES ASH)
      (ADJECTIVE STONE COLD)
      (FLAGS NDESCBIT)
      (ACTION FIREPLACE-F)>

<OBJECT WINDOW
      (IN STUDY)
      (DESC "window")
      (LDESC "A tall window, its glass clouded with age. The latch is rusted but intact, looking out to the garden.")
      (SYNONYM WINDOW GLASS LATCH CATCH)
      (ADJECTIVE TALL CLOUDED RUSTED)
      (FLAGS NDESCBIT)
      (ACTION WINDOW-F)>

<OBJECT BOOKSHELF
      (IN LIBRARY)
      (DESC "bookshelf")
      (LDESC "Floor-to-ceiling shelves, filled with books of every description. Colored markers dot the spines, suggesting a hidden pattern.")
      (SYNONYM BOOKSHELF SHELVES BOOKCASE BOOKSHELVES SHELF)
      (ADJECTIVE FLOOR-TO-CEILING)
      (FLAGS NDESCBIT)
      (ACTION BOOKSHELF-F)>

<OBJECT READING-DESK
      (IN LIBRARY)
      (DESC "reading desk")
      (LDESC "A wooden desk, its surface scattered with papers. A torn page lies among them, its message waiting to be read.")
      (SYNONYM DESK PAPERS)
      (ADJECTIVE READING WOODEN SCATTERED)
      (FLAGS NDESCBIT)
      (ACTION READING-DESK-F)>

; Distinct marked books let the parser track the documented color sequence.
<OBJECT RED-BOOK
      (IN LIBRARY)
      (DESC "red-marked book")
      (SYNONYM BOOK)
      (ADJECTIVE RED RED-MARKED COLORED COLOURED MARKED)
      (FLAGS NDESCBIT)
      (ACTION CIPHER-BOOK-F)>

<OBJECT BLUE-BOOK
      (IN LIBRARY)
      (DESC "blue-marked book")
      (SYNONYM BOOK)
      (ADJECTIVE BLUE BLUE-MARKED COLORED COLOURED MARKED)
      (FLAGS NDESCBIT)
      (ACTION CIPHER-BOOK-F)>

<OBJECT GREEN-BOOK
      (IN LIBRARY)
      (DESC "green-marked book")
      (SYNONYM BOOK)
      (ADJECTIVE GREEN GREEN-MARKED COLORED COLOURED MARKED)
      (FLAGS NDESCBIT)
      (ACTION CIPHER-BOOK-F)>

<OBJECT YELLOW-BOOK
      (IN LIBRARY)
      (DESC "yellow-marked book")
      (SYNONYM BOOK)
      (ADJECTIVE YELLOW YELLOW-MARKED COLORED COLOURED MARKED)
      (FLAGS NDESCBIT)
      (ACTION CIPHER-BOOK-F)>

<OBJECT TABLE
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
      (SYNONYM CABINET WINE-CABINET)
      (ADJECTIVE WINE GLASS GLASS-FRONTED UNLATCHED MEDICINAL)
      (FLAGS NDESCBIT CONTBIT SEARCHBIT)
      (ACTION WINE-CABINET-F)>

<OBJECT POTS
      (IN KITCHEN)
      (DESC "copper pots")
      (LDESC "Copper pots, tarnished with age, hang from the kitchen ceiling. They have cooked many meals, but none recently.")
      (SYNONYM POTS POT PAN PANS)
      (ADJECTIVE COPPER TARNISHED)
      (FLAGS NDESCBIT)
      (ACTION POTS-F)>

<OBJECT HEARTH
      (IN KITCHEN)
      (DESC "cold hearth")
      (LDESC "A stone hearth, cold and empty. The last fire burned long ago.")
      (SYNONYM HEARTH ASHES ASH)
      (ADJECTIVE COLD STONE EMPTY)
      (FLAGS NDESCBIT)
      (ACTION HEARTH-F)>

<OBJECT SERVANT-BELL
      (IN KITCHEN)
      (DESC "servant bell")
      (LDESC "A servant bell, its rope leading up to the servant's quarters. A pull summons the staff.")
      (SYNONYM BELL ROPE)
      (ADJECTIVE SERVANT SERVANTS HANGING)
      (FLAGS NDESCBIT)
      (ACTION SERVANT-BELL-F)>

<OBJECT KETTLE
      (IN LOCAL-GLOBALS)
      (DESC "blue kettle")
      (LDESC "A blue enamel kettle waits on the range, warm enough to mist its spout.")
      (SYNONYM KETTLE POT TEA CARD)
      (ADJECTIVE BLUE ENAMEL WARM HOT)
      (FLAGS NDESCBIT DRINKBIT READBIT)
      (ACTION KETTLE-F)>

<OBJECT BELL-WIRE
      (IN ASHWORTH-ENTRANCE-HALL)
      (DESC "bell wire")
      (LDESC "A thin servant-bell wire runs beside the study door.")
      (SYNONYM WIRE CORD)
      (ADJECTIVE BELL SERVANT THIN SERVANT-BELL CROOKED)
      (FLAGS NDESCBIT)
      (ACTION BELL-WIRE-F)>

<OBJECT DRAWER
      (IN KITCHEN)
      (DESC "drawer")
      (LDESC "A drawer in the counter.")
      (SYNONYM DRAWER)
      (ADJECTIVE COUNTER WOODEN)
      (FLAGS NDESCBIT CONTBIT SEARCHBIT)
      (CAPACITY 10)
      (ACTION DRAWER-F)>

<OBJECT FOUNTAIN
      (IN GARDEN)
      (DESC "fountain")
      (LDESC "A stone fountain, dry and silent. Coins lie at the bottom, wishes unfulfilled.")
      (SYNONYM FOUNTAIN COINS BASIN COIN)
      (ADJECTIVE STONE DRY EMPTY TARNISHED)
      (FLAGS NDESCBIT)
      (ACTION FOUNTAIN-F)>

<OBJECT HEDGES
      (IN GARDEN)
      (DESC "hedge mazes")
      (LDESC "Tall hedges, their branches thick and tangled. They hide secrets in their shadows.")
      (SYNONYM HEDGES HEDGE BUSHES MAZE MAZES BUSH)
      (ADJECTIVE TALL THICK TANGLED OVERGROWN)
      (FLAGS NDESCBIT)
      (ACTION HEDGES-F)>

<OBJECT PLANTS
      (IN GREENHOUSE)
      (DESC "exotic plants")
      (LDESC "Exotic plants from around the world, their leaves and flowers a splash of color in the gray manor.")
      (SYNONYM PLANTS FLOWERS PLANT FLOWER WOLFSBANE ACONITUM)
      (ADJECTIVE EXOTIC PURPLE)
      (FLAGS NDESCBIT)
      (ACTION PLANTS-F)>

<OBJECT LABELS
      (IN GREENHOUSE)
      (DESC "plant labels")
      (LDESC "Small labels marking the plants. They identify species and their properties.")
      (SYNONYM LABELS LABEL)
      (ADJECTIVE PLANT SMALL CURLED)
      (FLAGS NDESCBIT)
      (ACTION LABELS-F)>

<OBJECT BENCH
      (IN GREENHOUSE)
      (DESC "potting bench")
      (LDESC "A wooden potting bench, its surface covered in soil and tools. Labels identify the plants it tends.")
      (SYNONYM BENCH)
      (ADJECTIVE POTTING WOODEN)
      (FLAGS NDESCBIT)
      (ACTION BENCH-F)>

<OBJECT BEDS
      (IN SERVANTS-QUARTERS)
      (DESC "servant beds")
      (LDESC "Simple beds for the household staff, their sheets worn but clean.")
      (SYNONYM BEDS BED)
      (ADJECTIVE SERVANT SIMPLE EMPTY)
      (FLAGS NDESCBIT)
      (ACTION BEDS-F)>

<OBJECT TRUNK
      (IN SERVANTS-QUARTERS)
      (DESC "trunk")
      (LDESC "A large wooden trunk, its lid heavy.")
      (SYNONYM TRUNK CHEST)
      (ADJECTIVE LARGE WOODEN HEAVY)
      (FLAGS NDESCBIT CONTBIT SEARCHBIT)
      (ACTION TRUNK-F)
      (CAPACITY 20)>

<OBJECT TRUNK-LETTER
      (IN TRUNK)
      (DESC "folded note")
      (LDESC "A [[folded note->note]], its edges worn, lies here.")
      (SYNONYM NOTE LETTER MESSAGE)
      (ADJECTIVE FOLDED WORN)
      (FLAGS TAKEBIT READBIT)
      (TEXT "The letter is addressed to Mr. Hudson from an unknown sender. It reads: 'The master's experiments have gone too far. If anything happens to me, the evidence is in the study. Burn this after reading.' The signature is illegible.")
      (ACTION TRUNK-LETTER-F)>

<OBJECT UNIFORMS
      (IN TRUNK)
      (DESC "servant uniforms")
      (LDESC "Servant uniforms, their fabric worn from use. They hang on hooks, waiting for their next wearer.")
      (SYNONYM UNIFORMS CLOTHES UNIFORM CLOTHING)
      (ADJECTIVE SERVANT WORN)
      (FLAGS NDESCBIT)
      (ACTION UNIFORMS-F)>

<OBJECT STONE-WALLS
      (IN SECRET-PASSAGE)
      (DESC "stone walls")
      (LDESC "Wet stone walls, slick with moisture. They have stood for centuries.")
      (SYNONYM WALLS WALL)
      (ADJECTIVE STONE WET SLICK)
      (FLAGS NDESCBIT)
	  (ACTION STONE-WALLS-F)>

<OBJECT COBWEBS
      (IN SECRET-PASSAGE)
      (DESC "cobwebs")
      (LDESC "Dusty cobwebs fill the air, undisturbed for years.")
      (SYNONYM COBWEBS WEB WEBS COBWEB)
      (ADJECTIVE DUSTY TORN)
      (FLAGS NDESCBIT)
	  (ACTION COBWEBS-F)>

<OBJECT DUST
      (IN SECRET-PASSAGE)
      (DESC "dust")
      (LDESC "Overlapping scuffs cross the passage dust.")
      (SYNONYM DUST SCUFF SCUFFS TRAIL)
      (ADJECTIVE PASSAGE OVERLAPPING BROAD)
      (FLAGS NDESCBIT)
	  (ACTION DUST-F)>

<OBJECT SHELVES
      (IN PANTRY)
      (DESC "pantry shelves")
      (LDESC "Shelves filled with food and wine. Some items are old, others relatively fresh.")
      (SYNONYM SHELVES SHELF PRESERVES SPICES)
      (ADJECTIVE PANTRY OLD FRESH)
      (FLAGS NDESCBIT)
      (ACTION SHELVES-F)>

<OBJECT FOXGLOVE
      (IN PANTRY)
      (DESC "foxglove")
      (LDESC "A bottle of dried [[foxglove]] leaves stands among the preserves, a skull inked on its label.")
      (SYNONYM FOXGLOVE DIGITALIS LEAVES)
      (ADJECTIVE DRIED MEDICINAL)
      (FLAGS TAKEBIT)
      (ACTION FOXGLOVE-F)>

<OBJECT CHARCOAL
      (IN PANTRY)
      (DESC "charcoal")
      (LDESC "A tin of powdered [[charcoal]] waits at the end of the shelf.")
      (SYNONYM CHARCOAL COAL POWDER)
      (ADJECTIVE POWDERED MEDICINAL)
      (FLAGS TAKEBIT)
      (ACTION CHARCOAL-F)>

; === GLOBAL OBJECTS ===

<OBJECT FOG
      (IN LOCAL-GLOBALS)
      (DESC "fog")
      (LDESC "Cold river fog curls through the manor gates.")
      (SYNONYM FOG MIST HAZE)
      (ADJECTIVE COLD RIVER DAMP)
      (FLAGS NDESCBIT)
      (ACTION FOG-F)>

<OBJECT GATES
      (DESC "iron gates")
      (LDESC "The iron gates stand open, their bars red with rust.")
      (SYNONYM GATES GATE BARS)
      (ADJECTIVE IRON RUSTED RUSTY STURDY)
      (FLAGS NDESCBIT)
      (ACTION GATES-F)>

<OBJECT PATH
      (DESC "gravel path")
      (LDESC "A gravel path leads north through the fog to Ashworth Manor.")
      (SYNONYM PATH WALKWAY DRIVE)
      (ADJECTIVE GRAVEL MANOR)
      (FLAGS NDESCBIT)
      (ACTION PATH-F)>

<OBJECT CHANDELIER
      (DESC "chandelier")
      (LDESC "A dusty crystal chandelier hangs above the entrance hall.")
      (SYNONYM CHANDELIER LIGHT CRYSTAL CRYSTALS)
      (ADJECTIVE DUSTY CRYSTAL DULL)
      (FLAGS NDESCBIT)
      (ACTION CHANDELIER-F)>

<OBJECT PORTRAITS
      (DESC "family portraits")
      (LDESC "Portraits of the Ashworth family line the walls.")
      (SYNONYM PORTRAITS PAINTINGS PICTURES PORTRAIT PAINTING PICTURE)
      (ADJECTIVE FAMILY ASHWORTH)
      (FLAGS NDESCBIT)
      (ACTION PORTRAITS-F)>

<OBJECT RUG
      (DESC "Persian rug")
      (LDESC "A faded Persian rug covers the entrance-hall floor.")
      (SYNONYM RUG CARPET MAT)
      (ADJECTIVE PERSIAN FADED ELEGANT)
      (FLAGS NDESCBIT)
      (ACTION RUG-F)>

<OBJECT CHALK-OUTLINE
      (DESC "chalk outline")
      (LDESC "A chalk outline marks the place where Lord Ashworth's body was found.")
      (SYNONYM CHALK-OUTLINE OUTLINE BODY)
      (ADJECTIVE CHALK BODY)
      (FLAGS NDESCBIT)
      (ACTION CHALK-OUTLINE-F)>

; === NPCs ===

<OBJECT MR-HUDSON
      (IN SERVANTS-QUARTERS)
      (DESC "Mr. Hudson")
      (LDESC "Mr. [[Hudson]], the butler, stands nervously in the servants' quarters. His expression is troubled, his hands fidgeting with a keyring.")
      (SYNONYM HUDSON BUTLER MR-HUDSON MAN)
      (ADJECTIVE MR MISTER NERVOUS TROUBLED)
      ;"He never leaves his quarters, whose description follows his mood."
      (FLAGS ACTORBIT NDESCBIT)
      (ACTION MR-HUDSON-F)>

<OBJECT LADY-ASHWORTH
      (IN DINING-ROOM)
      (DESC "Lady Ashworth")
      (LDESC "Lady [[Ashworth]] sits at the dining table, her expression cold and calculating. She watches you with sharp eyes.")
      (SYNONYM ASHWORTH WIFE LADY-ASHWORTH WIDOW WOMAN)
      (ADJECTIVE LADY COLD)
      (FLAGS ACTORBIT)
      (ACTION LADY-ASHWORTH-F)>

<OBJECT DR-MORIARTY
      (IN LIBRARY)
      (DESC "Dr. Moriarty")
      (LDESC "Dr. Moriarty stands by the bookshelf, his expression arrogant and dismissive. He regards you with cool intelligence.")
      (SYNONYM MORIARTY DR-MORIARTY DOCTOR SCIENTIST MAN)
      (ADJECTIVE DR DOCTOR ARROGANT)
      (FLAGS ACTORBIT NDESCBIT)
      (ACTION DR-MORIARTY-F)>

<OBJECT INSPECTOR
      (DESC "Inspector Lestrade")
      (LDESC "Inspector Lestrade of Scotland Yard stands in the entrance hall, his expression professional and skeptical. He waits for your evidence.")
      (SYNONYM LESTRADE OFFICER DETECTIVE POLICE SCOTLAND-YARD YARDMAN INSPECTOR POLICEMAN)
      (ADJECTIVE SCOTLAND INSPECTOR SKEPTICAL OFFICER)
      (FLAGS ACTORBIT NDESCBIT ARTICLEBIT)
      (ACTION INSPECTOR-F)>

; Conversation topics are global so ASK ... ABOUT ... can resolve them from
; the listener's room without requiring the referenced person or clue nearby.
<OBJECT MASTER-TOPIC
      (IN GLOBAL-OBJECTS)
      (DESC "master")
      (SYNONYM MASTER LORD EMPLOYER)

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
      (ADJECTIVE DR DOCTOR)
	  (ACTION CONVERSATION-TOPIC-F)>
<OBJECT MARRIAGE-TOPIC
      (IN GLOBAL-OBJECTS)
      (DESC "marriage")
      (SYNONYM MARRIAGE RELATIONSHIP)
	  (ACTION CONVERSATION-TOPIC-F)>
<OBJECT EXPERIMENTS-TOPIC
      (IN GLOBAL-OBJECTS)
      (DESC "experiments")
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
	(IN DINING-ROOM)
	(DESC "dinner cutlery")
	(SYNONYM CUTLERY SETTINGS PLATE SOUP SPOON FORK KNIFE KNIVES)
	(ADJECTIVE DINNER BLUNT HEAVY TABLE UNTOUCHED)
	(FLAGS NDESCBIT)
	(ACTION PLACE-SETTINGS-F)>

<OBJECT WHITE-ROSE
	(IN GARDEN)
	(DESC "white rose")
	(SYNONYM ROSE BLOOM PETALS FLOWER)
	(ADJECTIVE WHITE)
	(FLAGS NDESCBIT)
	(ACTION WHITE-ROSE-F)>
