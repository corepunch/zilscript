<DIRECTIONS NORTH EAST WEST SOUTH NE NW SE SW UP DOWN IN OUT LAND>
<VERSION ZIP>
<CONSTANT RELEASEID 1>

; === GLOBAL FLAGS ===

<GLOBAL TICK-COUNT 200>
<GLOBAL CLOCK-SLOWED <>>
<GLOBAL MUSIC-BOX-PLAYED <>>
<GLOBAL KEY-FOUND <>>
<GLOBAL KEY-WOUND <>>
<GLOBAL BERTRAND-WOUND <>>
<GLOBAL MARZIPAN-BUTTON <>>
<GLOBAL OLD-TICK-HEARD <>>
<GLOBAL OLD-TICK-RIDDLES 0>
<GLOBAL NUTMEG-TRUST 0>
<GLOBAL NUTMEG-GIFTS 0>
<GLOBAL LADDER-OILED <>>
<GLOBAL CART-MOVED <>>
<GLOBAL CART-HELPED <>>
<GLOBAL TOWER-WOUND <>>
<GLOBAL STUDY-ACCESS <>>
<GLOBAL HEART-ACCESS <>>
<GLOBAL JOURNAL-READ <>>
<GLOBAL LETTER-READ <>>
<GLOBAL DIAGRAM-READ <>>
<GLOBAL STUDY-JOURNAL-READ <>>
<GLOBAL REPAIR-BOOK-OPEN <>>
<GLOBAL GAME-WON <>>
<GLOBAL ENDING-TIER 0>
<GLOBAL COMPANION-COUNT 0>
<GLOBAL NUTMEG-SAVED <>>
<GLOBAL HINT-KEY 0>
<GLOBAL HINT-LEVEL 0>
<GLOBAL NUTMEG-KEY-METHOD 0>
<GLOBAL PUZZLES-SOLVED 0>
<GLOBAL LORE-DISCOVERED 0>
<GLOBAL SCORE-MAX 100>
<GLOBAL TIMER-ACTIVE T>
<GLOBAL RANKINGS
    <LTABLE "Toymaker's Apprentice"
         "Journeyman Toymaker"
         "Master Toymaker"
         "Grand Artificer"
         "The Last Toymaker">>

; === ROOMS ===

<ROOM WORKSHOP-FLOOR
      (IN ROOMS)
      (DESC "Workshop Floor")
      (ACTION WORKSHOP-FLOOR-FCN)
      (EAST TO TOOL-BENCH)
      (NORTH TO SNOWY-ALLEY)
      (UP TO STORAGE-LOFT IF LADDER-OILED)
      (IN TO TOLLIVER-STUDY IF STUDY-ACCESS)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL WORKSHOP-BUILDING TOPIC-TOLLIVER TOPIC-KEY TOPIC-HEART)>

<ROOM WORKBENCH-TOP
      (IN ROOMS)
      (DESC "Workbench Top")
      (ACTION WORKBENCH-TOP-FCN)
      (DOWN PER WORKBENCH-DOWN-EXIT)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL WORKBENCH TOPIC-TOLLIVER TOPIC-HEART)>

<ROOM TOOL-BENCH
      (IN ROOMS)
      (DESC "Tool Bench")
      (LDESC "Makeshift [[steps]] climb past the [[tool rack->rack]] to the countertop above the workshop floor to the [[west]].")
      (WEST TO WORKSHOP-FLOOR)
      (UP TO COUNTERTOP IF BERTRAND-WOUND)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL TOPIC-TOLLIVER TOPIC-KEY)>

<ROOM COUNTERTOP
      (IN ROOMS)
      (DESC "Countertop")
      (LDESC "Moonlight falls through the [[window]] onto the toy display [[case]] by the [[steps]] back [[down]].")
      (DOWN TO TOOL-BENCH)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL WORKSHOP-BUILDING TOPIC-TOLLIVER TOPIC-KEY TOPIC-FOX)>

<ROOM STORAGE-LOFT
      (IN ROOMS) (ACTION STORAGE-LOFT-LOOK)
      (DESC "Storage Loft")
      (LDESC "In the storage loft, a dusty [[box]] sits under the [[cobwebs]] beside the [[ladder]] back [[down]].")
      (DOWN TO WORKSHOP-FLOOR)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL TOPIC-TOLLIVER)>

<ROOM SNOWY-ALLEY
      (IN ROOMS)
      (DESC "Snowy Alley")
      (LDESC "Under a flickering [[streetlamp]], tiny [[footprints]] cross the [[snow]] [[east]]. The workshop is [[south]].")
      (SOUTH TO WORKSHOP-FLOOR)
      (EAST TO CLOCK-SQUARE)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL WORKSHOP-BUILDING MOON TOPIC-FOX)>

<ROOM CLOCK-SQUARE
      (IN ROOMS)
      (DESC "Clock Square")
      (LDESC "From the dim [[lamps]] below the [[tower]], [[paths]] lead [[west]] to the alley, [[east]] to the mailbox and [[south]] to the scrap-yard.")
      (WEST TO SNOWY-ALLEY)
      (EAST TO MAILBOX-CORNER)
      (SOUTH TO SCRAP-YARD)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL MOON TOPIC-FOX TOPIC-TOLLIVER BAKERY)>

<ROOM MAILBOX-CORNER
      (IN ROOMS)
      (DESC "Mailbox Corner")
      (LDESC "Fox [[footprints]] double back [[west]] toward the square.")
      (WEST TO CLOCK-SQUARE)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL MOON TOPIC-FOX TOPIC-TOLLIVER FOOTPRINTS CLOCK-TOWER)>

<ROOM SCRAP-YARD
      (IN ROOMS)
      (DESC "Scrap-Yard")
      (ACTION SCRAP-YARD-FCN)
      (NORTH TO CLOCK-SQUARE)
      (EAST TO FOX-DEN IF CART-MOVED)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL MOON TOPIC-FOX)>

