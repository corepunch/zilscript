# Blackout at Meridian — prototype

Original setting, characters and prose; no licensed superhero identities.

## Architecture

The entry file `blackout-at-meridian.zil` loads the superhero ruleset and
the book's presets, locations, dialogue, and actions. `logic.zil` defines
the world state and actions. `dungeon.zil` adds object details, room
descriptions, parser syntax, and companion choices. `rules.zil` overrides
the shared opening, score, version and USE routines.

The hero and the drone are both characters (stat tables); the profiles are
archetypes (`BULWARK-RANKS`, `ARC-RANKS`, `LENS-RANKS`). The hero actions are
the kernel's: ATTACK (STRIKE, HIT, ...), RESCUE, DISABLE, CHOOSE, POWER
(FOCUS), NAME and STATUS (DIAGNOSE), each with a reply for when no object
takes it; the book's objects answer them in their ACTION routines.

Historical references: TSR Marvel Super Heroes (1984), seven attributes, Health and Karma sums, and percentile checks with four outcome tiers. See https://index.rpg.net/display-generalinfo.phtml?key=system&match=precise&value=Marvel+Super+Heroes . DC Heroes (1985) is a future candidate, not implemented. No source text, characters, artwork or original table graphic copied. Standard-rank percentile thresholds are derived from the historical cumulative probabilities documented at https://www.darkshire.net/~jhkim/rpg/systemdesign/dice-msh.html ; intermediate ranks round down and the extreme shift ranks are not separately modeled. The recovery rule, encounter difficulty and combat loop are independent prototype choices. This is not a complete implementation of the original Karma, FEAT intensity, column-shift or combat rules; do not claim full compatibility.

## Play

Three rooms: Dispatch, Meridian Bridge (north) and the Relay Station (east of
the bridge). Choose Bulwark, Arc or Lens on the duty board (EXAMINE a card to
compare; one choice per game). NAME SHEET asks for a hero name: READ stores it
lowercase, so each word is capitalised; spaces are collapsed, a name longer
than 32 characters is cut at the last whole word, a blank line keeps the
current name and a line with non-ASCII characters is refused. The unnamed
hero is called Meridian. Rescue the passengers (Strength, Agility or Power,
by profile; a failure costs 5 Health), then either strike the drone
(Fighting; it counters for 10 Health until it falls) or throw the bypass
lever (Reason, strong success needed; a failure costs 10 Health). A downed
drone leaves the lever unguarded. The emergency kit works once, costs 10
Karma, restores up to 20 Health and refuses an unhurt hero. Victory and
defeat (0 Health) both end through FINISH, which prints the hero. Taking or
climbing the tram does not attempt the rescue, and opening the kit or console
is inspection only. HELP
explains the rules and the next step.

Adventure Arena and the story tests keep the game
in one process, so the name prompt works. The CLI (`llm.lua`) restores its
snapshot at the parser boundary, so a reply to the name prompt, and to the
RESTART/RESTORE/QUIT prompt after an ending, arrives as an ordinary command.

## Validation

`lua5.4 run-zil-test.lua tests/test-superhero-system` checks the system: every
rank band's cutoffs at both ends, damage, healing to the maximum and Karma
that never goes below zero; `tests/test-rpg-kernel` checks the kernel against
a toy d20 system. `make test-book-walkthroughs` runs the book's tests in
`books/blackout-at-meridian/test/`.

* `test_walkthrough_rules.lua`: a seeded typed walkthrough.
* `test_walkthrough_endings.lua`: every profile to both victories and to
  defeat on the bridge and in the relay, with forced dice; kit rules.
* `test_walkthrough_seeds.lua`: real seeded dice for every profile; every
  reported roll is checked against an independent copy of the percentile
  table, and every check's Health and Karma cost.
* `test_walkthrough_world.lua`: actions before a profile and on wrong
  targets, the typed name, exits and scenery in each state.
* `test_walkthrough_story.lua`: every profile by typed commands, and
  the companion's first card to an ending.

`test/hero.lua` holds their shared helpers. The CLI plays the book with
`lua5.4 llm.lua --new-game --game blackout-at-meridian`. The native build
and the iOS reader have not been verified.
