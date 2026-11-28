<INSERT-FILE "rulesets.rpg.kernel">
<INSERT-FILE "rulesets.superhero.system">
<ROUTINE REPORT-CHECK (TBL ATTR DIFFICULTY ROLL TIER) <RTRUE>>
<ROUTINE ATTR-NAME (ATTR) <RTRUE>>
<ROUTINE OF-WORD () <RTRUE>>
<GLOBAL BULWARK <LTABLE 30 10 40 40 6 10 10 30>>
;"Lowest rank of each band and its green, yellow and red cutoffs, as the
  book tests copy them; each band's edges are checked at both ends."
<GLOBAL TIER-ROWS <TABLE 1000 6 36 76 150 11 41 81 100 16 46 86 75 21 51 86 50 26 56 91 40 31 61 91
 30 36 66 95 20 41 71 95 10 46 76 98 6 51 81 98 4 56 86 100 2 61 91 100 0 66 96 100>>

<ROUTINE BAND-OK? (RANK G Y R)
 <AND <OR <==? .G 1> <==? <RANK-TIER .RANK <- .G 1>> 0>>
      <==? <RANK-TIER .RANK .G> 1> <==? <RANK-TIER .RANK <- .Y 1>> 1>
      <==? <RANK-TIER .RANK .Y> 2> <==? <RANK-TIER .RANK <- .R 1>> 2>
      <==? <RANK-TIER .RANK .R> 3> <==? <RANK-TIER .RANK 100> 3> <==? <RANK-TIER .RANK 1> 0>>>

<ROUTINE BANDS-OK? ("AUX" (I 0) RANK (TOP 5000))
 <REPEAT ()
  <COND (<G? .I 48> <RETURN>)>
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
