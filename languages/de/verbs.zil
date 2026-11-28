  			"Generic VERBS file for
			    The ZORK Trilogy
		       started on 7/25/83 by SEM
		       -- GERMAN EDITION"

;"*** General note: Most of this file consists of dull “verb defaults”,
that is, responses you get if there's nothing interesting to respond
to what was typed. Most sentences are of a very general nature, which
must be maintained since you can plug in any (THING) into the sentence. ***"


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
	       (T <TELL "Deine H%ande sind leer." CR>)>>

<ROUTINE FINISH ("AUX" WRD)
	 <V-SCORE>
	 <COND (,PROSE-LINKS <QUIT>)>
	 <REPEAT ()
		 <CRLF>
		 <TELL 
"M%ochtest du das Spiel neu anfangen, einen gespeicherten Zug wiederherstellen oder diese Spielrunde beenden?|
(Tippe: NEUBEGINN, WIEDERHERSTELLUNG oder AUFHOEREN): 
>">
		 <PUTB ,P-INBUF 1 0>
		 <READ ,P-INBUF ,P-LEXV>
		 <SET WRD <GET ,P-LEXV ,P-LEXSTART>>
		 <COND (<EQUAL? .WRD ,W?NEUBEGINN>
			<RESTART>
			<TELL "Verfehlt." CR>)
		       (<EQUAL? .WRD ,W?WIEDERHERSTELLUNG>
			<COND (<RESTORE>
			       <TELL "Ok." CR>)
			      (T
			       <TELL "Verfehlt." CR>)>)
		       (<EQUAL? .WRD ,W?AUFHOEREN>
			<QUIT>)
>>>

<ROUTINE V-QUIT ("AUX" SCOR)
	 <V-SCORE>
	 <TELL 
"M%ochtest du aufh%oren zu spielen. (J wenn: Ja): ">
	 <COND (<YES?>
		<QUIT>)
	       (ELSE 
	        <TELL "Ok." CR>)>>

<ROUTINE V-RESTART ()
	 <V-SCORE T>
	 <TELL "M%ochtest du neu anfangen? (J wenn: Ja): ">
	 <COND (<YES?>
		<TELL "Neuanfang." CR>
		<RESTART>
		<TELL "Verfehlt." CR>)>>

<ROUTINE V-RESTORE ()
	 <COND (<RESTORE>
		<TELL "Ok." CR>
		<V-FIRST-LOOK>)
	       (T
		<TELL "Verfehlt." CR>)>>

<ROUTINE V-SAVE ("AUX" SV FLG)
	 <COND (<EQUAL? <SET SV <SAVE>> 1>
		<TELL "Ok." CR>)
	       (<EQUAL? .SV 2>
		<TELL "Ok." CR>
		<CRLF>
		<V-LOOK>)
	       (T
		<TELL "Verfehlt." CR>)>
	 <RTRUE>>

;"V-SCORE is in ACTIONS.ZIL"

<ROUTINE V-SCRIPT ()
	<PUT 0 8 <BOR <GET 0 8> 1>>
	<TELL "Hier beginnt eine gedruckte Kopie von: " CR CR>
	<V-VERSION>
	<RTRUE>>

<ROUTINE V-UNSCRIPT ()
	<TELL "Hier endet eine gedruckte Kopie von: " CR CR>
	<V-VERSION>
	<PUT 0 8 <BAND <GET 0 8> -2>>
	<RTRUE>>


<ROUTINE V-VERSION ("AUX" (CNT 17))
	<TELL "ZORK I: Das Gro%se Unterweltreich|
Infocom dialogf%ahig Prose - eine Phantasiegeschichte|
Copyright (c) 1981, 1982, 1983, 1984, 1985, 1986">
	<TELL " Infocom, Inc.|
Alle Rechte vorbehalten. ZORK ist ein eingetragenes Markenzeichen|
der Infocom, Inc.|
BETA RELEASE # 1|
Ver%offenlichtung ">
	<PRINTN <BAND <GET 0 1> *3777*>>
	<TELL " / Seriennummer ">
	<REPEAT ()
		<COND (<G? <SET CNT <+ .CNT 1>> 23>
		       <RETURN>)
		      (T
		       <PRINTC <GETB 0 .CNT>>)>>
	<TELL " / ">
	<V-$ID>
	<RTRUE>>

<ROUTINE V-VERIFY ()
	 <TELL "Diskette pr%ufen..." CR>
	 <COND (<VERIFY>
		<TELL "Die Diskette ist in Ordnung." CR>)
	       (T
		<TELL CR "** Diskettenfehler **" CR>)>>


<ROUTINE V-RANDOM ()
	 <COND (<NOT <EQUAL? ,PRSO ,INTNUM>>
		<TELL "Illegal call to #RND." CR>)
	       (T
		<RANDOM <- 0 ,P-NUMBER>>
		<RTRUE>)>>


;<ROUTINE V-AGAIN ("AUX" (OBJ <>))
	 <COND (<EQUAL? ,L-PRSA ,V?WALK>
		<DO-WALK ,L-PRSO>)
	       (T
		<COND (,L-PRSO
		       <COND (<OR <NOT <LOC ,L-PRSO>>
				  <FSET? ,L-PRSO ,INVISIBLE>>
			      <SET OBJ ,L-PRSO>)>)>
		<COND (,L-PRSI
		       <COND (<OR <NOT <LOC ,L-PRSI>>
				  <FSET? ,L-PRSI ,INVISIBLE>>
			      <SET OBJ ,L-PRSI>)>)>
		<COND (<AND .OBJ 
			    <NOT <EQUAL? .OBJ ;,PSEUDO-OBJECT ,ROOMS>>>
		       <TELL "You can't see " DER-ACC .OBJ " anymore." CR>
		       <RFATAL>)
		      (T
		       <PERFORM ,L-PRSA ,L-PRSO ,L-PRSI>)>)>>


<ROUTINE V-ANSWER ()
	 <TELL "Keiner wartet auf deine Antwort." CR>
	 <SETG P-CONT <>>
	 <SETG QUOTE-FLAG <>>
	 <RTRUE>>

<ROUTINE PRE-BOARD ("AUX" AV)
	 <SET AV <LOC ,WINNER>>
	 <COND 
	       (<FSET? ,PRSO ,VEHBIT>
		<COND (<NOT <IN? ,PRSO ,HERE>>
		       ;<TELL
DER-NOM-CAP ,PRSO " must be on the ground to be boarded." CR>
		       <TELL
DER-NOM-CAP ,PRSO " mu%s auf der Erde sein, um bestiegen zu werden." CR>)
		      (<FSET? .AV ,VEHBIT>
		       <TELL "Du bist schon in " DER-DAT .AV "!" CR>)
		      (T
		       <RFALSE>)>)
	       ;"Boarding a liquid means getting into it."
	       (<FSET? ,PRSO ,DRINKBIT>
		<PERFORM ,V?SWIM ,PRSO>
		<RTRUE>)
	       (T
		<TELL
"Du hast also eine Idee, wie man in " EIN-ACC ,PRSO " einsteigt?" CR>)>
	 <RFATAL>>

<ROUTINE V-BOARD ("AUX" AV)
	 ;"Du bist jetzt in dem Zauberboot"
	 <TELL "Du bist jetzt in " DER-DAT ,PRSO "." CR>
	 <MOVE ,WINNER ,PRSO>
	 <APPLY <GETP ,PRSO ,P?ACTION> ,M-ENTER>
	 <RTRUE>>

