;; To add custom launch commands to different versions of R that aren't found
;; on your path, configure the `ess-s-versions-list` variable, like below.
;; This has to be defined before (require 'ess-site). The third argument is
;; for optional command line arguments to pass to the process at launch:
;;
;; (setq ess-s-versions-list
;;      '( ("R-something" "/usr/local/bin/R-something")
;;         ("R-other" "/opt/local/bin/R-other" "-j")))

(load (expand-file-name "~/.emacs.d/vendor/ess-release/lisp/ess-site"))
(require 'ess-site)

;; (load "my/ess-knitr")

(add-hook 'ess-mode-hook
          (lambda ()
            (setq tab-width 2)
            (setq yas/buffer-local-condition t)))
            ;; I can't define these "inline"
            ;; emacs throws an "ess-help-mode-map" symbol is void
            ;; (define-key ess-help-mode-map "w" 'ess-display-help-in-browser)
            ;; (define-key ess-help-mode-map "i" 'ess-display-R-index)))

;; To get tab yasnippet expansion to work on LaTeX/Rnw files
(add-hook 'latex-mode-hook
'(lambda()
(local-set-key [tab] 'yas/expand)))


;; Tweak font locking
(add-hook 'ess-mode-hook
 '(lambda()
    (font-lock-add-keywords nil
    '(("\\<\\(if\\|for\\|function\\|return\\)\\>[\n[:blank:]]*(" 1
       font-lock-keyword-face) ; must go first to override highlighting below
      ("\\<\\([.A-Za-z][._A-Za-z0-9]*\\)[\n[:blank:]]*(" 1
       font-lock-function-name-face) ; highlight function names
      ("\\([(,]\\|[\n[:blank:]]*\\)\\([.A-Za-z][._A-Za-z0-9]*\\)[\n[:blank:]]*=[^=]" 2
       font-lock-reference-face) ;highlight argument names
      ))
    ))

(setq ess-ask-for-ess-directory t)
(setq ess-local-process-name "R")
(setq ansi-color-for-comint-mode 'filter)
(setq comint-scroll-to-bottom-on-input t)
(setq comint-scroll-to-bottom-on-output t)
(setq comint-move-point-for-output t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Sweave with cacheSweave, taken from:
;; http://blog.nguyenvq.com/2009/05/14/editingadding-on-to-sweave-features-in-ess/
(defun ess-swv-run-in-R2 (cmd &optional choose-process)
  "Run \\[cmd] on the current .Rnw file.  Utility function not called by user."
  (let* ((rnw-buf (current-buffer)))
    (if choose-process ;; previous behavior
  (ess-force-buffer-current "R process to load into: ")
      ;; else
      (update-ess-process-name-list)
      (cond ((= 0 (length ess-process-name-list))
       (message "no ESS processes running; starting R")
       (sit-for 1); so the user notices before the next msgs/prompt
       (R)
       (set-buffer rnw-buf)
       )
      ((not (string= "R" (ess-make-buffer-current))); e.g. Splus, need R
       (ess-force-buffer-current "R process to load into: "))
       ))

    (save-excursion
      (ess-execute (format "require(tools)")) ;; Make sure tools is loaded.
      (basic-save-buffer); do not Sweave/Stangle old version of file !
      (let* ((sprocess (get-ess-process ess-current-process-name))
       (sbuffer (process-buffer sprocess))
       (rnw-file (buffer-file-name))
       (Rnw-dir (file-name-directory rnw-file))
       (Sw-cmd
        (format
         "local({..od <- getwd(); setwd(%S); library(cacheSweave); %s(%S, cacheSweaveDriver()); setwd(..od) })"
         Rnw-dir cmd rnw-file))
       )
  (message "%s()ing %S" cmd rnw-file)
  (ess-execute Sw-cmd 'buffer nil nil)
  (switch-to-buffer rnw-buf)
  (ess-show-buffer (buffer-name sbuffer) nil)))))

;; (defun ess-swv-weave2 ()
;;  "Run Sweave on the current .Rnw file."
;;  (interactive)
;;  (ess-swv-run-in-R2 "Sweave"))
;; (define-key noweb-minor-mode-map "\M-nw" 'ess-swv-weave2)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; The input commands won't appear in R buffer, but blocks of code
;; evaluated by C-c C-r shouldn't hang ESS no more, cf:
;; https://stat.ethz.ch/pipermail/ess-help/2012-April/007745.html
(setq ess-eval-visibly-p nil)

;; Setting comint-prompt-read-only to true is supposed to be a bad idea?
;; See: http://stackoverflow.com/questions/2710442
;; (setq comint-prompt-read-only t)

;; Scrolls back in history matching the command prefix entered so far
(define-key ess-mode-map (kbd "M-r") 'comint-previous-matching-input-from-input)
(define-key ess-mode-map (kbd "M-s") 'comint-next-matching-input-from-input)

;; Sets R's width and length arguments to "max out" the frame it is running
;; in. The "inferior-ess-mode-map" is active in the buffer running the R
;; process itself (not buffers that are editing R files).
(define-key inferior-ess-mode-map (kbd "C-c w") 'ess-execute-screen-options)

;; Show function argument completion while editing R code and interacting with
;; an inferior R process
(define-key ess-mode-map [f2] 'ess-r-args-show)
(define-key ess-mode-map [f3] 'ess-r-args-insert)
(define-key inferior-ess-mode-map [f2] 'ess-r-args-show)
(define-key inferior-ess-mode-map [f3] 'ess-r-args-insert)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; auto yasnippet generation.
;; See::
;;   http://www.svenhartenstein.de/Software/R-autoyas/
;;   https://stat.ethz.ch/pipermail/ess-help/2011-March/006758.html
(defun r-autoyas-exit-snippet-delete-remaining ()
  "Exit yas snippet and delete the remaining argument list."
  (interactive "*")
  (let ((deletefrom (point)))
    (yas/exit-snippet (car (yas/snippets-at-point)))
    (yas/check-commit-snippet)
    (delete-region deletefrom (point))
    ))

(defun r-autoyas-expand (&optional funcname no-paren)
  "Insert argument list (in parentheses if no-paren is nil) of R
  function before the point as intelligent yas snippets and
  expand the snippets."
  (interactive "*")
  (when no-paren
    (delete-backward-char 1)
    (delete-char 1))
  (if (null funcname)
      (setq funcname (ess-r-args-current-function)))
  (ess-command (concat ".r.autoyas.create('" funcname "')\n")
               (get-buffer-create "*r-autoyas*"))
  (unless (null funcname)
    (let (snippet)
      (with-current-buffer "*r-autoyas*"
        (if (< (length (buffer-string)) 10);; '[1] " "' if no valid fun
            (message "No valid function!")
          (delete-region 1 6)
          (goto-char (point-max))
          (delete-backward-char 2)
          (goto-char (point-min))
          (replace-string "\\\"" "\"")
          (goto-char (point-min))
          (replace-string "\\\\" "\\")
          (setq snippet (buffer-string))))
      (when snippet
        (yas/expand-snippet snippet)))))

(defun r-autoyas-inject-commands ()
  (ess-eval-linewise
   ".r.autoyas.esc <- function(str) {
  str <- gsub('$', '\\\\$', str, fixed=TRUE)
  str <- gsub('`', '\\\\`', str, fixed=TRUE)
  return(str)
  };
  .r.autoyas.create <- function(funcname) {
  if (existsFunction(deffun <- paste(funcname,'.default', sep=''))) {
  funcname <- deffun
  } else if(!existsFunction(funcname)) {
  return(' ')
  }
  formals <- formals(funcname)
  dots <- match('...', names(formals))
  if (!is.na(dots) & !is.null(options()[['r.autoyas.dotreplace']][[funcname]])) {
  formals2 <- NULL
  if (dots > 1) formals2 <- formals[1:(dots-1)]
  formals2 <- append(formals2, options()[['r.autoyas.dotreplace']][[funcname]])
  if (dots < length(formals)) formals2 <- append(formals2, formals[(dots+1):length(formals)])
  formals <- formals2
  }
  nr <- 0
  closebrackets <- 0
  str <- NULL
  for (field in names(formals)) {
  type <- typeof(formals[[field]])
  if (type=='symbol' & field!='...') {
  nr <- nr+2
  str <- append(str, paste('${',nr-1,':, ',field,'=${',nr,':',' }}', sep=''))
  } else if (type=='symbol' & field=='...') {
  nr <- nr+2
  str <- append(str, paste('${',nr-1,':, ${',nr,':',field,'}}', sep=''))
  } else if (type=='character') {
  nr <- nr+2
  str <- append(str, paste('${',nr-1,':, ',field,'=${',nr,':\\'',gsub('\\'', '\\\\\\'', .r.autoyas.esc(encodeString(formals[[field]])), fixed=TRUE),'\\'}}', sep=''))
  } else if (type=='logical') {
  nr <- nr+2
  str <- append(str, paste('${',nr-1,':, ',field,'=${',nr,':',as.character(formals[[field]]),'}}', sep=''))
  } else if (type=='double') {
  nr <- nr+2
  str <- append(str, paste('${',nr-1,':, ',field,'=${',nr,':',as.character(formals[[field]]),'}}', sep=''))
  } else if (type=='NULL') {
  nr <- nr+2
  str <- append(str, paste('${',nr-1,':, ',field,'=${',nr,':NULL}}', sep=''))
  } else if (type=='language') {
  nr <- nr+2
  str <- append(str, paste('${',nr-1,':, ',field,'=${',nr,':',.r.autoyas.esc(deparse(formals[[field]])),'}}', sep=''))
  }
  }
  str <- paste(str, sep='', collapse='')
  if (grepl(', ', str, fixed=TRUE)) str <- sub(', ', '', str) # remove 1st ', ' (from 1st field)
  str <- paste('(',str,')', sep='')
  str
  }\n"
   t nil nil t)
  )

(defadvice yas/abort-snippet (around r-delete-remaining)
  (if (member major-mode '(ess-mode inferior-ess-mode))
      (r-autoyas-exit-snippet-delete-remaining)
    ad-do-it))

(ad-activate 'yas/abort-snippet)
(add-hook 'ess-post-run-hook 'r-autoyas-inject-commands)

(define-key ess-mode-map (kbd "C-M-<tab>")
  '(lambda ()(interactive)
     (r-autoyas-expand nil nil)))

;; have r-autoyas called whenever you type (
;; (setq skeleton-pair t)
;; (setq skeleton-pair-alist
;;           '((?\( _ ?\))
;;             (?[  _ ?])
;;             (?{  _ ?})))
;;
;; (define-key ess-mode-map (kbd "(") '(lambda () (interactive)
;;                                       (skeleton-pair-insert-maybe nil)
;;                                       (r-autoyas-expand nil t)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ess-R-object-tooltip.el
;;
;; http://blogisticreflections.wordpress.com/2009/10/01/r-object-tooltips-in-ess/
;;
;; I have defined a function, ess-R-object-tooltip, that when
;; invoked, will return a tooltip with some information about
;; the object at point.  The information returned is
;; determined by which R function is called.  This is controlled
;; by an alist, called ess-R-object-tooltip-alist.  The default is
;; given below.  The keys are the classes of R object that will
;; use the associated function.  For example, when the function
;; is called while point is on a factor object, a table of that
;; factor will be shown in the tooltip.  The objects must of course
;; exist in the associated inferior R process for this to work.
;; The special key "other" in the alist defines which function
;; to call when the class is not mached in the alist.  By default,
;; the str function is called, which is actually a fairly useful
;; default for data.frame and function objects.
;;
;; The last line of this file shows my default keybinding.
;; I simply save this file in a directory in my load-path
;; and then place (require 'ess-R-object-tooltip) in my .emacs

;; the alist
(setq ess-R-object-tooltip-alist
      '((numeric    . "summary")
        (factor     . "table")
        (integer    . "summary")
        (lm         . "summary")
        (other      . "str")))

(defun ess-R-object-tooltip ()
  "Get info for object at point, and display it in a tooltip."
  (interactive)
  (let ((objname (current-word))
        (curbuf (current-buffer))
        (tmpbuf (get-buffer-create "**ess-R-object-tooltip**")))
    (if objname
        (progn
          (ess-command (concat "class(" objname ")\n")  tmpbuf )
          (set-buffer tmpbuf)
          (let ((bs (buffer-string)))
            (if (not(string-match "\(object .* not found\)\|unexpected" bs))
                (let* ((objcls (buffer-substring
                                (+ 2 (string-match "\".*\"" bs))
                                (- (point-max) 2)))
                       (myfun (cdr(assoc-string objcls
                                                ess-R-object-tooltip-alist))))
                  (progn
                    (if (eq myfun nil)
                        (setq myfun
                              (cdr(assoc-string "other"
                                                ess-R-object-tooltip-alist))))
                    (ess-command (concat myfun "(" objname ")\n") tmpbuf)
                    (let ((bs (buffer-string)))
                      (progn
                        (set-buffer curbuf)
                        (tooltip-show-at-point bs 0 30)))))))))
    (kill-buffer tmpbuf)))
(define-key ess-mode-map "\C-c\C-g" 'ess-R-object-tooltip)

