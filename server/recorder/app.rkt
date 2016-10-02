#lang rackjure

(require "../obd2.rkt"
         json)

(current-curly-dict hasheq)
(connect!)

(define (jsx->str jsval)
  (jsexpr->string
    (for/hasheq ([(k v) jsval])
                (values k (exact->inexact v)))))

(let loop ([spd (speed)]) 
  (unless (zero? spd)
    (displayln 
      (jsx->str
        {'rpm       (engine-rpm)
         'temp      (coolant-temp)
         'load      (engine-load)
         'speed     spd 
         'fuel-cons (fuel-cons spd)})))
  (loop (speed)))
