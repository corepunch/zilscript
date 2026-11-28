;"Superhero rules in English over the English base, without Zork's classic
  rules: the RPG kernel with its English words, the superhero system's
  numbers and, below, its English names."
<INSERT-FILE "languages.en.base">
<INSERT-FILE "rulesets.rpg.kernel">
<INSERT-FILE "rulesets.rpg.en">
<INSERT-FILE "rulesets.superhero.system">

<ROUTINE ATTR-NAME (ATTR)
 <COND (<==? .ATTR ,A-FIGHTING> <TELL "Fighting">)
       (<==? .ATTR ,A-AGILITY> <TELL "Agility">)
       (<==? .ATTR ,A-STRENGTH> <TELL "Strength">)
       (<==? .ATTR ,A-ENDURANCE> <TELL "Endurance">)
       (<==? .ATTR ,A-REASON> <TELL "Reason">)
       (<==? .ATTR ,A-INTUITION> <TELL "Intuition">)
       (<==? .ATTR ,A-PSYCHE> <TELL "Psyche">)
       (<==? .ATTR ,A-POWER> <TELL "Power">)
       (<==? .ATTR ,A-HEALTH> <TELL "Health">)
       (T <TELL "Karma">)>>

<ROUTINE TIER-NAME (TIER)
 <COND (<==? .TIER 0> <TELL "failure">)
       (<==? .TIER 1> <TELL "success">)
       (<==? .TIER 2> <TELL "strong success">)
       (T <TELL "exceptional success">)>>

<ROUTINE CHECK-TERMS (TBL ATTR DIFFICULTY)
 <TELL "Rank " N <STAT .TBL .ATTR> "; d100">>
