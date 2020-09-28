shouldLargerThan0(F, H) :- F >= 0, H >= 0, F =< 3, H =< 3.
isValidLeft(LF, LH) :- LF =< LH.
isValidLeft(_, LH) :- LH is 0.
right(LF, LH, A, B) :- A is 3 - LF, B is 3 - LH.
isValidRight(LF, LH) :- right(LF, LH, A, B), A =< B.
isValidRight(LF, LH) :- right(LF, LH, _, B), B is 0.

isValid(LF, LH) :- shouldLargerThan0(LF, LH), isValidLeft(LF, LH), isValidRight(LF, LH).

goal([0, 0, 0]).

%
move([LF, LH, 0],[NF, NH, NB]) :- 
    NF is LF + 1, NH is LH + 1, isValid(NF, NH), NB is 1.
move([LF, LH, 0], [NF, NH, NB]) :- 
    NF is LF + 2, NH is LH, isValid(NF, NH), NB is 1.
move([LF, LH, 0], [NF, NH, NB]) :- 
    NF is LF, NH is LH + 2, isValid(NF, NH), NB is 1.
%
move([LF, LH, 1],[NF, NH, NB]) :- 
    NF is LF - 1, NH is LH - 1, isValid(NF, NH), NB is 0.
move([LF, LH, 1], [NF, NH, NB]) :- 
    NF is LF - 2, NH is LH, isValid(NF, NH), NB is 0.
move([LF, LH, 1], [NF, NH, NB]) :- 
    NF is LF, NH is LH - 2, isValid(NF, NH), NB is 0.
%
move([LF, LH, 0], [NF, NH, NB]) :- 
    NF is LF + 1, NH is LH, isValid(NF, NH), NB is 1.
move([LF, LH, 0], [NF, NH, NB]) :- 
    NF is LF, NH is LH + 1, isValid(NF, NH), NB is 1.
%
move([LF, LH, 1], [NF, NH, NB]) :- 
    NF is LF - 1, NH is LH, isValid(NF, NH), NB is 0.
move([LF, LH, 1], [NF, NH, NB]) :- 
    NF is LF, NH is LH + 1, isValid(NF, NH), NB is 0.

repeat(A, L) :- not(member(A, L)), X = [A | L], left(A, X).
left(A, L) :- not(goal(A)), move(A, B), repeat(B, L).

left(A, P) :- goal(A).

solve(P) :- P = [[3, 3, 1]], left([3, 3, 1], P).
