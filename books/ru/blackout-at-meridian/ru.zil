;"The Russian edition supplies prose, dictionary words and choices for the shared story."
<SYNTAX ПОМОЩЬ = V-BOOK-HELP>
<SYNONYM ПОМОЩЬ ПОДСКАЗКА>
<SYNTAX ИСПОЛЬЗОВАТЬ OBJECT = V-USE>
<SYNTAX ПОСЛУШАТЬ = V-BOOK-LISTEN>


<ROUTINE MSG-VERSION () <TELL "Огни Меридиана|Супергеройское приключение, AdventureArena 2026|Выпуск " N ,RELEASEID CR>>


<ROUTINE SETUP-EDITION () <SETG COMPACT-ROOM-LISTS T>>
<ROUTINE WALK-TO-BRIDGE ()
 <COND (<EQUAL? ,HERE ,DISPATCH> <DO-WALK ,P?NORTH>) (T <DO-WALK ,P?WEST>)>>
<ROUTINE WALK-TO-RELAY () <DO-WALK ,P?EAST>>


<ROUTINE MSG-SCORE-HERO ()
 <TELL "Герой: ">>

<ROUTINE MSG-SCORE-UNREGISTERED ()
 <TELL ". Профиль ещё не выбран." CR>>

<ROUTINE MSG-SCORE-OPEN-CLASS ()
 <TELL " (">>

<ROUTINE MSG-SCORE-CLOSE-CLASS ()
 <TELL ")" CR>>

<ROUTINE MSG-OPENING ()
 <TELL "В девять вечера буря обесточила Меридиан. Затем кто-то захватил релейную станцию, через которую можно было вернуть свет. Теперь её охраняет дрон, а трамвай с пассажирами повис на оборванном тросе над рекой. Вы новый герой города, и это ваш первый вызов. Спешите на мост. Команда «помощь» доступна в любой момент." CR CR>
 <TELL D ,HERE CR>>

<ROUTINE MSG-HELP-HOW ()
 <TELL "Вводите команды «осмотреться», «осмотреть стенд» или «север» либо нажимайте на ссылки в тексте. При важных действиях игра бросает стогранный кубик. Чем больше выпало, тем лучше. Провал может стоить здоровья. Если оно упадёт до нуля, вызов закончится. Команда «прочитать карточку» показывает характеристики, «состояние» — здоровье и карму, а «назвать карточку» позволяет дать герою имя." CR>>

<ROUTINE MSG-HELP-UNREGISTERED ()
 <TELL "Сейчас осмотрите стенд и выберите героя командой «выбрать бастиона», «выбрать искру» или «выбрать призму»." CR>>

<ROUTINE MSG-HELP-RESCUE ()
 <TELL "Сейчас идите на север к мосту и введите «спасти пассажиров»." CR>>

<ROUTINE MSG-HELP-RELAY ()
 <TELL "На релейной станции попробуйте «ударить дрон» или «отключить пульт». Команда «применить аптечку» один раз восстанавливает до 20 очков здоровья за 10 очков кармы." CR>>

<ROUTINE MSG-USE ()
 <TELL "Уточните, что сделать. Предмет: " THE ,PRSO "." CR>>

<ROUTINE MSG-LISTEN-DISPATCH ()
 <TELL "Только дождь стучит по стеклу." CR>>

<ROUTINE MSG-LISTEN-BRIDGE ()
 <TELL "Дождь, ветер и скрип троса над рекой." CR>>

<ROUTINE MSG-LISTEN-RELAY-DRONE-DOWN ()
 <TELL "Слышен только низкий гул пульта." CR>>

<ROUTINE MSG-LISTEN-RELAY ()
 <TELL "Пульт гудит, а винты дрона тонко свистят." CR>>

<ROUTINE MSG-DEFAULT-NAME ()
 <TELL "Меридиан">>

<ROUTINE MSG-CLASS-BULWARK ()
 <TELL "Бастион">>

<ROUTINE MSG-CLASS-ARC ()
 <TELL "Искра">>

<ROUTINE MSG-CLASS-LENS ()
 <TELL "Призма">>

<ROUTINE MSG-HERO-HURT (HEALTH MAX)
 <TELL " (Здоровье: " N .HEALTH " из " N .MAX ".)" CR>>

<ROUTINE MSG-LOSS-RELAY ()
 <TELL "На бетонном полу у вас подкашиваются ноги. Спасатели вытаскивают вас под дождь, а дрон остаётся на страже обесточенного города.">>

