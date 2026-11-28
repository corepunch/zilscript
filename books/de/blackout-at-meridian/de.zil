;"Stromausfall in Meridian: the German edition's words. Objects and rooms
  merge with the declarations in logic.zil; the MSG-* routines are what the
  logic says. The German V-LOOK prints the room name itself."

;"HILFE is already a synonym of the world's TIP (wave to someone); the
  one-word form is the book's help."
<SYNTAX TIP = V-BOOK-HELP>
<SYNONYM TIP TIPE TIPS HILFE HILF TIPP TIPPS HINWEIS>
<SYNTAX NUTZ OBJECT = V-USE>
<SYNONYM NUTZ NUTZE VERWEND VERWENDE>
<SYNONYM REIB BERUEHR BER\%UHR BERUEHRE BER\%UHRE>
<SYNTAX HOER = V-BOOK-LISTEN>
<SYNTAX HOER ZU = V-BOOK-LISTEN>


<ROUTINE MSG-VERSION () <TELL "Stromausfall in Meridian|Ein Superhelden-Abenteuer von AdventureArena, 2026|Ausgabe " N ,RELEASEID CR>>

;"The German V-LOOK prints the room name itself, so the edition has nothing to set up."
<ROUTINE SETUP-EDITION () <RTRUE>>
<ROUTINE WALK-TO-BRIDGE ()
 <COND (<EQUAL? ,HERE ,DISPATCH> <DO-WALK ,P?NORD>) (T <DO-WALK ,P?WEST>)>>
<ROUTINE WALK-TO-RELAY () <DO-WALK ,P?OST>>


<ROUTINE MSG-SCORE-HERO ()
 <TELL "Held: ">>

<ROUTINE MSG-SCORE-UNREGISTERED ()
 <TELL ", noch kein Profil angemeldet." CR>>

<ROUTINE MSG-SCORE-OPEN-CLASS ()
 <TELL " (">>

<ROUTINE MSG-SCORE-CLOSE-CLASS ()
 <TELL ")" CR>>

<ROUTINE MSG-OPENING ()
 <TELL "Um neun Uhr ist in Meridian der Strom ausgefallen. Zehn Minuten sp%ater meldet der Verkehrsfunk eine Stra%senbahn, die an einem einzigen Kabel %uber dem Fluss h%angt. In der Relaisstation, von der aus sich das Netz wieder einschalten l%asst, steht jetzt eine fremde Wachdrohne. Du hast noch nie einen Einsatz geleitet. Geh jetzt zur Br%ucke. (Tippe jederzeit HILFE, um zu erfahren, wie das Spiel geht.)" CR CR>>

<ROUTINE MSG-HELP-HOW ()
 <TELL "Tippe Befehle wie SCHAU, UNTERSUCHE TAFEL oder NORD, oder w%ahle die verlinkten W%orter. Jede Heldentat w%urfelt W100 gegen einen deiner R%ange, und h%ohere W%urfe sind besser. Ein Fehlschlag kostet Gesundheit, und bei 0 Gesundheit ist deine Nacht vorbei. LIES BOGEN zeigt deine R%ange, ZUSTAND deine Gesundheit und dein Karma, und NENNE BOGEN gibt deinem Helden einen Namen." CR>>

<ROUTINE MSG-HELP-UNREGISTERED ()
 <TELL "Jetzt gerade: Untersuche die Profile an der Einsatztafel und W%AHLE FELS, BLITZ oder LUCHS." CR>>

<ROUTINE MSG-HELP-RESCUE ()
 <TELL "Jetzt gerade: Geh nach Norden zur Br%ucke und RETTE die FAHRG%ASTE." CR>>

<ROUTINE MSG-HELP-RELAY ()
 <TELL "Jetzt gerade: In der Relaisstation kannst du die DROHNE ANGREIFEN oder das PULT DEAKTIVIEREN. BENUTZE KASTEN stellt einmal bis zu 20 Gesundheit wieder her, f%ur 10 Karma." CR>>

<ROUTINE MSG-USE ()
 <TELL "Sag genauer, was du mit " DER-DAT ,PRSO " tun willst." CR>>

<ROUTINE MSG-LISTEN-DISPATCH ()
 <TELL "Nur der Regen am Glas." CR>>

<ROUTINE MSG-LISTEN-BRIDGE ()
 <TELL "Regen, Wind und das Kabel, das %uber dem Fluss knarrt." CR>>

<ROUTINE MSG-LISTEN-RELAY-DRONE-DOWN ()
 <TELL "Das tiefe Brummen des Pults, sonst nichts." CR>>

<ROUTINE MSG-LISTEN-RELAY ()
 <TELL "Das tiefe Brummen des Pults und das hohe Surren der Drohnenrotoren." CR>>

<ROUTINE MSG-DEFAULT-NAME ()
 <TELL "Meridian">>

<ROUTINE MSG-CLASS-BULWARK ()
 <TELL "Fels">>

<ROUTINE MSG-CLASS-ARC ()
 <TELL "Blitz">>

<ROUTINE MSG-CLASS-LENS ()
 <TELL "Luchs">>

<ROUTINE MSG-HERO-HURT (HEALTH MAX)
 <TELL " (Gesundheit " N .HEALTH " von " N .MAX ".)" CR>>

