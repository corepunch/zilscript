<SYNTAX TURN OBJECT = V-SPIN>

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
	<COND (<AND <EQUAL? .RARG ,M-LOOK> <FSET? ,RECORDER ,OPENBIT>>
		<TELL "The open [[recorder]] rings beside its [[mass ledger->ledger]] on the way [[west]] to the galley." CR>)>>

<ROUTINE GO ()
	<SETG COMPACT-ROOM-LISTS T>
	<SETG HERE ,CRADLE>
	<SETG VERBOSE T>
	<SETG LIT T>
	<SETG WINNER ,ADVENTURER>
	<SETG PLAYER ,WINNER>
	<MOVE ,WINNER ,HERE>
	<TELL "“Keep holding her hand.” You remember doing it. You remember strapping both hands into this cradle, too. Your fingers are still cold." CR CR>
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
		<CRLF> <RTRUE>)>>

<ROUTINE HUB-F (RARG "AUX" (STAGE 0))
	<COND (<EQUAL? .RARG ,M-LOOK>
		<COND (,EVAC <SET STAGE 4>) (,ISOLATED <SET STAGE 3>) (,PROOF <SET STAGE 2>) (,COOLING <SET STAGE 1>)>
		<COND (<OR <EQUAL? .STAGE ,HUB-MILESTONE> <0? .STAGE>>
		       <TELL "The air at the junction tastes of the [[copper rail->copper]] under your hand.">)
		      (,EVAC <TELL "From the [[rail->copper]] you can see Mara is waiting overhead.">)
		      (,ISOLATED <TELL "At the [[copper rail->copper]], the compulsive half-heard syllable is gone.">)
		      (,PROOF <TELL "You count four [[marks->copper]] on the [[rail->copper]], just as the measured breath-load said.">)
		      (T <TELL "Cool air reaches your ankles below the [[copper rail->copper]].">)>
		<SETG HUB-MILESTONE .STAGE>
		<TELL " The torque shop lies [[west]], galley [[east]], clinic [[north]], cradle [[south]], spine [[down]] and cupola [[up]]." CR>
		<RTRUE>)>>
<ROUTINE CLINIC-F (RARG)
	<COND (<EQUAL? .RARG ,M-LOOK>
		<TELL "The [[examination area->area]] smells of [[soap]], the [[clinical log->log]] open between the junction [[south]] and the lab [[north]]." CR>
		<COND (<IN? ,MARA ,CLINIC>
			<COND (,ISOLATED <TELL "[[Mara]] holds her own wrist, counting without looking at the time." CR>)
				(T <TELL "[[Mara]] asks whether you have eaten." CR>)>)
			(T <TELL "Mara has gone to the launch cupola." CR>)>
		<RTRUE>)>>
<ROUTINE LAB-F (RARG)
	<COND (<EQUAL? .RARG ,M-LOOK>
		<COND (,PROOF <TELL "The optical trace holds steady on the [[comparator]].">)
		      (T <TELL "The [[comparator]] vibrates at the edge of hearing.">)>
		<TELL " [[South]] returns to the clinic; [[east]] leads to screened quarantine." CR>
		<RTRUE>)>>
<ROUTINE COOLANT-F (RARG)
	<COND (<EQUAL? .RARG ,M-LOOK>
		<COND (,COOLING <TELL "Cold [[mist]] rises as the [[pump]] turns.">)
			(T <TELL "The [[pump]] makes a patient, unsuccessful sucking sound.">)>
		<TELL " The service spine is [[east]]." CR> <RTRUE>)>>
<ROUTINE RELAY-F (RARG)
	<COND (<EQUAL? .RARG ,M-LOOK>
		<COND (,ISOLATED <TELL "The severed [[incoming bus->bus]] hangs silent.">)
			(,TERMINATED <TELL "The [[incoming bus->bus]] hums against its fitted [[null spool->spool]].">)
			(T <TELL "The [[incoming bus->bus]] sings through your teeth.">)>
		<TELL " The service spine is [[west]]; the receiver vault is [[north]]." CR> <RTRUE>)>>
