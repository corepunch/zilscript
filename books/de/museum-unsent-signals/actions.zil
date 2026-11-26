<SYNTAX KIPP OBJECT = V-TILT-LENS>
<SYNONYM KIPP KIPPE NEIG NEIGE>

<GLOBAL LENS-READ <>>
<GLOBAL SIGNAL-HEARD <>>
<GLOBAL MUSEUM-END 0>

<ROUTINE MUSEUM-PLAQUE-F ()
 <COND (<VERB? EXAMINE READ>
  <TELL "In erhabenen Buchstaben steht die einzige Regel des Museums auf der Tafel: NICHTS HIER WURDE JE ABGESCHICKT. BITTE LASS ES RUHEN. Darunter klebt ein Zettel in der Handschrift des Hausmeisters: „Die Holzspule bei den unzustellbaren Briefen ist als leer eingetragen. Aber jemand hat sie vierzig Jahre lang jeden Tag in die Hand genommen. Bitte prüf sie, bevor wir die Relaisanlage abschalten.“" CR>)
       (<VERB? RUB>
  <TELL "Wo Besucher die Buchstaben mit den Fingern nachgezogen haben, sind sie fast flach. Der Klebestreifen des Hausmeisters ist neu und klebt noch ein bisschen." CR>)
       (<VERB? TAKE MOVE>
  <TELL "Die Tafel ist an die Wand geschraubt. Der Zettel ist für die Person bestimmt, die ihn hier liest." CR>)>>

<ROUTINE TICKET-COUNTER-F ()
 <COND (<VERB? EXAMINE READ>
  <TELL "Ein abgenutzter Holztresen mit einer alten Messingkasse. Auf der obersten Karte steht der Stempel LETZTE NACHT. Die Tinte ist noch feucht genug, um zu verwischen. Es wird niemand mehr kommen, um eine zu kaufen." CR>)
       (<VERB? RUB>
  <TELL "Du fährst mit der Hand über den Tresen. An zwei Stellen ist der Lack heller geworden. Dort hat sich der Hausmeister jeden Abend abgestützt." CR>)
       (<VERB? TAKE>
  <TELL "Du nimmst eine Karte und legst sie wieder hin. Die Schlüssel hast du schon. Eine Karte wäre bloß ein Andenken ans Ende." CR>)
       (<VERB? SMELL>
  <TELL "Frische Stempelfarbe und alter Lack." CR>)
       (<VERB? KNOCK>
  <TELL "Dein Klopfen hallt durchs leere Museum. Nur das Summen der Relaisanlage antwortet. Für einen Augenblick scheint es den Atem anzuhalten." CR>)>>

<ROUTINE GLASS-CASES-F ()
 <COND (<VERB? EXAMINE LOOK-INSIDE SEARCH>
  <TELL "In jeder Vitrine liegt eine ungesendete Nachricht mit einer kleinen Karte. Eine Wachswalze: eine zweimal aufgenommene Entschuldigung. Ein Telefonband: ein nie abgespielter Heiratsantrag. Unten ein Dutzend Aufnahmen, die alle mit „Lass gut sein“ anfangen. Eine Vitrine ist leer. Auf ihrer Karte steht nur LEER. Von dort stammt die Holzspule." CR>)
       (<VERB? OPEN>
  <TELL "Die Vitrinen sind abgeschlossen, und der Hausmeister hat die Schlüssel mit nach Hause genommen. Nur die Spule zur Überprüfung liegt draußen." CR>)
       (<VERB? RUB>
  <TELL "Das Glas ist kühl. Schwache Fingerabdrücke zeigen, wo Besucher die Fingerspitzen dagegen gehalten haben, als wollten sie die Nachrichten erreichen." CR>)
       (<VERB? KNOCK>
  <TELL "Klopf, klopf. Das Glas klingt leise, und die ganze Reihe antwortet mit einem Summen." CR>)
       (<VERB? LISTEN>
  <TELL "Nichts. Jede Nachricht hier wartet darauf, abgespielt zu werden, und keine wird es je." CR>)
       (<VERB? ATTACK KICK>
  <TELL "In einem Raum voller unausgesprochener Worte anderer Leute wäre Glasbruch wohl die schlechteste Art, selbst etwas zu sagen." CR>)>>

