<ROUTINE C-MOVE (ID LABEL CMD)
 <CHOICE .ID .LABEL .CMD ,CHOICE-RETURN 65> <CHOICE-DETAILS "group" "move">>
<ROUTINE SUGGEST-ACTIONS ()
 <COND (<EQUAL? ,HERE ,LENDING>
        <CHOICE "hall.inspect" "Den Leihschrank untersuchen" "untersuche leihschrank" ,CHOICE-INVESTIGATE 72>
        <COND (<NOT <FSET? ,CASE ,OPENBIT>>
               <CHOICE "hall.open" "Den Leihschrank öffnen" "öffne leihschrank" ,CHOICE-PROGRESS 95>)
              (<IN? ,LEAF ,CASE>
               <CHOICE "hall.borrow" "Das letzte Blatt von morgen ausleihen" "nimm morgenblatt" ,CHOICE-PROGRESS 96>)
              (<HELD? ,LEAF>
               <CHOICE "hall.return" "Das Blatt in den Schrank zurücklegen" "lege morgenblatt in leihschrank" ,CHOICE-EXPERIMENT 38>)>
        <CHOICE "hall.knock" "Vorsichtig am Schrank klopfen" "klopf an leihschrank" ,CHOICE-INTERACT 39>
        <C-MOVE "hall.basin" "Zur trockenen Kammer gehen" "nord">
        <C-MOVE "hall.folding" "In den Faltraum gehen" "ost">)
       (<EQUAL? ,HERE ,BASIN>
        <CHOICE "basin.receipt" "Den alten Leihschein lesen" "lies leihschein" ,CHOICE-INVESTIGATE 95>
        <CHOICE "basin.listen" "Der Steinrinne lauschen" "horch an steinrinne" ,CHOICE-INTERACT 43>
        <CHOICE "basin.sip" "Einen Schluck aus der Rinne versuchen" "trink aus steinrinne" ,CHOICE-EXPERIMENT 38>
        <C-MOVE "basin.hall" "Zurück in die Ausleihhalle gehen" "sued">
        <C-MOVE "basin.terrace" "Zur Leseterrasse gehen" "ost">)
       (<EQUAL? ,HERE ,FOLDING>
        <CHOICE "folding.guide" "Herausfinden, wozu das Faltbrett dient" "lies faltbrett" ,CHOICE-INVESTIGATE 93>
        <COND (<AND ,BOARD-READ <HELD? ,LEAF> <NOT ,WIDE-LOAN>>
               <CHOICE "folding.widen" "Die alten Falten auf dem Brett glätten" "lege morgenblatt auf faltbrett" ,CHOICE-PROGRESS 96>)>
        <COND (<AND ,WIDE-LOAN <HELD? ,LEAF>>
               <CHOICE "folding.refold" "Das Blatt wieder klein falten" "falte morgenblatt" ,CHOICE-EXPERIMENT 39>)>
        <C-MOVE "folding.hall" "Zurück in die Ausleihhalle gehen" "west">
        <C-MOVE "folding.terrace" "Zur Leseterrasse hinaufgehen" "nord">)
       (<EQUAL? ,HERE ,TERRACE>
        <CHOICE "terrace.inspect" "Den Leserahmen genauer ansehen" "untersuche leserahmen" ,CHOICE-INVESTIGATE 73>
        <COND (<AND <HELD? ,LEAF> <OR ,WIDE-LOAN ,RECEIPT-READ>>
               <CHOICE "terrace.fit" "Das Blatt in den Rahmen spannen" "lege morgenblatt in leserahmen" ,CHOICE-PROGRESS 96>)
              (<IN? ,LEAF ,FRAME>
               <CHOICE "terrace.read" "Dem Markt vom Rahmen aus vorlesen" "lies leserahmen" ,CHOICE-PROGRESS 97>
               <CHOICE "terrace.unfit" "Das Blatt aus dem Rahmen nehmen" "nimm morgenblatt" ,CHOICE-EXPERIMENT 35>)>
        <C-MOVE "terrace.folding" "In den Faltraum hinuntergehen" "sued">
        <C-MOVE "terrace.basin" "Zur trockenen Kammer gehen" "west">)>
 <COND (<IN? ,LEAF ,HERE>
        <CHOICE "recover.leaf" "Das Blatt wieder aufheben" "nimm morgenblatt" ,CHOICE-PROGRESS 91>)
       (<HELD? ,LEAF>
        <CHOICE "leaf.inspect" "Das Blatt in deiner Hand ansehen" "untersuche morgenblatt" ,CHOICE-INVESTIGATE 44>)>>
