#!/bin/sh

echo Install and Set San Francisco as System Font
ruby -e "$(curl -fsSL https://raw.github.com/wellsriley/YosemiteSanFranciscoFont/master/install)"

echo Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo Homebrew Maintenance
brew doctor
brew update
brew outdated
brew upgrade
brew tap phinze/cask
brew install brew-cask

echo Allllll the installs
brew bundle

# cleanup
brew cleanup --force
rm -f -r /Library/Caches/Homebrew/*

# upgrade all brew
brew cu --all --cleanup -y -v ; do_all

# set zsh as default shell
hsh -s /opt/homebrew/bin/zsh