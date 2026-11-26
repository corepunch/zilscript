 			"Generic VERBS file for
			    The ZORK Trilogy
		       started on 7/25/83 by SEM"

^L

"Verb Functions for Game Commands"

;"The verb form that agrees with OBJ, which a reply prints after its name:
  <TELL CTHE ,PRSO <AGREE ,PRSO \" is\" \" are\"> \" closed.\" CR>. A story marks
  a plural noun (\"cobwebs\", \"stairs\") with PLURALBIT; its indefinite
  article is then \"some\"."
<ROUTINE AGREE (OBJ SINGULAR PLURAL)
	 <COND (<FSET? .OBJ ,PLURALBIT> .PLURAL)
	       (T .SINGULAR)>>

<ROUTINE V-VERBOSE ()
	 <SETG VERBOSE T>
	 <SETG SUPER-BRIEF <>>
	 <TELL "Maximum verbosity." CR>>

<ROUTINE V-BRIEF ()
	 <SETG VERBOSE <>>
	 <SETG SUPER-BRIEF <>>
	 <TELL "Brief descriptions." CR>>

<ROUTINE V-SUPER-BRIEF ()
	 <SETG SUPER-BRIEF T>
	 <TELL "Superbrief descriptions." CR>>

;"V-DIAGNOSE is in ACTIONS.ZIL"

<ROUTINE V-INVENTORY ()
	 <COND (<FIRST? ,WINNER> <PRINT-CONT ,WINNER>)
	       (T <TELL "You are empty-handed." CR>)>>

<ROUTINE FINISH ("AUX" WRD)
	 <V-SCORE>
	 <COND (,PROSE-LINKS <QUIT>)>
	 <REPEAT ()
		 <CRLF>
		 <TELL
"Would you like to restart the game from the beginning, restore a saved
game position, or end this session of the game?|
(Type RESTART, RESTORE, or QUIT):|
>">
		 <READ ,P-INBUF ,P-LEXV>
		 <SET WRD <GET ,P-LEXV 1>>
		 <COND (<EQUAL? .WRD ,W?RESTART>
			<RESTART>
			<TELL "Failed." CR>)
		       (<EQUAL? .WRD ,W?RESTORE>
			<COND (<RESTORE>
			       <TELL "Ok." CR>)
			      (T
			       <TELL "Failed." CR>)>)
		       (<EQUAL? .WRD ,W?QUIT ,W?Q>
			<QUIT>)>>>

<ROUTINE V-QUIT ("AUX" SCOR)
	 <V-SCORE>
	 <TELL 
"Do you wish to leave the game? (Y is affirmative): ">
	 <COND (<YES?>
		<QUIT>)
	       (ELSE <TELL "Ok." CR>)>>

<ROUTINE V-RESTART ()
	 <V-SCORE T>
	 <TELL "Do you wish to restart? (Y is affirmative): ">
	 <COND (<YES?>
		<TELL "Restarting." CR>
		<RESTART>
		<TELL "Failed." CR>)>>

<ROUTINE V-RESTORE ()
	 <COND (<RESTORE>
		<TELL "Ok." CR>
		<V-FIRST-LOOK>)
	       (T
		<TELL "Failed." CR>)>>

<ROUTINE V-SAVE ()
	 <COND (<SAVE>
	        <TELL "Ok." CR>)
	       (T
		<TELL "Failed." CR>)>>

;"V-SCORE is in ACTIONS.ZIL"

<ROUTINE V-SCRIPT ()
	<PUT 0 8 <BOR <GET 0 8> 1>>
	<TELL "Here begins a transcript of interaction with" CR>
	<V-VERSION>
	<RTRUE>>

<ROUTINE V-UNSCRIPT ()
	<TELL "Here ends a transcript of interaction with" CR>
	<V-VERSION>
	<PUT 0 8 <BAND <GET 0 8> -2>>
	<RTRUE>>

<ROUTINE V-VERSION ("AUX" (CNT 17))
	<TELL "ZORK I: The Great Underground Empire|
Infocom interactive fiction - a fantasy story|
Copyright (c) 1981, 1982, 1983, 1984, 1985, 1986">
	<TELL " Infocom, Inc. All rights reserved." CR>
	<TELL "ZORK is a registered trademark of Infocom, Inc.|
Release ">
	<PRINTN <BAND <GET 0 1> *3777*>>
	<TELL " / Serial number ">
	<REPEAT ()
		<COND (<G? <SET CNT <+ .CNT 1>> 23>
		       <RETURN>)
		      (T
		       <PRINTC <GETB 0 .CNT>>)>>
	<CRLF>>

<ROUTINE V-VERIFY ()
	 <TELL "Verifying disk..." CR>
	 <COND (<VERIFY>
		<TELL "The disk is correct." CR>)
	       (T
		<TELL CR "** Disk Failure **" CR>)>>

<ROUTINE V-RANDOM ()
	 <COND (<NOT <EQUAL? ,PRSO ,INTNUM>>
		<TELL "Illegal call to #RND." CR>)
	       (T
		<RANDOM <- 0 ,P-NUMBER>>
		<RTRUE>)>>

^L

"Real Verb Functions"

<ROUTINE V-ANSWER ()
	 <TELL "Nobody seems to be awaiting your answer." CR>
	 <SETG P-CONT <>>
	 <SETG QUOTE-FLAG <>>
	 <RTRUE>>

<ROUTINE PRE-BOARD ("AUX" AV)
	 <SET AV <LOC ,WINNER>>
	 <COND (<FSET? ,PRSO ,VEHBIT>
		<COND (<NOT <IN? ,PRSO ,HERE>>
		       <TELL
CTHE ,PRSO " must be on the ground to be boarded." CR>)
		      (<FSET? .AV ,VEHBIT>
		       <TELL "You are already in " THE .AV "!" CR>)
		      (T
		       <RFALSE>)>)
	       ;"Boarding a liquid means getting into it."
	       (<FSET? ,PRSO ,DRINKBIT>
		<PERFORM ,V?SWIM ,PRSO>
		<RTRUE>)
	       (T
		<TELL
"You have a theory on how to board " A ,PRSO ", perhaps?" CR>)>
	 <RFATAL>>

<ROUTINE V-BOARD ("AUX" AV)
	 <TELL "You are now in " THE ,PRSO "." CR>
	 <MOVE ,WINNER ,PRSO>
	 <APPLY <GETP ,PRSO ,P?ACTION> ,M-ENTER>
	 <RTRUE>>

<ROUTINE V-CLIMB-DOWN () <V-CLIMB-UP ,P?DOWN ,PRSO>>

<ROUTINE V-CLIMB-FOO ()
	 <V-CLIMB-UP ,P?UP ,PRSO>>

<ROUTINE V-CLIMB-ON ()
	 <COND (<FSET? ,PRSO ,VEHBIT>
		<PERFORM ,V?BOARD ,PRSO>
		<RTRUE>)
	       (T
		<TELL "You can't climb onto " THE ,PRSO "." CR>)>>

<ROUTINE V-CLIMB-UP ("OPTIONAL" (DIR ,P?UP) (OBJ <>) "AUX" X TX)
	 <COND (<AND .OBJ <NOT <EQUAL? ,PRSO ,ROOMS>>>
		<SET OBJ ,PRSO>)>
	 <COND (<SET TX <GETPT ,HERE .DIR>>
		<COND (.OBJ
		       <SET X <PTSIZE .TX>>
		       <COND (<OR <EQUAL? .X ,NEXIT>
				  <AND <EQUAL? .X ,CEXIT ,DEXIT ,UEXIT>
				       <NOT <GLOBAL-IN? ,PRSO <GETB .TX 0>>>>>
			      <TELL CTHE .OBJ <AGREE .OBJ " doesn't" " don't">
				    " lead ">
			      <COND (<==? .DIR ,P?UP>
				     <TELL "up">)
				    (T <TELL "down">)>
			      <TELL "ward." CR>
			      <RTRUE>)>)>
		<DO-WALK .DIR>
		<RTRUE>)
	       (<AND .OBJ
		     <ZMEMQ ,W?WALL
			    <SET X <GETPT ,PRSO ,P?SYNONYM>> <PTSIZE .X>>>
		<TELL "Climbing the walls is to no avail." CR>)
	       (<EQUAL? .OBJ <> ,ROOMS>
		<TELL "You can't go that way." CR>)
	       (T
	        <TELL "You can't do that!" CR>)>>

<ROUTINE V-CLOSE ()
	 <COND (<AND <NOT <FSET? ,PRSO ,CONTBIT>>
		     <NOT <FSET? ,PRSO ,DOORBIT>>>
		<TELL "You must tell me how to do that to " A ,PRSO "." CR>)
	       (<AND <NOT <FSET? ,PRSO ,SURFACEBIT>>
		     <NOT <EQUAL? <GETP ,PRSO ,P?CAPACITY> 0>>>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <FCLEAR ,PRSO ,OPENBIT>
		       <TELL "Closed." CR>
		       <COND (<AND ,LIT <NOT <SETG LIT <LIT? ,HERE>>>>
			      <TELL "It is now pitch black." CR>)>
		       <RTRUE>)
		      (T
	 	       <TELL "It is already closed." CR>)>)
	       (<FSET? ,PRSO ,DOORBIT>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <FCLEAR ,PRSO ,OPENBIT>
		       <TELL CTHE ,PRSO " is now closed." CR>)
		      (T
	 	       <TELL "It is already closed." CR>)>)
	       (T
		<TELL "You cannot close that." CR>)>>