;<ROUTINE V-BREATHE ()
	 <PERFORM ,V?INFLATE ,PRSO ,LUNGS>>


<ROUTINE V-CLIMB-DOWN () <V-CLIMB-UP ,P?RUNTER ,PRSO>>

<ROUTINE V-CLIMB-FOO ()
	 <V-CLIMB-UP ,P?RAUF ,PRSO>>

<ROUTINE V-CLIMB-ON ()
	 <COND (<FSET? ,PRSO ,VEHBIT>
		<PERFORM ,V?BOARD ,PRSO>
		<RTRUE>)
	       (T
		<TELL "Du kannst nicht auf " DER-ACC ,PRSO " steigen." CR>)>>

<ROUTINE V-CLIMB-UP ("OPTIONAL" (DIR ,P?RAUF) (OBJ <>) "AUX" X TX)
	 <COND (<AND .OBJ <NOT <EQUAL? ,PRSO ,ROOMS>>>
		<SET OBJ ,PRSO>)>
	 <COND (<SET TX <GETPT ,HERE .DIR>>
		<COND (.OBJ
		       <SET X <PTSIZE .TX>>
		       <COND (<OR <EQUAL? .X ,NEXIT>
				  <AND <EQUAL? .X ,CEXIT ,DEXIT ,UEXIT>
				       <NOT <GLOBAL-IN? ,PRSO <GET .TX 0>>>>>
			      <TELL DER-NOM-CAP .OBJ " f%uhrt nicht nach ">
			      ;<COND (<NOT <EQUAL? .OBJ ,STAIRS>>
				     <TELL "es">)>
			      ;<TELL "n't lead ">
			      <COND (<==? .DIR ,P?RAUF>
				     <TELL "oben">)
				    (T <TELL "unten">)>
			      <TELL "." CR>
			      <RTRUE>)>)>
		<DO-WALK .DIR>
		<RTRUE>)
	       (<AND .OBJ
		     <ZMEMQ ,W?WAND
			    <SET X <GETPT ,PRSO ,P?SYNONYM>>
			    <- </ <PTSIZE .X> 2> 1>>
		     ;<ZMEMQ ,W?WALL
			    <SET X <GETPT ,PRSO ,P?SYNONYM>> <PTSIZE .X>>>
		<TELL "Die W%ande raufzuklettern ist sinnlos." CR>)
	       (<EQUAL? .OBJ <> ,ROOMS>
		<TELL "In diese Richtung kannst du nicht gehen." CR>)
	       (T
	        <TELL "You can't do that!" CR>)>>

<ROUTINE V-CLOSE-OR-LOCK ()
	 <COND (<AND <OR <FSET? ,PRSO ,CONTBIT>
			 <FSET? ,PRSO ,DOORBIT>>
		     <NOT <FSET? ,PRSO ,SURFACEBIT>>>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <PERFORM ,V?CLOSE ,PRSO>
		       <RTRUE>)
		      (T  ;<dont need key to lock it grating HELD? ,KEY>
		       <PERFORM ,V?LOCK ,PRSO ,HANDS>
		       <RTRUE>)>)>
	 <PERFORM ,V?CLOSE ,PRSO>
	 <RTRUE>>

<ROUTINE V-CLOSE-OR-UNLOCK ()
	 <COND (<AND <OR <FSET? ,PRSO ,CONTBIT>
			 <FSET? ,PRSO ,DOORBIT>>
		     <NOT <FSET? ,PRSO ,SURFACEBIT>>>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <PERFORM ,V?CLOSE ,PRSO>
		       <RTRUE>)
		      (T  ;<dont need key to lock it grating HELD? ,KEY>
		       <PERFORM ,V?UNLOCK ,PRSO ,HANDS>
		       <RTRUE>)>)>
	 <PERFORM ,V?CLOSE ,PRSO>
	 <RTRUE>>
		      
<ROUTINE V-CLOSE ()
	 <COND (<AND <NOT <FSET? ,PRSO ,CONTBIT>>
		     <NOT <FSET? ,PRSO ,DOORBIT>>>
		<TELL 
"Es ist ist einfach unm%oglich " EIN-DAT ,PRSO " zu schlie%sen." CR>)
	       (<AND <NOT <FSET? ,PRSO ,SURFACEBIT>>
		     <NOT <EQUAL? <GETP ,PRSO ,P?CAPACITY> 0>>>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <FCLEAR ,PRSO ,OPENBIT>
		       <TELL "Geschlossen." CR>
		       <COND (<AND ,LIT <NOT <SETG LIT <LIT? ,HERE>>>>
			      <TELL "Es ist jetzt stockdunkel." CR>)>
		       <RTRUE>)
		      (T
	 	       <TELL 
PRONOUN-NOM-CAP ,PRSO " ist schon geschlossen." CR>)>)
	       (<FSET? ,PRSO ,DOORBIT>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <FCLEAR ,PRSO ,OPENBIT>
		       <TELL DER-NOM-CAP ,PRSO " ist jetzt geschlossen." CR>)
		      (T
	 	       <TELL PRONOUN-NOM-CAP ,PRSO " ist schon geschlossen." CR>)>)
	       (T
		<TELL "Du kannst das da nicht schlie%sen." CR>)>>

<ROUTINE V-COMMAND ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<TELL DER-NOM-CAP ,PRSO " reagiert nicht." CR>)
	       (T
		<TELL "Damit kann man nicht sprechen." CR>)>>


<ROUTINE V-DISEMBARK ()
	 <COND (<AND <EQUAL? ,PRSO ,ROOMS>
		     <FSET? <LOC ,WINNER> ,VEHBIT>>
		<PERFORM ,V?DISEMBARK <LOC ,WINNER>>
		<RTRUE>)
	       (<NOT <EQUAL? <LOC ,WINNER> ,PRSO>>
		<TELL "Da bist du doch gar nicht drin!" CR>
		<RFATAL>)
	       (<FSET? ,HERE ,RLANDBIT>
		<TELL "Du stehst wieder auf eigenen F%u%sen." CR>
		<MOVE ,WINNER ,HERE>)
	       (T
		<TELL
"Du begreifst, da%s es deinen Tod bedeuten w%urde, wenn du hier ausstiegest."
CR>
		<RFATAL>)>>

<ROUTINE V-DISENCHANT ()
	 <TELL "Hier passiert garnichts." CR>>


<ROUTINE V-DRINK-FROM ()
	 <TELL "Wie eigenartig!" CR>>


<ROUTINE V-DROP ()
	 <COND (<IDROP>
		<TELL "Fallen gelassen." CR>)>>

