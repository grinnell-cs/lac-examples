#lang racket
(require lac-camp/server)

;;; File:
;;;   MadLibsExample2
;;; Summary:
;;;   A slightly more cmplex MadLibs example

; Generate the HTML to a story
(define (story person color adjective)
  `(html
    (head
     (title "A story about " ,person))
    (body
     (h1 ,person "'s day")
     (p ,person " looked up at the sky.  "
        ,person " noticed that the sky was " , color ".  "
        "That made " ,person " feel " ,adjective ".")
     (p "The end."))))

; An example
(define (hans-story request)
  (story "Hans" "purple" "tall"))

; Generate the HTML to a story with user input
(define (story-interface request)
  (story (get "person" request "Cheerio named Joe")
         (get "color" request "a somewhat light tan")
         (get "adjective" request "confused")))

; Generate the HTML for a form
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
      (p "Adjective: "
         (input (@ (type "text")
                   (name "adjective"))))
      (p "Color: "
         (input (@ (type "text")
                   (name "color"))))
      (p "Person: "
         (input (@ (type "text")
                   (name "person"))))
      ; The stuff below creates the button
      (p (input (@ (type "submit")
                   (value "Write a story!"))))))))


; Serve your story HTML
(serve-procedure "write" story-interface) 

; Serve your form HTML
(serve-procedure "form" story-form)

; Serve a custom story HTML
(serve-procedure "hans" hans-story)

; I'll bet this starts the server (it does)
(start-server)
