#!/bin/bash

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
[[ -d "${HOME}/.local/bin" ]] && PATH="${HOME}/.local/bin:${PATH}"
[[ -d "${HOME}/.local/games" ]] && PATH="${HOME}/.local/games:${PATH}"

if [[ -n $SSH_CLIENT ]] || [[ -n $SSH_TTY ]]; then
    if [[ ! $TERM =~ screen ]]; then
        screen -Rd
    fi
fi

# . "/home/HOME/geoff/.deno/env"
# source /home/HOME/geoff/.local/share/bash-completion/completions/deno.bash
# . "$HOME/.local/share/../bin/env"
