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

# Theme - bullet-train is fancy but slower; consider "robbyrussell" for speed
ZSH_THEME="bullet-train"

# Plugins - removed rarely-used ones (bundler, rake, ruby, python, node)
# These add completion/aliases you likely don't use and slow startup
plugins=(git macos zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# =============================================================================
# ALIASES
# =============================================================================
source ~/.aliases

# =============================================================================
# LAZY-LOADED TOOLS (only load when first used)
# =============================================================================

# thefuck - lazy load (saves ~110ms per shell)
fuck() {
    unset -f fuck
    eval $(thefuck --alias)
    fuck "$@"
}

# SDKMAN - lazy load (saves ~50ms per shell)
export SDKMAN_DIR="$HOME/.sdkman"
sdk() {
    unset -f sdk
    [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
    sdk "$@"
}

# =============================================================================
# ENVIRONMENT
# =============================================================================
[[ -s "$HOME/.local/bin/env" ]] && . "$HOME/.local/bin/env"
export GOOGLE_APPLICATION_CREDENTIALS="/Users/scottpeterson/article-to-overcast-d5853d7d1ca9.json"

# SSH keys: Removed - macOS Keychain handles this automatically via ~/.ssh/config
# Add "AddKeysToAgent yes" and "UseKeychain yes" to ~/.ssh/config instead

# bun completions
[ -s "/Users/scottpeterson/.bun/_bun" ] && source "/Users/scottpeterson/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# >>> jarvis env auto-load >>>
# any shell opened inside projects/jarvis auto-loads its .env
_jarvis_load_env() {
  if [[ "$PWD" == "$HOME/projects/jarvis"* && -f "$HOME/projects/jarvis/.env" ]]; then
    set -a; source "$HOME/projects/jarvis/.env"; set +a
  fi
}
autoload -Uz add-zsh-hook
add-zsh-hook chpwd _jarvis_load_env
_jarvis_load_env
# <<< jarvis env auto-load <<<
