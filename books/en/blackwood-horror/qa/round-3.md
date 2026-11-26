# Blackwood Horror — fresh blind round 3 of 3

Seed 79. Whole-VM save: `/tmp/blackwood-r3.sav`. Numeric links only, through `llm.lua --links --choose N`. No source, tests, design, maps, earlier reports/transcripts, or save contents read during the blind phase. This report records first-experience observations before source access. Raw tool JSON and numeric commands are in `round-3.transcript.txt`.

## Blind phase, first freeze

128 numbered-choice attempts. The tester explored the gate, reception, patient ward, operating theater, basement stairs/corridor/storage/boiler, flooded chamber, hydrotherapy, isolation, electroshock theater, padded cell, observation deck, administration, director's office, staff quarters, cafeteria, garden, and chapel. The brass key, scalpel, bag and contents, lantern, shovel, coal, syringe, safe key, chapel key and relic were discovered through object examination/search, not a walkthrough. The boiler was fueled and lit; the thawed cabinet yielded the syringe. The safe was opened through the hollow book and portrait. Chapel entered before finding any serum.

**Blocked at Chapel by link-only exit omission.** Entering from the garden prints no exit direction and offers no movement action. Repeated `look`, `inventory`, conversation, pew/candle examination and relic/empty-syringe interactions do not reveal a way back. The relic response explicitly says serum remains necessary. This is a reachable progression blocker for a player who reaches the chapel while still exploring other branches. A narrow exit prose correction was requested from the coordinator without asking for puzzle spoilers. The VM remains untouched.

## Findings

1. **High: Chapel has no linked return exit.** Evidence above. A room may be frightening without preventing a player from revisiting the world through the permitted interface.
2. **Medium: steam before ignition.** Turned basement corridor valve before ever entering the boiler room. The response correctly said the pipes were cold and no steam was present. After visiting storage and lighting the lantern, returning to the corridor described steam hissing overhead. The boiler was subsequently found cold with an empty firebox. Valve position alone must not imply generated steam.
3. **Medium: inventory friction undercuts investigation.** Reading most discovered records automatically takes them, including documents of apparent clue value. By hydrotherapy, the syringe could not be taken; putting the soggy notebook in the medical bag did not help. Later the relic required many document/tool drops in the chapel. The scene's apparent danger turned into a long series of item-management commands. No failure was caused, but it damages pacing and rewards the incurious player. The bag was not useful for relieving the limit.
4. **Medium: conversation breaks voice.** `tell patient patient about private notes` prints that Patient 189 thinks the player should reread the manual. The object is directly relevant to this character; a grounded in-world response is needed.
5. **Medium: action menus overwhelm meaningful choices.** The chapel menu passed 700 entries after inventory, mostly cartesian verb/tool combinations and remembered topic nouns. Examples include injecting with a notebook or chapel key, turning a pipe valve to the gate, and reading a ledger with a key. The canonical commands also contain `patient patient` and `strait straitjacket`. Many are harmless parser affordances, but the user's actual interface is these links; meaningful tool roles are obscured.
6. **Instrumentation incident, separate from content:** one emitted `examine ether bottle` index (62) was invalid on the following call and became 34 after relisting. The coordinator confirmed concurrent shared menu changes caused this. Subsequent choices relisted first and selected the same offered command against the current menu. This incident is not evidence of a reproducible game defect in the stabilized runtime.

## Writing and fairness

Strong moments: the overhead lamp pointing at the operating table "like an accusation"; the force pressed into the child's HOME drawing; the familiar handwriting on the 1947 straitjacket; the observation mirror's reluctant self-recognition. Searching real cabinets, shelves, and tubs makes the place tangible. Named key markings and the lantern striker support reasonable experiments. The shovel and scalpel have distinct successful jobs, and the dead flashlight does not duplicate the working lantern.

Weak moments: many medical documents repeat a nearly identical Patient 189 / Mordecai / treatment / chapel warning rather than contributing distinct discoveries. Several rooms lean on generic decay, darkness, unnatural green light, and "strange symbols" instead of specific evidence. The first relic interaction introduces "serum—if returned to its source" without the player having heard of serum; this may be an intended clue for another branch, but the missing chapel exit makes it especially unhelpful. The chapel patient remained inert through extended inventory work, so the warning to run had little mechanical force in this sample.

Outcome at first freeze: **blind blocked after extensive exploration; no ending claimed.** Remediation and any continued blind/source-informed verification must be reported separately below.

## Continued blind play after narrow coordinator fixes

The coordinator added only the missing chapel return direction to prose and corrected the cold-boiler steam description, without giving any puzzle information. No source was opened. The same VM continued: LOOK now offered south, and leaving the chapel briefly provoked pursuit into the garden. The tester retraced the explored route to the patient ward, tried the carried scalpel on the chains, and reached the morgue.

A new **high interface defect** occurred there. Opening the refrigerated drawers described a glowing *glass vial*. The menu offered `examine glass vial` with target `vial`, but that command examined the carried morphine instead; it printed the Morphine Sulfate label. No serum take action was available. LOOK did not correct it. An organic workaround succeeded: leave the morgue, inventory and drop the morphine in the patient ward, then return. The same glowing-vial prose now generated `examine strange serum` and `take strange serum`. This shows that a carried object's overlapping wording can suppress a critical object. Both objects need distinct natural names in their prose and linked commands.

