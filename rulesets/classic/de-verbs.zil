;"German classic rules: Zork's combat, magic, treasure and puzzle verbs, with
  their German text. rulesets/classic/de.zil composes them over languages/de/base.zil.
  (c) Copyright 1983 Infocom, Inc. See LICENSE-ZORK-MIT."

<ROUTINE V-$ID ()
	 <TELL "Interpreter ">
	 <PRINTN <GETB 0 30>>
	 <TELL " Version ">
	 <PRINTC <GETB 0 31>>
	 <CRLF>
	 <RTRUE>>

;"Real Verb Functions"

<ROUTINE V-ADVENT ()
	 <TELL "A hollow voice says %>Fool%<." CR>>

<ROUTINE V-ALARM ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<COND (<L? <GETP ,PRSO ,P?STRENGTH> 0>
		       <TELL
DER-NOM-CAP ,PRSO " wird grob geweckt." CR>
		       <AWAKEN ,PRSO>)
		      (T
		       <TELL
DER-NOM-CAP ,PRSO " ist schon wach, falls du das noch nicht gemerkt
hast." CR>)>)
	       (<EQUAL? ,PRSO ,ROOMS>
		<PERFORM ,V?ALARM ,ME>
		<RTRUE>)
	       (T
		<TELL DER-NOM-CAP ,PRSO " schl%aft nicht!" CR>)>>

<ROUTINE V-BACK ()
	 <TELL "Sorry, my memory is poor. Please give a direction." CR>>

<ROUTINE V-BLAST ()
	 <TELL "You can't blast anything by using words." CR>>

<ROUTINE V-BRUSH ()
	 <TELL "Wenn du willst, aber um Himmels Willen, warum?" CR>>

<ROUTINE TELL-NO-PRSI ()
	 <TELL "Du hast nicht gesagt mit was!" CR>>

<ROUTINE PRE-BURN ()
	 <COND (<NOT ,PRSI>
		<TELL-NO-PRSI>)
	       (<FLAMING? ,PRSI>
	        <RFALSE>)
	       (T
	        <TELL "Mit " EIN-DAT ,PRSI " etwa?!?" CR>)>>

<ROUTINE V-BURN ()
	 <COND (<FSET? ,PRSO ,BURNBIT>
		<COND (<OR <IN? ,PRSO ,WINNER>
			   <IN? ,WINNER ,PRSO>>
		       <REMOVE-CAREFULLY ,PRSO>
		       <TELL
DER-NOM-CAP ,PRSO " f%angt Feuer. Dummerweise ">
		       <COND (<IN? ,WINNER ,PRSO>
			      <TELL "warst du gerade darin">)
			     (T <TELL "hast du ihn gerade festgehalten">)>
		       <TELL ".">)
		      (T
		       <REMOVE-CAREFULLY ,PRSO>
		       <TELL
DER-NOM-CAP ,PRSO " f%angt Feuer und verbrennt." CR>)>)
	       (T
		<TELL "Du kannst " EIN-ACC ,PRSO " nicht verbrennen." CR>)>>

<ROUTINE V-CHOMP ()
	 <TELL "Preposterous!" CR>>

<ROUTINE V-COUNT ()
	 ;<COND (<EQUAL? ,PRSO ,BLESSINGS>
	 	<TELL "Vergi%s nicht, du spielst Zork." CR>)>
	 <TELL "Du bist verr%uckt." CR>>

<ROUTINE V-CROSS ()
	 <TELL "Hier kannst du nicht %uberqueren." CR>>

<ROUTINE V-CURSES ()
	 <COND (,PRSO
		<COND (<FSET? ,PRSO ,ACTORBIT>
		       <TELL
"Auf Unh%oflichkeiten dieser Art pflegen wir nicht zu reagieren." CR>)
		      (T
		       <TELL "Was?!" CR>)>)
	       (T
		<TELL
"Wir benutzen gew%ohnlich eine gepflegtere Sprache." CR>)>>

<ROUTINE V-CUT ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<PERFORM ,V?ATTACK ,PRSO ,PRSI>)
	       (<AND <FSET? ,PRSO ,BURNBIT>
		     <FSET? ,PRSI ,WEAPONBIT>>
		<COND (<IN? ,WINNER ,PRSO>
		       ;<TELL
"Not a bright idea, especially since you're in " PRONOUN-ACC ,PRSO "." CR>
		       <TELL
"Nicht die kl%ugste Idee, denn du bist drin." CR>
		       <RTRUE>)>
		<REMOVE-CAREFULLY ,PRSO>
		<TELL
"Nicht die kl%ugste Idee, denn du bist drin. Deine raffinierte Navigation zermalmt " DER-ACC ,PRSO " in unz%ahlbare Splitter, die wegfliegen." CR>)
	       (<NOT <FSET? ,PRSI ,WEAPONBIT>>
		;<TELL
"The %>cutting edge%< of " D ,PRSI " is hardly adequate." CR>
		<TELL "Die scharfen Kanten haben keinen Schneid." CR>)
	       (T
		<TELL
"Eine eigenartige Idee, " DER-ACC ,PRSO " zu zerschneiden." CR>)>>

