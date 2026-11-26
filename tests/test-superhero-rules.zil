<INSERT-FILE "rulesets.superhero.percentile">
;"Lowest rank of each band and its green, yellow and red cutoffs, as the
  book tests copy them; each band's edges are checked at both ends."
<GLOBAL TIER-ROWS <TABLE 1000 6 36 76 150 11 41 81 100 16 46 86 75 21 51 86 50 26 56 91 40 31 61 91
 30 36 66 95 20 41 71 95 10 46 76 98 6 51 81 98 4 56 86 100 2 61 91 100 0 66 96 100>>

<ROUTINE BAND-OK? (RANK G Y R)
 <AND <OR <==? .G 1> <==? <HERO-TIER .RANK <- .G 1>> 0>>
      <==? <HERO-TIER .RANK .G> 1> <==? <HERO-TIER .RANK <- .Y 1>> 1>
      <==? <HERO-TIER .RANK .Y> 2> <==? <HERO-TIER .RANK <- .R 1>> 2>
      <==? <HERO-TIER .RANK .R> 3> <==? <HERO-TIER .RANK 100> 3> <==? <HERO-TIER .RANK 1> 0>>>

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
 <HERO-INIT 30 10 40 40 6 10 10 30>
 <ASSERT "health is the sum of physical ranks" <==? ,HERO-MAX-HEALTH 120>>
 <ASSERT "karma is the sum of mental ranks" <==? ,HERO-KARMA 26>>
 <ASSERT "below green" <==? <HERO-TIER 40 30> 0>>
 <ASSERT "green boundary" <==? <HERO-TIER 40 31> 1>>
 <ASSERT "yellow boundary" <==? <HERO-TIER 40 61> 2>>
 <ASSERT "red boundary" <==? <HERO-TIER 40 91> 3>>
 <ASSERT "typical failure boundary" <==? <HERO-TIER 6 50> 0>>
 <ASSERT "typical success boundary" <==? <HERO-TIER 6 51> 1>>
 <ASSERT "typical strong success boundary" <==? <HERO-TIER 6 81> 2>>
 <ASSERT "typical exceptional success boundary" <==? <HERO-TIER 6 98> 3>>
 <ASSERT "remarkable upper yellow" <==? <HERO-TIER 30 94> 2>>
 <ASSERT "remarkable red" <==? <HERO-TIER 30 95> 3>>
 <ASSERT "every band's cutoffs hold at its lowest and highest rank" <BANDS-OK?>>
 <ASSERT "heal restores what was lost" <==? <HERO-HEAL 20> 0>>
 <ASSERT "armor absorbs all damage" <==? <HERO-DAMAGE 10 20> 0>>
 <ASSERT "armor reduces damage" <==? <HERO-DAMAGE 10 3> 7>>
 <ASSERT "health is updated" <==? ,HERO-HEALTH 113>>
 <ASSERT "heal stops at the maximum" <==? <HERO-HEAL 20> 7>>
 <ASSERT "healed to the maximum" <==? ,HERO-HEALTH 120>>
 <ASSERT "heal at the maximum restores nothing" <==? <HERO-HEAL 5> 0>>
 <HERO-DAMAGE 30 0>
 <ASSERT "heal restores less than the loss" <==? <HERO-HEAL 20> 20>>
 <ASSERT "partly healed" <==? ,HERO-HEALTH 110>>
 <HERO-HEAL 10>
 <ASSERT "cannot overspend" <NOT <HERO-SPEND 27>>>
 <ASSERT "can spend karma" <HERO-SPEND 10>>
 <ASSERT "karma debited" <==? ,HERO-KARMA 16>>
 <HERO-REWARD 5>
 <ASSERT "karma reward" <==? ,HERO-KARMA 21>>
 <ASSERT "spending nothing is refused" <NOT <HERO-SPEND 0>>>
 <ASSERT "spending a negative amount is refused" <NOT <HERO-SPEND -5>>>
 <ASSERT "spending everything is allowed" <HERO-SPEND 21>>
 <ASSERT "karma never goes below zero" <AND <==? ,HERO-KARMA 0> <NOT <HERO-SPEND 1>>>>
 <HERO-DAMAGE 1000 0>
 <ASSERT "health clamps at zero" <==? ,HERO-HEALTH 0>>
 <TELL "Superhero rules tests completed." CR>>
