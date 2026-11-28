<ROOM VILLAGE (DESC "Zsaji's Village")>
<OBJECT SCALES (DESC "market scales") (ADJECTIVE MARKET) (SYNONYM SCALES SCALE PAN WEIGHTS)>
<OBJECT CLAPPER (DESC "brass clapper") (SYNONYM CLAPPER WEIGHT TONGUE) (ADJECTIVE BRASS)>
<OBJECT BELL (DESC "village bell") (SYNONYM BELL ROPE) (ADJECTIVE VILLAGE)>
<OBJECT ZSAJI (DESC "Zsaji") (SYNONYM ZSAJI HEALER)>

<ROUTINE MSG-MARKET-SCALES ()
 <COND (<NOT ,BW-WEIGHED> <TELL "One pan of the market scales hangs crooked. ">)
       (T <TELL "The market scales hang level. ">)>
 <TELL "The village lies west." CR>>
<ROUTINE MSG-FOUND-CLAPPER ()
 <TELL "You lift the crooked pan. A brass clapper rolls out from underneath, wobbling in smaller and smaller circles. Its worn loop is much too big for a grocer's weight." CR>>
<ROUTINE MSG-EMPTY-SCALES () <TELL "The pans hang level now. A single apple sends the needle bobbing." CR>>
<ROUTINE MSG-CLAPPER () <TELL "A loop at one end, a polished spot on either cheek. This little tongue has spent years swinging inside something." CR>>
<ROUTINE MSG-VILLAGE ()
 <TELL "Red dust sweeps through the village. Zsaji stands by a bell. The market is east." CR>>
<ROUTINE MSG-BELL ()
 <TELL "The bell hangs silent. Inside is an empty hook where its clapper should hang." CR>>
<ROUTINE MSG-BELL-FITTED () <TELL "The brass loop sits snug on the hook. The bell is ready for someone to pull its rope." CR>>
<ROUTINE MSG-ZSAJI ()
 <COND (,BW-BELL-RUNG <TELL "Zsaji shows you how to say welcome in her language. She makes room on the step. That part needs no translation." CR>)
       (T <TELL "Zsaji draws two shepherds in the dust. A faint whistle comes from the hill. She points to the bell: they're lost and need a sound to follow." CR>)>>
<ROUTINE MSG-HEALING () <TELL "Zsaji sees you rubbing the bruise from the skiff line. She offers her hand. Warmth slips under your sleeve and the ache eases. You regain 5 Health." CR>>
<ROUTINE MSG-ANSWERING-BELLS () <TELL "One pull sends a low note rolling out into the dust. Two high whistles answer. A pair of shepherds appear with their sleeves tied together so they can't lose each other. Zsaji ladles supper into both bowls." CR>>
<ROUTINE MSG-ALL-HOME () <TELL "The two shepherds tap their spoons against their empty bowls in time with the bell. Everyone is accounted for." CR>>
<ROUTINE MSG-VILLAGE-FAREWELL () <TELL "From the village, one low bell rings you safely through." CR>>
<ROUTINE BW-VILLAGE-CHOICES ()
 <COND (<==? ,HERE ,MARKET>
        <COND (<NOT ,BW-WEIGHED>
               <CHOICE "bw.market.scales" "See what's tipping the scales" "examine scales" ,CHOICE-INVESTIGATE 89>)>
        <CHOICE "bw.market.village" "Visit the healer's village" "west" ,CHOICE-INVESTIGATE 88>)
       (<==? ,HERE ,VILLAGE>
        <CHOICE "bw.village.healer" "Sit with Zsaji" "examine zsaji" ,CHOICE-INVESTIGATE 93>
        <COND (<IN? ,CLAPPER ,WINNER>
               <CHOICE "bw.village.fit" "Hook the clapper inside the bell" "put clapper in bell" ,CHOICE-PROGRESS 99>)
              (<AND <IN? ,CLAPPER ,BELL> <NOT ,BW-BELL-RUNG>>
               <CHOICE "bw.village.ring" "Ring the shepherds home" "pull bell" ,CHOICE-PROGRESS 100>)
              (T <CHOICE "bw.village.bell" "Inspect the meeting-house bell" "examine bell" ,CHOICE-INVESTIGATE 92>)>
        <CHOICE "bw.village.market" "Follow the lane to the market" "east" ,CHOICE-RETURN 90>)>
 <COND (<IN? ,CLAPPER ,HERE>
        <CHOICE "bw.clapper.take" "Pick up the brass clapper" "take clapper" ,CHOICE-INVESTIGATE 99>)>>
