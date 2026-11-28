# Horror book playtest, 2026-11-28

Exploratory sessions used seed 97 and separate saves; subsequent focused probes used typed commands. These sessions are opening-area samples, not blind completions; they do not establish that later rooms or endings are reachable. The house regression below separately executes a code-informed route to an ending. Lua 5.5.1 was used because `lua5.4` is not installed.

- **Blackwood Horror:** Gate → north → down → down reaches the basement corridor, with explicit exits and a hint of the flooded wing. Waiting did not trap the player. The lower-wing isolation room received a concrete trace of suffering; the playtest did not reach it.
- **House of the Ebb:** Causeway → north → kick Kit → open bag. Kit refuses violence in character and guards the bag. On each LOOK the hall said he *sets* it down again, narrating the same physical action repeatedly. Changed this to a stable description and added repeat-LOOK assertions to `test-round2-interactions.zil`; that test also reaches the brake ending.
- **The Last Broadcast:** Landing → north → north → search body reveals the interrupted brass crescent and points to the clock. The hall now makes the reason to question the other occupants explicit. Later deductions and endings were not explored in this session.
- **The Station at Minus One:** Ticket hall → north → push switch → pull latch → push latch. Both premature decisions are blocked and direct the player to the gauge room; pulling distinguishes the latch's direction. Added a prompt describing the cradle and stud as a way to weigh the caller. The comparison and endings remain untested in this session.
- **The Water That Answers:** Examined doctor, chose doctor, listened to tape, then opened cover before corroborating. The work order and a warning appeared; the cover explained the prerequisite instead of silently failing. Added a clear reason to weigh calling Noor against staying with the tape. The checks and endings remain untested in this session.

No softlock was established in these abbreviated sessions. Independent play, all outcomes, and adversarial testing remain necessary before claiming full coverage.

## Code-informed complete-route verification

After the exploratory sessions above, the existing typed walkthroughs passed for Blackwood, Ebb, Broadcast and Station. Their portable-reader walkthroughs also passed; Station's companion suite exercised both endings. Water's investigation walkthrough passed its preset/check and outcome scenarios. These are authored, code-informed routes, not independent blind play; see the corresponding `test/` directories for exact commands. Ebb's added repeat-LOOK regression also passed.

The revision adds end-of-story motif and consequence details: Blackwood's own breathing after the voice falls silent; Ebb's public and private reckonings with Kit's erased name; Broadcast's handling of the confession and ledger; Station's second cup and the answering rail signal; and Water's separation of corroboration from the original work order. These additions do not change puzzle state or outcomes.
