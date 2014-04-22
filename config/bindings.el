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

(set-background-color "black")

;; disable show-paren-mode
(show-paren-mode -1)

;; default off
(global-auto-complete-mode -1)

(setq tab-width 2)
(add-hook 'coffee-mode-hook 'boymaas/coffee-mode-config)
(defun boymaas/coffee-mode-config ()
  (setq evil-shift-width 2)
  (setq tab-width 2)
  ;;(local-unset-key "\t")
  )

;; kill process at point
(define-key process-menu-mode-map (kbd "C-k") 'boymaas/delete-process-at-point)
(evil-set-initial-state 'process-menu-mode 'emacs)
(defun boymaas/delete-process-at-point ()
  (interactive)
  (let ((process (get-text-property (point) 'tabulated-list-id)))
    (cond ((and process
                (processp process))
           (delete-process process)
           (revert-buffer))
          (t
           (error "no process at point!")))))

;; (set-keyboard-coding-system nil)

;; (setq mac-option-key-is-meta t)
;; (setq mac-command-key-is-meta t)
;; (setq mac-command-modifier 'meta)
;; (setq mac-option-modifier 'meta)



;; auto compllete by tab
(setq ac-auto-start nil)

;; this should change visual behaviour
;;(setq evil-want-visual-char-semi-exclusive t)

;; (eval-after-load "evil"
;;   '(progn
;;      ;; Navigation in autocomplete menues gets hijacked by evil
;;      ;(define-key ac-completing-map (kbd "<down>") 'ac-next)
;;      ;(define-key ac-completing-map (kbd "<up>") 'ac-previous)
;;      ;; Let me stop autocompleting the emacs/evil way
;;      (define-key ac-completing-map (kbd "C-g") 'ac-stop)
;;      (define-key ac-completing-map (kbd "ESC") 'evil-normal-state)
;;      (evil-make-intercept-map ac-completing-map)))

;; starting evil mode
(evil-set-initial-state 'nrepl-dbg-mode 'emacs)
;;(evil-set-initial-state 'nrepl-mode 'normal)
(evil-set-initial-state 'grep-mode 'emacs)

;; set emacs stte in macro-expansion-minor-mode
(add-hook 'nrepl-macroexpansion-minor-mode-hook 'boymaas/nrepl-macro-expansion-config)
(defun boymaas/nrepl-macro-expansion-config ()
  (interactive)
  ;;(define-key evil-normal-state-map "q" 'nrepl-popup-buffer-quit)
  (evil-emacs-state))

(evil-set-initial-state nrepl-macroexpansion-minor-mode 'emacs)

;; Ruby stuff

;; TODO: now installed via package system. Make this independent of that
;;(require 'flymake-ruby)
;;(add-hook 'ruby-mode-hook 'flymake-ruby-load)

;; Evil paste fix
(evil-define-command bmaas-evil-paste-after-exp
  (count &optional register yank-handler)
  :surpress-operator t
  (interactive "P<x>")
  (evil-open-below 1)
  (evil-beginning-of-line)
  (evil-paste-after count register yank-handler)
  (evil-force-normal-state)
  (evil-previous-line))

(define-key evil-normal-state-map "p" 'evil-paste-after)

;; For example:
;;(define-key global-map (kbd "C-+") 'text-scale-increase)
;;(define-key global-map (kbd "C--") 'text-scale-decrease)

;; Utils contain helpers to help
;; with defining keys and such
(require 'utils)

;; set emacs state for
(evil-set-initial-state 'magit-branch-manager-mode 'emacs)


(define-key evil-normal-state-map ";;" 'evil-buffer)
(define-key evil-normal-state-map ";h" 'help)
(define-key evil-normal-state-map ";x" 'smex)
(define-key evil-normal-state-map ";X" 'smex)

(define-key evil-normal-state-map ";v" (lambda() (interactive)(find-file "~/.live-packs/boymaas-pack/config/bindings.el")))
(define-key evil-normal-state-map ";V" (lambda() (interactive)(dired "~/.live-packs/")))


(define-key evil-normal-state-map ";gs" 'magit-status)


(define-key evil-normal-state-map ";c" 'evilnc-comment-or-uncomment-lines)


(define-key evil-normal-state-map ";b" 'ido-switch-buffer)
(define-key evil-normal-state-map ";B" 'ibuffer)

(define-key evil-normal-state-map ";f" 'projectile-find-file)
(define-key evil-normal-state-map ";F" 'projectile-find-file-other-window)
(define-key evil-normal-state-map ";el" 'dired)
(define-key evil-normal-state-map ";j" 'bookmark-jump)
(define-key evil-normal-state-map ";J" 'bookmark-jump-other-window)

(defvar boymaas/test-toggle-func 'projectile-toggle-between-implementation-and-test)

;; Paredit customizations
(define-key paredit-mode-map (read-kbd-macro "C-<up>") 'paredit-raise-sexp)

(defun boymaas/open-test-in-split-window ()
  (interactive)
  (delete-other-windows)
  (split-window-right)
  ;(rspec-toggle-spec-and-target)
  (funcall boymaas/test-toggle-func)
  )

(defun boymaas/open-test-in-split-window-clojure ()
  (interactive)
  (boymaas/open-test-in-split-window)
  (split-window-below)
  (nrepl-switch-to-repl-buffer 1)
  (windmove-up))


(define-key evil-normal-state-map ";." 'boymaas/open-test-in-split-window)
(defun boymaas/ruby-test-mappings ()
  (interactive)
  (setq boymaas/test-toggle-func 'rspec-toggle-spec-and-target)
  (define-key evil-normal-state-map ";t" 'rspec-verify)
  (define-key evil-normal-state-map ";T" 'rspec-verify-single)
  (define-key evil-normal-state-map ";r" 'rspec-rerun)
  (define-key evil-normal-state-map ";a" 'rspec-verify-all))
(add-hook 'ruby-mode-hook 'boymaas/ruby-test-mappings)

(defun boymaas/clojure-test-mappings ()
  (interactive)
  (define-key evil-normal-state-map ";." 'boymaas/open-test-in-split-window-clojure)
  (setq boymaas/test-toggle-func 'clojure-jump-between-tests-and-code)
  (define-key evil-normal-state-map ";t" 'clojure-test-run-test)
  (define-key evil-normal-state-map ";a" 'clojure-test-run-tests)
  (define-key evil-normal-state-map (read-kbd-macro "C-]") 'nrepl-jump)
  (define-key evil-normal-state-map (read-kbd-macro "C-o") 'nrepl-jump-back)
  )
(add-hook 'clojure-mode-hook 'boymaas/clojure-test-mappings)


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
(define-key evil-normal-state-map ";er" 'boymaas/switch-to-repl-buffer)

(defun boymaas/switch-to-repl-buffer ()
  (interactive)
  (nrepl-switch-to-repl-buffer 1))

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

;; Load per project config files!

(defun clojure-test-implementation-with-prefix-for (namespace)
  "Returns the path of the src file for the given test namespace."
  (let* ((namespace (clojure-underscores-for-hyphens namespace))
         (segments (split-string namespace "\\."))
         (namespace-end (split-string (car (last segments)) "_"))
         (namespace-end (mapconcat 'identity (butlast namespace-end 1) "_"))
         (impl-segments (append (butlast segments 1) (list namespace-end))))
    (format "%s/src/clj/%s.clj"
            (locate-dominating-file buffer-file-name "src/")
            (mapconcat 'identity impl-segments "/"))))

(setq clojure-test-implementation-for-fn 'clojure-test-implementation-with-prefix-for)



;; Piece of code heloing in localizing templates inside a rails project
(defun boymaas/rinari/locale-file-name ()
  (let* ((relative-to-project-dir
         (file-relative-name (buffer-file-name) (projectile-project-root)))
        ;; assuming path always starts with app/views we
        ;; remove first 2 elements of path and ofcourse the filename itself
        (relative-dir-to-app-view
         (butlast (cddr (split-string relative-to-project-dir "/"))))
        (base-name (file-name-sans-extension (file-name-base relative-to-project-dir)
                    ))
        ;; now build direcoty
        (locale-directory (join-string
                           (append (list "config" "locales" "en") relative-dir-to-app-view (list base-name))
                           "/"))

        )
    (join-string (list locale-directory "yml") ".")))

(defun boymaas/rinari/yank-text-and-place-in-locale-file (start end)
  (interactive "r")
  (let (;; get the translation label using the minibuffer
        (label (read-from-minibuffer "Translation label: "))
        ;; get contents to be pasted into the localte file
        (contents (buffer-substring (region-beginning) (region-end)))
        (locale-filename (expand-file-name (boymaas/rinari/locale-file-name) (projectile-project-root))))
    ;; delete region and replace with label
    (delete-region start end)
    (insert "= t(:" label ")")
    ;; now open the locale file, expanded relative to project rool
    ;; and append text, indented and all
    (save-excursion
      (with-current-buffer (find-file-noselect locale-filename)
        (goto-char (point-max))
        (newline)
        (insert "  " label ": " contents)
        (let ((locale-dir (file-name-directory locale-filename)))
          (unless (file-directory-p locale-dir)
              (make-directory locale-dir)))
        (save-buffer)))
    (switch-to-buffer (current-buffer))))

(define-key evil-visual-state-map ";t" 'boymaas/rinari/yank-text-and-place-in-locale-file)
