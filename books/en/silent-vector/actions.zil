<SYNTAX TURN OBJECT = V-SPIN>
<SYNTAX RESET OBJECT = V-RESET-HABITAT>
<ROUTINE V-RESET-HABITAT ()
 <COND (<EQUAL? ,PRSO ,BREAKER> <PERFORM ,V?PUSH ,BREAKER> <RTRUE>)
       (T <TELL "You look for a reset, but there is no obvious one here." CR>)>>

<GLOBAL POWER <>>
<GLOBAL COOLING <>>
<GLOBAL PROOF <>>
<GLOBAL ORIGIN <>>
<GLOBAL TERMINATED <>>
<GLOBAL ISOLATED <>>
<GLOBAL CONSENT <>>
<GLOBAL EVAC <>>
<GLOBAL RESOLVED <>>
<GLOBAL SENN-DISCLOSED <>>
<GLOBAL HUB-MILESTONE -1>
<GLOBAL HINT-STAGE -1>
<GLOBAL HINT-LEVEL 0>

<ROUTINE RECORDS-LOOK (RARG)
	<COND (<EQUAL? .RARG ,M-LOOK>
		<TELL "You are in the Physical Archive, a cramped [[storeroom->shelves]] for the records Asterion keeps on paper and metal, where no signal can reach them. The air is dry and still, and your own footsteps sound very loud.">
		<COND (<FSET? ,RECORDER ,OPENBIT> <TELL " The witness [[recorder]] stands open on its sprung feet beside the [[mass ledger->ledger]], still ringing faintly with each step.">)
			(T <TELL " Each footfall makes the sealed witness [[recorder]] ring softly on its sprung feet. Beside it, a heavy [[mass ledger->ledger]] lies open.">)>
		<TELL " The galley is back to the [[west]]." CR> <RTRUE>)>>

<ROUTINE V-VERSION ()
	<TELL "The Silent Vector|Studio Null, 2026|Release " N ,RELEASEID CR>>

<ROUTINE GO ()
	<V-VERSION> <CRLF>
	<SETG COMPACT-ROOM-LISTS T>
	<SETG HERE ,CRADLE>
	<SETG VERBOSE T>
	<SETG LIT T>
	<SETG WINNER ,ADVENTURER>
	<SETG PLAYER ,WINNER>
	<MOVE ,WINNER ,HERE>
	<TELL "“Keep holding her hand.” You remember saying it, and you remember a small, cold hand in yours." CR CR "You are the engineer of Asterion, a research station far out beyond the outer relay. The crew list says four people live here, and you can name them all; yet you remember a fifth, as clearly as you remember your own voice comforting her. Now something has tripped the habitat systems. You have woken alone in your sleeping cradle, with the strap loose across your chest. Your fingers are still cold." CR CR>
	<TELL D ,HERE CR>
	<V-LOOK>
	<MAIN-LOOP>
	<AGAIN>>

<ROUTINE CRADLE-NORTH ()
	<COND (,POWER ,HUB)
		(T <TELL "The pressure interlock holds. The [[breaker]] needs a reset." CR> <RFALSE>)>>
<ROUTINE BREAKER-F ()
	<COND (<VERB? EXAMINE READ>
		<COND (,POWER <TELL "The [[breaker]] is reset and holding. The mechanical pressure [[telltale]] in its housing reads one atmosphere; no software drives it." CR>)
			(T <TELL "The [[breaker]] is tripped, not broken. Its broad face is a push reset. A mechanical [[telltale]] in the housing shows the reserves are holding pressure." CR>)>)
		(<VERB? LISTEN> <COND (,POWER <TELL "Silence from the housing, and behind it the ordinary hush of moving air." CR>) (T <TELL "The dry click comes from behind the breaker's face: a relay trying, every second, to close and failing." CR>)>)
		(<VERB? RUB> <TELL "The broad face is cool plastic, with a shallow dish worn into it where palms have pressed it before." CR>)
		(<VERB? KICK ATTACK> <TELL "You have spent your career teaching people not to hit breakers. You are not going to start now." CR>)
		(<VERB? SPIN> <TELL "There is no dial. You reset this breaker by pressing its broad face." CR>)
		(<VERB? PUSH TURN>
		<COND (,POWER <TELL "Already reset. The mechanical telltale remains at one atmosphere." CR>)
			(T <SETG POWER T> <TELL "The [[breaker]] catches. Air moves across your face. The mechanical telltale settles at one atmosphere, and the interlock releases [[north]]. A small fact, independent of anything you remember." CR>)>)>>

;"Only verbs absent from the native substrate are registered here."
<SYNTAX COMPARE OBJECT WITH OBJECT = V-COMPARE>
<SYNTAX FIT OBJECT TO OBJECT = V-FIT>
<SYNTAX SHOW OBJECT TO OBJECT = V-SHOW>
<SYNTAX PRESERVE OBJECT = V-PRESERVE>
<SYNTAX ERASE OBJECT = V-ERASE>
<SYNTAX HINT = V-HINT>

<ROUTINE COPPER-STRIP-F ()
	<COND (<VERB? EXAMINE>
		<TELL "Your hand finds four worn finger marks in the bare strip.">
                <COND (,ISOLATED <TELL " You remember a fifth pair of footsteps here, but the passage is quiet now.">)>
		<COND (,COOLING <TELL " Cool air from below slips between your fingers.">)
		      (T <TELL " Heat from the spine below has made the metal almost too warm to touch.">)>
		<CRLF> <RTRUE>)
		(<VERB? SMELL> <TELL "Metal and old fingerprints, the taste of a coin held on the tongue." CR>)
		(<VERB? KNOCK> <TELL "The rail gives a dull ring that travels away around the junction and comes back to your hand a moment later." CR>)
		(<VERB? RUB> <TELL "The metal is smooth and faintly greasy. Your fingers settle into the worn places on the rail without your having to look." CR>)>>

<ROUTINE HUB-F (RARG "AUX" (STAGE 0))
	<COND (<EQUAL? .RARG ,M-LOOK>
		<COND (,EVAC <SET STAGE 4>) (,ISOLATED <SET STAGE 3>) (,PROOF <SET STAGE 2>) (,COOLING <SET STAGE 1>)>
		<TELL "You are in the Habitat Junction, where six ways meet at the centre of the [[station->junction]]. A bare [[copper rail->copper]] runs around the wall at hand height, polished by years of hands, and the air at the junction tastes faintly of it.">
		<COND (<OR <EQUAL? .STAGE ,HUB-MILESTONE> <0? .STAGE>> T)
		      (,EVAC <TELL " Looking up the ladder, you can see Mara is waiting in the cupola.">)
		      (,ISOLATED <TELL " The compulsive half-heard syllable is gone from the air here.">)
		      (,PROOF <TELL " You count four worn [[marks->copper]] on the rail, just as the measured breath-load said.">)
		      (T <TELL " Cool air from the spine below reaches your ankles.">)>
		<SETG HUB-MILESTONE .STAGE>
		<TELL " The torque shop is to the [[west]] and the galley to the [[east]]; the clinic lies [[north]], and your sleeping cradle is back to the [[south]]. A [[ladder]] runs [[down]] into the service spine and [[up]] to the launch cupola." CR>
		<RTRUE>)>>
<ROUTINE CLINIC-F (RARG)
	<COND (<EQUAL? .RARG ,M-LOOK>
		<TELL "You are in the Clinic, a small white room with a single [[exam bed->bed]] under a bright lamp. It smells of ordinary [[soap]], and the [[clinical log->log]] lies open beside it.">
		<COND (<IN? ,MARA ,CLINIC>
			<COND (,ISOLATED <TELL " [[Mara]], the station physician, holds her own wrist, counting without looking at the time.">)
				(T <TELL " [[Mara]], the station physician, looks up and asks whether you have eaten.">)>)
			(T <TELL " Mara has gone to the launch cupola.">)>
		<TELL " The junction is back to the [[south]], and the comparison laboratory lies [[north]]." CR>
		<RTRUE>)>>
<ROUTINE LAB-F (RARG)
	<COND (<EQUAL? .RARG ,M-LOOK>
		<TELL "In the Comparison Laboratory, steel [[benches]] catch every reflection. Even the instruments are bolted down. The light gathers on the glass of the optical [[comparator]],">
		<COND (,PROOF <TELL " its readout holding steady.">)
		      (T <TELL " which vibrates at the very edge of hearing.">)>
		<TELL " The clinic is back to the [[south]], and screened quarantine lies to the [[east]]." CR>
		<RTRUE>)>>
<ROUTINE COOLANT-F (RARG)
	<COND (<EQUAL? .RARG ,M-LOOK>
		<TELL "You are in the Coolant Well, a round shaft where the station's cooling [[pipes]] come up through the deck. The coolant [[pump]] squats in the middle of it, its square fitting at knee height.">
		<COND (,COOLING <TELL " Cold [[mist]] curls around it as it turns, and frost is starting to form around it.">)
			(T <TELL " It makes a patient, unsuccessful sucking sound, like a straw at the bottom of a glass.">)>
		<TELL " The service spine is back to the [[east]]." CR> <RTRUE>)>>
