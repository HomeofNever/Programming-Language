(define (shouldBeUnique lis res)
  (cond ((null? lis) res)
        ((eq? (length res) 0) (shouldBeUnique (cdr lis) (cons (car lis) res)))
        ((eq? (car lis) (car res)) (shouldBeUnique (cdr lis) res))
        (else (shouldBeUnique (cdr lis) (cons (car lis) res)))
        )
  )

(define (unique lis)
  (reverse (shouldBeUnique lis '()))
  )

(unique '(1 1 2 2))