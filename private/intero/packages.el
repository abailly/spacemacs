;; 1. place this in ~/.emacs.d/private/intero/packages.el

;; 2. add intero, syntax-checking and auto-completion to your
;; ~/.spacemacs layer configuration & remove the haskell layer
;; if you were using that before

;; 3. make sure you have stack installed http://haskellstack.org

;; 4. fire up emacs & open up a stack project's source files

(defconst intero-packages
  '(company
    flycheck
    haskell-mode
    hindent
    (intero :location (recipe
                       :repo "chrisdone/intero"
                       :fetcher github
                       :files ("elisp/intero.el")))))

(defun intero/init-company-mode ()
  (use-package company-mode))

(defun intero/init-hindent ()
  (use-package hindent))

(defun intero/init-haskell-mode ()
  (use-package haskell-mode))
(defun intero/post-init-haskell-mode ()
  (add-hook 'haskell-mode-hook 'hindent-mode)
  (add-hook 'haskell-mode-hook 'intero-mode))

(defun intero/init-intero ()
  (use-package intero
    :config
    (progn
      ;; provide SPC-m bindings for common intero commands
      (spacemacs/set-leader-keys-for-minor-mode 'intero-mode "l" 'intero-repl-load)
      (spacemacs/set-leader-keys-for-minor-mode 'intero-mode "t" 'intero-type-at)
      (spacemacs/set-leader-keys-for-minor-mode 'intero-mode "b" 'pop-tag-mark)
      (spacemacs/set-leader-keys-for-minor-mode 'intero-mode "i" 'intero-info)
      (spacemacs/set-leader-keys-for-minor-mode 'intero-mode "u" 'intero-uses-at)
      (spacemacs/set-leader-keys-for-minor-mode 'intero-mode "R" 'intero-restart)
      (spacemacs/set-leader-keys-for-minor-mode 'intero-mode "T" 'intero-targets)
      (spacemacs/set-leader-keys-for-minor-mode 'intero-mode "d" 'intero-goto-definition))
    ))

(defun intero/post-init-intero ()
  (flycheck-add-next-checker 'intero '(warning . haskell-hlint)))
