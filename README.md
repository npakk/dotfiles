# dotfiles_for_desktop
## Win
powershellは管理者権限（powershell.ps1の実行がエラーになるため）
**事前に環境変数$HOMEにホームディレクトリ`C:\Users\ユーザ名`、$DOOMDIRにも`C:\Users\ユーザ名`を設定しておく**

[Scoop](https://scoop.sh/)
```ps1
# Scoopインストール
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression

# aria2のワーニングを表示させない
scoop config aria2-warning-enabled false

# 最低限必要なソフトウェアのインストール
scoop install aria2 git task

git clone https://github.com/npakk/dotfiles_for_desktop.git
cd dotfiles_for_desktop
task
```

[Doom](https://github.com/doomemacs/doomemacs/blob/master/docs/getting_started.org)
```ps1
git clone https://github.com/hlissner/doom-emacs $HOME/.emacs.d
cd $HOME/.emacs.d/bin
./doom install
```
アイコンが文字化けしている場合は、`M-x nerd-icons-install-fonts`を実行してttfファイルを任意のディレクトリにダウンロードして、手動インストール

## Mac
[Homebrew](https://brew.sh)
```sh
# Homebrewインストール
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo >> /Users/`whoami`/.zprofile
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/`whoami`/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

git clone https://github.com/npakk/dotfiles_for_desktop.git
cd dotfiles_for_desktop
make
```
---
以下のソフトウェアは手動でインストール
- 1Password
- ATOK
- Docker

Dockerのデタッチキーと衝突して Ctrl+p の入力が吸われるときは、`~/.docker/config.json`を以下のように修正  
> Winの場合、cmdやpwshを使っているなら`%USERPROFILE%\.docker\config.json`、wslなら`~/.docker/config.json`
```json
{
    "detachKeys": "ctrl-_"
}
```

alacrittyのwin設定はwin.tomlに書くこと