<ROUTINE V-EAT ("AUX" (EAT? <>) (DRINK? <>) (NOBJ <>))
	 <COND (<SET EAT? <FSET? ,PRSO ,FOODBIT>>
		<COND (<AND <NOT <IN? ,PRSO ,WINNER>>
			    <NOT <IN? <LOC ,PRSO> ,WINNER>>>
		       <TELL "Das hast du doch gar nicht in der Hand." CR>)
		      (<VERB? DRINK>
		       <TELL
"Wie in aller Welt willst du " DER-ACC ,PRSO " denn trinken?">)
		      (T
		       <TELL 
"Es tut gut, l%oscht jeglichen Durst, den du eventuell versp%urt hast.">
		       <REMOVE-CAREFULLY ,PRSO>)>
		<CRLF>)
	       (<FSET? ,PRSO ,DRINKBIT>
		<SET DRINK? T>
		<SET NOBJ <LOC ,PRSO>>
		<COND (<OR <IN? ,PRSO ,GLOBAL-OBJECTS>
			   <LIQUID-HERE>
			   ;<EQUAL? ,PRSO ,PSEUDO-OBJECT>>
		       <HIT-SPOT>)
		      (<OR <NOT .NOBJ>
			   <NOT <ACCESSIBLE? .NOBJ>>>
		       <TELL "Du hast doch garnichts zu trinken." CR>)
		      (<AND <ACCESSIBLE? .NOBJ>
			    <NOT <IN? .NOBJ ,WINNER>>>
		       <TELL
"Erst mu%st du doch " DER-ACC .NOBJ " in der Hand halten." CR>
		       ;"Du mu%st die Gla%sflasche erst in der Hand halten.")
		      (<NOT <FSET? .NOBJ ,OPENBIT>>
		       <TELL
"Erst mu%st du doch " DER-ACC .NOBJ " %offnen." CR>)
		      (T
		       <HIT-SPOT>)>)
	       (<NOT <OR .EAT? .DRINK?>>
		<TELL
"Ich glaube nicht, da%s dir " DER-NOM ,PRSO " bekommt.">)>>

<ROUTINE HIT-SPOT ()
	 <TELL
"Es tut gut, l%oscht jeglichen Durst, den du eventuell versp%urt hast." CR>>


<ROUTINE REMOVE-CAREFULLY (OBJ "AUX" OLIT)
	 <COND (<EQUAL? .OBJ ,P-IT-OBJECT>
		<SETG P-IT-OBJECT <>>)>
	 <COND (<EQUAL? .OBJ ,P-HER-OBJECT>
		<SETG P-HER-OBJECT <>>)>
	 <COND (<EQUAL? .OBJ ,P-HIM-OBJECT>
		<SETG P-HIM-OBJECT <>>)>
	 <SET OLIT ,LIT>
	 <REMOVE .OBJ>
	 <SETG LIT <LIT? ,HERE>>
	 <COND (<AND .OLIT <NOT <EQUAL? .OLIT ,LIT>>>
		<TELL "Du tappst im Dunkeln." CR>)>
	 T>

<ROUTINE V-ENTER ()
	<DO-WALK ,P?HINEIN>>

<ROUTINE V-EXAMINE ()
	 <COND (<GETP ,PRSO ,P?TEXT>
		<TELL <GETP ,PRSO ,P?TEXT> CR>)
	       (<OR <FSET? ,PRSO ,CONTBIT>
		    <FSET? ,PRSO ,DOORBIT>>
		<V-LOOK-INSIDE>)
	       (T
		<TELL "Da ist nichts Besonderes an " DER-DAT ,PRSO "." CR>)>>

<ROUTINE V-EXIT ()
	 <COND (<AND <EQUAL? ,PRSO <> ,ROOMS>
		     <FSET? <LOC ,WINNER> ,VEHBIT>>
		<PERFORM ,V?DISEMBARK <LOC ,WINNER>>
		<RTRUE>)
	       (<AND ,PRSO <IN? ,WINNER ,PRSO>>
		<PERFORM ,V?DISEMBARK ,PRSO>
		<RTRUE>)
	       (ELSE
		<DO-WALK ,P?RAUS>)>>


;"Fill X fills it from the liquid here: the room's, or one beside you. Fill X with something that is no liquid puts that thing in X."
<ROUTINE PRE-FILL ("AUX" L)
	 <COND (<NOT ,PRSI>
		<COND (<OR <SET L <LIQUID-HERE>>
			   <SET L <FIND-IN <LOC ,WINNER> ,DRINKBIT>>>
		       <PERFORM ,V?FILL ,PRSO .L>)
		      (T
		       <TELL
"Da ist nichts, mit dem man " DER-ACC ,PRSO " f%ullen k%onnte." CR>)>
		<RTRUE>)
	       (<NOT <FSET? ,PRSI ,DRINKBIT>>
		<PERFORM ,V?PUT ,PRSI ,PRSO>
		<RTRUE>)>>

<ROUTINE V-FILL ()
	 <TELL "Das kannst du nicht f%ullen." CR>>

