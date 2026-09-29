<INSERT-FILE "books/blackwood-horror/blackwood-horror">

<GLOBAL CO <CO-CREATE GO>>

;"What is written on a thing, or shut inside one, is learned by examining it
  (Zork I prints the leaflet only when it is read, and lists the mailbox's
  contents only once it is open). GO BACK retraces the last step."

<ROUTINE RUN-TEST ()
    <ASSERT "Start at Sanitarium Gate" <CO-RESUME ,CO "look" T> <==? ,HERE ,SANITARIUM-GATE>>
    <ASSERT-TEXT "retrace" <CO-RESUME ,CO "go back">>
    <ASSERT "A refused GO BACK leaves the player in place" <==? ,HERE ,SANITARIUM-GATE>>
    <ASSERT-NOT-TEXT "[[" <CO-RESUME ,CO "look">>
    <ASSERT "Enter the entrance hall" <CO-RESUME ,CO "north" T> <==? ,HERE ,SANITARIUM-ENTRANCE>>
    <ASSERT "GO BACK returns to the gate" <CO-RESUME ,CO "go back" T> <==? ,HERE ,SANITARIUM-GATE>>
    <ASSERT "GO BACK again returns to the hall" <CO-RESUME ,CO "walk back" T> <==? ,HERE ,SANITARIUM-ENTRANCE>>

    <ASSERT "Go to Operating Theater" <CO-RESUME ,CO "north" T> <==? ,HERE ,OPERATING-THEATER>>
    <ASSERT-TEXT "slightly ajar" <CO-RESUME ,CO "look">>
    <ASSERT-NOT-TEXT "scalpel" <CO-RESUME ,CO "look">>
    <ASSERT-NOT-TEXT "contains" <CO-RESUME ,CO "look">>
    <ASSERT "The scalpel cannot be taken unseen" <CO-RESUME ,CO "take scalpel" T> <==? <LOC ,SCALPEL> ,METAL-CABINET>>
    <ASSERT-TEXT "scalpel" <CO-RESUME ,CO "examine cabinet">>
    <ASSERT "Examining the cabinet opens it" <FSET? ,METAL-CABINET ,OPENBIT>>
    <ASSERT-TEXT "rusty scalpel" <CO-RESUME ,CO "look">>
    <ASSERT "Take scalpel" <CO-RESUME ,CO "take scalpel" T> <==? <LOC ,SCALPEL> ,ADVENTURER>>
    <ASSERT-TEXT "slightly ajar" <CO-RESUME ,CO "close cabinet">>
    <ASSERT-NOT-TEXT "ether" <CO-RESUME ,CO "look">>
    <ASSERT-TEXT "bottle" <CO-RESUME ,CO "open cabinet">>

    <ASSERT "Back to the hall" <CO-RESUME ,CO "back" T> <==? ,HERE ,SANITARIUM-ENTRANCE>>
    <ASSERT "Go to Patient Ward" <CO-RESUME ,CO "east" T> <==? ,HERE ,PATIENT-WARD>>
    <ASSERT-TEXT "crayon drawing" <CO-RESUME ,CO "look">>
    <ASSERT-NOT-TEXT "HOME" <CO-RESUME ,CO "look">>
    <ASSERT-TEXT "HOME" <CO-RESUME ,CO "examine drawing">>

    ;"The brass key lies under the reception papers: the room hints at a glint,
      and only searching them shows the key."
    <ASSERT "Back to the hall" <CO-RESUME ,CO "west" T> <==? ,HERE ,SANITARIUM-ENTRANCE>>
    <ASSERT "Go to Reception" <CO-RESUME ,CO "west" T> <==? ,HERE ,RECEPTION-ROOM>>
    <ASSERT-TEXT "glints" <CO-RESUME ,CO "look">>
    <ASSERT-NOT-TEXT "brass key" <CO-RESUME ,CO "look">>
    <ASSERT "The key cannot be taken unseen" <CO-RESUME ,CO "take key" T> <N==? <LOC ,BRASS-KEY> ,ADVENTURER>>
    <ASSERT-TEXT "brass key" <CO-RESUME ,CO "examine papers">>
    <ASSERT-TEXT "brass key" <CO-RESUME ,CO "look">>
    <ASSERT-NOT-TEXT "glints" <CO-RESUME ,CO "look">>
    <ASSERT "Take the found key" <CO-RESUME ,CO "take key" T> <==? <LOC ,BRASS-KEY> ,ADVENTURER>>

    ;"Containers keep what lies in them until examined: the morgue drawer, the
      coal bin, the storage shelves and the doctor's bag, the hydrotherapy
      tubs and the staff lockers."
    <MOVE ,WINNER ,MORGUE> <SETG HERE ,MORGUE>
    <ASSERT-TEXT "faint glow" <CO-RESUME ,CO "look">>
    <ASSERT-NOT-TEXT "vial" <CO-RESUME ,CO "look">>
    <ASSERT-TEXT "vial" <CO-RESUME ,CO "examine drawers">>
    <ASSERT-TEXT "vial" <CO-RESUME ,CO "look">>

    <MOVE ,WINNER ,BOILER-ROOM> <SETG HERE ,BOILER-ROOM>
    <ASSERT-NOT-TEXT "lump" <CO-RESUME ,CO "look">>
    <ASSERT-NOT-TEXT "flashlight" <CO-RESUME ,CO "look">>
    <ASSERT-TEXT "shovel" <CO-RESUME ,CO "examine boiler">>
    <ASSERT-TEXT "lump of coal" <CO-RESUME ,CO "examine bin">>
    <ASSERT-TEXT "flashlight" <CO-RESUME ,CO "examine workbench">>

    <MOVE ,WINNER ,STORAGE-ROOM> <SETG HERE ,STORAGE-ROOM>
    <ASSERT-NOT-TEXT "lantern" <CO-RESUME ,CO "look">>
    <ASSERT-TEXT "medical bag" <CO-RESUME ,CO "search shelves">>
    <ASSERT-NOT-TEXT "morphine" <CO-RESUME ,CO "look">>
    <ASSERT-TEXT "morphine" <CO-RESUME ,CO "open bag">>

    ;"The lower wing is dark; carry the lit lantern."
    <MOVE ,OIL-LANTERN ,WINNER> <FSET ,OIL-LANTERN ,ONBIT> <SETG LANTERN-LIT-FLAG T>
    <MOVE ,WINNER ,HYDROTHERAPY-ROOM> <SETG HERE ,HYDROTHERAPY-ROOM>
    <ASSERT-NOT-TEXT "notebook" <CO-RESUME ,CO "look">>
    <ASSERT-TEXT "notebook" <CO-RESUME ,CO "examine tubs">>

    <MOVE ,WINNER ,STAFF-QUARTERS> <SETG HERE ,STAFF-QUARTERS>
    <ASSERT-NOT-TEXT "photograph" <CO-RESUME ,CO "look">>
    <ASSERT-TEXT "photograph" <CO-RESUME ,CO "examine lockers">>

    ;"The wall safe hides behind the portrait until the portrait is looked at."
    <MOVE ,WINNER ,DIRECTORS-OFFICE> <SETG HERE ,DIRECTORS-OFFICE>
    <ASSERT-NOT-TEXT "safe" <CO-RESUME ,CO "look">>
    <ASSERT-TEXT "wall safe" <CO-RESUME ,CO "examine portrait">>
    <ASSERT-TEXT "wall safe" <CO-RESUME ,CO "look">>>
