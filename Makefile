# ----------------------------------------------------------------------
#
# Makefile for dotfiles
#
# By Geoff S Derber
#
#
#
# ---------------------------------------------------------------------
NAME=dotfiles
VERSION=0.0.3
DESCRIPTION="My dotfiles"

BASH_FILES=bash bashrc bash_profile bash_logout
BEETS_FILES=config.yaml genres.txt
EMACS_FILES=emacs.d spacemacs
GIT_FILES=.gitignore .gitattributes .gitconfig
GNUPG_FILES=gpg-agent.conf gpg.conf
INPUT_FILES=editrc inputrc
MISC_FILES=kshrc netrc profile screenrc toprc wgetrc
PYTHON_FILES=pylintrc pythonrc
SSH_FILES=config
X_FILES=Xdefaults xscreensaver

DOC_FILES=*.md *.txt

PKG_DIR=pkg
PKG_NAME=$(NAME)-$(VERSION)
PKG=$(PKG_DIR)/$(PKG_NAME).tar.gz
SIG=$(PKG_DIR)/$(PKG_NAME).asc

PREFIX=~
DOC_DIR=$(PREFIX)/share/doc/$(PKG_NAME)

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
	install-x

install-bash:
	@for file in $(BASH_FILES); \
	do \
		ln -nrvsf $(PWD)/src/$$file $(PREFIX)/.$$file; \
	done

install-beets:
	mkdir -pv $(PREFIX)/.config/beets/
	@for file in $(BEETS_FILES); \
	do \
		ln -nrvsf $(PWD)/src/config/beets/$$file $(PREFIX)/.config/beets/$$file; \
	done

install-emacs:
	@for file in $(EMACS_FILES); \
	do \
		ln -nrvsf $(PWD)/src/$$file $(PREFIX)/.$$file; \
	done \
	@if [ ! -d $(PREFIX)/.emacs.d/spacemacs ]; then \
		cd $(PREFIX)/.emacs.d/ \
		git clone https://github.com/syl20bnr/spacemacs.git \
		cd $(HOME) \
	fi

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
	mkdir -p $(PREFIX)/.ssh
	chmod 700 $(PREFIX)/.ssh
	@for file in $(SSH_FILES); \
	do \
		mkdir -pv $(PREFIX)/.ssh/; \
		ln -rvsf $(PWD)/src/ssh/$$file $(PREFIX)/.ssh/$$file; \
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

