
(use-package lsp-mode
  :init
  (setq lsp-keymap-prefix "C-c l")
	:config
	(setq lsp-headerline-breadcrumb-enable nil)
  :hook (
         (javascript-mode . lsp)
         (typescript-mode . lsp)
         (js-mode . lsp)
         (typescript-tsx-mode . lsp)
         (haskell-mode . lsp)
         (elixir-mode . lsp)
         (php-mode . lsp)
         (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp)
(use-package lsp-treemacs :commands lsp-treemacs-errors-list)
(use-package lsp-ui
  :config
  (setq lsp-ui-peek-enable t)
  (setq lsp-ui-peek-show-directory t)
  (setq lsp-ui-doc-enable t)
  (setq lsp-ui-doc-position 'at-point))
