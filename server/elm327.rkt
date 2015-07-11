#lang racket

(require file/sha1
         (only-in alexis/collection 
                  for/sequence 
                  sequence->string
                  drop))

(provide send-and-receive
         response-seq)

(define host "192.168.0.10")
(define port 35000)

(define (response-seq iport cmd)
  (drop (* 2 (string-length cmd))
        (for/sequence ([ch (in-input-port-chars iport)]
                       #:unless (char-whitespace? ch) 
                       #:break (char=? ch #\>))
                      ch)))

(define (send-and-receive cmd [h host] [p port])
  (let-values ([(i o) (tcp-connect h p)])
    (display (string-append cmd "\r") o)
    (flush-output o)
    (hex-string->bytes
      (sequence->string
        (response-seq i cmd)))))
