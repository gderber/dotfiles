;;; packages.el ---
;;
;; Filename: packages.el
;; Description:
;; Author: Geoff S Derber
;; Maintainer:
;; Created: Mon Jun 10 06:49:01 2019 (-0400)
;; Version:
;; Package-Requires: ()
;; Last-Updated: Mon Jun 10 07:10:56 2019 (-0400)
;;           By: Geoff S Derber
;;     Update #: 7
;; URL:
;; Doc URL:
;; Keywords:
;; Compatibility:
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Commentary:
;;
;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Change Log:
;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or (at
;; your option) any later version.
;;
;; This program is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs.  If not, see <https://www.gnu.org/licenses/>.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Code:

(defconst drbr-packages
  '(
    (fireplace :location elpa)

    ;; Git
    (forge :location elpa)
    (ghub :location elpa)
    (magit-todos :location elpa)
    (magit-filenotify :location elpa)

    ;; Org
    (org-mind-map :location elpa)
    (org-journal :location elpa)
    ;; Org-noter maybe?
    (org-super-agenda :location elpa)
    ;;(org-contacts :location built-in)

    ;; Password Store
    (password-store :location elpa)
    (password-store-otp :location elpa)
    (pass :location elpa)
    (auth-source-pass :location elpa)

    ;; Mediawiki
    (mediawiki :location elpa)
    (ox-mediawiki :location elpa)

    ;; EMMS
    (emms :location elpa)
    (emms-state :location elpa)
    (emms-info-mediainfo :location elpa)
    (emms-mark-ext :location elpa)
    (helm-emms :location elpa)
    (org-emms :location elpa)

    ;; Ansible
    (ansible-vault :location elpa)

    )
    "The list of Lisp packages required by the drbr layer.

Each entry is either:

1. A symbol, which is interpreted as a package to be installed, or

2. A list of the form (PACKAGE KEYS...), where PACKAGE is the
    name of the package to be installed or loaded, and KEYS are
    any number of keyword-value-pairs.

    The following keys are accepted:

    - :excluded (t or nil): Prevent the package from being loaded
      if value is non-nil

    - :location: Specify a custom installation location.
      The following values are legal:

      - The symbol `elpa' (default) means PACKAGE will be
        installed using the Emacs package manager.

      - The symbol `local' directs Spacemacs to load the file at
        `./local/PACKAGE/PACKAGE.el'

      - A list beginning with the symbol `recipe' is a melpa
        recipe.  See: https://github.com/milkypostman/melpa#recipe-format")

(defun drbr/init-fireplace()
  (use-package fireplace))

(defun drbr/init-org-mind-map()
  (use-package org-mind-map))

(defun drbr/init-forge()
  (use-package forge
    :after magit))

(defun drbr/init-ghub()
  (use-package ghub))

(defun drbr/init-magit-todos()
  (use-package magit-todos))

(defun drbr/init-magit-filenotify()
  (use-package magit-filenotify))

(defun drbr/init-org-journal()
  (use-package org-journal))

;;(defun drbr/init-org-contacts()
;;  (use-package org-contacts))

(defun drbr/init-password-store()
  (use-package password-store))

(defun drbr/init-password-store-otp()
  (use-package password-store-otp))

(defun drbr/init-pass()
  (use-package pass))

(defun drbr/init-auth-source-pass()
  (use-package auth-source-pass))

(defun drbr/init-mediawiki()
  (use-package mediawiki))

(defun drbr/init-ox-mediawiki()
  (use-package ox-mediawiki))

(defun drbr/init-emms()
  (use-package emms))

(defun drbr/init-emms-state()
  (use-package emms-state))

(defun drbr/init-emms-info-mediainfo()
  (use-package emms-info-mediainfo))

(defun drbr/init-emms-mark-ext()
  (use-package emms-mark-ext))

(defun drbr/init-helm-emms()
  (use-package helm-emms))

(defun drbr/init-org-emms()
  (use-package org-emms))

(defun drbr/init-ansible-vault()
  (use-package ansible-vault))

;;(when (configuration-layer/package-drbr 'company)
;;  (defun drbr/post-init-firelpace ()
;; This makes no reference to `some-weird-package', which may have
;; been excluded by the user
;;    (spacemacs|add-company-hook fireplace)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; packages.el ends here
