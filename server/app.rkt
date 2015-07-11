#lang racket

(require web-server/servlet
         web-server/servlet-env
         web-server/templates
         racket/runtime-path
         net/rfc6455
         json
         "utils.rkt"
         "elm327.rkt")

(define app-routes
    (dispatch-case
        [("connect") (jsonize (hash 'ifaceId 0))]))

(define-runtime-path static-files "../client")

(serve/servlet app-routes 
               #:command-line? #t
               #:launch-browser? #f
               #:servlet-regexp #rx""
               #:extra-files-paths (list static-files))
