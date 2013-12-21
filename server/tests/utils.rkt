#lang racket

(require rackunit
         "../utils.rkt")

(test-equal? "test list partitioning"                
             (partition-at '(1 2 3 4 5) 2)
             '((1 2) (3 4) (5)))

(test-equal? "test empty list partitioning"                
             (partition-at '() 2)
             '())
