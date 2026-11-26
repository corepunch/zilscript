<ROUTINE SUGGEST-ACTIONS ()
 <COND (<EQUAL? ,HERE ,DISPATCH>
  <COND (<0? ,HERO-CLASS>
   <CHOICE "profile.bulwark" "W%ahle Fels" "waehle fels" ,CHOICE-INVESTIGATE 99>
   <CHOICE "profile.arc" "W%ahle Blitz" "waehle blitz" ,CHOICE-INVESTIGATE 98>
   <CHOICE "profile.lens" "W%ahle Luchs" "waehle luchs" ,CHOICE-INVESTIGATE 97>)
  (T <CHOICE "dispatch.go" "Zur Br%ucke gehen" "nord" ,CHOICE-INVESTIGATE 99>)>)
 (<EQUAL? ,HERE ,BRIDGE>
  <COND (,RESCUED <CHOICE "bridge.go" "In die Relaisstation gehen" "ost" ,CHOICE-INVESTIGATE 99>)
  (T <CHOICE "bridge.rescue" "Die Fahrg%aste retten" "rette bahn" ,CHOICE-INVESTIGATE 99>)>
  <CHOICE "bridge.back" "Zur%uck zur Leitstelle" "sued" ,CHOICE-INVESTIGATE 80>)
 (<EQUAL? ,HERE ,RELAY>
  <COND (<NOT ,DISABLED> <CHOICE "relay.strike" "Die Drohne angreifen" "schlag drohne" ,CHOICE-INVESTIGATE 99>)>
  <CHOICE "relay.bypass" "Den Umgehungshebel umlegen" "deaktiviere pult" ,CHOICE-INVESTIGATE 98>
  <COND (<AND <NOT ,BOOSTED> <L? ,HERO-HEALTH ,HERO-MAX-HEALTH>> <CHOICE "relay.kit" "Den Notfallkasten benutzen" "benutze kasten" ,CHOICE-INVESTIGATE 95>)>
  <CHOICE "relay.back" "Zur%uck zur Br%ucke" "west" ,CHOICE-INVESTIGATE 80>)>
 <COND (<NOT <0? ,HERO-CLASS>> <CHOICE "hero.sheet" "Heldenbogen lesen" "lies bogen" ,CHOICE-INVESTIGATE 90>)>>
