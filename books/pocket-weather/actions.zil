<SYNTAX SHOW OBJECT (HAVE) TO OBJECT (FIND ACTORBIT) = V-SHOW>
<SYNTAX HINT = V-WEATHER-HINT>
<SYNTAX TURN OBJECT = V-SPIN>
<SYNTAX STEAM OBJECT OVER OBJECT = V-STEAM>
<SYNTAX CLEAR OBJECT WITH OBJECT (HELD CARRIED HAVE) = V-DIG>
<SYNTAX WRITE OBJECT = V-WRITE>
<SYNTAX DRIZZLE OBJECT = V-DRIZZLE>
<SYNTAX SHOWER OBJECT = V-SHOWER>

<ROUTINE GO ()
	<SETG HERE ,DISPATCH> <SETG VERBOSE T> <SETG LIT T>
	<SETG WINNER ,ADVENTURER> <SETG PLAYER ,WINNER> <MOVE ,WINNER ,HERE>
	<TELL "THE POCKET WEATHER BUREAU" CR
	 "Your first morning as weather-post apprentice. One small raincloud has refused its forecast. Postmaster Mica has asked you to bring it back. There is time to find out why." CR CR>
	<V-LOOK> <MAIN-LOOP> <AGAIN>>
<ROUTINE DISPATCH-F (RARG)
	<COND (<EQUAL? .RARG ,M-LOOK>
	 <TELL "The [[dispatch bell->bell]] smells of wet brass.">
	 <COND (<IN? ,MICA ,DISPATCH> <TELL " [[Postmaster Mica->mica]] waits with an unfinished [[forecast]].">)>
	 <COND (,AGREED <TELL " For once, the post is waiting for the weather's permission.">)>
	 <TELL " The terrace is [[north]], the steam kitchen [[west]], the archive [[south]], and the forecast balcony [[east]]." CR>)>>
<ROUTINE TERRACE-F (RARG)
	<COND (<EQUAL? .RARG ,M-LOOK>
	 <TELL "Warm tiles tick under your feet.">
	 <COND (,PUBLISHED <TELL " The revised [[forecast]] hums through the air.">)
	 (,WIND-KNOWN <TELL " A steady breeze curls toward the garden.">)
	 (T <TELL " Above, the weather has stopped turning.">)>
	 <COND (<IN? ,CLOUD ,TERRACE> <TELL " [[Nimbus the cloud->cloud]] waits at shoulder height, ready to choose the rain together.">)>
	 <TELL " The post is [[south]], the garden [[east]], the whisper arch [[north]], and the vane perch [[up]]." CR>)>>
<ROUTINE VANE-DECK-F (RARG)
	<COND (<EQUAL? .RARG ,M-LOOK>
	 <TELL "The [[weather vane->vane]] is cool enough to sting your fingers.">
	 <COND (<IN? ,ROOK ,ROOKERY> <TELL " Its counterweight stretches into the rookery [[west]]; something there holds it still.">)
	 (T <TELL " [[Aster the rook->rook]] watches the free counterweight. The rookery is [[west]].">)>
	 <TELL " Warm tiles lie [[down]]." CR>)>>
<ROUTINE ROOKERY-F (RARG)
	<COND (<EQUAL? .RARG ,M-LOOK>
	 <COND (<IN? ,ROOK ,ROOKERY> <TELL "[[Aster the rook->rook]] grips the vane's counterweight with one black foot. He hums a [[weather joke->joke]] without telling it.">)
	 (T <TELL "The air can move again. The rookery is quieter.">)>
	 <TELL " The perch is [[east]]; the laundry smells of soap [[south]]." CR>)>>
<ROUTINE LAUNDRY-F (RARG)
	<COND (<EQUAL? .RARG ,M-LOOK>
	 <TELL "A [[laundry apron->apron]] hangs stiff with dried soap.">
	 <COND (<FSET? ,BUTTON ,INVISIBLE> <TELL " Its pockets bulge.">)
	 (T <TELL " Its empty pockets hang flat.">)>
	 <TELL " The kitchen is [[east]]; a rookery rustles [[north]]." CR>)>>
<ROUTINE KITCHEN-F (RARG)
	<COND (<EQUAL? .RARG ,M-LOOK>
	 <TELL "A [[steaming kettle->kettle]] breathes into the warm air. [[Baker Pip->pip]] ">
	 <COND (,AGREED <TELL "is planning biscuits shaped like commas: a pause you can eat.">)
	 (,REPORT-READ <TELL "has stopped humming. Yesterday is not as tidy as anyone thought.">)
	 (T <TELL "hums very badly, with excellent rhythm.">)>
	 <TELL " The laundry is [[west]]; the post is [[east]]." CR>)>>