<ROOM FOX-DEN
      (IN ROOMS)
      (DESC "Fox Den")
      (LDESC "A toy [[candle]] warms a rag [[bed]] just inside the [[entrance]] to the [[west]].")
      (WEST TO SCRAP-YARD)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL TOPIC-TOLLIVER TOPIC-KEY TOPIC-FOX TOPIC-HEART)>

<ROOM TOLLIVER-STUDY
      (IN ROOMS)
      (DESC "Tolliver's Study")
      (LDESC "Grandfather’s [[chair]] stands empty at his [[desk]]. A [[ticking]] comes from [[down]] below, and the [[stairs]] lead [[out]].")
      (OUT TO WORKSHOP-FLOOR)
      (DOWN TO WORKSHOP-HEART)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL TOPIC-TOLLIVER TOPIC-KEY TOPIC-HEART)>

<ROOM WORKSHOP-HEART
      (IN ROOMS)
      (DESC "Workshop Heart")
      (LDESC "Silent [[toys]] crowd the foot of the [[passage]] back [[up]].")
      (UP TO TOLLIVER-STUDY)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL TOPIC-HEART TOPIC-TOLLIVER)>

; === OBJECTS: WORKSHOP-FLOOR ===

<OBJECT KEY-HOOK
        (IN WORKSHOP-FLOOR)
        (SYNONYM HOOK)
        (ADJECTIVE KEY BRASS EMPTY COLD)
        (DESC "brass key hook")
        (LDESC "A brass key hook hangs on the wall.")
        (FLAGS NDESCBIT)
        (ACTION KEY-HOOK-F)>

<OBJECT WORKBENCH
        (IN WORKSHOP-FLOOR)
        (SYNONYM BENCH WORKBENCH TABLE GLINT GLINTS)
        (ADJECTIVE ENORMOUS WOODEN WORK GIANT CLUTTERED CARVED TOOL)
        (DESC "enormous workbench")
        (FLAGS NDESCBIT SURFACEBIT CONTBIT OPENBIT SEARCHBIT CLIMBBIT)
        (ACTION WORKBENCH-F)>

<OBJECT OIL-CAN
        (IN WORKSHOP-FLOOR)
        (SYNONYM CAN OILCAN OIL-CAN)
        (ADJECTIVE TINY COPPER OIL SMALL HALF-FULL)
        (DESC "tiny copper oil can")
        (LDESC "A tiny copper [[oil can->can]] lies here.")
        (FLAGS NDESCBIT TAKEBIT INVISIBLE)
        (SIZE 3)
        (ACTION OIL-CAN-F)>

<OBJECT SAWDUST
        (IN WORKSHOP-FLOOR)
        (SYNONYM SAWDUST DUST FLOOR)
        (ADJECTIVE SOFT GOLDEN CEDAR)
        (DESC "soft sawdust")
        (LDESC "Soft sawdust covers the floorboards like a golden blanket.")
        (FLAGS NDESCBIT)
        (ACTION SAWDUST-F)>

<OBJECT PET-DOOR
        (IN WORKSHOP-FLOOR)
        (SYNONYM DOOR PET FLAP)
        (ADJECTIVE PET SMALL WOODEN WORKSHOP)
        (DESC "small pet door")
        (INTERACTIONS "")
        (LDESC "A small pet door is cut into the bottom of the workshop's main door.")
        (FLAGS NDESCBIT)
        (ACTION PET-DOOR-F)>

<OBJECT SWEEP-BROOM
        (IN WORKSHOP-FLOOR)
        (SYNONYM BROOM BRUSH)
        (ADJECTIVE TINY SWEEP WORN PIP)
        (DESC "tiny broom")
        (LDESC "Your [[broom]] lies here.")
        (FLAGS TAKEBIT NDESCBIT)
        (SIZE 4)
        (ACTION SWEEP-BROOM-F)>

<OBJECT CLOCK-FACE
        (IN WORKSHOP-FLOOR)
        (SYNONYM CLOCK CUCKOO STAIRS STAIRCASE)
        (ADJECTIVE OLD WOODEN WALL CUCKOO TICKING WORKSHOP OPEN)
        (DESC "old cuckoo clock")
        (LDESC "An old cuckoo clock hangs on the wall, ticking softly.")
        (FLAGS NDESCBIT)
        (ACTION CLOCK-FACE-F)>

<OBJECT KEY-STRING
        (IN WORKSHOP-FLOOR)
        (SYNONYM STRING CORD THREAD TWINE)
        (ADJECTIVE FRAYED DANGLING CHEWED)
        (DESC "frayed string")
        (LDESC "A frayed [[string]] lies here.")
        (FLAGS TAKEBIT NDESCBIT)
        (SIZE 1)
        (ACTION KEY-STRING-F)>

<OBJECT LOFT-LADDER
        (IN WORKSHOP-FLOOR)
        (SYNONYM LADDER)
        (ADJECTIVE FOLDING LOFT WOODEN BROAD OILED)
        (DESC "folding loft ladder")
        (INTERACTIONS "")
        (LDESC "A folding wooden ladder leads toward the storage loft. Its iron lifting mechanism is rusted solid.")
        (FLAGS NDESCBIT)
        (ACTION LOFT-LADDER-F)>

<OBJECT LADDER-MECH
        (IN WORKSHOP-FLOOR)
        (SYNONYM MECHANISM LIFT WINCH)
        (ADJECTIVE RUSTY IRON LIFTING LADDER RUSTED FROZEN OILED)
        (DESC "rusty ladder mechanism")
        (INTERACTIONS "")
        (LDESC "The rusty iron lifting mechanism that raises the folding loft ladder is frozen solid.")
        (FLAGS TURNBIT NDESCBIT)
        (ACTION LADDER-MECH-F)>

; === OBJECTS: TOOL-BENCH ===

<OBJECT BERTRAND
        (IN TOOL-BENCH)
        (SYNONYM NUTCRACKER BERTRAND SOLDIER CAPTAIN)
        (ADJECTIVE PAINTED POMPOUS WOODEN CAPTAIN FROZEN)
        (DESC "painted wooden nutcracker")
        (INTERACTIONS "TELL:BERTRAND-KEY,KEY-HOOK,KEY-STRING,WORKSHOP-KEY,TOLLIVER-JOURNAL,LETTER,TOLLIVER-COAT,STUDY-JOURNAL")
        (LDESC "A painted wooden nutcracker stands at attention, frozen mid-stride.")
        (DESCFCN BERTRAND-DESC-F)
        (FLAGS ACTORBIT)
        (ACTION BERTRAND-F)>

