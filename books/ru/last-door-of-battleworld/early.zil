<ROOM LANDING (DESC "Равнина героев")>
<ROOM RIDGE (DESC "Гребень холма")>
<OBJECT MAGNETO (DESC "Магнето") (SYNONYM МАГНЕТО)>
<OBJECT BW-WRECK (DESC "обломки") (SYNONYM ОБЛОМКИ ОБЛОМОК МАШИНА МАШИНУ КОЛЬЦО)>
<OBJECT COIL (DESC "медная катушка") (SYNONYM КАТУШКА КАТУШКУ КАТУШКИ ПРОВОЛОКА) (ADJECTIVE МЕДНАЯ МЕДНУЮ)>
<OBJECT RELAY (DESC "щитовой передатчик") (SYNONYM ПЕРЕДАТЧИК ПЕРЕДАТЧИКА ПАНЕЛЬ ПАНЕЛИ) (ADJECTIVE ЩИТОВОЙ)>
<OBJECT RIDGE-ATTACK (DESC "злодеи") (SYNONYM ЗЛОДЕИ ЗЛОДЕЕВ КАНГ КАНГА КАНГОМ АТАКА)>
<ROUTINE MSG-EARLY-OPENING ()
 <TELL "Машина из Центрального парка унесла вас с Земли. Теперь вы в Мире битв и слышите крики о помощи." CR>>
<ROUTINE MSG-LANDING ()
 <TELL "На равнине трава сменяется красным камнем. У обломков стоит Магнето. Крики доносятся из-за холма на севере." CR>>
<ROUTINE MSG-MAGNETO ()
 <TELL "«Потусторонний поставил меня на вашу сторону, — говорит Магнето. — Обещал приз, если мы побьём врагов. Лучше поможем людям». Он показывает на север." CR>>
<ROUTINE MSG-WRECK ()
 <TELL "Это кольцо доставило вас сюда. С него вы видели, как из кусков разных планет сложился Мир битв. А когда Дум и Галактус бросили вызов Потустороннему, их отбросила яркая вспышка." CR>>
<ROUTINE MSG-COIL ()
 <TELL "Проволока свёрнута в тугую спираль. Сбоку выбит маленький щит." CR>>
<ROUTINE MSG-RIDGE ()
 <TELL "На холме стоит щитовой передатчик. ">
 <COND (,BW-SHIELD <TELL "Щит укрывает тропу на север, к лагерю. ">)
       (T <TELL "Канг стреляет по камням на тропе к лагерю, на севере. ">)>
 <TELL "Равнина осталась на юге." CR>>
<ROUTINE MSG-RELAY ()
 <COND (,BW-SHIELD <MSG-RELAY-DONE>)
       (T <TELL "Передатчик создаёт щит, когда есть питание. В пустое гнездо со значком щита как раз поместится катушка." CR>)>>
<ROUTINE MSG-RELAY-FIXED ()
 <TELL "Щёлк! Выстрел Канга рассыпается о щит искрами. Магнето поднимает плиту, и люди бегут на север в лагерь." CR> <MSG-EARLY-OBJECTIVE>>
<ROUTINE MSG-RELAY-DONE () <TELL "Щит ровно гудит над дорогой. Путь на север, к лагерю, открыт." CR>>
<ROUTINE MSG-ATTACK ()
 <TELL "Канг простреливает путь к лагерю. Почините передатчик">
 <COND (<NOT ,BW-SHIELD-POWER-TRIED> <TELL " или попробуйте свою силу: «применить передатчик»">)>
 <TELL "." CR>>
<ROUTINE BW-EARLY-CHOICES ()
 <COND (<EQUAL? ,HERE ,LANDING>
        <CHOICE "bw.landing.magneto" "Поговорить с Магнето" "осмотреть магнето" ,CHOICE-INVESTIGATE 95>
        <CHOICE "bw.landing.wreck" "Осмотреть обломки" "осмотреть обломки" ,CHOICE-INVESTIGATE 85>
        <COND (<IN? ,COIL ,LANDING> <CHOICE "bw.landing.coil" "Подобрать медную катушку" "взять катушку" ,CHOICE-PROGRESS 100>)>
        <CHOICE "bw.landing.ridge" "Подняться на холм" "север" ,CHOICE-PROGRESS 90>)
       (<EQUAL? ,HERE ,RIDGE> <COND (<NOT ,BW-SHIELD>
                 <COND (<NOT ,BW-SHIELD-POWER-TRIED> <CHOICE "bw.ridge.power" "Защитить дорогу своей силой" "применить передатчик" ,CHOICE-PROGRESS 98>)>
                 <COND (<IN? ,COIL ,RIDGE> <CHOICE "bw.ridge.coil" "Подобрать катушку" "взять катушку" ,CHOICE-PROGRESS 99>)>
                 <CHOICE "bw.ridge.relay" "Осмотреть повреждённый передатчик" "осмотреть передатчик" ,CHOICE-INVESTIGATE 95>
                 <COND (<IN? ,COIL ,WINNER> <CHOICE "bw.ridge.fix" "Вставить катушку в передатчик" "использовать передатчик" ,CHOICE-PROGRESS 100>)>)
                (T <CHOICE "bw.ridge.camp" "Пройти под щитом в лагерь" "север" ,CHOICE-PROGRESS 100>)>
          <CHOICE "bw.ridge.plain" "Вернуться на равнину" "юг" ,CHOICE-RETURN 60>)>>

<ROUTINE MSG-EARLY-OBJECTIVE () <TELL "Над лагерем вспыхивает лицо Дума. «Мой станок зашьёт последнюю дверь домой!» Теперь путь на север безопасен." CR>>
<ROUTINE MSG-SHIELD-POWER ()
 <COND (<EQUAL? ,RPG-PRESET-INDEX 1> <TELL "Вы натягиваете между скалами полог паутины, и выстрелы застревают в нём, не долетев до дороги." CR>)
       (<EQUAL? ,RPG-PRESET-INDEX 2> <TELL "Вы призываете вихрь: он уводит выстрелы в небо и укрывает дорогу." CR>)
       (T <TELL "Вы направляете защитное поле брони поперёк дороги; выстрелы Канга вспыхивают на нём и гаснут." CR>)>>
<ROUTINE MSG-SHIELD-FAIL () <TELL "Выстрелы пробивают защиту. Попробуйте вставить медную катушку с равнины в передатчик. Время есть." CR>>
