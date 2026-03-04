export ZDIR="$HOME/.config/zsh"
export ZBIN="$HOME/.config/zsh/init.zsh"
export ZCACHE="$ZDIR/.cache"

# ====== Core ====== #
source "$ZDIR/plugin-manager.zsh"
source "$ZDIR/plugins.zsh"
source "$ZDIR/options.zsh"
source "$ZDIR/paths.zsh"
source "$ZDIR/aliases.zsh" 
# ================== #

# ====== Tools ====== #
_evalcache /opt/homebrew/bin/brew shellenv
_evalcache mise activate zsh
# =================== #


# ============================= #
# ========= Generated ========= #
# ============================= #

# bun completions
[ -s "/Users/yet3/.bun/_bun" ] && source "/Users/yet3/.bun/_bun"

# Load Angular CLI autocompletion.
source <(ng completion script)

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
