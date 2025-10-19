;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
(cond
 ((eq system-type 'darwin)
  (setq doom-font (font-spec :family "HackGen Console NF" :size 20 :weight 'regular)
        doom-variable-pitch-font (font-spec :family "HackGen Console NF" :size 21)))
 (t
  (setq doom-font (font-spec :family "HackGen Console NF" :size 25 :weight 'regular)
        doom-variable-pitch-font (font-spec :family "HackGen Console NF" :size 36))))

;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-spacegrey)
(after! doom-themes
  (set-face-attribute 'org-level-1 nil :height 1.2 :weight 'bold)
  (set-face-attribute 'org-level-2 nil :height 1.05 :weight 'bold)
  (set-face-attribute 'org-level-3 nil :weight 'bold)
  (set-face-attribute 'org-block nil :background "#191d23"))
(setq evil-normal-state-cursor  '(box "white")
      evil-insert-state-cursor  '(bar "white")
      evil-visual-state-cursor '(hollow "white")
      evil-replace-state-cursor '(hbar "white"))

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type nil)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Dropbox/org/")

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

; orgファイルのtextlintのために追加
(set-language-environment "Japanese")
(setq locale-coding-system 'utf-8)
(setq-default buffer-file-coding-system 'utf-8)
(setq-default coding-system-for-write 'utf-8)
(setq-default coding-system-for-read 'utf-8); projectileのキャッシュファイル文字化けに対応

; org繰り返すタスクの完了ログを無効
(setq org-log-repeat nil)

; 行間
(setq-default line-spacing 0.3)

; 折り返し
(global-word-wrap-whitespace-mode t)
(add-to-list 'word-wrap-whitespace-characters ?\])

; 挿入する曜日表記を英語に
(setq system-time-locale "C")

; インラインコードなどの記号を非表示
(setq org-hide-emphasis-markers t)

; org-clockのステータスラインでの経過時間を当日集計にする
(setq org-clock-mode-line-total 'today)

; flycheck
(setq flycheck-checker-error-threshold 2000)
; textlintを止める
(setq flycheck-global-modes nil)
; textlintの実行パス
(setq flycheck-textlint-executable
      (expand-file-name
       "scoop/apps/nvm/current/nodejs/nodejs/textlint.cmd"
       (getenv "HOME")))
(setq flycheck-textlint-config "~/Dropbox/org/.textlintrc.js")
; flycheckのテンポラリファイルの文字化け対応（日本語をアンダーバーに置換）
(after! flycheck
  (advice-add 'flycheck-temp-file-system :around
              (lambda (orig filename)
                (let* ((base (file-name-nondirectory filename))
                       (safe-base (replace-regexp-in-string "[^[:ascii:]]" "_" base)))
                  (funcall orig safe-base)))))

(map! :map override
      :n "C-h" #'evil-window-left
      ; C-hはSPC hで代用可能
      :n "C-j" #'evil-window-down
      :n "C-k" #'evil-window-up
      :n "C-l" #'evil-window-right
      :n "C-q" #'evil-window-delete
      :n "S-<left>" #'evil-window-decrease-width
      :n "S-<right>" #'evil-window-increase-width
      :n "S-<up>" #'evil-window-decrease-height
      :n "S-<down>" #'evil-window-increase-height)

(map!
 :leader
 :desc "Toggle Treemacs"
 "e" #'treemacs)

(map!
 :prefix "C-c"
 "t" (lambda () (interactive) (org-capture nil "t"))
 "i" (lambda () (interactive) (org-capture nil "i"))
 "j" (lambda () (interactive) (org-capture nil "j"))
 "l" (lambda () (interactive) (org-capture nil "l"))
 "n l" 'org-roam-buffer-toggle
 "n f" 'org-roam-node-find
 "n g" 'org-roam-ui-mode
 "n i" 'org-roam-node-insert
 "n c" 'org-roam-capture
 "n C" #'cfw:open-org-calendar
 )

(after! org
  ; org-refile
  (setq org-refile-targets '(("inbox.org" :maxlevel 2)
                        (+org-capture-journal-file :maxlevel 2)))

  ; org-capture
  (setq org-capture-templates
      '(("t" "Todo" entry (file+headline "inbox.org" "Inbox")
         "* TODO %?\n%i"
        :refile-targets ((+org-capture-journal-file :regexp . "Done")))
        ("i" "warikomi" entry (file+function +org-capture-journal-file
        (lambda ()
                (org-datetree-find-date-create (org-date-to-gregorian (org-today)) t)
                (let ((year (nth 2 (org-date-to-gregorian (org-today))))
                (month (car (org-date-to-gregorian (org-today))))
                (day (nth 1 (org-date-to-gregorian (org-today)))))
                (setq match (re-search-forward (format "^\\*+[ \t]+%d-%02d-%02d \\w+\n\\*+[ \t]+Done$" year month day) nil t))
                (cond
                ((not match)
                (beginning-of-line 2)
                (insert "* ")
                (org-do-demote)
                (org-do-demote)
                (org-do-demote)
                (insert "Done\n")
                (insert "* ")
                (org-do-demote)
                (org-do-demote)
                (org-do-demote)
                (insert "Log")) (t
                nil)))
                (re-search-backward "^\\*.+ Done" nil t)
        ))
        "* %?"
        :clock-in t
        :clock-resume t
        ;; :time-prompt t
        :jump-to-captured t)
        ("j" "Journal" plain (file+datetree +org-capture-journal-file)
        nil
        :time-prompt t
        :immediate-finish t
        :jump-to-captured t)
        ("l" "Journal Logs" plain (file+function +org-capture-journal-file
        (lambda ()
                (org-datetree-find-date-create (org-date-to-gregorian (org-today)) t)
                (let ((year (nth 2 (org-date-to-gregorian (org-today))))
                (month (car (org-date-to-gregorian (org-today))))
                (day (nth 1 (org-date-to-gregorian (org-today)))))
                (setq match (re-search-forward (format "^\\*+[ \t]+%d-%02d-%02d \\w+\n\\*+[ \t]+Done$" year month day) nil t))
                (cond
                ((not match)
                (beginning-of-line 2)
                (insert "* ")
                (org-do-demote)
                (org-do-demote)
                (org-do-demote)
                (insert "Done\n")
                (insert "* ")
                (org-do-demote)
                (org-do-demote)
                (org-do-demote)
                (insert "Log")
                )
                (t
                nil)))
                (re-search-forward "^\\*.+ Log" nil t)
                (org-end-of-subtree t t)
                (newline)
        ))
        "- %<[%H:%M]> %?"
        :jump-to-captured nil)
        ))

  ;; clocktable挿入（org-mode 限定）
  (defun my/org-insert-today-clocktable ()
    "Insert a clocktable for today's subtree, with no indent."
    (interactive)
    (let ((org-clocktable-indent-string ""))
      (save-excursion
        ;; Move to heading start (in case point is mid-subtree)
        (org-back-to-heading t)
        ;; Insert clocktable block
        (insert "#+BEGIN: clocktable :maxlevel 6 :compact t :block today\n")
        (insert (format "#+CAPTION: Clock summary at [%s], for %s.\n"
                        (format-time-string "%Y-%m-%d %a %H:%M")
                        (format-time-string "%A, %B %d, %Y")))
        (insert "#+END:\n\n")
        ;; Generate the report
        (forward-line -3) ; move cursor to the BEGIN line
        (org-dblock-update))))

  (map! :map org-mode-map
        "C-c r" #'my/org-insert-today-clocktable)

  ;; S-Enter で左右分割
  (defun my/org-open-at-point-horizontal ()
    (interactive)
    (unless (window-in-direction 'right)
      (split-window-right))
    (other-window 1)
    (org-open-at-point))

  (map! :map org-mode-map
        :n "S-<return>" #'my/org-open-at-point-horizontal)
)

(after! evil
  ;; Evilの角括弧プレフィックスを無効化
  (define-key evil-motion-state-map (kbd "[") nil)
  (define-key evil-motion-state-map (kbd "]") nil))

(after! org
  ;; Orgで単体バインド
  (evil-define-key 'normal org-mode-map
    (kbd "[") #'org-previous-visible-heading
    (kbd "]") #'org-next-visible-heading))

;; コードブロックのシンタックスハイライトが効かないときに試す
;; (org-babel-do-load-languages
;;  'org-babel-load-languages
;;  '(
;;    (shell . t)
;;    )
;;  )

(use-package! org-roam
  :config
  (org-roam-db-autosync-mode)
  (setq org-roam-completion-everywhere nil)
  (setq org-roam-capture-templates
      '(("f" "Fleeting(一時メモ)" plain "%?"
         :target (file+head "fleeting/%<%Y%m%d%H%M%S>-${slug}.org" "#+TITLE: ${title}\n")
         :unnarrowed t)
        ("l" "Literature(文献)" plain "%?"
         :target (file+head "literature/%<%Y%m%d%H%M%S>-${slug}.org" "#+TITLE: ${title}\n")
         :unnarrowed t)
        ("p" "Permanent(記事)" plain "%?"
         :target (file+head "permanent/%<%Y%m%d%H%M%S>-${slug}.org" "#+TITLE: ${title}\n")
         :unnarrowed t)
        ("s" "Structure(まとめ)" plain "%?"
         :target (file+head "structure/%<%Y%m%d%H%M%S>-${slug}.org" "#+TITLE: ${title}\n")
         :unnarrowed t)
        ("b" "Blog(ブログ)" plain "%?"
         :target (file+head "blog/%<%Y%m%d%H%M%S>-${slug}.org" "#+TITLE: ${title}\n")
         :unnarrowed t)))
  (require 'org-roam-protocol))

(use-package! org-roam-ui
  :after org-roam
  ;; :hook (org-roam-mode . org-roam-ui-mode)
  :config
  (setq org-roam-ui-sync-theme t
        org-roam-ui-follow t
        org-roam-ui-update-on-save t
        org-roam-ui-open-on-start t))

(use-package! org-download
  :after org
  :config
  (setq-default org-download-image-dir "./images"
        org-download-heading-lvl nil
        org-download-screenshot-method "magick clipboard: %s"
        org-download-annotate-function (lambda (_) "")))

(use-package! ox-zenn
  :after ox
  :config
  (require 'ox-zenn)
  (add-to-list 'org-export-backends 'zenn))

;; org-sidebar は遅延ロードでOK
(use-package! org-sidebar
  :commands (org-sidebar-tree-toggle org-sidebar-toggle)
  :config
  (setq org-sidebar-tree-jump-fn #'org-sidebar-tree-jump-source)
  (setq org-sidebar-tree-side 'right))

;; SPC o で見出しツリーをサイドバー表示/非表示
(map! :leader
      :desc "Org Sidebar (headings)"
      "o" #'org-sidebar-tree-toggle)

;; Treemacs がロードされた後にペイン移動のショートカットが消える問題への対処
(after! treemacs
  (map! :map treemacs-mode-map
        "C-h" #'evil-window-left
        "C-j" #'evil-window-down
        "C-k" #'evil-window-up
        "C-l" #'evil-window-right
        "C-q" #'evil-window-delete
        "S-<return>" #'treemacs-visit-node-horizontal-split))

;; ポモドーロ
;; ---- 資源パス（ユーザー名直書きなし）----
(defconst my/home (or (getenv "USERPROFILE") (getenv "HOME")))
(defconst my/pomo-res
  (expand-file-name "Dropbox/org/pomodoro_resources" my/home))

(use-package! org-pomodoro
  :custom
  (org-pomodoro-length 25)
  (org-pomodoro-short-break-length 5)
  (org-pomodoro-long-break-length 15)
  (org-pomodoro-long-break-frequency 4)
  (org-pomodoro-manual-break t)
  (org-pomodoro-start-sound-p t)
  (org-pomodoro-overtime-sound-p t)
  (org-pomodoro-start-sound   (expand-file-name "start.wav" my/pomo-res))
  (org-pomodoro-overtime-sound   (expand-file-name "break.wav" my/pomo-res))
  (org-pomodoro-finished-sound   (expand-file-name "break.wav" my/pomo-res))
  (org-pomodoro-short-break-sound   (expand-file-name "start.wav" my/pomo-res))
  (org-pomodoro-long-break-sound   (expand-file-name "start.wav" my/pomo-res))
  (org-pomodoro-format "%s")
  (org-pomodoro-short-break-format "%s")
  (org-pomodoro-long-break-format  "%s")
  :custom-face
  (org-pomodoro-mode-line ((t (:foreground "#ff5555"))))
  (org-pomodoro-mode-line-break ((t (:foreground "#50a05b"))))
  )

;; 1) 初期化を固定値から nil に
(defvar my/pomo-last nil)

(defun my/org-pomodoro-quick (&optional m s l f)
  "実行中なら org-pomodoro をそのまま実行。
未実行なら長さ入力→開始。余計な確認は一切しない。"
  (interactive)
  (require 'org-pomodoro)
  (require 'subr-x)

  ;; すでに org-pomodoro が動作中なら、無条件で本体を呼ぶ
  ;; （残業中なら即休憩開始、通常作業中ならパッケージ側が必要に応じて確認）
  (when (org-pomodoro-active-p)
    (org-pomodoro)
    (cl-return-from my/org-pomodoro-quick nil))  ;; cl-lib が嫌ならこの行は削除してOK

  ;; --- ここから新規開始（値入力→反映） ---
  (let* ((d1 org-pomodoro-length)
         (d2 org-pomodoro-short-break-length)
         (d3 org-pomodoro-long-break-length)
         (d4 org-pomodoro-long-break-frequency))
    (unless (and m s l f)
      (let* ((inp (string-trim
                   (read-from-minibuffer
                    (format "mins short long freq (default %g %g %g %d): "
                            d1 d2 d3 d4))))
             (nums (and (not (string-empty-p inp))
                        (mapcar #'string-to-number
                                (split-string inp "[^0-9.]+" t)))))
        (setq m (or (and nums (nth 0 nums)) d1)
              s (or (and nums (nth 1 nums)) d2)
              l (or (and nums (nth 2 nums)) d3)
              f (or (and nums (nth 3 nums)) d4))))
    (setq org-pomodoro-length               m
          org-pomodoro-short-break-length   s
          org-pomodoro-long-break-length    l
          org-pomodoro-long-break-frequency f
          my/pomo-last (list m s l f))
    (org-pomodoro)))

;; ---- 休憩明けは直近設定で自動再開（安全に元位置へ戻す）----
(add-hook 'org-pomodoro-break-finished-hook
  (lambda ()
    (save-window-excursion
      (save-excursion
        (org-clock-goto)
        ;; 直前の設定があればそれを使い、なければ現行値を使う
        (pcase-let* ((defaults (list org-pomodoro-length
                                     org-pomodoro-short-break-length
                                     org-pomodoro-long-break-length
                                     org-pomodoro-long-break-frequency))
                     (`(,m ,s ,l ,f) (or my/pomo-last defaults)))
          (when (y-or-n-p (format "Start next pomodoro (%g min)? " m))
            ;; 承諾されたら設定を反映して開始
            (setq org-pomodoro-length               m
                  org-pomodoro-short-break-length   s
                  org-pomodoro-long-break-length    l
                  org-pomodoro-long-break-frequency f
                  my/pomo-last (list m s l f))
            (let ((current-prefix-arg nil))
              (org-pomodoro))))))))

;; ---- キーバインド：SPC n p で一行入力起動 ----
(map! :leader (:prefix ("n" . "notes")
               :desc "Pomodoro (quick)" "p" #'my/org-pomodoro-quick))

;; calfw
(use-package! calfw
  :config
  (use-package! calfw-org))

(defun my/open-org-calendar ()
  (interactive)
  (cfw:open-org-calendar))

(use-package! japanese-holidays
  :after calfw
  :config
  (setq calendar-holidays (append japanese-holidays))
  (setq calendar-mark-holidays-flag t))

(after! org
   (global-org-modern-mode t))
(use-package! org-modern-indent
  :after org-modern
  :hook (org-mode . org-modern-indent-mode))
