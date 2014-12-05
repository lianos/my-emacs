;; TODO: Use advice from this URL to tweak the autocompletion stuff:
;;       https://stat.ethz.ch/pipermail/ess-help/2012-May/007835.html
;;
;; It seems that if you want to add custom "launch" commands
;; (eg. M-x R-something) you need to define functions to do so. ESS has a hard
;; coded ess-r-versions-lists (eg. R-devel, R-patched, etc.) which I cannot add
;; to. I previously setup up an ess-s-vesrions-list like so (The third argument
;; is for optional command line arguments to pass to the process at launch):
;;
;; (setq ess-s-versions-list
;;      '( ("R-something" "/usr/local/bin/R-something")
;;         ("R-other" "/opt/local/bin/R-other" "-j")))

;; ess-r-versions-list
;; but these buffers are *S* buffers unless the R-pattern is one that is already
;; hunted for, which was not helpful to setup new ones.
;; This has to be defined before (require 'ess-site). :

;; This need to run on R-3.0.3
(defun Rbioc213 ()
  (interactive)
  (let ((inferior-R-program-name "~/sw/bin/R-bioc213"))
    (R)))

(setq ess-default-style 'DEFAULT)
(load (expand-file-name "~/.emacs.d/vendor/ess-release/lisp/ess-site"))
(require 'ess-site)

;; (require 'ess-smart-underscore)

;; (load "my/ess-knitr")

(add-hook 'ess-mode-hook
          (lambda ()
            (setq tab-width 2)
            (setq yas/buffer-local-condition t)))

;; disable saving history on exit
(setq ess-history-file nil)

;; R launched from my local terminal is setup to show help in the browser
;; but let ESS show help in an emacs buffer
(setq inferior-ess-r-help-command "help(\"%s\", help_type=\"text\")\n")

;; Do not put spaces around equals signs in `param=value`s for functions
(setq ess-ac-R-argument-suffix "=")

;; Get smartparens to work in the interactive ESS (iESS) buffer
(add-hook 'ess-R-post-run-hook 'smartparens-mode)

; (setq ess-ask-for-ess-directory t)
; (setq ess-local-process-name "R")
; (setq ansi-color-for-comint-mode 'filter)
(setq comint-scroll-to-bottom-on-input t)
(setq comint-scroll-to-bottom-on-output t)
(setq comint-move-point-for-output t)

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


;; To get tab yasnippet expansion to work on LaTeX/Rnw files
; (add-hook 'latex-mode-hook
; '(lambda()
; (local-set-key [tab] 'yas/expand)))


;; Tweak font locking
;; (add-hook 'ess-mode-hook
;;  '(lambda()
;;     (font-lock-add-keywords nil
;;     '(("\\<\\(if\\|for\\|function\\|return\\)\\>[\n[:blank:]]*(" 1
;;        font-lock-keyword-face) ; must go first to override highlighting below
;;       ("\\<\\([.A-Za-z][._A-Za-z0-9]*\\)[\n[:blank:]]*(" 1
;;        font-lock-function-name-face) ; highlight function names
;;       ("\\([(,]\\|[\n[:blank:]]*\\)\\([.A-Za-z][._A-Za-z0-9]*\\)[\n[:blank:]]*=[^=]" 2
;;        font-lock-reference-face) ;highlight argument names
;;       ))
;;     ))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Sweave with cacheSweave, taken from:
;; http://blog.nguyenvq.com/2009/05/14/editingadding-on-to-sweave-features-in-ess/
; (defun ess-swv-run-in-R2 (cmd &optional choose-process)
;   "Run \\[cmd] on the current .Rnw file.  Utility function not called by user."
;   (let* ((rnw-buf (current-buffer)))
;     (if choose-process ;; previous behavior
;   (ess-force-buffer-current "R process to load into: ")
;       ;; else
;       (update-ess-process-name-list)
;       (cond ((= 0 (length ess-process-name-list))
;        (message "no ESS processes running; starting R")
;        (sit-for 1); so the user notices before the next msgs/prompt
;        (R)
;        (set-buffer rnw-buf)
;        )
;       ((not (string= "R" (ess-make-buffer-current))); e.g. Splus, need R
;        (ess-force-buffer-current "R process to load into: "))
;        ))

;     (save-excursion
;       (ess-execute (format "require(tools)")) ;; Make sure tools is loaded.
;       (basic-save-buffer); do not Sweave/Stangle old version of file !
;       (let* ((sprocess (get-ess-process ess-current-process-name))
;        (sbuffer (process-buffer sprocess))
;        (rnw-file (buffer-file-name))
;        (Rnw-dir (file-name-directory rnw-file))
;        (Sw-cmd
;         (format
;          "local({..od <- getwd(); setwd(%S); library(cacheSweave); %s(%S, cacheSweaveDriver()); setwd(..od) })"
;          Rnw-dir cmd rnw-file))
;        )
;   (message "%s()ing %S" cmd rnw-file)
;   (ess-execute Sw-cmd 'buffer nil nil)
;   (switch-to-buffer rnw-buf)
;   (ess-show-buffer (buffer-name sbuffer) nil)))))

;; (defun ess-swv-weave2 ()
;;  "Run Sweave on the current .Rnw file."
;;  (interactive)
;;  (ess-swv-run-in-R2 "Sweave"))
;; (define-key noweb-minor-mode-map "\M-nw" 'ess-swv-weave2)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
