#!/bin/bash
# ==================================================================================================
#
# Filename: bashrc
# Description:
# Author: G S Derber
# Maintainer:
# Created: Sun Jan  6 12:22:35 2019 (-0500)
# Version:
# Package-Requires: ()
# URL:
# Doc URL:
# Keywords:
# Compatibility:
#
# ==================================================================================================
so() { [ -s "${1}" ] && source "${1}"; }

# Source global definitions (if any)
so /etc/bash.bashrc
so ~/.profile

# Host Specific settings
so ~/.bash.d/${HOSTNAME}_settings
so ~/.bash.d/bashrc # main configuration

## Uses:
ENV_NAME="$(uname -s|tr 'A-Z' 'a-z')"

so ~/.bash.d/${ENV_NAME}_profile # configuration per OS linux/OSX/WIN
so ~/.bash.d/common              # common stuff for overriding
so ~/.bash.d/shopt               # Shopts

#  Interactive ### {{{
if [[ $- == *i* ]]; then
    so ~/.bash.d/agent
    so ~/.bash.d/colors
    so ~/.bash.d/commonfunctions          # Common Functions
    so ~/.bash.d/functions                # Functions
    so ~/.bash.d/prompt                   # COMMAND_PROMPT function
    so ~/.bash.d/aliases                  # Alias
    so ~/.bash.d/dotfiles

    # Conditional functions
    # Functions requiring sudo, which you may not have access to.
    #if sudo -v ; then
    #   so ~/.bash/sudo_functions
    #fi

    # These functions are only useful for laptops
    if [[ ${LAPTOP} == "true" ]]; then
        so ~/.bash.d/laptop_functions
    fi
fi
### End Interactive ### }}}

## This needs to be after Interactive, to override
so ~/.bash.d/settings                     # Machine dependent settings

## This is last, so it can override everything. Less fighting with mini installs.
so ~/.bash.d/bashrc.local            # machine specific config. not tracked

# If interactive mode, start ssh and gpg agents
if [[ $- == *i* ]]; then
    start_agents
fi

eval "$(starship init bash)"
