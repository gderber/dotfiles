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

(defconst drbr-org-mode-packages
  '(
    ;; Org
    (org-mind-map :location elpa)
    (org-journal :location elpa)
    ;; Org-noter maybe?
    ;;(org-super-agenda :location elpa)
    ;;(org-contacts :location built-in)
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

(defun drbr-org-mode/init-org-mind-map()
  (require 'ox)
  (use-package org-mind-map
    :after org
    :config
    (setq org-mind-map-engine "dot")  ; default; Directed Graph
    ;; (setq org-mind-map-engine "neato")  ; Undirected Spring Graph"
    ;; (setq org-mind-map-engine "twopi")  ; Radial Layout"
    ;; (setq org-mind-map-engine "circo")  ; Circular Layout"
    ;; (setq org-mind-map-engine "p")  ; Undirected Spring Force-Directed"
        ))

;;(defun drbr-org-mode/init-org-super-agenda()
;;  (use-package org-super-agenda))

(defun drbr-org-mode/init-org-journal()
  (use-package org-journal))

;; (defun drbr-org-mode/post-init-persp-mode ()
;;   (spacemacs|define-custom-layout "@Drbr-Org"
;;     :binding "O"
;;     :body
;;     (split-window-right)
;;     (winum-select-window-2)
;;     (let ((agenda-files (org-agenda-files)))
;;       (if agenda-files
;;           (find-file (first agenda-files))
;;         (user-error "Error: No agenda files configured, nothing to display.")))
;;     (winum-select-window-1)))

;;(defun drbr/init-org-contacts()
;;  (use-package org-contacts))

;;(when (configuration-layer/package-drbr 'company)
;;  (defun drbr/post-init-firelpace ()
;; This makes no reference to `some-weird-package', which may have
;; been excluded by the user
;;    (spacemacs|add-company-hook fireplace)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; packages.el ends here
