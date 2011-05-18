#!/usr/bin/sbcl --script

;; Stuff required to load parenscript
(require :asdf)
(labels ((personal-dir (x)
			  (merge-pathnames x (user-homedir-pathname))))
  (load (personal-dir "src/lisp/asdf.lisp")))

(asdf:oos 'asdf:load-op :parenscript :verbose nil)

(defun js-filename (lisp-filename)
  "Converts `test.lisp' into `test.js'"
  (let ((base (subseq lisp-filename 0 
							 (position #\. lisp-filename))))
	 (format nil "~a.js" base)))

(when (> (length sb-ext:*posix-argv*) 1)
  (let* ((input-filename (nth 1 sb-ext:*posix-argv*))
			(parenscript:*parenscript-stream* *standard-output*))
	 (parenscript:ps-compile-file input-filename)))