<ROUTINE GARDEN-F (RARG)
	<COND (<EQUAL? .RARG ,M-LOOK>
	 <TELL "The [[seedlings]] smell peppery and dry.">
	 <COND (,GUTTER-READY <TELL " The [[gutter]] now curls around their roots, ready to share the rain.">)
	 (T <TELL " A crust of soil blocks their narrow [[gutter]].">)>
	 <TELL " Warm tiles lie [[west]]; the seed shed is [[east]]." CR>)>>
<ROUTINE SHED-F (RARG)
	<COND (<EQUAL? .RARG ,M-LOOK> <TELL "The air smells of last summer. A [[rain chart->chart]] curls at its edges. The garden is [[west]]." CR>)>>
<ROUTINE ARCH-F (RARG)
	<COND (<EQUAL? .RARG ,M-LOOK>
	 <COND (<IN? ,RIBBON ,CHIME> <TELL "The [[wind chime->chime]] makes a soft wooden chuckle. There is room between sounds.">)
	 (T <TELL "The [[wind chime->chime]] clangs so hard that words break against it.">)>
	 <TELL " Cloud Hollow lies [[east]]; the terrace is [[south]]." CR>)>>
<ROUTINE HOLLOW-F (RARG)
	<COND (<EQUAL? .RARG ,M-LOOK>
	 <COND (<IN? ,CLOUD ,HOLLOW> <TELL "[[Nimbus the cloud->cloud]] hovers just above your knees. Rain trembles inside it without falling.">)
	 (T <TELL "The hollow smells of rain that has decided where to go.">)>
	 <TELL " The whisper arch is [[west]]." CR>)>>
<ROUTINE ARCHIVE-F (RARG)
	<COND (<EQUAL? .RARG ,M-LOOK> <TELL "Cool air strokes the brass corners of the [[weatherbox]]. The post is [[north]]." CR>)>>
<ROUTINE BROADCAST-F (RARG)
	<COND (<EQUAL? .RARG ,M-LOOK>
	 <TELL "A [[broadcast slot->slot]] hums against your fingertips.">
	 <COND (<HELD? ,CARD> <TELL " Your [[card]] grows warm as you approach.">)>
	 <COND (,PUBLISHED <TELL " The town has heard the revised [[forecast]].">)>
	 <COND (<IN? ,MICA ,BROADCAST> <TELL " [[Mica]] waits to hear what the weather chooses.">)>
	 <TELL " The dispatch post is [[west]]." CR>)>>

<ROUTINE BELL-F ()
	<COND (<VERB? EXAMINE> <TELL "Small, solid, and made for ringing. Its note cannot order anyone about." CR>)
	 (<VERB? RING PULL>
	 <COND (<NOT <IN? ,MICA ,DISPATCH>> <TELL "Ting! The note hangs in the empty post. Mica is listening at the forecast balcony [[east]]." CR>)
	 (,AGREED <TELL "Ting! Mica bows. 'Apprentice present. Cloud back by choice. A better sort of [[forecast]].'" CR>)
	 (T <TELL "Ting! Mica bows. 'Apprentice present. Cloud absent. See the [[forecast]], then follow your observations.'" CR>)>)>>
<ROUTINE APRON-F ()
	<COND (<VERB? EXAMINE SEARCH LOOK-INSIDE LOOK-UNDER>
	 <COND (<FSET? ,BUTTON ,INVISIBLE>
	 <FCLEAR ,BUTTON ,INVISIBLE> <FCLEAR ,RIBBON ,INVISIBLE> <THIS-IS-IT ,BUTTON>
	 <TELL "You turn out the pockets. A [[brass button->button]] and a [[soft ribbon->ribbon]] tumble free. Neither has an owner now. Pip believes in useful pockets." CR>)
	 (T <TELL "The apron has surrendered its pocketful. No secret second pockets, unfortunately." CR>)>)>>
<ROUTINE BUTTON-F ()
	<COND (<VERB? EXAMINE> <TELL "A brass sun small enough for a rook to carry. Its old stitches have been carefully removed." CR>)>>
