(use-package flycheck
  :config
  (setq flycheck-highlighting-mode 'symbols)
  (setq flycheck-display-errors-delay 0.01)
  (add-hook 'after-init-hook #'global-flycheck-mode))

(provide 'init-flycheck)
