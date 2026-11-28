<ROUTINE V-VERSION ()
 <TELL "House of the Ebb|Studio Null, 2026|Release " N ,RELEASEID CR>>

<ROUTINE V-SCORE ("OPTIONAL" (ASK? T)) <TELL "There is no score and no deadline." CR>>

<ROUTINE GO ()
 <V-VERSION> <CRLF>
 <SETG COMPACT-ROOM-LISTS T> <SETG HERE ,CAUSEWAY> <SETG VERBOSE T> <SETG LIT T>
 <SETG WINNER ,ADVENTURER> <SETG PLAYER ,WINNER> <MOVE ,WINNER ,HERE>
 <TELL "You have come home to the tide-house, the old ferry-keeper's house out on the rocks, for the first time in nine winters. Your younger brother Kit promised he would wait for you on the causeway, and tonight he was there, just as he said, his boots ringing on the stones exactly like yours. No one has kept the house since the last ferry was lost. Yet a light is burning in its window." CR CR> <TELL D ,HERE CR>
 <V-LOOK> <MAIN-LOOP> <AGAIN>>

<SYNTAX HINT = V-BOOK-HINT>
<SYNTAX LISTEN = V-EBB-LISTEN>
<SYNTAX SMELL = V-EBB-SMELL>

<ROUTINE V-EBB-LISTEN ()
 <COND (<EQUAL? ,HERE ,CAUSEWAY> <PERFORM ,V?LISTEN ,ECAUSE>)
       (<EQUAL? ,HERE ,HALL> <PERFORM ,V?LISTEN ,ESTAIRS>)
       (<EQUAL? ,HERE ,KITCHEN> <TELL "There is a little tick from the range, the sound iron makes when a fire has just gone out." CR>)
       (<EQUAL? ,HERE ,OFFICE> <TELL "The tally sheet's bottom corner ticks against its board. It sounds like someone waiting to be counted." CR>)
       (<EQUAL? ,HERE ,LANTERN-LANDING> <TELL "You listen for a drip. None of the water ever falls." CR>)
       (<EQUAL? ,HERE ,LANTERN> <PERFORM ,V?LISTEN ,ESHUT>)
       (<EQUAL? ,HERE ,GALLERY> <PERFORM ,V?LISTEN ,EGALLERY>)>
 <RTRUE>>

<ROUTINE V-EBB-SMELL ()
 <COND (<EQUAL? ,HERE ,CAUSEWAY> <PERFORM ,V?SMELL ,ESEA>)
       (<EQUAL? ,HERE ,HALL> <PERFORM ,V?SMELL ,EBENCH>)
       (<EQUAL? ,HERE ,KITCHEN> <PERFORM ,V?SMELL ,ERANGE>)
       (<EQUAL? ,HERE ,OFFICE> <PERFORM ,V?SMELL ,ETALLY>)
       (<EQUAL? ,HERE ,LANTERN-LANDING> <PERFORM ,V?SMELL ,EWATER>)
       (<EQUAL? ,HERE ,LANTERN> <TELL "Salt has dried on the window frames, but the glass smells warm, like the inside of a lamp." CR>)
       (<EQUAL? ,HERE ,GALLERY> <TELL "The wind smells of seaweed where it enters the gallery and of wet iron where it leaves." CR>)>
 <RTRUE>>
<SYNTAX TURN OBJECT = V-SPIN>

<ROUTINE V-BOOK-HINT ()
 <COND (<NOT ,MUG-SEEN> <TELL "Look at the mug in the kitchen." CR>) (<NOT ,TALLY-READ> <TELL "Read the tally sheet in the office." CR>) (<NOT ,PLATE-READ> <TELL "Read the signal plate on the landing." CR>) (<NOT <FSET? ,ESHUT ,OPENBIT>> <TELL "Open the shutter in the lantern room." CR>) (<NOT ,LENS-READY> <TELL "Turn the lens in the lantern room." CR>) (T <TELL "On the gallery, ring the bell or pull the brake." CR>)>>

