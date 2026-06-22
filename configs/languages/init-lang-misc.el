(use-package php-mode)
(use-package racket-mode)
(use-package yaml-mode)
(use-package purescript-mode)
(use-package brainfuck-mode)
(use-package markdown-mode)
(use-package terraform-mode)

(setq-default tab-width 2)
(setq-default evil-shift-width 2)
(setq-default indent-tabs-mode t)
(electric-pair-mode 1)

(use-package treesit-auto
  :config
  (setq treesit-auto-install 'prompt)
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))

;; Async formatting after save
(use-package apheleia
  :hook (prog-mode . apheleia-mode)
  :config
  (add-to-list 'apheleia-mode-alist '(js-mode . prettier))
  (add-to-list 'apheleia-mode-alist '(php-mode . prettier))
  (apheleia-global-mode t))

(provide 'init-lang-misc)
