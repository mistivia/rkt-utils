#lang racket

(require monadic)
(require monadic/maybe)
(require curried)

(define-curried (f monad-inst m)
  (let-monad monad-inst
    (monad-do
      (assign x m)
      (assign y (pure (+ x 1)))
      (pure (+ x y)))))

(define f-maybe (f maybe-monad))

(displayln (f-maybe (just 5)))
(displayln (f-maybe nothing))

