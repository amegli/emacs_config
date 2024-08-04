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
																				;(eshell/clear . eshell/clear-scrollback)))

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
