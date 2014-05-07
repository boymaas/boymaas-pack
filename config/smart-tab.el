(live-add-pack-lib "smart-tab")



(require 'smart-tab)

; This is simplest way to let yasnippet work with smart-tab
(add-to-list 'hippie-expand-try-functions-list 'yas/hippie-try-expand) ;put yasnippet in hippie-expansion list

(setq smart-tab-using-hippie-expand t)
(global-smart-tab-mode t)
