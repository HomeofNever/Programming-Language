% Facebook Hacker Cup 2013: Balanced Smileys

balanced([]).
balanced([':', ')']).
balanced([':', '(']).
balanced([A|X]) :- member(A, ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', ' ', ':']), balanced(X), !.
balanced(['('|A]) :- append(B, [')'], A), balanced(B).
balanced(A) :- append(X, Y, A), not(X = []), not(Y = []), balanced(X), balanced(Y).

% Sample Query
% true
% balanced(['a', 'b', ' ']).
% balanced(['s', ' ', ':', ')', ':', '(']).
% balanced(['h', 'p', ':', ' ', ':', ')', ':', ')']).
% balanced(['(', ':', ')']).
% false
% balanced(['(', '(']).