;; Defines custom functions and binds them to keyboard shortcuts.
;;
;; These functions were primarily found in random places on the internet,
;; or ones I made myself.

;; =============================================================================
;; For loading libraries from the vendor directory and then loading my
;; customizations for that library. Taken from:
;; https://github.com/rmm5t/dotfiles/blob/master/emacs.d/rmm5t/defuns.el
(defun vendor (library &rest autoload-functions)
  (let* ((file (symbol-name library))
         (normal (concat "~/.emacs.d/vendor/" file))
         (suffix (concat normal ".el"))
         (personal (concat "~/.emacs.d/my/" file))
   (found nil))
    (cond
     ((file-directory-p normal) (add-to-list 'load-path normal) (set 'found t))
     ((file-directory-p suffix) (add-to-list 'load-path suffix) (set 'found t))
     ((file-exists-p suffix)  (set 'found t)))
    (when found
      (if autoload-functions
          (dolist (autoload-function autoload-functions)
            (autoload autoload-function (symbol-name library) nil t))
        (require library)))
    (when (file-exists-p (concat personal ".el"))
      (load personal))))

;; Delete to start of line
(defun kill-start-of-line ()
  "kill from point to start of line"
  (interactive)
  (kill-line 0))

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

;; http://stackoverflow.com/questions/3669511
(defun show-file-name ()
  "Show the full path file name in the minibuffer."
  (interactive)
  (message (buffer-file-name)))
(global-set-key (kbd "<f1>") 'show-file-name)

(defun send-buffer-path-to-clipboard ()
  "Send buffer path to clipboard"
  (interactive)
  (set-clipboard-contents-from-string (buffer-file-name)))

(defun send-buffer-dirpath-to-clipboard ()
  "Send directory path of buffer to clibpoard"
  (interactive)
  (set-clipboard-contents-from-string (file-name-directory (buffer-file-name))))

;; (define-key ctl-x-map "c" 'send-buffer-path-to-clipboard)
;; (define-key ctl-x-map "p" 'send-buffer-dirpath-to-clipboard)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Scrolling
;; Scroll up/down w/o moving point
(defun gcm-scroll-down ()
  (interactive)
  (scroll-up 1))
(defun gcm-scroll-up ()
  (interactive)
  (scroll-down 1))

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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Code chunks for literate documents
;; https://stat.ethz.ch/pipermail/ess-help/2015-February/010443.html
;; keyboard shortcut defined in my/ess.el(?)
(defun insert-md-code-chunk ()
  "Insert Rmd code chunk"
  (interactive)
  (insert "```\n\n```")
  (backward-char 4))

(defun insert-rmd-code-chunk ()
  "Insert Rmd code chunk"
  (interactive)
  (insert "```{r}\n\n```")
  (backward-char 6))

(defun insert-rnw-code-chunk ()
  "Insert Rnw code chunk"
  (interactive)
  (insert "<<>>=\n\n@")
  (backward-char 2))

(defun insert-org-code-chunk ()
  "Insert Rnw code chunk"
  (interactive)
  (insert "#+BEGIN_SRC R :session *R*\n\n#+END_SRC")
  (backward-char 10))


(defun insert-code-chunk ()
  "Insert appropriate code chunk based on buffer extension"
  (interactive)
  (pcase (file-name-extension (buffer-file-name))
    (`"Rnw" (insert-rnw-code-chunk))
    (`"org" (insert-org-code-chunk))
    (`"Rmd" (insert-rmd-code-chunk))
    (`"md" (insert-md-code-chunk))
    (code (message "Unknown buffer extension"))))
