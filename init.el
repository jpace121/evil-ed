;; init.el --- Jimmy's emacs config
;; This needs "some" organizing.  Enjoy!

;; Enable straight.el for packages.
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'evil)
(straight-use-package 'evil-leader)

(straight-use-package 'ace-jump-mode)
(straight-use-package 'auctex)
(straight-use-package 'csharp-mode)
(straight-use-package 'clojure-mode)
(straight-use-package 'clang-format)
(straight-use-package 'color-theme)
(straight-use-package 'company)
(straight-use-package 'flycheck)
(straight-use-package 'go-mode)
(straight-use-package 'goto-chg)
(straight-use-package 'markdown-mode)
(straight-use-package 'monokai-theme)
(straight-use-package 'org)
(straight-use-package 'rust-mode)
(straight-use-package 'undo-fu)
(straight-use-package 'yasnippet)
(straight-use-package 'yasnippet-snippets)
(straight-use-package 'zenburn-theme)
(straight-use-package 'prettier)
(straight-use-package 'typescript-mode)

(add-to-list 'load-path (concat user-emacs-directory "jimmy-files"))

(require 'navigate)

(fset 'yes-or-no-p 'y-or-n-p)
(setq show-paren-delay 0)
(setq show-paren-mode nil)

(global-evil-leader-mode)
(evil-leader/set-leader "<SPC>")

(setq-default show-trailing-whitespace t)

(setq make-backup-files nil)
(setq auto-save-default nil)
(setq backup-inhibited t)

(add-hook 'after-init-hook 'global-company-mode)
(global-set-key (kbd "TAB") 'company-complete)
(evil-declare-change-repeat 'company-complete)
(setq company-require-match 'never)

;http://superuser.com/questions/712237/safely-reload-files-which-are-changed-on-disc
(global-auto-revert-mode 1)

;Fix escape to do everything like vim.
;Source: http://juanjoalvarez.net/es/detail/2014/sep/19/vim-emacsevil-chaotic-migration-guide/
(defun minibuffer-keyboard-quit ()
  "Abort recursive edit.
In Delete Selection mode, if the mark is active, just deactivate it;
then it takes a second \\[keyboard-quit] to abort the minibuffer."
  (interactive)
  (if (and delete-selection-mode transient-mark-mode mark-active)
      (setq deactivate-mark  t)
    (when (get-buffer "*Completions*") (delete-windows-on "*Completions*"))
    (abort-recursive-edit)))
(define-key evil-normal-state-map [escape] 'keyboard-quit)
(define-key evil-visual-state-map [escape] 'keyboard-quit)
(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)
(global-set-key [escape] 'evil-exit-emacs-state)

;(setq TeX-auto-save t) ;;evil command litters files
(setq TeX-parse-self t)
(setq TeX-save-query nil)
(add-hook 'LaTeX-mode-hook 'TeX-PDF-mode)
(setq TeX-view-program-selection
            '((output-pdf "PDF Viewer")))
(setq TeX-view-program-list
            '(("PDF Viewer" "open %o")))
;;Allow GUI Emacs to see pdflatex
(setenv "PATH" (concat "/usr/texbin" ":" (getenv "PATH")))
;;Spell check for latex
(add-hook 'LaTeX-mode-hook #'turn-on-flyspell)
(when (executable-find "hunspell")
    (setq-default ispell-program-name "hunspell")
    (setq ispell-really-hunspell t))

(defun jp-return ()
    (define-key evil-insert-state-map (kbd "RET") 'evil-ret-and-indent))
(add-hook 'prog-mode-hook 'jp-return)

(setq-default tab-width 4 indent-tabs-mode nil)

(setq c-default-style "bsd"
      c-basic-offset 4)
(c-set-offset 'case-label '+)

;;Open Arduino in cpp mode until I can write my own Arduino mode.
(add-to-list 'auto-mode-alist '("\\.ino\\'" . c++-mode))

;;ROS .launch files should be opened as xml files.
(add-to-list 'auto-mode-alist '("\\.launch\\'" . xml-mode))

;;Neya uses .h for C++ headers.
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

;;Use .tsx for type script Typescript
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . typescript-mode))

;Add column to modeline
(column-number-mode 't)

(autoload 'markdown-mode "markdown-mode"
     "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

; Highlight ROS launch files as xml
(add-to-list 'auto-mode-alist '("\\.launch\\'" . xml-mode))

(require 'yasnippet)
(yas-global-mode 1)

(setq ace-jump-mode-scope 'frame)

;;This makes Ctrl-e work like emacs normally does.
;;(I don't use that combo in vim, and it looks worthless)
(define-key evil-normal-state-map (kbd "C-e") 'evil-end-of-line)
(define-key evil-insert-state-map (kbd "C-e") 'evil-end-of-line)
(define-key evil-visual-state-map (kbd "C-e") 'evil-end-of-line)
(define-key evil-motion-state-map (kbd "C-e") 'evil-end-of-line)

(evil-leader/set-key
  "f" 'evil-ace-jump-char-mode
  "s" 'evil-ace-jump-char-mode
  "j" 'evil-ace-jump-line-mode
  "x" 'execute-extended-command
  "b" 'buffer-menu
  "w" 'save-buffer
  "r" 'revert-buffer
  )
;Mode specific leader keys
(evil-leader/set-key-for-mode 'latex-mode "c" 'TeX-command-master)
(evil-leader/set-key-for-mode 'c++-mode "c" 'clang-format)
(evil-leader/set-key-for-mode 'org-mode "t" 'org-todo)
(evil-leader/set-key-for-mode 'org-mode "c" 'org-toggle-checkbox)
(evil-leader/set-key-for-mode 'typescript-mode "c" 'prettier-prettify)
(evil-leader/set-key-for-mode 'org-mode "o" 'org-insert-todo-heading)

(evil-set-undo-system 'undo-fu)

(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(evil-define-key 'normal org-mode-map (kbd "TAB") 'org-cycle)
;(evil-set-initial-state 'org-mode 'emacs)

(setq scroll-conservatively 1)

(global-unset-key (kbd "M-:"))

(require 'evil)
(evil-mode t)

(setq custom-file (concat user-emacs-directory "custom.el"))
(load custom-file)

(menu-bar-mode -1)

(setq native-comp-async-report-warnings-errors 'silent)
(setq warning-minimum-level :emergency)
