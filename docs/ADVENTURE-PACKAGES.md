# Adventure core, languages and rulesets

The reusable import graph is independent of historical game folders. All 12 original book entrypoints explicitly import the English classic composition. English and German Zork I are consumers of the packages, not dependencies of them. No implicit Zork fallback remains in INSERT-FILE. Historical files remain as reference material and for legacy direct-path tests.

## Package layout

* core/clock.zil: shared scheduler (QUEUE, INT, CLOCKER).
* core/objects.zil: shared SEE-INSIDE?, CCOUNT, WEIGHT and HELD? (identical implementations in the two historical sources).
* core/parser.zil: parser state, LEXV/INBUF tables, syntax-table offsets and the 20 helper routines (STUFF, INBUF-ADD, NUMBER?, SNARF-OBJECTS, SEARCH-LIST, LIT?, META-LOC and others) that were byte-identical in English and German. Each language parser inserts it first.
* core/loop.zil: the M-* handler codes, PLAYER, P-WON, P-MULT, P-NOT-HERE and MAIN-LOOP. The debug PERFORM, D-APPLY and DD-APPLY stay in each language loop because they sit inside its conditional-compilation block.
* languages/en: English syntax, parser, printing macros, loop and transitional classic verbs/globals.
* languages/de: German syntax, parser, grammatical rendering, loop and transitional classic verbs/globals. See SOURCE-PROVENANCE.md.
* rulesets/classic/en.zil and de.zil: explicit ordered composition. German story declarations precede classic globals/loop, preserving the historical order.

Every top-level parser and loop form that is identical in both languages now lives in core/; test_adventure_packages.lua fails if one is duplicated again. What remains in languages/ differs between English and German: PARSER, CLAUSE, GWIM, ORPHAN-MERGE, WORD-PRINT and the part-of-speech offsets in the parser, MAIN-LOOP-1 and PERFORM in the loop. Some of these differ only in messages or vocabulary words and can be split into a shared algorithm plus language hooks. The classic verbs and globals are still mixed: 51 forms are identical (scoring, deaths, exit-table constants, DO-WALK, DESC-OBJECT), and they belong to the classic ruleset or core rather than to a language. Next separate combat and inventory policy from localized messages. Keep object vocabulary in story resources and expose stable action IDs.

New stories use qualified imports, not path-search injection:

```zil
<INSERT-FILE "rulesets.classic.en">
<INSERT-FILE "actions">
<INSERT-FILE "dungeon">
```

An RPG-specific ruleset should compose these common world/locale components and then register its own character and action-resolution policy. It must not import historical game folders. Blackout at Meridian imports rulesets.superhero.en, which still composes rulesets.classic.en and adds rulesets/superhero/percentile.zil; the superhero rules do not yet replace classic combat or scoring.

## Validation

make test-adventure-packages checks the dependency graph, all original entrypoints and loads/starts The Midnight Ledger with historical file access blocked. CI runs this target and existing English walkthrough tests. make test-german-reference remains an opt-in probe; German compiler compatibility and complete gameplay are not yet verified. English export packaging includes only the book and independent packages, not Infocom directories. German export remains excluded pending exact source provenance verification.

English source derives from the November 2025 MIT Zork I release; retain the original notices. See https://github.com/historicalsource/zork1/blob/master/LICENSE. German source has been relocated from the existing repository and retains its original notices. See languages/de/SOURCE-PROVENANCE.md.