<ROUTINE V-COMMAND ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<TELL CTHE ,PRSO " pays no attention." CR>)
	       (T
		<TELL "You cannot talk to that!" CR>)>>

<ROUTINE V-DISEMBARK ()
	 <COND (<AND <EQUAL? ,PRSO ,ROOMS>
		     <FSET? <LOC ,WINNER> ,VEHBIT>>
		<PERFORM ,V?DISEMBARK <LOC ,WINNER>>
		<RTRUE>)
	       (<NOT <EQUAL? <LOC ,WINNER> ,PRSO>>
		<TELL "You're not in that!" CR>
		<RFATAL>)
	       (<FSET? ,HERE ,RLANDBIT>
		<TELL "You are on your own feet again." CR>
		<MOVE ,WINNER ,HERE>)
	       (T
		<TELL
"You realize that getting out here would be fatal." CR>
		<RFATAL>)>>

<ROUTINE V-DISENCHANT ()
	 <TELL "Nothing happens." CR>>

<ROUTINE V-DRINK-FROM ()
	 <TELL "How peculiar!" CR>>

<ROUTINE V-DROP ()
	 <COND (<IDROP>
		<TELL "Dropped." CR>)>>

<ROUTINE V-EAT ("AUX" (EAT? <>) (DRINK? <>) (NOBJ <>))
	 <COND (<SET EAT? <FSET? ,PRSO ,FOODBIT>>
		<COND (<AND <NOT <IN? ,PRSO ,WINNER>>
			    <NOT <IN? <LOC ,PRSO> ,WINNER>>>
		       <TELL "You're not holding that." CR>)
		      (<VERB? DRINK>
		       <TELL "How can you drink that?">)
		      (T
		       <TELL "Thank you very much. It really hit the spot.">
		       <REMOVE-CAREFULLY ,PRSO>)>
		<CRLF>)
	       (<FSET? ,PRSO ,DRINKBIT>
		<SET DRINK? T>
		<SET NOBJ <LOC ,PRSO>>
		<COND (<OR <IN? ,PRSO ,GLOBAL-OBJECTS>
			   <LIQUID-HERE>
			   <EQUAL? ,PRSO ,PSEUDO-OBJECT>>
		       <HIT-SPOT>)
		      (<OR <NOT .NOBJ>
			   <NOT <ACCESSIBLE? .NOBJ>>>
		       <TELL
"There isn't any water here." CR>)
		      (<AND <ACCESSIBLE? .NOBJ>
			    <NOT <IN? .NOBJ ,WINNER>>>
		       <TELL
"You have to be holding " THE .NOBJ " first." CR>)
		      (<NOT <FSET? .NOBJ ,OPENBIT>>
		       <TELL
"You'll have to open " THE .NOBJ " first." CR>)
		      (T
		       ;"A drink carried in an open container is used up."
		       <REMOVE-CAREFULLY ,PRSO>
		       <HIT-SPOT>)>)
	       (<NOT <OR .EAT? .DRINK?>>
		<TELL
"I don't think that " THE ,PRSO " would agree with you." CR>)>>

<ROUTINE HIT-SPOT ()
	 <TELL
"Thank you very much. I was rather thirsty (from all this talking,
probably)." CR>>

<ROUTINE V-ENCHANT ()
	 <V-DISENCHANT>>

<ROUTINE REMOVE-CAREFULLY (OBJ "AUX" OLIT)
	 <COND (<EQUAL? .OBJ ,P-IT-OBJECT>
		<SETG P-IT-OBJECT <>>)>
	 <SET OLIT ,LIT>
	 <REMOVE .OBJ>
	 <SETG LIT <LIT? ,HERE>>
	 <COND (<AND .OLIT <NOT <EQUAL? .OLIT ,LIT>>>
		<TELL "You are left in the dark..." CR>)>
	 T>

<ROUTINE V-ENTER ()
	<DO-WALK ,P?IN>>

<ROUTINE V-EXAMINE ()
	 <COND (<GETP ,PRSO ,P?TEXT>
		<TELL <GETP ,PRSO ,P?TEXT> CR>)
	       (<OR <FSET? ,PRSO ,CONTBIT>
		    <FSET? ,PRSO ,DOORBIT>>
		<V-LOOK-INSIDE>)
	       (T
		<TELL "There's nothing special about " THE ,PRSO "." CR>)>>

<ROUTINE V-EXIT ()
	 <COND (<AND <EQUAL? ,PRSO <> ,ROOMS>
		     <FSET? <LOC ,WINNER> ,VEHBIT>>
		<PERFORM ,V?DISEMBARK <LOC ,WINNER>>
		<RTRUE>)
	       (<AND ,PRSO <IN? ,WINNER ,PRSO>>
		<PERFORM ,V?DISEMBARK ,PRSO>
		<RTRUE>)
	       (ELSE
		<DO-WALK ,P?OUT>)>>

;"Fill X fills it from the liquid here: the room's, or one lying beside you.
  Fill X with something that is no liquid puts that thing in X."
<ROUTINE PRE-FILL ("AUX" L)
	 <COND (<NOT ,PRSI>
		<COND (<OR <SET L <LIQUID-HERE>>
			   <SET L <FIND-IN <LOC ,WINNER> ,DRINKBIT>>>
		       <PERFORM ,V?FILL ,PRSO .L>)
		      (T
		       <TELL "There is nothing to fill it with." CR>)>
		<RTRUE>)
	       (<NOT <FSET? ,PRSI ,DRINKBIT>>
		<PERFORM ,V?PUT ,PRSI ,PRSO>
		<RTRUE>)>>

