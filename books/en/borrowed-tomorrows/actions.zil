<ROUTINE V-VERSION ()
 <TELL "The Library of Borrowed Tomorrows|Studio Null, 2026|Release " N ,RELEASEID CR>>

<ROUTINE GO ()
 <V-VERSION> <CRLF>
 <SETG COMPACT-ROOM-LISTS T>
 <SETG HERE ,LENDING> <SETG VERBOSE T> <SETG LIT T>
 <SETG WINNER ,ADVENTURER> <SETG PLAYER ,WINNER> <MOVE ,WINNER ,HERE>
 <TELL "This morning you promised the whole market that you would fetch tomorrow from the Library of Borrowed Tomorrows and bring it back to them. It was an easy promise, back when you thought tomorrow just came by itself. Now you are standing inside the library, the librarians are nowhere to be seen, and it is very, very quiet." CR CR>
 <TELL D ,HERE CR>
 <V-LOOK> <MAIN-LOOP> <AGAIN>>

<ROUTINE LENDING-F (R)
 <COND (<EQUAL? .R ,M-LOOK>
        <TELL "You are in the Lending Hall of the library, a tall, hushed room with a polished wooden floor. Someone has pushed a tall wooden [[lending cabinet]] right up against the big window. ">
        <COND (,ON-LOAN <TELL "Only one stripe of [[sunlight]] falls across the floor now, today's, and beside it the boards have gone grey and still.">)
              (T <TELL "Two stripes of [[sunlight]] fall across the floor: today's, and beside it a narrow golden stripe that must be tomorrow's.">)>
        <TELL " An arch to the [[east]] opens into the folding room, and a passage leads [[north]] to the dry basin." CR>)>>
<ROUTINE FOLDING-F (R)
 <COND (<EQUAL? .R ,M-LOOK>
        <TELL "This is the Folding Room, a small, bright room with almost nothing in it except a long wooden [[folding board]]. The board is worn smooth at its edges but looks almost new in the middle. The lending hall is back through the arch to the [[west]], and a staircase climbs [[north]] to the reading terrace." CR>)>>
<ROUTINE BASIN-F (R)
 <COND (<EQUAL? .R ,M-LOOK>
        <TELL "You are in the Dry Basin, a cool stone room where a long [[stone trough]] runs along one wall and out through a gap toward the market.">
        <COND (,ON-LOAN <TELL " The trough is empty now. Every drop has backed out of it, even the one that was falling, and the room is silent.">)
              (T <TELL " A thin stream of water edges along the trough toward the market with a soft, busy trickle.">)>
        <TELL " An old [[loan receipt]] has been pressed flat against the stone wall. The lending hall is back to the [[south]], and a doorway to the [[east]] opens onto the reading terrace." CR>)>>
<ROUTINE TERRACE-F (R)
 <COND (<EQUAL? .R ,M-LOOK>
        <TELL "You are on the Reading Terrace, a wide stone balcony high above the town. Far below lies the [[market]], with its striped stalls, the bakery and the crowded square. A brass [[reading frame]] stands at the railing, facing out over the market.">
        <COND (<IN? ,LEAF ,FRAME> <TELL " The [[tomorrow leaf]] is clipped in the frame, lifting at both corners like a child getting ready to jump.">)
              (,ON-LOAN <TELL " Down below, the shadows have stopped getting longer under the stalls, and people stand still, waiting for an evening that isn't coming.">)
              (T <TELL " Down below, the afternoon shadows are slowly growing longer.">)>
        <TELL " Stairs lead [[south]] down to the folding room, and a doorway to the [[west]] leads back to the dry basin." CR>)>>