<ROUTINE V-DEFLATE ()
	 <COND (<AND <PRSO? ,LUNGS> ;"air"
		     <ACCESSIBLE? ,INFLATED-BOAT>>
		<PERFORM ,V?DEFLATE ,INFLATED-BOAT>
		<RTRUE>)
	       (T
	        <TELL "So ein Quatsch!" CR>)>>

<ROUTINE V-DIG-WITH ()
	 <PERFORM ,V?DIG ,GROUND ,SHOVEL>
	 <RTRUE>>

<ROUTINE V-ECHO ("AUX" LST MAX (ECH 0) CNT)
	 #DECL ((LST) <PRIMTYPE VECTOR> (MAX CNT ECH) FIX)
	 <COND (<G? <GET ;B ,P-LEXV ,P-LEXWORDS> 0>
		<SET LST <REST
			  ,P-LEXV
			  <* <GET ,P-LEXV ,P-LEXWORDS> ,P-WORDLEN>>>
		<SET MAX <- <+ <GET ;B .LST 0> <GET ;B .LST 1>> 1>>
		<REPEAT ()
		   <COND (<G? <SET ECH <+ .ECH 1>> 2>
			  <TELL "..." CR>
			  <RETURN>)
			 (T
			  <SET CNT <- <GET ;B .LST 1> 1>>
			  <REPEAT ()
			     <COND (<G? <SET CNT <+ .CNT 1>> .MAX>
				    <RETURN>)
				   (T
				    <PRINTC <GET ;B ,P-INBUF .CNT>>)>>
			  <TELL " ">)>>)
	       (T <TELL "Echo Echo ..." CR>)>>

<ROUTINE V-EXORCISE ()
	 <TELL "Was f%ur eine Schnappsidee!" CR>>

<ROUTINE V-FROBOZZ ()
	 <TELL
"Die FROBOZZ FIRMA gr%undete, besitzt und leitet diesen Kerker." CR>>

<ROUTINE V-HATCH ()
	 <TELL "Bizarre!" CR>>

<ROUTINE V-HINTS-OFF ()
	 <TELL "Tips sind f%uer diese Runde abgestellt." CR>
	 <SETG HINTS-OFF T>>

<ROUTINE V-INFLATE ()
	 <COND (<AND <ACCESSIBLE? ,PUMP>
		     <OR <PRSO? ,INFLATED-BOAT>
			 <PRSO? ,INFLATABLE-BOAT>
			 <PRSO? ,PUNCTURED-BOAT>>>
		<TELL "(mit " DER-DAT ,PUMP ")" CR CR>
		<PERFORM ,V?INFLATE ,PRSO ,PUMP>
		<RTRUE>)
	       (T
		<TELL "Wie willst du das denn aufblasen?" CR>)>>

<ROUTINE V-KICK ()
	 <TELL
DER-ACC-CAP ,PRSO " mit dem Fu%s treten, scheint nicht zu funktionieren." CR>>

