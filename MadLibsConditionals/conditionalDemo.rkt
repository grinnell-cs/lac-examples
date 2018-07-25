#lang racket
(require lac-camp)

;;; MadLibs & Conditional Procedures Demo Starter
;;; Adapted Code from Bella Koures & Hans Larsson
;;; Adapted by Halle Remash

(define (vampire-time noun)
  (if (string=? noun "Dracula")
      "night"
      "day"))

;;; Procedure:
;;;   story
;;; Parameters:
;;;   num, an integer
;;;   noun, a string
;;; Purpose:
;;;   Generate the HTML to a story using num and noun
;;; Produces:
;;;;  result, an xexp expression
;;; Preconditions:
;;;   noun is not the empty string
;;; Postconditions
;;;   [No additional]
(define (story noun)
  `(html
     (head
      (title "A story about " ,noun))
     (body
      (h1 ,noun "'s " ,(vampire-time noun))
      (p "Once upon a time there was a " ,noun ".")
      (p "The end."))))

; Code below this comment need not be edited

(define (story-interface userinput)
  (story (get "a-noun" userinput "Cheerio named Joe"))) 

(serve-procedure "write" story-interface)
   
(define (story-form userinput)
  `(html
     (head
      (title "MADLIBS"))
     (body
      (h1 "Help me write a story :(")
      (p "Fill in the stuff below cause I can't think of anything")
      (form (@ (method "get") 
               (action "write"))
            (p "Type a noun: "
                (input (@ (type "text")
                          (name "a-noun"))))
            (p (input (@ (type "submit")
                         (value "Write a story!"))))))))

(serve-procedure "form" story-form) 

(start-server)
