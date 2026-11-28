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

<GLOBAL FASERIP-RANK-NAMES <TABLE
 "Нулевой" "Слабый" "Низкий" "Обычный" "Хороший" "Отличный"
 "Выдающийся" "Невероятный" "Поразительный" "Чудовищный" "Неземной" "Ступень X"
 "Ступень Y" "Ступень Z" "Класс 1000" "Класс 3000" "Класс 5000" "Запредельный">>

<ROUTINE FASERIP-CHALLENGE (INTENSITY REQUIRED)
 <TELL "Сложность " N .INTENSITY "; нужен результат: ">
 <TIER-NAME .REQUIRED>
 <TELL "." CR>>

<ROUTINE REPORT-FEAT (TBL ATTR INTENSITY SHIFT REQUIRED RAW SPENT TOTAL TIER)
 <REPORT-CHECK .TBL .ATTR .INTENSITY .TOTAL .TIER>
 <FASERIP-CHALLENGE .INTENSITY .REQUIRED>
 <COND (<NOT <0? .SHIFT>> <TELL "Эффективный ранг " N ,LAST-FEAT-RANK "." CR>)>
 <COND (<NOT <0? .SPENT>>
        <TELL "Бросок d100 " N .RAW " + карма " N .SPENT " = " N .TOTAL "." CR>)>>

<ROUTINE REPORT-FEAT-GATE (REQUIRED)
 <COND (<0? .REQUIRED> <TELL "Проверка проходит без броска." CR>)
       (T <TELL "Без другого подхода эта проверка невозможна." CR>)>>
