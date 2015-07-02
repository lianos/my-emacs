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

;;
(defun Rbioc300 ()
  (interactive)
  (let ((inferior-R-program-name "~/sw/bin/R-bioc300"))
    (R)))

(setq ess-default-style 'RStudio)
(load (expand-file-name "~/.emacs.d/vendor/ess-release/lisp/ess-site"))

(require 'ess-site)

;; (require 'ess-smart-underscore)
;; (load "my/ess-knitr")
(add-hook 'ess-mode-hook
          (lambda ()
            ;; (setq tab-width 2)
            (setq yas/buffer-local-condition t)))

;; Tweak indentation levels. These were taken from this post:
;;    https://stat.ethz.ch/pipermail/ess-help/2014-November/010292.html
;; (setq ess-first-continued-statement-offset 2)
;; (setq ess-continued-statement-offset 0)

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
;; (define-key inferior-ess-mode-map (kbd "C-c w") 'ess-execute-screen-options)
