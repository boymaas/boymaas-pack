;; Place your bindings here.

;; TODO: remove this to own config
(require 'package)
(add-to-list 'package-archives
             '("marmalade" .
               "http://marmalade-repo.org/packages/")

             '("melpa" . "http://melpa.milkbox.net/packages/"))
(package-initialize)

;; Global line number mode with padded
;; space. Better for the eye.
(global-linum-mode)
(setq linum-format "%3d ")

;; Ruby stuff

;; TODO: now installed via package system. Make this independent of that
(require 'flymake-ruby)
(add-hook 'ruby-mode-hook 'flymake-ruby-load)

;; Evil paste fix
(evil-define-command bmaas-evil-paste-after
  (count &optional register yank-handler)
  :surpress-operator t
  (interactive "P<x>")
  (evil-open-below 1)
  (evil-beginning-of-line)
  (evil-paste-after count register yank-handler)
  (evil-force-normal-state)
  (evil-previous-line))

(define-key evil-normal-state-map "p" 'bmaas-evil-paste-after)

;; For example:
;;(define-key global-map (kbd "C-+") 'text-scale-increase)
;;(define-key global-map (kbd "C--") 'text-scale-decrease)

;; Utils contain helpers to help
;; with defining keys and such
(require 'utils)

(define-key evil-normal-state-map ";;" 'evil-buffer)
(define-key evil-normal-state-map ";h" 'help)
(define-key evil-normal-state-map ";x" 'smex)
(define-key evil-normal-state-map ";X" 'smex)

(define-key evil-normal-state-map ";v" (lambda() (interactive)(find-file "~/.live-packs/boymaas-pack/config/bindings.el")))

(define-key evil-normal-state-map ";gs" 'magit-status)

(define-key evil-normal-state-map ";b" 'ido-switch-buffer)
(define-key evil-normal-state-map ";B" 'ibuffer)

(define-key evil-normal-state-map ";f" 'projectile-find-file)
(define-key evil-normal-state-map ";F" 'projectile-find-file-other-window)
(define-key evil-normal-state-map ";el" 'dired)
(define-key evil-normal-state-map ";j" 'bookmark-jump)
(define-key evil-normal-state-map ";J" 'bookmark-jump-other-window)



(defun open-test-in-split-window ()
  (interactive)
  (delete-other-windows)
  (split-window-right)
  (rspec-toggle-spec-and-target))

(define-key evil-normal-state-map ";." 'open-test-in-split-window)


;; Projectile bindings
(define-key evil-normal-state-map ";p4f" 'projectile-find-file-other-window)
(define-key evil-normal-state-map ";p4t" 'projectile-find-implementation-or-test-other-window)
(define-key evil-normal-state-map ";pf" 'projectile-find-file)
(define-key evil-normal-state-map ";pT" 'projectile-find-test-file)
(define-key evil-normal-state-map ";pl" 'projectile-find-file-in-directory)
(define-key evil-normal-state-map ";pt" 'projectile-toggle-between-implementation-and-test)
(define-key evil-normal-state-map ";pg" 'projectile-grep)
(define-key evil-normal-state-map ";p4b" 'projectile-switch-to-buffer-other-window)
(define-key evil-normal-state-map ";pb" 'projectile-switch-to-buffer)
(define-key evil-normal-state-map ";po" 'projectile-multi-occur)
(define-key evil-normal-state-map ";pr" 'projectile-replace)
(define-key evil-normal-state-map ";pi" 'projectile-invalidate-cache)
(define-key evil-normal-state-map ";pR" 'projectile-regenerate-tags)
(define-key evil-normal-state-map ";pj" 'projectile-find-tag)
(define-key evil-normal-state-map ";pk" 'projectile-kill-buffers)
(define-key evil-normal-state-map ";pd" 'projectile-find-dir)
(define-key evil-normal-state-map ";pD" 'projectile-dired)
(define-key evil-normal-state-map ";pv" 'projectile-vc-dir)
(define-key evil-normal-state-map ";pe" 'projectile-recentf)
(define-key evil-normal-state-map ";pa" 'projectile-ack)
(define-key evil-normal-state-map ";pA" 'projectile-ag)
(define-key evil-normal-state-map ";pc" 'projectile-compile-project)
(define-key evil-normal-state-map ";pp" 'projectile-test-project)
(define-key evil-normal-state-map ";pz" 'projectile-cache-current-file)
(define-key evil-normal-state-map ";ps" 'projectile-switch-project)
(define-key evil-normal-state-map ";pm" 'projectile-commander)
(define-key evil-normal-state-map ";ph" 'helm-projectile)

(fill-keymap evil-window-map
             "<left>"  'evil-window-left
             "<down>"  'evil-window-down
             "<up>"    'evil-window-up
             "<right>" 'evil-window-right
             )

;; Enabling flex matching on ido completions
(setq ido-enable-flex-matching t)
(require 'ido)
(ido-mode 1)
(ido-everywhere 1)
(setq ido-enable-flex-matching t)
(setq ido-create-new-buffer 'always)
(setq ido-enable-tramp-completion nil)
(setq ido-enable-last-directory-history nil)
(setq ido-confirm-unique-completion nil) ;; wait for RET, even for unique?
(setq ido-show-dot-for-dired t) ;; put . as the first item
(setq ido-use-filename-at-point t) ;; prefer file names near point

;; Clojure hacking bindings

;; (global-set-key (kbd  "C-w <Left>") 'evil-window-left)

(define-key evil-normal-state-map ";ee" 'nrepl-eval-expression-at-point)
(define-key evil-normal-state-map ";eb" 'nrepl-eval-buffer)
(define-key evil-normal-state-map ";ef" 'nrepl-load-file)

(define-key evil-normal-state-map ";en" 'nrepl-eval-ns-form)
(define-key evil-visual-state-map ";er" 'nrepl-eval-region)
(define-key evil-normal-state-map ";em" 'nrepl-macroexpand-1)
(define-key evil-normal-state-map ";eM" 'nrepl-macroexpand-all)
(define-key evil-normal-state-map ";eg" 'nrepl-jump)
(define-key evil-normal-state-map ";eG" 'nrepl-jump-back)


; Ruby bindings
;; (define-key evil-normal-state-map ";." 'rspec-toggle-spec-and-target)
(define-key evil-normal-state-map ";t" 'rspec-verify)
(define-key evil-normal-state-map ";T" 'rspec-verify-single)
(define-key evil-normal-state-map ";r" 'rspec-rerun)
(define-key evil-normal-state-map ";a" 'rspec-verify-all)

; Rails bindings
(define-key evil-normal-state-map ";gf" 'rinari-find-file-in-project)
(define-key evil-normal-state-map ";gc" 'rinari-find-controller)
(define-key evil-normal-state-map ";gv" 'rinari-find-view)
(define-key evil-normal-state-map ";gh" 'rinari-find-helper)
(define-key evil-normal-state-map ";gr" 'rinari-find-rspec)

; ECB Conflicts
(add-hook 'ecb-history-buffer-after-create-hook 'evil-emacs-state)
(add-hook 'ecb-directories-buffer-after-create-hook 'evil-emacs-state)
(add-hook 'ecb-methods-buffer-after-create-hook 'evil-emacs-state)
(add-hook 'ecb-sources-buffer-after-create-hook 'evil-emacs-state)


;; Windmove, move around with shift & cursor keys
(global-set-key (kbd "<select>") 'windmove-up)
(windmove-default-keybindings)



;;; C-c as general purpose escape key sequence.
(defun vim-like-esc (prompt)
  "Functionality for escaping generally.  Includes exiting Evil insert state and C-g binding. "
  (cond
   ;; If we're in one of the Evil states that defines [escape] key, return [escape] so as
   ;; Key Lookup will use it.
   ((or (evil-insert-state-p) (evil-normal-state-p) (evil-replace-state-p) (evil-visual-state-p)) [escape])
   ;; This is the best way I could infer for now to have C-c work during evil-read-key.
   ;; Note: As long as I return [escape] in normal-state, I don't need this.
   ;;((eq overriding-terminal-local-map evil-read-key-map) (keyboard-quit) (kbd ""))
   (t (kbd "C-g"))))

;;(define-key key-translation-map (kbd "C-c C-c") 'vim-like-esc)
;; Works around the fact that Evil uses read-event directly when in operator state, which
;; doesn't use the key-translation-map.
;;(define-key evil-operator-state-map (kbd "C-c C-c") 'keyboard-quit)


;; Not sure what behavior this changes, but might as well set it, seeing the Elisp manual's
;; documentation of it.
;;(set-quit-char (kbd "C-c"))
