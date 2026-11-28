# Blind typed playtest of alternate routes

Fresh Terra players started from Zilscript
`a968c002a6d31235a33b424b550f65aee51b19b8`. They used typed parser commands
and the responses in their current sessions. They had no source, prior
transcripts, walkthroughs, or other players' commands. For repeat sessions,
players could use what they had learned in their own earlier runs.

The pass reached one terminal outcome in each of 20 editions, with
14 additional terminal runs and 5 exploratory runs.
The transcripts preserve the original input and output, including failed
commands and the responses that prompted changes. Seeds below reproduce
the sessions. A repeat can take a different route to the same named ending.

## All editions

| Edition | Seed | Outcome and transcript |
| --- | ---: | --- |
| `de/blackout-at-meridian` | 100 | [Die Lichter von Meridian · Luchs bypass](de-blackout-at-meridian.txt) |
| `de/borrowed-tomorrows` | 101 | [Platz für jeden Namen](de-borrowed-tomorrows.txt) |
| `de/museum-unsent-signals` | 102 | [Private Rückantwort](de-museum-unsent-signals.txt) |
| `en/bell-grew-leaves` | 103 | [Three Leaves for Yes](en-bell-grew-leaves.txt) |
| `en/blackout-at-meridian` | 100 | [The Lights of Meridian](en-blackout-at-meridian.txt) |
| `en/blackwood-horror` | 101 | [Patient 189 freed · Sanitarium Survivor](en-blackwood-horror.txt) |
| `en/borrowed-tomorrows` | 102 | [Room for Every Name](en-borrowed-tomorrows.txt) |
| `en/house-of-the-ebb` | 103 | [The Light Stays · private vigil](en-house-of-the-ebb.txt) |
| `en/last-broadcast` | 104 | [Case Solved](en-last-broadcast.txt) |
| `en/last-door-of-battleworld` | 105 | [The Last Door Stays Open](en-last-door-of-battleworld.txt) |
| `en/limehouse-killings` | 106 | [Solved · letter-led accusation](en-limehouse-killings.txt) |
| `en/museum-unsent-signals` | 37 | [Private Return](en-museum-unsent-signals.txt) |
| `en/pocket-weather` | 104 | [A Forecast You Can Keep · shower](en-pocket-weather.txt) |
| `en/silent-vector` | 37 | [Four Pulses · erase](en-silent-vector.txt) |
| `en/station-minus-one` | 105 | [Outside the Timetable · quarantine](en-station-minus-one.txt) |
| `en/the-midnight-ledger` | 106 | [The Weight of the Record](en-the-midnight-ledger.txt) |
| `en/the-water-that-answers` | 37 | [Case Closed · mechanic](en-the-water-that-answers.txt) |
| `en/wondertown` | 37 | [Heart restored · Master Toymaker](en-wondertown.txt) |
| `ru/blackout-at-meridian` | 37 | [Огни Меридиана · Prism, direct console](ru-blackout-at-meridian.txt) |
| `ru/last-door-of-battleworld` | 37 | [Последняя дверь открыта · Storm, emergency power](ru-last-door-of-battleworld.txt) |

## Additional routes

| Edition | Seed | Outcome and transcript |
| --- | ---: | --- |
| `de/blackout-at-meridian` | 200 | [Die Lichter von Meridian · Fels fights the drone](de-blackout-at-meridian-fels-combat.txt) |
| `de/borrowed-tomorrows` | 201 | [Platz für jeden Namen · returned the leaf before sharing](de-borrowed-tomorrows-return-leaf.txt) |
| `de/museum-unsent-signals` | 202 | [Eine Minute für die Lebenden](de-museum-unsent-signals-memorial.txt) |
| `en/bell-grew-leaves` | 203 | [Three Leaves for Yes · shutter first](en-bell-grew-leaves-shutter-first.txt) |
| `en/blackwood-horror` | 1 | [Chapel exploration · ongoing](en-blackwood-horror-chapel-exploration.txt) |
| `en/blackwood-horror` | 301 | [Patient 189 freed · Asylum Explorer](en-blackwood-horror-explorer.txt) |
| `en/blackwood-horror` | 302 | [Garden exploration · ongoing](en-blackwood-horror-garden-exploration.txt) |
| `en/borrowed-tomorrows` | 202 | [Private reading exploration · ongoing](en-borrowed-tomorrows-private-exploration.txt) |
| `en/house-of-the-ebb` | 203 | [The Shore Hears](en-house-of-the-ebb-ring-bell.txt) |
| `en/last-door-of-battleworld` | 305 | [Doom’s Bargain](en-last-door-of-battleworld-dooms-bargain.txt) |
| `en/museum-unsent-signals` | 37 | [A Minute for the Living](en-museum-unsent-signals-memorial.txt) |
| `en/pocket-weather` | 1 | [Promise exploration · ongoing](en-pocket-weather-promise-exploration.txt) |
| `en/silent-vector` | 37 | [The Unplayed Witness · preserve](en-silent-vector-preserve.txt) |
| `en/station-minus-one` | 204 | [The Extra Stop · rescue](en-station-minus-one-rescue.txt) |
| `en/the-midnight-ledger` | 205 | [The Weight of the Record · Ives finding left unsigned](en-the-midnight-ledger-ives-first.txt) |
| `en/the-water-that-answers` | 37 | [Case Closed · reporter and second-track warning](en-the-water-that-answers-second-track.txt) |
| `en/wondertown` | 1 | [Snowbank exploration · ongoing](en-wondertown-snow-exploration.txt) |
| `en/wondertown` | 37 | [Heart restored · tin soldier ending scene](en-wondertown-tin-soldier.txt) |
| `ru/last-door-of-battleworld` | 37 | [Последняя дверь открыта · Spider-Man, reflected beam](ru-last-door-of-battleworld-mirror.txt) |

