<SYNTAX SHOW OBJECT (HAVE) TO OBJECT (FIND ACTORBIT) = V-SHOW>
<SYNTAX HINT = V-WEATHER-HINT>
<SYNTAX TURN OBJECT = V-SPIN>
<SYNTAX WRAP OBJECT AROUND OBJECT = V-TIE>
<SYNTAX STEAM OBJECT OVER OBJECT = V-STEAM>
<SYNTAX CLEAR OBJECT WITH OBJECT (HELD CARRIED HAVE) = V-DIG>
<SYNTAX WRITE OBJECT = V-WRITE>
<SYNTAX CHOOSE OBJECT = V-CHOOSE-RAIN>
<SYNTAX DRIZZLE OBJECT = V-DRIZZLE>
<SYNTAX SHOWER OBJECT = V-SHOWER>

<ROUTINE V-VERSION ()
	<TELL "The Pocket Weather Bureau|Studio Null, 2026|Release " N ,RELEASEID CR>>

<ROUTINE GO ()
	<V-VERSION> <CRLF>
	<SETG COMPACT-ROOM-LISTS T>
	<SETG HERE ,DISPATCH> <SETG VERBOSE T> <SETG LIT T>
	<SETG WINNER ,ADVENTURER> <SETG PLAYER ,WINNER> <MOVE ,WINNER ,HERE>
	<TELL "You are the newest apprentice at the Pocket Weather Bureau, in a town so small it measures rain in a thimble. This morning your very first forecast got away from you: Nimbus, the town's only rain cloud, has slipped off to hide. The weather vane will not turn, the garden is thirsty, and the Postmaster wants the cloud brought back before the parade." CR CR>
	<TELL D ,HERE CR>
	<V-LOOK> <MAIN-LOOP> <AGAIN>>
<ROUTINE DISPATCH-F (RARG)
	<COND (<EQUAL? .RARG ,M-LOOK>
	 <TELL "You are in the Dispatch Post, a round office barely wider than a garden shed. The letter pigeonholes go right up to the ceiling, and rain beads on the brass dispatch bell on the counter.">
	 <COND (<AND ,AGREED <IN? ,MICA ,DISPATCH>> <TELL " Mica waits beside the bell for your revised forecast, her fingers still for once.">)
	       (<IN? ,MICA ,DISPATCH> <TELL " Postmaster Mica stands beside the bell with an unfinished forecast, tapping one foot.">)
	       (T <TELL " The Postmaster is out just now.">)>
	 <TELL " The warm terrace is north, and the kitchen, smelling of baking, is west. The archive is down to the south, and the forecast balcony is east." CR>)>>
<ROUTINE TERRACE-F (RARG)
	<COND (<EQUAL? .RARG ,M-LOOK>
	 <TELL "You are on the Warm Tile Terrace, a flat stretch of red roof behind the post. Warm from the morning, the tiles tick and click underfoot.">
	 <COND (,PUBLISHED
	        <COND (<IN? ,CLOUD ,TERRACE> <TELL " Nimbus the cloud hovers just above them as the revised forecast hums overhead.">)
	              (T <TELL " The revised forecast hums overhead.">)>)
	       (<AND ,AGREED <IN? ,CLOUD ,TERRACE>> <TELL " Nimbus the cloud hovers just above them, ready to choose the rain together.">)
	       (,WIND-KNOWN <TELL " A steady breeze blows from the hollow toward the garden, and the vane overhead swings with it.">)
	       (<IN? ,ROOK ,ROOKERY> <TELL " High overhead, the vane is stuck fast, though the air is moving.">)
       (T <TELL " High overhead, the vane rocks free for the first time today. Up on the perch you could test where the wind will carry the rain.">)>
	 <TELL " The dispatch post is back to the south, and the rain garden lies east. The whisper arch is north, and a short ladder climbs up to the vane perch." CR>)>>
<ROUTINE VANE-DECK-F (RARG)
	<COND (<EQUAL? .RARG ,M-LOOK>
	 <TELL "You are on the Weathercock Perch, a little railed ledge at the very top of the post. The weather vane stands here, a brass rooster riding a long arrow. Far below, the warm tiles of the terrace look like fish scales.">
	 <COND (<IN? ,ROOK ,ROOKERY> <TELL " The arrow does not move at all; something in the rookery seems to be holding its counterweight.">)
	       (T <TELL " Aster the rook sits on the rail beside you, admiring his new treasure.">)>
	 <TELL " The ladder leads down to the terrace, and the rookery is west." CR>)>>
<ROUTINE ROOKERY-F (RARG)
	<COND (<EQUAL? .RARG ,M-LOOK>
	 <TELL "You are in the Button Rookery, a loft lined with untidy nests. Bottle tops and thimbles are wedged into them, and warm puffs of lemony soap drift up from the laundry below.">
	 <COND (<IN? ,ROOK ,ROOKERY> <TELL " Aster the rook stands with one foot on the vane's counterweight, humming a weather joke he never quite finishes.">)
	       (T <TELL " The nests are empty now, and the vane's counterweight swings free in the draught.">)>
	 <TELL " The vane perch is east, and the laundry is below, to the south." CR>)>>
<ROUTINE LAUNDRY-F (RARG)
	<COND (<EQUAL? .RARG ,M-LOOK>
	 <TELL "You are in the Pocket Laundry, a steamy little room criss-crossed with drying lines. Clothes pegs click in the warm air, and a tub of lemon suds stands underneath. A laundry apron hangs from a hook beside it">
	 <COND (<FSET? ,BUTTON ,INVISIBLE> <TELL ", its pockets bulging.">)
	 (T <TELL ", its pockets flat">
	    <COND (<AND <FSET? ,BUTTON ,NDESCBIT> <IN? ,BUTTON ,LAUNDRY>>
		   <TELL ", a brass button">
		   <COND (<AND <FSET? ,RIBBON ,NDESCBIT> <IN? ,RIBBON ,LAUNDRY>> <TELL " and a soft ribbon">)>
		   <TELL " at its foot">)
		  (<AND <FSET? ,RIBBON ,NDESCBIT> <IN? ,RIBBON ,LAUNDRY>> <TELL ", a soft ribbon at its foot">)>
	    <TELL ".">)>
	 <TELL " The kitchen is east, and the rookery is up to the north." CR>)>>
<ROUTINE KITCHEN-F (RARG)
	<COND (<EQUAL? .RARG ,M-LOOK>
	 <TELL "You are in the Steam Kitchen, where the Bureau's biscuits are baked. The air is warm and damp, and a fine dust of flour lies over everything. A steaming kettle puffs away on the stove, and Baker Pip ">
	 <COND (,AGREED <TELL "is planning biscuits shaped like commas: a pause you can eat.">)
	 (,REPORT-READ <TELL "has stopped humming and is quietly thinking.">)
	 (T <TELL "hums beside it very badly, with excellent rhythm.">)>
	 <TELL " The laundry is west, and the dispatch post is back to the east." CR>)>>
<ROUTINE GARDEN-F (RARG)
	<COND (<EQUAL? .RARG ,M-LOOK>
	 <TELL "You are in the Thimble Rain Garden, a patch of soil no bigger than a tablecloth. In the sun the thirsty seedlings curl their leaves into spoons, with nothing to catch.">
	 <COND (,GUTTER-READY <TELL " A freshly cleared gutter curls around their roots, waiting for rain.">)
	 (T <TELL " A narrow gutter winds between them, but a dry crust of soil blocks it.">)>
	 <TELL " The warm terrace is back to the west, and the seed shed stands to the east." CR>)>>
<ROUTINE SHED-F (RARG)
	<COND (<EQUAL? .RARG ,M-LOOK> <TELL "You are in the Seed Shed, a cramped wooden hut that smells of seed sacks and dry earth. A large rain chart is pinned to the back wall, its corners curling in the dry air. The only way out is back west to the garden." CR>)>>
<ROUTINE ARCH-F (RARG)
	<COND (<EQUAL? .RARG ,M-LOOK>
	 <TELL "You are beneath the Whisper Arch, a curved stone gateway draped in ivy. A wind chime of hard metal tubes hangs from its keystone.">
	 <COND (<IN? ,RIBBON ,CHIME> <TELL " With its clapper wrapped in the soft ribbon, it makes only a soft wooden chuckle, and you can hear the breeze again.">)
	 (T <TELL " It clangs so hard in every gust that words break against it.">)>
	 <TELL " Through the arch to the east lies Cloud Hollow, and the path runs back south to the terrace." CR>)>>
<ROUTINE HOLLOW-F (RARG)
	<COND (<EQUAL? .RARG ,M-LOOK>
	 <TELL "You are in Cloud Hollow, a round dip in the hillside carpeted with soft moss. It is cool and damp here, like the inside of a watering can.">
	 <COND (<IN? ,CLOUD ,HOLLOW> <TELL " Nimbus the cloud hangs just above your knees, so full of rain that it trembles.">)
	 (T <TELL " The cloud has gone, but the hollow still smells of rain that has decided where to go.">)>
	 <TELL " The only way out is back west through the whisper arch." CR>)>>
