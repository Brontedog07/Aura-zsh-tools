set -euo pipefail

REPO_URL="${REPO_URL:-https://github.com/Brontedog07/Aura-zsh-tools.git}"
INSTALL_DIR="${INSTALL_DIR:-$HOME/.local/share/aura-zsh-tools}"
BIN_DIR="${BIN_DIR:-$HOME/bin}"
DEPS=(${DEPS:-})  # e.g., DEPS=(jq curl)

mkdir -p "$INSTALL_DIR" "$BIN_DIR"

if [ ! -d "$INSTALL_DIR/.git" ]; then
  git clone "$REPO_URL" "$INSTALL_DIR"
else
  git -C "$INSTALL_DIR" pull --ff-only
fi

# Link entrypoint
if [ -f "$INSTALL_DIR/tools" ]; then
  ln -sf "$INSTALL_DIR/tools" "$BIN_DIR/tools"
fi

# Add alias if missing
ALIAS_LINE='alias tools="zsh -f $HOME/bin/tools"'
ZSHRC="$HOME/.zshrc"
if ! grep -qxF "$ALIAS_LINE" "$ZSHRC" 2>/dev/null; then
  echo "$ALIAS_LINE" >> "$ZSHRC"
fi

# Optional deps
if [ ${#DEPS[@]} -gt 0 ]; then
  if command -v brew >/dev/null 2>&1; then
    brew install "${DEPS[@]}"
  elif command -v apt-get >/dev/null 2>&1; then
    sudo apt-get update && sudo apt-get install -y "${DEPS[@]}"
  else
    echo "Install deps manually: ${DEPS[*]}"
  fi
fi

echo "Done. Restart your shell or run: source $ZSHRC"