<OBJECT BERTRAND-KEY
        (IN TOOL-BENCH)
        (SYNONYM KEY)
        (ADJECTIVE WINDING TINY BRASS NUTCRACKER LITTLE)
        (DESC "tiny brass winding key")
        (LDESC "There is a tiny brass winding key on the nutcracker's back.")
        (FLAGS TAKEBIT NDESCBIT)
        (SIZE 2)
        (ACTION BERTRAND-KEY-F)>

<OBJECT VARNISH-POT
        (IN TOOL-BENCH)
        (SYNONYM POT VARNISH CAN)
        (ADJECTIVE STICKY VARNISH UNSETTLED THICK TACKY OPEN)
        (DESC "pot of varnish")
        (FLAGS NDESCBIT CONTBIT OPENBIT SURFACEBIT)
        (ACTION VARNISH-POT-F)>

<OBJECT TOOL-RACK
        (IN TOOL-BENCH)
        (SYNONYM RACK TOOLS)
        (ADJECTIVE WOODEN TOOL TINY)
        (DESC "tool rack")
        (LDESC "A wooden rack of tools hangs on the wall — chisels, files, tiny hammers.")
        (FLAGS NDESCBIT)
        (ACTION TOOL-RACK-F)>

<OBJECT MAKESHIFT-STEPS
        (IN TOOL-BENCH)
        (SYNONYM STEPS STAIRCASE CRATE CHAIR BOOK BOOKS STACK ROUTE SEAT)
        (ADJECTIVE MAKESHIFT LOW OLD REPAIR BROAD CLIMBING PACKING STACKED CHAIR)
        (DESC "makeshift climbing steps")
        (LDESC "A low crate leads to an old chair, where three broad repair books make the final steps to the countertop.")
        (FLAGS NDESCBIT CLIMBBIT)
        (ACTION MAKESHIFT-STEPS-F)>
; === OBJECTS: WORKBENCH TOP ===

<OBJECT REPAIR-BOOK
        (IN WORKBENCH-TOP)
        (SYNONYM BOOK MANUAL GUIDE ALBUM)
        (ADJECTIVE REPAIR ILLUSTRATED TOLLIVER LEATHER GREEN ENORMOUS BATTERED WOODEN OPEN)
        (DESC "illustrated repair book")
        (INTERACTIONS "")
        (FLAGS CONTBIT OPENABLEBIT READBIT NDESCBIT)
        (ACTION REPAIR-BOOK-F)>

<OBJECT HALF-FINISHED-TOYS
        (IN WORKBENCH-TOP)
        (SYNONYM TOYS INVENTIONS)
        (ADJECTIVE HALF-FINISHED WOODEN TOY UNFINISHED HALF-RIGGED)
        (DESC "half-finished toys")
        (LDESC "A half-rigged sailboat, a wooden train, and a duck with only one wheel wait beneath the work lamp.")
        (FLAGS NDESCBIT)
        (ACTION HALF-FINISHED-TOYS-F)>
; === OBJECTS: COUNTERTOP ===

<OBJECT MARZIPAN
        (IN COUNTERTOP)
        (SYNONYM DOLL RAGDOLL MARZIPAN EYE EYES)
        (ADJECTIVE RAG ONE-EYED PATCHED MENDED HUMMING BUTTON)
        (DESC "one-eyed rag doll")
        (INTERACTIONS "TELL:NUTMEG,FOOTPRINTS,WORKSHOP-KEY,KEY-HOOK,KEY-STRING")
        (LDESC "A rag doll with one button eye sits against the window, humming softly.")
        (DESCFCN MARZIPAN-DESC-F)
        (FLAGS ACTORBIT)
        (ACTION MARZIPAN-F)>

<OBJECT DISPLAY-CASE
        (IN COUNTERTOP)
        (SYNONYM CASE DISPLAY CABINET)
        (ADJECTIVE DUSTY GLASS DISPLAY BRASS TOY)
        (DESC "dusty glass display case")
        (INTERACTIONS "")
        (FLAGS NDESCBIT CONTBIT OPENABLEBIT TRANSBIT)
        (CAPACITY 20)
        (ACTION DISPLAY-CASE-F)>

<OBJECT TIN-SOLDIER
        (IN DISPLAY-CASE)
        (SYNONYM SOLDIER TIN-FIGURE FIGURE)
        (ADJECTIVE TIN BRAVE RUSTED PAINTED RED BLUE)
        (DESC "tin soldier")
        (LDESC "A brave [[tin soldier->soldier]], slightly rusted but still standing.")
        (FLAGS NDESCBIT TAKEBIT)
        (SIZE 5)
        (ACTION TIN-SOLDIER-F)>

<OBJECT MUSIC-BOX
        (IN DISPLAY-CASE)
        (SYNONYM BOX CRANK)
        (ADJECTIVE MUSIC SILVER TINY SMALL WINDING)
        (DESC "silver music box")
        (INTERACTIONS "PUT:DISPLAY-CASE")
        (LDESC "A silver [[music box->box]] with a tiny crank.")
        (FLAGS NDESCBIT TAKEBIT TURNBIT)
        (SIZE 4)
        (ACTION MUSIC-BOX-F)>

<OBJECT SHOP-WINDOW
        (IN COUNTERTOP)
        (SYNONYM WINDOW)
        (ADJECTIVE FROSTED GLASS SHOP SNOWY)
        (DESC "frosted shop window")
        (LDESC "Through the frosted window, you can see the snowy street outside.")
        (FLAGS NDESCBIT)
        (ACTION SHOP-WINDOW-F)>

