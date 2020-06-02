### Makefile ---
##
## Filename: Makefile
## Description: Installs / Uninstalls dotfiles in ${HOME}
## Author: Geoff S Derber
## Maintainer: 
## Created: Sun Jan  6 12:25:15 2019 (-0500)
## Version: 0.1.11
## Package-Requires: ()
## Last-Updated: Sun Jun  9 14:39:57 2019 (-0400)
##           By: Geoff S Derber
##     Update #: 21
## URL: https://github.com/gderber/dotfiles
## Doc URL: https://github.com/gderber/dotfiles
## Keywords: dotfiles
## Compatibility:
##
##   - References: https://github.com/xsnpdngv/keep
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
VERSION=0.1.11
DESCRIPTION="My dotfiles"

BASH_FILES=bash bashrc bash_profile bash_logout
BEETS_FILES=config.yaml genres.txt
EMACS_FILES=drbr drbr-ansible drbr-apache drbr-common drbr-emms drbr-git drbr-mediawiki drbr-org-mode drbr-passwordstore
SPACEMACS_FILES=spacemacs
GIT_FILES=.gitignore .gitattributes .gitconfig
GNUPG_FILES=gpg-agent.conf gpg.conf
INPUT_FILES=editrc inputrc
MISC_FILES=kshrc netrc profile screenrc toprc wgetrc
PYTHON_FILES=pylintrc pythonrc
X_FILES=Xdefaults xscreensaver
SYSTEMD_FILES=emacs
BIN_FILES=screenemacs
SHARE_FILES=emacsclient.desktop

F1_EXISTS=$(shell [ -d $(PREFIX)/.emacs.d/spacemacs ] && echo 1 || echo 0 )

DOC_FILES=*.md *.txt

PKG_DIR=pkg
PKG_NAME=$(NAME)-$(VERSION)
PKG=$(PKG_DIR)/$(PKG_NAME).tar.gz
SIG=$(PKG_DIR)/$(PKG_NAME).asc

PREFIX=~
DOC_DIR=$(PREFIX)/share/doc/$(PKG_NAME)

# FIXME: Hackish, maybe something from getent
USER=$(shell echo ${HOME}| sed 's|.*/||')

# Applications
PGP = gpg
ASC = $(wildcard *.asc)
SEC = $(filter-out $(ASC) $(PROJECT),$(wildcard *))
PROJECT = Makefile README.md sdel
#UID = "Tamas Dezso"

# TODO: Rewrite for auto creation
# help
help:
	@echo -e "Usage:\n\
    make file.asc  Encrypt: file -> file.asc\n\
    make file      Decrypt: file.asc -> file\n\
    make clean     Encrypt plain files if needed, then remove originals\n\
    make plain     Decrypt *.asc\n\
    make keys      Generate key pair\n\
    make export    Export keys to public_key.asc, private_key.asc\n\
    make import    Import keys from public_key.asc and private_key.asc"


# ======================================================================
#
# GPG Key Setup
#
# ======================================================================
# keygen
keys:
	$(PGP) --full-generate-key

# export public and private keys
export:
	$(PGP) --export --armor -o public_key.asc $(UID)
	umask 077; $(PGP) --export-secret-key --armor -o private_key.asc $(UID)

# import public and private keys
import: public_key.asc private_key.asc
	$(PGP) --import public_key.asc
	$(PGP) --import private_key.asc

# encrypt: file -> file.asc
%.asc:: %
	@$(PGP) --encrypt --default-recipient-self --armor -o $@ $<
	@./sdel $<

# decrypt: file.asc -> file
%:: %.asc
	@umask 077; $(PGP) --decrypt -o $@ $<
	@touch -r $? $@ # to be no newer than the encrypted one

# decrypt *.asc
plain: $(basename $(ASC))

# if file is present as .asc too, and is no newer than that, then
# it is simply removed, otherwise it is encrypted before
#clean:
#	$(MAKE) $(SEC:=.asc)
#@./sdel -f $(SEC)ASC = $(wildcard *.asc)

# ======================================================================
#
# Packaging
#
# ======================================================================
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
	install-bin \
	install-gnupg \
	install-git \
	install-misc \
	install-python \
	install-share \
	install-systemd \
	install-x

install-bash:
	@for file in $(BASH_FILES); \
	do \
		ln -nrvsf $(PWD)/src/$$file $(PREFIX)/.$$file; \
	done

uninstall-bash:
	@for file in $(BASH_FILES); \
	do \
		rm $(PREFIX)/.$$file; \
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

install-bin:
	mkdir -pv $(HOME)/.local/bin/
	@for file in $(BIN_FILES); \
	do \
		ln -nrvsf $(PWD)/src/local/bin/$$file $(PREFIX)/.local/bin/$$file; \
	done

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

install-share:
	mkdir -pv $(PREFIX)/.local/share/applications
	@for file in $(SHARE_FILES); \
	do \
		ln -nrvsf $(PWD)/src/local/share/applications/$$file $(PREFIX)/.local/share/applications/$$file; \
	done

install-systemd:
	mkdir -pv ${PREFIX}/.config/systemd/user
	@for file in $(SYSTEMD_FILES); \
	do \
		ln -rvsf $(PWD)/src/config/systemd/user/$$file.service $(PREFIX)/.config/systemd/user/$$file.service; \
		systemctl enable --user $$file; \
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

.PHONY: build sign clean test tag release install uninstall all help keys export import plain clean Makefile

######################################################################
### Makefile ends here
