(use-package eglot
  :hook (prog-mode . eglot-ensure))

(use-package consult-eglot)

(define-key minibuffer-local-map (kbd "C-c C-n") #'evil-normal-state)

;; Attempt to guess indent style of buffer
(use-package dtrt-indent
  :init (dtrt-indent-global-mode t))

;; Async formatting after save
(use-package apheleia
  :hook (prog-mode . apheleia-mode)
  :config
  (add-to-list 'apheleia-mode-alist '(js-mode . prettier))
  (add-to-list 'apheleia-mode-alist '(php-mode . prettier))
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

(setq eldoc-echo-area-prefer-doc-buffer t)
(setq eldoc-idle-delay .1)
(setq eldoc-echo-area-use-multiline-p 4)

(use-package racket-mode)
(use-package yaml-mode)
(use-package purescript-mode)

(use-package copilot
  :straight (:host github :repo "copilot-emacs/copilot.el" :files ("dist" "*.el"))
  :config
  (setq copilot-idle-delay 60)
  (global-set-key (kbd "C-'") 'copilot-complete)
  :hook (prog-mode-hook . copilot-mode)
  :bind (:map copilot-completion-map
              ("<tab>" . 'copilot-accept-completion)
              ("TAB" . 'copilot-accept-completion)
              ("C-TAB" . 'copilot-accept-completion-by-word)
              ("C-<tab>" . 'copilot-accept-completion-by-word)))

(provide 'init-code)
