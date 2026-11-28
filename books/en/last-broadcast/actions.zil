<SYNTAX TURN OBJECT = V-SPIN>

<ROUTINE LB-KITCHEN-LOOK (RARG)
	<COND (<EQUAL? .RARG ,M-LOOK>
		<TELL "You are in the station kitchen, the only warm room in the building. A kettle ticks on the [[range]], and the [[window]] over the sink is black with rain. [[Edith]] Shaw, the island's doctor, sits at the scrubbed [[table]], where two [[cups]] of tea have gone cold. ">
		<COND (<FSET? ,LB-BAG ,OPENBIT> <TELL "Her [[medical bag]] stands open at her elbow.">)
			(T <TELL "Her [[medical bag]] rests at her elbow, its clasp shut.">)>
		<TELL " The hall is back to the [[east]], and a door to the west leads to the [[telegraph room->west]]." CR> <RTRUE>)>>

<ROUTINE LB-ARCHIVE-LOOK (RARG)
	<COND (<EQUAL? .RARG ,M-LOOK>
		<TELL "This is the record archive, a cold, narrow room that smells of damp cardboard. [[Shelves->shelves]] of numbered discs run from floor to ceiling on three sides. A draught from under the door stirs a drift of loose [[papers]] on the [[reading table]], where ">
		<COND (<FSET? ,LB-SLEEVE ,OPENBIT> <TELL "an open [[cardboard sleeve]] lies apart from the rest.">)
			(T <TELL "a single [[cardboard sleeve]] lies apart from the rest.">)>
		<TELL " The only way out is back west into the [[cutting room->west]]." CR> <RTRUE>)>>

<ROUTINE LB-CUTTING-LOOK (RARG)
	<COND (<EQUAL? .RARG ,M-LOOK>
		<TELL "This is where Saint Bride cuts voices into lacquer. The air is warm enough to bring out its pear-drop smell; after the rain it is almost sickly. ">
		<COND (<FSET? ,LB-CUTTER ,OPENBIT> <TELL "The [[cutter]] stands against the wall with its inspection cover lifted, its heavy arm folded over the turntable.">)
			(T <TELL "The [[cutter]] stands against the wall under its inspection cover, its heavy arm folded over the turntable.">)>
		<TELL " A fine [[curl of lacquer->lacquer curl]] lies beside it, and the [[register]] sits on a sloping stand. The control room is to the [[south]], and a door to the east opens into the [[archive->east]]." CR> <RTRUE>)>>

<ROUTINE LB-CONTROL-LOOK (RARG)
	<COND (<EQUAL? .RARG ,M-LOOK>
		<TELL "You are in the control room, next to the studio. [[Valves]] glow orange in their racks, and the air smells of warm dust. A small [[green light]] burns above them. ">
		<COND (<AND <IN? ,LB-STYLUS ,LB-PLAYER> <IN? ,LB-DISC ,LB-PLAYER>>
			<TELL "Nearby, the [[gramophone]] is ready to play, beside the [[routing switch]].">)
			(T <TELL "Nearby stands a spring-driven [[gramophone]], beside the [[routing switch]] that chooses what goes out on the air.">)>
		<TELL " The studio is back to the [[west]]. Doors lead north to the [[cutting room->north]] and south to the [[workshop->south]]." CR> <RTRUE>)>>

<ROUTINE LB-STATION-CLOCK-F ()
	<COND (<VERB? EXAMINE READ>
		<TELL "Salt has whitened the rim, but the glass still seals the face. The [[station clock]] is running: 9:35. Its spring movement does not depend on the generator. At 9:17 you heard the appeal begin; at 9:21 Ruth found Vane. You wrote both times in your [[casebook]]." CR>
		<RTRUE>)
		(<VERB? LISTEN> <TELL "Under the wind you can just hear it ticking, steady as a pulse. Whoever keeps it wound has kept it going through worse nights than this." CR> <RTRUE>)
		(<VERB? RUB> <TELL "The salt crust is gritty under your fingers and flakes away from the rim. The glass beneath is cold, and perfectly dry inside." CR> <RTRUE>)
		(<VERB? KNOCK> <TELL "The glass gives back a dull tap. The second hand does not so much as falter." CR> <RTRUE>)
		(<VERB? SPIN WIND> <TELL "There is no key in the case, and the clock needs no help from you. It is running perfectly well." CR> <RTRUE>)>>
<ROUTINE LB-CASEBOOK-F ()
	<COND (<VERB? EXAMINE READ>
		<TELL "The [[casebook]] has two columns: heard and seen. At 9:17 the appeal began; at 9:21 Vane was found. Your auditory note reads: two coughs, then “Even this old island can learn to speak.”" CR>
		<COND (,LB-CLOCK <TELL "Measured: the office hands date a voltage fault, not a death." CR>)>
		<COND (,LB-SOUND <TELL "Heard again: the appeal survives in a groove." CR>)>
		<COND (,LB-PROVENANCE <TELL "Authenticated: edge number, duration and cutting entry identify the recording." CR>)>
		<COND (,LB-ROUTE <TELL "Traversed: the service route bypasses the studio." CR>)>
		<COND (,LB-WEAPON <TELL "Matched: a brass rim, its notch and the wound." CR>)>
		<COND (,LB-TRACE <TELL "Matched: blood within a repaired heel and the passage print." CR>)>
		<COND (,LB-RUTH-CLEARED <TELL "Tested: the announcer mistook a heater lamp for a live feed." CR>)>
		<COND (,LB-EDITH-CLEARED <TELL "Tested: the doctor's bloodied dressing and her patient's interval agree." CR>)>
		<COND (,LB-TOMAS-CLEARED <TELL "Tested: mainland challenges place the operator at his key." CR>)>
		<COND (,LB-MOTIVE <TELL "Read and answered: wages, unissued shares, and a threatened destruction of the accounts." CR>)>
		<TELL "Notes record observations, not verdicts. Reconstructing the casebook organizes established facts. Its hint gives optional, explicit next-step guidance." CR> <RTRUE>)
		(<VERB? HINT> <LB-NEXT> <RTRUE>)
		(<VERB? RECONSTRUCT> <LB-RECONSTRUCT>)>>
<ROUTINE V-VERSION ()
	<TELL "The Last Broadcast|Studio Null, 2026|Release " N ,RELEASEID CR>>

<ROUTINE GO ()
	<V-VERSION> <CRLF>
	<SETG COMPACT-ROOM-LISTS T>
	<SETG HERE ,LB-LANDING> <SETG VERBOSE T> <SETG LIT T>
	<SETG FUMBLE-PROB 0>
	<SETG WINNER ,ADVENTURER> <SETG PLAYER ,WINNER>
	<MOVE ,WINNER ,HERE>
	<TELL "November 1936. You are an insurance investigator, sent out to Saint Bride, a wireless station on a rock off the coast, to value its transmitter before the owner sells it. Tonight a gale has cut the island off from the mainland, with five people in the station besides yourself.|At 9:17, from the loudspeaker in the hall, you heard a gull cough twice, then Ada's appeal to save the station: “Even this old island can learn to speak.” Four minutes later Ruth called for help. By then the station's owner, Julian Vane, was dead in his office. You stepped out onto the landing to think, and wrote both times in your [[casebook]].||">
	<TELL D ,HERE CR>
	<V-LOOK> <MAIN-LOOP>>

<SYNTAX USE OBJECT ON OBJECT = V-USE-ON>
<SYNTAX USE OBJECT WITH OBJECT = V-USE-WITH>
<SYNTAX COMPARE OBJECT WITH OBJECT = V-COMPARE>
<SYNTAX RECONSTRUCT OBJECT = V-RECONSTRUCT>
<SYNTAX HINT OBJECT = V-HINT>
<SYNTAX ACCUSE OBJECT (FIND ACTORBIT) (IN-ROOM) = V-ACCUSE>
<SYNTAX SHOW OBJECT TO OBJECT (FIND ACTORBIT) = V-SHOW>

<ROUTINE V-USE-WITH () <TELL "That tool does not fit this mechanism." CR>>
<ROUTINE V-USE-ON () <TELL "That is not the right tool for this job." CR>>
<ROUTINE V-COMPARE () <LB-COMPARE>>
<ROUTINE V-HINT () <TELL "For optional next-step guidance, HINT CASEBOOK." CR>>
<ROUTINE V-RECONSTRUCT () <TELL "Reconstruct the evidence in your [[casebook]]." CR>>
<ROUTINE V-SHOW () <TELL "That exhibit does not answer this person's difficulty." CR>>
<ROUTINE V-ACCUSE () <LB-ACCUSE>>

<ROUTINE LB-SLEEVE-F ()
	<COND (<VERB? EXAMINE READ>
		<TELL "A stiff [[sleeve]], marked REHEARSAL in pencil. ">
		<COND (<FSET? ,LB-SLEEVE ,OPENBIT>
			<TELL "Its flap is open. ">
			<COND (<IN? ,LB-DISC ,LB-SLEEVE> <TELL "A [[lacquer disc]] is inside.">) (T <TELL "It is empty.">)>)
			(T <TELL "Its flap is folded tight. Open it to inspect the contents.">)>
		<COND (<AND <IN? ,LB-LEDGER ,LB-ARCHIVE> <NOT <FSET? ,LB-LEDGER ,TOUCHBIT>>>
		       <TELL " Beneath the sleeve, the corner of a [[wage ledger]] pokes out.">)>
		<CRLF> <RTRUE>)
		(<VERB? SMELL> <TELL "Damp cardboard and pencil shavings." CR> <RTRUE>)
		(<VERB? RUB> <TELL "Stiff card, softened at the corners by handling." CR> <RTRUE>)
		(<VERB? LOOK-UNDER> <COND (<AND <IN? ,LB-LEDGER ,LB-ARCHIVE> <NOT <FSET? ,LB-LEDGER ,TOUCHBIT>>> <TELL "Under the sleeve, the corner of a [[wage ledger]] pokes out." CR>) (T <TELL "Nothing but the scarred top of the reading table." CR>)> <RTRUE>)>>