<ROUTINE ARCHIVE-F (RARG)
	<COND (<EQUAL? .RARG ,M-LOOK>
	 <TELL "You are in the Folded Yesterday Archive, a cool cellar where the Bureau keeps its old weather. It smells of old string and damp stone, and somewhere in the dark a drip keeps time.">
	 <COND (<FSET? ,WEATHERBOX ,OPENBIT> <TELL " The brass weatherbox stands open in the middle of the floor.">)
	       (T <TELL " In the middle of the floor sits a brass weatherbox, its corners cold and beaded with damp.">)>
	 <TELL " Steps lead back up north to the dispatch post." CR>)>>
<ROUTINE BROADCAST-F (RARG)
	<COND (<EQUAL? .RARG ,M-LOOK>
	 <TELL "You are on the Forecast Balcony, a narrow ledge above the town square. The parade bunting snaps below your knees, where the rows of little roofs begin.">
	 <COND (<AND ,PUBLISHED <IN? ,CARD ,SLOT>> <TELL " Your card hums its forecast from the broadcast slot in the railing">)
	       (,PUBLISHED <TELL " Your forecast hums through the broadcast slot in the railing">)
	       (<HELD? ,CARD> <TELL " Your card grows warm as you near the humming broadcast slot in the railing">)
	       (T <TELL " A broadcast slot in the railing hums softly, waiting for a forecast">)>
	 <COND (<IN? ,MICA ,BROADCAST> <TELL ", and Mica stands beside you, listening">)>
	 <TELL ". The dispatch post is back through the door to the west." CR>)>>

<ROUTINE BELL-F ()
	<COND (<VERB? EXAMINE> <TELL "The small, solid bell smells of wet brass. Its note cannot order anyone about.">
	 <COND (<AND <IN? ,CARD ,DISPATCH> <NOT <FSET? ,CARD ,TOUCHBIT>>>
	        <TELL " One corner of a blank weather card sticks out from under its base.">)>
	 <CRLF>)
	 (<VERB? LISTEN> <TELL "Even sitting still, the bell gives a faint brass hum whenever a door closes somewhere in the post." CR>)
	 (<VERB? SMELL> <TELL "Wet brass and a little rain, like a coin left out in the weather." CR>)
	 (<VERB? RUB> <TELL "The brass is cold and wet with rain beads. Your fingertip leaves a bright, dry stripe across it." CR>)
	 (<VERB? LOOK-UNDER LOOK-BEHIND SEARCH>
	  <COND (<AND <IN? ,CARD ,DISPATCH> <NOT <FSET? ,CARD ,TOUCHBIT>>> <TELL "You tip your head. A blank weather card is tucked under the bell's base, one corner showing." CR>)
	        (T <TELL "Only a ring of dust where the bell has stood for years." CR>)>)
	 (<VERB? PUSH MOVE> <TELL "The heavy bell slides half a finger. Its clapper gives a cross little tick.">
	  <COND (<AND <IN? ,CARD ,DISPATCH> <NOT <FSET? ,CARD ,TOUCHBIT>>> <TELL " A corner of the blank weather card peeks out from under it.">)> <CRLF>)
	 (<VERB? KICK ATTACK> <TELL "A bell is for calling people, not for kicking. You give it a polite nod instead." CR>)
	 (<VERB? RING>
	 <COND (<NOT <IN? ,MICA ,DISPATCH>> <TELL "Ting! The note hangs in the empty post. Mica is listening at the forecast balcony east." CR>)
	 (,AGREED <TELL "Ting! Mica bows. “Apprentice present. Cloud back by choice. A better sort of forecast.”" CR>)
	 (T <TELL "Ting! Mica bows. “Apprentice present. Cloud absent. See the forecast, then follow your observations.”" CR>)>)>>
<ROUTINE APRON-F ()
	<COND (<VERB? SMELL> <TELL "Lemon soap, flour and a little bit of kettle steam. It smells like Pip's busiest mornings." CR>)
	 (<VERB? RUB> <TELL "The cloth is stiff where the soap dried. The pockets feel lumpy under your hand." CR>)
	 (<VERB? TAKE WEAR> <TELL "It is Pip's working apron, and much too big for you. The pockets are another matter." CR>)
	 (<VERB? EXAMINE SEARCH LOOK-INSIDE LOOK-UNDER>
	 <COND (<FSET? ,BUTTON ,INVISIBLE>
	 <MOVE ,DETAIL-WOOL-THREAD ,LAUNDRY> <FCLEAR ,BUTTON ,INVISIBLE> <FCLEAR ,RIBBON ,INVISIBLE> <THIS-IS-IT ,BUTTON>
	 <TELL "The cloth is stiff with dried soap. You turn out the pockets. A brass button and a soft ribbon tumble free. Neither has an owner now. Pip believes in useful pockets." CR>)
	 (T <TELL "The pockets are empty. One has a round sun-faded patch where the button lay, and the other has a loose wool thread caught in its seam." CR>)>)>>
<ROUTINE BUTTON-F ()
	<COND (<VERB? EXAMINE> <TELL "A brass sun small enough for a rook to carry. Its old stitches have been carefully removed." CR>)
	 (<VERB? RUB> <TELL "You polish the button on your sleeve. The little sun shines brighter, as if it had just risen." CR>)
	 (<VERB? SMELL> <TELL "It smells of brass and lemon soap, like a coin that has been through the wash." CR>)
	 (<VERB? EAT> <TELL "It is a button, not a biscuit. Pip would be very disappointed in you." CR>)>>
<ROUTINE ROOK-F ()
	<COND (<VERB? PLAY> <TELL "Aster plays catch with a bottle top, tossing it up and snapping it out of the air. “Your turn,” he says, and keeps it." CR>)
	      (<VERB? EXAMINE> <COND (<IN? ,BUTTON ,ROOK> <TELL "Aster turns the brass button until its tiny sunrise catches his eye. His foot is off the counterweight." CR>)
	 (T <TELL "Aster's foot keeps the vane still. “Wind steals everything. Something shiny that stays mine would be fair exchange.”" CR>)>)
	 (<AND <VERB? GIVE> <EQUAL? ,PRSI ,ROOK>>
	 <COND (<EQUAL? ,PRSO ,BUTTON>
	 <COND (<AND <HELD? ,BUTTON> <ACCESSIBLE? ,BUTTON>>
	 <MOVE ,BUTTON ,ROOK> <MOVE ,ROOK ,VANE-DECK>
	 <TELL "Aster accepts the brass button. He releases the counterweight and hops east to the perch. “A fair exchange! You may turn the vane now.”" CR>)
	 (T <TELL "You must be holding the button to make the trade." CR>)>)
	 (T <TELL "Aster wants something bright, small, and his to keep. He refuses politely." CR>)>)
	 (<VERB? TELL>
	 <COND (<EQUAL? ,PRSI ,JOKE> <TELL "“I wondered whether the weather would weather the weather,” Aster says. “It did. I didn't.” He laughs at the correct volume for seven birds." CR>)
	 (<EQUAL? ,PRSI ,PROMISE> <TELL "“A trade is a promise with two ends,” says Aster. “No grabbing.”" CR>)
	 (T <COND (<IN? ,BUTTON ,ROOK> <TELL "“A fair trade lets things move,” Aster says. “The forecast is yours to check now. Promise kept. Want a joke?”" CR>) (T <TELL "“The forecast says downwind. The vane can't show you downwind while I'm holding it. A promise of a shiny trade might help. Or ask for a joke.”" CR>)>)>)
	 (<AND <VERB? SHOW> <EQUAL? ,PRSO ,BUTTON>> <TELL "Aster leans forward. “Yes. Give it to me, and the wind is yours.”" CR>)
	 (<VERB? LISTEN> <TELL "Aster hums under his breath, tries the first line of a joke, and stops just before the funny part." CR>)
	 (<VERB? RUB> <TELL "Aster lets you stroke one glossy black wing, then shuffles politely out of reach. “Feathers are not for trading.”" CR>)
	 (<VERB? KICK ATTACK> <TELL "Aster gives you a long, offended look. You decide that fair trades work better." CR>)>>
<ROUTINE VANE-F ()
	<COND (<VERB? EXAMINE READ>
	 <COND (,WIND-KNOWN <TELL "The vane shows a steady breeze toward the garden below. A cloud can travel that way without crossing the parade." CR>)
	 (<IN? ,ROOK ,ROOKERY> <TELL "The brass arrow is held perfectly still. Its counterweight reaches into the rookery west, where something is gripping it. Once free, the vane can be turned to test the wind." CR>)
	 (T <TELL "The counterweight is free. Turn the vane gently and let the breeze find its own direction." CR>)>)
	 (<VERB? SPIN>
	 <COND (<IN? ,ROOK ,ROOKERY> <TELL "It will not turn while Aster grips the counterweight in the rookery west." CR>)
	 (T <SETG WIND-KNOWN T> <TELL "You turn the vane gently, then let it find its own answer. The breeze runs from the hollow toward the rain garden, away from the parade. You have measured a safe route." CR>)>)
	 (<VERB? LISTEN> <COND (<IN? ,ROOK ,ROOKERY> <TELL "Not a creak. The vane is held so still that even its pole is silent." CR>) (T <TELL "The pole gives a soft, thinking squeak, like a door that might open." CR>)>)
	 (<VERB? RUB> <TELL "The brass rooster is warm from the sun on one side and cool on the other. Its tail feathers are worn smooth by years of wind." CR>)
	 (<VERB? PUSH MOVE KICK> <COND (<IN? ,ROOK ,ROOKERY> <TELL "You push. The vane does not budge; something at the other end of its counterweight is holding on tight." CR>) (T <TELL "A shove would only tell you which way you pushed. Better to turn it gently and let the wind answer." CR>)>)>>
