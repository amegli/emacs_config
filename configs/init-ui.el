(add-to-list 'default-frame-alist '(fullscreen . maximized))

(use-package nerd-icons)
(use-package treemacs-nerd-icons
  :after treemacs
  :config (treemacs-load-theme "nerd-icons"))

(setq inhibit-startup-message t)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(set-fringe-mode 10)
(menu-bar-mode -1)

(set-face-attribute 'default nil :font "Hack Nerd Font Mono")

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package ef-themes)
(use-package doom-themes)

(defvar my/ember-palette
  '((base0 . "#151412") (base1 . "#1c1b19") (base2 . "#252422")
    (base3 . "#2e2d2a") (base4 . "#3e3c38") (base5 . "#585550")
    (base6 . "#706c61") (base7 . "#908a7e") (base8 . "#b8b0a0")
    (bg . "#1c1b19") (bg-alt . "#222120")
    (fg . "#d8d0c0") (fg-alt . "#b0a898")
    (red . "#e08060") (orange . "#c09058") (yellow . "#c8b468")
    (green . "#8a9868") (blue . "#7890a0") (teal . "#789080")
    (cyan . "#80a090") (magenta . "#b07878") (violet . "#988090")))

(defun my/ember-fix-face-args (args)
  "Resolve palette symbols leaked into :box :color by doom-themes macro."
  (let* ((face (car args))
         (rest (cdr args))
         ;; set-face-attribute allows optional FRAME before the plist
         (has-frame (and rest
                         (or (null (car rest)) (framep (car rest))
                             (eq (car rest) t) (eq (car rest) 0))))
         (frame (and has-frame (car rest)))
         (plist (if has-frame (cdr rest) rest))
         (box (plist-get plist :box)))
    (when (and (listp box) (symbolp (plist-get box :color)))
      (when-let ((hex (cdr (assq (plist-get box :color) my/ember-palette))))
        (setq box (plist-put (copy-sequence box) :color hex))
        (setq plist (plist-put (copy-sequence plist) :box box))))
    (if has-frame (cons face (cons frame plist)) (cons face plist))))

(advice-add 'set-face-attribute :filter-args #'my/ember-fix-face-args)

(use-package ember-theme
  :vc (:url "https://github.com/ember-theme/emacs" :rev :newest)
  :config
  (add-to-list 'custom-theme-load-path
               (file-name-directory (locate-library "ember-theme")))
  (load-theme 'ember t))

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))

(use-package default-text-scale
  :init (default-text-scale-mode))

(use-package treemacs)

(use-package avy)

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

(use-package pulsar)
(require 'pulsar)
(pulsar-global-mode 1)
(add-hook 'next-error-hook #'pulsar-pulse-line)
(add-hook 'minibuffer-setup-hook #'pulsar-pulse-line)

(setq display-buffer-alist
      '(
				("\\*Help\\*"
				 (display-buffer-below-selected)
				 (window-height . 0.5)
				 (reusable-frames . nil)
				 (window . selected-window))
				("\\*rg\\*"
				 (display-buffer-below-selected)
				 (window-height . 0.5)
				 (reusable-frames . nil)
				 (window . selected-window))
				("\\*Flycheck errors\\*"
				 (display-buffer-below-selected)
				 (window-height . 0.5)
				 (reusable-frames . nil)
				 (window . selected-window))
				("\\*jest\\*"
				 (display-buffer-below-selected)
				 (window-height . 0.5)
				 (reusable-frames . nil)
				 (window . selected-window))
				("\\*jest-test-compilation\\*"
				 (display-buffer-below-selected)
				 (window-height . 0.5)
				 (reusable-frames . nil)
				 (window . selected-window))
				("\\*mgli-milton-output\\*"
				 (display-buffer-below-selected)
				 (window-height . 0.5)
				 (reusable-frames . nil)
				 (window . selected-window))
				)
      )

(setq help-window-select t)

(use-package mini-frame)
(custom-set-variables
 '(mini-frame-show-parameters
   '((top . 0.3)
     (width . 0.7)
     (left . 0.5))))

(provide 'init-ui)