<ROUTINE ROOK-F ()
	<COND (<VERB? EXAMINE> <COND (<IN? ,BUTTON ,ROOK> <TELL "Aster turns the [[brass button->button]] until its tiny sunrise catches his eye. His foot is off the counterweight." CR>)
	 (T <TELL "Aster's foot keeps the vane still. 'Wind steals everything. Something shiny that stays mine would be fair exchange.'" CR>)>)
	 (<AND <VERB? GIVE> <EQUAL? ,PRSI ,ROOK>>
	 <COND (<EQUAL? ,PRSO ,BUTTON>
	 <COND (<AND <HELD? ,BUTTON> <ACCESSIBLE? ,BUTTON>>
	 <MOVE ,BUTTON ,ROOK> <MOVE ,ROOK ,VANE-DECK>
	 <TELL "Aster accepts the [[brass button->button]]. He releases the counterweight and hops [[east]] to the perch. 'A fair exchange! You may [[turn the vane->vane]] now.'" CR>)
	 (T <TELL "You must be holding the button to make the trade." CR>)>)
	 (T <TELL "Aster wants something bright, small, and his to keep. He refuses politely." CR>)>)
	 (<VERB? TELL>
	 <COND (<EQUAL? ,PRSI ,JOKE> <TELL "'I wondered whether the weather would weather the weather,' Aster says. 'It did. I didn't.' He laughs at the correct volume for seven birds." CR>)
	 (<EQUAL? ,PRSI ,PROMISE> <TELL "'A trade is a promise with two ends,' says Aster. 'No grabbing.'" CR>)
	 (T <COND (<IN? ,BUTTON ,ROOK> <TELL "'A fair trade lets things move,' Aster says. 'The [[forecast]] is yours to check now. [[Promise]] kept. Want a [[joke]]?'" CR>) (T <TELL "'The [[forecast]] says downwind. The vane can't show you downwind while I'm holding it. A [[promise]] of a shiny trade might help. Or ask for a [[joke]].'" CR>)>)>)
	 (<AND <VERB? SHOW> <EQUAL? ,PRSO ,BUTTON>> <TELL "Aster leans forward. 'Yes. Give it to me, and the wind is yours.'" CR>)>>
<ROUTINE VANE-F ()
	<COND (<VERB? EXAMINE>
	 <COND (,WIND-KNOWN <TELL "The vane shows a steady breeze toward the garden below. A cloud can travel that way without crossing the parade." CR>)
	 (<IN? ,ROOK ,ROOKERY> <TELL "The counterweight is gripped from the rookery [[west]]. Once free, the vane can be turned to test the wind." CR>)
	 (T <TELL "The counterweight is free. Turn the [[vane]] gently and let the breeze find its own direction." CR>)>)
	 (<VERB? SPIN>
	 <COND (<IN? ,ROOK ,ROOKERY> <TELL "It will not turn while Aster grips the counterweight in the rookery [[west]]." CR>)
	 (T <SETG WIND-KNOWN T> <TELL "You turn the [[vane]] gently, then let it find its own answer. The breeze runs from the hollow toward the rain garden, away from the parade. You have measured a safe route." CR>)>)>>
<ROUTINE SPOON-F () <COND (<VERB? EXAMINE> <TELL "A narrow baking spoon. It could scoop a tiny channel without tugging any roots." CR>)>>

<ROUTINE RIBBON-F ()
	<COND (<VERB? EXAMINE> <TELL "Soft wool, long enough to pad a clapper. It can be tied and untied without a knot you need teeth for." CR>)
	 (<VERB? TIE> <PAD-CHIME>)
	 (<VERB? UNTIE> <UNPAD-CHIME>)>>
<ROUTINE PAD-CHIME ()
	<COND (<NOT <OR <AND <EQUAL? ,PRSO ,RIBBON> <EQUAL? ,PRSI ,CHIME>>
	 <AND <EQUAL? ,PRSO ,CHIME> <EQUAL? ,PRSI ,RIBBON>>>>
	 <TELL "The ribbon can pad the [[wind chime->chime]] if you tie those two together." CR>)
	 (<NOT <EQUAL? ,HERE ,ARCH>> <TELL "You need to be beside the chime." CR>)
	 (<IN? ,RIBBON ,CHIME> <TELL "The clapper is already padded. Its soft chuckle leaves room for words." CR>)
	 (<NOT <AND <HELD? ,RIBBON> <ACCESSIBLE? ,RIBBON>>> <TELL "You need the ribbon in your hands." CR>)
	 (T <MOVE ,RIBBON ,CHIME> <TELL "You tie the [[soft ribbon->ribbon]] around the [[chime]]'s clapper. CLANG becomes tok. From [[east]], a small voice says, 'Oh. There you are.'" CR>)>
	<RTRUE>>
<ROUTINE UNPAD-CHIME ()
	<COND (<AND <EQUAL? ,HERE ,ARCH> <IN? ,RIBBON ,CHIME>>
	 <MOVE ,RIBBON ,WINNER> <TELL "You untie the [[ribbon]] and take it back. The [[chime]] clangs again. You can pad it again whenever you like." CR>)
	 (T <TELL "There is no padded clapper here to untie." CR>)> <RTRUE>>
