belongs(A, A) :- !.
belongs(tree(X, _), Z) :- belongs(X, Z).
belongs(tree(_, Y), Z) :- belongs(Y, Z).


myLevel(tree(A, B), T, L, CL) :- tree(_, _) = A, X is CL + 1, myLevel(A, T, L, X).
myLevel(tree(A, B), T, L, CL) :- tree(_, _) = B, X is CL + 1, myLevel(B, T, L, X).
myLevel(tree(A, _), A, L, CL) :- L is CL + 1.
myLevel(tree(_, B), B, L, CL) :- L is CL + 1.
myLevel(A, A, CL, CL).
level(X, T, L) :- myLevel(X, T, L, 0).

