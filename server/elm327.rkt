#lang racket

(require srfi/41)

(provide send-and-receive
         response-stream
         reset-device)

(define host "localhost")
(define port 35000)

(define (char-is-not c) (compose not (curry char=? c)))

(define (response-stream iport original-cmd)
  (let ([response-stream (stream-take-while (char-is-not #\>) 
                                            (port->stream iport))])
    (stream-filter (char-is-not #\return)
      (stream-drop (string-length original-cmd) response-stream))))

(define (send-and-receive cmd [h host] [p port])
  (call-with-values (λ [] (tcp-connect h p))
                    (λ [i o]
                       (display (string-append cmd "\r") o)
                       (flush-output o)
                       (list->string 
                         (stream->list 
                           (response-stream i cmd))))))

(define (reset-device)
  (send-and-receive "AT Z"))
