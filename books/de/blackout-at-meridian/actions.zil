<ROUTINE V-VERSION () <TELL "Stromausfall in Meridian|Ein Superhelden-Abenteuer von AdventureArena, 2026|Ausgabe " N ,RELEASEID CR>>

;"The score is the hero: the name and the character sheet. FINISH prints it
  under every ending."
<ROUTINE V-SCORE ("OPTIONAL" (ASK? T))
 <TELL "Held: "> <HERO-PRINT-NAME>
 <COND (<0? ,HERO-CLASS> <TELL ", noch kein Profil angemeldet." CR> <RTRUE>)>
 <TELL " (" > <HERO-PRINT-CLASS> <TELL ")" CR> <HERO-SHEET>>

<ROUTINE GO ()
 <V-VERSION> <CRLF>
 <SETG HERE ,DISPATCH> <SETG VERBOSE T> <SETG LIT T>
 <SETG WINNER ,ADVENTURER> <SETG PLAYER ,WINNER> <MOVE ,WINNER ,HERE>
 <MOVE ,DOSSIER ,WINNER>
 <TELL "Um neun Uhr nahm der Sturm Meridian den Strom, und dann besetzte jemand die Relaisstation, die ihn zur%uckbringen sollte. Eine Wachdrohne h%alt die Station nun besetzt, und auf der Meridian-Br%ucke h%angt eine Stra%senbahn voller Fahrg%aste an einem gerissenen Kabel %uber dem Fluss. Du bist der neueste Held der Stadt, und heute Nacht ist dein erster Einsatz. Melde dich in der Leitstelle mit einem Profil an und geh dann zur Br%ucke. (Tippe jederzeit HILFE, um zu erfahren, wie das Spiel geht.)" CR CR>
 ;"The German V-LOOK prints the room name itself."
 <V-LOOK> <MAIN-LOOP> <AGAIN>>

;"HILFE is already a synonym of the world's TIP (wave to someone); the
  one-word form is the book's help."
<SYNTAX TIP = V-BOOK-HELP>
<SYNONYM TIP TIPE TIPS HILFE HILF TIPP TIPPS HINWEIS>
<SYNTAX NUTZ OBJECT = V-USE>
<SYNONYM NUTZ NUTZE VERWEND VERWENDE>
<SYNONYM REIB BERUEHR BER\%UHR BERUEHRE BER\%UHRE>
<SYNTAX HOER = V-BOOK-LISTEN>
<SYNTAX HOER ZU = V-BOOK-LISTEN>

<ROUTINE V-BOOK-HELP ()
 <TELL "Tippe Befehle wie SCHAU, UNTERSUCHE TAFEL oder NORD, oder w%ahle die verlinkten W%orter. Jede Heldentat w%urfelt W100 gegen einen deiner R%ange, und h%ohere W%urfe sind besser. Ein Fehlschlag kostet Gesundheit, und bei 0 Gesundheit ist deine Nacht vorbei. LIES BOGEN zeigt deine R%ange, ZUSTAND deine Gesundheit und dein Karma, und NENNE BOGEN gibt deinem Helden einen Namen." CR>
 <COND (<0? ,HERO-CLASS> <TELL "Jetzt gerade: Untersuche die Profile an der Einsatztafel und W%AHLE FELS, BLITZ oder LUCHS." CR>)
       (<NOT ,RESCUED> <TELL "Jetzt gerade: Geh nach Norden zur Br%ucke und RETTE die FAHRG%ASTE." CR>)
       (T <TELL "Jetzt gerade: In der Relaisstation kannst du die DROHNE ANGREIFEN oder das PULT DEAKTIVIEREN. BENUTZE KASTEN stellt einmal bis zu 20 Gesundheit wieder her, f%ur 10 Karma." CR>)>>

;"The world's BENUTZ also lands here. The objects answer USE themselves."
<ROUTINE V-USE () <TELL "Sag genauer, was du mit " DER-DAT ,PRSO " tun willst." CR>>

<ROUTINE V-BOOK-LISTEN ()
 <COND (<EQUAL? ,HERE ,DISPATCH> <TELL "Nur der Regen am Glas." CR>)
       (<EQUAL? ,HERE ,BRIDGE> <TELL "Regen, Wind und das Kabel, das %uber dem Fluss knarrt." CR>)
       (,DISABLED <TELL "Das tiefe Brummen des Pults, sonst nichts." CR>)
       (T <TELL "Das tiefe Brummen des Pults und das hohe Surren der Drohnenrotoren." CR>)>>

;"READ stores the reply lowercase, so the name is capitalised word by word.
  A line with characters outside printable ASCII is refused rather than
  stored half; a blank line keeps the current name."
