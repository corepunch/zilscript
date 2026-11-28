; The experiment belongs to the parser; these cards only describe intentions.
<ROUTINE SUGGEST-ACTIONS ()
 <COND (<IN? ,TEST-PUCK ,HERE>
  <CHOICE "station.take-puck" "Take the ceramic puck" "take puck" ,CHOICE-PROGRESS 100>
  <CHOICE "station.inspect-puck" "Check the ceramic puck's markings" "examine puck" ,CHOICE-INVESTIGATE 65>)>
 <COND (<EQUAL? ,HERE ,TICKET-HALL>
  <CHOICE "station.clock-listen" "Listen to the clock skip a beat" "listen" ,CHOICE-INTERACT 60>
  <CHOICE "station.clock" "Watch the second hand cross zero" "examine clock" ,CHOICE-INVESTIGATE 95>
  <CHOICE "station.staff" "Check the staff room" "west" ,CHOICE-PROGRESS 90>
  <CHOICE-DETAILS "group" "move">
  <CHOICE "station.gauge" "Enter the gauge room" "east" ,CHOICE-PROGRESS 85>
  <CHOICE-DETAILS "group" "move">
  <CHOICE "station.platform" "Go out onto the platform" "north" ,CHOICE-PROGRESS 80>
  <CHOICE-DETAILS "group" "move">)
  (<EQUAL? ,HERE ,STAFF-ROOM>
   <CHOICE "station.log" "Read the night operator's log" "read logbook" ,CHOICE-INVESTIGATE 95>
   <CHOICE "station.tap" "Listen to the staff-room tap" "listen to tap" ,CHOICE-INTERACT 55>
   <CHOICE "station.cups" "Look at the two rinsed cups" "examine cups" ,CHOICE-INVESTIGATE 60>
   <CHOICE "station.staff-back" "Return to the ticket hall" "east" ,CHOICE-RETURN 75>
   <CHOICE-DETAILS "group" "move">)
  (<EQUAL? ,HERE ,GAUGE-ROOM>
   <CHOICE "station.cradle-tap" "Tap the cradle and watch the readout" "knock on cradle" ,CHOICE-INTERACT 55>
   <CHOICE "station.cradle" "Examine the receiver cradle" "examine cradle" ,CHOICE-INVESTIGATE 70>
   <COND (<IN? ,TEST-PUCK ,WINNER>
     <CHOICE "station.seat" "Seat the ceramic puck in the cradle" "put puck in cradle" ,CHOICE-PROGRESS 100>)
    (<IN? ,TEST-PUCK ,RECEIVER-CRADLE>
     <CHOICE "station.test" "Run the return comparison" "push stud" ,CHOICE-PROGRESS 100>
     <CHOICE "station.recover" "Lift the puck out of the cradle" "take puck" ,CHOICE-INVESTIGATE 55>)>
   <CHOICE "station.gauge-back" "Return to the ticket hall" "west" ,CHOICE-RETURN 75>
   <CHOICE-DETAILS "group" "move">)
  (<EQUAL? ,HERE ,LOWER-PLATFORM>
   <CHOICE "station.read-rescue" "Find out what a rescue would change" "examine switch" ,CHOICE-INVESTIGATE 90>
   <CHOICE "station.read-latch" "Find out what quarantine would do" "examine latch" ,CHOICE-INVESTIGATE 85>
   <CHOICE "station.call" "Call down the tunnel" "talk to train" ,CHOICE-INTERACT 65>
   <CHOICE "station.track" "Kneel and lay a hand on the warm rail" "touch track" ,CHOICE-INVESTIGATE 70>
   <COND (,LOOP-OBSERVED
    <CHOICE "station.rescue" "Register an emergency stop for the train" "push switch" ,CHOICE-PROGRESS 100>
    <CHOICE "station.quarantine" "Close the berth and warn the driver through the rail" "push latch" ,CHOICE-PROGRESS 99>)>
   <CHOICE "station.platform-back" "Return to the ticket hall" "south" ,CHOICE-RETURN 75>
   <CHOICE-DETAILS "group" "move">)>>
