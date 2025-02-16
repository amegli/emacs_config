(use-package projectile
  :config (projectile-mode)
  :bind-keymap ("C-c p" . projectile-command-map)
  :custom ((projectile-completion-system 'default))
  :init
  (when (file-directory-p "~/Development")
    (setq projectile-project-search-path '("~/Development")))
  (setq projectile-switch-project-action #'projectile-dired))

(setq dired-dwim-target t)

(use-package perspective
  :ensure t
  :straight t
  :custom
  (persp-mode-prefix-key (kbd "C-c M-p")) 
  :init
  (persp-mode))

(use-package dired-single)

(use-package nerd-icons-dired
  :hook
  (dired-mode . nerd-icons-dired-mode))

(use-package rg)

(setq dired-auto-revert-buffer t)

(provide 'init-project)
