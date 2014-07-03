#lang racket

(require rnrs/io/ports-6)

(provide trouble-codes)

(define trouble-codes
  (make-hash
    (map (curryr string-split ",") 
         (port->lines (open-file-input-port "codes.csv")))))
