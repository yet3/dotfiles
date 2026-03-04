#!/bin/bash

function attach-switch() {
  if tmux list-sessions 2>/dev/null | grep -q 'attached'; then
    tmux switch -t $1;
  else
    tmux attach-session -t $1;
  fi
}
