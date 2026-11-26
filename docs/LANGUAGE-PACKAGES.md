# Language packages: what German Zork I changed, and how to add a language

This is a map of what Infocom's German Zork I (`infocom/zork1-de`, release 15,
"pdl's revision") added to or changed in the English sources. The goal is to
make a third language cheap. The German edition now plays on the German
package (`tests/test_german_zork.lua` goes from the opening to the troll
room), so every point below is checked against running code unless it is
marked **(read, not run)**.

Files compared: `languages/en` with `languages/de`, `infocom/zork1` with
`infocom/zork1-de`, and the two compositions in `rulesets/classic`. Whatever
was identical in both languages has been moved to `core/`, and
`tests/test_adventure_packages.lua` fails if an identical top-level form
reappears in both packages.

## 1. Text encoding

### 1.1 How German spells umlauts

Infocom's German sources are ASCII. With `<LANGUAGE GERMAN>` in effect,
`%` followed by a letter is a special character:

| Escape | In strings | In atoms (vocabulary) |
|---|---|---|
| `%a %o %u` | ä ö ü | ä ö ü |
| `%A %O %U` | Ä Ö Ü | ä ö ü (the dictionary is lowercase) |
| `%s` | ß | ß |
| `%>` `%<` | » « (German order: » opens, « closes) | » « |

In atoms the `%` is escaped with a backslash (`H\%ANDE`, `VERLA\%S`),
because a bare `%` starts a read-time form. `%<COND …>` is also ZIL's
read-time evaluation, so `%<` is a guillemet only inside a string.

zilscript decodes these once, in the parser (`zilscript/charsets.lua`). The
runtime, the hosts and the player only ever see UTF-8: "Hände", "»Ja«".
Non-ASCII vocabulary words get ASCII Lua names (`W?HÄNDE` → `WQH_C3_A4NDE`),
and the dictionary and input lowercase the Latin-1 capitals, so "Öffne"
finds `öffne`.

`languages/de/init.zil` declares `<LANGUAGE GERMAN>` itself, and every file
inserted after it inherits the character set. **A new language should write
UTF-8 directly in its sources and needs no entry in `charsets.lua`.**

### 1.2 Spelling variants

Every word with an umlaut or ß appears in both spellings, because players type
both: `<SYNONYM SUED S\%UD S\%UDEN SUEDEN S>`,
`<SYNONYM VERLASS VERLASSE VERLA\%S VERLA\%SE>`. The `SYNTAX` head is always
the ASCII form, so code compares `,W?AUFHOEREN ,W?AUFH\%OREN`. Some variants
are typos that can never match (`SCHLEI\%S`, `K\%APF`, `KETTER`). **A new
language should derive ASCII alternatives (ä→ae, ß→ss) from one rule instead
of typing them.**

## 2. Grammar: gender, case, articles, pronouns

### 2.1 Gender is a flag on each object

There is no `GENDER` property. Each story object carries exactly one of
`DERBIT`, `DIEBIT`, `DASBIT` (in zork1-de: 53, 42 and 36 objects). An object
with no flag prints without an article, which is why the debug verb `TESTIT`
(`V-TEST-IT`) exists: it prints "Der/Die/Das X ist gut." for every object.
`GLOBAL-OBJECTS` lists every flag so the bits are allocated.

There is **no plural**. English plurals became singular collective nouns:
"pair of candles" → "Kerzenpaar", "pile of leaves" → "Blätterhaufen".

### 2.2 Adjective declension

Objects may split their name into `(ADJDESC "batteriengespeist")` and
`(DESC "Messingleuchte")` (40 objects). `DPRINT` (`languages/de/messages.zil`)
adds the ending from the article just printed, passed as a vocabulary word
(`W?DER`, `W?DEN`, `W?EIN`, …). After der/die/das the endings are right. After
ein/einen/einem they are not: the game prints "Ein batteriengespeister
Messingleuchte" (should be "Eine batteriengespeiste") and "enthält ein
Zettel" (should be "einen Zettel"). **A new language should write declension as
a table indexed by gender, number and case.**

