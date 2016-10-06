#lang racket

(require rackunit
         "../elm327.rkt"
         (only-in data/collection sequence->string)
         rnrs/io/ports-6)

(test-equal? "test that port is correctly consumed and parsed"
             (sequence->string
               (response-seq 
                 (open-string-input-port "010C\r\r41 0C 18 FA\r>blablabla")
                 "010C"))
             "18FA")
