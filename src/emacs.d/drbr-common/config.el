;;; config.el --- 
;; 
;; Filename: config.el
;; Description: 
;; Author: Geoff S Derber
;; Maintainer: 
;; Created: Mon Jun 10 18:42:03 2019 (-0400)
;; Version: 
;; Package-Requires: ()
;; Last-Updated: Mon Jun 10 18:42:09 2019 (-0400)
;;           By: Geoff S Derber
;;     Update #: 1
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

;; Provide a useful error trace if loading this monster fails.
(setq debug-on-error t)


; Unfortunately there's no common way to bind mouse events in the
; different emacsen.
;;(if (boundp 'running-xemacs)
;;    (global-set-key [(shift button2)]        ;<shift>-mouse2 to load
;;      'browse-url-at-mouse)                  ;url at point into
;;					     ;netscape.
;;  ;(else GNU Emacs
;;  (global-set-key [(shift down-mouse-2)]     ;<shift>-mouse2 to load
;;    'browse-url-at-mouse)                    ;url at point into netscape.
;; )

;;;;; Global Settings ;;;;;
(savehist-mode 1)
;; Miscellaneous settings
;; All settings clicked in the Options menu are saved here by Emacs.
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
;; '(column-number-mode t)
 '(cookie-file "/usr/share/games/fortunes/startrek")
;; '(line-number-mode t)
 '(display-battery-mode t)
 '(display-time-24hr-format t)
 '(display-time-day-and-date t)
 '(display-time-default-load-average t)
;; '(display-time-mail-file (quote none))
 '(display-time-mode t)
 '(size-indication-mode t) ;; Show file size
 ;;'(indicate-buffer-boundaries (quote ((t . right) (top . left))))
 ;;'(inhibit-startup-screen t)
 ;;'(indicate-empty-lines t)
 ;;'(save-place t nil (saveplace))
 '(scroll-bar-mode (quote right))
 ;;'(show-paren-mode t) ;; Show matched Parens
 ;;'(text-mode-hook (quote (turn-on-auto-fill text-mode-hook-identify)))
 ;;'(uniquify-buffer-name-style (quote forward) nil (uniquify))
 ;; Backup Settings
 ;;'(backup-directory-alist '(("." . "~/.emacs.d/backups")))
 ;;'(delete-old-versions -1)
 ;;'(version-control t)
 ;;'(vc-make-backup-files t)
 ;;'(auto-save-file-name-transforms '((".*" "~/.emacs.d/auto-save-list/" t)))
 ;; http://www.wisdomandwonder.com/wp-content/uploads/2014/03/C3F.html
 ;;'(savehist-file "~/.emacs.d/savehist")
 ;;'(history-length t)
 ;;'(history-delete-duplicates t)
 ;;'(savehist-save-minibuffer-history 1)
 ;;'(savehist-additional-variables
 ;;  '(kill-ring
 ;;    search-ring
 ;;    regexp-search-ring))
;; '(package-selected-packages
;;   (quote
;;    (which-key undo-tree hydra evil-unimpaired async aggressive-indent adaptive-wrap ace-window)))
  ;; End Sentences with 2 spaces
 ;;'(sentence-end-double-space t)
)


;;(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
;; )

