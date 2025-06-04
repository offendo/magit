;;; init --- minimal settings for magit
;;; Commentary:
;;; Code:
(setq user-init-file (or load-file-name (buffer-file-name)))
(setq user-emacs-directory (file-name-directory user-init-file))

(defvar bootstrap-version)
(setq straight-disable-native-compile t)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)
(use-package magit :straight t)

;;; Vim Bindings
(use-package evil
  :straight t
  :demand t
  :bind (("<escape>" . keyboard-escape-quit))
  :init
  ;; allows for using cgn
  (setq evil-want-keybinding nil)
  ;; no vim insert bindings
  (setq evil-undo-system 'undo-fu)
  :config
  (evil-mode 1))

(use-package evil-collection
  :straight t
  :after evil
  :config
  (evil-collection-init))

(menu-bar-mode -1)
(defalias 'yes-or-no-p 'y-or-n-p)
(setq inhibit-startup-screen t)
(setq initial-scratch-message "")

(setq-default message-log-max nil)
(setq-default mode-line-format nil)
(kill-buffer "*scratch*")
(kill-buffer "*Messages*")
(kill-buffer "*straight-process*")


(defun kill-other-buffers ()
  "Kill all other buffers."
  (interactive)
  (mapc 'kill-buffer (delq (current-buffer) (buffer-list))))

(defun close-all ()
  (interactive)
  (mapc 'kill-buffer (buffer-list))
  (delete-frame)
  )

(defun open-magit ()
  (interactive)
  (kill-other-buffers)
  (magit-status)
  (delete-other-windows))

(define-key global-map (kbd "C-q") 'close-all)

;;; init.el ends here
(provide 'init)
