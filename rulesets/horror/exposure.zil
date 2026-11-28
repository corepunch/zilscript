;"Escalating cold exposure, inspired by The Lurking Horror's blizzard.
   Call once per exposure tick. The book owns the clock schedule and supplies
   an LTABLE of (turn, text) tables, a fatal threshold and localized prose.
   Return true only for player-visible events so WAIT can continue on quiet ticks."
<GLOBAL COLD-EXPOSURE 0>

<ROUTINE HORROR-COLD-TURN (EXPOSED? WARNINGS FATAL-AT FATAL-TEXT
                         "OPTIONAL" (RECOVERY <>) "AUX" (INDEX 1) WARNING)
    <COND (<NOT .EXPOSED?>
           <COND (<AND .RECOVERY <G? ,COLD-EXPOSURE 0>>
                  <SETG COLD-EXPOSURE 0>
                  <TELL .RECOVERY CR>
                  <RTRUE>)>
           <SETG COLD-EXPOSURE 0>
           <RFALSE>)>
    <SETG COLD-EXPOSURE <+ ,COLD-EXPOSURE 1>>
    <COND (<NOT <L? ,COLD-EXPOSURE .FATAL-AT>>
           <JIGS-UP .FATAL-TEXT>
           <RTRUE>)>
    <REPEAT ()
        <COND (<G? .INDEX <GET .WARNINGS 0>> <RFALSE>)>
        <SET WARNING <GET .WARNINGS .INDEX>>
        <COND (<EQUAL? ,COLD-EXPOSURE <GET .WARNING 0>>
               <TELL <GET .WARNING 1> CR>
               <RTRUE>)>
        <SET INDEX <+ .INDEX 1>>>>
