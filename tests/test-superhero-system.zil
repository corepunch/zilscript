<INSERT-FILE "rulesets.rpg.kernel">
<INSERT-FILE "rulesets.superhero.system">
<ROUTINE REPORT-CHECK (TBL ATTR DIFFICULTY ROLL TIER) <RTRUE>>
<ROUTINE ATTR-NAME (ATTR) <RTRUE>>
<ROUTINE OF-WORD () <RTRUE>>
<GLOBAL BULWARK <LTABLE 30 10 40 40 6 10 10 30>>
;"Independently checked interval starts and odds, including the ordinary
  rank ranges and the special columns on the back of the 1986 Players' Book."
<GLOBAL TIER-ROWS <TABLE FASERIP-BEYOND 2 21 61 5000 2 26 66 3000 2 31 71
 1000 2 36 76 351 4 36 76 176 7 41 81 126 11 41 81 88 16 46 86
 63 21 51 86 46 26 56 91 37 31 61 91 26 36 66 95 16 41 71 95
 8 46 76 98 5 51 81 98 3 56 86 100 1 61 91 100 0 66 95 100>>

<ROUTINE REPORT-FEAT (TBL ATTR INTENSITY SHIFT REQUIRED RAW SPENT TOTAL TIER) <RTRUE>>
<ROUTINE REPORT-FEAT-GATE (REQUIRED) <RTRUE>>
<ROUTINE BAND-OK? (RANK G Y R)
 <AND <OR <==? .G 1> <==? <RANK-TIER .RANK <- .G 1>> 0>>
      <==? <RANK-TIER .RANK .G> 1> <==? <RANK-TIER .RANK <- .Y 1>> 1>
      <==? <RANK-TIER .RANK .Y> 2> <==? <RANK-TIER .RANK <- .R 1>> 2>
      <==? <RANK-TIER .RANK .R> 3> <==? <RANK-TIER .RANK 100> 3> <==? <RANK-TIER .RANK 1> 0>>>

<ROUTINE BANDS-OK? ("AUX" (I 0) RANK (TOP 50000))
 <REPEAT ()
  <COND (<G? .I 68> <RETURN>)>
  <SET RANK <GET ,TIER-ROWS .I>>
  <COND (<NOT <BAND-OK? .RANK <GET ,TIER-ROWS <+ .I 1>> <GET ,TIER-ROWS <+ .I 2>> <GET ,TIER-ROWS <+ .I 3>>>> <RFALSE>)>
  <COND (<NOT <BAND-OK? <- .TOP 1> <GET ,TIER-ROWS <+ .I 1>> <GET ,TIER-ROWS <+ .I 2>> <GET ,TIER-ROWS <+ .I 3>>>> <RFALSE>)>
  <SET TOP .RANK>
  <SET I <+ .I 4>>>
 <RTRUE>>