<ROUTINE CASE-F ()
 <COND (<AND <VERB? OPEN> <NOT <FSET? ,CASE ,OPENBIT>>>
        <FSET ,CASE ,OPENBIT>
        <COND (<IN? ,LEAF ,CASE> <TELL "You open the cabinet's little door. Inside, all alone on the shelf, lies a [[tomorrow leaf]]." CR>)
              (T <TELL "You open the empty cabinet." CR>)>)
       (<VERB? EXAMINE>
        <COND (<FSET? ,CASE ,OPENBIT>
               <COND (<IN? ,LEAF ,CASE> <TELL "One [[tomorrow leaf]] lies on the shelf of the open cabinet. There's room for many more, but there is only one." CR>)
                     (T <TELL "The open cabinet holds only a pale, page-shaped patch where a piece of paper used to lie." CR>)>)
              (T <TELL "The cabinet is made of dark wood, with a little door that is closed. A brass label on the front says ONE DAY PER BORROWER." CR>)>)
       (<AND <VERB? PUT> <EQUAL? ,PRSI ,CASE> <EQUAL? ,PRSO ,LEAF>>
        <COND (<NOT <FSET? ,CASE ,OPENBIT>> <TELL "Open the cabinet first." CR>)
              (T <MOVE ,LEAF ,CASE> <SETG ON-LOAN <>> <SETG WIDE-LOAN <>>
                 <TELL "You return the leaf. The cabinet folds it back to its old small size, and the extra stripe of sun comes back to the floor." CR>)>)
       (<VERB? READ>
        <TELL "The brass label says ONE DAY PER BORROWER. Underneath, much smaller, someone has scratched: per borrower? or per town?" CR>)
       (<VERB? KNOCK>
        <COND (<AND <IN? ,LEAF ,CASE> <NOT <FSET? ,CASE ,OPENBIT>>>
               <TELL "Tock, tock. Inside, something light shifts on the shelf, like a page settling down." CR>)
              (T <TELL "Tock, tock. The cabinet sounds hollow." CR>)>)
       (<VERB? LISTEN>
        <COND (<IN? ,LEAF ,CASE> <TELL "With your ear to the wood you hear a faint rustle, like someone turning over in their sleep." CR>)
              (T <TELL "Nothing. The empty cabinet is as quiet as a closed book." CR>)>)
       (<VERB? SMELL>
        <TELL "Cedar wood and old paper, the smell of a drawer nobody has opened in years." CR>)
       (<VERB? MOVE PUSH TAKE>
        <TELL "You lean on the cabinet with all your weight. It's far too heavy to budge, and someone clearly pushed it against the window on purpose." CR>)
       (<VERB? LOOK-UNDER>
        <TELL "Only dust, and four long scrapes on the floor where the cabinet's feet were dragged to the window." CR>)>>
<ROUTINE STRIPES-F ()
 <COND (<VERB? EXAMINE>
        <COND (,ON-LOAN <TELL "Today's stripe of sunlight lies on the floor, ordinary and yellow. Next to it, where tomorrow's narrow golden stripe used to be, the boards look grey and cold." CR>)
              (T <TELL "Today's sunlight lies on the floor in a wide yellow stripe. Beside it runs a narrow stripe of deeper gold, coming in through the very same window. That must be tomorrow, shining a little early." CR>)>)
       (<VERB? RUB>
        <COND (,ON-LOAN <TELL "You put your hand where tomorrow's stripe used to be. The floor is cold, like a seat nobody has sat in." CR>)
              (T <TELL "You hold your hand in the golden stripe. It's warmer than today's light, like a promise someone means to keep." CR>)>)
       (<VERB? TAKE>
        <TELL "You try to scoop up a stripe of sunlight, but it just lies on top of your hands. Light doesn't come in pieces." CR>)
       (<VERB? LOOK-INSIDE OPEN CLOSE>
        <TELL "The big window doesn't open. Through it you can see the rooftops of the town, all waiting." CR>)>>