<ROUTINE LB-DISC-F ()
	<COND
		(<AND <VERB? ATTACK KICK> <EQUAL? ,PRSO ,LB-DISC>> <TELL "There is only one copy of those six minutes. You keep it intact." CR> <RTRUE>)
		(<VERB? EXAMINE READ>
		<TELL "An aluminium-based lacquer [[disc]], sixteen inches across. Edge number A17; one continuous band, about six minutes at the marked speed. It requires the control-room gramophone and a playback stylus. The edge is chipped; the groove is sound." CR>
		<RTRUE>)
		(<VERB? PLAY> <LB-PLAY>)
		(<VERB? COMPARE> <LB-COMPARE>)
		(<VERB? SHOW> <LB-SHOW>)
		(<VERB? SMELL> <TELL "Faintly of lacquer, and of the cardboard of its sleeve." CR> <RTRUE>)
		(<VERB? RUB> <TELL "You hold it by the edge, as any engineer would. A thumb on the groove would leave a print for the needle to play." CR> <RTRUE>)
		(<VERB? LISTEN> <TELL "Held to your ear, the groove is silent. It needs a needle and a turntable." CR> <RTRUE>)
		(<VERB? SHAKE> <TELL "You do not shake sixteen inches of lacquer. It would crack like ice on a pond." CR> <RTRUE>)>>
<ROUTINE LB-WORKBENCH-F ()
	<COND (<VERB? EXAMINE SEARCH>
		<TELL "A scrap of [[black felt]] covers one corner, well away from the solder burns.">
		<COND (<AND <IN? ,LB-STYLUS ,LB-WORKSHOP> <NOT <FSET? ,LB-STYLUS ,TOUCHBIT>>>
		       <TELL " A sapphire [[playback stylus]] glints against the felt.">)>
		<CRLF> <RTRUE>)
		(<VERB? SMELL> <TELL "Rosin flux and scorched varnish." CR> <RTRUE>)
		(<VERB? RUB> <TELL "The wood is pitted with little craters where hot solder has dropped." CR> <RTRUE>)
		(<VERB? KNOCK> <TELL "Tools jump and rattle along the bench. The felt in the corner hardly stirs." CR> <RTRUE>)
		(<VERB? LOOK-UNDER> <TELL "Under the bench are crates of spare valves, packed in straw." CR> <RTRUE>)>>
<ROUTINE LB-STYLUS-F ()
	<COND (<VERB? EXAMINE>
		<TELL "A sapphire playback [[stylus]], kept apart from the cutter to prevent a costly confusion. Its sapphire fits the control-room gramophone pickup. It is small enough to lose a fortune." CR> <RTRUE>)
		(<VERB? USE-ON>
			<COND (<EQUAL? ,PRSI ,LB-PLAYER> <LB-MOUNT>)
				(T <TELL "The stylus belongs on the control-room gramophone, not there." CR> <RTRUE>)>)
		(<VERB? RUB> <TELL "You keep your thumb off the sapphire tip. The steel shank is cool and finely made." CR> <RTRUE>)
		(<VERB? SHAKE> <TELL "It is so light you can hardly feel it move." CR> <RTRUE>)>>
<ROUTINE LB-PLAYER-F ()
	<COND (<VERB? EXAMINE SEARCH LOOK-INSIDE>
		<TELL "A spring-driven broadcast [[gramophone]]. The transmitter feed is disconnected, so any experiment will stay in this room." CR>
		<COND (<IN? ,LB-STYLUS ,LB-PLAYER> <TELL "The sapphire stylus is fitted to the pickup." CR>)
			(T <TELL "The pickup is bare; it takes the playback stylus from the workshop." CR>)>
		<COND (<IN? ,LB-DISC ,LB-PLAYER> <TELL "The [[lacquer disc]] rests on its platter." CR>)
			(T <TELL "The platter is empty; it wants the archive disc." CR>)>
		<COND (<AND <IN? ,LB-STYLUS ,LB-PLAYER> <IN? ,LB-DISC ,LB-PLAYER>> <TELL "It is ready to play." CR>)>
		<RTRUE>)
		(<VERB? USE-ON USE-WITH>
			<COND (<OR <AND <VERB? USE-ON> <EQUAL? ,PRSO ,LB-STYLUS>> <AND <VERB? USE-WITH> <EQUAL? ,PRSI ,LB-STYLUS>>> <LB-MOUNT>)
				(T <TELL "Only the workshop playback stylus fits the pickup." CR> <RTRUE>)>)
		(<VERB? PLAY LISTEN> <LB-PLAY>)
		(<AND <VERB? PUT PUT-ON> <EQUAL? ,PRSI ,LB-PLAYER> <EQUAL? ,PRSO ,LB-STYLUS>> <LB-MOUNT>)
		(<AND <VERB? PUT-ON> <EQUAL? ,PRSI ,LB-PLAYER> <EQUAL? ,PRSO ,LB-DISC>> <PERFORM ,V?PUT ,LB-DISC ,LB-PLAYER> <RTRUE>)
		(<VERB? PUT PUT-ON>
			<COND (<EQUAL? ,PRSI ,LB-PLAYER>
				<COND (<NOT <EQUAL? ,PRSO ,LB-DISC>> <TELL "Only the [[disc]] belongs on this platter." CR> <RTRUE>)>)>)
		(<VERB? OPEN CLOSE> <TELL "The platter stays open; the [[disc]] must lie flat on it." CR> <RTRUE>)
		(<VERB? SPIN> <TELL "You give the platter a push. It turns freely on its spindle and slowly comes to rest." CR> <RTRUE>)
		(<VERB? WIND> <TELL "You give the crank a few turns until the spring is firm. The motor is ready whenever a record is." CR> <RTRUE>)
		(<VERB? SMELL> <TELL "Machine oil and the faint, dusty sweetness of shellac." CR> <RTRUE>)
		(<VERB? RUB> <TELL "The turntable felt is soft and clean. Someone looks after this machine." CR> <RTRUE>)>>
<ROUTINE LB-MOUNT ()
	<COND (<IN? ,LB-STYLUS ,LB-PLAYER> <TELL "The pickup is already fitted." CR>)
		(<NOT <AND <HELD? ,LB-STYLUS> <ACCESSIBLE? ,LB-STYLUS> <ACCESSIBLE? ,LB-PLAYER>>>
		<TELL "You need the stylus in your hand, beside the gramophone, to fit it." CR>)
		(T <MOVE ,LB-STYLUS ,LB-PLAYER> <TELL "You fit the sapphire stylus to the pickup. It remains mounted on the gramophone until you take it again. ">
			<COND (<IN? ,LB-DISC ,LB-PLAYER> <TELL "The gramophone is ready to play." CR>)
				(T <TELL "The gramophone is ready for the archive disc." CR>)>)>
	<RTRUE>>
<ROUTINE LB-PLAY ()
	<COND (<NOT <ACCESSIBLE? ,LB-PLAYER>> <TELL "The playback apparatus is in the control room." CR>)
		(<NOT <IN? ,LB-DISC ,LB-PLAYER>> <TELL "Put the archive disc in the gramophone first." CR>)
		(<AND <NOT <IN? ,LB-STYLUS ,LB-PLAYER>> <HELD? ,LB-STYLUS>> <TELL "The pickup is bare. You are carrying the playback stylus; fit it to the gramophone first." CR>)
		(<NOT <IN? ,LB-STYLUS ,LB-PLAYER>> <TELL "The pickup is bare. Bring the stylus from the workshop and fit it to the gramophone." CR>)
		(T <SETG LB-SOUND T>
		<TELL "The [[disc]] turns. Ada's voice asks the mainland for help. A gull coughs twice; she says, “Even this old island can learn to speak.”|Two coughs, then that sentence: the sequence in your opening note, now turning beneath a needle. A later stutter repeats the first syllable with mechanical patience. This appeal existed in a groove before it was supposedly spoken live.|At the centre, a pencilled timing mark sets the start at 9:17. Six minutes would carry the voice past 9:22. Ruth in the studio may recognise the rehearsal; the cutting register can authenticate its origin." CR>)>
	<RTRUE>>

<ROUTINE LB-BOARD-F ()
	<COND (<VERB? EXAMINE READ>
		<TELL "The [[appeal board]] smells of fresh varnish. It lists tonight's order: 9:12 power test; 9:16 Ruth leaves office; 9:17 Ada speaks; 9:21 Ruth discovers Vane. Ruth wrote the last entry in a hand no longer fit for broadcasting. The two public times agree with your [[casebook]]." CR> <RTRUE>)
		(<VERB? SMELL> <TELL "Turpentine and new varnish. The board was lettered today." CR> <RTRUE>)
		(<VERB? RUB> <TELL "The varnish is still faintly tacky. Your fingertip leaves a print beside the 9:17 line, and you wipe it away with your handkerchief." CR> <RTRUE>)
		(<VERB? KNOCK> <TELL "Thin plywood, hollow as a drum. It rattles on its nail." CR> <RTRUE>)
		(<VERB? LOOK-BEHIND> <TELL "You tilt the board on its nail. Behind it is only a paler oblong of wall where an older notice used to hang." CR> <RTRUE>)>>

<ROUTINE LB-OFFICE-CLOCK-F ()
	<COND (<VERB? EXAMINE READ>
		<TELL "The [[office clock]] reads 9:12. Beneath it: SYNCHRONOUS MOVEMENT -- RESTART BY HAND AFTER UNDERVOLTAGE. The [[winding knob]] is innocent; this clock never had a spring. ">
		<COND (,LB-CLOCK <TELL "The voltage chart has explained it: the hands date the 9:12 power fault, not the death." CR>)
			(T <TELL "Its time needs an independent witness." CR>)>
		<RTRUE>)
		(<VERB? COMPARE> <LB-COMPARE>)
		(<VERB? LISTEN> <TELL "You put your ear close. An electric clock like this should hum faintly while it runs; this one is silent." CR> <RTRUE>)
		(<VERB? RUB> <TELL "The bakelite case is cool and smooth under your hand." CR> <RTRUE>)
		(<VERB? KNOCK> <TELL "You tap the glass. The hands do not stir." CR> <RTRUE>)
		(<VERB? SPIN> <TELL "You leave the hands exactly where they are. Until something explains them, they are evidence." CR> <RTRUE>)>>