<ROUTINE MSG-LOSS-BRIDGE ()
 <TELL "Пальцы соскальзывают, и вы падаете на рельсы. Спасатели сами спускают пассажиров и выносят вас с моста на своей сетке.">>

<ROUTINE MSG-LOSS-ENDING ()
 <TELL " Сегодня Меридиану придётся искать другого героя." CR CR "КОНЕЦ. СПАСЕНИЕ ИЗ БУРИ" CR CR>>

<ROUTINE MSG-LEAP-BRIDGE ()
 <TELL "Вы смотрите на реку и передумываете. Пассажирам вы нужны здесь, наверху." CR>>

<ROUTINE MSG-LEAP-IDLE ()
 <TELL "Вы пружините на носках, готовясь к любому повороту событий." CR>>

<ROUTINE MSG-SETUP ()
 <TELL "Выберите героя: [[Бастион->бастиона]], [[Искра->искру]] или [[Призма->призму]]. Профили можно осмотреть, а имя — вписать в [[карточку героя->карточку]]. Вызов начнётся после выбора героя." CR>>

<ROUTINE MSG-DISPATCH-LOOK-REGISTERED ()
 <TELL "Вы в тесной диспетчерской Меридиана. Свет пока держится на аккумуляторах. Дождь чертит серебряные полосы на [[стекле->окно]], а за ним темнеет [[город]]. На [[стенде->стенд]] отмечен ваш профиль. Дверь ведёт на [[север]], к мосту.">>

<ROUTINE MSG-BRIDGE-LOOK-START ()
 <TELL "Вы на мосту Меридиана. Дождь бьёт в лицо. ">>

<ROUTINE MSG-BRIDGE-LOOK-RESCUED ()
 <TELL "Пустой [[трамвай]] всё ещё висит на [[тросе->трос]] над разорванными [[рельсами->рельсы]], но пассажиры уже у [[спасателей->команду]]. У [[релейной станции->станцию]] выбита [[дверь]], и путь на [[восток]] открыт.">>

<ROUTINE MSG-BRIDGE-LOOK-HANGING ()
 <TELL "На середине моста передний вагон [[трамвая->трамвай]] проломил [[рельсы]] и повис над [[рекой->реку]]. Его держит один провисший [[трос]]. Внутри ещё люди. Внизу [[спасатели->команду]] растянули сетку. На восточном конце моста видна [[релейная станция->станцию]], но сначала нужно спасти пассажиров.">>

<ROUTINE MSG-BRIDGE-LOOK-END ()
 <TELL " Диспетчерская осталась к [[югу->юг]]." CR>>

<ROUTINE MSG-RELAY-LOOK-START ()
 <TELL "Вы на релейной станции. В бетонном зале стоит гул. Вся городская сеть проходит через [[пульт управления->пульт]] у дальней стены. ">>

<ROUTINE MSG-RELAY-LOOK-DRONE-DOWN ()
 <TELL "[[Дрон]] лежит перед ним на полу, его глаз погас. ">>

<ROUTINE MSG-RELAY-LOOK-DRONE-UP ()
 <TELL "Перед пультом висит [[сторожевой дрон->дрон]]. Красный глаз следит за вами. ">>

<ROUTINE MSG-RELAY-LOOK-KIT-EMPTY ()
 <TELL "Пустая [[аптечка->аптечку]] раскрыта у [[двери->дверь]]. За дверью на [[запад]] ведёт дорога обратно к мосту." CR>>

<ROUTINE MSG-RELAY-LOOK-KIT-FULL ()
 <TELL "На стене рядом с [[дверью->дверь]] закреплена [[аптечка->аптечку]]. За дверью на [[запад]] ведёт дорога обратно к мосту." CR>>

<ROUTINE MSG-PROFILE-VANGUARD ()
 <TELL "Бастион поднимает тяжести и силён в ближнем бою. У него высокие сила и выносливость, а разум уступает остальным. Здоровье 120, карма 26.">>

<ROUTINE MSG-PROFILE-ARC ()
 <TELL "Искра движется молниеносно и бьёт электрическими разрядами. Её козыри — ловкость и способности. Здоровье 90, карма 50.">>

<ROUTINE MSG-PROFILE-LENS ()
 <TELL "Призма понимает машины и управляет кинетическими полями. У неё высокие разум и интуиция, но в бою она уязвима. Здоровье 60, карма 90.">>

<ROUTINE MSG-PROFILE-IS-YOURS ()
 <TELL " Это ваш профиль.">>

