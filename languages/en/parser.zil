			"Generic PARSER file for
			    The ZORK Trilogy
		       started on 7/28/83 by MARC"

;"WHICH and TRAP retrofixes installed"

"Parser global variable convention:  All parser globals will
  begin with “P-”.  Local variables are not restricted in any
  way.
"


<INSERT-FILE "core.parser">

<SETG SIBREAKS ".,\"">


<GLOBAL P-IT-OBJECT <>>
;<GLOBAL LAST-PSEUDO-LOC <>>

;"Parser variables and temporaries"


" Grovel down the input finding the verb, prepositions, and noun clauses.
   If the input is <direction> or <walk> <direction>, fall out immediately
   setting PRSA to ,V?WALK and PRSO to <direction>.  Otherwise, perform
   all required orphaning, syntax checking, and noun clause lookup."

<ROUTINE PARSER ("AUX" (PTR ,P-LEXSTART) WRD (VAL 0) (VERB <>) (OF-FLAG <>)
		       OWINNER OMERGED LEN (DIR <>) (NW 0) (LW 0) (CNT -1))
	<REPEAT ()
		<COND (<G? <SET CNT <+ .CNT 1>> ,P-ITBLLEN> <RETURN>)
		      (T
		       <COND (<NOT ,P-OFLAG>
			      <PUT ,P-OTBL .CNT <GET ,P-ITBL .CNT>>)>
		       <PUT ,P-ITBL .CNT 0>)>>
	<SET OWINNER ,WINNER>
	<SET OMERGED ,P-MERGED>
	<SETG P-ADVERB <>>
	<SETG P-MERGED <>>
	<SETG P-END-ON-PREP <>>
	<PUT ,P-PRSO ,P-MATCHLEN 0>
	<PUT ,P-PRSI ,P-MATCHLEN 0>
	<PUT ,P-BUTS ,P-MATCHLEN 0>
	<COND (<AND <NOT ,QUOTE-FLAG> <N==? ,WINNER ,PLAYER>>
	       <SETG WINNER ,PLAYER>
	       <SETG HERE <META-LOC ,PLAYER>>
	       ;<COND (<NOT <FSET? <LOC ,WINNER> ,VEHBIT>>
		      <SETG HERE <LOC ,WINNER>>)>
	       <SETG LIT <LIT? ,HERE>>)>
	<COND (,RESERVE-PTR
	       <SET PTR ,RESERVE-PTR>
	       <STUFF ,RESERVE-LEXV ,P-LEXV>
	       <COND (<AND <NOT ,SUPER-BRIEF> <EQUAL? ,PLAYER ,WINNER>>
		      <CRLF>)>
	       <SETG RESERVE-PTR <>>
	       <SETG P-CONT <>>)
	      (,P-CONT
	       <SET PTR ,P-CONT>
	       <COND (<AND <NOT ,SUPER-BRIEF>
			   <EQUAL? ,PLAYER ,WINNER>
			   <NOT <VERB? SAY>>>
		      <CRLF>)>
	       <SETG P-CONT <>>)
	      (T
	       <SETG WINNER ,PLAYER>
	       <SETG QUOTE-FLAG <>>
	       <COND (<NOT <FSET? <LOC ,WINNER> ,VEHBIT>>
		      <SETG HERE <LOC ,WINNER>>)>
	       <SETG LIT <LIT? ,HERE>>
	       <COND (<NOT ,SUPER-BRIEF> <CRLF>)>
	       <TELL ">">
	       <READ ,P-INBUF ,P-LEXV>)>
	<SETG P-LEN <GETB ,P-LEXV ,P-LEXWORDS>>
	<COND (<ZERO? ,P-LEN> <TELL "I beg your pardon?" CR> <RFALSE>)>
	<COND (<EQUAL? <SET WRD <GET ,P-LEXV .PTR>> ,W?OOPS>
	       <COND (<EQUAL? <GET ,P-LEXV <+ .PTR ,P-LEXELEN>>
			      ,W?PERIOD ,W?COMMA>
		      <SET PTR <+ .PTR ,P-LEXELEN>>
		      <SETG P-LEN <- ,P-LEN 1>>)>
	       <COND (<NOT <G? ,P-LEN 1>>
		      <TELL "I can't help your clumsiness." CR>
		      <RFALSE>)
		     (<GET ,OOPS-TABLE ,O-PTR>
		      <COND (<AND <G? ,P-LEN 2>
				  <EQUAL? <GET ,P-LEXV <+ .PTR ,P-LEXELEN>>
					  ,W?QUOTE>>
			     <TELL
"Sorry, you can't correct mistakes in quoted text." CR>
			     <RFALSE>)
			    (<G? ,P-LEN 2>
			     <TELL
"Warning: only the first word after OOPS is used." CR>)>
		      <PUT ,AGAIN-LEXV <GET ,OOPS-TABLE ,O-PTR>
			   <GET ,P-LEXV <+ .PTR ,P-LEXELEN>>>
		      <SETG WINNER .OWINNER> ;"maybe fix oops vs. chars.?"
		      <INBUF-ADD <GETB ,P-LEXV <+ <* .PTR ,P-LEXELEN> 6>>
				 <GETB ,P-LEXV <+ <* .PTR ,P-LEXELEN> 7>>
				 <+ <* <GET ,OOPS-TABLE ,O-PTR> ,P-LEXELEN> 3>>
		      <STUFF ,AGAIN-LEXV ,P-LEXV>
		      <SETG P-LEN <GETB ,P-LEXV ,P-LEXWORDS>>
		      <SET PTR <GET ,OOPS-TABLE ,O-START>>
		      <INBUF-STUFF ,OOPS-INBUF ,P-INBUF>)
		     (T
		      <PUT ,OOPS-TABLE ,O-END <>>
		      <TELL "There was no word to replace!" CR>
		      <RFALSE>)>)
	      (T
	       <COND (<NOT <EQUAL? .WRD ,W?AGAIN ,W?G>>
		      <SETG P-NUMBER 0>)>
	       <PUT ,OOPS-TABLE ,O-END <>>)>
	<COND (<EQUAL? <GET ,P-LEXV .PTR> ,W?AGAIN ,W?G>
	       <COND (<ZERO? <GETB ,OOPS-INBUF 1>>
		      <TELL "Beg pardon?" CR>
		      <RFALSE>)
		     (,P-OFLAG
		      <TELL "It's difficult to repeat fragments." CR>
		      <RFALSE>)
		     (<NOT ,P-WON>
		      <TELL "That would just repeat a mistake." CR>
		      <RFALSE>)
		     (<G? ,P-LEN 1>
		      <COND (<OR <EQUAL? <GET ,P-LEXV <+ .PTR ,P-LEXELEN>>
					,W?PERIOD ,W?COMMA ,W?THEN>
				 <EQUAL? <GET ,P-LEXV <+ .PTR ,P-LEXELEN>>
					,W?AND>>
			     <SET PTR <+ .PTR <* 2 ,P-LEXELEN>>>
			     <PUTB ,P-LEXV ,P-LEXWORDS
				   <- <GETB ,P-LEXV ,P-LEXWORDS> 2>>)
			    (T
			     <TELL "I couldn't understand that sentence." CR>
			     <RFALSE>)>)
		     (T
		      <SET PTR <+ .PTR ,P-LEXELEN>>
		      <PUTB ,P-LEXV ,P-LEXWORDS
			    <- <GETB ,P-LEXV ,P-LEXWORDS> 1>>)>
	       <COND (<G? <GETB ,P-LEXV ,P-LEXWORDS> 0>
		      <STUFF ,P-LEXV ,RESERVE-LEXV>
		      <SETG RESERVE-PTR .PTR>)
		     (T
		      <SETG RESERVE-PTR <>>)>
	       ;<SETG P-LEN <GETB ,AGAIN-LEXV ,P-LEXWORDS>>
	       <SETG WINNER .OWINNER>
	       <SETG P-MERGED .OMERGED>
	       <INBUF-STUFF ,OOPS-INBUF ,P-INBUF>
	       <STUFF ,AGAIN-LEXV ,P-LEXV>
	       <SET CNT -1>
	       <SET DIR ,AGAIN-DIR>
	       <REPEAT ()
		<COND (<IGRTR? CNT ,P-ITBLLEN> <RETURN>)
		      (T <PUT ,P-ITBL .CNT <GET ,P-OTBL .CNT>>)>>)
	      (T
	       <STUFF ,P-LEXV ,AGAIN-LEXV>
	       <INBUF-STUFF ,P-INBUF ,OOPS-INBUF>
	       <PUT ,OOPS-TABLE ,O-START .PTR>
	       <PUT ,OOPS-TABLE ,O-LENGTH <* 4 ,P-LEN>>
	       <SET LEN
		    <* 2 <+ .PTR <* ,P-LEXELEN <GETB ,P-LEXV ,P-LEXWORDS>>>>>
	       <PUT ,OOPS-TABLE ,O-END <+ <GETB ,P-LEXV <- .LEN 1>>
					  <GETB ,P-LEXV <- .LEN 2>>>>
	       <SETG RESERVE-PTR <>>
	       <SET LEN ,P-LEN>
	       <SETG P-DIR <>>
	       <SETG P-NCN 0>
	       <SETG P-GETFLAGS 0>
	       <REPEAT ()
		<COND (<L? <SETG P-LEN <- ,P-LEN 1>> 0>
		       <SETG QUOTE-FLAG <>>
		       <RETURN>)
		      (<OR <SET WRD <GET ,P-LEXV .PTR>>
			   <SET WRD <NUMBER? .PTR>>>
		       <COND (<ZERO? ,P-LEN> <SET NW 0>)
			     (T <SET NW <GET ,P-LEXV <+ .PTR ,P-LEXELEN>>>)>
		       <COND (<AND <EQUAL? .WRD ,W?TO>
				   <EQUAL? .VERB ,ACT?TELL ;,ACT?ASK>>
			      <SET WRD ,W?QUOTE>)
			     (<AND <EQUAL? .WRD ,W?THEN>
				   <G? ,P-LEN 0>
				   <NOT .VERB>
				   <NOT ,QUOTE-FLAG> ;"Last NOT added 7/3">
			      <COND (<EQUAL? .LW 0 ,W?PERIOD>
				     <SET WRD ,W?THE>)
				    (ELSE
				     <PUT ,P-ITBL ,P-VERB ,ACT?TELL>
				     <PUT ,P-ITBL ,P-VERBN 0>
				     <SET WRD ,W?QUOTE>)>)>
		       <COND (<EQUAL? .WRD ,W?THEN ,W?PERIOD ,W?QUOTE>
			      <COND (<EQUAL? .WRD ,W?QUOTE>
				     <COND (,QUOTE-FLAG
					    <SETG QUOTE-FLAG <>>)
					   (T <SETG QUOTE-FLAG T>)>)>
			      <OR <ZERO? ,P-LEN>
				  <SETG P-CONT <+ .PTR ,P-LEXELEN>>>
			      <PUTB ,P-LEXV ,P-LEXWORDS ,P-LEN>
			      <RETURN>)
			     (<AND <SET VAL
					<WT? .WRD
					     ,PS?DIRECTION
					     ,P1?DIRECTION>>
				   <EQUAL? .VERB <> ,ACT?WALK>
				   <OR <EQUAL? .LEN 1>
				       <AND <EQUAL? .LEN 2>
					    <EQUAL? .VERB ,ACT?WALK>>
				       <AND <EQUAL? .NW
					            ,W?THEN
					            ,W?PERIOD
					            ,W?QUOTE>
					    <NOT <L? .LEN 2>>>
				       <AND ,QUOTE-FLAG
					    <EQUAL? .LEN 2>
					    <EQUAL? .NW ,W?QUOTE>>
				       <AND <G? .LEN 2>
					    <EQUAL? .NW ,W?COMMA ,W?AND>>>>
			      <SET DIR .VAL>
			      <COND (<EQUAL? .NW ,W?COMMA ,W?AND>
				     <PUT ,P-LEXV
					  <+ .PTR ,P-LEXELEN>
					  ,W?THEN>)>
			      <COND (<NOT <G? .LEN 2>>
				     <SETG QUOTE-FLAG <>>
				     <RETURN>)>)
			     (<AND <SET VAL <WT? .WRD ,PS?VERB ,P1?VERB>>
				   <NOT .VERB>>
			      <SET VERB .VAL>
			      <PUT ,P-ITBL ,P-VERB .VAL>
			      <PUT ,P-ITBL ,P-VERBN ,P-VTBL>
			      <PUT ,P-VTBL 0 .WRD>
			      <PUTB ,P-VTBL 2 <GETB ,P-LEXV
						    <SET CNT
							 <+ <* .PTR 2> 2>>>>
			      <PUTB ,P-VTBL 3 <GETB ,P-LEXV <+ .CNT 1>>>)
			     (<OR <SET VAL <WT? .WRD ,PS?PREPOSITION 0>>
				  <EQUAL? .WRD ,W?ALL ,W?ONE ;,W?BOTH>
				  <WT? .WRD ,PS?ADJECTIVE>
				  <WT? .WRD ,PS?OBJECT>>
			      <COND (<AND <G? ,P-LEN 1>
					  <EQUAL? .NW ,W?OF>
					  <ZERO? .VAL>
					  <NOT <EQUAL? .WRD
						       ,W?ALL ,W?ONE ,W?A>>
					  ;<NOT <EQUAL? .WRD ,W?BOTH>>>
				     <SET OF-FLAG T>)
				    (<AND <NOT <ZERO? .VAL>>
				          <OR <ZERO? ,P-LEN>
					      <EQUAL? .NW ,W?THEN ,W?PERIOD>>>
				     <SETG P-END-ON-PREP T>
				     <COND (<L? ,P-NCN 2>
					    <PUT ,P-ITBL ,P-PREP1 .VAL>
					    <PUT ,P-ITBL ,P-PREP1N .WRD>)>)
				    (<EQUAL? ,P-NCN 2>
				     <TELL
"There were too many nouns in that sentence." CR>
				     <RFALSE>)
				    (T
				     <SETG P-NCN <+ ,P-NCN 1>>
				     <SETG P-ACT .VERB>
				     <OR <SET PTR <CLAUSE .PTR .VAL .WRD>>
					 <RFALSE>>
				     <COND (<L? .PTR 0>
					    <SETG QUOTE-FLAG <>>
					    <RETURN>)>)>)
			     (<EQUAL? .WRD ,W?OF>
			      <COND (<OR <NOT .OF-FLAG>
					 <EQUAL? .NW ,W?PERIOD ,W?THEN>>
				     <CANT-USE .PTR>
				     <RFALSE>)
				    (T
				     <SET OF-FLAG <>>)>)
			     (<WT? .WRD ,PS?BUZZ-WORD>)
			     (<AND <EQUAL? .VERB ,ACT?TELL>
				   <WT? .WRD ,PS?VERB ,P1?VERB>
				   <EQUAL? ,WINNER ,PLAYER>>
			      <TELL
"Please consult your manual for the correct way to talk to other people
or creatures." CR>
			      <RFALSE>)
			     (T
			      <CANT-USE .PTR>
			      <RFALSE>)>)
		      (T
		       <UNKNOWN-WORD .PTR>
		       <RFALSE>)>
		<SET LW .WRD>
		<SET PTR <+ .PTR ,P-LEXELEN>>>)>
	<PUT ,OOPS-TABLE ,O-PTR <>>
	<COND (.DIR
	       <SETG PRSA ,V?WALK>
	       <SETG PRSO .DIR>
	       <SETG P-OFLAG <>>
	       <SETG P-WALK-DIR .DIR>
	       <SETG AGAIN-DIR .DIR>)
	      (ELSE
	       <COND (,P-OFLAG <ORPHAN-MERGE>)>
	       <SETG P-WALK-DIR <>>
	       <SETG AGAIN-DIR <>>
	       <COND (<AND <SYNTAX-CHECK>
			   <SNARF-OBJECTS>
			   <MANY-CHECK>
			   <TAKE-CHECK>>
		      T)>)>>


