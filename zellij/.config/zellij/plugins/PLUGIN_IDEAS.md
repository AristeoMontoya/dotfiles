# Custom plugin ideas

Notes from investigating custom zellij plugins to support the tmux migration
(nested-session passthrough) and general automation. Nothing here is
implemented yet.

## Background

Zellij plugins are WASM modules run by `wasmi` with **WASI preview1**
(confirmed in zellij's own source, `plugin_loader.rs`). The ABI is simple and
language-agnostic:

- A plugin exports 5 plain C-ABI functions: `load`, `update() -> bool`,
  `pipe() -> bool`, `render(rows, cols: i32)`, `plugin_version`.
- It imports exactly one host function: `host_run_plugin_command()` (no args).
- Communication is: write a JSON array of bytes (a Protobuf-encoded message)
  to stdout, call the host import, read the JSON-byte-array response from
  stdin. Fully synchronous, single-threaded.
- Real `.proto` schemas exist in zellij's repo
  (`zellij-utils/src/plugin_api/*.proto`), including the messages we need
  (`RebindKeysPayload`, `KeyToRebind`, `KeyToUnbind`, etc.), so message shapes
  don't need to be reverse-engineered.

Since this protocol has no Rust-specific machinery, it's implementable in
**Go**, via TinyGo (`-target=wasi`) or modern stock Go (`GOOS=wasip1`) — no
existing Go zellij plugin was found anywhere as prior art, so this would be a
first, with only the Rust source as reference. TinyGo's protobuf/reflection
support is a historical weak spot, so for a narrow plugin (a handful of
message types) hand-rolling the protobuf wire format directly is likely more
reliable than pulling in generated codegen.

Rust has the `zellij-tile` crate as a ready-made SDK with every API call
already typed and encoded — relevant for idea 3 below.

## Idea 1: Ctrl+a arms/disarms the Ctrl+b keymap

**Motivation**: keep the current Ctrl+b tmux-prefix design (`Ctrl+b p` →
pane menu, `Ctrl+b t` → tab menu, etc.) intact, but let Ctrl+a toggle whether
Ctrl+b is recognized as a keybind *at all* — independent of what mode we're
currently in. When disarmed, Ctrl+b passes straight through untouched (e.g.
to a nested remote session that wants it as its own prefix).

**Mechanism**: `rebind_keys(keys_to_unbind, keys_to_rebind, write_to_disk)`,
a plugin-only API (`PluginCommand::RebindKeys`). This is exactly how zellij's
own built-in "change leader key" feature works — reference implementation at
`default-plugins/configuration/src/rebind_leaders_screen.rs` in zellij's
source. It edits the live, in-memory per-client keybind table directly:

- `keys_to_unbind: Vec<(InputMode, Key)>` — removes a binding
- `keys_to_rebind: Vec<(InputMode, Key, Vec<Action>)>` — (re)inserts one

No mode switch involved — matches the mental model of "just remove/add the
keymap, nothing more."

**Plugin needs to**:
1. Run persistently in the background (`load_plugins`, same as zjstatus).
2. Keep an armed/disarmed boolean.
3. On a pipe message (triggered by Ctrl+a via `MessagePlugin` in the
   keybind), toggle the state and call `rebind_keys()`:
   - Disarm: unbind Ctrl+b from every mode it's bound in (locked, normal,
     pane, tab, resize, move, session — wherever the shared groups place it).
   - Arm: rebind Ctrl+b back to its original action in each of those modes.

**Permission required**: `Reconfigure` (one-time grant, same model as other
plugin permissions).

## Idea 2: Status bar at top when zellij runs on a remote (SSH'd-into) host

**Motivation**: mirrors `tmux/.config/tmux/tmux.remote.conf`
(`set -g status-position top`), loaded by tmux via
`if-shell 'test -n "$SSH_CLIENT"'` in `tmux.options.conf`. Zellij has no
env-conditional config primitive (`if-shell` has no equivalent), and no env
var for default-layout selection — confirmed nothing in the source.

**Mechanism**: two plugin calls, no shell wrapper needed at all:

- `get_session_environment_variables()` — reads the env the zellij *server*
  process was started in. Confirmed server-side this is captured once,
  `session_env_vars = std::env::vars().collect()`, at server startup
  (`zellij-server/src/lib.rs`) — the same "checked once, at the moment the
  session begins" semantics as tmux's `if-shell` check, so `$SSH_CLIENT` is
  read correctly regardless of how the plugin itself is invoked.
- `override_layout(layout_info, retain_existing_terminal_panes, ...)` — lets
  a plugin swap in a different layout at runtime, with
  `retain_existing_terminal_panes: true` so already-open panes survive; only
  the structural arrangement (status bar first/top vs last/bottom) changes.

**Plugin needs to**: on `load()`, check `SSH_CLIENT` (or `SSH_TTY`/
`SSH_CONNECTION`) via `get_session_environment_variables()`; if set, call
`override_layout()` pointing at a "remote" layout variant (zjstatus pane
listed first instead of last).

**Permission required**: `ReadSessionEnvironmentVariables` +
`ChangeApplicationState`.

## Idea 3: Generic JSON-driven API bridge plugin

**Motivation** (raised after 1 & 2): instead of a new purpose-built plugin
(and recompile) per automation idea, have *one* plugin that exposes a curated
set of `zellij-tile` API calls, driven by JSON sent through a pipe message —
e.g. `zellij action pipe -- '{"action":"rebind_keys","unbind":[...],"rebind":[...]}'`.
Shell scripts (or keybinds via `MessagePlugin`) could then drive any
already-exposed action without touching plugin code.

This would **subsume ideas 1 and 2** — both become "recipes" (small JSON
payloads) sent to the same bridge, rather than two separate plugins.

**Trade-off to weigh, language-wise**: this only pays off for actions that
are already wired into the dispatcher — adding support for a brand-new
`PluginCommand`/`Action` variant still means touching plugin code and
recompiling, but *calling* an already-exposed action with different
arguments doesn't.

- In **Rust**, this is cheap: `zellij-tile` already has every call typed and
  implemented, so the bridge is just a JSON → match-statement → existing
  function dispatch table. Broad API coverage is low-effort.
- In **Go/TinyGo**, each exposed action needs its protobuf message
  hand-encoded (no ready-made SDK, and full protobuf-go codegen is the
  TinyGo risk area noted above). Fine for a small curated set (the handful
  of calls idea 1/2 need: `RebindKeys`, `OverrideLayout`,
  `GetSessionEnvironmentVariables`, maybe `SwitchToMode` / a generic `Pipe`
  passthrough), more effort to keep growing over time than the Rust path.

**Permissions required**: union of whatever actions are exposed (so
`Reconfigure` + `ChangeApplicationState` + `ReadSessionEnvironmentVariables`
for the set above) — all one-time grants.

## Open decisions

- Go/TinyGo vs Rust for implementation (user doesn't know Rust; Go is
  confirmed technically viable but is uncharted territory for zellij
  plugins specifically, and idea 3's appeal — broad, low-effort API surface
  — is strongest in Rust).
- Whether to build ideas 1 & 2 as two small separate plugins, or go straight
  to idea 3's bridge and implement 1 & 2 as its first two recipes.
