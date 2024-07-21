# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

typeset -gU PATH            # PATHの重複回避
export LANG=ja_JP.UTF-8

setopt list_packed          # 補完候補を詰めて表示
setopt correct              # コマンドのスペルチェックをする
setopt menu_complete        # 補完の可能性があるものを列挙し、最初にマッチしたものをすぐに挿入
setopt ignoreeof            # Ctrl-dで終了しない
setopt EXTENDED_HISTORY     # 開始と終了を記録
# setopt inc_append_history   # ヒストリを共有
setopt share_history        # ヒストリを共有(他のセッションでのヒストリも含める)
setopt hist_verify          # ヒストリを呼び出してから実行する前に編集可能
setopt hist_ignore_dups     # 重複コマンドを保存しない
setopt hist_ignore_all_dups # ヒストリに追加されるコマンドが同じなら古い方を削除
setopt hist_ignore_space    # 空白で始まるコマンドはヒストリから削除
setopt hist_find_no_dups    # 履歴検索中、(連続してなくとも)重複を飛ばす
setopt hist_reduce_blanks   # 余分な空白は詰めて記録
setopt hist_no_store        # historyコマンドは履歴に記録しない
setopt hist_expand          # 補完時にヒストリを自動的に展開
setopt auto_cd              # 'cd' なしで移動する
setopt auto_pushd           # 'cd -' [tab] で以前移動したディレクトリに移動する
setopt pushd_ignore_dups    # 重複するディレクトリはpushdに記録しないようにする
setopt globdots             # 明確なドットの指定なしで.から始まるファイルをマッチ

alias rm='trash'
alias v='nvim'
alias j='z'
alias ls='eza -a -F -I ".DS_Store|.localized"'
alias ll='eza -a -F -l -I ".DS_Store|.localized"'
alias find='fd'
alias grep='rg'
alias g='git'
alias dc='docker-compose'
alias dce='docker-compose exec'
alias dcr='docker-compose run'
alias sd='cd_ghq_on_fzf'
alias swf='switch_fontsize'
alias info='info --vi-keys'
alias lg='lazygit'
alias rty='rtty run zsh -p 8080 -v --font "HackGen35Nerd Console" --font-size 18'

autoload -Uz cd_ghq_on_fzf
autoload -Uz tmuxpopup
autoload -Uz switch_fontsize

# 移動した後は 'ls' する
function chpwd() { eza -a -F -I ".DS_Store|.localized" }

# history
export HISTFILE="$XDG_CACHE_HOME/zsh/.zsh_history"
export HISTSIZE=1000
export SAVEHIST=100000

# completion
autoload -Uz compinit
compinit -Cd "$XDG_CACHE_HOME/zsh/.zcompdump"
zstyle ':completion:*:default' menu select interactive
zstyle ':completion:*' list-colors "${LS_COLORS}"
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' '+m:{[:upper:]}={[:lower:]}'

# GitHub CLI completion
export FPATH="$(brew --prefix)/share/zsh/site-functions:$FPATH"
eval "$(gh completion -s zsh)"

bindkey -v                                                    # Vim風キーバインド
bindkey -v '^a' beginning-of-line                             # 行頭へ(menuselectでは補完候補の先頭へ)
bindkey -v '^b' backward-char                                 # 1文字左へ(menuselectでは補完候補1つ左へ)
bindkey -v '^e' end-of-line                                   # 行末へ(menuselectでは補完候補の最後尾へ)
bindkey -v '^f' forward-char                                  # 1文字右へ(menuselectでは補完候補1つ右へ)
# bindkey -v '^h' backward-delete-char                          # 1文字削除(menuselectでは絞り込みの1文字削除)
bindkey -v '^d' delete-char                                   # 前方1文字削除(menuselectでは絞り込みの1文字削除)
bindkey -v '^i' expand-or-complete                            # 補完開始

# completion bindkey
zmodload zsh/complist                                         # "bindkey -M menuselect"設定できるようにするためのモジュールロード
bindkey -M menuselect '^i' forward-char                       # 補完候補1つ右へ
bindkey -M menuselect '^g' .send-break                        # send-break2回分の効果
# bindkey -M menuselect '^j' .accept-line                       # accept-line2回分の効果
# bindkey -M menuselect '^k' accept-and-infer-next-history      # 次の補完メニューを表示する
bindkey -M menuselect '^n' down-line-or-history               # 補完候補1つ下へ
bindkey -M menuselect '^p' up-line-or-history                 # 補完候補1つ上へ
bindkey -M menuselect '^r' history-incremental-search-forward # 補完候補内インクリメンタルサーチ

function _left-pane() {
  tmux select-pane -L
}
zle -N left-pane _left-pane

function _down-pane() {
  tmux select-pane -D
}
zle -N down-pane _down-pane

