<ROUTINE LB-STATION-CLOCK-F ()
	<COND (<VERB? EXAMINE READ>
		<TELL "The [[station clock]] is running: 9:35. Its spring movement does not depend on the generator. At 9:17 you heard the appeal begin; at 9:21 Ruth found Vane. You wrote both times in your [[casebook]]." CR>
		<RTRUE>)>>
<ROUTINE LB-CASEBOOK-F ()
	<COND (<VERB? EXAMINE READ>
		<TELL "The [[casebook]] has two columns: heard and seen. At 9:17 the appeal began; at 9:21 Vane was found. Your auditory note reads: two coughs, then 'Even this old island can learn to speak.'" CR>
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
		<TELL "Notes record observations, not verdicts. RECONSTRUCT CASEBOOK organizes established facts. For optional explicit next-step guidance, choose HINT CASEBOOK." CR> <RTRUE>)
		(<VERB? HINT> <LB-NEXT> <RTRUE>)
		(<VERB? RECONSTRUCT> <LB-RECONSTRUCT>)>>
<ROUTINE GO ()
	<SETG HERE ,LB-LANDING> <SETG VERBOSE T> <SETG LIT T>
	<SETG FUMBLE-PROB 0>
	<SETG WINNER ,ADVENTURER> <SETG PLAYER ,WINNER>
	<MOVE ,WINNER ,HERE>
	<TELL "THE LAST BROADCAST|Saint Bride Island, 1936. At nine-seventeen a voice asked the mainland to save this station. Four minutes later the station's owner, Julian Vane, was dead.|The appeal began with a gull's double cough, then Ada's voice: 'Even this old island can learn to speak.' You heard those words at 9:17. At 9:21 you heard Ruth call for help. Now the station has fallen quiet.||Your [[casebook]] is dry, which is more than can be said for your profession.||">
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
		<CRLF> <RTRUE>)>>
<ROUTINE LB-DISC-F ()
	<COND (<VERB? EXAMINE READ>
		<TELL "An aluminium-based lacquer [[disc]], sixteen inches across. Edge number A17; one continuous band, about six minutes at the marked speed. It requires the control-room gramophone and a playback stylus. The edge is chipped; the groove is sound." CR>
		<RTRUE>)
		(<VERB? PLAY> <LB-PLAY>)
		(<VERB? COMPARE> <LB-COMPARE>)
		(<VERB? SHOW> <LB-SHOW>)>>
<ROUTINE LB-STYLUS-F ()
	<COND (<VERB? EXAMINE>
		<TELL "A sapphire playback [[stylus]], kept apart from the cutter to prevent a costly confusion. Its sapphire fits the control-room gramophone pickup. It is small enough to lose a fortune." CR> <RTRUE>)
		(<VERB? USE-ON>
			<COND (<EQUAL? ,PRSI ,LB-PLAYER> <LB-MOUNT>)
				(T <TELL "The stylus belongs on the control-room gramophone, not there." CR> <RTRUE>)>)>>
<ROUTINE LB-PLAYER-F ()
	<COND (<VERB? EXAMINE SEARCH LOOK-INSIDE>
		<TELL "A spring-driven broadcast [[gramophone]]. Put the archive disc in it; mount the workshop stylus with USE STYLUS ON GRAMOPHONE; then PLAY GRAMOPHONE. The transmitter feed is disconnected, so the experiment will stay in this room." CR>
		<COND (<IN? ,LB-STYLUS ,LB-PLAYER> <TELL "The pickup is fitted." CR>)>
		<COND (<IN? ,LB-DISC ,LB-PLAYER> <TELL "The [[lacquer disc]] rests on its platter." CR>)>
		<RTRUE>)
		(<VERB? USE-ON USE-WITH>
			<COND (<OR <AND <VERB? USE-ON> <EQUAL? ,PRSO ,LB-STYLUS>> <AND <VERB? USE-WITH> <EQUAL? ,PRSI ,LB-STYLUS>>> <LB-MOUNT>)
				(T <TELL "Only the workshop playback stylus fits the pickup." CR> <RTRUE>)>)
		(<VERB? PLAY LISTEN> <LB-PLAY>)
		(<VERB? PUT>
			<COND (<EQUAL? ,PRSI ,LB-PLAYER>
				<COND (<NOT <EQUAL? ,PRSO ,LB-DISC>> <TELL "Only the [[disc]] belongs on this platter." CR> <RTRUE>)>)>)
		(<VERB? OPEN CLOSE> <TELL "The platter stays open; the [[disc]] must lie flat on it." CR> <RTRUE>)>>
