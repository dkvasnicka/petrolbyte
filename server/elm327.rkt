#lang racket

(require "utils.rkt")

(provide send-and-receive
         reset-device
         retrieve-dtcs
         parse-dtcs)

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

(define [retrieve-dtcs]
  (let [[response (send-and-receive "03")]]
   (if (equal? (substring response 0 2) "43")
     (parse-dtcs (substring response 2))
     (raise "Did not receive a proper DTC reply from the device!"))))

(define [parse-dtcs dtcstring]
  (let [[codebytes (partition-at 
                      (remove* '(#\space) (string->list dtcstring)) 4)]]
    (map (λ [c] (string-append "P" (list->string c))) 
         (filter-not (compose null? (curry remove* '(#\0))) codebytes))))