<ROUTINE MSG-LOSS-RELAY ()
 <TELL "Auf dem Betonboden geben deine Knie nach. Die Rettungsmannschaft zieht dich hinaus in den Regen, und hinter dir h%alt die Drohne weiter Wache %uber der dunklen Stadt.">>

<ROUTINE MSG-LOSS-BRIDGE ()
 <TELL "Dein Griff l%ost sich, und du st%urzt gegen die Schienen. Die Mannschaft holt die Fahrg%aste ohne dich herunter und tr%agt dich in ihrem Netz von der Br%ucke.">>

<ROUTINE MSG-LOSS-ENDING ()
 <TELL " Meridian braucht heute Nacht einen anderen Helden." CR CR "ENDE: AUS DEM STURM GETRAGEN" CR CR>>

<ROUTINE MSG-LEAP-BRIDGE ()
 <TELL "Du blickst hinunter auf den Fluss und besinnst dich eines Besseren. Die Fahrg%aste brauchen dich hier oben." CR>>

<ROUTINE MSG-LEAP-IDLE ()
 <TELL "Du wippst auf den Fersen, zu allem bereit." CR>>

<ROUTINE MSG-SETUP ()
 <TELL "Wähle deinen Helden: [[Fels]], [[Blitz]] oder [[Luchs]]. Du kannst die Profile zuerst untersuchen und deinem Helden auf dem [[Heldenbogen->bogen]] einen Namen geben. Mit der Wahl eines Profils beginnt der Einsatz." CR>>

<ROUTINE MSG-DISPATCH-LOOK-REGISTERED ()
 <TELL "In Meridians enger Notleitstelle brennt nur noch eine Batterielampe. Der Regen zieht silberne Streifen %ubers [[Fenster]], dahinter ist die [[Stadt]] dunkel. Dein Profil ist auf der [[Einsatztafel->tafel]] als aktiv markiert. Hinter der [[Ausgangst%ur->tuer]] geht es nach [[Norden->nord]] zur Meridian-Br%ucke.">>

<ROUTINE MSG-BRIDGE-LOOK-START ()
 <TELL "Auf der Meridian-Br%ucke treibt dir der Wind den Regen quer ins Gesicht. ">>

<ROUTINE MSG-BRIDGE-LOOK-RESCUED ()
 <TELL "Die leere [[Stra%senbahn->bahn]] h%angt noch an ihrem [[Kabel]] durch die aufgerissenen [[Schienen]], aber ihre Fahrg%aste sind bei der [[Rettungsmannschaft->mannschaft]] unten in Sicherheit. Die [[Relaisstation->station]] steht am %ostlichen Ende der Br%ucke, ihre [[T%ur->tuer]] ist aufgebrochen, und der Weg nach [[Osten->ost]] ist frei.">>

<ROUTINE MSG-BRIDGE-LOOK-HANGING ()
 <TELL "Auf halber Strecke ist der vordere Wagen einer [[Stra%senbahn->bahn]] durch die [[Schienen]] gebrochen und h%angt %uber dem [[Fluss]], gehalten nur von einem durchh%angenden [[Kabel]]. Es sind noch Menschen darin. Unten wartet eine [[Rettungsmannschaft->mannschaft]] mit einem Netz. Die [[Relaisstation->station]] steht am %ostlichen Ende der Br%ucke, aber zuerst kommen die Fahrg%aste.">>

<ROUTINE MSG-BRIDGE-LOOK-END ()
 <TELL " Die Leitstelle liegt im [[S%uden->sued]]." CR>>

<ROUTINE MSG-RELAY-LOOK-START ()
 <TELL "In der Betonhalle der Relaisstation sp%urst du das Brummen durch deine nassen Sohlen. Das [[Schaltpult->pult]] am hinteren Ende leitet Meridians Strom um. ">>

<ROUTINE MSG-RELAY-LOOK-DRONE-DOWN ()
 <TELL "Die [[Wachdrohne->drohne]] liegt dunkel davor am Boden. ">>

<ROUTINE MSG-RELAY-LOOK-DRONE-UP ()
 <TELL "Eine [[Wachdrohne->drohne]] schwebt davor, ihr rotes Auge folgt dir. ">>

<ROUTINE MSG-RELAY-LOOK-KIT-EMPTY ()
 <TELL "Der [[Notfallkasten->kasten]] h%angt offen und leer neben der [[T%ur->tuer]], die nach [[Westen->west]] zur%uck zur Br%ucke f%uhrt." CR>>

<ROUTINE MSG-RELAY-LOOK-KIT-FULL ()
 <TELL "Neben der [[T%ur->tuer]] im [[Westen->west]] h%angt ein [[Notfallkasten->kasten]]. Hinter der T%ur liegt die Br%ucke." CR>>

<ROUTINE MSG-PROFILE-VANGUARD ()
 <TELL "Fels ist f%ur schwere Rettungen und den Nahkampf gebaut: viel St%arke und Ausdauer, aber wenig Verstand. Gesundheit 120, Karma 26.">>

<ROUTINE MSG-PROFILE-ARC ()
 <TELL "Blitz ist schnell und wirft Blitze: h%ochste Gewandtheit und Kraft, aber wenig St%arke. Gesundheit 90, Karma 50.">>

