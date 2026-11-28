<SYNTAX FALT OBJECT = V-FOLD-LOAN>
<SYNTAX KLEMM OBJECT (HELD HAVE) IN OBJECT = V-PUT PRE-PUT>
<SYNONYM KLEMM KLEMME>
<SYNONYM FALT FALTE>
<SYNTAX GLAETT OBJECT = V-UNFOLD-LOAN>
<SYNTAX FALT AUF OBJECT = V-UNFOLD-LOAN>
<SYNONYM GLAETT GLAETTE GL\%ATT GL\%ATTE ENTFALT ENTFALTE>
<SYNTAX ZERREISS OBJECT = V-TEAR-LOAN>
<SYNONYM ZERREISS ZERREISSE ZERREI\%S ZERREI\%SE>

<ROUTINE V-VERSION ()
 <TELL "Die Bibliothek der geliehenen Morgen|Studio Null, 2026|Ausgabe " N ,RELEASEID CR>>

<ROUTINE GO ()
 <V-VERSION> <CRLF>
 <SETG COMPACT-ROOM-LISTS T>
 <SETG HERE ,LENDING> <SETG VERBOSE T> <SETG LIT T>
 <SETG WINNER ,ADVENTURER> <SETG PLAYER ,WINNER> <MOVE ,WINNER ,HERE>
 <TELL "»Bis morgen«, sagte die Bäckerin heute früh am Markt. Du hast versprochen, ihr das Morgen aus der Bibliothek zu holen. Da klang es noch wie etwas, das ohnehin käme. Jetzt stehst du in der Bibliothek. Auf dein Hallo antwortet nicht einmal ein Echo." CR CR>
 <V-LOOK> <MAIN-LOOP> <AGAIN>>

<ROUTINE LENDING-F (R)
 <COND (<EQUAL? .R ,M-LOOK>
        <TELL "In der Ausleihhalle glänzen die Dielen wie frisch gewachst. Vor dem hohen Fenster steht ein dunkler Leihschrank. ">
        <COND (,ON-LOAN <TELL "Nur noch ein Streifen Sonnenlicht fällt über den Boden, der von heute. Daneben liegen die grauen Dielen reglos da.">)
              (T <TELL "Zwei Streifen Sonnenlicht liegen auf den Dielen. Der breite wandert mit der Sonne. Der schmale leuchtet goldgelb und ist ihr schon ein Stück voraus.">)>
        <TELL " Ein Bogen im Osten öffnet sich zum Faltraum, und ein Gang führt nach Norden in die trockene Kammer." CR>)>>
<ROUTINE FOLDING-F (R)
 <COND (<EQUAL? .R ,M-LOOK>
        <TELL "Im Faltraum steht nur das lange hölzerne Faltbrett. In die hellen Wände fallen Schatten von Zweigen. Die Kanten des Bretts sind glatt von vielen Händen, die Mitte ist noch rau. Durch den Bogen im Westen geht es zurück zur Ausleihhalle, eine Treppe führt nach Norden hinauf zur Leseterrasse." CR>)>>
<ROUTINE BASIN-F (R)
 <COND (<EQUAL? .R ,M-LOOK>
        <TELL "Du bist in der trockenen Kammer, einem kühlen Steinraum. Eine lange Steinrinne verläuft an der Wand entlang und durch einen Spalt hinaus in Richtung Markt.">
        <COND (,ON-LOAN <TELL " Die Rinne ist jetzt leer. Jeder Tropfen ist zurückgewichen, sogar der, der gerade fiel. Im Raum herrscht Stille.">)
              (T <TELL " Ein dünner Wasserfaden zieht leise murmelnd durch die Rinne dem Markt entgegen.">)>
        <TELL " Ein alter Leihschein klebt flach an der Steinwand. Im Süden geht es zurück zur Ausleihhalle, und eine Tür im Osten führt auf die Leseterrasse." CR>)>>
