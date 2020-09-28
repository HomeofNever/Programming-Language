left([A|P]) :- [X|B] = A, left([B|P]).
solve(P) :- left([[0, 0, 0]|P]).