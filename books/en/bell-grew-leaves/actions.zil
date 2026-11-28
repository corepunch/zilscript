<SYNTAX TURN OBJECT = V-SPIN>
<SYNTAX PULL OBJECT FROM OBJECT = V-TAKE PRE-TAKE>
;"Words a child reaches for: the tile shows the wick fitted and dipped."
<SYNTAX FIT OBJECT (HELD HAVE) IN OBJECT = V-PUT PRE-PUT>
<SYNTAX FIT OBJECT (HELD HAVE) ON OBJECT = V-PUT PRE-PUT>
<SYNTAX HANG OBJECT (HELD HAVE) IN OBJECT = V-PUT PRE-PUT>
<SYNTAX HANG OBJECT (HELD HAVE) ON OBJECT = V-PUT PRE-PUT>
<SYNTAX DIP OBJECT (HELD HAVE) IN OBJECT = V-PUT PRE-PUT>
<SYNTAX DIP OBJECT = V-SOAK>
<SYNONYM DIP SOAK DUNK>
<SYNTAX ATTACK OBJECT = V-ATTACK>
<SYNTAX HINT = V-BOOK-HINT>
<SYNTAX CALL TO OBJECT = V-CALL-ACROSS>
<SYNTAX YELL TO OBJECT = V-CALL-ACROSS>

<ROUTINE V-CALL-ACROSS ()
 <COND (<EQUAL? ,PRSO ,HOLLOW> <TELL "You cup your hands and call. The fog gives your voice back, a little smaller. The neighbors do not answer." CR>)
       (T <TELL "Your voice carries as far as the nearest stone, then disappears into the fog." CR>)>>
<SYNONYM HINT HINTS HELP>
<ROUTINE V-VERSION ()
 <TELL "The Bell That Grew Leaves|Studio Null, 2026|Release " N ,RELEASEID CR>>

<ROUTINE V-SOAK ()
 <COND (<NOT <EQUAL? ,PRSO ,WICK>> <TELL "There's no need to get that wet." CR>)
       (<NOT <HELD? ,WICK>> <TELL "You'd need to be holding the wick first." CR>)
       (<EQUAL? ,HERE ,SPRING> <PERFORM ,V?PUT ,WICK ,TROUGH> <RTRUE>)
       (T <TELL "There's no water here. The spring walk is the place for soaking things." CR>)>>

<ROUTINE V-BOOK-HINT ()
 <COND (<NOT ,PATTERN-KNOWN> <TELL "The painted signal tile in the reed store shows what to do. Go and look at it." CR>)
       (<AND <NOT ,WET-WICK> <IN? ,WICK ,BELL>> <TELL "The wick in the bell is still dry. Pull it out and give it a drink at the spring first." CR>)
       (<AND <NOT ,WET-WICK> <NOT <HELD? ,WICK>>> <TELL "Pick up the reed wick. It's the first picture on the tile." CR>)
       (<AND <NOT ,WET-WICK> <NOT ,FLOWING>> <TELL "On the spring walk, look at where the brass spout points." CR>)
       (<NOT ,WET-WICK> <TELL "Put the wick in the soaking bowl while the water runs into it." CR>)
       (<NOT <FSET? ,SHUTTER ,OPENBIT>> <TELL "The leaves will need a way out to the hollow. Open the frost shutter on the shutter landing." CR>)
       (<NOT <IN? ,WICK ,BELL>> <TELL "Put the wet wick in the root bell." CR>)
       (T <TELL "Everything is ready. Ring the root bell." CR>)>>

<ROUTINE GO ()
 <V-VERSION> <CRLF>
 <SETG COMPACT-ROOM-LISTS T>
 <SETG HERE ,COURT> <SETG VERBOSE T> <SETG LIT T>
 <SETG WINNER ,ADVENTURER> <SETG PLAYER ,WINNER> <MOVE ,WINNER ,HERE>
 <TELL "Three soft taps come up through the fog: tap, tap, tap. That is the village across the hollow, asking whether your village is still there. Your old bell is made of wood, too brittle to strike, and for the first time the grown-ups have left it to you to answer. You have come up to the Bell Court to find a way." CR CR>
 <TELL D ,HERE CR>
 <V-LOOK> <MAIN-LOOP> <AGAIN>>