<ROUTINE LB-MOUNT ()
	<COND (<NOT <AND <HELD? ,LB-STYLUS> <ACCESSIBLE? ,LB-STYLUS> <ACCESSIBLE? ,LB-PLAYER>>>
		<TELL "Hold the stylus within reach of the gramophone. A closed bag is no help." CR>)
		(<IN? ,LB-STYLUS ,LB-PLAYER> <TELL "The pickup is already fitted." CR>)
		(T <MOVE ,LB-STYLUS ,LB-PLAYER> <TELL "You fit the sapphire stylus to the pickup. It remains mounted on the gramophone until you take it again. The gramophone is ready for the archive disc." CR>)>
	<RTRUE>>
<ROUTINE LB-PLAY ()
	<COND (<NOT <ACCESSIBLE? ,LB-PLAYER>> <TELL "The playback apparatus is in the control room." CR>)
		(<NOT <IN? ,LB-DISC ,LB-PLAYER>> <TELL "Put the archive disc in the gramophone first." CR>)
		(<NOT <IN? ,LB-STYLUS ,LB-PLAYER>> <TELL "The pickup is bare. Bring the stylus from the workshop and fit it with USE STYLUS ON GRAMOPHONE." CR>)
		(T <SETG LB-SOUND T>
		<TELL "The [[disc]] turns. Ada's voice asks the mainland for help. A gull coughs twice; she says, 'Even this old island can learn to speak.'|Two coughs, then that sentence: the sequence in your opening note, now turning beneath a needle. A later stutter repeats the first syllable with mechanical patience. This appeal existed in a groove before it was supposedly spoken live.|At the centre, a pencilled timing mark sets the start at 9:17. Six minutes would carry the voice past 9:22. Ruth in the studio may recognise the rehearsal; the cutting register can authenticate its origin." CR>)>
	<RTRUE>>

<ROUTINE LB-BOARD-F ()
	<COND (<VERB? EXAMINE READ>
		<TELL "The [[appeal board]] lists tonight's order: 9:12 power test; 9:16 Ruth leaves office; 9:17 Ada speaks; 9:21 Ruth discovers Vane. Ruth wrote the last entry in a hand no longer fit for broadcasting. The two public times agree with your [[casebook]]." CR> <RTRUE>)>>

<ROUTINE LB-OFFICE-CLOCK-F ()
	<COND (<VERB? EXAMINE READ>
		<TELL "The [[office clock]] reads 9:12. Beneath it: SYNCHRONOUS MOVEMENT -- RESTART BY HAND AFTER UNDERVOLTAGE. The winding knob is innocent; this clock never had a spring. Its time needs an independent witness." CR> <RTRUE>)
		(<VERB? COMPARE> <LB-COMPARE>)>>

<ROUTINE LB-BODY-F ()
	<COND (<VERB? EXAMINE SEARCH>
		<TELL "One blow behind the ear. No struggle, no long chase. The [[body]] has stiffened in the attitude of someone signing away another person's future. A crescent of brass dust marks the wound. The crescent is interrupted by one narrow gap. Whatever made it had a matching notch in its edge. ">
		<COND (,LB-CLOCK <TELL "The [[office clock]] records the electrical fault; the wound belongs to the later interval." CR>)
			(T <TELL "The [[office clock]] has yet to account for its stopped hands." CR>)>
		<RTRUE>)
		(<VERB? COMPARE> <LB-COMPARE>)>>

<ROUTINE LB-MICROPHONE-F ()
	<COND (<VERB? EXAMINE LISTEN>
		<TELL "The [[microphone]] wears a red supply lamp. Its tiny plate says HEATER, not ON AIR. It shows that the microphone is warm, not that its voice reaches the transmitter. [[Ruth]] has been treating the two as synonymous." CR> <RTRUE>)>>

<ROUTINE LB-SWITCH-F ()
	<COND (<VERB? EXAMINE READ>
		<TELL "The [[routing switch]] selects MIC or DISC independently of the microphone's red heater lamp. It was found at DISC. A wax dab under its guard records that position; turning it now would tell you nothing about then. The [[gramophone]] supplies the second feed." CR> <RTRUE>)
		(<VERB? TURN PUSH PULL> <TELL "The transmitter is isolated. You test the routing lever without disturbing the wax witness mark: MIC and DISC are independent of the studio heater lamp." CR> <RTRUE>)>>

<ROUTINE LB-CUTTER-F ()
	<COND (<VERB? EXAMINE SEARCH>
		<FSET ,LB-CUTTER ,OPENBIT>
		<COND (<IN? ,LB-WEIGHT ,LB-CUTTER> <TELL "Inside its open cover, a loose [[brass counterweight]] rests in a cradle." CR>)>
		<TELL "The [[cutter]] engraves lacquer on an aluminium base. Its inspection cover lifts without a tool. The [[register]] records every cut by edge number and duration." CR> <RTRUE>)>>

