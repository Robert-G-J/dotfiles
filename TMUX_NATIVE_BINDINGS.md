# Native Tmux Keybindings

A comprehensive reference for the standard tmux keybindings that come built-in. If you accidentally press something and wonder what happened, check here.

The **prefix key** is `Ctrl-b`. Press it first, release, then press the second key.

## Sessions

| Keys | Action | Notes |
|------|--------|-------|
| `prefix` `d` | **Detach** from tmux (session keeps running in background) | Re-attach with `tmux attach` |
| `prefix` `s` | List all sessions and pick one to switch to | Interactive tree view |
| `prefix` `$` | Rename the current session | |
| `prefix` `(` | Switch to previous session | |
| `prefix` `)` | Switch to next session | |
| `prefix` `L` | Switch to last session | |

## Windows (tabs along the bottom)

| Keys | Action | Notes |
|------|--------|-------|
| `prefix` `c` | Create a new window | |
| `prefix` `&` | Kill the current window (prompts for confirmation) | |
| `prefix` `,` | Rename the current window | |
| `prefix` `w` | List all windows across all sessions and pick one | Interactive tree view |
| `prefix` `n` | Next window | |
| `prefix` `p` | Previous window | |
| `prefix` `l` | Last (most recently used) window | |
| `prefix` `0-9` | Jump to window number 0-9 | |
| `prefix` `'` | Prompt for a window index to jump to | Useful for windows > 9 |
| `prefix` `.` | Move the current window to a new index number | |
| `prefix` `f` | Search for a window by name | |

## Panes

| Keys | Action | Notes |
|------|--------|-------|
| `prefix` `"` | Split horizontally (top/bottom) | |
| `prefix` `%` | Split vertically (side by side) | |
| `prefix` `x` | Kill the current pane (prompts for confirmation) | |
| `prefix` `z` | **Zoom** — toggle current pane to fill the whole window | Press again to un-zoom |
| `prefix` `q` | Show pane numbers, press a number to jump to that pane | |
| `prefix` `o` | Cycle to the next pane | |
| `prefix` `;` | Jump to the last active pane | |
| `prefix` `{` | Swap current pane with the previous one | Moves the pane itself |
| `prefix` `}` | Swap current pane with the next one | Moves the pane itself |
| `prefix` `!` | Break pane into its own window | |
| `prefix` `Arrow keys` | Move to the pane in that direction | |

## Layouts

| Keys | Action |
|------|--------|
| `prefix` `Space` | Cycle through preset layouts |
| `prefix` `Alt-1` | Even horizontal layout (all panes side by side) |
| `prefix` `Alt-2` | Even vertical layout (all panes stacked) |
| `prefix` `Alt-3` | Main pane on left, others stacked on right |
| `prefix` `Alt-4` | Main pane on top, others side by side below |
| `prefix` `Alt-5` | Tiled layout (equal sized grid) |

## Copy Mode & Scrollback

| Keys | Action | Notes |
|------|--------|-------|
| `prefix` `[` | Enter copy mode (scroll through history) | |
| `prefix` `]` | Paste from the tmux buffer | |
| `prefix` `#` | List all paste buffers | |
| `prefix` `=` | Choose a paste buffer from the list | |
| `prefix` `PgUp` | Enter copy mode and scroll up one page | |

## Miscellaneous

| Keys | Action | Notes |
|------|--------|-------|
| `prefix` `?` | **List all keybindings** | The ultimate cheat sheet — press `q` to exit |
| `prefix` `:` | Open the tmux command prompt | Run any tmux command manually |
| `prefix` `~` | Show tmux messages log | |
| `prefix` `i` | Display info about the current window | |
| `prefix` `t` | Show a clock in the current pane | |

## "I pressed something and now..."

| What happened | You probably pressed | How to fix it |
|---------------|---------------------|---------------|
| Dropped back to the shell, tmux seems gone | `prefix d` (detach) | Run `tmux attach` to get back |
| Pane took over the whole screen | `prefix z` (zoom) | Press `prefix z` again to un-zoom |
| Stuck in a yellow/highlighted scroll view | `prefix [` (copy mode) | Press `q` to exit |
| A prompt appeared at the bottom | `prefix :` (command mode) | Press `Escape` to cancel |
| Pane numbers flashed on screen | `prefix q` (display panes) | Just wait — they disappear after 2s |
| Window changed unexpectedly | `prefix n/p/l` (window navigation) | Press `prefix` + the window number to go back |
| Two panes swapped positions | `prefix {` or `}` (swap pane) | Press the opposite one to swap back |
| All panes show the same output | `prefix :setw synchronize-panes` | Run the same command again to toggle off |
| A pane closed | `prefix x` (kill pane) — you confirmed with `y` | Gone — start a new one |

## Overrides in Custom Config

The following native bindings are overridden in `tmux.conf`. See [TMUX_GUIDE.md](TMUX_GUIDE.md) for their replacements.

| Native binding | Default action | Custom action |
|----------------|---------------|---------------|
| `prefix` `"` | Split top/bottom | Replaced by `prefix -` |
| `prefix` `%` | Split left/right | Replaced by `prefix \` |
| `prefix` `Space` | Cycle layouts | Toggles between last two sessions |
| `prefix` `!` | Break pane to window | Kills current session and switches |
| `prefix` `t` | Show clock | Shows directory tree |
| `prefix` `Arrow keys` | Move between panes | Replaced by `Ctrl-h/j/k/l` (vim-tmux navigator) |

## Terminal Commands

| Command | Action |
|---------|--------|
| `tmux` | Start a new session |
| `tmux new -s name` | Start a new named session |
| `tmux attach` or `tmux a` | Re-attach to the last session |
| `tmux attach -t name` | Attach to a specific session |
| `tmux ls` | List all sessions |
| `tmux kill-session -t name` | Kill a specific session |
| `tmux kill-server` | Kill tmux and all sessions |
