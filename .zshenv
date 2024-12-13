skip_global_compinit=1
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state/"
export ZDOTDIR="$HOME/.config/zsh"
export FPATH="$ZDOTDIR/autoload/:$FPATH"
export FPATH="$XDG_DATA_HOME/zsh/completions:${FPATH}"
# zsh-completions
export FPATH="$HOMEBREW_PREFIX/share/zsh-completions:${FPATH}"
. "$HOME/.cargo/env"