<ROUTINE CAUSEWAY-F (RARG)
 <COND (<AND <EQUAL? .RARG ,M-ENTER> <NOT ,LENS-READY>> <MOVE ,EKIT ,CAUSEWAY> <RFALSE>)
  (<EQUAL? .RARG ,M-LOOK> <TELL "You are on the [[causeway]], a raised stone road across the tidal flats that the [[sea]] covers twice a day. Seaweed has dried into the mortar between the stones in little commas, and the water sucks at them on either side.">
 <COND (,LENS-READY <TELL " Only your own boots answer the stones now.">)
       (T <TELL " [[Kit]] walks a pace behind you, close enough to touch.">)>
 <TELL " Ahead to the [[north]] stands the tide-[[house]] where you grew up, and someone has left a light burning in a house that has never had electricity." CR>)>>

<ROUTINE HALL-F (RARG)
 <COND (<AND <EQUAL? .RARG ,M-ENTER> <NOT ,LENS-READY> <NOT <IN? ,EKIT ,HALL>>>
        <MOVE ,EKIT ,HALL>
        <TELL "Kit sets his bag beside the bench." CR>
        <RFALSE>)
  (<EQUAL? .RARG ,M-LOOK> <TELL "This is the waiting hall, where ferry passengers once sat out the weather until the boat came. Rain has blown in through a broken [[pane]] and settles in the crease of a long wooden [[bench]].">
 <COND (<IN? ,EKIT ,HALL> <TELL " Your brother [[Kit]] stands by the bench, watching rainwater creep toward his [[bag]].">)
       (T <TELL " Kit's bag is gone, but the bench is dry where it sat.">)>
 <TELL " [[Stairs->hall stairs]] lead [[north]] and up into the house, and from them comes the sound of a boot being set down very carefully. The cold [[kitchen->west]] is to the west, and the [[tally office->east]], which smells of vinegar, is to the east. The [[causeway->south]] is back to the south." CR>)>>

<ROUTINE KITCHEN-F (RARG)
 <COND (<EQUAL? .RARG ,M-LOOK> <TELL "In the kitchen, a strip of [[moonlight]] crosses the black iron [[range->iron range]] where there used to be a fire. One small white [[child's mug->mug]] sits on the [[ledge]], clean around the lip; the rest of the shelf is furred with dust. The hall, a little warmer, is back to the [[east]]." CR>)>>

<ROUTINE OFFICE-F (RARG)
 <COND (<EQUAL? .RARG ,M-LOOK> <TELL "This is the tally office, where the keeper counted every passenger out on the ferry and every passenger back. It smells sharply of vinegar, and the damp has got into everything. An old [[tally sheet->sheet]] is pinned to a board on the wall, its corners curled with damp. The only way out is back [[west]] to the hall." CR>)>>

<ROUTINE STAIRS-F (RARG)
 <COND (<EQUAL? .RARG ,M-LOOK> <TELL "You are on the landing at the top of the stairs. Drops of [[water]] are creeping UP the wall here, one bead at a time, against all sense. A brass [[signal plate->plate]] of instructions is screwed to the wall. The [[stairs->landing stairs]] go back down to the hall to the [[south]], and a short [[ladder]] climbs [[up]] to the lantern room." CR>)>>

<ROUTINE LANTERN-F (RARG)
 <COND (<EQUAL? .RARG ,M-LOOK> <TELL "This is the lantern room at the top of the house, a small glass room built to signal the ferry. In the middle stands the great [[signal lens->lens]], and it turns the rain on the [[windows]] violet.">
 <COND (<FSET? ,ESHUT ,OPENBIT> <TELL " The narrow [[shutter]] in the seaward wall stands open to the wind.">)
       (T <TELL " A narrow [[shutter]] in the seaward wall is shut tight against the sea.">)>
 <COND (,LENS-READY <TELL " The lens holds its beam on one empty place out on the water, for a boat that never came back.">)>
 <TELL " You can climb back [[down]] to the landing, and the outside gallery runs off to the [[east]]." CR>)>>

