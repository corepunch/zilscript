<ROUTINE SUGGEST-ACTIONS ()
 <COND
  (<EQUAL? ,HERE ,VESTIBULE>
   <CHOICE "vestibule.1" "Read why the hearing was called" "read auction notice" ,CHOICE-INVESTIGATE 99>
   <CHOICE "vestibule.urn" "Look into the coffee urn" "look in coffee urn" ,CHOICE-INVESTIGATE 98>
   <CHOICE "vestibule.2" "Enter the hearing" "north" ,CHOICE-INVESTIGATE 98>
   <CHOICE "vestibule.3" "Find the porter" "east" ,CHOICE-INVESTIGATE 97>)
  (<EQUAL? ,HERE ,CHAMBER>
   <CHOICE "chamber.1" "Hear the clerk" "examine clerk venn" ,CHOICE-INVESTIGATE 99>
   <CHOICE "chamber.2" "Inspect the evidence panel" "examine evidence panel" ,CHOICE-INVESTIGATE 98>
   <COND (<NOT ,CASE-READY> <CHOICE "chamber.3" "Try to reconstruct the loss" "spin evidence panel" ,CHOICE-INVESTIGATE 97>)>
   <COND (,CASE-READY <CHOICE "chamber.4" "Consider the finding against Ives" "examine ives tab" ,CHOICE-INVESTIGATE 96>)>
   <COND (,CASE-READY <CHOICE "chamber.5" "Consider the finding against Orr" "examine orr tab" ,CHOICE-INVESTIGATE 95>)>
   <COND (,CASE-READY <CHOICE "chamber.6" "Record a finding against Ives" "spin ives tab" ,CHOICE-INVESTIGATE 94>)>
   <COND (,CASE-READY <CHOICE "chamber.7" "Record a finding against Orr" "spin orr tab" ,CHOICE-INVESTIGATE 93>)>
   <CHOICE "chamber.8" "Go to the scale" "west" ,CHOICE-INVESTIGATE 92>
   <CHOICE "chamber.9" "Check the records" "east" ,CHOICE-INVESTIGATE 91>
   <CHOICE "chamber.10" "Get to the registry" "north" ,CHOICE-INVESTIGATE 90>
   <CHOICE "chamber.11" "Return to the vestibule" "south" ,CHOICE-INVESTIGATE 89>)
  (<EQUAL? ,HERE ,CLOAKROOM>
   <CHOICE "cloakroom.1" "Hear how Ives accounted for himself" "examine porter ives" ,CHOICE-INVESTIGATE 99>
   <CHOICE "cloakroom.coat" "Go through the pockets of Ives's coat" "search wet coat" ,CHOICE-INVESTIGATE 98>
   <CHOICE "cloakroom.2" "Go back to the vestibule" "west" ,CHOICE-INVESTIGATE 98>)
  (<EQUAL? ,HERE ,SCALEHOUSE>
   <CHOICE "scalehouse.1" "Study the scale" "examine weigh scale" ,CHOICE-INVESTIGATE 99>
   <CHOICE "scalehouse.2" "Check the clock" "examine wall clock" ,CHOICE-INVESTIGATE 98>
   <CHOICE "scalehouse.3" "Return to the hearing" "east" ,CHOICE-INVESTIGATE 97>)
  (<EQUAL? ,HERE ,RECORDS>
   <CHOICE "records.1" "Read the midnight ledger" "read midnight ledger" ,CHOICE-INVESTIGATE 99>
   <CHOICE "records.2" "Check which key was taken" "examine key cabinet" ,CHOICE-INVESTIGATE 98>
   <CHOICE "records.3" "Look at the crate" "north" ,CHOICE-INVESTIGATE 97>
   <CHOICE "records.4" "Return to the hearing" "west" ,CHOICE-INVESTIGATE 96>)
  (<EQUAL? ,HERE ,CAGE>
   <CHOICE "cage.1" "Study the seal" "examine syndicate seal" ,CHOICE-INVESTIGATE 99>
   <CHOICE "cage.2" "Inspect the crate" "examine transit crate" ,CHOICE-INVESTIGATE 98>
   <CHOICE "cage.lid" "Lift the crate's lid" "open transit crate" ,CHOICE-INVESTIGATE 97>
   <CHOICE "cage.3" "Return to the records" "south" ,CHOICE-INVESTIGATE 97>)
  (<EQUAL? ,HERE ,REGISTRY>
   <CHOICE "registry.1" "Check the signed register" "read shift register" ,CHOICE-INVESTIGATE 99>
   <CHOICE "registry.2" "Hear the assessor" "examine assessor orr" ,CHOICE-INVESTIGATE 98>
   <CHOICE "registry.smell" "Step close enough to catch Orr's scent" "smell assessor orr" ,CHOICE-INVESTIGATE 97>
   <CHOICE "registry.3" "Return to the hearing" "south" ,CHOICE-INVESTIGATE 97>)
 >>