<ROUTINE TERRACE-F (R)
 <COND (<EQUAL? .R ,M-LOOK>
        <TELL "Auf der Leseterrasse reicht dir das Geländer bis zur Brust. Tief unten auf dem Markt stehen die gestreiften Dächer der Buden neben der kleinen Backstube. Am Geländer steht ein Leserahmen aus Messing, zum Markt hin ausgerichtet.">
        <COND (<IN? ,LEAF ,FRAME> <TELL " Das Morgenblatt steckt im Rahmen. Beide Ecken heben sich wie bei einem Kind, das gleich losspringen will.">)
              (,ON-LOAN <TELL " Unten unter den Ständen sind die Schatten stehen geblieben. Eine Obstverkäuferin hält ihren Korb in der Luft, schon halb auf dem Weg zum Karren. Sie wartet auf einen Abend, der nicht kommt.">)
              (T <TELL " Unten werden die Nachmittagsschatten langsam länger.">)>
        <TELL " Eine Treppe führt nach Süden hinab zum Faltraum. Durch eine Tür im Westen kommst du zurück zur trockenen Kammer." CR>)>>

<ROUTINE CASE-F ()
 <COND (<AND <VERB? OPEN> <NOT <FSET? ,CASE ,OPENBIT>>>
        <FSET ,CASE ,OPENBIT>
        <COND (<IN? ,LEAF ,CASE> <TELL "Du öffnest die kleine Schranktür. Drinnen liegt ganz allein auf dem Regalboden ein Morgenblatt." CR>)
              (T <TELL "Du öffnest die Schranktür. Auf dem Regalboden bleibt nur ein heller Fleck in Form eines Blatts." CR>)>)
       (<VERB? CLOSE>
        <COND (<FSET? ,CASE ,OPENBIT>
               <FCLEAR ,CASE ,OPENBIT>
               <TELL "Die Schranktür schnappt mit einem leisen Klick zu. Das Schild hängt jetzt wieder gerade." CR>)
              (T <TELL "Die Tür sitzt fest im Rahmen. Das Schild wackelt einmal und ist wieder still." CR>)>)
       (<AND <VERB? LOOK-INSIDE SEARCH> <NOT <FSET? ,CASE ,OPENBIT>>>
        <TELL "Durch den Türspalt fällt kein Licht. Öffne die kleine Tür, statt dich durchs Schlüsselloch zu quetschen." CR>)
       (<VERB? EXAMINE SEARCH>
        <COND (<FSET? ,CASE ,OPENBIT>
               <COND (<IN? ,LEAF ,CASE> <TELL "Ein Morgenblatt liegt im offenen Schrank. Hier wäre Platz für viele Blätter, aber es gibt nur dieses eine." CR>)
                     (T <TELL "Im offenen Schrank bleibt nur ein heller, blattförmiger Fleck, wo einmal ein Stück Papier lag." CR>)>)
              (T <TELL "Der Schrank ist aus dunklem Holz und hat eine kleine, geschlossene Tür. Vorne steht auf einem Messingschild: EIN TAG PRO PERSON." CR>)>)
       (<AND <VERB? PUT> <EQUAL? ,PRSI ,CASE> <EQUAL? ,PRSO ,LEAF>>
        <COND (<NOT <FSET? ,CASE ,OPENBIT>> <TELL "Öffne erst den Schrank." CR>)
              (T <MOVE ,LEAF ,CASE> <SETG ON-LOAN <>> <SETG WIDE-LOAN <>>
                 <TELL "Du gibst das Blatt zurück. Der Schrank faltet es wieder klein, und auf dem Boden erscheint der zweite Sonnenstreifen." CR>)>)
       (<VERB? READ>
        <TELL "Auf dem Messingschild steht: EIN TAG PRO PERSON. Darunter hat jemand viel kleiner eingeritzt: pro Person? Oder pro Stadt?" CR>)
       (<VERB? KNOCK>
        <COND (<AND <IN? ,LEAF ,CASE> <NOT <FSET? ,CASE ,OPENBIT>>>
               <TELL "Klopf, klopf. Drinnen verrutscht etwas Leichtes auf dem Regalboden, als würde sich ein Blatt zurechtlegen." CR>)
              (T <TELL "Klopf, klopf. Der Schrank klingt hohl." CR>)>)
       (<VERB? LISTEN>
        <COND (<IN? ,LEAF ,CASE> <TELL "Mit dem Ohr am Holz hörst du ein leises Rascheln, als würde sich jemand im Schlaf umdrehen." CR>)
              (T <TELL "Nichts. Der leere Schrank ist so still wie ein geschlossenes Buch." CR>)>)
       (<VERB? SMELL>
        <TELL "Zedernholz und altes Papier. So riecht eine Schublade, die jahrelang niemand geöffnet hat." CR>)
       (<AND <VERB? MOVE PUSH TAKE> <EQUAL? ,PRSO ,CASE>>
        <TELL "Du stemmst dich mit deinem ganzen Gewicht gegen den Schrank. Er ist viel zu schwer, und jemand hat ihn offensichtlich mit Absicht vors Fenster geschoben." CR>)
       (<VERB? LOOK-BEHIND>
        <TELL "Im Spalt entdeckst du einen Bleistiftstrich auf der Fensterbank. Genau hier musste der Schrank stehen, um das Licht von morgen aufzufangen." CR>)
       (<VERB? LOOK-UNDER>
        <TELL "Nur Staub und vier lange Schrammen von den Schrankfüßen, die bis zum Fenster führen." CR>)>>