<ROUTINE HERO-NAME-STATUS ("AUX" (I 1) C (STATUS 1))
 <REPEAT ()
  <SET C <GETB ,P-INBUF .I>>
  <COND (<OR <0? .C> <G? .I 119>> <RETURN>)
        (<OR <L? .C 32> <G? .C 126>> <SET STATUS 0> <RETURN>)
        (<N==? .C 32> <SET STATUS 2>)>
  <SET I <+ .I 1>>>
 .STATUS>

;"Spaces are collapsed, and a name longer than the table is cut at the last
  whole word that fits."
<ROUTINE HERO-COPY-NAME ("AUX" (I 1) (J 0) C (CAP T) (SPACE 0))
 <REPEAT ()
  <SET C <GETB ,P-INBUF .I>>
  <COND (<OR <0? .C> <G? .I 119>> <RETURN>)
        (<G? .J 31>
         <COND (<AND <N==? .C 32> <G? .SPACE 0>> <SET J .SPACE>)>
         <RETURN>)>
  <COND (<AND <==? .C 32> <OR <0? .J> <==? <GETB ,HERO-NAME <- .J 1>> 32>>>)
        (T
         <COND (<==? .C 32> <SET SPACE .J>)>
         <COND (<AND .CAP <NOT <L? .C 97>> <NOT <G? .C 122>>> <SET C <- .C 32>>)>
         <SET CAP <EQUAL? .C 32 45>>
         <PUTB ,HERO-NAME .J .C>
         <SET J <+ .J 1>>)>
  <SET I <+ .I 1>>>
 <COND (<AND <G? .J 0> <==? <GETB ,HERO-NAME <- .J 1>> 32>> <SET J <- .J 1>>)>
 <PUTB ,HERO-NAME .J 0>>

<ROUTINE HERO-PRINT-NAME ("AUX" (I 0) C)
 <COND (<0? <GETB ,HERO-NAME 0>> <TELL "Meridian"> <RTRUE>)>
 <REPEAT () <SET C <GETB ,HERO-NAME .I>> <COND (<OR <0? .C> <G? .I 31>> <RETURN>)>
  <PRINTC .C> <SET I <+ .I 1>>>>

<ROUTINE HERO-PRINT-CLASS ()
 <COND (<==? ,HERO-CLASS 1> <TELL "Fels">)
       (<==? ,HERO-CLASS 2> <TELL "Blitz">)
       (T <TELL "Luchs">)>>

;"Damage from a failed or answered action: the cost, then the Health left,
  then the ending if nothing is left."
<ROUTINE HERO-HURT (AMOUNT)
 <HERO-DAMAGE .AMOUNT 0>
 <TELL " (Gesundheit " N ,HERO-HEALTH " von " N ,HERO-MAX-HEALTH ".)" CR>
 <HERO-LOSS-CHECK>>

<ROUTINE HERO-LOSS-CHECK ()
 <COND (<0? ,HERO-HEALTH>
        <CRLF>
        <COND (<EQUAL? ,HERE ,RELAY> <TELL "Auf dem Betonboden geben deine Knie nach. Die Rettungsmannschaft zieht dich hinaus in den Regen, und hinter dir h%alt die Drohne weiter Wache %uber der dunklen Stadt.">)
              (T <TELL "Dein Griff l%ost sich, und du st%urzt gegen die Schienen. Die Mannschaft holt die Fahrg%aste ohne dich herunter und tr%agt dich in ihrem Netz von der Br%ucke.">)>
        <TELL " Meridian braucht heute Nacht einen anderen Helden." CR CR "ENDE: AUS DEM STURM GETRAGEN" CR CR>
        <FINISH>)>>

;"SPRING with nothing to jump is fatal in the base wherever RUNTER is a
  refusal string, as on the bridge; here it is only a thought."
<ROUTINE ROOM-BEG ()
 <COND (<AND <VERB? LEAP> <NOT ,PRSO>>
        <COND (<EQUAL? ,HERE ,BRIDGE> <TELL "Du blickst hinunter auf den Fluss und besinnst dich eines Besseren. Die Fahrg%aste brauchen dich hier oben." CR>)
              (T <TELL "Du wippst auf den Fersen, zu allem bereit." CR>)>)
       (<AND <VERB? SWIM> <NOT ,PRSO>> <PERFORM ,V?SWIM ,RIVER> <RTRUE>)>>