<ROUTINE GALLERY-F (RARG)
 <COND (<EQUAL? .RARG ,M-LOOK> <TELL "You are on the outside [[gallery]], a narrow walkway that runs around the top of the house under a little roof. The wind up here sounds almost homely, like someone humming to themselves in the next room. A brass [[witness bell->bell]] hangs just within reach.">
 <COND (,LENS-READY <TELL " Beside it stands [[Kit]], his thumb resting on the bell's [[clapper brake->brake]].">)>
 <TELL " The lantern room is back to the [[west]]." CR>)>>

<ROUTINE EBENCH-F ()
 <COND
  (<VERB? EXAMINE> <TELL "A long wooden bench, worn shiny at both ends. Nobody sat in the middle unless a whole family was waiting for the boat." CR>)
  (<VERB? CLIMB-ON CLIMB-FOO> <TELL "You sit at one end. After a moment you notice you have left room at the other end, the way you always did." CR>)
  (<VERB? RUB> <TELL "The wood is damp all along, except for one dry patch where Kit's bag was set down." CR>)
  (<VERB? LOOK-UNDER> <TELL "Dust, a dead moth, and a child's chalk mark showing how far the tide once came in." CR>)
  (<VERB? SMELL> <TELL "Wet wood and tar, the smell of every winter you spent waiting here." CR>)
  (<VERB? TAKE MOVE> <TELL "It is fixed to the floor, so that the storms couldn't throw it about." CR>)>>

<ROUTINE EKIT-F ()
 <COND
  (<VERB? EXAMINE TELL> <COND (,LENS-READY <TELL "Kit's coat is soaked through, though the gallery has a roof. “You don't have to make it pretty,” he says. “You only have to say what happened.” You cannot remember him coming up the stairs." CR>)
    (,TALLY-READ <TELL "Kit still looks nineteen, in his old oilskin coat. “They don't erase everyone's name,” he says. “Just the ones they think nobody will ask for.”" CR>)
    (T <TELL "Kit still looks nineteen, in his old oilskin coat, rain beaded on the collar. “You promised you wouldn't disappear on me again,” he says. Strange: you had always remembered that promise as one he made to you." CR>)>)
  (<VERB? RUB> <TELL "You reach for his sleeve. He moves at just that moment, as he always did, and your hand closes on cold air." CR>)
  (<VERB? LISTEN> <TELL "Under the rain you can hear the buckle on his boot, and nothing else. Not even his breathing." CR>)
  (<VERB? SMELL> <TELL "Wet oilskin and seawater, as though he has just come in off the boat." CR>)
  (<VERB? KISS> <TELL "He ducks his head away, embarrassed, like when he was small." CR>)
  (<VERB? HELLO> <TELL "“Hello yourself,” Kit says, as though you had only been gone an hour." CR>)
  (<VERB? FOLLOW> <TELL "He is right beside you. He always has been, tonight." CR>)
  (<VERB? TAKE PUSH MOVE> <TELL "You put a hand out to steer him, and somehow he is already a step to one side." CR>)
  (<VERB? ATTACK KICK> <TELL "You haven't hit your brother since you were twelve, and you're not starting tonight." CR>)>>

<ROUTINE EMUG-F ()
 <COND
  (<VERB? EXAMINE SEARCH READ LOOK-UNDER> <SETG MUG-SEEN T> <TELL "The white glaze is chipped where Kit always knocked his teeth on it. Someone has scraped his initials off the side. But under the handle, where no one else would think to look, he scratched them in again himself: K. R." CR>)
  (<VERB? TAKE> <TELL "You lift it, and then set it back exactly on its clean ring. It belongs on that ledge." CR>)
  (<VERB? SMELL> <TELL "Faintly, impossibly, of warm cocoa." CR>)
  (<VERB? RUB> <TELL "The lip is smooth and slightly warm, as if it has only just been put down." CR>)
  (<VERB? LOOK-INSIDE> <TELL "It is empty, dry and clean. No dust has settled in it in nine winters." CR>)
  (<VERB? KNOCK> <TELL "You tap the glaze. Two notes answer: one from the mug, and a fainter one from the wall behind the ledge." CR>)
  (<VERB? DRINK DRINK-FROM> <TELL "There is nothing in it, and it isn't yours." CR>)>>

