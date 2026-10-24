# Limehouse Killings — blind round 3 of 3

Frozen 2026-10-24 before reading any story source, tests, prior QA, maps, or design. Fresh seed 131; `/tmp/limehouse-r3.sav`; every turn selected a currently offered numeric `--choose` action. Observation used `--links`; no direct commands, state edits, or save-content inspection. Raw VM record: `round-3.transcript.txt`.

## Outcome

Reached Lestrade's explicit “The chain is complete” response organically, but could not finish the ending through the offered menus. Completed broad exploration: hall, gate, kitchen, garden, servants' quarters, greenhouse, study, library, secret passage, dining room, pantry. Gathered threat, method, financial proof, knife, seal and route evidence. Opened study with Hudson's keyring, window with lockpicks, bookshelf through the rainbow sequence, and name box through the correctly identified suspect. Preserved save for a post-fix continuation.

## Reproducible findings

1. **High — missing ending affordance.** After SHOW BANK STATEMENT TO SCOTLAND LESTRADE, response: “The same five hundred pounds in both records. Debt and blackmail: motive. The chain is complete.” TELL SCOTLAND LESTRADE ABOUT CASE says: “Then accuse your suspect and choose which proof leads the charge.” The current 263-choice menu contains no ACCUSE or proof-selection action. EXAMINE DR MORIARTY, SHOW BANK STATEMENT TO DR MORIARTY, TELL SCOTLAND LESTRADE ABOUT MORIARTY, TELL DR MORIARTY ABOUT CASE, and showing knife/seal do not unlock one. A menu-only player cannot make the requested accusation.

2. **Medium — opened roll described as tied.** OPEN DRAWER, OPEN LEATHER ROLL, TAKE LOCKPICK SET; leave kitchen for garden and return. Room output still says “A leather roll lies in the open drawer, neatly tied.” Its state is open and its tools have been removed.

3. **Medium — passage event contradicts unlocked door.** Unlock/open study using Hudson's keyring before completing library sequence. PUSH BLUE BOOK (after red/yellow/green) says “Its locked hall door is no longer the only way in.” The hall door is already open. The alternate route is useful and works, but the prose ignores established state.

4. **Medium — redundant comparison gate lacks a clear prompt.** Read poison label, examine greenhouse flowers and labels, read threat and debt ledger, question Moriarty about poison. TURN LOCKED BOX TO MORIARTY still says the three clues have not been connected. Only USE POISON BOTTLE ON EXOTIC PLANTS satisfies it, although both labels have already said “Aconitum - Wolfsbane” and Lestrade accepts the poison as the second case link before this comparison. No blocker after trying that comparison, but the feedback sent me back over already-understood facts repeatedly. Improve the specific missing observation prompt without bypassing the comparison.

5. **Low/usability — menu volume and unhelpful combinations.** Hall reached 263 choices, dominated by TELL-about-every-discovered-noun, SHOW/GIVE-every-item and doors attacked/opened/unlocked with everything carried. READ SECRET LEDGER WITH MAGNIFYING GLASS returns “How does one look through a magnifying glass?” and USE MAGNIFYING GLASS ON SECRET LEDGER returns the generic rejection. The meaningful cast/tool interaction works and deserves easier discovery than this noise.

An initial POISON topic canonicalization change was observed, but the offered POISON BOTTLE topic still produced Moriarty's admission; later menus retained the semantic topic. Not considered a book blocker.

## First-experience craft and fairness

The opening establishes a strong fog-and-beeswax detective promise. The kettle and cared-for servants' belongings give useful relief from murder-room morbidity. The chalk outline, cold ashes, passage dust, loan entry and suspect's retreat form a coherent physical investigation. Letter/flower/debt engravings make the box solution legible, with the comparison-feedback caveat above. Colored ribbons and the torn page make the shelf sequence fully fair.

Tool roles were distinct in practice: keyring provides legitimate study access; lockpicks free a rusted window; lantern reveals direction in passage dust; magnifier identifies a heel defect in the cast. Dust explicitly explains why magnification is unhelpful there and points to the cast, a good recovery cue. Lestrade's first/second/motive links give useful progress communication. The suspect's boot concealment is a satisfying response to presenting detail.

The bank statement repeats financial information already present in the ledger but adds documentary corroboration behind a substantial gate; this feels more like strengthening a case than a duplicate object. Poison bottle and pantry foxglove are differentiated substances, not arbitrary copies. No confirmed phantom object blocked this playthrough. The sealed parcel's wax monogram feels underused when Lestrade rejects it generically. Lady Ashworth's “cold and calculating” presence line is flatter than her meal and ribbon details. The ending itself remains unevaluated because it is inaccessible through menus.

## Recommendation

REVISE pending accusation/proof affordances and state-dependent prose fixes. Replay the preserved menu-only save to the ending after runtime repair; append post-fix results separately so these frozen observations remain intact.

## Post-freeze remediation and source-informed verification

The frozen section above records **126 numeric menu turns**. Only after freezing it and its raw transcript did source inspection begin.

- Fixed the ending affordance at its book-owned source: Hudson, Lady Ashworth and Moriarty now explicitly declare ACCUSE in their action handlers and delegate to the existing V-ACCUSE routine. This lets the normal menu discover the existing accusation grammar, including WITH-carried-evidence choices. No ending conditions were removed or weakened.
- Removed the roll's static “neatly tied” claim; presence prose remains accurate after opening and emptying it.
- Reworded the bookshelf-opening event so it respects an already-unlocked/open study entrance.
- Replaced the box's generic rejection with the specific missing clue category. When the missing prerequisite is the poison comparison, the response explicitly asks for that comparison; the gate still stays closed until it is done.
- Source-informed consistency fix: the bank statement now states £500, the amount Lestrade explicitly says he compares between the two financial records. Previously the statement said only “a large sum.”

The preserved save was then resumed through **two currently offered numeric choices**: ACCUSE DR MORIARTY, followed by ACCUSE DR MORIARTY WITH DEAD LETTER. The first asks which proof leads; the second reaches **THE LIMEHOUSE KILLINGS -- SOLVED**. This is a **post-source continuation**, not an uninterrupted blind ending. The separate `round-3-postfix.transcript.txt` contains all 128 turns, preserving the original blind transcript separately.

The ending pays off the discovered blade/drug/stair sequence, individual heel mark, wax seal and servant warning, then returns to the opening's domestic warmth through Hudson's tea. The proof choice produces an appropriately distinct confrontation. No unresolved blocker remains in this route.

Validation:

- `test/test-round-3.zil`: **12 assertions PASS**; the roll, door-event, comparison-prompt and statement-amount checks each failed against the corresponding unfixed text before repair.
- `test/test_round3_links.lua`: **PASS**, checks all three accusation affordances, the inspector gate, the lead-proof gate, and the solved ending. Confirmed RED with the missing actor verb declarations, then GREEN after restoration.
- Existing `test/test-round-2.zil` and `test/test-report-regressions.zil`: **PASS**.
- `tests/test_limehouse_walkthrough.lua`, run with isolated temporary save paths: **630 passed, 0 failed**, covering the full parser/process golden path and command regressions.

Final recommendation: **READY WITH RISKS**. The low-priority menu-volume and generic wax-seal feedback observations remain usability/editorial risks, not unresolved progression failures. Menu density is shared runtime behavior; this book now exposes all of its required actions through the ordinary discovery contract.
