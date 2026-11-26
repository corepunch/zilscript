<INSERT-FILE "books/de/borrowed-tomorrows/borrowed-tomorrows">
<GLOBAL CO <CO-CREATE GO>>
<ROUTINE RUN-TEST ()
	<ASSERT-TEXT "Faltraum" <CO-RESUME ,CO "schau">>
	<ASSERT "Schrank ist geschlossen" <NOT <FSET? ,CASE ,OPENBIT>>>
	<ASSERT-TEXT "öffnest die kleine Schranktür" <CO-RESUME ,CO "ÖFFNE den hölzernen Leihschrank">>
	<ASSERT "Schrank wurde geöffnet" <FSET? ,CASE ,OPENBIT>>
	<ASSERT-TEXT "Durch die offene Tür" <CO-RESUME ,CO "lies das Blatt">>
	<ASSERT "Lesen leiht das Blatt nicht aus" <AND <IN? ,LEAF ,CASE> <NOT ,ON-LOAN>>>
	<ASSERT-TEXT "trägt das Blatt deinen Namen ein" <CO-RESUME ,CO "nimm das Morgenblatt">>
	<ASSERT "Blatt ist ausgeliehen" <AND ,ON-LOAN <HELD? ,LEAF>>>
	<ASSERT-TEXT "Ein Morgenblatt" <CO-RESUME ,CO "inventar">>
	<ASSERT-TEXT "Jeder Tropfen ist zurückgewichen" <CO-RESUME ,CO "geh nach Norden">>
	<ASSERT-TEXT "NIMMT SIE DER STADT WEG" <CO-RESUME ,CO "lies den alten Leihschein">>
	<CO-RESUME ,CO "ost">
	<ASSERT-TEXT "zweiten Klammer" <CO-RESUME ,CO "lege das Blatt in den Rahmen">>
	<ASSERT "Zu kleines Blatt bleibt in der Hand" <HELD? ,LEAF>>
	<CO-RESUME ,CO "süd">
	<ASSERT-TEXT "STREICH DIE ALTEN FALTEN GLATT" <CO-RESUME ,CO "lies das Faltbrett">>
	<ASSERT-TEXT "ausgebreiteten Arme" <CO-RESUME ,CO "lege das Blatt auf das Brett">>
	<ASSERT "Aufgefaltetes Blatt bleibt in der Hand" <AND ,WIDE-LOAN <HELD? ,LEAF>>>
	<CO-RESUME ,CO "west">
	<ASSERT-TEXT "zweite Sonnenstreifen" <CO-RESUME ,CO "lege das Blatt in den Schrank">>
	<ASSERT "Rückgabe setzt Ausleihe und Faltung zurück" <AND <IN? ,LEAF ,CASE> <NOT ,ON-LOAN> <NOT ,WIDE-LOAN>>>
	<CO-RESUME ,CO "nimm das Blatt">
	<CO-RESUME ,CO "ost">
	<CO-RESUME ,CO "lass das Blatt">
	<ASSERT "Blatt kann wieder aufgenommen werden" <IN? ,LEAF ,FOLDING>>
	<CO-RESUME ,CO "nimm das Blatt">
	<CO-RESUME ,CO "lege das Blatt auf das Brett">
	<CO-RESUME ,CO "nord">
	<ASSERT-TEXT "Beide Klammern halten" <CO-RESUME ,CO "lege das Blatt in den Rahmen">>
	<ASSERT "Blatt steckt im Rahmen" <IN? ,LEAF ,FRAME>>
	<CO-RESUME ,CO "nimm das Blatt">
	<ASSERT "Blatt lässt sich wieder lösen" <HELD? ,LEAF>>
	<ASSERT-TEXT "geschieht nichts" <CO-RESUME ,CO "lies das Blatt">>
	<CO-RESUME ,CO "lege das Blatt in den Rahmen">
	<ASSERT "Vorlesen gelingt" <CO-RESUME ,CO "lies den Leserahmen" T>>
	<ASSERT "Vorlesen beendet das Buch" <NOT <CO-RESUME ,CO "schau" T>>>>