<ROUTINE STRIPES-F ()
 <COND (<VERB? EXAMINE>
        <COND (,ON-LOAN <TELL "Der Sonnenstreifen von heute liegt gelb und ganz gewöhnlich auf dem Boden. Daneben, wo eben noch das schmale Gold von morgen war, sehen die Dielen grau und kalt aus." CR>)
              (T <TELL "Das Sonnenlicht von heute liegt als breiter gelber Streifen auf dem Boden. Daneben fällt durchs selbe Fenster ein schmalerer, tiefer goldener Streifen. Das muss morgen sein. Es leuchtet ein bisschen zu früh." CR>)>)
       (<VERB? RUB>
        <COND (,ON-LOAN <TELL "Du legst die Hand dorthin, wo der Streifen von morgen war. Der Boden ist kalt wie ein Platz, auf dem noch niemand gesessen hat." CR>)
              (T <TELL "Du hältst die Hand in den goldenen Streifen. Er ist wärmer als das Licht von heute, wie ein Versprechen, das jemand wirklich halten will." CR>)>)
       (<VERB? TAKE>
        <TELL "Du versuchst, Sonnenlicht mit beiden Händen zu schöpfen. Es liegt einfach oben auf deinen Händen. Licht lässt sich nicht in Stücke teilen." CR>)
       (<VERB? LOOK-INSIDE OPEN CLOSE>
        <TELL "Das große Fenster geht nicht auf. Dahinter siehst du die Dächer der Stadt, die alle zu warten scheinen." CR>)>>
<ROUTINE BOARD-F ()
 <COND (<AND <VERB? PUT-UNDER> <EQUAL? ,PRSO ,LEAF> <EQUAL? ,PRSI ,BOARD>>
        <TELL "Unter dem Brett kann sich kein Blatt entfalten. Du behältst das Morgenblatt in der Hand." CR>)
       (<VERB? EXAMINE READ>
        <SETG BOARD-READ T>
        <TELL "Ins Brett ist eingeritzt: LEG EIN BLATT MIT DER GOLDSEITE NACH OBEN AUF DAS BRETT. WENN DU DEINEN TAG TEILEN WILLST, STREICH DIE ALTEN FALTEN GLATT. Nirgends steht, dass du das nicht darfst.">
        <COND (<HELD? ,LEAF> <TELL " Du hältst das Morgenblatt in der Hand.">)>
        <CRLF>)
       (<AND <VERB? PUT PUT-ON> <EQUAL? ,PRSI ,BOARD> <EQUAL? ,PRSO ,LEAF>>
        <UNFOLD-LOAN>)
       (<VERB? RUB>
        <TELL "Tausend Hände haben die Kanten glatt gerieben, doch die Mitte fühlt sich noch rau und neu an. Seit Jahren falten die Leute hier Dinge zusammen. Auseinandergefaltet hat fast niemand etwas." CR>)
       (<VERB? KNOCK>
        <TELL "Tock. Gutes, festes Holz. Darauf würde ein ganzer Himmel aus Papier Platz finden." CR>)
       (<VERB? SMELL>
        <TELL "Bienenwachs und Sägespäne." CR>)
       (<VERB? LOOK-UNDER>
        <TELL "Das Brett steht auf vier kräftigen Beinen. Darunter ist nichts versteckt, bis auf ein paar Sägespäne." CR>)
       (<VERB? TAKE MOVE>
        <TELL "Das Brett ist so lang wie ein Bett und am Boden festgeschraubt. Es soll dort bleiben, wo alle es benutzen können." CR>)>>
