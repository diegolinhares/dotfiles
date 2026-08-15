export PATH="$HOME/.local/bin:$PATH"

if command -v mise >/dev/null 2>&1; then
  eval "$(mise activate zsh)"
fi

if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi

if command -v atuin >/dev/null 2>&1; then
  eval "$(atuin init zsh)"
fi

if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
  alias cd=zd
  zd() {
    if (($# == 0)); then
      builtin cd "$HOME"
    elif [[ -d "$1" ]]; then
      builtin cd "$1"
    else
      z "$@"
    fi
  }
fi

if command -v eza >/dev/null 2>&1; then
  alias ls='eza -lh --group-directories-first --icons=auto'
  alias lsa='ls -a'
  alias lt='eza --tree --level=2 --long --icons --git'
  alias lta='lt -a'
fi

ff() {
  fzf --preview 'bat --style=numbers --color=always {}'
}

n() {
  if (($# == 0)); then
    nvim .
  else
    nvim "$@"
  fi
}

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias d=docker
alias r=rails
alias g=git
alias gcm='git commit -m'
alias gcam='git commit -a -m'
alias gcad='git commit -a --amend'

if command -v opencode >/dev/null 2>&1; then
  alias c=opencode
fi

export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
