nums(H,H,[H]).
nums(L,H,[L|R]):-L<H, N is L+1, nums(N,H,R).
%%% nums generates a list of integers between two other numbers, 
%%% L,H by putting the first number at the front of the list returned by a recursive call with a number 1 greater than the first.  
%%% It only works when the first argument is bound to an integer. It stops when it gets to the higher number

ranks(L) :- queen_no(N), nums(1,N,L).
files(L) :- queen_no(N), nums(1,N,L).
%%% ranks and files generate the x and y axes of the chess board. 
%%% Both are lists of numbers up to the number of queens; that is, ranks(L) binds L to the list [1,2,3,...,#queens].

rank(R) :- ranks(L), member(R,L).
%%% R is a rank on the board; selects a particular rank R from the list of all ranks L.
file(F) :- files(L), member(F,L).
%%% F is a file on the board; selects a particular file F from the list of all files L.


%%% Squares on the board are (rank,file) coordinates.  
%%% attacks decides if a queen on the square at rank R1, file F1 attacks the square at rank R2, file F2 or vice versa. 
%%% A queen attacks every square on the same rank, the same file, or the same diagonal.
attacks((R,_),(R,_)).
attacks((_,F),(_,F)). % a Prolog tuple
attacks((R1,F1),(R2,F2)) :- diagonal((R1,F1),(R2,F2)).
%%% can decompose a Prolog tuple by unification(X,Y)=(1,2) results in X=1,Y=2; 
%%% tuples have fixed size and there is not head-tail type construct for tuples

%%% Two squares are on the same diagonal if the slope of the line between them is 1 or -1.  
%%% Since / is used, real number values for 1 and -1 are needed.
diagonal((X,Y),(X,Y)). % degenerate case
diagonal((X1,Y1),(X2,Y2)) :- N is Y2-Y1, D is X2-X1, Q is N/D, Q is 1 . % diagonal needsbound arguments!
diagonal((X1,Y1),(X2,Y2)) :- N is Y2-Y1, D is X2-X1, Q is N/D, Q is -1 . %%% because of use of “is”, diagonal is NOT invertible.

%%% placement can be used as a generator.  
%%% If placement is called with a free variable, it will construct every possible list of squares on a chess board.
%%% The first predicate will allow it to establish the empty list as a list of squares on the board. 
%%% The second predicate will allow it to add any (R,F) pair onto the front of a list of squares if R is a rank of the board and F is a file of the board.
%%% placement first generates all 1 element lists, then all 2 element lists, etc.  
%%% Switching the order of predicates in the second clause will cause it to try varying the length of the list before it varies the squares added to the list
placement([]).
placement([(R,F)|P]) :- placement(P), rank(R), file(F).


%%% these two routines check the placement of the next queen
%%% Checks a list of squares to see that no queen on any of them would attack any other. 
%%% does by checking that position j doesn’t conflict with positions (j+1),(j+2) etc.
ok_place([]).
ok_place([(R,F)|P]) :- no_attacks((R,F),P), ok_place(P).

%%% Checks that a queen at square (R,F) doesn't attack any square (rank,file pair) in list L; 
%%% uses attacks predicate defined previously
no_attacks(_,[]).
no_attacks((R,F),[(R2,F2)|P]) :- not(attacks((R,F),(R2,F2))), no_attacks((R,F),P).

%%% This solution works by generating every list of squares, 
%%% such that the length of the list is the same as the number of queens, 
%%% and then checks every list generated to see if it represents a valid placementof queens to solve the N queens problem;assume list length function
queens(P) :- queen_no(N), length(P,N), placement(P), ok_place(P). % Length is to validate queen_no
queen_no(4).  %%% The number of queens/size of board -use 4