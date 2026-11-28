<DIRECTIONS NORTH EAST WEST SOUTH NE NW SE SW UP DOWN IN OUT LAND>

<ROOM ADMISSIONS (IN ROOMS) (GLOBAL RELAY) (DESC "Admissions") (FLAGS RLANDBIT ONBIT)
 (EAST TO DEAD-LETTERS) (WEST TO QUIET-HALL) (NORTH TO SIGNAL-BOOTH)
 (LDESC "You're in the admissions lobby. Only one light is still on, above the [[ticket counter->counter]] and a brass [[plaque]]. Beneath the hum of the [[relay]], you can hear each of your own steps on the tiles. The Dead Letters gallery lies [[east]], the Quiet Hall [[west]], and the signal booth [[north]].")>
<ROOM DEAD-LETTERS (IN ROOMS) (GLOBAL RELAY) (DESC "Dead Letters") (FLAGS RLANDBIT ONBIT)
 (WEST TO ADMISSIONS)
 (LDESC "You're in the Dead Letters gallery. The [[glass cases->cases]] run down both walls. At first the dark glass shows you only your own reflection; the [[inspection lens->lens]] on its stand was put there for a closer look. The door back to admissions is [[west]].")>
<ROOM QUIET-HALL (IN ROOMS) (GLOBAL RELAY) (DESC "Quiet Hall") (FLAGS RLANDBIT ONBIT)
 (EAST TO ADMISSIONS)
 (LDESC "This is the Quiet Hall, the one room in the museum built for listening to nothing. The thick carpet stops your footsteps so suddenly that you hear the sleeve of your coat brush your wrist. A straight wooden [[bench]] faces the far wall, where an old [[service diagram->diagram]] shows how the relay used to work. Admissions is back to the [[east]].")>
<ROOM SIGNAL-BOOTH (IN ROOMS) (GLOBAL RELAY) (DESC "Signal Booth") (FLAGS RLANDBIT ONBIT)
 (SOUTH TO ADMISSIONS)
 (LDESC "You are in the signal booth, a small glass room at the heart of the relay. The [[relay]] hums under your feet. The glass is warm enough to lean your forehead against. Set into the desk is a shallow [[reading basin->basin]] for playing spools, with a round [[audition stud->stud]] beside it. Below them are two sending keys: the [[return key]] on the left and the [[memorial key]] on the right, with a little [[address indicator->indicator]] above them. The corridor leads back [[south]] to admissions.")>

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
 (FLAGS NDESCBIT PLURALBIT) (ACTION GLASS-CASES-F)>

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
