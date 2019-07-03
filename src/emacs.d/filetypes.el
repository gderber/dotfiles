;;(add-to-list 'auto-mode-alist '(".*_EDITMSG\\'" . log-entry-mode))
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'auto-mode-alist '("ssh*_config" . conf-mode))
(add-to-list 'auto-mode-alist '("screenrc" . conf-mode))
(add-to-list 'auto-mode-alist '("\\.cnf\\'" . conf-mode))
(add-to-list 'auto-mode-alist '(".profile" . shell-script-mode))
(add-to-list 'auto-mode-alist '("profile" . shell-script-mode))


;; Org Mode
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(add-to-list 'auto-mode-alist '("\\.org.gpg$" . org-mode))
(add-to-list 'auto-mode-alist '("\\.ref$" . org-mode))
(add-to-list 'auto-mode-alist '("\\.ref.gpg$" . org-mode))
(add-to-list 'auto-mode-alist '("\\.nnotes$" . org-mode))
(add-to-list 'auto-mode-alist '("\\.nnotes.gpg$" . org-mode))