<ROUTINE RELAY-F ()
 <COND (<VERB? EXAMINE>
  <COND (<EQUAL? ,HERE ,SIGNAL-BOOTH> <TELL "Diese Kabine ist das Herz der Relaisanlage. Ihre Kabel verlaufen unter dem Pult und durch die Wände zu jedem Lautsprecher unter der Kuppel. Morgen früh wird jemand die Anlage abschalten." CR>)
        (T <TELL "Von hier siehst du die Relaisanlage nicht. Du hörst nur das tiefe, gleichmäßige Summen, das aus der Signalkabine durch die Wände dringt." CR>)>)
       (<VERB? LISTEN>
  <TELL "Das Summen schwillt kaum hörbar an und ab, wie langsames Atmen. Nach vierzig Jahren ist es das vertrauteste Geräusch im Gebäude." CR>)>>

<ROUTINE LOBBY-F ()
 <COND (<VERB? EXAMINE>
  <TELL "Eine altmodische Halle mit Fliesenboden und gedimmtem Licht. Die Kasse und die Tafel liegen gegenüber der Eingangstür, die für die Nacht abgeschlossen ist. Im Osten und Westen sind Durchgänge. Ein kurzer Gang führt nach Norden in die Signalkabine." CR>)
       (<VERB? LISTEN>
  <TELL "Nur das Summen der Anlage und deine Schritte auf den Fliesen." CR>)>>

<ROUTINE GALLERY-F ()
 <COND (<VERB? EXAMINE>
  <TELL "Ein langer, dämmriger Raum. Vom Boden bis zur Decke reichen die Vitrinen, jede mit ihrer kleinen Karte. Es fühlt sich an wie eine Bibliothek dessen, was Leute beinahe gesagt hätten." CR>)
       (<VERB? LISTEN>
  <TELL "Es ist vollkommen still. Hunderte Nachrichten liegen in diesem Raum, und keine gibt einen Ton von sich." CR>)>>

<ROUTINE QUIET-ROOM-F ()
 <COND (<VERB? EXAMINE>
  <TELL "Dicker grauer Teppich, schlichte Wände, eine Bank und ein Schaltplan. Im Saal der Stille soll dir nichts ins Auge fallen. Hier setzt man sich und wartet." CR>)
       (<VERB? LISTEN>
  <TELL "Teppich und Wände schlucken jedes Geräusch. Vor lauter Stille fängt es in deinen Ohren an zu klingeln." CR>)
       (<VERB? RUB>
  <TELL "Der Teppich ist dick und weich. Deine Hand hinterlässt einen Abdruck, der langsam verblasst." CR>)>>

<ROUTINE BOOTH-F ()
 <COND (<VERB? EXAMINE>
  <TELL "Eine kleine Kabine mit Glaswänden und einem abgenutzten Pult. Darin sitzen die Lesemulde, der Abhörknopf und zwei Sendetasten: links die Rückantworttaste, rechts die Gedenktaste." CR>)
       (<VERB? PUSH>
  <TELL "Du musst dich für eine entscheiden: die Rückantworttaste oder die Gedenktaste." CR>)
       (<VERB? RUB>
  <TELL "Das Glas ist warm. Du lehnst kurz die Stirn dagegen, wie all die Menschen vor dir." CR>)>>

<ROUTINE RETURN-LENS-F ()
 <COND (<VERB? EXAMINE LOOK-INSIDE>
  <COND (,LENS-READ <TELL "Gegen das Licht gekippt zeigt die Lupe die eingeritzte Anweisung deutlich: Drei Kerben am Holzrand einer Spule bedeuten NUR RÜCKANTWORT. Keine öffentliche Weiterleitung." CR>)
        (T <TELL "Wenn du gerade hindurchschaust, erscheint die Karte der leeren Vitrine groß und deutlich. Bei der Spule steht nur LEER. Die Lupe sitzt aber locker in ihrer Messingfassung. Du könntest sie zum Licht hin kippen." CR>)>)
       (<VERB? TILT-LENS MOVE PUSH>
        <SETG LENS-READ T>
        <TELL "Du kippst die Lupe zur Deckenleuchte. Feine Kratzer im Glas, eben noch unsichtbar, fangen das Licht ein: eine alte Anweisung des Relaispersonals. Drei Kerben am Holzrand bedeuten NUR RÜCKANTWORT. Keine öffentliche Weiterleitung. Jemand hat das Wort Rand unterstrichen." CR>)
       (<VERB? RUB>
  <TELL "Das Glas ist kühl und makellos. Die Messingfassung ist an einer Seite blank von all den Händen, die die Lupe schon gekippt haben." CR>)
       (<VERB? KNOCK>
  <TELL "Kling. Die Lupe zittert in ihrer Fassung. Sie sitzt offenbar weniger fest, als sie aussieht." CR>)
       (<VERB? TAKE>
  <TELL "Die Lupe ist an ihrem Ständer festgeschraubt. Sie lässt sich kippen, aber mitnehmen kannst du sie nicht." CR>)>>

