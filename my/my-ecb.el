;; Look at (and set) the most important ECB options like so:
;; M-x ecb-customize-most-important RET
(setq ecb-layout-name "left14")
(setq ecb-tip-of-the-day nil)

;;(ecb-default-highlight-face ((t (:background "cornflower blue" :foreground "yellow"))))

;; Set first mouse button to act/select objects in dir tree
(setq ecb-primary-secondary-mouse-buttons (quote mouse-1--mouse-2))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Set the ecb-source path in my-local-config.el, since this can change between
;; machines
;;
;; (setq ecb-source-path (quote (("/path/to/proj1" "proj1")
;;                               ("/path/to/proj2" "proj2"))))

(provide 'my-ecb)