The serum was obtained after dropping the automatically carried doctor's journal. The tester returned by the full explored route, then chose the offered `inject patient patient with medical syringe`. This drew serum into the syringe, invoked the carried relic, and freed Patient 189. The climax included remembering a former self, recognition of shared suffering, the patient becoming ash, and the smell of rain and grass. These concrete sensory details provide a satisfying release. `running` remained true.

The tester retraced the route to the front gate to reach the actual ending. At choice 189, a second **high missing exit defect** blocked finishing: the gate offers north only. Its prose and examination say it stands open, and OPEN returns "already open"; there is no linked direction out of the property. A second narrow prose correction was requested without source access. No ending/FINISH is claimed yet.

Additional craft concern: the rusty scalpel cuts "thick iron chains" by sawing for several minutes. That succeeded, but a surgical blade sawing heavy iron is physically unconvincing and makes the tool feel magical. The existing scene could instead identify a remaining strip of leather or wire whose material fits a scalpel, while retaining the same gate and its one tool role.

## Final blind freeze

191 numbered-choice attempts, including one rejected during the concurrent instrumentation update. Closing the gate resisted and left it open; another LOOK still had no outward exit. The organic session reached the successful Patient 189 climax but could not trigger the actual final termination. Report and full raw transcript were frozen before opening any book implementation or tests. Further verification is source-informed and must not be counted as a blind ending.

## Source diagnosis and remediation (after blindness ended)

The gate diagnosis above was a player inference. Source inspection showed **no outward gate route existed**: the intended ending already occurred at Patient 189's liberation, but its routine only set `GAME-WON` and returned to ordinary play. The clean correction is to call `FINISH` at that climax. No additional escape route was invented. The blind run therefore solved the intended adventure organically, after one narrow coordinator exit repair and an organic vial-shadow workaround; it did not reach terminal `running=false` on the original implementation.

Implemented corrections:

- The chapel's existing south return is linked in its room prose. Its ordinary and resolved descriptions both retain that route.
- Corridor steam requires both an open valve and a lit boiler. Opening a cold valve cannot imply generated steam.
- Every serum reveal now links **glowing serum → serum**. Carrying morphine no longer steals the critical link. Actual Session menu regression takes serum while leaving morphine carried.
- The morgue's chain is slack and its rusted padlock broken; a leather restraint strap actually binds the handles. The scalpel cuts leather, and the chain falls away. The same gate and tool remain; no interchangeable cutter was added.
- Patient 189 responds to Mordecai's private notes in-world, and unrelated topics receive a grounded response instead of the inherited manual joke. Conversation still cannot bypass the required objects.
- Blackwood disables Zork's inherited random inventory fumble in `GO`. The native weight limit remains. A deterministic low-roll negative control reproduces the old refusal, and the behavioral regression now successfully takes the linked serum with eight carried clues/tools. This removes an accidental random obstacle rather than adding carrying machinery.
- Medical records now distinguish sedation from awareness and supply specific storage directions for Compound 237 and the reusable syringe. Mordecai's private notes reveal his failed second-dose attempt and the cross's calming effect. These documents now contribute different operational clues.
- Liberation calls `FINISH`, exposing the terminal restart/restore/quit state and ending numeric-link play. Existing ending tests now verify that subsequent ordinary input remains in the terminal menu.
- Source review also found that the richest identity ending first merged the figure into the player's shadow, then said it crumbled to ash. Only the less complete recognition branches now crumble; the complete identity branch preserves its stated reunion.

## Verification

Fresh **source-informed** verification used another whole-VM save with seed 79, selecting only offered `--choose N` actions. It completed in **63 numeric choices**, with morphine still carried when the serum was found and taken. The final injection returned `running=false`, an empty action list, the successful liberation prose, and the terminal menu. This is separate from the organic blind evidence. Raw JSON and numeric commands are in `round-3-verification.transcript.txt`.

All **19 Blackwood ZIL suites passed: 386 assertions**, including the complete existing parser walkthrough. The actual reader/Session link-and-ending Lua regression passed. New coverage checks the chapel return, cold and heated steam descriptions, physical fastening state, distinct serum/morphine behavior, grounded topic handling, operational clue locations, the richest ending's consistency, and terminal closure. The new fastening and actual link/terminal regressions were observed failing before those fixes; the inherited fumble was additionally checked with a negative control. The coordinator’s earlier chapel/steam corrections were verified against the frozen player evidence.

Book audits passed: **0 critical vocabulary findings; 182 links checked; 59 link targets exercised; 2,050 commands played without a silent-response failure.**

Remaining assessment: generic horror vocabulary and some repeated administrative atmosphere are craft limitations, not progression blockers. The broad menu's generic cartesian combinations belong to the shared reader/suggestion layer and were reported to its owner. Optional props such as the dead flashlight, bell, bandages, and morphine have distinct descriptions and are not substitutes for the lantern, scalpel, serum, or syringe. The adventure is now finishable through its links with a terminal ending; this report does not claim that the original unmodified blind run terminated correctly.
