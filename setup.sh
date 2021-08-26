#!/usr/bin/env bash

# Bootstrap script for setting up a new OSX machine
# 
# This should be idempotent so it can be run multiple times.
# 
# Original source: https://gist.github.com/codeinthehole/26b37efa67041e1307db

echo "Starting bootstrapping"

# Check for Homebrew, install if we don't have it
if test ! "$(which brew)"; then
    echo "Installing homebrew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update homebrew recipes
brew update

# Install GNU `find`, `locate`, `updatedb`, and `xargs`, g-prefixed
brew install findutils

# Install fzf
brew install bash

PACKAGES=(
    python3
    fzf
)

echo "Installing packages..."
brew install "${PACKAGES[@]}"

"$(brew --prefix)"/opt/fzf/install # Keybindings and fuzzy completion for fzf

echo "Cleaning up..."
brew cleanup

echo "Installing cask..."
brew install caskroom/cask/brew-cask

CASKS=(
    iterm2
)

echo "Installing cask apps..."
brew cask install "${CASKS[@]}"

echo "Installing fonts..."
brew tap caskroom/fonts
FONTS=(
    font-inconsolidata
    font-roboto
    font-clear-sans
)
brew cask install "${FONTS[@]}"

echo "Installing Python packages..."
PYTHON_PACKAGES=(
    ipython
    virtualenv
    virtualenvwrapper
)
sudo pip install "${PYTHON_PACKAGES[@]}"

# Uncomment and test these when actually needed (setting up OS):

# echo "Configuring OSX..."

# # Show filename extensions by default
# defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# # Enable tap-to-click
# defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
# defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# # Disable "natural" scroll
# defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false


echo "Bootstrapping complete"