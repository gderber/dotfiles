#!/bin/bash

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

# Application Specific PATH
FSLINT=/usr/share/fslint/fslint
FSLINTPATH="${FSLINT}:${FSLINT}/fstool"
[[ -d ${FSLINT} ]] && PATH="${FSLINTPATH}:${PATH}"

# set PATH so it includes user's private bin if it exists
[[ -d "${HOME}/.local/bin" ]] && PATH="$HOME/.local/bin:$PATH"
[[ -d "${HOME}/.local/games" ]] && PATH="${HOME}/.local/games:${PATH}"
[[ -d "${HOME}/bin" ]] && PATH="$HOME/bin:$PATH"
[[ -d "${HOME}/games" ]] && PATH="${HOME}/games:${PATH}"

if [[ -n $SSH_CLIENT ]] || [[ -n $SSH_TTY ]]; then
    if [[ ! $TERM =~ screen ]]; then
        screen -Rd
    fi
fi
