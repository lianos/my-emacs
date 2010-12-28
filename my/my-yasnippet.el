(yas/initialize)
(setq yas/root-directory "~/.emacs.d/my/my-yasnippets")
(setq yas/buffer-local-condition t) ;; Expand snippets in comments
(yas/load-directory "~/.emacs.d/my/my-yasnippets")

(provide 'my-yasnippet)
