(use-package flycheck
  :config
  (setq flycheck-highlighting-mode nil
        flycheck-display-errors-delay most-positive-fixnum
        flycheck-indication-mode 'left-fringe)
  (global-flycheck-mode 1)
  (with-eval-after-load 'evil
    (evil-define-key 'normal 'global "E"
      (lambda () (interactive)
        (flycheck-display-error-at-point)))))

(provide 'init-flycheck)
