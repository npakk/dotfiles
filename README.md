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
sudo sed -i.bak -r 's@http://(jp\.)?archive\.ubuntu\.com/ubuntu/?@https://ftp.udx.icscoe.jp/Linux/ubuntu/@g' /etc/apt/sources.list &&\
sudo apt-get update && sudo apt-get install -y --no-install-recommends build-essential procps curl file git zsh lua5.1 luarocks locales tzdata &&\
sudo locale-gen ja_JP.UTF-8 en_US.UTF-8 &&\
sudo apt-get clean &&\
sudo rm -rf /var/lib/apt/lists/*

# brewインストール
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# brewの警告に従い、以下を実行
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
brew install gcc

# brewの警告が出ないか確認しておく
brew doctor

# ログインシェルを/usr/bin/zshに
chsh

# Macと一緒
git clone https://github.com/npakk/dotfiles.git ~/dotfiles
cd ~/dotfiles
make
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
