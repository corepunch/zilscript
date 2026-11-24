<SYNTAX TILT OBJECT = V-TILT-LENS>

<GLOBAL LENS-READ <>>
<GLOBAL SIGNAL-HEARD <>>
<GLOBAL MUSEUM-END 0>

<ROUTINE MUSEUM-PLAQUE-F ()
 <COND (<VERB? EXAMINE READ>
  <TELL "The caretaker has added a strip of paper: “The wooden spool in Dead Letters was filed as blank. Someone handled it every day for forty years. Please check before we switch the relay off.”" CR>)>>

<ROUTINE RETURN-LENS-F ()
 <COND (<VERB? EXAMINE LOOK-INSIDE>
  <COND (,LENS-READ <TELL "The instruction is still clear: three cuts mean RETURN ONLY. No public forwarding." CR>)
        (T <TELL "Look straight through and you see the catalogue. But the edge of the lens hangs free in its brass collar; you could tilt it toward the light." CR>)>)
       (<VERB? TILT-LENS MOVE PUSH>
        <SETG LENS-READ T>
        <TELL "In the tilted lens, a scratched instruction shines: three cuts on the wooden edge mean RETURN ONLY. No public forwarding. Someone underlined edge." CR>)>>

<ROUTINE MESSAGE-SPOOL-F ()
 <COND (<AND <VERB? PUT PUT-ON> <EQUAL? ,PRSI ,READING-BASIN> <HELD? ,MESSAGE-SPOOL>>
  <MOVE ,MESSAGE-SPOOL ,READING-BASIN>
  <TELL "The spool catches and starts to turn. The [[audition stud->stud]] glows on the basin's rim." CR>)
       (<VERB? EXAMINE READ>
  <COND (,LENS-READ
    <TELL "Three fine cuts along the wood. You make out the notch the lens described. Whatever the catalogue says, this has a private return address." CR>)
   (T <TELL "Three fine cuts along the wood. At first you take them for damage." CR>)>)>>

<ROUTINE HALL-BENCH-F ()
 <COND (<VERB? EXAMINE>
  <TELL "Two shallow hollows, very close. People seem to have sat here in pairs." CR>)>>

<ROUTINE SERVICE-DIAGRAM-F ()
 <COND (<VERB? EXAMINE READ>
  <TELL "The feed sends only new material chosen here, not the spool itself. The return path sends a new acknowledgment only to the sender. Someone drew a careful line around the part the museum is allowed to keep: the empty space between messages." CR>)>>

<ROUTINE READING-BASIN-F ()
 <COND (<VERB? EXAMINE SEARCH LOOK-INSIDE>
  <COND (<IN? ,MESSAGE-SPOOL ,READING-BASIN>
         <TELL "The [[spool]] turns slowly in the basin. Press the [[stud]] to hear it here, not out on the feed." CR>)
        (T <TELL "Empty. Set a wooden spool into the basin to play it." CR>)>)
       (<VERB? CLOSE> <TELL "The basin has no lid. The sound stays in the booth unless you send something." CR>)>>

<ROUTINE AUDITION-STUD-F ()
 <COND (<VERB? EXAMINE>
  <TELL "Pressing the stud plays what is in the [[basin]]. The recording cannot leave this booth." CR>)
       (<VERB? PUSH>
        <COND (<NOT <IN? ,MESSAGE-SPOOL ,READING-BASIN>>
               <TELL "The speaker clicks once. Load the wooden spool into the [[basin]] first." CR>)
              (<NOT ,LENS-READ>
               <TELL "A woman says “I made it.” Then a long interval. The counter asks for the kind of address; tilt the lens in Dead Letters toward the light before you route anything." CR>)
              (,SIGNAL-HEARD
               <TELL "The woman says “I made it.” You now know how much of the message is the minute after she stops." CR>)
              (T <SETG SIGNAL-HEARD T>
                 <TELL "A woman says “I made it.” For a whole minute you hear only her breathing. The three cuts align with the private return register: this wasn't a public announcement. She was talking to whoever used to wait up for her." CR>)>)>>

<ROUTINE ROUTING-READY ()
 <COND (,SIGNAL-HEARD <RTRUE>)
       (T <TELL "The keys stay dark. Read the cut marks in Dead Letters and audition the loaded spool before choosing a destination." CR> <RFALSE>)>>

<ROUTINE RETURN-KEY-F ()
 <COND (<VERB? EXAMINE>
  <TELL "A single press sends a new receipt down the private return register. It will not send the woman's voice or use the public feed." CR>)
       (<VERB? PUSH>
        <COND (<ROUTING-READY>
          <SETG MUSEUM-END 1>
          <TELL "You send four words: “Nobody had to wait.” The indicator takes an unreasonably long time to answer. Then it prints RECEIVED, and a second line that must have been added by hand: I STILL LEFT THE LIGHT ON." CR CR "ENDING: PRIVATE RETURN" CR>
          <FINISH>)>
        <RTRUE>)>>

<ROUTINE MEMORIAL-KEY-F ()
 <COND (<VERB? EXAMINE>
  <TELL "The memorial feed can send the minute of silence, without the voice or the address. It is a small public record of the act of waiting." CR>)
       (<VERB? PUSH>
        <COND (<ROUTING-READY>
          <SETG MUSEUM-END 2>
          <TELL "You send the minute without the voice. Across the dome, speakers announce nothing at all. You had expected notices asking what went wrong. Instead, the night dispatcher sends a short message: “Please wait to reset. Someone is still listening.”" CR CR "ENDING: A MINUTE FOR THE LIVING" CR>
          <FINISH>)>
        <RTRUE>)>>

<ROUTINE V-VERSION ()
 <TELL "The Museum of Unsent Signals|AdventureArena, 2026|Release " N ,RELEASEID CR>>

<ROUTINE GO ()
 <V-VERSION> <CRLF>
 <SETG HERE ,ADMISSIONS> <SETG VERBOSE T> <SETG LIT T>
 <SETG WINNER ,ADVENTURER> <SETG PLAYER ,WINNER> <MOVE ,WINNER ,HERE>
 <TELL "The museum is closing for good. The caretaker left you a key to the building and said, “You don't have to make everything speak.”" CR CR>
 <TELL D ,HERE CR>
 <V-LOOK> <MAIN-LOOP> <AGAIN>>

<ROUTINE V-SCORE ("OPTIONAL" (ASK? T))
 <COND (<NOT <EQUAL? ,MUSEUM-END 0>> <TELL "The museum has entered its last exhibit." CR>)
       (,SIGNAL-HEARD <TELL "The recording has been heard. No transmission has left the booth." CR>)
       (T <TELL "One entry in the museum catalogue is still under review." CR>)>>

<ROUTINE V-TILT-LENS ()
 <TELL "That won't tilt. The inspection lens sits in a movable collar." CR>>
