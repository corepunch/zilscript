# Author verification (source-informed)
Independent blind QA is coordinated by the parent task; these are author tests, not a claim of blind success.

Run from `apps/adventure-arena/zilscript/` with `PATH=/tmp:$PATH`:

```
lua5.4 run-zil-test.lua books.pocket-weather.test.test-opening
lua5.4 run-zil-test.lua books.pocket-weather.test.test-walkthrough
lua5.4 run-zil-test.lua books.pocket-weather.test.test-recovery
lua5.4 run-zil-test.lua books.pocket-weather.test.test-world
python3 books/pocket-weather/test/menu-walkthrough.py
lua5.4 scripts/check-vocab.lua books/pocket-weather/dungeon.zil
lua5.4 scripts/check-responses.lua books/pocket-weather
```



Both endings are tested: soft drizzle in the 53-step parser walkthrough and shower in the 74-step deliberately detouring recovery suite. The latter covers early invalid publication, hidden discovery, apron tools, wrong explicit tools despite carrying the correct one, reversible padding, premature promises, paper softening, container close/reopen, portable take/drop, and listening after cloud relocation. It includes optional flower acquisition/showing. Joke and biscuit topics resolve in the vocabulary audit.

A parser test assertion checks one postcondition at a time. Every gameplay action still passes through the real parser. Direct placement in the separate world audit isolates map edges and initial vocabulary; it is not evidence of puzzle completion.

# Author bug ledger
- Initial room light flags: changed LIGHTBIT to native ONBIT and declared directions; opening slice green.
- SHOW missing from substrate: declared supported book syntax and actor handlers; report exchange green.
- WITH menu assumes a carried tool: authored natural STEAM REPORT OVER KETTLE syntax, matching parser, hints and menu proof.
- Counterweight repeat text: now reflects actual rook location before wind measurement.
- Fixed chime noise only blocks conversation in Cloud Hollow; terrace listening works after untying.

No known unresolved author mechanical defects at freeze. Independent findings remain open until parent review.

# Blind-round-1 remediation
Independent evidence and status are in `BLIND1.md` and `QUALITY.md`. The regression suite is:

```
lua5.4 run-zil-test.lua books.pocket-weather.test.test-round-1
```


`PATH=/tmp:$PATH make test-pure-zil` also passed after iteration 2. The full output is in `/tmp/pocket-weather-broad-suite.log`; parent will repeat shared-reader affected checks after its integration changes.

# Authored menus before blind round 2

# Final blind-round-2 regressions

```
lua5.4 run-zil-test.lua books.pocket-weather.test.test-round-2
```