<ROUTINE ERANGE-F ()
 <COND
  (<VERB? EXAMINE> <TELL "A black iron range, the heart of the house once. No fire has burned in it for years. On the ledge above it, the keeper kept the family's cups; only one is left." CR>)
  (<VERB? OPEN LOOK-INSIDE> <TELL "The oven door creaks open on old ash and nothing else. You push it shut again." CR>)
  (<VERB? CLOSE> <TELL "The oven door is already shut on its cold ash." CR>)
  (<VERB? RUB> <TELL "Stone cold. Your fingers come away grey with soot." CR>)
  (<VERB? SMELL> <TELL "Old soot, and very faintly, burnt toast. Kit always burnt the toast." CR>)
  (<VERB? LIGHT> <TELL "There is no coal, and no one has brought any in years." CR>)>>

<ROUTINE ETALLY-F ()
 <COND
  (<VERB? EXAMINE READ SEARCH> <SETG TALLY-READ T> <TELL "The sheet records the ferry's last crossing. Three names went out on the boat, and only two were counted back. The keeper did not count the third; he struck the line out instead. In the margin, in your own handwriting, are the words “I said the third was never there.” Under the struck line, the initials K. R. can still be made out." CR>)
  (<VERB? RUB> <TELL "Under your fingertip the struck-out line is rough, where someone scrubbed at it with vinegar to lift the ink." CR>)
  (<VERB? SMELL> <TELL "Vinegar, strongest of all on the third line." CR>)
  (<VERB? TAKE MOVE> <TELL "It is pinned fast to its board, and you don't want to carry it." CR>)
  (<VERB? DESTROY> <TELL "You tore enough out of this house nine winters ago." CR>)>>

<ROUTINE EPLATE-F ()
 <COND
  (<VERB? EXAMINE READ> <SETG PLATE-READ T> <TELL "Instructions for a search at sea, stamped in brass. OPEN the seaward shutter. TURN the lens until it holds the missing berth, the place where the lost boat should be, in its light. Then, on the gallery, RING the bell to call the shore as witnesses, or PULL the brake to keep a private vigil instead. NEVER sound the bell into an unlit sea." CR>)
  (<VERB? RUB> <TELL "The letters are worn smooth beside TURN, as if many fingers rested there before doing it." CR>)
  (<VERB? SMELL> <TELL "Brass polish. Someone has been keeping it bright." CR>)
  (<VERB? TAKE MOVE> <TELL "It is screwed firmly to the wall." CR>)>>

<ROUTINE EWATER-F ()
 <COND
  (<VERB? EXAMINE> <TELL "Drops of water gather at the foot of the wall and creep upward, slow as snails, until they vanish into the ceiling, toward the lantern room." CR>)
  (<VERB? RUB> <TELL "Cold. When you touch your finger to your tongue it tastes of salt: sea water, not rain." CR>)
  (<VERB? SMELL> <TELL "It smells of the sea at the turn of the tide." CR>)
  (<VERB? TAKE> <TELL "The drop runs out from under your finger and keeps climbing." CR>)>>