<OBJECT BUTTON
        (IN COUNTERTOP)
        (SYNONYM BUTTON EYE)
        (ADJECTIVE SPARE BLACK SMOOTH WARM)
        (DESC "spare button")
        (INTERACTIONS "GIVE-TO:MARZIPAN;GIVE:MARZIPAN")
        (LDESC "A spare [[button]] lies near the rag doll.")
        (FLAGS NDESCBIT TAKEBIT)
        (SIZE 1)
        (ACTION TOY-BUTTON-F)>

; === OBJECTS: STORAGE-LOFT ===

<OBJECT OLD-TICK
        (IN STORAGE-LOFT)
        (SYNONYM CLOCK CUCKOO TICK BIRD LATCH)
        (ADJECTIVE OLD DUSTY CUCKOO WOODEN LOFT FROZEN HIDDEN)
        (DESC "old cuckoo clock")
        (INTERACTIONS "TELL:TOLLIVER-JOURNAL,LETTER,TOLLIVER-COAT,STUDY-JOURNAL")
        (LDESC "An old cuckoo clock, dusty and still, its hands frozen at five to midnight.")
        (DESCFCN OLD-TICK-DESC-F)
        (FLAGS ACTORBIT)
        (ACTION OLD-TICK-F)>

<OBJECT TOY-BOX
        (IN STORAGE-LOFT)
        (SYNONYM BOX CARTON WHEEL SPRINGS PARTS PIECES)
        (ADJECTIVE DUSTY CARDBOARD TOY BROKEN REPAIR)
        (DESC "dusty cardboard box")
        (INTERACTIONS "")
        (FLAGS NDESCBIT CONTBIT OPENABLEBIT)
        (CAPACITY 20)
        (ACTION TOY-BOX-F)>

<OBJECT DOLL-ARM
        (IN TOY-BOX)
        (SYNONYM ARM DOLL-ARM LIMB)
        (ADJECTIVE PORCELAIN DOLL DELICATE BROKEN)
        (DESC "porcelain doll arm")
        (FDESC "A delicate porcelain doll [[arm]] rests in the open box, separated from its owner.")
        (LDESC "A delicate porcelain doll [[arm]] lies here.")
        (FLAGS TAKEBIT)
        (SIZE 2)
        (ACTION DOLL-ARM-F)>

<OBJECT TOLLIVER-JOURNAL
        (IN STORAGE-LOFT)
        (SYNONYM JOURNAL DIARY NOTEBOOK)
        (ADJECTIVE LEATHER OLD TOLLIVER)
        (DESC "leather journal")
        (INTERACTIONS "")
        (LDESC "A leather [[journal]] lies here.")
        (FLAGS NDESCBIT TAKEBIT READBIT)
        (SIZE 5)
        (TEXT "October 14th — The workshop key grows weaker. I must wind it more often now. The magic in this town depends on it. October 20th — Old Tick tells me the heart of the workshop needs attention. I will attend to it tonight. October 21st — I could not reach the heart alone. Something blocks the way. I must find another path. The toys need me. Pip needs me.")
        (ACTION TOLLIVER-JOURNAL-F)>

<OBJECT COBWEBS
        (IN STORAGE-LOFT)
        (SYNONYM COBWEBS WEBS DUST COBWEB WEB)
        (ADJECTIVE DUSTY GREY GRAY)
        (DESC "dusty cobwebs")
        (LDESC "Dusty cobwebs drape the rafters like grey curtains.")
        (FLAGS NDESCBIT)
        (ACTION COBWEBS-F)>

; === OBJECTS: SNOWY-ALLEY ===

<OBJECT FOOTPRINTS
        (IN SNOWY-ALLEY)
        (SYNONYM FOOTPRINTS PRINTS TRACKS PAWPRINTS FOOTPRINT PRINT TRACK PAWPRINT)
        (ADJECTIVE FOX TINY MUDDY TOY-SIZED)
        (DESC "tiny fox footprints")
        (LDESC "Tiny fox footprints lead east through the fresh snow. They are unmistakeably toy-sized.")
        (FLAGS NDESCBIT)
        (ACTION FOOTPRINTS-F)>

<OBJECT STREETLAMP
        (IN SNOWY-ALLEY)
        (SYNONYM STREETLAMP LAMP LIGHT LANTERN)
        (ADJECTIVE FLICKERING TOY REPURPOSED LIT)
        (DESC "toy streetlamp")
        (INTERACTIONS "")
        (LDESC "A streetlamp — actually a repurposed toy lantern — flickers overhead on a pole.")
        (FLAGS LIGHTBIT NDESCBIT)
        (ACTION STREETLAMP-F)>

<OBJECT SNOW
        (IN SNOWY-ALLEY)
        (SYNONYM SNOW BLANKET)
        (ADJECTIVE FRESH DEEP COLD SPARKLING)
        (DESC "fresh snow")
        (LDESC "Fresh snow blankets the cobblestones. It sparkles in the moonlight.")
        (FLAGS NDESCBIT)
        (ACTION SNOW-F)>

; === OBJECTS: CLOCK-SQUARE ===

<OBJECT CLOCK-TOWER
        (IN CLOCK-SQUARE)
        (SYNONYM TOWER CLOCK BUILDING)
        (ADJECTIVE GIANT STONE CLOCK GREAT TICKING)
        (DESC "giant clock tower")
        (ACTION CLOCK-TOWER-F)
        (FLAGS NDESCBIT)>

<OBJECT CLOCK-WINDING
        (IN CLOCK-SQUARE)
        (SYNONYM MECHANISM WINDING KEYHOLE)
        (ADJECTIVE BRASS WINDING TINY)
        (DESC "brass winding mechanism")
        (INTERACTIONS "")
        (LDESC "A brass winding [[mechanism]] sits at the clock tower's base.")
        (DESCFCN CLOCK-WINDING-DESC-F)
        (FLAGS TURNBIT)
        (ACTION CLOCK-WINDING-F)>

<OBJECT BAKER-TOY
        (IN CLOCK-SQUARE)
        (SYNONYM BAKER TOY FIGURE)
        (ADJECTIVE WOODEN BAKER PAINTED FROZEN)
        (DESC "wooden baker toy")
        (LDESC "A wooden baker toy stands in the bakery window, frozen mid-knead.")
        (FLAGS NDESCBIT)
        (ACTION BAKER-TOY-F)>

