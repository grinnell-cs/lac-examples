#lang racket
(require lac-camp)

;;; File:
;;;   page-analysis.rkt
;;; Summary:
;;;   A really boring page analysis tool intended as a starting point
;;;   for a final project.

; +---------------+---------------------------------------------------
; | Page analysis |
; +---------------+

; Produce an analysis of the page as an HTML element
(define (analyze page)
  `(div (@ (class "analysis"))
        (hr (@ (width "50%")))
        (h2 "Page analysis")
        (p "Number of paragraph tags: "
           ,(length (extract-by-tag 'p page)))
        (p "Number of images: "
           ,(length (extract-by-tag 'img page)))
        (p "Number of italicized or emphasized words: "
           ,(+ (length (extract-by-tag 'i page))
               (length (extract-by-tag 'em page))))
        ,(top-five-words page)))

; Extract the top-five-words and describe them
(define (top-five-words page)
  (describe-top-five-words
   (map car
        (sort-by-count-decreasing
         (tally-all
          (string->words
           (extract-text page)))))))

; Get all the words from a string
(define (string->words str)
  (regexp-match* #px"\\b[a-zA-Z]+\\b" str))

; Given a list of words, give the top five
(define (describe-top-five-words words)
  `(p "The five-most-frequent words are "
      (em ,(list-ref words 0))
      ", "
      (em ,(list-ref words 1))
      ", "
      (em ,(list-ref words 2))
      ", "
      (em ,(list-ref words 3))
      ", and "
      (em ,(list-ref words 4))))

; +-------------------+----------------------------------------------
; | Page transformers |
; +-------------------+

(define (transform page)
  (page-add-to-end page (analyze page)))

; +---------------+--------------------------------------------------
; | Page Handlers |
; +---------------+

; Generate the form
(define (form request)
  `(html
    (head (title "Enter a URL"))
    (body
     (form (@ (method "get")
              (action "process"))
           (p "URL: "
              (input (@ (name "url")
                        (type "text")
                        (size "128"))))))))

; Process a request
(define (process request)
  (if (string=? "" (get "url" request ""))
      (form request)
      (transform (fetch-page (get "url" request "")))))

; +--------------+---------------------------------------------------
; | Server setup |
; +--------------+

(serve-procedure "form" form)
(serve-procedure "process" process)
(serve-procedure "" process)
(start-server)