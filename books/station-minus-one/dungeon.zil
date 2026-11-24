<DIRECTIONS NORTH EAST WEST SOUTH NE NW SE SW UP DOWN IN OUT LAND>

<ROOM TICKET-HALL (IN ROOMS) (DESC "Ticket Hall") (FLAGS RLANDBIT ONBIT)
 (WEST TO STAFF-ROOM) (EAST TO GAUGE-ROOM) (NORTH TO LOWER-PLATFORM)
 (LDESC "You are in the ticket hall of the station, a low concrete room far under the ice where the colony's trains stop. The ceiling lamps are off for the night, so the only light comes from glow strips set in the floor, and your breath hangs in the air. Above the row of ticket [[wickets]], the [[station clock->clock]] keeps creeping toward midnight. The staff room is through a door to the [[west]], and the gauge room, where the track instruments are kept, is to the [[east]]. Steps lead [[north]] down to the platform.")>
<ROOM STAFF-ROOM (IN ROOMS) (DESC "Staff Room") (FLAGS RLANDBIT ONBIT)
 (EAST TO TICKET-HALL)
 (LDESC "This is the staff room, a narrow, warm room that smells of stewed tea. There is a sink in one corner and a scuffed [[table]] under a hanging lamp. Two [[cups]] stand upside down on the drainer, both rinsed, though tonight was a one-person shift. The night operator's [[logbook]] lies open on the table. The door back to the ticket hall is to the [[east]].")>
<ROOM GAUGE-ROOM (IN ROOMS) (DESC "Gauge Room") (FLAGS RLANDBIT ONBIT)
 (WEST TO TICKET-HALL)
 (LDESC "This is the gauge room, where the station weighs whatever stands on its track. It is bitterly cold, and the floor hums at the edge of hearing. [[Frost]] furs the dials and pipes on every wall. Only two things on the console are clear of it: a round [[receiver cradle->cradle]], and a square [[calibration stud->stud]] beside it. The ticket hall is back through the door to the [[west]].")>
<ROOM LOWER-PLATFORM (IN ROOMS) (DESC "Lower Platform") (FLAGS RLANDBIT ONBIT)
 (SOUTH TO TICKET-HALL)
 (LDESC "You are on the lower platform. The [[track]] comes out of one black tunnel and runs into another, and there is no train in sight. Even so, a little warmth rises off the rails, like breath on your wrist. Two controls stand on a post at the platform edge: a red [[rescue switch->switch]] and a grey [[quarantine latch->latch]]. The steps back up to the ticket hall are to the [[south]].")>

<OBJECT STATION-CLOCK (IN TICKET-HALL) (DESC "station clock") (SYNONYM CLOCK) (ADJECTIVE STATION)
 (FLAGS NDESCBIT) (ACTION STATION-CLOCK-F)>

<OBJECT SHIFT-LOG (IN STAFF-ROOM) (DESC "logbook") (SYNONYM LOGBOOK LOG) (ADJECTIVE SHIFT)
 (FLAGS NDESCBIT) (ACTION SHIFT-LOG-F)>

<OBJECT TEST-PUCK (IN STAFF-ROOM) (DESC "ceramic puck") (SYNONYM PUCK) (ADJECTIVE CERAMIC TEST)
 (FLAGS TAKEBIT) (FDESC "A white [[ceramic puck->puck]] sits on the table beside the logbook.")
 (LDESC "The [[ceramic puck->puck]] is here.") (ACTION TEST-PUCK-F)>

<OBJECT RECEIVER-CRADLE (IN GAUGE-ROOM) (DESC "receiver cradle") (SYNONYM CRADLE RECEIVER) (ADJECTIVE RECEIVER)
 (FLAGS NDESCBIT CONTBIT OPENBIT SEARCHBIT) (CAPACITY 15) (ACTION RECEIVER-CRADLE-F)>

<OBJECT CALIBRATION-STUD (IN GAUGE-ROOM) (DESC "calibration stud") (SYNONYM STUD) (ADJECTIVE CALIBRATION)
 (FLAGS NDESCBIT) (ACTION CALIBRATION-STUD-F)>

<OBJECT RESCUE-SWITCH (IN LOWER-PLATFORM) (DESC "rescue switch") (SYNONYM SWITCH) (ADJECTIVE RESCUE)
 (FLAGS NDESCBIT) (ACTION RESCUE-SWITCH-F)>

<OBJECT QUARANTINE-LATCH (IN LOWER-PLATFORM) (DESC "quarantine latch") (SYNONYM LATCH) (ADJECTIVE QUARANTINE)
 (FLAGS NDESCBIT) (ACTION QUARANTINE-LATCH-F)>

<OBJECT TICKET-WICKETS (IN TICKET-HALL) (DESC "ticket wickets") (SYNONYM WICKETS WICKET GATES) (ADJECTIVE TICKET)
 (FLAGS NDESCBIT) (ACTION TICKET-WICKETS-F)>

<OBJECT STAFF-TABLE (IN STAFF-ROOM) (DESC "table") (SYNONYM TABLE) (ADJECTIVE SCUFFED STAFF)
 (FLAGS NDESCBIT) (ACTION STAFF-TABLE-F)>

<OBJECT RINSED-CUPS (IN STAFF-ROOM) (DESC "cups") (SYNONYM CUPS CUP) (ADJECTIVE RINSED TWO)
 (FLAGS NDESCBIT) (ACTION RINSED-CUPS-F)>

<OBJECT GAUGE-FROST (IN GAUGE-ROOM) (DESC "frost") (SYNONYM FROST ICE) (ADJECTIVE WHITE)
 (FLAGS NDESCBIT) (ACTION GAUGE-FROST-F)>

<OBJECT PLATFORM-TRACK (IN LOWER-PLATFORM) (DESC "track") (SYNONYM TRACK RAILS RAIL) (ADJECTIVE WARM EMPTY)
 (FLAGS NDESCBIT) (ACTION PLATFORM-TRACK-F)>

;"End of world inventory."
