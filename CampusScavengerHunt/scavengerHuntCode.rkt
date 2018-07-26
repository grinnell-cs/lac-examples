#lang racket
(require lac-camp)

;Natatorium Stairs

(define (home request)
  ;DIRECTIONS: FILL IN THE BLANKS BELOW WITH THE FOLLOWING PROCEDURES
  
  ; numbersToString
  ;  This function takes a string of numbers separated by ","s and converts them
  ;  to a-z and A-Z characters.
  
  ;  removeEveryOther
  ;  This function takes a string and removes every other character

  ; strReverse 
  ;  This function reverses a string.

  ; caesarShift
  ;  This function encrypts/decrypts a string of letters by shifting the characters 
  ;  by a certain number of letters.


  
  (define proc1 ___________)
  (define proc2 ___________)
  (define proc3 ___________)
  (define proc4 ___________)

  ; DO NOT EDIT ANY CODE BELOW THIS----------------------------------------------------
  `(html
    (head (title "Scavenger Hunt Code"))
    (body (@ (style "background:linear-gradient(to right, red,orange,yellow,green,blue,indigo,violet)"))
          (center (h1 (@ (style "color:white;font-size:10em"))
                      ,(proc4 (proc3 (proc2 (proc1 startText))))))
          )
    )
  )



;Faulconer Gallery

;(define startText "33,107,102,107,103,107,110,107,101,107,116,107,97,107,98,107,80")
(define startText (apply string (file->chars "startText.txt")))
(set! startText (substring startText 0 (- (string-length startText) 1)))

;Burling Library
(define (shiftAlphabetical char)
  (define shift 0)
  (define intRep (char->integer char))
  (if (>= intRep 97)
      (set! shift 97)
      (set! shift 65))
  (integer->char (+ (modulo (- (+ intRep 13) shift) 26) shift)
                 )
  )

(define (shiftCharacter char)
  (if (char-alphabetic? char)
      (shiftAlphabetical char)
      char)
  )

(define (caesarShift str)
  (list->string (map shiftCharacter (string->list str)
                     )
                )
  )

;South Campus Ceramics Studio
(define (strReverse str)
  (list->string (reverse (string->list str)))
  )

;JRC 2nd
(define (removeEveryOther str)
  (regexp-replace* #rx"([^ ])[^ ]" str "\\1")
  )

;Bear Gym Lobby
(define (numbersToString str)
  (apply string (map integer->char
                     (map string->number
                          (string-split str ",")
                          )
                     )
         )
  )



(serve-procedure "" home)
(start-server)