<ROUTINE DISPATCH-F (RARG)
 <COND (<EQUAL? .RARG ,M-BEG> <ROOM-BEG>)
       (<EQUAL? .RARG ,M-LOOK>
        <COND (<0? ,HERO-CLASS>
               <TELL "Du stehst in der Notleitstelle von Meridian, einem engen Raum, der mit Batteriestrom l%auft. Regen l%auft in silbernen Streifen am [[Fenster]] hinunter, und dahinter liegt die ganze [[Stadt]] im Dunkeln. An der [[Einsatztafel->tafel]] h%angen drei Heldenprofile: [[Fels]], [[Blitz]] und [[Luchs]]. W%ahle eines, und gib deinem Helden auf deinem [[Heldenbogen->bogen]] einen Namen, wenn du magst. Die T%ur zur Stra%se f%uhrt nach [[Norden->nord]] zur Meridian-Br%ucke.">)
              (T
               <TELL "Du stehst in der Notleitstelle von Meridian, einem engen Raum, der mit Batteriestrom l%auft. Regen l%auft in silbernen Streifen am [[Fenster]] hinunter, und dahinter liegt die ganze [[Stadt]] im Dunkeln. Dein Profil ist auf der [[Einsatztafel->tafel]] als aktiv markiert. Die T%ur zur Stra%se f%uhrt nach [[Norden->nord]] zur Meridian-Br%ucke.">)>
        <CRLF>)>>

<ROUTINE BRIDGE-F (RARG)
 <COND (<EQUAL? .RARG ,M-BEG> <ROOM-BEG>)
       (<EQUAL? .RARG ,M-LOOK>
        <TELL "Du stehst auf der Meridian-Br%ucke, mitten im Regen. ">
        <COND (,RESCUED <TELL "Die leere [[Stra%senbahn->bahn]] h%angt noch an ihrem [[Kabel]] durch die aufgerissenen [[Schienen]], aber ihre Fahrg%aste sind bei der [[Rettungsmannschaft->mannschaft]] unten in Sicherheit. Die [[Relaisstation->station]] steht am %ostlichen Ende der Br%ucke, ihre [[T%ur->tuer]] ist aufgebrochen, und der Weg nach [[Osten->ost]] ist frei.">)
              (T <TELL "Auf halber Strecke ist der vordere Wagen einer [[Stra%senbahn->bahn]] durch die [[Schienen]] gebrochen und h%angt %uber dem [[Fluss]], gehalten nur von einem durchh%angenden [[Kabel]]. Es sind noch Menschen darin. Unten wartet eine [[Rettungsmannschaft->mannschaft]] mit einem Netz. Die [[Relaisstation->station]] steht am %ostlichen Ende der Br%ucke, aber zuerst kommen die Fahrg%aste.">)>
        <TELL " Die Leitstelle liegt im [[S%uden->sued]]." CR>)>>

<ROUTINE RELAY-F (RARG)
 <COND (<EQUAL? .RARG ,M-BEG> <ROOM-BEG>)
       (<EQUAL? .RARG ,M-LOOK>
        <TELL "Du bist in der Relaisstation, einer Betonhalle, die vor gestohlener Energie brummt. Der ganze Strom von Meridian l%auft %uber das [[Schaltpult->pult]] am hinteren Ende. ">
        <COND (,DISABLED <TELL "Die [[Wachdrohne->drohne]] liegt dunkel davor am Boden. ">)
              (T <TELL "Eine [[Wachdrohne->drohne]] schwebt davor, ihr rotes Auge folgt dir. ">)>
        <COND (,BOOSTED <TELL "Der [[Notfallkasten->kasten]] h%angt offen und leer neben der [[T%ur->tuer]], die nach [[Westen->west]] zur%uck zur Br%ucke f%uhrt." CR>)
              (T <TELL "Ein [[Notfallkasten->kasten]] ist neben der [[T%ur->tuer]] an die Wand geklemmt, die nach [[Westen->west]] zur%uck zur Br%ucke f%uhrt." CR>)>)>>

<ROUTINE PROFILE-F ()
 <COND (<VERB? EXAMINE READ>
        <COND (<EQUAL? ,PRSO ,VANGUARD> <TELL "Fels ist f%ur schwere Rettungen und den Nahkampf gebaut: viel St%arke und Ausdauer, aber wenig Verstand. Gesundheit 120, Karma 26.">)
              (<EQUAL? ,PRSO ,ARC> <TELL "Blitz ist schnell und wirft Blitze: h%ochste Gewandtheit und Kraft, aber wenig St%arke. Gesundheit 90, Karma 50.">)
              (T <TELL "Luchs liest Maschinen wie ein Buch und lenkt Bewegungskr%afte: viel Verstand und Intuition, aber im Kampf zerbrechlich. Gesundheit 60, Karma 90.">)>
        <COND (<==? ,HERO-CLASS <PROFILE-CLASS ,PRSO>> <TELL " Das ist dein Profil.">)
              (<0? ,HERO-CLASS> <TELL " Um dieses Profil zu %ubernehmen, w%ahle es.">)>
        <CRLF> <RTRUE>)
       (<VERB? TAKE> <TELL "Die Karte bleibt an der Tafel. W%ahle sie, dann schickt die Leitstelle diesen Helden." CR>)
       (<VERB? HERO-CHOOSE USE>
        <COND (<NOT <0? ,HERO-CLASS>>
               <TELL "Du bist bereits als "> <HERO-PRINT-CLASS>
               <TELL " angemeldet. Mitten im Einsatz wechselt die Leitstelle den Helden nicht." CR> <RTRUE>)>
        <COND (<EQUAL? ,PRSO ,VANGUARD> <HERO-INIT 30 10 40 40 6 10 10 30>)
              (<EQUAL? ,PRSO ,ARC> <HERO-INIT 20 40 10 20 20 20 10 40>)
              (T <HERO-INIT 10 20 10 20 40 30 20 30>)>
        <SETG HERO-CLASS <PROFILE-CLASS ,PRSO>>
        <TELL "Die Leitstelle meldet dich als "> <HERO-PRINT-CLASS> <TELL " an. Deine R%ange:" CR>
        <HERO-SHEET>
        <TELL "Die Br%ucke liegt im [[Norden->nord]]." CR> <RTRUE>)
       (<VERB? HERO-STRIKE> <TELL "Die Einsatztafel zu zerrei%sen holt niemanden von der Br%ucke." CR>)>>

