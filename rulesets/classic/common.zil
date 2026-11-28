;"Classic rules without text, shared by every language: death and treasure
  counting, spraying, and verbs whose code is the same in English and German.
  Rules with player-facing text are in rulesets/classic/<language>-verbs.zil.
  (c) Copyright 1983 Infocom, Inc. See LICENSE-ZORK-MIT."

<GLOBAL HS 0> ;"counts occurences of HELLO, SAILOR"


<ROUTINE V-READ-PAGE ()
	 <PERFORM ,V?READ ,PRSO>
	 <RTRUE>>


<ROUTINE V-SPRAY ()
	 <V-SQUEEZE>>

<ROUTINE V-SSPRAY ()
	 <PERFORM ,V?SPRAY ,PRSI ,PRSO>>


<GLOBAL DEATHS 0>


<ROUTINE MUNG-ROOM (RM STR)
	 <FSET .RM ,RMUNGBIT>
	 <PUTP .RM ,P?LDESC .STR>>


