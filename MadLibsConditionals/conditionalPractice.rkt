#lang racket
(require lac-camp)

;;; MadLibs & Conditional Procedures
;;; Adapted Code from Bella Koures & Hans Larsson
;;; Adapted by Halle Remash

;;; Procedure:
;;;   vowel?
;;; Parameters:
;;;   ch, a character
;;; Purpose:
;;;   Checks if ch is a vowel
;;; Produces:
;;;;  result, a boolean
;;; Preconditions:
;;;   [No additional]
;;; Postconditions
;;;   [No additional]
(define (vowel? str) (string-contains? "aeiou" (substring str 0 1)))

;;; Procedure:
;;;   indef-article
;;; Parameters:
;;;   str, a string
;;; Purpose:
;;;   Returns the 'correct' indefinite article with str appended to it.
;;; Produces:
;;;   result, a string
;;; Preconditions:
;;;   [No additional]
;;; Postconditions:
;;;   The 'correct' indefinite article in this case is the either
;;;   'a' or 'an'. Traditionally the indefinite article 'an' precedes
;;;   a string that begins with a vowel sound. Our procedure relies on
;;;   text, thus it appends a str to 'an' if str begins with a vowel. 
(define (indef-article str)
  (string-append "a " str))

;;; Procedure:
;;;   fill-empty 
;;; Parameters:
;;;   given, a string (assumed from userinput)
;;;   replace, a string
;;; Purpose:
;;;   Returns replace only if given is the empty string.
(define (fill-empty given replace)
  given)

;;; Procedure:
;;;   num-grammar
;;; Parameters:
;;;   num, an integer
;;;   singular, a string
;;;   plural, a string
;;; Purpose:
;;;   Returns num appended to a singular or plural noun
;;; Produces:
;;;;  result, a string
;;; Preconditions:
;;;   [No additional]
;;; Postconditions:
;;;   If num equals one, num is appended to singular
;;;   Else, num is appended to plural
(define (num-grammar num singular plural)
  (string-append (number->string num) " " singular))

; Code below this comment need not be edited

(define (story num noun)
  `(html
     (head
      (title "A story about " (indef-article noun)))
     (body
      (h1 ,(indef-article noun) "'s day")
      (p "Once upon a time there was " ,(indef-article noun) ".")
      (p "The " ,noun " ate " ,(num-grammar (string->number num) "banana" "bananas") ".")
      (p "The end."))))

(define (story-interface userinput)
  (story (fill-empty (get "an-amount" userinput 1) "1")
         (fill-empty (get "a-noun" userinput "Cheerio named Joe") "something")))  

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
            (p "Type a number: "
               (input (@ (type "number")
                         (name "an-amount"))))
            (p (input (@ (type "submit")
                         (value "Write a story!"))))))))

(serve-procedure "form" story-form)