;"Check whether word pointed at by PTR is the correct part of speech.
   The second argument is the part of speech (,PS?<part of speech>).  The
   3rd argument (,P1?<part of speech>), if given, causes the value
   for that part of speech to be returned."

<ROUTINE WT? (PTR BIT "OPTIONAL" (B1 5) "AUX" (OFFS ,P-P1OFF) TYP)
	<COND (<BTST <SET TYP <GETB .PTR ,P-PSOFF>> .BIT>
	       <COND (<G? .B1 4> <RTRUE>)
		     (T
		      <SET TYP <BAND .TYP ,P-P1BITS>>
		      <COND (<NOT <EQUAL? .TYP .B1>> <SET OFFS <+ .OFFS 1>>)>
		      <GETB .PTR .OFFS>)>)>>

;" Scan through a noun clause, leave a pointer to its starting location"

<ROUTINE CLAUSE (PTR VAL WRD "AUX" OFF NUM (ANDFLG <>) (FIRST?? T) NW (LW 0))
	<SET OFF <* <- ,P-NCN 1> 2>>
	<COND (<NOT <EQUAL? .VAL 0>>
	       <PUT ,P-ITBL <SET NUM <+ ,P-PREP1 .OFF>> .VAL>
	       <PUT ,P-ITBL <+ .NUM 1> .WRD>
	       <SET PTR <+ .PTR ,P-LEXELEN>>)
	      (T <SETG P-LEN <+ ,P-LEN 1>>)>
	<COND (<ZERO? ,P-LEN> <SETG P-NCN <- ,P-NCN 1>> <RETURN -1>)>
	<PUT ,P-ITBL <SET NUM <+ ,P-NC1 .OFF>> <REST ,P-LEXV <* .PTR 2>>>
	<COND (<EQUAL? <GET ,P-LEXV .PTR> ,W?THE ,W?A ,W?AN>
	       <PUT ,P-ITBL .NUM <REST <GET ,P-ITBL .NUM> 4>>)>
	<REPEAT ()
		<COND (<L? <SETG P-LEN <- ,P-LEN 1>> 0>
		       <PUT ,P-ITBL <+ .NUM 1> <REST ,P-LEXV <* .PTR 2>>>
		       <RETURN -1>)>
		<COND (<OR <SET WRD <GET ,P-LEXV .PTR>>
			   <SET WRD <NUMBER? .PTR>>>
		       <COND (<ZERO? ,P-LEN> <SET NW 0>)
			     (T <SET NW <GET ,P-LEXV <+ .PTR ,P-LEXELEN>>>)>
		       <COND (<EQUAL? .WRD ,W?AND ,W?COMMA> <SET ANDFLG T>)
			     (<EQUAL? .WRD ,W?ALL ,W?ONE ;,W?BOTH>
			      <COND (<EQUAL? .NW ,W?OF>
				     <SETG P-LEN <- ,P-LEN 1>>
				     <SET PTR <+ .PTR ,P-LEXELEN>>)>)
			     (<OR <EQUAL? .WRD ,W?THEN ,W?PERIOD>
				  <AND <WT? .WRD ,PS?PREPOSITION>
				       <GET ,P-ITBL ,P-VERB>
				          ;"ADDED 4/27 FOR TURTLE,UP"
				       <NOT .FIRST??>>>
			      <SETG P-LEN <+ ,P-LEN 1>>
			      <PUT ,P-ITBL
				   <+ .NUM 1>
				   <REST ,P-LEXV <* .PTR 2>>>
			      <RETURN <- .PTR ,P-LEXELEN>>)
			     (<WT? .WRD ,PS?OBJECT>
			      <COND (<AND <G? ,P-LEN 0>
					  <EQUAL? .NW ,W?OF>
					  <NOT <EQUAL? .WRD ,W?ALL ,W?ONE>>>
				     T)
				    (<AND <WT? .WRD
					       ,PS?ADJECTIVE
					       ,P1?ADJECTIVE>
					  <NOT <EQUAL? .NW 0>>
					  <WT? .NW ,PS?OBJECT>>)
				    (<AND <NOT .ANDFLG>
					  <NOT <EQUAL? .NW ,W?BUT ,W?EXCEPT>>
					  <NOT <EQUAL? .NW ,W?AND ,W?COMMA>>>
				     <PUT ,P-ITBL
					  <+ .NUM 1>
					  <REST ,P-LEXV <* <+ .PTR 2> 2>>>
				     <RETURN .PTR>)
				    (T <SET ANDFLG <>>)>)
			     (<AND <OR ,P-MERGED
				       ,P-OFLAG
				       <NOT <EQUAL? <GET ,P-ITBL ,P-VERB> 0>>>
				   <OR <WT? .WRD ,PS?ADJECTIVE>
				       <WT? .WRD ,PS?BUZZ-WORD>>>)
			     (<AND .ANDFLG
				   <OR <WT? .WRD ,PS?DIRECTION>
				       <WT? .WRD ,PS?VERB>>>
			      <SET PTR <- .PTR 4>>
			      <PUT ,P-LEXV <+ .PTR 2> ,W?THEN>
			      <SETG P-LEN <+ ,P-LEN 2>>)
			     (<WT? .WRD ,PS?PREPOSITION> T)
			     (T
			      <CANT-USE .PTR>
			      <RFALSE>)>)
		      (T <UNKNOWN-WORD .PTR> <RFALSE>)>
		<SET LW .WRD>
		<SET FIRST?? <>>
		<SET PTR <+ .PTR ,P-LEXELEN>>>>


