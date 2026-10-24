# Limehouse Killings — blind round 2

Frozen before source, tests, maps, design documents, prior reports or save contents were inspected. Played only the current `--links` actions with full CLI save/restore each turn. Transcript includes raw JSON menus. One restart followed a link-only trap in the study; no injected state or unoffered commands. Shared menu fixes landed during the second run, so this reports observations against both interface generations. Parent requested freeze before the third fresh pass.

## Outcome

Explored gate, entrance hall, library, secret passage, study, dining room, pantry, kitchen, garden, greenhouse and servants’ quarters. Opened containers and investigated all reachable clue areas. Did not finish: the name dial had no offered Moriarty target. First run entered study from secret passage and had no offered return west, while south was locked and window required absent tool. Restarted and independently obtained the study key via Hudson, then opened the front door and revisited the study.

## Functional findings

- **High: name dial cannot be solved through links.** Read ledger, torn page and unsent letter; examined box. Text explicitly requests TURN BOX TO a name. Initially menus had only TURN WITH. After shared fix, TURN TO/FOR appeared but targets were objects in room/inventory, never Moriarty. The letter names him but exposes no usable name topic.
- **High: secret passage return omitted in study prose.** Entered east from passage, then study menu offered neither west nor any passage. A player without key/tools cannot return to collect them. Window requires tool and southern door is locked. Keep the route explicit in both directions.
- **High, shared interface (fixed in progress): lockpick links generated TAKE SET**, rejected as missing noun. Taking its open leather roll carried the set indirectly. Later OPEN WINDOW WITH LOCKPICK SET still requested a tool; inspect direct versus nested ownership rules before declaring this content or runtime.
- **Medium, shared interface (fixed in progress): `glass` ambiguous with window** and no offered disambiguation response. Later MAGNIFYING GLASS resolved.
- **Medium: dust trail is a promised clue with no response.** Passage description emphasizes a single trail; EXAMINE DUST says nothing special, magnifying glass on dust rejected. Explain what the trail does or cannot establish.
- **Medium: contradictory bottle location.** Study room puts bottle on mantelpiece; examining outline says bottle left on desk.
- **Medium: meaningful tool affordances are weak.** Magnifying glass bare USE says it reveals fine details without doing so. Use on chalk outline fails. Lantern lights but no relevant darkness had yet made it useful. Footprint cast has a native USE ON action, but could not assess suspect comparison before freeze. Keyring says each key opens a different lock, encouraging interchangeable universal key expectations.
- **Medium, shared interface: menu flood.** Study inventory generated over 200 choices, most nonsensical: read-with any object, turn-box-for every carried thing, use tool on itself, show NPC to object. Grammar validity alone is not semantic relevance.
- **Low: NPC topic junk examines.** After TELL HUDSON invitation, EXAMINE MASTER/ALIBI/KEY returned generic nothing special; TELL HUDSON ABOUT KEY did work and gave key. TELL ASHWORTH reveals marriage/alibi/case but those likewise become meaningless examines. These topics should be explicit dialogue affordances.
- **Low: state feedback.** After study door opened, north link appeared only after LOOK restated room. Existing TAKE CHARCOAL/FOXGLOVE/KNIFE choices remained TAKE after acquisition until leaving room; potentially legacy dynamic-link targets versus held scope.

## First-experience literary review

The atmospheric register is confident: the interrupted dinner, Hudson’s squeaking cloth, the greenhouse color shift and warm kettle provide distinct textures. The repeated first-visit personifications (hall listening, house silenced, museum violence) begin to feel authored by the same sentence machine, though the tactile details usually carry them. Several clue responses fall back from the opening’s polish to flat dossier entries: initial M equals Moriarty; debt is £500; experiments finance statement. Let witnesses speak as people protecting something and let evidence state what is physically observed before interpreting it.

