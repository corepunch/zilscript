# Investigator RPG: The Water That Answers

This is an English prototype, not a recreation of a tabletop game. The pump
room holds the recording and the optional investigation; the landing holds
the telephone that lets the player ask for support or report the work order.

| Preset | Medicine | Interview | Repair | Composure |
| --- | ---: | ---: | ---: | ---: |
| Doctor | 80 | 40 | 20 | 65 |
| Reporter | 25 | 70 | 35 | 55 |
| Mechanic | 35 | 25 | 90 | 60 |

The book supplies the roster and role-specific observations; the existing
pre-game contract presents the same generic catalog as Meridian, without
starting a scene or spending a turn. A host with pre-game support selects a
stable preset ID before GO. A text-only host can pick a preset at the
case-file prompt before entering the pump room.

- **Core evidence is deterministic.** Listening gives the gate number and
  circuit, regardless of class or any subsequent roll. Reporting can end
  the case even after every optional roll fails.
- **Corroboration is optional.** Roll at or under the skill, half for hard
  checks, or one fifth for extreme ones (rounded down). The doctor notices
  breathing, the reporter spots a timeline contradiction, and the mechanic
  notices a signal in the telephone feed. The log records which evidence was
  found. After failure, the relay cover permits one different attempt, using
  Repair. Both the prose and the numbered choice announce the noise risk
  before a die is rolled.
- **Composure changes the scene.** The first listen costs 2 on a successful
  check or 17 otherwise. Below 50, staying for the second track costs 5
  more, warned in advance. Going to Noor first recovers 8 (once) and always
  enables a supported return, even if the score remains below 50. There is
  no automatic forfeiture of the core evidence. Nothing rerolls on LOOK,
  a repeated command, or a choice preview.

`rulesets/investigator/system.zil` owns numeric outcomes, bounded resources
and the one-retry state machine. The book owns the conditions, consequences
and choice text. Separately, Blackwood's exposure module still owns cold
ticks, and neither ruleset imports the other.

Historical references: [Beyond Zork manual, pp. 4–5](https://www.mocagh.org/infocom/beyondzork-manual.pdf)
for preset-first setup before the first room description; [Chaosium's skill-roll
reference](https://callofcthulhuwiki.chaosium.com/rules/skill-rolls-and-difficulty-levels.html)
for percentile difficulty and raising the stakes on a second attempt; and
[its Sanity reference](https://callofcthulhuwiki.chaosium.com/rules/sanity.html)
for distinguishing the consequences of a shock roll. The scenario, prose and
Composure design here are original. No Infocom source is imported by the book.

```sh
lua5.4 main.lua --companion books.the-water-that-answers.the-water-that-answers
lua5.4 books/the-water-that-answers/test/test_walkthrough_investigation.lua
```
