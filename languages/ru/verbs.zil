;"Russian responses for the basic actions exposed by this grammar."
<ROUTINE V-EXAMINE ()
 <TELL "Ничего необычного." CR>>

<ROUTINE V-READ ()
 <COND (<AND <FSET? ,PRSO ,READBIT> <GETP ,PRSO ,P?TEXT>>
        <TELL <GETP ,PRSO ,P?TEXT> CR>)
       (T <TELL "Здесь нечего читать." CR>)>>

<ROUTINE V-TAKE ()
 <COND (<IN? ,PRSO ,WINNER> <TELL "Это уже у вас." CR>)
       (<NOT <FSET? ,PRSO ,TAKEBIT>> <TELL "Это нельзя взять." CR>)
       (<EQUAL? <ITAKE> T> <TELL "Готово." CR>)>>

<ROUTINE V-INVENTORY ("AUX" OBJ)
 <COND (<SET OBJ <FIRST? ,WINNER>>
        <TELL "У вас с собой:" CR>
        <REPEAT ()
         <TELL D .OBJ CR>
         <COND (<NOT <SET OBJ <NEXT? .OBJ>>> <RETURN>)>>)
       (T <TELL "У вас ничего нет." CR>)>>

<ROUTINE FINISH ("AUX" WORD)
 <V-SCORE>
 <COND (,PROSE-LINKS <QUIT>)>
 <REPEAT ()
  <TELL "Начать заново, загрузить сохранение или выйти?" CR>
  <TELL "Введите «начать», «загрузить» или «выйти»." CR>
  <READ ,P-INBUF ,P-LEXV>
  <SET WORD <GET ,P-LEXV 1>>
  <COND (<EQUAL? .WORD ,W?RESTART> <RESTART> <TELL "Не получилось." CR>)
        (<EQUAL? .WORD ,W?RESTORE> <COND (<RESTORE> <TELL "Готово." CR>) (T <TELL "Не получилось." CR>)>)
        (<EQUAL? .WORD ,W?QUIT> <QUIT>)>>>

<ROUTINE V-LISTEN () <TELL "Ни звука." CR>>
