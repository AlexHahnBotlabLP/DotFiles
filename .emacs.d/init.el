;; Install Use-Package
;; Package Manager
(require 'package)
(add-to-list 'package-archives
  '("melpa" . "http://melpa.org/packages/") t)

(package-initialize)

(require 'gruvbox-theme)

(load-theme 'gruvbox t)
(global-linum-mode 1)

;; set C-x p to previous buffer
(global-set-key (kbd "C-x p")
		(lambda ()
		  (interactive)
		  (other-window -1)))

(menu-bar-mode -1)
(tool-bar-mode -1)
(global-set-key (kbd "C-c C-m C-c") 'mc/edit-lines)

;; Binds 'git status' to C-c m
(define-key global-map (kbd "C-c m") 'magit-status)
(advice-add
 #'magit-key-mode-popup-committing :after
 (lambda ()
   (magit-key-mode-toggle-option
    (quote committing)
    "--no-verify")))

(define-key global-map (kbd "C-x ]")
  '(lambda () (interactive) (buf-move-right)))

(define-key global-map (kbd "C-x [")
  '(lambda () (interactive) (buf-move-left)))

(define-key global-map (kbd "C-x {")
  '(lambda () (interactive) (buf-move-up)))

(define-key global-map (kbd "C-x }")
  '(lambda () (interactive) (buf-move-down)))

(add-hook 'before-save-hook 'whitespace-cleanup)
(add-hook 'after-init-hook 'global-company-mode)
;; (add-hook 'haskell-mode-hook 'turn-off-electric-indent)
;; (add-hook 'ess-mode-hook 'turn-off-electric-indent)


(setq x-select-enable-clipboard t)
(setq interprogram-paste-function 'x-cut-buffer-or-selection-value)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(haskell-process-path-cabal "nix-shell --run repl")
 '(haskell-process-type (quote cabal-repl))
 '(package-selected-packages
   (quote
    (yaml-mode company multiple-cursors command-log-mode interaction-log helm buffer-move magit jsonl json-mode haskell-mode gruvbox-theme ess direx dired-subtree))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(require 'haskell-interactive-mode)
(require 'haskell-process)
(add-hook 'haskell-mode-hook 'interactive-haskell-mode)