<ROUTINE PROFILE-CLASS (OBJ)
 <COND (<EQUAL? .OBJ ,VANGUARD> 1) (<EQUAL? .OBJ ,ARC> 2) (T 3)>>

<ROUTINE DUTY-BOARD-F ()
 <COND (<VERB? EXAMINE READ>
        <COND (<0? ,HERO-CLASS> <TELL "An der Tafel h%angen drei Profilkarten, eine f%ur jede Art von Held, die die Leitstelle schicken kann: [[Fels]], [[Blitz]] und [[Luchs]]." CR>)
              (<==? ,HERO-CLASS 1> <TELL "Die [[Fels]]-Karte ist mit rotem Stift als AKTIV markiert. Die Karten [[Blitz]] und [[Luchs]] warten auf eine andere Nacht." CR>)
              (<==? ,HERO-CLASS 2> <TELL "Die [[Blitz]]-Karte ist mit rotem Stift als AKTIV markiert. Die Karten [[Fels]] und [[Luchs]] warten auf eine andere Nacht." CR>)
              (T <TELL "Die [[Luchs]]-Karte ist mit rotem Stift als AKTIV markiert. Die Karten [[Fels]] und [[Blitz]] warten auf eine andere Nacht." CR>)>)
       (<VERB? TAKE MOVE PUSH> <TELL "Die Tafel ist an die Wand geschraubt. Auf die Karten kommt es an." CR>)
       (<VERB? HERO-STRIKE> <TELL "Die Einsatztafel zu zerrei%sen holt niemanden von der Br%ucke." CR>)>>

<ROUTINE WINDOW-F ()
 <COND (<VERB? EXAMINE LOOK-INSIDE>
        <TELL "Durch das regennasse Glas ist die Stadt ein schwarzer Schatten unter den Wolken. Drau%sen %uber dem Fluss schwingt das rote Warnlicht einer festgefahrenen [[Stra%senbahn->bahn]] im Wind." CR>)
       (<VERB? OPEN> <TELL "Das Fenster ist zugestrichen, und der Sturm kann drau%sen bleiben." CR>)
       (<VERB? CLOSE> <TELL "Es ist schon zu." CR>)
       (<VERB? RUB> <TELL "Das Glas ist kalt. Der Regen ist auf der anderen Seite." CR>)
       (<VERB? HERO-STRIKE> <TELL "Die Leitstelle hat heute Nacht schon genug zu reparieren." CR>)>>

<ROUTINE SHEET-F ()
 <COND (<VERB? EXAMINE READ>
        <TELL "Held: "> <HERO-PRINT-NAME>
        <COND (<0? ,HERO-CLASS> <TELL CR "Noch kein Profil angemeldet. W%ahle an der Einsatztafel [[Fels]], [[Blitz]] oder [[Luchs]]." CR> <RTRUE>)>
        <TELL " (" > <HERO-PRINT-CLASS> <TELL ")" CR> <HERO-SHEET> <RTRUE>)
       (<VERB? HERO-NAME>
        <TELL "Gib den Namen deines Helden ein (bis zu 32 einfache Buchstaben, Ziffern oder Satzzeichen)." CR>
        <READ ,P-INBUF ,P-LEXV>
        <COND (<0? <HERO-NAME-STATUS>> <TELL "Die Einsatztafel zeigt nur einfache Buchstaben, Ziffern und Satzzeichen, also keine Umlaute. Dein Name bleibt "> <HERO-PRINT-NAME> <TELL "." CR>)
              (<==? <HERO-NAME-STATUS> 1> <TELL "Kein Name eingegeben. Die Leitstelle nennt dich weiter "> <HERO-PRINT-NAME> <TELL "." CR>)
              (T <HERO-COPY-NAME> <TELL "Name des Helden eingetragen: "> <HERO-PRINT-NAME> <CRLF>)>
        <RTRUE>)
       (<VERB? DROP PUT PUT-ON GIVE THROW>
        <TELL "Du beh%altst deinen Heldenbogen. Die Leitstelle braucht ihn, um zu wissen, wer du bist." CR>)
       (<VERB? HERO-STRIKE> <TELL "Dein Bogen ist der einzige Papierkram, den du heute Nacht hast. Halte ihn heil." CR>)>>

