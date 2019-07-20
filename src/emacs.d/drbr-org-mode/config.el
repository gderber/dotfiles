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

;; Org Mode Variables
(custom-set-variables
 ;; Files and Directories
 '(org-directory "~/Documents/Org/")
 '(org-default-notes-file "~/Documents/Org/notes.org")
 '(org-archive-location "~/Documents/Org/archive.org")
 ;; Agenda Settings
 '(org-agenda-ndays 14)
 '(org-agenda-show-all-dates t)
 '(org-agenda-start-on-weekday nil)
 '(org-agenda-include-diary t)
 '(org-agenda-skip-deadline-if-done t)
 '(org-agenda-skip-scheduled-if-done t)
 '(org-agenda-skip-timestamp-if-done t)
 '(org-reverse-note-order t)
 '(org-agenda-sorting-strategy '((agenda ts-up habit-down time-up priority-down category-keep)
                                 (todo priority-down category-keep)
                                 (tags priority-down category-keep)
                                 (search category-keep)))
 ;; Logging / Habit Tracking
 '(org-log-into-drawer "LOGBOOK")
 '(org-log-done-with-time t)
 '(org-log-states-order-reversed t)
 '(org-log-redeadline t)
 '(org-log-reschedule '(time))
 '(org-log-redeadline '(time))
 '(org-fast-tag-selection-single-key (quote expert))
 '(org-use-fast-todo-selection t)
 '(org-treat-S-cursor-todo-selection-as-state-change nil)
 ;; Todo Settings
 '(org-enforce-todo-dependencies t)
 '(org-enforce-todo-checkbox-dependencies t)
 '(org-deadline-warning-days 14)
 ;; Prepare for export backends
 '(org-export-backends '(org latex icalendar html ascii))

  )
;;(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
;;(add-to-list 'auto-mode-alist '("\\.org.gpg$" . org-mode))
;;(add-to-list 'auto-mode-alist '("\\.ref$" . org-mode))

;;(add-to-list 'auto-mode-alist '("\\.ref.gpg$" . org-mode))
;;(add-to-list 'auto-mode-alist '("\\.nnotes$" . org-mode))
;;(add-to-list 'auto-mode-alist '("\\.nnotes.gpg$" . org-mode))

;; Files and Directories
;(setq org-agenda-file-regexp )
;;(setq org-agenda-files "~/Documents/Org/*")
(setq org-agenda-files (list "~/Documents/Org/work.org"
                             "~/Documents/Org/personal.org"))
;; Todo Options
(setq org-todo-state-tags-triggers
      '(("CANCELLED" ("CANCELLED" . t))
        ("WAITING" ("WAITING" . t))
        ("HOLD" ("WAITING") ("HOLD" . t))
        (done ("WAITING") ("HOLD"))
        ("TODO" ("WAITING") ("CANCELLED") ("HOLD"))
        ("NEXT" ("WAITING") ("CANCELLED") ("HOLD"))
        ("DONE" ("WAITING") ("CANCELLED") ("HOLD"))))

(setq org-todo-keywords
      '(;; Sequent for TODOs
        (sequence "TODO(t@/!)" "WAITING(w@/!)" "DELEGATED(d@/!)" "HOLD(h@/!)" "FEEDBACK(f@/!)" "VERIFY(v@/!)" "|" "DONE()" "DELEGATED")
        ;; Sequence for Bugs
        (sequence "NEW(n!)" "CONFIRMED" "ASSIGNED" "IN PROGRESS" "|" "INVALID" "COMPLETE" "VERIFIED" "CLOSED")
        ;; Sequence for POSSESSIONS
        (sequence "PURCHASE(p@/!)" "PURCHASED(j@/!)" "TRANSIT(u@/!)" "GIFT(h@/!)" "SELL(k@/!)" "LOANED(n@/!)" "|" "UNWANTED(a@/!)" "OWN(o@/!)" "GIFTED(g@/!)"  "SOLD(c@/!)" "DISCARDED(q@/!)")
        ;; Sequence for MULTIMEDIA
        (sequence "CONSUME(r@/!)" "SUBSCRIBE(b@/!)" "CONSUMING(l@/!)" "SHARE(s@/!)" "|" "IGNORED(i@/!)" "REFERENCE(f@/!)")
        ;; Sequence for EVENTS
        (sequence "VISIT(v@/!)" "|" "DIDNOTGO(z@/!)" "MEETING(m@/!)" "VISITED(y@/!)")))

