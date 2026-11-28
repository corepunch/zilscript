<ROOM ADMISSIONS (IN ROOMS) (GLOBAL RELAY) (DESC "Eingangshalle") (FLAGS RLANDBIT ONBIT)
	(OST TO DEAD-LETTERS) (WEST TO QUIET-HALL) (NORD TO SIGNAL-BOOTH)
	(LDESC "Du stehst in der Eingangshalle des Museums der ungesendeten Signale. Das Licht ist gedimmt. Zu hören ist nur das ferne Summen der alten Relaisanlage. Hinter der [[Kasse]] liegt ein Stapel frisch gestempelter Eintrittskarten. Darüber glänzt eine blank polierte [[Messingtafel]]. Im [[Osten->ost]] geht es zur Galerie der unzustellbaren Briefe, im [[Westen->west]] zum Saal der Stille. Ein kurzer Gang führt nach [[Norden->nord]] in die Signalkabine.")>

<ROOM DEAD-LETTERS (IN ROOMS) (GLOBAL RELAY) (DESC "Galerie der unzustellbaren Briefe") (FLAGS RLANDBIT ONBIT)
	(WEST TO ADMISSIONS)
	(LDESC "Die Galerie der unzustellbaren Briefe ist ein langer, dämmriger Raum voller [[Glasvitrinen->vitrinen]]. In jeder liegt eine Nachricht, die jemand aufgenommen und dann doch nie abgeschickt hat. In den untersten Vitrinen liegen die Aufnahmen derer, die es sich anders überlegt haben. Auf Hüfthöhe steht eine runde [[Lupe]] in einer Messingfassung. Mit ihr lassen sich die Stücke aus der Nähe betrachten. Im [[Westen->west]] geht es zurück zur Eingangshalle.")>

<ROOM QUIET-HALL (IN ROOMS) (GLOBAL RELAY) (DESC "Saal der Stille") (FLAGS RLANDBIT ONBIT)
	(OST TO ADMISSIONS)
	(LDESC "Das ist der Saal der Stille, der einzige Raum im Museum, der dafür gebaut wurde, dem Nichts zuzuhören. Dicker Teppich schluckt deine Schritte. Die Stille ist angenehm, wie ein Mantel, den man über ein schlafendes Kind legt. Eine schlichte [[Holzbank]] steht vor der Wand mit dem alten [[Schaltplan]] der Relaisanlage. Im [[Osten->ost]] geht es zurück zur Eingangshalle.")>

<ROOM SIGNAL-BOOTH (IN ROOMS) (GLOBAL RELAY) (DESC "Signalkabine") (FLAGS RLANDBIT ONBIT)
	(SUED TO ADMISSIONS)
	(LDESC "Du bist in der Signalkabine, einem kleinen Glasraum im Herzen der Relaisanlage. Die Luft summt leise. Das Glas ist noch warm, wo andere ihre Stirn dagegen gelehnt haben. Im Pult sitzt eine flache [[Lesemulde]] für Tonspulen, daneben ein runder [[Abhörknopf]]. Darunter liegen zwei Sendetasten: links die [[Rückantworttaste]], rechts die [[Gedenktaste]]. Nach [[Süden->sued]] führt der Gang zurück zur Eingangshalle.")>

<OBJECT MUSEUM-PLAQUE (IN ADMISSIONS) (DESC "Messingtafel") (SYNONYM MESSINGTAFEL TAFEL SCHILD ZETTEL)
	(FLAGS NDESCBIT DIEBIT READBIT) (ACTION MUSEUM-PLAQUE-F)>

<OBJECT RETURN-LENS (IN DEAD-LETTERS) (DESC "Lupe") (SYNONYM LUPE LINSE FASSUNG)
	(ADJECTIVE RUND RUNDE RUNDEN)
	(FLAGS NDESCBIT DIEBIT) (ACTION RETURN-LENS-F)>

<OBJECT MESSAGE-SPOOL (IN DEAD-LETTERS) (DESC "Holzspule") (SYNONYM HOLZSPULE SPULE ANH\%ANGER ANHAENGER TONBAND BAND)
	(ADJECTIVE H\%OLZERN HOELZERN H\%OLZERNE HOELZERNE H\%OLZERNEN HOELZERNEN)
	(FLAGS TAKEBIT DIEBIT) (FDESC "Neben der Lupe hat jemand eine [[Holzspule]] aus ihrer Vitrine genommen. An ihr hängt ein Papieretikett.")
	(LDESC "Hier liegt die [[Holzspule]].") (INTERACTIONS "PUT:READING-BASIN") (ACTION MESSAGE-SPOOL-F)>

