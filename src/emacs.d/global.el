(load "~/.config/emacs/highlight-chars")

;;;;; Global Functions ;;;;;
(defun insert-date (prefix)
  "Insert the current date. With prefix-argument, use ISO format. With
   two prefix arguments, write out the day and month name."
  (interactive "P")
  (let ((format (cond
		 ((not prefix) "%d.%m.%Y")
		 ((equal prefix '(4)) "%Y-%m-%d")
		 ((equal prefix '(16)) "%A, %d. %B %Y")))
	(system-time-locale "de_DE"))
    (insert (format-time-string format))))

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
(global-set-key "\e[12~" 'other-window)
(global-set-key "\e[13~" 'kill-this-buffer)

;; Keys that Jeff likes - maybe I'll try them too.
(global-set-key (kbd "C-x C-k") 'compile)
(global-set-key (kbd "C-x C-j") 'fill-paragraph)

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

;;;;; Global Settings ;;;;;

;; Miscellaneous settings
;; All settings clicked in the Options menu are saved here by Emacs.
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(line-number-mode t)
 '(display-battery-mode t)
 '(display-time-24hr-format t)
 '(display-time-day-and-date t)
 '(display-time-default-load-average t)
 '(display-time-mail-file (quote none))
 '(display-time-mode t)
 '(size-indication-mode t) ;; Show file size
 '(indicate-buffer-boundaries (quote ((t . right) (top . left))))
 '(indicate-empty-lines t)
 '(save-place t nil (saveplace))
 '(scroll-bar-mode (quote right))
 '(show-paren-mode t) ;; Show matched Parens
 '(text-mode-hook (quote (turn-on-auto-fill text-mode-hook-identify)))
 '(uniquify-buffer-name-style (quote forward) nil (uniquify)))

(setq global-font-lock-mode t)             ; Enable syntax-highlighting
(setq font-lock-maximum-decoration t)
(setq indent-tabs-mode nil)                ; Use spaces instead of tabs for indentation.
;;(setq inhibit-startup-message t)           ;don't need it anymore.
(setq transient-mark-mode t)               ;where's that selection?
(setq mouse-yank-at-point t)               ;paste at point NOT at cursor
(setq next-line-add-newlines nil)          ;no newlines if I cursor past EOF.
(setq minibuffer-max-depth nil)            ;enable multiple minibuffers:
 ;I didn't understand this for a long time - if you don't set this,
 ;you can't do things like search the minibuffer history with M-s
 ;(cause that requires another minibuffer)
;;(setq browse-url-browser-function          ;call netscape on URLs.
;;      (quote browse-url-netscape))
;;(setq browse-url-new-window-p t)           ;open a fresh netscape window.
;;(if (boundp 'running-xemacs)
;;    (progn
;;      ;make the modeline time display show up on dark background.
 ;;     (setq display-time-display-time-foreground "tomato")
;;      ;I put my mail in a non-standard location.
;;      (setq display-time-mail-file (expand-file-name "~/nsmail/Inbox"))
;;      ; Make sure delete key always deletes forward in cc mode.
;;      (setq delete-key-deletes-forward t)
;;      )
;;)
;; Don't truncate lines in vertically split windows (suggested by Jeff).
(setq truncate-partial-width-windows nil)

;; uptimes
(setq emacs-load-start-time (current-time))

(add-hook 'font-lock-mode-hook 'hc-highlight-tabs)
(add-hook 'font-lock-mode-hook 'hc-highlight-hard-spaces)
(add-hook 'font-lock-mode-hook 'hc-highlight-trailing-whitespace)