<GLOBAL P-DIRECTION 0>


;"New ORPHAN-MERGE for TRAP Retrofix 6/21/84"

<ROUTINE ORPHAN-MERGE ("AUX" (CNT -1) TEMP VERB BEG END (ADJ <>) WRD)
   <SETG P-OFLAG <>>
   <COND (<OR <EQUAL? <WT? <SET WRD <GET <GET ,P-ITBL ,P-VERBN> 0>>
			   ,PS?VERB ,P1?VERB>
		      <GET ,P-OTBL ,P-VERB>>
	      <NOT <ZERO? <WT? .WRD ,PS?ADJECTIVE>>>>
	  <SET ADJ T>)
	 (<AND <NOT <ZERO? <WT? .WRD ,PS?OBJECT ,P1?OBJECT>>>
	       <EQUAL? ,P-NCN 0>>
	  <PUT ,P-ITBL ,P-VERB 0>
	  <PUT ,P-ITBL ,P-VERBN 0>
	  <PUT ,P-ITBL ,P-NC1 <REST ,P-LEXV 2>>
	  <PUT ,P-ITBL ,P-NC1L <REST ,P-LEXV 6>>
	  <SETG P-NCN 1>)>
   <COND (<AND <NOT <ZERO? <SET VERB <GET ,P-ITBL ,P-VERB>>>>
	       <NOT .ADJ>
	       <NOT <EQUAL? .VERB <GET ,P-OTBL ,P-VERB>>>>
	  <RFALSE>)
	 (<EQUAL? ,P-NCN 2> <RFALSE>)
	 (<EQUAL? <GET ,P-OTBL ,P-NC1> 1>
	  <COND (<OR <EQUAL? <SET TEMP <GET ,P-ITBL ,P-PREP1>>
			  <GET ,P-OTBL ,P-PREP1>>
		     <ZERO? .TEMP>>
		 <COND (.ADJ
			<PUT ,P-OTBL ,P-NC1 <REST ,P-LEXV 2>>
			<COND (<ZERO? <GET ,P-ITBL ,P-NC1L>>
			       <PUT ,P-ITBL ,P-NC1L <REST ,P-LEXV 6>>)>
			<COND (<ZERO? ,P-NCN> <SETG P-NCN 1>)>)
		       (T
			<PUT ,P-OTBL ,P-NC1 <GET ,P-ITBL ,P-NC1>>)>
		 <PUT ,P-OTBL ,P-NC1L <GET ,P-ITBL ,P-NC1L>>)
		(T <RFALSE>)>)
	 (<EQUAL? <GET ,P-OTBL ,P-NC2> 1>
	  <COND (<OR <EQUAL? <SET TEMP <GET ,P-ITBL ,P-PREP1>>
			  <GET ,P-OTBL ,P-PREP2>>
		     <ZERO? .TEMP>>
		 <COND (.ADJ
			<PUT ,P-ITBL ,P-NC1 <REST ,P-LEXV 2>>
			<COND (<ZERO? <GET ,P-ITBL ,P-NC1L>>
			       <PUT ,P-ITBL ,P-NC1L <REST ,P-LEXV 6>>)>)>
		 <PUT ,P-OTBL ,P-NC2 <GET ,P-ITBL ,P-NC1>>
		 <PUT ,P-OTBL ,P-NC2L <GET ,P-ITBL ,P-NC1L>>
		 <SETG P-NCN 2>)
		(T <RFALSE>)>)
	 (<NOT <ZERO? ,P-ACLAUSE>>
	  <COND (<AND <NOT <EQUAL? ,P-NCN 1>> <NOT .ADJ>>
		 <SETG P-ACLAUSE <>>
		 <RFALSE>)
		(T
		 <SET BEG <GET ,P-ITBL ,P-NC1>>
		 <COND (.ADJ <SET BEG <REST ,P-LEXV 2>> <SET ADJ <>>)>
		 <SET END <GET ,P-ITBL ,P-NC1L>>
		 <REPEAT ()
			 <SET WRD <GET .BEG 0>>
			 <COND (<EQUAL? .BEG .END>
				<COND (.ADJ <ACLAUSE-WIN .ADJ> <RETURN>)
				      (T <SETG P-ACLAUSE <>> <RFALSE>)>)
			       (<AND <NOT .ADJ>
				     <OR <BTST <GETB .WRD ,P-PSOFF>
					       ,PS?ADJECTIVE>
					 <EQUAL? .WRD ,W?ALL ,W?ONE>>>
				<SET ADJ .WRD>)
			       (<EQUAL? .WRD ,W?ONE>
				<ACLAUSE-WIN .ADJ>
				<RETURN>)
			       (<BTST <GETB .WRD ,P-PSOFF> ,PS?OBJECT>
				<COND (<EQUAL? .WRD ,P-ANAM>
				       <ACLAUSE-WIN .ADJ>)
				      (T
				       <NCLAUSE-WIN>)>
				<RETURN>)>
			 <SET BEG <REST .BEG ,P-WORDLEN>>
			 <COND (<EQUAL? .END 0>
				<SET END .BEG>
				<SETG P-NCN 1>
				<PUT ,P-ITBL ,P-NC1 <BACK .BEG 4>>
				<PUT ,P-ITBL ,P-NC1L .BEG>)>>)>)>
   <PUT ,P-VTBL 0 <GET ,P-OVTBL 0>>
   <PUTB ,P-VTBL 2 <GETB ,P-OVTBL 2>>
   <PUTB ,P-VTBL 3 <GETB ,P-OVTBL 3>>
   <PUT ,P-OTBL ,P-VERBN ,P-VTBL>
   <PUTB ,P-VTBL 2 0>
   <REPEAT ()
	   <COND (<G? <SET CNT <+ .CNT 1>> ,P-ITBLLEN>
		  <SETG P-MERGED T>
		  <RTRUE>)
		 (T <PUT ,P-ITBL .CNT <GET ,P-OTBL .CNT>>)>>
   T>


