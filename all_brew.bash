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
brew install brew-cask

# cleanup
brew cleanup --force
rm -f -r /Library/Caches/Homebrew/*

