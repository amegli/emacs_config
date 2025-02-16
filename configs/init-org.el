(defun mgli/org-heading-setup ()
  (dolist (face '((org-level-1 . 1.5)
                  (org-level-2 . 1.3)
                  (org-level-3 . 1.2)
                  (org-level-4 . 1.1)
                  (org-level-5 . 1.0)
                  (org-level-6 . 1.0)
                  (org-level-7 . 1.0)
                  (org-level-8 . 1.0)))
    (set-face-attribute (car face) nil :font "Hack Nerd Font" :weight 'regular :height (cdr face))))

(setq org-agenda-window-setup 'other-tab)

(use-package org
  :straight (:type built-in)
  :config
  (mgli/org-heading-setup)
  )
(add-hook 'org-mode-hook 'org-indent-mode)

(use-package evil-org
  :ensure t
  :after org
  :hook (org-mode . (lambda () evil-org-mode))
  :config
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))

(use-package org-modern
  :config 
  (setq
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

(setq org-use-sub-superscripts nil)
(setq org-export-with-sub-superscripts nil)

;; https://fuco1.github.io/2018-12-23-Multiline-fontification-with-org-emphasis-alist.html
(setcar (nthcdr 4 org-emphasis-regexp-components) 10)

(provide 'init-org)