<ROUTINE COURT-F (R)
 <COND (<EQUAL? .R ,M-LOOK>
        <TELL "You are in the Bell Court, a small [[cobbled yard]] at the top of the village. [[Fog]] beads on the low wall. One cobble rocks under your shoe with a tiny clack. In the middle hangs the old [[root bell]], carved from wood and low enough to touch, with pale roots growing down around its rim.">
        <COND (<IN? ,WICK ,BELL> <TELL " A [[reed wick]] hangs from a hole in one of the roots.">)>
        <COND (,LEAF-GROWN <TELL " One pale leaf still clings to the [[rim->root bell]].">)>
        <COND (<FSET? ,SHUTTER ,OPENBIT> <TELL " A cool draft drifts down from the north and stirs the roots.">)>
        <TELL " The reed store is through a low doorway to the [[east]], and the spring walk lies uphill to the [[north]]." CR>)>>
<ROUTINE STORE-F (R)
 <COND (<EQUAL? .R ,M-LOOK>
        <TELL "This is the Reed Store, a narrow wooden shed that smells like a field in August. Tied [[bundles of reeds->reed bundles]] lean in the corners, and a painted [[signal tile]] hangs on the wall above a plain shelf.">
        <TELL " The only way out is back [[west]] to the bell court." CR>)>>
<ROUTINE SPRING-F (R)
 <COND (<EQUAL? .R ,M-LOOK>
        <TELL "You are on the Spring Walk, a mossy ledge where a cold spring bubbles out of the hillside. A brass [[turning spout]] pokes out of the rock beside a shallow stone [[soaking bowl]].">
        <COND (,FLOWING <TELL " Water pours into the bowl, and the bowl holds a shaking picture of the sky.">)
              (T <TELL " The bowl is dry, though you can hear water running away somewhere nearby.">)>
        <TELL " The bell court is back down the hill to the [[south]], and stone steps lead [[east]] to the shutter landing." CR>)>>
<ROUTINE LANDING-F (R)
 <COND (<EQUAL? .R ,M-LOOK>
        <TELL "This is the Shutter Landing, a little stone platform at the edge of the village. Here the wall ends and the white sky seems to start below your feet.">
        <COND (<FSET? ,SHUTTER ,OPENBIT>
               <TELL " The square [[frost shutter]] in the wall stands open, and strands of fog drift in and come apart around you. Somewhere out there, across the hollow, is the other village.">)
              (T <TELL " A closed [[frost shutter]], square and wooden, covers the wall that faces the hollow. Frost glitters at its corners, and everything is very quiet.">)>
        <TELL " The stone steps lead back [[west]] to the spring walk." CR>)>>