<ROUTINE ESHUT-F ()
 <COND
  (<VERB? EXAMINE> <COND (<FSET? ,ESHUT ,OPENBIT> <TELL "The [[shutter]] is wedged open. Beyond it there is only the dark sea, waiting for a light." CR>)
    (T <TELL "A narrow iron [[shutter]] in the seaward wall, held flush with its frame by a simple catch. Nothing is locked; it only needs opening." CR>)>)
  (<VERB? OPEN> <COND (<FSET? ,ESHUT ,OPENBIT> <TELL "It is already open." CR>)
    (T <FSET ,ESHUT ,OPENBIT> <TELL "You lift the catch and swing the shutter out. The wind steps into the room like somebody late for dinner. It smells of Kit's wet coat." CR>)>)
  (<VERB? CLOSE> <COND (,LENS-READY <TELL "The light needs the sea now. You leave the shutter open." CR>)
    (<FSET? ,ESHUT ,OPENBIT> <FCLEAR ,ESHUT ,OPENBIT> <TELL "The wind has to wait outside again." CR>)
    (T <TELL "It is already closed." CR>)>)
  (<VERB? KNOCK> <COND (<FSET? ,ESHUT ,OPENBIT> <TELL "There is nothing to knock on but wind." CR>)
    (T <TELL "The iron rings dully. Outside, a loose bolt rattles once in reply." CR>)>)
  (<VERB? LISTEN> <COND (<FSET? ,ESHUT ,OPENBIT> <TELL "The sea, very close, breathing in and out against the rocks." CR>)
    (T <TELL "The wind presses against it from outside, like someone leaning on a door." CR>)>)
  (<VERB? RUB> <TELL "Cold iron with a crust of salt. The catch moves easily under your thumb." CR>)>>

<ROUTINE ELENS-F ()
 <COND
  (<VERB? EXAMINE> <TELL "The signal lens is a great ring of violet glass, turned by hand by a finger-shaped hollow in its rim. Instead of compass points, the rim is marked with the ferry's berths, the places out on the water where each boat should be. The maker cut one extra notch at the very end." CR>)
  (<VERB? TURN SPIN> <COND (,LENS-READY <TELL "You won't turn it away now. That would erase his name a second time." CR>)
    (<NOT <FSET? ,ESHUT ,OPENBIT>> <TELL "The beam breaks on the closed [[shutter]]. The light needs somewhere to go first." CR>)
    (<OR <NOT ,MUG-SEEN> <NOT ,TALLY-READ> <NOT ,PLATE-READ>>
     <TELL "You turn it a notch, then stop. Which berth was left empty? You don't know yet. The [[signal instructions->down]] on the landing, and the records and keepsakes in the rooms below, would tell you; a lucky turn won't." CR>)
    (T <SETG LENS-READY T> <FCLEAR ,EBRAKE ,INVISIBLE> <MOVE ,EKIT ,GALLERY> <REMOVE ,EBAG>
     <TELL "You turn the glass to the extra notch at the end of the rim. The beam swings out over the water and settles on an empty berth, where no boat is. On the stair below you hear the boot buckle you heard on the causeway, and you realize Kit is no longer with you. Out on the gallery to the [[east]], someone is calling his name in your voice." CR>)>)
  (<VERB? RUB> <TELL "The glass is warm, as if a light were already burning inside it." CR>)
  (<VERB? LISTEN> <TELL "Your ear catches a sustained note from the glass. It is the note the ferryman used to hum while he wound the lamp." CR>)
  (<VERB? LOOK-INSIDE> <TELL "Through the violet glass, the rain on the windows looks like a crowd of small, waiting lights." CR>)
  (<VERB? TAKE MOVE> <TELL "It weighs more than you do, and it only turns." CR>)>>

<ROUTINE EBELL-F ()
 <COND
  (<VERB? EXAMINE> <TELL "A brass [[bell]] bolted to its bracket, with a long clapper worn bright where hands have reached for it. The keeper rang it to call people from the shore to come and witness a search." CR>)
  (<VERB? TAKE> <TELL "It is bolted to the house. You could ring it here." CR>)
  (<VERB? RING> <COND (<NOT ,LENS-READY> <TELL "Not into a dark sea. Light the missing berth with the lens first; the lantern room is back to the [[west]]." CR>)
    (T <SETG EBB-ENDING T> <TELL "The first note is ugly. The second wakes a light across the water. Between the second note and the third you shout, “Kit Rook was aboard! I let you write him out.” You stay on the gallery until the first lantern ashore turns this way. Someone on shore will have to open the tally and find the space where his name was scraped away." CR CR "THE END: THE SHORE HEARS" CR> <FINISH>)>)
  (<VERB? RUB> <TELL "The brass is wet and cold, and it hums under your hand with the wind." CR>)
  (<VERB? LISTEN> <TELL "Even unrung, the bell gives off a faint, high note as the wind crosses its mouth." CR>)
  (<VERB? KNOCK> <TELL "You tap it with a knuckle. It answers with a small sound, too small to carry, that dies away into the rain." CR>)>>

