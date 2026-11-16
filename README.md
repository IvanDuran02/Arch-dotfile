# Dotfiles (Arch Linux + Wayland)

Managed with [chezmoi](https://www.chezmoi.io/).

## Stack & Environment
- **Compositor:** Hyprland (native Lua configuration, `ALT` modifier, multi-monitor 4K 120Hz + 1080p 75Hz)
- **Bar:** Waybar (Catppuccin Mocha, positioned at bottom)
- **Terminal:** WezTerm (Wayland native, Catppuccin Mocha, internal window opacity)
- **Multiplexer:** Tmux (`Ctrl-Space` prefix, vi-mode, Catppuccin pill tabs, `Ctrl-Space f` sessionizer)
- **Editor:** Neovim (Lazy.nvim, Treesitter, Mason LSP, Catppuccin Mocha, `cmdheight=0` flush layout)
- **Shell:** Zsh (Oh-My-Zsh, vi-cursor, custom LS_COLORS)
- **Languages:** Node (`fnm`), Rust (`rustup`), Go (`~/Packages/go`), Java (`jenv`), Python 3

## One-Command Deployment on Fresh Arch Linux
On any new Arch install:
```bash
sudo pacman -S --needed git chezmoi
chezmoi init --apply <your-repo-url>
```
*Chezmoi will clone the repository, install all official Arch packages via `run_onchange_install-packages.sh`, and deploy all configuration files directly into `~/.config/` and `~` (clean real files, no messy symlinks).*

Alternatively, if already cloned:
```bash
~/dotfiles/install.sh
```

## Daily Workflow
- **Check differences against dotfiles repository:**
  ```bash
  chezmoi diff
  ```
- **Check modified files:**
  ```bash
  chezmoi status
  ```
- **Apply changes from repository to system:**
  ```bash
  chezmoi apply
  ```
- **Edit a config (automatically stages into chezmoi):**
  ```bash
  chezmoi edit ~/.config/nvim/init.lua
  ```
  *(Or edit `~/.config/...` directly and run `chezmoi re-add`)*
- **Jump to dotfiles repository:**
  ```bash
  chezmoi cd
  ```
