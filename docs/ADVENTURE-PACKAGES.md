# Adventure core, languages and rulesets

This is the first extraction, not a completed language-independent parser.

## Current structure

* `core/clock.zil`: shared scheduler (QUEUE, INT, CLOCKER). The English and German historical implementations have identical code after stripping comments and whitespace; the canonical source is the English version. The module expects the host loop's P-WON and MOVES globals.
* `languages/en/syntax.zil`: the English grammar declarations (BUZZ, SYNONYM and SYNTAX) moved without semantic changes; still contains classic-specific verbs and ZORK-NUMBER conditionals. Split the generic and ruleset-specific vocabulary later.
* `languages/de/init.zil`: explicit adapter over the existing German TELLS and SYNTAX files, preserving their order. Not yet a generic German language implementation.
* `rulesets/classic/en.zil`: ordered composition for English Zork-compatible adventures. It explicitly imports mixed legacy modules pending further extraction. It is not the final ruleset API.
* `infocom/zork1/zork1.zil`, `infocom/zork1-de/zork1.zil` and `books/the-midnight-ledger/the-midnight-ledger.zil` exercise the new entry points. Existing flat clock/syntax import paths for English books/tests remain tiny forwarding modules during migration.

A book opts into the transitional composition with:

```zil
<INSERT-FILE "rulesets.classic.en">
<INSERT-FILE "actions">
<INSERT-FILE "dungeon">
<INSERT-FILE "companion">
```

The book still supplies its own settings and property defaults before the composition. Qualified package names resolve through the existing ZIL package search path. Other legacy books still use the old unqualified fallback; don't remove it until those books migrate. Do not globally append every language directory to the search path: collisions between syntax or grammar files would silently choose the wrong language.

## Routine-level audit

| Area | English | German | Next extraction |
| --- | --- | --- | --- |
| Clock | clock.zil | clock.zil | Extracted; shared byte-equivalent implementation |
| Game loop | main.zil | loop.zil | separate action dispatch and language-specific prompts |
| Parser | parser.zil (42 routine/define matches) | parser.zil (49) | split tokenization, noun resolution, grammar, ambiguity messages |
| Syntax | syntax.zil | syntax.zil | English moved; German adapter only |
| Verb handlers | verbs.zil | verbs.zil | split semantic operations, rendering and ruleset combat |
| Object globals | globals.zil | globals.zil | separate generic objects from world and language-specific nouns |
| Printing | macros.zil / verbs.zil | tells.zil | gender, nominative/accusative/dative, article and pronoun rendering |
| Game-specific logic | actions.zil / dungeon.zil | actions.zil / dungeon.zil | retain story objects and special interactions in the book |

Counts are lexical inventory, not a claim of semantic equivalence.

## Target boundaries

The next patch should introduce a language-neutral action record (verb/action ID plus resolved object IDs); keep parser text and inflection in language packages. Story noun IDs are stable, with localized synonyms and descriptions in story localization. Ruleset-specific verbs and terminology belong in ruleset locale resources. Keep the compiler/runtime independent of specific story or RPG systems. Extract classic combat only after regression coverage exists, then compose superhero rules without duplicating world logic.

## Validation

* Existing `make test-clock-direct` now imports core.clock explicitly; other clock tests exercise the legacy import path.
* Existing Zork I walkthrough and Midnight Ledger tests exercise the new composition.
* `make test-adventure-packages` checks exact moved source provenance and entry point ordering; `make test-german-reference` is an opt-in compile/start probe, not yet a passing compatibility guarantee.
* Full English and German walkthroughs and native Adventure Arena validation are pending until executed. The historical German source uses distinct ZIL constructs and a different grammar. It is not proven to run on the current Lua runtime.

## Source rights

The English extraction derives from Zork I, released under MIT in November 2025; the original Infocom headers and MIT notice are retained. See https://github.com/historicalsource/zork1/blob/master/LICENSE and https://opensource.microsoft.com/blog/2025/11/20/preserving-code-that-shaped-generations-zork-i-ii-and-iii-go-open-source/ . The German archival repository README explicitly says it is not open-licensed (https://github.com/historicalsource/zork-german). IF Archive lists a German Zork release among the MIT source archives, but this does not independently establish that every file in the separate historical mirror is covered. Do not copy its implementation into reusable packages or distribute it commercially until provenance and permission are verified. The German adapter references already-present files for local research; no German source is newly copied here.
