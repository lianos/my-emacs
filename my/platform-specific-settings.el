;; this is setup weird
;; there is code burreid in the platform tests that should probably be
;; just tested against wether or not a window-system is being used

(if (window-system)
  (progn
    (global-hl-line-mode t)
    (color-theme-zenburn)
  )

  (progn
    (color-theme-initialize)
    (if (equal (getenv "TERM_PROGRAM") "Apple_Terminal")
      (progn
        ;; Snow Leopard's Terminal.app only supports 16 colors!
        (global-hl-line-mode nil)
        (color-theme-calm-forest))
      (progn
        (global-hl-line-mode t)
        (color-theme-zenburn)))
  ))

(if macosx-p
  (if (window-system)
    (progn
      ;; Emacs.app needs this for delete/backspace to work as expected when
      ;; launched as an *.app instead of through the terminal
      (tool-bar-mode 0)               ;; removes the toolbar from the top
      (normal-erase-is-backspace-mode 1)
      (setq initial-frame-alist               ;; Set initial window position
            '((top . 40) (left . 50)          ;; works well for 19200 x 1200
              (width . 145) (height . 70)))

      ;; (color-theme-zenburn)
      ;; (global-hl-line-mode t)
      ;; Change the drag/drop behavior
      ;; http://stackoverflow.com/questions/1850292
      (define-key global-map [ns-drag-file]
        (lambda ()
          "Insert path of (multiple) dragged file(s) into buffer."
          (interactive)
          (insert (combine-and-quote-strings ns-input-file "\n"))
          (setq ns-input-file nil)))
    )

    ;; From a terminal
    (progn
      (global-hl-line-mode nil)
      (color-theme-initialize)
      (if (equal (getenv "TERM_PROGRAM") "Apple_Terminal")
        (progn
          ;; Snow Leopard's Terminal.app only supports 16 colors!
          (color-theme-calm-forest))
        (progn
          (color-theme-zenburn)))
      )))