<ROUTINE MSG-PROFILE-LENS ()
 <TELL "Luchs liest Maschinen wie ein Buch und lenkt Bewegungskr%afte: viel Verstand und Intuition, aber im Kampf zerbrechlich. Gesundheit 60, Karma 90.">>

<ROUTINE MSG-PROFILE-IS-YOURS ()
 <TELL " Das ist dein Profil.">>

<ROUTINE MSG-PROFILE-TO-CHOOSE ()
 <TELL " Um dieses Profil zu %ubernehmen, w%ahle es.">>

<ROUTINE MSG-PROFILE-TAKE ()
 <TELL "Die Karte bleibt an der Tafel. W%ahle sie, dann schickt die Leitstelle diesen Helden." CR>>

<ROUTINE MSG-CHOOSE-ALREADY-1 ()
 <TELL "Du bist bereits als ">>

<ROUTINE MSG-CHOOSE-ALREADY-2 ()
 <TELL " angemeldet. Mitten im Einsatz wechselt die Leitstelle den Helden nicht." CR>>

<ROUTINE MSG-CHOOSE-REGISTERED-1 ()
 <TELL "Die Leitstelle meldet dich als ">>

<ROUTINE MSG-CHOOSE-REGISTERED-2 ()
 <TELL " an. Deine R%ange:" CR>>


<ROUTINE MSG-PROFILE-ATTACK ()
 <TELL "Die Einsatztafel zu zerrei%sen holt niemanden von der Br%ucke." CR>>

<ROUTINE MSG-BOARD-LOOK-UNREGISTERED ()
 <TELL "An der Tafel h%angen drei Profilkarten, eine f%ur jede Art von Held, die die Leitstelle schicken kann: [[Fels]], [[Blitz]] und [[Luchs]]." CR>>

<ROUTINE MSG-BOARD-LOOK-BULWARK ()
 <TELL "Die [[Fels]]-Karte ist mit rotem Stift als AKTIV markiert. Die Karten [[Blitz]] und [[Luchs]] warten auf eine andere Nacht." CR>>

<ROUTINE MSG-BOARD-LOOK-ARC ()
 <TELL "Die [[Blitz]]-Karte ist mit rotem Stift als AKTIV markiert. Die Karten [[Fels]] und [[Luchs]] warten auf eine andere Nacht." CR>>

<ROUTINE MSG-BOARD-LOOK-LENS ()
 <TELL "Die [[Luchs]]-Karte ist mit rotem Stift als AKTIV markiert. Die Karten [[Fels]] und [[Blitz]] warten auf eine andere Nacht." CR>>

<ROUTINE MSG-DUTY-BOARD-TAKE ()
 <TELL "Die Tafel ist an die Wand geschraubt. Auf die Karten kommt es an." CR>>

<ROUTINE MSG-DUTY-BOARD-ATTACK ()
 <TELL "Die Einsatztafel zu zerrei%sen holt niemanden von der Br%ucke." CR>>

<ROUTINE MSG-WINDOW-EXAMINE ()
 <TELL "Durch das regennasse Glas ist die Stadt ein schwarzer Schatten unter den Wolken. Drau%sen %uber dem Fluss schwingt das rote [[Warnlicht->warnlicht]] einer festgefahrenen Stra%senbahn im Wind." CR>>

<ROUTINE MSG-WINDOW-OPEN ()
 <TELL "Das Fenster ist zugestrichen, und der Sturm kann drau%sen bleiben." CR>>

<ROUTINE MSG-WINDOW-CLOSE ()
 <TELL "Es ist schon zu." CR>>

<ROUTINE MSG-WINDOW-RUB ()
 <TELL "Das Glas ist kalt. Der Regen ist auf der anderen Seite." CR>>

<ROUTINE MSG-WINDOW-ATTACK ()
 <TELL "Die Leitstelle hat heute Nacht schon genug zu reparieren." CR>>

<ROUTINE MSG-SHEET-HERO ()
 <TELL "Held: ">>

<ROUTINE MSG-SHEET-UNREGISTERED ()
 <TELL CR "Noch kein Profil angemeldet. W%ahle an der Einsatztafel [[Fels]], [[Blitz]] oder [[Luchs]]." CR>>

<ROUTINE MSG-SHEET-OPEN-CLASS ()
 <TELL " (">>

<ROUTINE MSG-SHEET-CLOSE-CLASS ()
 <TELL ")" CR>>

<ROUTINE MSG-NAME-REFUSED-1 ()
 <TELL "Die Einsatztafel zeigt nur einfache Buchstaben, Ziffern und Satzzeichen, also keine Umlaute. Dein Name bleibt ">>

<ROUTINE MSG-NAME-REFUSED-2 ()
 <TELL "." CR>>

<ROUTINE MSG-NAME-BLANK-1 ()
 <TELL "Kein Name eingegeben. Die Leitstelle nennt dich weiter ">>

<ROUTINE MSG-NAME-BLANK-2 ()
 <TELL "." CR>>

<ROUTINE MSG-NAME-STORED ()
 <TELL "Name des Helden eingetragen: ">>

<ROUTINE MSG-SHEET-DROP ()
 <TELL "Du beh%altst deinen Heldenbogen. Die Leitstelle braucht ihn, um zu wissen, wer du bist." CR>>