<ROUTINE HERO-RESCUE-RANK ()
 <COND (<==? ,HERO-CLASS 1> <TELL "St%arkeprobe. "> ,HERO-STRENGTH)
       (<==? ,HERO-CLASS 2> <TELL "Gewandtheitsprobe. "> ,HERO-AGILITY)
       (T <TELL "Kraftprobe. "> ,HERO-POWER)>>

<ROUTINE TRAM-F ()
 <COND (<VERB? EXAMINE LOOK-INSIDE>
        <COND (,RESCUED <TELL "Der leere Wagen knarrt an seinem Kabel. Es ist niemand mehr darin." CR>)
              (T <TELL "Der vordere Wagen ist aus den Schienen gesprungen und h%angt mit der Nase nach unten %uber dem Fluss. Nur das [[Kabel]] h%alt ihn. Es sind noch Menschen darin, die dir zuwinken." CR>)>)
       (<VERB? LISTEN>
        <COND (,RESCUED <TELL "Nur das Kabel, das knarrt." CR>)
              (T <TELL "%Uber dem Regen h%orst du ein Kind weinen und jemanden, der laut z%ahlt, um ruhig zu bleiben." CR>)>)
       (<VERB? PUSH> <TELL "St%o%st du sie an, st%urzt sie ab. Die Fahrg%aste m%ussen gehalten werden, nicht gesto%sen." CR>)
       (<VERB? HERO-STRIKE> <TELL "Da sind Leute drin." CR>)
       (<VERB? HERO-RESCUE MOVE RAISE CLIMB-ON CLIMB-FOO THROUGH TAKE USE>
        <COND (<0? ,HERO-CLASS> <TELL "Melde dich zuerst in der Leitstelle mit einem Profil an." CR> <RTRUE>)>
        <COND (,RESCUED <TELL "Alle sind schon in Sicherheit." CR>)
              (<HERO-CHECK <HERO-RESCUE-RANK> 1>
               <SETG RESCUED T> <HERO-REWARD 10>
               <TELL "Du stabilisierst den Wagen und reichst die Fahrg%aste einen nach dem anderen hinunter ins Netz der Mannschaft. Der Letzte, ein Junge im gelben Regenmantel, l%asst deine Hand erst los, als er wieder festen Boden unter den F%u%sen hat. (Karma +10.) Der Weg nach [[Osten->ost]] zur Relaisstation ist frei." CR>)
              (T <TELL "Das Kabel rutscht, und der Wagen ruckt. Du steckst einen Schlag ein, aber das Netz der Mannschaft unten h%alt."> <HERO-HURT 5>)>
        <RTRUE>)>>

<ROUTINE CREW-F ()
 <COND (<VERB? EXAMINE>
        <COND (,RESCUED <TELL "Die Mannschaft wickelt die Fahrg%aste am Ufer in Rettungsdecken. Die Chefin zeigt dir den Daumen nach oben." CR>)
              (T <TELL "Feuerwehrleute in gelben M%anteln stehen unter der Br%ucke mit einem Netz und rufen dir durch den Regen etwas zu." CR>)>)
       (<VERB? TELL HELLO ANSWER YELL>
        <COND (,RESCUED <TELL "Die Chefin ruft herauf: %>Alle sind drau%sen! Die Drohne kam von der Relaisstation. Geh und schalte sie ab!%<" CR>)
              (T <TELL "Die Chefin formt die H%ande vor dem Mund: %>Wir fangen sie auf, aber das Kabel h%alt nicht mehr lange. Hol sie raus!%<" CR>)>
        <SETG P-CONT <>> <SETG QUOTE-FLAG <>> <RTRUE>)
       (<VERB? HERO-STRIKE> <TELL "Die sind auf deiner Seite." CR>)
       (<VERB? LISTEN> <TELL "Funkger%ate knacken, und jemand z%ahlt die Dr%ahte, die am Kabel noch %ubrig sind." CR>)>>

