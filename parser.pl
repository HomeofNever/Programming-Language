% Grammar 
% =======
% Nonterminals expr, term, term_tail and factor_tail are encoded as
% non(e,_), non(t,_), non(tt,_) and non(ft,_), respectively. 
% Special nonterminal start is encoded as non(s,_).
% Terminals num, -, and * are encoded as 
% term(num,_), term(minus,_) and term(times,_). 
% Special terminal term(eps,_) denotes the epsilon symbol.
% 
% Productions are represented as prod(N,[H|T]) where N is the unique
% index of the production, H is the left-hand-side, and T is the 
% right-hand-side. 

prod(0,[non(s,_),non(e,_)]).
prod(1,[non(e,_),non(t,_),non(tt,_)]). 
prod(2,[non(tt,_),term(minus,_),non(t,_),non(tt,_)]).
prod(3,[non(tt,_),term(eps,_)]).
prod(4,[non(t,_),term(num,_),non(ft,_)]).
prod(5,[non(ft,_),term(times,_),term(num,_),non(ft,_)]).
prod(6,[non(ft,_),term(eps,_)]).


% LL(1) parsing table
% ===================
% E.g., predict(non(s,_),term(num,_),0) stands for "on start and num, 
% predict production 0. start -> expr".


% YOUR CODE HERE. 
% Complete the LL(1) parsing table for the above grammar.
predict(non(s,_),term(num,_),0).
predict(non(e,_),term(num,_),1).
predict(non(tt,_),term(minus,_),2).
predict(non(tt,_),term(end,_),3).
predict(non(t,_),term(num,_),4).
predict(non(ft,_),term(times,_),5).
predict(non(ft,_),term(minus,_),6).
predict(non(ft,_),term(end,_),6).


% Sample inputs
% =============
input0([3,-,5]).
input1([3,-,5,*,7,-,18]).


% Transform
% ========
% Transform translates a token stream into the generic representation, 
% including the special end-of-input-marker. E.g., [3,-,5] translates 
% into [term(num,3),term(minus,_),term(num,5),term(end,_)].

% YOUR CODE HERE.
% Write transform(L,R): it takes input list L and transforms it into a
% list where terminals are represented with term(...). The transformed 
% list will be computed in unbound variable R.
% E.g., transform([3,-,5],R).
% R = [term(num,3),term(minus,_),term(num,5),term(end,_)]
isTerm(-, R) :- R = term(minus, _), !.
isTerm(*, R) :- R = term(times, _), !.
isTerm(X, R) :- R = term(num, X).
transform([], E) :- E = [term(end, _)].
transform([A|B], [C|R]) :- isTerm(A, C), transform(B, R).

% parseLL
% =======
% YOUR CODE HERE.
% Write parseLL(R,ProdSeq): it takes a transformed list R and produces 
% the production sequence the predictive parser applies.
% E.g., transform([3,-,5],R),parseLL(R,ProdSeq).
% ProdSeq = [0, 1, 4, 6, 2, 4, 6, 3].
parseLL(R, ProdSeq) :- parse([non(s,_)], R, ProdSeq).

parse([F|R], E, [S|ProdSeq]) :- 
    [A|_] = E, predict(F, A, P), prod(P, [_|RHS]), append(RHS, R, N), parse(N, E, ProdSeq), S = P, !.
parse([F|R], [N|E], P) :- 
    F = N, parse(R, E, P).
parse([term(num,_)|R], [term(num,_)|E], P) :- 
    parse(R, E, P).
parse([term(eps,_)|R], E, P) :- 
    parse(R, E, P). 
parse(_, [term(end,_)], []).

% parseAndSolve
% =============
% YOUR CODE HERE.
% Write parseAndSolve, which augments parseLL with computation. 
% E.g., transform([3,-,5],R),parseAndSolve(R,ProdSeq,V).
% ProdSeq = [0, 1, 4, 6, 2, 4, 6, 3],
% V = -2.
parseAndSolve(R, ProdSeq, V) :- parseLL(R, ProdSeq), solve(R, ProdSeq, V).

% Attributes
attribute(0,[non(s,Vs),non(e,Ve)]) :- Vs = Ve.
attribute(1,[non(e,Ve),non(t,Vt),non(tt,Vtt)]) :- Ve is Vt - Vtt. 
attribute(2,[non(tt,Vtto),term(minus,_),non(t,Vt),non(tt,Vtt)]) :- Vtto is Vt + Vtt.
attribute(3,[non(tt,Vtt),term(eps,_)]) :- Vtt is 0.
attribute(4,[non(t,Vt),term(num,Num),non(ft,Ft)]) :- Vt is Num * Ft.
attribute(5,[non(ft,Vfto),term(times,_),term(num,Num),non(ft,_)]) :- Vfto is Num.
attribute(6,[non(ft,Vft),term(eps,_)]) :- Vft is 1.

% Set each of the terms 
applyTerm([term(X,Y)|R], [term(X,Y)|E], P) :- applyTerm(R, E, P).
applyTerm(R, [term(_,Y)|E], P) :- [term(T,_)|_] = R, not(T = Y), applyTerm(R, E, P).
applyTerm(R, [X|E], P) :- [F|_] = R, not(F = X), applyTerm(R, E, P).
applyTerm(R, [], P) :- P = R.

% Connects non-terminals between recursions
applyNon([non(X,Y)|R], [non(X,Y)|E], P) :- applyNon(R, E, P).
applyNon(R, [_|E], P) :- applyNon(R, E, P).
applyNon(R, [], P) :- P = R, !.

solve(R, ProdSeq, V) :- solveLL(R, ProdSeq, X), [non(_, V)|_] = X.
 
% Entry
solveLL(R, [N|ProdSeq], V) :- 
    prod(N, X), applyTerm(R, X, NR), solveLL(NR, ProdSeq, Next), applyNon(Next, X, NextRes), attribute(N, X), [A|_] = X, append([A], NextRes, V), !.
solveLL(_, [], []).


