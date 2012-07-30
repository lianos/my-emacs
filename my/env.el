;; Environment variables

(setq exec-path (cons "/usr/local/bin" exec-path))
(setq exec-path (cons "~/sw/bin" exec-path))
(setq exec-path (cons "/usr/local/texlive/2010/bin/x86_64-darwin" exec-path))


(setenv "PATH" (concat "/usr/local/bin:" (getenv "PATH")))
(setenv "PATH" (concat "~/sw/bin:" (getenv "PATH")))
(setenv "PATH" (concat "/usr/local/texlive/2010/bin/x86_64-darwin:" (getenv "PATH")))

;; Ensure R starts in 64bit mode
(setenv "R_ARCH" "/x86_64")

;; (setq exec-path (cons "/usr/texbin" exec-path))
;; (setenv "PATH" (concat "/usr/texbin:" (getenv "PATH")))
;; (setq exec-path (cons "/usr/local/share/npm/bin" exec-path))
;; (setenv "PATH" (concat "/usr/local/share/npm/bin:" (getenv "PATH")))
;; (setq exec-path (cons "/Applications/Emacs.app/Contents/MacOS/bin" exec-path))
;; (setenv "PATH" (concat "/Applications/Emacs.app/Contents/MacOS/bin:" (getenv "PATH")))
