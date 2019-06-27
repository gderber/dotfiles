;;; packages.el --- drbr layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2017 Sylvain Benner & Contributors
;;
;; Author: Geoff S Derber <gd.smlinux@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Commentary:

;; See the Spacemacs documentation and FAQs for instructions on how to implement
;; a new layer:
;;
;;   SPC h SPC layers RET
;;
;;
;; Briefly, each package to be installed or configured by this layer should be
;; added to `drbr-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `drbr/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `drbr/pre-init-PACKAGE' and/or
;;   `drbr/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst drbr-packages
  '(
    (fireplace :location elpa)

    ;; Org
    ;;(org-mind-map :location elpa)
    (org-journal :location elpa)
;;    (org-contacts :location built-in)

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

    ;; Emacs Wiki packages
    (hl-fill-column :location elpa)
    ;;header2
    ;;highlight-chars
    ;;column-marker
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

;;(defun drbr/init-org-mind-map()
;;  (use-package org-mind-map))

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

  ;;(when (configuration-layer/package-drbr 'company)
  ;;  (defun drbr/post-init-firelpace ()
  ;; This makes no reference to `some-weird-package', which may have
  ;; been excluded by the user
  ;;    (spacemacs|add-company-hook fireplace)))

;;; packages.el ends here
