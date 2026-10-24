# Wondertown — round 2 remediation

The blind report and blind transcript remain frozen in `round-2.md` and `round-2.transcript.txt`. Source inspection and repairs started only after both files were saved.

## Repairs

Object action handlers now expose the book's existing wind, lubricate, give, and position actions on the objects that support them. Their puzzle routines remain the owners of actual state changes. This fixes the three blind blockers and prevents the same missing-menu defect at Old Tick, the tower, and the heart. Binary wind/lubricate grammar identifies its second object as a carried tool.

The loft ladder has a climb action that respects its oil gate. The downstairs clock has an enter action that respects study access. Revealed objects and newly opened exits have immediate prose links. The cart's open cargo bed is a surface, so it does not advertise an invalid open action.

The opening introduces Pip and the missing-key objective. The brass winding key's description explains its use. Old Tick's dialogue now distinguishes the loft's latch from the downstairs clock it opens, naming the workshop floor as the route to the study.

## Evidence

- `test/test_round2_links.lua`: initially RED for fourteen missing action advertisements; additional ladder-gate and study-route assertions were separately reproduced RED. GREEN after the corresponding fixes. It checks advertised verbs, actual gate mutations, inventory, final heart state, companion count, and the ending. Runtime approximately 0.2 seconds.
- `make test-pure-zil`: PASS; includes the new regression.
- Book walkthrough: PASS through the ending.
- Round 1, description ownership, and prose reveal regressions: PASS.
- Vocabulary: zero critical issues. Prose links: 109 checked. Link targets: 52 examined through the parser. Common responses: 1,475 commands played.
- Code-informed verification, separate from the frozen blind play: fresh whole-VM numeric-link smoke restored the heart in 43 moves. Every command was selected from its current returned menu. Ending returned `running=false` and no remaining actions. Transcript: `round-2-fixed.transcript.txt`.

Shared menu defects were reported to the coordinating agent: multiple VERB? arguments were not all advertised, binary suggestions admitted scenery tools, aliases failed to resolve, and topic/object noun collisions obscured actions. Shared fixes are maintained outside this book remediation.