<ROUTINE V-LAUNCH ()
	 <COND (<FSET? ,PRSO ,VEHBIT>
		;<TELL "You can't launch that by saying %>launch%<!" CR>
		<TELL
"Du kannst das nicht absto%sen, in dem du %>Absto%sen%<
sagst.">)
	       (T
		<TELL "Das ist ziemlich absurd." CR>)>>

<ROUTINE V-LEAVE ()
	 <COND (<PRSO? ,ROOMS>
		<DO-WALK ,P?RAUS>)
	       (T
		<PERFORM ,V?DROP ,PRSO>
		<RTRUE>)>>

<ROUTINE V-MAKE ()
    	<TELL "Das kannst du nicht." CR>>

<ROUTINE V-MELT ()
	 <TELL
"Es ist nicht gesagt, da%s man " EIN-NOM ,PRSO " schmelzen kann." CR>>

<ROUTINE V-MUMBLE ()
	 <TELL "You'll have to speak up if you expect me to hear you!" CR>>

<ROUTINE PRE-MUNG ()
	 <COND (<OR <NOT ,PRSI>
		    <NOT <FSET? ,PRSI ,WEAPONBIT>>>
		;<TELL "Trying to destroy " DER-ACC ,PRSO " with ">
		<TELL "Es ist sinnlos, " DER-ACC ,PRSO " mit ">
		<COND (<NOT ,PRSI>
		       <TELL "blo%sen F%austen">)
		      (T
		       <TELL EIN-DAT ,PRSI>)>
		<TELL " zerst%oren zu wollen." CR>)>>

<ROUTINE V-ODYSSEUS ()
	 <COND (<AND <EQUAL? ,HERE ,CYCLOPS-ROOM>
		     <IN? ,CYCLOPS ,HERE>
		     <NOT ,CYCLOPS-FLAG>>
		<DISABLE <INT I-CYCLOPS>>
		<SETG CYCLOPS-FLAG T>
		<TELL
"Als der Zyklop von der t%odlichen Strafe seines Vaters h%ort, entflieht er aus dem Zimmer, indem er die Ostwand des Zimmers niederrennt." CR>
	       <SETG MAGIC-FLAG T>
	       <FCLEAR ,CYCLOPS ,FIGHTBIT>
	       <REMOVE-CAREFULLY ,CYCLOPS>)
	       (T
		<TELL "War er nicht ein Seemann?" CR>)>>

<ROUTINE V-OIL ()
	 <TELL "Du bist wohl auch so einer, der Spinat ins Auto tankt?" CR>>

<ROUTINE V-OVERBOARD ("AUX" LOCN)
	 <COND (<EQUAL? ,PRSI ,TEETH>
		<COND (<FSET? <SET LOCN <LOC ,WINNER>> ,VEHBIT>
		       <MOVE ,PRSO <LOC .LOCN>>
		       <TELL "Ahoy -- " D ,PRSO " %uber Bord!" CR>)
		      (T
		       <TELL "You're not in anything!" CR>)>)
	       (<FSET? <LOC ,WINNER> ,VEHBIT>
		<PERFORM ,V?THROW ,PRSO>
		<RTRUE>)
	       (T
		<TELL "Huh?" CR>)>>

<ROUTINE V-PICK () <TELL "Das kannst du nicht knacken." CR>>

<ROUTINE V-PLAY ()
    <COND (<FSET? ,PRSO ,ACTORBIT>
	   <TELL
"Du spielst die Rolle so echt, da%s du dich selber umbringst, genau wie er es h%atte tun k%onnen." CR>
	   <JIGS-UP "">)
	  (ELSE <TELL "Das ist bl%od." CR>)>>

<ROUTINE V-PLUG ()
	 <TELL "Erfolglos." CR>>

<ROUTINE V-PRAY ()
	 <COND (<EQUAL? ,HERE ,SOUTH-TEMPLE>
		<GOTO ,FOREST-1>)
	       (T
		<TELL
"Wenn du gen%ugend betest, dann werden deine Gebete vielleicht erh%ort." CR>)>>

<ROUTINE V-PUMP ()
	 <COND (<AND ,PRSI <NOT <EQUAL? ,PRSI ,PUMP>>>
		<TELL
"Pump" PRONOUN-ACC ,PRSO " up with " EIN-DAT ,PRSI "?" CR>)
	       (<IN? ,PUMP ,WINNER>
		<PERFORM ,V?INFLATE ,PRSO ,PUMP>)
	       (T
		<TELL "It's really not clear how." CR>)>>

<ROUTINE V-REPENT ()
	 <TELL "Es k%onnte m%oglicherweise schon zu sp%at sein." CR>>

<ROUTINE V-SEND ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<TELL "Warum w%urdest du " DER-ACC ,PRSO " rufen lassen?" CR>)
	       (T
		<TELL "Das ist Unsinn." CR>)>>

