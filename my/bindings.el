;; ============================================================================
;; Swap ctrl-x to be ctrl-l : Banish emacs claw!
;; I've found this is necessary to be loaded after provided libraries because
;; some of them set keyboard binidngs straight to "C-x" and not the ctl-x-map
;; (I think)
;; ============================================================================
(global-set-key (kbd "C-l") ctl-x-map)
(global-set-key (kbd "C-x") 'recenter)

;; Set C-z to be another keymap (it minimizes window otherwise)
(global-set-key "\C-z" nil)

;; Activate CUA rectancgles over xterm
(global-set-key "\C-zr" 'cua-set-rectangle-mark)

;; ============================================================================
;; Key bindings
;; ============================================================================
(define-key ctl-x-map "\C-l" 'recenter)
(define-key ctl-x-map "l" 'goto-line)

(define-key ctl-x-map "\C-b" 'ibuffer)

;; goto last edit -- easy way to jump to where you were before in the buffer
(define-key ctl-x-map "\C-\\" 'goto-last-change)

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

(global-set-key (kbd "<f6>") 'bookmark-jump)
(global-set-key (kbd "<f7>") 'bookmark-set	)

;; Clears Meta-g from any binding, we are effectively setting it up as another
;; prefix key
;;(global-unset-key "\M-g")