<ROUTINE SPOON-F () <COND (<VERB? EXAMINE> <TELL "A narrow baking spoon. It could scoop a tiny channel without tugging any roots." CR>)
	 (<VERB? SMELL> <TELL "Vanilla and cinnamon. Somebody licked this spoon very recently." CR>)
	 (<VERB? RUB> <TELL "The bowl is narrow and smooth, worn thin at the tip from scraping the corners of mixing bowls." CR>)
	 (<VERB? WAVE> <TELL "You give the spoon one brisk circle. Anyone watching would assume you know how to conduct an orchestra of puddings." CR>)>>

<ROUTINE RIBBON-F ()
	<COND (<VERB? RUB> <TELL "The wool is soft and a little fuzzy. It would muffle anything you wrapped it around." CR>)
	 (<VERB? SMELL> <TELL "It smells of sheep and lemon soap." CR>)
	 (<VERB? EXAMINE> <TELL "Soft wool, long enough to pad a clapper. It can be tied and untied without a knot you need teeth for." CR>)
	 (<VERB? WAVE> <TELL "The ribbon makes a little sheep-shaped cloud in the air, then drops straight again." CR>)
	 (<VERB? WEAR> <TELL "You try the ribbon as a sash. It makes a very grand belt for a very small parcel, so you keep it free for useful work." CR>)
	 (<AND <VERB? TAKE> <IN? ,RIBBON ,CHIME>> <UNPAD-CHIME>)
	 (<VERB? TIE> <PAD-CHIME>)
	 (<VERB? UNTIE> <UNPAD-CHIME>)>>
<ROUTINE PAD-CHIME ()
	<COND (<NOT <OR <AND <EQUAL? ,PRSO ,RIBBON> <EQUAL? ,PRSI ,CHIME ,CHIME-CLAPPER>>
	 <AND <EQUAL? ,PRSO ,CHIME ,CHIME-CLAPPER> <EQUAL? ,PRSI ,RIBBON>>>>
	 <TELL "The ribbon can pad the wind chime if you tie those two together." CR>)
	 (<NOT <EQUAL? ,HERE ,ARCH>> <TELL "You need to be beside the chime." CR>)
	 (<IN? ,RIBBON ,CHIME> <TELL "The clapper is already padded. Its soft chuckle leaves room for words." CR>)
	 (<NOT <AND <HELD? ,RIBBON> <ACCESSIBLE? ,RIBBON>>> <TELL "You need the ribbon in your hands." CR>)
	 (T <MOVE ,RIBBON ,CHIME> <FSET ,RIBBON ,NDESCBIT> <TELL "You tie the soft ribbon around the chime's clapper. CLANG becomes tok.">
            <COND (<IN? ,CLOUD ,HOLLOW> <TELL " From the east, a small voice says, “Oh. There you are.”" CR>)
                  (T <TELL " In the quiet, you can hear the warm tiles ticking back to the south." CR>)>)>
	<RTRUE>>
<ROUTINE UNPAD-CHIME ()
	<COND (<AND <VERB? UNTIE>
                    <NOT <OR <AND <NOT ,PRSI> <EQUAL? ,PRSO ,RIBBON ,CHIME ,CHIME-CLAPPER>>
                             <AND <EQUAL? ,PRSO ,RIBBON> <EQUAL? ,PRSI ,CHIME ,CHIME-CLAPPER>>
                             <AND <EQUAL? ,PRSO ,CHIME ,CHIME-CLAPPER> <EQUAL? ,PRSI ,RIBBON>>>>>
               <TELL "Only the ribbon is tied around the clapper. That wouldn't loosen it." CR>)
              (<AND <EQUAL? ,HERE ,ARCH> <IN? ,RIBBON ,CHIME>>
	 <MOVE ,RIBBON ,WINNER> <FCLEAR ,RIBBON ,NDESCBIT> <TELL "You untie the ribbon and take it back. The chime clangs again. You can pad it again whenever you like." CR>)
	 (T <TELL "There is no padded clapper here to untie." CR>)> <RTRUE>>
<ROUTINE CHIME-F ()
	<COND (<VERB? RING>
           <COND (<IN? ,RIBBON ,CHIME> <TELL "You swing the padded clapper. Tok. You can still hear Nimbus." CR>)
                 (T <TELL "You swing the bare clapper. CLANG! The voice beyond the arch vanishes under the ringing." CR>)>)
          (<VERB? EXAMINE LISTEN>
	 <COND (<IN? ,RIBBON ,CHIME> <TELL "The ribbon softens each strike to tok. The clapper swings inside its wool wrap. Nimbus can be heard from east." CR>)
	 (T <TELL "The hard clapper strikes with a CLANG. Something soft tied around it would let you hear the voice beyond, to the east." CR>)>)
	 (<VERB? TIE> <PAD-CHIME>)
	 (<VERB? UNTIE> <UNPAD-CHIME>)
	 (<AND <VERB? TAKE> <EQUAL? ,PRSO ,CHIME>> <TELL "The chime is fixed here. Its clapper needs padding, not taking away." CR>)
	 (<VERB? RUB> <COND (<IN? ,RIBBON ,CHIME> <TELL "You still the tubes with your hand. Under the wool, the clapper gives a muffled bump." CR>) (T <TELL "You steady the tubes with your hand. They go quiet for a moment, then the next gust sets them clanging again." CR>)>)
	 (<VERB? PUSH KICK> <PERFORM ,V?RING ,CHIME>)>>
<ROUTINE GUTTER-F ()
	<COND (<VERB? RUB> <COND (,GUTTER-READY <TELL "The cleared channel is cool and smooth, shaped by the curve of the spoon." CR>) (T <TELL "The crust is hard and cracked, like the top of an overbaked pie. Fingers would only scratch it." CR>)>)
	 (<VERB? KICK> <TELL "A kick would send soil flying over the seedlings. This needs a gentler tool." CR>)
	 (<VERB? EXAMINE SEARCH>
	 <COND (,GUTTER-READY <TELL "A shallow channel curls around the seedlings, not through them. Rain can reach every root." CR>)
	 (T <TELL "Dry soil blocks the little channel. You could dig it clear with a narrow scoop; pulling the roots would hurt them." CR>)>)
	 (<VERB? DIG>
	 <COND (,GUTTER-READY <TELL "The gutter is already clear. The roots need no more disturbance." CR>)
	 (<NOT <EQUAL? ,PRSI ,SPOON>>
	 <TELL "That will not make the narrow, gentle scoop you need. ">
	 <COND (<AND <HELD? ,SPOON> <ACCESSIBLE? ,SPOON>> <TELL "Dig with the narrow spoon you are carrying." CR>)
	 (T <TELL "A narrow baking spoon would work. Bring it into reach and hold it before digging." CR>)>)
	 (<NOT <AND <HELD? ,SPOON> <ACCESSIBLE? ,SPOON>>> <TELL "You need to hold the spoon where you can reach it." CR>)
	 (T <SETG GUTTER-READY T> <TELL "You scoop the dry soil with the spoon, making a winding gutter around the seedlings. No roots break. A very small amount of rain will now reach them all." CR>)>)>>
<ROUTINE SEEDLINGS-F ()
	<COND (<VERB? EXAMINE>
	 <COND (,GUTTER-READY <TELL "Their roots wait beside your clear gutter. Enough rain to dampen the roots will be plenty; a flood would wash them out." CR>)
	 (T <TELL "Their small roots have lifted the dry soil like knuckles. A narrow gutter could share rain among them without flooding them." CR>)>)
	 (<VERB? TAKE MOVE> <TELL "These are growing things, not equipment. You leave their roots in the soil." CR>)
	 (<VERB? SMELL> <TELL "A green, peppery smell, faint and dry. Watered, they would smell much stronger." CR>)
	 (<VERB? RUB> <TELL "The leaves are soft, but limp and warm from the sun. One perks up a little when your shadow falls on it." CR>)>>
<ROUTINE CHART-F ()
	<COND (<VERB? EXAMINE READ> <TELL "The chart shows rain passing downwind into a winding garden channel. One picture has no words at all: a small hand raised, and rain stopping.">
	 <COND (,WIND-KNOWN <TELL " The vane agrees with the picture: today's wind runs toward the garden." CR>)
	 (T <TELL " You will need to measure today's wind, not just trust a picture." CR>)>)
	 (<VERB? TAKE> <TELL "The chart is fixed here for everyone. Its pictures are easy to remember." CR>)
	 (<VERB? RUB> <TELL "The paper is dry and crackly. Someone long ago traced the garden channel so often that the line is worn shiny." CR>)
	 (<VERB? SMELL> <TELL "Old paper and seed dust. It makes you want to sneeze." CR>)>>
