#!/usr/bin/env zsh

# Homebrew
ln -sf ~/dotfiles/home/Brewfile ~/Brewfile

echo -n "Do you want to run the installation process?(y/N):"
if read -q && echo; then
  if ! command -v brew &> /dev/null; then
    echo "[Homebrew]start"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo "[Homebrew]finish"
  fi

  brew bundle --file "$HOME/Brewfile"
  brew bundle cleanup --force --file "$HOME/Brewfile"
  brew update
  brew upgrade
  brew cleanup

  # fzf
  if ! echo $PATH | grep -q "fzf"; then
    echo "[fzf]start"
    $(brew --prefix)/opt/fzf/install
    echo "[fzf]finish"
  fi

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
    pyenv install $(pyenv install --list | grep "^\s*[0-9][0-9.]*[0-9]\s*$" | tail -1)
    pyenv virtualenv $(pyenv install --list | grep "^\s*[2][0-9.]*[0-9]\s*$" | tail -1) py2
    pyenv virtualenv $(pyenv install --list | grep "^\s*[0-9][0-9.]*[0-9]\s*$" | tail -1) py3
    eval "$(pyenv init -)"
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
    n
    echo "[n]finish"
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

  if ! yarn global list | grep -q "neovim"; then
    echo "[neovim provider - nodejs]start"
    yarn global add neovim
    echo "[neovim provider - nodejs]finish"
  fi

  # textlint
  if ! command -v textlint &> /dev/null; then
    echo "[textlint]start"
    yarn global add textlint
    yarn global add textlint-rule-preset-ja-technical-writing textlint-rule-preset-jtf-style textlint-rule-prh textlint-rule-max-ten textlint-rule-spellcheck-tech-word textlint-rule-no-mix-dearu-desumasu textlint-rule-preset-ja-spacing
    echo "[textlint]finish"
  fi

  # git-cz
  if ! command -v git-cz &> /dev/null; then
    echo "[git-cz]start"
    yarn global add git-cz
    echo "[git-cz]finish"
  fi

  # gcloud cli
  if ! gcloud config list 2> /dev/null  | grep -q "account"; then
    echo "[gcloud]start"
    gcloud init
    echo "[gcloud]finish"
  fi

else
  echo
fi

# don't show terminal last login message
touch "${HOME}/.hushlogin"

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

# karabiner-elements
mkdir -p ~/.config/karabiner
ln -sf ~/dotfiles/config/karabiner/karabiner.json ~/.config/karabiner/karabiner.json
ln -snf ~/dotfiles/config/karabiner/assets ~/.config/karabiner/assets

# iTerm2
mkdir -p ~/.config/iTerm2
ln -sf ~/dotfiles/config/iTerm2/com.googlecode.iterm2.plist ~/.config/iTerm2/com.googlecode.iterm2.plist

# Alacritty
mkdir -p ~/.config/alacritty
ln -sf ~/dotfiles/config/alacritty/alacritty.toml ~/.config/alacritty/alacritty.toml

# tmux
mkdir -p ~/.config/tmux
ln -sf ~/dotfiles/config/tmux/tmux.conf ~/.config/tmux/tmux.conf
ln -sf ~/dotfiles/config/tmux/default.session.conf ~/.config/tmux/default.session.conf

# neovim
mkdir -p ~/.config/nvim
ln -sf ~/dotfiles/config/nvim/init.lua ~/.config/nvim/init.lua
ln -snf ~/dotfiles/config/nvim/after ~/.config/nvim/after
ln -snf ~/dotfiles/config/nvim/spell ~/.config/nvim/spell
ln -snf ~/dotfiles/config/nvim/lua ~/.config/nvim/lua
ln -snf ~/dotfiles/config/nvim/snippets ~/.config/nvim/snippets
ln -sf ~/dotfiles/config/nvim/stylua.toml ~/.config/nvim/stylua.toml
ln -sf ~/dotfiles/config/nvim/selene.toml ~/.config/nvim/selene.toml
ln -sf ~/dotfiles/config/nvim/vim.toml ~/.config/nvim/vim.toml

# textlint
ln -sf ~/dotfiles/home/.textlintrc ~/.textlintrc

source ~/.zshenv
source ~/.config/zsh/.zshrc
echo "complete."
