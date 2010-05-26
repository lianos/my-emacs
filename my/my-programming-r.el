(load (expand-file-name "~/.emacs.d/plugins/ess-5.9.1/lisp/ess-site"))
(require 'ess-site)

(add-hook 'ess-mode-hook
          (lambda ()
            (setq tab-width 2)))

;; change some of the key bindings
;; Scrolls back in history matching the command prefix entered so far
(define-key ess-mode-map (kbd "M-r") 'comint-previous-matching-input-from-input)
(define-key ess-mode-map (kbd "M-s") 'comint-next-matching-input-from-input)

(provide 'my-programming-r)