;"Print undefined word in input.
   PTR points to the unknown word in P-LEXV"

<ROUTINE WORD-PRINT (CNT BUF)
	 <REPEAT ()
		 <COND (<DLESS? CNT 0> <RETURN>)
		       (ELSE
			<PRINTC <GETB ,P-INBUF .BUF>>
			<SET BUF <+ .BUF 1>>)>>>

<ROUTINE UNKNOWN-WORD (PTR "AUX" BUF)
	<PUT ,OOPS-TABLE ,O-PTR .PTR>
	<COND (<VERB? SAY>
	       <TELL "Nothing happens." CR>
	       <RFALSE>)>
	<TELL "I don't know the word \"">
	<WORD-PRINT <GETB <REST ,P-LEXV <SET BUF <* .PTR 2>>> 2>
		    <GETB <REST ,P-LEXV .BUF> 3>>
	<TELL "\"." CR>
	<SETG QUOTE-FLAG <>>
	<SETG P-OFLAG <>>>

<ROUTINE CANT-USE (PTR "AUX" BUF)
	<COND (<VERB? SAY>
	       <TELL "Nothing happens." CR>
	       <RFALSE>)>
	<TELL "You used the word \"">
	<WORD-PRINT <GETB <REST ,P-LEXV <SET BUF <* .PTR 2>>> 2>
		    <GETB <REST ,P-LEXV .BUF> 3>>
	<TELL "\" in a way that I don't understand." CR>
	<SETG QUOTE-FLAG <>>
	<SETG P-OFLAG <>>>


