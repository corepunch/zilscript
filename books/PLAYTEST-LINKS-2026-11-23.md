# Blind link playtest: six books — 2026-11-23

## Scope and method

Fresh sessions with seed 97, using `lua` 5.5.1 and `llm.lua --links` / `--choose`. Decisions came only from displayed prose and numbered actions, including the inventory control. No adventure source, walkthrough, maps, or previous reports were consulted during play. Each action was selected from the latest menu. The saved [transcripts](playtest-2026-11-23/) contain the actual commands and prose; menus are recorded below where relevant. Invalid index errors during testing were tester mistakes and did not execute a game action.

**Coverage:** One blind link-only route reached an ending in each book, with exploratory detours and failed experiments along the way. These are not exhaustive tests of every reachable state, ending, death, or action combination. A missing finding for a book is not a clean bill of health. Severity below reflects observed impact, not a claim that an ending is unreachable. A separate fresh Pocket Weather probe checked the initial inventory and Mica interaction.

## Findings

### Medium — Silent Vector: characters invite topics absent from the link menu

1. Reset habitat power, go north to the junction, north to Clinic, and choose **Mara: Tell**. She says to ask about “the signal, the crew, or Senn's daughter.” The returned menu contains only **Mara: Examine** and **Mara: Tell** for her; none of those three topics is offered.
2. Go north to the laboratory, east to Screened Quarantine, and choose **Senn: Tell**. He invites questions about “the signal, or about Lena.” His menu contains **Senn: Examine** and **Senn: Tell**, with neither invited topic.

A link-only reader cannot follow the offered conversation at that point. After isolating the receiver and returning, the story exposes **Ask about daughter**, so this is an observed state-dependent gap, not proof the whole game is blocked. Expected: the invited topics are selectable when offered, or the dialogue explains that they become available later.

### Medium — misleading object labels across several books

The label identifies a different noun from the object selected. Examples observed immediately on entering the stated room:

- **The Last Broadcast**, Saint Bride Landing: **salt: Examine / Read** targets the station clock, and in Service Workshop **Solder: Search** targets the workbench. In the Record Archive, **draught: Read** targets archive papers.
- **The Silent Vector**, Service Spine: **draught: Examine** targets a ventilation grille; in Physical Archive **footfall: Open** opens a witness recorder. Habitat Junction shows **copper rail: Examine**, but the underlying command is `examine copper copper`.
- **Pocket Weather**, Cloud Hollow: **Rain: Tell / Listen to / Drizzle** refers to Nimbus the cloud.
- **Blackwood Horror**, Morgue: **glow: Open** opens refrigerated drawers.

These actions can work, but readers looking for the stated object or its natural verbs must guess which unrelated word to select. Expected: the selectable noun should clearly identify the target, particularly for object manipulation. In Limehouse's dining room, **Ashworth: Ask about hall table** actually targets the dining table, another misleading label.

### Low — Blackwood Horror: the solution is described with a different noun from its action

In the Patient Ward, **heavy door: Open** says a leather restraint strap binds its handles and must be cut. Neither the strap nor a cut action is offered at that point. After acquiring the surgical scalpel from the operating theater, the menu offers **chains: Cut with rusty scalpel**; selecting it cuts the strap and opens the door. The puzzle works, but the actionable label suggests cutting metal chains rather than the explicitly identified leather fastening. Offer the strap as the target or make the action label describe cutting the strap.

### Medium — Blackwood Horror: offered two-object digging action rejects its own target

In the Overgrown Garden with the coal shovel held, choose **garden: Dig with coal shovel**. The response is “You'd need to specify what you want to dig. The shovel is ready.” The target was already supplied by the menu. From the same state, **garden: Dig in** works and reports digging in the dead earth. The contradictory binary action makes a sensible experiment appear malformed. It did not block the completed route.

### Low — Limehouse Killings: unfiltered item combinations overwhelm menus

