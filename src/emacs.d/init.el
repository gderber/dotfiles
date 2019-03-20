;;------------------------------------------------------------------------------
;;
;; .emacs.d/init.el
;;
;;;; Copyright:
;;
;; (c) 2017 Geoffrey Derber
;;
;; Author: Geoffrey Derber
;; Keywords: emacs, dotfile, config
;;
;; Sections copied from:
;;    Fabrice Niessen <(concat "fni" at-symbol "mygooglest.com")>
;;    Jeff Jones' .emacs
;;    Other sources on the web:
;;    - https://www.emacswiki.org/
;;    - http://stackoverflow.com/questions/298065/which-are-the-gnu-emacs-modes-extensions-you-cant-live-without
;;    - http://www.gnu.org/software/emacs/tour/
;;
;;    Everyone's .emacs rips off someone else's...
;;
;; This file is NOT part of GNU Emacs.
;;
;; This file is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 2 of
;; the License, or (at your option) any later version.
;;
;; This file is distributed in the hope that it will be
;; useful, but WITHOUT ANY WARRANTY; without even the implied
;; warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
;; PURPOSE.  See the GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public
;; License along with this file; if not, write to the Free
;; Software Foundation, Inc., 59 Temple Place - Suite 330, Boston,
;; MA 02111-1307, USA.
;;
;;;; Commentary:
;;
;; An amalgamation of ideas from many sources.  First, notice the
;; section headers - they look like that for use in outline-mode.  Type C-c @
;; C-t to get a listing of all the headings, type the usual motion keys to
;; move among them, & type C-c @ C-a to see all the text again.  I remap the
;; outline-minor-mode-prefix to C-c C-k, which I find easier to type.  A
;; "Local Variables" section at the end of this file sets up outline mode
;; appropriately.
;;
;; I place all my emacs packages in ~/.emacs.d/epkgs/
;;
;;;;  Citations
;;
;;
;;     "Emacs is like a laser guided missile. It only has to be slightly
;;      mis-configured to ruin your whole day."
;;                                                            [Sean McGrath]
;;
;;  Help
;;
;;      For help on The Emacs Editor, see:
;;          (info "(emacs)") <== C-x C-e here!
;; BUGS
;;
;; - `C-x SPC' = gud-break, unknown function
;; - menu-bar-mode disappears sometimes
;;
;;;; Emacs Tour
;;
;;
;;------------------------------------------------------------------------------

;;;; Global Settings ;;;;

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("marmalade" . "https://marmalade-repo.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")
                         ("orgmode" . "https://orgmode.org/elpa/")))

;; Provide a useful error trace if loading this monster fails.
(setq debug-on-error t)

;; External Packages
;;(load (expand-file-name "~/.emacs.d/epkgs/password-store/contrib/emacs/password-store"))
(load (expand-file-name "~/.emacs.d/epkgs/emacswiki/header2"))
(load (expand-file-name "~/.emacs.d/epkgs/emacswiki/fill-column-indicator"))
(load (expand-file-name "~/.emacs.d/epkgs/emacswiki/highlight-chars"))
(load (expand-file-name "~/.emacs.d/epkgs/emacswiki/column-marker"))

;; Configuration
(load (expand-file-name "~/.emacs.d/global"))
(load (expand-file-name "~/.emacs.d/filetypes"))

;;
(set-language-environment "UTF-8")

;; (load (expand-file-name "~/.emacs.d/mode-line"))

;; Load my defaults from another file.  Again, makes distributing this file
;; easier.  These defaults are things like my name and email address.
(load (expand-file-name "~/.emacs.d/private"))

;; Space emacs
(setq spacemacs-start-directory "~/.emacs.d/spacemacs/")
(load-file (concat spacemacs-start-directory "init.el"))

;;(cond ((eq system-type 'windows-nt)
       ;; Windows-specific code goes here.
;;       )
;;       ((eq system-type 'gnu/linux)
       ;; Linux-specific code goes here.
;;     ))

;;(cond ((display-graphic-p)
       ;; Graphical code goes here.
;;       )
;;      (t
       ;; Console-specific code
;;       ))

;; Mode Specific Setups
(load (expand-file-name "~/.emacs.d/modes/apache-mode"))
(load (expand-file-name "~/.emacs.d/modes/org-mode"))

;; Start an org-agenda mode buffer upon startup
(add-hook 'after-init-hook (lambda() (org-agenda-list 14)))
;;(add-hook 'after-init-hook (lambda() (initial-scratch-message my/fortune-scratch-message)))
