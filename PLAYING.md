# Playing Games Programmatically

This document explains how agents (or scripts) can play ZIL games to evaluate playability, test game content, or run walkthroughs.

## Overview

Use `llm.lua` to interact with games one action at a time. For blind testing,
use the reader's prose links and numbered menus, not invented parser commands.
The same `Session.parseLinks` and `Session:linkActions` methods power Adventure
Arena and this interface.

## Blind Link Play

Run from this repository's directory:

```bash
lua5.4 llm.lua --new-game --links --game wondertown --save /tmp/play.sav --seed 97
lua5.4 llm.lua --links --game wondertown --save /tmp/play.sav
lua5.4 llm.lua --choose 4 --game wondertown --save /tmp/play.sav
```

Output is JSON: `{output, room, running, actions}`. Each action is an array
`[label, command, linkTarget]`; `--choose N` selects its **1-based position in
the current list**. Read the result before choosing again. `--links` alone
observes menus without advancing a turn or rewriting the save. Look, inventory
and wait are explicit reader controls; inventory and native container lists
expose links to their real objects. Object menus use actual parser syntax,
including second objects and conversation topics introduced in prose. No
hidden-room inspection, source-derived hints or companion walkthrough is
added. Missing links or missing object actions are bugs to report.

Every chosen action writes the full world-memory image and scalar VM globals,
including the private random-generator state and reader presentation records.
Next invocation restores these directly, without replay. The save is required;
there is no history fallback in link mode. Lua coroutine stacks are not
serialized: play resumes at the ordinary input boundary, and `FINISH` is
recorded as terminal so a completed/dead story cannot resume normal play.
Start a fresh game after story/format changes; there are no save migrations.
`<save>.transcript` records actual commands and raw prose-link output.

For each QA round, keep the player blind to source, prior reports, maps and
walkthroughs until observations and transcript are frozen. Only then inspect
and fix the book. Label subsequent code-informed verification separately.

## Parser Diagnostics

The free-text interface below remains useful for focused parser regressions.
It is not evidence of a blind link-only completion.

## Quick Start

```bash
# Start a new game (creates zork1.sav and zork1.sav.actions in /tmp)
lua5.4 llm.lua --new-game --save /tmp/zork1.sav

# Send a command
lua5.4 llm.lua --action "look" --save /tmp/zork1.sav

# Play through a sequence
lua5.4 llm.lua --action "open mailbox" --save /tmp/zork1.sav
lua5.4 llm.lua --action "take leaflet" --save /tmp/zork1.sav
lua5.4 llm.lua --action "read leaflet" --save /tmp/zork1.sav
```

## Output

Each command returns the game's text output directly (plain text, no JSON):

```
Ashworth Manor Gate
The iron gates of Ashworth Manor loom before you...
```

- **Exit code 0** — command executed successfully
- **Exit code 1** — error occurred (stderr shows `ERROR: ...`)

## How State Continuity Works

1. `--new-game` starts fresh, saves initial state, and resets the action history.
2. Each `--action` call restores state from the save file, replays the command, then saves the new state.
3. A JSONL action history (`<savefile>.sav.actions`) is maintained as a fallback if the binary save is unavailable.
4. Each invocation is a separate OS process — no Lua state persists between calls.

## Agent Play Loop

To play N turns of a game:

```bash
SAVE="/tmp/zork1.sav"

# Initialize
lua5.4 llm.lua --new-game --save "$SAVE"

# Play turns
for i in $(seq 1 10); do
  # Execute a command - output is plain text, exit code 0=success, 1=error
  lua5.4 llm.lua --action "look" --save "$SAVE"
done
```

## Using With an LLM Agent

An agent can play the game in a loop:

1. **Start**: `lua5.4 llm.lua --new-game --save /tmp/game.sav`
2. **Observe**: Read the plain text output
3. **Decide**: Choose the next command based on game state
4. **Act**: `lua5.4 llm.lua --action "<command>" --save /tmp/game.sav`
5. **Repeat** from step 2

The agent should:
- Use `look` or `examine` frequently to understand the current state
- Track inventory with `inventory`
- Try multiple approaches if a puzzle doesn't yield results
- Read any text the game presents (signs, leaflets, etc.)

## Basic Commands

