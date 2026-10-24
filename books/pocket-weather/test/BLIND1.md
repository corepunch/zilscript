# Pocket Weather Bureau — independent blind playtest, round 1

Tested 2026-10-24 with seed 823. Read only PLAYING.md and the CLI's player-visible JSON. No source, walkthroughs, tests, design documents, previous reports, or other testers' findings were consulted. All play used current numbered actions. No typed parser commands, state inspection, or save branching. No hints requested. The driver only selected supplied indices, printed supplied labels, and logged responses.

Artifacts: `/tmp/pocket-blind1.sav` and its CLI transcript; `/tmp/pocket-blind1-transcript.jsonl` has full returned JSON for 83 chosen actions, followed by one terminal observation. Initial new-game output is in the CLI transcript; the JSONL starts with my first action, reading the forecast card. Record numbers below refer to 1-based JSONL records.

## Result and ending proof

Completed without a blocker, restart, or hint. Chose **soft drizzle**, reached **THE END -- A FORECAST YOU CAN KEEP**, `running:false`, no actions. A fresh subsequent `--links` invocation still returned `running:false` and no actions.

Final prose: rain reaches every root through the gutter; someone calls Pause; Nimbus stops; Mica rings the bell; Nimbus rests beside the apprentice and keeps the air over their shoulder dry. The ending records “a promise published.” I had taken the forecast card back out of the slot after broadcasting; broadcast remained valid, which makes sense for an already transmitted message.

## What worked

The core progression was understandable and satisfying. I explored terrace → rookery/laundry/kitchen → garden/shed → hollow → archive/kitchen → hollow → post/balcony → terrace. I deliberately tried some actions too early or with the wrong object, then recovered using the presented feedback.

The strongest emotional beat is the report and pressed flower: Nimbus followed orders, Ludo was not angry with it, and showing the flower gives Nimbus a remembered kindness rather than merely completing a checklist. “I can stop, and still be good at rain” is a particularly clear, child-readable statement of the story's heart. Mica apologizing makes responsibility belong to the institution too.

The finale is substantially earned by earlier actions. Freeing the vane establishes the safe route; a narrow spoon creates a gentle gutter; the chart previews both downwind rain and a stopping hand; silencing the chime makes actual listening possible; the report changes the meaning of the cloud's refusal; the promise and public card make the repaired agreement visible. The ending then uses route, gutter, flower, and pause instead of introducing a surprise solution. The final dry pocket of air is an affectionate payoff to the title and relationship.

The practical puzzle feedback is forgiving: the wrong digging tool explicitly points toward a narrow baking spoon; the closed report clearly needs warm steam; the chime tells you why words cannot be heard; writing before agreement is refused. No deadline or punishment discouraged exploration. Taking the ribbon out of the chime correctly made it loud again, and tying it back restored quiet. Searching the emptied apron did not duplicate its objects. Nested inventory showed the flower inside the report, and I could show that flower to Nimbus.

## Actionable findings

### 1. Medium: premature rain request skips the emotional state in its explanation

Reproduction: visit Nimbus before quieting the chime or having any conversation/agreement. Choose Listen to, then Drizzle (records 37–38).

What I saw: Listen says “The chime beyond the hollow shatters Nimbus's words. Soften it before trying to listen.” Immediately choosing Drizzle produces perfectly intelligible quoted dialogue: “Our promise needs to reach the town first. Write your card, let Mica approve it, and put it in the broadcast slot.” We had made no promise, and the cloud had not been heard at all.

Impact: spoils later workflow and makes Nimbus talk as though trust already exists. The world stops respecting the very listening rule the puzzle is teaching. Gate rain feedback by the earliest missing stage: quiet/listen, understand yesterday, agree, publish. Do not call it “our promise” until one exists.

### 2. Medium: menus retain impossible object actions after an object leaves

Reproduction A: in the rookery give Aster the brass button (22). He accepts it and hops east to the perch. The same returned menu offers brass button: Drop and turn the vane: Spin. Drop says “You don't have that!” (23); Spin says “You can't see any vane here!” (24). Aster's Examine/Tell also remain even though he moved.

Reproduction B: after the promise Nimbus explicitly moves west and south to the terrace (69). The hollow still offers Nimbus: Take, Listen, Tell, Drizzle, Shower, and even report: Steam over Nimbus. Choosing Nimbus: Drizzle says “You can't see any cloud here!” (70).

Impact: for a child using links as affordances, the story explicitly advertises a next step and then denies that it exists. Recompute action availability using current location/possession after movement and transfers; mentioning an out-of-room object should not offer local manipulation.

### 3. Medium: combinatorial menu noise obscures the meaningful actions

The kitchen inventory menu reached 75 actions; the terrace inventory menu reached 79. Examples offered include folded report: Steam over Baker Pip, Steam over pressed flower, narrow spoon: Put in folded report, weather card: Read with pressed flower, wind chime: Open with weather card. NPC menus repeatedly offer every remembered topic rather than a small useful conversation list.

There are also literal duplicates: Baker Pip: Tell about soft ribbon and brass button appear twice after taking both; later Nimbus: Tell about wind chime, soft ribbon, narrow spoon, and pressed flower repeat. These are visible in the recorded JSON, not inferred state. Deduplicate by actual target/topic identity, and reduce impossible generic object pairings. Preserve understandable experimentation such as spoon-versus-ribbon digging without turning every noun into every possible verb partner.

For ages 8–12, the prose is manageable but selecting a relevant action from almost 80 choices is the largest accessibility/readability problem.

### 4. Low: apron room description does not reflect emptied pockets

After taking both brass button and ribbon, revisiting the laundry says “Its pockets bulge” (18). Searching immediately answers that the apron has surrendered its pocketful (19). Use an emptied-pocket variant. The anti-duplication response itself is charming and works.

### 5. Low: conversational wording and menu labels disagree

Responses repeatedly say “ask,” including “Ask Nimbus about the pause,” while the available action says “Nimbus the cloud: Tell about pause.” Aster says “Or ask for a joke,” but the action is Tell about weather joke. I inferred the right choice, but a younger literal reader may see these as different activities. Label the reader action as Ask about, or use dialogue-neutral Talk about consistently.

### 6. Low: terminal prose presents unusable parser controls

The real ending is followed by “Type RESTART, RESTORE, or QUIT” and a parser prompt, but JSON correctly has no actions and the persisted session is terminal. In a link-only reader, replace this with supported reader controls or suppress the parser prompt. It does not prevent recognizing the ending.

## Reading and story assessment

The short paragraphs, sensory specifics, gentle humor (“correct volume for seven birds”), concrete tools, and small map suit ages 8–12. Terms such as counterweight, clapper, forecast and archive are reasonably supported by context. The cloud's fear of doing wrong feels comprehensible without being frightening. The repeated pause language is explicit, but its enactment in the finale prevents it from being only a lesson delivered in dialogue.

Two minor editorial reservations: “Nimbus was not being naughty. Nimbus was trying to be good” states the moral very directly, especially for older children; the narrator's “Your task was not to catch the weather...” also spells out what the player has just understood. Consider trusting the report/flower and Nimbus's invitation a little more. These are taste judgments, not completion problems.

The short finale could make the pause caller more concrete. It currently says “a small voice,” while Ludo was mentioned only in the old report and never met. Naming or briefly showing that child would strengthen the repair of yesterday. The existing stopping action still pays off clearly.

I did not test the alternate Shower outcome, every generic pairing, or every post-broadcast alteration. This report freezes blind findings; no source-informed verification was performed.