The central reasoning currently feels like accumulating repeated Moriarty pointers rather than testing an apparent contradiction. Knife, seal, debt, threat letter and name dial all point straight to the same name, while the poison/blood contradiction is potentially interesting but not yet developed in reachable scenes. The transitional line claiming the investigation has changed after four book presses is premature: I had not yet seen the body scene or its evidence. The color sequence is explicitly supplied, so the puzzle measures following an instruction, not detection. The first-session locked study trap is particularly damaging because an early success immediately removes exploration.

## Unique tools and scenery

Inventory is approachable when queried, and opening drawer → roll → lockpick listing worked structurally. The blunt dinner cutlery is repeated but unlinked; if this is merely a knife contrast, describe it as such without implying an obtainable tool. Potting bench says soil and tools, neither available as objects. Kettle card instructs tea first but no drink/pour action appeared. These may be atmospheric, but the requested no-phantom standard calls for supported responses or narrower prose. Neither every decorative noun nor every witness topic needs a fake item. Use the right scoped topic/control instead.

## Required before next blind round

Fix dial name linking and reverse passage; clarify tools and nested possession; replace empty/default clue responses and contradictory bottle geography; verify end-to-end link-only route against stabilized shared runtime. Functional observations above are reproducible evidence, not design assumptions; unvisited endings and late areas remain unassessed.


## Post-freeze remediation and correction

This section was written after source inspection; the blind account above remains unchanged. The study was **not actually a softlock**: OPEN DOOR from inside already drew back the bolt. I had examined the locked door but failed to try opening it. The revised room text now explains that interior bolt, and a reciprocal hidden stair provides the missing return route. Initial dialogue concern was likewise narrowed during play: TELL person ABOUT topic worked; default topic examines were the defective affordance.

Content fixes now applied:

- Linked Moriarty in the two evidence documents; shared runtime retains introduced global topics for the name dial. Numeric verification selected TURN LOCKED BOX TO MORIARTY and obtained the bank statement.
- Canonical map is library EAST → passage UP → study, reversed DOWN → WEST. The separate window route is study SOUTHWEST ↔ garden NORTHEAST. Removed the old library SOUTH alias. Updated executable walkthrough callers, companion and map; historical transcripts carry current-route notices.
- Picks now have the exclusive purpose of lifting the seized window catch; keyring opens the warded study lock. Bare OPEN WINDOW and wrong-tool attempts leave it closed. OPEN WITH and USE PICKS ON WINDOW work explicitly. HELD? plus ACCESSIBLE? accepts picks inside an open carried roll and rejects a closed roll.
- Lantern reveals the direction of disturbed dust; the lens accurately explains why a smeared trail cannot preserve a heel edge. Cast magnification remains its distinct identifying task. Walls and torn webs have authored observations.
- Fixed bottle geography; narrowed botanical identification so it establishes species rather than falsely proving a unique source. Removed premature investigative deduction after pressing books. Ending now explains weakening with poison, the blade from behind and escape via the hidden stair.
- Added concrete responses for cutlery and the garden rose, removed phantom bench tools, enabled DRINK TEA, gave conversation topics useful guidance, and made open-window descriptions current. Linked late-state witnesses and Lestrade so current prose exposes them.

Verification: new `test/test-round-2.zil` first failed on missing return route, then passed all route/tool/ownership/dust/tea/cutlery/bottle assertions. Existing report/prose regressions passed. Parser walkthrough passed 630 assertions; companion suite passed 13 tests. Initial lint passed 149 targets and 4775 commands; subsequent minor prose/scenery additions require the parent's final rerun. Broad pure-ZIL initially hit a shared OIL dictionary collision in the Zork walkthrough; parent reports the shared repair and a green walkthrough.

The source-informed numeric-only verification is saved separately as `round-2.verification.transcript.txt`. It reached the dial, selected its offered correct name, and collected the statement. It did not claim an organic ending. Its optional lantern step exposed the shared OIL/LAMP dictionary collision; parent fixed that afterward and requires a fresh game. Final numeric ending verification belongs to the fresh third round and parent release pass.
