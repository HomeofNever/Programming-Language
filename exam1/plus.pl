insertPlus([A|B], R) :- insertPlus(B, R1), R is R1 + A.
insertPlus([A|[]], A).

betweenList(0, _, _, []).
betweenList(N, L, U, [H|R]) :- N > 0, between(L, U, H), M is N - 1, betweenList(M, L, U, R).
