### Makefile ---
##
## Filename: Makefile
## Description: Installs / Uninstalls dotfiles in ${HOME}
## Author: Geoff S Derber
## Maintainer: 
## Created: Sun Jan  6 12:25:15 2019 (-0500)
## Version: 0.0.4
## Package-Requires: ()
## Last-Updated: Sun Jun  9 07:08:18 2019 (-0400)
##           By: Geoff S Derber
##     Update #: 20
## URL: https://github.com/gderber/dotfiles
## Doc URL: https://github.com/gderber/dotfiles
## Keywords: dotfiles
## Compatibility: 
## 
######################################################################
## 
### Commentary: 
## 
## 
## 
######################################################################
## 
### Change Log:
## 
## 
######################################################################
## 
## DO WHAT THE FUCK YOU WANT TO BUT IT'S NOT MY FAULT PUBLIC LICENSE TERMS AND
## CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
##
## 0. You just DO WHAT THE FUCK YOU WANT TO.
##
## THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
## IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
## FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
## AUTHOR(S), CREATOR(S), DEVELOPER(S), OR DISTRIBUTOR(S) BE LIABLE FOR ANY CLAIM,
## DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
## ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
## DEALINGS IN THE SOFTWARE.

######################################################################
## 
### Code:


NAME=dotfiles
VERSION=0.0.5
DESCRIPTION="My dotfiles"

BASH_FILES=bash bashrc bash_profile bash_logout
BEETS_FILES=config.yaml genres.txt
EMACS_FILES=emacs.d spacemacs
GIT_FILES=.gitignore .gitattributes .gitconfig
GNUPG_FILES=gpg-agent.conf gpg.conf
INPUT_FILES=editrc inputrc
MISC_FILES=kshrc netrc profile screenrc toprc wgetrc
PYTHON_FILES=pylintrc pythonrc
SSH_FILES=config config.d
X_FILES=Xdefaults xscreensaver
SYSTEMD_FILES=emacs.system

F1_EXISTS=$(shell [ -d $(PREFIX)/.emacs.d/spacemacs ] && echo 1 || echo 0 )

DOC_FILES=*.md *.txt

PKG_DIR=pkg
PKG_NAME=$(NAME)-$(VERSION)
PKG=$(PKG_DIR)/$(PKG_NAME).tar.gz
SIG=$(PKG_DIR)/$(PKG_NAME).asc

PREFIX=~
DOC_DIR=$(PREFIX)/share/doc/$(PKG_NAME)

USER=$(shell echo ${HOME}| sed 's|.*/||')


pkg:
	mkdir -p $(PKG_DIR)

$(PKG): pkg
	git archive --output=$(PKG) --prefix=$(PKG_NAME)/ HEAD

build: $(PKG)

$(SIG): $(PKG)
	gpg --sign --detach-sign --armor $(PKG)

sign: $(SIG)

clean:
	rm -f $(PKG) $(SIG)

all: $(PKG) $(SIG)

test:

tag:
	git tag $(VERSION)
	git push --tags

release: $(PKG) $(SIG) tag


uninstall:
	for file in $(INSTALL_FILES); do rm -f $(PREFIX)/$$file; done
	rm -rf $(DOC_DIR)

install: \
	install-bash \
	install-beets \
	install-emacs \
	install-gnupg \
	install-git \
	install-misc \
	install-python \
	install-ssh \
	install-systemd \
	install-x

install-bash:
	@for file in $(BASH_FILES); \
	do \
		ln -nrvsf $(PWD)/src/$$file $(PREFIX)/.$$file; \
	done

# Todo: a setup check if beets installed
# If beets exists, ...
# Else do not install
install-beets:
	mkdir -pv $(PREFIX)/.config/beets/
	@for file in $(BEETS_FILES); \
	do \
		ln -nrvsf $(PWD)/src/config/beets/$$file $(PREFIX)/.config/beets/$$file; \
	done

install-emacs:
	@$(foreach f, $(EMACS_FILES), [ -f $(HOME)/$f ] || ln -n -r -v -s -f $(PWD)/src/$f $(PREFIX)/.$f ; )
#	ifeq ( $(F1_EXISTS) , 1 )
#		git clone https://github.com/syl20bnr/spacemacs.git $(HOME)/emacs.d/spacemacs
#       else
#		( cd $(PREFIX)/.emacs.d/spacemacs; git pull origin master );
#	endif

install-git:
	@for file in $(GIT_FILES); \
	do \
		ln -rvsf $(PWD)/$$file $(PREFIX)/$$file; \
	done

install-gnupg:
	mkdir -pv $(PREFIX)/.gnupg
	chmod 700 $(PREFIX)/.gnupg
	@for file in $(GNUPG_FILES); \
	do \
		ln -rvsf $(PWD)/src/gnupg/$$file $(PREFIX)/.gnupg/$$file; \
	done

install-python:
	@for file in $(PYTHON_FILES); \
	do \
		ln -rvsf $(PWD)/src/$$file $(PREFIX)/.$$file; \
	done

install-misc:
	@for file in $(MISC_FILES); \
	do \
		ln -rvsf $(PWD)/src/$$file $(PREFIX)/.$$file; \
	done

install-ssh:
	mkdir -pv $(PREFIX)/.ssh
	chmod 700 $(PREFIX)/.ssh
	@for file in $(SSH_FILES); \
	do \
		ln -rvsf $(PWD)/src/ssh/$$file $(PREFIX)/.ssh/$$file; \
	done

install-systemd:
	mkdir -pv ${PREFIX}/.config/systemd/user
	@for file in $(SYSTEMD_FILES); \
	do \
		ln -rvsf $(PWD)/src/config/systemd/$$file $(PREFIX)/.config/systemd/user/$$file; \
	done

install-x:
	@for file in $(X_FILES); \
	do \
		ln -rvsf $(PWD)/src/$$file $(PREFIX)/.$$file; \
	done

backup:
	@echo "backing up"

install-backup:
	backup \
	install

.PHONY: build sign clean test tag release install uninstall all


######################################################################
### Makefile ends here
