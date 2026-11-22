"Wondertown complete walkthrough: from the empty key hook to the rewound heart"

<INSERT-FILE "books/wondertown/wondertown">

<GLOBAL CO <CO-CREATE GO>>

<ROUTINE RUN-TEST ()
    ;"Act 1 -- the workshop"
    <ASSERT "Start on the workshop floor" <CO-RESUME ,CO "look" T> <==? ,HERE ,,WORKSHOP-FLOOR>>
    <ASSERT-TEXT "holds no key" <CO-RESUME ,CO "examine hook">> ;"The workshop key is gone"
    <ASSERT "Take the chewed string" <CO-RESUME ,CO "take string" T> <==? <LOC ,KEY-STRING> ,ADVENTURER>>
    <ASSERT "Oil can is hidden under the bench" <FSET? ,OIL-CAN ,INVISIBLE>>
    <ASSERT-TEXT "oil can" <CO-RESUME ,CO "look under workbench">> ;"The copper glint is the oil can"
    <ASSERT "Take oil can" <CO-RESUME ,CO "take oil can" T> <==? <LOC ,OIL-CAN> ,ADVENTURER>>
    <ASSERT-TEXT "will not rise" <CO-RESUME ,CO "climb ladder">> ;"The loft ladder is rusted"
    <ASSERT "Still on the floor" <==? ,HERE ,WORKSHOP-FLOOR>>
    <ASSERT "Oil the ladder mechanism" <CO-RESUME ,CO "lubricate mechanism"> ,LADDER-OILED>

    ;"The loft: Old Tick, the journal, the repair box"
    <ASSERT "Climb to the loft" <CO-RESUME ,CO "climb ladder"> <==? ,HERE ,STORAGE-LOFT>>
    <ASSERT-TEXT "heart needs attention" <CO-RESUME ,CO "read journal">> ;"Tolliver worried about the heart"
    <ASSERT "Journal read" ,JOURNAL-READ>
    <ASSERT-TEXT "only the fox knows" <CO-RESUME ,CO "wind clock">> ;"Old Tick names the fox"
    <ASSERT "Old Tick is awake" ,OLD-TICK-HEARD>
    <ASSERT "No way to the study yet" <NOT ,STUDY-ACCESS>>
    <ASSERT "Open the repair box" <CO-RESUME ,CO "open cardboard box"> <FSET? ,TOY-BOX ,OPENBIT>>
    <ASSERT "Take doll arm" <CO-RESUME ,CO "take arm" T> <==? <LOC ,DOLL-ARM> ,ADVENTURER>>
    <ASSERT "Back down the ladder" <CO-RESUME ,CO "walk down" T> <==? ,HERE ,WORKSHOP-FLOOR>>

    ;"The tool bench: Captain Bertrand"
    <ASSERT "Go to the tool bench" <CO-RESUME ,CO "walk east" T> <==? ,HERE ,TOOL-BENCH>>
    <ASSERT-TEXT "block the chair seat" <CO-RESUME ,CO "climb steps">> ;"The frozen nutcracker bars the way"
    <ASSERT "Still at the tool bench" <==? ,HERE ,TOOL-BENCH>>
    <ASSERT-TEXT "at your service" <CO-RESUME ,CO "wind nutcracker">> ;"The key in his back winds him"
    <ASSERT "Bertrand is wound" ,BERTRAND-WOUND>
    <ASSERT "Pip keeps the winding key" <==? <LOC ,BERTRAND-KEY> ,ADVENTURER>>

    ;"The countertop: Marzipan and the display case"
    <ASSERT "Climb to the countertop" <CO-RESUME ,CO "climb steps"> <==? ,HERE ,COUNTERTOP>>
    <ASSERT-TEXT "Fox feet" <CO-RESUME ,CO "tell doll about fox">> ;"Marzipan sings of the fox"
    <ASSERT "Take button" <CO-RESUME ,CO "take button" T> <==? <LOC ,BUTTON> ,ADVENTURER>>
    <ASSERT-TEXT "hidden latch" <CO-RESUME ,CO "give button to doll">> ;"Her second eye earns the clock's secret"
    <ASSERT "Marzipan has her button" ,MARZIPAN-BUTTON>
    <ASSERT-TEXT "behind the glass" <CO-RESUME ,CO "wind music box">> ;"The case is shut"
    <ASSERT "Open display case" <CO-RESUME ,CO "open case"> <FSET? ,DISPLAY-CASE ,OPENBIT>>
    <ASSERT "Take soldier" <CO-RESUME ,CO "take tin soldier" T> <==? <LOC ,TIN-SOLDIER> ,ADVENTURER>>
    <ASSERT "Take music box" <CO-RESUME ,CO "take music box" T> <==? <LOC ,MUSIC-BOX> ,ADVENTURER>>
    <ASSERT "Down to the tool bench" <CO-RESUME ,CO "walk down" T> <==? ,HERE ,TOOL-BENCH>>
    <ASSERT "Back to the workshop floor" <CO-RESUME ,CO "walk west" T> <==? ,HERE ,WORKSHOP-FLOOR>>
    <ASSERT-TEXT "no way behind it yet" <CO-RESUME ,CO "enter clock">> ;"The workshop clock is still shut"

    ;"Act 2 -- Wrenfold by night"
    <ASSERT "Through the pet door" <CO-RESUME ,CO "walk north" T> <==? ,HERE ,SNOWY-ALLEY>>
    <ASSERT-TEXT "toy-sized" <CO-RESUME ,CO "examine footprints">> ;"Fox tracks lead east"
    <ASSERT "Go to clock square" <CO-RESUME ,CO "walk east" T> <==? ,HERE ,CLOCK-SQUARE>>
    <ASSERT-TEXT "extra hours" <CO-RESUME ,CO "wind mechanism">> ;"Standing on the tin soldier, Pip slows the tower"
    <ASSERT "Tower wound" ,TOWER-WOUND>
    <ASSERT "The night is longer now" <G? ,TICK-COUNT 200>>
    <ASSERT "Go to mailbox corner" <CO-RESUME ,CO "walk east" T> <==? ,HERE ,MAILBOX-CORNER>>
    <ASSERT-TEXT "south to the scrap-yard" <CO-RESUME ,CO "tell mailbox about footprints">> ;"The mailbox saw the fox"
    <ASSERT-TEXT "heart is failing" <CO-RESUME ,CO "read letter">> ;"Tolliver's letter to Pip"
    <ASSERT "Letter read" ,LETTER-READ>
    <ASSERT "Take scarf" <CO-RESUME ,CO "take scarf" T> <==? <LOC ,SCARF> ,ADVENTURER>>
    <ASSERT "Back to the square" <CO-RESUME ,CO "walk west" T> <==? ,HERE ,CLOCK-SQUARE>>

    ;"The scrap-yard: the cart that rescues toys"
    <ASSERT "Go to scrap-yard" <CO-RESUME ,CO "walk south" T> <==? ,HERE ,SCRAP-YARD>>
    <CO-RESUME ,CO "walk east" T>
    <ASSERT "The cart blocks the gate" <==? ,HERE ,SCRAP-YARD>>
    <ASSERT "Doll head is hidden in the piles" <FSET? ,DOLL-HEAD ,INVISIBLE>>
    <ASSERT-TEXT "doll head" <CO-RESUME ,CO "search piles">> ;"The head lies under the snowy scrap"
    <ASSERT "Take doll head" <CO-RESUME ,CO "take head" T> <==? <LOC ,DOLL-HEAD> ,ADVENTURER>>
    <ASSERT-TEXT "rescuing them" <CO-RESUME ,CO "examine cart">> ;"The cart is no enemy"
    <ASSERT-TEXT "rolls aside" <CO-RESUME ,CO "give head to cart">> ;"Kindness moves the cart"
    <ASSERT "Cart moved" ,CART-MOVED>
    <ASSERT "The head rests in the cart" <==? <LOC ,DOLL-HEAD> ,SCRAP-CART>>

    ;"The fox den: Nutmeg"
    <ASSERT "Enter fox den" <CO-RESUME ,CO "walk east" T> <==? ,HERE ,FOX-DEN>>
    <ASSERT-TEXT "snatches the key back" <CO-RESUME ,CO "take workshop key">> ;"She will not give it up yet"
    <ASSERT "Key not yet found" <NOT ,KEY-FOUND>>
    <ASSERT "Take yarn" <CO-RESUME ,CO "take yarn" T> <==? <LOC ,STRING-BALL> ,ADVENTURER>>
    <ASSERT "Give yarn to fox" <CO-RESUME ,CO "give yarn to fox"> <G? ,NUTMEG-TRUST 0>>
    <ASSERT "Give scarf to fox" <CO-RESUME ,CO "give scarf to fox"> <==? <LOC ,SCARF> ,NUTMEG>>
    <ASSERT "Two gifts given" <==? ,NUTMEG-GIFTS 2>>
    <ASSERT-TEXT "he fixed me once" <CO-RESUME ,CO "tell fox about tolliver">> ;"Nutmeg remembers the toymaker"
    <ASSERT-TEXT "Take it" <CO-RESUME ,CO "take workshop key">> ;"Trust earned"
    <ASSERT "Key found" ,KEY-FOUND>
    <ASSERT "Pip carries the workshop key" <==? <LOC ,WORKSHOP-KEY> ,ADVENTURER>>
    <ASSERT-TEXT "wind him again" <CO-RESUME ,CO "tell fox">> ;"Nutmeg says where to meet"

    ;"Return to the workshop"
    <ASSERT "Leave the den" <CO-RESUME ,CO "walk west" T> <==? ,HERE ,SCRAP-YARD>>
    <ASSERT "Square" <CO-RESUME ,CO "walk north" T> <==? ,HERE ,CLOCK-SQUARE>>
    <ASSERT "Alley" <CO-RESUME ,CO "walk west" T> <==? ,HERE ,SNOWY-ALLEY>>
    <ASSERT "Workshop" <CO-RESUME ,CO "walk south" T> <==? ,HERE ,WORKSHOP-FLOOR>>

    ;"Act 3 -- Old Tick calls Nutmeg, the study opens"
    <ASSERT "Up to the loft" <CO-RESUME ,CO "walk up" T> <==? ,HERE ,STORAGE-LOFT>>
    <ASSERT-TEXT "It has swung open" <CO-RESUME ,CO "wind clock">> ;"Nutmeg reaches the hidden latch"
    <ASSERT "Study access" ,STUDY-ACCESS>
    <ASSERT "Down to the workshop" <CO-RESUME ,CO "walk down" T> <==? ,HERE ,WORKSHOP-FLOOR>>
    <ASSERT-TEXT "stairs behind the open clock" <CO-RESUME ,CO "look">> ;"The room shows the open clock"
    <ASSERT "Enter study" <CO-RESUME ,CO "enter clock"> <==? ,HERE ,TOLLIVER-STUDY>>
    <ASSERT-TEXT "surround the heart with companions" <CO-RESUME ,CO "read diagram">> ;"How to rewind the heart"
    <ASSERT "Diagram read" ,DIAGRAM-READ>
    <ASSERT-TEXT "proud of you" <CO-RESUME ,CO "read open journal">> ;"Tolliver's last entry"
    <ASSERT "Study journal read" ,STUDY-JOURNAL-READ>

    ;"The workshop heart"
    <ASSERT "Go to heart" <CO-RESUME ,CO "walk down" T> <==? ,HERE ,WORKSHOP-HEART>>
    <ASSERT-TEXT "not yet wound" <CO-RESUME ,CO "position tin soldier">> ;"Companions wait for the key"
    <ASSERT-TEXT "The heart is beating" <CO-RESUME ,CO "wind heart">>
    <ASSERT "Heart wound" ,KEY-WOUND>
    <ASSERT "Not won by winding alone" <NOT ,GAME-WON>>
    <ASSERT-TEXT "Standing guard" <CO-RESUME ,CO "position tin soldier">> ;"Soldier and Nutmeg join the heart"
    <ASSERT "Nutmeg joined" ,NUTMEG-SAVED>
    <ASSERT "Two companions" <==? ,COMPANION-COUNT 2>>
    <ASSERT "Soldier stands by the heart" <==? <LOC ,TIN-SOLDIER> ,WORKSHOP-HEART>>
    <ASSERT-TEXT "Pip has restored the heart of Wrenfold" <CO-RESUME ,CO "position music box">>

    ;"Game won"
    <ASSERT "Game won" ,GAME-WON>
    <ASSERT "Full rewind ending" <==? ,ENDING-TIER 3>>
    <ASSERT "Three companions" <==? ,COMPANION-COUNT 3>>>