<ROUTINE MESSAGE-SPOOL-F ()
 <COND (<AND <VERB? PUT PUT-ON> <EQUAL? ,PRSI ,READING-BASIN> <HELD? ,MESSAGE-SPOOL>>
  <MOVE ,MESSAGE-SPOOL ,READING-BASIN>
  <TELL "Du legst die Spule in die Mulde. Sie rastet ein und beginnt sich zu drehen. Am Rand der Mulde leuchtet der [[Abhörknopf]] auf." CR>)
       (<VERB? EXAMINE READ>
  <COND (,LENS-READ
    <TELL "Ein kleines Tonband auf einer Holzspule. Auf dem Papieretikett steht: ZUR ÜBERPRÜFUNG. ALS LEER EINGETRAGEN. Am Holzrand sitzen drei feine, gleichmäßige Kerben, genau das Zeichen, das du in der Lupe gesehen hast. Was auch immer im Katalog steht, die Rückadresse ist privat. Diese Spule sollte an genau eine Person zurückgehen." CR>)
   (T <TELL "Ein kleines Tonband auf einer Holzspule. Wo ein Daumen aufliegen würde, ist das Holz glatt. Auf dem Papieretikett steht: ZUR ÜBERPRÜFUNG. ALS LEER EINGETRAGEN. Am Holzrand siehst du drei feine Kerben. Zuerst hältst du sie für Beschädigungen." CR>)>)
       (<VERB? SMELL>
  <TELL "Zedernholz und Maschinenöl, und ganz schwach ein Hauch von Handcreme." CR>)
       (<VERB? LISTEN>
  <TELL "An deinem Ohr bleibt die Spule stumm. Zum Abspielen braucht sie die Lesemulde in der Signalkabine." CR>)
       (<VERB? RUB>
  <TELL "Dein Daumen findet die glatte Vertiefung im Holz. Jemand hat die Spule immer wieder genau so gehalten." CR>)
       (<VERB? SHAKE>
  <TELL "Du schüttelst sie vorsichtig. Das Band bleibt straff auf der Spule. Wer es aufgewickelt hat, hat sich viel Mühe gegeben." CR>)>>

<ROUTINE HALL-BENCH-F ()
 <COND (<VERB? EXAMINE>
  <TELL "Eine schlichte Holzbank. Zwei flache Kuhlen liegen dicht nebeneinander auf der Sitzfläche. Hier haben wohl immer zwei Menschen Schulter an Schulter gesessen und geschwiegen." CR>)
       (<VERB? RUB>
  <TELL "Das Holz ist glatt und ein wenig warm, als wäre gerade erst jemand aufgestanden." CR>)
       (<VERB? LISTEN>
  <TELL "Du stehst reglos neben der Bank und lauschst. Es ist so still, dass du deinen Herzschlag hörst und darunter ganz leise das Summen der Relaisanlage." CR>)
       (<VERB? LOOK-UNDER>
  <TELL "Unter der Bank ist der Teppich kaum abgetreten. Alle, die hier saßen, haben die Füße ganz still gehalten." CR>)
       (<VERB? TAKE MOVE PUSH>
  <TELL "Die Bank ist am Boden befestigt, mit Blick auf den Schaltplan. So steht sie schon sehr lange." CR>)>>

<ROUTINE SERVICE-DIAGRAM-F ()
 <COND (<VERB? EXAMINE READ>
  <TELL "Auf dem Plan ist die Anlage ein Netz aus Linien. Zwei führen aus der Signalkabine. Die dicke Leitung, der GEDENKKANAL, geht zu allen Lautsprechern unter der Kuppel. Sie überträgt nur neues Material aus der Kabine, nie die Aufnahme von der Spule selbst. Die dünne Leitung, der RÜCKKANAL, schickt eine neue Empfangsbestätigung an die Person zurück, von der die Nachricht stammt. In einer Ecke hat jemand sorgfältig einen Kreis um das gezogen, was das Museum behalten darf: den leeren Raum zwischen den Nachrichten." CR>)
       (<VERB? RUB>
  <TELL "Dein Finger folgt dem dünnen Rückkanal über das Glas bis zu seinem einzigen winzigen Ziel." CR>)
       (<VERB? TAKE MOVE>
  <TELL "Der Plan ist gerahmt und an die Wand geschraubt. Er gehört zum Gebäude." CR>)>>

