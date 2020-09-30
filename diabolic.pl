diabolic([1, 8, 10, 15, 14, 11, 5, 4, 7, 2, 16, 9, 12, 13, 3, 6]).
write_all() :- write("L = [1, 8, 10, 15, 14, 11, 5, 4, 7, 2, 16, 9, 12, 13, 3, 6]").
magicConstant(B, C, D, E) :- 
diabolic([_|L]) :- [A|M] = L, [B|N] = M, [C|O] = N, [D|_] = O, .