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
(define (lis_slow ls)
  (if
   (null? ls)
   '()
   (lisRecursive ls (length ls))
   )
  )

;; n^2 solution
(define (lis_fast_find_all originL index currentL)
  (if (< index (length originL))
      (if (null? currentL)
          (lis_fast_find_all originL (+ index 1) (cons (list-ref originL index) '()))
          (let* (
                (prev (car (reverse currentL)))
                (next (list-ref originL index))
                (nextIndex (+ index 1))
                )
            (if (<= prev next)
                (let (
                      (accept (lis_fast_find_all originL nextIndex (append currentL (cons next '()))))
                      (drop (lis_fast_find_all originL nextIndex currentL))
                      )
                (lis_fast_find_all originL nextIndex currentL)
                )
            )
          )
      currentL
      )
  )
                
         
  

(define (lis_fast_recursive originL index currentL)
  (if (< index (length originL))
      (let (
            (calculatedLS (lis_fast_find_all originL index '()))
            )
        (if (< (length currentL) (length calculatedLS))
            (lis_fast_recursive originL (+ index 1) calculatedLS)
            (lis_fast_recursive originL (+ index 1) currentL)
            )
        )
      currentL)
  )
        
 
          
(define (lis_fast ls)
  (if (null? ls) '()
      (lis_fast_recursive ls 0 '())
      )
  )
  


;; Test Case
;(define list1 '(1 2 3 2 4 1 2))
;(define list2 '(2 4 3 1 2 1))
;(lis_slow list1)
;(lis_slow list2)
;(lis_fast list1)
;(lis_fast list2)
;(subListRecursive list1 0 7)
;(firstNonDecreasing '((1 2 3 2 4 1 2)))