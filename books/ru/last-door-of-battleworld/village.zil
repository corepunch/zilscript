<ROOM VILLAGE (DESC "Деревня Зсаджи")>
<SYNTAX ПОЗВОНИТЬ В OBJECT = V-RING>
<SYNTAX ПОЗВОНИТЬ OBJECT = V-RING>
<SYNONYM ПОЗВОНИТЬ ПОЗВОНИ ЗВОНИТЬ>
<ROUTINE V-RING () <TELL "Звука нет." CR>>
<OBJECT SCALES (DESC "лавочные весы") (ADJECTIVE ЛАВОЧНЫЕ ЛАВОЧНЫХ) (SYNONYM ВЕСЫ ВЕСОВ ЧАШУ ЧАША)>
<OBJECT CLAPPER (DESC "бронзовый язык") (SYNONYM ЯЗЫК ЯЗЫЧОК ГИРЬКА ГИРЬКУ) (ADJECTIVE БРОНЗОВЫЙ)>
<OBJECT BELL (DESC "деревенский колокол") (SYNONYM КОЛОКОЛ ВЕРЁВКУ ВЕРЕВКУ) (ADJECTIVE ДЕРЕВЕНСКИЙ)>
<OBJECT ZSAJI (DESC "Зсаджи") (SYNONYM ЗСАДЖИ ЦЕЛИТЕЛЬНИЦА ЦЕЛИТЕЛЬНИЦУ)>

<ROUTINE MSG-MARKET-SCALES ()
 <COND (<NOT ,BW-WEIGHED> <TELL "Одна чаша весов перекосилась. ">)
       (T <TELL "Весы висят ровно. ">)>
 <TELL "Деревня на западе." CR>>
<ROUTINE MSG-FOUND-CLAPPER ()
 <TELL "Вы приподнимаете чашу. Из-под неё выкатывается бронзовый язык с потёртой петлёй на конце. Для гирьки петля великовата." CR>>
<ROUTINE MSG-EMPTY-SCALES () <TELL "Теперь чаши висят ровно. От одного яблока стрелка начинает качаться." CR>>
<ROUTINE MSG-CLAPPER () <TELL "Петля на конце и две отполированные щёчки. Похоже, много лет эта штука раскачивалась, ударяясь обо что-то изнутри." CR>>
<ROUTINE MSG-VILLAGE ()
 <TELL "По деревне летит красная пыль. У колокола стоит Зсаджи. Рынок на востоке." CR>>
<ROUTINE MSG-BELL ()
 <TELL "Колокол молчит. Внутри пустой крюк: на нём должен висеть язык." CR>>
<ROUTINE MSG-BELL-FITTED () <TELL "Бронзовая петля прочно сидит на крюке. Теперь можно потянуть колокол за верёвку." CR>>
<ROUTINE MSG-ZSAJI ()
 <COND (,BW-BELL-RUNG <TELL "Зсаджи учит вас произносить приветствие на своём языке. Потом подвигается на ступеньке. Тут перевод не нужен." CR>)
       (T <TELL "Зсаджи рисует в пыли двух пастухов. С холма доносится слабый свист. Она показывает на колокол: пастухи заблудились и пойдут на звон." CR>)>>
<ROUTINE MSG-HEALING () <TELL "Зсаджи замечает синяк от троса и протягивает руку. По плечу разливается тепло, боль отступает. Вы восстановили 5 единиц здоровья." CR>>
<ROUTINE MSG-ANSWERING-BELLS () <TELL "Низкий звон плывёт над тропой. С холма отвечают два свистка. Из пыли выходят пастухи. Чтобы не потеряться, они связали рукава своих курток. Зсаджи разливает похлёбку." CR>>
<ROUTINE MSG-ALL-HOME () <TELL "Пастухи постукивают ложками по пустым мискам в такт колоколу. Все дома." CR>>
<ROUTINE MSG-VILLAGE-FAREWELL () <TELL "Из деревни вам вслед доносится низкий звон колокола." CR>>
<ROUTINE BW-VILLAGE-CHOICES ()
 <COND (<==? ,HERE ,MARKET>
        <COND (<NOT ,BW-WEIGHED>
               <CHOICE "bw.market.scales" "Выяснить, отчего перекосились весы" "осмотреть весы" ,CHOICE-INVESTIGATE 89>)>
        <CHOICE "bw.market.village" "Навестить деревню целительницы" "запад" ,CHOICE-INVESTIGATE 88>)
       (<==? ,HERE ,VILLAGE>
        <CHOICE "bw.village.healer" "Посидеть рядом со Зсаджи" "осмотреть зсаджи" ,CHOICE-INVESTIGATE 93>
        <COND (<IN? ,CLAPPER ,WINNER>
               <CHOICE "bw.village.fit" "Повесить язык на крюк внутри колокола" "вставить язык в колокол" ,CHOICE-PROGRESS 99>)
              (<AND <IN? ,CLAPPER ,BELL> <NOT ,BW-BELL-RUNG>>
               <CHOICE "bw.village.ring" "Созвать пастухов звоном" "позвонить в колокол" ,CHOICE-PROGRESS 100>)
              (T <CHOICE "bw.village.bell" "Осмотреть деревенский колокол" "осмотреть колокол" ,CHOICE-INVESTIGATE 92>)>
        <CHOICE "bw.village.market" "Вернуться на рынок" "восток" ,CHOICE-RETURN 90>)>
 <COND (<IN? ,CLAPPER ,HERE>
        <CHOICE "bw.clapper.take" "Поднять бронзовый язык" "взять язык" ,CHOICE-INVESTIGATE 99>)>>
