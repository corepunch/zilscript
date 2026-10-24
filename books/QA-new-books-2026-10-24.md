# Three new Arena Originals — release QA

24 October 2026. English story text and commands, matching the existing library.
All three books are bundled in Adventure Arena, registered in `llm.lua`, and
have original PNG covers. Their catalog metadata has no fabricated ratings or
reviews. Scoreless stories display moves rather than a fictitious score.

| Book | Rooms | Endings | Independent blind round 1 | Independent blind round 2 |
|---|---:|---:|---|---|
| The Pocket Weather Bureau | 12 | 2 | 83 choices; drizzle | 106 choices; shower |
| The Silent Vector | 14 | 2 | 131 choices; preserve | 121 choices; erase |
| The Last Broadcast | 13 | 1 | 127 choices; case solved | 117 choices; case solved |

All six independent runs reached actual terminal endings without requested
hints, source access or an author walkthrough. Each action was selected from
the current reader menu and executed across a full VM save/restore boundary.
Fresh terminal observations confirmed `running:false` and `actions:[]`.
The second round's full emitted actions and responses are preserved in each
book's `test/qa/BLIND2.transcript.jsonl`, alongside its frozen independent report.
Author walkthroughs and targeted regression tests are explicitly source-informed;
they are never counted as independent blind runs.

## Iterations

1. Build each world as real objects and gates, implement integrated puzzles,
   and reach the ending through real numeric menus. Verify alternate endings,
   wrong tools, containment, repeats and return paths with headless tests.
2. Independent first play, then fixes: stage cloud dialogue correctly; prevent
   early accusations from revealing unseen evidence; separate optional hints
   from ordinary notes; preserve the player's final deduction; repair natural
   tool verbs and reversed fitting; surface changed testimony. Apply the user's
   backward-design idea by tracing the final payoff to earlier physical and
   emotional clues. The detective's recognisable sound is planted up front.
3. Author explicit binary relationships and fix shared current-scope menus.
   Independent fresh second play, then focused final corrections: completed
   milestones change replies and descriptions; the actual carried spoon is
   acknowledged; Vane is unambiguously the victim; solved clock evidence stays
   solved in prose; sample containment and missing prerequisites are truthful;
   duplicate repair spellings and singular shears grammar are removed.

Each concrete book-owned finding has a reproducing regression, including checks
observed failing before the fix. Final author confirmations replay complete
endings; they do not claim a third independent blind round.

## Shared reader corrections

The shared Session and Suggestions modules live in `zilscript/reader/`. The app
imports them directly; their former application files have been removed. This
keeps standalone ZILScript numeric play and regression tests independent of the
parent app, while checking the same action implementation. CI runs the new-book
regressions in a standalone checkout.

- Resolve object actions against actual current VM scope, including accessible
  inventory, rather than offering remembered local manipulation after a transfer
  or an NPC's departure.
- Deduplicate secondary nouns by object identity; resolve canonical parser names
  so a prose alias does not become a second topic or replace a different tool.
- Filter two-object combinations using ordinary `INTERACTIONS` object properties.
  All 89 new objects declare their relationships. Useful wrong-tool experiments
  remain; hidden objects and unavailable physical exhibits are not leaked.
- Conversation menus say “Ask about” while executing the actual story grammar.
- Finish link-reader games through the native quit signal, with terminal VM
  persistence and no unsupported parser restart prompt. Application sessions
  stop offering actions after their coroutine ends.
- Read normalized `SCORE_MAX` for classic games; Zork I reports its actual 350.

The children's source-informed menu route peaks at 33 choices, down from about
80 in the first blind run; the horror route peaks at 27, down from 107. These are
observations on specific routes, not universal maximum claims for every state.

## Verification and limits

App-level regressions exercise all three real catalog entries, opening scope,
linked examination, replayed application saves, covers, metadata and status lines.
Book tests cover all five endings and the reported state/order/tool failures.
`test-new-books` runs every new book's focused ZIL and Lua regressions; the
standard pure-ZIL target includes it. Lint now discovers every `books/*/dungeon.zil`
instead of naming only the original three titles. The old book link-ending test
also checks the revised native terminal lifecycle.

Final results:

- Root Adventure Arena suite: **21/21 test files, 1200 assertions**, all pass.
- After the final prose/menu corrections, the real new-book runtime, scope/menu
  and persisted-link suites pass again: **59 + 20 + 26 assertions**.
- `make test-new-books test-pure-zil lint-zil`: **pass**, including all five
  endings, final focused regressions and the original books' reader routes.
- `make test-llm`: **131/131 persistence tests pass**.
- Six-book lint: **0 critical vocabulary findings**, **914 prose links**,
  **221 parser link targets**, **5875 common-verb commands**, all pass.
- Final numeric CLI proofs: **48 / 62 / 82 choices**, actual persistent terminal
  endings for Pocket Weather / Silent Vector / Last Broadcast respectively.
- Both repositories' `git diff --check`: pass.

Frozen terminal VM snapshots are preserved beside each blind2 report as
`test/qa/BLIND2.sav`. The subsequent final prose corrections are verified by the
focused regressions and source-informed routes, not retrospectively attributed
to the independent reader.

All three generated covers were inspected visually; prompts and workspace asset
paths are in [COVER-PROMPTS-2026-10-24.md](COVER-PROMPTS-2026-10-24.md). The native
application screenshot attempt failed because the sandbox's macOS capture/XPC
services could not create an image from the window. No successful full-window
visual QA is claimed. Templates and native layout code were not changed.
