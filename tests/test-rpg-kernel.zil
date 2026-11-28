;"The RPG kernel against a toy d20 system (tests/fixtures/rpg/toy-d20.zil):
  characters, resources, dice, checks, archetypes, the sheet and the hero's
  name, with the system's numbers and the language's words supplied by the
  test. Nothing here names the superhero system."
<INSERT-FILE "rulesets.rpg.kernel">
<INSERT-FILE "tests.fixtures.rpg.toy-d20">

;"The words a language supplies, recorded rather than printed."
<GLOBAL REPORTED-TIER -1>
<GLOBAL REPORTED-DIFFICULTY -1>
<ROUTINE CHECK-TERMS (TBL ATTR DIFFICULTY) <SETG REPORTED-DIFFICULTY .DIFFICULTY>>
<ROUTINE TIER-NAME (TIER) <SETG REPORTED-TIER .TIER>>
<ROUTINE ATTR-NAME (ATTR)
 <COND (<==? .ATTR ,A-MIGHT> <TELL "Might">) (<==? .ATTR ,A-LUCK> <TELL "Luck">)
       (<==? .ATTR ,A-HP> <TELL "HP">) (T <TELL "Mana">)>>
<ROUTINE OF-WORD () <TELL " of ">>
<ROUTINE SAY-NO-STATUS () <TELL "Nobody yet." CR>>

