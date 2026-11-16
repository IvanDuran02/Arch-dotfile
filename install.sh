#!/usr/bin/env bash
# ==============================================================================
# Dotfiles Bootstrap Script (Powered by chezmoi)
# ==============================================================================
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CHEZMOI_BIN=""

if command -v chezmoi &>/dev/null; then
    CHEZMOI_BIN="chezmoi"
elif [ -x "$HOME/.local/bin/chezmoi" ]; then
    CHEZMOI_BIN="$HOME/.local/bin/chezmoi"
else
    echo "==> chezmoi not found. Installing to ~/.local/bin..."
    mkdir -p "$HOME/.local/bin"
    sh -c "$(curl -fsLS https://get.chezmoi.io)" -- -b "$HOME/.local/bin"
    CHEZMOI_BIN="$HOME/.local/bin/chezmoi"
fi

echo "==> Deploying dotfiles using chezmoi (source: $DOTFILES_DIR)..."
"$CHEZMOI_BIN" init --source="$DOTFILES_DIR" --apply

echo "==> Dotfiles setup complete!"
echo "==> To reload Hyprland: hyprctl reload"
