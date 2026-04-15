# Dotfiles

My configuration files for my development environment; a continual work in progress.

## Setup

```bash
git clone git@github.com:robert-g-j/dotfiles.git ~/dotfiles
cd ~/dotfiles
./bootstrap.sh
```

`bootstrap.sh` is idempotent — safe to re-run at any time.

## Structure

Config directories use [GNU Stow](https://www.gnu.org/software/stow/) to symlink into `$HOME`:

| Package | What it configures |
|---------|--------------------|
| `zsh/`  | Zsh shell (Pure prompt, aliases, lazy-loaded NVM, k8s helpers) |
| `vim/`  | Vim with vim-plug and CoC LSP |
| `nvim/` | Neovim (currently sources vimrc) |
| `tmux/` | tmux with TPM (resurrect, continuum, logging) |
| `git/`  | Git config, global gitignore, commit template |

## Zsh Plugins

Managed manually (no plugin manager). Cloned by `bootstrap.sh`, sourced directly:

- [pure](https://github.com/sindresorhus/pure) — prompt theme
- [zsh-async](https://github.com/mafredri/zsh-async) — async library for pure
- [zsh-completions](https://github.com/zsh-users/zsh-completions) — extra completions
- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) — fish-style suggestions
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) — command highlighting

Update all plugins: `update-plugins`

## Vim

Plugin manager is [vim-plug](https://github.com/junegunn/vim-plug) (auto-installs on first launch).
Key mappings use `<Space>` as leader, influenced by Chris Toomey of Thoughtbot/Upcase.
