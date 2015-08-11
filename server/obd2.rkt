#lang racket

(require "elm327.rkt")

(provide engine-rpm
         speed
         fuel-cons
         connect!)

(define displacement 4.16)

(define (engine-rpm)
  (let ([bs (send-and-receive "010C")])
    (/ (+ (* 256 (bytes-ref bs 0)) 
          (bytes-ref bs 1)) 
       4.0)))

(define (speed)
  (bytes-ref (send-and-receive "010D") 0))

(define (maf-rate)
  (let ([bs (send-and-receive "0110")])
    (/ (+ (* 256 (bytes-ref bs 0)) 
          (bytes-ref bs 1)) 
       100)))

(define (manifold-abs-press)
  (bytes-ref (send-and-receive "010B") 0))

(define (iat)
  (- (bytes-ref (send-and-receive "010F") 0) 40))

(define (estimated-maf rpm)
  (* (/ (manifold-abs-press) (iat))
     (/ 28.97 8.314)
     (/ rpm 60)
     (/ displacement 2)
     0.8))

(define (fuel-rate maf)
  (* 3600 (/ (/ maf 14.7) 750)))

(define (fuel-cons spd rpm)
  (* (fuel-rate (maf-rate)) 
     (/ 100 (exact->inexact spd))))
