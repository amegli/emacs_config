(add-hook 'js-mode-hook 'eglot-ensure)
(add-hook 'js2-mode-hook 'eglot-ensure)
(add-hook 'elixir-mode-hook 'eglot-ensure)
(add-hook 'haskell-mode-hook 'eglot-ensure)
(add-hook 'php-mode-hook 'eglot-ensure)
(add-hook 'racket-mode-hook 'eglot-ensure)

(use-package flycheck-eglot
  :after (flycheck eglot)
  :config
  (global-flycheck-eglot-mode 1))

(use-package eldoc-box)

(setq eldoc-echo-area-prefer-doc-buffer t)
(setq eldoc-idle-delay .1)
(setq eldoc-echo-area-use-multiline-p 4)

(provide 'init-eglot)
