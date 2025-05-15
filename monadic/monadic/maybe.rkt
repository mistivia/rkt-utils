#lang racket

(require "./main.rkt")

(provide just nothing maybe-monad)

(struct just (val) #:transparent)
(define nothing 'nothing)

(define maybe-monad
  (monad-i
    ;; pure
    just
    ;; bind
    (lambda (m k)
      (match m
        ((quote nothing) nothing)
        ((struct just (x)) (k x))))))


