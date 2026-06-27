(add-hook 'js-mode-hook 'eglot-ensure)
(add-hook 'js2-mode-hook 'eglot-ensure)
(add-hook 'elixir-mode-hook 'eglot-ensure)
(add-hook 'haskell-mode-hook 'eglot-ensure)
(add-hook 'php-mode-hook 'eglot-ensure)
(add-hook 'racket-mode-hook 'eglot-ensure)
(add-hook 'tsx-ts-mode-hook 'eglot-ensure)
(add-hook 'typescript-ts-mode-hook 'eglot-ensure)
(add-hook 'typescript-mode-hook 'eglot-ensure)
(add-hook 'ruby-ts-mode-hook 'eglot-ensure)
(add-hook 'ruby-mode-hook 'eglot-ensure)
(add-hook 'clojurescript-mode-hook 'eglot-ensure)
(add-hook 'clojure-mode-hook 'eglot-ensure)

(use-package flycheck-eglot
  :after (flycheck eglot)
  :config
  (global-flycheck-eglot-mode 1))

(use-package eldoc-box
  :commands eldoc-box-help-at-point
  :init
  (with-eval-after-load 'evil
    (evil-define-key 'normal 'global "K" #'eldoc-box-help-at-point)))

(use-package consult-eglot)

(setq eldoc-idle-delay .1)

(provide 'init-eglot)
