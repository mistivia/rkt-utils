#lang racket

(provide define-curried
         curried-lambda
         call-curried)

(define-syntax curried-lambda
  (syntax-rules ()
    ((_ (e1) e2 ...)
      (lambda (e1) e2 ...))
    ((_ (e1 e2 ...) e3 ...)
      (lambda (e1) (curried-lambda (e2 ...) e3 ...)))))

(define-syntax define-curried
  (syntax-rules ()
    ((_ (f e1 ...) e2 ...)
      (define f
        (curried-lambda (e1 ...) e2 ...)))))

(define-syntax call-curried
  (syntax-rules ()
    ((_ f e)
      (f e))
    ((_ f e1 ... e2)
      ((call-curried f e1 ...) e2))))