<ROUTINE BELL-F ()
 <COND (<VERB? EXAMINE>
        <TELL "The bell is carved from one piece of old wood, not metal, so hitting it hard would only crack it. Pale roots grow down around its rim, dry and thin. One of them has a small round hole in it, just the right size for a wick.">
        <COND (<IN? ,WICK ,BELL> <TELL " The [[reed wick]] sits snugly in the hole.">)
              (<HELD? ,WICK> <TELL " The [[reed wick]] you are carrying would fit.">)>
        <COND (,LEAF-GROWN <TELL " A tiny pale leaf droops from the rim, still leaning toward the hollow.">)>
        <CRLF>)
       (<VERB? LISTEN>
        <COND (<AND ,WET-WICK <IN? ,WICK ,BELL>> <TELL "You hear water climbing up through the wood, a sound smaller than rain." CR>)
              (T <TELL "With your ear to the wood you hear your own heartbeat, then three very distant taps from across the hollow." CR>)>)
       (<AND <VERB? PUT PUT-ON> <EQUAL? ,PRSI ,BELL> <EQUAL? ,PRSO ,WICK>>
        <MOVE ,WICK ,BELL> <FSET ,WICK ,NDESCBIT>
        <TELL "You push the [[reed wick]] into the hole, and the root takes hold of it. There's enough left showing to pull it free again." CR>)
       (<VERB? RING>
        <COND (<NOT <IN? ,WICK ,BELL>> <TELL "Tuk. The wooden bell gives one dull knock that doesn't even reach the wall, and a pale root curls away like a dry finger. Ringing harder won't help. This bell will have to speak some other way." CR>)
              (<NOT ,WET-WICK> <TELL "The dry [[reed wick]] rattles in its hole. The wood is thirsty, not loose, and a dry wick has nothing to give it." CR>)
              (<AND <NOT <FSET? ,SHUTTER ,OPENBIT>> ,LEAF-GROWN>
               <TELL "The little leaf lifts, then slumps back against the rim. It needs a draft that reaches the hollow, not another ring." CR>)
              (<NOT <FSET? ,SHUTTER ,OPENBIT>>
               <SETG LEAF-GROWN T>
               <TELL "Water climbs up the wet wick into the wood, and with a soft rustle a tiny pale leaf unfolds on the rim. It leans away toward the hollow, then stops and droops. Something square is holding the fog in, and the leaf has nowhere to go." CR>)
              (T <TELL "The bell makes no sound at all. ">
                 <COND (,LEAF-GROWN <TELL "The drooping leaf lifts into the draft. Two more uncurl beside it.">)
                       (T <TELL "Water climbs the wet wick and three small leaves uncurl from the rim.">)>
                 <TELL " All three let go and sail through the shutter. The first turns its white side up, then the second, then the third. You wait until your fingers go cold. Then, in the far fog, three white leaves turn over in answer. Someone has been standing out in the cold with you this whole time." CR CR
                       "THE END -- THREE LEAVES FOR YES" CR>
                 <FINISH> <RTRUE>)>)
       (<VERB? RUB>
        <TELL "The wood is smooth and cool, and the roots feel as dry as old bread crusts. One root curls gently toward your fingers, as if it is thirsty." CR>)
       (<VERB? BRUSH>
        <TELL "You brush a little grey dust from the rim. Under it is the warm brown of a chestnut." CR>)
       (<VERB? SMELL>
        <TELL "It smells like a forest floor after a long dry week: sawdust, bark and old leaves." CR>)
       (<VERB? KNOCK>
        <TELL "You knock softly. Tok. The sound is small and flat, and it dies before it reaches the wall. Nobody across the hollow could hear that." CR>)
       (<VERB? MOVE PUSH>
        <TELL "You give the bell a gentle push. It swings a little on its beam and creaks, and a few flakes of dry bark drift down." CR>)
       (<VERB? LOOK-UNDER LOOK-INSIDE SEARCH>
        <TELL "You crouch and look up inside the bell. It is hollow and dark in there, and it smells of dust. Roots run all through the wood, like veins in a leaf.">
        <COND (<IN? ,WICK ,BELL> <TELL " The [[reed wick]] pokes out of its hole in the root.">)>
        <CRLF>)
       (<AND <VERB? TAKE> <EQUAL? ,PRSO ,BELL>>
        <TELL "The bell hangs from a thick beam and is far too big to carry. Besides, it belongs right here." CR>)
       (<VERB? KICK ATTACK STRIKE>
        <TELL "You would never hurt the village bell. It is so old and brittle that one hard blow would crack it, and it's the only voice the village has." CR>)>>