<ROUTINE WEATHERBOX-F ()
	<COND (<VERB? EXAMINE> <TELL "A little brass lip fits over the rim like the brim of a hat. ">
               <COND (<NOT <FSET? ,WEATHERBOX ,OPENBIT>> <TELL "Water runs off before it can reach the papers." CR>)
                     (<IN? ,REPORT ,WEATHERBOX> <TELL "Rain has spotted the lid, but the folded report inside is bone dry." CR>)
                     (T <TELL "A dry patch the size of the report shows where it lay." CR>)>)
	 (<VERB? KNOCK> <COND (<IN? ,REPORT ,WEATHERBOX> <TELL "Tonk. Something papery inside gives a soft shuffle." CR>) (T <TELL "Tonk. The box answers with an empty, hollow ring." CR>)>)
	 (<VERB? RUB> <TELL "The brass is cold and beaded with damp, but the water runs away along the lip instead of soaking in." CR>)
	 (<VERB? SMELL> <TELL "Damp brass outside, and something dry and papery from the gap under the lid." CR>)
	 (<VERB? SEARCH> <FSET ,WEATHERBOX ,OPENBIT> <FSET ,WEATHERBOX ,TOUCHBIT>
	 <COND (<IN? ,REPORT ,WEATHERBOX> <TELL "You open the weatherbox. Inside lies a tightly folded report." CR>)
	 (T <TELL "You open the weatherbox. You already removed its report." CR>)>)>>
<ROUTINE KETTLE-F ()
	<COND (<VERB? EXAMINE> <TELL "The kettle breathes a steady, gentle plume. Warm damp air relaxes a stubborn fold without tearing paper. Pip keeps the hot metal safely out of reach.">
	 <COND (<AND <IN? ,SPOON ,KITCHEN> <NOT <FSET? ,SPOON ,TOUCHBIT>>>
	        <TELL " A narrow spoon hangs by its handle beside the kettle.">)>
	 <COND (<AND <HELD? ,REPORT> <NOT ,REPORT-SOFT>> <TELL " Your folded report could be held over it.">)>
	 <CRLF>)
	 (<VERB? TAKE> <TELL "Pip tends the hot kettle. Bring something to its steam instead." CR>)
	 (<VERB? LISTEN> <TELL "It mutters, rattles its lid, and gives a long soft sigh, like someone settling into a chair." CR>)
	 (<VERB? SMELL> <TELL "Hot water, tin and a hint of peppermint tea." CR>)
	 (<VERB? RUB> <TELL "Pip catches your wrist just in time. “Hot! Steam is for paper, not fingers.”" CR>)>>
<ROUTINE REPORT-F ()
	<COND (<VERB? EXAMINE> <TELL "The old paper is folded so tightly it remembers the fold. ">
	 <COND (,REPORT-SOFT <TELL "It is soft enough to read now." CR>)
	 (T <TELL "Opening it dry would tear it. Warm steam could help: hold the report over the kettle in the kitchen." CR>)>)
	 (<VERB? STEAM> <STEAM-REPORT>)
	 (<VERB? CLOSE>
	  <COND (<FSET? ,REPORT ,OPENBIT> <FCLEAR ,REPORT ,OPENBIT>
	         <TELL "You lay the two halves together like butterfly wings. The soft fold closes without a crackle." CR>)
	        (T <TELL "It is already folded tight enough to hold yesterday in." CR>)>)
	 (<VERB? SMELL> <TELL "Dust and old ink, and faintly, something like a summer garden." CR>)
	 (<VERB? RUB> <COND (,REPORT-SOFT <TELL "The paper is soft and a little warm now, like a page left in the sun." CR>) (T <TELL "The folds are stiff and sharp. The paper crackles a warning under your thumb." CR>)>)
	 (<VERB? READ OPEN LOOK-INSIDE>
	 <COND (<NOT ,REPORT-SOFT> <TELL "The fold resists. Warm steam would relax it; dry pulling would tear the old paper." CR>)
	 (T <SETG REPORT-READ T> <FSET ,REPORT ,OPENBIT>
	 <TELL "The report says: “Yesterday: continuous rain, as ordered. Ludo asked Nimbus to stop. Nimbus said stopping would mean failing the Bureau. The parade went home. Ludo left this to say he wasn't cross with the cloud.”" CR>
	 <COND (<FSET? ,FLOWER ,INVISIBLE> <FCLEAR ,FLOWER ,INVISIBLE> <THIS-IS-IT ,FLOWER>
	 <TELL "A pressed flower slips free inside the opened report. Someone has flattened each blue petal with care." CR>)
	 (T <TELL "The report still remembers a small voice asking for a pause." CR>)>)>)>>
<ROUTINE STEAM-REPORT ()
	<COND (<NOT <AND <EQUAL? ,PRSO ,REPORT> <EQUAL? ,PRSI ,KETTLE>>> <TELL "Use the report and the kettle together; other objects would not gently relax that fold." CR>)
	 (<NOT <EQUAL? ,HERE ,KITCHEN>> <TELL "The kettle is in Pip's kitchen." CR>)
	 (<NOT <AND <HELD? ,REPORT> <ACCESSIBLE? ,REPORT>>> <TELL "You need to hold the report where you can reach it." CR>)
	 (,REPORT-SOFT <TELL "The report is already soft enough to read." CR>)
	 (T <SETG REPORT-SOFT T> <TELL "You hold the report in the kettle's gentle steam, safely above the hot metal. The fold uncurls like a waking leaf. Now you can read it." CR>)> <RTRUE>>
<ROUTINE FLOWER-F ()
	<COND (<VERB? EXAMINE> <TELL "A blue flower, pressed flat but carefully kept. A gift can say “I am not cross” long after its voice has gone home." CR>)
	 (<VERB? SMELL> <TELL "Very faintly, it still smells of yesterday's garden." CR>)
	 (<VERB? RUB> <TELL "The petals are thin as tissue. You touch them with one careful fingertip." CR>)
	 (<VERB? EAT> <TELL "This is somebody's gift. You keep it safe instead." CR>)>>
<ROUTINE PIP-F ()
	<COND (<VERB? PLAY> <TELL "Pip lets you shape a scrap of dough. You make a little cloud, and he sets it on the tray beside the real biscuits." CR>)
	      (<VERB? LISTEN> <COND (,REPORT-READ <TELL "Pip is quiet, but his fingers still tap a small, thoughtful beat on the table." CR>) (T <TELL "Pip hums a tune that is mostly wrong notes in exactly the right places." CR>)>)
	 (<VERB? SMELL> <TELL "Pip smells of warm butter and flour. He always does." CR>)
	 (<VERB? RUB> <TELL "Pip pats your hand and leaves a floury print on it. “There. Now you're part of the kitchen.”" CR>)
	 (<VERB? EXAMINE>
	 <COND (,AGREED <TELL "Pip's hands are already making tomorrow's celebration. He never waits for perfect weather to be kind." CR>)
	 (,REPORT-READ <TELL "Pip has set his work aside. “We thought obeying was enough. We should have listened.”" CR>)
	 (T <TELL "Pip measures very small things with great care.">
	 <COND (<IN? ,SPOON ,KITCHEN> <TELL " You may borrow the spoon.">)>
	 <TELL " Ask him about the forecast, yesterday, or a promise." CR>)>)
	 (<VERB? TELL>
	 <COND (<EQUAL? ,PRSI ,YESTERDAY> <TELL "“Emergency biscuit policy,” Pip says. “Everyone gets one. Especially if they think a mistake means they don't deserve one.”" CR>)
	 (<OR <EQUAL? ,PRSI ,PROMISE> <EQUAL? ,PRSI ,PAUSE>> <TELL "“Soft things still need boundaries,” Pip says. “A pause isn't a broken promise. It can be part of the promise.”" CR>)
	 (,GUTTER-READY <TELL "“The rain garden needs a little rain. Not all rain, everywhere.” Pip nods at the spoon's work. “Small tools. Careful work.”" CR>)
	 (T <TELL "“The rain garden needs a little rain. Not all rain, everywhere.” Pip nods at the spoon. “Small tools. Careful work.”" CR>)>)
	 (<AND <VERB? SHOW> <EQUAL? ,PRSO ,REPORT>>
	 <COND (,REPORT-READ <TELL "Pip reads it quietly. “Show Nimbus. Evidence is kinder than telling someone they shouldn't feel that way.”" CR>)
	 (T <TELL "“A fold remembers pressure,” Pip says. “The kettle's steam might persuade it to open. Hold your report over it.”" CR>)>)>>