With a telegram, magnifying glass, page, lockpick set, knife, and keyring, the Kitchen offers actions such as **kettle: Read with blood-stained knife**, **Read with keyring**, and **Read with creased telegram**. The drawer and other ordinary objects similarly offer combinations for every carried item. This makes the relevant choices difficult to find in an already lengthy menu; after collecting the investigation items, inventory in the Study exposed 222 actions. Consider restricting binary combinations to plausible interactions while retaining meaningful failed experiments.

## Completed sessions

- **Blackwood Horror:** opened the reception drawer and director's safe, obtained the chapel key, started the boiler, explored the hydrotherapy room and opened the chapel. Offered the relic to Patient 189 with the serum and syringe held; reached **Sanitarium Survivor**, 65/68 points, 146 moves.
- **The Last Broadcast:** authenticated the recording, compared the weapon and the boot print, tested witnesses and reconstructed the case. Accused Ada and reached **Case Solved**.
- **Limehouse Killings:** interviewed all three suspects, found the secret passage, matched the poison to the greenhouse, uncovered the financial evidence and presented the three links to Lestrade. Accused Moriarty with the bottle and reached **Solved**, 55/65 points, 130 moves, evidence 4/5.
- **Pocket Weather:** measured wind, cleared the gutter, quieted the chime, read and showed the report, agreed on a promise with Nimbus, wrote and broadcast the card, and chose drizzle. Reached **A Forecast You Can Keep**. The card was found by examining the dispatch bell; the earlier incomplete session did not establish a blockage.
- **The Silent Vector:** restored power and coolant, isolated the receiver, compared the physical strip, gained Ivo's consent, stored the wafer and armed the beacon. Chose preservation and reached **The Unplayed Witness**.
- **Wondertown:** gained Nutmeg's trust with the scarf, recovered the workshop key, wound Old Tick again, reached the heart and positioned the soldier and music box. Reached **Pip has restored the heart of Wrenfold**, 60/100 points, 112 moves, three companions. The music box was not offered as a gift to the fox, but the scarf route worked; this is not established as a blockage.

The transcripts are the authoritative record of the individual choices. They contain parser commands generated by the selected links, not free-text commands typed by the tester. Full displayed menus were not automatically saved; relevant menu entries are transcribed in the findings above.

## Fix verification

The findings above are retained as the original observations. After the fixes, fresh seed-97 sessions retested the affected scenes through the numbered link menus; [retest transcripts](playtest-2026-11-23/retest/) record the selected commands and prose. The regression `tests/test_playtest_link_fixes.lua` additionally checks the menu labels and commands, which plain transcripts do not capture.

- **Silent Vector:** Mara's generic reply offers signal, crew and daughter; choosing crew produces her clinical-log guidance. Senn's generic reply offers signal and Lena; choosing Lena produces his pre-isolation answer. The junction offers `copper rail: Examine` using `examine copper rail`; the service grille and archive recorder have their own labels.
- **Last Broadcast:** the landing offers station-clock actions, the workshop offers workbench actions, and the record archive offers papers actions. The incidental salt, solder and draught no longer label those objects.
- **Pocket Weather:** Cloud Hollow offers Nimbus's actions under the cloud's name rather than “Rain.”
- **Blackwood Horror:** the ward menu identifies the restraint strap along with the chains; cutting with the scalpel opens the morgue. The morgue offers drawer actions rather than glow actions. With the shovel, the two-object garden digging action gives the same meaningful ground response as the one-object action.
- **Limehouse Killings:** the dining-room table is labeled as the current table when questioning Lady Ashworth. Kitchen menus no longer pair the kettle and drawer with arbitrary items; the deliberate lockpick experiment remains selectable. Evidence, useful lens experiments, container operations and accusation routes remain available.

The link-only walkthrough suite reached endings again after the changes. These checks cover the reported scenarios and established routes, not all possible player actions.
