#!/usr/bin/env python3
"""Start every catalog book and resume its checkpoint in a new process."""
import os
from pathlib import Path
import subprocess
import tempfile


LUA = os.environ.get("LUA", "lua5.4")
BOOKS = Path(__file__).resolve().parents[1] / "books"
ROOT = BOOKS.parent

def invoke(book, save, *args):
    result = subprocess.run(
        [LUA, "llm.lua", "--game", book.name,
         "--save", str(save), *args],
        cwd=ROOT, text=True, encoding="utf-8", capture_output=True, timeout=20,
    )
    assert result.returncode == 0 and result.stdout.strip(), result.stderr
    return result.stdout


def check(book, directory):
    save = directory / "game.sav"
    history = directory / "game.sav.actions"
    invoke(book, save, "--new-game")
    assert save.stat().st_size > 0
    command = "look"
    invoke(book, save, "--action", command)
    assert command in history.read_text(encoding="utf-8")


def check_ending(directory):
    book = BOOKS / "borrowed-tomorrows"
    save = directory / "ending.sav"
    invoke(book, save, "--new-game")
    route = (
        "open lending cabinet", "take tomorrow leaf", "east",
        "put tomorrow leaf in folding board", "north",
        "put tomorrow leaf in reading frame", "read reading frame",
    )
    for command in route[:-1]:
        invoke(book, save, "--action", command)
    ending = invoke(book, save, "--action", route[-1])
    assert "answer comes from every side of the square" in ending, ending
    resumed = invoke(book, save, "--action", "look")
    assert "The story has ended" in resumed, resumed


if __name__ == "__main__":
    catalog = sorted(path.parent for path in BOOKS.glob("*/game.json"))
    assert catalog, "No adventure books found"
    for book in catalog:
        with tempfile.TemporaryDirectory(prefix="zil-book-") as temporary:
            try:
                check(book, Path(temporary))
            except AssertionError as exc:
                raise AssertionError(str(book.relative_to(BOOKS))) from exc
        print(book.relative_to(BOOKS), "checkpoint and LOOK passed")
    with tempfile.TemporaryDirectory(prefix="zil-book-ending-") as temporary:
        check_ending(Path(temporary))
    print(f"{len(catalog)} catalog books and a completed story passed")