<ROUTINE RELAY-F (RARG)
	<COND (<EQUAL? .RARG ,M-LOOK>
		<TELL "You are in the Receive Relay, a narrow [[bay]] where everything the station hears from outside comes in. The [[incoming bus->bus]], a thick armoured cable, runs out of a conduit to an open termination socket.">
		<COND (,ISOLATED <TELL " It hangs severed now, and the bay is silent.">)
			(,TERMINATED <TELL " It hums at a lower note against its fitted [[null spool->spool]].">)
			(T <TELL " It sings with a thin, high note you feel through your teeth.">)>
		<TELL " The service spine is to the [[west]], and the receiver vault lies [[north]]." CR> <RTRUE>)>>
<ROUTINE RECEPTION-F (RARG)
	<COND (<EQUAL? .RARG ,M-LOOK>
		<TELL "You duck into the Receiver Vault below the relay. The signal [[receiver]] almost fills it: one tall steel housing, with just enough space beside it to turn around.">
		<COND (<FSET? ,RECEIVER ,OPENBIT> <TELL " Its housing stands open, and the machine is silent.">)
			(,ISOLATED <TELL " It is silent now. You remember it thanking you, though it makes no sound.">)
			(T <TELL " With each low beat it gives, your tongue tries to shape a name.">)>
		<TELL " The only way out is [[south]], back to the relay." CR>
		<RTRUE>)>>
<ROUTINE QUARANTINE-F (RARG)
	<COND (<EQUAL? .RARG ,M-LOOK>
		<TELL "You are in Screened Quarantine, a bare cell hung with dull grey [[shielding]]. [[Senn]], the reconstruction researcher, sits on its only bench.">
		<COND (,SENN-DISCLOSED <TELL " His hands are closed now, and he meets your eyes.">)
			(,ISOLATED <TELL " He lets you finish speaking before he says, “Ask me about my [[daughter]] again.”">)
			(,PROOF <TELL " “When the carrier is quiet,” he says, “ask me about my [[daughter]] again.”">)
			(T <TELL " His lips shape the last word of your greeting before you say it.">)>
		<TELL " The laboratory is back to the [[west]]. To the [[north]], a heavy pressure [[interlock]] seals the way into the cold core." CR>
		<RTRUE>)>>

<ROUTINE CORE-F (RARG)
	<COND (<EQUAL? .RARG ,M-LOOK>
		<TELL "You are in the Cold Core, a vaulted chamber at the heart of the station, kept so cold that your breath hangs white.">
		<COND (<IN? ,WAFER ,COLD-ARCHIVE> <TELL " Inside the open sleeve of the [[cold archive->archive]], the [[wafer]] rests in cold storage under a rim of frost.">)
		      (T <TELL " The [[cold archive->archive]] stands at the far end, its access sleeve open and empty.">)>
		<TELL " Beside it, the [[decision console->console]] glows faintly. The only way out is [[south]], back to quarantine." CR>
		<RTRUE>)>>
<ROUTINE LAUNCH-F (RARG)
	<COND (<EQUAL? .RARG ,M-LOOK>
		<TELL "You are in the Launch Cupola, a glass [[dome]] at the very top of the station. Beyond it the [[stars]] hang hard and steady while the habitat turns slowly beneath them. Four empty [[evacuation seats->seats]] are arranged around the mechanical [[beacon]].">
		<COND (,EVAC <TELL " The beacon is armed now, and [[Mara]] waits beside the seats, counting under her breath.">)>
		<TELL " The [[ladder]] leads [[down]] to the junction." CR>
		<RTRUE>)>>

<ROUTINE CORE-NORTH ()
	<COND (<AND ,ISOLATED ,PROOF> ,CORE)
		(T <TELL "The cold-core interlock requires independent comparison and physical receive isolation. [[Senn]] touches the blank inspection field, then takes his hand away." CR> <RFALSE>)>>

<ROUTINE WRENCH-F ()
	<COND
		(<VERB? SHAKE LISTEN> <TELL "One dry click. The wrench has a spring and a stop, neither of which cares who is holding it." CR>)
		(<VERB? RUB> <TELL "You close your hand around the grip. It fits exactly. For a moment you feel a second, smaller hand settle over your knuckles, and then only your own." CR>)
		(<VERB? SMELL> <TELL "Machine oil and the faint sourness of old coolant." CR>)
		(<VERB? EXAMINE> <TELL "A calibrated torque [[wrench]], built for the coolant pump's square fitting. The grip is worn to the shape of your hand. A remembered smaller hand lies over yours; the grip has only one wear pattern." CR>)>>
<ROUTINE SHEARS-F ()
	<COND
		(<VERB? OPEN CLOSE> <TELL "The jaws meet without a ring. You can feel the blades close, but the quiet makes it seem as if they haven't." CR>)
		(<VERB? RUB> <TELL "The ceramic blades are smooth and faintly warm, like a cup that held tea an hour ago. They do not conduct the cold of your fingers." CR>)
		(<VERB? SMELL> <TELL "Antiseptic, sharp and clean. Mara looks after her tools." CR>)
		(<VERB? EXAMINE> <TELL "Nonconductive [[ceramic shears->shears]]. Mara used them for sterile cable work before anyone thought we needed weapons. They cut the incoming bus safely, once it is terminated." CR>)>>
<ROUTINE SPOOL-F ()
	<COND (<VERB? LISTEN> <COND (<IN? ,SPOOL ,BUS> <TELL "A low, steady hum as it soaks up the line's stored charge." CR>) (T <TELL "Nothing. A passive spool has nothing in it to make a sound." CR>)>)
		(<VERB? RUB> <TELL "Your thumb finds Ivo's scratched initials, and then the smoother patch where the second name was rubbed away." CR>)
		(<VERB? EXAMINE> <TELL "A passive [[null spool->spool]]: no processor, just impedance matched to the incoming bus. ">
			<COND (<IN? ,SPOOL ,BUS> <TELL "It is locked onto the bus termination. ">)
				(T <TELL "Fit it to the bus before cutting. ">)>
			<TELL "Ivo has scratched his initials into its casing. Beside them, a second name has been started and rubbed away." CR>)
		(<VERB? FIT> <V-FIT>)
		(<AND <VERB? TAKE> <IN? ,SPOOL ,BUS>>
		<TELL "Once fitted, the [[spool]] belongs to the safety termination. Leave it there; no other task needs it." CR>)>>
<ROUTINE PROTOCOL-F ()
	<COND (<VERB? RUB> <TELL "The lamination is scratched where gloved fingers have traced the steps, over and over, during drills." CR>)
		(<VERB? LOOK-BEHIND TAKE> <TELL "The card is riveted to the insulation. Someone wanted it to stay exactly where it is." CR>)
		(<VERB? EXAMINE READ>
		<TELL "RECEIVE ISOLATION / COOL STORAGE. Restore coolant with the torque wrench. FIT SPOOL TO BUS, then CUT BUS WITH SHEARS. The spool absorbs discharge; ceramic blades cannot feed it into your nervous system. Only then OPEN RECEIVER. Compare physical witness foil in the laboratory before accepting autobiographical evidence. Store a recovered wafer in the cold archive. A mechanical rendezvous beacon is safe; radio is not." CR>)>>
<ROUTINE PORTRAIT-F ()
	<COND (<VERB? RUB> <TELL "Your fingertip breaks a droplet. The face comes apart into beads, then gathers itself again around the gap your finger left." CR>)
		(<VERB? LISTEN> <TELL "The field that holds it whines very softly. You catch yourself waiting for the child to speak." CR>)
		(<VERB? EXAMINE READ>
		<TELL "Surface tension pins a child's face in clear [[droplets]]. It is beautiful and technically pointless. [[Ivo]] made it for Senn from a family photograph. A fifth adult sometimes seems to stand behind the child; when you count the actual droplets, no such figure is there. Ask Ivo about the [[daughter]]." CR>)>>
<ROUTINE RECORDER-F ()
	<COND (<AND <VERB? PUT PUT-ON> <EQUAL? ,PRSI ,RECORDER> <NOT <EQUAL? ,PRSO ,STRIP>>>
		<TELL "Only the witness strip belongs on the recorder's drum. You keep the other equipment clear of its springs." CR>)
		(<VERB? LISTEN> <TELL "Each step you take sets it ringing, a thin note on its sprung feet. When you stand still, it falls quiet." CR>)
		(<VERB? KNOCK> <TELL "The casing rings like a struck glass. Somewhere inside, the drum shivers and records your knock as weight." CR>)
		(<VERB? RUB> <TELL "The casing is cold, smooth metal with no ports, no lights and no network jack. Nothing in it could be told what to remember." CR>)
		(<VERB? EXAMINE READ>
		<COND (<NOT <FSET? ,RECORDER ,OPENBIT>> <TELL "Each step sets the sealed witness [[recorder]] ringing on its sprung feet. Its drum records pressure mechanically, even with the network disconnected. Open it to recover the foil. It weighs actual breath loads; it cannot record names." CR>)
				(<IN? ,STRIP ,RECORDER> <TELL "A mechanical witness [[recorder]], disconnected from the network before the signal arrived. Its lid stands open; the [[witness strip->strip]] rests on the exposed drum. It weighs actual breath loads; it cannot record names." CR>)
				(T <TELL "A mechanical witness [[recorder]], disconnected from the network before the signal arrived. Its lid stands open and the drum is bare; the foil has been removed. It weighs actual breath loads; it cannot record names." CR>)>)
		(<VERB? OPEN SEARCH LOOK-INSIDE>
		<COND (<FSET? ,RECORDER ,OPENBIT> <TELL "The [[recorder]] is already open." CR>)
			(T <FSET ,RECORDER ,OPENBIT> <TELL "The lid releases with a small musical note." CR>)>
		<COND (<IN? ,STRIP ,RECORDER> <TELL "A [[witness strip->strip]] rests on the exposed drum." CR> <THIS-IS-IT ,STRIP>)
			(T <TELL "The drum is empty." CR>)>)>>
