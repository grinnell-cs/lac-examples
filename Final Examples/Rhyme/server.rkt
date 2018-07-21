#lang racket
(require lac-camp/server)
(require lac-camp/text)

(define rhymes (list
                (list
                 "line"
                 "fine"
                 "dine"
                 "shine"
                 "pine")
                (list
                 "cat"
                 "bat"
                 "rat"
                 "gnat"
                 "hat")
                (list
                 "car"
                 "bar"
                 "rar"
                 )))

(define (noun)
  (one-of (string-append "a " (thing))
          (string-append "the " (thing))
          (person)))

(define (thing)
  (one-of "computer"
          "mouse"
          "counselor"
          "camper"
          "coder"))

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

(define (transitive-verb)
  (one-of "watched"
          "observed"
          "threw"
          "ignored"
          "taught"
          "lectured"
          "watched"))

(define (one-of-list list)
  (list-ref list (random (length list))))

(define (GenerateSentence rhymes)
  (define str (string-append (noun) " " (transitive-verb) " " (one-of "a" "the") " " (one-of-list rhymes) "."))
  (string-append (string-upcase (substring str 0 1)) (substring str 1)))

(define (GenerateRhyme request)
  (define ac (one-of-list rhymes))
  (define bd (one-of-list rhymes))
  `(*TOP*
    (html
     (head
      )
     (body
      (p ,(GenerateSentence ac))
      (p ,(GenerateSentence bd))
      (p ,(GenerateSentence ac))
      (p ,(GenerateSentence bd))
      ))))

(serve-procedure "" GenerateRhyme)
(start-server)