<ROUTINE RECEPTION-F (RARG)
	<COND (<EQUAL? .RARG ,M-LOOK>
		<COND (<FSET? ,RECEIVER ,OPENBIT>
                       <TELL "The silent [[receiver]] stands open across the passage [[south]] to the relay." CR> <RTRUE>)>
                <TELL "The [[receiver]] crowds the passage [[south]] to the relay." CR>
		<COND (,ISOLATED <TELL "You remember it thanking you, though it makes no sound." CR>)
			(T <TELL "With each low beat your tongue tries to shape a name." CR>)>
		<RTRUE>)>>
<ROUTINE QUARANTINE-F (RARG)
	<COND (<EQUAL? .RARG ,M-LOOK>
		<TELL "[[Senn]] sits between the lab [[west]] and the [[interlock]] [[north]] to the cold core." CR>
		<COND (,SENN-DISCLOSED <TELL "His hands are closed now, and he meets your eyes." CR>)
			(,ISOLATED <TELL "He lets you finish speaking before he says, “Ask me about my [[daughter]] again.”" CR>)
			(,PROOF <TELL "“When the carrier is quiet,” he says, “ask me about my [[daughter]] again.”" CR>)
			(T <TELL "His lips shape the last word of your greeting before you say it." CR>)>
		<RTRUE>)>>

<ROUTINE CORE-F (RARG)
	<COND (<EQUAL? .RARG ,M-LOOK>
		<COND (<IN? ,WAFER ,CORE>
                       <TELL "Your breath hangs white between the [[cold archive->archive]] and the [[decision console->console]] by the [[south]] door." CR> <RTRUE>)>
                <COND (<IN? ,WAFER ,COLD-ARCHIVE> <TELL "Your breath hangs white as the [[wafer]] rests in cold storage inside the silent [[archive]].">)
		      (T <TELL "Your breath hangs white over the [[cold archive->archive]].">)>
		<TELL " The [[decision console->console]] faces the way [[south]] to quarantine." CR>
		<RTRUE>)>>
<ROUTINE LAUNCH-F (RARG)
	<COND (<EQUAL? .RARG ,M-LOOK>
		<COND (,EVAC <TELL "The armed [[beacon]] points at the [[stars]], and [[Mara]] waits beside four empty [[seats]].">)
		      (T <TELL "The [[beacon]] points into the steady [[stars]].">)>
		<TELL " The junction is [[down]]." CR>
		<RTRUE>)>>

<ROUTINE CORE-NORTH ()
	<COND (<AND ,ISOLATED ,PROOF> ,CORE)
		(T <TELL "The cold-core interlock requires independent comparison and physical receive isolation. [[Senn]] touches the blank inspection field, then takes his hand away." CR> <RFALSE>)>>

<ROUTINE WRENCH-F ()
	<COND (<VERB? EXAMINE> <TELL "A calibrated torque [[wrench]], built for the coolant pump's square fitting. The grip is worn to the shape of your hand. A remembered smaller hand lies over yours; the grip has only one wear pattern." CR>)>>
<ROUTINE SHEARS-F ()
	<COND (<VERB? EXAMINE> <TELL "Nonconductive [[ceramic shears->shears]]. Mara used them for sterile cable work before anyone thought we needed weapons. They cut the incoming bus safely, once it is terminated." CR>)>>
<ROUTINE SPOOL-F ()
	<COND (<VERB? EXAMINE> <TELL "A passive [[null spool->spool]]: no processor, just impedance matched to the incoming bus. ">
			<COND (<IN? ,SPOOL ,BUS> <TELL "It is locked onto the bus termination. ">)
				(T <TELL "Fit it to the bus before cutting. ">)>
			<TELL "Ivo has scratched his initials into its casing. Beside them, a second name has been started and rubbed away." CR>)
		(<VERB? FIT> <V-FIT>)
		(<AND <VERB? TAKE> <IN? ,SPOOL ,BUS>>
		<TELL "Once fitted, the [[spool]] belongs to the safety termination. Leave it there; no other task needs it." CR>)>>
