# Author verification (source-informed)
Independent blind QA is coordinated by the parent task; these are author tests, not a claim of blind success.

Run from `apps/adventure-arena/zilscript/` with `PATH=/tmp:$PATH`:

```
lua5.4 run-zil-test.lua books.pocket-weather.test.test-opening
lua5.4 run-zil-test.lua books.pocket-weather.test.test-walkthrough
lua5.4 run-zil-test.lua books.pocket-weather.test.test-recovery
lua5.4 books/pocket-weather/test/test_pocket_weather_links.lua
lua5.4 books/pocket-weather/test/test_pocket_weather_world.lua
python3 books/pocket-weather/test/menu-walkthrough.py
lua5.4 scripts/check-vocab.lua books/pocket-weather/dungeon.zil
lua5.4 scripts/check-links.lua books/pocket-weather
lua5.4 scripts/check-link-targets.lua books/pocket-weather
lua5.4 scripts/check-responses.lua books/pocket-weather
```

Results at source freeze: all GREEN. Fast parser tests take about 0.05-0.15 seconds per module; real Session menu route about 0.18 seconds. World audit: 226 checks including every edge in both directions, all twelve revisits, focal nouns and five topics at each of four NPCs. Prose gate: 136 valid links, 18 room-link targets played through parser. Default-response smoke: 500 actual commands, no silence.

The source-informed **48-selection numeric-only route** calls the real `llm.lua --choose N` once per process and restores the VM after every action. `menu-walkthrough.json` records numbers, exact commands, room and output; `menu-walkthrough.transcript` is the raw prose-link transcript. It ends with `running=false`, entering FINISH. The reproducible Python script discovers the current index by exact expected menu command, then submits only that number. No hidden commands are submitted.

Both endings are tested: soft drizzle in the 53-step parser walkthrough and shower in the 74-step deliberately detouring recovery suite. The latter covers early invalid publication, hidden discovery, apron tools, wrong explicit tools despite carrying the correct one, reversible padding, premature promises, paper softening, container close/reopen, portable take/drop, and listening after cloud relocation. It includes optional flower acquisition/showing. Joke and biscuit topics resolve in the vocabulary audit.

A parser test assertion checks one postcondition at a time. Every gameplay action still passes through the real parser. Direct placement in the separate world audit isolates map edges and initial vocabulary; it is not evidence of puzzle completion.

# Author bug ledger
- Initial room light flags: changed LIGHTBIT to native ONBIT and declared directions; opening slice green.
- SHOW missing from substrate: declared supported book syntax and actor handlers; report exchange green.
- WITH menu assumes a carried tool: authored natural STEAM REPORT OVER KETTLE syntax, matching parser, hints and menu proof.
- Counterweight repeat text: now reflects actual rook location before wind measurement.
- Fixed chime noise only blocks conversation in Cloud Hollow; terrace listening works after untying.
- Public card action: card owns PUT; room links the carried card so its actual menu action can publish.
- Removed misleading remote direction links and gave weather card a distinct adjective from forecast topic.

No known unresolved author mechanical defects at freeze. Independent findings remain open until parent review.

# Blind-round-1 remediation
Independent evidence and status are in `BLIND1.md` and `QUALITY.md`. The regression suite is:

```
lua5.4 books/pocket-weather/test/test_pocket_weather_round1.lua
```

It runs 96 checks through the real parser. Fourteen expectations failed before the source fix; all pass afterward. It also reaches the revised drizzle ending after actual preparation, negotiation, approval, transmission, card retrieval, and a check that the absent postmaster does not answer the bell. Both rain verbs are tested before the quiet/listen/understanding/agreement milestones. Showing a flower through the loud chime cannot invent intelligible speech. The current prose count is 140 links; other audit counts above are unchanged.

`PATH=/tmp:$PATH make test-pure-zil` also passed after iteration 2. The full output is in `/tmp/pocket-weather-broad-suite.log`; parent will repeat shared-reader affected checks after its integration changes.

# Authored menus before blind round 2
Every object's binary action partners are declared by ordinary `INTERACTIONS` data. The source-informed real-Session test proves the same 48-selection route and reports a largest menu of 33. Its new assertions reject irrelevant card gifts, steaming people and spoon/report storage while preserving meaningful wrong-tool experiments. Shared canonicalization now emits `tell nimbus cloud about pause rule`; both this test and the separate CLI proof use that exact supplied command.

# Final blind-round-2 regressions

```
lua5.4 books/pocket-weather/test/test_pocket_weather_round2.lua
```

Ten expectations were RED against the frozen round-2 source, then all 69 checks GREEN. The test asks about the forecast after listening, agreement, writing, review and publication; verifies accurate bare-Dig/explicit-wrong-tool inventory feedback without changing the gutter; and reaches the actual shower ending. Existing complete drizzle and recovery/shower walkthroughs, 96 round-1 regressions and the 48-selection real-Session route also pass. No links or metadata changed, so the numeric route and menu size are unchanged. Independent evidence for both endings is recorded separately in `BLIND1.md` and `qa/BLIND2.md`.