<ROUTINE RECEIPT-F ()
 <COND (<VERB? EXAMINE READ>
        <SETG RECEIPT-READ T>
        <TELL "Auf dem alten Leihschein steht in sorgfältiger Schrift: WER DIE SONNE FÜR SICH ALLEIN LEIHT, NIMMT SIE DER STADT WEG. FÜR ALLE: SPANN EIN AUFGEFALTETES BLATT IN DEN LESERAHMEN UND LIES ES DORT VOR. Darunter hat jemand mit krakeliger Schrift ergänzt: Ich war zuerst da." CR>)
       (<VERB? TAKE MOVE>
        <TELL "Er sitzt fest. Er klebt schon so lange am Stein, dass er fast zur Wand gehört." CR>)
       (<VERB? RUB>
        <TELL "Das Papier ist dünn und kühl. Die krakelige Zeile unten ist tief eingedrückt. Da war wohl jemand wütend." CR>)
       (<VERB? SMELL>
        <TELL "Feuchter Stein und alte Tinte." CR>)>>
<ROUTINE RILL-F ()
 <COND (<VERB? EXAMINE>
        <COND (,ON-LOAN <TELL "Die Rinne ist ganz trocken. Es sieht aus, als wäre das Wasser stehen geblieben, umgekehrt und dahin zurückgeflossen, wo es herkam." CR>)
              (T <TELL "Eine lange Rinne aus Stein. Klares Wasser rinnt darin durch einen Spalt in der Wand hinunter zum Markt." CR>)>)
       (<VERB? LISTEN>
        <COND (,ON-LOAN <TELL "Gar nichts. Der Stein klingt hohl wie eine leere Tasse." CR>)
              (T <TELL "Wasser rinnt durch die Rinne und weiter zum Markt. Es klingt wie Seiten, die jemand umblättert." CR>)>)
       (<VERB? RUB>
        <COND (,ON-LOAN <TELL "Der Stein ist staubtrocken und seltsam warm. Als würde er warten." CR>)
              (T <TELL "Das Wasser ist kühl. Es läuft über deine Finger und zieht sie sanft zum Markt hin." CR>)>)
       (<VERB? LOOK-INSIDE SEARCH>
        <COND (,ON-LOAN <TELL "Kein Tropfen, nicht einmal ein feuchter Fleck." CR>)
              (T <TELL "Dein Spiegelbild kräuselt sich im Wasser und eilt mit ihm zum Markt." CR>)>)
       (<VERB? DRINK DRINK-FROM>
        <COND (,ON-LOAN <TELL "Deine Lippen finden nur warmen, staubigen Stein. Seit du das Blatt ausgeliehen hast, fließt hier nichts mehr." CR>)
              (T <TELL "Ein Schluck schmeckt nach einem Apfel, den du noch gar nicht gegessen hast. Der Rest rinnt weiter zum Markt." CR>)>)
       (<VERB? SMELL>
        <TELL "Kalter Stein und Flusskraut." CR>)>>
<ROUTINE FRAME-F ()
 <COND (<VERB? EXAMINE>
        <TELL "Ein Gestell aus Messing mit zwei Klammern. Es hält ein Blatt so hoch, dass alle auf dem Markt es sehen können. Die Klammern stehen weit auseinander. Ein gewöhnliches gefaltetes Blatt ist viel zu klein dafür.">
        <COND (<IN? ,LEAF ,FRAME> <TELL " Das Morgenblatt reicht bis zu beiden.">)
              (<AND <HELD? ,LEAF> ,WIDE-LOAN> <TELL " Das breite Morgenblatt könnte bis zu beiden reichen.">)>
        <CRLF>)
       (<VERB? READ>
        <COND (<IN? ,LEAF ,FRAME> <PUBLISH-LOAN>)
              (T <TELL "Im Rahmen steckt noch kein Blatt." CR>)>)
       (<AND <VERB? PUT PUT-ON> <EQUAL? ,PRSO ,LEAF> <EQUAL? ,PRSI ,FRAME>>
        <COND (,WIDE-LOAN <MOVE ,LEAF ,FRAME> <FSET ,LEAF ,NDESCBIT> <TELL "Du klemmst das breite Blatt ein. Beide Klammern halten, und das Morgenblatt zeigt hinaus über die Dächer der Stadt." CR>)
              (T <TELL "Du versuchst, das Blatt einzuklemmen. So zusammengefaltet ist es viel zu klein: Es reicht nicht bis zur zweiten Klammer. Du behältst es in der Hand." CR>)>)
       (<VERB? RUB>
        <TELL "Das Messing ist sonnenwarm, und die Klammern schnappen mit einem munteren Klick zu." CR>)
       (<VERB? MOVE PUSH>
        <TELL "Der Rahmen schwenkt ein wenig auf seinem Fuß und dreht sich gleich wieder zum Markt. Er weiß, für wen er da ist." CR>)
       (<VERB? KNOCK>
        <TELL "Kling! Das Messing klingt weit übers Geländer hinaus. Tief unten schaut eine Taube hoch." CR>)
       (<VERB? LOOK-INSIDE SEARCH>
        <COND (<IN? ,LEAF ,FRAME> <TELL "Die Klammern fassen nur die Ecken. Die goldene Mitte des Blatts bleibt frei; von unten können alle mitlesen." CR>)
              (T <TELL "Du beugst dich vor. Durch den leeren Rahmen ist der ganze Markt so klein wie ein gemaltes Bild." CR>)>)
       (<AND <VERB? TAKE> <EQUAL? ,PRSO ,FRAME>>
        <TELL "Der Rahmen ist an der Terrasse festgeschraubt. Er gehört hierher, wo ihn unten alle sehen können." CR>)>>
