"""Author verification: resolve emitted commands, advance only by numeric choice.

Run from zilscript/. This reads the published author parser route; it is not
blind play. Each CLI step restores a real saved VM. No source-state mutation or
typed parser command advances the story. The resulting fixed indices can be
replayed independently by test_numeric_links.lua.
"""
import json
import os
from pathlib import Path
import re
import subprocess
import tempfile

root = Path("books/silent-vector/test")
interpreter = os.environ.get("LUA", "lua5.4")
with tempfile.TemporaryDirectory(prefix="silent-vector-numeric-") as temporary:
    save = Path(temporary) / "play.sav"
    base = [interpreter, "llm.lua", "--game", "silent-vector", "--save", str(save)]

    def run(arguments):
        process = subprocess.run(base + arguments, text=True, capture_output=True, check=True)
        result = json.loads(process.stdout)
        assert result.get("ok", True), result
        return result

    def normalized(command):
        command = command.lower()
        names = {
            "habitat breaker": "breaker", "torque wrench": "wrench", "null spool": "spool",
            "protocol card": "protocol", "coolant pump": "pump", "witness recorder": "recorder",
            "witness strip": "strip", "mass ledger": "ledger", "ceramic shears": "shears",
            "clinical log": "log", "optical comparator": "comparator", "incoming bus": "bus",
            "signal receiver": "receiver", "memory wafer": "wafer", "cold archive": "archive",
            "decision console": "console", "mechanical beacon": "beacon", "rendezvous beacon": "beacon",
            "droplet portrait": "portrait", "operator ivo": "ivo", "researcher senn": "senn",
            "doctor mara": "mara", "ivo chen": "ivo", "senn orlov": "senn", "mara vale": "mara",
            "received signal": "signal", "physical crew": "crew", "missing daughter": "daughter",
        }
        for original, short in names.items():
            command = command.replace(original, short)
        command = re.sub(r"^tell ", "ask ", command)
        if command == "compare comparator with strip":
            command = "compare strip with comparator"
        if command == "fit bus to spool":
            command = "fit spool to bus"
        return command

    state = run(["--new-game", "--links", "--seed", "97"])
    route = json.loads((root / "parser-route.json").read_text()) + ["preserve console"]
    route.insert(route.index("ask senn about signal"), "examine senn")
    selected = []
    max_actions = len(state["actions"])
    for expected in route:
        def candidates():
            return [(index, action) for index, action in enumerate(state["actions"], 1)
                    if normalized(action[1]) == expected]
        matches = candidates()
        if not matches:
            inventory = next(index for index, action in enumerate(state["actions"], 1) if action[1] == "inventory")
            selected.append([inventory, "inventory", "inventory"])
            state = run(["--choose", str(inventory)])
            max_actions = max(max_actions, len(state["actions"]))
            matches = candidates()
        assert matches, (expected, state)
        index, action = matches[0]
        selected.append([index, expected, action[1]])
        state = run(["--choose", str(index)])
        max_actions = max(max_actions, len(state["actions"]))
        print(len(selected), index, action[1], "=>", state["room"], flush=True)
    assert "ENDING: THE UNPLAYED WITNESS" in state["output"], state
    assert state["running"] is False and state["actions"] == [], state
    terminal = run(["--links"])
    assert terminal["running"] is False and terminal["actions"] == [], terminal
    (root / "numeric-route.json").write_text(json.dumps(selected, indent=2) + "\n")
    (root / "numeric-choices.lua").write_text("return { " + ", ".join(str(row[0]) for row in selected) + " }\n")
    (root / "numeric-ending.txt").write_text(state["output"])
    (root / "numeric-transcript.txt").write_text(Path(str(save) + ".transcript").read_text())
    (root / "numeric-route.md").write_text(
        "# Author source-informed numbered route, with authored interaction metadata\n\n"
        "Fresh CLI game, seed 97. Author verification, not independent blind evidence. "
        "Every step selects an actually emitted numeric choice across a saved process boundary. "
        "No typed parser command or source-state mutation advances the story. "
        "Run regenerate-numeric.py after any shared-menu change.\n\n"
        + ", ".join(str(row[0]) for row in selected) + "\n\n"
        + f"{len(selected)} numeric choices; largest menu {max_actions} actions. "
        "Terminal THE UNPLAYED WITNESS, running=false, actions=[]. Actual commands and indices: "
        "numeric-route.json. Prose: numeric-transcript.txt. Fixed replay: test_numeric_links.lua.\n")
    print(f"Verified {len(selected)} numeric choices, maximum menu {max_actions}, persistent terminal ending")
