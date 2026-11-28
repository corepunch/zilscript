<SYNTAX ACCEPT OBJECT = V-BW-ACCEPT>
<SYNTAX REFUSE OBJECT = V-BW-REFUSE>
<OBJECT BW-OFFER (DESC "offer") (SYNONYM OFFER BARGAIN DEAL)>
<ROOM BW-WORLDSHIP (DESC "Taa II: Sound Gallery")>
<ROOM BW-CONVERTER (DESC "Taa II: Converter Chamber")>
<OBJECT BW-KLAW (DESC "Klaw") (SYNONYM KLAW)>
<OBJECT BW-PRISM (DESC "sound prism") (SYNONYM PRISM CAGE) (ADJECTIVE SOUND)>
<OBJECT BW-PLANS (DESC "Doom's plans") (SYNONYM PLANS PLAN DIAGRAMS DIAGRAM) (ADJECTIVE DOOM REVERSE)>
<OBJECT BW-REVERSE (DESC "reverse control") (SYNONYM CONTROL LEVER CONVERTER SIPHON) (ADJECTIVE REVERSE)>
<ROUTINE MSG-BW-OFFER-PRESENCE ()
 <COND (,BW-OFFER-REFUSED <TELL "Doom's offer still flickers beside the Loom, though you have refused it." CR>)
       (T <TELL "A green inscription beside him invites you to hear Doom's offer." CR>)>>
<ROUTINE MSG-BW-OFFER ()
 <TELL "Doom promises to grant your wish to return home and send the others back too. In exchange you must surrender your freedom to him: from then on you will obey his orders, even when you disagree. He calls it peace. You can say “accept offer” or “refuse offer”; accepting ends this adventure." CR>>
<ROUTINE MSG-BW-OFFER-FIRST () <TELL "Hear Doom's offer first, so you know what he asks in return." CR>>
<ROUTINE MSG-BW-ALREADY-REFUSED () <TELL "You have already refused to surrender your freedom. Doom has heard your answer." CR>>
<ROUTINE MSG-BW-REFUSED () <TELL "'Home isn't a gift if you own the people who live there,' you tell him. Doom's image stiffens. 'Then find your own way.' You intend to do just that." CR>>
<ROUTINE MSG-BW-ACCEPT-END () <TELL "You accept. Doom opens the way to Earth, and the passengers return to their families. He keeps his promise to grant your wish. Then his voice sounds in your ear: your first orders await. Home is familiar, but your choices are no longer your own." CR CR "THE END: DOOM'S BARGAIN" CR>>
<ROUTINE MSG-BW-WORLDSHIP ()
 <TELL "A docking bridge has brought you aboard Taa II, Galactus's immense Worldship. The gallery hums like a glass being rubbed around its rim. ">
 <COND (,BW-KLAW-FREE <TELL "Klaw stands beside the open prism. ">)
       (T <TELL "Klaw shimmers inside a sound prism. ">)>
 <TELL "The converter chamber lies north. The tower is south." CR>>
<ROUTINE MSG-BW-CONVERTER ()
 <TELL "The Worldship's converter chamber is big enough to shelter a town. Its great pipes point down toward Battleworld. Doom's plans lie beside a reverse control. The sound gallery is south." CR>>
<ROUTINE MSG-BW-KLAW ()
 <COND (,BW-KLAW-FREE <TELL "Klaw taps a bright rhythm against his palm. 'The converter was meant to take the planet's energy. Doom wanted to steal it for himself. Reverse it, and perhaps this place will get something back instead.'" CR>)
       (T <TELL "Klaw is made of sound; inside the prism his voice comes out as a squeak. 'Doom let me out once and then put me in here to keep me quiet. Try the catch on the prism. Gently, please.'" CR>)>>
