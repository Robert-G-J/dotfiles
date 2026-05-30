#!/usr/bin/env bash
set -euo pipefail

DOTFILES="$HOME/dotfiles"

# Architecture detection
if [[ "$(uname -m)" == "arm64" ]]; then
  BREW_PREFIX="/opt/homebrew"
else
  BREW_PREFIX="/usr/local"
fi

echo "==> [1/7] Xcode Command Line Tools"
if ! xcode-select -p &>/dev/null; then
  xcode-select --install
  echo "    Waiting for install to complete..."
  until xcode-select -p &>/dev/null; do sleep 5; done
fi
echo "    OK"

echo "==> [2/7] Homebrew"
if ! command -v brew &>/dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(${BREW_PREFIX}/bin/brew shellenv)"
fi
echo "    OK"

echo "==> [3/7] Brew Bundle"
brew bundle --file="$DOTFILES/Brewfile"

echo "==> [4/7] Stow symlinks"
cd "$DOTFILES"
for pkg in zsh vim nvim tmux git; do
  stow -v --restow --dotfiles "$pkg"
done

echo "==> [5/7] TPM (tmux plugin manager)"
TPM_DIR="$HOME/.tmux/plugins/tpm"
if [[ ! -d "$TPM_DIR" ]]; then
  git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
  echo "    Cloned TPM. Run prefix+I inside tmux to install plugins."
else
  echo "    OK (already installed)"
fi

echo "==> [6/7] Zsh plugins"
PLUGINS_DIR="$HOME/.zsh/plugins"
mkdir -p "$PLUGINS_DIR"

repos=(
  mafredri/zsh-async
  sindresorhus/pure
  zsh-users/zsh-completions
  zsh-users/zsh-autosuggestions
  zsh-users/zsh-syntax-highlighting
)

for repo in "${repos[@]}"; do
  dest="$PLUGINS_DIR/${repo##*/}"
  if [[ ! -d "$dest" ]]; then
    git clone "https://github.com/$repo" "$dest"
  fi
done
echo "    OK"

echo "==> [7/7] Vim plugins"
if command -v vim &>/dev/null; then
  vim +PlugInstall +qall 2>/dev/null
  echo "    OK"
fi

# Post-install checklist
echo ""
echo "===== Post-install checklist ====="
echo ""
missing=0
if [[ ! -f ~/env_var/env-vars.zsh ]]; then
  echo "[ ] Create ~/env_var/env-vars.zsh (see ~/.zsh/env-vars.zsh.example)"
  missing=1
fi
if [[ ! -f ~/.ssh/id_ed25519 ]] && [[ ! -f ~/.ssh/id_rsa ]]; then
  echo "[ ] Generate SSH key: ssh-keygen -t ed25519"
  missing=1
fi
if [[ ! -f ~/.iterm2_shell_integration.zsh ]]; then
  echo "[ ] Install iTerm2 shell integration"
  missing=1
fi
if ! command -v java &>/dev/null; then
  echo "[ ] Install Java (e.g. via SDKMAN: https://sdkman.io)"
  missing=1
fi
if [[ $missing -eq 0 ]]; then
  echo "Nothing missing — you're all set."
fi
echo ""
echo "Done. Open a new terminal or run: exec zsh"
