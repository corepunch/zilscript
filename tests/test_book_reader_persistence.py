#!/usr/bin/env python3
"""Start every catalog edition and resume its checkpoint in a new process."""
import os
from pathlib import Path
import subprocess
import tempfile


LUA = os.environ.get("LUA", "lua5.4")
BOOKS = Path(__file__).resolve().parents[1] / "books"
ROOT = BOOKS.parent
LOOK = {"en": "look", "de": "schau", "ru": "осмотреться"}


def invoke(edition, save, *args):
    result = subprocess.run(
        [LUA, "llm.lua", "--language", edition.parent.name, "--game", edition.name,
         "--save", str(save), *args],
        cwd=ROOT, text=True, encoding="utf-8", capture_output=True, timeout=20,
    )
    assert result.returncode == 0 and result.stdout.strip(), result.stderr
    return result.stdout


def check(edition, directory):
    save = directory / "game.sav"
    history = directory / "game.sav.actions"
    invoke(edition, save, "--new-game")
    assert save.stat().st_size > 0
    command = LOOK[edition.parent.name]
    invoke(edition, save, "--action", command)
    assert command in history.read_text(encoding="utf-8")


def check_german_ending(directory):
    edition = BOOKS / "de" / "borrowed-tomorrows"
    save = directory / "ending.sav"
    invoke(edition, save, "--new-game")
    route = (
        "oeffn leihschrank", "nimm morgenblatt", "ost", "inventar",
        "leg morgenblatt in faltbrett", "nord", "inventar",
        "leg morgenblatt in leserahmen", "lies leserahmen",
    )
    for command in route[:-1]:
        invoke(edition, save, "--action", command)
    ending = invoke(edition, save, "--action", route[-1])
    assert "ENDE – PLATZ FÜR JEDEN NAMEN" in ending, ending
    resumed = invoke(edition, save, "--action", "schau")
    assert "The story has ended" in resumed, resumed


if __name__ == "__main__":
    catalog = sorted(path.parent for path in BOOKS.glob("*/*/game.json"))
    assert catalog, "No adventure editions found"
    for edition in catalog:
        with tempfile.TemporaryDirectory(prefix="zil-book-") as temporary:
            try:
                check(edition, Path(temporary))
            except AssertionError as exc:
                raise AssertionError(str(edition.relative_to(BOOKS))) from exc
        print(edition.relative_to(BOOKS), "checkpoint and LOOK passed")
    with tempfile.TemporaryDirectory(prefix="zil-book-ending-") as temporary:
        check_german_ending(Path(temporary))
    print(f"{len(catalog)} catalog editions and German ending passed")
