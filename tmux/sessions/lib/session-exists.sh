#!/bin/bash

function session-exists() {
  if tmux has-session -t $1 2>/dev/null; then
    return 0 # true
  fi

  return 1 # false
}
