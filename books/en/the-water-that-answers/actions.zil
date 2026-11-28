<GLOBAL DOCTOR-SKILLS <LTABLE 80 40 20 65>>
<GLOBAL REPORTER-SKILLS <LTABLE 25 70 35 55>>
<GLOBAL MECHANIC-SKILLS <LTABLE 35 25 90 60>>
<SETG RPG-PRESETS <LTABLE <TABLE "doctor" DOCTOR-SKILLS>
                         <TABLE "reporter" REPORTER-SKILLS>
                         <TABLE "mechanic" MECHANIC-SKILLS>>>

<GLOBAL HAVE-MARKER <>>
<GLOBAL HEARD-TRACK <>>
<GLOBAL REPORT-DETAIL 0>
<GLOBAL LOUD <>>
<GLOBAL RESPONSE-LOGGED <>>
<GLOBAL CALLED-PARTNER <>>
<GLOBAL EVIDENCE-CHECK <TABLE 0>>

<SYNTAX USE OBJECT = V-USE>
<SYNTAX CALL OBJECT = V-CALL-PARTNER>
<ROUTINE V-CALL-PARTNER () <TELL "You need the station telephone to call Noor." CR>>

<ROUTINE RPG-PRESET-TITLE (INDEX)
 <COND (<==? .INDEX 1> <TELL "Doctor">)
       (<==? .INDEX 2> <TELL "Reporter">)
       (T <TELL "Mechanic">)>>

<ROUTINE RPG-PRESET-SUMMARY (INDEX)
 <COND (<==? .INDEX 1> <TELL "Hear what a failing breath reveals. Highest composure.">)
       (<==? .INDEX 2> <TELL "Catch a voice contradicting its own story. Skilled at interviews.">)
       (T <TELL "Hear the difference between a working pump and a recording. Skilled at repair.">)>>

<ROUTINE V-VERSION () <TELL "THE WATER THAT ANSWERS" CR>>
<ROUTINE GO ()
 <V-VERSION> <CRLF>
 <SETG HERE ,PROFILE-DESK> <SETG VERBOSE T> <SETG LIT T>
 <SETG WINNER ,ADVENTURER> <SETG PLAYER ,WINNER> <MOVE ,WINNER ,HERE>
 <RPG-PREPARE>
 <COND (<0? ,RPG-PRESET-INDEX> <V-LOOK>)
       (T <RPG-BEGIN ,OPEN-CASE> <SETG CLOCK-WAIT <>>)>
 <MAIN-LOOP> <AGAIN>>

<ROUTINE PROFILE-DESK-F (RARG)
 <COND (<==? .RARG ,M-LOOK>
        <TELL "To open the case, type CHOOSE DOCTOR, CHOOSE REPORTER, or CHOOSE MECHANIC." CR>)>>

<ROUTINE CHOOSE-F ("AUX" INDEX)
 <SET INDEX <COND (<==? ,PRSO ,CARD-DOCTOR> 1)
                  (<==? ,PRSO ,CARD-REPORTER> 2) (T 3)>>
 <COND (<VERB? EXAMINE READ> <RPG-PRESET-SUMMARY .INDEX> <CRLF>)
       (<VERB? RPG-CHOOSE>
        <COND (<RPG-SELECT-PRESET .INDEX> <RPG-BEGIN ,OPEN-CASE>)>)
       (<VERB? TAKE TOUCH> <TELL "The file can stay here. Choose the profile to take the case." CR>)>>

<ROUTINE OPEN-CASE ()
 <SETG HERE ,PUMP-ROOM> <MOVE ,WINNER ,HERE>
 <TELL "At 02:13 Noor forwarded a call from the old pumping station. The caller asked for someone to open Gate Four. That gate was bricked up nineteen years ago." CR CR>
 <V-LOOK>>

<ROUTINE PUMP-ROOM-F (RARG)
 <COND (<==? .RARG ,M-LOOK>
        <TELL "Silt has dried in crescents up the pump-room wall. A desk lamp still works. Beside it: a running tape machine and a relay cover bowed around one rusted screw. The passage east leads to the landing and the station telephone. You could call Noor from there, but the tape is still turning, and whatever is on it may be the only warning you get." CR>
        <COND (<AND ,HEARD-TRACK <NOT ,RESPONSE-LOGGED>>
               <TELL "The second track is still playing." CR>)> <RTRUE>)>>

