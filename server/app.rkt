#lang racket

(require web-server/servlet
         web-server/servlet-env
         web-server/templates
         racket/runtime-path
         json
         "utils.rkt"
         "obd2.rkt")

(define app-routes
    (dispatch-case
        [("connect") (jsonize ($ 'ifaceId (reset-device)))]
        [("error-codes") (jsonize ($ 'dtcs (list 
                                    ($ 'code "P0016" 'description 
                                       "Crankshaft Position - Camshaft Position Correlation (Bank 1 Sensor A)")
                                    ($ 'code "P0029" 'description 
                                       "Exhaust Valve Control Solenoid Circuit Range/Performance Bank 2"))))]
        ))

(define-runtime-path static-files "../client")

(serve/servlet app-routes 
               #:command-line? #t
               #:launch-browser? #f
               #:servlet-regexp #rx""
               #:extra-files-paths (list static-files))
