#lang racket

(require file/sha1
         (only-in alexis/collection 
                  for/sequence 
                  sequence->string
                  drop))

(provide send-and-receive
         response-seq
         connect!)

(define host "192.168.0.10")
(define port 35000)
(define-values (I O) (values (current-input-port) 
                             (current-output-port)))

(define (connect! [h host] [p port])
  (set!-values (I O) (tcp-connect h p)))

(define (response-seq iport cmd)
  (drop (* 2 (string-length cmd))
        (for/sequence ([ch (in-input-port-chars iport)]
                       #:unless (char-whitespace? ch) 
                       #:break (char=? ch #\>))
                      ch)))

(define (send-and-receive cmd)
  (display (string-append cmd "\r") O)
  (flush-output O)
  (hex-string->bytes
    (sequence->string
      (response-seq I cmd))))
