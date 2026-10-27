# Book vocabulary review — 27 October 2026

Reviewed every object declaration in all six `books/` adventures, against its
printed name, presence/discovery text, room context and action/examination prose.
There are 317 story objects. Limehouse additionally redeclares three substrate
internals (`GLOBAL-OBJECTS`, `QUOTE`, `INTQUOTE`) in `actions.zil`; those are
explicitly classified as parser machinery, not examinable story objects.

Expanded 299 objects with 208 noun aliases and 625 adjective entries.
Objects already adequately described by their vocabulary remain unchanged;
abstract topics do not receive invented physical adjectives.

| Book | Objects reviewed | Expanded | Nouns added | Adjectives added | Final nouns / adjectives per object |
|---|---:|---:|---:|---:|---:|
| blackwood-horror | 91 | 83 | 62 | 199 | 3.13 / 4.07 |
| last-broadcast | 35 | 34 | 14 | 64 | 3.77 / 3.26 |
| limehouse-killings | 70 | 69 | 64 | 140 | 3.39 / 2.93 |
| pocket-weather | 25 | 23 | 19 | 44 | 2.80 / 2.72 |
| silent-vector | 29 | 29 | 19 | 61 | 4.14 / 3.45 |
| wondertown | 67 | 61 | 30 | 117 | 3.18 / 4.43 |

The bundled original `infocom/zork1/dungeon.zil` has approximately 2.40 noun
entries and 1.52 adjective entries per object (122 object declarations). These
counts are an editorial diagnostic; semantically correct coverage matters more
than a word quota. No imported Infocom story source was modified.

## Findings and corrections

- Pocket Weather's dispatch bell now accepts SMALL and SOLID, matching its
  EXAMINE response. Blackwood's service bell accepts SMALL and BRASS, matching
  both LDESC and EXAMINE. Both respond to `ring small bell` and
  `ring small brass bell` through their real action handlers.
- Added missing sizes, materials, colors and conditions throughout: glass
  syringes, steel tables, heavy shovels, blue flowers, wool ribbons, calibrated
  wrenches, nonconductive shears, sapphire styli, small music boxes and tweed
  coats. Added ordinary alternate nouns and singular/plural spellings.
- Full names and titles parse, including `examine inspector lestrade` and
  `inspect inspector lestrade`. Limehouse's exact INSPECTOR alias now preserves
  its title meaning by targeting OFFICER, which has both noun and adjective
  meanings, rather than rewriting it to the bare surname.
- Fixed the shared runtime's six-character adjective registration. LEATHER
  and LEATHER-BOUND must share a stable adjective value, as must YELLOW and
  YELLOWED; registering a later spelling previously broke earlier objects.
- Kept Wondertown's loose envelope distinguishable from the mailbox's bundle
  of letters; a real-scope regression guards that distinction.
- Both Blackwood brass keys remain usable together in inventory. The key
  numbered 3 has the distinguishing printed/canonical name "reception key";
  the safe key retains its own name and its newly accepted brass modifier.
- Qualify authored commands where newly accurate aliases share scope:
  Wondertown's hints, companion and walkthrough say `POSITION TIN SOLDIER`,
  and Limehouse's Hudson confrontation says `SHOW UNSENT LETTER TO HUDSON`.
  The scenery's soldiers and the trunk's letter remain legitimate vocabulary.
  Literal tests prove both carried letters resolve with their distinguishing
  modifiers.
- Reader menu tests follow the newly qualified emitted commands; parser-driven
  gameplay transcripts still exercise bare nouns and ordinary existing forms.

## Durable gates

The content-writing, world-model, implementation and testing skills now require
an every-object prose vocabulary audit at original Zork density, including
EXAMINE/action text, aliases, titles, compounds, state and overlapping scope.
The writing manual and its source mirror carry the same contract.

`make test-book-vocabulary` validates printed modifiers, exercises every declared
synonym and adjective through the real parser, and asserts fixed prose phrases
against the intended object. The matrix covers all 317 story objects. It also
checks actual bell behavior, the inspector title/verb combination, adjective
registration in both orders and the envelope distinction. Parser-only probes
use an isolated lit room; they complement real-scope gameplay tests rather than
proving puzzle availability. Static lint checks printed-name modifiers; it does
not attempt to infer every adjective in arbitrary prose.

`make lint-zil` includes this gate, then checks link vocabulary, examines every
prose link in real scope, and plays common verbs on story objects. The root
`tests/adventure_arena_vocabulary.test.lua` supplies the fast headless bell,
literal-phrase and dictionary regression for `make test`.

## Verification results

- Vocabulary checker: 14 assertions pass; six book definitions have no critical
  printed-name issues.
- Vocabulary matrix: 317 story objects, 2,272 parser commands, zero failures.
- Full lint: 221 prose-link targets resolve; 5,875 common object commands answer.
- Unit suite, new-book walkthroughs and numeric reader routes, book playtest
  regressions, and the original Zork I/II pure-ZIL suite pass.
- Blackwood's complete walkthrough, Limehouse's cross-process walkthrough
  (630 assertions), and Wondertown's description/reveal suite pass.
- Four selected root app test files pass: vocabulary, ZIL runtime, new books,
  and reader session (226 assertions).
- Both repository diffs pass whitespace checks.

CLI suites used Lua 5.4.8 compiled from the repository's vendored sources into
`/tmp/lua-objc-vocabulary-bin`; no system interpreter was changed.