<ROUTINE MSG-BW-KLAW-STRIKE () <TELL "The prism rings like a struck glass. 'Please don't do that again,' says Klaw. There is a catch on the prism." CR>>
<ROUTINE MSG-BW-PRISM () <TELL "The clear cage catches every note Klaw makes. A broad catch marked RELEASE is meant to be pushed, not smashed." CR>>
<ROUTINE MSG-BW-PRISM-OPEN () <TELL "The catch is open and Klaw is free. The empty prism gives a tiny, satisfied ping." CR>>
<ROUTINE MSG-BW-FREE () <TELL "You press the catch. The prism unfolds like a flower and Klaw steps out in a ripple of sound. He listens to the pipes. 'Doom's plans explain the reverse control in the next chamber. Give the power back to the world.' He plays a little fanfare for your trouble." CR>>
<ROUTINE MSG-BW-PLANS () <TELL "Doom's notes describe stealing power as Galactus's converter drains the planet. In the margin, a repair diagram shows how to reverse the flow: read the scale, then turn the control. The energy will return to Battleworld instead of feeding Doom." CR>>
<ROUTINE MSG-BW-PLANS-HINT () <TELL "The plans are fixed under glass. You can read the diagram without taking them." CR>>
<ROUTINE MSG-BW-REVERSE () <TELL "The control has a scale with arrows pointing toward and away from the planet. The nearby plans explain which setting returns the energy safely." CR>>
<ROUTINE MSG-BW-REVERSE-BLOCK () <TELL "The arrows on the scale point both ways. Read Doom's plans first so you know where the power will go." CR>>
<ROUTINE MSG-BW-REVERSE-END ()
 <TELL "You turn the control to RETURN. The pipes sing in reverse; the Loom releases its thread and the last door swings open. Across Battleworld, dark windows glow again as the stolen energy returns to homes and shelters." CR CR>
 <COND (,BW-OFFER-REFUSED <TELL "You kept your answer to Doom, and found a way to help without giving up your freedom. ">)>
 <COND (,BW-KLAW-FREE <TELL "Klaw sends a clear note down the docking bridge. Ms. Marvel answers with a cheer. " >)>
 <TELL "The passengers cross home, while the Worldship's lamps settle to a quiet glow. Doom's promise of wishes has lost its power over them: they have chosen their own way home." CR CR "THE END: THE LAST DOOR STAYS OPEN" CR>>
<ROUTINE BW-LATE-CHOICES ()
 <COND (<EQUAL? ,HERE ,TOWER>
        <COND (<NOT ,BW-OFFER-SEEN> <CHOICE "bw.offer.hear" "Hear Doom's offer" "examine offer" ,CHOICE-INVESTIGATE 98>)
              (<NOT ,BW-OFFER-REFUSED>
               <CHOICE "bw.offer.accept" "Accept Doom's bargain and end the adventure" "accept offer" ,CHOICE-PROGRESS 70>
               <CHOICE "bw.offer.refuse" "Refuse to surrender your freedom" "refuse offer" ,CHOICE-PROGRESS 90>)>
        <CHOICE "bw.tower.ship" "Cross to Galactus's Worldship" "north" ,CHOICE-INVESTIGATE 85>)
       (<EQUAL? ,HERE ,BW-WORLDSHIP>
        <CHOICE "bw.ship.klaw" "Listen to Klaw" "examine klaw" ,CHOICE-INVESTIGATE 90>
        <COND (<NOT ,BW-KLAW-FREE> <CHOICE "bw.ship.prism" "Open the sound prism" "open prism" ,CHOICE-PROGRESS 98>)>
        <CHOICE "bw.ship.converter" "Visit the converter chamber" "north" ,CHOICE-PROGRESS 95>
        <CHOICE "bw.ship.tower" "Return to the tower" "south" ,CHOICE-RETURN 80>)
       (<EQUAL? ,HERE ,BW-CONVERTER>
        <COND (<NOT ,BW-PLAN-READ> <CHOICE "bw.converter.plans" "Read Doom's plans" "read plans" ,CHOICE-INVESTIGATE 99>)
              (T <CHOICE "bw.converter.reverse" "Return the stolen energy" "turn control" ,CHOICE-PROGRESS 100>)>
        <CHOICE "bw.converter.gallery" "Return to the sound gallery" "south" ,CHOICE-RETURN 80>)>>