<ROUTINE BOARD-F ()
 <COND (<VERB? EXAMINE READ>
        <SETG BOARD-READ T>
        <TELL "Words are carved into the wood of the board: LAY A LEAF ON THE BOARD, GOLD SIDE UP. TO SHARE YOUR DAY, OPEN THE OLD FOLDS. Nothing anywhere says you aren't allowed to.">
        <COND (<HELD? ,LEAF> <TELL " You have the [[tomorrow leaf]] in your hand.">)>
        <CRLF>)
       (<AND <VERB? PUT PUT-ON> <EQUAL? ,PRSI ,BOARD> <EQUAL? ,PRSO ,LEAF>>
        <COND (,WIDE-LOAN <TELL "You've already opened every fold." CR>)
              (T <SETG WIDE-LOAN T>
                 <TELL "You lay the [[tomorrow leaf]] on the board, gold side up, and smooth the old folds open with your palm. Fold after fold lets go, and the little square opens out to the width of your arms. Your name is still there in its corner, with plenty of room alongside it now. You lift it back up carefully." CR>)>)
       (<VERB? RUB>
        <TELL "The edges are worn smooth by a thousand hands, but the middle still feels rough and new. People have folded things here for years. Hardly anyone has unfolded anything." CR>)
       (<VERB? KNOCK>
        <TELL "Tonk. Good solid wood. It would hold a whole sky's worth of paper." CR>)
       (<VERB? SMELL>
        <TELL "Beeswax and sawdust." CR>)
       (<VERB? LOOK-UNDER>
        <TELL "Underneath, the board stands on four sturdy legs. Nothing hides there except a little sawdust." CR>)
       (<VERB? TAKE MOVE>
        <TELL "The board is as long as a bed and bolted to the floor. It's meant to stay where people can use it." CR>)>>
<ROUTINE RECEIPT-F ()
 <COND (<VERB? EXAMINE READ>
        <SETG RECEIPT-READ T>
        <TELL "It's an old library receipt, written in careful letters: SUN ON A PRIVATE LOAN IS SUN THE VILLAGE CAN'T USE. FOR EVERYONE, FIT AN UNFOLDED PAGE IN THE FRAME AND READ FROM THE FRAME. Underneath, in a different, scratchier hand, someone has added: I was here first." CR>)
       (<VERB? TAKE MOVE>
        <TELL "It's stuck fast. It has been pressed against the stone so long that it's almost part of the wall." CR>)
       (<VERB? RUB>
        <TELL "The paper is thin and cool. The scratchy line at the bottom is pressed in deep, as if whoever wrote it was cross." CR>)
       (<VERB? SMELL>
        <TELL "Damp stone and old ink." CR>)>>
<ROUTINE RILL-F ()
 <COND (<VERB? EXAMINE>
        <COND (,ON-LOAN <TELL "The trough is completely dry. It looks as if the water stopped, turned around, and went back the way it came." CR>)
              (T <TELL "A long stone channel. Clear water travels along it, out through a gap in the wall and down toward the market." CR>)>)
       (<VERB? LISTEN>
        <COND (,ON-LOAN <TELL "Nothing at all. The stone gives back the hollow sound of a cup with nothing in it." CR>)
              (T <TELL "Water travels along the trough and off toward the market. It makes a sound like pages turning." CR>)>)
       (<VERB? RUB>
        <COND (,ON-LOAN <TELL "The stone is bone dry, and strangely warm, as if it is waiting." CR>)
              (T <TELL "The water is cool and runs over your fingers, tugging them gently toward the market." CR>)>)
       (<VERB? LOOK-INSIDE SEARCH>
        <COND (,ON-LOAN <TELL "Not a drop, not even a damp spot." CR>)
              (T <TELL "Your reflection ripples along with the water, hurrying off toward the market." CR>)>)
       (<VERB? SMELL>
        <TELL "Cold stone and river weed." CR>)>>