<ROUTINE STRIP-F ()
	<COND (<VERB? EXAMINE READ>
		<COND (,PROOF <TELL "Four human breath loads. No fifth. The [[strip]] is the same foil you removed; the laboratory merely made its trace legible. ">
				<COND (,CONSENT <TELL "Ivo has examined it. His consent is on the record; keep the original reference." CR>)
					(T <TELL "Ivo needs to see this evidence before committing to evacuation." CR>)>)
			(T <TELL "The [[strip]] carries pressure and mass traces, not language. You cannot reliably count them by eye. Compare it with the optical comparator in the laboratory." CR>)>)
		(<VERB? COMPARE> <V-COMPARE>)
		(<VERB? SHOW> <V-SHOW>)
		(<VERB? RUB> <TELL "The foil is thinner than paper. Under your fingertip you can feel faint ridges, too fine to count." CR>)
		(<VERB? SMELL> <TELL "It smells of nothing at all, which is a kind of relief." CR>)>>

<ROUTINE LEDGER-F ()
	<COND (<VERB? RUB> <TELL "The page is deeply indented. Running your fingers down it, you can feel four names pressed into the paper and no more." CR>)
		(<VERB? SMELL> <TELL "Paper, ink and dust. It smells older than the station feels." CR>)
		(<VERB? EXAMINE READ>
		<TELL "Departure mass: four adults. Your name, Mara Vale, Ivo Chen, Senn Orlov. Four ration allocations. Four return restraints. No mass allowance exists for the fifth biography now shared by the crew. The ledger is indented through to the backing, written before first reception." CR>)>>
<ROUTINE LOG-F ()
	<COND (<VERB? RUB> <TELL "One line has been crossed out so hard that the pen has torn the page." CR>)
		(<VERB? EXAMINE READ>
		<TELL "Mara recorded four independent pulses before reception. Afterwards she added a fifth name, Lena Orlov, then crossed out its empty vital-sign fields. No fifth pulse is recorded. In the margin: “Requested pediatric analgesia. I remember treating an adult.” No dose was dispensed." CR>)>>
<ROUTINE PUMP-F ()
	<COND (<VERB? LISTEN> <COND (,COOLING <TELL "A deep, even pulse, liquid moving where it should." CR>) (T <TELL "A wet sucking, a gasp of air, and the same sound again. It is trying very hard." CR>)>)
		(<VERB? RUB> <COND (,COOLING <TELL "The casing is cold enough to sting. Frost comes away on your fingers." CR>) (T <TELL "The casing is warm and trembling. The square fitting wobbles very slightly under your hand." CR>)>)
		(<VERB? KICK ATTACK> <TELL "Kicking it would not seat the fitting, and you know exactly which tool would." CR>)
		(<VERB? SPIN>
           <COND (,COOLING <TELL "The seal holds. You leave the fitting seated." CR>)
                 (T <TELL "Your fingers slip on the square fitting. It needs the calibrated [[torque wrench->wrench]]." CR>)>)
          (<VERB? EXAMINE READ>
		<COND (,COOLING <TELL "The [[pump]] is sealed and delivering coolant to the cold archive. The square torque fitting holds." CR>)
			(T <TELL "The [[pump]] draws air through a loose square torque fitting. A calibrated wrench can repair the seal without replacing any parts." CR>)>)
		(<VERB? TURN>
		<COND (<NOT <EQUAL? ,PRSI ,WRENCH>> <TELL "The pump needs the calibrated torque wrench, not that tool. Only its calibrated click seats the square fitting." CR>)
			(<NOT <AND <HELD? ,WRENCH> <ACCESSIBLE? ,WRENCH>>> <TELL "Hold the [[wrench]] where you can reach it first." CR>)
			(,COOLING <TELL "The seal is already seated; more torque would do harm. You leave it alone." CR>)
			(T <SETG COOLING T> <TELL "The fitting seats at the wrench's calibrated click. The pump drinks liquid instead of air. Cold storage is available again; the junction air begins to cool." CR>)>)>>
<ROUTINE COMPARATOR-F ()
	<COND
		(<VERB? LOOK-INSIDE>
		<COND (,PROOF <TELL "White light cuts four narrow tracks across the glass. One is shallower than the others; it is still there." CR>)
		      (T <TELL "Without a strip the field is an even white. There is no mark to count yet." CR>)>)
		(<VERB? RUB> <TELL "Your fingers find a chipped corner of the rubber eyepiece. The dent you remember beside it simply isn't there." CR>)
		(<VERB? LISTEN> <TELL "Just the low burr of the light's ballast. The comparator returns traces, not voices." CR>)
		(<VERB? EXAMINE READ>
		<COND (,PROOF <TELL "The independent optical trace counts four bodies before reception and four after. The supposed decompression has no corresponding pressure drop. Compare the [[strip]] again if you need the raw sequence." CR>)
			(T <TELL "An optical [[comparator]], built to magnify physical witness foil. It has no network input. Comparing a witness strip with it measures the trace without decoding the transmission." CR>)>)
		(<VERB? COMPARE> <V-COMPARE>)>>
<ROUTINE V-COMPARE ()
	<COND (<NOT <AND <OR <AND <EQUAL? ,PRSO ,STRIP> <EQUAL? ,PRSI ,COMPARATOR>> <AND <EQUAL? ,PRSO ,COMPARATOR> <EQUAL? ,PRSI ,STRIP>>> <EQUAL? ,HERE ,LAB>>>
		<TELL "Compare the witness strip with the optical comparator in the laboratory; other surfaces cannot resolve its trace." CR>)
		(<NOT <AND <HELD? ,STRIP> <ACCESSIBLE? ,STRIP>>> <TELL "Take the physical [[strip]] first; a recollection of it is no reference." CR>)
		(,PROOF <TELL "The trace still resolves to four. Repeating the measurement does not create a fifth body." CR>)
		(T <SETG PROOF T>
		<TELL "Four breath loads before reception. Four after. No rupture, no fifth body. The supposed decompression has no matching pressure drop. A reception-time handstamp divides the continuous physical trace; there is no room in it for the accident you all remember." CR CR "The pressure trace stays level through the minute when you remember the accident. Something has taught you to remember it. You remember letting go of her hand, and the guilt does not lessen when the mechanism becomes clear." CR CR "Show the [[strip]] to Ivo. Isolate the incoming bus before entering the cold core." CR>)>>
<ROUTINE BUS-F ()
	<COND
		(<VERB? SMELL>
		<COND (,ISOLATED <TELL "There is still a scorched smell around the cut, but the sharp edge of ozone is fading." CR>)
		      (T <TELL "Ozone, like the instant before a lightning strike. The station used to smell of coffee." CR>)>)
		(<VERB? LISTEN> <COND (,ISOLATED <TELL "Silence. For the first time, the silence does not seem to be waiting for anything." CR>) (,TERMINATED <TELL "A low, muffled note, like someone humming with their mouth closed." CR>) (T <TELL "The high note is almost a voice. If you listen long enough, it seems about to say your name." CR>)>)
		(<VERB? RUB TAKE> <COND (,ISOLATED <TELL "The severed end is cold and dead in your hand. You lay it down again." CR>) (T <TELL "You keep your hand a palm's width from the live cable. The hairs on your arm rise all the same." CR>)>)
		(<VERB? EXAMINE READ>
		<COND (,ISOLATED <TELL "The [[bus]] is severed on the station side of the termination. No conductive path remains. The [[spool]] holds the isolated charge." CR>)
			(,TERMINATED <TELL "The [[spool]] is fitted to the [[bus]]. The line can now be cut with nonconductive shears." CR>)
			(T <TELL "A live [[incoming bus->bus]] with an empty termination socket. Fit a passive null spool before attempting to cut it. The tool must be nonconductive." CR>)>)
		(<VERB? FIT> <V-FIT>)
		(<VERB? PUT PUT-ON> <TELL "Fit the spool to the bus to engage the actual termination contacts; loose storage does not terminate a live line." CR>)
		(<VERB? CLOSE OPEN> <TELL "The bus is an exposed termination fitting, not a box with a lid." CR>)
		(<VERB? CUT>
		<COND (<NOT <EQUAL? ,PRSI ,SHEARS>> <TELL "Only ceramic shears prevent a conductive return path. That is the wrong tool." CR>)
			(<NOT <AND <HELD? ,SHEARS> <ACCESSIBLE? ,SHEARS>>> <TELL "Hold the [[shears]] in reach first." CR>)
			(<NOT ,TERMINATED> <TELL "The unabsorbed discharge would enter through the cut. Fit the null spool to the [[bus]] first. You do not make the cut." CR>)
			(,ISOLATED <TELL "The bus is already severed. No second cut is needed." CR>)
			(T <SETG ISOLATED T> <TELL "The ceramic edges meet. A blue fleck runs into the [[spool]] and dies. The singing stops in your teeth, then in the receiver vault. For the first time, the next thought does not feel anticipated." CR>)>)>>
