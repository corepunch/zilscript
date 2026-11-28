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

<GLOBAL FASERIP-RANK-NAMES <TABLE
 "Shift 0" "Feeble" "Poor" "Typical" "Good" "Excellent"
 "Remarkable" "Incredible" "Amazing" "Monstrous" "Unearthly" "Shift X"
 "Shift Y" "Shift Z" "Class 1000" "Class 3000" "Class 5000" "Beyond">>

<ROUTINE FASERIP-CHALLENGE (INTENSITY REQUIRED)
 <TELL "Challenge " N .INTENSITY "; needs ">
 <TIER-NAME .REQUIRED>
 <TELL "." CR>>

<ROUTINE REPORT-FEAT (TBL ATTR INTENSITY SHIFT REQUIRED RAW SPENT TOTAL TIER)
 <REPORT-CHECK .TBL .ATTR .INTENSITY .TOTAL .TIER>
 <FASERIP-CHALLENGE .INTENSITY .REQUIRED>
 <COND (<NOT <0? .SHIFT>> <TELL "Effective rank " N ,LAST-FEAT-RANK "." CR>)>
 <COND (<NOT <0? .SPENT>>
        <TELL "Raw d100 " N .RAW " + Karma " N .SPENT " = " N .TOTAL "." CR>)>>

<ROUTINE REPORT-FEAT-GATE (REQUIRED)
 <COND (<0? .REQUIRED> <TELL "The feat succeeds without a roll." CR>)
       (T <TELL "This feat is out of reach without another approach." CR>)>>
