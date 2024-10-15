#!/bin/zsh

alias ls="eza --icons"

alias ..="cd .."
alias cd..="cd .."

alias home="cd ~"
alias config="cd ~/.config"
alias dev="cd ~/dev/"
alias vim="nvim"
alias pn="pnpm"

alias notes="cd $NOTES_ROOT/"
alias notes-m="cd $NOTES_ROOT/Main/"

alias tmux-e="cd $HOME/.config/tmux/ && nvim ./tmux.conf"
alias tmux-cd="cd $HOME/.config/tmux/"

alias kitty-r="kill -SIGUSR1 $(pgrep -a kitty)"
alias kitty-e="cd $HOME/.config/kitty && nvim ./kitty.conf"
alias kitty-cd="cd $HOME/.config/kitty"

alias nvim-e="cd $HOME/.config/nvim && nvim ./init.lua"
alias nvim-cd="cd $HOME/.config/nvim"

alias zsh-r="source $HOME/.config/zsh/.zshrc"
alias zsh-e="cd $HOME/.config/zsh && nvim ./.zshrc"
alias zsh-cd="cd $HOME/.config/zsh"

alias todo="nvim $HOME/dev/TODO.md"

