(setq radian-font "JetBrainsMono Nerd Font Mono-10")
;;(setq radian-font-size 400)

(radian-local-on-hook before-straight

  ;; code that should be run right before straight.el is bootstrapped,
  ;; e.g.

;  (setq straight-vc-git-default-protocol ...)
;  (setq straight-check-for-modifications ...)
  (setq straight-use-package-by-default t)
  )

 (radian-local-on-hook after-init
  (setenv "BROWSER" "firefox")
  (setq radian-color-theme-enable nil)
  (use-feature all-the-icons)
  (use-feature night-owl-theme :straight t)
  (use-feature parchment-theme :straight t)
  (use-feature cloud-theme :straight t)
  (use-feature moe-theme :straight t)
  (use-feature zenburn-theme :straight t)
  (use-feature monokai-theme :straight t)
  (use-feature gruvbox-theme :straight t)
  (use-feature ample-theme :straight t)
  (use-feature ample-zen-theme :straight t)
  (use-feature alect-themes :straight t)
  (use-feature tao-theme :straight t)
  (use-feature poet-theme :straight t)
  (use-feature modus-operandi-theme :straight t)
  (use-feature modus-vivendi-theme :straight t)
  (use-feature faff-theme :straight t )
  (use-feature color-theme-modern :straight  t)


  (use-feature doom-modeline :straight t)
  (doom-modeline-mode)

  ;; expand the marked region in semantic increments
  ;;(negative prefix to reduce region)
  (use-feature expand-region
    :straight t
    :config
    :bind ("C-=" . 'er/expand-region))

  (setq save-interprogram-paste-before-kill t)

  (use-feature hungry-delete
    :straight t
    :config
    (global-hungry-delete-mode))

  (global-auto-revert-mode 1) ;; you might not want this
  (setq auto-revert-verbose t) ;; or this
  (global-set-key (kbd "<f5>") 'revert-buffer)

  (use-feature aggressive-indent
    :straight t
    :config
    (global-aggressive-indent-mode 1)
    (add-to-list 'aggressive-indent-excluded-modes 'html-mode)
    )

(use-feature ace-window
    :straight t
    :bind ("C-x o" . ace-window)
    :config
    (setq aw-scope 'frame) ;; was global
    (global-set-key [remap other-window] 'ace-window)
    )

  (use-feature try :straight t)
  (use-feature posframe :straight t)
  (use-feature iedit  :straight t)

  (use-feature which-key :straight t
    :config
    (setq which-key-use-C-h-commands nil)
    (which-key-setup-side-window-right-bottom)
    )

(use-feature hlinum :straight t :config (hlinum-activate) (global-linum-mode))

  (setq ibuffer-saved-filter-groups
        (quote (("default"
	         ("dired" (mode . dired-mode))
	         ("org" (name . "^.*org$"))
	         ("magit" (mode . magit-mode))
	         ("IRC" (or (mode . circe-channel-mode) (mode . circe-server-mode)))
	         ("web" (or (mode . web-mode) (mode . js2-mode)))
	         ("shell" (or (mode . eshell-mode) (mode . shell-mode)))
	         ("mu4e" (or
			  (mode . mu4e-compose-mode)
			  (name . "\*mu4e\*")
			  ))
	         ("programming" (or
			         (mode . clojure-mode)
			         (mode . go-mode)
			         (mode . clojurescript-mode)
			         (mode . python-mode)
			         (mode . c++-mode)))
	         ("emacs" (or
			   (name . "^\\*scratch\\*$")
			   (name . "^\\*Messages\\*$")))
	         ))))
  (add-hook 'ibuffer-mode-hook
	    (lambda ()
	      (ibuffer-auto-mode 1)
	      (ibuffer-switch-to-saved-filter-groups "default")))


  ;; Don't show filter groups if there are no buffers in that group
  (setq ibuffer-show-empty-filter-groups nil)

  ;; Don't ask for confirmation to delete marked buffers
  (setq ibuffer-expert t)

  (use-feature dashboard
    :straight t
    :config
    (dashboard-setup-startup-hook))

  (use-feature flycheck
    :straight t
    :init
    (global-flycheck-mode t))

  (use-feature hydra :straight t)
  (use-feature origami
    :straight t)
  (defhydra hydra-origami (:color red)
    "
  _o_pen node    _n_ext fold       toggle _f_orward
  _c_lose node   _p_revious fold   toggle _a_ll
  "
    ("o" origami-open-node)
    ("c" origami-close-node)
    ("n" origami-next-fold)
    ("p" origami-previous-fold)
    ("f" origami-forward-toggle-node)
    ("a" origami-toggle-all-nodes))


  (use-feature magit
    :straight t
    :init
    (progn
      (bind-key "C-x g" 'magit-status)
      ))

  (setq magit-status-margin
        '(t "%Y-%m-%d %H:%M " magit-log-margin-width t 18))

  (use-feature git-timemachine
    :straight t
    )

  (use-feature smerge-mode
    :after hydra
    :config
    (defhydra unpackaged/smerge-hydra
      (:color pink :hint nil :post (smerge-auto-leave))
      "
^Move^       ^Keep^               ^Diff^                 ^Other^
^^-----------^^-------------------^^---------------------^^-------
_n_ext       _b_ase               _<_: upper/base        _C_ombine
_p_rev       _u_pper              _=_: upper/lower       _r_esolve
^^           _l_ower              _>_: base/lower        _k_ill current
^^           _a_ll                _R_efine
^^           _RET_: current       _E_diff
"
      ("n" smerge-next)
      ("p" smerge-prev)
      ("b" smerge-keep-base)
      ("u" smerge-keep-upper)
      ("l" smerge-keep-lower)
      ("a" smerge-keep-all)
      ("RET" smerge-keep-current)
      ("\C-m" smerge-keep-current)
      ("<" smerge-diff-base-upper)
      ("=" smerge-diff-upper-lower)
      (">" smerge-diff-base-lower)
      ("R" smerge-refine)
      ("E" smerge-ediff)
      ("C" smerge-combine-with-next)
      ("r" smerge-resolve)
      ("k" smerge-kill-current)
      ("ZZ" (lambda ()
              (interactive)
              (save-buffer)
              (bury-buffer))
       "Save and bury buffer" :color blue)
      ("q" nil "cancel" :color blue))
    :hook (magit-diff-visit-file . (lambda ()
                                     (when smerge-mode
                                       (unpackaged/smerge-hydra/body)))))



  (use-feature forge
    :straight t
    :after magit)

  (require 'org-protocol)
  (custom-set-variables
   '(org-directory "~/Dropbox/org")
   '(org-default-notes-file (concat org-directory "/notes.org"))
   '(org-export-html-postamble nil)
   '(org-hide-leading-stars t)
   '(org-startup-folded (quote overview))
   '(org-startup-indented t)
   '(org-confirm-babel-evaluate nil)
   '(org-src-fontify-natively t)
   '(org-export-with-toc nil)
   )


  (use-feature org-bullets
    :straight t
    :config
    (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))


  (global-set-key "\C-ca" 'org-agenda)
  (setq org-agenda-start-on-weekday 0)
  ;; (setq org-agenda-custom-commands
  ;;       '(("c" "Simple agenda view"
  ;;          ((agenda "")
  ;;           (alltodo )))))

  (global-set-key (kbd "C-c c") 'org-capture)

  (setq org-agenda-files (list "~/Dropbox/org/gcal.org"
                               "~/Dropbox/org/i.org"))

  (setq org-capture-templates
        '(("l" "Link" entry (file+headline "~/Dropbox/org/links.org" "Links")
           "* %a %^g\n %?\n %T\n %i")
          ("b" "Blog idea" entry (file+headline "~/Dropbox/org/i.org" "POSTS:")
           "* %?\n%T" :prepend t)
          ("t" "To Do Item" entry (file+headline "~/Dropbox/org/i.org" "To Do and Notes")
           "* TODO %?\n%u" :prepend t)
          ("m" "Mail To Do" entry (file+headline "~/Dropbox/org/i.org" "To Do and Notes")
           "* TODO %a\n %?" :prepend t)
          ("n" "Note" entry (file+olp "~/Dropbox/org/i.org" "Notes")
           "* %u %? " :prepend t)
          ("r" "RSS" entry (file+headline "~/Sync/shared/elfeed.org" "Feeds misc")
           "** %A %^g\n")
          ))


  (use-feature htmlize :straight t)

  (setq org-ditaa-jar-path "/usr/share/ditaa/ditaa.jar")
  (setq org-file-apps
        (append '(
                  ("\\.pdf\\'" . "evince %s")
                  ("\\.x?html?\\'" . "/usr/bin/firefox %s")
                  ) org-file-apps ))
  ;; babel stuff

  (org-babel-do-load-languages
   'org-babel-load-languages
   '((python . t)
     (emacs-lisp . t)
     (shell . t)
     (C . t)
     (js . t)
     (ditaa . t)
     (dot . t)
     (org . t)
     (latex . t )
     ))

  (setq mail-user-agent 'mu4e-user-agent)
  (use-feature org-msg
    :straight t
    :config
    (setq org-msg-options "html-postamble:nil H:5 num:nil ^:{} toc:nil tex:dvipng")
    (setq org-msg-startup "hidestars indent inlineimages")
    (setq org-msg-greeting-fmt "\n%s,\n\n")
    (setq org-msg-greeting-fmt-mailto t)
    (setq org-msg-signature "
             ,#+begin_signature
             -- *Joe* \\\\
             ,#+end_signature")
    (org-msg-mode)
    )

  (use-feature ox-reveal :straight t)

  (require 'org-tempo)  ;; to bring back easy templates using <s or <n


  (require 'ox-publish)
  (setq org-publish-project-alist
        '(
          ("home_page"
           :base-directory "~/Sync/hunter/sites/home_page/"
           :base-extension "org"
           :publishing-directory "/ssh:zamansky@info.huntercs.org:/var/www/html/home_page/"
           :recursive t
           :publishing-function org-html-publish-to-html
           :headline-levels 4             ; Just the default for this project.
           :auto-preamble t
           )
          ("home_static"
           :base-directory "~/Sync/hunter/sites/home_page/"
           :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf"
           :publishing-directory "/ssh:zamansky@info.huntercs.org:/var/www/html/home_page/"
           :recursive t
           :publishing-function org-publish-attachment
           )

          ("teacher_ed"
           :base-directory "~/Sync/hunter/sites/teacher_ed/"
           :base-extension "org"
           :publishing-directory "/ssh:zamansky@info.huntercs.org:/var/www/html/teacher_ed/"
           :recursive t
           :publishing-function org-html-publish-to-html
           :headline-levels 4             ; Just the default for this project.
           :auto-preamble t
           )
          ))


  (setq org-refile-targets '((nil :maxlevel . 2)))


  (use-feature rainbow-delimiters
    :straight t
    :config
    (add-hook 'clojure-mode-hook #'rainbow-delimiters-mode)
    )
  (show-paren-mode t)

  ;; (defun load-if-exists (f)
  ;;   "load the elisp file only if it exists and is readable"
  ;;   (if (file-readable-p f)
  ;;       (load-file f)))

  ;; (load-if-exists "~/Sync/shared/mu4econfig.el")
  ;; (load-if-exists "~/Sync/shared/not-for-github.el")


  (use-feature yasnippet
    :straight t
    :init
    (yas-global-mode 1))

  (use-feature yasnippet-snippets
    :straight t)
  (use-feature yasnippet-classic-snippets
    :straight t)

  (use-feature lsp-ui
    :after lsp-mode
    :blackout
    :commands lsp-ui-mode
    :custom-face
    (lsp-ui-doc-background ((t (:background nil))))
    (lsp-ui-doc-header ((t (:inherit (font-lock-string-face italic)))))
    :bind (:map lsp-ui-mode-map
                ([remap xref-find-definitions] . lsp-ui-peek-find-definitions)
                ([remap xref-find-references] . lsp-ui-peek-find-references)
                ("C-c u" . lsp-ui-imenu))
    :custom
    (lsp-ui-doc-enable t)
    (lsp-ui-doc-header t)
    (lsp-ui-doc-include-signature t)
    (lsp-ui-doc-position 'top)
    (lsp-ui-doc-border (face-foreground 'default))
    (lsp-ui-sideline-enable nil)
    (lsp-ui-sideline-ignore-duplicate t)
    (lsp-ui-sideline-show-code-actions nil)
    :config
    ;; Use lsp-ui-doc-webkit only in GUI
    (setq lsp-ui-doc-use-webkit t)
    ;; WORKAROUND Hide mode-line of the lsp-ui-imenu buffer
    ;; https://github.com/emacs-lsp/lsp-ui/issues/243
    (defadvice lsp-ui-imenu (after hide-lsp-ui-imenu-mode-line activate)
      (setq mode-line-format nil)))

  (use-feature lsp-mode
    :straight t
    :commands lsp
    :custom
    (lsp-auto-guess-root nil)
    (lsp-prefer-flymake nil) ; Use flycheck instead of flymake
    :bind (:map lsp-mode-map ("C-c C-f" . lsp-format-buffer))
    :hook ((python-mode) . lsp))

  (use-feature ibuffer-projectile
    :straight t
    :config
    (add-hook 'ibuffer-hook
              (lambda ()
                (ibuffer-projectile-set-filter-groups)
                (unless (eq ibuffer-sorting-mode 'alphabetic)
                  (ibuffer-do-sort-by-alphabetic))))
    )

  (use-package blacken :straight t)
  (use-feature pyvenv)

  (use-feature company-irony
    :straight t
    :config
    (add-to-list 'company-backends 'company-irony))

  (use-feature irony
    :straight t
    :config
    (add-hook 'c++-mode-hook 'irony-mode)
    (add-hook 'c-mode-hook 'irony-mode)
    (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options))

  (use-feature irony-eldoc
    :straight t
    :config
    (add-hook 'irony-mode-hook #'irony-eldoc))

  ;; ;;(setq lsp-clangd-executable "clangd-6.0")
  ;; ;;(setq lsp-clients-clangd-executable "clangd-6.0")

  (use-feature cider
    :straight t
    :config
    (add-hook 'cider-repl-mode-hook #'company-mode)
    (add-hook 'cider-mode-hook #'company-mode)
    (add-hook 'cider-mode-hook #'eldoc-mode)
;    (add-hook 'cider-mode-hook #'cider-hydra-mode)
    (setq cider-repl-use-pretty-printing t)
    (setq cider-repl-display-help-banner nil)
;;    (setq cider-default-cljs-repl "(do (use 'figwheel-sidecar.repl-api) (start-figwheel!) (cljs-repl))")

    :bind (("M-r" . cider-namespace-refresh)
           ("C-c r" . cider-repl-reset)
           ("C-c ." . cider-reset-test-run-tests))
    )

  (use-feature dumb-jump
    :bind (("M-g o" . dumb-jump-go-other-window)
           ("M-g j" . dumb-jump-go)
           ("M-g x" . dumb-jump-go-prefer-external)
           ("M-g z" . dumb-jump-go-prefer-external-other-window))
    :config
    ;; (setq dumb-jump-selector 'ivy) ;; (setq dumb-jump-selector 'helm)
    :init
    (dumb-jump-mode)

    )

  (use-feature grip-mode :straight t)
  ;; font scaling
  (use-feature default-text-scale
    :straight t
    :bind (
           ("C-M-=" .  default-text-scale-increase)
           ("C-M--" . default-text-scale-decreaase))
    )

  ;; ;; narrow/widen dwim
  ;;   ; if you're windened, narrow to the region, if you're narrowed, widen
  ;;   ; bound to C-x n
  ;;   (defun narrow-or-widen-dwim (p)
  ;;   "If the buffer is narrowed, it widens. Otherwise, it narrows intelligently.
  ;;   Intelligently means: region, org-src-block, org-subtree, or defun,
  ;;   whichever applies first.
  ;;   Narrowing to org-src-block actually calls `org-edit-src-code'.

  ;;   With prefix P, don't widen, just narrow even if buffer is already
  ;;   narrowed."
  ;;   (interactive "P")
  ;;   (declare (interactive-only))
  ;;   (cond ((and (buffer-narrowed-p) (not p)) (widen))
  ;;   ((region-active-p)
  ;;   (narrow-to-region (region-beginning) (region-end)))
  ;;   ((derived-mode-p 'org-mode)
  ;;   ;; `org-edit-src-code' is not a real narrowing command.
  ;;   ;; Remove this first conditional if you don't want it.
  ;;   (cond ((ignore-errors (org-edit-src-code))
  ;;   (delete-other-windows))
  ;;   ((org-at-block-p)
  ;;   (org-narrow-to-block))
  ;;   (t (org-narrow-to-subtree))))
  ;;   (t (narrow-to-defun))))

  ;;   ;; (define-key endless/toggle-map "n" #'narrow-or-widen-dwim)
  ;;   ;; This line actually replaces Emacs' entire narrowing keymap, that's
  ;;   ;; how much I like this command. Only copy it if that's what you want.
  ;;   (define-key ctl-x-map "n" #'narrow-or-widen-dwim)



;  (use-feature restclient :straight t)

  ;; (use-feature company-restclient
  ;;   :straight t
  ;;   :config
  ;;   (add-to-list 'company-backends 'company-restclient))

  (use-feature multiple-cursors
    :straight t
    )

  (defhydra hydra-multiple-cursors (:hint nil)
    "
  Up^^             Down^^           Miscellaneous           % 2(mc/num-cursors) cursor%s(if (> (mc/num-cursors) 1) \"s\" \"\")
------------------------------------------------------------------
 [_p_]   Next     [_n_]   Next     [_l_] Edit lines  [_0_] Insert numbers
 [_P_]   Skip     [_N_]   Skip     [_a_] Mark all    [_A_] Insert letters
 [_M-p_] Unmark   [_M-n_] Unmark   [_s_] Search
 [Click] Cursor at point       [_q_] Quit"
    ("l" mc/edit-lines :exit t)
    ("a" mc/mark-all-like-this :exit t)
    ("n" mc/mark-next-like-this)
    ("N" mc/skip-to-next-like-this)
    ("M-n" mc/unmark-next-like-this)
    ("p" mc/mark-previous-like-this)
    ("P" mc/skip-to-previous-like-this)
    ("M-p" mc/unmark-previous-like-this)
    ("s" mc/mark-all-in-region-regexp :exit t)
    ("0" mc/insert-numbers :exit t)
    ("A" mc/insert-letters :exit t)
    ("<mouse-1>" mc/add-cursor-on-click)
    ;; Help with click recognition in this hydra
    ("<down-mouse-1>" ignore)
    ("<drag-mouse-1>" ignore)
    ("q" nil))

  (use-feature focus
    :straight t
    )

  (use-feature exec-path-from-shell
    :straight t
    :config
    (exec-path-from-shell-initialize))


  (use-feature fish-completion
    :straight t
    :config
    (global-fish-completion-mode))

    (use-feature eshell-prompt-extras
    :straight t
    :config
    (setq epe-show-python-info nil)
    )

    (use-feature eshell-git-prompt
    :straight t
    :config
    (eshell-git-prompt-use-theme 'git-radar)
    )


  (defun org-agenda-show-agenda-and-todo (&optional arg)
    (interactive "P")
    (org-agenda arg "c")
    (org-agenda-fortnight-view))

  ;; set up my own map
  (define-prefix-command 'z-map)
  (global-set-key (kbd "s-m") 'z-map) ;; was C-1
  (define-key z-map (kbd "k") 'compile)
  (define-key z-map (kbd "c") 'hydra-multiple-cursors/body)
  (define-key z-map (kbd "f") 'hydra-origami/body)
  (define-key z-map (kbd "m") 'mu4e)
  (define-key z-map (kbd "1") 'org-global-cycle)
  (define-key z-map (kbd "a") 'org-agenda-show-agenda-and-todo)
  (define-key z-map (kbd "g") 'counsel-ag)
  (define-key z-map (kbd "2") 'make-frame-command)
  (define-key z-map (kbd "0k") 'delete-frame)
  (define-key z-map (kbd "o") 'other-frame)

  (define-key z-map (kbd "s") 'flyspell-correct-word-before-point)
  (define-key z-map (kbd "i") 'z/load-iorg)
  (define-key z-map (kbd "*") 'calc)
  (define-key z-map (kbd "e") 'eshell-switcher)

  (setq user-full-name "Joe Duhamel"
        user-mail-address "joe@kflow.io")

  (use-feature nameframe
    :straight t)

  (use-feature nameframe-projectile
    :straight t
    :after projectile
    :config
    (nameframe-projectile-mode t)
    )

  (use-feature nameframe-perspective
    :straight t
    :after perspective
    :config (nameframe-perspective-mode t)
    )

  (use-feature diredfl
    :straight t
    :config
    (diredfl-global-mode 1))

  (setq
   dired-listing-switches "-laXGh --group-directories-first"
   dired-dwim-target t)

  (add-hook 'dired-mode-hook 'dired-hide-details-mode)

  (use-feature dired-recent
    :straight t
    :config
    (dired-recent-mode  1)
    )

  (global-set-key [mouse-3] 'flyspell-correct-word-before-point)

  (use-feature floobits :straight t)

  (use-feature perspective
    :straight t
    :config
    (persp-mode))

  (use-feature openwith
    :straight t
    :config
    (setq openwith-associations
          (list
           (list (openwith-make-extension-regexp
                  '("mpg" "mpeg" "mp3" "mp4"
                    "avi" "wmv" "wav" "mov" "flv"
                    "ogm" "ogg" "mkv"))
                 "vlc"
                 '(file))
           (list (openwith-make-extension-regexp
                  '("xbm" "pbm" "pgm" "ppm" "pnm"
                    "png" "gif" "bmp" "tif" "jpeg" "jpg"))
                 "xviewer"
                 '(file))
           (list (openwith-make-extension-regexp
                  '("pdf"))
                 "evince"
                 '(file))
           (list (openwith-make-extension-regexp
                  '("docx" "xlsx" "doc" "xls" "ppt" "odt" "ods" "odg" "odp"))
                 "libreoffice"
                 '(file))
           ))
    (openwith-mode 1))

    (load-theme 'night-owl t)
  )

  ;; (defun mz/elfeed-browse-url (&optional use-generic-p)
  ;;   "Visit the current entry in your browser using `browse-url'.
  ;;   If there is a prefix argument, visit the current entry in the
  ;;   browser defined by `browse-url-generic-program'."
  ;;   (interactive "P")
  ;;   (let ((entries (elfeed-search-selected)))
  ;;     (cl-loop for entry in entries
  ;;              do (if use-generic-p
  ;;                     (browse-url-generic (elfeed-entry-link entry))
  ;;                   (browse-url (elfeed-entry-link entry))))
  ;;     (mapc #'elfeed-search-update-entry entries)
  ;;     (unless (or elfeed-search-remain-on-entry (use-region-p))
  ;;       (forward-line))))

  ;; (defun elfeed-mark-all-as-read ()
  ;;   (interactive)
  ;;   (mark-whole-buffer)
  ;;   (elfeed-search-untag-all-unread))

  ;; ;;functions to support syncing .elfeed between machines
  ;; ;;makes sure elfeed reads index from disk before launching
  ;; (defun bjm/elfeed-load-db-and-open ()
  ;;   "Wrapper to load the elfeed db from disk before opening"
  ;;   (interactive)
  ;;   (elfeed-db-load)
  ;;   (elfeed)
  ;;   (elfeed-search-update--force))

  ;; ;;write to disk when quiting
  ;; (defun bjm/elfeed-save-db-and-bury ()
  ;;   "Wrapper to save the elfeed db to disk before burying buffer"
  ;;   (interactive)
  ;;   (elfeed-db-save)
  ;;   (quit-window))

  ;; (use-feature elfeed
  ;;   :straight t
  ;;   :bind (:map elfeed-search-mode-map
  ;;               ;;               ("q" . bjm/elfeed-save-db-and-bury)
  ;;               ;;               ("Q" . bjm/elfeed-save-db-and-bury)
  ;;               ("m" . elfeed-toggle-star)
  ;;               ("M" . elfeed-toggle-star)
  ;;               ;;               ("j" . mz/make-and-run-elfeed-hydra)
  ;;               ;;               ("J" . mz/make-and-run-elfeed-hydra)
  ;;               ;;               ("b" . mz/elfeed-browse-url)
  ;;               ("B" . elfeed-search-browse-url)
  ;;               )
  ;;   :config
  ;;     (setq elfeed-db-directory "~/Dropbox/shared/elfeeddb")
  ;;     (defalias 'elfeed-toggle-star
  ;;     (elfeed-expose #'elfeed-search-toggle-all 'star)))

  ;; (use-feature elfeed-goodies
  ;;   :straight t
  ;;   :config
  ;;   (elfeed-goodies/setup))

  ;; (use-feature elfeed-org
  ;;   :straight t
  ;;   :config
  ;;   (elfeed-org)
  ;;   )
  ;; ;;   (setq rmh-elfeed-org-files (list "~/Sync/shared/elfeed.org")))

  ;; (defun z/hasCap (s) ""
  ;;        (let ((case-fold-search nil))
  ;;          (string-match-p "[[:upper:]]" s)
  ;;          ))

  ;; (defun z/get-hydra-option-key (s)
  ;;   "returns single upper case letter (converted to lower) or first"
  ;;   (interactive)
  ;;   (let ( (loc (z/hasCap s)))
  ;;     (if loc
  ;;         (downcase (substring s loc (+ loc 1)))
  ;;       (substring s 0 1)
  ;;       )))

  ;; ;;  (active blogs cs eDucation emacs local misc sports star tech unread webcomics)
  ;; (defun mz/make-elfeed-cats (tags)
  ;;   "Returns a list of lists. Each one is line for the hydra configuratio in the form
  ;;          (c function hint)"
  ;;   (interactive)
  ;;   (mapcar (lambda (tag)
  ;;             (let* (
  ;;                    (tagstring (symbol-name tag))
  ;;                    (c (z/get-hydra-option-key tagstring))
  ;;                    )
  ;;               (list c (append '(elfeed-search-set-filter) (list (format "@6-months-ago +%s" tagstring) ))tagstring  )))
  ;;           tags))

  ;; (defmacro mz/make-elfeed-hydra ()
  ;;   `(defhydra mz/hydra-elfeed ()
  ;;      "filter"
  ;;      ,@(mz/make-elfeed-cats (elfeed-db-get-all-tags))
  ;;      ("*" (elfeed-search-set-filter "@6-months-ago +star") "Starred")
  ;;      ("M" elfeed-toggle-star "Mark")
  ;;      ("A" (elfeed-search-set-filter "@6-months-ago") "All")
  ;;      ("T" (elfeed-search-set-filter "@1-day-ago") "Today")
  ;;      ("Q" bjm/elfeed-save-db-and-bury "Quit Elfeed" :color blue)
  ;;      ("q" nil "quit" :color blue)
  ;;      ))

  ;; (defun mz/make-and-run-elfeed-hydra ()
  ;;   ""
  ;;   (interactive)
  ;;   (mz/make-elfeed-hydra)
  ;;   (mz/hydra-elfeed/body))

  ;; (defun my-elfeed-tag-sort (a b)
  ;;   (let* ((a-tags (format "%s" (elfeed-entry-tags a)))
  ;;          (b-tags (format "%s" (elfeed-entry-tags b))))
  ;;     (if (string= a-tags b-tags)
  ;;         (< (elfeed-entry-date b) (elfeed-entry-date a)))
  ;;     (string< a-tags b-tags)))

  ;; (setf elfeed-search-sort-function #'my-elfeed-tag-sort)

  ;; (defun my-dired-recent-dirs ()
  ;;   "Present a list of recently used directories and open the selected one in dired"
  ;;   (interactive)
  ;;   (let ((dir (ivy-read "Directory: "
  ;;                        dired-recent-directories
  ;;                        :re-builder #'ivy--regex
  ;;                        :sort nil
  ;;                        :initial-input nil)))
  ;;     (dired dir)))

  ;;  (use-feature keypression :straight t)

  ;;   (setq scroll-step 1)

  ;; (require 'cl-lib)
  ;;   (defun select-or-create (arg)
  ;;     "Commentary ARG."
  ;;     (if (string= arg "New eshell")
  ;;         (eshell t)
  ;;       (switch-to-buffer arg)))
  ;;   (defun eshell-switcher (&optional arg)
  ;;     "Commentary ARG."
  ;;     (interactive)
  ;;     (let* (
  ;;            (buffers (cl-remove-if-not (lambda (n) (eq (buffer-local-value 'major-mode n) 'eshell-mode)) (buffer-list)) )
  ;;            (names (mapcar (lambda (n) (buffer-name n)) buffers))
  ;;            (num-buffers (length buffers) )
  ;;            (in-eshellp (eq major-mode 'eshell-mode)))
  ;;       (cond ((eq num-buffers 0) (eshell (or arg t)))
  ;;             ((not in-eshellp) (switch-to-buffer (car buffers)))
  ;;             (t (select-or-create (completing-read "Select Shell:"
  ;;   (cons "New eshell" names)))))))

  ;; (defun eshell/in-term (prog &rest args)
  ;;   "Run shell command in term buffer."
  ;;   (switch-to-buffer (apply #'make-term prog prog nil args))
  ;;   (term-mode)
  ;;   (term-char-mode))