<ROUTINE MARKET-F ()
 <COND (<AND <VERB? EXAMINE> <NOT <EQUAL? ,HERE ,TERRACE>>>
        <TELL "Durch den Spalt in der Wand siehst du tief unten nur ein Stück vom Markt: die Ecke eines gestreiften Stands und einen Streifen vom Platz. Von der Leseterrasse aus könntest du viel mehr sehen." CR>)
       (<VERB? EXAMINE>
        <COND (,ON-LOAN <TELL "Von hier siehst du den ganzen Markt. Niemand packt ein, und niemand stellt etwas Neues auf. Die Bäckerin steht mit einem Stuhl in der Tür, als wüsste sie nicht, ob es ein Morgen geben wird, für das sie ihn hinausstellen kann." CR>)
              (T <TELL "Von hier siehst du den ganzen Markt: gestreifte Stände, Körbe mit Äpfeln, die offene Tür der Bäckerei und Leute, die vor dem Abend fertig werden wollen." CR>)>)
       (<VERB? LISTEN>
        <COND (,ON-LOAN <TELL "Der Markt ist seltsam still geworden. Ganz leise hörst du die Leute einander fragen, welcher Tag wohl als Nächstes kommt." CR>)
              (T <TELL "Vom Markt dringen Rufe und Lachen herauf, das Knarren von Karren und jemand, der den Preis für Pflaumen ausruft." CR>)>)
       (<VERB? SMELL>
        <TELL "Der Duft von warmem Brot zieht aus der Bäckerei bis hier oben herauf. Dein Magen knurrt." CR>)
       (<VERB? TAKE>
        <TELL "Der Markt liegt tief unter dir und ist viel zu groß zum Tragen. Was er braucht, ist etwas zum Lesen." CR>)>>
<ROUTINE HALL-ROOM-F ()
 <COND (<VERB? EXAMINE>
        <TELL "Die Ausleihhalle ist hoch und still. Der Holzboden glänzt, und die Regale reichen bis hoch in den Schatten. Jedes Regal ist leer. Alles, was diese Bibliothek noch verleihen kann, liegt im Schrank am Fenster." CR>)
       (<VERB? LISTEN>
        <TELL "Es ist so still, dass du den Staub zu Boden sinken hörst. Weit weg tickt eine Uhr und scheint vor dem nächsten Ticken zu zögern." CR>)
       (<VERB? SMELL>
        <TELL "Bohnerwachs und altes Papier. So riecht jede Bibliothek auf der Welt." CR>)>>
<ROUTINE FOLDING-ROOM-F ()
 <COND (<VERB? EXAMINE>
        <TELL "Ein kleiner, heller, kahler Raum mit weißen Wänden. In der Mitte steht das lange Faltbrett. Eine schmale Treppe führt hinauf zur Terrasse, ein Bogen zurück in die Halle." CR>)
       (<VERB? LISTEN>
        <COND (,ON-LOAN <TELL "Die Marktrufe sind verstummt. Von oben an der Treppe dringt nur eine Frage herab, leise wiederholt: Gibt es morgen früh Brot?" CR>)
              (T <TELL "Von oben an der Treppe dringt gedämpfter Marktlärm herab. Jemand ruft den Preis für Pflaumen aus, dann noch einmal ein bisschen billiger." CR>)>)
       (<VERB? SMELL>
        <TELL "Bienenwachs und Sonnenschein." CR>)>>
