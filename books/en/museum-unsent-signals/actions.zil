<SYNTAX TILT OBJECT = V-TILT-LENS>
<SYNONYM TILT ADJUST ANGLE>
<SYNTAX TURN OBJECT = V-SPIN>
<SYNTAX SIT ON OBJECT = V-MUSEUM-SIT>
<SYNTAX PRESS OBJECT = V-PUSH>
<SYNTAX PLAY OBJECT = V-MUSEUM-PLAY>
<SYNTAX LISTEN = V-MUSEUM-LISTEN>

<GLOBAL LENS-READ <>>
<GLOBAL SIGNAL-HEARD <>>
<GLOBAL MUSEUM-END 0>

<ROUTINE MUSEUM-PLAQUE-F ()
 <COND (<VERB? EXAMINE READ>
  <TELL "The plaque gives the museum's one rule in raised letters: NOTHING HERE WAS EVER SENT. PLEASE LET IT REST. Taped underneath is a strip of paper in the caretaker's handwriting: “The wooden spool in Dead Letters was filed as blank. But someone handled it every day for forty years. Please check it before we switch the relay off.”" CR>)
       (<VERB? RUB>
  <TELL "The raised letters are worn almost flat where visitors have traced them. The caretaker's tape is new and still a little sticky." CR>)
       (<VERB? TAKE MOVE>
  <TELL "The plaque is screwed to the wall, and the caretaker's note is meant for whoever reads it here." CR>)>>

<ROUTINE TICKET-COUNTER-F ()
 <COND (<VERB? EXAMINE READ>
  <TELL "A worn wooden counter with an old brass till. The top ticket on the stack is stamped LAST NIGHT, and the ink is still wet enough to smudge. Nobody else is coming to buy one." CR>)
       (<VERB? RUB>
  <TELL "You run your hand along the counter. The varnish is worn pale in two places, where the caretaker leaned on it every evening." CR>)
       (<VERB? TAKE>
  <TELL "You take one ticket, then put it back. It has a seat number but no date. For tonight, that seems exactly right." CR>)
       (<VERB? SMELL>
  <TELL "Fresh stamp ink and old varnish." CR>)
       (<VERB? KNOCK>
  <TELL "Your knock echoes into the empty museum. Nothing answers, except the relay's hum, which seems to hold its breath for a moment." CR>)>>

<ROUTINE GLASS-CASES-F ()
 <COND (<AND <VERB? PUT PUT-ON> <EQUAL? ,PRSI ,GLASS-CASES>>
  <TELL "The cases are locked, and the empty one is waiting for a decision, not a spool. Whatever happens to the " D ,PRSO " tonight happens in the signal booth." CR>)
       (<EQUAL? ,PRSI ,GLASS-CASES> <RFALSE>)
       (<VERB? EXAMINE LOOK-INSIDE SEARCH>
  <TELL "Each case holds one unsent message with a small card. A wax cylinder: an apology, recorded twice. A phone tape: a proposal, never played. Near the floor, a dozen recordings that begin “Never mind.” One case stands empty, and its card says only BLANK: that's where the wooden spool came from." CR>)
       (<VERB? OPEN>
  <TELL "The cases are locked, and the keys went home with the caretaker. Only the spool marked for review is out." CR>)
       (<VERB? RUB>
  <TELL "The glass is cool. Faint smudges show where visitors pressed their fingertips, as if trying to reach the messages inside." CR>)
       (<VERB? KNOCK>
  <TELL "Tap, tap. The glass rings softly, and the whole row of cases hums back at you." CR>)
       (<VERB? LISTEN>
  <TELL "Nothing. Every message in here is waiting to be played, and none of them will be." CR>)
       (<VERB? ATTACK KICK>
  <TELL "Breaking glass in a room full of other people's unsaid words seems like the worst possible way to say anything." CR>)>>

<ROUTINE RELAY-F ()
 <COND (<VERB? EXAMINE>
  <COND (<EQUAL? ,HERE ,SIGNAL-BOOTH> <TELL "This booth is the heart of the relay. Its cables run under the desk and away through the walls to every speaker under the dome. Tomorrow morning someone will switch it off." CR>)
        (T <TELL "You can't see the relay from here, only hear it: a low, steady hum coming through the walls from the signal booth." CR>)>)
       (<VERB? LISTEN>
  <TELL "The hum rises and falls very slightly, like slow breathing. After forty years it is the most familiar sound in the building." CR>)>>

