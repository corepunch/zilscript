# Blind typed playtest

The Terra playtest began on Zilscript commit
`d222b5c56ac808208f118737e3ed78da12382935`. They saw the game's replies to
their own typed parser commands and used in-game hints when needed. They
played without story source, walkthroughs, earlier transcripts, or companion
choices. A second group played each of the five translated editions
independently, without knowledge from the English playthroughs. The table
uses those independent sessions. The earlier translated sessions are also
preserved. The coverage is one ending per edition.

The seeded sessions started at 97 and replayed only the player's previously
typed commands to resume between batches. The standalone CLI sessions listed
with an unrecorded seed used ordinary save and restore. Their original
transcripts are preserved. There are separate deterministic repeats of the
[English](en-blackout-at-meridian-seeded.txt) and
[German](de-blackout-at-meridian-seeded.txt) Meridian sessions.

## Outcomes

| Edition | Seed | Ending and transcript |
| --- | --- | --- |
| German Blackout at Meridian | 97 | [Die Lichter von Meridian](de-blackout-at-meridian-independent.txt) |
| German Borrowed Tomorrows | 97 | [Platz für jeden Namen](de-borrowed-tomorrows-independent.txt) |
| German Museum of Unsent Signals | 97 | [Private Rückantwort](de-museum-unsent-signals-independent.txt) |
| English The Bell That Grew Leaves | Unrecorded | [Three Leaves for Yes](en-bell-grew-leaves.md) |
| English Blackout at Meridian | Unrecorded | [The Lights of Meridian](en-blackout-at-meridian.txt) |
| English Blackwood Horror | 97 | [Sanitarium Survivor](en-blackwood-horror.md) |
| English Borrowed Tomorrows | 97 | [Room for Every Name](en-borrowed-tomorrows.md) |
| English House of the Ebb | 97 | [The Shore Hears](en-house-of-the-ebb.md) |
| English The Last Broadcast | 97 | [Case Solved](en-last-broadcast.md) |
| English The Last Door of Battleworld | 97 | [The Last Door Stays Open](en-last-door-of-battleworld.txt) |
| English Limehouse Killings | Unrecorded | [Solved](en-limehouse-killings.md) |
| English Museum of Unsent Signals | 97 | [Private Return](en-museum-unsent-signals.md) |
| English The Pocket Weather Bureau | Unrecorded | [A Forecast You Can Keep](en-pocket-weather.md) |
| English Silent Vector | 97 | [The Unplayed Witness](en-silent-vector.md) |
| English The Station at Minus One | 97 | [The Extra Stop](en-station-minus-one.md) |
| English The Midnight Ledger | 97 | [The Weight of the Record](en-the-midnight-ledger.md) |
| English The Water That Answers | 97 | [Case Closed](en-the-water-that-answers.md) |
| English Wondertown | 97 | [Heart of Wrenfold restored after repair](en-wondertown-repaired.txt) |
| Russian Blackout at Meridian | 97 | [Огни Меридиана](ru-blackout-at-meridian-independent.txt) |
| Russian The Last Door of Battleworld | 97 | [Последняя дверь открыта](ru-last-door-of-battleworld-independent.txt) |

Replay verification used seed 97 on the repaired build. All 20 routes
reached their recorded endings. The English Battleworld and Pocket Weather
routes can now end earlier when the newly supported command succeeds. In
Russian Battleworld, the newly accepted winch command opens the route north
on the first attempt, so the replay omits the later duplicate movement.

## Findings and fixes

| Edition | Reproduction | Repair and verification |
| --- | --- | --- |
| Wondertown | Wind the heart while carrying a soldier, music box, or doll arm. The response asks for companions without saying how to position them. Dropping toys beside the heart leaves the mechanism waiting. Separately, `ask Bertrand about heart` can ask the player to pick between two things both called “the workshop heart.” [Original attempt](en-wondertown-blind.txt) | The winding response shows a placement command. The parser accepts `place tin soldier beside heart`. A dropped toy still needs to be picked up to count. The duplicate topic is gone, and Bertrand can answer the question. The original player followed the new in-game guidance to the full ending. |
| Limehouse Killings | Solve the name dial, then `look in box` before touching the bank statement. The text calls the box empty despite the statement still being readable. [Original transcript](en-limehouse-killings.md) | Looking inside reports the contents. The typed walkthrough asserts the statement is there before reading it and that the box is empty after the statement is taken. It also checks that replacing the statement with a different item lists that item. |
| The Last Door of Battleworld, English | The prism describes a catch to push, but `push catch` fails. `reverse control` also fails in the converter chamber. [Original transcript](en-last-door-of-battleworld.txt) | The catch names the prism and reverse is accepted as a verb. The Worldship walkthrough uses both phrases and checks that reversing still requires reading the plans. |
| The Pocket Weather Bureau | After publishing the forecast, `ask Nimbus about drizzle` repeats the choice, and `choose drizzle` is unrecognized. [Original transcript](en-pocket-weather.md) | Nimbus describes the requested option without choosing it. The typed walkthrough asks about drizzle and selects it with `choose a drizzle`. |
| The Water That Answers | The opening asks the player to choose a profession. Typing the profession alone produces a missing-verb error. [Original transcript](en-the-water-that-answers.md) | The opening spells out the three accepted commands. A regression checks the opening and selects each profession using its command. |
| Blackout at Meridian | On the bridge, German and Russian help still tell the player to go north to the bridge. The Russian opening also invites profile inspection, but `осмотреть профили` fails. [German transcript](de-blackout-at-meridian-independent.txt) · [Russian transcript](ru-blackout-at-meridian-independent.txt) | Shared help now passes the hero's location to each edition. The Russian duty board also answers to the word players saw for profiles. Regressions check help in both locations and the profile alias. |
| Borrowed Tomorrows, German | The receipt says to mount the page using `SPANN`, but `spanne morgenblatt in leserahmen` fails. Standalone `hilfe` asks “Hilfe was?” [Original transcript](de-borrowed-tomorrows-independent.txt) | Both forms of the verb use the existing mount action, which still checks the page is unfolded. Help gives the next appropriate instruction at each stage. |
| Museum of Unsent Signals, German | Standalone `hilfe` asks “Hilfe was?” The rims and notches named in the clue are unrecognized. A sending button repeats generic playback guidance after the address clue is known. [Original transcript](de-museum-unsent-signals-independent.txt) | German help explains the basic commands, `Rand` and `Kerben` resolve to the spool, and both buttons tell the player to play the recording again after learning the clue. The focused typed route reaches the private ending. |
| The Last Door of Battleworld, Russian | The opening suggests inspecting cards but `осмотреть карточки` goes nowhere. Kamala suggests cranking the winch, but `крутить лебёдку` is unrecognized. `помощь` is unavailable. [Original transcript](ru-last-door-of-battleworld-independent.txt) | The setup gives working commands for inspecting and choosing each hero. The winch accepts the stated verb, and help explains the commands. The Worldship test exercises the opening and the winch on its way to the ending. |