### 2.3 Articles through TELL tokens

English prints noun phrases with the built-in `TELL` tokens `A`, `AN`, `CA`,
`THE`, `CTHE`. German declares its own with `TELL-TOKENS`
(`languages/de/messages.zil`), 13 printers in three cases:

```zil
<TELL-TOKENS (CRLF CR) <CRLF>   D * <DPRINT .X <>>
     DER-NOM * <DER-NOM-PRINT .X>   DER-ACC * <DER-ACC-PRINT .X>   DER-DAT * ...
     EIN-NOM * ...  EIN-ACC * ...  EIN-DAT * ...
     PRONOUN-NOM * ...  PRONOUN-NOM-CAP * ...  PRONOUN-ACC * ...>
```

`"There is " A .OBJ " here"` becomes `"Hier ist " EIN-NOM .OBJ`. There is no
genitive and no `-DAT-CAP`. The most used tokens are `DER-NOM-CAP` (71),
`DER-ACC` (60) and `DER-DAT` (32).

zilscript implements `TELL-TOKENS` fully. A name or list of aliases, then one
argument pattern per argument (`*`, `*:TYPE`, or a literal such as `,PRSO`
that selects a variant), then the form to run with `.X` and `.Y`. Variants
are tried in order, the way Lurking Horror's `D ,PRSO` precedes `D *`. Tokens
belong to the game's compile session and never leak into another game.

### 2.4 Three referents instead of one

English keeps one referent: `IT` (synonyms IT THEM HER HIM), `P-IT-OBJECT`,
and a `THIS-IS-IT` that is one `SETG`. German needs three, because er/sie/es
follow grammatical gender (der Zettel is "ihn", die Lampe is "sie"):

* objects `IT`, `HIM`, `HER` with synonyms `ES IHM`, `ER IHN IHM`, `SIE IHR`;
* `P-IT-OBJECT`, `P-HIM-OBJECT`, `P-HER-OBJECT`;
* `THIS-IS-IT` picks the slot from the object's gender flag, and `PERFORM`
  calls it for PRSO and PRSI ("ala Stationfall").

Every place that resolves IT is repeated three times (MAIN-LOOP-1, PERFORM,
ITAKE-CHECK). One copy in MAIN-LOOP-1 walked the direct objects through
`P-PRSI`; it now uses `P-PRSO` as English does.

## 3. Parser (`languages/de/parser.zil`)

### 3.1 Words and messages swapped

Most of the PARSER diff replaces word constants:

| English | German |
|---|---|
| `W?OOPS` | `W?ACH` |
| `W?AGAIN ,W?G` | `W?WIEDER` |
| `W?THEN` / `W?AND` / `W?ALL` | `W?DANN` / `W?UND` / `W?ALLES` |
| `W?BUT ,W?EXCEPT` | `W?ABER ,W?AUSSER ,W?AU\%SER` |
| `W?OF` | `W?VOLL` ("Sack voll Münzen") |
| `W?THE ,W?A ,W?AN`, `W?ONE` | `DER DIE DAS` and the five `EIN*` forms |
| `W?TO` + `ACT?TELL` | `W?ZU` + `ACT?SAG` |
| `ACT?WALK` | `ACT?GEH` |
| `W?ME` | `W?MICH` |

Every parser message is translated in place ("I beg your pardon?" →
"Bitte?"). None is selected through an ID.

### 3.2 Articles are buzz words

All nine inflected articles are `BUZZ` words. `CLAUSE` drops a leading
article, and an `EIN*` form acts as English "one". The parser never checks an
article's case or gender: "nimm den Lampe" works. `DES` is a buzz word, so
genitive phrases are discarded.

### 3.3 Contractions, separable verbs, reflexives, compounds

* **Contractions** are synonyms of the bare preposition: `<SYNONYM IN IM INS>`,
  `<SYNONYM AN AM ANS>`. `VOM`, `ZUM`, `ZUR`, `BEIM` are missing.
