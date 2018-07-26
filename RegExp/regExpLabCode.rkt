#lang racket

; 1.1 A
; (regexp-match* #px"a" "I really don't really know")

; 1.1 B
; (regexp-match* #px"\\w" "11 is the best number")

; 1.1 C
; (regexp-match* #px"[a-z]+" "Sam and Sarah sometimes agree")

; 1.2 A
; (regexp-match* #px"[a-z]+" totally-txt)

; 2.1 A
; (regexp-replace* #px"Millenials" "The Millenials are great" "Snake People")

; 2.1 B
; (regexp-replace* #px"fish" "Halibut is a type of fish" string-upcase)

; 2.2 B
; (regexp-replace* #px"You|you" "You are the best you can be" "u")

; 2.2 D
; (regexp-replace* #px"(?i:laughing out loud|laugh out loud)" "I’m laughing out loud" "lol")

; 2.2 F
; (regexp-replace* #px"happy" "Because I'm happy clap along if you feel like a room without a roof!" "happy!")
