# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# Application Specific PATH
FSLINT=/usr/share/fslint/fslint
FSLINTPATH="${FSLINT}:${FSLINT}/fstool"
if [ -d ${FSLINT} ] ; then
   PATH="${FSLINTPATH}:${PATH}"
fi

PATH="/usr/games:${PATH}"

# set PATH so it includes user's private bin if it exists
if [ -d "${HOME}/.local/bin" ] ; then
    PATH="${HOME}/.local/bin:$PATH"
fi
if [ -d "${HOME}/.local/games" ] ; then
    PATH="$HOME/.local/games:$PATH"
fi
if [ -d "${HOME}/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi
if [ -d "${HOME}/games" ] ; then
    PATH="$HOME/games:$PATH"
fi