<ROUTINE MSG-PROFILE-TO-CHOOSE ()
 <TELL " Вы можете выбрать этот профиль.">>

<ROUTINE MSG-PROFILE-TAKE ()
 <TELL "Карточка остаётся на стенде. Выберите её, чтобы выйти на вызов под этим профилем." CR>>

<ROUTINE MSG-CHOOSE-ALREADY-1 ()
 <TELL "Ваш профиль уже зарегистрирован: ">>

<ROUTINE MSG-CHOOSE-ALREADY-2 ()
 <TELL ". Диспетчерская не меняет героев посреди вызова." CR>>

<ROUTINE MSG-CHOOSE-REGISTERED-1 ()
 <TELL "Диспетчерская регистрирует профиль: ">>

<ROUTINE MSG-CHOOSE-REGISTERED-2 ()
 <TELL ". Ваши характеристики:" CR>>


<ROUTINE MSG-PROFILE-ATTACK ()
 <TELL "Если сорвать стенд, пассажирам это не поможет." CR>>

<ROUTINE MSG-BOARD-LOOK-UNREGISTERED ()
 <TELL "На стенде три карточки героев: [[Бастион->бастиона]], [[Искра->искру]] и [[Призма->призму]]." CR>>

<ROUTINE MSG-BOARD-LOOK-BULWARK ()
 <TELL "На карточке [[Бастиона->бастиона]] красная отметка «НА ВЫЗОВЕ». [[Искра->искру]] и [[Призма->призму]] сегодня остаются в резерве." CR>>

<ROUTINE MSG-BOARD-LOOK-ARC ()
 <TELL "На карточке [[Искры->искру]] красная отметка «НА ВЫЗОВЕ». [[Бастион->бастиона]] и [[Призма->призму]] сегодня остаются в резерве." CR>>

<ROUTINE MSG-BOARD-LOOK-LENS ()
 <TELL "На карточке [[Призмы->призму]] красная отметка «НА ВЫЗОВЕ». [[Бастион->бастиона]] и [[Искра->искру]] сегодня остаются в резерве." CR>>

<ROUTINE MSG-DUTY-BOARD-TAKE ()
 <TELL "Стенд прикручен к стене. Важны карточки на нём." CR>>

<ROUTINE MSG-DUTY-BOARD-ATTACK ()
 <TELL "Если сорвать стенд, пассажирам это не поможет." CR>>

<ROUTINE MSG-WINDOW-EXAMINE ()
 <TELL "Сквозь потёки на стекле видно только тёмный силуэт города. Над рекой на ветру качается красный габаритный огонь [[трамвая->трамвай]]." CR>>

<ROUTINE MSG-WINDOW-OPEN ()
 <TELL "Раму закрасили вместе со створкой. Пусть буря остаётся снаружи." CR>>

<ROUTINE MSG-WINDOW-CLOSE ()
 <TELL "Окно уже закрыто." CR>>

<ROUTINE MSG-WINDOW-RUB ()
 <TELL "Стекло холодное. Дождь по ту сторону." CR>>

<ROUTINE MSG-WINDOW-ATTACK ()
 <TELL "У диспетчерской и без того хватает работы на сегодня." CR>>

<ROUTINE MSG-SHEET-HERO ()
 <TELL "Герой: ">>

<ROUTINE MSG-SHEET-UNREGISTERED ()
 <TELL CR "Профиль ещё не выбран. Выберите на стенде [[Бастиона->бастиона]], [[Искру->искру]] или [[Призму->призму]]." CR>>

<ROUTINE MSG-SHEET-OPEN-CLASS ()
 <TELL " (">>

<ROUTINE MSG-SHEET-CLOSE-CLASS ()
 <TELL ")" CR>>

<ROUTINE MSG-NAME-REFUSED-1 ()
 <TELL "На стенде можно записать имя из обычных печатных символов. Ваше имя остаётся прежним: ">>

<ROUTINE MSG-NAME-REFUSED-2 ()
 <TELL "." CR>>

<ROUTINE MSG-NAME-BLANK-1 ()
 <TELL "Имя не введено. Диспетчерская по-прежнему будет звать вас так: ">>

<ROUTINE MSG-NAME-BLANK-2 ()
 <TELL "." CR>>

<ROUTINE MSG-NAME-STORED ()
 <TELL "Имя героя: ">>

<ROUTINE MSG-SHEET-DROP ()
 <TELL "Оставьте карточку при себе. Она нужна, чтобы диспетчерская знала, кто вы." CR>>

