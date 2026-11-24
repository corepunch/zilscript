<ROUTINE V-VERSION ()
 <TELL "House of the Ebb|Studio Null, 2026|Release " N ,RELEASEID CR>>

<ROUTINE V-SCORE ("OPTIONAL" (ASK? T)) <TELL "There is no score and no deadline." CR>>

<ROUTINE GO ()
 <V-VERSION> <CRLF>
 <SETG COMPACT-ROOM-LISTS T> <SETG HERE ,CAUSEWAY> <SETG VERBOSE T> <SETG LIT T>
 <SETG WINNER ,ADVENTURER> <SETG PLAYER ,WINNER> <MOVE ,WINNER ,HERE>
 <TELL "Kit said he would wait on the causeway. That was nine winters ago. Tonight his boots sound just the same as yours on the stones." CR CR> <TELL D ,HERE CR>
 <V-LOOK> <MAIN-LOOP> <AGAIN>>

<SYNTAX HINT = V-BOOK-HINT>
<SYNTAX TURN OBJECT = V-SPIN>

<ROUTINE V-BOOK-HINT ()
 <COND (<NOT ,MUG-SEEN> <TELL "Look at the mug in the kitchen." CR>) (<NOT ,TALLY-READ> <TELL "Read the tally sheet in the office." CR>) (<NOT ,PLATE-READ> <TELL "Read the signal plate on the landing." CR>) (<NOT <FSET? ,ESHUT ,OPENBIT>> <TELL "Open the shutter in the lantern room." CR>) (<NOT ,LENS-READY> <TELL "Turn the lens in the lantern room." CR>) (T <TELL "On the gallery, ring the bell or pull the brake." CR>)>>

<ROUTINE CAUSEWAY-F (RARG)
 <COND (<EQUAL? .RARG ,M-LOOK> <TELL "Seaweed has dried into the mortar in little commas.">
 <COND (,LENS-READY <TELL " Only your own boots answer the stones.">)
       (T <TELL " Your brother walks a pace behind, so close you can hear his boot buckle.">)>
 <TELL " At the [[tide-house->north]], someone has left a light burning in a house without electricity." CR>)>>

<ROUTINE HALL-F (RARG)
 <COND (<EQUAL? .RARG ,M-LOOK> <TELL "Rain settles into the crease of a [[bench]].">
 <COND (<IN? ,EKIT ,HALL> <TELL " [[Kit]] sets down his bag without taking his eyes off the floor.">)
       (T <TELL " The bag is no longer there, but the wood is dry where it sat.">)>
 <TELL " From the [[stairs->north]] comes the noise of a boot being set down very carefully. The [[kitchen->west]] is cold; the [[tally office->east]] smells of vinegar. The [[causeway->south]] is behind you." CR>)>>

<ROUTINE KITCHEN-F (RARG)
 <COND (<EQUAL? .RARG ,M-LOOK> <TELL "A strip of moon shows through the unlit range. A [[child's mug->mug]] sits on its ledge, clean around the lip. The [[hall->east]] is a little warmer." CR>)>>

<ROUTINE OFFICE-F (RARG)
 <COND (<EQUAL? .RARG ,M-LOOK> <TELL "The old [[tally sheet->sheet]] has pulled the corners of its board into curls. Salt prickles on your knuckles. The [[hall->west]] is the only way out." CR>)>>

<ROUTINE STAIRS-F (RARG)
 <COND (<EQUAL? .RARG ,M-LOOK> <TELL "Water drips UP the landing wall, one bead at a time. A [[signal plate->plate]] is screwed beside the stair. The [[hall->south]] lies behind you; a [[lantern room->up]] waits overhead." CR>)>>

<ROUTINE LANTERN-F (RARG)
 <COND (<EQUAL? .RARG ,M-LOOK> <TELL "A [[signal lens->lens]] turns the rain on the window violet. A narrow [[shutter]] faces seaward.">
 <COND (,LENS-READY <TELL " The lens holds the place for a boat that never came back.">)>
 <TELL " The [[landing->down]] is below; a covered [[gallery->east]] runs along the side of the house." CR>)>>

<ROUTINE GALLERY-F (RARG)
 <COND (<EQUAL? .RARG ,M-LOOK> <TELL "The wind down here sounds almost domestic. Someone could be humming while hanging washing. A [[witness bell->bell]] hangs just within reach.">
 <COND (,LENS-READY <TELL " Beyond it, [[Kit]] lays his thumb on the [[clapper brake->brake]].">)>
 <TELL " The [[lantern room->west]] is behind you." CR>)>>

<ROUTINE EBENCH-F ()
 <COND
  (<VERB? EXAMINE> <TELL "The seat is worn shiny at both ends. No one sat in the middle unless there was a family waiting." CR>)>>

