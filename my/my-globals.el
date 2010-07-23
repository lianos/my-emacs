;; ============================================================================
;; Swap ctrl-x to be ctrl-l : Banish emacs claw!
;; I've found this is necessary to be loaded after provided libraries because
;; some of them set keyboard binidngs straight to "C-x" and not the ctl-x-map
;; (I think)
;; ============================================================================
(global-set-key (kbd "C-l") ctl-x-map)
(global-set-key (kbd "C-x") 'recenter)

;; ============================================================================
;; Key bindings
;; ============================================================================
(define-key ctl-x-map "\C-l" 'recenter)
(define-key ctl-x-map "l" 'goto-line)


(global-set-key "\C-\\"      'dabbrev-expand)     ;; C-\ autocompletes using
(define-key esc-map "\C-\\"  'dabbrev-completion) ;; words in current buffer

;; Allow us to invoke "extended commands" (M-x) w/ ctrl sequence
(define-key ctl-x-map "\C-m" 'execute-extended-command)

(global-set-key [M-delete]    'kill-word)
(global-set-key [M-backspace] 'backward-kill-word)

(global-set-key [M-left] 'backward-word)
(global-set-key [M-right] 'forward-word)

;; HOME and END to send you to start/end of the buffer
(global-set-key (kbd "<home>") 'beginning-of-buffer)
(global-set-key (kbd "<end>") 'end-of-buffer)
;; the above 2 aren't so handy in the terminal
(define-key ctl-x-map "t" 'beginning-of-buffer)
(define-key ctl-x-map "e" 'end-of-buffer)

;; Clears Meta-g from any binding, we are effectively setting it up as another
;; prefix key
;;(global-unset-key "\M-g")

;; ============================================================================
;; Global settings
;; ============================================================================


(setq inhibit-startup-message t)        ;; inhibit GNU start screen
(setq column-number-mode t)     ;; Display column numbers
(setq line-number-mode   t)     ;; Display line numbers
(show-paren-mode t)             ;; highlight matching parenthesis
(setq show-paren-style 'mixed)  ;; dunno, but supposed to be a good idea
(setq backup-inhibited t)       ;; disable backup
(setq auto-save-default nil)    ;; disable auto save
(tool-bar-mode 0)               ;; removes the toolbar from the top
(global-font-lock-mode t)       ;; turn on syntax highlight for all major modes
(fset 'yes-or-no-p 'y-or-n-p)   ;; type just "y/n" instead of "yes/no"
(setq next-line-add-newlines nil) ;; don't add new lines when scrolling past end
(setq visible-bell t)           ;; Turn off the beeping
(transient-mark-mode t)         ;; highlights regions between point and mark
(setq search-highlight t)       ;; highlights incremental search
(put 'downcase-region 'disabled nil) ;; set downcase-region to work w/o warning

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

(global-hl-line-mode nil)         ;; Highlight the current line
(toggle-hl-line-when-idle 1)  ;; Activate Highlight after idle (hl-line+.el)

;; ============================================================================
;; Version specific emacs settings
;; TODO: Figure out how set vars given the version of emacs
;; ============================================================================

;; emacs23+ has global-linum-mode
;; (global-linum-mode 1)           ;; always show line numbers (emacs23 only)
;; (setq linum-format "%d ")       ;; put space between number and lines

(if (and macosx-p window-system)
    ;; Running on OS X, not in terminal
    (progn
      (define-key global-map [ns-drag-file]
	;; Change the drag/drop behavior
	;; http://stackoverflow.com/questions/1850292
	(lambda ()
	  "Insert path of (multiple) dragged file(s) into buffer."
	  (interactive)
	  (insert (combine-and-quote-strings ns-input-file "\n"))
	  (setq ns-input-file nil)))))

(provide 'my-globals)
