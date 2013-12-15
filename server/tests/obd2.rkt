#lang racket

(require rackunit
         "../obd2.rkt")

(test-equal? "test that the TCP/IP function gets a proper response"                
             (substring 
               (send-and-receive "GET / HTTP/1.1\n\n" "google.com" 80) 0 8)
             "HTTP/1.1")