<ROUTINE LB-REGISTER-F ()
	<COND (<VERB? EXAMINE READ>
		<TELL "The [[register]] has two entries: 8:10, R. Bell, B03, two-minute microphone test, destroyed; 8:40, A. Mercer, A17, six-minute appeal, completed. Both were cut before the gale reached the aerial. Compare the actual disc with this register after hearing it." CR> <RTRUE>)
		(<VERB? COMPARE> <LB-COMPARE>)>>

<ROUTINE LB-GENERATOR-F ()
	<COND (<VERB? EXAMINE LISTEN>
		<TELL "The [[generator]] supplies lights and clocks. Accumulators buffer the transmitter; a small voltage sag can stop an office clock without silencing the station. Its mechanical recorder stamps the [[voltage chart]] independently of the electric clocks." CR> <RTRUE>)>>

<ROUTINE LB-CHART-F ()
	<COND (<VERB? EXAMINE READ>
		<TELL "The [[voltage chart]] records a brief fall below clock-running voltage at 9:12 and normal supply at 9:13. Every later minute is steady. The mechanical recorder and the station clock agree on the minute. The office hands have a different story to tell." CR> <RTRUE>)
		(<VERB? COMPARE> <LB-COMPARE>)>>

<ROUTINE LB-STAIN-F ()
	<COND (<VERB? EXAMINE SEARCH>
		<SETG LB-STAIN-SEEN T> <TELL "The [[stain]] is a heel print in diluted blood, pointing away from the office hatch. One square repair has been fixed diagonally across its edge, making a distinctive diamond interruption. It is precise enough to test against a real heel, not merely imagine a similar shape." CR> <RTRUE>)
		(<VERB? COMPARE> <LB-COMPARE>)>>

<ROUTINE LB-TABLE-F ()
	<COND (<VERB? EXAMINE SEARCH>
		<TELL "A broken tumbler has left a little glass dust in the [[table]] grain. Two cups have gone cold. [[Edith]] keeps looking at the cup opposite hers; she and Ruth were here together during the appeal. Her [[medical bag]] is within reach, with permission to inspect it." CR> <RTRUE>)>>

<ROUTINE LB-BAG-F ()
	<COND (<VERB? EXAMINE READ>
		<TELL "A [[medical bag]], kept private rather than locked. Edith has given permission to inspect it. ">
		<COND (<FSET? ,LB-BAG ,OPENBIT>
			<TELL "It stands open now. ">
			<COND (<IN? ,LB-DRESSING ,LB-BAG> <TELL "A [[bloodied dressing]] rests inside.">) (T <TELL "The evidence has been removed.">)>)
			(T <TELL "It is still closed.">)>
		<CRLF> <RTRUE>)>>
<ROUTINE LB-DRESSING-F ()
	<COND (<VERB? EXAMINE READ>
		<SETG LB-DRESSING-SEEN T> <TELL "The [[bloodied dressing]] bears the time 9:17 and initials R.B. in Edith's tidy hand. Three tiny glass fragments adhere to it. A surface cut, not a head wound. Show it to Edith and ask whose blood required the discretion." CR> <RTRUE>)
		(<VERB? SHOW> <LB-SHOW>)>>

<ROUTINE LB-TELEGRAPH-F ()
	<COND (<VERB? EXAMINE LISTEN>
		<TELL "The [[telegraph]] is a two-way landline. Messages are challenged minute by minute, with unpredictable reply groups; the mainland stamps its acknowledgement on the [[receipt]]. No recorded local performance could answer those challenges." CR> <RTRUE>)>>

<ROUTINE LB-RECEIPT-F ()
	<COND (<VERB? EXAMINE READ>
		<SETG LB-RECEIPT-SEEN T> <TELL "The [[telegraph receipt]] carries mainland challenges and Tomas's correct returns at every minute from 9:16 through 9:22. The far-end stamps are intact. Between them, an outgoing message asks a bookmaker for another week. Show it to [[Tomas]]; the shame and the alibi are on the same strip." CR> <RTRUE>)
		(<VERB? SHOW> <LB-SHOW>)>>

<ROUTINE LB-AERIAL-F ()
	<COND (<VERB? EXAMINE LISTEN>
		<TELL "The [[aerial]] sings through the rain. The gulls have left. The double cough you heard behind the appeal is absent from this wet iron. Somewhere a voice has carried better weather into the storm." CR> <RTRUE>)>>

<ROUTINE LB-LAMP-F ()
	<COND (<VERB? EXAMINE READ>
		<TELL "The green [[signal lamp]] follows the transmitter carrier. It cannot distinguish a live voice from a record, or truth from a man being paid to read it. From here the studio's red lamp is invisible: no outside witness could have seen it." CR> <RTRUE>)>>