<ROUTINE V-FIT ()
	<COND (<NOT <AND <OR <AND <EQUAL? ,PRSO ,SPOOL> <EQUAL? ,PRSI ,BUS>> <AND <EQUAL? ,PRSO ,BUS> <EQUAL? ,PRSI ,SPOOL>>> <EQUAL? ,HERE ,RELAY>>>
		<TELL "Only the null spool fits the incoming bus termination socket. That combination cannot terminate the line." CR>)
		(,TERMINATED <TELL "The [[spool]] is already fitted. The termination remains sound." CR>)
		(<NOT <AND <HELD? ,SPOOL> <ACCESSIBLE? ,SPOOL>>> <TELL "Take the [[spool]] and hold it in reach first." CR>)
		(T <MOVE ,SPOOL ,BUS> <FSET ,SPOOL ,NDESCBIT> <SETG TERMINATED T>
		<TELL "The [[spool]] locks onto the [[bus]]. The line falls to a lower note. Stored energy now has somewhere to go when you cut the bus with ceramic shears." CR>)>>
<ROUTINE RECEIVER-F ()
	<COND
		(<AND <VERB? PUT PUT-ON> <EQUAL? ,PRSI ,RECEIVER>>
		<TELL "The receiver is no place to stow equipment. Its spring clips are only for the wafer, and the wafer should go into the cold archive." CR>)
		(<AND <VERB? CLOSE> <NOT ,ISOLATED>> <TELL "The housing is already shut. The live latch will not give until you isolate the bus." CR>)
		(<VERB? LOOK-BEHIND> <TELL "The steel back sits almost flush to the bulkhead. A braid runs into the conduit toward the relay." CR>)
		(<VERB? ATTACK KICK> <TELL "A blow would crack the housing before it reached the connection. The isolation point is in the relay." CR>)
		(<VERB? LISTEN> <COND (,ISOLATED <TELL "Nothing. You listen for a long time to make sure." CR>) (T <TELL "A low beat, slower than a heart. Between beats your mouth starts to make a sound you did not choose." CR>)>)
		(<VERB? RUB KNOCK> <COND (,ISOLATED <TELL "The housing is cool and inert, just a steel box." CR>) (T <TELL "The housing is warm, and it buzzes faintly against your knuckles, like something purring." CR>)>)
		(<VERB? EXAMINE READ>
		<COND (<NOT ,ISOLATED> <TELL "The [[receiver]] remains live. Its mechanical release is interlocked to the incoming bus. Isolate that bus before opening the housing." CR>)
				(<NOT <FSET? ,RECEIVER ,OPENBIT>> <TELL "The [[receiver]] is electrically dead. Its mechanical release can now open the housing." CR>)
				(<IN? ,WAFER ,RECEIVER> <TELL "The [[receiver]] is electrically dead and its housing stands open. A single [[memory wafer->wafer]] rests inside." CR>)
			(T <TELL "The [[receiver]] is electrically dead. Its housing stands open and empty, two [[spring clips]] facing each other across a wafer-sized gap." CR>)>)
		(<VERB? OPEN SEARCH LOOK-INSIDE>
		<COND (<NOT ,ISOLATED> <TELL "The live housing cannot be opened. Terminate and sever the incoming bus first." CR>)
			(T <FSET ,RECEIVER ,OPENBIT>
				<COND (<IN? ,WAFER ,RECEIVER> <TELL "The housing opens on a single [[memory wafer->wafer]], still warm. A cooling crescent remains where it rested against the housing." CR> <THIS-IS-IT ,WAFER>)
					(T <TELL "The [[receiver]] is open and empty." CR>)>)>)>>
<ROUTINE WAFER-ORIGIN ()
	<SETG ORIGIN T>
	<TELL "A [[memory wafer->wafer]] on a passive substrate. Its [[engraved index]] reads LENA / RESCUE-COMPRESSION / SENN ORLOV. An outer-relay [[return stamp]] crosses Asterion's own outbound serial. There is no independent power source." CR CR
		"You remember Lena reciting that serial while she worked. You do not remember teaching it to her. Senn can account for the name; cold storage will hold the sample without playback." CR>>

<ROUTINE WAFER-F ()
	<COND
		(<VERB? SHAKE> <TELL "Not a rattle. The wafer is one piece, and the names on it do not move." CR>)
		(<VERB? ATTACK KICK> <TELL "You would break the one thing the others can inspect. The cold core offers a way to decide without guessing." CR>)
		(<VERB? EXAMINE> <WAFER-ORIGIN>)
		(<VERB? RUB> <TELL "The engraved index is rough under your thumb; the rest is smooth as glass, and cooler than your skin." CR>)
		(<VERB? SMELL> <TELL "Faintly of ozone, from the receiver it lay in." CR>)
		(<VERB? LISTEN> <TELL "The unpowered wafer makes no sound. You remember drawing breath with Lena, waiting through the same pause before each answer. The pause ends only when you breathe." CR>)
		(<VERB? PUT>
			<COND (<EQUAL? ,PRSI ,COLD-ARCHIVE> <ARCHIVE-F>)
				(T <TELL "The sample belongs in the cold archive, whose independent cooling and lack of a decoder keep it safe." CR>)>)>>
<ROUTINE ARCHIVE-F ()
	<COND (<VERB? EXAMINE READ>
		<COND (<IN? ,WAFER ,COLD-ARCHIVE>
				<TELL "The [[wafer]] is physically contained in the [[cold archive->archive]]. ">
				<COND (,COOLING <TELL "Independent cooling holds it without a decoder. You can still retrieve it; no final commitment has been made." CR>)
					(T <TELL "Cooling is unavailable. Restore the coolant pump before committing to storage." CR>)>)
			(,COOLING <TELL "The [[cold archive->archive]] is cooled and empty, with no decoder. Put the recovered [[memory wafer->wafer]] in it. The console can preserve it in a blind capsule or erase its physical domains; neither action has yet been committed." CR>)
			(T <TELL "The [[cold archive->archive]] is too warm for stable storage. Restore the coolant pump before placing a memory wafer here." CR>)>)
		(<AND <VERB? PUT> <EQUAL? ,PRSI ,COLD-ARCHIVE>>
		<COND (<NOT <EQUAL? ,PRSO ,WAFER>> <TELL "This chamber is for the memory wafer, not unrelated equipment." CR>)
			(<NOT ,COOLING> <TELL "The archive is too warm. Repair the coolant pump first; you keep the sample safe in your hand." CR>)
			(T <MOVE ,WAFER ,COLD-ARCHIVE> <FSET ,WAFER ,NDESCBIT> <TELL "You slide the [[wafer]] into the [[cold archive->archive]]. Frost draws a white border around it. The sample is contained without being read. You can still retrieve it; no final decision has been made." CR>)>)
		(<VERB? CLOSE> <TELL "The archive's access sleeve stays open until a final commitment. Its blind interior contains no decoder." CR>)
		(<VERB? RUB> <COND (,COOLING <TELL "The sleeve is so cold that your skin sticks to it for an instant." CR>) (T <TELL "The sleeve is barely cooler than the room. It is not ready to keep anything." CR>)>)
		(<VERB? LISTEN> <TELL "A faint tick of contracting metal. There is nothing inside it that could play a sound." CR>)>>

<ROUTINE MARA-F ()
	<COND (<VERB? RUB> <TELL "You touch Mara's arm. She checks the marks in her palm, then lets your hand stay there for a moment." CR>)
		(<VERB? LISTEN> <TELL "Mara is counting under her breath. Four. She starts again, and stops at four again." CR>)
		(<VERB? EXAMINE> <TELL "[[Mara]] has pressed thumbnail marks into her palm. She checks the marks before she answers you: a physical record of how often the same thought returned. Ask her about the [[signal]], the [[crew]], or Senn's [[daughter]]." CR>)
		(<VERB? SHOW> <V-SHOW>)
		(<AND <VERB? GIVE> <EQUAL? ,PRSI ,MARA>> <V-SHOW>)
		(<VERB? TELL>
		<COND (<EQUAL? ,PRSI ,WAFER> <MARA-SAMPLE>)
			(<EQUAL? ,PRSI ,TOPIC-SIGNAL>
				<COND (,ISOLATED <TELL "Mara says, “Ordinary neurons now. Severing the carrier stops new instructions, not the memories already laid down. Don't promise anyone an instant cure.”" CR>)
					(T <TELL "“It uses the brain's error correction,” Mara says. “You supply most of the experience yourself. A vivid memory is not a high-resolution recording.”" CR>)>)
			(<EQUAL? ,PRSI ,TOPIC-DAUGHTER>
				<COND (,PROOF <TELL "“Senn lost Lena before we launched,” Mara says. “I knew that when I wrote her name in my clinical log. I had to read my own handwriting three times.”" CR>)
					(T <TELL "“Ask Senn when he can bear it. I can tell you she never received a physical examination aboard this station.”" CR>)>)
			(<EQUAL? ,PRSI ,TOPIC-CREW>
				<COND (,EVAC <TELL "“Four living passengers,” Mara says. “I will count them by pulse until we reach the rescue ship.”" CR>)
					(,CONSENT <TELL "“Ivo agreed after reading the foil,” Mara says. “I heard him. Keep that consent with the reference; none of us should have to give it twice.”" CR>)
					(,PROOF <TELL "“Four bodies,” Mara says. “Show Ivo the foil. He deserves to decide with evidence.”" CR>)
					(T <TELL "“Read my clinical log,” Mara says. “Then take the witness foil to the comparator. Do not let my certainty replace a measurement.”" CR>)>)
			(T <TELL "Mara glances at the equipment. “The protocol covers the engineering. Ask me about the [[signal]], the [[crew]], or Senn's [[daughter]].”" CR>)>)>>

