(require 'cc-mode)
(require 'semantic)
(require 'ede)


(global-ede-mode)

(global-semanticdb-minor-mode 1)
(global-semantic-idle-scheduler-mode 1)
(global-semantic-stickyfunc-mode 1)


;; add include-path
(semantic-add-system-include "/usr/include/boost" 'c++-mode)
(semantic-add-system-include "/home/work/seastar" 'c++-mode)
(semantic-add-system-include "/usr/include/c++/5.4.0" 'c++-mode)

(semantic-mode 1)

(defun alexott/cedet-hook ()
  (local-set-key "\C-c\C-j" 'semantic-ia-fast-jump)
  (local-set-key "\C-c\C-s" 'semantic-ia-show-summary))

(add-hook 'c-mode-common-hook 'alexott/cedet-hook)
(add-hook 'c-mode-hook 'alexott/cedet-hook)
(add-hook 'c++-mode-hook 'alexott/cedet-hook)

;; Enable EDE only in C/C++
(require 'ede)
(global-ede-mode)

(provide 'setup-cedet)
