p(a). p(b). p(c). p(d). p(e).
q(f). q(b). q(d).
r(b). r(d).

u(X) :- p(X), q(X), r(X).
v(X) :- p(X), !, q(X), r(X).
w(X) :- p(X), q(X), !, r(X).

