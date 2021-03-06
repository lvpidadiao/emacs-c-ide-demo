(require 'package)
;(add-to-list 'package-archives
;	     '("melpa" . "http://melpa.milkbox.net/packages/") t)
(setq package-archives '(("gnu"   . "http://elpa.emacs-china.org/gnu/")
                         ("melpa" . "http://elpa.emacs-china.org/melpa/")))
(package-initialize)

(setq gc-cons-threshold 100000000)
(setq inhibit-startup-message t)

(defalias 'yes-or-no-p 'y-or-n-p)

(defconst demo-packages
  '(anzu
    company
    duplicate-thing
    ggtags
    helm
    helm-gtags
    helm-projectile
    helm-swoop
    function-args
    clean-aindent-mode
    comment-dwim-2
    dtrt-indent
    ws-butler
    iedit
    yasnippet
    smartparens
    projectile
    volatile-highlights
    undo-tree
    zygospore))

(defun install-packages ()
  "Install all required packages."
  (interactive)
  (unless package-archive-contents
    (package-refresh-contents))
  (dolist (package demo-packages)
    (unless (package-installed-p package)
      (package-install package))))

(install-packages)

;; this variables must be set before load helm-gtags
;; you can change to any prefix key of your choice
(setq helm-gtags-prefix-key "\C-cg")

