# Author verification
Run from apps/adventure-arena/zilscript with PATH=/tmp:$PATH on this workstation.

- `lua5.4 run-zil-test.lua books.last-broadcast.test.test-walkthrough`
- `lua5.4 run-zil-test.lua books.last-broadcast.test.test-regressions`
- `lua5.4 run-zil-test.lua books.last-broadcast.test.test-exits`
- `lua5.4 books/last-broadcast/test/test_last_broadcast_links.lua`
- `python3 books/last-broadcast/test/menu_cli.py`
- `lua5.4 scripts/check-vocab.lua books/last-broadcast/dungeon.zil`
- `lua5.4 scripts/check-links.lua books/last-broadcast`
- `lua5.4 scripts/check-link-targets.lua books/last-broadcast`
- `lua5.4 scripts/check-responses.lua books/last-broadcast`

The 80-command parser route is route.json; it includes optional scenic evidence, a deliberately blocked exit, and a recoverable wrong accusation. Standard READ implicitly picks up some portable evidence, so the three subsequent TAKE attempts in that diagnostic route are harmless repeats. The numeric route omits those repeats and must select actual emitted menu numbers. The numeric route also includes three optional, earned confrontations with Ada (disc, boots, weapon). The source-informed Lua menu regression and the cross-process CLI proof are author verification, not blind QA. The CLI proof persists every choice, reaches FINISH, restores the ending and verifies running=false.

Focused regressions verify hidden container contents, default TAKE/DROP/CLOSE behavior, mutable descriptions, physical mounting/removal of the needle, explicit wrong-tool rejection, closed versus open nested held containers, both states and directions of the service hatch, retained route knowledge, premature reconstruction/accusation refusal and recovery after a wrong charge. The exit test traverses all 30 directed edges and their reverse through the parser. The full route verifies real evidence flags independently of command transport.

Bug ledger (resolved): missing V-SCORE at FINISH; a generated gramophone adjective colliding with carried RECORD; virtual mounted stylus despite unchanged location; stale closed-sleeve/bag/hatch descriptions; inherited random inventory fumbles; inconsistent early draft of Ruth's kitchen timeline. Parent's independent reviews are tracked separately in QUALITY.md.

Blind-round-1 regressions (each observed RED before the source fix, GREEN after):

- `lua5.4 run-zil-test.lua books.last-broadcast.test.test-blind1-casebook`
- `lua5.4 run-zil-test.lua books.last-broadcast.test.test-blind1-accusation`
- `lua5.4 run-zil-test.lua books.last-broadcast.test.test-blind1-confrontation`
- `lua5.4 run-zil-test.lua books.last-broadcast.test.test-blind1-reconstruction`
- `lua5.4 run-zil-test.lua books.last-broadcast.test.test-blind1-comparison`
- `lua5.4 books/last-broadcast/test/test_blind1_audio.lua`

The first notebook read is a factual observation log. Explicit `HINT CASEBOOK` is the optional next-step walkthrough interface. Reconstruction organizes evidence without naming a culprit; player accusation supplies the final inference. Shared reader/menu findings are tracked by the parent, separately from these book regressions.

Reader relationship/discovery regression: `lua5.4 books/last-broadcast/test/test_reader_interactions.lua`. All 35 objects declare binary INTERACTIONS. The test covers immediate weapon discovery, useful equipment actions, intentional wrong-tool experiments, clock comparison and all four of Ada's relevant exhibits, while rejecting unrelated pairs. Parent-owned scope filtering also applies, so a valid relationship never reveals a hidden or remote object by itself.


Final blind2 presentation regressions (RED before the focused fix, GREEN after):

- `lua5.4 run-zil-test.lua books.last-broadcast.test.test-blind2-clock`
- `lua5.4 books/last-broadcast/test/test_blind2_prose.lua`

The independent 117-choice no-hint completion and fresh-process terminal proof are preserved in qa/BLIND2.md and qa/BLIND2.transcript.jsonl. The later focused copy/state-caption confirmation is source-informed and recorded separately.
