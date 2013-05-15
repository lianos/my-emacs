;; Defines custom functions and binds them to keyboard shortcuts.
;;
;; These functions were primarily found in random places on the internet,
;; or ones I made myself.

;; Delete to start of line
(defun kill-start-of-line ()
  "kill from point to start of line"
  (interactive)
  (kill-line 0))
(global-set-key (kbd "C-;") 'kill-start-of-line)

;; Change \M-; to a better comment-dwim. This will comment the current
;; line if the mark isn't active, not add a comment to the end of the line
;; http://www.emacswiki.org/emacs/CommentingCode
;; http://www.opensubscriber.com/message/emacs-devel@gnu.org/10971693.html
(defun comment-dwim-line (&optional arg)
  (interactive "*P")
  (comment-normalize-vars)
  (if (and (not (region-active-p)) (not (looking-at "[ \t]*$")))
      (comment-or-uncomment-region (line-beginning-position)
				   (line-end-position))
    (comment-dwim arg)))
(global-set-key "\M-;" 'comment-dwim-line)


;; http://www.emacswiki.org/emacs/NavigatingParentheses
(defun goto-embedded-match-paren (arg)
  "Go to the matching parenthesis if on parenthesis. Else go to the
   opening parenthesis one level up."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1))
        (t
         (backward-char 1)
         (cond ((looking-at "\\s\)")
                (forward-char 1) (backward-list 1))
               (t
                (while (not (looking-at "\\s("))
                  (backward-char 1)
                  (cond ((looking-at "\\s\)")
                         (message "->> )")
                         (forward-char 1)
                         (backward-list 1)
                         (backward-char 1)))
                  ))))))
(global-set-key "\C-p" 'goto-embedded-match-paren)

;;(defun goto-match-paren (arg)
;;  "Go to the matching parenthesis if on parenthesis AND last command is a
;;movement command, otherwise insert %. This is vi-esque style of jumping to
;;the matching brace"
;;  (interactive "p")
;;  (message "%s" last-command)
;;  (if (not (memq last-command '(set-mark
;;                                set-mark-command
;;                                cua-set-mark
;;                                goto-match-paren
;;                                down-list
;;                                up-list
;;                                end-of-defun
;;                                beginning-of-defun
;;                                backward-sexp
;;                                forward-sexp
;;                                backward-up-list
;;                                forward-paragraph
;;                                backward-paragraph
;;                                end-of-buffer
;;                                beginning-of-buffer
;;                                backward-word
;;                                forward-word
;;                                mwheel-scroll
;;                                backward-word
;;                                forward-word
;;                                mouse-start-secondary
;;                                mouse-yank-secondary
;;                                mouse-secondary-save-then-kill
;;                                move-end-of-line
;;                                move-beginning-of-line
;;                                backward-char
;;                                forward-char
;;                                scroll-up
;;                                scroll-down
;;                                scroll-left
;;                                scroll-right
;;                                mouse-set-point
;;                                next-buffer
;;                                previous-buffer
;;                                previous-line
;;                                next-line)))
;;      (self-insert-command (or arg 1))
;;    (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
;;          ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
;;          (t (self-insert-command (or arg 1))))))
;;(global-set-key (kbd "%") 'goto-match-paren)

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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Search directory w/ regexp then inline search the files w/ regexp
;; http://stackoverflow.com/questions/4969373
;;
;; 1. Run `find-grep-dired` as usual
;; 2. Press `t` (dired-toggle-marks) to mark all files.
;; 3. Press `A` to start dired-do-search. When prompted for regexp, simply press
;;    `M-p`, this will bring up your find-grep regexp since both functions
;;    use the same prompting history list
;; 4. You will be taken to the first match in the first file. Press `M-` to go
;;    to the next match spanning all of your matched files.
(defun find-grep-dired-do-search (dir regexp)
  "First perform `find-grep-dired', and wait for it to finish.
Then, using the same REGEXP as provided to `find-grep-dired',
perform `dired-do-search' on all files in the *Find* buffer."
  (interactive "DFind-grep (directory): \nsFind-grep (grep regexp): ")
  (find-grep-dired dir regexp)
  (while (get-buffer-process (get-buffer "*Find*"))
    (sit-for 1))
  (with-current-buffer "*Find*"
    (dired-toggle-marks)
    (dired-do-search regexp)))
(global-set-key [C-x s] 'find-grep-dired-do-search)