;; Setting Colours (faces) for todo states to give clearer view of work 
(setq org-todo-keyword-faces
      '(("TODO" :foreground "red" :weight bold)
        ("NEXT" :foreground "blue" :weight bold)
        ("DONE" :foreground "forest green" :weight bold)
        ("WAITING" :foreground "orange" :weight bold)
        ("HOLD" :foreground "magenta" :weight bold)
        ("CANCELLED" :foreground "forest green" :weight bold)
        ("MEETING" :foreground "forest green" :weight bold)
        ("PHONE" :foreground "forest green" :weight bold)))
;;
(setq org-agenda-custom-commands
      '(("d" todo "DELEGATED" nil)
        ("c" todo "DONE|DEFERRED|CANCELLED" nil)
        ("w" todo "WAITING" nil)
        ("f" agenda "" ((org-agenda-fortnight-view)))
        ("W" agenda "" ((org-agenda-ndays 21)))
        ("A" agenda ""
         ((org-agenda-skip-function
           (lambda nil
             (org-agenda-skip-entry-if (quote notregexp) "\\=.*\\[#A\\]")))
          (org-agenda-ndays 1)
          (org-agenda-overriding-header "Today's Priority #A tasks: ")))
        ("u" alltodo ""
         ((org-agenda-skip-function
           (lambda nil
             (org-agenda-skip-entry-if (quote scheduled) (quote deadline)
                                       (quote regexp) "\n]+>")))
          (org-agenda-overriding-header "Unscheduled TODO entries: ")))))


;; (setq org-super-agenda-groups
;;       '( ;; Each group has an implicit boolean OR operator between its selectors.
;;         (:name "Today"          ; Optionally specify section name
;;                :time-grid t     ; Items that appear on the time grid
;;                )
;;         (:name "Important" :priority "A")
;;         (:priority<= "B"
;;                      ;; Show this section after "Today" and "Important", because
;;                      ;; their order is unspecified, defaulting to 0. Sections
;;                      ;; are displayed lowest-number-first.
;;                      :order 1)
;;         (:name "Habits" :habit t :order 2)
;;         (:name "Shopping" :tag "Besorgung" :order 3)
;;         ;; Boolean AND group matches items that match all subgroups
;;         ;;  :and (:tag "shopping" :tag "@town")
;;         ;; Multiple args given in list with implicit OR
;;         ;;  :tag ("food" "dinner"))
;;         ;;  :habit t
;;         ;;  :tag "personal")
;;         (:name "Started" :todo "STARTED" :order 5)
;;         ;;(:name "Space-related (non-moon-or-planet-related)"
;;         ;;       ;; Regexps match case-insensitively on the entire entry
;;         ;;       :and (:regexp ("space" "NASA")
;;         ;;                     ;; Boolean NOT also has implicit OR between selectors
;;         ;;                     :not (:regexp "moon" :tag "planet")))
;;         (:name "BWG" :tag "@BWG" :order 7)
;;         (:todo "WAITING" :order 9)    ; Set order of this section
;;         (:name "read" :tag "2read" :order 15)
;;         ;; Groups supply their own section names when none are given
;;         (:todo ("SOMEDAY" "WATCHING")
;;                ;; Show this group at the end of the agenda (since it has the
;;                ;; highest number). If you specified this group last, items
;;                ;; with these todo keywords that e.g. have priority A would be
;;                ;; displayed in that group instead, because items are grouped
;;                ;; out in the order the groups are listed.
;;                :order 25)
;;         (:name "reward"
;;                :tag ("reward" "lp")
;;                :order 100)
;;         ;; After the last group, the agenda will display items that didn't
;;         ;; match any of these groups, with the default order position of 99
;;                  ))

;; Hooks
(add-hook 'org-after-todo-statistics-hook 'org-summary-todo)

;;(with-eval-after-load 'org-agenda
;;  (require 'org-projectile)
;;  (push (org-projectile-todo-files) org-agenda-files))

(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(add-to-list 'auto-mode-alist '("\\.org.gpg$" . org-mode))
(add-to-list 'auto-mode-alist '("\\.ref$" . org-mode))
(add-to-list 'auto-mode-alist '("\\.ref.gpg$" . org-mode))
(add-to-list 'auto-mode-alist '("\\.nnotes$" . org-mode))
(add-to-list 'auto-mode-alist '("\\.nnotes.gpg$" . org-mode))

(spacemacs|define-custom-layout "@Drbr-Org"
  :binding "O"
  :body
  (split-window-right)
  (winum-select-window-1)
  (let ((agenda-files (org-agenda-files)))
    (if agenda-files
        (find-file (first agenda-files))
      (user-error "Error: No agenda files configured, nothing to display.")))
  (winum-select-window-2)
  (org-agenda-list 14)
  (winum-select-window-1))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; config.el ends here