| Category | Command | Example |
|----------|---------|---------|
| Movement | `<direction>` or `go <direction>` | `north`, `go east`, `south`, `west`, `up`, `down` |
| Examination | `look`, `examine <object>` | `look`, `examine desk`, `x desk` |
| Inventory | `inventory` or `i` | `inventory` |
| Taking/Dropping | `take <object>`, `drop <object>` | `take key`, `drop key` |
| Containers | `open <container>`, `close <container>`, `look in <container>` | `open drawer`, `look in trunk` |
| Reading | `read <object>` | `read letter` |
| Pushing/Pulling | `push <object>`, `pull <object>` | `push button` |
| NPC Interaction | `ask <npc> about <topic>`, `tell <npc> about <topic>`, `show <object> to <npc>` | `ask hudson about master` |

Standard verbs: EXAMINE, TAKE, DROP, USE, OPEN, CLOSE, LOOK, READ, ASK, TELL, SHOW, GO, PUSH, PULL, TASTE.

## Command Reference

See [TESTING.md § How to Play](TESTING.md#how-to-play) for the full command reference.

## Available Games

Pass `--game <name>` to play different games:

| Game | Module |
|------|--------|
| zork1 (default) | `infocom.zork1.zork1` |
| lurkinghorror | `infocom.lurkinghorror.h1` |
| spellbreaker | `infocom.spellbreaker.z6` |
| planetfall | `infocom.planetfall.planetfall` |
| limehouse-killings | `books.limehouse-killings.limehouse-killings` |
| blackwood-horror | `books.blackwood-horror.blackwood-horror` |
| wondertown | `books.wondertown.wondertown` |

## Command-Line Reference

```
lua5.4 llm.lua [options]

Options:
  --action, -a "cmd"   Execute this command
  --save, -s file      Save file path (default: savefile.sav)
  --game, -g name      Game module (default: zork1)
  --new-game           Start fresh, ignoring existing save
  --help, -h           Show help

Output: plain text to stdout
Exit codes: 0 = success, 1 = error
```

## Companion Authoring Status

`llm.lua` currently accepts parser actions only. It does not yet load an
adventure's companion module or implement `--choices` and `--choose`.

For manual card play, use:

```bash
lua5.4 main.lua --companion <game-module>
```

For automated companion validation, a focused Lua test must currently load the
game and companion, call `COMPANION_QUERY` and `COMPANION_SELECT`, and resume the
game with the selected hidden command. The test must restore an independent
matching-state checkpoint for every candidate.

The proposed persistent authoring interface is not implemented yet.

Until that interface exists, do not document those operations as working CLI
commands. See
[`docs/GENERATING-COMPANION-ZIL.md`](docs/GENERATING-COMPANION-ZIL.md) for the
complete room/state-family coverage and validation requirements.

## Evaluating Playability

### Authoring binary reader actions

The reader uses current VM scope, including carried contents, to resolve a
prose link. A remembered noun alone never grants remote manipulation. Topics
must resolve through the story's current globals or actual accessible objects.
Several prose aliases for the same object produce one secondary action.

An object can constrain its binary menu with an ordinary string property:

```zil
(INTERACTIONS "STEAM:KETTLE,SPOON;SHOW:MICA,CLOUD")
```

Keys are action identifiers, the suffix of the real `V-...` action (`PUT-ON`
differs from `PUT`). Values are declared object names. Missing actions in an
authored property have no binary menu entries; an empty string allows unary
actions only. Actors list the carried exhibits they accept for reversed
SHOW/GIVE menus. These relations filter offered pairs without executing an
action, changing world state, bypassing parser scope, or exposing hidden nouns.
Include meaningful failed experiments as well as correct pairs. Ordinary
parser commands still use the story's own action routines and rejection logic.

Books using the link reader finish with the score/progress record and a native
QUIT signal; the reader does not display unsupported parser restart prompts.
The persisted debug snapshot remains terminal across fresh invocations.

To assess whether an LLM can play and beat a game:

1. Start a new game
2. Give the LLM the game output and ask it to choose actions
3. Feed each action back via `llm.lua`
4. Track: rooms visited, items collected, puzzles solved, deaths
5. A game is "playable" if the LLM can make meaningful progress without getting stuck in loops

Example evaluation script:

```bash
SAVE="/tmp/eval.sav"
lua5.4 llm.lua --new-game --save "$SAVE" > eval.log

for turn in $(seq 1 50); do
  # In practice, an LLM would decide the action here
  ACTION="look"
  lua5.4 llm.lua --action "$ACTION" --save "$SAVE" >> eval.log
  EXIT_CODE=$?

  # Check for game end conditions or errors
  if [ $EXIT_CODE -ne 0 ]; then
    break
  fi
done
```
