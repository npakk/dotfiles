## Mac
[Homebrew](https://brew.sh)
```sh
git clone https://github.com/npakk/dotfiles.git ~/dotfiles
cd ~/dotfiles
make
```

## Win
ユーザー環境変数 `$HOME`に`C:\Users\ユーザ名`、`$DOOMDIR`に`C:\Users\ユーザ名\.doom.d`を設定しておく

[Scoop](https://scoop.sh/)
```ps1
# Scoopインストール
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression

# aria2のワーニングを表示させない
scoop config aria2-warning-enabled false

# 最低限必要なソフトウェアのインストール
scoop install aria2 git task

# 管理者権限のあるPowerShellで以下を実行（scripts/powershell.ps1のエラー回避）
git clone https://github.com/npakk/dotfiles.git $HOME/dotfiles
cd $HOME/dotfiles
task
```

## Ubuntu on WSL2
```sh
# 環境変数
TZ=Asia/Tokyo
LANG=en_US.UTF-8
LANGUAGE=en_US:en
LC_ALL=en_US.UTF-8
SHELL=/usr/bin/zsh
export TZ LANG LANGUAGE LC_ALL SHELL

# 各種ビルドに必要なパッケージを入手（Ubuntuのbrewで必要なもの https://docs.brew.sh/Homebrew-on-Linux#requirements）
sudo sed -i.bak -r 's@http://(jp\.)?archive\.ubuntu\.com/ubuntu/?@https://ftp.udx.icscoe.jp/Linux/ubuntu/@g' /etc/apt/sources.list && \
sudo apt-get update && \
sudo apt-get install -y --no-install-recommends zsh locales tzdata && \
sudo apt-get install -y --no-install-recommends build-essential procps curl file git && \ #for Homebrew
sudo apt-get install -y --no-install-recommends lua5.1 luarocks && \ #for Neovim
sudo apt-get install -y --no-install-recommends inotify-tools && \ #for Neovim LSP
sudo apt-get install -y --no-install-recommends zlib1g-dev && \ #for rbenv
sudo locale-gen ja_JP.UTF-8 en_US.UTF-8 && \
sudo apt-get clean && \
sudo rm -rf /var/lib/apt/lists/*

# brewインストール
NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# brewの警告に従い、以下を実行
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# ログインシェルを/usr/bin/zshに
chsh

# Macと一緒（graphviz用にulimitを変更）
ulimit -n 65536
git clone https://github.com/npakk/dotfiles.git ~/dotfiles
cd ~/dotfiles
make

# ホストのDropboxへのシンボリックリンクを貼る
ln -s "/mnt/c/Users/$(powershell.exe '$env:USERNAME' | tr -d '\r')/Dropbox/" ~/Dropbox
```
もし環境を初期化する場合は設定 → アプリ → ディストリビューションの詳細オプション → リセット を行い、powershell上で`wsl --unregister Ubuntu`を実行。  
その後ディストリビューションを実行して初期化が完了したら、powershell上で`wsl --set-default Ubuntu`を実行。 

---
## Build Emacs for Windows 64bit with Native Compilation
references  
[Build Emacs for Windows 64bit with Native Compilation.md](https://gist.github.com/nauhygon/f3b44f51b34e89bc54f8)  
[How to Compile Emacs 29 From Source on Windows in 2022](https://readingworldmagazine.com/emacs/2022-02-24-compiling-emacs-29-from-source-on-windows/)  

[MSYS2](https://www.msys2.org)をダウンロード  
MSYS2 MINGW64を起動し以下を実行  
```sh
# アップデート
pacman -Syu --noconfirm

# Restart
```

```sh
pacman -Sy --noconfirm

# 必要なパッケージをインストール
pacman -Su --noconfirm \
autoconf autogen automake automake-wrapper make git pkgconf texinfo \
mingw-w64-x86_64-libgccjit mingw-w64-x86_64-gnutls mingw-w64-x86_64-imagemagick \
mingw-w64-x86_64-graphviz mingw-w64-x86_64-libtree-sitter

# Restart
```

```sh
pacman -Su --noconfirm

git clone https://github.com/emacs-mirror/emacs.git build-emacs
cd build-emacs
git config core.autocrlf false
./autogen.sh
./configure --prefix=/c/emacs --with-native-compilation --with-imagemagick --with-tree-sitter --without-dbus --without-pop
make -j$(nproc)
make install prefix=/c/emacs

cd ../
rm -rf build-emacs
```
PATHに `C:\msys64\mingw64\bin` を追加  
PATHに `C:\emacs\bin` を追加

## Doom Emacs
[Doom Emacs](https://github.com/doomemacs/doomemacs/blob/master/docs/getting_started.org)
```sh
# .emacs.dフォルダは事前に削除しておく
git clone --depth 1 https://github.com/doomemacs/doomemacs $HOME/.emacs.d
cd $HOME/.emacs.d/bin
./doom install
./doom sync
```
アイコンが文字化けしている場合は、`M-x nerd-icons-install-fonts`を実行してダウンロードされるttfファイルをインストール。  
Winの場合は`doom upgrade`時に`pwsh`(powershell6以上)を求められるので、[リリースページ](https://github.com/PowerShell/PowerShell)からインストールする。  
Macの場合はアプリケーションフォルダにEmacsアプリを追加する必要があるので、以下を実行する。
```sh
osascript -e 'tell application "Finder" to make alias file to posix file "/opt/homebrew/opt/emacs-plus@30/Emacs.app" at posix file "/Applications" with properties {name:"Emacs.app"}'
```

## textlint on Win
```sh
nvm install lts
nvm use lts

npm install -g --no-fund `
  textlint `
  textlint-filter-rule-allowlist `
  textlint-rule-preset-ja-technical-writing `
  textlint-rule-preset-jtf-style `
  textlint-rule-preset-ja-spacing `
  textlint-rule-spellcheck-tech-word `
  textlint-rule-prh `
  @proofdict/textlint-rule-proofdict
```

---
以下のソフトウェアは手動でインストール
- 1Password
- ATOK
- Docker
- Alacritty（Macのみ。Homebrewでdeprecatedとなったため）

tmuxのプレフィックス`Ctrl+\`が1Passwordの自動入力と衝突するため、1Passwordの設定から自動入力のショートカットを削除する。

Dockerのデタッチキーと衝突して`Ctrl+p`の入力が吸われるときは、`~/.docker/config.json`を以下のように修正  
Winの場合は`%USERPROFILE%\.docker\config.json`、WSL環境なら`~/.docker/config.json`も
```json
{
    "detachKeys": "ctrl-_"
}
```