<ROUTINE V-FILL ()
	 <TELL "You may know how to do that, but I don't." CR>>

<ROUTINE V-FIND ("AUX" (L <LOC ,PRSO>))
	 <COND (<EQUAL? ,PRSO ,HANDS ,LUNGS>
		<TELL
"Within six feet of your head, assuming you haven't left that
somewhere." CR>)
	       (<EQUAL? ,PRSO ,ME>
		<TELL "You're around here somewhere..." CR>)
	       (<EQUAL? .L ,GLOBAL-OBJECTS>
		<TELL "You find it." CR>)
	       (<IN? ,PRSO ,WINNER>
		<TELL "You have it." CR>)
	       (<OR <IN? ,PRSO ,HERE>
		    <GLOBAL-IN? ,PRSO ,HERE>
		    <EQUAL? ,PRSO ,PSEUDO-OBJECT>>
		<TELL "It's right here." CR>)
	       (<FSET? .L ,ACTORBIT>
		<TELL CTHE .L " has it." CR>)
	       (<FSET? .L ,SURFACEBIT>
		<TELL "It's on " THE .L "." CR>)
	       (<FSET? .L ,CONTBIT>
		<TELL "It's in " THE .L "." CR>)
	       (T
		<TELL "Beats me." CR>)>>

<ROUTINE V-FOLLOW ()
	 <TELL "You're nuts!" CR>>

<ROUTINE PRE-GIVE ()
	 <COND (<NOT <HELD? ,PRSO>>
		<TELL 
"That's easy for you to say since you don't even have " THE ,PRSO "." CR>)>>

<ROUTINE V-GIVE ()
	 <COND (<NOT <FSET? ,PRSI ,ACTORBIT>>
		<TELL "You can't give " A ,PRSO " to " A ,PRSI "!" CR>)
	       (T
		<TELL CTHE ,PRSI " refuses it politely." CR>)>>

<ROUTINE V-HELLO ()
	 <COND (,PRSO
		<COND (<FSET? ,PRSO ,ACTORBIT>
		       <TELL
CTHE ,PRSO " nods to you in greeting." CR>)
		      (T
		       <TELL
"It's a well known fact that only schizophrenics say \"Hello\" to " A ,PRSO "." CR>)>)
	       (T
		<TELL <PICK-ONE ,HELLOS> CR>)>>

<ROUTINE V-INCANT ()
	 <TELL
"The incantation echoes back faintly, but nothing else happens." CR>
	 <SETG QUOTE-FLAG <>>
	 <SETG P-CONT <>>
	 <RTRUE>>

<ROUTINE V-KISS ()
	 <TELL "That wouldn't be welcome." CR>>

<ROUTINE V-KNOCK ()
	 <COND (<FSET? ,PRSO ,DOORBIT>
		<TELL "Nobody's home." CR>)
	       (T
		<TELL "Why knock on " A ,PRSO "?" CR>)>>

<ROUTINE V-LAMP-OFF ()
	 <COND (<FSET? ,PRSO ,LIGHTBIT>
		<COND (<NOT <FSET? ,PRSO ,ONBIT>>
		       <TELL "It is already off." CR>)
		      (T
		       <FCLEAR ,PRSO ,ONBIT>
		       <COND (,LIT
			      <SETG LIT <LIT? ,HERE>>)>
		       <TELL CTHE ,PRSO <AGREE ,PRSO " is" " are"> " now off." CR>
		       <COND (<NOT ,LIT>
			      <TELL "It is now pitch black." CR>)>)>)
	       (T
		<TELL "You can't turn that off." CR>)>
	 <RTRUE>>

<ROUTINE V-LAMP-ON ()
	 <COND (<FSET? ,PRSO ,LIGHTBIT>
		<COND (<FSET? ,PRSO ,ONBIT>
		       <TELL "It is already on." CR>)
		      (T
		       <FSET ,PRSO ,ONBIT>
		       <TELL CTHE ,PRSO <AGREE ,PRSO " is" " are"> " now on." CR>
		       <COND (<NOT ,LIT>
			      <SETG LIT <LIT? ,HERE>>
			      <CRLF>
			      <V-LOOK>)>)>)
	       (<FSET? ,PRSO ,BURNBIT>
		<TELL
"If you wish to burn " THE ,PRSO ", you should say so." CR>)
	       (T
		<TELL "You can't turn that on." CR>)>
	 <RTRUE>>

<ROUTINE V-LEAN-ON ()
	 <TELL "Getting tired?" CR>>

<ROUTINE V-LEAP ("AUX" TX S)
	 <COND (,PRSO
		<COND (<IN? ,PRSO ,HERE>
		       <COND (<FSET? ,PRSO ,ACTORBIT>
			      <TELL
CTHE ,PRSO <AGREE ,PRSO " is" " are"> " too big to jump over." CR>)
			     (T
			      <V-SKIP>)>)
		      (T
		       <TELL "That would be a good trick." CR>)>)
	       (<SET TX <GETPT ,HERE ,P?DOWN>>
		<SET S <PTSIZE .TX>>
		<COND (<OR <EQUAL? .S 2> ;NEXIT
       			   <AND <EQUAL? .S 4> ;CEXIT
				<NOT <VALUE <GETB .TX 1>>>>>
		       ;"World verbs never kill: a story that wants a fatal fall
			 writes it in its own room."
		       <TELL "It's too far down to jump safely." CR>)
		      (T
		       <V-SKIP>)>)
	       (T
		<V-SKIP>)>>

<ROUTINE V-LISTEN ()
	 <TELL CTHE ,PRSO <AGREE ,PRSO " makes" " make"> " no sound." CR>>

<ROUTINE V-LOCK ()
	 <TELL "It doesn't seem to work." CR>>

<ROUTINE V-LOOK-BEHIND ()
	 <TELL "There is nothing behind " THE ,PRSO "." CR>>

<ROUTINE V-LOOK-INSIDE ()
	 <COND (<FSET? ,PRSO ,DOORBIT>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <TELL
CTHE ,PRSO <AGREE ,PRSO " is" " are"> " open, but I can't tell what's beyond it.">)
		      (T
		       <TELL CTHE ,PRSO <AGREE ,PRSO " is" " are"> " closed.">)>
		<CRLF>)
	       (<FSET? ,PRSO ,CONTBIT>
		<COND (<FSET? ,PRSO ,ACTORBIT>
		       <TELL "There is nothing special to be seen." CR>)
		      (<SEE-INSIDE? ,PRSO>
		       <COND (<AND <FIRST? ,PRSO>
				   <PRINT-CONT ,PRSO>>
			      <RTRUE>)
			     (T
			      <TELL CTHE ,PRSO <AGREE ,PRSO " is" " are"> " empty." CR>)>)
		      (T
		       <TELL CTHE ,PRSO <AGREE ,PRSO " is" " are"> " closed." CR>)>)
	       (T
		<TELL "You can't look inside " A ,PRSO "." CR>)>>

<ROUTINE V-LOOK-ON ()
	 <COND (<FSET? ,PRSO ,SURFACEBIT>
		<PERFORM ,V?LOOK-INSIDE ,PRSO>
		<RTRUE>)
	       (T
		<TELL "Look on " A ,PRSO "???" CR>)>>

