# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# PATHの重複を避ける
typeset -gU PATH

# git
export PATH="/usr/local/bin/git:$PATH"

# goenv
# export GOENV_ROOT="$XDG_DATA_HOME/goenv"
# export PATH="$GOENV_ROOT/bin:$PATH"
# eval "$(goenv init -)"

# go
# export GOPATH="$HOME/go"
# export PATH="$GOPATH/bin:$PATH"

# rbenv
export RBENV_ROOT="$XDG_DATA_HOME/rbenv"
export PATH="$RBENV_ROOT/bin:$PATH"
eval "$(rbenv init -)"

# pyenv
export PYENV_ROOT="$XDG_DATA_HOME/pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# gem
# export GEM_HOME="$XDG_DATA_HOME/.gem"
# export GEM_SPEC_CACHE="$XDG_CACHE_HOME/.gem"

# bundler
# export BUNDLE_USER_HOME="$HOME/.bundle"
# export BUNDLE_USER_CONFIG="$XDG_CONFIG_HOME/.bundle"
# export BUNDLE_USER_CACHE="$XDG_CACHE_HOME/.bundle"
# export BUNDLE_USER_PLUGIN="$XDG_DATA_HOME/.bundle"

# エイリアス
alias vi='nvim'
alias ls='exa -a -F'
alias find='fd'
alias dc='docker-compose'
alias dce='docker-compose exec'
alias dcr='docker-compose run'

# Vim風キーバインド
bindkey -v

# 文字コード
export LANG=ja_JP.UTF-8

# プロンプト
autoload -Uz colors
colors
PROMPT="%{${fg[cyan]}%}[%~]%{${reset_color}%}"

# 補完有効化
autoload -Uz compinit
compinit -d "$XDG_CACHE_HOME/zsh/.zcompdump"
zstyle ':completion:*:default' menu select

# 履歴ファイルの保存先
export HISTFILE="$XDG_CACHE_HOME/zsh/.zsh_history"
export HISTSIZE=1000
export SAVEHIST=100000

# 開始と終了を記録
setopt EXTENDED_HISTORY

# ヒストリを共有
setopt inc_append_history
setopt share_history

# ヒストリを呼び出してから実行する前に編集可能
setopt hist_verify

# 重複コマンドを保存しない
setopt hist_ignore_dups

# ヒストリに追加されるコマンドが同じなら古い方を削除
setopt hist_ignore_all_dups

# 空白で始まるコマンドはヒストリから削除
setopt hist_ignore_space

# 余分な空白は詰めて記録
setopt hist_reduce_blanks

# historyコマンドは履歴に記録しない
setopt hist_no_store

# 補完時にヒストリを自動的に展開
setopt hist_expand

# 'cd' なしで移動する
setopt auto_cd
setopt auto_pushd

# 重複するディレクトリは記録しないようにする
setopt correct

# 'cd -' [tab] で以前移動したディレクトリに移動する
setopt pushd_ignore_dups

# 明確なドットの指定なしで.から始まるファイルをマッチ
setopt globdots

# tab補完を便利にする
# https://gihyo.jp/dev/serial/01/zsh-book/0005
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' '+m:{[:upper:]}={[:lower:]}'

# 移動した後は 'ls' する
# function chpwd() { ls -A -F }
function chpwd() { exa -a -F }

# fzf
[ -f ~/.config/fzf/.fzf.zsh ] && source ~/.config/fzf/.fzf.zsh
export IGNORE_ELEMENTS="-E .git -E node_modules -E .cache -E .DS_Store -E .localized -E .Trash"
export FZF_CTRL_T_COMMAND="fd --hidden --follow ${IGNORE_ELEMENTS}"
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --style=numbers,changes,header --line-range :100 {}'"
export FZF_ALT_C_COMMAND="fd -t d --hidden --follow ${IGNORE_ELEMENTS} . '${HOME}'"
export FZF_ALT_C_OPTS="--preview 'exa --long --all --git -I \".DS_Store|.localized\" {}'"

### Added by Zinit's installer
if [[ ! -f $HOME/.config/zsh/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.config/zsh/.zinit" && command chmod g-rwX "$HOME/.config/zsh/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.config/zsh/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.config/zsh/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit's installer chunk

### plugin
zinit ice depth=1; zinit light romkatv/powerlevel10k 
zinit ice wait'0'; zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
###

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#676e96,bg=cyan,bold,underline"
