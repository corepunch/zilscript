;"Superhero rules in German over the German base, without Zork's classic
  rules: the RPG kernel with its German words, the superhero system's
  numbers and, below, its German names. The story inserts languages.de.init
  (messages, TELL tokens and vocabulary) before its objects and this file
  after them."
<INSERT-FILE "languages.de.base">
<INSERT-FILE "rulesets.rpg.kernel">
<INSERT-FILE "rulesets.rpg.de">
<INSERT-FILE "rulesets.superhero.system">

<ROUTINE ATTR-NAME (ATTR)
 <COND (<==? .ATTR ,A-FIGHTING> <TELL "Kampf">)
       (<==? .ATTR ,A-AGILITY> <TELL "Gewandtheit">)
       (<==? .ATTR ,A-STRENGTH> <TELL "St%arke">)
       (<==? .ATTR ,A-ENDURANCE> <TELL "Ausdauer">)
       (<==? .ATTR ,A-REASON> <TELL "Verstand">)
       (<==? .ATTR ,A-INTUITION> <TELL "Intuition">)
       (<==? .ATTR ,A-PSYCHE> <TELL "Psyche">)
       (<==? .ATTR ,A-POWER> <TELL "Kraft">)
       (<==? .ATTR ,A-HEALTH> <TELL "Gesundheit">)
       (T <TELL "Karma">)>>

<ROUTINE TIER-NAME (TIER)
 <COND (<==? .TIER 0> <TELL "Fehlschlag">)
       (<==? .TIER 1> <TELL "Erfolg">)
       (<==? .TIER 2> <TELL "starker Erfolg">)
       (T <TELL "au%serordentlicher Erfolg">)>>

<ROUTINE CHECK-TERMS (TBL ATTR DIFFICULTY)
 <TELL "Rang " N <STAT .TBL .ATTR> "; W100">>
