(defun keymap-symbol (keymap)
  "Return the symbol to which KEYMAP is bound, or nil if no such symbol exists."
  "Example Call: (keymap-symbol (current-local-map))"
  (catch 'gotit
    (mapatoms (lambda (sym)
                (and (boundp sym)
                     (eq (symbol-value sym) keymap)
                     (not (eq sym 'keymap))
                     (throw 'gotit sym))))))