<ROUTINE CHIME-F ()
	<COND (<VERB? EXAMINE LISTEN>
	 <COND (<IN? ,RIBBON ,CHIME> <TELL "The [[ribbon]] softens each strike to tok. Nimbus can be heard from [[east]]." CR>)
	 (T <TELL "The hard clapper strikes with a CLANG. Something soft tied around it would let you hear the voice beyond, to the [[east]]." CR>)>)
	 (<VERB? TIE> <PAD-CHIME>)
	 (<VERB? UNTIE> <UNPAD-CHIME>)
	 (<VERB? TAKE> <TELL "The chime is fixed here. Its clapper needs padding, not taking away." CR>)>>
<ROUTINE GUTTER-F ()
	<COND (<VERB? EXAMINE SEARCH>
	 <COND (,GUTTER-READY <TELL "A shallow channel curls around the [[seedlings]], not through them. Rain can reach every root." CR>)
	 (T <TELL "Dry soil blocks the little channel. You could dig it clear with a narrow scoop; pulling the [[roots->seedlings]] would hurt them." CR>)>)
	 (<VERB? DIG>
	 <COND (,GUTTER-READY <TELL "The gutter is already clear. The roots need no more disturbance." CR>)
	 (<NOT <EQUAL? ,PRSI ,SPOON>>
	 <TELL "That will not make the narrow, gentle scoop you need. ">
	 <COND (<AND <HELD? ,SPOON> <ACCESSIBLE? ,SPOON>> <TELL "Use the narrow spoon you are carrying: DIG GUTTER WITH SPOON." CR>)
	 (T <TELL "A narrow baking spoon would work. Bring it into reach and hold it before digging." CR>)>)
	 (<NOT <AND <HELD? ,SPOON> <ACCESSIBLE? ,SPOON>>> <TELL "You need to hold the spoon where you can reach it." CR>)
	 (T <SETG GUTTER-READY T> <TELL "You scoop the dry soil with the [[spoon]], making a winding [[gutter]] around the [[seedlings]]. No roots break. A very small amount of rain will now reach them all." CR>)>)>>
<ROUTINE SEEDLINGS-F ()
	<COND (<VERB? EXAMINE>
	 <COND (,GUTTER-READY <TELL "Their roots wait beside your clear [[gutter]]. Enough rain to dampen the roots will be plenty; a flood would wash them out." CR>)
	 (T <TELL "Their small roots have lifted the dry soil like knuckles. A narrow [[gutter]] could share rain among them without flooding them." CR>)>)
	 (<VERB? TAKE> <TELL "These are growing things, not equipment. You leave their roots in the soil." CR>)>>
<ROUTINE CHART-F ()
	<COND (<VERB? EXAMINE READ> <TELL "The [[chart]] shows rain passing downwind into a winding garden channel. One picture has no words at all: a small hand raised, and rain stopping. You will need to measure today's wind, not just trust a picture." CR>)
	 (<VERB? TAKE> <TELL "The chart is fixed here for everyone. Its pictures are easy to remember." CR>)>>
<ROUTINE WEATHERBOX-F ()
	<COND (<VERB? EXAMINE> <TELL "A brass weatherbox with an ordinary lid. It keeps yesterday's paperwork dry." CR>)
	 (<VERB? SEARCH> <FSET ,WEATHERBOX ,OPENBIT> <FSET ,WEATHERBOX ,TOUCHBIT>
	 <COND (<IN? ,REPORT ,WEATHERBOX> <TELL "You open the [[weatherbox]]. Inside lies a tightly [[folded report->report]]." CR>)
	 (T <TELL "You open the [[weatherbox]]. You already removed its report." CR>)>)>>
<ROUTINE KETTLE-F ()
	<COND (<VERB? EXAMINE> <TELL "The kettle breathes a steady, gentle plume. Warm damp air relaxes a stubborn fold without tearing paper. Pip keeps the hot metal safely out of reach." CR>)
	 (<VERB? TAKE> <TELL "Pip tends the hot kettle. Bring something to its steam instead." CR>)>>
<ROUTINE REPORT-F ()
	<COND (<VERB? EXAMINE> <TELL "The old paper is folded so tightly it remembers the fold. ">
	 <COND (,REPORT-SOFT <TELL "It is soft enough to read now." CR>)
	 (T <TELL "Opening it dry would tear it. Warm steam could help. You can STEAM REPORT OVER KETTLE in the kitchen." CR>)>)
	 (<VERB? STEAM> <STEAM-REPORT>)
	 (<VERB? READ OPEN LOOK-INSIDE>
	 <COND (<NOT ,REPORT-SOFT> <TELL "The fold resists. Warm steam would relax it; dry pulling would tear the old paper." CR>)
	 (T <SETG REPORT-READ T> <FSET ,REPORT ,OPENBIT>
	 <TELL "The [[report]] says: 'Yesterday: continuous rain, as ordered. Ludo asked Nimbus to stop. Nimbus said stopping would mean failing the Bureau. The parade went home. Ludo left this to say he wasn't cross with the cloud.'" CR>
	 <COND (<FSET? ,FLOWER ,INVISIBLE> <FCLEAR ,FLOWER ,INVISIBLE> <THIS-IS-IT ,FLOWER>
	 <TELL "A [[pressed flower->flower]] slips free inside the opened report. Someone has flattened each blue petal with care." CR>)
	 (T <TELL "The report still remembers a small voice asking for a pause." CR>)>)>)>>
