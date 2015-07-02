;; Some hints on setting up the right codes for different key combinations can
;; be found here:
;;    http://offbytwo.com/2012/01/15/emacs-plus-paredit-under-terminal.html
;;    http://unix.stackexchange.com/questions/47312

;; ============================================================================
;; Swap ctrl-x to be ctrl-l : Banish emacs claw!
;; I've found this is necessary to be loaded after provided libraries because
;; some of them set keyboard binidngs straight to "C-x" and not the ctl-x-map
;; (I think)
;; ============================================================================
(global-set-key (kbd "C-l") ctl-x-map)
(global-set-key (kbd "C-x") 'recenter)

;; ============================================================================
;; Set C-z to be another keymap (it minimizes window otherwise)
(global-set-key "\C-z" nil)

;; ============================================================================
;; Key bindings
;; ============================================================================

;; Shortcuts to functions defined in my/functions.el
(global-set-key (kbd "C-;") 'kill-start-of-line)
(global-set-key "\M-;" 'comment-dwim-line)
(define-key ctl-x-map "p" 'goto-embedded-match-paren)
(global-set-key "\M-p" 'goto-embedded-match-paren)
(global-set-key [M-down] 'gcm-scroll-down)
(global-set-key [M-up]   'gcm-scroll-up)
(global-set-key [C-x s] 'find-grep-dired-do-search)

;; Shortcuts to other "normal"(?) emacs stuff
(define-key ctl-x-map "\C-l" 'recenter)
(define-key ctl-x-map "l" 'goto-line)

(define-key ctl-x-map "\C-b" 'ibuffer)

;; goto last edit -- easy way to jump to where you were before in the buffer
(define-key ctl-x-map "\C-\\" 'goto-last-change)

;; Allow us to invoke "extended commands" (M-x) w/ ctrl sequence
(define-key ctl-x-map "\C-m" 'execute-extended-command)

(global-set-key [M-delete]    'kill-word)
(global-set-key [M-backspace] 'backward-kill-word)

;;(global-set-key [M-left] 'backward-word)
;;(global-set-key [M-right] 'forward-word)

;; HOME and END to send you to start/end of the buffer
(global-set-key (kbd "<home>") 'beginning-of-buffer)
(global-set-key (kbd "<end>") 'end-of-buffer)
;; the above 2 aren't so handy in the terminal
(define-key ctl-x-map "t" 'beginning-of-buffer)
(define-key ctl-x-map "e" 'end-of-buffer)

(global-set-key (kbd "<f6>") 'bookmark-jump)
(global-set-key (kbd "<f7>") 'bookmark-set)

;; Clears Meta-g from any binding, we are effectively setting it up as another
;; prefix key
;;(global-unset-key "\M-g")

(global-set-key "\C-zr" 'cua-set-rectangle-mark) ;; CUA rectancgles over xterm
(global-set-key [C-S-down] 'cua-set-rectangle-mark) ;; CUA rectancgles over xterm

;; (global-set-key (kbd "C-x") 'er/expand-region) ;; use DEL for forward delete!
;; (global-set-key (kbd "C--") 'er/contract-region)
;; (global-set-key (kbd "C-=") 'er/expand-region)
;; (global-set-key "\C-z=" 'er/expand-region) ;; to enablue use over xterm
(global-set-key [M-right] 'er/expand-region)
(global-set-key [M-left] 'er/contract-region)

;; Add code chunks to md, rmd, org:
(global-set-key "\C-c," 'insert-code-chunk)