#lang racket

(provide define-macro)

(define-syntax define-macro
  (lambda (x)
    (syntax-case x ()
      ((_ (macro . args) body ...)
       #'(define-macro macro (lambda args body ...)))
      ((_ macro transformer)
       #'(define-syntax macro
           (lambda (y)
             (syntax-case y ()
               ((_ . args)
                (let ((v (syntax->datum #'args)))
                  (datum->syntax y (apply transformer v)))))))))))

