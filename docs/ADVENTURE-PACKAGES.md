# Adventure core, languages and rulesets

The reusable import graph is independent of historical game folders. All 12 original book entrypoints explicitly import the English classic composition. English and German Zork I are consumers of the packages, not dependencies of them. No implicit Zork fallback remains in INSERT-FILE. Historical files remain as reference material and for legacy direct-path tests.

## Package layout

* core/clock.zil: shared scheduler (QUEUE, INT, CLOCKER).
* core/objects.zil: shared SEE-INSIDE?, CCOUNT, WEIGHT and HELD? (identical implementations in the two historical sources).
* languages/en: English syntax, parser, printing macros, loop and transitional classic verbs/globals.
* languages/de: German syntax, parser, grammatical rendering, loop and transitional classic verbs/globals. See SOURCE-PROVENANCE.md.
* rulesets/classic/en.zil and de.zil: explicit ordered composition. German story declarations precede classic globals/loop, preserving the historical order.

The parser, loop, verbs and globals remain mixed legacy implementations within the language directories; this is a physical dependency inversion, not a completed semantic separation. Next extract identical language-neutral parser helpers and dispatch, then separate combat and inventory policy from localized messages. Keep object vocabulary in story resources and expose stable action IDs.

New stories use qualified imports, not path-search injection:

```zil
<INSERT-FILE "rulesets.classic.en">
<INSERT-FILE "actions">
<INSERT-FILE "dungeon">
```

An RPG-specific ruleset should compose these common world/locale components and then register its own character and action-resolution policy. It must not import historical game folders. The superhero PR #90 will be migrated separately.

## Validation

make test-adventure-packages checks the dependency graph, all original entrypoints and loads/starts The Midnight Ledger with historical file access blocked. CI runs this target and existing English walkthrough tests. make test-german-reference remains an opt-in probe; German compiler compatibility and complete gameplay are not yet verified. English export packaging includes only the book and independent packages, not Infocom directories. German export remains excluded pending exact source provenance verification.

English source derives from the November 2025 MIT Zork I release; retain the original notices. See https://github.com/historicalsource/zork1/blob/master/LICENSE. German source has been relocated from the existing repository and retains its original notices. See languages/de/SOURCE-PROVENANCE.md.