<ROUTINE MSG-SHEET-ATTACK ()
 <TELL "Dein Bogen ist der einzige Papierkram, den du heute Nacht hast. Halte ihn heil." CR>>

<ROUTINE MSG-CHECK-STRENGTH ()
 <TELL "St%arkeprobe. ">>

<ROUTINE MSG-CHECK-AGILITY ()
 <TELL "Gewandtheitsprobe. ">>

<ROUTINE MSG-CHECK-POWER ()
 <TELL "Kraftprobe. ">>

<ROUTINE MSG-TRAM-EXAMINE-RESCUED ()
 <TELL "Der leere Wagen knarrt an seinem Kabel. Es ist niemand mehr darin." CR>>

<ROUTINE MSG-TRAM-EXAMINE ()
 <TELL "Der vordere Wagen ist aus den Schienen gesprungen und h%angt mit der Nase nach unten %uber dem Fluss. Nur das [[Kabel]] h%alt ihn. Es sind noch Menschen darin, die dir zuwinken." CR>>

<ROUTINE MSG-TRAM-LISTEN-RESCUED ()
 <TELL "Nur das Kabel, das knarrt." CR>>

<ROUTINE MSG-TRAM-LISTEN ()
 <TELL "%Uber dem Regen h%orst du ein Kind weinen und jemanden, der laut z%ahlt, um ruhig zu bleiben." CR>>

<ROUTINE MSG-TRAM-PUSH ()
 <TELL "St%o%st du sie an, st%urzt sie ab. Die Fahrg%aste m%ussen gehalten werden, nicht gesto%sen." CR>>

<ROUTINE MSG-TRAM-ATTACK ()
 <TELL "Da sind Leute drin." CR>>

<ROUTINE MSG-TRAM-TRY-RESCUE ()
 <TELL "Den Wagen einfach hochzureißen wäre zu riskant. Wenn du die Fahrgäste rettest, kannst du sie einzeln ins Netz der Mannschaft bringen." CR>>

<ROUTINE MSG-TRAM-RESCUE-UNREGISTERED ()
 <TELL "Melde dich zuerst in der Leitstelle mit einem Profil an." CR>>

<ROUTINE MSG-TRAM-RESCUE-RESCUED ()
 <TELL "Alle sind schon in Sicherheit." CR>>

<ROUTINE MSG-TRAM-RESCUED-NOW ()
 <TELL "Du stabilisierst den Wagen und reichst die Fahrg%aste einen nach dem anderen hinunter ins Netz der Mannschaft. Der Letzte, ein Junge im gelben Regenmantel, l%asst deine Hand erst los, als er wieder festen Boden unter den F%u%sen hat. (Karma +10.) Der Weg nach [[Osten->ost]] zur Relaisstation ist frei." CR>>

<ROUTINE MSG-TRAM-RESCUE-FAILED ()
 <TELL "Das Kabel rutscht, und der Wagen ruckt. Ein Fahrgast schreit auf; du steckst einen Schlag ein, aber unten spannt die Mannschaft ihr Netz. Du kannst die Rettung erneut versuchen.">>

<ROUTINE MSG-CREW-EXAMINE-RESCUED ()
 <TELL "Die Mannschaft wickelt die Fahrg%aste am Ufer in Rettungsdecken. Die Chefin zeigt dir den Daumen nach oben." CR>>

<ROUTINE MSG-CREW-EXAMINE ()
 <TELL "Feuerwehrleute in gelben M%anteln stehen unter der Br%ucke mit einem Netz und rufen dir durch den Regen etwas zu." CR>>

<ROUTINE MSG-CREW-TELL-RESCUED ()
 <TELL "Die Chefin ruft herauf: %>Alle sind drau%sen! Die Drohne kam von der Relaisstation. Geh und schalte sie ab!%<" CR>>

<ROUTINE MSG-CREW-TELL ()
 <TELL "Die Chefin formt die H%ande vor dem Mund: %>Wir fangen sie auf, aber das Kabel h%alt nicht mehr lange. Hol sie raus!%<" CR>>

<ROUTINE MSG-CREW-ATTACK ()
 <TELL "Die sind auf deiner Seite." CR>>

<ROUTINE MSG-CREW-LISTEN ()
 <TELL "Funkger%ate knacken, und jemand z%ahlt die Dr%ahte, die am Kabel noch %ubrig sind." CR>>

<ROUTINE MSG-RAILS-EXAMINE ()
 <TELL "Die Stahlschienen sind nach au%sen verbogen, wo der Wagen durchgebrochen ist. Hinter der L%ucke gibt es nur Regen und den Fluss." CR>>

<ROUTINE MSG-RAILS-CLIMB-ON ()
 <TELL "Du beugst dich %uber die L%ucke. Bis hinunter zum Fluss ist es tief." CR>>

<ROUTINE MSG-RAILS-TAKE ()
 <TELL "Die Schienen sind in die Br%ucke geschraubt und nicht mehr zu retten." CR>>

<ROUTINE MSG-RAILS-RUB ()
 <TELL "Kalter, nasser Stahl, der noch von der Last des Wagens summt." CR>>

<ROUTINE MSG-RAILS-ATTACK ()
 <TELL "Die Schienen haben heute Nacht genug abbekommen." CR>>

