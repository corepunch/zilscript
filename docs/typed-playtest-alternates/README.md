# Blind typed playtest of alternate routes

Fresh Terra players started from Zilscript
`a968c002a6d31235a33b424b550f65aee51b19b8`. They used typed parser commands
and the responses in their current sessions. They had no source, prior
transcripts, walkthroughs, or other players' commands. For repeat sessions,
players could use what they had learned in their own earlier runs.

The tables cover terminal outcomes, additional routes and exploratory runs.
The transcripts preserve the original input and output, including failed
commands and the responses that prompted changes. Seeds below reproduce
the sessions. A repeat can take a different route to the same named ending.

## All books

| Book | Seed | Outcome and transcript |
| --- | ---: | --- |
| `bell-grew-leaves` | 103 | [Three Leaves for Yes](bell-grew-leaves.txt) |
| `blackout-at-meridian` | 100 | [The Lights of Meridian](blackout-at-meridian.txt) |
| `blackwood-horror` | 101 | [Patient 189 freed · Sanitarium Survivor](blackwood-horror.txt) |
| `borrowed-tomorrows` | 102 | [Room for Every Name](borrowed-tomorrows.txt) |
| `house-of-the-ebb` | 103 | [The Light Stays · private vigil](house-of-the-ebb.txt) |
| `last-broadcast` | 104 | [Case Solved](last-broadcast.txt) |
| `last-door-of-battleworld` | 105 | [The Last Door Stays Open](last-door-of-battleworld.txt) |
| `limehouse-killings` | 106 | [Solved · letter-led accusation](limehouse-killings.txt) |
| `museum-unsent-signals` | 37 | [Private Return](museum-unsent-signals.txt) |
| `pocket-weather` | 104 | [A Forecast You Can Keep · shower](pocket-weather.txt) |
| `silent-vector` | 37 | [Four Pulses · erase](silent-vector.txt) |
| `station-minus-one` | 105 | [Outside the Timetable · quarantine](station-minus-one.txt) |
| `the-midnight-ledger` | 106 | [The Weight of the Record](the-midnight-ledger.txt) |
| `the-water-that-answers` | 37 | [Case Closed · mechanic](the-water-that-answers.txt) |
| `wondertown` | 37 | [Heart restored · Master Toymaker](wondertown.txt) |

## Additional routes

| Book | Seed | Outcome and transcript |
| --- | ---: | --- |
| `bell-grew-leaves` | 203 | [Three Leaves for Yes · shutter first](bell-grew-leaves-shutter-first.txt) |
| `blackwood-horror` | 1 | [Chapel exploration · ongoing](blackwood-horror-chapel-exploration.txt) |
| `blackwood-horror` | 301 | [Patient 189 freed · Asylum Explorer](blackwood-horror-explorer.txt) |
| `blackwood-horror` | 302 | [Garden exploration · ongoing](blackwood-horror-garden-exploration.txt) |
| `borrowed-tomorrows` | 202 | [Private reading exploration · ongoing](borrowed-tomorrows-private-exploration.txt) |
| `house-of-the-ebb` | 203 | [The Shore Hears](house-of-the-ebb-ring-bell.txt) |
| `last-door-of-battleworld` | 305 | [Doom’s Bargain](last-door-of-battleworld-dooms-bargain.txt) |
| `museum-unsent-signals` | 37 | [A Minute for the Living](museum-unsent-signals-memorial.txt) |
| `pocket-weather` | 1 | [Promise exploration · ongoing](pocket-weather-promise-exploration.txt) |
| `silent-vector` | 37 | [The Unplayed Witness · preserve](silent-vector-preserve.txt) |
| `station-minus-one` | 204 | [The Extra Stop · rescue](station-minus-one-rescue.txt) |
| `the-midnight-ledger` | 205 | [The Weight of the Record · Ives finding left unsigned](the-midnight-ledger-ives-first.txt) |
| `the-water-that-answers` | 37 | [Case Closed · reporter and second-track warning](the-water-that-answers-second-track.txt) |
| `wondertown` | 1 | [Snowbank exploration · ongoing](wondertown-snow-exploration.txt) |
| `wondertown` | 37 | [Heart restored · tin soldier ending scene](wondertown-tin-soldier.txt) |

## Findings and fixes

| Book | Finding | Fix |
| --- | --- | --- |
| Blackwood Horror | In the garden, `talk to figure` describes Patient 189 gripping the chapel altar. `look under altar` reports only dust even when the box is still there. [Garden](blackwood-horror-garden-exploration.txt) · [Chapel](blackwood-horror-chapel-exploration.txt) | Patient 189’s responses now fit either location. Looking under the altar shows the box while it is there and the mark it left when removed. |
| Limehouse Killings | The name dial says to compare the bottle with the plants. `compare bottle with plants` is unrecognized. [Transcript](limehouse-killings.txt) | `compare` accepts the bottle and the plants or their labels in either order. The identification still requires the bottle in hand and the greenhouse in reach. |
| Pocket Weather Bureau | The first Dispatch Post and Steam Kitchen descriptions omit the weather card and spoon. Both can be taken and are used in the puzzle. [Transcript](pocket-weather.txt) | Both objects have an initial room description and can still be picked up normally. |
| Silent Vector | The pump says a wrench can repair it. `use wrench on coolant` is rejected. [Transcript](silent-vector.txt) | The typed phrase now uses the existing pump repair, including the checks for the correct, accessible tool. |
| The Midnight Ledger | Examining the Orr tab says it records Orr's guilt, then says it would put the loss on Ives. [Transcript](the-midnight-ledger.txt) | Each tab names its own suspect. The completed reconstruction tells players to turn the tab supported by the evidence. |
| The Water That Answers | The story suggests calling Noor, studying the recording, and prying the cover. The corresponding typed verbs fail. [Mechanic](the-water-that-answers.txt) · [Reporter](the-water-that-answers-second-track.txt) | The parser accepts those commands through the existing telephone, tape and cover actions. Calling still requires the landing. |

In the Blackwood operating theater, bare `take all` skips objects inside
the cabinet. `take all from cabinet` and naming either item directly both
work. [Exploratory transcript](blackwood-horror-chapel-exploration.txt)

The Battleworld inscription now accepts READ, and the Loom can use the
market mirror when emergency power is unavailable.

## Replay notes

All recorded terminal routes were replayed against the repaired build.
The initial Battleworld run typed `accept offer` after failing to
read the inscription. In the repaired run, reading succeeds, so accepting
now ends at Doom’s Bargain. The original transcript continues to the
Worldship. A verification replay without the acceptance also reaches
the Worldship ending on the repaired build.