<ROUTINE READING-BASIN-F ()
 <COND (<VERB? EXAMINE SEARCH LOOK-INSIDE>
  <COND (<IN? ,MESSAGE-SPOOL ,READING-BASIN>
         <TELL "Die [[Spule->holzspule]] dreht sich langsam in der Mulde. Drück den [[Abhörknopf]], um sie hier in der Kabine zu hören. Über den Gedenkkanal geht dabei nichts hinaus." CR>)
        (T <TELL "Eine flache Schale aus schwarzem Glas, die beim Abspielen eine Spule aufnimmt. Sie ist leer. Leg zum Abspielen eine Holzspule hinein." CR>)>)
       (<VERB? CLOSE> <TELL "Die Mulde hat keinen Deckel. Der Ton bleibt in der Kabine, solange du nichts sendest." CR>)
       (<VERB? RUB>
  <TELL "Das schwarze Glas ist warm und sehr glatt wie ein Stein, den man in der Tasche trägt." CR>)
       (<VERB? LISTEN>
  <COND (<IN? ,MESSAGE-SPOOL ,READING-BASIN> <TELL "Ein leises Zischen, während sich die Spule dreht. Erst wenn du den Abhörknopf drückst, kommt richtiger Ton." CR>)
        (T <TELL "Ein tiefes, geduldiges Summen, wie ein Radio zwischen zwei Sendern." CR>)>)>>

<ROUTINE AUDITION-STUD-F ()
 <COND (<VERB? EXAMINE>
  <TELL "Ein runder Messingknopf neben der Mulde. Wenn du ihn drückst, spielt ein kleiner Lautsprecher hier in der Kabine ab, was in der [[Lesemulde]] liegt. Was du hier hörst, verlässt den Raum nicht." CR>)
       (<VERB? PUSH>
        <COND (<NOT <IN? ,MESSAGE-SPOOL ,READING-BASIN>>
               <TELL "Der Lautsprecher knackt einmal und verstummt. Leg zuerst die Holzspule in die [[Lesemulde]]." CR>)
              (<NOT ,LENS-READ>
               <TELL "Eine Frauenstimme sagt: „Ich bin angekommen.“ Dann folgt langes Schweigen, bis das Band ausläuft. Eine kleine Anzeige am Pult blinkt und fragt: Öffentliche oder private Adresse? Du weißt es noch nicht. Das Relaispersonal muss seine Spulen irgendwie gekennzeichnet haben. Wenn du die Lupe in der Galerie zum Licht hin kippst, könnte sie dir mehr verraten." CR>)
              (,SIGNAL-HEARD
               <TELL "Die Frau sagt: „Ich bin angekommen.“ Jetzt weißt du, wie viel von der Nachricht in der Minute steckt, die auf diese Worte folgt." CR>)
              (T <SETG SIGNAL-HEARD T>
                 <TELL "Eine Frauenstimme sagt: „Ich bin angekommen.“ Dann hörst du eine volle Minute lang nur ihren Atem, langsam und gleichmäßig, als warte sie auf eine Antwort. Die Anzeige ordnet die drei Kerben auf der Spule dem privaten Rückantwortregister zu. Das war nie eine Durchsage. Sie sprach mit einem einzigen Menschen, der damals wohl auf sie gewartet hat. Unter der Mulde leuchten beide Sendetasten auf." CR>)>)
       (<VERB? RUB>
  <TELL "Viele Daumen haben eine flache Mulde in den Messingknopf gerieben." CR>)
       (<VERB? TAKE>
  <TELL "Er gehört zum Pult. Er ist zum Drücken da." CR>)>>

<ROUTINE ROUTING-READY ()
 <COND (,SIGNAL-HEARD <RTRUE>)
       (T <TELL "Die Tasten bleiben dunkel. Die Kabine sendet nichts, bis du weißt, für wen die Nachricht bestimmt war. Finde heraus, was die Kerben auf der Spule bedeuten. Spiele dann die eingelegte Spule hier mit dem Abhörknopf ab." CR> <RFALSE>)>>

