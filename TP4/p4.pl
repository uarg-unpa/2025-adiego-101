%%Realizar un programa recursivo que en base a un número imprima por pantalla un triángulo.
%%Por ejemplo si el número es 3 debería imprimir:

scaloneta(N) :- contador(N,1), !.

contador(N,M) :- 
    N=:=M,
    triangulo(M), 
    !.

contador(N,M) :- 
    N > M,
    M1 is M + 1, 
    triangulo(M),
    nl,
    contador(N,M1).

triangulo(0) :- !.

triangulo(N) :- write('*'), N1 is N - 1, triangulo(N1).