<ROUTINE SYNTAX-CHECK ("AUX" SYN LEN NUM OBJ
		       	    (DRIVE1 <>) (DRIVE2 <>) PREP VERB TMP)
	<COND (<ZERO? <SET VERB <GET ,P-ITBL ,P-VERB>>>
	       <TELL "There was no verb in that sentence!" CR>
	       <RFALSE>)>
	<SET SYN <GET ,VERBS <- 255 .VERB>>>
	<SET LEN <GETB .SYN 0>>
	<SET SYN <REST .SYN>>
	<REPEAT ()
		<SET NUM <BAND <GETB .SYN ,P-SBITS> ,P-SONUMS>>
		<COND (<G? ,P-NCN .NUM> T)
		      (<AND <NOT <L? .NUM 1>>
			    <ZERO? ,P-NCN>
			    <OR <ZERO? <SET PREP <GET ,P-ITBL ,P-PREP1>>>
				<EQUAL? .PREP <GETB .SYN ,P-SPREP1>>>>
		       <SET DRIVE1 .SYN>)
		      (<EQUAL? <GETB .SYN ,P-SPREP1> <GET ,P-ITBL ,P-PREP1>>
		       <COND (<AND <EQUAL? .NUM 2> <EQUAL? ,P-NCN 1>>
			      <SET DRIVE2 .SYN>)
			     (<EQUAL? <GETB .SYN ,P-SPREP2>
				   <GET ,P-ITBL ,P-PREP2>>
			      <SYNTAX-FOUND .SYN>
			      <RTRUE>)>)>
		<COND (<DLESS? LEN 1>
		       <COND (<OR .DRIVE1 .DRIVE2> <RETURN>)
			     (T
			      <TELL
"That sentence isn't one I recognize." CR>
			      <RFALSE>)>)
		      (T <SET SYN <REST .SYN ,P-SYNLEN>>)>>
	<COND (<AND .DRIVE1
		    <SET OBJ
			 <GWIM <GETB .DRIVE1 ,P-SFWIM1>
			       <GETB .DRIVE1 ,P-SLOC1>
			       <GETB .DRIVE1 ,P-SPREP1>>>>
	       <PUT ,P-PRSO ,P-MATCHLEN 1>
	       <PUT ,P-PRSO 1 .OBJ>
	       <SYNTAX-FOUND .DRIVE1>)
	      (<AND .DRIVE2
		    <SET OBJ
			 <GWIM <GETB .DRIVE2 ,P-SFWIM2>
			       <GETB .DRIVE2 ,P-SLOC2>
			       <GETB .DRIVE2 ,P-SPREP2>>>>
	       <PUT ,P-PRSI ,P-MATCHLEN 1>
	       <PUT ,P-PRSI 1 .OBJ>
	       <SYNTAX-FOUND .DRIVE2>)
	      (<EQUAL? .VERB ,ACT?FIND>
	       <TELL "That question can't be answered." CR>
	       <RFALSE>)
	      (<NOT <EQUAL? ,WINNER ,PLAYER>>
	       <CANT-ORPHAN>)
	      (T
	       <ORPHAN .DRIVE1 .DRIVE2>
	       <TELL "What do you want to ">
	       <SET TMP <GET ,P-OTBL ,P-VERBN>>
	       <COND (<EQUAL? .TMP 0> <TELL "tell">)
		     (<ZERO? <GETB ,P-VTBL 2>>
		      <PRINTB <GET .TMP 0>>)
		     (T
		      <WORD-PRINT <GETB .TMP 2> <GETB .TMP 3>>
		      <PUTB ,P-VTBL 2 0>)>
	       <COND (.DRIVE2
		      <TELL " ">
		      <THING-PRINT T T>)>
	       <SETG P-OFLAG T>
	       <PREP-PRINT <COND (.DRIVE1 <GETB .DRIVE1 ,P-SPREP1>)
				 (T <GETB .DRIVE2 ,P-SPREP2>)>>
	       <TELL "?" CR>
	       <RFALSE>)>>

<ROUTINE CANT-ORPHAN ()
	 <TELL "\"I don't understand! What are you referring to?\"" CR>
	 <RFALSE>>




<ROUTINE BUFFER-PRINT (BEG END CP
		       "AUX" (NOSP T) WRD (FIRST?? T) (PN <>) (Q? <>))
	 <REPEAT ()
		<COND (<EQUAL? .BEG .END> <RETURN>)
		      (T
		       <SET WRD <GET .BEG 0>>
		       <COND ;(<EQUAL? .WRD ,W?$BUZZ> T)
			     (<EQUAL? .WRD ,W?COMMA>
			      <TELL ", ">)
			     (.NOSP <SET NOSP <>>)
			     (ELSE <TELL " ">)>
		       <COND (<EQUAL? .WRD ,W?PERIOD ,W?COMMA>
			      <SET NOSP T>)
			     (<EQUAL? .WRD ,W?ME>
			      <PRINTD ,ME>
			      <SET PN T>)
			     (<EQUAL? .WRD ,W?INTNUM>
			      <PRINTN ,P-NUMBER>
			      <SET PN T>)
			     (T
			      <COND (<AND .FIRST?? <NOT .PN> .CP>
				     <TELL "the ">)>
			      <COND (<OR ,P-OFLAG ,P-MERGED> <PRINTB .WRD>)
				    (<AND <EQUAL? .WRD ,W?IT>
					  <ACCESSIBLE? ,P-IT-OBJECT>>
				     <PRINTD ,P-IT-OBJECT>)
				    (T
				     <WORD-PRINT <GETB .BEG 2>
						 <GETB .BEG 3>>)>
			      <SET FIRST?? <>>)>)>
		<SET BEG <REST .BEG ,P-WORDLEN>>>>