<ROUTINE STEAM-REPORT ()
	<COND (<NOT <AND <EQUAL? ,PRSO ,REPORT> <EQUAL? ,PRSI ,KETTLE>>> <TELL "Use the report and the kettle together; other objects would not gently relax that fold." CR>)
	 (<NOT <EQUAL? ,HERE ,KITCHEN>> <TELL "The kettle is in Pip's kitchen." CR>)
	 (<NOT <AND <HELD? ,REPORT> <ACCESSIBLE? ,REPORT>>> <TELL "You need to hold the report where you can reach it." CR>)
	 (,REPORT-SOFT <TELL "The report is already soft enough to read." CR>)
	 (T <SETG REPORT-SOFT T> <TELL "You hold the [[report]] in the [[kettle]]'s gentle steam, safely above the hot metal. The fold uncurls like a waking leaf. Now you can read it." CR>)> <RTRUE>>
<ROUTINE FLOWER-F ()
	<COND (<VERB? EXAMINE> <TELL "A blue flower, pressed flat but carefully kept. A gift can say 'I am not cross' long after its voice has gone home." CR>)>>
<ROUTINE PIP-F ()
	<COND (<VERB? EXAMINE>
	 <COND (,AGREED <TELL "Pip's hands are already making tomorrow's celebration. He never waits for perfect weather to be kind." CR>)
	 (,REPORT-READ <TELL "Pip has set his work aside. 'We thought obeying was enough. We should have listened.'" CR>)
	 (T <TELL "Pip measures very small things with great care. You may borrow the [[spoon]]. Ask him about the [[forecast]], [[yesterday]], or a [[promise]]." CR>)>)
	 (<VERB? TELL>
	 <COND (<EQUAL? ,PRSI ,YESTERDAY> <TELL "'Emergency biscuit policy,' Pip says. 'Everyone gets one. Especially if they think a mistake means they don't deserve one.'" CR>)
	 (<EQUAL? ,PRSI ,PROMISE> <TELL "'Soft things still need boundaries,' Pip says. 'A [[pause]] isn't a broken promise. It can be part of the promise.'" CR>)
	 (T <TELL "'The rain garden needs a little rain. Not all rain, everywhere.' Pip nods at the [[spoon]]. 'Small tools. Careful work.'" CR>)>)
	 (<AND <VERB? SHOW> <EQUAL? ,PRSO ,REPORT>>
	 <COND (,REPORT-READ <TELL "Pip reads it quietly. 'Show Nimbus. Evidence is kinder than telling someone they shouldn't feel that way.'" CR>)
	 (T <TELL "'A fold remembers pressure,' Pip says. 'The [[kettle]]'s steam might persuade it to open. STEAM REPORT OVER KETTLE.'" CR>)>)>>
<ROUTINE TOPIC-F ()
	<COND (<VERB? EXAMINE>
	 <COND (<EQUAL? ,PRSO ,FORECAST> <COND (,PUBLISHED <TELL "The new forecast gives the garden rain and everybody permission to pause." CR>)
	 (T <TELL "The official forecast orders continuous rain over the parade. Mica wants it delivered. Nimbus does not. You may need a revised forecast, not a captured cloud." CR>)>)
	 (<EQUAL? ,PRSO ,PROMISE> <TELL "A promise should say what you will do, and how someone can ask you to stop. Ask Nimbus about the [[pause]] before making one." CR>)
	 (<EQUAL? ,PRSO ,PAUSE> <TELL "A pause means stopping to listen. Ask Nimbus what that would mean for the rain." CR>)
	 (<EQUAL? ,PRSO ,YESTERDAY> <TELL "Yesterday left something folded away in the archive, south of the post." CR>)
	 (T <TELL "Aster knows a weather joke. Whether it is funny is another question." CR>)>)>>