<ROUTINE LB-BODY-F ()
	<COND (<VERB? EXAMINE SEARCH>
		<TELL "One blow behind the ear. No struggle, no long chase. The [[body]] has stiffened in the attitude of someone signing away another person's future. A crescent of [[brass dust]] marks the wound. The crescent is interrupted by one narrow gap. ">
		<COND (,LB-WEAPON <TELL "The notched brass counterweight made it. ">)
			(T <TELL "Whatever made it had a matching notch in its edge. ">)>
		<COND (,LB-CLOCK <TELL "The [[office clock]] records the electrical fault; the wound belongs to the later interval." CR>)
			(T <TELL "The [[office clock]] has yet to account for its stopped hands." CR>)>
		<RTRUE>)
		(<VERB? COMPARE> <LB-COMPARE>)
		(<VERB? SMELL> <TELL "Bay rum and cigar smoke, and beneath them the flat, coppery smell you noticed from the door." CR> <RTRUE>)
		(<VERB? RUB> <TELL "His hand is cold, and the fingers have begun to stiffen. You let it rest where it was." CR> <RTRUE>)
		(<VERB? MOVE PUSH> <TELL "You will not move him. The police will want him as he was found, and so do you." CR> <RTRUE>)
		(<VERB? LOOK-UNDER> <TELL "Under the chair there is only a dropped fountain pen, its cap still on." CR> <RTRUE>)
		(<VERB? KICK ATTACK MUNG STRIKE KISS> <TELL "Whatever you think of Julian Vane, he is past answering for it." CR> <RTRUE>)
		(<VERB? PUT-ON PUT> <COND (<EQUAL? ,PRSI ,LB-BODY> <TELL "You lay nothing on him. Hold an exhibit up to the wound and compare them instead." CR> <RTRUE>)>)>>

<ROUTINE LB-MICROPHONE-F ()
	<COND
		(<VERB? LOOK-BEHIND> <TELL "The cable loops back through a hole in the floor. The lamp on its collar tells you nothing about what happened at the far end." CR> <RTRUE>)
		(<VERB? EXAMINE>
		<TELL "The felt around the [[microphone]] smells of old tobacco. The microphone wears a red supply lamp. Its tiny [[plate->heater plate]] says HEATER, not ON AIR. It shows that the microphone is warm, not that its voice reaches the transmitter. [[Ruth]] has been treating the two as synonymous." CR> <RTRUE>)
		(<VERB? LISTEN> <TELL "You lean close. The microphone gives you nothing back but a faint tick from its warm casing." CR> <RTRUE>)
		(<VERB? RUB> <TELL "The casing is warm under your fingers, warmer than anything else in the studio." CR> <RTRUE>)
		(<VERB? SMELL> <TELL "Hot dust and singed felt, the smell of a small element left on for hours." CR> <RTRUE>)
		(<VERB? KNOCK> <TELL "You tap the grille. Ruth gives you the look an organist gives a cough during the sermon." CR> <RTRUE>)>>

<ROUTINE LB-SWITCH-F ()
	<COND
		(<VERB? LOOK-BEHIND> <TELL "Two cloth-covered leads disappear into the rack, tagged in pencil. Different sources, the same wire out to sea." CR> <RTRUE>)
		(<VERB? EXAMINE READ>
		<TELL "The [[routing switch]] selects MIC or DISC independently of the microphone's red heater lamp. It was found at DISC. A [[wax dab]] under its guard records that position; turning it now would tell you nothing about then. The [[gramophone]] supplies the second feed." CR> <RTRUE>)
		(<VERB? TURN SPIN PUSH MOVE> <TELL "The transmitter is isolated. You test the routing lever without disturbing the wax witness mark: MIC and DISC are independent of the studio heater lamp." CR> <RTRUE>)
		(<VERB? RUB> <TELL "The bakelite lever is smooth and cool. Under the guard the wax feels brittle; one careless shove would crumble it." CR> <RTRUE>)
		(<VERB? LISTEN> <TELL "Somewhere in the rack behind it a relay ticks once, then is quiet." CR> <RTRUE>)>>

<ROUTINE LB-CUTTER-F ()
	<COND (<VERB? EXAMINE SEARCH>
		<FSET ,LB-CUTTER ,OPENBIT>
		<COND (<IN? ,LB-WEIGHT ,LB-CUTTER> <TELL "Inside its open cover, a loose [[brass counterweight]] rests in a cradle." CR>)>
		<TELL "The [[cutter]] engraves lacquer on an aluminium base. Its inspection cover lifts without a tool. The [[register]] records every cut by edge number and duration." CR> <RTRUE>)
		(<VERB? SMELL> <TELL "Warm machine oil and lacquer, strongest around the turntable." CR> <RTRUE>)
		(<VERB? LISTEN> <TELL "Silent. The motor is switched off at the wall." CR> <RTRUE>)
		(<VERB? RUB> <TELL "The steel bed of the turntable is cold and polished smooth." CR> <RTRUE>)
		(<VERB? SPIN> <TELL "The heavy turntable moves a quarter of the way round under your hand and stops." CR> <RTRUE>)>>

<ROUTINE LB-REGISTER-F ()
	<COND (<VERB? EXAMINE READ>
		<TELL "The register sits on a sloping stand beside the cutter. It has two entries: 8:10, R. Bell, B03, two-minute microphone test, destroyed; 8:40, A. Mercer, A17, six-minute appeal, completed. Both were cut before the gale reached the aerial. ">
		<COND (,LB-PROVENANCE <TELL "The A17 entry has been matched to the disc you heard." CR>)
			(T <TELL "Compare the actual disc with this register after hearing it." CR>)>
		<RTRUE>)
		(<VERB? COMPARE> <LB-COMPARE>)
		(<VERB? RUB> <TELL "Good heavy paper, ruled in red. The pencil entries have not smudged." CR> <RTRUE>)
		(<VERB? LOOK-UNDER> <TELL "Under the stand is only a box of blank aluminium discs, still in their wrapping." CR> <RTRUE>)>>

<ROUTINE LB-GENERATOR-F ()
	<COND
		(<VERB? LAMP-OFF> <TELL "You leave the flywheel running. The last person to lose the light in this building is still upstairs." CR> <RTRUE>)
		(<VERB? EXAMINE>
		<TELL "The [[generator]] shudders on its rubber feet, powering the lights and clocks. Accumulators buffer the transmitter; a small voltage sag can stop an office clock without silencing the station. Its mechanical recorder stamps the [[voltage chart]] independently of the electric clocks." CR> <RTRUE>)
		(<VERB? LISTEN> <TELL "A deep, steady thump, so regular you stop hearing it until you listen. Beneath it the recording instrument ticks off the minutes." CR> <RTRUE>)
		(<VERB? RUB> <TELL "The casing is hot and shivering. Your hand comes away grey with oily soot." CR> <RTRUE>)
		(<VERB? SMELL> <TELL "Diesel, hot oil and scorched rubber." CR> <RTRUE>)
		(<VERB? KICK> <TELL "You would only hurt your foot, and every light in the station hangs on this engine." CR> <RTRUE>)>>

<ROUTINE LB-CHART-F ()
	<COND (<VERB? EXAMINE READ>
		<TELL "The [[voltage chart]] records a brief fall below clock-running voltage at 9:12 and normal supply at 9:13. Every later minute is steady. The mechanical recorder and the station clock agree on the minute. The office hands have a different story to tell." CR> <RTRUE>)
		(<VERB? COMPARE> <LB-COMPARE>)
		(<VERB? SMELL> <TELL "Violet recorder ink and warm machine oil." CR> <RTRUE>)
		(<VERB? RUB> <TELL "The paper is glazed, so the ink lies on the surface. The trace is quite dry." CR> <RTRUE>)>>

<ROUTINE LB-STAIN-F ()
	<COND (<VERB? EXAMINE SEARCH>
		<SETG LB-STAIN-SEEN T> <TELL "Up close the damp stone smells of hot rubber. The [[stain]] is a heel print in diluted blood, pointing away from the office hatch. One [[square repair]] has been fixed diagonally across its edge, making a distinctive diamond interruption. ">
		<COND (,LB-TRACE <TELL "The repaired heel of Ada's boots fills it exactly." CR>)
			(T <TELL "It is precise enough to test against a real heel, not merely imagine a similar shape." CR>)>
		<RTRUE>)
		(<VERB? COMPARE> <LB-COMPARE>)
		(<VERB? SMELL> <TELL "Wet stone, and under it something faintly metallic." CR> <RTRUE>)
		(<VERB? RUB KICK> <TELL "You keep well clear of it. A smudged print is no use to anyone." CR> <RTRUE>)>>

<ROUTINE LB-TABLE-F ()
	<COND (<VERB? EXAMINE SEARCH>
		<TELL "Glass dust from a broken tumbler clings to the scrubbed grain of the [[table]]. Two [[cups]] have gone cold. [[Edith]] keeps looking at the cup opposite hers; she and Ruth were here together during the appeal. Her [[medical bag]] is within reach, with permission to inspect it." CR> <RTRUE>)
		(<VERB? KNOCK> <TELL "Solid deal, scrubbed white. The cups jump in their saucers, and Edith steadies them without looking." CR> <RTRUE>)
		(<VERB? RUB> <TELL "The grain is rough from scrubbing, and here and there something catches at your fingertip like grit." CR> <RTRUE>)
		(<VERB? LOOK-UNDER> <TELL "Only the flagstones, still damp from a recent mopping." CR> <RTRUE>)
		(<VERB? SMELL> <TELL "Carbolic soap and stewed tea." CR> <RTRUE>)>>

<ROUTINE LB-BAG-F ()
	<COND
		(<VERB? OPEN SEARCH LOOK-INSIDE>
		<COND (<NOT <FSET? ,LB-BAG ,OPENBIT>>
			<FSET ,LB-BAG ,OPENBIT> <TELL "Edith turns the clasp for you. ">)>
		<COND (<IN? ,LB-DRESSING ,LB-BAG>
			<TELL "Beneath a spare roll of gauze is a [[bloodied dressing]]." CR>
			<THIS-IS-IT ,LB-DRESSING>)
			(T <TELL "Edith holds the bag open. Spare gauze and a roll of instruments, nothing else from tonight." CR>)>
		<RTRUE>)
		(<VERB? EXAMINE>
		<TELL "A [[medical bag]], kept private rather than locked. Edith has given permission to inspect it. ">
		<COND (<FSET? ,LB-BAG ,OPENBIT>
			<TELL "It stands open now. ">
			<COND (<IN? ,LB-DRESSING ,LB-BAG> <TELL "A [[bloodied dressing]] rests inside.">) (T <TELL "The evidence has been removed.">)>)
			(T <TELL "It is still closed.">)>
		<CRLF> <RTRUE>)
		(<VERB? SMELL> <TELL "Carbolic, iodine and old leather." CR> <RTRUE>)
		(<VERB? RUB> <TELL "Good leather, much mended. The clasp is worn smooth with use." CR> <RTRUE>)>>
