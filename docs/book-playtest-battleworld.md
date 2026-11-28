# The Last Door of Battleworld: reader playtest

2026-11-28; Lua 5.4.8, fixed seeds, English 197 and Russian 198. These
sessions are partial and were interrupted while the book was under active
construction; they do not establish full-game playability.

## Reader observations

- Both locales offered all three heroes. Choosing
  Spider-Man (English) or Гроза (Russian) began the mission, and following
  north reached the span. The scene states that passengers need help
  before the route onward. The English prose's sideways school block and the
  Russian rain falling upwards are vivid, accessible images.
- Russian seed 198: choosing «Спасти пассажиров» failed with a roll of 1. The
  text reported the injury, confirmed the passengers survived, and named the
  winch as the alternative. The reader offered «Потянуть» on the winch.
  Before this could be selected, subsequent module loads failed. Its result
  has therefore not been verified in this session.
- The English span menu exposed a north action even though the civilian rescue
  gate should prevent passage; this may be an intentional blocked-direction
  affordance. Its feedback was not tested before the load failure.

## Automated route

An early walkthrough failed with `not in companion menu: choose spider-man at 15`. The subsequent retest below passed after the modules loaded.

## Retest after modules loaded

On the then-current sources, all four scripts passed under Lua 5.4.8:
`test_walkthrough_early.lua`, `test_walkthrough_village.lua`,
`test_walkthrough_worldship.lua`, and `test_walkthrough_battleworld.lua`.
The last reports 12 victories across both languages, three heroes and two
endings, including forced setbacks and recovery. The Worldship test also
reaches the reverse-converter ending in both languages. These are
code-informed, scripted routes, not a new blind full-game reader completion.

An independent fresh-game parser session in each language forced d100 to 1,
selected Storm, repaired the relay, tried the skiff rescue, pulled the winch,
examined the skiff, and walked north to the market. Both editions reported
failure and successful evacuation; examination confirmed the passengers were
safe. The earlier module failure and companion-menu test failure did not recur.

## Changes from this pass

Ms. Marvel now explains in both languages that the catch is holding while
the hero looks around. The Russian failed-rescue response names the same
five-point Health cost as the English response. A headless regression
checks the scene dialogue, the narrated damage, and the actual Health
change in both editions.
