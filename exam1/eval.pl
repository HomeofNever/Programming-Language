or(1,1,1) :- !. % Avoid Duplicate
or(A, B, R) :- R is A + B.
and(A, B, R) :- R is A * B.

eval([0], 0).
eval([1], 1).
eval([and|A], V) :- append(X, Y, A), eval(X, N), eval(Y, M), and(N, M, V).
eval([or|A], V) :- append(X, Y, A), eval(X, N), eval(Y, M), or(N, M, V).
