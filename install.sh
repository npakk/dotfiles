#!/usr/bin/env zsh

# Homebrew
ln -sf ~/dotfiles/Brewfile ~/Brewfile

# zsh
ln -sf ~/dotfiles/.zshenv ~/.zshenv
ln -sf ~/dotfiles/zsh/.zshrc ~/.config/zsh/.zshrc

# git
ln -sf ~/dotfiles/.gitconfig ~/.gitconfig
ln -sf ~/dotfiles/git/ignore ~/.config/git/ignore

# ghq
if [ ! -d ~/.config/gh ]; then
  mkdir ~/.config/gh
fi
ln -sf ~/dotfiles/gh/config.yml ~/.config/gh/config.yml

# karabiner-elements
ln -sf ~/dotfiles/karabiner/karabiner.json ~/.config/karabiner/karabiner.json
ln -snf ~/dotfiles/karabiner/assets ~/.config/karabiner/assets

# iTerm2
ln -sf ~/dotfiles/iTerm2/com.googlecode.iterm2.plist ~/.config/iTerm2/com.googlecode.iterm2.plist
ln -sf ~/dotfiles/iTerm2/iceberg_bluemoon.itermcolors ~/.config/iTerm2/iceberg_bluemoon.itermcolors
ln -sf ~/dotfiles/iTerm2/MyProfile.json ~/.config/iTerm2/MyiTerm.json

# neovim
ln -sf ~/dotfiles/nvim/init.lua ~/.config/nvim/init.lua
ln -snf ~/dotfiles/nvim/after ~/.config/nvim/after
ln -snf ~/dotfiles/nvim/lua ~/.config/nvim/lua
ln -snf ~/dotfiles/nvim/snippets ~/.config/nvim/snippets
