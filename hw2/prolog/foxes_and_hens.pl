% Rules
% # of fox < # of hen or # of hen is 0
% it applied to both side
shouldLargerThan0(F, H) :- F >= 0, H >= 0, F =< 3, H =< 3.
isValidLeft(LF, LH) :- LF =< LH.
isValidLeft(_, LH) :- LH is 0.
right(LF, LH, A, B) :- A is 3 - LF, B is 3 - LH.
isValidRight(LF, LH) :- right(LF, LH, A, B), A =< B.
isValidRight(LF, LH) :- right(LF, LH, _, B), B is 0.

% Once is it valid, stop backtrace to aviod same result.
isValid(LF, LH) :- shouldLargerThan0(LF, LH), isValidLeft(LF, LH), isValidRight(LF, LH), !.

% Change boot side and number
transport(0, Num, R, NB) :- R is Num * -1, NB = 1.
transport(1, Num, R, NB) :- R is Num * 1, NB = 0.
% Move 2 animal
move([LF, LH, LB],[NF, NH, NB]) :- 
    transport(LB, 1, R, NB), NF is LF - R, NH is LH - R, isValid(NF, NH).
move([LF, LH, LB], [NF, NH, NB]) :- 
    transport(LB, 2, R, NB), NF is LF - R, NH is LH, isValid(NF, NH).
move([LF, LH, LB], [NF, NH, NB]) :- 
    transport(LB, 2, R, NB), NF is LF, NH is LH - R, isValid(NF, NH).
% Move 1 animal 
move([LF, LH, LB], [NF, NH, NB]) :- 
    transport(LB, 1, R, NB), NF is LF - R, NH is LH, isValid(NF, NH).
move([LF, LH, LB], [NF, NH, NB]) :- 
    transport(LB, 1, R, NB), NF is LF, NH is LH - R, isValid(NF, NH).

% Entry
left(X, P) :- [A|_] = X, not(goal(A)), move(A, B), not(member(B, X)), left([B|X], P).
left(X, P) :- [A|_] = X, goal(A), P = X.

goal([3, 3, 1]).

solve(P) :- left([[0, 0, 0]], P).