<ROUTINE V-VERSION ()
 <TELL "The Library of Borrowed Tomorrows|Studio Null, 2026|Release " N ,RELEASEID CR>>

<ROUTINE GO ()
 <V-VERSION> <CRLF>
 <SETG COMPACT-ROOM-LISTS T>
 <SETG HERE ,LENDING> <SETG VERBOSE T> <SETG LIT T>
 <SETG WINNER ,ADVENTURER> <SETG PLAYER ,WINNER> <MOVE ,WINNER ,HERE>
 <TELL "You promised to bring tomorrow to the market. It was an easy promise when you thought tomorrow came by itself." CR CR>
 <TELL D ,HERE CR>
 <V-LOOK> <MAIN-LOOP> <AGAIN>>

<ROUTINE LENDING-F (R)
 <COND (<EQUAL? .R ,M-LOOK>
        <TELL "Someone has pushed the [[lending cabinet]] right up to the window. ">
        <COND (,ON-LOAN <TELL "The window admits exactly one day of light. Nothing follows it.">)
              (T <TELL "A narrow stripe of tomorrow's sun lies beside today's.">)>
        <TELL " The folding room is [[east]], the basin [[north]]." CR>)>>
<ROUTINE FOLDING-F (R)
 <COND (<EQUAL? .R ,M-LOOK>
        <TELL "The wooden [[folding board]] is worn at its edges and almost new in the middle. The hall is [[west]]; stairs lead [[north]] to the reading terrace." CR>)>>
<ROUTINE BASIN-F (R)
 <COND (<EQUAL? .R ,M-LOOK>
        <COND (,ON-LOAN <TELL "Every drop has backed out of the [[stone trough]], even the one that was falling.">)
              (T <TELL "Water edges along the [[stone trough]] in the direction of the market.">)>
        <TELL " An old [[loan receipt]] has been pressed flat against the stone. The hall is [[south]]; the terrace [[east]]." CR>)>>
<ROUTINE TERRACE-F (R)
 <COND (<EQUAL? .R ,M-LOOK>
        <TELL "A [[reading frame]] faces the market.">
        <COND (<IN? ,LEAF ,FRAME> <TELL " The [[tomorrow leaf]] lifts at both corners, like a child getting ready to jump.">)
              (,ON-LOAN <TELL " Below, the market's shadows have stopped getting longer.">)
              (T <TELL " Below, the market's shadows are growing longer.">)>
        <TELL " The folding room is [[south]] and the basin [[west]]." CR>)>>

<ROUTINE CASE-F ()
 <COND (<AND <VERB? OPEN> <NOT <FSET? ,CASE ,OPENBIT>>>
        <FSET ,CASE ,OPENBIT>
        <COND (<IN? ,LEAF ,CASE> <TELL "You open the cabinet. Inside lies a [[tomorrow leaf]]." CR>)
              (T <TELL "You open the empty cabinet." CR>)>)
       (<VERB? EXAMINE>
        <COND (<FSET? ,CASE ,OPENBIT>
               <COND (<IN? ,LEAF ,CASE> <TELL "One [[tomorrow leaf]] lies in the open cabinet." CR>)
                     (T <TELL "The open cabinet holds only the shape left by a piece of paper." CR>)>)
              (T <TELL "The cabinet is closed. Its label says ONE DAY PER BORROWER." CR>)>)
       (<AND <VERB? PUT> <EQUAL? ,PRSI ,CASE> <EQUAL? ,PRSO ,LEAF>>
        <COND (<NOT <FSET? ,CASE ,OPENBIT>> <TELL "Open the cabinet first." CR>)
              (T <MOVE ,LEAF ,CASE> <SETG ON-LOAN <>> <SETG WIDE-LOAN <>>
                 <TELL "The cabinet folds the leaf to its old size. The extra stripe of sun returns to the floor." CR>)>)>>
