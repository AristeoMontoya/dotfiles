#!/usr/bin/env python3
import os
import re
import subprocess
import sys
import time
from pathlib import Path

LAYOUT_DIR = Path.home() / ".config/zellij/layouts"
ANSI_RESET  = "\033[0m"
ANSI_BLUE   = "\033[1;34m"
ANSI_RED    = "\033[31m"
ANSI_ESC    = re.compile(r'\x1b\[[0-9;]*m')

def strip_ansi(s):
    return ANSI_ESC.sub('', s)

def zellij(*args):
    return subprocess.run(["zellij", *args], capture_output=True, text=True)

def fzf(options, **kwargs):
    args = ["fzf", "--ansi"]
    for k, v in kwargs.items():
        k_flag = f"--{k.replace('_', '-')}"
        args += [k_flag] if v is None else [k_flag, v]
    result = subprocess.run(args, input="\n".join(options), capture_output=True, text=True)
    return result.stdout.strip() if result.returncode == 0 else ""

def get_sessions():
    r = zellij("list-sessions", "-s", "-n")
    return sorted(r.stdout.splitlines()) if r.returncode == 0 else []

def get_layouts(session_set):
    if not LAYOUT_DIR.exists():
        return []
    layouts = []
    for f in LAYOUT_DIR.rglob("*"):
        if f.is_file() and f.name != ".gitkeep":
            rel = f.relative_to(LAYOUT_DIR)
            if f.stem not in session_set:
                layouts.append(str(rel))
    return sorted(layouts)

def kill_mode():
    sessions = get_sessions()
    if not sessions:
        sys.exit(0)

    options = [f"{ANSI_BLUE}*{s}{ANSI_RESET}" for s in sessions]
    chosen = fzf(options, multi=None, header="Select sessions to kill (TAB to select, ENTER to confirm)")
    if not chosen:
        sys.exit(0)

    kill_list = [strip_ansi(s).lstrip("*") for s in chosen.splitlines() if s.strip()]

    # Killing the currently attached session takes the client down with it,
    # so hop to a survivor first if one exists.
    current = os.environ.get("ZELLIJ_SESSION_NAME")
    remaining = [s for s in sessions if s not in kill_list]
    if current in kill_list and remaining:
        zellij("action", "switch-session", remaining[0])

    for s in kill_list:
        zellij("kill-session", s)
        # The server tears sessions down asynchronously (serializing a
        # resurrection snapshot as it goes), so a single delete-session
        # call can run before that finishes, or get raced by a snapshot
        # write that lands right after - poll until it's actually gone.
        for _ in range(15):
            zellij("delete-session", s)
            time.sleep(0.3)
            if s not in get_sessions():
                break

def main():
    sessions = get_sessions()
    session_set = set(sessions)
    layouts = get_layouts(session_set)

    script_path = os.path.abspath(__file__)

    menu = (
        [f"{ANSI_BLUE}*{s}{ANSI_RESET}" for s in sessions]
        + layouts
        + [f"{ANSI_RED}Kill Session{ANSI_RESET}"]
    )

    chosen = fzf(
        menu,
        header="Pick a session or 'Kill Session'",
        bind=f"enter:transform:echo {{}} | sed 's/\\x1b\\[[0-9;]*m//g' | grep -q '^Kill Session$' && echo 'become(python3 {script_path} --kill)' || echo 'accept'"
    )

    if not chosen:
        sys.exit(0)

    clean = strip_ansi(chosen)
    if clean == "Kill Session":
        os.execv(sys.executable, [sys.executable, script_path, "--kill"])

    if clean.startswith("*"):
        os.execvp("zellij", ["zellij", "action", "switch-session", clean[1:]])

    layout_path = LAYOUT_DIR / clean

    # Executable, extension-less entries (eg. project_picker) build their own
    # layout dynamically and handle session creation/switching themselves.
    if os.access(layout_path, os.X_OK):
        os.execv(str(layout_path), [str(layout_path)])

    session_name = layout_path.stem
    os.execvp("zellij", ["zellij", "action", "switch-session", session_name, "--layout", str(layout_path)])

if __name__ == "__main__":
    if "--kill" in sys.argv:
        kill_mode()
    else:
        main()
