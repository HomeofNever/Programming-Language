write_all() :- allDiabolic.
diabolic(L) :- solveDiabolic(L, [[1, 8, 10, 15, 14, 11, 5, 4, 7, 2, 16, 9, 12, 13, 3, 6]], []).

diabolicReflection(
    [
        A, B, C, D, 
        E, F, G, H, 
        I, J, K, L, 
        M, N, O, P
     ], [
        D, C, B, A,
        H, G, F, E,
        L, K, J, I,
        P, O, N, M 
     ]
).
diabolicRotationAboutCenter(
    [
        A, B, C, D, 
        E, F, G, H, 
        I, J, K, L, 
        M, N, O, P
    ], [
        M, I, E, A,
        N, J, F, B,
        O, K, G, C,
        P, L, H, D
    ]
).
diabolicRotateofColumn(
    [
        A, B, C, D, 
        E, F, G, H, 
        I, J, K, L, 
        M, N, O, P
    ], [
        D, A, B, C,
        H, E, F, G,
        L, I, J, K,
        P, M, N, O
     ]
).
diabolicRotateofRow(
    [
        A, B, C, D, 
        E, F, G, H, 
        I, J, K, L, 
        M, N, O, P
    ], [
        E, F, G, H, 
        I, J, K, L, 
        M, N, O, P,
        A, B, C, D
     ]
).
diabolicComplexConvolution(
    [
        A, B, C, D, 
        E, F, G, H, 
        I, J, K, L, 
        M, N, O, P
    ], [
        A, D, H, E,
        B, C, G, F,
        N, O, K, J,
        M, P, L, I
     ]
).

solveDiabolic(L, [S|Stack], All) :- 
    not(member(S, All)), 
    diabolicReflection(S, A), diabolicRotationAboutCenter(S, B), diabolicRotateofColumn(S, C), diabolicRotateofRow(S, D), diabolicComplexConvolution(S, E), 
    append(Stack, [A, B, C, D, E], Next),
    solveDiabolic(L, Next, [S|All]).
solveDiabolic(L, [S|Stack], All) :- member(S, All), solveDiabolic(L, Stack, All).
solveDiabolic(L, [], All) :- member(L, All).

allDiabolic() :- findall(L, diabolic(L), All), open('solution_diabolic_test3.txt',write,Out), writeDiabolic(All, Out), close(Out).
writeDiabolic([C|N], Out) :- writeDiabolic(N, Out), write(Out, "L = "), write(Out, C), nl(Out).
writeDiabolic([], _) :- !.

