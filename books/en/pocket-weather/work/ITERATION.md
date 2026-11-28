# Stage 7 review and handoff
Premise, world plan, object scope, prose and implementation were built in that order. The first vertical slice was played before paper/negotiation completion; each later puzzle was exercised through parser and the growing walkthrough. A complete numeric-only real CLI route then exposed menu-level issues that parser commands alone did not catch.

Fairness review: five substantive puzzle mechanisms (trade, miniature water route, steam paper, sound padding, negotiated promise) converge. The final writing/review/publication sequence makes the resolution interactive, rather than adding an arbitrary riddle. Independent observation/repair work can happen in either order. No tool consumed, no clock, no death, no irreversible navigation. Aster keeps the actual traded button; ribbon physically attaches and detaches; report physically opens to reveal its flower; card physically moves into broadcast slot.


State review: rook, cloud and Mica move at meaningful events. Full-room revisit descriptions remain verbose. Stage milestones guard duplicate progress. Missing prerequisites explain the next observation; wrong explicit tools cannot borrow the right carried one. The fixed noise gate applies only to the hollow after the cloud moves.

Hint review: HINT gives three tiers per actual next prerequisite; repeated hints progress from attention, to direction/tool, to exact command. Solving a milestone resets the tier. The optional printed observation book encourages conversation before instructions. In-book menus are the engine's real parser menus, not a custom choice system.

Source freeze sent to parent for blind QA. No new story or objects may be added while that independent session runs without coordination. Next: receive independent findings, load bug-fixing guidance, reproduce RED, fix narrowly, repeat GREEN and the relevant blind confirmation.

# Iteration 2: frozen blind report -> RED -> repair -> replay
Independent blind round 1 completed in 83 numeric actions, no hints, no restart, terminal soft-drizzle ending. Its frozen report is `test/BLIND1.md`; raw parser output is `test/blind1.transcript`. The tester found the ending substantially earned by the earlier world actions.


Book changes:
- Rain feedback now follows the earliest unmet emotional stage: noise -> listening -> understanding yesterday -> agreement -> public forecast. It cannot mention “our promise” until AGREED is true, or bypass a loud chime with intelligible dialogue.
- Showing any object to Nimbus respects the same sound state; the flower no longer produces speech through noise.
- Searching the apron turns its actual room-held hidden objects out; subsequent room text has empty pockets.
- Bell response checks Mica's actual location and agreement state. The published slot checks the card's actual location; transmission stays published after card retrieval.

Backwards narrative check, from ending to opening:
1. Rain reaching each root pays off the mandatory spoon-cleared gutter, introduced by the thirsty seedlings.
2. A safe route pays off the mandatory vane measurement, obtained through an honest rook trade, rather than a guessed direction.
3. A child's request being heard pays off the report's unheard Ludo and the optional carefully preserved flower. The drizzle ending now names Ludo's final Pause. The shower ending keeps Nimbus's own Pause, so both town and cloud retain agency.
4. Stopping without failure pays off both the chart's raised hand and Nimbus's explicitly negotiated pause rule.
5. The public card records measured wind and cleared gutter, not a new solution introduced at the finish. Mica's approval and apology make the Bureau responsible as well.
6. The final dry pocket of air is Nimbus's voluntary affectionate act after listening earned trust.

Editorial changes remain small: removed two sentences explaining the moral the player has already understood; named the final child's request; made the written forecast explicitly cite the player's earlier work. No new puzzle, object or prerequisite was added. Source frozen again for fresh blind round 2.

# Focused menu-metadata pass before blind round 2


All required secondary nouns are introduced in current prose or inventory: kettle in the kitchen; report in the opened weatherbox; pause/promise in Nimbus's conversation; ribbon/button only after apron discovery; flower only after report reading. No offroom or hidden partner was added to compensate for the shared scope checks. A noun-order cleanup makes the topic's canonical command `pause rule`, retaining both RULE and PAUSE as parser synonyms. Documentation author is now Studio Null, matching catalog and cover attribution.

Story source frozen again after these focused metadata changes. No puzzle, object, route, prerequisite or ending behavior changed in this pass.

# Final iteration after independent blind round 2
The second fresh blind player completed in 106 numbered choices without hints, visited all twelve rooms, and chose the actual shower ending. The persistent report and complete JSONL evidence live in `test/qa/BLIND2.md` and `test/qa/BLIND2.transcript.jsonl`. Round 1 independently reached drizzle; round 2 independently reached shower. Both confirmed terminal saved state.

Only two book defects remained: Nimbus's forecast response forgot an already-established agreement, and bare Dig implied that the player had not brought the spoon they were carrying. The new parser regression produced 10 failing expectations before repair. All 69 checks pass after narrow dialogue changes, including listening/understanding/writing/review/publication states and an actual shower ending. Wrong explicit tools still do not automatically use the spoon.


The round 1 and round 2 parser tests were subsequently migrated to `test/test-round-1.zil` and `test/test-round-2.zil`; the historical counts above refer to the original Lua run.
