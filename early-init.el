;;; early-init.el --- Disable package.el; straight.el manages everything -*- lexical-binding: t; -*-
(setq package-enable-at-startup nil)

;; The default 800 KB threshold makes GC run several times per keystroke in a
;; 1 MB org buffer. 64 MB keeps typing responsive at the cost of some memory.
(setq gc-cons-threshold (* 64 1024 1024))
;;; early-init.el ends here
