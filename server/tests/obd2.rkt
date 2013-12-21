#lang racket

(require rackunit
         "../obd2.rkt")

(test-equal? "test that the TCP/IP function gets a proper response"                
             (send-and-receive "AT Z")
             "ELM327 v1.4b")

(test-equal? "test that reseting the device produces device ID"                
             (reset-device)
             "ELM327 v1.4b")
