(use-package clojure-mode)
(use-package cider
	:after clojure-mode
  :config
  (setq cider-preferred-build-tool 'clojure-cli)
  (setq cider-repl-pop-to-buffer-on-connect nil)
  (setq cider-repl-use-pretty-printing t)
	(setq cider-allow-jack-in-without-project t)
  (setq cider-eldoc-display-for-symbol-at-point t))

(use-package paredit
  :hook ((clojure-mode . paredit-mode)
         (cider-repl-mode . paredit-mode)))

(with-eval-after-load 'evil
  (evil-define-key 'normal clojure-mode-map
    "K" #'cider-doc)
  (evil-define-key 'normal cider-repl-mode-map
    "K" #'cider-doc))

(provide 'init-clojure)
