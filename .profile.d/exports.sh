# Emacs
# ALTERNATE_EDITOR
# If the Emacs server is not running, run the shell command in this environment variable instead.
# If set to the empty string, run "emacs --daemon" to start Emacs in daemon mode, and try to
# connect to it.  Will be over‐ridden by the --alternate-editor option, if present.
export ALTERNATE_EDITOR=""
# $EDITOR opens in terminal (--tty and -nw are equivalent)
export EDITOR="emacsclient --tty"
# GUI editor
export VISUAL="emacsclient --create-frame"

export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# GTAGS
export GTAGSLABEL=pygments

# ==================================================================================================
#
# XDG Base Directory
#
# ==================================================================================================
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_STATE_HOME="${HOME}/.local/state"

#export ANSIBLE_COLLECTIONS_PATH="${XDG_DATA_HOME}/ansible/collections"
#export ANSIBLE_CONFIG="${XDG_CONFIG_HOME}/ansible.cfg"
#export ANSIBLE_GALAXY_CACHE_DIR="${XDG_CACHE_HOME}/ansible/galaxy_cache"
#export ANSIBLE_HOME="${XDG_CONFIG_HOME}/ansible"
export DVDCSS_CACHE="${XDG_DATA_HOME}/dvdcss"
export ICEAUTHORITY="${XDG_CACHE_HOME}/ICEauthority"
export PASSWORD_STORE_DIR="${XDG_DATA_HOME}/password-store"
export PYLINTRC="${XDG_CONFIG_HOME}/pylint/pylintrc"
#export SCREENDIR="${XDG_RUNTIME_DIR}/screen"
#export SCREENRC="${XDG_CONFIG_HOME}/screen/screenrc"
export SPACEMACSDIR="${XDG_CONFIG_HOME}/spacemacs"
export WGETRC="${XDG_CONFIG_HOME}/wgetrc"
export LSP_USE_PLISTS=true