<ROUTINE PREP-PRINT (PREP "AUX" WRD)
	<COND (<NOT <ZERO? .PREP>>
	       <TELL " ">
	       <COND ;(<EQUAL? .PREP ,PR?THROUGH>
		      <TELL "through">)
		     (T
		      <SET WRD <PREP-FIND .PREP>>
		      <PRINTB .WRD>)>)>>

;"An answer's adjective replaces the question's: a phrase is matched by its
  first adjective only, so SMALL KEY answered SAFE must become SAFE KEY."
<ROUTINE CLAUSE-COPY (SRC DEST "OPTIONAL" (INSRT <>) "AUX" BEG END WRD)
	<SET BEG <GET .SRC <GET ,P-CCTBL ,CC-SBPTR>>>
	<SET END <GET .SRC <GET ,P-CCTBL ,CC-SEPTR>>>
	<PUT .DEST
	     <GET ,P-CCTBL ,CC-DBPTR>
	     <REST ,P-OCLAUSE
		   <+ <* <GET ,P-OCLAUSE ,P-MATCHLEN> ,P-LEXELEN> 2>>>
	<REPEAT ()
		<COND (<EQUAL? .BEG .END>
		       <PUT .DEST
			    <GET ,P-CCTBL ,CC-DEPTR>
			    <REST ,P-OCLAUSE
				  <+ <* <GET ,P-OCLAUSE ,P-MATCHLEN> ,P-LEXELEN>
				     2>>>
		       <RETURN>)
		      (T
		       <SET WRD <GET .BEG 0>>
		       <COND (<AND .INSRT <EQUAL? ,P-ANAM .WRD>>
			      <CLAUSE-ADD .INSRT>)>
		       <COND (<OR <NOT .INSRT>
				  <EQUAL? ,P-ANAM .WRD>
				  <ZERO? <WT? .WRD ,PS?ADJECTIVE>>>
			      <CLAUSE-ADD .WRD>)>)>
		<SET BEG <REST .BEG ,P-WORDLEN>>>>




<ROUTINE GWIM (GBIT LBIT PREP "AUX" OBJ)
	<COND (<EQUAL? .GBIT ,RMUNGBIT>
	       <RETURN ,ROOMS>)>
	<SETG P-GWIMBIT .GBIT>
	<SETG P-SLOCBITS .LBIT>
	<PUT ,P-MERGE ,P-MATCHLEN 0>
	<COND (<GET-OBJECT ,P-MERGE <>>
	       <SETG P-GWIMBIT 0>
	       <COND (<EQUAL? <GET ,P-MERGE ,P-MATCHLEN> 1>
		      <SET OBJ <GET ,P-MERGE 1>>
		      <TELL "(">
		      <COND (<AND <NOT <ZERO? .PREP>>
				  <NOT ,P-END-ON-PREP>>
			     <PRINTB <SET PREP <PREP-FIND .PREP>>>
			     <COND (<EQUAL? .PREP ,W?OUT>
				    <TELL " of">)>
			     <TELL " ">
			     <COND (<EQUAL? .OBJ ,HANDS>
				    <TELL "your hands">)
				   (T
				    <TELL "the " D .OBJ>)>
			     <TELL ")" CR>)
			    (ELSE
			     <TELL D .OBJ ")" CR>)>
		      .OBJ)>)
	      (T <SETG P-GWIMBIT 0> <RFALSE>)>>



<GLOBAL P-ADJN <>>



<ROUTINE SNARFEM (PTR EPTR TBL "AUX" (BUT <>) LEN WV WRD NW (WAS-ALL <>))
   <SETG P-AND <>>
   <COND (<EQUAL? ,P-GETFLAGS ,P-ALL>
	  <SET WAS-ALL T>)>
   <SETG P-GETFLAGS 0>
   <PUT .TBL ,P-MATCHLEN 0>
   <SET WRD <GET .PTR 0>>
   <REPEAT ()
	   <COND (<EQUAL? .PTR .EPTR>
		  <SET WV <GET-OBJECT <OR .BUT .TBL>>>
		  <COND (.WAS-ALL <SETG P-GETFLAGS ,P-ALL>)>
		  <RETURN .WV>)
		 (T
		  <COND (<==? .EPTR <REST .PTR ,P-WORDLEN>>
			 <SET NW 0>)
			(T <SET NW <GET .PTR ,P-LEXELEN>>)>
		  <COND (<EQUAL? .WRD ,W?ALL ;,W?BOTH>
			 <SETG P-GETFLAGS ,P-ALL>
			 <COND (<EQUAL? .NW ,W?OF>
				<SET PTR <REST .PTR ,P-WORDLEN>>)>)
			(<EQUAL? .WRD ,W?BUT ,W?EXCEPT>
			 <OR <GET-OBJECT <OR .BUT .TBL>> <RFALSE>>
			 <SET BUT ,P-BUTS>
			 <PUT .BUT ,P-MATCHLEN 0>)
			(<EQUAL? .WRD ,W?A ,W?ONE>
			 <COND (<NOT ,P-ADJ>
				<SETG P-GETFLAGS ,P-ONE>
				<COND (<EQUAL? .NW ,W?OF>
				       <SET PTR <REST .PTR ,P-WORDLEN>>)>)
			       (T
				<SETG P-NAM ,P-ONEOBJ>
				<OR <GET-OBJECT <OR .BUT .TBL>> <RFALSE>>
				<AND <ZERO? .NW> <RTRUE>>)>)
			(<AND <EQUAL? .WRD ,W?AND ,W?COMMA>
			      <NOT <EQUAL? .NW ,W?AND ,W?COMMA>>>
			 <SETG P-AND T>
			 <OR <GET-OBJECT <OR .BUT .TBL>> <RFALSE>>
			 T)
			(<WT? .WRD ,PS?BUZZ-WORD>)
			(<EQUAL? .WRD ,W?AND ,W?COMMA>)
			(<EQUAL? .WRD ,W?OF>
			 <COND (<ZERO? ,P-GETFLAGS>
				<SETG P-GETFLAGS ,P-INHIBIT>)>)
			(<AND <SET WV <WT? .WRD ,PS?ADJECTIVE ,P1?ADJECTIVE>>
			      <NOT ,P-ADJ>>
			 <SETG P-ADJ .WV>
			 <SETG P-ADJN .WRD>)
			(<WT? .WRD ,PS?OBJECT ,P1?OBJECT>
			 <SETG P-NAM .WRD>
			 <SETG P-ONEOBJ .WRD>)>)>
	   <COND (<NOT <EQUAL? .PTR .EPTR>>
		  <SET PTR <REST .PTR ,P-WORDLEN>>
		  <SET WRD .NW>)>>>


