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

;"Room and container listings use Russian phrasing while retaining the base
  traversal and object-specific descriptions."
<ROUTINE DESCRIBE-OBJECT (OBJ V? LEVEL "AUX" (STR <>) AV)
 <SETG DESC-OBJECT .OBJ>
 <COND (<AND <0? .LEVEL> <APPLY <GETP .OBJ ,P?DESCFCN> ,M-OBJDESC>> <RTRUE>)
       (<AND <0? .LEVEL>
             <OR <AND <NOT <FSET? .OBJ ,TOUCHBIT>> <SET STR <GETP .OBJ ,P?FDESC>>>
                 <SET STR <GETP .OBJ ,P?LDESC>>>> <TELL .STR>)
       (<0? .LEVEL>
        <TELL "Здесь: " D .OBJ>
        <COND (<FSET? .OBJ ,ONBIT> <TELL " (светится)">)>
        <TELL ".">)
       (T <TELL <GET ,INDENTS .LEVEL> D .OBJ>
          <COND (<FSET? .OBJ ,ONBIT> <TELL " (светится)">)
                (<AND <FSET? .OBJ ,WEARBIT> <IN? .OBJ ,WINNER>> <TELL " (надето)">)>)>
 <COND (<AND <0? .LEVEL> <SET AV <LOC ,WINNER>> <FSET? .AV ,VEHBIT>>
        <TELL " (снаружи: " D .AV ")">)>
 <CRLF>
 <COND (<AND <SEE-INSIDE? .OBJ> <FIRST? .OBJ>> <PRINT-CONT .OBJ .V? .LEVEL>)>>
