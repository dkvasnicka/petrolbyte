#lang racket

(require rackunit
         "../obd2.rkt")

(test-equal? "test that the TCP/IP function gets a proper response"                
             (send-and-receive "AT Z")
             "ELM327 v1.4b")

(test-equal? "test that reseting the device produces device ID"                
             (reset-device)
             "ELM327 v1.4b")

(test-equal? "test that error codes are properly retrieved and normalized to the Pxxxx format"                
             (retrieve-dtcs)
             '("P0182" "P2197"))

(test-equal? "test that DTC parsing works"                
             (parse-dtcs "018221970000")
             '("P0182" "P2197"))
