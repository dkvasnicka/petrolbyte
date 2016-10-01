#lang racket

(require "../obd2.rkt")

(connect!)

(define (format-line l)
  (string-join
    (map (curry ~r #:precision 2) l)
    ","))

(let loop ([spd (speed)]) 
  (unless (zero? spd)
    (displayln 
      (format-line
        (list (engine-rpm) (coolant-temp) 
              (engine-load) spd (fuel-cons spd)))))
  (loop (speed)))