<ROUTINE RAILS-F ()
 <COND (<VERB? EXAMINE> <TELL "Die Stahlschienen sind nach au%sen verbogen, wo der Wagen durchgebrochen ist. Hinter der L%ucke gibt es nur Regen und den Fluss." CR>)
       (<VERB? LEAP> <PERFORM ,V?SWIM ,RIVER> <RTRUE>)
       (<VERB? CLIMB-ON CLIMB-FOO CLIMB-UP> <TELL "Du beugst dich %uber die L%ucke. Bis hinunter zum Fluss ist es tief." CR>)
       (<VERB? TAKE MOVE PUSH RAISE> <TELL "Die Schienen sind in die Br%ucke geschraubt und nicht mehr zu retten." CR>)
       (<VERB? RUB> <TELL "Kalter, nasser Stahl, der noch von der Last des Wagens summt." CR>)
       (<VERB? HERO-STRIKE> <TELL "Die Schienen haben heute Nacht genug abbekommen." CR>)>>

<ROUTINE CABLE-F ()
 <COND (<VERB? EXAMINE>
        <COND (,RESCUED <TELL "Jetzt, wo der Wagen leer ist, singt das Kabel nicht mehr im Wind." CR>)
              (T <TELL "Das Kabel h%angt unter dem Gewicht des Wagens durch. W%ahrend du hinsiehst, rei%st noch ein Draht." CR>)>)
       (<VERB? LISTEN> <TELL "Es knarrt und singt im Wind." CR>)
       (<VERB? RUB> <TELL "Es ist tot. Heute Nacht flie%st kein Strom hindurch, das einzige St%uck Gl%uck in diesem Sturm." CR>)
       (<VERB? HERO-STRIKE> <TELL "Dieses Kabel ist alles, was die Bahn h%alt." CR>)
       (<VERB? TAKE MOVE RAISE CLIMB-ON CLIMB-FOO CLIMB-UP HERO-RESCUE>
        <COND (,RESCUED <TELL "Das Kabel kann dort h%angen, bis die Stadt wieder Strom zum Reparieren hat." CR>)
              (T <PERFORM ,V?HERO-RESCUE ,TRAM>)>
        <RTRUE>)>>

;"A failed or answered strike lets the drone counter while it still flies."
<ROUTINE DRONE-F ()
 <COND (<VERB? EXAMINE>
        <COND (,DISABLED <TELL "Die Drohne liegt auf dem R%ucken, die Rotoren stehen still. Ihr rotes Auge ist erloschen." CR>)
              (T <TELL "Eine schwarze Wachdrohne, so gro%s wie eine Autot%ur, schwebt auf vier Rotoren. Ihr rotes Auge verfolgt jede deiner Bewegungen. Panzerung " N ,DRONE-HP " von 40." CR>)>)
       (<VERB? LISTEN>
        <COND (,DISABLED <TELL "Stille." CR>) (T <TELL "Ihre Rotoren surren hoch und gleichm%a%sig." CR>)>)
       (<VERB? TELL HELLO ANSWER YELL>
        <COND (,DISABLED <TELL "Sie sagt gar nichts." CR>)
              (T <TELL "Die Drohne antwortet mit einem Rauschen: %>SPERRGEBIET. VERLASSEN SIE SOFORT DEN RAUM.%<" CR>)>
        <SETG P-CONT <>> <SETG QUOTE-FLAG <>> <RTRUE>)
       (<VERB? TAKE RUB PUSH MOVE>
        <COND (,DISABLED <TELL "Sie ist schwerer, als sie aussieht, und die Polizei wird sie haben wollen. Lass sie liegen, wo sie gefallen ist." CR>)
              (T <TELL "Sie gleitet au%ser Reichweite, und ihr Auge leuchtet rot auf. Du m%usstest gegen sie k%ampfen." CR>)>)
       (<VERB? HERO-DISABLE>
        <COND (,DISABLED <TELL "Sie ist schon au%ser Gefecht." CR>) (T <PERFORM ,V?HERO-STRIKE ,DRONE>)> <RTRUE>)
       (<VERB? HERO-STRIKE>
        <COND (<0? ,HERO-CLASS> <TELL "Melde dich zuerst in der Leitstelle mit einem Profil an." CR> <RTRUE>)>
        <COND (,DISABLED <TELL "Die Drohne ist schon au%ser Gefecht." CR> <RTRUE>)>
        <TELL "Kampfprobe. ">
        <COND (<HERO-CHECK ,HERO-FIGHTING 1>
               <SETG DRONE-HP <- ,DRONE-HP ,HERO-POWER>>
               <COND (<NOT <G? ,DRONE-HP 0>>
                      <SETG DRONE-HP 0> <SETG DISABLED T> <HERO-REWARD 10>
                      <TELL "Die Drohne kracht auf den Boden, und ihr rotes Auge geht aus. (Karma +10.) Das [[Pult]] ist unbewacht." CR>)
                     (T <TELL "Dein Schlag sitzt, und die Drohne taumelt, aus einem Rotor spr%uhen Funken. Panzerung " N ,DRONE-HP " von 40." CR>)>)
              (T <TELL "Die Drohne weicht aus, und dein Schlag trifft nur Luft." CR>)>
        <COND (<NOT ,DISABLED> <TELL "Ihr Bet%aubungsstrahl trifft dich."> <HERO-HURT 10>)>
        <RTRUE>)>>

