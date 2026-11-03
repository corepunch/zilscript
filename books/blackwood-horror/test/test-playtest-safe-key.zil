<INSERT-FILE "books/blackwood-horror/blackwood-horror">

<GLOBAL CO <CO-CREATE GO>>

<ROUTINE RUN-TEST ()
    ;"Observed command: TAKE SAFE KEY -> 'Which key do you mean, the brass key or the safe key?'"
    ;"Both keys are written as small and brass, so SMALL KEY asks which one.
      The answer, or a new TAKE naming the key (read as the answer), replaces
      SMALL and must reach the right key."
    <SETG HERE ,DIRECTORS-OFFICE>
    <MOVE ,WINNER ,DIRECTORS-OFFICE>
    <MOVE ,BRASS-KEY ,WINNER>
    <FCLEAR ,BRASS-KEY ,INVISIBLE> ;"Found under the reception papers"
    <MOVE ,HOLLOW-BOOK ,WINNER>
    <FSET ,HOLLOW-BOOK ,OPENBIT>
    <MOVE ,SAFE-KEY ,HOLLOW-BOOK>

    <ASSERT-TEXT "Which small key" <CO-RESUME ,CO "take small key">>
    <ASSERT-TEXT "Taken" <CO-RESUME ,CO "numbered">>
    <ASSERT "Answering NUMBERED selects the safe key"
            <==? <LOC ,SAFE-KEY> ,WINNER>>

    <MOVE ,SAFE-KEY ,HOLLOW-BOOK>
    <ASSERT-TEXT "Which small key" <CO-RESUME ,CO "take small key">>
    <ASSERT-TEXT "Taken" <CO-RESUME ,CO "take safe key">>
    <ASSERT "TAKE SAFE KEY selects the safe key"
            <==? <LOC ,SAFE-KEY> ,WINNER>>
    <ASSERT-TEXT "already have" <CO-RESUME ,CO "take reception key">>>
