# Stromausfall in Meridian

The German edition of Blackout at Meridian (`books/blackout-at-meridian`): same
three rooms, same rules and numbers, written for German-speaking children.
Original setting and prose; no licensed superhero identities.

## Architecture

The story inserts `languages.de.init` (messages, TELL tokens, vocabulary)
before its objects, as Zork I (German) does, then `rulesets.superhero.de`
after them. That ruleset composes `languages/de/base.zil`,
`rulesets/superhero/percentile.zil` (the numbers, shared with the English
edition) and `rulesets/superhero/de-verbs.zil` (the check report, the
character sheet and the hero actions with German words).

* `dungeon.zil`: rooms and objects. Every object has one gender flag (der, die,
  das) and compound-noun names, so the TELL tokens (`DER-DAT`, ...) need no
  adjective declension. There are no ADJECTIVE lists: German adjective
  matching does not work in the shared parser yet. Umlauts are written as
  `%a %o %u %s` escapes in strings; `Straßenbahn`, `Brücke` and `Stahltür`
  are written as UTF-8 in DESC and SYNONYM so `scripts/check-vocab.lua` can
  match them.
* `actions.zil`: the actions, the name prompt, HILFE, USE and LISTEN.
* `companion.zil`: the companion's cards in German.
* `game.json`: `"language": "de"`, so the reader sends German commands.

## Play

Profiles: **Fels** (strong, 120 Health), **Blitz** (fast, 90 Health) and
**Luchs** (clever, 60 Health), the German names of Bulwark, Arc and Lens.
Verbs (imperative stems; umlaut and ASCII spellings both work):

| Action | Words |
|---|---|
| strike | SCHLAG, HAU, GREIF ... AN, ANGREIF, KAEMPF, ZERSTOER |
| rescue | RETT, BERG, HELF |
| disable | DEAKTIVIER, SCHALT ... AB, HACK, UMGEH, BETAETIG, LEG ... UM |
| choose | WAEHL, REGISTRIER |
| focus | KONZENTRIER, FOKUSSIER |
| name | NENN, BENENN, TAUF |
| diagnose | ZUSTAND, GESUNDHEIT, STATUS, DIAGNOSE |
| help | HILFE, TIPP, HINWEIS |

NENNE BOGEN names the hero; names are ASCII only (a line with umlauts keeps
the current name). The unnamed hero is called Meridian.

## Validation

`make test-book-walkthroughs` runs `test/test_walkthrough_*.lua`: a typed
seeded walkthrough, every ending for every profile with forced dice, real
seeded dice checked against an independent percentile table, the world
(exits, scenery, names, every prose link) and the link-menu route with the
companion. `test/hero.lua` also fails a reply that shows an undecoded
escape, `nil`, or a word of the English edition.
