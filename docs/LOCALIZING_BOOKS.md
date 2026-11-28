# Localizing Adventure Arena books

## Catalog and source layout

Each language owns a catalog and a source tree. Add a German-only title to
`books/de/` and the German catalog. A translated edition uses the same slug
in both source trees, so maintainers can find the corresponding editions.

```text
books/
  en/borrowed-tomorrows/
    borrowed-tomorrows.zil
    dungeon.zil
    actions.zil
    companion.zil
    game.json
    test/
  de/borrowed-tomorrows/
    borrowed-tomorrows.zil
    dungeon.zil
    actions.zil
    companion.zil
    game.json
    test/
infocom/
  zork1/books.zil
  zork1-de/books.zil
```

The app catalogs are [English](../../catalog/en.lua) and
[German](../../catalog/de.lua). They determine the available titles, shelf
order, summaries, and cover paths. Reuse an existing cover by path when the
art suits both editions. Keep localized story assets in the edition folder
when their text or content differs.

The full edition ID is `books.<language>.<slug>`, used by the app and CLI
saves. The app restores only that edition's commands. The CLI requires
`--language de` for German books and refuses a snapshot from another edition.
On launch, Adventure Arena uses the device's preferred languages in order and
opens the first catalog with titles. English is the fallback. Keep
**Settings → Story Language** on **Automatic** to follow the device, or choose
a catalog explicitly. The edition supplies its own commands and suggestions.
Catalog navigation and general app settings use the existing English interface.

## What changed in Infocom's German edition

Compare [the English source](../infocom/zork1/) with
[the German source](../infocom/zork1-de/). These five files explain most of
the changes relevant to authors.

| File | What to bring into a conversion |
| --- | --- |
| `zork1.zil` and `loop.zil` | The German header declares `LANGUAGE GERMAN`, uses YZIP-era facilities, and loads a separate loop in place of the English `main.zil`. Room direction properties become `NORD`, `OST`, `SUED`, `NO`, `SO`, `RAUF`, and `RUNTER`. The book entry also declares `HINEIN` and `RAUS`. |
| `syntax.zil` | German action sentences have their own verb stems, articles, prepositions, and word order. For example, `nimm das Blatt`, `lege das Blatt in den Rahmen`, and `schau in den Schrank` use the German grammar while still dispatching stable IDs such as `V-TAKE`, `V-PUT`, and `V-LOOK-INSIDE`. German imperatives and their aliases often differ only at the end. |
| `parser.zil` and `globals.zil` | The German parser recognizes articles and contractions such as `der`, `den`, `dem`, `im`, and `aufs`. It has distinct pronoun references for masculine, feminine, and neuter nouns. The local object vocabulary needs explicit inflected adjective forms and synonyms that make sense in German. |
| `dungeon.zil` and `tells.zil` | Objects supply `DERBIT`, `DIEBIT`, or `DASBIT` from the **German** noun. `DESC` supplies the noun, and `ADJDESC` can supply a printable adjective stem. The German `TELL` tokens choose the article and ending by case. Triggering `DER-NOM-CAP` on a masculine noun yields “Der …”, whereas `DER-ACC` yields “den …”. Review plural phrases, proper names, and irregular endings as whole sentences. |
| `verbs.zil` and `actions.zil` | Shared responses, disambiguation, hints, room descriptions, descriptions of actions, and a game's printed clues all need language review. The translator's notes in the archive call out fragments that surround a substituted object. Translate that whole sentence and exercise each branch that changes its object or wording. |

The playable German book entry [uses the German parser, grammar, articles, and
loop](../infocom/zork1-de/books.zil). Its port uses UTF-8 for prose instead of
the historic glyph escapes and the Lua VM's property and dictionary layouts
instead of the archive's YZIP structures. The runtime keeps German dictionary
words at full length and accepts both umlauts and their ASCII alternatives,
such as `öffne` and `oeffne`. The archived German Zork world is reference
material. The book entry loads its mechanics and language modules without
loading that dungeon, puzzle actions, hints, or terminal status-line code.

## Convert a book

1. Copy the edition's world, actions, and tests to `books/de/<slug>/`. Leave
   internal object and routine IDs, flags for puzzle state, and
   `INTERACTIONS` action/partner IDs intact. In `<slug>.zil`, insert
   `infocom/zork1-de/books` before the local files, then use the German room
   direction properties. Keep each book's own load order where actions and
   world declarations depend on it.
2. Translate the title page, room and object text, inscription clues,
   dialogue, game-specific errors, alternate branches and endings. Start the
   story with `VERBOSE` and end it through `FINISH`. Check where the archive's
   generic text is reached for that book's mechanics.
3. Build the playable vocabulary. Make the first `SYNONYM` a unique noun the
   reader can send by itself. Add natural alternatives and accepted
   adjective forms for typed commands. Give singular objects the correct
   article flag. Audit both sides of each `[[label->target]]` link. The
   visible label may be inflected while the target needs to resolve to the
   canonical noun. For example, use `[[Süden->sued]]` for a direction exit.
4. Keep any narrow story-specific `SYNTAX` with that book's actions. Reuse
   existing German commands and dispatch IDs where available. For example,
   the museum adds `kipp` for its lens but uses the shared `drück` and
   `lege … in …` grammar for operating the console. Check each authored
   companion action's label **and** command in the states that offer it.
5. Update `game.json` and the German app catalog together. Exercise a fresh
   session, a return to the same save, and navigation to the English
   catalog. New or renamed edition IDs start fresh saves.
6. Run the package of checks below. Exercise overlong or compound names,
   mixed case, umlauts and ASCII alternatives, articles and inflection,
   ambiguity, wrong actions and recovery, each ending, and the complete
   playthrough using only offered links. Keep the walkthroughs under
   `test/`.

## Run the checks

From the ZILScript root:

```sh
lua5.4 llm.lua --language de --game borrowed-tomorrows --new-game --links --save /tmp/borrowed-de.sav
lua5.4 llm.lua --language de --game borrowed-tomorrows --choose 5 --save /tmp/borrowed-de.sav
lua5.4 main.lua books.de.museum-unsent-signals.museum-unsent-signals
make test-book-walkthroughs
make lint-zil
make zip GAME=borrowed-tomorrows BOOK_LANG=de
```

The walkthrough target covers both catalogs. Lint checks the syntax and
parser resolution of prose links and plays common object verbs in both
languages. The additional English vocabulary lints compare printed English
phrases with synonym and adjective declarations. The source archive preserves
the paths of the edition and its substrate.

Completed German editions are
[Die Bibliothek der geliehenen Morgen](../books/de/borrowed-tomorrows/) and
[Das Museum der ungesendeten Signale](../books/de/museum-unsent-signals/).
The English catalog has twelve books. The other ten have no German edition
yet.

## Russian editions

[Огни Меридиана](../books/ru/blackout-at-meridian/) shares its
[story logic](../books/shared/blackout-at-meridian/logic.zil) with the
English and German editions. Its [Russian base](../languages/ru/base.zil)
declares `LANGUAGE RUSSIAN` and loads Russian
[vocabulary and syntax](../languages/ru/syntax.zil). Declare the forms
the parser should recognize in `SYNONYM` and `ADJECTIVE`. Use the display
form on the left of a prose link and the parser form on the right, as in
`[[карточка героя->карточку]]`.

```sh
lua5.4 llm.lua --language ru --game blackout-at-meridian --new-game --links --save /tmp/meridian-ru.sav
lua5.4 books/ru/blackout-at-meridian/test/test_walkthrough_russian.lua
make lint-zil
```
