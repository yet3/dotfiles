declare -A ZINIT 
ZINIT[HOME_DIR]="$ZCACHE/zinit"
ZINIT[BIN_DIR]="${ZINIT[HOME_DIR]}/zinit.git"
ZINIT[ZCOMPDUMP_PATH]="$ZCACHE/.zcompdump"
ZINIT[PLUGINS_DIR]="$ZCACHE/plugins"
ZINIT[COMPLETIONS_DIR]="$ZCACHE/completions"

[ ! -d ${ZINIT[HOME_DIR]} ] && mkdir -p "$(dirname ${ZINIT[HOME_DIR]})"
[ ! -d ${ZINIT[HOME_DIR]}/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "${ZINIT[HOME_DIR]}"
source "${ZINIT[HOME_DIR]}/zinit.zsh"
autoload -Uz _zinit
autoload -Uz compinit
compinit
(( ${+_comps} )) && _comps[zinit]=_zinit
