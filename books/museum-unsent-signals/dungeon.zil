<DIRECTIONS NORTH EAST WEST SOUTH NE NW SE SW UP DOWN IN OUT LAND>

<ROOM ADMISSIONS (IN ROOMS) (GLOBAL RELAY) (DESC "Admissions") (FLAGS RLANDBIT ONBIT)
 (EAST TO DEAD-LETTERS) (WEST TO QUIET-HALL) (NORTH TO SIGNAL-BOOTH)
 (LDESC "You are in the admissions lobby of the Museum of Unsent Signals. The lights have been turned down low, and the only sound is the far-off hum of the old relay. Behind the [[ticket counter->counter]] a stack of tickets has just been stamped, and above it hangs a brass [[plaque]], polished so clean it shines. Dead Letters is through a doorway to the [[east]], and the Quiet Hall lies to the [[west]]. A short corridor leads [[north]] to the signal booth.")>
<ROOM DEAD-LETTERS (IN ROOMS) (GLOBAL RELAY) (DESC "Dead Letters") (FLAGS RLANDBIT ONBIT)
 (WEST TO ADMISSIONS)
 (LDESC "This is the Dead Letters gallery, a long, dim room lined with [[glass cases->cases]]. Each case holds a message that somebody recorded and then never sent, and the ones nearest the floor are kept for messages people changed their minds about. At waist height stands a round [[inspection lens->lens]] in a brass collar, for looking closely at the exhibits. The doorway back to admissions is to the [[west]].")>
<ROOM QUIET-HALL (IN ROOMS) (GLOBAL RELAY) (DESC "Quiet Hall") (FLAGS RLANDBIT ONBIT)
 (EAST TO ADMISSIONS)
 (LDESC "This is the Quiet Hall, the one room in the museum built for listening to nothing. Thick carpet swallows your footsteps, and the hush is the good kind, like a coat put over a sleeping child. A straight wooden [[bench]] faces the far wall, where an old [[service diagram->diagram]] shows how the relay used to work. Admissions is back to the [[east]].")>
<ROOM SIGNAL-BOOTH (IN ROOMS) (GLOBAL RELAY) (DESC "Signal Booth") (FLAGS RLANDBIT ONBIT)
 (SOUTH TO ADMISSIONS)
 (LDESC "You are in the signal booth, a small glass room at the heart of the relay. The air hums faintly, and the glass is warm where people have leaned their foreheads against it. Set into the desk is a shallow [[reading basin->basin]] for playing spools, with a round [[audition stud->stud]] beside it. Below them are two sending keys: the [[return key]] on the left and the [[memorial key]] on the right. The corridor leads back [[south]] to admissions.")>

<OBJECT MUSEUM-PLAQUE (IN ADMISSIONS) (DESC "plaque") (SYNONYM PLAQUE NOTE STRIP PAPER LETTERS RULE) (ADJECTIVE MUSEUM BRASS RAISED CARETAKER)
 (FLAGS NDESCBIT) (ACTION MUSEUM-PLAQUE-F)>

<OBJECT RETURN-LENS (IN DEAD-LETTERS) (DESC "inspection lens") (SYNONYM LENS COLLAR RIM SCRATCHES) (ADJECTIVE INSPECTION BRASS ROUND FINE)
 (FLAGS NDESCBIT) (ACTION RETURN-LENS-F)>

<OBJECT MESSAGE-SPOOL (IN DEAD-LETTERS) (DESC "wooden spool") (SYNONYM SPOOL TAG REEL TAPE CUTS CUT MARKS MARK EDGE) (ADJECTIVE WOODEN PAPER RECORDING)
 (FLAGS TAKEBIT) (FDESC "One [[wooden spool->spool]] has been taken out of its case and left beside the lens, with a paper tag tied to it.")
 (LDESC "The [[wooden spool->spool]] is here.") (ACTION MESSAGE-SPOOL-F)>

<OBJECT HALL-BENCH (IN QUIET-HALL) (DESC "bench") (SYNONYM BENCH SEAT HOLLOWS) (ADJECTIVE HALL STRAIGHT PLAIN SHALLOW WOODEN)
 (FLAGS NDESCBIT) (ACTION HALL-BENCH-F)>

