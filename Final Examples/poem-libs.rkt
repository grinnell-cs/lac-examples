#lang racket
(require lac-camp)

;;; File:
;;;   one-syllable.rkt
;;; Summary:
;;;   A slightly more complex MadLibs example for the final project

; Generate the HTML to a story
(define (madlibs author subject name month room-part noun1
                 adjective1 adjective2 adjective3
                 rhyme)
  `(html
    (head
     (title "The " ,(capitalize subject)))
    (body
     (h1 "The " ,(capitalize subject))
     (h2 "A poem by Edgar Allan Poe and " ,author)
     (p "Once upon a midnight " ,adjective1 ", while I pondered, weak and " ,adjective2 ","
        (br)
        "Over many a quaint and curious " ,noun1 " of forgotten lore—"
        (br)
        "While I nodded, nearly napping, suddenly there came a tapping,"
        (br)
        "As of some one gently rapping, rapping at my " ,room-part "."
        (br)
        "“’Tis some visitor,” I muttered, “tapping at my " ,room-part "—"
        (br)
        "Only this and nothing " ,rhyme ".”")
     (p "Ah, distinctly I remember it was in the " ,adjective3 " " ,month ";"
        (br)
        "And each separate dying ember wrought its ghost upon the floor."
        (br)
        "Eagerly I wished the morrow;—vainly I had sought to borrow"
        (br)
        "From my " ,noun1 " surcease of sorrow—sorrow for the lost " ,name "—"
        (br)
        "For the rare and radiant maiden whom the angels name " ,name "—"
        (br)
        "Nameless here for " ,rhyme ".")
     (p "And the silken, sad, uncertain rustling of each purple curtain"
        (br)
        "Thrilled me—filled me with fantastic terrors never felt before;"
        (br)
        "So that now, to still the beating of my heart, I stood repeating"
        (br)
        "“’Tis some visitor entreating entrance at my " ,room-part "—"
        (br)
        "Some late visitor entreating entrance at my " ,room-part ";—"
        (br)
        "This it is and nothing " ,rhyme ".”")
     (div)
     (p (a (@ (href ""))
           "Write another story")))))

; Generate the HTML to a madlibs with user input
(define (madlibs-interface request)
  (madlibs (get "author" request "Hans")
           (get "subject" request "Cheerio")
           (get "name" request "Someone")
           (get "month" request "Juneyouary")
           (get "room-part" request "window")
           (get "noun1" request "something")
           (get "adjective1" request "tired")
           (get "adjective2" request "fired")
           (get "adjective3" request "happy")
           (get "rhyme" request "noone")))

; Generate the HTML for a form
(define (madlibs-form request)
  `(html
    (head
     (title "MADLIBS"))
    (body
     (h1 "Help me write a story")
     (p "Fill in the stuff below cause I can't think of anything")
     (form
      ; This tells the Web browser that you have a form that needs user input
      (@ (method "get") ; This string must always be get
         (action "")) ; This string must be your story pathname
      ; Here's where you put all of the inputs.  The inputs have a standard form.
      (p "Your name "
         (input (@ (type "text")
                   (name "author"))))
      (p "Someone else's name "
         (input (@ (type "text")
                   (name "name"))))
      (p "Some word that rhymes with that name "
         (input (@ (type "text")
                   (name "rhyme"))))
      (p "A noun "
         (input (@ (type "text")
                   (name "subject"))))
      (p "Another noun "
         (input (@ (type "text")
                   (name "noun1"))))
      (p "An adjective "
         (input (@ (type "text")
                   (name "adjective1"))))
      (p "Another adjective "
         (input (@ (type "text")
                   (name "adjective2")))
         "it should rhyme with the previous one")
      (p "And another adjective "
         (input (@ (type "text")
                   (name "adjective3")))
         "this one need not rhyme")
      (p "Part of a room "
         (input (@ (type "text")
                   (name "room-part"))))
      (p "Your favorite month "
         (input (@ (type "text")
                   (name "month"))))
      ; The stuff below creates the button
      (p (input (@ (type "submit")
                   (value "Write a story!"))))))))

; How to handle both kinds of requests
(define (start-page request)
  (if (string=? (get "author" request "") "")
      (madlibs-form request)
      (madlibs-interface request)))

(serve-procedure "" start-page)

; Serve your story HTML
(serve-procedure "write" madlibs-interface) 

; Serve your form HTML
(serve-procedure "form" madlibs-form)

; I'll bet this starts the server (it does)
(start-server)