<ROUTINE LB-BOOTS-F ()
	<COND (<VERB? EXAMINE SEARCH>
		<TELL "Ada's [[leather boots]], offered without grace. The left heel has a square leather repair set diagonally across the edge. Rust-red moisture remains in its stitching. A deliberate repair, not the shape of an ordinary heel. Ada permits you to carry them; her permission sounds like a challenge." CR> <RTRUE>)
		(<VERB? COMPARE> <LB-COMPARE>)>>

<ROUTINE LB-ROSTER-F ()
	<COND (<VERB? EXAMINE READ>
		<TELL "The [[maintenance roster]] assigns Ada the 9:15 inspection beneath the office. The service hatch has a square spindle; the workshop spanner operates it from either side. Ada signed the spanner back at 9:20. Ruth and Edith are assigned to the kitchen, Tomas to the landline. This is duty, not proof of obedience." CR> <RTRUE>)>>

<ROUTINE LB-LEDGER-F ()
	<COND (<VERB? EXAMINE READ>
		<SETG LB-LEDGER-SEEN T> <TELL "The [[wage ledger]] records eleven years of deductions for transmitter shares that were never issued. Mercer, H.: deceased; balance carried forward. Ada's father died still paying for a station he did not own. Vane has marked the accounts for destruction after tomorrow's sale. Ada is the surviving Mercer. These figures have left her something to answer for her father." CR> <RTRUE>)
		(<VERB? SHOW> <LB-SHOW>)>>

<ROUTINE LB-VANE-F ()
	<COND (<VERB? EXAMINE READ>
		<TELL "Vane owned Saint Bride and treated its inhabitants as replaceable components. Each of the four survivors has a reason to hate him. A reason is not a route through an office wall." CR> <RTRUE>)>>

<ROUTINE LB-BROADCAST-F ()
	<COND (<VERB? EXAMINE READ>
		<TELL "At 9:17 Ada's voice began the six-minute appeal. Ruth found Vane at 9:21. The investigation must distinguish the continuing voice from the continuing presence of its owner. Your [[casebook]] can reconstruct the evidence when the experiments are complete." CR> <RTRUE>)>>

<ROUTINE LB-SPANNER-F ()
	<COND (<VERB? EXAMINE> <TELL "A square-socket [[service spanner]], made for the office hatch. There is only one; it is quite large enough to be absent conspicuously." CR> <RTRUE>)
		(<VERB? USE-ON>
			<COND (<EQUAL? ,PRSI ,LB-HATCH> <LB-OPEN-HATCH>)
				(T <TELL "The [[spanner]] operates the service hatch, not that." CR> <RTRUE>)>)>>
<ROUTINE LB-HATCH-F ()
	<COND (<VERB? EXAMINE>
		<COND (<FSET? ,LB-HATCH ,OPENBIT> <TELL "The [[hatch]] stands open. Fresh blood has dried along the underside of its square spindle, where a hand or a heel brushed it. The passage and office are connected now." CR>)
			(T <TELL "A flush [[service hatch]] with a square spindle. Ordinary fingers cannot turn it. The service spanner in the workshop was made for the job." CR>)> <RTRUE>)
		(<VERB? USE-ON USE-WITH OPEN UNLOCK>
			<COND (<OR <AND <VERB? USE-ON> <EQUAL? ,PRSO ,LB-SPANNER>> <AND <VERB? USE-WITH OPEN UNLOCK> <EQUAL? ,PRSI ,LB-SPANNER>>> <LB-OPEN-HATCH>)
				(<FSET? ,LB-HATCH ,OPENBIT> <TELL "The [[hatch]] is already open." CR> <RTRUE>)
				(T <TELL "Only the square service spanner fits. Use it explicitly on the [[hatch]]." CR> <RTRUE>)>)
		(<VERB? CLOSE> <FCLEAR ,LB-HATCH ,OPENBIT> <TELL "You lower the [[hatch]]. The square bolt falls home." CR> <RTRUE>)>>