* **Separable verbs** ("mach die Lampe an") reuse the English rule for a
  preposition that ends the sentence ("pick X up"): the prefix sits where an
  English preposition would, `<SYNTAX MACH AN OBJECT …>`. With two objects
  there is no slot left, so several lines comment the particle out and need
  routines to tell senses apart (`V-CLOSE-OR-LOCK`, `V-TRAGE`). `NON-SEP?`
  lists verbs whose preposition is not a prefix; only the orphan question
  ("Mach was auf?" vs "Schau in was?") uses it.
* **Reflexives** read `DICH` as a preposition with a GWIM trick
  (`<SYNTAX SIEH DICH OBJECT (FIND KLUDGEBIT) = V-LOOK>`).
* **Compounds and inflections** are listed as synonyms one by one
  (`LAMPE LATERNE LICHT LEUCHTE MESSINGLEUCHTE`, `GREIF GREIFE KAEMPF …`).
* **Two objects:** `SCHENK X Y` calls `V-SCHENKE`, which finds the recipient
  by `ACTORBIT`, because German word order does not decide it.

### 3.4 Routines that changed

| Routine | German change |
|---|---|
| `PARSER`, `CLAUSE`, `ORPHAN-MERGE`, `SNARFEM` | the words of §3.1 |
| `WORD-PRINT`, `PREP-PRINT` | optional `CAP?`; capitalizes with `PRINTC <- c 32>`, ASCII only |
| `CAPITALIZE`, `REFERRING`, `NON-SEP?`, `GWIM-PRSO?` | new |
| `SYNTAX-CHECK` | orphan question rebuilt: "<Verb> was <prep>?" |
| `GWIM` | "(mit dem X)" note picks dative or accusative |
| `BUFFER-PRINT` | resolves ER/IHN/IHM, SIE/IHR, ES/IHM |
| `WHICH-PRINT` | "Welche(r/s)" by gender |
| `ITAKE-CHECK` | three referents; "(den X erst nehmen)" |
| `MANY-CHECK` | names grammatical cases ("mehrere Akkusativ") |
| `CLAUSE-COPY` | still Infocom's version; a later English fix was not ported |

## 4. Syntax and vocabulary

German has 290 `SYNTAX` lines (English 267) and 124 `SYNONYM` lines (74).

* Directions belong to the story: `<DIRECTIONS NORD OST WEST SUED NO NW SO SW
  RAUF RUNTER HINEIN RAUS LANDEN>` in `zork1-de/zork1.zil`. Exit keywords stay
  English (`TO`, `PER`, `IF`, `SORRY`).
* Verbs are imperative stems (`NIMM`, `SCHAU`, `GEH`). Action routines keep
  their English names (`= V-TAKE`), so `ACT?` names change (`ACT?SAG`).
* Meta verbs are partly German (`INVENTAR`, `AUFHOEREN`, `PUNKTESTAND`) and
  partly English (`SAVE`, `SCRIPT`, `VERSION`).

## 5. Messages

`languages/de/messages.zil` is not a message catalog. It is the German
counterpart of `languages/en/macros.zil`: TELL-TOKENS, the 13 printers,
`DPRINT`, and the same DEFMACs as English (`VERB?` through `ABS`). Text
everywhere else is inline.

Eleven verb handlers are word for word the English ones, text included,
because the translator never reached them: `V-VERBOSE`, `V-BRIEF`,
`V-SUPER-BRIEF` ("Maximum verbosity."), `V-RANDOM`, `V-BACK`, `V-BLAST`,
`V-CHOMP`, `V-HATCH`, `V-MUMBLE`, `V-PUT-UNDER`, `V-SGIVE`. They stay in each
package, because the language owns the words. Other English left in the German
package **(read, not run)**: `loop.zil` "The " before "Das andere Ding", `parser.zil` "the " in
`BUFFER-PRINT` and " or " in `WHICH-PRINT`, about 49 lines in
`classic-verbs.zil` (many in Zork II/III branches that Zork I never compiles),
and about 10 lines in `zork1-de/actions.zil`.

