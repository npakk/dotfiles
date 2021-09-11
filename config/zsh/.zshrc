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
export GOPATH=$HOME/go
export GOENV_ROOT="$XDG_DATA_HOME/goenv"
export PATH="$GOENV_ROOT/bin:$PATH"
eval "$(goenv init -)"

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
export GEM_HOME="$XDG_DATA_HOME/.gem"
export GEM_SPEC_CACHE="$XDG_CACHE_HOME/.gem"

# bundler
export BUNDLE_USER_HOME="$HOME/.bundle"
export BUNDLE_USER_CONFIG="$XDG_CONFIG_HOME/.bundle"
export BUNDLE_USER_CACHE="$XDG_CACHE_HOME/.bundle"
export BUNDLE_USER_PLUGIN="$XDG_DATA_HOME/.bundle"

# 文字コード
export LANG=ja_JP.UTF-8

# プロンプト
autoload -Uz colors
colors
PROMPT="%{${fg[cyan]}%}[%~]%{${reset_color}%}"
SPROMPT="correct: $RED%R$DEFAULT -> $GREEN%r$DEFAULT ? [Yes/No/Abort/Edit] => "

# autoload
autoload -Uz cd_ghq_on_fzf
autoload -Uz tmuxpopup

# エイリアス
alias v='nvim'
alias ls='exa -a -F -I ".DS_Store|.localized"'
alias ll='exa -a -F -l -I ".DS_Store|.localized"'
alias find='fd'
alias grep='rg'
alias g='git'
alias dc='docker-compose'
alias dce='docker-compose exec'
alias dcr='docker-compose run'
alias sd='cd_ghq_on_fzf'
alias info='info --vi-keys'
alias lg='lazygit'
alias rty='rtty run zsh -p 8080 -v --font "HackGen35Nerd Console" --font-size 18'

# 補完有効化
autoload -Uz compinit
compinit -d "$XDG_CACHE_HOME/zsh/.zcompdump"
zstyle ':completion:*:default' menu select interactive

# 補完候補のカラーリング
zstyle ':completion:*' list-colors "${LS_COLORS}"

# 補完時に大文字小文字を区別しない
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' '+m:{[:upper:]}={[:lower:]}'

# gitの補完を有効化
export FPATH="$(brew --prefix)/share/zsh/site-functions:$FPATH"
eval "$(gh completion -s zsh)"

# Vim風キーバインド
bindkey -v

# 補完キーバインド
zmodload zsh/complist                                         # "bindkey -M menuselect"設定できるようにするためのモジュールロード
bindkey -v '^a' beginning-of-line                             # 行頭へ(menuselectでは補完候補の先頭へ)
bindkey -v '^b' backward-char                                 # 1文字左へ(menuselectでは補完候補1つ左へ)
bindkey -v '^e' end-of-line                                   # 行末へ(menuselectでは補完候補の最後尾へ)
bindkey -v '^f' forward-char                                  # 1文字右へ(menuselectでは補完候補1つ右へ)
bindkey -v '^h' backward-delete-char                          # 1文字削除(menuselectでは絞り込みの1文字削除)
bindkey -v '^d' delete-char                                   # 前方1文字削除(menuselectでは絞り込みの1文字削除)
bindkey -v '^i' expand-or-complete                            # 補完開始
bindkey -M menuselect '^g' .send-break                        # send-break2回分の効果
bindkey -M menuselect '^i' forward-char                       # 補完候補1つ右へ
bindkey -M menuselect '^j' .accept-line                       # accept-line2回分の効果
bindkey -M menuselect '^k' accept-and-infer-next-history      # 次の補完メニューを表示する
bindkey -M menuselect '^n' down-line-or-history               # 補完候補1つ下へ
bindkey -M menuselect '^p' up-line-or-history                 # 補完候補1つ上へ
bindkey -M menuselect '^r' history-incremental-search-forward # 補完候補内インクリメンタルサーチ

# 履歴ファイルの保存先
export HISTFILE="$XDG_CACHE_HOME/zsh/.zsh_history"
export HISTSIZE=1000
export SAVEHIST=100000

# 補完候補を詰めて表示
setopt list_packed

# コマンドのスペルチェックをする
setopt correct

# 補完の可能性のあるものを列挙し、最初にマッチしたものをすぐに挿入
setopt menu_complete

# Ctrl-dで終了しない
setopt ignoreeof

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

# 履歴検索中、(連続してなくとも)重複を飛ばす
setopt hist_find_no_dups

# 余分な空白は詰めて記録
setopt hist_reduce_blanks

# historyコマンドは履歴に記録しない
setopt hist_no_store

# 補完時にヒストリを自動的に展開
setopt hist_expand

# 'cd' なしで移動する
setopt auto_cd

# 'cd -' [tab] で以前移動したディレクトリに移動する
setopt auto_pushd

# 移動した後は 'ls' する
function chpwd() { exa -a -F -I ".DS_Store|.localized" }

# 重複するディレクトリはpushdに記録しないようにする
setopt pushd_ignore_dups

# 明確なドットの指定なしで.から始まるファイルをマッチ
setopt globdots

# fzf
[ -f ~/.config/fzf/.fzf.zsh ] && source ~/.config/fzf/.fzf.zsh
export IGNORE_ELEMENTS="-E .git -E node_modules -E .cache -E \"*cache*\" -E .DS_Store -E .localized -E .Trash -E Library -E Documents -E Downloads -E Applications -E Pictures -E Movies"
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
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
###

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#676e96,bg=cyan,bold,underline"
