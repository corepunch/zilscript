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

At the inspected [ZILScript revision](https://github.com/corepunch/zilscript/tree/d5c61a5a93d0cb9e4e3b0933d180997b958ac4a6),
the campaign starts with hero/profile preparation before the mission, then
moves through three authored locations: Dispatch, the bridge rescue, and the
relay confrontation. The bridge picks a different rescue attribute by hero
profile, and the relay supports fighting the drone or attempting the technical
bypass. Resolution updates Health and Karma, records rescue and drone state,
and ends in success or defeat. Compare [setup and sheet
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
   rescue with the crew. Keep both routes visible through parser and companion
   links.
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