<ROUTINE LB-DRESSING-F ()
	<COND (<VERB? EXAMINE READ>
		<SETG LB-DRESSING-SEEN T> <TELL "The [[bloodied dressing]] bears the time 9:17 and initials R.B. in Edith's tidy hand. Three tiny glass fragments adhere to it. A surface cut, not a head wound. ">
		<COND (,LB-EDITH-CLEARED <TELL "Edith has named the patient: Ruth Bell." CR>)
			(T <TELL "Show it to Edith and ask whose blood required the discretion." CR>)>
		<RTRUE>)
		(<VERB? SHOW> <LB-SHOW>)
		(<VERB? SMELL> <TELL "Iodine, and the stale sweetness of dried blood." CR> <RTRUE>)>>

<ROUTINE LB-TELEGRAPH-F ()
	<COND (<VERB? EXAMINE>
		<TELL "The [[telegraph]] is a two-way landline. Messages are challenged minute by minute, with unpredictable reply groups; the mainland stamps its acknowledgement on the [[receipt]]. No recorded local performance could answer those challenges." CR> <RTRUE>)
		(<VERB? LISTEN> <TELL "The sounder clicks in short bursts: a coast station passing the weather, a silence, then more." CR> <RTRUE>)
		(<VERB? RUB PUSH> <TELL "You keep your hand off the key. One careless touch would send nonsense to the mainland under Tomas's name." CR> <RTRUE>)>>

<ROUTINE LB-RECEIPT-F ()
	<COND (<VERB? EXAMINE READ>
		<SETG LB-RECEIPT-SEEN T> <TELL "The [[telegraph receipt]] carries mainland challenges and Tomas's correct returns at every minute from 9:16 through 9:22. The far-end stamps are intact. Between them, an outgoing message asks a bookmaker for another week. ">
		<COND (,LB-TOMAS-CLEARED <TELL "Tomas has owned to both sides of the strip." CR>)
			(T <TELL "Show it to [[Tomas]]; the shame and the alibi are on the same strip." CR>)>
		<RTRUE>)
		(<VERB? SHOW> <LB-SHOW>)
		(<VERB? RUB> <TELL "Thin paper tape gummed onto a backing form. The mainland stamps are pressed deep into it." CR> <RTRUE>)>>

<ROUTINE LB-AERIAL-F ()
	<COND (<VERB? EXAMINE>
		<TELL "The [[aerial]] sings through the rain. The gulls have left. The double cough you heard behind the appeal is absent from this wet iron. Somewhere a voice has carried better weather into the storm." CR> <RTRUE>)
		(<VERB? LISTEN> <TELL "The wires hum one low note, which rises whenever a gust comes." CR> <RTRUE>)
		(<VERB? RUB> <TELL "You keep your hands to yourself. A transmitting aerial is no thing to grab in the rain." CR> <RTRUE>)
		(<VERB? CLIMB-FOO CLIMB-UP> <TELL "Not in this wind, and not without a harness." CR> <RTRUE>)>>

<ROUTINE LB-LAMP-F ()
	<COND
		(<VERB? LISTEN> <TELL "Each raindrop makes a dry little hiss. The lamp has no way of telling you whose voice is on the carrier." CR> <RTRUE>)
		(<VERB? EXAMINE READ>
		<TELL "The green [[signal lamp]] follows the transmitter carrier. It cannot distinguish a live voice from a record, or truth from a man being paid to read it. From here the studio's red lamp is invisible: no outside witness could have seen it." CR> <RTRUE>)
		(<VERB? RUB> <TELL "The glass is hot. Raindrops hiss and vanish where they strike it." CR> <RTRUE>)
		(<VERB? LOOK-BEHIND> <TELL "Its cable runs down the mast to the transmitter below." CR> <RTRUE>)>>

<ROUTINE LB-BOOTS-F ()
	<COND (<VERB? EXAMINE SEARCH>
		<TELL "Ada's [[leather boots]], offered without grace. The left heel has a square leather repair set diagonally across the edge. Rust-red moisture remains in its stitching. A deliberate repair, not the shape of an ordinary heel. Ada permits you to carry them; her permission sounds like a challenge." CR> <RTRUE>)
		(<VERB? COMPARE> <LB-COMPARE>)
		(<VERB? SMELL> <TELL "Wet leather and dubbin, and something sour in the stitching." CR> <RTRUE>)
		(<VERB? RUB> <TELL "The leather is still damp, though the bunkroom is dry." CR> <RTRUE>)
		(<VERB? LOOK-INSIDE> <TELL "Nothing inside but a worn insole, shaped by years of Ada's feet." CR> <RTRUE>)
		(<VERB? WEAR> <TELL "They are a size too small for you, and they are evidence." CR> <RTRUE>)>>

<ROUTINE LB-ROSTER-F ()
	<COND (<VERB? EXAMINE READ>
		<TELL "The [[maintenance roster]] assigns Ada the 9:15 inspection beneath the office. The service hatch has a square spindle; the workshop spanner operates it from either side. Ada signed the spanner back at 9:20. Ruth and Edith are assigned to the kitchen, Tomas to the landline. This is duty, not proof of obedience." CR> <RTRUE>)
		(<VERB? RUB> <TELL "Cheap paper held by a single drawing pin. The initials on it are in several hands." CR> <RTRUE>)
		(<VERB? LOOK-BEHIND> <TELL "You lift the corner. Behind it is only distemper, a little paler where the light never reaches." CR> <RTRUE>)>>

<ROUTINE LB-LEDGER-F ()
	<COND (<VERB? EXAMINE READ>
		<SETG LB-LEDGER-SEEN T> <TELL "The [[wage ledger]] records eleven years of deductions for transmitter shares that were never issued. Mercer, H.: deceased; balance carried forward. Ada's father died still paying for a station he did not own. Vane has marked the accounts for destruction after tomorrow's sale. Ada is the surviving Mercer. These figures have left her something to answer for her father." CR> <RTRUE>)
		(<VERB? SHOW> <LB-SHOW>)
		(<VERB? SMELL> <TELL "Mildew and old ink. It has been kept somewhere damp for years." CR> <RTRUE>)
		(<VERB? SHAKE> <TELL "Nothing falls from between the pages." CR> <RTRUE>)
		(<VERB? RUB> <TELL "The cloth cover is worn through at the spine." CR> <RTRUE>)>>

<ROUTINE LB-VANE-F ()
	<COND (<VERB? EXAMINE>
		<TELL "Vane owned Saint Bride and treated its inhabitants as replaceable components. Each of the four survivors has a reason to hate him. A reason is not a route through an office wall." CR> <RTRUE>)>>

<ROUTINE LB-BROADCAST-F ()
	<COND (<VERB? EXAMINE>
		<TELL "At 9:17 Ada's voice began the six-minute appeal. Ruth found Vane at 9:21. The investigation must distinguish the continuing voice from the continuing presence of its owner. Your [[casebook]] can reconstruct the evidence when the experiments are complete." CR> <RTRUE>)>>

<ROUTINE LB-SPANNER-F ()
	<COND (<VERB? EXAMINE> <TELL "A square-socket [[service spanner]], made for the office hatch. There is only one; it is quite large enough to be absent conspicuously." CR> <RTRUE>)
		(<VERB? USE-ON>
			<COND (<EQUAL? ,PRSI ,LB-HATCH> <LB-OPEN-HATCH>)
				(T <TELL "The [[spanner]] operates the service hatch, not that." CR> <RTRUE>)>)
		(<VERB? SHAKE> <TELL "It is heavy and well balanced. Inside, the square socket is worn bright." CR> <RTRUE>)
		(<VERB? RUB> <TELL "The handle is gritty with dried oil." CR> <RTRUE>)
		(<VERB? SMELL> <TELL "Machine oil and iron." CR> <RTRUE>)>>
<ROUTINE LB-HATCH-F ()
	<COND (<VERB? EXAMINE>
		<COND (<FSET? ,LB-HATCH ,OPENBIT> <TELL "The [[hatch]] stands open. Fresh blood has dried along the underside of its square spindle, where a hand or a heel brushed it. The passage and office are connected now." CR>)
			(T <TELL "A flush [[service hatch]] with a square spindle. Ordinary fingers cannot turn it. The service spanner in the workshop was made for the job." CR>)> <RTRUE>)
		(<VERB? USE-ON USE-WITH OPEN UNLOCK>
			<COND (<OR <AND <VERB? USE-ON> <EQUAL? ,PRSO ,LB-SPANNER>> <AND <VERB? USE-WITH OPEN UNLOCK> <EQUAL? ,PRSI ,LB-SPANNER>>> <LB-OPEN-HATCH>)
				(<FSET? ,LB-HATCH ,OPENBIT> <TELL "The [[hatch]] is already open." CR> <RTRUE>)
				(T <TELL "Only the square service spanner fits; the [[hatch]] will not open without it." CR> <RTRUE>)>)
		(<VERB? CLOSE>
			<COND (<FSET? ,LB-HATCH ,OPENBIT> <FCLEAR ,LB-HATCH ,OPENBIT> <TELL "You lower the [[hatch]]. The square bolt falls home." CR>)
				(T <TELL "The [[hatch]] is already bolted shut." CR>)>
			<RTRUE>)
		(<VERB? KNOCK> <COND (<EQUAL? ,HERE ,LB-PASSAGE> <TELL "Your knuckles ring on the iron underside. Nothing stirs in the office above." CR>) (T <TELL "The hatch gives back a hollow boom, and somewhere below the sound runs away along a tunnel." CR>)> <RTRUE>)
		(<VERB? LISTEN> <COND (<EQUAL? ,HERE ,LB-PASSAGE> <TELL "From the office above comes nothing at all. It is as still as the man in it." CR>) (T <TELL "Through the boards comes the slow thump of the generator and the drip of water somewhere underground." CR>)> <RTRUE>)
		(<VERB? RUB> <TELL "The iron is cold. The square spindle stands proud of the plate, its corners worn bright." CR> <RTRUE>)>>
