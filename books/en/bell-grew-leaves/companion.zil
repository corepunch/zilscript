<ROUTINE C-MOVE (ID LABEL CMD)
 <CHOICE .ID .LABEL .CMD ,CHOICE-RETURN 65> <CHOICE-DETAILS "group" "move">>
<ROUTINE SUGGEST-ACTIONS ()
 <COND (<EQUAL? ,HERE ,COURT>
        <CHOICE "court.inspect" "Look at the roots around the bell" "examine root bell" ,CHOICE-INVESTIGATE 76>
        <CHOICE "court.listen" "Put your ear to the bell" "listen to root bell" ,CHOICE-INTERACT 45>
        <CHOICE "court.ring" "Answer the distant taps" "ring root bell" ,CHOICE-PROGRESS 93>
        <COND (<HELD? ,WICK>
               <CHOICE "court.fit" "Fit the wick into the bell" "put reed wick in root bell" ,CHOICE-EXPERIMENT 83>)
              (<IN? ,WICK ,BELL>
               <CHOICE "court.retrieve" "Pull the wick free again" "take reed wick" ,CHOICE-EXPERIMENT 40>)>
        <C-MOVE "court.store" "Go to the reed store" "east">
        <C-MOVE "court.spring" "Go to the spring walk" "north">)
       (<EQUAL? ,HERE ,STORE>
        <CHOICE "store.tile" "Study the pictures on the signal tile" "read signal tile" ,CHOICE-INVESTIGATE 97>
        <C-MOVE "store.court" "Return to the bell court" "west">)
       (<EQUAL? ,HERE ,SPRING>
        <CHOICE "spring.spout" "See where the spring water goes" "examine turning spout" ,CHOICE-INVESTIGATE 78>
        <CHOICE "spring.bowl" "Check the soaking bowl" "examine soaking bowl" ,CHOICE-INVESTIGATE 50>
        <COND (,SPOUT-SEEN
               <COND (,FLOWING
                      <CHOICE "spring.drain" "Turn the spout away from the bowl" "turn turning spout" ,CHOICE-EXPERIMENT 39>)
                     (T <CHOICE "spring.fill" "Turn the spout toward the bowl" "turn turning spout" ,CHOICE-PROGRESS 93>)>)>
        <COND (<AND <HELD? ,WICK> ,FLOWING <NOT ,WET-WICK>>
               <CHOICE "spring.soak" "Dip the wick in the spring water" "put reed wick in soaking bowl" ,CHOICE-PROGRESS 98>)>
        <C-MOVE "spring.court" "Return to the bell court" "south">
        <C-MOVE "spring.landing" "Go to the shutter landing" "east">)
       (<EQUAL? ,HERE ,LANDING>
        <CHOICE "landing.inspect" "Examine the frost shutter" "examine frost shutter" ,CHOICE-INVESTIGATE 74>
        <COND (<FSET? ,SHUTTER ,OPENBIT>
               <CHOICE "landing.close" "Shut out the fog again" "close frost shutter" ,CHOICE-EXPERIMENT 40>)
              (T <CHOICE "landing.open" "Open the shutter to the hollow" "open frost shutter" ,CHOICE-PROGRESS 94>)>
        <C-MOVE "landing.spring" "Go back to the spring walk" "west">)>
 <COND (<IN? ,WICK ,HERE>
        <CHOICE "wick.take" "Pick up the reed wick" "take reed wick" ,CHOICE-PROGRESS 91>)
       (<HELD? ,WICK>
        <CHOICE "wick.inspect" "Look at the wick you are carrying" "examine reed wick" ,CHOICE-INVESTIGATE 45>)>>
