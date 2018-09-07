;;; keybindings.el --- 
;; 
;; Filename: keybindings.el
;; Description: 
;; Author: Geoff S Derber
;; Maintainer: 
;; Created: Wed Sep  5 15:36:14 2018 (-0400)
;; Version: 
;; Package-Requires: ()
;; Last-Updated: Wed Sep  5 15:37:36 2018 (-0400)
;;           By: Geoff S Derber
;;     Update #: 2
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

;;;;; Global Keybindings ;;;;;;

; Now the functions are defined, we can assign them to keys.
(global-set-key (kbd "C-c d") 'insert-date)
;; keyboard mods not specific to any mode.
;;  note the use of kbd function to make these work in emacs or
;;  xemacs.
;;(global-set-key (kbd "C-h") 'delete-backward-char)   ;backspace, not help!
(global-set-key (kbd "C-c g") 'goto-line)
(global-set-key (kbd "<f2>") 'other-window)       ;convenient shortcuts.
(global-set-key (kbd "<f3>") 'kill-this-buffer)
(global-set-key (kbd "<f4>") 'speedbar-get-focus) ;jump to the speedbar.

(global-unset-key (kbd "ESC ESC"))         ;eval-expr gets in my way.
(global-set-key (kbd "C-`") 'capitalize-word)      ;I want c-~, but
      ;that's too
                                                   ;hard to type.

;; Duplicates of some of the keys above so everything works
;; properly on remote xterms.
;;(global-set-key "\e[12~" 'other-window)
;;(global-set-key "\e[13~" 'kill-this-buffer)

;; Keys that Jeff likes - maybe I'll try them too.
;;(global-set-key (kbd "C-x C-k") 'compile)
;;(global-set-key (kbd "C-x C-j") 'fill-paragraph)

; Unfortunately there's no common way to bind mouse events in the
; different emacsen.
(if (boundp 'running-xemacs)
    (global-set-key [(shift button2)]        ;<shift>-mouse2 to load
      'browse-url-at-mouse)                  ;url at point into
					     ;netscape.
  ;(else GNU Emacs
  (global-set-key [(shift down-mouse-2)]     ;<shift>-mouse2 to load
    'browse-url-at-mouse)                    ;url at point into netscape.
 )

(global-set-key (kbd "C-x g") 'magit-status)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; keybindings.el ends here