<ROUTINE WICK-F ()
 <COND (<AND <VERB? TAKE> <FSET? ,WICK ,NDESCBIT>> <FCLEAR ,WICK ,NDESCBIT> <RFALSE>)
       (<AND <VERB? MOVE> <IN? ,WICK ,BELL>>
        <MOVE ,WICK ,WINNER> <FCLEAR ,WICK ,NDESCBIT>
        <TELL "You pull the [[reed wick]] free of the root. It comes out easily." CR>)
       (<AND <VERB? MOVE> <HELD? ,WICK>>
        <TELL "You wave the wick about. It's as light as a feather." CR>)
       (<VERB? MOVE>
        <TELL "You nudge the wick with your toe, and it rolls a little way." CR>)
       (<VERB? EXAMINE>
        <COND (,WET-WICK <TELL "The reed is dark and heavy with spring water. If you squeeze it, a little runs over your thumb." CR>)
              (T <TELL "A short, hollow stem of reed, as light as a feather, cut to fit snugly into something small. When one end of a wick stands in water, the water creeps up inside it, even uphill." CR>)>)
       (<VERB? SMELL>
        <COND (,WET-WICK <TELL "It smells of cold spring water and green stems." CR>)
              (T <TELL "It smells like a summer riverbank, dry and sweet." CR>)>)
       (<VERB? WAVE>
        <COND (,WET-WICK <TELL "You wave a small hello. Two cold drops land on your nose, but the reed stays soaked." CR>)
              (T <TELL "You conduct three imaginary notes. The reed is an excellent baton and has no opinion of your singing." CR>)>)
       (<VERB? SHAKE>
        <COND (,WET-WICK <TELL "Drops fly off and patter on your shoes, but the reed stays dark and soaked right through." CR>)
              (T <TELL "It makes a faint dry rattle, like a straw with a seed inside." CR>)>)
       (<VERB? SQUEEZE>
        <COND (,WET-WICK <TELL "A trickle of cold water runs over your thumb. There's plenty more inside." CR>)
              (T <TELL "It crackles faintly. There isn't a drop of water in it." CR>)>)
       (<VERB? LOOK-INSIDE>
        <COND (,WET-WICK <TELL "Peering into the end, you see water shining inside the hollow stem." CR>)
              (T <TELL "You squint through the hollow stem like a tiny telescope. It's empty, and you can see daylight at the other end." CR>)>)>>
<ROUTINE TILE-F ()
 <COND (<VERB? EXAMINE READ>
        <SETG PATTERN-KNOWN T>
        <TELL "There are no words on the tile, only three painted pictures in a row, like a lesson for someone too young to read. First, a reed wick standing in a bowl of water. Second, the wick tucked into a hole in the bell's roots. Third, three white leaves floating out through an open shutter. Underneath, someone painted a fourth leaf, then thought better of it and crossed it out." CR>)
       (<VERB? RUB>
        <TELL "The paint is smooth and a little chipped. Many fingers have traced these pictures before yours." CR>)
       (<VERB? SMELL>
        <TELL "Old paint and dust, with a hint of linseed oil." CR>)
       (<VERB? LOOK-UNDER>
        <COND (<IN? ,WICK ,STORE> <TELL "On the shelf underneath lies a short [[reed wick]], set there carefully, as if someone meant you to find it." CR>)
              (T <TELL "There's a clean, wick-shaped patch on the dusty shelf where the wick used to lie." CR>)>)
       (<VERB? MOVE SPIN>
        <TELL "The tile is fixed firmly to the wall. The painted pictures must be read from left to right, not turned like a wheel." CR>)
       (<VERB? KNOCK>
        <TELL "Tok, tok. Solid baked clay, fixed fast to the wall." CR>)
       (<VERB? TAKE>
        <TELL "The tile is fixed firmly to the wall. It's meant to stay here for the next person who needs it." CR>)>>
<ROUTINE BUNDLES-F ()
 <COND (<VERB? EXAMINE SEARCH>
        <TELL "Dozens of long reeds, tied in bundles with string, waiting to be cut into wicks someday. They are long and bent and green at the ends. The one good wick has already been cut and laid on the shelf." CR>)
       (<VERB? TAKE MOVE PULL>
        <TELL "You pull out one long reed, look at it, and push it back. It's far too long and crooked to fit anything. The bundles rustle as if they're settling down again." CR>)
       (<VERB? SMELL>
        <TELL "They smell like a hayloft in summer." CR>)
       (<VERB? RUB LISTEN>
        <TELL "When you brush them, the reeds whisper against each other like people sharing a secret." CR>)>>
