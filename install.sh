#!/usr/bin/env bash

# ==============================================================================
# Dotfiles Installation & Symlink Script
# ==============================================================================
set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo "==> Deploying dotfiles from: $DOTFILES_DIR"

# Ensure target directories exist
mkdir -p "$HOME/.config" "$HOME/.local/bin" "$HOME/.vim/undodir" "$HOME/Pictures/Screenshots"

# Make helper scripts executable
chmod +x "$DOTFILES_DIR/bin/.local/bin/tmux-sessionizer"

if command -v stow >/dev/null 2>&1; then
    echo "==> GNU Stow detected. Linking packages..."
    cd "$DOTFILES_DIR"
    stow -v -R -t "$HOME" wezterm nvim tmux hypr zsh bin
else
    echo "==> GNU Stow not installed. Creating direct symlinks..."
    ln -sfn "$DOTFILES_DIR/wezterm/.config/wezterm" "$HOME/.config/wezterm"
    ln -sfn "$DOTFILES_DIR/nvim/.config/nvim"       "$HOME/.config/nvim"
    ln -sfn "$DOTFILES_DIR/tmux/.config/tmux"       "$HOME/.config/tmux"
    ln -sf  "$DOTFILES_DIR/hypr/.config/hypr/hyprland.lua" "$HOME/.config/hypr/hyprland.lua"
    ln -sf  "$DOTFILES_DIR/zsh/.zshrc"             "$HOME/.zshrc"
    ln -sf  "$DOTFILES_DIR/bin/.local/bin/tmux-sessionizer" "$HOME/.local/bin/tmux-sessionizer"
fi

echo "==> Dotfiles setup complete!"
echo "==> To reload Hyprland config: hyprctl reload"
echo "==> To start tmux with sessionizer: press Ctrl-Space followed by f, or run tmux-sessionizer"
