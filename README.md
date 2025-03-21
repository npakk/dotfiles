## Mac
[Homebrew](https://brew.sh)
```sh
git clone https://github.com/npakk/dotfiles.git ~/dotfiles
cd ~/dotfiles
make
```

## Win
環境変数 `$HOME`と`$DOOMDIR`に`C:\Users\ユーザ名`を設定しておく

[Scoop](https://scoop.sh/)
```ps1
# 管理者権限のあるPowerShellで以下を実行（scripts/powershell.ps1のエラー回避）

# Scoopインストール
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression

# aria2のワーニングを表示させない
scoop config aria2-warning-enabled false

# 最低限必要なソフトウェアのインストール
scoop install aria2 git task

git clone https://github.com/npakk/dotfiles.git $HOME/dotfiles
cd $HOME/dotfiles
task
```

## Ubuntu on WSL2
```sh
# 環境変数
TZ=Asia/Tokyo
LANG=ja_JP.UTF-8
LANGUAGE=ja_JP:ja
LC_ALL=ja_JP.UTF-8
SHELL=/usr/bin/zsh
export TZ LANG LANGUAGE LC_ALL SHELL

# 各種ビルドに必要なパッケージを入手（Ubuntuのbrewで必要なもの https://docs.brew.sh/Homebrew-on-Linux#requirements）
sudo sed -i.bak -r 's@http://(jp\.)?archive\.ubuntu\.com/ubuntu/?@https://ftp.udx.icscoe.jp/Linux/ubuntu/@g' /etc/apt/sources.list && \
sudo apt-get update && \
sudo apt-get install -y --no-install-recommends zsh locales tzdata && \
sudo apt-get install -y --no-install-recommends build-essential procps curl file git && \ #for Homebrew
sudo apt-get install -y --no-install-recommends lua5.1 luarocks && \ #for Neovim
sudo apt-get install -y --no-install-recommends zlib1g-dev && \ #for rbenv
sudo apt-get install -y --no-install-recommends build-essential libgccjit-10-dev gcc-10 libtree-sitter-dev libgtk-3-dev libgnutls28-dev libjpeg-dev libtiff5-dev libgif-dev libxpm-dev libncurses-dev texinfo libjansson-dev libharfbuzz-dev libtree-sitter-dev libwebp-dev libxml2-dev autoconf sqlite3 libsqlite3-dev && \
sudo locale-gen ja_JP.UTF-8 en_US.UTF-8 && \
sudo apt-get clean && \
sudo rm -rf /var/lib/apt/lists/*

# Emacs
# /home/.local/share/fontsに使用するフォントファイルを配置しておくこと
export CC="gcc-10" && export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH &&\
echo "/usr/local/lib" | sudo tee /etc/ld.so.conf.d/tree-sitter.conf && sudo ldconfig &&\
git clone --depth 1 --branch emacs-29.4 https://github.com/emacs-mirror/emacs.git emacs &&\
cd emacs &&\
./autogen.sh &&\
./configure --with-native-compilation --with-json --with-tree-sitter --with-modules &&\
make -j$(nproc) && sudo make install

# ホストのorg-directoryをWSLとつなぐ
ln -s /mnt/c/Users/Npakk/Dropbox ~/Dropbox

# brewインストール
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# brewの警告に従い、以下を実行
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# ログインシェルを/usr/bin/zshに
chsh

# Macと一緒（graphviz用にulimitを変更）
ulimit -n 65536
git clone https://github.com/npakk/dotfiles.git ~/dotfiles
cd ~/dotfiles
make
ulimit -n 1024
```

---
[Doom](https://github.com/doomemacs/doomemacs/blob/master/docs/getting_started.org)
```ps1
git clone https://github.com/hlissner/doom-emacs $HOME/.emacs.d
cd $HOME/.emacs.d/bin
./doom install
```
アイコンが文字化けしている場合は、`M-x nerd-icons-install-fonts`を実行してダウンロードされるttfファイルをインストール。  
Macの場合はアプリケーションフォルダにEmacsアプリを追加する必要があるので、以下を実行する。
```sh
osascript -e 'tell application "Finder" to make alias file to posix file "/opt/homebrew/opt/emacs-plus@29/Emacs.app" at posix file "/Applications" with properties {name:"Emacs.app"}'
```

---
以下のソフトウェアは手動でインストール
- 1Password
- ATOK
- Docker

Dockerのデタッチキーと衝突して`Ctrl+p`の入力が吸われるときは、`~/.docker/config.json`を以下のように修正  
Winの場合は`%USERPROFILE%\.docker\config.json`、WSL環境なら`~/.docker/config.json`も
```json
{
    "detachKeys": "ctrl-_"
}
```
