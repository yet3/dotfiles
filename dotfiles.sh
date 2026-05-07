#!/usr/bin/env bash 

declare -A LINKS
LINKS["shortie"]="
  '$HOME/dotfiles/shortie' 
  '$HOME/.config/shortie'
"
LINKS["neovim"]="
  '$HOME/dotfiles/nvim' 
  '$HOME/.config/nvim'
"
LINKS["zsh"]="
  '$HOME/dotfiles/zsh' 
  '$HOME/.config/zsh'
"
LINKS["zshrc"]="
  '$HOME/dotfiles/zsh/init.zsh' 
  '$HOME/.zshrc'
"
LINKS["starship"]="
  '$HOME/dotfiles/starship/starship.toml' 
  '$HOME/.config/starship.toml'
"
LINKS["mise"]="
  '$HOME/dotfiles/mise' 
  '$HOME/.config/mise'
"
LINKS["tmux"]="
  '$HOME/dotfiles/tmux' 
  '$HOME/.config/tmux'
"
LINKS["ghostty"]="
  '$HOME/dotfiles/ghostty' 
  '$HOME/.config/ghostty'
"

# ========== Commands ========== #

setup() {
  new_links=0
  old_links=0
  for key in "${!LINKS[@]}"; do
    eval "arr=(${LINKS[$key]})"
    parts=("${arr[@]}")
    src=${parts[0]}
    target=${parts[1]}

    if [ -e "$target" ]; then
      ((old_links++))
      echo "[$key] '$src' -> '$target' symlink SKIPPED"
    else
      if [ ! -e "$src" ]; then
        echo "[$key] '$src' doesn't exist ERROR"
      else
        ln -s "$src" "$target"
        ((new_links++))
        echo "[$key] '$src' -> '$target' symlink CREATED"
      fi
    fi
  done
  echo "Dotfiles symlinks setup finished! created: $new_links; existing: $old_links"
}

cleanup() {
  removed_links=0
  for key in "${!LINKS[@]}"; do
    eval "arr=(${LINKS[$key]})"
    parts=("${arr[@]}")
    src=${parts[0]}
    target=${parts[1]}

    if [ ! -L "$target" ]; then
      echo "[$key] '$target' is not a symlink"
    else
      rm -rf "$target"
      ((removed_links++))
      echo "[$key] '$src' -> '$target' symlink REMOVED"
    fi
  done
  echo "Dotfiles symlinks cleanup finished! removed: $removed_links"
}

if [ "$1" == "setup" ]; then
  setup
elif [ "$1" == "cleanup" ]; then
  cleanup
else
  echo "Valid arguments: 'setup', 'cleanup'"
fi


