;; User pack init file
;;
;; Use this file to initiate the pack configuration.
;; See README for more information.

;; Load bindings config
(live-load-config-file "bindings.el")
(live-load-config-file "smart-tab.el")
(live-load-config-file "emacs-nav.el")
;;(live-load-config-file "sr-speedbar.el")
(live-load-config-file "rcodetools.el")
(live-load-config-file "evil-org-mode.el")
;;(live-load-config-file "ruby-electric.el")

;; byte compile everything that needs to be compiled for
;; faster startup
;;(byte-recompile-directory (expand-file-name "~/.emacs.d") 0)
