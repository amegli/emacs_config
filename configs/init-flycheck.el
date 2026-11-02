(use-package flycheck
  :config
  (setq flycheck-highlighting-mode nil
        flycheck-display-errors-delay most-positive-fixnum
        flycheck-indication-mode 'left-fringe)
  ;; org-lint reruns on every idle pause and takes ~0.7 s on a 1 MB org file.
  ;; Its misplaced-heading check also flags prose like =** Notes= and lands
  ;; every hit on the first line of a narrowed buffer. Not useful for notes.
  (setq-default flycheck-disabled-checkers '(org-lint))
  (global-flycheck-mode 1)
  (with-eval-after-load 'evil
    (evil-define-key 'normal 'global "E"
      (lambda () (interactive)
        (flycheck-display-error-at-point)))))

(provide 'init-flycheck)
