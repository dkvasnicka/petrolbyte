#lang racket

(require web-server/servlet
         web-server/servlet-env
         web-server/templates
         racket/runtime-path
         json
         "utils.rkt")

(define app-routes
    (dispatch-case
        [("data") (jsonize ($ 'x ($ 'y '(4 5 6))))]))

(define-runtime-path static-files "../client")

(serve/servlet app-routes 
               #:command-line? #t
               #:launch-browser? #f
               #:servlet-regexp #rx""
               #:extra-files-paths (list static-files))
