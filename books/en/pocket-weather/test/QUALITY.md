# Release quality status
Author construction stages 1-8 complete. Author technical gates and both endings GREEN. Source-informed numeric proof remains clearly separate from blind evidence.

## Independent blind round 1
Frozen report: `BLIND1.md`; transcript: `blind1.transcript`. Seed 823; completed in 83 numbered actions without hints/restart. FINISH and terminal saved state verified. Tester read only PLAYING.md and player-visible CLI output until the report was frozen.

| Finding | Ownership | Iteration 2 status |
|---|---|---|
| Premature rain assumes unheard agreement | Book | Fixed; noise/listen/understanding/agreement/publication stages tested |
| Stale moved-object actions | Shared reader | Resolved in shared reader; round 2 observed no inaccessible NPC manipulation |
| Menu pairing noise/duplicates | Shared reader | Resolved by shared scope/deduplication plus authored partner lists; round 2 found no exact duplicate labels |
| Emptied apron still bulges | Book | Fixed; actual reveal turns pockets out and revisits show empty pockets |
| Ask/Tell label mismatch | Shared reader | Resolved in shared reader with Ask-about labels |
| Moral over-explanation | Editorial | Removed two explanatory sentences; story actions carry meaning |
| Final pause caller vague | Editorial | Drizzle names Ludo's request; shower retains Nimbus's own request |

Related state defects found during author remediation: shown flower bypassed chime noise, absent Mica answered bell, and slot claimed card remained after retrieval. All fixed and covered by actual-parser tests.

## RED/GREEN and current checks

Both independent blind runs are complete. All reported book-owned mechanical findings are resolved with parser regressions. Final parent release/integration confirmation remains separate; no further story additions without coordination.

Broad substrate regression: `make test-pure-zil` GREEN after book remediation (2026-10-24).

## Focused menu-metadata follow-up


## Independent blind round 2 and final repair
Frozen evidence: `qa/BLIND2.md` and `qa/BLIND2.transcript.jsonl`. Seed 1926; 106 numbered actions, no hints/source knowledge, all twelve rooms visited, actual shower ending and persisted terminal state verified. Together with round 1's actual drizzle, both outcomes have independent blind completion evidence. The second player confirmed the transfers, emptied apron, published-card retrieval, NPC movement, noise recovery, and pause payoff; no stale inaccessible actions or exact duplicate menu labels were observed.

The remaining two mechanical findings are now fixed:

- Forecast conversation acknowledges the earliest missing stage: listening, understanding yesterday, pause rule, measured route, prepared roots, agreement, writing, review, publication, then rain choice. It cannot send an agreed or published story back to listening.
- Bare Dig and wrong explicit tools acknowledge a held, accessible spoon and request its explicit use. Neither action silently borrows it or changes the gutter.


The round 1 and round 2 parser suites were subsequently migrated to `test-round-1.zil` and `test-round-2.zil`; the counts above describe the original Lua runs.
