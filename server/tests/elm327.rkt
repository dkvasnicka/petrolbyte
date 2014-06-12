#lang racket

(require rackunit
         "../elm327.rkt"
         srfi/41
         rnrs/io/ports-6)

;(test-equal? "test that the TCP/IP function gets a proper response"                
;             (send-and-receive "AT Z")
;             "ELM327 v1.4b")
;
;(test-equal? "test that reseting the device produces device ID"                
;             (reset-device)
;             "ELM327 v1.4b")
;
;(test-equal? "test that error codes are properly retrieved and normalized to the Pxxxx format"                
;             (retrieve-dtcs)
;             '("P0182" "P2197"))

(test-equal? "test that port is correctly consumed and parsed"
             (list->string
               (stream->list
                 (response-stream 
                   (open-string-input-port "AT Z\r\rELM327 v1.4b\r>") "AT Z")))
             "ELM327 v1.4b")

(test-equal? "test that DTC parsing works"                
             (parse-dtcs "018221970000")
             '("P0182" "P2197"))
