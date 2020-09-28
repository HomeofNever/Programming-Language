takes(jane, his).
takes(jane, cs).
takes(ajit, art).
takes(ajit, cs).
classmates(X,Y) :-takes(X,Z),takes(Y,Z), not(X = Y).
