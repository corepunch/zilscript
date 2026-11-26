<INSERT-FILE "rulesets.superhero.percentile">
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
 <ASSERT "armor absorbs all damage" <==? <HERO-DAMAGE 10 20> 0>>
 <ASSERT "armor reduces damage" <==? <HERO-DAMAGE 10 3> 7>>
 <ASSERT "health is updated" <==? ,HERO-HEALTH 113>>
 <ASSERT "cannot overspend" <NOT <HERO-SPEND 27>>>
 <ASSERT "can spend karma" <HERO-SPEND 10>>
 <ASSERT "karma debited" <==? ,HERO-KARMA 16>>
 <HERO-REWARD 5>
 <ASSERT "karma reward" <==? ,HERO-KARMA 21>>
 <HERO-DAMAGE 1000 0>
 <ASSERT "health clamps at zero" <==? ,HERO-HEALTH 0>>
 <TELL "Superhero rules tests completed." CR>>