<ROUTINE TOPIC-F ()
	<COND (<VERB? EXAMINE>
	 <COND (<EQUAL? ,PRSO ,FORECAST> <COND (,PUBLISHED <TELL "The new forecast gives the garden rain and everybody permission to pause." CR>)
	 (,AGREED <TELL "The official forecast still orders continuous rain over the parade. The promise you made with Nimbus must replace it: written on your card, approved by Mica, and broadcast." CR>)
	 (T <TELL "The official forecast orders continuous rain over the parade. Mica wants it delivered. Nimbus does not. You may need a revised forecast, not a captured cloud." CR>)>)
	 (<EQUAL? ,PRSO ,PROMISE>
	 <COND (,AGREED <TELL "You and Nimbus promised rain for the garden, a clear gutter for the roots, and a pause whenever anyone asks." CR>)
	 (T <TELL "A promise should say what you will do, and how someone can ask you to stop. Ask Nimbus about the pause before making one." CR>)>)
	 (<EQUAL? ,PRSO ,PAUSE>
	 <COND (,PAUSE-KNOWN <TELL "A pause means stopping to listen. If anyone says pause, the rain stops, and you decide together whether to go on." CR>)
	 (T <TELL "A pause means stopping to listen. Ask Nimbus what that would mean for the rain." CR>)>)
	 (<EQUAL? ,PRSO ,YESTERDAY>
	 <COND (,REPORT-READ <TELL "Yesterday, Ludo asked for a pause and nobody stopped. The report says he was not cross with the cloud." CR>)
	 (<NOT <IN? ,REPORT ,WEATHERBOX>> <TELL "Yesterday is folded tightly into the report from the archive." CR>)
	 (T <TELL "Yesterday left something folded away in the archive, south of the post." CR>)>)
	 (T <TELL "The tune keeps tripping over two words that sound alike: “whether” and “weather”. Aster is saving the last line. Ask him for it." CR>)>)>>

<ROUTINE CLOUD-F ()
	<COND (<VERB? PLAY> <TELL "You blow gently. Nimbus drifts back a little, then drifts closer, as if playing tag. A single drop lands on your nose." CR>)
	      (<VERB? SMELL> <TELL "The air beside Nimbus smells of rain on dry earth." CR>)
          (<VERB? EXAMINE>
	 <COND (,PUBLISHED <TELL "Nimbus is light around the edges. “Shall we drizzle or make a puddle-sized shower? Either way, anyone may ask for a pause.”" CR>)
	 (,AGREED <TELL "Nimbus floats without curling away. “We have a promise. Now let the whole town hear it through your forecast.”" CR>)
	 (,APOLOGY <TELL "Nimbus no longer hides its face. It wants to hear how tomorrow can be different. Ask about a pause, then talk about a promise." CR>)
	 (T <TELL "Rain hangs inside Nimbus like held breath. It is not a fierce cloud. It is a very full one. Listen before giving it another forecast." CR>)>)
	 (<VERB? LISTEN>
	 <COND (<AND <EQUAL? ,HERE ,HOLLOW> <NOT <IN? ,RIBBON ,CHIME>>> <TELL "The chime beyond the hollow shatters Nimbus's words. Soften it before trying to listen." CR>)
	 (,AGREED <TELL "“I can stop,” Nimbus whispers, trying the words without making them smaller. “I can stop, and still be good at rain.”" CR>)
	 (T <SETG LISTENED T> <TELL "You let Nimbus finish. “I didn't stop yesterday. They told me not to stop. Then everyone was unhappy. If I stay here, I can't do it wrong again.” The cloud waits. You do not fill the quiet with instructions." CR>)>)
	 (<AND <VERB? SHOW> <EQUAL? ,PRSI ,CLOUD>>
	 <COND (<AND <EQUAL? ,HERE ,HOLLOW> <NOT <IN? ,RIBBON ,CHIME>>> <TELL "Nimbus looks at what you hold, but the chime breaks every word. Make room for words first." CR>)
	 (<EQUAL? ,PRSO ,REPORT>
	 <COND (<NOT ,REPORT-READ> <TELL "Read the report first. Nimbus needs you to understand it, not merely hold it up." CR>)
	 (<NOT ,LISTENED> <TELL "Nimbus draws back. Listen before asking it to look at yesterday." CR>)
	 (T <SETG APOLOGY T> <TELL "Nimbus reads the report. “Ludo wasn't cross with me?” The rain inside loosens. You say the Bureau should have listened when Ludo asked. For the first time, Nimbus stops apologizing. “Then we need a different promise. One with a pause.”" CR>)>)
	 (<EQUAL? ,PRSO ,FLOWER> <TELL "Nimbus touches the flower with a cool edge. “Ludo kept the blue one for me.” A little of yesterday becomes something worth keeping." CR>)
	 (T <TELL "Nimbus looks, but it needs understanding rather than equipment. The old report might explain yesterday." CR>)>)
	 (<VERB? TELL>
	 <COND (<AND <EQUAL? ,HERE ,HOLLOW> <NOT <IN? ,RIBBON ,CHIME>>> <TELL "The chime breaks every sentence. Soften it before a conversation." CR>)
	 (<EQUAL? ,PRSI ,PAUSE> <SETG PAUSE-KNOWN T>
	 <TELL "“If anyone says pause, I stop,” Nimbus says. “Including me. We listen, then decide together whether to continue.">
	 <COND (,AGREED <TELL " That is our promise now.”" CR>)
	 (T <TELL " Could that be part of the promise?”" CR>)>)
	 (<AND ,PUBLISHED <EQUAL? ,PRSI ,LIGHT-DRIZZLE ,PUDDLE-SHOWER>>
	  <PERFORM ,V?EXAMINE ,PRSI> <RTRUE>)
	 (<EQUAL? ,PRSI ,PROMISE> <MAKE-PROMISE>)
	 (<EQUAL? ,PRSI ,YESTERDAY> <TELL "“I was good at following the forecast,” Nimbus says. “I wasn't good at listening.”">
	 <COND (,APOLOGY <TELL " The cloud says it without shrinking now." CR>)
	 (T <TELL " The old report may help you understand." CR>)>)
	 (T <CLOUD-FORECAST>)>)
	 (<VERB? DRIZZLE> <RAIN-ENDING <>>)
	 (<VERB? SHOWER> <RAIN-ENDING T>)
	 (<VERB? TAKE> <TELL "Nimbus is someone to ask, not something to carry." CR>)
	 (<VERB? RUB> <COND (,AGREED <TELL "Nimbus leans into your hand, cool and damp, and leaves a fine mist on your fingers." CR>) (T <TELL "Your hand goes in up to the wrist. It is cool and wet inside, and Nimbus shivers but does not pull away." CR>)>)
	 (<VERB? KICK ATTACK> <TELL "Nimbus has been ordered about enough already. You keep your feet to yourself." CR>)>>
<ROUTINE CLOUD-FORECAST ()
	<COND (<NOT ,LISTENED> <TELL "“The forecast tells me where to go, but never when to listen. Could you listen to me? Then we can talk about yesterday, a pause, and a promise.”" CR>)
	 (<NOT ,APOLOGY> <TELL "“You heard me,” Nimbus says. “But yesterday is still between us. Find out what happened, so we can understand it together.”" CR>)
	 (<NOT ,PAUSE-KNOWN> <TELL "“You understand yesterday now. What would a pause mean for tomorrow? Let's talk about that first.”" CR>)
	 (<NOT ,WIND-KNOWN> <TELL "“Where can the rain go safely? Measure the wind before we promise a route.”" CR>)
	 (<NOT ,GUTTER-READY> <TELL "“How will the roots receive it? Prepare the little gutter before we promise rain.”" CR>)
	 (<NOT ,AGREED> <TELL "“The route and roots are ready. Now we can talk about a promise we both want to keep.”" CR>)
	 (<NOT ,CARD-WRITTEN>
	 <TELL "“We have agreed,” Nimbus says. “Write our forecast on your ">
	 <COND (<HELD? ,CARD> <TELL "weather card">) (T <TELL "weather card">)>
	 <TELL " so the town can hear it too.”" CR>)
	 (<NOT ,CARD-APPROVED> <TELL "“Our forecast is written. Let Mica read the card before it goes out.”" CR>)
	 (<NOT ,PUBLISHED> <TELL "“Mica has approved our forecast. Put the card in the broadcast slot so everyone hears the pause rule.”" CR>)
	 (T <TELL "“The town has heard us. We can choose a drizzle or a shower, and pause whenever either of us needs.”" CR>)>>
<ROUTINE MAKE-PROMISE ()
	<COND (,AGREED <TELL "You have already made the promise. "> <CLOUD-FORECAST>)
	 (<NOT ,LISTENED> <TELL "Listen to Nimbus first. A promise cannot begin with another instruction." CR>)
	 (<NOT ,APOLOGY> <TELL "Nimbus needs to see that you understand yesterday. Read the old report, then show it to the cloud." CR>)
	 (<NOT ,PAUSE-KNOWN> <TELL "Ask Nimbus about the pause. You both need to know what stopping means." CR>)
	 (<NOT ,WIND-KNOWN> <TELL "Where will the rain go? Free and turn the vane above the terrace to measure a safe route." CR>)
	 (<NOT ,GUTTER-READY> <TELL "How will the roots receive it? Clear the garden's tiny gutter before promising rain." CR>)
	 (T <SETG AGREED T> <FCLEAR ,COMMA-BISCUITS ,INVISIBLE> <MOVE ,CLOUD ,TERRACE> <FCLEAR ,HOLLOW-SCENT ,INVISIBLE>
	 <TELL "You promise rain for the garden, a clear gutter for the roots, and a pause whenever anyone asks. Including Nimbus. The cloud unfolds. “Then I would like to come back.” It slips west and south to the warm terrace, keeping pace with no one but itself." CR>)> <RTRUE>>
