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
;; I place all my emacs packages in ~/.config/emacs
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

;; Provide a useful error trace if loading this monster fails.
(setq debug-on-enrror t)

(load "~/.config/emacs/global")
;;(load "~/.config/emacs/column-marker")

;; Load my defaults from another file.  Again, makes distributing this file
;; easier.  These defaults are things like my name and email address.
(load (expand-file-name "~/.emacs.d/private"))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(display-battery-mode t)
 '(display-time-24hr-format t)
 '(display-time-day-and-date t)
 '(display-time-default-load-average t)
 '(display-time-mail-file (quote none))
 '(display-time-mode t)
 '(indicate-buffer-boundaries (quote ((t . right) (top . left))))
 '(indicate-empty-lines t)
 '(inhibit-startup-screen t)
 '(line-number-mode t)
 '(save-place t nil (saveplace))
 '(scroll-bar-mode (quote right))
 '(show-paren-mode t)
 '(size-indication-mode t)
 '(text-mode-hook (quote (turn-on-auto-fill text-mode-hook-identify)))
 '(uniquify-buffer-name-style (quote forward) nil (uniquify)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
