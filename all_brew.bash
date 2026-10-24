#!/usr/bin/env bash
# Set up a new Mac: install Homebrew, install everything in the Brewfile,
# and install the dotfiles. The login shell stays macOS's /bin/zsh.
set -euo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if ! command -v brew >/dev/null 2>&1; then
  echo "Installing Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

echo "Updating Homebrew"
brew update
brew upgrade

echo "Installing Brewfile packages"
brew bundle --file="$repo_dir/Brewfile"

echo "Upgrading casks"
brew cu --all --yes --cleanup

brew cleanup

echo "Installing dotfiles"
"$repo_dir/dotfiles.sh" install
