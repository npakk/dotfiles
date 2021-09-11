#!/usr/bin/env zsh

# don't show terminal last login message
touch "${HOME}/.hushlogin"

# Homebrew
ln -sf ~/dotfiles/home/Brewfile ~/Brewfile

# zsh
ln -sf ~/dotfiles/home/.zshenv ~/.zshenv
ln -sf ~/dotfiles/config/zsh/.zshrc ~/.config/zsh/.zshrc
ln -snf ~/dotfiles/config/zsh/autoload ~/.config/zsh/autoload

# git
ln -sf ~/dotfiles/home/.gitconfig ~/.gitconfig
ln -sf ~/dotfiles/config/git/ignore ~/.config/git/ignore

# github cli
ln -sf ~/dotfiles/config/gh/config.yml ~/.config/gh/config.yml

# lazygit
ln -sf ~/dotfiles/config/lazygit/config.yml ~/.config/lazygit/config.yml
ln -sf ~/dotfiles/config/lazygit/state.yml ~/.config/lazygit/state.yml

# karabiner-elements
ln -sf ~/dotfiles/config/karabiner/karabiner.json ~/.config/karabiner/karabiner.json
ln -snf ~/dotfiles/config/karabiner/assets ~/.config/karabiner/assets

# iTerm2
ln -sf ~/dotfiles/config/iTerm2/com.googlecode.iterm2.plist ~/.config/iTerm2/com.googlecode.iterm2.plist

# Alacritty
ln -sf ~/dotfiles/config/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml

# tmux
ln -sf ~/dotfiles/home/.tmux.conf ~/.tmux.conf

# neovim
ln -sf ~/dotfiles/config/nvim/init.lua ~/.config/nvim/init.lua
ln -snf ~/dotfiles/config/nvim/after ~/.config/nvim/after
ln -snf ~/dotfiles/config/nvim/lua ~/.config/nvim/lua
ln -snf ~/dotfiles/config/nvim/snippets ~/.config/nvim/snippets
ln -sf ~/dotfiles/config/nvim/.stylua ~/.config/nvim/.stylua

# textlint
ln -sf ~/dotfiles/home/.textlintrc ~/.textlintrc
