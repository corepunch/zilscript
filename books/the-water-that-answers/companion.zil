<ROUTINE SUGGEST-ACTIONS ()
 <COND (<EQUAL? ,HERE ,PROFILE-DESK>
        <CHOICE "case.doctor" "Take the case as the doctor" "choose doctor" ,CHOICE-INVESTIGATE 100>
        <CHOICE "case.reporter" "Take the case as the reporter" "choose reporter" ,CHOICE-INVESTIGATE 99>
        <CHOICE "case.mechanic" "Take the case as the mechanic" "choose mechanic" ,CHOICE-INVESTIGATE 98>)
       (<EQUAL? ,HERE ,PUMP-ROOM>
        <COND (<NOT ,HAVE-MARKER>
               <CHOICE "pump.order" "Listen to the recorded work order" "listen to tape" ,CHOICE-PROGRESS 100>)
              (T
               <COND (<==? <GET ,EVIDENCE-CHECK 0> ,INV-READY>
                      <CHOICE "pump.check" "Separate the two voices for corroboration" "search tape" ,CHOICE-INVESTIGATE 90>)
                     (<==? <GET ,EVIDENCE-CHECK 0> ,INV-FAILED>
                      <CHOICE "pump.push" "Pry the relay cover; a failure will be heard downstairs" "open cover" ,CHOICE-INVESTIGATE 90>)>
               <COND (<NOT ,RESPONSE-LOGGED>
                      <COND (<AND <NOT ,CALLED-PARTNER> <L? <STAT ,HERO ,A-COMPOSURE> 50>>
                             <CHOICE "pump.listen-cost" "Stay and listen to the second track; lose 5 Composure" "listen to track" ,CHOICE-INVESTIGATE 80>)
                            (T <CHOICE "pump.listen" "Listen to the second track" "listen to track" ,CHOICE-INVESTIGATE 80>)>)>)>
        <CHOICE "pump.landing" "Go to the telephone on the landing" "east" ,CHOICE-PROGRESS 95>)
       (<EQUAL? ,HERE ,PUMP-LANDING>
        <COND (,HAVE-MARKER
               <CHOICE "landing.report" "Report the work order and close the case" "use telephone" ,CHOICE-PROGRESS 100>
               <COND (<NOT ,CALLED-PARTNER>
                      <CHOICE "landing.support" "Call Noor for support before returning" "call telephone" ,CHOICE-INVESTIGATE 90>)>)>
        <CHOICE "landing.return" "Return to the pump room" "west" ,CHOICE-RETURN 70>)>>
