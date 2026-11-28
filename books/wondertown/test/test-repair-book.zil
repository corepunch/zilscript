"Regression: climbing the workbench reaches a distinct book scene"
<INSERT-FILE "books/wondertown/wondertown">
<GLOBAL CO <CO-CREATE GO>>

<ROUTINE RUN-TEST ()
    <CO-RESUME ,CO "look" T>
    <CO-RESUME ,CO "climb workbench">
    <ASSERT "Climbing reaches the workbench top"
            <EQUAL? ,HERE ,WORKBENCH-TOP>>

    <ASSERT-TEXT "green leather book"
                 <CO-RESUME ,CO "examine illustrated book">>
    <ASSERT-TEXT "paper gears"
                 <CO-RESUME ,CO "open illustrated book">>
    <ASSERT "Repair book is open" ,REPAIR-BOOK-OPEN>
    <ASSERT-TEXT "already open"
                 <CO-RESUME ,CO "open illustrated book">>
    <ASSERT-TEXT "follow the ticking beneath the ticking"
                 <CO-RESUME ,CO "read illustrated book">> ;"Reading the open book repeats its clue"
    <CO-RESUME ,CO "down">
    <ASSERT "The open book blocks the descent"
            <EQUAL? ,HERE ,WORKBENCH-TOP>>
    <CO-RESUME ,CO "close illustrated book">
    <CO-RESUME ,CO "down">
    <ASSERT "Closing the book permits the descent"
            <EQUAL? ,HERE ,WORKSHOP-FLOOR>>
>
