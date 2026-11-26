;"The world every adventure shares, whatever its rules or language: the exit
  table layout and DO-WALK, room and object description state, verbosity,
  moves, and the verb code identical in every language.
  (c) Copyright 1983 Infocom, Inc. See LICENSE-ZORK-MIT."

<GLOBAL VERBOSE <>>

<GLOBAL SUPER-BRIEF <>>

<GDECL (VERBOSE SUPER-BRIEF) <OR ATOM FALSE>>

<ROUTINE V-COMMAND-FILE ()
	 <DIRIN 1>
	 <RTRUE>>

<ROUTINE V-RECORD ()
	 <DIROUT 4>
	 <RTRUE>>

<ROUTINE V-UNRECORD ()
	 <DIROUT -4>
	 <RTRUE>>

<ROUTINE V-DRINK ()
	 <V-EAT>>

<ROUTINE PRE-DROP ()
	 <COND (<EQUAL? ,PRSO <LOC ,WINNER>>
		<PERFORM ,V?DISEMBARK ,PRSO>
		<RTRUE>)>>

<ROUTINE V-LOOK ()
	 <COND (<DESCRIBE-ROOM T>
		<DESCRIBE-OBJECTS T>)>>

<ROUTINE PRE-PUT ()
	 <COND (T
		<PRE-GIVE>)>> ;"That's easy for you to say..."

<ROUTINE V-RAISE ()
	 <V-LOWER>>

<ROUTINE V-SKIP ()
	 <TELL <PICK-ONE ,WHEEEEE> CR>>

<ROUTINE V-UNLOCK ()
	 <V-LOCK>>

<GLOBAL LIT <>>

<GLOBAL SPRAYED? <>>

<ROUTINE V-FIRST-LOOK ()
	 <COND (<DESCRIBE-ROOM>
		<COND (<NOT ,SUPER-BRIEF>
		       <DESCRIBE-OBJECTS>)>)>>

<GLOBAL DESC-OBJECT <>>

<GLOBAL MOVES 0>

<GLOBAL SCORE 0>

<GLOBAL BASE-SCORE 0>

<GLOBAL WON-FLAG <>>

<ROUTINE SCORE-OBJ (OBJ "AUX" TEMP)
	 <COND (<G? <SET TEMP <GETP .OBJ ,P?VALUE>> 0>
		<SCORE-UPD .TEMP>
		<PUTP .OBJ ,P?VALUE 0>)>>

<GLOBAL DEAD <>>

<GLOBAL LUCKY 1>

<GLOBAL FUMBLE-NUMBER 7>

<GLOBAL FUMBLE-PROB 8>

<CONSTANT REXIT 0>

<CONSTANT NEXITSTR 0>

<CONSTANT FEXITFCN 0>

<CONSTANT CEXITSTR 1>

<CONSTANT DEXITOBJ 1>

<GLOBAL INDENTS
	<TABLE (PURE)
	       ""
	       "  "
	       "    "
	       "      "
	       "        "
	       "          ">>

<ROUTINE DO-WALK (DIR)
	 <SETG P-WALK-DIR .DIR>
	 <PERFORM ,V?WALK .DIR>>

<ROUTINE GLOBAL-IN? (OBJ1 OBJ2 "AUX" TX)
	 <COND (<SET TX <GETPT .OBJ2 ,P?GLOBAL>>
		<ZMEMQB .OBJ1 .TX <- <PTSIZE .TX> 1>>)>>

<ROUTINE FIND-IN (WHERE WHAT "AUX" W)
	 <SET W <FIRST? .WHERE>>
	 <COND (<NOT .W>
		<RFALSE>)>
	 <REPEAT ()
		 <COND (<AND <FSET? .W .WHAT>
			     <NOT <EQUAL? .W ,ADVENTURER>>>
			<RETURN .W>)
		       (<NOT <SET W <NEXT? .W>>>
			<RETURN <>>)>>>

;"The liquid a room offers: a drinkable thing among its local globals, such
  as a river or a spring. Fill and drink find it when no object in
  the command is one."
<ROUTINE LIQUID-HERE ("AUX" TX (I 0) N O)
	 <COND (<NOT <SET TX <GETPT ,HERE ,P?GLOBAL>>>
		<RFALSE>)>
	 <SET N <PTSIZE .TX>>
	 <REPEAT ()
		 <COND (<NOT <L? .I .N>>
			<RFALSE>)
		       (<FSET? <SET O <GETB .TX .I>> ,DRINKBIT>
			<RETURN .O>)>
		 <SET I <+ .I 1>>>>

<ROUTINE NULL-F ("OPTIONAL" A1 A2)

	 <RFALSE>>

<GLOBAL LOAD-MAX 100>

<GLOBAL LOAD-ALLOWED 100>
