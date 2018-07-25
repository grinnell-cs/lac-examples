#lang racket
(require lac-camp/server)

;;; File:
;;;   MadLibsExample1
;;; Summary:
;;;   A simple MadLibs example

; Generate the HTML to a MadLibs story that needs a noun
(define (story noun)
  `(html
    (head
     (title "A story about " ,noun))
    (body
     (h1 "A " ,noun "'s day")
     (p "Once upon a time there was a " ,noun ".")
     (p "The end."))))

; One such story
(define (camper-story request)
  (story "camper"))

; Generate the HTML to a story with user input
(define (story-interface request)
  (story (get "a-noun" request "Cheerio named Joe"))) ; a-noun is referenced in story-form 

; Generate the HTML to a form
(define (story-form request)
  `(html
    (head
     (title "MADLIBS"))
    (body
     (h1 "Help me write a story :(")
     (p "Fill in the stuff below cause I can't think of anything")
     (form
      ; This tells the Web browser that you have a form that needs user input
      (@ (method "get") ; This string must always be get
         (action "write")) ; This string must be your story pathname
      ; Here's where you put all of the inputs.  The inputs have a standard form.
      (p "Type a noun: "
         (input (@ (type "text")
                   (name "a-noun")))) ; This string must match the name given in story-interface procedure
      ; The stuff below creates the button
      (p (input (@ (type "submit")
                   (value "Write a story!"))))))))

; Serve your story HTML
(serve-procedure "write" story-interface) ; write is now your story pathname

; Serve your form HTML
(serve-procedure "form" story-form) ; form is now your story-form pathname

; Serve Bella's special story
(serve-procedure "boring" camper-story)

;(serve-procedure "" story-form) An empty string as a pathname serves procedure to home page

; I'll bet this starts the server (it does)
(start-server)
