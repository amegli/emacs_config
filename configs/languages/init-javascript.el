(use-package json-mode)

(use-package js2-mode)

(use-package web-mode
  :config
  (setq web-mode-content-types-alist
        '(("ejs" . "\\.ssp\\'"))))

(use-package jest-test-mode
  :ensure t
  :commands jest-test-mode
  :hook (typescript-mode js-mode typescript-tsx-mode typescript-ts-mode))

(add-hook 'js-mode-hook
					(lambda ()
						(setq js-indent-level 2)))

(use-package jest)

(setq treesit-language-source-alist
      '((tsx        "https://github.com/tree-sitter/tree-sitter-typescript" "master" "tsx/src")
        (typescript "https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src")))

(use-package typescript-ts-mode
  :mode ("\\.ts\\'" . typescript-ts-mode))

(use-package tsx-ts-mode
	:ensure nil
  :mode ("\\.tsx\\'" . tsx-ts-mode))

(add-to-list 'auto-mode-alist '("\\.toast\\'" . json-mode))
(add-to-list 'auto-mode-alist '("\\.ssp\\'" . web-mode))

(provide 'init-javascript)
