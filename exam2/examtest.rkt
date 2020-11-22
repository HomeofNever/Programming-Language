;;length of lis
(define (len a)
  (if (null? a) 0 (+ 1 (len (cdr a)))))

;;high order function
(define (f g x)(g x))
(f number? 0)
(f len '(1 2))
(f (lambda (x) (* 2 x)) 3)

;;map
(define (mymap f l)
  (if (null? l) '()
      (cons (f (car l)) (mymap f (cdr l)) )))

(mymap abs '(-1 2 -3 -4))
(mymap (lambda (x) (+ 1 x)) '(1 2 3))
(mymap (lambda (x) (abs x)) '(-1 2 -3))

;;use map to count atom
(define (atomcount2 s)
  (cond ((atom? s) 1)
        (else (apply + (map atomcount2 s)))))

(define (atom? a)
  (not (pair? a)))

(atomcount2 '(1 2 3))
(atom? '())

;;use map to flatten
(define (flatten2 s)
  (cond ((null? s) '())
        ((atom? s) (cons s '()))
        (else (apply append(map flatten2 s)))))

(flatten2 '(a ((b) c) d e))

;;foldr
(define (foldr op lis id)
  (if (null? lis) id
      (op(car lis) (foldr op(cdr lis) id)) ))
(foldr + '(10 20 30) 0);; 10 + (20 + (30 + 0)) = 60
(foldr - '(10 20 30) 0);; 10 - (20 - (30 - 0)) = 20
(foldr append '((1 2)(3 4)) '());; (1 2 3 4)
(define (len2 lis) (foldr (lambda (x y)(+ 1 y)) lis 0))
(len2 '(1 2 3))

;;foldl
(define (foldl op lis id)
  (if (null? lis) id
      (foldl op(cdr lis)(op id (car lis)))))
(foldl + '(1 2 3) 0)

;;reverse
(define (rev lis)(foldl(lambda (x y) (cons y x)) lis '()))

;; let, let*, letrec
(let ((x 2))(* x x))
(let ((x 2))(let((y 1))(+ x y)))
(let* ((x 10) (y (* 2 x))) (* x y)) 
(let* ((x 10)(y(* 2 x)))(* x y))