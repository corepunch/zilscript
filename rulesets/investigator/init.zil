<INSERT-FILE "world.base">
<INSERT-FILE "rulesets.rpg.kernel">
<INSERT-FILE "rulesets.rpg.actions">
<INSERT-FILE "rulesets.investigator.system">

<ROUTINE ATTR-NAME (ATTR)
 <COND (<==? .ATTR ,A-MEDICINE> <TELL "Medicine">)
       (<==? .ATTR ,A-INTERVIEW> <TELL "Interview">)
       (<==? .ATTR ,A-REPAIR> <TELL "Repair">)
       (<==? .ATTR ,A-COMPOSURE> <TELL "Composure">)>>

<ROUTINE TIER-NAME (TIER)
 <COND (<0? .TIER> <TELL "failure">) (T <TELL "success">)>>

<ROUTINE CHECK-TERMS (TBL ATTR DIFFICULTY)
 <TELL "d100; need " N <INV-TARGET <STAT .TBL .ATTR> .DIFFICULTY> " or less; rolled">>

<ROUTINE INVESTIGATOR-SHEET-ROW (TBL ATTR)
 <ATTR-NAME .ATTR>
 <SHEET-ROW <TAKE-OUTPUT> <STAT .TBL .ATTR>
  <COND (<==? .ATTR ,A-COMPOSURE> <MAX-STAT .TBL .ATTR>) (T 0)>
  <COND (<==? .ATTR ,A-COMPOSURE> "resources") (T "abilities")>>>

<SETG RPG-PRESET-ROW ,INVESTIGATOR-SHEET-ROW>
