#!/bin/bash

source $TMUX_SESSIONS_DIR/lib/attach-switch.sh;
source $TMUX_SESSIONS_DIR/lib/session-exists.sh;
source $TMUX_SESSIONS_DIR/lib/is-current-session.sh;

SESSION_NAME="notes";
NOTES_DIR=$NVIM_NOTES_DIR;

if session-exists $SESSION_NAME; then

  if is-current-session $SESSION_NAME; then
    tmux switch-client -l;
  else
    attach-switch $SESSION_NAME;
  fi
else
  tmux new-session -d -s $SESSION_NAME -c $NOTES_DIR -n 'notes' "/bin/sh -c 'nvim; exec zsh'";

  attach-switch $SESSION_NAME;
fi
