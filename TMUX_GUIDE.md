# Tmux User Guide

This is a quick reference for the custom tmux configuration in `tmux.conf`. The **prefix key** is the default `Ctrl-b` (shown below as `prefix`).

## Dependencies

Install these for full functionality:

```sh
brew install lazygit tree
```

## Keybinding Reference

### Splitting & Creating Windows

| Keys | Action |
|------|--------|
| `prefix` `-` | Split pane top/bottom |
| `prefix` `\` | Split pane left/right |
| `prefix` `c` | New window (inherits current directory) |

### Moving Between Panes

These work **without the prefix** and integrate with Vim splits seamlessly — the same keys navigate both tmux panes and Vim splits.

| Keys | Action |
|------|--------|
| `Ctrl-h` | Move left |
| `Ctrl-j` | Move down |
| `Ctrl-k` | Move up |
| `Ctrl-l` | Move right |
| `Ctrl-\` | Move to last pane |
| `prefix` `q` | Show pane numbers (press a number to jump to it) |

### Resizing Panes

These work **without the prefix**.

| Keys | Action |
|------|--------|
| `Shift-Left/Right` | Fine resize (2 cells) |
| `Shift-Up/Down` | Fine resize (1 cell) |
| `Ctrl-Left/Right` | Coarse resize (10 cells) |
| `Ctrl-Up/Down` | Coarse resize (5 cells) |

You can also click and drag pane borders with the mouse.

### Pane & Window Management

| Keys | Action |
|------|--------|
| `prefix` `b` | Send current pane to a background window |
| `prefix` `J` | Pull a pane from another window into this one (prompts for source) |
| `prefix` `!` | Kill current session and switch to another |

### Sessions

| Keys | Action |
|------|--------|
| `prefix` `Space` | Toggle between last two sessions |
| `prefix` `Ctrl-j` | Fuzzy-search all sessions with fzf |

### Tools

| Keys | Action | Requires |
|------|--------|----------|
| `prefix` `g` | Open lazygit in a side split | `lazygit` |
| `prefix` `t` | Show directory tree (3 levels) in a side split | `tree` |
| `prefix` `Ctrl-d` | Open `~/dotfiles/` in Vim with fzf file picker | `vim` + fzf plugin |

### Copy Mode (Vim-style)

Enter copy mode with `prefix` `[`, then:

| Keys | Action |
|------|--------|
| `h/j/k/l` | Navigate (like Vim) |
| `v` | Start visual selection |
| `y` or `Enter` | Copy selection to system clipboard and exit |
| `Space` | Repeat last jump (f/F/t/T) |
| `0` | Jump to first non-whitespace character |
| `q` | Exit copy mode |

Outside of copy mode:

| Keys | Action |
|------|--------|
| `prefix` `y` | Copy tmux buffer to system clipboard |
| `prefix` `Ctrl-y` | Same as above |

### Session Persistence (tmux-resurrect + tmux-continuum)

| Keys | Action |
|------|--------|
| `prefix` `S` | Save session state (windows, panes, layouts) |
| `prefix` `R` | Restore last saved session state |

Sessions are also **saved automatically every 15 minutes** and **restored automatically when tmux starts**. Survives terminal crashes and reboots.

### Logging (tmux-logging)

| Keys | Action |
|------|--------|
| `prefix` `Shift-p` | Toggle logging current pane to a file |
| `prefix` `Alt-p` | Save visible pane contents to a file |
| `prefix` `Alt-Shift-p` | Export full pane history to a file |
| `prefix` `Alt-c` | Clear pane history |

Logs are saved to `~/` as `tmux-{session}-{window}-{pane}-{timestamp}.log`.

### Config & Maintenance

| Keys | Action |
|------|--------|
| `prefix` `Ctrl-r` | Reload tmux.conf |
| `prefix` `Ctrl-l` | Clear/redraw terminal (since bare Ctrl-l is used for navigation) |
| `prefix` `I` | Install new plugins (after adding to tmux.conf) |
| `prefix` `U` | Update installed plugins |

## Notable Behaviours

- **Mouse enabled** — click to select panes, scroll to browse history, drag borders to resize.
- **Windows start at 1** not 0, and re-number automatically when one is closed.
- **Killing a session** switches to another session instead of detaching you from tmux.
- **50,000 lines** of scrollback history per pane.
- **Clipboard** works natively via OSC 52 — no `reattach-to-user-namespace` needed.
- **Sessions auto-save** every 15 minutes and auto-restore on tmux start.

## Common Workflows

### Split your workspace for coding

```
prefix \     (side-by-side split: code left, terminal right)
prefix -     (top/bottom split: code top, tests bottom)
```

### Quick git operations

```
prefix g     (opens lazygit — stage, commit, push, rebase interactively)
```

### Browse project structure

```
prefix t     (shows a colour tree of the current directory)
```

### Copy text from terminal output

```
prefix [     (enter copy mode)
              navigate to text with h/j/k/l
v            (start selecting)
y            (copy to clipboard, exits copy mode)
```

Then paste normally with `Cmd-v`.

### Save Claude's output for later

```
prefix Alt-Shift-p   (exports the full pane history to a log file in ~/)
```

Or toggle continuous logging before a long Claude session:

```
prefix Shift-p       (toggle — all output is captured until you toggle off)
```
