<SYNTAX ACCEPT OBJECT = V-BW-ACCEPT>
<SYNTAX REFUSE OBJECT = V-BW-REFUSE>
<SYNONYM TURN REVERSE>
<OBJECT BW-OFFER (DESC "offer") (SYNONYM OFFER BARGAIN DEAL SIGN INSCRIPTION)>
<ROOM BW-WORLDSHIP (DESC "Taa II: Sound Gallery")>
<ROOM BW-CONVERTER (DESC "Taa II: Converter Chamber")>
<OBJECT BW-KLAW (DESC "Klaw") (SYNONYM KLAW)>
<OBJECT BW-PRISM (DESC "sound prism") (SYNONYM PRISM CAGE CATCH) (ADJECTIVE SOUND)>
<OBJECT BW-PLANS (DESC "Doom's plans") (SYNONYM PLANS PLAN DIAGRAMS DIAGRAM) (ADJECTIVE DOOM REVERSE)>
<OBJECT BW-REVERSE (DESC "reverse control") (SYNONYM CONTROL LEVER CONVERTER SIPHON) (ADJECTIVE REVERSE)>
<ROUTINE MSG-BW-OFFER-PRESENCE ()
 <COND (,BW-OFFER-REFUSED <TELL "Doom's rejected offer still glows." CR>)
       (T <TELL "Doom's offer glows on a sign." CR>)>>
<ROUTINE MSG-BW-OFFER ()
 <TELL "'I can send you all home,' says Doom. 'In return, you must always obey me.'" CR "Type 'accept offer' to take the deal and end the story, or 'refuse offer' to keep looking for your own way." CR>>
<ROUTINE MSG-BW-OFFER-FIRST ()
 <TELL "Read Doom's offer before you decide. Try READ INSCRIPTION." CR>>
<ROUTINE MSG-BW-ALREADY-REFUSED () <TELL "You have already refused to surrender your freedom. Doom has heard your answer." CR>>
<ROUTINE MSG-BW-REFUSED () <TELL "'Home isn't a gift if you own the people who live there,' you tell him. Doom's image stiffens. 'Then find your own way.' You intend to do just that." CR>>
<ROUTINE MSG-BW-ACCEPT-END ()
 <TELL "Doom sends everyone home. The passengers run to their families. Then his voice crackles in your ear. 'I have your first orders.'" CR CR "THE END: DOOM'S BARGAIN" CR>>
<ROUTINE MSG-BW-WORLDSHIP ()
 <TELL "Galactus's ship hums like a singing glass. ">
 <COND (,BW-KLAW-FREE <TELL "Klaw stands beside the open prism. ">)
       (T <TELL "Klaw is trapped in a clear prism. ">)>
 <TELL "The converter room is north. The tower is south." CR>>
<ROUTINE MSG-BW-CONVERTER ()
 <TELL "Huge pipes hum in the converter room. Doom's plans lie beside a lever. The sound gallery is south." CR>>
<ROUTINE MSG-BW-KLAW ()
 <COND (,BW-KLAW-FREE <TELL "'Galactus built the converter to drain the planet,' says Klaw. 'Doom meant to steal that power. You can send it back.'" CR>)
       (T <TELL "Klaw is made of sound. In the prism he can barely squeak. 'Doom locked me in. Please open the catch!'" CR>)>>
<ROUTINE MSG-BW-KLAW-STRIKE () <TELL "The prism rings like a struck glass. 'Please don't do that again,' says Klaw. There is a catch on the prism." CR>>
<ROUTINE MSG-BW-PRISM ()
 <TELL "The prism traps every sound Klaw makes. Push the catch marked RELEASE to open it." CR>>
<ROUTINE MSG-BW-PRISM-OPEN () <TELL "The catch is open and Klaw is free. The empty prism gives a tiny, satisfied ping." CR>>
<ROUTINE MSG-BW-FREE ()
 <TELL "The prism opens like a flower. Klaw steps out and plays a thank-you tune. 'Read Doom's plans in the next room. You can give the power back to Battleworld.'" CR>>
<ROUTINE MSG-BW-PLANS ()
 <TELL "Doom planned to steal the power that Galactus drained from Battleworld. The drawing shows a way to send it back: turn the lever to RETURN." CR>>
<ROUTINE MSG-BW-PLANS-HINT () <TELL "The plans are fixed under glass. You can read the diagram without taking them." CR>>
<ROUTINE MSG-BW-REVERSE ()
 <TELL "One marking points toward the planet, the other away. Read Doom's plans to find the right setting." CR>>
<ROUTINE MSG-BW-REVERSE-BLOCK ()
 <TELL "The lever could send the power either way. Read Doom's plans first." CR>>
<ROUTINE MSG-BW-REVERSE-END ()
 <TELL "You turn the control to RETURN. The pipes sing in reverse; the Loom releases its thread and the last door swings open. Across Battleworld, dark windows glow again as the stolen energy returns to homes and shelters." CR CR>
 <COND (,BW-OFFER-REFUSED <TELL "You kept your answer to Doom, and found a way to help without giving up your freedom. ">)>
 <COND (,BW-KLAW-FREE <TELL "Klaw sends a clear note down the docking bridge. Ms. Marvel answers with a cheer. " >)>
 <TELL "The passengers cross home, while the Worldship's lamps settle to a quiet glow. Doom's promise of wishes has lost its power over them: they have chosen their own way home." CR CR "THE END: THE LAST DOOR STAYS OPEN" CR>>
<ROUTINE BW-LATE-CHOICES ()
 <COND (<EQUAL? ,HERE ,TOWER>
        <COND (<NOT ,BW-OFFER-SEEN> <CHOICE "bw.offer.hear" "Read Doom's offer" "read offer" ,CHOICE-INVESTIGATE 98>)
              (<NOT ,BW-OFFER-REFUSED>
               <CHOICE "bw.offer.accept" "Take the deal and end the story" "accept offer" ,CHOICE-PROGRESS 70>
               <CHOICE "bw.offer.refuse" "Refuse Doom's deal" "refuse offer" ,CHOICE-PROGRESS 90>)>
        <CHOICE "bw.tower.ship" "Cross to Galactus's Worldship" "north" ,CHOICE-INVESTIGATE 85>)
       (<EQUAL? ,HERE ,BW-WORLDSHIP>
        <CHOICE "bw.ship.klaw" "Listen to Klaw" "examine klaw" ,CHOICE-INVESTIGATE 90>
        <COND (<NOT ,BW-KLAW-FREE> <CHOICE "bw.ship.prism" "Open the sound prism" "open prism" ,CHOICE-PROGRESS 98>)>
        <CHOICE "bw.ship.converter" "Visit the converter chamber" "north" ,CHOICE-PROGRESS 95>
        <CHOICE "bw.ship.tower" "Return to the tower" "south" ,CHOICE-RETURN 80>)
       (<EQUAL? ,HERE ,BW-CONVERTER>
        <COND (<NOT ,BW-PLAN-READ> <CHOICE "bw.converter.plans" "Read Doom's plans" "read plans" ,CHOICE-INVESTIGATE 99>)
              (T <CHOICE "bw.converter.reverse" "Return the stolen energy" "turn lever" ,CHOICE-PROGRESS 100>)>
        <CHOICE "bw.converter.gallery" "Return to the sound gallery" "south" ,CHOICE-RETURN 80>)>>
