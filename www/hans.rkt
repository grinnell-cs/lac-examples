#lang racket

;;; File:
;;;   hans.rkt
;;; Summary:
;;;   Another Racket server file example.  May or may not serve
;;;   a Web page with Hans

; The following line lets us use the lac-camp utilities.
(require lac-camp)

; This procedure builds a page about Hans.
(define (HansSite request)
  `(html
    (head
     (title "Hans!"))
    (body
     (h1 "This is about Hans!")
     (p (@ (class "first"))
        "Hans goes to Grinnell High School")
     (img (@ (src "hans.png")))
     (a (@ (href "http://www.google.com"))
        "This is a link to google")
     (p "Hans says that 2 + 3 = " ,(+ 2 3))
     )))

; The following lines configure and start the server.
(serve-procedure "Hans" HansSite)
(serve-file "hans.png" "Desktop/lac/www/hands.png")
(start-server)