<ROUTINE LB-OPEN-HATCH ()
	<COND (<NOT <AND <HELD? ,LB-SPANNER> <ACCESSIBLE? ,LB-SPANNER> <ACCESSIBLE? ,LB-HATCH>>>
		<TELL "Hold the service spanner within reach of the [[hatch]]." CR>)
		(<FSET? ,LB-HATCH ,OPENBIT> <TELL "The [[hatch]] is already open." CR>)
		(T <FSET ,LB-HATCH ,OPENBIT> <TELL "The bolt turns. You lift the [[hatch]] on its counterbalanced hinges. Warm air rises, carrying oil and wet brick." CR>)>
	<RTRUE>>

;"Both direct and indirect evidence objects expose the verb for reader menus."
<ROUTINE LB-PAIR? (A B)
	<AND <OR <AND <EQUAL? ,PRSO .A> <EQUAL? ,PRSI .B>> <AND <EQUAL? ,PRSO .B> <EQUAL? ,PRSI .A>>>
		<ACCESSIBLE? .A> <ACCESSIBLE? .B>>>
<ROUTINE LB-COMPARE ()
	<COND (<LB-PAIR? ,LB-WEIGHT ,LB-BODY>
		<SETG LB-WEAPON T>
		<TELL "The crescent on the brass rim fits the wound. A tiny broken notch matches the missing interruption in the bruise; blood remains behind the weight's retaining lug. This is the weapon, carried from the cutting room and put back after the blow. You preserve it in the casebook as a measurement, not a flourish." CR>)
		(<LB-PAIR? ,LB-CHART ,LB-OFFICE-CLOCK>
		<SETG LB-CLOCK T>
		<TELL "9:12 aligns exactly: voltage fell, the synchronous [[office clock]] stalled, and nobody restarted it. The stopped hands date an electrical fault, not a killing. The murder belongs between Ruth leaving Vane alive at 9:16 and finding him at 9:21. You rule a new interval in the [[casebook]]." CR>)
		(<LB-PAIR? ,LB-DISC ,LB-REGISTER>
		<COND (<NOT ,LB-SOUND> <TELL "Matching the number is not enough: hear what this disc actually contains before identifying it as the transmitted appeal." CR>)
			(T <SETG LB-PROVENANCE T> <TELL "A17, six minutes, Ada Mercer, 8:40. Number, duration and the gull cough all agree. Ruth's two-minute test cannot be this [[disc]]. The entry attributes this complete appeal to Ada before the scheduled broadcast. The [[register]] proves advance preparation; it cannot establish who started playback or where anyone went." CR>)>)
		(<LB-PAIR? ,LB-BOOTS ,LB-STAIN>
		<COND (<NOT ,LB-STAIN-SEEN> <TELL "Examine the [[stain]] closely before choosing what to compare." CR>)
			(T <SETG LB-TRACE T> <TELL "The square heel repair fills the diamond interruption exactly. Blood is caught inside the repair stitching, not painted on the sole: these [[boots]] walked through wet blood away from Vane's office. The matching smear on the hatch is above them. The measurements describe a journey; they do not supply its explanation." CR>)>)
		(T <TELL "These do not share a useful measurement. A comparison needs matching times, dimensions or distinctive marks, with both physical exhibits within reach." CR>)>
	<RTRUE>>

<ROUTINE LB-RUTH-F ()
	<COND (<LB-MANNERS ,LB-RUTH> <RTRUE>)
		(<VERB? EXAMINE>
		<TELL "Ruth Bell has the trained stillness of an announcer whose next line will ruin someone. Ask her about the [[microphone]], the [[broadcast]], or [[Vane]]." CR>
		<COND (,LB-RUTH-CLEARED <TELL "She has stopped watching the red lamp. When you are ready, she will make the station's first honest announcement tonight." CR>)> <RTRUE>)
		(<VERB? TELL>
			<COND (<EQUAL? ,PRSI ,LB-MICROPHONE>
				<TELL "“Ada asked me to leave the lamp on for her appeal. I did, then fetched Vane; he refused to come. At 9:16 I left him alive, and cut my hand on a glass in the kitchen. Edith dressed it at once. I thought the red meant live.” [[Ruth]] looks at the plate below the [[microphone]]. “How thoroughly one can read the wrong word.”" CR>)
				(<EQUAL? ,PRSI ,LB-DISC ,LB-BROADCAST>
					<COND (,LB-RUTH-CLEARED <TELL "“Six minutes of her voice. She had enough time to go below and come back. I never saw her at the microphone during the appeal; I only heard her.”" CR>)
						(T <TELL "“I heard Ada all through the appeal. Surely that places her?” [[Ruth]] folds her injured hand. “If you have the actual recording, let me hear your evidence rather than your conclusion.”" CR>)>)
				(<EQUAL? ,PRSI ,LB-VANE> <TELL "“At 9:16 I left him alive in the office. Edith saw me enter the kitchen straight away. At 9:21 I left her there and found him dead. He owed us wages. That doesn't make what happened a pay rise.”" CR>)
				(T <TELL "“Ask me about the [[microphone]], the [[broadcast]], or [[Vane]]. I can tell you what I saw. What I heard appears more troublesome.”" CR>)> <RTRUE>)
		(<VERB? SHOW GIVE> <LB-SHOW>)
		(<VERB? ACCUSE> <LB-ACCUSE>)
		(<VERB? LISTEN> <TELL "Ruth is murmuring the station call under her breath, over and over, as if to keep her voice in working order: “Saint Bride calling. Saint Bride calling.”" CR> <RTRUE>)
		(<VERB? RUB> <TELL "Ruth steps back before your hand reaches her sleeve. “I am quite steady, thank you.”" CR> <RTRUE>)>>
<ROUTINE LB-EDITH-F ()
	<COND (<LB-MANNERS ,LB-EDITH> <RTRUE>)
		(<VERB? EXAMINE>
		<TELL "Edith Shaw is washing her hands by rubbing them together, without water. Her [[medical bag]] is within reach. Ask about the [[bag]], the [[broadcast]], or [[Vane]]." CR>
		<COND (,LB-EDITH-CLEARED <TELL "Now that the patient is named, she has the plain impatience of a doctor kept from useful work." CR>)> <RTRUE>)
		(<VERB? TELL>
			<COND (<EQUAL? ,PRSI ,LB-BAG ,LB-DRESSING>
				<COND (,LB-EDITH-CLEARED <TELL "“Ruth's cut hand, from 9:16 to 9:21. She was beside me throughout the appeal until she went to fetch Vane. We were both afraid he would dismiss her for breaking the glass. A splendid standard for an employer.”" CR>)
					(T <TELL "“The blood in my bag belongs to a patient. You may inspect it. I will not make medical privacy look less suspicious merely to suit you.”" CR>)>)
				(<EQUAL? ,PRSI ,LB-BROADCAST> <TELL "“I heard the appeal from the kitchen. Ruth came in at 9:16, before it started, and stayed until 9:21. A voice through a wall is not a medical observation of its owner.”" CR>)
				(<EQUAL? ,PRSI ,LB-VANE> <TELL "“He threatened to expose my treatment of union men who could not pay. There was nothing unlawful in treating them; he only needed their next employers to know. He was alive when Ruth left him at 9:16. The clock is irrelevant to the wound.”" CR>)
				(T <TELL "“Ask about the [[medical bag]], the [[broadcast]], or [[Vane]]. You may examine the bag. I would prefer a fact to an insinuation.”" CR>)> <RTRUE>)
		(<VERB? SHOW GIVE> <LB-SHOW>)
		(<VERB? ACCUSE> <LB-ACCUSE>)
		(<VERB? LISTEN> <TELL "She is breathing slowly and deliberately, the way she would tell a frightened patient to." CR> <RTRUE>)
		(<VERB? RUB> <TELL "Edith looks at your hand until you take it back. “If anyone's pulse wants taking, I can manage it myself.”" CR> <RTRUE>)>>
<ROUTINE LB-TOMAS-F ()
	<COND (<LB-MANNERS ,LB-TOMAS> <RTRUE>)
		(<VERB? EXAMINE>
		<TELL "Tomas Vale holds his hands flat, as though they might otherwise transmit a confession. Ask about the [[receipt]], the [[broadcast]], or [[Vane]]." CR>
		<COND (,LB-TOMAS-CLEARED <TELL "He has stopped hiding the outgoing side of the receipt. It is a small, sensible revolution." CR>)> <RTRUE>)
		(<VERB? TELL>
			<COND (<EQUAL? ,PRSI ,LB-RECEIPT>
				<COND (,LB-TOMAS-CLEARED <TELL "“The bookmaker knows. You know. Vane knew. Oddly, the third is no longer the worst of it. I shall leave the island owing an ordinary sum to an ordinary brute.”" CR>)
					(T <TELL "“The mainland can verify my times. Please read the [[receipt]] yourself. I would rather be suspected of murder than discuss the message on the other side.” He pauses. “That came out badly.”" CR>)>)
				(<EQUAL? ,PRSI ,LB-BROADCAST> <TELL "“I heard Ada from 9:17. I was answering challenge groups on this [[telegraph]] from 9:16 until 9:22. A recording cannot know which numbers the mainland will choose next.”" CR>)
				(<EQUAL? ,PRSI ,LB-VANE> <TELL "“He bought my gambling debt. Then he charged me for the favour every payday. I wanted to leave, not become a murderer permanently resident here.”" CR>)
				(T <TELL "“Ask about the [[receipt]], the [[broadcast]], or [[Vane]]. I have no talent for looking innocent. The telegraph is better at it.”" CR>)> <RTRUE>)
		(<VERB? SHOW GIVE> <LB-SHOW>)
		(<VERB? ACCUSE> <LB-ACCUSE>)
		(<VERB? LISTEN> <TELL "Under the click of the sounder he is counting softly to himself, the way operators count code groups." CR> <RTRUE>)
		(<VERB? RUB> <TELL "Tomas flinches as though you had touched a live wire. “Sorry. Nerves.”" CR> <RTRUE>)>>
