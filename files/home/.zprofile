if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

export PATH="$HOME/.local/bin:$PATH"

source "$HOME/.orbstack/shell/init.zsh" 2>/dev/null || true

if command -v mise >/dev/null 2>&1; then
  eval "$(mise activate zsh --shims)"
fi
