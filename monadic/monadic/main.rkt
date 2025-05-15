#lang racket

(require defmacro)

(provide monad-i
         let-monad
         monad-do
         monad-i-bind
         monad-i-pure)

(struct monad-i (pure bind))

(define-macro (let-monad monad-inst . exps)
  `(let ((bind (monad-i-bind ,monad-inst))
         (pure (monad-i-pure ,monad-inst)))
     (begin
       ,@exps)))


(define-macro (monad-do . exps)
  (define (impl exps)
    (if (eq? (cdr exps) '())
        (car exps)
        (let ((e (car exps))
              (es (cdr exps)))
          (if (and (pair? e)
                   (eq? (car e) 'assign))
              `(bind ,(caddr e) (lambda (,(cadr e))
                                  ,(impl es)))
              `(bind ,e (lambda (,(gensym)) ,(impl es)))))))
  (impl exps))