<ROUTINE V-LOOK-UNDER ()
	 <TELL "There is nothing but dust there." CR>>

<ROUTINE V-LOWER () <HACK-HACK "Playing in this way with the ">>

<ROUTINE PRE-MOVE ()
	 <COND (<HELD? ,PRSO>
		<TELL "You aren't an accomplished enough juggler." CR>)>>

<ROUTINE V-MOVE ()
	 <COND (<FSET? ,PRSO ,TAKEBIT>
		<TELL "Moving " THE ,PRSO " reveals nothing." CR>)
	       (T
		<TELL "You can't move " THE ,PRSO "." CR>)>>

<ROUTINE V-OPEN ("AUX" F STR)
	 <COND (<AND <FSET? ,PRSO ,CONTBIT>
		     <NOT <EQUAL? <GETP ,PRSO ,P?CAPACITY> 0>>>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <TELL "It is already open." CR>)
		      (T
		       <FSET ,PRSO ,OPENBIT>
		       <FSET ,PRSO ,TOUCHBIT>
		       <COND (<OR <NOT <FIRST? ,PRSO>> <FSET? ,PRSO ,TRANSBIT>>
			      <TELL "Opened." CR>)
			     (<AND <SET F <FIRST? ,PRSO>>
				   <NOT <NEXT? .F>>
				   <NOT <FSET? .F ,TOUCHBIT>>
				   <SET STR <GETP .F ,P?FDESC>>>
			      <TELL CTHE ,PRSO <AGREE ,PRSO " opens." " open."> CR>
			      <TELL .STR CR>)
			     (T
			      <TELL "Opening " THE ,PRSO " reveals ">
			      <PRINT-CONTENTS ,PRSO>
			      <TELL "." CR>)>)>)
	       (<FSET? ,PRSO ,DOORBIT>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <TELL "It is already open." CR>)
		      (T
		       <TELL CTHE ,PRSO <AGREE ,PRSO " opens." " open."> CR>
		       <FSET ,PRSO ,OPENBIT>)>)

	       (T
		<TELL
"You must tell me how to do that to " A ,PRSO "." CR>)>>

;"A story's liquid answers POUR-ON in its own action."
<ROUTINE V-POUR-ON ()
	 <TELL "You can't pour that." CR>>

<ROUTINE V-PUSH () <HACK-HACK "Pushing the ">>

<ROUTINE V-PUSH-TO ()
	 <TELL "You can't push things to that." CR>>

<ROUTINE V-PUT ()
	 <COND (<OR <FSET? ,PRSI ,OPENBIT>
		    <OPENABLE? ,PRSI>
		    <FSET? ,PRSI ,VEHBIT>>)
	       (T
		<TELL "You can't do that." CR>
		<RTRUE>)>
	 <COND (<NOT <FSET? ,PRSI ,OPENBIT>>
		<TELL CTHE ,PRSI " isn't open." CR>
		<THIS-IS-IT ,PRSI>)
	       (<EQUAL? ,PRSI ,PRSO>
		<TELL "How can you do that?" CR>)
	       (<IN? ,PRSO ,PRSI>
		<TELL CTHE ,PRSO " is already in " THE ,PRSI "." CR>)
	       (<G? <- <+ <WEIGHT ,PRSI> <WEIGHT ,PRSO>>
		       <GETP ,PRSI ,P?SIZE>>
		    <GETP ,PRSI ,P?CAPACITY>>
		<TELL "There's no room." CR>)
	       (<AND <NOT <HELD? ,PRSO>>
		     <FSET? ,PRSO ,TRYTAKEBIT>>
		<TELL "You don't have " THE ,PRSO "." CR>
		<RTRUE>)
	       (<AND <NOT <HELD? ,PRSO>>
		     <NOT <ITAKE>>>
		<RTRUE>)
	       (T
		<MOVE ,PRSO ,PRSI>
		<FSET ,PRSO ,TOUCHBIT>
		<SCORE-OBJ ,PRSO>
		<TELL "Done." CR>)>>

<ROUTINE V-PUT-BEHIND ()
	 <TELL "That hiding place is too obvious." CR>>

<ROUTINE V-PUT-ON ()
	 <COND (<EQUAL? ,PRSI ,GROUND>
		<PERFORM ,V?DROP ,PRSO>
		<RTRUE>)
	       (<FSET? ,PRSI ,SURFACEBIT>
		<V-PUT>)
	       (T
		<TELL "There's no good surface on " THE ,PRSI "." CR>)>>

<ROUTINE V-PUT-UNDER ()
	 <TELL "You can't do that." CR>>

<ROUTINE PRE-READ ()
	 <COND (<NOT ,LIT>
		<TELL "It is impossible to read in the dark." CR>)
	       (<AND ,PRSI <NOT <FSET? ,PRSI ,TRANSBIT>>>
		<TELL "How does one look through " A ,PRSI "?" CR>)>>

<ROUTINE V-READ ()
	 <COND (<NOT <FSET? ,PRSO ,READBIT>>
		<TELL "How does one read " A ,PRSO "?" CR>)
	       (T
		<TELL <GETP ,PRSO ,P?TEXT> CR>)>>

<ROUTINE V-REPLY ()
	 <TELL "It is hardly likely that " THE ,PRSO " is interested." CR>
	 <SETG P-CONT <>>
	 <SETG QUOTE-FLAG <>>
	 <RTRUE>>

<ROUTINE V-RING ()
	 <TELL "How, exactly, can you ring that?" CR>>

<ROUTINE V-RUB () <HACK-HACK "Fiddling with the ">>

<ROUTINE V-SAY ("AUX" V)
	 <COND (<NOT ,P-CONT>
		<TELL "Say what?" CR>
		<RTRUE>)>
	 <SETG QUOTE-FLAG <>>
	 <COND (<SET V <FIND-IN ,HERE ,ACTORBIT>>
		<TELL "You must address " THE .V " directly." CR>
		<SETG P-CONT <>>)
	       (<NOT <EQUAL? <GET ,P-LEXV ,P-CONT> ,W?HELLO>>
	        <SETG P-CONT <>>
		<TELL
"Talking to yourself is a sign of impending mental collapse." CR>)>
	 <RTRUE>>

<ROUTINE V-SEARCH ()
	 <TELL "You find nothing unusual." CR>>

<ROUTINE PRE-SGIVE ()
	 <PERFORM ,V?GIVE ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE V-SGIVE ()
	 <TELL "Foo!" CR>>

<ROUTINE V-SHAKE ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<TELL "This seems to have no effect." CR>)
	       (<NOT <FSET? ,PRSO ,TAKEBIT>>
		<TELL "You can't take it; thus, you can't shake it!" CR>)
	       (<FSET? ,PRSO ,CONTBIT>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <COND (<FIRST? ,PRSO>
			      <SHAKE-LOOP>
			      <TELL "The contents of the " D, PRSO " spill ">
	                      <COND (<NOT <FSET? ,HERE ,RLANDBIT>>
		                     <TELL "out and disappear">)
	                            (T
		                     <TELL "to the ground">)>
	                      <TELL "." CR>)
			     (T
			      <TELL "Shaken." CR>)>)
		      (T
		       <COND (<FIRST? ,PRSO>
			      <TELL
"It sounds like there is something inside " THE ,PRSO "." CR>)
			     (T
			      <TELL "The " D, PRSO <AGREE ,PRSO " sounds" " sound">
				    " empty." CR>)>)>)
	       (T
		<TELL "Shaken." CR>)>>