<ROUTINE BOARD-F ()
 <COND (<VERB? EXAMINE READ>
        <SETG BOARD-READ T>
        <TELL "The instructions are worked into the board: LAY A LEAF ON THE BOARD, GOLD SIDE UP. TO SHARE YOUR DAY, OPEN THE OLD FOLDS. There has never been a rule against opening them.">
        <COND (<HELD? ,LEAF> <TELL " You have the [[tomorrow leaf]] in your hand.">)>
        <CRLF>)
       (<AND <VERB? PUT PUT-ON> <EQUAL? ,PRSI ,BOARD> <EQUAL? ,PRSO ,LEAF>>
        <COND (,WIDE-LOAN <TELL "You've already opened every fold." CR>)
              (T <SETG WIDE-LOAN T>
                 <TELL "You lay down the [[tomorrow leaf]] and flatten the old folds with your palm. The little square opens to the width of your arms. Your name is still there, with room alongside it. You lift it back up." CR>)>)>>
<ROUTINE RECEIPT-F ()
 <COND (<VERB? EXAMINE READ>
        <SETG RECEIPT-READ T>
        <TELL "An old warning: SUN ON A PRIVATE LOAN IS SUN THE VILLAGE CAN'T USE. FOR EVERYONE, FIT AN UNFOLDED PAGE IN THE FRAME AND READ FROM THE FRAME. Below that, in a different hand: I was here first." CR>)>>
<ROUTINE RILL-F ()
 <COND (<VERB? EXAMINE LISTEN>
        <COND (,ON-LOAN <TELL "The stone gives back the hollow sound of a cup with nothing in it." CR>)
              (T <TELL "Water travels along the trough and off toward the market. It makes a sound like pages turning." CR>)>)>>
<ROUTINE FRAME-F ()
 <COND (<VERB? EXAMINE>
        <TELL "Two clips span the frame. They're too far apart to hold the ordinary square of paper.">
        <COND (<IN? ,LEAF ,FRAME> <TELL " The [[tomorrow leaf]] fits them both.">)
              (<AND <HELD? ,LEAF> ,WIDE-LOAN> <TELL " The wide [[tomorrow leaf]] might fit them both.">)>
        <CRLF>)
       (<VERB? READ>
        <COND (<IN? ,LEAF ,FRAME> <PUBLISH-LOAN>)
              (T <TELL "There isn't a page in the frame yet." CR>)>)
       (<AND <VERB? PUT PUT-ON> <EQUAL? ,PRSO ,LEAF> <EQUAL? ,PRSI ,FRAME>>
        <COND (,WIDE-LOAN <MOVE ,LEAF ,FRAME> <TELL "Both clips hold. The [[tomorrow leaf]] points toward the roofs." CR>)
              (T <TELL "The leaf won't reach the second clip. You keep hold of it." CR>)>)>>
<ROUTINE LEAF-F ()
 <COND (<AND <VERB? TAKE> <IN? ,LEAF ,CASE>>
        <COND (<FSET? ,CASE ,OPENBIT>
               <MOVE ,LEAF ,WINNER> <SETG ON-LOAN T>
               <TELL "The leaf records your name. One of the two stripes of light goes out so neatly that for a moment you think you blinked." CR>)>)
       (<VERB? EXAMINE>
        <COND (,WIDE-LOAN <TELL "Your name takes up one corner of the wide gold page. The rest is blank." CR>)
              (T <TELL "A tightly folded page with one box for one name." CR>)>)
       (<VERB? READ>
        <COND (<IN? ,LEAF ,FRAME> <PUBLISH-LOAN>)
              (<IN? ,LEAF ,CASE> <TELL "Through the open door you can make out the word TOMORROW and one box for one name." CR>)
              (T <TELL "It says TOMORROW, just under your name. Nothing happens when you read it here." CR>)>)>>
<ROUTINE PUBLISH-LOAN ()
 <TELL "You read the only word: TOMORROW. A hundred names come back from the market. Outside the bakery, someone takes back a chair they were about to put away." CR CR
       "THE END -- ROOM FOR EVERY NAME" CR>
 <FINISH> <RTRUE>>
<ROUTINE V-SCORE ("OPTIONAL" (ASK? T))
 <COND (<IN? ,LEAF ,FRAME> <TELL "Library record: a day shared." CR>)
       (,ON-LOAN <TELL "Library record: one day on loan." CR>)
       (T <TELL "Library record: no loans outstanding." CR>)>>
