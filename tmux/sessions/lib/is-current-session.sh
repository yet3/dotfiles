#!/bin/bash

function is-current-session() {
  if [[ "$(tmux display-message -p '#S')" = "$1" ]]; then
    return 0 # true
  else
    return 1 # false
  fi
}