<GLOBAL WHEEEEE
	<LTABLE 0 "You jump on the spot."
	       "You hop up and down."
	       "You jump, and land where you started.">>

<ROUTINE V-SMELL ()
	 <TELL "It smells like " A ,PRSO "." CR>>

<ROUTINE V-SQUEEZE ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<TELL CTHE ,PRSO " does not understand this.">)
	       (T
		<TELL "How singularly useless.">)>
	 <CRLF>>

<ROUTINE V-STAND ()
	 <COND (<FSET? <LOC ,WINNER> ,VEHBIT>
		<PERFORM ,V?DISEMBARK <LOC ,WINNER>>
		<RTRUE>)
	       (T
		<TELL "You are already standing, I think." CR>)>>

<ROUTINE V-SWIM ()
	 <TELL "Go jump in a lake!" CR>>

<ROUTINE PRE-TAKE ()
	 <COND (<IN? ,PRSO ,WINNER>
		<COND (<FSET? ,PRSO ,WEARBIT>
		       <TELL "You are already wearing it." CR>)
		      (T
		       <TELL "You already have that!" CR>)>)
	       (<AND <FSET? <LOC ,PRSO> ,CONTBIT>
		     <NOT <FSET? <LOC ,PRSO> ,OPENBIT>>>
		<TELL
"You can't reach something that's inside a closed container." CR>
		<RTRUE>)
	       (,PRSI
		<COND (<EQUAL? ,PRSI ,GROUND>
		       <SETG PRSI <>>
		       <RFALSE>)>
		<COND (<NOT <EQUAL? ,PRSI <LOC ,PRSO>>>
		       <TELL CTHE ,PRSO " isn't in " THE ,PRSI "." CR>)
		      (T
		       <SETG PRSI <>>
		       <RFALSE>)>)
	       (<EQUAL? ,PRSO <LOC ,WINNER>>
		<TELL "You're inside of it!" CR>)>>

<ROUTINE V-TAKE ()
	 <COND (<EQUAL? <ITAKE> T>
		<COND (<FSET? ,PRSO ,WEARBIT>
		       <TELL "You are now wearing " THE ,PRSO "." CR>)
		      (T
		       <TELL "Taken." CR>)>)>>

<ROUTINE V-TELL ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<COND (,P-CONT
		       <SETG WINNER ,PRSO>
		       <SETG HERE <LOC ,WINNER>>)
		      (T
		       <TELL CTHE ,PRSO " doesn't answer that." CR>)>)
	       (T
		<TELL "You can't talk to " THE ,PRSO "!" CR>
		<SETG QUOTE-FLAG <>>
		<SETG P-CONT <>>
		<RFATAL>)>>

<ROUTINE V-THROUGH ("OPTIONAL" (OBJ <>) "AUX" M)
	#DECL ((OBJ) <OR OBJECT FALSE> (M) <PRIMTYPE VECTOR>)
	<COND (<AND <FSET? ,PRSO ,DOORBIT>
		    <SET M <OTHER-SIDE ,PRSO>>>
	       <DO-WALK .M>
	       <RTRUE>)
	      (<AND <NOT .OBJ> <FSET? ,PRSO ,VEHBIT>>
	       <PERFORM ,V?BOARD ,PRSO>
	       <RTRUE>)
	      (<OR .OBJ <NOT <FSET? ,PRSO ,TAKEBIT>>>
	       <TELL
"You hit your head against " THE ,PRSO " as you attempt this feat." CR>)
	      (<IN? ,PRSO ,WINNER>
	       <TELL "That would involve quite a contortion!" CR>)
	      (T
	       <TELL <PICK-ONE ,YUKS> CR>)>>

<ROUTINE V-THROW ()
	 <COND (<IDROP>
		<COND (<EQUAL? ,PRSI ,ME>
		       <TELL CTHE ,PRSO " bounces off you and lands at your feet." CR>)
		      (<AND ,PRSI <FSET? ,PRSI ,ACTORBIT>>
		       <TELL
CTHE ,PRSI " ducks as " THE ,PRSO " flies by and crashes to the ground."
CR>)
		      (T <TELL "Thrown." CR>)>)
	       (ELSE <TELL "Huh?" CR>)>>

<ROUTINE V-TIE ()
	 <COND (<EQUAL? ,PRSI ,WINNER>
		<TELL "You can't tie anything to yourself." CR>)
	       (T
		<TELL "You can't tie " THE ,PRSO " to that." CR>)>>

;"Bare hands turn nothing but the pages of something to read."
<ROUTINE PRE-TURN ()
	 <COND (<AND <EQUAL? ,PRSI <> ,ROOMS>
		     <NOT <FSET? ,PRSO ,READBIT>>>

		<TELL "Your bare hands don't appear to be enough." CR>)
	       (<NOT <FSET? ,PRSO ,TURNBIT>>
		<TELL "You can't turn that!" CR>)>>

<ROUTINE V-TURN ()
	 <TELL "This has no effect." CR>>

<ROUTINE V-UNTIE ()
	 <TELL "This cannot be tied, so it cannot be untied!" CR>>

<ROUTINE V-WAIT ("OPTIONAL" (NUM 3))
	 <TELL "Time passes..." CR>
	 <REPEAT ()
		 <COND (<L? <SET NUM <- .NUM 1>> 0> <RETURN>)
		       (<CLOCKER> <RETURN>)>>
	 <SETG CLOCK-WAIT T>>

<ROUTINE V-WALK ("AUX" PT PTS STR OBJ RM)
	 <COND (<NOT ,P-WALK-DIR>
		<PERFORM ,V?WALK-TO ,PRSO>
		<RTRUE>)
	       (<SET PT <GETPT ,HERE ,PRSO>>
		<COND (<EQUAL? <SET PTS <PTSIZE .PT>> ,UEXIT>
		       <GOTO <GETB .PT ,REXIT>>)
		      (<EQUAL? .PTS ,NEXIT>
		       <TELL <GET .PT ,NEXITSTR> CR>
		       <RFATAL>)
		      (<EQUAL? .PTS ,FEXIT>
		       <COND (<SET RM <APPLY <GET .PT ,FEXITFCN>>>
			      <GOTO .RM>)
			     (T
			      <RFATAL>)>)
		      (<EQUAL? .PTS ,CEXIT>
		       <COND (<VALUE <GETB .PT ,CEXITFLAG>>
			      <GOTO <GETB .PT ,REXIT>>)
			     (<SET STR <GET .PT ,CEXITSTR>>
			      <TELL .STR CR>
			      <RFATAL>)
			     (T
			      <TELL "You can't go that way." CR>
			      <RFATAL>)>)
		      (<EQUAL? .PTS ,DEXIT>
		       <COND (<FSET? <SET OBJ <GETB .PT ,DEXITOBJ>> ,OPENBIT>
			      <GOTO <GETB .PT ,REXIT>>)
			     (<SET STR <GET .PT ,DEXITSTR>>
			      <TELL .STR CR>
			      <RFATAL>)
			     (T
			      <TELL CTHE .OBJ " is closed." CR>
			      <THIS-IS-IT .OBJ>
			      <RFATAL>)>)>)
	       (<AND <NOT ,LIT>
		     <PROB 80>
		     <EQUAL? ,WINNER ,ADVENTURER>
		     <NOT <FSET? ,HERE ,NONLANDBIT>>>
		<COND (,SPRAYED?
		       <TELL
"There are odd noises in the darkness, and there is no exit in that
direction." CR>
		       <RFATAL>)
		      (T
		       <JIGS-UP
"Oh, no! You have walked into the slavering fangs of a lurking grue!">)>)
	       (T
		<TELL "You can't go that way." CR>
		<RFATAL>)>>

