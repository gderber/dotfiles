# =============================================================== #
#
# PERSONAL $HOME/.bashrc FILE
#
# Last modified: Tue Mar 26 2016
#
# Code from:
#
# http://tldp.org/LDP/abs/html/sample-bashrc.html
# By Emmanuel Rouat [no-email]
#
# https://github.com/demure/dotfiles/blob/master/subbash/sourcer
#
# https://github.com/gmarik/dotfiles/blob/master/.bash/bashrc
#
# Others...
#
# =============================================================== #

#------------------------------------------------------------- 
# Source global definitions (if any)
#------------------------------------------------------------- 
if [ -f /etc/bashrc ]; then 
    . /etc/bashrc 
    # --> Read /etc/bashrc, if present. 
fi


so() { [ -s $1 ] && source $1; }

so ~/.bash/bashrc				# main configuration

## Uses:
## export ENV_NAME=$(uname -s|tr 'A-Z' 'a-z')
#so ~/.subbash/${ENV_NAME}_profile	  # configuration per OS linux/OSX

#so ~/.subbash/common	       		# common stuff or overriding

#so ~/.subbash/export  		       	# Exports
so ~/.bash/shopt   			# Shopts
#so ~/.subbash/installcheck	  # Checks for installs, $MISSING_PROGRAMS
#so ~/.subbash/sshagent		  # SSH agent, have before settings
#so ~/.subbash/gpgagent		  # GPG agent, have before settings

### Interactive ### {{{
if [[ $- == *i* ]]; then
   # so ~/.bash/colors
    so ~/.bash/prompt			# COMMAND_PROMPT function
    so ~/.bash/aliases	       		# Alias
    so ~/.bash/functions	      		# Functions
    # so ~/.bash/xdisplay
fi
### End Interactive ### }}}

## This needs to be after Interactive, to override
#so ~/.subbash/settings	      	# Machine dependent settings


## This is last, so it can override everything. Less fighting with mini installs.
#so ~/.subbash/bashrc.local    	# machine specific config. not tracked

return 0
