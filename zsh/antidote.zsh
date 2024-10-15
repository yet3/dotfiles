export ANTIDOTE_HOME=$ZSH_CACHE_DIR/plugins

zstyle ':antidote:compatibility-mode' 'antibody' 'on'
zstyle ':antidote:bundle' use-friendly-names 'yes'

antidote_dir=$ZSH_CACHE_DIR/.antidote
[[ -d $antidote_dir ]] ||
  git clone --depth=1 https://github.com/mattmc3/antidote $antidote_dir

antidote_plugins=${ZDOTDIR}/zsh_plugins.txt
antidote_bundle=${ZSH_CACHE_DIR}/plugins_bundle.zsh

[[ -f $antidote_plugins ]] || touch $antidote_plugins

fpath=($antidote_dir/functions $fpath)
autoload -Uz antidote

if [[ ! $antidote_bundle -nt $antidote_plugins ]]; then
  antidote bundle <$antidote_plugins >|$antidote_bundle
fi
source $antidote_bundle