<ROUTINE V-WALK-AROUND ()
	 <TELL "Use compass directions for movement." CR>>

<ROUTINE V-WALK-TO ()
	 <COND (<AND ,PRSO
		     <OR <IN? ,PRSO ,HERE>
			 <GLOBAL-IN? ,PRSO ,HERE>>>
		<TELL "It's here!" CR>)
	       (T
		<TELL "You should supply a direction!" CR>)>>

<ROUTINE V-WAVE ()
	 <HACK-HACK "Waving the ">>

<ROUTINE V-WEAR ()
	 <COND (<NOT <FSET? ,PRSO ,WEARBIT>>
		<TELL "You can't wear " THE ,PRSO "." CR>)
	       (T
		<PERFORM ,V?TAKE ,PRSO>
		<RTRUE>)>>

<ROUTINE V-YELL () <TELL "Aaaarrrrgggghhhh!" CR>>

^L

"Verb-Associated Routines"

"Descriptions"

<ROUTINE DESCRIBE-ROOM ("OPTIONAL" (LOOK? <>) "AUX" V? STR AV)
	 <SET V? <OR .LOOK? ,VERBOSE>>
	 <COND (<NOT ,LIT>
		<TELL "It is pitch black.">
		<COND (<NOT ,SPRAYED?>
		       <TELL " You are likely to be eaten by a grue.">)>
		<CRLF>
		<RFALSE>)>
	 <COND (<NOT <FSET? ,HERE ,TOUCHBIT>>
		<FSET ,HERE ,TOUCHBIT>
		<SET V? T>)>
	 <COND (<FSET? ,HERE ,MAZEBIT>
		<FCLEAR ,HERE ,TOUCHBIT>)>
	 <COND (<IN? ,HERE ,ROOMS>
		<COND (<OR <AND <NOT .LOOK?> ,SUPER-BRIEF>
			   <NOT .V?>>
		       <TELL D ,HERE>
		       <COND (<FSET? <SET AV <LOC ,WINNER>> ,VEHBIT>
			      <TELL ", in " THE .AV>)>
		       <CRLF>)>)>
	 <COND (<OR .LOOK? <NOT ,SUPER-BRIEF>>
		<SET AV <LOC ,WINNER>>
		;<COND (<FSET? .AV ,VEHBIT>
		       <TELL "(You are in " THE .AV ".)" CR>)>
		<COND (<AND .V? <APPLY <GETP ,HERE ,P?ACTION> ,M-LOOK>>
		       <RTRUE>)
		      (<AND .V? <SET STR <GETP ,HERE ,P?LDESC>>>
		       <TELL .STR CR>)
		      (T
		       <APPLY <GETP ,HERE ,P?ACTION> ,M-FLASH>)>
		<COND (<AND <NOT <EQUAL? ,HERE .AV>> <FSET? .AV ,VEHBIT>>
		       <APPLY <GETP .AV ,P?ACTION> ,M-LOOK>)>)>
	 T>

<GLOBAL COMPACT-ROOM-LISTS <>>
<GLOBAL LISTING-ROOM <>>

<ROUTINE DESCRIBE-OBJECTS ("OPTIONAL" (V? <>) "AUX" PRINTED)
	 <COND (,LIT
		<COND (<FIRST? ,HERE>
		       <SETG LISTING-ROOM ,COMPACT-ROOM-LISTS>
		       <SET PRINTED <PRINT-CONT ,HERE <SET V? <OR .V? ,VERBOSE>> -1>>
		       <SETG LISTING-ROOM <>>
		       .PRINTED)>)
	       (T
		<TELL "Only bats can see in the dark. And you're not one." CR>)>>

"DESCRIBE-OBJECT -- takes object and flag.  if flag is true will print a
long description (fdesc or ldesc), otherwise will print short."

<ROUTINE DESCRIBE-OBJECT (OBJ V? LEVEL "AUX" (STR <>) AV)
	 <SETG DESC-OBJECT .OBJ>
	 <COND (<AND <0? .LEVEL>
		     <APPLY <GETP .OBJ ,P?DESCFCN> ,M-OBJDESC>>
		<RTRUE>)
	       (<AND <0? .LEVEL>
		     <OR <AND <NOT <FSET? .OBJ ,TOUCHBIT>>
			      <SET STR <GETP .OBJ ,P?FDESC>>>
			 <SET STR <GETP .OBJ ,P?LDESC>>>>
		<TELL .STR>)
	       (<0? .LEVEL>
		<TELL "There" <AGREE .OBJ " is " " are "> A .OBJ " here">
		<COND (<FSET? .OBJ ,ONBIT>
		       <TELL " (providing light)">)>
		<TELL ".">)
	       (T
		<TELL <GET ,INDENTS .LEVEL>>
		<TELL CA .OBJ>
		<COND (<FSET? .OBJ ,ONBIT>
		       <TELL " (providing light)">)
		      (<AND <FSET? .OBJ ,WEARBIT>
			    <IN? .OBJ ,WINNER>>
		       <TELL " (being worn)">)>)>
	 <COND (<AND <0? .LEVEL>
		     <SET AV <LOC ,WINNER>>
		     <FSET? .AV ,VEHBIT>>
		<TELL " (outside " THE .AV ")">)>
	 <CRLF>
	 <COND (<AND <SEE-INSIDE? .OBJ> <FIRST? .OBJ>>
		<PRINT-CONT .OBJ .V? .LEVEL>)>>

<ROUTINE PRINT-CONTENTS (OBJ "AUX" F N (1ST? T) (IT? <>) (TWO? <>))
	 <COND (<SET F <FIRST? .OBJ>>
		<REPEAT ()
			<SET N <NEXT? .F>>
			<COND (.1ST? <SET 1ST? <>>)
			      (ELSE
			       <TELL ", ">
			       <COND (<NOT .N> <TELL "and ">)>)>
			<TELL A .F>
			<COND (<AND <NOT .IT?> <NOT .TWO?>>
			       <SET IT? .F>)
			      (ELSE
			       <SET TWO? T>
			       <SET IT? <>>)>
			<SET F .N>
			<COND (<NOT .F>
			       <COND (<AND .IT? <NOT .TWO?>>
				      <THIS-IS-IT .IT?>)>
			       <RTRUE>)>>)>>

<ROUTINE LOOSE-ROOM-ITEM? (ITEM)
    <AND <FSET? .ITEM ,TOUCHBIT> <FSET? .ITEM ,TAKEBIT>
         <NOT <FSET? .ITEM ,NDESCBIT>> <NOT <FSET? .ITEM ,INVISIBLE>>
         <NOT <FSET? .ITEM ,ACTORBIT>> <NOT <GETP .ITEM ,P?DESCFCN>>
         <NOT <AND <SEE-INSIDE? .ITEM> <FIRST? .ITEM>>>>>

;"In a room overview, simple contents share one line. EXAMINE and INVENTORY
  keep their usual listings. On the floor group only previously moved objects."
