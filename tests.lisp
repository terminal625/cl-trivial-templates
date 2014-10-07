
(in-package #:cl-user)

(defpackage #:cl-trivial-templates-tests
  (:use #:cl #:cl-trivial-templates #:fiveam #:iterate)
  (:export #:run-tests))


(in-package :cl-trivial-templates-tests)

(cl-interpol:enable-interpol-syntax)

(def-suite trivial-templates)
(in-suite trivial-templates)

(defun run-tests ()
  (let ((results (run 'trivial-templates)))
    (explain! results)
    (unless (results-status results)
      (error "Tests failed."))))

(define-template-modifier frob (x)
  (ttt-> :whatever (string-downcase x)))

(test simple
  (is (equal `(,#?"a\n" ,#?"b\n" #?"c\n") (let ((template "###whatever###"))
					    (declare (special template))
					    (iter (for x in '(a b c))
						  (collect (finalize-template (frob x))))))))
