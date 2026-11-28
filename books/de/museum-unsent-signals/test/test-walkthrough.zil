<INSERT-FILE "books/de/museum-unsent-signals/museum-unsent-signals">
<GLOBAL CO <CO-CREATE GO>>
<ROUTINE RUN-TEST ()
	<ASSERT-TEXT "Nachtbus" <CO-RESUME ,CO "öffne die Glastür">>
	<ASSERT "Glastür ist kein Ausgang" <EQUAL? ,HERE ,ADMISSIONS>>
	<ASSERT-TEXT "Wechselgeldfachs" <CO-RESUME ,CO "öffne die Kasse">>
	<ASSERT-TEXT "vierzig Jahre" <CO-RESUME ,CO "lies die Messingtafel">>
	<CO-RESUME ,CO "osten">
	<ASSERT-TEXT "Vitrinen sind abgeschlossen. Die Vitrinenschlüssel" <CO-RESUME ,CO "öffne die Vitrine">>
	<ASSERT-TEXT "für Beschädigungen" <CO-RESUME ,CO "untersuche die Holzspule">>
	<CO-RESUME ,CO "nimm die Spule">
	<ASSERT-TEXT "zweimal umgeschlagen" <CO-RESUME ,CO "drehe die Spule">>
	<CO-RESUME ,CO "west">
	<CO-RESUME ,CO "nord">
	<ASSERT-TEXT "Leg zuerst die Holzspule" <CO-RESUME ,CO "drück den Abhörknopf">>
	<CO-RESUME ,CO "lege die Spule in die Mulde">
	<ASSERT "Spule liegt in der Mulde" <IN? ,MESSAGE-SPOOL ,READING-BASIN>>
	<ASSERT-TEXT "Öffentliche oder private Adresse" <CO-RESUME ,CO "drück den Knopf">>
	<ASSERT "Bloßes Abspielen schaltet die Tasten nicht frei" <NOT ,SIGNAL-HEARD>>
	<ASSERT-TEXT "Die Tasten bleiben dunkel" <CO-RESUME ,CO "drück die linke Taste">>
	<CO-RESUME ,CO "süden">
	<CO-RESUME ,CO "west">
	<ASSERT-TEXT "Die rechte bleibt frei" <CO-RESUME ,CO "sitz auf der Holzbank">>
	<ASSERT-TEXT "nie die Aufnahme von der Spule" <CO-RESUME ,CO "lies den alten Schaltplan">>
	<CO-RESUME ,CO "ost">
	<CO-RESUME ,CO "ost">
	<ASSERT-TEXT "zum Licht hin kippen" <CO-RESUME ,CO "untersuche die runde Lupe">>
	<ASSERT "Ansehen kippt die Lupe nicht" <NOT ,LENS-READ>>
	<ASSERT-TEXT "NUR RÜCKANTWORT" <CO-RESUME ,CO "kippe die Lupe">>
	<ASSERT "Die Lupe zeigt die Markierung" ,LENS-READ>
	<CO-RESUME ,CO "west">
	<CO-RESUME ,CO "nord">
	<ASSERT-TEXT "Rascheln des Bands" <CO-RESUME ,CO "höre die Spule">>
	<ASSERT-TEXT "nimm die Spule erst heraus" <CO-RESUME ,CO "drehe die Spule">>
	<ASSERT "Bloßes Hören oder Drehen schaltet nichts frei" <NOT ,SIGNAL-HEARD>>
	<ASSERT-TEXT "Keine von beiden sendet ihre Stimme" <CO-RESUME ,CO "DRÜCK DEN ABHÖRKNOPF">>
	<ASSERT "Erneutes Abspielen schaltet die Tasten frei" ,SIGNAL-HEARD>
	<ASSERT-TEXT "beide Sendetasten erlöschen" <CO-RESUME ,CO "nimm die Spule">>
	<ASSERT "Herausnehmen verwirft die Freigabe" <AND <HELD? ,MESSAGE-SPOOL> <NOT ,SIGNAL-HEARD>>>
	<ASSERT-TEXT "Die Tasten bleiben dunkel" <CO-RESUME ,CO "drück die Rückantworttaste">>
	<ASSERT-TEXT "Die Tasten bleiben dunkel" <CO-RESUME ,CO "drück die Gedenktaste">>
	<ASSERT "Kein Ende ohne Spule" <EQUAL? ,MUSEUM-END 0>>
	<CO-RESUME ,CO "leg die Spule in die Mulde">
	<ASSERT-TEXT "Drück den Abhörknopf erneut" <CO-RESUME ,CO "drück die Gedenktaste">>
	<ASSERT "Keine alte Freigabe nach Einlegen" <NOT ,SIGNAL-HEARD>>
	<ASSERT-TEXT "privaten Rückantwortregister" <CO-RESUME ,CO "drück den Abhörknopf">>
	<ASSERT "Die private Sendetaste funktioniert" <CO-RESUME ,CO "drück die Rückantworttaste" T>>
	<ASSERT "Privates Ziel gewählt" <EQUAL? ,MUSEUM-END 1>>
	;"After the ending the story only offers to start again."
	<ASSERT-TEXT "NEUBEGINN" <CO-RESUME ,CO "schau">>>
