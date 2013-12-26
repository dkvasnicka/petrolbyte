#lang racket

(define listener (tcp-listen 35000))

(define [loop]
  (define-values (in out) (tcp-accept listener))  
  (let [[cmd (port->string in)]]
    (displayln cmd)
    (display
        (match cmd
            ["AT Z\r"   "ELM327 v1.4b"]
            ["03\r"     "43 01 82 21 97 00 00"]
            [_          "NO DATA"]) 
        out))
  
  (close-input-port in)
  (close-output-port out)
  (loop))

(loop)
