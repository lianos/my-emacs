(load (expand-file-name "~/.emacs.d/plugins/ess/lisp/ess-site"))
(require 'ess-site)

(add-hook 'ess-mode-hook
          (lambda ()
            (setq tab-width 2)))

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
(setq inferior-ess-r-help-command ".help.ESS(\"%s\", help_type=\"html\")")

;; Setting comint-prompt-read-only to true is supposed to be a bad idea?
;; See: http://stackoverflow.com/questions/2710442
;; (setq comint-prompt-read-only t)

;; Scrolls back in history matching the command prefix entered so far
(define-key ess-mode-map (kbd "M-r") 'comint-previous-matching-input-from-input)
(define-key ess-mode-map (kbd "M-s") 'comint-next-matching-input-from-input)

;; Show function argument completion while editing R code and interacting with
;; an inferior R process
(define-key ess-mode-map [f2] 'ess-r-args-show)
(define-key ess-mode-map [f3] 'ess-r-args-insert)
(define-key inferior-ess-mode-map [f2] 'ess-r-args-show)
(define-key inferior-ess-mode-map [f3] 'ess-r-args-insert)

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



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Bind lots of stuff to shift-RET
;; http://www.kieranhealy.org/blog/archives/2009/10/12/make-shift-enter-do-a-lot-in-ess/
;; ESS: Emacs Speaks Statistics
;; Use shift-enter to split window & launch R (if not running), execute highlighted
;; region (if R running & area highlighted), or execute current line
;; (and move to next line, skipping comments). Nice. 
;; See http://www.emacswiki.org/emacs/EmacsSpeaksStatistics,
;; FelipeCsaszar. Adapted to spilit vertically instead of
;; horizontally. 
;; (defun my-ess-start-R ()
;;   (interactive)
;;   (if (not (member "*R*" (mapcar (function buffer-name) (buffer-list))))
;;       (progn
;;   (delete-other-windows)
;;   (setq w1 (selected-window))
;;   (setq w1name (buffer-name))
;;   (setq w2 (split-window w1 nil t))
;;   (R)
;;   (set-window-buffer w2 "*R*")
;;   (set-window-buffer w1 w1name))))
;; 
;; (defun my-ess-eval ()
;;   (interactive)
;;   (my-ess-start-R)
;;   (if (and transient-mark-mode mark-active)
;;       (call-interactively 'ess-eval-region)
;;     (call-interactively 'ess-eval-line-and-step)))
;; 
;; (add-hook 'ess-mode-hook
;;     '(lambda()
;;        (local-set-key [(shift return)] 'my-ess-eval)))
;; 
;; (add-hook 'inferior-ess-mode-hook
;;     '(lambda()
;;        (local-set-key [C-up] 'comint-previous-input)
;;        (local-set-key [C-down] 'comint-next-input)))


(provide 'my-programming-r)
