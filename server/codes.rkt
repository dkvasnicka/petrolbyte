#lang racket

(require rnrs/io/ports-6)

(provide trouble-codes)

(define trouble-codes
  (for/hash ([l (in-lines (open-file-input-port "codes.csv"))])
            (let ([data (string-split l "," #:trim? #f)])
              (values (car data) (string-join (cdr data) ",")))))
