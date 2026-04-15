# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Personal dotfiles for a macOS development environment. Configuration files are symlinked from `~/dotfiles` to `$HOME` via `makesymlinks.sh`.

## Symlink Installation

```bash
./makesymlinks.sh   # backs up existing dotfiles to ~/dotfiles_old, then symlinks
```

The script links: `bashrc`, `vimrc`, `vim`, `zshrc`. After editing config files here, changes take effect immediately for vim/tmux (after reload), but zsh requires `exec zsh` or a new shell.

## Key Reload Commands

- **zsh**: `zpr` (alias for `exec zsh`), or edit with `zp` (alias for `vim ~/.zshrc`)
- **tmux**: `prefix + C-r` reloads `~/.tmux.conf`
- **vim**: `<Space>so` sources vimrc, `<Space>vi` opens it in a tab

## Repository Structure

- `zsh/zshrc` — Shell config, structured in numbered sections (environment, history, aliases, plugins, lazy-loads, tooling, PATH, init). Uses zplug for plugin management and Pure prompt theme.
- `vim/vimrc` — Vim config with vim-plug. Leader is `<Space>`. CoC provides LSP (tsserver, eslint, prettier, yaml). Plugins are lazy-loaded by filetype.
- `tmux.conf` — tmux config using default prefix (`C-b`). Vi copy mode, vim-tmux-navigator for seamless C-h/j/k/l pane/split navigation, TPM for plugins (resurrect, continuum, logging).
- `git/gitconfig` — Git aliases and settings. Push default is `upstream` with `autoSetupRemote`.
- `Brewfile` — Homebrew packages and casks managed via `brew bundle`.
- `zsh/zsh-functions.zsh` — Custom shell functions (e.g. `kubectx_prompt` for K8s context in RPROMPT).
- `zsh/omz-git.zsh` — Oh My Zsh git aliases/functions sourced standalone (not full OMZ).

## Architecture Notes

- **Performance-sensitive zshrc**: NVM is lazy-loaded (only initialised on first use of `nvm`/`node`/`npm`/`npx`/`pnpm`). Google Cloud SDK is behind a manual `load-gcloud` alias. Avoid adding eager loads to zshrc.
- **PATH deduplication**: `typeset -U path` ensures no duplicates. Custom paths are set at the bottom of zshrc with explicit priority ordering.
- **Vim-tmux integration**: `christoomey/vim-tmux-navigator` in vim + corresponding `is_vim` bindings in tmux.conf enable seamless C-h/j/k/l navigation across vim splits and tmux panes. These must stay in sync.
- **pip is blocked**: Aliased to print a warning and suggest `uv` instead, to prevent accidental global pip installs.
- **Brewfile**: `brewup` alias runs `brew update && brew upgrade && brew cleanup`. The `java` cask is being migrated to SDKMAN (see memory).
