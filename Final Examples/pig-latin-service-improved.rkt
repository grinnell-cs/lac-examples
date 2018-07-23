#lang racket
(require lac-camp)

;;; File:
;;;   pig-latin-service-improved.rkt
;;; Summary:
;;;   An improved Pig-latin Web page processor

; +-----------------+------------------------------------------------
; | Word conversion |
; +-----------------+

;;; Procedure:
;;;   igpay-atlinay-elperhay
;;; Parameters:
;;;   word, a string
;;;   leading-consonants, a string
;;;   remainder, a string
;;; Purpose:
;;;   Does the real work of igpay-atinlay, after the string has been
;;;   divided into parts.
;;; Produces:
;;;   ordway, a string
(define (igpay-atinlay-elperhay word leading-consonants remainder)
  (if (string=? "" remainder)
      (string-append leading-consonants "ay")
      (if (string=? leading-consonants "")
          (string-append remainder "yay")
          (if (starts-with-capital? leading-consonants)
              (string-append (string-upcase (substring remainder 0 1))
	                     (substring remainder 1)
			     (string-downcase (substring leading-consonants 0 1))
			     (substring leading-consonants 1)
			     "ay")
	      (string-append remainder leading-consonants "ay")))))
	          

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
  (regexp-replace #rx"^([^AEIOUaeiou]*)(.*)" word igpay-atinlay-elperhay))

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
