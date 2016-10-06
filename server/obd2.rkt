#lang racket

(require "elm327.rkt")

(provide engine-rpm
         speed
         fuel-cons
         coolant-temp
         engine-load
         connect!)

(define displacement 4.16)

(define (single-byte pid)
  (bytes-ref (send-and-receive pid) 0))

(define (engine-rpm)
  (let ([bs (send-and-receive "010C")])
    (/ (+ (* 256 (bytes-ref bs 0)) 
          (bytes-ref bs 1)) 
       4.0)))

(define (speed)
  (single-byte "010D"))

(define (maf-rate)
  (let ([bs (send-and-receive "0110")])
    (/ (+ (* 256 (bytes-ref bs 0)) 
          (bytes-ref bs 1)) 
       100)))

(define (manifold-abs-press)
  (single-byte "010B"))

(define (iat)
  (- (single-byte "010F") 40))

(define (fuel-trim)
  (* (- (single-byte "0106") 128)
     (/ 100 128)))

(define fuel-rate
  (case-lambda
    [()    
     (let ([bs (send-and-receive "015E")])
       (* (+ (* 256 (bytes-ref bs 0)) (bytes-ref bs 1)) 
          0.05))]
    
    [(maf ftrim)  
     (* 3600 
        (/ (* (/ maf 14.7) (+ 1 (/ ftrim 100))) 
           726))]))

(define (fuel-cons spd)
  (* (fuel-rate (maf-rate) (fuel-trim)) 
     (/ 100 spd)))

(define (coolant-temp)
  (- (single-byte "0105") 40))

(define (engine-load)
  (/ (* (single-byte "0104") 100)
     255))

