#lang racket

(require web-server/servlet
         web-server/servlet-env
         json)

(provide jsonize
         $
         partition-at)

(define [jsonize jsondata]
  (λ [req] 
     (response/full
        200 #"OK"
        (current-seconds) 
        #"application/json"
        null
        (list (jsexpr->bytes jsondata)))))

(define $ hash)

(define [partition-at lst size]
  (if (empty? lst)
      null
      (((λ [f] (f f))
        (λ [part-at]
          (λ [lst out]
             (if (<= (length lst) size)
                 (append out (list lst))
                 (let-values [[[x xs] (split-at lst size)]]
                   ((part-at part-at)
                        xs (append out (list x))))))))
       
       lst null)))
