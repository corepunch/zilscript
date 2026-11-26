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
  a table of numbers indexed by attribute constants the system defines
  (`<STAT ,HERO ,A-STRENGTH>`, `<SET-STAT ,DRONE ,A-HEALTH 40>`). The player
  and every opponent use the same routines; a story never keeps
  `DRONE-HP`-style globals.
* **Resources** are attributes with a maximum: `<SPEND tbl attr n>` refuses
  when short, `<GAIN tbl attr n>` caps at the maximum, `<LOSE tbl attr n>`
  floors at zero. Health, karma, mana and sanity are all resources.
* **Dice**: `<ROLL count sides>`, built on `RANDOM`, so seeded play replays.
* **Checks**: `<CHECK tbl attr difficulty required>` rolls through the
  system (`SYSTEM-ROLL`, `SYSTEM-GRADE`), records the roll and tier, reports
  through the language (`REPORT-CHECK`), and returns whether the tier is at
  least `required`.
* **Archetypes** are tables of starting values; `<BECOME tbl archetype>`
  copies them and asks the system to derive the rest (`SYSTEM-DERIVE`).
* **Sheet**: the system lists the attributes to show (`SHEET-LAYOUT`); the
  kernel prints them through the language's labels.
* **Actions**: generic action routines (`V-RPG-ATTACK`, `V-RPG-POWER`,
  `V-RPG-RESCUE`, `V-RPG-DISABLE`, `V-RPG-CHOOSE`, `V-RPG-NAME`,
  `V-RPG-STATUS`) whose default replies come from the language and whose real
  effects come from the story's object ACTION routines.

### rulesets/rpg/&lt;lang&gt;.zil

The kernel's words once per language: SYNTAX for the action verbs, their
default replies, `REPORT-CHECK`, the sheet's layout sentence, the naming
prompt. A system adds no sentences here.

### rulesets/&lt;system&gt;/system.zil and &lt;lang&gt;.zil

`system.zil` is numbers only: attribute constants, `SYSTEM-ROLL`,
`SYSTEM-GRADE` (for the superhero system, the percentile rank table),
`SYSTEM-DERIVE` (health from the physical ranks, karma from the mental
ones), `SHEET-LAYOUT`. `<lang>.zil` is names only (`ATTR-NAME`, `TIER-NAME`)
plus the composition of the layers, and any verb unique to that system.

A new system is two short files per language plus one numbers file.

## Editions: one story, many languages

A book's logic is written once. Each edition adds its words:

* **Objects merge.** The same object may be declared in the logic file and
  in an edition file; the runtime merges their properties and unions their
  flags. The logic declares location, flags that drive play and the ACTION;
  the edition declares DESC, LDESC, SYNONYM, ADJECTIVE, the grammatical
  gender and any other text property.
* **Messages are routines.** Logic never prints text directly: it calls
  message routines (`<MSG-TRAM-SAVED>`) that each edition defines. A message
  that needs a noun phrase uses the language's TELL tokens.
* **Prose links** live in the edition's text and name the edition's words.
* **Tests** play the logic through each edition with the same seeded route,
  so both editions reach the same endings with the same dice.

The app lists each edition (`books.<book>` and `books.<book>-<lang>`); both
entries point at the same logic.
