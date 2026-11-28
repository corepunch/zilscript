#!/usr/bin/env python3
"""Open every catalog edition through the public reader, then resume its save."""
import json
import os
from pathlib import Path
import subprocess
import tempfile

LUA = os.environ.get("LUA", "lua5.4")
BOOKS = Path(__file__).resolve().parents[1] / "books"
ROOT = BOOKS.parent


def invoke(edition, save, *args):
    return subprocess.run(
        [LUA, "llm.lua", "--links", "--language", edition.parent.name,
         "--game", edition.name, "--save", str(save), *args],
        cwd=ROOT, text=True, encoding="utf-8", capture_output=True, timeout=20,
    )


def response(result):
    assert result.returncode == 0, result.stderr
    data = json.loads(result.stdout)
    assert data["room"] and data["running"], data
    commands = [action[1] for action in data["actions"]]
    assert commands and len(set(commands)) == len(commands), data
    return data


def check(edition, directory):
    save = directory / "game.sav"
    transcript = directory / "game.sav.transcript"
    opening = response(invoke(edition, save, "--new-game", "--seed", "97"))
    assert opening["output"].strip(), opening
    assert any(action[2] for action in opening["actions"]), opening
    original = (save.read_bytes(), transcript.read_bytes())

    observed = response(invoke(edition, save))
    assert observed["room"] == opening["room"], observed
    assert observed["actions"] == opening["actions"], observed
    assert (save.read_bytes(), transcript.read_bytes()) == original

    invalid = invoke(edition, save, "--choose", "999999")
    assert invalid.returncode != 0, invalid.stdout + invalid.stderr
    assert "Choose a numbered action" in invalid.stdout + invalid.stderr
    assert (save.read_bytes(), transcript.read_bytes()) == original

    # LOOK is the reader’s first control; the command itself is localized.
    _, look, target = observed["actions"][0]
    assert not target, observed
    looked = response(invoke(edition, save, "--choose", "1"))
    assert looked["room"] == opening["room"] and looked["output"].strip(), looked
    assert ("\n> " + look + "\n").encode() in transcript.read_bytes()
    assert response(invoke(edition, save))["actions"] == looked["actions"]


def check_german_ending(directory):
    edition = BOOKS / "de" / "borrowed-tomorrows"
    save = directory / "ending.sav"
    state = response(invoke(edition, save, "--new-game", "--seed", "97"))
    route = (
        "oeffn leihschrank", "nimm morgenblatt", "ost", "inventar",
        "leg morgenblatt in faltbrett", "nord", "inventar",
        "leg morgenblatt in leserahmen", "lies leserahmen",
    )
    for command in route[:-1]:
        commands = [action[1] for action in state["actions"]]
        state = response(invoke(edition, save, "--choose", str(commands.index(command) + 1)))
    commands = [action[1] for action in state["actions"]]
    ending = invoke(edition, save, "--choose", str(commands.index(route[-1]) + 1))
    assert ending.returncode == 0, ending.stderr
    state = json.loads(ending.stdout)
    assert "ENDE – PLATZ FÜR JEDEN NAMEN" in state["output"], state
    assert "NEUBEGINN" not in state["output"], state
    assert state["running"] is False and state["actions"] == [], state

    saved = save.read_bytes()
    resumed = invoke(edition, save)
    assert resumed.returncode == 0, resumed.stderr
    state = json.loads(resumed.stdout)
    assert state["running"] is False and state["actions"] == [], state
    assert save.read_bytes() == saved


if __name__ == "__main__":
    catalog = sorted(path.parent for path in BOOKS.glob("*/*/game.json"))
    assert catalog, "No adventure editions found"
    for edition in catalog:
        with tempfile.TemporaryDirectory(prefix="zil-book-") as temporary:
            try:
                check(edition, Path(temporary))
            except (AssertionError, ValueError) as exc:
                raise AssertionError(str(edition.relative_to(BOOKS))) from exc
        print(edition.relative_to(BOOKS), "persisted reader opening, invalid choice and LOOK passed")
    with tempfile.TemporaryDirectory(prefix="zil-book-ending-") as temporary:
        check_german_ending(Path(temporary))
    print(f"{len(catalog)} catalog editions and German reader ending passed")
