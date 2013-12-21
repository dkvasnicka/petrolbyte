#lang racket

(provide send-and-receive
         reset-device)

(define host "localhost")
(define port 35000)

(define [send-and-receive cmd [h host] [p port]]
  (call-with-values (λ [] (tcp-connect h p))
                    (λ [i o]
                       (display cmd o)
                       (close-output-port o)
                       (port->string i))))

(define [reset-device]
  (send-and-receive "AT Z"))
