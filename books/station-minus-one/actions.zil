<GLOBAL LOOP-OBSERVED <>>
<GLOBAL STATION-END 0>

<ROUTINE STATION-CLOCK-F ()
 <COND (<VERB? EXAMINE READ>
  <TELL "Every time the second hand crosses zero, it comes out one second behind. In the reverse glass you can read the platform indicator: ARRIVAL MINUS ONE." CR>)>>

<ROUTINE SHIFT-LOG-F ()
 <COND (<VERB? EXAMINE READ>
  <TELL "The night operator wrote in pencil: “Yesterday's empty train left a reflection. Seat the ceramic puck in the gauge cradle and push the calibration stud. A reflection weighs nothing. I didn't build this station to wave at ghosts.”" CR>)>>

<ROUTINE TEST-PUCK-F ()
 <COND (<AND <VERB? PUT PUT-ON> <EQUAL? ,PRSI ,RECEIVER-CRADLE> <HELD? ,TEST-PUCK>>
  <MOVE ,TEST-PUCK ,RECEIVER-CRADLE>
  <TELL "The puck settles with a ceramic click. The [[calibration stud->stud]] pulses once." CR>)
       (<VERB? EXAMINE>
  <TELL "Heavy enough to feel warm, even here. Its rim says STANDARD LOAD. One side is shaped to fit the receiver cradle." CR>)>>

<ROUTINE RECEIVER-CRADLE-F ()
 <COND (<VERB? EXAMINE SEARCH LOOK-INSIDE>
  <COND (<IN? ,TEST-PUCK ,RECEIVER-CRADLE>
         <TELL "The [[ceramic puck->puck]] sits flush. The [[stud]] will test its weight against the thing on the rail." CR>)
        (T <TELL "A circular hollow with one notch. The gauge expects a standard ceramic puck; the [[stud]] does nothing without it." CR>)>)
       (<VERB? CLOSE> <TELL "The cradle has no lid. It needs the puck in the open." CR>)>>

<ROUTINE CALIBRATION-STUD-F ()
 <COND (<VERB? EXAMINE>
  <TELL "A low, square button. Pressing it runs an unloaded return comparison once the [[cradle]] has a standard weight." CR>)
       (<VERB? PUSH>
        <COND (<NOT <IN? ,TEST-PUCK ,RECEIVER-CRADLE>>
               <TELL "EMPTY REFERENCE. You need to seat a ceramic puck in the [[cradle]]." CR>)
              (,LOOP-OBSERVED
               <TELL "Again, something in the train moves its weight from one foot to the other." CR>)
              (T <SETG LOOP-OBSERVED T>
                 <TELL "First return: zero. Second return: a train's worth of weight. Then, in the margin, the small extra weight of a person changing feet. A reflection cannot do that." CR>)>)>>

<ROUTINE STATION-END-POSSIBLE ()
 <COND (,LOOP-OBSERVED <RTRUE>)
       (T <TELL "Your hand stops short. A reflection would also look like an arrival. Run the comparison in the gauge room before deciding what to do with the train." CR> <RFALSE>)>>

<ROUTINE RESCUE-SWITCH-F ()
 <COND (<VERB? EXAMINE>
  <TELL "This registers an emergency berth. Everyone in the colony will remember the unplanned stop; no one knows which other memories will come back with it." CR>)
       (<VERB? PUSH>
        <COND (<STATION-END-POSSIBLE>
          <SETG STATION-END 1>
          <TELL "The rail goes quiet. A door slides out of the dark, and a driver in her socks asks if this is still Tuesday. You hold the door while she counts the passengers down. By morning there will be two versions of every timetable and one queue for tea." CR CR "ENDING: THE EXTRA STOP" CR>
          <FINISH>)>
        <RTRUE>)>>

<ROUTINE QUARANTINE-LATCH-F ()
 <COND (<VERB? EXAMINE>
  <TELL "Pressing it closes the berth and rings the rail back to the last ordinary signal. The train can brake in its own history. You will never see it come in." CR>)
       (<VERB? PUSH>
        <COND (<STATION-END-POSSIBLE>
          <SETG STATION-END 2>
          <TELL "You close the berth. A single note travels out under the frost; after a long interval, another comes back. The warmth leaves the rail. In the logbook you draw two small circles for the signals, so whoever works alone tomorrow knows there was an answer." CR CR "ENDING: OUTSIDE THE TIMETABLE" CR>
          <FINISH>)>
        <RTRUE>)>>

<ROUTINE V-VERSION ()
 <TELL "The Station at Minus One|AdventureArena, 2026|Release " N ,RELEASEID CR>>

<ROUTINE GO ()
 <V-VERSION> <CRLF>
 <SETG HERE ,TICKET-HALL> <SETG VERBOSE T> <SETG LIT T>
 <SETG WINNER ,ADVENTURER> <SETG PLAYER ,WINNER> <MOVE ,WINNER ,HERE>
 <TELL "The last lift left an hour ago. Then a train rang for entry from the wrong side of midnight." CR CR>
 <TELL D ,HERE CR>
 <V-LOOK> <MAIN-LOOP> <AGAIN>>

<ROUTINE V-SCORE ("OPTIONAL" (ASK? T))
 <COND (<NOT <EQUAL? ,STATION-END 0>> <TELL "The station register is closed." CR>)
       (,LOOP-OBSERVED <TELL "A real train is waiting. Its next stop is your decision." CR>)
       (T <TELL "The station register still shows one unverified arrival." CR>)>>