<ROUTINE CLOUD-F ()
	<COND (<VERB? EXAMINE>
	 <COND (,PUBLISHED <TELL "Nimbus is light around the edges. 'Shall we [[drizzle->cloud]] or make a puddle-sized [[shower->cloud]]? Either way, anyone may ask for a [[pause]].'" CR>)
	 (,AGREED <TELL "Nimbus floats without curling away. 'We have a [[promise]]. Now let the whole town hear it through your [[forecast]].'" CR>)
	 (,APOLOGY <TELL "Nimbus no longer hides its face. It wants to hear how tomorrow can be different. Ask about a [[pause]], then talk about a [[promise]]." CR>)
	 (T <TELL "Rain hangs inside Nimbus like held breath. It is not a fierce cloud. It is a very full one. Listen before giving it another [[forecast]]." CR>)>)
	 (<VERB? LISTEN>
	 <COND (<AND <EQUAL? ,HERE ,HOLLOW> <NOT <IN? ,RIBBON ,CHIME>>> <TELL "The chime beyond the hollow shatters Nimbus's words. Soften it before trying to listen." CR>)
	 (,AGREED <TELL "'I can stop,' Nimbus whispers, trying the words without making them smaller. 'I can stop, and still be good at rain.'" CR>)
	 (T <SETG LISTENED T> <TELL "You let Nimbus finish. 'I didn't stop yesterday. They told me not to stop. Then everyone was unhappy. If I stay here, I can't do it wrong again.' The cloud waits. You do not fill the quiet with instructions." CR>)>)
	 (<AND <VERB? SHOW> <EQUAL? ,PRSI ,CLOUD>>
	 <COND (<AND <EQUAL? ,HERE ,HOLLOW> <NOT <IN? ,RIBBON ,CHIME>>> <TELL "Nimbus looks at what you hold, but the chime breaks every word. Make room for words first." CR>)
	 (<EQUAL? ,PRSO ,REPORT>
	 <COND (<NOT ,REPORT-READ> <TELL "Read the report first. Nimbus needs you to understand it, not merely hold it up." CR>)
	 (<NOT ,LISTENED> <TELL "Nimbus draws back. Listen before asking it to look at yesterday." CR>)
	 (T <SETG APOLOGY T> <TELL "Nimbus reads the [[report]]. 'Ludo wasn't cross with me?' The rain inside loosens. You say the Bureau should have listened when Ludo asked. For the first time, Nimbus stops apologizing. 'Then we need a different [[promise]]. One with a [[pause]].'" CR>)>)
	 (<EQUAL? ,PRSO ,FLOWER> <TELL "Nimbus touches the [[flower]] with a cool edge. 'Ludo kept the blue one for me.' A little of yesterday becomes something worth keeping." CR>)
	 (T <TELL "Nimbus looks, but it needs understanding rather than equipment. The old report might explain [[yesterday]]." CR>)>)
	 (<VERB? TELL>
	 <COND (<AND <EQUAL? ,HERE ,HOLLOW> <NOT <IN? ,RIBBON ,CHIME>>> <TELL "The chime breaks every sentence. Soften it before a conversation." CR>)
	 (<EQUAL? ,PRSI ,PAUSE> <SETG PAUSE-KNOWN T>
	 <TELL "'If anyone says pause, I stop,' Nimbus says. 'Including me. We listen, then decide together whether to continue. Could that be part of the [[promise]]?'" CR>)
	 (<EQUAL? ,PRSI ,PROMISE> <MAKE-PROMISE>)
	 (<EQUAL? ,PRSI ,YESTERDAY> <TELL "'I was good at following the [[forecast]],' Nimbus says. 'I wasn't good at listening.' The old report may help you understand." CR>)
	 (T <CLOUD-FORECAST>)>)
	 (<VERB? DRIZZLE> <RAIN-ENDING <>>)
	 (<VERB? SHOWER> <RAIN-ENDING T>)
	 (<VERB? TAKE> <TELL "Nimbus is someone to ask, not something to carry." CR>)>>
<ROUTINE CLOUD-FORECAST ()
	<COND (<NOT ,LISTENED> <TELL "'The [[forecast]] tells me where to go, but never when to listen. Could you listen to me? Then we can talk about [[yesterday]], a [[pause]], and a [[promise]].'" CR>)
	 (<NOT ,APOLOGY> <TELL "'You heard me,' Nimbus says. 'But yesterday is still between us. Find out what happened, so we can understand it together.'" CR>)
	 (<NOT ,PAUSE-KNOWN> <TELL "'You understand yesterday now. What would a pause mean for tomorrow? Let's talk about that first.'" CR>)
	 (<NOT ,WIND-KNOWN> <TELL "'Where can the rain go safely? Measure the wind before we promise a route.'" CR>)
	 (<NOT ,GUTTER-READY> <TELL "'How will the roots receive it? Prepare the little gutter before we promise rain.'" CR>)
	 (<NOT ,AGREED> <TELL "'The route and roots are ready. Now we can talk about a promise we both want to keep.'" CR>)
	 (<NOT ,CARD-WRITTEN> <TELL "'We have agreed,' Nimbus says. 'Write our forecast on your weather card so the town can hear it too.'" CR>)
	 (<NOT ,CARD-APPROVED> <TELL "'Our forecast is written. Let Mica read the card before it goes out.'" CR>)
	 (<NOT ,PUBLISHED> <TELL "'Mica has approved our forecast. Put the card in the broadcast slot so everyone hears the pause rule.'" CR>)
	 (T <TELL "'The town has heard us. We can choose a drizzle or a shower, and pause whenever either of us needs.'" CR>)>>