<ROUTINE MSG-CABLE-EXAMINE-RESCUED ()
 <TELL "Jetzt, wo der Wagen leer ist, singt das Kabel nicht mehr im Wind." CR>>

<ROUTINE MSG-CABLE-EXAMINE ()
 <TELL "Das Kabel h%angt unter dem Gewicht des Wagens durch. W%ahrend du hinsiehst, rei%st noch ein Draht." CR>>

<ROUTINE MSG-CABLE-LISTEN ()
 <TELL "Es knarrt und singt im Wind." CR>>

<ROUTINE MSG-CABLE-RUB ()
 <TELL "Es ist tot. Heute Nacht flie%st kein Strom hindurch, das einzige St%uck Gl%uck in diesem Sturm." CR>>

<ROUTINE MSG-CABLE-ATTACK ()
 <TELL "Dieses Kabel ist alles, was die Bahn h%alt." CR>>

<ROUTINE MSG-CABLE-TRY-RESCUE ()
 <TELL "Du lässt die Finger davon. An diesem Seil hängt der ganze Wagen über dem Fluss. Die Mannschaft kann die Fahrgäste auffangen, wenn du sie einzeln hinablässt." CR>>

<ROUTINE MSG-CABLE-TAKE-RESCUED ()
 <TELL "Das Kabel kann dort h%angen, bis die Stadt wieder Strom zum Reparieren hat." CR>>

<ROUTINE MSG-DRONE-EXAMINE-DISABLED ()
 <TELL "Die Drohne liegt auf dem R%ucken, die Rotoren stehen still. Ihr rotes Auge ist erloschen." CR>>

<ROUTINE MSG-DRONE-EXAMINE (INTEGRITY MAX)
 <TELL "Eine schwarze Wachdrohne, so gro%s wie eine Autot%ur, schwebt auf vier Rotoren. Ihr rotes Auge verfolgt jede deiner Bewegungen. Panzerung " N .INTEGRITY " von " N .MAX "." CR>>

<ROUTINE MSG-DRONE-LISTEN-DISABLED ()
 <TELL "Stille." CR>>

<ROUTINE MSG-DRONE-LISTEN ()
 <TELL "Ihre Rotoren surren hoch und gleichm%a%sig." CR>>

<ROUTINE MSG-DRONE-TELL-DISABLED ()
 <TELL "Sie sagt gar nichts." CR>>

<ROUTINE MSG-DRONE-TELL ()
 <TELL "Die Drohne antwortet mit einem Rauschen: %>SPERRGEBIET. VERLASSEN SIE SOFORT DEN RAUM.%<" CR>>

<ROUTINE MSG-DRONE-TAKE-DISABLED ()
 <TELL "Sie ist schwerer, als sie aussieht, und die Polizei wird sie haben wollen. Lass sie liegen, wo sie gefallen ist." CR>>

<ROUTINE MSG-DRONE-TAKE ()
 <TELL "Sie gleitet au%ser Reichweite, und ihr Auge leuchtet rot auf. Du m%usstest gegen sie k%ampfen." CR>>

<ROUTINE MSG-DRONE-DISABLE-DISABLED ()
 <TELL "Sie ist schon au%ser Gefecht." CR>>

<ROUTINE MSG-DRONE-ATTACK-UNREGISTERED ()
 <TELL "Melde dich zuerst in der Leitstelle mit einem Profil an." CR>>

<ROUTINE MSG-DRONE-ATTACK-DISABLED ()
 <TELL "Die Drohne ist schon au%ser Gefecht." CR>>

<ROUTINE MSG-DRONE-CHECK ()
 <TELL "Kampfprobe. ">>

<ROUTINE MSG-DRONE-DOWN ()
 <TELL "Die Drohne kracht auf den Boden, und ihr rotes Auge geht aus. (Karma +10.) Das [[Pult]] ist unbewacht." CR>>

<ROUTINE MSG-DRONE-HIT (INTEGRITY MAX)
 <TELL "Dein Schlag sitzt, und die Drohne taumelt, aus einem Rotor spr%uhen Funken. Panzerung " N .INTEGRITY " von " N .MAX "." CR>>

<ROUTINE MSG-DRONE-MISS ()
 <TELL "Die Drohne weicht aus, und dein Schlag trifft nur Luft." CR>>

<ROUTINE MSG-DRONE-COUNTER ()
 <TELL "Ihr Bet%aubungsstrahl trifft dich.">>

<ROUTINE MSG-CONSOLE-EXAMINE ()
 <TELL "Eine Wand aus dunklen Bildschirmen rund um einen einzigen Handhebel zur Umgehung, die einzige Steuerung, die noch von Hand reagiert. Leg ihn um, und die Stadt bekommt ihren Strom zur%uck.">>

<ROUTINE MSG-CONSOLE-EXAMINE-NOT-DISABLED ()
 <TELL " Die Drohne schwebt zwischen dir und ihm. Du kannst sie zuerst bek%ampfen und ihr Gegenfeuer riskieren oder mit einer Verstandesprobe direkt zum Hebel gelangen.">>

<ROUTINE MSG-CONSOLE-RUB ()
 <TELL "Es ist warm und zittert unter der Last, die es nicht tragen sollte." CR>>

<ROUTINE MSG-CONSOLE-TAKE ()
 <TELL "Es ist in den Beton geschraubt." CR>>