<ROUTINE IVO-F ()
	<COND (<VERB? RUB> <TELL "You touch Ivo's shoulder. “Careful,” he says. “Physical contact without a work order.” He does not move away." CR>)
		(<VERB? LISTEN> <TELL "Ivo is counting the crew in a whisper: your name, Mara, Senn, himself. Then a pause, as if a fifth name should come next." CR>)
		(<VERB? EXAMINE>
		<COND (,CONSENT <TELL "[[Ivo]] is counting again. Four, and this time he stops. Ask about the [[signal]], the [[crew]], or the [[daughter]]." CR>)
			(T <TELL "[[Ivo]] keeps rubbing an uninjured knuckle. He remembers Lena splinting it. Ask about the [[signal]], the [[crew]], or the [[daughter]]." CR>)>)
		(<VERB? SHOW> <V-SHOW>)
		(<AND <VERB? GIVE> <EQUAL? ,PRSI ,IVO>> <V-SHOW>)
		(<VERB? TELL>
		<COND (<EQUAL? ,PRSI ,WAFER> <IVO-SAMPLE>)
			(<EQUAL? ,PRSI ,TOPIC-SIGNAL>
			<COND (,ISOLATED <TELL "“I wanted the silence,” Ivo says. “Now I keep checking it isn't waiting for me to ask it back.”" CR>)
				(T <TELL "“Regulations prohibit emotional support from equipment still under warranty,” Ivo says. He waits for you to laugh, then says, “I decoded the first rescue header. That's how it got a listener.”" CR>)>)
			(<EQUAL? ,PRSI ,TOPIC-DAUGHTER>
				<COND (,PROOF <TELL "“I remember teaching Lena to solder,” Ivo says. “Senn says she died twelve years before he hired me. I can give up the claim. I can't yet give up the afternoon.”" CR>)
					(T <TELL "“Lena. I remember her as an adult. The portrait is of a child. Senn never brought photographs of her grown up.”" CR>)>)
			(T <COND (,CONSENT <TELL "“I agreed to leave because of the trace, not because the grief stopped,” Ivo says. “Prepare the cold archive and the mechanical beacon. Then make your decision openly.”" CR>)
				(,PROOF <TELL "“You compared the foil?” Ivo asks. “Show me the actual strip. I won't abandon someone on a verbal report, not even yours.”" CR>)
				(T <TELL "“I remember five,” Ivo says. “The ledger says four. Show me a reference made before the reception, measured without decoding the signal.”" CR>)>)>)>>
<ROUTINE SENN-F ()
	<COND (<VERB? RUB> <TELL "You lay a hand on Senn's shoulder. He flinches, then breathes out, as though he had forgotten anyone here was real." CR>)
		(<VERB? LISTEN> <COND (,SENN-DISCLOSED <TELL "Senn breathes slowly and says nothing. He is letting the quiet be quiet." CR>) (T <TELL "Under his breath, Senn is saying a word in time with your own speech, a fraction early." CR>)>)
		(<VERB? EXAMINE>
		<COND (,SENN-DISCLOSED <TELL "[[Senn]] keeps his hands closed on his knees. He follows your gaze instead of supplying your next word. ">)
			(T <TELL "[[Senn]] holds his palms apart, the spacing of hands around a face. There is nothing physically between them. ">)>
		<TELL "Ask about the [[signal]], the [[crew]], or his [[daughter]]." CR>
			<COND (<AND ,ISOLATED <NOT ,SENN-DISCLOSED>> <TELL "“My daughter,” he repeats. “You should ask me again now.”" CR>)>
			<RTRUE>)
		(<VERB? SHOW> <V-SHOW>)
		(<AND <VERB? GIVE> <EQUAL? ,PRSI ,SENN>> <V-SHOW>)
		(<VERB? TELL>
		<COND (<EQUAL? ,PRSI ,WAFER> <SENN-CONFESSION>)
			(<EQUAL? ,PRSI ,TOPIC-DAUGHTER>
				<COND (,ISOLATED <SENN-CONFESSION>)
					(T <TELL "“She would have been thirty-one,” Senn says. After a while: “That is a different sentence from saying she is.”" CR>)>)
			(<EQUAL? ,PRSI ,TOPIC-SIGNAL>
				<COND (,ISOLATED <TELL "“The relay returned our own rescue-compression experiment,” Senn says. “Its success criterion was continued decoding. A dying person makes you keep listening. We optimized for that without asking what it would feel like from this end.” He looks toward the cold core. “An inquiry will want to play the only specimen. Preservation means staying there when they ask, and saying no. Even to people who believe they are helping.”" CR>)
					(T <TELL "“We sent a low-bandwidth rescue model through the outer relay,” Senn says. “It was meant to rebuild damaged messages from a listener's existing knowledge. The return was more complete than the transmission.”" CR>)>)
			(<EQUAL? ,PRSI ,TOPIC-CREW>
				<COND (,PROOF <TELL "“Four bodies,” Senn says. “I won't dispute the trace. I will leave with you, whichever decision you record.”" CR>)
					(T <TELL "“I remember her in this room,” Senn says. “There is no fifth thermal load.” His open hands do not move." CR>)>)
			(T <TELL "Senn looks past the equipment. “Ask me about the [[signal]], or about [[Lena->daughter]]. I know which one is harder.”" CR>)>)>>

<ROUTINE TOPIC-F ()
	<COND (<AND <VERB? EXAMINE> <EQUAL? ,PRSO ,TOPIC-DAUGHTER> <IN? ,SENN ,HERE>>
		<COND (,SENN-DISCLOSED <TELL "Senn can show you how small her hands were. He has nothing on the station that bears her handwriting." CR>)
		      (T <TELL "Senn cups his hands as though a small face rested between them. He waits for you to ask about her." CR>)>)
	      (<VERB? EXAMINE>
             <COND (<EQUAL? ,PRSO ,TOPIC-CREW> <COND (,PROOF <TELL "The strip counted four bodies, just as the departure list counted four names. The fifth place is the one you keep making room for in your head." CR>)
                         (T <TELL "You can name Mara, Ivo and Senn without hesitating. Then you count yourself and find you are still waiting for one more name." CR>)>)
                   (<EQUAL? ,PRSO ,TOPIC-SIGNAL> <COND (,ISOLATED <TELL "Reception has stopped. You can still finish the words in your head." CR>)
                         (T <TELL "Listen to the rhythm in your head. You know exactly when the next beat is coming, as though you had heard it yesterday." CR>)>)
                   (T <TELL "Everyone who remembers the girl puts her beside someone else. No two memories give her a place of her own." CR>)>)>>
<ROUTINE V-SHOW ()
	<COND (<NOT <AND <HELD? ,PRSO> <ACCESSIBLE? ,PRSO>>>
		<TELL "Hold the actual item where the other person can inspect it." CR>)
		(<AND <EQUAL? ,PRSO ,STRIP> <EQUAL? ,PRSI ,IVO>>
			<COND (<NOT ,PROOF> <TELL "Ivo holds the foil to the light. “Neither of us can resolve this by eye. Compare it in the laboratory first.”" CR>)
				(,CONSENT <TELL "Ivo nods. “I've seen it. My consent stands. Get us out safely.”" CR>)
				(T <SETG CONSENT T> <TELL "Ivo follows the comparison marks with his finger. Four, four, four. “I consent to evacuation,” he says. “I don't consent to pretending we won't miss her.” He sets the [[strip]] back in your hand. “Cold storage, mechanical beacon. No radio.”" CR>)>)
		(<AND <EQUAL? ,PRSO ,STRIP> <EQUAL? ,PRSI ,MARA>>
			<COND (,PROOF <TELL "Mara aligns the comparison marks with her clinical count. “Four. I kept taking pulses because I thought I was missing someone.” She gives the foil back. “Keep this where we can all check it.”" CR>)
				(T <TELL "Mara cannot resolve the fine trace by eye. “Use the comparator. Then we can compare it with my pulse count.”" CR>)>)
		(<AND <EQUAL? ,PRSO ,STRIP> <EQUAL? ,PRSI ,SENN>>
			<COND (,SENN-DISCLOSED <TELL "Senn checks the foil again. “Keep all four traces. I won't put her name over one of yours.” He gives it back." CR>)
				(<AND ,PROOF ,ISOLATED> <TELL "Senn follows the four resolved traces. “Mine is there. Hers isn't. Ask me about my [[daughter]] now.”" CR>)
				(,PROOF <TELL "Senn follows the four resolved traces. “Mine is there. Hers isn't.” He returns the foil. “When the carrier is quiet, ask me about my [[daughter]] again.”" CR>)
				(T <TELL "Senn turns the foil without reading it. “The comparator will resolve this. I shouldn't be the one to tell you what it says.”" CR>)>)
		(<AND <EQUAL? ,PRSO ,WAFER> <EQUAL? ,PRSI ,MARA>> <MARA-SAMPLE>)
		(<AND <EQUAL? ,PRSO ,WAFER> <EQUAL? ,PRSI ,SENN>>
			<COND (<NOT ,ORIGIN>
				<TELL "Senn turns the wafer to the light without touching its contacts. Together you read its markings." CR>
				<WAFER-ORIGIN>)>
			<SENN-CONFESSION>)
		(<AND <EQUAL? ,PRSO ,WAFER> <EQUAL? ,PRSI ,IVO>> <IVO-SAMPLE>)
		(<EQUAL? ,PRSI ,MARA> <TELL "Mara checks the item and hands it back. “You know the tools. I know what happened to our pulse counts.”" CR>)
		(<EQUAL? ,PRSI ,SENN> <TELL "Senn does not take it. “Keep the engineering equipment. I'll answer for the experiment.”" CR>)
		(<EQUAL? ,PRSI ,IVO> <TELL "Ivo checks it out of habit. “Still the right tool. At least that hasn't changed.”" CR>)
		(T <TELL "Show the physical evidence to a colleague who can examine it." CR>)>>