<OBJECT TOY-LAMPS
        (IN CLOCK-SQUARE)
        (SYNONYM LAMPS LIGHTS LAMP LIGHT)
        (ADJECTIVE TIN TOY DIM WEAK FLICKERING)
        (DESC "tin toy lamps")
        (LDESC "Tin toy lamps dot the cobblestones, their light weak and flickering.")
        (FLAGS LIGHTBIT NDESCBIT)
        (ACTION TOY-LAMPS-F)>

; === OBJECTS: MAILBOX-CORNER ===

<OBJECT MAILBOX
        (IN MAILBOX-CORNER)
        (SYNONYM MAILBOX BOX POSTBOX FLAP)
        (ADJECTIVE RED TIN TALKING PAINTED SHIVERING)
        (DESC "red tin mailbox")
        (INTERACTIONS "TELL:FOOTPRINTS,NUTMEG,SCARF,LETTER")
        (FDESC "A red [[mailbox]] shivers in the [[snow]].")
        (LDESC "A red tin [[mailbox]] tilts into the snow, its flap moving occasionally like a mouth.")
        (FLAGS CONTBIT OPENBIT ACTORBIT)
        (ACTION MAILBOX-F)>

<OBJECT LETTER
        (IN MAILBOX-CORNER)
        (SYNONYM LETTER ENVELOPE NOTE)
        (ADJECTIVE CRUMPLED WHITE TOLLIVER)
        (DESC "crumpled letter")
        (INTERACTIONS "")
        (LDESC "A crumpled [[envelope]] lies half-buried in the snow.")
        (FLAGS NDESCBIT TAKEBIT READBIT)
        (SIZE 2)
        (TEXT "My dear Pip — The heart is failing. I must go and mend it myself. Do not worry. Take care of the toys while I am gone. Wind the key at midnight if I do not return. — Grandfather Tolliver")
        (ACTION LETTER-F)>

<OBJECT SCARF
        (IN MAILBOX-CORNER)
        (SYNONYM SCARF)
        (ADJECTIVE RED WOOL WARM WOOLEN WOOLLEN)
        (DESC "red wool scarf")
        (INTERACTIONS "GIVE-TO:NUTMEG;GIVE:NUTMEG")
        (LDESC "A wool [[scarf]] lies here.")
        (FLAGS NDESCBIT TAKEBIT)
        (SIZE 3)
        (ACTION SCARF-F)>

<OBJECT MAILBOX-LETTERS
        (IN MAILBOX)
        (SYNONYM BUNDLE MAIL)
        (ADJECTIVE UNSENT OLD UNOPENED)
        (DESC "bundle of letters")
        (LDESC "A bundle of unsent letters sits inside the mailbox. They are addressed to toys — invitations to birthday parties, thank-you notes, letters from children long grown up.")
        (FLAGS NDESCBIT)
        (ACTION MAILBOX-LETTERS-F)>

; === OBJECTS: SCRAP-YARD ===

<OBJECT SCRAP-CART
        (IN SCRAP-YARD)
        (SYNONYM CART WAGON)
        (ADJECTIVE SCRAP METAL CREAKING SCRAP-METAL HEAVY RUSTED IRON)
        (DESC "scrap-metal cart")
        (INTERACTIONS "")
        (LDESC "A scrap-metal cart creaks along a track, gathering broken toys into its bed.")
        (DESCFCN SCRAP-CART-DESC-F)
        (FLAGS CONTBIT OPENBIT SURFACEBIT)
        (CAPACITY 40)
        (ACTION SCRAP-CART-F)>

<OBJECT HEADLESS-DOLL
        (IN SCRAP-CART)
        (SYNONYM DOLL BODY)
        (ADJECTIVE HEADLESS PORCELAIN BROKEN TORN)
        (DESC "headless doll")
        (LDESC "A [[headless porcelain doll->doll]] lies in the scrap cart. Its dress is torn, but someone has folded its hands neatly.")
        (SIZE 4)
        (ACTION HEADLESS-DOLL-F)>

<OBJECT DOLL-HEAD
        (IN SCRAP-YARD)
        (SYNONYM HEAD)
        (ADJECTIVE DOLL PORCELAIN PAINTED BLUE)
        (DESC "porcelain doll head")
        (INTERACTIONS "GIVE-TO:SCRAP-CART,HEADLESS-DOLL;GIVE:SCRAP-CART,HEADLESS-DOLL;PUT:SCRAP-CART")
        (LDESC "A porcelain [[doll head->head]] lies here.")
        (FLAGS NDESCBIT TAKEBIT INVISIBLE)
        (SIZE 2)
        (ACTION DOLL-HEAD-F)>

<OBJECT SCRAP-PILES
        (IN SCRAP-YARD)
        (SYNONYM PILES PILE SCRAP PLAYTHINGS HEAP TOYS)
        (ADJECTIVE BROKEN DISCARDED SNOWY TOY FROZEN)
        (DESC "piles of broken toys")
        (INTERACTIONS "")
        (FLAGS NDESCBIT)
        (ACTION SCRAP-PILES-F)>

<OBJECT TOY-HORSE
        (IN SCRAP-YARD)
        (SYNONYM HORSE PONY)
        (ADJECTIVE TOY THREE-LEGGED WOODEN CHIPPED MISSING)
        (DESC "three-legged horse")
        (LDESC "A toy [[horse]], one leg missing, lies on its side.")
        (FLAGS NDESCBIT TAKEBIT)
        (SIZE 6)
        (ACTION TOY-HORSE-F)>

<OBJECT YARD-GATE
        (IN SCRAP-YARD)
        (SYNONYM GATE GATEWAY)
        (ADJECTIVE IRON EAST BLOCKED)
        (DESC "iron gate")
        (LDESC "An iron gate leads east, but the scrap cart blocks the way.")
        (FLAGS NDESCBIT)
        (ACTION YARD-GATE-F)>

; === OBJECTS: FOX-DEN ===

