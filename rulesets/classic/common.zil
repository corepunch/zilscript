;"Death, treasure counting and other classic rules."

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