<ROUTINE RUN-TEST ()
 <BECOME ,HERO ,BULWARK>
 <ASSERT "health is the sum of physical ranks" <==? <MAX-STAT ,HERO ,A-HEALTH> 120>>
 <ASSERT "health starts full" <==? <STAT ,HERO ,A-HEALTH> 120>>
 <ASSERT "karma is the sum of mental ranks" <==? <STAT ,HERO ,A-KARMA> 26>>
 <ASSERT "karma has no ceiling" <==? <MAX-STAT ,HERO ,A-KARMA> ,NO-LIMIT>>
 <ASSERT "the archetype's ranks are the attributes" <AND <==? <STAT ,HERO ,A-FIGHTING> 30> <==? <STAT ,HERO ,A-POWER> 30>>>
 <ASSERT "a check rolls a d100 against the attribute's rank" <AND <NOT <L? <SYSTEM-ROLL ,HERO ,A-FIGHTING 0> 1>> <NOT <G? <SYSTEM-ROLL ,HERO ,A-FIGHTING 0> 100>>>>
 <ASSERT "grading uses the attribute's rank" <AND <==? <SYSTEM-GRADE ,HERO ,A-REASON 0 50> 0> <==? <SYSTEM-GRADE ,HERO ,A-REASON 0 51> 1> <==? <SYSTEM-GRADE ,HERO ,A-FIGHTING 0 66> 2> <==? <SYSTEM-GRADE ,HERO ,A-FIGHTING 0 95> 3>>>
 <ASSERT "below green" <==? <RANK-TIER 40 30> 0>>
 <ASSERT "green boundary" <==? <RANK-TIER 40 31> 1>>
 <ASSERT "yellow boundary" <==? <RANK-TIER 40 61> 2>>
 <ASSERT "red boundary" <==? <RANK-TIER 40 91> 3>>
 <ASSERT "typical failure boundary" <==? <RANK-TIER 6 50> 0>>
 <ASSERT "typical success boundary" <==? <RANK-TIER 6 51> 1>>
 <ASSERT "typical strong success boundary" <==? <RANK-TIER 6 81> 2>>
 <ASSERT "typical exceptional success boundary" <==? <RANK-TIER 6 98> 3>>
 <ASSERT "remarkable upper yellow" <==? <RANK-TIER 30 94> 2>>
 <ASSERT "remarkable red" <==? <RANK-TIER 30 95> 3>>
 <ASSERT "every band's cutoffs hold at its lowest and highest rank" <BANDS-OK?>>
 <ASSERT "roll outside a genuine d100 is not graded as a success"
   <AND <0? <RANK-TIER 40 0>> <0? <RANK-TIER 40 101>>>>
 <ASSERT "a 37 rank point check is Incredible, not Remarkable" <==? <RANK-TIER 37 31> 1>>
 <ASSERT "low column shifts stop at Shift 0" <0? <FASERIP-SHIFT <FASERIP-COLUMN 6> -50>>>
 <ASSERT "normal shifts never cross into cosmic columns"
   <==? <FASERIP-SHIFT <FASERIP-COLUMN 100> 50> <FASERIP-COLUMN 500>>>
 <ASSERT "cosmic columns do not shift" <==? <FASERIP-SHIFT <FASERIP-COLUMN 1000> -10> <FASERIP-COLUMN 1000>>>
 <ASSERT "shift is a column change rather than a numeric bonus"
   <==? <FASERIP-SHIFT <FASERIP-COLUMN 60> 1> <FASERIP-COLUMN 75>>>
 <ASSERT "intensity determines green, yellow, or red"
   <AND <==? <FASERIP-REQUIRED <FASERIP-COLUMN 40> 20> 1>
        <==? <FASERIP-REQUIRED <FASERIP-COLUMN 20> 20> 2>
        <==? <FASERIP-REQUIRED <FASERIP-COLUMN 6> 20> 3>>>
 <ASSERT "rank bands, not raw numbers, determine equal intensity"
   <==? <FASERIP-REQUIRED <FASERIP-COLUMN 16> 25> 2>>
 <ASSERT "automatic is opt-in and needs more than three columns of advantage"
   <AND <==? <FASERIP-REQUIRED <FASERIP-COLUMN 40> 10 T> 1>
        <0? <FASERIP-REQUIRED <FASERIP-COLUMN 40> 6 T>>>>
 <ASSERT "strict mode is opt-in and allows one column above"
   <AND <==? <FASERIP-REQUIRED <FASERIP-COLUMN 10> 20 <> T> 3>
        <==? <FASERIP-REQUIRED <FASERIP-COLUMN 10> 30 <> T> 4>>>
 <ASSERT "commitment costs ten even on an otherwise successful roll"
   <==? <FASERIP-KARMA-COST 25 99 95> 10>>
 <ASSERT "commitment adds only what is needed, up to available Karma"
   <AND <==? <FASERIP-KARMA-COST 25 80 95> 15>
        <==? <FASERIP-KARMA-COST 9 1 95> 9>
        <0? <FASERIP-KARMA-COST 0 1 95>>>>
 <FASERIP-FEAT ,HERO ,A-STRENGTH 20 1>
 <ASSERT "ordinary feat records a raw roll and keeps the original rank"
   <AND <G? ,LAST-FEAT-RAW 0> <==? ,LAST-FEAT-RANK 50> <==? <STAT ,HERO ,A-STRENGTH> 40>
        <0? ,LAST-FEAT-KARMA> <==? <STAT ,HERO ,A-KARMA> 26>>>
 <ASSERT "automatic check passes without using a roll or Karma"
   <FASERIP-FEAT ,HERO ,A-STRENGTH 6 0 T <> T>>
 <ASSERT "automatic metadata clears previous dice"
   <AND <0? ,LAST-ROLL> <0? ,LAST-FEAT-KARMA> <==? <STAT ,HERO ,A-KARMA> 26>>>
 <ASSERT "strict impossible check does not spend or draw dice"
   <NOT <FASERIP-FEAT ,HERO ,A-REASON 40 0 <> T T>>>
 <ASSERT "impossible metadata retains its reason but no RNG result"
   <AND <==? ,LAST-FEAT-REQUIRED 4> <0? ,LAST-FEAT-RAW> <0? ,LAST-FEAT-KARMA>>>
 <FASERIP-FEAT ,HERO ,A-STRENGTH 40 0 <> <> T>
 <ASSERT "committed Karma and effective roll reconcile with live balance"
   <AND <NOT <L? ,LAST-FEAT-KARMA 10>>
        <==? <STAT ,HERO ,A-KARMA> <- 26 ,LAST-FEAT-KARMA>>
        <NOT <G? ,LAST-ROLL 100>> <NOT <L? ,LAST-ROLL ,LAST-FEAT-RAW>>>>
 <SET-STAT ,HERO ,A-KARMA 26>

