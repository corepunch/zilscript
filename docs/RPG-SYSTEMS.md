# Tabletop RPG systems: one kernel, many systems, many languages

Stories will use mechanics from many tabletop games: percentile ranks
(superhero), d20 against a difficulty (fantasy), roll-under skills with
sanity (horror), dice pools. Each of those shares most of its machinery
with the others, and each is played in several languages. This document
fixes where each piece lives so nothing is written twice.

## The rule

Every piece of code or text has exactly one home, chosen by the narrowest
thing it depends on:

| Depends on | Lives in |
|---|---|
| nothing (engine) | `core/` |
| one language only (world verbs, parser words) | `languages/<lang>/` |
| RPG machinery, no language | `rulesets/rpg/kernel.zil` |
| RPG machinery, one language | `rulesets/rpg/<lang>.zil` |
| one system's numbers | `rulesets/<system>/system.zil` |
| one system's names in one language | `rulesets/<system>/<lang>.zil` |
| one story's logic | `books/<book>/logic.zil` (rooms, objects, state, actions) |
| one story's words in one language | `books/<book>/<lang>.zil` |

If a form would be identical in two homes of the same row, it belongs one row
up. `tests/test_adventure_packages.lua` enforces this for languages and
rulesets.

## Layers and their contracts

```
book entry (books/<book>/<book>[-<lang>].zil)
  languages/<lang>/init.zil            vocabulary, TELL tokens (German before objects)
  books/<book>/<lang>.zil              the edition's words: object names, genders, messages
  books/<book>/logic.zil               rooms, objects, state and actions, language-free
  rulesets/<system>/<lang>.zil         composes everything below, adds the system's names
    languages/<lang>/base.zil          parser, loop, world verbs
    rulesets/rpg/kernel.zil            characters, dice, resources, checks, archetypes
    rulesets/rpg/<lang>.zil            RPG verbs and sentences
    rulesets/<system>/system.zil       the system's numbers
```

### rulesets/rpg/kernel.zil (language-neutral)

* **Characters are stat tables.** A character, the hero or an opponent, is
  a table of `CHARACTER-SIZE` (32) words indexed by attribute constants the
  system defines, numbered 1 to 15 (`<STAT ,HERO ,A-STRENGTH>`,
  `<SET-STAT ,DRONE-STATS ,A-HEALTH 40>`). Slot 0 remembers the archetype the
  character became. The player is the kernel's `HERO`; an opponent is
  `<GLOBAL DRONE-STATS <ITABLE 32 0>>` in the story. The player and every
  opponent use the same routines; a story never keeps `DRONE-HP`-style
  globals.
* **Resources** are attributes with a maximum (kept in slot attribute+16,
  `<MAX-STAT tbl attr>`), set full by `<SET-RESOURCE tbl attr max>`:
  `<SPEND tbl attr n>` refuses (false) when short or when `n` is not positive,
  `<GAIN tbl attr n>` caps at the maximum and returns what was gained,
  `<LOSE tbl attr n>` floors at zero and returns what was lost. Health,
  karma, mana and sanity are all resources. A maximum of `NO-LIMIT` marks a
  resource without a ceiling (karma); the sheet shows a maximum only for a
  resource whose maximum is above 0 and below `NO-LIMIT`.
* **Dice**: `<ROLL count sides>`, the sum of `count` calls of `RANDOM`, so
  seeded play replays.
* **Checks**: `<CHECK tbl attr difficulty required>` asks the system to roll
  (`<SYSTEM-ROLL tbl attr difficulty>`) and grade
  (`<SYSTEM-GRADE tbl attr difficulty roll>`, a tier from 0), records
  `LAST-ROLL` and `LAST-TIER`, reports through `REPORT-CHECK` (the kernel's
  sentence: the system's `CHECK-TERMS`, the roll, the system's `TIER-NAME`),
  and returns whether the tier is at least `required`. `difficulty` means
  what the system says (unused by the percentile system, a target number in
  d20).
* **Archetypes** are `LTABLE`s of starting values for attributes 1, 2, ...;
  `<BECOME tbl archetype>` copies them, remembers the archetype
  (`<BECAME? tbl>`, `<KIND-OF tbl>`) and calls `<SYSTEM-DERIVE tbl>`, which
  sets the resources and their maxima.
