(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("org" . "https://orgmode.org/elpa/")
			 ("elpa" . "https://elpa.gnu.org/packages/")))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

;; Set a custom file for Emacs customizations
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))


;; ******** Modify auto-save behavior ******
(defvar my-auto-save-folder (expand-file-name "~/.emacs.d/auto-saves/"))
(unless (file-exists-p my-auto-save-folder)
  (make-directory my-auto-save-folder t))
(setq auto-save-file-name-transforms `((".*" ,my-auto-save-folder t)))
;; ***************************************** 


;; **************** UI *************************
(setq inhibit-startup-message t)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(set-fringe-mode 10)
(menu-bar-mode -1)
(use-package doom-themes
  :init (load-theme 'doom-gruvbox-light t))
;; https://github.com/seagle0128/doom-modeline
(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))
;; **************** /UI *************************


;; **************** COMPLETION *************************
;; Ivy "a generic completion mechanism for Emacs."
;; https://github.com/abo-abo/swiper
;; https://oremacs.com/swiper/
(use-package counsel
  :bind (("M-x" . counsel-M-x)
	 ("C-x b" . counsel-ibuffer)
	 ("C-x C-f" . counsel-find-file)
	 :map minibuffer-local-map
	 ("C-r" . counsel-minibuffer-history)))
(use-package ivy
  :bind (("C-s" . swiper)
	 :map ivy-minibuffer-map
	 ("TAB" . ivy-alt-done)
	 ("C-l" . ivy-alt-done)
	 ("C-j" . ivy-next-line)
	 ("C-k" . ivy-previous-line)
	 :map ivy-switch-buffer-map
	 ("C-k" . ivy-previous-line)
	 ("C-l" . ivy-done)
	 ("C-d" . ivy-switch-buffer-kill)
	 :map ivy-reverse-i-search-map
	 ("C-k" . ivy-previous-line)
	 ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))
;; **************** /COMPLETION *************************


(use-package command-log-mode)

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package which-key
  :init (which-key-mode)
  :config
  (setq which-key-idle-delay 0.1))

(use-package ivy-rich
  :init (ivy-rich-mode 1))


;; **************** HELPFUL *************************
;; Helpful is an alternative to the built-in Emacs help that provides much more
;; contextual information.
(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))
;; **************** /HELPFUL *************************


;; **************** EVIL *************************
(use-package evil
  :init 
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  :config
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state))

;; https://github.com/emacs-evil/evil-collection
;; This is a collection of Evil bindings for the parts of Emacs that Evil does not cover properly by default, such as help-mode, M-x calendar, Eshell and more.
(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))
;; **************** /EVIL *************************


;; **************** PROJECT *************************
(use-package projectile
  :config (projectile-mode)
  :bind-keymap ("C-c p" . projectile-command-map)
  :custom ((projectile-completion-system 'ivy))
  :init
  (when (file-directory-p "~/Development")
    (setq projectile-project-search-path '("~/Development")))
  (setq projectile-switch-project-action #'projectile-dired))
;; Counsel-projectile provides further ivy integration into projectile by taking
;; advantage of ivy's support for selecting from a list of actions and applying
;; an action without leaving the completion session.
(use-package counsel-projectile
  :config (counsel-projectile-mode))

(use-package dired-single)
(use-package all-the-icons-dired
  :hook (dired-mode . all-the-icons-dired-mode))
;; **************** /PROJECT *************************


;; **************** LINE NUMBERS *************************
;; Disable line numbers for certain modes
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
;; **************** /LINE NUMBERS *************************


;; **************** MAGIT *************************
(use-package magit
  :commands (magit-status magit-get-current-branch))

(use-package git-gutter
  :init (global-git-gutter-mode t))
;; **************** /MAGIT *************************


;; **************** ORG *************************
(use-package org
  :config
  (setq org-hide-emphasis-markers t)
  )
;; **************** /ORG *************************


;; **************** LSP *************************
(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :init
  (setq lsp-keymap-prefix "C-c l")
  (setq lsp-haskell-server-path "haskell-language-server-wrapper")
  :hook (
	 (haskell-mode . lsp-deferred)
	 (haskell-literate-mode . lsp-deferred)
	 (lsp-mode . lsp-enable-which-key-integration))
  :custom ((projectile-completion-system 'ivy))
  )
(use-package lsp-ui
  :hook (lsp-mode . lsp-ui-mode)
  :custom
  (lsp-ui-doc-position 'bottom))
(use-package lsp-haskell)
(use-package lsp-treemacs
  :after lsp)
(use-package lsp-ivy)
(use-package haskell-mode)
(use-package typescript-mode
  :mode ("\\.ts\\'"
	 "\\.js\\'"
	 "\\.ssp\\'"
	 "\\.ss\\'")
  :hook (typescript-mode . lsp-deferred))
(use-package json-mode)
;; **************** /LSP *************************


;; **************** CODE COMPLETION *************************
(use-package company
  :after lsp-mode
  :hook (lsp-mode . global-company-mode)
  :bind (:map company-active-map
         ("<tab>" . company-complete-selection))
        (:map lsp-mode-map
         ("<tab>" . company-indent-or-complete-common))
  :custom
  (company-minimum-prefix-length 1)
  (company-idle-delay 0.0))
(use-package company-box
  :hook (company-mode . company-box-mode))
;; **************** /CODE COMPLETION *************************


;; **************** TERMINAL *************************
(defun mgli/bottom-eshell ()
  (interactive)
  (split-window-below -30)
  (other-window 1)
  (set-window-parameter (selected-window) 'is-mgli-eshell t)
  (eshell))

(defun mgli/close-bottom-eshell (orig-fun &rest args)
  (let ((is-mgli-eshell (window-parameter (selected-window) 'is-mgli-eshell)))
    (apply orig-fun args)
    (when is-mgli-eshell
      (delete-window))))

(advice-add 'eshell-life-is-too-much :around #'mgli/close-bottom-eshell)

(use-package vterm
    :ensure t)

(use-package eshell-git-prompt)
(use-package eshell
  :hook 
  (eshell-pre-command-hook . eshell-save-some-history)
  :config
  (with-eval-after-load 'esh-opt
    (setq eshell-destroy-buffer-when-process-dies t)
    (setq eshell-visual-commands '("htop" "zsh" "vim")))
  (eshell-git-prompt-use-theme 'powerline))
;; **************** \TERMINAL *************************


;; **************** FORMATTING *************************
;; Requires https://github.com/tweag/ormolu
(use-package ormolu
 :hook (haskell-mode . ormolu-format-on-save-mode)
 :bind
 (:map haskell-mode-map
   ("C-c r" . ormolu-format-buffer)))
;; **************** /FORMATTING *************************


;; **************** KEYS *************************
;; https://github.com/noctuid/general.el/tree/master
;; general.el provides a more convenient method for binding keys in emacs (for both evil and non-evil users).
(use-package general
  :after evil
  :config
  (general-evil-setup t)
  (general-create-definer mgli/leader-def
    :states '(normal motion emacs)
    :keymaps 'override
    :prefix "SPC")
  (mgli/leader-def
    :states '(normal motion emacs)
    :keymaps 'override
    "f" (cons "files" (make-sparse-keymap))
    "ff" 'find-file
    "fd" 'dired-jump

    "p" (cons "project" (make-sparse-keymap))
    "pp" 'projectile-switch-project
    "pf" 'counsel-projectile-find-file
    "ps" 'counsel-projectile-rg

    "g" (cons "magit" (make-sparse-keymap))
    "gg" 'magit
    "gb" 'magit-blame-addition

    "t" (cons "terminal" (make-sparse-keymap))
    "tb" 'mgli/bottom-eshell
    "te" 'eshell
    "tv" 'vterm

    "h" (cons "help" (make-sparse-keymap))
    "hh" 'help
    "ha" 'apropos-command
    "hb" 'describe-bindings
    "hk" 'describe-key

    "b" (cons "buffer" (make-sparse-keymap))
    "bl" 'list-buffers
    "bk" 'kill-buffer

    "c" (cons "code" (make-sparse-keymap))
    "cc" 'comment-dwim
   )
)
;; **************** /KEYS *************************

(fringe-mode 0)
(column-number-mode)


(use-package dashboard
  :ensure t
  :init
  (setq dashboard-banner-logo-title
	(mapconcat #'identity
	'(" ___ __ __   _______    __        ________ ... "
	  "/__//_//_/\\ /______/\\  /_/\\      /_______/\\    "
	  "\\::\\| \\| \\ \\\\::::__\\/__\\:\\ \\     \\__.::._\\/    "
	  " \\:.      \\ \\\\:\\ /____/\\\\:\\ \\       \\::\\ \\     "
	  "  \\:.\\-/\\  \\ \\\\:\\\\_  _\\/ \\:\\ \\____  _\\::\\ \\__  "
	  "   \\. \\  \\  \\ \\\\:\\_\\ \\ \\  \\:\\/___/\\/__\\::\\__/\\ "
	  "    \\__\\/ \\__\\/ \\_____\\/   \\_____\\/\\________\\/ ")
	"\n"))
  (setq dashboard-startup-banner nil)
  (setq dashboard-icon-type 'all-the-icons)
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  (setq dashboard-set-init-info t)
  (setq dashboard-projects-backend 'projectile)
  (setq dashboard-center-content t)
  (setq dashboard-items '((recents   . 5)
                        (bookmarks . 5)
                        (projects  . 5)
                        (agenda    . 5)
                        (registers . 5)))
  (dashboard-setup-startup-hook)
  (dashboard-open))