<ROUTINE LB-OPEN-HATCH ()
	<COND (<NOT <AND <HELD? ,LB-SPANNER> <ACCESSIBLE? ,LB-SPANNER> <ACCESSIBLE? ,LB-HATCH>>>
		<TELL "Hold the service spanner within reach of the [[hatch]]." CR>)
		(<FSET? ,LB-HATCH ,OPENBIT> <TELL "The [[hatch]] is already open." CR>)
		(T <SETG LB-ROUTE T> <FSET ,LB-HATCH ,OPENBIT> <TELL "The bolt turns. You lift the [[hatch]] on its counterbalanced hinges. Warm air rises through a route that never enters the studio." CR>)>
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
	<COND (<VERB? EXAMINE>
		<TELL "Ruth Bell has the trained stillness of an announcer whose next line will ruin someone. Ask her about the [[microphone]], the [[broadcast]], or [[Vane]]." CR>
		<COND (,LB-RUTH-CLEARED <TELL "She has stopped watching the red lamp. When you are ready, she will make the station's first honest announcement tonight." CR>)> <RTRUE>)
		(<VERB? TELL>
			<COND (<EQUAL? ,PRSI ,LB-MICROPHONE>
				<TELL "'Ada asked me to leave the lamp on for her appeal. I did, then fetched Vane; he refused to come. At 9:16 I left him alive, and cut my hand on a glass in the kitchen. Edith dressed it at once. I thought the red meant live.' [[Ruth]] looks at the plate below the [[microphone]]. 'How thoroughly one can read the wrong word.'" CR>)
				(<EQUAL? ,PRSI ,LB-DISC ,LB-BROADCAST>
					<COND (,LB-RUTH-CLEARED <TELL "'Six minutes of her voice. She had enough time to go below and come back. I never saw her at the microphone during the appeal; I only heard her.'" CR>)
						(T <TELL "'I heard Ada all through the appeal. Surely that places her?' [[Ruth]] folds her injured hand. 'If you have the actual recording, let me hear your evidence rather than your conclusion.'" CR>)>)
				(<EQUAL? ,PRSI ,LB-VANE> <TELL "'At 9:16 I left him alive in the office. Edith saw me enter the kitchen straight away. At 9:21 I left her there and found him dead. He owed us wages. That doesn't make what happened a pay rise.'" CR>)
				(T <TELL "'Ask me about the [[microphone]], the [[broadcast]], or [[Vane]]. I can tell you what I saw. What I heard appears more troublesome.'" CR>)> <RTRUE>)
		(<VERB? SHOW> <LB-SHOW>)
		(<VERB? ACCUSE> <LB-ACCUSE>)>>
<ROUTINE LB-EDITH-F ()
	<COND (<VERB? EXAMINE>
		<TELL "Edith Shaw is washing her hands by rubbing them together, without water. Her [[medical bag]] is within reach. Ask about the [[bag]], the [[broadcast]], or [[Vane]]." CR>
		<COND (,LB-EDITH-CLEARED <TELL "Now that the patient is named, she has the plain impatience of a doctor kept from useful work." CR>)> <RTRUE>)
		(<VERB? TELL>
			<COND (<EQUAL? ,PRSI ,LB-BAG ,LB-DRESSING>
				<COND (,LB-EDITH-CLEARED <TELL "'Ruth's cut hand, from 9:16 to 9:21. She was beside me throughout the appeal until she went to fetch Vane. We were both afraid he would dismiss her for breaking the glass. A splendid standard for an employer.'" CR>)
					(T <TELL "'The blood in my bag belongs to a patient. You may inspect it. I will not make medical privacy look less suspicious merely to suit you.'" CR>)>)
				(<EQUAL? ,PRSI ,LB-BROADCAST> <TELL "'I heard the appeal from the kitchen. Ruth came in at 9:16, before it started, and stayed until 9:21. A voice through a wall is not a medical observation of its owner.'" CR>)
				(<EQUAL? ,PRSI ,LB-VANE> <TELL "'He threatened to expose my treatment of union men who could not pay. There was nothing unlawful in treating them; he only needed their next employers to know. He was alive when Ruth left him at 9:16. The clock is irrelevant to the wound.'" CR>)
				(T <TELL "'Ask about the [[medical bag]], the [[broadcast]], or [[Vane]]. You may examine the bag. I would prefer a fact to an insinuation.'" CR>)> <RTRUE>)
		(<VERB? SHOW> <LB-SHOW>)
		(<VERB? ACCUSE> <LB-ACCUSE>)>>
<ROUTINE LB-TOMAS-F ()
	<COND (<VERB? EXAMINE>
		<TELL "Tomas Vale holds his hands flat, as though they might otherwise transmit a confession. Ask about the [[receipt]], the [[broadcast]], or [[Vane]]." CR>
		<COND (,LB-TOMAS-CLEARED <TELL "He has stopped hiding the outgoing side of the receipt. It is a small, sensible revolution." CR>)> <RTRUE>)
		(<VERB? TELL>
			<COND (<EQUAL? ,PRSI ,LB-RECEIPT>
				<COND (,LB-TOMAS-CLEARED <TELL "'The bookmaker knows. You know. Vane knew. Oddly, the third is no longer the worst of it. I shall leave the island owing an ordinary sum to an ordinary brute.'" CR>)
					(T <TELL "'The mainland can verify my times. Please read the [[receipt]] yourself. I would rather be suspected of murder than discuss the message on the other side.' He pauses. 'That came out badly.'" CR>)>)
				(<EQUAL? ,PRSI ,LB-BROADCAST> <TELL "'I heard Ada from 9:17. I was answering challenge groups on this [[telegraph]] from 9:16 until 9:22. A recording cannot know which numbers the mainland will choose next.'" CR>)
				(<EQUAL? ,PRSI ,LB-VANE> <TELL "'He bought my gambling debt. Then he charged me for the favour every payday. I wanted to leave, not become a murderer permanently resident here.'" CR>)
				(T <TELL "'Ask about the [[receipt]], the [[broadcast]], or [[Vane]]. I have no talent for looking innocent. The telegraph is better at it.'" CR>)> <RTRUE>)
		(<VERB? SHOW> <LB-SHOW>)
		(<VERB? ACCUSE> <LB-ACCUSE>)>>
