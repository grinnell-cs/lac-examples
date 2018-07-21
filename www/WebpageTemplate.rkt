#lang racket
(require lac-camp)

(define (EmptySite stuff)
  `(*TOP*
     (html
       (head
        )
       (body
        ))))

(serve-procedure "EmptySite" EmptySite)
(start-server)