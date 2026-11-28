;"Optional German scene reactions. Only a single-object action is handled
  here; rescue, battle and character state otherwise stay in shared logic."
<ROUTINE EDITION-REACTION ()
 <COND (,PRSI <RFALSE>)
       (<EQUAL? ,PRSO ,WINDOW>
        <COND (<VERB? KNOCK>
               <TELL "Dreimal klopfst du gegen die Scheibe. Der Regen klopft ungerührt weiter, völlig aus dem Takt." CR>)
              (<VERB? LISTEN>
               <TELL "Am Glas klingt der Regen wie zerknülltes Papier. Dazwischen knistert leise das Funkgerät der Leitstelle." CR>)>)
       (<EQUAL? ,PRSO ,DUTY-BOARD>
        <COND (<VERB? LOOK-BEHIND>
               <TELL "Hinter der Tafel klebt ein vergilbtes Foto. Darauf ist dieselbe Brücke zu sehen, aber in jedem Fenster der Stadt brennt Licht." CR>)
              (<VERB? KNOCK>
               <TELL "Beim Klopfen klappern die drei Profilkarten. Jemand hat ihre Ecken mit Reißzwecken gesichert; die Leitstelle hat mit Sturm gerechnet." CR>)>)
       (<EQUAL? ,PRSO ,TRAM>
        <COND (<VERB? TAKE>
               <COND (,RESCUED <TELL "Die Mannschaft wird die leere Bahn bergen. Für dich ist der Weg zur Relaisstation frei." CR>)
                     (T <TELL "Den Wagen einfach hochzureißen wäre zu riskant. Wenn du die Fahrgäste rettest, kannst du sie einzeln ins Netz der Mannschaft bringen." CR>)>)
              (<VERB? KNOCK>
               <COND (,RESCUED <TELL "Im leeren Wagen klappert noch ein Haltegriff. Diesmal muss niemand antworten." CR>)
                     (T <TELL "Aus dem Wagen kommen zwei rasche Schläge zurück. Jemand hat verstanden, dass du da bist." CR>)>)>)
       (<EQUAL? ,PRSO ,RAILS>
        <COND (<VERB? LISTEN>
               <TELL "Ein tiefes Ticken wandert durch den Stahl, jedes Mal wenn der Wind den Wagen rüttelt." CR>)
              (<VERB? LOOK-UNDER>
               <TELL "Durch die Lücke unter der Schiene siehst du das nasse Netz der Mannschaft. Es hängt ein gutes Stück unter dir." CR>)>)
       (<EQUAL? ,PRSO ,CABLE>
        <COND (<VERB? SMELL>
               <TELL "Die Isolierung riecht nach heißem Gummi. Der Regen hat sie längst gekühlt, aber der Brandgeruch sitzt noch darin." CR>)>)
       (<EQUAL? ,PRSO ,SUPPLIES>
        <COND (<VERB? OPEN LOOK-INSIDE>
               <COND (,BOOSTED <TELL "Der Kasten ist offen und leer. Im Deckel steckt noch eine alte Gebrauchsanweisung." CR>)
                     (T <TELL "Im Kasten stecken ein Kältepack und ein versiegeltes Notfallpflaster. Das Siegel bleibt heil. Mit BENUTZE KASTEN entscheidest du, ob du die 10 Karma ausgeben willst." CR>)>)>)
       (<EQUAL? ,PRSO ,DRONE>
        <COND (<VERB? LOOK-UNDER>
               <COND (,DISABLED <TELL "Fast versteckt unter einem Rotor klebt ein Aufkleber: NUR BEI TROCKENEM WETTER BETREIBEN." CR>)
                     (T <TELL "In der dunklen Unterseite fährt ein zweites Auge mit. Du bleibst lieber auf Abstand." CR>)>)>)>>

<OBJECT DISPATCH-DOOR (IN DISPATCH) (DESC "Ausgangst%ur")
 (SYNONYM AUSGANGSTUER AUSGANGST\%UR T\%UR TUER)
 (FLAGS NDESCBIT DIEBIT) (ACTION DISPATCH-DOOR-F)>

<ROUTINE DISPATCH-DOOR-F ()
 <COND (<VERB? EXAMINE>
        <TELL "Unter der Ausgangstür drückt der Regen eine schmale Pfütze in die Leitstelle. Oben am Griff hängt ein gelbes Schild: BRÜCKE, NORDEN." CR>)
       (<VERB? OPEN>
        <COND (<0? ,HERO-CLASS> <TELL "Der Griff gibt erst nach, wenn du ein Profil gewählt hast." CR>)
              (T <TELL "Die Tür ruckt im Wind. Mit NORD gehst du hinaus zur Brücke." CR>)>)
       (<VERB? THROUGH WALK-TO> <WALK-TO-BRIDGE> <RTRUE>)
       (<VERB? KNOCK>
        <TELL "Der spröde Lack bröckelt unter deinem Knöchel. Hinter der Tür wartet nichts als Wetter." CR>)>>
