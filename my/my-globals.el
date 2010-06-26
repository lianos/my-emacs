(setq color-theme-is-global t)
;; Use black bacground color scheme if running in a terminal
(if (not window-system)
  (progn
    (color-theme-initialize)
    (color-theme-charcoal-black)))

(global-linum-mode 1)           ;; always show line numbers (emacs23 only)
(setq column-number-mode t)     ;; Display column numbers
(setq line-number-mode   t)     ;; Display line numbers
(show-paren-mode t)             ;; highlight matching parenthesis
(setq show-paren-style 'mixed)  ;; dunno, but supposed to be a good idea
(setq backup-inhibited t)       ;; disable bakcup
(setq auto-save-default nil)    ;; disable auto save
(tool-bar-mode 0)               ;; removes the toolbar from the top
(global-font-lock-mode t)       ;; turn on syntax highlight for all major modes
(fset 'yes-or-no-p 'y-or-n-p)   ;; type just "y/n" instead of "yes/no"
(setq next-line-add-newlines nil) ;; beeps when trying to move down past end of file
(global-hl-line-mode 1)         ;; Highlight the current line
(setq visible-bell t)           ;; Turn off the beeping
(transient-mark-mode t)         ;; highlights regions between point and mark
(setq search-highlight t)       ;; highlights incremental search
(setq scroll-step 1)            ;; scroll past endn of screen 1 line at a time


;; Allow us to invoke "extended commands" (M-x) w/ ctrl sequence
(define-key ctl-x-map "\C-m" 'execute-extended-command)

;; The following clears Meta-g from any binding, we are effectively
;; setting it up as another prefix key
;;(global-unset-key "\M-g")
(global-set-key "\C-cl" 'goto-line)

(global-set-key [M-delete]    'kill-word)
(global-set-key [M-backspace] 'backward-kill-word)

(global-set-key [M-left] 'backward-word)
(global-set-key [M-right] 'forward-word)

;; HOME and END to send you to start/end of the buffer
(global-set-key (kbd "<home>") 'beginning-of-buffer)
(global-set-key (kbd "<end>") 'end-of-buffer)
(define-key ctl-x-map "t" 'beginning-of-buffer) ; the above 2 aren't so handy in the terminal
(define-key ctl-x-map "e" 'end-of-buffer)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Scrolling
;; http://zhangda.wordpress.com/2009/05/21
(setq-default scroll-up-aggressively 0.01
              scroll-down-aggressively 0.01
              scroll-margin 1
              scroll-conservatively 0)

;; http://stackoverflow.com/questions/445873/emacs-mouse-scrolling
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1) ((control) . nil)))

(provide 'my-globals)