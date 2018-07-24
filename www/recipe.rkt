#lang racket
(require lac-camp/server)

(define (CheeseBread stuff)
  `(*TOP*
     (html
       (head
        )
       (body
        (h1 "CheeseBread")
        (h3 "Ingredients")
        (ul ;ul stands for unordered list
         (li "Cheese"); li stands for list item
         (li "Bread")
         (li "Spices"))
        (h3 "Directions")
        (ol
         (li "Preaheat the oven to 400° and while it is warming up put the cheese on the bread.")
         (li "You should probably do something with those spices so put them on top of the bread too.")
         (li "Ok put that all in the oven until the cheese melts.")
         (li "Once the cheese is melted onto the bread take it out and eat it whenever you want.")
        )))))

;(serve-procedure "CheeseBread" CheeseBread)
(start-server)