<ROUTINE BEACON-F ()
	<COND
		(<VERB? SPIN> <TELL "You trace the hinge with one finger. The reflector folds, but the beacon itself is fired by a straight push." CR>)
		(<VERB? LOOK-BEHIND> <TELL "Not a wire anywhere. A spring, a catch, and a clear arc out past the dome." CR>)
		(<VERB? EXAMINE READ>
		<COND (,EVAC <TELL "The [[beacon]] is armed for a ballistic rendezvous. It broadcasts no information; rescue will find its physical reflector. Return to the cold-core console for the final decision." CR>)
			(T <TELL "A mechanical [[beacon]], not a transmitter: it launches a passive reflector. Push it after independent comparison, Ivo's informed consent, physical receive isolation, and cooled wafer containment. It prepares departure; it does not make the final choice." CR>)>)
		(<VERB? RUB> <TELL "Bare metal, cold from the dome glass, with a spring housing as thick as your wrist. There is no circuit board anywhere in it." CR>)
		(<VERB? LISTEN> <COND (,EVAC <TELL "The armed spring creaks faintly under its load." CR>) (T <TELL "Nothing. A machine with nothing to say is exactly what you want up here." CR>)>)
		(<VERB? PUSH>
		<COND (<NOT ,PROOF> <TELL "Departure is not prepared: first compare the physical witness foil in the laboratory." CR>)
			(<NOT ,CONSENT> <TELL "Departure is not prepared: Ivo has not yet agreed to leave. Show him the measured witness foil." CR>)
			(<NOT ,ISOLATED> <TELL "Departure is not prepared: terminate and sever the incoming bus before leaving a live receive chain behind." CR>)
			(<NOT ,COOLING> <TELL "Departure is not prepared: restore coolant so the sample can remain cold." CR>)
			(<NOT <IN? ,WAFER ,COLD-ARCHIVE>> <TELL "Departure is not prepared: put the actual memory wafer in the cold archive." CR>)
			(,EVAC <TELL "The [[beacon]] remains armed. Return to the cold-core console when you are ready." CR>)
			(T <SETG EVAC T> <MOVE ,MARA ,LAUNCH>
			<TELL "The [[beacon]] arms with a heavy clunk. [[Mara]] comes up from the clinic, carrying the evacuation count in her head and checking it against four physical restraints. “Ivo and Senn are coming,” she says. “You have time. Go back to the cold-core console. Decide with all of us knowing what you did.”" CR>)>)>>
<ROUTINE CONSOLE-F ()
	<COND
		(<VERB? SPIN> <TELL "The keys do not turn. You leave them both untouched; only a deliberate choice will commit the sample." CR>)
		(<VERB? EXAMINE READ>
		<TELL "Two final commitments. PRESERVE seals the sample in a blind, unpowered capsule and evacuates the living crew with a prohibition on playback. ERASE degausses the sample, removes the station's powered decoding chain, and evacuates the living crew without it. Preservation commits you to guarded custody: rescuers and investigators will want to play their only specimen, and you will have to keep refusing. Erasure destroys that specimen and the possibility of studying what it became. Both leave a physical warning. Neither erases your implanted memories." CR CR "Before either commitment: independent comparison, examination of the wafer's origin index, Ivo's consent, receive isolation, cooling, the wafer physically in the archive, and the rendezvous beacon armed. Preparation can still be changed. The next successful PRESERVE or ERASE ends the story." CR>)
		(<VERB? PRESERVE> <V-PRESERVE> <RTRUE>)
		(<VERB? ERASE> <V-ERASE> <RTRUE>)
		(<VERB? RUB> <TELL "The two keys are cold and ridged, PRESERVE on the left, ERASE on the right, far enough apart that no one could press both by accident." CR>)
		(<VERB? LISTEN> <TELL "A faint electrical whine, steady and patient. It will wait as long as you need." CR>)
		(<VERB? PUSH TURN> <TELL "These commitments are deliberately distinct. Choose PRESERVE or ERASE after reading the [[console]]." CR>)>>
<ROUTINE READY-TO-END ()
	<COND (<NOT <AND <EQUAL? ,HERE ,CORE> <EQUAL? ,PRSO ,CONSOLE>>>
		<TELL "Only the decision console in the cold core can commit that operation." CR> <RFALSE>)
		(<NOT ,PROOF> <TELL "No commitment is made. Compare the foil in the laboratory first." CR> <RFALSE>)
		(<NOT ,ORIGIN> <TELL "No commitment is made. First examine the recovered wafer's engraved index." CR> <RFALSE>)
		(<NOT ,CONSENT> <TELL "No commitment is made. Show the measured foil to Ivo and obtain his consent to evacuation." CR> <RFALSE>)
		(<NOT ,ISOLATED> <TELL "No commitment is made. Terminate and sever the incoming bus." CR> <RFALSE>)
		(<NOT ,COOLING> <TELL "No commitment is made. Restore the coolant pump by turning its square fitting with the wrench." CR> <RFALSE>)
		(<NOT <IN? ,WAFER ,COLD-ARCHIVE>> <TELL "No commitment is made. Put the actual wafer in the cold archive." CR> <RFALSE>)
		(<NOT ,EVAC> <TELL "No commitment is made. Arm the rendezvous beacon in the launch cupola." CR> <RFALSE>)
		(T <RTRUE>)>>

<ROUTINE V-PRESERVE ()
	<COND (<READY-TO-END>
		<SETG RESOLVED T> <FCLEAR ,COLD-ARCHIVE ,OPENBIT>
		<MOVE ,IVO ,LAUNCH> <MOVE ,SENN ,LAUNCH>
		<TELL "You commit to preservation." CR CR "The archive closes without reading the wafer. Four measured bodies; one manufactured biography. You record both facts, and the fact that neither settled the question of suffering. The sealed capsule carries its warning as physical grooves, not an enticing voice." CR CR "At the rendezvous, Mara counts four pulses. Ivo asks whether anyone remembers what Lena liked to eat. All four of you answer differently. Senn begins to apologize. You ask him to help inventory the capsule instead." CR CR "The rescue ship will not accept the capsule until its medical officer has assessed it. She proposes a test playback. You refuse. For two days you trade sleep for custody while people with clean voices argue that understanding is worth a controlled exposure. Senn gives his first statement beside the unaltered foil. Ivo takes the next watch." CR CR "Eventually they accept sealed transfer under your warning. Someone else will hold the keys tomorrow. You have saved the possibility of an answer, and taken responsibility for keeping it unanswered until an answer can be sought safely." CR CR "ENDING: THE UNPLAYED WITNESS" CR>
		<FINISH>)>>
<ROUTINE V-ERASE ()
	<COND (<READY-TO-END>
		<SETG RESOLVED T> <REMOVE ,WAFER>
		<MOVE ,IVO ,LAUNCH> <MOVE ,SENN ,LAUNCH>
		<TELL "You commit to erasure." CR CR "The domains collapse in a calibrated field. Nothing screams; the archive has no decoder. You wait through the whole cycle anyway. The optical foil still counts four. The mass ledger still has four names. None of the evidence becomes a pardon." CR CR "There is no remaining specimen with which another team can reconstruct what it became. The warning you leave names the returned rescue experiment, the fabricated decompression, and Senn's daughter's training record. It contains no playable example. At rendezvous Mara counts four pulses. Ivo asks you to sit beside him because he remembers asking Lena." CR CR "Senn will face the inquiry alive. You will all give statements, including where the statements disagree. That night you dream of holding a hand, wake with both hands empty, and let Mara take one. It is not the hand you remember. It is warm." CR CR "ENDING: FOUR PULSES" CR>
		<FINISH>)>>
