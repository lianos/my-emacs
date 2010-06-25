;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Use "%" to jump to the matching parenthesis.
;; Taken from http://www.crsr.net/Notes/Emacs.html
(defun goto-match-paren (arg)
  "Go to the matching parenthesis if on parenthesis, otherwise insert
   the character typed."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
        ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
        (t                    (self-insert-command))))
(global-set-key (kbd "C-.") 'goto-match-paren)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Clipboard functions
;; http://www.emacswiki.org/emacs/CopyAndPaste
(defun set-clipboard-contents-from-string (str)
  "Copy the value of string STR into the clipboard."
  (let ((x-select-enable-clipboard t))
    (x-select-text str)))

(defun set-clipboard-contents (beg end)
  "Copy the value of the current region into the clipboard."
  (interactive "r")
  (set-clipboard-contents-from-string
   (buffer-substring-no-properties beg end))
  (setq deactivate-mark t))

(defun send-buffer-path-to-clipboard ()
  "Send buffer path to clipboard"
  (interactive)
  (set-clipboard-contents-from-string (buffer-file-name)))

(defun send-buffer-dirpath-to-clipboard ()
  "Send directory path of buffer to clibpoard"
  (interactive)
  (set-clipboard-contents-from-string (file-name-directory (buffer-file-name))))

(define-key ctl-x-map "c" 'send-buffer-path-to-clipboard)
(define-key ctl-x-map "p" 'send-buffer-dirpath-to-clipboard)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Scrolling
;; Scroll up/down w/o moving point
(defun gcm-scroll-down ()
  (interactive)
  (scroll-up 1))
(defun gcm-scroll-up ()
  (interactive)
  (scroll-down 1))
  
(global-set-key [M-down] 'gcm-scroll-down)
(global-set-key [M-up]   'gcm-scroll-up)

(provide 'my-functions)