function _up-pane() {
  tmux select-pane -U
}
zle -N up-pane _up-pane

function _right-pane() {
  tmux select-pane -R
}
zle -N right-pane _right-pane

function _backspace-or-left-pane() {
  if [[ $#BUFFER -gt 0 ]]; then
    zle backward-delete-char
  elif [[ ! -z ${TMUX} ]]; then
    zle left-pane
  fi
}
zle -N backspace-or-left-pane _backspace-or-left-pane

function _kill-line-or-up-pane() {
  if [[ $#BUFFER -gt 0 ]]; then
    zle kill-line
  elif [[ ! -z ${TMUX} ]]; then
    zle up-pane
  fi
}
zle -N kill-line-or-up-pane _kill-line-or-up-pane

function _accept-line-or-down-pane() {
  if [[ $#BUFFER -gt 0 ]]; then
    zle accept-line
  elif [[ ! -z ${TMUX} ]]; then
    zle down-pane
  fi
}
zle -N accept-line-or-down-pane _accept-line-or-down-pane

function _clear-screen-or-right-pane() {
  if [[ $#BUFFER -gt 0 ]]; then
    zle clear-screen
  elif [[ ! -z ${TMUX} ]]; then
    zle right-pane
  fi
}
zle -N clear-screen-or-right-pane _clear-screen-or-right-pane

bindkey '^k' kill-line-or-up-pane
bindkey '^l' clear-screen-or-right-pane
bindkey '^h' backspace-or-left-pane
bindkey '^j' accept-line-or-down-pane

# goenv
export GOPATH=$HOME/go
export GOENV_ROOT="$XDG_DATA_HOME/goenv"
export PATH="$GOENV_ROOT/bin:$PATH"
export PATH="$GOENV_ROOT/shims:$PATH"
goenv() {
  unfunction "$0"
  eval "$(goenv init -)"
  $0 "$@"
}

# pyenv
export PYENV_ROOT="$XDG_DATA_HOME/pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export PATH="$PYENV_ROOT/shims:${PATH}"
pyenv() {
  unfunction "$0"
  eval "$(pyenv init --path)"
  if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
  fi
  $0 "$@"
}

# rbenv
export RBENV_ROOT="$XDG_DATA_HOME/rbenv"
export PATH="$RBENV_ROOT/bin:$PATH"
export PATH="$RBENV_ROOT/shims:${PATH}"
rbenv() {
  unfunction "$0"
  eval "$(rbenv init -)"
  $0 "$@"
}

# gem
export GEM_HOME="$XDG_DATA_HOME/.gem"
export GEM_SPEC_CACHE="$XDG_CACHE_HOME/.gem"

# bundler
export BUNDLE_USER_HOME="$HOME/.bundle"
export BUNDLE_USER_CONFIG="$XDG_CONFIG_HOME/.bundle"
export BUNDLE_USER_CACHE="$XDG_CACHE_HOME/.bundle"
export BUNDLE_USER_PLUGIN="$XDG_DATA_HOME/.bundle"

# n
export N_PREFIX="$XDG_DATA_HOME/n"
export PATH="$N_PREFIX/bin:$PATH"

# rustup
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export CARGO_HOME="$HOME/.cargo"
export PATH="$CARGO_HOME/bin:$PATH"

# git
export PATH="/usr/local/bin/git:$PATH"

# sbin
# for brew warning. see https://qiita.com/FrogWoman/items/7c0fdaa7550dc5895a33
export PATH="/usr/local/sbin:$PATH"

# z
. `brew --prefix`/etc/profile.d/z.sh

# fzf
[ -f ${XDG_CONFIG_HOME}/fzf/.fzf.zsh ] && source ${XDG_CONFIG_HOME}/fzf/.fzf.zsh
export IGNORE_ELEMENTS="-E .git -E node_modules -E .cache -E \"*cache*\" -E .DS_Store -E .localized -E .Trash -E Library -E Documents -E Downloads -E Applications -E Pictures -E Movies"
export FZF_CTRL_T_COMMAND="fd --hidden --follow ${IGNORE_ELEMENTS}"
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --style=numbers,changes,header --line-range :100 {}'"
export FZF_ALT_C_COMMAND="fd -t d --hidden --follow ${IGNORE_ELEMENTS} . '${HOME}'"
export FZF_ALT_C_OPTS="--preview 'eza --long --all --git -I \".DS_Store|.localized\" {}'"

# zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zinit ice depth=1; zinit light romkatv/powerlevel10k 
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions

# To customize prompt, run `p10k configure` or edit ~/dotfiles/config/zsh/.p10k.zsh.
[[ ! -f ~/dotfiles/config/zsh/.p10k.zsh ]] || source ~/dotfiles/config/zsh/.p10k.zsh