<ROUTINE LB-ADA-F ()
	<COND (<VERB? EXAMINE>
		<TELL "Ada Mercer is looking at the space between her hands. Her speech is exact; her breathing less so. Ask about the [[boots]], the [[broadcast]], [[Vane]], or the [[roster]]." CR>
		<COND (,LB-TRACE <TELL "When you mention the heel repair she draws her bare feet under the chair." CR>)
			(,LB-MOTIVE <TELL "She no longer speaks of the owner, only of Vane." CR>)> <RTRUE>)
		(<VERB? TELL>
			<COND (<EQUAL? ,PRSI ,LB-BOOTS ,LB-ROSTER>
				<COND (,LB-TRACE <TELL "'I should have burned them.' Ada catches the words too late. 'Because they are worn out. You can take down whichever version you prefer.'" CR>)
					(T <TELL "'I repaired the heel myself. I inspect the cable passage every evening; it is my route on the [[roster]]. Take the [[boots]] if you must. I have had enough of standing.'" CR>)>)
				(<EQUAL? ,PRSI ,LB-DISC> <LB-ADA-EXHIBIT ,LB-DISC>)
				(<EQUAL? ,PRSI ,LB-WEIGHT> <LB-ADA-EXHIBIT ,LB-WEIGHT>)
				(<EQUAL? ,PRSI ,LB-BROADCAST>
					<COND (,LB-PROVENANCE <LB-ADA-EXHIBIT ,LB-DISC>)
						(T <TELL "'Everyone heard me speaking. Ask Ruth. The recording equipment exists for emergencies; an island is a series of emergencies with water between them.'" CR>)>)
				(<EQUAL? ,PRSI ,LB-STAIN>
					<COND (,LB-TRACE <LB-ADA-EXHIBIT ,LB-BOOTS>)
						(T <TELL "'It is a service passage. You must distinguish a trace of routine work from something that happened tonight.'" CR>)>)
				(<EQUAL? ,PRSI ,LB-VANE ,LB-LEDGER>
					<COND (,LB-MOTIVE <TELL "'My father thought the shares would keep me here safely after he died. Instead they kept us both paying. I wanted the proof to live longer than Vane's ownership.'" CR>)
						(T <TELL "'The accounts are in the archive. If you want to understand this station, read them. People are noisier than figures and generally less exact.'" CR>)>)
				(T <TELL "'Ask about my [[boots]], the [[roster]], the [[broadcast]], or [[Vane]]. Please make it a question whose answer you intend to hear.'" CR>)> <RTRUE>)
		(<VERB? SHOW> <LB-SHOW>)
		(<VERB? ACCUSE> <LB-ACCUSE>)>>