<ROUTINE CONSOLE-F ()
 <COND (<VERB? EXAMINE>
        <TELL "Eine Wand aus dunklen Bildschirmen rund um einen einzigen Handhebel zur Umgehung, die einzige Steuerung, die noch von Hand reagiert. Leg ihn um, und die Stadt bekommt ihren Strom zur%uck.">
        <COND (<NOT ,DISABLED> <TELL " Die Drohne schwebt zwischen dir und ihm.">)>
        <CRLF>)
       (<VERB? RUB LISTEN> <TELL "Es ist warm und zittert unter der Last, die es nicht tragen sollte." CR>)
       (<VERB? TAKE> <TELL "Es ist in den Beton geschraubt." CR>)
       (<VERB? HERO-STRIKE> <TELL "Schl%agst du das Pult kaputt, bleibt die Stadt wochenlang dunkel. Der Hebel reicht." CR>)
       (<VERB? HERO-DISABLE MOVE PUSH TURN OPEN USE>
        <COND (<0? ,HERO-CLASS> <TELL "Melde dich zuerst in der Leitstelle mit einem Profil an." CR> <RTRUE>)>
        <COND (<OR ,DISABLED <HERO-CHECK-REASON>>
               <SETG DISABLED T> <SETG DRONE-HP 0> <HERO-REWARD 20>
               <TELL "Du legst den Umgehungshebel um. Das Brummen der Halle sinkt zu einem Murmeln, die Bildschirme erwachen einer nach dem anderen, und das Relais kehrt zur %ortlichen Steuerung zur%uck. Auf der anderen Seite des Flusses geht in Meridian Stra%se f%ur Stra%se das Licht an. (Karma +20.)" CR CR "Dein Funkger%at knackt, und die Leitstelle ruft deinen Namen: ">
               <HERO-PRINT-NAME> <TELL ". Meridian ist gerettet." CR CR "ENDE: DIE LICHTER VON MERIDIAN" CR CR>
               <FINISH>)
              (T <TELL "Der Strahl der Drohne trifft dich, bevor du den Hebel erreichst."> <HERO-HURT 10>)>
        <RTRUE>)>>

<ROUTINE HERO-CHECK-REASON ()
 <TELL "Verstandsprobe, starker Erfolg n%otig. ">
 <HERO-CHECK ,HERO-REASON 2>>

<ROUTINE KIT-F ()
 <COND (<VERB? EXAMINE>
        <COND (,BOOSTED <TELL "Der Kasten h%angt offen und leer." CR>)
              (T <TELL "Ein roter Notfallkasten, an die Wand geklemmt. Er wirkt nur einmal, kostet 10 Karma und stellt bis zu 20 Gesundheit wieder her." CR>)>)
       (<VERB? TAKE> <TELL "Er ist an die Wand geklemmt. Benutze ihn dort, wo er h%angt." CR>)
       (<VERB? HERO-STRIKE> <TELL "Vielleicht brauchst du, was darin ist." CR>)
       (<VERB? HERO-FOCUS USE OPEN>
        <COND (<0? ,HERO-CLASS> <TELL "Melde dich zuerst in der Leitstelle mit einem Profil an." CR> <RTRUE>)>
        <COND (,BOOSTED <TELL "Der Kasten ist leer." CR>)
              (<NOT <L? ,HERO-HEALTH ,HERO-MAX-HEALTH>> <TELL "Du bist unverletzt. Heb dir den Kasten f%ur den Fall auf, dass du ihn brauchst." CR>)
              (<HERO-SPEND 10>
               <SETG BOOSTED T>
               <TELL "Du rei%st den Kasten auf und dr%uckst dir das Pflaster auf die Rippen. Du erholst dich um " N <HERO-HEAL 20> " Gesundheit. (Gesundheit " N ,HERO-HEALTH " von " N ,HERO-MAX-HEALTH ", Karma " N ,HERO-KARMA ".)" CR>)
              (T <TELL "Den Kasten zu aktivieren kostet 10 Karma, und du hast " N ,HERO-KARMA "." CR>)>
        <RTRUE>)>>

