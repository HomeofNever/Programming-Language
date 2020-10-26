;; Helpers
(define (isNonDecreasing? ls prev)
  (cond
    ((null? ls) #t)
    ((null? prev) (isNonDecreasing? (cdr ls) (car ls)))
    ((>= (car ls) prev) (isNonDecreasing? (cdr ls) (car ls)))
    (else #f)
    )
  )

(define (firstNonDecreasing ls)
  (cond ((null? ls) #f)
        ((isNonDecreasing? (car ls) '()) (car ls))
        (else (firstNonDecreasing (cdr ls)))
        )
  )
        

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

;; Starter
(define (lis ls)
  (lisRecursive ls (length ls))
)


;; Test Case
(define list1 '(1 2 3 2 4 1 2))
(define list2 '(2 4 3 1 2 1))
(lis list1)
;(lis list2)
;(subListRecursive list1 0 7)
;(firstNonDecreasing '((1 2 3 2 4 1 2)))