<ROUTINE V-FIND ("AUX" L)
	 <SET L <LOC ,PRSO>>
	 <COND (<EQUAL? ,PRSO ,HANDS ,LUNGS>
		<TELL
"Within six feet of your head, assuming you haven't left that
somewhere." CR>)
	       (<EQUAL? ,PRSO ,ME>
		<TELL "Du bist doch hier irgendwo in der N%ahe." CR>)
	       (<EQUAL? .L ,GLOBAL-OBJECTS>
		<TELL "Du findest " PRONOUN-ACC ,PRSO "." CR>)
	       (<IN? ,PRSO ,WINNER>
		<TELL "Du hast " PRONOUN-ACC ,PRSO "." CR>)
	       (<OR <IN? ,PRSO ,HERE>
		    <GLOBAL-IN? ,PRSO ,HERE>
		    ;<EQUAL? ,PRSO ,PSEUDO-OBJECT>>
		<TELL PRONOUN-NOM-CAP ,PRSO " ist hier." CR>)
	       (<FSET? .L ,ACTORBIT>
		<TELL DER-NOM-CAP .L " hat " PRONOUN-ACC ,PRSO "." CR>)
	       (<FSET? .L ,SURFACEBIT>
		<TELL PRONOUN-NOM-CAP ,PRSO " ist auf " DER-DAT .L "." CR>)
	       (<FSET? .L ,CONTBIT>
		<TELL PRONOUN-NOM-CAP ,PRSO " in " DER-DAT .L "." CR>)
	       (T
		<TELL "Da bist du bei mir an der falschen Adresse." CR>)>>

<ROUTINE V-FOLLOW ()
	 <TELL "Du bist narrisch!" CR>>


<ROUTINE PRE-GIVE ()
	 <COND (<NOT <HELD? ,PRSO>>
		<TELL 
"Das kannst du leicht sagen, denn du besitzt ja nicht einmal " 
DER-ACC ,PRSO "." CR>)>>

<ROUTINE V-GIVE ()
	 <COND (<NOT <FSET? ,PRSI ,ACTORBIT>>
		;<TELL "You can't give " EIN-ACC ,PRSO " to " EIN-DAT ,PRSI "!" CR>
		<TELL 
"Du kannst " EIN-DAT ,PRSI " doch nicht " EIN-ACC ,PRSO " geben!">)
	       (T
		<TELL 
DER-NOM-CAP ,PRSI " lehnt " PRONOUN-ACC ,PRSI " h%oflich ab." CR>)>>


<ROUTINE V-HELLO ()
	 <COND (<AND ,PRSO
		     <NOT <PRSO? ,ROOMS>>>
		<COND (<FSET? ,PRSO ,ACTORBIT>
		       <TELL
DER-NOM-CAP ,PRSO " gr%u%st dich mit einem Kopfnicken." CR>)
		      (T
		       <TELL
"Es ist eine alte Suppe, da%s nur Verr%uckte zu " EIN-DAT ,PRSO ":
%>Guten Tag%< sagen." CR>)>)
	       (T
		<TELL <PICK-ONE ,HELLOS> CR>)>>


<ROUTINE V-INCANT ()
<TELL
"The incantation echoes back faintly, but nothing else happens." CR>
	 <SETG QUOTE-FLAG <>>
	 <SETG P-CONT <>>
	 <RTRUE>>


<ROUTINE V-KISS ()
	 <TELL 
"Da w%urdest du lieber einen Ochs zwischen den H%ornern k%ussen." CR>>

<ROUTINE V-KNOCK ()
	 <COND (<FSET? ,PRSO ,DOORBIT>
		<TELL "Niemand zu Hause." CR>)
	       (T
		<TELL "Warum an " EIN-ACC ,PRSO " klopfen?" CR>)>>

<ROUTINE V-LAMP-OFF ()
	 <COND (<FSET? ,PRSO ,LIGHTBIT>
		<COND (<NOT <FSET? ,PRSO ,ONBIT>>
		       <TELL PRONOUN-NOM-CAP ,PRSO " ist schon aus." CR>)
		      (T
		       <FCLEAR ,PRSO ,ONBIT>
		       <COND (,LIT
			      <SETG LIT <LIT? ,HERE>>)>
		       <TELL "O.K. " DER-NOM ,PRSO " ist jetzt aus." CR>
		       <COND (<NOT ,LIT>
			      <TELL "Es ist jetzt stockdunkel." CR>)>)>)
	       (T
		<TELL "Das kannst du nicht ausmachen." CR>)>
	 <RTRUE>>

<ROUTINE V-LAMP-ON ()
	 <COND (<FSET? ,PRSO ,LIGHTBIT>
		<COND (<FSET? ,PRSO ,ONBIT>
		       <TELL PRONOUN-NOM-CAP ,PRSO " ist schon an." CR>)
		      (T
		       <FSET ,PRSO ,ONBIT>
		       <TELL DER-NOM-CAP ,PRSO " ist nun an." CR>
		       <COND (<NOT ,LIT>
			      <SETG LIT <LIT? ,HERE>>
			      <CRLF>
			      <V-LOOK>)>)>)
	       (<FSET? ,PRSO ,BURNBIT>
		<TELL
"Wenn du " DER-ACC ,PRSO " verbrennen willst, mu%st du's sagen." CR>)
	       (T
		<TELL "Das kannst du nicht anmachen." CR>)>
	 <RTRUE>>


<ROUTINE V-LEAN-ON ()
	 <TELL "Bist du m%ude?" CR>>

<ROUTINE V-LEAP ("AUX" TX S)
	 <COND (,PRSO
		<COND (<IN? ,PRSO ,HERE>
		       <COND (<FSET? ,PRSO ,ACTORBIT>
			      <TELL
DER-NOM-CAP ,PRSO " ist zu gro%s, um %uber ihn zu springen." CR>)
			     (T
			      <V-SKIP>)>)
		      (T
		       <TELL "Das w%are ein toller Trick." CR>)>)
	       (<SET TX <GETPT ,HERE ,P?RUNTER>>
		<SET S <PTSIZE .TX>>
		<COND (<OR <EQUAL? .S 3 ;2> ;NEXIT
       			   <AND <EQUAL? .S 5 ;4> ;CEXIT
				<NOT <VALUE <GETB ;B .TX 1>>>>>
		       <TELL
"Das war nicht der sicherste Platz f%ur den Absprung." CR>
		       <JIGS-UP <PICK-ONE ,JUMPLOSS>>)
		      (T
		       <V-SKIP>)>)
	       (T
		<V-SKIP>)>>

<GLOBAL JUMPLOSS
	<LTABLE 0
	       "Du h%attest erst mal gucken sollen, ehe du gesprungen bist."
	       "Im Film w%urde jetzt dein ganzes Leben schnell noch mal an dir vorbeispielen. Hiiiilfe.">>


<ROUTINE V-LISTEN ()
	 <TELL "Im Moment gibt " DER-NOM ,PRSO " keinen Laut von sich." CR>>

<ROUTINE V-LOCK ()
	 <TELL "Das scheint nicht zu funktionieren." CR>>


<ROUTINE V-LOOK-BEHIND ()
	 <TELL "Da ist nichts hinter " DER-DAT ,PRSO "." CR>>

<ROUTINE V-LOOK-INSIDE ()
	 <COND (<FSET? ,PRSO ,DOORBIT>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <TELL
DER-NOM-CAP ,PRSO " ist ge%offnet, aber du kannst nicht sehen, was
dahinter ist.">)
		      (T
		       <TELL DER-NOM-CAP ,PRSO " ist geschlossen.">)>
		<CRLF>)
	       (<FSET? ,PRSO ,CONTBIT>
		<COND (<FSET? ,PRSO ,ACTORBIT>
		       <TELL "Da gibt's nichts Besonderes zu sehen." CR>)
		      (<SEE-INSIDE? ,PRSO>
		       <COND (<AND <FIRST? ,PRSO>
				   <PRINT-CONT ,PRSO>>
			      <RTRUE>)
			     
			     (T
			      <TELL DER-NOM-CAP ,PRSO " ist leer." CR>)>)
		      (T
		       <TELL DER-NOM-CAP ,PRSO " ist geschlossen." CR>)>)
	       (T
		<TELL 
"Du kannst nicht in " EIN-DAT ,PRSO " hineingucken." CR>)>>

<ROUTINE V-LOOK-ON ()
	 <COND (<FSET? ,PRSO ,SURFACEBIT>
		<PERFORM ,V?LOOK-INSIDE ,PRSO>
		<RTRUE>)
	       (T
		<TELL "Weird." CR>)>>

<ROUTINE V-LOOK-UNDER ()
	 <TELL "Da gibt es nichts als Staub." CR>>

<ROUTINE V-LOWER () 
	 <TELL "So mit " DER-DAT ,PRSO " zu spielen, ist nicht hilfreich." CR>>


<ROUTINE PRE-MOVE ()
	 <COND (<HELD? ,PRSO>
		<TELL
"Deine Jonglierk%unste sind nicht gut genug daf%ur." CR>)>>

<ROUTINE V-MOVE ()
	 <COND (<FSET? ,PRSO ,TAKEBIT>
		<TELL "Wenn man " DER-ACC ,PRSO " wegnimmt, kommt nichts zum Vorschein." CR>)
	       (T
		<TELL 
DER-ACC-CAP ,PRSO " kann man nicht aus dem Weg schieben." CR>)>>


<ROUTINE V-NO ()
	 <V-YES>>


<ROUTINE V-OPEN ("AUX" F STR)
	 <COND (<AND <FSET? ,PRSO ,CONTBIT>
		     <NOT <EQUAL? <GETP ,PRSO ,P?CAPACITY> 0>>>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <TELL PRONOUN-NOM-CAP ,PRSO " ist schon offen." CR>)
		      (T
		       <FSET ,PRSO ,OPENBIT>
		       <FSET ,PRSO ,TOUCHBIT>
		       <COND (<OR <NOT <FIRST? ,PRSO>> <FSET? ,PRSO ,TRANSBIT>>
			      <TELL "Ge%offnet." CR>)
			     (<AND <SET F <FIRST? ,PRSO>>
				   <NOT <NEXT? .F>>
				   <NOT <FSET? .F ,TOUCHBIT>>
				   <SET STR <GETP .F ,P?FDESC>>>
			      <TELL 
DER-NOM-CAP ,PRSO " l%a%st sich %offnen." CR>
			      <TELL .STR CR>)
			     (T
			      <TELL 
DER-NOM-CAP ,PRSO ", der ge%offnet ist, enth%alt ">
			      <PRINT-CONTENTS ,PRSO>
			      <TELL "." CR>)>)>)
	       (<FSET? ,PRSO ,DOORBIT>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <TELL PRONOUN-NOM-CAP ,PRSO " ist schon offen." CR>)
		      (T
		       <TELL DER-NOM-CAP ,PRSO " %offnet." CR>
		       <FSET ,PRSO ,OPENBIT>)>)
	       (T
		<TELL
"Du scheinst " EIN-ACC ,PRSO " nicht %offnen zu k%onnen." CR>)>>


<ROUTINE V-POUR-ON ()
	 <TELL "Das l%a%st sich nicht gie%sen." CR>>

<ROUTINE V-PUSH () 
	 <TELL DER-ACC-CAP ,PRSO " schieben ist erfolglos." CR>>

<ROUTINE V-PUSH-TO ()
	 <TELL "Dahin kann man nichts schieben." CR>>


<ROUTINE V-PUT ()
	 <COND (<OR <FSET? ,PRSI ,OPENBIT>
		    <OPENABLE? ,PRSI>
		    <FSET? ,PRSI ,VEHBIT>>)
	       (T
		<TELL "Das geht nicht." CR>
		<RTRUE>)>
	 <COND (<NOT <FSET? ,PRSI ,OPENBIT>>
		<TELL DER-NOM-CAP ,PRSI " ist nicht offen." CR>
		<THIS-IS-IT ,PRSI>)
	       (<EQUAL? ,PRSI ,PRSO>
		<TELL "Wie willst du das denn anstellen?" CR>)
	       (<IN? ,PRSO ,PRSI>
		;<TELL 
DER-NOM-CAP ,PRSO " is already in " DER-DAT ,PRSI "." CR>
		<TELL DER-NOM-CAP ,PRSO " ist schon " DER-DAT ,PRSI "." CR>)
	       (<G? <- <+ <WEIGHT ,PRSI> <WEIGHT ,PRSO>>
		       <GETP ,PRSI ,P?SIZE>>
		    <GETP ,PRSI ,P?CAPACITY>>
		<TELL "Da ist wirklich kein Platz mehr." CR>)
	       (<AND <NOT <HELD? ,PRSO>>
		     <FSET? ,PRSO ,TRYTAKEBIT>>
		<TELL "Du hast " DER-ACC ,PRSO " ja gar nicht." CR>
		<RTRUE>)
	       (<AND <NOT <HELD? ,PRSO>>
		     <NOT <ITAKE>>>
		<RTRUE>)
	       (T
		<MOVE ,PRSO ,PRSI>
		<FSET ,PRSO ,TOUCHBIT>
		<SCORE-OBJ ,PRSO>
		<TELL "Geschafft." CR>)>>

<ROUTINE V-PUT-BEHIND ()
	 <TELL "Das Versteck ist nicht sicher." CR>>

<ROUTINE V-PUT-ON ()
	 <COND (<EQUAL? ,PRSI ,GROUND>
		<PERFORM ,V?DROP ,PRSO>
		<RTRUE>)
	       (<FSET? ,PRSI ,SURFACEBIT>
		<V-PUT>)
	       (T
		<TELL 
DER-NOM-CAP ,PRSI " hat keine gute Oberfl%ache." CR>)>>

<ROUTINE V-PUT-UNDER ()
	 <TELL "You can't do that." CR>>


;<ROUTINE V-RAPE ()
	 <TELL "What a (ahem!) strange idea." CR>>

<ROUTINE PRE-READ ()
	 <COND (<NOT ,LIT>
		<TELL "Es ist unm%oglich im Dunkeln zu lesen." CR>)
	       (<AND ,PRSI <NOT <FSET? ,PRSI ,TRANSBIT>>>
		<TELL "Wie kann man durch " EIN-ACC ,PRSI " hindurchsehen?" CR>)>>

<ROUTINE V-READ ()
	 <COND (<NOT <FSET? ,PRSO ,READBIT>>
	        ;<NOT <GETP ,PRSO ,P?TEXT>>
		<TELL "Wie kann man " EIN-ACC ,PRSI " lesen?" CR>)
	       (T
		<TELL <GETP ,PRSO ,P?TEXT> CR>)>>


<ROUTINE V-REPLY ()
	 <TELL "Es ist unwahrscheinlich, da%s sich " DER-NOM ,PRSO " daf%ur interesiert." CR>
	 <SETG P-CONT <>>
	 <SETG QUOTE-FLAG <>>
	 <RTRUE>>

<ROUTINE V-RING ()
	 <TELL "Wie, um Himmels Willen, soll man damit klingeln?" CR>>

<ROUTINE V-RUB () 
	 <TELL "Den Tisch reiben ist nicht hilfreich.">>

<ROUTINE V-SAY ("AUX" V)
	 <COND (<NOT ,P-CONT>
			 <TELL "Was?" CR>
			 <RTRUE>)>
	 <SETG QUOTE-FLAG <>>
	 <COND (<SET V <FIND-IN ,HERE ,ACTORBIT>>
		;<TELL "You must address " DER-ACC .V "Directly." CR>
		<TELL 
"Um zu den Personen zu sprechen, tippe:|
>PERSON, TAG|
oder|
>PERSON, LASS DER AXT FALLEN|
(usw.)|">
		<SETG P-CONT <>>)
	       (<NOT <EQUAL? <GET ,P-LEXV ,P-CONT> ;,W?HELLO ,W?HALLO>>
	        <SETG P-CONT <>>
		<TELL
"Selbstgespr%ache deuten auf einen bevorstehenden Nervenzusammenbruch hin." CR>)>
	 <RTRUE>>

<ROUTINE V-SEARCH ()
	 <TELL "Du findest nichts Ungew%ohnliches." CR>>


<ROUTINE V-SCHENKE ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<PERFORM ,V?GIVE ,PRSI ,PRSO>)
	       (<FSET? ,PRSI ,ACTORBIT>
		<PERFORM ,V?GIVE ,PRSO ,PRSI>)
	       (T
		<PERFORM ,V?DROP ,PRSO ,PRSI>)>
	 <RTRUE>>