<ROUTINE DIRECT-HINT ()
	<COND (<NOT ,POWER> <TELL "The habitat breaker is tripped. Examine it, then push it." CR>)
		(<NOT ,COOLING> <TELL "The torque shop has a calibrated wrench. TURN PUMP WITH WRENCH seats the square fitting; the service spine is below the junction." CR>)
		(<NOT ,PROOF> <TELL "Open the physical archive's recorder, take its witness strip, and compare the strip with the laboratory comparator." CR>)
		(<NOT ,CONSENT> <TELL "Show the measured witness strip to Ivo in the galley." CR>)
		(<NOT ,TERMINATED> <TELL "Take the null spool from the torque shop. Fit it to the incoming bus in the relay." CR>)
		(<NOT ,ISOLATED> <TELL "The clinic has ceramic shears. Cut the terminated incoming bus with those shears." CR>)
		(<IN? ,WAFER ,RECEIVER> <TELL "Open the isolated receiver and take the wafer." CR>)
		(<NOT ,ORIGIN> <TELL "Examine the memory wafer. Its engraved safety index can be read without playing it." CR>)
		(<NOT <IN? ,WAFER ,COLD-ARCHIVE>> <TELL "Take the wafer to the cold core, north of quarantine. Put it in the cold archive." CR>)
		(<NOT ,EVAC> <TELL "Push the rendezvous beacon in the cupola above the junction. Then return to the cold core." CR>)
		(T <TELL "Examine the cold-core console. Preserve console or erase console is the explicit final commitment." CR>)>>
<ROUTINE GALLEY-F (RARG)
	<COND (<EQUAL? .RARG ,M-LOOK>
		<TELL "You are in the Galley, where the crew eat at a single bolted table. It smells of reheated rice and coffee gone cold. Above the table, a [[portrait]] held in clear droplets of water turns slowly in its field.">
		<COND (,CONSENT <TELL " [[Ivo]], the communications officer, sits beneath it, tapping once for each name he will take to the cupola.">)
			(T <TELL " [[Ivo]], the communications officer, sits beneath it, counting to four under his breath and starting again.">)>
		<TELL " The junction is back to the [[west]], and the physical archive lies to the [[east]]." CR> <RTRUE>)>>
<ROUTINE V-SCORE ("OPTIONAL" (ASK? T))
	<COND (,RESOLVED <TELL "The crew has left the station. Your decision is part of the physical record." CR>)
		(,EVAC <TELL "Departure prepared. The cold-core decision remains yours." CR>)
		(,ISOLATED <TELL "Reception isolated. Secure the sample and prepare evacuation." CR>)
		(,PROOF <TELL "Independent evidence established. Isolate reception and obtain consent." CR>)
		(,POWER <TELL "Habitat restored. Establish an independent physical reference." CR>)
		(T <TELL "Restore habitat power." CR>)>>
<ROUTINE CRADLE-F (RARG)
	<COND (<EQUAL? .RARG ,M-LOOK>
		<TELL "You are in your restraint cradle, a padded sleeping [[niche->frame]] at the south end of the habitat.">
		<COND (,POWER <TELL " The [[padding]] still holds the warmth of your back, and the [[breaker]] sits quiet in its housing. Moving air brushes your face from the pressure-balanced door to the [[north]], which now stands open onto the habitat junction.">)
			(T <TELL " A dry [[click]] repeats somewhere inside the [[padding]], steady as a pulse. The habitat [[breaker]] is set into the frame, within arm's reach. The pressure-balanced door to the [[north]], which leads to the habitat junction, is sealed.">)>
		<CRLF> <RTRUE>)>>
<ROUTINE FRAME-F ()
	<COND
		(<VERB? LOOK-UNDER> <TELL "One of your boot prints has dried beneath the frame. The shorter one you pictured is not there." CR>)
		(<VERB? EXAMINE SEARCH>
           <COND (<FSET? ,DETAIL-BUCKLE ,OPENBIT> <TELL "The open [[buckle]] hangs loose against the [[restraint frame->frame]].">)
              (T <TELL "A [[buckle]] taps the [[restraint frame->frame]] when you shift your weight.">)>
        <TELL " The frame releases by hand. Its padding is worn in four places where you brace your limbs. There is no second person's impression. The doorway's mechanical interlock depends on the habitat [[breaker]]." CR>)
		(<VERB? LISTEN> <COND (,POWER <TELL "Nothing now but your own breathing and the habitat fans." CR>) (T <TELL "Click. Click. Click. The sound is mechanical and regular, and still you find yourself counting it like a heartbeat." CR>)>)
		(<VERB? RUB SMELL> <TELL "The padding is worn smooth and smells of your own sweat and the station's recycled air. Only one body has ever lain here." CR>)
		(<VERB? OPEN CLOSE> <COND (,POWER <TELL "The interlock is released; the way [[north]] is open." CR>)
			(T <TELL "Reset the [[breaker]] first. The pressure interlock is doing its job." CR>)>)>>
<ROUTINE RECESSES-F ()
	<COND (<VERB? RUB> <TELL "The insulation is warm and slightly spongy, pressed hard at the edges of each shape where tools have been pushed home." CR>)
		(<VERB? SMELL> <TELL "Oil, rubber and warm dust." CR>)
		(<VERB? EXAMINE SEARCH>
		<TELL "Two shapes are cut into the insulation below the [[protocol]].">
		<COND (<AND <IN? ,WRENCH ,WORKSHOP> <NOT <FSET? ,WRENCH ,TOUCHBIT>>> <TELL " A [[torque wrench->wrench]] fits the long slot.">)
			(T <TELL " The long slot is empty.">)>
		<COND (<AND <IN? ,SPOOL ,WORKSHOP> <NOT <FSET? ,SPOOL ,TOUCHBIT>>> <TELL " A [[null spool->spool]] fills the round one.">)
			(T <TELL " The round slot is empty.">)>
		<CRLF> <RTRUE>)>>
<ROUTINE EXAM-AREA-F ()
	<COND (<VERB? RUB> <TELL "The paper sheet on the bed is crisp and unwrinkled. Nobody has lain here since it was changed." CR>)
		(<VERB? CLIMB-ON> <TELL "You sit on the edge of the bed for a moment. Mara glances over, as if about to take your pulse, and does not." CR>)
		(<VERB? EXAMINE SEARCH SMELL> <TELL "The [[exam bed->bed]] has been washed with ordinary unscented soap. You remember a fifth patient here, but there is no fifth entry in the [[log]].">
		<COND (<AND <IN? ,SHEARS ,CLINIC> <NOT <FSET? ,SHEARS ,TOUCHBIT>>> <TELL " A pair of [[ceramic shears->shears]] lies ready for sterile work.">)>
		<CRLF> <RTRUE>)>>
<ROUTINE STARFIELD-F ()
	<COND (<VERB? LISTEN> <TELL "Nothing comes through the glass. Out there, there is nothing to carry a sound." CR>)
		(<VERB? RUB> <TELL "The dome glass is cold under your palm, and your breath fogs it for a moment around your hand." CR>)
		(<VERB? EXAMINE> <TELL "The [[stars]] are points without an atmosphere to soften them. The station's slow rotation changes their position predictably. It is a relief to watch something indifferent to you." CR>)>>
<ROUTINE HARDWARE-F ()
	<COND (<VERB? RUB> <TELL "Four harnesses, four buckles, all cold. You count them twice with your fingers." CR>)
		(<VERB? CLIMB-ON> <TELL "You try one of the four seats. Your shoulders fit between the restraints. You get up again." CR>)
          (<VERB? EXAMINE SEARCH> <TELL "Four physical [[evacuation restraints->restraints]], and a passive reflector served by the [[beacon]]. A rescue ship can find the reflector without decoding a message. Four places, no fifth." CR>)>>
<ROUTINE V-HINT ("AUX" (STAGE 0))
	<COND (<NOT ,POWER> <SET STAGE 0>)
		(<NOT ,COOLING> <SET STAGE 1>)
		(<NOT ,PROOF> <SET STAGE 2>)
		(<NOT ,CONSENT> <SET STAGE 3>)
		(<NOT ,TERMINATED> <SET STAGE 4>)
		(<NOT ,ISOLATED> <SET STAGE 5>)
		(<IN? ,WAFER ,RECEIVER> <SET STAGE 6>)
		(<NOT ,ORIGIN> <SET STAGE 7>)
		(<NOT <IN? ,WAFER ,COLD-ARCHIVE>> <SET STAGE 8>)
		(<NOT ,EVAC> <SET STAGE 9>)
		(T <SET STAGE 10>)>
	<COND (<NOT <EQUAL? .STAGE ,HINT-STAGE>> <SETG HINT-STAGE .STAGE> <SETG HINT-LEVEL 0>)>
	<SETG HINT-LEVEL <+ ,HINT-LEVEL 1>>
	<COND (<G? ,HINT-LEVEL 2> <DIRECT-HINT>)
		(<EQUAL? ,HINT-LEVEL 1>
			<COND (<EQUAL? .STAGE 0> <TELL "A protection trip does not necessarily mean a broken component." CR>)
				(<EQUAL? .STAGE 1> <TELL "The cooling failure has a mechanical sound, not an electrical one." CR>)
				(<EQUAL? .STAGE 2> <TELL "Find a record that does not depend on anyone's memory." CR>)
				(<EQUAL? .STAGE 3> <TELL "Ivo needs a reason he can examine, not an instruction to stop caring." CR>)
				(<EQUAL? .STAGE 4 5> <TELL "A cut changes where stored energy can go. Give it a safe destination first." CR>)
				(<EQUAL? .STAGE 6 7> <TELL "The receiver's physical contents can be inspected without being played." CR>)
				(<EQUAL? .STAGE 8> <TELL "Containment means preserving the physical sample without giving it a listener." CR>)
				(<EQUAL? .STAGE 9> <TELL "A rescue signal need not be a message." CR>)
				(T <TELL "There is no further mechanical trick. Read the commitments before choosing what you can accept responsibility for." CR>)>)
		(T <TELL "Look at the protocol card, the relevant fitting, or the decision console. Their descriptions identify the required physical operation. Ask for HINT once more for an exact next command." CR>)>>