<ROUTINE BASIN-ROOM-F ()
 <COND (<VERB? EXAMINE>
        <TELL "Kahle Steinwände, kühl und ein wenig feucht. Die Rinne läuft durch einen niedrigen Spalt in Richtung Markt. Im Osten führt eine Tür auf die Terrasse." CR>)
       (<VERB? RUB>
        <TELL "Die Steinwand ist kühl und glatt. Jahrelang hat das Wasser sie poliert." CR>)
       (<VERB? LISTEN>
        <COND (,ON-LOAN <TELL "Im Raum ist es ganz still. Sogar dein eigener Atem klingt laut." CR>)
              (T <TELL "Die Rinne plätschert. Durch den Spalt hörst du den fernen Markt." CR>)>)>>
<ROUTINE TERRACE-ROOM-F ()
 <COND (<VERB? EXAMINE>
        <TELL "Die Terrasse ist ein breiter Steinbalkon mit einem Messinggeländer, hoch über den Dächern der Stadt. Unten liegen der Markt und der Platz, dahinter die Hügel." CR>)
       (<VERB? LOOK-UNDER>
        <TELL "Du spähst über das Geländer. Es geht tief hinunter bis zum Markt. Du hältst dich gut fest." CR>)
       (<VERB? RUB>
        <TELL "Das Messinggeländer ist sonnenwarm und glatt von vielen Händen." CR>)>>
<ROUTINE UNFOLD-LOAN ()
 <COND (,WIDE-LOAN <TELL "Du hast schon alle Falten geglättet." CR>)
       (T <SETG WIDE-LOAN T>
          <TELL "Auf dem Faltbrett streichst du die alten Falten aus dem Morgenblatt. Eine nach der anderen gibt nach, bis das kleine Quadrat so breit ist wie deine ausgebreiteten Arme. Dein Name steht noch in seiner Ecke, und daneben ist jetzt reichlich Platz. Du hebst das Blatt wieder hoch." CR>)>>

