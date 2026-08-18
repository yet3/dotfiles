export ZDIR="$HOME/dotfiles/zsh"
export ZBIN="$HOME/dotfiles/zsh/init.zsh"
export ZCACHE="$ZDIR/.cache"

# ====== Core ====== #
source "$ZDIR/options.zsh"
source "$ZDIR/plugin-manager.zsh"
source "$ZDIR/plugins.zsh"
source "$ZDIR/paths.zsh"
source "$ZDIR/aliases.zsh" 
# ================== #

# ====== Tools ====== #
_evalcache /opt/homebrew/bin/brew shellenv
_evalcache mise activate zsh
shortie start --silent

sdk() {
  unfunction sdk
  export SDKMAN_DIR="$HOME/.sdkman"
  [[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && \
    source "$SDKMAN_DIR/bin/sdkman-init.sh"
  sdk "$@"
}
# =================== #
# zprof


# ============================= #
# ========= Generated ========= #
# ============================= #

# bun completions
[ -s "/Users/yet3/.bun/_bun" ] && source "/Users/yet3/.bun/_bun"

# Load Angular CLI autocompletion.
source <(ng completion script)


# pnpm
export PNPM_HOME="/Users/yet3/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME/bin:"*) ;;
  *) export PATH="$PNPM_HOME/bin:$PATH" ;;
esac
# pnpm end
