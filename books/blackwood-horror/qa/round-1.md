# Round 1 — blind link-menu playtest

Evidence frozen before reading adventure source, tests, map or walkthrough. Two fresh games, using only the player output and offered 1-based action indices. Full VM saves remained opaque. Canonical commands: `/tmp/lua5.4 llm.lua --new-game --links --game blackwood-horror --save /tmp/blackwood-r1.sav` and `/tmp/lua5.4 llm.lua --links --choose N --game blackwood-horror --save /tmp/blackwood-r1.sav`. Second save: `/tmp/blackwood-r1b.sav`. The helper `/tmp/bwplay.py` maps an exact offered command to its index; it never injects commands.

## Result

No ending reached. Run A is trapped in Operating Theater because no return movement is offered. Run B reaches Flooded Chamber in darkness; it offers only look, inventory, listen, smell and wait. A carried flashlight cannot be switched on using the offered `lamp on flashlight`: “There was no verb in that sentence!” This is an honest blocked playthrough, not a completed adventure.

## Reproducible defects

1. Gate → north → north enters Operating Theater. Its scene contains tiers, operating table and cabinet, but no route back. Add a visible return passage and directional link.
2. `examine cabinet` opens the cabinet and reports a scalpel and bottle. `look` explicitly lists both, but neither has a menu action. `close cabinet`/`open cabinet` do not repair discovery.
3. Gate → north → west → `examine desk`: “The desk has three drawers. The top two are broken and empty. The bottom drawer is intact but locked.” The only desk options are Examine and Open; Open returns “You must tell me how to do that to a oak desk.” The drawer has no link. A brass key can be found by examining papers and taken, but its intended lock remains inaccessible.
4. Patient Ward: `listen door` and `knock door` are offered and rejected as unrecognized sentences. `attack chains` asks what to attack with and provides no selectable continuation. Check all explicit book action verbs against actual grammar.
5. Basement Corridor → east: `examine boiler` mentions a shovel, `examine bin` reveals coal and `examine workbench` reveals flashlight. They become selectable after look. But Boiler offers Burn and “Lamp on boiler” on a cold boiler; the latter parser token is not player language.
6. Storage: `examine shelves` reveals lantern, medical bag and records. Look lists them, with grammatical errors (“The shelves contains”, “A oil lantern”, “A medical records”), but they still have no menu actions. Open shelves and Open workbench are offered and unsupported.
7. Flooded Chamber can be entered without light and then hides even its retreat. Do not leave the player stranded by a scene's darkness presentation.
8. Entrance door's Close silently refuses with “You leave it half-open.” A door offered as manipulable should reflect its genuine state and block its passage if actually closed.

## Prose and puzzle assessment

The ruined hospital atmosphere is coherent and restrained in several passages: rusted springs, the child's HOME drawing, and the overhead lamp “like an accusation” work. The flashlight, oil lantern and possible other lights appear redundant until distinct purposes are demonstrated. Coal shovel offers Swing/Dig without present purpose; abandoned tools may remain scenic, but meaningful portable tools should have distinct uses. The locked drawer cannot communicate its puzzle through the clickable interface. Ambient footsteps recur too often when trying invalid actions; they risk turning into noise. The generic grue text breaks the hospital voice. Opening the medical cabinet by examining is surprising; explicit Open should be the meaningful action. Room prose should establish architecture and atmosphere, with object presence/state rendered from actual objects. Fixed scenic nouns still need Examine links when the prose makes them salient.

## Exact evidence

See `round-1.transcript.txt` for all actual turns and output in both runs. No source inspection or hidden command was used before this report was frozen.

## Remediation after the blind evidence was frozen

Implemented in `dungeon.zil` / `actions.zil`:

- Added the missing retreat links in the entrance hall, operating theater, isolation ward and padded cell.
- Desk examination now exposes the real bottom drawer and reads its actual open state. The drawer is explicitly openable; its post-opening presence no longer claims it is locked.
- Added action links to revealed scalpel, ether, ledger, file, hollow-book key, bandages, morphine, syringe, bundle and service bell.
- Contents mentioned by the dissection table, drawer, medicine cabinet and service counter now follow actual containment after items move.
- The dark flooded passage refuses entry with a specific explanation until a working light is carried. This avoids the generic grue scene and loss of retreat. The real north exit still works with a lit lantern.
- The oil lantern explains its built-in striker and sustained flame. The electric flashlight's dead batteries are an intentional distinct state, not a second usable light. There is exactly one scalpel object in the world.
- Fixed doors now explain the actual obstruction preventing closure instead of silently substituting the player's decision.

Verification: `test/test-round-1.zil` (23 focused assertions), `make test-horror-all` (including the parser-driven ending walkthrough), 177 static prose links, and 57 room-link targets examined through the parser all pass. The ending walkthrough is implementation verification and is **not** claimed as a blind player completion.

Shared interface defects (unlinked generic nested listings, held-item affordances, parser verb translation and two-object actions) were sent to the main agent for the shared runtime fix. A fresh blind round is still required after those changes; this report does not claim the game is already perfect.
