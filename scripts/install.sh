#!/bin/zsh

# don't show terminal last login message
touch "$HOME/.hushlogin"

ln -snf $HOME/dotfiles/.config $HOME/.config

# zsh
mkdir -p $HOME/.cache/zsh $HOME/.local/state/zsh $HOME/.local/share/zsh/completions
ln -sf $HOME/dotfiles/.zshenv $HOME/.zshenv

# git
ln -sf $HOME/dotfiles/.gitconfig $HOME/.gitconfig

# textlint
ln -sf $HOME/dotfiles/.textlintrc $HOME/.textlintrc

source $HOME/.zshenv

# Homebrew
echo "[Homebrew]start"
if ! type brew &> /dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
if [ "$(uname)" = "Darwin" ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
  brew bundle --file "$HOME/dotfiles/Brewfile"
else
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  brew bundle --file "$HOME/dotfiles/Brewfile"
fi
echo "[Homebrew]finish"

# tmux theme
if ! [ -e "$HOME/.local/share/tmux/iceberg-dark" ]; then
  echo "[tmux theme]start"
  git clone https://github.com/gkeep/iceberg-dark.git "$HOME/.local/share/tmux/iceberg-dark"
  echo "[tmux theme]finish"
fi

# Hammerspoon（設定ファイルを ~/.config/hammerspoon/init.lua に変更）
if [ "$(uname)" = "Darwin" ]; then
  defaults write org.hammerspoon.Hammerspoon MJConfigFile "$HOME/.config/hammerspoon/init.lua"
fi

# mise
if command -v mise &> /dev/null; then
  echo "[mise]start"
  mise install
  eval "$(mise activate zsh)"
  echo "[mise]finish"
fi

# lua5.1 luarocks
if ! type lua &> /dev/null; then
  echo "[lua5.1 luarocks]start"
  PREFIX="$HOME/.local"
  curl -LO https://www.lua.org/ftp/lua-5.1.5.tar.gz
  curl -LO https://luarocks.github.io/luarocks/releases/luarocks-3.13.0.tar.gz
  tar -zxf lua-5.1.5.tar.gz
  tar -zxf luarocks-3.13.0.tar.gz
  cd lua-5.1.5
  make macosx
  make INSTALL_TOP="$PREFIX" install
  cd ../luarocks-3.13.0
  ./configure --prefix="$PREFIX" --with-lua-include="$PREFIX/include" --with-lua-bin="$PREFIX/bin/"
  make
  make install
  cd ../
  rm -rf lua-5.1.5.tar.gz lua-5.1.5 luarocks-3.13.0.tar.gz luarocks-3.13.0
  echo "[lua5.1 luarocks]finish"
fi

source $HOME/.config/zsh/.zshrc
echo "complete."
