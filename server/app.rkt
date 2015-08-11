#lang rackjure

(require web-server/servlet
         web-server/servlet-env
         web-server/templates
         racket/runtime-path
         "utils.rkt"
         "obd2.rkt")

(current-curly-dict hasheq)
(connect!)

(define (read-data)
  (let ([spd (speed)]
        [rpm (engine-rpm)]) 
    (jsonize 
      {'engineRpm (~r rpm #:precision 0 #:min-width 10 #:pad-string "&nbsp;")
       'speed     (~r spd #:min-width 10 #:pad-string "&nbsp;")
       'fuelCons  (~r (fuel-cons spd rpm) #:precision 1 #:min-width 10 #:pad-string "&nbsp;")})))

(define app-routes
    (dispatch-case
         [("data") (read-data)]))

(define-runtime-path static-files "../client")

(serve/servlet app-routes 
               #:command-line? #t
               #:launch-browser? #f
               #:servlet-regexp #rx""
               #:extra-files-paths (list static-files))