;"Dice and checks come from RANDOM, which the runner counts up: 1, 2, 3, ..."
<ROUTINE RUN-TEST ("AUX" ONE)
 <ASSERT "a new character has no archetype" <NOT <BECAME? ,HERO>>>
 <BECOME ,HERO ,WARRIOR>
 <ASSERT "becoming copies the archetype's values" <AND <==? <STAT ,HERO ,A-MIGHT> 4> <==? <STAT ,HERO ,A-LUCK> 1>>>
 <ASSERT "becoming remembers the archetype" <AND <BECAME? ,HERO> <==? <KIND-OF ,HERO> ,WARRIOR>>>
 <ASSERT "the system derives a resource and its maximum" <AND <==? <STAT ,HERO ,A-HP> 18> <==? <MAX-STAT ,HERO ,A-HP> 18>>>
 <ASSERT "the system derives a second resource" <AND <==? <STAT ,HERO ,A-MANA> 1> <==? <MAX-STAT ,HERO ,A-MANA> 1>>>

 ;"Resources"
 <ASSERT "lose returns what was lost" <==? <LOSE ,HERO ,A-HP 5> 5>>
 <ASSERT "lose lowers the resource" <==? <STAT ,HERO ,A-HP> 13>>
 <ASSERT "lose floors at zero and returns what was left" <==? <LOSE ,HERO ,A-HP 100> 13>>
 <ASSERT "a resource at zero stays at zero" <==? <STAT ,HERO ,A-HP> 0>>
 <ASSERT "a negative loss loses nothing" <==? <LOSE ,HERO ,A-HP -4> 0>>
 <ASSERT "gain returns what was gained" <==? <GAIN ,HERO ,A-HP 5> 5>>
 <ASSERT "gain caps at the maximum and returns the part that fit" <==? <GAIN ,HERO ,A-HP 100> 13>>
 <ASSERT "gain left the resource full" <==? <STAT ,HERO ,A-HP> 18>>
 <ASSERT "gain at the maximum gains nothing" <==? <GAIN ,HERO ,A-HP 1> 0>>
 <ASSERT "spend refuses when short" <NOT <SPEND ,HERO ,A-MANA 2>>>
 <ASSERT "a refused spend costs nothing" <==? <STAT ,HERO ,A-MANA> 1>>
 <ASSERT "spend pays" <SPEND ,HERO ,A-MANA 1>>
 <ASSERT "spend debits" <==? <STAT ,HERO ,A-MANA> 0>>
 <ASSERT "spending nothing is refused" <NOT <SPEND ,HERO ,A-HP 0>>>
 <ASSERT "spending a negative amount is refused" <NOT <SPEND ,HERO ,A-HP -3>>>
 <ASSERT "resources never go below zero" <AND <NOT <SPEND ,HERO ,A-MANA 1>> <==? <STAT ,HERO ,A-MANA> 0>>>
 <ASSERT "set-stat sets and returns" <AND <==? <SET-STAT ,HERO ,A-LUCK 3> 3> <==? <STAT ,HERO ,A-LUCK> 3>>>
 <ASSERT "other attributes are untouched" <==? <STAT ,HERO ,A-MIGHT> 4>>

 ;"Opponents are characters too, with their own table"
 <SET-RESOURCE ,SKELETON-STATS ,A-HP 7>
 <ASSERT "an opponent has its own health" <AND <==? <STAT ,SKELETON-STATS ,A-HP> 7> <==? <STAT ,HERO ,A-HP> 18>>>
 <LOSE ,SKELETON-STATS ,A-HP 7>
 <ASSERT "damage to an opponent leaves the hero alone" <AND <==? <STAT ,SKELETON-STATS ,A-HP> 0> <==? <STAT ,HERO ,A-HP> 18>>>
 <ASSERT "an opponent has no archetype until it becomes one" <NOT <BECAME? ,SKELETON-STATS>>>
 <BECOME ,SKELETON-STATS ,WIZARD>
 <ASSERT "any table becomes an archetype" <AND <==? <STAT ,SKELETON-STATS ,A-LUCK> 6> <==? <MAX-STAT ,SKELETON-STATS ,A-MANA> 6> <==? <MAX-STAT ,SKELETON-STATS ,A-HP> 10>>>

 ;"Dice: the runner's RANDOM counts 1, 2, 3 ... modulo the sides, so every
  die stays in range"
 <ASSERT "a roll of one die is in range" <AND <NOT <L? <SET ONE <ROLL 1 6>> 1>> <NOT <G? .ONE 6>>>>
 <ASSERT "no dice roll nothing" <==? <ROLL 0 6> 0>>
 <ASSERT "d1 is always one" <==? <ROLL 4 1> 4>>

 ;"Checks: the system rolls and grades, the language reports, the tier decides"
 <ASSERT "a check below the difficulty fails" <NOT <CHECK ,HERO ,A-MIGHT 99 1>>>
  <ASSERT "the check records the tier for the language" <==? ,REPORTED-TIER ,LAST-TIER>>
 <ASSERT "the check passes the difficulty to the report" <==? ,REPORTED-DIFFICULTY 99>>
 <ASSERT "the roll is a d20" <AND <NOT <L? ,LAST-ROLL 1>> <NOT <G? ,LAST-ROLL 20>>>>
 <ASSERT "a check an easy difficulty passes succeeds" <CHECK ,HERO ,A-MIGHT 1 1>>
 <ASSERT "success is at least tier 1" <NOT <L? ,LAST-TIER 1>>>
 <ASSERT "success does not meet a required tier above it" <OR <==? ,LAST-TIER 2> <NOT <CHECK ,HERO ,A-MIGHT 1 2>>>>
 <REPEAT ((TRIES 0))
  <CHECK ,HERO ,A-MIGHT 99 2>
  <COND (<OR <==? ,LAST-ROLL 20> <G? .TRIES 40>> <RETURN>)>
  <SET TRIES <+ .TRIES 1>>>
 <ASSERT "a natural 20 is found in a run of checks" <==? ,LAST-ROLL 20>>
 <ASSERT "a natural 20 is a critical, tier 2" <==? ,LAST-TIER 2>>
 <ASSERT "a critical meets the required tier" <OR <NOT <==? ,LAST-ROLL 20>> <NOT <L? ,LAST-TIER 2>>>>

 ;"A resource with a ceiling shows it; a plain attribute and an unbounded resource do not"
 <ASSERT "a resource with a maximum has a ceiling" <CEILING? ,HERO ,A-HP>>
 <ASSERT "a plain attribute has none" <NOT <CEILING? ,HERO ,A-MIGHT>>>
 <SET-RESOURCE ,HERO ,A-MANA ,NO-LIMIT>
 <ASSERT "a resource at NO-LIMIT has none" <NOT <CEILING? ,HERO ,A-MANA>>>
 <ASSERT "gain on an unbounded resource is not capped" <==? <GAIN ,HERO ,A-MANA 500> 0>>

 ;"The sheet and the status line come from the system's layouts and the language's names"
 <SET-STAT ,HERO ,A-HP 12>
 <PRINT-SHEET ,HERO>
 <PRINT-STATUS ,HERO>
 <CRLF>

 ;"The hero's name"
 <ASSERT "a new hero has no name" <NOT <NAMED?>>>
 <PUTB ,HERO-NAME 0 82>
 <PUTB ,HERO-NAME 1 0>
 <ASSERT "a stored name is a name" <NAMED?>>
 <PRINT-NAME>
 <CRLF>

 <TELL "RPG kernel tests completed." CR>>
