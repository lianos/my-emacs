(setq color-theme-is-global t)
;; Use black bacground color scheme if running in a terminal
(if (not window-system)
  (progn
    (color-theme-initialize)
    (color-theme-charcoal-black)))

(global-linum-mode 1) ;; always show line numbers (emacs23 only)
(setq column-number-mode t)     ;; Display column numbers
(setq line-number-mode   t)     ;; Display line numbers
(show-paren-mode t)                  ;; highlight matching parenthesis
(setq show-paren-style 'mixed)       ;; dunno, but supposed to be a good idea
(setq backup-inhibited t)       ;; disable bakcup
(setq auto-save-default nil)    ;; disable auto save
(tool-bar-mode 0)               ;; removes the toolbar from the top
(global-font-lock-mode t) ;; turn on auto syntax highlightig for all major modes
(fset 'yes-or-no-p 'y-or-n-p) ;; allows typing of just "y/n" instead of "yes/no"
(setq next-line-add-newlines nil) ;; beeps when trying to move down past end of file

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