<OBJECT HALL-BENCH (IN QUIET-HALL) (DESC "Holzbank") (SYNONYM HOLZBANK BANK)
	(FLAGS NDESCBIT DIEBIT) (ACTION HALL-BENCH-F)>

<OBJECT SERVICE-DIAGRAM (IN QUIET-HALL) (DESC "Schaltplan") (SYNONYM SCHALTPLAN PLAN)
	(ADJECTIVE ALT ALTE ALTER ALTEN)
	(FLAGS NDESCBIT DERBIT READBIT) (ACTION SERVICE-DIAGRAM-F)>

<OBJECT READING-BASIN (IN SIGNAL-BOOTH) (DESC "Lesemulde") (SYNONYM LESEMULDE MULDE SCHALE)
	(FLAGS NDESCBIT CONTBIT OPENBIT SEARCHBIT DIEBIT) (CAPACITY 15) (ACTION READING-BASIN-F)>

<OBJECT AUDITION-STUD (IN SIGNAL-BOOTH) (DESC "Abhörknopf") (SYNONYM ABH\%ORKNOPF ABHOERKNOPF KNOPF)
	(FLAGS NDESCBIT DERBIT) (ACTION AUDITION-STUD-F)>

<OBJECT RETURN-KEY (IN SIGNAL-BOOTH) (DESC "Rückantworttaste") (SYNONYM R\%UCKANTWORTTASTE RUECKANTWORTTASTE TASTE)
	(ADJECTIVE LINKS LINKE LINKEN)
	(FLAGS NDESCBIT DIEBIT) (ACTION RETURN-KEY-F)>

<OBJECT MEMORIAL-KEY (IN SIGNAL-BOOTH) (DESC "Gedenktaste") (SYNONYM GEDENKTASTE TASTE)
	(ADJECTIVE RECHTS RECHTE RECHTEN)
	(FLAGS NDESCBIT DIEBIT) (ACTION MEMORIAL-KEY-F)>

<OBJECT TICKET-COUNTER (IN ADMISSIONS) (DESC "Kasse") (SYNONYM KASSE SCHALTER STAPEL KARTE EINTRITTSKARTE)
	(FLAGS NDESCBIT READBIT DIEBIT) (ACTION TICKET-COUNTER-F)>

<OBJECT GLASS-CASES (IN DEAD-LETTERS) (DESC "Glasvitrinen") (SYNONYM VITRINEN VITRINE GLASVITRINE GLASVITRINEN EXPONATE NACHRICHTEN)
	(FLAGS NDESCBIT) (ACTION GLASS-CASES-F)>

<OBJECT RELAY (IN LOCAL-GLOBALS) (DESC "Relaisanlage") (SYNONYM RELAISANLAGE RELAIS SUMMEN KUPPEL)
	(ADJECTIVE ALT ALTE ALTER ALTEN)
	(FLAGS NDESCBIT DIEBIT) (ACTION RELAY-F)>

<OBJECT LOBBY (IN ADMISSIONS) (DESC "Eingangshalle") (SYNONYM EINGANGSHALLE HALLE LICHT T\%UR TUER GANG MUSEUM BODEN)
	(FLAGS NDESCBIT DIEBIT) (ACTION LOBBY-F)>

<OBJECT GALLERY (IN DEAD-LETTERS) (DESC "Galerie") (SYNONYM GALERIE RAUM ZIMMER T\%UR TUER BRIEFE BODEN)
	(FLAGS NDESCBIT DIEBIT) (ACTION GALLERY-F)>

<OBJECT QUIET-ROOM (IN QUIET-HALL) (DESC "Saal") (SYNONYM SAAL RAUM TEPPICH WAND STILLE SCHRITTE)
	(FLAGS NDESCBIT DERBIT) (ACTION QUIET-ROOM-F)>

<OBJECT BOOTH (IN SIGNAL-BOOTH) (DESC "Signalkabine") (SYNONYM SIGNALKABINE KABINE RAUM GLAS PULT GANG TASTEN)
	(FLAGS NDESCBIT DIEBIT) (ACTION BOOTH-F)>