<ROUTINE RAIN-F ()
 <COND (<VERB? EXAMINE>
        <COND (<EQUAL? ,HERE ,DISPATCH> <TELL "Der Regen l%auft in silbernen Streifen am Fenster hinunter." CR>)
              (<EQUAL? ,HERE ,BRIDGE> <TELL "Der Regen kommt waagerecht %uber die Br%ucke, kalt genug, dass es sticht." CR>)
              (T <TELL "Der Regen trommelt auf das Betondach der Halle." CR>)>)
       (<VERB? LISTEN> <TELL "Ein gleichm%a%siges Rauschen, nur von Donner unterbrochen." CR>)
       (<VERB? SMELL> <TELL "Nasser Stein und der scharfe Geruch von verbranntem Kabel." CR>)
       (<VERB? TAKE RUB> <TELL "Er rinnt dir durch die Finger." CR>)>>

<ROUTINE CITY-F ()
 <COND (<VERB? EXAMINE> <TELL "Meridian liegt dunkel da, vom Fluss bis zu den H%ugeln: keine Stra%senlaternen, keine erleuchteten Fenster, nur der Sturm." CR>)
       (<VERB? LISTEN> <TELL "Autoalarme, weit weg, und sonst nichts als der Regen." CR>)>>

<ROUTINE RIVER-F ()
 <COND (<VERB? EXAMINE> <TELL "Der Fluss ist hoch und schnell, braun vom Sturm." CR>)
       (<VERB? SWIM LEAP THROUGH> <TELL "Die Str%omung w%urde dich in Sekunden unter die Br%ucke rei%sen. Die Stadt braucht dich trocken und lebendig." CR>)
       (<VERB? DRINK> <TELL "Nicht heute Nacht und auch sonst nie." CR>)
       (<VERB? LISTEN> <TELL "Er tost gegen die Pfeiler der Br%ucke." CR>)>>

<ROUTINE BRIDGE-SPAN-F ()
 <COND (<VERB? EXAMINE>
        <COND (<EQUAL? ,HERE ,DISPATCH> <TELL "Die Meridian-Br%ucke ist ein kurzes St%uck nach Norden durch den Regen." CR>)
              (<EQUAL? ,HERE ,BRIDGE> <TELL "Eine alte Stahlbr%ucke mit Schienen in der Mitte, die %uber den Fluss zur Relaisstation f%uhrt." CR>)
              (T <TELL "Durch die T%ur f%uhrt die Br%ucke nach Westen in den Regen." CR>)>)
       (<VERB? THROUGH CLIMB-ON WALK-TO>
        <COND (<EQUAL? ,HERE ,DISPATCH> <DO-WALK ,P?NORD>)
              (<EQUAL? ,HERE ,RELAY> <DO-WALK ,P?WEST>)
              (T <TELL "Du stehst darauf." CR>)>
        <RTRUE>)
       (<VERB? LEAP> <PERFORM ,V?SWIM ,RIVER> <RTRUE>)>>

<ROUTINE DISTANT-TRAM-F ()
 <COND (<VERB? EXAMINE> <TELL "Von hier aus ist es nur ein rotes Warnlicht, das %uber dem Fluss schwingt. Die Br%ucke liegt im [[Norden->nord]]." CR>)
       (<VERB? HERO-RESCUE> <TELL "Sie ist drau%sen auf der Br%ucke, im [[Norden->nord]]." CR>)>>

<ROUTINE STATION-F ()
 <COND (<VERB? EXAMINE>
        <COND (<EQUAL? ,HERE ,RELAY> <TELL "Du bist drin. Der ganze Strom der Stadt l%auft durch diese Halle." CR>)
              (T <TELL "Ein gedrungenes Betongeb%aude am %ostlichen Ende der Br%ucke, das vor Strom brummt, den es nicht haben d%urfte. Seine [[Stahlt%ur->tuer]] wurde aufgebrochen." CR>)>)
       (<VERB? THROUGH WALK-TO>
        <COND (<EQUAL? ,HERE ,RELAY> <TELL "Du bist schon drin." CR>) (T <DO-WALK ,P?OST>)>
        <RTRUE>)
       (<VERB? LISTEN> <TELL "Ein tiefes elektrisches Brummen, lauter als der Regen." CR>)>>

<ROUTINE STATION-DOOR-F ()
 <COND (<VERB? EXAMINE> <TELL "Die Stahlt%ur der Relaisstation wurde von innen aus dem Schloss gerissen." CR>)
       (<VERB? CLOSE LOCK> <TELL "Sie ist kaputt und geht nicht mehr zu." CR>)
       (<VERB? OPEN> <TELL "Sie ist schon offen und bleibt es auch." CR>)
       (<VERB? KNOCK> <TELL "Drinnen wird niemand antworten." CR>)
       (<VERB? THROUGH>
        <COND (<EQUAL? ,HERE ,RELAY> <DO-WALK ,P?WEST>) (T <DO-WALK ,P?OST>)>
        <RTRUE>)>>
