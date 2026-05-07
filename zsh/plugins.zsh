export ZSH_EVALCACHE_DIR="$ZCACHE/evalcache"
zi light mroth/evalcache/

zi ice wait lucid notrack
zi light hlissner/zsh-autopair

zi ice wait lucid notrack atload"_zsh_autosuggest_start"
zi light zsh-users/zsh-autosuggestions

zi ice svn pick"plugins/completion/completion.plugin.zsh"
zi light mattmc3/zephyr

zi ice wait lucid notrack
zi light zdharma-continuum/fast-syntax-highlighting

zi ice wiat lucid notrack as"command" from"gh-r" \
          atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
          atpull"%atclone" src"init.zsh"
zi light starship/starship