<ROUTINE PRE-SGIVE ()
	 <COND (<FSET? ,PRSI ,ACTORBIT> ;"gib es ihm"
		<PERFORM ,V?GIVE ,PRSO ,PRSI>
		<RTRUE>)
	       (T ;"gib ihm es"
	        <PERFORM ,V?GIVE ,PRSI ,PRSO>)>
	 <RTRUE>>

<ROUTINE V-SGIVE ()
	 <TELL "Foo!" CR>>

<ROUTINE V-SHAKE ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<TELL "Das scheint keinen Zweck zu haben." CR>)
	       (<NOT <FSET? ,PRSO ,TAKEBIT>>
		<TELL 
"Du kannst " PRONOUN-ACC ,PRSO  " nicht wegnehmen, also kannst du "
PRONOUN-ACC ,PRSO " auch nicht sch%utteln." CR>)
	       (<FSET? ,PRSO ,CONTBIT>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <COND (<FIRST? ,PRSO>
			      <SHAKE-LOOP>
			      <TELL "Der Inhalt f%allt "> 
	                      <COND (<NOT <FSET? ,HERE ,RLANDBIT>>
		                     <TELL "heraus und verschwindet">)
	                            (T
		                     <TELL "auf die Erde">)>
	                      <TELL "." CR>)
			     (T
			      <TELL "Geschafft." CR>)>)
		      (T
		       <COND (<FIRST? ,PRSO>
			      <TELL
"Es h%ort sich an, als w%are da etwas in " DER-DAT ,PRSO "." CR>)
			     (T
			      <TELL 
DER-NOM-CAP ,PRSO " h%ort sich leer an." CR>)>)>)
	       (T
		<TELL "Shaken." CR>)>>