<ROUTINE MSG-SHEET-ATTACK ()
 <TELL "Эта карточка — ваш единственный документ на сегодня. Лучше сохранить её целой." CR>>

<ROUTINE MSG-CHECK-STRENGTH ()
 <TELL "Проверка силы. ">>

<ROUTINE MSG-CHECK-AGILITY ()
 <TELL "Проверка ловкости. ">>

<ROUTINE MSG-CHECK-POWER ()
 <TELL "Проверка способностей. ">>

<ROUTINE MSG-TRAM-EXAMINE-RESCUED ()
 <TELL "Пустой вагон скрипит на тросе. Внутри никого." CR>>

<ROUTINE MSG-TRAM-EXAMINE ()
 <TELL "Передний вагон сошёл с рельсов и навис над рекой. Его держит только [[трос]]. Пассажиры внутри машут вам." CR>>

<ROUTINE MSG-TRAM-LISTEN-RESCUED ()
 <TELL "Слышно только, как скрипит трос." CR>>

<ROUTINE MSG-TRAM-LISTEN ()
 <TELL "Сквозь шум дождя слышно, как плачет ребёнок, а кто-то считает вслух, чтобы успокоиться." CR>>

<ROUTINE MSG-TRAM-PUSH ()
 <TELL "Если толкнуть вагон, он упадёт. Его нужно удержать." CR>>

<ROUTINE MSG-TRAM-ATTACK ()
 <TELL "Внутри люди." CR>>

<ROUTINE MSG-TRAM-TRY-RESCUE ()
 <TELL "Вы держитесь за перила. Если забраться в вагон или дёрнуть его целиком, все могут упасть в реку. Спасите пассажиров по одному и передайте их спасателям." CR>>

<ROUTINE MSG-TRAM-RESCUE-UNREGISTERED ()
 <TELL "Сначала выберите героя в диспетчерской." CR>>

<ROUTINE MSG-TRAM-RESCUE-RESCUED ()
 <TELL "Все уже в безопасности." CR>>

<ROUTINE MSG-TRAM-RESCUED-NOW ()
 <TELL "Вы удерживаете вагон и по одному спускаете пассажиров в сетку. Последний, мальчик в жёлтом дождевике, отпускает вашу руку, только когда чувствует землю под ногами. Карма +10. Путь на [[восток]], к релейной станции, открыт." CR>>

<ROUTINE MSG-TRAM-RESCUE-FAILED ()
 <TELL "Трос соскальзывает, и вагон дёргается. Пассажир вскрикивает; вы получаете удар, но спасатели удерживают сетку внизу. Можно попробовать спасти пассажиров снова.">>

<ROUTINE MSG-CREW-EXAMINE-RESCUED ()
 <TELL "На берегу спасатели укутывают пассажиров в термоодеяла. Начальница команды показывает вам большой палец." CR>>

<ROUTINE MSG-CREW-EXAMINE ()
 <TELL "Под мостом пожарные в жёлтых плащах держат сетку и перекрикивают шум дождя." CR>>

<ROUTINE MSG-CREW-TELL-RESCUED ()
 <TELL "Начальница кричит: «Все выбрались! Дрон прилетел с релейной станции. Отключите его!»" CR>>

<ROUTINE MSG-CREW-TELL ()
 <TELL "Начальница кричит через сложенные ладони: «Мы их поймаем, но трос долго не выдержит. Выводите людей!»" CR>>

<ROUTINE MSG-CREW-ATTACK ()
 <TELL "Они на вашей стороне." CR>>

<ROUTINE MSG-CREW-LISTEN ()
 <TELL "Трещат рации. Кто-то считает вслух, сколько жил осталось в тросе." CR>>

<ROUTINE MSG-RAILS-EXAMINE ()
 <TELL "Рельсы выгнуло наружу там, где их проломил вагон. За провалом только дождь и река." CR>>

<ROUTINE MSG-RAILS-CLIMB-ON ()
 <TELL "Вы наклоняетесь над провалом. До реки далеко." CR>>

<ROUTINE MSG-RAILS-TAKE ()
 <TELL "Рельсы прикручены к мосту, и их уже не выправить." CR>>

<ROUTINE MSG-RAILS-RUB ()
 <TELL "Холодная мокрая сталь всё ещё гудит под весом вагона." CR>>

<ROUTINE MSG-RAILS-ATTACK ()
 <TELL "На сегодня рельсам досталось достаточно." CR>>

