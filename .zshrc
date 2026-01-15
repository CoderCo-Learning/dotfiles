# ============================================================================
# CoderCo zshrc Configuration
# Simple shell environment for DevOps workflows
# ============================================================================

# =================================================
# POWERLEVEL10K INSTANT PROMPT
# =================================================
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# =================================================
# ENVIRONMENT VARIABLES
# =================================================

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export EDITOR='vim'
export VISUAL='vim'

# History configuration
export HISTFILE=~/.zsh_history
export HISTSIZE=50000
export SAVEHIST=50000

# Development directories
export WORKSPACE="$HOME/workspace"
export LEARNING_DIR="$HOME/Documents/Learning"

# Docker
export DOCKER_BUILDKIT=1
export COMPOSE_DOCKER_CLI_BUILD=1

# =================================================
# PATH CONFIGURATION
# =================================================

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

# Homebrew paths (macOS)
if [[ "$OSTYPE" == "darwin"* ]]; then
  export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
  export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
fi

# User local paths
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/bin:$PATH"

# =================================================
# OH MY ZSH CONFIGURATION
# =================================================

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
  git
  docker
  docker-compose
  kubectl
  terraform
  aws
  helm
  z
  zsh-autosuggestions
  zsh-syntax-highlighting
)

DISABLE_AUTO_UPDATE="false"
UPDATE_ZSH_DAYS=7
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"

if [[ -f "$ZSH/oh-my-zsh.sh" ]]; then
  source "$ZSH/oh-my-zsh.sh"
else
  echo "Oh My Zsh not found. Install with:"
  echo "sh -c \"\$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)\""
fi

# =================================================
# COMPLETION SYSTEM
# =================================================

autoload -Uz compinit
compinit

setopt COMPLETE_IN_WORD
setopt ALWAYS_TO_END
setopt AUTO_MENU
setopt AUTO_LIST

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# =================================================
# HISTORY CONFIGURATION
# =================================================

setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY

# =================================================
# TOOL SETUP
# =================================================

# Go
if command -v go >/dev/null 2>&1; then
  export GOPATH="$(go env GOPATH)"
  export GOROOT="$(go env GOROOT)"
  export PATH="$GOPATH/bin:$GOROOT/bin:$PATH"
fi

# Python/pyenv
if command -v pyenv >/dev/null 2>&1; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init --path)"
  eval "$(pyenv init -)"
fi

# Kubernetes completions
if command -v kubectl >/dev/null 2>&1; then
  source <(kubectl completion zsh)
fi

if command -v helm >/dev/null 2>&1; then
  source <(helm completion zsh)
fi

# AWS completion
if command -v aws_completer >/dev/null 2>&1; then
  complete -C aws_completer aws
fi

# =================================================
# ALIASES - NAVIGATION
# =================================================

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ~='cd ~'
alias -- -='cd -'

# Basic
alias c='clear'
alias h='history'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# =================================================
# ALIASES - GIT
# =================================================

alias g='git'
alias gs='git status'
alias ga='git add'
alias gaa='git add --all'
alias gc='git commit'
alias gcm='git commit -m'
alias gp='git push'
alias gpl='git pull'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gl='git log --oneline -10'
alias gd='git diff'
alias gb='git branch'

# =================================================
# ALIASES - DOCKER
# =================================================

alias d='docker'
alias dc='docker compose'
alias dps='docker ps'
alias dpsa='docker ps -a'
alias di='docker images'
alias dex='docker exec -it'
alias dlogs='docker logs -f'
alias dprune='docker system prune -af'

# Docker Compose
alias dcu='docker compose up'
alias dcd='docker compose down'
alias dcb='docker compose build'

# =================================================
# ALIASES - KUBERNETES
# =================================================

alias k='kubectl'
alias kgp='kubectl get pods'
alias kgpa='kubectl get pods -A'
alias kgs='kubectl get svc'
alias kgd='kubectl get deployments'
alias kgn='kubectl get nodes'
alias kl='kubectl logs'
alias klf='kubectl logs -f'
alias kex='kubectl exec -it'
alias ka='kubectl apply -f'
alias kdel='kubectl delete'

# Contexts (if kubectx installed)
if command -v kubectx >/dev/null 2>&1; then
  alias kx='kubectx'
fi

# =================================================
# ALIASES - TERRAFORM
# =================================================

alias tf='terraform'
alias tfi='terraform init'
alias tfp='terraform plan'
alias tfa='terraform apply'
alias tfd='terraform destroy'
alias tfv='terraform validate'
alias tff='terraform fmt'
alias tfo='terraform output'
alias tfsl='terraform state list'

# =================================================
# ALIASES - AWS
# =================================================

alias awswho='aws sts get-caller-identity'
alias awsp='export AWS_PROFILE'

# =================================================
# ALIASES - HELM
# =================================================

alias hls='helm list'
alias hlsa='helm list -A'
alias hi='helm install'
alias hu='helm upgrade'
alias hd='helm delete'
alias hs='helm status'
alias hrepou='helm repo update'

# =================================================
# UTILITY FUNCTIONS
# =================================================

# System info
sysinfo() {
  echo "System Information"
  echo "=================="
  echo "OS: $(uname -s) $(uname -r)"
  echo "Shell: $SHELL"
  echo "User: $(whoami)"
  echo "Hostname: $(hostname)"
}

# AWS profile setter
awsp() {
  if [[ $# -eq 0 ]]; then
    echo "Current AWS Profile: ${AWS_PROFILE:-default}"
    aws configure list-profiles 2>/dev/null || echo "No profiles found"
  else
    export AWS_PROFILE="$1"
    echo "AWS Profile set to: $1"
  fi
}

# Kubernetes contexts
k8s-ctx() {
  if command -v kubectx >/dev/null 2>&1; then
    kubectx
  else
    kubectl config get-contexts
  fi
}

# Directory shortcuts
alias workspace='cd $WORKSPACE'
alias learn='cd $LEARNING_DIR'

# Quick editing
alias zshrc='$EDITOR ~/.zshrc'
alias reload='source ~/.zshrc'

# =================================================
# POWERLEVEL10K CONFIGURATION
# =================================================

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# =================================================
# CoderCo Dotfiles Integration
# =================================================

if [[ -f "${HOME}/.coderco-dotfiles/coderco.sh" ]]; then
  source "${HOME}/.coderco-dotfiles/coderco.sh"
fi

# =================================================
# SETUP
# =================================================

[[ ! -d "$WORKSPACE" ]] && mkdir -p "$WORKSPACE"
[[ ! -d "$LEARNING_DIR" ]] && mkdir -p "$LEARNING_DIR"
