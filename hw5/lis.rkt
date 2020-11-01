;; Contract: not-decrease? (list a) -> bool
;; Purpose: if a list is non-decreasing list
;; Example: (not-decrease? '(1 2 3 4 3 4 5)) should produce #f
;; Definition:
(define (firstNonDecreasing ls)
  (cond ((null? ls) #f)
        ((not-decrease? (car ls)) (car ls))
        (else (firstNonDecreasing (cdr ls)))
        )
  )
        
;; Contract: subListRecursive (list originL) * number * number -> bool * (list)
;; Purpose: recursively extend the list from given index to request length
;; Example: (subListRecursive '(1 2 3) 0 1) yields '(1)
;; Definition:
(define (subListRecursive originL index requestLength)
  (if (> requestLength 0)
      (if (< index (length originL))
           (let*
              (
               (x (subListRecursive originL (+ index 1) (- requestLength 1)))
               (y (subListRecursive originL (+ index 1) requestLength))
              )
             (letrec
                 (
                  (currentSym (lambda () (list-ref originL index)))
                  (currentX (lambda () (cond
                                ((eq? x #t) (cons (cons (currentSym) '()) '()))
                                ((eq? x #f) '())
                                (else (map (lambda (z) (cons (currentSym) z)) x)))
                            ))
                  (currentY (lambda () (cond
                               ((eq? y #t) '())
                               ((eq? y #f) '())
                               (else y)
                               )
                            ))
                 )
               (append (currentX) (currentY))
               )
             )
            #f
           )
      #t
      )
  )

;; Contract: lisRecursive (list originL) * number -> (list (list number))
;; Purpose: recursively get all possible list of squence with given length
;; Example: (lisRecursive '(1 2 3) 1) yields '((1) (2) (3))
;; Definition:
(define (lisRecursive originL length)
  (if (< length 0) #f
      (let (
            (seq
             (let ((currentL (subListRecursive originL 0 length)))
               (firstNonDecreasing currentL)
               )
             )
            )
        (if (eq? seq #f) (lisRecursive originL (- length 1)) seq)
        )
     )
  )

;; Contract: (list int) -> (list int)
;; Purpose: a list's non-decreasing sub list
;; Example: (lis_slow '(1 2 3 4 3 4 5)) should produce '(1 2 3 4 5)
;; Definition:
(define (lis_slow ls)
  (if
   (null? ls)
   '()
   (lisRecursive ls (length ls))
   )
  )

;; Contract: not-decrease? (list a) -> bool
;; Purpose: if a list is non-decreasing list
;; Example: (not-decrease? '(1 2 3 4 3 4 5)) should produce #f
;; Definition:
(define (not-decrease? lst)
  (if (< (length lst) 2) #t
      (and (<= (car lst) (cadr lst))
           (not-decrease? (cdr lst))
      )
  )
)

;; Contract: list-max (list int) * (list int) * int * int * int * int * int -> int * int
;; Purpose: helper function for lis_fast_helper, find the max in top n of a list
; for all s in str that less or equal than smax
; return the max value and the index of it
; initial index is 0
; initial max-value is 1
; initial max-index is index
;; Example: (list-max '(1 2 3 2 4 1 2) '() 0 0 1 1 -1) should produce (1 -1)
;; Definition:
(define (list-max str val index end-index max-str max-value max-index)
  (if (eq? index end-index)
      (list max-value max-index)
      (if (and (<= (list-ref str index) max-str) (> (+ (list-ref val index) 1) max-value))
          (list-max str val (+ index 1) end-index max-str (+ (list-ref val index) 1) index)
          (list-max str val (+ index 1) end-index max-str max-value max-index)
      )
  )
)

;; Contract: (list int) * int * int * (list int) * (list int) * int * int -> (list int) * int
;; Purpose: helper function for lis_fast, using dynamic programming
; str is the list
; initial index is 0
; val-acc: store the length
; loc-acc: store the index of the result
; max-value: the value of the max
; max-index the index of the max
; next value: (car result)
; next loc: (cadr result)
;; Example (lis_fast_helper (1 2 3 2 4 1 2) 0 () () 0 -1) should produce ((-1 0 1 1 2 0 3) 4)
;; Definition:
(define (lis_fast_helper str index val-acc loc-acc max-value max-index)
  (if (eq? index (length str)) (list loc-acc max-index)
   (let ((result (list-max str val-acc 0 index (list-ref str index) 1 -1)))
     (lis_fast_helper str (+ index 1) (append val-acc (list (car result))) (append loc-acc (list (cadr result)))
                      (max (car result) max-value) (if (> (car result) max-value) index max-index))
   )
  )
)

;; Contract: (list int) * (list int) * int -> (list int)
;; Purpose: get result from str, loc-acc and index
;; Example (get-result (1 2 3 2 4 1 2) (-1 0 1 1 2 0 3) 4) should produce (1 2 3 4)
;; Definition:
(define (get-result str loc-acc index)
  (if (equal? index -1)
      '()
      (cons (list-ref str index)
            (get-result str loc-acc (list-ref loc-acc index)))
  )
)

;; Contract: (list int) -> (list int)
;; Purpose: a list's non-decreasing sub list
;; Example: (lis_fast '(1 2 3 4 3 4 5)) should produce '(1 2 3 4 5)
;; Definition:
(define (lis_fast str) '()
 (let ((result (lis_fast_helper str 0 '() '() 0 -1)))
    (reverse (get-result str (car result) (cadr result)))
 )
)