<ROUTINE MSG-CONSOLE-ATTACK ()
 <TELL "Schl%agst du das Pult kaputt, bleibt die Stadt wochenlang dunkel. Der Hebel reicht." CR>>

<ROUTINE MSG-CONSOLE-DISABLE-UNREGISTERED ()
 <TELL "Melde dich zuerst in der Leitstelle mit einem Profil an." CR>>

<ROUTINE MSG-CONSOLE-WIN-START ()
 <TELL "Du legst den Umgehungshebel um. Das Brummen der Halle sinkt zu einem Murmeln, die Bildschirme erwachen einer nach dem anderen, und das Relais kehrt zur %ortlichen Steuerung zur%uck. Auf der anderen Seite des Flusses geht in Meridian Stra%se f%ur Stra%se das Licht an. Auf der Br%ucke zeigt der Junge im gelben Regenmantel auf das erste erleuchtete Fenster, und die Rettungsmannschaft jubelt. (Karma +20.)" CR CR "Dein Funkger%at knackt, und die Leitstelle ruft deinen Namen: ">>

<ROUTINE MSG-CONSOLE-WIN-END ()
 <TELL ". Meridian ist gerettet." CR CR "ENDE: DIE LICHTER VON MERIDIAN" CR CR>>

<ROUTINE MSG-CONSOLE-COUNTER ()
 <TELL "Der Strahl der Drohne trifft dich, bevor du den Hebel erreichst.">>

<ROUTINE MSG-CHECK-REASON ()
 <TELL "Verstandsprobe. ">>

<ROUTINE MSG-KIT-EXAMINE-BOOSTED ()
 <TELL "Der Kasten h%angt offen und leer." CR>>

<ROUTINE MSG-KIT-EXAMINE ()
 <TELL "Ein roter Notfallkasten, an die Wand geklemmt. Er wirkt nur einmal, kostet 10 Karma und stellt bis zu 20 Gesundheit wieder her." CR>>

<ROUTINE MSG-KIT-OPEN ()
 <TELL "Im Kasten stecken ein Kältepack und ein versiegeltes Notfallpflaster. Das Siegel bleibt heil. Mit BENUTZE KASTEN entscheidest du, ob du die 10 Karma ausgeben willst." CR>>

<ROUTINE MSG-KIT-TAKE ()
 <TELL "Er ist an die Wand geklemmt. Benutze ihn dort, wo er h%angt." CR>>

<ROUTINE MSG-KIT-ATTACK ()
 <TELL "Vielleicht brauchst du, was darin ist." CR>>

<ROUTINE MSG-KIT-POWER-UNREGISTERED ()
 <TELL "Melde dich zuerst in der Leitstelle mit einem Profil an." CR>>

<ROUTINE MSG-KIT-POWER-BOOSTED ()
 <TELL "Der Kasten ist leer." CR>>

<ROUTINE MSG-KIT-UNHURT ()
 <TELL "Du bist unverletzt. Heb dir den Kasten f%ur den Fall auf, dass du ihn brauchst." CR>>

<ROUTINE MSG-KIT-USED (GAINED HEALTH MAX KARMA)
 <TELL "Du rei%st den Kasten auf und dr%uckst dir das Pflaster auf die Rippen. Du erholst dich um " N .GAINED " Gesundheit. (Gesundheit " N .HEALTH " von " N .MAX ", Karma " N .KARMA ".)" CR>>

<ROUTINE MSG-KIT-NO-KARMA (KARMA)
 <TELL "Den Kasten zu aktivieren kostet 10 Karma, und du hast " N .KARMA "." CR>>

<ROUTINE MSG-RAIN-DISPATCH ()
 <TELL "Der Regen l%auft in silbernen Streifen am Fenster hinunter." CR>>

<ROUTINE MSG-RAIN-BRIDGE ()
 <TELL "Der Regen kommt waagerecht %uber die Br%ucke, kalt genug, dass es sticht." CR>>

<ROUTINE MSG-RAIN-EXAMINE ()
 <TELL "Der Regen trommelt auf das Betondach der Halle." CR>>

<ROUTINE MSG-RAIN-LISTEN ()
 <TELL "Ein gleichm%a%siges Rauschen, nur von Donner unterbrochen." CR>>

<ROUTINE MSG-RAIN-SMELL ()
 <TELL "Nasser Stein und der scharfe Geruch von verbranntem Kabel." CR>>

<ROUTINE MSG-RAIN-TAKE ()
 <TELL "Er rinnt dir durch die Finger." CR>>

<ROUTINE MSG-CITY-EXAMINE ()
 <TELL "Meridian liegt dunkel da, vom Fluss bis zu den H%ugeln: keine Stra%senlaternen, keine erleuchteten Fenster, nur der Sturm." CR>>

<ROUTINE MSG-CITY-LISTEN ()
 <TELL "Autoalarme, weit weg, und sonst nichts als der Regen." CR>>

<ROUTINE MSG-RIVER-EXAMINE ()
 <TELL "Der Fluss ist hoch und schnell, braun vom Sturm." CR>>

<ROUTINE MSG-RIVER-SWIM ()
 <TELL "Die Str%omung w%urde dich in Sekunden unter die Br%ucke rei%sen. Die Stadt braucht dich trocken und lebendig." CR>>