<ROUTINE LOBBY-F ()
 <COND (<VERB? OPEN UNLOCK>
  <TELL "The front door is locked for the night. The caretaker left you in charge of the relay, not the street." CR>)
       (<VERB? EXAMINE>
  <TELL "An old-fashioned lobby with a tiled floor and the lights turned down low. The ticket counter and the plaque face the front door, which is locked for the night. Doorways lead east and west, and a short corridor runs north to the signal booth." CR>)
       (<VERB? LISTEN>
  <TELL "Nothing but the hum of the relay and your own footsteps on the tiles." CR>)>>

<ROUTINE GALLERY-F ()
 <COND (<VERB? EXAMINE>
  <TELL "A long, dim room lined floor to ceiling with glass cases, each with its own little card. It feels like a library of things people almost said." CR>)
       (<VERB? LISTEN>
  <TELL "It is perfectly quiet. Hundreds of messages are in this room, and not one of them is making a sound." CR>)>>

<ROUTINE QUIET-ROOM-F ()
 <COND (<VERB? EXAMINE>
  <TELL "Thick grey carpet, plain walls, one bench and one diagram. Nothing in the Quiet Hall is meant to catch your eye. It is a room for sitting and waiting." CR>)
       (<VERB? LISTEN>
  <TELL "The carpet and walls drink up every sound. Your ears start to ring with the silence." CR>)
       (<VERB? RUB>
  <TELL "The carpet is thick and soft, and your hand leaves a print in it that slowly fades." CR>)>>

<ROUTINE BOOTH-F ()
 <COND (<VERB? EXAMINE>
  <TELL "A small booth with glass walls and a worn desk. On the desk are the reading basin, the audition stud and two sending keys: the return key on the left and the memorial key on the right." CR>)
       (<VERB? PUSH>
  <TELL "You'll have to choose one: the return key or the memorial key." CR>)
       (<VERB? RUB>
  <TELL "The glass is warm. You rest your forehead against it for a moment, like all the people before you." CR>)>>

<ROUTINE RETURN-LENS-F ()
 <COND (<VERB? EXAMINE LOOK-INSIDE>
  <COND (,LENS-READ <TELL "Still tilted toward the light, the lens shows the scratched instruction clearly: three cuts on the wooden edge of a spool mean RETURN ONLY. No public forwarding." CR>)
        (T <TELL "Looking straight through, you see the catalogue card of the empty case swim up large and clear. The spool's line says only BLANK. The rim of the lens isn't fixed, though: it hangs loose in its brass collar, and you could tilt it toward the light." CR>)>)
       (<AND <VERB? TILT-LENS MOVE PUSH PULL SPIN> ,LENS-READ>
  <TELL "The lens is already tilted toward the light, and the scratched instruction still shines: three cuts on the wooden edge mean RETURN ONLY." CR>)
       (<VERB? TILT-LENS MOVE PUSH PULL SPIN>
        <SETG LENS-READ T>
        <TELL "You tilt the lens toward the ceiling light. Fine scratches on the glass, invisible a moment ago, catch the light and shine: an old instruction from the relay staff. Three cuts on the wooden edge mean RETURN ONLY. No public forwarding. Someone has underlined the word edge." CR>)
       (<VERB? RUB>
  <TELL "The glass is cool and spotless. The brass collar is worn bright on one side, where many hands have tilted it before you." CR>)
       (<VERB? KNOCK>
  <TELL "Ting. The lens shivers in its collar. It isn't fixed as firmly as it looks." CR>)
       (<VERB? TAKE>
  <TELL "The lens is bolted to its stand. It can tilt, but it can't come with you." CR>)>>