<ROUTINE PROTOCOL-F ()
	<COND (<VERB? EXAMINE READ>
		<TELL "RECEIVE ISOLATION / COOL STORAGE. Restore coolant with the torque wrench. FIT SPOOL TO BUS, then CUT BUS WITH SHEARS. The spool absorbs discharge; ceramic blades cannot feed it into your nervous system. Only then OPEN RECEIVER. Compare physical witness foil in the laboratory before accepting autobiographical evidence. Store a recovered wafer in the cold archive. A mechanical rendezvous beacon is safe; radio is not." CR>)>>
<ROUTINE PORTRAIT-F ()
	<COND (<VERB? EXAMINE READ>
		<TELL "Surface tension pins a child's face in clear [[droplets]]. It is beautiful and technically pointless. [[Ivo]] made it for Senn from a family photograph. A fifth adult sometimes seems to stand behind the child; when you count the actual droplets, no such figure is there. Ask Ivo about the [[daughter]]." CR>)>>
<ROUTINE RECORDER-F ()
	<COND (<VERB? EXAMINE READ>
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
		(<VERB? SHOW> <V-SHOW>)>>

<ROUTINE LEDGER-F ()
	<COND (<VERB? EXAMINE READ>
		<TELL "Departure mass: four adults. Your name, Mara Vale, Ivo Chen, Senn Orlov. Four ration allocations. Four return restraints. No mass allowance exists for the fifth biography now shared by the crew. The ledger is indented through to the backing, written before first reception." CR>)>>
<ROUTINE LOG-F ()
	<COND (<VERB? EXAMINE READ>
		<TELL "Mara recorded four independent pulses before reception. Afterwards she added a fifth name, Lena Orlov, then crossed out its empty vital-sign fields. No fifth pulse is recorded. In the margin: “Requested pediatric analgesia. I remember treating an adult.” No dose was dispensed." CR>)>>
<ROUTINE PUMP-F ()
	<COND (<VERB? SPIN>
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
	<COND (<VERB? EXAMINE READ>
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
	<COND (<VERB? EXAMINE READ>
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
	<COND (<VERB? EXAMINE READ>
		<COND (<NOT ,ISOLATED> <TELL "The [[receiver]] remains live. Its mechanical release is interlocked to the incoming bus. Isolate that bus before opening the housing." CR>)
				(<NOT <FSET? ,RECEIVER ,OPENBIT>> <TELL "The [[receiver]] is electrically dead. Its mechanical release can now open the housing." CR>)
				(<IN? ,WAFER ,RECEIVER> <TELL "The [[receiver]] is electrically dead and its housing stands open. A single [[memory wafer->wafer]] rests inside." CR>)
			(T <TELL "The [[receiver]] is electrically dead. Its housing stands open and empty, two [[spring clips]] facing each other across a wafer-sized gap." CR>)>)
		(<VERB? OPEN SEARCH LOOK-INSIDE>
		<COND (<NOT ,ISOLATED> <TELL "The live housing cannot be opened. Terminate and sever the incoming bus first." CR>)
			(T <FSET ,RECEIVER ,OPENBIT>
				<COND (<IN? ,WAFER ,RECEIVER> <TELL "The housing opens on a single [[memory wafer->wafer]], still warm. A cooling crescent remains where it rested against the housing." CR> <THIS-IS-IT ,WAFER>)
					(T <TELL "The [[receiver]] is open and empty." CR>)>)>)>>
<ROUTINE WAFER-F ()
	<COND (<VERB? EXAMINE>
		<SETG ORIGIN T>
		<TELL "A [[memory wafer->wafer]] on a passive substrate. Its [[engraved index]] reads LENA / RESCUE-COMPRESSION / SENN ORLOV. An outer-relay [[return stamp]] crosses Asterion's own outbound serial. There is no independent power source." CR CR "You remember Lena reciting that serial while she worked. You do not remember teaching it to her. Senn can account for the name; cold storage will hold the sample without playback." CR>)
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
		(<VERB? CLOSE> <TELL "The archive's access sleeve stays open until a final commitment. Its blind interior contains no decoder." CR>)>>

<ROUTINE MARA-F ()
	<COND (<VERB? EXAMINE> <TELL "[[Mara]] has pressed thumbnail marks into her palm. She checks the marks before she answers you: a physical record of how often the same thought returned. Ask her about the [[signal]], the [[crew]], or Senn's [[daughter]]." CR>)
		(<VERB? SHOW> <V-SHOW>)
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
	<COND (<VERB? EXAMINE>
		<COND (,CONSENT <TELL "[[Ivo]] is counting again. Four, and this time he stops. Ask about the [[signal]], the [[crew]], or the [[daughter]]." CR>)
			(T <TELL "[[Ivo]] keeps rubbing an uninjured knuckle. He remembers Lena splinting it. Ask about the [[signal]], the [[crew]], or the [[daughter]]." CR>)>)
		(<VERB? SHOW> <V-SHOW>)
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
	<COND (<VERB? EXAMINE>
		<COND (,SENN-DISCLOSED <TELL "[[Senn]] keeps his hands closed on his knees. He follows your gaze instead of supplying your next word. ">)
			(T <TELL "[[Senn]] holds his palms apart, the spacing of hands around a face. There is nothing physically between them. ">)>
		<TELL "Ask about the [[signal]], the [[crew]], or his [[daughter]]." CR>
			<COND (<AND ,ISOLATED <NOT ,SENN-DISCLOSED>> <TELL "“My daughter,” he repeats. “You should ask me again now.”" CR>)>
			<RTRUE>)
		(<VERB? SHOW> <V-SHOW>)
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
		(<AND <EQUAL? ,PRSO ,WAFER> <EQUAL? ,PRSI ,SENN>> <SETG ORIGIN T> <SENN-CONFESSION>)
		(<AND <EQUAL? ,PRSO ,WAFER> <EQUAL? ,PRSI ,IVO>> <IVO-SAMPLE>)
		(<EQUAL? ,PRSI ,MARA> <TELL "Mara checks the item and hands it back. “You know the tools. I know what happened to our pulse counts.”" CR>)
		(<EQUAL? ,PRSI ,SENN> <TELL "Senn does not take it. “Keep the engineering equipment. I'll answer for the experiment.”" CR>)
		(<EQUAL? ,PRSI ,IVO> <TELL "Ivo checks it out of habit. “Still the right tool. At least that hasn't changed.”" CR>)
		(T <TELL "Show the physical evidence to a colleague who can examine it." CR>)>>

<ROUTINE BEACON-F ()
	<COND (<VERB? EXAMINE READ>
		<COND (,EVAC <TELL "The [[beacon]] is armed for a ballistic rendezvous. It broadcasts no information; rescue will find its physical reflector. Return to the cold-core console for the final decision." CR>)
			(T <TELL "A mechanical [[beacon]], not a transmitter: it launches a passive reflector. Push it after independent comparison, Ivo's informed consent, physical receive isolation, and cooled wafer containment. It prepares departure; it does not make the final choice." CR>)>)
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
	<COND (<VERB? EXAMINE READ>
		<TELL "Two final commitments. PRESERVE seals the sample in a blind, unpowered capsule and evacuates the living crew with a prohibition on playback. ERASE degausses the sample, removes the station's powered decoding chain, and evacuates the living crew without it. Preservation commits you to guarded custody: rescuers and investigators will want to play their only specimen, and you will have to keep refusing. Erasure destroys that specimen and the possibility of studying what it became. Both leave a physical warning. Neither erases your implanted memories." CR CR "Before either commitment: independent comparison, examination of the wafer's origin index, Ivo's consent, receive isolation, cooling, the wafer physically in the archive, and the rendezvous beacon armed. Preparation can still be changed. The next successful PRESERVE or ERASE ends the story." CR>)
		(<VERB? PRESERVE> <V-PRESERVE> <RTRUE>)
		(<VERB? ERASE> <V-ERASE> <RTRUE>)
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
		<TELL "Beneath the turning [[portrait]], ">
		<COND (,CONSENT <TELL "[[Ivo]] taps once for each name he will take to the cupola.">)
			(T <TELL "[[Ivo]] counts to four and starts again.">)>
		<TELL " [[West]] returns to the junction; [[east]] leads to the physical archive." CR> <RTRUE>)>>
<ROUTINE V-SCORE ("OPTIONAL" (ASK? T))
	<COND (,RESOLVED <TELL "The crew has left the station. Your decision is part of the physical record." CR>)
		(,EVAC <TELL "Departure prepared. The cold-core decision remains yours." CR>)
		(,ISOLATED <TELL "Reception isolated. Secure the sample and prepare evacuation." CR>)
		(,PROOF <TELL "Independent evidence established. Isolate reception and obtain consent." CR>)
		(,POWER <TELL "Habitat restored. Establish an independent physical reference." CR>)
		(T <TELL "Restore habitat power." CR>)>>
<ROUTINE CRADLE-F (RARG)
	<COND (<EQUAL? .RARG ,M-LOOK>
		<COND (,POWER <TELL "The [[padding]] holds the warmth of your back. Beside the quiet [[breaker]], the pressure-balanced way [[north]] stands open.">)
			(T <TELL "A dry [[click]] comes through the [[padding]]. The [[breaker]] is within reach, but the way [[north]] is sealed.">)>
		<CRLF> <RTRUE>)>>
<ROUTINE FRAME-F ()
	<COND (<VERB? EXAMINE SEARCH>
           <COND (<FSET? ,DETAIL-BUCKLE ,OPENBIT> <TELL "The open [[buckle]] hangs loose against the [[restraint frame->frame]].">)
              (T <TELL "A [[buckle]] taps the [[restraint frame->frame]] when you shift your weight.">)>
        <TELL " The frame releases by hand. Its padding is worn in four places where you brace your limbs. There is no second person's impression. The doorway's mechanical interlock depends on the habitat [[breaker]]." CR>)
		(<VERB? OPEN CLOSE> <COND (,POWER <TELL "The interlock is released; the way [[north]] is open." CR>)
			(T <TELL "Reset the [[breaker]] first. The pressure interlock is doing its job." CR>)>)>>
<ROUTINE RECESSES-F ()
	<COND (<VERB? EXAMINE SEARCH>
		<TELL "Two shapes are cut into the insulation below the [[protocol]].">
		<COND (<AND <IN? ,WRENCH ,WORKSHOP> <NOT <FSET? ,WRENCH ,TOUCHBIT>>> <TELL " A [[torque wrench->wrench]] fits the long slot.">)
			(T <TELL " The long slot is empty.">)>
		<COND (<AND <IN? ,SPOOL ,WORKSHOP> <NOT <FSET? ,SPOOL ,TOUCHBIT>>> <TELL " A [[null spool->spool]] fills the round one.">)
			(T <TELL " The round slot is empty.">)>
		<CRLF> <RTRUE>)>>
<ROUTINE EXAM-AREA-F ()
	<COND (<VERB? EXAMINE SEARCH SMELL> <TELL "The [[examination area->area]] has been washed with ordinary unscented soap. You remember a fifth patient here, but there is no fifth entry in the [[log]].">
		<COND (<AND <IN? ,SHEARS ,CLINIC> <NOT <FSET? ,SHEARS ,TOUCHBIT>>> <TELL " A pair of [[ceramic shears->shears]] lies ready for sterile work.">)>
		<CRLF> <RTRUE>)>>
<ROUTINE STARFIELD-F ()
	<COND (<VERB? EXAMINE> <TELL "The [[stars]] are points without an atmosphere to soften them. The station's slow rotation changes their position predictably. It is a relief to watch something indifferent to you." CR>)>>
<ROUTINE HARDWARE-F ()
	<COND (<VERB? CLIMB-ON> <TELL "You try one of the four seats. Your shoulders fit between the restraints. You get up again." CR>)
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
    <COND (<VERB? OPEN>
           <COND (<AND ,PROOF ,ISOLATED> <TELL "The bolt is back. The way into the core is open." CR>)
                 (T <TELL "The bolt holds. You check the flags. "> <PERFORM ,V?READ ,DETAIL-INSPECTION-FLAGS>)>)
          (<VERB? EXAMINE>
           <COND (<AND ,PROOF ,ISOLATED> <TELL "Both [[inspection flags]] show white: trace verified and receiver isolated. The bolt has drawn back into its sleeve." CR>)
                 (T <TELL "The bolt crosses two [[inspection flags]]. One needs a verified physical trace, the other a disconnected receiver." CR>)>)>>

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
    <COND (<VERB? OPEN PUSH UNTIE>
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