<ROUTINE CARD-F ()
	<COND (<VERB? EXAMINE READ>
	 <COND (,CARD-APPROVED <TELL "Mica has approved your card: rain in the garden, measured by need; pause on request; Nimbus may pause too. It belongs in the broadcast slot east of the post." CR>)
	 (,CARD-WRITTEN <TELL "Your card records the garden route, the clear gutter, and the pause rule. Mica needs to read it before publication." CR>)
	 (T <TELL "An apprentice's blank weather card. Its soft surface takes words when a promise is ready. You can write on it once you and Nimbus have agreed." CR>)>)
	 (<VERB? RUB> <TELL "The card is soft and slightly furry, the kind of surface that drinks ink without smudging." CR>)
	 (<VERB? SMELL> <TELL "New paper, and a faint smell of the bell's wet brass." CR>)
	 (<VERB? WRITE>
	 <COND (<NOT <AND <HELD? ,CARD> <ACCESSIBLE? ,CARD>>> <TELL "Hold the card before writing on it." CR>)
	 (<NOT ,AGREED> <TELL "You have no agreement to write yet. Listen to Nimbus and make a promise together." CR>)
	 (,CARD-WRITTEN <TELL "The card already says what you and Nimbus promised. Let Mica read it." CR>)
	 (T <SETG CARD-WRITTEN T> <TELL "You write the wind route you measured and the gutter you cleared, then the part in the largest letters: PAUSE WHEN ANYONE ASKS. INCLUDING THE CLOUD. Mica should read this card before it goes out." CR>)>)
	 (<AND <VERB? PUT PUT-ON> <EQUAL? ,PRSI ,SLOT>> <PUBLISH-CARD>)>>
<ROUTINE MICA-F ()
	<COND (<VERB? PLAY> <TELL "Mica almost starts a game of I-spy, then remembers the parade. “Later,” she says, and very nearly smiles." CR>)
	      (<VERB? LISTEN> <COND (,PUBLISHED <TELL "Mica is humming along with the broadcast, a little off key." CR>) (T <TELL "Tap, tap, tap goes Mica's foot. She is counting the minutes until the parade." CR>)>)
	 (<VERB? SMELL> <TELL "Mica smells of ink, sealing wax and the rain on her sleeves." CR>)
	 (<VERB? EXAMINE>
	 <COND (,PUBLISHED <TELL "Mica looks smaller without a fixed answer, and rather more useful. “You listened all the way to a better forecast.”" CR>)
	 (,CARD-APPROVED <TELL "Mica's fingers are still for once. “Approved. The broadcast slot is east of the post.”" CR>)
	 (,CARD-WRITTEN <TELL "Mica listens without interrupting. “Show me the card. I should learn to sign a promise I did not invent.”" CR>)
	 (,AGREED <TELL "Mica listens without interrupting. “Write the card. I should learn to sign a promise I did not invent.”" CR>)
	 (T <TELL "Mica's fingers tap an impatient rhythm, then stop when you look. Ask about the forecast, yesterday, or a promise." CR>)>)
	 (<VERB? TELL>
	 <COND (<EQUAL? ,PRSI ,YESTERDAY> <TELL "“I filed the report without asking how Nimbus felt,” Mica admits. “It is in the archive south of the dispatch post. I should have opened yesterday before writing tomorrow.”" CR>)
	 (<OR <EQUAL? ,PRSI ,PROMISE> <EQUAL? ,PRSI ,PAUSE>>
	 <TELL "“If we can ask a cloud to work, it can ask us to stop,” Mica says slowly.">
	 <COND (,PUBLISHED <TELL " “The whole town has heard that now.”" CR>)
	 (,CARD-APPROVED <TELL " “I have signed it. The broadcast slot is east of the post.”" CR>)
	 (T <TELL " “Bring me the written card when you have agreed.”" CR>)>)
	 (,PUBLISHED <TELL "“The old forecast ordered rain over the parade,” Mica says. “The new one asks first. Nimbus is waiting for you on the terrace.”" CR>)
	 (,CARD-APPROVED <TELL "“The old forecast ordered rain over the parade,” Mica says. “Yours is approved. Put the card in the broadcast slot east of the post.”" CR>)
	 (T <TELL "“The forecast says continuous rain over the parade,” Mica begins. Then: “But observations come first. If the forecast is wrong, we change the forecast.”" CR>)>)
	 (<AND <VERB? GIVE SHOW> <EQUAL? ,PRSI ,MICA>>
	 <COND (<AND <NOT <EQUAL? ,PRSO ,CARD>> ,CARD-APPROVED> <TELL "Mica looks carefully. “Thank you. I should have looked this carefully yesterday.”" CR>)
	 (<NOT <EQUAL? ,PRSO ,CARD>> <TELL "Mica looks carefully. “Thank you. For publication, I need your written weather card.”" CR>)
	 (<NOT <AND <HELD? ,CARD> <ACCESSIBLE? ,CARD>>> <TELL "Bring the card where you can hand it to Mica." CR>)
	 (<NOT ,CARD-WRITTEN> <TELL "“It is still blank,” says Mica. “Make the promise with Nimbus, then write it on the card.”" CR>)
	 (,CARD-APPROVED <TELL "“Already approved,” says Mica. “The broadcast slot is east of the post.”" CR>)
	 (T <MOVE ,CARD ,MICA> <SETG CARD-APPROVED T> <MOVE ,CARD ,WINNER>
	 <TELL "Mica reads every line, approves the card, and hands it back. “I am sorry about yesterday. An instruction should never be louder than someone asking to stop. Put this in the broadcast slot east of the post.”" CR>)>)>>
<ROUTINE SLOT-F ()
	<COND (<VERB? EXAMINE LOOK-INSIDE>
	 <COND (,PUBLISHED
	 <COND (<IN? ,CARD ,SLOT> <TELL "The card rests in the slot.">)
	 (T <TELL "The slot is empty again.">)>
	 <TELL " The promise has already gone out to the town. Nimbus waits on the terrace north of the post; choose a drizzle or a shower there." CR>)
	 (T <TELL "The slot sends an approved written weather card to everyone. It will not publish a blank or unapproved card." CR>)>)
	 (<VERB? OPEN CLOSE> <TELL "The slot has no door. It is always open to an approved weather card." CR>)
	 (<VERB? LISTEN> <COND (,PUBLISHED <TELL "Through the slot comes your own forecast, said in a hundred small voices all over town." CR>) (T <TELL "A low, patient hum, like a radio waiting for its next song." CR>)>)
	 (<VERB? RUB> <TELL "The brass edges buzz gently against your fingertips." CR>)>>
<ROUTINE PUBLISH-CARD ()
	<COND (<NOT <AND <EQUAL? ,PRSO ,CARD> <EQUAL? ,PRSI ,SLOT>>> <TELL "The slot takes an approved weather card, not that." CR>)
	 (,PUBLISHED <TELL "The town has already heard the promise. Nimbus is waiting for your choice of rain." CR>)
	 (<NOT <AND <HELD? ,CARD> <ACCESSIBLE? ,CARD>>> <TELL "You need to be holding the card." CR>)
	 (<NOT ,CARD-APPROVED> <TELL "The slot gives the card back untouched. Mica must approve the written promise first." CR>)
	 (T <MOVE ,CARD ,SLOT> <FSET ,CARD ,NDESCBIT> <SETG PUBLISHED T> <MOVE ,MICA ,BROADCAST>
          <MOVE ,LIGHT-DRIZZLE ,TERRACE> <MOVE ,PUDDLE-SHOWER ,TERRACE>
	 <TELL "You place the card in the slot. Its quiet hum carries the garden route and the pause rule through town. Mica comes to listen beside you. “Now,” she says, “let the weather have the last word.” Nimbus waits on the terrace north of the post." CR>)> <RTRUE>>
<ROUTINE RAIN-NEXT-STEP ()
	<COND (,CARD-APPROVED <TELL "Mica has approved the card. Put it in the broadcast slot east of the post.”" CR>)
	 (,CARD-WRITTEN <TELL "Let Mica approve the card, then put it in the broadcast slot.”" CR>)
	 (T <TELL "Write your card, let Mica approve it, and put it in the broadcast slot.”" CR>)>>
