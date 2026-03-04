#!/bin/bash

source $TMUX_SESSIONS_DIR/lib/attach-switch.sh;
source $TMUX_SESSIONS_DIR/lib/session-exists.sh;

SESSION_NAME="nvim";
NVIM_DIR=~/.config/nvim

if session-exists $SESSION_NAME; then
  attach-switch $SESSION_NAME;
else
  tmux new-session -d -s $SESSION_NAME -c $NVIM_DIR -n 'editor' "/bin/sh -c 'nvim ./init.lua; exec zsh'";

  tmux new-window -t $SESSION_NAME -d -c $NVIM_DIR -n 'term';

  attach-switch $SESSION_NAME;
fi
