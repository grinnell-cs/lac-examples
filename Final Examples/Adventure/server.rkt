#lang racket
(require lac-camp/server)
(require lac-camp/text)
(require math/base)
(require html-parsing)

(define file-path "Desktop/lac-examples/Final Examples/Adventure/")

(define (randomName)
  (one-of "Jon" "Dave" "Sam" "Mark" "Luke" "Mary" "Beth" "Ana" "Jen"))

(define (randomMonster)
  (list (one-of "Bosh" "Grob" "Log") (one-of "brick.jpg" "grass.jpg" "stone.png")))

(define (randomAdjective)
  (one-of "Green" "Blue" "Shiny" "Hard" "Sharp" "Solid" "Enchanted" "Pointy" "Magic"))

(define (randomMaterial)
  (one-of "Stone" "Wood" "Diamond" "Metal" "Iron" "Steel" "Bronze" "Copper" "Silver"))

(define (randomWeapon)
  (one-of "Dagger" "Knife" "Staff" "Sword" "Wand" "Hammer" "Axe" "Club" "Mace"))

(define (getDefaults request)
  (list (list "name" (get "name" request "Adventurer"))
        (list "class" (get "class" request "snowman.png"))
        (list "level" (get "level" request "1"))
        (list "health" (get "health" request "100"))
        (list "money" (get "money" request "0"))
        (list "tools" (get "tools" request "Hand (1)"))))

(define (Include values link text)
  (define inputs (map (lambda (value)
                        (string-append "<input type='hidden' name='" (car value) "' value='" (cadr value) "'>"))
                      values))
  `(*TOP*
    (form (@ (method "post")
             (action ,link))
          ,(html->xexp (string-append "<div>" (apply string-append inputs) "</div>"))
          (input (@ (type "submit") (value ,text))))))

(define (IncludeDefault request link text)
  (Include (getDefaults request) link text))

(define (IncludeExtra request link text extraValues)
  (define keys (map (lambda (value) (car value)) extraValues))
  (define base (filter (lambda (value) (not (member (car value) keys))) (getDefaults request)))
  (Include (append base extraValues) link text))

(define (Intro request)
  `(*TOP*
    (html
     (head
      )
     (body
      (form (@ (method "post")
               (action "home"))
            (h2 "Enter your name!")
            (input (@ (type "text")
                      (name "name")))
            (br)
            (select (@ (name "class"))
                    (option (@ (value "snowman.png")) "Snowman")
                    (option (@ (value "wizard.jpg")) "Wizard")
                    (option (@ (value "ant.jpg")) "Ant")
                    (option (@ (value "spy.png")) "Spy"))
            (br)
            (input (@ (type "submit")
                      (value "Start Game!"))))
      ))))

(define (Home request)
  `(*TOP*
    (html
     (head
      )
     (body
      (h1 ,(get "name" request "Adventurer"))
      (img (@ (src ,(get "class" request "snowman.png")) (style "width:10%;display:inline")))
      (p (strong "Level: ") ,(get "level" request "1"))
      (p (strong "Money: ") ,(get "money" request "0"))
      (p (strong "Health: ") ,(get "health" request "100"))
      (p (strong "Tools: ") ,(get "tools" request "Hand (1)"))
      ,(IncludeDefault request "shop" "Buy Something!")
      ,(IncludeDefault request "fight" "Fight Something!")
      ,(IncludeDefault request "train" "Train!")
      ,(IncludeExtra request "home" "Free Money!" (list (list "money" "1000")))
      ,(IncludeDefault request "inn" "Go to the Inn (restore health)!")
      ))))

(define (Inn request)
  (define price (number->string (random 1 100)))
  (define health (number->string (* (string->number (get "level" request "1")) 100)))
  `(*TOP*
    (html
     (head
      )
     (body
      (h1 ,(randomName)"'s Inn")
      (p "For " (strong "$",price) " you can heal back to full (" (strong ,health) ") health")
      ,(IncludeExtra request "heal" "Heal" (list (list "price" price) (list "max" health)))
      ,(IncludeDefault request "inn" "Try Another Inn!")
      ,(IncludeDefault request "home" "Return Home")
      ))))

(define (Heal request)
  (define health (get "max" request "100"))
  (define price (string->number (get "price" request "0")))
  (define money (string->number (get "money" request "0")))
  (set! money (- money price))
  (set! money (number->string (max money 0)))
  `(*TOP*
    (html
     (head
      )
     (body
      (p "The innkeeper healed you to " ,health " health")
      ,(IncludeExtra request "home" "Return Home" (list (list "health" health) (list "money" money)))
      ))))

(define (shopItem item request)
  (define itemString (string-append (first item) " " (second item) " "
                                    (third item) " (" (number->string (fourth item)) ")"))
  (define items (get "tools" request "Hand (1)"))
  (define money (string->number (get "money" request "0")))
  (if (> money (fifth item))
      (set! items (string-append items ", " itemString))
      (set! money (+ money (fifth item))))
  (set! money (number->string (- money (fifth item))))
  `(li ,(car item) " " ,(cadr item) " " ,(caddr item)
       (ul
        (li "Damage Dealt: " (strong ,(number->string (cadddr item))) " per level")
        (li "Price: " (strong "$" ,(number->string (fifth item))))
        ,(IncludeExtra request "home" "Purchase! (and return home)"
                       (list (list "tools" items) (list "money" money))))))

