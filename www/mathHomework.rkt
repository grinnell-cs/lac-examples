#lang racket
(define (MathHomework stuff)
  `(*TOP*
     (html
       (head
        )
       (body
        (h1 "My Math Homework")
        (h3 "Problems")
        (ol ;ol stands for ordered list
         (li "27 + 18"); li stands for list item
         (li "45 * 2")
         (li "90 / 5"))
        (h3 "Solutions")
        (ol
         (li "27 + 18 = " ,(+ 27 18)) ;the coma tells racket to do the math
         (li "45 * 2 = " ,(* 45 2))
         (li "90 / 5 = " ,(/ 90 5))
        )))))



;(serve-procedure "MathHomework" MathHomework)
(start-server)