<ROUTINE MAKE-PROMISE ()
	<COND (,AGREED <TELL "You have already made the promise. Now give it public words on your card and let Mica approve it." CR>)
	 (<NOT ,LISTENED> <TELL "Listen to Nimbus first. A promise cannot begin with another instruction." CR>)
	 (<NOT ,APOLOGY> <TELL "Nimbus needs to see that you understand yesterday. Read the old report, then show it to the cloud." CR>)
	 (<NOT ,PAUSE-KNOWN> <TELL "Ask Nimbus about the [[pause]]. You both need to know what stopping means." CR>)
	 (<NOT ,WIND-KNOWN> <TELL "Where will the rain go? Free and turn the vane above the terrace to measure a safe route." CR>)
	 (<NOT ,GUTTER-READY> <TELL "How will the roots receive it? Clear the garden's tiny gutter before promising rain." CR>)
	 (T <SETG AGREED T> <MOVE ,CLOUD ,TERRACE>
	 <TELL "You promise rain for the garden, a clear gutter for the roots, and a pause whenever anyone asks. Including Nimbus. The cloud unfolds. 'Then I would like to come back.' It slips [[west]] and south to the warm terrace, keeping pace with no one but itself." CR>)> <RTRUE>>
<ROUTINE CARD-F ()
	<COND (<VERB? EXAMINE READ>
	 <COND (,CARD-APPROVED <TELL "Mica has approved your [[card]]: rain in the garden, measured by need; pause on request; Nimbus may pause too. It belongs in the broadcast slot east of the post." CR>)
	 (,CARD-WRITTEN <TELL "Your [[card]] records the garden route, the clear gutter, and the pause rule. Mica needs to read it before publication." CR>)
	 (T <TELL "An apprentice's blank weather card. Its soft surface takes words when a promise is ready. You can WRITE CARD once you and Nimbus have agreed." CR>)>)
	 (<VERB? WRITE>
	 <COND (<NOT <AND <HELD? ,CARD> <ACCESSIBLE? ,CARD>>> <TELL "Hold the card before writing on it." CR>)
	 (<NOT ,AGREED> <TELL "You have no agreement to write yet. Listen to Nimbus and make a promise together." CR>)
	 (,CARD-WRITTEN <TELL "The card already says what you and Nimbus promised. Let Mica read it." CR>)
	 (T <SETG CARD-WRITTEN T> <TELL "You write the wind route you measured and the gutter you cleared, then the part in the largest letters: PAUSE WHEN ANYONE ASKS. INCLUDING THE CLOUD. Mica should read this [[card]] before it goes out." CR>)>)
	 (<AND <VERB? PUT PUT-ON> <EQUAL? ,PRSI ,SLOT>> <PUBLISH-CARD>)>>
<ROUTINE MICA-F ()
	<COND (<VERB? EXAMINE>
	 <COND (,PUBLISHED <TELL "Mica looks smaller without a fixed answer, and rather more useful. 'You listened all the way to a better forecast.'" CR>)
	 (,AGREED <TELL "Mica listens without interrupting. 'Write the [[card]]. I should learn to sign a [[promise]] I did not invent.'" CR>)
	 (T <TELL "Mica's fingers tap an impatient rhythm, then stop when you look. Ask about the [[forecast]], [[yesterday]], or a [[promise]]." CR>)>)
	 (<VERB? TELL>
	 <COND (<EQUAL? ,PRSI ,YESTERDAY> <TELL "'I filed the report without asking how Nimbus felt,' Mica admits. 'It is in the archive south of the dispatch post. I should have opened yesterday before writing tomorrow.'" CR>)
	 (<OR <EQUAL? ,PRSI ,PROMISE> <EQUAL? ,PRSI ,PAUSE>> <TELL "'If we can ask a cloud to work, it can ask us to stop,' Mica says slowly. 'Bring me the written [[card]] when you have agreed.'" CR>)
	 (T <TELL "'The [[forecast]] says continuous rain over the parade,' Mica begins. Then: 'But observations come first. If the forecast is wrong, we change the forecast.'" CR>)>)
	 (<AND <VERB? GIVE SHOW> <EQUAL? ,PRSI ,MICA>>
	 <COND (<NOT <EQUAL? ,PRSO ,CARD>> <TELL "Mica looks carefully. 'Thank you. For publication, I need your written weather card.'" CR>)
	 (<NOT <AND <HELD? ,CARD> <ACCESSIBLE? ,CARD>>> <TELL "Bring the card where you can hand it to Mica." CR>)
	 (<NOT ,CARD-WRITTEN> <TELL "'It is still blank,' says Mica. 'Make the promise with Nimbus, then WRITE CARD.'" CR>)
	 (,CARD-APPROVED <TELL "'Already approved,' says Mica. 'The broadcast slot is east of the post.'" CR>)
	 (T <MOVE ,CARD ,MICA> <SETG CARD-APPROVED T> <MOVE ,CARD ,WINNER>
	 <TELL "Mica reads every line, approves the [[card]], and hands it back. 'I am sorry about yesterday. An instruction should never be louder than someone asking to stop. Put this in the broadcast slot east of the post.'" CR>)>)>>
