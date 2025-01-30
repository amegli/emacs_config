(use-package json-mode)

(use-package jest-test-mode
  :ensure t
  :commands jest-test-mode
  :hook (typescript-mode js-mode typescript-tsx-mode))

(use-package jest)

(add-to-list 'auto-mode-alist '("\\.toast\\'" . json-mode))

(provide 'init-javascript)
