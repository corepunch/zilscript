;"English words for the superhero rules: the check report, the character
  sheet, and the hero actions with their replies when nothing in the story
  takes the action. A story's objects answer them in their ACTION routines."

<ROUTINE HERO-REPORT-CHECK (RANK ROLL TIER)
 <TELL "Rank " N .RANK "; d100 " N .ROLL "; ">
 <COND (<==? .TIER 0> <TELL "failure.">)
       (<==? .TIER 1> <TELL "success.">)
       (<==? .TIER 2> <TELL "strong success.">)
       (T <TELL "exceptional success.">)>
 <CRLF>>

<ROUTINE HERO-SHEET ()
 <TELL "Fighting: " N ,HERO-FIGHTING ", Agility: " N ,HERO-AGILITY CR>
 <TELL "Strength: " N ,HERO-STRENGTH ", Endurance: " N ,HERO-ENDURANCE CR>
 <TELL "Reason: " N ,HERO-REASON ", Intuition: " N ,HERO-INTUITION CR>
 <TELL "Psyche: " N ,HERO-PSYCHE ", Power: " N ,HERO-POWER CR>
 <TELL "Health: " N ,HERO-HEALTH "/" N ,HERO-MAX-HEALTH ", Karma: " N ,HERO-KARMA CR>>

<SYNTAX STRIKE OBJECT = V-HERO-STRIKE>
<SYNONYM STRIKE ATTACK HIT PUNCH FIGHT KILL>
<SYNTAX RESCUE OBJECT = V-HERO-RESCUE>
<SYNTAX DISABLE OBJECT = V-HERO-DISABLE>
<SYNONYM DISABLE BYPASS HACK>
<SYNTAX CHOOSE OBJECT = V-HERO-CHOOSE>
<SYNONYM CHOOSE SELECT>
<SYNTAX FOCUS OBJECT = V-HERO-FOCUS>

<SYNTAX NAME OBJECT = V-HERO-NAME>
<SYNTAX DIAGNOSE = V-HERO-DIAGNOSE>
<SYNONYM DIAGNOSE HEALTH>

<ROUTINE V-HERO-STRIKE () <TELL "That is not a target." CR>>
<ROUTINE V-HERO-RESCUE () <TELL "Nobody needs rescuing there." CR>>
<ROUTINE V-HERO-DISABLE () <TELL "That is not a control system." CR>>
<ROUTINE V-HERO-CHOOSE () <TELL "That is not a profile." CR>>
<ROUTINE V-HERO-FOCUS () <TELL "That does not help." CR>>
<ROUTINE V-HERO-NAME () <TELL "That has no name to give." CR>>
<ROUTINE V-HERO-DIAGNOSE ()
 <TELL "Health " N ,HERO-HEALTH " of " N ,HERO-MAX-HEALTH ", Karma " N ,HERO-KARMA "." CR>>