<ROUTINE RAIN-ENDING (BIG?)
	<COND (<AND <EQUAL? ,HERE ,HOLLOW> <NOT <IN? ,RIBBON ,CHIME>>>
	 <TELL "Nimbus draws inward. The chime breaks its answer into sounds you cannot understand. Soften the chime before asking for rain." CR> <RTRUE>)
	 (<NOT ,LISTENED> <TELL "Nimbus curls tight around its rain. Listen to Nimbus first; another request can wait." CR> <RTRUE>)
	 (<NOT ,APOLOGY> <TELL "Nimbus holds its rain. You have heard its fear, but yesterday is still between you. Find out what happened and show that you understand." CR> <RTRUE>)
	 (<NOT ,AGREED> <TELL "Nimbus is ready to talk, but you have not agreed on a forecast together. Talk about a pause and a promise before choosing rain." CR> <RTRUE>)
	 (<NOT ,PUBLISHED> <TELL "Nimbus waits. “Our promise needs to reach the town first. "> <RAIN-NEXT-STEP> <RTRUE>)>
	<COND (.BIG? <TELL "You and Nimbus choose a small shower. Round drops drum the clear gutter; the seedlings drink, and one excellent puddle grows. Halfway through, Nimbus says, “Pause.” The rain stops at once. You both listen. Ludo puts one boot in the puddle and holds out the other, waiting. When Nimbus says “Ready,” you choose one last splash together." CR>)
	 (T <TELL "You and Nimbus choose a soft drizzle. Rain whispers down the clear gutter to every waiting root. Ludo's old flower would hardly bend under it. From the garden, Ludo calls “Pause.” Nimbus stops at once. This time, the small voice reaches everyone. A parade drummer catches her own stick in midair. In the quiet, you hear the last drop reach the bottom of the gutter." CR>)>
	<MOVE ,MICA ,DISPATCH>
	<TELL CR "Mica returns to the post and rings the dispatch bell once. Tomorrow's forecast has room for an apprentice's observations, a child's voice, and a cloud that can say no. Nimbus folds itself small enough to rest beside you, and leaves the pocket of air over your shoulder dry." CR CR "THE END -- A FORECAST YOU CAN KEEP" CR>
	<FINISH> <RTRUE>>
<ROUTINE V-SCORE ("OPTIONAL" (ASK? T))
	<TELL "Bureau record: ">
	<COND (,PUBLISHED <TELL "a promise published.">) (,AGREED <TELL "a promise made together.">)
	 (,APOLOGY <TELL "yesterday understood.">) (T <TELL "observations in progress.">)>
	<TELL " No deadline. Good weather work takes listening." CR>>
<ROUTINE V-WEATHER-HINT ("AUX" STAGE)
	<SET STAGE <COND (<NOT ,WIND-KNOWN> 1) (<NOT ,GUTTER-READY> 2) (<NOT ,REPORT-READ> 3) (<AND <NOT ,AGREED> <NOT <IN? ,RIBBON ,CHIME>>> 4) (<NOT ,LISTENED> 5) (<NOT ,APOLOGY> 6) (<NOT ,PAUSE-KNOWN> 7) (<NOT ,AGREED> 8) (<NOT ,CARD-WRITTEN> 9) (<NOT ,CARD-APPROVED> 10) (<NOT ,PUBLISHED> 11) (T 12)>>
	<COND (<NOT <EQUAL? .STAGE ,HINT-STAGE>> <SETG HINT-STAGE .STAGE> <SETG HINT-LEVEL 0>)>
	<COND (<L? ,HINT-LEVEL 3> <SETG HINT-LEVEL <+ ,HINT-LEVEL 1>>)>
	<TELL "Hint " N ,HINT-LEVEL " of 3: ">
	<COND
	 (<EQUAL? .STAGE 1> <COND (<EQUAL? ,HINT-LEVEL 1> <TELL "Who is holding the wind still?" CR>) (<EQUAL? ,HINT-LEVEL 2> <TELL "Aster in the rookery wants a fair trade. Search the laundry apron." CR>) (T <TELL "GIVE BUTTON TO ROOK, then TURN VANE on the perch." CR>)>)
	 (<EQUAL? .STAGE 2> <COND (<EQUAL? ,HINT-LEVEL 1> <TELL "Look at the garden roots. How could a little rain reach them all?" CR>) (<EQUAL? ,HINT-LEVEL 2> <TELL "A narrow scoop can clear the gutter without pulling roots. Borrow the kitchen spoon." CR>) (T <TELL "DIG GUTTER WITH SPOON." CR>)>)
	 (<EQUAL? .STAGE 3> <COND (<EQUAL? ,HINT-LEVEL 1> <TELL "What happened yesterday? Look for what the Bureau filed away." CR>) (<EQUAL? ,HINT-LEVEL 2> <TELL "Open the archive weatherbox. Bring its folded report to the warm kitchen." CR>) (T <TELL "STEAM REPORT OVER KETTLE, then READ REPORT." CR>)>)
	 (<EQUAL? .STAGE 4> <COND (<EQUAL? ,HINT-LEVEL 1> <TELL "A voice needs room between sounds. Listen at the whisper arch." CR>) (<EQUAL? ,HINT-LEVEL 2> <TELL "Something soft can pad the chime. The laundry apron has soft ribbon." CR>) (T <TELL "At the arch, TIE RIBBON TO CHIME." CR>)>)
	 (<EQUAL? .STAGE 5> <COND (<EQUAL? ,HINT-LEVEL 1> <TELL "Before another instruction, give Nimbus time to finish." CR>) (<EQUAL? ,HINT-LEVEL 2> <TELL "Cloud Hollow is east of the whisper arch. Listening is an action, too." CR>) (T <TELL "LISTEN TO CLOUD." CR>)>)
	 (<EQUAL? .STAGE 6> <COND (<EQUAL? ,HINT-LEVEL 1> <TELL "Nimbus needs to know you understand yesterday." CR>) (<EQUAL? ,HINT-LEVEL 2> <TELL "Old evidence can be kinder than saying someone should feel differently." CR>) (T <TELL "SHOW REPORT TO CLOUD." CR>)>)
	 (<EQUAL? .STAGE 7> <COND (<EQUAL? ,HINT-LEVEL 1> <TELL "How could the cloud safely stop doing a good job?" CR>) (<EQUAL? ,HINT-LEVEL 2> <TELL "Ask Nimbus what a pause would mean." CR>) (T <TELL "ASK CLOUD ABOUT PAUSE." CR>)>)
	 (<EQUAL? .STAGE 8> <COND (<EQUAL? ,HINT-LEVEL 1> <TELL "A route, a prepared garden, and permission to pause can become one promise." CR>) (<EQUAL? ,HINT-LEVEL 2> <TELL "Talk to Nimbus about making that promise together." CR>) (T <TELL "TELL CLOUD ABOUT PROMISE." CR>)>)
	 (<EQUAL? .STAGE 9> <COND (<EQUAL? ,HINT-LEVEL 1> <TELL "The town needs to hear what you and Nimbus agreed." CR>) (<EQUAL? ,HINT-LEVEL 2> <TELL "Take the weather card from the dispatch post. Give the promise written words." CR>) (T <TELL "WRITE CARD." CR>)>)
	 (<EQUAL? .STAGE 10> <COND (<EQUAL? ,HINT-LEVEL 1> <TELL "Mica must listen to the new promise too." CR>) (<EQUAL? ,HINT-LEVEL 2> <TELL "Bring the written card to Mica at the dispatch post." CR>) (T <TELL "GIVE CARD TO MICA." CR>)>)
	 (<EQUAL? .STAGE 11> <COND (<EQUAL? ,HINT-LEVEL 1> <TELL "A private promise should become public responsibility." CR>) (<EQUAL? ,HINT-LEVEL 2> <TELL "The forecast balcony east of the post has a broadcast slot." CR>) (T <TELL "PUT CARD IN SLOT." CR>)>)
	 (<EQUAL? .STAGE 12> <COND (<EQUAL? ,HINT-LEVEL 1> <TELL "What size of rain would you and Nimbus like?" CR>) (<EQUAL? ,HINT-LEVEL 2> <TELL "Nimbus waits on the terrace. Both choices keep the pause rule." CR>) (T <TELL "DRIZZLE CLOUD or SHOWER CLOUD." CR>)>)
	>>
<ROUTINE V-STEAM () <TELL "Warm damp air is useful for a stubborn paper fold, not for that." CR>>
<ROUTINE V-WRITE () <TELL "Write your weather card once you and Nimbus have agreed." CR>>
<ROUTINE V-CHOOSE-RAIN ()
	<COND (<AND <IN? ,CLOUD ,HERE> <EQUAL? ,PRSO ,LIGHT-DRIZZLE ,PUDDLE-SHOWER>>
	       <RAIN-ENDING <EQUAL? ,PRSO ,PUDDLE-SHOWER>>)
	      (T <TELL "Choose a drizzle or a shower with Nimbus on the terrace." CR>)>>
<ROUTINE V-DRIZZLE () <TELL "Rain is something to choose with Nimbus the cloud." CR>>
<ROUTINE V-SHOWER () <TELL "Rain is something to choose with Nimbus the cloud." CR>>

<ROUTINE V-SHOW () <TELL "That does not answer the question here. Try showing evidence to someone who needs it." CR>>

<ROUTINE OVERHEAD-VANE-F ()
    <COND (<VERB? READ SPIN> <TELL "The arrow is too high overhead. Climb up to the perch to reach it and read the wind." CR>)
          (<VERB? EXAMINE>
           <COND (<IN? ,ROOK ,ROOKERY> <TELL "The arrow stays put even when a feather blows past. You could see what holds it from the perch above." CR>)
                 (T <TELL "The tip of the arrow swings freely. From the perch you could read exactly where it points." CR>)>)>>

