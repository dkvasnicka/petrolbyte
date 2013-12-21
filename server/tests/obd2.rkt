#lang racket

(require rackunit
         "../obd2.rkt")

(test-equal? "test that the TCP/IP function gets a proper response"                
             (send-and-receive "AT Z" "localhost")
             "ELM327 v1.4b")
