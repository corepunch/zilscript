# Last Broadcast — independent blind round 2

Frozen observations, 2026-10-24. Source blind through the ending and this report. Read only `PLAYING.md` and actual `llm.lua` JSON outputs. No source, design, walkthrough, tests, other QA reports, or agent reports consulted. No hints used. No child agents. Seed 1927; save `/tmp/broadcast-blind2.sav`.

Full evidence: `BLIND2.transcript.jsonl` contains the initial output, all 117 chosen numbered actions with their actual 1-based menu index and full resulting JSON, and a fresh-process terminal observation. Action numbers below correspond to the numbered chosen records; the initial record is zero. Each action used `--choose`, saving the VM normally. A few preplanned label sequences stopped when the next label was absent or had changed; they did not submit a command or advance the world. Choices were always resolved against the current JSON menu.

## Result and ending proof

Solved independently in 117 actions. The final choice was **Ada: Accuse** after a successful reconstruction at action 116. Action 117 produced Ada's confession, `THE LAST BROADCAST -- CASE SOLVED.`, `running:false`, and `actions:[]`. A separate `--links` invocation restored the terminal save and again returned `running:false`, `actions:[]`, with empty output. No parser restart prompt appeared.

The confession earned its conclusion: Ada admits starting the disc intentionally after Vane threatened to burn her father's name with the accounts; she describes the counterweight, hatch, and spanner returned at 9:20. The accounts survive for the workers while the murder goes to police. This is a satisfying moral distinction, and the final unrehearsed announcement/gulls complete the sound motif.

## Actionable findings

1. **Opening referent contradicts the victim's identity (medium narrative priority).** The initial output says: “At nine-seventeen a voice asked the mainland to save this station. Four minutes later its owner was dead.” The next paragraph explicitly attributes the heard voice to Ada. An ordinary reading therefore says Ada died; she is actually alive and Vane is the victim. Reproduce with the new-game command alone. Replace “its owner” with “the station's owner” or name Vane. This is the first impression of the central case, so it deserves a direct correction.

2. **Revisited body retains an unresolved-clock instruction after the clock is solved (low priority).** Action 49 compares the office clock and voltage chart successfully, establishes the undervoltage explanation, and rules the actual interval in the casebook. Action 109 revisits **body: Examine**, which still ends “The office clock has yet to account for its stopped hands.” This falsely suggests unfinished evidence and can send a careful player back over completed work. Condition that final sentence on the established clock explanation, or make it neutral. The physical wound description itself can remain unchanged.

3. **Some exact-command prose is stronger guidance than necessary (optional editorial improvement).** Gramophone examination names the complete sequence and `USE STYLUS ON GRAMOPHONE`; multiple exhibits explicitly order “Show [item] to [person].” All those actions are offered as reader choices. This makes the case very accessible, but the experience becomes following evidence-handling instructions once the sound trick is suspected. Retain practical equipment instructions, while considering whether some social prompts could describe why a witness matters instead of prescribing the verb. This is a preference, not a blocker.

4. **Directional link captions lose destination names on the upper walk (minor reader polish).** Aerial platform prose describes the covered walk east to the bunkroom, but its menu says **east: Go east**. The bunkroom's return says **west: Go west**. Both work, and the adjacent prose supplies the destination. Captions such as **bunkroom: Go east** and **aerial platform: Go west** would match the otherwise helpful destination-first menus.

No progression blocker, missing essential choice, crash, object-identity exploit, or terminal-resume defect was observed.

## Independent deduction and alternate hypotheses

The lamp/routing evidence made the recording-alibi hypothesis available before I met Ada: microphone HEATER rather than ON AIR (16), routing found at DISC with a preserved wax mark (21), and A. Mercer's complete six-minute cut at 8:40 versus Ruth's destroyed two-minute test (25). Ada became the leading hypothesis from actual evidence, not from accusation feedback or the reconstruction.

I also tested Ruth and the kitchen account. An early Ruth accusation (17) failed safely and asked for her full interval and a wound connection. Edith's initially evasive medical privacy and bloody bag were plausible reasons to doubt the kitchen pair, while Tomas's gambling/debt motive supplied another alternative. Those explanations had to be tested: reading and showing the far-end challenge receipt establishes Tomas's continuous participation (59–60); the dressing, glass fragments, table evidence, and Edith's account establish the kitchen interval (55, 75–77); Ruth later recognizes the rehearsal without claiming she saw Ada live (101). A second Ruth accusation (102) gives evidence-specific dismissal rather than repeating the initial generic warning.

Ada's premature accusation (72) did not end the case or award a lucky guess; it required reconstruction. Her early disc response (71) correctly distinguished possession of a disc from having heard it. Her later response (114) distinguished advance preparation from actual whereabouts. These are good safeguards against treating a mechanism as proof of a killer.

The positive physical chain closes the case: notched brass counterweight to wound (48), independent voltage chart to misleading electric clock (49), maintenance assignment and spanner return (67), and Ada's distinctive repaired heel to the bloody print leaving the office route (107). Motive comes from the wage ledger and her response (29, 70). Those independent strands make Ada the uniquely supported culprit among the presented suspects. The mutual kitchen alibi still depends partly on witness credibility, but the Ada-specific physical trail provides positive identification instead of relying only on elimination.

## Agency, affordances, and physical identity

The investigation permits a natural order. I reached the passage from the generator side, opened the hatch from underneath, then entered the office; I explored the upper outside walk before returning to the main investigation. Collecting evidence, comparing physical things, testing equipment, presenting exhibits, revisiting witnesses, and making reversible accusations all worked through numbered choices. No hint or invented parser noun was necessary.

Meaningful wrong experiments were supported. A playback stylus on the hatch (45) correctly fails because only the square spanner fits. A spanner on the gramophone (85) correctly fails because the pickup needs the stylus. Pushing the routing switch (22) provides a controlled, non-destructive test and preserves the original wax witness mark.

The gramophone has real, persistent contents. Putting the disc on it changes the disc to Take rather than Drop (86). Fitting the stylus mounts it physically (88). Removing that stylus (93) makes playback fail in the next separately restored invocation (94); remounting works (95). The disc left on the gramophone cannot be compared remotely with the cutting register: I had to return, take it (96), and bring it to the register (98). This is good object identity and scope discipline. Native container listings exposed the mounted parts and sleeve contents.

Inventory is useful and necessary to reveal some carried-object menus after moving rooms. The explicit inventory reader control was sufficient; I found the disc's Put-in action there (84–86). Captions sometimes change with prose aliases (“lacquer disc”/“disc”, “leather boots”/“pair of leather boots”/“boots”, and item-first versus actor-first Show), but the same objects and commands remain recognizable. No duplicate physical objects were implied by those aliases.

The reconstruction is successful as an organizational aid: SOUND versus PERSON, fixed interval, physical evidence, tested witnesses, and an intentionally blank final line. It stops short of naming Ada. It still largely confirms a conclusion already made independently, which is appropriate here; I retained the final accusation choice.

## Atmosphere and overall assessment

The compact station feels coherent through solder, damp cable rubber, cold paper, tobacco felt, rain on iron, and the separate lamp meanings. Each witness has a specific shame or economic pressure, and Vane's exploitation gives the murder a social context. The voice/recording motif is integral to both the puzzle and the ending. The sharp dialogue is memorable without requiring long exposition.

Fair clue chain: strong. Unique culprit: strong within the presented evidence. Player agency: good exploration and testing, modest deduction freedom once exact instructions appear. Reader affordances: complete for every essential action encountered. Physical object identity: strong, including tested removal/remounting and locality. Completion: unassisted, 117 choices, terminal state verified across process restore.
