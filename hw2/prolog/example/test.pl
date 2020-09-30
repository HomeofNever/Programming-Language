keepNon([term(_, _)|N], X) :- keepNon(N, X).
keepNon([non(X, Y)|N], [non(X, Y)|R]) :- keepNon(N, R).
keepNon([], _).