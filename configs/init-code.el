(use-package eglot
  :hook (prog-mode . eglot-ensure))

(use-package consult-eglot)

;; Attempt to guess indent style of buffer
(use-package dtrt-indent
  :init (dtrt-indent-global-mode t))

;; Async formatting after save
(use-package apheleia
  :ensure t
  :hook (prog-mode . apheleia-mode))

(setq-default tab-width 2)
(setq-default indent-tabs-mode t)

(use-package flycheck
  :ensure t
  :config
  (setq flycheck-highlighting-mode 'lines)
  (setq flycheck-display-errors-delay 0.01)
  (add-hook 'after-init-hook #'global-flycheck-mode))

(use-package flycheck-eglot
  :ensure t
  :after (flycheck eglot)
  :config
  (global-flycheck-eglot-mode 1))

(use-package flycheck-pos-tip
  :hook (flycheck-mode . flycheck-pos-tip-mode))

(setq eldoc-echo-area-prefer-doc-buffer t)
(setq eldoc-idle-delay .1)
(setq eldoc-echo-area-use-multiline-p nil)

(use-package racket-mode)

(provide 'init-code)
