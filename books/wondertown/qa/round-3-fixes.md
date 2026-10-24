# Wondertown round 3 — fixes and source-informed verification

This follow-up was written after the blind report and raw transcript were frozen. The original blind result remains **blocked before the study, no ending reached**. The verification below is source-informed and must not be presented as blind completion.

## Diagnosed and fixed

- **Repeat-winding clue gap.** The actual passage gate was a second WIND of Old Tick after earning Nutmeg's trust. The blind player had wound him before meeting Nutmeg, then revisited and talked to him; his generic answer never suggested repeating an already successful action. Nutmeg's default conversation after key handover now offers to meet Pip at the loft latch and explicitly asks for another winding. Old Tick's conversation explains the same mechanical step. Examining the closed workshop clock after key recovery points back to its twin in the loft. The underlying gate is retained.
- **Stale Nutmeg state.** Friendly/no-key descriptions incorrectly required trust greater than 2, while gifts only reached 2. Room, examination, and key conversation now use actual key handover state. Giving the scarf before handover no longer claims the key has already left her neck. Negative-trust descriptions remain unhappy even after handover and do not invent a returned key.
- **Default conversation voice.** Nutmeg now answers in character before trust, after kindness, after key handover, and after opening the passage; the inappropriate manual response is gone.
- **Natural head return.** Giving the matched head to the headless doll now lets the cart receive it for her and opens the same gate as giving it to the cart. This preserves the cart's role and adds no replacement tool.
- **False arm promise.** The arm's examination no longer promises a matching doll that cannot be repaired with it. It is presented honestly as one of the broken pieces Tolliver still considered worth saving.
- **Repeated-companion exploit.** Repeating POSITION SOLDIER previously counted the same toy again and reached the ending. Only a carried companion can now be placed, and toys sustaining the heart become fixed there, preventing a take-and-replace duplicate as well. Post-ending placement cannot add further contributions. Distinct soldier and music box contributions still complete the heart with Nutmeg.
- **Phantom companion accounting.** Removed the unreachable Bertrand contribution branch and its never-set `BERTRAND-POLITE` flag. The status line reports actual contributors instead of an unsupported “of 6” total. Bertrand retains his concrete workshop gate role.

The menu identity, grammar, topic, and recipient-filter problems reported during blind play are handled in shared tooling by the parent task. No shared runtime, Suggestions, Session, or Makefile files were edited here. Temporary ACTORBIT experimentation during verification was reverted; no book object semantics were changed to work around filtering.

## Verification

`test/test-round3-regressions.zil` failed before the dialogue correction and independently failed on repeated placement and take-and-replace before those corrections. It now passes 19 independent observable assertions. Commands run separately from their postconditions; there are no combined coroutine-success/state assertions.

All 23 Wondertown ZIL files passed through `run-zil-test.lua`. The round-2 Lua link test passed; the companion integration suite passed 79/79. `make test-pure-zil` passed. Book-only audits passed: 109 links, 52 parsed link targets, and 1,475 response checks. `git diff --check` passed.

A fresh seed-97 session then reached **“Pip has restored the heart of Wrenfold”**, 59/100 points, three actual contributors, and `running:false`. Every command was selected by its current numeric menu index in a separate process using the same save. The route wound the loft clock before meeting Nutmeg, used the new direct head-to-doll action, read Nutmeg's explicit rewind clue, repeated the loft winding, entered the study through the workshop clock, read the diagram and journal, wound the heart, placed the soldier, attempted a duplicate placement (correctly rejected), and placed the music box. No `--action` or state editing was used in this ending verification.

The raw ending proof is `round-3-verification.transcript.txt`. The numeric verifier queried actions and stopped if an intended command was absent; initial dry runs encountered naming/filter changes while shared tools were being fixed. The delivered transcript is the final fresh run after those corrections, with the book's ordinary nonactor cart/doll flags.