<ROUTINE SPOUT-F ()
 <COND (<VERB? EXAMINE>
        <SETG SPOUT-SEEN T>
        <COND (,FLOWING <TELL "The brass mouth of the spout is pointing into the [[soaking bowl]]. It turns on a pin." CR>)
              (T <TELL "The brass mouth points past the [[soaking bowl]], so the spring water splashes away down a crack in the rocks. The spout sits on a pin; you could turn it to send the water into the bowl." CR>)>)
       (<VERB? SPIN>
        <SETG SPOUT-SEEN T>
        <COND (,FLOWING <SETG FLOWING <>> <TELL "You turn the spout away. The water splashes off into the rocks again, and the bowl drains through a hairline crack." CR>)
              (T <SETG FLOWING T> <TELL "You turn the spout with a squeak. Water gushes into the [[soaking bowl]], and the bowl fills faster than the crack leaks." CR>)>)
       (<AND <VERB? PUT PUT-ON> <EQUAL? ,PRSO ,WICK> <EQUAL? ,PRSI ,SPOUT>>
        <TELL "The jet would snatch the wick from your fingers. Turn the spout toward the [[soaking bowl]], where you can give the reed a proper drink." CR>)
       (<VERB? MOVE PUSH>
        <TELL "The spout wobbles on its pin. It's made for turning, not pushing." CR>)
       (<VERB? RUB>
        <TELL "The brass is icy cold and slick with spray. Your fingers come away tingling." CR>)
       (<VERB? LISTEN>
        <COND (,FLOWING <TELL "The water drums into the bowl with a happy, hollow sound." CR>)
              (T <TELL "The water gurgles out of the spout and chatters away into the rocks, past the bowl." CR>)>)
       (<VERB? SMELL>
        <TELL "Cold water and wet brass, like pennies in a puddle." CR>)
       (<VERB? TAKE>
        <TELL "The spout is set deep into the rock. It turns, but it won't come out." CR>)>>
<ROUTINE TROUGH-F ()
 <COND (<VERB? EXAMINE>
        <COND (,FLOWING <TELL "Clear water spills over the low edge of the bowl. It is just deep enough to soak something small, like a wick.">
               <COND (<HELD? ,WICK> <TELL " You hold the [[reed wick]] above the water.">)>
               <CRLF>)
              (T <TELL "The stone bowl is empty except for a hairline crack along the bottom. The [[turning spout]] is near enough to fill it, if it pointed this way." CR>)>)
       (<AND <VERB? PUT PUT-ON> <EQUAL? ,PRSO ,WICK> <EQUAL? ,PRSI ,TROUGH>>
        <COND (,FLOWING <SETG WET-WICK T> <TELL "You dip the [[reed wick]] in the water. It goes dark from one end to the other as it drinks. You lift it out before it can float away." CR>)
              (T <TELL "The bowl is empty. The reed wouldn't get any wetter here." CR>)>)
       (<VERB? RUB>
        <COND (,FLOWING <TELL "The water is so cold it makes your fingers ache. You pull your hand out quickly." CR>)
              (T <TELL "The stone is dry and rough. Your finger finds the thin crack running along the bottom." CR>)>)
       (<VERB? LOOK-INSIDE SEARCH>
        <COND (,FLOWING <TELL "Your own face wobbles in the water, with the white sky behind it." CR>)
              (T <TELL "Nothing in there but the hairline crack and a little dry moss." CR>)>)
       (<VERB? LISTEN>
        <COND (,FLOWING <TELL "Big drops go plop in the bowl. Smaller drops answer from the crack underneath." CR>)
              (T <TELL "The empty bowl is quiet. All the chatter is coming from the spout beside it." CR>)>)
       (<VERB? SMELL>
        <TELL "It smells of wet stone, like the air after rain." CR>)
       (<VERB? DRINK DRINK-FROM>
        <COND (,FLOWING <TELL "You cup your hands in the bowl and drink. The water is so cold it makes your teeth ache." CR>)
              (T <TELL "The bowl is dry. There's nothing in it to drink." CR>)>)
       (<AND <VERB? TAKE MOVE> <EQUAL? ,PRSO ,TROUGH>>
        <TELL "The bowl is carved right out of the rock. It isn't going anywhere." CR>)>>
