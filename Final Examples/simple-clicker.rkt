#lang racket
(require lac-camp)

;;; File:
;;;   simple-clicker.rkt
;;; Summary:
;;;   A simple clicker, intended as a demo for final projects

(define (clicker-page num)
  `(html 
    (head (title ,(number->string num)))
    (body
     (h1 ,num)
     (form (@ (action "clicker")
              (method "get"))
           (input (@ (type "hidden")
                     (name "clicker")
                     (value ,(number->string (+ num 1)))))
           (input (@ (type "submit")
                     (value "More"))))
          (form (@ (action "clicker")
              (method "get"))
           (input (@ (type "hidden")
                     (name "clicker")
                     (value ,(number->string (- num 1)))))
           (input (@ (type "submit")
                     (value "Less"))))

     )))

(define (clicker-interface request)
  (clicker-page (string->number (get "clicker" request "0"))))

(serve-procedure "clicker" clicker-interface)
(start-server)

