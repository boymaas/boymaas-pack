(live-add-pack-lib "rcodetools")

(require 'rcodetools)

;; Important setting, sinc when executing without bundle exec
;; we get a bash -S error. This has to do with the way
;; rbenv executes commmands. So to execute gem commands (not part of the bundle)
;; we would have to use system ruby be prepending the path etc ... not what i need or want
;; so to use rcodetools add it to development group of Gemfile
;; https://github.com/sstephenson/rbenv/issues/420

;; REMOVED: --dev since it gave all kinds of output I don't want
(set 'xmpfilter-command-name "RUBYOPT='-Ispec' bundle exec ruby -S xmpfilter --fork --dev --detect-rbtest --no-warnings")

(eval-after-load 'ruby-mode
  '(progn
     (define-key ruby-mode-map (kbd "C-c C-c") 'xmp)))