<OBJECT NUTMEG
        (IN FOX-DEN)
        (SYNONYM FOX NUTMEG VIXEN TOY)
        (ADJECTIVE PATCHY STUFFED ORANGE FOX FOX-SHAPED LOPSIDED)
        (DESC "patchy fox toy")
        (INTERACTIONS "TELL:WORKSHOP-KEY,TOLLIVER-JOURNAL,LETTER,TOLLIVER-COAT,STUDY-JOURNAL")
        (LDESC "A fox-shaped toy with patchy fur curls in the den, watching you with button eyes.")
        (DESCFCN NUTMEG-DESC-F)
        (FLAGS ACTORBIT)
        (ACTION NUTMEG-F)>

<OBJECT WORKSHOP-KEY
        (IN FOX-DEN)
        (SYNONYM KEY)
        (ADJECTIVE WORKSHOP BRASS TICKING WARM CARVED)
        (DESC "workshop key")
        (LDESC "The workshop key hangs from a string around the fox's neck, ticking faintly.")
        (FLAGS TAKEBIT NDESCBIT)
        (SIZE 3)
        (ACTION WORKSHOP-KEY-F)>

<OBJECT RAG-BED
        (IN FOX-DEN)
        (SYNONYM BED NEST RAGS)
        (ADJECTIVE COSY RAG COZY CEDAR)
        (DESC "cosy rag bed")
        (FLAGS NDESCBIT CONTBIT OPENBIT SURFACEBIT)
        (CAPACITY 20)
        (ACTION RAG-BED-F)>

<OBJECT TOY-CANDLE
        (IN FOX-DEN)
        (SYNONYM CANDLE FLAME)
        (ADJECTIVE TOY WAX TINY SMALL WARM STEADY)
        (DESC "toy candle")
        (LDESC "A tiny toy candle burns with a warm, steady flame. It is the only light in the den.")
        (FLAGS LIGHTBIT FLAMEBIT NDESCBIT)
        (ACTION TOY-CANDLE-F)>

<OBJECT STRING-BALL
        (IN FOX-DEN)
        (SYNONYM BALL YARN STRING)
        (ADJECTIVE RED YARN FRAYED)
        (DESC "ball of yarn")
        (INTERACTIONS "GIVE-TO:NUTMEG;GIVE:NUTMEG")
        (LDESC "A ball of red [[yarn]] sits here.")
        (FLAGS NDESCBIT TAKEBIT)
        (SIZE 2)
        (ACTION STRING-BALL-F)>

; === OBJECTS: TOLLIVER-STUDY ===

<OBJECT TOLLIVER-COAT
        (IN TOLLIVER-STUDY)
        (SYNONYM COAT JACKET)
        (ADJECTIVE WORN OLD TOLLIVER TWEED GRANDFATHER WARM)
        (DESC "worn coat")
        (LDESC "Grandfather's [[coat]] lies here.")
        (FLAGS NDESCBIT TAKEBIT)
        (SIZE 8)
        (ACTION TOLLIVER-COAT-F)>

<OBJECT TEA-CUP
        (IN TOLLIVER-STUDY)
        (SYNONYM CUP TEA MUG)
        (ADJECTIVE COLD STONE DUSTY BITTER)
        (DESC "cold cup of tea")
        (LDESC "A [[cup of tea->cup]] sits here.")
        (FLAGS NDESCBIT TAKEBIT)
        (SIZE 2)
        (ACTION TEA-CUP-F)>

<OBJECT STUDY-DESK
        (IN TOLLIVER-STUDY)
        (SYNONYM DESK TABLE PAPERS)
        (ADJECTIVE WOODEN CLUTTERED STUDY)
        (DESC "cluttered wooden desk")
        (FLAGS NDESCBIT SURFACEBIT CONTBIT OPENBIT)
        (CAPACITY 40)
        (ACTION STUDY-DESK-F)>

<OBJECT DIAGRAM
        (IN STUDY-DESK)
        (SYNONYM DIAGRAM DRAWING PAPER PLAN)
        (ADJECTIVE WINDING HAND-DRAWN PENCILLED)
        (DESC "winding diagram")
        (INTERACTIONS "")
        (LDESC "A hand-drawn [[diagram]] of the workshop's inner workings lies here.")
        (FLAGS NDESCBIT TAKEBIT READBIT)
        (SIZE 3)
        (ACTION DIAGRAM-F)>

<OBJECT STUDY-JOURNAL
        (IN STUDY-DESK)
        (SYNONYM JOURNAL DIARY NOTEBOOK)
        (ADJECTIVE FINAL OPEN TOLLIVER GRANDFATHER)
        (DESC "open journal")
        (INTERACTIONS "")
        (LDESC "Tolliver's [[journal]] lies open to the final entry.")
        (FLAGS NDESCBIT TAKEBIT READBIT)
        (SIZE 5)
        (TEXT "I cannot wind the heart alone. The magic has grown weak, and I am old. But Pip — dear Pip — is still small enough to reach the heart chamber. If the key is found, and if Pip has made friends along the way, then perhaps the heart can beat again. I have left the key in the workshop. I only hope it is enough. — G.T.")
        (ACTION STUDY-JOURNAL-F)>

<OBJECT STUDY-CHR
        (IN TOLLIVER-STUDY)
        (SYNONYM CHAIR SEAT)
        (ADJECTIVE WOODEN OLD)
        (DESC "wooden chair")
        (LDESC "An old wooden chair sits behind the desk. Tolliver's coat hangs on its back.")
        (FLAGS NDESCBIT)
        (ACTION STUDY-CHR-F)>

; === OBJECTS: WORKSHOP-HEART ===

<OBJECT HEART-MECH
        (IN WORKSHOP-HEART)
        (SYNONYM MECHANISM HEART CLOCKWORK GEARS)
        (ADJECTIVE GIANT CENTRAL BRASS CLOCKWORK WORKSHOP VAST SILENT STILL)
        (DESC "workshop heart")
        (INTERACTIONS "WIND:WORKSHOP-KEY")
        (DESCFCN HEART-DESC-F)
        (ACTION HEART-MECH-F)>

