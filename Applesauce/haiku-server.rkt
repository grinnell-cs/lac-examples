#lang racket
(require lac-camp)

;;; File:
;;;   haiku-server.rkt
;;; Summary:
;;;   A simple Haiku server for the Language and Code Camp

; +---------------------+--------------------------------------------
; | Language Generation |
; +---------------------+

(define (seven-syllables)
  (one-of (string-append (two-syllable-word) " "
                         (three-syllable-word) " "
                         (two-syllable-word))
          (string-append (one-syllable-word) " "
                         (two-syllable-word) " "
                         (one-syllable-word) " "
                         (two-syllable-word) " "
                         (one-syllable-word))
          (string-append (three-syllable-word) " "
                         (one-syllable-word) " "
                         (three-syllable-word))))


(define (five-syllables)
  (one-of (string-append (two-syllable-word) " "
                         (one-syllable-word) " "
                         (two-syllable-word))
          (string-append (three-syllable-word) " "
                         (two-syllable-word))
          (string-append (one-syllable-word) " "
                         (three-syllable-word) " "
                         (one-syllable-word))))

(define (one-syllable-word)
  (one-of "fast"
          "blue"
          "hot"
	  "geese"
	  "mouse"
	  "mice"
	  "sleep"
	  "cold"
	  "twice"
	  "thrice"
	  "poem"))

(define (two-syllable-word)
  (one-of "happy"
          "silly"
          "yellow"
          "purple"
          "thinking"
          "dreaming"
          "sleeping"
          "vastness"
	  "apple"
	  "arrow"
	  "resides"
          "language"))

(define (three-syllable-word)
  (one-of "happiness"
          "analyze"
	  "expected"
	  "elephant"
          "forgetful"
          "amazing"
          "scavenger"))

; +----------+-------------------------------------------------------
; | Web Page |
; +----------+

(define (haiku-page request)
  `(html
    (head (title "Your daily haiku"))
    (body
     (h1 "Your daily haiku, presented by NAME and NAME")
     (p ,(capitalize (seven-syllables)))
     (p ,(capitalize (five-syllables)))
     (p ,(capitalize (seven-syllables))))))

(serve-procedure "" haiku-page)
(start-server)