## Findings and fixes

| Edition | Finding | Fix |
| --- | --- | --- |
| Museum of Unsent Signals, German | The spool describes a paper label, but `lies etikett` is rejected. [Transcript](de-museum-unsent-signals.txt) | Reading the label by either name now reads the spool’s text. |
| Blackwood Horror | In the garden, `talk to figure` describes Patient 189 gripping the chapel altar. `look under altar` reports only dust even when the box is still there. [Garden](en-blackwood-horror-garden-exploration.txt) · [Chapel](en-blackwood-horror-chapel-exploration.txt) | Patient 189’s responses now fit either location. Looking under the altar shows the box while it is there and the mark it left when removed. |
| Limehouse Killings | The name dial says to compare the bottle with the plants. `compare bottle with plants` is unrecognized. [Transcript](en-limehouse-killings.txt) | `compare` accepts the bottle and the plants or their labels in either order. The identification still requires the bottle in hand and the greenhouse in reach. |
| Pocket Weather Bureau | The first Dispatch Post and Steam Kitchen descriptions omit the weather card and spoon. Both can be taken and are used in the puzzle. [Transcript](en-pocket-weather.txt) | Both objects have an initial room description and can still be picked up normally. |
| Silent Vector | The pump says a wrench can repair it. `use wrench on coolant` is rejected. [Transcript](en-silent-vector.txt) | The typed phrase now uses the existing pump repair, including the checks for the correct, accessible tool. |
| The Midnight Ledger | Examining the Orr tab says it records Orr's guilt, then says it would put the loss on Ives. [Transcript](en-the-midnight-ledger.txt) | Each tab names its own suspect. The completed reconstruction tells players to turn the tab supported by the evidence. |
| The Water That Answers | The story suggests calling Noor, studying the recording, and prying the cover. The corresponding typed verbs fail. [Mechanic](en-the-water-that-answers.txt) · [Reporter](en-the-water-that-answers-second-track.txt) | The parser accepts those commands through the existing telephone, tape and cover actions. Calling still requires the landing. |
| The Last Door of Battleworld | The English tower describes an inscription that the parser cannot read. Russian `говорить с думом` fails, and `применить станок` advises aligning the mirror when it is already aligned. [English](en-last-door-of-battleworld.txt) · [Russian dialogue](ru-last-door-of-battleworld.txt) · [Russian mirror route](ru-last-door-of-battleworld-mirror.txt) | The inscription can be read in both languages, Doom accepts the Russian conversational form, and applying the Loom can use the reflected beam when emergency power is unavailable. |

In the Blackwood operating theater, bare `take all` skips objects inside
the cabinet. `take all from cabinet` and naming either item directly both
work. [Exploratory transcript](en-blackwood-horror-chapel-exploration.txt)

## Replay notes

All recorded terminal routes were replayed against the repaired build.
The initial English Battleworld run typed `accept offer` after failing to
read the inscription. In the repaired run, reading succeeds, so accepting
now ends at Doom’s Bargain. The original transcript continues to the
Worldship. A verification replay without the acceptance also reaches
the Worldship ending on the repaired build. The Russian mirror replay
reaches its original ending on
`применить станок`, one command earlier.