<ROUTINE FRAME-F ()
 <COND (<VERB? EXAMINE>
        <TELL "A brass stand with two clips, made to hold a page up for the whole market to see. The clips are set very far apart, much too far for an ordinary little folded page.">
        <COND (<IN? ,LEAF ,FRAME> <TELL " The [[tomorrow leaf]] fits them both.">)
              (<AND <HELD? ,LEAF> ,WIDE-LOAN> <TELL " The wide [[tomorrow leaf]] might fit them both.">)>
        <CRLF>)
       (<VERB? READ>
        <COND (<IN? ,LEAF ,FRAME> <PUBLISH-LOAN>)
              (T <TELL "There isn't a page in the frame yet." CR>)>)
       (<AND <VERB? PUT PUT-ON> <EQUAL? ,PRSO ,LEAF> <EQUAL? ,PRSI ,FRAME>>
        <COND (,WIDE-LOAN <MOVE ,LEAF ,FRAME> <FSET ,LEAF ,NDESCBIT> <TELL "You clip the wide page in. Both clips hold, and the [[tomorrow leaf]] points out toward the roofs of the town." CR>)
              (T <TELL "You try to clip the leaf in, but folded up like this it is far too small: it won't reach the second clip. You keep hold of it." CR>)>)
       (<VERB? RUB>
        <TELL "The brass is warm from the sun, and the clips snap shut with a cheerful click." CR>)
       (<VERB? MOVE PUSH>
        <TELL "The frame swivels a little on its base, then swings back to face the market. It knows who it's meant for." CR>)
       (<VERB? KNOCK>
        <TELL "Ting! The brass rings out over the railing, and far below a pigeon looks up." CR>)
       (<VERB? TAKE>
        <TELL "The frame is bolted to the terrace. It belongs up here, where everyone below can see it." CR>)>>
<ROUTINE MARKET-F ()
 <COND (<AND <VERB? EXAMINE> <NOT <EQUAL? ,HERE ,TERRACE>>>
        <TELL "Through the gap in the wall you can just see a slice of the market, far below: the corner of a striped stall and a strip of the square. You'd see much more from the reading terrace." CR>)
       (<VERB? EXAMINE>
        <COND (,ON-LOAN <TELL "From up here you can see the whole market. Nobody is packing up, and nobody is setting out anything new. The baker stands in her doorway, holding a chair, as if she can't decide whether there will be a tomorrow to put it out for." CR>)
              (T <TELL "From up here you can see the whole market: striped stalls, baskets of apples, the bakery with its door open, and people hurrying to finish before evening." CR>)>)
       (<VERB? LISTEN>
        <COND (,ON-LOAN <TELL "The market has gone strangely hushed. You can hear people asking each other, very quietly, what day it will be." CR>)
              (T <TELL "Up from the market come shouts, laughter, the creak of carts and someone calling out the price of plums." CR>)>)
       (<VERB? SMELL>
        <TELL "Warm bread from the bakery drifts all the way up here. Your stomach rumbles." CR>)
       (<VERB? TAKE>
        <TELL "The market is far below you, and much too big to carry. What it needs is something to read." CR>)>>
<ROUTINE HALL-ROOM-F ()
 <COND (<VERB? EXAMINE>
        <TELL "The Lending Hall is tall and hushed, with a polished wooden floor and shelves so high they disappear into shadow. Every shelf is empty. All the library has left to lend is in the cabinet by the window." CR>)
       (<VERB? LISTEN>
        <TELL "It's so quiet you can hear dust settling. Somewhere far off, a clock ticks, then seems to wait before ticking again." CR>)
       (<VERB? SMELL>
        <TELL "Floor polish and old paper, the smell of every library everywhere." CR>)>>
<ROUTINE FOLDING-ROOM-F ()
 <COND (<VERB? EXAMINE>
        <TELL "A small, bright room, white-walled and bare, with the long folding board in the middle. A narrow staircase climbs to the terrace, and an arch leads back to the hall." CR>)
       (<VERB? LISTEN>
        <TELL "From up the stairs comes the faint noise of the market." CR>)
       (<VERB? SMELL>
        <TELL "Beeswax and sunshine." CR>)>>
