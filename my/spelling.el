;; aspell/flyspell stuff

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; aspell
;; ----------------------------------------------------------------------------
;; Used homebrew to install aspell
;;    brew install aspell --lang=en
(setq-default ispell-program-name "aspell")


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; flypsell
;; ----------------------------------------------------------------------------

;; from http://www.emacswiki.org/emacs/FlySpell#toc7
;; easy spell check
(global-set-key (kbd "<f8>") 'ispell-word)
(global-set-key (kbd "C-S-<f8>") 'flyspell-mode)
(global-set-key (kbd "C-M-<f8>") 'flyspell-buffer)
(global-set-key (kbd "C-<f8>") 'flyspell-check-previous-highlighted-word)

(defun flyspell-check-next-highlighted-word ()
  "Custom function to spell check next highlighted word"
  (interactive)
  (flyspell-goto-next-error)
  (ispell-word))
(global-set-key (kbd "M-<f8>") 'flyspell-check-next-highlighted-word)
