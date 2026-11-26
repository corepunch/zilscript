<ROUTINE SUGGEST-ACTIONS ()
 <COND
  (<EQUAL? ,HERE ,CAUSEWAY>
   <CHOICE "causeway.1" "Enter the tide-house" "north" ,CHOICE-INVESTIGATE 99>
   <COND (<IN? ,EKIT ,CAUSEWAY> <CHOICE "causeway.kit" "Speak to Kit" "examine younger kit" ,CHOICE-INTERACT 90>)>)
  (<EQUAL? ,HERE ,HALL>
   <COND (<IN? ,EKIT ,HALL> <CHOICE "hall.1" "Speak to Kit" "examine younger kit" ,CHOICE-INVESTIGATE 99>)>
   <CHOICE "hall.bench" "Sit for a moment on the waiting bench" "sit on bench" ,CHOICE-INTERACT 90>
   <CHOICE "hall.2" "Look in the kitchen" "west" ,CHOICE-INVESTIGATE 98>
   <CHOICE "hall.3" "Check the tally office" "east" ,CHOICE-INVESTIGATE 97>
   <CHOICE "hall.4" "Climb the stairs" "north" ,CHOICE-INVESTIGATE 96>
   <CHOICE "hall.5" "Step back out onto the causeway" "south" ,CHOICE-INVESTIGATE 95>)
  (<EQUAL? ,HERE ,KITCHEN>
   <CHOICE "kitchen.1" "Look at Kit's mug" "examine child mug" ,CHOICE-INVESTIGATE 99>
   <CHOICE "kitchen.range" "Open the cold iron range" "open iron range" ,CHOICE-INTERACT 90>
   <CHOICE "kitchen.2" "Return to the hall" "east" ,CHOICE-INVESTIGATE 98>)
  (<EQUAL? ,HERE ,OFFICE>
   <CHOICE "office.1" "Read the tally" "read old sheet" ,CHOICE-INVESTIGATE 99>
   <CHOICE "office.touch" "Run a finger along the struck-out line" "touch old sheet" ,CHOICE-INTERACT 90>
   <CHOICE "office.2" "Return to the hall" "west" ,CHOICE-INVESTIGATE 98>)
  (<EQUAL? ,HERE ,STAIRS>
   <CHOICE "stairs.1" "Read the signal instructions" "read signal plate" ,CHOICE-INVESTIGATE 99>
   <CHOICE "stairs.water" "Touch the water creeping up the wall" "touch water" ,CHOICE-INTERACT 90>
   <CHOICE "stairs.2" "Go up to the lantern" "up" ,CHOICE-INVESTIGATE 98>
   <CHOICE "stairs.3" "Back to the hall" "south" ,CHOICE-INVESTIGATE 97>)
  (<EQUAL? ,HERE ,LANTERN>
   <CHOICE "lantern.1" "Inspect the lens" "examine lens" ,CHOICE-INVESTIGATE 99>
   <COND (<NOT <FSET? ,ESHUT ,OPENBIT>> <CHOICE "lantern.2" "Open the seaward shutter" "open seaward shutter" ,CHOICE-INVESTIGATE 98>)>
   <COND (<NOT ,LENS-READY> <CHOICE "lantern.3" "Try a place on the lens" "spin signal lens" ,CHOICE-INVESTIGATE 97>)>
   <CHOICE "lantern.4" "Step out to the gallery" "east" ,CHOICE-INVESTIGATE 96>
   <CHOICE "lantern.5" "Go back down" "down" ,CHOICE-INVESTIGATE 95>)
  (<EQUAL? ,HERE ,GALLERY>
   <CHOICE "gallery.1" "Inspect the bell" "examine bell" ,CHOICE-INVESTIGATE 99>
   <COND (,LENS-READY <CHOICE "gallery.2" "Call the shore as witnesses" "ring witness bell" ,CHOICE-INVESTIGATE 98>)>
   <COND (,LENS-READY <CHOICE "gallery.3" "Pull the brake for a private vigil" "pull clapper brake" ,CHOICE-INVESTIGATE 97>)>
   <COND (<IN? ,EKIT ,GALLERY> <CHOICE "gallery.kit" "Speak to Kit before deciding" "examine younger kit" ,CHOICE-INTERACT 99>)>
   <COND (<NOT ,LENS-READY> <CHOICE "gallery.listen" "Listen to the bell in the wind" "listen to witness bell" ,CHOICE-INTERACT 90>)>
   <CHOICE "gallery.4" "Return to the lantern" "west" ,CHOICE-INVESTIGATE 96>)
 >>
