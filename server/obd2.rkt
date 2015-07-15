#lang racket

(require "elm327.rkt")

(provide engine-rpm
         connect!)

(define (engine-rpm)
  (let ([bs (send-and-receive "010C")])
    (exact->inexact
      (/ (+ (* 256 (bytes-ref bs 0)) (bytes-ref bs 1)) 4))))
