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
        [("connect") (jsonize ($ 'ifaceId (reset-device)))]))

(define-runtime-path static-files "../client")

(ws-serve
  #:port 8080
  (λ [wsc _]
     (let loop []
       (define m (ws-recv wsc))
       (printf "~a\n" m)
       (unless (eof-object? m)
         (ws-send! wsc m)
         (loop)))))

(serve/servlet app-routes 
               #:command-line? #t
               #:launch-browser? #f
               #:servlet-regexp #rx""
               #:extra-files-paths (list static-files))
