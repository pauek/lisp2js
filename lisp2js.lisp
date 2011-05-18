#!/usr/bin/sbcl --script

(require :asdf)
(labels ((personal-dir (x)
			  (merge-pathnames x (user-homedir-pathname))))
  (load (personal-dir "src/lisp/asdf.lisp")))

(asdf:oos 'asdf:load-op :parenscript :verbose nil)

(defun js-filename (lisp-filename)
  (let ((base (subseq lisp-filename 0 
							 (position #\. lisp-filename))))
	 (format nil "~a.js" base)))

(when (> (length sb-ext:*posix-argv*) 1)
  (let* ((input-filename (nth 1 sb-ext:*posix-argv*))
			(js-filename (js-filename input-filename)))
	 (with-open-file (parenscript:*parenscript-stream* js-filename 
																		:direction :output
																		:if-exists :supersede)
		(parenscript:ps-compile-file (nth 1 sb-ext:*posix-argv*)))))
