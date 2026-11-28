<SETG HERO-NAME <ITABLE 130 (BYTE) 0>>
<ROUTINE OF-WORD () <TELL " из ">>
<ROUTINE NAME-PROMPT () <TELL "Введите имя героя. Оно может содержать до 32 символов." CR>>
<ROUTINE ASK-NAME ("AUX" STATUS)
 <NAME-PROMPT>
 <SET STATUS <READ ,HERO-NAME <> 32>>
 <COND (<==? .STATUS 2> <SETG RPG-PRESET-NAME <>>)>
 .STATUS>

<SYNTAX УДАРИТЬ OBJECT = V-RPG-ATTACK>
<SYNONYM УДАРИТЬ УДАРЬ АТАКОВАТЬ АТАКУЙ>
<SYNTAX СПАСТИ OBJECT = V-RPG-RESCUE>
<SYNONYM СПАСТИ СПАСИ>
<SYNTAX ОТКЛЮЧИТЬ OBJECT = V-RPG-DISABLE>
<SYNONYM ОТКЛЮЧИТЬ ОТКЛЮЧИ>
<SYNTAX ВЫБРАТЬ OBJECT = V-RPG-CHOOSE>
<SYNONYM ВЫБРАТЬ ВЫБЕРИ>
<SYNTAX ПРИМЕНИТЬ OBJECT = V-RPG-POWER>
<SYNONYM ПРИМЕНИТЬ ПРИМЕНИ>
<SYNTAX НАЗВАТЬ OBJECT = V-RPG-NAME>
<SYNONYM НАЗВАТЬ НАЗОВИ>
<SYNTAX СОСТОЯНИЕ = V-RPG-DIAGNOSE>
<SYNONYM СОСТОЯНИЕ ЗДОРОВЬЕ ДИАГНОЗ>
<SYNTAX СТАТУС = V-RPG-CHARACTER>
<SYNONYM СТАТУС СТАТЫ ХАРАКТЕРИСТИКИ>

<ROUTINE STATUS-PROFILE () <TELL "Профиль: ">>

<ROUTINE SAY-NO-TARGET () <TELL "Эту цель нельзя атаковать." CR>>
<ROUTINE SAY-NO-RESCUE () <TELL "Здесь некого спасать." CR>>
<ROUTINE SAY-NO-CONTROL () <TELL "Это не пульт управления." CR>>
<ROUTINE SAY-NO-PROFILE () <TELL "Здесь нельзя выбрать героя." CR>>
<ROUTINE SAY-NO-POWER () <TELL "Это не поможет." CR>>
<ROUTINE SAY-NO-NAME () <TELL "Имя героя можно задать в карточке героя." CR>>
<ROUTINE SAY-NO-STATUS () <TELL "Сначала выберите героя." CR>>
<ROUTINE SAY-NO-CHARACTER () <SAY-NO-STATUS>>
