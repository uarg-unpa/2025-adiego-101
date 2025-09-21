% Caso base: si N es un solo dígito, la suma es N.
suma_digitos(N, N) :-
    N < 10,!.

% Caso recursivo: descomponemos el número en el último dígito y el resto.
suma_digitos(N, S) :-
    N >= 10,
    Digito is N mod 10,
    Resto is N // 10,
    suma_digitos(Resto, S1),
    S is S1 + Digito.