<ROUTINE V-SMELL ()
	 <TELL 
PRONOUN-NOM-CAP ,PRSO " riecht genau wie " EIN-NOM ,PRSO "." CR>>


<ROUTINE V-SQUEEZE ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<TELL DER-NOM-CAP ,PRSO " versteht das nicht.">)
	       (T
		<TELL "Wie einmalig sinnlos.">)>
	 <CRLF>>


<ROUTINE V-STAND ()
	 <COND (<FSET? <LOC ,WINNER> ,VEHBIT>
		<PERFORM ,V?DISEMBARK <LOC ,WINNER>>
		<RTRUE>)
	       (T
		<TELL "Du stehst schon." CR>)>>


;"WAS USED FOR “SCHLAG OBJECT”"
;<ROUTINE V-STRIKE ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		;<TELL
"Since you aren't versed in hand-to-hand combat, you'd better attack "
DER-ACC ,PRSO " with a weapon." CR>
		<TELL "Da du im Faustkampf nicht ge%ubt bist, greifst du " DER-ACC ,PRSO " besser mit einer Waffe an." CR>)
	       (T
		<PERFORM ,V?LAMP-ON ,PRSO>
		<RTRUE>)>>

<ROUTINE V-SWIM ()
	 <TELL "Geh baden." CR>>


<ROUTINE V-TRAGE ()
	 <COND (<AND <HELD? ,PRSO>
		     <FSET? ,PRSO ,WEARBIT>>
		<PERFORM ,V?WEAR ,PRSO>
		<RTRUE>)
	       (T
		<PERFORM ,V?TAKE ,PRSO>
		<RTRUE>)>>

<ROUTINE PRE-TAKE ()
	 <COND (<IN? ,PRSO ,WINNER>
		<COND (<FSET? ,PRSO ,WEARBIT>
		       <TELL 
"Du hast " DER-ACC ,PRSO " doch schon an." CR>)
		      (T
		       <TELL "Das hast du doch schon!" CR>)>)
	       (<AND <FSET? <LOC ,PRSO> ,CONTBIT>
		     <NOT <FSET? <LOC ,PRSO> ,OPENBIT>>>
		<TELL
"Was in einem geschlossenen Beh%alter ist, kannst man nicht anfassen." CR>
		<RTRUE>)
	       (,PRSI
		<COND (<EQUAL? ,PRSI ,GROUND>
		       <SETG PRSI <>>
		       <RFALSE>)>
		
		<COND (<NOT <EQUAL? ,PRSI <LOC ,PRSO>>>
		       <TELL 
DER-NOM-CAP ,PRSO " ist doch garnicht in " DER-DAT ,PRSI "." CR>)
		      (T
		       <SETG PRSI <>>
		       <RFALSE>)>)
	       (<EQUAL? ,PRSO <LOC ,WINNER>>
		<TELL "Du bist drin." CR>)>>

<ROUTINE V-TAKE ()
	 <COND (<EQUAL? <ITAKE> T>
		<COND (<FSET? ,PRSO ,WEARBIT>
		       <TELL "Jetzt hast du " DER-ACC ,PRSO " an." CR>)
		      (T
		       <TELL "Genommen." CR>)>)>>

<ROUTINE V-TELL ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<COND (,P-CONT
		       <SETG WINNER ,PRSO>
		       <SETG HERE <LOC ,WINNER>>)
		      (T
		       <TELL
DER-NOM-CAP ,PRSO " stutzt einen Moment. Vielleicht denkt er, da%s du die Spielanleitung noch mal durchlesen solltest." CR>)>)
	       (T
		<TELL "Mit " DER-DAT ,PRSO " l%a%st sich nicht reden!" CR>
		<SETG QUOTE-FLAG <>>
		<SETG P-CONT <>>
		<RFATAL>)>>


;<ROUTINE V-TEST-IT ()
	 <TELL
"Da" NF SS " ich zu sp" NF LCA "t komme." CR>
	 <TELL
NF UCO "ffne den " NF UCU "bermench. " NF UCA "pfel sind sch" NF LCO "n." CR>
	 <TELL
"Und " NF LCU "ber den Mann." CR>>

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
"Du st%o%st dir den Kopf an " DER-DAT ,PRSO ", wenn du dieses Kunstst%uck ausprobierst." CR>)
	      (<IN? ,PRSO ,WINNER>
	       <TELL "Dazu mu%s man sich zu sehr verrenken." CR>)
	      (T
	       <TELL <PICK-ONE ,YUKS> CR>)>>

<ROUTINE V-THROW ()
	 <COND (<IDROP>
		<COND (<EQUAL? ,PRSI ,ME>
		       <TELL
"Ein toller Wurf! " DER-NOM-CAP ,PRSO>
		       <SETG WINNER ,PLAYER>
		       <JIGS-UP " trifft dich genau in den Kopf. Normalerweise w%urde daraus nicht viel Schaden entstehen, aber du hast das unsagbare Pech, hinten%uberzufallen, als du dich ducken willst und brichst dir das Genick. Die Gerechtigkeit kommt schnell und gnadenreich im Gro%sen Land der Unterwelt.">)
		      (<AND ,PRSI <FSET? ,PRSI ,ACTORBIT>>
		       <TELL DER-NOM-CAP ,PRSI " duckt sich, als "
DER-ACC ,PRSO " vorbeisaust und zu Boden f%allt." CR>
		       ;<TELL
DER-NOM-CAP ,PRSI " ducks as " DER-NOM ,PRSO " flies by and crashes to the ground." CR>)
		      (T <TELL "Geworfen." CR>)>)
	       (ELSE <TELL "Was?" CR>)>>


<ROUTINE V-TIE ()
	 <COND (<EQUAL? ,PRSI ,WINNER>
		<TELL "Du kannst nichts an dir selber festbinden." CR>)
	       (T
		<TELL "Daran kannst du " DER-ACC ,PRSO " nicht festbinden." CR>)>>


<ROUTINE PRE-TURN ()
	 <COND (<AND <EQUAL? ,PRSI <> ,ROOMS>
		     <NOT <FSET? ,PRSO ,READBIT>>>
		<TELL "Mit nackten H%anden kommst du hier nicht weiter." CR>)
	       (<NOT <FSET? ,PRSO ,TURNBIT>>
		<TELL "Das kannst du nicht drehen!" CR>)>>

<ROUTINE V-TURN ()
	 <TELL "Erfolglos." CR>>


<ROUTINE V-UNTIE ()
	 <TELL 
DER-NOM-CAP ,PRSO " kann nicht festgebunden werden, also kann "
PRONOUN-NOM ,PRSO " auch nicht losgebunden werden!" CR>>

;"ren: translate"
<ROUTINE V-USE ()
	 <TELL "You must be more specific." CR>>

