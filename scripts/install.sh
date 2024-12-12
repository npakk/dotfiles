#!/bin/zsh

# don't show terminal last login message
touch "$HOME/.hushlogin"

# zsh
mkdir -p $HOME/.cache/zsh $HOME/.local/state/zsh $HOME/.local/share/zsh/completions
ln -sf $HOME/dotfiles/.zshenv $HOME/.zshenv
ln -sf $HOME/dotfiles/.gitconfig $HOME/.gitconfig
ln -snf $HOME/dotfiles/.config $HOME/.config

source $HOME/.zshenv
source $HOME/.config/zsh/.zshrc

# Homebrew
echo "[Homebrew]start"
if ! type brew &> /dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
/opt/homebrew/bin/brew bundle --file "$HOME/dotfiles/Brewfile"
echo "[Homebrew]finish"

# tpm
if ! [ -e ~/.local/share/tmux/plugins/tpm ]; then
  echo "[tpm]start"
  git clone https://github.com/tmux-plugins/tpm ~/.local/share/tmux/plugins/tpm
  echo "[tpm]Don't forget installing tmux's plugin on tmux. Open tmux, press {prefix} + I."
  echo "[tpm]finish"
fi

# goenv
if [ -z "$(echo $(goenv versions | sed "/system/d"))" ]; then
  echo "[goenv]start"
  goenv install $(goenv install --list | grep "^\s*[0-9][0-9.]*[0-9]\s*$" | tail -1)
  goenv global $(goenv install --list | grep "^\s*[0-9][0-9.]*[0-9]\s*$" | tail -1)
  echo "[goenv]finish"
fi

# rustup
if ! command -v rustup &> /dev/null; then
  echo "[rustup]start"
  curl https://sh.rustup.rs -sSf | RUSTUP_INIT_SKIP_PATH_CHECK=yes sh
  rustup update stable
  echo "[rustup]finish"
fi

# pyenv
if [ -z "$(echo $(pyenv versions | sed "/system/d"))" ]; then
  echo "[pyenv]start"
  pyenv install $(pyenv install --list | grep "^\s*[2][0-9.]*[0-9]\s*$" | tail -1)
  pyenv install $(pyenv install --list | grep "^\s*[0-9][0-9.]*[0-9]\s*$" | tail -1) pyenv virtualenv $(pyenv install --list | grep "^\s*[2][0-9.]*[0-9]\s*$" | tail -1) py2 pyenv virtualenv $(pyenv install --list | grep "^\s*[0-9][0-9.]*[0-9]\s*$" | tail -1) py3 eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
  pyenv activate py2
  pip install --upgrade pip
  pyenv activate py3
  pip install --upgrade pip
  echo "[pyenv]finish"
fi

# rbenv
if [ -z "$(echo $(rbenv versions | sed "/system/d"))" ]; then
  echo "[rbenv]start"
  rbenv install $(rbenv install --list-all | grep "^\s*[0-9][0-9.]*[0-9]\s*$" | tail -1)
  rbenv global $(rbenv install --list-all | grep "^\s*[0-9][0-9.]*[0-9]\s*$" | tail -1)
  echo "[rbenv]finish"
fi

# n
if [ -z "$(echo $(n ls))" ]; then
  echo "[n]start"
  n latest
  echo "[n]finish"
fi

# lua5.1 luarocks
if ! type lua &> /dev/null; then
  echo "[lua5.1 luarocks]start"
  curl -LO https://www.lua.org/ftp/lua-5.1.5.tar.gz
  curl -LO https://luarocks.github.io/luarocks/releases/luarocks-3.11.1.tar.gz
  tar -zxf lua-5.1.5.tar.gz
  tar -zxf luarocks-3.11.1.tar.gz
  cd lua-5.1.5
  make macosx
  sudo make install
  cd ../luarocks-3.11.1
  ./configure --with-lua-include=/usr/local/include --with-lua-bin=/usr/local/bin/
  make
  sudo make install
  cd ../
  rm -rf lua-5.1.5.tar.gz lua-5.1.5 luarocks-3.11.1.tar.gz luarocks-3.11.1
  echo "[lua5.1 luarocks]finish"
fi

# neovim provider
if ! gem list | grep -q "neovim"; then
  echo "[neovim provider - ruby]start"
  gem install neovim
  echo "[neovim provider - ruby]finish"
fi

pyenv activate py2
if ! pip list 2> /dev/null | grep -q "neovim"; then
  echo "[neovim provider - python2]start"
  pyenv activate py2
  pip install neovim
  echo "[neovim provider - python2]finish"
fi

pyenv activate py3
if ! pip list 2> /dev/null | grep -q "neovim"; then
  echo "[neovim provider - python3]start"
  pyenv activate py3
  pip install neovim
  echo "[neovim provider - python3]finish"
fi

if ! npm ls -g | grep -q "neovim"; then
  echo "[neovim provider - nodejs]start"
  npm install -g neovim
  echo "[neovim provider - nodejs]finish"
fi

# git-cz
if ! command -v git-cz &> /dev/null; then
  echo "[git-cz]start"
  npm install -g git-cz
  echo "[git-cz]finish"
fi

echo "complete."
