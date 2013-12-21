#lang racket

(define listener (tcp-listen 35000))

(define [loop]
  (define-values (in out) (tcp-accept listener))  
  (display
    (match (port->string in)
        ["AT Z" "ELM327 v1.4b"]
        ["03"   "43018221970000"]
        [_      "NO DATA"]) 
    out)
  
  (close-input-port in)
  (close-output-port out)
  (loop))

(loop)
