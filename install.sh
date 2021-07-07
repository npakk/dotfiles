#!/usr/bin/env zsh

# Homebrew
ln -sf ~/dotfiles/HOME/Brewfile ~/Brewfile

# zsh
ln -sf ~/dotfiles/HOME/.zshenv ~/.zshenv
ln -sf ~/dotfiles/.config/zsh/.zshrc ~/.config/zsh/.zshrc

# git
ln -sf ~/dotfiles/HOME/.gitconfig ~/.gitconfig
ln -sf ~/dotfiles/.config/git/ignore ~/.config/git/ignore

# ghq
if [ ! -d ~/.config/gh ]; then
  mkdir ~/.config/gh
fi
ln -sf ~/dotfiles/.config/gh/config.yml ~/.config/gh/config.yml

# karabiner-elements
ln -sf ~/dotfiles/.config/karabiner/karabiner.json ~/.config/karabiner/karabiner.json
ln -snf ~/dotfiles/.config/karabiner/assets ~/.config/karabiner/assets

# iTerm2
ln -sf ~/dotfiles/.config/iTerm2/com.googlecode.iterm2.plist ~/.config/iTerm2/com.googlecode.iterm2.plist
ln -sf ~/dotfiles/.config/iTerm2/iceberg_bluemoon.itermcolors ~/.config/iTerm2/iceberg_bluemoon.itermcolors
ln -sf ~/dotfiles/.config/iTerm2/MyProfile.json ~/.config/iTerm2/MyiTerm.json

# neovim
ln -sf ~/dotfiles/.config/nvim/init.lua ~/.config/nvim/init.lua
ln -snf ~/dotfiles/.config/nvim/after ~/.config/nvim/after
ln -snf ~/dotfiles/.config/nvim/lua ~/.config/nvim/lua
ln -snf ~/dotfiles/.config/nvim/snippets ~/.config/nvim/snippets
