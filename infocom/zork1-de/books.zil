;"German book substrate, using the parser, grammar, articles and loop from
Infocom's German edition with the Lua runtime's dictionary and IO."
<LANGUAGE GERMAN>
<SETG ZORK-NUMBER 1>
<SETG BOOK-MODE T>
<DIRECTIONS NORD OST WEST SUED NO NW SO SW RAUF RUNTER HINEIN RAUS>
<INSERT-FILE "tells">
<INSERT-FILE "syntax">
<INSERT-FILE "globals">
<INSERT-FILE "clock">
<INSERT-FILE "loop">
<INSERT-FILE "parser">
<INSERT-FILE "verbs">

;"Zork defines its maze in its dungeon. Books can supply their own."
<ROUTINE IN-MAZE? (PLACE) <RFALSE>>
