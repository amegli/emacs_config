;;; milton.el --- -*- lexical-binding: t -*-
;;; Commentary:
;; Interact with a locally installed 'milton' application.

;;; Code:
(defvar milton-config-path "/Users/andrewmegli/Development/test/milton/config/"
  "Path to the milton configuration file.")

(defun mgli-milton (action environment)
	"Make milton go"
	(interactive
	 (list
		(read-string "Action (upload, info, diff...) [default upload]: " nil nil "upload")
		(read-string "Environment (dev, test, stage, prod) [default dev]: " nil nil "dev")))
  (let* ((path-arg (unless (string-equal action "command-file") " --path"))
				 (cd-command (if path-arg nil "cd .. && "))
				 (output (shell-command-to-string
									(format (concat cd-command "milton --%s" path-arg " %s --config %s")
													action (shell-quote-argument buffer-file-name)
													(concat (file-name-as-directory milton-config-path) "milton." environment ".config")
													))))
		(with-help-window "*mgli-milton-output*"
			(princ output))))

(defun mgli-milton-command-file (environment)
	"Run milton against the current command file buffer."
	(interactive
	 (list
		(read-string "Environment (dev, test, stage, prod) [default dev]: " nil nil "dev")))
	(mgli-milton "command-file" environment))

(provide 'milton)
;;; milton.el ends here
