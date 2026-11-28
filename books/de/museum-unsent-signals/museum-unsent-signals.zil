"Das Museum der ungesendeten Signale"
<CONSTANT RELEASEID 1>
<VERSION ZIP>
<FREQUENT-WORDS?>
<PROPDEF SIZE 5>
<PROPDEF CAPACITY 0>
<PROPDEF VALUE 0>
<PROPDEF TVALUE 0>
<DIRECTIONS NORD OST WEST SUED NO NW SO SW RAUF RUNTER HINEIN RAUS>
;"German vocabulary, TELL tokens and messages come before the story's objects;
  the classic rules follow them."
<INSERT-FILE "languages.de.init">
<INSERT-FILE "dungeon">
<INSERT-FILE "rulesets.classic.de">
<INSERT-FILE "actions">
<SYNTAX TIP = V-MUSEUM-HELP>
<SYNONYM TIP TIPE TIPS HILFE HILF TIPP TIPPS HINWEIS>
<ROUTINE V-MUSEUM-HELP ()
 <TELL "Tippe SCHAU, um dich umzusehen, UNTERSUCHE gefolgt von einem Gegenstand, oder eine Himmelsrichtung wie OST. NIMM und LEG bewegen Gegenstände; INVENTAR zeigt, was du trägst. Lies den Zettel in der Eingangshalle, um zu erfahren, wonach du suchen sollst." CR>>