## 6. Version code is not language code

German was built for Infocom's version 4+ machine (`<VERSION YZIP>`,
`PLUS-MODE`, `NEW-VOC?`): word-sized exits and local-global lists, longer
dictionary entries, a status line drawn by the game, a full-screen hint menu.
None of that is language. This runtime has one layout for every language, and
the German package now uses it:

| Item | Decision |
|---|---|
| Exit targets, door objects, `GLOBAL` lists | version 3 bytes, read with `GETB`; an object above 255 there is a load error, not a silent clamp |
| Object numbers | words, up to 1023 (German Zork has 256 objects) |
| Dictionary offsets `P-PSOFF`/`P-P1OFF` | 4 and 5, in `core/parser.zil` |
| `ZMEMQB`, `HERE` | in `core/parser.zil` |
| Story text | an interned string pool outside the 64 KB story memory |
| `PLUS-MODE` | never assigned (the compile-time build environment assigns `ZILCH` and `PREDGEN`) |
| Status line, cursor and window opcodes | removed from the German package; hosts show location and score |
| Hint menu (`hints.zil`) | not inserted: it needs cursor windows and single-key input |

German Zork inserts its dungeon before the classic composition, so its rooms
keep object numbers below 256.

## 7. What the translator changed inside the game

| Change | Example |
|---|---|
| One gender flag per object | 131 objects |
| `ADJDESC` split out of `DESC` | LAMP: `(DESC "Messingleuchte") (ADJDESC "batteriengespeist")` |
| Plurals made singular | CANDLES "Kerzenpaar" |
| Pseudo-objects became real objects, so they can carry a gender | `CHAIN CHASM DOME DOOR-P GAS GATE LAKE NAILS PAINT STREAM`; `(PSEUDO …)` lines commented out |
| Every inflection and spelling listed | `(SYNONYM ZAEHNE Z\%AHNE ZAEHNEN Z\%AHNEN GEBISS GEBI\%S)` |
| Word comparisons translated | the echo room tests `W?LAUF ,W?GEH ,W?REN` |
| Directions and `SORRY` exits in German | `(OST SORRY "Die T%ur ist mit Brettern vernagelt …")` |

## 8. Adding a language

### 8.1 Shared already (in `core/`)

* `core/parser.zil`: parser globals and tables, `HERE`, the dictionary offsets,
  `STUFF`, `INBUF-STUFF`, `INBUF-ADD`, `NUMBER?`, `ACLAUSE-WIN`,
  `NCLAUSE-WIN`, `ORPHAN`, `THING-PRINT`, `CLAUSE-ADD`, `PREP-FIND`,
  `SYNTAX-FOUND`, `SNARF-OBJECTS`, `BUT-MERGE`, `DO-SL`, `SEARCH-LIST`,
  `OBJ-FOUND`, `TAKE-CHECK`, `ZMEMQ`, `ZMEMQB`, `LIT?`, `META-LOC`.
* `core/loop.zil`: `M-*` codes, `PLAYER`, `P-WON`, `MAIN-LOOP`, `P-MULT`, `P-NOT-HERE`.
* `core/clock.zil` (`QUEUE`, `INT`, `CLOCKER`), `core/objects.zil`
  (`SEE-INSIDE?`, `CCOUNT`, `WEIGHT`, `HELD?`).
* `rulesets/classic/common.zil`: the classic rules without text, 44 forms
  (the exit-table constants, `DO-WALK`, `GLOBAL-IN?`, `FIND-IN`, the score,
  death, load and verbosity globals, `SCORE-OBJ`, `MUNG-ROOM`, `V-LOOK`,
  `V-FIRST-LOOK`, `PRE-DROP`, `PRE-PUT`, `NULL-F` and the verbs whose code is
  shared). Both compositions insert it before their language's verbs.
* The compiler and runtime: UTF-8 text, TELL-TOKENS, macros, object and
  string limits.

### 8.2 What a language package provides today

