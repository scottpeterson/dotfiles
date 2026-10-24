# =============================================================================
# PERFORMANCE OPTIMIZATIONS
# =============================================================================

# Disable oh-my-zsh auto-update check (saves ~70ms) - run `omz update` manually
DISABLE_AUTO_UPDATE="true"

# Disable untracked files check in git (faster prompt in large repos)
DISABLE_UNTRACKED_FILES_DIRTY="true"

# =============================================================================
# PATH CONFIGURATION (consolidated - order matters, later entries have priority)
# =============================================================================
typeset -U PATH path  # drop duplicate PATH entries (macOS already adds /usr/local/bin)
export PATH="$HOME/bin:/usr/local/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/usr/local/opt/openjdk/bin:$PATH"

# Android SDK
export ANDROID_HOME=~/Library/Android/sdk
export ANDROID_SDK_ROOT=~/Library/Android/sdk

# =============================================================================
# OH-MY-ZSH CONFIGURATION
# =============================================================================
export ZSH="/Users/scottpeterson/.oh-my-zsh"

# No oh-my-zsh theme: Starship draws the prompt (see below and ~/.config/starship.toml)
ZSH_THEME=""

# Plugins - removed rarely-used ones (bundler, rake, ruby, python, node)
# These add completion/aliases you likely don't use and slow startup
plugins=(git macos zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# =============================================================================
# ALIASES
# =============================================================================
source ~/.aliases

# Prompt
eval "$(starship init zsh)"

# =============================================================================
# LAZY-LOADED TOOLS (only load when first used)
# =============================================================================

# thefuck - lazy load (saves ~110ms per shell)
fuck() {
    unset -f fuck
    eval $(thefuck --alias)
    fuck "$@"
}

# =============================================================================
# ENVIRONMENT
# =============================================================================
[[ -s "$HOME/.local/bin/env" ]] && . "$HOME/.local/bin/env"

# SSH keys: Removed - macOS Keychain handles this automatically via ~/.ssh/config
# Add "AddKeysToAgent yes" and "UseKeychain yes" to ~/.ssh/config instead

# bun completions
[ -s "/Users/scottpeterson/.bun/_bun" ] && source "/Users/scottpeterson/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"


# Machine-specific settings that stay out of the dotfiles repo
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
