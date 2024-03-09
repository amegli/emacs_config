(use-package dashboard
  :ensure t
  :init
  (setq dashboard-banner-logo-title
				(mapconcat #'identity
									 '(" ___ __ __   _______    __        ________ ... "
										 "/__//_//_/\\ /______/\\  /_/\\      /_______/\\    "
										 "\\::\\| \\| \\ \\\\::::__\\/__\\:\\ \\     \\__.::._\\/    "
										 " \\:.      \\ \\\\:\\ /____/\\\\:\\ \\       \\::\\ \\     "
										 "  \\:.\\-/\\  \\ \\\\:\\\\_  _\\/ \\:\\ \\____  _\\::\\ \\__  "
										 "   \\. \\  \\  \\ \\\\:\\_\\ \\ \\  \\:\\/___/\\/__\\::\\__/\\ "
										 "    \\__\\/ \\__\\/ \\_____\\/   \\_____\\/\\________\\/ ")
									 "\n"))
  (setq dashboard-startup-banner nil)
  (setq dashboard-icon-type 'all-the-icons)
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  (setq dashboard-set-init-info t)
  (setq dashboard-projects-backend 'projectile)
  (setq dashboard-center-content t)
  (setq dashboard-items '((recents   . 5)
                          (bookmarks . 5)
                          (projects  . 5)
                          (agenda    . 5)
                          (registers . 5)))
  (dashboard-setup-startup-hook)
  (dashboard-open))

(provide 'init-dashboard)
