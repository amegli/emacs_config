(advice-add 'eshell-life-is-too-much :around #'mgli/close-bottom-eshell)

(use-package vterm
  :ensure t)

(use-package eat
	:straight t
  :custom
  (eat-term-name "xterm-256color")
  :custom-face
  (ansi-color-bright-blue ((t (:foreground "#00afff" :background "#00afff"))))
  :config
  (evil-set-initial-state 'eat-mode 'emacs)
  (eat-eshell-mode)
  (eat-eshell-visual-command-mode))

(use-package eshell-git-prompt)
(use-package eshell
  :hook 
  (eshell-pre-command-hook . eshell-save-some-history)
  :config
  (with-eval-after-load 'esh-opt
    (setq eshell-destroy-buffer-when-process-dies t)
    (setq eshell-visual-commands '("htop" "zsh" "vim")))
  (eshell-git-prompt-use-theme 'git-radar))

(use-package eshell-up)

;; https://www.emacswiki.org/emacs/EshellAlias
(setq my/eshell-aliases
      '((g  . magit)
				(gl . magit-log)
				(d  . dired)
				(o  . find-file)	
				(oo . find-file-other-window)
				(up . eshell-up)
				(pk . eshell-up-peek)
				(l  . (lambda () (eshell/ls '-la)))
				(eshell/clear . eshell/clear-scrollback)))

(mapc (lambda (alias)
				(defalias (car alias) (cdr alias)))
      my/eshell-aliases)

(setq term-buffer-maximum-size 10000) 
(setq eshell-buffer-maximum-lines 10000)

(use-package eshell-syntax-highlighting
  :after eshell-mode
  :ensure t 
  :config
  (eshell-syntax-highlighting-global-mode +1))

(setq tramp-default-method "ssh")

(provide 'init-terminal)
