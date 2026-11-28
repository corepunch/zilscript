# FASERIP adventure modules and Blackout at Meridian

Three original TSR module booklets were checked. Page numbers refer to the
printed pages; PDF viewers may count covers separately. These are historical
references for structure only, not sources of game text, characters, maps,
artwork, or a license to distribute them.

## Three patterns from the original modules

### After Midnight (MLA1, TSR 6892, 1990): urban investigation

[Original scan](https://mshgamer.com/wp-content/uploads/2013/03/TSR6892.MLA1_.After_.Midnight.pdf).
This is the closest reference in scale of individual encounters, not in total
length. It supports both Basic and Advanced rules and can be run by itself or
as the first part of Gang Wars (printed pp. 1–3). The front matter contains the
premise, suggested heroes, NPC factions and the central device. A chain of 35
short chapters is followed by a conditional epilogue and an NPC roster. Maps
are supporting material, separate from the sequence.

The pool-hall encounter (pp. 16–17) separates purpose, what players see, what
happens, onward consequences and Karma. Entering openly or in disguise changes
the encounter; an upfront offer of help makes persuasion easier than
interrogation. What the informant asks for depends on whether they helped him
during the interruption. The same clue can therefore be earned with different
costs and relationships. The finale and epilogue (pp. 46–50) distinguish
defeating the villain from clearing the heroes' names: recovering evidence
affects a later court outcome, and the standalone ending differs from the
trilogy handoff.

**For Meridian:** follow this model for local NPC reactions, alternate
approaches with different costs, and a short debrief that remembers what the
player saved. Do not reproduce a 35-chapter campaign to make a three-scene
game feel more like a module.

### The Revenge of Kang (MT3, TSR 6891, 1989): authored chapter graph

[Original scan](https://mshgamer.com/wp-content/uploads/2013/03/TSR6891.MT3_.The_.Revenge.Of_.Kang_.pdf).
The 64-page booklet opens with background and campaign assumptions, then gives
player characters and friendly/enemy NPCs, followed by 38 numbered chapters
and a separate map sheet (pp. 1–6, 17–19). The first chapter has an alternate
start for groups without the preceding modules. An optional campaign coda
begins at chapter 34 (pp. 59–63).

The chapter template returns to the same useful questions: what is the scene
for, what do players see, what might they do, where does each outcome go, and
what earns or costs Karma? The routes across the bay and through the swamp
have different hazards and rejoin at the spire (pp. 20–22). The wisdom trial
(pp. 27–28) offers a logic puzzle and an optional Reason FEAT fallback. Failure
routes to another playable chapter rather than immediately terminating the
adventure. Between tests, an escape branch can also change how a return visit
plays.

**For Meridian:** keep its authored scene spine, but give a bad result a cost
and a different next decision. Rejoin paths once their consequences are
recorded. A scene graph is an authoring and testing tool, not a requirement to
replace the player's object-based parser with a numbered chapter book.

### Nightmares of Futures Past (MX1, TSR 6873, 1987): situation and state

[Original scan](https://mshgamer.com/wp-content/uploads/2013/03/TSR6873.MX1_.Nightmares.of_.Futures.Past_.pdf).
This is deliberately a campaign toolkit rather than one compulsory mission.
The introduction (pp. 1–2) encourages original heroes and states that there is
no single crime or villain the players must resolve. Setting and faction
material comes first, then scenario-specific rules (p. 19), keyed camp material
(pp. 20–23), NPCs (pp. 24–25), and situations and event triggers (pp. 26–32),
with a separate tracking diagram and base plan.

The hunt (pp. 26–27 and inside cover) begins from the characters' level of
concealment. A daily FEAT changes an explicit search state; some states surface
incidents or send the search off target. The party's conduct can change the
inputs. If they are detained, a different event set replaces the outdoor
search procedure (pp. 30–32). Some events remain the Judge's choice; the
booklet does not prescribe a fixed story path.

**For Meridian:** consider one small, telegraphed hazard track only if a longer
scenario needs sustained pressure. Let meaningful actions, not opening a help
screen or inspecting scenery, advance it. Do not import a background faction
simulation, random incident deck, or hidden instant failure into the
introductory mission.

## What our game is today

At the inspected [ZILScript revision](https://github.com/corepunch/zilscript/tree/435a6409edd8a7aef1e7e7645e5ba065eb96d8cb),
the campaign starts with hero/profile preparation before the mission, then
moves through three authored locations: Dispatch, the bridge rescue, and the
relay confrontation. The bridge picks a different rescue attribute by hero
profile, and the relay supports fighting the drone or attempting the technical
bypass. Resolution updates Health and Karma and ends in success or defeat.
The east exit is gated on the rescue; a failed rescue costs 5 Health and
leaves the same approach available. Once the drone is down, throwing the
lever needs no further roll. The guarded technical option previews its
required FEAT tier. Both successful routes converge on the same ending;
they do not preserve an evidence outcome or an independent rescue-method
flag. The kit is single-use and can exchange Karma for recovery. Compare [setup and sheet
export](../books/shared/blackout-at-meridian/rules.zil), [encounter
logic](../books/shared/blackout-at-meridian/logic.zil), and [edition and
ruleset boundaries](RPG-SYSTEMS.md).

This resembles the chapter structure of *After Midnight* and *Kang*:
description, approach, check, aftermath. It does not resemble a campaign
framework like *Nightmares*. Dispatch mostly functions as preparation; both
successful relay approaches restore the city; many failed rolls mainly cost
Health and permit another attempt. This is a good length for a standalone
tutorial. The gap is consequence design, not missing chapters or missing
licensed setting material.

## What to align next

1. **Use a small encounter contract in the author's notes and tests.**
   Record a stable ID, entry prerequisites, first-view clues, supported
   approaches, ability/power and difficulty per approach, result tiers,
   one-time rewards, state changes, alternate exits and debrief flags. Keep
   localized prose independent of this state. Don't make players see internal
   notes.
2. **Prototype one fail-forward beat, not another rules engine.** If the
   bridge attempt fails, change the situation and expose a clue or safer
   alternative, instead of requiring the same roll until Health runs out.
   Example: rescue immediately, or stabilize the tram and coordinate a slower
   rescue with the crew. Keep both routes visible through parser commands and companion choices.
3. **Make the relay choice matter in the debrief.** Distinguish the public
   benefit of restoring power from how it was done. Successful technical
   control might preserve evidence; force might be faster but damage it.
   Track the result and reward once. Do not require another mission, persistent
   campaign, or a new resource economy for this beat.
4. **Expand only when extra stories need it.** Optional scenes, contacts,
   reputation and across-module handoffs make sense for a second independent
   module. Use a visible, turn-based pressure track only for a scenario that
   benefits from it. Leave large maps, multi-hero encounter scaling, and
   freeform Judge adjudication out of this solo introductory book.

An acceptance test for the first aligned encounter: each profile can finish
the primary route and at least one bad-roll route; the reader's visible
choices explain the changed situation; retries cannot farm rewards; and
save/reload plus EN/DE/RU replays preserve the same outcomes. This is a design
recommendation, not a claim that the mission already implements these changes.


## Second pass: more than encounter chapters

The examples below are additional readings of the three original scans
linked above. The Meridian adaptations are proposals, not shipped behavior.

| Source and printed pages | Additional lesson | How to use it without copying the scenario |
| --- | --- | --- |
| *After Midnight*, pp. 11–12 and 15–17 | The initial lead can arrive through a public story or a personal contact. Later public reporting and a witness's willingness to help react to what the heroes actually did. | Make indispensable information available from more than one source. An existing contact can add context or save effort, but absence of a contact must not gate the next scene. Echo a specific action in a dispatcher or crew report rather than introducing a global Popularity stat. |
| *After Midnight*, pp. 9–10 and 34, 49–50 | The adventure explicitly discourages stopping a recurring villain's escape to protect future chapters. Other passages distinguish witnesses' claims from evidence that can change a later verdict. | Keep the latter, reject the former. If the player credibly secures something early, record it and rejoin the plot from that state. Never present a win the book is secretly committed to undoing. Make optional evidence traceable to a specific action. |
| *The Revenge of Kang*, pp. 17 and 25, 27–28 | A standalone start supplies context that a campaign party already knows. In the tribunal, relevant arguments can improve a character check; the wisdom trial also lets players solve the problem before falling back on a roll. | Put a clear objective in the opening. Let a clue obtained by inspecting the scene affect a later action in a named, visible way. Use a solved interaction to bypass a roll where it makes sense, and never import real-time puzzle timers or require the player to perform a speech well enough. |
| *Nightmares of Futures Past*, pp. 26–27 and 31–32 | Concealment sets the initial search position, leads can go stale, and a different situation can switch off the outdoor search procedure entirely. This is richer than an always-on countdown. | For a later scenario, author named states with visible tells, interventions, and a stop condition. Check what starts, changes, or ends the pressure; do not keep a clock running in an unrelated scene. For Meridian, visible changes after a rescue failure are enough; no clock needed. |

## First follow-up: make a setback change the next decision

Keep Dispatch, Bridge and Relay. Implement one complete beat before adding a
new scene or rule:

1. **Dispatch:** give one concrete goal and one optional lead that makes
   sense to a newcomer. Let the player restate the goal in their own words.
2. **Bridge:** keep the current immediate, profile-specific rescue. After
   the first failure, show what went wrong and make an assisted option
   visible through the existing crew. For example, stabilizing the car and
   coordinating the crew can secure the passengers at the cost of leaving
   the tram unusable. That route should not require the same failed dice
   check again. A direct success and an assisted success both open the
   east exit and award rescue credit once.
3. **Relay, second priority:** keep combat and technical control. Make a
   diagnostic record an optional, separately discoverable object. Recovering
   it before damaging the relevant equipment changes what the dispatcher can
   report. Neither route should silently imply evidence was recovered.
4. **Debrief:** say whom the hero saved and what they managed to bring back,
   then end the mission. Two short, concrete lines are more useful than a
   generic victory paragraph or a new reputation meter.

### Ownership

- **Book:** cue, authored approaches, NPC reactions, evidence, outcomes,
  reward conditions, and debrief. Share the logic across EN/DE/RU; localize
  prose and command aliases in the editions.
- **Ruleset:** FEATs, stat labels and resource arithmetic. Do not hard-code
  this mission's evidence or contacts into FASERIP.
- **Reader:** accept typed commands. The reader should not invent or award outcomes.
- **Author notes and regression cases:** record the table below before a
  second module needs it. No new scenario data format, campaign tracking,
  expandable faction simulation, or global Popularity stat for this change.

| Case to prove | Expected result |
| --- | --- |
| Immediate rescue passes for each profile | Passengers saved, east exit available, reward awarded once. |
| First rescue fails | Immediate consequence and new option are visible; player can advance without repeating the same roll. Merely inspecting the scene does not reroll or change the rescue state. |
| Assisted rescue succeeds | Same primary objective completed, different recorded method. Repeating it the action cannot farm the rescue reward. |
| Relay defeated by either approach, record found or missed | Each route can win; debrief truthfully reflects the independent evidence result. |
| Resume after setback and before debrief | Same outcomes and available actions in EN/DE/RU; old saves are either reproduced or explicitly migrated. They must not silently replay into a new outcome. |

## Parent-and-child test before expanding

For a first run with a nine-year-old, read the opening aloud, let the child
choose and name the hero, then give them control of the first action. Offer
two verbs only when they ask for help. If they hit the same obstacle twice,
ask what they would try with a teammate; note that answer as a candidate
for an authored option, rather than silently telling them what to type.
Do not interrupt the first scene to explain the FASERIP table.

Observer checklist: can the child say who needs help, name an action they
want to try, explain what a failed attempt changed, and describe one
specific thing their hero did at the end? These are playtest questions, not
claims about how a child will respond. In the current build, changing the
rescue plan is a table-side improvisation, not an implemented crew rescue.