<ROUTINE LEAF-F ()
 <COND (<AND <VERB? TAKE> <IN? ,LEAF ,FRAME>>
        <COND (<ITAKE> <FCLEAR ,LEAF ,NDESCBIT>
               <TELL "Eine Klammer nach der anderen gibt nach. Du hältst das Blatt wieder in der Hand; unten wartet der Markt noch immer." CR>)
              (T <RTRUE>)>)
       (<VERB? UNFOLD-LOAN>
        <COND (<NOT <HELD? ,LEAF>> <TELL "Nimm das Blatt zuerst in die Hand." CR>)
              (<EQUAL? ,HERE ,FOLDING> <UNFOLD-LOAN>)
              (,WIDE-LOAN <TELL "Das Blatt ist schon weit offen; faltenfrei hältst du es kaum fest." CR>)
              (T <TELL "Eine Ecke federt gleich zurück. Zum Glattstreichen brauchst du das lange Brett im Faltraum." CR>)>)
       (<VERB? FOLD-LOAN>
        <COND (<NOT <HELD? ,LEAF>> <TELL "Nimm das Blatt erst wieder in die Hand." CR>)
              (,WIDE-LOAN <SETG WIDE-LOAN <>>
               <TELL "Du folgst den alten Falten. Kaum ist das Blatt wieder klein, rückt dein Name zurück in sein Kästchen." CR>)
              (T <TELL "Kleiner wird es nicht, ohne dass du auch deinen Namen zusammenfalten müsstest." CR>)>)
       (<VERB? THROW THROW-OFF OVERBOARD>
        <TELL "Du hältst das Blatt lieber fest. Morgen ist nichts, was man wegwirft." CR>)
       (<VERB? TEAR-LOAN>
        <TELL "An der Kante zittert ein goldener Riss. Du lässt los. Einen ganzen Tag klebt man nicht mit Klebeband wieder zusammen." CR>)
       (<AND <VERB? TAKE> <IN? ,LEAF ,CASE>>
        <COND (<FSET? ,CASE ,OPENBIT>
               <MOVE ,LEAF ,WINNER> <SETG ON-LOAN T>
               <TELL "Als du es heraushebst, trägt das Blatt deinen Namen ein. Er erscheint in Gold in dem kleinen Kästchen. Im selben Augenblick erlischt der schmale Streifen vom Sonnenlicht des nächsten Tages so sauber, dass du meinst, geblinzelt zu haben. Das Morgen ist jetzt ausgeliehen. An dich allein." CR>)>)
       (<VERB? EXAMINE>
        <COND (,WIDE-LOAN <TELL "Das goldene Blatt ist jetzt aufgefaltet, so breit wie deine ausgebreiteten Arme. In einer Ecke steht dein Name. Der Rest ist noch leer und wartet." CR>)
              (T <TELL "Ein kleines Blatt aus Goldpapier, immer wieder gefaltet, bis nur ein festes kleines Quadrat blieb. Vorne ist ein einziges Kästchen, gerade groß genug für einen Namen." CR>)>)
       (<VERB? READ>
        <COND (<IN? ,LEAF ,FRAME> <PUBLISH-LOAN>)
              (<IN? ,LEAF ,CASE> <TELL "Durch die offene Tür erkennst du das Wort MORGEN und ein Kästchen für einen Namen." CR>)
              (T <TELL "Unter deinem Namen steht in Gold: MORGEN. Du liest es leise. Nur du hörst es. Damit es unten ankommt, muss das Blatt in den Leserahmen." CR>)>)
       (<VERB? SMELL>
        <TELL "Es riecht wie die Luft kurz vor dem Morgen: kühl, frisch und ein bisschen nach Toast." CR>)
       (<VERB? LISTEN>
        <TELL "Am Ohr macht das Blatt winzige Geräusche: ein Hahn, ein Wasserkessel, jemand lacht. Die Geräusche von morgen, die warten, bis sie an der Reihe sind." CR>)
       (<VERB? RUB>
        <TELL "Das Papier ist warm, als hätte es schon in der Sonne von morgen gelegen." CR>)
       (<VERB? SHAKE>
        <COND (,WIDE-LOAN <TELL "Das breite Blatt flattert wie eine kleine Fahne. Für einen Augenblick spürst du einen Windhauch, der nach Morgen riecht." CR>)
              (T <TELL "Das feste kleine Quadrat flattert überhaupt nicht. Es ist viel zu straff gefaltet." CR>)>)>>
<ROUTINE PUBLISH-LOAN ()
 <SETG PUBLISHED-LOAN T>
 <TELL "Am Rahmen liest du das eine Wort auf dem Blatt laut vor, so deutlich du kannst: MORGEN. Das breite Blatt leuchtet. Unten auf dem Markt antworten hundert Namen, einer nach dem anderen, bis kein Platz mehr neben deinem Namen frei ist. Ein Karrenrad dreht sich endlich weiter. Die Schatten werden länger. Die Bäckerin stellt ihren Stuhl zwischen die Buden. »Bis morgen«, ruft sie wieder. Diesmal antworten die Leute von allen Seiten des Platzes." CR CR
       "ENDE – PLATZ FÜR JEDEN NAMEN" CR>
 <FINISH> <RTRUE>>
<ROUTINE V-SCORE ("OPTIONAL" (ASK? T))
 <COND (,PUBLISHED-LOAN <TELL "Ausleihbuch: Ein Tag wurde geteilt." CR>)
       (<IN? ,LEAF ,FRAME> <TELL "Ausleihbuch: Ein Tag ist zum Teilen bereit. Lies ihn am Leserahmen vor." CR>)
       (,ON-LOAN <TELL "Ausleihbuch: Ein Tag ist ausgeliehen." CR>)
       (T <TELL "Ausleihbuch: Zurzeit ist nichts ausgeliehen." CR>)>>

<ROUTINE V-FOLD-LOAN ()
 <TELL "Nur das Morgenblatt hat diese feinen alten Faltlinien." CR>>

<ROUTINE V-UNFOLD-LOAN ()
 <TELL "Glattstreichen musst du das Morgenblatt, nicht seine Unterlage." CR>>

<ROUTINE V-TEAR-LOAN ()
 <TELL "Was du hier findest, hat schon viele Jahre unversehrt überstanden. Lass es lieber so." CR>>
