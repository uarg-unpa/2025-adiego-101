ocurrencia([], _, 0).
ocurrencia([C|Xs], C, N) :- ocurrencia(Xs, C, N1), N is N1+1.
ocurrencia([Y|Xs], C, N) :- Y \= C, ocurrencia(Xs, C, N).
% ?- ocurrencia([a,b,a,a,c], a, 3).  % true
