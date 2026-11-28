# Release perspectives


## Independent blind round 1

Reader completed The Unplayed Witness, seed 824, 131 numeric choices, no hints, terminal state persisted. Report and full transcript were frozen before author inspection: `/tmp/vector-blind1-report.md`, `/tmp/vector-blind1-transcript.json`, `/tmp/vector-blind1.sav.transcript`.


## Menu metadata author confirmation

All 29 objects now have explicit binary interaction policies, without changing unary parser behavior. A new Session-level menu regression was RED before metadata and GREEN with it, retaining useful wrong-tool and wrong-storage responses while removing irrelevant combinations. Both full parser endings, the seven fast ZIL tests and the blind1 regression remain GREEN. This addresses the book-owned relationship authoring part of blind1 finding 3 alongside the parent's shared scope/deduplication fixes. This author pass preceded the independent round 2 below; it did not replace that playtest.

## Independent blind round 2 and final polish

The fresh second reader used seed 1928, chose 121 actual numbered actions, requested no hints and reached **Four Pulses** through Erase. Transcript JSONL line 122 records `running:false` and `actions:[]`; line 123 independently confirms saved terminal persistence. Frozen player observations and full emitted choices: [BLIND2.md](qa/BLIND2.md), [BLIND2.transcript.jsonl](qa/BLIND2.transcript.jsonl). This reader found no blocking defect and assessed the independent measurement, character testimony, custody risk and warm-hand conclusion as an earned chain. The reader also tested reversible containment after departure preparation, wrong tools, fitted-spool safety and honest remote NPC/sample scope.



The original parser regression was subsequently migrated to `test-blind1-parser.zil`.
