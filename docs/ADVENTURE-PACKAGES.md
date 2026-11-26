# Adventure core, languages and rulesets

A story is built from three layers, each knowing nothing about the layer
above it:

```
story (books/<name>, infocom/zork1)       rooms, objects, prose
  rulesets/<rules>/<lang>.zil              the game's rules: classic, superhero
    languages/<lang>/base.zil              everything an adventure in that language needs
      core/                                language-neutral engine ZIL
```

Core and languages never name a story's rooms or objects. A ruleset stands on
its language's base and never on another ruleset. `tests/test_adventure_packages.lua`
checks all of this.

## Package layout

* `core/parser.zil`: parser state, `HERE`, LEXV/INBUF tables, syntax-table and
  dictionary offsets, and the helper routines shared by every language.
* `core/loop.zil`: the `M-*` handler codes, `PLAYER`, `P-WON`, `MAIN-LOOP`.
* `core/clock.zil`: the scheduler (`QUEUE`, `INT`, `CLOCKER`).
* `core/objects.zil`: `SEE-INSIDE?`, `CCOUNT`, `WEIGHT`, `HELD?`.
* `core/world.zil`: the world every adventure shares without text: the exit
  table layout and `DO-WALK`, `GLOBAL-IN?`, `FIND-IN`, room and object
  description state, verbosity, moves and score, and the shared world-verb
  code (`V-LOOK`, `V-FIRST-LOOK`, `PRE-DROP`, `PRE-PUT`).
* `languages/<lang>/`: `parser.zil`, `loop.zil`, vocabulary (`syntax.zil`),
  macros or messages, `verbs.zil` (the world verbs with their text: look,
  examine, take, drop, put, open, close, lock, walk, enter, climb, give, talk,
  wait, eat, drink, wear, switch on and off, save, restore, score, version)
  and `globals.zil` (the global objects the parser needs: `GLOBAL-OBJECTS`,
  `ROOMS`, `IT`, `NOT-HERE-OBJECT`, the hands and the ground).
* `languages/<lang>/base.zil`: the composition of all of the above. English
  inserts its vocabulary there; German stories insert `languages.de.init`
  (messages, TELL tokens, vocabulary) before their own objects.
* `rulesets/classic/`: Zork's rules. `common.zil` holds those without text
  (death and treasure counting, spraying), `<lang>-syntax.zil` and
  `<lang>-verbs.zil` the combat, magic, treasure and puzzle verbs with their
  words, `<lang>-globals.zil` Zork's scenery and characters (the sailor, the
  grue, zorkmids). `rulesets/classic/<lang>.zil` composes them over the base.
* `rulesets/superhero/`: `percentile.zil` holds the numbers (attributes,
  percentile checks, health, karma); `en-verbs.zil` the English words: the
  check report, the character sheet, and the hero actions (strike, attack,
  hit, rescue, disable, focus, choose, diagnose) with replies for when no
  object takes them. `rulesets/superhero/en.zil` composes them over
  `languages/en/base.zil`, without the classic rules.

Which form goes where was decided by references, not by hand: everything the
parser, loop and world verbs reach is the world; the rest of Zork's verbs are
classic. A form identical in two languages belongs in `core/` (parser, loop,
world) or `rulesets/classic/common.zil` (classic rules without text); the
test fails if one is duplicated again. Identical verbs with English text the
German edition never translated stay in each language, which owns the words.

The English world verbs name no story's objects and test no `ZORK-NUMBER`.
Zork I's own cases live in Zork I: an object's or room's action answers the
verb (`TREE-F`, `TREE-ROOM`, `MIRROR-ROOM`, `SANDY-CAVE-F`, `WATER-F`,
`PUTTY-FCN`), or `infocom/zork1/actions.zil` replaces a world routine with
its own ("Zork I's own world rules": `SCORE-UPD`, `FIRSTER`, `V-SWIM`,
`SHAKE-LOOP`), as a book replaces `V-SCORE`. A later `ROUTINE` replaces an
earlier one wherever it is called; an object's `ACTION` is bound when the
object is defined, so a language object's action cannot be replaced. The
world's own rules are generic: a liquid is a `DRINKBIT` object (fill from the
one among the room's globals, board it to swim, drink it from an open
container to use it up), and pages turn by hand (`PRE-TURN` lets a `READBIT`
object turn without a tool). The package test fails if a Zork I name or
`ZORK-NUMBER` returns to core or the English language.

Plural nouns carry `PLURALBIT`: the `A` and `CA` tokens print "some", and
`AGREE` picks a reply's verb form (`<TELL CTHE ,PRSO <AGREE ,PRSO " is" " are">
" closed." CR>`).


A verb's syntax lines may come from the language and from a ruleset (`READ`,
`THROW`, `TIE`): the runtime grows the verb's syntax block as lines arrive.

## Writing a story

A story imports one ruleset with a qualified name:

```zil
<INSERT-FILE "rulesets.classic.en">     ;"or rulesets.superhero.en"
<INSERT-FILE "dungeon">
<INSERT-FILE "actions">
```

It must not import historical game folders. A new ruleset copies the shape of
`rulesets/superhero`: its numbers in a language-neutral file, its words and
verbs in `<lang>-verbs.zil`, and a `<lang>.zil` over `languages.<lang>.base`.

## Validation

`make test-adventure-packages` checks the dependency graph, that each ruleset
composes over its language's base and superhero never reaches the classic
rules, the shared-form and game-name rules above, and loads The Midnight
Ledger and Blackout at Meridian with historical file access blocked.
`make test-german-zork` plays the German Zork I from the opening to the troll
room. CI runs both. English export packaging (`make zip`) includes the book,
core, the English language and both English rulesets, not Infocom
directories. How the German package differs from the English one, and what a
third language needs, is in [LANGUAGE-PACKAGES.md](LANGUAGE-PACKAGES.md).

## Sources

English source derives from the November 2025 MIT Zork I release; retain the
original notices (https://github.com/historicalsource/zork1/blob/master/LICENSE).
German Zork I is reference material and is never exported; `languages/de` is
still its relocated code, so German adventures we publish should run on a
German package we write (`languages/de/SOURCE-PROVENANCE.md`). The historical
Zork I parser, verbs and globals in `infocom/zork1` remain as reference and
for the direct-path parser tests.