<ROUTINE LB-ADA-F ()
	<COND (<LB-MANNERS ,LB-ADA> <RTRUE>)
		(<VERB? EXAMINE>
		<TELL "Ada Mercer is looking at the space between her hands. Her speech is exact; her breathing less so. Ask about the [[boots]], the [[broadcast]], [[Vane]], or the [[roster]]." CR>
		<COND (,LB-TRACE <TELL "When you mention the heel repair she draws her bare feet under the chair." CR>)
			(,LB-MOTIVE <TELL "She no longer speaks of the owner, only of Vane." CR>)> <RTRUE>)
		(<VERB? TELL>
			<COND (<EQUAL? ,PRSI ,LB-BOOTS ,LB-ROSTER>
				<COND (,LB-TRACE <TELL "“I should have burned them.” Ada catches the words too late. “Because they are worn out. You can take down whichever version you prefer.”" CR>)
					(T <TELL "“I repaired the heel myself. I inspect the cable passage every evening; it is my route on the [[roster]]. Take the [[boots]] if you must. I have had enough of standing.”" CR>)>)
				(<EQUAL? ,PRSI ,LB-DISC> <LB-ADA-EXHIBIT ,LB-DISC>)
				(<EQUAL? ,PRSI ,LB-WEIGHT> <LB-ADA-EXHIBIT ,LB-WEIGHT>)
				(<EQUAL? ,PRSI ,LB-BROADCAST>
					<COND (,LB-PROVENANCE <LB-ADA-EXHIBIT ,LB-DISC>)
						(T <TELL "“Everyone heard me speaking. Ask Ruth. The recording equipment exists for emergencies; an island is a series of emergencies with water between them.”" CR>)>)
				(<EQUAL? ,PRSI ,LB-STAIN>
					<COND (,LB-TRACE <LB-ADA-EXHIBIT ,LB-BOOTS>)
						(T <TELL "“It is a service passage. You must distinguish a trace of routine work from something that happened tonight.”" CR>)>)
				(<EQUAL? ,PRSI ,LB-VANE ,LB-LEDGER>
					<COND (,LB-MOTIVE <TELL "“My father thought the shares would keep me here safely after he died. Instead they kept us both paying. I wanted the proof to live longer than Vane's ownership.”" CR>)
						(T <TELL "“The accounts are in the archive. If you want to understand this station, read them. People are noisier than figures and generally less exact.”" CR>)>)
				(T <TELL "“Ask about my [[boots]], the [[roster]], the [[broadcast]], or [[Vane]]. Please make it a question whose answer you intend to hear.”" CR>)> <RTRUE>)
		(<VERB? SHOW GIVE> <LB-SHOW>)
		(<VERB? ACCUSE> <LB-ACCUSE>)
		(<VERB? LISTEN> <TELL "Her breathing is quick and shallow, though her voice, when she speaks, stays perfectly level." CR> <RTRUE>)
		(<VERB? RUB> <TELL "Ada does not move away. She simply waits until you take your hand back." CR> <RTRUE>)>>

<ROUTINE LB-MANNERS (WHO)
	<COND (<OR <VERB? ATTACK MUNG KICK STRIKE> <AND <VERB? THROW> <EQUAL? ,PRSI .WHO>>>
		<TELL "One blow has already been struck at Saint Bride tonight. You came to account for it, not to add another, and " D .WHO " knows it." CR>)
		(<VERB? HELLO> <TELL D .WHO " answers with a short nod. Nobody in the station has much use for pleasantries tonight." CR>)
		(<VERB? KISS> <TELL "Scarcely the moment, and scarcely the conduct of an insurance investigator." CR>)
		(<VERB? TAKE PUSH MOVE> <TELL D .WHO " is a witness, not an exhibit. You leave everyone exactly where they are." CR>)
		(<VERB? FOLLOW> <TELL "Nobody is going anywhere tonight. The gale has seen to that." CR>)
		(T <RFALSE>)>>

<ROUTINE LB-SHOW ()
	<COND (<NOT <AND <HELD? ,PRSO> <ACCESSIBLE? ,PRSO> <ACCESSIBLE? ,PRSI>>>
		<TELL "Take the exhibit in hand first; a witness answers for what is held out to them." CR>)
		(<AND <EQUAL? ,PRSI ,LB-ADA> <OR <EQUAL? ,PRSO ,LB-DISC ,LB-BOOTS> <EQUAL? ,PRSO ,LB-WEIGHT>>>
			<LB-ADA-EXHIBIT ,PRSO>)
		(<AND <EQUAL? ,PRSO ,LB-DISC> <EQUAL? ,PRSI ,LB-RUTH>>
		<COND (<NOT ,LB-SOUND> <TELL "“It is a disc,” says [[Ruth]]. “We have dozens. Hear it first; tell me whether it is the one you heard tonight.”" CR>)
			(T <SETG LB-RUTH-CLEARED T> <TELL "Ruth repeats the gull cough from memory, then laughs once without pleasure. “The rehearsal. I was in the cutting room at 8:40. Ada recorded all six minutes. She told me to leave the microphone heater on tonight, and I thought that meant she was live. At 9:16 I reached the kitchen, cut my hand on a glass, and stayed with Edith until 9:21. Ada did not need me to lie. She needed me to misunderstand.”|The tiny glass cut is still visible. You have both a recording witness and a medical witness to test." CR>)>)
		(<AND <EQUAL? ,PRSO ,LB-DRESSING> <EQUAL? ,PRSI ,LB-EDITH>>
		<COND (<NOT ,LB-DRESSING-SEEN> <TELL "Read the [[dressing]] before asking Edith to identify the evidence." CR>)
			(T <SETG LB-EDITH-CLEARED T> <TELL "“Ruth Bell. Three fragments of glass, here, here and here.” [[Edith]] points without touching. “She entered at 9:16; I dated the dressing 9:17 while the appeal began. She sat with me until 9:21. We can account for one another throughout the interval. I concealed a patient's name, not Vane's death.”|The matching little cut on Ruth's hand explains the blood. It does not match the blunt head wound." CR>)>)
		(<AND <EQUAL? ,PRSO ,LB-RECEIPT> <EQUAL? ,PRSI ,LB-TOMAS>>
		<COND (<NOT ,LB-RECEIPT-SEEN> <TELL "Read the mainland stamps on the [[receipt]] before presenting it." CR>)
			(T <SETG LB-TOMAS-CLEARED T> <TELL "Tomas turns the [[receipt]] over. “A bookmaker. Forty-seven pounds. Vane was going to tell my mother; you may think that funny if you have not met her.”|The mainland's unpredictable challenges required his hand at the key every minute, 9:16 to 9:22. No interval remains for the office journey. He has hidden a debt, not a departure." CR>)>)
		(<AND <EQUAL? ,PRSO ,LB-LEDGER> <EQUAL? ,PRSI ,LB-ADA>>
		<COND (<NOT ,LB-LEDGER-SEEN> <TELL "Read the [[ledger]] before asking Ada to explain it." CR>)
			(T <SETG LB-MOTIVE T> <TELL "Ada touches her father's name. “He promised shares instead of wages. Then sold the station as though none of us had paid for it. Tomorrow he meant to burn the accounts. He told me so at nine-fifteen.”|Her anger is unmistakable; its existence proves no murder. But the [[ledger]] explains why a prepared recording might become more than insurance against a failed microphone. “Do not let them call him a generous man,” she says." CR>)>)
		(T <TELL "That exhibit does not resolve this witness's contradiction. Each survivor has something specific to explain." CR>)>
	<RTRUE>>

<ROUTINE LB-NEXT ()
	<COND (<NOT ,LB-CLOCK> <TELL "The office clock may date a power fault. Bring the generator room's voltage chart to it and compare them." CR>)
		(<NOT ,LB-SOUND> <TELL "Test the voice. Open the archive sleeve; take its disc and the workshop stylus to the control room. Fit the stylus, put the disc in the gramophone, and play it." CR>)
		(<NOT ,LB-PROVENANCE> <TELL "Authenticate the heard recording: take the disc to the cutting register and compare them." CR>)
		(<NOT ,LB-ROUTE> <TELL "Test the service route. Use the workshop spanner on the office hatch, then go through it to verify where the passage leads." CR>)
		(<NOT ,LB-WEAPON> <TELL "Examine the disc cutter and take its loose counterweight to the body. Compare the brass rim with the wound." CR>)
		(<NOT ,LB-TRACE> <TELL "Examine the passage stain. Bring Ada's boots there and compare their heel repair with the print." CR>)
		(<NOT ,LB-RUTH-CLEARED> <TELL "Show the heard disc to Ruth. Test her interpretation of the microphone's red lamp." CR>)
		(<NOT ,LB-EDITH-CLEARED> <TELL "Open Edith's medical bag, examine its dressing, and show it to her. Learn whose blood it carries." CR>)
		(<NOT ,LB-TOMAS-CLEARED> <TELL "Read the telegraph receipt and show it to Tomas. A remote witness can verify a local alibi." CR>)
		(<NOT ,LB-MOTIVE> <TELL "Read the archive wage ledger and show it to Ada. Her reply belongs to the case, though a motive alone never does." CR>)
		(T <TELL "The evidence is sufficient. Reconstruct the casebook, then confront a suspect in person. A wrong accusation will not close the investigation." CR> <RFALSE>)>
	<RTRUE>>
<ROUTINE LB-COMPLETE? ()
	<AND ,LB-CLOCK ,LB-SOUND ,LB-PROVENANCE ,LB-ROUTE ,LB-WEAPON ,LB-TRACE
		,LB-RUTH-CLEARED ,LB-EDITH-CLEARED ,LB-TOMAS-CLEARED ,LB-MOTIVE>>
<ROUTINE LB-RECONSTRUCT ()
	<COND (<NOT <LB-COMPLETE?>>
		<TELL "There is still a gap in the reconstruction. The [[casebook]] records established observations; an unanswered measurement or untested witness cannot become a fact by being written neatly. The casebook's optional hint gives explicit guidance if you want it." CR>)
		(T <SETG LB-RECONSTRUCTED T>
		<TELL "You draw two lines in the [[casebook]]: SOUND and PERSON.|Fixed points: the office hands stopped at 9:12 for an electrical reason. Vane was alive at 9:16 and found at 9:21. A six-minute appeal began at 9:17; the sound existed before that interval.|Physical facts: the notched brass rim matches the wound. Blood crossed the service route, away from the office, inside the stitching of a distinctive repaired heel. The route never enters the studio.|Witnesses: a dated dressing tests the kitchen pair's account; unpredictable mainland challenges test the operator's. The wage accounts explain what was at stake, but anger does not identify a hand.|Leave the last line blank. Which claimed presence survives only as sound, while the physical evidence places its owner elsewhere? Decide whose name belongs there. Accuse that person in person; the casebook will not choose for you." CR>)>
	<RTRUE>>