<ROUTINE MSG-CABLE-EXAMINE-RESCUED ()
 <TELL "Когда вагон опустел, трос перестал звенеть на ветру." CR>>

<ROUTINE MSG-CABLE-EXAMINE ()
 <TELL "Трос провис под весом вагона. У вас на глазах лопается ещё одна жила." CR>>

<ROUTINE MSG-CABLE-LISTEN ()
 <TELL "Трос скрипит и звенит на ветру." CR>>

<ROUTINE MSG-CABLE-RUB ()
 <TELL "Тока в проводе нет. Хоть в этом повезло." CR>>

<ROUTINE MSG-CABLE-ATTACK ()
 <TELL "Только этот трос удерживает вагон." CR>>

<ROUTINE MSG-CABLE-TRY-RESCUE ()
 <TELL "Вы не трогаете трос. На нём висит весь вагон. Спасатели подхватят пассажиров, если спускать их по одному." CR>>

<ROUTINE MSG-CABLE-TAKE-RESCUED ()
 <TELL "Пусть трос висит, пока у города не будет света и возможности его заменить." CR>>

<ROUTINE MSG-DRONE-EXAMINE-DISABLED ()
 <TELL "Дрон лежит на спине. Винты замерли, красный глаз погас." CR>>

<ROUTINE MSG-DRONE-EXAMINE (INTEGRITY MAX)
 <TELL "Чёрный сторожевой дрон размером с автомобильную дверь висит на четырёх винтах. Его красный глаз следит за каждым вашим движением. Прочность: " N .INTEGRITY " из " N .MAX "." CR>>

<ROUTINE MSG-DRONE-LISTEN-DISABLED ()
 <TELL "Тишина." CR>>

<ROUTINE MSG-DRONE-LISTEN ()
 <TELL "Винты тонко и ровно свистят." CR>>

<ROUTINE MSG-DRONE-TELL-DISABLED ()
 <TELL "Дрон молчит." CR>>

<ROUTINE MSG-DRONE-TELL ()
 <TELL "В ответ раздаётся треск: «ЗАПРЕТНАЯ ЗОНА. НЕМЕДЛЕННО УЙДИТЕ»." CR>>

<ROUTINE MSG-DRONE-TAKE-DISABLED ()
 <TELL "Дрон тяжелее, чем кажется, и он понадобится полиции. Оставьте его там, где он упал." CR>>

<ROUTINE MSG-DRONE-TAKE ()
 <TELL "Дрон отходит в сторону, и его глаз вспыхивает. Придётся сражаться." CR>>

<ROUTINE MSG-DRONE-DISABLE-DISABLED ()
 <TELL "Дрон уже обезврежен." CR>>

<ROUTINE MSG-DRONE-ATTACK-UNREGISTERED ()
 <TELL "Сначала выберите героя в диспетчерской." CR>>

<ROUTINE MSG-DRONE-ATTACK-DISABLED ()
 <TELL "Дрон уже обезврежен." CR>>

<ROUTINE MSG-DRONE-CHECK ()
 <TELL "Проверка боевого навыка. ">>

<ROUTINE MSG-DRONE-DOWN ()
 <TELL "Дрон падает на пол, и красный глаз гаснет. Карма +10. [[Пульт]] больше никто не охраняет." CR>>

<ROUTINE MSG-DRONE-HIT (INTEGRITY MAX)
 <TELL "Удар попадает в цель. Дрон кренится, из одного винта сыплются искры. Прочность: " N .INTEGRITY " из " N .MAX "." CR>>

<ROUTINE MSG-DRONE-MISS ()
 <TELL "Дрон скользит в сторону, и удар проходит мимо." CR>>

<ROUTINE MSG-DRONE-COUNTER ()
 <TELL "Вас задевает оглушающий луч.">>

<ROUTINE MSG-CONSOLE-EXAMINE ()
 <TELL "Среди потухших экранов остался один ручной переключатель. Если его перевести, город снова получит контроль над сетью.">>

<ROUTINE MSG-CONSOLE-EXAMINE-NOT-DISABLED ()
 <TELL " Дрон висит между вами и переключателем. Можно сначала атаковать его, рискуя попасть под ответный луч, или попытаться добраться до рычага напрямую: для этого нужна проверка разума.">>

<ROUTINE MSG-CONSOLE-RUB ()
 <TELL "Пульт тёплый и дрожит от нагрузки, на которую не рассчитан." CR>>

