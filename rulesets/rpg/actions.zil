;"Standard RPG actions and replies: the check report, the action verbs and
  synonyms, the naming prompt, and the replies when no object takes an
  action. A story's objects answer the actions in their ACTION routines."

<ROUTINE OF-WORD () <TELL " of ">>
<ROUTINE NAME-PROMPT () <TELL "Type your hero name (up to 32 plain letters, digits or punctuation)." CR>>

<SYNTAX STRIKE OBJECT = V-RPG-ATTACK>
<SYNTAX STRIKE OBJECT WITH OBJECT = V-RPG-ATTACK>
<SYNONYM STRIKE ATTACK HIT PUNCH FIGHT KILL>
;"The base reads DESTROY (break, smash) only as Zork's DESTROY IN; a hero
  who breaks something strikes it."
<SYNTAX DESTROY OBJECT = V-RPG-ATTACK>
<SYNTAX RESCUE OBJECT = V-RPG-RESCUE>
<SYNTAX DISABLE OBJECT = V-RPG-DISABLE>
<SYNONYM DISABLE BYPASS HACK>
<SYNTAX CHOOSE OBJECT = V-RPG-CHOOSE>
<SYNONYM CHOOSE SELECT>
<SYNTAX FOCUS OBJECT = V-RPG-POWER>

<SYNTAX NAME OBJECT = V-RPG-NAME>
<SYNTAX DIAGNOSE = V-RPG-DIAGNOSE>
<SYNONYM DIAGNOSE HEALTH>

<ROUTINE STATUS-PROFILE () <TELL "Profile: ">>

<ROUTINE SAY-NO-TARGET () <TELL "That is not a target." CR>>
<ROUTINE SAY-NO-RESCUE () <TELL "Nobody needs rescuing there." CR>>
<ROUTINE SAY-NO-CONTROL () <TELL "That is not a control system." CR>>
<ROUTINE SAY-NO-PROFILE () <TELL "That is not a profile." CR>>
<ROUTINE SAY-NO-POWER () <TELL "That does not help." CR>>
<ROUTINE SAY-NO-NAME () <TELL "That has no name to give." CR>>
<ROUTINE SAY-NO-STATUS () <TELL "You have no ranks yet, so there is no Health or Karma to count." CR>>
<ROUTINE SAY-NO-CHARACTER () <TELL "Choose a character first." CR>>