<ROUTINE LB-ACCUSE ()
	<COND (<EQUAL? ,PRSO ,LB-RUTH>
		<COND (<AND ,LB-RUTH-CLEARED ,LB-EDITH-CLEARED>
			<TELL "Ruth has explained the rehearsal she witnessed, and the dated dressing corroborates her kitchen interval with Edith. That is a tested account, not an unexplained departure. The accusation fails; the investigation remains open." CR>)
			(T <TELL "Ruth asks you to distinguish what she saw from what she heard. You have not tested her full interval or connected her physically to the wound. The accusation fails; you may continue questioning her." CR>)>)
		(<EQUAL? ,PRSO ,LB-EDITH>
		<COND (,LB-EDITH-CLEARED
			<TELL "The dated dressing belongs to a glass cut, and the patient and physician account for one another through the interval. Your charge does not explain that tested evidence. The accusation fails; the investigation remains open." CR>)
			(T <TELL "Edith waits for a fact that puts her at the wound, rather than a suspicion about her manner. You have not tested her interval. The accusation fails; she remains available for questions." CR>)>)
		(<EQUAL? ,PRSO ,LB-TOMAS>
		<COND (,LB-TOMAS-CLEARED
			<TELL "The mainland challenged Tomas's telegraph hand throughout 9:16-9:22. Your theory requires him both at the key and in the office. The accusation fails without costing you evidence; continue the investigation." CR>)
			(T <TELL "A nervous operator is not a measured absence. You have not tested his stated interval or connected him physically to the killing. The accusation fails; you may continue." CR>)>)
		(<EQUAL? ,PRSO ,LB-ADA>
			<COND (<NOT ,LB-RECONSTRUCTED> <TELL "Ada waits. A theory needs a reconstructed sequence, not a collection of suspicions. Consult your [[casebook]] and reconstruct it before making this charge." CR>)
				(T <SETG LB-WON T>
				<TELL "“The voice stayed here,” you say. “You did not.”|Ada looks once at the heel repair. “I recorded an appeal to save the place. Then he said he would burn my father's name with the accounts. I started the disc because I knew what I was going to do. Not because the machine failed. Because it worked.”|She describes the counterweight, the hatch, and the spanner returned at nine-twenty. You write the admission beneath the facts which earned it. The ledger will go to the workers; the rest goes to the police. You tear the carbon copy carefully along its perforation, leaving Ada's confession attached to the evidence. Neither fact cancels the other.|Ruth makes one last announcement. No music, no rehearsal: Julian Vane is dead; the station will remain silent until morning. Outside, the gulls have returned. They have nothing prepared.||THE LAST BROADCAST -- CASE SOLVED.||" >
				<FINISH>)>)
		(T <TELL "Accuse a person, with evidence sufficient to withstand an answer." CR>)>
	<RTRUE>>

<ROUTINE V-SCORE ("OPTIONAL" (ASK? <>))
	<COND (,LB-WON <TELL "The case is solved; the evidence and the workers' accounts are preserved." CR>)
		(T <TELL "The case is open. Your casebook records observations; optional hints require HINT CASEBOOK." CR>)>>
<ROUTINE LB-RECORD-CROSSING ()
	<COND (<NOT ,LB-ROUTE>
		<SETG LB-ROUTE T>
		<TELL "The office and service passage connect directly. Someone could cross between them without setting foot in the studio." CR CR>)>
	<RFALSE>>

<ROUTINE LB-OFFICE-F (RARG)
	<COND (<AND <EQUAL? .RARG ,M-ENTER> <VERB? WALK> <EQUAL? ,PRSO ,P?UP>>
		<LB-RECORD-CROSSING>)
		(<EQUAL? .RARG ,M-LOOK>
		<TELL "This is Julian Vane's office, so narrow that the [[filing cabinets]] crowd anyone standing at the desk. The air is too warm. Under the stale cigar smoke is the smell of old pennies. Vane's [[body]] sits slumped in his chair beneath an electric [[office clock]], his back to the door. ">
		<COND (<FSET? ,LB-HATCH ,OPENBIT> <TELL "A square service [[hatch]] in the floor stands open, and warm air rises from the [[passage below->down]].">)
			(T <TELL "A square service [[hatch]] is set flush in the floor, bolted shut over whatever lies [[below->down]].">)>
		<TELL " The hall is back to the [[south]]." CR> <RTRUE>)>>
<ROUTINE LB-PASSAGE-F (RARG)
	<COND (<AND <EQUAL? .RARG ,M-ENTER> <VERB? WALK> <EQUAL? ,PRSO ,P?DOWN>>
		<LB-RECORD-CROSSING>)
		(<EQUAL? .RARG ,M-LOOK>
		<TELL "This is the cable passage, a low brick tunnel that carries the station's wiring beneath the floors. It is damp and close, and your shoulders brush cold [[pipes]] sweating with condensation. A dark [[stain]] marks the wet stone underfoot. ">
		<COND (<FSET? ,LB-HATCH ,OPENBIT> <TELL "Overhead, lamplight falls through the open [[hatch]] from Vane's [[office above->up]].">)
			(T <TELL "Overhead, a square [[hatch]] is shut against the [[office above->up]].">)>
		<TELL " The tunnel runs back south to the [[generator room->south]]." CR> <RTRUE>)>>

<ROUTINE LB-WEIGHT-F ()
	<COND
		(<VERB? LOOK-BEHIND SEARCH> <TELL "You tilt the brass in the light without rubbing the rim. A dark fleck has lodged behind the lug, beyond the reach of a fast wipe." CR> <RTRUE>)
		(<AND <VERB? ATTACK KICK> <EQUAL? ,PRSO ,LB-WEIGHT>> <TELL "You keep the weight unmarked. You already have one blow to account for." CR> <RTRUE>)
		(<VERB? EXAMINE>
		<TELL "A loose [[brass counterweight]], heavy enough to balance the cutting arm. One rim has a broken notch and a damp polished crescent. Something dark remains behind its retaining lug. Its edge has the shape of an incomplete crescent." CR> <RTRUE>)
		(<VERB? COMPARE> <LB-COMPARE>)
		(<VERB? SMELL> <TELL "Brass and lacquer, and faintly something like iron." CR> <RTRUE>)
		(<VERB? RUB> <TELL "You touch only the clean face. The rest may have more to tell than your fingers would leave on it." CR> <RTRUE>)
		(<VERB? SHAKE> <TELL "It is heavy for its size, a solid pound or more of brass." CR> <RTRUE>)>>

<ROUTINE LB-ADA-EXHIBIT (EXHIBIT)
	<COND (<EQUAL? .EXHIBIT ,LB-DISC>
		<COND (,LB-PROVENANCE
			<TELL "“A reserve,” Ada says. “I cut the appeal in case the live feed failed. Preparing for a fault is my job.” She keeps looking at the label, not at you. “You have proved when that voice was made. You have not proved where I stood when it was played.”" CR>)
			(,LB-SOUND <TELL "“My voice, yes. A reserve recording. You can hear what is on it; its edge and the cutting entry can tell you the rest.” Ada draws her hands away from the disc." CR>)
			(T <TELL "“A disc is not yet an accusation. Have you listened to it?” Ada does not reach for it." CR>)>)
		(<EQUAL? .EXHIBIT ,LB-BOOTS>
		<COND (,LB-TRACE
			<TELL "“Inside the stitching?” Ada repeats. She begins to say “routine inspection”, then stops. The repair is her own work; now she will not look at it. “You have measured it. I cannot improve a measurement by speaking.”" CR>)
			(T <TELL "“I repair my own soles. That square patch is mine. If you think the boots tell you where I went, measure them against something. Don't ask me to supply the ground.”" CR>)>)
		(<EQUAL? .EXHIBIT ,LB-WEIGHT>
		<COND (,LB-WEAPON
			<TELL "Ada starts to turn the counterweight, then stops before her thumb reaches the dark retaining lug. “I cleaned that machine every morning. Not this evening.” Her voice has lost its broadcast precision. “Anyone could lift it. That is all I can say about it.”" CR>)
			(T <TELL "“The cutter's counterweight. Loose, by design. It is meant to balance an arm, not prove a theory. What have you matched its edge to?”" CR>)>)>
	<RTRUE>>

<ROUTINE LB-HEEL-REPAIR-F ()
    <COND (<VERB? EXAMINE>
           <SETG LB-STAIN-SEEN T>
           <TELL "One corner of the diamond sits right on the curve of the heel. Along its opposite edge the stitches left a row of tiny dots." CR>)
		(<VERB? RUB> <TELL "You do not touch the print. The pattern is too useful to spoil." CR> <RTRUE>)>>

<ROUTINE DETAIL-WINDING-KNOB-F ()
    <COND (<VERB? READ> <TELL "SET. There is no winding mark." CR>)
          (<VERB? SPIN> <TELL "The minute hand trembles under your thumb. You let go before you change the reading. This knob sets the hands." CR>)>>

<ROUTINE DETAIL-HEATER-PLATE-F ()
    <COND (<VERB? READ> <TELL "HEATER. The pencilled arrow points to the lamp that shows when the microphone is warm." CR>)
		(<VERB? RUB> <TELL "The punched letters are sharp-edged under your thumb. The pencilled arrow does not smudge." CR> <RTRUE>)>>

<ROUTINE LB-ARCHIVE-PAPERS-F ()
    <COND (<VERB? READ> <TELL "REQUISITION. Below it are spaces for a date, an item and a signature. The lines are blank." CR>)
		(<VERB? SEARCH> <TELL "You leaf through them. Every sheet is a blank requisition form, curling in the damp." CR> <RTRUE>)
		(<VERB? RUB> <TELL "The paper is cold and limp with damp." CR> <RTRUE>)
		(<VERB? LOOK-UNDER> <TELL "Only the scarred top of the reading table." CR> <RTRUE>)>>

<ROUTINE DETAIL-WAX-DAB-F ()
    <COND (<VERB? RUB> <TELL "You touch the wax on the guard. Its broken edge fits the piece on the switch at DISC." CR>)
		(<VERB? SMELL> <TELL "Ordinary candle wax, the kind kept in every drawer on the island for power cuts." CR> <RTRUE>)>>

