#!/bin/bash

source $TMUX_SESSIONS_DIR/lib/attach-switch.sh;
source $TMUX_SESSIONS_DIR/lib/session-exists.sh;

SESSION_NAME="any";
MAIN_DIR=$HOME;

if session-exists $SESSION_NAME; then
  attach-switch $SESSION_NAME;
else
  tmux new-session -d -s $SESSION_NAME -c $MAIN_DIR -n 'home';

  attach-switch $SESSION_NAME;
fi
