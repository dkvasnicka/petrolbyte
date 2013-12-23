#lang racket

(require web-server/servlet
         web-server/servlet-env
         web-server/templates
         racket/runtime-path
         json
         "utils.rkt"
         "elm327.rkt"
         "codes.rkt")

(define app-routes
    (dispatch-case
        [("connect") (jsonize ($ 'ifaceId (reset-device)))]
        [("error-codes") (jsonize ($ 'dtcs 
                                     (map (λ [c] ($ 'code c 'description
                                                     (hash-ref trouble-codes c))) 
                                          (retrieve-dtcs))))]
        ))

(define-runtime-path static-files "../client")

(serve/servlet app-routes 
               #:command-line? #t
               #:launch-browser? #f
               #:servlet-regexp #rx""
               #:extra-files-paths (list static-files))
