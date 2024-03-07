
;; (use-package haskell-mode
;;   :ensure t
;;   :hook ((haskell-mode . subword-mode)
;;          (haskell-cabal-mode . subword-mode)
;;          (haskell-mode . interactive-haskell-mode)
;;          (haskell-mode . turn-on-haskell-indentation)
;;          (haskell-mode . haskell-auto-insert-module-template)))

;; (use-package reformatter
;;   :ensure t
;;   :after haskell-mode
;;   :config
;;   (reformatter-define hindent
;;     :program "hindent"
;;     :lighter " Hin")
;;   (defalias 'hindent-mode 'hindent-on-save-mode)
;;   (reformatter-define ormolu
;;     :program "ormolu"
;;     :lighter " Orm"))

;; (use-package dhall-mode
;;   :ensure t)

;; (use-package page-break-lines
;;   :ensure t
;;   :config
;;   (add-to-list 'page-break-lines-modes 'haskell-mode))

(provide 'init-haskell)