<ROUTINE LB-COVERED-WALK-F ()
    <COND (<VERB? CROSS>
           <COND (<EQUAL? ,HERE ,LB-PLATFORM> <DO-WALK ,P?EAST>)
                 (T <DO-WALK ,P?WEST>)>)
		(<VERB? LISTEN> <TELL "Rain drums on the corrugated tin like gravel thrown on a roof." CR> <RTRUE>)
		(<VERB? RUB> <TELL "The boards are slick at the edges and dry down the middle." CR> <RTRUE>)>>

<ROUTINE LB-HALL-STAIRS-F ()
    <COND (<VERB? CLIMB-FOO CLIMB-UP> <DO-WALK ,P?UP>)
		(<VERB? RUB> <TELL "The handrail is greasy with years of hands, and the worn treads are as smooth as soap." CR> <RTRUE>)
		(<VERB? LISTEN> <TELL "Nothing moves upstairs but the rain on the slates." CR> <RTRUE>)>>

<ROUTINE LB-TELEGRAPH-STAIRS-F ()
    <COND (<VERB? CLIMB-FOO CLIMB-UP> <DO-WALK ,P?UP>)
		(<VERB? RUB> <TELL "The iron is wet, and cold enough to ache." CR> <RTRUE>)
		(<VERB? LISTEN> <TELL "Rain drums on the trapdoor at the top." CR> <RTRUE>)>>

<ROUTINE LB-HALL-LIGHT-F ()
	<COND
		(<VERB? RUB> <TELL "You cannot reach it from here. It swings well inside the door, out of the rain." CR> <RTRUE>)
		(<VERB? LISTEN> <TELL "Its bracket creaks at the end of every swing, a small sound the wind keeps losing." CR> <RTRUE>)>>

<ROUTINE LB-CONTROL-LIGHT-F ()
	<COND
		(<VERB? RUB> <TELL "The glass is warm. It glows as steadily under your finger as before." CR> <RTRUE>)
		(<VERB? LOOK-BEHIND> <TELL "A pair of cloth-covered wires runs from the lamp down into the transmitter rack." CR> <RTRUE>)>>

<ROUTINE LB-LACQUER-CURL-F ()
	<COND
		(<VERB? RUB> <TELL "It is soft and faintly sticky, and it clings to your finger until you flick it back onto the bench." CR> <RTRUE>)
		(<VERB? SMELL> <TELL "Sharp and sweet, like pear drops." CR> <RTRUE>)>>

<ROUTINE DETAIL-CUTTING-NEEDLE-F ()
	<COND
		(<VERB? RUB> <TELL "You stop short of the point. It was made to carve a groove a hair wide, and it would carve you as gladly." CR> <RTRUE>)
		(<VERB? SMELL> <TELL "Hot lacquer, faint but sharp." CR> <RTRUE>)>>

<ROUTINE DETAIL-BLACK-FELT-F ()
	<COND
		(<VERB? RUB> <TELL "Soft and worn smooth, like the cloth of a billiard table." CR> <RTRUE>)
		(<VERB? LOOK-UNDER> <TELL "You lift the edge. There is only the scarred bench beneath." CR> <RTRUE>)>>

<ROUTINE DETAIL-CUPS-F ()
	<COND
		(<VERB? SMELL> <TELL "Stewed tea, gone cold and bitter." CR> <RTRUE>)
		(<VERB? DRINK DRINK-FROM TAKE> <TELL "Cold, stewed, and not yours. You leave Edith's tea where it is." CR> <RTRUE>)
		(<VERB? RUB> <TELL "Stone cold, both of them." CR> <RTRUE>)>>

<ROUTINE DETAIL-BRASS-DUST-F ()
	<COND
		(<VERB? RUB> <TELL "You do not touch it. The pattern is the only witness the wound has." CR> <RTRUE>)>>

<ROUTINE LB-DOORS-F ()
	<COND
		(<VERB? KNOCK> <TELL "You rap on the frame. Nobody answers; everyone in the station is already where they mean to be." CR> <RTRUE>)
		(<VERB? OPEN CLOSE> <TELL "You leave it as it is. In this weather a shut door only bangs." CR> <RTRUE>)>>

<ROUTINE LB-SEA-F ()
	<COND
		(<VERB? EXAMINE> <TELL "Water climbs the outside face of the breakwater, folds over the top, and comes through the gaps in the planks." CR> <RTRUE>)
		(<VERB? CROSS ENTER> <TELL "The next wave takes the entire top of it. You step back until the soles of your shoes stop slipping." CR> <RTRUE>)
		(<VERB? LISTEN> <TELL "The sea booms against the stone, and the planks shudder under your feet." CR> <RTRUE>)
		(<VERB? SMELL> <TELL "Salt, weed and cold." CR> <RTRUE>)>>

<ROUTINE LB-COATS-F ()
	<COND
		(<VERB? WEAR TAKE> <TELL "You lift a heavy sleeve. Rain runs down it onto your cuff. Someone will need their oilskin when the boat gets back." CR> <RTRUE>)
		(<VERB? SHAKE> <TELL "A shower of cold drops lands in the puddle. All four owners must have come in soaked." CR> <RTRUE>)
		(<VERB? SEARCH LOOK-INSIDE> <TELL "You go through the pockets: matches, a pipe, a tide table, a mainland bus ticket. Nothing that belongs to tonight." CR> <RTRUE>)
		(<VERB? SMELL> <TELL "Wet rubberised cotton and sheep's wool." CR> <RTRUE>)>>

<ROUTINE LB-CABINETS-F ()
	<COND
		(<VERB? LOOK-BEHIND> <TELL "The backs are jammed against the wall. Pale stripes in the dust show they haven't been moved in years." CR> <RTRUE>)
		(<VERB? OPEN SEARCH> <TELL "Every drawer is locked. The police can have the keys; tonight's evidence is in plainer sight." CR> <RTRUE>)
		(<VERB? KNOCK> <TELL "The steel gives back a dull, full sound. Nothing in these is empty." CR> <RTRUE>)>>

<ROUTINE LB-FELT-F ()
	<COND
		(<VERB? SMELL> <TELL "Cigarettes and damp wool. The felt has been soaking up more than sound." CR> <RTRUE>)
		(<VERB? RUB> <TELL "Soft and dusty. It swallows the sound of your hand completely." CR> <RTRUE>)
		(<VERB? KNOCK> <TELL "Your knock makes no sound at all, which is the point of it." CR> <RTRUE>)>>

<ROUTINE LB-VALVES-F ()
	<COND
		(<VERB? LISTEN> <TELL "A low, even hum, and now and then the tick of hot metal." CR> <RTRUE>)
		(<VERB? RUB> <TELL "Warm through the mesh. You take your hand away before it becomes hot." CR> <RTRUE>)>>

<ROUTINE LB-SHELVES-F ()
	<COND
		(<VERB? SEARCH> <TELL "You run a finger along the numbers. Nothing on the shelves is out of order." CR> <RTRUE>)
		(<VERB? RUB> <TELL "Your fingertip comes away grey with dust." CR> <RTRUE>)>>

<ROUTINE LB-READING-TABLE-F ()
	<COND
		(<VERB? LOOK-UNDER> <TELL "Nothing under it but dust and a dropped pencil stub." CR> <RTRUE>)
		(<VERB? KNOCK> <TELL "The table rocks on one short leg and settles." CR> <RTRUE>)>>

<ROUTINE LB-WORKSHOP-SHELVES-F ()
	<COND
		(<VERB? SEARCH> <TELL "Spare parts, every one of them, sorted by size. Nothing here belongs to tonight." CR> <RTRUE>)
		(<VERB? RUB> <TELL "Your hand comes away smelling of rubber insulation." CR> <RTRUE>)>>

<ROUTINE LB-LADDER-F ()
	<COND
		(<VERB? CLIMB-FOO CLIMB-UP CLIMB-DOWN> <COND (<EQUAL? ,HERE ,LB-WORKSHOP> <DO-WALK ,P?DOWN>) (T <DO-WALK ,P?UP>)>)
		(<VERB? RUB> <TELL "The rungs are warm and faintly greasy from the engine below." CR> <RTRUE>)>>

<ROUTINE LB-PIPES-F ()
	<COND
		(<VERB? RUB> <TELL "Cold and wet. A drop runs down your wrist." CR> <RTRUE>)
		(<VERB? LISTEN> <TELL "Water ticks somewhere inside the pipes." CR> <RTRUE>)>>

<ROUTINE LB-RANGE-F ()
	<COND
		(<VERB? SMELL> <TELL "Hot iron and the faint bitter smell of a kettle that has boiled dry once too often." CR> <RTRUE>)
		(<VERB? RUB> <TELL "Warm as a sleeping cat. You keep your hand there longer than you meant to." CR> <RTRUE>)
		(<VERB? LISTEN> <TELL "The kettle ticks and settles, and the fire shifts in the grate." CR> <RTRUE>)>>

<ROUTINE LB-KITCHEN-WINDOW-F ()
	<COND
		(<VERB? OPEN> <TELL "You would let the gale into the only warm room on the island." CR> <RTRUE>)
		(<VERB? KNOCK> <TELL "The glass shivers in its frame. Edith glances up, then away." CR> <RTRUE>)>>

<ROUTINE LB-BATTERIES-F ()
	<COND
		(<VERB? SMELL> <TELL "A sharp, sour whiff of acid." CR> <RTRUE>)
		(<VERB? RUB> <TELL "You think better of it. Battery acid eats through tweed." CR> <RTRUE>)>>

<ROUTINE LB-BUNKS-F ()
	<COND
		(<VERB? LOOK-UNDER SEARCH> <TELL "Only swept boards and a strapped kitbag." CR> <RTRUE>)
		(<VERB? RUB> <TELL "The blankets are coarse grey wool, and cold." CR> <RTRUE>)
		(<VERB? CLIMB-ON> <TELL "You sit on the edge of the nearest bunk. The springs complain, and Ada does not offer you her chair." CR> <RTRUE>)>>

<ROUTINE LB-STATION-F ()
	<COND
		(<VERB? THROUGH ENTER WALK-TO> <DO-WALK ,P?NORTH> <RTRUE>)
		(<VERB? LISTEN> <TELL "Over the wind you can hear the generator thumping somewhere underneath it, steady as a ship's engine." CR> <RTRUE>)>>
