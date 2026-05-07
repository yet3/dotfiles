declare -A ZINIT 
ZINIT[HOME_DIR]="$ZCACHE/zinit"
ZINIT[BIN_DIR]="${ZINIT[HOME_DIR]}/zinit.git"
ZINIT[ZCOMPDUMP_PATH]="$ZCACHE/.zcompdump"
ZINIT[PLUGINS_DIR]="$ZCACHE/plugins"
ZINIT[COMPLETIONS_DIR]="$ZCACHE/completions"

[ ! -d ${ZINIT[HOME_DIR]} ] && mkdir -p "$(dirname ${ZINIT[HOME_DIR]})"
[ ! -d ${ZINIT[HOME_DIR]}/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "${ZINIT[HOME_DIR]}"
source "${ZINIT[HOME_DIR]}/zinit.zsh"

autoload -Uz compinit

if [[ -n ${ZCACHE}/.zcompdump(#qN.mh+24) ]]; then
  compinit -d "${ZCACHE}/.zcompdump"
else
  compinit -C -d "${ZCACHE}/.zcompdump"
fi

autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
