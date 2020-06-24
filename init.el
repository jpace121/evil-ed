;; init.el --- Jimmy's emacs config
;; This needs "some" organizing.  Enjoy!

(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")
                         ("ELPA" . "http://tromey.com/elpa/")))

(package-initialize)

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

;Grammar checking
(require 'langtool)
(setq langtool-language-tool-jar (concat user-emacs-directory "jimmy-files/LanguageTool-3.1/languagetool-commandline.jar"))
(setq langtool-default-language "en-US")

(defun jp-return ()
    (define-key evil-insert-state-map (kbd "RET") 'evil-ret-and-indent))
(add-hook 'prog-mode-hook 'jp-return)

(setq-default tab-width 4 indent-tabs-mode nil)

(setq c-default-style "bsd"
      c-basic-offset 4)
(c-set-offset 'case-label '+)

(setq clang-format-executable "/usr/bin/clang-format-7")

;;Open Arduino in cpp mode until I can write my own Arduino mode.
(add-to-list 'auto-mode-alist '("\\.ino\\'" . c++-mode))

;;ROS .launch files should be opened as xml files.
(add-to-list 'auto-mode-alist '("\\.launch\\'" . xml-mode))

;;Neya uses .h for C++ headers.
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

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

;Rust compile commands
(defun jp-cargo-build ()
    (interactive)
    (save-buffer)
    (shell-command "cargo build")
)

(defun jp-cargo-test ()
    (interactive)
    (save-buffer)
    (shell-command "cargo test")
)

(defun jp-python-run ()
    (interactive)
    (save-buffer)
    (python-shell-send-buffer)
    (python-shell-switch-to-shell)
)

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
(evil-leader/set-key-for-mode 'latex-mode "lc" 'langtool-check-buffer)
(evil-leader/set-key-for-mode 'latex-mode "lq" 'langtool-check-done)
(evil-leader/set-key-for-mode 'c-mode "c" 'compile)
(evil-leader/set-key-for-mode 'c++-mode "c" 'clang-format)
(evil-leader/set-key-for-mode 'rust-mode "c" 'jp-cargo-build)
(evil-leader/set-key-for-mode 'rust-mode "t" 'jp-cargo-test)
(evil-leader/set-key-for-mode 'python-mode "c" 'jp-python-run)
(evil-leader/set-key-for-mode 'org-mode "t" 'org-todo)
(evil-leader/set-key-for-mode 'org-mode "c" 'org-toggle-checkbox)
(evil-leader/set-key-for-mode 'org-mode "o" 'org-insert-todo-heading)

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
