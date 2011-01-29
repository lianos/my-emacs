(if (and macosx-p window-system)
    ;; Running on OS X, not in terminal
    (progn
      (define-key global-map [ns-drag-file]
        ;; Change the drag/drop behavior
        ;; http://stackoverflow.com/questions/1850292
        (lambda ()
          "Insert path of (multiple) dragged file(s) into buffer."
          (interactive)
          (insert (combine-and-quote-strings ns-input-file "\n"))
          (setq ns-input-file nil)))))