<ROUTINE ROOM-ITEM-LIST (OBJ "AUX" ITEM (COUNT 0) (PRINTED 0))
    <COND (<OR <EQUAL? .OBJ ,WINNER> <FSET? .OBJ ,ACTORBIT>> <RFALSE>)>
    <SET ITEM <FIRST? .OBJ>>
    <REPEAT ()
        <COND (<NOT .ITEM> <RETURN>)
              (<EQUAL? .OBJ ,HERE>
               <COND (<LOOSE-ROOM-ITEM? .ITEM> <SET COUNT <+ .COUNT 1>>)>)
              (<FSET? .ITEM ,INVISIBLE>)
              (<OR <GETP .ITEM ,P?DESCFCN>
                   <AND <SEE-INSIDE? .ITEM> <FIRST? .ITEM>>> <RFALSE>)
              (<NOT <FSET? .ITEM ,NDESCBIT>> <SET COUNT <+ .COUNT 1>>)>
        <SET ITEM <NEXT? .ITEM>>>
    <COND (<OR <0? .COUNT> <AND <EQUAL? .OBJ ,HERE> <L? .COUNT 2>>> <RFALSE>)>
    <SET ITEM <FIRST? .OBJ>>
    <REPEAT ()
        <COND (<NOT .ITEM> <RETURN>)>
        <COND (<AND <NOT <FSET? .ITEM ,INVISIBLE>> <NOT <FSET? .ITEM ,NDESCBIT>>
                    <OR <NOT <EQUAL? .OBJ ,HERE>> <LOOSE-ROOM-ITEM? .ITEM>>>
               <SET PRINTED <+ .PRINTED 1>>
               <COND (<EQUAL? .PRINTED 1>)
                     (<EQUAL? .PRINTED .COUNT> <TELL " and ">)
                     (T <TELL ", ">)>
               <COND (<EQUAL? .PRINTED 1> <TELL CA .ITEM>)
                     (T <TELL A .ITEM>)>
               <COND (<FSET? .ITEM ,ONBIT> <TELL " (lit)">)>)>
        <SET ITEM <NEXT? .ITEM>>>
    <COND (<EQUAL? .OBJ ,HERE> <TELL " lie here." CR>)
          (T <COND (<EQUAL? .COUNT 1> <TELL " is ">) (T <TELL " are ">)>
             <COND (<FSET? .OBJ ,SURFACEBIT> <TELL "on">) (T <TELL "in">)>
             <TELL " " THE .OBJ "." CR>)>
    <RTRUE>>

<ROUTINE PRINT-CONT (OBJ "OPTIONAL" (V? <>) (LEVEL 0)
		     "AUX" Y 1ST? SHIT AV STR (PV? <>) (INV? <>) (GROUPED <>))
	 <COND (,LISTING-ROOM
		<SET GROUPED <ROOM-ITEM-LIST .OBJ>>
		<COND (<AND .GROUPED <NOT <EQUAL? .OBJ ,HERE>>> <RTRUE>)>)>
	 <COND (<NOT <SET Y <FIRST? .OBJ>>> <RTRUE>)>
	 <COND (<AND <SET AV <LOC ,WINNER>> <FSET? .AV ,VEHBIT>>
		T)
	       (ELSE <SET AV <>>)>
	 <SET 1ST? T>
	 <SET SHIT T>
	 <COND (<EQUAL? ,WINNER .OBJ <LOC .OBJ>>
		<SET INV? T>)
	       (ELSE
		<REPEAT ()
			<COND (<NOT .Y>
			       <RETURN>)
			      (<EQUAL? .Y .AV> <SET PV? T>)
			      (<EQUAL? .Y ,WINNER>)
			      (<AND <NOT <FSET? .Y ,INVISIBLE>>
				    <NOT <FSET? .Y ,TOUCHBIT>>
				    <SET STR <GETP .Y ,P?FDESC>>>
			       <COND (<NOT <FSET? .Y ,NDESCBIT>>
				      <TELL .STR CR>
				      <SET SHIT <>>
				      ;<SET 1ST? <>>)>
			       <COND (<AND <SEE-INSIDE? .Y>
					   <NOT <GETP <LOC .Y> ,P?DESCFCN>>
					   <FIRST? .Y>>
				      <COND (<PRINT-CONT .Y .V? 0>
					     <SET 1ST? <>>)>)>)>
			<SET Y <NEXT? .Y>>>)>
	 <SET Y <FIRST? .OBJ>>
	 <REPEAT ()
		 <COND (<NOT .Y>
			<COND (<AND .PV? .AV <FIRST? .AV>>
			       <SET LEVEL <+ .LEVEL 1>>
			       <PRINT-CONT .AV .V? .LEVEL>)>
			<RETURN>)
		       (<EQUAL? .Y .AV ,ADVENTURER>)
		       (<AND .GROUPED <LOOSE-ROOM-ITEM? .Y>>)
		       (<AND <NOT <FSET? .Y ,INVISIBLE>>
			     <OR .INV?
				 <FSET? .Y ,TOUCHBIT>
				 <NOT <GETP .Y ,P?FDESC>>>>
			<COND (<NOT <FSET? .Y ,NDESCBIT>>
			       <COND (.1ST?
				      <COND (<FIRSTER .OBJ .LEVEL>
					     <COND (<L? .LEVEL 0>
						    <SET LEVEL 0>)>)>
				      <SET LEVEL <+ 1 .LEVEL>>
				      <SET 1ST? <>>)>
			       <COND (<L? .LEVEL 0> <SET LEVEL 0>)>
			       <DESCRIBE-OBJECT .Y .V? .LEVEL>)
			      (<AND <FIRST? .Y> <SEE-INSIDE? .Y>>
			       <SET LEVEL <+ .LEVEL 1>>
			       <PRINT-CONT .Y .V? .LEVEL>
			       <SET LEVEL <- .LEVEL 1>>)>)>
		 <SET Y <NEXT? .Y>>>
	 <COND (<AND .1ST? .SHIT <NOT .GROUPED>> <RFALSE>) (T <RTRUE>)>>

<ROUTINE FIRSTER (OBJ LEVEL)
	 <COND (<EQUAL? .OBJ ,WINNER>
		<TELL "You are carrying:" CR>)
	       (<NOT <IN? .OBJ ,ROOMS>>
		<COND (<G? .LEVEL 0>
		       <TELL <GET ,INDENTS .LEVEL>>)>
		<COND (<FSET? .OBJ ,SURFACEBIT>
		       <TELL "Sitting on " THE .OBJ " is: " CR>)
		      (<FSET? .OBJ ,ACTORBIT>
		       <TELL CTHE .OBJ <AGREE .OBJ " is" " are"> " holding: " CR>)
		      (T
		       <TELL CTHE .OBJ <AGREE .OBJ " contains:" " contain:"> CR>)>)>>

"Scoring"

<ROUTINE YES? ()
	 <PRINTI ">">
	 <READ ,P-INBUF ,P-LEXV>
	 <COND (<EQUAL? <GET ,P-LEXV 1> ,W?YES ,W?Y>
		<RTRUE>)
	       (T
		<RFALSE>)>>

"Death"

;"JIGS-UP is in ACTIONS.ZIL"

;"RANDOMIZE-OBJECTS is in ACTIONS.ZIL"

;"KILL-INTERRUPTS is in ACTIONS.ZIL"

"Object Manipulation"