<ROUTINE MESSAGE-SPOOL-F ()
 <COND (<AND <VERB? PUT PUT-ON> <EQUAL? ,PRSI ,READING-BASIN> <HELD? ,MESSAGE-SPOOL>>
  <SETG SIGNAL-HEARD <>>
  <MOVE ,MESSAGE-SPOOL ,READING-BASIN>
  <TELL "You set the spool into the basin. It catches and starts to turn, and the [[audition stud->stud]] begins to glow on the basin's rim." CR>)
       (<AND <VERB? TAKE> <IN? ,MESSAGE-SPOOL ,READING-BASIN>>
        <COND (<EQUAL? <ITAKE> T>
               <SETG SIGNAL-HEARD <>>
               <TELL "You lift the spool. The reel stops, the address indicator clears, and both sending keys go dark." CR>)>
        <RTRUE>)
       (<AND <VERB? MUSEUM-PLAY SPIN> <EQUAL? ,PRSO ,MESSAGE-SPOOL>>
        <COND (<IN? ,MESSAGE-SPOOL ,READING-BASIN>
               <PERFORM ,V?PUSH ,AUDITION-STUD>)
              (T <TELL "The reel can turn in your hands, but it can't speak. The reading basin in the signal booth can play it." CR>)>
        <RTRUE>)
       (<AND <VERB? PUSH> <EQUAL? ,PRSO ,MESSAGE-SPOOL>>
        <TELL "The spool has no switch. It takes a basin and a listening ear to get anything out of it." CR>)
       (<VERB? EXAMINE READ>
  <COND (,LENS-READ
    <TELL "A small reel of recording tape on a wooden spool. The paper tag says FOR REVIEW. FILED AS BLANK. Along the wooden edge are three fine, even cuts, exactly the mark the lens described. Whatever the catalogue says, this spool has a private return address: it was meant to go back to one person, not out to everyone." CR>)
   (T <TELL "A small reel of recording tape on a wooden spool, worn smooth where a thumb would rest. The paper tag says FOR REVIEW. FILED AS BLANK. Along the wooden edge are three fine cuts. At first you take them for damage." CR>)>)
       (<VERB? SMELL>
  <TELL "Cedar wood and machine oil, and very faintly, someone's hand cream." CR>)
       (<VERB? LISTEN>
  <TELL "Held to your ear, the spool is silent. It needs the reading basin in the signal booth to play." CR>)
       (<VERB? RUB>
  <TELL "Your thumb finds the smooth hollow worn into the wood. Someone held this spool exactly this way, again and again." CR>)
       (<VERB? SHAKE>
  <TELL "You give it a careful shake. The tape stays tight on its reel. Whoever wound it took great care." CR>)>>

<ROUTINE HALL-BENCH-F ()
 <COND (<VERB? EXAMINE>
  <TELL "A plain wooden bench. Two shallow hollows are worn into the seat, very close together. People seem to have sat here in pairs, shoulder to shoulder, saying nothing." CR>)
       (<VERB? RUB>
  <TELL "The wood is smooth and faintly warm, as if someone got up from it only a moment ago." CR>)
       (<VERB? LISTEN>
  <TELL "You stand still beside the bench and listen. The hall is so quiet you can hear your own heartbeat, and under it, very faintly, the relay humming in the booth." CR>)
       (<VERB? CLIMB-ON CLIMB-FOO MUSEUM-SIT>
  <TELL "You sit in one of the two hollows. The other stays empty beside you, and the hush settles over both. After a while you get up again; the spool is still waiting to be checked." CR>)
       (<VERB? LOOK-UNDER>
  <TELL "Under the bench, the carpet is hardly worn at all. Everyone who sat here kept their feet very still." CR>)
       (<VERB? TAKE MOVE PUSH>
  <TELL "The bench is fixed to the floor, facing the diagram. It has faced that way for a very long time." CR>)>>

<ROUTINE SERVICE-DIAGRAM-F ()
 <COND (<VERB? EXAMINE READ>
  <TELL "The diagram shows the relay as a web of lines. Two of them leave the signal booth. The thick line, the MEMORIAL FEED, goes to every speaker under the dome, but it carries only new material chosen in the booth, not the spool itself. The thin line, the RETURN PATH, sends a new acknowledgment back to the sender and nobody else. In one corner someone has drawn a careful line around the part the museum is allowed to keep: the empty space between messages." CR>)
       (<VERB? RUB>
  <TELL "Your finger follows the thin return line across the glass, back to its single, tiny destination." CR>)
       (<VERB? TAKE MOVE>
  <TELL "The diagram is framed and screwed to the wall. It belongs to the building." CR>)>>