<ROUTINE BASIN-ROOM-F ()
 <COND (<VERB? EXAMINE>
        <TELL "Bare stone walls, cool and a little damp. The trough runs out through a low gap in the wall, down toward the market, and a doorway opens east onto the terrace." CR>)
       (<VERB? RUB>
        <TELL "The stone wall is cool and smooth, polished by years of running water." CR>)
       (<VERB? LISTEN>
        <COND (,ON-LOAN <TELL "The room is perfectly silent. Even your own breathing sounds loud." CR>)
              (T <TELL "The trough trickles, and through the gap comes the far-off noise of the market." CR>)>)>>
<ROUTINE TERRACE-ROOM-F ()
 <COND (<VERB? EXAMINE>
        <TELL "The terrace is a wide stone balcony with a brass railing, high above the rooftops of the town. Below are the market and the square, and beyond them the hills." CR>)
       (<VERB? LOOK-UNDER>
        <TELL "You peek over the railing. It's a long way down to the market. You hold on tight." CR>)
       (<VERB? RUB>
        <TELL "The brass railing is warm from the sun and smooth from many hands." CR>)>>
<ROUTINE LEAF-F ()
 <COND (<AND <VERB? TAKE> <FSET? ,LEAF ,NDESCBIT>> <FCLEAR ,LEAF ,NDESCBIT> <RFALSE>)
       (<AND <VERB? TAKE> <IN? ,LEAF ,CASE>>
        <COND (<FSET? ,CASE ,OPENBIT>
               <MOVE ,LEAF ,WINNER> <SETG ON-LOAN T>
               <TELL "As you lift it out, the leaf records your name: it appears in the little box in gold. At the same moment the narrow stripe of tomorrow's sunlight on the floor goes out, so neatly that for a moment you think you blinked. Tomorrow is on loan now, to you, and only to you." CR>)>)
       (<VERB? EXAMINE>
        <COND (,WIDE-LOAN <TELL "The gold page is opened out now, as wide as your arms. Your name sits in one corner, and all the rest is blank, waiting." CR>)
              (T <TELL "A small page of gold paper, folded over and over into a tight little square. On the front is a single box, big enough for just one name." CR>)>)
       (<VERB? READ>
        <COND (<IN? ,LEAF ,FRAME> <PUBLISH-LOAN>)
              (<IN? ,LEAF ,CASE> <TELL "Through the open door you can make out the word TOMORROW and one box for one name." CR>)
              (T <TELL "In small gold letters it says TOMORROW, just under your name. Nothing happens when you read it here, quietly, in your own hands. A word like that is meant to be read out where everyone can see it." CR>)>)
       (<VERB? SMELL>
        <TELL "It smells like the air just before morning: cool, clean, and a little like toast." CR>)
       (<VERB? LISTEN>
        <TELL "Held to your ear, the page makes tiny sounds: a rooster, a kettle, someone laughing. Tomorrow's sounds, waiting their turn." CR>)
       (<VERB? RUB>
        <TELL "The paper is warm, as if it has been lying in tomorrow's sun." CR>)
       (<VERB? SHAKE>
        <COND (,WIDE-LOAN <TELL "The wide page flaps like a little flag, and for a moment you feel a breeze that smells of morning." CR>)
              (T <TELL "The tight little square doesn't flutter at all. It's folded much too firmly for that." CR>)>)>>
<ROUTINE PUBLISH-LOAN ()
 <TELL "Standing at the frame, you read the one word on the page out loud, as clearly as you can: TOMORROW. The wide page glows, and down in the market a hundred names call back, one after another, until all the empty space beside yours is full. The shadows begin to grow longer again. Outside the bakery, someone takes back a chair they were about to put away." CR CR
       "THE END -- ROOM FOR EVERY NAME" CR>
 <FINISH> <RTRUE>>
<ROUTINE V-SCORE ("OPTIONAL" (ASK? T))
 <COND (<IN? ,LEAF ,FRAME> <TELL "Library record: a day shared." CR>)
       (,ON-LOAN <TELL "Library record: one day on loan." CR>)
       (T <TELL "Library record: no loans outstanding." CR>)>>
