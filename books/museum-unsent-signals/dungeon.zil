<DIRECTIONS NORTH EAST WEST SOUTH NE NW SE SW UP DOWN IN OUT LAND>

<ROOM ADMISSIONS (IN ROOMS) (DESC "Admissions") (FLAGS RLANDBIT ONBIT)
 (EAST TO DEAD-LETTERS) (WEST TO QUIET-HALL) (NORTH TO SIGNAL-BOOTH)
 (LDESC "The ticket ink is still wet: LAST NIGHT. Over the counter someone has polished the [[plaque]] clean. Dead Letters is [[east]], the Quiet Hall [[west]], and the signal booth [[north]].")>
<ROOM DEAD-LETTERS (IN ROOMS) (DESC "Dead Letters") (FLAGS RLANDBIT ONBIT)
 (WEST TO ADMISSIONS)
 (LDESC "The cases nearest the floor are reserved for messages people changed their minds about. At waist height a brass [[inspection lens->lens]] is set in a brass collar. Admissions is [[west]].")>
<ROOM QUIET-HALL (IN ROOMS) (DESC "Quiet Hall") (FLAGS RLANDBIT ONBIT)
 (EAST TO ADMISSIONS)
 (LDESC "The hall has the good hush of a coat put over a sleeping child. A straight [[bench]] faces the old [[service diagram->diagram]]. Admissions is [[east]].")>
<ROOM SIGNAL-BOOTH (IN ROOMS) (DESC "Signal Booth") (FLAGS RLANDBIT ONBIT)
 (SOUTH TO ADMISSIONS)
 (LDESC "The [[reading basin->basin]] sits between an [[audition stud->stud]] and a pair of keys: [[return key]] to the left, [[memorial key]] to the right. The glass is warm where people have leaned their foreheads against it. Admissions is [[south]].")>

<OBJECT MUSEUM-PLAQUE (IN ADMISSIONS) (DESC "plaque") (SYNONYM PLAQUE) (ADJECTIVE MUSEUM)
 (FLAGS NDESCBIT) (ACTION MUSEUM-PLAQUE-F)>

<OBJECT RETURN-LENS (IN DEAD-LETTERS) (DESC "inspection lens") (SYNONYM LENS) (ADJECTIVE INSPECTION BRASS)
 (FLAGS NDESCBIT) (ACTION RETURN-LENS-F)>

<OBJECT MESSAGE-SPOOL (IN DEAD-LETTERS) (DESC "wooden spool") (SYNONYM SPOOL) (ADJECTIVE WOODEN)
 (FLAGS TAKEBIT) (FDESC "One [[wooden spool->spool]] is out of its case. A paper label reads FOR REVIEW.")
 (LDESC "The [[wooden spool->spool]] is here.") (ACTION MESSAGE-SPOOL-F)>

<OBJECT HALL-BENCH (IN QUIET-HALL) (DESC "bench") (SYNONYM BENCH) (ADJECTIVE HALL)
 (FLAGS NDESCBIT) (ACTION HALL-BENCH-F)>

<OBJECT SERVICE-DIAGRAM (IN QUIET-HALL) (DESC "service diagram") (SYNONYM DIAGRAM) (ADJECTIVE SERVICE)
 (FLAGS NDESCBIT) (ACTION SERVICE-DIAGRAM-F)>

<OBJECT READING-BASIN (IN SIGNAL-BOOTH) (DESC "reading basin") (SYNONYM BASIN) (ADJECTIVE READING)
 (FLAGS NDESCBIT CONTBIT OPENBIT SEARCHBIT) (CAPACITY 15) (ACTION READING-BASIN-F)>

<OBJECT AUDITION-STUD (IN SIGNAL-BOOTH) (DESC "audition stud") (SYNONYM STUD) (ADJECTIVE AUDITION)
 (FLAGS NDESCBIT) (ACTION AUDITION-STUD-F)>

<OBJECT RETURN-KEY (IN SIGNAL-BOOTH) (DESC "return key") (SYNONYM KEY) (ADJECTIVE RETURN LEFT)
 (FLAGS NDESCBIT) (ACTION RETURN-KEY-F)>

<OBJECT MEMORIAL-KEY (IN SIGNAL-BOOTH) (DESC "memorial key") (SYNONYM KEY) (ADJECTIVE MEMORIAL RIGHT)
 (FLAGS NDESCBIT) (ACTION MEMORIAL-KEY-F)>

;"End of world inventory."
