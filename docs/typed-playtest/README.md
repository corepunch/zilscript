# Blind typed playtest

The Terra playtest began on Zilscript commit
`d222b5c56ac808208f118737e3ed78da12382935`. They saw the game's replies to
their own typed parser commands and used in-game hints when needed. They
played without story source, walkthroughs, earlier transcripts, or companion
choices. The table records one ending per book.

The seeded sessions started at 97 and replayed only the player's previously
typed commands to resume between batches. The standalone CLI sessions listed
with an unrecorded seed used ordinary save and restore. Their original
transcripts are preserved. There is a deterministic repeat of the
[Meridian session](blackout-at-meridian-seeded.txt).

## Outcomes

| Book | Seed | Ending and transcript |
| --- | --- | --- |
| The Bell That Grew Leaves | Unrecorded | [Three Leaves for Yes](bell-grew-leaves.md) |
| Blackout at Meridian | Unrecorded | [The Lights of Meridian](blackout-at-meridian.txt) |
| Blackwood Horror | 97 | [Sanitarium Survivor](blackwood-horror.md) |
| Borrowed Tomorrows | 97 | [Room for Every Name](borrowed-tomorrows.md) |
| House of the Ebb | 97 | [The Shore Hears](house-of-the-ebb.md) |
| The Last Broadcast | 97 | [Case Solved](last-broadcast.md) |
| The Last Door of Battleworld | 97 | [The Last Door Stays Open](last-door-of-battleworld.txt) |
| Limehouse Killings | Unrecorded | [Solved](limehouse-killings.md) |
| Museum of Unsent Signals | 97 | [Private Return](museum-unsent-signals.md) |
| The Pocket Weather Bureau | Unrecorded | [A Forecast You Can Keep](pocket-weather.md) |
| Silent Vector | 97 | [The Unplayed Witness](silent-vector.md) |
| The Station at Minus One | 97 | [The Extra Stop](station-minus-one.md) |
| The Midnight Ledger | 97 | [The Weight of the Record](the-midnight-ledger.md) |
| The Water That Answers | 97 | [Case Closed](the-water-that-answers.md) |
| Wondertown | 97 | [Heart of Wrenfold restored after repair](wondertown-repaired.txt) |

Replay verification used seed 97 on the repaired build. The 15 routes
reached their recorded endings. The Battleworld and Pocket Weather
routes can now end earlier when the newly supported command succeeds.

## Findings and fixes

| Book | Reproduction | Repair and verification |
| --- | --- | --- |
| Wondertown | Wind the heart while carrying a soldier, music box, or doll arm. The response asks for companions without saying how to position them. Dropping toys beside the heart leaves the mechanism waiting. Separately, `ask Bertrand about heart` can ask the player to pick between two things both called “the workshop heart.” [Original attempt](wondertown-blind.txt) | The winding response shows a placement command. The parser accepts `place tin soldier beside heart`. A dropped toy still needs to be picked up to count. The duplicate topic is gone, and Bertrand can answer the question. The original player followed the new in-game guidance to the full ending. |
| Limehouse Killings | Solve the name dial, then `look in box` before touching the bank statement. The text calls the box empty despite the statement still being readable. [Original transcript](limehouse-killings.md) | Looking inside reports the contents. The typed walkthrough asserts the statement is there before reading it and that the box is empty after the statement is taken. It also checks that replacing the statement with a different item lists that item. |
| The Last Door of Battleworld | The prism describes a catch to push, but `push catch` fails. `reverse control` also fails in the converter chamber. [Original transcript](last-door-of-battleworld.txt) | The catch names the prism and reverse is accepted as a verb. The Worldship walkthrough uses both phrases and checks that reversing still requires reading the plans. |
| The Pocket Weather Bureau | After publishing the forecast, `ask Nimbus about drizzle` repeats the choice, and `choose drizzle` is unrecognized. [Original transcript](pocket-weather.md) | Nimbus describes the requested option without choosing it. The typed walkthrough asks about drizzle and selects it with `choose a drizzle`. |
| The Water That Answers | The opening asks the player to choose a profession. Typing the profession alone produces a missing-verb error. [Original transcript](the-water-that-answers.md) | The opening spells out the three accepted commands. A regression checks the opening and selects each profession using its command. |
