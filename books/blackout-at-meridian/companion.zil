<ROUTINE SUGGEST-ACTIONS ()
 <COND (<EQUAL? ,HERE ,DISPATCH>
  <COND (<0? ,HERO-CLASS>
   <CHOICE "profile.bulwark" "Choose Bulwark" "choose bulwark" ,CHOICE-INVESTIGATE 99>
   <CHOICE "profile.arc" "Choose Arc" "choose arc" ,CHOICE-INVESTIGATE 98>
   <CHOICE "profile.lens" "Choose Lens" "choose lens" ,CHOICE-INVESTIGATE 97>)
  (T <CHOICE "dispatch.go" "Go to the bridge" "north" ,CHOICE-INVESTIGATE 99>)>)
 (<EQUAL? ,HERE ,BRIDGE>
  <COND (,RESCUED <CHOICE "bridge.go" "Enter the relay" "east" ,CHOICE-INVESTIGATE 99>)
  (T <CHOICE "bridge.rescue" "Rescue the passengers" "rescue tram" ,CHOICE-INVESTIGATE 99>)>
  <CHOICE "bridge.back" "Return to dispatch" "south" ,CHOICE-INVESTIGATE 80>)
 (<EQUAL? ,HERE ,RELAY>
  <COND (<NOT ,DISABLED> <CHOICE "relay.strike" "Strike the drone" "strike drone" ,CHOICE-INVESTIGATE 99>)>
  <CHOICE "relay.bypass" "Disable the relay" "disable console" ,CHOICE-INVESTIGATE 98>
  <COND (<NOT ,BOOSTED> <CHOICE "relay.kit" "Use the recovery kit" "focus kit" ,CHOICE-INVESTIGATE 95>)>
  <CHOICE "relay.back" "Return to the bridge" "west" ,CHOICE-INVESTIGATE 80>)>
 <COND (<NOT <0? ,HERO-CLASS>> <CHOICE "hero.sheet" "Read character sheet" "read sheet" ,CHOICE-INVESTIGATE 90>)>>