* **Sheet and status**: the system lists the attributes to show in two
  `LTABLE`s, `SHEET-LAYOUT` (two to a line: `Name: 30` or `Health: 12/18`)
  and `STATUS-LAYOUT` (`Health 12 of 18, Karma 7.`); the kernel prints them
  with the language's `ATTR-NAME` and `OF-WORD`.
* **The hero's name** (`HERO-NAME`): `<ASK-NAME>` prints the language's
  `NAME-PROMPT`, reads a line and returns 0 (refused: characters outside
  printable ASCII), 1 (blank, name kept) or 2 (stored, capitalised word by
  word, at most 32 characters); `<NAMED?>` and `<PRINT-NAME>` read it back.
  What an unnamed hero is called is the story's.
* **Actions**: `V-RPG-ATTACK`, `V-RPG-POWER`, `V-RPG-RESCUE`,
  `V-RPG-DISABLE`, `V-RPG-CHOOSE`, `V-RPG-NAME` and `V-RPG-STATUS` print the
  language's default reply (`SAY-NO-TARGET`, `SAY-NO-POWER`, ...) when no
  story object takes the action in its ACTION routine
  (`<VERB? RPG-ATTACK>`).

### rulesets/rpg/&lt;lang&gt;.zil

The kernel's words once per language: SYNTAX and synonyms for the seven
actions, the `SAY-NO-*` replies, `OF-WORD` ("of"/"von"), `NAME-PROMPT`,
and the world's `DIAGNOSE` in German. A system adds no sentences here.

### rulesets/&lt;system&gt;/system.zil and &lt;lang&gt;.zil

`system.zil` is numbers only: the attribute constants, `SYSTEM-ROLL`,
`SYSTEM-GRADE` (for the superhero system, the percentile rank table),
`SYSTEM-DERIVE` (health from the physical ranks, karma from the mental
ones), `SHEET-LAYOUT` and `STATUS-LAYOUT`. `<lang>.zil` is names only:
`ATTR-NAME`, `TIER-NAME`, `CHECK-TERMS` (what a roll is against: "Rank 30;
d100"), plus the composition of the layers (language base, kernel, kernel
words, system), and any verb unique to that system.

