;"German classic global objects: Zork's scenery and characters that every
  room may mention (the sailor, the grue, zorkmids).
  (c) Copyright 1983 Infocom, Inc. See LICENSE-ZORK-MIT."

<OBJECT SAILOR
	(LOC GLOBAL-OBJECTS)
	(SYNONYM SEEMANN)
	(DESC "Seemann")
	(FLAGS NDESCBIT DERBIT)
	(ACTION SAILOR-FCN)>

<ROUTINE SAILOR-FCN ()
	  <COND (<VERB? TELL>
		 <SETG P-CONT <>>
		 <SETG QUOTE-FLAG <>>
		 <TELL "So kannst du mit dem Seemann nicht sprechen." CR>)
		(<VERB? EXAMINE>
		 <TELL
"Hier ist kein Seemann zu sehen." CR>)
		(<VERB? HELLO>
		 <SETG HS <+ ,HS 1>>
		 <COND (<0? <MOD ,HS 20>>
			<TELL
"Du wiederholst dich." CR>)
		       (<0? <MOD ,HS 10>>
			<TELL
"Dieser Satz wird langsam langweilig." CR>)
		       (T
			<TELL "Hier passiert garnichts." CR>)>)>>

<OBJECT GRUE
	(LOC GLOBAL-OBJECTS)
	(SYNONYM GREUEL)
	(ADJECTIVE BOESARTIGE B\%OSARTIGE)
	(DESC "Greuel")
	(ADJDESC "lauernd")
	(FLAGS DASBIT)
	(ACTION GRUE-FUNCTION)>

<ROUTINE GRUE-FUNCTION ()
    <COND (<VERB? EXAMINE>
	   <TELL
"Das Greuel ist ein b%osartiges lauerndes Wesen in den dunklen Orten dieser Welt. Sein Lieblingsfressen besteht aus Abenteurern, aber sein uners%attlicher Appetit ist von seiner Furcht vor Licht gem%a%sigt Kein Greuel ist je bei Tageslicht gesehen worden, und nur wenige haben seine f%urchterlichen Krallen %uberlebt, um von dem grauenhaften Wesen zu erz%ahlen." CR>)
	  (<VERB? FIND>
	   <TELL
"Hier ist kein Greuel, aber ich bin sicher, das mindestens eines hier in der N%ahe im Dunkeln auf der Lauer liegt. Es w%are schon klug, auf die Lichtquelle zu achten." CR>)
	  (<VERB? LISTEN>
	   <TELL
"Es gibt keinen Ton von sich, aber es liegt immer in der N%ahe im Dunkeln."
CR>)>>

<OBJECT PATHOBJ
	(LOC GLOBAL-OBJECTS)
	(SYNONYM PFAD WALDPFAD)
        (ADJECTIVE ENGE ENGEN WINDENDER DURCHGANG)
	(DESC "Durchgang")
	(FLAGS NDESCBIT DERBIT)
	(ACTION PATH-OBJECT)>

<OBJECT ZORKMID
	(LOC GLOBAL-OBJECTS)
	(SYNONYM ZORKKNETE ZORKKNET)
	(DESC "Zorkknete")
	(FLAGS DIEBIT)
	(ACTION ZORKMID-FUNCTION)>

<ROUTINE ZORKMID-FUNCTION ()
    <COND (<VERB? EXAMINE>
	   <TELL
"Zorkknete ist die W%ahrung des Gro%sen Unterweltreiches." CR>)
	  (<VERB? FIND>
	   <TELL
"Man findet Zorkknete am besten, indem man rausgeht, und sie sucht." CR>)>>
