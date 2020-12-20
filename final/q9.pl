shouldBeUnique([], [], []).
shouldBeUnique([H|AT], [], RealResult):- shouldBeUnique(AT, [H], RealResult).
shouldBeUnique([H|AT], Result, RealResult):- Result = [H|_], shouldBeUnique(AT, Result, RealResult).
shouldBeUnique([H|AT], Result, RealResult):- Result = [RH|_], not(RH is H), shouldBeUnique(AT, [H|Result], RealResult).
shouldBeUnique([], Result, RealResult):- RealResult = Result.

unique(A, Result):- shouldBeUnique(A, [], ResultR), reverse(ResultR, Result).