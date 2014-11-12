;Source: https://github.com/nathantypanski/emacs.d/blob/master/config/my-eshell.el
;; from <https://github.com/bling/dotemacs/>
(defmacro after (feature &rest body)
  "After FEATURE is loaded, evaluate BODY."
    (declare (indent defun))
      `(eval-after-load ,feature
           '(progn ,@body)))
(after 'evil

  (defun my-setup-eshell ()
    "Setup eshell as a function, because it breaks normal Evil keybindings"
    (evil-define-key 'normal eshell-mode-map (kbd "RET") 'eshell-send-input)
    (evil-define-key 'insert eshell-mode-map (kbd "RET") 'eshell-send-input)
    )
  (add-hook 'eshell-mode-hook 'my-setup-eshell)
  )
(provide 'my-eshell)
