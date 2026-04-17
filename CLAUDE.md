# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Personal dotfiles for a macOS development environment. Supports both Intel and Apple Silicon Macs via runtime architecture detection. Config files are symlinked from `~/dotfiles` to `$HOME` using GNU Stow.

## Bootstrap

```bash
./bootstrap.sh   # idempotent — safe to re-run
```

Orchestrates: Xcode CLT → Homebrew → brew bundle → stow symlinks → TPM → zsh plugins → vim plugins → post-install checklist.

## Stow Structure

Each top-level directory is a stow "package" mirroring `$HOME`. Stow is invoked with `--dotfiles`: files named `dot-*` in the package are symlinked with a leading `.` in `$HOME` (e.g. `dot-zshrc` → `~/.zshrc`). Always pass `--dotfiles` to stow.

| Package | Key files (repo name → `$HOME` symlink) |
|---------|-----------|
| `zsh/`  | `dot-zshrc`, `dot-zsh/zsh-functions.zsh`, `dot-zsh/omz-git.zsh`, `dot-zsh/completion/` |
| `vim/`  | `dot-vimrc`, `dot-vim/coc-settings.json` |
| `nvim/` | `dot-config/nvim/init.vim` (sources vimrc — full Lua migration deferred) |
| `tmux/` | `dot-tmux.conf` |
| `git/`  | `dot-gitconfig`, `dot-gitignore_global`, `dot-gitmessage` |

Files at repo root (`Brewfile`, `bootstrap.sh`, docs) are not stow packages.

## Key Reload Commands

- **zsh**: `zpr` (alias for `exec zsh`), or edit with `zp` (alias for `vim ~/.zshrc`)
- **tmux**: `prefix + C-r` reloads `~/.tmux.conf`
- **vim**: `<Space>so` sources vimrc, `<Space>vi` opens it in a tab

## Architecture Notes

- **Multi-arch support**: `HOMEBREW_PREFIX` is set at the top of zshrc via `uname -m` detection. All Homebrew paths use this variable. Never hardcode `/usr/local` or `/opt/homebrew`.
- **Performance-sensitive zshrc**: NVM is lazy-loaded (only initialised on first use of `nvm`/`node`/`npm`/`npx`/`pnpm`). Google Cloud SDK is behind a manual `load-gcloud` alias. Avoid adding eager loads.
- **Conditional sourcing**: All external `source` commands are guarded with `[ -f ... ]` so the shell degrades gracefully on a fresh machine rather than breaking.
- **Zsh plugins**: Managed manually (no plugin manager). Cloned by `bootstrap.sh` into `~/.zsh/plugins/`, sourced directly. Update with `update-plugins` alias.
- **PATH deduplication**: `typeset -U path` ensures no duplicates. Custom paths are set at the bottom of zshrc with explicit priority ordering.
- **Vim-tmux integration**: `christoomey/vim-tmux-navigator` in vim + corresponding `is_vim` bindings in tmux.conf enable seamless C-h/j/k/l navigation across vim splits and tmux panes. These must stay in sync.
- **pip is blocked**: Aliased to print a warning and suggest `uv` instead, to prevent accidental global pip installs.
- **Secrets**: Not in repo. Template at `zsh/.zsh/env-vars.zsh.example`; real file lives at `~/env_var/env-vars.zsh`.