<ROUTINE ROOK-WEIGHT-F ()
    <COND (<VERB? RUB> <TELL "Smooth brass, rubbed bright on top where Aster likes to stand." CR>)
          (<VERB? PUSH MOVE> <PERFORM ,V?MOVE ,DETAIL-BRASS-PEAR>)
          (<VERB? EXAMINE>
           <COND (<IN? ,ROOK ,ROOKERY> <TELL "Aster’s toes curl around a brass pear at the end of the arm. With his weight on it the arrow cannot turn." CR>)
                 (T <TELL "The brass pear swings clear of the perch now. It balances the arrow at the other end." CR>)>)>>

<ROUTINE CLAPPER-F ()
    <COND (<VERB? RING PUSH> <PERFORM ,V?RING ,CHIME>)
          (<VERB? EXAMINE>
           <COND (<IN? ,RIBBON ,CHIME> <TELL "A dent has formed in the wool where it meets the rim. Even at the end of a swing, only the ribbon touches metal." CR>)
                 (T <TELL "The tip is as shiny as a newly polished spoon. It has worn a matching bright spot inside the rim." CR>)>)
          (<VERB? LISTEN> <PERFORM ,PRSA ,CHIME>)
          (<VERB? TIE> <PAD-CHIME>)
          (<VERB? UNTIE> <UNPAD-CHIME>)>>

<ROUTINE PICTURE-F ()
    <COND (<VERB? READ> <PERFORM ,PRSA ,CHART>)>>

<ROUTINE FORECAST-F ()
    <COND (<VERB? READ> <PERFORM ,V?EXAMINE ,FORECAST>)
          (T <TOPIC-F>)>>

<ROUTINE DETAIL-BRASS-PEAR-F ()
    <COND (<VERB? TAKE MOVE SPIN>
           <COND (<IN? ,ROOK ,ROOKERY> <TELL "Aster tightens his toes over the brass pear. The arm stays put." CR>)
                 (T <TELL "The pear swings back on its arm when you let go. Its stalk is screwed in tight." CR>)>)>>

<ROUTINE DETAIL-BRASS-LIP-F ()
    <COND (<VERB? OPEN RAISE> <PERFORM ,V?OPEN ,WEATHERBOX>)>>

<ROUTINE DETAIL-WOOL-THREAD-F ()
    <COND (<VERB? MOVE> <TELL "The seam puckers under your tug. You smooth it flat again before a stitch comes loose." CR>)>>

<ROUTINE DETAIL-BUBBLES-F ()
    <COND (<VERB? SMELL> <TELL "Lemon peel! The warm air carries the scent up from the laundry." CR>)
          (<VERB? RUB> <TELL "Pop! A wet circle is all that is left of the bubble on your finger." CR>)>>

<ROUTINE DETAIL-PLUME-F ()
    <COND (<VERB? RUB> <TELL "At the cool edge of the white plume, a bead of water settles on your hand." CR>)>>

<ROUTINE HOLLOW-SCENT-F ()
    <COND (<VERB? SMELL> <TELL "The first breath smells of wet earth. The next carries the sharp green smell of a crushed leaf." CR>)>>

<ROUTINE ROOKERY-SOAP-F ()
    <COND (<VERB? SMELL> <TELL "A clean lemon smell rises from the perch with each warm puff of air." CR>)>>

<ROUTINE TERRACE-TILES-F ()
    <COND (<VERB? LISTEN> <TELL "You shift your heel. Click. A softer click answers from the next tile." CR>)
          (<VERB? RUB> <TELL "The tiles are warm as fresh toast and slightly gritty with roof dust." CR>)
          (<VERB? KNOCK> <TELL "Tock, tock. Each tile has a slightly different note, like a very flat xylophone." CR>)>>

<ROUTINE POST-RAIN-F ()
    <COND (<VERB? RUB> <TELL "The beads are cold. They run together under your finger and drip off the bell's rim." CR>)
          (<VERB? DRINK EAT> <TELL "You catch one on your tongue. It tastes of brass and sky." CR>)>>

<ROUTINE HOLLOW-BREEZE-F ()
    <COND (<VERB? SMELL> <TELL "The breeze carries the cool, earthy smell of the hollow toward the garden." CR>)
          (<VERB? LISTEN> <TELL "It hums very quietly through the gaps between the tiles." CR>)>>

<ROUTINE COMMA-BISCUITS-F ()
    <COND (<VERB? EAT TAKE> <TELL "“Not yet!” says Pip. “They're still only a plan. Plans taste of nothing.”" CR>)
          (<VERB? SMELL> <TELL "Nothing yet but flour. Pip promises they will smell of butter by tomorrow." CR>)>>

<ROUTINE PIGEONHOLES-F ()
    <COND (<VERB? SEARCH LOOK-INSIDE TAKE> <TELL "Every slot holds somebody's folded forecast, addressed by street. None of them is addressed to you." CR>)
          (<VERB? RUB> <TELL "The wooden edges are worn round by years of quick fingers." CR>)>>

<ROUTINE LADDER-F ()
    <COND (<VERB? CLIMB-ON CLIMB-UP CLIMB-DOWN CLIMB-FOO>
           <COND (<EQUAL? ,HERE ,TERRACE>
                  <COND (<VERB? CLIMB-DOWN> <TELL "Your feet are already on the lowest tiles. The ladder goes up from here." CR>)
                        (T <GOTO ,VANE-DECK>)>)
                 (<VERB? CLIMB-UP> <TELL "You are at the top rung. The ladder only goes down from here." CR>)
                 (T <GOTO ,TERRACE>)>)
          (<VERB? RUB> <TELL "The iron rungs are sun-warm and slightly rough, good for small hands." CR>)>>

<ROUTINE PERCH-RAIL-F ()
    <COND (<VERB? RUB> <TELL "The rail is worn smooth by claws and gloves alike." CR>)
          (<VERB? LOOK-UNDER> <TELL "Far below, a cat on the terrace looks up at you and decides you are not interesting." CR>)>>

<ROUTINE NESTS-F ()
    <COND (<VERB? SEARCH TAKE LOOK-INSIDE>
           <COND (<IN? ,ROOK ,ROOKERY> <TELL "You leave the rooks' treasures where they are. Aster is watching, and a rook never forgets a thief." CR>)
                 (T <TELL "Aster is out on the perch. You spot a bottle top neatly tucked under a feather and leave it exactly as you found it." CR>)>)
          (<VERB? SMELL> <TELL "Twigs, feathers and a little lemon soap." CR>)>>

<ROUTINE LINES-F ()
    <COND (<VERB? RUB> <TELL "The socks on the line are still damp. One of them is warm, as if somebody has just taken a foot out of it." CR>)
          (<VERB? SMELL> <TELL "Lemon suds and clean cotton." CR>)
          (<VERB? TAKE> <TELL "That washing belongs to the whole Bureau. You let it dry." CR>)
          (<VERB? MOVE PUSH> <TELL "The line springs back and three pegs click in a row. One damp sock gives your nose a tiny slap." CR>)>>

<ROUTINE FLOUR-F ()
    <COND (<VERB? RUB> <TELL "You draw a little cloud in the flour with one finger. Pip nods, approving." CR>)
          (<VERB? SMELL> <TELL "Flour, butter and the iron smell of a hot stove." CR>)
          (<VERB? EAT> <TELL "Raw flour tastes of nothing much. Pip says biscuits are better." CR>)>>

<ROUTINE SACKS-F ()
    <COND (<VERB? SEARCH LOOK-INSIDE> <TELL "Seeds, seeds and more seeds: beans, peas and tiny black poppy seeds. Nothing else." CR>)
          (<VERB? SMELL> <TELL "Dry, dusty and a little sweet, like a cupboard of oats." CR>)
          (<VERB? RUB> <TELL "The seeds shift and rustle inside the sacking like sand." CR>)>>

<ROUTINE ARCH-STONE-F ()
    <COND (<VERB? LISTEN> <COND (<IN? ,RIBBON ,CHIME> <TELL "The arch carries every small sound, and from the east comes the hush of something breathing slowly." CR>) (T <TELL "The stones throw the chime's clang back at you twice over." CR>)>)
          (<VERB? RUB> <TELL "The stones are cool and furred with moss. Ivy roots grip every crack." CR>)>>

<ROUTINE MOSS-F ()
    <COND (<VERB? RUB> <TELL "The moss is soaked like a sponge. Your fingers come away wet." CR>)
          (<VERB? SMELL> <TELL "Green and earthy, like a forest after a shower." CR>)>>

<ROUTINE DRIP-F ()
    <COND (<VERB? LISTEN> <TELL "Plink. Plink. Plink. Steady as a clock, it never hurries and never stops." CR>)
          (<VERB? RUB> <TELL "You find the spot and catch a cold drop on your fingertip. The next one comes right on time." CR>)>>

<ROUTINE BUNTING-F ()
    <COND (<VERB? LISTEN> <TELL "The paper flags flutter and snap, and somewhere below a band is tuning up." CR>)
          (<VERB? TAKE RUB> <TELL "It is strung far below the balcony, out of reach." CR>)>>
