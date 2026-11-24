<ROUTINE C-MOVE (ID LABEL CMD)
 <CHOICE .ID .LABEL .CMD ,CHOICE-RETURN 65> <CHOICE-DETAILS "group" "move">>
<ROUTINE SUGGEST-ACTIONS ()
 <COND (<EQUAL? ,HERE ,LENDING>
        <CHOICE "hall.inspect" "Inspect the lending cabinet" "examine lending cabinet" ,CHOICE-INVESTIGATE 72>
        <COND (<NOT <FSET? ,CASE ,OPENBIT>>
               <CHOICE "hall.open" "Open the lending cabinet" "open lending cabinet" ,CHOICE-PROGRESS 95>)
              (<IN? ,LEAF ,CASE>
               <CHOICE "hall.borrow" "Borrow the last page of tomorrow" "take tomorrow leaf" ,CHOICE-PROGRESS 96>)
              (<HELD? ,LEAF>
               <CHOICE "hall.return" "Return the page to the cabinet" "put tomorrow leaf in lending cabinet" ,CHOICE-EXPERIMENT 38>)>
        <C-MOVE "hall.basin" "Go to the stone basin" "north">
        <C-MOVE "hall.folding" "Go to the folding room" "east">)
       (<EQUAL? ,HERE ,BASIN>
        <CHOICE "basin.receipt" "Read the old receipt" "read loan receipt" ,CHOICE-INVESTIGATE 95>
        <CHOICE "basin.listen" "Listen to the stone trough" "listen to stone trough" ,CHOICE-INTERACT 43>
        <C-MOVE "basin.hall" "Return to the lending hall" "south">
        <C-MOVE "basin.terrace" "Go to the reading terrace" "east">)
       (<EQUAL? ,HERE ,FOLDING>
        <CHOICE "folding.guide" "Find out what the folding board is for" "read folding board" ,CHOICE-INVESTIGATE 93>
        <COND (<AND ,BOARD-READ <HELD? ,LEAF> <NOT ,WIDE-LOAN>>
               <CHOICE "folding.widen" "Open the old folds on the board" "put tomorrow leaf on folding board" ,CHOICE-PROGRESS 96>)>
        <C-MOVE "folding.hall" "Return to the lending hall" "west">
        <C-MOVE "folding.terrace" "Go up to the reading terrace" "north">)
       (<EQUAL? ,HERE ,TERRACE>
        <CHOICE "terrace.inspect" "Look closely at the reading frame" "examine reading frame" ,CHOICE-INVESTIGATE 73>
        <COND (<AND <HELD? ,LEAF> <OR ,WIDE-LOAN ,RECEIPT-READ>>
               <CHOICE "terrace.fit" "Try the page in the frame" "put tomorrow leaf in reading frame" ,CHOICE-PROGRESS 96>)
              (<IN? ,LEAF ,FRAME>
               <CHOICE "terrace.read" "Read from the frame to the market" "read reading frame" ,CHOICE-PROGRESS 97>
               <CHOICE "terrace.unfit" "Lift the page out of the frame" "take tomorrow leaf" ,CHOICE-EXPERIMENT 35>)>
        <C-MOVE "terrace.folding" "Go down to the folding room" "south">
        <C-MOVE "terrace.basin" "Go to the stone basin" "west">)>
 <COND (<IN? ,LEAF ,HERE>
        <CHOICE "recover.leaf" "Pick the page back up" "take tomorrow leaf" ,CHOICE-PROGRESS 91>)
       (<HELD? ,LEAF>
        <CHOICE "leaf.inspect" "Look at the page you are carrying" "examine tomorrow leaf" ,CHOICE-INVESTIGATE 44>)>>
