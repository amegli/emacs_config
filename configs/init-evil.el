(use-package evil
  :init 
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  :config
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state))

(define-key evil-insert-state-map (kbd "TAB") 'tab-to-tab-stop)

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

(evil-set-undo-system 'undo-redo)

(use-package evil-snipe)
(evil-snipe-mode 1)
(evil-snipe-override-mode 1)
(add-hook 'magit-mode-hook 'turn-off-evil-snipe-override-mode)

;; Make C-. available for embark-act instead
(define-key evil-normal-state-map (kbd "C-.") nil)

(provide 'init-evil)