For the current superhero rules, see [FASERIP checks and sheet export](FASERIP-RULES.md).
For encounter authors, see [the Marvel module reread and Meridian design notes](FASERIP-ADVENTURE-MODULES.md#second-pass-more-than-encounter-chapters).

A new system is one numbers file plus one names-and-composition file per
language; `tests/fixtures/rpg/toy-d20.zil` is a complete example (a d20
system in 30 lines) that `tests/test-rpg-kernel.zil` plays the kernel with.

## Editions: one story, many languages

A book's logic is written once. Each edition adds its words:

* **Objects merge.** The same object may be declared in the logic file and
  in an edition file; the runtime merges their properties and unions their
  flags. The logic declares location, flags that drive play and the ACTION;
  the edition declares DESC, LDESC, SYNONYM, ADJECTIVE, the grammatical
  gender and any other text property.
  The declarations may come in either order. FLAGS are unioned, SYNONYM and
  ADJECTIVE lists are concatenated without duplicates, and every other
  property may be given once, or again with the same value; two different
  values raise an error naming the object and property. Object numbers and
  the object tree follow the first declaration. Because a declaration of a
  name that a language package already defines (`STAIRS`, `ADVENTURER`)
  merges into it, a story names its own rooms and objects differently.
* **Messages are routines.** Logic never prints text directly: it calls
  message routines (`<MSG-TRAM-SAVED>`) that each edition defines. A message
  that needs a noun phrase uses the language's TELL tokens.
* **Prose links** live in the edition's text and name the edition's words.
* **Tests** play the logic through each edition with the same seeded route,
  so both editions reach the same endings with the same dice.

* **Exits are words.** A direction is a property named by a compass word
  (`NORTH`, `NORD`), so the edition declares each room's exits, including a
  gate and the text of its refusal (`(NORTH TO BRIDGE IF HERO-CLASS ELSE "...")`;
  a routine-decided `PER` exit has no way back for `go back`). The few places
  where logic must walk somewhere call edition routines (`WALK-TO-BRIDGE`).
* **Replacing the world's routines** (`V-VERSION`, `V-SCORE`, `GO`) must come
  after the language base, while the objects of a German edition come before
  it (a direction word must not collide with an object number): the logic that
  replaces world routines lives in `rules.zil`, inserted last.

Layout of a book with editions (one story, so one app entry per edition):

```
books/shared/<book>/logic.zil, rules.zil   the story, no words
books/<lang>/<book>/<book>.zil             the entry: imports rulesets.<system>.<lang>,
                                           the logic, the edition's words, the rules
books/<lang>/<book>/<lang>.zil               the edition's words: partial objects and rooms,
                                           MSG-* routines, syntax, companion cards
books/<lang>/<book>/game.json              the edition's own app id and language
```

Each edition has its own id, so saves never cross.

## Character creation and printable sheets

A story that offers character creation calls `RPG-PREPARE` in its `GO`
routine before presenting the available profiles. Running the world parser
during setup lets players examine profiles and enter a name. The clock stays
paused. The story owns the profiles and validates the selection. Once it has
initialized its character, it calls `RPG-BEGIN` with the story's opening
routine. This resumes the clock and runs the opening once. Both the character
and the setup state live in the normal ZIL game state.

A story can offer a printable sheet by defining `RPG-EXPORT-SHEET`. Return
false if there is no sheet yet. Send the character's name and profile to
`SHEET-IDENTITY`, then call `EXPORT-SHEET-RANKS` with the character table.
The kernel uses the system's `SHEET-LAYOUT` and the language's `ATTR-NAME`,
just as the in-game sheet does. The host receives rows with current values
and optional maxima. Adventure Arena turns those rows into a printable
HTML file. Exporting the sheet does not run a parser turn.

### Optional native pre-game selection

A book that has ready-made characters sets `RPG-PRESETS` after its RPG
ruleset is loaded: an `LTABLE` of two-cell `TABLE` rows, each containing a
stable ASCII ID and the archetype. The edition supplies
`RPG-PRESET-TITLE(index)` and `RPG-PRESET-SUMMARY(index)`, which print the
profile's localized name and approach. For preview, system derivation must
be deterministic on the supplied scratch table and must not change the
world, clock, or random generator.

A host loads the VM and calls `zilscript.rpg_setup.profiles(env)` **before
GO**. An empty list means no picker. Rendering the data is the host's job.
It calls `select(env, { id = ..., name = ... })` only after explicit
confirmation. The engine validates the stable ID and optional name, applies
the archetype exactly once, and gives the story its chosen index to start
the mission. A native reader saves the selection separately from its
commands, so neither the choice nor the name appears as a parser command
or advances a turn. A cancelled selection has no save. Existing saves
without a selection still replay their old parser commands; parser-only
clients without a setup frontend retain the in-VM prompt.

See the [Meridian setup](../books/shared/blackout-at-meridian/rules.zil) for a
book using the generic API with three authored profiles.


A reader passes a legacy-restore flag when opening an existing command-only
save without a preset record. A book may define `RPG-RESTORE-LEGACY` to select
its compatible behavior before GO, including subsequent turns. This keeps
Meridian's original yellow console check for old runs. New runs use the
intensity-based check. Command replay is not a general snapshot/migration
mechanism; gameplay edits still need targeted restore tests.

### Optional portrait on the printed sheet

Books that want a portrait can define `RPG-PORTRAIT()`. It returns a stable
lowercase ASCII asset ID for the active character (e.g. `arc`), or false
when none is available. It is called at the sheet-export boundary and must
not advance a turn, draw a random number, or change the active character.
Use the preset ID, not a localized display name or player-entered name. A
book can omit this routine or return false for any individual hero.

Put each original grayscale PNG at `portraits/<id>.png` under the book's
asset directory. The host may point translated editions at one shared
catalog asset root. The export embeds only matching, packaged PNG bytes
(no URL, path supplied by the player, or network request). If the image is
missing or cannot be read, the same sheet prints without an image or an
empty portrait column. Artwork does not affect save files or the character
setup flow. Meridian's three original illustrations are in
[the English book's asset folder](../books/en/blackout-at-meridian/portraits).
