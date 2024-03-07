(use-package eglot
  :hook (prog-mode . eglot-ensure))
(use-package consult-eglot)
(use-package dtrt-indent
  :init (dtrt-indent-global-mode t))
(use-package apheleia
  :ensure t
  :hook (prog-mode . apheleia-mode))
(setq-default tab-width 2)
(setq-default indent-tabs-mode t)

(use-package flycheck
  :ensure t
  :config
  (setq flycheck-highlighting-mode 'lines)
  (setq flycheck-display-errors-delay 0.2)
  (add-hook 'after-init-hook #'global-flycheck-mode))

(use-package flycheck-eglot
  :ensure t
  :after (flycheck eglot)
  :config
  (global-flycheck-eglot-mode 1))

(use-package flycheck-inline
  :after flycheck
  :hook (flycheck-mode-hook . flycheck-inline-mode))

(provide 'init-code)