<ASSERT "heal restores what was lost" <==? <GAIN ,HERO ,A-HEALTH 20> 0>>
 <ASSERT "damage" <==? <LOSE ,HERO ,A-HEALTH 7> 7>>
 <ASSERT "health is updated" <==? <STAT ,HERO ,A-HEALTH> 113>>
 <ASSERT "heal stops at the maximum" <==? <GAIN ,HERO ,A-HEALTH 20> 7>>
 <ASSERT "healed to the maximum" <==? <STAT ,HERO ,A-HEALTH> 120>>
 <ASSERT "heal at the maximum restores nothing" <==? <GAIN ,HERO ,A-HEALTH 5> 0>>
 <LOSE ,HERO ,A-HEALTH 30>
 <ASSERT "heal restores less than the loss" <==? <GAIN ,HERO ,A-HEALTH 20> 20>>
 <ASSERT "partly healed" <==? <STAT ,HERO ,A-HEALTH> 110>>
 <GAIN ,HERO ,A-HEALTH 10>
 <ASSERT "cannot overspend" <NOT <SPEND ,HERO ,A-KARMA 27>>>
 <ASSERT "can spend karma" <SPEND ,HERO ,A-KARMA 10>>
 <ASSERT "karma debited" <==? <STAT ,HERO ,A-KARMA> 16>>
 <GAIN ,HERO ,A-KARMA 5>
 <ASSERT "karma reward" <==? <STAT ,HERO ,A-KARMA> 21>>
 <ASSERT "spending nothing is refused" <NOT <SPEND ,HERO ,A-KARMA 0>>>
 <ASSERT "spending a negative amount is refused" <NOT <SPEND ,HERO ,A-KARMA -5>>>
 <ASSERT "spending everything is allowed" <SPEND ,HERO ,A-KARMA 21>>
 <ASSERT "karma never goes below zero" <AND <==? <STAT ,HERO ,A-KARMA> 0> <NOT <SPEND ,HERO ,A-KARMA 1>>>>
 <LOSE ,HERO ,A-HEALTH 1000>
 <ASSERT "health clamps at zero" <==? <STAT ,HERO ,A-HEALTH> 0>>
 <TELL "Superhero system tests completed." CR>>
