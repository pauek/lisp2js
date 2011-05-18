(setf x 1)

(defun f (x) (1+ x))

(defmacro defun-ex (name args &body body)
  `(with-slots (,name) exports
	  (setf ,name (lambda ,args ,@body))))

(defun-ex superfunc (a b)
  (+ a b))