<ROUTINE GET-OBJECT (TBL
		     "OPTIONAL" (VRB T)
		     "AUX" BITS LEN XBITS TLEN (GCHECK <>) (OLEN 0) OBJ)
	 <SET XBITS ,P-SLOCBITS>
	 <SET TLEN <GET .TBL ,P-MATCHLEN>>
	 <COND (<BTST ,P-GETFLAGS ,P-INHIBIT> <RTRUE>)>
	 <COND (<AND <NOT ,P-NAM> ,P-ADJ>
		<COND (<WT? ,P-ADJN ,PS?OBJECT ,P1?OBJECT>
		       <SETG P-NAM ,P-ADJN>
		       <SETG P-ADJ <>>)
		      %<COND (<==? ,ZORK-NUMBER 3>
			      '(<SET BITS
				     <WT? ,P-ADJN
					  ,PS?DIRECTION ,P1?DIRECTION>>
				<SETG P-ADJ <>>
				<PUT .TBL ,P-MATCHLEN 1>
				<PUT .TBL 1 ,INTDIR>
				<SETG P-DIRECTION .BITS>
				<RTRUE>))
			     (ELSE '(<NULL-F> T))>>)>
	 <COND (<AND <NOT ,P-NAM>
		     <NOT ,P-ADJ>
		     <NOT <EQUAL? ,P-GETFLAGS ,P-ALL>>
		     <ZERO? ,P-GWIMBIT>>
		<COND (.VRB
		       <TELL
"There seems to be a noun missing in that sentence!" CR>)>
		<RFALSE>)>
	 <COND (<OR <NOT <EQUAL? ,P-GETFLAGS ,P-ALL>> <ZERO? ,P-SLOCBITS>>
		<SETG P-SLOCBITS -1>)>
	 <SETG P-TABLE .TBL>
	 <PROG ()
	       <COND (.GCHECK <GLOBAL-CHECK .TBL>)
		     (T
		      <COND (,LIT
			     <FCLEAR ,PLAYER ,TRANSBIT>
			     <DO-SL ,HERE ,SOG ,SIR>
			     <FSET ,PLAYER ,TRANSBIT>)>
		      <DO-SL ,PLAYER ,SH ,SC>)>
	       <SET LEN <- <GET .TBL ,P-MATCHLEN> .TLEN>>
	       <COND (<BTST ,P-GETFLAGS ,P-ALL>)
		     (<AND <BTST ,P-GETFLAGS ,P-ONE>
			   <NOT <ZERO? .LEN>>>
		      <COND (<NOT <EQUAL? .LEN 1>>
			     <PUT .TBL 1 <GET .TBL <RANDOM .LEN>>>
			     <TELL "(How about the ">
			     <PRINTD <GET .TBL 1>>
			     <TELL "?)" CR>)>
		      <PUT .TBL ,P-MATCHLEN 1>)
		     (<OR <G? .LEN 1>
			  <AND <ZERO? .LEN> <NOT <EQUAL? ,P-SLOCBITS -1>>>>
		      <COND (<EQUAL? ,P-SLOCBITS -1>
			     <SETG P-SLOCBITS .XBITS>
			     <SET OLEN .LEN>
			     <PUT .TBL
				  ,P-MATCHLEN
				  <- <GET .TBL ,P-MATCHLEN> .LEN>>
			     <AGAIN>)
			    (T
			     <COND (<ZERO? .LEN> <SET LEN .OLEN>)>
			     <COND (<NOT <EQUAL? ,WINNER ,PLAYER>>
				    <CANT-ORPHAN>
				    <RFALSE>)
				   (<AND .VRB ,P-NAM>
				    <WHICH-PRINT .TLEN .LEN .TBL>
				    <SETG P-ACLAUSE
					  <COND (<EQUAL? .TBL ,P-PRSO> ,P-NC1)
						(T ,P-NC2)>>
				    <SETG P-AADJ ,P-ADJ>
				    <SETG P-ANAM ,P-NAM>
				    <ORPHAN <> <>>
				    <SETG P-OFLAG T>)
				   (.VRB
				    <TELL
"There seems to be a noun missing in that sentence!" CR>)>
			     <SETG P-NAM <>>
			     <SETG P-ADJ <>>
			     <RFALSE>)>)>
	       <COND (<AND <ZERO? .LEN> .GCHECK>
		      <COND (.VRB
			     ;"next added 1/2/85 by JW"
			     <SETG P-SLOCBITS .XBITS>
			     <COND (<OR ,LIT <VERB? TELL ;WHERE ;WHAT ;WHO>>
				    ;"Changed 6/10/83 - MARC"
				    <OBJ-FOUND ,NOT-HERE-OBJECT .TBL>
				    <SETG P-XNAM ,P-NAM>
				    <SETG P-XADJ ,P-ADJ>
				    <SETG P-XADJN ,P-ADJN>
				    <SETG P-NAM <>>
				    <SETG P-ADJ <>>
				    <SETG P-ADJN <>>
				    <RTRUE>)
				   (T <TELL "It's too dark to see!" CR>)>)>
		      <SETG P-NAM <>>
		      <SETG P-ADJ <>>
		      <RFALSE>)
		     (<ZERO? .LEN> <SET GCHECK T> <AGAIN>)>
	       <SETG P-SLOCBITS .XBITS>
	       <SETG P-NAM <>>
	       <SETG P-ADJ <>>
	       <RTRUE>>>

<GLOBAL P-XADJN <>>

<ROUTINE WHICH-PRINT (TLEN LEN TBL "AUX" OBJ RLEN)
	 <SET RLEN .LEN>
	 <TELL "Which ">
         <COND (<OR ,P-OFLAG ,P-MERGED ,P-AND>
		<PRINTB <COND (,P-NAM ,P-NAM)
			      (,P-ADJ ,P-ADJN)
			      (ELSE ,W?ONE)>>)
	       (ELSE
		<THING-PRINT <EQUAL? .TBL ,P-PRSO>>)>
	 <TELL " do you mean, ">
	 <REPEAT ()
		 <SET TLEN <+ .TLEN 1>>
		 <SET OBJ <GET .TBL .TLEN>>
		 <TELL "the " D .OBJ>
		 <COND (<EQUAL? .LEN 2>
		        <COND (<NOT <EQUAL? .RLEN 2>> <TELL ",">)>
		        <TELL " or ">)
		       (<G? .LEN 2> <TELL ", ">)>
		 <COND (<L? <SET LEN <- .LEN 1>> 1>
		        <TELL "?" CR>
		        <RETURN>)>>>


<ROUTINE GLOBAL-CHECK (TBL "AUX" LEN RMG RMGL (CNT 0) OBJ OBITS)
	<SET LEN <GET .TBL ,P-MATCHLEN>>
	<SET OBITS ,P-SLOCBITS>
	<COND (<SET RMG <GETPT ,HERE ,P?GLOBAL>>
	       <SET RMGL <- <PTSIZE .RMG> 1>>
	       <REPEAT ()
		       <COND (<THIS-IT? <SET OBJ <GETB .RMG .CNT>> .TBL>
			      <OBJ-FOUND .OBJ .TBL>)>
		       <COND (<IGRTR? CNT .RMGL> <RETURN>)>>)>
	<COND (<SET RMG <GETPT ,HERE ,P?PSEUDO>>
	       <SET RMGL <- </ <PTSIZE .RMG> 4> 1>>
	       <SET CNT 0>
	       <REPEAT ()
		       <COND (<EQUAL? ,P-NAM <GET .RMG <* .CNT 2>>>
			      <PUTP ,PSEUDO-OBJECT
				    ,P?ACTION
				    <GET .RMG <+ <* .CNT 2> 1>>>
			      <OBJ-FOUND ,PSEUDO-OBJECT .TBL>
			      <RETURN>)
		             (<IGRTR? CNT .RMGL> <RETURN>)>>)>
	<COND (<EQUAL? <GET .TBL ,P-MATCHLEN> .LEN>
	       <SETG P-SLOCBITS -1>
	       <SETG P-TABLE .TBL>
	       <DO-SL ,GLOBAL-OBJECTS 1 1>
	       <SETG P-SLOCBITS .OBITS>
	       <COND (<AND <ZERO? <GET .TBL ,P-MATCHLEN>>
			   <EQUAL? ,PRSA ,V?LOOK-INSIDE ,V?SEARCH ,V?EXAMINE>>
		      <DO-SL ,ROOMS 1 1>)>)>>



<ROUTINE ITAKE-CHECK (TBL IBITS "AUX" PTR OBJ TAKEN)
	 #DECL ((TBL) TABLE (IBITS PTR) FIX (OBJ) OBJECT
		(TAKEN) <OR FALSE FIX ATOM>)
	 <COND (<AND <SET PTR <GET .TBL ,P-MATCHLEN>>
		     <OR <BTST .IBITS ,SHAVE>
			 <BTST .IBITS ,STAKE>>>
		<REPEAT ()
			<COND (<L? <SET PTR <- .PTR 1>> 0> <RETURN>)
			      (T
			       <SET OBJ <GET .TBL <+ .PTR 1>>>
			       <COND (<EQUAL? .OBJ ,IT>
				      <COND (<NOT <ACCESSIBLE? ,P-IT-OBJECT>>
					     <TELL
"I don't see what you're referring to." CR>
					     <RFALSE>)
					    (T
					     <SET OBJ ,P-IT-OBJECT>)>)>
			       <COND (<AND <NOT <HELD? .OBJ>>
					   <NOT <EQUAL? .OBJ ,HANDS ,ME>>>
				      <SETG PRSO .OBJ>
				      <COND (<FSET? .OBJ ,TRYTAKEBIT>
					     <SET TAKEN T>)
					    (<NOT <EQUAL? ,WINNER ,ADVENTURER>>
					     <SET TAKEN <>>)
					    (<AND <BTST .IBITS ,STAKE>
						  <EQUAL? <ITAKE <>> T>>
					     <SET TAKEN <>>)
					    (T <SET TAKEN T>)>
				      <COND (<AND .TAKEN
						  <BTST .IBITS ,SHAVE>
						  <EQUAL? ,WINNER
							  ,ADVENTURER>>
					     <COND (<EQUAL? .OBJ
							    ,NOT-HERE-OBJECT>
						    <TELL
"You don't have that!" CR>
						    <RFALSE>)>
					     <TELL "You don't have the ">
					     <PRINTD .OBJ>
					     <TELL "." CR>
					     <RFALSE>)
					    (<AND <NOT .TAKEN>
						  <EQUAL? ,WINNER ,ADVENTURER>>
					     <TELL "(Taken)" CR>)>)>)>>)
	       (T)>>

