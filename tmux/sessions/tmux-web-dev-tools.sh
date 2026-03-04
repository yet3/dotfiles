#!/bin/bash

source $TMUX_SESSIONS_DIR/lib/attach-switch.sh;
source $TMUX_SESSIONS_DIR/lib/session-exists.sh;

SESSION_NAME="web-dt";
WEB_DIR=~/dev/02-apps/web-dev-tools/

if session-exists $SESSION_NAME; then
  attach-switch $SESSION_NAME;
else
  tmux new-session -d -s $SESSION_NAME -c $WEB_DIR -n 'editor' "/bin/sh -c 'nvim; exec zsh'";

  tmux new-window -t $SESSION_NAME -c $WEB_DIR -n 'term';

  attach-switch $SESSION_NAME;
fi
