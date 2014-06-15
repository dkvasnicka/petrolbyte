#lang racket

(require "utils.rkt"
         srfi/41)

(provide send-and-receive
         reset-device
         retrieve-dtcs
         parse-dtcs
         response-stream)

(define host "localhost")
(define port 35000)

(define [char-is-not c] (compose not (curry char=? c)))

(define [response-stream iport original-cmd]
  (let [[response-stream (stream-take-while (char-is-not #\>) 
                                            (port->stream iport))]]
    (stream-filter (char-is-not #\return)
      (stream-drop (string-length original-cmd) response-stream))))

(define [send-and-receive cmd [h host] [p port]]
  (call-with-values (λ [] (tcp-connect h p))
                    (λ [i o]
                       (display (string-append cmd "\r") o)
                       (flush-output o)
                       (list->string 
                         (stream->list 
                           (response-stream i cmd))))))

(define [reset-device]
  (send-and-receive "AT Z"))

(define [retrieve-dtcs]
  (let [[response (send-and-receive "03")]]
   (if (equal? (substring response 0 2) "43")
     (parse-dtcs (substring response 2))
     (error "Did not receive a proper DTC reply from the device!"))))

(define [parse-dtcs dtcstring]
  (let [[codebytes (partition-at 
                      (remove* '(#\space) (string->list dtcstring)) 4)]]
    (map (λ [c] (string-append "P" (list->string c))) 
         (filter-not (compose null? (curry remove* '(#\0))) codebytes))))
