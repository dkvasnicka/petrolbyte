#lang racket

(provide send-and-receive)

(define host "192.168.0.10")
(define port 35000)

(define [send-and-receive cmd [h host] [p port]]
  (call-with-values (λ [] (tcp-connect h p))
                    (λ [i o]
                       (display cmd o)
                       (close-output-port o)
                       (port->string i))))

