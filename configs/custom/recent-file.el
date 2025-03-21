;;; recent-file.el --- -*- lexical-binding: t -*-
;;; Commentary:
;; 

;;; Code:
(defun mgli-switch-to-recent-file (switching-fn)
	"Filter buffer list to file-based buffers and switch to one.
The provided SWITCHING-FN is used to select a buffer from the results.
This is meant for use with `previous-buffer` and `next-buffer` but any
similar function will work."
	(interactive)
	(let* ((starting-buffer (current-buffer))
				 (window-buffers (mapcar #'window-buffer (window-list)))
				 (valid-buffers (match-buffers
												 (lambda (buffer)
												   (and
														(not (eq buffer (current-buffer)))
														(not (member buffer window-buffers))
														(buffer-file-name buffer))))))
		(if valid-buffers
				(progn
					(dotimes (_ (length (buffer-list)))
						(unless (not (member (current-buffer) valid-buffers))
							(cl-return))
						(funcall switching-fn))
					(if (not (member (current-buffer) valid-buffers))
							(progn
								(switch-to-buffer starting-buffer)
								(message "Exhausted all switch attempts; returning to original buffer."))))
			(message "No valid buffers to switch to."))))

(defun mgli-previous-file ()
	"Switch to the previous file-based buffer."
	(interactive)
	(mgli-switch-to-recent-file #'previous-buffer))

(defun mgli-next-file ()
	"Switch to the next file-based buffer."
	(interactive)
	(mgli-switch-to-recent-file #'next-buffer))

(provide 'recent-file)
;;; recent-file.el ends here