<ROUTINE MSG-CONSOLE-TAKE ()
 <TELL "Пульт прикручен к бетонному полу." CR>>

<ROUTINE MSG-CONSOLE-ATTACK ()
 <TELL "Если разбить пульт, город останется без света на недели. Достаточно перевести переключатель." CR>>

<ROUTINE MSG-CONSOLE-DISABLE-UNREGISTERED ()
 <TELL "Сначала выберите героя в диспетчерской." CR>>

<ROUTINE MSG-CONSOLE-WIN-START ()
 <TELL "Вы переводите переключатель. Гул стихает, экраны включаются один за другим, станция возвращается под местное управление. На другом берегу Меридиан загорается улица за улицей. На мосту мальчик в жёлтом дождевике показывает на первое освещённое окно, и спасатели ликуют. Карма +20." CR CR "В рации раздаётся треск, и диспетчер вызывает вас по имени: ">>

<ROUTINE MSG-CONSOLE-WIN-END ()
 <TELL ". Меридиан в безопасности." CR CR "КОНЕЦ. ОГНИ МЕРИДИАНА" CR CR>>

<ROUTINE MSG-CONSOLE-COUNTER ()
 <TELL "Луч дрона задевает вас прежде, чем вы успеваете добраться до переключателя.">>

<ROUTINE MSG-CHECK-REASON ()
 <TELL "Проверка разума. ">>

<ROUTINE MSG-KIT-EXAMINE-BOOSTED ()
 <TELL "Аптечка раскрыта и пуста." CR>>

<ROUTINE MSG-KIT-EXAMINE ()
 <TELL "Красная аптечка прикреплена к стене. Её можно использовать один раз за 10 очков кармы. Она восстанавливает до 20 очков здоровья." CR>>

<ROUTINE MSG-KIT-OPEN ()
 <TELL "Под прозрачной крышкой лежит запечатанный пластырь. Пломба цела. Команда «применить аптечку» потратит 10 очков кармы, если вам нужно лечение." CR>>

<ROUTINE MSG-KIT-TAKE ()
 <TELL "Аптечка закреплена на стене. Используйте её здесь." CR>>

<ROUTINE MSG-KIT-ATTACK ()
 <TELL "Вам ещё может понадобиться то, что внутри." CR>>

<ROUTINE MSG-KIT-POWER-UNREGISTERED ()
 <TELL "Сначала выберите героя в диспетчерской." CR>>

<ROUTINE MSG-KIT-POWER-BOOSTED ()
 <TELL "Аптечка пуста." CR>>

<ROUTINE MSG-KIT-UNHURT ()
 <TELL "Вы не ранены. Приберегите аптечку." CR>>

<ROUTINE MSG-KIT-USED (GAINED HEALTH MAX KARMA)
 <TELL "Вы открываете аптечку и прижимаете пластырь к рёбрам. Восстановлено очков здоровья: " N .GAINED ". (Здоровье: " N .HEALTH " из " N .MAX ", карма: " N .KARMA ".)" CR>>

<ROUTINE MSG-KIT-NO-KARMA (KARMA)
 <TELL "Для аптечки нужно 10 очков кармы. У вас сейчас " N .KARMA "." CR>>

<ROUTINE MSG-RAIN-DISPATCH ()
 <TELL "Дождь чертит серебряные полосы на окне." CR>>

<ROUTINE MSG-RAIN-BRIDGE ()
 <TELL "На мосту холодный дождь бьёт сбоку и щиплет кожу." CR>>

<ROUTINE MSG-RAIN-EXAMINE ()
 <TELL "Дождь барабанит по бетонной крыше станции." CR>>

<ROUTINE MSG-RAIN-LISTEN ()
 <TELL "Ровный гул, который прерывают раскаты грома." CR>>

<ROUTINE MSG-RAIN-SMELL ()
 <TELL "Пахнет мокрым камнем и горелой проводкой." CR>>

<ROUTINE MSG-RAIN-TAKE ()
 <TELL "Вода стекает между пальцами." CR>>

<ROUTINE MSG-CITY-EXAMINE ()
 <TELL "Меридиан погас от реки до холмов. Ни фонарей, ни светящихся окон. Только буря." CR>>

<ROUTINE MSG-CITY-LISTEN ()
 <TELL "Вдали слышны автомобильные сигнализации, а вокруг только дождь." CR>>

<ROUTINE MSG-RIVER-EXAMINE ()
 <TELL "После ливня река поднялась, и мутная вода несётся мимо." CR>>