The algorithm and its words are not separated yet, so a new language copies
and edits each of these:

| File | Defines |
|---|---|
| `init.zil` | `<LANGUAGE>` if it uses escapes; inserts messages and syntax |
| `syntax.zil` | `BUZZ` (articles, conjunctions, punctuation), preposition synonyms and contractions, direction synonyms, every `SYNTAX` line, verb forms |
| `parser.zil` | `SIBREAKS`, `PARSER`, `WT?`, `CLAUSE`, `ORPHAN-MERGE`, `WORD-PRINT`, `UNKNOWN-WORD`, `CANT-USE`, `SYNTAX-CHECK`, `CANT-ORPHAN`, `BUFFER-PRINT`, `PREP-PRINT`, `CLAUSE-COPY`, `GWIM`, `SNARFEM`, `GET-OBJECT`, `WHICH-PRINT`, `GLOBAL-CHECK`, `ITAKE-CHECK`, `MANY-CHECK`, `THIS-IT?`, `ACCESSIBLE?` |
| `loop.zil` | `MAIN-LOOP-1`, `PERFORM`, `D-APPLY`, `DD-APPLY` |
| macros or messages | TELL tokens for the language's noun phrases, article and pronoun printers |
| `classic-globals.zil` | `GLOBAL-OBJECTS` with the grammatical flags, the referent objects, `NOT-HERE-OBJECT` |
| `classic-verbs.zil` | every `V-*`/`PRE-*` handler with its text, `THIS-IS-IT`, `DESCRIBE-OBJECT`, `PRINT-CONT` |
| the story | `<DIRECTIONS>`, grammatical data on every object, inflected synonyms, translated descriptions |

### 8.3 What to extract before a third language is cheap

1. **Parser word hooks.** Global word tables the language fills
   (`P-ARTICLES`, `P-ONE-WORDS`, `P-ALL-WORDS`, `P-AND-WORDS`, `P-BUT-WORDS`,
   `P-OF-WORDS`, `P-THEN-WORD`, `P-AGAIN-WORDS`, `P-OOPS-WORDS`,
   `P-ME-WORDS`, the talk and walk actions). Then `PARSER`, `CLAUSE`,
   `SNARFEM`, `ORPHAN-MERGE` and `MAIN-LOOP-1` become identical and move to
   core; §3.1 is almost the whole diff.
2. **Message hooks.** One routine or ID per parser and loop message, with the
   text supplied by the language.
3. **A noun-phrase contract.** `<THE-PRINT obj case cap?>`,
   `<A-PRINT obj case cap?>`, `<PRONOUN-PRINT obj case cap?>`, exposed as TELL
   tokens. English ignores the case; German maps it to its printers; Russian
   needs six cases and animacy.
4. **Grammatical data.** One representation (flags or a property) with
   number as well as gender, and declension as a table.
5. **A referent table** indexed by pronoun class (English 1, German 3,
   French 2, Russian 3 plus plural), chosen by `THIS-IS-IT`. That removes the
   three copied blocks.
6. **Orphan and GWIM phrasing** as a language routine.
7. **Shared macros** (`VERB?` through `ABS`) into `core/macros.zil`.
8. **Text out of the classic verbs.** The rules without text are already in
   `rulesets/classic/common.zil`. The rest of `classic-verbs.zil` is the same
   algorithm with the language's sentences inside; with message hooks (item 2)
   most of it moves to the ruleset too.

### 8.4 Tests a new language needs

* A walkthrough like `tests/test_german_zork.lua`: the opening, an object with
  each grammatical class, a pronoun of each class, a separable or particle
  verb, capitalized non-ASCII input, and a check that no escape or `nil`
  reaches the output.
* A `TESTIT`-style check that every object has its grammatical data.
* A check that the package contains no English strings.

## Provenance

German Zork I is reference material: we study and test against it and do
not ship it. `languages/de` is still Infocom's German code relocated from it,
so German adventures we publish should run on a package we write from what
this document records (see `languages/de/SOURCE-PROVENANCE.md`).
