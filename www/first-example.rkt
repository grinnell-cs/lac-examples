#lang racket

;;; File:
;;;   first-example.rkt
;;; Summary:
;;;   Our first Racket Web Server example.  Serve a file.

; The following line lets us use the lac-camp utilities.
(require lac-camp)

; The following line configures the server.
(serve-file "index.html"
            "Desktop/lac/www/start.html")
(start-server)
