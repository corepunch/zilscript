# Author verification
Run from apps/adventure-arena/zilscript with PATH=/tmp:$PATH on this workstation.

- `lua5.4 run-zil-test.lua books.en.last-broadcast.test.test-walkthrough`
- `lua5.4 run-zil-test.lua books.en.last-broadcast.test.test-regressions`
- `lua5.4 run-zil-test.lua books.en.last-broadcast.test.test-exits`
- `python3 books/en/last-broadcast/test/menu_cli.py`
- `lua5.4 scripts/check-vocab.lua books/en/last-broadcast/dungeon.zil`
- `lua5.4 scripts/check-responses.lua books/en/last-broadcast`

The 80-command parser route is route.json; it includes optional scenic evidence, a deliberately blocked exit, and a recoverable wrong accusation. Standard READ implicitly picks up some portable evidence, so the three subsequent TAKE attempts in that diagnostic route are harmless repeats.

Focused regressions verify hidden container contents, default TAKE/DROP/CLOSE behavior, mutable descriptions, physical mounting/removal of the needle, explicit wrong-tool rejection, closed versus open nested held containers, both states and directions of the service hatch, retained route knowledge, premature reconstruction/accusation refusal and recovery after a wrong charge. The exit test traverses all 30 directed edges and their reverse through the parser. The full route verifies real evidence flags independently of command transport.

Bug ledger (resolved): missing V-SCORE at FINISH; a generated gramophone adjective colliding with carried RECORD; virtual mounted stylus despite unchanged location; stale closed-sleeve/bag/hatch descriptions; inherited random inventory fumbles; inconsistent early draft of Ruth's kitchen timeline. Parent's independent reviews are tracked separately in QUALITY.md.

Blind-round-1 regressions (each observed RED before the source fix, GREEN after):

- `lua5.4 run-zil-test.lua books.en.last-broadcast.test.test-blind1-casebook`
- `lua5.4 run-zil-test.lua books.en.last-broadcast.test.test-blind1-accusation`
- `lua5.4 run-zil-test.lua books.en.last-broadcast.test.test-blind1-confrontation`
- `lua5.4 run-zil-test.lua books.en.last-broadcast.test.test-blind1-reconstruction`
- `lua5.4 run-zil-test.lua books.en.last-broadcast.test.test-blind1-comparison`
- `lua5.4 run-zil-test.lua books.en.last-broadcast.test.test-blind1-audio`

The first notebook read is a factual observation log. Explicit `HINT CASEBOOK` is the optional next-step walkthrough interface. Reconstruction organizes evidence without naming a culprit; player accusation supplies the final inference. Shared reader/menu findings are tracked by the parent, separately from these book regressions.

Reader relationship/discovery regression: `lua5.4 books/en/last-broadcast/test/test_reader_interactions.lua`. All 35 objects declare binary INTERACTIONS. The test covers immediate weapon discovery, useful equipment actions, intentional wrong-tool experiments, clock comparison and all four of Ada's relevant exhibits, while rejecting unrelated pairs. Parent-owned scope filtering also applies, so a valid relationship never reveals a hidden or remote object by itself.


Final blind2 presentation regressions (RED before the focused fix, GREEN after):

- `lua5.4 run-zil-test.lua books.en.last-broadcast.test.test-blind2-clock`
- `lua5.4 books/en/last-broadcast/test/test_blind2_prose.lua`

The independent 117-choice no-hint completion and fresh-process terminal proof are preserved in qa/BLIND2.md and qa/BLIND2.transcript.jsonl. The later focused copy/state-caption confirmation is source-informed and recorded separately.

QA misbehaviour regressions (`lua5.4 run-zil-test.lua books.en.last-broadcast.test.test-qa-misbehaviour`): ENTER STATION walks into the hall instead of striking the station clock; witnesses answer HELLO, KISS, TAKE, FOLLOW, ATTACK and THROW in the story's voice and GIVE shows the exhibit; TURN reaches the routing switch (TURN is V-SPIN here); TEA names the cups; ASK ABOUT HEATER parses; PUT STYLUS IN/ON the gramophone mounts it and PUT DISC ON loads the platter. `menu_cli.py` rewrites numeric-route.json and numeric-transcript.txt each run.
