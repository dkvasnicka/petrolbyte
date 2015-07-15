#lang rackjure

(require web-server/servlet
         web-server/servlet-env
         web-server/templates
         racket/runtime-path
         "utils.rkt"
         "obd2.rkt")

(current-curly-dict hasheq)

(define app-routes
    (dispatch-case
        [("engine-rpm") (jsonize {'engineRpm (engine-rpm)})]))

(define-runtime-path static-files "../client")

(serve/servlet app-routes 
               #:command-line? #t
               #:launch-browser? #f
               #:servlet-regexp #rx""
               #:extra-files-paths (list static-files))
