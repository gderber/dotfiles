#!/bin/bash
# ==================================================================================================
# .bashrc
#
# Filename: bashrc
# Description:
# Author: G S Derber
# Maintainer:
# Created: Sun Jan  6 12:22:35 2019 (-0500)
# Version:
# Package-Requires: ()
# Last-Updated: Sun Jun  9 14:50:12 2019 (-0400)
#           By: Geoff S Derber
#     Update #: 2
# URL:
# Doc URL:
# Keywords:
# Compatibility:
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or (at
# your option) any later version.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with GNU Emacs.  If not, see <https://www.gnu.org/licenses/>.
#
# ==================================================================================================
# If not running interactively, don't do anything
case $- in
    *i*) ;;
    *) return;;
esac

so() { [ -s $1 ] && source $1; }

# Source global definitions (if any)
so /etc/bash.bashrc
so ~/.profile

# Host Specific settings
so ~/.bash.d/${HOSTNAME}_settings
so ~/.bash.d/bashrc # main configuration

## Uses:
ENV_NAME="$(uname -s|tr 'A-Z' 'a-z')"

so ~/.bash.d/${ENV_NAME}_profile # configuration per OS linux/OSX/WIN
so ~/.bash.d/common              # common stuff or overriding
so ~/.bash.d/exports             # Exports
so ~/.bash.d/shopt               # Shopts

### Interactive ### {{{
if [[ $- == *i* ]]; then
    so ~/.bash.d/colors
    so ~/.bash.d/commonfunctions          # Common Functions
    so ~/.bash.d/functions                # Functions
    so ~/.bash.d/prompt                   # COMMAND_PROMPT function
    so ~/.bash.d/aliases                  # Alias
    #so ~/.bash.d/agent                    # GPG and SSH agents, have before settings
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
