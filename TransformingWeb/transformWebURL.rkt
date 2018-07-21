#lang racket
(require lac-camp)

(define (form request)
  `(html
    (head (title "Enter a URL"))
    (body
     (form (@ (method "get")
              (action "process"))
           (p "URL: "
              (input (@ (name "url")
                        (type "text"))))))))

(define (process request)
  ; request url again if user enters empty string
  (if (string=? "" (get "url" request ""))
      (form request)
      ; Change the next line below to transform web page
      ; example:
      ;(page-delete-elements (fetch-page (get "url" request "")) 'p))
      (fetch-page (get "url" request ""))
      ))

;;; Serving web pages
; Front page
(serve-procedure "form" form)
(serve-procedure "process" process)
(serve-procedure "" process)
(start-server)