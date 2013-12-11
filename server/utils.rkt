#lang racket

(require web-server/servlet
         web-server/servlet-env
         json)

(provide jsonize
         $)

(define [jsonize jsondata]
  (λ [req] 
     (response/full
        200 #"OK"
        (current-seconds) 
        #"application/json"
        null
        (list (jsexpr->bytes jsondata)))))

(define $ hash)