<OBJECT SERVICE-DIAGRAM (IN QUIET-HALL) (DESC "service diagram") (SYNONYM DIAGRAM LINES LINE WEB) (ADJECTIVE SERVICE THICK THIN)
 (FLAGS NDESCBIT) (ACTION SERVICE-DIAGRAM-F)>

<OBJECT READING-BASIN (IN SIGNAL-BOOTH) (DESC "reading basin") (SYNONYM BASIN SPOOLS) (ADJECTIVE READING)
 (FLAGS NDESCBIT CONTBIT OPENBIT SEARCHBIT) (CAPACITY 15) (ACTION READING-BASIN-F)>

<OBJECT AUDITION-STUD (IN SIGNAL-BOOTH) (DESC "audition stud") (SYNONYM STUD BUTTON SPEAKER) (ADJECTIVE AUDITION ROUND BRASS)
 (FLAGS NDESCBIT) (ACTION AUDITION-STUD-F)>

<OBJECT RETURN-KEY (IN SIGNAL-BOOTH) (DESC "return key") (SYNONYM KEY) (ADJECTIVE RETURN LEFT)
 (FLAGS NDESCBIT) (ACTION RETURN-KEY-F)>

<OBJECT MEMORIAL-KEY (IN SIGNAL-BOOTH) (DESC "memorial key") (SYNONYM KEY) (ADJECTIVE MEMORIAL RIGHT)
 (FLAGS NDESCBIT) (ACTION MEMORIAL-KEY-F)>

<OBJECT TICKET-COUNTER (IN ADMISSIONS) (DESC "ticket counter") (SYNONYM COUNTER TICKETS TICKET STACK TILL STAMP INK VARNISH) (ADJECTIVE TICKET WOODEN TOP)
 (FLAGS NDESCBIT READBIT) (ACTION TICKET-COUNTER-F)>

<OBJECT GLASS-CASES (IN DEAD-LETTERS) (DESC "glass cases") (SYNONYM CASES CASE EXHIBITS MESSAGES MESSAGE GLASS CARD CARDS CYLINDER RECORDINGS) (ADJECTIVE GLASS WAX CATALOGUE EMPTY)
 (FLAGS NDESCBIT) (ACTION GLASS-CASES-F)>

<OBJECT RELAY (IN LOCAL-GLOBALS) (DESC "relay") (SYNONYM RELAY HUM DOME CABLES CABLE WIRES) (ADJECTIVE OLD)
 (FLAGS NDESCBIT) (ACTION RELAY-F)>

<OBJECT LOBBY (IN ADMISSIONS) (DESC "lobby") (SYNONYM LOBBY ADMISSIONS LIGHTS DOORWAY CORRIDOR MUSEUM FLOOR DOOR) (ADJECTIVE ADMISSIONS SHORT)
 (FLAGS NDESCBIT) (ACTION LOBBY-F)>

<OBJECT GALLERY (IN DEAD-LETTERS) (DESC "gallery") (SYNONYM GALLERY ROOM DOORWAY LETTERS FLOOR) (ADJECTIVE DEAD DIM LONG)
 (FLAGS NDESCBIT) (ACTION GALLERY-F)>

<OBJECT QUIET-ROOM (IN QUIET-HALL) (DESC "quiet hall") (SYNONYM HALL ROOM CARPET WALL HUSH FOOTSTEPS) (ADJECTIVE QUIET THICK FAR)
 (FLAGS NDESCBIT) (ACTION QUIET-ROOM-F)>

<OBJECT BOOTH (IN SIGNAL-BOOTH) (DESC "signal booth") (SYNONYM BOOTH ROOM GLASS DESK CORRIDOR KEYS) (ADJECTIVE SIGNAL SMALL SENDING)
 (FLAGS NDESCBIT) (ACTION BOOTH-F)>

<OBJECT ADDRESS-INDICATOR (IN SIGNAL-BOOTH) (DESC "address indicator") (SYNONYM INDICATOR COUNTER DISPLAY) (ADJECTIVE ADDRESS SMALL)
 (FLAGS NDESCBIT) (ACTION ADDRESS-INDICATOR-F)>

;"End of world inventory."
