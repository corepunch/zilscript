# Stromausfall in Meridian

The German edition of Blackout at Meridian: same rooms, rules and numbers,
written for German-speaking children. The story's logic is shared with the
English edition (`books/shared/blackout-at-meridian`, see
`books/en/blackout-at-meridian/README.md`); this folder holds the edition's
words (`de.zil`: objects, exits, messages, syntax, companion cards), its
entry file and its tests.

Every object has one gender flag (der, die, das) and compound-noun names, so
the TELL tokens (`DER-DAT`, ...) need no adjective declension. There are no
ADJECTIVE lists: German adjective matching does not work in the shared parser
yet. Umlauts are written as `%a %o %u %s` escapes in strings; `Straßenbahn`,
`Brücke` and `Stahltür` are UTF-8 in DESC and SYNONYM so
`scripts/check-vocab.lua` can match them.

## Play

Profiles: **Fels** (strong, 120 Health), **Blitz** (fast, 90 Health) and
**Luchs** (clever, 60 Health), the German names of Bulwark, Arc and Lens.
Verbs are imperative stems; umlaut and ASCII spellings both work:
SCHLAG, HAU, GREIF ... AN, KAEMPF, ZERSTOER (strike); RETT, BERG, HELF
(rescue); DEAKTIVIER, SCHALT ... AB, HACK, UMGEH (disable); WAEHL, REGISTRIER
(choose); KONZENTRIER, FOKUSSIER; NENN, BENENN, TAUF (name); ZUSTAND,
GESUNDHEIT, STATUS, DIAGNOSE; HILFE, TIPP, HINWEIS. NENNE BOGEN names the
hero; names are ASCII only. The unnamed hero is called Meridian.

## Validation

`make test-book-walkthroughs` runs `test/test_walkthrough_*.lua`: a typed
seeded walkthrough, every ending for every profile with forced dice, real
seeded dice checked against an independent percentile table, the world
(exits, scenery, names, every prose link) and the link-menu route with the
companion. `test/hero.lua` also fails a reply that shows an undecoded escape,
`nil`, or a word of the English edition. The English test directory's
`test_walkthrough_editions.lua` plays both editions on the same seeds.
