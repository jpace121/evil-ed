;;; init.el --- Jimmy's emacs config

(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")
                         ("ELPA" . "http://tromey.com/elpa/")))

(package-initialize)

(fset 'yes-or-no-p 'y-or-n-p)
(show-paren-mode t)

(global-evil-leader-mode)
(evil-leader/set-leader "<SPC>")

(require 'evil)
(evil-mode t)

(setq make-backup-files nil)
(setq auto-save-default nil)
(setq backup-inhibited t)

(require 'auto-complete-config)
(ac-config-default)
(setq ac-auto-start nil)
(ac-set-trigger-key "TAB")

;;Make * and # match whole word not subwords
;(setq-default evil-symbol-word-search t)

(require 'auto-complete-auctex)
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq TeX-save-query nil)
(add-hook 'LaTeX-mode-hook 'TeX-PDF-mode)
(setq TeX-view-program-selection
            '((output-pdf "PDF Viewer")))
(setq TeX-view-program-list
            '(("PDF Viewer" "open %o")))
;;Allow GUI Emacs to see pdflatex
(setenv "PATH" (concat "/usr/texbin" ":" (getenv "PATH")))

(evil-set-initial-state 'eshell-mode 'insert)

(add-hook 'after-init-hook #'global-flycheck-mode)

(define-key evil-insert-state-map (kbd "RET") 'newline-and-indent)
;(define-key global-map (kbd "RET") 'newline-and-indent)
(setq c-default-style "bsd"
      c-basic-offset 4)

(autoload 'octave-mode "octave-mod" nil t)
(setq auto-mode-alist
    (cons '("\\.m$" . octave-mode) auto-mode-alist))

(autoload 'markdown-mode "markdown-mode"
     "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

(require 'yasnippet)
(yas-global-mode 1)

;;This makes Ctrl-e work like emacs normally does.
;;(I don't use that combo in vim, and it looks worthless)
(define-key evil-normal-state-map (kbd "C-e") 'evil-end-of-line)
(define-key evil-insert-state-map (kbd "C-e") 'evil-end-of-line)
(define-key evil-visual-state-map (kbd "C-e") 'evil-end-of-line)
(define-key evil-motion-state-map (kbd "C-e") 'evil-end-of-line)

(evil-leader/set-key
  "f" 'evil-ace-jump-char-mode
  "s" 'evil-ace-jump-word-mode
  "j" 'evil-ace-jump-line-mode
  "s" 'ace-jump-mode
  "x" 'execute-extended-command
  "lc" 'TeX-command-master)
;would be better if could replace mode specific stuff like 'lc' with
;stuff that only worked in the correct mode

(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(evil-set-initial-state 'org-mode 'emacs)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector ["#3F3F3F" "#CC9393" "#7F9F7F" "#F0DFAF" "#8CD0D3" "#DC8CC3" "#93E0E3" "#DCDCCC"])
 '(background-color "#ffffd7")
 '(background-mode light)
 '(compilation-message-face (quote default))
 '(cursor-color "#626262")
 '(custom-enabled-themes (quote (zenburn)))
 '(custom-safe-themes (quote ("e26780280b5248eb9b2d02a237d9941956fc94972443b0f7aeec12b5c15db9f3" "a774c5551bc56d7a9c362dca4d73a374582caedb110c201a09b410c0ebbb5e70" "bd115791a5ac6058164193164fd1245ac9dc97207783eae036f0bfc9ad9670e0" "3b819bba57a676edf6e4881bd38c777f96d1aa3b3b5bc21d8266fa5b0d0f1ebf" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "fc5fcb6f1f1c1bc01305694c59a1a861b008c534cae8d0e48e4d5e81ad718bc6" "1e7e097ec8cb1f8c3a912d7e1e0331caeed49fef6cff220be63bd2a6ba4cc365" default)))
 '(fci-rule-color "#383838")
 '(foreground-color "#626262")
 '(highlight-changes-colors (quote ("#D700D7" "#AF87FF")))
 '(highlight-tail-colors (quote (("#303030" . 0) ("#B3EE3A" . 20) ("#AFEEEE" . 30) ("#8DE6F7" . 50) ("#FFF68F" . 60) ("#FFA54F" . 70) ("#FE87F4" . 85) ("#303030" . 100))))
 '(linum-format " %7i ")
 '(magit-diff-use-overlays nil)
 '(syslog-debug-face (quote ((t :background unspecified :foreground "#5FFFFF" :weight bold))))
 '(syslog-error-face (quote ((t :background unspecified :foreground "#FF1493" :weight bold))))
 '(syslog-hour-face (quote ((t :background unspecified :foreground "#87D700"))))
 '(syslog-info-face (quote ((t :background unspecified :foreground "#5FD7FF" :weight bold))))
 '(syslog-ip-face (quote ((t :background unspecified :foreground "#CDC673"))))
 '(syslog-su-face (quote ((t :background unspecified :foreground "#D700D7"))))
 '(syslog-warn-face (quote ((t :background unspecified :foreground "#FF8C00" :weight bold))))
 '(vc-annotate-background "#2B2B2B")
 '(vc-annotate-color-map (quote ((20 . "#BC8383") (40 . "#CC9393") (60 . "#DFAF8F") (80 . "#D0BF8F") (100 . "#E0CF9F") (120 . "#F0DFAF") (140 . "#5F7F5F") (160 . "#7F9F7F") (180 . "#8FB28F") (200 . "#9FC59F") (220 . "#AFD8AF") (240 . "#BFEBBF") (260 . "#93E0E3") (280 . "#6CA0A3") (300 . "#7CB8BB") (320 . "#8CD0D3") (340 . "#94BFF3") (360 . "#DC8CC3"))))
 '(vc-annotate-very-old-color "#DC8CC3")
 '(weechat-color-list (quote (unspecified "#1B1E1C" "#303030" "#5F0000" "#FF1493" "#6B8E23" "#87D700" "#968B26" "#CDC673" "#21889B" "#5FD7FF" "#A41F99" "#D700D7" "#349B8D" "#5FFFFF" "#F5F5F5" "#FFFAFA"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:background nil)))))