<ROUTINE EKIT-F ()
 <COND
  (<VERB? EXAMINE TELL> <COND (,LENS-READY <TELL "“You don't have to make it pretty,” he says. “You only have to say what happened.” You cannot remember when he came up the stair." CR>)
    (,TALLY-READ <TELL "“They don't erase everyone's name,” he says. “Just the ones they think nobody will ask for.”" CR>)
    (T <TELL "“You promised you wouldn't disappear on me again,” he says. You had remembered the promise as something he said." CR>)>)>>

<ROUTINE EMUG-F ()
 <COND
  (<VERB? EXAMINE SEARCH> <SETG MUG-SEEN T> <TELL "The white glaze is chipped where Kit always knocked his teeth. His initials have been scraped out. Under the handle he scratched them again himself: K. R." CR>)>>

<ROUTINE ETALLY-F ()
 <COND
  (<VERB? EXAMINE READ SEARCH> <SETG TALLY-READ T> <TELL "Three names went out on the ferry. Two were brought back. The keeper struck the third line out rather than count it. In the margin is your own hand: “I said the third was never there.” The initials beneath it are K. R." CR>)>>

<ROUTINE EPLATE-F ()
 <COND
  (<VERB? EXAMINE READ> <SETG PLATE-READ T> <TELL "During a search, OPEN the seaward shutter, then TURN the lens to hold one missing berth in its light. On the gallery, RING to call the shore as witnesses, or PULL the brake to hold a private vigil. Never sound the bell into an unlit sea." CR>)>>

<ROUTINE ESHUT-F ()
 <COND
  (<VERB? EXAMINE> <COND (<FSET? ,ESHUT ,OPENBIT> <TELL "The [[shutter]] is wedged open. All the space beyond it looks like a place made for a single light." CR>)
    (T <TELL "An iron catch holds the [[shutter]] flush with its frame. The catch works; there is nothing to unlock." CR>)>)
  (<VERB? OPEN> <COND (<FSET? ,ESHUT ,OPENBIT> <TELL "It is already open." CR>)
    (T <FSET ,ESHUT ,OPENBIT> <TELL "You lift the catch. Wind steps into the room like somebody late for dinner. It smells of Kit's wet coat." CR>)>)
  (<VERB? CLOSE> <COND (,LENS-READY <TELL "The light needs the sea now. You leave the shutter open." CR>)
    (<FSET? ,ESHUT ,OPENBIT> <FCLEAR ,ESHUT ,OPENBIT> <TELL "The wind has to wait outside again." CR>)
    (T <TELL "It is already closed." CR>)>)>>

<ROUTINE ELENS-F ()
 <COND
  (<VERB? EXAMINE> <TELL "The [[lens]] has a finger-shaped hollow in its rim. Instead of a compass it is marked with ferry berths. The maker cut one extra notch at the end." CR>)
  (<VERB? TURN SPIN> <COND (,LENS-READY <TELL "Turning the lens away now would erase a name a second time." CR>)
    (<NOT <FSET? ,ESHUT ,OPENBIT>> <TELL "The beam breaks on the closed [[shutter]]. First give the light somewhere to go." CR>)
    (<OR <NOT ,MUG-SEEN> <NOT ,TALLY-READ> <NOT ,PLATE-READ>>
     <TELL "Which berth did they leave empty? You need the [[signal instructions->down]] and the records and keepsakes below, not a lucky turn." CR>)
    (T <SETG LENS-READY T> <FCLEAR ,EBRAKE ,INVISIBLE> <MOVE ,EKIT ,GALLERY>
     <TELL "You turn the glass to the extra notch. A beam takes the shape of an empty berth. Below it is the buckle you heard on the causeway. Kit is not beside you now. From the gallery [[east]], someone calls his name in your voice." CR>)>)>>

<ROUTINE EBELL-F ()
 <COND
  (<VERB? EXAMINE> <TELL "The [[bell]] is bolted through its handle. The clapper is worn where a person could reach it. This is how the keeper summoned witnesses from ashore." CR>)
  (<VERB? TAKE> <TELL "It belongs to the house. You could sound it here." CR>)
  (<VERB? RING> <COND (<NOT ,LENS-READY> <TELL "Not into a dark sea. Go [[west]] and light the missing berth first." CR>)
    (T <SETG EBB-ENDING T> <TELL "The first note is ugly. The second knocks a light on across the water. Between the second note and the third you shout, “Kit Rook was aboard. I let you write him out.” You stay on the gallery until the first lantern turns this way." CR CR "THE END: THE SHORE HEARS" CR> <FINISH>)>)>>

<ROUTINE EBRAKE-F ()
 <COND
  (<VERB? EXAMINE> <TELL "The [[brake]] draws the clapper away from the metal. No one ashore would hear, but no one here would have to wait for an answer." CR>)
  (<VERB? MOVE PULL> <COND (,LENS-READY <SETG EBB-ENDING T>
   <TELL "You draw the clapper back. In the space where a bell might have sounded, you say his name once. The glass holds the light until morning. To take his memory home is not to leave him here." CR CR "THE END: THE LIGHT STAYS" CR> <FINISH>) (T <TELL "The light must be ready first." CR>)>)>>
