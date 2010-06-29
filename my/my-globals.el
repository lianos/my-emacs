;; ============================================================================
;; Swap ctrl-x to be ctrl-l : Banish emacs claw!
;; I've found this is necessary to be loaded after provided libraries because
;; some of them set keyboard binidngs straight to "C-x" and not the ctl-x-map
;; (I think)
;; ============================================================================
(global-set-key (kbd "C-l") ctl-x-map)
(global-set-key (kbd "C-x") 'recenter)

(setq inhibit-startup-message t)        ;; inhibit GNU start screen
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
(setq visible-bell t)           ;; Turn off the beeping
(transient-mark-mode t)         ;; highlights regions between point and mark
(setq search-highlight t)       ;; highlights incremental search

(global-hl-line-mode 1)         ;; Highlight the current line
;;(toggle-hl-line-when-idle 1)  ;; Highlihgt current line only when idle (hl-line+.el)

;; set C-\ to autocomplete from words in current buffer
(global-set-key "\C-\\"      'dabbrev-expand)
(define-key esc-map "\C-\\"  'dabbrev-completion)

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
;; (setq-default scroll-up-aggressively 0.01
;;               scroll-down-aggressively 0.01
;;               scroll-margin 1
;;               scroll-conservatively 0)

;; From: http://www.djcbsoftware.nl/dot-emacs.html
(setq 
  scroll-margin 0                        ;; do smooth scrolling, ...
  scroll-conservatively 100000           ;; ... the defaults ...
  scroll-up-aggressively 0               ;; ... are very ...
  scroll-down-aggressively 0             ;; ... annoying
  scroll-preserve-screen-position t)     ;; preserve screen pos with C-v/M-v 

;; http://stackoverflow.com/questions/445873/emacs-mouse-scrolling
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1) ((control) . nil)))

(provide 'my-globals)
