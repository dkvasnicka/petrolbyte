#lang rackjure

(require "../obd2.rkt"
         json)

(current-curly-dict hasheq)
(connect!)

(define (make-json spd rpm fcons)
  (jsexpr->string
    {'rpm       rpm 
     'speed     spd
     'fuel-cons fcons}))

(let loop ([spd (speed)]) 
  (unless (zero? spd)
    (let ([rpm (engine-rpm)])
      (displayln (make-json spd rpm (fuel-cons spd rpm)))))
  (loop (speed)))