<ROUTINE SHUTTER-F ()
 <COND (<VERB? EXAMINE>
        <COND (<FSET? ,SHUTTER ,OPENBIT> <TELL "Fog moves through the open square. Far out beyond it, the neighbors have lit a lamp." CR>)
              (T <TELL "The shutter keeps the frost out in winter. It's held shut by a wooden peg that you can lift from this side." CR>)>)
       (<OR <VERB? OPEN> <AND <VERB? RAISE MOVE> <NOT <FSET? ,SHUTTER ,OPENBIT>>>>
        <COND (<FSET? ,SHUTTER ,OPENBIT> <TELL "It's already open." CR>)
              (T <FSET ,SHUTTER ,OPENBIT> <TELL "You lift the peg and swing the shutter open. Fog comes in as quietly as a cat." CR>)>)
       (<VERB? SPIN>
        <TELL "The shutter swings on hinges. The little peg is what keeps it shut." CR>)
       (<VERB? CLOSE>
        <COND (<FSET? ,SHUTTER ,OPENBIT>
               <FCLEAR ,SHUTTER ,OPENBIT> <TELL "You swing it closed. The shutter fits snugly in its frame again." CR>)
              (T <TELL "It's already closed." CR>)>)
       (<VERB? RAISE>
        <TELL "The peg is already lifted, and the shutter stands open." CR>)
       (<VERB? KNOCK>
        <COND (<FSET? ,SHUTTER ,OPENBIT> <TELL "You knock on the edge of the open shutter. The sound gets lost in the fog." CR>)
              (T <TELL "Knock, knock. The wood is cold, and frost crackles at the corners. Nobody answers. It would be easier to talk with it open." CR>)>)
       (<VERB? LISTEN>
        <COND (<FSET? ,SHUTTER ,OPENBIT> <TELL "Far across the hollow the three soft taps come again. They're still waiting." CR>)
              (T <TELL "Through the boards you can just hear three soft taps, very far away." CR>)>)
       (<VERB? RUB>
        <TELL "The wood is cold enough to sting. Little ferns of frost grow along the boards." CR>)
       (<VERB? SMELL>
        <COND (<FSET? ,SHUTTER ,OPENBIT> <TELL "The fog smells faintly of chimney smoke from the other village." CR>)
              (T <TELL "Cold wood and frost, like the inside of a winter coat." CR>)>)
       (<VERB? PUSH MOVE>
        <COND (<FSET? ,SHUTTER ,OPENBIT> <TELL "The shutter swings a little on its hinges and stays open." CR>)
              (T <TELL "It won't budge while the wooden peg holds it. You'd have to lift the peg and open it properly." CR>)>)
       (<VERB? LOOK-INSIDE LOOK-BEHIND>
        <COND (<FSET? ,SHUTTER ,OPENBIT> <TELL "You look out through the open square. Fog fills the hollow like milk in a bowl, and far across it a small lamp glows where the other village must be." CR>)
              (T <TELL "The shutter is closed. You'd have to open it to see out." CR>)>)
       (<VERB? THROUGH CLIMB-ON CLIMB-UP>
        <TELL "The shutter is a window, not a door. Beyond it the hill drops straight down into the fog, so you stay safely on the landing." CR>)>>
<ROUTINE FOG-F ()
 <COND (<VERB? EXAMINE>
        <TELL "The fog is thick and white, as soft as wool. It hides the whole hollow, so the other village can't see you and you can't see them." CR>)
       (<VERB? SMELL>
        <TELL "It smells of cold water and, very faintly, of somebody's chimney smoke." CR>)
       (<VERB? LISTEN>
        <COND (<AND <EQUAL? ,HERE ,LANDING> <NOT <FSET? ,SHUTTER ,OPENBIT>>> <TELL "The fog is quiet, but something taps far away on the other side of the boards." CR>)
              (T <TELL "You hear the little sounds the fog lets through: a drip, your breathing, then three far-off taps." CR>)>)
       (<VERB? TAKE RUB>
        <TELL "You close your hand around a wisp of fog. When you open it, there is only a cool damp spot on your palm." CR>)>>
<ROUTINE HOLLOW-F ()
 <COND (<VERB? EXAMINE>
        <TELL "Below the village the hill drops away into a wide hollow, filled to the brim with fog. The other village is somewhere on the far side, close enough to hear but much too far to shout to.">
        <COND (<AND <EQUAL? ,HERE ,LANDING> <FSET? ,SHUTTER ,OPENBIT>> <TELL " Through the open shutter you can see a small lamp glowing over there.">)>
        <CRLF>)
       (<VERB? LISTEN>
        <TELL "From across the hollow come three soft taps: tap, tap, tap. They are still waiting for an answer." CR>)
       (<VERB? YELL>
        <TELL "You call out, but the fog swallows your voice before it gets anywhere." CR>)>>
