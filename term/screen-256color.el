;; See http://www.emacswiki.org/emacs/GnuScreen
;; 256 Colours under Gnu Screen
(defun terminal-init-screen ()
  "Terminal initialization function for screen-256color."
  (load "term/xterm")
  (xterm-register-default-colors)
  (tty-set-up-initial-frame-faces))
