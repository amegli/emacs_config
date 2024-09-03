
(add-to-list 'default-frame-alist '(fullscreen . maximized))

(use-package all-the-icons
  :if (display-graphic-p))

(setq inhibit-startup-message t)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(set-fringe-mode 10)
(menu-bar-mode -1)

(set-face-attribute 'default nil :font "Hack Nerd Font Mono")

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package doom-themes
  :init (load-theme 'doom-zenburn t))

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))

(use-package default-text-scale
	:init (default-text-scale-mode))

(use-package treemacs)

(global-display-line-numbers-mode 1)

(defun disable-line-numbers-mode-hook()
  (display-line-numbers-mode 0)
  (message "Disabling line numbers for %s" major-mode))

(dolist (mode `(org-mode-hook
								term-mode-hook
								shell-mode-hook
								treemacs-mode-hook
								dashboard-mode-hook
								eshell-mode-hook))
  (add-hook mode 'disable-line-numbers-mode-hook))

(fringe-mode 0)
(column-number-mode)

(use-package spacious-padding
	:init
	(spacious-padding-mode 1))

(setq display-buffer-alist
			'(("\\*Help\\*"
				 (display-buffer-below-selected)
				 (window-height . 0.5)
				 (reusable-frames . nil)
				 (window . selected-window))))

(setq help-window-select t)

(provide 'init-ui)