(add-to-list 'load-path "~/.emacs.d/custom")


(require 'setup-helm)
;;(require 'setup-helm-gtags)
(require 'setup-ggtags)
(require 'setup-cedet)
(require 'setup-editing)

(windmove-default-keybindings)

;; function-args
(require 'function-args)
(fa-config-default)
;; (define-key c-mode-map  [(tab)] 'company-complete)
;; (define-key c++-mode-map  [(tab)] 'company-complete)

;; company
(require 'company)
(add-hook 'after-init-hook 'global-company-mode)
;;(define-key c-mode-map  [(tab)] 'company-complete)
;;(define-key c++-mode-map  [(tab)] 'company-complete)
(define-key c-mode-map  [(control tab)] 'company-clang)
(define-key c++-mode-map  [(control tab)] 'company-clang)

(global-set-key [(control tab)] 'company-complete)

;; company-c-headers
;;(add-to-list 'company-backends 'company-c-headers)

;;(delete 'company-clang company-backends)
(add-to-list 'company-backends 'company-clang)

;; hs-minor-mode for folding source code
(add-hook 'c-mode-common-hook 'hs-minor-mode)



;; yasnippt
(add-to-list 'yas-snippet-dirs "/home/techyc/ExternTool/yasnippet-snippets")

;; Available C style:
;; “gnu”: The default style for GNU projects
;; “k&r”: What Kernighan and Ritchie, the authors of C used in their book
;; “bsd”: What BSD developers use, aka “Allman style” after Eric Allman.
;; “whitesmith”: Popularized by the examples that came with Whitesmiths C, an early commercial C compiler.
;; “stroustrup”: What Stroustrup, the author of C++ used in his book
;; “ellemtel”: Popular C++ coding standards as defined by “Programming in C++, Rules and Recommendations,” Erik Nyquist and Mats Henricson, Ellemtel
;; “linux”: What the Linux developers use for kernel development
;; “python”: What Python developers use for extension modules
;; “java”: The default style for java-mode (see below)
;; “user”: When you want to define your own style
(setq
 c-default-style "java" ;; set style to "linux"
 )

(global-set-key (kbd "RET") 'newline-and-indent)  ; automatically indent when press RET

;; activate whitespace-mode to view all whitespace characters
(global-set-key (kbd "C-c w") 'whitespace-mode)

;; show unncessary whitespace that can mess up your diff
(add-hook 'prog-mode-hook (lambda () (interactive) (setq show-trailing-whitespace 1)))

;; use space to indent by default
(setq-default indent-tabs-mode nil)

;; set appearance of a tab that is represented by 4 spaces
(setq-default tab-width 4)

;; Compilation
(global-set-key (kbd "<f5>") (lambda ()
                               (interactive)
                               (setq-local compilation-read-command nil)
                               (call-interactively 'compile)))

;; setup GDB
(setq
 ;; use gdb-many-windows by default
 gdb-many-windows t

 ;; Non-nil means display source file containing the main routine at startup
 gdb-show-main t
 )

;; Package: clean-aindent-mode
(require 'clean-aindent-mode)
(add-hook 'prog-mode-hook 'clean-aindent-mode)

;; Package: dtrt-indent
(require 'dtrt-indent)
(dtrt-indent-mode 1)

;; Package: ws-butler
(require 'ws-butler)
(add-hook 'prog-mode-hook 'ws-butler-mode)

;; Package: yasnippet
(require 'yasnippet)
(yas-global-mode 1)

;; Package: smartparens
(require 'smartparens-config)
(setq sp-base-key-bindings 'paredit)
(setq sp-autoskip-closing-pair 'always)
(setq sp-hybrid-kill-entire-symbol nil)
(sp-use-paredit-bindings)

(show-smartparens-global-mode +1)
(smartparens-global-mode 1)

;; Package: projejctile
(require 'projectile)
(projectile-global-mode)
(setq projectile-enable-caching t)

(require 'helm-projectile)
(helm-projectile-on)
(setq projectile-completion-system 'helm)
(setq projectile-indexing-method 'alien)

;; Package zygospore
(global-set-key (kbd "C-x 1") 'zygospore-toggle-delete-other-windows)

;; ;; following is the c++ programming environment.
;; (custom-set-variables
;;  ;; custom-set-variables was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(company-clang-arguments
;;    (quote
;;     ("-I/usr/include/c++/5.4.0/" "-std=c++14")))
;;  '(company-clang-executable "/usr/bin/clang")
;;  '(custom-enabled-themes (quote (seoul256)))
;;  '(custom-safe-themes
;;    (quote
;;     ("eb07ee737bae7860ff12a4dbd2dcb9ff9712e517cfd6279fa74f04a17b6e1ba6" default)))
;;  '(flycheck-clang-include-path (quote ("/usr/include/c++/5.4.0/" "/home/work/seastar/"
;;                                        )))
;;  '(flycheck-clang-language-standard "c++14")
;;  '(flycheck-gcc-include-path (quote ("/home/work/seastar/")))
;;  '(flycheck-gcc-language-standard "c++14"))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Ubuntu Mono" :foundry "DAMA" :slant normal :weight normal :height 143 :width normal)))))


;; turn off auto backup
(setq make-backup-files nil)


(setq workdir "-I/home/work/yc_svn/branches/sflagent_lenovo_dongde_v0/")

;; folloing is the c programming environment.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-clang-arguments
   (quote
    ("-std=c++11"
     (concat workdir "src/include")
     "-I/usr/local/include/x86_64-linux-gnu/" "-I/usr/local/include/")))
 '(company-clang-executable "/usr/bin/clang++")
 '(current-language-environment "UTF-8")
 '(custom-enabled-themes (quote (rebecca)))
 '(custom-safe-themes
   (quote
    ("d431bff071bfc4c300767f2a0b29b23c7994573f7c6b5ef4c77ed680e6f44dd0" "eb07ee737bae7860ff12a4dbd2dcb9ff9712e517cfd6279fa74f04a17b6e1ba6" default)))
 '(flycheck-clang-include-path (quote ((concat workdir "src/include"))))
 '(flycheck-clang-warnings nil)
 '(flycheck-gcc-include-path
   (quote
    ("/home/work/yc_svn/src/lib/dpdk/src/x86_64-native-linuxapp-gcc/include/" "/home/work/yc_svn/src/include/" "/home/work/yc_svn/src/include/ies/" "/home/work/yc_svn/src/include/ies/std/intel/" "/home/work/yc_svn/src/include/ies/platforms/libertyTrail" "/home/work/yc_svn/src/include/ies/alos/" "/home/work/yc_svn/src/include/ies/api/" "/home/work/yc_svn/src/include/ies/common/" "/home/work/yc_svn/src/approute_daemon/"))))
