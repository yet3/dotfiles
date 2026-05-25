#!/usr/bin/env bash 

DOTFILES="$HOME/dotfiles"
CONFIG="$HOME/.config"
EDITOR="nvim"

source "$DOTFILES/scripts/dotfiles-lib.sh"

#    "name"      "source"                           "target"
link "shortie"   "$DOTFILES/shortie"                "$CONFIG/shortie"
link "neovim"    "$DOTFILES/nvim"                   "$CONFIG/nvim"
link "zsh"       "$DOTFILES/zsh"                    "$CONFIG/zsh"
link "zshrc"     "$DOTFILES/zsh/init.zsh"           "$HOME/.zshrc"
link "starship"  "$DOTFILES/starship/starship.toml" "$CONFIG/starship.toml"
link "mise"      "$DOTFILES/mise"                   "$CONFIG/mise"
link "tmux"      "$DOTFILES/tmux"                   "$CONFIG/tmux"

run $1