<ROUTINE MSG-RIVER-DRINK ()
 <TELL "Nicht heute Nacht und auch sonst nie." CR>>

<ROUTINE MSG-RIVER-LISTEN ()
 <TELL "Er tost gegen die Pfeiler der Br%ucke." CR>>

<ROUTINE MSG-BRIDGE-SPAN-DISPATCH ()
 <TELL "Die Meridian-Br%ucke ist ein kurzes St%uck nach Norden durch den Regen." CR>>

<ROUTINE MSG-BRIDGE-SPAN-BRIDGE ()
 <TELL "Eine alte Stahlbr%ucke mit Schienen in der Mitte, die %uber den Fluss zur Relaisstation f%uhrt." CR>>

<ROUTINE MSG-BRIDGE-SPAN-EXAMINE ()
 <TELL "Durch die T%ur f%uhrt die Br%ucke nach Westen in den Regen." CR>>

<ROUTINE MSG-BRIDGE-SPAN-THROUGH ()
 <TELL "Du stehst darauf." CR>>

<ROUTINE MSG-DISTANT-TRAM-EXAMINE ()
 <TELL "Von hier aus ist es nur ein rotes Warnlicht, das %uber dem Fluss schwingt. Die Br%ucke liegt im [[Norden->nord]]." CR>>

<ROUTINE MSG-DISTANT-TRAM-RESCUE ()
 <TELL "Sie ist drau%sen auf der Br%ucke, im [[Norden->nord]]." CR>>

<ROUTINE MSG-STATION-INSIDE ()
 <TELL "Du bist drin. Der ganze Strom der Stadt l%auft durch diese Halle." CR>>

<ROUTINE MSG-STATION-EXAMINE ()
 <TELL "Ein gedrungenes Betongeb%aude am %ostlichen Ende der Br%ucke, das vor Strom brummt, den es nicht haben d%urfte. Seine [[Stahlt%ur->tuer]] wurde aufgebrochen." CR>>

<ROUTINE MSG-STATION-ALREADY-INSIDE ()
 <TELL "Du bist schon drin." CR>>

<ROUTINE MSG-STATION-LISTEN ()
 <TELL "Ein tiefes elektrisches Brummen, lauter als der Regen." CR>>

<ROUTINE MSG-STATION-DOOR-EXAMINE ()
 <TELL "Die Stahlt%ur der Relaisstation wurde von innen aus dem Schloss gerissen." CR>>

<ROUTINE MSG-STATION-DOOR-CLOSE ()
 <TELL "Sie ist kaputt und geht nicht mehr zu." CR>>

<ROUTINE MSG-STATION-DOOR-OPEN ()
 <TELL "Sie ist schon offen und bleibt es auch." CR>>

<ROUTINE MSG-STATION-DOOR-KNOCK ()
 <TELL "Drinnen wird niemand antworten." CR>>


<ROOM DISPATCH (DESC "Leitstelle") (NORD TO BRIDGE IF HERO-CLASS ELSE "Die Leitstelle schickt keinen unangemeldeten Helden in den Sturm. W%ahle zuerst ein Profil: Fels, Blitz oder Luchs.") (RAUS TO BRIDGE IF HERO-CLASS ELSE "Die Leitstelle schickt keinen unangemeldeten Helden in den Sturm. W%ahle zuerst ein Profil: Fels, Blitz oder Luchs.")>

<ROOM BRIDGE (DESC "Meridian-Br%ucke") (SUED TO DISPATCH) (OST TO RELAY IF RESCUED ELSE "Nicht, solange die Fahrg%aste %uber dem Fluss h%angen. Rette sie zuerst.") (RUNTER "Die Mannschaft sichert das Flussufer. Die Fahrg%aste brauchen dich hier oben.")>
<ROOM RELAY (DESC "Relaisstation") (WEST TO BRIDGE) (RAUS TO BRIDGE)>

<OBJECT VANGUARD (DESC "Fels-Karte") (SYNONYM KARTE PROFIL FELS FELSKARTE FELS-KARTE) (FLAGS DIEBIT)>
<OBJECT ARC (DESC "Blitz-Karte") (SYNONYM KARTE PROFIL BLITZ BLITZKARTE BLITZ-KARTE) (FLAGS DIEBIT)>

<OBJECT LENS (DESC "Luchs-Karte") (SYNONYM KARTE PROFIL LUCHS LUCHSKARTE LUCHS-KARTE) (FLAGS DIEBIT)>
<OBJECT DUTY-BOARD (DESC "Einsatztafel") (SYNONYM TAFEL EINSATZTAFEL BRETT) (FLAGS DIEBIT)>

<OBJECT WINDOW (DESC "Fenster") (SYNONYM FENSTER GLAS SCHEIBE) (FLAGS DASBIT)>
<OBJECT DOSSIER (DESC "Heldenbogen") (SYNONYM BOGEN HELDENBOGEN BLATT DOSSIER PAPIER) (FLAGS DERBIT)>