<ROUTINE MSG-RIVER-SWIM ()
 <TELL "Течение за секунды утащит вас под мост. Городу вы нужны живыми." CR>>

<ROUTINE MSG-RIVER-DRINK ()
 <TELL "Плыть здесь слишком опасно." CR>>

<ROUTINE MSG-RIVER-LISTEN ()
 <TELL "Река грохочет о быки моста." CR>>

<ROUTINE MSG-BRIDGE-SPAN-DISPATCH ()
 <TELL "До моста Меридиана недолго бежать на север сквозь дождь." CR>>

<ROUTINE MSG-BRIDGE-SPAN-BRIDGE ()
 <TELL "Старый стальной мост тянется над рекой к релейной станции. Посередине проложены трамвайные рельсы." CR>>

<ROUTINE MSG-BRIDGE-SPAN-EXAMINE ()
 <TELL "За дверью мост уходит на запад в пелену дождя." CR>>

<ROUTINE MSG-BRIDGE-SPAN-THROUGH ()
 <TELL "Вы уже на мосту." CR>>

<ROUTINE MSG-DISTANT-TRAM-EXAMINE ()
 <TELL "Отсюда виден только красный габаритный огонь, который качается над рекой. Мост к [[северу->север]]." CR>>

<ROUTINE MSG-DISTANT-TRAM-RESCUE ()
 <TELL "Трамвай на мосту, к [[северу->север]]." CR>>

<ROUTINE MSG-STATION-INSIDE ()
 <TELL "Вы уже внутри. Вся городская сеть проходит через этот зал." CR>>

<ROUTINE MSG-STATION-EXAMINE ()
 <TELL "Приземистое бетонное здание на восточном конце моста гудит под нагрузкой. Стальная [[дверь]] взломана." CR>>

<ROUTINE MSG-STATION-ALREADY-INSIDE ()
 <TELL "Вы уже внутри." CR>>

<ROUTINE MSG-STATION-LISTEN ()
 <TELL "Низкий электрический гул заглушает дождь." CR>>

<ROUTINE MSG-STATION-DOOR-EXAMINE ()
 <TELL "Стальная дверь станции сорвана с замка изнутри." CR>>

<ROUTINE MSG-STATION-DOOR-CLOSE ()
 <TELL "Дверь перекошена и не закроется." CR>>

<ROUTINE MSG-STATION-DOOR-OPEN ()
 <TELL "Дверь уже открыта. Такой она и останется." CR>>

<ROUTINE MSG-STATION-DOOR-KNOCK ()
 <TELL "Изнутри никто не ответит." CR>>


<ROOM DISPATCH (DESC "Диспетчерская") (NORTH TO BRIDGE IF HERO-CLASS ELSE "Диспетчерская выпускает на вызов только зарегистрированных героев. Выберите Бастиона, Искру или Призму.") (OUT TO BRIDGE IF HERO-CLASS ELSE "Диспетчерская выпускает на вызов только зарегистрированных героев. Выберите Бастиона, Искру или Призму.")>

<ROOM BRIDGE (DESC "Мост Меридиана") (SOUTH TO DISPATCH) (EAST TO RELAY IF RESCUED ELSE "Пассажиры всё ещё висят над рекой. Сначала спасите их.") (DOWN "Берегом занимаются спасатели. Пассажирам вы нужны наверху.")>
<ROOM RELAY (DESC "Релейная станция") (WEST TO BRIDGE) (OUT TO BRIDGE)>

<OBJECT VANGUARD (DESC "Бастион") (SYNONYM БАСТИОНА БАСТИОН)>
<OBJECT ARC (DESC "Искра") (SYNONYM ИСКРУ ИСКРА ИСКРЫ)>

<OBJECT LENS (DESC "Призма") (SYNONYM ПРИЗМУ ПРИЗМА ПРИЗМЫ)>
<OBJECT DUTY-BOARD (DESC "стенд") (SYNONYM СТЕНД СТЕНДА ТАБЛО)>

<OBJECT WINDOW (DESC "окно") (SYNONYM ОКНО СТЕКЛО)>
<OBJECT DOSSIER (DESC "карточка героя") (SYNONYM КАРТОЧКУ КАРТОЧКА КАРТОЧКЕ ДОСЬЕ) (ADJECTIVE ГЕРОЯ)>