<ROUTINE COURT-YARD-F ()
 <COND (<VERB? EXAMINE>
        <TELL "Round grey cobbles, green with moss between them, and a low stone wall all around. The yard is just big enough for the whole village to stand in when the bell is rung, though today it's only you." CR>)
       (<VERB? LISTEN>
        <TELL "A drop ticks off the low wall. You wait for the next one and hear your own shoe squeak instead." CR>)
       (<VERB? RUB>
        <TELL "The moss is cold and springy, like a wet sponge." CR>)
       (<VERB? SMELL>
        <TELL "Wet stone and moss, the smell of a morning that hasn't warmed up yet." CR>)>>
<ROUTINE STORE-SHED-F ()
 <COND (<AND <VERB? PUT PUT-ON> <EQUAL? ,PRSI ,STORE-SHED>>
        <MOVE ,PRSO ,STORE>
        <TELL "You lay the " D ,PRSO " back on the shelf." CR>)
       (<VERB? EXAMINE>
        <COND (<IN? ,WICK ,STORE> <TELL "The shed is plain and tidy: wooden walls, a dusty floor, and a shelf under the tile where a short [[reed wick]] has been laid." CR>)
              (T <TELL "The shed is plain and tidy: wooden walls, a dusty floor, and an empty shelf under the tile." CR>)>)
       (<VERB? SMELL>
        <TELL "Dry grass and dust. It smells like summer has been stored in here for later." CR>)
       (<VERB? KNOCK>
        <TELL "The thin wooden wall goes bonk, and a little dust drifts down from the roof." CR>)>>
<ROUTINE SPRING-LEDGE-F ()
 <COND (<VERB? EXAMINE>
        <TELL "The ledge is a flat shelf of rock on the side of the hill, soft with moss. Stone steps are cut into the rock, worn hollow in the middle by many feet." CR>)
       (<VERB? RUB>
        <TELL "The moss is soft and soaking wet. Your fingers come away green." CR>)
       (<VERB? LOOK-UNDER>
        <TELL "You lift a corner of moss. Underneath, a tiny beetle hurries away to find a drier home." CR>)>>
<ROUTINE WATER-F ()
 <COND (<AND <VERB? PUT PUT-ON> <EQUAL? ,PRSI ,WATER> <EQUAL? ,PRSO ,WICK>>
        <COND (,FLOWING <PERFORM ,V?PUT ,WICK ,TROUGH> <RTRUE>)
              (T <TELL "The water splashes past too fast and runs off into the rocks. The wick would soak better standing in a bowl of still water." CR>)>)
       (<VERB? EXAMINE>
        <COND (,FLOWING <TELL "Clear, cold spring water pours from the spout into the [[soaking bowl]]." CR>)
              (T <TELL "Clear, cold spring water bubbles out of the hillside and through the brass spout, then splashes away into the rocks, missing the [[soaking bowl]] altogether." CR>)>)
       (<VERB? DRINK DRINK-FROM>
        <TELL "You cup your hands and drink. The water is so cold it makes your teeth ache, and it tastes of stone." CR>)
       (<VERB? RUB>
        <TELL "Brr! The spring water is icy cold." CR>)
       (<VERB? LISTEN>
        <TELL "It chatters and gurgles, as if it has a lot to say." CR>)
       (<VERB? TAKE>
        <TELL "It runs straight through your fingers. A bowl would hold it better." CR>)>>
<ROUTINE PLATFORM-F ()
 <COND (<VERB? EXAMINE>
        <TELL "A little stone platform at the very edge of the village, with a low wall and the square frost shutter set into it. Beyond the wall the hill drops straight down into the fog." CR>)
       (<VERB? LOOK-UNDER>
        <TELL "You peer over the edge. Far below, the fog rolls slowly, like milk being stirred." CR>)
       (<VERB? RUB>
        <TELL "The stones are cold and furry with frost." CR>)>>
<ROUTINE V-SCORE ("OPTIONAL" (ASK? T))
 <COND (<AND <IN? ,WICK ,BELL> ,WET-WICK <FSET? ,SHUTTER ,OPENBIT>>
        <TELL "The bell has a clear path across the fog." CR>)
       (T <TELL "The neighboring village is listening patiently." CR>)>>