;"The keyhole stands in the room, not inside the heart: the heart is no
  container, so the parser could not see into it."
<OBJECT KEY-SLOT
        (IN WORKSHOP-HEART)
        (SYNONYM SLOT KEYHOLE HOLE)
        (ADJECTIVE BRASS KEY HEART)
        (DESC "brass keyhole")
        (LDESC "A brass keyhole gleams at the heart mechanism's centre. It is exactly the right size for the workshop key.")
        (FLAGS NDESCBIT)
        (ACTION KEY-SLOT-F)>

<OBJECT SILENT-TOYS
        (IN WORKSHOP-HEART)
        (SYNONYM TOYS FIGURES WITNESSES SOLDIERS DOLLS ANIMALS)
        (ADJECTIVE SILENT MOTIONLESS FROZEN TOY WOODEN PAINTED DULL)
        (DESC "silent toys")
        (LDESC "Dozens of toys stand motionless around the heart, waiting for the magic to return.")
        (FLAGS NDESCBIT)
        (ACTION SILENT-TOYS-F)>

; === LOCAL-GLOBALS ===

<OBJECT BAKERY
    (IN LOCAL-GLOBALS)
    (SYNONYM BAKERY SHOP SHOPFRONT)
    (ADJECTIVE ABANDONED OLD FROSTED)
    (DESC "bakery")
    (FLAGS NDESCBIT)
    (ACTION BAKERY-F)>

<OBJECT WORKSHOP-BUILDING
    (IN LOCAL-GLOBALS)
    (SYNONYM BUILDING WORKSHOP SHOP)
    (ADJECTIVE OLD COSY TOY TOLLIVER FROSTED)
    (DESC "workshop building")
    (FLAGS NDESCBIT)
    (ACTION WORKSHOP-BUILDING-F)>

<OBJECT MOON
    (IN LOCAL-GLOBALS)
    (SYNONYM MOON SKY)
    (ADJECTIVE WINTER BRIGHT PALE)
    (DESC "winter moon")
    (FLAGS NDESCBIT)
    (ACTION MOON-F)>

<OBJECT COBBLER
    (IN LOCAL-GLOBALS)
    (SYNONYM COBBLER SHOP SHOPFRONT SHOES BOOTS SLIPPERS)
    (ADJECTIVE OLD ABANDONED COBBLERS DUSTY)
    (DESC "cobbler's shop")
    (FLAGS NDESCBIT)
    (ACTION COBBLER-F)>

; === TOPIC OBJECTS (for ASK/TELL interaction) ===

<OBJECT TOPIC-TOLLIVER
    (IN LOCAL-GLOBALS)
    (SYNONYM TOLLIVER GRANDFATHER MAKER TOYMAKER)
    (ADJECTIVE OLD KIND GRANDFATHER)
    (DESC "Grandfather Tolliver")
    (FLAGS NDESCBIT)>

<OBJECT TOPIC-KEY
    (IN LOCAL-GLOBALS)
    (SYNONYM KEY)
    (ADJECTIVE WORKSHOP MAGIC)
    (DESC "workshop key")
    (FLAGS NDESCBIT)>

<OBJECT TOPIC-FOX
    (IN LOCAL-GLOBALS)
    (SYNONYM FOX NUTMEG)
    (ADJECTIVE PATCHY LONELY)
    (DESC "the fox")
    (FLAGS NDESCBIT)>

<OBJECT TOPIC-HEART
    (IN LOCAL-GLOBALS)
    (SYNONYM HEART MAGIC)
    (ADJECTIVE WORKSHOP CLOCKWORK)
    (DESC "workshop heart")
    (FLAGS NDESCBIT)>

<OBJECT COUNTER-STEPS (IN COUNTERTOP) (DESC "steps down")
    (SYNONYM STEPS STAIRS CRATE) (ADJECTIVE MAKESHIFT WOODEN)
    (FLAGS NDESCBIT) (INTERACTIONS "")
    (TEXT "From up here Pip can see the three landings: a stack of books, a chair seat, then a crate. The crate looks very small indeed.")
    (ACTION COUNTER-STEPS-F)>

<OBJECT LOFT-RUNGS (IN STORAGE-LOFT) (DESC "loft ladder")
    (SYNONYM LADDER RUNGS) (ADJECTIVE LOFT WOODEN)
    (FLAGS NDESCBIT) (INTERACTIONS "")
    (TEXT "The top rung is smooth where Tolliver used to hook his thumb to pull himself into the loft.")
    (ACTION LOFT-RUNGS-F)>

<OBJECT SQUARE-PATHS (IN CLOCK-SQUARE) (DESC "cobbled paths")
    (SYNONYM PATHS PATH COBBLES) (ADJECTIVE COBBLED WINDING)
    (FLAGS NDESCBIT) (INTERACTIONS "")
    (TEXT "The cobbles are tiny wooden blocks set on end. A red [[paint mark]] points toward the mailbox.")>

<OBJECT MAILBOX-SNOW (IN MAILBOX-CORNER) (DESC "drifted snow")
    (SYNONYM SNOW DRIFT) (ADJECTIVE DRIFTED FRESH)
    (FLAGS NDESCBIT) (INTERACTIONS "")
    (TEXT "Snow has banked up on the windy side of the post. The fox tracks shelter in its lee.")>

<OBJECT CART-TRACK (IN SCRAP-YARD) (DESC "rusted track")
    (SYNONYM TRACK RAIL RAILS) (ADJECTIVE RUSTED IRON)
    (FLAGS NDESCBIT) (INTERACTIONS "")
    (TEXT "Two rails curve under the cart. There is just enough room beyond the gate for all four [[wheels->cart wheels]].")>

<OBJECT DEN-ENTRANCE (IN FOX-DEN) (DESC "den entrance")
    (SYNONYM ENTRANCE OPENING) (ADJECTIVE DEN NARROW)
    (FLAGS NDESCBIT) (INTERACTIONS "")
    (TEXT "Rusty wire ends have been bent away from the opening, so a patch of fur can slip through without snagging.")>

