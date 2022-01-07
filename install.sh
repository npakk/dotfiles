#!/usr/bin/env zsh

# don't show terminal last login message
touch "${HOME}/.hushlogin"

# Homebrew
ln -sf ~/dotfiles/home/Brewfile ~/Brewfile

# zsh
mkdir -p ~/.config/zsh
mkdir -p ~/.cache/zsh
ln -sf ~/dotfiles/home/.zshenv ~/.zshenv
ln -sf ~/dotfiles/config/zsh/.zshrc ~/.config/zsh/.zshrc
ln -snf ~/dotfiles/config/zsh/autoload ~/.config/zsh/autoload
ln -sf ~/dotfiles/config/zsh/.p10k.zsh ~/.config/zsh/.p10k.zsh

# fzf
mkdir -p ~/.config/fzf
ln -sf ~/dotfiles/config/fzf/.fzf.zsh ~/.config/fzf/.fzf.zsh

# git
mkdir -p ~/.config/git
ln -sf ~/dotfiles/home/.gitconfig ~/.gitconfig
ln -sf ~/dotfiles/config/git/ignore ~/.config/git/ignore

# github cli
mkdir -p ~/.config/gh
ln -sf ~/dotfiles/config/gh/config.yml ~/.config/gh/config.yml

# lazygit
mkdir -p ~/.config/lazygit
ln -sf ~/dotfiles/config/lazygit/config.yml ~/.config/lazygit/config.yml
ln -sf ~/dotfiles/config/lazygit/state.yml ~/.config/lazygit/state.yml

# karabiner-elements
mkdir -p ~/.config/karabiner
ln -sf ~/dotfiles/config/karabiner/karabiner.json ~/.config/karabiner/karabiner.json
ln -snf ~/dotfiles/config/karabiner/assets ~/.config/karabiner/assets

# iTerm2
mkdir -p ~/.config/iTerm2
ln -sf ~/dotfiles/config/iTerm2/com.googlecode.iterm2.plist ~/.config/iTerm2/com.googlecode.iterm2.plist

# Alacritty
mkdir -p ~/.config/alacritty
ln -sf ~/dotfiles/config/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml

# tmux
ln -sf ~/dotfiles/home/.tmux.conf ~/.tmux.conf

# neovim
mkdir -p ~/.config/nvim
ln -sf ~/dotfiles/config/nvim/init.lua ~/.config/nvim/init.lua
ln -snf ~/dotfiles/config/nvim/after ~/.config/nvim/after
ln -snf ~/dotfiles/config/nvim/lua ~/.config/nvim/lua
ln -snf ~/dotfiles/config/nvim/snippets ~/.config/nvim/snippets
ln -sf ~/dotfiles/config/nvim/.stylua ~/.config/nvim/.stylua

# textlint
ln -sf ~/dotfiles/home/.textlintrc ~/.textlintrc