<OBJECT TRAM (DESC "трамвай") (SYNONYM ТРАМВАЙ ТРАМВАЯ ВАГОН ПАССАЖИРОВ ЛЮДЕЙ)>
<OBJECT CREW (DESC "команда спасателей") (SYNONYM КОМАНДУ КОМАНДА СПАСАТЕЛЕЙ СПАСАТЕЛИ СЕТКУ)>

<OBJECT RAILS (DESC "рельсы") (SYNONYM РЕЛЬСЫ РЕЛЬСОВ) (FLAGS PLURALBIT)>
<OBJECT CABLE (DESC "трос") (SYNONYM ТРОС ПРОВОД ТРОСА)>

<OBJECT DRONE (DESC "сторожевой дрон") (SYNONYM ДРОН ДРОНА) (ADJECTIVE СТОРОЖЕВОЙ СТОРОЖЕВОГО)>
<OBJECT CONSOLE (DESC "пульт управления") (SYNONYM ПУЛЬТ ПУЛЬТА ПЕРЕКЛЮЧАТЕЛЬ) (ADJECTIVE УПРАВЛЕНИЯ РЕЛЕЙНЫЙ)>

<OBJECT SUPPLIES (DESC "аптечка") (SYNONYM АПТЕЧКУ АПТЕЧКА АПТЕЧКИ)>
<OBJECT RAIN (DESC "дождь") (SYNONYM ДОЖДЬ БУРЮ)>

<OBJECT CITY (DESC "город") (SYNONYM ГОРОД МЕРИДИАН)>
<OBJECT RIVER (DESC "река") (SYNONYM РЕКУ РЕКА РЕКИ РЕКОЙ)>

<OBJECT BRIDGE-SPAN (DESC "мост") (SYNONYM МОСТ МОСТА)>
<OBJECT DISTANT-TRAM (DESC "трамвай") (SYNONYM ТРАМВАЙ ТРАМВАЯ)>

<OBJECT STATION (DESC "релейная станция") (SYNONYM СТАНЦИЮ СТАНЦИЯ СТАНЦИИ) (ADJECTIVE РЕЛЕЙНАЯ РЕЛЕЙНУЮ)>
<OBJECT STATION-DOOR (DESC "дверь станции") (SYNONYM ДВЕРЬ ДВЕРИ ДВЕРЬЮ) (ADJECTIVE СТАНЦИИ СТАЛЬНУЮ)>

<ROUTINE SUGGEST-ACTIONS ()
 <COND (<EQUAL? ,HERE ,DISPATCH>
  <COND (<0? ,HERO-CLASS>
   <CHOICE "profile.bulwark" "Выбрать Бастиона" "выбрать бастиона" ,CHOICE-INVESTIGATE 99>
   <CHOICE "profile.arc" "Выбрать Искру" "выбрать искру" ,CHOICE-INVESTIGATE 98>
   <CHOICE "profile.lens" "Выбрать Призму" "выбрать призму" ,CHOICE-INVESTIGATE 97>)
  (T <CHOICE "dispatch.go" "Идти на мост" "север" ,CHOICE-INVESTIGATE 99>)>)
 (<EQUAL? ,HERE ,BRIDGE>
  <COND (,RESCUED <CHOICE "bridge.go" "Войти на релейную станцию" "восток" ,CHOICE-INVESTIGATE 99>)
  (T <CHOICE "bridge.rescue" "Спасти пассажиров" "спасти трамвай" ,CHOICE-INVESTIGATE 99>)>
  <CHOICE "bridge.back" "Вернуться в диспетчерскую" "юг" ,CHOICE-INVESTIGATE 80>)
 (<EQUAL? ,HERE ,RELAY>
  <COND (<NOT ,DISABLED> <CHOICE "relay.strike" "Ударить дрон" "ударить дрон" ,CHOICE-INVESTIGATE 99>)>
  <CHOICE "relay.bypass" "Перевести переключатель" "отключить пульт" ,CHOICE-INVESTIGATE 98>
  <COND (<AND <NOT ,BOOSTED> <L? <STAT ,HERO ,A-HEALTH> <MAX-STAT ,HERO ,A-HEALTH>>> <CHOICE "relay.kit" "Применить аптечку" "применить аптечку" ,CHOICE-INVESTIGATE 95>)>
  <CHOICE "relay.back" "Вернуться на мост" "запад" ,CHOICE-INVESTIGATE 80>)>
 <COND (<NOT <0? ,HERO-CLASS>> <CHOICE "hero.sheet" "Открыть карточку героя" "прочитать карточку" ,CHOICE-INVESTIGATE 90>)>>