<ROUTINE RETURN-KEY-F ()
 <COND (<VERB? EXAMINE>
  <TELL "Eine kleine Taste mit der Aufschrift RÜCKANTWORT. Ein Druck schickt eine neue Antwort privat an die Person zurück, die die Nachricht aufgenommen hat. Die Stimme der Frau wird dabei nicht übertragen. Der öffentliche Kanal bleibt stumm.">
  <COND (,SIGNAL-HEARD <TELL " Jetzt leuchtet sie schwach." CR>) (T <TELL " Sie ist dunkel." CR>)>)
       (<VERB? PUSH>
        <COND (<ROUTING-READY>
          <SETG MUSEUM-END 1>
          <TELL "Du tippst ins Rückantwortregister: „Niemand musste aufbleiben.“ Dann drückst du die Taste. Die Anzeige lässt sich unerträglich lange Zeit mit der Antwort. Schließlich erscheint EMPFANGEN und darunter eine zweite Zeile, die jemand von Hand eingegeben haben muss: ICH HAB DAS LICHT TROTZDEM ANGELASSEN." CR CR "ENDE – PRIVATE RÜCKANTWORT" CR>
          <FINISH>)>
        <RTRUE>)
       (<VERB? RUB>
  <TELL "Die Rückantworttaste ist glatt geworden. Jemand hat oft einen Finger daraufgelegt, ohne sie zu drücken." CR>)>>

<ROUTINE MEMORIAL-KEY-F ()
 <COND (<VERB? EXAMINE>
  <TELL "Eine kleine Taste mit der Aufschrift GEDENKEN. Sie kann die stille Minute auf allen Lautsprechern unter der Kuppel ausgeben, ohne die Stimme und ohne die Adresse. Eine kleine öffentliche Erinnerung daran, dass jemand gewartet hat.">
  <COND (,SIGNAL-HEARD <TELL " Jetzt leuchtet sie schwach." CR>) (T <TELL " Sie ist dunkel." CR>)>)
       (<VERB? PUSH>
        <COND (<ROUTING-READY>
          <SETG MUSEUM-END 2>
          <TELL "Du drückst die Taste und sendest die Minute ohne die Stimme. Unter der Kuppel verkünden sämtliche Lautsprecher rein gar nichts. Du hast mit Beschwerden gerechnet, mit Fragen, was schiefgelaufen sei. Stattdessen kommt eine kurze Nachricht vom Nachtdienst: „Bitte noch nicht zurücksetzen. Jemand hört noch zu.“" CR CR "ENDE – EINE MINUTE FÜR DIE LEBENDEN" CR>
          <FINISH>)>
        <RTRUE>)
       (<VERB? RUB>
  <TELL "Die Gedenktaste ist kühl und fast wie neu. Sie wurde wohl kaum je benutzt." CR>)>>

<ROUTINE V-VERSION ()
 <TELL "Das Museum der ungesendeten Signale|AdventureArena, 2026|Ausgabe " N ,RELEASEID CR>>

<ROUTINE GO ()
 <V-VERSION> <CRLF>
 <SETG HERE ,ADMISSIONS> <SETG VERBOSE T> <SETG LIT T>
 <SETG WINNER ,ADVENTURER> <SETG PLAYER ,WINNER> <MOVE ,WINNER ,HERE>
 <TELL "Das Museum schließt für immer. Heute ist die letzte Nacht im Museum der ungesendeten Signale. Hier hat die Stadt alle Nachrichten aufbewahrt, die aufgenommen und nie abgeschickt wurden. Morgen früh wird die alte Relaisanlage unter der Kuppel abgeschaltet. Der Hausmeister ist nach Hause gegangen. Er hat dir die Schlüssel, einen Zettel an der Tafel und einen Rat hinterlassen: „Du musst nicht alles zum Sprechen bringen.“" CR CR>
 <V-LOOK> <MAIN-LOOP> <AGAIN>>

<ROUTINE V-SCORE ("OPTIONAL" (ASK? T))
 <COND (<NOT <EQUAL? ,MUSEUM-END 0>> <TELL "Das Museum hat seinen letzten Eintrag gemacht." CR>)
       (,SIGNAL-HEARD <TELL "Du hast die Aufnahme gehört. Die Kabine hat noch nichts gesendet." CR>)
       (T <TELL "Ein Eintrag im Museumskatalog wird noch überprüft." CR>)>>

<ROUTINE V-TILT-LENS ()
 <TELL "Das lässt sich nicht kippen. Die Lupe sitzt in einer beweglichen Fassung." CR>>