<OBJECT TRAM (DESC "Straßenbahn") (SYNONYM BAHN STRASSENBAHN STRAßENBAHN WAGEN FAHRGAESTE FAHRG\%ASTE FAHRGAST PASSAGIERE PASSAGIER LEUTE MENSCHEN) (FLAGS DIEBIT)>
<OBJECT CREW (DESC "Rettungsmannschaft") (SYNONYM MANNSCHAFT RETTUNGSMANNSCHAFT RETTER FEUERWEHR NETZ SPRUNGNETZ CHEFIN CHEF EINSATZLEITERIN) (FLAGS DIEBIT)>

<OBJECT RAILS (DESC "Schiene") (SYNONYM SCHIENE SCHIENEN GLEIS GLEISE GELAENDER GEL\%ANDER) (FLAGS DIEBIT)>
<OBJECT CABLE (DESC "Kabel") (SYNONYM KABEL KABELN DRAHT OBERLEITUNG SEIL) (FLAGS DASBIT)>

<OBJECT DRONE (DESC "Wachdrohne") (SYNONYM DROHNE DROHNEN WACHDROHNE AUGE ROBOTER) (FLAGS DIEBIT)>
<OBJECT CONSOLE (DESC "Schaltpult") (SYNONYM PULT SCHALTPULT KONSOLE HEBEL BILDSCHIRM BILDSCHIRME SCHIRME) (FLAGS DASBIT)>

<OBJECT SUPPLIES (DESC "Notfallkasten") (SYNONYM KASTEN NOTFALLKASTEN KIT KOFFER) (FLAGS DERBIT)>
<OBJECT RAIN (DESC "Regen") (SYNONYM REGEN STURM GEWITTER) (FLAGS DERBIT)>

<OBJECT CITY (DESC "Stadt") (SYNONYM STADT MERIDIAN HORIZONT STROM) (FLAGS DIEBIT)>
<OBJECT RIVER (DESC "Fluss") (SYNONYM FLUSS FLU\%SS STROEMUNG STR\%OMUNG WASSER) (FLAGS DERBIT)>

<OBJECT BRIDGE-SPAN (DESC "Brücke") (SYNONYM BRUECKE BRüCKE) (FLAGS DIEBIT)>
<OBJECT DISTANT-TRAM (DESC "Straßenbahn") (SYNONYM BAHN STRASSENBAHN STRAßENBAHN WARNLICHT LICHT) (FLAGS DIEBIT)>

<OBJECT STATION (DESC "Relaisstation") (SYNONYM STATION RELAISSTATION GEBAEUDE GEB\%AUDE HALLE) (FLAGS DIEBIT)>
<OBJECT STATION-DOOR (DESC "Stahltür") (SYNONYM TUER T\%UR STAHLTUER STAHLTüR TUERE T\%URE) (FLAGS DIEBIT)>

<ROUTINE SUGGEST-ACTIONS ()
 <COND (<EQUAL? ,HERE ,DISPATCH>
  <COND (<0? ,HERO-CLASS>
   <CHOICE "profile.bulwark" "W%ahle Fels" "waehle fels" ,CHOICE-INVESTIGATE 99>
   <CHOICE "profile.arc" "W%ahle Blitz" "waehle blitz" ,CHOICE-INVESTIGATE 98>
   <CHOICE "profile.lens" "W%ahle Luchs" "waehle luchs" ,CHOICE-INVESTIGATE 97>)
  (T <CHOICE "dispatch.go" "Zur Br%ucke gehen" "nord" ,CHOICE-INVESTIGATE 99>)>
  <CHOICE "dispatch.glass" "An die Fensterscheibe klopfen" "klopf an fenster" ,CHOICE-INTERACT 40>)
 (<EQUAL? ,HERE ,BRIDGE>
  <COND (,RESCUED <CHOICE "bridge.go" "In die Relaisstation gehen" "ost" ,CHOICE-INVESTIGATE 99>)
  (T <CHOICE "bridge.rescue" "Die Fahrg%aste retten" "rette bahn" ,CHOICE-INVESTIGATE 99>)>
  <CHOICE "bridge.signal" "An die Bahn klopfen" "klopf an bahn" ,CHOICE-INTERACT 40>
  <CHOICE "bridge.back" "Zur%uck zur Leitstelle" "sued" ,CHOICE-INVESTIGATE 80>)
 (<EQUAL? ,HERE ,RELAY>
  <COND (<NOT ,DISABLED> <CHOICE "relay.strike" "Die Drohne angreifen" "schlag drohne" ,CHOICE-INVESTIGATE 99>)>
  <CHOICE "relay.bypass" "Den Umgehungshebel umlegen" "deaktiviere pult" ,CHOICE-INVESTIGATE 98>
  <COND (<AND <NOT ,BOOSTED> <L? <STAT ,HERO ,A-HEALTH> <MAX-STAT ,HERO ,A-HEALTH>>> <CHOICE "relay.kit" "Den Notfallkasten benutzen" "benutze kasten" ,CHOICE-INVESTIGATE 95>)>
  <CHOICE "relay.inspect-kit" "In den Notfallkasten schauen" "schau in kasten" ,CHOICE-INVESTIGATE 42>
  <CHOICE "relay.back" "Zur%uck zur Br%ucke" "west" ,CHOICE-INVESTIGATE 80>)>
 <COND (<NOT <0? ,HERO-CLASS>> <CHOICE "hero.sheet" "Heldenbogen lesen" "lies bogen" ,CHOICE-INVESTIGATE 90>)>>
