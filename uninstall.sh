set -euo pipefail
BIN_DIR="${BIN_DIR:-$HOME/bin}"
INSTALL_DIR="${INSTALL_DIR:-$HOME/.local/share/aura-zsh-tools}"
ZSHRC="$HOME/.zshrc"
ALIAS_LINE='alias tools="zsh -f $HOME/bin/tools"'

rm -f "$BIN_DIR/tools"
[ -f "$ZSHRC" ] && tmp="$(mktemp)" && { grep -vxF "$ALIAS_LINE" "$ZSHRC" > "$tmp" || true; } && mv "$tmp" "$ZSHRC"
rm -rf "$INSTALL_DIR"
echo "Uninstalled."