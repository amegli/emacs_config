(add-to-list 'treesit-language-source-alist
             '(ruby "https://github.com/tree-sitter/tree-sitter-ruby"))

(add-to-list 'major-mode-remap-alist '(ruby-mode . ruby-ts-mode))

(provide 'init-ruby)