<GLOBAL WHEEEEE
	<LTABLE 0 "Ausgezeichnet. Du bist in die 4. Klasse versetzt!"
		  "Macht's dir Spa%s?"
		  "Jaaaaaaaaaa!!!!!"
		  "Soll ich etwa Beifall klatschen?">>

<ROUTINE V-SPIN ()
	 <TELL "Den kannst du nicht rumwirbeln!" CR>>

<ROUTINE V-STAB ("AUX" W)
	 <COND (<SET W <FIND-WEAPON ,WINNER>>
		<PERFORM ,V?ATTACK ,PRSO .W>
		<RTRUE>)
	       (T
		<TELL
"Du hast wohl vor, " DER-ACC ,PRSO " mit dem kleinen Finger zu
erdolchen." CR>)>>

<ROUTINE V-STAY ()
	 <TELL "Du r%uhrst dich nicht." CR>>

<ROUTINE V-SWING ()
	 <COND (<NOT ,PRSI>
		<TELL "Huiiii!" CR>)
	       (T
		<PERFORM ,V?ATTACK ,PRSI ,PRSO>
		<RTRUE>)>>

<ROUTINE V-TEST-IT ("AUX" (NUM 1))
	 <TELL "Da%s ich zu sp%at komme." CR>
	 <TELL "%Offne den %Ubermensch. %Apfel sind sch%on." CR>
	 <TELL "Er sagt, %>Und %uber den Mann.%<" CR CR>
	 <REPEAT ()
		 <COND (<AND <NOT <IN? .NUM ,ROOMS>>
			     <NOT <EQUAL? .NUM ,ROOMS>>
			     <OR <FSET? .NUM ,DERBIT>
				 <FSET? .NUM ,DASBIT>
				 <FSET? .NUM ,DIEBIT>>>
			<TELL DER-NOM-CAP .NUM " ist gut." CR>)
		       (<AND <NOT <IN? .NUM ,ROOMS>>
			     <NOT <EQUAL? .NUM ,ROOMS>>>
			<TELL "No Gender: " D .NUM CR>)>
		 <COND (<G? .NUM ,LAST-OBJECT>
		        <RETURN>)
		       (T
			<SET NUM <+ .NUM 1>>)>>
	 <TELL CR "End of test." CR>
	 <RTRUE>>

<ROUTINE V-THROW-OFF ()
	 <TELL "Von dort kann man nichts runterwerfen!" CR>>

<ROUTINE V-TIE-UP ()
	 <TELL
DER-ACC-CAP ,PRSO " kannst du damit bestimmt nicht fesseln!" CR>>

<ROUTINE V-TREASURE ()
	 <COND (<EQUAL? ,HERE ,NORTH-TEMPLE>
		<GOTO ,TREASURE-ROOM>)
	       (<EQUAL? ,HERE ,TREASURE-ROOM>
		<GOTO ,NORTH-TEMPLE>)
	       (T
		<TELL "Hier passiert garnichts." CR>)>>

<ROUTINE V-WIN ()
	 <TELL "Logo! Klar!" CR>>

<ROUTINE V-WIND ()
	 <TELL "Du kannst " DER-ACC ,PRSO " nicht aufziehen." CR>>

<ROUTINE V-WISH ()
	 <TELL "Mit viel Gl%uck, wird dein Wunsch sich erf%ullen." CR>>

<ROUTINE V-ZORK () <TELL "Zu deinen Diensten!" CR>>

<ROUTINE DESCRIBE-ROOM ("OPTIONAL" (LOOK? <>) "AUX" V? STR AV)
	 <SET V? <OR .LOOK? ,VERBOSE>>
	 <COND (<NOT ,LIT>
		<TELL "Es ist stockdunkel.">
		<COND (<NOT ,SPRAYED?>
		       <TELL " Es besteht die M%oglichkeit, da%s du von einem Greuel gefressen wirst.">)>
		<CRLF>
		<RFALSE>)>
	 <COND (<NOT <FSET? ,HERE ,TOUCHBIT>>
		<FSET ,HERE ,TOUCHBIT>
		<SET V? T>)>
	 <COND (<IN-MAZE? ,HERE>
		<FCLEAR ,HERE ,TOUCHBIT>)>
	 <COND (<IN? ,HERE ,ROOMS>
		;"Was <TELL D ,HERE CR>"
		<TELL D ,HERE>
		<COND (<FSET? <SET AV <LOC ,WINNER>> ,VEHBIT>
		       <TELL ", in " DER-DAT .AV>)>
		<CRLF>)>
	 <COND (<OR .LOOK? <NOT ,SUPER-BRIEF>>
		<SET AV <LOC ,WINNER>>
		;<COND (<FSET? .AV ,VEHBIT>
		       <TELL "(You are in " DER-DAT .AV ".)" CR>)>
		<COND (<AND .V? <APPLY <GETP ,HERE ,P?ACTION> ,M-LOOK>>
		       <RTRUE>)
		      (<AND .V? <SET STR <GETP ,HERE ,P?LDESC>>>
		       <TELL .STR CR>)
		      (T
		       <APPLY <GETP ,HERE ,P?ACTION> ,M-FLASH>)>
		<COND (<AND <NOT <EQUAL? ,HERE .AV>> <FSET? .AV ,VEHBIT>>
		       <APPLY <GETP .AV ,P?ACTION> ,M-LOOK>)>)>
	 T>

<ROUTINE DESCRIBE-OBJECTS ("OPTIONAL" (V? <>))
	 <COND (,LIT
		<COND (<FIRST? ,HERE>
		       <PRINT-CONT ,HERE <SET V? <OR .V? ,VERBOSE>> -1>)>)
	       (T
		<TELL "Nur Flederm%ause k%onnen im Dunkeln sehen. Und du bist keine." CR>)>>

<ROUTINE SCORE-UPD (NUM)
	 <SETG BASE-SCORE <+ ,BASE-SCORE .NUM>>
	 <SETG SCORE <+ ,SCORE .NUM>>
	 ;<TELL "[Your score g%os up.]" CR>
	 <COND (<AND <EQUAL? ,SCORE 350>
		     <NOT ,WON-FLAG>>
		<SETG WON-FLAG T>
		<FCLEAR ,MAP ,INVISIBLE>
		<FCLEAR ,WEST-OF-HOUSE ,TOUCHBIT>
		<TELL
"Eine fast unvernehmbare Stimme fl%ustert dir zu: %>Suche unter den Sch%atzen nach dem letzten Geheimnis.%<" CR>)>
	 T>

<ROUTINE LKP (ITM TBL "AUX" (CNT 0) LEN)
	 <SET LEN <GET .TBL 0>>
	 <REPEAT ()
		 <COND (<G? <SET CNT <+ .CNT 1>> .LEN>
			<RFALSE>)
		       (<EQUAL? <GET .TBL .CNT> .ITM>
			<COND (<EQUAL? .CNT .LEN> <RFALSE>)
			      (T
			       <RETURN <GET .TBL <+ .CNT 1>>>)>)>>>

<GLOBAL SWIMYUKS
	<LTABLE 0 "Du kannst in dem Kerker nicht schwimmen.">>

<GLOBAL DUMMY
	<LTABLE 0
"Pa%s auf."
"Dazu ist es zu sp%at."
"La%s dir die Augen checken.">>