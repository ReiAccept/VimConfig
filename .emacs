(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(current-language-environment "UTF-8"))

(setq default-tab-width 4)
(setq-default indent-tabs-mode nil)
(setq c-default-style "linux")
(setq c-basic-offset 4)
(electric-pair-mode t)
(setq make-backup-files nil)
(global-linum-mode 1) ; always show line numbers                              
(setq linum-format "%d| ")  ;set format

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Consolas" :foundry "outline" :slant normal :weight normal :height 113 :width normal)))))
