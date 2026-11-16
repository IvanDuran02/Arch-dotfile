# ==============================================================================
# ZSH CONFIGURATION (Wayland & WezTerm Optimized)
# ==============================================================================

# Path to Oh My Zsh installation
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

# Plugins
plugins=(git)

if [ -f "$ZSH/oh-my-zsh.sh" ]; then
    source "$ZSH/oh-my-zsh.sh"
fi

# Environment & PATH
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"

if [ -d "$HOME/Android/Sdk" ]; then
    export ANDROID_SDK_ROOT="$HOME/Android/Sdk"
    export PATH="$PATH:$ANDROID_SDK_ROOT/platform-tools:$ANDROID_SDK_ROOT/emulator:$ANDROID_SDK_ROOT/tools:$ANDROID_SDK_ROOT/tools/bin"
fi

# Default Editor
export EDITOR='nvim'
export VISUAL='nvim'

# Aliases
alias vim=nvim
alias v=nvim
alias t=tmux
alias ta='tmux attach'
alias tls='tmux ls'
alias c=clear
alias open=xdg-open
alias lg=lazygit

# Oh My Posh initialization (if installed)
if command -v oh-my-posh >/dev/null 2>&1; then
    eval "$(oh-my-posh init zsh --config 'https://github.com/JanDeDobbeleer/oh-my-posh/blob/main/themes/catppuccin_mocha.omp.json')"
fi

# Cursor Styling: Blinking skinny bar
echo -ne '\e[5 q'
function restore_cursor {
    echo -ne '\e[5 q'
}
autoload -Uz add-zsh-hook
add-zsh-hook precmd restore_cursor
