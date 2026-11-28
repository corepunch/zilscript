<INSERT-FILE "languages.ru.base">
<INSERT-FILE "rulesets.rpg.kernel">
<INSERT-FILE "rulesets.rpg.ru">
<INSERT-FILE "rulesets.superhero.system">

<ROUTINE ATTR-NAME (ATTR)
 <COND (<==? .ATTR ,A-FIGHTING> <TELL "Бой">)
       (<==? .ATTR ,A-AGILITY> <TELL "Ловкость">)
       (<==? .ATTR ,A-STRENGTH> <TELL "Сила">)
       (<==? .ATTR ,A-ENDURANCE> <TELL "Выносливость">)
       (<==? .ATTR ,A-REASON> <TELL "Разум">)
       (<==? .ATTR ,A-INTUITION> <TELL "Интуиция">)
       (<==? .ATTR ,A-PSYCHE> <TELL "Воля">)
       (<==? .ATTR ,A-POWER> <TELL "Способности">)
       (<==? .ATTR ,A-HEALTH> <TELL "Здоровье">)
       (T <TELL "Карма">)>>

<ROUTINE TIER-NAME (TIER)
 <COND (<==? .TIER 0> <TELL "провал">)
       (<==? .TIER 1> <TELL "успех">)
       (<==? .TIER 2> <TELL "значительный успех">)
       (T <TELL "исключительный успех">)>>

<ROUTINE CHECK-TERMS (TBL ATTR DIFFICULTY)
 <TELL "Ранг " N <STAT .TBL .ATTR> "; бросок d100">>
