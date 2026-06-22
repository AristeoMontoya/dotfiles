#!/usr/bin/env python3
import os
import re
import subprocess
import sys
from pathlib import Path

SESSION_DIR = Path.home() / ".config/tmux/session-scripts"
ANSI_RESET  = "\033[0m"
ANSI_BLUE   = "\033[1;34m"
ANSI_RED    = "\033[31m"
ANSI_YELLOW = "\033[33m"
ANSI_ESC    = re.compile(r'\x1b\[[0-9;]*m')

def strip_ansi(s):
    return ANSI_ESC.sub('', s)

def tmux(*args):
    return subprocess.run(["tmux", *args], capture_output=True, text=True)

def fzf(options, **kwargs):
    args = ["fzf", "--ansi"]
    for k, v in kwargs.items():
        k_flag = f"--{k.replace('_', '-')}"
        args += [k_flag] if v is None else [k_flag, v]
    result = subprocess.run(args, input="\n".join(options), capture_output=True, text=True)
    return result.stdout.strip() if result.returncode == 0 else ""

def get_tmux_sessions():
    r = tmux("list-sessions", "-F", "#S")
    return sorted(r.stdout.splitlines()) if r.returncode == 0 else []

def get_scripts(session_set):
    if not SESSION_DIR.exists():
        return []
    scripts = []
    for f in SESSION_DIR.rglob("*"):
        if f.is_file() and f.name != ".gitkeep":
            rel = f.relative_to(SESSION_DIR)
            if rel.name not in session_set:
                scripts.append(str(rel))
    return scripts

def kill_mode():
    sessions = get_tmux_sessions()
    if not sessions:
        sys.exit(0)

    options = [f"{ANSI_BLUE}*{s}{ANSI_RESET}" for s in sessions]
    chosen = fzf(options, multi=None, header="Select sessions to kill (TAB to select, ENTER to confirm)")
    if not chosen:
        sys.exit(0)

    kill_list = [strip_ansi(s).lstrip("*") for s in chosen.splitlines() if s.strip()]
    for s in kill_list:
        tmux("kill-session", "-t", s)

def main():
    sessions = get_tmux_sessions()
    session_set = set(sessions)
    scripts = get_scripts(session_set)

    script_path = os.path.abspath(__file__)

    menu = (
        [f"{ANSI_BLUE}*{s}{ANSI_RESET}" for s in sessions]
        + scripts
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

    session_name = Path(clean).name.replace("env/", "")
    script_file  = SESSION_DIR / clean

    if tmux("has-session", "-t", session_name).returncode != 0:
        if script_file.is_file():
            r = subprocess.run([str(script_file)], capture_output=True, text=True)
            session_name = r.stdout.strip()
        else:
            print(f"Can't find session script: '{script_file}'")
            sys.exit(1)

    if os.environ.get("TMUX"):
        tmux("switch", "-t", session_name)
    else:
        tmux("attach", "-t", session_name)

if __name__ == "__main__":
    if "--kill" in sys.argv:
        kill_mode()
    else:
        main()