<ROUTINE V-WAIT ("OPTIONAL" (NUM 3))
	 <TELL "Zeit vergeht..." CR>
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
		       <COND (<VALUE <GETB .PT ,CEXITFLAG>> ;"globals can getb"
			      <GOTO <GETB .PT ,REXIT>>)  ;"dir. props can't"
			     (<SET STR <GET .PT ,CEXITSTR>>
			      <TELL .STR CR>
			      <RFATAL>)
			     (T
			      <TELL 
"In die Richtung kannst du nicht gehen." CR>
			      <RFATAL>)>)
		      (<EQUAL? .PTS ,DEXIT>
		       <COND (<FSET? <SET OBJ <GETB .PT ,DEXITOBJ>> ,OPENBIT>
			      <GOTO <GETB .PT ,REXIT>>)
			     (<SET STR <GET .PT ,DEXITSTR>>
			      <TELL .STR CR>
			      <RFATAL>)
			     (T
			      <TELL DER-NOM-CAP .OBJ " ist geschlossen." CR>
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
"O nein! Du bist in die lechzenden F%ange eines lauernden Greuels geraten!">)>)
	       (T
		<TELL "In die Richtung kannst du nicht gehen." CR>
		<RFATAL>)>>

<ROUTINE V-WALK-AROUND ()
	 <TELL "Benutze einen Kompa%s f%ur die Richtung." CR>>

<ROUTINE V-WALK-TO ()
	 <COND (<EQUAL? ,PRSO ,INTDIR>
		<DO-WALK ,P-DIRECTION>
		<RTRUE>)
	       (<AND ,PRSO
		     <OR <IN? ,PRSO ,HERE>
			 <GLOBAL-IN? ,PRSO ,HERE>>>
		<TELL PRONOUN-NOM-CAP ,PRSO " ist hier!" CR>)
	       (T
		<TELL "Du mu%st eine Richtung angeben!" CR>)>>

<ROUTINE V-WAVE ()
	 <TELL 
DER-ACC-CAP ,PRSO " wedeln, scheint nicht zu funktionieren." CR>>

<ROUTINE V-WEAR ()
	 <COND (<NOT <FSET? ,PRSO ,WEARBIT>>
		<TELL "Du kannst " DER-ACC ,PRSO " nicht tragen." CR>)
	       (T
		<PERFORM ,V?TAKE ,PRSO>
		<RTRUE>)>>


<ROUTINE V-YELL () <TELL "AAAUUUUUU!" CR>>

<ROUTINE V-YES ()
	 <TELL "Ja?" CR>>


"Verb-Associated Routines"

"Descriptions"


"DESCRIBE-OBJECT -- takes object and flag. if flag is true will print a
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
		<TELL "Hier ist " EIN-NOM .OBJ>
		<COND (<FSET? .OBJ ,ONBIT>
		       <TELL " (beleuchtet)">)>
		<TELL ".">)
	       (T
		<TELL <GET ,INDENTS .LEVEL>>
		<TELL EIN-NOM-CAP .OBJ>
		<COND (<FSET? .OBJ ,ONBIT>
		       <TELL " (beleuchtet)">)
		      (<AND <FSET? .OBJ ,WEARBIT>
			    <IN? .OBJ ,WINNER>>
		       <TELL " (auf dem Leib)">)>)>
	 
	 <COND (<AND <0? .LEVEL>
		     <SET AV <LOC ,WINNER>>
		     <FSET? .AV ,VEHBIT>>
		<TELL " (au%serhalb von " DER-DAT .AV ")">)>
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
			       <COND (<NOT .N> <TELL "und ">)>)>
			<TELL EIN-NOM  .F>
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

<ROUTINE PRINT-CONT (OBJ "OPTIONAL" (V? <>) (LEVEL 0)
		     "AUX" Y 1ST? SHIT AV STR (PV? <>) (INV? <>))
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
			       <SET LEVEL <+ .LEVEL 1>> ;"not in Zork III"
			       <PRINT-CONT .AV .V? .LEVEL>)>
			<RETURN>)
		       (<EQUAL? .Y .AV ,ADVENTURER>)
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
			       <SET LEVEL <+ .LEVEL 1>> ;"not in Zork III"
			       <PRINT-CONT .Y .V? .LEVEL>
			       <SET LEVEL <- .LEVEL 1>> ;"not in Zork III")>)>
		 <SET Y <NEXT? .Y>>>
	 <COND (<AND .1ST? .SHIT> <RFALSE>) (T <RTRUE>)>>

<ROUTINE FIRSTER (OBJ LEVEL)
	 <COND (<EQUAL? .OBJ ,WINNER>
		<TELL "Du tr%agst:" CR>)
	       (<NOT <IN? .OBJ ,ROOMS>>
		<COND (<G? .LEVEL 0>
		       <TELL <GET ,INDENTS .LEVEL>>)>
		<COND (<FSET? .OBJ ,SURFACEBIT>
		       <TELL "Auf " DER-DAT .OBJ>
		       <COND (<G? <CCOUNT .OBJ> 1>
			      <TELL " ist: " CR>)
			     (T
			      <TELL " sind: " CR>)>)
		      (<FSET? .OBJ ,ACTORBIT>
		       <TELL DER-NOM-CAP .OBJ 
" scheint das Folgende zu halten:" CR>)
		      (T
		       <TELL DER-NOM-CAP .OBJ " scheint das Folgende zu enthalten:" CR>)>)>>


"Scoring"


;<ROUTINE YES? ()
	 <PRINTI ">">
	 <READ ,P-INBUF ,P-LEXV>
	 <COND (<EQUAL? <GET ,P-LEXV 1> ,W?YES ,W?Y>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<CONSTANT YES-INBUF <ITABLE 19 (BYTE LENGTH) 0>>
<CONSTANT YES-LEXV  <ITABLE 3 (LEXV) 0 0>>

<ROUTINE YES? ("AUX" WORD VAL)
	<REPEAT ()
		<PRINTI ">">
		<PUTB ,YES-INBUF 1 0>
		<READ ,YES-INBUF ,YES-LEXV>
		<COND (<AND <NOT <0? <GETB ,YES-LEXV ,P-LEXWORDS>>>
			    <SET WORD <GET ,YES-LEXV ,P-LEXSTART>>>
		       <SET VAL <WT? .WORD ,PS?VERB ,P1?VERB>>
		       <COND (<OR <EQUAL? .VAL ,ACT?JA>
				  <EQUAL? .WORD ,W?J>>
			      <SET VAL T>
			      <RETURN>)
			     (<OR <EQUAL? .VAL ,ACT?NEIN>
				  <EQUAL? .WORD ,W?N>>
			      <SET VAL <>>
			      <RETURN>)
			     (<EQUAL? .VAL ,ACT?NEUBEGINN>
			      <V-RESTART>)
			     (<EQUAL? .VAL ,ACT?WIEDERHERSTELLUNG>
			      <V-RESTORE>)
			     (<EQUAL? .VAL ,ACT?AUFHOEREN>
			      <V-QUIT>)>)>
		<TELL "[Please type YES or NO.]">>
	.VAL>

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
"Deine Hand greift durch das Objekt hindurch." CR>)>
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
		       <TELL "Last ist zu schwer">
		       <COND (<L? ,LOAD-ALLOWED ,LOAD-MAX>
			      ;<TELL ", especially in light of your condition.">
			      <TELL ", aber du nimmst es leicht">)
			     (T
			      <TELL ".">)>
		       <CRLF>)>
		<RFATAL>)
	       (<AND <VERB? TAKE>
		     <G? <SET CNT <CCOUNT ,WINNER>> ,FUMBLE-NUMBER>
		     <PROB <* .CNT ,FUMBLE-PROB>>>
		<TELL
"Du hast deine H%ande schon zu voll!" CR>
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
		<TELL "Du tr%agst " DER-ACC ,PRSO " nicht." CR>
		<RFALSE>)
	       (<AND <NOT <IN? ,PRSO ,WINNER>>
		     <NOT <FSET? <LOC ,PRSO> ,OPENBIT>>>
		<TELL DER-NOM-CAP ,PRSO " ist geschlossen." CR>
		<RFALSE>)
	       (T
		<MOVE ,PRSO <LOC ,WINNER>>
		<RTRUE>)>>


