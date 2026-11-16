#!/usr/bin/env bash
# ==============================================================================
# Chezmoi Lifecycle Script: Arch Linux Package & Environment Setup
# Triggered automatically on `chezmoi apply` when this file changes
# ==============================================================================
set -euo pipefail

if [ ! -f /etc/arch-release ]; then
    echo "==> Skipping Arch package installation: non-Arch distribution detected."
    exit 0
fi

echo "==> [chezmoi] Verifying Arch Linux packages..."

# List of official Arch packages required for this environment
PACKAGES=(
    # Wayland & Desktop
    hyprland
    waybar
    wezterm
    wl-clipboard
    pavucontrol

    # Core CLI & Editors
    tmux
    zsh
    neovim
    git
    fzf
    ripgrep
    fd
    tree
    stow

    # Fonts
    ttf-jetbrains-mono-nerd

    # Development toolchains
    go
    rustup
    python
    python-pip
    base-devel
)

MISSING_PACKAGES=()
for pkg in "${PACKAGES[@]}"; do
    if ! pacman -Qi "$pkg" &>/dev/null; then
        MISSING_PACKAGES+=("$pkg")
    fi
done

if [ ${#MISSING_PACKAGES[@]} -gt 0 ]; then
    echo "==> Missing official packages: ${MISSING_PACKAGES[*]}"
    if command -v sudo &>/dev/null && sudo -n true 2>/dev/null; then
        sudo pacman -S --needed --noconfirm "${MISSING_PACKAGES[@]}"
    else
        echo "==> Please install them by running: sudo pacman -S --needed ${MISSING_PACKAGES[*]}"
    fi
else
    echo "==> All official Arch packages are installed."
fi

# Toolchains setup
if command -v rustup &>/dev/null; then
    if ! rustup toolchain list | grep -q "stable"; then
        echo "==> Initializing Rust stable toolchain..."
        rustup default stable
    fi
fi

# Setup TPM (Tmux Plugin Manager) if missing
TPM_DIR="$HOME/.config/tmux/plugins/tpm"
if [ ! -d "$TPM_DIR" ]; then
    echo "==> Cloning Tmux Plugin Manager (TPM)..."
    git clone https://github.com/tmux-plugins/tpm "$TPM_DIR" || true
fi

# Create required directories
mkdir -p "$HOME/Packages/go" "$HOME/.vim/undodir" "$HOME/Pictures/Screenshots" "$HOME/.local/bin"

echo "==> [chezmoi] Arch environment setup complete."