<ROUTINE SLOT-F ()
	<COND (<VERB? EXAMINE LOOK-INSIDE>
	 <COND (,PUBLISHED
	 <COND (<IN? ,CARD ,SLOT> <TELL "The [[card]] rests in the slot.">)
	 (T <TELL "The slot is empty again.">)>
	 <TELL " The promise has already gone out to the town. Nimbus waits on the terrace north of the post; choose a drizzle or a shower there." CR>)
	 (T <TELL "The slot sends an approved written weather card to everyone. It will not publish a blank or unapproved card." CR>)>)>>
<ROUTINE PUBLISH-CARD ()
	<COND (<NOT <AND <EQUAL? ,PRSO ,CARD> <EQUAL? ,PRSI ,SLOT>>> <TELL "The slot takes an approved weather card, not that." CR>)
	 (,PUBLISHED <TELL "The town has already heard the promise. Nimbus is waiting for your choice of rain." CR>)
	 (<NOT <AND <HELD? ,CARD> <ACCESSIBLE? ,CARD>>> <TELL "You need to be holding the card." CR>)
	 (<NOT ,CARD-APPROVED> <TELL "The slot gives the card back untouched. Mica must approve the written promise first." CR>)
	 (T <MOVE ,CARD ,SLOT> <SETG PUBLISHED T> <MOVE ,MICA ,BROADCAST>
	 <TELL "You place the [[card]] in the [[slot]]. Its quiet hum carries the garden route and the pause rule through town. [[Mica]] comes to listen beside you. 'Now,' she says, 'let the weather have the last word.' Nimbus waits on the terrace north of the post." CR>)> <RTRUE>>
<ROUTINE RAIN-ENDING (BIG?)
	<COND (<AND <EQUAL? ,HERE ,HOLLOW> <NOT <IN? ,RIBBON ,CHIME>>>
	 <TELL "Nimbus draws inward. The chime breaks its answer into sounds you cannot understand. Soften the chime before asking for rain." CR> <RTRUE>)
	 (<NOT ,LISTENED> <TELL "Nimbus curls tight around its rain. Listen to Nimbus first; another request can wait." CR> <RTRUE>)
	 (<NOT ,APOLOGY> <TELL "Nimbus holds its rain. You have heard its fear, but yesterday is still between you. Find out what happened and show that you understand." CR> <RTRUE>)
	 (<NOT ,AGREED> <TELL "Nimbus is ready to talk, but you have not agreed on a forecast together. Talk about a [[pause]] and a [[promise]] before choosing rain." CR> <RTRUE>)
	 (<NOT ,PUBLISHED> <TELL "Nimbus waits. 'Our promise needs to reach the town first. Write your card, let Mica approve it, and put it in the broadcast slot.'" CR> <RTRUE>)>
	<COND (.BIG? <TELL "You and Nimbus choose a small shower. Round drops drum the clear gutter; the seedlings drink, and one excellent puddle grows. Halfway through, Nimbus says, 'Pause.' The rain stops at once. You both listen. Then, together, you choose one last splash." CR>)
	 (T <TELL "You and Nimbus choose a soft drizzle. Rain whispers down the clear gutter to every waiting root. Ludo's old flower would hardly bend under it. From the garden, Ludo calls 'Pause.' Nimbus stops at once. This time, the small voice reaches everyone." CR>)>
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
<ROUTINE V-DRIZZLE () <TELL "Rain is something to choose with Nimbus the cloud." CR>>
<ROUTINE V-SHOWER () <TELL "Rain is something to choose with Nimbus the cloud." CR>>

<ROUTINE V-SHOW () <TELL "That does not answer the question here. Try showing evidence to someone who needs it." CR>>