<ROUTINE EBRAKE-F ()
 <COND
  (<VERB? EXAMINE> <TELL "A brass [[brake]] that draws the clapper back from the bell and holds it there. With the bell silenced, no one ashore would hear anything, but no one here would have to wait for an answer either. It is a way to keep watch in private." CR>)
  (<VERB? MOVE PULL> <COND (,LENS-READY <SETG EBB-ENDING T>
   <TELL "You draw the clapper back and hold it. In the silence where the bell would have rung, you say his name, once. The lens holds its light on the empty berth until morning. You will carry his name back over the causeway yourself, without asking the shore to witness it. To take his memory home is not to leave him here." CR CR "THE END: THE LIGHT STAYS" CR> <FINISH>) (T <TELL "The light must be ready first." CR>)>)
  (<VERB? RUB> <TELL "Kit's thumb is already on it. His hand is as cold as the brass, and it does not move away." CR>)
  (<VERB? LISTEN> <TELL "The clapper just brushes the brake in the wind. There is a sound of teeth almost closing." CR>)>>

<ROUTINE ECAUSE-F ()
 <COND
  (<VERB? EXAMINE> <TELL "Big square stones, green at the edges, with dried seaweed curled in the mortar between them. You and Kit used to race the tide along here." CR>)
  (<VERB? RUB> <TELL "The stones are slick and cold. The seaweed crackles under your fingers like old paper." CR>)
  (<VERB? LISTEN>
   <COND (,LENS-READY <TELL "Your boots on the stones, the sea on either side. This time, when you stop, there is no second set of steps to stop with you." CR>)
         (T <TELL "Your boots on the stones, the sea on either side, and once, just behind you, a second pair of boots keeping step." CR>)>)>>

<ROUTINE ESEA-F ()
 <COND
  (<VERB? EXAMINE> <TELL "Black water on both sides of the causeway, flat as a slate. Far out, where the ferry used to cross, nothing moves at all." CR>)
  (<VERB? LISTEN> <TELL "It sucks and sighs at the stones, patient, the way it always did." CR>)
  (<VERB? SMELL> <TELL "Salt and weed and cold. The smell of home." CR>)
  (<VERB? SWIM DRINK THROUGH> <TELL "Not tonight. Not here." CR>)>>

<ROUTINE EHOUSE-F ()
 <COND
  (<VERB? EXAMINE> <TELL "The tide-house stands on its rock at the end of the causeway, tall and narrow, with the glass lantern room on top. One window is lit, a steady yellow light, though no one has kept the house for years." CR>)
  (<VERB? LISTEN> <TELL "From here you can hear nothing but the sea. The light doesn't flicker." CR>)
  (<VERB? THROUGH> <DO-WALK ,P?NORTH> <RTRUE>)
  (<VERB? KNOCK> <TELL "You knock on the windward wall. A shutter somewhere upstairs lifts and drops." CR>)>>

<ROUTINE EPANE-F ()
 <COND
  (<VERB? EXAMINE> <TELL "One pane of the hall window is broken, and rain comes in through it in little gusts. Someone has stuffed a rag into the corner of the frame, years ago." CR>)
  (<VERB? RUB> <TELL "The broken edge is worn smooth, like sea glass." CR>)
  (<VERB? LISTEN> <TELL "The wind whistles through the gap on a single low note." CR>)>>