<OBJECT STUDY-STAIRS (IN TOLLIVER-STUDY) (DESC "study stairs")
    (SYNONYM STAIRS STAIRCASE STEPS) (ADJECTIVE STUDY NARROW)
    (FLAGS NDESCBIT) (INTERACTIONS "")
    (TEXT "The treads fit Pip’s boots. At the far end the clock case hides them from anyone looking up from the workshop.")
    (ACTION STUDY-STAIRS-F)>

<OBJECT DISTANT-TICK (IN TOLLIVER-STUDY) (DESC "distant ticking")
    (SYNONYM TICKING TICK SOUND) (ADJECTIVE DISTANT FAINT)
    (FLAGS NDESCBIT) (INTERACTIONS "")
    (TEXT "Pip puts an ear to the floor. This tick comes up through the boards from below the desk.")
    (ACTION DISTANT-TICK-F)>

<OBJECT HEART-PASSAGE (IN WORKSHOP-HEART) (DESC "heart passage")
    (SYNONYM PASSAGE TUNNEL) (ADJECTIVE NARROW BRASS HEART)
    (FLAGS NDESCBIT) (INTERACTIONS "")
    (TEXT "Brass pipes run along both sides of the passage. Pip can follow them uphill to Grandfather’s study.")>

<OBJECT DETAIL-SAILBOAT (IN WORKBENCH-TOP) (DESC "sailboat")
    (SYNONYM SAILBOAT BOAT HULL MAST) (ADJECTIVE WOODEN UNFINISHED)
    (FLAGS NDESCBIT) (INTERACTIONS "")
    (TEXT "Pip tips the hull. A round hole goes right through the deck for a mast, and Grandfather has already tied a sail small enough to fit.")
    (ACTION DETAIL-SAILBOAT-F)>

<OBJECT DETAIL-WOODEN-TRAIN (IN WORKBENCH-TOP) (DESC "wooden train")
    (SYNONYM TRAIN ENGINE WHEELS) (ADJECTIVE WOODEN RED)
    (FLAGS NDESCBIT) (INTERACTIONS "")
    (TEXT "All the red wheels turn together except the last one. A pencil cross marks the axle Grandfather still meant to fix.")
    (ACTION DETAIL-WOODEN-TRAIN-F)>

<OBJECT DETAIL-WOODEN-DUCK (IN WORKBENCH-TOP) (DESC "wooden duck")
    (SYNONYM DUCK AXLE WHEEL) (ADJECTIVE WOODEN MISSING)
    (FLAGS NDESCBIT) (INTERACTIONS "")
    (TEXT "Under the tilted wing, a stub of axle pokes out. The duck’s good wheel is painted orange, just like its beak.")
    (ACTION DETAIL-WOODEN-DUCK-F)>

<OBJECT DETAIL-HAMMER (IN TOOL-BENCH) (DESC "hammer")
    (SYNONYM HAMMER MALLET HAMMERS) (ADJECTIVE TINY JEWELLER'S)
    (FLAGS NDESCBIT TAKEBIT) (INTERACTIONS "")
    (TEXT "One end of the head is round as a bead. The other is flat and small enough to tap a nail into a toy shoe.") (ACTION RACK-TOOL-F)>

<OBJECT DETAIL-BRASS-LATCH (IN COUNTERTOP) (DESC "brass latch")
    (SYNONYM LATCH TONGUE) (ADJECTIVE BRASS SMALL)
    (FLAGS NDESCBIT) (INTERACTIONS "")
    (ACTION LATCH-F)
    (TEXT "A thin tongue of brass hooks over the edge of the glass. A crescent worn into its end fits Pip’s thumb.")>

<OBJECT DETAIL-PAINT-MARK (IN CLOCK-SQUARE) (DESC "paint mark")
    (SYNONYM MARK PAINT ARROW) (ADJECTIVE RED PAINT)
    (FLAGS NDESCBIT) (INTERACTIONS "")
    (TEXT "Two brushstrokes make an arrow. The second stroke skids across a crack between the cobbles.")
    (ACTION DETAIL-PAINT-MARK-F)>

<OBJECT DETAIL-AXLES (IN SCRAP-YARD) (DESC "axles")
    (SYNONYM AXLES AXLE GREASE) (ADJECTIVE OILED CART)
    (FLAGS NDESCBIT) (INTERACTIONS "")
    (TEXT "The ends shine through the old rust. Whoever looks after this cart put one neat drop of oil on each end.")>

<OBJECT MUSIC-TOOTH (DESC "brass tooth")
    (SYNONYM TOOTH TINE COMB) (ADJECTIVE BRASS LITTLE)
    (FLAGS NDESCBIT) (INTERACTIONS "")
    (TEXT "A pin lifts the tooth and lets go. Pip can feel it trembling for a moment after the note has died away.")
    (ACTION MUSIC-TOOTH-F)>

<OBJECT CART-WHEELS (IN SCRAP-YARD) (DESC "cart wheels")
    (SYNONYM WHEELS WHEEL RIMS RIM) (ADJECTIVE CART IRON RUSTED)
    (FLAGS NDESCBIT) (INTERACTIONS "")
    (ACTION CART-WHEELS-F)>

<OBJECT TOY-CHISELS (IN TOOL-BENCH) (DESC "chisels")
    (SYNONYM CHISELS CHISEL) (ADJECTIVE TINY)
    (FLAGS NDESCBIT TAKEBIT) (INTERACTIONS "")
    (TEXT "The widest blade is only as wide as Pip’s little fingernail. A curl of wood still clings to the narrowest one.") (ACTION RACK-TOOL-F)>

<OBJECT TOY-FILES (IN TOOL-BENCH) (DESC "needle-files")
    (SYNONYM NEEDLE-FILES FILES FILE NEEDLE-FILE) (ADJECTIVE FINE)
    (FLAGS NDESCBIT TAKEBIT) (INTERACTIONS "")
    (TEXT "Pip runs a nail down the handles. One has a round end for smoothing holes, one a flat end for the space between two gear teeth.") (ACTION RACK-TOOL-F)>
