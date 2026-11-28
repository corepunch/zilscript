# Choosing and tracking a character: lessons from Beyond Zork

## What the original game did

The [1987 Infocom instruction manual](https://www.mocagh.org/infocom/beyondzork-manual.pdf)
explains starting a story on printed p. 4 and the status, diagnosis, and
display commands on pp. 5–7. The [archived source snapshot](../infocom/beyondzork/README.md)
fills in details the printed manual omits. It is a development archive, not an
exact reconstruction of every shipping build.

- **Setup precedes gameplay.** [`GO`](../infocom/beyondzork/misc.zil) runs
  startup and character setup before the opening room description and main
  parser loop. The [menu](../infocom/beyondzork/constants.zil) separates the
  ready-made default, a list of authored presets, random generation, manual
  allocation, and exit. In [`rarities.zil`](../infocom/beyondzork/rarities.zil),
  `QUICK-SETUP` loads a ready-to-play character. `PICK-A-CHAR` previews a
  focused preset's attribute bars before confirmation. The non-quick paths
  confirm attributes and collect the character's identity separately.
- **Full and compact information serve different needs.** `STATUS` (also
  `STAT`/`STATS` in the [syntax](../infocom/beyondzork/syntax.zil)) uses
  `V-STATUS`/`STANDARD-STATS` in [`verbs.zil`](../infocom/beyondzork/verbs.zil)
  to show the character's identity, rank and current attributes in the
  enhanced pane or as text. `DIAGNOSE` is a physical-condition report.
  `STATUS` is an out-of-world action in the source.
- **The live monitor is smaller than the sheet.** Enhanced-mode `MONITOR`
  controls the automatic combat endurance display; it is not another full
  sheet. [`UPDATE-STAT`](../infocom/beyondzork/misc.zil) changes `STATS` and
  tracks the normal values separately in `MAXSTATS`. It refreshes an
  applicable display and can notify the player of a change; the combat bar
  is tied to endurance falling below or returning to its normal value.

## What we adopt

| Feature | Adventure Arena policy |
| --- | --- |
| Ready-made default | The first authored profile is the recommended or initially selected profile where the host offers a quick path. Starting still takes explicit confirmation; highlighting it does not begin play. Parser-only editions require the player to choose a profile. |
| Curated profile selection | Preview the localized profile, play style, and starting values before confirming. *Blackout at Meridian* has three fixed hero profiles; *The Water That Answers* has three fixed investigator profiles. Keep optional character name separate from profile. |
| Random or manual allocation | Not offered in these books. Their encounters are tuned for three known profiles. Add other creation modes only if the book and its ruleset define valid ranges, budgets, and preview/confirmation behavior. |
| During play | Keep the complete sheet a deliberate request and the live monitor a small, optional reader control. The monitor follows the system's bounded pool (Health or Composure here), not a hard-coded attribute named Endurance. A pool displays its current and maximum values, while ranks and uncapped Karma display a single value. |
| Resume | Restore the saved character and current values; do not show character setup again or rederive values from the starting profile. |

We borrow the interaction pattern, not Infocom's narrative text, art, window
layout, or stats. The native reader can present localized controls from
structured ZIL data; parser-only users can inspect the same current ranks
without a dedicated screen.

| Edition | Full character status | Compact diagnosis |
| --- | --- | --- |
| English | `STATUS`, `STAT`, `STATS` | `DIAGNOSE`, `HEALTH` |
| German | `STATUS`, `STAT`, `STATS`, `WERTE`, `CHARAKTERWERTE` | `ZUSTAND`, `GESUNDHEIT`, `DIAGNOSE` |
| Russian | `СТАТУС`, `СТАТЫ`, `ХАРАКТЕРИСТИКИ` (also the Latin spellings) | `СОСТОЯНИЕ`, `ЗДОРОВЬЕ`, `ДИАГНОЗ` |

Full status shows a chosen character name (if entered), a separate profile
label, and the ruleset's ordered rows. Both commands leave the world, turn
counter, scheduled events and dice alone. Before selection they tell the
player to choose a character. The books' existing `SCORE` behavior and end
reports are unchanged.

## Ownership and verification

Books declare their presets and starting scenes. The
[RPG kernel](../rulesets/rpg/kernel.zil) previews from a scratch character and
reads live values from the active character; system layouts define which
values are reported and language packs provide localized verbs and labels.
Preview and live export share the ruleset's row formatter, including
groups, localized rank names and optional maxima. Name validation, layout
and printing in the host do not invent or change ranks, roll dice, or
submit a parser action just to obtain data.

In Elsewhere, **Quick Start** uses the first authored preset and default
name. Selecting a different profile updates the comparison immediately;
**Start** uses the highlighted preset and the optional entered name.
In a running story, **Character Stats** opens the live sheet and print
action. The running header shows the first bounded resource, or it reverts
to the normal score/turn line when the player hides the monitor.

Run `lua5.4 tests/test_rpg_status.lua` for typed EN/DE/RU status and diagnosis
after taking damage, including a scheduled event that must not fire until the
next real action. The test also checks the investigator ruleset and its
existing score command.
