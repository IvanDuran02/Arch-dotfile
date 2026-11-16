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

# Golang (located in ~/Packages/go)
export GOPATH="$HOME/Packages/go"
export GOBIN="$GOPATH/bin"
export PATH="$PATH:$GOBIN"

# Rust (Cargo)
if [ -d "$HOME/.cargo/bin" ]; then
    export PATH="$HOME/.cargo/bin:$PATH"
fi

# Fast Node Manager (fnm)
if command -v fnm >/dev/null 2>&1; then
    eval "$(fnm env --use-on-cd --shell zsh)"
fi

# jenv (Java Version Manager)
export PATH="$HOME/.jenv/bin:$PATH"
if command -v jenv >/dev/null 2>&1; then
    eval "$(jenv init -)"
fi

if [ -d "$HOME/Android/Sdk" ]; then
    export ANDROID_SDK_ROOT="$HOME/Android/Sdk"
    export PATH="$PATH:$ANDROID_SDK_ROOT/platform-tools:$ANDROID_SDK_ROOT/emulator:$ANDROID_SDK_ROOT/tools:$ANDROID_SDK_ROOT/tools/bin"
fi

# Default Editor
export EDITOR='nvim'
export VISUAL='nvim'

# Fix GNU ls colors (eliminate bright green background on other-writable/sticky dirs)
if command -v dircolors >/dev/null 2>&1; then
    eval "$(dircolors -b 2>/dev/null)"
    export LS_COLORS="$LS_COLORS:ow=01;34:tw=01;34:st=01;34:"
fi

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
