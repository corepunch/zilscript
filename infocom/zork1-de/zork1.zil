"ZORK1 for
	        Zork I: The Great Underground Empire
	(c) Copyright 1983 Infocom, Inc. All Rights Reserved.
	-- GERMAN EDITION"

<VERSION YZIP>
<SETG ZORK-NUMBER 1>
;"PLUS-MODE selects Infocom's word-sized exit and GLOBAL layouts. This runtime
  writes the version 3 byte layouts, which the German verbs read without it."
<SET REDEFINE T>
<SETG NEW-VOC? T>
<FREQUENT-WORDS?>


<PRINC "Renovated ZORK I: The Great Underground Empire
">

<COND (<GASSIGNED? PREDGEN>
       <ID 0>)>
 
ON!-INITIAL
OFF!-INITIAL   ;"makes dubugging possible -pld"

;<DIRECTIONS NORTH EAST WEST SOUTH NE NW SE SW UP DOWN IN OUT LAND>
 <DIRECTIONS NORD OST WEST SUED NO NW SO SW RAUF RUNTER 
	     ;IN HINEIN ;OUT RAUS LANDEN> 

<PROPDEF SIZE 5>
<PROPDEF CAPACITY 0>
<PROPDEF VALUE 0>
<PROPDEF TVALUE 0>

<INSERT-FILE "languages.de.init">
;"The dungeon comes first so its rooms keep object numbers below 256, which
  the version 3 exit layout stores in one byte."
<INSERT-FILE "DUNGEON" T>
<INSERT-FILE "rulesets.classic.de">
<INSERT-FILE "ACTIONS" T>
;"HINTS is Infocom's full-screen hint menu (cursor windows and single-key
  input); hosts here show one text stream, so the game ships without it."
