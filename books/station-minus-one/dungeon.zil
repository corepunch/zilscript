<DIRECTIONS NORTH EAST WEST SOUTH NE NW SE SW UP DOWN IN OUT LAND>

<ROOM TICKET-HALL (IN ROOMS) (DESC "Ticket Hall") (FLAGS RLANDBIT ONBIT)
 (WEST TO STAFF-ROOM) (EAST TO GAUGE-ROOM) (NORTH TO LOWER-PLATFORM)
 (LDESC "Light comes up through the floor of the closed station. Over the wickets, a [[station clock->clock]] keeps trying to reach midnight. The staff room lies [[west]], the gauge room [[east]], and the platform [[north]].")>
<ROOM STAFF-ROOM (IN ROOMS) (DESC "Staff Room") (FLAGS RLANDBIT ONBIT)
 (EAST TO TICKET-HALL)
 (LDESC "Somebody rinsed both cups, though this was a one-person shift. A [[logbook]] lies flat on the table. The ticket hall is [[east]].")>
<ROOM GAUGE-ROOM (IN ROOMS) (DESC "Gauge Room") (FLAGS RLANDBIT ONBIT)
 (WEST TO TICKET-HALL)
 (LDESC "The floor hums at the edge of hearing. The [[receiver cradle->cradle]] and [[calibration stud->stud]] are the only things here without a coating of frost. The hall is [[west]].")>
<ROOM LOWER-PLATFORM (IN ROOMS) (DESC "Lower Platform") (FLAGS RLANDBIT ONBIT)
 (SOUTH TO TICKET-HALL)
 (LDESC "A little warmth comes up the empty track, like breath on your wrist. The [[rescue switch->switch]] and [[quarantine latch->latch]] stand at the platform edge. The hall is [[south]].")>

<OBJECT STATION-CLOCK (IN TICKET-HALL) (DESC "station clock") (SYNONYM CLOCK) (ADJECTIVE STATION)
 (FLAGS NDESCBIT) (ACTION STATION-CLOCK-F)>

<OBJECT SHIFT-LOG (IN STAFF-ROOM) (DESC "logbook") (SYNONYM LOGBOOK LOG) (ADJECTIVE SHIFT)
 (FLAGS NDESCBIT) (ACTION SHIFT-LOG-F)>

<OBJECT TEST-PUCK (IN STAFF-ROOM) (DESC "ceramic puck") (SYNONYM PUCK) (ADJECTIVE CERAMIC TEST)
 (FLAGS TAKEBIT) (FDESC "A [[ceramic puck->puck]] holds down the corner of a napkin.")
 (LDESC "The [[ceramic puck->puck]] is here.") (ACTION TEST-PUCK-F)>

<OBJECT RECEIVER-CRADLE (IN GAUGE-ROOM) (DESC "receiver cradle") (SYNONYM CRADLE RECEIVER) (ADJECTIVE RECEIVER)
 (FLAGS NDESCBIT CONTBIT OPENBIT SEARCHBIT) (CAPACITY 15) (ACTION RECEIVER-CRADLE-F)>

<OBJECT CALIBRATION-STUD (IN GAUGE-ROOM) (DESC "calibration stud") (SYNONYM STUD) (ADJECTIVE CALIBRATION)
 (FLAGS NDESCBIT) (ACTION CALIBRATION-STUD-F)>

<OBJECT RESCUE-SWITCH (IN LOWER-PLATFORM) (DESC "rescue switch") (SYNONYM SWITCH) (ADJECTIVE RESCUE)
 (FLAGS NDESCBIT) (ACTION RESCUE-SWITCH-F)>

<OBJECT QUARANTINE-LATCH (IN LOWER-PLATFORM) (DESC "quarantine latch") (SYNONYM LATCH) (ADJECTIVE QUARANTINE)
 (FLAGS NDESCBIT) (ACTION QUARANTINE-LATCH-F)>

;"End of world inventory."