<ROUTINE MANY-CHECK ("AUX" (LOSS <>) TMP)
	<COND (<AND <G? <GET ,P-PRSO ,P-MATCHLEN> 1>
		    <NOT <BTST <GETB ,P-SYNTAX ,P-SLOC1> ,SMANY>>>
	       <SET LOSS 1>)
	      (<AND <G? <GET ,P-PRSI ,P-MATCHLEN> 1>
		    <NOT <BTST <GETB ,P-SYNTAX ,P-SLOC2> ,SMANY>>>
	       <SET LOSS 2>)>
	<COND (.LOSS
	       <TELL "You can't use multiple ">
	       <COND (<EQUAL? .LOSS 2> <TELL "in">)>
	       <TELL "direct objects with \"">
	       <SET TMP <GET ,P-ITBL ,P-VERBN>>
	       <COND (<ZERO? .TMP> <TELL "tell">)
		     (<OR ,P-OFLAG ,P-MERGED>
		      <PRINTB <GET .TMP 0>>)
		     (T
		      <WORD-PRINT <GETB .TMP 2> <GETB .TMP 3>>)>
	       <TELL "\"." CR>
	       <RFALSE>)
	      (T)>>




<ROUTINE THIS-IT? (OBJ TBL "AUX" SYNS)
 <COND (<FSET? .OBJ ,INVISIBLE> <RFALSE>)
       (<AND ,P-NAM
	     <NOT <ZMEMQ ,P-NAM
			 <SET SYNS <GETPT .OBJ ,P?SYNONYM>>
			 <- </ <PTSIZE .SYNS> 2> 1>>>>
	<RFALSE>)
       (<AND ,P-ADJ
	     <OR <NOT <SET SYNS <GETPT .OBJ ,P?ADJECTIVE>>>
		 <NOT <ZMEMQB ,P-ADJ .SYNS <- <PTSIZE .SYNS> 1>>>>>
	<RFALSE>)
       (<AND <NOT <ZERO? ,P-GWIMBIT>> <NOT <FSET? .OBJ ,P-GWIMBIT>>>
	<RFALSE>)>
 <RTRUE>>

<ROUTINE ACCESSIBLE? (OBJ "AUX" (L <LOC .OBJ>)) ;"can player TOUCH object?"
	 ;"revised 5/2/84 by SEM and SWG"
	 <COND (<FSET? .OBJ ,INVISIBLE>
		<RFALSE>)
	       ;(<EQUAL? .OBJ ,PSEUDO-OBJECT>
		<COND (<EQUAL? ,LAST-PSEUDO-LOC ,HERE>
		       <RTRUE>)
		      (T
		       <RFALSE>)>)
	       (<NOT .L>
		<RFALSE>)
	       (<EQUAL? .L ,GLOBAL-OBJECTS>
		<RTRUE>)
	       (<AND <EQUAL? .L ,LOCAL-GLOBALS>
		     <GLOBAL-IN? .OBJ ,HERE>>
		<RTRUE>)
	       (<NOT <EQUAL? <META-LOC .OBJ> ,HERE <LOC ,WINNER>>>
		<RFALSE>)
	       (<EQUAL? .L ,WINNER ,HERE <LOC ,WINNER>>
		<RTRUE>)
	       (<AND <FSET? .L ,OPENBIT>
		     <ACCESSIBLE? .L>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

