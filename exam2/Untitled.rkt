(define (fun lis)
  (cond ((null? lis) lis)
        ((null? (cdr lis)) lis)
        ((equal? (car lis) (car (cdr lis))) (fun (cdr lis)))
        (else (cons (car lis) (fun (cdr lis))))))

(define (fun_tail lis total)
  (cond ((null? lis) total)
        ((null? (cdr lis)) (cons (car lis) total))
        ((equal? (car lis) (car (cdr lis))) (fun_tail (cdr lis) total))
        (else (fun_tail (cdr lis) (cons (car lis) total)))))

(define (fun_start lis)
  (reverse (fun_tail lis '())))

(fun '(1 3 3 4 1))
(fun_start '(1 2 1 2))

(define (atom? a)
  (not (pair? a)))
(define (foldr op lis id)
  (if (null? lis) id
      (op (car lis) (foldr op(cdr lis) id)) ))
(define (min-nest lis)
  (if (atom? lis)
      0
      (+ 1 (foldr min (map min-nest lis) 101) )
      )
  )

(min-nest '(1 ((2) (3))))
(min-nest '((((((8)) 9)) (a))))