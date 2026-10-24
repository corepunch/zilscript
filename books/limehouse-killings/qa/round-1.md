# Blind playtest, round 1

Status: **blocked before ending**. No story source, maps, tests, design notes or saves were inspected during play. All 36 turns used only offered 1-based choices from `llm.lua --links`; full VM snapshot was saved after every action. Nine rooms were explored: gate, hall, library, dining room, pantry, kitchen, garden, greenhouse, servants' quarters. Raw player output and selected actions are preserved in `round-1.transcript.txt`.

Start command: `/tmp/lua5.4 llm.lua --new-game --links --game limehouse-killings --save /tmp/limehouse-r1.sav`.
Every following command: `/tmp/lua5.4 llm.lua --links --choose N --game limehouse-killings --save /tmp/limehouse-r1.sav`. Exact choices and resulting text appear sequentially in the transcript.

## Findings frozen before source inspection

1. **Required colored-book interaction unavailable.** Read page: “Among the marked books, follow the rainbow order: red, yellow, green, blue. Only then will the way open.” Examine ribbons: “RED on shelf 1, BLUE on shelf 3, GREEN on shelf 4, YELLOW on shelf 2.” The only offered action was `push bookshelf`, yielding “You push a book. Nothing happens. Perhaps there's an order to follow.” There were no color/shelf choices. This blocks the clearly signposted puzzle.
2. **Conversation unavailable through choices.** Library `tell moriarty` yielded “What do you want to ask Dr. Moriarty about?” without offering any topics. Hudson and Lady Ashworth similarly had only generic Tell actions. The mystery cannot be fairly tested without topic choices.
3. **Open-container contents have no choices.** Open leather roll revealed “A lockpick set”; no link or Take choice appeared even after inventory/look. Open trunk revealed “A folded note”; look repeated it, still no note choice. Study is locked and explicitly asks for a key or lockpick, so this blocks progress.
4. **Newly revealed room object can require an extra Look.** Opening kitchen drawer reports a leather roll but its actions appear only after Look. The player should be able to act directly on what was just revealed.
5. **Stale Take actions and invalid incomplete Use actions.** Take telegram/glass remained offered after possession. `use glass`, `use on glass`, `use on footprint cast` are not understandable complete actions. Inventory also does not expose carried objects as usable menu targets after leaving their source room.
6. **Prose needs polish.** Kitchen's “A kitchen that has seen better days” is generic and grammatically detached from the otherwise atmospheric scene. Greenhouse mentions a second foxglove plant although the portable poison already exists in the pantry: botanically plausible, but weakens the identity of the evidentiary object and offers no interaction with this second source. The blue kettle's warmth beside a long-cold hearth is possible on a range but the heating source should be clear. Dining knife is scenery while another bloodied knife is evidence; distinguish the harmless place-setting cutlery explicitly.

## Positive observations and limits

The hall correctly describes the study as locked and Open rejects entry. The kitchen drawer description updates after opening. The hedge stops mentioning a glint after taking the unique bloodied knife and examination remembers its former position. Cabinet prose changes after opening. No duplicate portable object was observed in these nine rooms, but inaccessible rooms and ending are untested. Room prose establishes a strong rainy Victorian atmosphere; strengthen interaction clarity while retaining its tone. No claim of full completion is made.


## Remediation and verification

After freezing the findings above, content was inspected. The four marked books already existed as distinct fixed objects; the defect was missing prose links. Shelf and ribbon examinations now expose those objects and each book has an examination response. Generic conversations now expose explicit, linked topics. Drawer opening links the roll immediately and checks its actual location. The solved library retains the normal west exit link, and the newly opened secret passage and bank statement are linked at discovery. Kitchen warmth/prose, the competing greenhouse foxglove reference, and dinner cutlery wording were revised. The impossible four-letter dial for the eight-letter name MORIARTY was corrected to a lettered dial.

Focused headless assertions were added to `test/test-report-regressions.zil` for book discovery, ordinary exit retention, removed-container-content consistency, greenhouse labels, and conversational topic prompts. This test and `test-prose-reveal.zil` pass. `check-links.lua` checked 119 links; `check-link-targets.lua` parsed 38 targets successfully. Shared menu/container/inventory repairs belong to the parent runtime work and need the next independent blind playtest.

The exact `--choose` indices in order were: `10, 8, 15, 12, 8, 11, 13, 15, 8, 7, 9, 9, 8, 12, 11, 6, 12, 7, 10, 10, 8, 1, 15, 2, 16, 1, 13, 6, 16, 6, 10, 8, 9, 11, 8, 1`.

Additional source-level narrative repairs after the blind freeze: examination of the bloodied knife no longer claims knowledge of an inaccessible doctor's office; it describes the surgical blade and engraved initial. The chalk outline no longer pronounces an unsupported chronological sequence of stabbing then poisoning. Moriarty's response to a letter he has already read no longer treats knowledge of its contents as impossible. Lestrade no longer calls the case closed on seeing the ledger alone. These revisions preserve the clue chain while grounding deductions in what was observed.

Verification completed: existing parser walkthrough passes **630/630 assertions** after updating four obsolete prose expectations. `make test-pure-zil` passes. Focused report regressions were rerun after the final narrative edits and pass. These are source-informed mechanical checks, separate from the blocked organic first play.
