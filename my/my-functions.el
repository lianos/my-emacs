;; Defines custom functions and binds them to keyboard shortcuts.
;; 
;; These functions were primarily found in random places on the internet,
;; or ones I made myself.
(defun goto-match-paren (arg)
  "Go to the matching parenthesis if on parenthesis AND last command is
a movement command, otherwise insert %.
(vi style of % jumping to matching brace.)"
  (interactive "p")
  (message "%s" last-command)
  (if (not (memq last-command '(set-mark
                                set-mark-command
                                cua-set-mark
                                goto-match-paren
                                down-list
                                up-list
                                end-of-defun
                                beginning-of-defun
                                backward-sexp
                                forward-sexp
                                backward-up-list
                                forward-paragraph
                                backward-paragraph
                                end-of-buffer
                                beginning-of-buffer
                                backward-word
                                forward-word
                                mwheel-scroll
                                backward-word
                                forward-word
                                mouse-start-secondary
                                mouse-yank-secondary
                                mouse-secondary-save-then-kill
                                move-end-of-line
                                move-beginning-of-line
                                backward-char
                                forward-char
                                scroll-up
                                scroll-down
                                scroll-left
                                scroll-right
                                mouse-set-point
                                next-buffer
                                previous-buffer)))
      (self-insert-command (or arg 1))
    (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
          ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
          (t (self-insert-command (or arg 1))))))

(global-set-key (kbd "%") 'goto-match-paren)

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
