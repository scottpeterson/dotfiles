#!/bin/sh

echo Install and Set San Francisco as System Font
ruby -e "$(curl -fsSL https://raw.github.com/wellsriley/YosemiteSanFranciscoFont/master/install)"

echo Install Homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew tap homebrew/science

echo Homebrew Maintenance
brew doctor
brew update
brew outdated
brew upgrade
brew tap phinze/cask
brew install brew-cask

echo Allllll the installs
declare -a cask_apps=(
  '1password'
  'wget'
  'iterm2'
  'transmit'
  'sublime-text'
  'slack'
  'github'
  'visual-studio-code'
  'git'
  'tree'
  'firefox'
  # 'postgresql'
  # 'go'
  # 'golang'
  # 'node'
  # 'ant'
  # 'ffmpeg'
  # 'eigen'
  # 'opencv'
  # 'java'
)

for app in "${cask_apps[@]}"; do
  brew cask install "$app"
done

# Development
xcode-select --install

# cleanup
brew cleanup --force
rm -f -r /Library/Caches/Homebrew/*

