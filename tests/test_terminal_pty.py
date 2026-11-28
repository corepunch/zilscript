#!/usr/bin/env python3
"""Exercise the real CLI with a pseudo-TTY, not the numbered pipe fallback."""
import os
import pty
import select
import subprocess
import sys
import termios
import time

LUA = os.environ.get("LUA", "lua5.4")
PROMPT = b"\x1b[2K> "


def read_until(fd, pending, needle, timeout=8):
    deadline = time.monotonic() + timeout
    while time.monotonic() < deadline:
        index = pending.find(needle)
        if index >= 0:
            del pending[:index + len(needle)]
            return
        if select.select([fd], [], [], 0.1)[0]:
            pending.extend(os.read(fd, 65536))
    raise AssertionError(f"Expected {needle!r}; last terminal output: {pending[-1000:]!r}")


def test_terminal():
    master, slave = pty.openpty()
    original = termios.tcgetattr(slave)
    process = subprocess.Popen(
        [LUA, "main.lua", "books.en.wondertown.wondertown"],
        stdin=slave, stdout=slave, stderr=slave,
    )
    pending = bytearray()
    try:
        read_until(master, pending, "Use \u2191 or \u2193".encode())
        read_until(master, pending, PROMPT)
        time.sleep(0.5)  # Longer than the old one-tenth-second EOF.
        assert process.poll() is None, "The choice widget treated typing delay as EOF"
        os.write(master, b"\x1b[B")
        read_until(master, pending, PROMPT + b"examine workbench")
        os.write(master, b"\r")
        read_until(master, pending, PROMPT)
        os.write(master, "üö".encode())
        read_until(master, pending, PROMPT + "üö".encode())
        os.write(master, b"\x7f")
        read_until(master, pending, PROMPT + "ü".encode())
        os.write(master, b"\x03")
        assert process.wait(timeout=8) == 0
        restored = termios.tcgetattr(slave)
        if sys.platform == "darwin":
            # Darwin sets PENDIN when ICANON is restored, even when a caller
            # restores the exact saved termios via tcsetattr. It is a kernel
            # pending-input flag, not a persistent terminal setting.
            restored[3] &= ~termios.PENDIN
            original[3] &= ~termios.PENDIN
        assert restored == original, "Terminal settings were not restored"
    finally:
        if process.poll() is None:
            process.kill()
            process.wait()
        os.close(master)
        os.close(slave)


if __name__ == "__main__":
    test_terminal()
    print("Companion terminal: idle, arrow selection, UTF-8 editing and restoration passed")
