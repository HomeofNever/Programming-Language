;; Contract: myfind : id -> boolean
;; Purpose: find corresponded boolean value of given id from variable list
;; Example: (myfind '((a #t)) 'a) should produce #t
;; Definition:
(define (myfind myvars id)
  (if
   (null? myvars)
   #f
   (if
    (equal? (caar myvars) id)
    (cadar myvars)
    (myfind (cdr myvars) id)
   )
 )
)

;; Contract: mystart : expr -> boolean
;; Purpose: evaluate given expression
;; Example: (mystart '(prog true)) should produce #t
;; Definition:
(define (mystart myvars expr)
  ( cond
     ((equal? expr 'true) #t)
     ((equal? expr 'false) #f)
     ((symbol? expr) (myfind myvars expr))
     ((equal? (car expr) 'prog) (mystart myvars (cadr expr)))
     ((equal? (car expr) 'myignore) #f)
     ((equal? (car expr) 'myand) (and
                                  (mystart myvars (cadr expr))
                                  (mystart myvars (caddr expr))
                                 ))
     ((equal? (car expr) 'myor) (or
                                  (mystart myvars (cadr expr))
                                  (mystart myvars (caddr expr))
                                 ))
     ((equal? (car expr) 'mynot) (not (mystart myvars (cadr expr))))
     ((equal? (car expr) 'mylet) (mystart
                                   (cons
                                    (cons (cadr expr)
                                          (cons
                                           (mystart myvars (caddr expr))
                                           '()
                                          )
                                    )
                                    myvars
                                   )
                                   (cadddr expr)
                                 ))
     (else #f)
  )
)

;; Contract: mystart? : expr -> boolean
;; Purpose: evaluate a list of expressions
;; Example: (myinterpreter '((prog true) (prog (myand true false))) should produce #t
;; Definition:
(define (myinterpreter x)
  (if (null? x)
      '()
       (cons (mystart '() (car x)) (myinterpreter (cdr x)))
  )
)

;; Test cases
#|
(myinterpreter '(
    (prog true) ; #t
    (prog (myor (myand true (myignore (myor true false))) (myand true false))) ; #f
    (prog (mylet z (myor false true) (myand z true))) ; #t
    (prog (mylet a true (myor (mylet b (myand true false) (myor false b)) (myand false a)))) ; #f
    (prog (mylet x true (myor (mylet x (myand true false) (myand true x)) (myand true x)))) ; #t
    (prog (mylet b true (mylet b true b))) ; #t
))
|#