#lang racket
(require lac-camp)

;;; File:
;;;   pig-latin-service-simple.rkt
;;; Summary:
;;;   A simple Pig-latin Web page processor

; +-----------------+------------------------------------------------
; | Word conversion |
; +-----------------+

;;; Procedure:
;;;   igpay-atinlay
;;; Parameters:
;;;   word, a string
;;; Purpose:
;;;   Convert word into Pig Latin, or some reasonable facsimile thereof.
;;; Produces:
;;;   ordway, a string
;;; Preconditions:
;;;   Word contains only letters.
;;; Postconditions:
;;;   ordway is the Pig-Latin equivalent of word.
(define (igpay-atinlay word)
  (if (starts-with-vowel? word)
      (string-append word "yay")
      (if (starts-with-capital? word)
          (if (= (string-length word) 1)
              (string-append word "ay")
              (string-append (string-upcase (substring word 1 2))
                             (substring word 2)
                             (string-downcase (substring word 0 1))
                             "ay"))
          (string-append (substring word 1)
                         (substring word 0 1)
                         "ay"))))

; +-------------------+----------------------------------------------
; | Page transformers |
; +-------------------+

(define (transform page)
  (page-replace-text page #rx"[a-zA-Z]+" igpay-atinlay))

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
