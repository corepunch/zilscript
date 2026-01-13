<DIRECTIONS NORTH SOUTH>
<CONSTANT RELEASEID 1>

<ROOM STARTROOM
      (IN ROOMS)
      (DESC "Start Room")
      (LDESC "A dark test room.")>

<OBJECT FLASHLIGHT
        (IN PLAYER)
        (SYNONYM FLASHLIGHT LIGHT TORCH)
        (DESC "flashlight")
        (FLAGS TAKEBIT)
        (ACTION FLASHLIGHT-F)>

<ROUTINE FLASHLIGHT-F ()
    <COND (<VERB? TURN-ON LAMP-ON>
           <FSET ,FLASHLIGHT ,LIGHTBIT>
           <FSET ,FLASHLIGHT ,ONBIT>
           <TELL "The flashlight is now on." CR>
           <NOW-LIT?>
           <RTRUE>)
          (<VERB? TURN-OFF LAMP-OFF>
           <FCLEAR ,FLASHLIGHT ,LIGHTBIT>
           <FCLEAR ,FLASHLIGHT ,ONBIT>
           <TELL "The flashlight is now off." CR>
           <NOW-DARK?>
           <RTRUE>)>>

<OBJECT LANTERN
        (IN STARTROOM)
        (SYNONYM LANTERN LAMP)
        (DESC "lantern")
        (FLAGS TAKEBIT)
        (ACTION LANTERN-F)>

<ROUTINE LANTERN-F ()
    <COND (<VERB? TURN-ON LAMP-ON>
           <FSET ,LANTERN ,LIGHTBIT>
           <FSET ,LANTERN ,ONBIT>
           <TELL "The lantern is now lit." CR>
           <NOW-LIT?>
           <RTRUE>)
          (<VERB? TURN-OFF LAMP-OFF>
           <FCLEAR ,LANTERN ,LIGHTBIT>
           <FCLEAR ,LANTERN ,ONBIT>
           <TELL "The lantern is now dark." CR>
           <NOW-DARK?>
           <RTRUE>)>>

<ROUTINE GO ()
    <SETG HERE ,STARTROOM>
    <SETG WINNER ,ADVENTURER>
    <SETG PLAYER ,WINNER>
    <MOVE ,WINNER ,HERE>
    <FCLEAR ,FLASHLIGHT ,LIGHTBIT>
    <FCLEAR ,FLASHLIGHT ,ONBIT>
    <FCLEAR ,LANTERN ,LIGHTBIT>
    <FCLEAR ,LANTERN ,ONBIT>
    <V-LOOK>
    <MAIN-LOOP>
    <AGAIN>>
