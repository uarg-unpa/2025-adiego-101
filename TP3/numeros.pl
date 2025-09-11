aleatorio():- numeros(1).
numeros(10).
numeros(C):-C<10, C1 is C+1, X is random(10), write(X), nl,numeros(C1).