<ROUTINE EBAG-F ()
 <COND
  (<VERB? EXAMINE> <TELL "Kit's old canvas kit bag, the one he took on the ferry. It is soaked dark, though it has been under a roof since you arrived." CR>)
  (<VERB? OPEN SEARCH LOOK-INSIDE TAKE MOVE> <COND (<IN? ,EKIT ,HALL> <TELL "Kit puts his hand flat on the bag before you can touch it. “Not yet,” he says." CR>)
    (T <TELL "You glance toward the door, half expecting Kit to stop you. He doesn't, and still you leave the bag alone. It is his to open." CR>)>)
  (<VERB? SMELL> <TELL "Wet canvas and seawater." CR>)
  (<VERB? LISTEN> <TELL "Water drips from the strap, but you never hear it hit the floor." CR>)>>

<ROUTINE ESTAIRS-F ()
 <COND
  (<VERB? EXAMINE>
   <COND (<EQUAL? ,HERE ,HALL> <TELL "Steep wooden stairs, worn hollow in the middle. The landing at the top is in shadow." CR>)
         (T <TELL "The wooden stairs drop to the hall to the south. The separate iron [[ladder]] takes you up." CR>)>)
  (<VERB? LISTEN> <TELL "A boot, set down very carefully, on a stair you cannot see. Then nothing." CR>)
  (<VERB? CLIMB-FOO CLIMB-ON CLIMB-UP CLIMB-DOWN>
   <COND (<EQUAL? ,HERE ,HALL>
          <COND (<VERB? CLIMB-DOWN> <TELL "From here the stairs only go up, to the landing." CR>)
                (T <DO-WALK ,P?NORTH>)>)
         (<VERB? CLIMB-UP> <TELL "The stairs go back to the hall. To go higher, use the [[ladder]]." CR>)
         (T <DO-WALK ,P?SOUTH>)>
   <RTRUE>)>>

<ROUTINE ELADDER-F ()
 <COND
  (<VERB? EXAMINE> <TELL "The stairs end here. A short iron ladder goes the rest of the way up, through a hatch into the lantern room." CR>)
  (<VERB? RUB> <TELL "The rungs are cold and wet, and worn bright by the keeper's hands." CR>)
  (<VERB? CLIMB-FOO CLIMB-ON CLIMB-UP THROUGH> <DO-WALK ,P?UP> <RTRUE>)
  (<VERB? CLIMB-DOWN> <TELL "You are at the foot of the ladder. The wooden stairs back to the hall are south." CR>)
  (<VERB? KNOCK> <TELL "The ladder rings against its brackets. Water keeps climbing the wall beside it." CR>)>>

<ROUTINE EMOON-F ()
 <COND
  (<VERB? EXAMINE> <TELL "A thin strip of moonlight comes in at the window and lies across the cold range like a dropped ribbon." CR>)
  (<VERB? RUB> <TELL "You put your hand in it. It is no warmer than the rest of the room." CR>)>>

<ROUTINE EWINDOWS-F ()
 <COND
  (<VERB? EXAMINE> <TELL "The lantern room is walled with glass. Rain runs down every pane, and the lens turns each drop violet." CR>)
  (<VERB? RUB> <TELL "You wipe a pane with your sleeve. Out there is only the dark sea, and one place on it where a light should be." CR>)
  (<VERB? KNOCK> <TELL "The glass gives back a dull, shivering note." CR>)>>

<ROUTINE EGALLERY-F ()
 <COND
  (<VERB? EXAMINE> <TELL "A narrow iron walkway around the top of the house, with a rail on the sea side and a little roof overhead. From here the keeper could see the whole crossing." CR>)
  (<VERB? RUB> <TELL "The rail is crusted with salt, and polished in one place where someone has stood and held on for a long time." CR>)
  (<VERB? LISTEN> <TELL "The wind hums along the rail. Under it you can almost make out a tune Kit used to whistle." CR>)>>