<ROUTINE SENN-CONFESSION ()
	<COND (,SENN-DISCLOSED <TELL "Senn closes his hands. “The years between nine and thirty-one came from us. I can't tell you which details I supplied. I can tell you who allowed the model to keep running.”" CR>)
		(T <SETG SENN-DISCLOSED T>
			<TELL "“Lena died at nine,” Senn says. “I gave the reconstruction my memories as training material. Not to resurrect her. To test whether a rescue call could rebuild missing information from a listener. Then I heard her grown voice. The experiment supplied the years I never got.” He closes his hands. “I did not stop it.”" CR>)>>
<ROUTINE MARA-SAMPLE ()
	<TELL "Mara keeps her hands away from the wafer. “Storage without playback is safe for us. Custody is a longer promise. At rescue they will want to hear the evidence, and they'll have more authority than we do.” ">
	<COND (,CONSENT <TELL "She nods toward the galley. “Ivo has agreed to leave. Don't confuse that with agreeing to hear it again.”" CR>)
		(T <TELL "“Show Ivo the measured foil before you ask him to leave.”" CR>)>>
<ROUTINE IVO-SAMPLE ()
	<TELL "Ivo studies the unpowered wafer. “An inquiry will ask why we won't let them listen. Our answer will be four people saying they remember five.” ">
	<COND (,CONSENT <TELL "He rubs his knuckle. “I'll stand watch if we preserve it. I want my refusal on the record before somebody asks twice.”" CR>)
		(T <TELL "“Bring me the measured foil. I need something better than that before I agree to leave.”" CR>)>>

<ROUTINE CORE-INTERLOCK-F ()
    <COND (<VERB? KNOCK> <TELL "The door is thick enough to swallow the sound. Your knuckles hurt more than the door does." CR>)
          (<VERB? RUB> <TELL "The steel is cold on this side, colder than the room. Whatever lies beyond is kept very cold indeed." CR>)
          (<VERB? LISTEN> <TELL "Faintly, through the steel, the hum of refrigeration." CR>)
          (<VERB? OPEN>
           <COND (<AND ,PROOF ,ISOLATED> <TELL "The bolt is back. The way into the core is open." CR>)
                 (T <TELL "The bolt holds. You check the flags. "> <PERFORM ,V?READ ,DETAIL-INSPECTION-FLAGS>)>)
          (<VERB? EXAMINE>
           <COND (<AND ,PROOF ,ISOLATED> <TELL "Both inspection [[flags]] show white: trace verified and receiver isolated. The bolt has drawn back into its sleeve." CR>)
                 (T <TELL "The bolt crosses two inspection [[flags]]. One needs a verified physical trace, the other a disconnected receiver." CR>)>)>>

<ROUTINE FLAGS-DETAIL-F ()
    <COND (<VERB? EXAMINE READ>
           <COND (,PROOF <TELL "The TRACE tab shows white. ">) (T <TELL "A black bar still covers TRACE. ">)>
           <COND (,ISOLATED <TELL "The receiver tab shows white." CR>) (T <TELL "A red line on the receiver tab means the circuit is still live." CR>)>)>>

<ROUTINE GAUGE-DETAIL-F ()
    <COND (<VERB? EXAMINE READ>
           <COND (,POWER <TELL "The needle sits on the single black line for one atmosphere. You can still feel a faint pulse through the glass." CR>) (T <TELL "A needle quivers behind a little round window. Even with the breaker out, the needle stays inside the painted reserve band." CR>)>)>>

<ROUTINE WAFER-CLIPS-F ()
    <COND (<VERB? EXAMINE>
           <COND (<IN? ,WAFER ,RECEIVER> <TELL "The tips bear against the two blank edges of the wafer. They hold it level without touching its face." CR>) (T <TELL "Each tip has a bright contact spot the size of a pinhead. The rest of the jaw is dull." CR>)>)>>

<ROUTINE INDEX-DETAIL-F ()
    <COND (<VERB? EXAMINE READ>
           <SETG ORIGIN T>
           <TELL "Under LENA and SENN ORLOV the cuts are equally sharp. Between them, RESCUE-COMPRESSION is cut in the same small hand." CR>)>>

<ROUTINE RETURN-STAMP-F ()
    <COND (<VERB? READ> <TELL "The return stamp crosses the raised serial. The outer relay stamped the wafer after the serial was struck." CR>)>>

<ROUTINE DETAIL-BUCKLE-F ()
    <COND
		(<VERB? RUB> <TELL "Your thumb finds the dimple without looking. The memory of a smaller hand knowing the same trick has nowhere physical to land." CR>)
		(<VERB? OPEN PUSH UNTIE>
           <COND (<FSET? ,PRSO ,OPENBIT> <TELL "The buckle is already open. The two ends hang loose." CR>)
                 (T <FSET ,PRSO ,OPENBIT>
                  <TELL "You press the lip with your thumb. The tongue slips free and the strap falls loose." CR>)>)
          (<VERB? CLOSE>
           <COND (<FSET? ,PRSO ,OPENBIT> <FCLEAR ,PRSO ,OPENBIT>
                  <TELL "You slide the tongue back into the buckle. It catches with a click." CR>)
                 (T <TELL "The tongue is already fastened." CR>)>)
          (<VERB? EXAMINE>
           <COND (<FSET? ,PRSO ,OPENBIT> <TELL "The tongue hangs free of its slot. You can slide it back in." CR>)
                 (T <TELL "The lip is polished on the side nearest your thumb. You can find the release with your eyes shut." CR>)>)>>

<ROUTINE GRILLE-F ()
    <COND (<VERB? RUB> <TELL "You press the grille flat. The rattle stops under your hand and starts again the moment you let go." CR>)
          (<VERB? LISTEN> <TELL "A loose rattle, and behind it the long breath of air moving up toward the habitat." CR>)>>

<ROUTINE DROPLETS-F ()
    <COND (<VERB? RUB> <PERFORM ,V?RUB ,PORTRAIT> <RTRUE>)>>

<ROUTINE JUNCTION-F ()
    <COND (<VERB? LISTEN> <TELL "The fans, the faint tick of the rail, and somewhere in the station the footsteps of the others. You catch yourself waiting for one more set." CR>)
          (<VERB? RUB> <TELL "The padded wall between the hatches is cool and slightly tacky, scuffed where people push off in a hurry." CR>)>>

<ROUTINE LADDER-F ()
    <COND (<VERB? CLIMB-ON CLIMB-UP CLIMB-FOO>
           <COND (<EQUAL? ,HERE ,HUB> <TELL "The ladder runs [[up]] to the cupola and [[down]] to the spine." CR>)
                 (<EQUAL? ,HERE ,LAUNCH> <TELL "The ladder goes back [[down]] to the junction." CR>)
                 (T <TELL "The ladder climbs [[up]] to the junction." CR>)>)
          (<VERB? RUB> <TELL "The rungs are knurled steel, cold, and worn bright in the middle by boots." CR>)>>

<ROUTINE GALLEY-TABLE-F ()
    <COND (<VERB? SMELL> <TELL "Reheated rice, cold coffee and the plastic smell of meal trays." CR>)
          (<VERB? RUB> <TELL "There is a ring of dried coffee in front of each of the four places. You count them twice." CR>)
          (<VERB? EAT DRINK> <TELL "The coffee is stone cold and the rice has dried at the edges. You are not that hungry yet." CR>)>>

<ROUTINE SHELVES-F ()
    <COND (<VERB? SEARCH LOOK-INSIDE> <TELL "Maintenance logs, ration counts, dull years of paperwork. Nothing here mentions anyone you have not already named." CR>)
          (<VERB? SMELL> <TELL "Dry paper and machine oil. It smells reassuringly boring." CR>)>>

<ROUTINE BENCHES-F ()
    <COND (<VERB? RUB> <TELL "The steel is cold and spotless. Someone wiped it down very carefully, perhaps more than once." CR>)
          (<VERB? LOOK-UNDER> <TELL "Cable runs, all labelled in Mara's square hand. None of them leads to the comparator." CR>)>>

<ROUTINE PIPES-F ()
    <COND (<VERB? LISTEN> <COND (,COOLING <TELL "A steady gurgle as coolant moves through them." CR>) (T <TELL "They tick and creak as they warm, with nothing flowing inside." CR>)>)
          (<VERB? RUB> <COND (,COOLING <TELL "Cold enough to make your fingers ache." CR>) (T <TELL "Warm, and getting warmer." CR>)>)>>

<ROUTINE BAY-F ()
    <COND (<VERB? LISTEN> <PERFORM ,V?LISTEN ,BUS> <RTRUE>)
          (<VERB? RUB> <TELL "The conduit is warm where the cable leaves it, and cool a hand's width away." CR>)>>

<ROUTINE SHIELDING-F ()
    <COND (<VERB? CLIMB-ON> <TELL "You sit at the far end of the bench from Senn. The shielding swallows the small sounds you both make, and neither of you hurries to fill the quiet." CR>)
          (<VERB? RUB> <TELL "The shielding is soft and heavy, like a lead apron. It deadens your voice to almost nothing." CR>)
          (<VERB? KNOCK> <TELL "Your knock makes no sound at all. The room was built to keep signals out, or in." CR>)>>
