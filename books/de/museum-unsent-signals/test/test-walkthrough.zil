<INSERT-FILE "books/de/museum-unsent-signals/museum-unsent-signals">
<GLOBAL CO <CO-CREATE GO>>
<ROUTINE RUN-TEST ()
	<ASSERT-TEXT "vierzig Jahre" <CO-RESUME ,CO "lies die Messingtafel">>
	<CO-RESUME ,CO "osten">
	<ASSERT-TEXT "für Beschädigungen" <CO-RESUME ,CO "untersuche die Holzspule">>
	<CO-RESUME ,CO "nimm die Spule">
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
	<ASSERT-TEXT "nie die Aufnahme von der Spule" <CO-RESUME ,CO "lies den alten Schaltplan">>
	<CO-RESUME ,CO "ost">
	<CO-RESUME ,CO "ost">
	<ASSERT-TEXT "zum Licht hin kippen" <CO-RESUME ,CO "untersuche die runde Lupe">>
	<ASSERT "Ansehen kippt die Lupe nicht" <NOT ,LENS-READ>>
	<ASSERT-TEXT "NUR RÜCKANTWORT" <CO-RESUME ,CO "kippe die Lupe">>
	<ASSERT "Die Lupe zeigt die Markierung" ,LENS-READ>
	<CO-RESUME ,CO "west">
	<CO-RESUME ,CO "nord">
	<ASSERT-TEXT "privaten Rückantwortregister" <CO-RESUME ,CO "DRÜCK DEN ABHÖRKNOPF">>
	<ASSERT "Erneutes Abspielen schaltet die Tasten frei" ,SIGNAL-HEARD>
	<ASSERT "Die private Sendetaste funktioniert" <CO-RESUME ,CO "drück die Rückantworttaste" T>>
	<ASSERT "Privates Ziel gewählt" <EQUAL? ,MUSEUM-END 1>>
	<ASSERT "Die Sendung beendet das Buch" <NOT <CO-RESUME ,CO "schau" T>>>>
