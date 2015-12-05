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
(show-paren-mode t)

(global-evil-leader-mode)
(evil-leader/set-leader "<SPC>")

(setq make-backup-files nil)
(setq auto-save-default nil)
(setq backup-inhibited t)

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

;Try out ido mode
;;ido is too anooying normally, will kep this and the fix here for archive
;;purposes
;(setq ido-enable-flex-matching t)
;(setq ido-everywhere t)
;(ido-mode 1)
;(define-key evil-ex-map "e " 'ido-find-file)
;(define-key evil-ex-map "w " 'ido-write-file)
;(define-key evil-ex-map "b " 'ido-switch-buffer)

;Including this for historical sake.
;Long term, I'm going to stick to using an external shell for
;almost everything. If there are tasks that commonly need interaction
;with the outside world, I'll write little functions for them.
(require 'multi-term)
(setq multi-term-program "/bin/bash")

(require 'auto-complete-config)
(ac-config-default)
(setq ac-auto-start nil)
(ac-set-trigger-key "TAB")

;;Make * and # match whole word not subwords
;(setq-default evil-symbol-word-search t)

(require 'auto-complete-auctex)
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

(add-hook 'after-init-hook #'global-flycheck-mode)
(setq-default flycheck-flake8rc
    (concat user-emacs-directory "jimmy-files/flake8_settings.yaml"))

(defun jp-return ()
    (define-key evil-insert-state-map (kbd "RET") 'evil-ret-and-indent))
(add-hook 'prog-mode-hook 'jp-return)

(setq-default tab-width 4 indent-tabs-mode nil)

(setq c-default-style "bsd"
      c-basic-offset 4)
(c-set-offset 'case-label '+)

;;Open Arduino in cpp mode until I can write my own Arduino mode.
(add-to-list 'auto-mode-alist '("\\.ino\\'" . c++-mode))

;:Octave mode was great fail indent wise.
;(autoload 'octave-mode "octave-mod" nil t)
;(setq auto-mode-alist
    ;(cons '("\\.m$" . octave-mode) auto-mode-alist))
;(add-hook 'octave-mode-hook 'auto-complete-mode)
;(add-hook 'octave-mode-hook (lambda ()
  ;(setq indent-tabs-mode t)
  ;(setq tab-stop-list (number-sequence 2 200 2))
  ;(setq tab-width 4)
  ;(setq indent-line-function 'insert-tab) ))

;Add column to modeline
(column-number-mode 't)

;Only remaining bug, emacs doesn't unindent end statments
;Add matlab to path on Mac so emacs gui can see it
(if (and (eq system-type 'darwin) (file-exists-p "/Applications/MATLAB_R2013a.app/bin"))
    (setq exec-path (append exec-path '("/Applications/MATLAB_R2013a.app/bin")))
)


;Only add the maltab stuff if on a Mac, and is matlab is installed,
;if using matlab on linux would need to change this stuff?
(if (executable-find "matlab")
   (progn
   (custom-set-variables
     '(matlab-shell-command-switches '("-nodesktop -nosplash")))
    (add-to-list 'load-path "~/.emacs.d/jimmy-files/matlab-emacs")
    (load-library "matlab-load")
    (require 'matlab-publish))
)

(autoload 'markdown-mode "markdown-mode"
     "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

(require 'yasnippet)
(yas-global-mode 1)

(setq ace-jump-mode-scope 'frame)

;;This makes Ctrl-e work like emacs normally does.
;;(I don't use that combo in vim, and it looks worthless)
(define-key evil-normal-state-map (kbd "C-e") 'evil-end-of-line)
(define-key evil-insert-state-map (kbd "C-e") 'evil-end-of-line)
(define-key evil-visual-state-map (kbd "C-e") 'evil-end-of-line)
(define-key evil-motion-state-map (kbd "C-e") 'evil-end-of-line)

(require 'my-eshell)
(load-library "jp-eshell")

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

;Android
(require 'android-mode) ;do I need this?
;;(custom-set-variables '(android-mode-skd-dir "~/Library/Android/sdk"))


(evil-leader/set-key
  "f" 'evil-ace-jump-char-mode
  "s" 'evil-ace-jump-char-mode
  "j" 'evil-ace-jump-line-mode
  "x" 'execute-extended-command
  "b" 'buffer-menu
  "w" 'save-buffer
  ;"wj" 'evil-window-down
  ;"wk" 'evil-window-up
  ;"wh" 'evil-window-left
  ;"wl" 'evil-window-right
  )
;Mode specific leader keys
(evil-leader/set-key-for-mode 'latex-mode "c" 'TeX-command-master)
(evil-leader/set-key-for-mode 'c-mode "c" 'compile)
(evil-leader/set-key-for-mode 'matlab-mode "c" 'matlab-shell-save-and-go)
(evil-leader/set-key-for-mode 'matlab-mode "p" 'matlab-publish-file-latex)
(evil-leader/set-key-for-mode 'rust-mode "c" 'jp-cargo-build)
(evil-leader/set-key-for-mode 'rust-mode "t" 'jp-cargo-test)
(evil-leader/set-key-for-mode 'python-mode "c" 'jp-python-run)
(evil-leader/set-key-for-mode 'matlab-shell-mode "c" 'buffer-menu)
;^no worky, wrong name?

(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
;(evil-set-initial-state 'org-mode 'emacs)

;Multiple cursors is rather broken with evil-mode.
;(require 'multiple-cursors)
;(define-key evil-insert-state-map (kbd "C-n") 'mc/mark-next-like-this)
;(define-key evil-insert-state-map (kbd "C-b") 'mc/skip-to-next-like-this)

(setq scroll-conservatively 1)

(require 'evil)
(evil-mode t)

;(setq custom-file "~/.emacs.d/custom.el")
(setq custom-file (concat user-emacs-directory "custom.el"))
(load custom-file)
