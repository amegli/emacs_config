(use-package json-mode)

(use-package js2-mode)

(use-package web-mode
  :config
  (setq web-mode-content-types-alist
        '(("ejs" . "\\.ssp\\'"))))

(use-package jest-test-mode
  :ensure t
  :commands jest-test-mode
  :hook (typescript-mode js-mode typescript-tsx-mode))

(add-hook 'js-mode-hook
					(lambda ()
						(setq js-indent-level 2)))

(use-package jest)

(add-to-list 'auto-mode-alist '("\\.toast\\'" . json-mode))
(add-to-list 'auto-mode-alist '("\\.ssp\\'" . web-mode))

(provide 'init-javascript)