(setq-default fill-column 100)
;;(setq global-font-lock-mode t)             ; Enable syntax-highlighting
;;(setq font-lock-maximum-decoration t)
(setq indent-tabs-mode nil)                ; Use spaces instead of tabs for indentation.
(setq tab-width 4)                         ; Set tab width to 4
(setq default-tab-width 4)                 ; Required by graphviz-dot-mode
(setq transient-mark-mode t)               ;where's that selection?
(setq mouse-yank-at-point t)               ;paste at point NOT at cursor
;;(setq next-line-add-newlines nil)          ;no newlines if I cursor past EOF.
(setq require-final-newline 't)            ; Always newline at end of file
;;(setq minibuffer-max-depth nil)            ;enable multiple minibuffers:
 ;I didn't understand this for a long time - if you don't set this,
 ;you can't do things like search the minibuffer history with M-s
 ;(cause that requires another minibuffer)
(setq browse-url-browser-function          ;call netscape on URLs.
      (quote browse-url-firefox))

;; Neotree settings:
(when (display-graphic-p)
  (setq neo-theme icons)
  (setq neo-vc-integration face)
  )

;;(setq browse-url-new-window-p t)           ;open a fresh netscape window.
;;(if (boundp 'running-xemacs)
;;    (progn
;;      ;make the modeline time display show up on dark background.
;;      (setq display-time-display-time-foreground "tomato")
;;      ;I put my mail in a non-standard location.
;;      (setq display-time-mail-file (expand-file-name "~/nsmail/Inbox"))
;;      ; Make sure delete key always deletes forward in cc mode.
;;      (setq delete-key-deletes-forward t)
;;      )
;;)



;; Don't truncate lines in vertically split windows (suggested by Jeff).
;;(setq truncate-partial-width-windows nil)

;; uptimes
(setq emacs-load-start-time (current-time))

;;(add-hook 'font-lock-mode-hook 'hc-highlight-tabs)
;;(add-hook 'font-lock-mode-hook 'hc-highlight-hard-spaces)
;;(add-hook 'font-lock-mode-hook 'hc-highlight-trailing-whitespace)
;;(add-hook 'after-change-major-mode-hook 'fci-mode)

;; Add hooks for various modes
(with-eval-after-load 'cc-mode
  (add-hook 'cc-mode-hook 'fci-mode))
(with-eval-after-load 'shell-mode
  (add-hook 'shell-mode-hook 'fci-mode))
(with-eval-after-load 'conf-mode
  (add-hook 'conf-mode-hook 'fci-mode))
(with-eval-after-load 'python-mode
  (add-hook 'python-mode-hook 'fci-mode))
(with-eval-after-load 'yaml-mode
  (add-hook 'yaml-mode-hook 'fci-mode))
(with-eval-after-load 'emacs-lisp-mode
  (add-hook 'emacs-lisp-mode-hook 'fci-mode))
(with-eval-after-load 'php-mode-hook
  (add-hook 'php-mode-hook 'fci-mode))
(with-eval-after-load 'html-mode
  (add-hook 'html-mode-hook 'fci-mode))
(with-eval-after-load 'nxml-mode
  (add-hook 'nxml-mode-hook 'fci-mode))
(with-eval-after-load 'graphviz-dot-mode
  (add-hook 'graphviz-dot-mode-hook 'fci-mode))


;; Header
;;(autoload 'auto-update-file-header "header2")
;;(add-hook 'write-file-hooks 'auto-update-file-header)
;; To have Emacs add a file header whenever you create a new file in
;; some mode, put this in your init file (~/.emacs):
;;(autoload 'auto-make-header "header2")
;;(add-hook 'emacs-lisp-mode-hook 'auto-make-header)
;;(add-hook 'c-mode-common-hook   'auto-make-header)

;;(elpy-enable)
;;(require 'epa-file)
;;(epa-file-enable)

;; Fix for broken daemon mode
;;(defun signal-restart-server ()
;;    "Handler for SIGUSR1 signal, to (re)start an emacs server.
;;
;;Can be tested from within emacs with:
;; (signal-process (emacs-pid) 'sigusr1)
;;
;;or from the command line with:
;;$ kill -USR1 <emacs-pid>
;;$ emacsclient -c
;;"
;;    (interactive)
;;    (server-force-delete)
;;    (server-start))
;;)
;;(define-key special-event-map [sigusr1] 'signal-restart-server)

;; Server Settings
(require 'server)
(unless (server-running-p)
  (server-start))

;;(add-to-list 'auto-mode-alist '(".*_EDITMSG\\'" . log-entry-mode))
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'auto-mode-alist '("ssh*_config" . conf-mode))
(add-to-list 'auto-mode-alist '("screenrc" . conf-mode))
(add-to-list 'auto-mode-alist '("\\.cnf\\'" . conf-mode))
(add-to-list 'auto-mode-alist '(".profile" . shell-script-mode))
(add-to-list 'auto-mode-alist '("profile" . shell-script-mode))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; config.el ends here
