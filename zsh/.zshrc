## 1. Environment & FPATH
export JAVA_HOME=$(/usr/libexec/java_home -v 11)
export NVM_DIR="$HOME/.nvm"
export LESS="-XFR"
export FZF_DEFAULT_COMMAND='rg'
export CLOUDSDK_PYTHON="/usr/local/bin/python3"
export CLICOLOR=1

# Consolidate fpath for completions
fpath=(
  "/Users/robjones/Library/Application Support/ScalaCli/completions/zsh"
  ~/.zsh/completion
  $fpath
)

## 2. History Configuration
HISTFILE=${HISTFILE:-$HOME/.zsh_history}
HISTSIZE=10000
SAVEHIST=10000

case $HIST_STAMPS in
  "mm/dd/yyyy") alias history='fc -fl 1' ;;
  "dd.mm.yyyy") alias history='fc -El 1' ;;
  "yyyy-mm-dd") alias history='fc -il 1' ;;
  *)            alias history='fc -l 1'  ;;
esac

setopt append_history extended_history hist_expire_dups_first
setopt hist_ignore_dups hist_ignore_space hist_verify
setopt inc_append_history share_history

## 3. Aliases
alias pip="echo 'Use uv instead of pip to keep your Mac clean. Running: uv pip';" # Prevent accidental global pip installs by routing to uv
alias pip-install="echo 'Installing via uv...'; uv pip install" # Prevent accidental global pip installs by routing to uv
alias tree='tree -C -I "*~|*#|node_modules|sprockets" && echo "Tree excluding node_modules"'
alias brewup="brew update && brew upgrade && brew cleanup"
alias gs='git status' gp='git pull' ga='git add' gd='git diff'
alias gcm='git commit -m' gc='git commit' goto='git checkout'
alias zp='vim ~/.zshrc' zpr='exec zsh'
alias k='kubectl' kcx='kubectx' mk='minikube' tn='tmux new -f'

## 4. Plugin Manager (zplug)
export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

zplug 'mafredri/zsh-async', from:"github", at:"main", use:"async.zsh"
zplug 'sindresorhus/pure', use:pure.zsh, at:"main", from:github, as:theme
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "docker/compose", use:contrib/completion/zsh

if ! zplug check --verbose; then
  printf "Install [y/N]: "
  if read -q; then
      zplug install
  fi
fi
zplug load --verbose

## 5. Lazy-Load NVM (Huge speed boost)
lazy_nvm() {
  unset -f nvm node npm npx pnpm
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
  "$@"
}
nvm() { lazy_nvm nvm "$@"; }
node() { lazy_nvm node "$@"; }
npm() { lazy_nvm npm "$@"; }
npx() { lazy_nvm npx "$@"; }
pnpm() { lazy_nvm pnpm "$@"; }

## 6. External Tooling
# Load Z
[ -f "/usr/local/etc/profile.d/z.sh" ] && . "/usr/local/etc/profile.d/z.sh" # Intel Mac profile
[ -f "opt/homebrew/etc/profile.d/z.sh" ] && . "opt/homebrew/etc/profile.d/z.sh"	# Apple Silicon Mac profile

# Google Cloud SDK
alias load-gcloud='source "/Users/robjones/google-cloud-sdk/path.zsh.inc" && source "/Users/robjones/google-cloud-sdk/completion.zsh.inc"' # Google Cloud SDK - Load only when needed

# Local Scripts
source ~/.zsh/zsh-functions.zsh
source ~/.zsh/omz-git.zsh
source ~/.iterm2_shell_integration.zsh
source ~/env_var/env-vars.zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# K8s Prompt - Source after all env vars are set
if [ ! -f ~/.kube/completion.zsh ]; then
  mkdir -p ~/.kube
  kubectl completion zsh > ~/.kube/completion.zsh
fi
source ~/.kube/completion.zsh
## To display the current k8s context in the prompt for visual safety
RPROMPT='$(kubectx_prompt)'

## Used to quickly switch between k8s contexts 
kc() {
  kubectl config use-context "$1"
}

## Used to quickly switch between k8s namespaces within the current context
kn() {
  kubectl config set-context --current --namespace="$1"
}

# 7. Path configuration - Ensure custom paths are prioritised and duplicates are removed
typeset -U path

# # Set the priority order
path=(
  /usr/local/bin
  /usr/local/sbin
  $HOME/google-cloud-sdk/bin
  $HOME/.orbstack/bin
  $path
  )
export PATH

## 7. Final Initialization (Run ONCE)
autoload -Uz colors && colors
autoload -Uz compinit && compinit

## 8. Ensure Ctrl-Z (SIGSTOP) works regardless of plugin interference
bindkey -e                 # Emacs keybindings on CLI
setopt MONITOR             # Check for job control support to stay enabled
bindkey '^Z' suspend-shell # re-bind Ctrl-Z to suspend the shell as is zsh default
stty susp ^Z               # Terminal must honor the suspend signal

# Claude Code
export MAX_MCP_OUTPUT_TOKENS=100000
