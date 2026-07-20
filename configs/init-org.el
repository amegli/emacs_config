(setq org-agenda-window-setup 'other-tab)

(use-package org
  :straight (:type built-in)
  :config
  (mgli/org-heading-setup)
  )
(add-hook 'org-mode-hook 'org-indent-mode)

(setq org-todo-keywords
      '((sequence "TODO" "IN-PROGRESS" "REVIEW" "|" "DONE" "CANCELED")))

(use-package evil-org
  :after org
  :hook (org-mode . evil-org-mode)
  :config
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))

(use-package org-modern
  :config 
  (setq
   ;; --- Headline bullets --------------------------------------------------
   ;; Show a decorative bullet per level (not a fold triangle) so nesting
   ;; depth reads instantly.  Fill state AND shape both change each level.
   org-modern-star 'replace
   org-modern-replace-stars "◉○◆◇▸•··"
   org-modern-hide-stars 'leading
   ;; --- Plain-list bullets ------------------------------------------------
   ;; `-' lists (your most common) render as a real bullet instead of a dash.
   org-modern-list '((?- . "•") (?+ . "◦") (?* . "▹"))
   org-auto-align-tags nil
   org-tags-column 0
   org-catch-invisible-edits 'show-and-error
   org-special-ctrl-a/e t
   org-insert-heading-respect-content t
   org-hide-emphasis-markers t
   org-pretty-entities t
   org-ellipsis "…"
   org-agenda-tags-column 0
   org-agenda-block-separator ?─
   org-agenda-time-grid
   '((daily today require-timed)
     (800 1000 1200 1400 1600 1800 2000)
     " ┄┄┄┄┄ " "┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄")
   org-agenda-current-time-string
   "◀── now ─────────────────────────────────────────────────")
  :after org
  :hook (org-mode . org-modern-mode)
  )

(setq org-agenda-files '("~/Documents/org"))

;; --- Capture -----------------------------------------------------------------
;; Fast, low-friction capture into todo.org's Inbox; process/refile later.
(setq org-directory "~/Documents/org")
(setq org-default-notes-file "~/Documents/org/todo.org")

(setq org-capture-templates
      '(("t" "Todo" entry
         (file+headline "~/Documents/org/todo.org" "Inbox")
         "* TODO %?\n  %U\n  %a"
         :empty-lines 1)

        ;; Meeting notes scaffold. Targets the current year's meeting file
        ;; automatically, then jumps into it so notes are taken in the real
        ;; buffer (not a cramped capture popup).
        ("m" "Meeting" entry
         (file (lambda () (expand-file-name (format-time-string "%Y_meetings.org")
                                            org-directory)))
         "* %^{Meeting} %t :meeting:"
         :immediate-finish t
         :jump-to-captured t
         :empty-lines 1)))

;; --- Refile ------------------------------------------------------------------
;; Where captured Inbox items can be moved. Offer headings up to level 3
;; across every agenda file, with completion showing the full path.
(setq org-refile-targets '((org-agenda-files :maxlevel . 3)))
(setq org-refile-use-outline-path 'file)   ; show file name in refile prompt
(setq org-outline-path-complete-in-steps nil) ; complete whole path at once
(setq org-refile-allow-creating-parent-nodes 'confirm)

(setq org-use-sub-superscripts nil)
(setq org-export-with-sub-superscripts nil)

;; https://fuco1.github.io/2018-12-23-Multiline-fontification-with-org-emphasis-alist.html
(setcar (nthcdr 4 org-emphasis-regexp-components) 10)

(provide 'init-org)