<ROUTINE LB-SHOW ()
	<COND (<NOT <AND <HELD? ,PRSO> <ACCESSIBLE? ,PRSO> <ACCESSIBLE? ,PRSI>>>
		<TELL "Hold the exhibit where its witness can actually see it. A closed container defeats the demonstration." CR>)
		(<AND <EQUAL? ,PRSI ,LB-ADA> <OR <EQUAL? ,PRSO ,LB-DISC ,LB-BOOTS> <EQUAL? ,PRSO ,LB-WEIGHT>>>
			<LB-ADA-EXHIBIT ,PRSO>)
		(<AND <EQUAL? ,PRSO ,LB-DISC> <EQUAL? ,PRSI ,LB-RUTH>>
		<COND (<NOT ,LB-SOUND> <TELL "'It is a disc,' says [[Ruth]]. 'We have dozens. Hear it first; tell me whether it is the one you heard tonight.'" CR>)
			(T <SETG LB-RUTH-CLEARED T> <TELL "Ruth repeats the gull cough from memory, then laughs once without pleasure. 'The rehearsal. I was in the cutting room at 8:40. Ada recorded all six minutes. She told me to leave the microphone heater on tonight, and I thought that meant she was live. At 9:16 I reached the kitchen, cut my hand on a glass, and stayed with Edith until 9:21. Ada did not need me to lie. She needed me to misunderstand.'|The tiny glass cut is still visible. You have both a recording witness and a medical witness to test." CR>)>)
		(<AND <EQUAL? ,PRSO ,LB-DRESSING> <EQUAL? ,PRSI ,LB-EDITH>>
		<COND (<NOT ,LB-DRESSING-SEEN> <TELL "Read the [[dressing]] before asking Edith to identify the evidence." CR>)
			(T <SETG LB-EDITH-CLEARED T> <TELL "'Ruth Bell. Three fragments of glass, here, here and here.' [[Edith]] points without touching. 'She entered at 9:16; I dated the dressing 9:17 while the appeal began. She sat with me until 9:21. We can account for one another throughout the interval. I concealed a patient's name, not Vane's death.'|The matching little cut on Ruth's hand explains the blood. It does not match the blunt head wound." CR>)>)
		(<AND <EQUAL? ,PRSO ,LB-RECEIPT> <EQUAL? ,PRSI ,LB-TOMAS>>
		<COND (<NOT ,LB-RECEIPT-SEEN> <TELL "Read the mainland stamps on the [[receipt]] before presenting it." CR>)
			(T <SETG LB-TOMAS-CLEARED T> <TELL "Tomas turns the [[receipt]] over. 'A bookmaker. Forty-seven pounds. Vane was going to tell my mother; you may think that funny if you have not met her.'|The mainland's unpredictable challenges required his hand at the key every minute, 9:16 to 9:22. No interval remains for the office journey. He has hidden a debt, not a departure." CR>)>)
		(<AND <EQUAL? ,PRSO ,LB-LEDGER> <EQUAL? ,PRSI ,LB-ADA>>
		<COND (<NOT ,LB-LEDGER-SEEN> <TELL "Read the [[ledger]] before asking Ada to explain it." CR>)
			(T <SETG LB-MOTIVE T> <TELL "Ada touches her father's name. 'He promised shares instead of wages. Then sold the station as though none of us had paid for it. Tomorrow he meant to burn the accounts. He told me so at nine-fifteen.'|Her anger is unmistakable; its existence proves no murder. But the [[ledger]] explains why a prepared recording might become more than insurance against a failed microphone. 'Do not let them call him a generous man,' she says." CR>)>)
		(T <TELL "That exhibit does not resolve this witness's contradiction. Each survivor has something specific to explain." CR>)>
	<RTRUE>>

<ROUTINE LB-NEXT ()
	<COND (<NOT ,LB-CLOCK> <TELL "The office clock may date a power fault. Bring the generator room's voltage chart to it and compare them." CR>)
		(<NOT ,LB-SOUND> <TELL "Test the voice. Open the archive sleeve; take its disc and the workshop stylus to the control room. Fit the stylus, put the disc in the gramophone, and play it." CR>)
		(<NOT ,LB-PROVENANCE> <TELL "Authenticate the heard recording: take the disc to the cutting register and compare them." CR>)
		(<NOT ,LB-ROUTE> <TELL "Test the service route. The workshop spanner opens the office hatch from either side." CR>)
		(<NOT ,LB-WEAPON> <TELL "Examine the disc cutter and take its loose counterweight to the body. Compare the brass rim with the wound." CR>)
		(<NOT ,LB-TRACE> <TELL "Examine the passage stain. Bring Ada's boots there and compare their heel repair with the print." CR>)
		(<NOT ,LB-RUTH-CLEARED> <TELL "Show the heard disc to Ruth. Test her interpretation of the microphone's red lamp." CR>)
		(<NOT ,LB-EDITH-CLEARED> <TELL "Open Edith's medical bag, examine its dressing, and show it to her. Learn whose blood it carries." CR>)
		(<NOT ,LB-TOMAS-CLEARED> <TELL "Read the telegraph receipt and show it to Tomas. A remote witness can verify a local alibi." CR>)
		(<NOT ,LB-MOTIVE> <TELL "Read the archive wage ledger and show it to Ada. Her reply belongs to the case, though a motive alone never does." CR>)
		(T <TELL "The evidence is sufficient. RECONSTRUCT CASEBOOK, then confront a suspect in person. A wrong accusation will not close the investigation." CR> <RFALSE>)>
	<RTRUE>>
<ROUTINE LB-COMPLETE? ()
	<AND ,LB-CLOCK ,LB-SOUND ,LB-PROVENANCE ,LB-ROUTE ,LB-WEAPON ,LB-TRACE
		,LB-RUTH-CLEARED ,LB-EDITH-CLEARED ,LB-TOMAS-CLEARED ,LB-MOTIVE>>