<ROUTINE READING-BASIN-F ()
 <COND (<VERB? EXAMINE SEARCH LOOK-INSIDE>
  <COND (<IN? ,MESSAGE-SPOOL ,READING-BASIN>
         <TELL "The [[spool]] turns slowly in the basin. Press the [[stud]] to hear it here in the booth, not out on the feed." CR>)
        (T <TELL "A shallow bowl of black glass, made to hold a spool while it plays. It's empty. Set a wooden spool into the basin to play it." CR>)>)
       (<VERB? MUSEUM-PLAY>
        <PERFORM ,V?PUSH ,AUDITION-STUD> <RTRUE>)
       (<VERB? KNOCK>
        <TELL "The glass gives back one bright note. It's the only thing in this booth that doesn't need a speaker." CR>)
       (<VERB? CLOSE> <TELL "The basin has no lid. The sound stays in the booth unless you send something." CR>)
       (<VERB? RUB>
  <TELL "The black glass is warm and very smooth, like a stone kept in a pocket." CR>)
       (<VERB? LISTEN>
  <COND (<IN? ,MESSAGE-SPOOL ,READING-BASIN> <TELL "A soft hiss as the spool turns. It won't make a real sound until you press the stud." CR>)
        (T <TELL "A low, patient hum, like a radio between stations." CR>)>)>>

<ROUTINE AUDITION-STUD-F ()
 <COND (<VERB? EXAMINE>
  <TELL "A round brass button beside the basin. Pressing it plays whatever is in the [[basin]] through a small speaker here in the booth. Nothing you hear this way leaves the room." CR>)
       (<VERB? PUSH>
        <COND (<NOT <IN? ,MESSAGE-SPOOL ,READING-BASIN>>
               <TELL "The speaker clicks once and goes quiet. Load the wooden spool into the [[basin]] first." CR>)
              (<NOT ,LENS-READ>
               <TELL "A woman's voice says, “I made it.” Then comes a long silence, and the spool runs out. The small [[address indicator->indicator]] on the desk blinks and asks for the kind of address: public or private? You can't tell yet. The relay staff must have marked their spools somehow; the inspection lens in Dead Letters might show more if you tilt it toward the light." CR>)
              (,SIGNAL-HEARD
               <TELL "The woman says, “I made it.” This time you know how much of the message is the minute after she stops." CR>)
              (T <SETG SIGNAL-HEARD T>
                 <TELL "A woman's voice says, “I made it.” Then, for a whole minute, you hear nothing but her breathing, slow and steady, as if she is waiting for someone to answer. The address indicator matches the three cuts on the spool to the private return register: this was never a public announcement. She was talking to one person, whoever used to wait up for her. Below the basin, both sending keys light up." CR>)>)
       (<VERB? MUSEUM-PLAY>
        <PERFORM ,V?PUSH ,AUDITION-STUD> <RTRUE>)
       (<VERB? LISTEN>
        <TELL "You put an ear to the grille. The speaker waits for the stud, not the other way around." CR>)
       (<VERB? RUB>
  <TELL "The brass button is worn into a shallow dip by years of thumbs." CR>)
       (<VERB? TAKE>
  <TELL "It's part of the desk. It's for pressing." CR>)>>

<ROUTINE ADDRESS-INDICATOR-F ()
 <COND (<VERB? EXAMINE READ>
  <COND (<ROUTE-ARMED?>
         <TELL "The little display reads PRIVATE RETURN REGISTER. It matched the three cuts on the spool to one address, and the sending keys are waiting." CR>)
        (T
         <TELL "A small address indicator set into the desk beside the keys. Its display asks PUBLIC OR PRIVATE? and blinks, waiting for a spool to be played and its address marks understood." CR>)>)
       (<VERB? RUB PUSH>
  <TELL "Its glass is warm. It only shows what the booth has worked out; it takes no answer from your finger." CR>)>>

<ROUTINE ROUTE-ARMED? ()
 <AND ,SIGNAL-HEARD <IN? ,MESSAGE-SPOOL ,READING-BASIN>>>

<ROUTINE ROUTING-READY ()
 <COND (<ROUTE-ARMED?> <RTRUE>)
       (T <TELL "The keys stay dark. The booth won't send anything until you know who this message was for. Find out what the cut marks on the spool mean, then play the loaded spool here with the audition stud." CR> <RFALSE>)>>