<ROUTINE ITAKE ("OPTIONAL" (VB T) "AUX" CNT OBJ)
	 #DECL ((VB) <OR ATOM FALSE> (CNT) FIX (OBJ) OBJECT)
	 <COND (,DEAD
		<COND (.VB
		       <TELL
"Your hand passes through its object." CR>)>
		<RFALSE>)
	       (<NOT <FSET? ,PRSO ,TAKEBIT>>
		<COND (.VB
		       <TELL <PICK-ONE ,YUKS> CR>)>
		<RFALSE>)
	       (<AND <FSET? <LOC ,PRSO> ,CONTBIT>
		     <NOT <FSET? <LOC ,PRSO> ,OPENBIT>>>
		;"Kludge for parser calling itake"
		<RFALSE>)
	       (<AND <NOT <IN? <LOC ,PRSO> ,WINNER>>
		     <G? <+ <WEIGHT ,PRSO> <WEIGHT ,WINNER>> ,LOAD-ALLOWED>>
		<COND (.VB
		       <TELL "Your load is too heavy">
		       <COND (<L? ,LOAD-ALLOWED ,LOAD-MAX>
			      <TELL", especially in light of your condition.">)
			     (T
			      <TELL ".">)>
		       <CRLF>)>
		<RFATAL>)
	       (<AND <VERB? TAKE>
		     <G? <SET CNT <CCOUNT ,WINNER>> ,FUMBLE-NUMBER>
		     <PROB <* .CNT ,FUMBLE-PROB>>>
		<TELL
"You're holding too many things already!" CR>
		<RFALSE>)
	       (T
		<MOVE ,PRSO ,WINNER>
		<FCLEAR ,PRSO ,NDESCBIT>
		<FSET ,PRSO ,TOUCHBIT>
		<SCORE-OBJ ,PRSO>
		<RTRUE>)>>

<ROUTINE IDROP ()
	 <COND (<AND <NOT <IN? ,PRSO ,WINNER>>
		     <NOT <IN? <LOC ,PRSO> ,WINNER>>>
		<TELL "You're not carrying " THE ,PRSO "." CR>
		<RFALSE>)
	       (<AND <NOT <IN? ,PRSO ,WINNER>>
		     <NOT <FSET? <LOC ,PRSO> ,OPENBIT>>>
		<TELL CTHE ,PRSO " is closed." CR>
		<RFALSE>)
	       (T
		<MOVE ,PRSO <LOC ,WINNER>>
		<RTRUE>)>>

"Miscellaneous"

<CONSTANT UEXIT 1>
<CONSTANT NEXIT 2>
<CONSTANT FEXIT 3>
<CONSTANT CEXIT 4>
<CONSTANT DEXIT 5>

<CONSTANT CEXITFLAG 1>
<CONSTANT DEXITSTR 1>

<ROUTINE HACK-HACK (STR)
	 <COND (<AND <IN? ,PRSO ,GLOBAL-OBJECTS>
		     <VERB? WAVE RAISE LOWER>>
		<TELL CTHE ,PRSO " isn't here!" CR>)
	       (T
		<TELL .STR D ,PRSO <PICK-ONE ,HO-HUM> CR>)>>

<GLOBAL HO-HUM
	<LTABLE
	 0
	 " doesn't seem to work."
	 " isn't notably helpful."
	 " has no effect.">>

<ROUTINE NO-GO-TELL (AV WLOC)
	 <COND (.AV
		<TELL "You can't go there in " A .WLOC ".">)
	       (T
		<TELL "You can't go there without a vehicle.">)>
	 <CRLF>>

<ROUTINE GOTO (RM "OPTIONAL" (V? T)
	       "AUX" (LB <FSET? .RM ,RLANDBIT>) (WLOC <LOC ,WINNER>)
	             (AV <>) OLIT OHERE)
	 <SET OLIT ,LIT>
	 <SET OHERE ,HERE>
	 <COND (<FSET? .WLOC ,VEHBIT>
		<SET AV <GETP .WLOC ,P?VTYPE>>)>
	 <COND (<AND <NOT .LB>
		     <NOT .AV>>
		<NO-GO-TELL .AV .WLOC>
		<RFALSE>)
	       (<AND <NOT .LB>
		     <NOT <FSET? .RM .AV>>>
		<NO-GO-TELL .AV .WLOC>
		<RFALSE>)
	       (<AND <FSET? ,HERE ,RLANDBIT>
		     .LB
		     .AV
		     <NOT <EQUAL? .AV ,RLANDBIT>>
		     <NOT <FSET? .RM .AV>>>
		<NO-GO-TELL .AV .WLOC>
		<RFALSE>)
	       (<FSET? .RM ,RMUNGBIT>
		<TELL <GETP .RM ,P?LDESC> CR>
		<RFALSE>)
	       (T
		<COND (<AND .LB
			    <NOT <FSET? ,HERE ,RLANDBIT>>
			    <NOT ,DEAD>
			    <FSET? .WLOC ,VEHBIT>>
		       <TELL
CTHE .WLOC " comes to a rest on the shore." CR CR>)>
		<COND (.AV
		       <MOVE .WLOC .RM>)
		      (T
		       <MOVE ,WINNER .RM>)>
		<SETG HERE .RM>
		<SETG LIT <LIT? ,HERE>>
		<COND (<AND <NOT .OLIT>
			    <NOT ,LIT>
			    <PROB 80>>
		       <COND (,SPRAYED?
			      <TELL
"There are sinister gurgling noises in the darkness all around you!" CR>)
			     (T
			      <TELL
"Oh, no! A lurking grue slithered into the ">
			      <COND (<FSET? <LOC ,WINNER> ,VEHBIT>
				     <TELL D <LOC ,WINNER>>)
				    (T <TELL "room">)>
			      <JIGS-UP " and devoured you!">
			      <RTRUE>)>)>
		<COND (<AND <NOT ,LIT>
			    <EQUAL? ,WINNER ,ADVENTURER>>
		       <TELL "You have moved into a dark place." CR>
		       <SETG P-CONT <>>)>
		<APPLY <GETP ,HERE ,P?ACTION> ,M-ENTER>
		<SCORE-OBJ .RM>
		<COND (<NOT <EQUAL? ,HERE .RM>> <RTRUE>)
		      (<AND <NOT <EQUAL? ,ADVENTURER ,WINNER>>
			    <IN? ,ADVENTURER .OHERE>>
		       <TELL CTHE ,WINNER " leaves the room." CR>)
		      (<AND .V?

			    <EQUAL? ,WINNER ,ADVENTURER>>
		       <V-FIRST-LOOK>)>
		<RTRUE>)>>

<ROUTINE OTHER-SIDE (DOBJ "AUX" (P 0) TX) ;"finds room beyond given door"
	 <REPEAT ()
		 <SET P <NEXTP ,HERE .P>>
		 <COND (<OR <ZERO? .P> <L? .P ,LOW-DIRECTION>>
			<RETURN <>>)
		       (ELSE
			<SET TX <GETPT ,HERE .P>>
			<COND (<AND <EQUAL? <PTSIZE .TX> ,DEXIT>
				    <EQUAL? <GETB .TX ,DEXITOBJ> .DOBJ>>
			       <RETURN .P>)>)>>>

<ROUTINE THIS-IS-IT (OBJ)
	 <SETG P-IT-OBJECT .OBJ>>

<GLOBAL HELLOS
	<LTABLE 0 "Hello."
	       "Good day."
	       "Nice weather we've been having lately."
	       "Goodbye.">>

<GLOBAL YUKS
	<LTABLE
	 0
	 "A valiant attempt."
	 "You can't be serious."
	 ;"Not bloody likely."
	 "An interesting idea..."
	 "What a concept!">>

