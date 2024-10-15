export ZDOTDIR="$HOME/.config/zsh"
export ZSH_CACHE_DIR="$ZDOTDIR/.cache"
export HISTFILE="$ZSH_CACHE_DIR/.zsh_history"

export ZSH_EVALCACHE_DIR="$ZSH_CACHE_DIR/.zsh-evalcache"
source "$ZDOTDIR/plugins/evalcache/evalcache.plugin.zsh"

[[ -f ${ZDOTDIR}/.options ]] && source ${ZDOTDIR}/.options

_evalcache /opt/homebrew/bin/brew shellenv
_evalcache fnm env
_evalcache starship init zsh

source "$ZDOTDIR/antidote.zsh"
source "$ZDOTDIR/paths.zsh"
source "$ZDOTDIR/vars.zsh"
source "$ZDOTDIR/aliases.zsh" 

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

