(use-package eglot
  :hook (prog-mode . eglot-ensure))

(use-package consult-eglot)

;; Attempt to guess indent style of buffer
(use-package dtrt-indent
  :init (dtrt-indent-global-mode t))

;; Async formatting after save
(use-package apheleia
  :hook (prog-mode . apheleia-mode)
  :config
  (add-to-list 'apheleia-mode-alist '(js-mode . prettier))
  (apheleia-global-mode t))

(setq-default tab-width 2)
(setq-default indent-tabs-mode t)

(use-package flycheck
  :config
  (setq flycheck-highlighting-mode 'lines)
  (setq flycheck-display-errors-delay 0.01)
  (add-hook 'after-init-hook #'global-flycheck-mode))

(use-package flycheck-eglot
  :after (flycheck eglot)
  :config
  (global-flycheck-eglot-mode 1))

(use-package flycheck-pos-tip
  :hook (flycheck-mode . flycheck-pos-tip-mode))

(setq eldoc-echo-area-prefer-doc-buffer t)
(setq eldoc-idle-delay .1)
(setq eldoc-echo-area-use-multiline-p nil)

(use-package racket-mode)

(use-package yaml-mode)

;; Worth it??
(use-package dumb-jump
  :hook (xref-backend-functions . dumb-jump-xref-activate))

(use-package copilot
  :straight (:host github :repo "copilot-emacs/copilot.el" :files ("dist" "*.el"))
  :hook (prog-mode-hook . copilot-mode))

(provide 'init-code)
