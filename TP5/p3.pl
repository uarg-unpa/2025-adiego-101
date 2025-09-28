primeros(0,_,[]).
primeros(_,[],[]).
primeros(N,[X|Xs],[X|R]) :- N>0, N1 is N-1, primeros(N1,Xs,R).