"Miscellaneous"

<CONSTANT UEXIT %<COND (<AND <GASSIGNED? PLUS-MODE> ,PLUS-MODE> 2) (T 1)>>
	"Uncondl EXIT:	(dir TO rm)		 = rm"
<CONSTANT NEXIT %<COND (<AND <GASSIGNED? PLUS-MODE> ,PLUS-MODE> 3) (T 2)>>
	"Non EXIT:	(dir ;SORRY string)	 = str-ing"
<CONSTANT FEXIT %<COND (<AND <GASSIGNED? PLUS-MODE> ,PLUS-MODE> 4) (T 3)>>
	"Fcnl EXIT:	(dir PER rtn)		 = rou-tine, 0"
<CONSTANT CEXIT %<COND (<AND <GASSIGNED? PLUS-MODE> ,PLUS-MODE> 5) (T 4)>>
	"Condl EXIT:	(dir TO rm IF f)	 = rm, f, str-ing"
<CONSTANT DEXIT %<COND (<AND <GASSIGNED? PLUS-MODE> ,PLUS-MODE> 6) (T 5)>>
	"Door EXIT:	(dir TO rm IF dr IS OPEN)= rm, dr, str-ing, 0"

<CONSTANT CEXITFLAG %<COND (<AND <GASSIGNED? PLUS-MODE> ,PLUS-MODE> 4) (T 1)>>	"GET/B"
<CONSTANT DEXITSTR %<COND (<AND <GASSIGNED? PLUS-MODE> ,PLUS-MODE> 2) (T 1)>>	"GET"


;<ROUTINE HACK-HACK (STR "OPT" (DATIVE? <>))
	 <COND (<AND <IN? ,PRSO ,GLOBAL-OBJECTS>
		     <VERB? WAVE RAISE LOWER>>
		<TELL DER-NOM-CAP ,PRSO " ist nicht hier!" CR>)
	       (.DATIVE?
		<TELL .STR DER-DAT ,PRSO <PICK-ONE ,HO-HUM> CR>)
	       (T
		<TELL .STR DER-ACC ,PRSO <PICK-ONE ,HO-HUM> CR>)>>

<ROUTINE NO-GO-TELL (AV WLOC)
	 <COND (.AV
		<TELL EIN-DAT .WLOC " kannst du da nicht hin.">)
	       (T
		<TELL 
"Ohne ein Transportmittel kannst du da nicht hingehen." >)>
	 <CRLF>>

<ROUTINE GOTO (RM "OPTIONAL" (V? T)
	       "AUX" (LB <>) WLOC 
	             (AV <>) OLIT OHERE)
	 <SET OLIT ,LIT>
	 <SET OHERE ,HERE> ;"next three lines used to be “aux” defaults"
	 <SET WLOC <LOC ,WINNER>>
	 <COND (<FSET? .RM ,RLANDBIT>
		<SET LB T>)>
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
DER-NOM-CAP .WLOC " stoppt am Ufer." CR CR>)>
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
			      ;<TELL
"Oh, no! A lurking grue slithered into ">
			      <TELL
"Meine G%ute! Ein lauerndes Greuel ist in "> 
			      <COND (<FSET? <LOC ,WINNER> ,VEHBIT>
				     <TELL DER-ACC <LOC ,WINNER>>)
				    (T <TELL "das Zimmer">)>
			      <JIGS-UP 
" geschlittert und hat dich verschlungen.">
			      <RTRUE>)>)>
		<COND (<AND <NOT ,LIT>
			    <EQUAL? ,WINNER ,ADVENTURER>>
		       <TELL "Du bist in einem dunklen Ort gelandet." CR>
		       <SETG P-CONT <>>)>
		<APPLY <GETP ,HERE ,P?ACTION> ,M-ENTER>
		<SCORE-OBJ .RM>
		<COND (<NOT <EQUAL? ,HERE .RM>> <RTRUE>)
		      (<AND <NOT <EQUAL? ,ADVENTURER ,WINNER>>
			    <IN? ,ADVENTURER .OHERE>>
		       <TELL DER-NOM-CAP ,WINNER " verl%a%st das Zimmer." CR>)
		      (<AND .V?
			    <EQUAL? ,WINNER ,ADVENTURER>>
		       <V-FIRST-LOOK>)>
		<RTRUE>)>>


;<ROUTINE WORD-TYPE (OBJ WORD "AUX" SYNS)
	 <ZMEMQ .WORD
		<SET SYNS <GETPT .OBJ ,P?SYNONYM>>
		<- </ <PTSIZE .SYNS> 2> 1>>>


;<ROUTINE IN-HERE? (OBJ)
	 <OR <IN? .OBJ ,HERE>
	     <GLOBAL-IN? .OBJ ,HERE>>>


<ROUTINE OTHER-SIDE (DOBJ "AUX" (P 0) TX) ;"finds room beyond given door"
	 <REPEAT ()
		 <COND (<L? <SET P <NEXTP ,HERE .P>> ,LOW-DIRECTION>
			<RETURN <>>)
		       (ELSE
			<SET TX <GETPT ,HERE .P>>
			<COND (<AND <EQUAL? <PTSIZE .TX> ,DEXIT>
				    <EQUAL? <GETB .TX ,DEXITOBJ> .DOBJ>>
			       <RETURN .P>)>)>>>


<GLOBAL P-HIM-OBJECT <>>

<GLOBAL P-IT-OBJECT <>>

<GLOBAL P-HER-OBJECT <>>

<ROUTINE THIS-IS-IT (OBJ)
	 <COND (<OR <NOT .OBJ>
		    <AND <VERB? WALK>
			 <PRSO? .OBJ>> ;"PRSO is a direction"
		    <EQUAL? .OBJ ,ADVENTURER> ;"is this necessary?"
		    <EQUAL? .OBJ ,NOT-HERE-OBJECT ,ME ;,GLOBAL-ROOM>>
		<RTRUE>)  
	       (<FSET? .OBJ ,DERBIT>
		<SETG P-HIM-OBJECT .OBJ>)
	       (<FSET? .OBJ ,DASBIT>
		<SETG P-IT-OBJECT .OBJ>)
	       (T
		<SETG P-HER-OBJECT .OBJ>)>>


<GLOBAL HELLOS
	<LTABLE 0 "Hallo, ist da jemand?"
	          "Hallo, Hallo!"
		  "Guten Tag."
		  "Sch%ones Wetter haben wir, nicht wahr?"
		  "Auf Wiedersehen.">>

<GLOBAL YUKS
	<LTABLE
	 0
"Ein braver Versuch."
"Das kann doch nicht dein Ernst sein."
"Das hie%se das Unm%ogliche m%oglich machen."
"Eine hochinteressante Idee..."
"Was f%ur ein Plan!">>

<GLOBAL WHEEEEE
	<LTABLE 0 "Ausgezeichnet. Du bist in die 4. Klasse versetzt!"
		  "Macht's dir Spa%s?"
		  "Jaaaaaaaaaa!!!!!"
		  "Soll ich etwa Beifall klatschen?">>

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
	 <COND (<FSET? ,HERE ,MAZEBIT>
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


