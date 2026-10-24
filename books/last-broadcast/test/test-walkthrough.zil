<INSERT-FILE "books/last-broadcast/last-broadcast">
<GLOBAL CO <CO-CREATE GO>>

<ROUTINE RUN-TEST ()
	;"1: examine station clock"
	<ASSERT-TEXT "spring movement" <CO-RESUME ,CO "examine station clock">>
	;"2: examine casebook"
	<CO-RESUME ,CO "examine casebook">
	;"3: north"
	<CO-RESUME ,CO "north">
	;"4: read board"
	<CO-RESUME ,CO "read board">
	;"5: north"
	<CO-RESUME ,CO "north">
	;"6: examine body"
	<CO-RESUME ,CO "examine body">
	;"7: examine office clock"
	<CO-RESUME ,CO "examine office clock">
	;"8: down"
	<CO-RESUME ,CO "down">
	;"9: south"
	<CO-RESUME ,CO "south">
	;"10: east"
	<CO-RESUME ,CO "east">
	;"11: ask ruth about microphone"
	<CO-RESUME ,CO "ask ruth about microphone">
	;"12: ask ruth about vane"
	<CO-RESUME ,CO "ask ruth about vane">
	;"13: east"
	<CO-RESUME ,CO "east">
	;"14: examine switch"
	<CO-RESUME ,CO "examine switch">
	;"15: north"
	<CO-RESUME ,CO "north">
	;"16: examine cutter"
	<CO-RESUME ,CO "examine cutter">
	;"17: take counterweight"
	<CO-RESUME ,CO "take counterweight">
	;"18: read register"
	<CO-RESUME ,CO "read register">
	;"19: east"
	<CO-RESUME ,CO "east">
	;"20: examine sleeve"
	<ASSERT-TEXT "flap is folded tight" <CO-RESUME ,CO "examine sleeve">>
	;"21: open sleeve"
	<ASSERT-TEXT "reveals a lacquer disc" <CO-RESUME ,CO "open sleeve">>
	;"22: examine disc"
	<CO-RESUME ,CO "examine disc">
	;"23: take disc"
	<CO-RESUME ,CO "take disc">
	;"24: read ledger"
	<CO-RESUME ,CO "read ledger">
	;"25: take ledger"
	<CO-RESUME ,CO "take ledger">
	;"26: west"
	<CO-RESUME ,CO "west">
	;"27: south"
	<CO-RESUME ,CO "south">
	;"28: south"
	<CO-RESUME ,CO "south">
	;"29: take stylus"
	<CO-RESUME ,CO "take stylus">
	;"30: take spanner"
	<CO-RESUME ,CO "take spanner">
	;"31: down"
	<CO-RESUME ,CO "down">
	;"32: read chart"
	<CO-RESUME ,CO "read chart">
	;"33: take chart"
	<CO-RESUME ,CO "take chart">
	;"34: north"
	<CO-RESUME ,CO "north">
	;"35: examine stain"
	<CO-RESUME ,CO "examine stain">
	;"36: use spanner on hatch"
	<ASSERT-TEXT "bolt turns" <CO-RESUME ,CO "use spanner on hatch">>
	<ASSERT "State after use spanner on hatch" <FSET? ,LB-HATCH ,OPENBIT>>
	;"37: up"
	<CO-RESUME ,CO "up">
	;"38: compare clock with chart"
	<ASSERT-TEXT "not a killing" <CO-RESUME ,CO "compare clock with chart">>
	<ASSERT "State after compare clock with chart" ,LB-CLOCK>
	;"39: compare body with counterweight"
	<ASSERT-TEXT "This is the weapon" <CO-RESUME ,CO "compare body with counterweight">>
	<ASSERT "State after compare body with counterweight" ,LB-WEAPON>
	;"40: south"
	<CO-RESUME ,CO "south">
	;"41: up"
	<CO-RESUME ,CO "up">
	;"42: examine boots"
	<CO-RESUME ,CO "examine boots">
	;"43: take boots"
	<CO-RESUME ,CO "take boots">
	;"44: read roster"
	<CO-RESUME ,CO "read roster">
	;"45: show ledger to ada"
	<ASSERT-TEXT "father's name" <CO-RESUME ,CO "show ledger to ada">>
	<ASSERT "State after show ledger to ada" ,LB-MOTIVE>
	;"46: down"
	<CO-RESUME ,CO "down">
	;"47: north"
	<CO-RESUME ,CO "north">
	;"48: down"
	<CO-RESUME ,CO "down">
	;"49: compare stain with boots"
	<ASSERT-TEXT "diamond interruption" <CO-RESUME ,CO "compare stain with boots">>
	<ASSERT "State after compare stain with boots" ,LB-TRACE>
	;"50: south"
	<CO-RESUME ,CO "south">
	;"51: up"
	<CO-RESUME ,CO "up">
	;"52: north"
	<CO-RESUME ,CO "north">
	;"53: use stylus on gramophone"
	<ASSERT-TEXT "It remains mounted" <CO-RESUME ,CO "use stylus on gramophone">>
	<ASSERT "State after use stylus on gramophone" <IN? ,LB-STYLUS ,LB-PLAYER>>
	;"54: put disc in gramophone"
	<CO-RESUME ,CO "put disc in gramophone">
	;"55: play gramophone"
	<ASSERT-TEXT "gull coughs twice" <CO-RESUME ,CO "play gramophone">>
	<ASSERT "State after play gramophone" ,LB-SOUND>
	;"56: take disc"
	<CO-RESUME ,CO "take disc">
	;"57: north"
	<CO-RESUME ,CO "north">
	;"58: compare register with disc"
	<ASSERT-TEXT "A17, six minutes" <CO-RESUME ,CO "compare register with disc">>
	<ASSERT "State after compare register with disc" ,LB-PROVENANCE>
	;"59: south"
	<CO-RESUME ,CO "south">
	;"60: west"
	<CO-RESUME ,CO "west">
	;"61: show disc to ruth"
	<ASSERT-TEXT "misunderstand" <CO-RESUME ,CO "show disc to ruth">>
	<ASSERT "State after show disc to ruth" ,LB-RUTH-CLEARED>
	;"62: west"
	<CO-RESUME ,CO "west">
	;"63: west"
	<CO-RESUME ,CO "west">
	;"64: open bag"
	<CO-RESUME ,CO "open bag">
	;"65: examine dressing"
	<CO-RESUME ,CO "examine dressing">
	;"66: take dressing"
	<CO-RESUME ,CO "take dressing">
	;"67: show dressing to edith"
	<ASSERT-TEXT "Ruth Bell. Three fragments" <CO-RESUME ,CO "show dressing to edith">>
	<ASSERT "State after show dressing to edith" ,LB-EDITH-CLEARED>
	;"68: west"
	<CO-RESUME ,CO "west">
	;"69: read receipt"
	<CO-RESUME ,CO "read receipt">
	;"70: take receipt"
	<CO-RESUME ,CO "take receipt">
	;"71: show receipt to tomas"
	<ASSERT-TEXT "No interval remains" <CO-RESUME ,CO "show receipt to tomas">>
	<ASSERT "State after show receipt to tomas" ,LB-TOMAS-CLEARED>
	;"72: accuse tomas"
	<ASSERT-TEXT "accusation fails" <CO-RESUME ,CO "accuse tomas">>
	<ASSERT "State after accuse tomas" <NOT ,LB-WON>>
	;"73: up"
	<CO-RESUME ,CO "up">
	;"74: examine aerial"
	<CO-RESUME ,CO "examine aerial">
	;"75: examine signal lamp"
	<CO-RESUME ,CO "examine signal lamp">
	;"76: east"
	<CO-RESUME ,CO "east">
	;"77: reconstruct casebook"
	<ASSERT-TEXT "SOUND and PERSON" <CO-RESUME ,CO "reconstruct casebook">>
	<ASSERT "State after reconstruct casebook" ,LB-RECONSTRUCTED>
	;"78: ask ada about ledger"
	<CO-RESUME ,CO "ask ada about ledger">
	;"79: accuse ada"
	<ASSERT-TEXT "CASE SOLVED" <CO-RESUME ,CO "accuse ada">>
	<ASSERT "State after accuse ada" ,LB-WON>
	<ASSERT "All testimony and physical gates agree" <AND ,LB-CLOCK ,LB-WEAPON ,LB-SOUND ,LB-PROVENANCE ,LB-TRACE ,LB-ROUTE ,LB-RUTH-CLEARED ,LB-EDITH-CLEARED ,LB-TOMAS-CLEARED ,LB-MOTIVE>>
>