<ROUTINE LB-RECONSTRUCT ()
	<COND (<NOT <LB-COMPLETE?>>
		<TELL "There is still a gap in the reconstruction. The [[casebook]] records established observations; an unanswered measurement or untested witness cannot become a fact by being written neatly. Optional HINT CASEBOOK gives explicit guidance if you want it." CR>)
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
				<TELL "'The voice stayed here,' you say. 'You did not.'|Ada looks once at the heel repair. 'I recorded an appeal to save the place. Then he said he would burn my father's name with the accounts. I started the disc because I knew what I was going to do. Not because the machine failed. Because it worked.'|She describes the counterweight, the hatch, and the spanner returned at nine-twenty. You write the admission beneath the facts which earned it. The ledger will go to the workers; the rest goes to the police. Neither fact cancels the other.|Ruth makes one last announcement. No music, no rehearsal: Julian Vane is dead; the station will remain silent until morning. Outside, the gulls have returned. They have nothing prepared.||THE LAST BROADCAST -- CASE SOLVED.||" >
				<FINISH>)>)
		(T <TELL "Accuse a person, with evidence sufficient to withstand an answer." CR>)>
	<RTRUE>>

<ROUTINE V-SCORE ("OPTIONAL" (ASK? <>))
	<COND (,LB-WON <TELL "The case is solved; the evidence and the workers' accounts are preserved." CR>)
		(T <TELL "The case is open. Your casebook records observations; optional hints require HINT CASEBOOK." CR>)>>
<ROUTINE LB-OFFICE-F (RARG)
	<COND (<EQUAL? .RARG ,M-LOOK>
		<TELL "The [[body]] sits with its back to the light. An [[office clock]] hangs above the [[hatch]]. ">
		<COND (<FSET? ,LB-HATCH ,OPENBIT> <TELL "The hatch stands open to the [[passage below->down]]. ">)
			(T <TELL "The hatch is bolted shut over the [[route below->down]]. ">)>
		<TELL "The [[hall->south]] lies south." CR> <RTRUE>)>>
<ROUTINE LB-PASSAGE-F (RARG)
	<COND (<EQUAL? .RARG ,M-LOOK>
		<TELL "Hot cable rubber cuts through the smell of damp stone. A [[stain]] lies beneath the [[hatch]]. ">
		<COND (<FSET? ,LB-HATCH ,OPENBIT> <TELL "The open hatch admits light from the [[office above->up]]. ">)
			(T <TELL "The hatch is shut against the [[office above->up]]. ">)>
		<TELL "The [[generator room->south]] lies south." CR> <RTRUE>)>>

<ROUTINE LB-WEIGHT-F ()
	<COND (<VERB? EXAMINE>
		<TELL "A loose [[brass counterweight]], heavy enough to balance the cutting arm. One rim has a broken notch and a damp polished crescent. Something dark remains behind its retaining lug. Its edge has the shape of an incomplete crescent." CR> <RTRUE>)
		(<VERB? COMPARE> <LB-COMPARE>)>>

<ROUTINE LB-ADA-EXHIBIT (EXHIBIT)
	<COND (<EQUAL? .EXHIBIT ,LB-DISC>
		<COND (,LB-PROVENANCE
			<TELL "'A reserve,' Ada says. 'I cut the appeal in case the live feed failed. Preparing for a fault is my job.' She keeps looking at the label, not at you. 'You have proved when that voice was made. You have not proved where I stood when it was played.'" CR>)
			(,LB-SOUND <TELL "'My voice, yes. A reserve recording. You can hear what is on it; its edge and the cutting entry can tell you the rest.' Ada draws her hands away from the disc." CR>)
			(T <TELL "'A disc is not yet an accusation. Have you listened to it?' Ada does not reach for it." CR>)>)
		(<EQUAL? .EXHIBIT ,LB-BOOTS>
		<COND (,LB-TRACE
			<TELL "'Inside the stitching?' Ada repeats. She begins to say 'routine inspection', then stops. The repair is her own work; now she will not look at it. 'You have measured it. I cannot improve a measurement by speaking.'" CR>)
			(T <TELL "'I repair my own soles. That square patch is mine. If you think the boots tell you where I went, measure them against something. Don't ask me to supply the ground.'" CR>)>)
		(<EQUAL? .EXHIBIT ,LB-WEIGHT>
		<COND (,LB-WEAPON
			<TELL "Ada starts to turn the counterweight, then stops before her thumb reaches the dark retaining lug. 'I cleaned that machine every morning. Not this evening.' Her voice has lost its broadcast precision. 'Anyone could lift it. That is all I can say about it.'" CR>)
			(T <TELL "'The cutter's counterweight. Loose, by design. It is meant to balance an arm, not prove a theory. What have you matched its edge to?'" CR>)>)>
	<RTRUE>>