<ROUTINE LANDING-F (RARG)
 <COND (<==? .RARG ,M-LOOK>
        <TELL "The landing smells of cold iron. A telephone with a waxed cord is bolted to the wall. Through the doorway to the west, the tape reels turn in their circle of yellow light." CR>
        <COND (,LOUD <TELL "From below the stairs comes a slow scrape, as if someone is locating each step with a pole." CR>)> <RTRUE>)>>

<ROUTINE TAPE-F ()
 <COND (<NOT ,RPG-STARTED> <TELL "Open a case file first." CR>)
       (<VERB? READ LISTEN EXAMINE>
        <COND (<NOT ,HAVE-MARKER>
               <SETG HAVE-MARKER T>
               <TELL "A woman reads a work order in a level voice: 'Gate Four. Counterweight jammed. Isolate circuit C before opening.' You write it down. Her chair scrapes. From much farther away, a second voice gives your name." CR>
               <SETG HEARD-TRACK T>
               <INV-SHOCK ,HERO 2 17>
               <COND (<L? <STAT ,HERO ,A-COMPOSURE> 50>
                      <TELL "You take your fingers off the machine. Either step east to call Noor, or stay and listen; lose 5 Composure." CR>)
                     (T <TELL "You can listen to the second track or carry what you know east to Noor." CR>)>)
              (T <TELL "Your notes still say: Gate Four, circuit C. The work order does not change." CR>)>
        <COND (<0? <GET ,EVIDENCE-CHECK 0>>
               <TELL "You can study the recording for corroboration. It isn't needed to report the work order." CR>)>
        <RTRUE>)
       (<VERB? SEARCH>
        <COND (<NOT ,HAVE-MARKER> <TELL "Listen to the tape once before trying to pull it apart." CR>)
              (<NOT <0? <GET ,EVIDENCE-CHECK 0>>> <TELL "You've already taken what you can from a clean listen." CR>)
              (<==? <INV-ATTEMPT ,EVIDENCE-CHECK ,HERO <FIELD-SKILL> ,INV-HARD <>> 1> <CORROBORATE>)
              (T <TELL "There isn't enough separation between the two voices. You can leave with the work order, or pry the relay cover; a failure will be heard downstairs." CR>)>
        <RTRUE>)
       (<VERB? TAKE REMOVE TOUCH> <TELL "The reels are turning. Better to leave the tape on its spindles." CR>)>>

<ROUTINE FIELD-SKILL ()
 <COND (<==? ,RPG-PRESET-INDEX 1> ,A-MEDICINE)
       (<==? ,RPG-PRESET-INDEX 2> ,A-INTERVIEW)
       (T ,A-REPAIR)>>

<ROUTINE CORROBORATE ()
 <SETG REPORT-DETAIL ,RPG-PRESET-INDEX>
 <COND (<==? ,REPORT-DETAIL 1>
        <TELL "Between the two voices you hear one long inhalation, then none. The first woman was reading an instruction. The second voice speaks without breathing." CR>)
       (<==? ,REPORT-DETAIL 2>
        <TELL "The first woman identifies herself by surname. The second answers before the question has been asked. Someone added a reply to a conversation that never took place." CR>)
       (T <TELL "The pump relay normally clicks twice. The tape has three clicks, exactly one second apart. The spare trigger is wired into the telephone feed." CR>)>>

<ROUTINE COVER-F ()
 <COND (<VERB? EXAMINE SEARCH TOUCH>
        <TELL "The bent cover will come away if you pry it. It will also ring against the pipe if you slip." CR>
        <COND (<==? <GET ,EVIDENCE-CHECK 0> ,INV-FAILED>
               <TELL "Pry the cover; a failure will be heard downstairs." CR>)> <RTRUE>)
       (<VERB? OPEN PUSH PULL TAKE>
        <COND (<==? <GET ,EVIDENCE-CHECK 0> ,INV-FAILED>
               <COND (<==? <INV-ATTEMPT ,EVIDENCE-CHECK ,HERO ,A-REPAIR ,INV-REGULAR T> 1>
                      <TELL "You catch the cover before it hits. Under it, a splice links the recorder to the main line." CR>
                      <SETG REPORT-DETAIL 4>)
                     (T <SETG LOUD T> <TELL "The cover strikes the pipe. Something at the foot of the stairs taps three times in reply." CR>)>)
              (<0? <GET ,EVIDENCE-CHECK 0>>
               <TELL "Leave the cover until you've tried to separate the voices on the tape." CR>)
              (T <TELL "There's no reason to pry it again. You can take the work order to the telephone." CR>)>
        <RTRUE>)>>

