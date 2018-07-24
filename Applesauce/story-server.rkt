#lang racket
(require lac-camp)

;;; File:
;;;   story-server.rkt
;;; Summary:
;;;   A simple story server for the Language and Code Camp

; +---------------------+--------------------------------------------
; | Language Generation |
; +---------------------+

(define (paragraph)
  (one-of (stuff-with-subject (noun))
          (stuff-with-subject-and-object (noun) (noun))
          ""))


(define (stuff-with-subject subject)
  (one-of (string-append (sentence-with-subject subject) 
                         "  "
                         (one-of (stuff-with-subject subject)
                                 (stuff-with-subject subject)
                                 ""))
          (stuff-with-subject-and-object subject (noun))))

(define (stuff-with-subject-and-object subject object)
  (string-append (sentence-with-subject-and-object subject object) 
                 "  "
                 (one-of (stuff-with-subject subject)
                         (stuff-with-subject subject)
                         (stuff-with-subject object)
                         (stuff-with-subject-and-object subject object)
                         (stuff-with-subject-and-object subject object)
                         (stuff-with-subject-and-object object subject)
                         "")))

(define (sentence-with-subject subject)
  (string-append (capitalize subject)
                 " "
                 (intransitive-verb)
                 "."))

(define (sentence-with-subject-and-object subject object)
  (string-append (capitalize subject)
                 " "
                 (transitive-verb)
                 " "
                 object
                 "."))

(define (noun)
  (one-of (string-append "a " (thing))
          (string-append "the " (thing))
          (person)
          (place)))

(define (thing)
  (one-of "computer"
          "mouse"
          "counselor"
          "camper"
          "coder"
          "elephant"
          "giant"
          "worm"
          "bicycle"))

(define (person)
  (one-of "Halle"
          "Bella"
          "Syamala"
          "Yesheng"
          "James"
          "Stella"
          "Vanessa"
          "Nolan"
          "Sam"
          "Sarah"))

(define (place)
  (one-of "Grinnell College"
          "Iowa"
          "The Noyce Science Center"
          "Noyce 3813"
          "America"))

(define (transitive-verb)
  (one-of "watched"
          "observed"
          "threw"
          "ignored"
          "taught"
          "aprehended"
          "ate"
          "investigated"
          "saw"
          "conquered"
          "illustrated"))
          
(define (intransitive-verb)
  (one-of "cogitated"
          "slept"
          "lectured"
          "watched"
          "scavenged"
          "ate"
          "napped"
          "coded"
          "typed"
          "biked"
          "skateboarded"))


; +----------+-------------------------------------------------------
; | Web Page |
; +----------+

(define (story-page request)
  `(html
    (head (title "A pointless story"))
    (body
     (h1 "A pointless story")
     (p ,(paragraph))
     (p ,(paragraph))
     (p ,(paragraph))
     (p "The end."))))

(serve-procedure "" story-page)
(start-server)