<ROUTINE RETURN-KEY-F ()
 <COND (<VERB? EXAMINE READ>
  <TELL "A small key marked RETURN. A single press sends one new reply back down the private return register to whoever first sent the message. It will not send the woman's voice, and it never touches the public feed.">
  <COND (<ROUTE-ARMED?> <TELL " It is lit now, softly." CR>) (T <TELL " It is dark." CR>)>)
       (<VERB? PUSH>
        <COND (<ROUTING-READY>
          <SETG MUSEUM-END 1>
          <TELL "You type four words into the return register, “Nobody had to wait,” and press the key. The indicator takes an unreasonably long time to answer. Then it prints RECEIVED, and under it a second line that someone must have typed by hand: I STILL LEFT THE LIGHT ON." CR CR "ENDING: PRIVATE RETURN" CR>
          <FINISH>)>
        <RTRUE>)
       (<VERB? LISTEN>
  <TELL "You hear nothing at this end. That was always the point of a private line." CR>)
       (<VERB? RUB>
  <TELL "The return key is worn smooth. Somebody rested a finger on it many times without ever pressing down." CR>)>>

<ROUTINE MEMORIAL-KEY-F ()
 <COND (<VERB? EXAMINE READ>
  <TELL "A small key marked MEMORIAL. It can send the minute of silence out to every speaker under the dome, without the voice and without the address: a small public record of someone waiting.">
  <COND (<ROUTE-ARMED?> <TELL " It is lit now, softly." CR>) (T <TELL " It is dark." CR>)>)
       (<VERB? PUSH>
        <COND (<ROUTING-READY>
          <SETG MUSEUM-END 2>
          <TELL "You press the key and send the minute without the voice. Across the dome, every speaker announces nothing at all. You had expected complaints asking what went wrong. Instead, the night dispatcher sends one short message: “Please wait to reset. Someone is still listening.”" CR CR "ENDING: A MINUTE FOR THE LIVING" CR>
          <FINISH>)>
        <RTRUE>)
       (<VERB? LISTEN>
  <TELL "The key is silent. The relay's hum carries on behind it, ready to make a roomful of people stop and listen." CR>)
       (<VERB? RUB>
  <TELL "The memorial key is cool and almost new. It was hardly ever used." CR>)>>

<ROUTINE V-VERSION ()
 <TELL "The Museum of Unsent Signals|AdventureArena, 2026|Release " N ,RELEASEID CR>>

<ROUTINE GO ()
 <V-VERSION> <CRLF>
 <SETG HERE ,ADMISSIONS> <SETG VERBOSE T> <SETG LIT T>
 <SETG WINNER ,ADVENTURER> <SETG PLAYER ,WINNER> <MOVE ,WINNER ,HERE>
 <TELL "The museum is closing for good. Tonight is the last night of the Museum of Unsent Signals, the place where the city kept every message that was recorded and never sent. Tomorrow morning the old relay under the dome will be switched off. The caretaker left you in charge of the last shift. There is a note on the plaque and one piece of advice: “You don't have to make everything speak.”" CR CR>
 <TELL D ,HERE CR>
 <V-LOOK> <MAIN-LOOP> <AGAIN>>

<ROUTINE V-SCORE ("OPTIONAL" (ASK? T))
 <COND (<NOT <EQUAL? ,MUSEUM-END 0>> <TELL "The museum has entered its last exhibit." CR>)
       (<ROUTE-ARMED?> <TELL "The recording has been heard. No transmission has left the booth." CR>)
       (T <TELL "One entry in the museum catalogue is still under review." CR>)>>

<ROUTINE V-TILT-LENS ()
 <TELL "That won't tilt. The inspection lens sits in a movable collar." CR>>

<ROUTINE V-MUSEUM-SIT ()
 <TELL "There isn't room to sit there. The Quiet Hall has a bench." CR>>

<ROUTINE V-MUSEUM-PLAY ()
 <TELL "That's not a recording you can play. The signal booth has a basin for spools." CR>>

<ROUTINE V-MUSEUM-LISTEN ()
 <COND (<EQUAL? ,HERE ,ADMISSIONS> <PERFORM ,V?LISTEN ,LOBBY>)
       (<EQUAL? ,HERE ,DEAD-LETTERS> <PERFORM ,V?LISTEN ,GALLERY>)
       (<EQUAL? ,HERE ,QUIET-HALL> <PERFORM ,V?LISTEN ,QUIET-ROOM>)
       (T <PERFORM ,V?LISTEN ,READING-BASIN>)>
 <RTRUE>>