<ROUTINE TRACK-F ()
 <COND (<VERB? EXAMINE LISTEN READ>
        <COND (<NOT ,HEARD-TRACK> <TELL "You need to hear the main recording first." CR>)
              (,RESPONSE-LOGGED <TELL "You have the last words down. Nothing follows them." CR>)
              (T <SETG RESPONSE-LOGGED T>
                 <COND (<AND <NOT ,CALLED-PARTNER> <L? <STAT ,HERO ,A-COMPOSURE> 50>>
                        <LOSE ,HERO ,A-COMPOSURE 5>
                        <TELL "It costs you five Composure to stay. ">)>
                 <TELL "You wind the spare track back. The voice isn't asking to be let out. It says: 'When she calls, don't say where you are.'" CR>)>
        <RTRUE>)
       (<VERB? TAKE TOUCH> <TELL "It is a second recording on the same tape." CR>)>>

<ROUTINE PHONE-F ()
 <COND (<VERB? EXAMINE LISTEN>
        <TELL "Noor rigged the telephone to her desk. Call for support, or use the telephone to report the work order." CR>)
       (<VERB? CALL-PARTNER>
        <COND (<NOT ,HAVE-MARKER>
               <TELL "Noor picks up. 'Listen to the tape first. I'll be here when you need me.'" CR>)
              (<NOT ,CALLED-PARTNER>
               <SETG CALLED-PARTNER T>
               <GAIN ,HERO ,A-COMPOSURE 8>
               <TELL "Noor asks for the time, then for one thing you can see. The wax on the cord is green. You tell her. She stays on the line while you decide whether to go back to the tape or use the telephone to report the work order." CR>)
              (T <TELL "Noor is still on the line. Take the time you need." CR>)>
        <RTRUE>)
       (<VERB? USE>
        <COND (<NOT ,HAVE-MARKER>
               <TELL "'I need the work order,' Noor says. The tape machine is west." CR>)
              (T
               <TELL "You read back the order: Gate Four, circuit C. Noor has enough to shut the line from her end." CR>
               <COND (<G? ,REPORT-DETAIL 0> <TELL "She logs your corroborating detail as a separate piece of evidence, leaving the original work order intact for the crew." CR>
                      <COND (<==? ,REPORT-DETAIL 1> <TELL "She adds: 'second speaker, no breath.' " CR>)
                            (<==? ,REPORT-DETAIL 2> <TELL "She preserves the reply separately from the original call." CR>)
                            (<==? ,REPORT-DETAIL 3> <TELL "She sends a crew to trace the telephone feed once the water falls." CR>)
                            (T <TELL "She tells the first crew to photograph the splice before touching it." CR>)>)>
               <COND (,RESPONSE-LOGGED <TELL "You give her the last warning without telling her where you are." CR>)>
               <COND (,LOUD <TELL "As the scraping reaches the landing, Noor cuts the circuit. The footsteps stop one stair short." CR>)
                     (T <TELL "In the pump room the reels slow to a stop. For the first time tonight, the telephone has a dial tone." CR>)>
               <TELL "CASE CLOSED" CR> <FINISH>)>
        <RTRUE>)
       (<VERB? TAKE TOUCH> <TELL "The telephone is bolted to the landing wall." CR>)>>

<ROUTINE V-USE () <TELL "Use something nearby." CR>>
<ROUTINE V-SCORE ("OPTIONAL" (ASK? T))
 <COND (,RPG-STARTED <V-RPG-STATUS>) (T <TELL "Open a case file first." CR>)>>

<ROUTINE RPG-EXPORT-SHEET ("AUX" NAME)
 <COND (<NOT ,RPG-STARTED> <RFALSE>)>
 <COND (<NAMED?> <PRINT-NAME>) (T <TELL "Investigator">)>
 <SET NAME <TAKE-OUTPUT>>
 <RPG-PRESET-TITLE ,RPG-PRESET-INDEX>
 <SHEET-IDENTITY .NAME <TAKE-OUTPUT>>
 <EXPORT-SHEET-RANKS ,HERO ,INVESTIGATOR-SHEET-ROW>
 <RTRUE>>