(define (Shop request)
  (define level (string->number (get "level" request "1"))) 
  (define items (map (lambda (x) (list (randomAdjective) (randomMaterial) (randomWeapon) (random 1 10) (random 1 500))) (range 5)))
  `(*TOP*
    (html
     (head
      )
     (body
      (h1 ,(randomName)"'s Shop")
      (ul
       ,(shopItem (first items) request)
       ,(shopItem (second items) request)
       ,(shopItem (third items) request)
       ,(shopItem (fourth items) request)
       ,(shopItem (fifth items) request))
       )
      ,(IncludeDefault request "shop" "Try Another Shop")
      ,(IncludeDefault request "home" "Return Home")
      )))

(define (Train request)
  (define level (string->number (get "level" request "1")))
  (define increase (number->string (exact-ceiling (* level 1.1))))
  (define price (* level 10))
  (define money (string->number (get "money" request 0)))
  (define resultLevel (number->string level))
  (if (>= money price)
      (set! resultLevel increase)
      (set! money (+ money price)))
  (define resultMoney (number->string (- money price)))
  `(*TOP*
    (html
     (head
      )
     (body
      (h1 ,(randomName)"'s Dojo")
      (p "For $" ,(number->string price) " you can increase your level to " ,increase)
      ,(IncludeExtra request "train" "Train" (list (list "level" resultLevel) (list "money" resultMoney)))
      ,(IncludeDefault request "home" "Return Home")
      ))))

(define (Fight request)
  (define monster (randomMonster))
  (define level (random (exact-floor (string->number (get "level" request "1")))))
  (define hp (number->string (* level 50)))
  (define mlvl (number->string level))
  `(*TOP*
    (html
     (head
      )
     (body
      (img (@ (style "width:10%;display:inline") (src ,(cadr monster))))
      (p "You encountered " ,(car monster) ": Level ",(number->string level))
      ,(IncludeExtra request "battle" "Fight" (list (list "mname" (car monster)) (list "mimg" (cadr monster)) (list "mhp" hp) (list "mlvl" mlvl)))
      ,(IncludeDefault request "home" "Run Away")
      ))))

(define (getDamage tools)
  (sum (map string->number (string-split (regexp-replace* "[^(0-9]" tools "") "("))))

(define (lose request)
  (define money (string->number (get "money" request "0")))
  (set! money (number->string (exact-round (/ money 2))))
  (define level (string->number (get "level" request "1")))
  (define health (number->string (* level 100)))
  `(*TOP*
    (html
     (head
      )
     (body
      (p "You fainted, fortunately, the innkeeper agreed to heal you for half your money")
      ,(IncludeExtra request "home" "Home" (list (list "money" money) (list "health" health)))))))

(define (win request)
  (define name (get "mname" request "Borg"))
  (define mlvl (string->number (get "mlvl" request "0")))
  (define money (string->number (get "money" request "0")))
  (define newmoney (number->string (exact-round (+ money (* mlvl 10)))))
  (define level (string->number (get "level" request "1")))
  (define newlevel (number->string (+ level (+ 1 (/ mlvl 5)))))
  `(*TOP*
    (html
     (head
      )
     (body
      (p "You defeated " (strong ,name) "! This has earned you:")
      (ul
       (li "$" ,(number->string (* mlvl 10)))
       (li ,(number->string (+ 1 (/ mlvl 5))) " levels"))
      ,(IncludeExtra request "home" "Home" (list (list "money" newmoney) (list "level" newlevel)))))))

(define (Battle request)
  (define name (get "mname" request "Borg"))
  (define img (get "mimg" request "grass.jpg"))
  (define clvl (string->number (get "level" request "1")))
  (define hp (- (string->number (get "mhp" request "0")) (* (getDamage (get "tools" request "Hand (1)")) clvl)))
  (define lvl (get "mlvl" request "0"))
  (define health (- (string->number (get "health" request "100")) (* (string->number lvl) (random 1 5))))
  (define newhealth (number->string health))
  (define mhp (number->string hp))
  (if (< health 0)
      (lose request)
      (if (< hp 0)
          (win request)
          `(*TOP*
            (html
             (head
              )
             (body
              (img (@ (style "width:10%;display:inline") (src ,img)))
              (strong ,name ": Level ",lvl)
              (p ,name "'s Health: " ,mhp)
              (p "Your Health: " ,newhealth)
              ,(IncludeExtra request "battle" "Fight" (list (list "mname" name) (list "mimg" img) (list "mhp" mhp) (list "mlvl" lvl) (list "health" newhealth)))
              ,(IncludeExtra request "home" "Run Away" (list (list "health" newhealth)))
              ))))))

(serve-procedure "" Intro)
(serve-procedure "home" Home)
(serve-procedure "inn" Inn)
(serve-procedure "heal" Heal)
(serve-procedure "shop" Shop)
(serve-procedure "train" Train)
(serve-procedure "fight" Fight)
(serve-procedure "battle" Battle)
(serve-file "ant.jpg" (string-append file-path "ant.jpg"))
(serve-file "snowman.png" (string-append file-path "snowman.png"))
(serve-file "spy.png" (string-append file-path "spy.png"))
(serve-file "wizard.jpg" (string-append file-path "wizard.jpg"))
(serve-file "brick.jpg" (string-append file-path "brick.jpg"))
(serve-file "stone.png" (string-append file-path "stone.png"))
(serve-file "grass.jpg" (string-append file-path "grass.jpg"))
(start-server)
